From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 01/17] strbuf: make strbuf_getline_crlf() global
Date: Mon, 04 Jan 2016 11:17:50 -0800
Message-ID: <xmqqvb79nogx.fsf@gitster.mtv.corp.google.com>
References: <1446071161-15610-1-git-send-email-gitster@pobox.com>
	<1450303398-25900-1-git-send-email-gitster@pobox.com>
	<1450303398-25900-2-git-send-email-gitster@pobox.com>
	<alpine.DEB.2.20.1601041255110.14434@virtualbox>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Jan 04 20:17:58 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aGAdi-0001de-4O
	for gcvg-git-2@plane.gmane.org; Mon, 04 Jan 2016 20:17:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752012AbcADTRz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Jan 2016 14:17:55 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:65464 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751933AbcADTRx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Jan 2016 14:17:53 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 9B3E7369E0;
	Mon,  4 Jan 2016 14:17:52 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=CRYG46M5fmAnuECNQfDvrs/TE/U=; b=lz6Oc7
	bpg4qfIvGhPR02hXD2imcrNJVdTC09+Vxpy2mvN+OmZHH4T4c61I/YUPh5RCjhdT
	aAzRM6Ze6YoeAhuoKNFAAsayV6DhhVNEZxMHFXvbxUiK4U+0LB/cA52M15CHFuyv
	VTkDk4cpV0FXkkYoLgoCC5adLtN6zaTK44r5g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=uKBZ7RrlyqlgueftHgBOdPeSyA22esST
	1efwjezuy/CKXzXja1SmvuI8QPx3Y/BkMSSEoXpJJba4al8hyxfHcsczB+qwh7PW
	kT0NHhI6mx/FutNmEO9Pi04R7i58HQmrdkPB91KV9cvax/JZ3JFHzDIQh2Fpk5qu
	ORTV/4htEN4=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 929AD369DE;
	Mon,  4 Jan 2016 14:17:52 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 11275369DC;
	Mon,  4 Jan 2016 14:17:51 -0500 (EST)
In-Reply-To: <alpine.DEB.2.20.1601041255110.14434@virtualbox> (Johannes
	Schindelin's message of "Mon, 4 Jan 2016 13:25:35 +0100 (CET)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: D996ABC8-B317-11E5-8F79-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283317>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi Junio,
>
> On Wed, 16 Dec 2015, Junio C Hamano wrote:
>
>> Often we read "text" files that are supplied by the end user
>> (e.g. commit log message that was edited with $GIT_EDITOR upon
>> 'git commit -e'), and in some environments lines in a text file
>> are terminated with CRLF.  Existing strbuf_getline() knows to read
>> a single line and then strip the terminating byte from the result,
>> but it is handy to have a version that is more tailored for a "text"
>> input that takes both '\n' and '\r\n' as line terminator (aka
>> <newline> in POSIX lingo) and returns the body of the line after
>> stripping <newline>.
>> 
>> Recently reimplemented "git am" uses such a function implemented
>> privately; move it to strbuf.[ch] and make it available for others.
>
> ... While at it, we fix the formatting of the strbuf_getline() function.

Yeah right; I think it is obvious from the patch text, but while at
it, I'll amend the log message ;-)

Thanks.
