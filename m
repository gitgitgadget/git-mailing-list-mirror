Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33EACC433ED
	for <git@archiver.kernel.org>; Wed, 14 Apr 2021 06:13:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 00B67611EE
	for <git@archiver.kernel.org>; Wed, 14 Apr 2021 06:13:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349104AbhDNGNv (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Apr 2021 02:13:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347755AbhDNGNv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Apr 2021 02:13:51 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45F65C061574
        for <git@vger.kernel.org>; Tue, 13 Apr 2021 23:13:30 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id r13so5926698pjf.2
        for <git@vger.kernel.org>; Tue, 13 Apr 2021 23:13:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=6lpduO5DJO6Jhu/7gSmAFMWgZN9X6fUCsnXUxPXJa0k=;
        b=IUcpS67tL3auSKjlsNNgj1x/Qaa1+AsVsgeb3gp02vta+OE9GiDpr5JtJnnSkL1MWR
         3qAzcvMaPiatd9DoM87kuqpuJk9twNelSmvoFrNOnUTylkD/LYg9bKxAe4g0q60HjzgC
         3CYG2VB11sxQ4AkvRvnWnmzGmxM7oxcc6+1MXxMkvTdrlZW+/V40VS77AaSDHsAgpkzM
         l4EFkNFg8BvGvONYx/wytEaaD33bFxmMdT4qnohjEn2Pwl1DmKgw6RYj34NfFpKsMSpA
         HAkK8V3JmsdyPLsqH8Rhu/t6rETiyjBZ86pEXpY8mN16VALZSAfEWBbQZ41BsQCKdu9r
         CZBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=6lpduO5DJO6Jhu/7gSmAFMWgZN9X6fUCsnXUxPXJa0k=;
        b=rsvtJWZOdZPmqFcIj+1EC5mLF0fM0yDH0ydqlwh+h2tdv2BKrpLx8EtUS+HZSGJzgX
         gJcxfLuxAPV1WfbYa1XYVLvvsvS1IV9dhm7mw6ba69LEulOW2/XH4PdTEXdQkv30iEnl
         /dUWtNVxwL5HTHuipqk+PQMSFsGza5aujXgpue37p1D+XojmjZGtx67fduP1aB4/bGTA
         T77RTtdaZMTi4EQq2vYEX0MjnWMxBZhA3bRVyxhPg/8Z0hSXkndbW8ApRG/FSnhEWhhm
         Yh0bsPRlxVJ1eJYWUDnLgUDuyhEEtwZYqvQ1WEfo9/RAgIXUdukoqySt5hvbLrs9U6nC
         Efmw==
X-Gm-Message-State: AOAM53120sideZ3uDAsWIVcYTEeduDzrOm2wFtfzPbCnrnaNEPrKSdds
        rm5IFq+AcQsUG0sHTA0P5fWPq3XieAM=
X-Google-Smtp-Source: ABdhPJz5OsqIVAp7CwJgJSp/GJoh7XhAxsW2f8kyIe0s5jOTRSP4zbHAzroLsgzR68/utB7qk/q3Ag==
X-Received: by 2002:a17:90a:d352:: with SMTP id i18mr1867124pjx.19.1618380809385;
        Tue, 13 Apr 2021 23:13:29 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:e5b9:3ce9:bdd4:e712])
        by smtp.gmail.com with ESMTPSA id s21sm237792pjr.52.2021.04.13.23.13.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Apr 2021 23:13:28 -0700 (PDT)
Date:   Tue, 13 Apr 2021 23:13:26 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     git@vger.kernel.org
Cc:     Raxel Gutierrez <raxelgutierrez09@gmail.com>, mricon@kernel.org,
        patchwork@lists.ozlabs.org, Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>,
        Emily Shaffer <emilyshaffer@google.com>
Subject: Pain points in Git's patch flow
Message-ID: <YHaIBvl6Mf7ztJB3@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I'd like to introduce Raxel (cc-ed), who is starting an internship
this June with the Git team at Google.

He'll be working on a bit of an experimental project: we want to take
Patchwork[1], which in principle can be a helpful addition to a
mailing list centric workflow[2], and improve it to be something that
people in the Git open source project get day-to-day benefit from.
Raxel's previous successes in making changes to tools to support a
better user experience make me excited for the potential for this
work.

Anyway, yesterday[3] Junio, Taylor, and Emily were discussing how to
encourage more reviews:

 <gitster> this week, i'd be thinking about ways to get topics, that
           are not reviewed sufficiently, reviewed. I can act as the
           last-resort fallback reviewer, but that's not sufficient.
 <ttaylorr> gitster: I share your concern.
 <nasamuffin> gitster: yep, agree, on both counts

That reminded me that it would be useful preparation to collect
descriptions of pain points we are having with our existing patch
flow.  For example:

- As a reviewer, I want to be able to easily find a series that needs
  review.  Using patchwork, I can see some recent patch series; or
  using a hierarchical threaded mail reader, I can find a neglected
  thread or one that seems to be likely to have an interesting
  discussion going on.  But without reading in detail, there is no
  easy way to see whether the series has reached a review, whether
  someone else intends to review it, and what the author believes its
  status to be.

- Relatedly, as a patch author or reviewer, I want to be able to
  easily tell whether a topic has been sufficiently reviewed.  Today,
  the signals for this are implicit: I have to judge consensus, or to
  check the Git repository for whether the patch has been merged, or
  to check the maintainer's latest "What's cooking in git.git"
  message.

- As a potential reviewer or interested user, I want to be able to
  follow all relevant discussion for a patch series, while also
  having the ability to stop following it if the discussion goes on
  too long and starts overwhelming my email inbox.  Today, I can join
  the discussion and then (1) it is hit-or-miss whether the patch
  author ccs me on later iterations of the patch and (2) there is no
  easy way without aggressive email filtering to stop watching it if
  I am cc-ed.

- After having diagnosed an issue to be due to a patch, I want to be
  able to easily find all relevant review discussion.  Today I can
  use the mailing list archive[4] or patchwork to find review
  discussion on the latest version of the series that patch was in,
  but tracing back to previous iterations of that same series can be
  non-trivial.  Moreover, if I'm interested in a particular puzzling
  line of code, finding which iteration introduced it can take a long
  time.

Those four are important in my everyday life.  Questions:

 1. What pain points in the patch flow for git.git are important to
    you?

 2. What tricks do you use to get by with those existing pain points?

 3. Do you think patchwork goes in a direction that is likely to help
    with these?

 4. What other tools would you like to see that could help?

Thanks,
Jonathan

[1] http://jk.ozlabs.org/projects/patchwork/; you can see an instance
for Git at https://patchwork.kernel.org/project/git/list/
[2] https://kernel-recipes.org/en/2016/talks/patches-carved-into-stone-tablets/,
https://www.kernel.org/pub/software/scm/git/docs/gitworkflows.html#_patch_workflow
[3] https://colabti.org/irclogger/irclogger_log/git-devel?date=2021-04-12#l40
[4] https://lore.kernel.org/git/
