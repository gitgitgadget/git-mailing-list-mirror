Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88BB8ECAAD8
	for <git@archiver.kernel.org>; Wed, 31 Aug 2022 06:22:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230143AbiHaGV6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 31 Aug 2022 02:21:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229948AbiHaGV4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Aug 2022 02:21:56 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E08FA6F256
        for <git@vger.kernel.org>; Tue, 30 Aug 2022 23:21:53 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id s7so1964360wro.2
        for <git@vger.kernel.org>; Tue, 30 Aug 2022 23:21:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc;
        bh=Tv6PjYE6sNwuX1EqJyBhEJ1FrXrzXR2BtekSGNvTAK0=;
        b=CfT9DgwYVWFFuAAeRMU9Bt0vnuM05Wj5GEgyjqL2laMWoFWCShipPRMt/0YfY/3HxN
         F3+7irwxR1WDEq5ckOSdBYrlZdoWgthXWerlgOpGAWl1jEUbnKj6zeB4aWgrd9hSrMz8
         BfN2NvNi0/hPxZuS9fvspY9MH9/xG0vxh9ZrY4uat6Xk7V+HCHPAYze52sEHz2dV1kO3
         X5VeTh14wU41sGpzTm2zjaEmi15S6r4Zk4jrDl5atR3qjp6WuqbegT655+p9gnuEtar2
         XjS+L6tfwLU6NHclnSck7ET8ANeKud8t4lehcSkWCIxyRcRGsPvv9F7OTZvDnQkolt3U
         8QAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc;
        bh=Tv6PjYE6sNwuX1EqJyBhEJ1FrXrzXR2BtekSGNvTAK0=;
        b=vkmuNUuRJL0Mgbx8m5ucLa0Y0cohVegJym50GTtKNSTrYzwFOhJJ1i+7j3KfIfaDc2
         nWYbuQR60rK/XRbULOwHYVXL9Ab1S2X/CzNqh1vrzTBNnFIkEFyIkNkP3TUGOlItii18
         E0G/4f4T8D5qZ3qTQKH9nESHfpe98WTO+wabJymSMfMZGzcdoO98dok4OCpP7hHNhQuL
         6NRgvzZ4A6UCCorgnk79odz3OYvYQgChDXCL7EcyHO84ekXzKqOJ6c4pJgz3KzBnI+bL
         ulswwTU8hgRXilC0RsRLDqCfgo6xRet+NXnULD9xxnurHPRwtbGfoNPvRe/9rKf/hT5y
         aSWA==
X-Gm-Message-State: ACgBeo3/8a1i/+TVVxtd9Qk36jXlKxRKSfQT0fLAN+Z+Ho+InDi6YoxP
        iSPzR855oqch+tnT5LkqUZGGLAHsRIE=
X-Google-Smtp-Source: AA6agR7TrhgmFQPqOqY3z+lzXba45Z6UNUM9vrn59/aUPUgckUIGaHn/uor9SHudeocg8D7Ajg2qeA==
X-Received: by 2002:a5d:630f:0:b0:225:617c:8076 with SMTP id i15-20020a5d630f000000b00225617c8076mr11042116wru.692.1661926912182;
        Tue, 30 Aug 2022 23:21:52 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n19-20020a05600c3b9300b003a846a014c1sm1178018wms.23.2022.08.30.23.21.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Aug 2022 23:21:51 -0700 (PDT)
Message-Id: <e4414cf630da284bdb11f5613ca0ce6413c6a443.1661926908.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1342.git.1661926908.gitgitgadget@gmail.com>
References: <pull.1342.git.1661926908.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 31 Aug 2022 06:21:46 +0000
Subject: [PATCH 1/3] diff: have submodule_format logic avoid additional diff
 headers
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
paths", 2022-02-02) introduced the possibility of additional headers,
created in create_filepairs_for_header_only_notifications().  These are
represented by inserting additional pairs in diff_queued_diff which
always have a mode of 0 and a null_oid.  When these were added, one
code path was noted to assume that at least one of the diff_filespecs
in the pair were valid, and that codepath was corrected.

The submodule_format handling is another codepath with the same issue;
it would operate on these additional headers and attempt to display them
as submodule changes.  Prevent that by explicitly checking for both
modes being 0.

Reported-by: Philippe Blain <levraiphilippeblain@gmail.com>
Signed-off-by: Elijah Newren <newren@gmail.com>
---
 diff.c                  | 6 ++++--
 t/t4069-remerge-diff.sh | 8 ++++++++
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/diff.c b/diff.c
index 974626a6211..be23f660570 100644
--- a/diff.c
+++ b/diff.c
@@ -3429,14 +3429,16 @@ static void builtin_diff(const char *name_a,
 
 	if (o->submodule_format == DIFF_SUBMODULE_LOG &&
 	    (!one->mode || S_ISGITLINK(one->mode)) &&
-	    (!two->mode || S_ISGITLINK(two->mode))) {
+	    (!two->mode || S_ISGITLINK(two->mode)) &&
+	    (one->mode || two->mode)) {
 		show_submodule_diff_summary(o, one->path ? one->path : two->path,
 				&one->oid, &two->oid,
 				two->dirty_submodule);
 		return;
 	} else if (o->submodule_format == DIFF_SUBMODULE_INLINE_DIFF &&
 		   (!one->mode || S_ISGITLINK(one->mode)) &&
-		   (!two->mode || S_ISGITLINK(two->mode))) {
+		   (!two->mode || S_ISGITLINK(two->mode)) &&
+		   (one->mode || two->mode)) {
 		show_submodule_inline_diff(o, one->path ? one->path : two->path,
 				&one->oid, &two->oid,
 				two->dirty_submodule);
diff --git a/t/t4069-remerge-diff.sh b/t/t4069-remerge-diff.sh
index 9e7cac68b1c..e3e6fbd97b2 100755
--- a/t/t4069-remerge-diff.sh
+++ b/t/t4069-remerge-diff.sh
@@ -185,6 +185,14 @@ test_expect_success 'remerge-diff w/ diff-filter=U: all conflict headers, no dif
 	test_cmp expect actual
 '
 
+test_expect_success 'submodule formatting ignores additional headers' '
+	# Reuses "expect" from last testcase
+
+	git show --oneline --remerge-diff --diff-filter=U --submodule=log >tmp &&
+	sed -e "s/[0-9a-f]\{7,\}/HASH/g" tmp >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'remerge-diff w/ diff-filter=R: relevant file + conflict header' '
 	git log -1 --oneline resolution >tmp &&
 	cat <<-EOF >>tmp &&
-- 
gitgitgadget

