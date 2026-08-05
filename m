Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2724E247280
	for <git@vger.kernel.org>; Wed,  5 Aug 2026 05:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785908845; cv=none; b=tXc39SV6w029cl8bPkvmkEac6CAgE/GWXQ248JmM5fx5AUkYeXpcIKekXouOAKZZWNtwUAK7JB+LEM4qM/OCvlFT+HdTiqDB1TP+GyH6Hg+Brt+vzHdr3+7BVC6h9BldwRrTbhTLDiVVk8WpfYXErYM/ndudqJdd8fgCNeOomDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785908845; c=relaxed/simple;
	bh=j0cl5ADKki3DTUrRWh9nwwnUBPYqViqX0j/dBnBFXrQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dkTS2imCy/mIi4NvhKrnWY2tUKR/1Otkd6GhHWI2JLyQo0GrGtI38a/4wg73al7iPoZnR+CBDbIkfgIc3d0kExTEBW11PSmYAM7YszX7rsJD1uq55zu0hqR3m4Bt9bqYHu+UUaMjNZixCLiGIhsPGKm0kacqO7vUDFdIG+azaJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HRIsg8oZ; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HRIsg8oZ"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4921eed3fa2so4100895e9.0
        for <git@vger.kernel.org>; Tue, 04 Aug 2026 22:47:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785908841; x=1786513641; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=46e8v0ujhpxXLRDH37y8tTiKxYvXPwcfSrQUDFLr+tE=;
        b=HRIsg8oZBdUzCch5IQapzMizjLddfFbNK5CJe5w5kaaW1JGMcAhInuayy60CTsEy6e
         5gVmNX6a4EznivX/LbMfiuuelQwBf3wXxjkw62AQ/l4OqrdjsNO3KOhyzFfsk7Oc67ZX
         CfzFQ7A24kndHDz8xFsnVYnWIrOso1UYM1S0vzu1jxb3mWXUCdy4RzHId4+C/q7z8jj6
         RymeV+fQJ/5mhcS0qs8ddvvrNYXqGOMjye/uZ3hIrk6nMakS8ZvfRcjY8yPdLBqwF+EV
         cuBJS1U/H7IFaEWKadSOomIjq+b4l+gqlR8K6qpiA7eKvKNpPOGd4Un/Em5Mdfuf8NkW
         qk8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785908841; x=1786513641;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=46e8v0ujhpxXLRDH37y8tTiKxYvXPwcfSrQUDFLr+tE=;
        b=c7wNDQ//Lkjdsbt50qtvbXqEasYLlGUQQy+Z8P7CqdNNgUEWjWoxO2RtlkbE+5mvWV
         1Pr9kIrZOZ8uUVCtF5sG4wJ0/dxF20q5zbRH33Z9HWBRvScu4k71u4g6gvP/F4yjEL/g
         Q+IbqFzmYPwZqp2gfGkkTfHPVOLNKqW7YIXMe6OmnfO2GazrNuRQA++VFLJjfuIEH5Q8
         y4FvgHm95YxRw031HcwpReVQe5VHbqEN3ho1RkvEWTMbEEAjWBeW6TUNPEaWTeB8Tfb3
         Ioky0gra6OgDfG2/fAOvecWYNzgpga6HcUejIW3O2iQh0tJpzYwi8Z+tDsWSEoFbkbdS
         N0mA==
X-Gm-Message-State: AOJu0YzhmZHCB/EqDc1MuCwbtwJ7tf1uwLzVcx8Xn9JWWuZRsxewt2Qm
	8tBY+s4ATt8AxQ7glCyJ416zbbkAi91QmHBGsvgpFB22FEJjzfhnsIf00RzADPo=
X-Gm-Gg: AR+sD12poLDl6zkUr3su1SZKhat8tJ+8W6g+i2judrVWi/feZuLbuRj0NYkwf9oyMcX
	JxmymQmuJeolUSM++cxqf/0B5gYM5Ytv/ajudqLYJZHSc9ACskMQpDt7BHQxA2Jpk7TBCkBDcE9
	ovjhwWbGbcGJQBV4aOLgZBGjABxu5QnquQoLic6/fnPUFZpeJXJ5UiAOMz1Hek7bgeoIyfVzTiF
	kJ1Yu7jL9Sw545LN7YFUmMq85hY0MCBHWGD7kN2eGhPwP5c5LUmxEVdtPsh9l4aa3sn7UnmL/Og
	dbQlsQPdzz2PxEK3rJ++CxygfGPl7S+J9odTz4titZExRcakO1ugjgR10xNSLWm0ui2aKELuMru
	d/6xiBXuliinximwO6m+vePYQSc0PmFZr5UxCF/kz24ugzrFtFWTJWRbqP/j1mmoyoapgmfr7dE
	C7LornweyJyUQqqza05tdk3P/Y84mUGE+qfA9FSOgT3HFNe9oc
X-Received: by 2002:a05:600c:1c25:b0:499:4e47:eaf2 with SMTP id 5b1f17b1804b1-4994e79dbf0mr44808325e9.6.1785908840944;
        Tue, 04 Aug 2026 22:47:20 -0700 (PDT)
Received: from kali ([197.230.48.178])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49949fc2b98sm158847905e9.2.2026.08.04.22.47.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 22:47:20 -0700 (PDT)
From: shrimech <eddinen77@gmail.com>
To: git@vger.kernel.org
Cc: shrimech <eddinen77@gmail.com>
Subject: [PATCH] add: remove interactive mode
Date: Wed,  5 Aug 2026 06:46:11 +0100
Message-ID: <20260805054611.128396-1-eddinen77@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove the --interactive (-i) option from git add and drop
its associated interactive-mode documentation.

The patch mode (--patch/-p) remains available for interactively
selecting hunks to stage.

Signed-off-by: shrimech <eddinen77@gmail.com>
---
 Documentation/git-add.adoc | 140 +++----------------------------------
 builtin/add.c              |  17 ++---
 2 files changed, 18 insertions(+), 139 deletions(-)

diff --git a/Documentation/git-add.adoc b/Documentation/git-add.adoc
index 941135dc63..89a6bbe309 100644
--- a/Documentation/git-add.adoc
+++ b/Documentation/git-add.adoc
@@ -8,7 +8,7 @@ git-add - Add file contents to the index
 SYNOPSIS
 --------
 [synopsis]
-git add [--verbose | -v] [--dry-run | -n] [--force | -f] [--interactive | -i] [--patch | -p]
+git add [--verbose | -v] [--dry-run | -n] [--force | -f] [--patch | -p]
 	[--edit | -e] [--[no-]all | -A | --[no-]ignore-removal | [--update | -u]] [--sparse]
 	[--intent-to-add | -N] [--refresh] [--ignore-errors] [--ignore-missing] [--renormalize]
 	[--chmod=(+|-)x] [--pathspec-from-file=<file> [--pathspec-file-nul]]
@@ -87,23 +87,12 @@ in linkgit:gitglossary[7].
 	be removed from the working tree without warning. See
 	linkgit:git-sparse-checkout[1] for more details.
 
-`-i`::
-`--interactive`::
-	Add modified contents in the working tree interactively to
-	the index. Optional path arguments may be supplied to limit
-	operation to a subset of the working tree. See ``Interactive
-	mode'' for details.
-
 `-p`::
 `--patch`::
 	Interactively choose hunks of patch between the index and the
 	work tree and add them to the index. This gives the user a chance
 	to review the difference before adding modified contents to the
 	index.
-+
-This effectively runs `add --interactive`, but bypasses the
-initial command menu and directly jumps to the `patch` subcommand.
-See ``Interactive mode'' for details.
 
 include::diff-context-options.adoc[]
 
@@ -171,123 +160,16 @@ for `git add --no-all <pathspec>...`, i.e. ignored removed files.
 	them, do not abort the operation, but continue adding the
 	others. The command shall still exit with non-zero status.
 	The configuration variable `add.ignoreErrors` can be set to
-	true to make this the default behaviour.
-
-`--ignore-missing`::
-	This option can only be used together with `--dry-run`. By using
-	this option the user can check if any of the given files would
-	be ignored, no matter if they are already present in the work
-	tree or not.
-
-`--no-warn-embedded-repo`::
-	By default, `git add` will warn when adding an embedded
-	repository to the index without using `git submodule add` to
-	create an entry in `.gitmodules`. This option will suppress the
-	warning (e.g., if you are manually performing operations on
-	submodules).
-
-`--renormalize`::
-	Apply the "clean" process freshly to all tracked files to
-	forcibly add them again to the index.  This is useful after
-	changing `core.autocrlf` configuration or the `text` attribute
-	in order to correct files added with wrong _CRLF/LF_ line endings.
-	This option implies `-u`. Lone CR characters are untouched, thus
-	while a _CRLF_ cleans to _LF_, a _CRCRLF_ sequence is only partially
-	cleaned to _CRLF_.
-
-`--chmod=(+|-)x`::
-	Override the executable bit of the added files.  The executable
-	bit is only changed in the index, the files on disk are left
-	unchanged.
-
-`--pathspec-from-file=<file>`::
-	Pathspec is passed in _<file>_ instead of commandline args. If
-	_<file>_ is exactly `-` then standard input is used. Pathspec
-	elements are separated by _LF_ or _CR/LF_. Pathspec elements can be
-	quoted as explained for the configuration variable `core.quotePath`
-	(see linkgit:git-config[1]). See also `--pathspec-file-nul` and
-	global `--literal-pathspecs`.
-
-`--pathspec-file-nul`::
-	Only meaningful with `--pathspec-from-file`. Pathspec elements are
-	separated with _NUL_ character and all other characters are taken
-	literally (including newlines and quotes).
-
-`--`::
-	This option can be used to separate command-line options from
-	the list of files, (useful when filenames might be mistaken
-	for command-line options).
-
-
-EXAMPLES
---------
-
-* Adds content from all ++*.txt++ files under `Documentation` directory
-  and its subdirectories:
-+
-------------
-$ git add Documentation/\*.txt
-------------
-+
-Note that the asterisk ++*++ is quoted from the shell in this
-example; this lets the command include the files from
-subdirectories of `Documentation/` directory.
-
-* Considers adding content from all ++git-*.sh++ scripts:
-+
-------------
-$ git add git-*.sh
-------------
-+
-Because this example lets the shell expand the asterisk (i.e. you are
-listing the files explicitly), it does not consider
-`subdir/git-foo.sh`.
-
-INTERACTIVE MODE
-----------------
-When the command enters the interactive mode, it shows the
-output of the 'status' subcommand, and then goes into its
-interactive command loop.
-
-The command loop shows the list of subcommands available, and
-gives a prompt "What now> ".  In general, when the prompt ends
-with a single '>', you can pick only one of the choices given
-and type return, like this:
-
-------------
-    *** Commands ***
-      1: status       2: update       3: revert       4: add untracked
-      5: patch        6: diff         7: quit         8: help
-    What now> 1
-------------
-
-You also could say `s` or `sta` or `status` above as long as the
-choice is unique.
-
-The main command loop has 6 subcommands (plus help and quit).
-
-status::
-
-   This shows the change between `HEAD` and index (i.e. what will be
-   committed if you say `git commit`), and between index and
-   working tree files (i.e. what you could stage further before
-   `git commit` using `git add`) for each path.  A sample output
-   looks like this:
-+
-------------
-              staged     unstaged path
-     1:       binary      nothing foo.png
-     2:     +403/-35        +1/-1 add-interactive.c
-------------
-+
-It shows that `foo.png` has differences from `HEAD` (but that is
-binary so line count cannot be shown) and there is no
-difference between indexed copy and the working tree
-version (if the working tree version were also different,
-'binary' would have been shown in place of 'nothing').  The
-other file, `add-interactive.c`, has 403 lines added
-and 35 lines deleted if you commit what is in the index, but
-working tree file has further modifications (one addition and
+	EDITING PATCHES
+	---------------
+
+	Invoking `git add -e` will open a patch in your editor; after the editor exits, the
+	result is applied to the index. You are free to make arbitrary changes
+	to the patch, but note that some changes may have confusing results, or
+	even result in a patch that cannot be applied.  If you want to abort the
+	operation entirely (i.e., stage nothing new in the index), simply delete
+	all lines of the patch. The list below describes some common things you
+	may see in a patch, and which editing operations make sense on them.
 one deletion).
 
 update::
diff --git a/builtin/add.c b/builtin/add.c
index 60ffbede2b..67d33b52a9 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -31,7 +31,7 @@ static const char * const builtin_add_usage[] = {
 	N_("git add [<options>] [--] <pathspec>..."),
 	NULL
 };
-static int patch_interactive, add_interactive, edit_interactive;
+static int patch_interactive, edit_interactive;
 static struct interactive_options interactive_opts = INTERACTIVE_OPTIONS_INIT;
 static int take_worktree_changes;
 static int add_renormalize;
@@ -255,7 +255,6 @@ static struct option builtin_add_options[] = {
 	OPT__DRY_RUN(&show_only, N_("dry run")),
 	OPT__VERBOSE(&verbose, N_("be verbose")),
 	OPT_GROUP(""),
-	OPT_BOOL('i', "interactive", &add_interactive, N_("interactive picking")),
 	OPT_BOOL('p', "patch", &patch_interactive, N_("select hunks interactively")),
 	OPT_BOOL(0, "auto-advance", &interactive_opts.auto_advance,
 		 N_("auto advance to the next file when selecting hunks interactively")),
@@ -408,21 +407,19 @@ int cmd_add(int argc,
 	if (interactive_opts.interhunkcontext < -1)
 		die(_("'%s' cannot be negative"), "--inter-hunk-context");
 
-	if (patch_interactive)
-		add_interactive = 1;
-	if (add_interactive) {
+	if (patch_interactive) {
 		if (show_only)
-			die(_("options '%s' and '%s' cannot be used together"), "--dry-run", "--interactive/--patch");
+			die(_("options '%s' and '%s' cannot be used together"), "--dry-run", "--patch");
 		if (pathspec_from_file)
-			die(_("options '%s' and '%s' cannot be used together"), "--pathspec-from-file", "--interactive/--patch");
+			die(_("options '%s' and '%s' cannot be used together"), "--pathspec-from-file", "--patch");
 		exit(interactive_add(repo, argv + 1, prefix, patch_interactive, &interactive_opts));
 	} else {
 		if (interactive_opts.context != -1)
-			die(_("the option '%s' requires '%s'"), "--unified", "--interactive/--patch");
+			die(_("the option '%s' requires '%s'"), "--unified", "--patch");
 		if (interactive_opts.interhunkcontext != -1)
-			die(_("the option '%s' requires '%s'"), "--inter-hunk-context", "--interactive/--patch");
+			die(_("the option '%s' requires '%s'"), "--inter-hunk-context", "--patch");
 		if (!interactive_opts.auto_advance)
-			die(_("the option '%s' requires '%s'"), "--no-auto-advance", "--interactive/--patch");
+			die(_("the option '%s' requires '%s'"), "--no-auto-advance", "--patch");
 	}
 
 	if (edit_interactive) {
-- 
2.53.0

