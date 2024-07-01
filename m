Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5198C16CD1A
	for <git@vger.kernel.org>; Mon,  1 Jul 2024 15:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719847190; cv=none; b=fLaShz0xO57eyrEro2C9dNoPjXnpzxrNFTHBgJx6o57lzgHrg2i4Q97mT1RBk36zfxazPkJJKGD0WB9vV8iCmQyV06uY5SQKM1aWP7jLiTO3L7OWgylV94Xn0P+pR1Vs0ZE4jYkb32oEvIiU1Py56Vp10e4AKo8G0y+kIS7MbXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719847190; c=relaxed/simple;
	bh=BC4WA+tPwl9oS1bBchJ2+WRcWp9izVr2vtdCx4yUBiI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AHfAj4SqlZuLBdnPv0JALRr9Ci+m11AJWFLlEdE3qpP++VSaErL/my6e07Iw4/T1iaEpxHWlQ4y2d3M0CDKiWIz5rIFPPo5UFQClBSmiiz4t65cFbehJEqdAZfpMOU3KudtSnj1ozkl8Rd0hCynoxpKxlc5BN7Mgfll7h4KmwXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TPmBsPqs; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TPmBsPqs"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-710437d0affso1663071a12.3
        for <git@vger.kernel.org>; Mon, 01 Jul 2024 08:19:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719847187; x=1720451987; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MIjXo17y2I60tynB0XPFRXKG2SwN0ybS3ex43NXPyQQ=;
        b=TPmBsPqsRlp9gmG8lreTAY1glEeuy/D8tX8/0gBZKjyZBN8P2A9tSPSRA6EUEnaB2y
         f02/p82TIFOogAzqg2OP7eysD+36VLok64GPZvAglNe3P+BC6lnOvGA40AYxWJVTd7IG
         Wzd5j8lo21wJUwWLhSWrSusG9F1RgFYQnxZ71vwoZ2aP8rVIkEnW/8T+Rq0KR8MRgwva
         u9ptVl4aad764y2r4C+0uzvPj7RFqWtcychgM6ASuOYnIipVPXYh3nFmYV+AUfuAkDPc
         IkMOBd7bm552PxPA7CWIi4SFpf1DGDeTtWdCQwg/cMpLFSJqx1XowCJsV9xC1z0E7K2h
         RGYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719847187; x=1720451987;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MIjXo17y2I60tynB0XPFRXKG2SwN0ybS3ex43NXPyQQ=;
        b=rD1Hka57SSfi0okJsYAh9k/1sxzMEKpsUZ3/yYDrNaPqqV7zdGGVe02buXB7zk58Mu
         /cayj/JxLspSAyUTKP2wVaoU9jQCl9S4RfLACSapzmeZzHrQz3xyRXRbNiKf1TTdLjVi
         zcVZTgvToVH0UNIfTA5gHoZLbq5bse3j9MZmIkDseOQ0Qem+YLmfBiknxGJ8FhUa+6qc
         jsCDraxwYqLfaG7Hx7W0jS9WEJUzZp4p0Rzf0f7sz/6X5i7qLrku8r1pbCG2Gar4Nn39
         KTpv+ckt9265gNRSrBCfoj4b6extFmWlZZZMMcWEoxOKPIKx/3OPE5uMf1eEAW5jZeDM
         EW+w==
X-Gm-Message-State: AOJu0Yxi8LywMI0Nt8xVQ6vjVB/XAuAvNUuTPeOsJcaXwsENgKMEnugH
	ALmNTYUxeqYl/XiJiPrEUSa0/iqIaVaGimhu6baig6DN+VFJDD1TmY6zvw==
X-Google-Smtp-Source: AGHT+IFdjtSiACX3puVY4tO84RDdIjdvKthBup+cV7mVc327w4ZS77Eoy+PXStrZ8xeiWVMK1+mhbA==
X-Received: by 2002:a05:6a21:999e:b0:1be:c42f:be42 with SMTP id adf61e73a8af0-1bef61019f4mr5917217637.19.1719847185412;
        Mon, 01 Jul 2024 08:19:45 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fac1538e49sm66118855ad.145.2024.07.01.08.19.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jul 2024 08:19:44 -0700 (PDT)
Date: Mon, 1 Jul 2024 23:19:42 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [GSoC][PATCH v6 04/11] fsck: add a unified interface for reporting
 fsck messages
Message-ID: <ZoLJDoY6BiHW6ul1@ArchLinux>
References: <ZoLHtmOKTfxMSxvw@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZoLHtmOKTfxMSxvw@ArchLinux>

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
 fsck.h          | 40 +++++++++++++++---------
 object-file.c   | 11 ++++---
 5 files changed, 101 insertions(+), 47 deletions(-)

diff --git a/builtin/fsck.c b/builtin/fsck.c
index 13b64f723f..cdf2218dfd 100644
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
 
 	fsck_walk_options.objects_options.walk = mark_object;
 	fsck_obj_options.objects_options.walk = mark_used;
-	fsck_obj_options.error_func = fsck_error_func;
+	fsck_obj_options.error_func = fsck_objects_error_func;
 	if (check_strict)
 		fsck_obj_options.strict = 1;
 
diff --git a/builtin/mktag.c b/builtin/mktag.c
index c6fbeb58d4..d8e4b91134 100644
--- a/builtin/mktag.c
+++ b/builtin/mktag.c
@@ -20,6 +20,7 @@ static struct fsck_options fsck_options = FSCK_OBJECTS_OPTIONS_STRICT;
 static int mktag_fsck_error_func(struct fsck_options *o UNUSED,
 				 const struct object_id *oid UNUSED,
 				 enum object_type object_type UNUSED,
+				 const char *checked_ref_name UNUSED,
 				 enum fsck_msg_type msg_type,
 				 enum fsck_msg_id msg_id UNUSED,
 				 const char *message)
diff --git a/fsck.c b/fsck.c
index 04d0aa1766..31ae8d57ce 100644
--- a/fsck.c
+++ b/fsck.c
@@ -223,12 +223,18 @@ static int object_on_skiplist(struct fsck_options *opts,
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
@@ -247,9 +253,9 @@ static int report(struct fsck_options *options,
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
@@ -257,6 +263,36 @@ static int report(struct fsck_options *options,
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
 	if (!options->objects_options.object_names)
@@ -1199,12 +1235,13 @@ int fsck_buffer(const struct object_id *oid, enum object_type type,
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
@@ -1305,16 +1342,18 @@ int git_fsck_config(const char *var, const char *value,
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
index ff7281b410..e611b3b65b 100644
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
 
 struct fsck_refs_options {
 	unsigned verbose:1;
@@ -155,7 +160,7 @@ struct fsck_options {
 
 #define FSCK_OBJECTS_OPTIONS_DEFAULT { \
 	.oid_skiplist = OIDSET_INIT, \
-	.error_func = fsck_error_function, \
+	.error_func = fsck_objects_error_function, \
 	.objects_options = { \
 		.gitmodules_found = OIDSET_INIT, \
 		.gitmodules_done = OIDSET_INIT, \
@@ -165,7 +170,7 @@ struct fsck_options {
 }
 #define FSCK_OBJECTS_OPTIONS_STRICT { \
 	.strict = 1, \
-	.error_func = fsck_error_function, \
+	.error_func = fsck_objects_error_function, \
 	.objects_options = { \
 		.gitmodules_found = OIDSET_INIT, \
 		.gitmodules_done = OIDSET_INIT, \
@@ -175,7 +180,7 @@ struct fsck_options {
 }
 #define FSCK_OBJECTS_OPTIONS_MISSING_GITMODULES { \
 	.strict = 1, \
-	.error_func = fsck_error_cb_print_missing_gitmodules, \
+	.error_func = fsck_objects_error_cb_print_missing_gitmodules, \
 	.objects_options = { \
 		.gitmodules_found = OIDSET_INIT, \
 		.gitmodules_done = OIDSET_INIT, \
@@ -224,6 +229,13 @@ int fsck_tag_standalone(const struct object_id *oid, const char *buffer,
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
index 4e10dd9804..a681087625 100644
--- a/object-file.c
+++ b/object-file.c
@@ -2473,11 +2473,12 @@ int repo_has_object_file(struct repository *r,
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

