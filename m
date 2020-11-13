Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1F6CC63697
	for <git@archiver.kernel.org>; Fri, 13 Nov 2020 12:10:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 65BB82224C
	for <git@archiver.kernel.org>; Fri, 13 Nov 2020 12:10:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rjXNm1lH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726593AbgKMMK5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Nov 2020 07:10:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726558AbgKMMK4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Nov 2020 07:10:56 -0500
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5764BC0613D1
        for <git@vger.kernel.org>; Fri, 13 Nov 2020 04:10:56 -0800 (PST)
Received: by mail-wm1-x344.google.com with SMTP id c9so7903443wml.5
        for <git@vger.kernel.org>; Fri, 13 Nov 2020 04:10:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1YpVyg+L2WumoA2BhyTuTLloEC541IqEs9MhNB3Bt/A=;
        b=rjXNm1lHaZ6sBNovXWZsRVbtVBlMGe1k5/biVtIMFg0wE6467263X55X4qdg4Z8vzv
         9y9CioCn6TnVmQBJQBAp/r5iitlLBXOTgg5KWN2Y+/CDuIMtCXOWPbamgeRVNA/pE7W1
         HO59W9YKegpvRheBHZjk/kCSb3Ib+Jp0SMU4S5wQwMpK5pCv6YLL4uWQH5yvrWzBXWtL
         5V+LjFnhxdtSIumcAJbEs1dUqMCeOnQOnscANglqfOPDLupNEgCXvcumgbzHEisDj8ug
         EmWcMN+cPnA0ApJA4HY+qGbNItEATVlT5wDyrd2uzltTLAOF6VYtoiwfyGQN8h/Bdkl8
         Eaqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1YpVyg+L2WumoA2BhyTuTLloEC541IqEs9MhNB3Bt/A=;
        b=t6/ZlQwNcnxBDMNylRFr/cU7GUQSyoVplgYSlRpQx6w1T/wDEUubvQpqbrJoCa6a37
         9Zh5bRQq+qdBBDbMem56XI8aDEM0z7PXu9C/vQFpVddLH6H+rBzOZeowSHQlA3ySeTmG
         ieSeZOBG1LSrXwMpBPq2fBh4mnD/rFlFLecLgTrBN+hlJL+Sihg7n0FyUzplzOGMZTby
         +JK3wPR0QtO4qECqsXd7fglL4zuq9Z4nMxJ2b+CLPhVit5nrkud9u61+KwY4LyJ4Y7Wx
         maKzY0fXI6kimh4jxWWHQNSHS+Eh2tRx+GHZByU1uB8qXKaJyW6sqadKFUJ8WMxW2BBi
         Nkig==
X-Gm-Message-State: AOAM532sypQFXUc45V0EBDH5A/9j24OK7UKtOHHYD+tNcWoOX8ajkQJY
        6vIrgriKTKF0dIdqE0d/W28fMIdEk2A=
X-Google-Smtp-Source: ABdhPJxo7UVItjzhwuLWmcvTs15gHB2DFEgFTjqrBhYmPolc7+RZ66nYVlowAkO1rkGeqEGCYBOupw==
X-Received: by 2002:a1c:df8a:: with SMTP id w132mr2242374wmg.90.1605269451823;
        Fri, 13 Nov 2020 04:10:51 -0800 (PST)
Received: from ylate.lan (atoulouse-654-1-426-233.w2-6.abo.wanadoo.fr. [2.6.209.233])
        by smtp.googlemail.com with ESMTPSA id g138sm10083697wme.39.2020.11.13.04.10.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2020 04:10:51 -0800 (PST)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [PATCH v4 04/12] merge-index: libify merge_one_path() and merge_all()
Date:   Fri, 13 Nov 2020 12:04:20 +0100
Message-Id: <20201113110428.21265-5-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201113110428.21265-1-alban.gruin@gmail.com>
References: <20201005122646.27994-1-alban.gruin@gmail.com>
 <20201113110428.21265-1-alban.gruin@gmail.com>
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
 merge-strategies.c    | 103 ++++++++++++++++++++++++++++++++++++++++++
 merge-strategies.h    |  17 +++++++
 3 files changed, 127 insertions(+), 70 deletions(-)

diff --git a/builtin/merge-index.c b/builtin/merge-index.c
index 38ea6ad6ca..49e3382fb9 100644
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
+				err |= merge_all_index(&the_index, one_shot, quiet,
+						       merge_one_file_spawn, (void *)pgm);
 				continue;
 			}
 			die("git merge-index: unknown option %s", arg);
 		}
-		merge_one_path(arg);
+		err |= merge_index_path(&the_index, one_shot, quiet, arg,
+					merge_one_file_spawn, (void *)pgm);
 	}
-	if (err && !quiet)
-		die("merge program failed");
 	return err;
 }
diff --git a/merge-strategies.c b/merge-strategies.c
index f5fdb15bbf..e1d121c993 100644
--- a/merge-strategies.c
+++ b/merge-strategies.c
@@ -1,6 +1,7 @@
 #include "cache.h"
 #include "dir.h"
 #include "merge-strategies.h"
+#include "run-command.h"
 #include "xdiff-interface.h"
 
 static int checkout_from_index(struct index_state *istate, const char *path,
@@ -171,3 +172,105 @@ int merge_three_way(struct repository *r,
 
 	return 0;
 }
+
+int merge_one_file_spawn(const struct object_id *orig_blob,
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
+static int merge_entry(struct index_state *istate, int quiet, int pos,
+		       const char *path, merge_fn fn, void *data)
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
+	if (fn(oids[0], oids[1], oids[2], path, modes[0], modes[1], modes[2], data)) {
+		if (!quiet)
+			error(_("Merge program failed"));
+		return -2;
+	}
+
+	return found;
+}
+
+int merge_index_path(struct index_state *istate, int oneshot, int quiet,
+		     const char *path, merge_fn fn, void *data)
+{
+	int pos = index_name_pos(istate, path, strlen(path)), ret;
+
+	/*
+	 * If it already exists in the cache as stage0, it's
+	 * already merged and there is nothing to do.
+	 */
+	if (pos < 0) {
+		ret = merge_entry(istate, quiet, -pos - 1, path, fn, data);
+		if (ret == -1)
+			return -1;
+		else if (ret == -2)
+			return 1;
+	}
+	return 0;
+}
+
+int merge_all_index(struct index_state *istate, int oneshot, int quiet,
+		    merge_fn fn, void *data)
+{
+	int err = 0, i, ret;
+	for (i = 0; i < istate->cache_nr; i++) {
+		const struct cache_entry *ce = istate->cache[i];
+		if (!ce_stage(ce))
+			continue;
+
+		ret = merge_entry(istate, quiet, i, ce->name, fn, data);
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
index e624c4f27c..d2f52d6792 100644
--- a/merge-strategies.h
+++ b/merge-strategies.h
@@ -9,4 +9,21 @@ int merge_three_way(struct repository *r,
 		    const struct object_id *their_blob, const char *path,
 		    unsigned int orig_mode, unsigned int our_mode, unsigned int their_mode);
 
+typedef int (*merge_fn)(const struct object_id *orig_blob,
+			const struct object_id *our_blob,
+			const struct object_id *their_blob, const char *path,
+			unsigned int orig_mode, unsigned int our_mode, unsigned int their_mode,
+			void *data);
+
+int merge_one_file_spawn(const struct object_id *orig_blob,
+			 const struct object_id *our_blob,
+			 const struct object_id *their_blob, const char *path,
+			 unsigned int orig_mode, unsigned int our_mode, unsigned int their_mode,
+			 void *data);
+
+int merge_index_path(struct index_state *istate, int oneshot, int quiet,
+		     const char *path, merge_fn fn, void *data);
+int merge_all_index(struct index_state *istate, int oneshot, int quiet,
+		    merge_fn fn, void *data);
+
 #endif /* MERGE_STRATEGIES_H */
-- 
2.20.1

