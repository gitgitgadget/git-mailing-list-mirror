Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BDF5149C54
	for <git@vger.kernel.org>; Thu,  8 Aug 2024 11:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723116380; cv=none; b=d3ny3siTueWCkA84xKxx7DcZQNt/Kn1GOz4lo2TnLxBJdwUuT4zvI5XN7iSLo9cYJD2yq8BlUMxZ/vWaU6gAR2YlfGTpq34FAM2Oqq1jB2pFUY2Dis5K4+XppgmI95nV+0zzLbfCfM1wJ8VSldK7wnSyUtWhM7OAVfhX4yqFjV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723116380; c=relaxed/simple;
	bh=psYfKpqXB2eXs/L/bxb7clK+XkwFWUX9iKB8cb5S3ys=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eJq4knTyXK2N9y+kXcNP5D4dzjfybEcyn9QuiRFddvW1aP5/WCsZ9Gga3enpWTQcZfLry3nqMs+QJ8R7H4g03wSYzzy3skdGTkZe/nTR4W6zwU1JHYG2P7jdJCU7pVeITOLtGewAJai4L2tgbuBI8MM/jUo+H4caS9SK5QQjbpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VnYsypFA; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VnYsypFA"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-710d0995e21so136008b3a.1
        for <git@vger.kernel.org>; Thu, 08 Aug 2024 04:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723116378; x=1723721178; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+Hsel6U7BlzkbmKRjoWdla7eaGn2fX2uALHB6F6GIrE=;
        b=VnYsypFAuG6x0eaEDELLeMXQdecv58ScGBSEKDlSlQ2UyK8fKsPA8XefdA5GubXfZU
         sQQuNGuDLNIfmots/hOeU+f+8U500TLi7SHNsLIJBMQiekAsrfNMqqFneLSJTL2OylGF
         5Ylkv52MgplW0ezxJk7PTVqfwzvxPhvAC7w/+SitRCKYip+0dfOT8FHHmljQIAEgXCLh
         KKCosnEUP1N+IFVo9nRsqUXucmW+yUZ/+Wrrr+ljGYwraPHrtMv+sG5T3akuWThNjxls
         AZGjsYRU50bl+xmvxyWAp2+thgWQiMFxBzKS7TVT24QnK+QN1ygKV8ldumP6QX/N8lbR
         gyuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723116378; x=1723721178;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+Hsel6U7BlzkbmKRjoWdla7eaGn2fX2uALHB6F6GIrE=;
        b=ZZ9FYl33luKfHgWvYPjVAvG1N6DB8iMoxmanX+qbRir3K/xNZiPV1z7I5DXcWP//6r
         Ib2ap1ql8bpKxEFZL42DoMqjW5/Nq/OpojXD2O018wOo3VSqpU+s2v1THXS1l3KM5d3j
         6XsgNex0dO4DXefjxJj5sSfJf1FoCjEfj8WjgVJ8r/HPS+lohw6Kw+NBX2HLmLk+WeJL
         iPk3QyyASHsDnZy7V1LvhhQ09t/itZayTLabF67ZzHYv2AUoLasOpnjtkEc9yjgahgUr
         VC9au1xwnAI9J2/ZNKmvhMKqroehN/zfXROwaVAhHPt8XUEdb+L+7zJpWxfcSmdH/YYd
         G2lg==
X-Gm-Message-State: AOJu0YxdPOWyLezeO/GRTBj/WFNCeK0RuFvSf0zb/nvDtrpw8EQhLzfX
	w1rpG/gcLPN7sDUu67cnaYbKx3vKedt3fx3UtmHOzFLrUMYLAxJDV+qZS4W5JBM=
X-Google-Smtp-Source: AGHT+IHD1dGUKaOT1dgpYKMuL2Dr73cj6ds4Cj7UC0XM6noih405wjHis4l5BHcaFZ4+mLJNHW4+xA==
X-Received: by 2002:a05:6a20:24a5:b0:1c2:5fa8:2de2 with SMTP id adf61e73a8af0-1c6fce7901cmr1332119637.10.1723116377906;
        Thu, 08 Aug 2024 04:26:17 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d1b3b59ff2sm3196075a91.49.2024.08.08.04.26.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Aug 2024 04:26:17 -0700 (PDT)
Date: Thu, 8 Aug 2024 19:26:47 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: [GSoC][PATCH v16 3/9] fsck: make "fsck_error" callback generic
Message-ID: <ZrSrdwOCWrXpMYIA@ArchLinux>
References: <ZrSqMmD-quQ18a9F@ArchLinux.localdomain>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZrSqMmD-quQ18a9F@ArchLinux.localdomain>

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

