Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C995198E81
	for <git@vger.kernel.org>; Thu, 27 Jun 2024 15:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719501156; cv=none; b=HhLyXnqj68UOiGra9RgzAG4V/t+zXC/ryD71O0rr0OIpO3XZnjO99NI/vQw7uo2n+wCyEMCB7KDznR/7Xr8twA9SpwZMQEC4ZEI1WSahrYPSqD+31rR/A9ORmGfUY3ofrLdNhKwMhXxQYOmam8xWTXGL6l5YLDt33d2OdvB2GnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719501156; c=relaxed/simple;
	bh=zox0c4KGmr9lebECFTULNLuTpUPPozai+chXeBgameI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DS1jCmSYJ7/WAnOBalMwzynL+dZbEnEpbSjtql54y0PN6v+uQ1HZPFhL1kR69bJBA2tRQGod0CBSLlgC5eLhvV7LkhZ1f69oH5QMZjILxT9B1L5/fuvDAbSp7rLJgOEXIv4ro5uzLqZ/fSwgn2ZUn8ItCD9yUBBc72YJgBgcp98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lzlNNrrf; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lzlNNrrf"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7067272245aso3984189b3a.1
        for <git@vger.kernel.org>; Thu, 27 Jun 2024 08:12:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719501153; x=1720105953; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JULW6pmNy2frx5+4Mr26gRe6+cg2Wj6Q0bMRxQ/Agc4=;
        b=lzlNNrrfnOZpqXIr+SLL812rkL454N6RfnLbibhWnBFMPECGW0iNQif7CWccwetjFZ
         /bn4m06e7c5SK+Hqm0ehbFuki42O5jGgI+P+5qfECuBUgYEcdM9ZQ2XCseV2/rzdqfdo
         snfIvW8Sm4Bkkv1TQJEYA7iyaQibEfsKM+aGcz6diwSW8c9V5gWxVt01OKVagle1EsbX
         Cpkg/oaXmOeLUxo4hSZJXnw0VkD01D9vRlOyeog6l3D+I0fSSijQE/SVk5XF45Fr3l5n
         AxVFk0tDstTAGcH57uF9RBct6GiouT0TO4KrdTb2lq9GUi3FVzOas7MNkVDtsXP9dBah
         4nXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719501153; x=1720105953;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JULW6pmNy2frx5+4Mr26gRe6+cg2Wj6Q0bMRxQ/Agc4=;
        b=Y28JwBDvVoBh8AUoH2O+NAmcijeFAAUBK5YyePvl5BilOOzzdRThZOtLhbleQn01uC
         T489YNHF073wjliG3exRtEA8jR5inmK79BAW7gm9T8KfaDNC464nDBsvZI7M6WOclrBF
         qmIa/lSKdVb9bxcU7AOb9FntA5YCDh38YNYgXH8Hgv4jpuAS5eF7G930lVLDfSwshmfm
         QUxLQU9jjJ5KeOonubM8CpF733dPuFePOXKqCaRxR7Y1a/j24iUgnSAqar5l1rXOwDIF
         V4MsC2SKMGXAyAZf8B2kcQl4REJav6SgzEfV5UsnZF8mYn7k3zYO7aZJPteMYTtMf3jE
         Vq3Q==
X-Gm-Message-State: AOJu0YyyYCY3JXTLAuepZkrzi0CnsHkCEQrpg1v8s0kwxTP/WXgW2d2u
	IGuMKrPRvG3/liO+tG77TU3EUGcD/rpZHCnahtHnzQGcpu3i+8QfmCGxkA==
X-Google-Smtp-Source: AGHT+IECSGEUFWF3aoIrcglzEyBb1DGNcaepFDjsPjGGiKB+3I8FWQMnUgIapYTAJ0NjwBke+TfOqA==
X-Received: by 2002:a05:6a00:1990:b0:705:9ba5:f3e9 with SMTP id d2e1a72fcca58-7067471bf99mr17174383b3a.30.1719501152942;
        Thu, 27 Jun 2024 08:12:32 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-706b4a3438bsm1468187b3a.151.2024.06.27.08.12.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 08:12:32 -0700 (PDT)
Date: Thu, 27 Jun 2024 23:12:29 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [GSoC][PATCH v5 01/12] fsck: rename "fsck_options" to
 "fsck_objects_options"
Message-ID: <Zn2BXRatUdX16PD3@ArchLinux>
References: <Zn2Ah3WDhtOmzrzn@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zn2Ah3WDhtOmzrzn@ArchLinux>

The git-fsck(1) focuses on object database consistency check. It relies
on the "fsck_options" to interact with fsck error levels. However,
"fsck_options" aims at checking the object database which contains a lot
of fields only related to object database.

In order to provide git-fsck(1) with refs consistency check. Rename
"fsck_options" to "fsck_objects_options" to explicitly indicate this
structure is used to check the object database.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Karthik Nayak <karthik.188@gmail.com>
Signed-off-by: shejialuo <shejialuo@gmail.com>
---
 builtin/fsck.c           | 13 ++++----
 builtin/index-pack.c     | 18 +++++------
 builtin/mktag.c          | 13 ++++----
 builtin/unpack-objects.c | 14 ++++-----
 fetch-pack.c             | 12 ++++----
 fsck.c                   | 64 ++++++++++++++++++++++------------------
 fsck.h                   | 43 ++++++++++++++-------------
 object-file.c            |  4 +--
 8 files changed, 95 insertions(+), 86 deletions(-)

diff --git a/builtin/fsck.c b/builtin/fsck.c
index d13a226c2e..ec3220880d 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -42,8 +42,8 @@ static int check_full = 1;
 static int connectivity_only;
 static int check_strict;
 static int keep_cache_objects;
-static struct fsck_options fsck_walk_options = FSCK_OPTIONS_DEFAULT;
-static struct fsck_options fsck_obj_options = FSCK_OPTIONS_DEFAULT;
+static struct fsck_objects_options fsck_walk_options = FSCK_OBJECTS_OPTIONS_DEFAULT;
+static struct fsck_objects_options fsck_obj_options = FSCK_OBJECTS_OPTIONS_DEFAULT;
 static int errors_found;
 static int write_lost_and_found;
 static int verbose;
@@ -89,7 +89,7 @@ static int objerror(struct object *obj, const char *err)
 	return -1;
 }
 
-static int fsck_error_func(struct fsck_options *o UNUSED,
+static int fsck_error_func(struct fsck_objects_options *o UNUSED,
 			   const struct object_id *oid,
 			   enum object_type object_type,
 			   enum fsck_msg_type msg_type,
@@ -118,7 +118,7 @@ static int fsck_error_func(struct fsck_options *o UNUSED,
 static struct object_array pending;
 
 static int mark_object(struct object *obj, enum object_type type,
-		       void *data, struct fsck_options *options UNUSED)
+		       void *data, struct fsck_objects_options *options UNUSED)
 {
 	struct object *parent = data;
 
@@ -204,7 +204,8 @@ static int traverse_reachable(void)
 }
 
 static int mark_used(struct object *obj, enum object_type type UNUSED,
-		     void *data UNUSED, struct fsck_options *options UNUSED)
+		     void *data UNUSED,
+		     struct fsck_objects_options *options UNUSED)
 {
 	if (!obj)
 		return 1;
@@ -214,7 +215,7 @@ static int mark_used(struct object *obj, enum object_type type UNUSED,
 
 static void mark_unreachable_referents(const struct object_id *oid)
 {
-	struct fsck_options options = FSCK_OPTIONS_DEFAULT;
+	struct fsck_objects_options options = FSCK_OBJECTS_OPTIONS_DEFAULT;
 	struct object *obj = lookup_object(the_repository, oid);
 
 	if (!obj || !(obj->flags & HAS_OBJ))
diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 856428fef9..08ebeedfd3 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -127,7 +127,7 @@ static int nr_threads;
 static int from_stdin;
 static int strict;
 static int do_fsck_object;
-static struct fsck_options fsck_options = FSCK_OPTIONS_MISSING_GITMODULES;
+static struct fsck_objects_options fsck_objects_options = FSCK_OBJECTS_OPTIONS_MISSING_GITMODULES;
 static int verbose;
 static const char *progress_title;
 static int show_resolving_progress;
@@ -220,7 +220,7 @@ static void cleanup_thread(void)
 
 static int mark_link(struct object *obj, enum object_type type,
 		     void *data UNUSED,
-		     struct fsck_options *options UNUSED)
+		     struct fsck_objects_options *options UNUSED)
 {
 	if (!obj)
 		return -1;
@@ -852,7 +852,7 @@ static void sha1_object(const void *data, struct object_entry *obj_entry,
 			else
 				die(_("invalid blob object %s"), oid_to_hex(oid));
 			if (do_fsck_object &&
-			    fsck_object(&blob->object, (void *)data, size, &fsck_options))
+			    fsck_object(&blob->object, (void *)data, size, &fsck_objects_options))
 				die(_("fsck error in packed object"));
 		} else {
 			struct object *obj;
@@ -871,9 +871,9 @@ static void sha1_object(const void *data, struct object_entry *obj_entry,
 			if (!obj)
 				die(_("invalid %s"), type_name(type));
 			if (do_fsck_object &&
-			    fsck_object(obj, buf, size, &fsck_options))
+			    fsck_object(obj, buf, size, &fsck_objects_options))
 				die(_("fsck error in packed object"));
-			if (strict && fsck_walk(obj, NULL, &fsck_options))
+			if (strict && fsck_walk(obj, NULL, &fsck_objects_options))
 				die(_("Not all child objects of %s are reachable"), oid_to_hex(&obj->oid));
 
 			if (obj->type == OBJ_TREE) {
@@ -1746,7 +1746,7 @@ int cmd_index_pack(int argc, const char **argv, const char *prefix)
 		usage(index_pack_usage);
 
 	disable_replace_refs();
-	fsck_options.walk = mark_link;
+	fsck_objects_options.walk = mark_link;
 
 	reset_pack_idx_option(&opts);
 	opts.flags |= WRITE_REV;
@@ -1770,13 +1770,13 @@ int cmd_index_pack(int argc, const char **argv, const char *prefix)
 			} else if (skip_to_optional_arg(arg, "--strict", &arg)) {
 				strict = 1;
 				do_fsck_object = 1;
-				fsck_set_msg_types(&fsck_options, arg);
+				fsck_set_msg_types(&fsck_objects_options, arg);
 			} else if (!strcmp(arg, "--check-self-contained-and-connected")) {
 				strict = 1;
 				check_self_contained_and_connected = 1;
 			} else if (skip_to_optional_arg(arg, "--fsck-objects", &arg)) {
 				do_fsck_object = 1;
-				fsck_set_msg_types(&fsck_options, arg);
+				fsck_set_msg_types(&fsck_objects_options, arg);
 			} else if (!strcmp(arg, "--verify")) {
 				verify = 1;
 			} else if (!strcmp(arg, "--verify-stat")) {
@@ -1943,7 +1943,7 @@ int cmd_index_pack(int argc, const char **argv, const char *prefix)
 	else
 		close(input_fd);
 
-	if (do_fsck_object && fsck_finish(&fsck_options))
+	if (do_fsck_object && fsck_finish(&fsck_objects_options))
 		die(_("fsck error in pack objects"));
 
 	free(opts.anomaly);
diff --git a/builtin/mktag.c b/builtin/mktag.c
index 4767f1a97e..be2abc71d8 100644
--- a/builtin/mktag.c
+++ b/builtin/mktag.c
@@ -15,9 +15,9 @@ static char const * const builtin_mktag_usage[] = {
 };
 static int option_strict = 1;
 
-static struct fsck_options fsck_options = FSCK_OPTIONS_STRICT;
+static struct fsck_objects_options fsck_objects_options = FSCK_OBJECTS_OPTIONS_STRICT;
 
-static int mktag_fsck_error_func(struct fsck_options *o UNUSED,
+static int mktag_fsck_error_func(struct fsck_objects_options *o UNUSED,
 				 const struct object_id *oid UNUSED,
 				 enum object_type object_type UNUSED,
 				 enum fsck_msg_type msg_type,
@@ -91,12 +91,13 @@ int cmd_mktag(int argc, const char **argv, const char *prefix)
 	if (strbuf_read(&buf, 0, 0) < 0)
 		die_errno(_("could not read from stdin"));
 
-	fsck_options.error_func = mktag_fsck_error_func;
-	fsck_set_msg_type_from_ids(&fsck_options, FSCK_MSG_EXTRA_HEADER_ENTRY,
+	fsck_objects_options.error_func = mktag_fsck_error_func;
+	fsck_set_msg_type_from_ids(&fsck_objects_options,
+				   FSCK_MSG_EXTRA_HEADER_ENTRY,
 				   FSCK_WARN);
 	/* config might set fsck.extraHeaderEntry=* again */
-	git_config(git_fsck_config, &fsck_options);
-	if (fsck_tag_standalone(NULL, buf.buf, buf.len, &fsck_options,
+	git_config(git_fsck_config, &fsck_objects_options);
+	if (fsck_tag_standalone(NULL, buf.buf, buf.len, &fsck_objects_options,
 				&tagged_oid, &tagged_type))
 		die(_("tag on stdin did not pass our strict fsck check"));
 
diff --git a/builtin/unpack-objects.c b/builtin/unpack-objects.c
index f1c85a00ae..c59e330db9 100644
--- a/builtin/unpack-objects.c
+++ b/builtin/unpack-objects.c
@@ -25,7 +25,7 @@ static unsigned int offset, len;
 static off_t consumed_bytes;
 static off_t max_input_size;
 static git_hash_ctx ctx;
-static struct fsck_options fsck_options = FSCK_OPTIONS_STRICT;
+static struct fsck_objects_options fsck_objects_options = FSCK_OBJECTS_OPTIONS_STRICT;
 static struct progress *progress;
 
 /*
@@ -212,7 +212,7 @@ static void write_cached_object(struct object *obj, struct obj_buffer *obj_buf)
  */
 static int check_object(struct object *obj, enum object_type type,
 			void *data UNUSED,
-			struct fsck_options *options UNUSED)
+			struct fsck_objects_options *options UNUSED)
 {
 	struct obj_buffer *obj_buf;
 
@@ -237,10 +237,10 @@ static int check_object(struct object *obj, enum object_type type,
 	obj_buf = lookup_object_buffer(obj);
 	if (!obj_buf)
 		die("Whoops! Cannot find object '%s'", oid_to_hex(&obj->oid));
-	if (fsck_object(obj, obj_buf->buffer, obj_buf->size, &fsck_options))
+	if (fsck_object(obj, obj_buf->buffer, obj_buf->size, &fsck_objects_options))
 		die("fsck error in packed object");
-	fsck_options.walk = check_object;
-	if (fsck_walk(obj, NULL, &fsck_options))
+	fsck_objects_options.walk = check_object;
+	if (fsck_walk(obj, NULL, &fsck_objects_options))
 		die("Error on reachable objects of %s", oid_to_hex(&obj->oid));
 	write_cached_object(obj, obj_buf);
 	return 0;
@@ -635,7 +635,7 @@ int cmd_unpack_objects(int argc, const char **argv, const char *prefix UNUSED)
 			}
 			if (skip_prefix(arg, "--strict=", &arg)) {
 				strict = 1;
-				fsck_set_msg_types(&fsck_options, arg);
+				fsck_set_msg_types(&fsck_objects_options, arg);
 				continue;
 			}
 			if (starts_with(arg, "--pack_header=")) {
@@ -671,7 +671,7 @@ int cmd_unpack_objects(int argc, const char **argv, const char *prefix UNUSED)
 	the_hash_algo->final_oid_fn(&oid, &tmp_ctx);
 	if (strict) {
 		write_rest();
-		if (fsck_finish(&fsck_options))
+		if (fsck_finish(&fsck_objects_options))
 			die(_("fsck error in pack objects"));
 	}
 	if (!hasheq(fill(the_hash_algo->rawsz), oid.hash))
diff --git a/fetch-pack.c b/fetch-pack.c
index eba9e420ea..7d1e4a5087 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -46,7 +46,7 @@ static int server_supports_filtering;
 static int advertise_sid;
 static struct shallow_lock shallow_lock;
 static const char *alternate_shallow_file;
-static struct fsck_options fsck_options = FSCK_OPTIONS_MISSING_GITMODULES;
+static struct fsck_objects_options fsck_objects_options = FSCK_OBJECTS_OPTIONS_MISSING_GITMODULES;
 static struct strbuf fsck_msg_types = STRBUF_INIT;
 static struct string_list uri_protocols = STRING_LIST_INIT_DUP;
 
@@ -1220,9 +1220,9 @@ static struct ref *do_fetch_pack(struct fetch_pack_args *args,
 	} else
 		alternate_shallow_file = NULL;
 	if (get_pack(args, fd, pack_lockfiles, NULL, sought, nr_sought,
-		     &fsck_options.gitmodules_found))
+		     &fsck_objects_options.gitmodules_found))
 		die(_("git fetch-pack: fetch failed."));
-	if (fsck_finish(&fsck_options))
+	if (fsck_finish(&fsck_objects_options))
 		die("fsck failed");
 
  all_done:
@@ -1780,7 +1780,7 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
 
 			if (get_pack(args, fd, pack_lockfiles,
 				     packfile_uris.nr ? &index_pack_args : NULL,
-				     sought, nr_sought, &fsck_options.gitmodules_found))
+				     sought, nr_sought, &fsck_objects_options.gitmodules_found))
 				die(_("git fetch-pack: fetch failed."));
 			do_check_stateless_delimiter(args->stateless_rpc, &reader);
 
@@ -1823,7 +1823,7 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
 
 		packname[the_hash_algo->hexsz] = '\0';
 
-		parse_gitmodules_oids(cmd.out, &fsck_options.gitmodules_found);
+		parse_gitmodules_oids(cmd.out, &fsck_objects_options.gitmodules_found);
 
 		close(cmd.out);
 
@@ -1844,7 +1844,7 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
 	string_list_clear(&packfile_uris, 0);
 	strvec_clear(&index_pack_args);
 
-	if (fsck_finish(&fsck_options))
+	if (fsck_finish(&fsck_objects_options))
 		die("fsck failed");
 
 	if (negotiator)
diff --git a/fsck.c b/fsck.c
index e193930ae7..c24a0f9fae 100644
--- a/fsck.c
+++ b/fsck.c
@@ -99,7 +99,7 @@ void list_config_fsck_msg_ids(struct string_list *list, const char *prefix)
 }
 
 static enum fsck_msg_type fsck_msg_type(enum fsck_msg_id msg_id,
-	struct fsck_options *options)
+					struct fsck_objects_options *options)
 {
 	assert(msg_id >= 0 && msg_id < FSCK_MSG_MAX);
 
@@ -134,7 +134,7 @@ int is_valid_msg_type(const char *msg_id, const char *msg_type)
 	return 1;
 }
 
-void fsck_set_msg_type_from_ids(struct fsck_options *options,
+void fsck_set_msg_type_from_ids(struct fsck_objects_options *options,
 				enum fsck_msg_id msg_id,
 				enum fsck_msg_type msg_type)
 {
@@ -150,7 +150,7 @@ void fsck_set_msg_type_from_ids(struct fsck_options *options,
 	options->msg_type[msg_id] = msg_type;
 }
 
-void fsck_set_msg_type(struct fsck_options *options,
+void fsck_set_msg_type(struct fsck_objects_options *options,
 		       const char *msg_id_str, const char *msg_type_str)
 {
 	int msg_id = parse_msg_id(msg_id_str);
@@ -179,7 +179,7 @@ void fsck_set_msg_type(struct fsck_options *options,
 	free(to_free);
 }
 
-void fsck_set_msg_types(struct fsck_options *options, const char *values)
+void fsck_set_msg_types(struct fsck_objects_options *options, const char *values)
 {
 	char *buf = xstrdup(values), *to_free = buf;
 	int done = 0;
@@ -217,14 +217,14 @@ void fsck_set_msg_types(struct fsck_options *options, const char *values)
 	free(to_free);
 }
 
-static int object_on_skiplist(struct fsck_options *opts,
+static int object_on_skiplist(struct fsck_objects_options *opts,
 			      const struct object_id *oid)
 {
 	return opts && oid && oidset_contains(&opts->skiplist, oid);
 }
 
 __attribute__((format (printf, 5, 6)))
-static int report(struct fsck_options *options,
+static int report(struct fsck_objects_options *options,
 		  const struct object_id *oid, enum object_type object_type,
 		  enum fsck_msg_id msg_id, const char *fmt, ...)
 {
@@ -257,13 +257,13 @@ static int report(struct fsck_options *options,
 	return result;
 }
 
-void fsck_enable_object_names(struct fsck_options *options)
+void fsck_enable_object_names(struct fsck_objects_options *options)
 {
 	if (!options->object_names)
 		options->object_names = kh_init_oid_map();
 }
 
-const char *fsck_get_object_name(struct fsck_options *options,
+const char *fsck_get_object_name(struct fsck_objects_options *options,
 				 const struct object_id *oid)
 {
 	khiter_t pos;
@@ -275,7 +275,7 @@ const char *fsck_get_object_name(struct fsck_options *options,
 	return kh_value(options->object_names, pos);
 }
 
-void fsck_put_object_name(struct fsck_options *options,
+void fsck_put_object_name(struct fsck_objects_options *options,
 			  const struct object_id *oid,
 			  const char *fmt, ...)
 {
@@ -296,7 +296,7 @@ void fsck_put_object_name(struct fsck_options *options,
 	va_end(ap);
 }
 
-const char *fsck_describe_object(struct fsck_options *options,
+const char *fsck_describe_object(struct fsck_objects_options *options,
 				 const struct object_id *oid)
 {
 	static struct strbuf bufs[] = {
@@ -316,7 +316,8 @@ const char *fsck_describe_object(struct fsck_options *options,
 	return buf->buf;
 }
 
-static int fsck_walk_tree(struct tree *tree, void *data, struct fsck_options *options)
+static int fsck_walk_tree(struct tree *tree, void *data,
+			  struct fsck_objects_options *options)
 {
 	struct tree_desc desc;
 	struct name_entry entry;
@@ -364,7 +365,8 @@ static int fsck_walk_tree(struct tree *tree, void *data, struct fsck_options *op
 	return res;
 }
 
-static int fsck_walk_commit(struct commit *commit, void *data, struct fsck_options *options)
+static int fsck_walk_commit(struct commit *commit, void *data,
+			    struct fsck_objects_options *options)
 {
 	int counter = 0, generation = 0, name_prefix_len = 0;
 	struct commit_list *parents;
@@ -433,7 +435,8 @@ static int fsck_walk_commit(struct commit *commit, void *data, struct fsck_optio
 	return res;
 }
 
-static int fsck_walk_tag(struct tag *tag, void *data, struct fsck_options *options)
+static int fsck_walk_tag(struct tag *tag, void *data,
+			 struct fsck_objects_options *options)
 {
 	const char *name = fsck_get_object_name(options, &tag->object.oid);
 
@@ -444,7 +447,8 @@ static int fsck_walk_tag(struct tag *tag, void *data, struct fsck_options *optio
 	return options->walk(tag->tagged, OBJ_ANY, data, options);
 }
 
-int fsck_walk(struct object *obj, void *data, struct fsck_options *options)
+int fsck_walk(struct object *obj, void *data,
+	      struct fsck_objects_options *options)
 {
 	if (!obj)
 		return -1;
@@ -580,7 +584,7 @@ static int verify_ordered(unsigned mode1, const char *name1,
 
 static int fsck_tree(const struct object_id *tree_oid,
 		     const char *buffer, unsigned long size,
-		     struct fsck_options *options)
+		     struct fsck_objects_options *options)
 {
 	int retval = 0;
 	int has_null_sha1 = 0;
@@ -793,7 +797,7 @@ static int fsck_tree(const struct object_id *tree_oid,
  */
 static int verify_headers(const void *data, unsigned long size,
 			  const struct object_id *oid, enum object_type type,
-			  struct fsck_options *options)
+			  struct fsck_objects_options *options)
 {
 	const char *buffer = (const char *)data;
 	unsigned long i;
@@ -825,7 +829,7 @@ static int verify_headers(const void *data, unsigned long size,
 
 static int fsck_ident(const char **ident,
 		      const struct object_id *oid, enum object_type type,
-		      struct fsck_options *options)
+		      struct fsck_objects_options *options)
 {
 	const char *p = *ident;
 	char *end;
@@ -885,7 +889,7 @@ static int fsck_ident(const char **ident,
 
 static int fsck_commit(const struct object_id *oid,
 		       const char *buffer, unsigned long size,
-		       struct fsck_options *options)
+		       struct fsck_objects_options *options)
 {
 	struct object_id tree_oid, parent_oid;
 	unsigned author_count;
@@ -946,7 +950,7 @@ static int fsck_commit(const struct object_id *oid,
 }
 
 static int fsck_tag(const struct object_id *oid, const char *buffer,
-		    unsigned long size, struct fsck_options *options)
+		    unsigned long size, struct fsck_objects_options *options)
 {
 	struct object_id tagged_oid;
 	int tagged_type;
@@ -955,7 +959,7 @@ static int fsck_tag(const struct object_id *oid, const char *buffer,
 }
 
 int fsck_tag_standalone(const struct object_id *oid, const char *buffer,
-			unsigned long size, struct fsck_options *options,
+			unsigned long size, struct fsck_objects_options *options,
 			struct object_id *tagged_oid,
 			int *tagged_type)
 {
@@ -1050,7 +1054,7 @@ int fsck_tag_standalone(const struct object_id *oid, const char *buffer,
 
 struct fsck_gitmodules_data {
 	const struct object_id *oid;
-	struct fsck_options *options;
+	struct fsck_objects_options *options;
 	int ret;
 };
 
@@ -1100,7 +1104,8 @@ static int fsck_gitmodules_fn(const char *var, const char *value,
 }
 
 static int fsck_blob(const struct object_id *oid, const char *buf,
-		     unsigned long size, struct fsck_options *options)
+		     unsigned long size,
+		     struct fsck_objects_options *options)
 {
 	int ret = 0;
 
@@ -1170,7 +1175,7 @@ static int fsck_blob(const struct object_id *oid, const char *buf,
 }
 
 int fsck_object(struct object *obj, void *data, unsigned long size,
-	struct fsck_options *options)
+		struct fsck_objects_options *options)
 {
 	if (!obj)
 		return report(options, NULL, OBJ_NONE, FSCK_MSG_BAD_OBJECT_SHA1, "no valid object to fsck");
@@ -1180,7 +1185,7 @@ int fsck_object(struct object *obj, void *data, unsigned long size,
 
 int fsck_buffer(const struct object_id *oid, enum object_type type,
 		const void *data, unsigned long size,
-		struct fsck_options *options)
+		struct fsck_objects_options *options)
 {
 	if (type == OBJ_BLOB)
 		return fsck_blob(oid, data, size, options);
@@ -1197,7 +1202,7 @@ int fsck_buffer(const struct object_id *oid, enum object_type type,
 		      type);
 }
 
-int fsck_error_function(struct fsck_options *o,
+int fsck_error_function(struct fsck_objects_options *o,
 			const struct object_id *oid,
 			enum object_type object_type UNUSED,
 			enum fsck_msg_type msg_type,
@@ -1214,7 +1219,8 @@ int fsck_error_function(struct fsck_options *o,
 
 static int fsck_blobs(struct oidset *blobs_found, struct oidset *blobs_done,
 		      enum fsck_msg_id msg_missing, enum fsck_msg_id msg_type,
-		      struct fsck_options *options, const char *blob_type)
+		      struct fsck_objects_options *options,
+		      const char *blob_type)
 {
 	int ret = 0;
 	struct oidset_iter iter;
@@ -1253,7 +1259,7 @@ static int fsck_blobs(struct oidset *blobs_found, struct oidset *blobs_done,
 	return ret;
 }
 
-int fsck_finish(struct fsck_options *options)
+int fsck_finish(struct fsck_objects_options *options)
 {
 	int ret = 0;
 
@@ -1270,7 +1276,7 @@ int fsck_finish(struct fsck_options *options)
 int git_fsck_config(const char *var, const char *value,
 		    const struct config_context *ctx, void *cb)
 {
-	struct fsck_options *options = cb;
+	struct fsck_objects_options *options = cb;
 	const char *msg_id;
 
 	if (strcmp(var, "fsck.skiplist") == 0) {
@@ -1300,7 +1306,7 @@ int git_fsck_config(const char *var, const char *value,
  * Custom error callbacks that are used in more than one place.
  */
 
-int fsck_error_cb_print_missing_gitmodules(struct fsck_options *o,
+int fsck_error_cb_print_missing_gitmodules(struct fsck_objects_options *o,
 					   const struct object_id *oid,
 					   enum object_type object_type,
 					   enum fsck_msg_type msg_type,
diff --git a/fsck.h b/fsck.h
index 6085a384f6..b64164db17 100644
--- a/fsck.h
+++ b/fsck.h
@@ -92,15 +92,15 @@ enum fsck_msg_id {
 };
 #undef MSG_ID
 
-struct fsck_options;
+struct fsck_objects_options;
 struct object;
 
-void fsck_set_msg_type_from_ids(struct fsck_options *options,
+void fsck_set_msg_type_from_ids(struct fsck_objects_options *options,
 				enum fsck_msg_id msg_id,
 				enum fsck_msg_type msg_type);
-void fsck_set_msg_type(struct fsck_options *options,
+void fsck_set_msg_type(struct fsck_objects_options *options,
 		       const char *msg_id, const char *msg_type);
-void fsck_set_msg_types(struct fsck_options *options, const char *values);
+void fsck_set_msg_types(struct fsck_objects_options *options, const char *values);
 int is_valid_msg_type(const char *msg_id, const char *msg_type);
 
 /*
@@ -112,26 +112,26 @@ int is_valid_msg_type(const char *msg_id, const char *msg_type);
  *     >0	error signaled and do not abort
  */
 typedef int (*fsck_walk_func)(struct object *obj, enum object_type object_type,
-			      void *data, struct fsck_options *options);
+			      void *data, struct fsck_objects_options *options);
 
 /* callback for fsck_object, type is FSCK_ERROR or FSCK_WARN */
-typedef int (*fsck_error)(struct fsck_options *o,
+typedef int (*fsck_error)(struct fsck_objects_options *o,
 			  const struct object_id *oid, enum object_type object_type,
 			  enum fsck_msg_type msg_type, enum fsck_msg_id msg_id,
 			  const char *message);
 
-int fsck_error_function(struct fsck_options *o,
+int fsck_error_function(struct fsck_objects_options *o,
 			const struct object_id *oid, enum object_type object_type,
 			enum fsck_msg_type msg_type, enum fsck_msg_id msg_id,
 			const char *message);
-int fsck_error_cb_print_missing_gitmodules(struct fsck_options *o,
+int fsck_error_cb_print_missing_gitmodules(struct fsck_objects_options *o,
 					   const struct object_id *oid,
 					   enum object_type object_type,
 					   enum fsck_msg_type msg_type,
 					   enum fsck_msg_id msg_id,
 					   const char *message);
 
-struct fsck_options {
+struct fsck_objects_options {
 	fsck_walk_func walk;
 	fsck_error error_func;
 	unsigned strict:1;
@@ -144,7 +144,7 @@ struct fsck_options {
 	kh_oid_map_t *object_names;
 };
 
-#define FSCK_OPTIONS_DEFAULT { \
+#define FSCK_OBJECTS_OPTIONS_DEFAULT { \
 	.skiplist = OIDSET_INIT, \
 	.gitmodules_found = OIDSET_INIT, \
 	.gitmodules_done = OIDSET_INIT, \
@@ -152,7 +152,7 @@ struct fsck_options {
 	.gitattributes_done = OIDSET_INIT, \
 	.error_func = fsck_error_function \
 }
-#define FSCK_OPTIONS_STRICT { \
+#define FSCK_OBJECTS_OPTIONS_STRICT { \
 	.strict = 1, \
 	.gitmodules_found = OIDSET_INIT, \
 	.gitmodules_done = OIDSET_INIT, \
@@ -160,7 +160,7 @@ struct fsck_options {
 	.gitattributes_done = OIDSET_INIT, \
 	.error_func = fsck_error_function, \
 }
-#define FSCK_OPTIONS_MISSING_GITMODULES { \
+#define FSCK_OBJECTS_OPTIONS_MISSING_GITMODULES { \
 	.strict = 1, \
 	.gitmodules_found = OIDSET_INIT, \
 	.gitmodules_done = OIDSET_INIT, \
@@ -176,14 +176,15 @@ struct fsck_options {
  *    >0	return value of the first signaled error >0 (in the case of no other errors)
  *    0		everything OK
  */
-int fsck_walk(struct object *obj, void *data, struct fsck_options *options);
+int fsck_walk(struct object *obj, void *data,
+	      struct fsck_objects_options *options);
 
 /*
  * Blob objects my pass a NULL data pointer, which indicates they are too large
  * to fit in memory. All other types must pass a real buffer.
  */
 int fsck_object(struct object *obj, void *data, unsigned long size,
-	struct fsck_options *options);
+		struct fsck_objects_options *options);
 
 /*
  * Same as fsck_object(), but for when the caller doesn't have an object
@@ -191,14 +192,14 @@ int fsck_object(struct object *obj, void *data, unsigned long size,
  */
 int fsck_buffer(const struct object_id *oid, enum object_type,
 		const void *data, unsigned long size,
-		struct fsck_options *options);
+		struct fsck_objects_options *options);
 
 /*
  * fsck a tag, and pass info about it back to the caller. This is
  * exposed fsck_object() internals for git-mktag(1).
  */
 int fsck_tag_standalone(const struct object_id *oid, const char *buffer,
-			unsigned long size, struct fsck_options *options,
+			unsigned long size, struct fsck_objects_options *options,
 			struct object_id *tagged_oid,
 			int *tag_type);
 
@@ -207,7 +208,7 @@ int fsck_tag_standalone(const struct object_id *oid, const char *buffer,
  * after completing all fsck_object() calls in order to resolve any remaining
  * checks.
  */
-int fsck_finish(struct fsck_options *options);
+int fsck_finish(struct fsck_objects_options *options);
 
 /*
  * Subsystem for storing human-readable names for each object.
@@ -224,14 +225,14 @@ int fsck_finish(struct fsck_options *options);
  * points to a rotating array of static buffers, and may be invalidated by a
  * subsequent call.
  */
-void fsck_enable_object_names(struct fsck_options *options);
-const char *fsck_get_object_name(struct fsck_options *options,
+void fsck_enable_object_names(struct fsck_objects_options *options);
+const char *fsck_get_object_name(struct fsck_objects_options *options,
 				 const struct object_id *oid);
 __attribute__((format (printf,3,4)))
-void fsck_put_object_name(struct fsck_options *options,
+void fsck_put_object_name(struct fsck_objects_options *options,
 			  const struct object_id *oid,
 			  const char *fmt, ...);
-const char *fsck_describe_object(struct fsck_options *options,
+const char *fsck_describe_object(struct fsck_objects_options *options,
 				 const struct object_id *oid);
 
 struct key_value_info;
diff --git a/object-file.c b/object-file.c
index d3cf4b8b2e..ec44ac3d82 100644
--- a/object-file.c
+++ b/object-file.c
@@ -2472,7 +2472,7 @@ int repo_has_object_file(struct repository *r,
  * report the minimal fsck error here, and rely on the caller to
  * give more context.
  */
-static int hash_format_check_report(struct fsck_options *opts UNUSED,
+static int hash_format_check_report(struct fsck_objects_options *opts UNUSED,
 				     const struct object_id *oid UNUSED,
 				     enum object_type object_type UNUSED,
 				     enum fsck_msg_type msg_type UNUSED,
@@ -2507,7 +2507,7 @@ static int index_mem(struct index_state *istate,
 		}
 	}
 	if (flags & HASH_FORMAT_CHECK) {
-		struct fsck_options opts = FSCK_OPTIONS_DEFAULT;
+		struct fsck_objects_options opts = FSCK_OBJECTS_OPTIONS_DEFAULT;
 
 		opts.strict = 1;
 		opts.error_func = hash_format_check_report;
-- 
2.45.2

