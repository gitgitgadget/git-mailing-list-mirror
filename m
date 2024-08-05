Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6C083E479
	for <git@vger.kernel.org>; Mon,  5 Aug 2024 16:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722876301; cv=none; b=IJ1lNiQCUzXsRFHB5Z7lE/8UM/h/iYlSNTXhi29y+wYQs0W93AUHQkIvPtRvQFi7cG1XZaStN8GcLeZP+Y+scRMzSKrZ4rGivldqBEerMcIUlUt/ZMc0EA8JB5/KtNjVloHpE+Qb1jNvLBzK3k33hcm56cSp9oy3u6mHAAlyKF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722876301; c=relaxed/simple;
	bh=9Kqz6qIA5CWM5K27vSzkIfcF9uGHTKnddDCHROhEiJ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gunbt/9z4ix+K4wzJx/2cFWO4Aw/q1Kkk/QI42R+Ui36hiRVtGOhQUh2cLlvM1YlfdUt2pF37nVivrhvW1ApeZu1BWFhyYuRn2O4QA//0CaGQj5LQ8eow12fVSo0i6eOqMrE9vBNgN/wngcBHmQtYbQyq0gTAbhZT2BjjxrwvYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IgcWG6d6; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IgcWG6d6"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1fc491f9b55so84860665ad.3
        for <git@vger.kernel.org>; Mon, 05 Aug 2024 09:44:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722876299; x=1723481099; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8xe9DP7MzHqznOoiJe++dxb/q6o3x4HRjYqfLrdcmcw=;
        b=IgcWG6d6YFLs8qXTCKzUHiX3KLn3LauoXmCzZNAWapjXEagSwuQrQTjbkqXPOW7boi
         daW1AU2yjH/QoetzF3U1iWW8x3RmhRmksarHR1a51iZUlzzdkRmK9U5vNFbBtLnD9tFe
         sbjaZc1xg0DZ5D0OhXZsFBdN2VN6jzSqkdb5waWA5FSo83qXIDvJ6biAraVezooKcKgs
         QzvXlEeU9tc3gM9fadreIMO3q8L9TYY2F497NIbALK/Javrj0Y9iBwk5dG6+L4opkB+l
         knejJf8ETQxl43u0j2ZHvQUeSzg71OLsQh60iOr9nnGA37lceU+G4o94RrIBSHg6qtpv
         8gJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722876299; x=1723481099;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8xe9DP7MzHqznOoiJe++dxb/q6o3x4HRjYqfLrdcmcw=;
        b=UBgCYJcX0XllubfH7jrvEZ4jBRj2GH1Zcu/Y6Vv0pmQ95322lHe8reqHLoRycOftNc
         YqhWNtOJG7skz+IGDLvu3A2/fbPmdqLD58n2GOR8NYlWwCpkkHxno5dmEFI7iWImq8Ds
         Smi7IqyOdIBiHgz1iJ9Orj2qACJ01Uu2sOwISMRoqGU7vAo8pV3eJCGHHYAdgZ5WTRRl
         Be8FpdL/7RjFSvyQOodwsnRIPmtlnTeX6XwdLMpeDCniO5m2lxtXWfLX91UNIhLnf/9O
         AAKOrXc05qORlVvEGaKqVNlEwy1rtCffnk/TVHFrxogbXgOIDumlz7CzrZzi8v9Qtjm6
         g/iw==
X-Gm-Message-State: AOJu0Yx/1S8I2lAuTK/+tUzKGi/y2I0U2fJZr+57Tdf3w1GacL+8m9z+
	hJYiUZDMh4WYGQNb0MXNnaJYj0r6xNHz9ZRTXykKma4c8aRfoaUF4tH/nw==
X-Google-Smtp-Source: AGHT+IHN1EFwLBMx+BtSBnxIyq0Op79OOPUz4t8STDv+u2wRSgy4RH8arrdxLHHtFdwv7HGYRxjneQ==
X-Received: by 2002:a17:902:ec83:b0:1fd:9590:6550 with SMTP id d9443c01a7336-1ff574dfe01mr121198095ad.64.1722876298735;
        Mon, 05 Aug 2024 09:44:58 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ff58f219easm70222295ad.58.2024.08.05.09.44.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Aug 2024 09:44:58 -0700 (PDT)
Date: Tue, 6 Aug 2024 00:45:26 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: [GSoC][PATCH v15 2/9] fsck: rename objects-related fsck error
 functions
Message-ID: <ZrEBpkTgbWf0Hrr4@ArchLinux>
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

The names of objects-related fsck error functions are generic. It's OK
when there is only object database check. However, we are going to
introduce refs database check report function. To avoid ambiguity,
rename object-related fsck error functions to explicitly indicate these
functions are used to report objects-related messages.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Karthik Nayak <karthik.188@gmail.com>
Signed-off-by: shejialuo <shejialuo@gmail.com>
---
 builtin/fsck.c | 14 +++++++-------
 fsck.c         | 17 +++++++++--------
 fsck.h         | 26 +++++++++++++-------------
 3 files changed, 29 insertions(+), 28 deletions(-)

diff --git a/builtin/fsck.c b/builtin/fsck.c
index d13a226c2e..6d86bbe1e9 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -89,12 +89,12 @@ static int objerror(struct object *obj, const char *err)
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
+				   enum fsck_msg_type msg_type,
+				   enum fsck_msg_id msg_id UNUSED,
+				   const char *message)
 {
 	switch (msg_type) {
 	case FSCK_WARN:
@@ -938,7 +938,7 @@ int cmd_fsck(int argc, const char **argv, const char *prefix)
 
 	fsck_walk_options.walk = mark_object;
 	fsck_obj_options.walk = mark_used;
-	fsck_obj_options.error_func = fsck_error_func;
+	fsck_obj_options.error_func = fsck_objects_error_func;
 	if (check_strict)
 		fsck_obj_options.strict = 1;
 
diff --git a/fsck.c b/fsck.c
index 3f32441492..8347842cfb 100644
--- a/fsck.c
+++ b/fsck.c
@@ -1200,7 +1200,7 @@ int fsck_buffer(const struct object_id *oid, enum object_type type,
 		      type);
 }
 
-int fsck_error_function(struct fsck_options *o,
+int fsck_objects_error_function(struct fsck_options *o,
 			const struct object_id *oid,
 			enum object_type object_type UNUSED,
 			enum fsck_msg_type msg_type,
@@ -1303,16 +1303,17 @@ int git_fsck_config(const char *var, const char *value,
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
+						   enum fsck_msg_type msg_type,
+						   enum fsck_msg_id msg_id,
+						   const char *message)
 {
 	if (msg_id == FSCK_MSG_GITMODULES_MISSING) {
 		puts(oid_to_hex(oid));
 		return 0;
 	}
-	return fsck_error_function(o, oid, object_type, msg_type, msg_id, message);
+	return fsck_objects_error_function(o, oid, object_type,
+					   msg_type, msg_id, message);
 }
diff --git a/fsck.h b/fsck.h
index bcfb2e34cd..41ebebbb59 100644
--- a/fsck.h
+++ b/fsck.h
@@ -120,16 +120,16 @@ typedef int (*fsck_error)(struct fsck_options *o,
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
+				enum fsck_msg_type msg_type, enum fsck_msg_id msg_id,
+				const char *message);
+int fsck_objects_error_cb_print_missing_gitmodules(struct fsck_options *o,
+						   const struct object_id *oid,
+						   enum object_type object_type,
+						   enum fsck_msg_type msg_type,
+						   enum fsck_msg_id msg_id,
+						   const char *message);
 
 struct fsck_options {
 	fsck_walk_func walk;
@@ -150,7 +150,7 @@ struct fsck_options {
 	.gitmodules_done = OIDSET_INIT, \
 	.gitattributes_found = OIDSET_INIT, \
 	.gitattributes_done = OIDSET_INIT, \
-	.error_func = fsck_error_function \
+	.error_func = fsck_objects_error_function \
 }
 #define FSCK_OPTIONS_STRICT { \
 	.strict = 1, \
@@ -158,7 +158,7 @@ struct fsck_options {
 	.gitmodules_done = OIDSET_INIT, \
 	.gitattributes_found = OIDSET_INIT, \
 	.gitattributes_done = OIDSET_INIT, \
-	.error_func = fsck_error_function, \
+	.error_func = fsck_objects_error_function, \
 }
 #define FSCK_OPTIONS_MISSING_GITMODULES { \
 	.strict = 1, \
@@ -166,7 +166,7 @@ struct fsck_options {
 	.gitmodules_done = OIDSET_INIT, \
 	.gitattributes_found = OIDSET_INIT, \
 	.gitattributes_done = OIDSET_INIT, \
-	.error_func = fsck_error_cb_print_missing_gitmodules, \
+	.error_func = fsck_objects_error_cb_print_missing_gitmodules, \
 }
 
 /* descend in all linked child objects
-- 
2.46.0

