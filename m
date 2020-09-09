Return-Path: <SRS0=4khD=CT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16C41C433E2
	for <git@archiver.kernel.org>; Thu, 10 Sep 2020 03:23:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C377B21D40
	for <git@archiver.kernel.org>; Thu, 10 Sep 2020 03:23:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729942AbgIJDXo (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Sep 2020 23:23:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729779AbgIJDXB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Sep 2020 23:23:01 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 378D9C06179E
        for <git@vger.kernel.org>; Wed,  9 Sep 2020 16:20:40 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id r24so5776480ljm.3
        for <git@vger.kernel.org>; Wed, 09 Sep 2020 16:20:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KWzDQ1e6771FpbwDw9CPPsZAcSQ+aLMpAJ38xiLklTs=;
        b=FlqpjF5WhdjRmfYYNM1BuJ2YnWfiKdRrywEYUv7KV+XlyPP5KcIloReFZ1vvQAqwBe
         u4dLgNWRqj1aIDq/VKkfq/3T/jVrtC9btnvnd6KUUcDVd9LPUs1twAO2OTYGsm+QZ+bG
         QLHyn54SrrI7wFSvdpu30vkLQGGs32rMiSfEMhye6fq7tdckNT9FjwV12szUGQrMHmF2
         5CkeTs9QX/HLAqn2G/FW5TYmSvcRoYZkD1e4vUKymHaKU6qFZg0HkeCt7GgrIpRA5/C4
         8rRy8oQAwm1FX7OAMJpt94dUv0dMMp2nEPqMrbaTQd0MZkUQbo8QHtaCiE9GU0WcE1DD
         OzWQ==
X-Gm-Message-State: AOAM532bLzCdFOoHP6g+OmAbRuryq32o7gCPa8xc5YAHPtMIeSm8i7Nq
        yMlVahpzHac9JdhPneVYMmk0HqHyuW69UYKtwNFUpUBurJ0=
X-Google-Smtp-Source: ABdhPJx4rlKaMzYoob7MefQAs1lHiL7t0mix+iZUqMcUWVx8+TIuCw4iGkAqE0+38/QZgUou3F17Xf5I0hbYDksH1MM=
X-Received: by 2002:a17:906:2cc2:: with SMTP id r2mr5854320ejr.482.1599692852943;
 Wed, 09 Sep 2020 16:07:32 -0700 (PDT)
MIME-Version: 1.0
References: <xmqq4ko6twc9.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqq4ko6twc9.fsf@gitster.c.googlers.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 9 Sep 2020 19:07:22 -0400
Message-ID: <CAPig+cQnnukVoJTgsu1sGFWkAYv7V38-0s-CgYuMyizYHhSFQQ@mail.gmail.com>
Subject: Re: What's cooking in git.git (Sep 2020, #03; Wed, 9)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 9, 2020 at 6:33 PM Junio C Hamano <gitster@pobox.com> wrote:
> * es/format-patch-interdiff-cleanup (2020-09-08) 3 commits
>  - format-patch: use 'origin' as start of current-series-range when known
>  - diff-lib: tighten show_interdiff()'s interface
>  - diff: move show_interdiff() from its own file to diff-lib
>
>  Code cleanup with a slight behaviour change when "format-patch
>  --range-diff=<prev> origin..HEAD" gives a single revision to
>  <prev>.

Perhaps this could be a bit more precise by saying something like:

    Code cleanup and make "format-patch --range-diff=<prev>
    <origin>..HEAD" not ignore <origin> when <prev> is a single
    revision.

> * es/wt-add-detach (2020-09-06) 3 commits
>  - git-worktree.txt: discuss branch-based vs. throwaway worktrees
>  - worktree: teach `add` to recognize -d as shorthand for --detach
>  - git-checkout.txt: document -d short option for --detach
>
>  "git worktree add" learns the "--detach" option to create a new
>  worktree without being on a branch.

This needs a tweak to avoid being incorrect. "git worktree add" has
understood --detach from the start. This series only teaches it -d as
an alias for --detach. So, perhaps:

    "git worktree add" learns "-d" as short for "--detach".
