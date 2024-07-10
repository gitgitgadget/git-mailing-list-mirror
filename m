Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5793FBE4E
	for <git@vger.kernel.org>; Wed, 10 Jul 2024 14:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720622815; cv=none; b=sNjkO8bW59guPe70QSInC4HwaMEU2KFg90kboRWb5xCycNEKtInbJWNXzwLiXxVevuONY+FlZtMej2j0xl6WFm02N4981hDLHDNHzAlVyrg64/wDueiQitZ73W7mcf2fF2QLBFYUcJJhkrz1tWJRpJWUjW5nWuDOt+DI6bz2+jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720622815; c=relaxed/simple;
	bh=IBr4NobRpuFMjVd1HoOD9dYC8M+4JV9Zog46fOPjZrg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q3aGFRLx3MwtmHXG12jdUlCwgLLIhUGd4a9imVRmMi1IxyEKUJnQkWDIDBC4pd1ttcX+8IORuJ3iPeMBd/FH6wSakcj8J/69LLF4tmIw4yYaLSCCCZi7YLFtSU8+OAbw+I+rj7mtJ0qxDQZV/EyhX6aVfJ91R1vmna2XTumLmGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AHZrbzlF; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AHZrbzlF"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1fb1ff21748so35242845ad.3
        for <git@vger.kernel.org>; Wed, 10 Jul 2024 07:46:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720622813; x=1721227613; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TBvBSuUQTn5VA33azNMPlZF/fcfIqgux26YadIbziCs=;
        b=AHZrbzlF9XEym4f+Ux79f7Q/50DIoFwBuOmgRZiaNS3t6gwzqCcS4mbzjIaq6erS/4
         /31Sig0aSBXMMGTxgsgPMCF1EW+cxuME6rnUVVh6AVsUFd6XzQPCZxsh3cj9VnDg6hMn
         sMSoYJYhvBg0mb0F2ytLvwQ0MxUbw5YDu3tK+3/VkDHZnb6bTuOLoxNYTN03XKSYGwTr
         xUhSbZXUEQ4XuCJbs0CQ0VQIWpRxO/U2kNM1eOb3yFe3eDnZnuT3bOOv9XP7eZRdTH99
         18+gGekKM/2tHNAsxMjpAQV/pbNfycgVD9XsnqCY0lKVaScBJ1WgjifGNT+8QIs/Acn2
         4K5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720622813; x=1721227613;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TBvBSuUQTn5VA33azNMPlZF/fcfIqgux26YadIbziCs=;
        b=B4yDoRBt8hS6xDqefBFAWPHKYpde1MfRs45wcnchRqo6VZYZ8LfqY3mf23/L9FyNTL
         efEf6PG9S6XNU2/9rkOgpDZr32pW/y8SFFER5n6zhlWnOxZsND+lVDg4WvJbcYCWw64j
         IWgcce0uqO12ofHXjjpQeY84sU4Ff6dbIgFl1ek+oX/rrGc2USYAPkwI5+xekuub3tyr
         5YOzNrj9qqpeN3EL0MGQttZF/B5aeIsildqfw2GEfGkkeSdP9KdR0Lh11hacqFWZuNop
         zalypdttyhUcr3xLva5+VsMeaSfkoQdblzHqDIBjr6ikosjYi+z4oOCOwbJ5q/dWcRxa
         7wMA==
X-Gm-Message-State: AOJu0Yyb+lEThwrVH9/B4WdrDMNW2LjhDTzqg70DiG3Y0ckiWK3dwjUW
	CqlF3Aw1wWAhxFMuqujdlYulsHg4mRG1oKgYNWxU2wtkMeNKvnOQE79+og==
X-Google-Smtp-Source: AGHT+IGdneZ5R240PN5AHe1Kf1P08zT9AjZS9QTFNPL5dZHLBMcLHQh72bvKFfXrNNzyy/c4IjzpCA==
X-Received: by 2002:a17:902:ec8a:b0:1fb:9b91:d7db with SMTP id d9443c01a7336-1fbb6d3d3b6mr56920075ad.19.1720622813114;
        Wed, 10 Jul 2024 07:46:53 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fbb6ac4812sm34642705ad.226.2024.07.10.07.46.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jul 2024 07:46:52 -0700 (PDT)
Date: Wed, 10 Jul 2024 22:46:53 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: [GSoC][PATCH v10 02/10] fsck: rename objects-related fsck error
 functions
Message-ID: <Zo6e3WIe7yJSs1_l@ArchLinux>
References: <Zo6eJi8BePrQxTQV@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zo6eJi8BePrQxTQV@ArchLinux>

The names of objects-related fsck error functions are general. It's OK
when there is only object database check. However, we are going to
introduce refs database check. In order to avoid ambiguity, rename
objects-related fsck error functions to explicitly indicate these
functions are used to report objects-related messages.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Karthik Nayak <karthik.188@gmail.com>
Signed-off-by: shejialuo <shejialuo@gmail.com>
---
 builtin/fsck.c | 14 +++++++-------
 fsck.c         | 27 ++++++++++++++-------------
 fsck.h         | 26 +++++++++++++-------------
 3 files changed, 34 insertions(+), 33 deletions(-)

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
index 3f32441492..0aaff7f635 100644
--- a/fsck.c
+++ b/fsck.c
@@ -1200,12 +1200,12 @@ int fsck_buffer(const struct object_id *oid, enum object_type type,
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
+				enum fsck_msg_type msg_type,
+				enum fsck_msg_id msg_id UNUSED,
+				const char *message)
 {
 	if (msg_type == FSCK_WARN) {
 		warning("object %s: %s", fsck_describe_object(o, oid), message);
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
2.45.2

