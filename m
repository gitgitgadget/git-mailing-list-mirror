Return-Path: <SRS0=ku3G=DQ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BBBCC433E7
	for <git@archiver.kernel.org>; Fri,  9 Oct 2020 19:26:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E80D2227E
	for <git@archiver.kernel.org>; Fri,  9 Oct 2020 19:26:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="YkMjlnnP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388655AbgJIT04 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Oct 2020 15:26:56 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55354 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388639AbgJIT04 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Oct 2020 15:26:56 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 48CEB7218D;
        Fri,  9 Oct 2020 15:26:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=zQPkuF4GM2hvVko4SMUf3M7o5Bk=; b=YkMjlnnP/oqIPjjVhsaT
        jGfpJOKr8deTgcU5v33+o5/6flkIFZAjtDmfmc0Dfjlwn/XX8UeoSCqLyoO5NVmI
        hyHrSwWLytkVhlgzj4XTO3eH5CKVaQqPtmKNDndVw45jlAsKEX/QlDI1akMQqs1x
        n2hXYrxbu9uCZtbqXVG22Kc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         q=dns; s=sasl; b=xjXyFrG8Fwru/fD6BN56NolgriKr8ucWBh3EtfAOmGXU0I
        asPH8w0wKKIGrV+Fv71zxX6o4du6Ym7C92QWzTfIACuofFMrYcQcKCLUdnYNxQkk
        0QLWOdjyINz0+i3f/k9EihS8jY0ic9y3UFyc1ZVVwzNTM2lPDirUKmoTmrMNM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3F7F07218C;
        Fri,  9 Oct 2020 15:26:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9BA6A7218B;
        Fri,  9 Oct 2020 15:26:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] clean up extern decl of functions
References: <xmqq8scgzqis.fsf@gitster.c.googlers.com>
        <20201009015505.GB1314@generichostname>
        <xmqqtuv4uncn.fsf@gitster.c.googlers.com>
Date:   Fri, 09 Oct 2020 12:26:49 -0700
Message-ID: <xmqqy2kfryiu.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 615EF5FC-0A65-11EB-97A2-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

>> Why are we re-introducing an explicit "extern"? Since function decls are
>> extern by default, what do we gain by doing this?
>>
>> You mentioned in the past[0]
>>
>> 	I think there is a push to drop the "extern " from decls of
>> 	functions in *.h header files.
>>
>> so are we reversing that push now?
>
> That is certainly on the table.  Re-read what you quoted and realize
> that I was not expressing my opinion on the "push"; it was just
> stating that other reviewers seem to be in favor.
>
> See my other response why I think the "push"  was a bad idea.

I'd elaborate a bit more.  A proposed update to CodingGuidelines
will be sent separately as a follow-up to this message.

"Are we reversing that push now?"  That is not a question I can
unilaterally answer yes/no---I do not run dictatorship where I
cannot survive without telling all the contributors how to cross
their t's and dot their i's.  There are things in our coding
guidelines that tells me to do something differently from how I
would, but I can adjust and survive if the primary benefit of having
guidelines, i.e. making things uniform one way or the other, is net
win.  When a guideline turns out to be a bad idea, however, I can
propose to change it.  So can you or anybody else ;-)

In that message, I just told Emily that there is a push to omit
extern, in the sense that it was the opinion of the prevailing
louder voices.  Back then, I didn't have an opinion strong enough to
favor either way myself, and I was willing to go with the majority
if many contributors wanted to drop "extern" in the hope that it
will result in quality code.

But with the Makefile patch you posted with Dscho's review this
morning, it has become apparent to me that it wasn't a great idea
after all.  It caused you to spend your time to write the RFC patch
and come up with the regexp, and caused the project to spend
reviewer bandwidth on the patch.

Of course, how you spend your time is entirely up to you.  But if
you are going to contribute your time on this project, the project
appreciates if the time is spent on things that make the codebase
better.  And to me, unlike to me "in the past[0]", it is reasonably
clear that the push of omitting "extern" ended up wasting resources
without doing much good for the project.

Seeing that the pattern that were trying to be careful didn't catch
the decls fixed by the patch you were responding to in this thread
did not help improve my impression on the idea of omitting "extern".

I think these two decls I touched in this patch were left behind
when somebody, possibly you in b199d714 (*.[ch]: remove extern from
function declarations using sed, 2019-04-29), tried to "clean up"
the last time, because the pattern used in the conversion did not
catch it.
