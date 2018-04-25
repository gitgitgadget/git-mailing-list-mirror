Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 846CB1F424
	for <e@80x24.org>; Wed, 25 Apr 2018 18:21:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756226AbeDYSVT (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Apr 2018 14:21:19 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:44012 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755673AbeDYSVM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Apr 2018 14:21:12 -0400
Received: by mail-pf0-f194.google.com with SMTP id j11so15923903pff.10
        for <git@vger.kernel.org>; Wed, 25 Apr 2018 11:21:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=lJ0w2/xNcbIxlRNTuv/YiA8q0RyddFyMp9PJkO5ortE=;
        b=qsDEx/6babl6ACw0iHC3NRd96QTDMG/JocbUS0up14Fq+nzth5eiVNCqjuy5rjKEPI
         hsLDrLP3vigj+c01F2mwxqjg+/eLJsugZEANGshPAhRjiw6LgonjtyMS3punYjfvswpm
         9zajz7uNgAHoy9Z45MlxcPo3akMhCnRDtvI3kGl2hlUQnufgSDpDH7EIRYH4g5qXvxoJ
         fMbl71eLefE+Dv+A4horDO9eFGPlCRBobHdJd8G8XTOzKfe4rS0Ltfx6VcF2hkgZhNC1
         a3GjaIwo/ty8rNc0ezrNkCa9EoDXYfY3v7XojYHcVqtSRiIPmsTs3CrHqyaER8g5UfRS
         Uzaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=lJ0w2/xNcbIxlRNTuv/YiA8q0RyddFyMp9PJkO5ortE=;
        b=DBKrROL1MPCRhgy+P8I9gJYiWNQAmmG258EfgvcnqZMeJZaY6E5fhZjkf0qz55JDoR
         fXDG2cbr46Ze7OncNMMbF3zPNDFrzN/lkjUK1cj7SvPnWikeAE1nS0nZv9WLX83r5JN/
         OMibKPukgfM9N6Fbmmi4Kn2k1acFLOrBcMVVmTWNSRlev8/rljZ1buqK4BJDFJqsSQK7
         zWFV8ejszSUU63smVx96W1lE5XoWgcibQ+5b9domXqLoRQFTiCIqVtIyye4qh4SsYvCy
         BXIv75KAGwSQaTRbOTyZAUQA3wlxsWm1cu1UWOOQZFQLVgTqLA8EcF5EBi4KtwWWERX1
         0cZQ==
X-Gm-Message-State: ALQs6tB174HS+kytXLuXYrBrBzDcG1lEj1yPFnSP2W7PeYmsTqn8jqxH
        F2B8VcSoAIdEVvrB8ja9ogFqI3Lo+XY=
X-Google-Smtp-Source: AB8JxZqWxNr53kSEQ1Flhh2yI/vIPjPfl+6XeQcduOkEx8/kEr1GPcV+IEf6rnOuv2SdN7dJer6vUg==
X-Received: by 10.101.102.86 with SMTP id z22mr1842023pgv.31.1524680471466;
        Wed, 25 Apr 2018 11:21:11 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id l19sm25285512pgn.44.2018.04.25.11.21.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 25 Apr 2018 11:21:10 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     bmwill@google.com, git@vger.kernel.org, gitster@pobox.com,
        jonathantanmy@google.com, sandals@crustytoothpaste.net
Subject: [PATCHv3 1/9] cache.h: add repository argument to oid_object_info_extended
Date:   Wed, 25 Apr 2018 11:20:58 -0700
Message-Id: <20180425182106.162972-2-sbeller@google.com>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d-goog
In-Reply-To: <20180425182106.162972-1-sbeller@google.com>
References: <20180424215910.22201-1-sbeller@google.com>
 <20180425182106.162972-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a repository argument to allow oid_object_info_extended callers
to be more specific about which repository to act on. This is a small
mechanical change; it doesn't change the implementation to handle
repositories other than the_repository yet.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 builtin/cat-file.c |  6 +++---
 cache.h            |  5 ++++-
 packfile.c         |  2 +-
 sha1_file.c        | 10 +++++-----
 streaming.c        |  2 +-
 5 files changed, 14 insertions(+), 11 deletions(-)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 2c46d257cd..4ecdb9ff54 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -77,7 +77,7 @@ static int cat_one_file(int opt, const char *exp_type, const char *obj_name,
 	switch (opt) {
 	case 't':
 		oi.type_name = &sb;
-		if (oid_object_info_extended(&oid, &oi, flags) < 0)
+		if (oid_object_info_extended(the_repository, &oid, &oi, flags) < 0)
 			die("git cat-file: could not get object info");
 		if (sb.len) {
 			printf("%s\n", sb.buf);
@@ -88,7 +88,7 @@ static int cat_one_file(int opt, const char *exp_type, const char *obj_name,
 
 	case 's':
 		oi.sizep = &size;
-		if (oid_object_info_extended(&oid, &oi, flags) < 0)
+		if (oid_object_info_extended(the_repository, &oid, &oi, flags) < 0)
 			die("git cat-file: could not get object info");
 		printf("%lu\n", size);
 		return 0;
@@ -342,7 +342,7 @@ static void batch_object_write(const char *obj_name, struct batch_options *opt,
 	struct strbuf buf = STRBUF_INIT;
 
 	if (!data->skip_object_info &&
-	    oid_object_info_extended(&data->oid, &data->info,
+	    oid_object_info_extended(the_repository, &data->oid, &data->info,
 				     OBJECT_INFO_LOOKUP_REPLACE) < 0) {
 		printf("%s missing\n",
 		       obj_name ? obj_name : oid_to_hex(&data->oid));
diff --git a/cache.h b/cache.h
index 027bd7ffc8..588c4fff9a 100644
--- a/cache.h
+++ b/cache.h
@@ -1673,7 +1673,10 @@ struct object_info {
 #define OBJECT_INFO_QUICK 8
 /* Do not check loose object */
 #define OBJECT_INFO_IGNORE_LOOSE 16
-extern int oid_object_info_extended(const struct object_id *, struct object_info *, unsigned flags);
+
+#define oid_object_info_extended(r, oid, oi, flags) \
+	oid_object_info_extended_##r(oid, oi, flags)
+int oid_object_info_extended_the_repository(const struct object_id *, struct object_info *, unsigned flags);
 
 /*
  * Set this to 0 to prevent sha1_object_info_extended() from fetching missing
diff --git a/packfile.c b/packfile.c
index 0bc67d0e00..d9914ba723 100644
--- a/packfile.c
+++ b/packfile.c
@@ -1474,7 +1474,7 @@ static void *read_object(const struct object_id *oid, enum object_type *type,
 	oi.sizep = size;
 	oi.contentp = &content;
 
-	if (oid_object_info_extended(oid, &oi, 0) < 0)
+	if (oid_object_info_extended(the_repository, oid, &oi, 0) < 0)
 		return NULL;
 	return content;
 }
diff --git a/sha1_file.c b/sha1_file.c
index 64a5bd7d87..50a2dc5f0a 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1231,7 +1231,7 @@ static int sha1_loose_object_info(struct repository *r,
 
 int fetch_if_missing = 1;
 
-int oid_object_info_extended(const struct object_id *oid, struct object_info *oi, unsigned flags)
+int oid_object_info_extended_the_repository(const struct object_id *oid, struct object_info *oi, unsigned flags)
 {
 	static struct object_info blank_oi = OBJECT_INFO_INIT;
 	struct pack_entry e;
@@ -1310,7 +1310,7 @@ int oid_object_info_extended(const struct object_id *oid, struct object_info *oi
 	rtype = packed_object_info(e.p, e.offset, oi);
 	if (rtype < 0) {
 		mark_bad_packed_object(e.p, real->hash);
-		return oid_object_info_extended(real, oi, 0);
+		return oid_object_info_extended(the_repository, real, oi, 0);
 	} else if (oi->whence == OI_PACKED) {
 		oi->u.packed.offset = e.offset;
 		oi->u.packed.pack = e.p;
@@ -1329,7 +1329,7 @@ int oid_object_info(const struct object_id *oid, unsigned long *sizep)
 
 	oi.typep = &type;
 	oi.sizep = sizep;
-	if (oid_object_info_extended(oid, &oi,
+	if (oid_object_info_extended(the_repository, oid, &oi,
 				     OBJECT_INFO_LOOKUP_REPLACE) < 0)
 		return -1;
 	return type;
@@ -1347,7 +1347,7 @@ static void *read_object(const unsigned char *sha1, enum object_type *type,
 
 	hashcpy(oid.hash, sha1);
 
-	if (oid_object_info_extended(&oid, &oi, 0) < 0)
+	if (oid_object_info_extended(the_repository, &oid, &oi, 0) < 0)
 		return NULL;
 	return content;
 }
@@ -1745,7 +1745,7 @@ int has_sha1_file_with_flags(const unsigned char *sha1, int flags)
 	if (!startup_info->have_repository)
 		return 0;
 	hashcpy(oid.hash, sha1);
-	return oid_object_info_extended(&oid, NULL,
+	return oid_object_info_extended(the_repository, &oid, NULL,
 					flags | OBJECT_INFO_SKIP_CACHED) >= 0;
 }
 
diff --git a/streaming.c b/streaming.c
index cce7b17ea7..d1e6b2dce6 100644
--- a/streaming.c
+++ b/streaming.c
@@ -117,7 +117,7 @@ static enum input_source istream_source(const struct object_id *oid,
 
 	oi->typep = type;
 	oi->sizep = &size;
-	status = oid_object_info_extended(oid, oi, 0);
+	status = oid_object_info_extended(the_repository, oid, oi, 0);
 	if (status < 0)
 		return stream_error;
 
-- 
2.17.0.441.gb46fe60e1d-goog

