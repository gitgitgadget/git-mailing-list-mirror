Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 88EEB20248
	for <e@80x24.org>; Sat,  6 Apr 2019 11:37:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726640AbfDFLhV (ORCPT <rfc822;e@80x24.org>);
        Sat, 6 Apr 2019 07:37:21 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:39821 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726036AbfDFLhV (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 Apr 2019 07:37:21 -0400
Received: by mail-pf1-f195.google.com with SMTP id i17so1633449pfo.6
        for <git@vger.kernel.org>; Sat, 06 Apr 2019 04:37:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tV7Pu8ExeeZC83xGO7zNWhu0P7oJAV/3/iczI9tiSeE=;
        b=jYLGgUy6NdIZUbHdGgE4cHcWh8RJJoGX53e45i5mvzPu0DSkFM3qvh04KlBqL4MbgS
         WS8xfCyDuCI54Kj1385Fh+6GGfVLEa1MGgWsk7XlZIzwl9QmIech7DMouYqMJEK52Sgx
         +idpr1ah4zJ6sBM6viMK/C8x92kFTR+vYxiFpr6IowYZM77m5pO48TjTfVWx0u1WqfMu
         3nWtPnlpEchnvxVF3AOFATbFWo+F89cCz5Ky5a6/K7fSFRt/zwaacFZo3EHaOrOxPeBP
         dC/Tz5rDMyhkzwhpcxa1pKNUyc62x7kcsSXSG8Hs3eFQwlpHNdBifbmOG9pzEWlkwF+S
         +G+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tV7Pu8ExeeZC83xGO7zNWhu0P7oJAV/3/iczI9tiSeE=;
        b=ijKmEllI3UkOzHWO5w+OgdfP9Rn+WsXmPBmRNknNJlDRapgoqP9pWgzpAbqZToBznr
         PkVKpUv/oe7cpHXYMEhQ3+/bd9lenIK6R9t9uTF5UjUAALBYF/3+gOq8FtcS3CRP6htC
         GC+4zgMJkLEcdSqNLL2IZ2iIiw9ISygMzbpztThHu5+iEKWuK1olVf4WzOgb5rKEs3Sk
         QgwaCUsoCGMvG7fWztysTpyLx2tsBhg4a5IZtDuBqB75dNT3F0VW3Q8T1Yvfna8H0D0f
         E0Ay/UQ+/B4e7HlmA7Xkf2Fa6El6yTkAhN6xNxlC8eeTEU0dCAaYnuHLWto3/U7BXaP7
         EaTg==
X-Gm-Message-State: APjAAAUsWQBN0yNf1fmShXmBLifF6P52AXk0u9g88D4WRDrFxEvIa98p
        weudM4GoHodEB1jihTFjq+k=
X-Google-Smtp-Source: APXvYqxGtS7/cpz97bPQbV+X+Xoqf+fScsx6GVgB2ZIVBATsRPZL1VVBaSUedpRlr69Z80OWJ87P+g==
X-Received: by 2002:a63:df4d:: with SMTP id h13mr17404191pgj.220.1554550640696;
        Sat, 06 Apr 2019 04:37:20 -0700 (PDT)
Received: from ash ([116.102.217.71])
        by smtp.gmail.com with ESMTPSA id b13sm15465837pfd.12.2019.04.06.04.37.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 06 Apr 2019 04:37:20 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Sat, 06 Apr 2019 18:37:15 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, stefanbeller@gmail.com,
        szeder.dev@gmail.com,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH v3 23/33] sha1-name.c: remove the_repo from get_oid_basic()
Date:   Sat,  6 Apr 2019 18:34:43 +0700
Message-Id: <20190406113453.5149-24-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.479.g47ac719cd3
In-Reply-To: <20190406113453.5149-1-pclouds@gmail.com>
References: <20190403113457.20399-1-pclouds@gmail.com>
 <20190406113453.5149-1-pclouds@gmail.com>
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
2.21.0.479.g47ac719cd3

