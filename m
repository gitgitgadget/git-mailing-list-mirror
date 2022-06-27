Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBD4CC433EF
	for <git@archiver.kernel.org>; Mon, 27 Jun 2022 18:38:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237481AbiF0Sii (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Jun 2022 14:38:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240496AbiF0SiM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Jun 2022 14:38:12 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96ABCCE2
        for <git@vger.kernel.org>; Mon, 27 Jun 2022 11:36:43 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id c130-20020a1c3588000000b0039c6fd897b4so8024747wma.4
        for <git@vger.kernel.org>; Mon, 27 Jun 2022 11:36:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=YqoyexvLeD9VobWvJz7mGg0G5uZtp4Fx9wNnc+nZhXg=;
        b=FgzdqgcOSh4Lwr7B1tIlF45bUdJ7zRf56DWZU5m6rEQWk0OefOjbB387OaDjglPoux
         29VZXznGXTb9y7uaEuA6hTbhArwVFpOSc0TsB8+tTmGX0vIFc0RRy1yLGnYFflI6NIEr
         BTIkpbz/a+Gn5dZ/8cTG1wAHfHdhGgitgZuo4F7NQ/+g+nMNW5vIeEBiyApfxmPszoP/
         wrCfuyawrcBdzLhO9PYKXRJBlZNi4zoEAQBZ5Cn7x1c2H2r0h3Uf8OGathHpGgw69SUS
         lIbbaWYpGOwGCjx86sj1YUJEMdNC/R0nqux6TDtXXQex5ao8/ZZUMHoCiJV24sDTVuhr
         8rYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=YqoyexvLeD9VobWvJz7mGg0G5uZtp4Fx9wNnc+nZhXg=;
        b=DrM+yjUDIroPIPWk/w6PbmOzo2HUTCU9+sF3vUU9/glco4d3YiSncKUnK8B6a7Yjig
         ltVDGSzjckpGhGmxWiN/vrtPpAXc7XrKC0AYEUaA8j7eBG0Odb6PHOG1sfRhi4bdaVgh
         PF0Q74BVG8I30Be1l57SCtPV+SRn2i77WNn0u4b4ioEMnij9gAPxYAduN56eU8kzw8vY
         j9SU082uvaEwKMjq6tW/HGRlFQXtCxtIIHHB/vgz3yWQmboMktLlNw3eKXuMWQYKTuD9
         JMS+sErNI/9GaYdAV35ucaiB3lWHcwAzPxInEPOaKkRtPXtIW37TbT8Sh2IeponkMZ/P
         7F4g==
X-Gm-Message-State: AJIora9nW4xxGzEQu82ZQ6HOXyDR01Vj/24lvGxsCsfaG2071nPQh2i3
        4sQiOdYZljRe6Y36rM95Gyd8VSVoiZlFew==
X-Google-Smtp-Source: AGRyM1vW0xTcl9Vtoe87iP/V+UKnmIvGdLLM0LD6c3DfA+ca0YyGSKpIXSJc37KEFJYhWg9+w7+lLg==
X-Received: by 2002:a7b:c110:0:b0:39c:8270:7b95 with SMTP id w16-20020a7bc110000000b0039c82707b95mr17094546wmi.41.1656355001749;
        Mon, 27 Jun 2022 11:36:41 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ay4-20020a05600c1e0400b003a047dccfffsm6667120wmb.42.2022.06.27.11.36.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 11:36:41 -0700 (PDT)
Message-Id: <14411512783fd4e2cdcc8513690377b29262f6b8.1656354994.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1261.v5.git.git.1656354994.gitgitgadget@gmail.com>
References: <pull.1261.v4.git.git.1654635432.gitgitgadget@gmail.com>
        <pull.1261.v5.git.git.1656354994.gitgitgadget@gmail.com>
From:   "Glen Choo via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 27 Jun 2022 18:36:34 +0000
Subject: [PATCH v5 5/5] setup.c: create `discovery.bare`
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
        Jonathan Tan <jonathantanmy@google.com>,
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
done, e.g. if the user passes `--git-dir=my-dir`, discovery will be
skipped and my-dir will be used as the repo regardless of the
`discovery.bare` value.

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
 Documentation/config/discovery.txt | 23 ++++++++++
 setup.c                            | 57 ++++++++++++++++++++++++-
 t/t0035-discovery-bare.sh          | 68 ++++++++++++++++++++++++++++++
 4 files changed, 149 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/config/discovery.txt
 create mode 100755 t/t0035-discovery-bare.sh

diff --git a/Documentation/config.txt b/Documentation/config.txt
index e284b042f22..9a5e1329772 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -409,6 +409,8 @@ include::config/diff.txt[]
 
 include::config/difftool.txt[]
 
+include::config/discovery.txt[]
+
 include::config/extensions.txt[]
 
 include::config/fastimport.txt[]
diff --git a/Documentation/config/discovery.txt b/Documentation/config/discovery.txt
new file mode 100644
index 00000000000..bbcf89bb0b5
--- /dev/null
+++ b/Documentation/config/discovery.txt
@@ -0,0 +1,23 @@
+discovery.bare::
+	Specifies whether Git will work with a bare repository that it
+	found during repository discovery. If the repository is
+	specified directly via the --git-dir command-line option or the
+	GIT_DIR environment variable (see linkgit:git[1]), Git will
+	always use the specified repository, regardless of this value.
++
+This config setting is only respected in protected configuration (see
+<<SCOPES>>). This prevents the untrusted repository from tampering with
+this value.
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
index c8e3c32814d..16938fd5a24 100644
--- a/setup.c
+++ b/setup.c
@@ -10,6 +10,10 @@
 static int inside_git_dir = -1;
 static int inside_work_tree = -1;
 static int work_tree_config_is_bogus;
+enum discovery_bare_allowed {
+	DISCOVERY_BARE_NEVER = 0,
+	DISCOVERY_BARE_ALWAYS,
+};
 
 static struct startup_info the_startup_info;
 struct startup_info *startup_info = &the_startup_info;
@@ -1142,6 +1146,46 @@ static int ensure_valid_ownership(const char *path)
 	return data.is_safe;
 }
 
+static int discovery_bare_cb(const char *key, const char *value, void *d)
+{
+	enum discovery_bare_allowed *discovery_bare_allowed = d;
+
+	if (strcmp(key, "discovery.bare"))
+		return 0;
+
+	if (!strcmp(value, "never")) {
+		*discovery_bare_allowed = DISCOVERY_BARE_NEVER;
+		return 0;
+	}
+	if (!strcmp(value, "always")) {
+		*discovery_bare_allowed = DISCOVERY_BARE_ALWAYS;
+		return 0;
+	}
+	return -1;
+}
+
+static enum discovery_bare_allowed get_discovery_bare(void)
+{
+	enum discovery_bare_allowed result = DISCOVERY_BARE_ALWAYS;
+	git_protected_config(discovery_bare_cb, &result);
+	return result;
+}
+
+static const char *discovery_bare_allowed_to_string(
+	enum discovery_bare_allowed discovery_bare_allowed)
+{
+	switch (discovery_bare_allowed) {
+	case DISCOVERY_BARE_NEVER:
+		return "never";
+	case DISCOVERY_BARE_ALWAYS:
+		return "always";
+	default:
+		BUG("invalid discovery_bare_allowed %d",
+		    discovery_bare_allowed);
+	}
+	return NULL;
+}
+
 enum discovery_result {
 	GIT_DIR_NONE = 0,
 	GIT_DIR_EXPLICIT,
@@ -1151,7 +1195,8 @@ enum discovery_result {
 	GIT_DIR_HIT_CEILING = -1,
 	GIT_DIR_HIT_MOUNT_POINT = -2,
 	GIT_DIR_INVALID_GITFILE = -3,
-	GIT_DIR_INVALID_OWNERSHIP = -4
+	GIT_DIR_INVALID_OWNERSHIP = -4,
+	GIT_DIR_DISALLOWED_BARE = -5,
 };
 
 /*
@@ -1248,6 +1293,8 @@ static enum discovery_result setup_git_directory_gently_1(struct strbuf *dir,
 		}
 
 		if (is_git_directory(dir->buf)) {
+			if (!get_discovery_bare())
+				return GIT_DIR_DISALLOWED_BARE;
 			if (!ensure_valid_ownership(dir->buf))
 				return GIT_DIR_INVALID_OWNERSHIP;
 			strbuf_addstr(gitdir, ".");
@@ -1394,6 +1441,14 @@ const char *setup_git_directory_gently(int *nongit_ok)
 		}
 		*nongit_ok = 1;
 		break;
+	case GIT_DIR_DISALLOWED_BARE:
+		if (!nongit_ok) {
+			die(_("cannot use bare repository '%s' (discovery.bare is '%s')"),
+			    dir.buf,
+			    discovery_bare_allowed_to_string(get_discovery_bare()));
+		}
+		*nongit_ok = 1;
+		break;
 	case GIT_DIR_NONE:
 		/*
 		 * As a safeguard against setup_git_directory_gently_1 returning
diff --git a/t/t0035-discovery-bare.sh b/t/t0035-discovery-bare.sh
new file mode 100755
index 00000000000..0b345d361e6
--- /dev/null
+++ b/t/t0035-discovery-bare.sh
@@ -0,0 +1,68 @@
+#!/bin/sh
+
+test_description='verify discovery.bare checks'
+
+. ./test-lib.sh
+
+pwd="$(pwd)"
+
+expect_accepted () {
+	git "$@" rev-parse --git-dir
+}
+
+expect_rejected () {
+	test_must_fail git "$@" rev-parse --git-dir 2>err &&
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
+		expect_accepted
+	)
+'
+
+test_expect_success 'discovery.bare=always' '
+	git config --global discovery.bare always &&
+	(
+		cd outer-repo/bare-repo &&
+		expect_accepted
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
+		expect_accepted -c discovery.bare=always &&
+		expect_rejected -c discovery.bare=
+	)
+'
+
+test_done
-- 
gitgitgadget
