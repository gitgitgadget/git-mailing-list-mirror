Return-Path: <SRS0=R7wA=DM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00836C4727D
	for <git@archiver.kernel.org>; Mon,  5 Oct 2020 12:27:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B3B80208A9
	for <git@archiver.kernel.org>; Mon,  5 Oct 2020 12:27:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X5nAJQ9U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726197AbgJEM1n (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Oct 2020 08:27:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726138AbgJEM1m (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Oct 2020 08:27:42 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C82D1C0613A8
        for <git@vger.kernel.org>; Mon,  5 Oct 2020 05:27:41 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id e18so3435282wrw.9
        for <git@vger.kernel.org>; Mon, 05 Oct 2020 05:27:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VqPu+6eMDaMas6kXEYkJIlsPiQuAzz9VhfIi/RUao9U=;
        b=X5nAJQ9Uw4hSJD+fuTK+9hSuMDr2cXfnTjnucyOnESGW7F1QGmDDsc1QOXANNA6sA4
         8p/KwDCwqxdfCqAgCINZcIsmrvTZ35Ot+qJGuYYprSDmi72cfm05jO4Br3cOqDfpqk8i
         Ewec9v5RJkMILmbBCGmre5t17sDwf00Et4mvqXib1XNps4W2XBEOrnrqN/NeJpZjrnHT
         4NdIOQxfEkmS3Htw+z3stf0fv+nMPNarY+l+o4l06EKW65OK/+Jnpf3gGPi3ClaaftDR
         mdS66jPDNMCbWqrcmyV4DgcFVQug6yz9EtfoEeZf1oj9KeZfvXhzJA6UiuPdQReJKBYW
         BNMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VqPu+6eMDaMas6kXEYkJIlsPiQuAzz9VhfIi/RUao9U=;
        b=puFEKiVlXdr/2wH2gsyWnpEYjzOwD8lzi2Ehn95C0zt0pycGJaJsYltN0GeMZs5P1y
         oJLbB7z9To6Ye4zhn9A5Ll9MmZaeyXwN4zqYzuXl+Xd2XKBdStvqMZ2/Wei4OHlcLgiW
         4m2F/EHkoGoqKg28G+FCxSSYRO0bdqUE0GmVBCcuY1+J76EGm4Qc2za2udUfMEShfGDX
         sVNN4G5AfmfoA3Z4DtJm6/0SRuc4nRqDsqPqLJa3pbL5M0d8AZBhT5AJHQUXbusEu16H
         1d8+O0QUgP7n2cVvaaLs5VfUcSJReHUc0SWkFAc5rvzdE6Rw6RmUNAc+n1PJfS0mJcXn
         eVwQ==
X-Gm-Message-State: AOAM531yp3mqz+rzpToYvyKaQC4TMlGfN8HUtLFsJJaVenhghFLLaD2d
        gPEoLchEL2r0gBnrkbb6u3w69oneg9A=
X-Google-Smtp-Source: ABdhPJy8EAcQp2DcZhGC1bkIdEZBLCdciINUCRVPKw8Bx/OvhSZd9jFp21Fma2yOgNmUYtg39x/KWw==
X-Received: by 2002:adf:eb8f:: with SMTP id t15mr17398909wrn.417.1601900860109;
        Mon, 05 Oct 2020 05:27:40 -0700 (PDT)
Received: from ylate.lan (atoulouse-654-1-293-21.w86-199.abo.wanadoo.fr. [86.199.76.21])
        by smtp.googlemail.com with ESMTPSA id n2sm13270400wma.29.2020.10.05.05.27.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2020 05:27:39 -0700 (PDT)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, phillip.wood@dunelm.org.uk,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [PATCH v3 03/11] merge-index: libify merge_one_path() and merge_all()
Date:   Mon,  5 Oct 2020 14:26:38 +0200
Message-Id: <20201005122646.27994-4-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201005122646.27994-1-alban.gruin@gmail.com>
References: <20200901105705.6059-1-alban.gruin@gmail.com>
 <20201005122646.27994-1-alban.gruin@gmail.com>
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

To avoid this, this moves merge_one_path(), merge_all(), and their
helpers to merge-strategies.c.  They also take a callback to dictate
what they should do for each file.  For now, to preserve the behaviour
of `merge-index', only one callback, launching a new process, is
defined.

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
index bbe6f48698..f0e30f5624 100644
--- a/merge-strategies.c
+++ b/merge-strategies.c
@@ -2,6 +2,7 @@
 #include "dir.h"
 #include "ll-merge.h"
 #include "merge-strategies.h"
+#include "run-command.h"
 #include "xdiff-interface.h"
 
 static int add_to_index_cacheinfo(struct index_state *istate,
@@ -212,3 +213,101 @@ int merge_strategies_one_file(struct repository *r,
 
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
2.28.0.662.ge304723957

