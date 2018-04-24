Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2C4DC1F424
	for <e@80x24.org>; Tue, 24 Apr 2018 21:59:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751415AbeDXV7d (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Apr 2018 17:59:33 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:33270 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751213AbeDXV72 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Apr 2018 17:59:28 -0400
Received: by mail-pg0-f67.google.com with SMTP id i194so11840080pgd.0
        for <git@vger.kernel.org>; Tue, 24 Apr 2018 14:59:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GlB3HiFx04fFbIt7p721C8csMAE8bx0Hd1sZV2UfnAs=;
        b=dLWu4k2g7SvTLgIPlAPKzZ+nmP+xRh+LrnxyL2gbBtO4u3OR3fKrDHOxL4Od3CJ4Ng
         gxJ2V0FSO/yHRIhxQv77Ugh9l7oiKYITiwYWU+64ONZLNn/sAtLXCPgqONlYQskE3HRN
         VLSk++r3dgsrUzNwQEp72uPcN+sP1695rlB+pLmihZmq67js3WO+3aBcQ9LAqqn7W29H
         H3yA37eC+4K9qsOdH6LCGceUx3dWH4Rg27qP+XkIQqr/CpnIHcl72eRRE47FIEykBkrM
         fks/2WQp2fOHk75B02t+I/VmZ4jSTxRgxPFOwL0MUjHD9wnxvX1Osnc/3mGMkiRtuwAG
         KZ4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=GlB3HiFx04fFbIt7p721C8csMAE8bx0Hd1sZV2UfnAs=;
        b=ZOuJDw/fRnHWi0gMoWIOUpAwNosdnZY+KJ4QtnUG30rOd9TrAhWXKVSlyWTGy5wVot
         nFVPkbBoJHaYj9geXS8JSeDRvCUYhp0Bcm7E3icgLjzTFvHLZqmM/9sKAjlvjG24Rtg9
         tmM3bmZLfLrXdC0D8SERRyMv8HcpQSKpE9yqCWHm49VPj6XizhdBcq+XeRAbP4aivkBe
         4WI5MCDuxawpTVVcKQ9R4JO3b+/3Z49E38PW/zVbLxJL0xjZ1HKK5tZdda9oTAb1HIq0
         zaNyYrknVIkMcWIw2uGwDxj4ViG9PHX9wSwS0jV8/U48hlpYCtEnEIC3fHT/2CxWrpXo
         8GcA==
X-Gm-Message-State: ALQs6tDLNfMrTRgU+fS4uBELVJOQidlDMCwWWxoNsrQaw1rtW2F+1PMJ
        368yazd2YgitAftwsnCa9Hdz3ahvMyE=
X-Google-Smtp-Source: AIpwx4/63Tv43PAJeycI4lLwGf3xQCA8BLTtogKh6+K6y3Owi6RBBoUXrk2D9AkCCb/ighVdO0A53Q==
X-Received: by 10.101.74.132 with SMTP id b4mr8017561pgu.36.1524607167414;
        Tue, 24 Apr 2018 14:59:27 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id t9sm31954415pgr.37.2018.04.24.14.59.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 24 Apr 2018 14:59:26 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org, gitster@pobox.com
Cc:     bmwill@google.com, jonathantanmy@google.com,
        sandals@crustytoothpaste.net, Stefan Beller <sbeller@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCHv2 9/9] cache.h: allow oid_object_info to handle arbitrary repositories
Date:   Tue, 24 Apr 2018 14:59:09 -0700
Message-Id: <20180424215910.22201-10-sbeller@google.com>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d-goog
In-Reply-To: <20180424215910.22201-1-sbeller@google.com>
References: <20180424215910.22201-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This involves also adapting oid_object_info_extended and a some
internal functions that are used to implement these. It all has to
happen in one patch, because of a single recursive chain of calls visits
all these functions.

sha1_object_info_extended is also used in partial clones, which allow
fetching missing objects. As this series will not add the repository
struct to the transport code and fetch_object(), add a TODO note and
bug out if a user tries to use a partial clone in a repository other than
the_repository.

Helped-by: Brandon Williams <bmwill@google.com>
Helped-by: Jonathan Tan <jonathantanmy@google.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---
 cache.h     |  9 ++++-----
 packfile.c  | 58 ++++++++++++++++++++++++++---------------------------
 packfile.h  |  8 ++++----
 sha1_file.c | 30 ++++++++++++++++-----------
 4 files changed, 54 insertions(+), 51 deletions(-)

diff --git a/cache.h b/cache.h
index 6340b2c572..3a4d80e92b 100644
--- a/cache.h
+++ b/cache.h
@@ -1192,8 +1192,7 @@ static inline void *read_object_file(const struct object_id *oid, enum object_ty
 }
 
 /* Read and unpack an object file into memory, write memory to an object file */
-#define oid_object_info(r, o, f) oid_object_info_##r(o, f)
-int oid_object_info_the_repository(const struct object_id *, unsigned long *);
+int oid_object_info(struct repository *r, const struct object_id *, unsigned long *);
 
 extern int hash_object_file(const void *buf, unsigned long len,
 			    const char *type, struct object_id *oid);
@@ -1675,9 +1674,9 @@ struct object_info {
 /* Do not check loose object */
 #define OBJECT_INFO_IGNORE_LOOSE 16
 
-#define oid_object_info_extended(r, oid, oi, flags) \
-	oid_object_info_extended_##r(oid, oi, flags)
-int oid_object_info_extended_the_repository(const struct object_id *, struct object_info *, unsigned flags);
+int oid_object_info_extended(struct repository *r,
+			     const struct object_id *,
+			     struct object_info *, unsigned flags);
 
 /*
  * Set this to 0 to prevent sha1_object_info_extended() from fetching missing
diff --git a/packfile.c b/packfile.c
index 8de87f904b..55d383ed0a 100644
--- a/packfile.c
+++ b/packfile.c
@@ -1104,9 +1104,9 @@ static const unsigned char *get_delta_base_sha1(struct packed_git *p,
 		return NULL;
 }
 
-#define retry_bad_packed_offset(r, p, o) \
-	retry_bad_packed_offset_##r(p, o)
-static int retry_bad_packed_offset_the_repository(struct packed_git *p, off_t obj_offset)
+static int retry_bad_packed_offset(struct repository *r,
+				   struct packed_git *p,
+				   off_t obj_offset)
 {
 	int type;
 	struct revindex_entry *revidx;
@@ -1116,7 +1116,7 @@ static int retry_bad_packed_offset_the_repository(struct packed_git *p, off_t ob
 		return OBJ_BAD;
 	nth_packed_object_oid(&oid, p, revidx->nr);
 	mark_bad_packed_object(p, oid.hash);
-	type = oid_object_info(the_repository, &oid, NULL);
+	type = oid_object_info(r, &oid, NULL);
 	if (type <= OBJ_NONE)
 		return OBJ_BAD;
 	return type;
@@ -1124,13 +1124,12 @@ static int retry_bad_packed_offset_the_repository(struct packed_git *p, off_t ob
 
 #define POI_STACK_PREALLOC 64
 
-#define packed_to_object_type(r, p, o, t, w, c) \
-	packed_to_object_type_##r(p, o, t, w, c)
-static enum object_type packed_to_object_type_the_repository(struct packed_git *p,
-							     off_t obj_offset,
-							     enum object_type type,
-							     struct pack_window **w_curs,
-							     off_t curpos)
+static enum object_type packed_to_object_type(struct repository *r,
+					      struct packed_git *p,
+					      off_t obj_offset,
+					      enum object_type type,
+					      struct pack_window **w_curs,
+					      off_t curpos)
 {
 	off_t small_poi_stack[POI_STACK_PREALLOC];
 	off_t *poi_stack = small_poi_stack;
@@ -1157,7 +1156,7 @@ static enum object_type packed_to_object_type_the_repository(struct packed_git *
 		if (type <= OBJ_NONE) {
 			/* If getting the base itself fails, we first
 			 * retry the base, otherwise unwind */
-			type = retry_bad_packed_offset(the_repository, p, base_offset);
+			type = retry_bad_packed_offset(r, p, base_offset);
 			if (type > OBJ_NONE)
 				goto out;
 			goto unwind;
@@ -1185,7 +1184,7 @@ static enum object_type packed_to_object_type_the_repository(struct packed_git *
 unwind:
 	while (poi_stack_nr) {
 		obj_offset = poi_stack[--poi_stack_nr];
-		type = retry_bad_packed_offset(the_repository, p, obj_offset);
+		type = retry_bad_packed_offset(r, p, obj_offset);
 		if (type > OBJ_NONE)
 			goto out;
 	}
@@ -1272,15 +1271,15 @@ static void detach_delta_base_cache_entry(struct delta_base_cache_entry *ent)
 	free(ent);
 }
 
-#define cache_or_unpack_entry(r, p, bo, bs, t) cache_or_unpack_entry_##r(p, bo, bs, t)
-static void *cache_or_unpack_entry_the_repository(struct packed_git *p, off_t base_offset,
-	unsigned long *base_size, enum object_type *type)
+static void *cache_or_unpack_entry(struct repository *r, struct packed_git *p,
+				   off_t base_offset, unsigned long *base_size,
+				   enum object_type *type)
 {
 	struct delta_base_cache_entry *ent;
 
 	ent = get_delta_base_cache_entry(p, base_offset);
 	if (!ent)
-		return unpack_entry(the_repository, p, base_offset, type, base_size);
+		return unpack_entry(r, p, base_offset, type, base_size);
 
 	if (type)
 		*type = ent->type;
@@ -1334,8 +1333,8 @@ static void add_delta_base_cache(struct packed_git *p, off_t base_offset,
 	hashmap_add(&delta_base_cache, ent);
 }
 
-int packed_object_info_the_repository(struct packed_git *p, off_t obj_offset,
-				      struct object_info *oi)
+int packed_object_info(struct repository *r, struct packed_git *p,
+		       off_t obj_offset, struct object_info *oi)
 {
 	struct pack_window *w_curs = NULL;
 	unsigned long size;
@@ -1347,7 +1346,7 @@ int packed_object_info_the_repository(struct packed_git *p, off_t obj_offset,
 	 * a "real" type later if the caller is interested.
 	 */
 	if (oi->contentp) {
-		*oi->contentp = cache_or_unpack_entry(the_repository, p, obj_offset, oi->sizep,
+		*oi->contentp = cache_or_unpack_entry(r, p, obj_offset, oi->sizep,
 						      &type);
 		if (!*oi->contentp)
 			type = OBJ_BAD;
@@ -1381,7 +1380,7 @@ int packed_object_info_the_repository(struct packed_git *p, off_t obj_offset,
 
 	if (oi->typep || oi->type_name) {
 		enum object_type ptot;
-		ptot = packed_to_object_type(the_repository, p, obj_offset,
+		ptot = packed_to_object_type(r, p, obj_offset,
 					     type, &w_curs, curpos);
 		if (oi->typep)
 			*oi->typep = ptot;
@@ -1470,10 +1469,10 @@ struct unpack_entry_stack_ent {
 	unsigned long size;
 };
 
-#define read_object(r, o, t, s) read_object_##r(o, t, s)
-static void *read_object_the_repository(const struct object_id *oid,
-					enum object_type *type,
-					unsigned long *size)
+static void *read_object(struct repository *r,
+			 const struct object_id *oid,
+			 enum object_type *type,
+			 unsigned long *size)
 {
 	struct object_info oi = OBJECT_INFO_INIT;
 	void *content;
@@ -1481,14 +1480,13 @@ static void *read_object_the_repository(const struct object_id *oid,
 	oi.sizep = size;
 	oi.contentp = &content;
 
-	if (oid_object_info_extended(the_repository, oid, &oi, 0) < 0)
+	if (oid_object_info_extended(r, oid, &oi, 0) < 0)
 		return NULL;
 	return content;
 }
 
-void *unpack_entry_the_repository(struct packed_git *p, off_t obj_offset,
-				  enum object_type *final_type,
-				  unsigned long *final_size)
+void *unpack_entry(struct repository *r, struct packed_git *p, off_t obj_offset,
+		   enum object_type *final_type, unsigned long *final_size)
 {
 	struct pack_window *w_curs = NULL;
 	off_t curpos = obj_offset;
@@ -1618,7 +1616,7 @@ void *unpack_entry_the_repository(struct packed_git *p, off_t obj_offset,
 				      oid_to_hex(&base_oid), (uintmax_t)obj_offset,
 				      p->pack_name);
 				mark_bad_packed_object(p, base_oid.hash);
-				base = read_object(the_repository, &base_oid, &type, &base_size);
+				base = read_object(r, &base_oid, &type, &base_size);
 				external_base = base;
 			}
 		}
diff --git a/packfile.h b/packfile.h
index 1efa57a90e..fdfddb89b5 100644
--- a/packfile.h
+++ b/packfile.h
@@ -115,8 +115,7 @@ extern off_t nth_packed_object_offset(const struct packed_git *, uint32_t n);
 extern off_t find_pack_entry_one(const unsigned char *sha1, struct packed_git *);
 
 extern int is_pack_valid(struct packed_git *);
-#define unpack_entry(r, p, of, ot, s) unpack_entry_##r(p, of, ot, s)
-extern void *unpack_entry_the_repository(struct packed_git *, off_t, enum object_type *, unsigned long *);
+extern void *unpack_entry(struct repository *r, struct packed_git *, off_t, enum object_type *, unsigned long *);
 extern unsigned long unpack_object_header_buffer(const unsigned char *buf, unsigned long len, enum object_type *type, unsigned long *sizep);
 extern unsigned long get_size_from_delta(struct packed_git *, struct pack_window **, off_t);
 extern int unpack_object_header(struct packed_git *, struct pack_window **, off_t *, unsigned long *);
@@ -126,8 +125,9 @@ extern void release_pack_memory(size_t);
 /* global flag to enable extra checks when accessing packed objects */
 extern int do_check_packed_object_crc;
 
-#define packed_object_info(r, p, o, oi) packed_object_info_##r(p, o, oi)
-extern int packed_object_info_the_repository(struct packed_git *pack, off_t offset, struct object_info *);
+extern int packed_object_info(struct repository *r,
+			      struct packed_git *pack,
+			      off_t offset, struct object_info *);
 
 extern void mark_bad_packed_object(struct packed_git *p, const unsigned char *sha1);
 extern const struct packed_git *has_packed_and_bad(const unsigned char *sha1);
diff --git a/sha1_file.c b/sha1_file.c
index 746ff8297a..94123e0299 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1231,7 +1231,8 @@ static int sha1_loose_object_info(struct repository *r,
 
 int fetch_if_missing = 1;
 
-int oid_object_info_extended_the_repository(const struct object_id *oid, struct object_info *oi, unsigned flags)
+int oid_object_info_extended(struct repository *r, const struct object_id *oid,
+			     struct object_info *oi, unsigned flags)
 {
 	static struct object_info blank_oi = OBJECT_INFO_INIT;
 	struct pack_entry e;
@@ -1240,7 +1241,7 @@ int oid_object_info_extended_the_repository(const struct object_id *oid, struct
 	int already_retried = 0;
 
 	if (flags & OBJECT_INFO_LOOKUP_REPLACE)
-		real = lookup_replace_object(the_repository, oid);
+		real = lookup_replace_object(r, oid);
 
 	if (is_null_oid(real))
 		return -1;
@@ -1269,20 +1270,20 @@ int oid_object_info_extended_the_repository(const struct object_id *oid, struct
 	}
 
 	while (1) {
-		if (find_pack_entry(the_repository, real->hash, &e))
+		if (find_pack_entry(r, real->hash, &e))
 			break;
 
 		if (flags & OBJECT_INFO_IGNORE_LOOSE)
 			return -1;
 
 		/* Most likely it's a loose object. */
-		if (!sha1_loose_object_info(the_repository, real->hash, oi, flags))
+		if (!sha1_loose_object_info(r, real->hash, oi, flags))
 			return 0;
 
 		/* Not a loose object; someone else may have just packed it. */
 		if (!(flags & OBJECT_INFO_QUICK)) {
-			reprepare_packed_git(the_repository);
-			if (find_pack_entry(the_repository, real->hash, &e))
+			reprepare_packed_git(r);
+			if (find_pack_entry(r, real->hash, &e))
 				break;
 		}
 
@@ -1290,9 +1291,12 @@ int oid_object_info_extended_the_repository(const struct object_id *oid, struct
 		if (fetch_if_missing && repository_format_partial_clone &&
 		    !already_retried) {
 			/*
-			 * TODO Investigate haveing fetch_object() return
+			 * TODO Investigate having fetch_object() return
 			 * TODO error/success and stopping the music here.
+			 * TODO Pass a repository struct through fetch_object.
 			 */
+			if (r != the_repository)
+				die(_("partial clones only supported in the_repository"));
 			fetch_object(repository_format_partial_clone, real->hash);
 			already_retried = 1;
 			continue;
@@ -1307,10 +1311,10 @@ int oid_object_info_extended_the_repository(const struct object_id *oid, struct
 		 * information below, so return early.
 		 */
 		return 0;
-	rtype = packed_object_info(the_repository, e.p, e.offset, oi);
+	rtype = packed_object_info(r, e.p, e.offset, oi);
 	if (rtype < 0) {
 		mark_bad_packed_object(e.p, real->hash);
-		return oid_object_info_extended(the_repository, real, oi, 0);
+		return oid_object_info_extended(r, real, oi, 0);
 	} else if (oi->whence == OI_PACKED) {
 		oi->u.packed.offset = e.offset;
 		oi->u.packed.pack = e.p;
@@ -1322,15 +1326,17 @@ int oid_object_info_extended_the_repository(const struct object_id *oid, struct
 }
 
 /* returns enum object_type or negative */
-int oid_object_info_the_repository(const struct object_id *oid, unsigned long *sizep)
+int oid_object_info(struct repository *r,
+		    const struct object_id *oid,
+		    unsigned long *sizep)
 {
 	enum object_type type;
 	struct object_info oi = OBJECT_INFO_INIT;
 
 	oi.typep = &type;
 	oi.sizep = sizep;
-	if (oid_object_info_extended(the_repository, oid, &oi,
-				     OBJECT_INFO_LOOKUP_REPLACE) < 0)
+	if (oid_object_info_extended(r, oid, &oi,
+				      OBJECT_INFO_LOOKUP_REPLACE) < 0)
 		return -1;
 	return type;
 }
-- 
2.17.0.441.gb46fe60e1d-goog

