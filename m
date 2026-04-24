Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A1DC2D780E
	for <git@vger.kernel.org>; Fri, 24 Apr 2026 19:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777060418; cv=none; b=Ohh3dgImKUkSrRLQWKfODorwiMDsQ3xSQ0T2ENvlH7qjXakluUvl8BlpBQGt85MOgXEVR9yQ6oqSh8urqqjWwgxrYej30EzxFtvZJ0DIziNji3e5482sMztUBreCZvliE1FzE6askEPy7bfs9Be81g86sgFqD1losR6EKY5F+eQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777060418; c=relaxed/simple;
	bh=uwsrhqg7Kf9+5k6P9rueqaW0dWkgbQGY/f4ZPFFZqn4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZBCrAAGGEi7p4nSyEvMojvOkBbRN0n4oAB7X7f1cMTpyWtXueVRuYwgd1I3EVEC4LsAICEt/+IJ2GOCKm2GiQO2igi5b/yUF9clfyLtAZjs+l4nw+Ok3GlG8gJfsEj1xetG5iTrzLiPnVS9BtPwFv77BxU40cZl6e97MkeH9gMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TFIapVUu; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TFIapVUu"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-488af96f6b2so105311725e9.0
        for <git@vger.kernel.org>; Fri, 24 Apr 2026 12:53:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777060415; x=1777665215; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=WlCck1ASqeKIYbOpIpkd9yCqW/beIYnTzHhEin1KBLw=;
        b=TFIapVUunGev9OvP8k9YQ0WCmP22F2TJlF3lMNsM6yQRr2qRozmEHxpWikIZ62XNB5
         gRLzhmI6yz0w7T2fiblU01QtSTvr1FROTLzXq5HHDvtNZSX72bOCA7cXP6ohIo5pojTg
         idfs44EV3dtaSSq/iO+oJiUOH3IRF9MoeaFs94InOfWQ3JPyVoZQflsP2S0aw0l2xh4m
         V3XPCwtt3BGZyn/N6EWltXxuZsJg0roK+4pXkt0wR5rCihrtPAO0qHMDDPpMFWAk/O26
         0EOalsCE9JKc22mAX3MrP6CHPSTu8JtgPIW8ZGQtEAso8bIxx0t95eK2YSdt53vpdwFA
         IExg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777060415; x=1777665215;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WlCck1ASqeKIYbOpIpkd9yCqW/beIYnTzHhEin1KBLw=;
        b=KM+Ho647Cc4GtmP8agvaYRG3HN8oft2wzY7oZRmXTWmXDe3arkeFOvCwTFYp2D2XmI
         SJl9GCZfuIOxvv6NCJvRGJmldkxm6+gs8vzZrFL+LjwL1Mpr7aGlyuCqDJrn4JYtR9iJ
         XNfOvGud5533NqQpETCp8Q1HnPewtVVofxZttMeldOn3pv0UMyB6QKYxqo0RiAfgqixd
         hM/bZuj/LavsK7xqSBW1iqZ2jABJXgsw9XDBa4EHvnfNVC86Bq2d81Vt02KVUK0cJINZ
         sjGLcxgUTB9EXJt7U6Ieu2PjhQtgAAgrtqGxetG3q8WaZ8zv/LnlYoRZP1yo29PV1fXF
         wosA==
X-Forwarded-Encrypted: i=1; AFNElJ+F0fxb4pts4RXQBB6kNBNpci3IHj74XVeoOOhkJaJDLcCiwUYfbl6mXxl46RvXRFgbjW0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNvrmI0PlEYTVJpAEWQeNOPfIquAtKWoicKjj6PqTf33Wp4dXM
	ffj3h7wny0HjYsdLdplH3ufXLlDkmxX15djCTAhzY5yD1BJt6SKaJpw6
X-Gm-Gg: AeBDievxAVw6W68s2kmIlESKUJl0hQ+C0fsW9AT1Iw3Rh7mYNBop3gnUCiQCrQK3CVf
	FDVZUFIvr/NYdwr3Uou21/3DzZW0U3xsHTbjkFptti2hlIhYjQ6iUrzLf3YeJ9FxV15rB2kl9NF
	HGkdV5q/epx6nSecTP4AeMXa2bktfa8+AKzhkrOi5NLNVCqOCif2389w6opKVENvrMd0AmcIdvE
	1jGx1TwkY6jmteAZfmWe6+9ht4HffrDYEak4YvjeO8Z5G+VIrjjFd5ra+GxFlRIetR9Pm1tntiQ
	+WtiAJ271EHiN4Wv0FiDhDZH62ZexXHVgrPCIELXBFkCY2mO1o2qIxbnUEsoBjyYwv2m8gYuP15
	+9kCuDCFCObonKVCMjOuMIazaCgUJ1mGZM1xLuGbUyZoo1oOdYjtvSE3ejtEq8g0ZfTO71eWHkP
	ZvlAyRjXQZjK79XLUj25EuhSnGtSJCNORn3y1+LDOW9Qcwur4x0SbF/Q6sH9NIocSC5RIrB78Sq
	V98F9joU26eSg==
X-Received: by 2002:a05:600c:c0c8:b0:487:21c7:2885 with SMTP id 5b1f17b1804b1-488fb73d9ffmr356978375e9.5.1777060415226;
        Fri, 24 Apr 2026 12:53:35 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:7d8:fa01:60c8:18fb:2acc:d4f? ([2a0a:ef40:7d8:fa01:60c8:18fb:2acc:d4f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4891c08faffsm720475575e9.1.2026.04.24.12.53.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Apr 2026 12:53:34 -0700 (PDT)
Message-ID: <4a8d1289-2e2b-4fd6-8ada-143992dd7c4d@gmail.com>
Date: Fri, 24 Apr 2026 20:53:31 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] dir: use per-worktree repository ignore patterns upon
 request
To: "D. Ben Knoble" <ben.knoble+github@gmail.com>, git@vger.kernel.org
Cc: "brian m . carlson" <sandals@crustytoothpaste.net>,
 Patrick Steinhardt <ps@pks.im>, Taylor Blau <me@ttaylorr.com>,
 Caleb White <cdwhite3@pm.me>, Calvin Wan <calvinwan@google.com>,
 Junio C Hamano <gitster@pobox.com>, Elijah Newren <newren@gmail.com>,
 Andrew Berry <andrew@furrypaws.ca>, Jeff King <peff@peff.net>,
 Derrick Stolee <stolee@gmail.com>
References: <e3ee0a11b566dd2cc605447c111ae4620bce0fe6.1777050300.git.ben.knoble+github@gmail.com>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <e3ee0a11b566dd2cc605447c111ae4620bce0fe6.1777050300.git.ben.knoble+github@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Ben

On 24/04/2026 18:09, D. Ben Knoble wrote:
> Today we have $GIT_DIR/info/exclude for the main worktree, but $(git
> rev-parse --git-dir)/info/exclude for secondary worktrees does not
> actually contribute to ignore specs; instead, secondary worktrees also
> use $GIT_COMMON_DIR/info/exclude.

Sharing the same set of exclude patterns between all worktrees seems 
like a reasonable thing to do - it would be a pain to have to populate 
them every time a new worktree was created.

	git rev-parse --git-path info/exclude

always returns the correct path because it uses repo_git_path() which 
knows whether a particular path is per-worktree or resides under 
$GIT_COMMON_DIR. It is best to avoid constructing paths manually using 
"git rev-parse --git-dir"

> Some users may prefer each worktree use its own ignore file; some may
> prefer both; some may prefer the current behavior.

This sounds quite hypothetical - do we have a concrete use case for 
per-worktree exclude files?

If there is a use for per-worktree excludes it would be much better to 
use a different path such as "info.worktree/exclude" so that the main 
worktree can have both shared and per-worktree excludes. We could use 
"exclude.worktree" like "config.worktree" but then we'd be in danger of 
adding new ".worktree" files in the future if we want to add 
per-worktree versions of other files that live under "info/"

Thanks

Phillip

> Add, test, and document extensions.worktreeIgnore that controls which
> set of ignore files to use for worktrees.
> 
> Signed-off-by: D. Ben Knoble <ben.knoble+github@gmail.com>
> ---
> 
> Notes (benknoble/commits):
>      Discussed briefly at https://lore.kernel.org/git/CALnO6CCXmA+ATT7CuyWkU6P8qmLCCpMi5Ppr1c78s0heznpVyw@mail.gmail.com/T
> 
>      This is based on next (4f69b47b94 (Merge branch 'ps/test-set-e-clean' into
>      next, 2026-04-23)) but cleanly applies to master (94f057755b (Git 2.54,
>      2026-04-19)) and seen (50541634cb (Merge branch
>      'js/parseopt-subcommand-autocorrection' into seen, 2026-04-23)).
> 
>   Documentation/config/extensions.adoc |  7 ++++
>   Documentation/git-worktree.adoc      |  3 ++
>   Documentation/gitignore.adoc         |  6 ++--
>   dir.c                                | 48 +++++++++++++++++++++++---
>   t/meson.build                        |  1 +
>   t/t2408-worktree-ignore.sh           | 50 ++++++++++++++++++++++++++++
>   6 files changed, 109 insertions(+), 6 deletions(-)
>   create mode 100755 t/t2408-worktree-ignore.sh
> 
> diff --git a/Documentation/config/extensions.adoc b/Documentation/config/extensions.adoc
> index be6678bb5b..5bfb06a54b 100644
> --- a/Documentation/config/extensions.adoc
> +++ b/Documentation/config/extensions.adoc
> @@ -148,3 +148,10 @@ details.
>   +
>   For historical reasons, this extension is respected regardless of the
>   `core.repositoryFormatVersion` setting.
> +
> +worktreeIgnore:::
> +	If enabled, then worktrees will load per-repository ignore files from
> +	`$GIT_DIR/info/exclude` (that is,
> +	`$GIT_COMMON_DIR/worktrees/<id>/info/exclude`). If set to `merge`, then
> +	both `$GIT_COMMON_DIR/info/exclude` and `$GIT_DIR/info/exclude` are
> +	used.
> diff --git a/Documentation/git-worktree.adoc b/Documentation/git-worktree.adoc
> index fbf8426cd9..611c1e06b0 100644
> --- a/Documentation/git-worktree.adoc
> +++ b/Documentation/git-worktree.adoc
> @@ -412,6 +412,9 @@ linkgit:gitrepository-layout[5] for details.
>   When `extensions.worktreeConfig` is enabled, the config file
>   `.git/worktrees/<id>/config.worktree` is read after `.git/config` is.
>   
> +See `extensions.worktreeIgnore` in linkgit:git-config[1] to control how
> +per-repository ignore files are found in worktrees.
> +
>   LIST OUTPUT FORMAT
>   ------------------
>   The `worktree list` command has two output formats. The default format shows the
> diff --git a/Documentation/gitignore.adoc b/Documentation/gitignore.adoc
> index a3d24e5c34..d6976a44e4 100644
> --- a/Documentation/gitignore.adoc
> +++ b/Documentation/gitignore.adoc
> @@ -7,7 +7,7 @@ gitignore - Specifies intentionally untracked files to ignore
>   
>   SYNOPSIS
>   --------
> -$XDG_CONFIG_HOME/git/ignore, $GIT_DIR/info/exclude, .gitignore
> +$XDG_CONFIG_HOME/git/ignore, $GIT_COMMON_DIR/info/exclude, .gitignore
>   
>   DESCRIPTION
>   -----------
> @@ -34,7 +34,9 @@ precedence, the last matching pattern decides the outcome):
>      includes such `.gitignore` files in its repository, containing patterns for
>      files generated as part of the project build.
>   
> - * Patterns read from `$GIT_DIR/info/exclude`.
> + * Patterns read from `$GIT_COMMON_DIR/info/exclude`. (See
> +   `extensions.worktreeIgnore` in linkgit:git-config[1] to change how this
> +   applies to worktrees.)
>   
>    * Patterns read from the file specified by the configuration
>      variable `core.excludesFile`.
> diff --git a/dir.c b/dir.c
> index fcb8f6dd2a..9592eb0062 100644
> --- a/dir.c
> +++ b/dir.c
> @@ -36,6 +36,7 @@
>   #include "trace2.h"
>   #include "tree.h"
>   #include "hex.h"
> +#include "worktree.h"
>   
>    /*
>     * The maximum size of a pattern/exclude file. If the file exceeds this size
> @@ -3478,6 +3479,23 @@ int remove_dir_recursively(struct strbuf *path, int flag)
>   }
>   
>   static GIT_PATH_FUNC(git_path_info_exclude, "info/exclude")
> +static const char *git_worktree_info_exclude(void)
> +{
> +	static const char *ret;
> +	if (!ret)
> +	{
> +		const struct worktree *wt = get_worktree_from_repository(the_repository);
> +		ret = worktree_git_path(wt, "info/exclude");
> +	}
> +	return ret;
> +}
> +
> +static void standard_exclude_from_info(const char *path, struct dir_struct *dir)
> +{
> +	struct oid_stat *oid_stat = dir->untracked ? &dir->internal.ss_info_exclude : NULL;
> +	if (!access_or_warn(path, R_OK, 0))
> +		add_patterns_from_file_1(dir, path, oid_stat);
> +}
>   
>   void setup_standard_excludes(struct dir_struct *dir)
>   {
> @@ -3492,10 +3510,32 @@ void setup_standard_excludes(struct dir_struct *dir)
>   
>   	/* per repository user preference */
>   	if (startup_info->have_repository) {
> -		const char *path = git_path_info_exclude();
> -		if (!access_or_warn(path, R_OK, 0))
> -			add_patterns_from_file_1(dir, path,
> -						 dir->untracked ? &dir->internal.ss_info_exclude : NULL);
> +		/* extensions.worktreeIgnore determines which includes we add */
> +		const char *wt_ignore;
> +		int do_wt_ignore;
> +		if (repo_config_get_value(the_repository,
> +					  "extensions.worktreeIgnore",
> +					  &wt_ignore)) {
> +			/* unset: use main/.git/info/exclude */
> +			standard_exclude_from_info(git_path_info_exclude(), dir);
> +			return;
> +		}
> +		do_wt_ignore = git_parse_maybe_bool(wt_ignore);
> +		if (!do_wt_ignore) {
> +			/* false: as above */
> +			standard_exclude_from_info(git_path_info_exclude(), dir);
> +		} else if (do_wt_ignore > 0 || !strcmp(wt_ignore, "worktree")) {
> +			/* true/worktree: use worktree/.git‡/info/exclude
> +			 * ‡: resolving .git */
> +			standard_exclude_from_info(git_worktree_info_exclude(), dir);
> +		} else if (!strcmp(wt_ignore, "merge")) {
> +			/* merge both! worktree last */
> +			standard_exclude_from_info(git_path_info_exclude(), dir);
> +			standard_exclude_from_info(git_worktree_info_exclude(), dir);
> +		} else {
> +			die(_("invalid value for '%s': '%s'"),
> +			      "extensions.worktreeIgnore", wt_ignore);
> +		}
>   	}
>   }
>   
> diff --git a/t/meson.build b/t/meson.build
> index 7528e5cda5..30624b59e8 100644
> --- a/t/meson.build
> +++ b/t/meson.build
> @@ -307,6 +307,7 @@ integration_tests = [
>     't2405-worktree-submodule.sh',
>     't2406-worktree-repair.sh',
>     't2407-worktree-heads.sh',
> +  't2408-worktree-ignore.sh',
>     't2500-untracked-overwriting.sh',
>     't2501-cwd-empty.sh',
>     't3000-ls-files-others.sh',
> diff --git a/t/t2408-worktree-ignore.sh b/t/t2408-worktree-ignore.sh
> new file mode 100755
> index 0000000000..67644ddd8d
> --- /dev/null
> +++ b/t/t2408-worktree-ignore.sh
> @@ -0,0 +1,50 @@
> +#!/bin/sh
> +
> +test_description='extensions.worktreeIgnore'
> +
> +. ./test-lib.sh
> +
> +test_expect_success 'setup' '
> +	test_commit init &&
> +	git worktree add wt &&
> +	echo main >.git/info/exclude &&
> +	echo contents >main &&
> +	echo contents >wt/main &&
> +	wt_exclude="$(git -C wt rev-parse --git-dir)"/info/exclude &&
> +	mkdir -p "$(dirname "$wt_exclude")" &&
> +	echo worktree >"$wt_exclude" &&
> +	echo contents >worktree &&
> +	echo contents >wt/worktree
> +'
> +
> +test_ignore_main() {
> +	git check-ignore main &&
> +	git -C wt check-ignore main
> +}
> +
> +test_expect_success 'ignores main items by default' '
> +	test_ignore_main
> +'
> +
> +test_expect_success 'ignores main items with extensions.worktreeIgnore=no' '
> +	test_config extensions.worktreeIgnore no &&
> +	test_ignore_main
> +'
> +
> +test_expect_success 'ignores worktree items with extensions.worktreeIgnore=worktree' '
> +	test_config extensions.worktreeIgnore worktree &&
> +	git check-ignore main &&
> +	! git check-ignore worktree &&
> +	! git -C wt check-ignore main &&
> +	git -C wt check-ignore worktree
> +'
> +
> +test_expect_success 'ignores all items with extensions.worktreeIgnore=merge' '
> +	test_config extensions.worktreeIgnore merge &&
> +	git check-ignore main &&
> +	! git check-ignore worktree &&
> +	git -C wt check-ignore main &&
> +	git -C wt check-ignore worktree
> +'
> +
> +test_done
> 
> base-commit: 4f69b47b940100b02630f745a52f9d9850f122b2

