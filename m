Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED4C4C48BDF
	for <git@archiver.kernel.org>; Sun, 20 Jun 2021 18:02:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C2D9861057
	for <git@archiver.kernel.org>; Sun, 20 Jun 2021 18:02:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229875AbhFTSEe (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 20 Jun 2021 14:04:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229694AbhFTSEe (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Jun 2021 14:04:34 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 673EFC061574
        for <git@vger.kernel.org>; Sun, 20 Jun 2021 11:02:21 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id d11so14580576wrm.0
        for <git@vger.kernel.org>; Sun, 20 Jun 2021 11:02:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=WH+S6ZgOsl1zplw2QEy/thGpYFHTODKY7FZNYoiPQk8=;
        b=MXc+RZC2WOrjOZxWwTCMZX6GTfj4S8rlm1+2Ntu1GF9bc8R+VzMuI0kjHD2ty/J8I4
         p02qI5zqyKKLn1z8vziLv33MRMTBtJHH5a+qk9CpWFf+9kyQhhnvD0glB+L9zYar5XoS
         omf92EUZ7TMTZ5L4A0i8ScF1+n/6o1xay+VX83ohIbheiuowRYevD9lMNB8U2UYVsiI2
         HfF724hLKo9x0nREsu1lGRJTbxB08gZW/9VUfUIBhaDe0shWwBw3NpOVHv+JZ1rms+6X
         IvSF5kAu47bt93bnvFd7UypVXMMtzJct3siUftHgHT3UOOfb+22LQxGfRJn1V9Ol2Ymx
         9rng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WH+S6ZgOsl1zplw2QEy/thGpYFHTODKY7FZNYoiPQk8=;
        b=khNlVbXYyfsrqQGmIqxVIT09FXKyJpwTNR4aroBzK01SGimz2FR948xCccZ3goEQ3p
         Mse5S5y1PYCEbdhdrn2XWl31lxZtxOzAAW2FAsqSKnArFl25ELL0kJ/FBD29G4KITE3E
         lO6UiGKc5l4YzEDYIADdBN6hR0EmDTY7C4wXdGC0bLtM1r5MeQ9N3uNH+07S6nd+B2dq
         Gbd9GGxvDpFhPAsJjcdGN/olHOilhzmi8mgwwIjdHyx/9ky9VI7Gm6zvaZ2B/PRMdgHG
         7Ux81oXN0EeCb23IrspIwRLcllzmHmHY2mHC5jdAPpmoKd5Y2kFiHTW7boRItPF7PJ+R
         Z+AQ==
X-Gm-Message-State: AOAM530AYwWkwwI7BqgGWOjLugFa6/FtHk4Zo6yIbNWVcF6E7ggi3a1C
        fhoDw4xagWa+rOxYdnNi8yWw/WWAF4M=
X-Google-Smtp-Source: ABdhPJwjznXPBr3ewcB6PnfSnjZLU0G9rRMfKfygY/tCg1bNjCNvjK+wxpyt3haRS6VFvl+v7jF6BA==
X-Received: by 2002:a05:6000:2ce:: with SMTP id o14mr24870390wry.145.1624212139866;
        Sun, 20 Jun 2021 11:02:19 -0700 (PDT)
Received: from [192.168.1.201] (11.22.198.146.dyn.plus.net. [146.198.22.11])
        by smtp.googlemail.com with ESMTPSA id r6sm14987142wrz.91.2021.06.20.11.02.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 20 Jun 2021 11:02:19 -0700 (PDT)
Subject: Re: Nonexistent changes appear rebasing but only with
 rebase.backend=apply
To:     Marco Giuliano <marco.giuliano@tesisquare.com>, git@vger.kernel.org
References: <CANLwWg4hG=iv9qjOmGHSJ7z7Y+vvvP+x0o3DfR5bH5A-C6_7aQ@mail.gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <9a83ef22-2291-1364-b0a8-1eb8257972a2@gmail.com>
Date:   Sun, 20 Jun 2021 19:02:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CANLwWg4hG=iv9qjOmGHSJ7z7Y+vvvP+x0o3DfR5bH5A-C6_7aQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Marco

On 18/06/2021 16:21, Marco Giuliano wrote:
> Hi All
> 
> I'm facing a strange anomaly during rebase.
> I'll try to explain what happens because unfortunately I cannot share
> more information since it's confidential and unfortunately an
> anonymized export does not reproduce the issue.
> 
> I have the following repository status:
> 
>     * commit 2 (BRANCH X)
>     |
>     |  * commit 4 (BRANCH Y) (HEAD)
>     |  |
>     |  * commit 3
>     | /
>     |/
>     * commit 1
>     |
>     |
>   (...)
> 
> What I'm trying to do is rebasing branch Y on branch X, with the command:
> git rebase X
> 
> The anomaly is that, among other expected conflicts, also two files
> (fileA, fileB) appear modified in both branches, but those two files
> have not been modified in any of the 4 commits you see in the graph
> above!
> The anomaly appears only with the config setting rebase.backend=apply,
> while not with rebase.backend=merge (*).
> 
> This might not be caused by rebase command itself, but rather by some
> previous operations which might have accidentally "broken" something
> and that the rebase simply makes them appear.
> You need to know that commit 4 is the result of several squash and
> reordering of multiple commits; is it possible that some of those
> operations have created some "leftovers" ?
> 
> I know this is difficult without seeing the actual repository, but
> could you just give me some advice or point me to the place where I
> can investigate ?

That certainly sounds quite strange. I think the patches used by the 
apply backend are stored in .git/rebased-patches, it might be worth 
looking at that file when the rebase stops for you to resolve the 
conflict resolution to see if that sheds any light on which commits the 
conflicts are coming from. Failing that does the content of the 
conflicts provide any clues as to which commits they are coming from? 
You could also try matching the blob id's from the index line of `diff 
--cc` to the index lines in `git log -p` to try and find where they are 
coming from.

Rebase ought to just replay the commits so in theory it shouldn't matter 
that you've been squashing and rearranging commits. What does `git log 
-p branch-x...branch-y fileA fileB` show? (it shouldn't show anything if 
those files are not touched by any of the commits)

Best Wishes

Phillip

> (*)
> When the anomaly first appeared, I was using git for windows, version
> < 2.26.0 (unfortunately I cannot recover the exact number); I decided
> to upgrade git to 2.31.1 and the anomaly disappeared. Investigating
> the release notes, I noticed that rebase.backend default value changed
> from apply to rebase from version 2.26.0.
> I also copied the repository on linux (with git 2.31.0), and the
> behavior is the same.
> 
> Thanks in advance for any help,
> Best Regards,
> Marco
> 

