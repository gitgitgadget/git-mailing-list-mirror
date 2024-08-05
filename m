Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4430413D8A8
	for <git@vger.kernel.org>; Mon,  5 Aug 2024 16:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722876314; cv=none; b=bRySX3UkRCu1weH8r3BGYK+fkIp2GfoGLqpQ+XvpF2PLVu282AdgUD4x7C9gRUHZesGT2Jc5g/kQTIMmLo3MMZcoEmCzpme6jm3ox35NgXBgGXq10epmrCz/yhdgEtXOFm2RIY2sLKq59C+75/rm2wsFmmJb5qolDYi02xhiIyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722876314; c=relaxed/simple;
	bh=psYfKpqXB2eXs/L/bxb7clK+XkwFWUX9iKB8cb5S3ys=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GIlEzC5lZsZhxMgXC78Qmg3SgoB9P4UYx5+63hI/+sQpNkEk+jFhnrhH3PLAORsFeUW3Z5pteW6Qq87W2GgKR7M0DxlUV1v+K4xYQaUT2v7ceaVTCsCOttALIIPqupD7kGQCBFnxbr6eTwEBzN0wGUfmHJfpRzHX0adnEL/LDr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TBHfCkN3; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TBHfCkN3"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-70d19d768c2so8006206b3a.3
        for <git@vger.kernel.org>; Mon, 05 Aug 2024 09:45:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722876312; x=1723481112; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+Hsel6U7BlzkbmKRjoWdla7eaGn2fX2uALHB6F6GIrE=;
        b=TBHfCkN3374Kuidz9FCg/NJZdQHN/+EkVzSYE8Zv8mL2wqtlrcrP9Wt0B5bwQEQLo+
         Mlr+fEJ39rCDloTet6xWO+Xxnmlf1QfQF/Td0skz4zOeeYctJPrOYEi3Idm/OvGjQawO
         lXUIPBYPjESjvBAHnZBzmJQbPEqYdywERnzUflg9sUeCyq5asdujcie6sFceowTFBg84
         MQoigQ+dlX5UAQcTsTMFgjXW4rYPDhVfD6huUGrOBT721KbCNhudtCgxko7ijd6rs16z
         Y2fV1NeGUJvg2mj+edb1QFzbPJl/KSY6pHtsDiTbloOba+8/hHDzvJBkgU8pbo4KLSbZ
         J2Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722876312; x=1723481112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+Hsel6U7BlzkbmKRjoWdla7eaGn2fX2uALHB6F6GIrE=;
        b=rf01J/Sv7dGZNYtKv4M3xzBcnOUOIei5rGQB94wZKVdwqFHMLdpXXndWzwOY+2l4/R
         sWf9XyvewMV0JIRCkm5R36nIYCLqSuI6EUSEVs+2bJjMAO4VHPIgSnxP9dznPk7ndigd
         6sHRMjoQ6r2NK30XWNx9t60xdZR/fa6+psXH2ErQoSCSlVkNnMa2vnVYG8571RjcHSVc
         XaWvHRd17lOkZh5noqZR21duYtumc9019wACkpNqpwS6KXpw8xZ8gQQqU2fVMgJo/DgA
         BsmoPoP3H40HczlivFfPlXQeq/H/NVIvVV5+7/DB89Rxvm8ZCkiaQuZAWFoWPb8tnlqP
         MaDA==
X-Gm-Message-State: AOJu0YxAsTVP9tN4UyD3Kun7yGa0Fu13so6hnsZ+VWHnXL+xHLjgC+zR
	Xn7SvOM04BFyLo2zTUgvZtkVJuxvGx0ZCHnj1WI5IG0O3ZUsd4c3x9KhnA==
X-Google-Smtp-Source: AGHT+IEvY+3a2g+y+liY8zmoWCVo0kM5NNvIvxmBAWWRZdoEBHKWQgbn9PYSQTcuixR0Gk9OPUiTOg==
X-Received: by 2002:aa7:8890:0:b0:710:50c8:ddcb with SMTP id d2e1a72fcca58-7106cf90809mr11104189b3a.5.1722876311838;
        Mon, 05 Aug 2024 09:45:11 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7106ecdfe83sm5589330b3a.122.2024.08.05.09.45.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Aug 2024 09:45:11 -0700 (PDT)
Date: Tue, 6 Aug 2024 00:45:39 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: [GSoC][PATCH v15 3/9] fsck: make "fsck_error" callback generic
Message-ID: <ZrEBsym854FtguPI@ArchLinux>
References: <ZrEBKjzbyxtMdCCx@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZrEBKjzbyxtMdCCx@ArchLinux>

The "fsck_error" callback is designed to report the objects-related
error messages. It accepts two parameter "oid" and "object_type" which
is not generic. In order to provide a unified callback which can report
either objects or refs, remove the objects-related parameters and add
the generic parameter "void *fsck_report".

Create a new "fsck_object_report" structure which incorporates the
removed parameters "oid" and "object_type". Then change the
corresponding references to adapt to new "fsck_error" callback.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Karthik Nayak <karthik.188@gmail.com>
Signed-off-by: shejialuo <shejialuo@gmail.com>
---
 builtin/fsck.c  |  7 +++++--
 builtin/mktag.c |  3 +--
 fsck.c          | 26 ++++++++++++++++----------
 fsck.h          | 17 ++++++++++++-----
 object-file.c   |  9 ++++-----
 5 files changed, 38 insertions(+), 24 deletions(-)

diff --git a/builtin/fsck.c b/builtin/fsck.c
index 6d86bbe1e9..766bbd014d 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -90,12 +90,15 @@ static int objerror(struct object *obj, const char *err)
 }
 
 static int fsck_objects_error_func(struct fsck_options *o UNUSED,
-				   const struct object_id *oid,
-				   enum object_type object_type,
+				   void *fsck_report,
 				   enum fsck_msg_type msg_type,
 				   enum fsck_msg_id msg_id UNUSED,
 				   const char *message)
 {
+	struct fsck_object_report *report = fsck_report;
+	const struct object_id *oid = report->oid;
+	enum object_type object_type = report->object_type;
+
 	switch (msg_type) {
 	case FSCK_WARN:
 		/* TRANSLATORS: e.g. warning in tree 01bfda: <more explanation> */
diff --git a/builtin/mktag.c b/builtin/mktag.c
index 4767f1a97e..c6b644219f 100644
--- a/builtin/mktag.c
+++ b/builtin/mktag.c
@@ -18,8 +18,7 @@ static int option_strict = 1;
 static struct fsck_options fsck_options = FSCK_OPTIONS_STRICT;
 
 static int mktag_fsck_error_func(struct fsck_options *o UNUSED,
-				 const struct object_id *oid UNUSED,
-				 enum object_type object_type UNUSED,
+				 void *fsck_report UNUSED,
 				 enum fsck_msg_type msg_type,
 				 enum fsck_msg_id msg_id UNUSED,
 				 const char *message)
diff --git a/fsck.c b/fsck.c
index 8347842cfb..cca6ae144f 100644
--- a/fsck.c
+++ b/fsck.c
@@ -232,6 +232,10 @@ static int report(struct fsck_options *options,
 		  enum fsck_msg_id msg_id, const char *fmt, ...)
 {
 	va_list ap;
+	struct fsck_object_report report = {
+		.oid = oid,
+		.object_type = object_type
+	};
 	struct strbuf sb = STRBUF_INIT;
 	enum fsck_msg_type msg_type = fsck_msg_type(msg_id, options);
 	int result;
@@ -252,7 +256,7 @@ static int report(struct fsck_options *options,
 
 	va_start(ap, fmt);
 	strbuf_vaddf(&sb, fmt, ap);
-	result = options->error_func(options, oid, object_type,
+	result = options->error_func(options, &report,
 				     msg_type, msg_id, sb.buf);
 	strbuf_release(&sb);
 	va_end(ap);
@@ -1201,12 +1205,14 @@ int fsck_buffer(const struct object_id *oid, enum object_type type,
 }
 
 int fsck_objects_error_function(struct fsck_options *o,
-			const struct object_id *oid,
-			enum object_type object_type UNUSED,
-			enum fsck_msg_type msg_type,
-			enum fsck_msg_id msg_id UNUSED,
-			const char *message)
+				void *fsck_report,
+				enum fsck_msg_type msg_type,
+				enum fsck_msg_id msg_id UNUSED,
+				const char *message)
 {
+	struct fsck_object_report *report = fsck_report;
+	const struct object_id *oid = report->oid;
+
 	if (msg_type == FSCK_WARN) {
 		warning("object %s: %s", fsck_describe_object(o, oid), message);
 		return 0;
@@ -1304,16 +1310,16 @@ int git_fsck_config(const char *var, const char *value,
  */
 
 int fsck_objects_error_cb_print_missing_gitmodules(struct fsck_options *o,
-						   const struct object_id *oid,
-						   enum object_type object_type,
+						   void *fsck_report,
 						   enum fsck_msg_type msg_type,
 						   enum fsck_msg_id msg_id,
 						   const char *message)
 {
 	if (msg_id == FSCK_MSG_GITMODULES_MISSING) {
-		puts(oid_to_hex(oid));
+		struct fsck_object_report *report = fsck_report;
+		puts(oid_to_hex(report->oid));
 		return 0;
 	}
-	return fsck_objects_error_function(o, oid, object_type,
+	return fsck_objects_error_function(o, fsck_report,
 					   msg_type, msg_id, message);
 }
diff --git a/fsck.h b/fsck.h
index 41ebebbb59..3b80d02506 100644
--- a/fsck.h
+++ b/fsck.h
@@ -114,23 +114,30 @@ int is_valid_msg_type(const char *msg_id, const char *msg_type);
 typedef int (*fsck_walk_func)(struct object *obj, enum object_type object_type,
 			      void *data, struct fsck_options *options);
 
-/* callback for fsck_object, type is FSCK_ERROR or FSCK_WARN */
+/*
+ * Callback for reporting errors either for objects or refs. The "fsck_report"
+ * is a generic pointer that can be used to pass any information.
+ */
 typedef int (*fsck_error)(struct fsck_options *o,
-			  const struct object_id *oid, enum object_type object_type,
+			  void *fsck_report,
 			  enum fsck_msg_type msg_type, enum fsck_msg_id msg_id,
 			  const char *message);
 
 int fsck_objects_error_function(struct fsck_options *o,
-				const struct object_id *oid, enum object_type object_type,
+				void *fsck_report,
 				enum fsck_msg_type msg_type, enum fsck_msg_id msg_id,
 				const char *message);
 int fsck_objects_error_cb_print_missing_gitmodules(struct fsck_options *o,
-						   const struct object_id *oid,
-						   enum object_type object_type,
+						   void *fsck_report,
 						   enum fsck_msg_type msg_type,
 						   enum fsck_msg_id msg_id,
 						   const char *message);
 
+struct fsck_object_report {
+	const struct object_id *oid;
+	enum object_type object_type;
+};
+
 struct fsck_options {
 	fsck_walk_func walk;
 	fsck_error error_func;
diff --git a/object-file.c b/object-file.c
index 065103be3e..05ac6ebed6 100644
--- a/object-file.c
+++ b/object-file.c
@@ -2470,11 +2470,10 @@ int repo_has_object_file(struct repository *r,
  * give more context.
  */
 static int hash_format_check_report(struct fsck_options *opts UNUSED,
-				     const struct object_id *oid UNUSED,
-				     enum object_type object_type UNUSED,
-				     enum fsck_msg_type msg_type UNUSED,
-				     enum fsck_msg_id msg_id UNUSED,
-				     const char *message)
+				    void *fsck_report UNUSED,
+				    enum fsck_msg_type msg_type UNUSED,
+				    enum fsck_msg_id msg_id UNUSED,
+				    const char *message)
 {
 	error(_("object fails fsck: %s"), message);
 	return 1;
-- 
2.46.0

