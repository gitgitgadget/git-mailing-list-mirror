Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9217DC83F12
	for <git@archiver.kernel.org>; Tue, 29 Aug 2023 20:48:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236254AbjH2Urm (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Aug 2023 16:47:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240639AbjH2Urg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Aug 2023 16:47:36 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 184B01BE
        for <git@vger.kernel.org>; Tue, 29 Aug 2023 13:47:32 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-401b0d97850so47286515e9.2
        for <git@vger.kernel.org>; Tue, 29 Aug 2023 13:47:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693342050; x=1693946850; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/M0fw5FQQbFXFkbCKQTcsaoIeKtTzPJog/+yepijpiE=;
        b=k2GPfZJo7/RVuQ+vlfBwePPw60W5mF4Ewx0lYGVcQGIFe+nr0lmKjHnW3vMtezowNZ
         kE/1n/tDfRBFQ+/XPUJrwMjjtNLxwcjvuT7W1ev/Jb1M+23YINnax4+nj5x0HQfkRLiO
         h07a4fQp20UWHK3unksWohqXEINjFVNsjWHNOm7R8hAo9l/IXczDUDfuQY087l2j1wz4
         4B4CqeaVc7HYUYYLzyRzxudJMPxmqZR/RvXkX9agoPyufAtRX9ysrHiw3zi7Ro/GF4TR
         bd4MWFAPO2KD92/yXYOC++LuA5rkwDqj/P4ptuvMIC2+5ksGpomPiweuuRjUNuuMS+Cb
         /9Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693342050; x=1693946850;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/M0fw5FQQbFXFkbCKQTcsaoIeKtTzPJog/+yepijpiE=;
        b=RNqqWrbsbIJwM9GTd6dwGBe/WcJfz9fKjxdKXQEdT9OLLx6g8zkn/3NTZRQKh257w2
         Q1dQ6ms74OgVn7p1Yx6UgEMjEKTQ61swVu+GjD4DSTBpgrCMPTCU9zApH0DaX1baEZSC
         V7pZcdGXnV6xLO38DOYr4Xbyv4tvY5Lwgx9iCXg15fSIxF8VTQoWfB6sJMuvmfP4ZUry
         JMLIMmJXAbbxv1Q3rqXn6Z6IWhwgVdLYIUG4h006tKCrTXxx8KvgQtKTuv0ngpZNXlWf
         pCBfAotg/aDPAJeC0XpBcCQTJUJ6bNOoPi1hSeP4xQ+MX6KyfzFcxeEBmGpwLLYGUag9
         1bhw==
X-Gm-Message-State: AOJu0Yyj7MulrPn21BI10q0HYqc/D3LDs/CMr+MEyv4ElcSxCoLTthmY
        IFxoSweAUCPhpBFp9NOv/to1Rm2DWv4=
X-Google-Smtp-Source: AGHT+IG3SXHLdVyEhECKZPJdRbsCMz01eVw4oNXBi0CJ/xGwFoPzVz9QITYFulHQdB7RByJz9NmpbQ==
X-Received: by 2002:adf:fe89:0:b0:317:e1fb:d57b with SMTP id l9-20020adffe89000000b00317e1fbd57bmr134036wrr.56.1693342050023;
        Tue, 29 Aug 2023 13:47:30 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b16-20020a5d4d90000000b0030fd03e3d25sm14780792wru.75.2023.08.29.13.47.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Aug 2023 13:47:29 -0700 (PDT)
Message-ID: <pull.1578.v2.git.1693342048633.gitgitgadget@gmail.com>
In-Reply-To: <pull.1578.git.1693304963963.gitgitgadget@gmail.com>
References: <pull.1578.git.1693304963963.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 29 Aug 2023 20:47:28 +0000
Subject: [PATCH v2] ci(linux-asan-ubsan): let's save some time
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

Every once in a while, the `git-p4` tests flake for reasons outside of
our control. It typically fails with "Connection refused" e.g. here:
https://github.com/git/git/actions/runs/5969707156/job/16196057724

	[...]
	+ git p4 clone --dest=/home/runner/work/git/git/t/trash directory.t9807-git-p4-submit/git //depot
	  Initialized empty Git repository in /home/runner/work/git/git/t/trash directory.t9807-git-p4-submit/git/.git/
	  Perforce client error:
		Connect to server failed; check $P4PORT.
		TCP connect to localhost:9807 failed.
		connect: 127.0.0.1:9807: Connection refused
	  failure accessing depot: could not run p4
	  Importing from //depot into /home/runner/work/git/git/t/trash directory.t9807-git-p4-submit/git
	 [...]

This happens in other jobs, too, but in the `linux-asan-ubsan` job it
hurts the most because that job often takes over a full hour to run,
therefore re-running a failed `linux-asan-ubsan` job is _very_ costly.

The purpose of the `linux-asan-ubsan` job is to exercise the C code of
Git, anyway, and any part of Git's source code that the `git-p4` tests
run and that would benefit from the attention of ASAN/UBSAN are run
better in other tests anyway, as debugging C code run via Python scripts
can get a bit hairy.

In fact, it is not even just `git-p4` that is the problem (even if it
flakes often enough to be problematic in the CI builds), but really the
part about Python scripts. So let's just skip any Python parts of the
tests from being run in that job.

For good measure, also skip the Subversion tests because debugging C
code run via Perl scripts is as much fun as debugging C code run via
Python scripts. And it will reduce the time this very expensive job
takes, which is a big benefit.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
    ci(linux-asan-ubsan): let's save some time
    
    I often look at failed CI runs, and the linux-asan-ubsan job comes up
    frequently, and painfully (because it takes such a long time that
    re-running is often less desirable than getting the CI runs to pass).
    
    This commit is an attempt to reduce the pain and suffering stemming from
    this particular job, simply by deciding that the benefit of running the
    Python/Subversion-related tests in that job is far outweighed by its
    cost.
    
    This commit not only reduces the number of git-p4 flakes in
    linux-asan-ubsan to 0, it also seems to shave off about 10 minutes
    runtime, comparing
    https://github.com/gitgitgadget/git/actions/runs/5929602548/job/16077585391
    to
    https://github.com/gitgitgadget/git/actions/runs/6010305446/job/16301473243?pr=1578
    (which is not quite scientific due to the lack of a controlled
    environment, but it's the best we got for now). Together, those benefits
    form a strong incentive for me to get this merged.
    
    This patch is based on maint.
    
    Changes since v1:
    
     * Made the rationale clearer (it is not Python that flakes, but
       Perforce).
     * Touched up the commit message.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1578%2Fdscho%2Fskip-p4-from-asan-runs-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1578/dscho/skip-p4-from-asan-runs-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1578

Range-diff vs v1:

 1:  ac5b82ea934 ! 1:  1927a97667b ci(linux-asan-ubsan): let's save some time
     @@ Commit message
          better in other tests anyway, as debugging C code run via Python scripts
          can get a bit hairy.
      
     -    In fact, it is not even `git-p4` that is the problem (even if it flakes
     -    often enough to be problematic in the CI builds), but really the part
     -    about Python scripts. So let's just skip any Python parts of the tests
     -    from being run in that job.
     +    In fact, it is not even just `git-p4` that is the problem (even if it
     +    flakes often enough to be problematic in the CI builds), but really the
     +    part about Python scripts. So let's just skip any Python parts of the
     +    tests from being run in that job.
      
          For good measure, also skip the Subversion tests because debugging C
          code run via Perl scripts is as much fun as debugging C code run via
     @@ ci/lib.sh: linux-leaks)
       	;;
       linux-asan-ubsan)
       	export SANITIZE=address,undefined
     -+	export NO_SVN_TESTS=LetsSaveSomeTimeBack
     -+	MAKEFLAGS="$MAKEFLAGS NO_PYTHON=YepItFlakesTooOften"
     ++	export NO_SVN_TESTS=LetsSaveSomeTime
     ++	MAKEFLAGS="$MAKEFLAGS NO_PYTHON=YepBecauseP4FlakesTooOften"
       	;;
       esac
       


 ci/lib.sh | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/ci/lib.sh b/ci/lib.sh
index 369d462f130..6fbb5bade12 100755
--- a/ci/lib.sh
+++ b/ci/lib.sh
@@ -280,6 +280,8 @@ linux-leaks)
 	;;
 linux-asan-ubsan)
 	export SANITIZE=address,undefined
+	export NO_SVN_TESTS=LetsSaveSomeTime
+	MAKEFLAGS="$MAKEFLAGS NO_PYTHON=YepBecauseP4FlakesTooOften"
 	;;
 esac
 

base-commit: 43c8a30d150ecede9709c1f2527c8fba92c65f40
-- 
gitgitgadget
