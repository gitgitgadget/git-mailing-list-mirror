Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1E71C433B4
	for <git@archiver.kernel.org>; Mon,  3 May 2021 11:21:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B85361026
	for <git@archiver.kernel.org>; Mon,  3 May 2021 11:21:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232888AbhECLW3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 May 2021 07:22:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229811AbhECLW3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 May 2021 07:22:29 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEFB4C06174A
        for <git@vger.kernel.org>; Mon,  3 May 2021 04:21:35 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id n25so5833854edr.5
        for <git@vger.kernel.org>; Mon, 03 May 2021 04:21:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=jF51OXD8FQShFdCX2lDkePXYvyIqreadlUjnTK+Y1qo=;
        b=T+QpEeWj6QYS9ob0FZhJV1b+skvGDPsT7W0rajNQJ4ZwrOlLVXyfXIiqCX2IpQHEEH
         P5bBNZMWTsir/uoMwfveLyNqWe1usKvYk1R2eKrXhbNGzSTgDJpLyOzXdAiMEpGy4cvm
         rFMuLDVyGC5UeqHAez69DvmK2ok75KAu+0u0+6eVn5XBZC2CxfZpl9Zflj7LbKXtX22i
         UXMOCfo3EBA4yeg/LeVS7BP/QAWFYF6cicn68E2QV4HKFPXAUywfPRbkzodE9GR6pX4O
         hNz8NkL0R3ixmlp1VfAU8S90EbMJlsOo+ErPirrbZo32OT9e1vfQ7o/la9hgoFnL4qMl
         mcew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=jF51OXD8FQShFdCX2lDkePXYvyIqreadlUjnTK+Y1qo=;
        b=ci8VrAJRb3TtNL+EBdNRLAMo+zgWFQ9/RVr5pogPI/sdC46ACl8oxAXwEjbPyNpVaw
         tCBZvR5VADK4H3mxtHPaZ5YKe9T6BWhnQpEkz4uCwK3Yq3rUe1EXI11QFnwu7vG+g+dW
         LwG3L0S/UO+AmJliHjh9m3xf0j41eQREbtihoyK65th+C2YktAgcPA7p1FSvSZqCXXZC
         xcYZiKXYtaRjnNImahAAgIyRDeEpk9/2rgk/tlql2T5mBr/4zrGnouDg+q3pMWzkN9/a
         K9cNNGBFc27RdeTwHSvtfjrw1qew1zO9tUNaduEEivFRpObeNPDueCbiJuPB/M8jSNvP
         VYEg==
X-Gm-Message-State: AOAM532tP3NAcKYIarKWPCFppIZXTQHDK7swVn//5LZ6FsalPfR5AtFT
        DOVRufGc//luz0kcUIMGBLM=
X-Google-Smtp-Source: ABdhPJxSMpIv+Jf4jlfaqulEYGw2o7gdf48fhApHD81BdhXFGwTpMmrNZcCy45nw/Lj8KDEkbl3i9Q==
X-Received: by 2002:a05:6402:c8:: with SMTP id i8mr19779039edu.57.1620040894340;
        Mon, 03 May 2021 04:21:34 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id mp36sm10628969ejc.48.2021.05.03.04.21.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 May 2021 04:21:33 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/9] fsck_tree(): fix shadowed variable
Date:   Mon, 03 May 2021 13:15:03 +0200
References: <YI12hK4X/gfl3u29@coredump.intra.peff.net>
 <YI12stO48egyiHjv@coredump.intra.peff.net>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.5.12
In-reply-to: <YI12stO48egyiHjv@coredump.intra.peff.net>
Message-ID: <87y2cwvz9e.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sat, May 01 2021, Jeff King wrote:

> Commit b2f2039c2b (fsck: accept an oid instead of a "struct tree" for
> fsck_tree(), 2019-10-18) introduced a new "oid" parameter to
> fsck_tree(), and we pass it to the report() function when we find
> problems. However, that is shadowed within the tree-walking loop by the
> existing "oid" variable which we use to store the oid of each tree
> entry. As a result, we may report the wrong oid for some problems we
> detect within the loop (the entry oid, instead of the tree oid).
>
> Our tests didn't catch this because they checked only that we found the
> expected fsck problem, not that it was attached to the correct object.
>
> Let's rename both variables in the function to avoid confusion. This
> makes the diff a little noisy (e.g., all of the report() calls outside
> the loop were already correct but need to be touched), but makes sure we
> catch all cases and will avoid similar confusion in the future.
>
> And we can update the test to be a bit more specific and catch this
> problem.

Have you considered just passing down the "obj" instead of the "oid"?
It's a bit of a bigger change, but seems to be worth it in this case as
the below diff (on top of master) shows. We spend quite a bit of effort
peeling an "obj" just to pass oid/type further down the stack.

If you're interested in picking that up consider it to have by SOB, but
I don't think me submitting it while you have this in-flight is worth
the conflict.

diff --git a/builtin/fsck.c b/builtin/fsck.c
index 87a99b0108e..5ce8d4792d6 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -51,18 +51,18 @@ static int name_objects;
 #define ERROR_COMMIT_GRAPH 020
 #define ERROR_MULTI_PACK_INDEX 040
 
-static const char *describe_object(const struct object_id *oid)
+static const char *describe_object(const struct object *obj)
 {
-	return fsck_describe_object(&fsck_walk_options, oid);
+	return fsck_describe_object(&fsck_walk_options, obj);
 }
 
-static const char *printable_type(const struct object_id *oid,
-				  enum object_type type)
+static const char *printable_type(const struct object *obj)
 {
 	const char *ret;
+	enum object_type type = obj->type;
 
 	if (type == OBJ_NONE)
-		type = oid_object_info(the_repository, oid, NULL);
+		type = oid_object_info(the_repository, &obj->oid, NULL);
 
 	ret = type_name(type);
 	if (!ret)
@@ -76,14 +76,13 @@ static int objerror(struct object *obj, const char *err)
 	errors_found |= ERROR_OBJECT;
 	/* TRANSLATORS: e.g. error in tree 01bfda: <more explanation> */
 	fprintf_ln(stderr, _("error in %s %s: %s"),
-		   printable_type(&obj->oid, obj->type),
-		   describe_object(&obj->oid), err);
+		   printable_type(obj),
+		   describe_object(obj), err);
 	return -1;
 }
 
 static int fsck_error_func(struct fsck_options *o,
-			   const struct object_id *oid,
-			   enum object_type object_type,
+			   const struct object *obj,
 			   enum fsck_msg_type msg_type,
 			   enum fsck_msg_id msg_id,
 			   const char *message)
@@ -92,14 +91,14 @@ static int fsck_error_func(struct fsck_options *o,
 	case FSCK_WARN:
 		/* TRANSLATORS: e.g. warning in tree 01bfda: <more explanation> */
 		fprintf_ln(stderr, _("warning in %s %s: %s"),
-			   printable_type(oid, object_type),
-			   describe_object(oid), message);
+			   printable_type(obj),
+			   describe_object(obj), message);
 		return 0;
 	case FSCK_ERROR:
 		/* TRANSLATORS: e.g. error in tree 01bfda: <more explanation> */
 		fprintf_ln(stderr, _("error in %s %s: %s"),
-			   printable_type(oid, object_type),
-			   describe_object(oid), message);
+			   printable_type(obj),
+			   describe_object(obj), message);
 		return 1;
 	default:
 		BUG("%d (FSCK_IGNORE?) should never trigger this callback",
@@ -121,8 +120,8 @@ static int mark_object(struct object *obj, int type, void *data, struct fsck_opt
 	if (!obj) {
 		/* ... these references to parent->fld are safe here */
 		printf_ln(_("broken link from %7s %s"),
-			  printable_type(&parent->oid, parent->type),
-			  describe_object(&parent->oid));
+			  printable_type(parent),
+			  describe_object(parent));
 		printf_ln(_("broken link from %7s %s"),
 			  (type == OBJ_ANY ? _("unknown") : type_name(type)),
 			  _("unknown"));
@@ -150,10 +149,10 @@ static int mark_object(struct object *obj, int type, void *data, struct fsck_opt
 		if (parent && !has_object(the_repository, &obj->oid, 1)) {
 			printf_ln(_("broken link from %7s %s\n"
 				    "              to %7s %s"),
-				  printable_type(&parent->oid, parent->type),
-				  describe_object(&parent->oid),
-				  printable_type(&obj->oid, obj->type),
-				  describe_object(&obj->oid));
+				  printable_type(parent),
+				  describe_object(parent),
+				  printable_type(obj),
+				  describe_object(obj));
 			errors_found |= ERROR_REACHABLE;
 		}
 		return 1;
@@ -261,8 +260,8 @@ static void check_reachable_object(struct object *obj)
 		if (has_object_pack(&obj->oid))
 			return; /* it is in pack - forget about it */
 		printf_ln(_("missing %s %s"),
-			  printable_type(&obj->oid, obj->type),
-			  describe_object(&obj->oid));
+			  printable_type(obj),
+			  describe_object(obj));
 		errors_found |= ERROR_REACHABLE;
 		return;
 	}
@@ -288,8 +287,8 @@ static void check_unreachable_object(struct object *obj)
 	 */
 	if (show_unreachable) {
 		printf_ln(_("unreachable %s %s"),
-			  printable_type(&obj->oid, obj->type),
-			  describe_object(&obj->oid));
+			  printable_type(obj),
+			  describe_object(obj));
 		return;
 	}
 
@@ -308,12 +307,12 @@ static void check_unreachable_object(struct object *obj)
 	if (!(obj->flags & USED)) {
 		if (show_dangling)
 			printf_ln(_("dangling %s %s"),
-				  printable_type(&obj->oid, obj->type),
-				  describe_object(&obj->oid));
+				  printable_type(obj),
+				  describe_object(obj));
 		if (write_lost_and_found) {
 			char *filename = git_pathdup("lost-found/%s/%s",
 				obj->type == OBJ_COMMIT ? "commit" : "other",
-				describe_object(&obj->oid));
+				describe_object(obj));
 			FILE *f;
 
 			if (safe_create_leading_directories_const(filename)) {
@@ -326,7 +325,7 @@ static void check_unreachable_object(struct object *obj)
 				if (stream_blob_to_fd(fileno(f), &obj->oid, NULL, 1))
 					die_errno(_("could not write '%s'"), filename);
 			} else
-				fprintf(f, "%s\n", describe_object(&obj->oid));
+				fprintf(f, "%s\n", describe_object(obj));
 			if (fclose(f))
 				die_errno(_("could not finish '%s'"),
 					  filename);
@@ -345,7 +344,7 @@ static void check_unreachable_object(struct object *obj)
 static void check_object(struct object *obj)
 {
 	if (verbose)
-		fprintf_ln(stderr, _("Checking %s"), describe_object(&obj->oid));
+		fprintf_ln(stderr, _("Checking %s"), describe_object(obj));
 
 	if (obj->flags & REACHABLE)
 		check_reachable_object(obj);
@@ -403,8 +402,8 @@ static int fsck_obj(struct object *obj, void *buffer, unsigned long size)
 
 	if (verbose)
 		fprintf_ln(stderr, _("Checking %s %s"),
-			   printable_type(&obj->oid, obj->type),
-			   describe_object(&obj->oid));
+			   printable_type(obj),
+			   describe_object(obj));
 
 	if (fsck_walk(obj, NULL, &fsck_obj_options))
 		objerror(obj, _("broken links"));
@@ -417,7 +416,7 @@ static int fsck_obj(struct object *obj, void *buffer, unsigned long size)
 
 		if (!commit->parents && show_root)
 			printf_ln(_("root %s"),
-				  describe_object(&commit->object.oid));
+				  describe_object(&commit->object));
 	}
 
 	if (obj->type == OBJ_TAG) {
@@ -425,10 +424,10 @@ static int fsck_obj(struct object *obj, void *buffer, unsigned long size)
 
 		if (show_tags && tag->tagged) {
 			printf_ln(_("tagged %s %s (%s) in %s"),
-				  printable_type(&tag->tagged->oid, tag->tagged->type),
-				  describe_object(&tag->tagged->oid),
+				  printable_type(tag->tagged),
+				  describe_object(tag->tagged),
 				  tag->tag,
-				  describe_object(&tag->object.oid));
+				  describe_object(&tag->object));
 		}
 	}
 
diff --git a/builtin/mktag.c b/builtin/mktag.c
index dddcccdd368..4ea768d6cc1 100644
--- a/builtin/mktag.c
+++ b/builtin/mktag.c
@@ -15,8 +15,7 @@ static int option_strict = 1;
 static struct fsck_options fsck_options = FSCK_OPTIONS_STRICT;
 
 static int mktag_fsck_error_func(struct fsck_options *o,
-				 const struct object_id *oid,
-				 enum object_type object_type,
+				 const struct object *obj,
 				 enum fsck_msg_type msg_type,
 				 enum fsck_msg_id msg_id,
 				 const char *message)
diff --git a/fsck.c b/fsck.c
index f5ed6a26358..4ded78b5af9 100644
--- a/fsck.c
+++ b/fsck.c
@@ -199,14 +199,14 @@ void fsck_set_msg_types(struct fsck_options *options, const char *values)
 }
 
 static int object_on_skiplist(struct fsck_options *opts,
-			      const struct object_id *oid)
+			      const struct object *obj)
 {
-	return opts && oid && oidset_contains(&opts->skiplist, oid);
+	return opts && obj && oidset_contains(&opts->skiplist, &obj->oid);
 }
 
-__attribute__((format (printf, 5, 6)))
+__attribute__((format (printf, 4, 5)))
 static int report(struct fsck_options *options,
-		  const struct object_id *oid, enum object_type object_type,
+		  const struct object *obj,
 		  enum fsck_msg_id msg_id, const char *fmt, ...)
 {
 	va_list ap;
@@ -217,7 +217,7 @@ static int report(struct fsck_options *options,
 	if (msg_type == FSCK_IGNORE)
 		return 0;
 
-	if (object_on_skiplist(options, oid))
+	if (object_on_skiplist(options, obj))
 		return 0;
 
 	if (msg_type == FSCK_FATAL)
@@ -230,7 +230,7 @@ static int report(struct fsck_options *options,
 
 	va_start(ap, fmt);
 	strbuf_vaddf(&sb, fmt, ap);
-	result = options->error_func(options, oid, object_type,
+	result = options->error_func(options, obj,
 				     msg_type, msg_id, sb.buf);
 	strbuf_release(&sb);
 	va_end(ap);
@@ -278,8 +278,9 @@ void fsck_put_object_name(struct fsck_options *options,
 }
 
 const char *fsck_describe_object(struct fsck_options *options,
-				 const struct object_id *oid)
+				 const struct object *obj)
 {
+	const struct object_id *oid = &obj->oid;
 	static struct strbuf bufs[] = {
 		STRBUF_INIT, STRBUF_INIT, STRBUF_INIT, STRBUF_INIT
 	};
@@ -333,7 +334,7 @@ static int fsck_walk_tree(struct tree *tree, void *data, struct fsck_options *op
 		}
 		else {
 			result = error("in tree %s: entry %s has bad mode %.6o",
-				       fsck_describe_object(options, &tree->object.oid),
+				       fsck_describe_object(options, &tree->object),
 				       entry.path, entry.mode);
 		}
 		if (result < 0)
@@ -443,7 +444,7 @@ int fsck_walk(struct object *obj, void *data, struct fsck_options *options)
 		return fsck_walk_tag((struct tag *)obj, data, options);
 	default:
 		error("Unknown object type for %s",
-		      fsck_describe_object(options, &obj->oid));
+		      fsck_describe_object(options, obj));
 		return -1;
 	}
 }
@@ -558,7 +559,7 @@ static int verify_ordered(unsigned mode1, const char *name1,
 	return c1 < c2 ? 0 : TREE_UNORDERED;
 }
 
-static int fsck_tree(const struct object_id *oid,
+static int fsck_tree(const struct object *obj,
 		     const char *buffer, unsigned long size,
 		     struct fsck_options *options)
 {
@@ -579,7 +580,7 @@ static int fsck_tree(const struct object_id *oid,
 	struct name_stack df_dup_candidates = { NULL };
 
 	if (init_tree_desc_gently(&desc, buffer, size)) {
-		retval += report(options, oid, OBJ_TREE, FSCK_MSG_BAD_TREE, "cannot be parsed as a tree");
+		retval += report(options, obj, FSCK_MSG_BAD_TREE, "cannot be parsed as a tree");
 		return retval;
 	}
 
@@ -606,7 +607,7 @@ static int fsck_tree(const struct object_id *oid,
 				oidset_insert(&options->gitmodules_found, oid);
 			else
 				retval += report(options,
-						 oid, OBJ_TREE,
+						 obj,
 						 FSCK_MSG_GITMODULES_SYMLINK,
 						 ".gitmodules is a symbolic link");
 		}
@@ -619,7 +620,7 @@ static int fsck_tree(const struct object_id *oid,
 					if (!S_ISLNK(mode))
 						oidset_insert(&options->gitmodules_found, oid);
 					else
-						retval += report(options, oid, OBJ_TREE,
+						retval += report(options, obj,
 								 FSCK_MSG_GITMODULES_SYMLINK,
 								 ".gitmodules is a symbolic link");
 				}
@@ -628,7 +629,7 @@ static int fsck_tree(const struct object_id *oid,
 		}
 
 		if (update_tree_entry_gently(&desc)) {
-			retval += report(options, oid, OBJ_TREE, FSCK_MSG_BAD_TREE, "cannot be parsed as a tree");
+			retval += report(options, obj, FSCK_MSG_BAD_TREE, "cannot be parsed as a tree");
 			break;
 		}
 
@@ -676,30 +677,30 @@ static int fsck_tree(const struct object_id *oid,
 	name_stack_clear(&df_dup_candidates);
 
 	if (has_null_sha1)
-		retval += report(options, oid, OBJ_TREE, FSCK_MSG_NULL_SHA1, "contains entries pointing to null sha1");
+		retval += report(options, obj, FSCK_MSG_NULL_SHA1, "contains entries pointing to null sha1");
 	if (has_full_path)
-		retval += report(options, oid, OBJ_TREE, FSCK_MSG_FULL_PATHNAME, "contains full pathnames");
+		retval += report(options, obj, FSCK_MSG_FULL_PATHNAME, "contains full pathnames");
 	if (has_empty_name)
-		retval += report(options, oid, OBJ_TREE, FSCK_MSG_EMPTY_NAME, "contains empty pathname");
+		retval += report(options, obj, FSCK_MSG_EMPTY_NAME, "contains empty pathname");
 	if (has_dot)
-		retval += report(options, oid, OBJ_TREE, FSCK_MSG_HAS_DOT, "contains '.'");
+		retval += report(options, obj, FSCK_MSG_HAS_DOT, "contains '.'");
 	if (has_dotdot)
-		retval += report(options, oid, OBJ_TREE, FSCK_MSG_HAS_DOTDOT, "contains '..'");
+		retval += report(options, obj, FSCK_MSG_HAS_DOTDOT, "contains '..'");
 	if (has_dotgit)
-		retval += report(options, oid, OBJ_TREE, FSCK_MSG_HAS_DOTGIT, "contains '.git'");
+		retval += report(options, obj, FSCK_MSG_HAS_DOTGIT, "contains '.git'");
 	if (has_zero_pad)
-		retval += report(options, oid, OBJ_TREE, FSCK_MSG_ZERO_PADDED_FILEMODE, "contains zero-padded file modes");
+		retval += report(options, obj, FSCK_MSG_ZERO_PADDED_FILEMODE, "contains zero-padded file modes");
 	if (has_bad_modes)
-		retval += report(options, oid, OBJ_TREE, FSCK_MSG_BAD_FILEMODE, "contains bad file modes");
+		retval += report(options, obj, FSCK_MSG_BAD_FILEMODE, "contains bad file modes");
 	if (has_dup_entries)
-		retval += report(options, oid, OBJ_TREE, FSCK_MSG_DUPLICATE_ENTRIES, "contains duplicate file entries");
+		retval += report(options, obj, FSCK_MSG_DUPLICATE_ENTRIES, "contains duplicate file entries");
 	if (not_properly_sorted)
-		retval += report(options, oid, OBJ_TREE, FSCK_MSG_TREE_NOT_SORTED, "not properly sorted");
+		retval += report(options, obj, FSCK_MSG_TREE_NOT_SORTED, "not properly sorted");
 	return retval;
 }
 
 static int verify_headers(const void *data, unsigned long size,
-			  const struct object_id *oid, enum object_type type,
+			  const struct object *obj,
 			  struct fsck_options *options)
 {
 	const char *buffer = (const char *)data;
@@ -708,7 +709,7 @@ static int verify_headers(const void *data, unsigned long size,
 	for (i = 0; i < size; i++) {
 		switch (buffer[i]) {
 		case '\0':
-			return report(options, oid, type,
+			return report(options, obj,
 				FSCK_MSG_NUL_IN_HEADER,
 				"unterminated header: NUL at offset %ld", i);
 		case '\n':
@@ -726,12 +727,12 @@ static int verify_headers(const void *data, unsigned long size,
 	if (size && buffer[size - 1] == '\n')
 		return 0;
 
-	return report(options, oid, type,
-		FSCK_MSG_UNTERMINATED_HEADER, "unterminated header");
+	return report(options, obj,
+		      FSCK_MSG_UNTERMINATED_HEADER, "unterminated header");
 }
 
 static int fsck_ident(const char **ident,
-		      const struct object_id *oid, enum object_type type,
+		      const struct object *obj,
 		      struct fsck_options *options)
 {
 	const char *p = *ident;
@@ -742,28 +743,28 @@ static int fsck_ident(const char **ident,
 		(*ident)++;
 
 	if (*p == '<')
-		return report(options, oid, type, FSCK_MSG_MISSING_NAME_BEFORE_EMAIL, "invalid author/committer line - missing space before email");
+		return report(options, obj, FSCK_MSG_MISSING_NAME_BEFORE_EMAIL, "invalid author/committer line - missing space before email");
 	p += strcspn(p, "<>\n");
 	if (*p == '>')
-		return report(options, oid, type, FSCK_MSG_BAD_NAME, "invalid author/committer line - bad name");
+		return report(options, obj, FSCK_MSG_BAD_NAME, "invalid author/committer line - bad name");
 	if (*p != '<')
-		return report(options, oid, type, FSCK_MSG_MISSING_EMAIL, "invalid author/committer line - missing email");
+		return report(options, obj, FSCK_MSG_MISSING_EMAIL, "invalid author/committer line - missing email");
 	if (p[-1] != ' ')
-		return report(options, oid, type, FSCK_MSG_MISSING_SPACE_BEFORE_EMAIL, "invalid author/committer line - missing space before email");
+		return report(options, obj, FSCK_MSG_MISSING_SPACE_BEFORE_EMAIL, "invalid author/committer line - missing space before email");
 	p++;
 	p += strcspn(p, "<>\n");
 	if (*p != '>')
-		return report(options, oid, type, FSCK_MSG_BAD_EMAIL, "invalid author/committer line - bad email");
+		return report(options, obj, FSCK_MSG_BAD_EMAIL, "invalid author/committer line - bad email");
 	p++;
 	if (*p != ' ')
-		return report(options, oid, type, FSCK_MSG_MISSING_SPACE_BEFORE_DATE, "invalid author/committer line - missing space before date");
+		return report(options, obj, FSCK_MSG_MISSING_SPACE_BEFORE_DATE, "invalid author/committer line - missing space before date");
 	p++;
 	if (*p == '0' && p[1] != ' ')
-		return report(options, oid, type, FSCK_MSG_ZERO_PADDED_DATE, "invalid author/committer line - zero-padded date");
+		return report(options, obj, FSCK_MSG_ZERO_PADDED_DATE, "invalid author/committer line - zero-padded date");
 	if (date_overflows(parse_timestamp(p, &end, 10)))
-		return report(options, oid, type, FSCK_MSG_BAD_DATE_OVERFLOW, "invalid author/committer line - date causes integer overflow");
+		return report(options, obj, FSCK_MSG_BAD_DATE_OVERFLOW, "invalid author/committer line - date causes integer overflow");
 	if ((end == p || *end != ' '))
-		return report(options, oid, type, FSCK_MSG_BAD_DATE, "invalid author/committer line - bad date");
+		return report(options, obj, FSCK_MSG_BAD_DATE, "invalid author/committer line - bad date");
 	p = end + 1;
 	if ((*p != '+' && *p != '-') ||
 	    !isdigit(p[1]) ||
@@ -771,12 +772,12 @@ static int fsck_ident(const char **ident,
 	    !isdigit(p[3]) ||
 	    !isdigit(p[4]) ||
 	    (p[5] != '\n'))
-		return report(options, oid, type, FSCK_MSG_BAD_TIMEZONE, "invalid author/committer line - bad time zone");
+		return report(options, obj, FSCK_MSG_BAD_TIMEZONE, "invalid author/committer line - bad time zone");
 	p += 6;
 	return 0;
 }
 
-static int fsck_commit(const struct object_id *oid,
+static int fsck_commit(const struct object *obj,
 		       const char *buffer, unsigned long size,
 		       struct fsck_options *options)
 {
@@ -786,20 +787,20 @@ static int fsck_commit(const struct object_id *oid,
 	const char *buffer_begin = buffer;
 	const char *p;
 
-	if (verify_headers(buffer, size, oid, OBJ_COMMIT, options))
+	if (verify_headers(buffer, size, obj, options))
 		return -1;
 
 	if (!skip_prefix(buffer, "tree ", &buffer))
-		return report(options, oid, OBJ_COMMIT, FSCK_MSG_MISSING_TREE, "invalid format - expected 'tree' line");
+		return report(options, obj, FSCK_MSG_MISSING_TREE, "invalid format - expected 'tree' line");
 	if (parse_oid_hex(buffer, &tree_oid, &p) || *p != '\n') {
-		err = report(options, oid, OBJ_COMMIT, FSCK_MSG_BAD_TREE_SHA1, "invalid 'tree' line format - bad sha1");
+		err = report(options, obj, FSCK_MSG_BAD_TREE_SHA1, "invalid 'tree' line format - bad sha1");
 		if (err)
 			return err;
 	}
 	buffer = p + 1;
 	while (skip_prefix(buffer, "parent ", &buffer)) {
 		if (parse_oid_hex(buffer, &parent_oid, &p) || *p != '\n') {
-			err = report(options, oid, OBJ_COMMIT, FSCK_MSG_BAD_PARENT_SHA1, "invalid 'parent' line format - bad sha1");
+			err = report(options, obj, FSCK_MSG_BAD_PARENT_SHA1, "invalid 'parent' line format - bad sha1");
 			if (err)
 				return err;
 		}
@@ -808,23 +809,23 @@ static int fsck_commit(const struct object_id *oid,
 	author_count = 0;
 	while (skip_prefix(buffer, "author ", &buffer)) {
 		author_count++;
-		err = fsck_ident(&buffer, oid, OBJ_COMMIT, options);
+		err = fsck_ident(&buffer, obj, options);
 		if (err)
 			return err;
 	}
 	if (author_count < 1)
-		err = report(options, oid, OBJ_COMMIT, FSCK_MSG_MISSING_AUTHOR, "invalid format - expected 'author' line");
+		err = report(options, obj, FSCK_MSG_MISSING_AUTHOR, "invalid format - expected 'author' line");
 	else if (author_count > 1)
-		err = report(options, oid, OBJ_COMMIT, FSCK_MSG_MULTIPLE_AUTHORS, "invalid format - multiple 'author' lines");
+		err = report(options, obj, FSCK_MSG_MULTIPLE_AUTHORS, "invalid format - multiple 'author' lines");
 	if (err)
 		return err;
 	if (!skip_prefix(buffer, "committer ", &buffer))
-		return report(options, oid, OBJ_COMMIT, FSCK_MSG_MISSING_COMMITTER, "invalid format - expected 'committer' line");
-	err = fsck_ident(&buffer, oid, OBJ_COMMIT, options);
+		return report(options, obj, FSCK_MSG_MISSING_COMMITTER, "invalid format - expected 'committer' line");
+	err = fsck_ident(&buffer, obj, options);
 	if (err)
 		return err;
 	if (memchr(buffer_begin, '\0', size)) {
-		err = report(options, oid, OBJ_COMMIT, FSCK_MSG_NUL_IN_COMMIT,
+		err = report(options, obj, FSCK_MSG_NUL_IN_COMMIT,
 			     "NUL byte in the commit object body");
 		if (err)
 			return err;
@@ -832,16 +833,16 @@ static int fsck_commit(const struct object_id *oid,
 	return 0;
 }
 
-static int fsck_tag(const struct object_id *oid, const char *buffer,
+static int fsck_tag(const struct object *obj, const char *buffer,
 		    unsigned long size, struct fsck_options *options)
 {
 	struct object_id tagged_oid;
 	int tagged_type;
-	return fsck_tag_standalone(oid, buffer, size, options, &tagged_oid,
+	return fsck_tag_standalone(obj, buffer, size, options, &tagged_oid,
 				   &tagged_type);
 }
 
-int fsck_tag_standalone(const struct object_id *oid, const char *buffer,
+int fsck_tag_standalone(const struct object *obj, const char *buffer,
 			unsigned long size, struct fsck_options *options,
 			struct object_id *tagged_oid,
 			int *tagged_type)
@@ -851,49 +852,49 @@ int fsck_tag_standalone(const struct object_id *oid, const char *buffer,
 	struct strbuf sb = STRBUF_INIT;
 	const char *p;
 
-	ret = verify_headers(buffer, size, oid, OBJ_TAG, options);
+	ret = verify_headers(buffer, size, obj, options);
 	if (ret)
 		goto done;
 
 	if (!skip_prefix(buffer, "object ", &buffer)) {
-		ret = report(options, oid, OBJ_TAG, FSCK_MSG_MISSING_OBJECT, "invalid format - expected 'object' line");
+		ret = report(options, obj, FSCK_MSG_MISSING_OBJECT, "invalid format - expected 'object' line");
 		goto done;
 	}
 	if (parse_oid_hex(buffer, tagged_oid, &p) || *p != '\n') {
-		ret = report(options, oid, OBJ_TAG, FSCK_MSG_BAD_OBJECT_SHA1, "invalid 'object' line format - bad sha1");
+		ret = report(options, obj, FSCK_MSG_BAD_OBJECT_SHA1, "invalid 'object' line format - bad sha1");
 		if (ret)
 			goto done;
 	}
 	buffer = p + 1;
 
 	if (!skip_prefix(buffer, "type ", &buffer)) {
-		ret = report(options, oid, OBJ_TAG, FSCK_MSG_MISSING_TYPE_ENTRY, "invalid format - expected 'type' line");
+		ret = report(options, obj, FSCK_MSG_MISSING_TYPE_ENTRY, "invalid format - expected 'type' line");
 		goto done;
 	}
 	eol = strchr(buffer, '\n');
 	if (!eol) {
-		ret = report(options, oid, OBJ_TAG, FSCK_MSG_MISSING_TYPE, "invalid format - unexpected end after 'type' line");
+		ret = report(options, obj, FSCK_MSG_MISSING_TYPE, "invalid format - unexpected end after 'type' line");
 		goto done;
 	}
 	*tagged_type = type_from_string_gently(buffer, eol - buffer, 1);
 	if (*tagged_type < 0)
-		ret = report(options, oid, OBJ_TAG, FSCK_MSG_BAD_TYPE, "invalid 'type' value");
+		ret = report(options, obj, FSCK_MSG_BAD_TYPE, "invalid 'type' value");
 	if (ret)
 		goto done;
 	buffer = eol + 1;
 
 	if (!skip_prefix(buffer, "tag ", &buffer)) {
-		ret = report(options, oid, OBJ_TAG, FSCK_MSG_MISSING_TAG_ENTRY, "invalid format - expected 'tag' line");
+		ret = report(options, obj, FSCK_MSG_MISSING_TAG_ENTRY, "invalid format - expected 'tag' line");
 		goto done;
 	}
 	eol = strchr(buffer, '\n');
 	if (!eol) {
-		ret = report(options, oid, OBJ_TAG, FSCK_MSG_MISSING_TAG, "invalid format - unexpected end after 'type' line");
+		ret = report(options, obj, FSCK_MSG_MISSING_TAG, "invalid format - unexpected end after 'type' line");
 		goto done;
 	}
 	strbuf_addf(&sb, "refs/tags/%.*s", (int)(eol - buffer), buffer);
 	if (check_refname_format(sb.buf, 0)) {
-		ret = report(options, oid, OBJ_TAG,
+		ret = report(options, obj,
 			     FSCK_MSG_BAD_TAG_NAME,
 			     "invalid 'tag' name: %.*s",
 			     (int)(eol - buffer), buffer);
@@ -904,12 +905,12 @@ int fsck_tag_standalone(const struct object_id *oid, const char *buffer,
 
 	if (!skip_prefix(buffer, "tagger ", &buffer)) {
 		/* early tags do not contain 'tagger' lines; warn only */
-		ret = report(options, oid, OBJ_TAG, FSCK_MSG_MISSING_TAGGER_ENTRY, "invalid format - expected 'tagger' line");
+		ret = report(options, obj, FSCK_MSG_MISSING_TAGGER_ENTRY, "invalid format - expected 'tagger' line");
 		if (ret)
 			goto done;
 	}
 	else
-		ret = fsck_ident(&buffer, oid, OBJ_TAG, options);
+		ret = fsck_ident(&buffer, obj, options);
 	if (!*buffer)
 		goto done;
 
@@ -921,7 +922,7 @@ int fsck_tag_standalone(const struct object_id *oid, const char *buffer,
 		 * garbage" could be a custom header. E.g. "mktag"
 		 * doesn't want any unknown headers.
 		 */
-		ret = report(options, oid, OBJ_TAG, FSCK_MSG_EXTRA_HEADER_ENTRY, "invalid format - extra header(s) after 'tagger'");
+		ret = report(options, obj, FSCK_MSG_EXTRA_HEADER_ENTRY, "invalid format - extra header(s) after 'tagger'");
 		if (ret)
 			goto done;
 	}
@@ -1075,7 +1076,7 @@ static int check_submodule_url(const char *url)
 }
 
 struct fsck_gitmodules_data {
-	const struct object_id *oid;
+	const struct object *obj;
 	struct fsck_options *options;
 	int ret;
 };
@@ -1094,27 +1095,27 @@ static int fsck_gitmodules_fn(const char *var, const char *value, void *vdata)
 	name = xmemdupz(subsection, subsection_len);
 	if (check_submodule_name(name) < 0)
 		data->ret |= report(data->options,
-				    data->oid, OBJ_BLOB,
+				    data->obj,
 				    FSCK_MSG_GITMODULES_NAME,
 				    "disallowed submodule name: %s",
 				    name);
 	if (!strcmp(key, "url") && value &&
 	    check_submodule_url(value) < 0)
 		data->ret |= report(data->options,
-				    data->oid, OBJ_BLOB,
+				    data->obj,
 				    FSCK_MSG_GITMODULES_URL,
 				    "disallowed submodule url: %s",
 				    value);
 	if (!strcmp(key, "path") && value &&
 	    looks_like_command_line_option(value))
 		data->ret |= report(data->options,
-				    data->oid, OBJ_BLOB,
+				    data->obj,
 				    FSCK_MSG_GITMODULES_PATH,
 				    "disallowed submodule path: %s",
 				    value);
 	if (!strcmp(key, "update") && value &&
 	    parse_submodule_update_type(value) == SM_UPDATE_COMMAND)
-		data->ret |= report(data->options, data->oid, OBJ_BLOB,
+		data->ret |= report(data->options, data->obj,
 				    FSCK_MSG_GITMODULES_UPDATE,
 				    "disallowed submodule update setting: %s",
 				    value);
@@ -1123,9 +1124,10 @@ static int fsck_gitmodules_fn(const char *var, const char *value, void *vdata)
 	return 0;
 }
 
-static int fsck_blob(const struct object_id *oid, const char *buf,
+static int fsck_blob(const struct object *obj, const char *buf,
 		     unsigned long size, struct fsck_options *options)
 {
+	const struct object_id *oid = &obj->oid;
 	struct fsck_gitmodules_data data;
 	struct config_options config_opts = { 0 };
 
@@ -1133,7 +1135,7 @@ static int fsck_blob(const struct object_id *oid, const char *buf,
 		return 0;
 	oidset_insert(&options->gitmodules_done, oid);
 
-	if (object_on_skiplist(options, oid))
+	if (object_on_skiplist(options, obj))
 		return 0;
 
 	if (!buf) {
@@ -1142,18 +1144,18 @@ static int fsck_blob(const struct object_id *oid, const char *buf,
 		 * blob too gigantic to load into memory. Let's just consider
 		 * that an error.
 		 */
-		return report(options, oid, OBJ_BLOB,
+		return report(options, obj,
 			      FSCK_MSG_GITMODULES_LARGE,
 			      ".gitmodules too large to parse");
 	}
 
-	data.oid = oid;
+	data.obj = obj;
 	data.options = options;
 	data.ret = 0;
 	config_opts.error_action = CONFIG_ERROR_SILENT;
 	if (git_config_from_mem(fsck_gitmodules_fn, CONFIG_ORIGIN_BLOB,
 				".gitmodules", buf, size, &data, &config_opts))
-		data.ret |= report(options, oid, OBJ_BLOB,
+		data.ret |= report(options, obj,
 				   FSCK_MSG_GITMODULES_PARSE,
 				   "could not parse gitmodules blob");
 
@@ -1164,35 +1166,34 @@ int fsck_object(struct object *obj, void *data, unsigned long size,
 	struct fsck_options *options)
 {
 	if (!obj)
-		return report(options, NULL, OBJ_NONE, FSCK_MSG_BAD_OBJECT_SHA1, "no valid object to fsck");
+		return report(options, obj, FSCK_MSG_BAD_OBJECT_SHA1, "no valid object to fsck");
 
 	if (obj->type == OBJ_BLOB)
-		return fsck_blob(&obj->oid, data, size, options);
+		return fsck_blob(obj, data, size, options);
 	if (obj->type == OBJ_TREE)
-		return fsck_tree(&obj->oid, data, size, options);
+		return fsck_tree(obj, data, size, options);
 	if (obj->type == OBJ_COMMIT)
-		return fsck_commit(&obj->oid, data, size, options);
+		return fsck_commit(obj, data, size, options);
 	if (obj->type == OBJ_TAG)
-		return fsck_tag(&obj->oid, data, size, options);
+		return fsck_tag(obj, data, size, options);
 
-	return report(options, &obj->oid, obj->type,
+	return report(options, obj,
 		      FSCK_MSG_UNKNOWN_TYPE,
 		      "unknown type '%d' (internal fsck error)",
 		      obj->type);
 }
 
 int fsck_error_function(struct fsck_options *o,
-			const struct object_id *oid,
-			enum object_type object_type,
+			const struct object *obj,
 			enum fsck_msg_type msg_type,
 			enum fsck_msg_id msg_id,
 			const char *message)
 {
 	if (msg_type == FSCK_WARN) {
-		warning("object %s: %s", fsck_describe_object(o, oid), message);
+		warning("object %s: %s", fsck_describe_object(o, obj), message);
 		return 0;
 	}
-	error("object %s: %s", fsck_describe_object(o, oid), message);
+	error("object %s: %s", fsck_describe_object(o, obj), message);
 	return 1;
 }
 
@@ -1204,6 +1205,7 @@ int fsck_finish(struct fsck_options *options)
 
 	oidset_iter_init(&options->gitmodules_found, &iter);
 	while ((oid = oidset_iter_next(&iter))) {
+		struct object *obj;
 		enum object_type type;
 		unsigned long size;
 		char *buf;
@@ -1215,20 +1217,24 @@ int fsck_finish(struct fsck_options *options)
 		if (!buf) {
 			if (is_promisor_object(oid))
 				continue;
+			obj = (struct object *)lookup_blob(the_repository, oid);
 			ret |= report(options,
-				      oid, OBJ_BLOB,
+				      obj,
 				      FSCK_MSG_GITMODULES_MISSING,
 				      "unable to read .gitmodules blob");
 			continue;
 		}
 
-		if (type == OBJ_BLOB)
-			ret |= fsck_blob(oid, buf, size, options);
-		else
+		if (type == OBJ_BLOB) {
+			obj = (struct object *)lookup_blob(the_repository, oid);
+			ret |= fsck_blob(obj, buf, size, options);
+		} else {
+			obj = lookup_object(the_repository, oid);
 			ret |= report(options,
-				      oid, type,
+				      obj,
 				      FSCK_MSG_GITMODULES_BLOB,
 				      "non-blob found at .gitmodules");
+		}
 		free(buf);
 	}
 
@@ -1267,15 +1273,14 @@ int git_fsck_config(const char *var, const char *value, void *cb)
  */
 
 int fsck_error_cb_print_missing_gitmodules(struct fsck_options *o,
-					   const struct object_id *oid,
-					   enum object_type object_type,
+					   const struct object *obj,
 					   enum fsck_msg_type msg_type,
 					   enum fsck_msg_id msg_id,
 					   const char *message)
 {
 	if (msg_id == FSCK_MSG_GITMODULES_MISSING) {
-		puts(oid_to_hex(oid));
+		puts(oid_to_hex(&obj->oid));
 		return 0;
 	}
-	return fsck_error_function(o, oid, object_type, msg_type, msg_id, message);
+	return fsck_error_function(o, obj, msg_type, msg_id, message);
 }
diff --git a/fsck.h b/fsck.h
index 7202c3c87e8..864032709c4 100644
--- a/fsck.h
+++ b/fsck.h
@@ -103,17 +103,16 @@ typedef int (*fsck_walk_func)(struct object *obj, enum object_type object_type,
 
 /* callback for fsck_object, type is FSCK_ERROR or FSCK_WARN */
 typedef int (*fsck_error)(struct fsck_options *o,
-			  const struct object_id *oid, enum object_type object_type,
+			  const struct object *obj,
 			  enum fsck_msg_type msg_type, enum fsck_msg_id msg_id,
 			  const char *message);
 
 int fsck_error_function(struct fsck_options *o,
-			const struct object_id *oid, enum object_type object_type,
+			const struct object *obj,
 			enum fsck_msg_type msg_type, enum fsck_msg_id msg_id,
 			const char *message);
 int fsck_error_cb_print_missing_gitmodules(struct fsck_options *o,
-					   const struct object_id *oid,
-					   enum object_type object_type,
+					   const struct object *obj,
 					   enum fsck_msg_type msg_type,
 					   enum fsck_msg_id msg_id,
 					   const char *message);
@@ -168,7 +167,7 @@ int fsck_object(struct object *obj, void *data, unsigned long size,
  * fsck a tag, and pass info about it back to the caller. This is
  * exposed fsck_object() internals for git-mktag(1).
  */
-int fsck_tag_standalone(const struct object_id *oid, const char *buffer,
+int fsck_tag_standalone(const struct object *obj, const char *buffer,
 			unsigned long size, struct fsck_options *options,
 			struct object_id *tagged_oid,
 			int *tag_type);
@@ -203,7 +202,7 @@ void fsck_put_object_name(struct fsck_options *options,
 			  const struct object_id *oid,
 			  const char *fmt, ...);
 const char *fsck_describe_object(struct fsck_options *options,
-				 const struct object_id *oid);
+				 const struct object *obj);
 
 /*
  * git_config() callback for use by fsck-y tools that want to support
