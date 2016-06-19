Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BD0C320189
	for <e@80x24.org>; Sun, 19 Jun 2016 18:08:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751335AbcFSSIs (ORCPT <rfc822;e@80x24.org>);
	Sun, 19 Jun 2016 14:08:48 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50479 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750768AbcFSSIr (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Jun 2016 14:08:47 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 99BD522E1D;
	Sun, 19 Jun 2016 14:07:33 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=YZ8I/Yx+1XPw/Pi+wxYwQJjH+Qo=; b=enRlLM
	yBy29egLB3Hzb+Tb78ENuRiEfxX3Jmh2JWExgZGKkKHj1u98HKOwZNrnTIZ7jg7N
	ZFjOuntmHN5n3f/fO31B1jwc/yGaGO0M8F2EncWHCRuXmhkniRAiCFDIoL0NjYSN
	br/eGW35dEK53cuaY8i2tJEC12dwA9n1OP3JQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=FacPrblCjdYa7m1YO8xlsrtIusTMd6dd
	zcfTRovqhbLytrMn2yTqzlfOghutA4LaNNWeLeZ4voy4nIEci7NLdNsW3fXu7Tfk
	F2NT5NHTDOPlc94kWWDwU7z780lA61eKo/5p57tV9F6CEX967GOueZ7tMYX1CioH
	V0siGcTI1jA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 924F522E1C;
	Sun, 19 Jun 2016 14:07:33 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 204F422E19;
	Sun, 19 Jun 2016 14:07:33 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Michael Haggerty <mhagger@alum.mit.edu>
Cc:	git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jun 2016, #05; Thu, 16)
References: <xmqqk2ho33ig.fsf@gitster.mtv.corp.google.com>
	<5764CBA8.5070303@alum.mit.edu>
	<xmqqziqixsti.fsf@gitster.mtv.corp.google.com>
	<57665497.3060100@alum.mit.edu>
Date:	Sun, 19 Jun 2016 11:07:31 -0700
In-Reply-To: <57665497.3060100@alum.mit.edu> (Michael Haggerty's message of
	"Sun, 19 Jun 2016 10:15:19 +0200")
Message-ID: <xmqqr3btvyqk.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B1E42704-3648-11E6-8EFC-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Michael Haggerty <mhagger@alum.mit.edu> writes:

>> Good timing. I was planning to kick split-under-lock and any of its
>> dependents temporarily out of 'next', so that fixes can choose not
>> to be incremental, and dependent topics can be rebased on top of the
>> fixed fondation.  Even if we do incremental, [4] is not sufficient
>> material for me to write a log message for.
>> 
>> So people who reviewed what has been in 'next' can revisit [4] and
>> give review comments, while I could just pick up the history
>> mentioned there, i.e.
>> 
>>     git checkout pu
>>     git pull git://github.com/mhagger/git +split-under-lock:mh/split-under-lock
>> 
>> and we can start from there?
>
> Sure. The branches in my GitHub fork already include all of the
> improvements and fixes that I know of, and the only outstanding issue is
> the one that Lars mentioned in this thread (which I believe to be a
> problem in git-p4).
>
> BTW, there are still no conflicts between these branches
> (split-under-lock, update-ref-errors, ref-iterators, and ref-store) and
> current master. Therefore, I don't see a need to rebase them onto
> master. But if you would prefer that I do so, just let me know.

If the updated split-under-lock itself can build on the same
upstream commit, then there is no reason to rebase it on top of v2.9
or anything newer.

Your other topics queued in my tree build on the version of
split-under-lock I have (e.g. mh/ref-store uses ref-iterators and
split-under-lock).  When split-under-lock gets updated, they need to
be rebuilt on top of the updated version, and that is what I meant
by "dependent topics can be rebased on top".
