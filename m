Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15A78C00140
	for <git@archiver.kernel.org>; Fri,  5 Aug 2022 17:59:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241608AbiHER70 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Aug 2022 13:59:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241574AbiHER7D (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Aug 2022 13:59:03 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DC8917E06
        for <git@vger.kernel.org>; Fri,  5 Aug 2022 10:59:00 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id b6so1726057wmq.5
        for <git@vger.kernel.org>; Fri, 05 Aug 2022 10:59:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc;
        bh=zxp1MOA1q3xkKIfmLh9FWxzW54spxCGbySUFWMwS8Do=;
        b=J+UsVMKq7kNYJvwG9Psda/SOfq6YRA9nX5HLWAyhaAot2Ly4xeqNGNRCx1BGgdYvYr
         MwBjQ4HouZuHTRhFTsG0U0FeVpbBrnKPzJvyL5J7JnvraWq/JEqhERZiLazRRmY/7ifo
         cmmxiThrNSXLpBR7Hw98xBkA5T43QlhbQmueGx+evXjQ7uCdxYlgx0K7SP7YEMkBC3ch
         Q564LyE9KFFQY3Ovat8bocUoVzwwCMrmzu71821diXyzCYJLkifsNlrIkOokOW3pcnV8
         l1PL2WYDDgx+YfAaBHvPKTD/OjHAPYDa0ATndOzjVUhX7kWpF82Yn9WLICjw22oUsxBb
         U7Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc;
        bh=zxp1MOA1q3xkKIfmLh9FWxzW54spxCGbySUFWMwS8Do=;
        b=NCNRhK34q5YVP7bcSd0BuWum2yWXReY4/UH2yep4bWftlaxl8IaimoD+kXzrJJ+3dZ
         Meoj/S8fDizOpmivnuCiRBfLS9eQisAA4xtChFOyGu2US86ea65usfTcxqvV59T1zjoS
         6Ir2yADktu8UM5S7RmMczgjKPuiKwzoYsoQPv5TjlgPHfMC6IrVXTtmhfd/ZTspmGIrF
         DjW49sya9Qrv4XQtzAPPNQ/hdX4KytzCWLsic/0CTmiT+lNX3d3hAREXulL1uW4ALXJ9
         t/5DNQLwmSFcNM6+SYLnN5pKH1oppRFSpP1mqGQMFDdeM4RghKDOoV5Ps7icHaQqvGUF
         GfRQ==
X-Gm-Message-State: ACgBeo3N6eXAREg4ZGXJBIQizyynTFpIT0cYgqfYh9ylA5kRXd2B249Q
        hCsqQmBGFWMvPIKDueiBmGqLbPvoDYM=
X-Google-Smtp-Source: AA6agR4Od5yECT05L3sks6iAKyQHaVuiZQEQVr8PTSTDB39YAws078xmKU7nD46jrW1BwgywbIbDGQ==
X-Received: by 2002:a05:600c:34c9:b0:3a4:f1d7:edbd with SMTP id d9-20020a05600c34c900b003a4f1d7edbdmr10133129wmq.128.1659722338615;
        Fri, 05 Aug 2022 10:58:58 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id bv20-20020a0560001f1400b0021d6d18a9f8sm4481784wrb.76.2022.08.05.10.58.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Aug 2022 10:58:57 -0700 (PDT)
Message-Id: <063e5bac2ce0bbe08ce71ba5012c4f7c447e0d4e.1659722324.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1301.v3.git.1659722323.gitgitgadget@gmail.com>
References: <pull.1301.v2.git.1659122979.gitgitgadget@gmail.com>
        <pull.1301.v3.git.1659722323.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 05 Aug 2022 17:58:38 +0000
Subject: [PATCH v3 06/11] log-tree: use ref_namespaces instead of if/else-if
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, me@ttaylorr.com, vdye@github.com,
        steadmon@google.com,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

The add_ref_decoration() method uses an if/else-if chain to determine if
a ref matches a known ref namespace that has a special decoration
category. That decoration type is later used to assign a color when
writing to stdout.

The newly-added ref_namespaces array contains all namespaces, along
with information about their decoration type. Check this array instead
of this if/else-if chain. This reduces our dependency on string literals
being embedded in the decoration logic.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 log-tree.c | 26 ++++++++++++++++----------
 1 file changed, 16 insertions(+), 10 deletions(-)

diff --git a/log-tree.c b/log-tree.c
index 1b2c76c5bb9..bb6cbceee63 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -137,6 +137,7 @@ static int ref_filter_match(const char *refname,
 static int add_ref_decoration(const char *refname, const struct object_id *oid,
 			      int flags, void *cb_data)
 {
+	int i;
 	struct object *obj;
 	enum object_type objtype;
 	enum decoration_type deco_type = DECORATION_NONE;
@@ -166,16 +167,21 @@ static int add_ref_decoration(const char *refname, const struct object_id *oid,
 		return 0;
 	obj = lookup_object_by_type(the_repository, oid, objtype);
 
-	if (starts_with(refname, "refs/heads/"))
-		deco_type = DECORATION_REF_LOCAL;
-	else if (starts_with(refname, "refs/remotes/"))
-		deco_type = DECORATION_REF_REMOTE;
-	else if (starts_with(refname, "refs/tags/"))
-		deco_type = DECORATION_REF_TAG;
-	else if (!strcmp(refname, "refs/stash"))
-		deco_type = DECORATION_REF_STASH;
-	else if (!strcmp(refname, "HEAD"))
-		deco_type = DECORATION_REF_HEAD;
+	for (i = 0; i < ARRAY_SIZE(ref_namespace); i++) {
+		struct ref_namespace_info *info = &ref_namespace[i];
+
+		if (!info->decoration)
+			continue;
+		if (info->exact) {
+			if (!strcmp(refname, info->ref)) {
+				deco_type = info->decoration;
+				break;
+			}
+		} else if (starts_with(refname, info->ref)) {
+			deco_type = info->decoration;
+			break;
+		}
+	}
 
 	add_name_decoration(deco_type, refname, obj);
 	while (obj->type == OBJ_TAG) {
-- 
gitgitgadget

