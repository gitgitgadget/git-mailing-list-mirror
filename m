Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 18CA91F424
	for <e@80x24.org>; Mon, 22 Jan 2018 11:04:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751134AbeAVLEr (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 Jan 2018 06:04:47 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:45503 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751024AbeAVLEp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Jan 2018 06:04:45 -0500
Received: by mail-wm0-f66.google.com with SMTP id i186so15494644wmi.4
        for <git@vger.kernel.org>; Mon, 22 Jan 2018 03:04:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:in-reply-to
         :references;
        bh=NCwH7PFBP7cLZVKGZ4yeDdmYWg8o5l0lARduKpkpQ5o=;
        b=n+H9D0R26ZJaBIUOsvw1bXl3TXjSN/i6GoiOs0SpXTpY0VVAjFuRDNhKs0vwiQjbdv
         vrtlWD7SEifToGhXGAt3ng4ciOk06jSEX+bMJJmUvqHky5ociUqumCrXrHpnBFObbOp0
         eg0XQ4s65Bo5cAp9hzpA13pOnZvtHdbro/EW6tck9EUpOy0sCTltv+Luy/lGMuglrdjT
         r0r9hZlo2IGCSA7XsLhNaqdpomCCUPlUByMUSyTIW4hrOOXHQUvcWiPT8QVQt7uFKKCU
         OEs2AHt9/IYydK2OiQwjle1C/s8JyLeegEuBlrLqpRNSmBuvpXbHBIBKrZ7Kf4+xMR6f
         1QdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=NCwH7PFBP7cLZVKGZ4yeDdmYWg8o5l0lARduKpkpQ5o=;
        b=Hlt7RSM3yIo5/9QaOd8Dnj6qgJLmAioGPGxA4tZ5uNAIElpA5xhJDcg55TD0eJgWJQ
         YPO0dFnqyB0H2VTxCeQRnTgZwi1MbdH+YXTl6M0H8M+gPNMuC62ZxGUWsMPkZIixgs82
         v8CEWc2mJaz0Y0PUaSLOWiuYxVNoIwB/2ZhQ59/JKjCFQFuXlZiATGCRA7Lzs6uwzYC0
         ppCPlY9yBY+xisaeN/JJiyXXy+QWjal8KGFPf/zx9WmDlp6SRCdHxGFWASMyHuzb5YpF
         3jz/kv40mvDOkLDvIiIDXz15kC6pECc6pWLg/2Kxvom3SuS3RH+pH4xi4uzSL/BIlDPX
         hJlw==
X-Gm-Message-State: AKwxytcD0+z5H3giu9Oz+wdc1kSQBDtQatibiBk3aeiqXdScX7FPLbd6
        XnYw2wgc5yEfrWmrCC4tpuOneuFQ
X-Google-Smtp-Source: AH8x225gKBPh8TtbfDpR1kfNYt5IlBWlkB2KfeIk6EnCjkaQhNFi5W43DK0+CawgyfDwTVfJP7TpjQ==
X-Received: by 10.80.166.98 with SMTP id d89mr13036426edc.34.1516619083805;
        Mon, 22 Jan 2018 03:04:43 -0800 (PST)
Received: from localhost.localdomain ([188.121.16.104])
        by smtp.gmail.com with ESMTPSA id e12sm10833591edm.42.2018.01.22.03.04.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 22 Jan 2018 03:04:43 -0800 (PST)
From:   Patryk Obara <patryk.obara@gmail.com>
To:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        sandals@crustytoothpaste.ath.cx,
        Jonathan Tan <jonathantanmy@google.com>
Subject: [PATCH v2 03/14] sha1_file: convert pretend_sha1_file to object_id
Date:   Mon, 22 Jan 2018 12:04:26 +0100
Message-Id: <3dd965c82e84e8f0e42fa343f0665ca1a47684a8.1516617960.git.patryk.obara@gmail.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <cover.1516617960.git.patryk.obara@gmail.com>
References: <cover.1516282880.git.patryk.obara@gmail.com>
 <cover.1516617960.git.patryk.obara@gmail.com>
In-Reply-To: <cover.1516617960.git.patryk.obara@gmail.com>
References: <cover.1516617960.git.patryk.obara@gmail.com>
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

