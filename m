Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6494C43219
	for <git@archiver.kernel.org>; Fri,  4 Mar 2022 18:33:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241745AbiCDSds (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Mar 2022 13:33:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241731AbiCDSdj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Mar 2022 13:33:39 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAED84A3C9
        for <git@vger.kernel.org>; Fri,  4 Mar 2022 10:32:37 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id n33-20020a05600c3ba100b003832caf7f3aso4400465wms.0
        for <git@vger.kernel.org>; Fri, 04 Mar 2022 10:32:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lfiTc0eZSBfsbMOse4DFVbrZ/fI5b+Aw1x1MWDNSQY0=;
        b=ajtUFWZCX7SlQaq4Hx149YeerhTODNYJvh/acRDyWjbbiRDHEsCsrmnoXeBDElpdGD
         qF79WOz0NHUbXYOIVZh0pS9VrHhBc3Cu116CnJ3Pr71vPOkavQRMwXVZ+RdnZ/vWG/rX
         pSVjONNbu3ln5GiKBnr+/UI7gk+n392LEgnv6EmY6Sr7HMis/5vzLt1g68SRsev3UdP2
         756zRE8D3Wylnii2u0RDC8vpoy74icvoBRcmEx2zDIt2otcKxr6zMjk0FfB3mvdtygOQ
         TdBRhEr3Nk5Ndc8PEwBqM+zXtDJXB5C4Vaj+jTiWYPHqEImnp77dIGqqTe6j9LDPYfNq
         MMBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lfiTc0eZSBfsbMOse4DFVbrZ/fI5b+Aw1x1MWDNSQY0=;
        b=sYK5TEd4d4Nt3kN0/3oxeoPSh/95XnBqVvAVwPyJToy+mLcDymh06Bj2WUKKOKM8yB
         YSlX7+eri5px2QKUmDOB5uh1+DfdrBR6NUMRckP+BUbmuhzzpMwU1tJxtJ0kBxUK9OAM
         p7I5WztEDzVpLq013WoI5ZMzUIHl0UA1X+ApWUoVhe0HAMLJtsPOwR9RcAEW9hB9orll
         7xZSgBoq77ijA9LN+pd0UKYLDbwzsxs1ArNyChNnvPD9/pIAXDQC0smfTipOdU7W+CQg
         +EDLDoEFznYKa+8PikuFnNTdIzYTVdaE9oTrHmZ6/MxejlE1a/S8c1ePevEyWAlhawZz
         7/6g==
X-Gm-Message-State: AOAM532PfgN9gIImHhfTLYc0AvUJ4EhP0F7+ETAX9MdpGyZJ4KSoPX8K
        PIRz1UzvQBu3f4wl9ON2UBYGr9EJSho3tQ==
X-Google-Smtp-Source: ABdhPJyDmLCF0RrCwLxYKyMu46Uyy8amf1VJTKMcVD1zYaIpqqBVe3TI9VbT8X7ZdQ93yq1WxMgIbg==
X-Received: by 2002:a05:600c:6014:b0:381:832b:95a4 with SMTP id az20-20020a05600c601400b00381832b95a4mr8826519wmb.1.1646418755435;
        Fri, 04 Mar 2022 10:32:35 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id 11-20020a05600c22cb00b00382a960b17csm10573990wmg.7.2022.03.04.10.32.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Mar 2022 10:32:34 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 14/14] repository.c: free the "path cache" in repo_clear()
Date:   Fri,  4 Mar 2022 19:32:17 +0100
Message-Id: <patch-v2-14.14-d70a4394f2b-20220304T182902Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1248.gb68c9165ad8
In-Reply-To: <cover-v2-00.14-00000000000-20220304T182902Z-avarab@gmail.com>
References: <cover-00.14-00000000000-20220302T170718Z-avarab@gmail.com> <cover-v2-00.14-00000000000-20220304T182902Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The "struct path_cache" added in 102de880d24 (path.c: migrate global
git_path_* to take a repository argument, 2018-05-17) is only used
directly by code in repository.[ch] (but populated in path.[ch]).

Let's move this code to repository.[ch], and stop leaking this memory
when we run repo_clear(). To avoid the cast change it from a "const
char *" to a "char *".

This also removes the "PATH_CACHE_INIT" macro, which has never been
used for anything. For the "struct repository" we already make a hard
assumption that it (and "the_repository") can be identically
initialized by making it a "static" variable, so making use of a
"PATH_CACHE_INIT" somewhere would have been confusing.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 path.h       | 14 --------------
 repository.c | 16 ++++++++++++++++
 repository.h | 14 +++++++++++++-
 3 files changed, 29 insertions(+), 15 deletions(-)

diff --git a/path.h b/path.h
index b68691a86b8..0a59c85a62e 100644
--- a/path.h
+++ b/path.h
@@ -169,20 +169,6 @@ void report_linked_checkout_garbage(void);
 		return r->cached_paths.var; \
 	}
 
-struct path_cache {
-	const char *squash_msg;
-	const char *merge_msg;
-	const char *merge_rr;
-	const char *merge_mode;
-	const char *merge_head;
-	const char *merge_autostash;
-	const char *auto_merge;
-	const char *fetch_head;
-	const char *shallow;
-};
-
-#define PATH_CACHE_INIT { 0 }
-
 const char *git_path_squash_msg(struct repository *r);
 const char *git_path_merge_msg(struct repository *r);
 const char *git_path_merge_rr(struct repository *r);
diff --git a/repository.c b/repository.c
index 34610c5a33e..9b86f3f1214 100644
--- a/repository.c
+++ b/repository.c
@@ -240,6 +240,20 @@ int repo_submodule_init(struct repository *subrepo,
 	return ret;
 }
 
+static void repo_clear_path_cache(struct repo_path_cache *cache)
+{
+	FREE_AND_NULL(cache->squash_msg);
+	FREE_AND_NULL(cache->squash_msg);
+	FREE_AND_NULL(cache->merge_msg);
+	FREE_AND_NULL(cache->merge_rr);
+	FREE_AND_NULL(cache->merge_mode);
+	FREE_AND_NULL(cache->merge_head);
+	FREE_AND_NULL(cache->merge_autostash);
+	FREE_AND_NULL(cache->auto_merge);
+	FREE_AND_NULL(cache->fetch_head);
+	FREE_AND_NULL(cache->shallow);
+}
+
 void repo_clear(struct repository *repo)
 {
 	FREE_AND_NULL(repo->gitdir);
@@ -280,6 +294,8 @@ void repo_clear(struct repository *repo)
 		remote_state_clear(repo->remote_state);
 		FREE_AND_NULL(repo->remote_state);
 	}
+
+	repo_clear_path_cache(&repo->cached_paths);
 }
 
 int repo_read_index(struct repository *repo)
diff --git a/repository.h b/repository.h
index ca837cb9e91..e29f361703d 100644
--- a/repository.h
+++ b/repository.h
@@ -44,6 +44,18 @@ struct repo_settings {
 	int core_multi_pack_index;
 };
 
+struct repo_path_cache {
+	char *squash_msg;
+	char *merge_msg;
+	char *merge_rr;
+	char *merge_mode;
+	char *merge_head;
+	char *merge_autostash;
+	char *auto_merge;
+	char *fetch_head;
+	char *shallow;
+};
+
 struct repository {
 	/* Environment */
 	/*
@@ -82,7 +94,7 @@ struct repository {
 	/*
 	 * Contains path to often used file names.
 	 */
-	struct path_cache cached_paths;
+	struct repo_path_cache cached_paths;
 
 	/*
 	 * Path to the repository's graft file.
-- 
2.35.1.1248.gb68c9165ad8

