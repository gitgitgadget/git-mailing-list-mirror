Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9240B40847
	for <git@vger.kernel.org>; Sat, 20 Jul 2024 09:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721467650; cv=none; b=UKe3vp7Ya1OgBH94o37NloPaFJT3+V7arF9xrJGvNH1y9Ym0cruB7gkrH+YZqPfM193ELSs/CZ05xuWMnM0djD9hhPkKx2I6pADZ0i5D6slvEMsr7EgqI+2wXBWxIu1PPnPIg6USQa/70nVtD6o8eli4RZWCGgeOTmo0Owkf3W0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721467650; c=relaxed/simple;
	bh=2K43dd5rEmasNVcu6xwJS3VCgAha6jgNXgCFk9fBt5Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t9Wn4wNPGo/D+NQ7yUHhJ2Yqy5YI1QOXag7UW6Lrjkl13EJOsgEk2oc3hm8Tx39etG06mnfcTy7WvopdS2C1/gAkPjybLEiftOPp8tbuJp6SV29BMOXmQq3QkWjiy23lGHgL00AOOeWJvrhjyizFs+JqDOi9/jiwuuL80v5XEhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dUk7THXI; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dUk7THXI"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1fc5549788eso22541835ad.1
        for <git@vger.kernel.org>; Sat, 20 Jul 2024 02:27:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721467647; x=1722072447; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wA7QKi1pRPqFmkz/Qq7E1tMSFQtE6VXXKSSfcRH62ew=;
        b=dUk7THXImINIWifmXFSIWzNM1CWJ3TIIZaKxjuwWIRYDDdkZkMex9niwv0jinkAiz8
         Otcu+NE6qKlrIEddOkihlWPWYPvGknByDJMWne2Xd9PmVMDfWvgc1BlAPwdlMRl9Ca2F
         jdUl6OuiEoZb7uk9p3RoBKmFNpQ8kp2ov/2EAS60SwIGmPJsfUKk9v1hYH5AQVp+h5OL
         aMnSEc4bOhKvyqOh9SGuYu3yJY6mdmT1Ky4rncZKvA6h8sLFZlNvKgg/MkctJPUnERyw
         SnvW3KdCVNbDdoLlY39CPjzHJ+Qrwhyo6Rnk/7gM+nYiHXf7HxB/8cnwgh1lI/Ij6idC
         0IZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721467647; x=1722072447;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wA7QKi1pRPqFmkz/Qq7E1tMSFQtE6VXXKSSfcRH62ew=;
        b=eLg4Z3CdNWp+h79rLmfYTDcie372JFz5HX9oVaGwZhcMI5zGI+8VQYFkfzzK+YIAI8
         nPQ3Jumou1AWxHx9Adlhu3Czv1VZTk5HBqZTyRY1+leMoDj20WPFlirIEhOdWEIKJp2R
         XUTjXhwKC7Q5NEDLQDolkKHC2wKFZpfBKliD7zbkahBfYYYbkVJEujnpD1beIaL0TubU
         l0XYnpMUJFuvzkLljztWenBNiLGGReFu67bJnK4Oc8+4ayUjetKtxCF2WM5/1TwwfCMR
         WoCtoVuRYQLosT6Bzp3U8xOi/bZ/iB2wqsiwvGhC4mumO1Pnsmw/Z78zc0vbLgy7d6/E
         CsyQ==
X-Gm-Message-State: AOJu0YxuBoUWfqvfz3UjE7FO8mBozXL64pbpeGDD/rsksxheuKL6XWrB
	P/Xq7RE9wfOXVpi+0UVkHLryf2BzpAjReJE/2kdO2ktbInL3ffarzOEV2g==
X-Google-Smtp-Source: AGHT+IEkjtyW+8BkFaacKJdMywWMiqVyUrWuniGKuXKcd+Xn/t/RusJWqyF2qUxBkp8v1wqLoRj0Yw==
X-Received: by 2002:a17:902:d489:b0:1fd:7c8a:be3e with SMTP id d9443c01a7336-1fd7c8ad873mr9654535ad.36.1721467647272;
        Sat, 20 Jul 2024 02:27:27 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fd6f4548ffsm17999135ad.236.2024.07.20.02.27.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Jul 2024 02:27:26 -0700 (PDT)
Date: Sat, 20 Jul 2024 17:27:37 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: [GSoC][PATCH v12 02/10] fsck: add a unified interface for reporting
 fsck messages
Message-ID: <ZpuDCc8SZx8e4mLP@ArchLinux>
References: <ZpuCg1GL1YE_sJBP@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZpuCg1GL1YE_sJBP@ArchLinux>

The static function "report" provided by "fsck.c" aims at checking fsck
error type and calling the callback "error_func" to report the message.
However, "report" function is only related to object database which
cannot be reused for refs. In order to provide a unified interface which
can report either objects or refs, create a new function "fsck_vreport"
following the "report" prototype. Instead of using "...", provide
"va_list" to allow more flexibility.

In order to provide an extensible error report for refs, add a new
"fsck_refs_info" structure to incorporate an union for supporting
different checks for files backend and reftable backend. Then
incorporate this structure into the "fsck_options" to reuse the
"error_func" callback.

Then, change "report" function to use "fsck_vreport" to report objects
related messages. Add a new function called "fsck_refs_report" to use
"fsck_vreport" to report refs related messages.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Karthik Nayak <karthik.188@gmail.com>
Signed-off-by: shejialuo <shejialuo@gmail.com>
---
 fsck.c | 46 +++++++++++++++++++++++++++++++++++++++-------
 fsck.h | 26 +++++++++++++++++++++++++-
 2 files changed, 64 insertions(+), 8 deletions(-)

diff --git a/fsck.c b/fsck.c
index 3f32441492..f2417e65fd 100644
--- a/fsck.c
+++ b/fsck.c
@@ -226,12 +226,17 @@ static int object_on_skiplist(struct fsck_options *opts,
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
+			enum fsck_msg_id msg_id, const char *fmt, va_list ap)
 {
-	va_list ap;
+	va_list ap_copy;
 	struct strbuf sb = STRBUF_INIT;
 	enum fsck_msg_type msg_type = fsck_msg_type(msg_id, options);
 	int result;
@@ -250,8 +255,8 @@ static int report(struct fsck_options *options,
 	prepare_msg_ids();
 	strbuf_addf(&sb, "%s: ", msg_id_info[msg_id].camelcased);
 
-	va_start(ap, fmt);
-	strbuf_vaddf(&sb, fmt, ap);
+	va_copy(ap_copy, ap);
+	strbuf_vaddf(&sb, fmt, ap_copy);
 	result = options->error_func(options, oid, object_type,
 				     msg_type, msg_id, sb.buf);
 	strbuf_release(&sb);
@@ -260,6 +265,33 @@ static int report(struct fsck_options *options,
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
+	result = fsck_vreport(options, oid, object_type, msg_id, fmt, ap);
+	va_end(ap);
+
+	return result;
+}
+
+int fsck_refs_report(struct fsck_options *options,
+		     const struct object_id *oid,
+		     enum fsck_msg_id msg_id, const char *fmt, ...)
+{
+	va_list ap;
+	int result;
+	va_start(ap, fmt);
+	result = fsck_vreport(options, oid, OBJ_NONE, msg_id, fmt, ap);
+	va_end(ap);
+	return result;
+}
+
 void fsck_enable_object_names(struct fsck_options *options)
 {
 	if (!options->object_names)
diff --git a/fsck.h b/fsck.h
index bcfb2e34cd..a2ecb39b51 100644
--- a/fsck.h
+++ b/fsck.h
@@ -114,7 +114,9 @@ int is_valid_msg_type(const char *msg_id, const char *msg_type);
 typedef int (*fsck_walk_func)(struct object *obj, enum object_type object_type,
 			      void *data, struct fsck_options *options);
 
-/* callback for fsck_object, type is FSCK_ERROR or FSCK_WARN */
+/*
+ * callback function for reporting errors when checking either objects or refs
+ */
 typedef int (*fsck_error)(struct fsck_options *o,
 			  const struct object_id *oid, enum object_type object_type,
 			  enum fsck_msg_type msg_type, enum fsck_msg_id msg_id,
@@ -131,11 +133,24 @@ int fsck_error_cb_print_missing_gitmodules(struct fsck_options *o,
 					   enum fsck_msg_id msg_id,
 					   const char *message);
 
+/*
+ * The information for reporting refs-related error message
+ */
+struct fsck_refs_info {
+	char *ref_checkee;
+	union {
+		struct {
+			char *sub_ref_checkee;
+		} files;
+	} u;
+};
+
 struct fsck_options {
 	fsck_walk_func walk;
 	fsck_error error_func;
 	unsigned strict:1;
 	enum fsck_msg_type *msg_type;
+	struct fsck_refs_info refs_info;
 	struct oidset skip_oids;
 	struct oidset gitmodules_found;
 	struct oidset gitmodules_done;
@@ -209,6 +224,15 @@ int fsck_tag_standalone(const struct object_id *oid, const char *buffer,
  */
 int fsck_finish(struct fsck_options *options);
 
+/*
+ * Report an error or warning for refs.
+ */
+__attribute__((format (printf, 4, 5)))
+int fsck_refs_report(struct fsck_options *options,
+		     const struct object_id *oid,
+		     enum fsck_msg_id msg_id,
+		     const char *fmt, ...);
+
 /*
  * Subsystem for storing human-readable names for each object.
  *
-- 
2.45.2

