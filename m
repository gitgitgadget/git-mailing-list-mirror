Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	UNWANTED_LANGUAGE_BODY shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CB5631F403
	for <e@80x24.org>; Wed,  6 Jun 2018 17:03:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932319AbeFFRDb (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Jun 2018 13:03:31 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:36561 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933788AbeFFRDS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Jun 2018 13:03:18 -0400
Received: by mail-lf0-f68.google.com with SMTP id u4-v6so10241517lff.3
        for <git@vger.kernel.org>; Wed, 06 Jun 2018 10:03:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xCHRlEMIveaxtFSjXRbEmGEg7F72VZ7FSgC/Er0Mdxc=;
        b=LIn7lWDEyNSsryAnIRPWWweGpmsrml6U6HCk2h/vciwBtNvhW4IbpRJd2XUILTIIs3
         Pr7KXa+A6LHQYy5+L3mBR+wsA5CKfJgBX1Manf/JFfqYv3AtAjQx1seMNoHDtwe+F8zi
         rKbhAdj7TNgHCQpf1C7GGFNJd8QrJxyRB5yGZBP+V0yTKYVT98wmoHAAmDK5I2ALteGG
         zKxsaHXySJxcp7Lth8lt5UnpS3L+iMtqMandJTitRzrjDwRxYE7yx58V/fmjnOJvarFn
         cI6kKbRl0otCDc7xWxVwz+xSCWK07mtqaeVxDNgOzXMuymZ+V0mNwYyrpDj/t5MpWG51
         sdyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xCHRlEMIveaxtFSjXRbEmGEg7F72VZ7FSgC/Er0Mdxc=;
        b=nZxdYsiCQ3RaCetUnX90oO1DPR+oldzh4guqH3l3E5I+bodxB5Zcv5o1ZKOp3ewWaB
         Rj08mLp3k4x1MZIEHvCKwKH3dIBeCojoxinvqjMEuImXIsI5RkOxt5601rprC7L8u/Hk
         dGn3UDDCjYjPr6XEqYI56Spgpc/WJlYesuYfkrlRwgwp5wId8XBZ1h26w3R1HYsFBOt1
         5Wlzb0DN72LsUIscV0o5rvYTlYGXNCK1WK7pcfU4KsjoFvSR5nIasoJcByeAn5cEXR9D
         E23cBERDoLvsmO7hcfLxqoIl8caJ2qoVF2dgpnC09tz2QV0oJ8iFedhgq6lTYHnDmXSZ
         uNCg==
X-Gm-Message-State: APt69E2BGGJ67i0Fx1ueE1s0nzLUibPcxA7ZRB7QWyqcsnXtincTe8Tz
        vDYqKl3MiHGYBPdXocRvEy4=
X-Google-Smtp-Source: ADUXVKIp/xE35hwmEj5wWMG7MKCrJoOUoyb3SPobxNO7KjbzMEVNufH9WMK3ufozGxKUgpTMhoWOsA==
X-Received: by 2002:a19:1f51:: with SMTP id f78-v6mr2526961lff.42.1528304596844;
        Wed, 06 Jun 2018 10:03:16 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id g14-v6sm1485305lfb.36.2018.06.06.10.03.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Jun 2018 10:03:16 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     bmwill@google.com, git@vger.kernel.org, newren@gmail.com,
        ramsay@ramsayjones.plus.com
Subject: [PATCH v4 21/23] resolve-undo.c: use the right index instead of the_index
Date:   Wed,  6 Jun 2018 19:02:41 +0200
Message-Id: <20180606170243.4169-16-pclouds@gmail.com>
X-Mailer: git-send-email 2.18.0.rc0.333.g22e6ee6cdf
In-Reply-To: <20180606170243.4169-1-pclouds@gmail.com>
References: <20180606165016.3285-1-pclouds@gmail.com>
 <20180606170243.4169-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 resolve-undo.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/resolve-undo.c b/resolve-undo.c
index 383231b011..2377995d6d 100644
--- a/resolve-undo.c
+++ b/resolve-undo.c
@@ -1,3 +1,4 @@
+#define NO_THE_INDEX_COMPATIBILITY_MACROS
 #include "cache.h"
 #include "dir.h"
 #include "resolve-undo.h"
@@ -146,7 +147,7 @@ int unmerge_index_entry_at(struct index_state *istate, int pos)
 		struct cache_entry *nce;
 		if (!ru->mode[i])
 			continue;
-		nce = make_index_entry(&the_index, ru->mode[i], ru->oid[i].hash,
+		nce = make_index_entry(istate, ru->mode[i], ru->oid[i].hash,
 				       name, i + 1, 0);
 		if (matched)
 			nce->ce_flags |= CE_MATCHED;
@@ -186,7 +187,7 @@ void unmerge_index(struct index_state *istate, const struct pathspec *pathspec)
 
 	for (i = 0; i < istate->cache_nr; i++) {
 		const struct cache_entry *ce = istate->cache[i];
-		if (!ce_path_match(&the_index, ce, pathspec, NULL))
+		if (!ce_path_match(istate, ce, pathspec, NULL))
 			continue;
 		i = unmerge_index_entry_at(istate, i);
 	}
-- 
2.18.0.rc0.333.g22e6ee6cdf

