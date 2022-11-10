Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83E37C4332F
	for <git@archiver.kernel.org>; Thu, 10 Nov 2022 19:08:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231640AbiKJTIB (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Nov 2022 14:08:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231524AbiKJTHb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Nov 2022 14:07:31 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41C3759877
        for <git@vger.kernel.org>; Thu, 10 Nov 2022 11:06:13 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id a11-20020a05600c2d4b00b003cf6f5fd9f1so1787925wmg.2
        for <git@vger.kernel.org>; Thu, 10 Nov 2022 11:06:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jtq3iPEAnMV1G7hru853ch69TOxtztyX7mt4g8SPMWI=;
        b=U//loJ6554iORdttasDemUim20sVejuN0pE6gsh9pMHVCJ144zmXp3s+s/A7ZJH6fl
         4bM3pP0Oz0ekUBwd1dsEhieKP8NHTthCapFVxOUYSLK9kUepzk+HEHHDFkffX+5RQOIk
         zCJrv/jA/7S0NUzPPrBERN57hIlEMvNOw0MxipGa1CKNVoIDheVaZM7itj3XvYrwxDz8
         FIsMpz01v88UWHDIfvMV4idVLu6s/wJC7ikMx2IGAFp3ZmTlMr1VS3EmFYJS4Fn7/SaN
         oXqjCdssBLfMWpDZiH2J9l1U1Qg9vESJ7FK1ilfMbvoLRxGktACfGpswVckTu7d4gZ/p
         yldw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jtq3iPEAnMV1G7hru853ch69TOxtztyX7mt4g8SPMWI=;
        b=kj3WMvztOiWdezF8L3Z+c3+zHyk11Ku3nBnIfVSnmJdq8FTFjpM5p4pQnyei1wEt0G
         h9j4h43CtoBmh7Uq8TFUT4pmqVxrSsApFRjNpaAH0cq/QNc5Q9XNS0MiyyCd6wiDOOd0
         GHGeKxkTLe0yjJ4ZfYG6LPyCodcdl4HzyKOM5U8jHXN3Oj2JvWqymAuqgWU6qwq8Dwdj
         3LS05ftKjB7GrTL15v6bvNm9YNRH4Xf4Zwk9IJ9HL0S7R9bXklnB0+PwZG4nxhITShxe
         yeA4V5TSIRXJkzPtj20tX4WISAy3CuJGJPTLenfkEyMQBVfYYeM1sXwSq8OJVxlHaBA/
         1KDA==
X-Gm-Message-State: ACrzQf0NyUknjC21TuAOQaPJpp4YedpVFDkX/z2RglYmJwgICsy7J/nV
        3MHbOguSk9H2MKhUhllw8a5WgXFIYRE=
X-Google-Smtp-Source: AMsMyM4jPaow4eE8ZKov8s1nvMK5TvJ891f6VKUyOysw32wqinZbVII+URlF6Ok1URjzV7TTDsgMLg==
X-Received: by 2002:a05:600c:2c4b:b0:3cf:9cd9:a850 with SMTP id r11-20020a05600c2c4b00b003cf9cd9a850mr21789118wmg.135.1668107171472;
        Thu, 10 Nov 2022 11:06:11 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id bd10-20020a05600c1f0a00b003cfbe1da539sm385352wmb.36.2022.11.10.11.06.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Nov 2022 11:06:10 -0800 (PST)
Message-Id: <386f18ca36a9ffc15917c8bcc877769c7c1db7be.1668107165.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1411.v3.git.1668107165.gitgitgadget@gmail.com>
References: <pull.1411.v2.git.1668045438.gitgitgadget@gmail.com>
        <pull.1411.v3.git.1668107165.gitgitgadget@gmail.com>
From:   "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 10 Nov 2022 19:06:03 +0000
Subject: [PATCH v3 3/5] reset: use 'skip_cache_tree_update' option
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, phillip.wood123@gmail.com,
        derrickstolee@github.com, jonathantanmy@google.com,
        szeder.dev@gmail.com, Taylor Blau <me@ttaylorr.com>,
        Victoria Dye <vdye@github.com>, Victoria Dye <vdye@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Victoria Dye <vdye@github.com>

Enable the 'skip_cache_tree_update' option in the variants that call
'prime_cache_tree()' after 'unpack_trees()' (specifically, 'git reset
--mixed' and 'git reset --hard'). This avoids redundantly rebuilding the
cache tree in both 'cache_tree_update()' at the end of 'unpack_trees()' and
in 'prime_cache_tree()', resulting in a small (but consistent) performance
improvement. From the newly-added 'p7102-reset.sh' test:

Test                         before            after
--------------------------------------------------------------------
7102.1: reset --hard (...)   2.11(0.40+1.54)   1.97(0.38+1.47) -6.6%

Signed-off-by: Victoria Dye <vdye@github.com>
---
 builtin/reset.c       |  2 ++
 t/perf/p7102-reset.sh | 21 +++++++++++++++++++++
 2 files changed, 23 insertions(+)
 create mode 100755 t/perf/p7102-reset.sh

diff --git a/builtin/reset.c b/builtin/reset.c
index fdce6f8c856..ab027774824 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -73,9 +73,11 @@ static int reset_index(const char *ref, const struct object_id *oid, int reset_t
 	case HARD:
 		opts.update = 1;
 		opts.reset = UNPACK_RESET_OVERWRITE_UNTRACKED;
+		opts.skip_cache_tree_update = 1;
 		break;
 	case MIXED:
 		opts.reset = UNPACK_RESET_PROTECT_UNTRACKED;
+		opts.skip_cache_tree_update = 1;
 		/* but opts.update=0, so working tree not updated */
 		break;
 	default:
diff --git a/t/perf/p7102-reset.sh b/t/perf/p7102-reset.sh
new file mode 100755
index 00000000000..9b039e8691f
--- /dev/null
+++ b/t/perf/p7102-reset.sh
@@ -0,0 +1,21 @@
+#!/bin/sh
+
+test_description='performance of reset'
+. ./perf-lib.sh
+
+test_perf_default_repo
+test_checkout_worktree
+
+test_perf 'reset --hard with change in tree' '
+	base=$(git rev-parse HEAD) &&
+	test_commit --no-tag A &&
+	new=$(git rev-parse HEAD) &&
+
+	for i in $(test_seq 10)
+	do
+		git reset --hard $new &&
+		git reset --hard $base || return $?
+	done
+'
+
+test_done
-- 
gitgitgadget

