Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E14D21F462
	for <e@80x24.org>; Wed, 19 Jun 2019 09:59:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731508AbfFSJ7n (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Jun 2019 05:59:43 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:33237 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731385AbfFSJ7m (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Jun 2019 05:59:42 -0400
Received: by mail-pg1-f196.google.com with SMTP id k187so9381399pga.0
        for <git@vger.kernel.org>; Wed, 19 Jun 2019 02:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=X31QZYE2YBKeGWyA1pEB2fxKzniHQtaARgTcTHQfvD0=;
        b=ZsAd5iX8slSCdcPq58YTuRpxt9Y/Nd8N2xEvtyX9QMnqu+PRpI+0kozRjkISHahcGx
         ZOXZ2l7WmaClz2flSD4YIugt33jxl4up0lzsxcJHZeuoNlEWknLGYN+79we9ilDNteSN
         3w1Re0Bdb4YLho6Hx8E7RpynLGXZ8n0iScnRizfMNW6noBrFH3yH12+LD6koyjnYkXlo
         hE2x9sK9bp8DXAUtUJfaFo94yKN2pG7JFV8cVQmCuPHiy2PngICiDdz3tXm7mVJ0zjYR
         qY8e86DhKnx7s1+Jc6uQ683GqUF8QpPpbqsCWegNV7grUKZt1MVmaTIQPshoDKRQDNds
         FBxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=X31QZYE2YBKeGWyA1pEB2fxKzniHQtaARgTcTHQfvD0=;
        b=EP0yaJbBhaYaQWmT8WbpaMyLqwUrqVUQ99KG3A9hrB9+FcBHOMlMQuhbuNP41IMsHN
         NGXgDGgwtb3t3dYcXv3sATnR3sdFaz3OvfpD42A1bkKw1FSWSy5xs39cE0ybf3FGh/7o
         dpIDd5iK01UQ1XD/n/uAT044ASkeA30EmGq2BICw+iZxp1XQizfPjAXxZV4Pfz2VcmOo
         2JGsCKkbsMlahM7PsYPnnEYPujAyuZGVH9J0ZH4tgPjnHhVG3Y6pBllox0pK/wVeqyBt
         GL7T4LqRvK335riGRGRKpZoGvJ9g39bbm6ngK/9nT8YnlHBgrRlEWR9nzstEysVVx7If
         ux5Q==
X-Gm-Message-State: APjAAAWeYctjCwRSICy8+mp/cNdZtVK9JKKkhKp/iilyQ2XmYdK1m34b
        U5S8ckgUe5+vgX3uiEahccK8MPxF
X-Google-Smtp-Source: APXvYqwThc/NEicMteCPlCdomBO9URHEvaXm3TLGw7ZM4/YeDDfohDfOiaPa1VIm8f9kyonSmx9Ngg==
X-Received: by 2002:a62:1515:: with SMTP id 21mr47587459pfv.100.1560938381835;
        Wed, 19 Jun 2019 02:59:41 -0700 (PDT)
Received: from ash ([115.76.181.38])
        by smtp.gmail.com with ESMTPSA id 201sm25107922pfz.24.2019.06.19.02.59.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Jun 2019 02:59:41 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Wed, 19 Jun 2019 16:59:37 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 8/8] dir.c: dump "UNTR" extension as json
Date:   Wed, 19 Jun 2019 16:58:58 +0700
Message-Id: <20190619095858.30124-9-pclouds@gmail.com>
X-Mailer: git-send-email 2.22.0.rc0.322.g2b0371e29a
In-Reply-To: <20190619095858.30124-1-pclouds@gmail.com>
References: <20190619095858.30124-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The big part of UNTR extension is dumped at the end instead of dumping
as soon as we read it, because we actually "patch" some fields in
untracked_cache_dir with EWAH bitmaps at the end.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 dir.c         | 56 ++++++++++++++++++++++++++++++++++++++++++++++++++-
 dir.h         |  4 +++-
 json-writer.h |  6 ++++++
 read-cache.c  |  2 +-
 4 files changed, 65 insertions(+), 3 deletions(-)

diff --git a/dir.c b/dir.c
index ba4a51c296..f389eee24a 100644
--- a/dir.c
+++ b/dir.c
@@ -19,6 +19,7 @@
 #include "varint.h"
 #include "ewah/ewok.h"
 #include "fsmonitor.h"
+#include "json-writer.h"
 #include "submodule-config.h"
 
 /*
@@ -2826,7 +2827,42 @@ static void load_oid_stat(struct oid_stat *oid_stat, const unsigned char *data,
 	oid_stat->valid = 1;
 }
 
-struct untracked_cache *read_untracked_extension(const void *data, unsigned long sz)
+static void jw_object_oid_stat(struct json_writer *jw, const char *key,
+			       const struct oid_stat *oid_stat)
+{
+	jw_object_inline_begin_object(jw, key);
+	jw_object_bool(jw, "valid", oid_stat->valid);
+	jw_object_string(jw, "oid", oid_to_hex(&oid_stat->oid));
+	jw_object_stat_data(jw, "stat", &oid_stat->stat);
+	jw_end(jw);
+}
+
+static void jw_object_untracked_cache_dir(struct json_writer *jw,
+					  const struct untracked_cache_dir *ucd)
+{
+	int i;
+
+	jw_object_bool(jw, "valid", ucd->valid);
+	jw_object_bool(jw, "check-only", ucd->check_only);
+	jw_object_stat_data(jw, "stat", &ucd->stat_data);
+	jw_object_string(jw, "exclude-oid", oid_to_hex(&ucd->exclude_oid));
+	jw_object_inline_begin_array(jw, "untracked");
+	for (i = 0; i < ucd->untracked_nr; i++)
+		jw_array_string(jw, ucd->untracked[i]);
+	jw_end(jw);
+
+	jw_object_inline_begin_object(jw, "dirs");
+	for (i = 0; i < ucd->dirs_nr; i++) {
+		jw_object_inline_begin_object(jw, ucd->dirs[i]->name);
+		jw_object_untracked_cache_dir(jw, ucd->dirs[i]);
+		jw_end(jw);
+	}
+	jw_end(jw);
+}
+
+struct untracked_cache *read_untracked_extension(const void *data,
+						 unsigned long sz,
+						 struct json_writer *jw)
 {
 	struct untracked_cache *uc;
 	struct read_data rd;
@@ -2864,6 +2900,17 @@ struct untracked_cache *read_untracked_extension(const void *data, unsigned long
 	uc->dir_flags = get_be32(next + ouc_offset(dir_flags));
 	exclude_per_dir = (const char *)next + exclude_per_dir_offset;
 	uc->exclude_per_dir = xstrdup(exclude_per_dir);
+
+	if (jw) {
+		jw_object_inline_begin_object(jw, "untracked-cache");
+		jw_object_intmax(jw, "ext-size", sz);
+		jw_object_string(jw, "ident", ident);
+		jw_object_oid_stat(jw, "info/exclude", &uc->ss_info_exclude);
+		jw_object_oid_stat(jw, "excludes-file", &uc->ss_excludes_file);
+		jw_object_intmax(jw, "flags", uc->dir_flags);
+		jw_object_string(jw, "excludes-per-dir", uc->exclude_per_dir);
+	}
+
 	/* NUL after exclude_per_dir is covered by sizeof(*ouc) */
 	next += exclude_per_dir_offset + strlen(exclude_per_dir) + 1;
 	if (next >= end)
@@ -2905,6 +2952,12 @@ struct untracked_cache *read_untracked_extension(const void *data, unsigned long
 	ewah_each_bit(rd.sha1_valid, read_oid, &rd);
 	next = rd.data;
 
+	if (jw) {
+		jw_object_inline_begin_object(jw, "root");
+		jw_object_untracked_cache_dir(jw, uc->root);
+		jw_end(jw);
+	}
+
 done:
 	free(rd.ucd);
 	ewah_free(rd.valid);
@@ -2915,6 +2968,7 @@ struct untracked_cache *read_untracked_extension(const void *data, unsigned long
 		free_untracked_cache(uc);
 		uc = NULL;
 	}
+	jw_end_gently(jw);
 	return uc;
 }
 
diff --git a/dir.h b/dir.h
index 680079bbe3..80efdd05c4 100644
--- a/dir.h
+++ b/dir.h
@@ -6,6 +6,8 @@
 #include "cache.h"
 #include "strbuf.h"
 
+struct json_writer;
+
 struct dir_entry {
 	unsigned int len;
 	char name[FLEX_ARRAY]; /* more */
@@ -362,7 +364,7 @@ void untracked_cache_remove_from_index(struct index_state *, const char *);
 void untracked_cache_add_to_index(struct index_state *, const char *);
 
 void free_untracked_cache(struct untracked_cache *);
-struct untracked_cache *read_untracked_extension(const void *data, unsigned long sz);
+struct untracked_cache *read_untracked_extension(const void *data, unsigned long sz, struct json_writer *jw);
 void write_untracked_extension(struct strbuf *out, struct untracked_cache *untracked);
 void add_untracked_cache(struct index_state *istate);
 void remove_untracked_cache(struct index_state *istate);
diff --git a/json-writer.h b/json-writer.h
index 3c173647d3..f778e019a2 100644
--- a/json-writer.h
+++ b/json-writer.h
@@ -121,6 +121,12 @@ static inline void jw_object_inline_begin_array_gently(struct json_writer *jw,
 		jw_object_inline_begin_array(jw, name);
 }
 
+static inline void jw_array_inline_begin_object_gently(struct json_writer *jw)
+{
+	if (jw)
+		jw_array_inline_begin_object(jw);
+}
+
 static inline void jw_end_gently(struct json_writer *jw)
 {
 	if (jw)
diff --git a/read-cache.c b/read-cache.c
index 289705b816..d7d9ce7260 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1708,7 +1708,7 @@ static int read_index_extension(struct index_state *istate,
 			return -1;
 		break;
 	case CACHE_EXT_UNTRACKED:
-		istate->untracked = read_untracked_extension(data, sz);
+		istate->untracked = read_untracked_extension(data, sz, istate->jw);
 		break;
 	case CACHE_EXT_FSMONITOR:
 		read_fsmonitor_extension(istate, data, sz);
-- 
2.22.0.rc0.322.g2b0371e29a

