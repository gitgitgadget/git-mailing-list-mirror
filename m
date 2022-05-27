Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29F53C433EF
	for <git@archiver.kernel.org>; Fri, 27 May 2022 21:09:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354701AbiE0VJq (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 May 2022 17:09:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354696AbiE0VJc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 May 2022 17:09:32 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 656AA1339FA
        for <git@vger.kernel.org>; Fri, 27 May 2022 14:09:30 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id f23-20020a7bcc17000000b003972dda143eso5258194wmh.3
        for <git@vger.kernel.org>; Fri, 27 May 2022 14:09:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Hw1LDv0GzA4OB1oJQkdVGfyx3ceT1MPERg3FQv07nqo=;
        b=DFlcyng7l4bb5yaGxg1K/9wZZAf0WCN/VF+r2eYZqI+YQ46fegtHcBXXPPnwh0OhL5
         Jv+myr2jW0oPkcgNnAV9+yNnO/U6dbANm2WzP/w1QK+EQ7GuyA6/KAz/WBbLZdajIhCI
         mdnYN8exyJ1FODLE8+pzMXMMpTu6m9Kzx65hYlQBjOUGMUh0ixT7x+25AA32nUZcmC2L
         KvCfrFNHzmcuy32ty44mbClk0W3oDSCg/E+383zlGS2miwp0rBpl2FUHFPK5NgGNfgWN
         OI3sJNDSnzM1Rz/OLhX9qPViQ6Gkv0XnvOleLtMYhLeblCRc15CO914m/6Y1HFA3JW8x
         Tn1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Hw1LDv0GzA4OB1oJQkdVGfyx3ceT1MPERg3FQv07nqo=;
        b=SL9imYB2OE9Vt9fyNpi4fyo5fYRiSE15hDhBkrnymV2lKDYCeE8OvaZi77QDCS6XZA
         z51ubQ0xrcY4+hc2kbsuqF4f3sWOdWOoQeLN7JGJuUaed3hHCV6cWWMIa62ZiVx8wWtk
         HK19+jTnk2T2CS9gFU0stsKiPQFE8yeCYDkA2Cgi6mWpcKUGut2aa7TPlDd0HUm5LqmK
         8AC5nhqOimcnB9dUcB61XSGR7KJrJI+NH2oG2OoLfwNVfiD7GNjnQnU7U4B05v0RB0b5
         BoQo93U9FuawSajzo0CTInrxl8hYIkqqb27zFWAzUsXFKnedHVBiyDVSNMbrzkzU0gGl
         yBRA==
X-Gm-Message-State: AOAM531yqJQetiwpaVnbKzSo/56T0kLZzlqmjqV0Az3IpYkew5kC+Qvn
        P5N1FIxyMaVYdvbhVFQIuVdNnqzkO0s=
X-Google-Smtp-Source: ABdhPJxiC2yX9neNIMSWDpRl0rBaDfajLdE0BBNZt4KOEw30FyblpWbn5D05iOY6jtcmbDtGvcCy/g==
X-Received: by 2002:a05:600c:34d1:b0:397:4c0d:598a with SMTP id d17-20020a05600c34d100b003974c0d598amr8563699wmq.36.1653685768631;
        Fri, 27 May 2022 14:09:28 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q62-20020a1c4341000000b003942a244f38sm2879618wma.17.2022.05.27.14.09.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 May 2022 14:09:28 -0700 (PDT)
Message-Id: <66a0a208176094415d7b0ae1f686bdd1638b8a8a.1653685761.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1261.v3.git.git.1653685761.gitgitgadget@gmail.com>
References: <pull.1261.v2.git.git.1652485058.gitgitgadget@gmail.com>
        <pull.1261.v3.git.git.1653685761.gitgitgadget@gmail.com>
From:   "Glen Choo via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 27 May 2022 21:09:20 +0000
Subject: [PATCH v3 4/5] config: include "-c" in protected config
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

Protected config should include the command line (aka "-c") because we
can be quite certain that this config is specified by the user.

Introduce a function, `git_configset_add_parameters()`, that adds "-c"
config to a config_set, and use it to add "-c" to protected config.

Signed-off-by: Glen Choo <chooglen@google.com>
---
 Documentation/config.txt           |  6 +++---
 Documentation/glossary-content.txt |  2 +-
 config.c                           |  6 ++++++
 config.h                           |  9 +++++++++
 t/t0033-safe-directory.sh          | 24 ++++++++++--------------
 t/t0035-discovery-bare.sh          |  3 +--
 6 files changed, 30 insertions(+), 20 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 34133288d75..f40a3e297ce 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -370,9 +370,9 @@ names do not conflict with those that are used by Git itself and
 other popular tools, and describe them in your documentation.
 
 Variables marked with '(Protected config only)' are only respected when
-they are specified in protected configuration. This includes global and
-system-level config, and excludes repository config, the command line
-option `-c`, and environment variables. For more details, see the
+they are specified in protected configuration. This includes global,
+system-level config, the command line option `-c`, and environment
+variables, and excludes repository config. For more details, see the
 'protected configuration' entry in linkgit:gitglossary[7].
 
 include::config/advice.txt[]
diff --git a/Documentation/glossary-content.txt b/Documentation/glossary-content.txt
index a669983abd6..4190c410a00 100644
--- a/Documentation/glossary-content.txt
+++ b/Documentation/glossary-content.txt
@@ -494,12 +494,12 @@ Protected configuration includes:
 - system-level config, e.g. `/etc/git/config`
 - global config, e.g. `$XDG_CONFIG_HOME/git/config` and
   `$HOME/.gitconfig`
+- the command line option `-c` and its equivalent environment variables
 +
 Protected configuration excludes:
 +
 - repository config, e.g. `$GIT_DIR/config` and
   `$GIT_DIR/config.worktree`
-- the command line option `-c` and its equivalent environment variables
 
 [[def_reachable]]reachable::
 	All of the ancestors of a given <<def_commit,commit>> are said to be
diff --git a/config.c b/config.c
index c30bb7c5d09..22192ca1d63 100644
--- a/config.c
+++ b/config.c
@@ -2373,6 +2373,11 @@ int git_configset_add_file(struct config_set *cs, const char *filename)
 	return git_config_from_file(config_set_callback, filename, cs);
 }
 
+int git_configset_add_parameters(struct config_set *cs)
+{
+	return git_config_from_parameters(config_set_callback, cs);
+}
+
 int git_configset_get_value(struct config_set *cs, const char *key, const char **value)
 {
 	const struct string_list *values = NULL;
@@ -2628,6 +2633,7 @@ static void read_protected_config(void)
 	git_configset_add_file(the_repository->protected_config, system_config);
 	git_configset_add_file(the_repository->protected_config, xdg_config);
 	git_configset_add_file(the_repository->protected_config, user_config);
+	git_configset_add_parameters(the_repository->protected_config);
 
 	free(system_config);
 	free(xdg_config);
diff --git a/config.h b/config.h
index 411965f52b5..e3ff1fcf683 100644
--- a/config.h
+++ b/config.h
@@ -446,6 +446,15 @@ void git_configset_init(struct config_set *cs);
  */
 int git_configset_add_file(struct config_set *cs, const char *filename);
 
+/**
+ * Parses command line options and environment variables, and adds the
+ * variable-value pairs to the `config_set`. Returns 0 on success, or -1
+ * if there is an error in parsing. The caller decides whether to free
+ * the incomplete configset or continue using it when the function
+ * returns -1.
+ */
+int git_configset_add_parameters(struct config_set *cs);
+
 /**
  * Finds and returns the value list, sorted in order of increasing priority
  * for the configuration variable `key` and config set `cs`. When the
diff --git a/t/t0033-safe-directory.sh b/t/t0033-safe-directory.sh
index 238b25f91a3..5a1cd0d0947 100755
--- a/t/t0033-safe-directory.sh
+++ b/t/t0033-safe-directory.sh
@@ -16,24 +16,20 @@ test_expect_success 'safe.directory is not set' '
 	expect_rejected_dir
 '
 
-test_expect_success 'ignoring safe.directory on the command line' '
-	test_must_fail git -c safe.directory="$(pwd)" status 2>err &&
-	grep "unsafe repository" err
+test_expect_success 'safe.directory on the command line' '
+	git -c safe.directory="$(pwd)" status
 '
 
-test_expect_success 'ignoring safe.directory in the environment' '
-	test_must_fail env GIT_CONFIG_COUNT=1 \
-		GIT_CONFIG_KEY_0="safe.directory" \
-		GIT_CONFIG_VALUE_0="$(pwd)" \
-		git status 2>err &&
-	grep "unsafe repository" err
+test_expect_success 'safe.directory in the environment' '
+	env GIT_CONFIG_COUNT=1 \
+	    GIT_CONFIG_KEY_0="safe.directory" \
+	    GIT_CONFIG_VALUE_0="$(pwd)" \
+	    git status
 '
 
-test_expect_success 'ignoring safe.directory in GIT_CONFIG_PARAMETERS' '
-	test_must_fail env \
-		GIT_CONFIG_PARAMETERS="${SQ}safe.directory${SQ}=${SQ}$(pwd)${SQ}" \
-		git status 2>err &&
-	grep "unsafe repository" err
+test_expect_success 'safe.directory in GIT_CONFIG_PARAMETERS' '
+	env GIT_CONFIG_PARAMETERS="${SQ}safe.directory${SQ}=${SQ}$(pwd)${SQ}" \
+	    git status
 '
 
 test_expect_success 'ignoring safe.directory in repo config' '
diff --git a/t/t0035-discovery-bare.sh b/t/t0035-discovery-bare.sh
index 94c2f76d774..0d5983df307 100755
--- a/t/t0035-discovery-bare.sh
+++ b/t/t0035-discovery-bare.sh
@@ -56,8 +56,7 @@ test_expect_success 'discovery.bare on the command line' '
 	git config --global discovery.bare never &&
 	(
 		cd outer-repo/bare-repo &&
-		test_must_fail git -c discovery.bare=always rev-parse --git-dir 2>err &&
-		grep "discovery.bare" err
+		git -c discovery.bare=always rev-parse --git-dir
 	)
 '
 
-- 
gitgitgadget

