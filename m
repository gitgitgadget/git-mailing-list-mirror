Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B56B8208CD
	for <e@80x24.org>; Wed, 30 Aug 2017 07:06:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751236AbdH3HGm (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Aug 2017 03:06:42 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:37862 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750757AbdH3HGm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Aug 2017 03:06:42 -0400
Received: by mail-pg0-f68.google.com with SMTP id t193so4482685pgc.4
        for <git@vger.kernel.org>; Wed, 30 Aug 2017 00:06:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rwZS5gzntgseVTYLDnsY9bEh1zUFHo/cW5Gs2qbb9fA=;
        b=rJSCwVpKdGXsQuLN8xd5alM4G6SNsVn+sABeUkCla0+0mXpyalVaA5ThiO5kHj1IQZ
         jK90oLhu+yOEFrLIBdZu43HQFdOTH1qWNVcL34q6pTwubFsJrm/QQYVNBKRNpPEc2qlw
         klVl6FeOtt0XDib+eUDO8WxXHG+hs9QXBDrhqwhJwC13HFxt49YAmRnpT1iFKKjI1hz1
         zk6jImKaofdLNjG0SN8swUUc/WUFKJN2fCKu0Ks2JTiPIwleEPEB1zUdvRec7XVwPrHo
         o57yU+Te2wrfkbt7rES5BdPFADa/njGx//X3ZI/N0whdwHvm1yE7TxBeNcosLmK7Cy7W
         NhpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rwZS5gzntgseVTYLDnsY9bEh1zUFHo/cW5Gs2qbb9fA=;
        b=L+DfLDtvGYGkSldLx2vAB1BOlt1HAb0QPpltfZyosSA6EzV65mhBDvljrjxlpFqk1y
         2gxwRDa3zNk14n4hUz+qNh0ajB2AzCVupYz51mOJgjRMDyAi73Z+gGNcBQMtJwFurVUM
         dgrb1YEmLm2feMFhQFmFUbZc7Fx+6bjbEo3UWtuPymx0N/RoTUxTYwP1AWbFaiW/dYxJ
         sX6TbSDgyEqGtJPFORu2M2cpqRDSupNu+VHTtsKGvhN3wDci4PfcHc9faIvBlVYZk50Y
         Q4e4QgKxGkB9dDQgg32ls7wx6LD6gVBv881/ikxqIybmp+wbSxs/mYGuNUi06QKBI2Z0
         J/Uw==
X-Gm-Message-State: AHYfb5iPEGofScTcTW937kQ4ZLYhX3Q4ePAjqGbDRlOSA2aMMjuARJwJ
        Z10PGjCCFnpCNpb7knI=
X-Received: by 10.98.77.70 with SMTP id a67mr599044pfb.343.1504076801168;
        Wed, 30 Aug 2017 00:06:41 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:402:5042:50b1:56af:6f3d])
        by smtp.gmail.com with ESMTPSA id 188sm7737986pfe.171.2017.08.30.00.06.40
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 30 Aug 2017 00:06:40 -0700 (PDT)
Date:   Wed, 30 Aug 2017 00:06:38 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH 23/39] pack: add repository argument to sha1_file_name
Message-ID: <20170830070638.GX153983@aiede.mtv.corp.google.com>
References: <20170830064634.GA153983@aiede.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170830064634.GA153983@aiede.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
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
 cache.h        |  8 --------
 http-walker.c  |  3 ++-
 http.c         |  5 +++--
 object-store.h |  9 +++++++++
 sha1_file.c    | 11 ++++++-----
 5 files changed, 20 insertions(+), 16 deletions(-)

diff --git a/cache.h b/cache.h
index abec62dc9b..0d120b9327 100644
--- a/cache.h
+++ b/cache.h
@@ -895,14 +895,6 @@ extern void check_repository_format(void);
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
index 0979053272..2c86e6e76e 100644
--- a/http.c
+++ b/http.c
@@ -2163,7 +2163,7 @@ struct http_object_request *new_http_object_request(const char *base_url,
 	hashcpy(freq->sha1, sha1);
 	freq->localfile = -1;
 
-	filename = sha1_file_name(sha1);
+	filename = sha1_file_name(the_repository, sha1);
 	snprintf(freq->tmpfile, sizeof(freq->tmpfile),
 		 "%s.temp", filename);
 
@@ -2311,7 +2311,8 @@ int finish_http_object_request(struct http_object_request *freq)
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
index 6af88e5b04..8ab26fb3b3 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -253,7 +253,7 @@ static void fill_sha1_path(struct strbuf *buf, const unsigned char *sha1)
 	}
 }
 
-const char *sha1_file_name(const unsigned char *sha1)
+const char *sha1_file_name_the_repository(const unsigned char *sha1)
 {
 	static struct strbuf buf = STRBUF_INIT;
 
@@ -664,7 +664,8 @@ int check_and_freshen_file(const char *fn, int freshen)
 
 static int check_and_freshen_local(const unsigned char *sha1, int freshen)
 {
-	return check_and_freshen_file(sha1_file_name(sha1), freshen);
+	return check_and_freshen_file(sha1_file_name(the_repository, sha1),
+				      freshen);
 }
 
 static int check_and_freshen_nonlocal(const unsigned char *sha1, int freshen)
@@ -822,7 +823,7 @@ static int stat_sha1_file_the_repository(const unsigned char *sha1,
 {
 	struct alternate_object_database *alt;
 
-	*path = sha1_file_name(sha1);
+	*path = sha1_file_name(the_repository, sha1);
 	if (!lstat(*path, st))
 		return 0;
 
@@ -849,7 +850,7 @@ static int open_sha1_file_the_repository(const unsigned char *sha1,
 	struct alternate_object_database *alt;
 	int most_interesting_errno;
 
-	*path = sha1_file_name(sha1);
+	*path = sha1_file_name(the_repository, sha1);
 	fd = git_open(*path);
 	if (fd >= 0)
 		return fd;
@@ -1509,7 +1510,7 @@ static int write_loose_object(const unsigned char *sha1, char *hdr, int hdrlen,
 	git_SHA_CTX c;
 	unsigned char parano_sha1[20];
 	static struct strbuf tmp_file = STRBUF_INIT;
-	const char *filename = sha1_file_name(sha1);
+	const char *filename = sha1_file_name(the_repository, sha1);
 
 	fd = create_tmpfile(&tmp_file, filename);
 	if (fd < 0) {
-- 
2.14.1.581.gf28d330327

