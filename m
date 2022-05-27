Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90EC4C433FE
	for <git@archiver.kernel.org>; Fri, 27 May 2022 21:09:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354697AbiE0VJc (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 May 2022 17:09:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351476AbiE0VJ3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 May 2022 17:09:29 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBF5D1269B9
        for <git@vger.kernel.org>; Fri, 27 May 2022 14:09:27 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id n124-20020a1c2782000000b003972dfca96cso3391282wmn.4
        for <git@vger.kernel.org>; Fri, 27 May 2022 14:09:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=vyWCBPY9wgVNipCFxb7f47vQ1iJ3QXZEZYyXxib4ai8=;
        b=hO6d6rLzQI/xgIya94xlviO0LS4P4d25e00M3/jxVUI5y4VQ3djHuwZIcrnlD4jV2G
         PV2e9SaPfUQf0h9R7r0hdbzFflAgmeOhRfkljnaGaiZN0m3FtoFBfQ6gjmOT3/QuUkjY
         pkWn2/mbuMLQOMbafggoFkWksEMTNl2j1S7YwJsn4YMqhEZoShTiEA5AU+1iBS3yjGr3
         IeAnMgubkDYsB89Up6UR+Dwd4NkwUDdvPF8I2pnhlKsL9oSnoHHxaqsAwik3RGCG3jmf
         B/bUxuruWrAkAkAW0EWeYhhcSIWhbdGRU011LiWA/aDRJA7ORDrGl+9GQOWFKbCjij6b
         Khtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=vyWCBPY9wgVNipCFxb7f47vQ1iJ3QXZEZYyXxib4ai8=;
        b=3A0YnjuNm8D7vT2oRJfYlEHYybxAwZesgVsK3aBGZA5kjx50uoWZvYPYTPJCCW9Mnf
         YgMt7t2G5jBdNkUbxK+Kx6nfaV2yqy9U1Gm7jtp5mhIsJk8xjalODCJ+KwWfoeP8tFL0
         LTnlUgcuNuiswPjeE8FkFddRJ0QZxf5jHD1iHILvmtBPrTqWb4VfdIsxS49t7C1fZ++/
         tk/3lnN8t7TEM91WKOnsdjSt4bQwmGj0QLLBYJwuW7B8Z+LyYDuow2WSCDNL/Rfa6YDF
         /8GboHGUltI6RbY/lDLZz8QMTXYXssI68hMeVnVDecBhNn3wza0BzP30ZOWyDPrbvdSj
         b/Tw==
X-Gm-Message-State: AOAM530j5Ti+c4ZpMjsTxvIAPrUp9ErvtIlgoaMpipR7CVUmibaWI5QK
        P06Y+yuNLzy2hSkP58VaF04cMHDWQwo=
X-Google-Smtp-Source: ABdhPJw31Tdk02cyznOstNz16MRCki0gDXud+14sOm4QwJRCtwrpDSK3QRSc58QBciH02mzQ8Fh57g==
X-Received: by 2002:a05:600c:4fd6:b0:394:55ae:32c7 with SMTP id o22-20020a05600c4fd600b0039455ae32c7mr8619383wmq.73.1653685766136;
        Fri, 27 May 2022 14:09:26 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q4-20020adfea04000000b0020d0c48d135sm2622868wrm.15.2022.05.27.14.09.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 May 2022 14:09:25 -0700 (PDT)
Message-Id: <7499a2809615d42eaf3649e1c33f38d099d27c1a.1653685761.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1261.v3.git.git.1653685761.gitgitgadget@gmail.com>
References: <pull.1261.v2.git.git.1652485058.gitgitgadget@gmail.com>
        <pull.1261.v3.git.git.1653685761.gitgitgadget@gmail.com>
From:   "Glen Choo via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 27 May 2022 21:09:18 +0000
Subject: [PATCH v3 2/5] config: read protected config with
 `git_protected_config()`
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Derrick Stolee <derrickstolee@github.com>,
        Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Glen Choo <chooglen@google.com>,
        Glen Choo <chooglen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Glen Choo <chooglen@google.com>

Protected config is read using `read_very_early_config()`, which has
several downsides:

- Every call to `read_very_early_config()` parses global and
  system-level config files anew, but this can be optimized by just
  parsing them once [1].
- Protected variables should respect "-c" because we can reasonably
  assume that it comes from the user. But, `read_very_early_config()`
  can't use "-c" because it is called so early that it does not have
  access to command line arguments.

Introduce `git_protected_config()`, which reads protected config and
caches the values in `the_repository.protected_config`. Then, refactor
`safe.directory` to use `git_protected_config()`.

This implementation can still be improved, however:

- `git_protected_config()` iterates through every variable in
  `the_repository.protected_config`, which may still be too expensive to
  be called in every "git" invocation. There exist constant time lookup
  functions for non-protected config (repo_config_get_*()), but for
  simplicity, this commit does not implement similar functions for
  protected config.

- Protected config is stored in `the_repository` so that we don't need
  to statically allocate it. But this might be confusing since protected
  config ignores repository config by definition.

[1] While `git_protected_config()` should save on file I/O, I wasn't
able to measure a meaningful difference between that and
`read_very_early_config()` on my machine (which has an SSD).

Signed-off-by: Glen Choo <chooglen@google.com>
---
 config.c     | 35 +++++++++++++++++++++++++++++++++++
 config.h     |  8 ++++++++
 repository.c |  5 +++++
 repository.h |  8 ++++++++
 setup.c      |  2 +-
 5 files changed, 57 insertions(+), 1 deletion(-)

diff --git a/config.c b/config.c
index fa471dbdb89..c30bb7c5d09 100644
--- a/config.c
+++ b/config.c
@@ -2614,6 +2614,41 @@ int repo_config_get_pathname(struct repository *repo,
 	return ret;
 }
 
+/* Read protected config into the_repository->protected_config. */
+static void read_protected_config(void)
+{
+	char *xdg_config = NULL, *user_config = NULL, *system_config = NULL;
+
+	CALLOC_ARRAY(the_repository->protected_config, 1);
+	git_configset_init(the_repository->protected_config);
+
+	system_config = git_system_config();
+	git_global_config(&user_config, &xdg_config);
+
+	git_configset_add_file(the_repository->protected_config, system_config);
+	git_configset_add_file(the_repository->protected_config, xdg_config);
+	git_configset_add_file(the_repository->protected_config, user_config);
+
+	free(system_config);
+	free(xdg_config);
+	free(user_config);
+}
+
+/* Ensure that the_repository->protected_config has been initialized. */
+static void git_protected_config_check_init(void)
+{
+	if (the_repository->protected_config &&
+	    the_repository->protected_config->hash_initialized)
+		return;
+	read_protected_config();
+}
+
+void git_protected_config(config_fn_t fn, void *data)
+{
+	git_protected_config_check_init();
+	configset_iter(the_repository->protected_config, fn, data);
+}
+
 /* Functions used historically to read configuration from 'the_repository' */
 void git_config(config_fn_t fn, void *data)
 {
diff --git a/config.h b/config.h
index 7654f61c634..411965f52b5 100644
--- a/config.h
+++ b/config.h
@@ -505,6 +505,14 @@ int repo_config_get_maybe_bool(struct repository *repo,
 int repo_config_get_pathname(struct repository *repo,
 			     const char *key, const char **dest);
 
+/*
+ * Functions for reading protected config. By definition, protected
+ * config ignores repository config, so it is unnecessary to read
+ * protected config from any `struct repository` other than
+ * the_repository.
+ */
+void git_protected_config(config_fn_t fn, void *data);
+
 /**
  * Querying For Specific Variables
  * -------------------------------
diff --git a/repository.c b/repository.c
index 5d166b692c8..ec319a5e09a 100644
--- a/repository.c
+++ b/repository.c
@@ -295,6 +295,11 @@ void repo_clear(struct repository *repo)
 		FREE_AND_NULL(repo->remote_state);
 	}
 
+	if (repo->protected_config) {
+		git_configset_clear(repo->protected_config);
+		FREE_AND_NULL(repo->protected_config);
+	}
+
 	repo_clear_path_cache(&repo->cached_paths);
 }
 
diff --git a/repository.h b/repository.h
index 6cc661e5a43..24251aac553 100644
--- a/repository.h
+++ b/repository.h
@@ -126,6 +126,14 @@ struct repository {
 
 	struct repo_settings settings;
 
+	/*
+	 * Config that comes from trusted sources, namely
+	 * - system config files (e.g. /etc/gitconfig)
+	 * - global config files (e.g. $HOME/.gitconfig,
+	 *   $XDG_CONFIG_HOME/git)
+	 */
+	struct config_set *protected_config;
+
 	/* Subsystems */
 	/*
 	 * Repository's config which contains key-value pairs from the usual
diff --git a/setup.c b/setup.c
index f818dd858c6..847d47f9195 100644
--- a/setup.c
+++ b/setup.c
@@ -1128,7 +1128,7 @@ static int ensure_valid_ownership(const char *path)
 	    is_path_owned_by_current_user(path))
 		return 1;
 
-	read_very_early_config(safe_directory_cb, &data);
+	git_protected_config(safe_directory_cb, &data);
 
 	return data.is_safe;
 }
-- 
gitgitgadget

