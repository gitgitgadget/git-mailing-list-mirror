Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11EF3C433FE
	for <git@archiver.kernel.org>; Tue,  1 Feb 2022 14:53:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239580AbiBAOxh (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Feb 2022 09:53:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239532AbiBAOx2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Feb 2022 09:53:28 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45805C06174E
        for <git@vger.kernel.org>; Tue,  1 Feb 2022 06:53:27 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id m14so32322407wrg.12
        for <git@vger.kernel.org>; Tue, 01 Feb 2022 06:53:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Wy0DXbRsLaSHcdG7SuyTzumH2wAkf6mki3FuPUGPjFE=;
        b=epNncQC1Rbc3zti+W0XoFcl2I82W/ejtn42E5IF6yZr2cgbx33TWqOhGpIyEEN9mo4
         AKNDFuvbMAgb0Gc6Sl8AM688H5uSP20rIqIJ65/pYH+wAVoVa7ptRwKv6UJ/4YO1Rpcb
         Gq3Z0iiL+ccATe+E5rOa3YHfGoJDhHJiNiyEOwAqh2f9qSSCRWOY0Fy/CfU6XByQ2LEU
         33BZRoBaUP4WILinMAiOLIISgywPsRnQkmGTy3b65I9Mub8Gf9RXzZnmZFPxNlwG24Wl
         K3yWsat1q7hE6HPQ1IdmFDbU0+idh9fkN9Y8oTdT44tV0R8yn47Gj9r/8E0nxVp1fzIN
         0gcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Wy0DXbRsLaSHcdG7SuyTzumH2wAkf6mki3FuPUGPjFE=;
        b=Y2XTVUHMavpFy0x+0UuyGvYbvfrOtZXrPBNQEvf3F6Pd5GciqFNjXdjZKCmzxAYc+8
         TyXtZXduBX8otNQXumKZ+6vWIBuGOmGJun6lmIlb6HQmP2gxuXBuRNZsPGvvvQMkQXYM
         BbdkmvhNU0XMXSxBZVRQqxVTUerMSXuiIRnQHupUdcFWzIwhziDcXVU5ABBghOYF3QCW
         fDqh2lTH6VLj1ILINl/qAosNtmJx0d2FP84I7dF1J9YoQILaxac1YbB6eTgyLWYdtFBi
         VUJdTjIs8WuBjNFU/DY59C6MUStiekxOQ5B13r8Izxa7X+2FBV/+LUExANEwmvduiUdu
         1GcQ==
X-Gm-Message-State: AOAM531qAgZ+RRhFM+VaSKCyODhqO/JHshIF1Eh4VWG+PjQRxiClVA9Z
        NK5FryHV3p5rAggaDRKU6hsWEKx0uOrT1g==
X-Google-Smtp-Source: ABdhPJxHHyiHUKvE87sSu5UPcHuXglsGxdTolsoM+qn6Da4kyIwMZtpM68ngRSSzKNVdfj5hpCdo8w==
X-Received: by 2002:adf:f50e:: with SMTP id q14mr21874215wro.647.1643727205356;
        Tue, 01 Feb 2022 06:53:25 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id bg17sm2492054wmb.2.2022.02.01.06.53.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Feb 2022 06:53:23 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Han Xin <chiyutianyi@gmail.com>,
        Jiang Xin <worldhello.net@gmail.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 07/10] object-file API: have hash_object_file() take "enum object_type"
Date:   Tue,  1 Feb 2022 15:53:09 +0100
Message-Id: <patch-07.10-ad5d94714cc-20220201T144803Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.0.913.g12b4baa2536
In-Reply-To: <cover-00.10-00000000000-20220201T144803Z-avarab@gmail.com>
References: <cover-00.10-00000000000-20220201T144803Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the hash_object_file() function to take an "enum
object_type".

Almost all of its callers were passing either
"{commit,tree,blob,tag}_type", or the result of a call to
type_name(). Let's instead benefit from type checking and use the enum
directly.

"Almost" because one caller here will now pass OBJ_BAD. The previous
"NULL" value was not used, as "check_object_signature()" will never
use its "type" argument when given a NULL "map" argument, which that
caller in "parse_object()" also does. We'll deal with it in a
subsequent commit, but for now it'll pass an "OBJ_BAD" placeholder.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 apply.c                  |  4 ++--
 builtin/index-pack.c     |  2 +-
 builtin/replace.c        |  2 +-
 builtin/unpack-objects.c |  2 +-
 cache-tree.c             |  6 +++---
 cache.h                  |  2 +-
 convert.c                |  2 +-
 diffcore-rename.c        |  2 +-
 dir.c                    |  2 +-
 log-tree.c               |  2 +-
 object-file.c            | 26 ++++++++++++++------------
 object-store.h           |  3 ++-
 object.c                 |  2 +-
 pack-check.c             |  2 +-
 14 files changed, 31 insertions(+), 28 deletions(-)

diff --git a/apply.c b/apply.c
index e82a7c30f01..8513755e254 100644
--- a/apply.c
+++ b/apply.c
@@ -3157,7 +3157,7 @@ static int apply_binary(struct apply_state *state,
 		 * See if the old one matches what the patch
 		 * applies to.
 		 */
-		hash_object_file(the_hash_algo, img->buf, img->len, blob_type,
+		hash_object_file(the_hash_algo, img->buf, img->len, OBJ_BLOB,
 				 &oid);
 		if (strcmp(oid_to_hex(&oid), patch->old_oid_prefix))
 			return error(_("the patch applies to '%s' (%s), "
@@ -3203,7 +3203,7 @@ static int apply_binary(struct apply_state *state,
 				     name);
 
 		/* verify that the result matches */
-		hash_object_file(the_hash_algo, img->buf, img->len, blob_type,
+		hash_object_file(the_hash_algo, img->buf, img->len, OBJ_BLOB,
 				 &oid);
 		if (strcmp(oid_to_hex(&oid), patch->new_oid_prefix))
 			return error(_("binary patch to '%s' creates incorrect result (expecting %s, got %s)"),
diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 5531a6d8bae..4f2f4550e2e 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -970,7 +970,7 @@ static struct base_data *resolve_delta(struct object_entry *delta_obj,
 	if (!result_data)
 		bad_object(delta_obj->idx.offset, _("failed to apply delta"));
 	hash_object_file(the_hash_algo, result_data, result_size,
-			 type_name(delta_obj->real_type), &delta_obj->idx.oid);
+			 delta_obj->real_type, &delta_obj->idx.oid);
 	sha1_object(result_data, NULL, result_size, delta_obj->real_type,
 		    &delta_obj->idx.oid);
 
diff --git a/builtin/replace.c b/builtin/replace.c
index 995ca683302..53a3b246570 100644
--- a/builtin/replace.c
+++ b/builtin/replace.c
@@ -409,7 +409,7 @@ static int check_one_mergetag(struct commit *commit,
 	int i;
 
 	hash_object_file(the_hash_algo, extra->value, extra->len,
-			 type_name(OBJ_TAG), &tag_oid);
+			 OBJ_TAG, &tag_oid);
 	tag = lookup_tag(the_repository, &tag_oid);
 	if (!tag)
 		return error(_("bad mergetag in commit '%s'"), ref);
diff --git a/builtin/unpack-objects.c b/builtin/unpack-objects.c
index 808041551fd..dbeb0680a58 100644
--- a/builtin/unpack-objects.c
+++ b/builtin/unpack-objects.c
@@ -266,7 +266,7 @@ static void write_object(unsigned nr, enum object_type type,
 	} else {
 		struct object *obj;
 		int eaten;
-		hash_object_file(the_hash_algo, buf, size, type_name(type),
+		hash_object_file(the_hash_algo, buf, size, type,
 				 &obj_list[nr].oid);
 		added_object(nr, type, buf, size);
 		obj = parse_object_buffer(the_repository, &obj_list[nr].oid,
diff --git a/cache-tree.c b/cache-tree.c
index fdbbd191d22..6752f69d515 100644
--- a/cache-tree.c
+++ b/cache-tree.c
@@ -432,14 +432,14 @@ static int update_one(struct cache_tree *it,
 	if (repair) {
 		struct object_id oid;
 		hash_object_file(the_hash_algo, buffer.buf, buffer.len,
-				 tree_type, &oid);
+				 OBJ_TREE, &oid);
 		if (has_object_file_with_flags(&oid, OBJECT_INFO_SKIP_FETCH_OBJECT))
 			oidcpy(&it->oid, &oid);
 		else
 			to_invalidate = 1;
 	} else if (dryrun) {
 		hash_object_file(the_hash_algo, buffer.buf, buffer.len,
-				 tree_type, &it->oid);
+				 OBJ_TREE, &it->oid);
 	} else if (write_object_file_flags(buffer.buf, buffer.len, OBJ_TREE,
 					   &it->oid, flags & WRITE_TREE_SILENT
 					   ? HASH_SILENT : 0)) {
@@ -948,7 +948,7 @@ static int verify_one(struct repository *r,
 		strbuf_addf(&tree_buf, "%o %.*s%c", mode, entlen, name, '\0');
 		strbuf_add(&tree_buf, oid->hash, r->hash_algo->rawsz);
 	}
-	hash_object_file(r->hash_algo, tree_buf.buf, tree_buf.len, tree_type,
+	hash_object_file(r->hash_algo, tree_buf.buf, tree_buf.len, OBJ_TREE,
 			 &new_oid);
 	if (!oideq(&new_oid, &it->oid))
 		BUG("cache-tree for path %.*s does not match. "
diff --git a/cache.h b/cache.h
index 281f00ab1b1..d9c68c66d53 100644
--- a/cache.h
+++ b/cache.h
@@ -1320,7 +1320,7 @@ struct object_info;
 int parse_loose_header(const char *hdr, struct object_info *oi);
 
 int check_object_signature(struct repository *r, const struct object_id *oid,
-			   void *buf, unsigned long size, const char *type,
+			   void *buf, unsigned long size, enum object_type type,
 			   struct object_id *real_oidp);
 
 int finalize_object_file(const char *tmpfile, const char *filename);
diff --git a/convert.c b/convert.c
index df7186bd813..d88072fe320 100644
--- a/convert.c
+++ b/convert.c
@@ -1159,7 +1159,7 @@ static int ident_to_worktree(const char *src, size_t len,
 	/* are we "faking" in place editing ? */
 	if (src == buf->buf)
 		to_free = strbuf_detach(buf, NULL);
-	hash_object_file(the_hash_algo, src, len, "blob", &oid);
+	hash_object_file(the_hash_algo, src, len, OBJ_BLOB, &oid);
 
 	strbuf_grow(buf, len + cnt * (the_hash_algo->hexsz + 3));
 	for (;;) {
diff --git a/diffcore-rename.c b/diffcore-rename.c
index bebd4ed6a42..c0422d9e709 100644
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -261,7 +261,7 @@ static unsigned int hash_filespec(struct repository *r,
 		if (diff_populate_filespec(r, filespec, NULL))
 			return 0;
 		hash_object_file(r->hash_algo, filespec->data, filespec->size,
-				 "blob", &filespec->oid);
+				 OBJ_BLOB, &filespec->oid);
 	}
 	return oidhash(&filespec->oid);
 }
diff --git a/dir.c b/dir.c
index d91295f2bcd..5674e8a6256 100644
--- a/dir.c
+++ b/dir.c
@@ -1113,7 +1113,7 @@ static int add_patterns(const char *fname, const char *base, int baselen,
 				       &istate->cache[pos]->oid);
 			else
 				hash_object_file(the_hash_algo, buf, size,
-						 "blob", &oid_stat->oid);
+						 OBJ_BLOB, &oid_stat->oid);
 			fill_stat_data(&oid_stat->stat, &st);
 			oid_stat->valid = 1;
 		}
diff --git a/log-tree.c b/log-tree.c
index d3e7a40b648..27a5b0bd61a 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -561,7 +561,7 @@ static int show_one_mergetag(struct commit *commit,
 	struct strbuf signature = STRBUF_INIT;
 
 	hash_object_file(the_hash_algo, extra->value, extra->len,
-			 type_name(OBJ_TAG), &oid);
+			 OBJ_TAG, &oid);
 	tag = lookup_tag(the_repository, &oid);
 	if (!tag)
 		return -1; /* error message already given */
diff --git a/object-file.c b/object-file.c
index 9fc959fa05d..4a23a7aa79f 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1073,7 +1073,7 @@ int format_object_header(char *str, size_t size, enum object_type type,
  * the streaming interface and rehash it to do the same.
  */
 int check_object_signature(struct repository *r, const struct object_id *oid,
-			   void *map, unsigned long size, const char *type,
+			   void *map, unsigned long size, enum object_type type,
 			   struct object_id *real_oidp)
 {
 	struct object_id tmp;
@@ -1679,7 +1679,7 @@ int pretend_object_file(void *buf, unsigned long len, enum object_type type,
 {
 	struct cached_object *co;
 
-	hash_object_file(the_hash_algo, buf, len, type_name(type), oid);
+	hash_object_file(the_hash_algo, buf, len, type, oid);
 	if (has_object_file_with_flags(oid, OBJECT_INFO_QUICK | OBJECT_INFO_SKIP_FETCH_OBJECT) ||
 	    find_cached_object(oid))
 		return 0;
@@ -1854,19 +1854,23 @@ static int write_buffer(int fd, const void *buf, size_t len)
 }
 
 void hash_object_file(const struct git_hash_algo *algo, const void *buf,
-		     unsigned long len, const char *type,
+		     unsigned long len, enum object_type type,
 		     struct object_id *oid)
 {
 	char hdr[MAX_HEADER_LEN];
 	int hdrlen = sizeof(hdr);
-	write_object_file_prepare(algo, buf, len, type, oid, hdr, &hdrlen);
+
+	write_object_file_prepare(algo, buf, len, type_name(type), oid, hdr, &hdrlen);
 }
 
 static void hash_object_file_literally(const struct git_hash_algo *algo, const void *buf,
 				       unsigned long len, const char *type,
 				       struct object_id *oid)
 {
-	hash_object_file(algo, buf, len, type, oid);
+	char hdr[MAX_HEADER_LEN];
+	int hdrlen = sizeof(hdr);
+
+	write_object_file_prepare(algo, buf, len, type, oid, hdr, &hdrlen);
 }
 
 int hash_object_file_oideq(const struct git_hash_algo *algo, const void *buf,
@@ -1877,7 +1881,7 @@ int hash_object_file_oideq(const struct git_hash_algo *algo, const void *buf,
 	struct object_id tmp;
 	struct object_id *real_oid = real_oidp ? real_oidp : &tmp;
 
-	hash_object_file(algo, buf, len, type_name(type), real_oid);
+	hash_object_file(algo, buf, len, type, real_oid);
 
 	return oideq(oid, real_oid);
 }
@@ -2184,9 +2188,7 @@ static int index_mem(struct index_state *istate,
 	if (write_object)
 		ret = write_object_file(buf, size, type, oid);
 	else
-		hash_object_file(the_hash_algo, buf, size, type_name(type),
-				 oid);
-
+		hash_object_file(the_hash_algo, buf, size, type, oid);
 	if (re_allocated)
 		free(buf);
 	return ret;
@@ -2212,8 +2214,8 @@ static int index_stream_convert_blob(struct index_state *istate,
 		ret = write_object_file(sbuf.buf, sbuf.len, OBJ_BLOB,
 					oid);
 	else
-		hash_object_file(the_hash_algo, sbuf.buf, sbuf.len,
-				 type_name(OBJ_BLOB), oid);
+		hash_object_file(the_hash_algo, sbuf.buf, sbuf.len, OBJ_BLOB,
+				 oid);
 	strbuf_release(&sbuf);
 	return ret;
 }
@@ -2332,7 +2334,7 @@ int index_path(struct index_state *istate, struct object_id *oid,
 			return error_errno("readlink(\"%s\")", path);
 		if (!(flags & HASH_WRITE_OBJECT))
 			hash_object_file(the_hash_algo, sb.buf, sb.len,
-					 blob_type, oid);
+					 OBJ_BLOB, oid);
 		else if (write_object_file(sb.buf, sb.len, OBJ_BLOB, oid))
 			rc = error(_("%s: failed to insert into database"), path);
 		strbuf_release(&sb);
diff --git a/object-store.h b/object-store.h
index 2ddc20b3304..719122f047f 100644
--- a/object-store.h
+++ b/object-store.h
@@ -245,8 +245,9 @@ static inline void *repo_read_object_file(struct repository *r,
 /* Read and unpack an object file into memory, write memory to an object file */
 int oid_object_info(struct repository *r, const struct object_id *, unsigned long *);
 
+
 void hash_object_file(const struct git_hash_algo *algo, const void *buf,
-		      unsigned long len, const char *type,
+		      unsigned long len, enum object_type type,
 		      struct object_id *oid);
 
 /**
diff --git a/object.c b/object.c
index d7673332582..795b1356a1b 100644
--- a/object.c
+++ b/object.c
@@ -279,7 +279,7 @@ struct object *parse_object(struct repository *r, const struct object_id *oid)
 	if ((obj && obj->type == OBJ_BLOB && repo_has_object_file(r, oid)) ||
 	    (!obj && repo_has_object_file(r, oid) &&
 	     oid_object_info(r, oid, NULL) == OBJ_BLOB)) {
-		if (check_object_signature(r, repl, NULL, 0, NULL, NULL) < 0) {
+		if (check_object_signature(r, repl, NULL, 0, OBJ_BAD, NULL) < 0) {
 			error(_("hash mismatch %s"), oid_to_hex(oid));
 			return NULL;
 		}
diff --git a/pack-check.c b/pack-check.c
index 3f418e3a6af..faceae610d3 100644
--- a/pack-check.c
+++ b/pack-check.c
@@ -143,7 +143,7 @@ static int verify_packfile(struct repository *r,
 				    oid_to_hex(&oid), p->pack_name,
 				    (uintmax_t)entries[i].offset);
 		else if (check_object_signature(r, &oid, data, size,
-						type_name(type), NULL))
+						type, NULL))
 			err = error("packed %s from %s is corrupt",
 				    oid_to_hex(&oid), p->pack_name);
 		else if (fn) {
-- 
2.35.0.913.g12b4baa2536

