Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F11E2207E4
	for <e@80x24.org>; Fri, 28 Apr 2017 23:54:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2999767AbdD1XyY (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Apr 2017 19:54:24 -0400
Received: from mail-pg0-f42.google.com ([74.125.83.42]:34901 "EHLO
        mail-pg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1948703AbdD1XyO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Apr 2017 19:54:14 -0400
Received: by mail-pg0-f42.google.com with SMTP id o3so16379894pgn.2
        for <git@vger.kernel.org>; Fri, 28 Apr 2017 16:54:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zBD1Ikf3DOWcW/kStRZD9jtlpwrxMHTmV5Vj4m43ocQ=;
        b=vPxF+zn0kpBfbeczluE1pFZ2OxPAe/UkO+WUmEzSBGDIrLDuDnovU2SmdWV8cPhL45
         uIx212uRd+9pcu2MK9lt4S8iq+yB+hIAf/bgKAEVyl4p9HwvwVa02ICBOHpFwjTBNVOC
         tqYeVk9CdG77ObN4C4R3LEkVTuBVd6EF5LasEV+YM12m/Ay4ItdhPniLKzF+w2l7rSbr
         Hz1sjd/yy4LWc22YTLtaZUOtYj3s3jgzMKxgab2A68xAyJhb3y5EmNDJLtGz22rHIfHH
         bFYP+g9Qxb1GY3O9gQV8BWi5TbosRbQP9NmGWKIMNYHuvWV5wllxmMOEAd8yoLTQ2Iqv
         6Ogg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=zBD1Ikf3DOWcW/kStRZD9jtlpwrxMHTmV5Vj4m43ocQ=;
        b=A8W1fg/r9xeIV4X+9eoD3QzlGu0VepbCtz30z4Kt8ZA/d8VA/o0S360w5Y6AXWewvL
         JewUmMLXq7h1R64Xk+gNHcAotsRhBaKibXfcLIDJz/93mxnf5+8SJVCa20CR9rL3JGNL
         xRpipZQZ51DyQgUm/2EAV5d/8gDiXSLJNFQ3v/0g7zUpfQyZ3jS7UKcI2M8SaGvE8g8F
         uPbFATOad/OJ72CZSMPLsk/D35OD+bpJRfVY49W9Chw8YJUm/EZGM1Z4AhQykUYyVXxO
         K6WY1D2AONDTbDd52+AM/JYfnCZds3VC3HNSHtCzAA9EIAIr5YvW4NClpc3cOFoPITmL
         Brlw==
X-Gm-Message-State: AN3rC/4EZdhrMIM4YejJTWTPU7YdI1Ls/pldvYoHHkv9newNqE9lkRRU
        5QFpW6t4xbLt9PNo
X-Received: by 10.84.137.1 with SMTP id 1mr18451647plm.68.1493423653869;
        Fri, 28 Apr 2017 16:54:13 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id 188sm5332429pfu.15.2017.04.28.16.54.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 28 Apr 2017 16:54:12 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>
Subject: [PATCH 2/6] submodule: rename free_submodules_sha1s
Date:   Fri, 28 Apr 2017 16:53:58 -0700
Message-Id: <20170428235402.162251-3-bmwill@google.com>
X-Mailer: git-send-email 2.13.0.rc0.306.g87b477812d-goog
In-Reply-To: <20170428235402.162251-1-bmwill@google.com>
References: <20170428235402.162251-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rename 'free_submodules_sha1s()' to 'free_submodules_oids()' since the
function frees a 'struct string_list' which has a 'struct oid_array'
stored in the 'util' field.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 submodule.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/submodule.c b/submodule.c
index be0f5d847..46abd52b1 100644
--- a/submodule.c
+++ b/submodule.c
@@ -738,7 +738,7 @@ static void find_unpushed_submodule_commits(struct commit *commit,
 	diff_tree_combined_merge(commit, 1, &rev);
 }
 
-static void free_submodules_sha1s(struct string_list *submodules)
+static void free_submodules_oids(struct string_list *submodules)
 {
 	struct string_list_item *item;
 	for_each_string_list_item(item, submodules)
@@ -779,7 +779,8 @@ int find_unpushed_submodules(struct oid_array *commits,
 		if (submodule_needs_pushing(submodule->string, commits))
 			string_list_insert(needs_pushing, submodule->string);
 	}
-	free_submodules_sha1s(&submodules);
+
+	free_submodules_oids(&submodules);
 
 	return needs_pushing->nr;
 }
-- 
2.13.0.rc0.306.g87b477812d-goog

