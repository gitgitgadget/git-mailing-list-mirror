Return-Path: <SRS0=39iz=ZR=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92E21C432C3
	for <git@archiver.kernel.org>; Mon, 25 Nov 2019 21:28:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BC162071A
	for <git@archiver.kernel.org>; Mon, 25 Nov 2019 21:28:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="itH7rozu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726094AbfKYV23 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Nov 2019 16:28:29 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:53777 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725930AbfKYV23 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Nov 2019 16:28:29 -0500
Received: by mail-wm1-f66.google.com with SMTP id u18so904839wmc.3
        for <git@vger.kernel.org>; Mon, 25 Nov 2019 13:28:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=g0WYTMEDS/ILOe9fevPvjAjK85K9yL299KEBLUeq5Og=;
        b=itH7rozuNZzFublpxOsgy7ieTRJKIGDEQFzcrUiz4UXeB/tbDnXy/abxl9CNtl4FRa
         qE0lJoaC5ri3+tekkM9m2Bh03qGlwMgl/irdjdq3V/lFAkvDSjutcDsciZe+PF4ULLFH
         arWn0BanZPEAETGjmwZGEBf3ZIpq+hCOQqzW+6NSx3YRxYSz77zOokC0MvsM4w2Mc8aO
         WAeNZASesDtCeqNEM4jbKTObVJb35yKMrxaFPA/VKW5vtX2B+Dyub0EX1fx1ST4ylia7
         3fG0I7pq8pBJVlyaUxC2yT+zTzKYilQAM9apiJnvSB8L+MFu3gU/IOAZtv7BWqt1lSRl
         SHEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=g0WYTMEDS/ILOe9fevPvjAjK85K9yL299KEBLUeq5Og=;
        b=U5dxgFf88NZl/7hEHu6gXHNgv23PpNJt+lRkkaigCg1ykbrSZJfKZNsIeiDpZYQRGJ
         mITVUSFPs6mFLct+nXLtN+9iOdTCQVineCVCyXwjrd6lexaYhR4G+kEvL105iUSlofr5
         89MhVd0rmRLCWrNluorbE04Gz7+/ls8IosT1+iY5mUPDByRtMoFTKsSoHIPvg/zTGI4U
         6UzUpu46byMRSbj0e9NJ0SFFKY/YfD0HGW6XUWwtoZmhWDQEFD1IL5IHWdr+MI+/Bn5j
         VxafndBUJT4carC4/pN8hNzq/i4vFh7TmExZguyAJ0A6g8uwL3Yg122bvCrH2nSe7jUI
         skMg==
X-Gm-Message-State: APjAAAWk72z1bECZhuC7vBaNIOBpioMJA1kJ2pZOjeuWcsYf2IzmQ5QA
        8E6XSPW2po/ynGRrp2ogHKicBBOT
X-Google-Smtp-Source: APXvYqyq9PGKQ83OpJ38bpWlBu+i7wN+kysIZLFX/93QAiWranvtytnCIrtyq65fhC0RnjVB9QxJxg==
X-Received: by 2002:a1c:ca:: with SMTP id 193mr755627wma.103.1574717305179;
        Mon, 25 Nov 2019 13:28:25 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k20sm613956wmj.10.2019.11.25.13.28.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Nov 2019 13:28:24 -0800 (PST)
Message-Id: <pull.450.v5.git.1574717303.gitgitgadget@gmail.com>
In-Reply-To: <pull.450.v4.git.1574351516.gitgitgadget@gmail.com>
References: <pull.450.v4.git.1574351516.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 25 Nov 2019 21:28:21 +0000
Subject: [PATCH v5 0/2] commit-graph: use start_delayed_progress()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     ryenus@gmail.com, stolee@gmail.com, peff@peff.net,
        szeder.dev@gmail.com, Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks, Ryenus, for reporting this problem.

Update in V3:

Based on our discussion, I've added the suggested GIT_PROGRESS_DELAY
environment variable. This allowed the existing tests to stick around with
one exception in the GC tests. The test remains, but we can no longer look
at the commit-graph output.

Update in V4:

The GIT_PROGRESS_DELAY check is extracted to a helper method so it can be
used with start_delayed_sparse_progress().

Update in V5:

I took Peff's advice for using "env" to use this delay in the GC test.

Derrick Stolee (2):
  progress: create GIT_PROGRESS_DELAY
  commit-graph: use start_delayed_progress()

 Documentation/git.txt   |  4 ++++
 commit-graph.c          |  2 +-
 progress.c              | 15 +++++++++++++--
 t/t5318-commit-graph.sh |  4 ++--
 t/t6500-gc.sh           |  6 +++---
 5 files changed, 23 insertions(+), 8 deletions(-)


base-commit: da72936f544fec5a335e66432610e4cef4430991
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-450%2Fderrickstolee%2Fcommit-graph-progress-fix-v5
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-450/derrickstolee/commit-graph-progress-fix-v5
Pull-Request: https://github.com/gitgitgadget/git/pull/450

Range-diff vs v4:

 1:  a7acdf9c8f = 1:  a7acdf9c8f progress: create GIT_PROGRESS_DELAY
 2:  e62dcc1ce5 ! 2:  efe1419dc6 commit-graph: use start_delayed_progress()
     @@ -12,13 +12,9 @@
          commits are being added.
      
          The tests that check for the progress output have already been updated
     -    to use GIT_PROGRESS_DELAY=0 to force the expected output. However, there
     -    is one test in t6500-gc.sh that uses the test_terminal method. This
     -    mechanism does not preserve the GIT_PROGRESS_DELAY environment variable,
     -    so we need to modify check on the output. We still watch for the
     -    "Enumerating objects" progress but no longer look for "Computing
     -    commit graph generation numbers".
     +    to use GIT_PROGRESS_DELAY=0 to force the expected output.
      
     +    Helped-by: Jeff King <peff@peff.net>
          Reported-by: ryenus <ryenus@gmail.com>
          Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
      
     @@ -39,12 +35,12 @@
       --- a/t/t6500-gc.sh
       +++ b/t/t6500-gc.sh
      @@
     - test_expect_success TTY 'with TTY: gc --no-quiet' '
     - 	test_terminal git -c gc.writeCommitGraph=true gc --no-quiet >stdout 2>stderr &&
     - 	test_must_be_empty stdout &&
     --	test_i18ngrep "Enumerating objects" stderr &&
     --	test_i18ngrep "Computing commit graph generation numbers" stderr
     -+	test_i18ngrep "Enumerating objects" stderr
       '
       
     - test_expect_success 'gc --quiet' '
     + test_expect_success TTY 'with TTY: gc --no-quiet' '
     +-	test_terminal git -c gc.writeCommitGraph=true gc --no-quiet >stdout 2>stderr &&
     ++	test_terminal env GIT_PROGRESS_DELAY=0 \
     ++		git -c gc.writeCommitGraph=true gc --no-quiet >stdout 2>stderr &&
     + 	test_must_be_empty stdout &&
     + 	test_i18ngrep "Enumerating objects" stderr &&
     + 	test_i18ngrep "Computing commit graph generation numbers" stderr

-- 
gitgitgadget
