Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58CFF15EFA4
	for <git@vger.kernel.org>; Thu, 27 Jun 2024 15:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719501268; cv=none; b=nyRlD/uOqoC1XJXGmDsdRqa+nlxmDVmd/SXrE2cDbkkswDY7RBHGkwIXjw6SFKMl6S/spNgr1YTnUVK+s9D8YI+YBVhB1i45Uzijc7WuSNOQ5UgKe7Agk8TcAgS+6fV1JDgP2SKGQkAcEEhcWhYovkeQWzpmr7fEwAB2fWzrGxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719501268; c=relaxed/simple;
	bh=NtDlJ5yB9MRzU7FDHUytlNDi3DKpPtkIMakZ2KVgngU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LwhnNqlhxCFpaKTBGZPipU1X8FllZl7oBXfsH0PdsLizeLAvFMEsjNWtp0bptvFl2sUwUHKme9XgYNRgte8K9cKNpDzEvsGE1YXRUpmdSGtK7c7m7AEY8Ktf1uDF6C6dSPOSXrR7y0GMm+yek0cJHnAqG2TDPM4aulAKWq9FG8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q3v1vK3h; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q3v1vK3h"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-70670188420so4290009b3a.2
        for <git@vger.kernel.org>; Thu, 27 Jun 2024 08:14:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719501265; x=1720106065; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GnpUu6Vr4AQMBbj2weRVsZlDo0DFAbZ8DNczzdgCKYU=;
        b=Q3v1vK3hAcwbVc5KmhxUCLlULsCzyHn3AoDe5BabHnOEkaYXZJiSkI0FHj37Esus2F
         uabKfaXIrWllYC09m3uBmT89pLKKgbCen8aMG4+WnDaYAKx8NrcqUzeEYLFaYu2VUDT3
         XV+QPcntrEKWKr7DpT+JQHI8jcwUBbxemVbzRQtfNtAUaqUQxXkSFfWrRSrbhz2DlRU0
         87j2hN7oP47Qb64rjBIhwrT8YEW9Am+ydTD/Xihpp9Ch6F5hkHWo4+cNh4L3/PCUgm2q
         cNBKYPONAh2XVaz9f1QF+EhrZBR4LnzMur+SwoARTl7OT6oPpn83mLQ1S2JzPfr6xTqQ
         okQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719501265; x=1720106065;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GnpUu6Vr4AQMBbj2weRVsZlDo0DFAbZ8DNczzdgCKYU=;
        b=xGyHz8+gTF4UVpT+TjxIMjvSade+BMsKwJwCY8P9y+b+VzrujSEOkSbfwQfvwGCZKq
         ZZa3/56ZKalvoxu525PgM1XwyWguCsFHFGCVldHBCD8KICCyknaPRvfeyKLwmpo2slOe
         Vv82FgQ2Z+mz0W4+lycAU+xh4A5RN4fgQ5ItZfvmhtF2Bef7nKRTg2aQiZELQrDlyJtl
         qbZQNM90RSeCfCoMGrKCwqZ7GPrM8BiINqyHJh5xzgAullo+zUu2dPyKzeu4lgLOU2EJ
         Ro9Tdzqo61PWh7XhKTwSv01fGYRjxNdaq9EYksTeORdjIbRWkSMz8hJbJS7Y4kn2n+Yl
         M+OA==
X-Gm-Message-State: AOJu0Yw9TFBcL55xamupTciAgxwBaPVTYcpSjBRJCCa63Mw9DLgTZ8Dn
	HqyEN9GbmUdJgogB4bmDKWApJBTx+fw44W5AYFLvAdSc1rkMOd20876Cjw==
X-Google-Smtp-Source: AGHT+IGh6rw/GdLkmUPF6HxMJ5TvWsZDTwZOMBJmwEzhwqM9xJqyC7RaMMLadqwy2/OXM7AK5LUPAw==
X-Received: by 2002:a05:6a00:2f17:b0:704:2d7f:b61c with SMTP id d2e1a72fcca58-7066e4e69c5mr13996273b3a.7.1719501264863;
        Thu, 27 Jun 2024 08:14:24 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-706b4a58ebfsm1466847b3a.196.2024.06.27.08.14.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 08:14:24 -0700 (PDT)
Date: Thu, 27 Jun 2024 23:14:21 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [GSoC][PATCH v5 05/12] fsck: add a unified interface for reporting
 fsck messages
Message-ID: <Zn2BzdUa8tT6_WpN@ArchLinux>
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

The static function "report" provided by "fsck.c" aims at reporting the
problems related to object database which cannot be reused for refs.
In order to provide a unified interface which can report either objects
or refs, create a new function "fsck_report" by adding two parameters
"refs_options" and "checked_ref_name" following the "report" prototype.
However, instead of using "...", provide "va_list" to allow more
flexibility.

The "vfsck_report" function will use "error_func" registered in
"fsck_options" function to report customized messages. Change
"error_func" prototype to align with the "vfsck_report".

Change "report" function to make it use "vfsck_report" to report
objects-related messages. Add a new function called "fsck_refs_report"
to use "vfsck_report" to report refs-related messages. Also, create a
general function "fsck_report" for future use.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Karthik Nayak <karthik.188@gmail.com>
Signed-off-by: shejialuo <shejialuo@gmail.com>
---
 builtin/fsck.c  |  4 ++-
 builtin/mktag.c |  4 ++-
 fsck.c          | 88 ++++++++++++++++++++++++++++++++++++++++---------
 fsck.h          | 39 +++++++++++++++++++---
 object-file.c   | 14 ++++----
 5 files changed, 122 insertions(+), 27 deletions(-)

diff --git a/builtin/fsck.c b/builtin/fsck.c
index c383125027..2a3b536c1b 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -89,9 +89,11 @@ static int objerror(struct object *obj, const char *err)
 	return -1;
 }
 
-static int fsck_error_func(struct fsck_objects_options *o UNUSED,
+static int fsck_error_func(struct fsck_objects_options *objects_options UNUSED,
+			   struct fsck_refs_options *refs_options UNUSED,
 			   const struct object_id *oid,
 			   enum object_type object_type,
+			   const char *checked_ref_name UNUSED,
 			   enum fsck_msg_type msg_type,
 			   enum fsck_msg_id msg_id UNUSED,
 			   const char *message)
diff --git a/builtin/mktag.c b/builtin/mktag.c
index 76860f4c7c..0779a778e9 100644
--- a/builtin/mktag.c
+++ b/builtin/mktag.c
@@ -17,9 +17,11 @@ static int option_strict = 1;
 
 static struct fsck_objects_options fsck_objects_options = FSCK_OBJECTS_OPTIONS_STRICT;
 
-static int mktag_fsck_error_func(struct fsck_objects_options *o UNUSED,
+static int mktag_fsck_error_func(struct fsck_objects_options *objects_options UNUSED,
+				 struct fsck_refs_options *refs_options UNUSED,
 				 const struct object_id *oid UNUSED,
 				 enum object_type object_type UNUSED,
+				 const char *checked_ref_name UNUSED,
 				 enum fsck_msg_type msg_type,
 				 enum fsck_msg_id msg_id UNUSED,
 				 const char *message)
diff --git a/fsck.c b/fsck.c
index 7ac6e4587c..5184d17736 100644
--- a/fsck.c
+++ b/fsck.c
@@ -230,19 +230,23 @@ static int object_on_skiplist(const struct object_id *oid)
 	return oid && oidset_contains(&fsck_configs.oid_skiplist, oid);
 }
 
-__attribute__((format (printf, 5, 6)))
-static int report(struct fsck_objects_options *options,
-		  const struct object_id *oid, enum object_type object_type,
-		  enum fsck_msg_id msg_id, const char *fmt, ...)
+static int vfsck_report(struct fsck_objects_options *objects_options,
+			struct fsck_refs_options *refs_options,
+			const struct object_id *oid,
+			enum object_type object_type,
+			const char *checked_ref_name,
+			enum fsck_msg_id msg_id, const char *fmt, va_list ap)
 {
-	va_list ap;
+	va_list ap_copy;
 	struct strbuf sb = STRBUF_INIT;
 	struct fsck_options *fsck_options;
 	enum fsck_msg_type msg_type;
 	int result;
 
-	if (options)
-		fsck_options = &options->fsck_options;
+	if (objects_options)
+		fsck_options = &objects_options->fsck_options;
+	else if (refs_options)
+		fsck_options = &refs_options->fsck_options;
 	else
 		BUG("fsck_options is not set");
 
@@ -261,9 +265,10 @@ static int report(struct fsck_objects_options *options,
 	prepare_msg_ids();
 	strbuf_addf(&sb, "%s: ", msg_id_info[msg_id].camelcased);
 
-	va_start(ap, fmt);
-	strbuf_vaddf(&sb, fmt, ap);
-	result = fsck_options->error_func(options, oid, object_type,
+	va_copy(ap_copy, ap);
+	strbuf_vaddf(&sb, fmt, ap_copy);
+	result = fsck_options->error_func(objects_options, NULL,
+					  oid, object_type, checked_ref_name,
 					  msg_type, msg_id, sb.buf);
 	strbuf_release(&sb);
 	va_end(ap);
@@ -271,6 +276,51 @@ static int report(struct fsck_objects_options *options,
 	return result;
 }
 
+__attribute__((format (printf, 5, 6)))
+static int report(struct fsck_objects_options *objects_options,
+		  const struct object_id *oid, enum object_type object_type,
+		  enum fsck_msg_id msg_id, const char *fmt, ...)
+{
+	va_list ap;
+	int result;
+	va_start(ap, fmt);
+	result = vfsck_report(objects_options, NULL, oid, object_type, "",
+			      msg_id, fmt, ap);
+	va_end(ap);
+	return result;
+}
+
+int fsck_report(struct fsck_objects_options *objects_options,
+		struct fsck_refs_options *refs_options,
+		const struct object_id *oid,
+		enum object_type object_type,
+		const char *checked_ref_name,
+		enum fsck_msg_id msg_id, const char *fmt, ...)
+{
+	va_list ap;
+	int result;
+	va_start(ap, fmt);
+	result = vfsck_report(objects_options, refs_options, oid, object_type,
+			      checked_ref_name, msg_id, fmt, ap);
+	va_end(ap);
+	return result;
+
+}
+
+int fsck_refs_report(struct fsck_refs_options *refs_options,
+		     const struct object_id *oid,
+		     const char *checked_ref_name,
+		     enum fsck_msg_id msg_id, const char *fmt, ...)
+{
+	va_list ap;
+	int result;
+	va_start(ap, fmt);
+	result = fsck_report(NULL, refs_options, oid, OBJ_NONE,
+			     checked_ref_name, msg_id, fmt, ap);
+	va_end(ap);
+	return result;
+}
+
 void fsck_enable_object_names(struct fsck_objects_options *options)
 {
 	if (!options->object_names)
@@ -1216,18 +1266,22 @@ int fsck_buffer(const struct object_id *oid, enum object_type type,
 		      type);
 }
 
-int fsck_error_function(struct fsck_objects_options *o,
+int fsck_error_function(struct fsck_objects_options *objects_options,
+			struct fsck_refs_options *refs_options UNUSED,
 			const struct object_id *oid,
 			enum object_type object_type UNUSED,
+			const char *checked_ref_name UNUSED,
 			enum fsck_msg_type msg_type,
 			enum fsck_msg_id msg_id UNUSED,
 			const char *message)
 {
 	if (msg_type == FSCK_WARN) {
-		warning("object %s: %s", fsck_describe_object(o, oid), message);
+		warning("object %s: %s",
+			fsck_describe_object(objects_options, oid), message);
 		return 0;
 	}
-	error("object %s: %s", fsck_describe_object(o, oid), message);
+	error("object %s: %s",
+	      fsck_describe_object(objects_options, oid), message);
 	return 1;
 }
 
@@ -1320,9 +1374,11 @@ int git_fsck_config(const char *var, const char *value,
  * Custom error callbacks that are used in more than one place.
  */
 
-int fsck_error_cb_print_missing_gitmodules(struct fsck_objects_options *o,
+int fsck_error_cb_print_missing_gitmodules(struct fsck_objects_options *objects_options,
+					   struct fsck_refs_options *refs_options,
 					   const struct object_id *oid,
 					   enum object_type object_type,
+					   const char *checked_ref_name,
 					   enum fsck_msg_type msg_type,
 					   enum fsck_msg_id msg_id,
 					   const char *message)
@@ -1331,5 +1387,7 @@ int fsck_error_cb_print_missing_gitmodules(struct fsck_objects_options *o,
 		puts(oid_to_hex(oid));
 		return 0;
 	}
-	return fsck_error_function(o, oid, object_type, msg_type, msg_id, message);
+	return fsck_error_function(objects_options, refs_options,
+				   oid, object_type, checked_ref_name,
+				   msg_type, msg_id, message);
 }
diff --git a/fsck.h b/fsck.h
index a17fee30b4..70d5e78ae6 100644
--- a/fsck.h
+++ b/fsck.h
@@ -93,6 +93,7 @@ enum fsck_msg_id {
 #undef MSG_ID
 
 struct fsck_options;
+struct fsck_refs_options;
 struct fsck_objects_options;
 struct object;
 
@@ -115,19 +116,27 @@ int is_valid_msg_type(const char *msg_id, const char *msg_type);
 typedef int (*fsck_walk_func)(struct object *obj, enum object_type object_type,
 			      void *data, struct fsck_objects_options *options);
 
-/* callback for fsck_object, type is FSCK_ERROR or FSCK_WARN */
-typedef int (*fsck_error)(struct fsck_objects_options *o,
+/*
+ * callback function for reporting errors when checking either objects or refs
+ */
+typedef int (*fsck_error)(struct fsck_objects_options *objects_options,
+			  struct fsck_refs_options *refs_options,
 			  const struct object_id *oid, enum object_type object_type,
+			  const char *checked_ref_name,
 			  enum fsck_msg_type msg_type, enum fsck_msg_id msg_id,
 			  const char *message);
 
-int fsck_error_function(struct fsck_objects_options *o,
+int fsck_error_function(struct fsck_objects_options *objects_options,
+			struct fsck_refs_options *refs_options,
 			const struct object_id *oid, enum object_type object_type,
+			const char *checked_ref_name,
 			enum fsck_msg_type msg_type, enum fsck_msg_id msg_id,
 			const char *message);
-int fsck_error_cb_print_missing_gitmodules(struct fsck_objects_options *o,
+int fsck_error_cb_print_missing_gitmodules(struct fsck_objects_options *objects_options,
+					   struct fsck_refs_options *refs_options,
 					   const struct object_id *oid,
 					   enum object_type object_type,
+					   const char *checked_ref_name,
 					   enum fsck_msg_type msg_type,
 					   enum fsck_msg_id msg_id,
 					   const char *message);
@@ -223,6 +232,28 @@ int fsck_tag_standalone(const struct object_id *oid, const char *buffer,
  */
 int fsck_finish(struct fsck_objects_options *options);
 
+/*
+ * Provide a unified interface for either fscking refs or objects.
+ * It will get the current msg error type and call the error_func callback
+ * which is registered in the "fsck_options" struct. For refs, the caller
+ * should pass NULL for "objs_options". For objects, the caller should pass
+ * NULL for "refs_options".
+ */
+__attribute__((format (printf, 7, 8)))
+int fsck_report(struct fsck_objects_options *objects_options,
+		struct fsck_refs_options *refs_options,
+		const struct object_id *oid,
+		enum object_type object_type,
+		const char *checked_ref_name,
+		enum fsck_msg_id msg_id, const char *fmt, ...);
+
+__attribute__((format (printf, 5, 6)))
+int fsck_refs_report(struct fsck_refs_options *refs_options,
+		     const struct object_id *oid,
+		     const char *checked_ref_name,
+		     enum fsck_msg_id msg_id,
+		     const char *fmt, ...);
+
 /*
  * Subsystem for storing human-readable names for each object.
  *
diff --git a/object-file.c b/object-file.c
index 9eda05ee01..5cb9117fc4 100644
--- a/object-file.c
+++ b/object-file.c
@@ -2472,12 +2472,14 @@ int repo_has_object_file(struct repository *r,
  * report the minimal fsck error here, and rely on the caller to
  * give more context.
  */
-static int hash_format_check_report(struct fsck_objects_options *opts UNUSED,
-				     const struct object_id *oid UNUSED,
-				     enum object_type object_type UNUSED,
-				     enum fsck_msg_type msg_type UNUSED,
-				     enum fsck_msg_id msg_id UNUSED,
-				     const char *message)
+static int hash_format_check_report(struct fsck_objects_options *objects_options UNUSED,
+				    struct fsck_refs_options *refs_options UNUSED,
+				    const struct object_id *oid UNUSED,
+				    enum object_type object_type UNUSED,
+				    const char *chekced_ref_name UNUSED,
+				    enum fsck_msg_type msg_type UNUSED,
+				    enum fsck_msg_id msg_id UNUSED,
+				    const char *message)
 {
 	error(_("object fails fsck: %s"), message);
 	return 1;
-- 
2.45.2

