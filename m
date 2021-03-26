Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9E25C433DB
	for <git@archiver.kernel.org>; Fri, 26 Mar 2021 02:41:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C273661A45
	for <git@archiver.kernel.org>; Fri, 26 Mar 2021 02:41:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230510AbhCZClV (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 25 Mar 2021 22:41:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230423AbhCZClC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Mar 2021 22:41:02 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53BA3C06174A
        for <git@vger.kernel.org>; Thu, 25 Mar 2021 19:41:02 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id z2so4202286wrl.5
        for <git@vger.kernel.org>; Thu, 25 Mar 2021 19:41:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jkDLve32JMC0r0BHgItMQAqLWUo+dvr45+IA4gmeZNs=;
        b=V0wBFgU72TebJ8lCYryX4W3Xt6qFSZFDntsWAv7D4DsTEHJ7nVdUmH3IaNEOb2fmd7
         WTex+fwjdbfQE7KGXzGWRaq2EJ5+avl59NTiihK7GCjV5dORxRHiqvVbj6P2cwWVvfU8
         gGANwQiisFZiCpLWRosBpfl5gWCF8J3QTqOZ/L726YZVIxbq0CJ7a1yxcr4LUaioPNdV
         eFP5WJtwclLjgFc/bUxNy48pflIKajP/AX1RDq/wRPoAA3XsQA1wqvW2Zvv4oSCkwkLZ
         JqcwtTYyNMvf1bLdW1D7AWi5NP1EiZzzOvehXw1OCUxfqVjP4127C62Y/MIP/Rjt0IRU
         Tw/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jkDLve32JMC0r0BHgItMQAqLWUo+dvr45+IA4gmeZNs=;
        b=kd50NGSFvuCBpbtytIH9eNZekxU6noTfME8Bx2WkQZlI5yk9Oc1E/rWiOS7KCdDV1j
         4nKBWn7O856bQO+dKqU835x+U6oYp4qDMojpiOQyF48jq7CTY0wNEWc1lZIUMTl6+0pn
         7jHVigkYpNtZ7VFxJMOxhu6ekc/4noDKQnFNFXtUKyT/OBmdew0dyFI/xmGQfbnljXRy
         5omSgdxr601LN5xRV56P3LFXVcQ1ruYYEpymEqW8jny9nZIZotWpbp/iz+g9b4rb6H+f
         rV+B3CZhSPl4FX3MoC92rW4/CQCsaHmIRvxwTISN2qbhnbuaR5WRCI13r/hOsKaB+lgH
         47DQ==
X-Gm-Message-State: AOAM531mPTfUJVsmeCnmzQ5Jvl30n4xmU6yeIek9TNJexd49XbddWjwV
        kwg89A0SOOGo1lF0Aw54nHGQSQOdZ2QA2P/789w=
X-Google-Smtp-Source: ABdhPJz1htPYigC5x8X3iWfEggydJTAp43CugUZSNj/3qgWZvMdMteEX5sX728h0k69XR1xdFOlq9g==
X-Received: by 2002:a05:6000:1b0f:: with SMTP id f15mr12134278wrz.171.1616726460732;
        Thu, 25 Mar 2021 19:41:00 -0700 (PDT)
Received: from localhost.localdomain ([2a02:85f:2a0a:9300:501f:ca6d:3b18:1e72])
        by smtp.googlemail.com with ESMTPSA id i10sm10020226wrs.11.2021.03.25.19.40.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Mar 2021 19:41:00 -0700 (PDT)
From:   "=?UTF-8?q?=CE=A3=CF=84=CE=B1=CF=8D=CF=81=CE=BF=CF=82=20=CE=9D=CF=84=CE=AD=CE=BD=CF=84=CE=BF=CF=82?=" 
        <stdedos@gmail.com>
X-Google-Original-From: =?UTF-8?q?=CE=A3=CF=84=CE=B1=CF=8D=CF=81=CE=BF=CF=82=20=CE=9D=CF=84=CE=AD=CE=BD=CF=84=CE=BF=CF=82?= <stdedos+git@gmail.com>
To:     git <git@vger.kernel.org>
Cc:     =?UTF-8?q?=CE=A3=CF=84=CE=B1=CF=8D=CF=81=CE=BF=CF=82=20=CE=9D=CF=84=CE=AD=CE=BD=CF=84=CE=BF=CF=82?= 
        <stdedos+git@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Stavros Ntentos <133706+stdedos@users.noreply.github.com>
Subject: [RFC PATCH v1 2/2] fixup! pathspec: warn: long and short forms are incompatible
Date:   Fri, 26 Mar 2021 04:40:05 +0200
Message-Id: <20210326024005.26962-3-stdedos+git@gmail.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210326024005.26962-1-stdedos+git@gmail.com>
References: <xmqqft1iquka.fsf@gitster.g>
 <20210326024005.26962-1-stdedos+git@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Stavros Ntentos <133706+stdedos@users.noreply.github.com>

malloc and stuff
---
 pathspec.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/pathspec.c b/pathspec.c
index 374c529569..4ac8bfdc06 100644
--- a/pathspec.c
+++ b/pathspec.c
@@ -7,6 +7,7 @@
 #include "attr.h"
 #include "strvec.h"
 #include "quote.h"
+#include "git-compat-util.h"
 
 /*
  * Finds which of the given pathspecs match items in the index.
@@ -745,16 +746,20 @@ int match_pathspec_attrs(const struct index_state *istate,
 }
 
 void check_mishandled_exclude(const char *entry) {
+	char *flags, *path;
 	size_t entry_len = strlen(entry);
-	char flags[entry_len];
-	char path[entry_len];
 
-	if (sscanf(entry, ":!(%4096[^)])%4096s", &flags, &path) != 2) {
-		return;
-	}
-	if (count_slashes(flags) > 0) {
-		return;
+	flags = xstrdup(entry);
+	memset(flags, '\0', entry_len);
+	path = xstrdup(entry);
+	memset(path, '\0', entry_len);
+
+	if (sscanf(entry, ":!(%4096[^)])%4096s", flags, path) == 2) {
+		if (count_slashes(flags) == 0) {
+			warning(_("Pathspec provided matches `:!(...)`\n\tDid you mean `:(exclude,...)`?"));
+		}
 	}
 
-	warning(_("Pathspec provided matches `:!(...)`\n\tDid you mean `:(exclude,...)`?"));
+	FREE_AND_NULL(flags);
+	FREE_AND_NULL(path);
 }
-- 
2.31.0

