Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E22EC202DA
	for <e@80x24.org>; Tue,  7 Mar 2017 14:33:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932611AbdCGOdg (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 Mar 2017 09:33:36 -0500
Received: from mout.gmx.net ([212.227.17.22]:60297 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755646AbdCGOdX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Mar 2017 09:33:23 -0500
Received: from virtualbox ([37.201.194.72]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MEKZg-1cVvA43utU-00FSo9; Tue, 07
 Mar 2017 15:33:09 +0100
Date:   Tue, 7 Mar 2017 15:33:07 +0100 (CET)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Duy Nguyen <pclouds@gmail.com>
Subject: [PATCH v4 06/10] Make read_early_config() reusable
In-Reply-To: <cover.1488897111.git.johannes.schindelin@gmx.de>
Message-ID: <7377f3f8c2c0c008dbff6b08603b91593ac9cc79.1488897111.git.johannes.schindelin@gmx.de>
References: <cover.1488562287.git.johannes.schindelin@gmx.de> <cover.1488897111.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:tAVIy+sR31qQ137DzJhn1fsjA7HhjMU/pfc9BVLLmVqSThd3x+3
 2SB4qMMYKvV8D5xcuzp7ylGdGH60D5TFTP82DFjigmrxDGH39EawVE2E1ZTNqKWzx+qUR4W
 qUGjRC3fyFcTxIHcJMTya9EkBEKPLVNyhYQWW76k4+3S4sbmetxBcEdICJoHMgXuSo6U4iR
 okhcR3mH1/LQ/bIOlD+hA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ICe423mGyaY=:q66nvQji/EdkpJph8lPLJh
 9ej5c4XhEmEhlERbLq2mPX+LrYRSKnoe8t1L6NZw3uWI+kaaKPQmY3wggIAz30rR7qTRVTksQ
 BSjYGVJeQJChlE7O136pzVhsO7/5nszuyuIuyH0r/APbAADcnHn/wm+q6R+8++Q1bAgjRcMAt
 t4Uqsxb0XU2Z72IbXRIZF6X9bohuYVL6GX4p00/k/VrzEAefpfyw5xZKjKmHv6LECcI6qhZ7L
 wP/64DUYGVCSEMiZbWcb7MBfj2fHmeaM8RJNHsjjHQ93MbTN0YrPszgeXkU2D73wO0w9znYef
 txKxrnSh8ZvlfbJz17T94M6HN5H1EAE105Lyids3PHMP8KY32HxpY4BF/Mng3jgyUtJmQxgaB
 j6buCqTIvwN+0qxGBbnj81oUG6XjCNPv7Bhf1a0OuUM3B/ChSbxLRPxPZBel433WiA+3Vw5Fb
 Pu1t1jw0QJdV9rvXRoisuYCe127EUBN98aU9Ra04gM+MdOofDcNIGQJs0EZaDv4eT/S1pzY9P
 LW72hJN8o/zFENB6wvMNZ33b4RLHg4hWkrHU6aL8/n4fB3OKiIJkQ2rQWUI8a0aEZtVn3av0X
 vt1NwapMnwLYDIGXIyPA559CWUxzUzOwIXJFK293grkqlIJuXCUnveR+3znLUgAmw8mEdz6+A
 zLgFd+upkBYHVDvxdD8hMdTzxTwR5cPq4FroM/WH31KO96X6AtTL34XoH/mGMVwdOAm1izFeG
 mXu4DwxYf3ua71vyVcbjFogbpdqJWehUI8eO5Yg13JKSp9ulrL99HXwDA3xH0z1dvGrw6AFlT
 1hupfPo9Iw9AgSmFdm9xlnXAyOh5ShatfSEqGTJ0fDC3PW5I+fAx9jXXpMzwHZ/mL5UVyDwZc
 d38yK8Plv7Zg4cnpmwUoIr+kGKnWQHfqkH6L3zre7Diq1UjoLvONgb5sK94ZbpfSqCncugeuD
 NhvmwX+oYIIus12rZ1EeS4ga7mw5lM/3gh3WRkB+nQCDIFFHK8jcPNRSAP44Tf91lkqnuFKvj
 lqvbyj2EAF93+H2U6bQG/ua5gHu4YVogs6EM6qQVfzIB66DGTB/1WVQuGfBQ1H40/g==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The pager configuration needs to be read early, possibly before
discovering any .git/ directory.

Let's not hide this function in pager.c, but make it available to other
callers.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 cache.h  |  1 +
 config.c | 31 +++++++++++++++++++++++++++++++
 pager.c  | 31 -------------------------------
 3 files changed, 32 insertions(+), 31 deletions(-)

diff --git a/cache.h b/cache.h
index 5218726cf88..e7b57457e73 100644
--- a/cache.h
+++ b/cache.h
@@ -1804,6 +1804,7 @@ extern int git_config_from_blob_sha1(config_fn_t fn, const char *name,
 				     const unsigned char *sha1, void *data);
 extern void git_config_push_parameter(const char *text);
 extern int git_config_from_parameters(config_fn_t fn, void *data);
+extern void read_early_config(config_fn_t cb, void *data);
 extern void git_config(config_fn_t fn, void *);
 extern int git_config_with_options(config_fn_t fn, void *,
 				   struct git_config_source *config_source,
diff --git a/config.c b/config.c
index c6b874a7bf7..9cfbeafd04c 100644
--- a/config.c
+++ b/config.c
@@ -1412,6 +1412,37 @@ static void configset_iter(struct config_set *cs, config_fn_t fn, void *data)
 	}
 }
 
+void read_early_config(config_fn_t cb, void *data)
+{
+	git_config_with_options(cb, data, NULL, 1);
+
+	/*
+	 * Note that this is a really dirty hack that does the wrong thing in
+	 * many cases. The crux of the problem is that we cannot run
+	 * setup_git_directory() early on in git's setup, so we have no idea if
+	 * we are in a repository or not, and therefore are not sure whether
+	 * and how to read repository-local config.
+	 *
+	 * So if we _aren't_ in a repository (or we are but we would reject its
+	 * core.repositoryformatversion), we'll read whatever is in .git/config
+	 * blindly. Similarly, if we _are_ in a repository, but not at the
+	 * root, we'll fail to find .git/config (because it's really
+	 * ../.git/config, etc). See t7006 for a complete set of failures.
+	 *
+	 * However, we have historically provided this hack because it does
+	 * work some of the time (namely when you are at the top-level of a
+	 * valid repository), and would rarely make things worse (i.e., you do
+	 * not generally have a .git/config file sitting around).
+	 */
+	if (!startup_info->have_repository) {
+		struct git_config_source repo_config;
+
+		memset(&repo_config, 0, sizeof(repo_config));
+		repo_config.file = ".git/config";
+		git_config_with_options(cb, data, &repo_config, 1);
+	}
+}
+
 static void git_config_check_init(void);
 
 void git_config(config_fn_t fn, void *data)
diff --git a/pager.c b/pager.c
index ae796433630..73ca8bc3b17 100644
--- a/pager.c
+++ b/pager.c
@@ -43,37 +43,6 @@ static int core_pager_config(const char *var, const char *value, void *data)
 	return 0;
 }
 
-static void read_early_config(config_fn_t cb, void *data)
-{
-	git_config_with_options(cb, data, NULL, 1);
-
-	/*
-	 * Note that this is a really dirty hack that does the wrong thing in
-	 * many cases. The crux of the problem is that we cannot run
-	 * setup_git_directory() early on in git's setup, so we have no idea if
-	 * we are in a repository or not, and therefore are not sure whether
-	 * and how to read repository-local config.
-	 *
-	 * So if we _aren't_ in a repository (or we are but we would reject its
-	 * core.repositoryformatversion), we'll read whatever is in .git/config
-	 * blindly. Similarly, if we _are_ in a repository, but not at the
-	 * root, we'll fail to find .git/config (because it's really
-	 * ../.git/config, etc). See t7006 for a complete set of failures.
-	 *
-	 * However, we have historically provided this hack because it does
-	 * work some of the time (namely when you are at the top-level of a
-	 * valid repository), and would rarely make things worse (i.e., you do
-	 * not generally have a .git/config file sitting around).
-	 */
-	if (!startup_info->have_repository) {
-		struct git_config_source repo_config;
-
-		memset(&repo_config, 0, sizeof(repo_config));
-		repo_config.file = ".git/config";
-		git_config_with_options(cb, data, &repo_config, 1);
-	}
-}
-
 const char *git_pager(int stdout_is_tty)
 {
 	const char *pager;
-- 
2.12.0.windows.1.7.g94dafc3b124


