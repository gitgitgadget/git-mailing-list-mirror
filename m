Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2BADF20323
	for <e@80x24.org>; Sat, 18 Mar 2017 10:22:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751105AbdCRKWE (ORCPT <rfc822;e@80x24.org>);
        Sat, 18 Mar 2017 06:22:04 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:34615 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750971AbdCRKWC (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Mar 2017 06:22:02 -0400
Received: by mail-pf0-f194.google.com with SMTP id o126so11324397pfb.1
        for <git@vger.kernel.org>; Sat, 18 Mar 2017 03:21:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=HmzfUmxhTQmRxWy8VBDpcE+mKNBAaKf7vbikw/qDpwE=;
        b=tJuX3uu+3sOa3lW3fjYdu3ujGqWtnLETW+6TXufWl2+b8qYg0Y8RS8R5a43AhQ1uZy
         BvTPtgv9AGOOt+u85n5N9qgQz50twHrLRqeRaD7HPRDyWqmps/deZ2Mt8A6UR+CKpaeE
         afJIXyjJmSq5wh2fYUdJpFg3ZnOw8kIgxZfUzc0JhBOVhA8/Yr5qaSgcWE+tQcl7jC3z
         8NOyNZXqnml4BycRF6rQTixKtJHg8sXFhmG3pCuVYDazUYDVR5bsrU5g1dMaTWk8gNC/
         SUxgaWpnERiQH3HEKMMsHqsMHswfZK8nU4Sz04EhmDdtVbJ3p1+THV+TPB/317xoqPV1
         9pGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=HmzfUmxhTQmRxWy8VBDpcE+mKNBAaKf7vbikw/qDpwE=;
        b=MZoz9A7nIaT451AD/vVGX6oVglWdmOaoK2MlWdf4u7S0cND4VMQuRia3/Ma0MrGqfT
         c9pHsAcUhzE/0dyhbWrkwFKFbSVkA3vcS2o4eX54zY06ll3DeQ0z3RotnNVImasVBUtr
         x2kKSanJjgxvBeN9431ur38j7IXbVHb7FLGnnYpHNNI2mcFMglcXn+sRKWyBt/8qvd2N
         ztgkcTHzSo8LqYA5+9Ep5zd+F2X8eM/nOYF+hr87DWmzRnmsTQO2pywe00GhK+BwKNqA
         G8Vy2ORJuL/0bPbbAEu7pd/nK5sHFNFNvN2/spoOe3Z31Q3ITFHgalItyE3PpFoYxfD8
         gTCA==
X-Gm-Message-State: AFeK/H0YD+eYSauHnnkOp5/ASZgjP9J9hECBjY3AgmajN7YSOvY+6zsrhIppxdGsgCq82g==
X-Received: by 10.98.58.136 with SMTP id v8mr22293314pfj.230.1489831966642;
        Sat, 18 Mar 2017 03:12:46 -0700 (PDT)
Received: from ash ([115.72.187.186])
        by smtp.gmail.com with ESMTPSA id y5sm21931074pgy.28.2017.03.18.03.12.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 18 Mar 2017 03:12:46 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Sat, 18 Mar 2017 17:12:41 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Stefan Beller <sbeller@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v2 08/12] refs: remove dead for_each_*_submodule()
Date:   Sat, 18 Mar 2017 17:11:49 +0700
Message-Id: <20170318101153.6901-9-pclouds@gmail.com>
X-Mailer: git-send-email 2.11.0.157.gd943d85
In-Reply-To: <20170318101153.6901-1-pclouds@gmail.com>
References: <20170217141908.18012-1-pclouds@gmail.com>
 <20170318101153.6901-1-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

These are used in revision.c. After the last patch they are replaced
with the refs_ version. Delete them (except for_each_remote_ref_submodule
which is still used by submodule.c)
---
 refs.c | 24 ------------------------
 refs.h |  9 ---------
 2 files changed, 33 deletions(-)

diff --git a/refs.c b/refs.c
index 5fc47ff5f0..1f2f870084 100644
--- a/refs.c
+++ b/refs.c
@@ -316,12 +316,6 @@ int for_each_tag_ref(each_ref_fn fn, void *cb_data)
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
@@ -332,12 +326,6 @@ int for_each_branch_ref(each_ref_fn fn, void *cb_data)
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
@@ -1263,11 +1251,6 @@ int for_each_ref(each_ref_fn fn, void *cb_data)
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
@@ -1289,13 +1272,6 @@ int for_each_fullref_in(const char *prefix, each_ref_fn fn, void *cb_data, unsig
 			       prefix, fn, 0, flag, cb_data);
 }
 
-int for_each_ref_in_submodule(const char *submodule, const char *prefix,
-			      each_ref_fn fn, void *cb_data)
-{
-	return refs_for_each_ref_in(get_submodule_ref_store(submodule),
-				    prefix, fn, cb_data);
-}
-
 int for_each_replace_ref(each_ref_fn fn, void *cb_data)
 {
 	return do_for_each_ref(get_main_ref_store(),
diff --git a/refs.h b/refs.h
index 0572473ef7..e06db37118 100644
--- a/refs.h
+++ b/refs.h
@@ -259,15 +259,6 @@ int for_each_glob_ref(each_ref_fn fn, const char *pattern, void *cb_data);
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

