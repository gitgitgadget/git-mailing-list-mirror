Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8D3FD20136
	for <e@80x24.org>; Fri, 17 Feb 2017 14:20:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934337AbdBQOU0 (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Feb 2017 09:20:26 -0500
Received: from mail-pg0-f65.google.com ([74.125.83.65]:33159 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934098AbdBQOUZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Feb 2017 09:20:25 -0500
Received: by mail-pg0-f65.google.com with SMTP id 5so5071436pgj.0
        for <git@vger.kernel.org>; Fri, 17 Feb 2017 06:20:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HHIaatm6EampQhu+C9iJ57VWc7JtDoWq+Xy4fi+Uatw=;
        b=ivU4rdiauOOuwpqORw94y3DO/1QlTNu5jLuErXzU3fCt4ug12MSNshBikcAzqD2WBi
         cNlNa46n0jeu4LV9BQ2pXl0KMD0HQFIFP8Nbgq7gcnzoJwigw743Nuxws6l9/8vApIhf
         LUbRZu+VsFWaG8RdlN2adBpSd5vhvl+Xk23D19Fx2fguPa3X97dud4+fmRjU+rUYFdQf
         kniugTUvIbJWOPgkRuDpeaXF3LP8JZsRiemI1ofMLqjIk29gVOwy4oK2Jl2qo+Qwcxpb
         OG2B2LLl1Fq775e02gGsrkXpuqE2wTCZPG2mdE1uGV6F4OW4JVWa+R/HW8PEylFYBNNa
         /k5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HHIaatm6EampQhu+C9iJ57VWc7JtDoWq+Xy4fi+Uatw=;
        b=qvvA7DDtb8U44eDfiNWBpgQxLm0AMzE0XQttLTH1wJXr/+4fFhuJ+xnls3QKFfAlwb
         83v3Rs4fOaWCd29TOxr+QRFbdnCXHEsKPraEdlh/xE8M4S6LcAFx5XRhApJ0XB9co6ia
         Ci37zPLR3hFvibOWP+V13PZ+90GYbWTECj9PhbXqgxMVGS43y8iwZwg5RZ8HTeR1jYWg
         PrAWsBAIwH3C3tAb3PslVQRlJHVQkRjUW97i8bIMm43YDUMh9eM/MWB9NDAI9dVDZvPp
         q7EvDMxbYjDalVfzNFKMEFoFurzexowZfgTgE+A/b85XFSrRsde9TsmGgGFBCFFcjLGf
         /uMg==
X-Gm-Message-State: AMke39kklFJAHoaXp6iyHCpGIYrldiiebianu+xusF5VSWD4SZqqGcc9FO/nbJHscJUoOA==
X-Received: by 10.84.169.67 with SMTP id g61mr11664609plb.137.1487341224379;
        Fri, 17 Feb 2017 06:20:24 -0800 (PST)
Received: from ash ([115.73.162.84])
        by smtp.gmail.com with ESMTPSA id 64sm20037035pfq.112.2017.02.17.06.20.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 Feb 2017 06:20:23 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Fri, 17 Feb 2017 21:20:19 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Stefan Beller <sbeller@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 10/15] refs: remove dead for_each_*_submodule()
Date:   Fri, 17 Feb 2017 21:19:03 +0700
Message-Id: <20170217141908.18012-11-pclouds@gmail.com>
X-Mailer: git-send-email 2.11.0.157.gd943d85
In-Reply-To: <20170217141908.18012-1-pclouds@gmail.com>
References: <20170217141908.18012-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

These are used in revision.c. After the last patch they are replaced
with the refs_ version. Delete them (except for_each_remote_ref_submodule
which is still used by submodule.c)

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 refs.c | 30 ------------------------------
 refs.h |  9 ---------
 2 files changed, 39 deletions(-)

diff --git a/refs.c b/refs.c
index 37b03d4ff..fa2df7a1d 100644
--- a/refs.c
+++ b/refs.c
@@ -310,12 +310,6 @@ int for_each_tag_ref(each_ref_fn fn, void *cb_data)
 	return refs_for_each_tag_ref(get_main_ref_store(), fn, cb_data);
 }
 
-int for_each_tag_ref_submodule(const char *submodule, each_ref_fn fn, void *cb_data)
-{
-	return refs_for_each_tag_ref(get_submodule_ref_store(submodule),
-				     fn, cb_data);
-}
-
 int refs_for_each_branch_ref(struct ref_store *refs, each_ref_fn fn, void *cb_data)
 {
 	return refs_for_each_ref_in(refs, "refs/heads/", fn, cb_data);
@@ -326,12 +320,6 @@ int for_each_branch_ref(each_ref_fn fn, void *cb_data)
 	return refs_for_each_branch_ref(get_main_ref_store(), fn, cb_data);
 }
 
-int for_each_branch_ref_submodule(const char *submodule, each_ref_fn fn, void *cb_data)
-{
-	return refs_for_each_branch_ref(get_submodule_ref_store(submodule),
-					fn, cb_data);
-}
-
 int refs_for_each_remote_ref(struct ref_store *refs, each_ref_fn fn, void *cb_data)
 {
 	return refs_for_each_ref_in(refs, "refs/remotes/", fn, cb_data);
@@ -1169,11 +1157,6 @@ int refs_head_ref(struct ref_store *refs, each_ref_fn fn, void *cb_data)
 	return 0;
 }
 
-int head_ref_submodule(const char *submodule, each_ref_fn fn, void *cb_data)
-{
-	return refs_head_ref(get_submodule_ref_store(submodule), fn, cb_data);
-}
-
 int head_ref(each_ref_fn fn, void *cb_data)
 {
 	return refs_head_ref(get_main_ref_store(), fn, cb_data);
@@ -1212,12 +1195,6 @@ int for_each_ref(each_ref_fn fn, void *cb_data)
 	return do_for_each_ref(get_main_ref_store(), "", fn, 0, 0, cb_data);
 }
 
-int for_each_ref_submodule(const char *submodule, each_ref_fn fn, void *cb_data)
-{
-	return do_for_each_ref(get_submodule_ref_store(submodule),
-			       "", fn, 0, 0, cb_data);
-}
-
 int refs_for_each_ref_in(struct ref_store *refs, const char *prefix,
 			 each_ref_fn fn, void *cb_data)
 {
@@ -1239,13 +1216,6 @@ int for_each_fullref_in(const char *prefix, each_ref_fn fn, void *cb_data, unsig
 			       prefix, fn, 0, flag, cb_data);
 }
 
-int for_each_ref_in_submodule(const char *submodule, const char *prefix,
-		each_ref_fn fn, void *cb_data)
-{
-	return do_for_each_ref(get_submodule_ref_store(submodule),
-			       prefix, fn, strlen(prefix), 0, cb_data);
-}
-
 int for_each_replace_ref(each_ref_fn fn, void *cb_data)
 {
 	return do_for_each_ref(get_main_ref_store(),
diff --git a/refs.h b/refs.h
index 8fc82deda..986d408bd 100644
--- a/refs.h
+++ b/refs.h
@@ -202,15 +202,6 @@ int for_each_glob_ref(each_ref_fn fn, const char *pattern, void *cb_data);
 int for_each_glob_ref_in(each_ref_fn fn, const char *pattern,
 			 const char *prefix, void *cb_data);
 
-int head_ref_submodule(const char *submodule, each_ref_fn fn, void *cb_data);
-int for_each_ref_submodule(const char *submodule,
-			   each_ref_fn fn, void *cb_data);
-int for_each_ref_in_submodule(const char *submodule, const char *prefix,
-		each_ref_fn fn, void *cb_data);
-int for_each_tag_ref_submodule(const char *submodule,
-			       each_ref_fn fn, void *cb_data);
-int for_each_branch_ref_submodule(const char *submodule,
-				  each_ref_fn fn, void *cb_data);
 int for_each_remote_ref_submodule(const char *submodule,
 				  each_ref_fn fn, void *cb_data);
 
-- 
2.11.0.157.gd943d85

