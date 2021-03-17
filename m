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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F6FAC4332D
	for <git@archiver.kernel.org>; Wed, 17 Mar 2021 20:57:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2BA8164F33
	for <git@archiver.kernel.org>; Wed, 17 Mar 2021 20:57:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233539AbhCQU5J (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Mar 2021 16:57:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233513AbhCQU4l (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Mar 2021 16:56:41 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F234C06174A
        for <git@vger.kernel.org>; Wed, 17 Mar 2021 13:56:41 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id a132-20020a1c668a0000b029010f141fe7c2so1946981wmc.0
        for <git@vger.kernel.org>; Wed, 17 Mar 2021 13:56:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wr6LrFyAd7ihfq5tqEFUsByYRH3eyhXKVadq9w+ENtg=;
        b=ri2A7msKatQI6lc1F1Hq2+m4a4L5SzYKZ6Z1UKb6gI0Cmg7uzmdc0iIO+zAVNoGJLl
         0reL72KPA20OLapINuhCjTieIuZzATdnDOYykfr4wtMU5NCzdSLVmjwjCozEdfrFg7ft
         NEjHtryAY6zVfC1RbvzpEmdwg32CjITAUwYp9Mryc6/Y6fec2jEkJVfMHj61k9/qxNdj
         bJwoXibwZwuDUT5JSzx5BGciPb5KaU41VNS6T0D6fMoYEvzK4iJHFcQ3rGPks80+gI1K
         KsphsxfSjaHXBzw1t4HL3vPySbodOVKPMRFftCgxhUDzOG3iI0f+i3JCGpQZzqsWpo2X
         256g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wr6LrFyAd7ihfq5tqEFUsByYRH3eyhXKVadq9w+ENtg=;
        b=sMo3gw1U1pLe8T6lV2QAQnCHcYhBuYRuYYSmFQd0nWTLdUAHoO4RkHp0RBoaPFnj1t
         uxVT+LhIzM/QrADMYas86f8lgRJjeoLvTn8Vn8RYIopR9+pD4ows1POfnag1Oxj//318
         iv2aHcwtThguXwgGDqP99Fxsf7tC23pGHAg8varP4FxWMZBHq7pWCENCO7BLuz37YxjH
         lGpjjrFVTAIj/0lleTmWsU61+BpI7OLVKayYBQDs5SSHGFbrs5rHxwx/di2UXx/8kgcy
         Bn4HP9Own9Aj7AaIO+dn7RrTLVviJvkwStwkqhQX7f/ogsF+FIZ/uYQ4M7g828hcN3OZ
         hmXg==
X-Gm-Message-State: AOAM532HoHGx5vwlyqaoRMRdxoWrSy3KC18t7/0bkoh61wzw1TObMWez
        oD57uU5m5CGUwj7l1Dn09JseOtySHsE=
X-Google-Smtp-Source: ABdhPJxakeb6jyqT8o5VrOoOF84dg7eWQvNBEP8l9oWZbkjdFpI4rIxp7N1Xy068oyb2uVsh5/YyKQ==
X-Received: by 2002:a05:600c:47d7:: with SMTP id l23mr557507wmo.155.1616014600123;
        Wed, 17 Mar 2021 13:56:40 -0700 (PDT)
Received: from ylate.lan (atoulouse-654-1-299-135.w86-199.abo.wanadoo.fr. [86.199.82.135])
        by smtp.googlemail.com with ESMTPSA id g5sm158452wrq.30.2021.03.17.13.56.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Mar 2021 13:56:39 -0700 (PDT)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [PATCH v7 04/15] merge-index: libify merge_one_path() and merge_all()
Date:   Wed, 17 Mar 2021 21:49:28 +0100
Message-Id: <20210317204939.17890-5-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210317204939.17890-1-alban.gruin@gmail.com>
References: <20201124115315.13311-1-alban.gruin@gmail.com>
 <20210317204939.17890-1-alban.gruin@gmail.com>
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
 Makefile              |  1 +
 builtin/merge-index.c | 90 +++++++++++++++----------------------------
 merge-strategies.c    | 75 ++++++++++++++++++++++++++++++++++++
 merge-strategies.h    | 18 +++++++++
 4 files changed, 125 insertions(+), 59 deletions(-)
 create mode 100644 merge-strategies.c
 create mode 100644 merge-strategies.h

diff --git a/Makefile b/Makefile
index dfb0f1000f..1b1dc49e86 100644
--- a/Makefile
+++ b/Makefile
@@ -913,6 +913,7 @@ LIB_OBJS += merge-blobs.o
 LIB_OBJS += merge-ort.o
 LIB_OBJS += merge-ort-wrappers.o
 LIB_OBJS += merge-recursive.o
+LIB_OBJS += merge-strategies.o
 LIB_OBJS += merge.o
 LIB_OBJS += mergesort.o
 LIB_OBJS += midx.o
diff --git a/builtin/merge-index.c b/builtin/merge-index.c
index 38ea6ad6ca..70f440d9a0 100644
--- a/builtin/merge-index.c
+++ b/builtin/merge-index.c
@@ -1,74 +1,43 @@
 #define USE_THE_INDEX_COMPATIBILITY_MACROS
 #include "builtin.h"
+#include "merge-strategies.h"
 #include "run-command.h"
 
 static const char *pgm;
-static int one_shot, quiet;
-static int err;
 
-static int merge_entry(int pos, const char *path)
+static int merge_one_file_spawn(struct index_state *istate,
+				const struct object_id *orig_blob,
+				const struct object_id *our_blob,
+				const struct object_id *their_blob, const char *path,
+				unsigned int orig_mode, unsigned int our_mode, unsigned int their_mode,
+				void *data)
 {
-	int found;
-	const char *arguments[] = { pgm, "", "", "", path, "", "", "", NULL };
-	char hexbuf[4][GIT_MAX_HEXSZ + 1];
-	char ownbuf[4][60];
+	char oids[3][GIT_MAX_HEXSZ + 1] = {{0}};
+	char modes[3][10] = {{0}};
+	const char *arguments[] = { pgm, oids[0], oids[1], oids[2],
+				    path, modes[0], modes[1], modes[2], NULL };
 
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
+	if (orig_blob) {
+		oid_to_hex_r(oids[0], orig_blob);
+		xsnprintf(modes[0], sizeof(modes[0]), "%06o", orig_mode);
 	}
-	return found;
-}
-
-static void merge_one_path(const char *path)
-{
-	int pos = cache_name_pos(path, strlen(path));
 
-	/*
-	 * If it already exists in the cache as stage0, it's
-	 * already merged and there is nothing to do.
-	 */
-	if (pos < 0)
-		merge_entry(-pos-1, path);
-}
+	if (our_blob) {
+		oid_to_hex_r(oids[1], our_blob);
+		xsnprintf(modes[1], sizeof(modes[1]), "%06o", our_mode);
+	}
 
-static void merge_all(void)
-{
-	int i;
-	for (i = 0; i < active_nr; i++) {
-		const struct cache_entry *ce = active_cache[i];
-		if (!ce_stage(ce))
-			continue;
-		i += merge_entry(i, ce->name)-1;
+	if (their_blob) {
+		oid_to_hex_r(oids[2], their_blob);
+		xsnprintf(modes[2], sizeof(modes[2]), "%06o", their_mode);
 	}
+
+	return run_command_v_opt(arguments, 0);
 }
 
 int cmd_merge_index(int argc, const char **argv, const char *prefix)
 {
-	int i, force_file = 0;
+	int i, force_file = 0, err = 0, one_shot = 0, quiet = 0;
 
 	/* Without this we cannot rely on waitpid() to tell
 	 * what happened to our children.
@@ -89,7 +58,9 @@ int cmd_merge_index(int argc, const char **argv, const char *prefix)
 		quiet = 1;
 		i++;
 	}
+
 	pgm = argv[i++];
+
 	for (; i < argc; i++) {
 		const char *arg = argv[i];
 		if (!force_file && *arg == '-') {
@@ -98,14 +69,15 @@ int cmd_merge_index(int argc, const char **argv, const char *prefix)
 				continue;
 			}
 			if (!strcmp(arg, "-a")) {
-				merge_all();
+				err |= merge_all_index(&the_index, one_shot, quiet,
+						       merge_one_file_spawn, NULL);
 				continue;
 			}
 			die("git merge-index: unknown option %s", arg);
 		}
-		merge_one_path(arg);
+		err |= merge_index_path(&the_index, one_shot, quiet, arg,
+					merge_one_file_spawn, NULL);
 	}
-	if (err && !quiet)
-		die("merge program failed");
+
 	return err;
 }
diff --git a/merge-strategies.c b/merge-strategies.c
new file mode 100644
index 0000000000..c80f964612
--- /dev/null
+++ b/merge-strategies.c
@@ -0,0 +1,75 @@
+#include "cache.h"
+#include "merge-strategies.h"
+
+static int merge_entry(struct index_state *istate, int quiet, unsigned int pos,
+		       const char *path, int *err, merge_fn fn, void *data)
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
+	if (fn(istate, oids[0], oids[1], oids[2], path,
+	       modes[0], modes[1], modes[2], data)) {
+		if (!quiet)
+			error(_("Merge program failed"));
+		(*err)++;
+	}
+
+	return found;
+}
+
+int merge_index_path(struct index_state *istate, int oneshot, int quiet,
+		     const char *path, merge_fn fn, void *data)
+{
+	int pos = index_name_pos(istate, path, strlen(path)), ret, err = 0;
+
+	/*
+	 * If it already exists in the cache as stage0, it's
+	 * already merged and there is nothing to do.
+	 */
+	if (pos < 0) {
+		ret = merge_entry(istate, quiet || oneshot, -pos - 1, path, &err, fn, data);
+		if (ret == -1)
+			return -1;
+		else if (err)
+			return 1;
+	}
+	return 0;
+}
+
+int merge_all_index(struct index_state *istate, int oneshot, int quiet,
+		    merge_fn fn, void *data)
+{
+	int err = 0, ret;
+	unsigned int i;
+
+	for (i = 0; i < istate->cache_nr; i++) {
+		const struct cache_entry *ce = istate->cache[i];
+		if (!ce_stage(ce))
+			continue;
+
+		ret = merge_entry(istate, quiet || oneshot, i, ce->name, &err, fn, data);
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
new file mode 100644
index 0000000000..88f476f170
--- /dev/null
+++ b/merge-strategies.h
@@ -0,0 +1,18 @@
+#ifndef MERGE_STRATEGIES_H
+#define MERGE_STRATEGIES_H
+
+#include "object.h"
+
+typedef int (*merge_fn)(struct index_state *istate,
+			const struct object_id *orig_blob,
+			const struct object_id *our_blob,
+			const struct object_id *their_blob, const char *path,
+			unsigned int orig_mode, unsigned int our_mode, unsigned int their_mode,
+			void *data);
+
+int merge_index_path(struct index_state *istate, int oneshot, int quiet,
+		     const char *path, merge_fn fn, void *data);
+int merge_all_index(struct index_state *istate, int oneshot, int quiet,
+		    merge_fn fn, void *data);
+
+#endif /* MERGE_STRATEGIES_H */
-- 
2.31.0

