Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9664CC67871
	for <git@archiver.kernel.org>; Mon, 24 Oct 2022 21:55:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230020AbiJXVzx (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Oct 2022 17:55:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231462AbiJXVzX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Oct 2022 17:55:23 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87580D73C0
        for <git@vger.kernel.org>; Mon, 24 Oct 2022 13:09:11 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id l14-20020a05600c1d0e00b003c6ecc94285so34021wms.1
        for <git@vger.kernel.org>; Mon, 24 Oct 2022 13:09:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XDiTOXUGdKhpxdMZy+MPQMIrlEQ28JbmaVB9D6yDnM4=;
        b=LVyWuVQ5uOK8TwVt4PQ0v0S3AjaTN5Nfwr4o+TPHkpgPeBWa/qfsqrrvA1nDRpR15u
         MZHJSKGLQ7+oEzK9Q7aOPqFiV16IGXN+cMKw2Jshm8aREkolHdoyIoVLxe15L1cvWQ+r
         vp0gkGzwmiWn3F9QJYrvEF5LAUYR/0UQJaXjgR0FHLI9yo9LP7YK7pHNG0DiIcZ+ztul
         8pOEvPtR/7IcmD3vLJ4vnis/rNzJXfdSsCMLIKvnnPXQCzfhBXHECh2tiraYjViWPPi9
         Y89N6mXbfCsdLQ30lz/slZTQuOnze3jbw99mcrYmZl+gTf/9MJWv7IOzrO7i0yihm+0a
         tDHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XDiTOXUGdKhpxdMZy+MPQMIrlEQ28JbmaVB9D6yDnM4=;
        b=CnbLwY0bN4s9F394TrPb/Wzfl91WQgw/E7WF/uZ+J6DP2FwXHhB+sOOaxFPMmVbpKe
         nHm5kLvT9dOwsUGSu4rAxt3t/n+/MxwR3NbsFm/ySFeR2x7EwSonoARHWE2kJX20cO5Z
         76TuCDiruGcbcSp1vIYvI+0zL7Kq7GVEhpzlcyxk4A7egnBXXJulcdupHgHM4eYQ41DP
         NoWO5ziOvhOfAB18XWgK+pnVDUPBdmdY8H3fiPf7p9zbvoK30kNNC2QHbHEh+JGNVaLX
         Hg+0K6R6KG2NzmfFNUYAoBU+1AitrPQtw/bj1IKy3X+K/jE+Wovm8r/lg/BGzTpoY8m5
         XJOg==
X-Gm-Message-State: ACrzQf2UKdVVWxNzKK0hxbz1fJvphRJv2YH+ywmBSNxzrx81GCwmgzDe
        gWUZemThQVhgWlOS/s14fSvRAjJ3zQQ=
X-Google-Smtp-Source: AMsMyM7n4hb5D6bLs/V7ogKsphKGHR7dMZXjOtEjYJcEXO362YCd0a9VwBhg53U/6kVJdiH8+SvIoA==
X-Received: by 2002:a05:600c:4e8a:b0:3c6:de26:9d6e with SMTP id f10-20020a05600c4e8a00b003c6de269d6emr23996296wmq.117.1666642070514;
        Mon, 24 Oct 2022 13:07:50 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l3-20020adfa383000000b002366eb01e07sm487686wrb.114.2022.10.24.13.07.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Oct 2022 13:07:49 -0700 (PDT)
Message-Id: <815013553133cddae5baf9d3dca00f8318e250f7.1666642065.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1359.v5.git.1666642064.gitgitgadget@gmail.com>
References: <pull.1359.v4.git.1666307815.gitgitgadget@gmail.com>
        <pull.1359.v5.git.1666642064.gitgitgadget@gmail.com>
From:   "Jerry Zhang via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 24 Oct 2022 20:07:41 +0000
Subject: [PATCH v5 3/6] builtin: patch-id: fix patch-id with binary diffs
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

