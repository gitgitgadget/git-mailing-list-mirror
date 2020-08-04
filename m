Return-Path: <SRS0=W4Po=BO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92016C433E0
	for <git@archiver.kernel.org>; Tue,  4 Aug 2020 22:01:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 780B2207FC
	for <git@archiver.kernel.org>; Tue,  4 Aug 2020 22:01:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TZaxuQ8O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728091AbgHDWBX (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Aug 2020 18:01:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728052AbgHDWBW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Aug 2020 18:01:22 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC22DC06174A
        for <git@vger.kernel.org>; Tue,  4 Aug 2020 15:01:21 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id d27so32213291qtg.4
        for <git@vger.kernel.org>; Tue, 04 Aug 2020 15:01:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4jM4uBIKl7buLa+IwnOGHeAbd38hzr/vLHfLEzGwHvU=;
        b=TZaxuQ8OBULbkJcPTIk9MRpjR0c0m9za1UEytBubXKxyX0nWLxWe69Zv+H85mr3zxB
         BkLaf5ool735A5pQqNxwkz+bTGBvvRGU825zvpV2Jh8mHtiDbsRN/y9lZxAPaKX7euov
         jsWHBL0IrRZrycoZiY4qzkFxVAMCp76TPq3SyDY+BRi3e9bDMFW1oGeW8BdJvxVJH+7F
         VndZvuyivMgrbSPP64fQ2GllgF+t6qLAcsNCWeFSuS1qWdsMEtv4+G25/Fl5DThxBu51
         Fi03aPcoOyprSvILlQBM6I8G8SJwy93V9pgIexrlK+9LAa+r7yUkxeIGuIpuXoBeXm8u
         DcgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4jM4uBIKl7buLa+IwnOGHeAbd38hzr/vLHfLEzGwHvU=;
        b=B5LSQmaq8cUXmfYEczesBZKF5vDaVUcc3b3TFMBFHIH3mJYJjxgIgJAMh256KdUFaL
         mWMqMXVREPJaFxM0b6z84HUhtTUCFjhFJZanriXHpsqyKv+po5buC5zGZnPgWBanu61J
         /55f0GvUXb/QSGZ7nqCfzXI32Ke+VlN4k5WYXkqwMC4iLmfc2ZLah1ZH2Tm6t7VlbLWs
         pVz0d+sMB5/5FOSoXgLEUsZu4jc4zFhTso+qk2QMQXtK0INYHZcfEactUm9rk6hOSAP4
         v+mdfDUEyrHcfhZmvuZaZzM/700Iqkk5AI/UOruu+aI+S+abFgCDQeB7k3NnmTwBgUVe
         GMkg==
X-Gm-Message-State: AOAM532TO5uftnshV0gCA1n6n4MFzZe1lrw75G6/x9kbf0MfZ7fSM99/
        9ImZ0LEBZfCb0+2XYY0pKLFla9fBbvzJlA==
X-Google-Smtp-Source: ABdhPJzOzpD5KghSI2d5KEHu1FR1k/trKTtJRQkbO16weRpemSWJ3c3+xJMajRk/VzQbN6c8UdoqTw==
X-Received: by 2002:aed:2356:: with SMTP id i22mr227040qtc.92.1596578480480;
        Tue, 04 Aug 2020 15:01:20 -0700 (PDT)
Received: from localhost.localdomain (c-98-229-3-81.hsd1.vt.comcast.net. [98.229.3.81])
        by smtp.gmail.com with ESMTPSA id n33sm231724qtd.43.2020.08.04.15.01.19
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Aug 2020 15:01:20 -0700 (PDT)
From:   Aaron Lipman <alipman88@gmail.com>
To:     git@vger.kernel.org
Cc:     Aaron Lipman <alipman88@gmail.com>
Subject: [PATCH v4 0/5] Introduce --first-parent flag for git bisect
Date:   Tue,  4 Aug 2020 18:01:08 -0400
Message-Id: <20200804220113.5909-1-alipman88@gmail.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20200801175840.1877-1-alipman88@gmail.com>
References: <20200801175840.1877-1-alipman88@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

OK, here's take 4! Responding to Junio's feedback, first:

> That function [cmd_bisect__helper()] is supposed to be a thin shim
> layer whose only reason of its existence is to serve as an interface
> with the scripted version of "git bisect".  When everything is
> migrated from the shell script, cmd_bisect__helper() should disappear.
> ...
> This is going backwards, as far as I can tell.  If anything, I'd
> rather see cmd_bisect__helper() get fixed so that it does not parse
> "--first-parent" (and similarly, "--no-checkout" that you imitated)
> into first_parent_only (and no_checkout) variables and passed as
> parameters to bisect_start().

Thanks for the explanation, Junio. (And for bearing with me while I
gain familiarity with git's codebase.) Now that I've taken some time
to examine how git-bisect.sh and cmd_bisect__helper() fit together,
the correct approach is much more clear.

I've added a commit (3/5 in this iteration) that updates
cmd_bisect__helper() to defer parsing the --no-checkout flag.

As no_checkout was also passed to bisect_next_all() [via implicitly
checking for the existence of .git/BISECT_HEAD when calling
bisect_next() in git-bisect.sh], I've removed that parameter and
instead check for .git/BISECT_HEAD in bisect_next_all() to determine
whether no-checkout mode is on.

This means no-checkout mode can no longer be enabled by "git
bisect--helper --next-all --no-checkout" - it can now only be turned
on when running "git bisect start". But this doesn't change git
bisect's public API, so this should be OK.

Other than the changes suggested by Martin (summarized below), the
only new change is removing the read_first_parent_option() wrapper
function in favor of file_exists() from dir.h.

---

Martin, thanks for your suggestions - I've moved the commit updating
"git bisect run" tests to 1/5, updated the commit message, and
included the changes you provided. (I held off on additional
indentation corrections, as it kinda felt like unnecessary code
churn/outside the scope of abstracting platform-specific details.)

> Also, does "separate between <one thing>" make grammatical sense?
> Should it be "separate between <two things>" or "separate [it] from
> <one thing>"? Dunno..

I think "separate [it] from <one thing>" is correct, good catch!

> (Signed-off-by: Martin Ågren <martin.agren@gmail.com>, FWIW.)

I'm still getting used to the conventions - should I add your name as
a signed-off-by tag, a thanks-to tag, or both?

Aaron Lipman (5):
  t6030: modernize "git bisect run" tests
  rev-list: allow bisect and first-parent flags
  cmd_bisect__helper: defer parsing no-checkout flag
  bisect: introduce first-parent flag
  bisect: combine args passed to find_bisection()

 Documentation/git-bisect.txt       |  13 +++-
 Documentation/rev-list-options.txt |   7 +-
 bisect.c                           |  79 +++++++++++++---------
 bisect.h                           |   9 +--
 builtin/bisect--helper.c           |  23 ++++---
 builtin/rev-list.c                 |   9 ++-
 git-bisect.sh                      |   2 +-
 revision.c                         |   3 -
 t/t6000-rev-list-misc.sh           |   4 +-
 t/t6002-rev-list-bisect.sh         |  45 +++++++++++++
 t/t6030-bisect-porcelain.sh        | 104 ++++++++++++++++-------------
 11 files changed, 195 insertions(+), 103 deletions(-)

-- 
2.24.3 (Apple Git-128)

