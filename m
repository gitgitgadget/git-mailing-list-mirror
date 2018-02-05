Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 15A3D1F404
	for <e@80x24.org>; Tue,  6 Feb 2018 00:02:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752009AbeBFAC0 (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Feb 2018 19:02:26 -0500
Received: from mail-pl0-f67.google.com ([209.85.160.67]:35958 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750999AbeBFACZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Feb 2018 19:02:25 -0500
Received: by mail-pl0-f67.google.com with SMTP id v3so100489plg.3
        for <git@vger.kernel.org>; Mon, 05 Feb 2018 16:02:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=roPb6FamudBvbtSj6+fPSmzI++GtzIK0WYlIfUJqtQE=;
        b=AivJ5K50oLu420U2JcRs4OIKv/9Adk/u4C4DtyarlCzV+KcElpPtj00X3MlW7mlnSd
         p49Z16SG5ipafcGS8Fb79ZM06ExWMB6tWV8MvTYqjWw6f8Wtac5YkuspJR5MslGDNsP2
         6ma2bpd2GxhgAgyQFHF4tbRqAOmg7foW8CPlWZV8BuDHFt+awnOMgyNkY+OJSe+BQxjc
         VwcqqVoJnnh6NbqEGRQtSq5DtzXFyZUCASO85n/TDRQ+uersg7QlDKJRnlZaG+4qmZJo
         GfUdQFCfE0+LD5OugBy4xltw0TpMeykg13890W+mF6qbrXz7Gg37tDZW8zKrXIMhbynK
         B7VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=roPb6FamudBvbtSj6+fPSmzI++GtzIK0WYlIfUJqtQE=;
        b=aKgH2d/heN4tb7d5ebD2nviChYrvt76QAZFc1Yo4dPAFhh3K7GmO1tBxYpHQGfWxpP
         O5SvhLPdgVrV14J2i41lUV9jAHbxHjbi6EQ3zsp9D7N+A/fmBmf0UiriQ3cWG9EQs7pQ
         PjVvL4XyjzI3+VL36uItAxY7/CQRWZaBz4mYTa08ptHECXUbydjA16Jp8RnfjeLmY3wC
         zA7H1F7wwAensV9HOXmqONOcpSTwdOcLNQSc+Imj8KdKj+lLraAH8nwt2vcBszedylw2
         z26TuS6HIjMP9r8FOM6aWCTMo2h36Htfq1I2eKFBtbluXJrL8Ag5gQjQxn0Pj87bGt2C
         lN1g==
X-Gm-Message-State: APf1xPDXr3uRfZj7uTVHUBROmm9OfObVIbLns5dzE2Y9JmyU+/398dzH
        6foA0/qneEXgdS7WmAQDvWRgaka1ALI=
X-Google-Smtp-Source: AH8x227LReRMZdQsNp2KvN6G6sYoKm6f/+0eCjT8kd4pmPVT/j7h/yiuRYksZZBmM8xuM36Vam0r/w==
X-Received: by 2002:a17:902:8d81:: with SMTP id v1-v6mr505863plo.430.1517875342674;
        Mon, 05 Feb 2018 16:02:22 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id x26sm19604271pfi.141.2018.02.05.16.02.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Feb 2018 16:02:20 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH 041/194] sha1_file: add repository argument to sha1_object_info_extended
Date:   Mon,  5 Feb 2018 15:55:02 -0800
Message-Id: <20180205235735.216710-21-sbeller@google.com>
X-Mailer: git-send-email 2.15.1.433.g936d1b9894.dirty
In-Reply-To: <20180205235735.216710-1-sbeller@google.com>
References: <20180205235508.216277-1-sbeller@google.com>
 <20180205235735.216710-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jonathan Nieder <jrnieder@gmail.com>

Add a repository argument to allow sha1_object_info_extended callers
to be more specific about which repository to act on. This is a small
mechanical change; it doesn't change the implementation to handle
repositories other than the_repository yet.

As with the previous commits, use a macro to catch callers passing a
repository other than the_repository at compile time.

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 builtin/cat-file.c |  6 +++---
 cache.h            |  4 +++-
 packfile.c         |  2 +-
 sha1_file.c        | 11 ++++++-----
 streaming.c        |  2 +-
 5 files changed, 14 insertions(+), 11 deletions(-)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index f5fa4fd75a..9d18efeb7c 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -77,7 +77,7 @@ static int cat_one_file(int opt, const char *exp_type, const char *obj_name,
 	switch (opt) {
 	case 't':
 		oi.typename = &sb;
-		if (sha1_object_info_extended(oid.hash, &oi, flags) < 0)
+		if (sha1_object_info_extended(the_repository, oid.hash, &oi, flags) < 0)
 			die("git cat-file: could not get object info");
 		if (sb.len) {
 			printf("%s\n", sb.buf);
@@ -88,7 +88,7 @@ static int cat_one_file(int opt, const char *exp_type, const char *obj_name,
 
 	case 's':
 		oi.sizep = &size;
-		if (sha1_object_info_extended(oid.hash, &oi, flags) < 0)
+		if (sha1_object_info_extended(the_repository, oid.hash, &oi, flags) < 0)
 			die("git cat-file: could not get object info");
 		printf("%lu\n", size);
 		return 0;
@@ -340,7 +340,7 @@ static void batch_object_write(const char *obj_name, struct batch_options *opt,
 	struct strbuf buf = STRBUF_INIT;
 
 	if (!data->skip_object_info &&
-	    sha1_object_info_extended(data->oid.hash, &data->info,
+	    sha1_object_info_extended(the_repository, data->oid.hash, &data->info,
 				      OBJECT_INFO_LOOKUP_REPLACE) < 0) {
 		printf("%s missing\n",
 		       obj_name ? obj_name : oid_to_hex(&data->oid));
diff --git a/cache.h b/cache.h
index ce309cfe3f..3410a93737 100644
--- a/cache.h
+++ b/cache.h
@@ -1749,7 +1749,9 @@ struct object_info {
 #define OBJECT_INFO_SKIP_CACHED 4
 /* Do not retry packed storage after checking packed and loose storage */
 #define OBJECT_INFO_QUICK 8
-extern int sha1_object_info_extended(const unsigned char *, struct object_info *, unsigned flags);
+#define sha1_object_info_extended(r, s, oi, f) \
+		sha1_object_info_extended_##r(s, oi, f)
+extern int sha1_object_info_extended_the_repository(const unsigned char *, struct object_info *, unsigned flags);
 
 /* Dumb servers support */
 extern int update_server_info(int);
diff --git a/packfile.c b/packfile.c
index 7aa69dd3c0..0ca13a4ed7 100644
--- a/packfile.c
+++ b/packfile.c
@@ -1450,7 +1450,7 @@ static void *read_object(const unsigned char *sha1, enum object_type *type,
 	oi.sizep = size;
 	oi.contentp = &content;
 
-	if (sha1_object_info_extended(sha1, &oi, 0) < 0)
+	if (sha1_object_info_extended(the_repository, sha1, &oi, 0) < 0)
 		return NULL;
 	return content;
 }
diff --git a/sha1_file.c b/sha1_file.c
index 1e867bc293..a5dcb76d96 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1234,7 +1234,7 @@ static int sha1_loose_object_info(struct repository *r,
 	return (status < 0) ? status : 0;
 }
 
-int sha1_object_info_extended(const unsigned char *sha1, struct object_info *oi, unsigned flags)
+int sha1_object_info_extended_the_repository(const unsigned char *sha1, struct object_info *oi, unsigned flags)
 {
 	static struct object_info blank_oi = OBJECT_INFO_INIT;
 	struct pack_entry e;
@@ -1294,7 +1294,8 @@ int sha1_object_info_extended(const unsigned char *sha1, struct object_info *oi,
 	rtype = packed_object_info(e.p, e.offset, oi);
 	if (rtype < 0) {
 		mark_bad_packed_object(e.p, real);
-		return sha1_object_info_extended(real, oi, 0);
+		return sha1_object_info_extended(the_repository, real, oi,
+						 0);
 	} else if (oi->whence == OI_PACKED) {
 		oi->u.packed.offset = e.offset;
 		oi->u.packed.pack = e.p;
@@ -1313,7 +1314,7 @@ int sha1_object_info(const unsigned char *sha1, unsigned long *sizep)
 
 	oi.typep = &type;
 	oi.sizep = sizep;
-	if (sha1_object_info_extended(sha1, &oi,
+	if (sha1_object_info_extended(the_repository, sha1, &oi,
 				      OBJECT_INFO_LOOKUP_REPLACE) < 0)
 		return -1;
 	return type;
@@ -1328,7 +1329,7 @@ static void *read_object(const unsigned char *sha1, enum object_type *type,
 	oi.sizep = size;
 	oi.contentp = &content;
 
-	if (sha1_object_info_extended(sha1, &oi, 0) < 0)
+	if (sha1_object_info_extended(the_repository, sha1, &oi, 0) < 0)
 		return NULL;
 	return content;
 }
@@ -1715,7 +1716,7 @@ int has_sha1_file_with_flags(const unsigned char *sha1, int flags)
 {
 	if (!startup_info->have_repository)
 		return 0;
-	return sha1_object_info_extended(sha1, NULL,
+	return sha1_object_info_extended(the_repository, sha1, NULL,
 					 flags | OBJECT_INFO_SKIP_CACHED) >= 0;
 }
 
diff --git a/streaming.c b/streaming.c
index 22d27df55e..47fca9aba0 100644
--- a/streaming.c
+++ b/streaming.c
@@ -116,7 +116,7 @@ static enum input_source istream_source(const unsigned char *sha1,
 
 	oi->typep = type;
 	oi->sizep = &size;
-	status = sha1_object_info_extended(sha1, oi, 0);
+	status = sha1_object_info_extended(the_repository, sha1, oi, 0);
 	if (status < 0)
 		return stream_error;
 
-- 
2.15.1.433.g936d1b9894.dirty

