Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 708791F453
	for <e@80x24.org>; Sun, 17 Feb 2019 10:10:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728281AbfBQKKw (ORCPT <rfc822;e@80x24.org>);
        Sun, 17 Feb 2019 05:10:52 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:45844 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726638AbfBQKKw (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 Feb 2019 05:10:52 -0500
Received: by mail-pf1-f196.google.com with SMTP id v21so4076093pfm.12
        for <git@vger.kernel.org>; Sun, 17 Feb 2019 02:10:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dMiNY5KRrZKy13KymcVkaSIAvSKOaapfmt1QuN6Ionw=;
        b=a388DPhKDYng7Nenv9jxAs2CCNolLCiHpFyIPZao6N8Q363D7Fg5a16ijThvAvAVCT
         HEpGx8KcDS+yvcVeAYSeYuJGI515Bxm/HDD6NAa21an6gkoBQrWbnrTDw7MLkoDOEAp5
         uXB1/ElTMZqwJYM7Ay5qtP+FjJz9vRoeXXqis4qvmuzJRy8phxSIIb68/LPweA5ZA2+M
         DgUgtZWuhtHV0jh45TwFrK7P+yktB7gIVq4cnZM0rAczsKHcy6wa28rstbjNYXUzR33E
         EvEcMVwYMrfjg/vOlUxjhvVcoT3dop6K4acFdNe4osPkYtFPxUIxO0OQ/mB0T+Aqamz7
         H0Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dMiNY5KRrZKy13KymcVkaSIAvSKOaapfmt1QuN6Ionw=;
        b=IzXW1jeswVUp1Gob+0WpKTKM4pmdP03mUdb/LBNpFWlhLTbrUSRS2mL7Hsggsv+t6J
         TOsq5oLvia1fN5sF2r60n66IsqDE+afpxWy0+zUrrvHhzBCPW8p0M3bir4PLQjr21Uce
         hCjcm179jTqpWwdWRnAvO/+evVaedKSHVOIb8D6rj1GVOCIifAmRU8QakPUKK7hDpq0Z
         9x+GaRe56LGYHwI0a4/Tp1VIC8WYFbIBoamWWHZd3j2sTk1ql42I2W9FQJkhxcShUdHm
         i5TAvYGdlDmKMBZ70QNfxv/Wu/m+n8Mb6tXAU7Fxw08iD9RJWmigL+5T7UjAPvNMX03e
         ccyg==
X-Gm-Message-State: AHQUAuYTAHLVqf68pYP0KnuoO0UPHfvKXlXGTKPGF6VH972TA/eEU9Yw
        o7HlFbLp58P8E6GAn7rfF8s8bzyK
X-Google-Smtp-Source: AHgI3IampBRrhzTPscU7GrlGut47RYQVi8ZwGkgb+y3ODBizblEpKAegUTkFWI5jX9QdRHKgrnkstw==
X-Received: by 2002:a63:1766:: with SMTP id 38mr13679499pgx.204.1550398251364;
        Sun, 17 Feb 2019 02:10:51 -0800 (PST)
Received: from ash ([115.72.21.220])
        by smtp.gmail.com with ESMTPSA id d13sm16811238pfd.58.2019.02.17.02.10.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Feb 2019 02:10:50 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Sun, 17 Feb 2019 17:10:47 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 21/31] sha1-name.c: remove the_repo from get_oid_basic()
Date:   Sun, 17 Feb 2019 17:09:03 +0700
Message-Id: <20190217100913.4127-22-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.rc0.328.g0e39304f8d
In-Reply-To: <20190217100913.4127-1-pclouds@gmail.com>
References: <20190217100913.4127-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 sha1-name.c | 25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/sha1-name.c b/sha1-name.c
index 1cda854f02..d4c135aea8 100644
--- a/sha1-name.c
+++ b/sha1-name.c
@@ -773,8 +773,8 @@ static inline int push_mark(const char *string, int len)
 static enum get_oid_result get_oid_1(const char *name, int len, struct object_id *oid, unsigned lookup_flags);
 static int interpret_nth_prior_checkout(struct repository *r, const char *name, int namelen, struct strbuf *buf);
 
-static int get_oid_basic(const char *str, int len, struct object_id *oid,
-			  unsigned int flags)
+static int get_oid_basic(struct repository *r, const char *str, int len,
+			 struct object_id *oid, unsigned int flags)
 {
 	static const char *warn_msg = "refname '%.*s' is ambiguous.";
 	static const char *object_name_msg = N_(
@@ -792,9 +792,9 @@ static int get_oid_basic(const char *str, int len, struct object_id *oid,
 	int refs_found = 0;
 	int at, reflog_len, nth_prior = 0;
 
-	if (len == the_hash_algo->hexsz && !get_oid_hex(str, oid)) {
+	if (len == r->hash_algo->hexsz && !get_oid_hex(str, oid)) {
 		if (warn_ambiguous_refs && warn_on_object_refname_ambiguity) {
-			refs_found = dwim_ref(str, len, &tmp_oid, &real_ref);
+			refs_found = repo_dwim_ref(r, str, len, &tmp_oid, &real_ref);
 			if (refs_found > 0) {
 				warning(warn_msg, len, str);
 				if (advice_object_name_warning)
@@ -835,8 +835,8 @@ static int get_oid_basic(const char *str, int len, struct object_id *oid,
 		struct strbuf buf = STRBUF_INIT;
 		int detached;
 
-		if (interpret_nth_prior_checkout(the_repository, str, len, &buf) > 0) {
-			detached = (buf.len == the_hash_algo->hexsz && !get_oid_hex(buf.buf, oid));
+		if (interpret_nth_prior_checkout(r, str, len, &buf) > 0) {
+			detached = (buf.len == r->hash_algo->hexsz && !get_oid_hex(buf.buf, oid));
 			strbuf_release(&buf);
 			if (detached)
 				return 0;
@@ -845,19 +845,18 @@ static int get_oid_basic(const char *str, int len, struct object_id *oid,
 
 	if (!len && reflog_len)
 		/* allow "@{...}" to mean the current branch reflog */
-		refs_found = dwim_ref("HEAD", 4, oid, &real_ref);
+		refs_found = repo_dwim_ref(r, "HEAD", 4, oid, &real_ref);
 	else if (reflog_len)
-		refs_found = dwim_log(str, len, oid, &real_ref);
+		refs_found = repo_dwim_log(r, str, len, oid, &real_ref);
 	else
-		refs_found = dwim_ref(str, len, oid, &real_ref);
+		refs_found = repo_dwim_ref(r, str, len, oid, &real_ref);
 
 	if (!refs_found)
 		return -1;
 
 	if (warn_ambiguous_refs && !(flags & GET_OID_QUIETLY) &&
 	    (refs_found > 1 ||
-	     !get_short_oid(the_repository,
-			    str, len, &tmp_oid, GET_OID_QUIETLY)))
+	     !get_short_oid(r, str, len, &tmp_oid, GET_OID_QUIETLY)))
 		warning(warn_msg, len, str);
 
 	if (reflog_len) {
@@ -889,7 +888,7 @@ static int get_oid_basic(const char *str, int len, struct object_id *oid,
 				return -1;
 			}
 		}
-		if (read_ref_at(get_main_ref_store(the_repository),
+		if (read_ref_at(get_main_ref_store(r),
 				real_ref, flags, at_time, nth, oid, NULL,
 				&co_time, &co_tz, &co_cnt)) {
 			if (!len) {
@@ -1159,7 +1158,7 @@ static enum get_oid_result get_oid_1(const char *name, int len,
 	if (!ret)
 		return FOUND;
 
-	ret = get_oid_basic(name, len, oid, lookup_flags);
+	ret = get_oid_basic(the_repository, name, len, oid, lookup_flags);
 	if (!ret)
 		return FOUND;
 
-- 
2.21.0.rc0.328.g0e39304f8d

