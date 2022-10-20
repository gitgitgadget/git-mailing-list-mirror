Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31090C43217
	for <git@archiver.kernel.org>; Thu, 20 Oct 2022 23:17:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229930AbiJTXRN (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Oct 2022 19:17:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229845AbiJTXRD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Oct 2022 19:17:03 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EB6022EE1D
        for <git@vger.kernel.org>; Thu, 20 Oct 2022 16:17:02 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id f11so1570699wrm.6
        for <git@vger.kernel.org>; Thu, 20 Oct 2022 16:17:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XDiTOXUGdKhpxdMZy+MPQMIrlEQ28JbmaVB9D6yDnM4=;
        b=erW0xKBQT7rqBsqRnKN17eeEG+jsUVBcGlv1Ay5snipgLIWjMODYiUcpG4ibMlxy4x
         FnIrHnbXzNN64GovBdCPUQOHlmxZtDSa5dx9izHfPkdpzxToGHsYrERrhVDdNxAkeK5h
         cpNVSAYSh2QZS2NvMMkgKDMBBLWwd/wP8iq3OjwuWJBye8XWdvnVhX1CrY/+/IRlxcbt
         mNH0Rq2RiRvx8YKTgWRuNIJ+F0ANKDhKYLew1pXdsSqQWZZANkj61NMnzs78j/XG0pSz
         CUj0seLo0AA6Kg9UMqMQUUo+Ah6J96Zes2ZQ1MKcMtfo160oSyaHCK9pxV6rNuetkyp9
         PIxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XDiTOXUGdKhpxdMZy+MPQMIrlEQ28JbmaVB9D6yDnM4=;
        b=LIgQL9w9c/BWmQSxuEsgqDT+wtn0hv03yKruO/reWKfA2m3Sf+IcolOZt908ALmxWv
         LcC8/5s4yphFfdLd7fY35LQtiK+psWWGQ3nw2irvBDsCd/0+84UmYjxuSf0cyFAplfLs
         S+YgTomwNgc4uinEtGAWb8nw5h6EaX13TEYPTpkE5VJ0Wvh/tpI1WcCOKfdF9OXJGkG1
         umMQRlmJ9N+BhE2tufQ1/xagBtTKPIQmixzX06zY3TUPO5z25+XvcWtJQ2mWykqPOid1
         zMiNI6q5cZNaJunUPGtWLmbH4rO2w+BbU8Hlae7NOorgR/odBcr8bH5gT0dcnSJO/je/
         qZrQ==
X-Gm-Message-State: ACrzQf0wAf5WfXtWW+q92kdIlngulkzlt2tXBtmhd7ovOPYmSGc9o4FI
        gyfgo5ssHJKbbDTFGHiV/c76GqZsKNU=
X-Google-Smtp-Source: AMsMyM5wrkmaeW4JZm/3uAIQo8H/3aC5RdRLWWK3rvW/KtNsgVEetOn8kTEE08cRcpu10Z663TyUQA==
X-Received: by 2002:a05:6000:912:b0:230:9113:1a09 with SMTP id bz18-20020a056000091200b0023091131a09mr10270208wrb.707.1666307820795;
        Thu, 20 Oct 2022 16:17:00 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id bw17-20020a0560001f9100b0022afedf3c87sm3673703wrb.105.2022.10.20.16.17.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Oct 2022 16:17:00 -0700 (PDT)
Message-Id: <815013553133cddae5baf9d3dca00f8318e250f7.1666307815.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1359.v4.git.1666307815.gitgitgadget@gmail.com>
References: <pull.1359.v3.git.1665737804.gitgitgadget@gmail.com>
        <pull.1359.v4.git.1666307815.gitgitgadget@gmail.com>
From:   "Jerry Zhang via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 20 Oct 2022 23:16:52 +0000
Subject: [PATCH v4 3/6] builtin: patch-id: fix patch-id with binary diffs
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
incoming diff has any binary files. Add logic to get_one_patchid
to handle the different possible styles of binary diff. This
attempts to keep resulting patch-ids identical to what would be
produced by the counterpart logic in diff.c, that is it produces
the id by hashing the a and b oids in succession.

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

