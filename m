Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01BD513B5A5
	for <git@vger.kernel.org>; Thu,  1 Aug 2024 15:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722525249; cv=none; b=RsdbgraZPwX67JZMjw8hlH6mvxGx/4lT3yg3y0TRnImOik61yhCDiD+RKme7g6BSjkZDrBBVjQgSDTIul0jvaMZuQO76rw/K4RMMQ/fJEXrkNn8RIvVHECfQE31Bn+ekcJTGz1qGb1k8eHZqc7q1f1W3ud8Wwo4gm+J/AvzxUBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722525249; c=relaxed/simple;
	bh=0w40N95UwS3rC1/w4Vwom3FaqlpF0OqwCVE/XHl4y0M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xlh7S2pwS1nWMXCh/xP6/VkuXJzQCDBajdxffwXp8No6qMK8pFfdonkLUTnbblGamIo+YRCHNTiXmF+Z2c6CkVZSgkx/CHLMwa9FjxGSN5AIZVG7sCryLAo7nmrWC5mECUKDYKpexairzcNwfDukANatLDRjSr6C9D+BosI3TCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j2FEKG35; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j2FEKG35"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1fc56fd4de1so16850955ad.0
        for <git@vger.kernel.org>; Thu, 01 Aug 2024 08:14:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722525246; x=1723130046; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PgecxP4O0Pj59wqK0X7+wytHBmUi03mK/T6KiVvNudI=;
        b=j2FEKG35SdvzItOF+LHxM1e/J7bz/GYKjMTLg9BButt3bvp+O2SjDILogW5OuJT5lh
         rGR7vZKJnKGQb7TRs6PqYCjfa4b9NH8HLGc7kETT6T477VYtB+wQsW6uBaAF/iw5gDja
         PWdYyNlqAAKgWV3kjQP9m4ZpvdQDKmv5bfP7HKqpaMFf+VFh4uC0ZkE98Z72Nee8wIsw
         zW7Q6u3YqJrbi4+cgWs8QPU1AWq6LNH3WSoHt9nZUcoCNAgHlAWmh6hagZlG0j8MetOR
         ZDi0HxJfS0T8kfGCD9GU76FhQ+u9Tv73RpT5KjD+NlVxEn/TC7GSBZOvm392z5Acs5BN
         3TdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722525246; x=1723130046;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PgecxP4O0Pj59wqK0X7+wytHBmUi03mK/T6KiVvNudI=;
        b=BRAZFAoU5zsCEGtkkt70LpHfoGcoyRnrLNDzTgSsOox797P6O6YQ15/cwX5Uc7aZuB
         TV2OvCUWpvo+mSFmttwkY93bc18F5QomP/VYd+Ipq4/OCpEIxSTfWQ2XJl6uST1UsIgy
         2jPepedmAlafMOKvyvSPMIIO/ssxZIGVTk3rwWm3ng3ADDoUnJrRIwKgyOQoCdHPZ9uo
         Em6skxlmDK3CB/3qwAF75ip4MoY17lQ/VMRri0e+8scXQZJXYbY3mvzBOZykv1WKex6j
         UsNTmP7lXaSq1b0Bw+3hV61OQQut/L3y1/23f3n3NyhGk6BsLlrSVh2K9WGXKWuTIvAp
         PUFw==
X-Gm-Message-State: AOJu0YxCqLD87C+Z+uP/xwf2e2haYTnAvDcGl6WUOOHAu+TYC89EBUFv
	a25O2fviT8FVo9jZqu4ksMRI+gWShqXrQSu5GPssdSrhT4Kk0JnyNlLp3A==
X-Google-Smtp-Source: AGHT+IHC8QrZl2YsLlfcLGAs3OEn2mEkT6lN4EDZXqg14JgE8BbLM4na3fYiCs0z6PB+UqECIZmOrg==
X-Received: by 2002:a17:902:db0e:b0:1fb:6121:dfc0 with SMTP id d9443c01a7336-1ff57bed363mr3113465ad.19.1722525246400;
        Thu, 01 Aug 2024 08:14:06 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7f84a03sm141204495ad.243.2024.08.01.08.14.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Aug 2024 08:14:05 -0700 (PDT)
Date: Thu, 1 Aug 2024 23:14:29 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: [GSoC][PATCH v14 06/11] fsck: rename objects-related fsck error
 functions
Message-ID: <ZqumVWxLZpBYkrGB@ArchLinux>
References: <ZqulmWVBaeyP4blf@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZqulmWVBaeyP4blf@ArchLinux>

The names of objects-related fsck error functions are generic. It's OK
when there is only object database check. However, we have introduced
refs database check report function. To avoid ambiguity, rename
object-related fsck error functions to explicitly indicate these
functions are used to report objects-related messages.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Karthik Nayak <karthik.188@gmail.com>
Signed-off-by: shejialuo <shejialuo@gmail.com>
---
 builtin/fsck.c | 12 ++++++------
 fsck.c         | 22 +++++++++++-----------
 fsck.h         | 24 ++++++++++++------------
 3 files changed, 29 insertions(+), 29 deletions(-)

diff --git a/builtin/fsck.c b/builtin/fsck.c
index 9673a08286..766bbd014d 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -89,11 +89,11 @@ static int objerror(struct object *obj, const char *err)
 	return -1;
 }
 
-static int fsck_error_func(struct fsck_options *o UNUSED,
-			   void *fsck_report,
-			   enum fsck_msg_type msg_type,
-			   enum fsck_msg_id msg_id UNUSED,
-			   const char *message)
+static int fsck_objects_error_func(struct fsck_options *o UNUSED,
+				   void *fsck_report,
+				   enum fsck_msg_type msg_type,
+				   enum fsck_msg_id msg_id UNUSED,
+				   const char *message)
 {
 	struct fsck_object_report *report = fsck_report;
 	const struct object_id *oid = report->oid;
@@ -941,7 +941,7 @@ int cmd_fsck(int argc, const char **argv, const char *prefix)
 
 	fsck_walk_options.walk = mark_object;
 	fsck_obj_options.walk = mark_used;
-	fsck_obj_options.error_func = fsck_error_func;
+	fsck_obj_options.error_func = fsck_objects_error_func;
 	if (check_strict)
 		fsck_obj_options.strict = 1;
 
diff --git a/fsck.c b/fsck.c
index f0ae760c86..0a870fcec0 100644
--- a/fsck.c
+++ b/fsck.c
@@ -1236,11 +1236,11 @@ int fsck_buffer(const struct object_id *oid, enum object_type type,
 		      type);
 }
 
-int fsck_error_function(struct fsck_options *o,
-			void *fsck_report,
-			enum fsck_msg_type msg_type,
-			enum fsck_msg_id msg_id UNUSED,
-			const char *message)
+int fsck_objects_error_function(struct fsck_options *o,
+				void *fsck_report,
+				enum fsck_msg_type msg_type,
+				enum fsck_msg_id msg_id UNUSED,
+				const char *message)
 {
 	struct fsck_object_report *report = fsck_report;
 	const struct object_id *oid = report->oid;
@@ -1369,16 +1369,16 @@ int git_fsck_config(const char *var, const char *value,
  * Custom error callbacks that are used in more than one place.
  */
 
-int fsck_error_cb_print_missing_gitmodules(struct fsck_options *o,
-					   void *fsck_report,
-					   enum fsck_msg_type msg_type,
-					   enum fsck_msg_id msg_id,
-					   const char *message)
+int fsck_objects_error_cb_print_missing_gitmodules(struct fsck_options *o,
+						   void *fsck_report,
+						   enum fsck_msg_type msg_type,
+						   enum fsck_msg_id msg_id,
+						   const char *message)
 {
 	if (msg_id == FSCK_MSG_GITMODULES_MISSING) {
 		struct fsck_object_report *report = fsck_report;
 		puts(oid_to_hex(report->oid));
 		return 0;
 	}
-	return fsck_error_function(o, fsck_report, msg_type, msg_id, message);
+	return fsck_objects_error_function(o, fsck_report, msg_type,msg_id, message);
 }
diff --git a/fsck.h b/fsck.h
index 2276ea7e34..2002590f60 100644
--- a/fsck.h
+++ b/fsck.h
@@ -123,15 +123,15 @@ typedef int (*fsck_error)(struct fsck_options *o,
 			  enum fsck_msg_type msg_type, enum fsck_msg_id msg_id,
 			  const char *message);
 
-int fsck_error_function(struct fsck_options *o,
-			void *fsck_report,
-			enum fsck_msg_type msg_type, enum fsck_msg_id msg_id,
-			const char *message);
-int fsck_error_cb_print_missing_gitmodules(struct fsck_options *o,
-					   void *fsck_report,
-					   enum fsck_msg_type msg_type,
-					   enum fsck_msg_id msg_id,
-					   const char *message);
+int fsck_objects_error_function(struct fsck_options *o,
+				void *fsck_report,
+				enum fsck_msg_type msg_type, enum fsck_msg_id msg_id,
+				const char *message);
+int fsck_objects_error_cb_print_missing_gitmodules(struct fsck_options *o,
+						   void *fsck_report,
+						   enum fsck_msg_type msg_type,
+						   enum fsck_msg_id msg_id,
+						   const char *message);
 
 int fsck_refs_error_function(struct fsck_options *options,
 			     void *fsck_report,
@@ -169,7 +169,7 @@ struct fsck_options {
 	.gitmodules_done = OIDSET_INIT, \
 	.gitattributes_found = OIDSET_INIT, \
 	.gitattributes_done = OIDSET_INIT, \
-	.error_func = fsck_error_function \
+	.error_func = fsck_objects_error_function \
 }
 #define FSCK_OPTIONS_STRICT { \
 	.strict = 1, \
@@ -177,7 +177,7 @@ struct fsck_options {
 	.gitmodules_done = OIDSET_INIT, \
 	.gitattributes_found = OIDSET_INIT, \
 	.gitattributes_done = OIDSET_INIT, \
-	.error_func = fsck_error_function, \
+	.error_func = fsck_objects_error_function, \
 }
 #define FSCK_OPTIONS_MISSING_GITMODULES { \
 	.strict = 1, \
@@ -185,7 +185,7 @@ struct fsck_options {
 	.gitmodules_done = OIDSET_INIT, \
 	.gitattributes_found = OIDSET_INIT, \
 	.gitattributes_done = OIDSET_INIT, \
-	.error_func = fsck_error_cb_print_missing_gitmodules, \
+	.error_func = fsck_objects_error_cb_print_missing_gitmodules, \
 }
 #define FSCK_REFS_OPTIONS_DEFAULT { \
 	.error_func = fsck_refs_error_function, \
-- 
2.45.2

