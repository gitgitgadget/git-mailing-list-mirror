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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F79CC433DF
	for <git@archiver.kernel.org>; Thu, 25 Jun 2020 12:49:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E556520724
	for <git@archiver.kernel.org>; Thu, 25 Jun 2020 12:49:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lbuWKByV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404806AbgFYMtG (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 25 Jun 2020 08:49:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404764AbgFYMtD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Jun 2020 08:49:03 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5193FC061573
        for <git@vger.kernel.org>; Thu, 25 Jun 2020 05:49:02 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id a6so6667164wmm.0
        for <git@vger.kernel.org>; Thu, 25 Jun 2020 05:49:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XMoEEopApLD1TvKM4EE4u4Zq4iE+6s/yqAo5OCEk7bY=;
        b=lbuWKByVaV3dqXnnNxF6+Gk3WQ4nhGcDSA+S9eQtVWV3kSfkVLNx5jew/QgwyFW3iW
         lNnxt93gOma/dX3QtpZUueR+NaFdKzwyCkmn9qDQbvQ8hAKqWYU9Rnuc8DjHAFczXEMp
         KZt6zRKedvrnfMIE6ANdzQ7Myt1M89nz0jI4TSyLA8Pzbzxm4kLCbgqiHlRtt2OJo7XU
         0p4scb4UmPAHhGEOZTahx5ucyjamqzclo6h1h6Uk8vUI/Rsu9PShRG8Ikdnd1BtdBmPF
         FAZucXR1O1/SSg8OW8WjKpPGl4YEqiNVDShgQ44MgHDAAG8AWSh7oKpJbrECb9VfXHnw
         QAdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XMoEEopApLD1TvKM4EE4u4Zq4iE+6s/yqAo5OCEk7bY=;
        b=AZ+Oc19rpYtKdnaMhZQ79tgp1ZRUP79tLlFIYvXQzaK7Q6Y2sJaCNmfc3txOkvjZ5a
         XTbYORiWALA2UvGCoZgCC4bTobsnPtde3hsmip7dYG3kVmn8vZQ3dF32QAej+uKrqjXU
         77jjVMvagv+Bvru0DvEjaoaUn4NhH05LgRMWxiK4ZV6eGN/GGRrv3yGLtaNRB3vHU/eQ
         90+bLK4ZNCG0Oq830wkzt9CivFMZtE0gdUfO2PXM5KJiGdja3DrfMJ5reYUjrr/p9phk
         sXsPx285lzB8J94KJK7GdxhyrNd9gnq16suz/TRZlkgqoh6a5iQm3Epak/y5oOSKgaPR
         P39w==
X-Gm-Message-State: AOAM531aPC9c0WfeI2izcMj9XpqZfnlK/dh0aI0aqr5AbrNTjipfGSrM
        IrJhgY3sGKRHo8zcyoxJ8+IYQ5Sb
X-Google-Smtp-Source: ABdhPJyYjB69uCM3LWEg1lHqBsouOVXO9PrYk1Q2uLArKakMvD/ahHapS648fSZ3j+Ph+Uc7nLZ9GA==
X-Received: by 2002:a1c:f00a:: with SMTP id a10mr3295678wmb.61.1593089340103;
        Thu, 25 Jun 2020 05:49:00 -0700 (PDT)
Received: from ylate.lan (atoulouse-654-1-308-216.w86-199.abo.wanadoo.fr. [86.199.91.216])
        by smtp.googlemail.com with ESMTPSA id y16sm31563409wro.71.2020.06.25.05.48.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2020 05:48:59 -0700 (PDT)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [RFC PATCH v1 05/17] merge-one-file: libify merge_one_file()
Date:   Thu, 25 Jun 2020 14:19:41 +0200
Message-Id: <20200625121953.16991-6-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200625121953.16991-1-alban.gruin@gmail.com>
References: <20200625121953.16991-1-alban.gruin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This moves merge_one_file() (and its helper functions) to a new file,
merge-strategies.c.  This will enable the resolve and octopus strategies
to directly call it instead of forking.  It is also renamed
merge_strategies_one_file().

This is not a faithful copy-and-paste; in the builtin versions,
merge_one_file() operated on `the_repository' and `the_index', something
we cannot allow a function part of libgit.a to do.  Hence, it now takes
a pointer to a repository as its first argument (and helper functions
takes a pointer to an `index_state').

Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
---

Notes:
    This patch is best viewed with `--color-moved'.

 Makefile                 |   1 +
 builtin/merge-one-file.c | 190 +-------------------------------------
 merge-strategies.c       | 191 +++++++++++++++++++++++++++++++++++++++
 merge-strategies.h       |  13 +++
 4 files changed, 209 insertions(+), 186 deletions(-)
 create mode 100644 merge-strategies.c
 create mode 100644 merge-strategies.h

diff --git a/Makefile b/Makefile
index 19574f5133..1ab4d160cb 100644
--- a/Makefile
+++ b/Makefile
@@ -911,6 +911,7 @@ LIB_OBJS += match-trees.o
 LIB_OBJS += mem-pool.o
 LIB_OBJS += merge-blobs.o
 LIB_OBJS += merge-recursive.o
+LIB_OBJS += merge-strategies.o
 LIB_OBJS += merge.o
 LIB_OBJS += mergesort.o
 LIB_OBJS += midx.o
diff --git a/builtin/merge-one-file.c b/builtin/merge-one-file.c
index d612885723..2f7a3e1db2 100644
--- a/builtin/merge-one-file.c
+++ b/builtin/merge-one-file.c
@@ -23,191 +23,8 @@
 #define USE_THE_INDEX_COMPATIBILITY_MACROS
 #include "cache.h"
 #include "builtin.h"
-#include "commit.h"
-#include "dir.h"
 #include "lockfile.h"
-#include "object-store.h"
-#include "xdiff-interface.h"
-
-static int add_to_index_cacheinfo(unsigned int mode,
-				  const struct object_id *oid, const char *path)
-{
-	struct cache_entry *ce;
-	int len, option;
-
-	if (!verify_path(path, mode))
-		return error("Invalid path '%s'", path);
-
-	len = strlen(path);
-	ce = make_empty_cache_entry(&the_index, len);
-
-	oidcpy(&ce->oid, oid);
-	memcpy(ce->name, path, len);
-	ce->ce_flags = create_ce_flags(0);
-	ce->ce_namelen = len;
-	ce->ce_mode = create_ce_mode(mode);
-	if (assume_unchanged)
-		ce->ce_flags |= CE_VALID;
-	option = ADD_CACHE_OK_TO_ADD | ADD_CACHE_OK_TO_REPLACE;
-	if (add_cache_entry(ce, option))
-		return error("%s: cannot add to the index", path);
-
-	return 0;
-}
-
-static int checkout_from_index(const char *path)
-{
-	struct checkout state;
-	struct cache_entry *ce;
-
-	state.istate = &the_index;
-	state.force = 1;
-	state.base_dir = "";
-	state.base_dir_len = 0;
-
-	ce = cache_file_exists(path, strlen(path), 0);
-	if (checkout_entry(ce, &state, NULL, NULL) < 0)
-		return error("%s: cannot checkout file", path);
-	return 0;
-}
-
-static int merge_one_file_deleted(const struct object_id *orig_blob,
-				  const struct object_id *our_blob,
-				  const struct object_id *their_blob, const char *path,
-				  unsigned int orig_mode, unsigned int our_mode, unsigned int their_mode)
-{
-	if ((our_blob && orig_mode != our_mode) ||
-	    (their_blob && orig_mode != their_mode))
-		return error(_("File %s deleted on one branch but had its "
-			       "permissions changed on the other."), path);
-
-	if (our_blob) {
-		printf("Removing %s\n", path);
-
-		if (file_exists(path))
-			remove_path(path);
-	}
-
-	if (remove_file_from_cache(path))
-		return error("%s: cannot remove from the index", path);
-	return 0;
-}
-
-static int do_merge_one_file(const struct object_id *orig_blob,
-			     const struct object_id *our_blob,
-			     const struct object_id *their_blob, const char *path,
-			     unsigned int orig_mode, unsigned int our_mode, unsigned int their_mode)
-{
-	int ret, i, dest;
-	mmbuffer_t result = {NULL, 0};
-	mmfile_t mmfs[3];
-	xmparam_t xmp = {{0}};
-	struct cache_entry *ce;
-
-	if (our_mode == S_IFLNK || their_mode == S_IFLNK)
-		return error(_("%s: Not merging symbolic link changes."), path);
-	else if (our_mode == S_IFGITLINK || their_mode == S_IFGITLINK)
-		return error(_("%s: Not merging conflicting submodule changes."), path);
-
-	read_mmblob(mmfs + 0, our_blob);
-	read_mmblob(mmfs + 2, their_blob);
-
-	if (orig_blob) {
-		printf("Auto-merging %s\n", path);
-		read_mmblob(mmfs + 1, orig_blob);
-	} else {
-		printf("Added %s in both, but differently.\n", path);
-		read_mmblob(mmfs + 1, the_hash_algo->empty_blob);
-	}
-
-	xmp.level = XDL_MERGE_ZEALOUS_ALNUM;
-	xmp.style = 0;
-	xmp.favor = 0;
-
-	ret = xdl_merge(mmfs + 1, mmfs + 0, mmfs + 2, &xmp, &result);
-
-	for (i = 0; i < 3; i++)
-		free(mmfs[i].ptr);
-
-	if (ret > 127)
-		ret = 1;
-
-	ce = cache_file_exists(path, strlen(path), 0);
-	if (!ce)
-		BUG("file is not present in the cache?");
-
-	unlink(path);
-	dest = open(path, O_WRONLY | O_CREAT, ce->ce_mode);
-	write_in_full(dest, result.ptr, result.size);
-	close(dest);
-
-	free(result.ptr);
-
-	if (ret) {
-		if (!orig_blob)
-			error(_("content conflict in %s"), path);
-		if (our_mode != their_mode)
-			error(_("permission conflict: %o->%o,%o in %s"),
-			      orig_mode, our_mode, their_mode, path);
-
-		return 1;
-	}
-
-	return add_file_to_cache(path, 0);
-}
-
-static int merge_one_file(const struct object_id *orig_blob,
-			  const struct object_id *our_blob,
-			  const struct object_id *their_blob, const char *path,
-			  unsigned int orig_mode, unsigned int our_mode, unsigned int their_mode)
-{
-	if (orig_blob &&
-	    ((our_blob && oideq(orig_blob, our_blob)) ||
-	     (their_blob && oideq(orig_blob, their_blob))))
-		return merge_one_file_deleted(orig_blob, our_blob, their_blob, path,
-					      orig_mode, our_mode, their_mode);
-	else if (!orig_blob && our_blob && !their_blob) {
-		return add_to_index_cacheinfo(our_mode, our_blob, path);
-	} else if (!orig_blob && !our_blob && their_blob) {
-		printf("Adding %s\n", path);
-
-		if (file_exists(path))
-			return error(_("untracked %s is overwritten by the merge."), path);
-
-		if (add_to_index_cacheinfo(their_mode, their_blob, path))
-			return 1;
-		return checkout_from_index(path);
-	} else if (!orig_blob && our_blob && their_blob &&
-		   oideq(our_blob, their_blob)) {
-		if (our_mode != their_mode)
-			return error(_("File %s added identically in both branches, "
-				       "but permissions conflict %o->%o."),
-				     path, our_mode, their_mode);
-
-		printf("Adding %s\n", path);
-
-		if (add_to_index_cacheinfo(our_mode, our_blob, path))
-			return 1;
-		return checkout_from_index(path);
-	} else if (our_blob && their_blob)
-		return do_merge_one_file(orig_blob, our_blob, their_blob, path,
-					 orig_mode, our_mode, their_mode);
-	else {
-		char *orig_hex = "", *our_hex = "", *their_hex = "";
-
-		if (orig_blob)
-			orig_hex = oid_to_hex(orig_blob);
-		if (our_blob)
-			our_hex = oid_to_hex(our_blob);
-		if (their_blob)
-			their_hex = oid_to_hex(their_blob);
-
-		return error(_("%s: Not handling case %s -> %s -> %s"),
-			path, orig_hex, our_hex, their_hex);
-	}
-
-	return 0;
-}
+#include "merge-strategies.h"
 
 static const char builtin_merge_one_file_usage[] =
 	"git merge-one-file <orig blob> <our blob> <their blob> <path> "
@@ -244,8 +61,9 @@ int cmd_merge_one_file(int argc, const char **argv, const char *prefix)
 		their_mode = strtol(argv[7], NULL, 8);
 	}
 
-	ret = merge_one_file(p_orig_blob, p_our_blob, p_their_blob, argv[4],
-			     orig_mode, our_mode, their_mode);
+	ret = merge_strategies_one_file(the_repository,
+					p_orig_blob, p_our_blob, p_their_blob, argv[4],
+					orig_mode, our_mode, their_mode);
 
 	if (ret) {
 		rollback_lock_file(&lock);
diff --git a/merge-strategies.c b/merge-strategies.c
new file mode 100644
index 0000000000..3a9fce9f22
--- /dev/null
+++ b/merge-strategies.c
@@ -0,0 +1,191 @@
+#include "cache.h"
+#include "dir.h"
+#include "merge-strategies.h"
+#include "xdiff-interface.h"
+
+static int add_to_index_cacheinfo(struct index_state *istate,
+				  unsigned int mode,
+				  const struct object_id *oid, const char *path)
+{
+	struct cache_entry *ce;
+	int len, option;
+
+	if (!verify_path(path, mode))
+		return error(_("Invalid path '%s'"), path);
+
+	len = strlen(path);
+	ce = make_empty_cache_entry(istate, len);
+
+	oidcpy(&ce->oid, oid);
+	memcpy(ce->name, path, len);
+	ce->ce_flags = create_ce_flags(0);
+	ce->ce_namelen = len;
+	ce->ce_mode = create_ce_mode(mode);
+	if (assume_unchanged)
+		ce->ce_flags |= CE_VALID;
+	option = ADD_CACHE_OK_TO_ADD | ADD_CACHE_OK_TO_REPLACE;
+	if (add_index_entry(istate, ce, option))
+		return error(_("%s: cannot add to the index"), path);
+
+	return 0;
+}
+
+static int checkout_from_index(struct index_state *istate, const char *path)
+{
+	struct checkout state = CHECKOUT_INIT;
+	struct cache_entry *ce;
+
+	state.istate = istate;
+	state.force = 1;
+	state.base_dir = "";
+	state.base_dir_len = 0;
+
+	ce = index_file_exists(istate, path, strlen(path), 0);
+	if (checkout_entry(ce, &state, NULL, NULL) < 0)
+		return error(_("%s: cannot checkout file"), path);
+	return 0;
+}
+
+static int merge_one_file_deleted(struct index_state *istate,
+				  const struct object_id *orig_blob,
+				  const struct object_id *our_blob,
+				  const struct object_id *their_blob, const char *path,
+				  unsigned int orig_mode, unsigned int our_mode, unsigned int their_mode)
+{
+	if ((our_blob && orig_mode != our_mode) ||
+	    (their_blob && orig_mode != their_mode))
+		return error(_("File %s deleted on one branch but had its "
+			       "permissions changed on the other."), path);
+
+	if (our_blob) {
+		printf("Removing %s\n", path);
+
+		if (file_exists(path))
+			remove_path(path);
+	}
+
+	if (remove_file_from_index(istate, path))
+		return error("%s: cannot remove from the index", path);
+	return 0;
+}
+
+static int do_merge_one_file(struct index_state *istate,
+			     const struct object_id *orig_blob,
+			     const struct object_id *our_blob,
+			     const struct object_id *their_blob, const char *path,
+			     unsigned int orig_mode, unsigned int our_mode, unsigned int their_mode)
+{
+	int ret, i, dest;
+	mmbuffer_t result = {NULL, 0};
+	mmfile_t mmfs[3];
+	xmparam_t xmp = {{0}};
+	struct cache_entry *ce;
+
+	if (our_mode == S_IFLNK || their_mode == S_IFLNK)
+		return error(_("%s: Not merging symbolic link changes."), path);
+	else if (our_mode == S_IFGITLINK || their_mode == S_IFGITLINK)
+		return error(_("%s: Not merging conflicting submodule changes."), path);
+
+	read_mmblob(mmfs + 0, our_blob);
+	read_mmblob(mmfs + 2, their_blob);
+
+	if (orig_blob) {
+		printf("Auto-merging %s\n", path);
+		read_mmblob(mmfs + 1, orig_blob);
+	} else {
+		printf("Added %s in both, but differently.\n", path);
+		read_mmblob(mmfs + 1, &null_oid);
+	}
+
+	xmp.level = XDL_MERGE_ZEALOUS_ALNUM;
+	xmp.style = 0;
+	xmp.favor = 0;
+
+	ret = xdl_merge(mmfs + 1, mmfs + 0, mmfs + 2, &xmp, &result);
+
+	for (i = 0; i < 3; i++)
+		free(mmfs[i].ptr);
+
+	if (ret > 127)
+		ret = 1;
+
+	ce = index_file_exists(istate, path, strlen(path), 0);
+	if (!ce)
+		BUG("file is not present in the cache?");
+
+	unlink(path);
+	dest = open(path, O_WRONLY | O_CREAT, ce->ce_mode);
+	write_in_full(dest, result.ptr, result.size);
+	close(dest);
+
+	free(result.ptr);
+
+	if (ret) {
+		if (!orig_blob)
+			error(_("content conflict in %s"), path);
+		if (our_mode != their_mode)
+			error(_("permission conflict: %o->%o,%o in %s"),
+			      orig_mode, our_mode, their_mode, path);
+
+		return 1;
+	}
+
+	return add_file_to_index(istate, path, 0);
+}
+
+int merge_strategies_one_file(struct repository *r,
+			      const struct object_id *orig_blob,
+			      const struct object_id *our_blob,
+			      const struct object_id *their_blob, const char *path,
+			      unsigned int orig_mode, unsigned int our_mode,
+			      unsigned int their_mode)
+{
+	if (orig_blob &&
+	    ((our_blob && oideq(orig_blob, our_blob)) ||
+	     (their_blob && oideq(orig_blob, their_blob))))
+		return merge_one_file_deleted(r->index,
+					      orig_blob, our_blob, their_blob, path,
+					      orig_mode, our_mode, their_mode);
+	else if (!orig_blob && our_blob && !their_blob) {
+		return add_to_index_cacheinfo(r->index, our_mode, our_blob, path);
+	} else if (!orig_blob && !our_blob && their_blob) {
+		printf("Adding %s\n", path);
+
+		if (file_exists(path))
+			return error(_("untracked %s is overwritten by the merge."), path);
+
+		if (add_to_index_cacheinfo(r->index, their_mode, their_blob, path))
+			return 1;
+		return checkout_from_index(r->index, path);
+	} else if (!orig_blob && our_blob && their_blob &&
+		   oideq(our_blob, their_blob)) {
+		if (our_mode != their_mode)
+			return error(_("File %s added identically in both branches, "
+				       "but permissions conflict %o->%o."),
+				     path, our_mode, their_mode);
+
+		printf("Adding %s\n", path);
+
+		if (add_to_index_cacheinfo(r->index, our_mode, our_blob, path))
+			return 1;
+		return checkout_from_index(r->index, path);
+	} else if (our_blob && their_blob)
+		return do_merge_one_file(r->index,
+					 orig_blob, our_blob, their_blob, path,
+					 orig_mode, our_mode, their_mode);
+	else {
+		char *orig_hex = "", *our_hex = "", *their_hex = "";
+
+		if (orig_blob)
+			orig_hex = oid_to_hex(orig_blob);
+		if (our_blob)
+			our_hex = oid_to_hex(our_blob);
+		if (their_blob)
+			their_hex = oid_to_hex(their_blob);
+
+		return error(_("%s: Not handling case %s -> %s -> %s"),
+			path, orig_hex, our_hex, their_hex);
+	}
+
+	return 0;
+}
diff --git a/merge-strategies.h b/merge-strategies.h
new file mode 100644
index 0000000000..b527d145c7
--- /dev/null
+++ b/merge-strategies.h
@@ -0,0 +1,13 @@
+#ifndef MERGE_STRATEGIES_H
+#define MERGE_STRATEGIES_H
+
+#include "object.h"
+
+int merge_strategies_one_file(struct repository *r,
+			      const struct object_id *orig_blob,
+			      const struct object_id *our_blob,
+			      const struct object_id *their_blob, const char *path,
+			      unsigned int orig_mode, unsigned int our_mode,
+			      unsigned int their_mode);
+
+#endif /* MERGE_STRATEGIES_H */
-- 
2.27.0.139.gc9c318d6bf

