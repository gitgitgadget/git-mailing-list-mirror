Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9A8FD20899
	for <e@80x24.org>; Wed, 23 Aug 2017 12:38:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754048AbdHWMiX (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 Aug 2017 08:38:23 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:36533 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753834AbdHWMiW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Aug 2017 08:38:22 -0400
Received: by mail-pf0-f194.google.com with SMTP id c15so1353545pfm.3
        for <git@vger.kernel.org>; Wed, 23 Aug 2017 05:38:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WjpfjSxoif0+mwPCyZr3ncuIbsj/fERfH4TAFsO0tkg=;
        b=FCi4uciaKs+01gjAZ0znLsRPsX1K6NzNRvCcZ3kFYP7rMUtwNNgqEADAGMgTqcyTOD
         wQo6RUUK+2XeTeJ5g8pG99mZIFgldll86aeiGEJRNzEz7MXPe5slkDyGH5OEPAyRmN6g
         O6gxXXBFX2vJMg0BNqEZVp8NigIWD5B+K+xXVTb+2R1tFNX9TEC8E2zpa9vdu0CXoAIk
         pA/lTXv08I/8hOy4F3neocM4n1aK8a2c6ugmo9hXvqb6YiazntWDqGk4BnYag6FSnz9e
         FDos6JieW2jgwfxWjC/wVw+NqYOdkhKlYPLO2gZ2UQSEt6YiBUFQgGobw8ZPifv/Dfo1
         H/Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WjpfjSxoif0+mwPCyZr3ncuIbsj/fERfH4TAFsO0tkg=;
        b=FKvAA+rlVuYf+7xe/oioCDRVVoTcmn92TA2sVJuHUl+hP9fiHpMO5D7Ebnmg7Nzwom
         jth4BNLlcMpDs1aAc4YtqFvBG+qRC44HwgPl07Ze6ilP+SRSpTpcuuNBM+4slIacjMSH
         ET1ywEYoNha2R4YfxnE5isVSfhtIvO5Chs4pSFJD7QkEhA9lAjmL031HQHZA9S37Dxgj
         PelsWrAIHBXe2REEhfs3YBHyb+vEqq8JaHgM7Od9mEdUeZGD/K9/i31tVM4r45pZlRoK
         8fnZOeWf2Z0IJudpk+fTbe6E0ytLz5TkhqZ9HNEn2WrdexF8oBo8knbyXCT098ekOKYz
         bI3Q==
X-Gm-Message-State: AHYfb5iovZa2KUyi+UcrfdqEzzxvRBsdpQVp99NaApGBgZRi2WLb/WIb
        wQbKPRi6T1eM1UwJ
X-Received: by 10.98.214.81 with SMTP id r78mr2629101pfg.159.1503491901886;
        Wed, 23 Aug 2017 05:38:21 -0700 (PDT)
Received: from ash ([115.72.183.215])
        by smtp.gmail.com with ESMTPSA id c80sm3833296pfj.26.2017.08.23.05.38.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Aug 2017 05:38:21 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Wed, 23 Aug 2017 19:38:16 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Stefan Beller <sbeller@google.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v4 10/16] refs: remove dead for_each_*_submodule()
Date:   Wed, 23 Aug 2017 19:36:58 +0700
Message-Id: <20170823123704.16518-11-pclouds@gmail.com>
X-Mailer: git-send-email 2.11.0.157.gd943d85
In-Reply-To: <20170823123704.16518-1-pclouds@gmail.com>
References: <20170823123704.16518-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

These are used in revision.c. After the last patch they are replaced
with the refs_ version. Delete them.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 Documentation/technical/api-ref-iteration.txt |  7 ++----
 refs.c                                        | 33 ---------------------------
 refs.h                                        | 10 --------
 3 files changed, 2 insertions(+), 48 deletions(-)

diff --git a/Documentation/technical/api-ref-iteration.txt b/Documentation/technical/api-ref-iteration.txt
index 37379d8337..46c3d5c355 100644
--- a/Documentation/technical/api-ref-iteration.txt
+++ b/Documentation/technical/api-ref-iteration.txt
@@ -32,11 +32,8 @@ Iteration functions
 
 * `for_each_glob_ref_in()` the previous and `for_each_ref_in()` combined.
 
-* `head_ref_submodule()`, `for_each_ref_submodule()`,
-  `for_each_ref_in_submodule()`, `for_each_tag_ref_submodule()`,
-  `for_each_branch_ref_submodule()`, `for_each_remote_ref_submodule()`
-  do the same as the functions described above but for a specified
-  submodule.
+* Use `refs_` API for accessing submodules. The submodule ref store could
+  be obtained with `get_submodule_ref_store()`.
 
 * `for_each_rawref()` can be used to learn about broken ref and symref.
 
diff --git a/refs.c b/refs.c
index 7fa19e9309..8c989ffec7 100644
--- a/refs.c
+++ b/refs.c
@@ -336,12 +336,6 @@ int for_each_tag_ref(each_ref_fn fn, void *cb_data)
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
@@ -352,12 +346,6 @@ int for_each_branch_ref(each_ref_fn fn, void *cb_data)
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
@@ -1254,15 +1242,6 @@ int refs_head_ref(struct ref_store *refs, each_ref_fn fn, void *cb_data)
 	return 0;
 }
 
-int head_ref_submodule(const char *submodule, each_ref_fn fn, void *cb_data)
-{
-	struct ref_store *refs = get_submodule_ref_store(submodule);
-
-	if (!refs)
-		return -1;
-	return refs_head_ref(refs, fn, cb_data);
-}
-
 int head_ref(each_ref_fn fn, void *cb_data)
 {
 	return refs_head_ref(get_main_ref_store(), fn, cb_data);
@@ -1323,11 +1302,6 @@ int for_each_ref(each_ref_fn fn, void *cb_data)
 	return refs_for_each_ref(get_main_ref_store(), fn, cb_data);
 }
 
-int for_each_ref_submodule(const char *submodule, each_ref_fn fn, void *cb_data)
-{
-	return refs_for_each_ref(get_submodule_ref_store(submodule), fn, cb_data);
-}
-
 int refs_for_each_ref_in(struct ref_store *refs, const char *prefix,
 			 each_ref_fn fn, void *cb_data)
 {
@@ -1349,13 +1323,6 @@ int for_each_fullref_in(const char *prefix, each_ref_fn fn, void *cb_data, unsig
 			       prefix, fn, 0, flag, cb_data);
 }
 
-int for_each_ref_in_submodule(const char *submodule, const char *prefix,
-			      each_ref_fn fn, void *cb_data)
-{
-	return refs_for_each_ref_in(get_submodule_ref_store(submodule),
-				    prefix, fn, cb_data);
-}
-
 int refs_for_each_fullref_in(struct ref_store *refs, const char *prefix,
 			     each_ref_fn fn, void *cb_data,
 			     unsigned int broken)
diff --git a/refs.h b/refs.h
index 5d25da227a..78a26400b6 100644
--- a/refs.h
+++ b/refs.h
@@ -304,16 +304,6 @@ int for_each_glob_ref(each_ref_fn fn, const char *pattern, void *cb_data);
 int for_each_glob_ref_in(each_ref_fn fn, const char *pattern,
 			 const char *prefix, void *cb_data);
 
-int head_ref_submodule(const char *submodule, each_ref_fn fn, void *cb_data);
-int for_each_ref_submodule(const char *submodule,
-			   each_ref_fn fn, void *cb_data);
-int for_each_ref_in_submodule(const char *submodule, const char *prefix,
-			      each_ref_fn fn, void *cb_data);
-int for_each_tag_ref_submodule(const char *submodule,
-			       each_ref_fn fn, void *cb_data);
-int for_each_branch_ref_submodule(const char *submodule,
-				  each_ref_fn fn, void *cb_data);
-
 int head_ref_namespaced(each_ref_fn fn, void *cb_data);
 int for_each_namespaced_ref(each_ref_fn fn, void *cb_data);
 
-- 
2.11.0.157.gd943d85

