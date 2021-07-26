Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3135CC4338F
	for <git@archiver.kernel.org>; Mon, 26 Jul 2021 09:47:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 136EA60F49
	for <git@archiver.kernel.org>; Mon, 26 Jul 2021 09:47:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232938AbhGZJGb (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Jul 2021 05:06:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232932AbhGZJGZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Jul 2021 05:06:25 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A831EC061757
        for <git@vger.kernel.org>; Mon, 26 Jul 2021 02:46:53 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id a4-20020a17090aa504b0290176a0d2b67aso10458792pjq.2
        for <git@vger.kernel.org>; Mon, 26 Jul 2021 02:46:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2E0vQzywkAkm5sgQCYlBnjGL6bnEaLJtOjlGrCSjp0Y=;
        b=LuPGTAzf17bAzvv/1sQw7h7ez2WbCE30BhLFx5iT48babMaK6NWQiQ4LtGScTsapE2
         tFV0w/O6ubEdMORCj/vtMd9BR4mUtRCM001/+2aqE90TpjCbdXhSQiw9+wshz65c/YxO
         zYd64raiBv4mc2LSGzWZ+Z7h67WsF76fSP9R4XUy5rsT65XwXJgeNV/RPl5VEuW6BNbR
         QmsKPvl7HDPFVT6RckJgGxTHwvruprlBYTwGIhYH+iIjKxRxr/IinB7HknRWf9oWrlTg
         tDwtwXdL5v1Hj3wa5QAjk76wQ7jqWUHrVDrQGDbD6V7hr6cUMbR/VGAO/CiRIZOH2dor
         0uuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2E0vQzywkAkm5sgQCYlBnjGL6bnEaLJtOjlGrCSjp0Y=;
        b=T7pxbOJBBrQVTXfEcMqBpVcmsfPSpqmd6Fp9zmQznSv8tnpPbFDwn5VC6bD8tg67qD
         jb7+WYtLAs0ymWqAC0MfQKKD7/JKYq78Dzq+5PSjjH/5byVgcdl81bS1sVzIEVYNSa2R
         FdvDuxJ+Iy706xYdPCyfXOMqSNsw5xI22y+MBMzNuSCuK16+l0s3XxcMRGWUPVujKhvs
         Vuqe7q7sF6oZq+WFqcT7XbA4jTXDfa/F8gAy31zDChnmfKGCs4nedKgieNdhJdLZnlCO
         IyjOsNjD/BG3jd2F7/fB+gO1kbtxq+mUZYPqzSw7+2RDH+PZYF57wF7x6fn+PZX2qENP
         rERQ==
X-Gm-Message-State: AOAM531gzW+cv7u+QFIQvjxqrEnpjbj8cCnO/Mu7QFHD0ssRwSvJKu//
        ozSQCooLx4KAqeKukto6e9WUdUHQUGQ7Mtg+DQA=
X-Google-Smtp-Source: ABdhPJyTaRf66ZJ4LiExMZFDyL+K3FQikchjjDXKkUyUfQ+x0dXkx5pZ9rRjs2WxMwpN59Iug9+7bA==
X-Received: by 2002:a05:6a00:a94:b029:384:1dc6:7012 with SMTP id b20-20020a056a000a94b02903841dc67012mr13264726pfl.53.1627292812919;
        Mon, 26 Jul 2021 02:46:52 -0700 (PDT)
Received: from localhost.localdomain ([115.227.76.17])
        by smtp.gmail.com with ESMTPSA id g13sm42522319pfo.112.2021.07.26.02.46.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Jul 2021 02:46:52 -0700 (PDT)
From:   Teng Long <dyroneteng@gmail.com>
To:     git@vger.kernel.org
Cc:     jonathantanmy@google.com, avarab@gmail.com,
        Teng Long <dyroneteng@gmail.com>
Subject: [PATCH v3 1/3] packfile-uris: support for excluding commit objects
Date:   Mon, 26 Jul 2021 17:46:12 +0800
Message-Id: <91dce385f630f4741bc6bb1540ef3c65e95a113f.1627292425.git.dyroneteng@gmail.com>
X-Mailer: git-send-email 2.31.1.443.g55c63af4c9.dirty
In-Reply-To: <cover.1627292424.git.dyroneteng@gmail.com>
References: <cover.1627292424.git.dyroneteng@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On the server, more sophisticated means of excluding objects should be
supported, such as commit object. This commit introduces a new
configuration `uploadpack.excludeobject` for this.

The reason for bringing a new configuration is for two considerations.
First, the old configuration supports a single object type (blob), which
limits the use of this feature. Secondly, the name of the old
configuration is not abstract enough, this make extension difficult. If
different object types use different configuration names, the
configuration items will be bloated and difficult to maintain, so the
new configuration is more abstract in name and easy to extend.

Although a new configuration has been introduced, the old one is
still available and compatible with the new configuration. The old
configuration `uploadpack.blobpackfileuri` only supports excluding
blobs. The new configuration `uploadpack.excludeobject` not only
supports excluding blob objects, but also supports excluding commit
objects, as well as recursively excluding tree objects and blob objects
they contain.

Signed-off-by: Teng Long <dyroneteng@gmail.com>
---
 builtin/describe.c     |  4 +-
 builtin/pack-objects.c | 97 ++++++++++++++++++++++++------------------
 builtin/rev-list.c     |  2 +-
 fetch-pack.c           |  6 +++
 list-objects.c         | 37 +++++++++-------
 list-objects.h         |  2 +-
 object.c               | 15 +++++--
 object.h               |  4 ++
 pack-bitmap.c          |  8 ++--
 reachable.c            |  8 ++--
 revision.c             | 36 +++++++++++-----
 revision.h             |  4 ++
 upload-pack.c          |  7 +++
 13 files changed, 148 insertions(+), 82 deletions(-)

diff --git a/builtin/describe.c b/builtin/describe.c
index 40482d8e9f..045da79b5c 100644
--- a/builtin/describe.c
+++ b/builtin/describe.c
@@ -485,9 +485,9 @@ static void process_commit(struct commit *commit, void *data)
 	pcd->current_commit = commit->object.oid;
 }
 
-static void process_object(struct object *obj, const char *path, void *data)
+static void process_object(struct object *obj, const char *path, void *show_data, void *carry_data)
 {
-	struct process_commit_data *pcd = data;
+	struct process_commit_data *pcd = show_data;
 
 	if (oideq(&pcd->looking_for, &obj->oid) && !pcd->dst->len) {
 		reset_revision_walk();
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 6d13cd3e1a..154c98bcb6 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -1188,6 +1188,24 @@ static int have_duplicate_entry(const struct object_id *oid,
 	return 1;
 }
 
+static int match_packfile_uri_exclusions(struct configured_exclusion *ex)
+{
+	int i;
+	const char *p;
+
+	if (ex) {
+		for (i = 0; i < uri_protocols.nr; i++) {
+			if (skip_prefix(ex->uri,
+					uri_protocols.items[i].string,
+					&p) &&
+			    *p == ':')
+				return 1;
+
+		}
+	}
+	return 0;
+}
+
 static int want_found_object(const struct object_id *oid, int exclude,
 			     struct packed_git *p)
 {
@@ -1293,7 +1311,8 @@ static int want_object_in_pack_one(struct packed_git *p,
 static int want_object_in_pack(const struct object_id *oid,
 			       int exclude,
 			       struct packed_git **found_pack,
-			       off_t *found_offset)
+			       off_t *found_offset,
+			       struct object *referred_commit)
 {
 	int want;
 	struct list_head *pos;
@@ -1333,21 +1352,13 @@ static int want_object_in_pack(const struct object_id *oid,
 	}
 
 	if (uri_protocols.nr) {
-		struct configured_exclusion *ex =
-			oidmap_get(&configured_exclusions, oid);
-		int i;
-		const char *p;
-
-		if (ex) {
-			for (i = 0; i < uri_protocols.nr; i++) {
-				if (skip_prefix(ex->uri,
-						uri_protocols.items[i].string,
-						&p) &&
-				    *p == ':') {
-					oidset_insert(&excluded_by_config, oid);
-					return 0;
-				}
-			}
+		if (referred_commit) {
+			if (oidmap_get(&configured_exclusions, &referred_commit->oid) && match_packfile_uri_exclusions(referred_ex))
+				return 0;
+		}
+		if (oidmap_get(&configured_exclusions, oid) && match_packfile_uri_exclusions(ex)) {
+			oidset_insert(&excluded_by_config, oid);
+			return 0;
 		}
 	}
 
@@ -1384,7 +1395,8 @@ static const char no_closure_warning[] = N_(
 );
 
 static int add_object_entry(const struct object_id *oid, enum object_type type,
-			    const char *name, int exclude)
+			    const char *name, int exclude,
+			    struct object *referred_commit)
 {
 	struct packed_git *found_pack = NULL;
 	off_t found_offset = 0;
@@ -1394,7 +1406,7 @@ static int add_object_entry(const struct object_id *oid, enum object_type type,
 	if (have_duplicate_entry(oid, exclude))
 		return 0;
 
-	if (!want_object_in_pack(oid, exclude, &found_pack, &found_offset)) {
+	if (!want_object_in_pack(oid, exclude, &found_pack, &found_offset, referred_commit)) {
 		/* The pack is missing an object, so it will not have closure */
 		if (write_bitmap_index) {
 			if (write_bitmap_index != WRITE_BITMAP_QUIET)
@@ -1420,7 +1432,7 @@ static int add_object_entry_from_bitmap(const struct object_id *oid,
 	if (have_duplicate_entry(oid, 0))
 		return 0;
 
-	if (!want_object_in_pack(oid, 0, &pack, &offset))
+	if (!want_object_in_pack(oid, 0, &pack, &offset, NULL))
 		return 0;
 
 	create_object_entry(oid, type, name_hash, 0, 0, pack, offset);
@@ -1560,7 +1572,7 @@ static void add_pbase_object(struct tree_desc *tree,
 		if (name[cmplen] != '/') {
 			add_object_entry(&entry.oid,
 					 object_type(entry.mode),
-					 fullname, 1);
+					 fullname, 1, NULL);
 			return;
 		}
 		if (S_ISDIR(entry.mode)) {
@@ -1628,7 +1640,7 @@ static void add_preferred_base_object(const char *name)
 	cmplen = name_cmp_len(name);
 	for (it = pbase_tree; it; it = it->next) {
 		if (cmplen == 0) {
-			add_object_entry(&it->pcache.oid, OBJ_TREE, NULL, 1);
+			add_object_entry(&it->pcache.oid, OBJ_TREE, NULL, 1, NULL);
 		}
 		else {
 			struct tree_desc tree;
@@ -2830,7 +2842,7 @@ static void add_tag_chain(const struct object_id *oid)
 			die(_("unable to pack objects reachable from tag %s"),
 			    oid_to_hex(oid));
 
-		add_object_entry(&tag->object.oid, OBJ_TAG, NULL, 0);
+		add_object_entry(&tag->object.oid, OBJ_TAG, NULL, 0, NULL);
 
 		if (tag->tagged->type != OBJ_TAG)
 			return;
@@ -2985,7 +2997,7 @@ static int git_pack_config(const char *k, const char *v, void *cb)
 			pack_idx_opts.flags &= ~WRITE_REV;
 		return 0;
 	}
-	if (!strcmp(k, "uploadpack.blobpackfileuri")) {
+	if (!strcmp(k, "uploadpack.excludeobject") || !strcmp(k, "uploadpack.blobpackfileuri")) {
 		struct configured_exclusion *ex = xmalloc(sizeof(*ex));
 		const char *oid_end, *pack_end;
 		/*
@@ -2998,11 +3010,11 @@ static int git_pack_config(const char *k, const char *v, void *cb)
 		    *oid_end != ' ' ||
 		    parse_oid_hex(oid_end + 1, &pack_hash, &pack_end) ||
 		    *pack_end != ' ')
-			die(_("value of uploadpack.blobpackfileuri must be "
-			      "of the form '<object-hash> <pack-hash> <uri>' (got '%s')"), v);
+                        die(_("value of uploadpack.excludeobject or uploadpack.blobpackfileuri must be "
+                              "of the form '<object-hash> <pack-hash> <uri>' (got '%s')"), v);
 		if (oidmap_get(&configured_exclusions, &ex->e.oid))
-			die(_("object already configured in another "
-			      "uploadpack.blobpackfileuri (got '%s')"), v);
+                        die(_("object already configured by an earlier "
+                              "uploadpack.excludeobject or uploadpack.blobpackfileuri (got '%s')"), v);
 		ex->pack_hash_hex = xcalloc(1, pack_end - oid_end);
 		memcpy(ex->pack_hash_hex, oid_end + 1, pack_end - oid_end - 1);
 		ex->uri = xstrdup(pack_end + 1);
@@ -3031,7 +3043,7 @@ static int add_object_entry_from_pack(const struct object_id *oid,
 		return 0;
 
 	ofs = nth_packed_object_offset(p, pos);
-	if (!want_object_in_pack(oid, 0, &p, &ofs))
+	if (!want_object_in_pack(oid, 0, &p, &ofs, NULL))
 		return 0;
 
 	oi.typep = &type;
@@ -3059,7 +3071,7 @@ static void show_commit_pack_hint(struct commit *commit, void *_data)
 }
 
 static void show_object_pack_hint(struct object *object, const char *name,
-				  void *_data)
+				  void *show_data, void *carry_data)
 {
 	struct object_entry *oe = packlist_find(&to_pack, &object->oid);
 	if (!oe)
@@ -3224,7 +3236,7 @@ static void read_object_list_from_stdin(void)
 			die(_("expected object ID, got garbage:\n %s"), line);
 
 		add_preferred_base_object(p + 1);
-		add_object_entry(&oid, OBJ_NONE, p + 1, 0);
+		add_object_entry(&oid, OBJ_NONE, p + 1, 0, NULL);
 	}
 }
 
@@ -3233,7 +3245,7 @@ static void read_object_list_from_stdin(void)
 
 static void show_commit(struct commit *commit, void *data)
 {
-	add_object_entry(&commit->object.oid, OBJ_COMMIT, NULL, 0);
+	add_object_entry(&commit->object.oid, OBJ_COMMIT, NULL, 0, NULL);
 	commit->object.flags |= OBJECT_ADDED;
 
 	if (write_bitmap_index)
@@ -3243,10 +3255,11 @@ static void show_commit(struct commit *commit, void *data)
 		propagate_island_marks(commit);
 }
 
-static void show_object(struct object *obj, const char *name, void *data)
+static void show_object(struct object *obj, const char *name, void *show_data, void *carry_data)
 {
+	struct object *referred_commit = carry_data;
 	add_preferred_base_object(name);
-	add_object_entry(&obj->oid, obj->type, name, 0);
+	add_object_entry(&obj->oid, obj->type, name, 0, referred_commit);
 	obj->flags |= OBJECT_ADDED;
 
 	if (use_delta_islands) {
@@ -3265,7 +3278,7 @@ static void show_object(struct object *obj, const char *name, void *data)
 	}
 }
 
-static void show_object__ma_allow_any(struct object *obj, const char *name, void *data)
+static void show_object__ma_allow_any(struct object *obj, const char *name, void *show_data, void *carry_data)
 {
 	assert(arg_missing_action == MA_ALLOW_ANY);
 
@@ -3276,10 +3289,10 @@ static void show_object__ma_allow_any(struct object *obj, const char *name, void
 	if (!has_object(the_repository, &obj->oid, 0))
 		return;
 
-	show_object(obj, name, data);
+	show_object(obj, name, show_data, carry_data);
 }
 
-static void show_object__ma_allow_promisor(struct object *obj, const char *name, void *data)
+static void show_object__ma_allow_promisor(struct object *obj, const char *name, void *show_data, void *carry_data)
 {
 	assert(arg_missing_action == MA_ALLOW_PROMISOR);
 
@@ -3290,7 +3303,7 @@ static void show_object__ma_allow_promisor(struct object *obj, const char *name,
 	if (!has_object(the_repository, &obj->oid, 0) && is_promisor_object(&obj->oid))
 		return;
 
-	show_object(obj, name, data);
+	show_object(obj, name, show_data, carry_data);
 }
 
 static int option_parse_missing_action(const struct option *opt,
@@ -3397,7 +3410,7 @@ static void add_objects_in_unpacked_packs(void)
 		QSORT(in_pack.array, in_pack.nr, ofscmp);
 		for (i = 0; i < in_pack.nr; i++) {
 			struct object *o = in_pack.array[i].object;
-			add_object_entry(&o->oid, o->type, "", 0);
+			add_object_entry(&o->oid, o->type, "", 0, NULL);
 		}
 	}
 	free(in_pack.array);
@@ -3413,7 +3426,7 @@ static int add_loose_object(const struct object_id *oid, const char *path,
 		return 0;
 	}
 
-	add_object_entry(oid, type, "", 0);
+	add_object_entry(oid, type, "", 0, NULL);
 	return 0;
 }
 
@@ -3538,7 +3551,8 @@ static int get_object_list_from_bitmap(struct rev_info *revs)
 
 static void record_recent_object(struct object *obj,
 				 const char *name,
-				 void *data)
+				 void *show_data,
+				 void *carry_data)
 {
 	oid_array_append(&recent_objects, &obj->oid);
 }
@@ -3831,7 +3845,8 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 			 N_("respect islands during delta compression")),
 		OPT_STRING_LIST(0, "uri-protocol", &uri_protocols,
 				N_("protocol"),
-				N_("exclude any configured uploadpack.blobpackfileuri with this protocol")),
+				N_("exclude any configured uploadpack.excludeobject or "
+				   	"uploadpack.blobpackfileuri with this protocol")),
 		OPT_END(),
 	};
 
diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index b4d8ea0a35..1cad33d9e8 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -266,7 +266,7 @@ static int finish_object(struct object *obj, const char *name, void *cb_data)
 	return 0;
 }
 
-static void show_object(struct object *obj, const char *name, void *cb_data)
+static void show_object(struct object *obj, const char *name, void *cb_data, void *carry_data)
 {
 	struct rev_list_info *info = cb_data;
 	struct rev_info *revs = info->revs;
diff --git a/fetch-pack.c b/fetch-pack.c
index 2318ebe680..39bb449586 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -23,6 +23,7 @@
 #include "fetch-negotiator.h"
 #include "fsck.h"
 #include "shallow.h"
+#include "strmap.h"
 
 static int transfer_unpack_limit = -1;
 static int fetch_unpack_limit = -1;
@@ -1576,6 +1577,7 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
 	struct string_list packfile_uris = STRING_LIST_INIT_DUP;
 	int i;
 	struct strvec index_pack_args = STRVEC_INIT;
+	struct strset uris;
 
 	negotiator = &negotiator_alloc;
 	fetch_negotiator_init(r, negotiator);
@@ -1677,6 +1679,7 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
 		}
 	}
 
+	strset_init(&uris);
 	for (i = 0; i < packfile_uris.nr; i++) {
 		int j;
 		struct child_process cmd = CHILD_PROCESS_INIT;
@@ -1684,6 +1687,8 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
 		const char *uri = packfile_uris.items[i].string +
 			the_hash_algo->hexsz + 1;
 
+		if (!strset_add(&uris, uri))
+			continue;
 		strvec_push(&cmd.args, "http-fetch");
 		strvec_pushf(&cmd.args, "--packfile=%.*s",
 			     (int) the_hash_algo->hexsz,
@@ -1727,6 +1732,7 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
 						 get_object_directory(),
 						 packname));
 	}
+	strset_clear(&uris);
 	string_list_clear(&packfile_uris, 0);
 	strvec_clear(&index_pack_args);
 
diff --git a/list-objects.c b/list-objects.c
index e19589baa0..fa3156dc89 100644
--- a/list-objects.c
+++ b/list-objects.c
@@ -24,7 +24,8 @@ struct traversal_context {
 static void process_blob(struct traversal_context *ctx,
 			 struct blob *blob,
 			 struct strbuf *path,
-			 const char *name)
+			 const char *name,
+			 struct object *referred_commit)
 {
 	struct object *obj = &blob->object;
 	size_t pathlen;
@@ -60,7 +61,7 @@ static void process_blob(struct traversal_context *ctx,
 	if (r & LOFR_MARK_SEEN)
 		obj->flags |= SEEN;
 	if (r & LOFR_DO_SHOW)
-		ctx->show_object(obj, path->buf, ctx->show_data);
+		ctx->show_object(obj, path->buf, ctx->show_data, referred_commit);
 	strbuf_setlen(path, pathlen);
 }
 
@@ -97,11 +98,13 @@ static void process_gitlink(struct traversal_context *ctx,
 static void process_tree(struct traversal_context *ctx,
 			 struct tree *tree,
 			 struct strbuf *base,
-			 const char *name);
+			 const char *name,
+			 struct object *referred_commit);
 
 static void process_tree_contents(struct traversal_context *ctx,
 				  struct tree *tree,
-				  struct strbuf *base)
+				  struct strbuf *base,
+				  struct object *referred_commit)
 {
 	struct tree_desc desc;
 	struct name_entry entry;
@@ -129,7 +132,7 @@ static void process_tree_contents(struct traversal_context *ctx,
 				    entry.path, oid_to_hex(&tree->object.oid));
 			}
 			t->object.flags |= NOT_USER_GIVEN;
-			process_tree(ctx, t, base, entry.path);
+			process_tree(ctx, t, base, entry.path, referred_commit);
 		}
 		else if (S_ISGITLINK(entry.mode))
 			process_gitlink(ctx, entry.oid.hash,
@@ -142,7 +145,7 @@ static void process_tree_contents(struct traversal_context *ctx,
 				    entry.path, oid_to_hex(&tree->object.oid));
 			}
 			b->object.flags |= NOT_USER_GIVEN;
-			process_blob(ctx, b, base, entry.path);
+			process_blob(ctx, b, base, entry.path, referred_commit);
 		}
 	}
 }
@@ -150,7 +153,8 @@ static void process_tree_contents(struct traversal_context *ctx,
 static void process_tree(struct traversal_context *ctx,
 			 struct tree *tree,
 			 struct strbuf *base,
-			 const char *name)
+			 const char *name,
+			 struct object *referred_commit)
 {
 	struct object *obj = &tree->object;
 	struct rev_info *revs = ctx->revs;
@@ -191,14 +195,14 @@ static void process_tree(struct traversal_context *ctx,
 	if (r & LOFR_MARK_SEEN)
 		obj->flags |= SEEN;
 	if (r & LOFR_DO_SHOW)
-		ctx->show_object(obj, base->buf, ctx->show_data);
+		ctx->show_object(obj, base->buf, ctx->show_data, referred_commit);
 	if (base->len)
 		strbuf_addch(base, '/');
 
 	if (r & LOFR_SKIP_TREE)
 		trace_printf("Skipping contents of tree %s...\n", base->buf);
 	else if (!failed_parse)
-		process_tree_contents(ctx, tree, base);
+		process_tree_contents(ctx, tree, base, referred_commit);
 
 	r = list_objects_filter__filter_object(ctx->revs->repo,
 					       LOFS_END_TREE, obj,
@@ -207,7 +211,7 @@ static void process_tree(struct traversal_context *ctx,
 	if (r & LOFR_MARK_SEEN)
 		obj->flags |= SEEN;
 	if (r & LOFR_DO_SHOW)
-		ctx->show_object(obj, base->buf, ctx->show_data);
+		ctx->show_object(obj, base->buf, ctx->show_data, referred_commit);
 
 	strbuf_setlen(base, baselen);
 	free_tree_buffer(tree);
@@ -314,9 +318,9 @@ void mark_edges_uninteresting(struct rev_info *revs,
 	}
 }
 
-static void add_pending_tree(struct rev_info *revs, struct tree *tree)
+static void add_pending_tree(struct rev_info *revs,  struct tree *tree, struct object *referred_commit)
 {
-	add_pending_object(revs, &tree->object, "");
+	add_pending_object_with_referred_commit(revs, &tree->object, "", referred_commit);
 }
 
 static void traverse_trees_and_blobs(struct traversal_context *ctx,
@@ -329,23 +333,24 @@ static void traverse_trees_and_blobs(struct traversal_context *ctx,
 	for (i = 0; i < ctx->revs->pending.nr; i++) {
 		struct object_array_entry *pending = ctx->revs->pending.objects + i;
 		struct object *obj = pending->item;
+		struct object *referred_commit = pending->referred_commit;
 		const char *name = pending->name;
 		const char *path = pending->path;
 		if (obj->flags & (UNINTERESTING | SEEN))
 			continue;
 		if (obj->type == OBJ_TAG) {
 			obj->flags |= SEEN;
-			ctx->show_object(obj, name, ctx->show_data);
+			ctx->show_object(obj, name, ctx->show_data, referred_commit);
 			continue;
 		}
 		if (!path)
 			path = "";
 		if (obj->type == OBJ_TREE) {
-			process_tree(ctx, (struct tree *)obj, base, path);
+			process_tree(ctx, (struct tree *)obj, base, path, referred_commit);
 			continue;
 		}
 		if (obj->type == OBJ_BLOB) {
-			process_blob(ctx, (struct blob *)obj, base, path);
+			process_blob(ctx, (struct blob *)obj, base, path, referred_commit);
 			continue;
 		}
 		die("unknown pending object %s (%s)",
@@ -370,7 +375,7 @@ static void do_traverse(struct traversal_context *ctx)
 		else if (get_commit_tree(commit)) {
 			struct tree *tree = get_commit_tree(commit);
 			tree->object.flags |= NOT_USER_GIVEN;
-			add_pending_tree(ctx->revs, tree);
+			add_pending_tree(ctx->revs, tree, &commit->object);
 		} else if (commit->object.parsed) {
 			die(_("unable to load root tree for commit %s"),
 			      oid_to_hex(&commit->object.oid));
diff --git a/list-objects.h b/list-objects.h
index a952680e46..ab946d34db 100644
--- a/list-objects.h
+++ b/list-objects.h
@@ -6,7 +6,7 @@ struct object;
 struct rev_info;
 
 typedef void (*show_commit_fn)(struct commit *, void *);
-typedef void (*show_object_fn)(struct object *, const char *, void *);
+typedef void (*show_object_fn)(struct object *, const char *, void *, void *);
 void traverse_commit_list(struct rev_info *, show_commit_fn, show_object_fn, void *);
 
 typedef void (*show_edge_fn)(struct commit *);
diff --git a/object.c b/object.c
index 14188453c5..6b1ce2fcde 100644
--- a/object.c
+++ b/object.c
@@ -322,9 +322,10 @@ void object_list_free(struct object_list **list)
  */
 static char object_array_slopbuf[1];
 
-void add_object_array_with_path(struct object *obj, const char *name,
-				struct object_array *array,
-				unsigned mode, const char *path)
+void add_object_array_with_path_and_referred_commit(struct object *obj, const char *name,
+						    struct object_array *array,
+						    unsigned mode, const char *path,
+						    struct object *referred_commit)
 {
 	unsigned nr = array->nr;
 	unsigned alloc = array->alloc;
@@ -339,6 +340,7 @@ void add_object_array_with_path(struct object *obj, const char *name,
 	}
 	entry = &objects[nr];
 	entry->item = obj;
+	entry->referred_commit = referred_commit;
 	if (!name)
 		entry->name = NULL;
 	else if (!*name)
@@ -354,6 +356,13 @@ void add_object_array_with_path(struct object *obj, const char *name,
 	array->nr = ++nr;
 }
 
+void add_object_array_with_path(struct object *obj, const char *name,
+				struct object_array *array,
+				unsigned mode, const char *path)
+{
+	add_object_array_with_path_and_referred_commit(obj, name, array, mode, path, NULL);
+}
+
 void add_object_array(struct object *obj, const char *name, struct object_array *array)
 {
 	add_object_array_with_path(obj, name, array, S_IFINVALID, NULL);
diff --git a/object.h b/object.h
index 87a6da47c8..de9f15b97d 100644
--- a/object.h
+++ b/object.h
@@ -43,6 +43,7 @@ struct object_array {
 	unsigned int alloc;
 	struct object_array_entry {
 		struct object *item;
+		struct object *referred_commit;
 		/*
 		 * name or NULL.  If non-NULL, the memory pointed to
 		 * is owned by this object *except* if it points at
@@ -157,6 +158,9 @@ void object_list_free(struct object_list **list);
 /* Object array handling .. */
 void add_object_array(struct object *obj, const char *name, struct object_array *array);
 void add_object_array_with_path(struct object *obj, const char *name, struct object_array *array, unsigned mode, const char *path);
+void add_object_array_with_path_and_referred_commit(struct object *obj, const char *name, struct object_array *array,
+						    unsigned mode, const char *path,
+						    struct object *referred_commit);
 
 /*
  * Returns NULL if the array is empty. Otherwise, returns the last object
diff --git a/pack-bitmap.c b/pack-bitmap.c
index 3ed15431cd..516eb235da 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -459,9 +459,9 @@ struct bitmap_show_data {
 	struct bitmap *base;
 };
 
-static void show_object(struct object *object, const char *name, void *data_)
+static void show_object(struct object *object, const char *name, void *show_data, void *carry_data)
 {
-	struct bitmap_show_data *data = data_;
+	struct bitmap_show_data *data = show_data;
 	int bitmap_pos;
 
 	bitmap_pos = bitmap_position(data->bitmap_git, &object->oid);
@@ -1268,9 +1268,9 @@ struct bitmap_test_data {
 };
 
 static void test_show_object(struct object *object, const char *name,
-			     void *data)
+			     void *show_data, void *carry_data)
 {
-	struct bitmap_test_data *tdata = data;
+	struct bitmap_test_data *tdata = show_data;
 	int bitmap_pos;
 
 	bitmap_pos = bitmap_position(tdata->bitmap_git, &object->oid);
diff --git a/reachable.c b/reachable.c
index 77a60c70a5..ebd817c446 100644
--- a/reachable.c
+++ b/reachable.c
@@ -47,14 +47,14 @@ static int add_one_ref(const char *path, const struct object_id *oid,
  * The traversal will have already marked us as SEEN, so we
  * only need to handle any progress reporting here.
  */
-static void mark_object(struct object *obj, const char *name, void *data)
+static void mark_object(struct object *obj, const char *name, void *show_data, void *carry_data)
 {
-	update_progress(data);
+	update_progress(show_data);
 }
 
-static void mark_commit(struct commit *c, void *data)
+static void mark_commit(struct commit *c, void *show_data)
 {
-	mark_object(&c->object, NULL, data);
+	mark_object(&c->object, NULL, show_data,  NULL);
 }
 
 struct recent_data {
diff --git a/revision.c b/revision.c
index 4853c85d0b..da0ce0e3f2 100644
--- a/revision.c
+++ b/revision.c
@@ -304,10 +304,11 @@ void mark_parents_uninteresting(struct commit *commit)
 	commit_stack_clear(&pending);
 }
 
-static void add_pending_object_with_path(struct rev_info *revs,
-					 struct object *obj,
-					 const char *name, unsigned mode,
-					 const char *path)
+static void add_pending_object_with_path_and_referred_commit(struct rev_info *revs,
+							     struct object *obj,
+							     const char *name, unsigned mode,
+							     const char *path,
+							     struct object *referred_commit)
 {
 	struct interpret_branch_name_options options = { 0 };
 	if (!obj)
@@ -326,20 +327,36 @@ static void add_pending_object_with_path(struct rev_info *revs,
 		strbuf_release(&buf);
 		return; /* do not add the commit itself */
 	}
-	add_object_array_with_path(obj, name, &revs->pending, mode, path);
+	add_object_array_with_path_and_referred_commit(obj, name, &revs->pending, mode, path, referred_commit);
+}
+
+static void add_pending_object_with_path(struct rev_info *revs,
+					 struct object *obj,
+					 const char *name, unsigned mode,
+					 const char *path) {
+	add_pending_object_with_path_and_referred_commit(revs, obj, name, mode, path, NULL);
 }
 
 static void add_pending_object_with_mode(struct rev_info *revs,
 					 struct object *obj,
-					 const char *name, unsigned mode)
+					 const char *name, unsigned mode,
+					 struct object *referred_commit)
 {
-	add_pending_object_with_path(revs, obj, name, mode, NULL);
+
+	add_pending_object_with_path_and_referred_commit(revs, obj, name, mode, NULL, referred_commit);
+}
+
+void add_pending_object_with_referred_commit(struct rev_info *revs,
+					     struct object *obj, const char *name,
+					     struct object *referred_commit)
+{
+	add_pending_object_with_mode(revs, obj, name, S_IFINVALID, referred_commit);
 }
 
 void add_pending_object(struct rev_info *revs,
 			struct object *obj, const char *name)
 {
-	add_pending_object_with_mode(revs, obj, name, S_IFINVALID);
+	add_pending_object_with_mode(revs, obj, name, S_IFINVALID, NULL);
 }
 
 void add_head_to_pending(struct rev_info *revs)
@@ -2764,7 +2781,6 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
 			continue;
 		}
 
-
 		if (handle_revision_arg(arg, revs, flags, revarg_opt)) {
 			int j;
 			if (seen_dashdash || *arg == '^')
@@ -2817,7 +2833,7 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
 		if (get_oid_with_context(revs->repo, revs->def, 0, &oid, &oc))
 			diagnose_missing_default(revs->def);
 		object = get_reference(revs, revs->def, &oid, 0);
-		add_pending_object_with_mode(revs, object, revs->def, oc.mode);
+		add_pending_object_with_mode(revs, object, revs->def, oc.mode, NULL);
 	}
 
 	/* Did the user ask for any diff output? Run the diff! */
diff --git a/revision.h b/revision.h
index a24f72dcd1..8a632e3587 100644
--- a/revision.h
+++ b/revision.h
@@ -424,6 +424,10 @@ void show_object_with_name(FILE *, struct object *, const char *);
 void add_pending_object(struct rev_info *revs,
 			struct object *obj, const char *name);
 
+void add_pending_object_with_referred_commit(struct rev_info *revs,
+					     struct object *obj, const char *name,
+					     struct object *referred_commit);
+
 void add_pending_oid(struct rev_info *revs,
 		     const char *name, const struct object_id *oid,
 		     unsigned int flags);
diff --git a/upload-pack.c b/upload-pack.c
index 5c1cd19612..d26fb351a3 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -1751,6 +1751,13 @@ int upload_pack_advertise(struct repository *r,
 			strbuf_addstr(value, " packfile-uris");
 			free(str);
 		}
+
+		if (!repo_config_get_string(the_repository,
+					    "uploadpack.excludeobject",
+					    &str) && str) {
+			strbuf_addstr(value, " packfile-uris");
+			free(str);
+		}
 	}
 
 	return 1;
-- 
2.31.1.443.g55c63af4c9.dirty

