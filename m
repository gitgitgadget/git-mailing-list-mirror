Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E499C64E7B
	for <git@archiver.kernel.org>; Tue, 24 Nov 2020 11:55:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB80320782
	for <git@archiver.kernel.org>; Tue, 24 Nov 2020 11:55:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qQToozNz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733117AbgKXLzF (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Nov 2020 06:55:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733112AbgKXLzF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Nov 2020 06:55:05 -0500
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CE94C0617A6
        for <git@vger.kernel.org>; Tue, 24 Nov 2020 03:55:03 -0800 (PST)
Received: by mail-wm1-x344.google.com with SMTP id d142so2159421wmd.4
        for <git@vger.kernel.org>; Tue, 24 Nov 2020 03:55:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=g6f4lMU44WIp4RgRKTQ7dDq9rOZSto3d9XfaXphHOws=;
        b=qQToozNzDZ6QwkNKuofE+lTOCnSPJUjzVQ872AqHd4sy6JEjsC/VELZ0XJPvUz3pA0
         dzHDZ0EBB31R5vh8A9ZMxoTXWUCdzHXQzv7/kwoVTt8qoo+wx+8h6FMff1rhsizVCoC6
         xZE/HYaX99HnoOHf0NZ9mrya3qN58N7x6y2Bq2bHT7QJS8h9FIuxLJR69zuRtqfB92dO
         mRVy5zNR9wM6M1fTe5AS+PzjwL0oKJoPL8DDshUUvOoNFmjVxFRW55POzeRk62JIDJQO
         mMGJELVAclPWCObCxmk/FyPu0+xyxCA9IMmL0kRAbY79ARxGPLZwmUKapNiUDrxEXl5k
         F/BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=g6f4lMU44WIp4RgRKTQ7dDq9rOZSto3d9XfaXphHOws=;
        b=d61iVNNsTvuyfmgurfE/D/KO+m1HnIj050vxVA5Xz2buH+4kH50X/4zlrg35U5PmQz
         4A9/Hgu80u9W4SWYWpPeBRFFG7kfSw6a0Lzx/bP1e3Cy0DhLwyuQYLe/9pFBvErVwWvG
         a6GALw0lN8pl6+4mxjLbjHddTuLsSR8Pwsi3PwC7jeAuEoSSLdSptl3ta/NxDpRv1WgT
         h/A+rbs2ve3Wp6rV9lUxbu9bLLNbQikiCJNYNOV2mwPhSlErFOndssHdeXXtUnYpKWfc
         aJTtP74VLNy3sxyCXn+8HT07JrlUsesbv+C2JVY14G8/+EG49ed7yQ5DvHuz5eEnUxbj
         kEOQ==
X-Gm-Message-State: AOAM530K8UcXLlMvmp7RhTKAz9pgSRZ+Pv+5CUNdn+m/o0oleDDZDkMW
        7AmbWdhrTc8z6DoZp6kgC49Fgp4zMdg=
X-Google-Smtp-Source: ABdhPJzcl54yTAEWr6R+2V7h608wA5S7kRAX+Cgu0CblCexEYeCkexsb6pgKBzzOJI69SdA20Rpc+g==
X-Received: by 2002:a1c:398a:: with SMTP id g132mr4058557wma.51.1606218901827;
        Tue, 24 Nov 2020 03:55:01 -0800 (PST)
Received: from ylate.lan (atoulouse-654-1-307-224.w86-199.abo.wanadoo.fr. [86.199.90.224])
        by smtp.googlemail.com with ESMTPSA id l13sm25893227wrm.24.2020.11.24.03.55.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2020 03:55:01 -0800 (PST)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [PATCH v6 05/13] merge-index: libify merge_one_path() and merge_all()
Date:   Tue, 24 Nov 2020 12:53:07 +0100
Message-Id: <20201124115315.13311-6-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201124115315.13311-1-alban.gruin@gmail.com>
References: <20201116102158.8365-1-alban.gruin@gmail.com>
 <20201124115315.13311-1-alban.gruin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The "resolve" and "octopus" merge strategies do not call directly `git
merge-one-file', they delegate the work to another git command, `git
merge-index', that will loop over files in the index and call the
specified command.  Unfortunately, these functions are not part of
libgit.a, which means that once rewritten, the strategies would still
have to invoke `merge-one-file' by spawning a new process first.

To avoid this, this moves and renames merge_one_path(), merge_all(), and
their helpers to merge-strategies.c.  They also take a callback to
dictate what they should do for each file.  For now, to preserve the
behaviour of `merge-index', only one callback, launching a new process,
is defined.

Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
---
 builtin/merge-index.c |  77 +++----------------------------
 merge-strategies.c    | 104 ++++++++++++++++++++++++++++++++++++++++++
 merge-strategies.h    |  19 ++++++++
 3 files changed, 130 insertions(+), 70 deletions(-)

diff --git a/builtin/merge-index.c b/builtin/merge-index.c
index 38ea6ad6ca..d5e5713b25 100644
--- a/builtin/merge-index.c
+++ b/builtin/merge-index.c
@@ -1,74 +1,11 @@
 #define USE_THE_INDEX_COMPATIBILITY_MACROS
 #include "builtin.h"
-#include "run-command.h"
-
-static const char *pgm;
-static int one_shot, quiet;
-static int err;
-
-static int merge_entry(int pos, const char *path)
-{
-	int found;
-	const char *arguments[] = { pgm, "", "", "", path, "", "", "", NULL };
-	char hexbuf[4][GIT_MAX_HEXSZ + 1];
-	char ownbuf[4][60];
-
-	if (pos >= active_nr)
-		die("git merge-index: %s not in the cache", path);
-	found = 0;
-	do {
-		const struct cache_entry *ce = active_cache[pos];
-		int stage = ce_stage(ce);
-
-		if (strcmp(ce->name, path))
-			break;
-		found++;
-		oid_to_hex_r(hexbuf[stage], &ce->oid);
-		xsnprintf(ownbuf[stage], sizeof(ownbuf[stage]), "%o", ce->ce_mode);
-		arguments[stage] = hexbuf[stage];
-		arguments[stage + 4] = ownbuf[stage];
-	} while (++pos < active_nr);
-	if (!found)
-		die("git merge-index: %s not in the cache", path);
-
-	if (run_command_v_opt(arguments, 0)) {
-		if (one_shot)
-			err++;
-		else {
-			if (!quiet)
-				die("merge program failed");
-			exit(1);
-		}
-	}
-	return found;
-}
-
-static void merge_one_path(const char *path)
-{
-	int pos = cache_name_pos(path, strlen(path));
-
-	/*
-	 * If it already exists in the cache as stage0, it's
-	 * already merged and there is nothing to do.
-	 */
-	if (pos < 0)
-		merge_entry(-pos-1, path);
-}
-
-static void merge_all(void)
-{
-	int i;
-	for (i = 0; i < active_nr; i++) {
-		const struct cache_entry *ce = active_cache[i];
-		if (!ce_stage(ce))
-			continue;
-		i += merge_entry(i, ce->name)-1;
-	}
-}
+#include "merge-strategies.h"
 
 int cmd_merge_index(int argc, const char **argv, const char *prefix)
 {
-	int i, force_file = 0;
+	int i, force_file = 0, err = 0, one_shot = 0, quiet = 0;
+	const char *pgm;
 
 	/* Without this we cannot rely on waitpid() to tell
 	 * what happened to our children.
@@ -98,14 +35,14 @@ int cmd_merge_index(int argc, const char **argv, const char *prefix)
 				continue;
 			}
 			if (!strcmp(arg, "-a")) {
-				merge_all();
+				err |= merge_all_index(the_repository, one_shot, quiet,
+						       merge_one_file_spawn, (void *)pgm);
 				continue;
 			}
 			die("git merge-index: unknown option %s", arg);
 		}
-		merge_one_path(arg);
+		err |= merge_index_path(the_repository, one_shot, quiet, arg,
+					merge_one_file_spawn, (void *)pgm);
 	}
-	if (err && !quiet)
-		die("merge program failed");
 	return err;
 }
diff --git a/merge-strategies.c b/merge-strategies.c
index 20a328bf57..6f27e66dfe 100644
--- a/merge-strategies.c
+++ b/merge-strategies.c
@@ -1,6 +1,7 @@
 #include "cache.h"
 #include "dir.h"
 #include "merge-strategies.h"
+#include "run-command.h"
 #include "xdiff-interface.h"
 
 static int checkout_from_index(struct index_state *istate, const char *path,
@@ -176,3 +177,106 @@ int merge_three_way(struct repository *r,
 
 	return 0;
 }
+
+int merge_one_file_spawn(struct repository *r,
+			 const struct object_id *orig_blob,
+			 const struct object_id *our_blob,
+			 const struct object_id *their_blob, const char *path,
+			 unsigned int orig_mode, unsigned int our_mode, unsigned int their_mode,
+			 void *data)
+{
+	char oids[3][GIT_MAX_HEXSZ + 1] = {{0}};
+	char modes[3][10] = {{0}};
+	const char *arguments[] = { (char *)data, oids[0], oids[1], oids[2],
+				    path, modes[0], modes[1], modes[2], NULL };
+
+	if (orig_blob) {
+		oid_to_hex_r(oids[0], orig_blob);
+		xsnprintf(modes[0], sizeof(modes[0]), "%06o", orig_mode);
+	}
+
+	if (our_blob) {
+		oid_to_hex_r(oids[1], our_blob);
+		xsnprintf(modes[1], sizeof(modes[1]), "%06o", our_mode);
+	}
+
+	if (their_blob) {
+		oid_to_hex_r(oids[2], their_blob);
+		xsnprintf(modes[2], sizeof(modes[2]), "%06o", their_mode);
+	}
+
+	return run_command_v_opt(arguments, 0);
+}
+
+static int merge_entry(struct repository *r, int quiet, unsigned int pos,
+		       const char *path, int *err, merge_fn fn, void *data)
+{
+	int found = 0;
+	const struct object_id *oids[3] = {NULL};
+	unsigned int modes[3] = {0};
+
+	do {
+		const struct cache_entry *ce = r->index->cache[pos];
+		int stage = ce_stage(ce);
+
+		if (strcmp(ce->name, path))
+			break;
+		found++;
+		oids[stage - 1] = &ce->oid;
+		modes[stage - 1] = ce->ce_mode;
+	} while (++pos < r->index->cache_nr);
+	if (!found)
+		return error(_("%s is not in the cache"), path);
+
+	if (fn(r, oids[0], oids[1], oids[2], path,
+	       modes[0], modes[1], modes[2], data)) {
+		if (!quiet)
+			error(_("Merge program failed"));
+		(*err)++;
+	}
+
+	return found;
+}
+
+int merge_index_path(struct repository *r, int oneshot, int quiet,
+		     const char *path, merge_fn fn, void *data)
+{
+	int pos = index_name_pos(r->index, path, strlen(path)), ret, err = 0;
+
+	/*
+	 * If it already exists in the cache as stage0, it's
+	 * already merged and there is nothing to do.
+	 */
+	if (pos < 0) {
+		ret = merge_entry(r, quiet || oneshot, -pos - 1, path, &err, fn, data);
+		if (ret == -1)
+			return -1;
+		else if (err)
+			return 1;
+	}
+	return 0;
+}
+
+int merge_all_index(struct repository *r, int oneshot, int quiet,
+		    merge_fn fn, void *data)
+{
+	int err = 0, ret;
+	unsigned int i;
+
+	for (i = 0; i < r->index->cache_nr; i++) {
+		const struct cache_entry *ce = r->index->cache[i];
+		if (!ce_stage(ce))
+			continue;
+
+		ret = merge_entry(r, quiet || oneshot, i, ce->name, &err, fn, data);
+		if (ret > 0)
+			i += ret - 1;
+		else if (ret == -1)
+			return -1;
+
+		if (err && !oneshot)
+			return 1;
+	}
+
+	return err;
+}
diff --git a/merge-strategies.h b/merge-strategies.h
index e624c4f27c..94c40635c4 100644
--- a/merge-strategies.h
+++ b/merge-strategies.h
@@ -9,4 +9,23 @@ int merge_three_way(struct repository *r,
 		    const struct object_id *their_blob, const char *path,
 		    unsigned int orig_mode, unsigned int our_mode, unsigned int their_mode);
 
+typedef int (*merge_fn)(struct repository *r,
+			const struct object_id *orig_blob,
+			const struct object_id *our_blob,
+			const struct object_id *their_blob, const char *path,
+			unsigned int orig_mode, unsigned int our_mode, unsigned int their_mode,
+			void *data);
+
+int merge_one_file_spawn(struct repository *r,
+			 const struct object_id *orig_blob,
+			 const struct object_id *our_blob,
+			 const struct object_id *their_blob, const char *path,
+			 unsigned int orig_mode, unsigned int our_mode, unsigned int their_mode,
+			 void *data);
+
+int merge_index_path(struct repository *r, int oneshot, int quiet,
+		     const char *path, merge_fn fn, void *data);
+int merge_all_index(struct repository *r, int oneshot, int quiet,
+		    merge_fn fn, void *data);
+
 #endif /* MERGE_STRATEGIES_H */
-- 
2.29.2.260.ge31aba42fb

