Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C85911FAEB
	for <e@80x24.org>; Thu,  8 Jun 2017 23:41:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751642AbdFHXla (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Jun 2017 19:41:30 -0400
Received: from mail-pf0-f176.google.com ([209.85.192.176]:34993 "EHLO
        mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751501AbdFHXlZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Jun 2017 19:41:25 -0400
Received: by mail-pf0-f176.google.com with SMTP id l89so22164632pfi.2
        for <git@vger.kernel.org>; Thu, 08 Jun 2017 16:41:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=r3oY8VAzT/YWqt/QHLl4o5Ky4yRFVS47KgFXbmNsO4s=;
        b=oLTvY2paS7zfiLVnvBL3zRjv+8LOiS/8sOnXCuOteB/0Ok5DrJ5PpXV59fZ7umwQ0n
         1R6/Px6Z6HlhOMYP8L0q51fjuW5iqt7TDwmIGWRX9TB0myjlYw7djTVuEqs6u0TOY5dH
         8ZG8mN89GBjxQwk1/orr+ozPDavRSdG6fTaolIh7fP40k/hhGCFQNYTsuNnV1lPa80Ai
         7AtQChhV6crkCwoh17DnMIEZaQ80wXEdLBe2VpqXrMWiXZ0uvKGyh3XAlyNM4mAHto1p
         V728YIORxDlpKv4V/50ecBCHF+wzT0TLp3ajT/mufhdN3YvCqupc76EP95IEeg0PhYLV
         WJ6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=r3oY8VAzT/YWqt/QHLl4o5Ky4yRFVS47KgFXbmNsO4s=;
        b=qayvDZTC+HPOSiSe5NBm4CbbZge+RYJTAhnJ3jKZ2Wqd0sMMl+gelO0oVNJf65a6vH
         2QIJY2uck31IAE8VxWojHYQxuxjWl2/H8+khb+hcp8jUDthTxMGpz7UBo3gwyckLiIp6
         G0QDEeLmjS8cmfljKcyHAAlDKL5HTjOigktoYdwQqPpDa6E1BuYlJph1WWauQQFyR5mV
         hgzgJhDYBRowPdH3m5W4c8qFEPmFfenlnBPA+yOy5Q+H8wsFA0SOi4kk1dODivueKwzU
         tdk2zt/x4zOkXGt5nilGOJOeHo5ioaLic/B5O0qwXACdq4ce0fCodqcGKRMHNFNLxB5S
         eqOA==
X-Gm-Message-State: AODbwcBZN/PWTqmQwmadol6p1hmXGDBQ7V5xgAQmOpFenCn3Va7oBia7
        VWbXQaadmdMfdLzQwwNPIQ==
X-Received: by 10.84.247.2 with SMTP id n2mr36284091pll.74.1496965283060;
        Thu, 08 Jun 2017 16:41:23 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id m65sm11745237pfg.94.2017.06.08.16.41.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 08 Jun 2017 16:41:22 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, jrnieder@gmail.com, jacob.keller@gmail.com,
        Johannes.Schindelin@gmx.de, sandals@crustytoothpaste.net,
        peartben@gmail.com, pclouds@gmail.com, gitster@pobox.com,
        peff@peff.net, git@jeffhostetler.com, avarab@gmail.com,
        jonathantanmy@google.com, Brandon Williams <bmwill@google.com>
Subject: [PATCH v2 06/32] environment: remove namespace_len variable
Date:   Thu,  8 Jun 2017 16:40:34 -0700
Message-Id: <20170608234100.188529-7-bmwill@google.com>
X-Mailer: git-send-email 2.13.1.508.gb3defc5cc-goog
In-Reply-To: <20170608234100.188529-1-bmwill@google.com>
References: <20170531214417.38857-1-bmwill@google.com>
 <20170608234100.188529-1-bmwill@google.com>
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
2.13.1.508.gb3defc5cc-goog

