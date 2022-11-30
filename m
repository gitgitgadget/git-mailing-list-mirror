Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE631C433FE
	for <git@archiver.kernel.org>; Wed, 30 Nov 2022 03:46:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233217AbiK3Dql (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Nov 2022 22:46:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232868AbiK3DqX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Nov 2022 22:46:23 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3B59769EE
        for <git@vger.kernel.org>; Tue, 29 Nov 2022 19:45:05 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id g10so15410797plo.11
        for <git@vger.kernel.org>; Tue, 29 Nov 2022 19:45:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BoydLjhle/6njEQpaGR01ydEf+GHy/RwAFTZk5cCC8g=;
        b=VDlFWs5Oq9Bm4rfXPL5lgvKKOyR/BhRMQ0dxlBCG6aUmy+qh5vQ2S9WtFRrqYtJENP
         0Uy4JeQ22vSmEOdo9mLzJBxm+nq7Yll1TnPCWQ/tHt/lvPNKQ1jzvnhuTFwU0MZGMmKz
         15htgm35ynOh7lParHGI0NGoC6NuWRWmmafVoOGRUImzWEkqPfXcE9rj2h5mLpiw7j8E
         sb4ekEWFKjTpKclYkeshFPma6J106SlugkRzpJlx+9nc3YBE06M8AFsHsWqAtVUHaIHN
         HWcT93Vv5Vflohj0IZmwxgweVoMcn/WDn0ADwuN7/8BRJfzpE+pg7zqRFCavAyJ59tO3
         Tf8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=BoydLjhle/6njEQpaGR01ydEf+GHy/RwAFTZk5cCC8g=;
        b=r4yIfMBFn9FPXhNJwbSVQLJ+HlRZJtWL6daL5sxbYKnl1s8FtXDayW4nBeFdFAdBkk
         iJEqSAKFQmMUQPGQ6H/uv3FVp2v0O/SfihtALkS4ylqPNpluwblwcH06ZrB8PvBDuqme
         WR422scB4z69EdlxcU6SPXLLpR8FlwwhtAKwIl7LpWThGMLcaISj5ry+igsnYORFBDbb
         t9WCZWnoKnoQpdctxDLI+nWlCPvuZnDwtzJI3nb3RWh+eey1htJXEFf0bXjilKhTQVmd
         KIs3nEAHlFOGqyDc+9xDmTLThaiQsXs/TL7k0S/2S9oOmF4ifNzPIPt9c5QmStK6GNMl
         dOoQ==
X-Gm-Message-State: ANoB5pnHk4LIfaogJsNA7nXhMrPsoLmsZEwz+Wz8uXOeRX6kgmQqanua
        nAvj5X0auzbLMSCCjXCI2StTG3G/W0vTwQ==
X-Google-Smtp-Source: AA0mqf6yFdXlHjv7GhGstf/gcIAdf9Q21NJE3HxYFcCBnY+OJl9v+ZI1N2CgF9V2v94hhXy7U7IvAA==
X-Received: by 2002:a17:90b:609:b0:219:3ad9:64f5 with SMTP id gb9-20020a17090b060900b002193ad964f5mr13191872pjb.138.1669779905111;
        Tue, 29 Nov 2022 19:45:05 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id a5-20020aa79705000000b0056c058ab000sm239810pfg.155.2022.11.29.19.45.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Nov 2022 19:45:04 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Glen Choo <chooglen@google.com>
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>,
        Calvin Wan <calvinwan@google.com>
Subject: Re: What's cooking in git.git (Nov 2022, #07; Tue, 29)
References: <xmqqsfi22j67.fsf@gitster.g>
        <kl6lpmd5d1e8.fsf@chooglen-macbookpro.roam.corp.google.com>
Date:   Wed, 30 Nov 2022 12:45:04 +0900
In-Reply-To: <kl6lpmd5d1e8.fsf@chooglen-macbookpro.roam.corp.google.com> (Glen
        Choo's message of "Tue, 29 Nov 2022 11:08:31 -0800")
Message-ID: <xmqqedtl14xr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Glen Choo <chooglen@google.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> * gc/submodule-clone-update-with-branches (2022-10-30) 8 commits
>>  - clone, submodule update: create and check out branches
>>  - submodule--helper: remove update_data.suboid
>>  - submodule update: refactor update targets
>>  - submodule: return target of submodule symref
>>  - t5617: drop references to remote-tracking branches
>>  - submodule--helper clone: create named branch
>>  - repo-settings: add submodule_propagate_branches
>>  - clone: teach --detach option
>>
>>  "git clone --recurse-submodules" and "git submodule update" learns
>>  to honor the "propagete branches" option.
>>
>>  Waiting for review on the updated round.
>>  source: <pull.1321.v3.git.git.1666988096.gitgitgadget@gmail.com>
>
> Jonathan left adequate feedback on the updated round, and we had decided
> on a direction for the reroll in [1].
>
> However, Calvin is also looking at how we could parallelize worktree
> updates to speed up "git clone --recurse-submodules", so the Google
> folks are taking an even bigger step back to figure out how worktree
> updating should look, which will probably end in a different approach
> from [1], but it should answer the questions on that thread about "git
> checkout" with branches.
>
> [1] https://lore.kernel.org/git/20221123013319.1597025-1-jonathantanmy@google.com

Thanks for a status report.

So it sounds more like "discard for now" to expect a fresh restart.


