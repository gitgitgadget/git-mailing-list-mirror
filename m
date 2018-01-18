Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1A5711FADF
	for <e@80x24.org>; Thu, 18 Jan 2018 14:52:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932570AbeAROwQ (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Jan 2018 09:52:16 -0500
Received: from mail-lf0-f66.google.com ([209.85.215.66]:41200 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756634AbeAROvN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Jan 2018 09:51:13 -0500
Received: by mail-lf0-f66.google.com with SMTP id f136so5536376lff.8
        for <git@vger.kernel.org>; Thu, 18 Jan 2018 06:51:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:in-reply-to
         :references;
        bh=tiOu3ktLrgolnxtE/ky7PpTnKLW65BXt4M1J48Cz/Tc=;
        b=OVjZbglSSnSBB8DucOu9ZI2bJzWYPpwvhTRjI4cbVwZ39JomyWyKR8jyvH1QH2QKry
         nqzk+6kUFt8RVrLVWXYpz4aNDnT8oGfVdtXRQC45Dcpriet+umQwhTF6EZBXZBH3vpN6
         EIyMEVth08ot46MxdARmgHbg4HNk5WTceYPpHC72+G4BhyMjRrcSU8543Ec0dc0B6lfe
         +hWreUOByCEyvNuSIffSJXsB6N/Hn2sQR24Dyg+rFRIC2DGBy2gbYLDhqzjH6ObOOcj9
         XOGLuEs/T5msg3stg+cPoegYjMuibwWGRHqEF4B6YWr9aS2I+kofS8fCYU+DW/SqtATw
         WD2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=tiOu3ktLrgolnxtE/ky7PpTnKLW65BXt4M1J48Cz/Tc=;
        b=K6MsBqktnMnGIoFOGCLh07aYTOHTFiEUSi870BxuE8l531ifbh7r7jEwJM/710o7dM
         M9ya7wyUGkIy8xwkcdqZ+fP5Blj/a9jupUduUVshXXKLmJ/RAT0L8dRlIf9B1co6Rm1W
         wWvbi80pJTkWppxLsc13ba3+Om7uTfv1I5/hHEuD/mtmvCj6fHKYF68hBZVY/sXeNQCa
         BSxx3E/MG9kHehduabdFJirqjc9aMzlTJH9Gyu307q8nXhswuWTJY+1Rh9FalmRzvpPw
         ioPndkOA/90LgHxtpoxxHWoJ8kr5364oYlqN6wK4m/PhNRUba+WZzR4j/ZpswLxsktnq
         sTog==
X-Gm-Message-State: AKwxytc2xNgL6pZ5WIFtOtNHrMYK3X05iDRAmVVDnjdWsZa34HtIO+Dy
        3LKktr9RuhSuThd4m4JtdzLJrojEIsM=
X-Google-Smtp-Source: ACJfBoutNwMvZ1KbKEifpUmmpkh4+N5OCwHOzuiUxbIM3gOhqLg6gWz9in8BLC26nljHQ/dVuCEANQ==
X-Received: by 10.25.22.2 with SMTP id m2mr17992096lfi.21.1516287071936;
        Thu, 18 Jan 2018 06:51:11 -0800 (PST)
Received: from localhost.localdomain ([188.121.16.104])
        by smtp.gmail.com with ESMTPSA id 23sm560988lju.28.2018.01.18.06.51.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 18 Jan 2018 06:51:10 -0800 (PST)
From:   Patryk Obara <patryk.obara@gmail.com>
To:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        "brian m . carlson" <sandals@crustytoothpaste.ath.cx>
Subject: [PATCH 03/11] sha1_file: convert pretend_sha1_file to object_id
Date:   Thu, 18 Jan 2018 15:50:55 +0100
Message-Id: <94b8f264f241866fa175abfa25f4ab096e0b11c5.1516282880.git.patryk.obara@gmail.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <cover.1516282880.git.patryk.obara@gmail.com>
References: <cover.1516282880.git.patryk.obara@gmail.com>
In-Reply-To: <cover.1516282880.git.patryk.obara@gmail.com>
References: <cover.1516282880.git.patryk.obara@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Convert the declaration and definition of pretend_sha1_file to use
struct object_id and adjust all usages of this function.

Signed-off-by: Patryk Obara <patryk.obara@gmail.com>
---
 blame.c     | 2 +-
 cache.h     | 3 ++-
 sha1_file.c | 8 ++++----
 3 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/blame.c b/blame.c
index 2893f3c103..2ad656c1be 100644
--- a/blame.c
+++ b/blame.c
@@ -232,7 +232,7 @@ static struct commit *fake_working_tree_commit(struct diff_options *opt,
 	convert_to_git(&the_index, path, buf.buf, buf.len, &buf, 0);
 	origin->file.ptr = buf.buf;
 	origin->file.size = buf.len;
-	pretend_sha1_file(buf.buf, buf.len, OBJ_BLOB, origin->blob_oid.hash);
+	pretend_sha1_file(buf.buf, buf.len, OBJ_BLOB, &origin->blob_oid);
 
 	/*
 	 * Read the current index, replace the path entry with
diff --git a/cache.h b/cache.h
index d8b975a571..8ed75d7260 100644
--- a/cache.h
+++ b/cache.h
@@ -1241,7 +1241,8 @@ extern int sha1_object_info(const unsigned char *, unsigned long *);
 extern int hash_sha1_file(const void *buf, unsigned long len, const char *type, unsigned char *sha1);
 extern int write_sha1_file(const void *buf, unsigned long len, const char *type, unsigned char *return_sha1);
 extern int hash_sha1_file_literally(const void *buf, unsigned long len, const char *type, struct object_id *oid, unsigned flags);
-extern int pretend_sha1_file(void *, unsigned long, enum object_type, unsigned char *);
+extern int pretend_sha1_file(void *, unsigned long, enum object_type,
+			     struct object_id *oid);
 extern int force_object_loose(const unsigned char *sha1, time_t mtime);
 extern int git_open_cloexec(const char *name, int flags);
 #define git_open(name) git_open_cloexec(name, O_RDONLY)
diff --git a/sha1_file.c b/sha1_file.c
index 3da70ac650..dc8adb9d17 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1313,12 +1313,12 @@ static void *read_object(const unsigned char *sha1, enum object_type *type,
 }
 
 int pretend_sha1_file(void *buf, unsigned long len, enum object_type type,
-		      unsigned char *sha1)
+		      struct object_id *oid)
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

