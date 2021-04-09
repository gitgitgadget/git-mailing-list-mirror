Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDC05C433B4
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 04:06:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9BC586115C
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 04:06:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231517AbhDIEGs (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Apr 2021 00:06:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231324AbhDIEGG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Apr 2021 00:06:06 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F642C061764
        for <git@vger.kernel.org>; Thu,  8 Apr 2021 21:05:53 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id q26so4195647wrz.9
        for <git@vger.kernel.org>; Thu, 08 Apr 2021 21:05:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lLo4Q5Rcz7oNfpwrSJc5Q7ygYZIN1Ni0xzfNcmKIuxc=;
        b=J3wqKPCYv6bLnHIbBy6q1mhd+5yHIYGaQYIEI8XDPSfsjwfBgmJEifZmOwiLZtW/3v
         pC+vnzkuSwITP4UFMyXV2eRKCsOK51dzqHD+fWEzvao5em+WB1r+KcCp4JlUNpUsxnnG
         8PdoLaSiIdmrC5PaHKiVd15qvjC10847C4eox+PNayyFrf7p34NK3iQqL9iUuWX0ZeAy
         7SErbbAKuucOW8udV+rMZy599pzW5/3bH6YPLxmIb6A7dWhvm+BF1lEui221TVehXUJP
         eDHEvIe4h7CgkozfBm33PRFwZRuIeD9GIiJJLeAbfBK6QEI7UIVQaOvXvl+/t2NV2JqU
         phIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lLo4Q5Rcz7oNfpwrSJc5Q7ygYZIN1Ni0xzfNcmKIuxc=;
        b=M62WAZ3Vrfclmv8bJumCt+2XbPS5XL6uzSdH/TsjjkRLJY0NSjoBLGYDIhdAtbFf7+
         bYTi2ay0i5HyuNyvImleB3gB1EbuxV/FSYmPYvCFEinN1X330d9730VCVZDDSd/KfuEe
         YRe+8962olLRt/Qc/Oc6dCqhpclhagqY2x/M3uCkfmHv36GoPFyEXC40dKOyNR3QjcaX
         WwB1B2nEE8VgiwMaCRDOv1+6MOwji7+PkoEEhzkpQvadkggBCb4olKQqy97tzevHApSt
         X4zg6wNuxAY1rmF4GGv435+EjIE8IPhd6hxd4JsI/V+A73CB7H9hHrCgpQc5E2w9bA+A
         z8gQ==
X-Gm-Message-State: AOAM5319+GnLUVY/6S4ab26T0xLk0mybL5nhnx5YKoxuc637Int8g1KS
        oe3KoS3NurNVZ3gav9fu1ma7QDbu+sPoLg==
X-Google-Smtp-Source: ABdhPJxBkdwC3WIf4rQ17InP8H7JZZ88BS8bGmSpzIRa6oxz51VC/ps2ZS3TEysPLOVsDE9B24kPPg==
X-Received: by 2002:a5d:66c8:: with SMTP id k8mr15485656wrw.240.1617941151197;
        Thu, 08 Apr 2021 21:05:51 -0700 (PDT)
Received: from Inspiron.home (2a01cb04010c420080e637770dc2ae3c.ipv6.abo.wanadoo.fr. [2a01:cb04:10c:4200:80e6:3777:dc2:ae3c])
        by smtp.gmail.com with ESMTPSA id c9sm2064636wrr.78.2021.04.08.21.05.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Apr 2021 21:05:50 -0700 (PDT)
From:   Firmin Martin <firminmartin24@gmail.com>
To:     git@vger.kernel.org
Cc:     Firmin Martin <firminmartin24@gmail.com>
Subject: [RFC PATCH v1 11/13] doc: typeset config option entries in monospace
Date:   Fri,  9 Apr 2021 06:02:59 +0200
Message-Id: <20210409040301.3260358-12-firminmartin24@gmail.com>
X-Mailer: git-send-email 2.31.1.133.g84d06cdc06
In-Reply-To: <20210409040301.3260358-1-firminmartin24@gmail.com>
References: <20210409040301.3260358-1-firminmartin24@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Automatically wrap configuration option entries (i.e. something of the form
<entry>[::|;;]<description>) with backticks as indicated in the
CodingGuidelines.

The following command and regex has performed the whole substitution
(without manual intervention).

    REGEX="^([[:space:]]*?)[\"']?([-0-9a-z]+?(?:\.[][ [:alnum:]-=<>]+)+)[\"']?(::|;;)([[:space:]]+|\$)" &&
    perl -pi -e "s/$REGEX/\$1\`\$2\`\$3\$4/g" $(grep -Pl "$REGEX" *.txt --exclude-dir=RelNotes)

Signed-off-by: Firmin Martin <firminmartin24@gmail.com>
---
 Documentation/git-apply.txt              |  4 +-
 Documentation/git-archive.txt            |  6 +-
 Documentation/git-cvsexportcommit.txt    |  2 +-
 Documentation/git-cvsserver.txt          | 10 ++--
 Documentation/git-difftool.txt           | 12 ++--
 Documentation/git-fast-import.txt        |  2 +-
 Documentation/git-fmt-merge-msg.txt      |  2 +-
 Documentation/git-grep.txt               | 14 ++---
 Documentation/git-http-backend.txt       |  6 +-
 Documentation/git-interpret-trailers.txt | 18 +++---
 Documentation/git-log.txt                | 14 ++---
 Documentation/git-merge.txt              |  2 +-
 Documentation/git-notes.txt              | 14 ++---
 Documentation/git-p4.txt                 | 72 ++++++++++++------------
 Documentation/git-send-email.txt         |  8 +--
 Documentation/git-svn.txt                | 24 ++++----
 Documentation/gitmodules.txt             | 14 ++---
 Documentation/gitrepository-layout.txt   |  4 +-
 Documentation/gitweb.txt                 |  2 +-
 19 files changed, 115 insertions(+), 115 deletions(-)

diff --git a/Documentation/git-apply.txt b/Documentation/git-apply.txt
index fd681659e8..6fafe4a3b3 100644
--- a/Documentation/git-apply.txt
+++ b/Documentation/git-apply.txt
@@ -253,11 +253,11 @@ has no effect when `--index` or `--cached` is in use.
 CONFIGURATION
 -------------
 
-apply.ignoreWhitespace::
+`apply.ignoreWhitespace`::
 	Set to 'change' if you want changes in whitespace to be ignored by default.
 	Set to one of: no, none, never, false if you want changes in
 	whitespace to be significant.
-apply.whitespace::
+`apply.whitespace`::
 	When no `--whitespace` flag is given from the command
 	line, this configuration item is used as the default.
 
diff --git a/Documentation/git-archive.txt b/Documentation/git-archive.txt
index 83ce330c9d..830ff2b680 100644
--- a/Documentation/git-archive.txt
+++ b/Documentation/git-archive.txt
@@ -103,7 +103,7 @@ zip
 CONFIGURATION
 -------------
 
-tar.umask::
+`tar.umask`::
 	This variable can be used to restrict the permission bits of
 	tar archive entries.  The default is 0002, which turns off the
 	world write bit.  The special value "user" indicates that the
@@ -111,7 +111,7 @@ tar.umask::
 	details.  If `--remote` is used then only the configuration of
 	the remote repository takes effect.
 
-tar.<format>.command::
+`tar.<format>.command`::
 	This variable specifies a shell command through which the tar
 	output generated by `git archive` should be piped. The command
 	is executed using the shell with the generated tar file on its
@@ -124,7 +124,7 @@ tar.<format>.command::
 The "tar.gz" and "tgz" formats are defined automatically and default to
 `gzip -cn`. You may override them with custom commands.
 
-tar.<format>.remote::
+`tar.<format>.remote`::
 	If true, enable `<format>` for use by remote clients via
 	linkgit:git-upload-archive[1]. Defaults to false for
 	user-defined formats, but true for the "tar.gz" and "tgz"
diff --git a/Documentation/git-cvsexportcommit.txt b/Documentation/git-cvsexportcommit.txt
index 8514bbd2b2..a9ef265a34 100644
--- a/Documentation/git-cvsexportcommit.txt
+++ b/Documentation/git-cvsexportcommit.txt
@@ -84,7 +84,7 @@ OPTIONS
 
 CONFIGURATION
 -------------
-cvsexportcommit.cvsdir::
+`cvsexportcommit.cvsdir`::
 	The default location of the CVS checkout to use for the export.
 
 EXAMPLES
diff --git a/Documentation/git-cvsserver.txt b/Documentation/git-cvsserver.txt
index 23647e12b0..bd8930eb2b 100644
--- a/Documentation/git-cvsserver.txt
+++ b/Documentation/git-cvsserver.txt
@@ -254,14 +254,14 @@ Configuring database backend
 its documentation if changing these variables, especially
 about `DBI->connect()`.
 
-gitcvs.dbName::
+`gitcvs.dbName`::
 	Database name. The exact meaning depends on the
 	selected database driver, for SQLite this is a filename.
 	Supports variable substitution (see below). May
 	not contain semicolons (`;`).
 	Default: '%Ggitcvs.%m.sqlite'
 
-gitcvs.dbDriver::
+`gitcvs.dbDriver`::
 	Used DBI driver. You can specify any available driver
 	for this here, but it might not work. cvsserver is tested
 	with 'DBD::SQLite', reported to work with
@@ -270,16 +270,16 @@ gitcvs.dbDriver::
 	contain colons (`:`).
 	Default: 'SQLite'
 
-gitcvs.dbuser::
+`gitcvs.dbuser`::
 	Database user. Only useful if setting `dbDriver`, since
 	SQLite has no concept of database users. Supports variable
 	substitution (see below).
 
-gitcvs.dbPass::
+`gitcvs.dbPass`::
 	Database password.  Only useful if setting `dbDriver`, since
 	SQLite has no concept of database passwords.
 
-gitcvs.dbTableNamePrefix::
+`gitcvs.dbTableNamePrefix`::
 	Database table name prefix.  Supports variable substitution
 	(see below).  Any non-alphabetic characters will be replaced
 	with underscores.
diff --git a/Documentation/git-difftool.txt b/Documentation/git-difftool.txt
index 24a2b7cc36..4b895fe7f9 100644
--- a/Documentation/git-difftool.txt
+++ b/Documentation/git-difftool.txt
@@ -118,25 +118,25 @@ CONFIG VARIABLES
 `git difftool` falls back to `git mergetool` config variables when the
 difftool equivalents have not been defined.
 
-diff.tool::
+`diff.tool`::
 	The default diff tool to use.
 
-diff.guitool::
+`diff.guitool`::
 	The default diff tool to use when `--gui` is specified.
 
-difftool.<tool>.path::
+`difftool.<tool>.path`::
 	Override the path for the given tool.  This is useful in case
 	your tool is not in the PATH.
 
-difftool.<tool>.cmd::
+`difftool.<tool>.cmd`::
 	Specify the command to invoke the specified diff tool.
 +
 See the `--tool=<tool>` option above for more details.
 
-difftool.prompt::
+`difftool.prompt`::
 	Prompt before each invocation of the diff tool.
 
-difftool.trustExitCode::
+`difftool.trustExitCode`::
 	Exit difftool if the invoked diff tool returns a non-zero exit status.
 +
 See the `--trust-exit-code` option above for more details.
diff --git a/Documentation/git-fast-import.txt b/Documentation/git-fast-import.txt
index cfbb47665f..6830332297 100644
--- a/Documentation/git-fast-import.txt
+++ b/Documentation/git-fast-import.txt
@@ -172,7 +172,7 @@ Performance and Compression Tuning
 	Maximum size of each output packfile.
 	The default is unlimited.
 
-fastimport.unpackLimit::
+`fastimport.unpackLimit`::
 	See linkgit:git-config[1]
 
 PERFORMANCE
diff --git a/Documentation/git-fmt-merge-msg.txt b/Documentation/git-fmt-merge-msg.txt
index 1ea37635d8..fc9076377c 100644
--- a/Documentation/git-fmt-merge-msg.txt
+++ b/Documentation/git-fmt-merge-msg.txt
@@ -53,7 +53,7 @@ CONFIGURATION
 -------------
 include::config/fmt-merge-msg.txt[]
 
-merge.summary::
+`merge.summary`::
 	Synonym to `merge.log`; this is deprecated and will be removed in
 	the future.
 
diff --git a/Documentation/git-grep.txt b/Documentation/git-grep.txt
index 6f71b659d0..0a0d0f3f57 100644
--- a/Documentation/git-grep.txt
+++ b/Documentation/git-grep.txt
@@ -41,31 +41,31 @@ characters.  An empty string as search expression matches all lines.
 CONFIGURATION
 -------------
 
-grep.lineNumber::
+`grep.lineNumber`::
 	If set to true, enable `-n` option by default.
 
-grep.column::
+`grep.column`::
 	If set to true, enable the `--column` option by default.
 
-grep.patternType::
+`grep.patternType`::
 	Set the default matching behavior. Using a value of 'basic', 'extended',
 	'fixed', or 'perl' will enable the `--basic-regexp`, `--extended-regexp`,
 	`--fixed-strings`, or `--perl-regexp` option accordingly, while the
 	value 'default' will return to the default matching behavior.
 
-grep.extendedRegexp::
+`grep.extendedRegexp`::
 	If set to true, enable `--extended-regexp` option by default. This
 	option is ignored when the `grep.patternType` option is set to a value
 	other than 'default'.
 
-grep.threads::
+`grep.threads`::
 	Number of grep worker threads to use. If unset (or set to 0), Git will
 	use as many threads as the number of logical cores available.
 
-grep.fullName::
+`grep.fullName`::
 	If set to true, enable `--full-name` option by default.
 
-grep.fallbackToNoIndex::
+`grep.fallbackToNoIndex`::
 	If set to true, fall back to `git grep --no-index` if `git grep`
 	is executed outside of a `git` repository.  Defaults to false.
 
diff --git a/Documentation/git-http-backend.txt b/Documentation/git-http-backend.txt
index d512add556..a286c3648f 100644
--- a/Documentation/git-http-backend.txt
+++ b/Documentation/git-http-backend.txt
@@ -34,7 +34,7 @@ SERVICES
 These services can be enabled/disabled using the per-repository
 configuration file:
 
-http.getanyfile::
+`http.getanyfile`::
 	This serves Git clients older than version 1.6.6 that are unable to use the
 	upload pack service.  When enabled, clients are able to read
 	any file within the repository, including objects that are
@@ -42,12 +42,12 @@ http.getanyfile::
 	It is enabled by default, but a repository can disable it
 	by setting this configuration item to `false`.
 
-http.uploadpack::
+`http.uploadpack`::
 	This serves `git fetch-pack` and `git ls-remote` clients.
 	It is enabled by default, but a repository can disable it
 	by setting this configuration item to `false`.
 
-http.receivepack::
+`http.receivepack`::
 	This serves `git send-pack` clients, allowing push.  It is
 	disabled by default for anonymous users, and enabled by
 	default for users authenticated by the web server.  It can be
diff --git a/Documentation/git-interpret-trailers.txt b/Documentation/git-interpret-trailers.txt
index be2ba5f545..54c69ea087 100644
--- a/Documentation/git-interpret-trailers.txt
+++ b/Documentation/git-interpret-trailers.txt
@@ -134,7 +134,7 @@ OPTIONS
 CONFIGURATION VARIABLES
 -----------------------
 
-trailer.separators::
+`trailer.separators`::
 	This option tells which characters are recognized as trailer
 	separators. By default only ':' is recognized as a trailer
 	separator, except that '=' is always accepted on the command
@@ -151,7 +151,7 @@ the default separator used, so by default trailers will appear like:
 '<token>% <value>' (one percent sign and one space will appear between
 the token and the value).
 
-trailer.where::
+`trailer.where`::
 	This option tells where a new trailer will be added.
 +
 This can be `end`, which is the default, `start`, `after` or `before`.
@@ -168,7 +168,7 @@ last trailer with the same <token>.
 If it is `before`, then each new trailer will appear just before the
 first trailer with the same <token>.
 
-trailer.ifexists::
+`trailer.ifexists`::
 	This option makes it possible to choose what action will be
 	performed when there is already at least one trailer with the
 	same <token> in the message.
@@ -194,7 +194,7 @@ will be added.
 With `doNothing`, nothing will be done; that is no new trailer will be
 added if there is already one with the same <token> in the message.
 
-trailer.ifmissing::
+`trailer.ifmissing`::
 	This option makes it possible to choose what action will be
 	performed when there is not yet any trailer with the same
 	<token> in the message.
@@ -206,7 +206,7 @@ With `add`, a new trailer will be added.
 +
 With `doNothing`, nothing will be done.
 
-trailer.<token>.key::
+`trailer.<token>.key`::
 	This `key` will be used instead of <token> in the trailer. At
 	the end of this key, a separator can appear and then some
 	space characters. By default the only valid separator is ':',
@@ -216,22 +216,22 @@ trailer.<token>.key::
 If there is a separator, then the key will be used instead of both the
 <token> and the default separator when adding the trailer.
 
-trailer.<token>.where::
+`trailer.<token>.where`::
 	This option takes the same values as the `trailer.where`
 	configuration variable and it overrides what is specified by
 	that option for trailers with the specified <token>.
 
-trailer.<token>.ifexists::
+`trailer.<token>.ifexists`::
 	This option takes the same values as the `trailer.ifexists`
 	configuration variable and it overrides what is specified by
 	that option for trailers with the specified <token>.
 
-trailer.<token>.ifmissing::
+`trailer.<token>.ifmissing`::
 	This option takes the same values as the `trailer.ifmissing`
 	configuration variable and it overrides what is specified by
 	that option for trailers with the specified <token>.
 
-trailer.<token>.command::
+`trailer.<token>.command`::
 	This option can be used to specify a shell command that will
 	be called to automatically add or modify a trailer with the
 	specified <token>.
diff --git a/Documentation/git-log.txt b/Documentation/git-log.txt
index 83555dc7dc..e8b1033f50 100644
--- a/Documentation/git-log.txt
+++ b/Documentation/git-log.txt
@@ -188,16 +188,16 @@ CONFIGURATION
 See linkgit:git-config[1] for core variables and linkgit:git-diff[1]
 for settings related to diff generation.
 
-format.pretty::
+`format.pretty`::
 	Default for the `--format` option.  (See 'Pretty Formats' above.)
 	Defaults to `medium`.
 
-i18n.logOutputEncoding::
+`i18n.logOutputEncoding`::
 	Encoding to use when displaying logs.  (See 'Discussion' above.)
 	Defaults to the value of `i18n.commitEncoding` if set, and UTF-8
 	otherwise.
 
-log.date::
+`log.date`::
 	Default format for human-readable dates.  (Compare the
 	`--date` option.)  Defaults to "default", which means to write
 	dates like `Sat May 8 19:35:34 2010 -0500`.
@@ -206,26 +206,26 @@ If the format is set to "auto:foo" and the pager is in use, format
 "foo" will be the used for the date format. Otherwise "default" will
 be used.
 
-log.follow::
+`log.follow`::
 	If `true`, `git log` will act as if the `--follow` option was used when
 	a single <path> is given.  This has the same limitations as `--follow`,
 	i.e. it cannot be used to follow multiple files and does not work well
 	on non-linear history.
 
-log.showRoot::
+`log.showRoot`::
 	If `false`, `git log` and related commands will not treat the
 	initial commit as a big creation event.  Any root commits in
 	`git log -p` output would be shown without a diff attached.
 	The default is `true`.
 
-log.showSignature::
+`log.showSignature`::
 	If `true`, `git log` and related commands will act as if the
 	`--show-signature` option was passed to them.
 
 mailmap.*::
 	See linkgit:git-shortlog[1].
 
-notes.displayRef::
+`notes.displayRef`::
 	Which refs, in addition to the default set by `core.notesRef`
 	or `GIT_NOTES_REF`, to read notes from when showing commit
 	messages with the `log` family of commands.  See
diff --git a/Documentation/git-merge.txt b/Documentation/git-merge.txt
index ac5838dfb0..226ec907c1 100644
--- a/Documentation/git-merge.txt
+++ b/Documentation/git-merge.txt
@@ -358,7 +358,7 @@ CONFIGURATION
 -------------
 include::config/merge.txt[]
 
-branch.<name>.mergeOptions::
+`branch.<name>.mergeOptions`::
 	Sets default options for merging into branch <name>. The syntax and
 	supported options are the same as those of `git merge`, but option
 	values containing whitespace characters are currently not supported.
diff --git a/Documentation/git-notes.txt b/Documentation/git-notes.txt
index 9f22359707..50f76c7c69 100644
--- a/Documentation/git-notes.txt
+++ b/Documentation/git-notes.txt
@@ -310,13 +310,13 @@ some special-purpose tools to do something useful with them.
 CONFIGURATION
 -------------
 
-core.notesRef::
+`core.notesRef`::
 	Notes ref to read and manipulate instead of
 	`refs/notes/commits`.  Must be an unabbreviated ref name.
 	This setting can be overridden through the environment and
 	command line.
 
-notes.mergeStrategy::
+`notes.mergeStrategy`::
 	Which merge strategy to choose by default when resolving notes
 	conflicts.  Must be one of `manual`, `ours`, `theirs`, `union`, or
 	`cat_sort_uniq`.  Defaults to `manual`.  See "NOTES MERGE STRATEGIES"
@@ -324,13 +324,13 @@ notes.mergeStrategy::
 +
 This setting can be overridden by passing the `--strategy` option.
 
-notes.<name>.mergeStrategy::
+`notes.<name>.mergeStrategy`::
 	Which merge strategy to choose when doing a notes merge into
 	refs/notes/<name>.  This overrides the more general
 	`notes.mergeStrategy`.  See the "NOTES MERGE STRATEGIES" section above
 	for more information on each available strategy.
 
-notes.displayRef::
+`notes.displayRef`::
 	Which ref (or refs, if a glob or specified more than once), in
 	addition to the default set by `core.notesRef` or
 	`GIT_NOTES_REF`, to read notes from when showing commit
@@ -339,7 +339,7 @@ notes.displayRef::
 	`GIT_NOTES_DISPLAY_REF` environment variable.
 	See linkgit:git-log[1].
 
-notes.rewrite.<command>::
+`notes.rewrite.<command>`::
 	When rewriting commits with <command> (currently `amend` or
 	`rebase`), if this variable is `false`, `git` will not copy
 	notes from the original to the rewritten commit.  Defaults to
@@ -348,7 +348,7 @@ notes.rewrite.<command>::
 This setting can be overridden by the `GIT_NOTES_REWRITE_REF`
 environment variable.
 
-notes.rewriteMode::
+`notes.rewriteMode`::
 	When copying notes during a rewrite, what to do if the target
 	commit already has a note.  Must be one of `overwrite`,
 	`concatenate`, `cat_sort_uniq`, or `ignore`.  Defaults to
@@ -357,7 +357,7 @@ notes.rewriteMode::
 This setting can be overridden with the `GIT_NOTES_REWRITE_MODE`
 environment variable.
 
-notes.rewriteRef::
+`notes.rewriteRef`::
 	When copying notes during a rewrite, specifies the (fully
 	qualified) ref whose notes should be copied.  May be a glob,
 	in which case notes in all matching refs will be copied.  You
diff --git a/Documentation/git-p4.txt b/Documentation/git-p4.txt
index 812d0afd4c..f7666634c0 100644
--- a/Documentation/git-p4.txt
+++ b/Documentation/git-p4.txt
@@ -559,30 +559,30 @@ They all are in the `git-p4` section.
 
 General variables
 ~~~~~~~~~~~~~~~~~
-git-p4.user::
+`git-p4.user`::
 	User specified as an option to all p4 commands, with `-u <user>`.
 	The environment variable `P4USER` can be used instead.
 
-git-p4.password::
+`git-p4.password`::
 	Password specified as an option to all p4 commands, with
 	`-P <password>`.
 	The environment variable `P4PASS` can be used instead.
 
-git-p4.port::
+`git-p4.port`::
 	Port specified as an option to all p4 commands, with
 	`-p <port>`.
 	The environment variable `P4PORT` can be used instead.
 
-git-p4.host::
+`git-p4.host`::
 	Host specified as an option to all p4 commands, with
 	`-h <host>`.
 	The environment variable `P4HOST` can be used instead.
 
-git-p4.client::
+`git-p4.client`::
 	Client specified as an option to all p4 commands, with
 	`-c <client>`, including the client spec.
 
-git-p4.retries::
+`git-p4.retries`::
 	Specifies the number of times to retry a p4 command (notably,
 	`p4 sync`) if the network times out. The default value is 3.
 	Set the value to 0 to disable retries or if your p4 version
@@ -590,20 +590,20 @@ git-p4.retries::
 
 Clone and sync variables
 ~~~~~~~~~~~~~~~~~~~~~~~~
-git-p4.syncFromOrigin::
+`git-p4.syncFromOrigin`::
 	Because importing commits from other Git repositories is much faster
 	than importing them from p4, a mechanism exists to find p4 changes
 	first in Git remotes.  If branches exist under `refs/remote/origin/p4`,
 	those will be fetched and used when syncing from p4.  This
 	variable can be set to 'false' to disable this behavior.
 
-git-p4.branchUser::
+`git-p4.branchUser`::
 	One phase in branch detection involves looking at p4 branches
 	to find new ones to import.  By default, all branches are
 	inspected.  This option limits the search to just those owned
 	by the single user named in the variable.
 
-git-p4.branchList::
+`git-p4.branchList`::
 	List of branches to be imported when branch detection is
 	enabled.  Each entry should be a pair of branch names separated
 	by a colon (:).  This example declares that both branchA and
@@ -614,31 +614,31 @@ git config       git-p4.branchList main:branchA
 git config --add git-p4.branchList main:branchB
 -------------
 
-git-p4.ignoredP4Labels::
+`git-p4.ignoredP4Labels`::
 	List of p4 labels to ignore. This is built automatically as
 	unimportable labels are discovered.
 
-git-p4.importLabels::
+`git-p4.importLabels`::
 	Import p4 labels into `git`, as per `--import-labels`.
 
-git-p4.labelImportRegexp::
+`git-p4.labelImportRegexp`::
 	Only p4 labels matching this regular expression will be imported. The
 	default value is '[a-zA-Z0-9_\-.]+$'.
 
-git-p4.useClientSpec::
+`git-p4.useClientSpec`::
 	Specify that the p4 client spec should be used to identify p4
 	depot paths of interest.  This is equivalent to specifying the
 	option `--use-client-spec`.  See the "CLIENT SPEC" section above.
 	This variable is a boolean, not the name of a p4 client.
 
-git-p4.pathEncoding::
+`git-p4.pathEncoding`::
 	Perforce keeps the encoding of a path as given by the originating OS.
 	Git expects paths encoded as UTF-8. Use this config to tell `git-p4`
 	what encoding Perforce had used for the paths. This encoding is used
 	to transcode the paths to UTF-8. As an example, Perforce on Windows
 	often uses "cp1252" to encode path names.
 
-git-p4.largeFileSystem::
+`git-p4.largeFileSystem`::
 	Specify the system that is used for large (binary) files. Please note
 	that large file systems do not support the `git p4 submit` command.
 	Only Git LFS is implemented right now (see https://git-lfs.github.com/
@@ -649,30 +649,30 @@ git-p4.largeFileSystem::
 git config       git-p4.largeFileSystem GitLFS
 -------------
 
-git-p4.largeFileExtensions::
+`git-p4.largeFileExtensions`::
 	All files matching a file extension in the list will be processed
 	by the large file system. Do not prefix the extensions with '.'.
 
-git-p4.largeFileThreshold::
+`git-p4.largeFileThreshold`::
 	All files with an uncompressed size exceeding the threshold will be
 	processed by the large file system. By default the threshold is
 	defined in bytes. Add the suffix k, m, or g to change the unit.
 
-git-p4.largeFileCompressedThreshold::
+`git-p4.largeFileCompressedThreshold`::
 	All files with a compressed size exceeding the threshold will be
 	processed by the large file system. This option might slow down
 	your clone/sync process. By default the threshold is defined in
 	bytes. Add the suffix k, m, or g to change the unit.
 
-git-p4.largeFilePush::
+`git-p4.largeFilePush`::
 	Boolean variable which defines if large files are automatically
 	pushed to a server.
 
-git-p4.keepEmptyCommits::
+`git-p4.keepEmptyCommits`::
 	A changelist that contains only excluded files will be imported
 	as an empty commit if this boolean option is set to true.
 
-git-p4.mapUser::
+`git-p4.mapUser`::
 	Map a P4 user to a name and email address in Git. Use a string
 	with the following format to create a mapping:
 +
@@ -685,69 +685,69 @@ multiple P4 user can be defined.
 
 Submit variables
 ~~~~~~~~~~~~~~~~
-git-p4.detectRenames::
+`git-p4.detectRenames`::
 	Detect renames.  See linkgit:git-diff[1].  This can be true,
 	false, or a score as expected by `git diff -M`.
 
-git-p4.detectCopies::
+`git-p4.detectCopies`::
 	Detect copies.  See linkgit:git-diff[1].  This can be true,
 	false, or a score as expected by `git diff -C`.
 
-git-p4.detectCopiesHarder::
+`git-p4.detectCopiesHarder`::
 	Detect copies harder.  See linkgit:git-diff[1].  A boolean.
 
-git-p4.preserveUser::
+`git-p4.preserveUser`::
 	On submit, re-author changes to reflect the Git author,
 	regardless of who invokes `git p4 submit`.
 
-git-p4.allowMissingP4Users::
+`git-p4.allowMissingP4Users`::
 	When 'preserveUser' is true, `git p4` normally dies if it
 	cannot find an author in the p4 user map.  This setting
 	submits the change regardless.
 
-git-p4.skipSubmitEdit::
+`git-p4.skipSubmitEdit`::
 	The submit process invokes the editor before each p4 change
 	is submitted.  If this setting is true, though, the editing
 	step is skipped.
 
-git-p4.skipSubmitEditCheck::
+`git-p4.skipSubmitEditCheck`::
 	After editing the p4 change message, `git p4` makes sure that
 	the description really was changed by looking at the file
 	modification time.  This option disables that test.
 
-git-p4.allowSubmit::
+`git-p4.allowSubmit`::
 	By default, any branch can be used as the source for a `git p4
 	submit` operation.  This configuration variable, if set, permits only
 	the named branches to be used as submit sources.  Branch names
 	must be the short names (no `refs/heads/`), and should be
 	separated by commas (","), with no spaces.
 
-git-p4.skipUserNameCheck::
+`git-p4.skipUserNameCheck`::
 	If the user running `git p4 submit` does not exist in the p4
 	user map, `git p4` exits.  This option can be used to force
 	submission regardless.
 
-git-p4.attemptRCSCleanup::
+`git-p4.attemptRCSCleanup`::
 	If enabled, `git p4 submit` will attempt to cleanup RCS keywords
 	($Header$, etc). These would otherwise cause merge conflicts and prevent
 	the submit going ahead. This option should be considered experimental at
 	present.
 
-git-p4.exportLabels::
+`git-p4.exportLabels`::
 	Export Git tags to p4 labels, as per `--export-labels`.
 
-git-p4.labelExportRegexp::
+`git-p4.labelExportRegexp`::
 	Only p4 labels matching this regular expression will be exported. The
 	default value is '[a-zA-Z0-9_\-.]+$'.
 
-git-p4.conflict::
+`git-p4.conflict`::
 	Specify submit behavior when a conflict with p4 is found, as per
 	`--conflict`.  The default behavior is 'ask'.
 
-git-p4.disableRebase::
+`git-p4.disableRebase`::
     Do not rebase the tree against p4/master following a submit.
 
-git-p4.disableP4Sync::
+`git-p4.disableP4Sync`::
     Do not sync p4/master with Perforce following a submit. Implies `git-p4.disableRebase`.
 
 IMPLEMENTATION DETAILS
diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
index 958ab5018b..abd617524c 100644
--- a/Documentation/git-send-email.txt
+++ b/Documentation/git-send-email.txt
@@ -443,11 +443,11 @@ Information
 CONFIGURATION
 -------------
 
-sendemail.aliasesFile::
+`sendemail.aliasesFile`::
 	To avoid typing long email addresses, point this to one or more
 	email aliases files.  You must also supply `sendemail.aliasFileType`.
 
-sendemail.aliasFileType::
+`sendemail.aliasFileType`::
 	Format of the file(s) specified in `sendemail.aliasesFile`. Must be
 	one of 'mutt', 'mailrc', 'pine', 'elm', or 'gnus', or 'sendmail'.
 +
@@ -468,13 +468,13 @@ described below:
 	recognized by the parser.
 --
 
-sendemail.multiEdit::
+`sendemail.multiEdit`::
 	If true (default), a single editor instance will be spawned to edit
 	files you have to edit (patches when `--annotate` is used, and the
 	summary when `--compose` is used). If false, files will be edited one
 	after the other, spawning a new editor each time.
 
-sendemail.confirm::
+`sendemail.confirm`::
 	Sets the default for whether to confirm before sending. Must be
 	one of 'always', 'never', 'cc', 'compose', or 'auto'. See `--confirm`
 	in the previous section for the meaning of these values.
diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
index d484152b7a..5e31bd8088 100644
--- a/Documentation/git-svn.txt
+++ b/Documentation/git-svn.txt
@@ -755,8 +755,8 @@ config key: `svn.followparent`
 CONFIG FILE-ONLY OPTIONS
 ------------------------
 
-svn.noMetadata::
-svn-remote.<name>.noMetadata::
+`svn.noMetadata`::
+`svn-remote.<name>.noMetadata`::
 	This gets rid of the 'git-svn-id:' lines at the end of every commit.
 +
 This option can only be used for one-shot imports as `git svn`
@@ -776,8 +776,8 @@ https://github.com/newren/git-filter-repo[git-filter-repo] instead.
 filter-repo also allows reformatting of metadata for ease-of-reading
 and rewriting authorship info for non-`svn.authorsFile` users.
 
-svn.useSvmProps::
-svn-remote.<name>.useSvmProps::
+`svn.useSvmProps`::
+`svn-remote.<name>.useSvmProps`::
 	This allows `git svn` to re-map repository URLs and UUIDs from
 	mirrors created using SVN::Mirror (or svk) for metadata.
 +
@@ -789,26 +789,26 @@ introduce a helper function that returns the original identity
 URL and UUID, and use it when generating metadata in commit
 messages.
 
-svn.useSvnsyncProps::
-svn-remote.<name>.useSvnsyncprops::
+`svn.useSvnsyncProps`::
+`svn-remote.<name>.useSvnsyncprops`::
 	Similar to the useSvmProps option; this is for users
 	of the svnsync(1) command distributed with SVN 1.4.x and
 	later.
 
-svn-remote.<name>.rewriteRoot::
+`svn-remote.<name>.rewriteRoot`::
 	This allows users to create repositories from alternate
 	URLs.  For example, an administrator could run `git svn` on the
 	server locally (accessing via `file://`) but wish to distribute
 	the repository with a public `http://` or `svn://` URL in the
 	metadata so users of it will see the public URL.
 
-svn-remote.<name>.rewriteUUID::
+`svn-remote.<name>.rewriteUUID`::
 	Similar to the useSvmProps option; this is for users who need
 	to remap the UUID manually. This may be useful in situations
 	where the original UUID is not available via either useSvmProps
 	or useSvnsyncProps.
 
-svn-remote.<name>.pushurl::
+`svn-remote.<name>.pushurl`::
 
 	Similar to Git's `remote.<name>.pushurl`, this key is designed
 	to be used in cases where 'url' points to an SVN repository
@@ -818,7 +818,7 @@ svn-remote.<name>.pushurl::
 	either 'commiturl' or 'pushurl' could be used, 'commiturl'
 	takes precedence.
 
-svn.brokenSymlinkWorkaround::
+`svn.brokenSymlinkWorkaround`::
 	This disables potentially expensive checks to workaround
 	broken symlinks checked into SVN by broken clients.  Set this
 	option to "false" if you track a SVN repository with many
@@ -827,13 +827,13 @@ svn.brokenSymlinkWorkaround::
 	revision fetched.  If unset, `git svn` assumes this option to
 	be "true".
 
-svn.pathnameencoding::
+`svn.pathnameencoding`::
 	This instructs `git svn` to recode pathnames to a given encoding.
 	It can be used by windows users and by those who work in non-utf8
 	locales to avoid corrupted file names with non-ASCII characters.
 	Valid encodings are the ones supported by Perl's Encode module.
 
-svn-remote.<name>.automkdirs::
+`svn-remote.<name>.automkdirs`::
 	Normally, the `git svn clone` and `git svn rebase` commands
 	attempt to recreate empty directories that are in the
 	Subversion repository.  If this option is set to "false", then
diff --git a/Documentation/gitmodules.txt b/Documentation/gitmodules.txt
index 861a8ae778..e4e5ecded2 100644
--- a/Documentation/gitmodules.txt
+++ b/Documentation/gitmodules.txt
@@ -23,13 +23,13 @@ submodule has been added unless it was customized with the `--name`
 option of `git submodule add`. Each submodule section also contains the
 following required keys:
 
-submodule.<name>.path::
+`submodule.<name>.path`::
 	Defines the path, relative to the top-level directory of the Git
 	working tree, where the submodule is expected to be checked out.
 	The path name must not end with a `/`. All submodule paths must
 	be unique within the `.gitmodules` file.
 
-submodule.<name>.url::
+`submodule.<name>.url`::
 	Defines a URL from which the submodule repository can be cloned.
 	This may be either an absolute URL ready to be passed to
 	linkgit:git-clone[1] or (if it begins with `./` or `../`) a location
@@ -37,7 +37,7 @@ submodule.<name>.url::
 
 In addition, there are a number of optional keys:
 
-submodule.<name>.update::
+`submodule.<name>.update`::
 	Defines the default update procedure for the named submodule,
 	i.e. how the submodule is updated by the `git submodule update`
 	command in the superproject. This is only used by `git
@@ -47,7 +47,7 @@ submodule.<name>.update::
 	linkgit:git-submodule[1] for their meaning. For security
 	reasons, the '!command' form is not accepted here.
 
-submodule.<name>.branch::
+`submodule.<name>.branch`::
 	A remote branch name for tracking updates in the upstream submodule.
 	If the option is not specified, it defaults to the remote `HEAD`.
 	A special value of `.` is used to indicate that the name of the branch
@@ -55,7 +55,7 @@ submodule.<name>.branch::
 	current repository.  See the `--remote` documentation in
 	linkgit:git-submodule[1] for details.
 
-submodule.<name>.fetchRecurseSubmodules::
+`submodule.<name>.fetchRecurseSubmodules`::
 	This option can be used to control recursive fetching of this
 	submodule. If this option is also present in the submodule's entry in
 	`.git/config` of the superproject, the setting there will override the
@@ -63,7 +63,7 @@ submodule.<name>.fetchRecurseSubmodules::
 	Both settings can be overridden on the command line by using the
 	`--[no-]recurse-submodules` option to `git fetch` and `git pull`.
 
-submodule.<name>.ignore::
+`submodule.<name>.ignore`::
 	Defines under what circumstances `git status` and the diff family show
 	a submodule as modified. The following values are supported:
 +
@@ -93,7 +93,7 @@ Both settings can be overridden on the command line by using the
 affected by this setting.
 --
 
-submodule.<name>.shallow::
+`submodule.<name>.shallow`::
 	When set to true, a clone of this submodule will be performed as a
 	shallow clone (with a history depth of 1) unless the user explicitly
 	asks for a non-shallow clone.
diff --git a/Documentation/gitrepository-layout.txt b/Documentation/gitrepository-layout.txt
index c639ea8cc6..8d2cc46d44 100644
--- a/Documentation/gitrepository-layout.txt
+++ b/Documentation/gitrepository-layout.txt
@@ -145,7 +145,7 @@ for details.
 	if `$GIT_COMMON_DIR` is set and `$GIT_COMMON_DIR/config` will be
 	used instead.
 
-config.worktree::
+`config.worktree`::
 	Working directory specific configuration file for the main
 	working directory in multiple working directory setup (see
 	linkgit:git-worktree[1]).
@@ -182,7 +182,7 @@ config.worktree::
 	The current index file for the repository.  It is
 	usually not found in a bare repository.
 
-sharedindex.<SHA-1>::
+`sharedindex.<SHA-1>`::
 	The shared index part, to be referenced by `$GIT_DIR/index` and
 	other temporary index files. Only valid in split index mode.
 
diff --git a/Documentation/gitweb.txt b/Documentation/gitweb.txt
index 057038bb6d..e863f739b1 100644
--- a/Documentation/gitweb.txt
+++ b/Documentation/gitweb.txt
@@ -254,7 +254,7 @@ This is per-repository enhancement / version of global prefix-based
 `@git_base_url_list` `gitweb` configuration variable (see
 linkgit:gitweb.conf[5]).
 
-gitweb.owner::
+`gitweb.owner`::
 	You can use the `gitweb.owner` repository configuration variable to set
 	repository's owner.  It is displayed in the project list and summary
 	page.
-- 
2.31.1.133.g84d06cdc06

