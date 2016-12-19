Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5E0561FF40
	for <e@80x24.org>; Mon, 19 Dec 2016 18:27:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1764002AbcLSS0m (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Dec 2016 13:26:42 -0500
Received: from mail-pg0-f53.google.com ([74.125.83.53]:34737 "EHLO
        mail-pg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1763948AbcLSSZr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Dec 2016 13:25:47 -0500
Received: by mail-pg0-f53.google.com with SMTP id y62so11404695pgy.1
        for <git@vger.kernel.org>; Mon, 19 Dec 2016 10:25:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=af5yxmu2qI3bLh/H/IxG+oNE7b4j1m+4SNKwbg4bDWk=;
        b=YtDr1NHlnMxR+5eRK7JiAc51XLVCf+HCb9wN9yMY8dECr032IOgyktQF+vI7fqJ3H1
         VCJOimmrUGG+UdZCgI59y3/KYygp0giOkK0yJTclEZ2QqfEz0ZnDyj4BXc3OM0zJGNz4
         mVQeRBN5ze/VCreWwKt2ydj2P8dI0lXhSjlhjAolpdTOYXK8g+A84K3zmvKTjRtgjez7
         EdG4JTcMxmEwSDUDf1xx5bxZf3vZ23WmvVytyqeeL2N8suJNRqpUoQ1aBzNl8pXA1d/3
         dndBCbJ7gIpLSC3T8VbnQ3k06RmG5Mgwf1TR4u5HduS4lnic0kQ2eP/Vqyggzp//PDSF
         auhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=af5yxmu2qI3bLh/H/IxG+oNE7b4j1m+4SNKwbg4bDWk=;
        b=nz3KtCD/Jy5l+gtxtuG5+0Nuo72iFLgix0FBJOy4vMsy6497/jtFStJck5o91zhqdf
         KI6bUyFqCuI1Agc6JEnF0wDbK4zN9LvEOHEJAcUoIHTeAi5lcXWJZShaIOhihrvYOAid
         QgvdTlaxG6Yj1nRfntzOx4SSotaalGGEun2/HP1xmlHtuA/auJUAb+rd1tiZQOujGeSE
         81a/P4VoZ5W1xNK9IvpbuPQDPT2muF8hViZZVG/DbvMZhuv9s8VyixMlDNHwrUKfbygC
         44g2izZ4EaWHJ+LWfhQ0gf+HTRtjZO4zfooBajdtMwTVccWehL1gaudOWn9jgjY0a7aR
         n3bw==
X-Gm-Message-State: AKaTC00I6pZqDypxfx/Zk6TaypvczNPbm9HPdNS/eZiqW1lklxNqmnhM0w6L9i6FP2kwzX9D
X-Received: by 10.84.215.138 with SMTP id l10mr37192659pli.166.1482171946515;
        Mon, 19 Dec 2016 10:25:46 -0800 (PST)
Received: from roshar.mtv.corp.google.com ([172.27.69.28])
        by smtp.gmail.com with ESMTPSA id x90sm33098745pfk.73.2016.12.19.10.25.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 19 Dec 2016 10:25:45 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, Brandon Williams <bmwill@google.com>
Subject: [PATCH 2/3] submodules: add RECURSE_SUBMODULES_ONLY value
Date:   Mon, 19 Dec 2016 10:25:32 -0800
Message-Id: <1482171933-180601-3-git-send-email-bmwill@google.com>
X-Mailer: git-send-email 2.8.0.rc3.226.g39d4020
In-Reply-To: <1482171933-180601-1-git-send-email-bmwill@google.com>
References: <1482171933-180601-1-git-send-email-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add the `RECURSE_SUBMODULES_ONLY` enum value to submodule.h.  This enum
value will be used in a later patch to push to indicate that only
submodules should be pushed, while the superproject should remain
unpushed.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 submodule-config.c | 2 ++
 submodule.h        | 1 +
 2 files changed, 3 insertions(+)

diff --git a/submodule-config.c b/submodule-config.c
index 098085b..33eb62d 100644
--- a/submodule-config.c
+++ b/submodule-config.c
@@ -251,6 +251,8 @@ static int parse_push_recurse(const char *opt, const char *arg,
 			return RECURSE_SUBMODULES_ON_DEMAND;
 		else if (!strcmp(arg, "check"))
 			return RECURSE_SUBMODULES_CHECK;
+		else if (!strcmp(arg, "only"))
+			return RECURSE_SUBMODULES_ONLY;
 		else if (die_on_error)
 			die("bad %s argument: %s", opt, arg);
 		else
diff --git a/submodule.h b/submodule.h
index 23d7668..4a83a4c 100644
--- a/submodule.h
+++ b/submodule.h
@@ -6,6 +6,7 @@ struct argv_array;
 struct sha1_array;
 
 enum {
+	RECURSE_SUBMODULES_ONLY = -5,
 	RECURSE_SUBMODULES_CHECK = -4,
 	RECURSE_SUBMODULES_ERROR = -3,
 	RECURSE_SUBMODULES_NONE = -2,
-- 
2.8.0.rc3.226.g39d4020

