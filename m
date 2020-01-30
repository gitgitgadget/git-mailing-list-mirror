Return-Path: <SRS0=gonI=3T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1838FC2D0DB
	for <git@archiver.kernel.org>; Thu, 30 Jan 2020 20:34:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6D652083E
	for <git@archiver.kernel.org>; Thu, 30 Jan 2020 20:34:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp-br.20150623.gappssmtp.com header.i=@usp-br.20150623.gappssmtp.com header.b="sCf3UZpW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727818AbgA3UeF (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jan 2020 15:34:05 -0500
Received: from mail-qk1-f181.google.com ([209.85.222.181]:37560 "EHLO
        mail-qk1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727706AbgA3UeF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jan 2020 15:34:05 -0500
Received: by mail-qk1-f181.google.com with SMTP id 21so4341867qky.4
        for <git@vger.kernel.org>; Thu, 30 Jan 2020 12:34:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9ZzSQrYsrzbc1Ozbtg+HY0OurFxYZmDjegKiwbKYKBE=;
        b=sCf3UZpWDLguji2/FchJuGFuoqjcKgDZaGjwWzew6z6vgmuyVs5GQV2dSkwY0/TrIf
         r5ejOahSobIdFNcljK3ByAefatWfigyZJOJX0j9h0LPxdjQ0a6zI3Rc4ZgQMrFltG/Ny
         du1JaSSbz+Pi31K+2lob9m+2eGAE9x0Lr57zl3JbZgbEDD7VTQiPEuWov4Xsne8+ZmIx
         DaiB22EPTxpoTWlKU5To1gFuyXO0+84Us/L0sx+oV6ncxlcPz46kHHLAl3J6GXZRR4sf
         04Se0IKiKgXstoxsVBPIMwrZsmbhPsYGPJn3ZPIikFiBDdfaKLmOJ643lHJS65J5oGvb
         qOOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9ZzSQrYsrzbc1Ozbtg+HY0OurFxYZmDjegKiwbKYKBE=;
        b=RcP13pq7EtZfUqmpnZd2UP5y0e1/Pj8uQWXGljQv9JrawEYX5COKE9D9VAo8wKALE5
         r6qWkBbZ0xhDuHwWLR2IEtMxdMT8dEyd7WplA9uuji9x92WQn14MD0zWwUvBcWLo9HzY
         IJhs3kKcZxYxoJ4LZne4CpRcjPxJ4703WibWl4kOY1k6fbq4m8PZ4zHx+OUTZ7WNqFG/
         3g1PuC50KTBzlo8UeqA2eKVWhIsno7ZwZTdGBjrEG3idyxF3or3mxWQbp+apN+Zt8fMW
         T4bpwM4aP/2iJqnHf7tra6fzebaaBt9we1IUjF5jNVtUgJH6UatBTTARs9ixLYHegm/w
         ik/w==
X-Gm-Message-State: APjAAAXqZo3wTpoxOobntsSXu5M5cKFHRTms0blkxFk4gd0llzC37ang
        w2mfSUIrqjkIYOhKQ1dSxluKZ2cuMD0=
X-Google-Smtp-Source: APXvYqyR2x/JH+V7fC65p4v0oRRK3dixaN3tzVXPHLw+ILmCejVOJamVNM5qxzY5Fpwqrv5AdTfI1Q==
X-Received: by 2002:a37:9e96:: with SMTP id h144mr7290696qke.327.1580416443985;
        Thu, 30 Jan 2020 12:34:03 -0800 (PST)
Received: from mango.semfio.usp.br ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id o12sm3436514qke.79.2020.01.30.12.34.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jan 2020 12:34:03 -0800 (PST)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     Stefan Beller <stefanbeller@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>
Subject: [PATCH 6/7] sha1-file: pass git_hash_algo to hash_object_file()
Date:   Thu, 30 Jan 2020 17:32:22 -0300
Message-Id: <40b95d0a979eb4865572611bfb6d1bfe2be1de57.1580413221.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <cover.1580413221.git.matheus.bernardino@usp.br>
References: <cover.1580413221.git.matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Allow hash_object_file() to work on arbitrary repos by introducing a
git_hash_algo parameter. Change callers which have a struct repository
pointer in their scope to pass on the git_hash_algo from the said repo.
For all other callers, pass on the_hash_algo, which was already being
used internally at hash_object_file(). This functionality will be used
in the following patch to make check_object_signature() be able to work
on arbitrary repos (which, in turn, will be used to fix an
inconsistency at object.c:parse_object()).

Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
---
 apply.c                  |  6 ++++--
 builtin/index-pack.c     |  2 +-
 builtin/replace.c        |  3 ++-
 builtin/unpack-objects.c |  3 ++-
 cache-tree.c             |  9 ++++++---
 convert.c                |  2 +-
 diffcore-rename.c        |  4 ++--
 dir.c                    |  4 ++--
 log-tree.c               |  3 ++-
 object-store.h           |  5 +++--
 sha1-file.c              | 20 +++++++++++---------
 11 files changed, 36 insertions(+), 25 deletions(-)

diff --git a/apply.c b/apply.c
index fab44322c5..bdc008fae2 100644
--- a/apply.c
+++ b/apply.c
@@ -3157,7 +3157,8 @@ static int apply_binary(struct apply_state *state,
 		 * See if the old one matches what the patch
 		 * applies to.
 		 */
-		hash_object_file(img->buf, img->len, blob_type, &oid);
+		hash_object_file(the_hash_algo, img->buf, img->len, blob_type,
+				 &oid);
 		if (strcmp(oid_to_hex(&oid), patch->old_oid_prefix))
 			return error(_("the patch applies to '%s' (%s), "
 				       "which does not match the "
@@ -3202,7 +3203,8 @@ static int apply_binary(struct apply_state *state,
 				     name);
 
 		/* verify that the result matches */
-		hash_object_file(img->buf, img->len, blob_type, &oid);
+		hash_object_file(the_hash_algo, img->buf, img->len, blob_type,
+				 &oid);
 		if (strcmp(oid_to_hex(&oid), patch->new_oid_prefix))
 			return error(_("binary patch to '%s' creates incorrect result (expecting %s, got %s)"),
 				name, patch->new_oid_prefix, oid_to_hex(&oid));
diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 7a08da8401..0183610a76 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -949,7 +949,7 @@ static void resolve_delta(struct object_entry *delta_obj,
 	free(delta_data);
 	if (!result->data)
 		bad_object(delta_obj->idx.offset, _("failed to apply delta"));
-	hash_object_file(result->data, result->size,
+	hash_object_file(the_hash_algo, result->data, result->size,
 			 type_name(delta_obj->real_type), &delta_obj->idx.oid);
 	sha1_object(result->data, NULL, result->size, delta_obj->real_type,
 		    &delta_obj->idx.oid);
diff --git a/builtin/replace.c b/builtin/replace.c
index bd92dc63b9..b36d17a657 100644
--- a/builtin/replace.c
+++ b/builtin/replace.c
@@ -409,7 +409,8 @@ static int check_one_mergetag(struct commit *commit,
 	struct tag *tag;
 	int i;
 
-	hash_object_file(extra->value, extra->len, type_name(OBJ_TAG), &tag_oid);
+	hash_object_file(the_hash_algo, extra->value, extra->len,
+			 type_name(OBJ_TAG), &tag_oid);
 	tag = lookup_tag(the_repository, &tag_oid);
 	if (!tag)
 		return error(_("bad mergetag in commit '%s'"), ref);
diff --git a/builtin/unpack-objects.c b/builtin/unpack-objects.c
index 9100964667..dd4a75e030 100644
--- a/builtin/unpack-objects.c
+++ b/builtin/unpack-objects.c
@@ -265,7 +265,8 @@ static void write_object(unsigned nr, enum object_type type,
 	} else {
 		struct object *obj;
 		int eaten;
-		hash_object_file(buf, size, type_name(type), &obj_list[nr].oid);
+		hash_object_file(the_hash_algo, buf, size, type_name(type),
+				 &obj_list[nr].oid);
 		added_object(nr, type, buf, size);
 		obj = parse_object_buffer(the_repository, &obj_list[nr].oid,
 					  type, size, buf,
diff --git a/cache-tree.c b/cache-tree.c
index 8c51a15751..a537a806c1 100644
--- a/cache-tree.c
+++ b/cache-tree.c
@@ -407,13 +407,15 @@ static int update_one(struct cache_tree *it,
 
 	if (repair) {
 		struct object_id oid;
-		hash_object_file(buffer.buf, buffer.len, tree_type, &oid);
+		hash_object_file(the_hash_algo, buffer.buf, buffer.len,
+				 tree_type, &oid);
 		if (has_object_file_with_flags(&oid, OBJECT_INFO_SKIP_FETCH_OBJECT))
 			oidcpy(&it->oid, &oid);
 		else
 			to_invalidate = 1;
 	} else if (dryrun) {
-		hash_object_file(buffer.buf, buffer.len, tree_type, &it->oid);
+		hash_object_file(the_hash_algo, buffer.buf, buffer.len,
+				 tree_type, &it->oid);
 	} else if (write_object_file(buffer.buf, buffer.len, tree_type,
 				     &it->oid)) {
 		strbuf_release(&buffer);
@@ -828,7 +830,8 @@ static void verify_one(struct repository *r,
 		strbuf_addf(&tree_buf, "%o %.*s%c", mode, entlen, name, '\0');
 		strbuf_add(&tree_buf, oid->hash, r->hash_algo->rawsz);
 	}
-	hash_object_file(tree_buf.buf, tree_buf.len, tree_type, &new_oid);
+	hash_object_file(r->hash_algo, tree_buf.buf, tree_buf.len, tree_type,
+			 &new_oid);
 	if (!oideq(&new_oid, &it->oid))
 		BUG("cache-tree for path %.*s does not match. "
 		    "Expected %s got %s", len, path->buf,
diff --git a/convert.c b/convert.c
index 797e0bd0b1..33507ee0a9 100644
--- a/convert.c
+++ b/convert.c
@@ -1146,7 +1146,7 @@ static int ident_to_worktree(const char *src, size_t len,
 	/* are we "faking" in place editing ? */
 	if (src == buf->buf)
 		to_free = strbuf_detach(buf, NULL);
-	hash_object_file(src, len, "blob", &oid);
+	hash_object_file(the_hash_algo, src, len, "blob", &oid);
 
 	strbuf_grow(buf, len + cnt * (the_hash_algo->hexsz + 3));
 	for (;;) {
diff --git a/diffcore-rename.c b/diffcore-rename.c
index 531d7adeaf..e189f407af 100644
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -263,8 +263,8 @@ static unsigned int hash_filespec(struct repository *r,
 	if (!filespec->oid_valid) {
 		if (diff_populate_filespec(r, filespec, 0))
 			return 0;
-		hash_object_file(filespec->data, filespec->size, "blob",
-				 &filespec->oid);
+		hash_object_file(r->hash_algo, filespec->data, filespec->size,
+				 "blob", &filespec->oid);
 	}
 	return oidhash(&filespec->oid);
 }
diff --git a/dir.c b/dir.c
index 7d255227b1..512c5d7ea6 100644
--- a/dir.c
+++ b/dir.c
@@ -1002,8 +1002,8 @@ static int add_patterns(const char *fname, const char *base, int baselen,
 				oidcpy(&oid_stat->oid,
 				       &istate->cache[pos]->oid);
 			else
-				hash_object_file(buf, size, "blob",
-						 &oid_stat->oid);
+				hash_object_file(the_hash_algo, buf, size,
+						 "blob", &oid_stat->oid);
 			fill_stat_data(&oid_stat->stat, &st);
 			oid_stat->valid = 1;
 		}
diff --git a/log-tree.c b/log-tree.c
index 4e32638de8..cae38dcc66 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -501,7 +501,8 @@ static int show_one_mergetag(struct commit *commit,
 	int status, nth;
 	size_t payload_size, gpg_message_offset;
 
-	hash_object_file(extra->value, extra->len, type_name(OBJ_TAG), &oid);
+	hash_object_file(the_hash_algo, extra->value, extra->len,
+			 type_name(OBJ_TAG), &oid);
 	tag = lookup_tag(the_repository, &oid);
 	if (!tag)
 		return -1; /* error message already given */
diff --git a/object-store.h b/object-store.h
index 61b8b13e3b..cf97cbc292 100644
--- a/object-store.h
+++ b/object-store.h
@@ -198,8 +198,9 @@ static inline void *repo_read_object_file(struct repository *r,
 /* Read and unpack an object file into memory, write memory to an object file */
 int oid_object_info(struct repository *r, const struct object_id *, unsigned long *);
 
-int hash_object_file(const void *buf, unsigned long len,
-		     const char *type, struct object_id *oid);
+int hash_object_file(const struct git_hash_algo *algo, const void *buf,
+		     unsigned long len, const char *type,
+		     struct object_id *oid);
 
 int write_object_file(const void *buf, unsigned long len,
 		      const char *type, struct object_id *oid);
diff --git a/sha1-file.c b/sha1-file.c
index e789bfd153..d545e8b882 100644
--- a/sha1-file.c
+++ b/sha1-file.c
@@ -982,7 +982,7 @@ int check_object_signature(const struct object_id *oid, void *map,
 	int hdrlen;
 
 	if (map) {
-		hash_object_file(map, size, type, &real_oid);
+		hash_object_file(the_hash_algo, map, size, type, &real_oid);
 		return !oideq(oid, &real_oid) ? -1 : 0;
 	}
 
@@ -1543,7 +1543,7 @@ int pretend_object_file(void *buf, unsigned long len, enum object_type type,
 {
 	struct cached_object *co;
 
-	hash_object_file(buf, len, type_name(type), oid);
+	hash_object_file(the_hash_algo, buf, len, type_name(type), oid);
 	if (has_object_file(oid) || find_cached_object(oid))
 		return 0;
 	ALLOC_GROW(cached_objects, cached_object_nr + 1, cached_object_alloc);
@@ -1714,13 +1714,13 @@ static int write_buffer(int fd, const void *buf, size_t len)
 	return 0;
 }
 
-int hash_object_file(const void *buf, unsigned long len, const char *type,
+int hash_object_file(const struct git_hash_algo *algo, const void *buf,
+		     unsigned long len, const char *type,
 		     struct object_id *oid)
 {
 	char hdr[MAX_HEADER_LEN];
 	int hdrlen = sizeof(hdr);
-	write_object_file_prepare(the_hash_algo, buf, len, type, oid, hdr,
-				  &hdrlen);
+	write_object_file_prepare(algo, buf, len, type, oid, hdr, &hdrlen);
 	return 0;
 }
 
@@ -2006,7 +2006,8 @@ static int index_mem(struct index_state *istate,
 	if (write_object)
 		ret = write_object_file(buf, size, type_name(type), oid);
 	else
-		ret = hash_object_file(buf, size, type_name(type), oid);
+		ret = hash_object_file(the_hash_algo, buf, size,
+				       type_name(type), oid);
 	if (re_allocated)
 		free(buf);
 	return ret;
@@ -2032,8 +2033,8 @@ static int index_stream_convert_blob(struct index_state *istate,
 		ret = write_object_file(sbuf.buf, sbuf.len, type_name(OBJ_BLOB),
 					oid);
 	else
-		ret = hash_object_file(sbuf.buf, sbuf.len, type_name(OBJ_BLOB),
-				       oid);
+		ret = hash_object_file(the_hash_algo, sbuf.buf, sbuf.len,
+				       type_name(OBJ_BLOB), oid);
 	strbuf_release(&sbuf);
 	return ret;
 }
@@ -2151,7 +2152,8 @@ int index_path(struct index_state *istate, struct object_id *oid,
 		if (strbuf_readlink(&sb, path, st->st_size))
 			return error_errno("readlink(\"%s\")", path);
 		if (!(flags & HASH_WRITE_OBJECT))
-			hash_object_file(sb.buf, sb.len, blob_type, oid);
+			hash_object_file(the_hash_algo, sb.buf, sb.len,
+					 blob_type, oid);
 		else if (write_object_file(sb.buf, sb.len, blob_type, oid))
 			rc = error(_("%s: failed to insert into database"), path);
 		strbuf_release(&sb);
-- 
2.25.0

