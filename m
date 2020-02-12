Return-Path: <SRS0=D6Hn=4A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A030C352A4
	for <git@archiver.kernel.org>; Wed, 12 Feb 2020 19:19:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F21BF21739
	for <git@archiver.kernel.org>; Wed, 12 Feb 2020 19:19:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qU0cn4Mf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729029AbgBLTTR (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Feb 2020 14:19:17 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:36762 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729010AbgBLTTQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Feb 2020 14:19:16 -0500
Received: by mail-wm1-f67.google.com with SMTP id p17so3881599wma.1
        for <git@vger.kernel.org>; Wed, 12 Feb 2020 11:19:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=IhhUEVQhypOC1SjJS26KH+6S9VoyyVb0vmmtJ2aGBpM=;
        b=qU0cn4MfmswWOLdmbHFWAeDxBvI7q5eJmr3FNZ3SCz5WhPtzQi2K53LqAhVTqCDROX
         sXcej/rKULci3h0xQslzb5ivuRfUHAXu07Zyu04R1p/0A8wAl4hilbUvRme6RrYEgpr8
         0Hfq0VVyL4izbw6E5GhVo9mhqxXpRv4/Chpf847YBjDlCrFrDDDTVo0yxWSP7iSETDN1
         scVwL22Ei2pp4otZW1pBMNC524AjmvhRzJE3w3zXuD9yqs16+MYvsjZjmMo2RH9lBfZv
         NsA1XCmSfSJVuX/E+HzyiQZXuEtf6NzbBu/GqsyDSgma2QGQuYydy8p7nzowH1ouHAgn
         Mvzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=IhhUEVQhypOC1SjJS26KH+6S9VoyyVb0vmmtJ2aGBpM=;
        b=SIfQ+CGQTAb0yK+IvsrXB8n1+t8dHO2ZjOxjdlNYwndFts+AloUzPd+jzE1BEBFwjv
         //2BajdQJ5VWzaQXpmwvY61yTjb/AOysZsbF9Tw4vYDsUpD6dYBD4ekDom5SWCgRNMMM
         VmpkKS7660nzVz711ihfYPkrlrdfjLav0w8PwGXGOf6yxDSi4dlOnhVcQJfL9q/iC8eF
         rPYQBdfZod6Aqeesf97FUY7/6VBRBkhRDUD6Ade5hRSjqokpcdDeO5/8E85f7qWIdgSg
         fHIsInl8z0526IV/KQahfOkdfVUCfZgTulXDMSCJzjFzoNbsX5SFccL3j0GRM/zz/Tgn
         QIKQ==
X-Gm-Message-State: APjAAAUOhSzfin2yoAqOQCTUXn4tLgCUTnHBeNi4SzJfAMwrTYdzaaRj
        NByW9cbosdnrnhCrcjEKyOBelWVh
X-Google-Smtp-Source: APXvYqxDKHTUZ/7WPiDZ+lRxufRWMf+mMnztEbL+WDP1Ch5E36pMMq70hhXCpNUEXe3zXKUYK4YE3g==
X-Received: by 2002:a1c:688a:: with SMTP id d132mr580008wmc.189.1581535154542;
        Wed, 12 Feb 2020 11:19:14 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w8sm2027742wmm.0.2020.02.12.11.19.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2020 11:19:14 -0800 (PST)
Message-Id: <ef8ec98181ff03d756be80f1d3796eda98c7f475.1581535151.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.545.git.1581535151.gitgitgadget@gmail.com>
References: <pull.545.git.1581535151.gitgitgadget@gmail.com>
From:   "Parth Gala via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 12 Feb 2020 19:19:09 +0000
Subject: [PATCH 3/5] object.c: parse_object_or_die() accept 'r' as parameter
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Parth Gala <parthpgala@gmail.com>,
        Parth Gala <parthpgala@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Parth Gala <parthpgala@gmail.com>

'parse_object_or_die()' and its callers are modified to enable
passing 'r' as an argument to 'parse_object_or_die()'.

Signed-off-by: Parth Gala <parthpgala@gmail.com>
---
 builtin/grep.c  | 6 ++++--
 builtin/prune.c | 3 ++-
 bundle.c        | 8 +++++---
 object.c        | 4 ++--
 object.h        | 2 +-
 pack-bitmap.c   | 5 +++--
 reachable.c     | 6 ++++--
 upload-pack.c   | 4 +++-
 8 files changed, 24 insertions(+), 14 deletions(-)

diff --git a/builtin/grep.c b/builtin/grep.c
index 50ce8d9461..c4156b0560 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -406,6 +406,7 @@ static int grep_submodule(struct grep_opt *opt,
 			  const char *filename, const char *path, int cached)
 {
 	struct repository subrepo;
+	struct repository *r = the_repository;
 	struct repository *superproject = opt->repo;
 	const struct submodule *sub = submodule_from_path(superproject,
 							  &null_oid, path);
@@ -455,7 +456,7 @@ static int grep_submodule(struct grep_opt *opt,
 		unsigned long size;
 		struct strbuf base = STRBUF_INIT;
 
-		object = parse_object_or_die(oid, oid_to_hex(oid));
+		object = parse_object_or_die(r, oid, oid_to_hex(oid));
 
 		grep_read_lock();
 		data = read_object_with_reference(&subrepo,
@@ -802,6 +803,7 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 	const char *show_in_pager = NULL, *default_pager = "dummy";
 	struct grep_opt opt;
 	struct object_array list = OBJECT_ARRAY_INIT;
+	struct repository *r = the_repository;
 	struct pathspec pathspec;
 	struct string_list path_list = STRING_LIST_INIT_NODUP;
 	int i;
@@ -1037,7 +1039,7 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 			break;
 		}
 
-		object = parse_object_or_die(&oid, arg);
+		object = parse_object_or_die(r, &oid, arg);
 		if (!seen_dashdash)
 			verify_non_filename(prefix, arg);
 		add_object_array_with_path(object, arg, &list, oc.mode, oc.path);
diff --git a/builtin/prune.c b/builtin/prune.c
index 2b76872ad2..6d478717ef 100644
--- a/builtin/prune.c
+++ b/builtin/prune.c
@@ -125,6 +125,7 @@ static void remove_temporary_files(const char *path)
 int cmd_prune(int argc, const char **argv, const char *prefix)
 {
 	struct rev_info revs;
+	struct repository *r = the_repository;
 	int exclude_promisor_objects = 0;
 	const struct option options[] = {
 		OPT__DRY_RUN(&show_only, N_("do not remove, show only")),
@@ -154,7 +155,7 @@ int cmd_prune(int argc, const char **argv, const char *prefix)
 		const char *name = *argv++;
 
 		if (!get_oid(name, &oid)) {
-			struct object *object = parse_object_or_die(&oid,
+			struct object *object = parse_object_or_die(r, &oid,
 								    name);
 			add_pending_object(&revs, object, "");
 		}
diff --git a/bundle.c b/bundle.c
index 99439e07a1..26231f2a38 100644
--- a/bundle.c
+++ b/bundle.c
@@ -298,6 +298,7 @@ static int compute_and_write_prerequisites(int bundle_fd,
 {
 	struct child_process rls = CHILD_PROCESS_INIT;
 	struct strbuf buf = STRBUF_INIT;
+	struct repository *r = the_repository;
 	FILE *rls_fout;
 	int i;
 
@@ -316,13 +317,13 @@ static int compute_and_write_prerequisites(int bundle_fd,
 		if (buf.len > 0 && buf.buf[0] == '-') {
 			write_or_die(bundle_fd, buf.buf, buf.len);
 			if (!get_oid_hex(buf.buf + 1, &oid)) {
-				struct object *object = parse_object_or_die(&oid,
+				struct object *object = parse_object_or_die(r, &oid,
 									    buf.buf);
 				object->flags |= UNINTERESTING;
 				add_pending_object(revs, object, buf.buf);
 			}
 		} else if (!get_oid_hex(buf.buf, &oid)) {
-			struct object *object = parse_object_or_die(&oid,
+			struct object *object = parse_object_or_die(r, &oid,
 								    buf.buf);
 			object->flags |= SHOWN;
 		}
@@ -347,6 +348,7 @@ static int write_bundle_refs(int bundle_fd, struct rev_info *revs)
 {
 	int i;
 	int ref_count = 0;
+	struct repository *r = the_repository;
 
 	for (i = 0; i < revs->pending.nr; i++) {
 		struct object_array_entry *e = revs->pending.objects + i;
@@ -407,7 +409,7 @@ static int write_bundle_refs(int bundle_fd, struct rev_info *revs)
 				 * end up triggering "empty bundle"
 				 * error.
 				 */
-				obj = parse_object_or_die(&oid, e->name);
+				obj = parse_object_or_die(r, &oid, e->name);
 				obj->flags |= SHOWN;
 				add_pending_object(revs, obj, e->name);
 			}
diff --git a/object.c b/object.c
index 90338a509c..0a7a278c88 100644
--- a/object.c
+++ b/object.c
@@ -236,10 +236,10 @@ struct object *parse_object_buffer(struct repository *r, const struct object_id
 	return obj;
 }
 
-struct object *parse_object_or_die(const struct object_id *oid,
+struct object *parse_object_or_die(struct repository *r, const struct object_id *oid,
 				   const char *name)
 {
-	struct object *o = parse_object(the_repository, oid);
+	struct object *o = parse_object(r, oid);
 	if (o)
 		return o;
 
diff --git a/object.h b/object.h
index 375236cec3..92af2ead8f 100644
--- a/object.h
+++ b/object.h
@@ -135,7 +135,7 @@ struct object *parse_object(struct repository *r, const struct object_id *oid);
  * "name" parameter is not NULL, it is included in the error message
  * (otherwise, the hex object ID is given).
  */
-struct object *parse_object_or_die(const struct object_id *oid, const char *name);
+struct object *parse_object_or_die(struct repository *, const struct object_id *oid, const char *name);
 
 /* Given the result of read_sha1_file(), returns the object after
  * parsing it.  eaten_p indicates if the object has a borrowed copy
diff --git a/pack-bitmap.c b/pack-bitmap.c
index e07c798879..b7f9aebc7b 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -682,6 +682,7 @@ static int in_bitmapped_pack(struct bitmap_index *bitmap_git,
 struct bitmap_index *prepare_bitmap_walk(struct rev_info *revs)
 {
 	unsigned int i;
+	struct repository *r = the_repository;
 
 	struct object_list *wants = NULL;
 	struct object_list *haves = NULL;
@@ -699,7 +700,7 @@ struct bitmap_index *prepare_bitmap_walk(struct rev_info *revs)
 		struct object *object = revs->pending.objects[i].item;
 
 		if (object->type == OBJ_NONE)
-			parse_object_or_die(&object->oid, NULL);
+			parse_object_or_die(r, &object->oid, NULL);
 
 		while (object->type == OBJ_TAG) {
 			struct tag *tag = (struct tag *) object;
@@ -709,7 +710,7 @@ struct bitmap_index *prepare_bitmap_walk(struct rev_info *revs)
 			else
 				object_list_insert(object, &wants);
 
-			object = parse_object_or_die(get_tagged_oid(tag), NULL);
+			object = parse_object_or_die(r, get_tagged_oid(tag), NULL);
 		}
 
 		if (object->flags & UNINTERESTING)
diff --git a/reachable.c b/reachable.c
index 8f50235b28..c661a1c892 100644
--- a/reachable.c
+++ b/reachable.c
@@ -31,13 +31,14 @@ static int add_one_ref(const char *path, const struct object_id *oid,
 {
 	struct rev_info *revs = (struct rev_info *)cb_data;
 	struct object *object;
+	struct repository *r = the_repository;
 
 	if ((flag & REF_ISSYMREF) && (flag & REF_ISBROKEN)) {
 		warning("symbolic ref is dangling: %s", path);
 		return 0;
 	}
 
-	object = parse_object_or_die(oid, path);
+	object = parse_object_or_die(r, oid, path);
 	add_pending_object(revs, object, "");
 
 	return 0;
@@ -68,6 +69,7 @@ static void add_recent_object(const struct object_id *oid,
 {
 	struct object *obj;
 	enum object_type type;
+	struct repository *r = the_repository;
 
 	if (mtime <= data->timestamp)
 		return;
@@ -86,7 +88,7 @@ static void add_recent_object(const struct object_id *oid,
 	switch (type) {
 	case OBJ_TAG:
 	case OBJ_COMMIT:
-		obj = parse_object_or_die(oid, NULL);
+		obj = parse_object_or_die(r, oid, NULL);
 		break;
 	case OBJ_TREE:
 		obj = (struct object *)lookup_tree(the_repository, oid);
diff --git a/upload-pack.c b/upload-pack.c
index 6d196e275b..daea9059f0 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -1210,6 +1210,8 @@ static int parse_want_ref(struct packet_writer *writer, const char *line,
 			  struct object_array *want_obj)
 {
 	const char *arg;
+	struct repository *r = the_repository;
+
 	if (skip_prefix(line, "want-ref ", &arg)) {
 		struct object_id oid;
 		struct string_list_item *item;
@@ -1223,7 +1225,7 @@ static int parse_want_ref(struct packet_writer *writer, const char *line,
 		item = string_list_append(wanted_refs, arg);
 		item->util = oiddup(&oid);
 
-		o = parse_object_or_die(&oid, arg);
+		o = parse_object_or_die(r, &oid, arg);
 		if (!(o->flags & WANTED)) {
 			o->flags |= WANTED;
 			add_object_array(o, NULL, want_obj);
-- 
gitgitgadget

