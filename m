Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2D05B1FADF
	for <e@80x24.org>; Thu, 18 Jan 2018 14:52:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932568AbeAROwK (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Jan 2018 09:52:10 -0500
Received: from mail-lf0-f68.google.com ([209.85.215.68]:38937 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756629AbeAROvQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Jan 2018 09:51:16 -0500
Received: by mail-lf0-f68.google.com with SMTP id m8so27015132lfc.6
        for <git@vger.kernel.org>; Thu, 18 Jan 2018 06:51:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:in-reply-to
         :references;
        bh=SYGFWnMv2S0hfbahKY6Vo5kaxwdF4+ckV+HRf4Jrdt0=;
        b=JekKd31kvwuYO/qIvPGWQp95uZVFkzITCmifNzTyulsDkTkjkS8Wzu7KyRgvAjptt0
         Lw5CWBvyxTY0OWexiqomzN3EgrDF678rHectHBqv1y/K+Bdj2+Ogv6OdQ5VwdW7C8gTV
         YzurwNEj9lq0OQcsB+yp62HfxBbsZ+8IKKsUnz9OWqXckZ76chF7E6Eh3jz5+bfJLKqv
         49GAv2QKEZ/iaG8A1ynvcRYvpV9GpVYm4msDzm+hvXiGMuT5vNdr5Iua7RsksbQy8HlX
         S0He/Ay+7GGDVgj1MsPyeB8+UbB297y39NAqbkp967P7I0osrKSz+Bzj2yAyfclTdses
         rPEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=SYGFWnMv2S0hfbahKY6Vo5kaxwdF4+ckV+HRf4Jrdt0=;
        b=tV/NgSXeyCb/dJgA31g9FbXbOssJEq9h9FDZHELTznGfLW5aO+J37xACxBWiq1rI8H
         13K8QE1BmEVzUcH80ge4UDJYLs+b0RuqdiPxnzmWnYu2uxWy3zer70Oxo9fUEKyEAUHY
         wSRQ5tjzuRvNkR8e3ItajZxQu+hlvL+wS2yAzhzii1rgltzOs1VlV08sKaGOdqYWWFk6
         G3xzHBwNQtYFvLb6LQdxLdlFjv7+NHXn+rKHEkSLqmkeNquMLm1Bo1uauVm6PlUKhKq9
         tYmSu1x7IPQd7xqqP2WF3IUAfs58hUzFrmhD/iEABpBTI8LsqPy1C67/1v48jrxUDdSy
         gImg==
X-Gm-Message-State: AKwxytcjjAHYtyBaPoPOxH14HLa5EWNAealusWf+/CCba6pt8pG8xPkL
        LMAUHOF425ctdC2MtQ5Atn/v7JqWTrA=
X-Google-Smtp-Source: ACJfBov8rrps+iUOsFQRcRRdchfm1tYn06OhQdB7tJgHihNYcfZ1z/4zO8SCC0lD6q0iLu9tRGAxRw==
X-Received: by 10.25.167.85 with SMTP id q82mr7777208lfe.112.1516287074976;
        Thu, 18 Jan 2018 06:51:14 -0800 (PST)
Received: from localhost.localdomain ([188.121.16.104])
        by smtp.gmail.com with ESMTPSA id 23sm560988lju.28.2018.01.18.06.51.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 18 Jan 2018 06:51:14 -0800 (PST)
From:   Patryk Obara <patryk.obara@gmail.com>
To:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        "brian m . carlson" <sandals@crustytoothpaste.ath.cx>
Subject: [PATCH 05/11] sha1_file: convert hash_sha1_file to object_id
Date:   Thu, 18 Jan 2018 15:50:57 +0100
Message-Id: <96b3c9ac4e18b96c89d85cde52f57d50be1cb7eb.1516282880.git.patryk.obara@gmail.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <cover.1516282880.git.patryk.obara@gmail.com>
References: <cover.1516282880.git.patryk.obara@gmail.com>
In-Reply-To: <cover.1516282880.git.patryk.obara@gmail.com>
References: <cover.1516282880.git.patryk.obara@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Convert the declaration and definition of hash_sha1_file to use
struct object_id and adjust all function calls.

Signed-off-by: Patryk Obara <patryk.obara@gmail.com>
---
 apply.c                  |  4 ++--
 builtin/index-pack.c     |  3 +--
 builtin/replace.c        |  2 +-
 builtin/unpack-objects.c |  2 +-
 cache-tree.c             | 11 +++++------
 cache.h                  |  3 ++-
 convert.c                |  6 +++---
 diffcore-rename.c        |  2 +-
 dir.c                    |  2 +-
 log-tree.c               |  2 +-
 sha1_file.c              | 22 +++++++++++-----------
 11 files changed, 29 insertions(+), 30 deletions(-)

diff --git a/apply.c b/apply.c
index 321a9fa68d..d6cbb4dc66 100644
--- a/apply.c
+++ b/apply.c
@@ -3154,7 +3154,7 @@ static int apply_binary(struct apply_state *state,
 		 * See if the old one matches what the patch
 		 * applies to.
 		 */
-		hash_sha1_file(img->buf, img->len, blob_type, oid.hash);
+		hash_sha1_file(img->buf, img->len, blob_type, &oid);
 		if (strcmp(oid_to_hex(&oid), patch->old_sha1_prefix))
 			return error(_("the patch applies to '%s' (%s), "
 				       "which does not match the "
@@ -3199,7 +3199,7 @@ static int apply_binary(struct apply_state *state,
 				     name);
 
 		/* verify that the result matches */
-		hash_sha1_file(img->buf, img->len, blob_type, oid.hash);
+		hash_sha1_file(img->buf, img->len, blob_type, &oid);
 		if (strcmp(oid_to_hex(&oid), patch->new_sha1_prefix))
 			return error(_("binary patch to '%s' creates incorrect result (expecting %s, got %s)"),
 				name, patch->new_sha1_prefix, oid_to_hex(&oid));
diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 4c51aec81f..f7c69008f1 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -959,8 +959,7 @@ static void resolve_delta(struct object_entry *delta_obj,
 	if (!result->data)
 		bad_object(delta_obj->idx.offset, _("failed to apply delta"));
 	hash_sha1_file(result->data, result->size,
-		       typename(delta_obj->real_type),
-		       delta_obj->idx.oid.hash);
+		       typename(delta_obj->real_type), &delta_obj->idx.oid);
 	sha1_object(result->data, NULL, result->size, delta_obj->real_type,
 		    &delta_obj->idx.oid);
 	counter_lock();
diff --git a/builtin/replace.c b/builtin/replace.c
index 10078ae371..7267d06b17 100644
--- a/builtin/replace.c
+++ b/builtin/replace.c
@@ -355,7 +355,7 @@ static void check_one_mergetag(struct commit *commit,
 	struct tag *tag;
 	int i;
 
-	hash_sha1_file(extra->value, extra->len, typename(OBJ_TAG), tag_oid.hash);
+	hash_sha1_file(extra->value, extra->len, typename(OBJ_TAG), &tag_oid);
 	tag = lookup_tag(&tag_oid);
 	if (!tag)
 		die(_("bad mergetag in commit '%s'"), ref);
diff --git a/builtin/unpack-objects.c b/builtin/unpack-objects.c
index 62ea264c46..2e494e2a4b 100644
--- a/builtin/unpack-objects.c
+++ b/builtin/unpack-objects.c
@@ -258,7 +258,7 @@ static void write_object(unsigned nr, enum object_type type,
 	} else {
 		struct object *obj;
 		int eaten;
-		hash_sha1_file(buf, size, typename(type), obj_list[nr].oid.hash);
+		hash_sha1_file(buf, size, typename(type), &obj_list[nr].oid);
 		added_object(nr, type, buf, size);
 		obj = parse_object_buffer(&obj_list[nr].oid, type, size, buf,
 					  &eaten);
diff --git a/cache-tree.c b/cache-tree.c
index e03e72c34a..0df09180ee 100644
--- a/cache-tree.c
+++ b/cache-tree.c
@@ -400,15 +400,14 @@ static int update_one(struct cache_tree *it,
 	}
 
 	if (repair) {
-		unsigned char sha1[20];
-		hash_sha1_file(buffer.buf, buffer.len, tree_type, sha1);
-		if (has_sha1_file(sha1))
-			hashcpy(it->oid.hash, sha1);
+		struct object_id oid;
+		hash_sha1_file(buffer.buf, buffer.len, tree_type, &oid);
+		if (has_sha1_file(oid.hash))
+			oidcpy(&it->oid, &oid);
 		else
 			to_invalidate = 1;
 	} else if (dryrun)
-		hash_sha1_file(buffer.buf, buffer.len, tree_type,
-			       it->oid.hash);
+		hash_sha1_file(buffer.buf, buffer.len, tree_type, &it->oid);
 	else if (write_sha1_file(buffer.buf, buffer.len, tree_type, it->oid.hash)) {
 		strbuf_release(&buffer);
 		return -1;
diff --git a/cache.h b/cache.h
index 04af1d69e4..b953d9f82c 100644
--- a/cache.h
+++ b/cache.h
@@ -1236,7 +1236,8 @@ static inline const unsigned char *lookup_replace_object(const unsigned char *sh
 
 /* Read and unpack a sha1 file into memory, write memory to a sha1 file */
 extern int sha1_object_info(const unsigned char *, unsigned long *);
-extern int hash_sha1_file(const void *buf, unsigned long len, const char *type, unsigned char *sha1);
+extern int hash_sha1_file(const void *buf, unsigned long len, const char *type,
+			  struct object_id *oid);
 extern int write_sha1_file(const void *buf, unsigned long len, const char *type, unsigned char *return_sha1);
 extern int hash_sha1_file_literally(const void *buf, unsigned long len, const char *type, struct object_id *oid, unsigned flags);
 extern int pretend_sha1_file(void *, unsigned long, enum object_type,
diff --git a/convert.c b/convert.c
index 1a41a48e15..999bcb1336 100644
--- a/convert.c
+++ b/convert.c
@@ -898,7 +898,7 @@ static int ident_to_git(const char *path, const char *src, size_t len,
 static int ident_to_worktree(const char *path, const char *src, size_t len,
                              struct strbuf *buf, int ident)
 {
-	unsigned char sha1[20];
+	struct object_id oid;
 	char *to_free = NULL, *dollar, *spc;
 	int cnt;
 
@@ -912,7 +912,7 @@ static int ident_to_worktree(const char *path, const char *src, size_t len,
 	/* are we "faking" in place editing ? */
 	if (src == buf->buf)
 		to_free = strbuf_detach(buf, NULL);
-	hash_sha1_file(src, len, "blob", sha1);
+	hash_sha1_file(src, len, "blob", &oid);
 
 	strbuf_grow(buf, len + cnt * 43);
 	for (;;) {
@@ -969,7 +969,7 @@ static int ident_to_worktree(const char *path, const char *src, size_t len,
 
 		/* step 4: substitute */
 		strbuf_addstr(buf, "Id: ");
-		strbuf_add(buf, sha1_to_hex(sha1), 40);
+		strbuf_add(buf, sha1_to_hex(oid.hash), GIT_SHA1_HEXSZ);
 		strbuf_addstr(buf, " $");
 	}
 	strbuf_add(buf, src, len);
diff --git a/diffcore-rename.c b/diffcore-rename.c
index 245e999fe5..93cbcb9de4 100644
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -261,7 +261,7 @@ static unsigned int hash_filespec(struct diff_filespec *filespec)
 		if (diff_populate_filespec(filespec, 0))
 			return 0;
 		hash_sha1_file(filespec->data, filespec->size, "blob",
-			       filespec->oid.hash);
+			       &filespec->oid);
 	}
 	return sha1hash(filespec->oid.hash);
 }
diff --git a/dir.c b/dir.c
index effa531d35..a3454d6cd0 100644
--- a/dir.c
+++ b/dir.c
@@ -851,7 +851,7 @@ static int add_excludes(const char *fname, const char *base, int baselen,
 				       &istate->cache[pos]->oid);
 			else
 				hash_sha1_file(buf, size, "blob",
-					       sha1_stat->oid.hash);
+					       &sha1_stat->oid);
 			fill_stat_data(&sha1_stat->stat, &st);
 			sha1_stat->valid = 1;
 		}
diff --git a/log-tree.c b/log-tree.c
index fca29d4799..019026e1ae 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -499,7 +499,7 @@ static void show_one_mergetag(struct commit *commit,
 	int status, nth;
 	size_t payload_size, gpg_message_offset;
 
-	hash_sha1_file(extra->value, extra->len, typename(OBJ_TAG), oid.hash);
+	hash_sha1_file(extra->value, extra->len, typename(OBJ_TAG), &oid);
 	tag = lookup_tag(&oid);
 	if (!tag)
 		return; /* error message already given */
diff --git a/sha1_file.c b/sha1_file.c
index dc8adb9d17..88b960316c 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -788,7 +788,7 @@ void *xmmap(void *start, size_t length,
 int check_sha1_signature(const unsigned char *sha1, void *map,
 			 unsigned long size, const char *type)
 {
-	unsigned char real_sha1[20];
+	struct object_id real_oid;
 	enum object_type obj_type;
 	struct git_istream *st;
 	git_SHA_CTX c;
@@ -796,8 +796,8 @@ int check_sha1_signature(const unsigned char *sha1, void *map,
 	int hdrlen;
 
 	if (map) {
-		hash_sha1_file(map, size, type, real_sha1);
-		return hashcmp(sha1, real_sha1) ? -1 : 0;
+		hash_sha1_file(map, size, type, &real_oid);
+		return hashcmp(sha1, real_oid.hash) ? -1 : 0;
 	}
 
 	st = open_istream(sha1, &obj_type, &size, NULL);
@@ -822,9 +822,9 @@ int check_sha1_signature(const unsigned char *sha1, void *map,
 			break;
 		git_SHA1_Update(&c, buf, readlen);
 	}
-	git_SHA1_Final(real_sha1, &c);
+	git_SHA1_Final(real_oid.hash, &c);
 	close_istream(st);
-	return hashcmp(sha1, real_sha1) ? -1 : 0;
+	return hashcmp(sha1, real_oid.hash) ? -1 : 0;
 }
 
 int git_open_cloexec(const char *name, int flags)
@@ -1317,7 +1317,7 @@ int pretend_sha1_file(void *buf, unsigned long len, enum object_type type,
 {
 	struct cached_object *co;
 
-	hash_sha1_file(buf, len, typename(type), oid->hash);
+	hash_sha1_file(buf, len, typename(type), oid);
 	if (has_sha1_file(oid->hash) || find_cached_object(oid->hash))
 		return 0;
 	ALLOC_GROW(cached_objects, cached_object_nr + 1, cached_object_alloc);
@@ -1486,11 +1486,11 @@ static int write_buffer(int fd, const void *buf, size_t len)
 }
 
 int hash_sha1_file(const void *buf, unsigned long len, const char *type,
-                   unsigned char *sha1)
+		   struct object_id *oid)
 {
 	char hdr[32];
 	int hdrlen = sizeof(hdr);
-	write_sha1_file_prepare(buf, len, type, sha1, hdr, &hdrlen);
+	write_sha1_file_prepare(buf, len, type, oid->hash, hdr, &hdrlen);
 	return 0;
 }
 
@@ -1769,7 +1769,7 @@ static int index_mem(struct object_id *oid, void *buf, size_t size,
 	if (write_object)
 		ret = write_sha1_file(buf, size, typename(type), oid->hash);
 	else
-		ret = hash_sha1_file(buf, size, typename(type), oid->hash);
+		ret = hash_sha1_file(buf, size, typename(type), oid);
 	if (re_allocated)
 		free(buf);
 	return ret;
@@ -1793,7 +1793,7 @@ static int index_stream_convert_blob(struct object_id *oid, int fd,
 				      oid->hash);
 	else
 		ret = hash_sha1_file(sbuf.buf, sbuf.len, typename(OBJ_BLOB),
-				     oid->hash);
+				     oid);
 	strbuf_release(&sbuf);
 	return ret;
 }
@@ -1907,7 +1907,7 @@ int index_path(struct object_id *oid, const char *path, struct stat *st, unsigne
 		if (strbuf_readlink(&sb, path, st->st_size))
 			return error_errno("readlink(\"%s\")", path);
 		if (!(flags & HASH_WRITE_OBJECT))
-			hash_sha1_file(sb.buf, sb.len, blob_type, oid->hash);
+			hash_sha1_file(sb.buf, sb.len, blob_type, oid);
 		else if (write_sha1_file(sb.buf, sb.len, blob_type, oid->hash))
 			rc = error("%s: failed to insert into database", path);
 		strbuf_release(&sb);
-- 
2.14.3

