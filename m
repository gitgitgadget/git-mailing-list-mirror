Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36C2712C7FD
	for <git@vger.kernel.org>; Thu,  8 Aug 2024 11:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723116238; cv=none; b=qrsdP2WyMfoG41dZ1HKOuJ3tSnkPLYrdkXeZU8HUPqufgoIXEdw7ryo7a0TNWZfKeIpHsIEwJXoUnokaMGamUqduCFGVLPfVuxefprxE+5w4agXfynZQaSvhZYIh0MUsO+w1/d2cS6NRt8wy6u53fTDNeHOsWUYWgSJAgMVguEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723116238; c=relaxed/simple;
	bh=9Kqz6qIA5CWM5K27vSzkIfcF9uGHTKnddDCHROhEiJ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N0ddOt2EgXnDfPBo8zg+BiRKGPwcf76Lsupc1UX6i5CA5nK+EWZ1YLFfIaIt0YIAW/TJ9J16JK523fQz6TayVgqAnfu0aRr4P6DjMiRkY/erjNbcQt/ChjN8rFmzL6C5bXVfrZfOnWfUOHEcWpOwcQQsioPdDgqbTptxE2EL/rM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QfRh1Cq7; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QfRh1Cq7"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-710d1de6e79so60627b3a.0
        for <git@vger.kernel.org>; Thu, 08 Aug 2024 04:23:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723116236; x=1723721036; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8xe9DP7MzHqznOoiJe++dxb/q6o3x4HRjYqfLrdcmcw=;
        b=QfRh1Cq7qT57dhsDZ7q1XO/+D6GlP0FogKLZhEiY182VJyIAUndk0uRrTVu/hc1Bj0
         YendILiZo+9kK/TJyogXyMYOjF7QKDtz6UJac23x6Kd/7Hl7NTRhEe/yUk3iZyKf/yJ0
         hBxSjq4pKXylyTyK4mgDVrNZKyE5RbGEo9GmbJwrtdAsogF21vr/wNkWFFvbSDlY7I/B
         3Jt3kbpr8vorw7tsjkOOn8GhBtnNW3aAWdiXJ/uC9dLPIPRIefxEKvz0JE9QIDOF3NzI
         tYCmEnepIpCG+yPrGRSW3P6TeMPj93QGjC7L1Rbz040r42EmeNYON/vPBpsbCxXfZiEF
         A2pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723116236; x=1723721036;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8xe9DP7MzHqznOoiJe++dxb/q6o3x4HRjYqfLrdcmcw=;
        b=uEI/25ykJMVIursLY8TrHx7djfODZJPBPWXTrzkzqjpv6ybc2xKFklBnwHIwumKVCQ
         mWewO/tP2cJwF7yVlzM9xE5PDjsAIgks+Q4nnDdcYMVedv0cvy2tC9JBOo1SYgymU22U
         FvslJe3QDi80l6atLMALGeHiBEsggZ9538s/fQwiTE78aVdLXmZ7sY1MNCTDgYu95jMh
         S7VKKiaybyKnK+VOrVHmztOjVh6SfKZ6Bmi/mnoXxcacRnUFoVpFPdaY/hwApFH9qXxx
         WJ8CUEnamnh1a6goXxdm2cbcFwHolDsTnOji1i11j7vDSWux0ESV0/zq26Yr+gHXdULq
         7yJQ==
X-Gm-Message-State: AOJu0YxXwQYRFe2BIbYsd/6Xosgw0A+lXLRllWqRhv2xwYJE4gbcXODc
	6wnzktOkdvbPr3u9NCGvjuQWmL/rEvVEt/zkDsIr5M84j0rTQHteRl4KQqcucas=
X-Google-Smtp-Source: AGHT+IHMgn9z01n/pnHL895BqZKT8VzCFXQFN5TUG/1YE6lOy4ty/DWrE7+PVl70sNmHJ7Xf/ESXVQ==
X-Received: by 2002:a05:6a00:1249:b0:705:a13b:e740 with SMTP id d2e1a72fcca58-710cae20b3bmr1873078b3a.19.1723116235778;
        Thu, 08 Aug 2024 04:23:55 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ff59297329sm122585245ad.247.2024.08.08.04.23.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Aug 2024 04:23:55 -0700 (PDT)
Date: Thu, 8 Aug 2024 19:24:25 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: [GSoC][PATCH v16 2/9] fsck: rename objects-related fsck error
 functions
Message-ID: <ZrSq6XV8hKRZMrnt@ArchLinux>
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

