Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 220931F404
	for <e@80x24.org>; Tue,  6 Feb 2018 00:13:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752167AbeBFANH (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Feb 2018 19:13:07 -0500
Received: from mail-pl0-f66.google.com ([209.85.160.66]:39958 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752028AbeBFANE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Feb 2018 19:13:04 -0500
Received: by mail-pl0-f66.google.com with SMTP id g18so111955plo.7
        for <git@vger.kernel.org>; Mon, 05 Feb 2018 16:13:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=YLj5XwPE+IJiJHGzXd+DjbQYU9DHDIBtB1sbDLG5k4w=;
        b=qzmmHWdONWccXnaxav1cO7YoPhA/4i0LnMSLzkdQkJnLI0L4/xede8ZZUwJcIiQsT/
         DN30fbk+HQ3LD1j0aesAcWQ4Svdkia4GHEbT7pKINNTBeXYO/3a1hVlCHn1LuEpAi+BF
         tCVFE2eRnRrgnK0Q0O6/3wgEPgF3jGcwJ8vB+2TqbJhFduhjlvtPr3rAOWe1JbOp07ty
         jXouF1VJz6TZeUbqeKyfxfgnv+Ueg1Vn1e0bb/1rHmqbA2Zpx97N+yeLQds/rob75xNx
         lCi8KfFQekFFt+rpkkM/UgOO/Jg0hMIQVQ6Z0TP1lEBmmsp7Wp+yzOPf8GY7exmqmZ6g
         ru8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=YLj5XwPE+IJiJHGzXd+DjbQYU9DHDIBtB1sbDLG5k4w=;
        b=C/9PqgG5PJNU203f+8gsdzn8ym7PU3o3lYhGGE63y/FbFdQh649/Gn8ykHWFRhjLXk
         mnyU76TDvwolevG5Oe+UdSsoe119No0fpVhnqVi6cx0l4dTznG77OhqV/hM+xwj8AEtB
         Nv6Y9I4KGKAbJx/Gkzga0zminJOMjdWttZcOYOuJSmSpcrJYU6WKyLVl5DJ3x1pOVT+2
         XpJrpOe4vRr2jWoXsCswH+sjlPQ6TuJWk7g4yf5q8Kda9ouOG/Q6blIPzoi984RhEXqf
         W8pV7Gt9mjG4YPZHl+rpTGX3wGCMrurMfebo3Sero49+Y+UacpCegheS3mp8FxgDQmht
         CsLg==
X-Gm-Message-State: APf1xPDu+m5UxorCXchzW8S0sKkIeakMoIXztWvmEn0uTWGwC0PFRRcS
        Y1XddCkWv1Be1bxeyB+EeCvtMUX+22Q=
X-Google-Smtp-Source: AH8x227b7sZervyRnwUPcbbNyWtn2FDVewK5m7mEJZQNY6RiNRW8A7r4ZyKchcqLKX6tfgjVru7BDQ==
X-Received: by 2002:a17:902:507:: with SMTP id 7-v6mr550828plf.0.1517875983105;
        Mon, 05 Feb 2018 16:13:03 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id u26sm19134628pfk.126.2018.02.05.16.13.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Feb 2018 16:13:02 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 088/194] tag: add repository argument to deref_tag
Date:   Mon,  5 Feb 2018 15:55:49 -0800
Message-Id: <20180205235735.216710-68-sbeller@google.com>
X-Mailer: git-send-email 2.15.1.433.g936d1b9894.dirty
In-Reply-To: <20180205235735.216710-1-sbeller@google.com>
References: <20180205235508.216277-1-sbeller@google.com>
 <20180205235735.216710-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a repository argument to allow the callers of deref_tag
to be more specific about which repository to act on. This is a small
mechanical change; it doesn't change the implementation to handle
repositories other than the_repository yet.

As with the previous commits, use a macro to catch callers passing a
repository other than the_repository at compile time.

Add the cocci patch that converted the callers.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---
 blame.c                                |  6 +++---
 builtin/diff.c                         |  2 +-
 builtin/fmt-merge-msg.c                |  3 ++-
 builtin/grep.c                         |  3 ++-
 builtin/name-rev.c                     |  3 ++-
 commit.c                               |  3 ++-
 contrib/coccinelle/object_parser.cocci |  9 +++++++++
 fetch-pack.c                           |  9 ++++++---
 http-backend.c                         |  2 +-
 http-push.c                            |  2 +-
 line-log.c                             |  2 +-
 merge-recursive.c                      |  3 ++-
 remote.c                               |  6 ++++--
 server-info.c                          |  2 +-
 sha1_name.c                            | 11 +++++++----
 shallow.c                              |  4 +++-
 tag.c                                  |  2 +-
 tag.h                                  |  3 ++-
 upload-pack.c                          |  2 +-
 19 files changed, 51 insertions(+), 26 deletions(-)

diff --git a/blame.c b/blame.c
index f95a53898d..02cd0ba498 100644
--- a/blame.c
+++ b/blame.c
@@ -1655,7 +1655,7 @@ static struct commit *find_single_final(struct rev_info *revs,
 		struct object *obj = revs->pending.objects[i].item;
 		if (obj->flags & UNINTERESTING)
 			continue;
-		obj = deref_tag(obj, NULL, 0);
+		obj = deref_tag(the_repository, obj, NULL, 0);
 		if (obj->type != OBJ_COMMIT)
 			die("Non commit %s?", revs->pending.objects[i].name);
 		if (found)
@@ -1686,7 +1686,7 @@ static struct commit *dwim_reverse_initial(struct rev_info *revs,
 
 	/* Is that sole rev a committish? */
 	obj = revs->pending.objects[0].item;
-	obj = deref_tag(obj, NULL, 0);
+	obj = deref_tag(the_repository, obj, NULL, 0);
 	if (obj->type != OBJ_COMMIT)
 		return NULL;
 
@@ -1721,7 +1721,7 @@ static struct commit *find_single_initial(struct rev_info *revs,
 		struct object *obj = revs->pending.objects[i].item;
 		if (!(obj->flags & UNINTERESTING))
 			continue;
-		obj = deref_tag(obj, NULL, 0);
+		obj = deref_tag(the_repository, obj, NULL, 0);
 		if (obj->type != OBJ_COMMIT)
 			die("Non commit %s?", revs->pending.objects[i].name);
 		if (found)
diff --git a/builtin/diff.c b/builtin/diff.c
index 0b7d0d612d..1dd7dd4a26 100644
--- a/builtin/diff.c
+++ b/builtin/diff.c
@@ -395,7 +395,7 @@ int cmd_diff(int argc, const char **argv, const char *prefix)
 		int flags = (obj->flags & UNINTERESTING);
 		if (!obj->parsed)
 			obj = parse_object(the_repository, &obj->oid);
-		obj = deref_tag(obj, NULL, 0);
+		obj = deref_tag(the_repository, obj, NULL, 0);
 		if (!obj)
 			die(_("invalid object '%s' given."), name);
 		if (obj->type == OBJ_COMMIT)
diff --git a/builtin/fmt-merge-msg.c b/builtin/fmt-merge-msg.c
index dd74251690..49fd7ea1d2 100644
--- a/builtin/fmt-merge-msg.c
+++ b/builtin/fmt-merge-msg.c
@@ -344,7 +344,8 @@ static void shortlog(const char *name,
 	const struct object_id *oid = &origin_data->oid;
 	int limit = opts->shortlog_len;
 
-	branch = deref_tag(parse_object(the_repository, oid), oid_to_hex(oid),
+	branch = deref_tag(the_repository, parse_object(the_repository, oid),
+			   oid_to_hex(oid),
 			   GIT_SHA1_HEXSZ);
 	if (!branch || branch->type != OBJ_COMMIT)
 		return;
diff --git a/builtin/grep.c b/builtin/grep.c
index 1c71dff341..2c43307f02 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -641,7 +641,8 @@ static int grep_objects(struct grep_opt *opt, const struct pathspec *pathspec,
 
 	for (i = 0; i < nr; i++) {
 		struct object *real_obj;
-		real_obj = deref_tag(list->objects[i].item, NULL, 0);
+		real_obj = deref_tag(the_repository, list->objects[i].item,
+				     NULL, 0);
 
 		/* load the gitmodules file for this rev */
 		if (recurse_submodules) {
diff --git a/builtin/name-rev.c b/builtin/name-rev.c
index 45ec5515cc..2cbb702c2c 100644
--- a/builtin/name-rev.c
+++ b/builtin/name-rev.c
@@ -438,7 +438,8 @@ int cmd_name_rev(int argc, const char **argv, const char *prefix)
 		commit = NULL;
 		object = parse_object(the_repository, &oid);
 		if (object) {
-			struct object *peeled = deref_tag(object, *argv, 0);
+			struct object *peeled = deref_tag(the_repository,
+							  object, *argv, 0);
 			if (peeled && peeled->type == OBJ_COMMIT)
 				commit = (struct commit *)peeled;
 		}
diff --git a/commit.c b/commit.c
index 253a906124..1b0e37f6f0 100644
--- a/commit.c
+++ b/commit.c
@@ -23,7 +23,8 @@ const char *commit_type = "commit";
 struct commit *lookup_commit_reference_gently(const struct object_id *oid,
 					      int quiet)
 {
-	struct object *obj = deref_tag(parse_object(the_repository, oid),
+	struct object *obj = deref_tag(the_repository,
+				       parse_object(the_repository, oid),
 				       NULL, 0);
 
 	if (!obj)
diff --git a/contrib/coccinelle/object_parser.cocci b/contrib/coccinelle/object_parser.cocci
index 0e2ebdfccb..7ddd9f11ce 100644
--- a/contrib/coccinelle/object_parser.cocci
+++ b/contrib/coccinelle/object_parser.cocci
@@ -29,6 +29,15 @@ expression G;
 +the_repository,
  E, F, G)
 
+@@
+expression E;
+expression F;
+expression G;
+@@
+ deref_tag(
++the_repository,
+ E, F, G)
+
 @@
 expression E;
 @@
diff --git a/fetch-pack.c b/fetch-pack.c
index 02ac850967..ee1e65688a 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -124,7 +124,8 @@ static void rev_list_push(struct commit *commit, int mark)
 
 static int rev_list_insert_ref(const char *refname, const struct object_id *oid)
 {
-	struct object *o = deref_tag(parse_object(the_repository, oid),
+	struct object *o = deref_tag(the_repository,
+				     parse_object(the_repository, oid),
 				     refname, 0);
 
 	if (o && o->type == OBJ_COMMIT)
@@ -142,7 +143,8 @@ static int rev_list_insert_ref_oid(const char *refname, const struct object_id *
 static int clear_marks(const char *refname, const struct object_id *oid,
 		       int flag, void *cb_data)
 {
-	struct object *o = deref_tag(parse_object(the_repository, oid),
+	struct object *o = deref_tag(the_repository,
+				     parse_object(the_repository, oid),
 				     refname, 0);
 
 	if (o && o->type == OBJ_COMMIT)
@@ -751,7 +753,8 @@ static int everything_local(struct fetch_pack_args *args,
 	 * Don't mark them common yet; the server has to be told so first.
 	 */
 	for (ref = *refs; ref; ref = ref->next) {
-		struct object *o = deref_tag(lookup_object(the_repository, ref->old_oid.hash),
+		struct object *o = deref_tag(the_repository,
+					     lookup_object(the_repository, ref->old_oid.hash),
 					     NULL, 0);
 
 		if (!o || o->type != OBJ_COMMIT || !(o->flags & COMPLETE))
diff --git a/http-backend.c b/http-backend.c
index b76c8c4f3d..609faf93d4 100644
--- a/http-backend.c
+++ b/http-backend.c
@@ -441,7 +441,7 @@ static int show_text_ref(const char *name, const struct object_id *oid,
 
 	strbuf_addf(buf, "%s\t%s\n", oid_to_hex(oid), name_nons);
 	if (o->type == OBJ_TAG) {
-		o = deref_tag(o, name, 0);
+		o = deref_tag(the_repository, o, name, 0);
 		if (!o)
 			return 0;
 		strbuf_addf(buf, "%s\t%s^{}\n", oid_to_hex(&o->oid),
diff --git a/http-push.c b/http-push.c
index 83117770a3..de5e70ea7b 100644
--- a/http-push.c
+++ b/http-push.c
@@ -1473,7 +1473,7 @@ static void add_remote_info_ref(struct remote_ls_ctx *ls)
 		    oid_to_hex(&ref->old_oid), ls->dentry_name);
 
 	if (o->type == OBJ_TAG) {
-		o = deref_tag(o, ls->dentry_name, 0);
+		o = deref_tag(the_repository, o, ls->dentry_name, 0);
 		if (o)
 			strbuf_addf(buf, "%s\t%s^{}\n",
 				    oid_to_hex(&o->oid), ls->dentry_name);
diff --git a/line-log.c b/line-log.c
index 545ad0f28b..653c7279f3 100644
--- a/line-log.c
+++ b/line-log.c
@@ -479,7 +479,7 @@ static struct commit *check_single_commit(struct rev_info *revs)
 		struct object *obj = revs->pending.objects[i].item;
 		if (obj->flags & UNINTERESTING)
 			continue;
-		obj = deref_tag(obj, NULL, 0);
+		obj = deref_tag(the_repository, obj, NULL, 0);
 		if (obj->type != OBJ_COMMIT)
 			die("Non commit %s?", revs->pending.objects[i].name);
 		if (commit)
diff --git a/merge-recursive.c b/merge-recursive.c
index 181ab36c36..8b6984cdd7 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -2152,7 +2152,8 @@ static struct commit *get_ref(const struct object_id *oid, const char *name)
 {
 	struct object *object;
 
-	object = deref_tag(parse_object(the_repository, oid), name,
+	object = deref_tag(the_repository, parse_object(the_repository, oid),
+			   name,
 			   strlen(name));
 	if (!object)
 		return NULL;
diff --git a/remote.c b/remote.c
index 2abc6baf84..8d84e26dd4 100644
--- a/remote.c
+++ b/remote.c
@@ -1980,12 +1980,14 @@ int ref_newer(const struct object_id *new_oid, const struct object_id *old_oid)
 	 * Both new and old must be commit-ish and new is descendant of
 	 * old.  Otherwise we require --force.
 	 */
-	o = deref_tag(parse_object(the_repository, old_oid), NULL, 0);
+	o = deref_tag(the_repository, parse_object(the_repository, old_oid),
+		      NULL, 0);
 	if (!o || o->type != OBJ_COMMIT)
 		return 0;
 	old = (struct commit *) o;
 
-	o = deref_tag(parse_object(the_repository, new_oid), NULL, 0);
+	o = deref_tag(the_repository, parse_object(the_repository, new_oid),
+		      NULL, 0);
 	if (!o || o->type != OBJ_COMMIT)
 		return 0;
 	new = (struct commit *) o;
diff --git a/server-info.c b/server-info.c
index fd7ed2a383..ee4491b73a 100644
--- a/server-info.c
+++ b/server-info.c
@@ -64,7 +64,7 @@ static int add_info_ref(const char *path, const struct object_id *oid,
 		return -1;
 
 	if (o->type == OBJ_TAG) {
-		o = deref_tag(o, path, 0);
+		o = deref_tag(the_repository, o, path, 0);
 		if (o)
 			if (fprintf(fp, "%s	%s^{}\n",
 				oid_to_hex(&o->oid), path) < 0)
diff --git a/sha1_name.c b/sha1_name.c
index 717b31359a..117c080fd4 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -259,7 +259,8 @@ static int disambiguate_committish_only(const struct object_id *oid, void *cb_da
 		return 0;
 
 	/* We need to do this the hard way... */
-	obj = deref_tag(parse_object(the_repository, oid), NULL, 0);
+	obj = deref_tag(the_repository, parse_object(the_repository, oid),
+			NULL, 0);
 	if (obj && obj->type == OBJ_COMMIT)
 		return 1;
 	return 0;
@@ -283,7 +284,8 @@ static int disambiguate_treeish_only(const struct object_id *oid, void *cb_data_
 		return 0;
 
 	/* We need to do this the hard way... */
-	obj = deref_tag(parse_object(the_repository, oid), NULL, 0);
+	obj = deref_tag(the_repository, parse_object(the_repository, oid),
+			NULL, 0);
 	if (obj && (obj->type == OBJ_TREE || obj->type == OBJ_COMMIT))
 		return 1;
 	return 0;
@@ -971,7 +973,7 @@ static int peel_onion(const char *name, int len, struct object_id *oid,
 	if (!o)
 		return -1;
 	if (!expected_type) {
-		o = deref_tag(o, name, sp - name - 2);
+		o = deref_tag(the_repository, o, name, sp - name - 2);
 		if (!o || (!o->parsed && !parse_object(the_repository, &o->oid)))
 			return -1;
 		oidcpy(oid, &o->oid);
@@ -1103,7 +1105,8 @@ static int handle_one_ref(const char *path, const struct object_id *oid,
 	if (!object)
 		return 0;
 	if (object->type == OBJ_TAG) {
-		object = deref_tag(object, path, strlen(path));
+		object = deref_tag(the_repository, object, path,
+				   strlen(path));
 		if (!object)
 			return 0;
 	}
diff --git a/shallow.c b/shallow.c
index c2f81a5a5a..aa6d04992c 100644
--- a/shallow.c
+++ b/shallow.c
@@ -89,7 +89,9 @@ struct commit_list *get_shallow_commits(struct object_array *heads, int depth,
 		if (!commit) {
 			if (i < heads->nr) {
 				commit = (struct commit *)
-					deref_tag(heads->objects[i++].item, NULL, 0);
+					deref_tag(the_repository,
+						  heads->objects[i++].item,
+						  NULL, 0);
 				if (!commit || commit->object.type != OBJ_COMMIT) {
 					commit = NULL;
 					continue;
diff --git a/tag.c b/tag.c
index 7ff9943847..d8174e0405 100644
--- a/tag.c
+++ b/tag.c
@@ -64,7 +64,7 @@ int gpg_verify_tag(const struct object_id *oid, const char *name_to_report,
 	return ret;
 }
 
-struct object *deref_tag(struct object *o, const char *warn, int warnlen)
+struct object *deref_tag_the_repository(struct object *o, const char *warn, int warnlen)
 {
 	while (o && o->type == OBJ_TAG)
 		if (((struct tag *)o)->tagged)
diff --git a/tag.h b/tag.h
index 31498e788a..4f45695e1e 100644
--- a/tag.h
+++ b/tag.h
@@ -16,7 +16,8 @@ extern struct tag *lookup_tag_the_repository(const struct object_id *oid);
 #define parse_tag_buffer(r, i, d, s) parse_tag_buffer_##r(i, d, s)
 extern int parse_tag_buffer_the_repository(struct tag *item, const void *data, unsigned long size);
 extern int parse_tag(struct tag *item);
-extern struct object *deref_tag(struct object *, const char *, int);
+#define deref_tag(r, o, w, l) deref_tag_##r(o, w, l)
+extern struct object *deref_tag_the_repository(struct object *, const char *, int);
 extern struct object *deref_tag_noverify(struct object *);
 extern int gpg_verify_tag(const struct object_id *oid,
 		const char *name_to_report, unsigned flags);
diff --git a/upload-pack.c b/upload-pack.c
index 8716e28d4f..469a843669 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -368,7 +368,7 @@ static int ok_to_give_up(void)
 
 		if (want->flags & COMMON_KNOWN)
 			continue;
-		want = deref_tag(want, "a want line", 0);
+		want = deref_tag(the_repository, want, "a want line", 0);
 		if (!want || want->type != OBJ_COMMIT) {
 			/* no way to tell if this is reachable by
 			 * looking at the ancestry chain alone, so
-- 
2.15.1.433.g936d1b9894.dirty

