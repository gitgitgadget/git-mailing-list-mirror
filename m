Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40FBAC433FE
	for <git@archiver.kernel.org>; Fri, 14 Oct 2022 08:57:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230005AbiJNI5B (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Oct 2022 04:57:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbiJNI4w (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Oct 2022 04:56:52 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17E8014EC4B
        for <git@vger.kernel.org>; Fri, 14 Oct 2022 01:56:51 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id bg9-20020a05600c3c8900b003bf249616b0so3071502wmb.3
        for <git@vger.kernel.org>; Fri, 14 Oct 2022 01:56:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=THN3lZr8Afgc/s1qPGU8HeL91Zw6FhoarpmRRTK7ABM=;
        b=HwLFxkm2ExxQqfubtbJRS9GdnA1kMQyOqqEDjeqWYGXpRScYgTFWwjtL8OOHvhd+ev
         CRS0WgOkKTpZROBWYqU4S9VR9ExYjsz09by4JVxOFitmyKlQaAF5hZcoJYZfxCg+1PTv
         TWkztqyKHc2imPf0wDR3kENA2jSA2mIUU6MT/Gqi0YpKW3oQViGMXOa8PdJVWz4F1xqY
         5X6yH35YbCYbvn0s1WtG1PKaWPKBfJq9S/cjTfZeB+SCGWcU56bzSufNMQMdBzWS9FFh
         I2vw6crYQPBN2Uvwod4x0DMX7L7oA9SP0suGxDPYN3HwVsCubV3ioxImvyb0Dusa3dQA
         TO0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=THN3lZr8Afgc/s1qPGU8HeL91Zw6FhoarpmRRTK7ABM=;
        b=mupY+vleCzQDBmMdDAdrh62fyx7aulBruccBDyRkS/v4zcM/UXmalr5GTEpawrgyOu
         ocR1HzSShi325yV+sOFDzYdN9AUiYLxKHawJIRsP6YEaI3W1KP0rlA5eTCAe1FQEfNZ3
         g00V3UyDYKB0J6N1XyPxwyxeM8onazLRsA7tkv8YYDWngPf3A6g6gq4ysk4ECxy2Dwo8
         ZgaueGQ3zrTLXFGStAgrW4v3uoWCoa4ylhSE/SciOla6PSsCYyoOcAlRiq5zyqdgpi9q
         A5CurEL1TpW1vPsuryvsR3A4T2ctuOijHtI4z1q330QiY0NpyZf/ScUMF3cx36Js/hqN
         38Kw==
X-Gm-Message-State: ACrzQf0BwDU1V2DzQRtBNg1Fbou2TNHJ/Cwnn7BhUJP7NV7yRhzCA2SI
        qHz7oSJGRxVxRtWs5S/ptaCwP38mfGE=
X-Google-Smtp-Source: AMsMyM6CW+fLAzOPFigUU2m8COUs4gw8bpPBv2ye/PB0mRO+AUYPvrKsq5EsinSgBFXezd/5dvRUWg==
X-Received: by 2002:a05:600c:3b22:b0:3c3:e25:f9e with SMTP id m34-20020a05600c3b2200b003c30e250f9emr2690365wms.183.1665737809256;
        Fri, 14 Oct 2022 01:56:49 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z10-20020a05600c0a0a00b003a2f2bb72d5sm9396893wmp.45.2022.10.14.01.56.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Oct 2022 01:56:48 -0700 (PDT)
Message-Id: <2164212892712930cb34223499bb3e03bf2c2392.1665737804.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1359.v3.git.1665737804.gitgitgadget@gmail.com>
References: <pull.1359.v2.git.1663654859.gitgitgadget@gmail.com>
        <pull.1359.v3.git.1665737804.gitgitgadget@gmail.com>
From:   "Jerry Zhang via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 14 Oct 2022 08:56:40 +0000
Subject: [PATCH v3 3/7] builtin: patch-id: fix patch-id with binary diffs
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jerry Zhang <jerry@skydio.com>, Jerry Zhang <Jerry@skydio.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jerry Zhang <Jerry@skydio.com>

"git patch-id" currently doesn't produce correct output if the
incoming diff has any binary files. Add logic to
get_one_patchid to handle the different possible styles of binary
diff. This attempts to keep resulting patch-ids identical to what
would be produced by the counterpart logic in diff.c, that is it
produces the id by hashing the a and b oids in succession.

In general we handle binary diffs by first caching the object ids from
the "index" line and using those if we then find an indication
that the diff is binary.

The input could contain patches generated with "git diff --binary". This
currently breaks the parse logic and results in multiple patch-ids
output for a single commit. Here we have to skip the contents of the
patch itself since those do not go into the patch id. --binary
implies --full-index so the object ids are always available.

When the diff is generated with --full-index there is no patch content
to skip over.

When a diff is generated without --full-index or --binary, it will
contain abbreviated object ids. This will still result in a sufficiently
unique patch-id when hashed, but does not match internal patch id
output. We'll call this ok for now as we already need specialized
arguments to diff in order to match internal patch id (namely -U3).

Signed-off-by: Jerry Zhang <Jerry@skydio.com>
---
 builtin/patch-id.c  | 36 ++++++++++++++++++++++++++++++++++--
 t/t4204-patch-id.sh | 29 ++++++++++++++++++++++++++++-
 2 files changed, 62 insertions(+), 3 deletions(-)

diff --git a/builtin/patch-id.c b/builtin/patch-id.c
index 881fcf32732..e7a31123142 100644
--- a/builtin/patch-id.c
+++ b/builtin/patch-id.c
@@ -61,6 +61,8 @@ static int get_one_patchid(struct object_id *next_oid, struct object_id *result,
 {
 	int patchlen = 0, found_next = 0;
 	int before = -1, after = -1;
+	int diff_is_binary = 0;
+	char pre_oid_str[GIT_MAX_HEXSZ + 1], post_oid_str[GIT_MAX_HEXSZ + 1];
 	git_hash_ctx ctx;
 
 	the_hash_algo->init_fn(&ctx);
@@ -88,14 +90,44 @@ static int get_one_patchid(struct object_id *next_oid, struct object_id *result,
 
 		/* Parsing diff header?  */
 		if (before == -1) {
-			if (starts_with(line, "index "))
+			if (starts_with(line, "GIT binary patch") ||
+			    starts_with(line, "Binary files")) {
+				diff_is_binary = 1;
+				before = 0;
+				the_hash_algo->update_fn(&ctx, pre_oid_str,
+							 strlen(pre_oid_str));
+				the_hash_algo->update_fn(&ctx, post_oid_str,
+							 strlen(post_oid_str));
+				if (stable)
+					flush_one_hunk(result, &ctx);
 				continue;
-			else if (starts_with(line, "--- "))
+			} else if (skip_prefix(line, "index ", &p)) {
+				char *oid1_end = strstr(line, "..");
+				char *oid2_end = NULL;
+				if (oid1_end)
+					oid2_end = strstr(oid1_end, " ");
+				if (!oid2_end)
+					oid2_end = line + strlen(line) - 1;
+				if (oid1_end != NULL && oid2_end != NULL) {
+					*oid1_end = *oid2_end = '\0';
+					strlcpy(pre_oid_str, p, GIT_MAX_HEXSZ + 1);
+					strlcpy(post_oid_str, oid1_end + 2, GIT_MAX_HEXSZ + 1);
+				}
+				continue;
+			} else if (starts_with(line, "--- "))
 				before = after = 1;
 			else if (!isalpha(line[0]))
 				break;
 		}
 
+		if (diff_is_binary) {
+			if (starts_with(line, "diff ")) {
+				diff_is_binary = 0;
+				before = -1;
+			}
+			continue;
+		}
+
 		/* Looking for a valid hunk header?  */
 		if (before == 0 && after == 0) {
 			if (starts_with(line, "@@ -")) {
diff --git a/t/t4204-patch-id.sh b/t/t4204-patch-id.sh
index a730c0db985..cdc5191aa8d 100755
--- a/t/t4204-patch-id.sh
+++ b/t/t4204-patch-id.sh
@@ -42,7 +42,7 @@ calc_patch_id () {
 }
 
 get_top_diff () {
-	git log -p -1 "$@" -O bar-then-foo --
+	git log -p -1 "$@" -O bar-then-foo --full-index --
 }
 
 get_patch_id () {
@@ -61,6 +61,33 @@ test_expect_success 'patch-id detects inequality' '
 	get_patch_id notsame &&
 	! test_cmp patch-id_main patch-id_notsame
 '
+test_expect_success 'patch-id detects equality binary' '
+	cat >.gitattributes <<-\EOF &&
+	foo binary
+	bar binary
+	EOF
+	get_patch_id main &&
+	get_patch_id same &&
+	git log -p -1 --binary main >top-diff.output &&
+	calc_patch_id <top-diff.output main_binpatch &&
+	git log -p -1 --binary same >top-diff.output &&
+	calc_patch_id <top-diff.output same_binpatch &&
+	test_cmp patch-id_main patch-id_main_binpatch &&
+	test_cmp patch-id_same patch-id_same_binpatch &&
+	test_cmp patch-id_main patch-id_same &&
+	test_when_finished "rm .gitattributes"
+'
+
+test_expect_success 'patch-id detects inequality binary' '
+	cat >.gitattributes <<-\EOF &&
+	foo binary
+	bar binary
+	EOF
+	get_patch_id main &&
+	get_patch_id notsame &&
+	! test_cmp patch-id_main patch-id_notsame &&
+	test_when_finished "rm .gitattributes"
+'
 
 test_expect_success 'patch-id supports git-format-patch output' '
 	get_patch_id main &&
-- 
gitgitgadget

