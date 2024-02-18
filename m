Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A420771B3B
	for <git@vger.kernel.org>; Sun, 18 Feb 2024 19:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708286383; cv=none; b=josIYf9y8Deuzo2elUVBXa5bfBjBy/kX98gMj4UUlbpYN7bZ63xP7UIXDtxWa6CzZDAU7As7QxdsVJG69Bf9xCOOvGiDkz7xFw1nJm+F9DGwnNDBRbbFpp59XzRkyuTlseWlF9j66tnrxIBZecE376Zs5abq8O1+EQHOcwO3P7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708286383; c=relaxed/simple;
	bh=31eouZfqOINtJL4W0zdUaBYkP11FA0yNXh4TpRHK/oY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eGbR5nYza+fxMxSLvvHrAP18EOZywApzWbYGpXDPOI08EuHvYxGZaUBB3CeNJb3uTm6b2SaIyDb9d4JppgVQwlzSFept5MY9mmKnjE7jYaXO9YiAVe/sU2lTiFYuZwX6ZxGr4UdSRhNl5SkawtvTPnV1wxTuFL+dmlfdIjJeQBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lfYd2Wbx; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lfYd2Wbx"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-563c2b2bddbso4589228a12.1
        for <git@vger.kernel.org>; Sun, 18 Feb 2024 11:59:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708286380; x=1708891180; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rI/HPdGTW0agng8WQoR+PVh9x7Bb6vN39q4/Ah2hrFs=;
        b=lfYd2WbxKkVTNhz7Uk2GYTscxKFzdzpfk+yE9yI+03vZiEM9wRc37/tCCVel+T3LiY
         ly4ZKrDJUvfXSc5oQVB1grbVnzIF0N24c/2Mwyb49YdLhHQ3Laj0aUDzefEhCcEyjwtn
         OlaUcd4XgXiLBKqEiKgzTFiWsd/doTJwqPs4xUYeCIm+DmOKgaQSic4DAFJuYCXmtI0/
         nKTWxhaKjLuR6Od45CxD526PD9+wnE4xWmyOiyttbS7RshSQJ5+DGkpmFa1RhV7D5urI
         HMqFROOevE2U9R3D7vId996ADdm8t0NLrLpGmTsrZr3S5rKVUYRmwTr8lkdHz3+F2PLR
         NTzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708286380; x=1708891180;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rI/HPdGTW0agng8WQoR+PVh9x7Bb6vN39q4/Ah2hrFs=;
        b=HTm4Ji0zw4h9NgAvB6gOXnzdNV962ubnsTt3yv9U0OjMrq4Srlrvp6YyXA+JUYJv6j
         mbOx9AgZ/4LTvjU4kQKuFD1aEABbSGOVD/WFUb7me92AYgC+QBH+0FpYDav8O454Cjl2
         i0T0mq5bcyV04AKqUJvGk9iDS2kITZIkzDLtt6p0aScfZ/z6dnWZfi6k4FR2+K0BIDwQ
         ZW4BeYMdE4HX6iGFGkKYNk6D/qHgjt9JxQ1rur+hXbdc1jzmMkgbGb/kcAeu3sh9Pg/f
         iH0g4zmc34gurR6GrCQpWRLQxmi3L+oh/uU3pe+9qg121EAnco7s0ukUzHHEhnI2YpLo
         rdwQ==
X-Gm-Message-State: AOJu0YwXe0eczMXWlY9DaG2ykmWkG8XZchTjCqRAflBlavW6goISHEQT
	yHkY9g2FYbgsYQ+PgQyV0Af/6ITvxLfk4EB0xZ5DXiqTv5LcDcAmUUIW5RxB
X-Google-Smtp-Source: AGHT+IGmplhMORVPBnx/7DtWmKL+q7ZTc3bG10pj0NiYIRSNPOLf8HJz/aqG9vAtVGHjmV3FMWOa7w==
X-Received: by 2002:a17:906:d86:b0:a3d:7559:6ed1 with SMTP id m6-20020a1709060d8600b00a3d75596ed1mr7133954eji.4.1708286379688;
        Sun, 18 Feb 2024 11:59:39 -0800 (PST)
Received: from mkb-desktop.bosmans (89-224-201-31.ftth.glasoperator.nl. [31.201.224.89])
        by smtp.gmail.com with ESMTPSA id dt14-20020a170907728e00b00a3cbbaf5981sm2206999ejc.51.2024.02.18.11.59.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Feb 2024 11:59:39 -0800 (PST)
From: Maarten Bosmans <mkbosmans@gmail.com>
X-Google-Original-From: Maarten Bosmans <maarten.bosmans@vortech.nl>
To: git@vger.kernel.org
Cc: Maarten Bosmans <maarten.bosmans@vortech.nl>
Subject: [PATCH v2 1/5] log: Move show_blob_object() to log.c
Date: Sun, 18 Feb 2024 20:59:34 +0100
Message-Id: <20240218195938.6253-2-maarten.bosmans@vortech.nl>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240218195938.6253-1-maarten.bosmans@vortech.nl>
References: <20240205204932.16653-1-maarten.bosmans@vortech.nl>
 <20240218195938.6253-1-maarten.bosmans@vortech.nl>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Maarten Bosmans <mkbosmans@gmail.com>

From: Maarten Bosmans <maarten.bosmans@vortech.nl>

This way it can be used outside of builtin/log.c.
The next commit will make builtin/notes.c use it.

Signed-off-by: Maarten Bosmans <maarten.bosmans@vortech.nl>
---
 Makefile      |  1 +
 builtin/log.c | 39 +++++----------------------------------
 log.c         | 41 +++++++++++++++++++++++++++++++++++++++++
 log.h         | 11 +++++++++++
 4 files changed, 58 insertions(+), 34 deletions(-)
 create mode 100644 log.c
 create mode 100644 log.h

diff --git a/Makefile b/Makefile
index 78e874099d..1c19d5c0f3 100644
--- a/Makefile
+++ b/Makefile
@@ -1059,6 +1059,7 @@ LIB_OBJS += list-objects-filter-options.o
 LIB_OBJS += list-objects-filter.o
 LIB_OBJS += list-objects.o
 LIB_OBJS += lockfile.o
+LIB_OBJS += log.o
 LIB_OBJS += log-tree.o
 LIB_OBJS += ls-refs.o
 LIB_OBJS += mailinfo.o
diff --git a/builtin/log.c b/builtin/log.c
index db1808d7c1..587a4c374d 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -32,7 +32,6 @@
 #include "parse-options.h"
 #include "line-log.h"
 #include "branch.h"
-#include "streaming.h"
 #include "version.h"
 #include "mailmap.h"
 #include "progress.h"
@@ -42,7 +41,7 @@
 #include "range-diff.h"
 #include "tmp-objdir.h"
 #include "tree.h"
-#include "write-or-die.h"
+#include "log.h"
 
 #define MAIL_DEFAULT_WRAP 72
 #define COVER_FROM_AUTO_MAX_SUBJECT_LEN 100
@@ -653,37 +652,6 @@ static void show_tagger(const char *buf, struct rev_info *rev)
 	strbuf_release(&out);
 }
 
-static int show_blob_object(const struct object_id *oid, struct rev_info *rev, const char *obj_name)
-{
-	struct object_id oidc;
-	struct object_context obj_context;
-	char *buf;
-	unsigned long size;
-
-	fflush(rev->diffopt.file);
-	if (!rev->diffopt.flags.textconv_set_via_cmdline ||
-	    !rev->diffopt.flags.allow_textconv)
-		return stream_blob_to_fd(1, oid, NULL, 0);
-
-	if (get_oid_with_context(the_repository, obj_name,
-				 GET_OID_RECORD_PATH,
-				 &oidc, &obj_context))
-		die(_("not a valid object name %s"), obj_name);
-	if (!obj_context.path ||
-	    !textconv_object(the_repository, obj_context.path,
-			     obj_context.mode, &oidc, 1, &buf, &size)) {
-		free(obj_context.path);
-		return stream_blob_to_fd(1, oid, NULL, 0);
-	}
-
-	if (!buf)
-		die(_("git show %s: bad file"), obj_name);
-
-	write_or_die(1, buf, size);
-	free(obj_context.path);
-	return 0;
-}
-
 static int show_tag_object(const struct object_id *oid, struct rev_info *rev)
 {
 	unsigned long size;
@@ -770,7 +738,10 @@ int cmd_show(int argc, const char **argv, const char *prefix)
 		const char *name = rev.pending.objects[i].name;
 		switch (o->type) {
 		case OBJ_BLOB:
-			ret = show_blob_object(&o->oid, &rev, name);
+			fflush(rev.diffopt.file);
+			bool do_textconv = rev.diffopt.flags.textconv_set_via_cmdline &&
+				rev.diffopt.flags.allow_textconv;
+			ret = show_blob_object(&o->oid, name, do_textconv);
 			break;
 		case OBJ_TAG: {
 			struct tag *t = (struct tag *)o;
diff --git a/log.c b/log.c
new file mode 100644
index 0000000000..5c77707385
--- /dev/null
+++ b/log.c
@@ -0,0 +1,41 @@
+#include "git-compat-util.h"
+#include "gettext.h"
+#include "diff.h"
+#include "log.h"
+#include "notes.h"
+#include "object-name.h"
+#include "repository.h"
+#include "streaming.h"
+#include "write-or-die.h"
+
+/*
+ * Print blob contents to stdout.
+ */
+int show_blob_object(const struct object_id *oid, const char *obj_name, bool do_textconv)
+{
+	struct object_id oidc;
+	struct object_context obj_context;
+	char *buf;
+	unsigned long size;
+
+	if (!do_textconv)
+		return stream_blob_to_fd(1, oid, NULL, 0);
+
+	if (get_oid_with_context(the_repository, obj_name,
+				 GET_OID_RECORD_PATH,
+				 &oidc, &obj_context))
+		die(_("not a valid object name %s"), obj_name);
+	if (!obj_context.path ||
+	    !textconv_object(the_repository, obj_context.path,
+			     obj_context.mode, &oidc, 1, &buf, &size)) {
+		free(obj_context.path);
+		return stream_blob_to_fd(1, oid, NULL, 0);
+	}
+
+	if (!buf)
+		die(_("git show %s: bad file"), obj_name);
+
+	write_or_die(1, buf, size);
+	free(obj_context.path);
+	return 0;
+}
diff --git a/log.h b/log.h
new file mode 100644
index 0000000000..464cca52ff
--- /dev/null
+++ b/log.h
@@ -0,0 +1,11 @@
+#ifndef LOG_H
+#define LOG_H
+
+struct object_id;
+
+/*
+ * Print blob contents to stdout.
+ */
+int show_blob_object(const struct object_id *oid, const char *obj_name, bool do_textconv);
+
+#endif
-- 
2.35.3

