Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BD4861F453
	for <e@80x24.org>; Sun, 17 Feb 2019 10:10:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728225AbfBQKKV (ORCPT <rfc822;e@80x24.org>);
        Sun, 17 Feb 2019 05:10:21 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:37264 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726638AbfBQKKV (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 Feb 2019 05:10:21 -0500
Received: by mail-pl1-f193.google.com with SMTP id b5so7276516plr.4
        for <git@vger.kernel.org>; Sun, 17 Feb 2019 02:10:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SF2bQITIKETKEi+osCSBBq4tQ78G+/StqoIK0Lq86Io=;
        b=QqXG5owy2eKlo4frLq2fTvqwTgL4I2JrpI1323opSdJ9JYuQ5+cgz/amsWx8ZOfPvi
         vG+vvw+Q4+LHc2ezthj34k2I/cpdzg+6r3GC5xavNvCM3Qu+BQXfGa9O2G2pWmAjfEuG
         aJQ7vRJoDvRcghe954k5jGYIaGIB03x1teT/KqkCrj95Qpa2N9QHEIBNzVOqoJhfxm/V
         QExq9Ia1F/OOnHPi3uNjz8v66wPwCtqZmKbg9vO56KesR8Zh6zTPMmdevW+Dvq+XKqbZ
         aYUHCY007KdshovTu3dFsiHJ9U+72RySUoLbGU71q5iWYQ6pauNfspAq4OM67GkioY3x
         wNaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SF2bQITIKETKEi+osCSBBq4tQ78G+/StqoIK0Lq86Io=;
        b=eLxg54Q7/dbgRsT6ttn4JoLjZxdd8aWHGNL++aoZplZcs5lU7wtagTyGExfigg5ysu
         NYiFn6zTbAWMgxIJF1Nne2cZZDedq6aA+DRVMVSw0VvsZqVowKNkG6ESogRNdLaV70gg
         36hxdt8PzEvZzYI+nNRRUZ7ocHcFnQ6/NyFbmQTr/HxnE/5vwly0hvkLWk2Xnwf5IK27
         Agzn1Yvrgvp7P7OhTjgFlhxX1aEY+TbHUD3/B4T9XfnVF13UQzsHD+5iOpe89jrDnpzp
         RFYd/V7osrlvoQNLfrTdehDFDM/7nO2MIxzpR1u0mYgg9AomF39ZNuBn51MMbU+FqYeu
         xMKw==
X-Gm-Message-State: AHQUAuYOsK75K07v3SazGPR6Hs67NAlejUkVNdbbu8ZJZRSswmzIxhom
        LSt8u5h40nVKV5V9oAQLH+uGFqvY
X-Google-Smtp-Source: AHgI3Ib2d8/fPKKXlxxxDNZJ/5P4ZppefzeQbxMfeE5r7dEecjuM7d1t8u3H22qB8+srwCPdp2Xaug==
X-Received: by 2002:a17:902:780a:: with SMTP id p10mr19845581pll.54.1550398220740;
        Sun, 17 Feb 2019 02:10:20 -0800 (PST)
Received: from ash ([115.72.21.220])
        by smtp.gmail.com with ESMTPSA id d26sm13465279pfn.12.2019.02.17.02.10.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Feb 2019 02:10:20 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Sun, 17 Feb 2019 17:10:16 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 14/31] sha1-name.c: add repo_for_each_abbrev()
Date:   Sun, 17 Feb 2019 17:08:56 +0700
Message-Id: <20190217100913.4127-15-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.rc0.328.g0e39304f8d
In-Reply-To: <20190217100913.4127-1-pclouds@gmail.com>
References: <20190217100913.4127-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 cache.h     | 3 ++-
 sha1-name.c | 5 +++--
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/cache.h b/cache.h
index 524a44110a..92973e7ae0 100644
--- a/cache.h
+++ b/cache.h
@@ -1366,7 +1366,8 @@ extern enum get_oid_result get_oid_with_context(struct repository *repo, const c
 				struct object_context *oc);
 
 typedef int each_abbrev_fn(const struct object_id *oid, void *);
-extern int for_each_abbrev(const char *prefix, each_abbrev_fn, void *);
+int repo_for_each_abbrev(struct repository *r, const char *prefix, each_abbrev_fn, void *);
+#define for_each_abbrev(prefix, fn, data) repo_for_each_abbrev(the_repository, prefix, fn, data)
 
 extern int set_disambiguate_hint_config(const char *var, const char *value);
 
diff --git a/sha1-name.c b/sha1-name.c
index a75992eb54..cdcf84b826 100644
--- a/sha1-name.c
+++ b/sha1-name.c
@@ -493,13 +493,14 @@ static enum get_oid_result get_short_oid(const char *name, int len,
 	return status;
 }
 
-int for_each_abbrev(const char *prefix, each_abbrev_fn fn, void *cb_data)
+int repo_for_each_abbrev(struct repository *r, const char *prefix,
+			 each_abbrev_fn fn, void *cb_data)
 {
 	struct oid_array collect = OID_ARRAY_INIT;
 	struct disambiguate_state ds;
 	int ret;
 
-	if (init_object_disambiguation(the_repository, prefix, strlen(prefix), &ds) < 0)
+	if (init_object_disambiguation(r, prefix, strlen(prefix), &ds) < 0)
 		return -1;
 
 	ds.always_call_fn = 1;
-- 
2.21.0.rc0.328.g0e39304f8d

