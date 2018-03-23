Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C91B01F404
	for <e@80x24.org>; Fri, 23 Mar 2018 17:22:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752517AbeCWRWM (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Mar 2018 13:22:12 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:35977 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752077AbeCWRWI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Mar 2018 13:22:08 -0400
Received: by mail-lf0-f67.google.com with SMTP id z143-v6so19392761lff.3
        for <git@vger.kernel.org>; Fri, 23 Mar 2018 10:22:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=G7NjkCUFasqWv25oJR5KOol/oizrJJ5XG8b+mM2O9SA=;
        b=NFAyJsnLKxkJQA7maXzd28ZsDSN9v9lj6LDnwmmck6ilFlv+uSRKrfERSc1gyHK8Re
         ob+2iU1s5+5DYmMJCNyaS78NxPaiPiNI9PEu1A1uBNClGyfkXzhmeAXNubSvaE/1D+ST
         m/yK5uxciMw/vAsNAETU+rJpTaaB6cF2pHw5MAkBYZTd/slabw4W2MDf3x4xf+bV9cVw
         r/2rvBkfsuJol6FEpV1PuXcyxLwO2wMStg1/h/q5SKN+eAEZHvNlsx79s5KHY+Snmiee
         hVH3mr1mjZjxS4yA4DsQiUyYbUPVAaLK67Z1XWXibk0fIAKuprVjrkHGtSVbvxSqaLsk
         Np6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=G7NjkCUFasqWv25oJR5KOol/oizrJJ5XG8b+mM2O9SA=;
        b=E8ltfIOM+PtQ0N4lWDESCpxUoWXxsavAcnWhHE/xAYATnmTHtICX0/tK0Lae6LZYxU
         ebbhJH9g1J2dtEzRscHkDbOAsvcEvjl/xztP+cMtApk//wj0MJCMcDaEC88BdeJ/oSlJ
         Q7bELajvU2rx8Y/HGxJ3K1Oa5aQlTI72kHeNvfWXLokSeyr41HgKzox/YXDjJjp8mTWk
         Jmo6EO9/f3FJC59EJSA+ogtOvzRCD2cGxh4pV/N7d3L/NnHzJvN1MkZpaacC1bMT1BSA
         xq41770KwHcTjmfXr+db6uyrKS7P88pwc6zoJ2TJxl4JWQj65a0Zz14vMrVeokN1XVvY
         TbSQ==
X-Gm-Message-State: AElRT7H3ngqMSHHgncRFwWu1osMxrkQ0uoZER2gVYectPDO7FpkA76zp
        dxuxstUI9N42OAWwRkyPF7U=
X-Google-Smtp-Source: AG47ELsocw58oZ0niqC8pEImJ3T0L+CDgakSktdhJR7gOm4EgG8xBXoYaRhE3FHfJfcjtsoj5hKWNQ==
X-Received: by 2002:a19:228a:: with SMTP id i132-v6mr21120692lfi.57.1521825726656;
        Fri, 23 Mar 2018 10:22:06 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id g13sm1973028lja.65.2018.03.23.10.22.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Mar 2018 10:22:05 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, sbeller@google.com,
        Brandon Williams <bmwill@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 20/27] sha1_file: add repository argument to map_sha1_file
Date:   Fri, 23 Mar 2018 18:21:14 +0100
Message-Id: <20180323172121.17725-21-pclouds@gmail.com>
X-Mailer: git-send-email 2.17.0.rc0.348.gd5a49e0b6f
In-Reply-To: <20180323172121.17725-1-pclouds@gmail.com>
References: <20180303113637.26518-1-pclouds@gmail.com>
 <20180323172121.17725-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Stefan Beller <sbeller@google.com>

Add a repository argument to allow map_sha1_file callers to be more
specific about which repository to handle. This is a small mechanical
change; it doesn't change the implementation to handle repositories
other than the_repository yet.

As with the previous commits, use a macro to catch callers passing a
repository other than the_repository at compile time.

While at it, move the declaration to object-store.h, where it should
be easier to find.

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 cache.h        | 1 -
 object-store.h | 3 +++
 sha1_file.c    | 4 ++--
 streaming.c    | 5 ++++-
 4 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/cache.h b/cache.h
index cbec0ecd23..720664e394 100644
--- a/cache.h
+++ b/cache.h
@@ -1242,7 +1242,6 @@ extern int pretend_sha1_file(void *, unsigned long, enum object_type, unsigned c
 extern int force_object_loose(const unsigned char *sha1, time_t mtime);
 extern int git_open_cloexec(const char *name, int flags);
 #define git_open(name) git_open_cloexec(name, O_RDONLY)
-extern void *map_sha1_file(const unsigned char *sha1, unsigned long *size);
 extern int unpack_sha1_header(git_zstream *stream, unsigned char *map, unsigned long mapsize, void *buffer, unsigned long bufsiz);
 extern int parse_sha1_header(const char *hdr, unsigned long *sizep);
 
diff --git a/object-store.h b/object-store.h
index 3707f3c495..03671745f4 100644
--- a/object-store.h
+++ b/object-store.h
@@ -128,4 +128,7 @@ void raw_object_store_clear(struct raw_object_store *o);
 #define sha1_file_name(r, b, s) sha1_file_name_##r(b, s)
 void sha1_file_name_the_repository(struct strbuf *buf, const unsigned char *sha1);
 
+#define map_sha1_file(r, s, sz) map_sha1_file_##r(s, sz)
+void *map_sha1_file_the_repository(const unsigned char *sha1, unsigned long *size);
+
 #endif /* OBJECT_STORE_H */
diff --git a/sha1_file.c b/sha1_file.c
index 4b6144b7cd..f968f67a14 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -961,7 +961,7 @@ static void *map_sha1_file_1_the_repository(const char *path,
 	return map;
 }
 
-void *map_sha1_file(const unsigned char *sha1, unsigned long *size)
+void *map_sha1_file_the_repository(const unsigned char *sha1, unsigned long *size)
 {
 	return map_sha1_file_1(the_repository, NULL, sha1, size);
 }
@@ -1185,7 +1185,7 @@ static int sha1_loose_object_info(const unsigned char *sha1,
 		return 0;
 	}
 
-	map = map_sha1_file(sha1, &mapsize);
+	map = map_sha1_file(the_repository, sha1, &mapsize);
 	if (!map)
 		return -1;
 
diff --git a/streaming.c b/streaming.c
index 5892b50bd8..22d27df55e 100644
--- a/streaming.c
+++ b/streaming.c
@@ -3,6 +3,8 @@
  */
 #include "cache.h"
 #include "streaming.h"
+#include "repository.h"
+#include "object-store.h"
 #include "packfile.h"
 
 enum input_source {
@@ -335,7 +337,8 @@ static struct stream_vtbl loose_vtbl = {
 
 static open_method_decl(loose)
 {
-	st->u.loose.mapped = map_sha1_file(sha1, &st->u.loose.mapsize);
+	st->u.loose.mapped = map_sha1_file(the_repository,
+					   sha1, &st->u.loose.mapsize);
 	if (!st->u.loose.mapped)
 		return -1;
 	if ((unpack_sha1_header(&st->z,
-- 
2.17.0.rc0.348.gd5a49e0b6f

