Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3F7A51F405
	for <e@80x24.org>; Wed,  8 Aug 2018 18:59:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730875AbeHHVUo (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Aug 2018 17:20:44 -0400
Received: from mail-wm0-f53.google.com ([74.125.82.53]:55287 "EHLO
        mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729997AbeHHVUn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Aug 2018 17:20:43 -0400
Received: by mail-wm0-f53.google.com with SMTP id c14-v6so3805971wmb.4
        for <git@vger.kernel.org>; Wed, 08 Aug 2018 11:59:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=a8nTfEF4ISXp5D/SagQ54g5EkvIEc6thnJm2iKnvKYo=;
        b=rdjhWdQupqVXcd1ZarQXpnZiyex2XbR0D5NlbUciX4lOvz46ssy/cJgOMp1MhN1CE5
         CU2upuzFM3TA5qcHY8h4k8gK8P6MFS0I2KZrS4ndyUzMiwbrSQ61rtFLq77YYeZCR3+o
         xzqlVJ8U1uU2swW8Vpf8HjprRvUTclcsePVJJYzmrKJRh92PRFyBo+Rf1sJne2x/9+Bg
         G4uRJO4UW3GkFpXMLbukeQM8W+XtmT2qQS2pAVZQeeL+gBrUl8X9XaKgfdKTOa2Rb43U
         fghDNnlQqh9ZB0TCp0E9nKm0eeV/wdSmolIxjNbyMOLIdTCYAhLY4zOLsUFcTbnpi8ZP
         dteQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=a8nTfEF4ISXp5D/SagQ54g5EkvIEc6thnJm2iKnvKYo=;
        b=guAOOuhcm8nngWbaqxD2PzPaNOoAYNq40jtuoLwyDoL+s4DHkQo7Z8RyoLymlk0beG
         nVmYdIT27mB2VGIvlMF8kOkrVIvPaadKK/pzIqnMnIIEJWYoy2YPv3ncpI0MEkLC+3CM
         FmlUfdsJqveJXjUQFZh4zCOch2PMJ3Xfy/XORJ4/6xRasKYQ6NUFWV8OGTzDd8pfpkv7
         HgEOakoZdBCnpQEm4JFnwN/EAu043vD+ALR9rwNTi0TIljqd+EKIRSWT1Lxt9h6PNiVz
         aDa32TOFHRwwE97VXgDiTLb/7srTQgMoyijAweRzBAnghTd5fMwLpFEUCmx8PFkbgBPd
         bqPQ==
X-Gm-Message-State: AOUpUlGQEMFbtDK9d6FQ9QvqQGzLuVOE1VGsOYCljOB6vtU/j0SLkckR
        /rYpdotRSJiiCbZNViOejzeosMLX
X-Google-Smtp-Source: AA+uWPznfr2HNIBZ1vcqcdl9fV6nvN5iJlaPH5O3tx5RjHVpQsJEUuJ2zTc7+fZsLtP6u99oHzFEzQ==
X-Received: by 2002:a1c:4489:: with SMTP id r131-v6mr2546280wma.128.1533754781160;
        Wed, 08 Aug 2018 11:59:41 -0700 (PDT)
Received: from sebi-laptop.tendawifi.com ([86.127.74.86])
        by smtp.gmail.com with ESMTPSA id p5-v6sm4238879wre.32.2018.08.08.11.59.40
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Aug 2018 11:59:40 -0700 (PDT)
From:   Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
To:     git@vger.kernel.org
Subject: [GSoC][PATCH v7 26/26] stash: replace all "git apply" child processes with API calls
Date:   Wed,  8 Aug 2018 21:59:05 +0300
Message-Id: <56500d98f9d5daaa5f21a43767885baede86e3a0.1533753605.git.ungureanupaulsebastian@gmail.com>
X-Mailer: git-send-email 2.18.0.573.g56500d98f
In-Reply-To: <cover.1533753605.git.ungureanupaulsebastian@gmail.com>
References: <cover.1533753605.git.ungureanupaulsebastian@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

`apply_all_patches()` does not provide a method to apply patches
from strbuf. Because of this, this commit introduces a new
function `apply_patch_from_buf()` which applies a patch from buf.
It works by saving the strbuf as a file. This way we can call
`apply_all_patches()`. Before returning, the created file is
removed.
---
 builtin/stash.c | 61 +++++++++++++++++++++++++++----------------------
 1 file changed, 34 insertions(+), 27 deletions(-)

diff --git a/builtin/stash.c b/builtin/stash.c
index 46e76a34e..74eda822c 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -13,6 +13,7 @@
 #include "revision.h"
 #include "log-tree.h"
 #include "diffcore.h"
+#include "apply.h"
 
 static const char * const git_stash_usage[] = {
 	N_("git stash list [<options>]"),
@@ -277,10 +278,6 @@ static int diff_tree_binary(struct strbuf *out, struct object_id *w_commit)
 	struct child_process cp = CHILD_PROCESS_INIT;
 	const char *w_commit_hex = oid_to_hex(w_commit);
 
-	/*
-	 * Diff-tree would not be very hard to replace with a native function,
-	 * however it should be done together with apply_cached.
-	 */
 	cp.git_cmd = 1;
 	argv_array_pushl(&cp.args, "diff-tree", "--binary", NULL);
 	argv_array_pushf(&cp.args, "%s^2^..%s^2", w_commit_hex, w_commit_hex);
@@ -288,18 +285,36 @@ static int diff_tree_binary(struct strbuf *out, struct object_id *w_commit)
 	return pipe_command(&cp, NULL, 0, out, 0, NULL, 0);
 }
 
-static int apply_cached(struct strbuf *out)
+static int apply_patch_from_buf(struct strbuf *patch, int cached, int reverse,
+				int check_index)
 {
-	struct child_process cp = CHILD_PROCESS_INIT;
+	int ret = 0;
+	struct apply_state state;
+	struct argv_array args = ARGV_ARRAY_INIT;
+	const char *patch_path = ".git/stash_patch.patch";
+	FILE *patch_file;
 
-	/*
-	 * Apply currently only reads either from stdin or a file, thus
-	 * apply_all_patches would have to be updated to optionally take a
-	 * buffer.
-	 */
-	cp.git_cmd = 1;
-	argv_array_pushl(&cp.args, "apply", "--cached", NULL);
-	return pipe_command(&cp, out->buf, out->len, NULL, 0, NULL, 0);
+	if (init_apply_state(&state, NULL))
+		return -1;
+
+	state.cached = cached;
+	state.apply_in_reverse = reverse;
+	state.check_index = check_index;
+	if (state.cached)
+		state.check_index = 1;
+	if (state.check_index)
+		state.unsafe_paths = 0;
+
+	patch_file = fopen(patch_path, "w");
+	strbuf_write(patch, patch_file);
+	fclose(patch_file);
+
+	argv_array_push(&args, patch_path);
+	ret = apply_all_patches(&state, args.argc, args.argv, 0);
+
+	remove_path(patch_path);
+	clear_apply_state(&state);
+	return ret;
 }
 
 static int reset_head(const char *prefix)
@@ -418,7 +433,7 @@ static int do_apply_stash(const char *prefix, struct stash_info *info,
 				return -1;
 			}
 
-			ret = apply_cached(&out);
+			ret = apply_patch_from_buf(&out, 1, 0, 0);
 			strbuf_release(&out);
 			if (ret)
 				return -1;
@@ -1341,7 +1356,6 @@ static int do_push_stash(int argc, const char **argv, const char *prefix,
 			int i;
 			struct child_process cp1 = CHILD_PROCESS_INIT;
 			struct child_process cp2 = CHILD_PROCESS_INIT;
-			struct child_process cp3 = CHILD_PROCESS_INIT;
 			struct strbuf out = STRBUF_INIT;
 
 			cp1.git_cmd = 1;
@@ -1365,11 +1379,9 @@ static int do_push_stash(int argc, const char **argv, const char *prefix,
 			if (pipe_command(&cp2, NULL, 0, &out, 0, NULL, 0))
 				return -1;
 
-			cp3.git_cmd = 1;
-			argv_array_pushl(&cp3.args, "apply", "--index", "-R",
-					 NULL);
-			if (pipe_command(&cp3, out.buf, out.len, NULL, 0, NULL,
-					 0))
+			discard_cache();
+			read_cache();
+			if (apply_patch_from_buf(&out, 0, 1, 1))
 				return -1;
 		} else {
 			struct child_process cp = CHILD_PROCESS_INIT;
@@ -1405,12 +1417,7 @@ static int do_push_stash(int argc, const char **argv, const char *prefix,
 				return -1;
 		}
 	} else {
-		struct child_process cp = CHILD_PROCESS_INIT;
-
-		cp.git_cmd = 1;
-		argv_array_pushl(&cp.args, "apply", "-R", NULL);
-
-		if (pipe_command(&cp, patch.buf, patch.len, NULL, 0, NULL, 0)) {
+		if (apply_patch_from_buf(&patch, 0, 1, 0)) {
 			if (!quiet)
 				fprintf_ln(stderr, "Cannot remove worktree changes");
 			return -1;
-- 
2.18.0.573.g56500d98f

