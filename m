Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 448CD20D18
	for <e@80x24.org>; Tue, 20 Jun 2017 19:20:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752014AbdFTTUR (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Jun 2017 15:20:17 -0400
Received: from mail-pf0-f177.google.com ([209.85.192.177]:35590 "EHLO
        mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751036AbdFTTUQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jun 2017 15:20:16 -0400
Received: by mail-pf0-f177.google.com with SMTP id c73so13545435pfk.2
        for <git@vger.kernel.org>; Tue, 20 Jun 2017 12:20:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=IYLqqaKPCkWi5kLzGcXHfYKgD1pzdMl3tAAmg8lw/X4=;
        b=innypOx0fV1uN7ehAvcOoN/kIJATaqb+ZNimfm1qTPa0PtXLHzGbDaKtF0IQ5Qb4hc
         Z4N7cSY1IkIuwSgLtVofs307R5c9ypInHKBshCZb3yM15dPwB0SfY37pfiTvTrAMWUg/
         nd8Gf5kF9ysqXy8BnWoy2pic8xgH0Hqpe670wg65lw8YuvLE545QHNtUrncopqfwqwha
         muPjdkdg5XRpirxxlAWSkNAYPQR4/ypPW9ET891Gi8Bmwll7sY6guZnUr8DeA8qblJIm
         7XtfZaBNCpLjrJs9mPnSs6bpuM/c4+u1/P107+WbbRMOafh0DtE3nGM/W4V/uv4SWqv+
         zR8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=IYLqqaKPCkWi5kLzGcXHfYKgD1pzdMl3tAAmg8lw/X4=;
        b=eztABVes2grmr71SjaRGch7aHBiQgEKASMedcF/yQZTLuPP1q5+xy1My0Rp5pCh1FL
         L9opZ6ZLoKGG3wXaaHl96JXVoykI2qgciygi+1rA444vktiI5vSyJiW4xx7dGDzZMxjr
         MFsl2YTV6D2yumEJUk61o+ovkIu6t80Rqn1dZoCIp6qlDqeyU2HG3Zt7ZNNWo7h4XGNh
         3x1ZYDz2K3bkFgeFuU/X2iLTuHPuS7WI9LNvcxNIrovLMTGUWlr7+K2SqW8vidoLJuiB
         hnprkxlCXjXZ0IX8Kwe4T+LUofyeUKnIzQgF0yeTK7A8H8dTqlu4sF/rsIzyXbj5vu8e
         jd0w==
X-Gm-Message-State: AKS2vOzqqV8lDIZ0lD+GTmpKdPVmLs4KmGhaBgf23Y+t5FNqkB2F3f6N
        B8fajbTnyXY5PgrPrdujjg==
X-Received: by 10.98.220.193 with SMTP id c62mr32593957pfl.140.1497986415231;
        Tue, 20 Jun 2017 12:20:15 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id t6sm18680500pgs.33.2017.06.20.12.20.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 20 Jun 2017 12:20:13 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, jrnieder@gmail.com, jacob.keller@gmail.com,
        Johannes.Schindelin@gmx.de, sandals@crustytoothpaste.net,
        peartben@gmail.com, pclouds@gmail.com, gitster@pobox.com,
        peff@peff.net, git@jeffhostetler.com, avarab@gmail.com,
        jonathantanmy@google.com, Brandon Williams <bmwill@google.com>
Subject: [PATCH v3 03/20] environment: remove namespace_len variable
Date:   Tue, 20 Jun 2017 12:19:34 -0700
Message-Id: <20170620191951.84791-4-bmwill@google.com>
X-Mailer: git-send-email 2.13.1.611.g7e3b11ae1-goog
In-Reply-To: <20170620191951.84791-1-bmwill@google.com>
References: <20170608234100.188529-1-bmwill@google.com>
 <20170620191951.84791-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Use 'skip_prefix' instead of 'starts_with' so that we can drop the need
to keep around 'namespace_len'.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 environment.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/environment.c b/environment.c
index a73b08f5d..e035f6372 100644
--- a/environment.c
+++ b/environment.c
@@ -98,7 +98,6 @@ char *git_work_tree_cfg;
 static char *work_tree;
 
 static const char *namespace;
-static size_t namespace_len;
 
 static const char *super_prefix;
 
@@ -190,7 +189,6 @@ void setup_git_env(void)
 	git_replace_ref_base = xstrdup(replace_ref_base ? replace_ref_base
 							  : "refs/replace/");
 	namespace = expand_namespace(getenv(GIT_NAMESPACE_ENVIRONMENT));
-	namespace_len = strlen(namespace);
 	shallow_file = getenv(GIT_SHALLOW_FILE_ENVIRONMENT);
 	if (shallow_file)
 		set_alternate_shallow_file(shallow_file, 0);
@@ -231,9 +229,10 @@ const char *get_git_namespace(void)
 
 const char *strip_namespace(const char *namespaced_ref)
 {
-	if (!starts_with(namespaced_ref, get_git_namespace()))
-		return NULL;
-	return namespaced_ref + namespace_len;
+	const char *out;
+	if (skip_prefix(namespaced_ref, get_git_namespace(), &out))
+		return out;
+	return NULL;
 }
 
 const char *get_super_prefix(void)
-- 
2.13.1.611.g7e3b11ae1-goog

