Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A5191A0AE0
	for <git@vger.kernel.org>; Tue, 18 Jun 2024 08:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718698519; cv=none; b=aHwWLcTr4bDY8GyEDSStNhyGqgl1BLC4918WPRThLWgEFy74xe2csC80YXNoe9ocoUxrlZuRRvGPDDhDi9jjWI7+rPGPT/HXeJWOAEsmkhUylkHCR23Kej0DK1HAXojDhI5w1EDt+NT1h7/Wp6+xEpH37CcR/lNg55fkzkE61Cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718698519; c=relaxed/simple;
	bh=1LiNvH04yWUfiKlUTKmS+hfirGKSvf0cDaYO8nH6nnA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=dOzdh24cR3yQH7emgsorw7w8dtzWh0UGepTBB347lr8wLrQDY+JCSvSKvTrvm7ci9x0twQJ3XrmW2bbWTtonywV6MVXZehRFLOBXSwW+OmFfao0QZcR5mjUiRUMg6F/UxGavymehnrRiesWi66TWIVoTjC+c21YvfUplVapsa2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mT7fPNva; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mT7fPNva"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-681ad26f4a5so3160805a12.2
        for <git@vger.kernel.org>; Tue, 18 Jun 2024 01:15:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718698517; x=1719303317; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9z1RCjIOh+PISoYg8+SlZJ5dPOTeKJIU/cG+VTO4yTk=;
        b=mT7fPNvalAv0Z9y4ds8lJCDN8vuMqi99mvMfiBQWq3m/OBaAN93ZqkwMNwI2FojehW
         uOiQW7yoneuTa64mVIiNGllRZiDmoU/rJwK5mknQfXAzOHRYy9vdIkW5Z0h/QdrcMo1N
         HmDe4sFCHCrJrUTxnGaPAtwEa08CdXYElIrKMvezqNBwG9s5LIqpujGBZqSU2SsoT+zv
         Lr2dLUoxXmyu91Wr21NZPBRRUT+dgGhsXy6DpG2TL4rHP4UGQ6zbT95fGw3KzADLB8F4
         +t19AsUSW5jyxz1f3/xzoe1bxKvdpc5dlGIYkLzhfJtrgiW82mg1/je1+rLBWkViDZlX
         O9ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718698517; x=1719303317;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9z1RCjIOh+PISoYg8+SlZJ5dPOTeKJIU/cG+VTO4yTk=;
        b=Vh6Q9kLi9yA6zRqEmge62rnCtcUpRtWdah+t5xrXUMi5esrBjCEg05UcVAQvLFE4u4
         wsa8YXapt5IaWjo6uQS8UY4GmZEaTQBxQHyxGd3NjdTVnKigJddwFTGTIV07+GGMxrQP
         rXVz4e4jjT9uKFt0oexjILQhVFl9gDJj/KN9xIlPiNa7Ac/f849ACCeJBoOZMP2KxVOv
         5RgMvyjNwZiAQqtBI5mJbyx00Dox+T5eUqKZ6rBKclvtp3HSj2iwmaufPoqcf/2gOPdO
         eX+CS/+7/qw9lsk/LAjLDlStKRpZqb2f4EXq7ULgcFG9R5tU3Of3CIf5OX4f6rvs//W9
         AgFA==
X-Gm-Message-State: AOJu0Yxl/L7BSgM8qnt93ua/6emOiHhYW/S/F98VD7yrHZ6KUnqDNgL7
	wLFup20kLtAntrrcnLGqBTdF5pJC/rTa89E612Mu4NdYXqZhgJMW6pcEiw==
X-Google-Smtp-Source: AGHT+IGacdPnuCDj5OOsOq39E+ee+tfwPRmaHyn5GH/GUuQao8MOaZg3rvkQyiWZpWQrEOuB7A9Asw==
X-Received: by 2002:a05:6a20:9148:b0:1b2:cf6c:d5a4 with SMTP id adf61e73a8af0-1bae82ecde1mr12611649637.61.1718698516625;
        Tue, 18 Jun 2024 01:15:16 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-705ccb3d1aasm8814042b3a.140.2024.06.18.01.15.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 01:15:16 -0700 (PDT)
Date: Tue, 18 Jun 2024 16:15:13 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [GSoC][PATCH v3 1/7] fsck: add refs check interfaces to interface
 with fsck error levels
Message-ID: <ZnFCEYypdAyXMMlg@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240612085349.710785-1-shejialuo@gmail.com>

The git-fsck(1) focuses on object database consistency check. It relies
on the "fsck_options" to interact with fsck error levels. However,
"fsck_options" aims at checking the object database which makes it
unsuitable to change the semantics of it. Instead, create
"fsck_refs_options" structure to handle refs consistency check.

The "git_fsck_config" sets up the "msg_type" and "skiplist" member of
the "fsck_options". For refs, we just need the "msg_type". In order to
allow setting up more refs-specific options easily later, add a separate
function "git_fsck_refs_config" to initialize the refs-specific options.

Move the "msg_type" and "strict" member to the top of the "fsck_options"
which allows us to convert "fsck_refs_options *" to "fsck_options *" to
reuse the interfaces provided by "fsck.h" without changing the original
code.

The static function "report" provided by "fsck.c" aims at reporting the
problems related to object database which cannot be reused for refs.
Provide "fsck_refs_report" function to integrate the fsck error levels
into reference consistency check.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Karthik Nayak <karthik.188@gmail.com>
Signed-off-by: shejialuo <shejialuo@gmail.com>
---
 fsck.c | 69 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 fsck.h | 45 ++++++++++++++++++++++++++++++++++++--
 2 files changed, 112 insertions(+), 2 deletions(-)

diff --git a/fsck.c b/fsck.c
index 8ef962199f..13528c646e 100644
--- a/fsck.c
+++ b/fsck.c
@@ -1249,6 +1249,20 @@ int fsck_buffer(const struct object_id *oid, enum object_type type,
 		      type);
 }
 
+int fsck_refs_error_function(struct fsck_refs_options *o UNUSED,
+			     const char *name,
+			     enum fsck_msg_type msg_type,
+			     enum fsck_msg_id msg_id UNUSED,
+			     const char *message)
+{
+	if (msg_type == FSCK_WARN) {
+		warning("%s: %s", name, message);
+		return 0;
+	}
+	error("%s: %s", name, message);
+	return 1;
+}
+
 int fsck_error_function(struct fsck_options *o,
 			const struct object_id *oid,
 			enum object_type object_type UNUSED,
@@ -1323,6 +1337,61 @@ int fsck_finish(struct fsck_options *options)
 	return ret;
 }
 
+int fsck_refs_report(struct fsck_refs_options *o,
+		     const char *name,
+		     enum fsck_msg_id msg_id,
+		     const char *fmt, ...)
+{
+	va_list ap;
+	struct strbuf sb = STRBUF_INIT;
+	enum fsck_msg_type msg_type =
+		fsck_msg_type(msg_id, (struct fsck_options*)o);
+	int ret = 0;
+
+	if (msg_type == FSCK_IGNORE)
+		return 0;
+
+	if (msg_type == FSCK_FATAL)
+		msg_type = FSCK_ERROR;
+	else if (msg_type == FSCK_INFO)
+		msg_type = FSCK_WARN;
+
+	prepare_msg_ids();
+	strbuf_addf(&sb, "%s: ", msg_id_info[msg_id].camelcased);
+
+	va_start(ap, fmt);
+	strbuf_vaddf(&sb, fmt, ap);
+	ret = o->error_func(o, name, msg_type, msg_id, sb.buf);
+	strbuf_release(&sb);
+	va_end(ap);
+
+	return ret;
+}
+
+int git_fsck_refs_config(const char *var, const char *value,
+			 const struct config_context *ctx, void *cb)
+{
+	struct fsck_refs_options *options = cb;
+	const char *msg_id;
+
+	/*
+	 * We don't check the value of fsck.skiplist here, because it
+	 * is specific to object database, not reference database.
+	 */
+	if (strcmp(var, "fsck.skiplist") == 0) {
+		return 0;
+	}
+
+	if (skip_prefix(var, "fsck.", &msg_id)) {
+		if (!value)
+			return config_error_nonbool(var);
+		fsck_set_msg_type((struct fsck_options*)options, msg_id, value);
+		return 0;
+	}
+
+	return git_default_config(var, value, ctx, cb);
+}
+
 int git_fsck_config(const char *var, const char *value,
 		    const struct config_context *ctx, void *cb)
 {
diff --git a/fsck.h b/fsck.h
index 17fa2dda5d..6a38ac4a16 100644
--- a/fsck.h
+++ b/fsck.h
@@ -96,6 +96,7 @@ enum fsck_msg_id {
 };
 #undef MSG_ID
 
+struct fsck_refs_options;
 struct fsck_options;
 struct object;
 
@@ -107,6 +108,21 @@ void fsck_set_msg_type(struct fsck_options *options,
 void fsck_set_msg_types(struct fsck_options *options, const char *values);
 int is_valid_msg_type(const char *msg_id, const char *msg_type);
 
+/*
+ * callback function for fsck refs and reflogs.
+ */
+typedef int (*fsck_refs_error)(struct fsck_refs_options *o,
+			       const char *name,
+			       enum fsck_msg_type msg_type,
+			       enum fsck_msg_id msg_id,
+			       const char *message);
+
+int fsck_refs_error_function(struct fsck_refs_options *o,
+			     const char *name,
+			     enum fsck_msg_type msg_type,
+			     enum fsck_msg_id msg_id,
+			     const char *message);
+
 /*
  * callback function for fsck_walk
  * type is the expected type of the object or OBJ_ANY
@@ -135,11 +151,28 @@ int fsck_error_cb_print_missing_gitmodules(struct fsck_options *o,
 					   enum fsck_msg_id msg_id,
 					   const char *message);
 
+struct fsck_refs_options {
+	enum fsck_msg_type *msg_type;
+	unsigned strict:1;
+
+	fsck_refs_error error_func;
+	unsigned verbose:1;
+};
+
+#define FSCK_REFS_OPTIONS_DEFAULT { \
+	.error_func = fsck_refs_error_function, \
+}
+
 struct fsck_options {
+	/*
+	 * Reorder the fields to allow `fsck_ref_options` to use
+	 * the interfaces using `struct fsck_options`.
+	 */
+	enum fsck_msg_type *msg_type;
+	unsigned strict:1;
+
 	fsck_walk_func walk;
 	fsck_error error_func;
-	unsigned strict:1;
-	enum fsck_msg_type *msg_type;
 	struct oidset skiplist;
 	struct oidset gitmodules_found;
 	struct oidset gitmodules_done;
@@ -221,6 +254,12 @@ int fsck_tag_standalone(const struct object_id *oid, const char *buffer,
  */
 int fsck_finish(struct fsck_options *options);
 
+__attribute__((format (printf, 4, 5)))
+int fsck_refs_report(struct fsck_refs_options *o,
+		     const char *name,
+		     enum fsck_msg_id msg_id,
+		     const char *fmt, ...);
+
 /*
  * Subsystem for storing human-readable names for each object.
  *
@@ -247,6 +286,8 @@ const char *fsck_describe_object(struct fsck_options *options,
 				 const struct object_id *oid);
 
 struct key_value_info;
+int git_fsck_refs_config(const char *var, const char *value,
+			 const struct config_context *ctx, void *cb);
 /*
  * git_config() callback for use by fsck-y tools that want to support
  * fsck.<msg> fsck.skipList etc.
-- 
2.45.2

