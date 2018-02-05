Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7FADF1F404
	for <e@80x24.org>; Mon,  5 Feb 2018 23:57:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751837AbeBEX5r (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Feb 2018 18:57:47 -0500
Received: from mail-pg0-f65.google.com ([74.125.83.65]:40429 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750964AbeBEX5p (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Feb 2018 18:57:45 -0500
Received: by mail-pg0-f65.google.com with SMTP id g2so113550pgn.7
        for <git@vger.kernel.org>; Mon, 05 Feb 2018 15:57:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=HOLiDkRURXek/Knw/nwCBgt4gWqFFHbTu1/w9BOd3rU=;
        b=qStIPpZdbZ/U7DolXBeXoB+11eva7v7IQiE6MOUTKqElFCD+SND7KURtvhu1M86/AW
         epvS/idOsXhOY0dlflOMx3T+oIuGSDdeYAS8OIBw5FXyYruV1x4pCQj7ENSscycAtOTg
         ce9VsCNNki2HYq+pzGZ8xSPlwMOvrO+r4HvqfbFDCRFoaQ1alzBF2vCPxyEzF3WO64fx
         ZBgg2HkW9FhvSiroNQRirNd4Sl4NJpuL30aq+38+zFizql4anS68TsgBiIT6PBb5Kcjp
         l6DZzaKOe015fKAb/flZPB+j6hV6LMAGzxLAGPLalXShLqYtEwCgam/cXKtD6C44GIkw
         I/EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=HOLiDkRURXek/Knw/nwCBgt4gWqFFHbTu1/w9BOd3rU=;
        b=toyIkTUdG8nrQ5LUzLRnRow3zYK60EgSSxO6GyiPI5wGoPB8NRfJbriKv8XXD0gg53
         JbKJRJlwFYMNNg0uxEuf1SUH+tMzkuisd2rjBteKazjTWlAMwyPDB5XL2PRwusCjCyhY
         TJHID0fzY+0tX9B3HwlXwf/ykDXLxUXVSfTxQ7AllLdXJan5kT7vkQ8BGIKIf1a+8FE+
         dc2+67QnuOsnP1rrclFjkEmtmkpP8zbL4lEIgzadQwQE0U3ORipiZCGbFtqRn4Kv1n4n
         zqjhYvhiHXEi0UmFCDJobCReho2AegEBkL+vLTzsgDyRlnEFT9wxVhClSuQ5MLLrbsdg
         CXcw==
X-Gm-Message-State: APf1xPCNM9r4DBl+vAlmHSP/jssn/wJLsQZikmZSK2USgG4U0WNNn8iz
        GwA9w9coab9uzuo6Myy11UkKORTsmko=
X-Google-Smtp-Source: AH8x224LIfTBsCNjdiYEc2LwQSmgii3kjx7kZd5Z1zTuNmF78RcQ0DGVXdX20UQ2Bs0mtxSN7xJGRA==
X-Received: by 10.99.149.8 with SMTP id p8mr387432pgd.186.1517875064501;
        Mon, 05 Feb 2018 15:57:44 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id e71sm10855837pgc.79.2018.02.05.15.57.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Feb 2018 15:57:43 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH 022/194] pack: add repository argument to sha1_file_name
Date:   Mon,  5 Feb 2018 15:54:43 -0800
Message-Id: <20180205235735.216710-2-sbeller@google.com>
X-Mailer: git-send-email 2.15.1.433.g936d1b9894.dirty
In-Reply-To: <20180205235735.216710-1-sbeller@google.com>
References: <20180205235508.216277-1-sbeller@google.com>
 <20180205235735.216710-1-sbeller@google.com>
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
index bba53f356d..63ed5ccf0a 100644
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
index 979d9b3e46..ad57476635 100644
--- a/http.c
+++ b/http.c
@@ -2182,7 +2182,7 @@ struct http_object_request *new_http_object_request(const char *base_url,
 	hashcpy(freq->sha1, sha1);
 	freq->localfile = -1;
 
-	filename = sha1_file_name(sha1);
+	filename = sha1_file_name(the_repository, sha1);
 	snprintf(freq->tmpfile, sizeof(freq->tmpfile),
 		 "%s.temp", filename);
 
@@ -2330,7 +2330,8 @@ int finish_http_object_request(struct http_object_request *freq)
 		return -1;
 	}
 	freq->rename =
-		finalize_object_file(freq->tmpfile, sha1_file_name(freq->sha1));
+		finalize_object_file(freq->tmpfile,
+				     sha1_file_name(the_repository, freq->sha1));
 
 	return freq->rename;
 }
diff --git a/object-store.h b/object-store.h
index eef8d3b653..228c2ce8ae 100644
--- a/object-store.h
+++ b/object-store.h
@@ -54,6 +54,15 @@ struct packed_git {
 	char pack_name[FLEX_ARRAY]; /* more */
 };
 
+/*
+ * Return the name of the file in a repository's local object database
+ * that would be used to store a loose object with the specified sha1.
+ * The return value is a pointer to a statically allocated buffer that
+ * is overwritten each time the function is called.
+ */
+#define sha1_file_name(r, s) sha1_file_name_##r(s)
+extern const char *sha1_file_name_the_repository(const unsigned char *sha1);
+
 #define prepare_alt_odb(r) prepare_alt_odb_##r()
 extern void prepare_alt_odb_the_repository(void);
 
diff --git a/sha1_file.c b/sha1_file.c
index f6e982880e..caad178b14 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -323,7 +323,7 @@ static void fill_sha1_path(struct strbuf *buf, const unsigned char *sha1)
 	}
 }
 
-const char *sha1_file_name(const unsigned char *sha1)
+const char *sha1_file_name_the_repository(const unsigned char *sha1)
 {
 	static struct strbuf buf = STRBUF_INIT;
 
@@ -724,7 +724,8 @@ int check_and_freshen_file(const char *fn, int freshen)
 
 static int check_and_freshen_local(const unsigned char *sha1, int freshen)
 {
-	return check_and_freshen_file(sha1_file_name(sha1), freshen);
+	return check_and_freshen_file(sha1_file_name(the_repository, sha1),
+				      freshen);
 }
 
 static int check_and_freshen_nonlocal(const unsigned char *sha1, int freshen)
@@ -882,7 +883,7 @@ static int stat_sha1_file_the_repository(const unsigned char *sha1,
 {
 	struct alternate_object_database *alt;
 
-	*path = sha1_file_name(sha1);
+	*path = sha1_file_name(the_repository, sha1);
 	if (!lstat(*path, st))
 		return 0;
 
@@ -909,7 +910,7 @@ static int open_sha1_file_the_repository(const unsigned char *sha1,
 	struct alternate_object_database *alt;
 	int most_interesting_errno;
 
-	*path = sha1_file_name(sha1);
+	*path = sha1_file_name(the_repository, sha1);
 	fd = git_open(*path);
 	if (fd >= 0)
 		return fd;
@@ -1576,7 +1577,7 @@ static int write_loose_object(const unsigned char *sha1, char *hdr, int hdrlen,
 	git_SHA_CTX c;
 	unsigned char parano_sha1[20];
 	static struct strbuf tmp_file = STRBUF_INIT;
-	const char *filename = sha1_file_name(sha1);
+	const char *filename = sha1_file_name(the_repository, sha1);
 
 	fd = create_tmpfile(&tmp_file, filename);
 	if (fd < 0) {
-- 
2.15.1.433.g936d1b9894.dirty

