Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A71081F404
	for <e@80x24.org>; Sun, 28 Jan 2018 00:13:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752321AbeA1AN3 (ORCPT <rfc822;e@80x24.org>);
        Sat, 27 Jan 2018 19:13:29 -0500
Received: from mail-lf0-f68.google.com ([209.85.215.68]:38517 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751839AbeA1AN1 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Jan 2018 19:13:27 -0500
Received: by mail-lf0-f68.google.com with SMTP id g72so5028639lfg.5
        for <git@vger.kernel.org>; Sat, 27 Jan 2018 16:13:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:in-reply-to
         :references;
        bh=NCwH7PFBP7cLZVKGZ4yeDdmYWg8o5l0lARduKpkpQ5o=;
        b=RwTs0xSLbG0YkpjZ0gxkcm/wTW3L5JoDhf+13Vcjjosu6clB+u3Py7UO+dlE9irqoN
         A1+pe7TSwnluoGXKAcIXr+QgZXQe2/Ot8EOTSJSoms7VcjAOq0hgG2JHm/ifsWRoDOFp
         fOrJo3rwuiB1Excb5qCbxMgWnfre8Ol+ax4qdA9f2VU4gzH/RADTibgE87ZE/2Zx6oTU
         iNmcYAB5hEGGSot2NiZXYZfZQ+Q0dDPRYvIYxe6eCpDjJhpuwfokHgYAdnW4ybLv7/JE
         lwbJVtAXuNkxCJFLvh3hhGaJSkqJ+7qUv8Tz4EN4qz/cc+XZHjQVsHqbjUJTE18SgZWT
         2QSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=NCwH7PFBP7cLZVKGZ4yeDdmYWg8o5l0lARduKpkpQ5o=;
        b=kmi8xvzof6CfcPFUUmnQ7I13YmRqY1yMdz5owl2yR9SQiaUkCWguARPjRlP+sAmlNH
         gzzSKrm8K7m3CwWoz6EEbQ/RGHDke3Gj40Z6CPgA2pyxIYrekwm/k217PwNxigy7k4na
         DYZQJd3pSfN4aA6K4yTeyxUv/jBYBDEZnZURVXHjcl7/pgdTkf3DJMcunSbXT6akWm/v
         v5twLkHqKZSJMwcaIM7acHV0+DUnNWRIEspz57m26IqAkblp05s0fJG8zAvAYqOSyqX3
         WazoW4kuwZoR1XThVtRyXlKsWOCxZ6b+5yNPE6hvwazJH8hn2Jh0GsWyA8eTsIoWNqE5
         L4Qg==
X-Gm-Message-State: AKwxytclxAsBNH+L81slyK7M3t+CBk8VYP4dOI7jVHmr3nsIOovSFfK4
        7bB0gyfWvURSj3A7tdZL5xotfaLX
X-Google-Smtp-Source: AH8x227ly4ViLLcUUhiqsVGit1qJRwN26m4Ljr3EwL7qglgLAc3XNv4TxRBOCoXOV09Y8Shr6wQrSw==
X-Received: by 10.46.64.155 with SMTP id r27mr2677066lje.149.1517098405569;
        Sat, 27 Jan 2018 16:13:25 -0800 (PST)
Received: from localhost.localdomain ([188.121.16.104])
        by smtp.gmail.com with ESMTPSA id y26sm2144695lfk.30.2018.01.27.16.13.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 27 Jan 2018 16:13:24 -0800 (PST)
From:   Patryk Obara <patryk.obara@gmail.com>
To:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v4 01/12] sha1_file: convert pretend_sha1_file to object_id
Date:   Sun, 28 Jan 2018 01:13:11 +0100
Message-Id: <d154b8b52844dfe5ed73f66ab223fcc92e986e7d.1517097306.git.patryk.obara@gmail.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <cover.1517097306.git.patryk.obara@gmail.com>
References: <cover.1516790478.git.patryk.obara@gmail.com>
 <cover.1517097306.git.patryk.obara@gmail.com>
In-Reply-To: <cover.1517097306.git.patryk.obara@gmail.com>
References: <cover.1517097306.git.patryk.obara@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Convert the declaration and definition of pretend_sha1_file to use
struct object_id and adjust all usages of this function.  Rename it to
pretend_object_file.

Signed-off-by: Patryk Obara <patryk.obara@gmail.com>
---
 Documentation/technical/api-object-access.txt |  2 +-
 blame.c                                       |  2 +-
 cache.h                                       |  5 ++++-
 sha1_file.c                                   | 10 +++++-----
 4 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/Documentation/technical/api-object-access.txt b/Documentation/technical/api-object-access.txt
index 03bb0e950d..a1162e5bcd 100644
--- a/Documentation/technical/api-object-access.txt
+++ b/Documentation/technical/api-object-access.txt
@@ -7,7 +7,7 @@ Talk about <sha1_file.c> and <object.h> family, things like
 * read_object_with_reference()
 * has_sha1_file()
 * write_sha1_file()
-* pretend_sha1_file()
+* pretend_object_file()
 * lookup_{object,commit,tag,blob,tree}
 * parse_{object,commit,tag,blob,tree}
 * Use of object flags
diff --git a/blame.c b/blame.c
index 2893f3c103..1fc22b304b 100644
--- a/blame.c
+++ b/blame.c
@@ -232,7 +232,7 @@ static struct commit *fake_working_tree_commit(struct diff_options *opt,
 	convert_to_git(&the_index, path, buf.buf, buf.len, &buf, 0);
 	origin->file.ptr = buf.buf;
 	origin->file.size = buf.len;
-	pretend_sha1_file(buf.buf, buf.len, OBJ_BLOB, origin->blob_oid.hash);
+	pretend_object_file(buf.buf, buf.len, OBJ_BLOB, &origin->blob_oid);
 
 	/*
 	 * Read the current index, replace the path entry with
diff --git a/cache.h b/cache.h
index d8b975a571..e4e03ac51d 100644
--- a/cache.h
+++ b/cache.h
@@ -1241,7 +1241,10 @@ extern int sha1_object_info(const unsigned char *, unsigned long *);
 extern int hash_sha1_file(const void *buf, unsigned long len, const char *type, unsigned char *sha1);
 extern int write_sha1_file(const void *buf, unsigned long len, const char *type, unsigned char *return_sha1);
 extern int hash_sha1_file_literally(const void *buf, unsigned long len, const char *type, struct object_id *oid, unsigned flags);
-extern int pretend_sha1_file(void *, unsigned long, enum object_type, unsigned char *);
+
+extern int pretend_object_file(void *, unsigned long, enum object_type,
+			       struct object_id *oid);
+
 extern int force_object_loose(const unsigned char *sha1, time_t mtime);
 extern int git_open_cloexec(const char *name, int flags);
 #define git_open(name) git_open_cloexec(name, O_RDONLY)
diff --git a/sha1_file.c b/sha1_file.c
index 3da70ac650..830b93b428 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1312,13 +1312,13 @@ static void *read_object(const unsigned char *sha1, enum object_type *type,
 	return content;
 }
 
-int pretend_sha1_file(void *buf, unsigned long len, enum object_type type,
-		      unsigned char *sha1)
+int pretend_object_file(void *buf, unsigned long len, enum object_type type,
+			struct object_id *oid)
 {
 	struct cached_object *co;
 
-	hash_sha1_file(buf, len, typename(type), sha1);
-	if (has_sha1_file(sha1) || find_cached_object(sha1))
+	hash_sha1_file(buf, len, typename(type), oid->hash);
+	if (has_sha1_file(oid->hash) || find_cached_object(oid->hash))
 		return 0;
 	ALLOC_GROW(cached_objects, cached_object_nr + 1, cached_object_alloc);
 	co = &cached_objects[cached_object_nr++];
@@ -1326,7 +1326,7 @@ int pretend_sha1_file(void *buf, unsigned long len, enum object_type type,
 	co->type = type;
 	co->buf = xmalloc(len);
 	memcpy(co->buf, buf, len);
-	hashcpy(co->sha1, sha1);
+	hashcpy(co->sha1, oid->hash);
 	return 0;
 }
 
-- 
2.14.3

