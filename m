Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URG_BIZ,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C0B2C43461
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 04:06:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4DE9C6115C
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 04:06:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231431AbhDIEGs (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Apr 2021 00:06:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231343AbhDIEGG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Apr 2021 00:06:06 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 275B4C061762
        for <git@vger.kernel.org>; Thu,  8 Apr 2021 21:05:53 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5-20020a05600c0245b029011a8273f85eso2235586wmj.1
        for <git@vger.kernel.org>; Thu, 08 Apr 2021 21:05:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XSvqG8WXUr/rx6+U8SaX4nPnhmnv11TaK9gan1tFma8=;
        b=dcxUdGmu/cwWJt4rzsWVmobElaiqAUhr+bnFlrrPVEVojamWFO9MN43D9ZgvNZCMS4
         g0G9wSOSm2mYKkmJ7zMK0Ceagf0ehJJoJhzUwuXLKEvHlHBKsHtRdEh4TWNT+GcR+U3L
         DaMhfOsmJd/ic1mnhnNhd+JHU4+I/xTKGhzH2DlFyED8xTe4qtaEIMXcw4D6lib1pV9E
         jfcOFhsPlLvQdmN5eX1pkkMv7omFtasgP9HxWpqwWPJMGzLoT0883zEXv47BmTlkmozU
         q3pBmIr3YMz7tfT/rk7vYhXp7k7PjYd/K0RFC/zl5iwSlDmnpwVObwcFLgeRsJ/CwAvJ
         gaRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XSvqG8WXUr/rx6+U8SaX4nPnhmnv11TaK9gan1tFma8=;
        b=FPZ4uUz11Ytv1eITCQb4wxuuX68BWDKeN4nlwX1IN89fGRlhGQ4nEzNCV2kw39m+vN
         oNFZzQsdw8eBjIPT2N13J30a9VOMg0pwJvJEPdEXOMCS3xgAsy23oScHIz0NQ9u3AkCY
         rQRM0e7H48sZ9cPwHi4ei1Wxq8p5Q0Dob0DUop3MofWvrdhmUaQHfuhNbbmX+7Fg9CD3
         Joi7EhAcLBfeL1YC0bpYqbNX4zbixmml6VcgCcP96tGGI0iz19dx06P3iv2CVeM5I+4u
         Zh/ndl4qmvyStPowjQcq8fncF5RhPop5zwA2TBKew4fMbjFGcUWKR/wClC/lxtLpTSyl
         BL6A==
X-Gm-Message-State: AOAM532g11GZmF9hLcVtghptc9qJLGRMmot4C0nb5qAsI9MvN+KXWWu0
        H2h6km3z5L2SN3C7H+RCvHK3GTfG3MiKfQ==
X-Google-Smtp-Source: ABdhPJyqoQ43H0OMtOrOzBmFHCF+0I7qlCGMwCaHcp12qUuq2g2Ex/pPO9gerEHixsa4K15rVSIe1g==
X-Received: by 2002:a1c:2541:: with SMTP id l62mr11764772wml.188.1617941150415;
        Thu, 08 Apr 2021 21:05:50 -0700 (PDT)
Received: from Inspiron.home (2a01cb04010c420080e637770dc2ae3c.ipv6.abo.wanadoo.fr. [2a01:cb04:10c:4200:80e6:3777:dc2:ae3c])
        by smtp.gmail.com with ESMTPSA id c9sm2064636wrr.78.2021.04.08.21.05.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Apr 2021 21:05:49 -0700 (PDT)
From:   Firmin Martin <firminmartin24@gmail.com>
To:     git@vger.kernel.org
Cc:     Firmin Martin <firminmartin24@gmail.com>
Subject: [RFC PATCH v1 10/13] doc: typeset more command entries in monospace
Date:   Fri,  9 Apr 2021 06:02:58 +0200
Message-Id: <20210409040301.3260358-11-firminmartin24@gmail.com>
X-Mailer: git-send-email 2.31.1.133.g84d06cdc06
In-Reply-To: <20210409040301.3260358-1-firminmartin24@gmail.com>
References: <20210409040301.3260358-1-firminmartin24@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Wrap command-line option entries (i.e. something of the form
<entry>[::|;;]<description>) which contain space or number with
backticks as indicated in the CodingGuidelines. Additionaly, as
an intended effect, also wrap some subcommands and status values.

The following command and regex assisted the substitution
with manual intervention to exclude false positives.

    REGEX="^([[:space:]]*?)[\"']?([][ 0-9a-zA-Z-=<>]+)[\"']?(::|;;)([[:space:]]+|\$)" &&
    perl -pi -e "s/$REGEX/\$1\`\$2\`\$3\$4/g" $(grep -Pl "$REGEX" *.txt --exclude-dir=RelNotes)

Signed-off-by: Firmin Martin <firminmartin24@gmail.com>
---
 Documentation/blame-options.txt          | 10 ++++-----
 Documentation/diff-format.txt            |  4 ++--
 Documentation/fetch-options.txt          | 12 +++++------
 Documentation/git-add.txt                |  2 +-
 Documentation/git-am.txt                 | 10 ++++-----
 Documentation/git-apply.txt              |  4 ++--
 Documentation/git-archimport.txt         |  4 ++--
 Documentation/git-archive.txt            |  6 +++---
 Documentation/git-branch.txt             | 14 ++++++-------
 Documentation/git-bugreport.txt          |  8 ++++----
 Documentation/git-bundle.txt             |  8 ++++----
 Documentation/git-check-ignore.txt       |  6 +++---
 Documentation/git-cherry-pick.txt        |  4 ++--
 Documentation/git-clean.txt              |  8 ++++----
 Documentation/git-clone.txt              | 26 ++++++++++++------------
 Documentation/git-column.txt             | 14 ++++++-------
 Documentation/git-commit-tree.txt        |  6 +++---
 Documentation/git-commit.txt             | 10 ++++-----
 Documentation/git-config.txt             | 16 +++++++--------
 Documentation/git-credential-cache.txt   |  4 ++--
 Documentation/git-credential-store.txt   |  2 +-
 Documentation/git-cvsexportcommit.txt    |  2 +-
 Documentation/git-cvsimport.txt          | 24 +++++++++++-----------
 Documentation/git-cvsserver.txt          |  2 +-
 Documentation/git-describe.txt           |  4 ++--
 Documentation/git-diff-files.txt         |  8 ++++----
 Documentation/git-diff.txt               |  8 ++++----
 Documentation/git-difftool.txt           |  4 ++--
 Documentation/git-filter-branch.txt      | 24 +++++++++++-----------
 Documentation/git-fmt-merge-msg.txt      |  8 ++++----
 Documentation/git-for-each-repo.txt      |  2 +-
 Documentation/git-format-patch.txt       | 12 +++++------
 Documentation/git-fsck.txt               |  8 ++++----
 Documentation/git-grep.txt               | 18 ++++++++--------
 Documentation/git-hash-object.txt        |  2 +-
 Documentation/git-http-fetch.txt         |  2 +-
 Documentation/git-index-pack.txt         |  2 +-
 Documentation/git-init.txt               |  6 +++---
 Documentation/git-interpret-trailers.txt |  6 +++---
 Documentation/git-log.txt                |  2 +-
 Documentation/git-ls-files.txt           |  4 ++--
 Documentation/git-ls-remote.txt          |  2 +-
 Documentation/git-merge-file.txt         |  4 ++--
 Documentation/git-merge.txt              |  4 ++--
 Documentation/git-mergetool.txt          |  2 +-
 Documentation/git-notes.txt              | 12 +++++------
 Documentation/git-p4.txt                 | 22 ++++++++++----------
 Documentation/git-prune.txt              |  2 +-
 Documentation/git-push.txt               | 14 ++++++-------
 Documentation/git-quiltimport.txt        |  6 +++---
 Documentation/git-range-diff.txt         |  4 ++--
 Documentation/git-rebase.txt             | 10 ++++-----
 Documentation/git-receive-pack.txt       |  2 +-
 Documentation/git-replace.txt            |  6 +++---
 Documentation/git-reset.txt              |  6 +++---
 Documentation/git-restore.txt            |  2 +-
 Documentation/git-rev-parse.txt          |  8 ++++----
 Documentation/git-revert.txt             |  4 ++--
 Documentation/git-send-email.txt         |  2 +-
 Documentation/git-shell.txt              |  2 +-
 Documentation/git-shortlog.txt           |  2 +-
 Documentation/git-show-branch.txt        |  2 +-
 Documentation/git-show-index.txt         |  2 +-
 Documentation/git-stash.txt              |  4 ++--
 Documentation/git-submodule.txt          | 14 ++++++-------
 Documentation/git-svn.txt                | 16 +++++++--------
 Documentation/git-switch.txt             | 10 ++++-----
 Documentation/git-tag.txt                | 16 +++++++--------
 Documentation/git-unpack-file.txt        |  2 +-
 Documentation/git-update-index.txt       |  4 ++--
 Documentation/git-upload-archive.txt     |  2 +-
 Documentation/git-web--browse.txt        |  8 ++++----
 Documentation/git-worktree.txt           | 10 ++++-----
 Documentation/git.txt                    |  4 ++--
 Documentation/gitattributes.txt          |  2 +-
 Documentation/gitk.txt                   |  2 +-
 Documentation/gitremote-helpers.txt      | 10 ++++-----
 Documentation/gitweb.txt                 |  4 ++--
 Documentation/merge-options.txt          |  4 ++--
 Documentation/pull-fetch-param.txt       |  6 +++---
 Documentation/rev-list-options.txt       |  6 +++---
 Documentation/revisions.txt              |  2 +-
 82 files changed, 286 insertions(+), 286 deletions(-)

diff --git a/Documentation/blame-options.txt b/Documentation/blame-options.txt
index c58d30a648..15e50af424 100644
--- a/Documentation/blame-options.txt
+++ b/Documentation/blame-options.txt
@@ -26,7 +26,7 @@ include::line-range-format.txt[]
 `-t`::
 	Show raw timestamp (Default: off).
 
--S <revs-file>::
+`-S <revs-file>`::
 	Use revisions from revs-file instead of calling linkgit:git-rev-list[1].
 
 --reverse <rev>..<rev>::
@@ -63,14 +63,14 @@ include::line-range-format.txt[]
 	discussion about encoding in the linkgit:git-log[1]
 	manual page.
 
---contents <file>::
+`--contents <file>`::
 	When <rev> is not specified, the command annotates the
 	changes starting backwards from the working tree copy.
 	This flag makes the command pretend as if the working
 	tree copy has the contents of the named file (specify
 	`-` to make the command read from the standard input).
 
---date <format>::
+`--date <format>`::
 	Specifies the format used to output dates. If `--date` is not
 	provided, the value of the `blame.date` config variable is
 	used. If the `blame.date` config variable is also not set, the
@@ -117,7 +117,7 @@ commit. And the default value is 40. If there are more than one
 `-C` options given, the <num> argument of the last `-C` will
 take effect.
 
---ignore-rev <rev>::
+`--ignore-rev <rev>`::
 	Ignore changes made by the revision when assigning blame, as if the
 	change never happened.  Lines that were changed or added by an ignored
 	commit will be blamed on the previous commit that changed that line or
@@ -129,7 +129,7 @@ take effect.
 	by an ignored commit that we could not attribute to another revision are
 	marked with a '*'.
 
---ignore-revs-file <file>::
+`--ignore-revs-file <file>`::
 	Ignore revisions listed in `file`, which must be in the same format as an
 	`fsck.skipList`.  This option may be repeated, and these files will be
 	processed after any files specified with the `blame.ignoreRevsFile` config
diff --git a/Documentation/diff-format.txt b/Documentation/diff-format.txt
index 14ef11d552..ac0ecc266a 100644
--- a/Documentation/diff-format.txt
+++ b/Documentation/diff-format.txt
@@ -7,10 +7,10 @@ The raw output format from `git-diff-index`, `git-diff-tree`,
 These commands all compare two sets of things; what is
 compared differs:
 
-git-diff-index <tree-ish>::
+`git-diff-index <tree-ish>`::
         compares the <tree-ish> and the files on the filesystem.
 
-git-diff-index --cached <tree-ish>::
+`git-diff-index --cached <tree-ish>`::
         compares the <tree-ish> and the index.
 
 git-diff-tree [-r] <tree-ish-1> <tree-ish-2> [<pattern>...]::
diff --git a/Documentation/fetch-options.txt b/Documentation/fetch-options.txt
index fcee0ad87d..98ffc052f0 100644
--- a/Documentation/fetch-options.txt
+++ b/Documentation/fetch-options.txt
@@ -231,7 +231,7 @@ ifndef::git-pull[]
 	use it.
 endif::git-pull[]
 
---upload-pack <upload-pack>::
+`--upload-pack <upload-pack>`::
 	When given, and the repository to fetch from is handled
 	by `git fetch-pack`, `--exec=<upload-pack>` is passed to
 	the command to specify non-default path for the command
@@ -255,7 +255,7 @@ endif::git-pull[]
 	is specified. This flag forces progress status even if the
 	standard error stream is not directed to a terminal.
 
--o <option>::
+`-o <option>`::
 `--server-option=<option>`::
 	Transmit the given string to the server when communicating using
 	protocol version 2.  The given string must not contain a NUL or LF
@@ -277,10 +277,10 @@ endif::git-pull[]
 	'git-pull' the `--ff-only` option will still check for forced updates
 	before attempting a fast-forward update. See linkgit:git-config[1].
 
--4::
---ipv4::
+`-4`::
+`--ipv4`::
 	Use IPv4 addresses only, ignoring IPv6 addresses.
 
--6::
---ipv6::
+`-6`::
+`--ipv6`::
 	Use IPv6 addresses only, ignoring IPv4 addresses.
diff --git a/Documentation/git-add.txt b/Documentation/git-add.txt
index 646951cf7e..1bc86d8482 100644
--- a/Documentation/git-add.txt
+++ b/Documentation/git-add.txt
@@ -313,7 +313,7 @@ contents of working tree files for selected paths in the index.
   information for selected paths are reverted to that of the
   `HEAD` version.  Reverting new paths makes them untracked.
 
-add untracked::
+`add untracked`::
 
   This has a very similar UI to 'update' and
   'revert', and lets you add untracked paths to the index.
diff --git a/Documentation/git-am.txt b/Documentation/git-am.txt
index c8560bacad..0d01c475ab 100644
--- a/Documentation/git-am.txt
+++ b/Documentation/git-am.txt
@@ -75,7 +75,7 @@ OPTIONS
 	Be quiet. Only print error messages.
 
 `-u`::
---utf8::
+`--utf8`::
 	Pass `-u` flag to `git mailinfo` (see linkgit:git-mailinfo[1]).
 	The proposed commit log message taken from the e-mail
 	is re-coded into UTF-8 encoding (configuration variable
@@ -85,13 +85,13 @@ OPTIONS
 This was optional in prior versions of git, but now it is the
 default.   You can use `--no-utf8` to override this.
 
---no-utf8::
+`--no-utf8`::
 	Pass `-n` flag to `git mailinfo` (see
 	linkgit:git-mailinfo[1]).
 
--3::
---3way::
---no-3way::
+`-3`::
+`--3way`::
+`--no-3way`::
 	When the patch does not apply cleanly, fall back on
 	3-way merge if the patch records the identity of blobs
 	it is supposed to apply to and we have those blobs
diff --git a/Documentation/git-apply.txt b/Documentation/git-apply.txt
index 88cdddb178..fd681659e8 100644
--- a/Documentation/git-apply.txt
+++ b/Documentation/git-apply.txt
@@ -82,8 +82,8 @@ OPTIONS
 	Note that `--index` could be implied by other options such
 	as `--cached` or `--3way`.
 
--3::
---3way::
+`-3`::
+`--3way`::
 	When the patch does not apply cleanly, fall back on 3-way merge if
 	the patch records the identity of blobs it is supposed to apply to,
 	and we have those blobs available locally, possibly leaving the
diff --git a/Documentation/git-archimport.txt b/Documentation/git-archimport.txt
index 8ea76463bf..3144cc1680 100644
--- a/Documentation/git-archimport.txt
+++ b/Documentation/git-archimport.txt
@@ -91,7 +91,7 @@ OPTIONS
 	on the command-line will override the automatically-generated
 	ones.
 
--D <depth>::
+`-D <depth>`::
 	Follow merge ancestry and attempt to import trees that have been
 	merged from.  Specify a depth greater than 1 if patch logs have been
 	pruned.
@@ -100,7 +100,7 @@ OPTIONS
 	Attempt to auto-register archives at http://mirrors.sourcecontrol.net
 	This is particularly useful with the `-D` option.
 
--t <tmpdir>::
+`-t <tmpdir>`::
 	Override the default tempdir.
 
 
diff --git a/Documentation/git-archive.txt b/Documentation/git-archive.txt
index d0ca1241a2..83ce330c9d 100644
--- a/Documentation/git-archive.txt
+++ b/Documentation/git-archive.txt
@@ -51,7 +51,7 @@ OPTIONS
 --prefix=<prefix>/::
 	Prepend <prefix>/ to each filename in the archive.
 
--o <file>::
+`-o <file>`::
 `--output=<file>`::
 	Write the archive to <file> instead of stdout.
 
@@ -93,9 +93,9 @@ BACKEND EXTRA OPTIONS
 
 zip
 ~~~
--0::
+`-0`::
 	Store the files instead of deflating them.
--9::
+`-9`::
 	Highest and slowest compression level.  You can specify any
 	number from 1 to 9 to adjust compression speed and ratio.
 
diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.txt
index b9f65c4d52..cefc94e440 100644
--- a/Documentation/git-branch.txt
+++ b/Documentation/git-branch.txt
@@ -228,7 +228,7 @@ start-point is either a local or remote-tracking branch.
 	As this option had confusing syntax, it is no longer supported.
 	Please use `--track` or `--set-upstream-to` instead.
 
--u <upstream>::
+`-u <upstream>`::
 `--set-upstream-to=<upstream>`::
 	Set up <branchname>'s tracking information so <upstream> is
 	considered <branchname>'s upstream branch. If no <branchname>
@@ -244,19 +244,19 @@ start-point is either a local or remote-tracking branch.
 	`request-pull`, and `merge` (if enabled)). Multi-line explanations
 	may be used.
 
---contains [<commit>]::
+`--contains [<commit>]`::
 	Only list branches which contain the specified commit (HEAD
 	if not specified). Implies `--list`.
 
---no-contains [<commit>]::
+`--no-contains [<commit>]`::
 	Only list branches which don't contain the specified commit
 	(`HEAD` if not specified). Implies `--list`.
 
---merged [<commit>]::
+`--merged [<commit>]`::
 	Only list branches whose tips are reachable from the
 	specified commit (`HEAD` if not specified). Implies `--list`.
 
---no-merged [<commit>]::
+`--no-merged [<commit>]`::
 	Only list branches whose tips are not reachable from the
 	specified commit (`HEAD` if not specified). Implies `--list`.
 
@@ -290,10 +290,10 @@ start-point is either a local or remote-tracking branch.
 	finally remote-tracking branches. See linkgit:git-config[1].
 
 
---points-at <object>::
+`--points-at <object>`::
 	Only list branches of the given object.
 
---format <format>::
+`--format <format>`::
 	A string that interpolates `%(fieldname)` from a branch ref being shown
 	and the object it points at.  The format is the same as
 	that of linkgit:git-for-each-ref[1].
diff --git a/Documentation/git-bugreport.txt b/Documentation/git-bugreport.txt
index 0d5ef36f90..1b24b53907 100644
--- a/Documentation/git-bugreport.txt
+++ b/Documentation/git-bugreport.txt
@@ -38,13 +38,13 @@ the kind of information listed above when manually asking for help.
 
 OPTIONS
 -------
--o <path>::
---output-directory <path>::
+`-o <path>`::
+`--output-directory <path>`::
 	Place the resulting bug report file in `<path>` instead of the root of
 	the Git repository.
 
--s <format>::
---suffix <format>::
+`-s <format>`::
+`--suffix <format>`::
 	Specify an alternate suffix for the bugreport name, to create a file
 	named `git-bugreport-<formatted suffix>`. This should take the form of a
 	strftime(3) format string; the current local time will be used.
diff --git a/Documentation/git-bundle.txt b/Documentation/git-bundle.txt
index 92499c452d..644f2bb9dd 100644
--- a/Documentation/git-bundle.txt
+++ b/Documentation/git-bundle.txt
@@ -37,13 +37,13 @@ destination repository.
 OPTIONS
 -------
 
-create [options] <file> <git-rev-list-args>::
+`create [options] <file> <git-rev-list-args>`::
 	Used to create a bundle named 'file'.  This requires the
 	'<git-rev-list-args>' arguments to define the bundle contents.
 	'options' contains the options specific to the `git bundle create`
 	subcommand.
 
-verify <file>::
+`verify <file>`::
 	Used to check that a bundle file is valid and will apply
 	cleanly to the current repository.  This includes checks on the
 	bundle format itself as well as checking that the prerequisite
@@ -51,12 +51,12 @@ verify <file>::
 	`git bundle` prints a list of missing commits, if any, and exits
 	with a non-zero status.
 
-list-heads <file>::
+`list-heads <file>`::
 	Lists the references defined in the bundle.  If followed by a
 	list of references, only references matching those given are
 	printed out.
 
-unbundle <file>::
+`unbundle <file>`::
 	Passes the objects in the bundle to `git index-pack`
 	for storage in the repository, then prints the names of all
 	defined references. If a list of references is given, only
diff --git a/Documentation/git-check-ignore.txt b/Documentation/git-check-ignore.txt
index eabe8467ef..ae7842c65d 100644
--- a/Documentation/git-check-ignore.txt
+++ b/Documentation/git-check-ignore.txt
@@ -106,13 +106,13 @@ buffer.
 EXIT STATUS
 -----------
 
-0::
+`0`::
 	One or more of the provided paths is ignored.
 
-1::
+`1`::
 	None of the provided paths are ignored.
 
-128::
+`128`::
 	A fatal error was encountered.
 
 SEE ALSO
diff --git a/Documentation/git-cherry-pick.txt b/Documentation/git-cherry-pick.txt
index 5d6021e4ca..31937c16f8 100644
--- a/Documentation/git-cherry-pick.txt
+++ b/Documentation/git-cherry-pick.txt
@@ -81,8 +81,8 @@ OPTIONS
 	described above, and `-r` was to disable it.  Now the
 	default is not to do `-x` so this option is a no-op.
 
--m parent-number::
---mainline parent-number::
+`-m parent-number`::
+`--mainline parent-number`::
 	Usually you cannot cherry-pick a merge because you do not know which
 	side of the merge should be considered the mainline.  This
 	option specifies the parent number (starting from 1) of
diff --git a/Documentation/git-clean.txt b/Documentation/git-clean.txt
index e782f48c2c..55a77a31f5 100644
--- a/Documentation/git-clean.txt
+++ b/Documentation/git-clean.txt
@@ -55,7 +55,7 @@ OPTIONS
 	Be quiet, only report errors, but not the files that are
 	successfully removed.
 
--e <pattern>::
+`-e <pattern>`::
 `--exclude=<pattern>`::
 	Use the given exclude pattern in addition to the standard ignore rules
 	(see linkgit:gitignore[5]).
@@ -98,7 +98,7 @@ The main command loop has 6 subcommands.
 
    Start cleaning files and directories, and then quit.
 
-filter by pattern::
+`filter by pattern`::
 
    This shows the files and directories to be deleted and issues an
    "Input ignore patterns>>" prompt. You can input space-separated
@@ -107,7 +107,7 @@ filter by pattern::
    deletion. When you are satisfied with the filtered result, press
    ENTER (empty) back to the main menu.
 
-select by numbers::
+`select by numbers`::
 
    This shows the files and directories to be deleted and issues an
    "Select items to delete>>" prompt. When the prompt ends with double
@@ -119,7 +119,7 @@ select by numbers::
    Also when you are satisfied with the filtered result, press ENTER
    (empty) back to the main menu.
 
-ask each::
+`ask each`::
 
   This will start to clean, and you must confirm one by one in order
   to delete items. Please note that this action is not as efficient
diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
index 935d191ae1..a5861c0530 100644
--- a/Documentation/git-clone.txt
+++ b/Documentation/git-clone.txt
@@ -96,7 +96,7 @@ If you want to break the dependency of a repository cloned with `--shared` on
 its source repository, you can simply run `git repack -a` to copy all
 objects from the source repository into a pack in the cloned repository.
 
---reference[-if-able] <repository>::
+`--reference[-if-able] <repository>`::
 	If the reference repository is on the local machine,
 	automatically setup `.git/objects/info/alternates` to
 	obtain objects from the reference repository.  Using
@@ -190,14 +190,14 @@ objects from the source repository into a pack in the cloned repository.
 	that all these refs are overwritten by a `git remote update` in the
 	target repository.
 
--o <name>::
---origin <name>::
+`-o <name>`::
+`--origin <name>`::
 	Instead of using the remote name `origin` to keep track of the upstream
 	repository, use `<name>`.  Overrides `clone.defaultRemoteName` from the
 	config.
 
--b <name>::
---branch <name>::
+`-b <name>`::
+`--branch <name>`::
 	Instead of pointing the newly created `HEAD` to the branch pointed
 	to by the cloned repository's `HEAD`, point to `<name>` branch
 	instead. In a non-bare repository, this is the branch that will
@@ -205,8 +205,8 @@ objects from the source repository into a pack in the cloned repository.
 	`--branch` can also take tags and detaches the `HEAD` at that commit
 	in the resulting repository.
 
--u <upload-pack>::
---upload-pack <upload-pack>::
+`-u <upload-pack>`::
+`--upload-pack <upload-pack>`::
 	When given, and the repository to clone from is accessed
 	via ssh, this specifies a non-default path for the command
 	run on the other end.
@@ -215,8 +215,8 @@ objects from the source repository into a pack in the cloned repository.
 	Specify the directory from which templates will be used;
 	(See the "TEMPLATE DIRECTORY" section of linkgit:git-init[1].)
 
--c <key>=<value>::
---config <key>=<value>::
+`-c <key>=<value>`::
+`--config <key>=<value>`::
 	Set a configuration variable in the newly-created repository;
 	this takes effect immediately after the repository is
 	initialized, but before the remote history is fetched or any
@@ -232,7 +232,7 @@ Configuration variables known to not take effect are:
 `remote.<name>.mirror` and `remote.<name>.tagOpt`.  Use the
 corresponding `--mirror` and `--no-tags` options instead.
 
---depth <depth>::
+`--depth <depth>`::
 	Create a 'shallow' clone with a history truncated to the
 	specified number of commits. Implies `--single-branch` unless
 	`--no-single-branch` is given to fetch the histories near the
@@ -294,15 +294,15 @@ or `--mirror` is given)
 	superproject's recorded SHA-1. Equivalent to passing `--remote` to
 	`git submodule update`.
 
---separate-git-dir=<git dir>::
+`--separate-git-dir=<git dir>`::
 	Instead of placing the cloned repository where it is supposed
 	to be, place the cloned repository at the specified directory,
 	then make a filesystem-agnostic Git symbolic link to there.
 	The result is Git repository can be separated from working
 	tree.
 
--j <n>::
---jobs <n>::
+`-j <n>`::
+`--jobs <n>`::
 	The number of submodules fetched at the same time.
 	Defaults to the `submodule.fetchJobs` option.
 
diff --git a/Documentation/git-column.txt b/Documentation/git-column.txt
index 0865d22bdc..b350018637 100644
--- a/Documentation/git-column.txt
+++ b/Documentation/git-column.txt
@@ -20,30 +20,30 @@ columns.
 
 OPTIONS
 -------
---command=<name>::
+`--command=<name>`::
 	Look up layout mode using configuration variable `column.<name>` and
 	`column.ui`.
 
---mode=<mode>::
+`--mode=<mode>`::
 	Specify layout mode. See configuration variable `column.ui` for option
 	syntax in linkgit:git-config[1].
 
---raw-mode=<n>::
+`--raw-mode=<n>`::
 	Same as `--mode` but take mode encoded as a number. This is mainly used
 	by other commands that have already parsed layout mode.
 
---width=<width>::
+`--width=<width>`::
 	Specify the terminal width. By default 'git column' will detect the
 	terminal width, or fall back to 80 if it is unable to do so.
 
---indent=<string>::
+`--indent=<string>`::
 	String to be printed at the beginning of each line.
 
---nl=<N>::
+`--nl=<N>`::
 	String to be printed at the end of each line,
 	including newline character.
 
---padding=<N>::
+`--padding=<N>`::
 	The number of spaces between columns. One space by default.
 
 EXAMPLES
diff --git a/Documentation/git-commit-tree.txt b/Documentation/git-commit-tree.txt
index 47f21f4bcc..35b37e9d6d 100644
--- a/Documentation/git-commit-tree.txt
+++ b/Documentation/git-commit-tree.txt
@@ -47,14 +47,14 @@ OPTIONS
 `<tree>`::
 	An existing tree object.
 
--p <parent>::
+`-p <parent>`::
 	Each `-p` indicates the id of a parent commit object.
 
--m <message>::
+`-m <message>`::
 	A paragraph in the commit log message. This can be given more than
 	once and each <message> becomes its own paragraph.
 
--F <file>::
+`-F <file>`::
 	Read the commit log message from the given file. Use `-` to read
 	from the standard input. This can be given more than once and the
 	content of each file becomes its own paragraph.
diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
index 48be5646c4..0594ed1db5 100644
--- a/Documentation/git-commit.txt
+++ b/Documentation/git-commit.txt
@@ -76,13 +76,13 @@ OPTIONS
 	which changes to commit. See linkgit:git-add[1] for
 	details.
 
--C <commit>::
+`-C <commit>`::
 `--reuse-message=<commit>`::
 	Take an existing commit object, and reuse the log message
 	and the authorship information (including the timestamp)
 	when creating the commit.
 
--c <commit>::
+`-c <commit>`::
 `--reedit-message=<commit>`::
 	Like `-C`, but with `-c` the editor is invoked, so that
 	the user can further edit the commit message.
@@ -164,7 +164,7 @@ See linkgit:git-rebase[1] for details.
 	quoted as explained for the configuration variable `core.quotePath`
 	(see linkgit:git-config[1]).
 
--F <file>::
+`-F <file>`::
 `--file=<file>`::
 	Take the commit message from the given file.  Use '-' to
 	read the message from the standard input.
@@ -179,7 +179,7 @@ See linkgit:git-rebase[1] for details.
 `--date=<date>`::
 	Override the author date used in the commit.
 
--m <msg>::
+`-m <msg>`::
 `--message=<msg>`::
 	Use the given <msg> as the commit message.
 	If multiple `-m` options are given, their values are
@@ -187,7 +187,7 @@ See linkgit:git-rebase[1] for details.
 +
 The `-m` option is mutually exclusive with `-c`, `-C`, and `-F`.
 
--t <file>::
+`-t <file>`::
 `--template=<file>`::
 	When editing the commit message, start the editor with the
 	contents in the given file.  The `commit.template` configuration
diff --git a/Documentation/git-config.txt b/Documentation/git-config.txt
index b70aad6e0f..2201ce6058 100644
--- a/Documentation/git-config.txt
+++ b/Documentation/git-config.txt
@@ -98,7 +98,7 @@ OPTIONS
 	in which section and variable names are lowercased, but subsection
 	names are not.
 
---get-urlmatch name URL::
+`--get-urlmatch name URL`::
 	When given a two-part name `section.key`, the value for
 	`section.<url>.key` whose <url> part matches the best to the
 	given URL is returned (if no such key exists, the value for
@@ -141,11 +141,11 @@ See also <<FILES>>.
 	read from or written to if `extensions.worktreeConfig` is
 	present. If not it's the same as `--local`.
 
--f config-file::
---file config-file::
+`-f config-file`::
+`--file config-file`::
 	Use the given config file instead of the one specified by GIT_CONFIG.
 
---blob blob::
+`--blob blob`::
 	Similar to `--file` but use the given blob instead of a file. E.g.
 	you can use 'master:.gitmodules' to read values from the file
 	`.gitmodules` in the `master` branch. See "SPECIFYING REVISIONS"
@@ -174,7 +174,7 @@ See also <<FILES>>.
 	the name/value pairs that are matched to only those where the value
 	is exactly equal to the `value-pattern`.
 
---type <type>::
+`--type <type>`::
   `git config` will ensure that any input or output is valid under the given
   type constraint(s), and will canonicalize outgoing values in `<type>`'s
   canonical form.
@@ -236,7 +236,7 @@ Valid `<type>`'s include:
 	all queried config options with the scope of that value
 	(local, global, system, command).
 
---get-colorbool name [stdout-is-tty]::
+`--get-colorbool name [stdout-is-tty]`::
 
 	Find the color setting for `name` (e.g. `color.diff`) and output
 	"true" or "false".  `stdout-is-tty` should be either "true" or
@@ -247,7 +247,7 @@ Valid `<type>`'s include:
 	When the color setting for `name` is undefined, the command uses
 	`color.ui` as fallback.
 
---get-color name [default]::
+`--get-color name [default]`::
 
 	Find the color configured for `name` (e.g. `color.diff.new`) and
 	output it as the ANSI color escape sequence to the standard
@@ -269,7 +269,7 @@ Valid `<type>`'s include:
 	using `--file`, `--global`, etc) and `on` when searching all
 	config files.
 
---default <value>::
+`--default <value>`::
   When using `--get`, and the requested variable is not found, behave as if
   <value> were the value assigned to the that variable.
 
diff --git a/Documentation/git-credential-cache.txt b/Documentation/git-credential-cache.txt
index e9834b8b95..601f23685a 100644
--- a/Documentation/git-credential-cache.txt
+++ b/Documentation/git-credential-cache.txt
@@ -26,11 +26,11 @@ linkgit:gitcredentials[7] or `EXAMPLES` below.
 OPTIONS
 -------
 
---timeout <seconds>::
+`--timeout <seconds>`::
 
 	Number of seconds to cache credentials (default: 900).
 
---socket <path>::
+`--socket <path>`::
 
 	Use `<path>` to contact a running cache daemon (or start a new
 	cache daemon if one is not started).
diff --git a/Documentation/git-credential-store.txt b/Documentation/git-credential-store.txt
index 3d83420f0a..7fe4049130 100644
--- a/Documentation/git-credential-store.txt
+++ b/Documentation/git-credential-store.txt
@@ -29,7 +29,7 @@ linkgit:gitcredentials[7] or `EXAMPLES` below.
 OPTIONS
 -------
 
---file=<path>::
+`--file=<path>`::
 
 	Use `<path>` to lookup and store credentials. The file will have its
 	filesystem permissions set to prevent other users on the system
diff --git a/Documentation/git-cvsexportcommit.txt b/Documentation/git-cvsexportcommit.txt
index 64e98c4f1d..8514bbd2b2 100644
--- a/Documentation/git-cvsexportcommit.txt
+++ b/Documentation/git-cvsexportcommit.txt
@@ -105,7 +105,7 @@ Merge one patch into CVS (`-c` and `-w` options). The working directory is withi
 	$ git cvsexportcommit -v -c -w ~/project_cvs_checkout <commit-sha1>
 ------------
 
-Merge pending patches into CVS automatically -- only if you really know what you are doing::
+`Merge pending patches into CVS automatically -- only if you really know what you are doing`::
 +
 ------------
 $ export GIT_DIR=~/project/.git
diff --git a/Documentation/git-cvsimport.txt b/Documentation/git-cvsimport.txt
index 5caeed88ed..c5105348ec 100644
--- a/Documentation/git-cvsimport.txt
+++ b/Documentation/git-cvsimport.txt
@@ -52,7 +52,7 @@ OPTIONS
 `-v`::
 	Verbosity: let 'cvsimport' report what it is doing.
 
--d <CVSROOT>::
+`-d <CVSROOT>`::
 	The root of the CVS archive. May be local (a simple path) or remote;
 	currently, only the :local:, :ext: and :pserver: access methods
 	are supported. If not given, `git cvsimport` will try to read it
@@ -64,16 +64,16 @@ OPTIONS
 	If not given, `git cvsimport` tries to read it from
 	`CVS/Repository`.
 
--C <target-dir>::
+`-C <target-dir>`::
 	The Git repository to import to.  If the directory doesn't
         exist, it will be created.  Default is the current directory.
 
--r <remote>::
+`-r <remote>`::
 	The Git remote to import this CVS repository into.
 	Moves all CVS branches into remotes/<remote>/<branch>
 	akin to the way `git clone` uses `origin` by default.
 
--o <branch-for-HEAD>::
+`-o <branch-for-HEAD>`::
 	When no remote is specified (via `-r`) the `HEAD` branch
 	from CVS is imported to the `origin` branch within the Git
 	repository, as `HEAD` already has a special meaning for Git.
@@ -98,20 +98,20 @@ the old cvs2git tool.
 `-u`::
 	Convert underscores in tag and branch names to dots.
 
--s <subst>::
+`-s <subst>`::
 	Substitute the character "/" in branch names with <subst>
 
--p <options-for-cvsps>::
+`-p <options-for-cvsps>`::
 	Additional options for cvsps.
 	The options `-u` and `-A` are implicit and should not be used here.
 +
 If you need to pass multiple options, separate them with a comma.
 
--z <fuzz>::
+`-z <fuzz>`::
 	Pass the timestamp fuzz factor to cvsps, in seconds. If unset,
 	cvsps defaults to 300s.
 
--P <cvsps-output-file>::
+`-P <cvsps-output-file>`::
 	Instead of calling cvsps, read the provided cvsps output file. Useful
 	for debugging or when cvsps is being handled outside cvsimport.
 
@@ -120,7 +120,7 @@ If you need to pass multiple options, separate them with a comma.
 	will enable default regexes that try to capture the source
 	branch name from the commit message.
 
--M <regex>::
+`-M <regex>`::
 	Attempt to detect merges based on the commit message with a custom
 	regex. It can be used with `-m` to enable the default regexes
 	as well. You must escape forward slashes.
@@ -129,18 +129,18 @@ The regex must capture the source branch name in $1.
 +
 This option can be used several times to provide several detection regexes.
 
--S <regex>::
+`-S <regex>`::
 	Skip paths matching the regex.
 
 `-a`::
 	Import all commits, including recent ones. cvsimport by default
 	skips commits that have a timestamp less than 10 minutes ago.
 
--L <limit>::
+`-L <limit>`::
 	Limit the number of commits imported. Workaround for cases where
 	cvsimport leaks memory.
 
--A <author-conv-file>::
+`-A <author-conv-file>`::
 	CVS by default uses the Unix username when writing its
 	commit logs. Using this option and an author-conv-file
 	maps the name recorded in CVS to author name, e-mail and
diff --git a/Documentation/git-cvsserver.txt b/Documentation/git-cvsserver.txt
index 5b7bfe6dc0..23647e12b0 100644
--- a/Documentation/git-cvsserver.txt
+++ b/Documentation/git-cvsserver.txt
@@ -31,7 +31,7 @@ All these options obviously only make sense if enforced by the server side.
 They have been implemented to resemble the linkgit:git-daemon[1] options as
 closely as possible.
 
---base-path <path>::
+`--base-path <path>`::
 Prepend 'path' to requested CVSROOT
 
 `--strict-paths`::
diff --git a/Documentation/git-describe.txt b/Documentation/git-describe.txt
index 39cecb4ce6..69cc3b2db9 100644
--- a/Documentation/git-describe.txt
+++ b/Documentation/git-describe.txt
@@ -93,7 +93,7 @@ OPTIONS
 	describe such a commit as v1.2-0-gdeadbee (0th commit since tag v1.2
 	that points at object deadbee....).
 
---match <pattern>::
+`--match <pattern>`::
 	Only consider tags matching the given `glob(7)` pattern,
 	excluding the `refs/tags/` prefix. If used with `--all`, it also
 	considers local branches and remote-tracking references matching the
@@ -103,7 +103,7 @@ OPTIONS
 	matching any of the patterns will be considered.  Use `--no-match` to
 	clear and reset the list of patterns.
 
---exclude <pattern>::
+`--exclude <pattern>`::
 	Do not consider tags matching the given `glob(7)` pattern, excluding
 	the `refs/tags/` prefix. If used with `--all`, it also does not consider
 	local branches and remote-tracking references matching the pattern,
diff --git a/Documentation/git-diff-files.txt b/Documentation/git-diff-files.txt
index 5a993a309f..9c90566859 100644
--- a/Documentation/git-diff-files.txt
+++ b/Documentation/git-diff-files.txt
@@ -22,10 +22,10 @@ OPTIONS
 -------
 include::diff-options.txt[]
 
--1 --base::
--2 --ours::
--3 --theirs::
--0::
+`-1 --base`::
+`-2 --ours`::
+`-3 --theirs`::
+`-0`::
 	Diff against the "base" version, "our branch" or "their
 	branch" respectively.  With these options, diffs for
 	merged entries are not shown.
diff --git a/Documentation/git-diff.txt b/Documentation/git-diff.txt
index 7779631421..de1e14726c 100644
--- a/Documentation/git-diff.txt
+++ b/Documentation/git-diff.txt
@@ -117,16 +117,16 @@ OPTIONS
 :git-diff: 1
 include::diff-options.txt[]
 
--1 --base::
--2 --ours::
--3 --theirs::
+`-1 --base`::
+`-2 --ours`::
+`-3 --theirs`::
 	Compare the working tree with the "base" version (stage #1),
 	"our branch" (stage #2) or "their branch" (stage #3).  The
 	index contains these stages only for unmerged entries i.e.
 	while resolving conflicts.  See linkgit:git-read-tree[1]
 	section "3-Way Merge" for detailed information.
 
--0::
+`-0`::
 	Omit diff output for unmerged entries and just show
 	"Unmerged".  Can be used only when comparing the working tree
 	with the index.
diff --git a/Documentation/git-difftool.txt b/Documentation/git-difftool.txt
index f8b1e83404..24a2b7cc36 100644
--- a/Documentation/git-difftool.txt
+++ b/Documentation/git-difftool.txt
@@ -42,7 +42,7 @@ OPTIONS
 	Start showing the diff for the given path, skipping all
 	the paths before it.
 
--t <tool>::
+`-t <tool>`::
 `--tool=<tool>`::
 	Use the diff tool specified by <tool>.  Valid values include
 	emerge, kompare, meld, and vimdiff. Run `git difftool --tool-help`
@@ -86,7 +86,7 @@ with custom merge tool commands and has the same value as `$MERGED`.
 Specifying `--no-symlinks` instructs `git difftool` to create copies
 instead.  `--no-symlinks` is the default on Windows.
 
--x <command>::
+`-x <command>`::
 `--extcmd=<command>`::
 	Specify a custom command for viewing diffs.
 	`git-difftool` ignores the configured defaults and runs
diff --git a/Documentation/git-filter-branch.txt b/Documentation/git-filter-branch.txt
index 4a72e4ce44..01b572f565 100644
--- a/Documentation/git-filter-branch.txt
+++ b/Documentation/git-filter-branch.txt
@@ -95,25 +95,25 @@ multiple commits.
 OPTIONS
 -------
 
---setup <command>::
+`--setup <command>`::
 	This is not a real filter executed for each commit but a one
 	time setup just before the loop. Therefore no commit-specific
 	variables are defined yet.  Functions or variables defined here
 	can be used or modified in the following filter steps except
 	the commit filter, for technical reasons.
 
---subdirectory-filter <directory>::
+`--subdirectory-filter <directory>`::
 	Only look at the history which touches the given subdirectory.
 	The result will contain that directory (and only that) as its
 	project root. Implies <<Remap_to_ancestor>>.
 
---env-filter <command>::
+`--env-filter <command>`::
 	This filter may be used if you only need to modify the environment
 	in which the commit will be performed.  Specifically, you might
 	want to rewrite the author/committer name/email/time environment
 	variables (see linkgit:git-commit-tree[1] for details).
 
---tree-filter <command>::
+`--tree-filter <command>`::
 	This is the filter for rewriting the tree and its contents.
 	The argument is evaluated in shell with the working
 	directory set to the root of the checked out tree.  The new tree
@@ -121,14 +121,14 @@ OPTIONS
 	are auto-removed - neither .gitignore files nor any other ignore
 	rules *HAVE ANY EFFECT*!).
 
---index-filter <command>::
+`--index-filter <command>`::
 	This is the filter for rewriting the index.  It is similar to the
 	tree filter but does not check out the tree, which makes it much
 	faster.  Frequently used with `git rm --cached
 	--ignore-unmatch ...`, see EXAMPLES below.  For hairy
 	cases, see linkgit:git-update-index[1].
 
---parent-filter <command>::
+`--parent-filter <command>`::
 	This is the filter for rewriting the commit's parent list.
 	It will receive the parent string on stdin and shall output
 	the new parent string on stdout.  The parent string is in
@@ -136,13 +136,13 @@ OPTIONS
 	the initial commit, `-p parent` for a normal commit and
 	`-p parent1 -p parent2 -p parent3 ...` for a merge commit.
 
---msg-filter <command>::
+`--msg-filter <command>`::
 	This is the filter for rewriting the commit messages.
 	The argument is evaluated in the shell with the original
 	commit message on standard input; its standard output is
 	used as the new commit message.
 
---commit-filter <command>::
+`--commit-filter <command>`::
 	This is the filter for performing the commit.
 	If this filter is specified, it will be called instead of the
 	`git commit-tree` command, with arguments of the form
@@ -162,7 +162,7 @@ You can also use the `git_commit_non_empty_tree "$@"` instead of
 `git commit-tree "$@"` if you don't wish to keep commits with a single parent
 and that makes no change to the tree.
 
---tag-name-filter <command>::
+`--tag-name-filter <command>`::
 	This is the filter for rewriting tag names. When passed,
 	it will be called for every tag ref that points to a rewritten
 	object (or to a tag object which points to a rewritten object).
@@ -193,11 +193,11 @@ to other tags will be rewritten to point to the underlying commit.
 	`--commit-filter`, though the same effect can be achieved by using the
 	provided `git_commit_non_empty_tree` function in a commit filter.
 
---original <namespace>::
+`--original <namespace>`::
 	Use this option to set the namespace where the original commits
 	will be stored. The default value is `refs/original`.
 
--d <directory>::
+`-d <directory>`::
 	Use this option to set the path to the temporary directory used for
 	rewriting.  When applying a tree filter, the command needs to
 	temporarily check out the tree to some directory, which may consume
@@ -211,7 +211,7 @@ to other tags will be rewritten to point to the underlying commit.
 	directory or when there are already refs starting with
 	`refs/original/`, unless forced.
 
---state-branch <branch>::
+`--state-branch <branch>`::
 	This option will cause the mapping from old to new objects to
 	be loaded from named branch upon startup and saved as a new
 	commit to that branch upon exit, enabling incremental of large
diff --git a/Documentation/git-fmt-merge-msg.txt b/Documentation/git-fmt-merge-msg.txt
index 283bb59199..1ea37635d8 100644
--- a/Documentation/git-fmt-merge-msg.txt
+++ b/Documentation/git-fmt-merge-msg.txt
@@ -39,13 +39,13 @@ OPTIONS
 	Synonyms to `--log` and `--no-log`; these are deprecated and will be
 	removed in the future.
 
--m <message>::
---message <message>::
+`-m <message>`::
+`--message <message>`::
 	Use <message> instead of the branch names for the first line
 	of the log message.  For use with `--log`.
 
--F <file>::
---file <file>::
+`-F <file>`::
+`--file <file>`::
 	Take the list of merged objects from <file> instead of
 	stdin.
 
diff --git a/Documentation/git-for-each-repo.txt b/Documentation/git-for-each-repo.txt
index c2d6cd6629..af959b1cd9 100644
--- a/Documentation/git-for-each-repo.txt
+++ b/Documentation/git-for-each-repo.txt
@@ -33,7 +33,7 @@ in the multi-valued config variable `maintenance.repo`.
 
 OPTIONS
 -------
---config=<config>::
+`--config=<config>`::
 	Use the given config variable as a multi-valued list storing
 	absolute path names. Iterate on that list of paths to run
 	the given arguments.
diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
index 3372e13868..fc2501c9e0 100644
--- a/Documentation/git-format-patch.txt
+++ b/Documentation/git-format-patch.txt
@@ -110,8 +110,8 @@ include::diff-options.txt[]
 `-<n>`::
 	Prepare patches from the topmost <n> commits.
 
--o <dir>::
---output-directory <dir>::
+`-o <dir>`::
+`--output-directory <dir>`::
 	Use <dir> to store the resulting files, instead of the
 	current working directory.
 
@@ -123,7 +123,7 @@ include::diff-options.txt[]
 `--no-numbered`::
 	Name output in '[PATCH]' format.
 
---start-number <n>::
+`--start-number <n>`::
 	Start numbering the patches at <n> instead of 1.
 
 `--numbered-files`::
@@ -180,7 +180,7 @@ Beware that the default for `git send-email` is to thread emails
 itself.  If you want `git format-patch` to take care of threading, you
 will want to ensure that threading is disabled for `git send-email`.
 
---in-reply-to=<message id>::
+`--in-reply-to=<message id>`::
 	Make the first mail (or all the mails with `--no-thread`) appear as a
 	reply to the given <message id>, which avoids breaking threads to
 	provide a new patch series.
@@ -212,7 +212,7 @@ is greater than 100 bytes, then the mode will be `message`, otherwise
 If `<mode>` is `none`, both the cover letter subject and body will be
 populated with placeholder text.
 
---subject-prefix=<subject prefix>::
+`--subject-prefix=<subject prefix>`::
 	Instead of the standard '[PATCH]' prefix in the subject
 	line, instead use '[<subject prefix>]'. This
 	allows for useful naming of a patch series, and can be
@@ -230,7 +230,7 @@ populated with placeholder text.
 	Comments"; use this when sending an experimental patch for
 	discussion rather than application.
 
--v <n>::
+`-v <n>`::
 `--reroll-count=<n>`::
 	Mark the series as the <n>-th iteration of the topic. The
 	output filenames have `v<n>` prepended to them, and the
diff --git a/Documentation/git-fsck.txt b/Documentation/git-fsck.txt
index f942c5a7a6..6c98485d8f 100644
--- a/Documentation/git-fsck.txt
+++ b/Documentation/git-fsck.txt
@@ -129,7 +129,7 @@ using `git commit-graph verify`. See linkgit:git-commit-graph[1].
 Extracted Diagnostics
 ---------------------
 
-unreachable <type> <object>::
+`unreachable <type> <object>`::
 	The <type> object <object>, isn't actually referred to directly
 	or indirectly in any of the trees or commits seen. This can
 	mean that there's another root node that you're not specifying
@@ -137,15 +137,15 @@ unreachable <type> <object>::
 	then you might as well delete unreachable nodes since they
 	can't be used.
 
-missing <type> <object>::
+`missing <type> <object>`::
 	The <type> object <object>, is referred to but isn't present in
 	the database.
 
-dangling <type> <object>::
+`dangling <type> <object>`::
 	The <type> object <object>, is present in the database but never
 	'directly' used. A dangling commit could be a root node.
 
-hash mismatch <object>::
+`hash mismatch <object>`::
 	The database has an object whose hash doesn't match the
 	object database value.
 	This indicates a serious data integrity problem.
diff --git a/Documentation/git-grep.txt b/Documentation/git-grep.txt
index 478abece38..6f71b659d0 100644
--- a/Documentation/git-grep.txt
+++ b/Documentation/git-grep.txt
@@ -118,7 +118,7 @@ OPTIONS
 `-I`::
 	Don't match the pattern in binary files.
 
---max-depth <depth>::
+`--max-depth <depth>`::
 	For each <pathspec> given on command line, descend at most <depth>
 	levels of directories. A value of -1 means no limit.
 	This option is ignored if <pathspec> contains active wildcards.
@@ -246,18 +246,18 @@ providing this option will cause it to die.
 	linkgit:gitattributes[5]).
 
 `-<num>`::
--C <num>::
---context <num>::
+`-C <num>`::
+`--context <num>`::
 	Show <num> leading and trailing lines, and place a line
 	containing `--` between contiguous groups of matches.
 
--A <num>::
---after-context <num>::
+`-A <num>`::
+`--after-context <num>`::
 	Show <num> trailing lines, and place a line containing
 	`--` between contiguous groups of matches.
 
--B <num>::
---before-context <num>::
+`-B <num>`::
+`--before-context <num>`::
 	Show <num> leading lines, and place a line containing
 	`--` between contiguous groups of matches.
 
@@ -270,11 +270,11 @@ providing this option will cause it to die.
 	`git diff` works out patch hunk headers (see 'Defining a
 	custom hunk-header' in linkgit:gitattributes[5]).
 
---threads <num>::
+`--threads <num>`::
 	Number of grep worker threads to use.
 	See `grep.threads` in 'CONFIGURATION' for more information.
 
--f <file>::
+`-f <file>`::
 	Read patterns from <file>, one per line.
 +
 Passing the pattern via <file> allows for providing a search pattern
diff --git a/Documentation/git-hash-object.txt b/Documentation/git-hash-object.txt
index 40f5574afe..b9f1081f6e 100644
--- a/Documentation/git-hash-object.txt
+++ b/Documentation/git-hash-object.txt
@@ -23,7 +23,7 @@ When <type> is not specified, it defaults to "blob".
 OPTIONS
 -------
 
--t <type>::
+`-t <type>`::
 	Specify the type (default: "blob").
 
 `-w`::
diff --git a/Documentation/git-http-fetch.txt b/Documentation/git-http-fetch.txt
index 63e447642e..0bcdc90294 100644
--- a/Documentation/git-http-fetch.txt
+++ b/Documentation/git-http-fetch.txt
@@ -30,7 +30,7 @@ OPTIONS
 `-v`::
 	Report what is downloaded.
 
--w <filename>::
+`-w <filename>`::
         Writes the commit-id into the filename under `$GIT_DIR/refs/<filename>` on
         the local end after the transfer is complete.
 
diff --git a/Documentation/git-index-pack.txt b/Documentation/git-index-pack.txt
index b42e095f3e..01a212a579 100644
--- a/Documentation/git-index-pack.txt
+++ b/Documentation/git-index-pack.txt
@@ -28,7 +28,7 @@ OPTIONS
 `-v`::
 	Be verbose about what is going on, including progress status.
 
--o <index-file>::
+`-o <index-file>`::
 	Write the generated pack index into the specified
 	file.  Without this option the name of pack index
 	file is constructed from the name of packed archive
diff --git a/Documentation/git-init.txt b/Documentation/git-init.txt
index cfa190859e..b537591829 100644
--- a/Documentation/git-init.txt
+++ b/Documentation/git-init.txt
@@ -62,7 +62,7 @@ include::object-format-disclaimer.txt[]
 Specify the directory from which templates will be used.  (See the "TEMPLATE
 DIRECTORY" section below.)
 
---separate-git-dir=<git dir>::
+`--separate-git-dir=<git dir>`::
 
 Instead of initializing the repository as a directory to either `$GIT_DIR` or
 `./.git/`, create a text file there containing the path to the actual
@@ -71,7 +71,7 @@ repository.
 +
 If this is reinitialization, the repository will be moved to the specified path.
 
--b <branch-name>::
+`-b <branch-name>`::
 `--initial-branch=<branch-name>`::
 
 Use the specified name for the initial branch in the newly created
@@ -110,7 +110,7 @@ the repository permissions.
 
 Same as 'group', but make the repository readable by all users.
 
-'0xxx'::
+`0xxx`::
 
 '0xxx' is an octal number and each file will have mode '0xxx'. '0xxx' will
 override users' umask(2) value (and not only loosen permissions as 'group' and
diff --git a/Documentation/git-interpret-trailers.txt b/Documentation/git-interpret-trailers.txt
index dc2974c611..be2ba5f545 100644
--- a/Documentation/git-interpret-trailers.txt
+++ b/Documentation/git-interpret-trailers.txt
@@ -84,7 +84,7 @@ OPTIONS
 	trailer to the input messages. See the description of this
 	command.
 
---where <placement>::
+`--where <placement>`::
 `--no-where`::
 	Specify where all new trailers will be added.  A setting
 	provided with `--where` overrides all configuration variables
@@ -92,7 +92,7 @@ OPTIONS
 	`--where` or `--no-where`. Possible values are `after`, `before`,
 	`end` or `start`.
 
---if-exists <action>::
+`--if-exists <action>`::
 `--no-if-exists`::
 	Specify what action will be performed when there is already at
 	least one trailer with the same <token> in the message.  A setting
@@ -101,7 +101,7 @@ OPTIONS
 	`--if-exists` or `--no-if-exists`. Possible actions are `addIfDifferent`,
 	`addIfDifferentNeighbor`, `add`, `replace` and `doNothing`.
 
---if-missing <action>::
+`--if-missing <action>`::
 `--no-if-missing`::
 	Specify what action will be performed when there is no other
 	trailer with the same <token> in the message.  A setting
diff --git a/Documentation/git-log.txt b/Documentation/git-log.txt
index 21f9328681..83555dc7dc 100644
--- a/Documentation/git-log.txt
+++ b/Documentation/git-log.txt
@@ -79,7 +79,7 @@ produced by `--stat`, etc.
 
 include::line-range-options.txt[]
 
-<revision range>::
+`<revision range>`::
 	Show only commits in the specified revision range.  When no
 	<revision range> is specified, it defaults to `HEAD` (i.e. the
 	whole history leading to the current commit).  `origin..HEAD`
diff --git a/Documentation/git-ls-files.txt b/Documentation/git-ls-files.txt
index 0e26aafc63..72f1f28902 100644
--- a/Documentation/git-ls-files.txt
+++ b/Documentation/git-ls-files.txt
@@ -88,13 +88,13 @@ OPTIONS
 	When any of the `-t`, `--unmerged`, or `--stage` option is
 	in use, this option has no effect.
 
--x <pattern>::
+`-x <pattern>`::
 `--exclude=<pattern>`::
 	Skip untracked files matching pattern.
 	Note that pattern is a shell wildcard pattern. See EXCLUDE PATTERNS
 	below for more information.
 
--X <file>::
+`-X <file>`::
 `--exclude-from=<file>`::
 	Read exclude patterns from <file>; 1 per line.
 
diff --git a/Documentation/git-ls-remote.txt b/Documentation/git-ls-remote.txt
index 6dc89de377..0bc6dbabf3 100644
--- a/Documentation/git-ls-remote.txt
+++ b/Documentation/git-ls-remote.txt
@@ -72,7 +72,7 @@ OPTIONS
 	themselves will not work for refs whose objects have not yet been
 	fetched from the remote, and will give a `missing object` error.
 
--o <option>::
+`-o <option>`::
 `--server-option=<option>`::
 	Transmit the given string to the server when communicating using
 	protocol version 2.  The given string must not contain a NUL or LF
diff --git a/Documentation/git-merge-file.txt b/Documentation/git-merge-file.txt
index d7605b60f0..8caebefcc2 100644
--- a/Documentation/git-merge-file.txt
+++ b/Documentation/git-merge-file.txt
@@ -52,7 +52,7 @@ linkgit:git[1].
 OPTIONS
 -------
 
--L <label>::
+`-L <label>`::
 	This option may be given up to three times, and
 	specifies labels to be used in place of the
 	corresponding file names in conflict reports. That is,
@@ -67,7 +67,7 @@ OPTIONS
 `-q`::
 	Quiet; do not warn about conflicts.
 
---diff3::
+`--diff3`::
 	Show conflicts in "diff3" style.
 
 `--ours`::
diff --git a/Documentation/git-merge.txt b/Documentation/git-merge.txt
index de57a4fb54..ac5838dfb0 100644
--- a/Documentation/git-merge.txt
+++ b/Documentation/git-merge.txt
@@ -63,7 +63,7 @@ OPTIONS
 -------
 include::merge-options.txt[]
 
--m <msg>::
+`-m <msg>`::
 	Set the commit message to be used for the merge commit (in
 	case one is created).
 +
@@ -74,7 +74,7 @@ The `git fmt-merge-msg` command can be
 used to give a good default for automated `git merge`
 invocations. The automated message can include the branch description.
 
--F <file>::
+`-F <file>`::
 `--file=<file>`::
 	Read the commit message to be used for the merge commit (in
 	case one is created).
diff --git a/Documentation/git-mergetool.txt b/Documentation/git-mergetool.txt
index 1a5b30b293..28f5169268 100644
--- a/Documentation/git-mergetool.txt
+++ b/Documentation/git-mergetool.txt
@@ -24,7 +24,7 @@ the merge tool program on every file with merge conflicts.
 
 OPTIONS
 -------
--t <tool>::
+`-t <tool>`::
 `--tool=<tool>`::
 	Use the merge resolution program specified by <tool>.
 	Valid values include emerge, gvimdiff, kdiff3,
diff --git a/Documentation/git-notes.txt b/Documentation/git-notes.txt
index 16afea280d..9f22359707 100644
--- a/Documentation/git-notes.txt
+++ b/Documentation/git-notes.txt
@@ -129,7 +129,7 @@ OPTIONS
 	When adding notes to an object that already has notes,
 	overwrite the existing notes (instead of aborting).
 
--m <msg>::
+`-m <msg>`::
 `--message=<msg>`::
 	Use the given note message (instead of prompting).
 	If multiple `-m` options are given, their values
@@ -137,20 +137,20 @@ OPTIONS
 	Lines starting with `#` and empty lines other than a
 	single line between paragraphs will be stripped out.
 
--F <file>::
+`-F <file>`::
 `--file=<file>`::
 	Take the note message from the given file.  Use '-' to
 	read the note message from the standard input.
 	Lines starting with `#` and empty lines other than a
 	single line between paragraphs will be stripped out.
 
--C <object>::
+`-C <object>`::
 `--reuse-message=<object>`::
 	Take the given blob object (for example, another note) as the
 	note message. (Use `git notes copy <object>` instead to
 	copy notes between objects.)
 
--c <object>::
+`-c <object>`::
 `--reedit-message=<object>`::
 	Like `-C`, but with `-c` the editor is invoked, so that
 	the user can further edit the note message.
@@ -159,7 +159,7 @@ OPTIONS
 	Allow an empty note object to be stored. The default behavior is
 	to automatically remove empty notes.
 
---ref <ref>::
+`--ref <ref>`::
 	Manipulate the notes tree in <ref>.  This overrides
 	`GIT_NOTES_REF` and the `core.notesRef` configuration.  The ref
 	specifies the full refname when it begins with `refs/notes/`; when it
@@ -180,7 +180,7 @@ OPTIONS
 	Do not remove anything; just report the object names whose notes
 	would be removed.
 
--s <strategy>::
+`-s <strategy>`::
 `--strategy=<strategy>`::
 	When merging notes, resolve notes conflicts using the given
 	strategy. The following strategies are recognized: "manual"
diff --git a/Documentation/git-p4.txt b/Documentation/git-p4.txt
index 90280af75b..812d0afd4c 100644
--- a/Documentation/git-p4.txt
+++ b/Documentation/git-p4.txt
@@ -202,7 +202,7 @@ General options
 ~~~~~~~~~~~~~~~
 All commands except clone accept these options.
 
---git-dir <dir>::
+`--git-dir <dir>`::
 	Set the `GIT_DIR` environment variable.  See linkgit:git[1].
 
 `-v`::
@@ -214,7 +214,7 @@ Sync options
 These options can be used in the initial 'clone' as well as in
 subsequent 'sync' operations.
 
---branch <ref>::
+`--branch <ref>`::
 	Import changes into <ref> instead of refs/remotes/p4/master.
 	If <ref> starts with refs/, it is used as is.  Otherwise, if
 	it does not start with p4/, that prefix is added.
@@ -237,7 +237,7 @@ Git repository:
 	Use the branch detection algorithm to find new paths in p4.  It is
 	documented below in "BRANCH DETECTION".
 
---changesfile <file>::
+`--changesfile <file>`::
 	Import exactly the p4 change numbers listed in 'file', one per
 	line.  Normally, `git p4` inspects the current p4 repository
 	state and detects the changes it should import.
@@ -261,14 +261,14 @@ Git repository:
 	sync operations must specify `--import-local` as well so that
 	they can find the p4 branches in refs/heads.
 
---max-changes <n>::
+`--max-changes <n>`::
 	Import at most 'n' changes, rather than the entire range of
 	changes included in the given revision specifier. A typical
 	usage would be use '@all' as the revision specifier, but then
 	to use `--max-changes 1000` to import only the last 1000
 	revisions rather than the entire revision history.
 
---changes-block-size <n>::
+`--changes-block-size <n>`::
 	The internal block size to use when converting a revision
 	specifier such as '@all' into a list of specific change
 	numbers. Instead of using a single call to `p4 changes` to
@@ -297,7 +297,7 @@ Clone options
 These options can be used in an initial 'clone', along with the 'sync'
 options described above.
 
---destination <directory>::
+`--destination <directory>`::
 	Where to create the Git repository.  If not provided, the last
 	component in the p4 depot path is used to create a new
 	directory.
@@ -309,7 +309,7 @@ Submit options
 ~~~~~~~~~~~~~~
 These options can be used to modify `git p4 submit` behavior.
 
---origin <commit>::
+`--origin <commit>`::
 	Upstream location from which commits are identified to submit to
 	p4.  By default, this is the most recent p4 commit reachable
 	from `HEAD`.
@@ -333,7 +333,7 @@ These options can be used to modify `git p4 submit` behavior.
 	Show just what commits would be submitted to p4; do not change
 	state in Git or p4.
 
---prepare-p4-only::
+`--prepare-p4-only`::
 	Apply a commit to the p4 workspace, opening, adding and deleting
 	files in p4 as for a normal submit operation.  Do not issue the
 	final `p4 submit`, but instead print a message about how to
@@ -345,7 +345,7 @@ These options can be used to modify `git p4 submit` behavior.
 	After creating each shelve, the relevant files are reverted/deleted.
 	If you have multiple commits pending multiple shelves will be created.
 
---update-shelve CHANGELIST::
+`--update-shelve CHANGELIST`::
 	Update an existing shelved changelist with this commit. Implies
 	`--shelve`. Repeat for multiple shelved changelists.
 
@@ -356,7 +356,7 @@ These options can be used to modify `git p4 submit` behavior.
 	to bypass the prompt, causing conflicting commits to be automatically
 	skipped, or to quit trying to apply commits, without prompting.
 
---branch <branch>::
+`--branch <branch>`::
 	After submitting, sync this named branch instead of the default
 	p4/master.  See the "Sync options" section above for more
 	information.
@@ -369,7 +369,7 @@ These options can be used to modify `git p4 submit` behavior.
     Disable the automatic rebase after all commits have been successfully
     submitted. Can also be set with `git-p4.disableRebase`.
 
---disable-p4sync::
+`--disable-p4sync`::
     Disable the automatic sync of `p4/master` from Perforce after commits have
     been submitted. Implies `--disable-rebase`. Can also be set with
     `git-p4.disableP4Sync`. Sync with `origin/master` still goes ahead if possible.
diff --git a/Documentation/git-prune.txt b/Documentation/git-prune.txt
index 1e4a2a648f..ff5b13c029 100644
--- a/Documentation/git-prune.txt
+++ b/Documentation/git-prune.txt
@@ -45,7 +45,7 @@ OPTIONS
 `--progress`::
 	Show progress.
 
---expire <time>::
+`--expire <time>`::
 	Only expire loose objects older than <time>.
 
 \--::
diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
index c33ebe5f4a..fc805da72f 100644
--- a/Documentation/git-push.txt
+++ b/Documentation/git-push.txt
@@ -212,7 +212,7 @@ already exists on the remote side.
 	Either all refs are updated, or on error, no refs are updated.
 	If the server does not support atomic pushes the push will fail.
 
--o <option>::
+`-o <option>`::
 `--push-option=<option>`::
 	Transmit the given string to the server, which passes them to
 	the pre-receive as well as the post-receive hook. The given string
@@ -419,12 +419,12 @@ Specifying `--no-force-if-includes` disables this behavior.
 	default is `--verify`, giving the hook a chance to prevent the
 	push.  With `--no-verify`, the hook is bypassed completely.
 
--4::
---ipv4::
+`-4`::
+`--ipv4`::
 	Use IPv4 addresses only, ignoring IPv6 addresses.
 
--6::
---ipv6::
+`-6`::
+`--ipv6`::
 	Use IPv6 addresses only, ignoring IPv4 addresses.
 
 include::urls-remotes.txt[]
@@ -474,7 +474,7 @@ For a failed update, more details are given:
 	Git did not try to send the ref at all, typically because it
 	is not a fast-forward and you did not force the update.
 
-remote rejected::
+`remote rejected`::
 	The remote end refused the update.  Usually caused by a hook
 	on the remote side, or because the remote repository has one
 	of the following safety options in effect:
@@ -483,7 +483,7 @@ remote rejected::
 	non-fast-forward updates), `receive.denyDeletes` or
 	`receive.denyDeleteCurrent`.  See linkgit:git-config[1].
 
-remote failure::
+`remote failure`::
 	The remote end did not report the successful update of the ref,
 	perhaps because of a temporary error on the remote side, a
 	break in the network connection, or other transient error.
diff --git a/Documentation/git-quiltimport.txt b/Documentation/git-quiltimport.txt
index c3ec9efe38..c6c64529e4 100644
--- a/Documentation/git-quiltimport.txt
+++ b/Documentation/git-quiltimport.txt
@@ -38,18 +38,18 @@ OPTIONS
 	a patch.  At the time of this writing only missing author
 	information is warned about.
 
---author Author Name <Author Email>::
+`--author Author Name <Author Email>`::
 	The author name and email address to use when no author
 	information can be found in the patch description.
 
---patches <dir>::
+`--patches <dir>`::
 	The directory to find the quilt patches.
 +
 The default for the patch directory is patches
 or the value of the `$QUILT_PATCHES` environment
 variable.
 
---series <file>::
+`--series <file>`::
 	The quilt series file.
 +
 The default for the series file is <patches>/series
diff --git a/Documentation/git-range-diff.txt b/Documentation/git-range-diff.txt
index 8703bef8ef..5f20b86e57 100644
--- a/Documentation/git-range-diff.txt
+++ b/Documentation/git-range-diff.txt
@@ -81,14 +81,14 @@ to revert to color all lines according to the outer diff markers
 	This flag is passed to the `git log` program
 	(see linkgit:git-log[1]) that generates the patches.
 
-<range1> <range2>::
+`<range1> <range2>`::
 	Compare the commits specified by the two ranges, where
 	`<range1>` is considered an older version of `<range2>`.
 
 <rev1>...<rev2>::
 	Equivalent to passing `<rev2>..<rev1>` and `<rev1>..<rev2>`.
 
-<base> <rev1> <rev2>::
+`<base> <rev1> <rev2>`::
 	Equivalent to passing `<base>..<rev1>` and `<base>..<rev2>`.
 	Note that `<base>` does not need to be the exact branch point
 	of the branches. Example: after rebasing a branch `my-topic`,
diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index f32ffaa011..589b2d17c9 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -208,7 +208,7 @@ include::config/sequencer.txt[]
 
 OPTIONS
 -------
---onto <newbase>::
+`--onto <newbase>`::
 	Starting point at which to create the new commits. If the
 	`--onto` option is not specified, the starting point is
 	<upstream>.  May be any valid commit, and not just an
@@ -358,7 +358,7 @@ other words, the sides are swapped.
 +
 See also INCOMPATIBLE OPTIONS below.
 
--s <strategy>::
+`-s <strategy>`::
 `--strategy=<strategy>`::
 	Use the given merge strategy.
 	If there is no `-s` option `git merge-recursive` is used
@@ -371,7 +371,7 @@ which makes little sense.
 +
 See also INCOMPATIBLE OPTIONS below.
 
--X <strategy-option>::
+`-X <strategy-option>`::
 `--strategy-option=<strategy-option>`::
 	Pass the <strategy-option> through to the merge strategy.
 	This implies `--merge` and, if no strategy has been
@@ -554,8 +554,8 @@ idea unless you know what you are doing (see BUGS below).
 +
 See also INCOMPATIBLE OPTIONS below.
 
--x <cmd>::
---exec <cmd>::
+`-x <cmd>`::
+`--exec <cmd>`::
 	Append "exec <cmd>" after each line creating a commit in the
 	final history. <cmd> will be interpreted as one or more shell
 	commands. Any command that fails will interrupt the rebase,
diff --git a/Documentation/git-receive-pack.txt b/Documentation/git-receive-pack.txt
index 921f658bd8..6756a819e9 100644
--- a/Documentation/git-receive-pack.txt
+++ b/Documentation/git-receive-pack.txt
@@ -38,7 +38,7 @@ its behavior, see linkgit:git-config[1].
 
 OPTIONS
 -------
-<directory>::
+`<directory>`::
 	The repository to sync into.
 
 PRE-RECEIVE HOOK
diff --git a/Documentation/git-replace.txt b/Documentation/git-replace.txt
index fc6fc6ae6f..5c6c4892ef 100644
--- a/Documentation/git-replace.txt
+++ b/Documentation/git-replace.txt
@@ -66,7 +66,7 @@ OPTIONS
 `--delete`::
 	Delete existing replace refs for the given objects.
 
---edit <object>::
+`--edit <object>`::
 	Edit an object's content interactively. The existing content
 	for <object> is pretty-printed into a temporary file, an
 	editor is launched on the file, and the result is parsed to
@@ -96,8 +96,8 @@ OPTIONS
 	and deletes that file upon success. The purpose is to help users
 	with transitioning off of the now-deprecated graft file.
 
--l <pattern>::
---list <pattern>::
+`-l <pattern>`::
+`--list <pattern>`::
 	List replace refs for objects that match the given pattern (or
 	all if no pattern is given).
 	Typing `git replace` without arguments, also lists all replace
diff --git a/Documentation/git-reset.txt b/Documentation/git-reset.txt
index 7e44572383..cf524cd1e5 100644
--- a/Documentation/git-reset.txt
+++ b/Documentation/git-reset.txt
@@ -203,7 +203,7 @@ $ git reset --hard HEAD~3   <1>
     "RECOVERING FROM UPSTREAM REBASE" section in linkgit:git-rebase[1]
     for the implications of doing so.)
 
-Undo a merge or pull::
+`Undo a merge or pull`::
 +
 ------------
 $ git pull                         <1>
@@ -253,7 +253,7 @@ $ git reset --merge ORIG_HEAD      <2>
     want.  `git reset --merge` keeps your local changes.
 
 
-Interrupted workflow::
+`Interrupted workflow`::
 +
 Suppose you are interrupted by an urgent fix request while you
 are in the middle of a large change.  The files in your
@@ -298,7 +298,7 @@ $ git add frotz.c                           <3>
 <2> This commits all other changes in the index.
 <3> Adds the file to the index again.
 
-Keep changes in working tree while discarding some previous commits::
+`Keep changes in working tree while discarding some previous commits`::
 +
 Suppose you are working on something and you commit it, and then you
 continue working a bit more, but now you think that what you have in
diff --git a/Documentation/git-restore.txt b/Documentation/git-restore.txt
index 25a7160aab..e2dfad0b69 100644
--- a/Documentation/git-restore.txt
+++ b/Documentation/git-restore.txt
@@ -32,7 +32,7 @@ THIS COMMAND IS EXPERIMENTAL. THE BEHAVIOR MAY CHANGE.
 
 OPTIONS
 -------
--s <tree>::
+`-s <tree>`::
 `--source=<tree>`::
 	Restore the working tree files with the content from the given
 	tree. It is common to specify the source tree by naming a
diff --git a/Documentation/git-rev-parse.txt b/Documentation/git-rev-parse.txt
index d84a853018..191ec94ec7 100644
--- a/Documentation/git-rev-parse.txt
+++ b/Documentation/git-rev-parse.txt
@@ -74,11 +74,11 @@ Options for Filtering
 Options for Output
 ~~~~~~~~~~~~~~~~~~
 
---default <arg>::
+`--default <arg>`::
 	If there is no parameter given by the user, use `<arg>`
 	instead.
 
---prefix <arg>::
+`--prefix <arg>`::
 	Behave as if `git rev-parse` was invoked from the `<arg>`
 	subdirectory of the working tree.  Any relative filenames are
 	resolved as if they are prefixed by `<arg>` and will be printed
@@ -236,13 +236,13 @@ print a message to stderr and exit with nonzero status.
 `--git-common-dir`::
 	Show `$GIT_COMMON_DIR` if defined, else `$GIT_DIR`.
 
---resolve-git-dir <path>::
+`--resolve-git-dir <path>`::
 	Check if <path> is a valid repository or a gitfile that
 	points at a valid repository, and print the location of the
 	repository.  If <path> is a gitfile then the resolved path
 	to the real repository is printed.
 
---git-path <path>::
+`--git-path <path>`::
 	Resolve `$GIT_DIR/<path>` and takes other path relocation
 	variables such as `$GIT_OBJECT_DIRECTORY`,
 	`$GIT_INDEX_FILE`... into account. For example, if
diff --git a/Documentation/git-revert.txt b/Documentation/git-revert.txt
index 5fde44478f..e1f7b574ba 100644
--- a/Documentation/git-revert.txt
+++ b/Documentation/git-revert.txt
@@ -47,8 +47,8 @@ OPTIONS
 	message prior to committing the revert. This is the default if
 	you run the command from a terminal.
 
--m parent-number::
---mainline parent-number::
+`-m parent-number`::
+`--mainline parent-number`::
 	Usually you cannot revert a merge because you do not know which
 	side of the merge should be considered the mainline.  This
 	option specifies the parent number (starting from 1) of
diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
index 6e96c23492..958ab5018b 100644
--- a/Documentation/git-send-email.txt
+++ b/Documentation/git-send-email.txt
@@ -124,7 +124,7 @@ is not set, this will be prompted for.
 +
 This option may be specified multiple times.
 
---8bit-encoding=<encoding>::
+`--8bit-encoding=<encoding>`::
 	When encountering a non-ASCII message or subject that does not
 	declare its encoding, add headers/quoting to indicate it is
 	encoded in <encoding>.  Default is the value of the
diff --git a/Documentation/git-shell.txt b/Documentation/git-shell.txt
index 5b72dc53d6..a52db35d2b 100644
--- a/Documentation/git-shell.txt
+++ b/Documentation/git-shell.txt
@@ -32,7 +32,7 @@ COMMANDS
 	Call the corresponding server-side command to support
 	the client's `git push`, `git fetch`, or `git archive --remote`
 	request.
-'cvs server'::
+`cvs server`::
 	Imitate a CVS server.  See linkgit:git-cvsserver[1].
 
 If a `~/git-shell-commands` directory is present, `git shell` will
diff --git a/Documentation/git-shortlog.txt b/Documentation/git-shortlog.txt
index c3f6997d2e..2d1cdf62d7 100644
--- a/Documentation/git-shortlog.txt
+++ b/Documentation/git-shortlog.txt
@@ -89,7 +89,7 @@ counts both authors and co-authors.
 If width is `0` (zero) then indent the lines of the output without wrapping
 them.
 
-<revision range>::
+`<revision range>`::
 	Show only commits in the specified revision range.  When no
 	<revision range> is specified, it defaults to `HEAD` (i.e. the
 	whole history leading to the current commit).  `origin..HEAD`
diff --git a/Documentation/git-show-branch.txt b/Documentation/git-show-branch.txt
index 017390e1ed..de05271a77 100644
--- a/Documentation/git-show-branch.txt
+++ b/Documentation/git-show-branch.txt
@@ -94,7 +94,7 @@ OPTIONS
 `--no-name`::
 	Do not show naming strings for each commit.
 
---sha1-name::
+`--sha1-name`::
 	Instead of naming the commits using the path to reach
 	them from heads (e.g. "master~2" to mean the grandparent
 	of "master"), name them with the unique prefix of their
diff --git a/Documentation/git-show-index.txt b/Documentation/git-show-index.txt
index 0d4b36859d..c0304de730 100644
--- a/Documentation/git-show-index.txt
+++ b/Documentation/git-show-index.txt
@@ -39,7 +39,7 @@ index file itself, it's both faster and more flexible.
 OPTIONS
 -------
 
---object-format=<hash-algorithm>::
+`--object-format=<hash-algorithm>`::
 	Specify the given object format (hash algorithm) for the index file.  The
 	valid values are 'sha1' and (if enabled) 'sha256'.  The default is the
 	algorithm for the current repository (set by `extensions.objectFormat`), or
diff --git a/Documentation/git-stash.txt b/Documentation/git-stash.txt
index 974b16963c..9b7c9a5398 100644
--- a/Documentation/git-stash.txt
+++ b/Documentation/git-stash.txt
@@ -67,7 +67,7 @@ save [-p|--patch] [-k|--[no-]keep-index] [-u|--include-untracked] [-a|--all] [-q
 	Instead, all non-option arguments are concatenated to form the stash
 	message.
 
-list [<log-options>]::
+`list [<log-options>]`::
 
 	List the stash entries that you currently have.  Each 'stash entry' is
 	listed with its name (e.g. `stash@{0}` is the latest entry, `stash@{1}` is
@@ -111,7 +111,7 @@ apply [--index] [-q|--quiet] [<stash>]::
 	`<stash>` may be any commit that looks like a commit created by
 	`stash push` or `stash create`.
 
-branch <branchname> [<stash>]::
+`branch <branchname> [<stash>]`::
 
 	Creates and checks out a new branch named `<branchname>` starting from
 	the commit at which the `<stash>` was originally created, applies the
diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
index 95868792c9..107b3a581e 100644
--- a/Documentation/git-submodule.txt
+++ b/Documentation/git-submodule.txt
@@ -185,7 +185,7 @@ set-branch (-d|--default) [--] <path>::
 	`--default` option removes the `submodule.<name>.branch` configuration
 	key, which causes the tracking branch to default to the remote `HEAD`.
 
-set-url [--] <path> <newurl>::
+`set-url [--] <path> <newurl>`::
 	Sets the URL of the specified submodule to <newurl>. Then, it will
 	automatically synchronize the submodule's new remote URL
 	configuration.
@@ -203,7 +203,7 @@ summary [--cached|--files] [(-n|--summary-limit) <n>] [commit] [--] [<path>...]:
 Using the `--submodule=log` option with linkgit:git-diff[1] will provide that
 information too.
 
-foreach [--recursive] <command>::
+`foreach [--recursive] <command>`::
 	Evaluates an arbitrary shell command in each checked out submodule.
 	The command has access to the variables `$name`, `$sm_path`, `$displaypath`,
 	`$sha1` and `$toplevel`:
@@ -277,8 +277,8 @@ OPTIONS
 	This option is only valid for the deinit command. Unregister all
 	submodules in the working tree.
 
--b <branch>::
---branch <branch>::
+`-b <branch>`::
+`--branch <branch>`::
 	Branch of repository to add as submodule.
 	The name of the branch is recorded as `submodule.<name>.branch` in
 	`.gitmodules` for `update --remote`.  A special value of `.` is used to
@@ -391,7 +391,7 @@ the submodule itself.
 	name to the given string instead of defaulting to its path. The name
 	must be valid as a directory name and may not end with a '/'.
 
---reference <repository>::
+`--reference <repository>`::
 	This option is only valid for add and update commands.  These
 	commands sometimes need to clone a remote repository. In this case,
 	this option will be passed to the linkgit:git-clone[1] command.
@@ -424,8 +424,8 @@ options carefully.
 	`submodule.<name>.shallow` as provided by the `.gitmodules` file
 	by default. To ignore the suggestions use `--no-recommend-shallow`.
 
--j <n>::
---jobs <n>::
+`-j <n>`::
+`--jobs <n>`::
 	This option is only valid for the update command.
 	Clone new submodules in parallel with as many jobs.
 	Defaults to the `submodule.fetchJobs` option.
diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
index 6fca35c8cb..d484152b7a 100644
--- a/Documentation/git-svn.txt
+++ b/Documentation/git-svn.txt
@@ -260,7 +260,7 @@ Use of `dcommit` is preferred to `set-tree` (below).
 +
 `--no-rebase`;;
 	After committing, do not rebase or reset.
---commit-url <URL>;;
+`--commit-url <URL>`;;
 	Commit to this SVN URL (the full path).  This is intended to
 	allow existing `git svn` repositories created with one transport
 	method (e.g. `svn://` or `http://` for anonymous read) to be
@@ -465,12 +465,12 @@ option, or indirectly from the tag or commit when the second tree-ish
 denotes such an object, or it is requested by invoking an editor (see
 `--edit` option below).
 
--m <msg>;;
+`-m <msg>`;;
 `--message=<msg>`;;
 	Use the given `msg` as the commit message. This option
 	disables the `--edit` option.
 
--F <filename>;;
+`-F <filename>`;;
 `--file=<filename>`;;
 	Take the commit message from the given file. This option
 	disables the `--edit` option.
@@ -528,7 +528,7 @@ Only the rev_map and refs/remotes/git-svn are changed (see
 Follow 'reset' with a `fetch` and then `git reset` or `git rebase` to
 move local branches onto the new tree.
 
--r <n>;;
+`-r <n>`;;
 `--revision=<n>`;;
 	Specify the most recent revision to keep.  All later revisions
 	are discarded.
@@ -579,8 +579,8 @@ OPTIONS
 	Only used with the `init` command.
 	These are passed directly to `git init`.
 
--r <arg>::
---revision <arg>::
+`-r <arg>`::
+`--revision <arg>`::
 	   Used with the `fetch` command.
 +
 This allows revision ranges for partial/cauterized history
@@ -727,8 +727,8 @@ ADVANCED OPTIONS
 	when tracking a single URL.  The `log` and `dcommit` commands
 	no longer require this switch as an argument.
 
--R<remote name>::
---svn-remote <remote name>::
+`-R<remote name>`::
+`--svn-remote <remote name>`::
 	Specify the [svn-remote "<remote name>"] section to use,
 	this allows SVN multiple repositories to be tracked.
 	Default: "svn"
diff --git a/Documentation/git-switch.txt b/Documentation/git-switch.txt
index 44ae45e838..307e2fa097 100644
--- a/Documentation/git-switch.txt
+++ b/Documentation/git-switch.txt
@@ -56,8 +56,8 @@ As a special case, you may use `A...B` as a shortcut for the merge
 base of `A` and `B` if there is exactly one merge base. You can leave
 out at most one of `A` and `B`, in which case it defaults to `HEAD`.
 
--c <new-branch>::
---create <new-branch>::
+`-c <new-branch>`::
+`--create <new-branch>`::
 	Create a new branch named `<new-branch>` starting at
 	`<start-point>` before switching to the branch. This is a
 	convenient shortcut for:
@@ -67,8 +67,8 @@ $ git branch <new-branch>
 $ git switch <new-branch>
 ------------
 
--C <new-branch>::
---force-create <new-branch>::
+`-C <new-branch>`::
+`--force-create <new-branch>`::
 	Similar to `--create` except that if `<new-branch>` already
 	exists, it will be reset to `<start-point>`. This is a
 	convenient shortcut for:
@@ -171,7 +171,7 @@ name, the guessing is aborted.  You can explicitly give a name with
 	Do not set up "upstream" configuration, even if the
 	`branch.autoSetupMerge` configuration variable is true.
 
---orphan <new-branch>::
+`--orphan <new-branch>`::
 	Create a new 'orphan' branch, named `<new-branch>`. All
 	tracked files are removed.
 
diff --git a/Documentation/git-tag.txt b/Documentation/git-tag.txt
index 6f125deee3..8c6a00d0aa 100644
--- a/Documentation/git-tag.txt
+++ b/Documentation/git-tag.txt
@@ -72,7 +72,7 @@ OPTIONS
 	Override `tag.gpgSign` configuration variable that is
 	set to force each and every tag to be signed.
 
--u <keyid>::
+`-u <keyid>`::
 `--local-user=<keyid>`::
 	Make a GPG-signed tag, using the given key.
 
@@ -139,27 +139,27 @@ options for details.
 +
 This option is only applicable when listing tags without annotation lines.
 
---contains [<commit>]::
+`--contains [<commit>]`::
 	Only list tags which contain the specified commit (HEAD if not
 	specified). Implies `--list`.
 
---no-contains [<commit>]::
+`--no-contains [<commit>]`::
 	Only list tags which don't contain the specified commit (HEAD if
 	not specified). Implies `--list`.
 
---merged [<commit>]::
+`--merged [<commit>]`::
 	Only list tags whose commits are reachable from the specified
 	commit (`HEAD` if not specified).
 
---no-merged [<commit>]::
+`--no-merged [<commit>]`::
 	Only list tags whose commits are not reachable from the specified
 	commit (`HEAD` if not specified).
 
---points-at <object>::
+`--points-at <object>`::
 	Only list tags of the given object (HEAD if not
 	specified). Implies `--list`.
 
--m <msg>::
+`-m <msg>`::
 `--message=<msg>`::
 	Use the given tag message (instead of prompting).
 	If multiple `-m` options are given, their values are
@@ -167,7 +167,7 @@ This option is only applicable when listing tags without annotation lines.
 	Implies `-a` if none of `-a`, `-s`, or `-u <keyid>`
 	is given.
 
--F <file>::
+`-F <file>`::
 `--file=<file>`::
 	Take the tag message from the given file.  Use '-' to
 	read the message from the standard input.
diff --git a/Documentation/git-unpack-file.txt b/Documentation/git-unpack-file.txt
index 85c5f120e5..f295b26ec7 100644
--- a/Documentation/git-unpack-file.txt
+++ b/Documentation/git-unpack-file.txt
@@ -20,7 +20,7 @@ returns the name of the temporary file in the following format:
 
 OPTIONS
 -------
-<blob>::
+`<blob>`::
 	Must be a blob id
 
 GIT
diff --git a/Documentation/git-update-index.txt b/Documentation/git-update-index.txt
index 7a4925b3c6..8b513910d0 100644
--- a/Documentation/git-update-index.txt
+++ b/Documentation/git-update-index.txt
@@ -73,7 +73,7 @@ OPTIONS
 	Ignores missing files during a `--refresh`
 
 --cacheinfo <mode>,<object>,<path>::
---cacheinfo <mode> <object> <path>::
+`--cacheinfo <mode> <object> <path>`::
 	Directly insert the specified info into the index.  For
 	backward compatibility, you can also give these three
 	arguments as three separate parameters, but new users are
@@ -158,7 +158,7 @@ you will need to handle the situation manually.
 `--verbose`::
         Report what is being added and removed from index.
 
---index-version <n>::
+`--index-version <n>`::
 	Write the resulting index out in the named on-disk format version.
 	Supported versions are 2, 3 and 4. The current default version is 2
 	or 3, depending on whether extra features are used, such as
diff --git a/Documentation/git-upload-archive.txt b/Documentation/git-upload-archive.txt
index 36f7901adb..6fb5aa1ba0 100644
--- a/Documentation/git-upload-archive.txt
+++ b/Documentation/git-upload-archive.txt
@@ -54,7 +54,7 @@ access via non-smart-http.
 
 OPTIONS
 -------
-<directory>::
+`<directory>`::
 	The repository to get a tar archive from.
 
 GIT
diff --git a/Documentation/git-web--browse.txt b/Documentation/git-web--browse.txt
index 0e788b1208..5aebb3093d 100644
--- a/Documentation/git-web--browse.txt
+++ b/Documentation/git-web--browse.txt
@@ -41,13 +41,13 @@ Custom commands may also be specified.
 
 OPTIONS
 -------
--b <browser>::
---browser=<browser>::
+`-b <browser>`::
+`--browser=<browser>`::
 	Use the specified browser. It must be in the list of supported
 	browsers.
 
--t <browser>::
---tool=<browser>::
+`-t <browser>`::
+`--tool=<browser>`::
 	Same as above.
 
 -c <conf.var>::
diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktree.txt
index d44084a7f4..9dc105f08f 100644
--- a/Documentation/git-worktree.txt
+++ b/Documentation/git-worktree.txt
@@ -58,7 +58,7 @@ specifying `--reason` to explain why the working tree is locked.
 
 COMMANDS
 --------
-add <path> [<commit-ish>]::
+`add <path> [<commit-ish>]`::
 
 Create `<path>` and checkout `<commit-ish>` into it. The new working directory
 is linked to the current repository, sharing everything except working
@@ -174,8 +174,8 @@ allows the move to proceed; use `--force` twice if the destination is locked.
 `remove` refuses to remove an unclean working tree unless `--force` is used.
 To remove a locked working tree, specify `--force` twice.
 
--b <new-branch>::
--B <new-branch>::
+`-b <new-branch>`::
+`-B <new-branch>`::
 	With `add`, create a new branch named `<new-branch>` starting at
 	`<commit-ish>`, and check out `<new-branch>` into the new working tree.
 	If `<commit-ish>` is omitted, it defaults to `HEAD`.
@@ -235,13 +235,13 @@ This can also be set up as the default behaviour by using the
 +
 With `list`, output additional information about worktrees (see below).
 
---expire <time>::
+`--expire <time>`::
 	With `prune`, only expire unused working trees older than `<time>`.
 +
 With `list`, annotate missing working trees as prunable if they are
 older than `<time>`.
 
---reason <string>::
+`--reason <string>`::
 	With `lock`, an explanation why the working tree is locked.
 
 `<worktree>`::
diff --git a/Documentation/git.txt b/Documentation/git.txt
index d1389f92c1..8e511669fe 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -53,7 +53,7 @@ displayed. See linkgit:git-help[1] for more information,
 because `git --help ...` is converted internally into `git
 help ...`.
 
--C <path>::
+`-C <path>`::
 	Run as if `git` was started in '<path>' instead of the current working
 	directory.  When multiple `-C` options are given, each subsequent
 	non-absolute `-C <path>` is interpreted relative to the preceding `-C
@@ -68,7 +68,7 @@ example the following invocations are equivalent:
     git --git-dir=a.git --work-tree=b -C c status
     git --git-dir=c/a.git --work-tree=c/b status
 
--c <name>=<value>::
+`-c <name>=<value>`::
 	Pass a configuration parameter to the command. The value
 	given will override values from configuration files.
 	The <name> is expected in the same format as listed by
diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
index 0440adf4fc..50397236d2 100644
--- a/Documentation/gitattributes.txt
+++ b/Documentation/gitattributes.txt
@@ -41,7 +41,7 @@ Each attribute can be in one of these states for a given path:
 	this is specified by listing the name of the attribute
 	prefixed with a dash `-` in the attribute list.
 
-Set to a value::
+`Set to a value`::
 
 	The path has the attribute with specified string value;
 	this is specified by listing the name of the attribute
diff --git a/Documentation/gitk.txt b/Documentation/gitk.txt
index 4fd7300cc4..d4879237f2 100644
--- a/Documentation/gitk.txt
+++ b/Documentation/gitk.txt
@@ -100,7 +100,7 @@ linkgit:git-rev-list[1] for a complete list.
 
 include::line-range-options.txt[]
 
-<revision range>::
+`<revision range>`::
 
 	Limit the revisions to show. This can be either a single revision
 	meaning show from the given revision and back, or it can be a range in
diff --git a/Documentation/gitremote-helpers.txt b/Documentation/gitremote-helpers.txt
index 80681ed5c0..02ae4993bc 100644
--- a/Documentation/gitremote-helpers.txt
+++ b/Documentation/gitremote-helpers.txt
@@ -271,7 +271,7 @@ See REF LIST KEYWORDS for a list of currently defined keywords.
 +
 Supported if the helper has the "fetch" or "import" capability.
 
-'list for-push'::
+`list for-push`::
 	Similar to 'list', except that it is used if and only if
 	the caller wants to the resulting ref list to prepare
 	push commands.
@@ -470,10 +470,10 @@ set by Git if the remote helper has the 'option' capability.
 'option depth' <depth>::
 	Deepens the history of a shallow repository.
 
-'option deepen-since <timestamp>::
+`option deepen-since <timestamp>`::
 	Deepens the history of a shallow repository based on time.
 
-'option deepen-not <ref>::
+`option deepen-not <ref>`::
 	Deepens the history of a shallow repository excluding ref.
 	Multiple options add up.
 
@@ -494,7 +494,7 @@ set by Git if the remote helper has the 'option' capability.
 	but don't actually change any repository data.  For most
 	helpers this only applies to the 'push', if supported.
 
-'option servpath <c-style-quoted-path>'::
+`option servpath <c-style-quoted-path>`::
 	Sets service path (--upload-pack, --receive-pack etc.) for
 	next connect. Remote helper may support this option, but
 	must not rely on this option being set before
@@ -517,7 +517,7 @@ set by Git if the remote helper has the 'option' capability.
 'option pushcert' {'true'|'false'}::
 	GPG sign pushes.
 
-'option push-option <string>::
+`option push-option <string>`::
 	Transmit <string> as a push option. As the push option
 	must not contain LF or NUL characters, the string is not encoded.
 
diff --git a/Documentation/gitweb.txt b/Documentation/gitweb.txt
index 3ade8b7d72..057038bb6d 100644
--- a/Documentation/gitweb.txt
+++ b/Documentation/gitweb.txt
@@ -92,9 +92,9 @@ encode SPACE), all whitespace characters as defined in Perl, including SP,
 TAB and LF, (used to separate fields in a record).
 
 * Currently recognized fields are:
-<repository path>::
+`<repository path>`::
 	path to repository GIT_DIR, relative to `$projectroot`
-<repository owner>::
+`<repository owner>`::
 	displayed as repository owner, preferably full name, or email,
 	or both
 
diff --git a/Documentation/merge-options.txt b/Documentation/merge-options.txt
index ec6b02f79a..0812eb032a 100644
--- a/Documentation/merge-options.txt
+++ b/Documentation/merge-options.txt
@@ -107,7 +107,7 @@ With `--squash`, `--commit` is not allowed, and will fail.
 	This option bypasses the pre-merge and commit-msg hooks.
 	See also linkgit:githooks[5].
 
--s <strategy>::
+`-s <strategy>`::
 `--strategy=<strategy>`::
 	Use the given merge strategy; can be supplied more than
 	once to specify them in the order they should be tried.
@@ -115,7 +115,7 @@ With `--squash`, `--commit` is not allowed, and will fail.
 	is used instead (`git merge-recursive` when merging a single
 	head, `git merge-octopus` otherwise).
 
--X <option>::
+`-X <option>`::
 `--strategy-option=<option>`::
 	Pass merge strategy specific option through to the merge
 	strategy.
diff --git a/Documentation/pull-fetch-param.txt b/Documentation/pull-fetch-param.txt
index b062400072..cfea4f14b4 100644
--- a/Documentation/pull-fetch-param.txt
+++ b/Documentation/pull-fetch-param.txt
@@ -1,17 +1,17 @@
-<repository>::
+`<repository>`::
 	The "remote" repository that is the source of a fetch
 	or pull operation.  This parameter can be either a URL
 	(see the section <<URLS,GIT URLS>> below) or the name
 	of a remote (see the section <<REMOTES,REMOTES>> below).
 
 ifndef::git-pull[]
-<group>::
+`<group>`::
 	A name referring to a list of repositories as the value
 	of `remotes.<group>` in the configuration file.
 	(See linkgit:git-config[1]).
 endif::git-pull[]
 
-<refspec>::
+`<refspec>`::
 	Specifies which refs to fetch and which local refs to update.
 	When no <refspec>s appear on the command line, the refs to fetch
 	are read from `remote.<repository>.fetch` variables instead
diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
index 7053aa6170..b68f1c19c5 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -14,7 +14,7 @@ Note that these are applied before commit
 ordering and formatting options, such as `--reverse`.
 
 `-<number>`::
--n <number>::
+`-n <number>`::
 `--max-count=<number>`::
 	Limit the number of commits to output.
 
@@ -454,7 +454,7 @@ Parent/child relations are only visible with `--parents`, but that does
 not affect the commits selected in default mode, so we have shown the
 parent lines.
 
---full-history without parent rewriting::
+`--full-history without parent rewriting`::
 	This mode differs from the default in one point: always follow
 	all parents of a merge, even if it is TREESAME to one of them.
 	Even if more than one side of the merge has commits that are
@@ -473,7 +473,7 @@ Note that without parent rewriting, it is not really possible to talk
 about the parent/child relationships between the commits, so we show
 them disconnected.
 
---full-history with parent rewriting::
+`--full-history with parent rewriting`::
 	Ordinary commits are only included if they are !TREESAME
 	(though this can be changed, see `--sparse` below).
 +
diff --git a/Documentation/revisions.txt b/Documentation/revisions.txt
index 0614772a76..4e9afd9a7d 100644
--- a/Documentation/revisions.txt
+++ b/Documentation/revisions.txt
@@ -318,7 +318,7 @@ three notations also consider its parents. For example you can say
 Revision Range Summary
 ----------------------
 
-'<rev>'::
+`<rev>`::
 	Include commits that are reachable from <rev> (i.e. <rev> and its
 	ancestors).
 
-- 
2.31.1.133.g84d06cdc06

