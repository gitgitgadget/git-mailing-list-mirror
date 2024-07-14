Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBE0C49635
	for <git@vger.kernel.org>; Sun, 14 Jul 2024 12:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720960284; cv=none; b=spZ25nf4AaxljB6QZzo6KZZJ4G+++mCHFz4RM9K+FCDBxZ5GRYbGAEyfdjk0sXwG/TbgPUAxka5MseYyNJ9zmf5P+Vv6++x+3aNTueGDZoIKzwcdOlsdmTOsqKnNzW8U3kHt+hv3GuksYY2hKZPB7JlHOAqzou02sdje1gr4pO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720960284; c=relaxed/simple;
	bh=MxwAzjlqVNuoxZlxmFEYKA8A5mjus1wveytMqEV4ywY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H+skhg76aiS9vIlquiCpQNM241574ULNX1rXrrLdsKzyVQN4BDy2MRdAkCWi7UbDdxIpOpyj509CJ9NcyBs2yCAjFidcGZsKnrBybT+yxguH3CPO+BjAz1z6UneULt9MVk976xE2Qux70hPfsbki8TXnEcTkthmhiRGEqGkuKTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KOM5GhNL; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KOM5GhNL"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-6e7e23b42c3so1935843a12.1
        for <git@vger.kernel.org>; Sun, 14 Jul 2024 05:31:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720960281; x=1721565081; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zhg4RNNdhtPm4o7yGzVsRbA9V5BekoEg8E1GhQOvOcA=;
        b=KOM5GhNL397/ln4uqnjCLZbsi67PUgYtHmGRS+fLaGkHBnxBBIVKWpQKUiVhSPX4wj
         Uc82wv/urg/R3gjwI2QkuFlDC0M7atc8RmY2Ixkw1wkMEq4afZBbhQ28itfFvNrgYVLj
         bD93LLG70gddJlt1hWpDqpVmBj87pWOakQNQZR0kbm+APqV6ohcOJJKXfUJc0qeorhZp
         YyEq0XGLmxEqSgiSiJht3yroA6khYh/cj5wfsGX2J139RM+J3THe0JRaYxMuedc6dlVu
         96MbTZhmXIO1z6XcwjngJGnN563Y2D/2/qsQ6eYIwQuSYroK8JpB/qXLwngcevAoCdah
         uDqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720960281; x=1721565081;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zhg4RNNdhtPm4o7yGzVsRbA9V5BekoEg8E1GhQOvOcA=;
        b=QGIrC618m3GfnJDmxmTpBXoi48aX2BDujMo1/vs+bcAso+crbebFlXSVyujPM9BVJ+
         RN1b8fFKdKNVvEbFUPOAEQNv9FRWCn5wNnUS9m3bb87TbhlKfBuKqYF8LiARONhHL1zc
         rD3zMEaoQCUE5KYHaARHK1PweAU0Z9MdqiGjlzXDXnlwveNEknfkFFOxYmcLt1b5xHeP
         77SAlvs7A/eE+k1KuFOs+zmXwHRokyXtP3cs6vW3YUUKGQvWpCLIzYvKlVOAP+Sw7bFT
         RQ0kiS7l74tkRI6py2V0FdrPvNRRLC/huh/FVeWTbCGGLfrorBEJmV6reTWA818duq9F
         UlMA==
X-Gm-Message-State: AOJu0YxbOP+i0GcVx2BAxKLTjVnAklhrXLLoTGuEpp590iM6wFdGkK34
	xsHcgw0zm0CY2vyUzTJlKR/r6qTOe8ajdgSGx86yuvoQT8ZzlqPwgMpGbw==
X-Google-Smtp-Source: AGHT+IGDqcbgA8YVT3HNNLmvQ93KpZ0ziIP+cyBPQCR5uRMj5wpY2eIQZbdPgIM3R3+SQHoNGFD8tQ==
X-Received: by 2002:a05:6a21:9997:b0:1c2:905c:dc2 with SMTP id adf61e73a8af0-1c29822dabemr18208710637.15.1720960281266;
        Sun, 14 Jul 2024 05:31:21 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fc0bb6fd90sm23073015ad.59.2024.07.14.05.31.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jul 2024 05:31:20 -0700 (PDT)
Date: Sun, 14 Jul 2024 20:31:25 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: [GSoC][PATCH v11 03/10] fsck: rename objects-related fsck error
 functions
Message-ID: <ZpPFHX_bpyAwfGri@ArchLinux>
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

The names of objects-related fsck error functions are general. It's OK
when there is only object database check. However, we have introduced
refs database check report function. To avoid ambiguity, rename
object-related fsck error functions to explicitly indicate these
functions are used to report objects-related messages.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Karthik Nayak <karthik.188@gmail.com>
Signed-off-by: shejialuo <shejialuo@gmail.com>
---
 builtin/fsck.c | 18 +++++++++---------
 fsck.c         | 37 +++++++++++++++++++------------------
 fsck.h         | 32 ++++++++++++++++----------------
 3 files changed, 44 insertions(+), 43 deletions(-)

diff --git a/builtin/fsck.c b/builtin/fsck.c
index 8aeb8b17e2..d22488c5d0 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -89,14 +89,14 @@ static int objerror(struct object *obj, const char *err)
 	return -1;
 }
 
-static int fsck_error_func(struct fsck_options *o UNUSED,
-			   const struct object_id *oid,
-			   enum object_type object_type,
-			   const char *ref_checkee UNUSED,
-			   const char *sub_ref_checkee UNUSED,
-			   enum fsck_msg_type msg_type,
-			   enum fsck_msg_id msg_id UNUSED,
-			   const char *message)
+static int fsck_objects_error_func(struct fsck_options *o UNUSED,
+				   const struct object_id *oid,
+				   enum object_type object_type,
+				   const char *ref_checkee UNUSED,
+				   const char *sub_ref_checkee UNUSED,
+				   enum fsck_msg_type msg_type,
+				   enum fsck_msg_id msg_id UNUSED,
+				   const char *message)
 {
 	switch (msg_type) {
 	case FSCK_WARN:
@@ -940,7 +940,7 @@ int cmd_fsck(int argc, const char **argv, const char *prefix)
 
 	fsck_walk_options.walk = mark_object;
 	fsck_obj_options.walk = mark_used;
-	fsck_obj_options.error_func = fsck_error_func;
+	fsck_obj_options.error_func = fsck_objects_error_func;
 	if (check_strict)
 		fsck_obj_options.strict = 1;
 
diff --git a/fsck.c b/fsck.c
index 7fceecdfae..d66ea4ef44 100644
--- a/fsck.c
+++ b/fsck.c
@@ -1239,14 +1239,14 @@ int fsck_buffer(const struct object_id *oid, enum object_type type,
 		      type);
 }
 
-int fsck_error_function(struct fsck_options *o,
-			const struct object_id *oid,
-			enum object_type object_type UNUSED,
-			const char *ref_checkee UNUSED,
-			const char *sub_ref_checkee UNUSED,
-			enum fsck_msg_type msg_type,
-			enum fsck_msg_id msg_id UNUSED,
-			const char *message)
+int fsck_objects_error_function(struct fsck_options *o,
+				const struct object_id *oid,
+				enum object_type object_type UNUSED,
+				const char *ref_checkee UNUSED,
+				const char *sub_ref_checkee UNUSED,
+				enum fsck_msg_type msg_type,
+				enum fsck_msg_id msg_id UNUSED,
+				const char *message)
 {
 	if (msg_type == FSCK_WARN) {
 		warning("object %s: %s", fsck_describe_object(o, oid), message);
@@ -1344,19 +1344,20 @@ int git_fsck_config(const char *var, const char *value,
  * Custom error callbacks that are used in more than one place.
  */
 
-int fsck_error_cb_print_missing_gitmodules(struct fsck_options *o,
-					   const struct object_id *oid,
-					   enum object_type object_type,
-					   const char *ref_checkee,
-					   const char *sub_ref_checkee,
-					   enum fsck_msg_type msg_type,
-					   enum fsck_msg_id msg_id,
-					   const char *message)
+int fsck_objects_error_cb_print_missing_gitmodules(struct fsck_options *o,
+						   const struct object_id *oid,
+						   enum object_type object_type,
+						   const char *ref_checkee,
+						   const char *sub_ref_checkee,
+						   enum fsck_msg_type msg_type,
+						   enum fsck_msg_id msg_id,
+						   const char *message)
 {
 	if (msg_id == FSCK_MSG_GITMODULES_MISSING) {
 		puts(oid_to_hex(oid));
 		return 0;
 	}
-	return fsck_error_function(o, oid, object_type, ref_checkee,
-				   sub_ref_checkee, msg_type, msg_id, message);
+	return fsck_objects_error_function(o, oid, object_type, ref_checkee,
+					   sub_ref_checkee, msg_type, msg_id,
+					   message);
 }
diff --git a/fsck.h b/fsck.h
index 61ca38afd6..0b40d9ec28 100644
--- a/fsck.h
+++ b/fsck.h
@@ -123,19 +123,19 @@ typedef int (*fsck_error)(struct fsck_options *o,
 			  enum fsck_msg_type msg_type, enum fsck_msg_id msg_id,
 			  const char *message);
 
-int fsck_error_function(struct fsck_options *o,
-			const struct object_id *oid, enum object_type object_type,
-			const char *ref_checkee, const char *sub_ref_checkee,
-			enum fsck_msg_type msg_type, enum fsck_msg_id msg_id,
-			const char *message);
-int fsck_error_cb_print_missing_gitmodules(struct fsck_options *o,
-					   const struct object_id *oid,
-					   enum object_type object_type,
-					   const char *ref_checkee,
-					   const char *sub_ref_checkee,
-					   enum fsck_msg_type msg_type,
-					   enum fsck_msg_id msg_id,
-					   const char *message);
+int fsck_objects_error_function(struct fsck_options *o,
+				const struct object_id *oid, enum object_type object_type,
+				const char *ref_checkee, const char *sub_ref_checkee,
+				enum fsck_msg_type msg_type, enum fsck_msg_id msg_id,
+				const char *message);
+int fsck_objects_error_cb_print_missing_gitmodules(struct fsck_options *o,
+						   const struct object_id *oid,
+						   enum object_type object_type,
+						   const char *ref_checkee,
+						   const char *sub_ref_checkee,
+						   enum fsck_msg_type msg_type,
+						   enum fsck_msg_id msg_id,
+						   const char *message);
 
 struct fsck_options {
 	fsck_walk_func walk;
@@ -156,7 +156,7 @@ struct fsck_options {
 	.gitmodules_done = OIDSET_INIT, \
 	.gitattributes_found = OIDSET_INIT, \
 	.gitattributes_done = OIDSET_INIT, \
-	.error_func = fsck_error_function \
+	.error_func = fsck_objects_error_function \
 }
 #define FSCK_OPTIONS_STRICT { \
 	.strict = 1, \
@@ -164,7 +164,7 @@ struct fsck_options {
 	.gitmodules_done = OIDSET_INIT, \
 	.gitattributes_found = OIDSET_INIT, \
 	.gitattributes_done = OIDSET_INIT, \
-	.error_func = fsck_error_function, \
+	.error_func = fsck_objects_error_function, \
 }
 #define FSCK_OPTIONS_MISSING_GITMODULES { \
 	.strict = 1, \
@@ -172,7 +172,7 @@ struct fsck_options {
 	.gitmodules_done = OIDSET_INIT, \
 	.gitattributes_found = OIDSET_INIT, \
 	.gitattributes_done = OIDSET_INIT, \
-	.error_func = fsck_error_cb_print_missing_gitmodules, \
+	.error_func = fsck_objects_error_cb_print_missing_gitmodules, \
 }
 
 /* descend in all linked child objects
-- 
2.45.2

