Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5E4CC1F404
	for <e@80x24.org>; Wed, 28 Mar 2018 22:35:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753856AbeC1Wfv (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Mar 2018 18:35:51 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:33514 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753627AbeC1Wfm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Mar 2018 18:35:42 -0400
Received: by mail-pg0-f68.google.com with SMTP id i194so1748942pgd.0
        for <git@vger.kernel.org>; Wed, 28 Mar 2018 15:35:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=l/FRD0MP0HyhmuBcz9xXgZ7j3slWgsNuTjQy/h/w8pU=;
        b=qJHTJNLiAjZSOoMZdjyTELtYd8aAxeu0b891I9oMfETKvC088dRJvtSYoUrGJLzYVZ
         o5GHVlhweBA5EJgjrhCW7coKNCFfaupIOY1HnitccR9UjygvDF7Kl7SSOzLv0BuSvmq3
         VqDCdcXztDkzxRRs82gKIM4HiTDr9eUEyJib3xOEFZAuQYK3p8vMqKWOA05UOdj/6lkq
         m3H/ym5H7vxiXXrTZxJH1DpgR5tcAtY0jSIlqV464kcEs5440m6cJEVDhCIL844Hd/Db
         xDdPU+JFjzhvsyi9trQ/h+CTEDwezATh2teHen3Pzr4t9wvGZ5Q7qfVfXnuV30Cqul8r
         +owQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=l/FRD0MP0HyhmuBcz9xXgZ7j3slWgsNuTjQy/h/w8pU=;
        b=hCDJsZaNnT5y4ZoJj8kpcrG34xKWvuK2p7pC+lIDPrUmLKS5Rc3ayddK5OqIuZg019
         6VSfDlk2nfYv7bd6z/DE/wIwZy5Lq79kpJHvwzYDSTaUbohpauCzUAriaRlppdgesr2O
         8/q5pL6Y1EDdnMSlajYEbbJCp1NXPX5KRJHnRsG5g1+mSdFegKkEoA/dKrvenjLgd2m/
         tjLtGazFCDDjsyPyZ+xq8uyCXtas9SVV/T8sRaL4y85bMTlMN6J1pSqracELh5LbQ8Bb
         OJVjC9NztOv6irJ0UZ0PMyqsbcsLG0X7uj924aBnLmyUD11rr6j1f8Rq7SkxWbeX9qYZ
         yskw==
X-Gm-Message-State: AElRT7G6bbxRdeB0lM6l+L4Ko1EIfrwALVO1gutSr7IiohEIsbEuIbFF
        VwNhP2RSZ3UZ/oJuplYxc9sjHA==
X-Google-Smtp-Source: AIpwx48MTVbuLki+OMfd7BZU1XWk5/L6PLpn5HIoYUY+PnauTHkNERIY1t4M9d06Bp1Cgd16WxaKDg==
X-Received: by 10.98.49.135 with SMTP id x129mr4330580pfx.75.1522276541922;
        Wed, 28 Mar 2018 15:35:41 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id l80sm11055220pfk.73.2018.03.28.15.35.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 28 Mar 2018 15:35:41 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     jonathantanmy@google.com
Cc:     bmwill@google.com, git@vger.kernel.org, gitster@pobox.com,
        hvoigt@hvoigt.net, sbeller@google.com, seanwbehan@riseup.net
Subject: [PATCHv3 5/6] submodule-config: remove submodule_from_cache
Date:   Wed, 28 Mar 2018 15:35:30 -0700
Message-Id: <20180328223531.241920-6-sbeller@google.com>
X-Mailer: git-send-email 2.17.0.rc1.321.gba9d0f2565-goog
In-Reply-To: <20180328223531.241920-1-sbeller@google.com>
References: <20180328105416.3add54858bac92573d7d1130@google.com>
 <20180328223531.241920-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This continues the story of bf12fcdf5e (submodule-config: store
the_submodule_cache in the_repository, 2017-06-22).

The previous patch taught submodule_from_path to take a repository into
account, such that submodule_from_{path, cache} are the same now.
Remove submodule_from_cache, migrating all its callers to
submodule_from_path.

Reviewed-by: Jonathan Tan <jonathantanmy@google.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---
 repository.c       | 2 +-
 submodule-config.c | 9 ---------
 submodule-config.h | 3 ---
 submodule.c        | 4 ++--
 4 files changed, 3 insertions(+), 15 deletions(-)

diff --git a/repository.c b/repository.c
index a4848c1bd0..eb5b8e9f5a 100644
--- a/repository.c
+++ b/repository.c
@@ -176,7 +176,7 @@ int repo_submodule_init(struct repository *submodule,
 	struct strbuf worktree = STRBUF_INIT;
 	int ret = 0;
 
-	sub = submodule_from_cache(superproject, &null_oid, path);
+	sub = submodule_from_path(superproject, &null_oid, path);
 	if (!sub) {
 		ret = -1;
 		goto out;
diff --git a/submodule-config.c b/submodule-config.c
index 0ea1e927d2..9abe9166d5 100644
--- a/submodule-config.c
+++ b/submodule-config.c
@@ -635,15 +635,6 @@ const struct submodule *submodule_from_path(struct repository *r,
 	return config_from(r->submodule_cache, treeish_name, path, lookup_path);
 }
 
-const struct submodule *submodule_from_cache(struct repository *repo,
-					     const struct object_id *treeish_name,
-					     const char *key)
-{
-	gitmodules_read_check(repo);
-	return config_from(repo->submodule_cache, treeish_name,
-			   key, lookup_path);
-}
-
 void submodule_free(struct repository *r)
 {
 	if (r->submodule_cache)
diff --git a/submodule-config.h b/submodule-config.h
index 43dfe7dec0..6f686184e8 100644
--- a/submodule-config.h
+++ b/submodule-config.h
@@ -45,9 +45,6 @@ const struct submodule *submodule_from_name(struct repository *r,
 const struct submodule *submodule_from_path(struct repository *r,
 					    const struct object_id *commit_or_tree,
 					    const char *path);
-extern const struct submodule *submodule_from_cache(struct repository *repo,
-						    const struct object_id *treeish_name,
-						    const char *key);
 void submodule_free(struct repository *r);
 
 #endif /* SUBMODULE_CONFIG_H */
diff --git a/submodule.c b/submodule.c
index 9279cff2d7..dac73d10a7 100644
--- a/submodule.c
+++ b/submodule.c
@@ -231,7 +231,7 @@ int is_submodule_active(struct repository *repo, const char *path)
 	const struct string_list *sl;
 	const struct submodule *module;
 
-	module = submodule_from_cache(repo, &null_oid, path);
+	module = submodule_from_path(repo, &null_oid, path);
 
 	/* early return if there isn't a path->module mapping */
 	if (!module)
@@ -1236,7 +1236,7 @@ static int get_next_submodule(struct child_process *cp,
 		if (!S_ISGITLINK(ce->ce_mode))
 			continue;
 
-		submodule = submodule_from_cache(spf->r, &null_oid, ce->name);
+		submodule = submodule_from_path(spf->r, &null_oid, ce->name);
 		if (!submodule) {
 			const char *name = default_name_or_path(ce->name);
 			if (name) {
-- 
2.17.0.rc1.321.gba9d0f2565-goog

