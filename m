Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 557A42E62C0
	for <git@vger.kernel.org>; Mon, 26 Jan 2026 21:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769462752; cv=none; b=MsGCQht7r2+/mW38WnOePUbzG0PbOlNLdS7hJVniYCIKfEv0YPvefOsL/ya/Kc4MsqmQkk7YLxmtjqhCMHwvomqBWGCBFuiNdmF/UcrxpWWhFjikCMvnRyfHByQQdtF13JVXbE9SKl7+3LqLRfgss+zyFIss8c2ZYzybD0iDt0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769462752; c=relaxed/simple;
	bh=0ynunUK3rMAhqDH6JsdlmdQzHbAN7fv6A/5kdMKbvF0=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=MT6tTXODHahu7qO/KWltJaOy6cnJqo/Nadfp2IiIEXPdA4S90UlJHs8+wF5tzK6nitGW722ogUK0xpk29RPBhzfp7PeDoHTWM56q5orl9/4LmB5xgKuctAQ4XThiwjXMPuuex6VH1C5qWE5S4XTB1Pk8jh+ttbtACYXlUGr9dxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HsZWukLE; arc=none smtp.client-ip=74.125.82.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HsZWukLE"
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-2b785801c93so919246eec.0
        for <git@vger.kernel.org>; Mon, 26 Jan 2026 13:25:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769462749; x=1770067549; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jUEFZhcM2RbPlBFStrLj1nxj/anDnS3bg+9/1TLBywk=;
        b=HsZWukLE3L9oc8x9Qp5toZrr7lTdHYF1JdiDGsKjwjuHVAn4Xj3fA2oQ6uSoBXV8a9
         OmXkP3imQFH8tGQ3E8FvSQ+FfBVazWBhttT72tzqn1E1YnJgXdlD5EG5AZafb7CY5wp3
         voQENRaIsLnLnLefBXw8vsdGV9YBJD4MpHvR4I4rcim2qwtDuU6Zz4U9UTbAWgW3ZdKh
         ng+xMMmgyzIi20VzONn+qyQp7ZgLCBJ536f4mtXX5bGMW2gp54+7fBrJzb4SIvzVAsTm
         Bi22/D1MQc43utLR68agGs49CzWNZZ2rQ/8tI4w2q7j3/nICuUyzAjy4Bl5OopODwqIt
         gQeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769462749; x=1770067549;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jUEFZhcM2RbPlBFStrLj1nxj/anDnS3bg+9/1TLBywk=;
        b=HVu09Pqn6ohoBdxhOd5xHuNtyI0ojpz5rMdIsm1KCRmHMPS1D64cUyqyWw4QN9ZVIw
         7UWuwsTySgYVx8pbCY8ZN4AasyBGck654f+VTr6TUy4qlGSvvsmUUXl0Jl0+BQ9uox4N
         8kZBouP/Yt8Ah5ynX0JEnFU/rEWCr5x6qsxsrwiwztGnw5hdHViTocahnNRjV/pk0Kjv
         avJnOYVRk8BtrICzxyOM2iO7CGea9FqD3EKdHuOmF1/rSa4Skl2wvXM6lBaIPzH8q9/i
         ZVxybXpF+/KW2tlU+r0HsUICjrOnOpHXy+shfZndS3LVE58FoEKm/m5vkwUx9jBE+111
         x6qQ==
X-Gm-Message-State: AOJu0YxHB/2c2foPUh+xjZr/xiYtZdnFUUCJ2BzUEeiCgJhKAiI+tAwK
	qJZZ5FdbJC80ucRpZsOrtAn5fyAsoScJ7dzwthiwYXLSS1U2Oy1SJka7bFX0Tg==
X-Gm-Gg: AZuq6aJ8l0a/n6vPNK0z1aNkc5Tm1w2J6k7Ye2wCYLrVftgF6l6PjhKjA3eqZEJ8dC7
	oIYXUeOjYshbaQfMuF4TEFslgDaQ2hkwFcrcrIS7O9lJlRhNG9qNIVO5JJGafQHW2rK7QDJ1HZ2
	oejd8s4zJWEG24JPSxamkL/e9tgtyJItXmeqMy30S3Re1P5Gj+X6ruGMC+k0WPqex23SwoGIFs/
	imEKXDW4EyBJ4TWLjbRlHvW/4NW1Qn9fYxkVvMbpjfzIHvBfmuxHdQplcHxcEOHYTqgZOB9/eWs
	Ovqf2UjZsIvZUD9cWlp7NkMn5j0+4Y29Q/Eugq8bVfiuy+8NHZK+jQA5lSDyV1KHxO79cH5FcEW
	xtKP50jvXmlLJd6JlJg7qsbcHcnvHWGj6ijOcOfO708usqPYidpSBzHsMDX8ZmdkGtkpPfcNVcz
	P8qIwPUaue6wRN
X-Received: by 2002:a05:693c:3018:b0:2b7:29b3:7954 with SMTP id 5a478bee46e88-2b764813596mr2574710eec.36.1769462748165;
        Mon, 26 Jan 2026 13:25:48 -0800 (PST)
Received: from [127.0.0.1] ([68.220.59.208])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b73a9fbdcesm16744448eec.25.2026.01.26.13.25.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jan 2026 13:25:47 -0800 (PST)
Message-Id: <05e68e28257cd450463d253abe9b2995759bdc10.1769462744.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2036.v2.git.1769462744.gitgitgadget@gmail.com>
References: <pull.2036.git.1769202903.gitgitgadget@gmail.com>
	<pull.2036.v2.git.1769462744.gitgitgadget@gmail.com>
From: "=?UTF-8?q?Jean-No=C3=ABl=20Avila?= via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 26 Jan 2026 21:25:41 +0000
Subject: [PATCH v2 1/4] convert git-submodule doc to synopsis style
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc: Sent
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
    =?UTF-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>,
    =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>

From: =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>

 * convert commands to synopsis style
 * use _<placeholder>_ for arguments
 * convert inline lists into proper definition lists
 * minor formatting fixes

Signed-off-by: Jean-Noël Avila <jn.avila@free.fr>
---
 Documentation/git-submodule.adoc | 369 ++++++++++++++++---------------
 1 file changed, 185 insertions(+), 184 deletions(-)

diff --git a/Documentation/git-submodule.adoc b/Documentation/git-submodule.adoc
index 95beaee561..188212508e 100644
--- a/Documentation/git-submodule.adoc
+++ b/Documentation/git-submodule.adoc
@@ -8,19 +8,19 @@ git-submodule - Initialize, update or inspect submodules
 
 SYNOPSIS
 --------
-[verse]
-'git submodule' [--quiet] [--cached]
-'git submodule' [--quiet] add [<options>] [--] <repository> [<path>]
-'git submodule' [--quiet] status [--cached] [--recursive] [--] [<path>...]
-'git submodule' [--quiet] init [--] [<path>...]
-'git submodule' [--quiet] deinit [-f|--force] (--all|[--] <path>...)
-'git submodule' [--quiet] update [<options>] [--] [<path>...]
-'git submodule' [--quiet] set-branch [<options>] [--] <path>
-'git submodule' [--quiet] set-url [--] <path> <newurl>
-'git submodule' [--quiet] summary [<options>] [--] [<path>...]
-'git submodule' [--quiet] foreach [--recursive] <command>
-'git submodule' [--quiet] sync [--recursive] [--] [<path>...]
-'git submodule' [--quiet] absorbgitdirs [--] [<path>...]
+[synopsis]
+git submodule [--quiet] [--cached]
+git submodule [--quiet] add [<options>] [--] <repository> [<path>]
+git submodule [--quiet] status [--cached] [--recursive] [--] [<path>...]
+git submodule [--quiet] init [--] [<path>...]
+git submodule [--quiet] deinit [-f|--force] (--all|[--] <path>...)
+git submodule [--quiet] update [<options>] [--] [<path>...]
+git submodule [--quiet] set-branch [<options>] [--] <path>
+git submodule [--quiet] set-url [--] <path> <newurl>
+git submodule [--quiet] summary [<options>] [--] [<path>...]
+git submodule [--quiet] foreach [--recursive] <command>
+git submodule [--quiet] sync [--recursive] [--] [<path>...]
+git submodule [--quiet] absorbgitdirs [--] [<path>...]
 
 
 DESCRIPTION
@@ -34,16 +34,16 @@ COMMANDS
 With no arguments, shows the status of existing submodules.  Several
 subcommands are available to perform operations on the submodules.
 
-add [-b <branch>] [-f|--force] [--name <name>] [--reference <repository>] [--ref-format <format>] [--depth <depth>] [--] <repository> [<path>]::
+`add [-b <branch>] [-f | --force] [--name <name>] [--reference <repository>] [--ref-format <format>] [--depth <depth>] [--] <repository> [<path>]`::
 	Add the given repository as a submodule at the given path
 	to the changeset to be committed next to the current
 	project: the current project is termed the "superproject".
 +
-<repository> is the URL of the new submodule's origin repository.
-This may be either an absolute URL, or (if it begins with ./
-or ../), the location relative to the superproject's default remote
-repository (Please note that to specify a repository 'foo.git'
-which is located right next to a superproject 'bar.git', you'll
+_<repository>_ is the URL of the new submodule's origin repository.
+This may be either an absolute URL, or (if it begins with `./`
+or `../`), the location relative to the superproject's default remote
+repository (Please note that to specify a repository `foo.git`
+which is located right next to a superproject `bar.git`, you'll
 have to use `../foo.git` instead of `./foo.git` - as one might expect
 when following the rules for relative URLs - because the evaluation
 of relative URLs in Git is identical to that of relative directories).
@@ -55,13 +55,13 @@ If the superproject doesn't have a default remote configured
 the superproject is its own authoritative upstream and the current
 working directory is used instead.
 +
-The optional argument <path> is the relative location for the cloned
-submodule to exist in the superproject. If <path> is not given, the
-canonical part of the source repository is used ("repo" for
-"/path/to/repo.git" and "foo" for "host.xz:foo/.git"). If <path>
+The optional argument _<path>_ is the relative location for the cloned
+submodule to exist in the superproject. If _<path>_ is not given, the
+canonical part of the source repository is used (`repo` for
+`/path/to/repo.git` and `foo` for `host.xz:foo/.git`). If _<path>_
 exists and is already a valid Git repository, then it is staged
-for commit without cloning. The <path> is also used as the submodule's
-logical name in its configuration entries unless `--name` is used
+for commit without cloning. The _<path>_ is also used as the submodule's
+logical name in its configuration entries unless `--name <name>` is used
 to specify a logical name.
 +
 The given URL is recorded into `.gitmodules` for use by subsequent users
@@ -75,10 +75,10 @@ URL in `.gitmodules`.
 If `--ref-format <format>`  is specified, the ref storage format of newly
 cloned submodules will be set accordingly.
 
-status [--cached] [--recursive] [--] [<path>...]::
+`status [--cached] [--recursive] [--] [<path>...]`::
 	Show the status of the submodules. This will print the SHA-1 of the
 	currently checked out commit for each submodule, along with the
-	submodule path and the output of 'git describe' for the
+	submodule path and the output of `git describe` for the
 	SHA-1. Each SHA-1 will possibly be prefixed with `-` if the submodule is
 	not initialized, `+` if the currently checked out submodule commit
 	does not match the SHA-1 found in the index of the containing
@@ -95,7 +95,7 @@ submodules with respect to the commit recorded in the index or the HEAD,
 linkgit:git-status[1] and linkgit:git-diff[1] will provide that information
 too (and can also report changes to a submodule's work tree).
 
-init [--] [<path>...]::
+`init [--] [<path>...]`::
 	Initialize the submodules recorded in the index (which were
 	added and committed elsewhere) by setting `submodule.$name.url`
 	in `.git/config`, using the same setting from `.gitmodules` as
@@ -103,7 +103,7 @@ init [--] [<path>...]::
 	the default remote. If there is no default remote, the current
 	repository will be assumed to be upstream.
 +
-Optional <path> arguments limit which submodules will be initialized.
+Optional _<path>_ arguments limit which submodules will be initialized.
 If no path is specified and submodule.active has been configured, submodules
 configured to be active will be initialized, otherwise all submodules are
 initialized.
@@ -116,12 +116,12 @@ that is set to a custom command is *not* copied for security reasons.
 You can then customize the submodule clone URLs in `.git/config`
 for your local setup and proceed to `git submodule update`;
 you can also just use `git submodule update --init` without
-the explicit 'init' step if you do not intend to customize
+the explicit `init` step if you do not intend to customize
 any submodule locations.
 +
 See the add subcommand for the definition of default remote.
 
-deinit [-f|--force] (--all|[--] <path>...)::
+`deinit [-f | --force] (--all|[--] <path>...)`::
 	Unregister the given submodules, i.e. remove the whole
 	`submodule.$name` section from .git/config together with their work
 	tree. Further calls to `git submodule update`, `git submodule foreach`
@@ -139,7 +139,7 @@ If you really want to remove a submodule from the repository and commit
 that use linkgit:git-rm[1] instead. See linkgit:gitsubmodules[7] for removal
 options.
 
-update [--init] [--remote] [-N|--no-fetch] [--[no-]recommend-shallow] [-f|--force] [--checkout|--rebase|--merge] [--reference <repository>] [--ref-format <format>] [--depth <depth>] [--recursive] [--jobs <n>] [--[no-]single-branch] [--filter <filter-spec>] [--] [<path>...]::
+`update [--init] [--remote] [-N | --no-fetch] [--[no-]recommend-shallow] [-f | --force] [--checkout | --rebase | --merge] [--reference <repository>] [--ref-format <format>] [--depth <depth>] [--recursive] [--jobs <n>] [--[no-]single-branch] [--filter <filter-spec>] [--] [<path>...]`::
 +
 --
 Update the registered submodules to match what the superproject
@@ -148,38 +148,38 @@ in submodules and updating the working tree of
 the submodules. The "updating" can be done in several ways depending
 on command line options and the value of `submodule.<name>.update`
 configuration variable. The command line option takes precedence over
-the configuration variable. If neither is given, a 'checkout' is performed.
+the configuration variable. If neither is given, a `checkout` is performed.
 (note: what is in `.gitmodules` file is irrelevant at this point;
 see `git submodule init` above for how `.gitmodules` is used).
-The 'update' procedures supported both from the command line as well as
+The `update` procedures supported both from the command line as well as
 through the `submodule.<name>.update` configuration are:
 
-	checkout;; the commit recorded in the superproject will be
-	    checked out in the submodule on a detached HEAD.
+`checkout`;; the commit recorded in the superproject will be
+checked out in the submodule on a detached HEAD.
 +
 If `--force` is specified, the submodule will be checked out (using
 `git checkout --force`), even if the commit specified
 in the index of the containing repository already matches the commit
 checked out in the submodule.
 
-	rebase;; the current branch of the submodule will be rebased
-	    onto the commit recorded in the superproject.
+`rebase`;; the current branch of the submodule will be rebased
+onto the commit recorded in the superproject.
 
-	merge;; the commit recorded in the superproject will be merged
-	    into the current branch in the submodule.
+`merge`;; the commit recorded in the superproject will be merged
+into the current branch in the submodule.
 
 The following update procedures have additional limitations:
 
-	custom command;; mechanism for running arbitrary commands with the
-	    commit ID as an argument. Specifically, if the
-	    `submodule.<name>.update` configuration variable is set to
-	    `!custom command`, the object name of the commit recorded in the
-	    superproject for the submodule is appended to the `custom command`
-	    string and executed. Note that this mechanism is not supported in
-	    the `.gitmodules` file or on the command line.
+`!<custom-command>`;; mechanism for running arbitrary commands with the
+commit ID as an argument. Specifically, if the
+`submodule.<name>.update` configuration variable is set to
+`!<custom-command>`, the object name of the commit recorded in the
+superproject for the submodule is appended to the _<custom-command>_
+string and executed. Note that this mechanism is not supported in
+the `.gitmodules` file or on the command line.
 
-	none;; the submodule is not updated. This update procedure is not
-	    allowed on the command line.
+`none`;; the submodule is not updated. This update procedure is not
+allowed on the command line.
 
 If the submodule is not yet initialized, and you just want to use the
 setting as stored in `.gitmodules`, you can automatically initialize the
@@ -195,20 +195,20 @@ If `--filter <filter-spec>` is specified, the given partial clone filter will be
 applied to the submodule. See linkgit:git-rev-list[1] for details on filter
 specifications.
 --
-set-branch (-b|--branch) <branch> [--] <path>::
-set-branch (-d|--default) [--] <path>::
-	Sets the default remote tracking branch for the submodule. The
+`set-branch (-b|--branch) <branch> [--] <path>`::
+`set-branch (-d|--default) [--] <path>`::
+	Set the default remote tracking branch for the submodule. The
 	`--branch` option allows the remote branch to be specified. The
-	`--default` option removes the submodule.<name>.branch configuration
-	key, which causes the tracking branch to default to the remote 'HEAD'.
+	`--default` option removes the `submodule.<name>.branch` configuration
+	key, which causes the tracking branch to default to the remote `HEAD`.
 
-set-url [--] <path> <newurl>::
-	Sets the URL of the specified submodule to <newurl>. Then, it will
+`set-url [--] <path> <newurl>`::
+	Set the URL of the specified submodule to _<newurl>_. Then, it will
 	automatically synchronize the submodule's new remote URL
 	configuration.
 
-summary [--cached|--files] [(-n|--summary-limit) <n>] [commit] [--] [<path>...]::
-	Show commit summary between the given commit (defaults to HEAD) and
+`summary [--cached | --files] [(-n|--summary-limit) <n>] [commit] [--] [<path>...]`::
+	Show commit summary between the given commit (defaults to `HEAD`) and
 	working tree/index. For a submodule in question, a series of commits
 	in the submodule between the given super project commit and the
 	index or working tree (switched by `--cached`) are shown. If the option
@@ -220,27 +220,31 @@ summary [--cached|--files] [(-n|--summary-limit) <n>] [commit] [--] [<path>...]:
 Using the `--submodule=log` option with linkgit:git-diff[1] will provide that
 information too.
 
-foreach [--recursive] <command>::
-	Evaluates an arbitrary shell command in each checked out submodule.
-	The command has access to the variables $name, $sm_path, $displaypath,
-	$sha1 and $toplevel:
-	$name is the name of the relevant submodule section in `.gitmodules`,
-	$sm_path is the path of the submodule as recorded in the immediate
-	superproject, $displaypath contains the relative path from the
-	current working directory to the submodules root directory,
-	$sha1 is the commit as recorded in the immediate
-	superproject, and $toplevel is the absolute path to the top-level
-	of the immediate superproject.
-	Note that to avoid conflicts with '$PATH' on Windows, the '$path'
-	variable is now a deprecated synonym of '$sm_path' variable.
-	Any submodules defined in the superproject but not checked out are
-	ignored by this command. Unless given `--quiet`, foreach prints the name
-	of each submodule before evaluating the command.
-	If `--recursive` is given, submodules are traversed recursively (i.e.
-	the given shell command is evaluated in nested submodules as well).
-	A non-zero return from the command in any submodule causes
-	the processing to terminate. This can be overridden by adding '|| :'
-	to the end of the command.
+`foreach [--recursive] <command>`::
+	Evaluate an arbitrary shell _<command>_ in each checked out submodule.
+	The command has access to the variables `$name`, `$sm_path`, `$displaypath`,
+	`$sha1` and `$toplevel`:
++
+--
+`$name`;; the name of the relevant submodule section in `.gitmodules`
+`$sm_path`;; the path of the submodule as recorded in the immediate
+	superproject
+`$displaypath`;; the relative path from the
+	current working directory to the submodules root directory
+`$sha1`;; the commit as recorded in the immediate superproject
+`$toplevel`;; the absolute path to the top-level of the immediate superproject.
+--
++
+Note that to avoid conflicts with `$PATH` on Windows, the `$path`
+variable is now a deprecated synonym of `$sm_path` variable.
+Any submodules defined in the superproject but not checked out are
+ignored by this command. Unless given `--quiet`, foreach prints the name
+of each submodule before evaluating the command.
+If `--recursive` is given, submodules are traversed recursively (i.e.
+the given shell command is evaluated in nested submodules as well).
+A non-zero return from the command in any submodule causes
+the processing to terminate. This can be overridden by adding ++||:++
+to the end of the command.
 +
 As an example, the command below will show the path and currently
 checked out commit for each submodule:
@@ -249,10 +253,10 @@ checked out commit for each submodule:
 git submodule foreach 'echo $sm_path `git rev-parse HEAD`'
 --------------
 
-sync [--recursive] [--] [<path>...]::
-	Synchronizes submodules' remote URL configuration setting
+`sync [--recursive] [--] [<path>...]`::
+	Synchronize submodules' remote URL configuration setting
 	to the value specified in `.gitmodules`. It will only affect those
-	submodules which already have a URL entry in .git/config (that is the
+	submodules which already have a URL entry in `.git/config` (that is the
 	case when they are initialized or freshly added). This is useful when
 	submodule URLs change upstream and you need to update your local
 	repositories accordingly.
@@ -263,12 +267,12 @@ sync [--recursive] [--] [<path>...]::
 If `--recursive` is specified, this command will recurse into the
 registered submodules, and sync any nested submodules within.
 
-absorbgitdirs::
+`absorbgitdirs`::
 	If a git directory of a submodule is inside the submodule,
 	move the git directory of the submodule into its superproject's
 	`$GIT_DIR/modules` path and then connect the git directory and
 	its working directory by setting the `core.worktree` and adding
-	a .git file pointing to the git directory embedded in the
+	a `.git` file pointing to the git directory embedded in the
 	superprojects git directory.
 +
 A repository that was cloned independently and later added as a submodule or
@@ -279,72 +283,70 @@ This command is recursive by default.
 
 OPTIONS
 -------
--q::
---quiet::
+`-q`::
+`--quiet`::
 	Only print error messages.
 
---progress::
-	This option is only valid for add and update commands.
-	Progress status is reported on the standard error stream
-	by default when it is attached to a terminal, unless -q
+`--progress`::
+	Report progress status on the standard error stream
+	by default when it is attached to a terminal, unless `-q`
 	is specified. This flag forces progress status even if the
-	standard error stream is not directed to a terminal.
+	standard error stream is not directed to a terminal. It is
+	only valid for `add` and `update` commands.
 
---all::
-	This option is only valid for the deinit command. Unregister all
-	submodules in the working tree.
+`--all`::
+	Unregister all submodules in the working tree. This option is only
+	valid for the `deinit` command.
 
--b <branch>::
---branch <branch>::
+`-b <branch>`::
+`--branch <branch>`::
 	Branch of repository to add as submodule.
 	The name of the branch is recorded as `submodule.<name>.branch` in
 	`.gitmodules` for `update --remote`.  A special value of `.` is used to
 	indicate that the name of the branch in the submodule should be the
 	same name as the current branch in the current repository.  If the
-	option is not specified, it defaults to the remote 'HEAD'.
-
--f::
---force::
-	This option is only valid for add, deinit and update commands.
-	When running add, allow adding an otherwise ignored submodule path.
-	This option is also used to bypass a check that the submodule's name
-	is not already in use. By default, 'git submodule add' will fail if
-	the proposed name (which is derived from the path) is already registered
-	for another submodule in the repository. Using '--force' allows the command
-	to proceed by automatically generating a unique name by appending a number
-	to the conflicting name (e.g., if a submodule named 'child' exists, it will
-	try 'child1', and so on).
-	When running deinit the submodule working trees will be removed even
-	if they contain local changes.
-	When running update (only effective with the checkout procedure),
-	throw away local changes in submodules when switching to a
-	different commit; and always run a checkout operation in the
-	submodule, even if the commit listed in the index of the
-	containing repository matches the commit checked out in the
-	submodule.
-
---cached::
-	This option is only valid for status and summary commands.  These
-	commands typically use the commit found in the submodule HEAD, but
-	with this option, the commit stored in the index is used instead.
-
---files::
-	This option is only valid for the summary command. This command
-	compares the commit in the index with that in the submodule HEAD
-	when this option is used.
-
--n::
---summary-limit::
-	This option is only valid for the summary command.
-	Limit the summary size (number of commits shown in total).
+	option is not specified, it defaults to the remote `HEAD`.
+
+`-f`::
+`--force`::
+	Force the command to proceed, even if it would otherwise fail.
+	This option is only valid for `add`, `deinit` and `update` commands.
+`add`;; allow adding an otherwise ignored submodule path.
+This option is also used to bypass a check that the submodule's name
+is not already in use. By default, `git submodule add` will fail if
+the proposed name (which is derived from the path) is already registered
+for another submodule in the repository. Using `--force` allows the command
+to proceed by automatically generating a unique name by appending a number
+to the conflicting name (e.g., if a submodule named 'child' exists, it will
+try 'child1', and so on).
+`deinit`;; the submodule working trees will be removed even
+if they contain local changes.
+`update`;; (only effective with the checkout procedure),
+throw away local changes in submodules when switching to a
+different commit; and always run a checkout operation in the
+submodule, even if the commit listed in the index of the
+containing repository matches the commit checked out in the
+submodule.
+
+`--cached`::
+	Use the index to determine the commit instead of the `HEAD`.
+	This option is only valid for `status` and `summary` commands.
+
+`--files`::
+	Make the `summary` command compare the commit in the index with that in
+	the submodule `HEAD`.
+
+`-n <n>`::
+`--summary-limit <n>`::
+	Limit the `summary` size (number of commits shown in total) to _<n>_.
 	Giving 0 will disable the summary; a negative number means unlimited
 	(the default). This limit only applies to modified submodules. The
 	size is always limited to 1 for added/deleted/typechanged submodules.
 
---remote::
-	This option is only valid for the update command.  Instead of using
-	the superproject's recorded SHA-1 to update the submodule, use the
-	status of the submodule's remote-tracking branch.  The remote used
+`--remote`::
+	Instead of using the superproject's recorded SHA-1 to update the
+	submodule, use the status of the submodule's remote-tracking branch.
+	This option is only valid for the `update` command. The remote used
 	is branch's remote (`branch.<name>.remote`), defaulting to `origin`.
 	The remote branch used defaults to the remote `HEAD`, but the branch
 	name may be overridden by setting the `submodule.<name>.branch`
@@ -363,7 +365,7 @@ SHA-1.  If you don't want to fetch, you should use `submodule update
 --remote --no-fetch`.
 +
 Use this option to integrate changes from the upstream subproject with
-your submodule's current HEAD.  Alternatively, you can run `git pull`
+your submodule's current `HEAD`.  Alternatively, you can run `git pull`
 from the submodule, which is equivalent except for the remote branch
 name: `update --remote` uses the default upstream repository and
 `submodule.<name>.branch`, while `git pull` uses the submodule's
@@ -372,51 +374,51 @@ to distribute the default upstream branch with the superproject and
 `branch.<name>.merge` if you want a more native feel while working in
 the submodule itself.
 
--N::
---no-fetch::
-	This option is only valid for the update command.
+`-N`::
+`--no-fetch`::
 	Don't fetch new objects from the remote site.
+	This option is only valid for the `update` command.
 
---checkout::
-	This option is only valid for the update command.
-	Checkout the commit recorded in the superproject on a detached HEAD
+`--checkout`::
+	This option is only valid for the `update` command.
+	Checkout the commit recorded in the superproject on a detached `HEAD`
 	in the submodule. This is the default behavior, the main use of
-	this option is to override `submodule.$name.update` when set to
+	this option is to override `submodule.<name>.update` when set to
 	a value other than `checkout`.
-	If the key `submodule.$name.update` is either not explicitly set or
+	If the key `submodule.<name>.update` is either not explicitly set or
 	set to `checkout`, this option is implicit.
 
---merge::
-	This option is only valid for the update command.
+`--merge`::
 	Merge the commit recorded in the superproject into the current branch
-	of the submodule. If this option is given, the submodule's HEAD will
+	of the submodule. This option is only valid for the `update` command.
+	If this option is given, the submodule's `HEAD` will
 	not be detached. If a merge failure prevents this process, you will
 	have to resolve the resulting conflicts within the submodule with the
 	usual conflict resolution tools.
-	If the key `submodule.$name.update` is set to `merge`, this option is
+	If the key `submodule.<name>.update` is set to `merge`, this option is
 	implicit.
 
---rebase::
+`--rebase`::
 	This option is only valid for the update command.
 	Rebase the current branch onto the commit recorded in the
 	superproject. If this option is given, the submodule's HEAD will not
 	be detached. If a merge failure prevents this process, you will have
 	to resolve these failures with linkgit:git-rebase[1].
-	If the key `submodule.$name.update` is set to `rebase`, this option is
+	If the key `submodule.<name>.update` is set to `rebase`, this option is
 	implicit.
 
---init::
-	This option is only valid for the update command.
-	Initialize all submodules for which "git submodule init" has not been
-	called so far before updating.
+`--init`::
+	Initialize all submodules for which `git submodule init` has not been
+	called so far before updating. 	This option is only valid for the `update`
+	command.
+
 
---name::
-	This option is only valid for the add command. It sets the submodule's
-	name to the given string instead of defaulting to its path. The name
+`--name <name>`::
+	Set the submodule's name to the given string instead of defaulting to its path. _<name>_
 	must be valid as a directory name and may not end with a '/'.
 
---reference <repository>::
-	This option is only valid for add and update commands.  These
+`--reference <repository>`::
+	This option is only valid for `add` and `update` commands.  These
 	commands sometimes need to clone a remote repository. In this case,
 	this option will be passed to the linkgit:git-clone[1] command.
 +
@@ -424,53 +426,52 @@ the submodule itself.
 for linkgit:git-clone[1]'s `--reference`, `--shared`, and `--dissociate`
 options carefully.
 
---dissociate::
+`--dissociate`::
 	This option is only valid for add and update commands.  These
 	commands sometimes need to clone a remote repository. In this case,
 	this option will be passed to the linkgit:git-clone[1] command.
 +
-*NOTE*: see the NOTE for the `--reference` option.
+*NOTE*: see the NOTE above for the `--reference` option.
 
---recursive::
-	This option is only valid for foreach, update, status and sync commands.
-	Traverse submodules recursively. The operation is performed not
+`--recursive`::
+	Traverse submodules recursively. This option is only valid for `foreach`,
+	`update`, `status` and `sync` commands. The operation is performed not
 	only in the submodules of the current repo, but also
 	in any nested submodules inside those submodules (and so on).
 
---depth::
-	This option is valid for add and update commands. Create a 'shallow'
-	clone with a history truncated to the specified number of revisions.
-	See linkgit:git-clone[1]
+`--depth <depth>`::
+	Create a 'shallow' clone with a history truncated to the _<depth>_ revisions.
+	This option is valid for `add` and `update` commands. See linkgit:git-clone[1]
 
---recommend-shallow::
---no-recommend-shallow::
-	This option is only valid for the update command.
+`--recommend-shallow`::
+`--no-recommend-shallow`::
+	This option is only valid for the `update` command.
 	The initial clone of a submodule will use the recommended
 	`submodule.<name>.shallow` as provided by the `.gitmodules` file
 	by default. To ignore the suggestions use `--no-recommend-shallow`.
 
--j <n>::
---jobs <n>::
-	This option is only valid for the update command.
-	Clone new submodules in parallel with as many jobs.
+`-j <n>`::
+`--jobs <n>`::
+	Clone new submodules in parallel with _<n>_ jobs.
+	This option is only valid for the `update` command.
 	Defaults to the `submodule.fetchJobs` option.
 
---single-branch::
---no-single-branch::
-	This option is only valid for the update command.
-	Clone only one branch during update: HEAD or one specified by --branch.
+`--single-branch`::
+`--no-single-branch`::
+	Clone only one branch during update: `HEAD` or one specified by `--branch`.
+	This option is only valid for the `update` command.
 
-<path>...::
+`<path>...`::
 	Paths to submodule(s). When specified this will restrict the command
 	to only operate on the submodules found at the specified paths.
-	(This argument is required with add).
+	(This argument is required with `add`).
 
 FILES
 -----
 When initializing submodules, a `.gitmodules` file in the top-level directory
-of the containing repository is used to find the url of each submodule.
+of the containing repository is used to find the URL of each submodule.
 This file should be formatted in the same way as `$GIT_DIR/config`. The key
-to each submodule url is "submodule.$name.url".  See linkgit:gitmodules[5]
+to each submodule URL is `submodule.<name>.url`.  See linkgit:gitmodules[5]
 for details.
 
 SEE ALSO
-- 
gitgitgadget

