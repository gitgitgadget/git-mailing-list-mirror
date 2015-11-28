From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Is it possible to build `git` such that the install directory and the deployment prefix is not the same?
Date: Fri, 27 Nov 2015 23:54:59 -0800
Message-ID: <xmqqmvty8soc.fsf@gitster.mtv.corp.google.com>
References: <CAO8bsPDQ2BX1U0D9=pa99_nkEeRWzuN6QzsMw+2u0GPqO6M9kw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Henry Qin <root@hq6.me>
X-From: git-owner@vger.kernel.org Sat Nov 28 08:55:10 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a2aLe-0006fm-89
	for gcvg-git-2@plane.gmane.org; Sat, 28 Nov 2015 08:55:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751038AbbK1HzK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Nov 2015 02:55:10 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:64882 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750847AbbK1HzI (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Nov 2015 02:55:08 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 1C5BC1FFEC;
	Sat, 28 Nov 2015 02:55:02 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=8v9IGtDkVTrZEN5EBhqo23OpRvU=; b=wSdL7x
	Ib/8x8pb4U/X4+jYop449jrfJUviLA0vwyLi8VI0ekUJJg0C/9tUKAJ9wife19HN
	HaSXZJ0cJOgiDjH2Ro30x9z9dxOOZlFQoZwZ1H1zFNUk3II+bp5HZIY+70Aswyf3
	FQeDUilhfddzCAk6lOdCYG9qDeyKt4C7LTucY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Wj4GLDihixJGiNi1I2p/T/ZvtqqJNork
	ZN6kQ6tG7RBzVtZ26JQGLOXiHPXrEkjGZM/sjNIiWzAzVDJzC42AcOb4vajsiOwa
	mdu6VwdmgwJ32BpT3HXXY14cYyj9cY4ZWpma0n5P9fGDpgUjlABczpoNhAYSOyh6
	k8o7UUOSGgk=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 837FE1FFEA;
	Sat, 28 Nov 2015 02:55:01 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 69ADE1FFE9;
	Sat, 28 Nov 2015 02:55:00 -0500 (EST)
In-Reply-To: <CAO8bsPDQ2BX1U0D9=pa99_nkEeRWzuN6QzsMw+2u0GPqO6M9kw@mail.gmail.com>
	(Henry Qin's message of "Fri, 27 Nov 2015 23:19:01 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 53547728-95A5-11E5-826A-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281783>

Henry Qin <root@hq6.me> writes:

> Here is the question, copied below for your convenience:
>
> """
> I am attempting to build git from source, and I would like make
> install to put the binaries into a directory called dist in my source
> directory, so I use the following configure line.
>
> ./configure --prefix=`pwd`/dist

You probably want to use DESTDIR instead, e.g.

    $ make prefix=/usr/local DESTDIR=/var/tmp/dest

The standard way to phrase your question is "how do I 'make install'
to install to a fake location so that I can tar up the result into a
tarball?" (the key part being "so that..."), I think.
