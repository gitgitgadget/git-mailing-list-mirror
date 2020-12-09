Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A067C4361B
	for <git@archiver.kernel.org>; Wed,  9 Dec 2020 21:29:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F183239D1
	for <git@archiver.kernel.org>; Wed,  9 Dec 2020 21:29:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387993AbgLIV3c (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Dec 2020 16:29:32 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56957 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727369AbgLIV3c (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Dec 2020 16:29:32 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8C4279E866;
        Wed,  9 Dec 2020 16:28:49 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=fNSOLsyrpN9+av+a4j2yTQ5FUJ4=; b=DcRL4U
        gVG22aJLXQ5DSB1Bv7GDuMQbsjSz8FPMEcijP2IVJzaHuXASVabqfbNFHK0f80h5
        Mk53a9b1bRpq4+sGKozx6Sp4IDSPbsyYBJefQYUOOKZT5MQqXHHy7niDhQ0mrc95
        7f2Jp3aFU2jyj2Ujf2i6kLUuARUB6JOKJF/mY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=dy16NGVg/uApP6yuF4V75K+uYVAeK1lO
        O2ath/9H1D4zS4KWtP8qMZmbGcBg2za10o9DHS/LgmBpsggOty3ZSpFDfr8qLd8u
        bNHjcsGURC+2pQfvqdyjRuFABToBeqG+Yk5SF2dOitiwR9Lz/iwl+ODRvqTW6WFF
        dEIq8T6k6wo=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 83D279E865;
        Wed,  9 Dec 2020 16:28:49 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 11B479E864;
        Wed,  9 Dec 2020 16:28:49 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: fc/pull-merge-rebase, was Re: What's cooking in git.git (Dec
 2020, #01; Tue, 8)
References: <xmqqpn3j4ved.fsf@gitster.c.googlers.com>
        <nycvar.QRO.7.76.6.2012091502000.25979@tvgsbejvaqbjf.bet>
Date:   Wed, 09 Dec 2020 13:28:48 -0800
In-Reply-To: <nycvar.QRO.7.76.6.2012091502000.25979@tvgsbejvaqbjf.bet>
        (Johannes Schindelin's message of "Wed, 9 Dec 2020 15:09:03 +0100
        (CET)")
Message-ID: <xmqqk0tq1xf3.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 86B2CC7C-3A65-11EB-BFB0-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi Junio,
>
> On Tue, 8 Dec 2020, Junio C Hamano wrote:
>
>> * fc/pull-merge-rebase (2020-12-08) 19 commits
>>  - future: pull: enable ff-only mode by default
>>  - pull: advice of future changes
>>  - pull: add pull.mode=ff-only
>>  - pull: add pull.mode
>>  - pull: trivial memory fix
>>  - test: pull-options: revert unnecessary changes
>>  - test: merge-pull-config: trivial cleanup
>>  - pull: move configurations fetches
>>  - rebase: add REBASE_DEFAULT
>>  - pull: show warning with --ff
>>  - pull: introduce --merge option
>>  - pull: trivial whitespace style fix
>>  - pull: display default warning only when non-ff
>>  - pull: move default warning
>>  - pull: trivial cleanup
>>  - pull: cleanup autostash check
>>  - pull: refactor fast-forward check
>>  - pull: improve default warning
>>  - doc: pull: explain what is a fast-forward
>>
>>  When a user does not tell "git pull" to use rebase or merge, the
>>  command gives a loud message telling a user to choose between
>>  rebase or merge but creates a merge anyway, forcing users who would
>>  want to rebase to redo the operation.  Fix this by (1) tightening
>>  the condition to give the message---there is no reason to stop or
>>  force the user to choose between rebase or merge if the history
>>  fast-forwards, and (2) failing the operation when the history does
>>  not fast-forward, instead of making a merge, in such a case.
>
> Despite what the commit message of the tip commit says, it is not "time to
> flip the switch and make ff-only the default" because it breaks our very
> own test suite left and right. See for yourself:

With respect to what is in 'seen' that are not marked as "Will merge
to...", I am merely a messenger, and you are shooting one ;-).

I know of these breakages, becuase I've seen them before pushing the
integration results out.  The first-parent history near the tip of
'seen' looks like so:

    4a386f47a7 Merge branch 'fc/pull-merge-rebase' into seen
    e0b9615ea3 Merge branch 'es/config-hooks' into seen
    addabb0fb7 ### start breaking 5411,5520,4013,5524,6402,5604,...
    0ffeed16ab Merge branch 'sj/untracked-files-in-submodule-dir...

Notice the ### separator?  Everything above the line breaks 'seen'.
(Emily cc'ed---even though her config-hooks is not on topic of your
message, it is above the separator as the result of merging it to
'seen' breaks 5411).

The reason why I am experimenting with this is because I suspect
that those who are involved in the topics above the separator would
want them in 'seen', as it would be easier to work with, when the
breakage may be coming from interactions with other topics, to
pinpoint what interaction may be at fault.

But if you and others who are not involved in these topics above the
separator want to see 'seen' in a buildable/testable state by
excluding them, I am fine with that, too.  It is a hassle for me to
maintain the two parts of 'seen' the way I pushed out last night.  I
have to identify which merge of the topics into 'seen' breaks
builds/tests, shuffle the order of topics, minimizing the number of
topics above the breakage point, and tentatively rewind 'seen' to
below the breakage point when building and installing for my own
use, etc.  It would become unnecessary if I can just discard new
topics after seeing builds/tests break in 'seen'.

But that is a digression.

> Given that not even our very own test suite is well-suited to this change,
> I rather doubt that this is a safe thing to do.
>
> In the _least_, the patch series should put in the effort to show just how
> much work it is to adjust the test suite to let it pass again. This would
> also give an indication how much work we impose on our users by that
> ff-only change in behavior.

I do not doubt the need to make sure that the test suite covers the
new use case as well as the need to adjust the existing tests.

Having said that, I have a strong suspicion that the "turn the
current warn-but-go-ahead-to-merge into error-out-and-stop for those
who haven't chosen between rebase and merge when we see a non-ff
situation" this topic aims for *can* be made without causing as much
harm to existing users' workflows as these test failures imply.  The
reason why I say so is because the existing behaviour of loudly
warning is so annoying, even with the current behaviour of making a
merge after showing the warning, existing users would have made and
recorded the choice in pull.rebase long time ago already.  Those who
want to rebase by default would have had more incentive to avoid
the "warn but still go ahead to merge" doing a wrong thing to them,
but those who want to merge by default would also have set it, if
only to squelch the annoying loud warning.

A spot check: do you have pull.rebase set to anything in your
config?

So, if this "default change" is done in such a way so that it won't
make any difference to those who have pull.rebase set to either yes
or no, I suspect that the fallout would not be as bad as what these
test failures imply.

On the other hand, if the implementation in the topic forces
everybody (including those who have made the choice by setting
pull.rebase) to set another variable before allowing to work with a
non-ff pull, it would break everybody and is a disaster.

Thanks.


