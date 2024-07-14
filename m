Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 222331FDD
	for <git@vger.kernel.org>; Sun, 14 Jul 2024 12:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720960273; cv=none; b=P4HykM/RXrKwlBLdnhficTge6+lonrxuzp0J9Y+zW4KSfiKlZ/w8AidL83Q0vku9b6IY7rR+/cC4aOgS48HAsAxpTX9El0DyXS7ibTdjhwPAAIqeLIOWQokICykm4MDXLXv4G3zDUnqFveVFgdAqr5TZalsbYlZlO6k3D5Gpikw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720960273; c=relaxed/simple;
	bh=S3EQ2wKKD/ps9kONyyiFhUrB9IDZ53zjMNvGg7ojQDc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RdSLrILi2Vu2R53BCjG6PQ3SqsTwYRqMhRwCjLoODsdwFgQMqXPXvH1MoSbr8cTOnUbE8YEji0/LYsMkAhyqXYOEiBNYSVjvtzslbTPk5baYDg9h2LXNzLegbRCdWZqpTbL+LhueTn3+YEe2nQknzKG1GeAdTBPWCwpOIUMzk1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ibUgZ4s0; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ibUgZ4s0"
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3c9cc681ee0so1977314b6e.0
        for <git@vger.kernel.org>; Sun, 14 Jul 2024 05:31:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720960270; x=1721565070; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Seoqvdll4X7hFWS8fDEbdt/icnhk0Fij2yQ8eCCM4ak=;
        b=ibUgZ4s0C5vBJqos2Lg0gdZ6F9XvUyQhxfz3mdDzXHQ7RcixBY9HL4siidPcfuQDUW
         MD7aExh1X078H0KIjU++hD6qgc2fS0cNBKMxMaar8UK9a2i5ogzxMpWhXPzzOKFwqndx
         ngEU/f6O7IgIIm2Bp7cO2Ho+zFLx657YcEXuGHc+Hd92XJqBFaUdeX1HmZRjLtZSPK9V
         5jCPwtoahgEHg4AAhyr4zFQCxditvF4BIToUBuT1Y5hxGF0yiiWQbXeBU7K+IuU7e8i/
         BcJ28y9F8IwfawMavcNYf4v9Vlel0WSzfvSEl86XUKKpsS7ZNQATsMXSkt2GhOLa+U4A
         Lf3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720960270; x=1721565070;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Seoqvdll4X7hFWS8fDEbdt/icnhk0Fij2yQ8eCCM4ak=;
        b=nDrNodIMhJwoAlEWr43e8HXrU1UPW2LXt80xMZwYKcW52PT1nVBtO4Xe7mk6ktkTbt
         rXARs1dbCfjYKj4fZ62F+ILctzmtXIcfrdZ14/ADBl+x51gD+x85ZEUhUwDkaZwa9Cmg
         icSpYEM+3IZTYAWEimIFg2hdmdSO2a9mpWHX4b5MRaWDpfFEcdSmqkgSGy1cs7gW9aW+
         vkczYEG6SejBh0qR7wlhfhkY1bxZYestzaUbLuX7m+VPLwf0HzJpDIXdda1Dt/2e+pCK
         65DMzal9DnfLdsTlBZwiQ7+OR6uaykI5IUMIXjLybFaBsGeTnzasiIQlx7TuMI1L6Tcr
         AP1Q==
X-Gm-Message-State: AOJu0YxxJcHvRW1ZuaKjvSf8aP3oruyZDXF4k3HW2Q3wJFFWuu5utEyJ
	/kRWPWGxBdGdRb0js+50vsTE+AnolBNJ/jsJnex/iBxSAKfstO3gPYTxyQ==
X-Google-Smtp-Source: AGHT+IGkpomIIqWqB04UshpUuw+CAOKsdRQEEwGG/cObmfrGYiZt325uNA2KW3VPyb2Sp3f3zGsHPw==
X-Received: by 2002:a05:6808:1a2a:b0:3d5:6413:2138 with SMTP id 5614622812f47-3d93c038456mr19841140b6e.12.1720960270001;
        Sun, 14 Jul 2024 05:31:10 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b7ecc947fsm2538069b3a.195.2024.07.14.05.31.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jul 2024 05:31:09 -0700 (PDT)
Date: Sun, 14 Jul 2024 20:31:14 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: [GSoC][PATCH v11 02/10] fsck: add a unified interface for reporting
 fsck messages
Message-ID: <ZpPFElAYLVtRlq-e@ArchLinux>
References: <ZpPEdmUN1Z5tqbK3@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZpPEdmUN1Z5tqbK3@ArchLinux>

The static function "report" provided by "fsck.c" aims at checking fsck
error type and calling the callback "error_func" to report the message.
However, "report" function is only related to object database which
cannot be reused for refs. In order to provide a unified interface which
can report either objects or refs, create a new function "fsck_vreport"
following the "report" prototype. Instead of using "...", provide
"va_list" to allow more flexibility.

When checking loose refs and reflogs, we only need to pass the checked
name to the fsck error report function. However, for packed-refs and
reftable refs, we need to check both the consistency of the file itself
and the refs or reflogs contained in the file. In order to provide above
checks, add two parameters "ref_checkee" and "sub_ref_checkee" in
"fsck_vreport" function.

Like "report", the "fsck_vreport" function will use "error_func"
registered in "fsck_options" to report customized messages. Change
"error_func" prototype to align with the new "fsck_vreport".

Then, change "report" function to use "fsck_vreport" to report objects
related messages. Add a new function called "fsck_refs_report" to use
"fsck_vreport" to report refs related messages.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Karthik Nayak <karthik.188@gmail.com>
Signed-off-by: shejialuo <shejialuo@gmail.com>
---
 builtin/fsck.c  |  2 ++
 builtin/mktag.c |  2 ++
 fsck.c          | 60 ++++++++++++++++++++++++++++++++++++++++++-------
 fsck.h          | 19 +++++++++++++++-
 object-file.c   | 12 +++++-----
 5 files changed, 81 insertions(+), 14 deletions(-)

diff --git a/builtin/fsck.c b/builtin/fsck.c
index d13a226c2e..8aeb8b17e2 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -92,6 +92,8 @@ static int objerror(struct object *obj, const char *err)
 static int fsck_error_func(struct fsck_options *o UNUSED,
 			   const struct object_id *oid,
 			   enum object_type object_type,
+			   const char *ref_checkee UNUSED,
+			   const char *sub_ref_checkee UNUSED,
 			   enum fsck_msg_type msg_type,
 			   enum fsck_msg_id msg_id UNUSED,
 			   const char *message)
diff --git a/builtin/mktag.c b/builtin/mktag.c
index 4767f1a97e..b5f9e108e5 100644
--- a/builtin/mktag.c
+++ b/builtin/mktag.c
@@ -20,6 +20,8 @@ static struct fsck_options fsck_options = FSCK_OPTIONS_STRICT;
 static int mktag_fsck_error_func(struct fsck_options *o UNUSED,
 				 const struct object_id *oid UNUSED,
 				 enum object_type object_type UNUSED,
+				 const char *ref_checkee UNUSED,
+				 const char *sub_ref_checkee UNUSED,
 				 enum fsck_msg_type msg_type,
 				 enum fsck_msg_id msg_id UNUSED,
 				 const char *message)
diff --git a/fsck.c b/fsck.c
index 3f32441492..7fceecdfae 100644
--- a/fsck.c
+++ b/fsck.c
@@ -226,12 +226,19 @@ static int object_on_skiplist(struct fsck_options *opts,
 	return opts && oid && oidset_contains(&opts->skip_oids, oid);
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
+static int fsck_vreport(struct fsck_options *options,
+			const struct object_id *oid,
+			enum object_type object_type,
+			const char *ref_checkee,
+			const char *sub_ref_checkee,
+			enum fsck_msg_id msg_id, const char *fmt, va_list ap)
 {
-	va_list ap;
+	va_list ap_copy;
 	struct strbuf sb = STRBUF_INIT;
 	enum fsck_msg_type msg_type = fsck_msg_type(msg_id, options);
 	int result;
@@ -250,9 +257,10 @@ static int report(struct fsck_options *options,
 	prepare_msg_ids();
 	strbuf_addf(&sb, "%s: ", msg_id_info[msg_id].camelcased);
 
-	va_start(ap, fmt);
-	strbuf_vaddf(&sb, fmt, ap);
+	va_copy(ap_copy, ap);
+	strbuf_vaddf(&sb, fmt, ap_copy);
 	result = options->error_func(options, oid, object_type,
+				     ref_checkee, sub_ref_checkee,
 				     msg_type, msg_id, sb.buf);
 	strbuf_release(&sb);
 	va_end(ap);
@@ -260,6 +268,37 @@ static int report(struct fsck_options *options,
 	return result;
 }
 
+__attribute__((format (printf, 5, 6)))
+static int report(struct fsck_options *options,
+		  const struct object_id *oid, enum object_type object_type,
+		  enum fsck_msg_id msg_id, const char *fmt, ...)
+{
+	va_list ap;
+	int result;
+
+	va_start(ap, fmt);
+	result = fsck_vreport(options, oid, object_type, NULL, NULL,
+			      msg_id, fmt, ap);
+	va_end(ap);
+
+	return result;
+}
+
+int fsck_refs_report(struct fsck_options *options,
+		     const struct object_id *oid,
+		     const char *ref_checkee,
+		     const char *sub_ref_checkee,
+		     enum fsck_msg_id msg_id, const char *fmt, ...)
+{
+	va_list ap;
+	int result;
+	va_start(ap, fmt);
+	result = fsck_vreport(options, oid, OBJ_NONE, ref_checkee, sub_ref_checkee,
+			      msg_id, fmt, ap);
+	va_end(ap);
+	return result;
+}
+
 void fsck_enable_object_names(struct fsck_options *options)
 {
 	if (!options->object_names)
@@ -1203,6 +1242,8 @@ int fsck_buffer(const struct object_id *oid, enum object_type type,
 int fsck_error_function(struct fsck_options *o,
 			const struct object_id *oid,
 			enum object_type object_type UNUSED,
+			const char *ref_checkee UNUSED,
+			const char *sub_ref_checkee UNUSED,
 			enum fsck_msg_type msg_type,
 			enum fsck_msg_id msg_id UNUSED,
 			const char *message)
@@ -1306,6 +1347,8 @@ int git_fsck_config(const char *var, const char *value,
 int fsck_error_cb_print_missing_gitmodules(struct fsck_options *o,
 					   const struct object_id *oid,
 					   enum object_type object_type,
+					   const char *ref_checkee,
+					   const char *sub_ref_checkee,
 					   enum fsck_msg_type msg_type,
 					   enum fsck_msg_id msg_id,
 					   const char *message)
@@ -1314,5 +1357,6 @@ int fsck_error_cb_print_missing_gitmodules(struct fsck_options *o,
 		puts(oid_to_hex(oid));
 		return 0;
 	}
-	return fsck_error_function(o, oid, object_type, msg_type, msg_id, message);
+	return fsck_error_function(o, oid, object_type, ref_checkee,
+				   sub_ref_checkee, msg_type, msg_id, message);
 }
diff --git a/fsck.h b/fsck.h
index bcfb2e34cd..61ca38afd6 100644
--- a/fsck.h
+++ b/fsck.h
@@ -114,19 +114,25 @@ int is_valid_msg_type(const char *msg_id, const char *msg_type);
 typedef int (*fsck_walk_func)(struct object *obj, enum object_type object_type,
 			      void *data, struct fsck_options *options);
 
-/* callback for fsck_object, type is FSCK_ERROR or FSCK_WARN */
+/*
+ * callback function for reporting errors when checking either objects or refs
+ */
 typedef int (*fsck_error)(struct fsck_options *o,
 			  const struct object_id *oid, enum object_type object_type,
+			  const char *ref_checkee, const char *sub_ref_checkee,
 			  enum fsck_msg_type msg_type, enum fsck_msg_id msg_id,
 			  const char *message);
 
 int fsck_error_function(struct fsck_options *o,
 			const struct object_id *oid, enum object_type object_type,
+			const char *ref_checkee, const char *sub_ref_checkee,
 			enum fsck_msg_type msg_type, enum fsck_msg_id msg_id,
 			const char *message);
 int fsck_error_cb_print_missing_gitmodules(struct fsck_options *o,
 					   const struct object_id *oid,
 					   enum object_type object_type,
+					   const char *ref_checkee,
+					   const char *sub_ref_checkee,
 					   enum fsck_msg_type msg_type,
 					   enum fsck_msg_id msg_id,
 					   const char *message);
@@ -209,6 +215,17 @@ int fsck_tag_standalone(const struct object_id *oid, const char *buffer,
  */
 int fsck_finish(struct fsck_options *options);
 
+/*
+ * Report an error or warning for refs.
+ */
+__attribute__((format (printf, 6, 7)))
+int fsck_refs_report(struct fsck_options *options,
+		     const struct object_id *oid,
+		     const char *ref_checkee,
+		     const char *sub_ref_checkee,
+		     enum fsck_msg_id msg_id,
+		     const char *fmt, ...);
+
 /*
  * Subsystem for storing human-readable names for each object.
  *
diff --git a/object-file.c b/object-file.c
index 065103be3e..bc63b80c48 100644
--- a/object-file.c
+++ b/object-file.c
@@ -2470,11 +2470,13 @@ int repo_has_object_file(struct repository *r,
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
+				    const char *ref_checkee UNUSED,
+				    const char *sub_ref_checkee UNUSED,
+				    enum fsck_msg_type msg_type UNUSED,
+				    enum fsck_msg_id msg_id UNUSED,
+				    const char *message)
 {
 	error(_("object fails fsck: %s"), message);
 	return 1;
-- 
2.45.2

