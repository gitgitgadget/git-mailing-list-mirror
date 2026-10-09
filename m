Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C743D3FE348
	for <git@vger.kernel.org>; Fri,  9 Oct 2026 08:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791535973; cv=none; b=L4DW1cFEHLUbLqfOJxBw86J0jQDUh5Esjz+lY9RuvTVTbXzddQYjbePsqhUhS9Y0YW2w0a5c+sd9TqPCQsv9+YdM5+1EZt+dQoBFhglHsy3uD+vOeQDMAm4+b7odmWs6J6POx3ldTbmWyk+TF/Unx53souMpGleEDu6OSJQ3h/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791535973; c=relaxed/simple;
	bh=15mSgQcrULK1kYPL8TuffZ3NgIAEa2ZsvsNmSlV97+0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=BIr8yGRR7ytENyytp6fqDfvyh3L6yqS5jFYGSC+uyC/rsrhOgj3dtgTvhnTARqwyinpELIRgTgqqQ4dxYsgYccJFYJHx1OUlnemuK+HLDlf1kA035gR406YTgmwR+BGgfkRgnGM52eIbzmIsvO0Fm1Smwn7x32U/adNwoH5Ml34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=RXTNb7sf; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="RXTNb7sf"
Received: from [192.168.4.34] (unknown [4.194.122.136])
	by linux.microsoft.com (Postfix) with ESMTPSA id 0200020B7168;
	Fri,  9 Oct 2026 01:52:42 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 0200020B7168
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1791535969;
	bh=/U+9bRJ9nLJ+KQV1Mabju3TBQuC2cEDZzZaryvie/6U=;
	h=From:Subject:Date:In-Reply-To:References:To:Cc:From;
	b=RXTNb7sfL6+YJ/0Rc1PFCzrdWnxeGMM861+oBgUvJ1FrQbaSWPMMMkp1xiiAbiRX8
	 QRTnMxUUxgTqEZ8JHvBKR9u0KuxXQc58JQ6X1IrnEWPMpfotCYm08GzQaIOznNRzdv
	 a01T5RzKH1oiYVXoqkkMVXDhsbepy4j7cOqwqSm4=
From: Delilah Ashley Wu <delilahwu@linux.microsoft.com>
Subject: [PATCH v3 0/2] config: read both home and xdg files for --global
Date: Fri, 09 Oct 2026 19:51:44 +1100
Message-Id: <20261009-fix-config-list-global-home-and-xdg-v3-0-f936b9c8a0cc@microsoft.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACCryGoC/5WPTW7DIBSErxKx7rP4SR3IKveougAMmApMBMRKF
 PnuBfsCrfQ2I735ZuaNisneFHQ9vVE2qy8+LU2wjxPSs1ycAT81jSimI+aYg/VP0Gmx3kHwpYI
 LSckAc4oG5DLBc3IglJZSY8EkUaiR7tk0257y9X3o8lA/RteO7h82pwh1zkbuafdHCAMRjA/O1
 4FcRow/OT+LLvvJyZl6c1H6MOgUO2FuZVJ+7UNW0pP+TenVVrpbj7mU/WnuSgGDokLrkVlMLuo
 Wvc6pJFsP7rZtv82B2jRpAQAA
X-Change-ID: 20260808-fix-config-list-global-home-and-xdg-9bcaac093a1b
In-Reply-To: <pull.1938.git.1760058849.gitgitgadget@gmail.com>
References: <pull.1938.git.1760058849.gitgitgadget@gmail.com>
To: git@vger.kernel.org
Cc: Derrick Stolee <stolee@gmail.com>, Chris Torek <chris.torek@gmail.com>, 
 Patrick Steinhardt <ps@pks.im>, Delilah Ashley Wu <delilahwu@microsoft.com>, 
 Ben Knoble <ben.knoble@gmail.com>, Nils Fahldieck <nils@fahldieck.de>, 
 Junio C Hamano <gitster@pobox.com>, 
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
 Johannes Schindelin <Johannes.Schindelin@gmx.de>, 
 Jade Lovelace <lists@jade.fyi>, Glen Choo <glencbz@gmail.com>
X-Mailer: b4 0.15.2

Hi all, thanks again for your patience. I think I've addressed all the
feedback from Junio's review.

As reported in [1], `$HOME/.gitconfig` and `$XDG_CONFIG_HOME/git/config`
are both valid global configuration locations. However, when both files
exist, `git config list --global` only reads from the former location
whereas `git config list` (without `--global`) reads from both. The same
issue was reported for `git config get` in [2]. This inconsistency has
no good justification and contradicts the documented behaviour.

Suppose that `$HOME/.gitconfig` contains:
    [home]
        config = true

and `$XDG_CONFIG_HOME/git/config` contains:
    [xdg]
        config = true

Then, listing with `--global` shows only the home config:
    $ git config list --global --show-scope --show-origin
    global  file:/Users/delilah/.gitconfig    home.config=true

and getting the XDG configuration entry with `--global` will fail:
    $ git config get --global xdg.config; echo $?
    1

Git still reads the XDG config as part of its effective configuration,
as shown by listing the configuration without `--global`:
    $ git config list --show-scope --show-origin
    global  file:/Users/delilah/.config/git/config    xdg.config=true
    global  file:/Users/delilah/.gitconfig            home.config=true

The documentation, quoted in [1] and [2], states that `--global` should
read from both files, so its output should be the same as above. Here's
the relevant excerpt:

> OPTIONS
>     --global::
>         For writing options: write to global `~/.gitconfig` file
>         rather than the repository `.git/config`, write to
>         `$XDG_CONFIG_HOME/git/config` file if this file exists and the
>         `~/.gitconfig` file doesn't.
>
>         For reading options: read only from global `~/.gitconfig` and from
>         `$XDG_CONFIG_HOME/git/config` rather than from all available files.

To be consistent with the documentation and the behaviour without
`--global`, we should read both configuration files when `--global` is
passed. Writing or editing the global configuration remains unchanged
and retains the current destinations as discussed in [3].

[1]: https://lore.kernel.org/git/CAFA9we-QLQRzJdGMMCPatmfrk1oHeiUu9msMRXXk1MLE5HRxBQ@mail.gmail.com/
[2]: https://lore.kernel.org/git/CAAdFe9yhBk-WecVzCTsjQ-4Z3AZAbpP+w+B076ouM3qX6d1WAg@mail.gmail.com/
[3]: https://lore.kernel.org/git/xmqqo6esti9o.fsf@gitster.g/

Thanks for your time!
Delilah

---
Changes in v3:
 - Drop patch 1 ("path: use forward slashes in XDG config on Windows"),
   then set `XDG_CONFIG_HOME` during a `--show-origin` test so the path
   assertions still pass on Windows.
 - Drop implementation changes from v2 patch 2 ("config: let sequence
   require a successful file"), leaving its tests as v3 patch 1 ("t1300:
   test list with missing global config"). This removes
   `attempt_git_config_from_file_with_options()` and `success_count` in
   favour of a new `global_had_success` flag in v3 patch 2.
 - Teach `git_config_system()` to respect the new `ignore_system` flag.
 - Refactor `config_with_options()` changes for shorter lines.
 - Remove the unused `ignore_global` flag.
 - Test that other scopes are ignored when `--global` is specified.
 - Link to v2: https://patch.msgid.link/20260823-fix-config-list-global-home-and-xdg-v2-0-b29cc63f017b@microsoft.com/

Changes in v2:
 - Squash test-only patches into their corresponding implementation
   patches.
 - Reorder patches to prevent a regression from being introduced and
   then fixed in a later patch.
 - Narrow the scope of slash conversion to `xdg_config_home_for()` and
   avoid modifying `cleanup_path()`, which could've broken callers that
   do not expect normalised slashes.
 - Clarify that some tests only check the return code of a `git config`
   command; we do not care about the output.
 - Link to v1: https://patch.msgid.link/pull.1938.git.1760058849.gitgitgadget@gmail.com/

---
Delilah Ashley Wu (2):
      t1300: test list with missing global config
      config: read global scope via config_sequence

 builtin/config.c     |  11 +++++
 builtin/var.c        |   4 +-
 config.c             |  50 +++++++++++++++-------
 config.h             |   3 +-
 t/t1300-config.sh    | 116 +++++++++++++++++++++++++++++++++++++++++++++++++++
 t/t1306-xdg-files.sh |   5 ++-
 6 files changed, 172 insertions(+), 17 deletions(-)

Range-diff versus v2:

1:  5a2a98c38b < -:  ---------- path: use forward slashes in XDG config on Windows
2:  75e1deab27 < -:  ---------- config: let sequence require a successful file
-:  ---------- > 1:  283725f0c4 t1300: test list with missing global config
3:  4a6f67fdf4 ! 2:  482d05e24d config: read global scope via config_sequence
    @@ Commit message
         Since `git config list --show-scope --show-origin` reads both the home
         and XDG files, there must be existing code that respects both locations,
         namely `do_git_config_sequence()` which reads from all scopes. Introduce
    -    flags to ignore all but the global scope (i.e. ignore system, local,
    -    worktree, and cmdline). Then, reuse the function to read only the global
    -    scope when `--global` is specified. This was the suggested solution [3]
    -    in the original bug report [1].
    +    an `ignore_system` flag and modify `git_config_system()` to respect it.
    +    This makes `config_options` the primary way to disable parts of the
    +    configuration sequence and allows callers of `do_git_config_sequence()`
    +    to ignore all but the global scope (i.e. ignore system, local, worktree,
    +    and cmdline). Reuse the function to read only the global scope when
    +    `--global` is specified. This was the suggested solution [3] in the
    +    original bug report [1].
     
    -    Modify tests to check that both configuration files are respected during
    -    `--global` read operations. Also, add additional tests to supplement the
    -    regression tests from the previous patch, "config: let sequence require
    -    a successful file". The expected behaviour of `git config list` is:
    -      - Without `--global`, it should not bail on unreadable/non-existent
    -        global config files.
    +    The previous patch, "t1300: test list with missing global config",
    +    recorded existing behaviour: when no global configuration file exists,
    +    `git config list` should succeed whereas `git config list --global`
    +    should fail. Since the configuration sequence gracefully ignores missing
    +    global configuration files, track whether we successfully read at least
    +    one of them and adjust the return code accordingly.
     
    -      - With `--global`, it should bail when both `$HOME/.gitconfig` and
    -        `$XDG_CONFIG_HOME/git/config` are unreadable. It should not bail
    -        when one or more of them is readable.
    +    Keep populating `opts->source.file` in `builtin/config.c` as the
    +    destination for write operations. Read operations use the configuration
    +    sequence instead, which can be confusing. Add a comment to explain this
    +    distinction.
     
    -    Implementation notes:
    -      - The `ignore_global` flag is not set anywhere, so the
    -        `if (!opts->ignore_global)` condition is always met. Include the
    -        flag for completeness, but we can remove it if desired.
    -
    -      - Keep populating `opts->source.file` in `builtin/config.c` because it
    -        is used as the destination config file for write operations. The
    -        proposed changes could convolute the code because there is no single
    -        source of truth for the config file locations in the global scope.
    -        Add a comment to clarify this.
    +    Lastly, modify tests to check that both home and XDG configuration files
    +    are respected during `--global` read operations.
     
         [1] https://lore.kernel.org/git/CAFA9we-QLQRzJdGMMCPatmfrk1oHeiUu9msMRXXk1MLE5HRxBQ@mail.gmail.com/
         [2] https://lore.kernel.org/git/CAAdFe9yhBk-WecVzCTsjQ-4Z3AZAbpP+w+B076ouM3qX6d1WAg@mail.gmail.com/
    -    [3] https://lore.kernel.org/git/kl6ly1oze7wb.fsf@chooglen-macbookpro.roam.corp.google.com
    +    [3] https://lore.kernel.org/git/kl6ly1oze7wb.fsf@chooglen-macbookpro.roam.corp.google.com/
     
         Reported-by: Jade Lovelace <lists@jade.fyi>
         Reported-by: Nils Fahldieck <nils@fahldieck.de>
    @@ builtin/config.c: static void location_options_init(struct config_location_optio
      		if (!opts->source.file)
      			/*
     
    + ## builtin/var.c ##
    +@@ builtin/var.c: static char *git_attr_val_global(int ident_flag UNUSED)
    + 
    + static char *git_config_val_system(int ident_flag UNUSED)
    + {
    +-	if (git_config_system()) {
    ++	const struct config_options opts = { 0 };
    ++
    ++	if (git_config_system(&opts)) {
    + 		char *file = git_system_config();
    + 		normalize_path_copy(file, file);
    + 		return file;
    +
      ## config.c ##
    +@@ config.c: void git_global_config_paths(char **user_out, char **xdg_out)
    + 	*xdg_out = xdg_config;
    + }
    + 
    +-int git_config_system(void)
    ++int git_config_system(const struct config_options *opts)
    + {
    +-	return !git_env_bool("GIT_CONFIG_NOSYSTEM", 0);
    ++	return !opts->ignore_system && !git_env_bool("GIT_CONFIG_NOSYSTEM", 0);
    + }
    + 
    + static int do_git_config_sequence(const struct config_options *opts,
    +-				  const struct repository *repo,
    +-				  config_fn_t fn, void *data)
    ++				  const struct repository *repo, config_fn_t fn,
    ++				  void *data, int require_global_scope_success)
    + {
    ++	int tmp_ret;
    + 	int ret = 0;
    ++	int global_had_success = 0;
    + 	char *system_config = git_system_config();
    + 	char *xdg_config = NULL;
    + 	char *user_config = NULL;
     @@ config.c: static int do_git_config_sequence(const struct config_options *opts,
      		worktree_config = NULL;
      	}
      
     -	if (git_config_system() && system_config &&
    -+	if (!opts->ignore_system && git_config_system() && system_config &&
    ++	if (git_config_system(opts) && system_config &&
      	    !access_or_die(system_config, R_OK,
      			   opts->system_gently ? ACCESS_EACCES_OK : 0))
    - 		attempt_git_config_from_file_with_options(fn, system_config, data,
    - 							  CONFIG_SCOPE_SYSTEM, NULL,
    - 							  &success_count, &ret);
    + 		ret += git_config_from_file_with_options(fn, system_config,
    +@@ config.c: static int do_git_config_sequence(const struct config_options *opts,
      
    --	git_global_config_paths(&user_config, &xdg_config);
    -+	if (!opts->ignore_global) {
    -+		git_global_config_paths(&user_config, &xdg_config);
    + 	git_global_config_paths(&user_config, &xdg_config);
      
     -	if (xdg_config && !access_or_die(xdg_config, R_OK, ACCESS_EACCES_OK))
    --		attempt_git_config_from_file_with_options(fn, xdg_config,
    --							  data,
    --							  CONFIG_SCOPE_GLOBAL,
    --							  NULL, &success_count, &ret);
    -+		if (xdg_config && !access_or_die(xdg_config, R_OK, ACCESS_EACCES_OK))
    -+			attempt_git_config_from_file_with_options(fn, xdg_config,
    -+								  data,
    -+								  CONFIG_SCOPE_GLOBAL,
    -+								  NULL, &success_count, &ret);
    +-		ret += git_config_from_file_with_options(fn, xdg_config, data,
    +-							 CONFIG_SCOPE_GLOBAL, NULL);
    ++	if (xdg_config &&
    ++	    !access_or_die(xdg_config, R_OK, ACCESS_EACCES_OK)) {
    ++		tmp_ret = git_config_from_file_with_options(fn, xdg_config,
    ++							    data, CONFIG_SCOPE_GLOBAL,
    ++							    NULL);
    ++		ret += tmp_ret;
    ++		if (!tmp_ret)
    ++			global_had_success = 1;
    ++	}
      
     -	if (user_config && !access_or_die(user_config, R_OK, ACCESS_EACCES_OK))
    --		attempt_git_config_from_file_with_options(fn, user_config,
    --							  data,
    --							  CONFIG_SCOPE_GLOBAL,
    --							  NULL, &success_count, &ret);
    -+		if (user_config && !access_or_die(user_config, R_OK, ACCESS_EACCES_OK))
    -+			attempt_git_config_from_file_with_options(fn, user_config,
    -+								  data,
    -+								  CONFIG_SCOPE_GLOBAL,
    -+								  NULL, &success_count, &ret);
    -+
    -+		free(xdg_config);
    -+		free(user_config);
    +-		ret += git_config_from_file_with_options(fn, user_config, data,
    +-							 CONFIG_SCOPE_GLOBAL, NULL);
    ++	if (user_config &&
    ++	    !access_or_die(user_config, R_OK, ACCESS_EACCES_OK)) {
    ++		tmp_ret = git_config_from_file_with_options(fn, user_config,
    ++							    data, CONFIG_SCOPE_GLOBAL,
    ++							    NULL);
    ++		ret += tmp_ret;
    ++		if (!tmp_ret)
    ++			global_had_success = 1;
     +	}
      
      	if (!opts->ignore_repo && repo_config &&
      	    !access_or_die(repo_config, R_OK, 0))
     @@ config.c: static int do_git_config_sequence(const struct config_options *opts,
    - 		die(_("unable to parse command-line config"));
    - 
    - 	free(system_config);
    --	free(xdg_config);
    --	free(user_config);
    + 	free(user_config);
      	free(repo_config);
      	free(worktree_config);
    ++
    ++	if (require_global_scope_success && !global_had_success && !ret)
    ++		ret = -1;
    ++
    + 	return ret;
    + }
      
     @@ config.c: int config_with_options(config_fn_t fn, void *data,
    + 	}
    + 
    + 	/*
    +-	 * If we have a specific filename, use it. Otherwise, follow the
    +-	 * regular lookup sequence.
    ++	 * Use the specified file when provided, except for the global scope,
    ++	 * which can come from more than one file. With no explicit source,
    ++	 * follow the regular lookup sequence.
      	 */
      	if (config_source && config_source->use_stdin) {
      		ret = git_config_from_stdin(fn, data, config_source->scope);
    --	} else if (config_source && config_source->file) {
     +	} else if (config_source && config_source->file &&
    -+		   config_source->scope != CONFIG_SCOPE_GLOBAL) {
    ++		   config_source->scope == CONFIG_SCOPE_GLOBAL) {
    ++		ret = do_git_config_sequence(opts, repo, fn, data, 1);
    + 	} else if (config_source && config_source->file) {
      		ret = git_config_from_file_with_options(fn, config_source->file,
      							data, config_source->scope,
    - 							NULL);
     @@ config.c: int config_with_options(config_fn_t fn, void *data,
      		ret = git_config_from_blob_ref(fn, repo, config_source->blob,
      					       data, config_source->scope);
      	} else {
    --		ret = do_git_config_sequence(opts, repo, fn, data, 0);
    -+		ret = do_git_config_sequence(opts, repo, fn, data,
    -+					     config_source && config_source->scope == CONFIG_SCOPE_GLOBAL);
    +-		ret = do_git_config_sequence(opts, repo, fn, data);
    ++		ret = do_git_config_sequence(opts, repo, fn, data, 0);
      	}
      
      	if (inc.remote_urls) {
    @@ config.h: typedef int (*config_parser_event_fn_t)(enum config_event_t type,
      struct config_options {
      	unsigned int respect_includes : 1;
     +	unsigned int ignore_system : 1;
    -+	unsigned int ignore_global : 1;
      	unsigned int ignore_repo : 1;
      	unsigned int ignore_worktree : 1;
      	unsigned int ignore_cmdline : 1;
    +@@ config.h: int repo_config_rename_section(struct repository *, const char *, const char *);
    + int repo_config_rename_section_in_file(struct repository *, const char *, const char *, const char *);
    + int repo_config_copy_section(struct repository *, const char *, const char *);
    + int repo_config_copy_section_in_file(struct repository *, const char *, const char *, const char *);
    +-int git_config_system(void);
    ++int git_config_system(const struct config_options *opts);
    + int config_error_nonbool(const char *);
    + #if defined(__GNUC__)
    + #define config_error_nonbool(s) (config_error_nonbool(s), const_error())
     
      ## t/t1300-config.sh ##
     @@ t/t1300-config.sh: test_expect_success 'list --global with nonexistent global config fails' '
    @@ t/t1300-config.sh: test_expect_success 'list --global with nonexistent global co
     +	global	file:$HOME/.config/git/config	xdg.config=xdg
     +	global	file:$HOME/.gitconfig	home.config=home
     +	EOF
    -+	git config ${mode_prefix}list --global --show-scope --show-origin >actual &&
    ++	# Git uses HOME and XDG_CONFIG_HOME to determine the location of the
    ++	# XDG config file. On Windows, the default values lead to mixed forward
    ++	# and backward slashes in the output --show-origin path for XDG config.
    ++	# Explicitly set XDG_CONFIG_HOME with only forward slashes, allowing us
    ++	# to use the same expected path across all platforms.
    ++	XDG_CONFIG_HOME="$HOME/.config" \
    ++		git config ${mode_prefix}list --global \
    ++		--show-scope --show-origin >actual &&
     +	test_cmp expect actual &&
     +
     +	echo xdg >expect &&
    @@ t/t1300-config.sh: test_expect_success 'list --global with nonexistent global co
     +	git config ${mode_get} --global home.config >actual &&
     +	test_cmp expect actual
     +'
    ++
    ++test_expect_success 'list --global ignores other scopes' '
    ++	test_when_finished rm -f system_config &&
    ++	cat >system_config <<-EOF &&
    ++	[system]
    ++		config = true
    ++	EOF
    ++
    ++	test_config core.repositoryformatversion 1 &&
    ++	test_config extensions.worktreeConfig true &&
    ++	test_config --worktree worktree.config true &&
    ++
    ++	test_when_finished rm -f \"\$HOME\"/.gitconfig &&
    ++	cat >"$HOME"/.gitconfig <<-EOF &&
    ++	[home]
    ++		config = home
    ++	EOF
    ++
    ++	test_config repo.config true &&
    ++
    ++	echo "global	home.config=home" >expect &&
    ++	GIT_CONFIG_NOSYSTEM=false GIT_CONFIG_SYSTEM=system_config \
    ++		git -c cmdline.config=true config ${mode_prefix}list \
    ++		--global --show-scope >actual &&
    ++	test_cmp expect actual
    ++'
     +
      test_expect_success 'override global and system config' '
      	test_when_finished rm -f \"\$HOME\"/.gitconfig &&

---
base-commit: 6de20f6092dcf9bdb1c8efe03db4b70c82b423dd
change-id: 20260808-fix-config-list-global-home-and-xdg-9bcaac093a1b

