Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 622F716D4EF
	for <git@vger.kernel.org>; Wed, 12 Jun 2024 08:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718182451; cv=none; b=oeChNeRuDbWxFURP9A9IxrvzxADOxZBz19Fmy01rr1pyDE327vexlggqwXnznLaY62pcTqDs/w3XksY/mrhFv1ouQaubl0m6aJLLYVqozB0S4yWKuSKqGcSGN1ffe6NnXJPBp+Umx6MayRJOcYpsBEii4WyVpDwKtPISlKTYuzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718182451; c=relaxed/simple;
	bh=Wt488ytTtHs3k9YyRHY0iLARXB3ECkoCQfArcMw8fd4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bqRZSPg/VAtYKGUMnp6G5+2yG0z320uRRpAup2OSrTTTTx2QJKO88I4b1YK+0menWO1w1EMhWtm/z78kqpKgASIryFZ7KdP8u/n8QxEi4gnf+3rwcstziK5Zvn0uoUCa4z7envPGmEj9sS1PDaQVBxHSe9qfObquWefB02Nbb00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jGQG3kvT; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jGQG3kvT"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1f4a5344ec7so5699605ad.1
        for <git@vger.kernel.org>; Wed, 12 Jun 2024 01:54:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718182448; x=1718787248; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gDNyAA5zgUU7lYVxSw0ppe+Urq5or0MFtM5ktEyjxDk=;
        b=jGQG3kvTMo0a/h1cNFtbkvJ+dI02AppagMyE793MYNjGehDseSct7APqwpPGzmI0Ft
         /DePndV+9XXUuGIWrEUACgpWu4OFyqYm08p1V8Ax5mphIoMb8ndV7Pxpyy9pctwzV+UE
         5Op/zv8rKxsyrv29lXQBYN0oqeBvv3lqO9l7t+jAf6TS5S/RIRACI3QWp/UFbtqAGbS2
         Lp8+DufLOsR3E/Ck7j4cEcX0uNdV7dgOrZJFfb1lm1vws1usTtLT+3R4LO2LPH0Oq2iv
         PkjBwKncADV1n8IUpuZmxPQG/BMPnRffRTpveZNOHRWnTBQeHoCTTZqUXa6rIv+vGJFk
         t+6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718182448; x=1718787248;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gDNyAA5zgUU7lYVxSw0ppe+Urq5or0MFtM5ktEyjxDk=;
        b=pVh6l3KTAK9JKj/oHX7bh/hA9rrUTLbeIE1p5JkKWlhAM9jjcJStkTJ6+BwrK9Ybws
         VJR9yLPiE6F4qRpszx/z9Ky/JbZHxF3dYxmeuoTh7/Gl3KJpM9zbbf336MPQPlxRNm+B
         WOc7OD9NBLicO7QrUUDGusoq9QNe/eNxNx1jNHl9YpWmaorr/e/QhzjA7CsNYd5r3CDu
         R/FJJwGsh22oUz+8rRn5dnogH9kNoI2Q6V4aRZJK/0zWPKcIxpbagb9aw80ioHktepy4
         eTyHw5faXLJgEUMz/og26SV/eGkH83jwF8sdkvjweMrxTag5elrBMUOZmeuYLvXMAiuJ
         YH+A==
X-Gm-Message-State: AOJu0YzxIahs5Vt35oUi8czahbwxNqR0xtBU2q/DMaMuU0wcV0cy3j0h
	x2wiDv/ToICHedoAri4x/Q6iKDHFXP27RfepyVuIQu9ecZRMxWvDtytlR9Do
X-Google-Smtp-Source: AGHT+IEffXsSSOZzJl6rTxiPD4kHSrLEkFlBY9HB3Na50aoKC6NuhYACNXSGC0SZIDyLdcTnt5JqFQ==
X-Received: by 2002:a17:902:e80e:b0:1f6:1a86:37ba with SMTP id d9443c01a7336-1f83ae5eccemr22798805ad.2.1718182448082;
        Wed, 12 Jun 2024 01:54:08 -0700 (PDT)
Received: from ArchLinux.localdomain ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f6eccc0bd0sm84066855ad.105.2024.06.12.01.54.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 01:54:07 -0700 (PDT)
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>,
	Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	shejialuo <shejialuo@gmail.com>
Subject: [GSoC][PATCH v2 1/7] fsck: add refs check interfaces to interface with fsck error levels
Date: Wed, 12 Jun 2024 16:53:43 +0800
Message-ID: <20240612085349.710785-2-shejialuo@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240612085349.710785-1-shejialuo@gmail.com>
References: <20240530122753.1114818-1-shejialuo@gmail.com>
 <20240612085349.710785-1-shejialuo@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
 fsck.h | 39 +++++++++++++++++++++++++++++++--
 2 files changed, 106 insertions(+), 2 deletions(-)

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
index 17fa2dda5d..7451b1f91b 100644
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
@@ -135,11 +151,22 @@ int fsck_error_cb_print_missing_gitmodules(struct fsck_options *o,
 					   enum fsck_msg_id msg_id,
 					   const char *message);
 
+struct fsck_refs_options {
+	enum fsck_msg_type *msg_type;
+	unsigned strict:1;
+	fsck_refs_error error_func;
+	unsigned verbose:1;
+};
+
+#define FSCK_REFS_OPTIONS_DEFAULT { \
+	.error_func = fsck_refs_error_function, \
+}
+
 struct fsck_options {
+	enum fsck_msg_type *msg_type;
+	unsigned strict:1;
 	fsck_walk_func walk;
 	fsck_error error_func;
-	unsigned strict:1;
-	enum fsck_msg_type *msg_type;
 	struct oidset skiplist;
 	struct oidset gitmodules_found;
 	struct oidset gitmodules_done;
@@ -221,6 +248,12 @@ int fsck_tag_standalone(const struct object_id *oid, const char *buffer,
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
@@ -247,6 +280,8 @@ const char *fsck_describe_object(struct fsck_options *options,
 				 const struct object_id *oid);
 
 struct key_value_info;
+int git_fsck_refs_config(const char *var, const char *value,
+			 const struct config_context *ctx, void *cb);
 /*
  * git_config() callback for use by fsck-y tools that want to support
  * fsck.<msg> fsck.skipList etc.
-- 
2.45.2

