Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 249EEC0502A
	for <git@archiver.kernel.org>; Wed, 31 Aug 2022 06:22:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230156AbiHaGWD (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 31 Aug 2022 02:22:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbiHaGV5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Aug 2022 02:21:57 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36A61BD0A7
        for <git@vger.kernel.org>; Tue, 30 Aug 2022 23:21:56 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id i188-20020a1c3bc5000000b003a7b6ae4eb2so6126300wma.4
        for <git@vger.kernel.org>; Tue, 30 Aug 2022 23:21:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc;
        bh=FbAzcYrfg8wQJJ1BMIBW8a/ealwSpSlEigebpgIFtY0=;
        b=KZYUHTCxqyvYn12X/FG5eH0orSdC+D5dFH2r+p72S4YZ49XCI7Yvt+1t9m/YNMLNg7
         1Q2F93IJuTOpbqEUtc4E0LPHMt7tbA6AoUAZiUEn96HFPmY4DEZMmQ7FT32jY/E2M8Bc
         DlMIIqa/JB3w+2DIBEN1+dGrW4oj7UfmeZxWOXaJ5W4EaISMKuGQz3U8zu6Z+v3uQmCM
         W7+d8FKzf6gmMscsqhHD5OEzjwzhGE48HJPGhZx9jCLNi+8bfYlZLi0srccihokGZiuH
         4Q15Ii5oHDtR+J7+psTvTWOLAo25aRmgOn69rfpEZMfzLnjUqiTdNtOWwwGfU2V83Pcp
         FJcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc;
        bh=FbAzcYrfg8wQJJ1BMIBW8a/ealwSpSlEigebpgIFtY0=;
        b=RWwRr/I6g4BOsekVjCSSkHm/QkRq2U0wVAT6X/pZRHCj+NP//5Q/RK/LqZO5x/b9/B
         sRmFyls/Wo15JQTGnAaj4k5Qr0gmMhkj4WY7brPNiX/3C0zfqp6GQcegPqBtzm3dz5/K
         yloYHjxOQKdf0xBDkHAUIH7YzEi9GIE75/s4W6IWZQQHNAlm+idUplRNEOVHhOcLmsqf
         kEVNxv/hQAOn2UvRzbt9yMEYU0S5L3Esoz6Dsx7U712au+nj1ZOWOeIwKjJTDj/5Iwph
         o6D4/YKZL3RsE29OlyPhRKsAmz3iXMu0bGn4pOjXlRHtAJhxRBbqY1T1pXiDz65hVQOa
         /MZQ==
X-Gm-Message-State: ACgBeo0syn23/oLqWX4iPXnMUgdAwSSbzeKVzfRwyG32RVo8cKvUQsEI
        DyplRBtmpokFGNe2YdJicOk69c6D3Zs=
X-Google-Smtp-Source: AA6agR6wQP9olATzqK1AZDd/YUGnivgebY0eClm2iDhoyAFz4ZrTIuh4N8VICKoumGL6CO4Efb2E+g==
X-Received: by 2002:a05:600c:2c47:b0:3a6:4623:4ccf with SMTP id r7-20020a05600c2c4700b003a646234ccfmr929088wmg.85.1661926914512;
        Tue, 30 Aug 2022 23:21:54 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c6-20020adffb06000000b002250c35826dsm11087610wrr.104.2022.08.30.23.21.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Aug 2022 23:21:53 -0700 (PDT)
Message-Id: <46ea0d7dd6555dbb9939940207fa2c8044d0ab56.1661926908.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1342.git.1661926908.gitgitgadget@gmail.com>
References: <pull.1342.git.1661926908.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 31 Aug 2022 06:21:48 +0000
Subject: [PATCH 3/3] diff: fix filtering of merge commits under --remerge-diff
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Philippe Blain <levraiphilippeblain@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Commit 95433eeed9 ("diff: add ability to insert additional headers for
paths", 2022-02-02) introduced the possibility of additional headers.
Because there could be conflicts with no content differences (e.g. a
modify/delete conflict resolved in favor of taking the modified file
as-is), that commit also modified the diff_queue_is_empty() and
diff_flush_patch() logic to ensure these headers were included even if
there was no associated content diff.

However, the added logic was a bit inconsistent between these two
functions.  diff_queue_is_empty() overlooked the fact that the
additional headers strmap could be non-NULL and empty, which would cause
it to display commits that should have been filtered out.

Fix the diff_queue_is_empty() logic to also account for
additional_path_headers being empty.

Reported-by: Philippe Blain <levraiphilippeblain@gmail.com>
Signed-off-by: Elijah Newren <newren@gmail.com>
---
 diff.c                  | 1 +
 t/t4069-remerge-diff.sh | 5 +++++
 2 files changed, 6 insertions(+)

diff --git a/diff.c b/diff.c
index 9535e755c73..f5c0e0599c9 100644
--- a/diff.c
+++ b/diff.c
@@ -5910,6 +5910,7 @@ int diff_queue_is_empty(struct diff_options *o)
 	int i;
 	int include_conflict_headers =
 	    (o->additional_path_headers &&
+	     strmap_get_size(o->additional_path_headers) &&
 	     !o->pickaxe_opts &&
 	     (!o->filter || filter_bit_tst(DIFF_STATUS_UNMERGED, o)));
 
diff --git a/t/t4069-remerge-diff.sh b/t/t4069-remerge-diff.sh
index 95a16d19aec..07323ebafe0 100755
--- a/t/t4069-remerge-diff.sh
+++ b/t/t4069-remerge-diff.sh
@@ -56,6 +56,11 @@ test_expect_success 'remerge-diff on a clean merge' '
 	test_cmp expect actual
 '
 
+test_expect_success 'remerge-diff on a clean merge with a filter' '
+	git show --oneline --remerge-diff --diff-filter=U bc_resolution >actual &&
+	test_must_be_empty actual
+'
+
 test_expect_success 'remerge-diff with both a resolved conflict and an unrelated change' '
 	git log -1 --oneline ab_resolution >tmp &&
 	cat <<-EOF >>tmp &&
-- 
gitgitgadget
