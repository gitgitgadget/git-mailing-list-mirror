From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 01/18] Introduce fsck options
Date: Mon, 22 Dec 2014 09:32:26 -0800
Message-ID: <xmqq61d3bnf9.fsf@gitster.dls.corp.google.com>
References: <cover.1418055173.git.johannes.schindelin@gmx.de>
	<56e9445d6e8a746356146bc565512f53bf8a0c8d.1418055173.git.johannes.schindelin@gmx.de>
	<xmqqk31zjz8o.fsf@gitster.dls.corp.google.com>
	<alpine.DEB.1.00.1412221822310.21312@s15462909.onlinehome-server.info>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Dec 22 18:32:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y36qT-000637-Nv
	for gcvg-git-2@plane.gmane.org; Mon, 22 Dec 2014 18:32:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932132AbaLVRcd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Dec 2014 12:32:33 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:64686 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755071AbaLVRcc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Dec 2014 12:32:32 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 0413328102;
	Mon, 22 Dec 2014 12:32:32 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=HYiz4/cH0t27O7ugij8SVXnwQT4=; b=oGDyCd
	T0tz2ScENTWhs74I9FxVnDRbVVhWyyrWTSmn9CDr+FQMZ1MQHpkeMrt3Sh6ufrYH
	W956xcbg9Mn53hcparN9b3b2DgtDcDFqbpSKxibfgh3YzhVoTSYYP/PaRWmOMqoH
	r6rWyp9NSOo9DC5tbmJazmp/Ahbd+GNCRWrhw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=OWlWSvap9du2wihLSySQbxWSn5MZbXPc
	P9UZOjy059KP5+C8BU5ePv6mOsKDYUBXze0rt3yVz4cZwUkVPN53B0X2wV7utAsJ
	GWg9iDz2QSHs+nlzn171kQWIkdW3C+YUU0QGBrdVVDgln7ISpS9nHpnaKBojypFP
	hloxcNfPb5M=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id EEDE928101;
	Mon, 22 Dec 2014 12:32:31 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 96258280FA;
	Mon, 22 Dec 2014 12:32:27 -0500 (EST)
In-Reply-To: <alpine.DEB.1.00.1412221822310.21312@s15462909.onlinehome-server.info>
	(Johannes Schindelin's message of "Mon, 22 Dec 2014 18:26:10 +0100
	(CET)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 7FC59FF0-8A00-11E4-9C2F-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261655>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> Is it a good idea to allow walker to be strict but obj verifier to
>> be not (or vice versa)?  I am wondering why this is not a single
>> struct with two callback function pointers.
>
> Unfortunately not. There are two different walkers used, and in fact,
> fsck_walk_options() is only used to walk the objects, not to fsck them.
>
> Now, I could use only one struct and set the walker, but that is not
> thread-safe, and while code is not threaded yet AFAICT, it might be in the
> future. That is why I decided to be rather safe than sorry. If you want it
> differently, please just say the word, I will make it so.

Thanks for explaining; I just found that the reason behind the
design choice was unclear and wanted to know.
