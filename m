From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] userdiff: add built-in pattern for CSS
Date: Tue, 24 May 2016 15:18:59 -0700
Message-ID: <xmqq37p73xrg.fsf@gitster.mtv.corp.google.com>
References: <20160520132829.7937-1-william.duclot@ensimag.grenoble-inp.fr>
	<20160524142537.19324-1-william.duclot@ensimag.grenoble-inp.fr>
	<xmqqmvnf46on.fsf@gitster.mtv.corp.google.com>
	<925654601.13199.1464127975010.JavaMail.zimbra@ensimag.grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org,
	simon rabourg <simon.rabourg@ensimag.grenoble-inp.fr>,
	francois beutin <francois.beutin@ensimag.grenoble-inp.fr>,
	antoine queru <antoine.queru@ensimag.grenoble-inp.fr>,
	Matthieu Moy <matthieu.moy@grenoble-inp.fr>
To: William Duclot <william.duclot@ensimag.grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed May 25 00:19:14 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b5KfR-000258-7x
	for gcvg-git-2@plane.gmane.org; Wed, 25 May 2016 00:19:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751581AbcEXWTF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 May 2016 18:19:05 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59714 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751497AbcEXWTE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 May 2016 18:19:04 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 86E7B1EBED;
	Tue, 24 May 2016 18:19:02 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Us+W0l8P6QMti+0GKtnj9r7nHoM=; b=RIwTTV
	X8tgeZVsndbEyI926me8S7h0iWOJzoI3mWcnbx2D6AI2DF6N4hapDLSQb9wgFrC6
	MCN6+ECrsrwSBRwVVs+le5Qb/O9TfxWegBRItRLBMMoxeHRlULlhYim9HFGe9quF
	shN8HV+puFixB67GO3rZBDhaUrzYeZT/D7Qvs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=q4tMPwBL50dpXuWBWuuD/d6WzgeH6ktM
	sljV1xm1d2EwTwSrrLhwI/mqBWXVLkLpVe/sDiqCErnM5g/SKLh/JvWKN3x7eT4x
	xNlp/FXEMlF3D6QPBCqDKPYzI8AUne6ogJE/8T8tc0wOaupRZW8Tom8+UZ3rjJay
	qHlDaKwE2kE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 7DB711EBEC;
	Tue, 24 May 2016 18:19:02 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id EE4881EBEB;
	Tue, 24 May 2016 18:19:01 -0400 (EDT)
In-Reply-To: <925654601.13199.1464127975010.JavaMail.zimbra@ensimag.grenoble-inp.fr>
	(William Duclot's message of "Wed, 25 May 2016 00:12:55 +0200 (CEST)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 84D6B786-21FD-11E6-AB3E-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295537>

William Duclot <william.duclot@ensimag.grenoble-inp.fr> writes:

> I did have considered IPATTERN(), but assumed that case-sensitive was
> default and case-insensitive was the exception.

Don't assume, but ask ;-)

> As the CSS pattern
> does not deal with letters at all it seemed sensible to me to follow
> the example of the HTML pattern, which use PATTERNS().

Did you notice that HTML pattern has to do an [Hh] that would be
unnecessary if it chose to use IPATTTERN()?

You do not have to ask a person, but instead ask the history.
IPATTERN() was added at 909a5494 (userdiff.c: add builtin fortran
regex patterns, 2010-09-10) when adding fortran support.  Anything
that existed before, including HTML, did [A-Za-z] when they could
have done [a-z] if IPATTERN() existed back then.

>>  - In our codebase, we format multi-line comments in a particular
>>    way, namely
>> 
>> 	   /*
>>          * A multi-line comment begins with slash asterisk
>>          * on its own line, and its closing asterisk slash
>>          * also is on its own line.
>>          */
>
> I take good note of that. I took example on the fortran pattern
> comment, should I fix it too while I'm at it?

Not "while you are at it".

Making existing things better is welcome but such a change shouldn't
be mixed with addition of new things.  You can do it as a separate
patch, probably as a preliminary clean-up before your change, if you
want to.

>>  - Try not to write overlong lines.  If your expression needs to
>>    become long and there is no good place to fold lines, that is one
>>    thing, but an overlong comment is unexcuable, as you can fold
>>    lines anywhere between words.
>
> Again, I take good note of that.
>
> Thank you for your time!

Thank you for working on this.
