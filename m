Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA8A8C433DB
	for <git@archiver.kernel.org>; Tue, 30 Mar 2021 13:40:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A1ECA619D0
	for <git@archiver.kernel.org>; Tue, 30 Mar 2021 13:40:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232154AbhC3NkV (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Mar 2021 09:40:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231701AbhC3NkT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Mar 2021 09:40:19 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83FC4C061574
        for <git@vger.kernel.org>; Tue, 30 Mar 2021 06:40:18 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id z1so18273592edb.8
        for <git@vger.kernel.org>; Tue, 30 Mar 2021 06:40:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=4ONCIU9kyygjknYTerh8O1b5mTaUkgGNA8wrYayZTuk=;
        b=K+9e/wVLui7AODQ3RFemaK/2irUbZQYsiQ9o54NwDhDcxm9IF5Mk7flCtZ6BGN1hmp
         P76QbXiBQ8VeZLHLaUUlMVUSoQR/welCyDPfX2yCkHZT8zEobYKbvClCBwXk9RIod12R
         WtlunYuPs6/hYiUabObA44FWZHbpqSNCVSwL1MTCXwTZDjt3R3xcc/tJlAnrJJup/c/8
         tLOt5RLP4Czk7mIIfMwsglk1Ddbe73lYoeUSM4SN1C4FB+Kdrk8ojgqHC+ov87L6LATz
         VKUgpkbSU8t3brEtCf2kBFlzS45GK01YdZrNm/GJM13den8z/18IiAbIRPMxXhf6b5mZ
         3/Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4ONCIU9kyygjknYTerh8O1b5mTaUkgGNA8wrYayZTuk=;
        b=awBxiVaOlkF9aBal6T0uC7DdFOb1g+tdwoylG4JKNL+mZkMMDQK/qNe6agXmJm4J0z
         MYCRVLW1udlwcnjveXi6k2j+fY68wpJml4Tf3GhvFlG8/ntTbF5D/RFu/1H+aB+Ook3O
         KlAWk8whL2FI4v+7rxiZ0tOfPFbtj72ZxO1Glpu2vG6Xe3u5IBjCZoHvfmEHx2UAQWXB
         ysFtF0700fA6RWa5906y2fersp9jdQSBmgu9r08fPp2etUZQGnkTAVe0TTcU/4U2OYyJ
         QnK+IJPv+sviQFdJW/t9h5tywOhK8RwzwHVgta6Y00uG3IDzfTmzFbT4otUoqkidGENq
         jRKQ==
X-Gm-Message-State: AOAM5315Ki+rnRoaOlEI7tQn89dXxkwZrFz4/TjzwDMxwPlsPCn0dVTk
        vv9YR0Pm9LISI1TC6oHYeIQ=
X-Google-Smtp-Source: ABdhPJyV8QMYwlzCwdrM2GaOBzeiY4eJZh+FXmyv08wdKhEJ9k7CAOtYtMIh5qS0i2gvKrmPU9b2sw==
X-Received: by 2002:aa7:d74b:: with SMTP id a11mr33565037eds.92.1617111616413;
        Tue, 30 Mar 2021 06:40:16 -0700 (PDT)
Received: from [192.168.1.201] (243.20.198.146.dyn.plus.net. [146.198.20.243])
        by smtp.googlemail.com with ESMTPSA id l18sm10104630ejk.86.2021.03.30.06.40.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Mar 2021 06:40:16 -0700 (PDT)
Subject: Re: [PATCH 0/3] rebase: don't override --no-reschedule-failed-exec
 with config
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
References: <873d1fda948855510b07f9cb75d374c03d60a94e.1544468695.git.gitgitgadget@gmail.com>
 <cover.1616411973.git.avarab@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <9c11c7cf-3a37-a07b-83c3-89c24195c359@gmail.com>
Date:   Tue, 30 Mar 2021 14:40:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <cover.1616411973.git.avarab@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Ævar

On 22/03/2021 11:48, Ævar Arnfjörð Bjarmason wrote:
> I recently started using rebase.rescheduleFailedExec=true and noticed
> this bug in its implementation. It's conceptually a relatively simple
> fix, but as noted in 3/3 rebase being a "start this operation, run
> other command verbs later" has an unintuitive interaction with our
> usual "command-line options override config".
> 
> !README FIRST!
> Everthing after this line has no relevance to this series, it's just a
> side musing on another (mis-)feature of --reschedule-failed-exec.
> !/README FIRST!
> 
> There's another bug/misfeature I've noticed with
> rebase.rescheduleFailedExec=true (although maybe it'll be argued by
> someone that it's a feature). Let's say you run:
> 
>      git rebase -x false --reschedule-failed-exec HEAD~2
> 
> You'll now land in a state of (according to our helpful PS1 code, but
> also the rebase state) of 2/4. Aside: Because you're rebasing 2
> commits, we have 4 because of the 2x exec. So far so good and all of
> that's expected.
> 
> But now when you do "git rebase --continue" we'll fail as expected,
> but not as expected (at least I find it funny) bump the count to 3/5,
> then 4/6, 5/7 etc.
> 
> With my "I just read the code" hat on this makes perfect sense. Every
> time we process a TODO item we bump the count of processed items, and
> under --reschedule-failed-exec we simply push the command that just
> failed onto the list, hence the increasing done/TODO count when a
> command fails.
> 
> But I don't see how it makes any sense to expose this as UI via "git
> status" and __git_ps1. I asked git to process this item of 4 sequencer
> TODO items. If I fail an item it makes more sense that I just don't
> get past it, not that under the hood a new identical item is
> rescheduled for me. Just don't advance past the current item!
> 
> Now if I've tried X times to make the "make test" pass for each commit
> in my 3-commit series I'm going to be on item 10/12 or
> whatever. There's no way to just look at that and see where I'm at in
> the sequence.
> 
> As an aside it would arguably make more sense to report 1/3 instead of
> 2/6 for the first commit of 3 with a failing -x "make test", but you
> can have X number of "exec" items and a manually edited list etc.

I think counting the number of picks rather than total commands is 
probably better especially now that we have reset and label commands as 
well. Grouping all the execs with the previous pick doesn't seem that 
unreasonable to me (though I should note that I don't use the prompt 
from git.git and my prompt prints the command that we've stopped at on a 
line above the prompt so it is easy for me to see where I am in the list).

> So that's probably a no-go but at least once I'm used to it I know if
> i'm on 4/6 I'm on commit 2/3, with --reschedule-failed-exec you'll
> have no idea what 12/14 or whatever means for where you are in your
> 3-patch sequence, it has no relation to the TODO list you edited, just
> rebase-merge's own internal state.
> 
> Getting back on topic: This just seems like needlessly exposing an
> implementation detail, I also asked to "pick" a commit, but if that
> item "fails" e.g. due to:
>      
>      $ git rebase --continue
>      You must edit all merge conflicts and then
>      mark them as resolved using git add
> 
> We don't push a new "pick" item on the list and inflate the count, so
> why would we do that for "exec"?

We do push a new pick if a pick/merge/reset fails because it would 
overwrite untracked files.

As an aside I wish I could skip a rescheduled pick or exec with 'git 
rebase --skip' rather than having to edit the todo list (skipping reset 
commands is a bad idea though)

> Just say the command failed, return
> its non-zero status from "git rebase --continue", and don't advance.
> 
> Maybe it is useful to keep track of the N number of failures, and
> e.g. report in __git_ps1:
> 
>      master|REBASE 2/6
>      master|REBASE 2(tries: 1)/6
>      master|REBASE 2(tries: 2)/6

Something like that would be nice but I think just not incrementing the 
count when we reschedule a command would be fine.

> Instead of the current:
> 
>      master|REBASE 2/6
>      master|REBASE 3/7
>      master|REBASE 4/8
> 
> To say I'm on 2/6, but that I've tried 3 times already and failed to
> advance past it.
> 
> Anyway, I don't have patches for this side-report/rant. Looking at the
> implementation it seemed more non-trivial than I was willing to
> quickly fix.

Yeah, I think the implementation would need a bit of thought.

In summary I agree that it would be good to improve the count so it 
makes more sense to the user

Best Wishes

Phillip


> We bump the count fairly early before we even get to there being an
> "exec" item, to implement this proposed view of the world we'd need to
> defer that (or go back and edit it once we see "failed exec" and that
> we're using --reschedule-failed-exec).
> 
> I'm not familiar enough with the sequencer internals to know if trying
> that would lead us down a path of e.g. having inconsistent or bad
> state if we'd die in the middle of all of that.
> 
> Ævar Arnfjörð Bjarmason (3):
>    rebase tests: camel-case rebase.rescheduleFailedExec consistently
>    rebase tests: use test_unconfig after test_config
>    rebase: don't override --no-reschedule-failed-exec with config
> 
>   Documentation/git-rebase.txt |  8 ++++++++
>   sequencer.c                  |  5 +++++
>   t/t3418-rebase-continue.sh   | 30 ++++++++++++++++++++++++++++--
>   3 files changed, 41 insertions(+), 2 deletions(-)
> 

