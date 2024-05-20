Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CF8E136988
	for <git@vger.kernel.org>; Mon, 20 May 2024 20:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716236533; cv=none; b=k+uvDQjwjJr7pD/bHGFKrC2tVJVvMQr8sjkb8Bmno538prEJbQNbxGl1+Yza5hRXR+Gl9cf3UKnsHW5+rzdACMe+olV/chF+DZmfshhHEL90/bXb1jLMTFIPRVW5ZUEWWRvmSZ76sRxK/50yUmJJYNv7fMInr6EuzE2sy6o3BqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716236533; c=relaxed/simple;
	bh=bo+fPoWCnehDUdUXdCJ3d/mPRVM06KdgUy9DyEpb7q0=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=hlgE0fuJ2fBRYfyYG4eZ4GZPayCIp4SzvJJgl3HQYMCr3xodxzH75DimaGfwocrt5nbpkPOVS+6xrlzv+84VQx+gXT76CTLf3AJcqujJMBao3HmZzlDmcP4svrpo4FCgz2c1+K0QzAgG8nIChvoTG7c9s2a15/nsvPrTXgE7FIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bwg+rUbY; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bwg+rUbY"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-34d9c9f2cf0so2478882f8f.3
        for <git@vger.kernel.org>; Mon, 20 May 2024 13:22:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716236529; x=1716841329; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7GSAwyerxg+POObKWesOD9tLB/byCNUpF0P7PByr2gg=;
        b=Bwg+rUbYQV1lO3FYj319ZOjZw+arl2SnSPDlostZb7K0M6rN0Wv9wcRNp7zSP12bd2
         UaQIf6hYig0Vfd5b0aJhGDA4amqxK5vwJceZjbJi3aaIoVr3dNPbpfdIV1WvGs+QTmiw
         w1eyRoE/vlqoFk/4kD+XRx8y/pGCF1ITLNrfI0V5AybFKl0O1FTHMrp3VsbIVFqTvUH1
         Q+2fUTmqt5JoL9+4eRLww4tG2Uqse9czPVy+01PW7JsNSRALaRfQpiHwZLJsRwKXR/8c
         +L7hRBGkgWGRRsmIJODoJtV6utPbPE310/N1yq1VYcSZqbE1H6g/5BtQl/pkXFYQJLiB
         pFlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716236529; x=1716841329;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7GSAwyerxg+POObKWesOD9tLB/byCNUpF0P7PByr2gg=;
        b=aU2+D54Rmn47fCXgdsabzDUw7sxemGT/nvtbpPQVT7hpPADEzLxAW+EwMaV4qtJfUn
         NWP3UAt2ZMuY+wOxZAkfhn7AlJdwCSKhiBn94uwsLClsgqOUJOyI+SqDCVUzKq5ogieB
         9RuEdQCa/xAcsVUAWGe2IqTLcP/YMe0bsHbeFU6qROo5eBoeob21BIbqPR/fdxDq+2sl
         wwg6kCwMvkknCMQDD8NXu92sNw777WAT1yFRPBkbdyR1It0yl3B1eIG+2fND6Q2hxUhc
         VgeQeiKFL/dBYqmhrVcgqJbVXdM2n2C8m444bs+YWTsQ+KTR7P15n2YfXxITywbHYbmB
         ZV4Q==
X-Gm-Message-State: AOJu0YzA8z4qKITZo5SqaZ8HMSPmILk9A/vcPW3sdvFaPk0DdTzc945u
	8BnAnVaGC76wtdiG+h1mDb3HQzQdMzwCK0/lwmdnm7vuiSQNWoKtsty2iw==
X-Google-Smtp-Source: AGHT+IFgEltHQah0AXbTWPN7cMsfSbcyHwXTXfj1XoNBuhfym5cuQuj6YLTuIvGABaZL5LNMnJFXUA==
X-Received: by 2002:a05:600c:4f04:b0:420:1508:f0ae with SMTP id 5b1f17b1804b1-4201508f2edmr240314465e9.10.1716236528863;
        Mon, 20 May 2024 13:22:08 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42014c21260sm320572705e9.3.2024.05.20.13.22.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 May 2024 13:22:08 -0700 (PDT)
Message-Id: <pull.1732.v3.git.1716236526.gitgitgadget@gmail.com>
In-Reply-To: <pull.1732.v2.git.1716028366.gitgitgadget@gmail.com>
References: <pull.1732.v2.git.1716028366.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 20 May 2024 20:21:59 +0000
Subject: [PATCH v3 0/6] Various fixes for v2.45.1 and friends
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,
    Jeff King <peff@peff.net>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

There have been a couple of issues that were reported about v2.45.1, and in
addition I have noticed some myself:

 * a memory leak in the clone protection logic
 * a missed adjustment in the Makefile that leads to an incorrect templates
   path in v2.39.4, v2.40.2 and v2.41.1 (but not in v2.42.2, ..., v2.45.1)
 * an overzealous core.hooksPath check
 * that Git LFS clone problem where it exits with an error (even if the
   clone often succeeded...)

This patch series is based on maint-2.39 to allow for (relatively) easy
follow-up versions v2.39.5, ..., v2.45.2.

Changes since v2:

 * instead of introducing an escape hatch for the clone protections and
   special-casing Git LFS, drop the clone protections

Changes since v1:

 * simplified adding the SHA-256s corresponding to Git LFS' hooks
 * the core.hooksPath test case now verifies that the config setting was
   configured correctly

Johannes Schindelin (6):
  hook: plug a new memory leak
  init: use the correct path of the templates directory again
  Revert "core.hooksPath: add some protection while cloning"
  tests: verify that `clone -c core.hooksPath=/dev/null` works again
  clone: drop the protections where hooks aren't run
  Revert "Add a helper function to compare file contents"

 Makefile                     |  2 +-
 builtin/clone.c              | 12 +-------
 cache.h                      | 14 ---------
 config.c                     | 13 +-------
 copy.c                       | 58 ------------------------------------
 hook.c                       | 32 --------------------
 t/helper/test-path-utils.c   | 10 -------
 t/t0060-path-utils.sh        | 41 -------------------------
 t/t1350-config-hooks-path.sh |  7 +++++
 t/t1800-hook.sh              | 15 ----------
 t/t5601-clone.sh             | 51 -------------------------------
 11 files changed, 10 insertions(+), 245 deletions(-)


base-commit: 47b6d90e91835082010da926f6a844d4441c57a6
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1732%2Fdscho%2Fvarious-fixes-for-v2.45.1-and-friends-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1732/dscho/various-fixes-for-v2.45.1-and-friends-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/1732

Range-diff vs v2:

 1:  d4a003bf2ce = 1:  d4a003bf2ce hook: plug a new memory leak
 2:  961dfc35f42 = 2:  961dfc35f42 init: use the correct path of the templates directory again
 3:  57db89a1497 = 3:  57db89a1497 Revert "core.hooksPath: add some protection while cloning"
 4:  cd14042b065 = 4:  cd14042b065 tests: verify that `clone -c core.hooksPath=/dev/null` works again
 5:  b841db8392e < -:  ----------- hook(clone protections): add escape hatch
 6:  5e5128bc232 < -:  ----------- hooks(clone protections): special-case current Git LFS hooks
 7:  bd6d72625f5 ! 5:  0044a355674 hooks(clone protections): simplify templates hooks validation
     @@ Metadata
      Author: Johannes Schindelin <Johannes.Schindelin@gmx.de>
      
       ## Commit message ##
     -    hooks(clone protections): simplify templates hooks validation
     +    clone: drop the protections where hooks aren't run
      
     -    When an active hook is encountered during a clone operation, to protect
     -    against Remote Code Execution attack vectors, Git checks whether the
     -    hook was copied over from the templates directory.
     +    As part of the security bug-fix releases v2.39.4, ..., v2.45.1, I
     +    introduced logic to safeguard `git clone` from running hooks that were
     +    installed _during_ the clone operation.
      
     -    When that logic was introduced, there was no other way to check this
     -    than to add a function to compare files.
     +    The rationale was that Git's CVE-2024-32002, CVE-2021-21300,
     +    CVE-2019-1354, CVE-2019-1353, CVE-2019-1352, and CVE-2019-1349 should
     +    have been low-severity vulnerabilities but were elevated to
     +    critical/high severity by the attack vector that allows a weakness where
     +    files inside `.git/` can be inadvertently written during a `git clone`
     +    to escalate to a Remote Code Execution attack by virtue of installing a
     +    malicious `post-checkout` hook that Git will then run at the end of the
     +    operation without giving the user a chance to see what code is executed.
      
     -    In the meantime, we've added code to compute the SHA-256 checksum of a
     -    given hook and compare that checksum against a list of known-safe ones.
     +    Unfortunately, Git LFS uses a similar strategy to install its own
     +    `post-checkout` hook during a `git clone`; In fact, Git LFS is
     +    installing four separate hooks while running the `smudge` filter.
      
     -    Let's simplify the logic by adding to said list when copying the
     -    templates' hooks.
     +    While this pattern is probably in want of being improved by introducing
     +    better support in Git for Git LFS and other tools wishing to register
     +    hooks to be run at various stages of Git's commands, let's undo the
     +    clone protections to unbreak Git LFS-enabled clones.
      
     -    We need to be careful to support multi-process operations such as
     -    recursive submodule clones: In such a scenario, the list of SHA-256
     -    checksums that is kept in memory is not enough, we also have to pass the
     -    information down to child processes via `GIT_CONFIG_PARAMETERS`.
     -
     -    Extend the regression test in t5601 to ensure that recursive clones are
     -    handled as expected.
     -
     -    Note: Technically there is no way that the checksums computed while
     -    initializing the submodules' gitdirs can be passed to the process that
     -    performs the checkout: For historical reasons, these operations are
     -    performed in processes spawned in separate loops from the
     -    super-project's `git clone` process. But since the templates from which
     -    the submodules are initialized are the very same as the ones from which
     -    the super-project is initialized, we can get away with using the list of
     -    SHA-256 checksums that is computed when initializing the super-project
     -    and passing that down to the `submodule--helper` processes that perform
     -    the recursive checkout.
     +    This reverts commit 8db1e8743c0 (clone: prevent hooks from running
     +    during a clone, 2024-03-28).
      
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
     - ## builtin/init-db.c ##
     -@@
     - #include "exec-cmd.h"
     - #include "parse-options.h"
     - #include "worktree.h"
     -+#include "run-command.h"
     -+#include "hook.h"
     + ## builtin/clone.c ##
     +@@ builtin/clone.c: int cmd_clone(int argc, const char **argv, const char *prefix)
     + 	int err = 0, complete_refs_before_fetch = 1;
     + 	int submodule_progress;
     + 	int filter_submodules = 0;
     +-	const char *template_dir;
     +-	char *template_dir_dup = NULL;
       
     - #ifdef NO_TRUSTABLE_FILEMODE
     - #define TEST_FILEMODE 0
     -@@ builtin/init-db.c: static void copy_templates_1(struct strbuf *path, struct strbuf *template_path,
     - 	size_t path_baselen = path->len;
     - 	size_t template_baselen = template_path->len;
     - 	struct dirent *de;
     -+	int is_hooks_dir = ends_with(template_path->buf, "/hooks/");
     + 	struct transport_ls_refs_options transport_ls_refs_options =
     + 		TRANSPORT_LS_REFS_OPTIONS_INIT;
     +@@ builtin/clone.c: int cmd_clone(int argc, const char **argv, const char *prefix)
     + 		usage_msg_opt(_("You must specify a repository to clone."),
     + 			builtin_clone_usage, builtin_clone_options);
       
     - 	/* Note: if ".git/hooks" file exists in the repository being
     - 	 * re-initialized, /etc/core-git/templates/hooks/update would
     -@@ builtin/init-db.c: static void copy_templates_1(struct strbuf *path, struct strbuf *template_path,
     - 			strbuf_release(&lnk);
     +-	xsetenv("GIT_CLONE_PROTECTION_ACTIVE", "true", 0 /* allow user override */);
     +-	template_dir = get_template_dir(option_template);
     +-	if (*template_dir && !is_absolute_path(template_dir))
     +-		template_dir = template_dir_dup =
     +-			absolute_pathdup(template_dir);
     +-	xsetenv("GIT_CLONE_TEMPLATE_DIR", template_dir, 1);
     +-
     + 	if (option_depth || option_since || option_not.nr)
     + 		deepen = 1;
     + 	if (option_single_branch == -1)
     +@@ builtin/clone.c: int cmd_clone(int argc, const char **argv, const char *prefix)
       		}
     - 		else if (S_ISREG(st_template.st_mode)) {
     -+			if (is_hooks_dir &&
     -+			    is_executable(template_path->buf))
     -+				add_safe_hook(template_path->buf);
     -+
     - 			if (copy_file(path->buf, template_path->buf, st_template.st_mode))
     - 				die_errno(_("cannot copy '%s' to '%s'"),
     - 					  template_path->buf, path->buf);
     + 	}
     + 
     +-	init_db(git_dir, real_git_dir, template_dir, GIT_HASH_UNKNOWN, NULL,
     ++	init_db(git_dir, real_git_dir, option_template, GIT_HASH_UNKNOWN, NULL,
     + 		INIT_DB_QUIET);
     + 
     + 	if (real_git_dir) {
     +@@ builtin/clone.c: int cmd_clone(int argc, const char **argv, const char *prefix)
     + 	free(unborn_head);
     + 	free(dir);
     + 	free(path);
     +-	free(template_dir_dup);
     + 	UNLEAK(repo);
     + 	junk_mode = JUNK_LEAVE_ALL;
     + 
      
       ## hook.c ##
      @@
     + #include "run-command.h"
       #include "config.h"
     - #include "strmap.h"
       
      -static int identical_to_template_hook(const char *name, const char *path)
      -{
     @@ hook.c
      -	return ret;
      -}
      -
     - static struct strset safe_hook_sha256s = STRSET_INIT;
     - static int safe_hook_sha256s_initialized;
     - 
     -@@ hook.c: static int get_sha256_of_file_contents(const char *path, char *sha256)
     - 	return 0;
     - }
     - 
     -+void add_safe_hook(const char *path)
     -+{
     -+	char sha256[GIT_SHA256_HEXSZ + 1] = { '\0' };
     -+
     -+	if (!get_sha256_of_file_contents(path, sha256)) {
     -+		char *p;
     -+
     -+		strset_add(&safe_hook_sha256s, sha256);
     -+
     -+		/* support multi-process operations e.g. recursive clones */
     -+		p = xstrfmt("safe.hook.sha256=%s", sha256);
     -+		git_config_push_parameter(p);
     -+		free(p);
     -+	}
     -+}
     -+
     - static int safe_hook_cb(const char *key, const char *value, void *d)
     + const char *find_hook(const char *name)
       {
     - 	struct strset *set = d;
     + 	static struct strbuf path = STRBUF_INIT;
      @@ hook.c: const char *find_hook(const char *name)
     + 		}
       		return NULL;
       	}
     - 	if (!git_hooks_path && git_env_bool("GIT_CLONE_PROTECTION_ACTIVE", 0) &&
     --	    !identical_to_template_hook(name, path.buf) &&
     - 	    !is_hook_safe_during_clone(name, path.buf, sha256))
     - 		die(_("active `%s` hook found during `git clone`:\n\t%s\n"
     - 		      "For security reasons, this is disallowed by default.\n"
     -
     - ## hook.h ##
     -@@ hook.h: int run_hooks(const char *hook_name);
     -  * hook. This function behaves like the old run_hook_le() API.
     -  */
     - int run_hooks_l(const char *hook_name, ...);
     -+
     -+/**
     -+ * Mark the contents of the provided path as safe to run during a clone
     -+ * operation.
     -+ *
     -+ * This function is mainly used when copying templates to mark the
     -+ * just-copied hooks as benign.
     -+ */
     -+void add_safe_hook(const char *path);
     -+
     - #endif
     -
     - ## setup.c ##
     -@@
     - #include "promisor-remote.h"
     - #include "quote.h"
     - #include "exec-cmd.h"
     -+#include "hook.h"
     +-	if (!git_hooks_path && git_env_bool("GIT_CLONE_PROTECTION_ACTIVE", 0) &&
     +-	    !identical_to_template_hook(name, path.buf))
     +-		die(_("active `%s` hook found during `git clone`:\n\t%s\n"
     +-		      "For security reasons, this is disallowed by default.\n"
     +-		      "If this is intentional and the hook should actually "
     +-		      "be run, please\nrun the command again with "
     +-		      "`GIT_CLONE_PROTECTION_ACTIVE=false`"),
     +-		    name, path.buf);
     + 	return path.buf;
     + }
       
     - static int inside_git_dir = -1;
     - static int inside_work_tree = -1;
      
       ## t/t5601-clone.sh ##
     -@@ t/t5601-clone.sh: test_expect_success 'clone with init.templatedir runs hooks' '
     - 		git config --unset init.templateDir &&
     - 		! grep "active .* hook found" err &&
     - 		test_path_is_missing hook-run-local-config/hook.run
     -+	) &&
     -+
     -+	test_config_global protocol.file.allow always &&
     -+	git -C tmpl/hooks submodule add "$(pwd)/tmpl/hooks" sub &&
     -+	test_tick &&
     -+	git -C tmpl/hooks add .gitmodules sub &&
     -+	git -C tmpl/hooks commit -m submodule &&
     -+
     -+	(
     -+		sane_unset GIT_TEMPLATE_DIR &&
     -+		NO_SET_GIT_TEMPLATE_DIR=t &&
     -+		export NO_SET_GIT_TEMPLATE_DIR &&
     -+
     -+		git -c init.templateDir="$(pwd)/tmpl" \
     -+			clone --recurse-submodules \
     -+			tmpl/hooks hook-run-submodule 2>err &&
     -+		! grep "active .* hook found" err &&
     -+		test_path_is_file hook-run-submodule/hook.run &&
     -+		test_path_is_file hook-run-submodule/sub/hook.run
     - 	)
     +@@ t/t5601-clone.sh: test_expect_success 'batch missing blob request does not inadvertently try to fe
     + 	git clone --filter=blob:limit=0 "file://$(pwd)/server" client
       '
       
     +-test_expect_success 'clone with init.templatedir runs hooks' '
     +-	git init tmpl/hooks &&
     +-	write_script tmpl/hooks/post-checkout <<-EOF &&
     +-	echo HOOK-RUN >&2
     +-	echo I was here >hook.run
     +-	EOF
     +-	git -C tmpl/hooks add . &&
     +-	test_tick &&
     +-	git -C tmpl/hooks commit -m post-checkout &&
     +-
     +-	test_when_finished "git config --global --unset init.templateDir || :" &&
     +-	test_when_finished "git config --unset init.templateDir || :" &&
     +-	(
     +-		sane_unset GIT_TEMPLATE_DIR &&
     +-		NO_SET_GIT_TEMPLATE_DIR=t &&
     +-		export NO_SET_GIT_TEMPLATE_DIR &&
     +-
     +-		git -c core.hooksPath="$(pwd)/tmpl/hooks" \
     +-			clone tmpl/hooks hook-run-hookspath 2>err &&
     +-		! grep "active .* hook found" err &&
     +-		test_path_is_file hook-run-hookspath/hook.run &&
     +-
     +-		git -c init.templateDir="$(pwd)/tmpl" \
     +-			clone tmpl/hooks hook-run-config 2>err &&
     +-		! grep "active .* hook found" err &&
     +-		test_path_is_file hook-run-config/hook.run &&
     +-
     +-		git clone --template=tmpl tmpl/hooks hook-run-option 2>err &&
     +-		! grep "active .* hook found" err &&
     +-		test_path_is_file hook-run-option/hook.run &&
     +-
     +-		git config --global init.templateDir "$(pwd)/tmpl" &&
     +-		git clone tmpl/hooks hook-run-global-config 2>err &&
     +-		git config --global --unset init.templateDir &&
     +-		! grep "active .* hook found" err &&
     +-		test_path_is_file hook-run-global-config/hook.run &&
     +-
     +-		# clone ignores local `init.templateDir`; need to create
     +-		# a new repository because we deleted `.git/` in the
     +-		# `setup` test case above
     +-		git init local-clone &&
     +-		cd local-clone &&
     +-
     +-		git config init.templateDir "$(pwd)/../tmpl" &&
     +-		git clone ../tmpl/hooks hook-run-local-config 2>err &&
     +-		git config --unset init.templateDir &&
     +-		! grep "active .* hook found" err &&
     +-		test_path_is_missing hook-run-local-config/hook.run
     +-	)
     +-'
     +-
     + . "$TEST_DIRECTORY"/lib-httpd.sh
     + start_httpd
     + 
 8:  4b0a636d41a = 6:  5c576e889d8 Revert "Add a helper function to compare file contents"

-- 
gitgitgadget
