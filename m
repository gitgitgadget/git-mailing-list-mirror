Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C655C433EF
	for <git@archiver.kernel.org>; Fri, 27 May 2022 21:09:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347937AbiE0VJo (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 May 2022 17:09:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242658AbiE0VJb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 May 2022 17:09:31 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 580A2132A14
        for <git@vger.kernel.org>; Fri, 27 May 2022 14:09:29 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id k5so1132789wrd.5
        for <git@vger.kernel.org>; Fri, 27 May 2022 14:09:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=hutjqO2Dgq5cUHiwKBTEfuYuwznC5/mL1yUVQ8ypFSs=;
        b=KD33z9roJ1FhhV4D/hcgc3hMkZhl2CvF9H1fvkXu/350ZjOeIghe2Z5y0JPV9Txa7Q
         5P3p1hqFRNSTLGkOu9WTXIFTBvjmnTguYtSe0yt58FbnhVzNM7HMZb6bJ8DJ91mxSfmI
         JKZhIbWQ7+BX4bNMDBucD5pmyaF37nNCRYudowWyua187fhf0/ZJbK4ETzcr7Gva4nR4
         1fDBtaHLhyRgHlxHsFHMwy8Ft+pbwkaT8Tb9I9eLog7MDetN83DObLxt2ySu76pxwbWg
         0zyf8Gr+YdWTBBVn+4IwlX8w6hY1F/VQc9fY7S659oL1Vaz9rW+AMOY+DTN7Z1ncJhSn
         zt7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=hutjqO2Dgq5cUHiwKBTEfuYuwznC5/mL1yUVQ8ypFSs=;
        b=nLQ39lX6DSNFkgsP9QCJ4Ouw5/IsY9cMGT5qqA5WQbsE1lqhb/Cuvn19FuWnRaDHa1
         9k5TSELwRKuH/UKImnQxqjwPVj4sB3p9FSgfQahhMd672UrXzWy/Mo2r+Bcr2htca8Wb
         E2iXQv21B9WUagI8terIpi/2UQ61LmOXXtVca4Dco76QoV+G2+/0kDLgysXjZ1ClkG6R
         6FfrPZfHZhICLldZzSAPGlxL4jR0emk4KkP0sBvbDPSioaq6CELFjA+C+072kpMgMtIb
         9xD1IFEdpdHD3dsH6kKJDY0swbj0X2SU7VNgdx+Klwl6Dw6twn25xZiGbbuZBn/NQdUw
         B5hg==
X-Gm-Message-State: AOAM531ixHaEeNip1oNWDiwoT6/01x7QYI+RPPBKJprTXlKY0gazj0/R
        b3O1ydkKT94bK8YBzLV6NpoqROrjJl0=
X-Google-Smtp-Source: ABdhPJzI90ekOsKS8sXogeRJPwEa1E1M4G8+pRLZM4C5RLrXL+DELMNuh7Ev4wWei9VVG6yoQPOd7w==
X-Received: by 2002:a5d:6da3:0:b0:20e:67a2:6779 with SMTP id u3-20020a5d6da3000000b0020e67a26779mr35964019wrs.418.1653685767503;
        Fri, 27 May 2022 14:09:27 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 128-20020a1c1986000000b003972c672859sm3126459wmz.21.2022.05.27.14.09.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 May 2022 14:09:26 -0700 (PDT)
Message-Id: <d5a3e9f98450a0d602cf21790b988c1259a3466d.1653685761.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1261.v3.git.git.1653685761.gitgitgadget@gmail.com>
References: <pull.1261.v2.git.git.1652485058.gitgitgadget@gmail.com>
        <pull.1261.v3.git.git.1653685761.gitgitgadget@gmail.com>
From:   "Glen Choo via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 27 May 2022 21:09:19 +0000
Subject: [PATCH v3 3/5] setup.c: create `discovery.bare`
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

There is a known social engineering attack that takes advantage of the
fact that a working tree can include an entire bare repository,
including a config file. A user could run a Git command inside the bare
repository thinking that the config file of the 'outer' repository would
be used, but in reality, the bare repository's config file (which is
attacker-controlled) is used, which may result in arbitrary code
execution. See [1] for a fuller description and deeper discussion.

A simple mitigation is to forbid bare repositories unless specified via
`--git-dir` or `GIT_DIR`. In environments that don't use bare
repositories, this would be minimally disruptive.

Create a config variable, `discovery.bare`, that tells Git whether or
not to die() when it discovers a bare repository. This only affects
repository discovery, thus it has no effect if discovery was not
done (e.g. `--git-dir` was passed).

This config is an enum of:

- "always": always allow bare repositories (this is the default)
- "never": never allow bare repositories

If we want to protect users from such attacks by default, neither value
will suffice - "always" provides no protection, but "never" is
impractical for bare repository users. A more usable default would be to
allow only non-embedded bare repositories ([2] contains one such
proposal), but detecting if a repository is embedded is potentially
non-trivial, so this work is not implemented in this series.

[1]: https://lore.kernel.org/git/kl6lsfqpygsj.fsf@chooglen-macbookpro.roam.corp.google.com
[2]: https://lore.kernel.org/git/5b969c5e-e802-c447-ad25-6acc0b784582@github.com

Signed-off-by: Glen Choo <chooglen@google.com>
---
 Documentation/config.txt           |  2 +
 Documentation/config/discovery.txt | 19 +++++++++
 setup.c                            | 66 +++++++++++++++++++++++++++++-
 t/t0035-discovery-bare.sh          | 64 +++++++++++++++++++++++++++++
 4 files changed, 150 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/config/discovery.txt
 create mode 100755 t/t0035-discovery-bare.sh

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 07832de1a6c..34133288d75 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -415,6 +415,8 @@ include::config/diff.txt[]
 
 include::config/difftool.txt[]
 
+include::config/discovery.txt[]
+
 include::config/extensions.txt[]
 
 include::config/fastimport.txt[]
diff --git a/Documentation/config/discovery.txt b/Documentation/config/discovery.txt
new file mode 100644
index 00000000000..fbe93597e7c
--- /dev/null
+++ b/Documentation/config/discovery.txt
@@ -0,0 +1,19 @@
+discovery.bare::
+	'(Protected config only)' Specifies whether Git will work with a
+	bare repository that it found during repository discovery. This
+	has no effect if the repository is specified directly via the
+	--git-dir command-line option or the GIT_DIR environment
+	variable (see linkgit:git[1]).
++
+The currently supported values are:
++
+* `always`: Git always works with bare repositories
+* `never`: Git never works with bare repositories
++
+This defaults to `always`, but this default may change in the future.
++
+If you do not use bare repositories in your workflow, then it may be
+beneficial to set `discovery.bare` to `never` in your global config.
+This will protect you from attacks that involve cloning a repository
+that contains a bare repository and running a Git command within that
+directory.
diff --git a/setup.c b/setup.c
index 847d47f9195..6686743ab7d 100644
--- a/setup.c
+++ b/setup.c
@@ -10,6 +10,13 @@
 static int inside_git_dir = -1;
 static int inside_work_tree = -1;
 static int work_tree_config_is_bogus;
+enum discovery_bare_config {
+	DISCOVERY_BARE_UNKNOWN = -1,
+	DISCOVERY_BARE_NEVER = 0,
+	DISCOVERY_BARE_ALWAYS,
+};
+static enum discovery_bare_config discovery_bare_config =
+	DISCOVERY_BARE_UNKNOWN;
 
 static struct startup_info the_startup_info;
 struct startup_info *startup_info = &the_startup_info;
@@ -1133,6 +1140,52 @@ static int ensure_valid_ownership(const char *path)
 	return data.is_safe;
 }
 
+static int discovery_bare_cb(const char *key, const char *value, void *d)
+{
+	if (strcmp(key, "discovery.bare"))
+		return 0;
+
+	if (!strcmp(value, "never")) {
+		discovery_bare_config = DISCOVERY_BARE_NEVER;
+		return 0;
+	}
+	if (!strcmp(value, "always")) {
+		discovery_bare_config = DISCOVERY_BARE_ALWAYS;
+		return 0;
+	}
+	return -1;
+}
+
+static int check_bare_repo_allowed(void)
+{
+	if (discovery_bare_config == DISCOVERY_BARE_UNKNOWN) {
+		discovery_bare_config = DISCOVERY_BARE_ALWAYS;
+		git_protected_config(discovery_bare_cb, NULL);
+	}
+	switch (discovery_bare_config) {
+	case DISCOVERY_BARE_NEVER:
+		return 0;
+	case DISCOVERY_BARE_ALWAYS:
+		return 1;
+	case DISCOVERY_BARE_UNKNOWN:
+		BUG("invalid discovery_bare_config %d", discovery_bare_config);
+	}
+	return 0;
+}
+
+static const char *discovery_bare_config_to_string(void)
+{
+	switch (discovery_bare_config) {
+	case DISCOVERY_BARE_NEVER:
+		return "never";
+	case DISCOVERY_BARE_ALWAYS:
+		return "always";
+	case DISCOVERY_BARE_UNKNOWN:
+		BUG("invalid discovery_bare_config %d", discovery_bare_config);
+	}
+	return NULL;
+}
+
 enum discovery_result {
 	GIT_DIR_NONE = 0,
 	GIT_DIR_EXPLICIT,
@@ -1142,7 +1195,8 @@ enum discovery_result {
 	GIT_DIR_HIT_CEILING = -1,
 	GIT_DIR_HIT_MOUNT_POINT = -2,
 	GIT_DIR_INVALID_GITFILE = -3,
-	GIT_DIR_INVALID_OWNERSHIP = -4
+	GIT_DIR_INVALID_OWNERSHIP = -4,
+	GIT_DIR_DISALLOWED_BARE = -5,
 };
 
 /*
@@ -1239,6 +1293,8 @@ static enum discovery_result setup_git_directory_gently_1(struct strbuf *dir,
 		}
 
 		if (is_git_directory(dir->buf)) {
+			if (!check_bare_repo_allowed())
+				return GIT_DIR_DISALLOWED_BARE;
 			if (!ensure_valid_ownership(dir->buf))
 				return GIT_DIR_INVALID_OWNERSHIP;
 			strbuf_addstr(gitdir, ".");
@@ -1385,6 +1441,14 @@ const char *setup_git_directory_gently(int *nongit_ok)
 		}
 		*nongit_ok = 1;
 		break;
+	case GIT_DIR_DISALLOWED_BARE:
+		if (!nongit_ok) {
+			die(_("cannot use bare repository '%s' (discovery.bare is '%s')"),
+			    dir.buf,
+			    discovery_bare_config_to_string());
+		}
+		*nongit_ok = 1;
+		break;
 	case GIT_DIR_NONE:
 		/*
 		 * As a safeguard against setup_git_directory_gently_1 returning
diff --git a/t/t0035-discovery-bare.sh b/t/t0035-discovery-bare.sh
new file mode 100755
index 00000000000..94c2f76d774
--- /dev/null
+++ b/t/t0035-discovery-bare.sh
@@ -0,0 +1,64 @@
+#!/bin/sh
+
+test_description='verify discovery.bare checks'
+
+. ./test-lib.sh
+
+pwd="$(pwd)"
+
+expect_rejected () {
+	test_must_fail git rev-parse --git-dir 2>err &&
+	grep "discovery.bare" err
+}
+
+test_expect_success 'setup bare repo in worktree' '
+	git init outer-repo &&
+	git init --bare outer-repo/bare-repo
+'
+
+test_expect_success 'discovery.bare unset' '
+	(
+		cd outer-repo/bare-repo &&
+		git rev-parse --git-dir
+	)
+'
+
+test_expect_success 'discovery.bare=always' '
+	git config --global discovery.bare always &&
+	(
+		cd outer-repo/bare-repo &&
+		git rev-parse --git-dir
+	)
+'
+
+test_expect_success 'discovery.bare=never' '
+	git config --global discovery.bare never &&
+	(
+		cd outer-repo/bare-repo &&
+		expect_rejected
+	)
+'
+
+test_expect_success 'discovery.bare in the repository' '
+	(
+		cd outer-repo/bare-repo &&
+		# Temporarily set discovery.bare=always, otherwise git
+		# config fails with "fatal: not in a git directory"
+		# (like safe.directory)
+		git config --global discovery.bare always &&
+		git config discovery.bare always &&
+		git config --global discovery.bare never &&
+		expect_rejected
+	)
+'
+
+test_expect_success 'discovery.bare on the command line' '
+	git config --global discovery.bare never &&
+	(
+		cd outer-repo/bare-repo &&
+		test_must_fail git -c discovery.bare=always rev-parse --git-dir 2>err &&
+		grep "discovery.bare" err
+	)
+'
+
+test_done
-- 
gitgitgadget

