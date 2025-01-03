Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1EA4190049
	for <git@vger.kernel.org>; Fri,  3 Jan 2025 13:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735912054; cv=none; b=TyrrslqwarehkJCNOxuPqXPAlHtmhWglzpYrIQlXW2qCbM0JjsIotZkZuJ0NrYUeeGnUY5zA4TRgAHRJj951MuBTKKvDU6S6KO7XzU9IXqEgtZtcx98BILkL0ESUJUH+aCW2AdTqw9wbnPoX4iv/aPmhIW01l3KtHZr7kjj3YNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735912054; c=relaxed/simple;
	bh=XNBHMWsC8RNHtbtQ2k+xAg1NeBTqb1551pt0spkUrd8=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=q7Xr+ZE+/wqE5WIddiRT8TS4CByOA8Ywl/WWjXZLMNQnfMFKckIEI0lSBEXEDqp2AyMn1XwdMTHCazVaxB6wUthMPltgFQzl/SKogUeHBrn8BUeRyYAfvqOKamqz3z1hjoHgAoHwL7Xaa1LPJyc4RWO/+wzvKIoylZERYrYVRNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V98P3evO; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V98P3evO"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3862d6d5765so7231964f8f.3
        for <git@vger.kernel.org>; Fri, 03 Jan 2025 05:47:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735912049; x=1736516849; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uVLbIAgYJAcMSomx3ZSqQCouHc9oLA2j8Q4nfVaLsaI=;
        b=V98P3evOzj5SL0J9h3HqgjXvrjJxxEAheLQNdHwKC35KIFEL/UA5Pap44T4iyweNFv
         i3PuEYeY+0Tzlsp0agijfSqvWjCKc2vt0TKIs0ukEyhLjuyYFEVSEkCSDV76gMPG4Sl2
         BXsX18hFRoUk549BhM9JIj53AyYnS+mlCbfHCeGjZ3UCHlL3LkoVexFW8Zgia/2kr+oB
         njR7qaRD5t9o0Sb/HPUDWqb4Ocvty3axOCL6eA6o7y1bFC+kekRsZguNmDqGtgjbTStM
         dMqrlLeVd/lPgRgQR+mPsECS9McHKfJhdsJdvgEvx1pcoaeA2ghXG9rdTZjXdyQmeehu
         /Ndw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735912049; x=1736516849;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uVLbIAgYJAcMSomx3ZSqQCouHc9oLA2j8Q4nfVaLsaI=;
        b=hq8M2TvvCHqxuONJmm85v87VNsYji4CTZA/lxWp6xfkf45PNsI0DQAIviCwK0mY/YG
         8aV7/kcGlZt/bEp9wrMnj0+BoeB7Td+zEjpvGbnsxo6mnn2V3iyQXtuJsc2rjntZClL3
         Hyv6BjFgTNOJOgETv+OqKR1t2+c+4ZcloSVVFfEU8jBlXb7TF93JwP5DEZHyrI6XeYqw
         JZ50RDw8+jE+YQ8h6PDaoIV9WJHkvDGw1e4G3OAGuaWUJSH2QnlwOKQvMBMc8IhwG1fv
         o/oiDx0e+xTM+a5t02/W2/9RNR+EVeMjJGOdXcNgn3jDAQgHdmishZEmoCE+EQa/i5DA
         Z4vA==
X-Gm-Message-State: AOJu0Yxwc6cjtkweGohzzKEbfGCPt3waIW+TN0Xr1EMC0SdiWbPhU55x
	IEByF3UyBEF4Z++EHtwNCBO9hrlXjW00etOG8McgY/228vCMoE/NQYX+Xw==
X-Gm-Gg: ASbGnculgcHq7NL0V1WNuxbbUqLyHPBHtnCUHehkv/yMbwLa9fjeosBFOyUCnhRpjyJ
	zxmuQIhfYrx7VTM5g0hGagtlSOKMDwa4Gl+0jmgJGGKucRsFOqJBB8tSlOy7Xk/QPsQeZTEQPAP
	bckvCejzJ28wJEJ/TMh2GDwebEBr1IDGkubuGmW/rX/vyiXT1b2C9aTa19bw49GjsLyuoNIya97
	B2d7AewvJw2DrmnIgrNn/ROvvaqkhGI/IuDX1boR+akFGA4gS7TZs03uw==
X-Google-Smtp-Source: AGHT+IF+vtFJfXTkS62PyVtsXJ8QV5gkmaiTZzAu1t426FO9MlA3RKU7P5SNM2lysoOloerSKNhdJw==
X-Received: by 2002:a5d:64e9:0:b0:385:f062:c2df with SMTP id ffacd0b85a97d-38a221f3186mr43559571f8f.11.1735912048927;
        Fri, 03 Jan 2025 05:47:28 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a1c832e74sm40192642f8f.30.2025.01.03.05.47.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jan 2025 05:47:27 -0800 (PST)
Message-Id: <dfd907fc3147b438222bbfad9b0a7ca61df642a5.1735912046.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1845.git.1735912046.gitgitgadget@gmail.com>
References: <pull.1845.git.1735912046.gitgitgadget@gmail.com>
From: "=?UTF-8?q?Jean-No=C3=ABl=20Avila?= via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 03 Jan 2025 13:47:24 +0000
Subject: [PATCH 1/3] doc: git-commit: apply new documentation guidelines
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

The documentation for git-commit has been updated to follow the new
documentation guidelines. The following changes have been applied to
the series of patches:

- switching the synopsis to a synopsis block which will automatically
  format placeholders in italics and keywords in monospace
- use _<placeholder>_ instead of <placeholder> in the description
- use `backticks for keywords and more complex option
descriptions`. The new rendering engine will apply synopsis rules to
these spans.

Additionally, some option descriptions have been turned into
imperative mood to make them more consistent with the rest of the
documentation.

Signed-off-by: Jean-Noël Avila <jn.avila@free.fr>
---
 Documentation/git-commit.txt | 276 +++++++++++++++++------------------
 builtin/commit.c             |   2 +-
 2 files changed, 138 insertions(+), 140 deletions(-)

diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
index c822113c111..b08a398e31d 100644
--- a/Documentation/git-commit.txt
+++ b/Documentation/git-commit.txt
@@ -7,8 +7,8 @@ git-commit - Record changes to the repository
 
 SYNOPSIS
 --------
-[verse]
-'git commit' [-a | --interactive | --patch] [-s] [-v] [-u<mode>] [--amend]
+[synopsis]
+git commit [-a | --interactive | --patch] [-s] [-v] [-u[<mode>]] [--amend]
 	   [--dry-run] [(-c | -C | --squash) <commit> | --fixup [(amend|reword):]<commit>]
 	   [-F <file> | -m <msg>] [--reset-author] [--allow-empty]
 	   [--allow-empty-message] [--no-verify] [-e] [--author=<author>]
@@ -23,31 +23,31 @@ Create a new commit containing the current contents of the index and
 the given log message describing the changes. The new commit is a
 direct child of HEAD, usually the tip of the current branch, and the
 branch is updated to point to it (unless no branch is associated with
-the working tree, in which case HEAD is "detached" as described in
+the working tree, in which case `HEAD` is "detached" as described in
 linkgit:git-checkout[1]).
 
 The content to be committed can be specified in several ways:
 
 1. by using linkgit:git-add[1] to incrementally "add" changes to the
-   index before using the 'commit' command (Note: even modified files
+   index before using the `commit` command (Note: even modified files
    must be "added");
 
 2. by using linkgit:git-rm[1] to remove files from the working tree
-   and the index, again before using the 'commit' command;
+   and the index, again before using the `commit` command;
 
-3. by listing files as arguments to the 'commit' command
-   (without --interactive or --patch switch), in which
+3. by listing files as arguments to the `commit` command
+   (without `--interactive` or `--patch` switch), in which
    case the commit will ignore changes staged in the index, and instead
    record the current content of the listed files (which must already
    be known to Git);
 
-4. by using the -a switch with the 'commit' command to automatically
+4. by using the `-a` switch with the `commit` command to automatically
    "add" changes from all known files (i.e. all files that are already
    listed in the index) and to automatically "rm" files in the index
    that have been removed from the working tree, and then perform the
    actual commit;
 
-5. by using the --interactive or --patch switches with the 'commit' command
+5. by using the `--interactive` or `--patch` switches with the `commit` command
    to decide one by one which files or hunks should be part of the commit
    in addition to contents in the index,
    before finalizing the operation. See the ``Interactive Mode'' section of
@@ -58,139 +58,139 @@ summary of what is included by any of the above for the next
 commit by giving the same set of parameters (options and paths).
 
 If you make a commit and then find a mistake immediately after
-that, you can recover from it with 'git reset'.
+that, you can recover from it with `git reset`.
 
 :git-commit: 1
 
 OPTIONS
 -------
--a::
---all::
-	Tell the command to automatically stage files that have
+`-a`::
+`--all`::
+	Automatically stage files that have
 	been modified and deleted, but new files you have not
 	told Git about are not affected.
 
--p::
---patch::
+`-p`::
+`--patch`::
 	Use the interactive patch selection interface to choose
 	which changes to commit. See linkgit:git-add[1] for
 	details.
 
--C <commit>::
---reuse-message=<commit>::
-	Take an existing commit object, and reuse the log message
+`-C <commit>`::
+`--reuse-message=<commit>`::
+	Take an existing _<commit>_ object, and reuse the log message
 	and the authorship information (including the timestamp)
 	when creating the commit.
 
--c <commit>::
---reedit-message=<commit>::
-	Like '-C', but with `-c` the editor is invoked, so that
+`-c <commit>`::
+`--reedit-message=<commit>`::
+	Like `-C`, but with `-c` the editor is invoked, so that
 	the user can further edit the commit message.
 
---fixup=[(amend|reword):]<commit>::
-	Create a new commit which "fixes up" `<commit>` when applied with
+`--fixup=[(amend|reword):]<commit>`::
+	Create a new commit which "fixes up" _<commit>_ when applied with
 	`git rebase --autosquash`. Plain `--fixup=<commit>` creates a
-	"fixup!" commit which changes the content of `<commit>` but leaves
+	"fixup!" commit which changes the content of _<commit>_ but leaves
 	its log message untouched. `--fixup=amend:<commit>` is similar but
 	creates an "amend!" commit which also replaces the log message of
-	`<commit>` with the log message of the "amend!" commit.
+	_<commit>_ with the log message of the "amend!" commit.
 	`--fixup=reword:<commit>` creates an "amend!" commit which
-	replaces the log message of `<commit>` with its own log message
-	but makes no changes to the content of `<commit>`.
+	replaces the log message of _<commit>_ with its own log message
+	but makes no changes to the content of _<commit>_.
 +
 The commit created by plain `--fixup=<commit>` has a subject
-composed of "fixup!" followed by the subject line from <commit>,
+composed of "fixup!" followed by the subject line from _<commit>_,
 and is recognized specially by `git rebase --autosquash`. The `-m`
 option may be used to supplement the log message of the created
 commit, but the additional commentary will be thrown away once the
-"fixup!" commit is squashed into `<commit>` by
+"fixup!" commit is squashed into _<commit>_ by
 `git rebase --autosquash`.
 +
 The commit created by `--fixup=amend:<commit>` is similar but its
 subject is instead prefixed with "amend!". The log message of
-<commit> is copied into the log message of the "amend!" commit and
+_<commit>_ is copied into the log message of the "amend!" commit and
 opened in an editor so it can be refined. When `git rebase
---autosquash` squashes the "amend!" commit into `<commit>`, the
-log message of `<commit>` is replaced by the refined log message
+--autosquash` squashes the "amend!" commit into _<commit>_, the
+log message of _<commit>_ is replaced by the refined log message
 from the "amend!" commit. It is an error for the "amend!" commit's
 log message to be empty unless `--allow-empty-message` is
 specified.
 +
 `--fixup=reword:<commit>` is shorthand for `--fixup=amend:<commit>
---only`. It creates an "amend!" commit with only a log message
+ --only`. It creates an "amend!" commit with only a log message
 (ignoring any changes staged in the index). When squashed by `git
-rebase --autosquash`, it replaces the log message of `<commit>`
+rebase --autosquash`, it replaces the log message of _<commit>_
 without making any other changes.
 +
 Neither "fixup!" nor "amend!" commits change authorship of
-`<commit>` when applied by `git rebase --autosquash`.
+_<commit>_ when applied by `git rebase --autosquash`.
 See linkgit:git-rebase[1] for details.
 
---squash=<commit>::
-	Construct a commit message for use with `rebase --autosquash`.
+`--squash=<commit>`::
+	Construct a commit message for use with `git rebase --autosquash`.
 	The commit message subject line is taken from the specified
 	commit with a prefix of "squash! ".  Can be used with additional
 	commit message options (`-m`/`-c`/`-C`/`-F`). See
 	linkgit:git-rebase[1] for details.
 
---reset-author::
-	When used with -C/-c/--amend options, or when committing after a
+`--reset-author`::
+	When used with `-C`/`-c`/`--amend` options, or when committing after a
 	conflicting cherry-pick, declare that the authorship of the
 	resulting commit now belongs to the committer. This also renews
 	the author timestamp.
 
---short::
+`--short`::
 	When doing a dry-run, give the output in the short-format. See
 	linkgit:git-status[1] for details. Implies `--dry-run`.
 
---branch::
+`--branch`::
 	Show the branch and tracking info even in short-format.
 
---porcelain::
+`--porcelain`::
 	When doing a dry-run, give the output in a porcelain-ready
 	format. See linkgit:git-status[1] for details. Implies
 	`--dry-run`.
 
---long::
+`--long`::
 	When doing a dry-run, give the output in the long-format.
 	Implies `--dry-run`.
 
--z::
---null::
+`-z`::
+`--null`::
 	When showing `short` or `porcelain` status output, print the
-	filename verbatim and terminate the entries with NUL, instead of LF.
+	filename verbatim and terminate the entries with _NUL_, instead of _LF_.
 	If no format is given, implies the `--porcelain` output format.
 	Without the `-z` option, filenames with "unusual" characters are
 	quoted as explained for the configuration variable `core.quotePath`
 	(see linkgit:git-config[1]).
 
--F <file>::
---file=<file>::
-	Take the commit message from the given file.  Use '-' to
+`-F <file>`::
+`--file=<file>`::
+	Take the commit message from _<file>_.  Use `-` to
 	read the message from the standard input.
 
---author=<author>::
+`--author=<author>`::
 	Override the commit author. Specify an explicit author using the
-	standard `A U Thor <author@example.com>` format. Otherwise <author>
+	standard `A U Thor <author@example.com>` format. Otherwise _<author>_
 	is assumed to be a pattern and is used to search for an existing
-	commit by that author (i.e. rev-list --all -i --author=<author>);
+	commit by that author (i.e. `git rev-list --all -i --author=<author>`);
 	the commit author is then copied from the first such commit found.
 
---date=<date>::
+`--date=<date>`::
 	Override the author date used in the commit.
 
--m <msg>::
---message=<msg>::
-	Use the given <msg> as the commit message.
+`-m <msg>`::
+`--message=<msg>`::
+	Use _<msg>_ as the commit message.
 	If multiple `-m` options are given, their values are
 	concatenated as separate paragraphs.
 +
 The `-m` option is mutually exclusive with `-c`, `-C`, and `-F`.
 
--t <file>::
---template=<file>::
+`-t <file>`::
+`--template=<file>`::
 	When editing the commit message, start the editor with the
-	contents in the given file.  The `commit.template` configuration
+	contents in _<file>_.  The `commit.template` configuration
 	variable is often used to give this option implicitly to the
 	command.  This mechanism can be used by projects that want to
 	guide participants with some hints on what to write in the message
@@ -200,56 +200,55 @@ The `-m` option is mutually exclusive with `-c`, `-C`, and `-F`.
 
 include::signoff-option.txt[]
 
---trailer <token>[(=|:)<value>]::
-	Specify a (<token>, <value>) pair that should be applied as a
+`--trailer <token>[(=|:)<value>]`::
+	Specify a (_<token>_, _<value>_) pair that should be applied as a
 	trailer. (e.g. `git commit --trailer "Signed-off-by:C O Mitter \
 	<committer@example.com>" --trailer "Helped-by:C O Mitter \
-	<committer@example.com>"` will add the "Signed-off-by" trailer
-	and the "Helped-by" trailer to the commit message.)
+	<committer@example.com>"` will add the `Signed-off-by` trailer
+	and the `Helped-by` trailer to the commit message.)
 	The `trailer.*` configuration variables
 	(linkgit:git-interpret-trailers[1]) can be used to define if
 	a duplicated trailer is omitted, where in the run of trailers
 	each trailer would appear, and other details.
 
--n::
---[no-]verify::
-	By default, the pre-commit and commit-msg hooks are run.
-	When any of `--no-verify` or `-n` is given, these are bypassed.
+`-n`::
+`--[no-]verify`::
+	Bypass the `pre-commit` and `commit-msg` hooks.
 	See also linkgit:githooks[5].
 
---allow-empty::
+`--allow-empty`::
 	Usually recording a commit that has the exact same tree as its
 	sole parent commit is a mistake, and the command prevents you
 	from making such a commit.  This option bypasses the safety, and
 	is primarily for use by foreign SCM interface scripts.
 
---allow-empty-message::
-       Like --allow-empty this command is primarily for use by foreign
+`--allow-empty-message`::
+       Like `--allow-empty` this command is primarily for use by foreign
        SCM interface scripts. It allows you to create a commit with an
        empty commit message without using plumbing commands like
        linkgit:git-commit-tree[1].
 
---cleanup=<mode>::
-	This option determines how the supplied commit message should be
+`--cleanup=<mode>`::
+	Determine how the supplied commit message should be
 	cleaned up before committing.  The '<mode>' can be `strip`,
 	`whitespace`, `verbatim`, `scissors` or `default`.
 +
 --
-strip::
+`strip`::
 	Strip leading and trailing empty lines, trailing whitespace,
 	commentary and collapse consecutive empty lines.
-whitespace::
+`whitespace`::
 	Same as `strip` except #commentary is not removed.
-verbatim::
+`verbatim`::
 	Do not change the message at all.
-scissors::
+`scissors`::
 	Same as `whitespace` except that everything from (and including)
 	the line found below is truncated, if the message is to be edited.
-	"`#`" can be customized with core.commentChar.
+	"`#`" can be customized with `core.commentChar`.
 
 		# ------------------------ >8 ------------------------
 
-default::
+`default`::
 	Same as `strip` if the message is to be edited.
 	Otherwise `whitespace`.
 --
@@ -257,19 +256,18 @@ default::
 The default can be changed by the `commit.cleanup` configuration
 variable (see linkgit:git-config[1]).
 
--e::
---edit::
-	The message taken from file with `-F`, command line with
-	`-m`, and from commit object with `-C` are usually used as
-	the commit log message unmodified. This option lets you
-	further edit the message taken from these sources.
+`-e`::
+`--edit`::
+	Let the user further edit the message taken from  file
+	with `-F`, command line with `-m`, and from commit object
+	with `-C` are usually used as the commit log message unmodified.
 
---no-edit::
+`--no-edit`::
 	Use the selected commit message without launching an editor.
 	For example, `git commit --amend --no-edit` amends a commit
 	without changing its commit message.
 
---amend::
+`--amend`::
 	Replace the tip of the current branch by creating a new
 	commit. The recorded tree is prepared as usual (including
 	the effect of the `-i` and `-o` options and explicit
@@ -295,23 +293,23 @@ You should understand the implications of rewriting history if you
 amend a commit that has already been published.  (See the "RECOVERING
 FROM UPSTREAM REBASE" section in linkgit:git-rebase[1].)
 
---no-post-rewrite::
-	Bypass the post-rewrite hook.
+`--no-post-rewrite`::
+	Bypass the `post-rewrite` hook.
 
--i::
---include::
+`-i`::
+`--include`::
 	Before making a commit out of staged contents so far,
 	stage the contents of paths given on the command line
 	as well.  This is usually not what you want unless you
 	are concluding a conflicted merge.
 
--o::
---only::
+`-o`::
+`--only`::
 	Make a commit by taking the updated working tree contents
 	of the paths specified on the
 	command line, disregarding any contents that have been
 	staged for other paths. This is the default mode of operation of
-	'git commit' if any paths are given on the command line,
+	`git commit` if any paths are given on the command line,
 	in which case this option can be omitted.
 	If this option is specified together with `--amend`, then
 	no paths need to be specified, which can be used to amend
@@ -319,48 +317,48 @@ FROM UPSTREAM REBASE" section in linkgit:git-rebase[1].)
 	already been staged. If used together with `--allow-empty`
 	paths are also not required, and an empty commit will be created.
 
---pathspec-from-file=<file>::
-	Pathspec is passed in `<file>` instead of commandline args. If
-	`<file>` is exactly `-` then standard input is used. Pathspec
-	elements are separated by LF or CR/LF. Pathspec elements can be
+`--pathspec-from-file=<file>`::
+	Pathspec is passed in _<file>_ instead of commandline args. If
+	_<file>_ is exactly `-` then standard input is used. Pathspec
+	elements are separated by _LF_ or _CR_/_LF_. Pathspec elements can be
 	quoted as explained for the configuration variable `core.quotePath`
 	(see linkgit:git-config[1]). See also `--pathspec-file-nul` and
 	global `--literal-pathspecs`.
 
---pathspec-file-nul::
+`--pathspec-file-nul`::
 	Only meaningful with `--pathspec-from-file`. Pathspec elements are
-	separated with NUL character and all other characters are taken
+	separated with _NUL_ character and all other characters are taken
 	literally (including newlines and quotes).
 
--u[<mode>]::
---untracked-files[=<mode>]::
+`-u[<mode>]`::
+`--untracked-files[=<mode>]`::
 	Show untracked files.
 +
 --
-The mode parameter is optional (defaults to 'all'), and is used to
-specify the handling of untracked files; when -u is not used, the
-default is 'normal', i.e. show untracked files and directories.
+The _<mode>_ parameter is optional (defaults to `all`), and is used to
+specify the handling of untracked files; when `-u` is not used, the
+default is `normal`, i.e. show untracked files and directories.
 
 The possible options are:
 
-	- 'no'     - Show no untracked files
-	- 'normal' - Shows untracked files and directories
-	- 'all'    - Also shows individual files in untracked directories.
+`no`:: Show no untracked files
+`normal`:: Shows untracked files and directories
+`all`:: Also shows individual files in untracked directories.
 
 All usual spellings for Boolean value `true` are taken as `normal`
 and `false` as `no`.
-The default can be changed using the status.showUntrackedFiles
+The default can be changed using the `status.showUntrackedFiles`
 configuration variable documented in linkgit:git-config[1].
 --
 
--v::
---verbose::
-	Show unified diff between the HEAD commit and what
+`-v`::
+`--verbose`::
+	Show unified diff between the `HEAD` commit and what
 	would be committed at the bottom of the commit message
 	template to help the user describe the commit by reminding
 	what changes the commit has.
 	Note that this diff output doesn't have its
-	lines prefixed with '#'. This diff will not be a part
+	lines prefixed with `#`. This diff will not be a part
 	of the commit message. See the `commit.verbose` configuration
 	variable in linkgit:git-config[1].
 +
@@ -368,40 +366,40 @@ If specified twice, show in addition the unified diff between
 what would be committed and the worktree files, i.e. the unstaged
 changes to tracked files.
 
--q::
---quiet::
+`-q`::
+`--quiet`::
 	Suppress commit summary message.
 
---dry-run::
+`--dry-run`::
 	Do not create a commit, but show a list of paths that are
 	to be committed, paths with local changes that will be left
 	uncommitted and paths that are untracked.
 
---status::
+`--status`::
 	Include the output of linkgit:git-status[1] in the commit
 	message template when using an editor to prepare the commit
 	message.  Defaults to on, but can be used to override
-	configuration variable commit.status.
+	configuration variable `commit.status`.
 
---no-status::
+`--no-status`::
 	Do not include the output of linkgit:git-status[1] in the
 	commit message template when using an editor to prepare the
 	default commit message.
 
--S[<keyid>]::
---gpg-sign[=<keyid>]::
---no-gpg-sign::
-	GPG-sign commits. The `keyid` argument is optional and
+`-S[<key-id>]`::
+`--gpg-sign[=<key-id>]`::
+`--no-gpg-sign`::
+	GPG-sign commits. The _<key-id>_ is optional and
 	defaults to the committer identity; if specified, it must be
 	stuck to the option without a space. `--no-gpg-sign` is useful to
 	countermand both `commit.gpgSign` configuration variable, and
 	earlier `--gpg-sign`.
 
-\--::
+`--`::
 	Do not interpret any more arguments as options.
 
-<pathspec>...::
-	When pathspec is given on the command line, commit the contents of
+`<pathspec>...`::
+	When _<pathspec>_ is given on the command line, commit the contents of
 	the files that match the pathspec without recording the changes
 	already added to the index. The contents of these files are also
 	staged for the next commit on top of what have been staged before.
@@ -412,10 +410,10 @@ EXAMPLES
 --------
 When recording your own work, the contents of modified files in
 your working tree are temporarily stored to a staging area
-called the "index" with 'git add'.  A file can be
+called the "index" with `git add`.  A file can be
 reverted back, only in the index but not in the working tree,
 to that of the last commit with `git restore --staged <file>`,
-which effectively reverts 'git add' and prevents the changes to
+which effectively reverts `git add` and prevents the changes to
 this file from participating in the next commit.  After building
 the state to be committed incrementally with these commands,
 `git commit` (without any pathname parameter) is used to record what
@@ -443,7 +441,7 @@ $ git commit -a
 ------------
 
 The command `git commit -a` first looks at your working tree,
-notices that you have modified hello.c and removed goodbye.c,
+notices that you have modified `hello.c` and removed `goodbye.c`,
 and performs necessary `git add` and `git rm` for you.
 
 After staging changes to many files, you can alter the order the
@@ -471,13 +469,13 @@ $ git commit
 this second commit would record the changes to `hello.c` and
 `hello.h` as expected.
 
-After a merge (initiated by 'git merge' or 'git pull') stops
+After a merge (initiated by `git merge` or `git pull`) stops
 because of conflicts, cleanly merged
 paths are already staged to be committed for you, and paths that
 conflicted are left in unmerged state.  You would have to first
-check which paths are conflicting with 'git status'
+check which paths are conflicting with `git status`
 and after fixing them manually in your working tree, you would
-stage the result as usual with 'git add':
+stage the result as usual with `git add`:
 
 ------------
 $ git status | grep unmerged
@@ -507,12 +505,12 @@ COMMIT INFORMATION
 Author and committer information is taken from the following environment
 variables, if set:
 
-	GIT_AUTHOR_NAME
-	GIT_AUTHOR_EMAIL
-	GIT_AUTHOR_DATE
-	GIT_COMMITTER_NAME
-	GIT_COMMITTER_EMAIL
-	GIT_COMMITTER_DATE
+ * `GIT_AUTHOR_NAME`
+ * `GIT_AUTHOR_EMAIL`
+ * `GIT_AUTHOR_DATE`
+ * `GIT_COMMITTER_NAME`
+ * `GIT_COMMITTER_EMAIL`
+ * `GIT_COMMITTER_DATE`
 
 (nb "<", ">" and "\n"s are stripped)
 
@@ -524,7 +522,7 @@ that, see the `credential.username` variable in linkgit:git-config[1].
 
 In case (some of) these environment variables are not set, the information
 is taken from the configuration items `user.name` and `user.email`, or, if not
-present, the environment variable EMAIL, or, if that is not set,
+present, the environment variable `EMAIL`, or, if that is not set,
 system user name and the hostname used for outgoing mail (taken
 from `/etc/mailname` and falling back to the fully qualified hostname when
 that file does not exist).
@@ -555,7 +553,7 @@ include::i18n.txt[]
 ENVIRONMENT AND CONFIGURATION VARIABLES
 ---------------------------------------
 The editor used to edit the commit log message will be chosen from the
-`GIT_EDITOR` environment variable, the core.editor configuration variable, the
+`GIT_EDITOR` environment variable, the `core.editor` configuration variable, the
 `VISUAL` environment variable, or the `EDITOR` environment variable (in that
 order).  See linkgit:git-var[1] for details.
 
diff --git a/builtin/commit.c b/builtin/commit.c
index ef5e622c077..a7315ed67cc 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -44,7 +44,7 @@
 #include "trailer.h"
 
 static const char * const builtin_commit_usage[] = {
-	N_("git commit [-a | --interactive | --patch] [-s] [-v] [-u<mode>] [--amend]\n"
+	N_("git commit [-a | --interactive | --patch] [-s] [-v] [-u[<mode>]] [--amend]\n"
 	   "           [--dry-run] [(-c | -C | --squash) <commit> | --fixup [(amend|reword):]<commit>]\n"
 	   "           [-F <file> | -m <msg>] [--reset-author] [--allow-empty]\n"
 	   "           [--allow-empty-message] [--no-verify] [-e] [--author=<author>]\n"
-- 
gitgitgadget

