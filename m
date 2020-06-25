Return-Path: <SRS0=4a08=AG=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23B1CC433E2
	for <git@archiver.kernel.org>; Thu, 25 Jun 2020 12:49:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F2D6F206BE
	for <git@archiver.kernel.org>; Thu, 25 Jun 2020 12:49:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h4MDQ5hH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404813AbgFYMtH (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 25 Jun 2020 08:49:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404800AbgFYMtE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Jun 2020 08:49:04 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC740C0613ED
        for <git@vger.kernel.org>; Thu, 25 Jun 2020 05:49:02 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id g75so5411620wme.5
        for <git@vger.kernel.org>; Thu, 25 Jun 2020 05:49:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=J7i8/kL9gIgWQQaUI1ZRXUK2V1w/DeNPWkP/9+CrIzU=;
        b=h4MDQ5hHTcbWLpyQfXDb3WrRLDxOBdLneDDS3At5Ni2ayOhhLSvQZQypuujD6ohNb2
         S/2ahEBQNMhXsxcLmJ7AHver4EVDj3KVTvyOn25vcRx6V9+ExWe9GLD462vgXqer/3kU
         nCi/BWqO1ej3hXs9mvwVPz/HSww2zzWoB+KQi3vh5Kp0BVAAOeDqySOKlUQ1vt++bwWo
         7j7/4Toze4YKXtq+inXZHEmmrSHWCzPXSJ4KS72lrfVCO/icaooTScDtHXsm7qDbnqHj
         kej3aHOGzoJeOERHcT2/AkdDqNhDvtzfoTDPgG/a9cDUZLzLZbY0pnNTQkIFzGNz4ssj
         71EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=J7i8/kL9gIgWQQaUI1ZRXUK2V1w/DeNPWkP/9+CrIzU=;
        b=tzi28xkbQWPiK5P5Anto5BhLBLlPqMrVOMqhO8u85nvnOKtFD6l1/hTu61k7ZZB2UU
         cqB0PhrbPVN75V4at3t9BTr+VHIGq31YnihXeO6nZ84rOfMc61P/kHNjrU9ZIIqeIcmf
         ozu/4mwjWDvHkG3SUMSJDvRb3UrEEUVIVYM5ONpBAx92rx6/0jlxZnKv4S5zbkqKYERI
         XoZrlLEopvGTz/MFkER8gvCs6EvLFe25bxb2KFJ0rIMhhuIO9UevI6n2osW7WI6Yd0YE
         CW04XwdAgSgYc8B0cHoydMrolLG+Uirvhbt7VRFIw9e5+/ORanjDh+TzV526aC2ailCH
         +JsA==
X-Gm-Message-State: AOAM530AfGLxIeOMTVSwUsmRbNq3moBz6q1zPJh5DnvJnCECuYbI3zGW
        Fgk0pPwb67vlcnxcGlZjzhV6gb/P
X-Google-Smtp-Source: ABdhPJy9L2KKl+cDSY7GYdYxo9ZTJf9w3PobsVvJIGR8TNcuy0nxX9Yr+1Hv321qf6BF3hliOgAT5A==
X-Received: by 2002:a1c:80d3:: with SMTP id b202mr3300566wmd.111.1593089341167;
        Thu, 25 Jun 2020 05:49:01 -0700 (PDT)
Received: from ylate.lan (atoulouse-654-1-308-216.w86-199.abo.wanadoo.fr. [86.199.91.216])
        by smtp.googlemail.com with ESMTPSA id y16sm31563409wro.71.2020.06.25.05.49.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2020 05:49:00 -0700 (PDT)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [RFC PATCH v1 06/17] merge-index: libify merge_one_path() and merge_all()
Date:   Thu, 25 Jun 2020 14:19:42 +0200
Message-Id: <20200625121953.16991-7-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200625121953.16991-1-alban.gruin@gmail.com>
References: <20200625121953.16991-1-alban.gruin@gmail.com>
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

Notes:
    This patch is best viewed with `--color-moved'.

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
index 3a9fce9f22..f4c0b4acd6 100644
--- a/merge-strategies.c
+++ b/merge-strategies.c
@@ -1,6 +1,7 @@
 #include "cache.h"
 #include "dir.h"
 #include "merge-strategies.h"
+#include "run-command.h"
 #include "xdiff-interface.h"
 
 static int add_to_index_cacheinfo(struct index_state *istate,
@@ -189,3 +190,101 @@ int merge_strategies_one_file(struct repository *r,
 
 	return 0;
 }
+
+int merge_program_cb(const struct object_id *orig_blob,
+		     const struct object_id *our_blob,
+		     const struct object_id *their_blob, const char *path,
+		     unsigned int orig_mode, unsigned int our_mode, unsigned int their_mode,
+		     void *data)
+{
+	char ownbuf[3][60] = {{0}};
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
2.27.0.139.gc9c318d6bf

