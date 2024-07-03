Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 139731741CF
	for <git@vger.kernel.org>; Wed,  3 Jul 2024 13:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720015010; cv=none; b=D1lFs/6I6S7ygk5AKNxx67tD/SNkp2rHf/rL7/Vm4NQW8xipQCK5hG68oOMWGvYbFxZ0ye+h9pRkN3CZQPXjtJj7ey/Yso3SHxNicsm4h/zXD+ZqM9ftYGgl/E75JjsoqqmSAWb22gLp0n6NcaF1kwnEJlJakAurR0bsN/yE1rI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720015010; c=relaxed/simple;
	bh=v8VmFdsty0kB+4InkuHUy7CQZTu3iJ7nCMvoEIJGbhw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i+EJrw0mukQR6o7RhoHenWZ3zoG17LpeuwJdoO3vKwCAvgL6m/PXQMQjqN2QzRdHQCrtVbUgbdS1GuXXXUt+ixo0+fXpR+hmOyFqOc07RZl6hDhlgJkZH4ePNR7BUVM8kbOmkBPpDhuFUg6btZMME88eFeaIfIjU9QruytJ/xX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MlZGKl9j; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MlZGKl9j"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1fab50496f0so33171495ad.2
        for <git@vger.kernel.org>; Wed, 03 Jul 2024 06:56:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720015008; x=1720619808; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hM1jUVbFa2gV7nYe65iTj5F6/NS+XiByT6O/hhGxcbM=;
        b=MlZGKl9jdpVS69+APnmghU+j3/X3qROaUYOCJTbH9Q7nGc2TpZieQ6IyROAESKNtIu
         oYASOjj7DXYp1EHdAeY9UILc1l/DCNVtSePyKYQ+BRXU2gaUjYpf0KDdJcaZwuYZxWns
         nHXkP9+Sq4E4KOeknJhLFIW0PctHk3lsVmcyR9q267cUFfajDTkWDyNzbQBg4D6FqbQy
         Hkmj5OouJyseyH/8d7u9dZxCApQavy+bBpbsP4MvIBIqWvj4papYd6g35ieLlpZQGad5
         WpPPftjoo322kvl85SDtHATddV30rWwdFJaCssEqQSBWn7RN/Eie5/KRj0sNaiCWp4gC
         NMZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720015008; x=1720619808;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hM1jUVbFa2gV7nYe65iTj5F6/NS+XiByT6O/hhGxcbM=;
        b=KzpeJnClkPPv/KKwqydwBmH0e2w4PqvgukjtVQw123DSa4IPinVCuXtAKOW5rs04s/
         C7y8H0sQM9F6tdQbhCh/j01afIHrYazjFl5PfgycJjLl3XBQ1r2CAaLe8kNlacbrteG7
         6tJmqGklT4JvJ0wCsBJENZh8f0yGycl1ZfXl9PxXB+aBIzXkmcICM1akDpWf970kMqTS
         M/0EKNIiYBBoAQFKmfcPvo+o5FxmBhwgb566i9nh+7D5NvFiz80HJ2YWqL3Wn3ikKgw3
         O75oz5jCyJ6Im28rTk64NbbQ9waI48ZYOPSSmj33K9KvQP0lvPkA8uNhiMNtg3HaBaMj
         8bBQ==
X-Gm-Message-State: AOJu0YxX8fwsVUy84A2DVQ0+yBdxStpFxs7xWYCydrZJ5rqM9VZ0RFjp
	T16TpX/+KiO8v7l88DVGfxI2kDCj64WHmNsq4UKFExQsEfZvVFrd5f2Wrxyy
X-Google-Smtp-Source: AGHT+IHQ+rlhLhxUwjC4Rs0NVvJf7VVJvwfOTNbgiWB7x8uu5l1tjYfo3UqWoC99Jt2gMXr+UcmV9Q==
X-Received: by 2002:a17:902:e849:b0:1fa:1599:386b with SMTP id d9443c01a7336-1fadbc73e81mr69486845ad.20.1720015007715;
        Wed, 03 Jul 2024 06:56:47 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fac1535d07sm103310585ad.123.2024.07.03.06.56.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 06:56:47 -0700 (PDT)
Date: Wed, 3 Jul 2024 21:56:47 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [GSoC][PATCH v7 2/9] fsck: add a unified interface for reporting
 fsck messages
Message-ID: <ZoVYn6C-QOuHM2sC@ArchLinux>
References: <ZoVX6sn2C9VIeZ38@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZoVX6sn2C9VIeZ38@ArchLinux>

The static function "report" provided by "fsck.c" aims at reporting the
problems related to object database which cannot be reused for refs.
In order to provide a unified interface which can report either objects
or refs, create a new function "vfsck_report" by adding
"checked_ref_name" parameter following the "report" prototype. However,
instead of using "...", provide "va_list" to allow more flexibility.

The "vfsck_report" function will use "error_func" registered in
"fsck_options" function to report customized messages. Change
"error_func" prototype to align with the "vfsck_report".

Change "report" function to make it use "vfsck_report" to report
objects-related messages. Add a new function called "fsck_refs_report"
to use "vfsck_report" to report refs-related messages.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Karthik Nayak <karthik.188@gmail.com>
Signed-off-by: shejialuo <shejialuo@gmail.com>
---
 builtin/fsck.c  | 15 ++++-----
 builtin/mktag.c |  1 +
 fsck.c          | 81 ++++++++++++++++++++++++++++++++++++-------------
 fsck.h          | 42 ++++++++++++++++---------
 object-file.c   | 11 ++++---
 5 files changed, 102 insertions(+), 48 deletions(-)

diff --git a/builtin/fsck.c b/builtin/fsck.c
index d13a226c2e..de34538c4f 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -89,12 +89,13 @@ static int objerror(struct object *obj, const char *err)
 	return -1;
 }
 
-static int fsck_error_func(struct fsck_options *o UNUSED,
-			   const struct object_id *oid,
-			   enum object_type object_type,
-			   enum fsck_msg_type msg_type,
-			   enum fsck_msg_id msg_id UNUSED,
-			   const char *message)
+static int fsck_objects_error_func(struct fsck_options *o UNUSED,
+				   const struct object_id *oid,
+				   enum object_type object_type,
+				   const char *checked_ref_name UNUSED,
+				   enum fsck_msg_type msg_type,
+				   enum fsck_msg_id msg_id UNUSED,
+				   const char *message)
 {
 	switch (msg_type) {
 	case FSCK_WARN:
@@ -938,7 +939,7 @@ int cmd_fsck(int argc, const char **argv, const char *prefix)
 
 	fsck_walk_options.walk = mark_object;
 	fsck_obj_options.walk = mark_used;
-	fsck_obj_options.error_func = fsck_error_func;
+	fsck_obj_options.error_func = fsck_objects_error_func;
 	if (check_strict)
 		fsck_obj_options.strict = 1;
 
diff --git a/builtin/mktag.c b/builtin/mktag.c
index 4767f1a97e..42f945c584 100644
--- a/builtin/mktag.c
+++ b/builtin/mktag.c
@@ -20,6 +20,7 @@ static struct fsck_options fsck_options = FSCK_OPTIONS_STRICT;
 static int mktag_fsck_error_func(struct fsck_options *o UNUSED,
 				 const struct object_id *oid UNUSED,
 				 enum object_type object_type UNUSED,
+				 const char *checked_ref_name UNUSED,
 				 enum fsck_msg_type msg_type,
 				 enum fsck_msg_id msg_id UNUSED,
 				 const char *message)
diff --git a/fsck.c b/fsck.c
index 1960bfeba9..7182ce8e80 100644
--- a/fsck.c
+++ b/fsck.c
@@ -226,12 +226,18 @@ static int object_on_skiplist(struct fsck_options *opts,
 	return opts && oid && oidset_contains(&opts->oid_skiplist, oid);
 }
 
-__attribute__((format (printf, 5, 6)))
-static int report(struct fsck_options *options,
-		  const struct object_id *oid, enum object_type object_type,
-		  enum fsck_msg_id msg_id, const char *fmt, ...)
+/*
+ * Provide a unified interface for either fscking refs or objects.
+ * It will get the current msg error type and call the error_func callback
+ * which is registered in the "fsck_options" struct.
+ */
+static int vfsck_report(struct fsck_options *options,
+			const struct object_id *oid,
+			enum object_type object_type,
+			const char *checked_ref_name,
+			enum fsck_msg_id msg_id, const char *fmt, va_list ap)
 {
-	va_list ap;
+	va_list ap_copy;
 	struct strbuf sb = STRBUF_INIT;
 	enum fsck_msg_type msg_type = fsck_msg_type(msg_id, options);
 	int result;
@@ -250,9 +256,9 @@ static int report(struct fsck_options *options,
 	prepare_msg_ids();
 	strbuf_addf(&sb, "%s: ", msg_id_info[msg_id].camelcased);
 
-	va_start(ap, fmt);
-	strbuf_vaddf(&sb, fmt, ap);
-	result = options->error_func(options, oid, object_type,
+	va_copy(ap_copy, ap);
+	strbuf_vaddf(&sb, fmt, ap_copy);
+	result = options->error_func(options, oid, object_type, checked_ref_name,
 				     msg_type, msg_id, sb.buf);
 	strbuf_release(&sb);
 	va_end(ap);
@@ -260,6 +266,36 @@ static int report(struct fsck_options *options,
 	return result;
 }
 
+__attribute__((format (printf, 5, 6)))
+static int report(struct fsck_options *options,
+		  const struct object_id *oid, enum object_type object_type,
+		  enum fsck_msg_id msg_id, const char *fmt, ...)
+{
+	va_list ap;
+	int result;
+	va_start(ap, fmt);
+	result = vfsck_report(options, oid, object_type, NULL,
+			      msg_id, fmt, ap);
+	va_end(ap);
+	return result;
+}
+
+
+
+int fsck_refs_report(struct fsck_options *options,
+		     const struct object_id *oid,
+		     const char *checked_ref_name,
+		     enum fsck_msg_id msg_id, const char *fmt, ...)
+{
+	va_list ap;
+	int result;
+	va_start(ap, fmt);
+	result = vfsck_report(options, oid, OBJ_NONE,
+			      checked_ref_name, msg_id, fmt, ap);
+	va_end(ap);
+	return result;
+}
+
 void fsck_enable_object_names(struct fsck_options *options)
 {
 	if (!options->object_names)
@@ -1200,12 +1236,13 @@ int fsck_buffer(const struct object_id *oid, enum object_type type,
 		      type);
 }
 
-int fsck_error_function(struct fsck_options *o,
-			const struct object_id *oid,
-			enum object_type object_type UNUSED,
-			enum fsck_msg_type msg_type,
-			enum fsck_msg_id msg_id UNUSED,
-			const char *message)
+int fsck_objects_error_function(struct fsck_options *o,
+				const struct object_id *oid,
+				enum object_type object_type UNUSED,
+				const char *checked_ref_name UNUSED,
+				enum fsck_msg_type msg_type,
+				enum fsck_msg_id msg_id UNUSED,
+				const char *message)
 {
 	if (msg_type == FSCK_WARN) {
 		warning("object %s: %s", fsck_describe_object(o, oid), message);
@@ -1303,16 +1340,18 @@ int git_fsck_config(const char *var, const char *value,
  * Custom error callbacks that are used in more than one place.
  */
 
-int fsck_error_cb_print_missing_gitmodules(struct fsck_options *o,
-					   const struct object_id *oid,
-					   enum object_type object_type,
-					   enum fsck_msg_type msg_type,
-					   enum fsck_msg_id msg_id,
-					   const char *message)
+int fsck_objects_error_cb_print_missing_gitmodules(struct fsck_options *o,
+						   const struct object_id *oid,
+						   enum object_type object_type,
+						   const char *checked_ref_name,
+						   enum fsck_msg_type msg_type,
+						   enum fsck_msg_id msg_id,
+						   const char *message)
 {
 	if (msg_id == FSCK_MSG_GITMODULES_MISSING) {
 		puts(oid_to_hex(oid));
 		return 0;
 	}
-	return fsck_error_function(o, oid, object_type, msg_type, msg_id, message);
+	return fsck_objects_error_function(o, oid, object_type, checked_ref_name,
+					   msg_type, msg_id, message);
 }
diff --git a/fsck.h b/fsck.h
index 1ee3dd85ba..f703dfb5e8 100644
--- a/fsck.h
+++ b/fsck.h
@@ -114,22 +114,27 @@ int is_valid_msg_type(const char *msg_id, const char *msg_type);
 typedef int (*fsck_walk_func)(struct object *obj, enum object_type object_type,
 			      void *data, struct fsck_options *options);
 
-/* callback for fsck_object, type is FSCK_ERROR or FSCK_WARN */
+/*
+ * callback function for reporting errors when checking either objects or refs
+ */
 typedef int (*fsck_error)(struct fsck_options *o,
 			  const struct object_id *oid, enum object_type object_type,
+			  const char *checked_ref_name,
 			  enum fsck_msg_type msg_type, enum fsck_msg_id msg_id,
 			  const char *message);
 
-int fsck_error_function(struct fsck_options *o,
-			const struct object_id *oid, enum object_type object_type,
-			enum fsck_msg_type msg_type, enum fsck_msg_id msg_id,
-			const char *message);
-int fsck_error_cb_print_missing_gitmodules(struct fsck_options *o,
-					   const struct object_id *oid,
-					   enum object_type object_type,
-					   enum fsck_msg_type msg_type,
-					   enum fsck_msg_id msg_id,
-					   const char *message);
+int fsck_objects_error_function(struct fsck_options *o,
+				const struct object_id *oid, enum object_type object_type,
+				const char *checked_ref_name,
+				enum fsck_msg_type msg_type, enum fsck_msg_id msg_id,
+				const char *message);
+int fsck_objects_error_cb_print_missing_gitmodules(struct fsck_options *o,
+						   const struct object_id *oid,
+						   enum object_type object_type,
+						   const char *checked_ref_name,
+						   enum fsck_msg_type msg_type,
+						   enum fsck_msg_id msg_id,
+						   const char *message);
 
 struct fsck_options {
 	fsck_walk_func walk;
@@ -145,12 +150,12 @@ struct fsck_options {
 };
 
 #define FSCK_OPTIONS_DEFAULT { \
-	.skiplist = OIDSET_INIT, \
+	.oid_skiplist = OIDSET_INIT, \
 	.gitmodules_found = OIDSET_INIT, \
 	.gitmodules_done = OIDSET_INIT, \
 	.gitattributes_found = OIDSET_INIT, \
 	.gitattributes_done = OIDSET_INIT, \
-	.error_func = fsck_error_function \
+	.error_func = fsck_objects_error_function \
 }
 #define FSCK_OPTIONS_STRICT { \
 	.strict = 1, \
@@ -158,7 +163,7 @@ struct fsck_options {
 	.gitmodules_done = OIDSET_INIT, \
 	.gitattributes_found = OIDSET_INIT, \
 	.gitattributes_done = OIDSET_INIT, \
-	.error_func = fsck_error_function, \
+	.error_func = fsck_objects_error_function, \
 }
 #define FSCK_OPTIONS_MISSING_GITMODULES { \
 	.strict = 1, \
@@ -166,7 +171,7 @@ struct fsck_options {
 	.gitmodules_done = OIDSET_INIT, \
 	.gitattributes_found = OIDSET_INIT, \
 	.gitattributes_done = OIDSET_INIT, \
-	.error_func = fsck_error_cb_print_missing_gitmodules, \
+	.error_func = fsck_objects_error_cb_print_missing_gitmodules, \
 }
 
 /* descend in all linked child objects
@@ -209,6 +214,13 @@ int fsck_tag_standalone(const struct object_id *oid, const char *buffer,
  */
 int fsck_finish(struct fsck_options *options);
 
+__attribute__((format (printf, 5, 6)))
+int fsck_refs_report(struct fsck_options *options,
+		     const struct object_id *oid,
+		     const char *checked_ref_name,
+		     enum fsck_msg_id msg_id,
+		     const char *fmt, ...);
+
 /*
  * Subsystem for storing human-readable names for each object.
  *
diff --git a/object-file.c b/object-file.c
index 065103be3e..d2c6427935 100644
--- a/object-file.c
+++ b/object-file.c
@@ -2470,11 +2470,12 @@ int repo_has_object_file(struct repository *r,
  * give more context.
  */
 static int hash_format_check_report(struct fsck_options *opts UNUSED,
-				     const struct object_id *oid UNUSED,
-				     enum object_type object_type UNUSED,
-				     enum fsck_msg_type msg_type UNUSED,
-				     enum fsck_msg_id msg_id UNUSED,
-				     const char *message)
+				    const struct object_id *oid UNUSED,
+				    enum object_type object_type UNUSED,
+				    const char *ref_checked_name UNUSED,
+				    enum fsck_msg_type msg_type UNUSED,
+				    enum fsck_msg_id msg_id UNUSED,
+				    const char *message)
 {
 	error(_("object fails fsck: %s"), message);
 	return 1;
-- 
2.45.2

