Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DDA9FA373D
	for <git@archiver.kernel.org>; Mon, 24 Oct 2022 21:55:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231428AbiJXVzf (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Oct 2022 17:55:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231458AbiJXVzT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Oct 2022 17:55:19 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ACCA3B978
        for <git@vger.kernel.org>; Mon, 24 Oct 2022 13:09:07 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id b20-20020a05600c4e1400b003cc28585e2fso3953832wmq.1
        for <git@vger.kernel.org>; Mon, 24 Oct 2022 13:09:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sp9Tg5X1RJCYKhvef62590LNA9REDWAdl/Lhvjci9/c=;
        b=bzdvrylCLTO9oMbVns2Ck+MeePn/KMnhYDckkznQTkJYNMwq2prXHDV0sBic3pnwNz
         sfcAQcvoWHsFfVdBl1BkI6O9gNUBFDG4QxuQuyEd+CG48Si7O1IZw4uWdIDrq138oiPh
         VNCpdoO403ig/5qtFNCTXoz30W5lkVOeOk666Ug3OdEJjuALZcTHnU9Kt0UXDFzHrGBA
         c+sUB76HieQEvpf0/Oa3sq/g2kj2+RhRSZjVp+scren9RBsWmA5ec28yqyd+BTEN1hWC
         4Jbd4f16So9lA/Q2sm0D30J7Hb4a115bQDQzBOmJNcCdeB/g8Mr7ZzXTH1PBM4d5rDin
         zvlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Sp9Tg5X1RJCYKhvef62590LNA9REDWAdl/Lhvjci9/c=;
        b=Ll+DO51ZKNnVsCApkE7/zI5KkIhCYKMjsz6ewcSbeMO/QKingBqZmm1txL2RfKWOtg
         Z3vYyqaThLhqwB+IoGD0hJq4t3LKGWnarthoR8w2S7O1aaQOZJ1xNuIvk2GaVqMJUrI7
         DGiOhax/F9UOCDU/CHWS/oaKPcXAILc1H2JWY9lwtFe+koNdz4vQIBqEeJYqnMfzDp81
         oQMvCxK4MVp+y59Y6PenP2PadmG8YA6uRh6e0hBhyX/tA4cRpvANCxxWLhHfNkPgPOYB
         RQHkQu89ianxllPYKGbtQvNXVcl6vtweoNDAWwsYUAi68D4W8TZpSmCIZ/tXqGgHV22T
         Pw7g==
X-Gm-Message-State: ACrzQf2ZCnEB4lEnRJGz9exFgtk1fosnZQG4F7jeyUMcqGNkfaB5j+FG
        Yw0bd5t6zTEm8spuBzV85Z6peJ0tQUw=
X-Google-Smtp-Source: AMsMyM4GL0334oK18Fd08RM44oeUNqptRkYCF8+KeuYyVkFN2NrlLhyaRw/gXMOoGSTPvyUvRjLaMw==
X-Received: by 2002:a7b:cc0c:0:b0:3c5:a58f:afbc with SMTP id f12-20020a7bcc0c000000b003c5a58fafbcmr23775388wmh.169.1666642067850;
        Mon, 24 Oct 2022 13:07:47 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t7-20020adfe107000000b0022da3977ec5sm452535wrz.113.2022.10.24.13.07.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Oct 2022 13:07:47 -0700 (PDT)
Message-Id: <321757ef919bc75e58108d6e6bef4aaeeb4b326a.1666642065.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1359.v5.git.1666642064.gitgitgadget@gmail.com>
References: <pull.1359.v4.git.1666307815.gitgitgadget@gmail.com>
        <pull.1359.v5.git.1666642064.gitgitgadget@gmail.com>
From:   "Jerry Zhang via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 24 Oct 2022 20:07:39 +0000
Subject: [PATCH v5 1/6] patch-id: fix stable patch id for binary / header-only
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jerry Zhang <jerry@skydio.com>, Jerry Zhang <jerry@skydio.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jerry Zhang <jerry@skydio.com>

Patch-ids for binary patches are found by hashing the object
ids of the before and after objects in succession. However in
the --stable case, there is a bug where hunks are not flushed
for binary and header-only patch ids, which would always result
in a patch-id of 0000. The --unstable case is currently correct.

Reorder the logic to branch into 3 cases for populating the
patch body: header-only which populates nothing, binary which
populates the object ids, and normal which populates the text
diff. All branches will end up flushing the hunk.

Don't populate the ---a/ and +++b/ lines for binary diffs, to correspond
to those lines not being present in the "git diff" text output.
This is necessary because we advertise that the patch-id calculated
internally and used in format-patch is the same that what the
builtin "git patch-id" would produce when piped from a diff.

Update the test to run on both binary and normal files.

Signed-off-by: Jerry Zhang <jerry@skydio.com>
---
 diff.c                     | 58 +++++++++++++++++++-------------------
 t/t3419-rebase-patch-id.sh | 34 +++++++++++++++-------
 2 files changed, 53 insertions(+), 39 deletions(-)

diff --git a/diff.c b/diff.c
index 648f6717a55..c15169e4b06 100644
--- a/diff.c
+++ b/diff.c
@@ -6253,46 +6253,46 @@ static int diff_get_patch_id(struct diff_options *options, struct object_id *oid
 		if (p->one->mode == 0) {
 			patch_id_add_string(&ctx, "newfilemode");
 			patch_id_add_mode(&ctx, p->two->mode);
-			patch_id_add_string(&ctx, "---/dev/null");
-			patch_id_add_string(&ctx, "+++b/");
-			the_hash_algo->update_fn(&ctx, p->two->path, len2);
 		} else if (p->two->mode == 0) {
 			patch_id_add_string(&ctx, "deletedfilemode");
 			patch_id_add_mode(&ctx, p->one->mode);
-			patch_id_add_string(&ctx, "---a/");
-			the_hash_algo->update_fn(&ctx, p->one->path, len1);
-			patch_id_add_string(&ctx, "+++/dev/null");
-		} else {
-			patch_id_add_string(&ctx, "---a/");
-			the_hash_algo->update_fn(&ctx, p->one->path, len1);
-			patch_id_add_string(&ctx, "+++b/");
-			the_hash_algo->update_fn(&ctx, p->two->path, len2);
 		}
 
-		if (diff_header_only)
-			continue;
-
-		if (fill_mmfile(options->repo, &mf1, p->one) < 0 ||
-		    fill_mmfile(options->repo, &mf2, p->two) < 0)
-			return error("unable to read files to diff");
-
-		if (diff_filespec_is_binary(options->repo, p->one) ||
+		if (diff_header_only) {
+			/* don't do anything since we're only populating header info */
+		} else if (diff_filespec_is_binary(options->repo, p->one) ||
 		    diff_filespec_is_binary(options->repo, p->two)) {
 			the_hash_algo->update_fn(&ctx, oid_to_hex(&p->one->oid),
 					the_hash_algo->hexsz);
 			the_hash_algo->update_fn(&ctx, oid_to_hex(&p->two->oid),
 					the_hash_algo->hexsz);
-			continue;
-		}
-
-		xpp.flags = 0;
-		xecfg.ctxlen = 3;
-		xecfg.flags = XDL_EMIT_NO_HUNK_HDR;
-		if (xdi_diff_outf(&mf1, &mf2, NULL,
-				  patch_id_consume, &data, &xpp, &xecfg))
-			return error("unable to generate patch-id diff for %s",
-				     p->one->path);
+		} else {
+			if (p->one->mode == 0) {
+				patch_id_add_string(&ctx, "---/dev/null");
+				patch_id_add_string(&ctx, "+++b/");
+				the_hash_algo->update_fn(&ctx, p->two->path, len2);
+			} else if (p->two->mode == 0) {
+				patch_id_add_string(&ctx, "---a/");
+				the_hash_algo->update_fn(&ctx, p->one->path, len1);
+				patch_id_add_string(&ctx, "+++/dev/null");
+			} else {
+				patch_id_add_string(&ctx, "---a/");
+				the_hash_algo->update_fn(&ctx, p->one->path, len1);
+				patch_id_add_string(&ctx, "+++b/");
+				the_hash_algo->update_fn(&ctx, p->two->path, len2);
+			}
 
+			if (fill_mmfile(options->repo, &mf1, p->one) < 0 ||
+			    fill_mmfile(options->repo, &mf2, p->two) < 0)
+				return error("unable to read files to diff");
+			xpp.flags = 0;
+			xecfg.ctxlen = 3;
+			xecfg.flags = XDL_EMIT_NO_HUNK_HDR;
+			if (xdi_diff_outf(&mf1, &mf2, NULL,
+					  patch_id_consume, &data, &xpp, &xecfg))
+				return error("unable to generate patch-id diff for %s",
+					     p->one->path);
+		}
 		if (stable)
 			flush_one_hunk(oid, &ctx);
 	}
diff --git a/t/t3419-rebase-patch-id.sh b/t/t3419-rebase-patch-id.sh
index 295040f2fe3..d24e55aac8d 100755
--- a/t/t3419-rebase-patch-id.sh
+++ b/t/t3419-rebase-patch-id.sh
@@ -43,15 +43,16 @@ test_expect_success 'setup: 500 lines' '
 	git add newfile &&
 	git commit -q -m "add small file" &&
 
-	git cherry-pick main >/dev/null 2>&1
-'
+	git cherry-pick main >/dev/null 2>&1 &&
 
-test_expect_success 'setup attributes' '
-	echo "file binary" >.gitattributes
+	git branch -f squashed main &&
+	git checkout -q -f squashed &&
+	git reset -q --soft HEAD~2 &&
+	git commit -q -m squashed
 '
 
 test_expect_success 'detect upstream patch' '
-	git checkout -q main &&
+	git checkout -q main^{} &&
 	scramble file &&
 	git add file &&
 	git commit -q -m "change big file again" &&
@@ -61,14 +62,27 @@ test_expect_success 'detect upstream patch' '
 	test_must_be_empty revs
 '
 
+test_expect_success 'detect upstream patch binary' '
+	echo "file binary" >.gitattributes &&
+	git checkout -q other^{} &&
+	git rebase main &&
+	git rev-list main...HEAD~ >revs &&
+	test_must_be_empty revs &&
+	test_when_finished "rm .gitattributes"
+'
+
 test_expect_success 'do not drop patch' '
-	git branch -f squashed main &&
-	git checkout -q -f squashed &&
-	git reset -q --soft HEAD~2 &&
-	git commit -q -m squashed &&
 	git checkout -q other^{} &&
 	test_must_fail git rebase squashed &&
-	git rebase --quit
+	test_when_finished "git rebase --abort"
+'
+
+test_expect_success 'do not drop patch binary' '
+	echo "file binary" >.gitattributes &&
+	git checkout -q other^{} &&
+	test_must_fail git rebase squashed &&
+	test_when_finished "git rebase --abort" &&
+	test_when_finished "rm .gitattributes"
 '
 
 test_done
-- 
gitgitgadget

