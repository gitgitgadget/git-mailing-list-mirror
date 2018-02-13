Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0A32B1F404
	for <e@80x24.org>; Tue, 13 Feb 2018 01:23:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933066AbeBMBXN (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Feb 2018 20:23:13 -0500
Received: from mail-pg0-f66.google.com ([74.125.83.66]:42778 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933195AbeBMBXJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Feb 2018 20:23:09 -0500
Received: by mail-pg0-f66.google.com with SMTP id y8so1511002pgr.9
        for <git@vger.kernel.org>; Mon, 12 Feb 2018 17:23:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=aul5nn8j2ZaIFQHkeG01wv2ClZ1ZUK0oDMwhCmNHEGY=;
        b=ArkgiUq1h9GPugPN4QSd7D2GnlHuHOJXl9k4q8YlOHnJa5AhogP2xuWbvEHwyxMmR1
         8uMripRQ24pdvkweOCVxXOx6Mlkwnm7mBvDCRem6EJ0oeZt5DGMrlggb6tUiP8XPyF0S
         okno8kMSw8NL9Z3y/ZGou3wOz6RXcDVAnnIuG7o3GoZ9wg54QRfDq9BwqEywQ2+sDQlJ
         tbxT+RFoGIGk7UX/Bo9m5Vy1WaQJdZK4EjifgGK+PYMSGeRhU7kBn2NbGYrRpPhbbg89
         UaQgkmDnXdnqXax2rufkwQIjnXcbUfxnorr+Qnk+8geNDpBiFRenh+RFNvzbtRf7WYmd
         XYDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=aul5nn8j2ZaIFQHkeG01wv2ClZ1ZUK0oDMwhCmNHEGY=;
        b=gaj375qgvupIV2s406I1ZD3X/FZEPzaiVvf3/92txJIhTqKkqeKb5+vk3onoHpzXV6
         6JH+WxgwzHfqcT2MXp4h4slvCkivNslreJ20ZtBXIGk+xXeR0jr00jN9DNAeGKD1kCd+
         cjp+AgNxphrqZ4Whzpbq77J9gyM9Oa0QxFjFVhv/HLubEFFMT1YZHuNQNjeKY9xbj3Pc
         RG05CjtAXiSZmtoUYWWOiUFsJDtkdWEUZ4Bn1sgGnwy0XOsPyuZzEA2TTOlr6QTtGe5a
         fxg/yVPyVQig6IZo4bxsao02WndSmWbBALjPK33w8aMLAAOP0fnlvqGJXnf6NGMzuo0r
         kLfQ==
X-Gm-Message-State: APf1xPBDC/N+hU6KFDk4dOiiVB3TgqYuzt+DIvitFssoSWYAZJhtJhP4
        JwDGfD/29gPKrt7i8cAAQgCDoshWE4E=
X-Google-Smtp-Source: AH8x226E3gKTztw+QzPfL8wmGKAZVHWSGi2fEFZPVoXtrjUfwNHIj3liQbbASjPz7SyB1mqkbQK4kA==
X-Received: by 10.98.9.138 with SMTP id 10mr3035368pfj.122.1518484988960;
        Mon, 12 Feb 2018 17:23:08 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id h8sm29511796pfk.121.2018.02.12.17.23.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 12 Feb 2018 17:23:08 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, pclouds@gmail.com, sunshine@sunshineco.com,
        jonathantanmy@google.com, Jonathan Nieder <jrnieder@gmail.com>,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH 15/26] sha1_file: add repository argument to sha1_file_name
Date:   Mon, 12 Feb 2018 17:22:30 -0800
Message-Id: <20180213012241.187007-16-sbeller@google.com>
X-Mailer: git-send-email 2.16.1.73.ga2c3e9663f.dirty
In-Reply-To: <20180213012241.187007-1-sbeller@google.com>
References: <20180213012241.187007-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jonathan Nieder <jrnieder@gmail.com>

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
 cache.h        |  8 --------
 http-walker.c  |  3 ++-
 http.c         |  5 +++--
 object-store.h |  9 +++++++++
 sha1_file.c    | 11 ++++++-----
 5 files changed, 20 insertions(+), 16 deletions(-)

diff --git a/cache.h b/cache.h
index 09d37cb651..4b01c0de10 100644
--- a/cache.h
+++ b/cache.h
@@ -956,14 +956,6 @@ extern void check_repository_format(void);
 #define DATA_CHANGED    0x0020
 #define TYPE_CHANGED    0x0040
 
-/*
- * Return the name of the file in the local object database that would
- * be used to store a loose object with the specified sha1.  The
- * return value is a pointer to a statically allocated buffer that is
- * overwritten each time the function is called.
- */
-extern const char *sha1_file_name(const unsigned char *sha1);
-
 /*
  * Return an abbreviated sha1 unique within this repository's object database.
  * The result will be at least `len` characters long, and will be NUL
diff --git a/http-walker.c b/http-walker.c
index a1c6f2639b..96873bdfed 100644
--- a/http-walker.c
+++ b/http-walker.c
@@ -1,4 +1,5 @@
 #include "cache.h"
+#include "repository.h"
 #include "commit.h"
 #include "walker.h"
 #include "http.h"
@@ -546,7 +547,7 @@ static int fetch_object(struct walker *walker, unsigned char *sha1)
 		ret = error("File %s has bad hash", hex);
 	} else if (req->rename < 0) {
 		ret = error("unable to write sha1 filename %s",
-			    sha1_file_name(req->sha1));
+			    sha1_file_name(the_repository, req->sha1));
 	}
 
 	release_http_object_request(req);
diff --git a/http.c b/http.c
index ab989b88dd..c7d2b74ce2 100644
--- a/http.c
+++ b/http.c
@@ -2181,7 +2181,7 @@ struct http_object_request *new_http_object_request(const char *base_url,
 	hashcpy(freq->sha1, sha1);
 	freq->localfile = -1;
 
-	filename = sha1_file_name(sha1);
+	filename = sha1_file_name(the_repository, sha1);
 	snprintf(freq->tmpfile, sizeof(freq->tmpfile),
 		 "%s.temp", filename);
 
@@ -2329,7 +2329,8 @@ int finish_http_object_request(struct http_object_request *freq)
 		return -1;
 	}
 	freq->rename =
-		finalize_object_file(freq->tmpfile, sha1_file_name(freq->sha1));
+		finalize_object_file(freq->tmpfile,
+				     sha1_file_name(the_repository, freq->sha1));
 
 	return freq->rename;
 }
diff --git a/object-store.h b/object-store.h
index add1d4e27c..5422e80c08 100644
--- a/object-store.h
+++ b/object-store.h
@@ -61,6 +61,15 @@ struct packed_git {
 	char pack_name[FLEX_ARRAY]; /* more */
 };
 
+/*
+ * Return the name of the file in a repository's local object database
+ * that would be used to store a loose object with the specified sha1.
+ * The return value is a pointer to a statically allocated buffer that
+ * is overwritten each time the function is called.
+ */
+#define sha1_file_name(r, s) sha1_file_name_##r(s)
+const char *sha1_file_name_the_repository(const unsigned char *sha1);
+
 void prepare_alt_odb(struct repository *r);
 
 #endif /* OBJECT_STORE_H */
diff --git a/sha1_file.c b/sha1_file.c
index f046d560f8..65fefdf4ac 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -323,7 +323,7 @@ static void fill_sha1_path(struct strbuf *buf, const unsigned char *sha1)
 	}
 }
 
-const char *sha1_file_name(const unsigned char *sha1)
+const char *sha1_file_name_the_repository(const unsigned char *sha1)
 {
 	static struct strbuf buf = STRBUF_INIT;
 
@@ -721,7 +721,8 @@ int check_and_freshen_file(const char *fn, int freshen)
 
 static int check_and_freshen_local(const unsigned char *sha1, int freshen)
 {
-	return check_and_freshen_file(sha1_file_name(sha1), freshen);
+	return check_and_freshen_file(sha1_file_name(the_repository, sha1),
+				      freshen);
 }
 
 static int check_and_freshen_nonlocal(const unsigned char *sha1, int freshen)
@@ -878,7 +879,7 @@ static int stat_sha1_file(const unsigned char *sha1, struct stat *st,
 {
 	struct alternate_object_database *alt;
 
-	*path = sha1_file_name(sha1);
+	*path = sha1_file_name(the_repository, sha1);
 	if (!lstat(*path, st))
 		return 0;
 
@@ -903,7 +904,7 @@ static int open_sha1_file(const unsigned char *sha1, const char **path)
 	struct alternate_object_database *alt;
 	int most_interesting_errno;
 
-	*path = sha1_file_name(sha1);
+	*path = sha1_file_name(the_repository, sha1);
 	fd = git_open(*path);
 	if (fd >= 0)
 		return fd;
@@ -1568,7 +1569,7 @@ static int write_loose_object(const unsigned char *sha1, char *hdr, int hdrlen,
 	git_SHA_CTX c;
 	unsigned char parano_sha1[20];
 	static struct strbuf tmp_file = STRBUF_INIT;
-	const char *filename = sha1_file_name(sha1);
+	const char *filename = sha1_file_name(the_repository, sha1);
 
 	fd = create_tmpfile(&tmp_file, filename);
 	if (fd < 0) {
-- 
2.16.1.73.ga2c3e9663f.dirty

