Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41179C433EF
	for <git@archiver.kernel.org>; Tue, 19 Oct 2021 11:40:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 29A836137C
	for <git@archiver.kernel.org>; Tue, 19 Oct 2021 11:40:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235481AbhJSLmU (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Oct 2021 07:42:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235480AbhJSLmK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Oct 2021 07:42:10 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04B10C06177E
        for <git@vger.kernel.org>; Tue, 19 Oct 2021 04:39:38 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id s136so15854590pgs.4
        for <git@vger.kernel.org>; Tue, 19 Oct 2021 04:39:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DPYV815Opfv1tsavPSYetwkcL45amc6HO/kOMN247hE=;
        b=K6njnMRi0u5f7hE0riaoYe5kTJxRL+Xj2j1FwzRiO6s7NCsrnW+ZLylsFXOedP2v4+
         7HUfJNw7XgrKPixvhAfAHCISV/eSpabKPYHmoGcmLyGTkTYgJoTtSe6hfrBUo35/W8lA
         ojS7CEhmKkSpKCCqZVB/JPxREYjcQ1LPXV0muwbfpunHBEx9NOQsih5/dWGrzKbeZzRU
         ZCgO75a6XB+RwrmtXCRAV10KDgAEjce8EdmWiryw9ykHOKY6CNXaITz6IZAfsobalB5i
         YTfrmxETZYbBJt0G+t4OB1rH+zYZwK+5mZwcOesUHHWuKyv4pcvWU20bliaa/i20kgLZ
         YRjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DPYV815Opfv1tsavPSYetwkcL45amc6HO/kOMN247hE=;
        b=8O9fp2VlY/oSoIycYEcizYBZrUsKq0iL0x5V/NvieDSAav0+AVoXetolZXy5W5z592
         dALAEWOv0W991jc8MwD31nK9Vg+a0LIUaDgPisa38hrMqoYy1FSGqmi8NB+VRQsORYlH
         yGzUXe1IH9IEpzkwl2My3OKuiWvJtFAJsFcIiPXeKOMRT2gKo1MNwqj+7fgG+Sv9cnsv
         6hJ/h2B/LynfQPQ/u+GARClmepxEXhzeP5cVvOBPt2613KQq69/mn8iNW3BySMBwBZpB
         TkZLH9qE8GdmUXg/xmgqNJXpohR1qtZ0m29c7aqW5WeGxVVSr02xN4LgEfEcM+MpE4ya
         x5iQ==
X-Gm-Message-State: AOAM532ola2AIofqq6RcZsGmVqILCDFUhRV4qI1GqdqWn/XKLL4SDA9P
        +7p+HiTtZBRROObXbIDAah2DjjLcLkk=
X-Google-Smtp-Source: ABdhPJy70Ta5QdQuMIAOkjrbz+o+fSpnG+kDNoah3ebdjIeQHj2+qNsPcHrGmbccEx/14vpnH4/4rg==
X-Received: by 2002:a62:7904:0:b0:44c:ca08:1956 with SMTP id u4-20020a627904000000b0044cca081956mr34712339pfc.47.1634643577306;
        Tue, 19 Oct 2021 04:39:37 -0700 (PDT)
Received: from localhost.localdomain ([205.204.117.96])
        by smtp.gmail.com with ESMTPSA id l207sm16430861pfd.199.2021.10.19.04.39.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Oct 2021 04:39:37 -0700 (PDT)
From:   Teng Long <dyroneteng@gmail.com>
X-Google-Original-From: Teng Long <tenglong@alibaba-inc.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, avarab@gmail.com, jonathantanmy@google.com,
        bagasdotme@gmail.com, adlternative@gmail.com, stolee@gmail.com,
        Teng Long <dyroneteng@gmail.com>
Subject: [PATCH v6 10/12] packfile-uri: support for excluding tags
Date:   Tue, 19 Oct 2021 19:38:34 +0800
Message-Id: <16c41c40a26e72d64959a332fbf7dc1c9794e70c.1634634814.git.tenglong@alibaba-inc.com>
X-Mailer: git-send-email 2.31.1.453.g945ddc3a74.dirty
In-Reply-To: <cover.1634634814.git.tenglong@alibaba-inc.com>
References: <cover.1634634814.git.tenglong@alibaba-inc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Teng Long <dyroneteng@gmail.com>

This commit brings the tags exclusion feature of packfile-uri. The
excluding level of tag is supported with "ET_SELF", "ET_INCLUDE"
and "ET_REACHABLE".

Exclusion scope on different level:

1. When a tag is specified to be excluded with level "ET_SELF",
only the tag object itself will be excluded.

2. When it's specified to be excluded with level "ET_INCLUDE",
exclude the referenced commit, and all trees and blobs contained in its
top-level. If it's a annotated tag, the tag object will be excluded
too.

3. When it is specified with level "ET_REACHABLE", exclude the ancestors
of the referenced commit, as well as the objects need to be excluded
under the level "ET_INCLUDED".

Signed-off-by: Teng Long <dyroneteng@gmail.com>
---
 builtin/pack-objects.c |  6 +++++-
 list-objects.c         | 20 ++++++++++++++++----
 object.c               |  1 +
 object.h               |  1 +
 revision.c             | 13 ++++++++++++-
 revision.h             |  9 +++++++++
 6 files changed, 44 insertions(+), 6 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 6713e734fb..073c3815a1 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -1416,6 +1416,9 @@ static int want_object_in_pack(const struct object_id *oid,
 		if (referred_objs) {
 			struct commit *commit = referred_objs->commit;
 			struct object_list *trees = referred_objs->trees;
+			struct object_list *tags = referred_objs->tags;
+			if (want_exclude_object(tags))
+				return 0;
 			if (commit) {
 				commit_ex = oidmap_get(&configured_exclusions, &commit->object.oid);
 				if (match_packfile_uri_exclusions(commit_ex) && commit_ex->level > ET_SELF)
@@ -3344,7 +3347,8 @@ static void read_object_list_from_stdin(void)
 
 static void show_commit(struct commit *commit, struct show_info *info)
 {
-	add_object_entry(&commit->object.oid, OBJ_COMMIT, NULL, 0, NULL);
+	struct referred_objects *referred_objs = info->show_cache;
+	add_object_entry(&commit->object.oid, OBJ_COMMIT, NULL, 0, referred_objs);
 	commit->object.flags |= OBJECT_ADDED;
 
 	if (write_bitmap_index)
diff --git a/list-objects.c b/list-objects.c
index 40292e2cc8..2e241e8707 100644
--- a/list-objects.c
+++ b/list-objects.c
@@ -348,9 +348,10 @@ static void traverse_trees_and_blobs(struct traversal_context *ctx,
 	for (i = 0; i < ctx->revs->pending.nr; i++) {
 		struct object_array_entry *pending = ctx->revs->pending.objects + i;
 		struct object *obj = pending->item;
-		struct referred_objects *referred_objs = pending->referred_objects;
 		const char *name = pending->name;
 		const char *path = pending->path;
+		struct referred_objects *referred_objs = pending->referred_objects;
+		struct commit_wraps_entry *cw_entry = NULL;
 		if (obj->flags & (UNINTERESTING | SEEN))
 			continue;
 		if (obj->type == OBJ_TAG) {
@@ -358,6 +359,10 @@ static void traverse_trees_and_blobs(struct traversal_context *ctx,
 			ctx->show_object(obj, name, &show_info);
 			continue;
 		}
+		if (referred_objs->commit)
+			cw_entry = oidmap_get(ctx->revs->commit_wraps, &referred_objs->commit->object.oid);
+		if (cw_entry)
+			referred_objs->tags = cw_entry->wraps;
 		if (!path)
 			path = "";
 		if (obj->type == OBJ_TREE) {
@@ -378,12 +383,14 @@ static void do_traverse(struct traversal_context *ctx)
 {
 	struct commit *commit;
 	struct strbuf csp; /* callee's scratch pad */
-	struct show_info show_info;
+	struct commit_wraps_entry *entry;
+	struct oidmap *commit_wraps = ctx->revs->commit_wraps;
+	struct referred_objects referred_objs = { NULL, NULL, NULL };
+	struct show_info show_info = { ctx->show_data , NULL };
 	strbuf_init(&csp, PATH_MAX);
 
-
 	show_info.show_data = ctx->show_data;
-	show_info.show_cache = NULL;
+	show_info.show_cache = &referred_objs;
 
 	while ((commit = get_revision(ctx->revs)) != NULL) {
 		/*
@@ -401,6 +408,11 @@ static void do_traverse(struct traversal_context *ctx)
 			      oid_to_hex(&commit->object.oid));
 		}
 
+		if (commit_wraps) {
+			entry = oidmap_get(commit_wraps, &commit->object.oid);
+			referred_objs.tags = entry ? entry->wraps : NULL;
+		}
+
 		ctx->show_commit(commit, &show_info);
 
 		if (ctx->revs->tree_blobs_in_commit_order)
diff --git a/object.c b/object.c
index 895068cbc2..167cc87ec9 100644
--- a/object.c
+++ b/object.c
@@ -335,6 +335,7 @@ void add_object_array_with_path_and_referred_commit(struct object *obj, const ch
 	referred_objs = xmalloc(sizeof(struct referred_objects));
 	referred_objs->commit = referred_commit;
 	referred_objs->trees = NULL;
+	referred_objs->tags = NULL;
 
 	if (nr >= alloc) {
 		alloc = (alloc + 32) * 2;
diff --git a/object.h b/object.h
index 618d674249..42a2178531 100644
--- a/object.h
+++ b/object.h
@@ -66,6 +66,7 @@ struct object_array {
 struct referred_objects{
     struct commit *commit;
     struct object_list *trees;
+    struct object_list *tags;
 };
 #define OBJECT_ARRAY_INIT { 0, 0, NULL }
 
diff --git a/revision.c b/revision.c
index 89a8b311ea..d16f9bbbb9 100644
--- a/revision.c
+++ b/revision.c
@@ -416,14 +416,17 @@ static struct commit *handle_commit(struct rev_info *revs,
 	const char *path = entry->path;
 	unsigned int mode = entry->mode;
 	unsigned long flags = object->flags;
+	struct object_list *wraps = NULL;
 
 	/*
 	 * Tag object? Look what it points to..
 	 */
 	while (object->type == OBJ_TAG) {
 		struct tag *tag = (struct tag *) object;
-		if (revs->tag_objects && !(flags & UNINTERESTING))
+		if (revs->tag_objects && !(flags & UNINTERESTING)) {
 			add_pending_object(revs, object, tag->tag);
+			object_list_insert(object, &wraps);
+		}
 		object = parse_object(revs->repo, get_tagged_oid(tag));
 		if (!object) {
 			if (revs->ignore_missing_links || (flags & UNINTERESTING))
@@ -449,6 +452,14 @@ static struct commit *handle_commit(struct rev_info *revs,
 	 */
 	if (object->type == OBJ_COMMIT) {
 		struct commit *commit = (struct commit *)object;
+		struct oidmap *commit_wraps = malloc(sizeof(struct oidmap));
+		struct commit_wraps_entry *cw_entry = xmalloc(sizeof(struct commit_wraps_entry));
+
+		oidmap_init(commit_wraps, 0);
+		cw_entry->e.oid = object->oid;
+		cw_entry->wraps = wraps;
+		oidmap_put(commit_wraps, cw_entry);
+		revs->commit_wraps = commit_wraps;
 
 		if (repo_parse_commit(revs->repo, commit) < 0)
 			die("unable to parse commit %s", name);
diff --git a/revision.h b/revision.h
index b2e0c0b9b7..a633ea2174 100644
--- a/revision.h
+++ b/revision.h
@@ -8,6 +8,7 @@
 #include "pretty.h"
 #include "diff.h"
 #include "commit-slab-decl.h"
+#include "oidmap.h"
 
 /**
  * The revision walking API offers functions to build a list of revisions
@@ -64,6 +65,11 @@ struct bloom_key;
 struct bloom_filter_settings;
 define_shared_commit_slab(revision_sources, char *);
 
+struct commit_wraps_entry {
+    struct oidmap_entry e;
+    struct object_list *wraps;
+};
+
 struct rev_cmdline_info {
 	unsigned int nr;
 	unsigned int alloc;
@@ -321,6 +327,9 @@ struct rev_info {
 
 	/* misc. flags related to '--no-kept-objects' */
 	unsigned keep_pack_cache_flags;
+
+	/* The commit_wraps caches the referred wrapped objects(such as tags) of a commit */
+	struct oidmap *commit_wraps;
 };
 
 int ref_excluded(struct string_list *, const char *path);
-- 
2.31.1.453.g945ddc3a74.dirty

