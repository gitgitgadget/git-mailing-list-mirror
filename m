Return-Path: <SRS0=kr1+=CK=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 324A6C2BBDB
	for <git@archiver.kernel.org>; Tue,  1 Sep 2020 11:01:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F1A79207EA
	for <git@archiver.kernel.org>; Tue,  1 Sep 2020 11:01:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q9xjz0Fm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726192AbgIAK66 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Sep 2020 06:58:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726310AbgIAK6O (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Sep 2020 06:58:14 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4465C061245
        for <git@vger.kernel.org>; Tue,  1 Sep 2020 03:58:13 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id a17so1003811wrn.6
        for <git@vger.kernel.org>; Tue, 01 Sep 2020 03:58:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mezOTD0s1ezoy/nByLO3746pGiGu+o0vX5xJJtgqOwg=;
        b=q9xjz0FmaoOBegaTL0mJQW3HdjnckZjgRyh+PJaTXb66qU1wHf0BTncGduzP8VKP8y
         jhUa1cVHEiy7LuuSX4u+b4MWTbw16W6PWCopkpX77fvu+YXdVzMzcDvaLcPm7i7uInBE
         1/P0yQ/UpB1e5QcVBZYAdiBi/QcesPM166DTvd/hbW7F3QuOPqtrCkllVaoq1rWBbRKz
         7kZm+ihnuz/+cRkJ5Xa5XOA0bfG4yD4DXnQmL346gjNORryvwdwp0M5qEygprm5iA/YC
         mhBEhYm/judssBqT07hmE3YP/OBkNfRfe1dNSsQsruRic0LxqOgMELjRMtzQ+krNBVrz
         B5WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mezOTD0s1ezoy/nByLO3746pGiGu+o0vX5xJJtgqOwg=;
        b=G/2tgwg5ZbifY0BQSzxPhdUjNu1KnlCqp35pTJEP9Cfp8tWPtLwUQFGF4niswaEQUJ
         B6A+Ik+lcYGC4/mtwj1tuup36a9NCFogF0ts3XU4sswzg+Yeg6y1c4Ugzk8gjV/7KDvY
         omylng4ykC7sYMrPL5nc3c+5CFPrjrvOsBFzvgg9yQbPd2czX0s5x7JIwoEwP/b3uYwF
         Neppho55ge8QjkcEQajg27V71EYlmh+cK5n2GKX1v2QrcWsemVje5wJ0FfpG5nzX/UAE
         ZcI8mg/dtMhfkh3rbd2CnuczVnPY6BEvirXTcLLWmT4RPqUGykZn34yMAm8LWjywthkl
         /kdA==
X-Gm-Message-State: AOAM530+0sA/kebTBc31H6QPHUKvYpRgpL4n/dOUjqJDJ9+cNNiRJMFt
        6D/F49o7eKnm8FsoiKTxhm2nRkfVt78=
X-Google-Smtp-Source: ABdhPJzY2VyiUHgIOw38z2SDVRIGrnx5pdKPxFnmv/dD58Uwyn4BpdpVvL/Nr7+6WizIdjcOKUFLjA==
X-Received: by 2002:adf:ec4d:: with SMTP id w13mr1326682wrn.334.1598957892052;
        Tue, 01 Sep 2020 03:58:12 -0700 (PDT)
Received: from ylate.lan (atoulouse-654-1-378-135.w86-199.abo.wanadoo.fr. [86.199.233.135])
        by smtp.googlemail.com with ESMTPSA id x16sm1705875wrq.62.2020.09.01.03.58.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2020 03:58:11 -0700 (PDT)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, phillip.wood@dunelm.org.uk,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [PATCH v2 03/11] merge-index: libify merge_one_path() and merge_all()
Date:   Tue,  1 Sep 2020 12:56:57 +0200
Message-Id: <20200901105705.6059-4-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200901105705.6059-1-alban.gruin@gmail.com>
References: <20200625121953.16991-1-alban.gruin@gmail.com>
 <20200901105705.6059-1-alban.gruin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The "resolve" and "octopus" merge strategies do not call directly `git
merge-one-file', they delegate the work to another git command, `git
merge-index', that will loop over files in the index and call the
specified command.  Unfortunately, these functions are not part of
libgit.a, which means that once rewritten, the strategies would still
have to invoke `merge-one-file' by spawning a new process first.

To avoid this, this moves merge_one_path(), merge_all(), and their
helpers to merge-strategies.c.  They also take a callback to dictate
what they should do for each file.  For now, only one launching a new
process is defined to preserve the behaviour of the builtin version.

Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
---
 builtin/merge-index.c | 77 +++------------------------------
 merge-strategies.c    | 99 +++++++++++++++++++++++++++++++++++++++++++
 merge-strategies.h    | 17 ++++++++
 3 files changed, 123 insertions(+), 70 deletions(-)

diff --git a/builtin/merge-index.c b/builtin/merge-index.c
index 38ea6ad6ca..6cb666cc78 100644
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
+				err |= merge_all(&the_index, one_shot, quiet,
+						 merge_program_cb, (void *)pgm);
 				continue;
 			}
 			die("git merge-index: unknown option %s", arg);
 		}
-		merge_one_path(arg);
+		err |= merge_one_path(&the_index, one_shot, quiet, arg,
+				      merge_program_cb, (void *)pgm);
 	}
-	if (err && !quiet)
-		die("merge program failed");
 	return err;
 }
diff --git a/merge-strategies.c b/merge-strategies.c
index f2af4a894d..ffd6cf77d6 100644
--- a/merge-strategies.c
+++ b/merge-strategies.c
@@ -2,6 +2,7 @@
 #include "dir.h"
 #include "ll-merge.h"
 #include "merge-strategies.h"
+#include "run-command.h"
 #include "xdiff-interface.h"
 
 static int add_to_index_cacheinfo(struct index_state *istate,
@@ -197,3 +198,101 @@ int merge_strategies_one_file(struct repository *r,
 
 	return 0;
 }
+
+int merge_program_cb(const struct object_id *orig_blob,
+		     const struct object_id *our_blob,
+		     const struct object_id *their_blob, const char *path,
+		     unsigned int orig_mode, unsigned int our_mode, unsigned int their_mode,
+		     void *data)
+{
+	char ownbuf[3][GIT_MAX_HEXSZ] = {{0}};
+	const char *arguments[] = { (char *)data, "", "", "", path,
+				    ownbuf[0], ownbuf[1], ownbuf[2],
+				    NULL };
+
+	if (orig_blob)
+		arguments[1] = oid_to_hex(orig_blob);
+	if (our_blob)
+		arguments[2] = oid_to_hex(our_blob);
+	if (their_blob)
+		arguments[3] = oid_to_hex(their_blob);
+
+	xsnprintf(ownbuf[0], sizeof(ownbuf[0]), "%o", orig_mode);
+	xsnprintf(ownbuf[1], sizeof(ownbuf[1]), "%o", our_mode);
+	xsnprintf(ownbuf[2], sizeof(ownbuf[2]), "%o", their_mode);
+
+	return run_command_v_opt(arguments, 0);
+}
+
+static int merge_entry(struct index_state *istate, int quiet, int pos,
+		       const char *path, merge_cb cb, void *data)
+{
+	int found = 0;
+	const struct object_id *oids[3] = {NULL};
+	unsigned int modes[3] = {0};
+
+	do {
+		const struct cache_entry *ce = istate->cache[pos];
+		int stage = ce_stage(ce);
+
+		if (strcmp(ce->name, path))
+			break;
+		found++;
+		oids[stage - 1] = &ce->oid;
+		modes[stage - 1] = ce->ce_mode;
+	} while (++pos < istate->cache_nr);
+	if (!found)
+		return error(_("%s is not in the cache"), path);
+
+	if (cb(oids[0], oids[1], oids[2], path, modes[0], modes[1], modes[2], data)) {
+		if (!quiet)
+			error(_("Merge program failed"));
+		return -2;
+	}
+
+	return found;
+}
+
+int merge_one_path(struct index_state *istate, int oneshot, int quiet,
+		   const char *path, merge_cb cb, void *data)
+{
+	int pos = index_name_pos(istate, path, strlen(path)), ret;
+
+	/*
+	 * If it already exists in the cache as stage0, it's
+	 * already merged and there is nothing to do.
+	 */
+	if (pos < 0) {
+		ret = merge_entry(istate, quiet, -pos - 1, path, cb, data);
+		if (ret == -1)
+			return -1;
+		else if (ret == -2)
+			return 1;
+	}
+	return 0;
+}
+
+int merge_all(struct index_state *istate, int oneshot, int quiet,
+	      merge_cb cb, void *data)
+{
+	int err = 0, i, ret;
+	for (i = 0; i < istate->cache_nr; i++) {
+		const struct cache_entry *ce = istate->cache[i];
+		if (!ce_stage(ce))
+			continue;
+
+		ret = merge_entry(istate, quiet, i, ce->name, cb, data);
+		if (ret > 0)
+			i += ret - 1;
+		else if (ret == -1)
+			return -1;
+		else if (ret == -2) {
+			if (oneshot)
+				err++;
+			else
+				return 1;
+		}
+	}
+
+	return err;
+}
diff --git a/merge-strategies.h b/merge-strategies.h
index b527d145c7..cf78d7eaf4 100644
--- a/merge-strategies.h
+++ b/merge-strategies.h
@@ -10,4 +10,21 @@ int merge_strategies_one_file(struct repository *r,
 			      unsigned int orig_mode, unsigned int our_mode,
 			      unsigned int their_mode);
 
+typedef int (*merge_cb)(const struct object_id *orig_blob,
+			const struct object_id *our_blob,
+			const struct object_id *their_blob, const char *path,
+			unsigned int orig_mode, unsigned int our_mode, unsigned int their_mode,
+			void *data);
+
+int merge_program_cb(const struct object_id *orig_blob,
+		     const struct object_id *our_blob,
+		     const struct object_id *their_blob, const char *path,
+		     unsigned int orig_mode, unsigned int our_mode, unsigned int their_mode,
+		     void *data);
+
+int merge_one_path(struct index_state *istate, int oneshot, int quiet,
+		   const char *path, merge_cb cb, void *data);
+int merge_all(struct index_state *istate, int oneshot, int quiet,
+	      merge_cb cb, void *data);
+
 #endif /* MERGE_STRATEGIES_H */
-- 
2.28.0.370.g2c2dc3cc62

