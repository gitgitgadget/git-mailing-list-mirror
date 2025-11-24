Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8F99274B26
	for <git@vger.kernel.org>; Mon, 24 Nov 2025 12:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763988542; cv=none; b=pbSBzXMaibAHO1K7SQDwijgbUrDqjhSB3m4ZzniX9E52WJGTwk2f8ZWyfVFmJx6pApQaIJJ3P+4pCylt07dWhc6QUhdekgj4eIZkyRbyhPZvQAWXikOmgPLHm2OiswNVFhkQFPpG16nFw4zuK/K8ahkiuGGjzYY+3XpTmXHTIjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763988542; c=relaxed/simple;
	bh=UnLFH4RHaWy9vjh3iNDcuKYWcq0fQWyaNrOfHc/o6WA=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=S27gFSGADCw2En2hRhaOAijb+BCk9n15XeAxf9RqRMW0gfO8aAOLqmOEAGWulHyJD9uBuDEuQqH6U2k+cTNypSQGcXua4342jJMezBUp8mhZ2ucZK4EpB0sN2y72aYXg2oITPRgLMKpW+PaUnIsTaFd09tI1Ye39ggdMwoLfJII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i55vK5g3; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i55vK5g3"
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-94900d3ef9bso168669039f.1
        for <git@vger.kernel.org>; Mon, 24 Nov 2025 04:49:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763988539; x=1764593339; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fHadoC9rc9lrfdpfSfUpGNrizrm31pZAEep5XpzUwUI=;
        b=i55vK5g38zuKxI0ZNvnUhb4fRlP/9toUX7l5jnZ7N4VUiKre+t4RC5ME/R+v80Olla
         qyUxEhbdut4D3VuNaf0AqjoPZu520CNk1QTYDIpCHjITL9yHXpf66y8L40S5pMfK3Uf6
         DQcTWEcT7TOVN2xRIDgT+OVH/CO49jasEPzFRd7vlHpnjN73O1tk7/DZ60Y156ogKHoN
         4lZ0Zpo3XRdZpYZQ2PEBbz8pi3CnurV0kq8vFMxHmPljLN6NYN4wlMZBea2chDGXpi5h
         B34skE6aCw0iKV+B0NknSgPGh5UswF7rzHX2EQGwRinYVOzIJZkoeh+X5BLgSEHRs6O8
         FYcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763988539; x=1764593339;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fHadoC9rc9lrfdpfSfUpGNrizrm31pZAEep5XpzUwUI=;
        b=phElf4nm2X+zVvZRNtrTHTWYbPtORqwP5kZQgOr/thdgaTPuBtWxtKSp0b2LlHLNqx
         562nat8Aa7ijPz7ykEG3av4bgsMQEVRtQQhyDWOVaTnb8GekRl2j5ULRHneORJ4ZlVGQ
         SDUIWk9QA5GaQLRU3PlPYwGqQyaun3iX+lcgxBo4ecI6XJ8WFFyWxqC75mV6mzr9iNnG
         IGc5uVYCb7ASPGymx4O37FPTO1Qqct74bvcE4HISTxwqL43CDSPAi1akxhjsyl0OMrmN
         bRK2sNTBPTJImKQaBLebT5k3pWNTBLfkgQubm29E/HfOhB0O2v85mAJaaB0U/zTE3Usq
         9/eg==
X-Gm-Message-State: AOJu0Yy6tEyZoVCCC+cCjeu9kJLdUGuleNXri/SS3+x42Xkq7dUeFzRt
	rvbUeUuBTT4hfiOtdpN8cLTNwOaH1JJ2vS3gp+pORjC7bDemgieIH+niC7KMKg==
X-Gm-Gg: ASbGnctYk0AFfeemeo7uCQsZXH0tc9wfXcbA0Jt5zvIt5KiWoTgfHGe4vthC4rV3xcf
	1iB5IMH+2izzxpRo8oRi7MAfu4dk9TvVCOvT2LKNhQ1bsdX2cyzHHAFme3kPfFpDKbAPv7EikCh
	sess/Kl37hL7+SEtpaSb/tkfsbW8BwvaD9SgzedtbPqXQC8jwqx4zyEq3DGb6/Nfj1RHscNtb8X
	F+I3AjyHR8tfH8MU7c1xq/U3gJ3g7rKz0nMdbwuY4qCwoj3nSNKhtbnY+t5XEEgK0XAWiRAUm3S
	qI3ncimgd5gGJmgfEa5r4r3ru3NjzvoNUaeN7xU7ROYwuH6s5slRzByEldIN8+z7Fw7rXB8gCyX
	g37WE7TMags6KctpZ8SmHG++t2XE/750rOTh4JV/hvjGmoFC+rvJuVnnOYbf9VjkXPcGRcHaVmE
	TiDwWjIi+R4/QO
X-Google-Smtp-Source: AGHT+IG24fH/DImHaqcTX8fxAcqKKuM4RXdUXBklY6WkU/GeTIKcFi1j7j4qKgQ19C7/gFU9NbO7kg==
X-Received: by 2002:a05:6638:37a2:b0:5b7:aba4:ccd5 with SMTP id 8926c6da1cb9f-5b967a01783mr8950160173.5.1763988539458;
        Mon, 24 Nov 2025 04:48:59 -0800 (PST)
Received: from [127.0.0.1] ([132.196.32.66])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5b954b590d2sm5586913173.60.2025.11.24.04.48.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Nov 2025 04:48:58 -0800 (PST)
Message-Id: <6e9ea103114ae7b5d6edb1232fac9e8aa4f9afa3.1763988532.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2002.v2.git.1763988532.gitgitgadget@gmail.com>
References: <pull.2002.git.1763588404.gitgitgadget@gmail.com>
	<pull.2002.v2.git.1763988532.gitgitgadget@gmail.com>
From: "=?UTF-8?q?Jean-No=C3=ABl=20Avila?= via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 24 Nov 2025 12:48:51 +0000
Subject: [PATCH v2 2/3] doc: convert git pull to synopsis style
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
Cc: =?UTF-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>,
    =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>

From: =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>

- Switch the synopsis to a synopsis block which will automatically
  format placeholders in italics and keywords in monospace
- Use _<placeholder>_ instead of <placeholder> in the description
- Use `backticks` for keywords and more complex option
descriptions. The new rendering engine will apply synopsis rules to
these spans.

Signed-off-by: Jean-Noël Avila <jn.avila@free.fr>
---
 Documentation/fetch-options.adoc | 10 +++---
 Documentation/git-pull.adoc      | 61 ++++++++++++++++----------------
 Documentation/merge-options.adoc |  2 +-
 Documentation/urls-remotes.adoc  |  4 +--
 4 files changed, 38 insertions(+), 39 deletions(-)

diff --git a/Documentation/fetch-options.adoc b/Documentation/fetch-options.adoc
index 35a84a1ef2..fcba46ee9e 100644
--- a/Documentation/fetch-options.adoc
+++ b/Documentation/fetch-options.adoc
@@ -71,7 +71,7 @@ configuration variables documented in linkgit:git-config[1], and the
 
 `--negotiate-only`::
 	Do not fetch anything from the server, and instead print the
-	ancestors of the provided `--negotiation-tip=*` arguments,
+	ancestors of the provided `--negotiation-tip=` arguments,
 	which we have in common with the server.
 +
 This is incompatible with `--recurse-submodules=(yes|on-demand)`.
@@ -126,7 +126,7 @@ ifndef::git-pull[]
 `--auto-gc`::
 `--no-auto-gc`::
 	Run `git maintenance run --auto` at the end to perform automatic
-	repository maintenance if needed. (`--[no-]auto-gc` is a synonym.)
+	repository maintenance if needed.
 	This is enabled by default.
 
 `--write-commit-graph`::
@@ -193,7 +193,7 @@ endif::git-pull[]
 	specified refspec (can be given more than once) to map the
 	refs to remote-tracking branches, instead of the values of
 	`remote.<name>.fetch` configuration variables for the remote
-	repository.  Providing an empty `<refspec>` to the
+	repository.  Providing an empty _<refspec>_ to the
 	`--refmap` option causes Git to ignore the configured
 	refspecs and rely entirely on the refspecs supplied as
 	command-line arguments. See section on "Configured Remote-tracking
@@ -204,7 +204,7 @@ endif::git-pull[]
 	Fetch all tags from the remote (i.e., fetch remote tags
 	`refs/tags/*` into local tags with the same name), in addition
 	to whatever else would otherwise be fetched.  Using this
-	option alone does not subject tags to pruning, even if --prune
+	option alone does not subject tags to pruning, even if `--prune`
 	is used (though tags may be pruned anyway if they are also the
 	destination of an explicit refspec; see `--prune`).
 
@@ -306,7 +306,7 @@ endif::git-pull[]
 `-o <option>`::
 `--server-option=<option>`::
 	Transmit the given string to the server when communicating using
-	protocol version 2.  The given string must not contain a NUL or LF
+	protocol version 2.  The given string must not contain a _NUL_ or _LF_
 	character.  The server's handling of server options, including
 	unknown ones, is server-specific.
 	When multiple `--server-option=<option>` are given, they are all
diff --git a/Documentation/git-pull.adoc b/Documentation/git-pull.adoc
index cd3bbc90e3..248f6c3f39 100644
--- a/Documentation/git-pull.adoc
+++ b/Documentation/git-pull.adoc
@@ -8,8 +8,8 @@ git-pull - Fetch from and integrate with another repository or a local branch
 
 SYNOPSIS
 --------
-[verse]
-'git pull' [<options>] [<repository> [<refspec>...]]
+[synopsis]
+git pull [<options>] [<repository> [<refspec>...]]
 
 
 DESCRIPTION
@@ -43,7 +43,7 @@ want to handle, you can safely abort it with `git merge --abort` or `git
 OPTIONS
 -------
 
-<repository>::
+_<repository>_::
 	The "remote" repository to pull from.  This can be either
 	a URL (see the section <<URLS,GIT URLS>> below) or the name
 	of a remote (see the section <<REMOTES,REMOTES>> below).
@@ -52,29 +52,29 @@ Defaults to the configured upstream for the current branch, or `origin`.
 See <<UPSTREAM-BRANCHES,UPSTREAM BRANCHES>> below for more on how to
 configure upstreams.
 
-<refspec>::
+_<refspec>_::
 	Which branch or other reference(s) to fetch and integrate into the
 	current branch, for example `main` in `git pull origin main`.
 	Defaults to the configured upstream for the current branch.
 +
 This can be a branch, tag, or other collection of reference(s).
-See <<fetch-refspec,<refspec>>> below under "Options related to fetching"
+See <<fetch-refspec,_<refspec>_>> below under "Options related to fetching"
 for the full syntax, and <<DEFAULT-BEHAVIOUR,DEFAULT BEHAVIOUR>> below
 for how `git pull` uses this argument to determine which remote branch
 to integrate.
 
--q::
---quiet::
+`-q`::
+`--quiet`::
 	This is passed to both underlying git-fetch to squelch reporting of
 	during transfer, and underlying git-merge to squelch output during
 	merging.
 
--v::
---verbose::
-	Pass --verbose to git-fetch and git-merge.
+`-v`::
+`--verbose`::
+	Pass `--verbose` to git-fetch and git-merge.
 
---recurse-submodules[=(yes|on-demand|no)]::
---no-recurse-submodules::
+`--recurse-submodules[=(yes|on-demand|no)]`::
+`--no-recurse-submodules`::
 	This option controls if new commits of populated submodules should
 	be fetched, and if the working trees of active submodules should be
 	updated, too (see linkgit:git-fetch[1], linkgit:git-config[1] and
@@ -91,21 +91,20 @@ Options related to merging
 
 include::merge-options.adoc[]
 
--r::
---rebase[=(false|true|merges|interactive)]::
-	When true, rebase the current branch on top of the upstream
+`-r`::
+`--rebase[=(true|merges|false|interactive)]`::
+`true`;; rebase the current branch on top of the upstream
 	branch after fetching. If there is a remote-tracking branch
 	corresponding to the upstream branch and the upstream branch
 	was rebased since last fetched, the rebase uses that information
-	to avoid rebasing non-local changes.
-+
-When set to `merges`, rebase using `git rebase --rebase-merges` so that
+	to avoid rebasing non-local changes. This is the default.
+
+`merges`;; rebase using `git rebase --rebase-merges` so that
 the local merge commits are included in the rebase (see
 linkgit:git-rebase[1] for details).
-+
-When false, merge the upstream branch into the current branch.
-+
-When `interactive`, enable the interactive mode of rebase.
+`false`;; merge the upstream branch into the current branch.
+`interactive`;; enable the interactive mode of rebase.
+
 +
 See `pull.rebase`, `branch.<name>.rebase` and `branch.autoSetupRebase` in
 linkgit:git-config[1] if you want to make `git pull` always use
@@ -117,8 +116,8 @@ It rewrites history, which does not bode well when you
 published that history already.  Do *not* use this option
 unless you have read linkgit:git-rebase[1] carefully.
 
---no-rebase::
-	This is shorthand for --rebase=false.
+`--no-rebase`::
+	This is shorthand for `--rebase=false`.
 
 Options related to fetching
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~
@@ -178,7 +177,7 @@ uses the refspec from the configuration or
 rules apply:
 
 . If `branch.<name>.merge` configuration for the current
-  branch `<name>` exists, that is the name of the branch at the
+  branch _<name>_ exists, that is the name of the branch at the
   remote site that is merged.
 
 . If the refspec is a globbing one, nothing is merged.
@@ -198,9 +197,9 @@ $ git pull
 $ git pull origin
 ------------------------------------------------
 +
-Normally the branch merged in is the HEAD of the remote repository,
-but the choice is determined by the branch.<name>.remote and
-branch.<name>.merge options; see linkgit:git-config[1] for details.
+Normally the branch merged in is the `HEAD` of the remote repository,
+but the choice is determined by the `branch.<name>.remote` and
+`branch.<name>.merge` options; see linkgit:git-config[1] for details.
 
 * Merge into the current branch the remote branch `next`:
 +
@@ -208,7 +207,7 @@ branch.<name>.merge options; see linkgit:git-config[1] for details.
 $ git pull origin next
 ------------------------------------------------
 +
-This leaves a copy of `next` temporarily in FETCH_HEAD, and
+This leaves a copy of `next` temporarily in `FETCH_HEAD`, and
 updates the remote-tracking branch `origin/next`.
 The same can be done by invoking fetch and merge:
 +
@@ -219,14 +218,14 @@ $ git merge origin/next
 
 
 If you tried a pull which resulted in complex conflicts and
-would want to start over, you can recover with 'git reset'.
+would want to start over, you can recover with `git reset`.
 
 
 include::transfer-data-leaks.adoc[]
 
 BUGS
 ----
-Using --recurse-submodules can only fetch new commits in already checked
+Using `--recurse-submodules` can only fetch new commits in already checked
 out submodules right now. When e.g. upstream added a new submodule in the
 just fetched commits of the superproject the submodule itself cannot be
 fetched, making it impossible to check out that submodule later without
diff --git a/Documentation/merge-options.adoc b/Documentation/merge-options.adoc
index 9d433265b2..952cb85e9a 100644
--- a/Documentation/merge-options.adoc
+++ b/Documentation/merge-options.adoc
@@ -56,7 +56,7 @@ ifdef::git-pull[]
 `--ff-only`::
 	Only update to the new history if there is no divergent local
 	history.  This is the default when no method for reconciling
-	divergent histories is provided (via the --rebase=* flags).
+	divergent histories is provided (via the `--rebase` flags).
 
 `--ff`::
 `--no-ff`::
diff --git a/Documentation/urls-remotes.adoc b/Documentation/urls-remotes.adoc
index 068b3ee4a6..6878bbe093 100644
--- a/Documentation/urls-remotes.adoc
+++ b/Documentation/urls-remotes.adoc
@@ -76,7 +76,7 @@ _<URL>_ is required; `#<head>` is optional.
 
 Depending on the operation, git will use one of the following
 refspecs, if you don't provide one on the command line.
-_<branch> is the name of this file in `$GIT_DIR/branches` and
+_<branch>_ is the name of this file in `$GIT_DIR/branches` and
 _<head>_ defaults to `master`.
 
 git fetch uses:
@@ -111,7 +111,7 @@ Git defaults to using the upstream branch for remote operations, for example:
   'origin/main' have diverged, and have 2 and 3 different commits each
   respectively".
 
-The upstream is stored in `.git/config`, in the "remote" and "merge"
+The upstream is stored in `.git/config`, in the "`remote`" and "`merge`"
 fields. For example, if `main`'s upstream is `origin/main`:
 
 ------------
-- 
gitgitgadget

