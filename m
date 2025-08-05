Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67AA629ACF1
	for <git@vger.kernel.org>; Tue,  5 Aug 2025 19:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754421056; cv=none; b=EzxTEp29N53MwC39eVwfGqVAi9FEdcEp4P7bIGGV10R297tYAyTcUieVdeAlURftlROLmWpWlnHi80kRMAJOrluzGGfiSzUe84nj0c3O1qlokwK2J/M2lZ0VrTRwV3olXubIfArVm9WLqOMTZ+6oiMtVHYj9loMQpmkiUpk4cHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754421056; c=relaxed/simple;
	bh=0oa2gMJHYnzb0gu7kVfRMFH06KtXwD/36c1WhrLZLqQ=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=K5otMfvhJreBgqV1bH6IABztYUObxEqKYpCUla//dY33oNAukXkL088KwCbLN9ppL7Mgx68u/bbFZYogWBTuVCCGiZr7+K5f9a3wXoUwc4Taj2GXsb9I/tO4ICVRAypqxUsnjU1CKOmPkNF9qEqMds1FEtwLzEK1elPeFvUi4S4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Veg4cEIf; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Veg4cEIf"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3b792b0b829so4791240f8f.3
        for <git@vger.kernel.org>; Tue, 05 Aug 2025 12:10:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754421051; x=1755025851; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hkOpgUxwO2FKWcKob1XFuyZn9Y/BXrg0B7y/z9ktw54=;
        b=Veg4cEIfOUaTqxheyt1lyA21qfgWy2Bt5xFhgEwDkAILlqCQh0POwwIVlLKnUwi7mS
         nqzylkQgGDQZYPdZ21t0AZSRFaLhRG49kuqWsVERZmxzsF1Bz2YSsQ42ow1uxZH4q3XO
         X9rhhseOne44QsZeusqFro9YDelZQEMqwT/2JvypPrYsoSuSHqTenACeE1oydKRPp0eo
         fXvyiNk4hejxRPVyMF7MNsu4ivSTiuldgEfByltH6ByOKMUPVriVFks/TquWR6ieb+2P
         Irk1xC1Pe0euyy3jVRpvRiII5qmEBSnzCCK5sk02zr5PvLwK3CbhNa+bkhU2gJnTEHPr
         Pbrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754421051; x=1755025851;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hkOpgUxwO2FKWcKob1XFuyZn9Y/BXrg0B7y/z9ktw54=;
        b=N4it+PEZUlK0H9ZOmkIDkWggW0//0gTrk9sE6amwmGJk2WQkpIR69/dW7eDsmW9tDo
         uoC3oPLSjYSwz1wf9nHHTC0Mek45TKDvQRanbH1LE7SMNjNUMEQ/BJve3kLA494X7oxD
         UiUzVAdCCzYOFEc5hlqyZZW/2QPm5ylDB3+DdZShb8FEFd9Pvge8R0xAZk4WlgsG9col
         2flppDITt587Q8MEga64l0BO+NqIyKYZKFVaYdSh7OIYZKwOylkYiR2mjG5nRe4JswPk
         IWq2xJCe/Q6n1kpEaWjEbRATeIPfD4SwTiMn5qVJgroXUsCMAmEFo10Sjs4nkvFXQdib
         BQZQ==
X-Gm-Message-State: AOJu0YymCnt9iCgWmgmmON199K0EXMHFKbxhhQ1Qwsj7nZ3AcdtWfsZk
	TdXMcy9hGM2ZY1MgltlyY8vY8lEVqbKBh1Z9UgnC+pRNnl3ToYpkzlAewxwsjw==
X-Gm-Gg: ASbGnctlATmpg2c7CNnEG1USN5q0iN3LokkfVjnAuem58o6LwNSeAcMdpQ7hBd7MYzc
	OvDFMVb/i/KdrgEm4XG3TTKgWgh9OP0b877vkJBcPOLn04XED1kBLOXhUKZPn9MM7BvegCrSYCl
	DC54GC7TbTw1+vzBFdwh/Aa2AoPM8IpBWiP2lZfFGf1HT19eVre+V2d1dmjXPKSWWVdV6Vloy0f
	ccamZJbcoTg5JzPCt1yd9zWwz3g68dXa8rgtuvP+urUa4ml3/Px14s7mezhZqawnkJKPK4DpJHb
	Hl01hPYTSSmVFe4MGDN5Iux0ZJ0dq5S+ZMxh3DVPyt0Qi7ir4spJYBlmv2qfjw3S66V3lOqqZ6O
	y3uc+P/xR3d9r09i5SoX1V/Y=
X-Google-Smtp-Source: AGHT+IHRTuswbhWfkZzw825i5iju48+ssjJ6YHSjH6dYTP4BjTKhsmLgGlIq/vSzXjrW/SY7/7vLPQ==
X-Received: by 2002:a5d:5f53:0:b0:3b8:d3ae:26e with SMTP id ffacd0b85a97d-3b8f419c18bmr134887f8f.53.1754421051010;
        Tue, 05 Aug 2025 12:10:51 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-459e075805csm56955045e9.4.2025.08.05.12.10.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Aug 2025 12:10:50 -0700 (PDT)
Message-Id: <03a8428849f9a464d6480eae5ea182b95bd61027.1754421046.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1945.v2.git.1754421045.gitgitgadget@gmail.com>
References: <pull.1945.git.1754399033.gitgitgadget@gmail.com>
	<pull.1945.v2.git.1754421045.gitgitgadget@gmail.com>
From: "=?UTF-8?q?Jean-No=C3=ABl=20Avila?= via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 05 Aug 2025 19:10:43 +0000
Subject: [PATCH v2 4/6] doc: check for absence of the form --[no-]parameter
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

For better searchability, this commit adds a check to ensure that parameters
expressed in the form of `--[no-]parameter` are not used in the
documentation.  In the place of such parameters, the documentation should
list two separate parameters: `--parameter` and `--no-parameter`.

Signed-off-by: Jean-Noël Avila <jn.avila@free.fr>
---
 Documentation/blame-options.adoc            |  3 ++-
 Documentation/diff-options.adoc             |  3 ++-
 Documentation/fetch-options.adoc            | 15 +++++++----
 Documentation/git-am.adoc                   |  3 ++-
 Documentation/git-backfill.adoc             |  3 ++-
 Documentation/git-cat-file.adoc             |  6 +++--
 Documentation/git-check-ref-format.adoc     |  3 ++-
 Documentation/git-clone.adoc                | 12 ++++++---
 Documentation/git-commit-graph.adoc         |  3 ++-
 Documentation/git-commit.adoc               |  3 ++-
 Documentation/git-config.adoc               |  3 ++-
 Documentation/git-difftool.adoc             |  9 ++++---
 Documentation/git-fast-import.adoc          |  3 ++-
 Documentation/git-fmt-merge-msg.adoc        |  3 ++-
 Documentation/git-format-patch.adoc         | 12 ++++++---
 Documentation/git-fsck.adoc                 |  9 ++++---
 Documentation/git-gc.adoc                   |  6 +++--
 Documentation/git-index-pack.adoc           |  3 ++-
 Documentation/git-log.adoc                  |  6 +++--
 Documentation/git-merge-tree.adoc           |  3 ++-
 Documentation/git-multi-pack-index.adoc     |  3 ++-
 Documentation/git-pack-objects.adoc         |  3 ++-
 Documentation/git-pull.adoc                 |  3 ++-
 Documentation/git-push.adoc                 | 18 ++++++++-----
 Documentation/git-range-diff.adoc           |  3 ++-
 Documentation/git-read-tree.adoc            |  3 ++-
 Documentation/git-reset.adoc                |  3 ++-
 Documentation/git-send-email.adoc           | 30 ++++++++++++++-------
 Documentation/git-send-pack.adoc            |  3 ++-
 Documentation/git-submodule.adoc            |  6 +++--
 Documentation/git-update-index.adoc         | 12 ++++++---
 Documentation/git-upload-pack.adoc          |  3 ++-
 Documentation/git-worktree.adoc             | 12 ++++++---
 Documentation/lint-documentation-style.perl |  3 +++
 Documentation/merge-options.adoc            |  3 ++-
 Documentation/scalar.adoc                   | 18 ++++++++-----
 36 files changed, 159 insertions(+), 78 deletions(-)

diff --git a/Documentation/blame-options.adoc b/Documentation/blame-options.adoc
index 19ea1872388f..1fb948fc76f3 100644
--- a/Documentation/blame-options.adoc
+++ b/Documentation/blame-options.adoc
@@ -75,7 +75,8 @@ include::line-range-format.adoc[]
 	iso format is used. For supported values, see the discussion
 	of the --date option at linkgit:git-log[1].
 
---[no-]progress::
+--progress::
+--no-progress::
 	Progress status is reported on the standard error stream
 	by default when it is attached to a terminal. This flag
 	enables progress reporting even if not attached to a
diff --git a/Documentation/diff-options.adoc b/Documentation/diff-options.adoc
index f3a35d81411f..f19b85142f4e 100644
--- a/Documentation/diff-options.adoc
+++ b/Documentation/diff-options.adoc
@@ -505,7 +505,8 @@ endif::git-format-patch[]
 	Turn off rename detection, even when the configuration
 	file gives the default to do so.
 
-`--[no-]rename-empty`::
+`--rename-empty`::
+`--no-rename-empty`::
 	Whether to use empty blobs as rename source.
 
 ifndef::git-format-patch[]
diff --git a/Documentation/fetch-options.adoc b/Documentation/fetch-options.adoc
index b01372e4b3c6..d3ac31f4e2a1 100644
--- a/Documentation/fetch-options.adoc
+++ b/Documentation/fetch-options.adoc
@@ -1,4 +1,5 @@
---[no-]all::
+--all::
+--no-all::
 	Fetch all remotes, except for the ones that has the
 	`remote.<name>.skipFetchAll` configuration variable set.
 	This overrides the configuration variable fetch.all`.
@@ -88,7 +89,8 @@ This is incompatible with `--recurse-submodules=[yes|on-demand]` and takes
 precedence over the `fetch.output` config option.
 
 ifndef::git-pull[]
---[no-]write-fetch-head::
+--write-fetch-head::
+--no-write-fetch-head::
 	Write the list of remote refs fetched in the `FETCH_HEAD`
 	file directly under `$GIT_DIR`.  This is the default.
 	Passing `--no-write-fetch-head` from the command line tells
@@ -118,13 +120,16 @@ ifndef::git-pull[]
 	Allow several <repository> and <group> arguments to be
 	specified. No <refspec>s may be specified.
 
---[no-]auto-maintenance::
---[no-]auto-gc::
+--auto-maintenance::
+--no-auto-maintenance::
+--auto-gc::
+--no-auto-gc::
 	Run `git maintenance run --auto` at the end to perform automatic
 	repository maintenance if needed. (`--[no-]auto-gc` is a synonym.)
 	This is enabled by default.
 
---[no-]write-commit-graph::
+--write-commit-graph::
+--no-write-commit-graph::
 	Write a commit-graph after fetching. This overrides the config
 	setting `fetch.writeCommitGraph`.
 endif::git-pull[]
diff --git a/Documentation/git-am.adoc b/Documentation/git-am.adoc
index 221070de4812..b23b4fba2013 100644
--- a/Documentation/git-am.adoc
+++ b/Documentation/git-am.adoc
@@ -48,7 +48,8 @@ OPTIONS
 --keep-non-patch::
 	Pass `-b` flag to 'git mailinfo' (see linkgit:git-mailinfo[1]).
 
---[no-]keep-cr::
+--keep-cr::
+--no-keep-cr::
 	With `--keep-cr`, call 'git mailsplit' (see linkgit:git-mailsplit[1])
 	with the same option, to prevent it from stripping CR at the end of
 	lines. `am.keepcr` configuration variable can be used to specify the
diff --git a/Documentation/git-backfill.adoc b/Documentation/git-backfill.adoc
index 95623051f789..b8394dcf22b6 100644
--- a/Documentation/git-backfill.adoc
+++ b/Documentation/git-backfill.adoc
@@ -57,7 +57,8 @@ OPTIONS
 	blobs seen at a given path. The default minimum batch size is
 	50,000.
 
-`--[no-]sparse`::
+`--sparse`::
+`--no-sparse`::
 	Only download objects if they appear at a path that matches the
 	current sparse-checkout. If the sparse-checkout feature is enabled,
 	then `--sparse` is assumed and can be disabled with `--no-sparse`.
diff --git a/Documentation/git-cat-file.adoc b/Documentation/git-cat-file.adoc
index 180d1ad363fd..c139f55a168d 100644
--- a/Documentation/git-cat-file.adoc
+++ b/Documentation/git-cat-file.adoc
@@ -62,8 +62,10 @@ OPTIONS
 	or to ask for a "blob" with `<object>` being a tag object that
 	points at it.
 
---[no-]mailmap::
---[no-]use-mailmap::
+--mailmap::
+--no-mailmap::
+--use-mailmap::
+--no-use-mailmap::
        Use mailmap file to map author, committer and tagger names
        and email addresses to canonical real names and email addresses.
        See linkgit:git-shortlog[1].
diff --git a/Documentation/git-check-ref-format.adoc b/Documentation/git-check-ref-format.adoc
index 2aacfd18088d..0c3abf914657 100644
--- a/Documentation/git-check-ref-format.adoc
+++ b/Documentation/git-check-ref-format.adoc
@@ -98,7 +98,8 @@ a branch.
 
 OPTIONS
 -------
---[no-]allow-onelevel::
+--allow-onelevel::
+--no-allow-onelevel::
 	Controls whether one-level refnames are accepted (i.e.,
 	refnames that do not contain multiple `/`-separated
 	components).  The default is `--no-allow-onelevel`.
diff --git a/Documentation/git-clone.adoc b/Documentation/git-clone.adoc
index 222d558290ed..031b56f09824 100644
--- a/Documentation/git-clone.adoc
+++ b/Documentation/git-clone.adoc
@@ -272,7 +272,8 @@ corresponding `--mirror` and `--no-tags` options instead.
 	reachable from a specified remote branch or tag.  This option
 	can be specified multiple times.
 
-`--[no-]single-branch`::
+`--single-branch`::
+`--no-single-branch`::
 	Clone only the history leading to the tip of a single branch,
 	either specified by the `--branch` option or the primary
 	branch remote's `HEAD` points at.
@@ -282,7 +283,8 @@ corresponding `--mirror` and `--no-tags` options instead.
 	branch when `--single-branch` clone was made, no remote-tracking
 	branch is created.
 
-`--[no-]tags`::
+`--tags`::
+`--no-tags`::
 	Control whether or not tags will be cloned. When `--no-tags` is
 	given, the option will be become permanent by setting the
 	`remote.<remote>.tagOpt=--no-tags` configuration. This ensures that
@@ -313,10 +315,12 @@ the clone is finished. This option is ignored if the cloned repository does
 not have a worktree/checkout (i.e. if any of `--no-checkout`/`-n`, `--bare`,
 or `--mirror` is given)
 
-`--[no-]shallow-submodules`::
+`--shallow-submodules`::
+`--no-shallow-submodules`::
 	All submodules which are cloned will be shallow with a depth of 1.
 
-`--[no-]remote-submodules`::
+`--remote-submodules`::
+`--no-remote-submodules`::
 	All submodules which are cloned will use the status of the submodule's
 	remote-tracking branch to update the submodule, rather than the
 	superproject's recorded SHA-1. Equivalent to passing `--remote` to
diff --git a/Documentation/git-commit-graph.adoc b/Documentation/git-commit-graph.adoc
index 50b50168045c..e9558173c001 100644
--- a/Documentation/git-commit-graph.adoc
+++ b/Documentation/git-commit-graph.adoc
@@ -34,7 +34,8 @@ OPTIONS
 	object directory, `git commit-graph ...` will exit with non-zero
 	status.
 
---[no-]progress::
+--progress::
+--no-progress::
 	Turn progress on/off explicitly. If neither is specified, progress is
 	shown if standard error is connected to a terminal.
 
diff --git a/Documentation/git-commit.adoc b/Documentation/git-commit.adoc
index d4d576ce665f..54c207ad45ea 100644
--- a/Documentation/git-commit.adoc
+++ b/Documentation/git-commit.adoc
@@ -214,7 +214,8 @@ include::signoff-option.adoc[]
 	each trailer would appear, and other details.
 
 `-n`::
-`--[no-]verify`::
+`--verify`::
+`--no-verify`::
 	Bypass the `pre-commit` and `commit-msg` hooks.
 	See also linkgit:githooks[5].
 
diff --git a/Documentation/git-config.adoc b/Documentation/git-config.adoc
index 511b2e26bfb0..36d28451528e 100644
--- a/Documentation/git-config.adoc
+++ b/Documentation/git-config.adoc
@@ -295,7 +295,8 @@ Valid `<type>`'s include:
 	When the color setting for `name` is undefined, the command uses
 	`color.ui` as fallback.
 
---[no-]includes::
+--includes::
+--no-includes::
 	Respect `include.*` directives in config files when looking up
 	values. Defaults to `off` when a specific file is given (e.g.,
 	using `--file`, `--global`, etc) and `on` when searching all
diff --git a/Documentation/git-difftool.adoc b/Documentation/git-difftool.adoc
index d596205eaf3b..064bc683471f 100644
--- a/Documentation/git-difftool.adoc
+++ b/Documentation/git-difftool.adoc
@@ -77,7 +77,8 @@ with custom merge tool commands and has the same value as `$MERGED`.
 --tool-help::
 	Print a list of diff tools that may be used with `--tool`.
 
---[no-]symlinks::
+--symlinks::
+--no-symlinks::
 	'git difftool''s default behavior is to create symlinks to the
 	working tree when run in `--dir-diff` mode and the right-hand
 	side of the comparison yields the same content as the file in
@@ -94,7 +95,8 @@ instead.  `--no-symlinks` is the default on Windows.
 	Additionally, `$BASE` is set in the environment.
 
 -g::
---[no-]gui::
+--gui::
+--no-gui::
 	When 'git-difftool' is invoked with the `-g` or `--gui` option
 	the default diff tool will be read from the configured
 	`diff.guitool` variable instead of `diff.tool`. This may be
@@ -104,7 +106,8 @@ instead.  `--no-symlinks` is the default on Windows.
 	fallback in the order of `merge.guitool`, `diff.tool`,
 	`merge.tool` until a tool is found.
 
---[no-]trust-exit-code::
+--trust-exit-code::
+--no-trust-exit-code::
 	Errors reported by the diff tool are ignored by default.
 	Use `--trust-exit-code` to make 'git-difftool' exit when an
 	invoked diff tool returns a non-zero exit code.
diff --git a/Documentation/git-fast-import.adoc b/Documentation/git-fast-import.adoc
index 6490d67fab56..3144ffcdb689 100644
--- a/Documentation/git-fast-import.adoc
+++ b/Documentation/git-fast-import.adoc
@@ -111,7 +111,8 @@ Locations of Marks Files
 	Like --import-marks but instead of erroring out, silently
 	skips the file if it does not exist.
 
---[no-]relative-marks::
+--relative-marks::
+--no-relative-marks::
 	After specifying --relative-marks the paths specified
 	with --import-marks= and --export-marks= are relative
 	to an internal directory in the current repository.
diff --git a/Documentation/git-fmt-merge-msg.adoc b/Documentation/git-fmt-merge-msg.adoc
index 0f3328956dfd..6d91620be979 100644
--- a/Documentation/git-fmt-merge-msg.adoc
+++ b/Documentation/git-fmt-merge-msg.adoc
@@ -35,7 +35,8 @@ OPTIONS
 	Do not list one-line descriptions from the actual commits being
 	merged.
 
---[no-]summary::
+--summary::
+--no-summary::
 	Synonyms to --log and --no-log; these are deprecated and will be
 	removed in the future.
 
diff --git a/Documentation/git-format-patch.adoc b/Documentation/git-format-patch.adoc
index a8b53db9a663..048d1b981524 100644
--- a/Documentation/git-format-patch.adoc
+++ b/Documentation/git-format-patch.adoc
@@ -295,7 +295,8 @@ header). Note also that `git send-email` already handles this
 transformation for you, and this option should not be used if you are
 feeding the result to `git send-email`.
 
---[no-]force-in-body-from::
+--force-in-body-from::
+--no-force-in-body-from::
 	With the e-mail sender specified via the `--from` option, by
 	default, an in-body "From:" to identify the real author of
 	the commit is added at the top of the commit log message if
@@ -314,7 +315,8 @@ feeding the result to `git send-email`.
 	`Cc:`, and custom) headers added so far from config or command
 	line.
 
---[no-]cover-letter::
+--cover-letter::
+--no-cover-letter::
 	In addition to the patches, generate a cover letter file
 	containing the branch description, shortlog and the overall diffstat.  You can
 	fill in a description in the file before sending it out.
@@ -379,7 +381,8 @@ configuration options in linkgit:git-notes[1] to use this workflow).
 The default is `--no-notes`, unless the `format.notes` configuration is
 set.
 
---[no-]signature=<signature>::
+--signature=<signature>::
+--no-signature::
 	Add a signature to each message produced. Per RFC 3676 the signature
 	is separated from the body by a line with '-- ' on it. If the
 	signature option is omitted the signature defaults to the Git version
@@ -411,7 +414,8 @@ you can use `--suffix=-patch` to get `0001-description-of-my-change-patch`.
   Output an all-zero hash in each patch's From header instead
   of the hash of the commit.
 
---[no-]base[=<commit>]::
+--no-base::
+--base[=<commit>]::
 	Record the base tree information to identify the state the
 	patch series applies to.  See the BASE TREE INFORMATION section
 	below for details. If <commit> is "auto", a base commit is
diff --git a/Documentation/git-fsck.adoc b/Documentation/git-fsck.adoc
index 11203ba925c7..1751f692d42b 100644
--- a/Documentation/git-fsck.adoc
+++ b/Documentation/git-fsck.adoc
@@ -31,7 +31,8 @@ index file, all SHA-1 references in the `refs` namespace, and all reflogs
 	Print out objects that exist but that aren't reachable from any
 	of the reference nodes.
 
---[no-]dangling::
+--dangling::
+--no-dangling::
 	Print objects that exist but that are never 'directly' used (default).
 	`--no-dangling` can be used to omit this information from the output.
 
@@ -97,14 +98,16 @@ care about this output and want to speed it up further.
 	compatible with linkgit:git-rev-parse[1], e.g.
 	`HEAD@{1234567890}~25^2:src/`.
 
---[no-]progress::
+--progress::
+--no-progress::
 	Progress status is reported on the standard error stream by
 	default when it is attached to a terminal, unless
 	--no-progress or --verbose is specified. --progress forces
 	progress status even if the standard error stream is not
 	directed to a terminal.
 
---[no-]references::
+--references::
+--no-references::
 	Control whether to check the references database consistency
 	via 'git refs verify'. See linkgit:git-refs[1] for details.
 	The default is to check the references database.
diff --git a/Documentation/git-gc.adoc b/Documentation/git-gc.adoc
index 526ce01463d7..6fed646dd883 100644
--- a/Documentation/git-gc.adoc
+++ b/Documentation/git-gc.adoc
@@ -53,11 +53,13 @@ configuration options such as `gc.auto` and `gc.autoPackLimit`, all
 other housekeeping tasks (e.g. rerere, working trees, reflog...) will
 be performed as well.
 
---[no-]detach::
+--detach::
+--no-detach::
 	Run in the background if the system supports it. This option overrides
 	the `gc.autoDetach` config.
 
---[no-]cruft::
+--cruft::
+--no-cruft::
 	When expiring unreachable objects, pack them separately into a
 	cruft pack instead of storing them as loose objects. `--cruft`
 	is on by default.
diff --git a/Documentation/git-index-pack.adoc b/Documentation/git-index-pack.adoc
index 270056cf6352..18036953c06b 100644
--- a/Documentation/git-index-pack.adoc
+++ b/Documentation/git-index-pack.adoc
@@ -36,7 +36,8 @@ OPTIONS
 	fails if the name of packed archive does not end
 	with .pack).
 
---[no-]rev-index::
+--rev-index::
+--no-rev-index::
 	When this flag is provided, generate a reverse index
 	(a `.rev` file) corresponding to the given pack. If
 	`--verify` is given, ensure that the existing
diff --git a/Documentation/git-log.adoc b/Documentation/git-log.adoc
index b6f3d92c435f..e304739c5e80 100644
--- a/Documentation/git-log.adoc
+++ b/Documentation/git-log.adoc
@@ -73,8 +73,10 @@ used as decoration if they match `HEAD`, `refs/heads/`, `refs/remotes/`,
 	Print out the ref name given on the command line by which each
 	commit was reached.
 
-`--[no-]mailmap`::
-`--[no-]use-mailmap`::
+`--mailmap`::
+`--no-mailmap`::
+`--use-mailmap`::
+`--no-use-mailmap`::
 	Use mailmap file to map author and committer names and email
 	addresses to canonical real names and email addresses. See
 	linkgit:git-shortlog[1].
diff --git a/Documentation/git-merge-tree.adoc b/Documentation/git-merge-tree.adoc
index f824eea61f1e..271ab220e8d7 100644
--- a/Documentation/git-merge-tree.adoc
+++ b/Documentation/git-merge-tree.adoc
@@ -59,7 +59,8 @@ OPTIONS
 	do not list filenames multiple times if they have multiple
 	conflicting stages).
 
---[no-]messages::
+--messages::
+--no-messages::
 	Write any informational messages such as "Auto-merging <path>"
 	or CONFLICT notices to the end of stdout.  If unspecified, the
 	default is to include these messages if there are merge
diff --git a/Documentation/git-multi-pack-index.adoc b/Documentation/git-multi-pack-index.adoc
index b6cd0d7f855d..e8073bc27232 100644
--- a/Documentation/git-multi-pack-index.adoc
+++ b/Documentation/git-multi-pack-index.adoc
@@ -25,7 +25,8 @@ OPTIONS
 +
 `<dir>` must be an alternate of the current repository.
 
---[no-]progress::
+--progress::
+--no-progress::
 	Turn progress on/off explicitly. If neither is specified, progress is
 	shown if standard error is connected to a terminal. Supported by
 	sub-commands `write`, `verify`, `expire`, and `repack.
diff --git a/Documentation/git-pack-objects.adoc b/Documentation/git-pack-objects.adoc
index eba014c40615..71b9682485c3 100644
--- a/Documentation/git-pack-objects.adoc
+++ b/Documentation/git-pack-objects.adoc
@@ -243,7 +243,8 @@ depth is 4095.
 	Add --no-reuse-object if you want to force a uniform compression
 	level on all data no matter the source.
 
---[no-]sparse::
+--sparse::
+--no-sparse::
 	Toggle the "sparse" algorithm to determine which objects to include in
 	the pack, when combined with the "--revs" option. This algorithm
 	only walks trees that appear in paths that introduce new objects.
diff --git a/Documentation/git-pull.adoc b/Documentation/git-pull.adoc
index 3f4ecc47301a..48e924a10a40 100644
--- a/Documentation/git-pull.adoc
+++ b/Documentation/git-pull.adoc
@@ -87,7 +87,8 @@ OPTIONS
 --verbose::
 	Pass --verbose to git-fetch and git-merge.
 
---[no-]recurse-submodules[=(yes|on-demand|no)]::
+--recurse-submodules[=(yes|on-demand|no)]::
+--no-recurse-submodules::
 	This option controls if new commits of populated submodules should
 	be fetched, and if the working trees of active submodules should be
 	updated, too (see linkgit:git-fetch[1], linkgit:git-config[1] and
diff --git a/Documentation/git-push.adoc b/Documentation/git-push.adoc
index d1978650d60a..5f5408e2c01d 100644
--- a/Documentation/git-push.adoc
+++ b/Documentation/git-push.adoc
@@ -197,7 +197,8 @@ already exists on the remote side.
 	with configuration variable `push.followTags`.  For more
 	information, see `push.followTags` in linkgit:git-config[1].
 
---[no-]signed::
+--signed::
+--no-signed::
 --signed=(true|false|if-asked)::
 	GPG-sign the push request to update refs on the receiving
 	side, to allow it to be checked by the hooks and/or be
@@ -208,7 +209,8 @@ already exists on the remote side.
 	will also fail if the actual call to `gpg --sign` fails.  See
 	linkgit:git-receive-pack[1] for the details on the receiving end.
 
---[no-]atomic::
+--atomic::
+--no-atomic::
 	Use an atomic transaction on the remote side if available.
 	Either all refs are updated, or on error, no refs are updated.
 	If the server does not support atomic pushes the push will fail.
@@ -232,7 +234,8 @@ already exists on the remote side.
 	repository over ssh, and you do not have the program in
 	a directory on the default $PATH.
 
---[no-]force-with-lease::
+--force-with-lease::
+--no-force-with-lease::
 --force-with-lease=<refname>::
 --force-with-lease=<refname>:<expect>::
 	Usually, "git push" refuses to update a remote ref that is
@@ -350,7 +353,8 @@ one branch, use a `+` in front of the refspec to push (e.g `git push
 origin +master` to force a push to the `master` branch). See the
 `<refspec>...` section above for details.
 
---[no-]force-if-includes::
+--force-if-includes::
+--no-force-if-includes::
 	Force an update only if the tip of the remote-tracking ref
 	has been integrated locally.
 +
@@ -377,7 +381,8 @@ Specifying `--no-force-if-includes` disables this behavior.
 	linkgit:git-pull[1] and other commands. For more information,
 	see `branch.<name>.merge` in linkgit:git-config[1].
 
---[no-]thin::
+--thin::
+--no-thin::
 	These options are passed to linkgit:git-send-pack[1]. A thin transfer
 	significantly reduces the amount of sent data when the sender and
 	receiver share many of the same objects in common. The default is
@@ -419,7 +424,8 @@ When using 'on-demand' or 'only', if a submodule has a
 "push.recurseSubmodules={on-demand,only}" or "submodule.recurse" configuration,
 further recursion will occur. In this case, "only" is treated as "on-demand".
 
---[no-]verify::
+--verify::
+--no-verify::
 	Toggle the pre-push hook (see linkgit:githooks[5]).  The
 	default is --verify, giving the hook a chance to prevent the
 	push.  With --no-verify, the hook is bypassed completely.
diff --git a/Documentation/git-range-diff.adoc b/Documentation/git-range-diff.adoc
index db0e4279b528..b5e85d37f1be 100644
--- a/Documentation/git-range-diff.adoc
+++ b/Documentation/git-range-diff.adoc
@@ -96,7 +96,8 @@ diff.
 --remerge-diff::
 	Convenience option, equivalent to `--diff-merges=remerge`.
 
---[no-]notes[=<ref>]::
+--notes[=<ref>]::
+--no-notes::
 	This flag is passed to the `git log` program
 	(see linkgit:git-log[1]) that generates the patches.
 
diff --git a/Documentation/git-read-tree.adoc b/Documentation/git-read-tree.adoc
index 1c48c2899630..1c04bba2b7b8 100644
--- a/Documentation/git-read-tree.adoc
+++ b/Documentation/git-read-tree.adoc
@@ -100,7 +100,8 @@ OPTIONS
 	directories the index file and index output file are
 	located in.
 
---[no-]recurse-submodules::
+--recurse-submodules::
+--no-recurse-submodules::
 	Using --recurse-submodules will update the content of all active
 	submodules according to the commit recorded in the superproject by
 	calling read-tree recursively, also setting the submodules' HEAD to be
diff --git a/Documentation/git-reset.adoc b/Documentation/git-reset.adoc
index 50e8a0ba6f66..3b9ba9aee952 100644
--- a/Documentation/git-reset.adoc
+++ b/Documentation/git-reset.adoc
@@ -90,7 +90,8 @@ but carries forward unmerged index entries.
 	If a file that is different between _<commit>_ and `HEAD` has local
 	changes, reset is aborted.
 
-`--[no-]recurse-submodules`::
+`--recurse-submodules`::
+`--no-recurse-submodules`::
 	When the working tree is updated, using `--recurse-submodules` will
 	also recursively reset the working tree of all active submodules
 	according to the commit recorded in the superproject, also setting
diff --git a/Documentation/git-send-email.adoc b/Documentation/git-send-email.adoc
index 5335502d68fc..11b1ab1a070a 100644
--- a/Documentation/git-send-email.adoc
+++ b/Documentation/git-send-email.adoc
@@ -115,7 +115,8 @@ illustration below where `[PATCH v2 0/3]` is in reply to `[PATCH 0/2]`:
 Only necessary if `--compose` is also set.  If `--compose`
 is not set, this will be prompted for.
 
---[no-]outlook-id-fix::
+--outlook-id-fix::
+--no-outlook-id-fix::
 	Microsoft Outlook SMTP servers discard the Message-ID sent via email and
 	assign a new random Message-ID, thus breaking threads.
 +
@@ -350,7 +351,8 @@ Automating
 --no-header-cmd::
 	Disable any header command in use.
 
---[no-]chain-reply-to::
+--chain-reply-to::
+--no-chain-reply-to::
 	If this is set, each email will be sent as a reply to the previous
 	email sent.  If disabled with `--no-chain-reply-to`, all emails after
 	the first will be sent as replies to the first email sent.  When using
@@ -364,19 +366,22 @@ Automating
 	values in the `sendemail` section. The default identity is
 	the value of `sendemail.identity`.
 
---[no-]signed-off-by-cc::
+--signed-off-by-cc::
+--no-signed-off-by-cc::
 	If this is set, add emails found in the `Signed-off-by` trailer or `Cc:`
 	lines to the cc list. Default is the value of `sendemail.signedOffByCc`
 	configuration value; if that is unspecified, default to
 	`--signed-off-by-cc`.
 
---[no-]cc-cover::
+--cc-cover::
+--no-cc-cover::
 	If this is set, emails found in `Cc:` headers in the first patch of
 	the series (typically the cover letter) are added to the cc list
 	for each email set. Default is the value of `sendemail.ccCover`
 	configuration value; if that is unspecified, default to `--no-cc-cover`.
 
---[no-]to-cover::
+--to-cover::
+--no-to-cover::
 	If this is set, emails found in `To:` headers in the first patch of
 	the series (typically the cover letter) are added to the to list
 	for each email set. Default is the value of `sendemail.toCover`
@@ -407,12 +412,14 @@ Default is the value of `sendemail.suppressCc` configuration value; if
 that is unspecified, default to `self` if `--suppress-from` is
 specified, as well as `body` if `--no-signed-off-cc` is specified.
 
---[no-]suppress-from::
+--suppress-from::
+--no-suppress-from::
 	If this is set, do not add the `From:` address to the `Cc:` list.
 	Default is the value of `sendemail.suppressFrom` configuration
 	value; if that is unspecified, default to `--no-suppress-from`.
 
---[no-]thread::
+--thread::
+--no-thread::
 	If this is set, the `In-Reply-To` and `References` headers will be
 	added to each email sent.  Whether each mail refers to the
 	previous email (`deep` threading per `git format-patch`
@@ -430,7 +437,8 @@ exists when `git send-email` is asked to add it (especially note that
 Failure to do so may not produce the expected result in the
 recipient's MUA.
 
---[no-]mailmap::
+--mailmap::
+--no-mailmap::
 	Use the mailmap file (see linkgit:gitmailmap[5]) to map all
 	addresses to their canonical real name and email address. Additional
 	mailmap data specific to `git send-email` may be provided using the
@@ -459,7 +467,8 @@ have been specified, in which case default to `compose`.
 --dry-run::
 	Do everything except actually send the emails.
 
---[no-]format-patch::
+--format-patch::
+--no-format-patch::
 	When an argument may be understood either as a reference or as a file name,
 	choose to understand it as a format-patch argument (`--format-patch`)
 	or as a file name (`--no-format-patch`). By default, when such a conflict
@@ -469,7 +478,8 @@ have been specified, in which case default to `compose`.
 	Make `git send-email` less verbose.  One line per email should be
 	all that is output.
 
---[no-]validate::
+--validate::
+--no-validate::
 	Perform sanity checks on patches.
 	Currently, validation means the following:
 +
diff --git a/Documentation/git-send-pack.adoc b/Documentation/git-send-pack.adoc
index b9e73f2e77b1..811193f16c33 100644
--- a/Documentation/git-send-pack.adoc
+++ b/Documentation/git-send-pack.adoc
@@ -71,7 +71,8 @@ be in a separate packet, and the list must end with a flush packet.
 	fails to update then the entire push will fail without changing any
 	refs.
 
---[no-]signed::
+--signed::
+--no-signed::
 --signed=(true|false|if-asked)::
 	GPG-sign the push request to update refs on the receiving
 	side, to allow it to be checked by the hooks and/or be
diff --git a/Documentation/git-submodule.adoc b/Documentation/git-submodule.adoc
index 87d8e0f0c563..2d6ac92ea450 100644
--- a/Documentation/git-submodule.adoc
+++ b/Documentation/git-submodule.adoc
@@ -435,7 +435,8 @@ options carefully.
 	clone with a history truncated to the specified number of revisions.
 	See linkgit:git-clone[1]
 
---[no-]recommend-shallow::
+--recommend-shallow::
+--no-recommend-shallow::
 	This option is only valid for the update command.
 	The initial clone of a submodule will use the recommended
 	`submodule.<name>.shallow` as provided by the `.gitmodules` file
@@ -447,7 +448,8 @@ options carefully.
 	Clone new submodules in parallel with as many jobs.
 	Defaults to the `submodule.fetchJobs` option.
 
---[no-]single-branch::
+--single-branch::
+--no-single-branch::
 	This option is only valid for the update command.
 	Clone only one branch during update: HEAD or one specified by --branch.
 
diff --git a/Documentation/git-update-index.adoc b/Documentation/git-update-index.adoc
index 7128aed54058..9bea9fab9ad1 100644
--- a/Documentation/git-update-index.adoc
+++ b/Documentation/git-update-index.adoc
@@ -86,7 +86,8 @@ OPTIONS
 --chmod=(+|-)x::
         Set the execute permissions on the updated files.
 
---[no-]assume-unchanged::
+--assume-unchanged::
+--no-assume-unchanged::
 	When this flag is specified, the object names recorded
 	for the paths are not updated.  Instead, this option
 	sets/unsets the "assume unchanged" bit for the
@@ -108,18 +109,21 @@ you will need to handle the situation manually.
 	Like `--refresh`, but checks stat information unconditionally,
 	without regard to the "assume unchanged" setting.
 
---[no-]skip-worktree::
+--skip-worktree::
+--no-skip-worktree::
 	When one of these flags is specified, the object names recorded
 	for the paths are not updated. Instead, these options
 	set and unset the "skip-worktree" bit for the paths. See
 	section "Skip-worktree bit" below for more information.
 
 
---[no-]ignore-skip-worktree-entries::
+--ignore-skip-worktree-entries::
+--no-ignore-skip-worktree-entries::
 	Do not remove skip-worktree (AKA "index-only") entries even when
 	the `--remove` option was specified.
 
---[no-]fsmonitor-valid::
+--fsmonitor-valid::
+--no-fsmonitor-valid::
 	When one of these flags is specified, the object names recorded
 	for the paths are not updated. Instead, these options
 	set and unset the "fsmonitor valid" bit for the paths. See
diff --git a/Documentation/git-upload-pack.adoc b/Documentation/git-upload-pack.adoc
index 516d1639d9d0..9167a321d08e 100644
--- a/Documentation/git-upload-pack.adoc
+++ b/Documentation/git-upload-pack.adoc
@@ -25,7 +25,8 @@ repository.  For push operations, see 'git send-pack'.
 OPTIONS
 -------
 
---[no-]strict::
+--strict::
+--no-strict::
 	Do not try <directory>/.git/ if <directory> is not a Git directory.
 
 --timeout=<n>::
diff --git a/Documentation/git-worktree.adoc b/Documentation/git-worktree.adoc
index 8340b7f028e6..389e669ac044 100644
--- a/Documentation/git-worktree.adoc
+++ b/Documentation/git-worktree.adoc
@@ -200,13 +200,15 @@ To remove a locked worktree, specify `--force` twice.
 	With `add`, detach `HEAD` in the new worktree. See "DETACHED HEAD"
 	in linkgit:git-checkout[1].
 
---[no-]checkout::
+--checkout::
+--no-checkout::
 	By default, `add` checks out `<commit-ish>`, however, `--no-checkout` can
 	be used to suppress checkout in order to make customizations,
 	such as configuring sparse-checkout. See "Sparse checkout"
 	in linkgit:git-read-tree[1].
 
---[no-]guess-remote::
+--guess-remote::
+--no-guess-remote::
 	With `worktree add <path>`, without `<commit-ish>`, instead
 	of creating a new branch from `HEAD`, if there exists a tracking
 	branch in exactly one remote matching the basename of `<path>`,
@@ -216,7 +218,8 @@ To remove a locked worktree, specify `--force` twice.
 This can also be set up as the default behaviour by using the
 `worktree.guessRemote` config option.
 
---[no-]relative-paths::
+--relative-paths::
+--no-relative-paths::
 	Link worktrees using relative paths or absolute paths (default).
 	Overrides the `worktree.useRelativePaths` config option, see
 	linkgit:git-config[1].
@@ -224,7 +227,8 @@ This can also be set up as the default behaviour by using the
 With `repair`, the linking files will be updated if there's an absolute/relative
 mismatch, even if the links are correct.
 
---[no-]track::
+--track::
+--no-track::
 	When creating a new branch, if `<commit-ish>` is a branch,
 	mark it as "upstream" from the new branch.  This is the
 	default if `<commit-ish>` is a remote-tracking branch.  See
diff --git a/Documentation/lint-documentation-style.perl b/Documentation/lint-documentation-style.perl
index 1f35a6a116da..11321a151bca 100755
--- a/Documentation/lint-documentation-style.perl
+++ b/Documentation/lint-documentation-style.perl
@@ -18,6 +18,9 @@ while (my $line = <>) {
 
 		report($line, "multiple parameters in a definition list item");
 	}
+	if ($line =~ /^`?--\[no-\][a-z0-9-]+.*(::|;;)$/) {
+		report($line, "definition list item with a `--[no-]` parameter");
+	}
 }
 
 
diff --git a/Documentation/merge-options.adoc b/Documentation/merge-options.adoc
index 95ef491be109..9d433265b298 100644
--- a/Documentation/merge-options.adoc
+++ b/Documentation/merge-options.adoc
@@ -135,7 +135,8 @@ ifdef::git-pull[]
 Only useful when merging.
 endif::git-pull[]
 
-`--[no-]verify`::
+`--verify`::
+`--no-verify`::
 	By default, the pre-merge and commit-msg hooks are run.
 	When `--no-verify` is given, these are bypassed.
 	See also linkgit:githooks[5].
diff --git a/Documentation/scalar.adoc b/Documentation/scalar.adoc
index 4bd5b150e8e1..f81b2832f8df 100644
--- a/Documentation/scalar.adoc
+++ b/Documentation/scalar.adoc
@@ -71,7 +71,8 @@ HEAD[:<directory>]`.
 	Instead of checking out the branch pointed to by the cloned
 	repository's HEAD, check out the `<name>` branch instead.
 
---[no-]single-branch::
+--single-branch::
+--no-single-branch::
 	Clone only the history leading to the tip of a single branch, either
 	specified by the `--branch` option or the primary branch remote's
 	`HEAD` points at.
@@ -81,23 +82,27 @@ remote-tracking branch for the branch this option was used for the initial
 cloning. If the HEAD at the remote did not point at any branch when
 `--single-branch` clone was made, no remote-tracking branch is created.
 
---[no-]src::
+--src::
+--no-src::
 	By default, `scalar clone` places the cloned repository within a
 	`<entlistment>/src` directory. Use `--no-src` to place the cloned
 	repository directly in the `<enlistment>` directory.
 
---[no-]tags::
+--tags::
+--no-tags::
 	By default, `scalar clone` will fetch the tag objects advertised by
 	the remote and future `git fetch` commands will do the same. Use
 	`--no-tags` to avoid fetching tags in `scalar clone` and to configure
 	the repository to avoid fetching tags in the future. To fetch tags after
 	cloning with `--no-tags`, run `git fetch --tags`.
 
---[no-]full-clone::
+--full-clone::
+--no-full-clone::
 	A sparse-checkout is initialized by default. This behavior can be
 	turned off via `--full-clone`.
 
---[no-]maintenance::
+--maintenance::
+--no-maintenance::
 	By default, `scalar clone` configures the enlistment to use Git's
 	background maintenance feature. Use the `--no-maintenance` to skip
 	this configuration.
@@ -122,7 +127,8 @@ Note: when this subcommand is called in a worktree that is called `src/`, its
 parent directory is considered to be the Scalar enlistment. If the worktree is
 _not_ called `src/`, it itself will be considered to be the Scalar enlistment.
 
---[no-]maintenance::
+--maintenance::
+--no-maintenance::
 	By default, `scalar register` configures the enlistment to use Git's
 	background maintenance feature. Use the `--no-maintenance` to skip
 	this configuration. This does not disable any maintenance that may
-- 
gitgitgadget

