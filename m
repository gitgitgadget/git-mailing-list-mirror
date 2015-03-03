From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git notes from incoming patch
Date: Tue, 03 Mar 2015 12:14:16 -0800
Message-ID: <xmqq4mq1bzzb.fsf@gitster.dls.corp.google.com>
References: <1425346358.13037.13.camel@intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>
To: "Keller\, Jacob E" <jacob.e.keller@intel.com>
X-From: git-owner@vger.kernel.org Tue Mar 03 21:14:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YStCy-0002mr-H8
	for gcvg-git-2@plane.gmane.org; Tue, 03 Mar 2015 21:14:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756012AbbCCUOU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Mar 2015 15:14:20 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:50889 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754217AbbCCUOT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Mar 2015 15:14:19 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id EA73E3D623;
	Tue,  3 Mar 2015 15:14:18 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=vFGwXt3ozCfnVgyzs5i+c6u/Lzg=; b=OEK3kZ
	jFnIv3gLdXzlCAoPjW64VXdUyCombBrkKnJ549NLGjENOLNPG/S98r4h1XUPCK5y
	zCOv4kGe94afJTudXXVg8oIbHB0XmO6ggtzfOqnh+m3/2t7jLP5nYTKPVlRdcap3
	Fk2VQowMoh+1tnzxMY5MlV9lfZGbeHEPX6LCk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=lWognTOZ6YsrhARLaD1qzho5pOiZk6+W
	VbNPrjuVlwhqXRf1V6qfBaIwJjnj2e9LifC8P957pAqmcY/1psWvAtmyQvyb7Kva
	0CY8pxjvdoU7eYFI8T7ozN1GWUXKVsCjFhGr9DgtdK/FMkXAR+sY5P/rSDa1hoiP
	XS3jHReGXDc=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E22863D622;
	Tue,  3 Mar 2015 15:14:18 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 465983D621;
	Tue,  3 Mar 2015 15:14:18 -0500 (EST)
In-Reply-To: <1425346358.13037.13.camel@intel.com> (Jacob E. Keller's message
	of "Tue, 3 Mar 2015 01:32:38 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: DF1E5B40-C1E1-11E4-A176-29999F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264679>

"Keller, Jacob E" <jacob.e.keller@intel.com> writes:

> I am wondering whether it is possible to read from a format-patch input
> and add notes when we generate the applied patch.

I would think post-applypatch hook is the right place to do this.
The hook has access to the incoming message in $GIT_DIR/rebase-apply
directory ('next' records the message number in the series, and then
you have individual pieces of e-mails separated out into 0001, 0002,
etc. you can read from), and "HEAD" already points at the result of
applying the patch.

Peek 'post-applypatch' on my 'todo' branch for inspirations.
