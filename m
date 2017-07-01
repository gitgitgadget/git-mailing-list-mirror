Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 400C7201A0
	for <e@80x24.org>; Sat,  1 Jul 2017 00:28:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752137AbdGAA2x (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Jun 2017 20:28:53 -0400
Received: from mail-pg0-f51.google.com ([74.125.83.51]:34247 "EHLO
        mail-pg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752019AbdGAA2r (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Jun 2017 20:28:47 -0400
Received: by mail-pg0-f51.google.com with SMTP id t186so70726291pgb.1
        for <git@vger.kernel.org>; Fri, 30 Jun 2017 17:28:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=X2jGHnaRECFJGdTn12VH8ZEK04nlvekjCEEEKcsGXTg=;
        b=OYIUpF1WVYS+bf2NriQG161ZHANq6W9wzSt+GB4BNskqPWj440nxbLjeAVqm6HBMAQ
         D+7f4PwknULPQSsowiZjvIq3W6sAO5yX23tbp8/XkXk3yO32gVaKQhBfK478P0hLLqCt
         uM/wKnO/C8kyN31WyiDu1xfZJoeUkrQxq6heSLfs5vJlvjLlMbL3QwatsL564iuX1JU6
         n+j6V5fWOOU01aM5VX/41kzFbG59R3DjNPWMV+PRLVKTx/G+8h1LqtBFL7MYWOC/2g+5
         JoLClhsvm89eEPA5IY+QG8uhAWcwzwIjMcRUwjUI8OBa4PRwSpqBMsZDopoTwKDlKVTx
         /HAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=X2jGHnaRECFJGdTn12VH8ZEK04nlvekjCEEEKcsGXTg=;
        b=skA4OxCdMAC0jOtxYS3PDz+6ciUQtbtRdB5kYzV0WdGsf/9t6tIz3PtsYX/pRrucWh
         0muMFif/hSE8K5DhE6qgLHmlcexl3+PPfwceNgnIcn/J9nmuhAGyTklszvjKV+uznmPU
         FWy8Uo0MUcb5KyJwJ+SU/CoVFhvukYedyrs6FgyucA2i0ooD1RgFrG8kCidzYPCGVw9W
         FOOd+fc8rnkeEaAc1luWGPxTWAhl3h1kPDA30BGE89INzErJqmbXAf8ePOSsFCYEsqHg
         Adww6CYpma7m4p+OPhojtApoppPleb3EnNg2LmK9RY2HpatjHmAAOtdgjEF7t3ffqoGf
         s7LQ==
X-Gm-Message-State: AKS2vOyft9oSfuU+iqih1CNNkmhWyrLjjKYIjR7uOkcDfklz3juRLCec
        tBmF2JXJ2h+CKepdX5VIvQ==
X-Received: by 10.99.55.19 with SMTP id e19mr24239195pga.28.1498868926706;
        Fri, 30 Jun 2017 17:28:46 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:cc8b:7c8c:8e14:f9b5])
        by smtp.gmail.com with ESMTPSA id t26sm23313049pfe.88.2017.06.30.17.28.45
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 30 Jun 2017 17:28:46 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, Stefan Beller <sbeller@google.com>
Subject: [PATCH 04/10] config.c: drop hashmap_cmp_fn cast
Date:   Fri, 30 Jun 2017 17:28:32 -0700
Message-Id: <20170701002838.22785-5-sbeller@google.com>
X-Mailer: git-send-email 2.13.0.31.g9b732c453e
In-Reply-To: <20170701002838.22785-1-sbeller@google.com>
References: <20170701002838.22785-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 config.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/config.c b/config.c
index 4a31e31ac3..30ff700629 100644
--- a/config.c
+++ b/config.c
@@ -1754,17 +1754,19 @@ static int configset_add_value(struct config_set *cs, const char *key, const cha
 }
 
 static int config_set_element_cmp(const void *unused_cmp_data,
-				  const struct config_set_element *e1,
-				  const struct config_set_element *e2,
+				  const void *entry,
+				  const void *entry_or_key,
 				  const void *unused_keydata)
 {
+	const struct config_set_element *e1 = entry;
+	const struct config_set_element *e2 = entry_or_key;
+
 	return strcmp(e1->key, e2->key);
 }
 
 void git_configset_init(struct config_set *cs)
 {
-	hashmap_init(&cs->config_hash, (hashmap_cmp_fn)config_set_element_cmp,
-		     NULL, 0);
+	hashmap_init(&cs->config_hash, config_set_element_cmp, NULL, 0);
 	cs->hash_initialized = 1;
 	cs->list.nr = 0;
 	cs->list.alloc = 0;
-- 
2.13.0.31.g9b732c453e

