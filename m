Return-Path: <SRS0=LSsm=B4=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CB88C433DF
	for <git@archiver.kernel.org>; Tue, 18 Aug 2020 12:23:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF596207D3
	for <git@archiver.kernel.org>; Tue, 18 Aug 2020 12:23:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hDGpGNwr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726628AbgHRMXS (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Aug 2020 08:23:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726336AbgHRMXR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Aug 2020 08:23:17 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC229C061389
        for <git@vger.kernel.org>; Tue, 18 Aug 2020 05:23:16 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id f12so9806888ils.6
        for <git@vger.kernel.org>; Tue, 18 Aug 2020 05:23:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=aDjUIq94mk+r+T6mf5CpumRtj3OLNwfh4fKhfBHjhzM=;
        b=hDGpGNwr3oOicpa+x+UB+DN43P5BceOTyWVpBvuT1BKzCNeKaLVDvlPe5jWgebgfYn
         xImM4EbIvQHDrhIOwx85EmjpOessnEaG1iPtS0nuTDT1ldajmTHyhBszyafv3ZQO6UBo
         Cq/XSgk1HejbRe+RQmE8tzrHsLfvPSPPTadeNc42934KMjR3Up3vInRcn6eMDNl0bsSY
         krHf2CwK+GmyLMSAeHjeX+4XY4L4vSnto6hOJpUHbJptnDlMFkogcqfn+b9+I58GXyRD
         MEJp4t33VbLW6Xu7FVJRMyyUGyFBpOU+/s22TCo2pOkGwkZubcS45W8zHIdLDiCZkaMj
         l30g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=aDjUIq94mk+r+T6mf5CpumRtj3OLNwfh4fKhfBHjhzM=;
        b=Uk+jS2xcGY6trkip6WPGahF+QtnCkmh0nAn4+MdvxSo0mWgT6zAREKyqSMaV5aMQmh
         RM8t5iIxQLgZMv97ell8kk3XP3Er+HGp/NGYeRLlLjoQ6w9DLwMETt8k7gYkKiZsqpJw
         EUax9K532thhR9XQE4cQNGMVPEV9NlNanOqu5uxdYZya6c4Q1wzlzY/CwJwn2xOB73Ql
         gx3Z7clUnoX0E9LccJvNul/RAytdffnrZcVGs/IRJD+iYFFMjQJtFg6k1fyc2uqaBi/6
         9oRrLK7iIavPGAOYw0DFRAIVuJz/i/jPAHrTKbg1XqnjN7K15mpOWJP1pjFRIO5onNCI
         aMKQ==
X-Gm-Message-State: AOAM533egZJnFyqdF8wKOliUMVEzk8lYNKrKjxXqG8Uotoxplg6Hob8h
        +0M9tq6WIeBDyunw16Z/skUejs5U7P3nwh89Y9Lc5MT8tLQdSg==
X-Google-Smtp-Source: ABdhPJzTp2MyyyQpSo7wuD4Ix2tKjKdqFwQ6wAZH81+0+HFpfz2DMkr6C7xsMqGObD+oAzwIl4VB/1rs2hAwa6PhDWk=
X-Received: by 2002:a92:3209:: with SMTP id z9mr10253728ile.126.1597753395851;
 Tue, 18 Aug 2020 05:23:15 -0700 (PDT)
MIME-Version: 1.0
From:   Gopal Yadav <gopunop@gmail.com>
Date:   Tue, 18 Aug 2020 17:53:04 +0530
Message-ID: <CAAUOv8jP00_W6=qFBWL1RpV0Dd1Fh1k19PQ33ycBnwVMLfRypA@mail.gmail.com>
Subject: [NEW] Git
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Everyone,

I am new to git and have submitted a microproject to get familiar with
the process of submitting patches. Would further like to work on
resolving this issue https://github.com/gitgitgadget/git/issues/353

Some questions regarding that:
What is meant by skipping evaluation of lazy prereq?
Does it mean that test_lazy_prereq() and test_run_lazy_prereq()
functions should be skipped in tests which are instructed to be
skipped by --run?

So for example if we run $sh t0001-init.sh --run='1-33'
Then current behaviour allows test_lazy_prereq() at line 319 to execute.
But since we are not running tests past the 33rd test we don't want
test_lazy_prereq() to be executed.
Is this the problem statement?

I know the issue talks about something related to chains but I am
thinking of starting by resolving the lazy prereq task first.
