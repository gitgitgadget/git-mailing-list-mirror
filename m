Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D74511FA7B
	for <e@80x24.org>; Thu, 22 Jun 2017 18:44:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753595AbdFVSoO (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Jun 2017 14:44:14 -0400
Received: from mail-pf0-f182.google.com ([209.85.192.182]:35906 "EHLO
        mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752493AbdFVSoM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Jun 2017 14:44:12 -0400
Received: by mail-pf0-f182.google.com with SMTP id q86so12531259pfl.3
        for <git@vger.kernel.org>; Thu, 22 Jun 2017 11:44:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ewcNdLBacroy/feJ+jFCUzBA5UDDnbRVC0wc7S8+iEA=;
        b=IEHgg0uyQJKiIbj5LFfLvqkrqPQpmX1bCw/VqzCYHdxco2Vplbzi9Qc7JMbFysJbzC
         FRBeOPM2Vi30JvHwK69dhSpoYXMgIHno7b32rmmJ2gNPmpP4GrQ4v5Rxn9BqQv3EwT8i
         bRtCDXLCwcZmHKwxiMGfoCDYkIdtAFoVhRSECUra0RHjT3IqKl3z5DpF8mKUGAyiso73
         EvqjNiuAq75QdEI8fjHggjxMxVelwebpyHjujf7/3BkD/W5HBMT2MCTL6qA+of8Dynnz
         B+1tgvLKKieI9Er9td3s1t0UtAh6ypwe97nNkg+0I1ukcnYXgx0pVKQ02vcxg9no7bFg
         LTsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ewcNdLBacroy/feJ+jFCUzBA5UDDnbRVC0wc7S8+iEA=;
        b=fzL8vuW6L9esN79EEdvgMStDi0k8B6+ofLwhjr9SojBKDSoWn9z+o3AIVsZojRO7Qy
         yqV7RmtDAHtz41G5JRWAe/Ire/8NPndVmzXoEjsDamcFVr5+YobQXY7DHIXeXyIkpa3Z
         X6Ytzn47x5urBDP05jFtLphHFr7HLf4tgVDmpKm/+Y6CODQlN76JG3Psd3YBvlZKThiu
         5fJ76N6MMGG2fCvIDZvEzlQI8Zoa+lZmtNQfJOnMjc7P1q/LXD7qZ3vDry2GYpY4L4Ye
         Cx15CM2a1Kj3DIrTVFWs3iBkW/vhsKBgFpGejzgReVVrBeF2GaLSsBPGNMYx0YOP+9pF
         pkkQ==
X-Gm-Message-State: AKS2vOxF9ft6LVfXJtyGYEr8o4MtrZbRcoSr+YaEtpW8GBgEnRcbt+R7
        xGH0iliP5QPrP6tAMY8KuA==
X-Received: by 10.84.167.74 with SMTP id j10mr4439556plg.144.1498157046122;
        Thu, 22 Jun 2017 11:44:06 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id g78sm5222211pfb.122.2017.06.22.11.44.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 22 Jun 2017 11:44:05 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, jrnieder@gmail.com, jacob.keller@gmail.com,
        Johannes.Schindelin@gmx.de, sandals@crustytoothpaste.net,
        peartben@gmail.com, pclouds@gmail.com, gitster@pobox.com,
        peff@peff.net, git@jeffhostetler.com, avarab@gmail.com,
        jonathantanmy@google.com, Brandon Williams <bmwill@google.com>
Subject: [PATCH v4 03/20] environment: remove namespace_len variable
Date:   Thu, 22 Jun 2017 11:43:31 -0700
Message-Id: <20170622184348.56497-4-bmwill@google.com>
X-Mailer: git-send-email 2.13.1.704.gde00cce3c-goog
In-Reply-To: <20170622184348.56497-1-bmwill@google.com>
References: <20170620191951.84791-1-bmwill@google.com>
 <20170622184348.56497-1-bmwill@google.com>
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
2.13.1.704.gde00cce3c-goog

