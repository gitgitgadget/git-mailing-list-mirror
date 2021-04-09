Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 375DFC433ED
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 04:05:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 04D95610A4
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 04:05:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229498AbhDIEF7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Apr 2021 00:05:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229840AbhDIEF5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Apr 2021 00:05:57 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 042CBC061760
        for <git@vger.kernel.org>; Thu,  8 Apr 2021 21:05:42 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id w4so459752wrt.5
        for <git@vger.kernel.org>; Thu, 08 Apr 2021 21:05:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oUNB4/TycE7b5K/VnjkROV2WUTl0wsHy2lTB10K6P6g=;
        b=l+IBV+Gx5vO5+MSP5pJu8LCwDOBJUQNU0C652/WvJpUMIjkpF9I5p3+vnHNfT4JW4d
         ZWxoq9f+kBTLQdfQ2s8IovUJg7hI3WiXvvXWr3fqADmKVY/PEHOnog+nb6K7kcTu9G1C
         ZP5l7T4Q3r/JMefada9q5wIckw5nNRdI/VtTBYIiRTjYb5NoY6w8pqz3WPuyHYAaFvNw
         ii0N3o8W0i5Fbck8KznynmV4iVIejhiqGgWIbxfSYrOLVZXezUcLj/b6r2lUxBo23gGu
         LBcPtPpB0hV1oyturDza4lLOfkFkj0E2s4bawliwKt00on1HJPYixGNe8XFLEswbManc
         gWpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oUNB4/TycE7b5K/VnjkROV2WUTl0wsHy2lTB10K6P6g=;
        b=J5u5B84esp6oQnyqr6D1Cc+yWkALNbWynyjVfIAb6oXs7sVhyPqAmuwPygDxn4lUcz
         A4RCEcgysSGBhllyHyWATbKEydHjPF1D53Z7fQepNozfA4WBobsdWtOG5MArDkCqLHRK
         ruBSOVfq454gPRhRnBe2xi+UNcg9BZdkMktr3OpMMX9OIGgWl1Y151ml5ji5IDDaP2Z7
         baBxLryH6JV2dAbo1nAWRW5trgEn+nh30AnbtcGlVA3jEKJx9izwZ9cKBCZS4qyHMBgi
         /jpzmBZlkJ5YZqrQ8gsTRud2znNdepv158tKvNnf6Afx2IcRhLiuZr3Nfp083S64KOew
         w09w==
X-Gm-Message-State: AOAM531CXMVyc4NIv7+HczMQeL03or40ADT34iLxrsiQTwWYRA/JH72z
        13jKWOu7gpl4xDe69qNbuIgjpeE42yBGxA==
X-Google-Smtp-Source: ABdhPJwiIXsEAo8Kj6MBvWFHnHQW81O2ZfTxVSLn3SkmNEIhJGg5jJ9PIhMvtQub7XC68g5wnmZ81w==
X-Received: by 2002:a5d:6443:: with SMTP id d3mr15636154wrw.292.1617941138117;
        Thu, 08 Apr 2021 21:05:38 -0700 (PDT)
Received: from Inspiron.home (2a01cb04010c420080e637770dc2ae3c.ipv6.abo.wanadoo.fr. [2a01:cb04:10c:4200:80e6:3777:dc2:ae3c])
        by smtp.gmail.com with ESMTPSA id c9sm2064636wrr.78.2021.04.08.21.05.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Apr 2021 21:05:37 -0700 (PDT)
From:   Firmin Martin <firminmartin24@gmail.com>
To:     git@vger.kernel.org
Cc:     Firmin Martin <firminmartin24@gmail.com>
Subject: [RFC PATCH v1 01/13] doc: typeset command-line options in monospace
Date:   Fri,  9 Apr 2021 06:02:49 +0200
Message-Id: <20210409040301.3260358-2-firminmartin24@gmail.com>
X-Mailer: git-send-email 2.31.1.133.g84d06cdc06
In-Reply-To: <20210409040301.3260358-1-firminmartin24@gmail.com>
References: <20210409040301.3260358-1-firminmartin24@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Wrap command-line options with backticks as indicated in the
CodingGuidelines.

The following command and regex assisted the process.

    REGEX="^(?![[:blank:]]*[\$]).*[^-\`+<[:punct:][:alnum:]]\-{1,2}[[:alpha:]][a-z0-9-]*(=[\"<]?([[:alnum:]])+[>\"]?)?[^\`-]" &&
    grep -Pn "$REGEX" *.txt --exclude-dir=RelNotes

Signed-off-by: Firmin Martin <firminmartin24@gmail.com>
---
 Documentation/SubmittingPatches               |   2 +-
 Documentation/blame-options.txt               |   6 +-
 Documentation/config/diff.txt                 |   2 +-
 Documentation/config/gitcvs.txt               |   6 +-
 Documentation/diff-generate-patch.txt         |   4 +-
 Documentation/diff-options.txt                |   8 +-
 Documentation/fetch-options.txt               |  16 +--
 Documentation/git-add.txt                     |   2 +-
 Documentation/git-apply.txt                   |   2 +-
 Documentation/git-archimport.txt              |   2 +-
 Documentation/git-archive.txt                 |   2 +-
 Documentation/git-branch.txt                  |   2 +-
 Documentation/git-bundle.txt                  |  10 +-
 Documentation/git-checkout-index.txt          |   6 +-
 Documentation/git-checkout.txt                |   4 +-
 Documentation/git-cherry-pick.txt             |   2 +-
 Documentation/git-clean.txt                   |   8 +-
 Documentation/git-clone.txt                   |   4 +-
 Documentation/git-column.txt                  |   2 +-
 Documentation/git-commit.txt                  |  16 +--
 Documentation/git-config.txt                  |   6 +-
 Documentation/git-count-objects.txt           |   6 +-
 Documentation/git-cvsexportcommit.txt         |   8 +-
 Documentation/git-cvsimport.txt               |  12 +-
 Documentation/git-cvsserver.txt               |  12 +-
 Documentation/git-daemon.txt                  |  22 ++--
 Documentation/git-describe.txt                |  18 +--
 Documentation/git-diff-tree.txt               |   6 +-
 Documentation/git-diff.txt                    |   6 +-
 Documentation/git-fast-export.txt             |  10 +-
 Documentation/git-fast-import.txt             |  42 +++----
 Documentation/git-fetch-pack.txt              |   4 +-
 Documentation/git-fetch.txt                   |   6 +-
 Documentation/git-filter-branch.txt           |  26 ++---
 Documentation/git-fmt-merge-msg.txt           |   2 +-
 Documentation/git-for-each-ref.txt            |   4 +-
 Documentation/git-format-patch.txt            |   6 +-
 Documentation/git-fsck.txt                    |   6 +-
 Documentation/git-gc.txt                      |   4 +-
 Documentation/git-grep.txt                    |   4 +-
 Documentation/git-help.txt                    |   8 +-
 Documentation/git-http-fetch.txt              |   2 +-
 Documentation/git-http-push.txt               |   2 +-
 Documentation/git-index-pack.txt              |  12 +-
 Documentation/git-init.txt                    |   2 +-
 Documentation/git-interpret-trailers.txt      |  18 +--
 Documentation/git-ls-files.txt                |  24 ++--
 Documentation/git-ls-remote.txt               |   2 +-
 Documentation/git-ls-tree.txt                 |   6 +-
 Documentation/git-mailinfo.txt                |   4 +-
 Documentation/git-mailsplit.txt               |   2 +-
 Documentation/git-merge-index.txt             |   2 +-
 Documentation/git-mv.txt                      |   2 +-
 Documentation/git-name-rev.txt                |  10 +-
 Documentation/git-notes.txt                   |   4 +-
 Documentation/git-p4.txt                      |  26 ++---
 Documentation/git-pack-objects.txt            |  36 +++---
 Documentation/git-patch-id.txt                |   6 +-
 Documentation/git-prune.txt                   |   2 +-
 Documentation/git-pull.txt                    |   6 +-
 Documentation/git-push.txt                    |  10 +-
 Documentation/git-quiltimport.txt             |   2 +-
 Documentation/git-read-tree.txt               |   6 +-
 Documentation/git-rebase.txt                  | 108 +++++++++---------
 Documentation/git-repack.txt                  |   2 +-
 Documentation/git-reset.txt                   |   4 +-
 Documentation/git-rev-parse.txt               |   6 +-
 Documentation/git-rm.txt                      |   2 +-
 Documentation/git-send-email.txt              |  42 +++----
 Documentation/git-send-pack.txt               |   2 +-
 Documentation/git-show-branch.txt             |   2 +-
 Documentation/git-show-ref.txt                |  12 +-
 Documentation/git-status.txt                  |  10 +-
 Documentation/git-submodule.txt               |   2 +-
 Documentation/git-svn.txt                     |  76 ++++++------
 Documentation/git-tag.txt                     |   4 +-
 Documentation/git-update-index.txt            |  12 +-
 Documentation/git-update-ref.txt              |   6 +-
 Documentation/git-verify-pack.txt             |   2 +-
 Documentation/git-web--browse.txt             |   2 +-
 Documentation/git-whatchanged.txt             |   2 +-
 Documentation/git.txt                         |   4 +-
 Documentation/gitcore-tutorial.txt            |   2 +-
 Documentation/gitdiffcore.txt                 |  30 ++---
 Documentation/gitk.txt                        |   6 +-
 Documentation/gittutorial-2.txt               |   4 +-
 Documentation/gittutorial.txt                 |   4 +-
 Documentation/gitweb.conf.txt                 |   6 +-
 Documentation/howto/revert-branch-rebase.txt  |   2 +-
 .../howto/setup-git-server-over-http.txt      |   2 +-
 Documentation/merge-options.txt               |  22 ++--
 Documentation/pretty-formats.txt              |  12 +-
 Documentation/pretty-options.txt              |  20 ++--
 Documentation/rev-list-options.txt            |  28 ++---
 Documentation/signoff-option.txt              |   2 +-
 Documentation/urls.txt                        |   4 +-
 Documentation/user-manual.txt                 |   4 +-
 97 files changed, 479 insertions(+), 479 deletions(-)

diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
index 0452db2e67..e7623d967b 100644
--- a/Documentation/SubmittingPatches
+++ b/Documentation/SubmittingPatches
@@ -158,7 +158,7 @@ invocation of `git show`:
 	git show -s --pretty=reference <commit>
 ....
 
-or, on an older version of Git without support for --pretty=reference:
+or, on an older version of Git without support for `--pretty=reference`:
 
 ....
 	git show -s --date=short --pretty='format:%h (%s, %ad)' <commit>
diff --git a/Documentation/blame-options.txt b/Documentation/blame-options.txt
index 117f4cf806..860e8e2f5c 100644
--- a/Documentation/blame-options.txt
+++ b/Documentation/blame-options.txt
@@ -50,7 +50,7 @@ include::line-range-format.txt[]
 --line-porcelain::
 	Show the porcelain format, but output commit information for
 	each line, not just the first time a commit is referenced.
-	Implies --porcelain.
+	Implies `--porcelain`.
 
 --incremental::
 	Show the result incrementally in a format designed for
@@ -71,11 +71,11 @@ include::line-range-format.txt[]
 	`-` to make the command read from the standard input).
 
 --date <format>::
-	Specifies the format used to output dates. If --date is not
+	Specifies the format used to output dates. If `--date` is not
 	provided, the value of the blame.date config variable is
 	used. If the blame.date config variable is also not set, the
 	iso format is used. For supported values, see the discussion
-	of the --date option at linkgit:git-log[1].
+	of the `--date` option at linkgit:git-log[1].
 
 --[no-]progress::
 	Progress status is reported on the standard error stream
diff --git a/Documentation/config/diff.txt b/Documentation/config/diff.txt
index 2d3331f55c..7556df330c 100644
--- a/Documentation/config/diff.txt
+++ b/Documentation/config/diff.txt
@@ -113,7 +113,7 @@ diff.relative::
 
 diff.orderFile::
 	File indicating how to order files within a diff.
-	See the '-O' option to linkgit:git-diff[1] for details.
+	See the `-O` option to linkgit:git-diff[1] for details.
 	If `diff.orderFile` is a relative pathname, it is treated as
 	relative to the top of the working tree.
 
diff --git a/Documentation/config/gitcvs.txt b/Documentation/config/gitcvs.txt
index 02da427fd9..a188638340 100644
--- a/Documentation/config/gitcvs.txt
+++ b/Documentation/config/gitcvs.txt
@@ -16,16 +16,16 @@ gitcvs.usecrlfattr::
 	the attributes force Git to treat a file as text,
 	the `-k` mode will be left blank so CVS clients will
 	treat it as text. If they suppress text conversion, the file
-	will be set with '-kb' mode, which suppresses any newline munging
+	will be set with `-kb` mode, which suppresses any newline munging
 	the client might otherwise do. If the attributes do not allow
 	the file type to be determined, then `gitcvs.allBinary` is
 	used. See linkgit:gitattributes[5].
 
 gitcvs.allBinary::
 	This is used if `gitcvs.usecrlfattr` does not resolve
-	the correct '-kb' mode to use. If true, all
+	the correct `-kb` mode to use. If true, all
 	unresolved files are sent to the client in
-	mode '-kb'. This causes the client to treat them
+	mode `-kb`. This causes the client to treat them
 	as binary files, which suppresses any newline munging it
 	otherwise might do. Alternatively, if it is set to "guess",
 	then the contents of the file are examined to decide if
diff --git a/Documentation/diff-generate-patch.txt b/Documentation/diff-generate-patch.txt
index 2db8eacc3e..2615b29cb0 100644
--- a/Documentation/diff-generate-patch.txt
+++ b/Documentation/diff-generate-patch.txt
@@ -13,7 +13,7 @@ You can customize the creation of patch text via the
 `GIT_EXTERNAL_DIFF` and the `GIT_DIFF_OPTS` environment variables
 (see linkgit:git[1]).
 
-What the -p option produces is slightly different from the traditional
+What the `-p` option produces is slightly different from the traditional
 diff format:
 
 1.   It is preceded with a "git diff" header that looks like this:
@@ -149,7 +149,7 @@ Similar to two-line header for traditional 'unified' diff
 format, `/dev/null` is used to signal created or deleted
 files.
 +
-However, if the --combined-all-paths option is provided, instead of a
+However, if the `--combined-all-paths` option is provided, instead of a
 two-line from-file/to-file you get a N+1 line from-file/to-file header,
 where N is the number of parents in the merge commit
 
diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index aa2b5c11f2..13e0753862 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -471,7 +471,7 @@ ifndef::git-format-patch[]
 	that is immediately followed by a tab character inside the
 	initial indent of the line are considered whitespace errors.
 	Exits with non-zero status if problems are found. Not compatible
-	with --exit-code.
+	with `--exit-code`.
 
 --ws-error-highlight=<kind>::
 	Highlight whitespace errors in the `context`, `old` or `new`
@@ -522,10 +522,10 @@ original should remain in the result for Git to consider it a total
 rewrite (i.e. otherwise the resulting patch will be a series of
 deletion and insertion mixed together with context lines).
 +
-When used with -M, a totally-rewritten file is also considered as the
-source of a rename (usually -M only considers a file that disappeared
+When used with `-M`, a totally-rewritten file is also considered as the
+source of a rename (usually `-M` only considers a file that disappeared
 as the source of a rename), and the number `n` controls this aspect of
-the -B option (defaults to 50%). `-B20%` specifies that a change with
+the `-B` option (defaults to 50%). `-B20%` specifies that a change with
 addition and deletion compared to 20% or more of the file's size are
 eligible for being picked up as a possible source of a rename to
 another file.
diff --git a/Documentation/fetch-options.txt b/Documentation/fetch-options.txt
index 07783deee3..4ccd65c166 100644
--- a/Documentation/fetch-options.txt
+++ b/Documentation/fetch-options.txt
@@ -115,10 +115,10 @@ endif::git-pull[]
 	Before fetching, remove any remote-tracking references that no
 	longer exist on the remote.  Tags are not subject to pruning
 	if they are fetched only because of the default tag
-	auto-following or due to a --tags option.  However, if tags
+	auto-following or due to a `--tags` option.  However, if tags
 	are fetched due to an explicit refspec (either on the command
 	line or in the remote configuration, for example if the remote
-	was cloned with the --mirror option), then they are also
+	was cloned with the `--mirror` option), then they are also
 	subject to pruning. Supplying `--prune-tags` is a shorthand for
 	providing the tag refspec.
 ifndef::git-pull[]
@@ -164,7 +164,7 @@ endif::git-pull[]
 	Fetch all tags from the remote (i.e., fetch remote tags
 	`refs/tags/*` into local tags with the same name), in addition
 	to whatever else would otherwise be fetched.  Using this
-	option alone does not subject tags to pruning, even if --prune
+	option alone does not subject tags to pruning, even if `--prune`
 	is used (though tags may be pruned anyway if they are also the
 	destination of an explicit refspec; see `--prune`).
 
@@ -215,7 +215,7 @@ ifndef::git-pull[]
 
 --recurse-submodules-default=[yes|on-demand]::
 	This option is used internally to temporarily provide a
-	non-negative default value for the --recurse-submodules
+	non-negative default value for the `--recurse-submodules`
 	option.  All other methods of configuring fetch's submodule
 	recursion (such as settings in linkgit:gitmodules[5] and
 	linkgit:git-config[1]) override this option, as does
@@ -240,7 +240,7 @@ endif::git-pull[]
 ifndef::git-pull[]
 -q::
 --quiet::
-	Pass --quiet to git-fetch-pack and silence any other internally
+	Pass `--quiet` to git-fetch-pack and silence any other internally
 	used git commands. Progress is not reported to the standard error
 	stream.
 
@@ -267,14 +267,14 @@ endif::git-pull[]
 --show-forced-updates::
 	By default, git checks if a branch is force-updated during
 	fetch. This can be disabled through fetch.showForcedUpdates, but
-	the --show-forced-updates option guarantees this check occurs.
+	the `--show-forced-updates` option guarantees this check occurs.
 	See linkgit:git-config[1].
 
 --no-show-forced-updates::
 	By default, git checks if a branch is force-updated during
-	fetch. Pass --no-show-forced-updates or set fetch.showForcedUpdates
+	fetch. Pass `--no-show-forced-updates` or set fetch.showForcedUpdates
 	to false to skip this check for performance reasons. If used during
-	'git-pull' the --ff-only option will still check for forced updates
+	'git-pull' the `--ff-only` option will still check for forced updates
 	before attempting a fast-forward update. See linkgit:git-config[1].
 
 -4::
diff --git a/Documentation/git-add.txt b/Documentation/git-add.txt
index be5e3ac54b..6a7cb07a8a 100644
--- a/Documentation/git-add.txt
+++ b/Documentation/git-add.txt
@@ -164,7 +164,7 @@ for "git add --no-all <pathspec>...", i.e. ignored removed files.
 	true to make this the default behaviour.
 
 --ignore-missing::
-	This option can only be used together with --dry-run. By using
+	This option can only be used together with `--dry-run`. By using
 	this option the user can check if any of the given files would
 	be ignored, no matter if they are already present in the work
 	tree or not.
diff --git a/Documentation/git-apply.txt b/Documentation/git-apply.txt
index 91d9a8601c..f1c8098c0b 100644
--- a/Documentation/git-apply.txt
+++ b/Documentation/git-apply.txt
@@ -233,7 +233,7 @@ behavior:
 	adjusting the hunk headers appropriately).
 
 --directory=<root>::
-	Prepend <root> to all filenames.  If a "-p" argument was also passed,
+	Prepend <root> to all filenames.  If a `-p` argument was also passed,
 	it is applied before prepending the new root.
 +
 For example, a patch that talks about updating `a/git-gui.sh` to `b/git-gui.sh`
diff --git a/Documentation/git-archimport.txt b/Documentation/git-archimport.txt
index a595a0ffee..b477e3c495 100644
--- a/Documentation/git-archimport.txt
+++ b/Documentation/git-archimport.txt
@@ -98,7 +98,7 @@ OPTIONS
 
 -a::
 	Attempt to auto-register archives at `http://mirrors.sourcecontrol.net`
-	This is particularly useful with the -D option.
+	This is particularly useful with the `-D` option.
 
 -t <tmpdir>::
 	Override the default tempdir.
diff --git a/Documentation/git-archive.txt b/Documentation/git-archive.txt
index 9f8172828d..0af18c9df3 100644
--- a/Documentation/git-archive.txt
+++ b/Documentation/git-archive.txt
@@ -77,7 +77,7 @@ OPTIONS
 	linkgit:git-upload-archive[1] for details.
 
 --exec=<git-upload-archive>::
-	Used with --remote to specify the path to the
+	Used with `--remote` to specify the path to the
 	'git-upload-archive' on the remote side.
 
 <tree-ish>::
diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.txt
index 94dc9a54f2..271b4ee34e 100644
--- a/Documentation/git-branch.txt
+++ b/Documentation/git-branch.txt
@@ -280,7 +280,7 @@ start-point is either a local or remote-tracking branch.
 
 --sort=<key>::
 	Sort based on the key given. Prefix `-` to sort in descending
-	order of the value. You may use the --sort=<key> option
+	order of the value. You may use the `--sort=<key>` option
 	multiple times, in which case the last key becomes the primary
 	key. The keys supported are the same as those in `git
 	for-each-ref`. Sort order defaults to the value configured for the
diff --git a/Documentation/git-bundle.txt b/Documentation/git-bundle.txt
index 53804cad4b..4f1e59a3b2 100644
--- a/Documentation/git-bundle.txt
+++ b/Documentation/git-bundle.txt
@@ -88,19 +88,19 @@ unbundle <file>::
 	the standard error stream is not directed to a terminal.
 
 --all-progress::
-	When --stdout is specified then progress report is
+	When `--stdout` is specified then progress report is
 	displayed during the object count and compression phases
 	but inhibited during the write-out phase. The reason is
 	that in some cases the output stream is directly linked
 	to another command which may wish to display progress
 	status of its own as it processes incoming pack data.
-	This flag is like --progress except that it forces progress
-	report for the write-out phase as well even if --stdout is
+	This flag is like `--progress` except that it forces progress
+	report for the write-out phase as well even if `--stdout` is
 	used.
 
 --all-progress-implied::
-	This is used to imply --all-progress whenever progress display
-	is activated.  Unlike --all-progress this flag doesn't actually
+	This is used to imply `--all-progress` whenever progress display
+	is activated.  Unlike `--all-progress` this flag doesn't actually
 	force any progress display by itself.
 
 --version=<version>::
diff --git a/Documentation/git-checkout-index.txt b/Documentation/git-checkout-index.txt
index 4d33e7be0f..b06d3ae3d9 100644
--- a/Documentation/git-checkout-index.txt
+++ b/Documentation/git-checkout-index.txt
@@ -52,7 +52,7 @@ OPTIONS
 --stage=<number>|all::
 	Instead of checking out unmerged entries, copy out the
 	files from named stage.  <number> must be between 1 and 3.
-	Note: --stage=all automatically implies --temp.
+	Note: `--stage=all` automatically implies `--temp`.
 
 --temp::
 	Instead of copying the files to the working directory
@@ -88,7 +88,7 @@ $ find . -name '*.h' -print0 | xargs -0 git checkout-index -f --
 which will force all existing `*.h` files to be replaced with their
 cached copies. If an empty command line implied "all", then this would
 force-refresh everything in the index, which was not the point.  But
-since 'git checkout-index' accepts --stdin it would be faster to use:
+since 'git checkout-index' accepts `--stdin` it would be faster to use:
 
 ----------------
 $ find . -name '*.h' -print0 | git checkout-index -f -z --stdin
@@ -128,7 +128,7 @@ or `.` if there is no stage entry.  Paths which only have a stage 0
 entry will always be omitted from the output.
 
 In both formats RS (the record separator) is newline by default
-but will be the null byte if -z was passed on the command line.
+but will be the null byte if `-z` was passed on the command line.
 The temporary file names are always safe strings; they will never
 contain directory separators or whitespace characters.  The path
 field is always relative to the current directory and the temporary
diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkout.txt
index b1a6fe4499..3336b8dace 100644
--- a/Documentation/git-checkout.txt
+++ b/Documentation/git-checkout.txt
@@ -151,13 +151,13 @@ of it").
 -B <new_branch>::
 	Creates the branch `<new_branch>` and start it at `<start_point>`;
 	if it already exists, then reset it to `<start_point>`. This is
-	equivalent to running "git branch" with "-f"; see
+	equivalent to running "git branch" with `-f`; see
 	linkgit:git-branch[1] for details.
 
 -t::
 --track::
 	When creating a new branch, set up "upstream" configuration. See
-	"--track" in linkgit:git-branch[1] for details.
+	`--track` in linkgit:git-branch[1] for details.
 +
 If no `-b` option is given, the name of the new branch will be
 derived from the remote-tracking branch, by looking at the local part of
diff --git a/Documentation/git-cherry-pick.txt b/Documentation/git-cherry-pick.txt
index 5d750314b2..0127f56204 100644
--- a/Documentation/git-cherry-pick.txt
+++ b/Documentation/git-cherry-pick.txt
@@ -126,7 +126,7 @@ effect to your index in a row.
 	indicating that an explicit invocation of `git commit
 	--allow-empty` is required. This option overrides that
 	behavior, allowing empty commits to be preserved automatically
-	in a cherry-pick. Note that when "--ff" is in effect, empty
+	in a cherry-pick. Note that when `--ff` is in effect, empty
 	commits that meet the "fast-forward" requirement will be kept
 	even without this option.  Note also, that use of this option only
 	keeps commits that were initially empty (i.e. the commit recorded the
diff --git a/Documentation/git-clean.txt b/Documentation/git-clean.txt
index a7f309dff5..f4246300ae 100644
--- a/Documentation/git-clean.txt
+++ b/Documentation/git-clean.txt
@@ -28,8 +28,8 @@ OPTIONS
 -d::
 	Normally, when no <path> is specified, git clean will not
 	recurse into untracked directories to avoid removing too much.
-	Specify -d to have it recurse into such directories as well.
-	If any paths are specified, -d is irrelevant; all untracked
+	Specify `-d` to have it recurse into such directories as well.
+	If any paths are specified, `-d` is irrelevant; all untracked
 	files matching the specified paths (with exceptions for nested
 	git directories mentioned under `--force`) will be removed.
 
@@ -37,9 +37,9 @@ OPTIONS
 --force::
 	If the Git configuration variable clean.requireForce is not set
 	to false, 'git clean' will refuse to delete files or directories
-	unless given -f or -i.  Git will refuse to modify untracked
+	unless given `-f` or `-i`.  Git will refuse to modify untracked
 	nested git repositories (directories with a .git subdirectory)
-	unless a second -f is given.
+	unless a second `-f` is given.
 
 -i::
 --interactive::
diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
index 3fe3810f1c..22334771d1 100644
--- a/Documentation/git-clone.txt
+++ b/Documentation/git-clone.txt
@@ -31,7 +31,7 @@ currently active branch.
 After the clone, a plain `git fetch` without arguments will update
 all the remote-tracking branches, and a `git pull` without
 arguments will in addition merge the remote master branch into the
-current master branch, if any (this is untrue when "--single-branch"
+current master branch, if any (this is untrue when `--single-branch`
 is given; see below).
 
 This default configuration is achieved by creating references to
@@ -52,7 +52,7 @@ OPTIONS
 	to save space when possible.
 +
 If the repository is specified as a local path (e.g., `/path/to/repo`),
-this is the default, and --local is essentially a no-op.  If the
+this is the default, and `--local` is essentially a no-op.  If the
 repository is specified as a URL, then this flag is ignored (and we
 never use the local optimizations).  Specifying `--no-local` will
 override the default when `/path/to/repo` is given, using the regular
diff --git a/Documentation/git-column.txt b/Documentation/git-column.txt
index f58e9c43e6..84a02ac15c 100644
--- a/Documentation/git-column.txt
+++ b/Documentation/git-column.txt
@@ -29,7 +29,7 @@ OPTIONS
 	syntax in linkgit:git-config[1].
 
 --raw-mode=<n>::
-	Same as --mode but take mode encoded as a number. This is mainly used
+	Same as `--mode` but take mode encoded as a number. This is mainly used
 	by other commands that have already parsed layout mode.
 
 --width=<width>::
diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
index 340c5fbb48..6d0d663b50 100644
--- a/Documentation/git-commit.txt
+++ b/Documentation/git-commit.txt
@@ -36,18 +36,18 @@ The content to be committed can be specified in several ways:
    and the index, again before using the 'commit' command;
 
 3. by listing files as arguments to the 'commit' command
-   (without --interactive or --patch switch), in which
+   (without `--interactive` or `--patch` switch), in which
    case the commit will ignore changes staged in the index, and instead
    record the current content of the listed files (which must already
    be known to Git);
 
-4. by using the -a switch with the 'commit' command to automatically
+4. by using the `-a` switch with the 'commit' command to automatically
    "add" changes from all known files (i.e. all files that are already
    listed in the index) and to automatically "rm" files in the index
    that have been removed from the working tree, and then perform the
    actual commit;
 
-5. by using the --interactive or --patch switches with the 'commit' command
+5. by using the `--interactive` or `--patch` switches with the 'commit' command
    to decide one by one which files or hunks should be part of the commit
    in addition to contents in the index,
    before finalizing the operation. See the ``Interactive Mode'' section of
@@ -84,7 +84,7 @@ OPTIONS
 
 -c <commit>::
 --reedit-message=<commit>::
-	Like '-C', but with `-c` the editor is invoked, so that
+	Like `-C`, but with `-c` the editor is invoked, so that
 	the user can further edit the commit message.
 
 --fixup=[(amend|reword):]<commit>::
@@ -134,7 +134,7 @@ See linkgit:git-rebase[1] for details.
 	linkgit:git-rebase[1] for details.
 
 --reset-author::
-	When used with -C/-c/--amend options, or when committing after a
+	When used with `-C`/`-c`/`--amend` options, or when committing after a
 	conflicting cherry-pick, declare that the authorship of the
 	resulting commit now belongs to the committer. This also renews
 	the author timestamp.
@@ -173,7 +173,7 @@ See linkgit:git-rebase[1] for details.
 	Override the commit author. Specify an explicit author using the
 	standard `A U Thor <author@example.com>` format. Otherwise <author>
 	is assumed to be a pattern and is used to search for an existing
-	commit by that author (i.e. rev-list --all -i --author=<author>);
+	commit by that author (i.e. `git rev-list --all -i --author=<author>`);
 	the commit author is then copied from the first such commit found.
 
 --date=<date>::
@@ -223,7 +223,7 @@ include::signoff-option.txt[]
 	is primarily for use by foreign SCM interface scripts.
 
 --allow-empty-message::
-       Like --allow-empty this command is primarily for use by foreign
+       Like `--allow-empty` this command is primarily for use by foreign
        SCM interface scripts. It allows you to create a commit with an
        empty commit message without using plumbing commands like
        linkgit:git-commit-tree[1].
@@ -337,7 +337,7 @@ FROM UPSTREAM REBASE" section in linkgit:git-rebase[1].)
 +
 --
 The mode parameter is optional (defaults to 'all'), and is used to
-specify the handling of untracked files; when -u is not used, the
+specify the handling of untracked files; when `-u` is not used, the
 default is 'normal', i.e. show untracked files and directories.
 
 The possible options are:
diff --git a/Documentation/git-config.txt b/Documentation/git-config.txt
index 4b4cc5c5e8..b93394ea45 100644
--- a/Documentation/git-config.txt
+++ b/Documentation/git-config.txt
@@ -92,7 +92,7 @@ OPTIONS
 	Like get, but returns all values for a multi-valued key.
 
 --get-regexp::
-	Like --get-all, but interprets the name as a regular expression and
+	Like `--get-all`, but interprets the name as a regular expression and
 	writes out the key names.  Regular expression matching is currently
 	case-sensitive and done against a canonicalized version of the key
 	in which section and variable names are lowercased, but subsection
@@ -337,8 +337,8 @@ ENVIRONMENT
 
 GIT_CONFIG::
 	Take the configuration from the given file instead of .git/config.
-	Using the "--global" option forces this to ~/.gitconfig. Using the
-	"--system" option forces this to $(prefix)/etc/gitconfig.
+	Using the `--global` option forces this to ~/.gitconfig. Using the
+	`--system` option forces this to $(prefix)/etc/gitconfig.
 
 GIT_CONFIG_NOSYSTEM::
 	Whether to skip reading settings from the system-wide
diff --git a/Documentation/git-count-objects.txt b/Documentation/git-count-objects.txt
index cb9b4d2e46..d12ce08789 100644
--- a/Documentation/git-count-objects.txt
+++ b/Documentation/git-count-objects.txt
@@ -24,11 +24,11 @@ OPTIONS
 +
 count: the number of loose objects
 +
-size: disk space consumed by loose objects, in KiB (unless -H is specified)
+size: disk space consumed by loose objects, in KiB (unless `-H` is specified)
 +
 in-pack: the number of in-pack objects
 +
-size-pack: disk space consumed by the packs, in KiB (unless -H is specified)
+size-pack: disk space consumed by the packs, in KiB (unless `-H` is specified)
 +
 prune-packable: the number of loose objects that are also present in
 the packs. These objects could be pruned using `git prune-packed`.
@@ -36,7 +36,7 @@ the packs. These objects could be pruned using `git prune-packed`.
 garbage: the number of files in object database that are neither valid loose
 objects nor valid packs
 +
-size-garbage: disk space consumed by garbage files, in KiB (unless -H is
+size-garbage: disk space consumed by garbage files, in KiB (unless `-H` is
 specified)
 +
 alternate: absolute path of alternate object databases; may appear
diff --git a/Documentation/git-cvsexportcommit.txt b/Documentation/git-cvsexportcommit.txt
index 00154b6c85..f08ab508af 100644
--- a/Documentation/git-cvsexportcommit.txt
+++ b/Documentation/git-cvsexportcommit.txt
@@ -18,7 +18,7 @@ DESCRIPTION
 Exports a commit from Git to a CVS checkout, making it easier
 to merge patches from a Git repository into a CVS repository.
 
-Specify the name of a CVS checkout using the -w switch or execute it
+Specify the name of a CVS checkout using the `-w` switch or execute it
 from the root of the CVS working copy. In the latter case GIT_DIR must
 be defined. See examples below.
 
@@ -40,7 +40,7 @@ OPTIONS
 
 -p::
 	Be pedantic (paranoid) when applying patches. Invokes patch with
-	--fuzz=0
+	`--fuzz=0`
 
 -a::
 	Add authorship information. Adds Author line, and Committer (if
@@ -48,7 +48,7 @@ OPTIONS
 
 -d::
 	Set an alternative CVSROOT to use.  This corresponds to the CVS
-	-d parameter.  Usually users will not want to set this, except
+	`-d` parameter.  Usually users will not want to set this, except
 	if using CVS in an asymmetric fashion.
 
 -f::
@@ -99,7 +99,7 @@ $ git cvsexportcommit -v <commit-sha1>
 $ cvs commit -F .msg <files>
 ------------
 
-Merge one patch into CVS (-c and -w options). The working directory is within the Git Repo::
+Merge one patch into CVS (`-c` and `-w` options). The working directory is within the Git Repo::
 +
 ------------
 	$ git cvsexportcommit -v -c -w ~/project_cvs_checkout <commit-sha1>
diff --git a/Documentation/git-cvsimport.txt b/Documentation/git-cvsimport.txt
index de1ebed67d..143c726511 100644
--- a/Documentation/git-cvsimport.txt
+++ b/Documentation/git-cvsimport.txt
@@ -38,7 +38,7 @@ created by 'git cvsimport'.  By default initial import will create and populate
 "master" branch from the CVS repository's main branch which you're free
 to work with; after that, you need to 'git merge' incremental imports, or
 any CVS branches, yourself.  It is advisable to specify a named remote via
--r to separate and protect the incoming branches.
+`-r` to separate and protect the incoming branches.
 
 If you intend to set up a shared public repository that all developers can
 read/write, or if you want to use linkgit:git-cvsserver[1], then you
@@ -74,7 +74,7 @@ OPTIONS
 	akin to the way 'git clone' uses 'origin' by default.
 
 -o <branch-for-HEAD>::
-	When no remote is specified (via -r) the `HEAD` branch
+	When no remote is specified (via `-r`) the `HEAD` branch
 	from CVS is imported to the 'origin' branch within the Git
 	repository, as `HEAD` already has a special meaning for Git.
 	When a remote is specified the `HEAD` branch is named
@@ -82,7 +82,7 @@ OPTIONS
 	Use this option if you want to import into a different
 	branch.
 +
-Use '-o master' for continuing an import that was initially done by
+Use `-o master` for continuing an import that was initially done by
 the old cvs2git tool.
 
 -i::
@@ -91,7 +91,7 @@ the old cvs2git tool.
 	not create them if they do not exist.
 
 -k::
-	Kill keywords: will extract files with '-kk' from the CVS archive
+	Kill keywords: will extract files with `-kk` from the CVS archive
 	to avoid noisy changesets. Highly recommended, but off by default
 	to preserve compatibility with early imported trees.
 
@@ -103,7 +103,7 @@ the old cvs2git tool.
 
 -p <options-for-cvsps>::
 	Additional options for cvsps.
-	The options `-u` and '-A' are implicit and should not be used here.
+	The options `-u` and `-A` are implicit and should not be used here.
 +
 If you need to pass multiple options, separate them with a comma.
 
@@ -158,7 +158,7 @@ all along.  If a time zone is specified, GIT_AUTHOR_DATE will
 have the corresponding offset applied.
 +
 For convenience, this data is saved to `$GIT_DIR/cvs-authors`
-each time the '-A' option is provided and read from that same
+each time the `-A` option is provided and read from that same
 file each time 'git cvsimport' is run.
 +
 It is not recommended to use this feature if you intend to
diff --git a/Documentation/git-cvsserver.txt b/Documentation/git-cvsserver.txt
index 1b1c71ad9d..955bae46c9 100644
--- a/Documentation/git-cvsserver.txt
+++ b/Documentation/git-cvsserver.txt
@@ -119,7 +119,7 @@ for example:
 ------
 You can use the 'htpasswd' facility that comes with Apache to make these
 files, but Apache's MD5 crypt method differs from the one used by most C
-library's crypt() function, so don't use the -m option.
+library's crypt() function, so don't use the `-m` option.
 
 Alternatively you can produce the password with perl's crypt() operator:
 -----
@@ -312,7 +312,7 @@ ENVIRONMENT
 These variables obviate the need for command-line options in some
 circumstances, allowing easier restricted usage through git-shell.
 
-GIT_CVSSERVER_BASE_PATH takes the place of the argument to --base-path.
+GIT_CVSSERVER_BASE_PATH takes the place of the argument to `--base-path`.
 
 GIT_CVSSERVER_ROOT specifies a single-directory whitelist. The
 repository must still be configured to allow access through
@@ -361,7 +361,7 @@ All the operations required for normal use are supported, including
 checkout, diff, status, update, log, add, remove, commit.
 
 Most CVS command arguments that read CVS tags or revision numbers
-(typically -r) work, and also support any git refspec
+(typically `-r`) work, and also support any git refspec
 (tag, branch, commit ID, etc).
 However, CVS revision numbers for non-default branches are not well
 emulated, and cvs log does not show tags or branches at
@@ -374,7 +374,7 @@ As described elsewhere on this page, the "module" parameter
 of cvs checkout is interpreted as a branch name, and it becomes
 the main branch.  It remains the main branch for a given sandbox
 even if you temporarily make another branch sticky with
-cvs update -r.  Alternatively, the -r argument can indicate
+cvs update -r.  Alternatively, the `-r` argument can indicate
 some other branch to actually checkout, even though the module
 is still the "main" branch.  Tradeoffs (as currently
 implemented): Each new "module" creates a new database on disk with
@@ -385,7 +385,7 @@ many operations, like cvs update.
 
 If you want to refer to a git refspec that has characters that are
 not allowed by CVS, you have two options.  First, it may just work
-to supply the git refspec directly to the appropriate CVS -r argument;
+to supply the git refspec directly to the appropriate CVS `-r` argument;
 some CVS clients don't seem to do much sanity checking of the argument.
 Second, if that fails, you can use a special character escape mechanism
 that only uses characters that are valid in CVS tags.  A sequence
@@ -415,7 +415,7 @@ Alternatively, if `gitcvs.usecrlfattr` config is not enabled
 or the attributes do not allow automatic detection for a filename, then
 the server uses the `gitcvs.allBinary` config for the default setting.
 If `gitcvs.allBinary` is set, then file not otherwise
-specified will default to '-kb' mode. Otherwise the `-k` mode
+specified will default to `-kb` mode. Otherwise the `-k` mode
 is left blank. But if `gitcvs.allBinary` is set to "guess", then
 the correct `-k` mode will be guessed based on the contents of
 the file.
diff --git a/Documentation/git-daemon.txt b/Documentation/git-daemon.txt
index fdc28c041c..2794a2d0c1 100644
--- a/Documentation/git-daemon.txt
+++ b/Documentation/git-daemon.txt
@@ -55,14 +55,14 @@ OPTIONS
 --base-path=<path>::
 	Remap all the path requests as relative to the given path.
 	This is sort of "Git root" - if you run 'git daemon' with
-	'--base-path=/srv/git' on example.com, then if you later try to pull
+	`--base-path=/srv/git` on example.com, then if you later try to pull
 	'git://example.com/hello.git', 'git daemon' will interpret the path
 	as `/srv/git/hello.git`.
 
 --base-path-relaxed::
-	If --base-path is enabled and repo lookup fails, with this option
+	If `--base-path` is enabled and repo lookup fails, with this option
 	'git daemon' will attempt to lookup without prefixing the base path.
-	This is useful for switching to --base-path usage, while still
+	This is useful for switching to `--base-path` usage, while still
 	allowing the old paths.
 
 --interpolated-path=<pathtemplate>::
@@ -81,16 +81,16 @@ OPTIONS
 	do not have the 'git-daemon-export-ok' file.
 
 --inetd::
-	Have the server run as an inetd service. Implies --syslog (may be
+	Have the server run as an inetd service. Implies `--syslog` (may be
 	overridden with `--log-destination=`).
-	Incompatible with --detach, --port, --listen, --user and --group
+	Incompatible with `--detach`, `--port`, `--listen`, `--user` and `--group`
 	options.
 
 --listen=<host_or_ipaddr>::
 	Listen on a specific IP address or hostname.  IP addresses can
 	be either an IPv4 address or an IPv6 address if supported.  If IPv6
-	is not supported, then --listen=hostname is also not supported and
-	--listen must be given an IPv4 address.
+	is not supported, then `--listen=hostname` is also not supported and
+	`--listen` must be given an IPv4 address.
 	Can be given more than once.
 	Incompatible with `--inetd` option.
 
@@ -116,7 +116,7 @@ OPTIONS
 
 --log-destination=<destination>::
 	Send log messages to the specified destination.
-	Note that this option does not imply --verbose,
+	Note that this option does not imply `--verbose`,
 	thus by default only error conditions will be logged.
 	The <destination> must be one of:
 +
@@ -154,7 +154,7 @@ otherwise `stderr`.
 	old connections to time out.
 
 --detach::
-	Detach from the shell. Implies --syslog.
+	Detach from the shell. Implies `--syslog`.
 
 --pid-file=<file>::
 	Save the process id in 'file'.  Ignored when the daemon
@@ -200,7 +200,7 @@ Git configuration files in that directory are readable by `<user>`.
 	is more convenient for clients, but may leak information about
 	the existence of unexported repositories.  When informative
 	errors are not enabled, all errors report "access denied" to the
-	client. The default is --no-informative-errors.
+	client. The default is `--no-informative-errors`.
 
 --access-hook=<path>::
 	Every time a client connects, first run an external command
@@ -219,7 +219,7 @@ it declines the service.
 
 <directory>::
 	A directory to add to the whitelist of allowed directories. Unless
-	--strict-paths is specified this will also include subdirectories
+	`--strict-paths` is specified this will also include subdirectories
 	of each named directory.
 
 SERVICES
diff --git a/Documentation/git-describe.txt b/Documentation/git-describe.txt
index a88f6ae2c6..a3f015743b 100644
--- a/Documentation/git-describe.txt
+++ b/Documentation/git-describe.txt
@@ -22,9 +22,9 @@ abbreviated object name of the most recent commit. The result
 is a "human-readable" object name which can also be used to
 identify the commit to other git commands.
 
-By default (without --all or --tags) `git describe` only shows
+By default (without `--all` or `--tags`) `git describe` only shows
 annotated tags.  For more information about creating annotated tags
-see the -a and -s options to linkgit:git-tag[1].
+see the `-a` and `-s` options to linkgit:git-tag[1].
 
 If the given object refers to a blob, it will be described
 as `<commit-ish>:<path>`, such that the blob can be found
@@ -60,7 +60,7 @@ OPTIONS
 --contains::
 	Instead of finding the tag that predates the commit, find
 	the tag that comes after the commit, and thus contains it.
-	Automatically implies --tags.
+	Automatically implies `--tags`.
 
 --abbrev=<n>::
 	Instead of using the default 7 hexadecimal digits as the
@@ -77,7 +77,7 @@ OPTIONS
 
 --exact-match::
 	Only output exact matches (a tag directly references the
-	supplied commit).  This is a synonym for --candidates=0.
+	supplied commit).  This is a synonym for `--candidates=0`.
 
 --debug::
 	Verbosely display information about the searching strategy
@@ -110,9 +110,9 @@ OPTIONS
 	excluding respectively "refs/heads/" and "refs/remotes/" prefix;
 	references of other types are never considered. If given multiple times,
 	a list of patterns will be accumulated and tags matching any of the
-	patterns will be excluded. When combined with --match a tag will be
-	considered when it matches at least one --match pattern and does not
-	match any of the --exclude patterns. Use `--no-exclude` to clear and
+	patterns will be excluded. When combined with `--match` a tag will be
+	considered when it matches at least one `--match` pattern and does not
+	match any of the `--exclude` patterns. Use `--no-exclude` to clear and
 	reset the list of patterns.
 
 --always::
@@ -150,7 +150,7 @@ Doing a 'git describe' on a tag-name will just show the tag name:
 	[torvalds@g5 git]$ git describe v1.0.4
 	v1.0.4
 
-With --all, the command can use branch heads as references, so
+With `--all`, the command can use branch heads as references, so
 the output shows the reference path as well:
 
 	[torvalds@g5 git]$ git describe --all --abbrev=4 v1.0.5^2
@@ -159,7 +159,7 @@ the output shows the reference path as well:
 	[torvalds@g5 git]$ git describe --all --abbrev=4 HEAD^
 	heads/lt/describe-7-g975b
 
-With --abbrev set to 0, the command can be used to find the
+With `--abbrev` set to 0, the command can be used to find the
 closest tagname without any suffix:
 
 	[torvalds@g5 git]$ git describe --abbrev=0 v1.0.5^2
diff --git a/Documentation/git-diff-tree.txt b/Documentation/git-diff-tree.txt
index 2fc24c542f..b9225cd824 100644
--- a/Documentation/git-diff-tree.txt
+++ b/Documentation/git-diff-tree.txt
@@ -18,7 +18,7 @@ DESCRIPTION
 Compares the content and mode of the blobs found via two tree objects.
 
 If there is only one <tree-ish> given, the commit is compared with its parents
-(see --stdin below).
+(see `--stdin` below).
 
 Note that 'git diff-tree' can use the tree encapsulated in a commit object.
 
@@ -37,7 +37,7 @@ include::diff-options.txt[]
         recurse into sub-trees
 
 -t::
-	show tree entry itself as well as subtrees.  Implies -r.
+	show tree entry itself as well as subtrees.  Implies `-r`.
 
 --root::
 	When `--root` is specified the initial commit will be shown as a big
@@ -113,7 +113,7 @@ include::pretty-options.txt[]
 --combined-all-paths::
 	This flag causes combined diffs (used for merge commits) to
 	list the name of the file from all parents.  It thus only has
-	effect when -c or --cc are specified, and is likely only
+	effect when `-c` or `--cc` are specified, and is likely only
 	useful if filename changes are detected (i.e. when either
 	rename or copy detection have been requested).
 
diff --git a/Documentation/git-diff.txt b/Documentation/git-diff.txt
index 7f4c8a8ce7..9f4b46c910 100644
--- a/Documentation/git-diff.txt
+++ b/Documentation/git-diff.txt
@@ -48,9 +48,9 @@ files on disk.
 	do not give <commit>, it defaults to HEAD.
 	If HEAD does not exist (e.g. unborn branches) and
 	<commit> is not given, it shows all staged changes.
-	--staged is a synonym of --cached.
+	`--staged` is a synonym of `--cached`.
 +
-If --merge-base is given, instead of using <commit>, use the merge base
+If `--merge-base` is given, instead of using <commit>, use the merge base
 of <commit> and HEAD.  `git diff --merge-base A` is equivalent to
 `git diff $(git merge-base A HEAD)`.
 
@@ -67,7 +67,7 @@ of <commit> and HEAD.  `git diff --merge-base A` is equivalent to
 	This is to view the changes between two arbitrary
 	<commit>.
 +
-If --merge-base is given, use the merge base of the two commits for the
+If `--merge-base` is given, use the merge base of the two commits for the
 "before" side.  `git diff --merge-base A B` is equivalent to
 `git diff $(git merge-base A B) B`.
 
diff --git a/Documentation/git-fast-export.txt b/Documentation/git-fast-export.txt
index 1978dbdc6a..a1c02918f9 100644
--- a/Documentation/git-fast-export.txt
+++ b/Documentation/git-fast-export.txt
@@ -67,14 +67,14 @@ produced incorrect results if you gave these options.
 	have been completed, or to save the marks table across
 	incremental runs.  As <file> is only opened and truncated
 	at completion, the same path can also be safely given to
-	--import-marks.
+	`--import-marks`.
 	The file will not be written if no new object has been
 	marked/exported.
 
 --import-marks=<file>::
 	Before processing any input, load the marks specified in
 	<file>.  The input file must exist, must be readable, and
-	must use the same format as produced by --export-marks.
+	must use the same format as produced by `--export-marks`.
 
 --mark-tags::
 	In addition to labelling blobs and commits with mark ids, also
@@ -86,7 +86,7 @@ produced incorrect results if you gave these options.
 	identifiers.
 +
 Any commits (or tags) that have already been marked will not be
-exported again.  If the backend uses a similar --import-marks file,
+exported again.  If the backend uses a similar `--import-marks` file,
 this allows for incremental bidirectional exporting of the repository
 by keeping the marks the same across runs.
 
@@ -130,7 +130,7 @@ by keeping the marks the same across runs.
 	and will make master{tilde}4 no longer have master{tilde}5 as
 	a parent (though both the old master{tilde}4 and new
 	master{tilde}4 will have all the same files).  Use
-	--reference-excluded-parents to instead have the stream
+	`--reference-excluded-parents` to instead have the stream
 	refer to commits in the excluded range of history by their
 	sha1sum.  Note that the resulting stream can only be used by a
 	repository which already contains the necessary parent
@@ -160,7 +160,7 @@ by keeping the marks the same across runs.
 	to export.  For example, `master~10..master` causes the
 	current master reference to be exported along with all objects
 	added since its 10th ancestor commit and (unless the
-	--reference-excluded-parents option is specified) all files
+	`--reference-excluded-parents` option is specified) all files
 	common to master{tilde}9 and master{tilde}10.
 
 EXAMPLES
diff --git a/Documentation/git-fast-import.txt b/Documentation/git-fast-import.txt
index 39cfa05b28..ff67238633 100644
--- a/Documentation/git-fast-import.txt
+++ b/Documentation/git-fast-import.txt
@@ -40,7 +40,7 @@ OPTIONS
 	not contain the old commit).
 
 --quiet::
-	Disable the output shown by --stats, making fast-import usually
+	Disable the output shown by `--stats`, making fast-import usually
 	be silent when it is successful.  However, if the import stream
 	has directives intended to show user output (e.g. `progress`
 	directives), the corresponding messages will still be shown.
@@ -49,7 +49,7 @@ OPTIONS
 	Display some basic statistics about the objects fast-import has
 	created, the packfiles they were stored into, and the
 	memory used by fast-import during this run.  Showing this output
-	is currently the default, but can be disabled with --quiet.
+	is currently the default, but can be disabled with `--quiet`.
 
 --allow-unsafe-features::
 	Many command-line options can be provided as part of the
@@ -97,23 +97,23 @@ Locations of Marks Files
 	have been completed, or to save the marks table across
 	incremental runs.  As <file> is only opened and truncated
 	at checkpoint (or completion) the same path can also be
-	safely given to --import-marks.
+	safely given to `--import-marks`.
 
 --import-marks=<file>::
 	Before processing any input, load the marks specified in
 	<file>.  The input file must exist, must be readable, and
-	must use the same format as produced by --export-marks.
+	must use the same format as produced by `--export-marks`.
 	Multiple options may be supplied to import more than one
 	set of marks.  If a mark is defined to different values,
 	the last file wins.
 
 --import-marks-if-exists=<file>::
-	Like --import-marks but instead of erroring out, silently
+	Like `--import-marks` but instead of erroring out, silently
 	skips the file if it does not exist.
 
 --[no-]relative-marks::
-	After specifying --relative-marks the paths specified
-	with --import-marks= and --export-marks= are relative
+	After specifying `--relative-marks` the paths specified
+	with `--import-marks`= and `--export-marks`= are relative
 	to an internal directory in the current repository.
 	In git-fast-import this means that the paths are relative
 	to the .git/info/fast-import directory. However, other
@@ -217,8 +217,8 @@ fast-forward update, fast-import will skip updating that ref and instead
 prints a warning message.  fast-import will always attempt to update all
 branch refs, and does not stop on the first failure.
 
-Branch updates can be forced with --force, but it's recommended that
-this only be used on an otherwise quiet repository.  Using --force
+Branch updates can be forced with `--force`, but it's recommended that
+this only be used on an otherwise quiet repository.  Using `--force`
 is not necessary for an initial import into an empty repository.
 
 
@@ -269,11 +269,11 @@ Date Formats
 ~~~~~~~~~~~~
 The following date formats are supported.  A frontend should select
 the format it will use for this import by passing the format name
-in the --date-format=<fmt> command-line option.
+in the `--date-format`=<fmt> command-line option.
 
 `raw`::
 	This is the Git native format and is `<time> SP <offutc>`.
-	It is also fast-import's default format, if --date-format was
+	It is also fast-import's default format, if `--date-format` was
 	not specified.
 +
 The time of the event is specified by `<time>` as the number of
@@ -381,7 +381,7 @@ and control the current import process.  More detailed discussion
 
 `alias`::
 	Record that a mark refers to a given object without first
-	creating any new object.  Using --import-marks and referring
+	creating any new object.  Using `--import-marks` and referring
 	to missing marks will cause fast-import to fail, so aliases
 	can provide a way to set otherwise pruned commits to a valid
 	value (e.g. the nearest non-pruned ancestor).
@@ -501,7 +501,7 @@ the email address from the other fields in the line.  Note that
 of bytes, except `LT`, `GT` and `LF`.  `<name>` is typically UTF-8 encoded.
 
 The time of the change is specified by `<when>` using the date format
-that was selected by the --date-format=<fmt> command-line option.
+that was selected by the `--date-format`=<fmt> command-line option.
 See ``Date Formats'' above for the set of supported formats, and
 their syntax.
 
@@ -989,7 +989,7 @@ save out all current branch refs, tags and marks.
 ....
 
 Note that fast-import automatically switches packfiles when the current
-packfile reaches --max-pack-size, or 4 GiB, whichever limit is
+packfile reaches `--max-pack-size`, or 4 GiB, whichever limit is
 smaller.  During an automatic packfile switch fast-import does not update
 the branch refs, tags or marks.
 
@@ -1152,10 +1152,10 @@ force::
 
 import-marks::
 import-marks-if-exists::
-	Like --import-marks except in two respects: first, only one
+	Like `--import-marks` except in two respects: first, only one
 	"feature import-marks" or "feature import-marks-if-exists"
-	command is allowed per stream; second, an --import-marks=
-	or --import-marks-if-exists command-line option overrides
+	command is allowed per stream; second, an `--import-marks=`
+	or `--import-marks-if-exists` command-line option overrides
 	any of these "feature" commands in the stream; third,
 	"feature import-marks-if-exists" like a corresponding
 	command-line option silently skips a nonexistent file.
@@ -1346,7 +1346,7 @@ users of fast-import, and are offered here as suggestions.
 Use One Mark Per Commit
 ~~~~~~~~~~~~~~~~~~~~~~~
 When doing a repository conversion, use a unique mark per commit
-(`mark :<n>`) and supply the --export-marks option on the command
+(`mark :<n>`) and supply the `--export-marks` option on the command
 line.  fast-import will dump a file which lists every mark and the Git
 object SHA-1 that corresponds to it.  If the frontend can tie
 the marks back to the source repository, it is easy to verify the
@@ -1411,7 +1411,7 @@ even for considerably large projects (100,000+ commits).
 
 However repacking the repository is necessary to improve data
 locality and access performance.  It can also take hours on extremely
-large projects (especially if -f and a large --window parameter is
+large projects (especially if `-f` and a large `--window` parameter is
 used).  Since repacking is safe to run alongside readers and writers,
 run the repack in the background and let it finish when it finishes.
 There is no reason to wait to explore your new Git project!
@@ -1425,7 +1425,7 @@ Repacking Historical Data
 ~~~~~~~~~~~~~~~~~~~~~~~~~
 If you are repacking very old imported data (e.g. older than the
 last year), consider expending some extra CPU time and supplying
---window=50 (or higher) when you run 'git repack'.
+`--window=50` (or higher) when you run 'git repack'.
 This will take longer, but will also produce a smaller packfile.
 You only need to expend the effort once, and everyone using your
 project will benefit from the smaller repository.
@@ -1534,7 +1534,7 @@ branch, their in-memory storage size can grow to a considerable size
 fast-import automatically moves active branches to inactive status based on
 a simple least-recently-used algorithm.  The LRU chain is updated on
 each `commit` command.  The maximum number of active branches can be
-increased or decreased on the command line with --active-branches=.
+increased or decreased on the command line with `--active-branches`=.
 
 per active tree
 ~~~~~~~~~~~~~~~
diff --git a/Documentation/git-fetch-pack.txt b/Documentation/git-fetch-pack.txt
index c975884793..88c2b9d426 100644
--- a/Documentation/git-fetch-pack.txt
+++ b/Documentation/git-fetch-pack.txt
@@ -80,7 +80,7 @@ be in a separate packet, and the list must end with a flush packet.
 	the things up in .bash_profile).
 
 --exec=<git-upload-pack>::
-	Same as --upload-pack=<git-upload-pack>.
+	Same as `--upload-pack`=<git-upload-pack>.
 
 --depth=<n>::
 	Limit fetching to ancestor-chains not longer than n.
@@ -97,7 +97,7 @@ be in a separate packet, and the list must end with a flush packet.
 	This option can be specified multiple times.
 
 --deepen-relative::
-	Argument --depth specifies the number of commits from the
+	Argument `--depth` specifies the number of commits from the
 	current shallow boundary instead of from the tip of each
 	remote branch history.
 
diff --git a/Documentation/git-fetch.txt b/Documentation/git-fetch.txt
index 9067c2079e..85b073a61a 100644
--- a/Documentation/git-fetch.txt
+++ b/Documentation/git-fetch.txt
@@ -25,7 +25,7 @@ of <refspec> below for ways to control this behavior).
 By default, any tag that points into the histories being fetched is
 also fetched; the effect is to fetch tags that
 point at branches that you are interested in.  This default behavior
-can be changed by using the --tags or --no-tags options or by
+can be changed by using the `--tags` or `--no-tags` options or by
 configuring remote.<name>.tagOpt.  By using a refspec that fetches tags
 explicitly, you can fetch tags that do not point into branches you
 are interested in as well.
@@ -204,7 +204,7 @@ representing the status of a single ref. Each line is of the form:
  <flag> <summary> <from> -> <to> [<reason>]
 -------------------------------
 
-The status of up-to-date refs is shown only if the --verbose option is
+The status of up-to-date refs is shown only if the `--verbose` option is
 used.
 
 In compact output mode, specified with configuration variable
@@ -287,7 +287,7 @@ include::transfer-data-leaks.txt[]
 
 BUGS
 ----
-Using --recurse-submodules can only fetch new commits in already checked
+Using `--recurse-submodules` can only fetch new commits in already checked
 out submodules right now. When e.g. upstream added a new submodule in the
 just fetched commits of the superproject the submodule itself cannot be
 fetched, making it impossible to check out that submodule later without
diff --git a/Documentation/git-filter-branch.txt b/Documentation/git-filter-branch.txt
index 62e482a95e..2de3511459 100644
--- a/Documentation/git-filter-branch.txt
+++ b/Documentation/git-filter-branch.txt
@@ -133,8 +133,8 @@ OPTIONS
 	It will receive the parent string on stdin and shall output
 	the new parent string on stdout.  The parent string is in
 	the format described in linkgit:git-commit-tree[1]: empty for
-	the initial commit, "-p parent" for a normal commit and
-	"-p parent1 -p parent2 -p parent3 ..." for a merge commit.
+	the initial commit, `-p parent` for a normal commit and
+	`-p parent1 -p parent2 -p parent3 ...` for a merge commit.
 
 --msg-filter <command>::
 	This is the filter for rewriting the commit messages.
@@ -170,7 +170,7 @@ and that makes no change to the tree.
 	tag name is expected on standard output.
 +
 The original tags are not deleted, but can be overwritten;
-use "--tag-name-filter cat" to simply update the tags.  In this
+use `--tag-name-filter cat` to simply update the tags.  In this
 case, be very careful and make sure you have the old tags
 backed up in case the conversion has run afoul.
 +
@@ -598,12 +598,12 @@ with:
   sensitive files and others which don't.  This comes about in
   multiple different ways:
 
-  ** the default to only doing a partial history rewrite ('--all' is not
+  ** the default to only doing a partial history rewrite (`--all` is not
      the default and few examples show it)
 
   ** the fact that there's no automatic post-run cleanup
 
-  ** the fact that --tag-name-filter (when used to rename tags) doesn't
+  ** the fact that `--tag-name-filter` (when used to rename tags) doesn't
      remove the old tags but just adds new ones with the new name
 
   ** the fact that little educational information is provided to inform
@@ -623,15 +623,15 @@ with:
      git-filter-branch command.  (The backup in refs/original/ is not a
      real backup; it dereferences tags first.)
 
-  ** Running git-filter-branch with either --tags or --all in your
+  ** Running git-filter-branch with either `--tags` or `--all` in your
      <rev-list options>.  In order to retain annotated tags as
-     annotated, you must use --tag-name-filter (and must not have
+     annotated, you must use `--tag-name-filter` (and must not have
      restored from refs/original/ in a previously botched rewrite).
 
 * Any commit messages that specify an encoding will become corrupted
   by the rewrite; git-filter-branch ignores the encoding, takes the
   original bytes, and feeds it to commit-tree without telling it the
-  proper encoding.  (This happens whether or not --msg-filter is
+  proper encoding.  (This happens whether or not `--msg-filter` is
   used.)
 
 * Commit messages (even if they are all UTF-8) by default become
@@ -650,21 +650,21 @@ with:
   dependencies (node_modules or similar) which couldn't have ever been
   functional since it's missing some files.)
 
-* If --prune-empty isn't specified, then the filtering process can
+* If `--prune-empty` isn't specified, then the filtering process can
   create hoards of confusing empty commits
 
-* If --prune-empty is specified, then intentionally placed empty
+* If `--prune-empty` is specified, then intentionally placed empty
   commits from before the filtering operation are also pruned instead
   of just pruning commits that became empty due to filtering rules.
 
-* If --prune-empty is specified, sometimes empty commits are missed
+* If `--prune-empty` is specified, sometimes empty commits are missed
   and left around anyway (a somewhat rare bug, but it happens...)
 
 * A minor issue, but users who have a goal to update all names and
-  emails in a repository may be led to --env-filter which will only
+  emails in a repository may be led to `--env-filter` which will only
   update authors and committers, missing taggers.
 
-* If the user provides a --tag-name-filter that maps multiple tags to
+* If the user provides a `--tag-name-filter` that maps multiple tags to
   the same name, no warning or error is provided; git-filter-branch
   simply overwrites each tag in some undocumented pre-defined order
   resulting in only one tag at the end.  (A git-filter-branch
diff --git a/Documentation/git-fmt-merge-msg.txt b/Documentation/git-fmt-merge-msg.txt
index 6793d8fc05..9004861eae 100644
--- a/Documentation/git-fmt-merge-msg.txt
+++ b/Documentation/git-fmt-merge-msg.txt
@@ -36,7 +36,7 @@ OPTIONS
 	merged.
 
 --[no-]summary::
-	Synonyms to --log and --no-log; these are deprecated and will be
+	Synonyms to `--log` and `--no-log`; these are deprecated and will be
 	removed in the future.
 
 -m <message>::
diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
index 2ae2478de7..e035edf11d 100644
--- a/Documentation/git-for-each-ref.txt
+++ b/Documentation/git-for-each-ref.txt
@@ -40,7 +40,7 @@ OPTIONS
 --sort=<key>::
 	A field name to sort on.  Prefix `-` to sort in
 	descending order of the value.  When unspecified,
-	`refname` is used.  You may use the --sort=<key> option
+	`refname` is used.  You may use the `--sort=<key>` option
 	multiple times, in which case the last key becomes the primary
 	key.
 
@@ -309,7 +309,7 @@ Ref: %(*refname)
 
 
 A simple example showing the use of shell eval on the output,
-demonstrating the use of --shell.  List the prefixes of all heads:
+demonstrating the use of `--shell`.  List the prefixes of all heads:
 ------------
 #!/bin/sh
 
diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
index 911da181a1..ca500ba72c 100644
--- a/Documentation/git-format-patch.txt
+++ b/Documentation/git-format-patch.txt
@@ -238,8 +238,8 @@ populated with placeholder text.
 	`--subject-prefix` option) has ` v<n>` appended to it.  E.g.
 	`--reroll-count=4` may produce `v4-0001-add-makefile.patch`
 	file that has "Subject: [PATCH v4 1/20] Add makefile" in it.
-	`<n>` does not have to be an integer (e.g. "--reroll-count=4.4",
-	or "--reroll-count=4rev2" are allowed), but the downside of
+	`<n>` does not have to be an integer (e.g. `--reroll-count=4.4`,
+	or `--reroll-count=4rev2` are allowed), but the downside of
 	using such a reroll-count is that the range-diff/interdiff
 	with the previous version does not state exactly which
 	version the new interation is compared against.
@@ -346,7 +346,7 @@ set.
 	number.
 
 --signature-file=<file>::
-	Works just like --signature except the signature is read from a file.
+	Works just like `--signature` except the signature is read from a file.
 
 --suffix=.<sfx>::
 	Instead of using `.patch` as the suffix for generated
diff --git a/Documentation/git-fsck.txt b/Documentation/git-fsck.txt
index bd596619c0..e932c75181 100644
--- a/Documentation/git-fsck.txt
+++ b/Documentation/git-fsck.txt
@@ -25,7 +25,7 @@ OPTIONS
 +
 If no objects are given, 'git fsck' defaults to using the
 index file, all SHA-1 references in `refs` namespace, and all reflogs
-(unless --no-reflogs is given) as heads.
+(unless `--no-reflogs` is given) as heads.
 
 --unreachable::
 	Print out objects that exist but that aren't reachable from any
@@ -59,7 +59,7 @@ index file, all SHA-1 references in `refs` namespace, and all reflogs
 	and in packed Git archives found in $GIT_DIR/objects/pack
 	and corresponding pack subdirectories in alternate
 	object pools.  This is now default; you can turn it off
-	with --no-full.
+	with `--no-full`.
 
 --connectivity-only::
 	Check only the connectivity of reachable objects, making sure
@@ -100,7 +100,7 @@ care about this output and want to speed it up further.
 --[no-]progress::
 	Progress status is reported on the standard error stream by
 	default when it is attached to a terminal, unless
-	--no-progress or --verbose is specified. --progress forces
+	`--no-progress` or `--verbose` is specified. `--progress` forces
 	progress status even if the standard error stream is not
 	directed to a terminal.
 
diff --git a/Documentation/git-gc.txt b/Documentation/git-gc.txt
index 853967dea0..9d27c3a41e 100644
--- a/Documentation/git-gc.txt
+++ b/Documentation/git-gc.txt
@@ -57,9 +57,9 @@ be performed as well.
 --prune=<date>::
 	Prune loose objects older than date (default is 2 weeks ago,
 	overridable by the config variable `gc.pruneExpire`).
-	--prune=now prunes loose objects regardless of their age and
+	`--prune=now` prunes loose objects regardless of their age and
 	increases the risk of corruption if another process is writing to
-	the repository concurrently; see "NOTES" below. --prune is on by
+	the repository concurrently; see "NOTES" below. `--prune` is on by
 	default.
 
 --no-prune::
diff --git a/Documentation/git-grep.txt b/Documentation/git-grep.txt
index 4e0ba8234a..84102cc596 100644
--- a/Documentation/git-grep.txt
+++ b/Documentation/git-grep.txt
@@ -66,7 +66,7 @@ grep.fullName::
 	If set to true, enable `--full-name` option by default.
 
 grep.fallbackToNoIndex::
-	If set to true, fall back to git grep --no-index if git grep
+	If set to true, fall back to git grep `--no-index` if git grep
 	is executed outside of a git repository.  Defaults to false.
 
 
@@ -123,7 +123,7 @@ OPTIONS
 	levels of directories. A value of -1 means no limit.
 	This option is ignored if <pathspec> contains active wildcards.
 	In other words if "a*" matches a directory named "a*",
-	"*" is matched literally so --max-depth is still effective.
+	"*" is matched literally so `--max-depth` is still effective.
 
 -r::
 --recursive::
diff --git a/Documentation/git-help.txt b/Documentation/git-help.txt
index 44fe8860b3..a19f275f60 100644
--- a/Documentation/git-help.txt
+++ b/Documentation/git-help.txt
@@ -98,16 +98,16 @@ variable will be checked. The following values are supported for this
 variable; they make 'git help' behave as their corresponding command-
 line option:
 
-* "man" corresponds to '-m|--man',
-* "info" corresponds to '-i|--info',
-* "web" or "html" correspond to '-w|--web'.
+* "man" corresponds to `-m`|`--man`,
+* "info" corresponds to `-i`|`--info`,
+* "web" or "html" correspond to `-w`|`--web`.
 
 help.browser, web.browser and browser.<tool>.path
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
 The `help.browser`, `web.browser` and `browser.<tool>.path` will also
 be checked if the 'web' format is chosen (either by command-line
-option or configuration variable). See '-w|--web' in the OPTIONS
+option or configuration variable). See `-w`|`--web` in the OPTIONS
 section above and linkgit:git-web{litdd}browse[1].
 
 man.viewer
diff --git a/Documentation/git-http-fetch.txt b/Documentation/git-http-fetch.txt
index 9fa17b60e4..969e553e4a 100644
--- a/Documentation/git-http-fetch.txt
+++ b/Documentation/git-http-fetch.txt
@@ -47,7 +47,7 @@ commit-id::
 	URL and uses index-pack to generate corresponding .idx and .keep files.
 	The hash is used to determine the name of the temporary file and is
 	arbitrary. The output of index-pack is printed to stdout. Requires
-	--index-pack-args.
+	`--index-pack-args`.
 
 --index-pack-args=<args>::
 	For internal use only. The command to run on the contents of the
diff --git a/Documentation/git-http-push.txt b/Documentation/git-http-push.txt
index ea03a4eeb0..5dd4d2b63a 100644
--- a/Documentation/git-http-push.txt
+++ b/Documentation/git-http-push.txt
@@ -44,7 +44,7 @@ OPTIONS
 -d::
 -D::
 	Remove <ref> from remote repository.  The specified branch
-	cannot be the remote HEAD.  If -d is specified the following
+	cannot be the remote HEAD.  If `-d` is specified the following
 	other conditions must also be met:
 
 	- Remote HEAD must resolve to an object that exists locally
diff --git a/Documentation/git-index-pack.txt b/Documentation/git-index-pack.txt
index 7fa74b9e79..bde1cf4a5c 100644
--- a/Documentation/git-index-pack.txt
+++ b/Documentation/git-index-pack.txt
@@ -49,7 +49,7 @@ OPTIONS
 	<pack-file> is not specified, the pack is written to
 	objects/pack/ directory of the current Git repository with
 	a default name determined from the pack content.  If
-	<pack-file> is not specified consider using --keep to
+	<pack-file> is not specified consider using `--keep` to
 	prevent a race condition between this process and
 	'git repack'.
 
@@ -57,18 +57,18 @@ OPTIONS
 	Fix a "thin" pack produced by `git pack-objects --thin` (see
 	linkgit:git-pack-objects[1] for details) by adding the
 	excluded objects the deltified objects are based on to the
-	pack. This option only makes sense in conjunction with --stdin.
+	pack. This option only makes sense in conjunction with `--stdin`.
 
 --keep::
 	Before moving the index into its final destination
 	create an empty .keep file for the associated pack file.
-	This option is usually necessary with --stdin to prevent a
+	This option is usually necessary with `--stdin` to prevent a
 	simultaneous 'git repack' process from deleting
 	the newly constructed pack and index before refs can be
 	updated to use objects contained in the pack.
 
 --keep=<msg>::
-	Like --keep create a .keep file before moving the index into
+	Like `--keep` create a .keep file before moving the index into
 	its final destination, but rather than creating an empty file
 	place '<msg>' followed by an LF into the .keep file.  The '<msg>'
 	message can later be searched for within all .keep files to
@@ -112,7 +112,7 @@ name of the pack/idx file (see "Notes").
 	the current repository (set by `extensions.objectFormat`), or 'sha1' if no
 	value is set or outside a repository.
 +
-This option cannot be used with --stdin.
+This option cannot be used with `--stdin`.
 +
 include::object-format-disclaimer.txt[]
 
@@ -120,7 +120,7 @@ NOTES
 -----
 
 Once the index has been created, the hash that goes into the name of
-the pack/idx file is printed to stdout. If --stdin was
+the pack/idx file is printed to stdout. If `--stdin` was
 also used then this is prefixed by either "pack\t", or "keep\t" if a
 new .keep file was successfully created. This is useful to remove a
 .keep file used as a lock to prevent the race with 'git repack'
diff --git a/Documentation/git-init.txt b/Documentation/git-init.txt
index b611d80697..a3f061517d 100644
--- a/Documentation/git-init.txt
+++ b/Documentation/git-init.txt
@@ -35,7 +35,7 @@ directory is used.
 Running 'git init' in an existing repository is safe. It will not
 overwrite things that are already there. The primary reason for
 rerunning 'git init' is to pick up newly added templates (or to move
-the repository to another place if --separate-git-dir is given).
+the repository to another place if `--separate-git-dir` is given).
 
 OPTIONS
 -------
diff --git a/Documentation/git-interpret-trailers.txt b/Documentation/git-interpret-trailers.txt
index 96ec6499f0..4288e5405c 100644
--- a/Documentation/git-interpret-trailers.txt
+++ b/Documentation/git-interpret-trailers.txt
@@ -87,27 +87,27 @@ OPTIONS
 --where <placement>::
 --no-where::
 	Specify where all new trailers will be added.  A setting
-	provided with '--where' overrides all configuration variables
-	and applies to all '--trailer' options until the next occurrence of
-	'--where' or '--no-where'. Possible values are `after`, `before`,
+	provided with `--where` overrides all configuration variables
+	and applies to all `--trailer` options until the next occurrence of
+	`--where` or `--no-where`. Possible values are `after`, `before`,
 	`end` or `start`.
 
 --if-exists <action>::
 --no-if-exists::
 	Specify what action will be performed when there is already at
 	least one trailer with the same <token> in the message.  A setting
-	provided with '--if-exists' overrides all configuration variables
-	and applies to all '--trailer' options until the next occurrence of
-	'--if-exists' or '--no-if-exists'. Possible actions are `addIfDifferent`,
+	provided with `--if-exists` overrides all configuration variables
+	and applies to all `--trailer` options until the next occurrence of
+	`--if-exists` or `--no-if-exists`. Possible actions are `addIfDifferent`,
 	`addIfDifferentNeighbor`, `add`, `replace` and `doNothing`.
 
 --if-missing <action>::
 --no-if-missing::
 	Specify what action will be performed when there is no other
 	trailer with the same <token> in the message.  A setting
-	provided with '--if-missing' overrides all configuration variables
-	and applies to all '--trailer' options until the next occurrence of
-	'--if-missing' or '--no-if-missing'. Possible actions are `doNothing`
+	provided with `--if-missing` overrides all configuration variables
+	and applies to all `--trailer` options until the next occurrence of
+	`--if-missing` or `--no-if-missing`. Possible actions are `doNothing`
 	or `add`.
 
 --only-trailers::
diff --git a/Documentation/git-ls-files.txt b/Documentation/git-ls-files.txt
index 6d11ab506b..b42f179aef 100644
--- a/Documentation/git-ls-files.txt
+++ b/Documentation/git-ls-files.txt
@@ -65,11 +65,11 @@ OPTIONS
 	name (with a trailing slash) and not its whole contents.
 
 --no-empty-directory::
-	Do not list empty directories. Has no effect without --directory.
+	Do not list empty directories. Has no effect without `--directory`.
 
 -u::
 --unmerged::
-	Show unmerged files in the output (forces --stage)
+	Show unmerged files in the output (forces `--stage`)
 
 -k::
 --killed::
@@ -111,7 +111,7 @@ OPTIONS
 	error (return 1).
 
 --with-tree=<tree-ish>::
-	When using --error-unmatch to expand the user supplied
+	When using `--error-unmatch` to expand the user supplied
 	<file> (i.e. path pattern) arguments to paths, pretend
 	that paths which were removed in the index since the
 	named <tree-ish> are still present.  Using this option
@@ -156,13 +156,13 @@ a space) at the start of each line:
 
 --recurse-submodules::
 	Recursively calls ls-files on each active submodule in the repository.
-	Currently there is only support for the --cached mode.
+	Currently there is only support for the `--cached` mode.
 
 --abbrev[=<n>]::
 	Instead of showing the full 40-byte hexadecimal object
 	lines, show the shortest prefix that is at least '<n>'
 	hexdigits long that uniquely refers the object.
-	Non default number of digits can be specified with --abbrev=<n>.
+	Non default number of digits can be specified with `--abbrev=<n>`.
 
 --debug::
 	After each line that describes a file, add more data about its
@@ -224,29 +224,29 @@ EXCLUDE PATTERNS
 
 'git ls-files' can use a list of "exclude patterns" when
 traversing the directory tree and finding files to show when the
-flags --others or --ignored are specified.  linkgit:gitignore[5]
+flags `--others` or `--ignored` are specified.  linkgit:gitignore[5]
 specifies the format of exclude patterns.
 
 These exclude patterns come from these places, in order:
 
-  1. The command-line flag --exclude=<pattern> specifies a
+  1. The command-line flag `--exclude=<pattern>` specifies a
      single pattern.  Patterns are ordered in the same order
      they appear in the command line.
 
-  2. The command-line flag --exclude-from=<file> specifies a
+  2. The command-line flag `--exclude-from=<file>` specifies a
      file containing a list of patterns.  Patterns are ordered
      in the same order they appear in the file.
 
-  3. The command-line flag --exclude-per-directory=<name> specifies
+  3. The command-line flag `--exclude-per-directory=<name>` specifies
      a name of the file in each directory 'git ls-files'
      examines, normally `.gitignore`.  Files in deeper
      directories take precedence.  Patterns are ordered in the
      same order they appear in the files.
 
-A pattern specified on the command line with --exclude or read
-from the file specified with --exclude-from is relative to the
+A pattern specified on the command line with `--exclude` or read
+from the file specified with `--exclude-from` is relative to the
 top of the directory tree.  A pattern read from a file specified
-by --exclude-per-directory is relative to the directory that the
+by `--exclude-per-directory` is relative to the directory that the
 pattern file appears in.
 
 SEE ALSO
diff --git a/Documentation/git-ls-remote.txt b/Documentation/git-ls-remote.txt
index 492e573856..4cb4e2fd5d 100644
--- a/Documentation/git-ls-remote.txt
+++ b/Documentation/git-ls-remote.txt
@@ -87,7 +87,7 @@ OPTIONS
 
 <refs>...::
 	When unspecified, all references, after filtering done
-	with --heads and --tags, are shown.  When <refs>... are
+	with `--heads` and `--tags`, are shown.  When <refs>... are
 	specified, only references matching the given patterns
 	are displayed.
 
diff --git a/Documentation/git-ls-tree.txt b/Documentation/git-ls-tree.txt
index db02d6d79a..6ed9030c1e 100644
--- a/Documentation/git-ls-tree.txt
+++ b/Documentation/git-ls-tree.txt
@@ -31,7 +31,7 @@ in the current working directory.  Note that:
    root level (e.g. `git ls-tree -r HEAD:sub dir`) in this case, as that
    would result in asking for `sub/sub/dir` in the `HEAD` commit.
    However, the current working directory can be ignored by passing
-   --full-tree option.
+   `--full-tree` option.
 
 OPTIONS
 -------
@@ -64,7 +64,7 @@ OPTIONS
 	Instead of showing the full 40-byte hexadecimal object
 	lines, show the shortest prefix that is at least '<n>'
 	hexdigits long that uniquely refers the object.
-	Non default number of digits can be specified with --abbrev=<n>.
+	Non default number of digits can be specified with `--abbrev`=<n>.
 
 --full-name::
 	Instead of showing the path names relative to the current working
@@ -72,7 +72,7 @@ OPTIONS
 
 --full-tree::
 	Do not limit the listing to the current working directory.
-	Implies --full-name.
+	Implies `--full-name`.
 
 [<path>...]::
 	When paths are given, show them (note that this isn't really raw
diff --git a/Documentation/git-mailinfo.txt b/Documentation/git-mailinfo.txt
index d343f040f5..5bc2982909 100644
--- a/Documentation/git-mailinfo.txt
+++ b/Documentation/git-mailinfo.txt
@@ -45,7 +45,7 @@ Finally, runs of whitespace are normalized to a single ASCII space
 character.
 
 -b::
-	When -k is not in effect, all leading strings bracketed with '['
+	When `-k` is not in effect, all leading strings bracketed with '['
 	and ']' pairs are stripped.  This option limits the stripping to
 	only the pairs whose bracketed string contains the word "PATCH".
 
@@ -60,7 +60,7 @@ Note that the patch is always used as-is without charset
 conversion, even with this flag.
 
 --encoding=<encoding>::
-	Similar to -u.  But when re-coding, the charset specified here is
+	Similar to `-u`.  But when re-coding, the charset specified here is
 	used instead of the one specified by `i18n.commitEncoding` or UTF-8.
 
 -n::
diff --git a/Documentation/git-mailsplit.txt b/Documentation/git-mailsplit.txt
index e3b2a88c4b..6e357716ec 100644
--- a/Documentation/git-mailsplit.txt
+++ b/Documentation/git-mailsplit.txt
@@ -42,7 +42,7 @@ OPTIONS
 	filenames.
 
 -f<nn>::
-	Skip the first <nn> numbers, for example if -f3 is specified,
+	Skip the first <nn> numbers, for example if `-f`3 is specified,
 	start the numbering with 0004.
 
 --keep-cr::
diff --git a/Documentation/git-merge-index.txt b/Documentation/git-merge-index.txt
index 2ab84a91e5..9fdfe6a31b 100644
--- a/Documentation/git-merge-index.txt
+++ b/Documentation/git-merge-index.txt
@@ -37,7 +37,7 @@ OPTIONS
 	failure usually indicates conflicts during the merge). This is for
 	porcelains which might want to emit custom messages.
 
-If 'git merge-index' is called with multiple <file>s (or -a) then it
+If 'git merge-index' is called with multiple <file>s (or `-a`) then it
 processes them in turn only stopping if merge returns a non-zero exit
 code.
 
diff --git a/Documentation/git-mv.txt b/Documentation/git-mv.txt
index 79449bf98f..b3808dcc06 100644
--- a/Documentation/git-mv.txt
+++ b/Documentation/git-mv.txt
@@ -50,7 +50,7 @@ Moving a submodule using a gitfile (which means they were cloned
 with a Git version 1.7.8 or newer) will update the gitfile and
 core.worktree setting to make the submodule work in the new location.
 It also will attempt to update the submodule.<name>.path setting in
-the linkgit:gitmodules[5] file and stage that file (unless -n is used).
+the linkgit:gitmodules[5] file and stage that file (unless `-n` is used).
 
 BUGS
 ----
diff --git a/Documentation/git-name-rev.txt b/Documentation/git-name-rev.txt
index 5cb0eb0855..99979fe55b 100644
--- a/Documentation/git-name-rev.txt
+++ b/Documentation/git-name-rev.txt
@@ -34,9 +34,9 @@ OPTIONS
 	Do not use any ref whose name matches a given shell pattern. The
 	pattern can be one of branch name, tag name or fully qualified ref
 	name. If given multiple times, a ref will be excluded when it matches
-	any of the given patterns. When used together with --refs, a ref will
-	be used as a match only when it matches at least one --refs pattern and
-	does not match any --exclude patterns. Use `--no-exclude` to clear the
+	any of the given patterns. When used together with `--refs`, a ref will
+	be used as a match only when it matches at least one `--refs` pattern and
+	does not match any `--exclude` patterns. Use `--no-exclude` to clear the
 	list of exclude patterns.
 
 --all::
@@ -45,12 +45,12 @@ OPTIONS
 --stdin::
 	Transform stdin by substituting all the 40-character SHA-1
 	hexes (say $hex) with "$hex ($rev_name)".  When used with
-	--name-only, substitute with "$rev_name", omitting $hex
+	`--name-only`, substitute with "$rev_name", omitting $hex
 	altogether.  Intended for the scripter's use.
 
 --name-only::
 	Instead of printing both the SHA-1 and the name, print only
-	the name.  If given with --tags the usual tag prefix of
+	the name.  If given with `--tags` the usual tag prefix of
 	"tags/" is also omitted from the name, matching the output
 	of `git-describe` more closely.
 
diff --git a/Documentation/git-notes.txt b/Documentation/git-notes.txt
index 0a4200674c..b0a5ab9a72 100644
--- a/Documentation/git-notes.txt
+++ b/Documentation/git-notes.txt
@@ -152,7 +152,7 @@ OPTIONS
 
 -c <object>::
 --reedit-message=<object>::
-	Like '-C', but with `-c` the editor is invoked, so that
+	Like `-C`, but with `-c` the editor is invoked, so that
 	the user can further edit the note message.
 
 --allow-empty::
@@ -251,7 +251,7 @@ When done, the user can either finalize the merge with
 'git notes merge --abort'.
 
 Users may select an automated merge strategy from among the following using
-either -s/--strategy option or configuring notes.mergeStrategy accordingly:
+either `-s`/`--strategy` option or configuring notes.mergeStrategy accordingly:
 
 "ours" automatically resolves conflicting notes in favor of the local
 version (i.e. the current notes ref).
diff --git a/Documentation/git-p4.txt b/Documentation/git-p4.txt
index f89e68b424..d9d29a5efa 100644
--- a/Documentation/git-p4.txt
+++ b/Documentation/git-p4.txt
@@ -180,7 +180,7 @@ The git commit is created relative to the current origin revision (HEAD by defau
 A parent commit is created based on the origin, and then the unshelve commit is
 created based on that.
 
-The origin revision can be changed with the "--origin" option.
+The origin revision can be changed with the `--origin` option.
 
 If the target branch in refs/remotes/p4-unshelved already exists, the old one will
 be renamed.
@@ -221,7 +221,7 @@ subsequent 'sync' operations.
 +
 By default a <ref> not starting with refs/ is treated as the
 name of a remote-tracking branch (under refs/remotes/).  This
-behavior can be modified using the --import-local option.
+behavior can be modified using the `--import-local` option.
 +
 The default <ref> is "master".
 +
@@ -265,7 +265,7 @@ Git repository:
 	Import at most 'n' changes, rather than the entire range of
 	changes included in the given revision specifier. A typical
 	usage would be use '@all' as the revision specifier, but then
-	to use '--max-changes 1000' to import only the last 1000
+	to use `--max-changes 1000` to import only the last 1000
 	revisions rather than the entire revision history.
 
 --changes-block-size <n>::
@@ -347,7 +347,7 @@ These options can be used to modify 'git p4 submit' behavior.
 
 --update-shelve CHANGELIST::
 	Update an existing shelved changelist with this commit. Implies
-	--shelve. Repeat for multiple shelved changelists.
+	`--shelve`. Repeat for multiple shelved changelists.
 
 --conflict=(ask|skip|quit)::
 	Conflicts can occur when applying a commit to p4.  When this
@@ -371,7 +371,7 @@ These options can be used to modify 'git p4 submit' behavior.
 
 --disable-p4sync::
     Disable the automatic sync of p4/master from Perforce after commits have
-    been submitted. Implies --disable-rebase. Can also be set with
+    been submitted. Implies `--disable-rebase`. Can also be set with
     git-p4.disableP4Sync. Sync with origin/master still goes ahead if possible.
 
 Hooks for submit
@@ -560,27 +560,27 @@ They all are in the 'git-p4' section.
 General variables
 ~~~~~~~~~~~~~~~~~
 git-p4.user::
-	User specified as an option to all p4 commands, with '-u <user>'.
+	User specified as an option to all p4 commands, with `-u <user>`.
 	The environment variable `P4USER` can be used instead.
 
 git-p4.password::
 	Password specified as an option to all p4 commands, with
-	'-P <password>'.
+	`-P <password>`.
 	The environment variable `P4PASS` can be used instead.
 
 git-p4.port::
 	Port specified as an option to all p4 commands, with
-	'-p <port>'.
+	`-p <port>`.
 	The environment variable `P4PORT` can be used instead.
 
 git-p4.host::
 	Host specified as an option to all p4 commands, with
-	'-h <host>'.
+	`-h <host>`.
 	The environment variable `P4HOST` can be used instead.
 
 git-p4.client::
 	Client specified as an option to all p4 commands, with
-	'-c <client>', including the client spec.
+	`-c <client>`, including the client spec.
 
 git-p4.retries::
 	Specifies the number of times to retry a p4 command (notably,
@@ -619,7 +619,7 @@ git-p4.ignoredP4Labels::
 	unimportable labels are discovered.
 
 git-p4.importLabels::
-	Import p4 labels into git, as per --import-labels.
+	Import p4 labels into git, as per `--import-labels`.
 
 git-p4.labelImportRegexp::
 	Only p4 labels matching this regular expression will be imported. The
@@ -734,7 +734,7 @@ git-p4.attemptRCSCleanup::
 	present.
 
 git-p4.exportLabels::
-	Export Git tags to p4 labels, as per --export-labels.
+	Export Git tags to p4 labels, as per `--export-labels`.
 
 git-p4.labelExportRegexp::
 	Only p4 labels matching this regular expression will be exported. The
@@ -742,7 +742,7 @@ git-p4.labelExportRegexp::
 
 git-p4.conflict::
 	Specify submit behavior when a conflict with p4 is found, as per
-	--conflict.  The default behavior is 'ask'.
+	`--conflict`.  The default behavior is 'ask'.
 
 git-p4.disableRebase::
     Do not rebase the tree against p4/master following a submit.
diff --git a/Documentation/git-pack-objects.txt b/Documentation/git-pack-objects.txt
index 25d9fbe37a..a78721517b 100644
--- a/Documentation/git-pack-objects.txt
+++ b/Documentation/git-pack-objects.txt
@@ -101,13 +101,13 @@ Incompatible with `--revs`, or options that imply `--revs` (such as
 	the pack are stored using delta compression.  The
 	objects are first internally sorted by type, size and
 	optionally names and compared against the other objects
-	within --window to see if using delta compression saves
-	space.  --depth limits the maximum delta depth; making
+	within `--window` to see if using delta compression saves
+	space.  `--depth` limits the maximum delta depth; making
 	it too deep affects the performance on the unpacker
 	side, because delta data needs to be applied that many
 	times to get to the necessary object.
 +
-The default value for --window is 10 and --depth is 50. The maximum
+The default value for `--window` is 10 and `--depth` is 50. The maximum
 depth is 4095.
 
 --window-memory=<n>::
@@ -165,19 +165,19 @@ depth is 4095.
 	the standard error stream is not directed to a terminal.
 
 --all-progress::
-	When --stdout is specified then progress report is
+	When `--stdout` is specified then progress report is
 	displayed during the object count and compression phases
 	but inhibited during the write-out phase. The reason is
 	that in some cases the output stream is directly linked
 	to another command which may wish to display progress
 	status of its own as it processes incoming pack data.
-	This flag is like --progress except that it forces progress
-	report for the write-out phase as well even if --stdout is
+	This flag is like `--progress` except that it forces progress
+	report for the write-out phase as well even if `--stdout` is
 	used.
 
 --all-progress-implied::
-	This is used to imply --all-progress whenever progress display
-	is activated.  Unlike --all-progress this flag doesn't actually
+	This is used to imply `--all-progress` whenever progress display
+	is activated.  Unlike `--all-progress` this flag doesn't actually
 	force any progress display by itself.
 
 -q::
@@ -194,7 +194,7 @@ depth is 4095.
 --no-reuse-object::
 	This flag tells the command not to reuse existing object data at all,
 	including non deltified object, forcing recompression of everything.
-	This implies --no-reuse-delta. Useful only in the obscure case where
+	This implies `--no-reuse-delta`. Useful only in the obscure case where
 	wholesale enforcement of a different compression level on the
 	packed data is desired.
 
@@ -203,12 +203,12 @@ depth is 4095.
 	generated pack.  If not specified,  pack compression level is
 	determined first by pack.compression,  then by core.compression,
 	and defaults to -1,  the zlib default,  if neither is set.
-	Add --no-reuse-object if you want to force a uniform compression
+	Add `--no-reuse-object` if you want to force a uniform compression
 	level on all data no matter the source.
 
 --[no-]sparse::
 	Toggle the "sparse" algorithm to determine which objects to include in
-	the pack, when combined with the "--revs" option. This algorithm
+	the pack, when combined with the `--revs` option. This algorithm
 	only walks trees that appear in paths that introduce new objects.
 	This can have significant performance benefits when computing
 	a pack to send a small change. However, it is possible that extra
@@ -220,7 +220,7 @@ depth is 4095.
 --thin::
 	Create a "thin" pack by omitting the common objects between a
 	sender and a receiver in order to reduce network transfer. This
-	option only makes sense in conjunction with --stdout.
+	option only makes sense in conjunction with `--stdout`.
 +
 Note: A thin pack violates the packed archive format by omitting
 required objects and is thus unusable by Git without making it
@@ -229,7 +229,7 @@ self-contained. Use `git index-pack --fix-thin`
 
 --shallow::
 	Optimize a pack that will be provided to a client with a shallow
-	repository.  This option, combined with --thin, can result in a
+	repository.  This option, combined with `--thin`, can result in a
 	smaller pack at the cost of speed.
 
 --delta-base-offset::
@@ -279,16 +279,16 @@ So does `git bundle` (see linkgit:git-bundle[1]) when it creates a bundle.
 	A debug option to help with future "partial clone" development.
 	This option specifies how missing objects are handled.
 +
-The form '--missing=error' requests that pack-objects stop with an error if
+The form `--missing=error` requests that pack-objects stop with an error if
 a missing object is encountered.  If the repository is a partial clone, an
 attempt to fetch missing objects will be made before declaring them missing.
 This is the default action.
 +
-The form '--missing=allow-any' will allow object traversal to continue
+The form `--missing=allow-any` will allow object traversal to continue
 if a missing object is encountered.  No fetch of a missing object will occur.
 Missing objects will silently be omitted from the results.
 +
-The form '--missing=allow-promisor' is like 'allow-any', but will only
+The form `--missing=allow-promisor` is like 'allow-any', but will only
 allow object traversal to continue for EXPECTED promisor missing objects.
 No fetch of a missing object will occur.  An unexpected missing object will
 raise an error.
@@ -302,7 +302,7 @@ raise an error.
 
 --keep-unreachable::
 	Objects unreachable from the refs in packs named with
-	--unpacked= option are added to the resulting pack, in
+	`--unpacked`= option are added to the resulting pack, in
 	addition to the reachable objects that are not in packs marked
 	with *.keep files. This implies `--revs`.
 
@@ -363,7 +363,7 @@ to recompute deltas on the fly due to crossing island boundaries.
 
 When repacking with delta islands the delta window tends to get
 clogged with candidates that are forbidden by the config. Repacking
-with a big --window helps (and doesn't take as long as it otherwise
+with a big `--window` helps (and doesn't take as long as it otherwise
 might because we can reject some object pairs based on islands before
 doing any computation on the content).
 
diff --git a/Documentation/git-patch-id.txt b/Documentation/git-patch-id.txt
index 442caff8a9..fb5b194b8a 100644
--- a/Documentation/git-patch-id.txt
+++ b/Documentation/git-patch-id.txt
@@ -34,15 +34,15 @@ OPTIONS
 	Use a "stable" sum of hashes as the patch ID. With this option:
 	 - Reordering file diffs that make up a patch does not affect the ID.
 	   In particular, two patches produced by comparing the same two trees
-	   with two different settings for "-O<orderfile>" result in the same
+	   with two different settings for `-O<orderfile>` result in the same
 	   patch ID signature, thereby allowing the computed result to be used
 	   as a key to index some meta-information about the change between
 	   the two trees;
 
 	 - Result is different from the value produced by git 1.9 and older
-	   or produced when an "unstable" hash (see --unstable below) is
+	   or produced when an "unstable" hash (see `--unstable` below) is
 	   configured - even when used on a diff output taken without any use
-	   of "-O<orderfile>", thereby making existing databases storing such
+	   of `-O<orderfile>`, thereby making existing databases storing such
 	   "unstable" or historical patch-ids unusable.
 
 	This is the default if patchid.stable is set to true.
diff --git a/Documentation/git-prune.txt b/Documentation/git-prune.txt
index 03552dd86f..7bad035e47 100644
--- a/Documentation/git-prune.txt
+++ b/Documentation/git-prune.txt
@@ -75,7 +75,7 @@ should instead call 'git gc', which handles pruning along with
 many other housekeeping tasks.
 
 For a description of which objects are considered for pruning, see
-'git fsck''s --unreachable option.
+'git fsck''s `--unreachable` option.
 
 SEE ALSO
 --------
diff --git a/Documentation/git-pull.txt b/Documentation/git-pull.txt
index 5c3fb67c01..edecf393d3 100644
--- a/Documentation/git-pull.txt
+++ b/Documentation/git-pull.txt
@@ -82,7 +82,7 @@ OPTIONS
 
 -v::
 --verbose::
-	Pass --verbose to git-fetch and git-merge.
+	Pass `--verbose` to git-fetch and git-merge.
 
 --[no-]recurse-submodules[=yes|on-demand|no]::
 	This option controls if new commits of populated submodules should
@@ -132,7 +132,7 @@ published that history already.  Do *not* use this option
 unless you have read linkgit:git-rebase[1] carefully.
 
 --no-rebase::
-	Override earlier --rebase.
+	Override earlier `--rebase`.
 
 Options related to fetching
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~
@@ -239,7 +239,7 @@ include::transfer-data-leaks.txt[]
 
 BUGS
 ----
-Using --recurse-submodules can only fetch new commits in already checked
+Using `--recurse-submodules` can only fetch new commits in already checked
 out submodules right now. When e.g. upstream added a new submodule in the
 just fetched commits of the superproject the submodule itself cannot be
 fetched, making it impossible to check out that submodule later without
diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
index a953c7c387..fc91d41ce0 100644
--- a/Documentation/git-push.txt
+++ b/Documentation/git-push.txt
@@ -277,7 +277,7 @@ that specifies the expected current value of the ref explicitly are
 still experimental and their semantics may change as we gain experience
 with this feature.
 +
-"--no-force-with-lease" will cancel all the previous --force-with-lease on the
+`--no-force-with-lease` will cancel all the previous `--force-with-lease` on the
 command line.
 +
 A general note on safety: supplying this option without an expected
@@ -416,8 +416,8 @@ Specifying `--no-force-if-includes` disables this behavior.
 
 --[no-]verify::
 	Toggle the pre-push hook (see linkgit:githooks[5]).  The
-	default is --verify, giving the hook a chance to prevent the
-	push.  With --no-verify, the hook is bypassed completely.
+	default is `--verify`, giving the hook a chance to prevent the
+	push.  With `--no-verify`, the hook is bypassed completely.
 
 -4::
 --ipv4::
@@ -443,13 +443,13 @@ representing the status of a single ref. Each line is of the form:
  <flag> <summary> <from> -> <to> (<reason>)
 -------------------------------
 
-If --porcelain is used, then each line of the output is of the form:
+If `--porcelain` is used, then each line of the output is of the form:
 
 -------------------------------
  <flag> \t <from>:<to> \t <summary> (<reason>)
 -------------------------------
 
-The status of up-to-date refs is shown only if --porcelain or --verbose
+The status of up-to-date refs is shown only if `--porcelain` or `--verbose`
 option is used.
 
 flag::
diff --git a/Documentation/git-quiltimport.txt b/Documentation/git-quiltimport.txt
index 70562dc4c0..edae01d55d 100644
--- a/Documentation/git-quiltimport.txt
+++ b/Documentation/git-quiltimport.txt
@@ -21,7 +21,7 @@ in the quilt patchset.
 
 For each patch the code attempts to extract the author from the
 patch description.  If that fails it falls back to the author
-specified with --author.  If the --author flag was not given
+specified with `--author`.  If the `--author` flag was not given
 the patch description is displayed and the user is asked to
 interactively enter the author of the patch.
 
diff --git a/Documentation/git-read-tree.txt b/Documentation/git-read-tree.txt
index 5fa8bab64c..3f53688170 100644
--- a/Documentation/git-read-tree.txt
+++ b/Documentation/git-read-tree.txt
@@ -38,7 +38,7 @@ OPTIONS
 	started.
 
 --reset::
-	Same as -m, except that unmerged entries are discarded instead
+	Same as `-m`, except that unmerged entries are discarded instead
 	of failing. When used with `-u`, updates leading to loss of
 	working tree changes will not abort the operation.
 
@@ -116,7 +116,7 @@ OPTIONS
 	located in.
 
 --[no-]recurse-submodules::
-	Using --recurse-submodules will update the content of all active
+	Using `--recurse-submodules` will update the content of all active
 	submodules according to the commit recorded in the superproject by
 	calling read-tree recursively, also setting the submodules' HEAD to be
 	detached at that commit.
@@ -227,7 +227,7 @@ refer to the presence of a path in the specified commit:
 In all "keep index" cases, the index entry stays as in the
 original index file.  If the entry is not up to date,
 'git read-tree' keeps the copy in the work tree intact when
-operating under the -u flag.
+operating under the `-u` flag.
 
 When this form of 'git read-tree' returns successfully, you can
 see which of the "local changes" that you made were carried forward by running
diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index f08ae27e2a..f063d54623 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -34,7 +34,7 @@ description on `--fork-point` below); or by `git log HEAD`, if the
 `--root` option is specified.
 
 The current branch is reset to <upstream>, or <newbase> if the
---onto option was supplied.  This has the exact same effect as
+`--onto` option was supplied.  This has the exact same effect as
 `git reset --hard <upstream>` (or <newbase>).  ORIG_HEAD is set
 to point at the tip of the branch before the reset.
 
@@ -130,7 +130,7 @@ We can get this using the following command:
     git rebase --onto master next topic
 
 
-Another example of --onto option is to rebase part of a
+Another example of `--onto` option is to rebase part of a
 branch.  If we have the following situation:
 
 ------------
@@ -175,7 +175,7 @@ would result in the removal of commits F and G:
 ------------
 
 This is useful if F and G were flawed in some way, or should not be
-part of topicA.  Note that the argument to --onto and the <upstream>
+part of topicA.  Note that the argument to `--onto` and the <upstream>
 parameter can be any valid commit-ish.
 
 In case of conflict, 'git rebase' will stop at the first problematic commit
@@ -210,7 +210,7 @@ OPTIONS
 -------
 --onto <newbase>::
 	Starting point at which to create the new commits. If the
-	--onto option is not specified, the starting point is
+	`--onto` option is not specified, the starting point is
 	<upstream>.  May be any valid commit, and not just an
 	existing branch name.
 +
@@ -229,9 +229,9 @@ top of an upstream branch. While the feature is being worked on, the
 upstream branch may advance and it may not be the best idea to keep
 rebasing on top of the upstream but to keep the base commit as-is.
 +
-Although both this option and --fork-point find the merge base between
+Although both this option and `--fork-point` find the merge base between
 <upstream> and <branch>, this option uses the merge base as the _starting
-point_ on which new commits will be created, whereas --fork-point uses
+point_ on which new commits will be created, whereas `--fork-point` uses
 the merge base to determine the _set of commits_ which will be rebased.
 +
 See also INCOMPATIBLE OPTIONS below.
@@ -258,7 +258,7 @@ See also INCOMPATIBLE OPTIONS below.
 	Abort the rebase operation but HEAD is not reset back to the
 	original branch. The index and working tree are also left
 	unchanged as a result. If a temporary stash entry was created
-	using --autostash, it will be saved to the stash list.
+	using `--autostash`, it will be saved to the stash list.
 
 --apply::
 	Use applying strategies to rebase (calling `git-am`
@@ -276,13 +276,13 @@ See also INCOMPATIBLE OPTIONS below.
 	With ask (implied by --interactive), the rebase will halt when
 	an empty commit is applied allowing you to choose whether to
 	drop it, edit files more, or just commit the empty changes.
-	Other options, like --exec, will use the default of drop unless
-	-i/--interactive is explicitly specified.
+	Other options, like `--exec`, will use the default of drop unless
+	`-i`/`--interactive` is explicitly specified.
 +
-Note that commits which start empty are kept (unless --no-keep-empty
+Note that commits which start empty are kept (unless `--no-keep-empty`
 is specified), and commits which are clean cherry-picks (as determined
 by `git log --cherry-mark ...`) are detected and dropped as a
-preliminary step (unless --reapply-cherry-picks is passed).
+preliminary step (unless `--reapply-cherry-picks` is passed).
 +
 See also INCOMPATIBLE OPTIONS below.
 
@@ -291,7 +291,7 @@ See also INCOMPATIBLE OPTIONS below.
 	Do not keep commits that start empty before the rebase
 	(i.e. that do not change anything from its parent) in the
 	result.  The default is to keep commits which start empty,
-	since creating such commits requires passing the --allow-empty
+	since creating such commits requires passing the `--allow-empty`
 	override flag to `git commit`, signifying that a user is very
 	intentionally creating such a commit and thus wants to keep
 	it.
@@ -303,7 +303,7 @@ flag exists as a convenient shortcut, such as for cases where external
 tools generate many empty commits and you want them all removed.
 +
 For commits which do not start empty but become empty after rebasing,
-see the --empty flag.
+see the `--empty` flag.
 +
 See also INCOMPATIBLE OPTIONS below.
 
@@ -362,7 +362,7 @@ See also INCOMPATIBLE OPTIONS below.
 --strategy=<strategy>::
 	Use the given merge strategy.
 	If there is no `-s` option 'git merge-recursive' is used
-	instead.  This implies --merge.
+	instead.  This implies `--merge`.
 +
 Because 'git rebase' replays each commit from the working branch
 on top of the <upstream> branch using the given strategy, using
@@ -396,11 +396,11 @@ See also INCOMPATIBLE OPTIONS below.
 
 -q::
 --quiet::
-	Be quiet. Implies --no-stat.
+	Be quiet. Implies `--no-stat`.
 
 -v::
 --verbose::
-	Be verbose. Implies --stat.
+	Be verbose. Implies `--stat`.
 
 --stat::
 	Show a diffstat of what changed upstream since the last rebase. The
@@ -415,13 +415,13 @@ See also INCOMPATIBLE OPTIONS below.
 
 --verify::
 	Allows the pre-rebase hook to run, which is the default.  This option can
-	be used to override --no-verify.  See also linkgit:githooks[5].
+	be used to override `--no-verify`.  See also linkgit:githooks[5].
 
 -C<n>::
 	Ensure at least <n> lines of surrounding context match before
 	and after each change.  When fewer lines of surrounding
 	context exist they all must match.  By default no context is
-	ever ignored.  Implies --apply.
+	ever ignored.  Implies `--apply`.
 +
 See also INCOMPATIBLE OPTIONS below.
 
@@ -444,7 +444,7 @@ details).
 	and <branch> when calculating which commits have been
 	introduced by <branch>.
 +
-When --fork-point is active, 'fork_point' will be used instead of
+When `--fork-point` is active, 'fork_point' will be used instead of
 <upstream> to calculate the set of commits to rebase, where
 'fork_point' is the result of `git merge-base --fork-point <upstream>
 <branch>` command (see linkgit:git-merge-base[1]).  If 'fork_point'
@@ -478,7 +478,7 @@ if the other side had no changes that conflicted.
 --whitespace=<option>::
 	This flag is passed to the 'git apply' program
 	(see linkgit:git-apply[1]) that applies the patch.
-	Implies --apply.
+	Implies `--apply`.
 +
 See also INCOMPATIBLE OPTIONS below.
 
@@ -582,10 +582,10 @@ See also INCOMPATIBLE OPTIONS below.
 --root::
 	Rebase all commits reachable from <branch>, instead of
 	limiting them with an <upstream>.  This allows you to rebase
-	the root commit(s) on a branch.  When used with --onto, it
+	the root commit(s) on a branch.  When used with `--onto`, it
 	will skip changes already contained in <newbase> (instead of
-	<upstream>) whereas without --onto it will operate on every change.
-	When used together with both --onto and --preserve-merges,
+	<upstream>) whereas without `--onto` it will operate on every change.
+	When used together with both `--onto` and `--preserve-merges`,
 	'all' root commits will be rewritten to have <newbase> as parent
 	instead.
 +
@@ -629,39 +629,39 @@ INCOMPATIBLE OPTIONS
 
 The following options:
 
- * --apply
- * --whitespace
- * -C
+ * `--apply`
+ * `--whitespace`
+ * `-C`
 
 are incompatible with the following options:
 
- * --merge
- * --strategy
- * --strategy-option
- * --allow-empty-message
- * --[no-]autosquash
- * --rebase-merges
- * --preserve-merges
- * --interactive
- * --exec
- * --no-keep-empty
- * --empty=
- * --reapply-cherry-picks
- * --edit-todo
- * --root when used in combination with --onto
+ * `--merge`
+ * `--strategy`
+ * `--strategy-option`
+ * `--allow-empty-message`
+ * `--[no-]autosquash`
+ * `--rebase-merges`
+ * `--preserve-merges`
+ * `--interactive`
+ * `--exec`
+ * `--no-keep-empty`
+ * `--empty=`
+ * `--reapply-cherry-picks`
+ * `--edit-todo`
+ * `--root` when used in combination with `--onto`
 
 In addition, the following pairs of options are incompatible:
 
- * --preserve-merges and --interactive
- * --preserve-merges and --signoff
- * --preserve-merges and --rebase-merges
- * --preserve-merges and --empty=
- * --preserve-merges and --ignore-whitespace
- * --preserve-merges and --committer-date-is-author-date
- * --preserve-merges and --ignore-date
- * --keep-base and --onto
- * --keep-base and --root
- * --fork-point and --root
+ * `--preserve-merges` and `--interactive` 
+ * `--preserve-merges` and `--signoff` 
+ * `--preserve-merges` and `--rebase-merges` 
+ * `--preserve-merges` and `--empty=` 
+ * `--preserve-merges` and `--ignore-whitespace` 
+ * `--preserve-merges` and `--committer-date-is-author-date` 
+ * `--preserve-merges` and `--ignore-date` 
+ * `--keep-base` and `--onto` 
+ * `--keep-base` and `--root` 
+ * `--fork-point` and `--root` 
 
 BEHAVIORAL DIFFERENCES
 -----------------------
@@ -683,13 +683,13 @@ also drops commits that become empty and has no option for controlling
 this behavior.
 
 The merge backend keeps intentionally empty commits by default (though
-with -i they are marked as empty in the todo list editor, or they can
-be dropped automatically with --no-keep-empty).
+with `-i` they are marked as empty in the todo list editor, or they can
+be dropped automatically with `--no-keep-empty`).
 
 Similar to the apply backend, by default the merge backend drops
-commits that become empty unless -i/--interactive is specified (in
+commits that become empty unless `-i`/`--interactive` is specified (in
 which case it stops and asks the user what to do).  The merge backend
-also has an --empty={drop,keep,ask} option for changing the behavior
+also has an `--empty={drop,keep,ask}` option for changing the behavior
 of handling commits that become empty.
 
 Directory rename detection
diff --git a/Documentation/git-repack.txt b/Documentation/git-repack.txt
index 317d63cf0d..98373e4f36 100644
--- a/Documentation/git-repack.txt
+++ b/Documentation/git-repack.txt
@@ -96,7 +96,7 @@ to the new separate pack will be written.
 	affects the performance on the unpacker side, because delta data needs
 	to be applied that many times to get to the necessary object.
 +
-The default value for --window is 10 and --depth is 50. The maximum
+The default value for `--window` is 10 and `--depth` is 50. The maximum
 depth is 4095.
 
 --threads=<n>::
diff --git a/Documentation/git-reset.txt b/Documentation/git-reset.txt
index 252e2d4e47..e9e816a986 100644
--- a/Documentation/git-reset.txt
+++ b/Documentation/git-reset.txt
@@ -89,7 +89,7 @@ but carries forward unmerged index entries.
 	changes, reset is aborted.
 
 --[no-]recurse-submodules::
-	When the working tree is updated, using --recurse-submodules will
+	When the working tree is updated, using `--recurse-submodules` will
 	also recursively reset the working tree of all active submodules
 	according to the commit recorded in the superproject, also setting
 	the submodules' HEAD to be detached at that commit.
@@ -345,7 +345,7 @@ $ git commit ...                            <8>
 ------------
 +
 <1> First, reset the history back one commit so that we remove the original
-    commit, but leave the working tree with all the changes. The -N ensures
+    commit, but leave the working tree with all the changes. The `-N` ensures
     that any new files added with `HEAD` are still marked so that `git add -p`
     will find them.
 <2> Next, we interactively select diff hunks to add using the `git add -p`
diff --git a/Documentation/git-rev-parse.txt b/Documentation/git-rev-parse.txt
index 6b8ca085aa..4b1af8c5a6 100644
--- a/Documentation/git-rev-parse.txt
+++ b/Documentation/git-rev-parse.txt
@@ -152,7 +152,7 @@ for another option.
 	form as close to the original input as possible.
 
 --symbolic-full-name::
-	This is similar to --symbolic, but it omits input that
+	This is similar to `--symbolic`, but it omits input that
 	are not refs (i.e. branch or tag names; or more
 	explicitly disambiguating "heads/master" form, when you
 	want to name the "master" branch when there is an
@@ -306,12 +306,12 @@ Other Options
 --since=datestring::
 --after=datestring::
 	Parse the date string, and output the corresponding
-	--max-age= parameter for 'git rev-list'.
+	`--max-age=` parameter for 'git rev-list'.
 
 --until=datestring::
 --before=datestring::
 	Parse the date string, and output the corresponding
-	--min-age= parameter for 'git rev-list'.
+	`--min-age=` parameter for 'git rev-list'.
 
 <args>...::
 	Flags and parameters to be parsed.
diff --git a/Documentation/git-rm.txt b/Documentation/git-rm.txt
index ab750367fd..e7ff1b5fbd 100644
--- a/Documentation/git-rm.txt
+++ b/Documentation/git-rm.txt
@@ -151,7 +151,7 @@ still uses a .git directory, `git rm` will move the submodules
 git directory into the superprojects git directory to protect
 the submodule's history. If it exists the submodule.<name> section
 in the linkgit:gitmodules[5] file will also be removed and that file
-will be staged (unless --cached or -n are used).
+will be staged (unless `--cached` or `-n` are used).
 
 A submodule is considered up to date when the HEAD is the same as
 recorded in the index, no tracked files are modified and no untracked
diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
index 93708aefea..afd41a010e 100644
--- a/Documentation/git-send-email.txt
+++ b/Documentation/git-send-email.txt
@@ -87,7 +87,7 @@ See the CONFIGURATION section for `sendemail.multiEdit`.
 --reply-to=<address>::
 	Specify the address where replies from recipients should go to.
 	Use this if replies to messages should go to another address than what
-	is specified with the --from parameter.
+	is specified with the `--from` parameter.
 
 --in-reply-to=<identifier>::
 	Make the first mail (or all the mails with `--no-thread`) appear as a
@@ -108,19 +108,19 @@ illustration below where `[PATCH v2 0/3]` is in reply to `[PATCH 0/2]`:
       [PATCH v2 2/3] New tests
       [PATCH v2 3/3] Implementation
 +
-Only necessary if --compose is also set.  If --compose
+Only necessary if `--compose` is also set.  If `--compose`
 is not set, this will be prompted for.
 
 --subject=<string>::
 	Specify the initial subject of the email thread.
-	Only necessary if --compose is also set.  If --compose
+	Only necessary if `--compose` is also set.  If `--compose`
 	is not set, this will be prompted for.
 
 --to=<address>,...::
 	Specify the primary recipient of the emails generated. Generally, this
 	will be the upstream maintainer of the project involved. Default is the
 	value of the `sendemail.to` configuration value; if that is unspecified,
-	and --to-cmd is not specified, this will be prompted for.
+	and `--to-cmd` is not specified, this will be prompted for.
 +
 This option may be specified multiple times.
 
@@ -163,7 +163,7 @@ Sending
 	This is useful if your default address is not the address that is
 	subscribed to a list. In order to use the 'From' address, set the
 	value to "auto". If you use the sendmail binary, you must have
-	suitable privileges for the -f parameter.  Default is the value of the
+	suitable privileges for the `-f` parameter.  Default is the value of the
 	`sendemail.envelopeSender` configuration variable; if that is
 	unspecified, choosing the envelope sender is left to your MTA.
 
@@ -232,12 +232,12 @@ a password is obtained using 'git-credential'.
 	Default value can be specified by the `sendemail.smtpServerOption`
 	configuration option.
 +
-The --smtp-server-option option must be repeated for each option you want
+The `--smtp-server-option` option must be repeated for each option you want
 to pass to the server. Likewise, different lines in the configuration files
 must be used for each option.
 
 --smtp-ssl::
-	Legacy alias for '--smtp-encryption ssl'.
+	Legacy alias for `--smtp-encryption ssl`.
 
 --smtp-ssl-cert-path::
 	Path to a store of trusted CA certificates for SMTP SSL/TLS
@@ -264,7 +264,7 @@ must be used for each option.
 	Some email servers (e.g. smtp.163.com) limit the number emails to be
 	sent per session (connection) and this will lead to a failure when
 	sending many messages.  With this option, send-email will disconnect after
-	sending $<num> messages and wait for a few seconds (see --relogin-delay)
+	sending $<num> messages and wait for a few seconds (see `--relogin-delay`)
 	and reconnect, to work around such a limit.  You may want to
 	use some form of credential helper to avoid having to retype
 	your password every time this happens.  Defaults to the
@@ -272,7 +272,7 @@ must be used for each option.
 
 --relogin-delay=<int>::
 	Waiting $<int> seconds before reconnecting to SMTP server. Used together
-	with --batch-size option.  Defaults to the `sendemail.smtpReloginDelay`
+	with `--batch-size` option.  Defaults to the `sendemail.smtpReloginDelay`
 	configuration variable.
 
 Automating
@@ -300,7 +300,7 @@ Automating
 
 --[no-]chain-reply-to::
 	If this is set, each email will be sent as a reply to the previous
-	email sent.  If disabled with "--no-chain-reply-to", all emails after
+	email sent.  If disabled with `--no-chain-reply-to`, all emails after
 	the first will be sent as replies to the first email sent.  When using
 	this, it is recommended that the first file given be an overview of the
 	entire patch series. Disabled by default, but the `sendemail.chainReplyTo`
@@ -315,19 +315,19 @@ Automating
 --[no-]signed-off-by-cc::
 	If this is set, add emails found in the `Signed-off-by` trailer or Cc: lines to the
 	cc list. Default is the value of `sendemail.signedoffbycc` configuration
-	value; if that is unspecified, default to --signed-off-by-cc.
+	value; if that is unspecified, default to `--signed-off-by-cc`.
 
 --[no-]cc-cover::
 	If this is set, emails found in Cc: headers in the first patch of
 	the series (typically the cover letter) are added to the cc list
 	for each email set. Default is the value of 'sendemail.cccover'
-	configuration value; if that is unspecified, default to --no-cc-cover.
+	configuration value; if that is unspecified, default to `--no-cc-cover`.
 
 --[no-]to-cover::
 	If this is set, emails found in To: headers in the first patch of
 	the series (typically the cover letter) are added to the to list
 	for each email set. Default is the value of 'sendemail.tocover'
-	configuration value; if that is unspecified, default to --no-to-cover.
+	configuration value; if that is unspecified, default to `--no-to-cover`.
 
 --suppress-cc=<category>::
 	Specify an additional category of recipients to suppress the
@@ -345,19 +345,19 @@ Automating
 - 'misc-by' will avoid including anyone mentioned in Acked-by,
   Reviewed-by, Tested-by and other "-by" lines in the patch body,
   except Signed-off-by (use 'sob' for that).
-- 'cccmd' will avoid running the --cc-cmd.
+- 'cccmd' will avoid running the `--cc-cmd`.
 - 'body' is equivalent to 'sob' + 'bodycc' + 'misc-by'.
 - 'all' will suppress all auto cc values.
 --
 +
 Default is the value of `sendemail.suppresscc` configuration value; if
-that is unspecified, default to 'self' if --suppress-from is
-specified, as well as 'body' if --no-signed-off-cc is specified.
+that is unspecified, default to 'self' if `--suppress-from` is
+specified, as well as 'body' if `--no-signed-off-cc` is specified.
 
 --[no-]suppress-from::
 	If this is set, do not add the From: address to the cc: list.
 	Default is the value of `sendemail.suppressFrom` configuration
-	value; if that is unspecified, default to --no-suppress-from.
+	value; if that is unspecified, default to `--no-suppress-from`.
 
 --[no-]thread::
 	If this is set, the In-Reply-To and References headers will be
@@ -366,10 +366,10 @@ specified, as well as 'body' if --no-signed-off-cc is specified.
 	wording) or to the first email (`shallow` threading) is
 	governed by "--[no-]chain-reply-to".
 +
-If disabled with "--no-thread", those headers will not be added
-(unless specified with --in-reply-to).  Default is the value of the
+If disabled with `--no-thread`, those headers will not be added
+(unless specified with `--in-reply-to`).  Default is the value of the
 `sendemail.thread` configuration value; if that is unspecified,
-default to --thread.
+default to `--thread`.
 +
 It is up to the user to ensure that no In-Reply-To header already
 exists when 'git send-email' is asked to add it (especially note that
@@ -389,7 +389,7 @@ Administering
 - 'never' will never confirm before sending
 - 'cc' will confirm before sending when send-email has automatically
   added addresses from the patch to the Cc list
-- 'compose' will confirm before sending the first message when using --compose.
+- 'compose' will confirm before sending the first message when using `--compose`.
 - 'auto' is equivalent to 'cc' + 'compose'
 --
 +
diff --git a/Documentation/git-send-pack.txt b/Documentation/git-send-pack.txt
index 44fd146b91..2cd2d823b3 100644
--- a/Documentation/git-send-pack.txt
+++ b/Documentation/git-send-pack.txt
@@ -32,7 +32,7 @@ OPTIONS
 	a directory on the default $PATH.
 
 --exec=<git-receive-pack>::
-	Same as --receive-pack=<git-receive-pack>.
+	Same as `--receive-pack`=<git-receive-pack>.
 
 --all::
 	Instead of explicitly specifying which refs to update,
diff --git a/Documentation/git-show-branch.txt b/Documentation/git-show-branch.txt
index 5cc2fcefba..0ce603646f 100644
--- a/Documentation/git-show-branch.txt
+++ b/Documentation/git-show-branch.txt
@@ -126,7 +126,7 @@ OPTIONS
 	default to color output.
 	Same as `--color=never`.
 
-Note that --more, --list, --independent and --merge-base options
+Note that `--more`, `--list`, `--independent` and `--merge-base` options
 are mutually exclusive.
 
 
diff --git a/Documentation/git-show-ref.txt b/Documentation/git-show-ref.txt
index ab4d271925..8c739adc70 100644
--- a/Documentation/git-show-ref.txt
+++ b/Documentation/git-show-ref.txt
@@ -23,7 +23,7 @@ particular ref exists.
 
 By default, shows the tags, heads, and remote refs.
 
-The --exclude-existing form is a filter that does the inverse. It reads
+The `--exclude-existing` form is a filter that does the inverse. It reads
 refs from stdin, one ref per line, and shows those that don't exist in
 the local repository.
 
@@ -54,7 +54,7 @@ OPTIONS
 --hash[=<n>]::
 
 	Only show the SHA-1 hash, not the reference name. When combined with
-	--dereference the dereferenced tag will still be shown after the SHA-1.
+	`--dereference` the dereferenced tag will still be shown after the SHA-1.
 
 --verify::
 
@@ -110,7 +110,7 @@ $ git show-ref --head --dereference
 ...
 -----------------------------------------------------------------------------
 
-When using --hash (and not --dereference) the output format is: '<SHA-1 ID>'
+When using `--hash` (and not `--dereference`) the output format is: '<SHA-1 ID>'
 
 -----------------------------------------------------------------------------
 $ git show-ref --heads --hash
@@ -145,7 +145,7 @@ will only match the exact branch called "master".
 If nothing matches, 'git show-ref' will return an error code of 1,
 and in the case of verification, it will show an error message.
 
-For scripting, you can ask it to be quiet with the "--quiet" flag, which
+For scripting, you can ask it to be quiet with the `--quiet` flag, which
 allows you to do things like
 
 -----------------------------------------------------------------------------
@@ -157,11 +157,11 @@ to check whether a particular branch exists or not (notice how we don't
 actually want to show any results, and we want to use the full refname for it
 in order to not trigger the problem with ambiguous partial matches).
 
-To show only tags, or only proper branch heads, use "--tags" and/or "--heads"
+To show only tags, or only proper branch heads, use `--tags` and/or `--heads`
 respectively (using both means that it shows tags and heads, but not other
 random references under the refs/ subdirectory).
 
-To do automatic tag object dereferencing, use the "-d" or "--dereference"
+To do automatic tag object dereferencing, use the `-d` or `--dereference`
 flag, so you can do
 
 -----------------------------------------------------------------------------
diff --git a/Documentation/git-status.txt b/Documentation/git-status.txt
index 83f38e3198..2fa3bc58f7 100644
--- a/Documentation/git-status.txt
+++ b/Documentation/git-status.txt
@@ -109,7 +109,7 @@ It is optional: it defaults to 'traditional'.
 The possible options are:
 
 	- 'traditional' - Shows ignored files and directories, unless
-			  --untracked-files=all is specified, in which case
+			  `--untracked-files=all` is specified, in which case
 			  individual files in ignored directories are
 			  displayed.
 	- 'no'	        - Show no ignored files.
@@ -252,7 +252,7 @@ via `git add` in the superproject to prepare a commit.
 'm' and '?' are applied recursively. For example if a nested submodule
 in a submodule contains an untracked file, this is reported as '?' as well.
 
-If -b is used the short-format status is preceded by a line
+If `-b` is used the short-format status is preceded by a line
 
     ## branchname tracking info
 
@@ -271,7 +271,7 @@ format, with a few exceptions:
 2. The user's status.relativePaths configuration is not respected; paths
    shown will always be relative to the repository root.
 
-There is also an alternate -z format recommended for machine parsing. In
+There is also an alternate `-z` format recommended for machine parsing. In
 that format, the status field is the same, but some other things
 change.  First, the '\->' is omitted from rename entries and the field
 order is reversed (e.g 'from \-> to' becomes 'to from'). Second, a NUL
@@ -425,11 +425,11 @@ directory.
 If `status.submoduleSummary` is set to a non zero number or true (identical
 to -1 or an unlimited number), the submodule summary will be enabled for
 the long format and a summary of commits for modified submodules will be
-shown (see --summary-limit option of linkgit:git-submodule[1]). Please note
+shown (see `--summary-limit` option of linkgit:git-submodule[1]). Please note
 that the summary output from the status command will be suppressed for all
 submodules when `diff.ignoreSubmodules` is set to 'all' or only for those
 submodules where `submodule.<name>.ignore=all`. To also view the summary for
-ignored submodules you can either use the --ignore-submodules=dirty command
+ignored submodules you can either use the `--ignore-submodules=dirty` command
 line option or the 'git submodule summary' command, which shows a similar
 output but does not honor these settings.
 
diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
index 7e5f995f77..1bcde161ca 100644
--- a/Documentation/git-submodule.txt
+++ b/Documentation/git-submodule.txt
@@ -432,7 +432,7 @@ options carefully.
 
 --[no-]single-branch::
 	This option is only valid for the update command.
-	Clone only one branch during update: HEAD or one specified by --branch.
+	Clone only one branch during update: HEAD or one specified by `--branch`.
 
 <path>...::
 	Paths to submodule(s). When specified this will restrict the command
diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
index 67b143cc81..3f55e9c419 100644
--- a/Documentation/git-svn.txt
+++ b/Documentation/git-svn.txt
@@ -17,8 +17,8 @@ It provides a bidirectional flow of changes between a Subversion and a Git
 repository.
 
 'git svn' can track a standard Subversion repository,
-following the common "trunk/branches/tags" layout, with the --stdlayout option.
-It can also follow branches and tags in any layout with the -T/-t/-b options
+following the common "trunk/branches/tags" layout, with the `--stdlayout` option.
+It can also follow branches and tags in any layout with the `-T`/`-t`/`-b` options
 (see options to 'init' below, and also the 'clone' command).
 
 Once tracking a Subversion repository (with any of the above methods), the Git
@@ -32,7 +32,7 @@ COMMANDS
 	Initializes an empty Git repository with additional
 	metadata directories for 'git svn'.  The Subversion URL
 	may be specified as a command-line argument, or as full
-	URL arguments to -T/-t/-b.  Optionally, the target
+	URL arguments to `-T`/`-t`/`-b`.  Optionally, the target
 	directory to operate on can be specified as a second
 	argument.  Normally this command initializes the current
 	directory.
@@ -47,11 +47,11 @@ COMMANDS
 --stdlayout;;
 	These are optional command-line options for init.  Each of
 	these flags can point to a relative repository path
-	(--tags=project/tags) or a full url
-	(--tags=https://foo.org/project/tags).
-	You can specify more than one --tags and/or --branches options, in case
+	(`--tags=project/tags`) or a full url
+	(`--tags=https://foo.org/project/tags`).
+	You can specify more than one `--tags` and/or `--branches` options, in case
 	your Subversion repository places tags or branches under multiple paths.
-	The option --stdlayout is
+	The option `--stdlayout` is
 	a shorthand way of setting trunk,tags,branches as the relative paths,
 	which is the Subversion default. If any of the other options are given
 	as well, they take precedence.
@@ -77,7 +77,7 @@ COMMANDS
 	to the names of remotes if trunk/branches/tags are
 	specified.  The prefix does not automatically include a
 	trailing slash, so be sure you include one in the
-	argument if that is what you want.  If --branches/-b is
+	argument if that is what you want.  If `--branches`/`-b` is
 	specified, the prefix must include a trailing slash.
 	Setting a prefix (with a trailing slash) is strongly
 	encouraged in any case, as your SVN-tracking refs will
@@ -108,8 +108,8 @@ your Perl's Getopt::Long is < v2.37).
 	be preserved as a config key.  See 'fetch' for a description
 	of `--include-paths`.
 --no-minimize-url;;
-	When tracking multiple directories (using --stdlayout,
-	--branches, or --tags options), git svn will attempt to connect
+	When tracking multiple directories (using `--stdlayout`,
+	`--branches`, or `--tags` options), git svn will attempt to connect
 	to the root (or highest allowed level) of the Subversion
 	repository.  This default allows better tracking of history if
 	entire projects are moved within a repository, but may cause
@@ -130,7 +130,7 @@ This automatically updates the rev_map if needed (see
 
 --localtime;;
 	Store Git commit times in the local time zone instead of UTC.  This
-	makes 'git log' (even without --date=local) show the same times
+	makes 'git log' (even without `--date=local`) show the same times
 	that `svn log` would in the local time zone.
 +
 This doesn't interfere with interoperating with the Subversion
@@ -220,7 +220,7 @@ config key: svn-remote.<name>.include-paths
 	are also tracked and removed when no longer necessary.
 
 --placeholder-filename=<filename>;;
-	Set the name of placeholder files created by --preserve-empty-dirs.
+	Set the name of placeholder files created by `--preserve-empty-dirs`.
 	Default: ".gitignore"
 
 'rebase'::
@@ -317,7 +317,7 @@ committing anything to SVN.
 -d<path>;;
 --destination=<path>;;
 
-	If more than one --branches (or --tags) option was given to the 'init'
+	If more than one `--branches` (or `--tags`) option was given to the 'init'
 	or 'clone' command, you must provide the location of the branch (or
 	tag) you wish to create in the SVN repository.  <path> specifies which
 	path to use to create the branch or tag and should match the pattern
@@ -327,7 +327,7 @@ committing anything to SVN.
 	git config --get-all svn-remote.<name>.branches
 	git config --get-all svn-remote.<name>.tags
 +
-where <name> is the name of the SVN repository as specified by the -R option to
+where <name> is the name of the SVN repository as specified by the `-R` option to
 'init' (or "svn" by default).
 
 --username;;
@@ -345,7 +345,7 @@ where <name> is the name of the SVN repository as specified by the -R option to
 
 --parents;;
 	Create parent folders. This parameter is equivalent to the parameter
-	--parents on svn cp commands and is useful for non-standard repository
+	`--parents` on svn cp commands and is useful for non-standard repository
 	layouts.
 
 'tag'::
@@ -354,7 +354,7 @@ where <name> is the name of the SVN repository as specified by the -R option to
 
 'log'::
 	This should make it easy to look up svn log messages when svn
-	users refer to -r/--revision numbers.
+	users refer to `-r`/`--revision` numbers.
 +
 The following features from `svn log' are supported:
 +
@@ -365,10 +365,10 @@ The following features from `svn log' are supported:
 	HEAD, NEXT, BASE, PREV, etc ...
 -v;;
 --verbose;;
-	it's not completely compatible with the --verbose
+	it's not completely compatible with the `--verbose`
 	output in svn log, but reasonably close.
 --limit=<n>;;
-	is NOT the same as --max-count, doesn't count
+	is NOT the same as `--max-count`, doesn't count
 	merged/excluded commits
 --incremental;;
 	supported
@@ -380,7 +380,7 @@ New features:
 --show-commit;;
 	shows the Git commit sha1, as well
 --oneline;;
-	our version of --pretty=oneline
+	our version of `--pretty=oneline`
 --
 +
 NOTE: SVN itself only stores times in UTC and nothing else. The regular svn
@@ -433,7 +433,7 @@ Any other arguments are passed directly to 'git log'
 'create-ignore'::
 	Recursively finds the svn:ignore property on directories and
 	creates matching .gitignore files. The resulting files are staged to
-	be committed, but are not committed. Use -r/--revision to refer to a
+	be committed, but are not committed. Use `-r`/`--revision` to refer to a
 	specific revision.
 
 'show-ignore'::
@@ -458,7 +458,7 @@ Any other arguments are passed directly to 'git log'
 	URL of the target Subversion repository.  The final argument
 	(URL) may be omitted if you are working from a 'git svn'-aware
 	repository (that has been `init`-ed with 'git svn').
-	The -r<revision> option is required for this.
+	The `-r<revision>` option is required for this.
 +
 The commit message is supplied either directly with the `-m` or `-F`
 option, or indirectly from the tag or commit when the second tree-ish
@@ -477,18 +477,18 @@ denotes such an object, or it is requested by invoking an editor (see
 
 'info'::
 	Shows information about a file or directory similar to what
-	`svn info' provides.  Does not currently support a -r/--revision
-	argument.  Use the --url option to output only the value of the
+	`svn info' provides.  Does not currently support a `-r`/`--revision`
+	argument.  Use the `--url` option to output only the value of the
 	'URL:' field.
 
 'proplist'::
 	Lists the properties stored in the Subversion repository about a
-	given file or directory.  Use -r/--revision to refer to a specific
+	given file or directory.  Use `-r`/`--revision` to refer to a specific
 	Subversion revision.
 
 'propget'::
 	Gets the Subversion property given as the first argument, for a
-	file.  A specific revision can be specified with -r/--revision.
+	file.  A specific revision can be specified with `-r`/`--revision`.
 
 'propset'::
 	Sets the Subversion property given as the first argument, to the
@@ -505,7 +505,7 @@ This will set the property 'svn:keywords' to 'FreeBSD=%H' for the file
 'devel/py-tipper/Makefile'.
 
 'show-externals'::
-	Shows the Subversion externals.  Use -r/--revision to specify a
+	Shows the Subversion externals.  Use `-r`/`--revision` to specify a
 	specific revision.
 
 'gc'::
@@ -517,10 +517,10 @@ This will set the property 'svn:keywords' to 'FreeBSD=%H' for the file
 	This allows you to re-'fetch' an SVN revision.  Normally the
 	contents of an SVN revision should never change and 'reset'
 	should not be necessary.  However, if SVN permissions change,
-	or if you alter your --ignore-paths option, a 'fetch' may fail
+	or if you alter your `--ignore-paths` option, a 'fetch' may fail
 	with "not found in commit" (file not previously visible) or
 	"checksum mismatch" (missed a modification).  If the problem
-	file cannot be ignored forever (with --ignore-paths) the only
+	file cannot be ignored forever (with `--ignore-paths`) the only
 	way to repair the repo is to use 'reset'.
 +
 Only the rev_map and refs/remotes/git-svn are changed (see
@@ -735,8 +735,8 @@ ADVANCED OPTIONS
 
 --follow-parent::
 	This option is only relevant if we are tracking branches (using
-	one of the repository layout options --trunk, --tags,
-	--branches, --stdlayout). For each tracked branch, try to find
+	one of the repository layout options `--trunk`, `--tags`,
+	`--branches`, `--stdlayout`). For each tracked branch, try to find
 	out where its revision was copied from, and set
 	a suitable parent in the first Git commit for the branch.
 	This is especially helpful when we're tracking a directory
@@ -747,7 +747,7 @@ ADVANCED OPTIONS
 	However, following long/convoluted histories can take a long
 	time, so disabling this feature may speed up the cloning
 	process. This feature is enabled by default, use
-	--no-follow-parent to disable it.
+	`--no-follow-parent` to disable it.
 +
 [verse]
 config key: svn.followparent
@@ -951,7 +951,7 @@ compatibility with SVN (see the CAVEATS section below).
 
 HANDLING OF SVN BRANCHES
 ------------------------
-If 'git svn' is configured to fetch branches (and --follow-branches
+If 'git svn' is configured to fetch branches (and `--follow-branches`
 is in effect), it sometimes creates multiple Git branches for one
 SVN branch, where the additional branches have names of the form
 'branchname@nnn' (with nnn an SVN revision number).  These additional
@@ -1031,14 +1031,14 @@ before 'dcommit' on will require forcing an overwrite of the existing ref
 on the remote repository.  This is generally considered bad practice,
 see the linkgit:git-push[1] documentation for details.
 
-Do not use the --amend option of linkgit:git-commit[1] on a change you've
-already dcommitted.  It is considered bad practice to --amend commits
+Do not use the `--amend` option of linkgit:git-commit[1] on a change you've
+already dcommitted.  It is considered bad practice to `--amend` commits
 you've already pushed to a remote repository for other users, and
 dcommit with SVN is analogous to that.
 
 When cloning an SVN repository, if none of the options for describing
-the repository layout is used (--trunk, --tags, --branches,
---stdlayout), 'git svn clone' will create a Git repository with
+the repository layout is used (`--trunk`, `--tags`, `--branches`,
+`--stdlayout`), 'git svn clone' will create a Git repository with
 completely linear history, where branches and tags appear as separate
 directories in the working copy.  While this is the easiest way to get a
 copy of a complete repository, for projects with many branches it will
@@ -1051,7 +1051,7 @@ without giving any repository layout options.  If the full history with
 branches and tags is required, the options `--trunk` / `--branches` /
 `--tags` must be used.
 
-When using multiple --branches or --tags, 'git svn' does not automatically
+When using multiple `--branches` or `--tags`, 'git svn' does not automatically
 handle name collisions (for example, if two branches from different paths have
 the same name, or if a branch and a tag have the same name).  In these cases,
 use 'init' to set up your Git repository then, before your first 'fetch', edit
@@ -1142,7 +1142,7 @@ Multiple fetch, branches, and tags keys are supported:
 ------------------------------------------------------------------------
 
 Creating a branch in such a configuration requires disambiguating which
-location to use using the -d or --destination flag:
+location to use using the `-d` or `--destination` flag:
 
 ------------------------------------------------------------------------
 $ git svn branch -d branches/server release-2-3-0
diff --git a/Documentation/git-tag.txt b/Documentation/git-tag.txt
index 31a97a1b6c..b802972bb2 100644
--- a/Documentation/git-tag.txt
+++ b/Documentation/git-tag.txt
@@ -111,7 +111,7 @@ options for details.
 
 --sort=<key>::
 	Sort based on the key given.  Prefix `-` to sort in
-	descending order of the value. You may use the --sort=<key> option
+	descending order of the value. You may use the `--sort=<key>` option
 	multiple times, in which case the last key becomes the primary
 	key. Also supports "version:refname" or "v:refname" (tag
 	names are treated as versions). The "version:refname" sort
@@ -236,7 +236,7 @@ On Re-tagging
 What should you do when you tag a wrong commit and you would
 want to re-tag?
 
-If you never pushed anything out, just re-tag it. Use "-f" to
+If you never pushed anything out, just re-tag it. Use `-f` to
 replace the old one. And you're done.
 
 But if you have pushed things out (or others could just read
diff --git a/Documentation/git-update-index.txt b/Documentation/git-update-index.txt
index 2853f168d9..936b64045e 100644
--- a/Documentation/git-update-index.txt
+++ b/Documentation/git-update-index.txt
@@ -56,21 +56,21 @@ OPTIONS
 	updates are needed by checking stat() information.
 
 -q::
-        Quiet.  If --refresh finds that the index needs an update, the
+        Quiet.  If `--refresh` finds that the index needs an update, the
         default behavior is to error out.  This option makes
 	'git update-index' continue anyway.
 
 --ignore-submodules::
 	Do not try to update submodules.  This option is only respected
-	when passed before --refresh.
+	when passed before `--refresh`.
 
 --unmerged::
-        If --refresh finds unmerged changes in the index, the default
+        If `--refresh` finds unmerged changes in the index, the default
 	behavior is to error out.  This option makes 'git update-index'
         continue anyway.
 
 --ignore-missing::
-	Ignores missing files during a --refresh
+	Ignores missing files during a `--refresh`
 
 --cacheinfo <mode>,<object>,<path>::
 --cacheinfo <mode> <object> <path>::
@@ -140,13 +140,13 @@ you will need to handle the situation manually.
 
 --force-remove::
 	Remove the file from the index even when the working directory
-	still has such a file. (Implies --remove.)
+	still has such a file. (Implies `--remove`.)
 
 --replace::
 	By default, when a file `path` exists in the index,
 	'git update-index' refuses an attempt to add `path/file`.
 	Similarly if a file `path/file` exists, a file `path`
-	cannot be added.  With --replace flag, existing entries
+	cannot be added.  With `--replace` flag, existing entries
 	that conflict with the entry being added are
 	automatically removed with warning messages.
 
diff --git a/Documentation/git-update-ref.txt b/Documentation/git-update-ref.txt
index 48b6683071..3c3da97c29 100644
--- a/Documentation/git-update-ref.txt
+++ b/Documentation/git-update-ref.txt
@@ -37,7 +37,7 @@ them and update them as a regular file (i.e. it will allow the
 filesystem to follow them, but will overwrite such a symlink to
 somewhere else with a regular filename).
 
-If --no-deref is given, <ref> itself is overwritten, rather than
+If `--no-deref` is given, <ref> itself is overwritten, rather than
 the result of following the symbolic pointers.
 
 In general, using
@@ -164,12 +164,12 @@ stored in <ref>, "newsha1" is the 40 character hexadecimal value of
 <newvalue> and "committer" is the committer's name, email address
 and date in the standard Git committer ident format.
 
-Optionally with -m:
+Optionally with `-m`:
 
     oldsha1 SP newsha1 SP committer TAB message LF
 
 Where all fields are as described above and "message" is the
-value supplied to the -m option.
+value supplied to the `-m` option.
 
 An update will fail (without changing <ref>) if the current user is
 unable to create a new log file, append to the existing log file
diff --git a/Documentation/git-verify-pack.txt b/Documentation/git-verify-pack.txt
index 61ca6d04c2..e1e537fcfb 100644
--- a/Documentation/git-verify-pack.txt
+++ b/Documentation/git-verify-pack.txt
@@ -38,7 +38,7 @@ OPTIONS
 
 OUTPUT FORMAT
 -------------
-When specifying the -v option the format used is:
+When specifying the `-v` option the format used is:
 
 	SHA-1 type size size-in-packfile offset-in-packfile
 
diff --git a/Documentation/git-web--browse.txt b/Documentation/git-web--browse.txt
index 8d162b56c5..d53b2570df 100644
--- a/Documentation/git-web--browse.txt
+++ b/Documentation/git-web--browse.txt
@@ -62,7 +62,7 @@ CONF.VAR (from -c option) and web.browser
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
 The web browser can be specified using a configuration variable passed
-with the -c (or --config) command-line option, or the `web.browser`
+with the `-c` (or `--config`) command-line option, or the `web.browser`
 configuration variable if the former is not used.
 
 browser.<tool>.path
diff --git a/Documentation/git-whatchanged.txt b/Documentation/git-whatchanged.txt
index 8b63ceb00e..798a43965b 100644
--- a/Documentation/git-whatchanged.txt
+++ b/Documentation/git-whatchanged.txt
@@ -35,7 +35,7 @@ Examples
 `git whatchanged --since="2 weeks ago" -- gitk`::
 
 	Show the changes during the last two weeks to the file 'gitk'.
-	The "--" is necessary to avoid confusion with the *branch* named
+	The `--` is necessary to avoid confusion with the *branch* named
 	'gitk'
 
 GIT
diff --git a/Documentation/git.txt b/Documentation/git.txt
index 3a9c44987f..fc49a4fd42 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -566,9 +566,9 @@ Git Commits
 Git Diffs
 ~~~~~~~~~
 `GIT_DIFF_OPTS`::
-	Only valid setting is "--unified=??" or "-u??" to set the
+	Only valid setting is `--unified=??` or `-u??` to set the
 	number of context lines shown when a unified diff is created.
-	This takes precedence over any "-U" or "--unified" option
+	This takes precedence over any `-U` or `--unified` option
 	value passed on the Git diff command line.
 
 `GIT_EXTERNAL_DIFF`::
diff --git a/Documentation/gitcore-tutorial.txt b/Documentation/gitcore-tutorial.txt
index c0b95256cc..633439702f 100644
--- a/Documentation/gitcore-tutorial.txt
+++ b/Documentation/gitcore-tutorial.txt
@@ -941,7 +941,7 @@ branch head.  Please see linkgit:gitrevisions[7] if you want to
 see more complex cases.
 
 [NOTE]
-Without the '--more=1' option, 'git show-branch' would not output the
+Without the `--more=1` option, 'git show-branch' would not output the
 '[master^]' commit, as '[mybranch]' commit is a common ancestor of
 both 'master' and 'mybranch' tips.  Please see linkgit:git-show-branch[1]
 for details.
diff --git a/Documentation/gitdiffcore.txt b/Documentation/gitdiffcore.txt
index 0d57f86abc..fbc458c3e5 100644
--- a/Documentation/gitdiffcore.txt
+++ b/Documentation/gitdiffcore.txt
@@ -55,7 +55,7 @@ is under consideration.
 
 The result of comparison is passed from these commands to what is
 internally called "diffcore", in a format similar to what is output
-when the -p option is not used.  E.g.
+when the `-p` option is not used.  E.g.
 
 ------------------------------------------------
 in-place edit  :100644 100644 bcd1234... 0123456... M file0
@@ -89,7 +89,7 @@ diffcore-break: For Splitting Up Complete Rewrites
 --------------------------------------------------
 
 The second transformation in the chain is diffcore-break, and is
-controlled by the -B option to the 'git diff-{asterisk}' commands.  This is
+controlled by the `-B` option to the 'git diff-{asterisk}' commands.  This is
 used to detect a filepair that represents "complete rewrite" and
 break such filepair into two filepairs that represent delete and
 create.  E.g.  If the input contained this filepair:
@@ -117,14 +117,14 @@ score defaults to 50% of the size of the smaller of the original
 and the result (i.e. if the edit shrinks the file, the size of
 the result is used; if the edit lengthens the file, the size of
 the original is used), and can be customized by giving a number
-after "-B" option (e.g. "-B75" to tell it to use 75%).
+after `-B` option (e.g. `-B75` to tell it to use 75%).
 
 
 diffcore-rename: For Detecting Renames and Copies
 -------------------------------------------------
 
 This transformation is used to detect renames and copies, and is
-controlled by the -M option (to detect renames) and the -C option
+controlled by the `-M` option (to detect renames) and the `-C` option
 (to detect copies as well) to the 'git diff-{asterisk}' commands.  If the
 input contained these filepairs:
 
@@ -141,9 +141,9 @@ merges these filepairs and creates:
 :100644 100644 0123456... 0123456... R100 fileX file0
 ------------------------------------------------
 
-When the "-C" option is used, the original contents of modified files,
+When the `-C` option is used, the original contents of modified files,
 and deleted files (and also unmodified files, if the
-"--find-copies-harder" option is used) are considered as candidates
+`--find-copies-harder` option is used) are considered as candidates
 of the source files in rename/copy operation.  If the input were like
 these filepairs, that talk about a modified file fileY and a newly
 created file file0:
@@ -166,7 +166,7 @@ In both rename and copy detection, the same "extent of changes"
 algorithm used in diffcore-break is used to determine if two
 files are "similar enough", and can be customized to use
 a similarity score different from the default of 50% by giving a
-number after the "-M" or "-C" option (e.g. "-M8" to tell it to use
+number after the `-M` or `-C` option (e.g. `-M8` to tell it to use
 8/10 = 80%).
 
 Note that when rename detection is on but both copy and break
@@ -189,7 +189,7 @@ preliminary pass; so if there are several remaining ext.txt files
 throughout the directory hierarchy after exact rename detection, this
 preliminary step may be skipped for those files.
 
-Note.  When the "-C" option is used with `--find-copies-harder`
+Note.  When the `-C` option is used with `--find-copies-harder`
 option, 'git diff-{asterisk}' commands feed unmodified filepairs to
 diffcore mechanism as well as modified ones.  This lets the copy
 detector consider unmodified files as copy source candidates at
@@ -222,13 +222,13 @@ transformation merges them back into the original
 The "extent of changes" parameter can be tweaked from the
 default 80% (that is, unless more than 80% of the original
 material is deleted, the broken pairs are merged back into a
-single modification) by giving a second number to -B option,
+single modification) by giving a second number to `-B` option,
 like these:
 
-* -B50/60 (give 50% "break score" to diffcore-break, use 60%
+* `-B50/60` (give 50% "break score" to diffcore-break, use 60%
   for diffcore-merge-broken).
 
-* -B/60 (the same as above, since diffcore-break defaults to 50%).
+* `-B/60` (the same as above, since diffcore-break defaults to 50%).
 
 Note that earlier implementation left a broken pair as a separate
 creation and deletion patches.  This was an unnecessary hack and
@@ -245,10 +245,10 @@ diffcore-pickaxe: For Detecting Addition/Deletion of Specified String
 
 This transformation limits the set of filepairs to those that change
 specified strings between the preimage and the postimage in a certain
-way.  -S<block of text> and -G<regular expression> options are used to
+way.  `-S<block of text>` and `-G<regular expression>` options are used to
 specify different ways these strings are sought.
 
-"-S<block of text>" detects filepairs whose preimage and postimage
+`-S<block of text>` detects filepairs whose preimage and postimage
 have different number of occurrences of the specified block of text.
 By definition, it will not detect in-file moves.  Also, when a
 changeset moves a file wholesale without affecting the interesting
@@ -258,7 +258,7 @@ rename-detected filepair).  When used with `--pickaxe-regex`, treat
 the <block of text> as an extended POSIX regular expression to match,
 instead of a literal string.
 
-"-G<regular expression>" (mnemonic: grep) detects filepairs whose
+`-G<regular expression>` (mnemonic: grep) detects filepairs whose
 textual diff has an added or a deleted line that matches the given
 regular expression.  This means that it will detect in-file (or what
 rename-detection considers the same file) moves, which is noise.  The
@@ -277,7 +277,7 @@ diffcore-order: For Sorting the Output Based on Filenames
 ---------------------------------------------------------
 
 This is used to reorder the filepairs according to the user's
-(or project's) taste, and is controlled by the -O option to the
+(or project's) taste, and is controlled by the `-O` option to the
 'git diff-{asterisk}' commands.
 
 This takes a text file each of whose lines is a shell glob
diff --git a/Documentation/gitk.txt b/Documentation/gitk.txt
index d50e9ed10e..6ceeae227c 100644
--- a/Documentation/gitk.txt
+++ b/Documentation/gitk.txt
@@ -112,7 +112,7 @@ include::line-range-options.txt[]
 <path>...::
 
 	Limit commits to the ones touching files in the given paths. Note, to
-	avoid ambiguity with respect to revision names use "--" to separate the paths
+	avoid ambiguity with respect to revision names use `--` to separate the paths
 	from any preceding options.
 
 gitk-specific options
@@ -130,7 +130,7 @@ gitk-specific options
 --select-commit=<ref>::
 
 	Select the specified commit after loading the graph.
-	Default behavior is equivalent to specifying '--select-commit=HEAD'.
+	Default behavior is equivalent to specifying `--select-commit=HEAD`.
 
 Examples
 --------
@@ -142,7 +142,7 @@ gitk v2.6.12.. include/scsi drivers/scsi::
 gitk --since="2 weeks ago" \-- gitk::
 
 	Show the changes during the last two weeks to the file 'gitk'.
-	The "--" is necessary to avoid confusion with the *branch* named
+	The `--` is necessary to avoid confusion with the *branch* named
 	'gitk'
 
 gitk --max-count=100 --all \-- Makefile::
diff --git a/Documentation/gittutorial-2.txt b/Documentation/gittutorial-2.txt
index 8bdb7d0bd3..e1e09070ad 100644
--- a/Documentation/gittutorial-2.txt
+++ b/Documentation/gittutorial-2.txt
@@ -318,7 +318,7 @@ index a042389..513feba 100644
 ------------------------------------------------
 
 At any time, we can create a new commit using 'git commit' (without
-the "-a" option), and verify that the state committed only includes the
+the `-a` option), and verify that the state committed only includes the
 changes stored in the index file, not the additional change that is
 still only in our working tree:
 
@@ -336,7 +336,7 @@ index 513feba..ba3da7b 100644
 ------------------------------------------------
 
 So by default 'git commit' uses the index to create the commit, not
-the working tree; the "-a" option to commit tells it to first update
+the working tree; the `-a` option to commit tells it to first update
 the index with all changes in the working tree.
 
 Finally, it's worth looking at the effect of 'git add' on the index
diff --git a/Documentation/gittutorial.txt b/Documentation/gittutorial.txt
index 59ef5cef1f..ff366cc752 100644
--- a/Documentation/gittutorial.txt
+++ b/Documentation/gittutorial.txt
@@ -95,13 +95,13 @@ $ git add file1 file2 file3
 ------------------------------------------------
 
 You are now ready to commit.  You can see what is about to be committed
-using 'git diff' with the --cached option:
+using 'git diff' with the `--cached` option:
 
 ------------------------------------------------
 $ git diff --cached
 ------------------------------------------------
 
-(Without --cached, 'git diff' will show you any changes that
+(Without `--cached`, 'git diff' will show you any changes that
 you've made but not yet added to the index.)  You can also get a brief
 summary of the situation with 'git status':
 
diff --git a/Documentation/gitweb.conf.txt b/Documentation/gitweb.conf.txt
index 7963a79ba9..181c543a64 100644
--- a/Documentation/gitweb.conf.txt
+++ b/Documentation/gitweb.conf.txt
@@ -459,14 +459,14 @@ $fallback_encoding::
 
 @diff_opts::
 	Rename detection options for git-diff and git-diff-tree. The default is
-	(\'-M'); set it to (\'-C') or (\'-C', \'-C') to also detect copies,
-	or set it to () i.e. empty list if you don't want to have renames
+	`('-M')`; set it to `('-C')` or `('-C', '-C')` to also detect copies,
+	or set it to `()` i.e. empty list if you don't want to have renames
 	detection.
 +
 *Note* that rename and especially copy detection can be quite
 CPU-intensive.  Note also that non Git tools can have problems with
 patches generated with options mentioned above, especially when they
-involve file copies (\'-C') or criss-cross renames (\'-B').
+involve file copies `('-C')` or criss-cross renames `('-B')`.
 
 
 Some optional features and policies
diff --git a/Documentation/howto/revert-branch-rebase.txt b/Documentation/howto/revert-branch-rebase.txt
index a3e5595a56..29b15a1173 100644
--- a/Documentation/howto/revert-branch-rebase.txt
+++ b/Documentation/howto/revert-branch-rebase.txt
@@ -54,7 +54,7 @@ since then.  I just limited the output to the first handful using
 Now I know 'master^2~4' (pronounce it as "find the second parent of
 the 'master', and then go four generations back following the first
 parent") is the one I would want to revert.  Since I also want to say
-why I am reverting it, the '-n' flag is given to 'git revert'.  This
+why I am reverting it, the `-n` flag is given to 'git revert'.  This
 prevents it from actually making a commit, and instead 'git revert'
 leaves the commit log message it wanted to use in '.msg' file:
 
diff --git a/Documentation/howto/setup-git-server-over-http.txt b/Documentation/howto/setup-git-server-over-http.txt
index bfe6f9b500..7a34937da0 100644
--- a/Documentation/howto/setup-git-server-over-http.txt
+++ b/Documentation/howto/setup-git-server-over-http.txt
@@ -163,7 +163,7 @@ Create this file by
       $ htpasswd -c /etc/apache2/passwd.git <user>
 
 You will be asked a password, and the file is created. Subsequent calls
-to htpasswd should omit the '-c' option, since you want to append to the
+to htpasswd should omit the `-c` option, since you want to append to the
 existing file.
 
 You need to restart Apache.
diff --git a/Documentation/merge-options.txt b/Documentation/merge-options.txt
index eb0aabd396..bf43c33d27 100644
--- a/Documentation/merge-options.txt
+++ b/Documentation/merge-options.txt
@@ -1,16 +1,16 @@
 --commit::
 --no-commit::
 	Perform the merge and commit the result. This option can
-	be used to override --no-commit.
+	be used to override `--no-commit`.
 +
-With --no-commit perform the merge and stop just before creating
+With `--no-commit` perform the merge and stop just before creating
 a merge commit, to give the user a chance to inspect and further
 tweak the merge result before committing.
 +
 Note that fast-forward updates do not create a merge commit and
-therefore there is no way to stop those merges with --no-commit.
+therefore there is no way to stop those merges with `--no-commit`.
 Thus, if you want to ensure your branch is not changed or updated
-by the merge command, use --no-ff with --no-commit.
+by the merge command, use `--no-ff` with `--no-commit`.
 
 --edit::
 -e::
@@ -74,7 +74,7 @@ When not possible, refuse to merge and exit with a non-zero status.
 	one-line descriptions from at most <n> actual commits that are being
 	merged. See also linkgit:git-fmt-merge-msg[1].
 +
-With --no-log do not list one-line descriptions from the
+With `--no-log` do not list one-line descriptions from the
 actual commits being merged.
 
 include::signoff-option.txt[]
@@ -85,7 +85,7 @@ include::signoff-option.txt[]
 	Show a diffstat at the end of the merge. The diffstat is also
 	controlled by the configuration option merge.stat.
 +
-With -n or --no-stat do not show a diffstat at the end of the
+With `-n` or `--no-stat` do not show a diffstat at the end of the
 merge.
 
 --squash::
@@ -98,10 +98,10 @@ merge.
 	the current branch whose effect is the same as merging another
 	branch (or more in case of an octopus).
 +
-With --no-squash perform the merge and commit the result. This
-option can be used to override --squash.
+With `--no-squash` perform the merge and commit the result. This
+option can be used to override `--squash`.
 +
-With --squash, --commit is not allowed, and will fail.
+With `--squash`, `--commit` is not allowed, and will fail.
 
 --no-verify::
 	This option bypasses the pre-merge and commit-msg hooks.
@@ -130,13 +130,13 @@ With --squash, --commit is not allowed, and will fail.
 
 --summary::
 --no-summary::
-	Synonyms to --stat and --no-stat; these are deprecated and will be
+	Synonyms to `--stat` and `--no-stat`; these are deprecated and will be
 	removed in the future.
 
 ifndef::git-pull[]
 -q::
 --quiet::
-	Operate quietly. Implies --no-progress.
+	Operate quietly. Implies `--no-progress`.
 
 -v::
 --verbose::
diff --git a/Documentation/pretty-formats.txt b/Documentation/pretty-formats.txt
index 45133066e4..d8a755faf1 100644
--- a/Documentation/pretty-formats.txt
+++ b/Documentation/pretty-formats.txt
@@ -93,8 +93,8 @@ confused as starting a new commit.
 +
 The 'raw' format shows the entire commit exactly as
 stored in the commit object.  Notably, the hashes are
-displayed in full, regardless of whether --abbrev or
---no-abbrev are used, and 'parents' information show the
+displayed in full, regardless of whether `--abbrev` or
+`--no-abbrev` are used, and 'parents' information show the
 true parent commits, without taking grafts or history
 simplification into account. Note that this format affects the way
 commits are displayed, but not the way the diff is shown e.g. with
@@ -144,7 +144,7 @@ The placeholders are:
 	    on the next placeholders until the color is switched
 	    again.
 '%m':: left (`<`), right (`>`) or boundary (`-`) mark
-'%w([<w>[,<i1>[,<i2>]]])':: switch line wrapping, like the -w option of
+'%w([<w>[,<i1>[,<i2>]]])':: switch line wrapping, like the `-w` option of
 			    linkgit:git-shortlog[1].
 '%<(<N>[,trunc|ltrunc|mtrunc])':: make the next placeholder take at
 				  least N columns, padding spaces on
@@ -183,7 +183,7 @@ The placeholders are:
 '%al':: author email local-part (the part before the '@' sign)
 '%aL':: author local-part (see '%al') respecting .mailmap, see
 	linkgit:git-shortlog[1] or linkgit:git-blame[1])
-'%ad':: author date (format respects --date= option)
+'%ad':: author date (format respects `--date=` option)
 '%aD':: author date, RFC2822 style
 '%ar':: author date, relative
 '%at':: author date, UNIX timestamp
@@ -199,14 +199,14 @@ The placeholders are:
 '%cl':: committer email local-part (the part before the '@' sign)
 '%cL':: committer local-part (see '%cl') respecting .mailmap, see
 	linkgit:git-shortlog[1] or linkgit:git-blame[1])
-'%cd':: committer date (format respects --date= option)
+'%cd':: committer date (format respects `--date=` option)
 '%cD':: committer date, RFC2822 style
 '%cr':: committer date, relative
 '%ct':: committer date, UNIX timestamp
 '%ci':: committer date, ISO 8601-like format
 '%cI':: committer date, strict ISO 8601 format
 '%cs':: committer date, short format (`YYYY-MM-DD`)
-'%d':: ref names, like the --decorate option of linkgit:git-log[1]
+'%d':: ref names, like the `--decorate` option of linkgit:git-log[1]
 '%D':: ref names without the " (", ")" wrapping.
 '%(describe[:options])':: human-readable name, like
 			  linkgit:git-describe[1]; empty string for
diff --git a/Documentation/pretty-options.txt b/Documentation/pretty-options.txt
index 27ddaf84a1..f8c61dd42e 100644
--- a/Documentation/pretty-options.txt
+++ b/Documentation/pretty-options.txt
@@ -6,7 +6,7 @@
 	'full', 'fuller', 'reference', 'email', 'raw', 'format:<string>'
 	and 'tformat:<string>'.  When '<format>' is none of the above,
 	and has '%placeholder' in it, it acts as if
-	'--pretty=tformat:<format>' were given.
+	`--pretty=tformat:<format>` were given.
 +
 See the "PRETTY FORMATS" section for some additional details for each
 format.  When '=<format>' part is omitted, it defaults to 'medium'.
@@ -17,19 +17,19 @@ configuration (see linkgit:git-config[1]).
 --abbrev-commit::
 	Instead of showing the full 40-byte hexadecimal commit object
 	name, show a prefix that names the object uniquely.
-	"--abbrev=<n>" (which also modifies diff output, if it is displayed)
+	`--abbrev=<n>` (which also modifies diff output, if it is displayed)
 	option can be used to specify the minimum length of the prefix.
 +
-This should make "--pretty=oneline" a whole lot more readable for
+This should make `--pretty=oneline` a whole lot more readable for
 people using 80-column terminals.
 
 --no-abbrev-commit::
 	Show the full 40-byte hexadecimal commit object name. This negates
 	`--abbrev-commit`, either explicit or implied by other options such
-	as "--oneline". It also overrides the `log.abbrevCommit` variable.
+	as `--oneline`. It also overrides the `log.abbrevCommit` variable.
 
 --oneline::
-	This is a shorthand for "--pretty=oneline --abbrev-commit"
+	This is a shorthand for `--pretty=oneline --abbrev-commit`
 	used together.
 
 --encoding=<encoding>::
@@ -73,21 +73,21 @@ to display.  The ref can specify the full refname when it begins
 with `refs/notes/`; when it begins with `notes/`, `refs/` and otherwise
 `refs/notes/` is prefixed to form a full name of the ref.
 +
-Multiple --notes options can be combined to control which notes are
-being displayed. Examples: "--notes=foo" will show only notes from
-"refs/notes/foo"; "--notes=foo --notes" will show both notes from
+Multiple `--notes` options can be combined to control which notes are
+being displayed. Examples: `--notes=foo` will show only notes from
+"refs/notes/foo"; `--notes=foo --notes` will show both notes from
 "refs/notes/foo" and from the default notes ref(s).
 
 --no-notes::
 	Do not show notes. This negates the above `--notes` option, by
 	resetting the list of notes refs from which notes are shown.
 	Options are parsed in the order given on the command line, so e.g.
-	"--notes --notes=foo --no-notes --notes=bar" will only show notes
+	`--notes --notes=foo --no-notes --notes=bar` will only show notes
 	from "refs/notes/bar".
 
 --show-notes[=<ref>]::
 --[no-]standard-notes::
-	These options are deprecated. Use the above --notes/--no-notes
+	These options are deprecated. Use the above `--notes`/`--no-notes`
 	options instead.
 endif::git-rev-list[]
 
diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
index b1c8f86c6e..965cb32f9c 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -885,38 +885,38 @@ ifdef::git-rev-list[]
 	blobs) from the list of printed objects.  The '<filter-spec>'
 	may be one of the following:
 +
-The form '--filter=blob:none' omits all blobs.
+The form `--filter=blob:none` omits all blobs.
 +
-The form '--filter=blob:limit=<n>[kmg]' omits blobs larger than n bytes
+The form `--filter=blob:limit=<n>[kmg]` omits blobs larger than n bytes
 or units.  n may be zero.  The suffixes k, m, and g can be used to name
 units in KiB, MiB, or GiB.  For example, 'blob:limit=1k' is the same
 as 'blob:limit=1024'.
 +
-The form '--filter=sparse:oid=<blob-ish>' uses a sparse-checkout
+The form `--filter=sparse:oid=<blob-ish>` uses a sparse-checkout
 specification contained in the blob (or blob-expression) '<blob-ish>'
 to omit blobs that would not be not required for a sparse checkout on
 the requested refs.
 +
-The form '--filter=tree:<depth>' omits all blobs and trees whose depth
+The form `--filter=tree:<depth>` omits all blobs and trees whose depth
 from the root tree is >= <depth> (minimum depth if an object is located
 at multiple depths in the commits traversed). <depth>=0 will not include
 any trees or blobs unless included explicitly in the command-line (or
-standard input when --stdin is used). <depth>=1 will include only the
+standard input when `--stdin` is used). <depth>=1 will include only the
 tree and blobs which are referenced directly by a commit reachable from
 <commit> or an explicitly-given object. <depth>=2 is like <depth>=1
 while also including trees and blobs one more level removed from an
 explicitly-given commit or tree.
 +
-Note that the form '--filter=sparse:path=<path>' that wants to read
+Note that the form `--filter=sparse:path=<path>` that wants to read
 from an arbitrary path on the filesystem has been dropped for security
 reasons.
 +
-Multiple '--filter=' flags can be specified to combine filters. Only
+Multiple `--filter=` flags can be specified to combine filters. Only
 objects which are accepted by every filter are included.
 +
-The form '--filter=combine:<filter1>+<filter2>+...<filterN>' can also be
+The form `--filter=combine:<filter1>+<filter2>+...<filterN>` can also be
 used to combined several filters, but this is harder than just repeating
-the '--filter' flag and is usually not necessary. Filters are joined by
+the `--filter` flag and is usually not necessary. Filters are joined by
 '{plus}' and individual filters are %-encoded (i.e. URL-encoded).
 Besides the '{plus}' and '%' characters, the following characters are
 reserved and also must be encoded: `~!@#$^&*()[]{}\;",<>?`+&#39;&#96;+
@@ -938,18 +938,18 @@ equivalent.
 	A debug option to help with future "partial clone" development.
 	This option specifies how missing objects are handled.
 +
-The form '--missing=error' requests that rev-list stop with an error if
+The form `--missing=error` requests that rev-list stop with an error if
 a missing object is encountered.  This is the default action.
 +
-The form '--missing=allow-any' will allow object traversal to continue
+The form `--missing=allow-any` will allow object traversal to continue
 if a missing object is encountered.  Missing objects will silently be
 omitted from the results.
 +
-The form '--missing=allow-promisor' is like 'allow-any', but will only
+The form `--missing=allow-promisor` is like 'allow-any', but will only
 allow object traversal to continue for EXPECTED promisor missing objects.
 Unexpected missing objects will raise an error.
 +
-The form '--missing=print' is like 'allow-any', but will also print a
+The form `--missing=print` is like 'allow-any', but will also print a
 list of the missing objects.  Object IDs are prefixed with a ``?'' character.
 
 --exclude-promisor-objects::
@@ -1113,7 +1113,7 @@ This implies the `--topo-order` option by default, but the
 `--date-order` option may also be specified.
 
 --show-linear-break[=<barrier>]::
-	When --graph is not used, all history branches are flattened
+	When `--graph` is not used, all history branches are flattened
 	which can make it hard to see that the two consecutive commits
 	do not belong to a linear branch. This option puts a barrier
 	in between them in that case. If `<barrier>` is specified, it
diff --git a/Documentation/signoff-option.txt b/Documentation/signoff-option.txt
index 12aa2333e4..597d057c6e 100644
--- a/Documentation/signoff-option.txt
+++ b/Documentation/signoff-option.txt
@@ -14,5 +14,5 @@ endif::git-commit[]
 	leadership of the project to which you're contributing to
 	understand how the signoffs are used in that project.
 +
-The --no-signoff option can be used to countermand an earlier --signoff
+The `--no-signoff` option can be used to countermand an earlier `--signoff`
 option on the command line.
diff --git a/Documentation/urls.txt b/Documentation/urls.txt
index 1c229d7581..c50ddd3120 100644
--- a/Documentation/urls.txt
+++ b/Documentation/urls.txt
@@ -44,13 +44,13 @@ syntaxes may be used:
 
 ifndef::git-clone[]
 These two syntaxes are mostly equivalent, except when cloning, when
-the former implies --local option. See linkgit:git-clone[1] for
+the former implies `--local` option. See linkgit:git-clone[1] for
 details.
 endif::git-clone[]
 
 ifdef::git-clone[]
 These two syntaxes are mostly equivalent, except the former implies
---local option.
+`--local` option.
 endif::git-clone[]
 
 'git clone', 'git fetch' and 'git pull', but not 'git push', will also
diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
index fd480b8645..0f9a699c09 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -293,7 +293,7 @@ ref: refs/heads/master
 === Examining an old version without creating a new branch
 
 The `git switch` command normally expects a branch head, but will also
-accept an arbitrary commit when invoked with --detach; for example,
+accept an arbitrary commit when invoked with `--detach`; for example,
 you can check out the commit referenced by a tag:
 
 ------------------------------------------------
@@ -305,7 +305,7 @@ changes and commit them, and you can discard any commits you make in this
 state without impacting any branches by performing another switch.
 
 If you want to create a new branch to retain commits you create, you may
-do so (now or later) by using -c with the switch command again. Example:
+do so (now or later) by using `-c` with the switch command again. Example:
 
   git switch -c new_branch_name
 
-- 
2.31.1.133.g84d06cdc06

