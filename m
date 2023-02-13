Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57CCDC636D4
	for <git@archiver.kernel.org>; Mon, 13 Feb 2023 18:22:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230215AbjBMSWe (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Feb 2023 13:22:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231310AbjBMSWP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Feb 2023 13:22:15 -0500
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 287FB20552
        for <git@vger.kernel.org>; Mon, 13 Feb 2023 10:21:57 -0800 (PST)
Received: by mail-pf1-x449.google.com with SMTP id u3-20020a056a00124300b0056d4ab0c7cbso6602441pfi.7
        for <git@vger.kernel.org>; Mon, 13 Feb 2023 10:21:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=qiwvlTuxsldB+i5b7/28DCMT7O9vGrWnXDrnuVIGZz4=;
        b=YqM2KaRWghAIhGOO1kz5PmKuUAX+iM6kK5Gw4nvdtqgj4QNvi+TLehW60ywklNnjQ3
         gDty69iWCvx5rBqP7V27Mqfvyz9E9K22ncOFn6+ljCB3qvvbqZm+frzAloJdj5Rfa50q
         LYMHFW/AMJuPmqiJYF+sCIs3NXGVvpiq54pYTsJzfbwdwDi99tIpiLjhS/+v53xFcpCJ
         tdwaADcWXQlpU6Co8rIOPVxAALUWfqtVfo4sNAk/2oEwkH9vdo3qX5/deirlTOrSinp+
         Qnzahl5zWjZ2gweMVsppT3OZ3dpW6ooFt+wNh3aidh+c0eaSp+7iZPe5vQQcvlcAIJnc
         2JBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qiwvlTuxsldB+i5b7/28DCMT7O9vGrWnXDrnuVIGZz4=;
        b=tLeKCKW4RG8Ez3CzL4baIIbNdgbUQjIc69nztNQeLoFADIqJ4qIBpovNCNfHQwmwti
         uwLXjB6TcvY4hbF33F1KoNkDy1MihQMhbl2JoKOE25JL3xNwS7aqZceuFb/MgVdBORnT
         s9UtZ0Aam1y90yeuETKKSCGZDx02cOFgvXJRQR7I3BeX4D9xplVFeXLhcV8+jhIwHU2j
         Y5adSgMaU5F1/SV1raJkdAMDckgYDLQWPzbMCwNQTZkcm1aMGBTG8TU9COTRKnQIYJPw
         iCD17C+VnjixVLtOsKUTc8pEQ1VzLJ5FjMLTQI1/0Vhxns0ONpnHK3QI8NFz0N+7mY1o
         CvLQ==
X-Gm-Message-State: AO0yUKU0K8MhnFBE1dqR8gJOOs5N5+gYGwLT+vOzt1PTXqsbvFjHowQZ
        kgpqrYGTZnnCWj9Nu/U/tqehVasBLKz50L5FVhLaPABbTBE25mtBCbX2cfHVl/wu/U7/dM1AIon
        sdbPJYIDA+W9+2LE/dJ+uYVbQAcwYrzWrdGlE6J238HKYGD+kO7+z35VTrxIlzcpqNg==
X-Google-Smtp-Source: AK7set/dUg8eBVfgscikZyRosRSATGg8k3iBqkYo9p6TDLSls9X2L2/pBiTsl1wKxbWYPlve55s9in1HL6jf2QE=
X-Received: from barleywine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3bd4])
 (user=calvinwan job=sendgmr) by 2002:aa7:9551:0:b0:5a8:d638:584f with SMTP id
 w17-20020aa79551000000b005a8d638584fmr110858pfq.2.1676312516404; Mon, 13 Feb
 2023 10:21:56 -0800 (PST)
Date:   Mon, 13 Feb 2023 18:21:29 +0000
In-Reply-To: <20230213182134.2173280-1-calvinwan@google.com>
Mime-Version: 1.0
References: <20230213182134.2173280-1-calvinwan@google.com>
X-Mailer: git-send-email 2.39.1.581.gbfd45094c4-goog
Message-ID: <20230213182134.2173280-2-calvinwan@google.com>
Subject: [RFC PATCH 1/6] leak fix: cache_put_path
From:   Calvin Wan <calvinwan@google.com>
To:     git@vger.kernel.org
Cc:     Calvin Wan <calvinwan@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

hashmap_put returns a pointer if the key was found and subsequently
replaced. Free this pointer so it isn't leaked.

Signed-off-by: Calvin Wan <calvinwan@google.com>
---
 submodule-config.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/submodule-config.c b/submodule-config.c
index 4dc61b3a78..90cab34568 100644
--- a/submodule-config.c
+++ b/submodule-config.c
@@ -128,9 +128,11 @@ static void cache_put_path(struct submodule_cache *cache,
 	unsigned int hash = hash_oid_string(&submodule->gitmodules_oid,
 					    submodule->path);
 	struct submodule_entry *e = xmalloc(sizeof(*e));
+	struct hashmap_entry *replaced;
 	hashmap_entry_init(&e->ent, hash);
 	e->config = submodule;
-	hashmap_put(&cache->for_path, &e->ent);
+	replaced = hashmap_put(&cache->for_path, &e->ent);
+	free(replaced);
 }
 
 static void cache_remove_path(struct submodule_cache *cache,
-- 
2.39.1.581.gbfd45094c4-goog

