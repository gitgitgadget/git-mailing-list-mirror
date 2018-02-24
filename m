Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 01B4C1F404
	for <e@80x24.org>; Sat, 24 Feb 2018 00:48:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752598AbeBXAsY (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Feb 2018 19:48:24 -0500
Received: from mail-pf0-f196.google.com ([209.85.192.196]:39985 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751674AbeBXAsV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Feb 2018 19:48:21 -0500
Received: by mail-pf0-f196.google.com with SMTP id m5so4186647pff.7
        for <git@vger.kernel.org>; Fri, 23 Feb 2018 16:48:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=BXsAK7tTx3pUoLj/hAciXWuNRpPfNxXnLUHgjTDo2Ds=;
        b=VE8Y1WasCWXdX1nEZAWVmIYcI4XID30bXjMyrESKC8fawVY7ZoWif8koj5HJbdqET4
         IdCw4RqwKZzdT2gcbuInqUFsEnZUZP2s5OP5s/VrWJpcFqL21R7X3Pi9pdO0RGaoudXa
         +gDQmKRAny1HpJ9JOmahsm66booVdzLlBVgzO0GShgCDVFOQkLNfrgsjlf+SYc5VuFBk
         O73fh8vsRgAA98Be5D3SxbZKSvgkVWUqvhvk4ZP2B03ofOVgoktaC1dp5FgdNMkqxJnW
         d3KVWC3X7vXYBakOgI4asSAa65g1nDS874JfZUo47VKkJRwfOd3C8bqzm/jjxl3RtPa0
         thnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=BXsAK7tTx3pUoLj/hAciXWuNRpPfNxXnLUHgjTDo2Ds=;
        b=nJqDOc7EXl+AtvzZ97Fr4vUeqPP+RR6mCFRXmbrvPWLhOf5FMbUrpSKmXAhsRP4bHM
         suJ4OjAJki8mNMzKPSDCnE++CoTqoms4hy+Dw7sh0267mamOpefBsgblns9gxygz1eTN
         yK4uKQbhAYTyNkrQAxlkM0liZpKPzgwIBgp/m6UVSwoEccnk08jgDg1onEQQAAkcQehO
         JjHgsdIARTmLENVreW047br4HKvnhZz3PukhE7flIJh7ALiQcXbLel4qjtz9nevBrRw0
         7UtPgbgbmNMmXj/v0eJfTOwJTBy0V/V4dk91fxqIDPmKfLi+/OdNq6KzFo/NUdmrgG46
         /O/w==
X-Gm-Message-State: APf1xPBXoXfA4VKsLDH8ejlvwoaiZAzkeL1IUP+F3GZhQehqHqV8j2M6
        0h9RQJfXzQnIgsjAEnYa6ls+eThyHak=
X-Google-Smtp-Source: AH8x226xFMvIpfa7LqaFnXxygz106ZEPxZC+gMCDpVs5F4gmo2m9hq/kY3zL3rrXn9yy/HhDXcM4Ng==
X-Received: by 10.99.141.200 with SMTP id z191mr2731864pgd.418.1519433300662;
        Fri, 23 Feb 2018 16:48:20 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id y6sm4250722pfg.138.2018.02.23.16.48.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 23 Feb 2018 16:48:20 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     git@vger.kernel.org, gitster@pobox.com, jonathantanmy@google.com,
        pclouds@gmail.com, sunshine@sunshineco.com, bmwill@google.com,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCHv4 16/27] sha1_file: add repository argument to sha1_file_name
Date:   Fri, 23 Feb 2018 16:47:43 -0800
Message-Id: <20180224004754.129721-17-sbeller@google.com>
X-Mailer: git-send-email 2.16.1.291.g4437f3f132-goog
In-Reply-To: <20180224004754.129721-1-sbeller@google.com>
References: <20180221015430.96054-1-sbeller@google.com>
 <20180224004754.129721-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a repository argument to allow sha1_file_name callers to be more
specific about which repository to handle. This is a small mechanical
change; it doesn't change the implementation to handle repositories
other than the_repository yet.

As with the previous commits, use a macro to catch callers passing a
repository other than the_repository at compile time.

While at it, move the declaration to object-store.h, where it should
be easier to find.

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 cache.h        |  6 ------
 http-walker.c  |  3 ++-
 http.c         |  5 ++---
 object-store.h |  7 +++++++
 sha1_file.c    | 10 +++++-----
 5 files changed, 16 insertions(+), 15 deletions(-)

diff --git a/cache.h b/cache.h
index 63889acb591..94d85a5c692 100644
--- a/cache.h
+++ b/cache.h
@@ -936,12 +936,6 @@ extern void check_repository_format(void);
 #define DATA_CHANGED    0x0020
 #define TYPE_CHANGED    0x0040
 
-/*
- * Put in `buf` the name of the file in the local object database that
- * would be used to store a loose object with the specified sha1.
- */
-extern void sha1_file_name(struct strbuf *buf, const unsigned char *sha1);
-
 /*
  * Return an abbreviated sha1 unique within this repository's object database.
  * The result will be at least `len` characters long, and will be NUL
diff --git a/http-walker.c b/http-walker.c
index 07c2b1af826..2c33969123a 100644
--- a/http-walker.c
+++ b/http-walker.c
@@ -1,4 +1,5 @@
 #include "cache.h"
+#include "repository.h"
 #include "commit.h"
 #include "walker.h"
 #include "http.h"
@@ -545,7 +546,7 @@ static int fetch_object(struct walker *walker, unsigned char *sha1)
 		ret = error("File %s has bad hash", hex);
 	} else if (req->rename < 0) {
 		struct strbuf buf = STRBUF_INIT;
-		sha1_file_name(&buf, req->sha1);
+		sha1_file_name(the_repository, &buf, req->sha1);
 		ret = error("unable to write sha1 filename %s", buf.buf);
 		strbuf_release(&buf);
 	}
diff --git a/http.c b/http.c
index 31755023a4f..df9dbea59c5 100644
--- a/http.c
+++ b/http.c
@@ -2246,7 +2246,7 @@ struct http_object_request *new_http_object_request(const char *base_url,
 	hashcpy(freq->sha1, sha1);
 	freq->localfile = -1;
 
-	sha1_file_name(&filename, sha1);
+	sha1_file_name(the_repository, &filename, sha1);
 	snprintf(freq->tmpfile, sizeof(freq->tmpfile),
 		 "%s.temp", filename.buf);
 
@@ -2395,8 +2395,7 @@ int finish_http_object_request(struct http_object_request *freq)
 		unlink_or_warn(freq->tmpfile);
 		return -1;
 	}
-
-	sha1_file_name(&filename, freq->sha1);
+	sha1_file_name(the_repository, &filename, freq->sha1);
 	freq->rename = finalize_object_file(freq->tmpfile, filename.buf);
 	strbuf_release(&filename);
 
diff --git a/object-store.h b/object-store.h
index 24b9a750aef..c0d1292cfc2 100644
--- a/object-store.h
+++ b/object-store.h
@@ -113,4 +113,11 @@ struct raw_object_store {
 
 void raw_object_store_clear(struct raw_object_store *o);
 
+/*
+ * Put in `buf` the name of the file in the local object database that
+ * would be used to store a loose object with the specified sha1.
+ */
+#define sha1_file_name(r, b, s) sha1_file_name_##r(b, s)
+void sha1_file_name_the_repository(struct strbuf *buf, const unsigned char *sha1);
+
 #endif /* OBJECT_STORE_H */
diff --git a/sha1_file.c b/sha1_file.c
index 03b9bbe8bb7..8ef2f856035 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -321,7 +321,7 @@ static void fill_sha1_path(struct strbuf *buf, const unsigned char *sha1)
 	}
 }
 
-void sha1_file_name(struct strbuf *buf, const unsigned char *sha1)
+void sha1_file_name_the_repository(struct strbuf *buf, const unsigned char *sha1)
 {
 	strbuf_addstr(buf, get_object_directory());
 	strbuf_addch(buf, '/');
@@ -715,7 +715,7 @@ static int check_and_freshen_local(const unsigned char *sha1, int freshen)
 	static struct strbuf buf = STRBUF_INIT;
 
 	strbuf_reset(&buf);
-	sha1_file_name(&buf, sha1);
+	sha1_file_name(the_repository, &buf, sha1);
 
 	return check_and_freshen_file(buf.buf, freshen);
 }
@@ -876,7 +876,7 @@ static int stat_sha1_file(const unsigned char *sha1, struct stat *st,
 	static struct strbuf buf = STRBUF_INIT;
 
 	strbuf_reset(&buf);
-	sha1_file_name(&buf, sha1);
+	sha1_file_name(the_repository, &buf, sha1);
 	*path = buf.buf;
 
 	if (!lstat(*path, st))
@@ -905,7 +905,7 @@ static int open_sha1_file(const unsigned char *sha1, const char **path)
 	static struct strbuf buf = STRBUF_INIT;
 
 	strbuf_reset(&buf);
-	sha1_file_name(&buf, sha1);
+	sha1_file_name(the_repository, &buf, sha1);
 	*path = buf.buf;
 
 	fd = git_open(*path);
@@ -1591,7 +1591,7 @@ static int write_loose_object(const struct object_id *oid, char *hdr,
 	static struct strbuf filename = STRBUF_INIT;
 
 	strbuf_reset(&filename);
-	sha1_file_name(&filename, oid->hash);
+	sha1_file_name(the_repository, &filename, oid->hash);
 
 	fd = create_tmpfile(&tmp_file, filename.buf);
 	if (fd < 0) {
-- 
2.16.1.291.g4437f3f132-goog

