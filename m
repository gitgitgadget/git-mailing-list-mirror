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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A4BDC433B4
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 04:06:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C88C610A4
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 04:06:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231642AbhDIEGv (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Apr 2021 00:06:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231402AbhDIEGG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Apr 2021 00:06:06 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CAECC061763
        for <git@vger.kernel.org>; Thu,  8 Apr 2021 21:05:53 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id s7so4080794wru.6
        for <git@vger.kernel.org>; Thu, 08 Apr 2021 21:05:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sVwrnSj3Pi43f9ArHmCX2+gNNiRFo/gJAIhlCWQGafQ=;
        b=FjMlSvRvloyPRMEE9OlwsB8zT6YN1Gh0Waux1gGe1DHhy9ZpRfQXHC6Nzii/Lpk+pq
         uIo6HxV04EA2RIemOvTaWkYQ2E93nnHK+ad/ldSG859MjbCqbcdumpJCeufDKG+EQk0p
         oxMgVaPe0osTIoJsjY/kGrPG+0XEgDdbomYKQvNLcph562XAYz9lIHBNVFSMu1Wjzq1C
         gLk+8vkdU9nPmWha0rrrSUZSSgTWp0uN3sGSlvJqTKoZL62ZIzpPebN+oVTK7gVpC9i6
         YCZMFuQ7GfZsdUyv97FLWBKAgdiL0mvy2l0kFgDtFWD6oPJjOru8gwV1OxKMNaJDRy4k
         /ZvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sVwrnSj3Pi43f9ArHmCX2+gNNiRFo/gJAIhlCWQGafQ=;
        b=YafEg8pVlltES8VX+dlCdeiQhsuPzyXB9J+9aE5PrPWnrjZYEOfFS7we9QJ8AMR03x
         UA75m29nNW1HyoAi/JKAyrwb6LZBorFh15sVYgokbKwjbzZe4ydCTTanX4kMPNdZ9hJO
         m+hmhxrEp5duuzBLn8TTcV2/zyPomCS4FKZ/khjTMLXjd05jx9xWpXIbeovM69Ldw/Rw
         GxrUrsMx6v3UKiRAuVWqtj38NnNhVmIr6sPXY9ojP0RyZzNVkj9G6ABK3fNa/N6d/JQL
         hS+xBonn2VyMYJUGfAA9m0S5T61HMCkE65QgYqOObOW/rFJ2zCfkm5+etKvPDC6HjmLd
         0zow==
X-Gm-Message-State: AOAM531TPDbSHVaeWJbMYdcb44F14aXLBKUDlCRBnMjO28iu3KvffObB
        T07oGxXeWo8U4qetCUwVLTnpn/VxhIVKPQ==
X-Google-Smtp-Source: ABdhPJwg6LidlSgk2Vp1+LN+QRRtgXM85cstdzX+j8J6wTNbJgXWGy3IngIpWo+t9/84yk6iSWM8Ag==
X-Received: by 2002:a05:6000:1204:: with SMTP id e4mr15723838wrx.266.1617941149381;
        Thu, 08 Apr 2021 21:05:49 -0700 (PDT)
Received: from Inspiron.home (2a01cb04010c420080e637770dc2ae3c.ipv6.abo.wanadoo.fr. [2a01:cb04:10c:4200:80e6:3777:dc2:ae3c])
        by smtp.gmail.com with ESMTPSA id c9sm2064636wrr.78.2021.04.08.21.05.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Apr 2021 21:05:47 -0700 (PDT)
From:   Firmin Martin <firminmartin24@gmail.com>
To:     git@vger.kernel.org
Cc:     Firmin Martin <firminmartin24@gmail.com>
Subject: [RFC PATCH v1 09/13] doc: typeset command/option/value entries in monospace
Date:   Fri,  9 Apr 2021 06:02:57 +0200
Message-Id: <20210409040301.3260358-10-firminmartin24@gmail.com>
X-Mailer: git-send-email 2.31.1.133.g84d06cdc06
In-Reply-To: <20210409040301.3260358-1-firminmartin24@gmail.com>
References: <20210409040301.3260358-1-firminmartin24@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Automatically wrap command-line option entries (i.e. something of the form
<entry>[::|;;]<description>) with backticks as indicated in the
CodingGuidelines. As an intended side effect, also wrap with backticks
some configuration options and values entries.

The following command and regex has performed the whole substitution
(without manual intervention).

    REGEX="^([[:space:]]*?)[\"']?([][a-zA-Z-=<>]+)[\"']?(::|;;)([[:space:]]+|\$)" &&
    perl -pi -e "s/$REGEX/\$1\`\$2\`\$3\$4/g" $(grep -Pl "$REGEX" *.txt --exclude-dir=RelNotes)

Signed-off-by: Firmin Martin <firminmartin24@gmail.com>
---
 Documentation/blame-options.txt          |  30 +--
 Documentation/config.txt                 |  12 +-
 Documentation/diff-options.txt           | 222 +++++++++++------------
 Documentation/fetch-options.txt          |  88 ++++-----
 Documentation/git-add.txt                |  66 +++----
 Documentation/git-am.txt                 |  82 ++++-----
 Documentation/git-apply.txt              |  60 +++---
 Documentation/git-archimport.txt         |  12 +-
 Documentation/git-archive.txt            |  30 +--
 Documentation/git-bisect.txt             |   4 +-
 Documentation/git-blame.txt              |  22 +--
 Documentation/git-branch.txt             |  88 ++++-----
 Documentation/git-bundle.txt             |  14 +-
 Documentation/git-cat-file.txt           |  36 ++--
 Documentation/git-check-attr.txt         |  14 +-
 Documentation/git-check-ignore.txt       |   6 +-
 Documentation/git-check-mailmap.txt      |   2 +-
 Documentation/git-check-ref-format.txt   |   6 +-
 Documentation/git-checkout-index.txt     |  28 +--
 Documentation/git-checkout.txt           |  66 +++----
 Documentation/git-cherry-pick.txt        |  42 ++---
 Documentation/git-cherry.txt             |   8 +-
 Documentation/git-clean.txt              |  30 +--
 Documentation/git-clone.txt              |  58 +++---
 Documentation/git-commit-graph.txt       |   8 +-
 Documentation/git-commit-tree.txt        |   8 +-
 Documentation/git-commit.txt             | 106 +++++------
 Documentation/git-config.txt             |  60 +++---
 Documentation/git-count-objects.txt      |   8 +-
 Documentation/git-cvsexportcommit.txt    |  24 +--
 Documentation/git-cvsimport.txt          |  16 +-
 Documentation/git-cvsserver.txt          |  16 +-
 Documentation/git-daemon.txt             |  66 +++----
 Documentation/git-describe.txt           |  24 +--
 Documentation/git-diff-files.txt         |   6 +-
 Documentation/git-diff-index.txt         |   8 +-
 Documentation/git-diff-tree.txt          |  28 +--
 Documentation/git-difftool.txt           |  28 +--
 Documentation/git-fast-export.txt        |  28 +--
 Documentation/git-fast-import.txt        |  56 +++---
 Documentation/git-fetch-pack.txt         |  36 ++--
 Documentation/git-fetch.txt              |  12 +-
 Documentation/git-filter-branch.txt      |   6 +-
 Documentation/git-fmt-merge-msg.txt      |   6 +-
 Documentation/git-for-each-ref.txt       |  54 +++---
 Documentation/git-format-patch.txt       |  86 ++++-----
 Documentation/git-fsck.txt               |  28 +--
 Documentation/git-gc.txt                 |  14 +-
 Documentation/git-grep.txt               | 126 ++++++-------
 Documentation/git-gui.txt                |   8 +-
 Documentation/git-hash-object.txt        |  12 +-
 Documentation/git-help.txt               |  26 +--
 Documentation/git-http-backend.txt       |   2 +-
 Documentation/git-http-fetch.txt         |  12 +-
 Documentation/git-http-push.txt          |  12 +-
 Documentation/git-imap-send.txt          |  12 +-
 Documentation/git-index-pack.txt         |  24 +--
 Documentation/git-init.txt               |  10 +-
 Documentation/git-instaweb.txt           |  32 ++--
 Documentation/git-interpret-trailers.txt |  20 +-
 Documentation/git-log.txt                |  18 +-
 Documentation/git-ls-files.txt           |  82 ++++-----
 Documentation/git-ls-remote.txt          |  28 +--
 Documentation/git-ls-tree.txt            |  24 +--
 Documentation/git-mailinfo.txt           |  22 +--
 Documentation/git-mailsplit.txt          |  16 +-
 Documentation/git-maintenance.txt        |  30 +--
 Documentation/git-merge-base.txt         |  12 +-
 Documentation/git-merge-file.txt         |  10 +-
 Documentation/git-merge-index.txt        |   6 +-
 Documentation/git-merge.txt              |  16 +-
 Documentation/git-mergetool.txt          |  18 +-
 Documentation/git-mktag.txt              |   2 +-
 Documentation/git-mktree.txt             |   6 +-
 Documentation/git-multi-pack-index.txt   |  14 +-
 Documentation/git-mv.txt                 |  14 +-
 Documentation/git-name-rev.txt           |  16 +-
 Documentation/git-notes.txt              |  56 +++---
 Documentation/git-p4.txt                 |  38 ++--
 Documentation/git-pack-objects.txt       |  74 ++++----
 Documentation/git-pack-redundant.txt     |   6 +-
 Documentation/git-pack-refs.txt          |   4 +-
 Documentation/git-patch-id.txt           |   4 +-
 Documentation/git-prune-packed.txt       |   8 +-
 Documentation/git-prune.txt              |  10 +-
 Documentation/git-pull.txt               |  12 +-
 Documentation/git-push.txt               |  76 ++++----
 Documentation/git-quiltimport.txt        |   6 +-
 Documentation/git-range-diff.txt         |  10 +-
 Documentation/git-read-tree.txt          |  34 ++--
 Documentation/git-rebase.txt             | 114 ++++++------
 Documentation/git-reflog.txt             |  20 +-
 Documentation/git-remote.txt             |  26 +--
 Documentation/git-repack.txt             |  48 ++---
 Documentation/git-replace.txt            |  14 +-
 Documentation/git-request-pull.txt       |   8 +-
 Documentation/git-rerere.txt             |  10 +-
 Documentation/git-reset.txt              |  22 +--
 Documentation/git-restore.txt            |  48 ++---
 Documentation/git-rev-parse.txt          |  82 ++++-----
 Documentation/git-revert.txt             |  32 ++--
 Documentation/git-rm.txt                 |  22 +--
 Documentation/git-send-email.txt         |  84 ++++-----
 Documentation/git-send-pack.txt          |  26 +--
 Documentation/git-sh-i18n.txt            |   2 +-
 Documentation/git-sh-setup.txt           |   4 +-
 Documentation/git-shortlog.txt           |  20 +-
 Documentation/git-show-branch.txt        |  38 ++--
 Documentation/git-show-ref.txt           |  24 +--
 Documentation/git-sparse-checkout.txt    |  12 +-
 Documentation/git-stash.txt              |  40 ++--
 Documentation/git-status.txt             |  42 ++---
 Documentation/git-stripspace.txt         |   8 +-
 Documentation/git-submodule.txt          |  56 +++---
 Documentation/git-svn.txt                | 150 +++++++--------
 Documentation/git-switch.txt             |  46 ++---
 Documentation/git-symbolic-ref.txt       |  12 +-
 Documentation/git-tag.txt                |  62 +++----
 Documentation/git-unpack-objects.txt     |  10 +-
 Documentation/git-update-index.txt       |  62 +++----
 Documentation/git-update-ref.txt         |  18 +-
 Documentation/git-upload-pack.txt        |  10 +-
 Documentation/git-var.txt                |   2 +-
 Documentation/git-verify-commit.txt      |   6 +-
 Documentation/git-verify-pack.txt        |   8 +-
 Documentation/git-verify-tag.txt         |   6 +-
 Documentation/git-worktree.txt           |  44 ++---
 Documentation/git-write-tree.txt         |   2 +-
 Documentation/git.txt                    |  66 +++----
 Documentation/gitattributes.txt          |  42 ++---
 Documentation/gitcli.txt                 |   4 +-
 Documentation/gitcore-tutorial.txt       |   2 +-
 Documentation/gitcredentials.txt         |  10 +-
 Documentation/githooks.txt               |   2 +-
 Documentation/gitk.txt                   |  28 +--
 Documentation/gitmodules.txt             |   8 +-
 Documentation/gitremote-helpers.txt      |  38 ++--
 Documentation/gitrepository-layout.txt   |  32 ++--
 Documentation/gitweb.conf.txt            |  34 ++--
 Documentation/gitweb.txt                 |  44 ++---
 Documentation/glossary-content.txt       |  12 +-
 Documentation/merge-options.txt          |  70 +++----
 Documentation/merge-strategies.txt       |  36 ++--
 Documentation/pretty-options.txt         |  28 +--
 Documentation/rev-list-options.txt       | 204 ++++++++++-----------
 Documentation/sequencer.txt              |   8 +-
 Documentation/signoff-option.txt         |   6 +-
 147 files changed, 2320 insertions(+), 2320 deletions(-)

diff --git a/Documentation/blame-options.txt b/Documentation/blame-options.txt
index 1d36a176bb..c58d30a648 100644
--- a/Documentation/blame-options.txt
+++ b/Documentation/blame-options.txt
@@ -1,12 +1,12 @@
--b::
+`-b`::
 	Show blank SHA-1 for boundary commits.  This can also
 	be controlled via the `blame.blankBoundary` config option.
 
---root::
+`--root`::
 	Do not treat root commits as boundaries.  This can also be
 	controlled via the `blame.showRoot` config option.
 
---show-stats::
+`--show-stats`::
 	Include additional statistics at the end of blame output.
 
 -L <start>,<end>::
@@ -20,10 +20,10 @@
 +
 include::line-range-format.txt[]
 
--l::
+`-l`::
 	Show long rev (Default: off).
 
--t::
+`-t`::
 	Show raw timestamp (Default: off).
 
 -S <revs-file>::
@@ -37,26 +37,26 @@ include::line-range-format.txt[]
 	START.  `git blame --reverse START` is taken as `git blame
 	--reverse START..HEAD` for convenience.
 
---first-parent::
+`--first-parent`::
 	Follow only the first parent commit upon seeing a merge
 	commit. This option can be used to determine when a line
 	was introduced to a particular integration branch, rather
 	than when it was introduced to the history overall.
 
--p::
---porcelain::
+`-p`::
+`--porcelain`::
 	Show in a format designed for machine consumption.
 
---line-porcelain::
+`--line-porcelain`::
 	Show the porcelain format, but output commit information for
 	each line, not just the first time a commit is referenced.
 	Implies `--porcelain`.
 
---incremental::
+`--incremental`::
 	Show the result incrementally in a format designed for
 	machine consumption.
 
---encoding=<encoding>::
+`--encoding=<encoding>`::
 	Specifies the encoding used to output author names
 	and commit summaries. Setting it to `none` makes blame
 	output unconverted data. For more information see the
@@ -77,14 +77,14 @@ include::line-range-format.txt[]
 	iso format is used. For supported values, see the discussion
 	of the `--date` option at linkgit:git-log[1].
 
---[no-]progress::
+`--[no-]progress`::
 	Progress status is reported on the standard error stream
 	by default when it is attached to a terminal. This flag
 	enables progress reporting even if not attached to a
 	terminal. Can't use `--progress` together with `--porcelain`
 	or `--incremental`.
 
--M[<num>]::
+`-M[<num>]`::
 	Detect moved or copied lines within a file. When a commit
 	moves or copies a block of lines (e.g. the original file
 	has A and then B, and the commit changes it to B and then
@@ -100,7 +100,7 @@ alphanumeric characters that Git must detect as moving/copying
 within a file for it to associate those lines with the parent
 commit. The default value is 20.
 
--C[<num>]::
+`-C[<num>]`::
 	In addition to `-M`, detect lines moved or copied from other
 	files that were modified in the same commit.  This is
 	useful when you reorganize your program and move code
@@ -136,5 +136,5 @@ take effect.
 	option.  An empty file name, `""`, will clear the list of revs from
 	previously processed files.
 
--h::
+`-h`::
 	Show help message.
diff --git a/Documentation/config.txt b/Documentation/config.txt
index 68529ad9db..6f83ce52a2 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -235,29 +235,29 @@ Values of many variables are treated as a simple string, but there
 are variables that take values of specific types and there are rules
 as to how to spell them.
 
-boolean::
+`boolean`::
 
        When a variable is said to take a boolean value, many
        synonyms are accepted for 'true' and 'false'; these are all
        case-insensitive.
 
-	true;; Boolean true literals are `yes`, `on`, `true`,
+	`true`;; Boolean true literals are `yes`, `on`, `true`,
 		and `1`.  Also, a variable defined without `= <value>`
 		is taken as true.
 
-	false;; Boolean false literals are `no`, `off`, `false`,
+	`false`;; Boolean false literals are `no`, `off`, `false`,
 		`0` and the empty string.
 +
 When converting a value to its canonical form using the `--type=bool` type
 specifier, `git config` will ensure that the output is "true" or
 "false" (spelled in lowercase).
 
-integer::
+`integer`::
        The value for many variables that specify various sizes can
        be suffixed with `k`, `M`,... to mean "scale the number by
        1024", "by 1024x1024", etc.
 
-color::
+`color`::
        The value for a variable that takes a color is a list of
        colors (at most two, one for foreground and one for background)
        and attributes (as many as you want), separated by spaces.
@@ -292,7 +292,7 @@ output) is set to be painted with `bold` or some other attribute.
 However, custom log formats may do more complicated and layered
 coloring, and the negated forms may be useful there.
 
-pathname::
+`pathname`::
 	A variable that takes a pathname value can be given a
 	string that begins with "`~/`" or "`~user/`", and the usual
 	tilde expansion happens to such a string: `~/`
diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index 34570aa445..1b594732aa 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -13,29 +13,29 @@ endif::git-diff[]
 endif::git-format-patch[]
 
 ifdef::git-format-patch[]
--p::
---no-stat::
+`-p`::
+`--no-stat`::
 	Generate plain patches without any diffstats.
 endif::git-format-patch[]
 
 ifndef::git-format-patch[]
--p::
--u::
---patch::
+`-p`::
+`-u`::
+`--patch`::
 	Generate patch (see section on generating patches).
 ifdef::git-diff[]
 	This is the default.
 endif::git-diff[]
 
--s::
---no-patch::
+`-s`::
+`--no-patch`::
 	Suppress diff output. Useful for commands like `git show` that
 	show the patch by default, or to cancel the effect of `--patch`.
 endif::git-format-patch[]
 
 ifdef::git-log[]
 --diff-merges=(off|none|first-parent|1|separate|m|combined|c|dense-combined|cc)::
---no-diff-merges::
+`--no-diff-merges`::
 	Specify diff format to be used for merge commits. Default is
 	{diff-merges-default} unless `--first-parent` is in use, in which case
 	`first-parent` is the default.
@@ -76,7 +76,7 @@ ifdef::git-log[]
 	two variants and the merge result picks one of them without
 	modification.  `--cc` implies `-p`.
 
---combined-all-paths::
+`--combined-all-paths`::
 	This flag causes combined diffs (used for merge commits) to
 	list the name of the file from all parents.  It thus only has
 	effect when `--diff-merges=[dense-]combined` is in use, and
@@ -84,26 +84,26 @@ ifdef::git-log[]
 	when either rename or copy detection have been requested).
 endif::git-log[]
 
--U<n>::
---unified=<n>::
+`-U<n>`::
+`--unified=<n>`::
 	Generate diffs with <n> lines of context instead of
 	the usual three.
 ifndef::git-format-patch[]
 	Implies `--patch`.
 endif::git-format-patch[]
 
---output=<file>::
+`--output=<file>`::
 	Output to a specific file instead of stdout.
 
---output-indicator-new=<char>::
---output-indicator-old=<char>::
---output-indicator-context=<char>::
+`--output-indicator-new=<char>`::
+`--output-indicator-old=<char>`::
+`--output-indicator-context=<char>`::
 	Specify the character used to indicate new, old or context
 	lines in the generated patch. Normally they are '+', '-' and
 	' ' respectively.
 
 ifndef::git-format-patch[]
---raw::
+`--raw`::
 ifndef::git-log[]
 	Generate the diff in raw format.
 ifdef::git-diff-core[]
@@ -120,33 +120,33 @@ endif::git-log[]
 endif::git-format-patch[]
 
 ifndef::git-format-patch[]
---patch-with-raw::
+`--patch-with-raw`::
 	Synonym for `-p --raw`.
 endif::git-format-patch[]
 
 ifdef::git-log[]
--t::
+`-t`::
 	Show the tree objects in the diff output.
 endif::git-log[]
 
---indent-heuristic::
+`--indent-heuristic`::
 	Enable the heuristic that shifts diff hunk boundaries to make patches
 	easier to read. This is the default.
 
---no-indent-heuristic::
+`--no-indent-heuristic`::
 	Disable the indent heuristic.
 
---minimal::
+`--minimal`::
 	Spend extra time to make sure the smallest possible
 	diff is produced.
 
---patience::
+`--patience`::
 	Generate a diff using the "patience diff" algorithm.
 
---histogram::
+`--histogram`::
 	Generate a diff using the "histogram diff" algorithm.
 
---anchored=<text>::
+`--anchored=<text>`::
 	Generate a diff using the "anchored diff" algorithm.
 +
 This option may be specified more than once.
@@ -194,7 +194,7 @@ have to use `--diff-algorithm=default` option.
 These parameters can also be set individually with `--stat-width=<width>`,
 `--stat-name-width=<name-width>` and `--stat-count=<count>`.
 
---compact-summary::
+`--compact-summary`::
 	Output a condensed summary of extended header information such
 	as file creations or deletions ("new" or "gone", optionally "+l"
 	if it's a symlink) and mode changes ("+x" or "-x" for adding
@@ -202,14 +202,14 @@ These parameters can also be set individually with `--stat-width=<width>`,
 	information is put between the filename part and the graph
 	part. Implies `--stat`.
 
---numstat::
+`--numstat`::
 	Similar to `--stat`, but shows number of added and
 	deleted lines in decimal notation and pathname without
 	abbreviation, to make it more machine friendly.  For
 	binary files, outputs two `-` instead of saying
 	`0 0`.
 
---shortstat::
+`--shortstat`::
 	Output only the last line of the `--stat` format containing total
 	number of modified files, as well as number of added and deleted
 	lines.
@@ -248,7 +248,7 @@ These parameters can also be set individually with `--stat-width=<width>`,
 	Note that when using `cumulative`, the sum of the percentages
 	reported may exceed 100%. The default (non-cumulative) behavior can
 	be specified with the `noncumulative` parameter.
-<limit>;;
+`<limit>`;;
 	An integer parameter specifies a cut-off percent (3% by default).
 	Directories contributing less than this percentage of the changes
 	are not shown in the output.
@@ -259,24 +259,24 @@ directories with less than 10% of the total amount of changed files,
 and accumulating child directory counts in the parent directories:
 `--dirstat=files,10,cumulative`.
 
---cumulative::
+`--cumulative`::
 	Synonym for --dirstat=cumulative
 
 --dirstat-by-file[=<param1,param2>...]::
 	Synonym for --dirstat=files,param1,param2...
 
---summary::
+`--summary`::
 	Output a condensed summary of extended header information
 	such as creations, renames and mode changes.
 
 ifndef::git-format-patch[]
---patch-with-stat::
+`--patch-with-stat`::
 	Synonym for `-p --stat`.
 endif::git-format-patch[]
 
 ifndef::git-format-patch[]
 
--z::
+`-z`::
 ifdef::git-log[]
 	Separate the commits with NULs instead of with new newlines.
 +
@@ -292,14 +292,14 @@ Without this option, pathnames with "unusual" characters are quoted as
 explained for the configuration variable `core.quotePath` (see
 linkgit:git-config[1]).
 
---name-only::
+`--name-only`::
 	Show only names of changed files.
 
---name-status::
+`--name-status`::
 	Show only names and status of changed files. See the description
 	of the `--diff-filter` option on what the status letters mean.
 
---submodule[=<format>]::
+`--submodule[=<format>]`::
 	Specify how differences in submodules are shown.  When specifying
 	`--submodule=short` the 'short' format is used.  This format just
 	shows the names of the commits at the beginning and end of the range.
@@ -311,7 +311,7 @@ linkgit:git-config[1]).
 	commit range.  Defaults to `diff.submodule` or the 'short' format
 	if the config option is unset.
 
---color[=<when>]::
+`--color[=<when>]`::
 	Show colored diff.
 	`--color` (i.e. without '=<when>') is the same as `--color=always`.
 	'<when>' can be one of `always`, `never`, or `auto`.
@@ -320,14 +320,14 @@ ifdef::git-diff[]
 	configuration settings.
 endif::git-diff[]
 
---no-color::
+`--no-color`::
 	Turn off colored diff.
 ifdef::git-diff[]
 	This can be used to override configuration settings.
 endif::git-diff[]
 	It is the same as `--color=never`.
 
---color-moved[=<mode>]::
+`--color-moved[=<mode>]`::
 	Moved lines of code are colored differently.
 ifdef::git-diff[]
 	It can be changed by the `diff.colorMoved` configuration setting.
@@ -337,40 +337,40 @@ endif::git-diff[]
 	The mode must be one of:
 +
 --
-no::
+`no`::
 	Moved lines are not highlighted.
-default::
+`default`::
 	Is a synonym for `zebra`. This may change to a more sensible mode
 	in the future.
-plain::
+`plain`::
 	Any line that is added in one location and was removed
 	in another location will be colored with `color.diff.newMoved`.
 	Similarly `color.diff.oldMoved` will be used for removed lines
 	that are added somewhere else in the diff. This mode picks up any
 	moved line, but it is not very useful in a review to determine
 	if a block of code was moved without permutation.
-blocks::
+`blocks`::
 	Blocks of moved text of at least 20 alphanumeric characters
 	are detected greedily. The detected blocks are
 	painted using either the `color.diff.{old,new}Moved` color.
 	Adjacent blocks cannot be told apart.
-zebra::
+`zebra`::
 	Blocks of moved text are detected as in 'blocks' mode. The blocks
 	are painted using either the `color.diff.{old,new}Moved` color or
 	`color.diff.{old,new}MovedAlternative`. The change between
 	the two colors indicates that a new block was detected.
-dimmed-zebra::
+`dimmed-zebra`::
 	Similar to 'zebra', but additional dimming of uninteresting parts
 	of moved code is performed. The bordering lines of two adjacent
 	blocks are considered interesting, the rest is uninteresting.
 	`dimmed_zebra` is a deprecated synonym.
 --
 
---no-color-moved::
+`--no-color-moved`::
 	Turn off move detection. This can be used to override configuration
 	settings. It is the same as `--color-moved=no`.
 
---color-moved-ws=<modes>::
+`--color-moved-ws=<modes>`::
 	This configures how whitespace is ignored when performing the
 	move detection for `--color-moved`.
 ifdef::git-diff[]
@@ -379,57 +379,57 @@ endif::git-diff[]
 	These modes can be given as a comma separated list:
 +
 --
-no::
+`no`::
 	Do not ignore whitespace when performing move detection.
-ignore-space-at-eol::
+`ignore-space-at-eol`::
 	Ignore changes in whitespace at EOL.
-ignore-space-change::
+`ignore-space-change`::
 	Ignore changes in amount of whitespace.  This ignores whitespace
 	at line end, and considers all other sequences of one or
 	more whitespace characters to be equivalent.
-ignore-all-space::
+`ignore-all-space`::
 	Ignore whitespace when comparing lines. This ignores differences
 	even if one line has whitespace where the other line has none.
-allow-indentation-change::
+`allow-indentation-change`::
 	Initially ignore any whitespace in the move detection, then
 	group the moved code blocks only into a block if the change in
 	whitespace is the same per line. This is incompatible with the
 	other modes.
 --
 
---no-color-moved-ws::
+`--no-color-moved-ws`::
 	Do not ignore whitespace when performing move detection. This can be
 	used to override configuration settings. It is the same as
 	`--color-moved-ws=no`.
 
---word-diff[=<mode>]::
+`--word-diff[=<mode>]`::
 	Show a word diff, using the <mode> to delimit changed words.
 	By default, words are delimited by whitespace; see
 	`--word-diff-regex` below.  The <mode> defaults to 'plain', and
 	must be one of:
 +
 --
-color::
+`color`::
 	Highlight changed words using only colors.  Implies `--color`.
-plain::
+`plain`::
 	Show words as `[-removed-]` and `{+added+}`.  Makes no
 	attempts to escape the delimiters if they appear in the input,
 	so the output may be ambiguous.
-porcelain::
+`porcelain`::
 	Use a special line-based format intended for script
 	consumption.  Added/removed/unchanged runs are printed in the
 	usual unified diff format, starting with a `+`/`-`/` `
 	character at the beginning of the line and extending to the
 	end of the line.  Newlines in the input are represented by a
 	tilde `~` on a line of its own.
-none::
+`none`::
 	Disable word diff again.
 --
 +
 Note that despite the name of the first mode, color is used to
 highlight the changed parts in all modes if enabled.
 
---word-diff-regex=<regex>::
+`--word-diff-regex=<regex>`::
 	Use <regex> to decide what a word is, instead of considering
 	runs of non-whitespace to be a word.  Also implies
 	`--word-diff` unless it was already enabled.
@@ -450,20 +450,20 @@ linkgit:gitattributes[5] or linkgit:git-config[1].  Giving it explicitly
 overrides any diff driver or configuration setting.  Diff drivers
 override configuration settings.
 
---color-words[=<regex>]::
+`--color-words[=<regex>]`::
 	Equivalent to `--word-diff=color` plus (if a regex was
 	specified) `--word-diff-regex=<regex>`.
 endif::git-format-patch[]
 
---no-renames::
+`--no-renames`::
 	Turn off rename detection, even when the configuration
 	file gives the default to do so.
 
---[no-]rename-empty::
+`--[no-]rename-empty`::
 	Whether to use empty blobs as rename source.
 
 ifndef::git-format-patch[]
---check::
+`--check`::
 	Warn if changes introduce conflict markers or whitespace errors.
 	What are considered whitespace errors is controlled by `core.whitespace`
 	configuration.  By default, trailing whitespaces (including
@@ -473,7 +473,7 @@ ifndef::git-format-patch[]
 	Exits with non-zero status if problems are found. Not compatible
 	with `--exit-code`.
 
---ws-error-highlight=<kind>::
+`--ws-error-highlight=<kind>`::
 	Highlight whitespace errors in the `context`, `old` or `new`
 	lines of the diff.  Multiple values are separated by comma,
 	`none` resets previous values, `default` reset the list to
@@ -485,19 +485,19 @@ ifndef::git-format-patch[]
 
 endif::git-format-patch[]
 
---full-index::
+`--full-index`::
 	Instead of the first handful of characters, show the full
 	pre- and post-image blob object names on the "index"
 	line when generating patch format output.
 
---binary::
+`--binary`::
 	In addition to `--full-index`, output a binary diff that
 	can be applied with `git-apply`.
 ifndef::git-format-patch[]
 	Implies `--patch`.
 endif::git-format-patch[]
 
---abbrev[=<n>]::
+`--abbrev[=<n>]`::
 	Instead of showing the full 40-byte hexadecimal object
 	name in diff-raw format output and diff-tree header
 	lines, show the shortest prefix that is at least '<n>'
@@ -530,8 +530,8 @@ addition and deletion compared to 20% or more of the file's size are
 eligible for being picked up as a possible source of a rename to
 another file.
 
--M[<n>]::
---find-renames[=<n>]::
+`-M[<n>]`::
+`--find-renames[=<n>]`::
 ifndef::git-log[]
 	Detect renames.
 endif::git-log[]
@@ -550,12 +550,12 @@ endif::git-log[]
 	the same as `-M5%`.  To limit detection to exact renames, use
 	`-M100%`.  The default similarity index is 50%.
 
--C[<n>]::
---find-copies[=<n>]::
+`-C[<n>]`::
+`--find-copies[=<n>]`::
 	Detect copies as well as renames.  See also `--find-copies-harder`.
 	If `n` is specified, it has the same meaning as for `-M<n>`.
 
---find-copies-harder::
+`--find-copies-harder`::
 	For performance reasons, by default, `-C` option finds copies only
 	if the original file of the copy was modified in the same
 	changeset.  This flag makes the command
@@ -564,8 +564,8 @@ endif::git-log[]
 	projects, so use it with caution.  Giving more than one
 	`-C` option has the same effect.
 
--D::
---irreversible-delete::
+`-D`::
+`--irreversible-delete`::
 	Omit the preimage for deletes, i.e. print only the header but not
 	the diff between the preimage and `/dev/null`. The resulting patch
 	is not meant to be applied with `patch` or `git apply`; this is
@@ -577,7 +577,7 @@ endif::git-log[]
 When used together with `-B`, omit also the preimage in the deletion part
 of a delete/create pair.
 
--l<num>::
+`-l<num>`::
 	The `-M` and `-C` options require O(n^2) processing time where n
 	is the number of potential rename/copy targets.  This
 	option prevents rename/copy detection from running if
@@ -606,7 +606,7 @@ from the index to the working tree can never have Added entries
 the index).  Similarly, copied and renamed entries cannot appear if
 detection for those types is disabled.
 
--S<string>::
+`-S<string>`::
 	Look for differences that change the number of occurrences of
 	the specified string (i.e. addition/deletion) in a file.
 	Intended for the scripter's use.
@@ -619,7 +619,7 @@ very first version of the block.
 +
 Binary files are searched as well.
 
--G<regex>::
+`-G<regex>`::
 	Look for differences whose patch text contains added/removed
 	lines that match <regex>.
 +
@@ -643,7 +643,7 @@ filter will be ignored.
 See the 'pickaxe' entry in linkgit:gitdiffcore[7] for more
 information.
 
---find-object=<object-id>::
+`--find-object=<object-id>`::
 	Look for differences that change the number of occurrences of
 	the specified object. Similar to `-S`, just the argument is different
 	in that it doesn't search for a specific string but for a specific
@@ -652,18 +652,18 @@ information.
 The object can be a blob or a submodule commit. It implies the `-t` option in
 `git-log` to also find trees.
 
---pickaxe-all::
+`--pickaxe-all`::
 	When `-S` or `-G` finds a change, show all the changes in that
 	changeset, not just the files that contain the change
 	in <string>.
 
---pickaxe-regex::
+`--pickaxe-regex`::
 	Treat the <string> given to `-S` as an extended POSIX regular
 	expression to match.
 
 endif::git-format-patch[]
 
--O<orderfile>::
+`-O<orderfile>`::
 	Control the order in which files appear in the output.
 	This overrides the `diff.orderFile` configuration variable
 	(see linkgit:git-config[1]).  To cancel `diff.orderFile`,
@@ -700,8 +700,8 @@ matches a pattern if removing any number of the final pathname
 components matches the pattern.  For example, the pattern "`foo*bar`"
 matches "`fooasdfbar`" and "`foo/bar/baz/asdf`" but not "`foobarx`".
 
---skip-to=<file>::
---rotate-to=<file>::
+`--skip-to=<file>`::
+`--rotate-to=<file>`::
 	Discard the files before the named <file> from the output
 	(i.e. 'skip to'), or move them to the end of the output
 	(i.e. 'rotate to').  These were invented primarily for use
@@ -709,13 +709,13 @@ matches "`fooasdfbar`" and "`foo/bar/baz/asdf`" but not "`foobarx`".
 	otherwise.
 
 ifndef::git-format-patch[]
--R::
+`-R`::
 	Swap two inputs; that is, show differences from index or
 	on-disk file to tree contents.
 endif::git-format-patch[]
 
---relative[=<path>]::
---no-relative::
+`--relative[=<path>]`::
+`--no-relative`::
 	When run from a subdirectory of the project, it can be
 	told to exclude changes outside the directory and show
 	pathnames relative to it with this option.  When you are
@@ -725,44 +725,44 @@ endif::git-format-patch[]
 	`--no-relative` can be used to countermand both `diff.relative` config
 	option and previous `--relative`.
 
--a::
---text::
+`-a`::
+`--text`::
 	Treat all files as text.
 
---ignore-cr-at-eol::
+`--ignore-cr-at-eol`::
 	Ignore carriage-return at the end of line when doing a comparison.
 
---ignore-space-at-eol::
+`--ignore-space-at-eol`::
 	Ignore changes in whitespace at EOL.
 
--b::
---ignore-space-change::
+`-b`::
+`--ignore-space-change`::
 	Ignore changes in amount of whitespace.  This ignores whitespace
 	at line end, and considers all other sequences of one or
 	more whitespace characters to be equivalent.
 
--w::
---ignore-all-space::
+`-w`::
+`--ignore-all-space`::
 	Ignore whitespace when comparing lines.  This ignores
 	differences even if one line has whitespace where the other
 	line has none.
 
---ignore-blank-lines::
+`--ignore-blank-lines`::
 	Ignore changes whose lines are all blank.
 
--I<regex>::
---ignore-matching-lines=<regex>::
+`-I<regex>`::
+`--ignore-matching-lines=<regex>`::
 	Ignore changes whose all lines match <regex>.  This option may
 	be specified more than once.
 
---inter-hunk-context=<lines>::
+`--inter-hunk-context=<lines>`::
 	Show the context between diff hunks, up to the specified number
 	of lines, thereby fusing hunks that are close to each other.
 	Defaults to `diff.interHunkContext` or 0 if the config option
 	is unset.
 
--W::
---function-context::
+`-W`::
+`--function-context`::
 	Show whole function as context lines for each change.
 	The function names are determined in the same way as
 	`git diff` works out patch hunk headers (see 'Defining a
@@ -770,26 +770,26 @@ endif::git-format-patch[]
 
 ifndef::git-format-patch[]
 ifndef::git-log[]
---exit-code::
+`--exit-code`::
 	Make the program exit with codes similar to diff(1).
 	That is, it exits with 1 if there were differences and
 	0 means no differences.
 
---quiet::
+`--quiet`::
 	Disable all output of the program. Implies `--exit-code`.
 endif::git-log[]
 endif::git-format-patch[]
 
---ext-diff::
+`--ext-diff`::
 	Allow an external diff helper to be executed. If you set an
 	external diff driver with linkgit:gitattributes[5], you need
 	to use this option with linkgit:git-log[1] and friends.
 
---no-ext-diff::
+`--no-ext-diff`::
 	Disallow external diff drivers.
 
---textconv::
---no-textconv::
+`--textconv`::
+`--no-textconv`::
 	Allow (or disallow) external text conversion filters to be run
 	when comparing binary files. See linkgit:gitattributes[5] for
 	details. Because textconv filters are typically a one-way
@@ -799,7 +799,7 @@ endif::git-format-patch[]
 	linkgit:git-log[1], but not for linkgit:git-format-patch[1] or
 	diff plumbing commands.
 
---ignore-submodules[=<when>]::
+`--ignore-submodules[=<when>]`::
 	Ignore changes to submodules in the diff generation. <when> can be
 	either "none", "untracked", "dirty" or "all", which is the default.
 	Using "none" will consider the submodule modified when it either contains
@@ -812,19 +812,19 @@ endif::git-format-patch[]
 	only changes to the commits stored in the superproject are shown (this was
 	the behavior until 1.7.0). Using "all" hides all changes to submodules.
 
---src-prefix=<prefix>::
+`--src-prefix=<prefix>`::
 	Show the given source prefix instead of "a/".
 
---dst-prefix=<prefix>::
+`--dst-prefix=<prefix>`::
 	Show the given destination prefix instead of "b/".
 
---no-prefix::
+`--no-prefix`::
 	Do not show any source or destination prefix.
 
---line-prefix=<prefix>::
+`--line-prefix=<prefix>`::
 	Prepend an additional prefix to every line of output.
 
---ita-invisible-in-index::
+`--ita-invisible-in-index`::
 	By default entries added by `git add -N` appear as an existing
 	empty file in `git diff` and a new file in `git diff --cached`.
 	This option makes the entry appear as a new file in `git diff`
diff --git a/Documentation/fetch-options.txt b/Documentation/fetch-options.txt
index 94de13eec8..fcee0ad87d 100644
--- a/Documentation/fetch-options.txt
+++ b/Documentation/fetch-options.txt
@@ -1,38 +1,38 @@
---all::
+`--all`::
 	Fetch all remotes.
 
--a::
---append::
+`-a`::
+`--append`::
 	Append ref names and object names of fetched refs to the
 	existing contents of `.git/FETCH_HEAD`.  Without this
 	option old data in `.git/FETCH_HEAD` will be overwritten.
 
---atomic::
+`--atomic`::
 	Use an atomic transaction to update local refs. Either all refs are
 	updated, or on error, no refs are updated.
 
---depth=<depth>::
+`--depth=<depth>`::
 	Limit fetching to the specified number of commits from the tip of
 	each remote branch history. If fetching to a 'shallow' repository
 	created by `git clone` with `--depth=<depth>` option (see
 	linkgit:git-clone[1]), deepen or shorten the history to the specified
 	number of commits. Tags for the deepened commits are not fetched.
 
---deepen=<depth>::
+`--deepen=<depth>`::
 	Similar to --depth, except it specifies the number of commits
 	from the current shallow boundary instead of from the tip of
 	each remote branch history.
 
---shallow-since=<date>::
+`--shallow-since=<date>`::
 	Deepen or shorten the history of a shallow repository to
 	include all reachable commits after <date>.
 
---shallow-exclude=<revision>::
+`--shallow-exclude=<revision>`::
 	Deepen or shorten the history of a shallow repository to
 	exclude commits reachable from a specified remote branch or tag.
 	This option can be specified multiple times.
 
---unshallow::
+`--unshallow`::
 	If the source repository is complete, convert a shallow
 	repository to a complete one, removing all the limitations
 	imposed by shallow repositories.
@@ -40,7 +40,7 @@
 If the source repository is shallow, fetch as much as possible so that
 the current repository has the same history as the source repository.
 
---update-shallow::
+`--update-shallow`::
 	By default when fetching from a shallow repository,
 	`git fetch` refuses refs that require updating
 	`.git/shallow`. This option updates `.git/shallow` and accept such
@@ -65,11 +65,11 @@ this option multiple times, one for each matching ref name.
 See also the `fetch.negotiationAlgorithm` configuration variable
 documented in linkgit:git-config[1].
 
---dry-run::
+`--dry-run`::
 	Show what would be done, without making any changes.
 
 ifndef::git-pull[]
---[no-]write-fetch-head::
+`--[no-]write-fetch-head`::
 	Write the list of remote refs fetched in the `FETCH_HEAD`
 	file directly under `$GIT_DIR`.  This is the default.
 	Passing `--no-write-fetch-head` from the command line tells
@@ -77,8 +77,8 @@ ifndef::git-pull[]
 	file is never written.
 endif::git-pull[]
 
--f::
---force::
+`-f`::
+`--force`::
 	When `git fetch` is used with `<src>:<dst>` refspec it may
 	refuse to update the local branch as discussed
 ifdef::git-pull[]
@@ -90,28 +90,28 @@ ifndef::git-pull[]
 endif::git-pull[]
 	This option overrides that check.
 
--k::
---keep::
+`-k`::
+`--keep`::
 	Keep downloaded pack.
 
 ifndef::git-pull[]
---multiple::
+`--multiple`::
 	Allow several <repository> and <group> arguments to be
 	specified. No <refspec>s may be specified.
 
---[no-]auto-maintenance::
---[no-]auto-gc::
+`--[no-]auto-maintenance`::
+`--[no-]auto-gc`::
 	Run `git maintenance run --auto` at the end to perform automatic
 	repository maintenance if needed. (`--[no-]auto-gc` is a synonym.)
 	This is enabled by default.
 
---[no-]write-commit-graph::
+`--[no-]write-commit-graph`::
 	Write a commit-graph after fetching. This overrides the config
 	setting `fetch.writeCommitGraph`.
 endif::git-pull[]
 
--p::
---prune::
+`-p`::
+`--prune`::
 	Before fetching, remove any remote-tracking references that no
 	longer exist on the remote.  Tags are not subject to pruning
 	if they are fetched only because of the default tag
@@ -125,8 +125,8 @@ ifndef::git-pull[]
 +
 See the PRUNING section below for more details.
 
--P::
---prune-tags::
+`-P`::
+`--prune-tags`::
 	Before fetching, remove any local tags that no longer exist on
 	the remote if `--prune` is enabled. This option should be used
 	more carefully, unlike `--prune` it will remove any local
@@ -139,16 +139,16 @@ See the PRUNING section below for more details.
 endif::git-pull[]
 
 ifndef::git-pull[]
--n::
+`-n`::
 endif::git-pull[]
---no-tags::
+`--no-tags`::
 	By default, tags that point at objects that are downloaded
 	from the remote repository are fetched and stored locally.
 	This option disables this automatic tag following. The default
 	behavior for a remote may be specified with the remote.<name>.tagOpt
 	setting. See linkgit:git-config[1].
 
---refmap=<refspec>::
+`--refmap=<refspec>`::
 	When fetching refs listed on the command line, use the
 	specified refspec (can be given more than once) to map the
 	refs to remote-tracking branches, instead of the values of
@@ -159,8 +159,8 @@ endif::git-pull[]
 	command-line arguments. See section on "Configured Remote-tracking
 	Branches" for details.
 
--t::
---tags::
+`-t`::
+`--tags`::
 	Fetch all tags from the remote (i.e., fetch remote tags
 	`refs/tags/*` into local tags with the same name), in addition
 	to whatever else would otherwise be fetched.  Using this
@@ -182,8 +182,8 @@ ifndef::git-pull[]
 	`fetch.recurseSubmodules` is set (see linkgit:git-config[1]).
 endif::git-pull[]
 
--j::
---jobs=<n>::
+`-j`::
+`--jobs=<n>`::
 	Number of parallel children to be used for all forms of fetching.
 +
 If the `--multiple` option was specified, the different remotes will be fetched
@@ -195,12 +195,12 @@ Typically, parallel recursive and multi-remote fetches will be faster. By
 default fetches are performed sequentially, not in parallel.
 
 ifndef::git-pull[]
---no-recurse-submodules::
+`--no-recurse-submodules`::
 	Disable recursive fetching of submodules (this has the same effect as
 	using the `--recurse-submodules=no` option).
 endif::git-pull[]
 
---set-upstream::
+`--set-upstream`::
 	If the remote is fetched successfully, add upstream
 	(tracking) reference, used by argument-less
 	linkgit:git-pull[1] and other commands. For more information,
@@ -208,7 +208,7 @@ endif::git-pull[]
 	linkgit:git-config[1].
 
 ifndef::git-pull[]
---submodule-prefix=<path>::
+`--submodule-prefix=<path>`::
 	Prepend <path> to paths printed in informative messages
 	such as "Fetching submodule foo".  This option is used
 	internally when recursing over submodules.
@@ -221,8 +221,8 @@ ifndef::git-pull[]
 	linkgit:git-config[1]) override this option, as does
 	specifying --[no-]recurse-submodules directly.
 
--u::
---update-head-ok::
+`-u`::
+`--update-head-ok`::
 	By default `git fetch` refuses to update the head which
 	corresponds to the current branch.  This flag disables the
 	check.  This is purely for the internal use for `git pull`
@@ -238,25 +238,25 @@ endif::git-pull[]
 	run on the other end.
 
 ifndef::git-pull[]
--q::
---quiet::
+`-q`::
+`--quiet`::
 	Pass `--quiet` to `git-fetch-pack` and silence any other internally
 	used `git` commands. Progress is not reported to the standard error
 	stream.
 
--v::
---verbose::
+`-v`::
+`--verbose`::
 	Be verbose.
 endif::git-pull[]
 
---progress::
+`--progress`::
 	Progress status is reported on the standard error stream
 	by default when it is attached to a terminal, unless -q
 	is specified. This flag forces progress status even if the
 	standard error stream is not directed to a terminal.
 
 -o <option>::
---server-option=<option>::
+`--server-option=<option>`::
 	Transmit the given string to the server when communicating using
 	protocol version 2.  The given string must not contain a NUL or LF
 	character.  The server's handling of server options, including
@@ -264,13 +264,13 @@ endif::git-pull[]
 	When multiple `--server-option=<option>` are given, they are all
 	sent to the other side in the order listed on the command line.
 
---show-forced-updates::
+`--show-forced-updates`::
 	By default, `git` checks if a branch is force-updated during
 	fetch. This can be disabled through `fetch.showForcedUpdates`, but
 	the `--show-forced-updates` option guarantees this check occurs.
 	See linkgit:git-config[1].
 
---no-show-forced-updates::
+`--no-show-forced-updates`::
 	By default, `git` checks if a branch is force-updated during
 	fetch. Pass `--no-show-forced-updates` or set `fetch.showForcedUpdates`
 	to false to skip this check for performance reasons. If used during
diff --git a/Documentation/git-add.txt b/Documentation/git-add.txt
index 786c31fc60..646951cf7e 100644
--- a/Documentation/git-add.txt
+++ b/Documentation/git-add.txt
@@ -66,28 +66,28 @@ OPTIONS
 For more details about the <pathspec> syntax, see the 'pathspec' entry
 in linkgit:gitglossary[7].
 
--n::
---dry-run::
+`-n`::
+`--dry-run`::
 	Don't actually add the file(s), just show if they exist and/or will
 	be ignored.
 
--v::
---verbose::
+`-v`::
+`--verbose`::
         Be verbose.
 
--f::
---force::
+`-f`::
+`--force`::
 	Allow adding otherwise ignored files.
 
--i::
---interactive::
+`-i`::
+`--interactive`::
 	Add modified contents in the working tree interactively to
 	the index. Optional path arguments may be supplied to limit
 	operation to a subset of the working tree. See ``Interactive
 	mode'' for details.
 
--p::
---patch::
+`-p`::
+`--patch`::
 	Interactively choose hunks of patch between the index and the
 	work tree and add them to the index. This gives the user a chance
 	to review the difference before adding modified contents to the
@@ -97,8 +97,8 @@ This effectively runs `add --interactive`, but bypasses the
 initial command menu and directly jumps to the `patch` subcommand.
 See ``Interactive mode'' for details.
 
--e::
---edit::
+`-e`::
+`--edit`::
 	Open the diff vs. the index in an editor and let the user
 	edit it.  After the editor was closed, adjust the hunk headers
 	and apply the patch to the index.
@@ -109,8 +109,8 @@ quicker and more flexible than using the interactive hunk selector.
 However, it is easy to confuse oneself and create a patch that does not
 apply to the index. See EDITING PATCHES below.
 
--u::
---update::
+`-u`::
+`--update`::
 	Update the index just where it already has an entry matching
 	<pathspec>.  This removes as well as modifies index entries to
 	match the working tree, but adds no new files.
@@ -120,9 +120,9 @@ tracked files in the entire working tree are updated (old versions
 of Git used to limit the update to the current directory and its
 subdirectories).
 
--A::
---all::
---no-ignore-removal::
+`-A`::
+`--all`::
+`--no-ignore-removal`::
 	Update the index not only where the working tree has a file
 	matching <pathspec> but also where the index already has an
 	entry. This adds, modifies, and removes index entries to
@@ -133,8 +133,8 @@ files in the entire working tree are updated (old versions
 of Git used to limit the update to the current directory and its
 subdirectories).
 
---no-all::
---ignore-removal::
+`--no-all`::
+`--ignore-removal`::
 	Update the index by adding new files that are unknown to the
 	index and files modified in the working tree, but ignore
 	files that have been removed from the working tree.  This
@@ -144,39 +144,39 @@ This option is primarily to help users who are used to older
 versions of Git, whose `git add <pathspec>...` was a synonym
 for `git add --no-all <pathspec>...`, i.e. ignored removed files.
 
--N::
---intent-to-add::
+`-N`::
+`--intent-to-add`::
 	Record only the fact that the path will be added later. An entry
 	for the path is placed in the index with no content. This is
 	useful for, among other things, showing the unstaged content of
 	such files with `git diff` and committing them with `git commit
 	-a`.
 
---refresh::
+`--refresh`::
 	Don't add the file(s), but only refresh their stat()
 	information in the index.
 
---ignore-errors::
+`--ignore-errors`::
 	If some files could not be added because of errors indexing
 	them, do not abort the operation, but continue adding the
 	others. The command shall still exit with non-zero status.
 	The configuration variable `add.ignoreErrors` can be set to
 	true to make this the default behaviour.
 
---ignore-missing::
+`--ignore-missing`::
 	This option can only be used together with `--dry-run`. By using
 	this option the user can check if any of the given files would
 	be ignored, no matter if they are already present in the work
 	tree or not.
 
---no-warn-embedded-repo::
+`--no-warn-embedded-repo`::
 	By default, `git add` will warn when adding an embedded
 	repository to the index without using `git submodule add` to
 	create an entry in `.gitmodules`. This option will suppress the
 	warning (e.g., if you are manually performing operations on
 	submodules).
 
---renormalize::
+`--renormalize`::
 	Apply the "clean" process freshly to all tracked files to
 	forcibly add them again to the index.  This is useful after
 	changing `core.autocrlf` configuration or the `text` attribute
@@ -188,7 +188,7 @@ for `git add --no-all <pathspec>...`, i.e. ignored removed files.
 	bit is only changed in the index, the files on disk are left
 	unchanged.
 
---pathspec-from-file=<file>::
+`--pathspec-from-file=<file>`::
 	Pathspec is passed in `<file>` instead of commandline args. If
 	`<file>` is exactly `-` then standard input is used. Pathspec
 	elements are separated by LF or CR/LF. Pathspec elements can be
@@ -196,7 +196,7 @@ for `git add --no-all <pathspec>...`, i.e. ignored removed files.
 	(see linkgit:git-config[1]). See also `--pathspec-file-nul` and
 	global `--literal-pathspecs`.
 
---pathspec-file-nul::
+`--pathspec-file-nul`::
 	Only meaningful with `--pathspec-from-file`. Pathspec elements are
 	separated with NUL character and all other characters are taken
 	literally (including newlines and quotes).
@@ -254,7 +254,7 @@ choice is unique.
 
 The main command loop has 6 subcommands (plus help and quit).
 
-status::
+`status`::
 
    This shows the change between `HEAD` and index (i.e. what will be
    committed if you say `git commit`), and between index and
@@ -278,7 +278,7 @@ and 35 lines deleted if you commit what is in the index, but
 working tree file has further modifications (one addition and
 one deletion).
 
-update::
+`update`::
 
    This shows the status information and issues an "Update>>"
    prompt.  When the prompt ends with double '>>', you can
@@ -307,7 +307,7 @@ Update>> -2
 After making the selection, answer with an empty line to stage the
 contents of working tree files for selected paths in the index.
 
-revert::
+`revert`::
 
   This has a very similar UI to 'update', and the staged
   information for selected paths are reverted to that of the
@@ -318,7 +318,7 @@ add untracked::
   This has a very similar UI to 'update' and
   'revert', and lets you add untracked paths to the index.
 
-patch::
+`patch`::
 
   This lets you choose one path out of a 'status' like selection.
   After choosing the path, it presents the diff between the index
@@ -347,7 +347,7 @@ that was chosen, the index is updated with the selected hunks.
 You can omit having to type return here, by setting the configuration
 variable `interactive.singleKey` to `true`.
 
-diff::
+`diff`::
 
   This lets you review what will be committed (i.e. between
   `HEAD` and index).
diff --git a/Documentation/git-am.txt b/Documentation/git-am.txt
index 80f2f89cbd..c8560bacad 100644
--- a/Documentation/git-am.txt
+++ b/Documentation/git-am.txt
@@ -31,50 +31,50 @@ OPTIONS
 	supply this argument, the command reads from the standard input.
 	If you supply directories, they will be treated as Maildirs.
 
--s::
---signoff::
+`-s`::
+`--signoff`::
 	Add a `Signed-off-by` trailer to the commit message, using
 	the committer identity of yourself.
 	See the signoff option in linkgit:git-commit[1] for more information.
 
--k::
---keep::
+`-k`::
+`--keep`::
 	Pass `-k` flag to `git mailinfo` (see linkgit:git-mailinfo[1]).
 
---keep-non-patch::
+`--keep-non-patch`::
 	Pass `-b` flag to `git mailinfo` (see linkgit:git-mailinfo[1]).
 
---[no-]keep-cr::
+`--[no-]keep-cr`::
 	With `--keep-cr`, call `git mailsplit` (see linkgit:git-mailsplit[1])
 	with the same option, to prevent it from stripping CR at the end of
 	lines. `am.keepcr` configuration variable can be used to specify the
 	default behaviour.  `--no-keep-cr` is useful to override `am.keepcr`.
 
--c::
---scissors::
+`-c`::
+`--scissors`::
 	Remove everything in body before a scissors line (see
 	linkgit:git-mailinfo[1]). Can be activated by default using
 	the `mailinfo.scissors` configuration variable.
 
---no-scissors::
+`--no-scissors`::
 	Ignore scissors lines (see linkgit:git-mailinfo[1]).
 
--m::
---message-id::
+`-m`::
+`--message-id`::
 	Pass the `-m` flag to `git mailinfo` (see linkgit:git-mailinfo[1]),
 	so that the Message-ID header is added to the commit message.
 	The `am.messageid` configuration variable can be used to specify
 	the default behaviour.
 
---no-message-id::
+`--no-message-id`::
 	Do not add the Message-ID header to the commit message.
 	`no-message-id` is useful to override `am.messageid`.
 
--q::
---quiet::
+`-q`::
+`--quiet`::
 	Be quiet. Only print error messages.
 
--u::
+`-u`::
 --utf8::
 	Pass `-u` flag to `git mailinfo` (see linkgit:git-mailinfo[1]).
 	The proposed commit log message taken from the e-mail
@@ -99,65 +99,65 @@ default.   You can use `--no-utf8` to override this.
 	am.threeWay configuration variable. For more information,
 	see `am.threeWay` in linkgit:git-config[1].
 
---rerere-autoupdate::
---no-rerere-autoupdate::
+`--rerere-autoupdate`::
+`--no-rerere-autoupdate`::
 	Allow the rerere mechanism to update the index with the
 	result of auto-conflict resolution if possible.
 
---ignore-space-change::
---ignore-whitespace::
---whitespace=<option>::
--C<n>::
--p<n>::
---directory=<dir>::
---exclude=<path>::
---include=<path>::
---reject::
+`--ignore-space-change`::
+`--ignore-whitespace`::
+`--whitespace=<option>`::
+`-C<n>`::
+`-p<n>`::
+`--directory=<dir>`::
+`--exclude=<path>`::
+`--include=<path>`::
+`--reject`::
 	These flags are passed to the `git apply` (see linkgit:git-apply[1])
 	program that applies
 	the patch.
 
---patch-format::
+`--patch-format`::
 	By default the command will try to detect the patch format
 	automatically. This option allows the user to bypass the automatic
 	detection and specify the patch format that the patch(es) should be
 	interpreted as. Valid formats are mbox, mboxrd,
 	stgit, stgit-series and hg.
 
--i::
---interactive::
+`-i`::
+`--interactive`::
 	Run interactively.
 
---committer-date-is-author-date::
+`--committer-date-is-author-date`::
 	By default the command records the date from the e-mail
 	message as the commit author date, and uses the time of
 	commit creation as the committer date. This allows the
 	user to lie about the committer date by using the same
 	value as the author date.
 
---ignore-date::
+`--ignore-date`::
 	By default the command records the date from the e-mail
 	message as the commit author date, and uses the time of
 	commit creation as the committer date. This allows the
 	user to lie about the author date by using the same
 	value as the committer date.
 
---skip::
+`--skip`::
 	Skip the current patch.  This is only meaningful when
 	restarting an aborted patch.
 
--S[<keyid>]::
---gpg-sign[=<keyid>]::
---no-gpg-sign::
+`-S[<keyid>]`::
+`--gpg-sign[=<keyid>]`::
+`--no-gpg-sign`::
 	GPG-sign commits. The `keyid` argument is optional and
 	defaults to the committer identity; if specified, it must be
 	stuck to the option without a space. `--no-gpg-sign` is useful to
 	countermand both `commit.gpgSign` configuration variable, and
 	earlier `--gpg-sign`.
 
---continue::
--r::
---resolved::
+`--continue`::
+`-r`::
+`--resolved`::
 	After a patch failure (e.g. attempting to apply
 	conflicting patch), the user has applied it by hand and
 	the index file stores the result of the application.
@@ -165,17 +165,17 @@ default.   You can use `--no-utf8` to override this.
 	extracted from the e-mail message and the current index
 	file, and continue.
 
---resolvemsg=<msg>::
+`--resolvemsg=<msg>`::
 	When a patch failure occurs, <msg> will be printed
 	to the screen before exiting.  This overrides the
 	standard message informing you to use `--continue`
 	or `--skip` to handle the failure.  This is solely
 	for internal use between `git rebase` and `git am`.
 
---abort::
+`--abort`::
 	Restore the original branch and abort the patching operation.
 
---quit::
+`--quit`::
 	Abort the patching operation but keep `HEAD` and the index
 	untouched.
 
diff --git a/Documentation/git-apply.txt b/Documentation/git-apply.txt
index a836021d5e..88cdddb178 100644
--- a/Documentation/git-apply.txt
+++ b/Documentation/git-apply.txt
@@ -38,29 +38,29 @@ OPTIONS
 	The files to read the patch from.  '-' can be used to read
 	from the standard input.
 
---stat::
+`--stat`::
 	Instead of applying the patch, output diffstat for the
 	input.  Turns off "apply".
 
---numstat::
+`--numstat`::
 	Similar to `--stat`, but shows the number of added and
 	deleted lines in decimal notation and the pathname without
 	abbreviation, to make it more machine friendly.  For
 	binary files, outputs two `-` instead of saying
 	`0 0`.  Turns off "apply".
 
---summary::
+`--summary`::
 	Instead of applying the patch, output a condensed
 	summary of information obtained from `git diff` extended
 	headers, such as creations, renames and mode changes.
 	Turns off "apply".
 
---check::
+`--check`::
 	Instead of applying the patch, see if the patch is
 	applicable to the current working tree and/or the index
 	file and detects errors.  Turns off "apply".
 
---index::
+`--index`::
 	Apply the patch to both the index and the working tree (or
 	merely check that it would apply cleanly to both if `--check` is
 	in effect). Note that `--index` expects index entries and
@@ -69,12 +69,12 @@ OPTIONS
 	raise an error if they are not, even if the patch would apply
 	cleanly to both the index and the working tree in isolation.
 
---cached::
+`--cached`::
 	Apply the patch to just the index, without touching the working
 	tree. If `--check` is in effect, merely check that it would
 	apply cleanly to the index entry.
 
---intent-to-add::
+`--intent-to-add`::
 	When applying the patch only to the working tree, mark new
 	files to be added to the index later (see `--intent-to-add`
 	option in linkgit:git-add[1]). This option is ignored unless
@@ -91,7 +91,7 @@ OPTIONS
 	resolve.  This option implies the `--index` option, and is incompatible
 	with the `--reject` and the `--cached` options.
 
---build-fake-ancestor=<file>::
+`--build-fake-ancestor=<file>`::
 	Newer `git diff` output has embedded 'index information'
 	for each blob to help identify the original version that
 	the patch applies to.  When this flag is given, and if
@@ -101,18 +101,18 @@ OPTIONS
 When a pure mode change is encountered (which has no index information),
 the information is read from the current index instead.
 
--R::
---reverse::
+`-R`::
+`--reverse`::
 	Apply the patch in reverse.
 
---reject::
+`--reject`::
 	For atomicity, `git apply` by default fails the whole patch and
 	does not touch the working tree when some of the hunks
 	do not apply.  This option makes it apply
 	the parts of the patch that are applicable, and leave the
 	rejected hunks in corresponding *.rej files.
 
--z::
+`-z`::
 	When `--numstat` has been given, do not munge pathnames,
 	but use a NUL-terminated machine-readable format.
 +
@@ -120,19 +120,19 @@ Without this option, pathnames with "unusual" characters are quoted as
 explained for the configuration variable `core.quotePath` (see
 linkgit:git-config[1]).
 
--p<n>::
+`-p<n>`::
 	Remove <n> leading path components (separated by slashes) from
 	traditional diff paths. E.g., with `-p2`, a patch against
 	`a/dir/file` will be applied directly to `file`. The default is
 	1.
 
--C<n>::
+`-C<n>`::
 	Ensure at least <n> lines of surrounding context match before
 	and after each change.  When fewer lines of surrounding
 	context exist they all must match.  By default no context is
 	ever ignored.
 
---unidiff-zero::
+`--unidiff-zero`::
 	By default, `git apply` expects that the patch being
 	applied is a unified diff with at least one line of context.
 	This provides good safety measures, but breaks down when
@@ -142,33 +142,33 @@ linkgit:git-config[1]).
 Note, for the reasons stated above usage of context-free patches is
 discouraged.
 
---apply::
+`--apply`::
 	If you use any of the options marked "Turns off
 	'apply'" above, `git apply` reads and outputs the
 	requested information without actually applying the
 	patch.  Give this flag after those flags to also apply
 	the patch.
 
---no-add::
+`--no-add`::
 	When applying a patch, ignore additions made by the
 	patch.  This can be used to extract the common part between
 	two files by first running 'diff' on them and applying
 	the result with this option, which would apply the
 	deletion part but not the addition part.
 
---allow-binary-replacement::
---binary::
+`--allow-binary-replacement`::
+`--binary`::
 	Historically we did not allow binary patch applied
 	without an explicit permission from the user, and this
 	flag was the way to do so.  Currently we always allow binary
 	patch application, so this is a no-op.
 
---exclude=<path-pattern>::
+`--exclude=<path-pattern>`::
 	Don't apply changes to files matching the given path pattern. This can
 	be useful when importing patchsets, where you want to exclude certain
 	files or directories.
 
---include=<path-pattern>::
+`--include=<path-pattern>`::
 	Apply changes to files matching the given path pattern. This can
 	be useful when importing patchsets, where you want to include certain
 	files or directories.
@@ -179,15 +179,15 @@ patch to each path is used.  A patch to a path that does not match any
 include/exclude pattern is used by default if there is no include pattern
 on the command line, and ignored if there is any include pattern.
 
---ignore-space-change::
---ignore-whitespace::
+`--ignore-space-change`::
+`--ignore-whitespace`::
 	When applying a patch, ignore changes in whitespace in context
 	lines if necessary.
 	Context lines will preserve their whitespace, and they will not
 	undergo whitespace fixing regardless of the value of the
 	`--whitespace` option. New lines will still be fixed, though.
 
---whitespace=<action>::
+`--whitespace=<action>`::
 	When applying a patch, detect a new or modified line that has
 	whitespace errors.  What are considered whitespace errors is
 	controlled by `core.whitespace` configuration.  By default,
@@ -214,25 +214,25 @@ behavior:
   to apply the patch.
 * `error-all` is similar to `error` but shows all errors.
 
---inaccurate-eof::
+`--inaccurate-eof`::
 	Under certain circumstances, some versions of 'diff' do not correctly
 	detect a missing new-line at the end of the file. As a result, patches
 	created by such 'diff' programs do not record incomplete lines
 	correctly. This option adds support for applying such patches by
 	working around this bug.
 
--v::
---verbose::
+`-v`::
+`--verbose`::
 	Report progress to stderr. By default, only a message about the
 	current patch being applied will be printed. This option will cause
 	additional information to be reported.
 
---recount::
+`--recount`::
 	Do not trust the line counts in the hunk headers, but infer them
 	by inspecting the patch (e.g. after editing the patch without
 	adjusting the hunk headers appropriately).
 
---directory=<root>::
+`--directory=<root>`::
 	Prepend <root> to all filenames.  If a `-p` argument was also passed,
 	it is applied before prepending the new root.
 +
@@ -240,7 +240,7 @@ For example, a patch that talks about updating `a/git-gui.sh` to `b/git-gui.sh`
 can be applied to the file in the working tree `modules/git-gui/git-gui.sh` by
 running `git apply --directory=modules/git-gui`.
 
---unsafe-paths::
+`--unsafe-paths`::
 	By default, a patch that affects outside the working area
 	(either a Git controlled working tree, or the current working
 	directory when `git apply` is used as a replacement of GNU
diff --git a/Documentation/git-archimport.txt b/Documentation/git-archimport.txt
index 72237659d9..8ea76463bf 100644
--- a/Documentation/git-archimport.txt
+++ b/Documentation/git-archimport.txt
@@ -68,22 +68,22 @@ patches that have been traded out-of-sequence between the branches.
 OPTIONS
 -------
 
--h::
+`-h`::
 	Display usage.
 
--v::
+`-v`::
 	Verbose output.
 
--T::
+`-T`::
 	Many tags. Will create a tag for every commit, reflecting the commit
 	name in the Arch repository.
 
--f::
+`-f`::
 	Use the fast patchset import strategy.  This can be significantly
 	faster for large trees, but cannot handle directory renames or
 	permissions changes.  The default strategy is slow and safe.
 
--o::
+`-o`::
 	Use this for compatibility with old-style branch names used by
 	earlier versions of `git archimport`.  Old-style branch names
 	were category{litdd}branch, whereas new-style branch names are
@@ -96,7 +96,7 @@ OPTIONS
 	merged from.  Specify a depth greater than 1 if patch logs have been
 	pruned.
 
--a::
+`-a`::
 	Attempt to auto-register archives at http://mirrors.sourcecontrol.net
 	This is particularly useful with the `-D` option.
 
diff --git a/Documentation/git-archive.txt b/Documentation/git-archive.txt
index 4bd6299046..d0ca1241a2 100644
--- a/Documentation/git-archive.txt
+++ b/Documentation/git-archive.txt
@@ -33,57 +33,57 @@ comment.
 OPTIONS
 -------
 
---format=<fmt>::
+`--format=<fmt>`::
 	Format of the resulting archive: 'tar' or 'zip'. If this option
 	is not given, and the output file is specified, the format is
 	inferred from the filename if possible (e.g. writing to "foo.zip"
 	makes the output to be in the zip format). Otherwise the output
 	format is `tar`.
 
--l::
---list::
+`-l`::
+`--list`::
 	Show all available formats.
 
--v::
---verbose::
+`-v`::
+`--verbose`::
 	Report progress to stderr.
 
 --prefix=<prefix>/::
 	Prepend <prefix>/ to each filename in the archive.
 
 -o <file>::
---output=<file>::
+`--output=<file>`::
 	Write the archive to <file> instead of stdout.
 
---add-file=<file>::
+`--add-file=<file>`::
 	Add a non-tracked file to the archive.  Can be repeated to add
 	multiple files.  The path of the file in the archive is built
 	by concatenating the value for `--prefix` (if any) and the
 	basename of <file>.
 
---worktree-attributes::
+`--worktree-attributes`::
 	Look for attributes in .gitattributes files in the working tree
 	as well (see <<ATTRIBUTES>>).
 
-<extra>::
+`<extra>`::
 	This can be any options that the archiver backend understands.
 	See next section.
 
---remote=<repo>::
+`--remote=<repo>`::
 	Instead of making a tar archive from the local repository,
 	retrieve a tar archive from a remote repository. Note that the
 	remote repository may place restrictions on which sha1
 	expressions may be allowed in `<tree-ish>`. See
 	linkgit:git-upload-archive[1] for details.
 
---exec=<git-upload-archive>::
+`--exec=<git-upload-archive>`::
 	Used with `--remote` to specify the path to the
 	`git-upload-archive` on the remote side.
 
-<tree-ish>::
+`<tree-ish>`::
 	The tree or commit to produce an archive for.
 
-<path>::
+`<path>`::
 	Without an optional path parameter, all files and subdirectories
 	of the current working directory are included in the archive.
 	If one or more paths are specified, only these are included.
@@ -134,11 +134,11 @@ tar.<format>.remote::
 ATTRIBUTES
 ----------
 
-export-ignore::
+`export-ignore`::
 	Files and directories with the attribute export-ignore won't be
 	added to archive files.  See linkgit:gitattributes[5] for details.
 
-export-subst::
+`export-subst`::
 	If the attribute export-subst is set for a file then Git will
 	expand several placeholders when adding this file to an archive.
 	See linkgit:gitattributes[5] for details.
diff --git a/Documentation/git-bisect.txt b/Documentation/git-bisect.txt
index d59422636b..476835938f 100644
--- a/Documentation/git-bisect.txt
+++ b/Documentation/git-bisect.txt
@@ -354,7 +354,7 @@ determine the eventual outcome of the bisect session.
 
 OPTIONS
 -------
---no-checkout::
+`--no-checkout`::
 +
 Do not checkout the new working tree at each iteration of the bisection
 process. Instead just update a special reference named `BISECT_HEAD` to make
@@ -365,7 +365,7 @@ does not require a checked out tree.
 +
 If the repository is bare, `--no-checkout` is assumed.
 
---first-parent::
+`--first-parent`::
 +
 Follow only the first parent commit upon seeing a merge commit.
 +
diff --git a/Documentation/git-blame.txt b/Documentation/git-blame.txt
index aa1b5d56d3..b3d60d241a 100644
--- a/Documentation/git-blame.txt
+++ b/Documentation/git-blame.txt
@@ -50,10 +50,10 @@ OPTIONS
 -------
 include::blame-options.txt[]
 
--c::
+`-c`::
 	Use the same output mode as linkgit:git-annotate[1] (Default: off).
 
---score-debug::
+`--score-debug`::
 	Include debugging information related to the movement of
 	lines between files (see `-C`) and lines moved within a
 	file (see `-M`).  The first number listed is the score.
@@ -62,30 +62,30 @@ include::blame-options.txt[]
 	a certain threshold for `git blame` to consider those lines
 	of code to have been moved.
 
--f::
---show-name::
+`-f`::
+`--show-name`::
 	Show the filename in the original commit.  By default
 	the filename is shown if there is any line that came from a
 	file with a different name, due to rename detection.
 
--n::
---show-number::
+`-n`::
+`--show-number`::
 	Show the line number in the original commit (Default: off).
 
--s::
+`-s`::
 	Suppress the author name and timestamp from the output.
 
--e::
---show-email::
+`-e`::
+`--show-email`::
 	Show the author email instead of author name (Default: off).
 	This can also be controlled via the `blame.showEmail` config
 	option.
 
--w::
+`-w`::
 	Ignore whitespace when comparing the parent's version and
 	the child's to find where the lines came from.
 
---abbrev=<n>::
+`--abbrev=<n>`::
 	Instead of using the default 7+1 hexadecimal digits as the
 	abbreviated object name, use <m>+1 digits, where <m> is at
 	least <n> but ensures the commit object names are unique.
diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.txt
index 6f37f11b33..b9f65c4d52 100644
--- a/Documentation/git-branch.txt
+++ b/Documentation/git-branch.txt
@@ -94,16 +94,16 @@ way to clean up all obsolete remote-tracking branches.
 
 OPTIONS
 -------
--d::
---delete::
+`-d`::
+`--delete`::
 	Delete a branch. The branch must be fully merged in its
 	upstream branch, or in `HEAD` if no upstream was set with
 	`--track` or `--set-upstream-to`.
 
--D::
+`-D`::
 	Shortcut for `--delete --force`.
 
---create-reflog::
+`--create-reflog`::
 	Create the branch's reflog.  This activates recording of
 	all changes made to the branch ref, enabling use of date
 	based sha1 expressions such as "<branchname>@\{yesterday}".
@@ -113,8 +113,8 @@ OPTIONS
 	`--create-reflog`, but currently does not negate the setting of
 	`core.logAllRefUpdates`.
 
--f::
---force::
+`-f`::
+`--force`::
 	Reset <branchname> to <startpoint>, even if <branchname> exists
 	already. Without `-f`, `git branch` refuses to change an existing branch.
 	In combination with `-d` (or `--delete`), allow deleting the
@@ -122,65 +122,65 @@ OPTIONS
 	`-m` (or `--move`), allow renaming the branch even if the new
 	branch name already exists, the same applies for `-c` (or `--copy`).
 
--m::
---move::
+`-m`::
+`--move`::
 	Move/rename a branch and the corresponding reflog.
 
--M::
+`-M`::
 	Shortcut for `--move --force`.
 
--c::
---copy::
+`-c`::
+`--copy`::
 	Copy a branch and the corresponding reflog.
 
--C::
+`-C`::
 	Shortcut for `--copy --force`.
 
---color[=<when>]::
+`--color[=<when>]`::
 	Color branches to highlight current, local, and
 	remote-tracking branches.
 	The value must be always (the default), never, or auto.
 
---no-color::
+`--no-color`::
 	Turn off branch colors, even when the configuration file gives the
 	default to color output.
 	Same as `--color=never`.
 
--i::
---ignore-case::
+`-i`::
+`--ignore-case`::
 	Sorting and filtering branches are case insensitive.
 
---column[=<options>]::
---no-column::
+`--column[=<options>]`::
+`--no-column`::
 	Display branch listing in columns. See configuration variable
 	`column.branch` for option syntax. `--column` and `--no-column`
 	without options are equivalent to 'always' and 'never' respectively.
 +
 This option is only applicable in non-verbose mode.
 
--r::
---remotes::
+`-r`::
+`--remotes`::
 	List or delete (if used with -d) the remote-tracking branches.
 	Combine with `--list` to match the optional pattern(s).
 
--a::
---all::
+`-a`::
+`--all`::
 	List both remote-tracking branches and local branches.
 	Combine with `--list` to match optional pattern(s).
 
--l::
---list::
+`-l`::
+`--list`::
 	List branches.  With optional `<pattern>...`, e.g. `git
 	branch --list 'maint-*'`, list only the branches that match
 	the pattern(s).
 
---show-current::
+`--show-current`::
 	Print the name of the current branch. In detached `HEAD` state,
 	nothing is printed.
 
--v::
--vv::
---verbose::
+`-v`::
+`-vv`::
+`--verbose`::
 	When in list mode,
 	show sha1 and commit subject line for each head, along with
 	relationship to upstream branch (if any). If given twice, print
@@ -189,23 +189,23 @@ This option is only applicable in non-verbose mode.
 	current worktree's `HEAD` will not have its path printed (it will always
 	be your current directory).
 
--q::
---quiet::
+`-q`::
+`--quiet`::
 	Be more quiet when creating or deleting a branch, suppressing
 	non-error messages.
 
---abbrev=<n>::
+`--abbrev=<n>`::
 	In the verbose listing that show the commit object name,
 	show the shortest prefix that is at least '<n>' hexdigits
 	long that uniquely refers the object.
 	The default value is 7 and can be overridden by the `core.abbrev`
 	config option.
 
---no-abbrev::
+`--no-abbrev`::
 	Display the full sha1s in the output listing rather than abbreviating them.
 
--t::
---track::
+`-t`::
+`--track`::
 	When creating a new branch, set up `branch.<name>.remote` and
 	`branch.<name>.merge` configuration entries to mark the
 	start-point branch as "upstream" from the new branch. This
@@ -220,25 +220,25 @@ want `git switch`, `git checkout` and `git branch` to always behave as if `--no-
 were given. Set it to `always` if you want this behavior when the
 start-point is either a local or remote-tracking branch.
 
---no-track::
+`--no-track`::
 	Do not set up "upstream" configuration, even if the
 	branch.autoSetupMerge configuration variable is true.
 
---set-upstream::
+`--set-upstream`::
 	As this option had confusing syntax, it is no longer supported.
 	Please use `--track` or `--set-upstream-to` instead.
 
 -u <upstream>::
---set-upstream-to=<upstream>::
+`--set-upstream-to=<upstream>`::
 	Set up <branchname>'s tracking information so <upstream> is
 	considered <branchname>'s upstream branch. If no <branchname>
 	is specified, then it defaults to the current branch.
 
---unset-upstream::
+`--unset-upstream`::
 	Remove the upstream information for <branchname>. If no branch
 	is specified it defaults to the current branch.
 
---edit-description::
+`--edit-description`::
 	Open an editor and edit the text to explain what the branch is
 	for, to be used by various other commands (e.g. `format-patch`,
 	`request-pull`, and `merge` (if enabled)). Multi-line explanations
@@ -260,25 +260,25 @@ start-point is either a local or remote-tracking branch.
 	Only list branches whose tips are not reachable from the
 	specified commit (`HEAD` if not specified). Implies `--list`.
 
-<branchname>::
+`<branchname>`::
 	The name of the branch to create or delete.
 	The new branch name must pass all checks defined by
 	linkgit:git-check-ref-format[1].  Some of these checks
 	may restrict the characters allowed in a branch name.
 
-<start-point>::
+`<start-point>`::
 	The new branch head will point to this commit.  It may be
 	given as a branch name, a commit-id, or a tag.  If this
 	option is omitted, the current `HEAD` will be used instead.
 
-<oldbranch>::
+`<oldbranch>`::
 	The name of an existing branch to rename.
 
-<newbranch>::
+`<newbranch>`::
 	The new name for an existing branch. The same restrictions as for
 	<branchname> apply.
 
---sort=<key>::
+`--sort=<key>`::
 	Sort based on the key given. Prefix `-` to sort in descending
 	order of the value. You may use the `--sort=<key>` option
 	multiple times, in which case the last key becomes the primary
diff --git a/Documentation/git-bundle.txt b/Documentation/git-bundle.txt
index 51f8dd463f..92499c452d 100644
--- a/Documentation/git-bundle.txt
+++ b/Documentation/git-bundle.txt
@@ -63,7 +63,7 @@ unbundle <file>::
 	references matching those in the list are printed. This command is
 	really plumbing, intended to be called only by `git fetch`.
 
-<git-rev-list-args>::
+`<git-rev-list-args>`::
 	A list of arguments, acceptable to `git rev-parse` and
 	`git rev-list` (and containing a named ref, see SPECIFYING REFERENCES
 	below), that specifies the specific objects and references
@@ -81,13 +81,13 @@ unbundle <file>::
 	necessarily everything in the pack (in this case, `git bundle` acts
 	like `git fetch-pack`).
 
---progress::
+`--progress`::
 	Progress status is reported on the standard error stream
 	by default when it is attached to a terminal, unless -q
 	is specified. This flag forces progress status even if
 	the standard error stream is not directed to a terminal.
 
---all-progress::
+`--all-progress`::
 	When `--stdout` is specified then progress report is
 	displayed during the object count and compression phases
 	but inhibited during the write-out phase. The reason is
@@ -98,19 +98,19 @@ unbundle <file>::
 	report for the write-out phase as well even if `--stdout` is
 	used.
 
---all-progress-implied::
+`--all-progress-implied`::
 	This is used to imply `--all-progress` whenever progress display
 	is activated.  Unlike `--all-progress` this flag doesn't actually
 	force any progress display by itself.
 
---version=<version>::
+`--version=<version>`::
 	Specify the bundle version.  Version 2 is the older format and can only be
 	used with SHA-1 repositories; the newer version 3 contains capabilities that
 	permit extensions. The default is the oldest supported format, based on the
 	hash algorithm in use.
 
--q::
---quiet::
+`-q`::
+`--quiet`::
 	This flag makes the command not to report its progress
 	on the standard error stream.
 
diff --git a/Documentation/git-cat-file.txt b/Documentation/git-cat-file.txt
index 3ac3d44fcb..ace67493f6 100644
--- a/Documentation/git-cat-file.txt
+++ b/Documentation/git-cat-file.txt
@@ -28,28 +28,28 @@ whitespace, so that the appropriate drivers can be determined.
 
 OPTIONS
 -------
-<object>::
+`<object>`::
 	The name of the object to show.
 	For a more complete list of ways to spell object names, see
 	the "SPECIFYING REVISIONS" section in linkgit:gitrevisions[7].
 
--t::
+`-t`::
 	Instead of the content, show the object type identified by
 	`<object>`.
 
--s::
+`-s`::
 	Instead of the content, show the object size identified by
 	`<object>`.
 
--e::
+`-e`::
 	Exit with zero status if `<object>` exists and is a valid
 	object. If `<object>` is of an invalid format exit with non-zero and
 	emits an error on stderr.
 
--p::
+`-p`::
 	Pretty-print the contents of `<object>` based on its type.
 
-<type>::
+`<type>`::
 	Typically this matches the real type of `<object>` but asking
 	for a type that can trivially be dereferenced from the given
 	`<object>` is also permitted.  An example is to ask for a
@@ -57,54 +57,54 @@ OPTIONS
 	or to ask for a "blob" with `<object>` being a tag object that
 	points at it.
 
---textconv::
+`--textconv`::
 	Show the content as transformed by a textconv filter. In this case,
 	`<object>` has to be of the form `<tree-ish>:<path>`, or `:<path>` in
 	order to apply the filter to the content recorded in the index at
 	`<path>`.
 
---filters::
+`--filters`::
 	Show the content as converted by the filters configured in
 	the current working tree for the given `<path>` (i.e. smudge filters,
 	end-of-line conversion, etc). In this case, `<object>` has to be of
 	the form `<tree-ish>:<path>`, or `:<path>`.
 
---path=<path>::
+`--path=<path>`::
 	For use with `--textconv` or `--filters`, to allow specifying an object
 	name and a path separately, e.g. when it is difficult to figure out
 	the revision from which the blob came.
 
---batch::
---batch=<format>::
+`--batch`::
+`--batch=<format>`::
 	Print object information and contents for each object provided
 	on stdin.  May not be combined with any other options or arguments
 	except `--textconv` or `--filters`, in which case the input lines
 	also need to specify the path, separated by whitespace.  See the
 	section `BATCH OUTPUT` below for details.
 
---batch-check::
---batch-check=<format>::
+`--batch-check`::
+`--batch-check=<format>`::
 	Print object information for each object provided on stdin.  May
 	not be combined with any other options or arguments except
 	`--textconv` or `--filters`, in which case the input lines also
 	need to specify the path, separated by whitespace.  See the
 	section `BATCH OUTPUT` below for details.
 
---batch-all-objects::
+`--batch-all-objects`::
 	Instead of reading a list of objects on stdin, perform the
 	requested batch operation on all objects in the repository and
 	any alternate object stores (not just reachable objects).
 	Requires `--batch` or `--batch-check` be specified. Note that
 	the objects are visited in order sorted by their hashes.
 
---buffer::
+`--buffer`::
 	Normally batch output is flushed after each object is output, so
 	that a process can interactively read and write from
 	`cat-file`. With this option, the output uses normal stdio
 	buffering; this is much more efficient when invoking
 	`--batch-check` on a large number of objects.
 
---unordered::
+`--unordered`::
 	When `--batch-all-objects` is in use, visit objects in an
 	order which may be more efficient for accessing the object
 	contents than hash order. The exact details of the order are
@@ -114,10 +114,10 @@ OPTIONS
 	only once, even if it is stored multiple times in the
 	repository.
 
---allow-unknown-type::
+`--allow-unknown-type`::
 	Allow `-s` or `-t` to query broken/corrupt objects of unknown type.
 
---follow-symlinks::
+`--follow-symlinks`::
 	With `--batch` or `--batch-check`, follow symlinks inside the
 	repository when requesting objects with extended SHA-1
 	expressions of the form tree-ish:path-in-tree.  Instead of
diff --git a/Documentation/git-check-attr.txt b/Documentation/git-check-attr.txt
index 0ac496700e..45ec659231 100644
--- a/Documentation/git-check-attr.txt
+++ b/Documentation/git-check-attr.txt
@@ -24,14 +24,14 @@ OPTIONS
 	paths.  If this option is used, then 'unspecified' attributes
 	will not be included in the output.
 
---cached::
+`--cached`::
 	Consider `.gitattributes` in the index only, ignoring the working tree.
 
---stdin::
+`--stdin`::
 	Read pathnames from the standard input, one per line,
 	instead of from the command-line.
 
--z::
+`-z`::
 	The output format is modified to be machine-parsable.
 	If `--stdin` is also given, input paths are separated
 	with a NUL character instead of a linefeed character.
@@ -57,10 +57,10 @@ unless `-z` is in effect, in which case NUL is used as delimiter:
 <path> is the path of a file being queried, <attribute> is an attribute
 being queried and <info> can be either:
 
-'unspecified';; when the attribute is not defined for the path.
-'unset';;	when the attribute is defined as false.
-'set';;		when the attribute is defined as true.
-<value>;;	when a value has been assigned to the attribute.
+`unspecified`;; when the attribute is not defined for the path.
+`unset`;;	when the attribute is defined as false.
+`set`;;		when the attribute is defined as true.
+`<value>`;;	when a value has been assigned to the attribute.
 
 Buffering happens as documented under the `GIT_FLUSH` option in
 linkgit:git[1].  The caller is responsible for avoiding deadlocks
diff --git a/Documentation/git-check-ignore.txt b/Documentation/git-check-ignore.txt
index 56a4f655c8..eabe8467ef 100644
--- a/Documentation/git-check-ignore.txt
+++ b/Documentation/git-check-ignore.txt
@@ -40,11 +40,11 @@ OPTIONS
 For precedence rules within and between exclude sources, see
 linkgit:gitignore[5].
 
---stdin::
+`--stdin`::
 	Read pathnames from the standard input, one per line,
 	instead of from the command-line.
 
--z::
+`-z`::
 	The output format is modified to be machine-parsable (see
 	below).  If `--stdin` is also given, input paths are separated
 	with a NUL character instead of a linefeed character.
@@ -55,7 +55,7 @@ linkgit:gitignore[5].
 	not be possible to distinguish between paths which match a
 	pattern and those which don't.
 
---no-index::
+`--no-index`::
 	Don't look in the index when undertaking the checks. This can
 	be used to debug why a path became tracked by e.g. `git add .`
 	and was not ignored by the rules as expected by the user or when
diff --git a/Documentation/git-check-mailmap.txt b/Documentation/git-check-mailmap.txt
index 302049afe4..d9a8e368c6 100644
--- a/Documentation/git-check-mailmap.txt
+++ b/Documentation/git-check-mailmap.txt
@@ -23,7 +23,7 @@ otherwise print the input as-is.
 
 OPTIONS
 -------
---stdin::
+`--stdin`::
 	Read contacts, one per line, from the standard input after exhausting
 	contacts provided on the command-line.
 
diff --git a/Documentation/git-check-ref-format.txt b/Documentation/git-check-ref-format.txt
index 77beb46e98..d97ee8892f 100644
--- a/Documentation/git-check-ref-format.txt
+++ b/Documentation/git-check-ref-format.txt
@@ -98,19 +98,19 @@ a branch.
 
 OPTIONS
 -------
---[no-]allow-onelevel::
+`--[no-]allow-onelevel`::
 	Controls whether one-level refnames are accepted (i.e.,
 	refnames that do not contain multiple `/`-separated
 	components).  The default is `--no-allow-onelevel`.
 
---refspec-pattern::
+`--refspec-pattern`::
 	Interpret <refname> as a reference name pattern for a refspec
 	(as used with remote repositories).  If this option is
 	enabled, <refname> is allowed to contain a single `*`
 	in the refspec (e.g., `foo/bar*/baz` or `foo/bar*baz/`
 	but not `foo/bar*/baz*`).
 
---normalize::
+`--normalize`::
 	Normalize 'refname' by removing any leading slash (`/`)
 	characters and collapsing runs of adjacent slashes between
 	name components into a single slash.  If the normalized
diff --git a/Documentation/git-checkout-index.txt b/Documentation/git-checkout-index.txt
index 6e49062ea3..8b70168926 100644
--- a/Documentation/git-checkout-index.txt
+++ b/Documentation/git-checkout-index.txt
@@ -22,30 +22,30 @@ Will copy all files listed from the index to the working directory
 
 OPTIONS
 -------
--u::
---index::
+`-u`::
+`--index`::
 	update stat information for the checked out entries in
 	the index file.
 
--q::
---quiet::
+`-q`::
+`--quiet`::
 	be quiet if files exist or are not in the index
 
--f::
---force::
+`-f`::
+`--force`::
 	forces overwrite of existing files
 
--a::
---all::
+`-a`::
+`--all`::
 	checks out all files in the index.  Cannot be used
 	together with explicit filenames.
 
--n::
---no-create::
+`-n`::
+`--no-create`::
 	Don't checkout new files, only refresh files already checked
 	out.
 
---prefix=<string>::
+`--prefix=<string>`::
 	When creating files, prepend <string> (usually a directory
 	including a trailing /)
 
@@ -54,17 +54,17 @@ OPTIONS
 	files from named stage.  <number> must be between 1 and 3.
 	Note: `--stage=all` automatically implies `--temp`.
 
---temp::
+`--temp`::
 	Instead of copying the files to the working directory
 	write the content to temporary files.  The temporary name
 	associations will be written to stdout.
 
---stdin::
+`--stdin`::
 	Instead of taking list of paths from the command line,
 	read list of paths from the standard input.  Paths are
 	separated by LF (i.e. one path per line) by default.
 
--z::
+`-z`::
 	Only meaningful with `--stdin`; paths are separated with
 	NUL character instead of LF.
 
diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkout.txt
index 15f9690e37..a6cd887e3c 100644
--- a/Documentation/git-checkout.txt
+++ b/Documentation/git-checkout.txt
@@ -104,19 +104,19 @@ file can be discarded to re-create the original conflicted merge result.
 
 OPTIONS
 -------
--q::
---quiet::
+`-q`::
+`--quiet`::
 	Quiet, suppress feedback messages.
 
---progress::
---no-progress::
+`--progress`::
+`--no-progress`::
 	Progress status is reported on the standard error stream
 	by default when it is attached to a terminal, unless `--quiet`
 	is specified. This flag enables progress reporting even if not
 	attached to a terminal, regardless of `--quiet`.
 
--f::
---force::
+`-f`::
+`--force`::
 	When switching branches, proceed even if the index or the
 	working tree differs from `HEAD`.  This is used to throw away
 	local changes.
@@ -124,8 +124,8 @@ OPTIONS
 When checking out paths from the index, do not fail upon unmerged
 entries; instead, unmerged entries are ignored.
 
---ours::
---theirs::
+`--ours`::
+`--theirs`::
 	When checking out paths from the index, check out stage #2
 	('ours') or #3 ('theirs') for unmerged paths.
 +
@@ -154,8 +154,8 @@ of it").
 	equivalent to running `git branch` with `-f`; see
 	linkgit:git-branch[1] for details.
 
--t::
---track::
+`-t`::
+`--track`::
 	When creating a new branch, set up "upstream" configuration. See
 	`--track` in linkgit:git-branch[1] for details.
 +
@@ -169,12 +169,12 @@ off of `origin/hack` (or `remotes/origin/hack`, or even
 guessing results in an empty name, the guessing is aborted.  You can
 explicitly give a name with `-b` in such a case.
 
---no-track::
+`--no-track`::
 	Do not set up "upstream" configuration, even if the
 	`branch.autoSetupMerge` configuration variable is true.
 
---guess::
---no-guess::
+`--guess`::
+`--no-guess`::
 	If `<branch>` is not found but there does exist a tracking
 	branch in exactly one remote (call it `<remote>`) with a
 	matching name, treat as equivalent to
@@ -197,12 +197,12 @@ linkgit:git-config[1].
 The default behavior can be set via the `checkout.guess` configuration
 variable.
 
--l::
+`-l`::
 	Create the new branch's reflog; see linkgit:git-branch[1] for
 	details.
 
--d::
---detach::
+`-d`::
+`--detach`::
 	Rather than checking out a branch to work on it, check out a
 	commit for inspection and discardable experiments.
 	This is the default behavior of `git checkout <commit>` when
@@ -234,14 +234,14 @@ branch by running `git rm -rf .` from the top level of the working tree.
 Afterwards you will be ready to prepare your new files, repopulating the
 working tree, by copying them from elsewhere, extracting a tarball, etc.
 
---ignore-skip-worktree-bits::
+`--ignore-skip-worktree-bits`::
 	In sparse checkout mode, `git checkout -- <paths>` would
 	update only entries matched by `<paths>` and sparse patterns
 	in `$GIT_DIR/info/sparse-checkout`. This option ignores
 	the sparse patterns and adds back any files in `<paths>`.
 
--m::
---merge::
+`-m`::
+`--merge`::
 	When switching branches,
 	if you have local modifications to one or more files that
 	are different between the current branch and the branch to
@@ -261,15 +261,15 @@ the conflicted merge in the specified paths.
 +
 When switching branches with `--merge`, staged changes may be lost.
 
---conflict=<style>::
+`--conflict=<style>`::
 	The same as `--merge` option above, but changes the way the
 	conflicting hunks are presented, overriding the
 	`merge.conflictStyle` configuration variable.  Possible values are
 	"merge" (default) and "diff3" (in addition to what is shown by
 	"merge" style, shows the original contents).
 
--p::
---patch::
+`-p`::
+`--patch`::
 	Interactively select hunks in the difference between the
 	`<tree-ish>` (or the index, if unspecified) and the working
 	tree.  The chosen hunks are then applied in reverse to the
@@ -282,20 +282,20 @@ section of linkgit:git-add[1] to learn how to operate the `--patch` mode.
 Note that this option uses the no overlay mode by default (see also
 `--overlay`), and currently doesn't support overlay mode.
 
---ignore-other-worktrees::
+`--ignore-other-worktrees`::
 	`git checkout` refuses when the wanted ref is already checked
 	out by another worktree. This option makes it check the ref
 	out anyway. In other words, the ref can be held by more than one
 	worktree.
 
---overwrite-ignore::
---no-overwrite-ignore::
+`--overwrite-ignore`::
+`--no-overwrite-ignore`::
 	Silently overwrite ignored files when switching branches. This
 	is the default behavior. Use `--no-overwrite-ignore` to abort
 	the operation when the new branch contains ignored files.
 
---recurse-submodules::
---no-recurse-submodules::
+`--recurse-submodules`::
+`--no-recurse-submodules`::
 	Using `--recurse-submodules` will update the content of all active
 	submodules according to the commit recorded in the superproject. If
 	local modifications in a submodule would be overwritten the checkout
@@ -304,15 +304,15 @@ Note that this option uses the no overlay mode by default (see also
 	Just like linkgit:git-submodule[1], this will detach `HEAD` of the
 	submodule.
 
---overlay::
---no-overlay::
+`--overlay`::
+`--no-overlay`::
 	In the default overlay mode, `git checkout` never
 	removes files from the index or the working tree.  When
 	specifying `--no-overlay`, files that appear in the index and
 	working tree, but not in `<tree-ish>` are removed, to make them
 	match `<tree-ish>` exactly.
 
---pathspec-from-file=<file>::
+`--pathspec-from-file=<file>`::
 	Pathspec is passed in `<file>` instead of commandline args. If
 	`<file>` is exactly `-` then standard input is used. Pathspec
 	elements are separated by LF or CR/LF. Pathspec elements can be
@@ -320,12 +320,12 @@ Note that this option uses the no overlay mode by default (see also
 	(see linkgit:git-config[1]). See also `--pathspec-file-nul` and
 	global `--literal-pathspecs`.
 
---pathspec-file-nul::
+`--pathspec-file-nul`::
 	Only meaningful with `--pathspec-from-file`. Pathspec elements are
 	separated with NUL character and all other characters are taken
 	literally (including newlines and quotes).
 
-<branch>::
+`<branch>`::
 	Branch to checkout; if it refers to a branch (i.e., a name that,
 	when prepended with `refs/heads/`, is a valid ref), then that
 	branch is checked out. Otherwise, if it refers to a valid
@@ -351,7 +351,7 @@ As a special case, you may use `"A...B"` as a shortcut for the
 merge base of `A` and `B` if there is exactly one merge base. You can
 leave out at most one of `A` and `B`, in which case it defaults to `HEAD`.
 
-<tree-ish>::
+`<tree-ish>`::
 	Tree to checkout from (when paths are given). If not specified,
 	the index will be used.
 +
diff --git a/Documentation/git-cherry-pick.txt b/Documentation/git-cherry-pick.txt
index fb12a67778..5d6021e4ca 100644
--- a/Documentation/git-cherry-pick.txt
+++ b/Documentation/git-cherry-pick.txt
@@ -50,19 +50,19 @@ OPTIONS
 	feed all <commit>... arguments to a single revision walk
 	(see a later example that uses 'maint master..next').
 
--e::
---edit::
+`-e`::
+`--edit`::
 	With this option, `git cherry-pick` will let you edit the commit
 	message prior to committing.
 
---cleanup=<mode>::
+`--cleanup=<mode>`::
 	This option determines how the commit message will be cleaned up before
 	being passed on to the commit machinery. See linkgit:git-commit[1] for more
 	details. In particular, if the '<mode>' is given a value of `scissors`,
 	scissors will be appended to `MERGE_MSG` before being passed on in the case
 	of a conflict.
 
--x::
+`-x`::
 	When recording the commit, append a line that says
 	"(cherry picked from commit ...)" to the original commit
 	message in order to indicate which commit this change was
@@ -76,7 +76,7 @@ OPTIONS
 	development branch), adding this information can be
 	useful.
 
--r::
+`-r`::
 	It used to be that the command defaulted to do `-x`
 	described above, and `-r` was to disable it.  Now the
 	default is not to do `-x` so this option is a no-op.
@@ -89,8 +89,8 @@ OPTIONS
 	the mainline and allows cherry-pick to replay the change
 	relative to the specified parent.
 
--n::
---no-commit::
+`-n`::
+`--no-commit`::
 	Usually the command automatically creates a sequence of commits.
 	This flag applies the changes necessary to cherry-pick
 	each named commit to your working tree and the index,
@@ -102,26 +102,26 @@ OPTIONS
 This is useful when cherry-picking more than one commits'
 effect to your index in a row.
 
--s::
---signoff::
+`-s`::
+`--signoff`::
 	Add a `Signed-off-by` trailer at the end of the commit message.
 	See the signoff option in linkgit:git-commit[1] for more information.
 
--S[<keyid>]::
---gpg-sign[=<keyid>]::
---no-gpg-sign::
+`-S[<keyid>]`::
+`--gpg-sign[=<keyid>]`::
+`--no-gpg-sign`::
 	GPG-sign commits. The `keyid` argument is optional and
 	defaults to the committer identity; if specified, it must be
 	stuck to the option without a space. `--no-gpg-sign` is useful to
 	countermand both `commit.gpgSign` configuration variable, and
 	earlier `--gpg-sign`.
 
---ff::
+`--ff`::
 	If the current `HEAD` is the same as the parent of the
 	cherry-pick'ed commit, then a fast forward to this commit will
 	be performed.
 
---allow-empty::
+`--allow-empty`::
 	By default, cherry-picking an empty commit will fail,
 	indicating that an explicit invocation of `git commit
 	--allow-empty` is required. This option overrides that
@@ -134,30 +134,30 @@ effect to your index in a row.
 	previous commit are dropped.  To force the inclusion of those commits
 	use `--keep-redundant-commits`.
 
---allow-empty-message::
+`--allow-empty-message`::
 	By default, cherry-picking a commit with an empty message will fail.
 	This option overrides that behavior, allowing commits with empty
 	messages to be cherry picked.
 
---keep-redundant-commits::
+`--keep-redundant-commits`::
 	If a commit being cherry picked duplicates a commit already in the
 	current history, it will become empty.  By default these
 	redundant commits cause `cherry-pick` to stop so the user can
 	examine the commit. This option overrides that behavior and
 	creates an empty commit object.  Implies `--allow-empty`.
 
---strategy=<strategy>::
+`--strategy=<strategy>`::
 	Use the given merge strategy.  Should only be used once.
 	See the MERGE STRATEGIES section in linkgit:git-merge[1]
 	for details.
 
--X<option>::
---strategy-option=<option>::
+`-X<option>`::
+`--strategy-option=<option>`::
 	Pass the merge strategy-specific option through to the
 	merge strategy.  See linkgit:git-merge[1] for details.
 
---rerere-autoupdate::
---no-rerere-autoupdate::
+`--rerere-autoupdate`::
+`--no-rerere-autoupdate`::
 	Allow the rerere mechanism to update the index with the
 	result of auto-conflict resolution if possible.
 
diff --git a/Documentation/git-cherry.txt b/Documentation/git-cherry.txt
index ab55060668..ff57fd3329 100644
--- a/Documentation/git-cherry.txt
+++ b/Documentation/git-cherry.txt
@@ -26,17 +26,17 @@ commits that do not.
 
 OPTIONS
 -------
--v::
+`-v`::
 	Show the commit subjects next to the SHA1s.
 
-<upstream>::
+`<upstream>`::
 	Upstream branch to search for equivalent commits.
 	Defaults to the upstream branch of `HEAD`.
 
-<head>::
+`<head>`::
 	Working branch; defaults to `HEAD`.
 
-<limit>::
+`<limit>`::
 	Do not report commits up to (and including) limit.
 
 EXAMPLES
diff --git a/Documentation/git-clean.txt b/Documentation/git-clean.txt
index 7923ae27a5..e782f48c2c 100644
--- a/Documentation/git-clean.txt
+++ b/Documentation/git-clean.txt
@@ -25,7 +25,7 @@ are affected.
 
 OPTIONS
 -------
--d::
+`-d`::
 	Normally, when no <path> is specified, `git clean` will not
 	recurse into untracked directories to avoid removing too much.
 	Specify `-d` to have it recurse into such directories as well.
@@ -33,34 +33,34 @@ OPTIONS
 	files matching the specified paths (with exceptions for nested
 	`git` directories mentioned under `--force`) will be removed.
 
--f::
---force::
+`-f`::
+`--force`::
 	If the Git configuration variable `clean.requireForce` is not set
 	to false, `git clean` will refuse to delete files or directories
 	unless given `-f` or `-i`.  Git will refuse to modify untracked
 	nested `git` repositories (directories with a .git subdirectory)
 	unless a second `-f` is given.
 
--i::
---interactive::
+`-i`::
+`--interactive`::
 	Show what would be done and clean files interactively. See
 	``Interactive mode'' for details.
 
--n::
---dry-run::
+`-n`::
+`--dry-run`::
 	Don't actually remove anything, just show what would be done.
 
--q::
---quiet::
+`-q`::
+`--quiet`::
 	Be quiet, only report errors, but not the files that are
 	successfully removed.
 
 -e <pattern>::
---exclude=<pattern>::
+`--exclude=<pattern>`::
 	Use the given exclude pattern in addition to the standard ignore rules
 	(see linkgit:gitignore[5]).
 
--x::
+`-x`::
 	Don't use the standard ignore rules (see linkgit:gitignore[5]), but
 	still use the ignore rules given with `-e` options from the command
 	line.  This allows removing all untracked
@@ -68,7 +68,7 @@ OPTIONS
 	conjunction with `git restore` or `git reset`) to create a pristine
 	working directory to test a clean build.
 
--X::
+`-X`::
 	Remove only files ignored by Git.  This may be useful to rebuild
 	everything from scratch, but keep manually created files.
 
@@ -94,7 +94,7 @@ You also could say `c` or `clean` above as long as the choice is unique.
 
 The main command loop has 6 subcommands.
 
-clean::
+`clean`::
 
    Start cleaning files and directories, and then quit.
 
@@ -125,11 +125,11 @@ ask each::
   to delete items. Please note that this action is not as efficient
   as the above two actions.
 
-quit::
+`quit`::
 
   This lets you quit without do cleaning.
 
-help::
+`help`::
 
   Show brief usage of interactive `git-clean`.
 
diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
index b8ca823467..935d191ae1 100644
--- a/Documentation/git-clone.txt
+++ b/Documentation/git-clone.txt
@@ -42,8 +42,8 @@ configuration variables.
 
 OPTIONS
 -------
--l::
---local::
+`-l`::
+`--local`::
 	When the repository to clone from is on a local machine,
 	this flag bypasses the normal "Git aware" transport
 	mechanism and clones the repository by making a copy of
@@ -62,14 +62,14 @@ Git transport instead.
 source repository, similar to running `cp -r src dst` while modifying
 `src`.
 
---no-hardlinks::
+`--no-hardlinks`::
 	Force the cloning process from a repository on a local
 	filesystem to copy the files under the `.git/objects`
 	directory instead of using hardlinks. This may be desirable
 	if you are trying to make a back-up of your repository.
 
--s::
---shared::
+`-s`::
+`--shared`::
 	When the repository to clone is on the local machine,
 	instead of using hard links, automatically setup
 	`.git/objects/info/alternates` to share the objects
@@ -110,7 +110,7 @@ objects from the source repository into a pack in the cloned repository.
 *NOTE*: see the NOTE for the `--shared` option, and also the
 `--dissociate` option.
 
---dissociate::
+`--dissociate`::
 	Borrow the objects from reference repositories specified
 	with the `--reference` options only to reduce network
 	transfer, and stop borrowing from them after a clone is made
@@ -121,23 +121,23 @@ objects from the source repository into a pack in the cloned repository.
 	same repository, and this option can be used to stop the
 	borrowing.
 
--q::
---quiet::
+`-q`::
+`--quiet`::
 	Operate quietly.  Progress is not reported to the standard
 	error stream.
 
--v::
---verbose::
+`-v`::
+`--verbose`::
 	Run verbosely. Does not affect the reporting of progress status
 	to the standard error stream.
 
---progress::
+`--progress`::
 	Progress status is reported on the standard error stream
 	by default when it is attached to a terminal, unless `--quiet`
 	is specified. This flag forces progress status even if the
 	standard error stream is not directed to a terminal.
 
---server-option=<option>::
+`--server-option=<option>`::
 	Transmit the given string to the server when communicating using
 	protocol version 2.  The given string must not contain a NUL or LF
 	character.  The server's handling of server options, including
@@ -145,16 +145,16 @@ objects from the source repository into a pack in the cloned repository.
 	When multiple `--server-option=<option>` are given, they are all
 	sent to the other side in the order listed on the command line.
 
--n::
---no-checkout::
+`-n`::
+`--no-checkout`::
 	No checkout of `HEAD` is performed after the clone is complete.
 
---[no-]reject-shallow::
+`--[no-]reject-shallow`::
 	Fail if the source repository is a shallow repository.
-	The 'clone.rejectShallow' configuration variable can be used to
+	The `clone.rejectShallow` configuration variable can be used to
 	specify the default.
 
---bare::
+`--bare`::
 	Make a 'bare' Git repository.  That is, instead of
 	creating `<directory>` and placing the administrative
 	files in `<directory>/.git`, make the `<directory>`
@@ -166,13 +166,13 @@ objects from the source repository into a pack in the cloned repository.
 	used, neither remote-tracking branches nor the related
 	configuration variables are created.
 
---sparse::
+`--sparse`::
 	Initialize the sparse-checkout file so the working
 	directory starts with only the files in the root
 	of the repository. The sparse-checkout file can be
 	modified to grow the working directory as needed.
 
---filter=<filter-spec>::
+`--filter=<filter-spec>`::
 	Use the partial clone feature and request that the server sends
 	a subset of reachable objects according to a given object filter.
 	When using `--filter`, the supplied `<filter-spec>` is used for
@@ -182,7 +182,7 @@ objects from the source repository into a pack in the cloned repository.
 	at least `<size>`. For more details on filter specifications, see
 	the `--filter` option in linkgit:git-rev-list[1].
 
---mirror::
+`--mirror`::
 	Set up a mirror of the source repository.  This implies `--bare`.
 	Compared to `--bare`, `--mirror` not only maps local branches of the
 	source to local branches of the target, it maps all refs (including
@@ -239,15 +239,15 @@ corresponding `--mirror` and `--no-tags` options instead.
 	tips of all branches. If you want to clone submodules shallowly,
 	also pass `--shallow-submodules`.
 
---shallow-since=<date>::
+`--shallow-since=<date>`::
 	Create a shallow clone with a history after the specified time.
 
---shallow-exclude=<revision>::
+`--shallow-exclude=<revision>`::
 	Create a shallow clone with a history, excluding commits
 	reachable from a specified remote branch or tag.  This option
 	can be specified multiple times.
 
---[no-]single-branch::
+`--[no-]single-branch`::
 	Clone only the history leading to the tip of a single branch,
 	either specified by the `--branch` option or the primary
 	branch remote's `HEAD` points at.
@@ -257,7 +257,7 @@ corresponding `--mirror` and `--no-tags` options instead.
 	branch when `--single-branch` clone was made, no remote-tracking
 	branch is created.
 
---no-tags::
+`--no-tags`::
 	Don't clone any tags, and set
 	`remote.<remote>.tagOpt=--no-tags` in the config, ensuring
 	that future `git pull` and `git fetch` operations won't follow
@@ -269,7 +269,7 @@ maintain a branch with no references other than a single cloned
 branch. This is useful e.g. to maintain minimal clones of the default
 branch of some repository for search indexing.
 
---recurse-submodules[=<pathspec>]::
+`--recurse-submodules[=<pathspec>]`::
 	After the clone is created, initialize and clone submodules
 	within based on the provided pathspec.  If no pathspec is
 	provided, all submodules are initialized and cloned.
@@ -285,10 +285,10 @@ the clone is finished. This option is ignored if the cloned repository does
 not have a worktree/checkout (i.e. if any of `--no-checkout`/`-n`, `--bare`,
 or `--mirror` is given)
 
---[no-]shallow-submodules::
+`--[no-]shallow-submodules`::
 	All submodules which are cloned will be shallow with a depth of 1.
 
---[no-]remote-submodules::
+`--[no-]remote-submodules`::
 	All submodules which are cloned will use the status of the submodule's
 	remote-tracking branch to update the submodule, rather than the
 	superproject's recorded SHA-1. Equivalent to passing `--remote` to
@@ -306,12 +306,12 @@ or `--mirror` is given)
 	The number of submodules fetched at the same time.
 	Defaults to the `submodule.fetchJobs` option.
 
-<repository>::
+`<repository>`::
 	The (possibly remote) repository to clone from.  See the
 	<<URLS,GIT URLS>> section below for more information on specifying
 	repositories.
 
-<directory>::
+`<directory>`::
 	The name of a new directory to clone into.  The "humanish"
 	part of the source repository is used if no directory is
 	explicitly given (`repo` for `/path/to/repo.git` and `foo`
diff --git a/Documentation/git-commit-graph.txt b/Documentation/git-commit-graph.txt
index 3246616b10..1e6db29d4a 100644
--- a/Documentation/git-commit-graph.txt
+++ b/Documentation/git-commit-graph.txt
@@ -21,7 +21,7 @@ Manage the serialized commit-graph file.
 
 OPTIONS
 -------
---object-dir::
+`--object-dir`::
 	Use given directory for the location of packfiles and commit-graph
 	file. This parameter exists to specify the location of an alternate
 	that only has the objects directory, not a full `.git` directory. The
@@ -31,13 +31,13 @@ OPTIONS
 	object directory, `git commit-graph ...` will exit with non-zero
 	status.
 
---[no-]progress::
+`--[no-]progress`::
 	Turn progress on/off explicitly. If neither is specified, progress is
 	shown if standard error is connected to a terminal.
 
 COMMANDS
 --------
-'write'::
+`write`::
 
 Write a commit-graph file based on the commits found in packfiles. If
 the config option `core.commitGraph` is disabled, then this command will
@@ -103,7 +103,7 @@ Finally, if `--expire-time=<datetime>` is not specified, let `datetime`
 be the current time. After writing the split commit-graph, delete all
 unused commit-graph whose modified times are older than `datetime`.
 
-'verify'::
+`verify`::
 
 Read the commit-graph file and verify its contents against the object
 database. Used to check for corrupted data.
diff --git a/Documentation/git-commit-tree.txt b/Documentation/git-commit-tree.txt
index 48a76dd029..47f21f4bcc 100644
--- a/Documentation/git-commit-tree.txt
+++ b/Documentation/git-commit-tree.txt
@@ -44,7 +44,7 @@ state was.
 
 OPTIONS
 -------
-<tree>::
+`<tree>`::
 	An existing tree object.
 
 -p <parent>::
@@ -59,9 +59,9 @@ OPTIONS
 	from the standard input. This can be given more than once and the
 	content of each file becomes its own paragraph.
 
--S[<keyid>]::
---gpg-sign[=<keyid>]::
---no-gpg-sign::
+`-S[<keyid>]`::
+`--gpg-sign[=<keyid>]`::
+`--no-gpg-sign`::
 	GPG-sign commits. The `keyid` argument is optional and
 	defaults to the committer identity; if specified, it must be
 	stuck to the option without a space. `--no-gpg-sign` is useful to
diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
index 3b22ba718c..48be5646c4 100644
--- a/Documentation/git-commit.txt
+++ b/Documentation/git-commit.txt
@@ -64,26 +64,26 @@ that, you can recover from it with `git reset`.
 
 OPTIONS
 -------
--a::
---all::
+`-a`::
+`--all`::
 	Tell the command to automatically stage files that have
 	been modified and deleted, but new files you have not
 	told Git about are not affected.
 
--p::
---patch::
+`-p`::
+`--patch`::
 	Use the interactive patch selection interface to chose
 	which changes to commit. See linkgit:git-add[1] for
 	details.
 
 -C <commit>::
---reuse-message=<commit>::
+`--reuse-message=<commit>`::
 	Take an existing commit object, and reuse the log message
 	and the authorship information (including the timestamp)
 	when creating the commit.
 
 -c <commit>::
---reedit-message=<commit>::
+`--reedit-message=<commit>`::
 	Like `-C`, but with `-c` the editor is invoked, so that
 	the user can further edit the commit message.
 
@@ -126,37 +126,37 @@ Neither "fixup!" nor "amend!" commits change authorship of
 `<commit>` when applied by `git rebase --autosquash`.
 See linkgit:git-rebase[1] for details.
 
---squash=<commit>::
+`--squash=<commit>`::
 	Construct a commit message for use with `rebase --autosquash`.
 	The commit message subject line is taken from the specified
 	commit with a prefix of "squash! ".  Can be used with additional
 	commit message options (`-m`/`-c`/`-C`/`-F`). See
 	linkgit:git-rebase[1] for details.
 
---reset-author::
+`--reset-author`::
 	When used with `-C`/`-c`/`--amend` options, or when committing after a
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
 	filename verbatim and terminate the entries with NUL, instead of LF.
 	If no format is given, implies the `--porcelain` output format.
@@ -165,22 +165,22 @@ See linkgit:git-rebase[1] for details.
 	(see linkgit:git-config[1]).
 
 -F <file>::
---file=<file>::
+`--file=<file>`::
 	Take the commit message from the given file.  Use '-' to
 	read the message from the standard input.
 
---author=<author>::
+`--author=<author>`::
 	Override the commit author. Specify an explicit author using the
 	standard `A U Thor <author@example.com>` format. Otherwise <author>
 	is assumed to be a pattern and is used to search for an existing
 	commit by that author (i.e. `git rev-list --all -i --author=<author>`);
 	the commit author is then copied from the first such commit found.
 
---date=<date>::
+`--date=<date>`::
 	Override the author date used in the commit.
 
 -m <msg>::
---message=<msg>::
+`--message=<msg>`::
 	Use the given <msg> as the commit message.
 	If multiple `-m` options are given, their values are
 	concatenated as separate paragraphs.
@@ -188,7 +188,7 @@ See linkgit:git-rebase[1] for details.
 The `-m` option is mutually exclusive with `-c`, `-C`, and `-F`.
 
 -t <file>::
---template=<file>::
+`--template=<file>`::
 	When editing the commit message, start the editor with the
 	contents in the given file.  The `commit.template` configuration
 	variable is often used to give this option implicitly to the
@@ -200,7 +200,7 @@ The `-m` option is mutually exclusive with `-c`, `-C`, and `-F`.
 
 include::signoff-option.txt[]
 
---trailer <token>[(=|:)<value>]::
+`--trailer <token>[(=|:)<value>]`::
 	Specify a (<token>, <value>) pair that should be applied as a
 	trailer. (e.g. `git commit --trailer "Signed-off-by:C O Mitter \
 	<committer@example.com>" --trailer "Helped-by:C O Mitter \
@@ -211,44 +211,44 @@ include::signoff-option.txt[]
 	a duplicated trailer is omitted, where in the run of trailers
 	each trailer would appear, and other details.
 
--n::
---no-verify::
+`-n`::
+`--no-verify`::
 	This option bypasses the pre-commit and commit-msg hooks.
 	See also linkgit:githooks[5].
 
---allow-empty::
+`--allow-empty`::
 	Usually recording a commit that has the exact same tree as its
 	sole parent commit is a mistake, and the command prevents you
 	from making such a commit.  This option bypasses the safety, and
 	is primarily for use by foreign SCM interface scripts.
 
---allow-empty-message::
+`--allow-empty-message`::
        Like `--allow-empty` this command is primarily for use by foreign
        SCM interface scripts. It allows you to create a commit with an
        empty commit message without using plumbing commands like
        linkgit:git-commit-tree[1].
 
---cleanup=<mode>::
+`--cleanup=<mode>`::
 	This option determines how the supplied commit message should be
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
 	"`#`" can be customized with `core.commentChar`.
 
 		# ------------------------ >8 ------------------------
 
-default::
+`default`::
 	Same as `strip` if the message is to be edited.
 	Otherwise `whitespace`.
 --
@@ -256,19 +256,19 @@ default::
 The default can be changed by the `commit.cleanup` configuration
 variable (see linkgit:git-config[1]).
 
--e::
---edit::
+`-e`::
+`--edit`::
 	The message taken from file with `-F`, command line with
 	`-m`, and from commit object with `-C` are usually used as
 	the commit log message unmodified. This option lets you
 	further edit the message taken from these sources.
 
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
@@ -294,18 +294,18 @@ You should understand the implications of rewriting history if you
 amend a commit that has already been published.  (See the "RECOVERING
 FROM UPSTREAM REBASE" section in linkgit:git-rebase[1].)
 
---no-post-rewrite::
+`--no-post-rewrite`::
 	Bypass the post-rewrite hook.
 
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
@@ -318,7 +318,7 @@ FROM UPSTREAM REBASE" section in linkgit:git-rebase[1].)
 	already been staged. If used together with `--allow-empty`
 	paths are also not required, and an empty commit will be created.
 
---pathspec-from-file=<file>::
+`--pathspec-from-file=<file>`::
 	Pathspec is passed in `<file>` instead of commandline args. If
 	`<file>` is exactly `-` then standard input is used. Pathspec
 	elements are separated by LF or CR/LF. Pathspec elements can be
@@ -326,13 +326,13 @@ FROM UPSTREAM REBASE" section in linkgit:git-rebase[1].)
 	(see linkgit:git-config[1]). See also `--pathspec-file-nul` and
 	global `--literal-pathspecs`.
 
---pathspec-file-nul::
+`--pathspec-file-nul`::
 	Only meaningful with `--pathspec-from-file`. Pathspec elements are
 	separated with NUL character and all other characters are taken
 	literally (including newlines and quotes).
 
--u[<mode>]::
---untracked-files[=<mode>]::
+`-u[<mode>]`::
+`--untracked-files[=<mode>]`::
 	Show untracked files.
 +
 --
@@ -350,8 +350,8 @@ The default can be changed using the `status.showUntrackedFiles`
 configuration variable documented in linkgit:git-config[1].
 --
 
--v::
---verbose::
+`-v`::
+`--verbose`::
 	Show unified diff between the `HEAD` commit and what
 	would be committed at the bottom of the commit message
 	template to help the user describe the commit by reminding
@@ -365,29 +365,29 @@ If specified twice, show in addition the unified diff between
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
 	configuration variable `commit.status`.
 
---no-status::
+`--no-status`::
 	Do not include the output of linkgit:git-status[1] in the
 	commit message template when using an editor to prepare the
 	default commit message.
 
--S[<keyid>]::
---gpg-sign[=<keyid>]::
---no-gpg-sign::
+`-S[<keyid>]`::
+`--gpg-sign[=<keyid>]`::
+`--no-gpg-sign`::
 	GPG-sign commits. The `keyid` argument is optional and
 	defaults to the committer identity; if specified, it must be
 	stuck to the option without a space. `--no-gpg-sign` is useful to
diff --git a/Documentation/git-config.txt b/Documentation/git-config.txt
index 80b646b895..b70aad6e0f 100644
--- a/Documentation/git-config.txt
+++ b/Documentation/git-config.txt
@@ -74,24 +74,24 @@ On success, the command returns the exit code 0.
 OPTIONS
 -------
 
---replace-all::
+`--replace-all`::
 	Default behavior is to replace at most one line. This replaces
 	all lines matching the key (and optionally the `value-pattern`).
 
---add::
+`--add`::
 	Adds a new line to the option without altering any existing
 	values.  This is the same as providing '^$' as the `value-pattern`
 	in `--replace-all`.
 
---get::
+`--get`::
 	Get the value for a given key (optionally filtered by a regex
 	matching the value). Returns error code 1 if the key was not
 	found and the last value if multiple key values were found.
 
---get-all::
+`--get-all`::
 	Like get, but returns all values for a multi-valued key.
 
---get-regexp::
+`--get-regexp`::
 	Like `--get-all`, but interprets the name as a regular expression and
 	writes out the key names.  Regular expression matching is currently
 	case-sensitive and done against a canonicalized version of the key
@@ -106,7 +106,7 @@ OPTIONS
 	section as name, do so for all the keys in the section and
 	list them.  Returns error code 1 if no value is found.
 
---global::
+`--global`::
 	For writing options: write to global `~/.gitconfig` file
 	rather than the repository `.git/config`, write to
 	`$XDG_CONFIG_HOME/git/config` file if this file exists and the
@@ -117,7 +117,7 @@ For reading options: read only from global `~/.gitconfig` and from
 +
 See also <<FILES>>.
 
---system::
+`--system`::
 	For writing options: write to system-wide
 	`$(prefix)/etc/gitconfig` rather than the repository
 	`.git/config`.
@@ -127,7 +127,7 @@ rather than from all available files.
 +
 See also <<FILES>>.
 
---local::
+`--local`::
 	For writing options: write to the repository `.git/config` file.
 	This is the default behavior.
 +
@@ -136,7 +136,7 @@ from all available files.
 +
 See also <<FILES>>.
 
---worktree::
+`--worktree`::
 	Similar to `--local` except that `.git/config.worktree` is
 	read from or written to if `extensions.worktreeConfig` is
 	present. If not it's the same as `--local`.
@@ -152,23 +152,23 @@ See also <<FILES>>.
 	section in linkgit:gitrevisions[7] for a more complete list of
 	ways to spell blob names.
 
---remove-section::
+`--remove-section`::
 	Remove the given section from the configuration file.
 
---rename-section::
+`--rename-section`::
 	Rename the given section to a new name.
 
---unset::
+`--unset`::
 	Remove the line matching the key from config file.
 
---unset-all::
+`--unset-all`::
 	Remove all lines matching the key from config file.
 
--l::
---list::
+`-l`::
+`--list`::
 	List all variables set in config file, along with their values.
 
---fixed-value::
+`--fixed-value`::
 	When used with the `value-pattern` argument, treat `value-pattern` as
 	an exact string instead of a regular expression. This will restrict
 	the name/value pairs that are matched to only those where the value
@@ -199,21 +199,21 @@ Valid `<type>`'s include:
   as-is.
 +
 
---bool::
---int::
---bool-or-int::
---path::
---expiry-date::
+`--bool`::
+`--int`::
+`--bool-or-int`::
+`--path`::
+`--expiry-date`::
   Historical options for selecting a type specifier. Prefer instead `--type`
   (see above).
 
---no-type::
+`--no-type`::
   Un-sets the previously set type specifier (if one was previously set). This
   option requests that `git config` not canonicalize the retrieved variable.
   `--no-type` has no effect without `--type=<type>` or `--<type>`.
 
--z::
---null::
+`-z`::
+`--null`::
 	For all options that output values and/or keys, always
 	end values with the null character (instead of a
 	newline). Use newline instead as a delimiter between
@@ -221,17 +221,17 @@ Valid `<type>`'s include:
 	output without getting confused e.g. by values that
 	contain line breaks.
 
---name-only::
+`--name-only`::
 	Output only the names of config variables for `--list` or
 	`--get-regexp`.
 
---show-origin::
+`--show-origin`::
 	Augment the output of all queried config options with the
 	origin type (file, standard input, blob, command line) and
 	the actual origin (config file path, ref, or blob id if
 	applicable).
 
---show-scope::
+`--show-scope`::
 	Similar to `--show-origin` in that it augments the output of
 	all queried config options with the scope of that value
 	(local, global, system, command).
@@ -258,12 +258,12 @@ Valid `<type>`'s include:
 (but note that `--get-color` will omit the trailing newline printed by
 `--type=color`).
 
--e::
---edit::
+`-e`::
+`--edit`::
 	Opens an editor to modify the specified config file; either
 	`--system`, `--global`, or repository (default).
 
---[no-]includes::
+`--[no-]includes`::
 	Respect `include.*` directives in config files when looking up
 	values. Defaults to `off` when a specific file is given (e.g.,
 	using `--file`, `--global`, etc) and `on` when searching all
diff --git a/Documentation/git-count-objects.txt b/Documentation/git-count-objects.txt
index a52bd618c4..6033087dbd 100644
--- a/Documentation/git-count-objects.txt
+++ b/Documentation/git-count-objects.txt
@@ -18,8 +18,8 @@ them, to help you decide when it is a good time to repack.
 
 OPTIONS
 -------
--v::
---verbose::
+`-v`::
+`--verbose`::
 	Report in more detail:
 +
 count: the number of loose objects
@@ -44,8 +44,8 @@ multiple times, one line per path. Note that if the path contains
 non-printable characters, it may be surrounded by double-quotes and
 contain C-style backslashed escape sequences.
 
--H::
---human-readable::
+`-H`::
+`--human-readable`::
 
 Print sizes in human readable format
 
diff --git a/Documentation/git-cvsexportcommit.txt b/Documentation/git-cvsexportcommit.txt
index 596512ec73..64e98c4f1d 100644
--- a/Documentation/git-cvsexportcommit.txt
+++ b/Documentation/git-cvsexportcommit.txt
@@ -34,52 +34,52 @@ parent the changeset should be done against.
 OPTIONS
 -------
 
--c::
+`-c`::
 	Commit automatically if the patch applied cleanly. It will not
 	commit if any hunks fail to apply or there were other problems.
 
--p::
+`-p`::
 	Be pedantic (paranoid) when applying patches. Invokes patch with
 	`--fuzz=0`
 
--a::
+`-a`::
 	Add authorship information. Adds Author line, and Committer (if
 	different from Author) to the message.
 
--d::
+`-d`::
 	Set an alternative CVSROOT to use.  This corresponds to the CVS
 	`-d` parameter.  Usually users will not want to set this, except
 	if using CVS in an asymmetric fashion.
 
--f::
+`-f`::
 	Force the merge even if the files are not up to date.
 
--P::
+`-P`::
 	Force the parent commit, even if it is not a direct parent.
 
--m::
+`-m`::
 	Prepend the commit message with the provided prefix.
 	Useful for patch series and the like.
 
--u::
+`-u`::
 	Update affected files from CVS repository before attempting export.
 
--k::
+`-k`::
 	Reverse CVS keyword expansion (e.g. $Revision: 1.2.3.4$
 	becomes $Revision$) in working CVS checkout before applying patch.
 
--w::
+`-w`::
 	Specify the location of the CVS checkout to use for the export. This
 	option does not require GIT_DIR to be set before execution if the
 	current directory is within a Git repository.  The default is the
 	value of `cvsexportcommit.cvsdir`.
 
--W::
+`-W`::
 	Tell cvsexportcommit that the current working directory is not only
 	a Git checkout, but also the CVS checkout.  Therefore, Git will
 	reset the working directory to the parent commit before proceeding.
 
--v::
+`-v`::
 	Verbose.
 
 CONFIGURATION
diff --git a/Documentation/git-cvsimport.txt b/Documentation/git-cvsimport.txt
index ead844944e..5caeed88ed 100644
--- a/Documentation/git-cvsimport.txt
+++ b/Documentation/git-cvsimport.txt
@@ -49,7 +49,7 @@ See linkgit:gitcvs-migration[7].
 
 OPTIONS
 -------
--v::
+`-v`::
 	Verbosity: let 'cvsimport' report what it is doing.
 
 -d <CVSROOT>::
@@ -85,17 +85,17 @@ OPTIONS
 Use `-o master` for continuing an import that was initially done by
 the old cvs2git tool.
 
--i::
+`-i`::
 	Import-only: don't perform a checkout after importing.  This option
 	ensures the working directory and index remain untouched and will
 	not create them if they do not exist.
 
--k::
+`-k`::
 	Kill keywords: will extract files with `-kk` from the CVS archive
 	to avoid noisy changesets. Highly recommended, but off by default
 	to preserve compatibility with early imported trees.
 
--u::
+`-u`::
 	Convert underscores in tag and branch names to dots.
 
 -s <subst>::
@@ -115,7 +115,7 @@ If you need to pass multiple options, separate them with a comma.
 	Instead of calling cvsps, read the provided cvsps output file. Useful
 	for debugging or when cvsps is being handled outside cvsimport.
 
--m::
+`-m`::
 	Attempt to detect merges based on the commit message. This option
 	will enable default regexes that try to capture the source
 	branch name from the commit message.
@@ -132,7 +132,7 @@ This option can be used several times to provide several detection regexes.
 -S <regex>::
 	Skip paths matching the regex.
 
--a::
+`-a`::
 	Import all commits, including recent ones. cvsimport by default
 	skips commits that have a timestamp less than 10 minutes ago.
 
@@ -165,7 +165,7 @@ It is not recommended to use this feature if you intend to
 export changes back to CVS again later with
 `git cvsexportcommit`.
 
--R::
+`-R`::
 	Generate a `$GIT_DIR/cvs-revisions` file containing a mapping from CVS
 	revision numbers to newly-created Git commit IDs.  The generated file
 	will contain one line for each (filename, revision) pair imported;
@@ -181,7 +181,7 @@ doing incremental imports.
 This option may be useful if you have CVS revision numbers stored in commit
 messages, bug-tracking systems, email archives, and the like.
 
--h::
+`-h`::
 	Print a short usage message and exit.
 
 OUTPUT
diff --git a/Documentation/git-cvsserver.txt b/Documentation/git-cvsserver.txt
index bf53d16a7f..5b7bfe6dc0 100644
--- a/Documentation/git-cvsserver.txt
+++ b/Documentation/git-cvsserver.txt
@@ -34,23 +34,23 @@ closely as possible.
 --base-path <path>::
 Prepend 'path' to requested CVSROOT
 
---strict-paths::
+`--strict-paths`::
 Don't allow recursing into subdirectories
 
---export-all::
+`--export-all`::
 Don't check for `gitcvs.enabled` in config. You also have to specify a list
 of allowed directories (see below) if you want to use this option.
 
--V::
---version::
+`-V`::
+`--version`::
 Print version information and exit
 
--h::
--H::
---help::
+`-h`::
+`-H`::
+`--help`::
 Print usage information and exit
 
-<directory>::
+`<directory>`::
 You can specify a list of allowed directories. If no directories
 are given, all are allowed. This is an additional restriction, gitcvs
 access still needs to be enabled by the `gitcvs.enabled` config option
diff --git a/Documentation/git-daemon.txt b/Documentation/git-daemon.txt
index 3f684378f4..533be2b997 100644
--- a/Documentation/git-daemon.txt
+++ b/Documentation/git-daemon.txt
@@ -46,26 +46,26 @@ An `upload-archive` also exists to serve `git archive`.
 
 OPTIONS
 -------
---strict-paths::
+`--strict-paths`::
 	Match paths exactly (i.e. don't allow "/foo/repo" when the real path is
 	"/foo/repo.git" or "/foo/repo/.git") and don't do user-relative paths.
 	`git daemon` will refuse to start when this option is enabled and no
 	whitelist is specified.
 
---base-path=<path>::
+`--base-path=<path>`::
 	Remap all the path requests as relative to the given path.
 	This is sort of "Git root" - if you run `git daemon` with
 	`--base-path=/srv/git` on `example.com`, then if you later try to pull
 	`git://example.com/hello.git`, `git daemon` will interpret the path
 	as `/srv/git/hello.git`.
 
---base-path-relaxed::
+`--base-path-relaxed`::
 	If `--base-path` is enabled and repo lookup fails, with this option
 	`git daemon` will attempt to lookup without prefixing the base path.
 	This is useful for switching to `--base-path` usage, while still
 	allowing the old paths.
 
---interpolated-path=<pathtemplate>::
+`--interpolated-path=<pathtemplate>`::
 	To support virtual hosting, an interpolated path template can be
 	used to dynamically construct alternate paths.  The template
 	supports %H for the target hostname as supplied by the client but
@@ -75,12 +75,12 @@ OPTIONS
 	After interpolation, the path is validated against the directory
 	whitelist.
 
---export-all::
+`--export-all`::
 	Allow pulling from all directories that look like Git repositories
 	(have the 'objects' and 'refs' subdirectories), even if they
 	do not have the `git-daemon-export-ok` file.
 
---inetd::
+`--inetd`::
 	Have the server run as an inetd service. Implies `--syslog` (may be
 	overridden with `--log-destination=`).
 	Incompatible with `--detach`, `--port`, `--listen`, `--user` and `--group`
@@ -94,49 +94,49 @@ OPTIONS
 	Can be given more than once.
 	Incompatible with `--inetd` option.
 
---port=<n>::
+`--port=<n>`::
 	Listen on an alternative port.  Incompatible with `--inetd` option.
 
---init-timeout=<n>::
+`--init-timeout=<n>`::
 	Timeout (in seconds) between the moment the connection is established
 	and the client request is received (typically a rather low value, since
 	that should be basically immediate).
 
---timeout=<n>::
+`--timeout=<n>`::
 	Timeout (in seconds) for specific client sub-requests. This includes
 	the time it takes for the server to process the sub-request and the
 	time spent waiting for the next client's request.
 
---max-connections=<n>::
+`--max-connections=<n>`::
 	Maximum number of concurrent clients, defaults to 32.  Set it to
 	zero for no limit.
 
---syslog::
+`--syslog`::
 	Short for `--log-destination=syslog`.
 
---log-destination=<destination>::
+`--log-destination=<destination>`::
 	Send log messages to the specified destination.
 	Note that this option does not imply `--verbose`,
 	thus by default only error conditions will be logged.
 	The <destination> must be one of:
 +
 --
-stderr::
+`stderr`::
 	Write to standard error.
 	Note that if `--detach` is specified,
 	the process disconnects from the real standard error,
 	making this destination effectively equivalent to `none`.
-syslog::
+`syslog`::
 	Write to syslog, using the `git-daemon` identifier.
-none::
+`none`::
 	Disable all logging.
 --
 +
 The default destination is `syslog` if `--inetd` or `--detach` is specified,
 otherwise `stderr`.
 
---user-path::
---user-path=<path>::
+`--user-path`::
+`--user-path=<path>`::
 	Allow {tilde}user notation to be used in requests.  When
 	specified with no parameter, requests to
 	`git://host/~alice/foo` is taken as a request to access
@@ -145,23 +145,23 @@ otherwise `stderr`.
 	taken as a request to access `path/foo` repository in
 	the home directory of user `alice`.
 
---verbose::
+`--verbose`::
 	Log details about the incoming connections and requested files.
 
---reuseaddr::
+`--reuseaddr`::
 	Use SO_REUSEADDR when binding the listening socket.
 	This allows the server to restart without waiting for
 	old connections to time out.
 
---detach::
+`--detach`::
 	Detach from the shell. Implies `--syslog`.
 
---pid-file=<file>::
+`--pid-file=<file>`::
 	Save the process id in 'file'.  Ignored when the daemon
 	is run under `--inetd`.
 
---user=<user>::
---group=<group>::
+`--user=<user>`::
+`--group=<group>`::
 	Change daemon's uid and gid before entering the service loop.
 	When only `--user` is given without `--group`, the
 	primary group ID for the user is used.  The values of
@@ -179,21 +179,21 @@ may also want to set and export `HOME` to point at the home
 directory of `<user>` before starting the daemon, and make sure any
 Git configuration files in that directory are readable by `<user>`.
 
---enable=<service>::
---disable=<service>::
+`--enable=<service>`::
+`--disable=<service>`::
 	Enable/disable the service site-wide per default.  Note
 	that a service disabled site-wide can still be enabled
 	per repository if it is marked overridable and the
 	repository enables the service with a configuration
 	item.
 
---allow-override=<service>::
---forbid-override=<service>::
+`--allow-override=<service>`::
+`--forbid-override=<service>`::
 	Allow/forbid overriding the site-wide default with per
 	repository configuration.  By default, all the services
 	may be overridden.
 
---[no-]informative-errors::
+`--[no-]informative-errors`::
 	When informative errors are turned on, `git-daemon` will report
 	more verbose errors to the client, differentiating conditions
 	like "no such repository" from "repository not exported". This
@@ -202,7 +202,7 @@ Git configuration files in that directory are readable by `<user>`.
 	errors are not enabled, all errors report "access denied" to the
 	client. The default is `--no-informative-errors`.
 
---access-hook=<path>::
+`--access-hook=<path>`::
 	Every time a client connects, first run an external command
 	specified by the <path> with service name (e.g. "upload-pack"),
 	path to the repository, hostname (%H), canonical hostname
@@ -217,7 +217,7 @@ The external command can optionally write a single line to its
 standard output to be sent to the requestor as an error message when
 it declines the service.
 
-<directory>::
+`<directory>`::
 	A directory to add to the whitelist of allowed directories. Unless
 	`--strict-paths` is specified this will also include subdirectories
 	of each named directory.
@@ -232,18 +232,18 @@ against only in a few selected repositories the daemon serves),
 the per-repository configuration file can be used to enable or
 disable them.
 
-upload-pack::
+`upload-pack`::
 	This serves `git fetch-pack` and `git ls-remote`
 	clients.  It is enabled by default, but a repository can
 	disable it by setting `daemon.uploadpack` configuration
 	item to `false`.
 
-upload-archive::
+`upload-archive`::
 	This serves `git archive --remote`.  It is disabled by
 	default, but a repository can enable it by setting
 	`daemon.uploadarch` configuration item to `true`.
 
-receive-pack::
+`receive-pack`::
 	This serves `git send-pack` clients, allowing anonymous
 	push.  It is disabled by default, as there is _no_
 	authentication in the protocol (in other words, anybody
diff --git a/Documentation/git-describe.txt b/Documentation/git-describe.txt
index a21eafa025..39cecb4ce6 100644
--- a/Documentation/git-describe.txt
+++ b/Documentation/git-describe.txt
@@ -37,8 +37,8 @@ OPTIONS
 <commit-ish>...::
 	Commit-ish object names to describe.  Defaults to `HEAD` if omitted.
 
---dirty[=<mark>]::
---broken[=<mark>]::
+`--dirty[=<mark>]`::
+`--broken[=<mark>]`::
 	Describe the state of the working tree.  When the working
 	tree matches `HEAD`, the output is the same as `git describe
 	HEAD`.  If the working tree has local modification "-dirty"
@@ -47,44 +47,44 @@ OPTIONS
 	error out, unless `--broken' is given, which appends
 	the suffix "-broken" instead.
 
---all::
+`--all`::
 	Instead of using only the annotated tags, use any ref
 	found in `refs/` namespace.  This option enables matching
 	any known branch, remote-tracking branch, or lightweight tag.
 
---tags::
+`--tags`::
 	Instead of using only the annotated tags, use any tag
 	found in `refs/tags` namespace.  This option enables matching
 	a lightweight (non-annotated) tag.
 
---contains::
+`--contains`::
 	Instead of finding the tag that predates the commit, find
 	the tag that comes after the commit, and thus contains it.
 	Automatically implies `--tags`.
 
---abbrev=<n>::
+`--abbrev=<n>`::
 	Instead of using the default 7 hexadecimal digits as the
 	abbreviated object name, use <n> digits, or as many digits
 	as needed to form a unique object name.  An <n> of 0
 	will suppress long format, only showing the closest tag.
 
---candidates=<n>::
+`--candidates=<n>`::
 	Instead of considering only the 10 most recent tags as
 	candidates to describe the input commit-ish consider
 	up to <n> candidates.  Increasing <n> above 10 will take
 	slightly longer but may produce a more accurate result.
 	An <n> of 0 will cause only exact matches to be output.
 
---exact-match::
+`--exact-match`::
 	Only output exact matches (a tag directly references the
 	supplied commit).  This is a synonym for `--candidates=0`.
 
---debug::
+`--debug`::
 	Verbosely display information about the searching strategy
 	being employed to standard error.  The tag name will still
 	be printed to standard out.
 
---long::
+`--long`::
 	Always output the long format (the tag, the number of commits
 	and the abbreviated commit name) even when it matches a tag.
 	This is useful when you want to see parts of the commit object name
@@ -115,10 +115,10 @@ OPTIONS
 	match any of the `--exclude` patterns. Use `--no-exclude` to clear and
 	reset the list of patterns.
 
---always::
+`--always`::
 	Show uniquely abbreviated commit object as fallback.
 
---first-parent::
+`--first-parent`::
 	Follow only the first parent commit upon seeing a merge commit.
 	This is useful when you wish to not match tags on branches merged
 	in the history of the target commit.
diff --git a/Documentation/git-diff-files.txt b/Documentation/git-diff-files.txt
index b0fb276b99..5a993a309f 100644
--- a/Documentation/git-diff-files.txt
+++ b/Documentation/git-diff-files.txt
@@ -34,14 +34,14 @@ The default is to diff against our branch (-2) and the
 cleanly resolved paths.  The option -0 can be given to
 omit diff output for unmerged entries and just show "Unmerged".
 
--c::
---cc::
+`-c`::
+`--cc`::
 	This compares stage 2 (our branch), stage 3 (their
 	branch) and the working tree file and outputs a combined
 	diff, similar to the way 'diff-tree' shows a merge
 	commit with these flags.
 
--q::
+`-q`::
 	Remain silent even on nonexistent files
 
 
diff --git a/Documentation/git-diff-index.txt b/Documentation/git-diff-index.txt
index 87db234e77..e95e997e2b 100644
--- a/Documentation/git-diff-index.txt
+++ b/Documentation/git-diff-index.txt
@@ -23,18 +23,18 @@ OPTIONS
 -------
 include::diff-options.txt[]
 
-<tree-ish>::
+`<tree-ish>`::
 	The id of a tree object to diff against.
 
---cached::
+`--cached`::
 	Do not consider the on-disk file at all.
 
---merge-base::
+`--merge-base`::
 	Instead of comparing <tree-ish> directly, use the merge base
 	between <tree-ish> and `HEAD` instead.  <tree-ish> must be a
 	commit.
 
--m::
+`-m`::
 	By default, files recorded in the index but not checked
 	out are reported as deleted.  This flag makes
 	`git diff-index` say that all non-checked-out files are up
diff --git a/Documentation/git-diff-tree.txt b/Documentation/git-diff-tree.txt
index 56354886a4..098e67f872 100644
--- a/Documentation/git-diff-tree.txt
+++ b/Documentation/git-diff-tree.txt
@@ -26,29 +26,29 @@ OPTIONS
 -------
 include::diff-options.txt[]
 
-<tree-ish>::
+`<tree-ish>`::
 	The id of a tree object.
 
 <path>...::
 	If provided, the results are limited to a subset of files
 	matching one of the provided pathspecs.
 
--r::
+`-r`::
         recurse into sub-trees
 
--t::
+`-t`::
 	show tree entry itself as well as subtrees.  Implies `-r`.
 
---root::
+`--root`::
 	When `--root` is specified the initial commit will be shown as a big
 	creation event. This is equivalent to a diff against the NULL tree.
 
---merge-base::
+`--merge-base`::
 	Instead of comparing the <tree-ish>s directly, use the merge
 	base between the two <tree-ish>s as the "before" side.  There
 	must be two <tree-ish>s given and they must both be commits.
 
---stdin::
+`--stdin`::
 	When `--stdin` is specified, the command does not take
 	<tree-ish> arguments from the command line.  Instead, it
 	reads lines containing either two <tree>, one <commit>, or a
@@ -68,29 +68,29 @@ newline, is printed.
 The following flags further affect the behavior when comparing
 commits (but not trees).
 
--m::
+`-m`::
 	By default, `git diff-tree --stdin` does not show
 	differences for merge commits.  With this flag, it shows
 	differences to that commit from all of its parents. See
 	also `-c`.
 
--s::
+`-s`::
 	By default, `git diff-tree --stdin` shows differences,
 	either in machine-readable form (without `-p`) or in patch
 	form (with `-p`).  This output can be suppressed.  It is
 	only useful with `-v` flag.
 
--v::
+`-v`::
 	This flag causes `git diff-tree --stdin` to also show
 	the commit message before the differences.
 
 include::pretty-options.txt[]
 
---no-commit-id::
+`--no-commit-id`::
 	`git diff-tree` outputs a line with the commit ID when
 	applicable.  This flag suppressed the commit ID output.
 
--c::
+`-c`::
 	This flag changes the way a merge commit is displayed
 	(which means it is useful only when the command is given
 	one <tree-ish>, or `--stdin`).  It shows the differences
@@ -100,7 +100,7 @@ include::pretty-options.txt[]
 	Furthermore, it lists only files which were modified
 	from all parents.
 
---cc::
+`--cc`::
 	This flag changes the way a merge commit patch is displayed,
 	in a similar way to the `-c` option. It implies the `-c`
 	and `-p` options and further compresses the patch output
@@ -110,14 +110,14 @@ include::pretty-options.txt[]
 	itself and the commit log message is not shown, just like in any other
 	"empty diff" case.
 
---combined-all-paths::
+`--combined-all-paths`::
 	This flag causes combined diffs (used for merge commits) to
 	list the name of the file from all parents.  It thus only has
 	effect when `-c` or `--cc` are specified, and is likely only
 	useful if filename changes are detected (i.e. when either
 	rename or copy detection have been requested).
 
---always::
+`--always`::
 	Show the commit itself and the commit log message even
 	if the diff itself is empty.
 
diff --git a/Documentation/git-difftool.txt b/Documentation/git-difftool.txt
index b646654941..f8b1e83404 100644
--- a/Documentation/git-difftool.txt
+++ b/Documentation/git-difftool.txt
@@ -19,31 +19,31 @@ linkgit:git-diff[1].
 
 OPTIONS
 -------
--d::
---dir-diff::
+`-d`::
+`--dir-diff`::
 	Copy the modified files to a temporary location and perform
 	a directory diff on them. This mode never prompts before
 	launching the diff tool.
 
--y::
---no-prompt::
+`-y`::
+`--no-prompt`::
 	Do not prompt before launching a diff tool.
 
---prompt::
+`--prompt`::
 	Prompt before each invocation of the diff tool.
 	This is the default behaviour; the option is provided to
 	override any configuration settings.
 
---rotate-to=<file>::
+`--rotate-to=<file>`::
 	Start showing the diff for the given path,
 	the paths before it will move to end and output.
 
---skip-to=<file>::
+`--skip-to=<file>`::
 	Start showing the diff for the given path, skipping all
 	the paths before it.
 
 -t <tool>::
---tool=<tool>::
+`--tool=<tool>`::
 	Use the diff tool specified by <tool>.  Valid values include
 	emerge, kompare, meld, and vimdiff. Run `git difftool --tool-help`
 	for the list of valid <tool> settings.
@@ -74,10 +74,10 @@ of the diff post-image.  `$MERGED` is the name of the file which is
 being compared. `$BASE` is provided for compatibility
 with custom merge tool commands and has the same value as `$MERGED`.
 
---tool-help::
+`--tool-help`::
 	Print a list of diff tools that may be used with `--tool`.
 
---[no-]symlinks::
+`--[no-]symlinks`::
 	`git difftool`'s default behavior is create symlinks to the
 	working tree when run in `--dir-diff` mode and the right-hand
 	side of the comparison yields the same content as the file in
@@ -87,14 +87,14 @@ Specifying `--no-symlinks` instructs `git difftool` to create copies
 instead.  `--no-symlinks` is the default on Windows.
 
 -x <command>::
---extcmd=<command>::
+`--extcmd=<command>`::
 	Specify a custom command for viewing diffs.
 	`git-difftool` ignores the configured defaults and runs
 	`$command $LOCAL $REMOTE` when this option is specified.
 	Additionally, `$BASE` is set in the environment.
 
--g::
---[no-]gui::
+`-g`::
+`--[no-]gui`::
 	When `git-difftool` is invoked with the `-g` or `--gui` option
 	the default diff tool will be read from the configured
 	`diff.guitool` variable instead of `diff.tool`. The `--no-gui`
@@ -102,7 +102,7 @@ instead.  `--no-symlinks` is the default on Windows.
 	is not set, we will fallback in the order of `merge.guitool`,
 	`diff.tool`, `merge.tool` until a tool is found.
 
---[no-]trust-exit-code::
+`--[no-]trust-exit-code`::
 	`git-difftool` invokes a diff tool individually on each file.
 	Errors reported by the diff tool are ignored by default.
 	Use `--trust-exit-code` to make `git-difftool` exit when an
diff --git a/Documentation/git-fast-export.txt b/Documentation/git-fast-export.txt
index 0e1db78aee..b50751b344 100644
--- a/Documentation/git-fast-export.txt
+++ b/Documentation/git-fast-export.txt
@@ -23,7 +23,7 @@ relied on by tools like `git filter-repo`).
 
 OPTIONS
 -------
---progress=<n>::
+`--progress=<n>`::
 	Insert 'progress' statements every <n> objects, to be shown by
 	`git fast-import` during import.
 
@@ -50,8 +50,8 @@ the output.  With 'rewrite', if the tagged object is a commit, it will
 rewrite the tag to tag an ancestor commit (via parent rewriting; see
 linkgit:git-rev-list[1])
 
--M::
--C::
+`-M`::
+`-C`::
 	Perform move and/or copy detection, as described in the
 	linkgit:git-diff[1] manual page, and use it to generate
 	rename and copy commands in the output dump.
@@ -59,7 +59,7 @@ linkgit:git-rev-list[1])
 Note that earlier versions of this command did not complain and
 produced incorrect results if you gave these options.
 
---export-marks=<file>::
+`--export-marks=<file>`::
 	Dumps the internal marks table to <file> when complete.
 	Marks are written one per line as `:markid SHA-1`. Only marks
 	for revisions are dumped; marks for blobs are ignored.
@@ -71,12 +71,12 @@ produced incorrect results if you gave these options.
 	The file will not be written if no new object has been
 	marked/exported.
 
---import-marks=<file>::
+`--import-marks=<file>`::
 	Before processing any input, load the marks specified in
 	<file>.  The input file must exist, must be readable, and
 	must use the same format as produced by `--export-marks`.
 
---mark-tags::
+`--mark-tags`::
 	In addition to labelling blobs and commits with mark ids, also
 	label tags.  This is useful in conjunction with
 	`--export-marks` and `--import-marks`, and is also useful (and
@@ -90,17 +90,17 @@ exported again.  If the backend uses a similar `--import-marks` file,
 this allows for incremental bidirectional exporting of the repository
 by keeping the marks the same across runs.
 
---fake-missing-tagger::
+`--fake-missing-tagger`::
 	Some old repositories have tags without a tagger.  The
 	fast-import protocol was pretty strict about that, and did not
 	allow that.  So fake a tagger to be able to fast-import the
 	output.
 
---use-done-feature::
+`--use-done-feature`::
 	Start the stream with a 'feature done' stanza, and terminate
 	it with a 'done' command.
 
---no-data::
+`--no-data`::
 	Skip output of blob objects and instead refer to blobs via
 	their original SHA-1 hash.  This is useful when rewriting the
 	directory structure or history of a repository without
@@ -108,13 +108,13 @@ by keeping the marks the same across runs.
 	resulting stream can only be used by a repository which
 	already contains the necessary objects.
 
---full-tree::
+`--full-tree`::
 	This option will cause fast-export to issue a "deleteall"
 	directive for each commit followed by a full list of all files
 	in the commit (as opposed to just listing the files which are
 	different from the commit's first parent).
 
---anonymize::
+`--anonymize`::
 	Anonymize the contents of the repository while still retaining
 	the shape of the history and stored tree.  See the section on
 	`ANONYMIZING` below.
@@ -124,7 +124,7 @@ by keeping the marks the same across runs.
 	`<to>` is omitted, map `<from>` to itself (i.e., do not
 	anonymize it). See the section on `ANONYMIZING` below.
 
---reference-excluded-parents::
+`--reference-excluded-parents`::
 	By default, running a command such as `git fast-export
 	master~5..master` will not include the commit `master~5`
 	and will make `master~4` no longer have `master~5` as
@@ -136,7 +136,7 @@ by keeping the marks the same across runs.
 	repository which already contains the necessary parent
 	commits.
 
---show-original-ids::
+`--show-original-ids`::
 	Add an extra directive to the output for commits and blobs,
 	`original-oid <SHA1SUM>`.  While such directives will likely be
 	ignored by importers such as `git-fast-import`, it may be useful
@@ -150,7 +150,7 @@ by keeping the marks the same across runs.
 	message will be re-encoded into UTF-8.  With 'no', the original
 	encoding will be preserved.
 
---refspec::
+`--refspec`::
 	Apply the specified refspec to each ref exported. Multiple of them can
 	be specified.
 
diff --git a/Documentation/git-fast-import.txt b/Documentation/git-fast-import.txt
index 7b801de61a..cfbb47665f 100644
--- a/Documentation/git-fast-import.txt
+++ b/Documentation/git-fast-import.txt
@@ -34,24 +34,24 @@ the frontend program in use.
 OPTIONS
 -------
 
---force::
+`--force`::
 	Force updating modified existing branches, even if doing
 	so would cause commits to be lost (as the new commit does
 	not contain the old commit).
 
---quiet::
+`--quiet`::
 	Disable the output shown by `--stats`, making fast-import usually
 	be silent when it is successful.  However, if the import stream
 	has directives intended to show user output (e.g. `progress`
 	directives), the corresponding messages will still be shown.
 
---stats::
+`--stats`::
 	Display some basic statistics about the objects fast-import has
 	created, the packfiles they were stored into, and the
 	memory used by fast-import during this run.  Showing this output
 	is currently the default, but can be disabled with `--quiet`.
 
---allow-unsafe-features::
+`--allow-unsafe-features`::
 	Many command-line options can be provided as part of the
 	fast-import stream itself by using the `feature` or `option`
 	commands. However, some of these options are unsafe (e.g.,
@@ -69,19 +69,19 @@ OPTIONS
 Options for Frontends
 ~~~~~~~~~~~~~~~~~~~~~
 
---cat-blob-fd=<fd>::
+`--cat-blob-fd=<fd>`::
 	Write responses to `get-mark`, `cat-blob`, and `ls` queries to the
 	file descriptor <fd> instead of `stdout`.  Allows `progress`
 	output intended for the end-user to be separated from other
 	output.
 
---date-format=<fmt>::
+`--date-format=<fmt>`::
 	Specify the type of dates the frontend will supply to
 	fast-import within `author`, `committer` and `tagger` commands.
 	See ``Date Formats'' below for details about which formats
 	are supported, and their syntax.
 
---done::
+`--done`::
 	Terminate with error if there is no `done` command at the end of
 	the stream.  This option might be useful for detecting errors
 	that cause the frontend to terminate before it has started to
@@ -90,7 +90,7 @@ Options for Frontends
 Locations of Marks Files
 ~~~~~~~~~~~~~~~~~~~~~~~~
 
---export-marks=<file>::
+`--export-marks=<file>`::
 	Dumps the internal marks table to <file> when complete.
 	Marks are written one per line as `:markid SHA-1`.
 	Frontends can use this file to validate imports after they
@@ -99,7 +99,7 @@ Locations of Marks Files
 	at checkpoint (or completion) the same path can also be
 	safely given to `--import-marks`.
 
---import-marks=<file>::
+`--import-marks=<file>`::
 	Before processing any input, load the marks specified in
 	<file>.  The input file must exist, must be readable, and
 	must use the same format as produced by `--export-marks`.
@@ -107,11 +107,11 @@ Locations of Marks Files
 	set of marks.  If a mark is defined to different values,
 	the last file wins.
 
---import-marks-if-exists=<file>::
+`--import-marks-if-exists=<file>`::
 	Like `--import-marks` but instead of erroring out, silently
 	skips the file if it does not exist.
 
---[no-]relative-marks::
+`--[no-]relative-marks`::
 	After specifying `--relative-marks` the paths specified
 	with `--import-marks`= and `--export-marks`= are relative
 	to an internal directory in the current repository.
@@ -145,21 +145,21 @@ algorithm.
 Performance and Compression Tuning
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
---active-branches=<n>::
+`--active-branches=<n>`::
 	Maximum number of branches to maintain active at once.
 	See ``Memory Utilization'' below for details.  Default is 5.
 
---big-file-threshold=<n>::
+`--big-file-threshold=<n>`::
 	Maximum size of a blob that fast-import will attempt to
 	create a delta for, expressed in bytes.  The default is 512m
 	(512 MiB).  Some importers may wish to lower this on systems
 	with constrained memory.
 
---depth=<n>::
+`--depth=<n>`::
 	Maximum delta depth, for blob and tree deltification.
 	Default is 50.
 
---export-pack-edges=<file>::
+`--export-pack-edges=<file>`::
 	After creating a packfile, print a line of data to
 	<file> listing the filename of the packfile and the last
 	commit on each branch that was written to that packfile.
@@ -168,7 +168,7 @@ Performance and Compression Tuning
 	as these commits can be used as edge points during calls
 	to `git pack-objects`.
 
---max-pack-size=<n>::
+`--max-pack-size=<n>`::
 	Maximum size of each output packfile.
 	The default is unlimited.
 
@@ -1141,17 +1141,17 @@ it does not.
 
 The <feature> part of the command may be any one of the following:
 
-date-format::
-export-marks::
-relative-marks::
-no-relative-marks::
-force::
+`date-format`::
+`export-marks`::
+`relative-marks`::
+`no-relative-marks`::
+`force`::
 	Act as though the corresponding command-line option with
 	a leading `--` was passed on the command line
 	(see OPTIONS, above).
 
-import-marks::
-import-marks-if-exists::
+`import-marks`::
+`import-marks-if-exists`::
 	Like `--import-marks` except in two respects: first, only one
 	"feature import-marks" or "feature import-marks-if-exists"
 	command is allowed per stream; second, an `--import-marks=`
@@ -1160,9 +1160,9 @@ import-marks-if-exists::
 	"feature import-marks-if-exists" like a corresponding
 	command-line option silently skips a nonexistent file.
 
-get-mark::
-cat-blob::
-ls::
+`get-mark`::
+`cat-blob`::
+`ls`::
 	Require that the backend support the 'get-mark', 'cat-blob',
 	or 'ls' command respectively.
 	Versions of fast-import not supporting the specified command
@@ -1171,13 +1171,13 @@ ls::
 	rather than wasting time on the early part of an import
 	before the unsupported command is detected.
 
-notes::
+`notes`::
 	Require that the backend support the 'notemodify' (N)
 	subcommand to the 'commit' command.
 	Versions of fast-import not supporting notes will exit
 	with a message indicating so.
 
-done::
+`done`::
 	Error out if the stream ends without a 'done' command.
 	Without this feature, errors causing the frontend to end
 	abruptly at a convenient point in the stream can go
diff --git a/Documentation/git-fetch-pack.txt b/Documentation/git-fetch-pack.txt
index 3d829538b0..e7e4ed214a 100644
--- a/Documentation/git-fetch-pack.txt
+++ b/Documentation/git-fetch-pack.txt
@@ -32,10 +32,10 @@ have a common ancestor commit.
 
 OPTIONS
 -------
---all::
+`--all`::
 	Fetch all remote refs.
 
---stdin::
+`--stdin`::
 	Take the list of refs from stdin, one per line. If there
 	are refs specified on the command line in addition to this
 	option, then the refs from stdin are processed after those
@@ -45,29 +45,29 @@ If `--stateless-rpc` is specified together with this option then
 the list of refs must be in packet format (pkt-line). Each ref must
 be in a separate packet, and the list must end with a flush packet.
 
--q::
---quiet::
+`-q`::
+`--quiet`::
 	Pass `-q` flag to `git unpack-objects`; this makes the
 	cloning process less verbose.
 
--k::
---keep::
+`-k`::
+`--keep`::
 	Do not invoke `git unpack-objects` on received data, but
 	create a single packfile out of it instead, and store it
 	in the object database. If provided twice then the pack is
 	locked against repacking.
 
---thin::
+`--thin`::
 	Fetch a "thin" pack, which records objects in deltified form based
 	on objects not included in the pack to reduce network traffic.
 
---include-tag::
+`--include-tag`::
 	If the remote side supports it, annotated tags objects will
 	be downloaded on the same connection as the other objects if
 	the object the tag references is downloaded.  The caller must
 	otherwise determine the tags this option made available.
 
---upload-pack=<git-upload-pack>::
+`--upload-pack=<git-upload-pack>`::
 	Use this to specify the path to `git-upload-pack` on the
 	remote side, if is not found on your `$PATH`.
 	Installations of sshd ignores the user's environment
@@ -79,39 +79,39 @@ be in a separate packet, and the list must end with a flush packet.
 	shells by having a lean `.bashrc` file (they set most of
 	the things up in `.bash_profile`).
 
---exec=<git-upload-pack>::
+`--exec=<git-upload-pack>`::
 	Same as `--upload-pack`=<git-upload-pack>.
 
---depth=<n>::
+`--depth=<n>`::
 	Limit fetching to ancestor-chains not longer than n.
 	`git-upload-pack` treats the special depth 2147483647 as
 	infinite even if there is an ancestor-chain that long.
 
---shallow-since=<date>::
+`--shallow-since=<date>`::
 	Deepen or shorten the history of a shallow repository to
 	include all reachable commits after <date>.
 
---shallow-exclude=<revision>::
+`--shallow-exclude=<revision>`::
 	Deepen or shorten the history of a shallow repository to
 	exclude commits reachable from a specified remote branch or tag.
 	This option can be specified multiple times.
 
---deepen-relative::
+`--deepen-relative`::
 	Argument `--depth` specifies the number of commits from the
 	current shallow boundary instead of from the tip of each
 	remote branch history.
 
---no-progress::
+`--no-progress`::
 	Do not show the progress.
 
---check-self-contained-and-connected::
+`--check-self-contained-and-connected`::
 	Output "connectivity-ok" if the received pack is
 	self-contained and connected.
 
--v::
+`-v`::
 	Run verbosely.
 
-<repository>::
+`<repository>`::
 	The URL to the remote repository.
 
 <refs>...::
diff --git a/Documentation/git-fetch.txt b/Documentation/git-fetch.txt
index 11ee865969..79c7f15904 100644
--- a/Documentation/git-fetch.txt
+++ b/Documentation/git-fetch.txt
@@ -48,7 +48,7 @@ include::fetch-options.txt[]
 
 include::pull-fetch-param.txt[]
 
---stdin::
+`--stdin`::
 	Read refspecs, one per line, from stdin in addition to those provided
 	as arguments. The "tag <name>" format is not supported.
 
@@ -212,7 +212,7 @@ In compact output mode, specified with configuration variable
 other string, it will be substituted with `*` in the other string. For
 example, `master -> origin/master` becomes `master -> origin/*`.
 
-flag::
+`flag`::
 	A single character indicating the status of the ref:
 (space);; for a successfully fetched fast-forward;
 `+`;; for a successful forced update;
@@ -222,22 +222,22 @@ flag::
 `!`;; for a ref that was rejected or failed to update; and
 `=`;; for a ref that was up to date and did not need fetching.
 
-summary::
+`summary`::
 	For a successfully fetched ref, the summary shows the old and new
 	values of the ref in a form suitable for using as an argument to
 	`git log` (this is `<old>..<new>` in most cases, and
 	`<old>...<new>` for forced non-fast-forward updates).
 
-from::
+`from`::
 	The name of the remote ref being fetched from, minus its
 	`refs/<type>/` prefix. In the case of deletion, the name of
 	the remote ref is "(none)".
 
-to::
+`to`::
 	The name of the local ref being updated, minus its
 	`refs/<type>/` prefix.
 
-reason::
+`reason`::
 	A human-readable explanation. In the case of successfully fetched
 	refs, no explanation is needed. For a failed ref, the reason for
 	failure is described.
diff --git a/Documentation/git-filter-branch.txt b/Documentation/git-filter-branch.txt
index 8b19805695..4a72e4ce44 100644
--- a/Documentation/git-filter-branch.txt
+++ b/Documentation/git-filter-branch.txt
@@ -185,7 +185,7 @@ be removed, buyer beware. There is also no support for changing the
 author or timestamp (or the tag message for that matter). Tags which point
 to other tags will be rewritten to point to the underlying commit.
 
---prune-empty::
+`--prune-empty`::
 	Some filters will generate empty commits that leave the tree untouched.
 	This option instructs `git-filter-branch` to remove such commits if they
 	have exactly one or zero non-pruned parents; merge commits will
@@ -205,8 +205,8 @@ to other tags will be rewritten to point to the underlying commit.
 	does this in the `.git-rewrite/` directory but you can override
 	that choice by this parameter.
 
--f::
---force::
+`-f`::
+`--force`::
 	`git filter-branch` refuses to start with an existing temporary
 	directory or when there are already refs starting with
 	`refs/original/`, unless forced.
diff --git a/Documentation/git-fmt-merge-msg.txt b/Documentation/git-fmt-merge-msg.txt
index a8e9ab914d..283bb59199 100644
--- a/Documentation/git-fmt-merge-msg.txt
+++ b/Documentation/git-fmt-merge-msg.txt
@@ -24,18 +24,18 @@ automatically invoking `git merge`.
 OPTIONS
 -------
 
---log[=<n>]::
+`--log[=<n>]`::
 	In addition to branch names, populate the log message with
 	one-line descriptions from the actual commits that are being
 	merged.  At most <n> commits from each merge parent will be
 	used (20 if <n> is omitted).  This overrides the `merge.log`
 	configuration variable.
 
---no-log::
+`--no-log`::
 	Do not list one-line descriptions from the actual commits being
 	merged.
 
---[no-]summary::
+`--[no-]summary`::
 	Synonyms to `--log` and `--no-log`; these are deprecated and will be
 	removed in the future.
 
diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
index 518f040fcd..74be946d9d 100644
--- a/Documentation/git-for-each-ref.txt
+++ b/Documentation/git-for-each-ref.txt
@@ -32,19 +32,19 @@ OPTIONS
 	literally, in the latter case matching completely or from the
 	beginning up to a slash.
 
---count=<count>::
+`--count=<count>`::
 	By default the command shows all refs that match
 	`<pattern>`.  This option makes it stop after showing
 	that many refs.
 
---sort=<key>::
+`--sort=<key>`::
 	A field name to sort on.  Prefix `-` to sort in
 	descending order of the value.  When unspecified,
 	`refname` is used.  You may use the `--sort=<key>` option
 	multiple times, in which case the last key becomes the primary
 	key.
 
---format=<format>::
+`--format=<format>`::
 	A string that interpolates `%(fieldname)` from a ref being shown
 	and the object it points at.  If `fieldname`
 	is prefixed with an asterisk (`*`) and the ref points
@@ -57,40 +57,40 @@ OPTIONS
 	`xx`; for example `%00` interpolates to `\0` (NUL),
 	`%09` to `\t` (TAB) and `%0a` to `\n` (LF).
 
---color[=<when>]::
+`--color[=<when>]`::
 	Respect any colors specified in the `--format` option. The
 	`<when>` field must be one of `always`, `never`, or `auto` (if
 	`<when>` is absent, behave as if `always` was given).
 
---shell::
---perl::
---python::
---tcl::
+`--shell`::
+`--perl`::
+`--python`::
+`--tcl`::
 	If given, strings that substitute `%(fieldname)`
 	placeholders are quoted as string literals suitable for
 	the specified host language.  This is meant to produce
 	a scriptlet that can directly be `eval`ed.
 
---points-at=<object>::
+`--points-at=<object>`::
 	Only list refs which points at the given object.
 
---merged[=<object>]::
+`--merged[=<object>]`::
 	Only list refs whose tips are reachable from the
 	specified commit (`HEAD` if not specified).
 
---no-merged[=<object>]::
+`--no-merged[=<object>]`::
 	Only list refs whose tips are not reachable from the
 	specified commit (`HEAD` if not specified).
 
---contains[=<object>]::
+`--contains[=<object>]`::
 	Only list refs which contain the specified commit (`HEAD` if not
 	specified).
 
---no-contains[=<object>]::
+`--no-contains[=<object>]`::
 	Only list refs which don't contain the specified commit (`HEAD`
 	if not specified).
 
---ignore-case::
+`--ignore-case`::
 	Sorting and filtering refs are case insensitive.
 
 FIELD NAMES
@@ -102,7 +102,7 @@ keys.
 
 For all objects, the following names can be used:
 
-refname::
+`refname`::
 	The name of the ref (the part after `$GIT_DIR`/).
 	For a non-ambiguous short name of the ref append `:short`.
 	The option `core.warnAmbiguousRefs` is used to select the strict
@@ -121,25 +121,25 @@ refname::
 +
 `strip` can be used as a synonym to `lstrip`.
 
-objecttype::
+`objecttype`::
 	The type of the object (`blob`, `tree`, `commit`, `tag`).
 
-objectsize::
+`objectsize`::
 	The size of the object (the same as `git cat-file -s` reports).
 	Append `:disk` to get the size, in bytes, that the object takes up on
 	disk. See the note about on-disk sizes in the `CAVEATS` section below.
-objectname::
+`objectname`::
 	The object name (aka SHA-1).
 	For a non-ambiguous abbreviation of the object name append `:short`.
 	For an abbreviation of the object name with desired length append
 	`:short=<length>`, where the minimum length is MINIMUM_ABBREV. The
 	length may be exceeded to ensure unique object names.
-deltabase::
+`deltabase`::
 	This expands to the object name of the delta base for the
 	given object, if it is stored as a delta.  Otherwise it
 	expands to the null object name (all zeroes).
 
-upstream::
+`upstream`::
 	The name of a local ref which can be considered ``upstream''
 	from the displayed ref. Respects `:short`, `:lstrip` and
 	`:rstrip` in the same way as `refname` above.  Additionally
@@ -161,24 +161,24 @@ Has no effect if the ref does not have tracking information associated
 with it.  All the options apart from `nobracket` are mutually exclusive,
 but if used together the last option is selected.
 
-push::
+`push`::
 	The name of a local ref which represents the `@{push}`
 	location for the displayed ref. Respects `:short`, `:lstrip`,
 	`:rstrip`, `:track`, `:trackshort`, `:remotename`, and `:remoteref`
 	options as `upstream` does. Produces an empty string if no `@{push}`
 	ref is configured.
 
-HEAD::
+`HEAD`::
 	'*' if `HEAD` matches current ref (the checked out branch), ' '
 	otherwise.
 
-color::
+`color`::
 	Change output color. Followed by `:<colorname>`, where color
 	names are described under Values in the "CONFIGURATION FILE"
 	section of linkgit:git-config[1].  For example,
 	`%(color:bold red)`.
 
-align::
+`align`::
 	Left-, middle-, or right-align the content between
 	%(align:...) and %(end). The "align:" is followed by
 	`width=<width>` and `position=<position>` in any order
@@ -193,7 +193,7 @@ align::
 	quoted, but if nested then only the topmost level performs
 	quoting.
 
-if::
+`if`::
 	Used as %(if)...%(then)...%(end) or
 	%(if)...%(then)...%(else)...%(end).  If there is an atom with
 	value or string literal after the %(if) then everything after
@@ -206,13 +206,13 @@ if::
 	the value between the %(if:...) and %(then) atoms with the
 	given string.
 
-symref::
+`symref`::
 	The ref which the given symbolic ref refers to. If not a
 	symbolic ref, nothing is printed. Respects the `:short`,
 	`:lstrip` and `:rstrip` options in the same way as `refname`
 	above.
 
-worktreepath::
+`worktreepath`::
 	The absolute path to the worktree in which the ref is checked
 	out, if it is checked out in any linked worktree. Empty string
 	otherwise.
diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
index 3b10a6f7ea..3372e13868 100644
--- a/Documentation/git-format-patch.txt
+++ b/Documentation/git-format-patch.txt
@@ -107,7 +107,7 @@ OPTIONS
 :git-format-patch: 1
 include::diff-options.txt[]
 
--<n>::
+`-<n>`::
 	Prepare patches from the topmost <n> commits.
 
 -o <dir>::
@@ -115,52 +115,52 @@ include::diff-options.txt[]
 	Use <dir> to store the resulting files, instead of the
 	current working directory.
 
--n::
---numbered::
+`-n`::
+`--numbered`::
 	Name output in '[PATCH n/m]' format, even with a single patch.
 
--N::
---no-numbered::
+`-N`::
+`--no-numbered`::
 	Name output in '[PATCH]' format.
 
 --start-number <n>::
 	Start numbering the patches at <n> instead of 1.
 
---numbered-files::
+`--numbered-files`::
 	Output file names will be a simple number sequence
 	without the default first line of the commit appended.
 
--k::
---keep-subject::
+`-k`::
+`--keep-subject`::
 	Do not strip/add '[PATCH]' from the first line of the
 	commit log message.
 
--s::
---signoff::
+`-s`::
+`--signoff`::
 	Add a `Signed-off-by` trailer to the commit message, using
 	the committer identity of yourself.
 	See the signoff option in linkgit:git-commit[1] for more information.
 
---stdout::
+`--stdout`::
 	Print all commits to the standard output in mbox format,
 	instead of creating a file for each one.
 
---attach[=<boundary>]::
+`--attach[=<boundary>]`::
 	Create multipart/mixed attachment, the first part of
 	which is the commit message and the patch itself in the
 	second part, with `Content-Disposition: attachment`.
 
---no-attach::
+`--no-attach`::
 	Disable the creation of an attachment, overriding the
 	configuration setting.
 
---inline[=<boundary>]::
+`--inline[=<boundary>]`::
 	Create multipart/mixed attachment, the first part of
 	which is the commit message and the patch itself in the
 	second part, with `Content-Disposition: inline`.
 
---thread[=<style>]::
---no-thread::
+`--thread[=<style>]`::
+`--no-thread`::
 	Controls addition of `In-Reply-To` and `References` headers to
 	make the second and subsequent mails appear as replies to the
 	first.  Also controls generation of the `Message-Id` header to
@@ -185,14 +185,14 @@ will want to ensure that threading is disabled for `git send-email`.
 	reply to the given <message id>, which avoids breaking threads to
 	provide a new patch series.
 
---ignore-if-in-upstream::
+`--ignore-if-in-upstream`::
 	Do not include a patch that matches a commit in
 	<until>..<since>.  This will examine all patches reachable
 	from <since> but not from <until> and compare them with the
 	patches being generated, and any patch that matches is
 	ignored.
 
---cover-from-description=<mode>::
+`--cover-from-description=<mode>`::
 	Controls which parts of the cover letter will be automatically
 	populated using the branch's description.
 +
@@ -218,20 +218,20 @@ populated with placeholder text.
 	allows for useful naming of a patch series, and can be
 	combined with the `--numbered` option.
 
---filename-max-length=<n>::
+`--filename-max-length=<n>`::
 	Instead of the standard 64 bytes, chomp the generated output
 	filenames at around '<n>' bytes (too short a value will be
 	silently raised to a reasonable length).  Defaults to the
 	value of the `format.filenameMaxLength` configuration
 	variable, or 64 if unconfigured.
 
---rfc::
+`--rfc`::
 	Alias for `--subject-prefix="RFC PATCH"`. RFC means "Request For
 	Comments"; use this when sending an experimental patch for
 	discussion rather than application.
 
 -v <n>::
---reroll-count=<n>::
+`--reroll-count=<n>`::
 	Mark the series as the <n>-th iteration of the topic. The
 	output filenames have `v<n>` prepended to them, and the
 	subject prefix ("PATCH" by default, but configurable via the
@@ -244,20 +244,20 @@ populated with placeholder text.
 	with the previous version does not state exactly which
 	version the new interation is compared against.
 
---to=<email>::
+`--to=<email>`::
 	Add a `To:` header to the email headers. This is in addition
 	to any configured headers, and may be used multiple times.
 	The negated form `--no-to` discards all `To:` headers added so
 	far (from config or command line).
 
---cc=<email>::
+`--cc=<email>`::
 	Add a `Cc:` header to the email headers. This is in addition
 	to any configured headers, and may be used multiple times.
 	The negated form `--no-cc` discards all `Cc:` headers added so
 	far (from config or command line).
 
---from::
---from=<ident>::
+`--from`::
+`--from=<ident>`::
 	Use `ident` in the `From:` header of each commit email. If the
 	author ident of the commit is not textually identical to the
 	provided `ident`, place a `From:` header in the body of the
@@ -271,7 +271,7 @@ header). Note also that `git send-email` already handles this
 transformation for you, and this option should not be used if you are
 feeding the result to `git send-email`.
 
---add-header=<header>::
+`--add-header=<header>`::
 	Add an arbitrary header to the email headers.  This is in addition
 	to any configured headers, and may be used multiple times.
 	For example, `--add-header="Organization: git-foo"`.
@@ -279,19 +279,19 @@ feeding the result to `git send-email`.
 	`Cc:`, and custom) headers added so far from config or command
 	line.
 
---[no-]cover-letter::
+`--[no-]cover-letter`::
 	In addition to the patches, generate a cover letter file
 	containing the branch description, shortlog and the overall diffstat.  You can
 	fill in a description in the file before sending it out.
 
---encode-email-headers::
---no-encode-email-headers::
+`--encode-email-headers`::
+`--no-encode-email-headers`::
 	Encode email headers that have non-ASCII characters with
 	"Q-encoding" (described in RFC 2047), instead of outputting the
 	headers verbatim. Defaults to the value of the
 	`format.encodeEmailHeaders` configuration variable.
 
---interdiff=<previous>::
+`--interdiff=<previous>`::
 	As a reviewer aid, insert an interdiff into the cover letter,
 	or as commentary of the lone patch of a 1-patch series, showing
 	the differences between the previous version of the patch series and
@@ -300,7 +300,7 @@ feeding the result to `git send-email`.
 	the series being formatted (for example `git format-patch
 	--cover-letter --interdiff=feature/v1 -3 feature/v2`).
 
---range-diff=<previous>::
+`--range-diff=<previous>`::
 	As a reviewer aid, insert a range-diff (see linkgit:git-range-diff[1])
 	into the cover letter, or as commentary of the lone patch of a
 	1-patch series, showing the differences between the previous
@@ -317,14 +317,14 @@ product of `format-patch` is generated, and they are not passed to
 the underlying `range-diff` machinery used to generate the cover-letter
 material (this may change in the future).
 
---creation-factor=<percent>::
+`--creation-factor=<percent>`::
 	Used with `--range-diff`, tweak the heuristic which matches up commits
 	between the previous and current series of patches by adjusting the
 	creation/deletion cost fudge factor. See linkgit:git-range-diff[1])
 	for details.
 
---notes[=<ref>]::
---no-notes::
+`--notes[=<ref>]`::
+`--no-notes`::
 	Append the notes (see linkgit:git-notes[1]) for the commit
 	after the three-dash line.
 +
@@ -339,13 +339,13 @@ configuration options in linkgit:git-notes[1] to use this workflow).
 The default is `--no-notes`, unless the `format.notes` configuration is
 set.
 
---[no-]signature=<signature>::
+`--[no-]signature=<signature>`::
 	Add a signature to each message produced. Per RFC 3676 the signature
 	is separated from the body by a line with '-- ' on it. If the
 	signature option is omitted the signature defaults to the Git version
 	number.
 
---signature-file=<file>::
+`--signature-file=<file>`::
 	Works just like `--signature` except the signature is read from a file.
 
 --suffix=.<sfx>::
@@ -357,35 +357,35 @@ set.
 Note that the leading character does not have to be a dot; for example,
 you can use `--suffix=-patch` to get `0001-description-of-my-change-patch`.
 
--q::
---quiet::
+`-q`::
+`--quiet`::
 	Do not print the names of the generated files to standard output.
 
---no-binary::
+`--no-binary`::
 	Do not output contents of changes in binary files, instead
 	display a notice that those files changed.  Patches generated
 	using this option cannot be applied properly, but they are
 	still useful for code review.
 
---zero-commit::
+`--zero-commit`::
   Output an all-zero hash in each patch's From header instead
   of the hash of the commit.
 
---[no-]base[=<commit>]::
+`--[no-]base[=<commit>]`::
 	Record the base tree information to identify the state the
 	patch series applies to.  See the BASE TREE INFORMATION section
 	below for details. If <commit> is "auto", a base commit is
 	automatically chosen. The `--no-base` option overrides a
 	`format.useAutoBase` configuration.
 
---root::
+`--root`::
 	Treat the revision argument as a <revision range>, even if it
 	is just a single commit (that would normally be treated as a
 	<since>).  Note that root commits included in the specified
 	range are always formatted as creation patches, independently
 	of this flag.
 
---progress::
+`--progress`::
 	Show progress reports on stderr as patches are generated.
 
 CONFIGURATION
diff --git a/Documentation/git-fsck.txt b/Documentation/git-fsck.txt
index 2d90384355..f942c5a7a6 100644
--- a/Documentation/git-fsck.txt
+++ b/Documentation/git-fsck.txt
@@ -20,38 +20,38 @@ Verifies the connectivity and validity of the objects in the database.
 
 OPTIONS
 -------
-<object>::
+`<object>`::
 	An object to treat as the head of an unreachability trace.
 +
 If no objects are given, `git fsck` defaults to using the
 index file, all SHA-1 references in `refs` namespace, and all reflogs
 (unless `--no-reflogs` is given) as heads.
 
---unreachable::
+`--unreachable`::
 	Print out objects that exist but that aren't reachable from any
 	of the reference nodes.
 
---[no-]dangling::
+`--[no-]dangling`::
 	Print objects that exist but that are never 'directly' used (default).
 	`--no-dangling` can be used to omit this information from the output.
 
---root::
+`--root`::
 	Report root nodes.
 
---tags::
+`--tags`::
 	Report tags.
 
---cache::
+`--cache`::
 	Consider any object recorded in the index also as a head node for
 	an unreachability trace.
 
---no-reflogs::
+`--no-reflogs`::
 	Do not consider commits that are referenced only by an
 	entry in a reflog to be reachable.  This option is meant
 	only to search for commits that used to be in a ref, but
 	now aren't, but are still in that corresponding reflog.
 
---full::
+`--full`::
 	Check not just objects in GIT_OBJECT_DIRECTORY
 	(`$GIT_DIR/objects`), but also the ones found in alternate
 	object pools listed in GIT_ALTERNATE_OBJECT_DIRECTORIES
@@ -61,7 +61,7 @@ index file, all SHA-1 references in `refs` namespace, and all reflogs
 	object pools.  This is now default; you can turn it off
 	with `--no-full`.
 
---connectivity-only::
+`--connectivity-only`::
 	Check only the connectivity of reachable objects, making sure
 	that any objects referenced by a reachable tag, commit, or tree
 	is present. This speeds up the operation by avoiding reading
@@ -74,7 +74,7 @@ Unreachable tags, commits, and trees will also be accessed to find the
 tips of dangling segments of history. Use `--no-dangling` if you don't
 care about this output and want to speed it up further.
 
---strict::
+`--strict`::
 	Enable more strict checking, namely to catch a file mode
 	recorded with g+w bit set, which was created by older
 	versions of Git.  Existing repositories, including the
@@ -82,22 +82,22 @@ care about this output and want to speed it up further.
 	objects that triggers this check, but it is recommended
 	to check new projects with this flag.
 
---verbose::
+`--verbose`::
 	Be chatty.
 
---lost-found::
+`--lost-found`::
 	Write dangling objects into `.git/lost-found/commit/` or
 	`.git/lost-found/other/`, depending on type.  If the object is
 	a blob, the contents are written into the file, rather than
 	its object name.
 
---name-objects::
+`--name-objects`::
 	When displaying names of reachable objects, in addition to the
 	SHA-1 also display a name that describes *how* they are reachable,
 	compatible with linkgit:git-rev-parse[1], e.g.
 	`HEAD@{1234567890}~25^2:src/`.
 
---[no-]progress::
+`--[no-]progress`::
 	Progress status is reported on the standard error stream by
 	default when it is attached to a terminal, unless
 	`--no-progress` or `--verbose` is specified. `--progress` forces
diff --git a/Documentation/git-gc.txt b/Documentation/git-gc.txt
index c5c71febf5..831dbe74e0 100644
--- a/Documentation/git-gc.txt
+++ b/Documentation/git-gc.txt
@@ -34,14 +34,14 @@ linkgit:git-fast-import[1] for more details on the import case.
 OPTIONS
 -------
 
---aggressive::
+`--aggressive`::
 	Usually `git gc` runs very quickly while providing good disk
 	space utilization and performance.  This option will cause
 	`git gc` to more aggressively optimize the repository at the expense
 	of taking much more time.  The effects of this optimization are
 	mostly persistent. See the "AGGRESSIVE" section below for details.
 
---auto::
+`--auto`::
 	With this option, `git gc` checks whether any housekeeping is
 	required; if not, it exits without performing any work.
 +
@@ -54,7 +54,7 @@ other housekeeping tasks (e.g. rerere, working trees, reflog...) will
 be performed as well.
 
 
---prune=<date>::
+`--prune=<date>`::
 	Prune loose objects older than date (default is 2 weeks ago,
 	overridable by the config variable `gc.pruneExpire`).
 	`--prune=now` prunes loose objects regardless of their age and
@@ -62,17 +62,17 @@ be performed as well.
 	the repository concurrently; see "NOTES" below. `--prune` is on by
 	default.
 
---no-prune::
+`--no-prune`::
 	Do not prune any loose objects.
 
---quiet::
+`--quiet`::
 	Suppress all progress reports.
 
---force::
+`--force`::
 	Force `git gc` to run even if there may be another `git gc`
 	instance running on this repository.
 
---keep-largest-pack::
+`--keep-largest-pack`::
 	All packs except the largest pack and those marked with a
 	`.keep` files are consolidated into a single pack. When this
 	option is used, `gc.bigPackThreshold` is ignored.
diff --git a/Documentation/git-grep.txt b/Documentation/git-grep.txt
index b10a3f6bb4..478abece38 100644
--- a/Documentation/git-grep.txt
+++ b/Documentation/git-grep.txt
@@ -72,50 +72,50 @@ grep.fallbackToNoIndex::
 
 OPTIONS
 -------
---cached::
+`--cached`::
 	Instead of searching tracked files in the working tree, search
 	blobs registered in the index file.
 
---no-index::
+`--no-index`::
 	Search files in the current directory that is not managed by Git.
 
---untracked::
+`--untracked`::
 	In addition to searching in the tracked files in the working
 	tree, search also in untracked files.
 
---no-exclude-standard::
+`--no-exclude-standard`::
 	Also search in ignored files by not honoring the `.gitignore`
 	mechanism. Only useful with `--untracked`.
 
---exclude-standard::
+`--exclude-standard`::
 	Do not pay attention to ignored files specified via the `.gitignore`
 	mechanism.  Only useful when searching files in the current directory
 	with `--no-index`.
 
---recurse-submodules::
+`--recurse-submodules`::
 	Recursively search in each submodule that is active and
 	checked out in the repository.  When used in combination with the
 	<tree> option the prefix of all submodule output will be the name of
 	the parent project's <tree> object. This option has no effect
 	if `--no-index` is given.
 
--a::
---text::
+`-a`::
+`--text`::
 	Process binary files as if they were text.
 
---textconv::
+`--textconv`::
 	Honor textconv filter settings.
 
---no-textconv::
+`--no-textconv`::
 	Do not honor textconv filter settings.
 	This is the default.
 
--i::
---ignore-case::
+`-i`::
+`--ignore-case`::
 	Ignore case differences between the patterns and the
 	files.
 
--I::
+`-I`::
 	Don't match the pattern in binary files.
 
 --max-depth <depth>::
@@ -125,77 +125,77 @@ OPTIONS
 	In other words if "a*" matches a directory named "a*",
 	"*" is matched literally so `--max-depth` is still effective.
 
--r::
---recursive::
+`-r`::
+`--recursive`::
 	Same as `--max-depth=-1`; this is the default.
 
---no-recursive::
+`--no-recursive`::
 	Same as `--max-depth=0`.
 
--w::
---word-regexp::
+`-w`::
+`--word-regexp`::
 	Match the pattern only at word boundary (either begin at the
 	beginning of a line, or preceded by a non-word character; end at
 	the end of a line or followed by a non-word character).
 
--v::
---invert-match::
+`-v`::
+`--invert-match`::
 	Select non-matching lines.
 
--h::
--H::
+`-h`::
+`-H`::
 	By default, the command shows the filename for each
 	match.  `-h` option is used to suppress this output.
 	`-H` is there for completeness and does not do anything
 	except it overrides `-h` given earlier on the command
 	line.
 
---full-name::
+`--full-name`::
 	When run from a subdirectory, the command usually
 	outputs paths relative to the current directory.  This
 	option forces paths to be output relative to the project
 	top directory.
 
--E::
---extended-regexp::
--G::
---basic-regexp::
+`-E`::
+`--extended-regexp`::
+`-G`::
+`--basic-regexp`::
 	Use POSIX extended/basic regexp for patterns.  Default
 	is to use basic regexp.
 
--P::
---perl-regexp::
+`-P`::
+`--perl-regexp`::
 	Use Perl-compatible regular expressions for patterns.
 +
 Support for these types of regular expressions is an optional
 compile-time dependency. If Git wasn't compiled with support for them
 providing this option will cause it to die.
 
--F::
---fixed-strings::
+`-F`::
+`--fixed-strings`::
 	Use fixed strings for patterns (don't interpret pattern
 	as a regex).
 
--n::
---line-number::
+`-n`::
+`--line-number`::
 	Prefix the line number to matching lines.
 
---column::
+`--column`::
 	Prefix the 1-indexed byte-offset of the first match from the start of the
 	matching line.
 
--l::
---files-with-matches::
---name-only::
--L::
---files-without-match::
+`-l`::
+`--files-with-matches`::
+`--name-only`::
+`-L`::
+`--files-without-match`::
 	Instead of showing every matched line, show only the
 	names of files that contain (or do not contain) matches.
 	For better compatibility with `git diff`, `--name-only` is a
 	synonym for `--files-with-matches`.
 
--O[<pager>]::
---open-files-in-pager[=<pager>]::
+`-O[<pager>]`::
+`--open-files-in-pager[=<pager>]`::
 	Open the matching files in the pager (not the output of 'grep').
 	If the pager happens to be `less` or `vi`, and the user
 	specified only one pattern, the first file is positioned at
@@ -204,48 +204,48 @@ providing this option will cause it to die.
 	without a space. If `pager` is unspecified, the default pager
 	will be used (see `core.pager` in linkgit:git-config[1]).
 
--z::
---null::
+`-z`::
+`--null`::
 	Use \0 as the delimiter for pathnames in the output, and print
 	them verbatim. Without this option, pathnames with "unusual"
 	characters are quoted as explained for the configuration
 	variable `core.quotePath` (see linkgit:git-config[1]).
 
--o::
---only-matching::
+`-o`::
+`--only-matching`::
 	Print only the matched (non-empty) parts of a matching line, with each such
 	part on a separate output line.
 
--c::
---count::
+`-c`::
+`--count`::
 	Instead of showing every matched line, show the number of
 	lines that match.
 
---color[=<when>]::
+`--color[=<when>]`::
 	Show colored matches.
 	The value must be always (the default), never, or auto.
 
---no-color::
+`--no-color`::
 	Turn off match highlighting, even when the configuration file
 	gives the default to color output.
 	Same as `--color=never`.
 
---break::
+`--break`::
 	Print an empty line between matches from different files.
 
---heading::
+`--heading`::
 	Show the filename above the matches in that file instead of
 	at the start of each shown line.
 
--p::
---show-function::
+`-p`::
+`--show-function`::
 	Show the preceding line that contains the function name of
 	the match, unless the matching line is a function name itself.
 	The name is determined in the same way as `git diff` works out
 	patch hunk headers (see 'Defining a custom hunk-header' in
 	linkgit:gitattributes[5]).
 
--<num>::
+`-<num>`::
 -C <num>::
 --context <num>::
 	Show <num> leading and trailing lines, and place a line
@@ -261,8 +261,8 @@ providing this option will cause it to die.
 	Show <num> leading lines, and place a line containing
 	`--` between contiguous groups of matches.
 
--W::
---function-context::
+`-W`::
+`--function-context`::
 	Show the surrounding text from the previous line containing a
 	function name up to the one before the next function name,
 	effectively showing the whole function in which the match was
@@ -294,28 +294,28 @@ In future versions we may learn to support patterns containing \0 for
 more search backends, until then we'll die when the pattern type in
 question doesn't support them.
 
--e::
+`-e`::
 	The next parameter is the pattern. This option has to be
 	used for patterns starting with `-` and should be used in
 	scripts passing user input to grep.  Multiple patterns are
 	combined by 'or'.
 
---and::
---or::
---not::
+`--and`::
+`--or`::
+`--not`::
 ( ... )::
 	Specify how multiple patterns are combined using Boolean
 	expressions.  `--or` is the default operator.  `--and` has
 	higher precedence than `--or`.  `-e` has to be used for all
 	patterns.
 
---all-match::
+`--all-match`::
 	When giving multiple pattern expressions combined with `--or`,
 	this flag is specified to limit the match to files that
 	have lines to match all of them.
 
--q::
---quiet::
+`-q`::
+`--quiet`::
 	Do not output matched lines; instead, exit with status 0 when
 	there is a match and with non-zero status when there isn't.
 
diff --git a/Documentation/git-gui.txt b/Documentation/git-gui.txt
index ff66c5b1d0..ed6fe4871e 100644
--- a/Documentation/git-gui.txt
+++ b/Documentation/git-gui.txt
@@ -29,22 +29,22 @@ a fairly native interface for users.
 
 COMMANDS
 --------
-blame::
+`blame`::
 	Start a blame viewer on the specified file on the given
 	version (or working directory if not specified).
 
-browser::
+`browser`::
 	Start a tree browser showing all files in the specified
 	commit.  Files selected through the
 	browser are opened in the blame viewer.
 
-citool::
+`citool`::
 	Start `git gui` and arrange to make exactly one commit before
 	exiting and returning to the shell.  The interface is limited
 	to only commit actions, slightly reducing the application's
 	startup time and simplifying the menubar.
 
-version::
+`version`::
 	Display the currently running version of `git gui`.
 
 
diff --git a/Documentation/git-hash-object.txt b/Documentation/git-hash-object.txt
index 15c2945345..40f5574afe 100644
--- a/Documentation/git-hash-object.txt
+++ b/Documentation/git-hash-object.txt
@@ -26,17 +26,17 @@ OPTIONS
 -t <type>::
 	Specify the type (default: "blob").
 
--w::
+`-w`::
 	Actually write the object into the object database.
 
---stdin::
+`--stdin`::
 	Read the object from standard input instead of from a file.
 
---stdin-paths::
+`--stdin-paths`::
 	Read file names from the standard input, one per line, instead
 	of from the command-line.
 
---path::
+`--path`::
 	Hash object as it were located at the given path. The location of
 	file does not directly influence on the hash value, but path is
 	used to determine what Git filters should be applied to the object
@@ -46,13 +46,13 @@ OPTIONS
 	temporary files located outside of the working directory or files
 	read from stdin.
 
---no-filters::
+`--no-filters`::
 	Hash the contents as is, ignoring any input filter that would
 	have been chosen by the attributes mechanism, including the end-of-line
 	conversion. If the file is read from standard input then this
 	is always implied, unless the `--path` option is given.
 
---literally::
+`--literally`::
 	Allow `--stdin` to hash any garbage into a loose object which might not
 	otherwise pass standard object parsing or `git-fsck` checks. Useful for
 	stress-testing Git itself or reproducing characteristics of corrupt or
diff --git a/Documentation/git-help.txt b/Documentation/git-help.txt
index 2d5660f47a..070ef46a8d 100644
--- a/Documentation/git-help.txt
+++ b/Documentation/git-help.txt
@@ -42,32 +42,32 @@ This page can be displayed with `git help help` or `git help --help`
 
 OPTIONS
 -------
--a::
---all::
+`-a`::
+`--all`::
 	Prints all the available commands on the standard output. This
 	option overrides any given command or guide name.
 
---verbose::
+`--verbose`::
 	When used with `--all` print description for all recognized
 	commands. This is the default.
 
--c::
---config::
+`-c`::
+`--config`::
 	List all available configuration variables. This is a short
 	summary of the list in linkgit:git-config[1].
 
--g::
---guides::
+`-g`::
+`--guides`::
 	Prints a list of the Git concept guides on the standard output. This
 	option overrides any given command or guide name.
 
--i::
---info::
+`-i`::
+`--info`::
 	Display manual page for the command in the 'info' format. The
 	'info' program will be used for that purpose.
 
--m::
---man::
+`-m`::
+`--man`::
 	Display manual page for the command in the 'man' format. This
 	option may be used to override a value set in the
 	`help.format` configuration variable.
@@ -76,8 +76,8 @@ By default the 'man' program will be used to display the manual page,
 but the `man.viewer` configuration variable may be used to choose
 other display programs (see below).
 
--w::
---web::
+`-w`::
+`--web`::
 	Display manual page for the command in the 'web' (HTML)
 	format. A web browser will be used for that purpose.
 +
diff --git a/Documentation/git-http-backend.txt b/Documentation/git-http-backend.txt
index 4bbf4811c0..d512add556 100644
--- a/Documentation/git-http-backend.txt
+++ b/Documentation/git-http-backend.txt
@@ -190,7 +190,7 @@ ScriptAliasMatch \
 ScriptAlias /git/ /var/www/cgi-bin/gitweb.cgi/
 ----------------------------------------------------------------
 
-Lighttpd::
+`Lighttpd`::
 	Ensure that `mod_cgi`, `mod_alias`, `mod_auth`, `mod_setenv` are
 	loaded, then set `GIT_PROJECT_ROOT` appropriately and redirect
 	all requests to the CGI:
diff --git a/Documentation/git-http-fetch.txt b/Documentation/git-http-fetch.txt
index 58e92f22c6..63e447642e 100644
--- a/Documentation/git-http-fetch.txt
+++ b/Documentation/git-http-fetch.txt
@@ -21,26 +21,26 @@ silently ignored.
 
 OPTIONS
 -------
-commit-id::
+`commit-id`::
         Either the hash or the filename under [URL]/refs/ to
         pull.
 
 -a, -c, -t::
 	These options are ignored for historical reasons.
--v::
+`-v`::
 	Report what is downloaded.
 
 -w <filename>::
         Writes the commit-id into the filename under `$GIT_DIR/refs/<filename>` on
         the local end after the transfer is complete.
 
---stdin::
+`--stdin`::
 	Instead of a commit id on the command line (which is not expected in this
 	case), `git http-fetch` expects lines on stdin in the format
 
 		<commit-id>['\t'<filename-as-in--w>]
 
---packfile=<hash>::
+`--packfile=<hash>`::
 	For internal use only. Instead of a commit id on the command
 	line (which is not expected in
 	this case), `git http-fetch` fetches the packfile directly at the given
@@ -49,11 +49,11 @@ commit-id::
 	arbitrary. The output of index-pack is printed to stdout. Requires
 	`--index-pack-args`.
 
---index-pack-args=<args>::
+`--index-pack-args=<args>`::
 	For internal use only. The command to run on the contents of the
 	downloaded pack. Arguments are URL-encoded separated by spaces.
 
---recover::
+`--recover`::
 	Verify that everything reachable from target is fetched.  Used after
 	an earlier fetch is interrupted.
 
diff --git a/Documentation/git-http-push.txt b/Documentation/git-http-push.txt
index a2932ba27f..d43f84dccd 100644
--- a/Documentation/git-http-push.txt
+++ b/Documentation/git-http-push.txt
@@ -22,27 +22,27 @@ not to work and sometimes corrupts repository.
 
 OPTIONS
 -------
---all::
+`--all`::
 	Do not assume that the remote repository is complete in its
 	current state, and verify all objects in the entire local
 	ref's history exist in the remote repository.
 
---force::
+`--force`::
 	Usually, the command refuses to update a remote ref that
 	is not an ancestor of the local ref used to overwrite it.
 	This flag disables the check.  What this means is that
 	the remote repository can lose commits; use it with
 	care.
 
---dry-run::
+`--dry-run`::
 	Do everything except actually send the updates.
 
---verbose::
+`--verbose`::
 	Report the list of objects being walked locally and the
 	list of objects successfully sent to the remote repository.
 
--d::
--D::
+`-d`::
+`-D`::
 	Remove <ref> from remote repository.  The specified branch
 	cannot be the remote `HEAD`.  If `-d` is specified the following
 	other conditions must also be met:
diff --git a/Documentation/git-imap-send.txt b/Documentation/git-imap-send.txt
index 68b1fb19e2..644fa7e847 100644
--- a/Documentation/git-imap-send.txt
+++ b/Documentation/git-imap-send.txt
@@ -29,20 +29,20 @@ git format-patch --signoff --stdout --attach origin | git imap-send
 OPTIONS
 -------
 
--v::
---verbose::
+`-v`::
+`--verbose`::
 	Be verbose.
 
--q::
---quiet::
+`-q`::
+`--quiet`::
 	Be quiet.
 
---curl::
+`--curl`::
 	Use libcurl to communicate with the IMAP server, unless tunneling
 	into it.  Ignored if Git was built without the USE_CURL_FOR_IMAP_SEND
 	option set.
 
---no-curl::
+`--no-curl`::
 	Talk to the IMAP server using git's own IMAP routines instead of
 	using libcurl.  Ignored if Git was built with the NO_OPENSSL option
 	set.
diff --git a/Documentation/git-index-pack.txt b/Documentation/git-index-pack.txt
index fa859f759d..b42e095f3e 100644
--- a/Documentation/git-index-pack.txt
+++ b/Documentation/git-index-pack.txt
@@ -25,7 +25,7 @@ the objects/pack/ directory of a Git repository.
 
 OPTIONS
 -------
--v::
+`-v`::
 	Be verbose about what is going on, including progress status.
 
 -o <index-file>::
@@ -36,14 +36,14 @@ OPTIONS
 	fails if the name of packed archive does not end
 	with .pack).
 
---[no-]rev-index::
+`--[no-]rev-index`::
 	When this flag is provided, generate a reverse index
 	(a `.rev` file) corresponding to the given pack. If
 	`--verify` is given, ensure that the existing
 	reverse index is correct. Takes precedence over
 	`pack.writeReverseIndex`.
 
---stdin::
+`--stdin`::
 	When this flag is provided, the pack is read from stdin
 	instead and a copy is then written to <pack-file>. If
 	<pack-file> is not specified, the pack is written to
@@ -53,13 +53,13 @@ OPTIONS
 	prevent a race condition between this process and
 	`git repack`.
 
---fix-thin::
+`--fix-thin`::
 	Fix a "thin" pack produced by `git pack-objects --thin` (see
 	linkgit:git-pack-objects[1] for details) by adding the
 	excluded objects the deltified objects are based on to the
 	pack. This option only makes sense in conjunction with `--stdin`.
 
---keep::
+`--keep`::
 	Before moving the index into its final destination
 	create an empty .keep file for the associated pack file.
 	This option is usually necessary with `--stdin` to prevent a
@@ -67,7 +67,7 @@ OPTIONS
 	the newly constructed pack and index before refs can be
 	updated to use objects contained in the pack.
 
---keep=<msg>::
+`--keep=<msg>`::
 	Like `--keep` create a .keep file before moving the index into
 	its final destination, but rather than creating an empty file
 	place '<msg>' followed by an LF into the .keep file.  The '<msg>'
@@ -79,13 +79,13 @@ OPTIONS
 	to force the version for the generated pack index, and to force
 	64-bit index entries on objects located above the given offset.
 
---strict::
+`--strict`::
 	Die, if the pack contains broken objects or links.
 
---check-self-contained-and-connected::
+`--check-self-contained-and-connected`::
 	Die if the pack contains broken links. For internal use only.
 
---fsck-objects::
+`--fsck-objects`::
 	For internal use only.
 +
 Die if the pack contains broken objects. If the pack contains a tree
@@ -93,7 +93,7 @@ pointing to a .gitmodules blob that does not exist, prints the hash of
 that blob (for the caller to check) after the hash that goes into the
 name of the pack/idx file (see "Notes").
 
---threads=<n>::
+`--threads=<n>`::
 	Specifies the number of threads to spawn when resolving
 	deltas. This requires that index-pack be compiled with
 	pthreads otherwise this option is ignored with a warning.
@@ -103,10 +103,10 @@ name of the pack/idx file (see "Notes").
 	Specifying 0 will cause Git to auto-detect the number of CPU's
 	and use maximum 3 threads.
 
---max-input-size=<size>::
+`--max-input-size=<size>`::
 	Die, if the pack is larger than <size>.
 
---object-format=<hash-algorithm>::
+`--object-format=<hash-algorithm>`::
 	Specify the given object format (hash algorithm) for the pack.  The valid
 	values are 'sha1' and (if enabled) 'sha256'.  The default is the algorithm for
 	the current repository (set by `extensions.objectFormat`), or 'sha1' if no
diff --git a/Documentation/git-init.txt b/Documentation/git-init.txt
index 2ee178a81c..cfa190859e 100644
--- a/Documentation/git-init.txt
+++ b/Documentation/git-init.txt
@@ -40,17 +40,17 @@ the repository to another place if `--separate-git-dir` is given).
 OPTIONS
 -------
 
--q::
---quiet::
+`-q`::
+`--quiet`::
 
 Only print error and warning messages; all other output will be suppressed.
 
---bare::
+`--bare`::
 
 Create a bare repository. If `GIT_DIR` environment is not set, it is set to the
 current working directory.
 
---object-format=<format>::
+`--object-format=<format>`::
 
 Specify the given object format (hash algorithm) for the repository.  The valid
 values are 'sha1' and (if enabled) 'sha256'.  'sha1' is the default.
@@ -72,7 +72,7 @@ repository.
 If this is reinitialization, the repository will be moved to the specified path.
 
 -b <branch-name>::
---initial-branch=<branch-name>::
+`--initial-branch=<branch-name>`::
 
 Use the specified name for the initial branch in the newly created
 repository.  If not specified, fall back to the default name (currently
diff --git a/Documentation/git-instaweb.txt b/Documentation/git-instaweb.txt
index a8876b74ca..f23cebccd9 100644
--- a/Documentation/git-instaweb.txt
+++ b/Documentation/git-instaweb.txt
@@ -20,12 +20,12 @@ repository.
 OPTIONS
 -------
 
--l::
---local::
+`-l`::
+`--local`::
 	Only bind the web server to the local IP (127.0.0.1).
 
--d::
---httpd::
+`-d`::
+`--httpd`::
 	The HTTP daemon command-line that will be executed.
 	Command-line options may be specified here, and the
 	configuration file will be added at the end of the command-line.
@@ -33,36 +33,36 @@ OPTIONS
 	webrick are supported.
 	(Default: lighttpd)
 
--m::
---module-path::
+`-m`::
+`--module-path`::
 	The module path (only needed if httpd is Apache).
 	(Default: /usr/lib/apache2/modules)
 
--p::
---port::
+`-p`::
+`--port`::
 	The port number to bind the httpd to.  (Default: 1234)
 
--b::
---browser::
+`-b`::
+`--browser`::
 	The web browser that should be used to view the `gitweb`
 	page. This will be passed to the `git web--browse` helper
 	script along with the URL of the `gitweb` instance. See
 	linkgit:git-web{litdd}browse[1] for more information about this. If
 	the script fails, the URL will be printed to stdout.
 
-start::
---start::
+`start`::
+`--start`::
 	Start the httpd instance and exit.  Regenerate configuration files
 	as necessary for spawning a new instance.
 
-stop::
---stop::
+`stop`::
+`--stop`::
 	Stop the httpd instance and exit.  This does not generate
 	any of the configuration files for spawning a new instance,
 	nor does it close the browser.
 
-restart::
---restart::
+`restart`::
+`--restart`::
 	Restart the httpd instance and exit.  Regenerate configuration files
 	as necessary for spawning a new instance.
 
diff --git a/Documentation/git-interpret-trailers.txt b/Documentation/git-interpret-trailers.txt
index b687701104..dc2974c611 100644
--- a/Documentation/git-interpret-trailers.txt
+++ b/Documentation/git-interpret-trailers.txt
@@ -71,10 +71,10 @@ the encoding rules and probably many other rules.
 
 OPTIONS
 -------
---in-place::
+`--in-place`::
 	Edit the files in place.
 
---trim-empty::
+`--trim-empty`::
 	If the <value> part of any trailer contains only whitespace,
 	the whole trailer will be removed from the resulting message.
 	This applies to existing trailers as well as new trailers.
@@ -85,7 +85,7 @@ OPTIONS
 	command.
 
 --where <placement>::
---no-where::
+`--no-where`::
 	Specify where all new trailers will be added.  A setting
 	provided with `--where` overrides all configuration variables
 	and applies to all `--trailer` options until the next occurrence of
@@ -93,7 +93,7 @@ OPTIONS
 	`end` or `start`.
 
 --if-exists <action>::
---no-if-exists::
+`--no-if-exists`::
 	Specify what action will be performed when there is already at
 	least one trailer with the same <token> in the message.  A setting
 	provided with `--if-exists` overrides all configuration variables
@@ -102,7 +102,7 @@ OPTIONS
 	`addIfDifferentNeighbor`, `add`, `replace` and `doNothing`.
 
 --if-missing <action>::
---no-if-missing::
+`--no-if-missing`::
 	Specify what action will be performed when there is no other
 	trailer with the same <token> in the message.  A setting
 	provided with `--if-missing` overrides all configuration variables
@@ -110,23 +110,23 @@ OPTIONS
 	`--if-missing` or `--no-if-missing`. Possible actions are `doNothing`
 	or `add`.
 
---only-trailers::
+`--only-trailers`::
 	Output only the trailers, not any other parts of the input.
 
---only-input::
+`--only-input`::
 	Output only trailers that exist in the input; do not add any
 	from the command-line or by following configured `trailer.*`
 	rules.
 
---unfold::
+`--unfold`::
 	Remove any whitespace-continuation in trailers, so that each
 	trailer appears on a line by itself with its full content.
 
---parse::
+`--parse`::
 	A convenience alias for `--only-trailers --only-input
 	--unfold`.
 
---no-divider::
+`--no-divider`::
 	Do not treat `---` as the end of the commit message. Use this
 	when you know your input contains just the commit message itself
 	(and not an email or the output of `git format-patch`).
diff --git a/Documentation/git-log.txt b/Documentation/git-log.txt
index 43f9a5c69e..21f9328681 100644
--- a/Documentation/git-log.txt
+++ b/Documentation/git-log.txt
@@ -27,11 +27,11 @@ each commit introduces are shown.
 OPTIONS
 -------
 
---follow::
+`--follow`::
 	Continue listing the history of a file beyond renames
 	(works only for a single file).
 
---no-decorate::
+`--no-decorate`::
 --decorate[=short|full|auto|no]::
 	Print out the ref names of any commits that are shown. If 'short' is
 	specified, the ref name prefixes `refs/heads/`, `refs/tags/` and
@@ -41,8 +41,8 @@ OPTIONS
 	are shown as if 'short' were given, otherwise no ref names are
 	shown. The default option is 'short'.
 
---decorate-refs=<pattern>::
---decorate-refs-exclude=<pattern>::
+`--decorate-refs=<pattern>`::
+`--decorate-refs-exclude=<pattern>`::
 	If no `--decorate-refs` is given, pretend as if all refs were
 	included.  For each candidate, do not use it for decoration if it
 	matches any patterns given to `--decorate-refs-exclude` or if it
@@ -51,17 +51,17 @@ OPTIONS
 	the decorations, but an explicit `--decorate-refs` pattern will
 	override a match in `log.excludeDecoration`.
 
---source::
+`--source`::
 	Print out the ref name given on the command line by which each
 	commit was reached.
 
---[no-]mailmap::
---[no-]use-mailmap::
+`--[no-]mailmap`::
+`--[no-]use-mailmap`::
 	Use mailmap file to map author and committer names and email
 	addresses to canonical real names and email addresses. See
 	linkgit:git-shortlog[1].
 
---full-diff::
+`--full-diff`::
 	Without this flag, `git log -p <path>...` shows commits that
 	touch the specified paths, and diffs about the same specified
 	paths.  With this, the full diff is shown for commits that touch
@@ -71,7 +71,7 @@ OPTIONS
 Note that this affects all diff-based output types, e.g. those
 produced by `--stat`, etc.
 
---log-size::
+`--log-size`::
 	Include a line ``log size <number>'' in the output for each commit,
 	where <number> is the length of that commit's message in bytes.
 	Intended to speed up tools that read log messages from `git log`
diff --git a/Documentation/git-ls-files.txt b/Documentation/git-ls-files.txt
index 3557823de9..0e26aafc63 100644
--- a/Documentation/git-ls-files.txt
+++ b/Documentation/git-ls-files.txt
@@ -32,56 +32,56 @@ shown:
 
 OPTIONS
 -------
--c::
---cached::
+`-c`::
+`--cached`::
 	Show cached files in the output (default)
 
--d::
---deleted::
+`-d`::
+`--deleted`::
 	Show deleted files in the output
 
--m::
---modified::
+`-m`::
+`--modified`::
 	Show modified files in the output
 
--o::
---others::
+`-o`::
+`--others`::
 	Show other (i.e. untracked) files in the output
 
--i::
---ignored::
+`-i`::
+`--ignored`::
 	Show only ignored files in the output. When showing files in the
 	index, print only those matched by an exclude pattern. When
 	showing "other" files, show only those matched by an exclude
 	pattern. Standard ignore rules are not automatically activated,
 	therefore at least one of the `--exclude*` options is required.
 
--s::
---stage::
+`-s`::
+`--stage`::
 	Show staged contents' mode bits, object name and stage number in the output.
 
---directory::
+`--directory`::
 	If a whole directory is classified as "other", show just its
 	name (with a trailing slash) and not its whole contents.
 
---no-empty-directory::
+`--no-empty-directory`::
 	Do not list empty directories. Has no effect without `--directory`.
 
--u::
---unmerged::
+`-u`::
+`--unmerged`::
 	Show unmerged files in the output (forces `--stage`)
 
--k::
---killed::
+`-k`::
+`--killed`::
 	Show files on the filesystem that need to be removed due
 	to file/directory conflicts for checkout-index to
 	succeed.
 
--z::
+`-z`::
 	\0 line termination on output and do not quote filenames.
 	See OUTPUT below for more information.
 
---deduplicate::
+`--deduplicate`::
 	When only filenames are shown, suppress duplicates that may
 	come from having multiple stages during a merge, or giving
 	`--deleted` and `--modified` option at the same time.
@@ -89,35 +89,35 @@ OPTIONS
 	in use, this option has no effect.
 
 -x <pattern>::
---exclude=<pattern>::
+`--exclude=<pattern>`::
 	Skip untracked files matching pattern.
 	Note that pattern is a shell wildcard pattern. See EXCLUDE PATTERNS
 	below for more information.
 
 -X <file>::
---exclude-from=<file>::
+`--exclude-from=<file>`::
 	Read exclude patterns from <file>; 1 per line.
 
---exclude-per-directory=<file>::
+`--exclude-per-directory=<file>`::
 	Read additional exclude patterns that apply only to the
 	directory and its subdirectories in <file>.
 
---exclude-standard::
+`--exclude-standard`::
 	Add the standard Git exclusions: `.git/info/exclude`, `.gitignore`
 	in each directory, and the user's global exclusion file.
 
---error-unmatch::
+`--error-unmatch`::
 	If any <file> does not appear in the index, treat this as an
 	error (return 1).
 
---with-tree=<tree-ish>::
+`--with-tree=<tree-ish>`::
 	When using `--error-unmatch` to expand the user supplied
 	<file> (i.e. path pattern) arguments to paths, pretend
 	that paths which were removed in the index since the
 	named <tree-ish> are still present.  Using this option
 	with `-s` or `-u` options does not make any sense.
 
--t::
+`-t`::
 	This feature is semi-deprecated. For scripting purpose,
 	linkgit:git-status[1] `--porcelain` and
 	linkgit:git-diff-files[1] `--name-status` are almost always
@@ -129,48 +129,48 @@ OPTIONS
 This option identifies the file status with the following tags (followed by
 a space) at the start of each line:
 
-	H::	cached
-	S::	skip-worktree
-	M::	unmerged
-	R::	removed/deleted
-	C::	modified/changed
-	K::	to be killed
+	`H`::	cached
+	`S`::	skip-worktree
+	`M`::	unmerged
+	`R`::	removed/deleted
+	`C`::	modified/changed
+	`K`::	to be killed
 	?::	other
 --
 
--v::
+`-v`::
 	Similar to `-t`, but use lowercase letters for files
 	that are marked as 'assume unchanged' (see
 	linkgit:git-update-index[1]).
 
--f::
+`-f`::
 	Similar to `-t`, but use lowercase letters for files
 	that are marked as 'fsmonitor valid' (see
 	linkgit:git-update-index[1]).
 
---full-name::
+`--full-name`::
 	When run from a subdirectory, the command usually
 	outputs paths relative to the current directory.  This
 	option forces paths to be output relative to the project
 	top directory.
 
---recurse-submodules::
+`--recurse-submodules`::
 	Recursively calls ls-files on each active submodule in the repository.
 	Currently there is only support for the `--cached` mode.
 
---abbrev[=<n>]::
+`--abbrev[=<n>]`::
 	Instead of showing the full 40-byte hexadecimal object
 	lines, show the shortest prefix that is at least '<n>'
 	hexdigits long that uniquely refers the object.
 	Non default number of digits can be specified with `--abbrev=<n>`.
 
---debug::
+`--debug`::
 	After each line that describes a file, add more data about its
 	cache entry.  This is intended to show as much information as
 	possible for manual inspection; the exact format may change at
 	any time.
 
---eol::
+`--eol`::
 	Show <eolinfo> and <eolattr> of files.
 	<eolinfo> is the file content identification used by Git when
 	the "text" attribute is "auto" (or not set and `core.autocrlf` is not false).
@@ -190,7 +190,7 @@ followed by the  ("attr/<eolattr>").
 \--::
 	Do not interpret any more arguments as options.
 
-<file>::
+`<file>`::
 	Files to show. If no files are given all files which match the other
 	specified criteria are shown.
 
diff --git a/Documentation/git-ls-remote.txt b/Documentation/git-ls-remote.txt
index cc1525f487..6dc89de377 100644
--- a/Documentation/git-ls-remote.txt
+++ b/Documentation/git-ls-remote.txt
@@ -21,10 +21,10 @@ commit IDs.
 
 OPTIONS
 -------
--h::
---heads::
--t::
---tags::
+`-h`::
+`--heads`::
+`-t`::
+`--tags`::
 	Limit to only refs/heads and refs/tags, respectively.
 	These options are _not_ mutually exclusive; when given
 	both, references stored in refs/heads and refs/tags are
@@ -32,37 +32,37 @@ OPTIONS
 	anything else on the command line gives help, consistent
 	with other `git` subcommands.
 
---refs::
+`--refs`::
 	Do not show peeled tags or pseudorefs like `HEAD` in the output.
 
--q::
---quiet::
+`-q`::
+`--quiet`::
 	Do not print remote URL to stderr.
 
---upload-pack=<exec>::
+`--upload-pack=<exec>`::
 	Specify the full path of `git-upload-pack` on the remote
 	host. This allows listing references from repositories accessed via
 	SSH and where the SSH daemon does not use the PATH configured by the
 	user.
 
---exit-code::
+`--exit-code`::
 	Exit with status "2" when no matching refs are found in the remote
 	repository. Usually the command exits with status "0" to indicate
 	it successfully talked with the remote repository, whether it
 	found any matching refs.
 
---get-url::
+`--get-url`::
 	Expand the URL of the given remote repository taking into account any
 	`url.<base>.insteadOf` config setting (See linkgit:git-config[1]) and
 	exit without talking to the remote.
 
---symref::
+`--symref`::
 	In addition to the object pointed by it, show the underlying
 	ref pointed by it when showing a symbolic ref.  Currently,
 	upload-pack only shows the symref `HEAD`, so it will be the only
 	one shown by ls-remote.
 
---sort=<key>::
+`--sort=<key>`::
 	Sort based on the key given. Prefix `-` to sort in descending order
 	of the value. Supports "version:refname" or "v:refname" (tag names
 	are treated as versions). The "version:refname" sort order can also
@@ -73,14 +73,14 @@ OPTIONS
 	fetched from the remote, and will give a `missing object` error.
 
 -o <option>::
---server-option=<option>::
+`--server-option=<option>`::
 	Transmit the given string to the server when communicating using
 	protocol version 2.  The given string must not contain a NUL or LF
 	character.
 	When multiple `--server-option=<option>` are given, they are all
 	sent to the other side in the order listed on the command line.
 
-<repository>::
+`<repository>`::
 	The "remote" repository to query.  This parameter can be
 	either a URL or the name of a remote (see the GIT URLS and
 	REMOTES sections of linkgit:git-fetch[1]).
diff --git a/Documentation/git-ls-tree.txt b/Documentation/git-ls-tree.txt
index 82c802d918..11c25fe451 100644
--- a/Documentation/git-ls-tree.txt
+++ b/Documentation/git-ls-tree.txt
@@ -35,42 +35,42 @@ in the current working directory.  Note that:
 
 OPTIONS
 -------
-<tree-ish>::
+`<tree-ish>`::
 	Id of a tree-ish.
 
--d::
+`-d`::
 	Show only the named tree entry itself, not its children.
 
--r::
+`-r`::
 	Recurse into sub-trees.
 
--t::
+`-t`::
 	Show tree entries even when going to recurse them. Has no effect
 	if `-r` was not passed. `-d` implies `-t`.
 
--l::
---long::
+`-l`::
+`--long`::
 	Show object size of blob (file) entries.
 
--z::
+`-z`::
 	\0 line termination on output and do not quote filenames.
 	See OUTPUT FORMAT below for more information.
 
---name-only::
---name-status::
+`--name-only`::
+`--name-status`::
 	List only filenames (instead of the "long" output), one per line.
 
---abbrev[=<n>]::
+`--abbrev[=<n>]`::
 	Instead of showing the full 40-byte hexadecimal object
 	lines, show the shortest prefix that is at least '<n>'
 	hexdigits long that uniquely refers the object.
 	Non default number of digits can be specified with `--abbrev`=<n>.
 
---full-name::
+`--full-name`::
 	Instead of showing the path names relative to the current working
 	directory, show the full path names.
 
---full-tree::
+`--full-tree`::
 	Do not limit the listing to the current working directory.
 	Implies `--full-name`.
 
diff --git a/Documentation/git-mailinfo.txt b/Documentation/git-mailinfo.txt
index b47e92ee57..5898b9ee89 100644
--- a/Documentation/git-mailinfo.txt
+++ b/Documentation/git-mailinfo.txt
@@ -24,7 +24,7 @@ command directly.  See linkgit:git-am[1] instead.
 
 OPTIONS
 -------
--k::
+`-k`::
 	Usually the program removes email cruft from the Subject:
 	header line to extract the title line for the commit log
 	message.  This option prevents this munging, and is most
@@ -44,12 +44,12 @@ Specifically, the following are removed until none of them remain:
 Finally, runs of whitespace are normalized to a single ASCII space
 character.
 
--b::
+`-b`::
 	When `-k` is not in effect, all leading strings bracketed with '['
 	and ']' pairs are stripped.  This option limits the stripping to
 	only the pairs whose bracketed string contains the word "PATCH".
 
--u::
+`-u`::
 	The commit log message, author name and author email are
 	taken from the e-mail, and after minimally decoding MIME
 	transfer encoding, re-coded in the charset specified by
@@ -59,19 +59,19 @@ character.
 Note that the patch is always used as-is without charset
 conversion, even with this flag.
 
---encoding=<encoding>::
+`--encoding=<encoding>`::
 	Similar to `-u`.  But when re-coding, the charset specified here is
 	used instead of the one specified by `i18n.commitEncoding` or UTF-8.
 
--n::
+`-n`::
 	Disable all charset re-coding of the metadata.
 
--m::
---message-id::
+`-m`::
+`--message-id`::
 	Copy the Message-ID header at the end of the commit message.  This
 	is useful in order to associate commits with mailing list discussions.
 
---scissors::
+`--scissors`::
 	Remove everything in body before a scissors line (e.g. "-- >8 --").
 	The line represents scissors and perforation marks, and is used to
 	request the reader to cut the message at that line.  If that line
@@ -86,14 +86,14 @@ beginning of the proposed commit log message with a scissors line.
 +
 This can be enabled by default with the configuration option `mailinfo.scissors`.
 
---no-scissors::
+`--no-scissors`::
 	Ignore scissors lines. Useful for overriding `mailinfo.scissors` settings.
 
-<msg>::
+`<msg>`::
 	The commit log message extracted from e-mail, usually
 	except the title line which comes from e-mail Subject.
 
-<patch>::
+`<patch>`::
 	The patch extracted from e-mail.
 
 GIT
diff --git a/Documentation/git-mailsplit.txt b/Documentation/git-mailsplit.txt
index 151c4f96be..1446a1588f 100644
--- a/Documentation/git-mailsplit.txt
+++ b/Documentation/git-mailsplit.txt
@@ -21,34 +21,34 @@ patches in the correct order.
 
 OPTIONS
 -------
-<mbox>::
+`<mbox>`::
 	Mbox file to split.  If not given, the mbox is read from
 	the standard input.
 
-<Maildir>::
+`<Maildir>`::
 	Root of the Maildir to split. This directory should contain the cur, tmp
 	and new subdirectories.
 
--o<directory>::
+`-o<directory>`::
 	Directory in which to place the individual messages.
 
--b::
+`-b`::
 	If any file doesn't begin with a From line, assume it is a
 	single mail message instead of signaling error.
 
--d<prec>::
+`-d<prec>`::
 	Instead of the default 4 digits with leading zeros,
 	different precision can be specified for the generated
 	filenames.
 
--f<nn>::
+`-f<nn>`::
 	Skip the first <nn> numbers, for example if `-f`3 is specified,
 	start the numbering with 0004.
 
---keep-cr::
+`--keep-cr`::
 	Do not remove `\r` from lines ending with `\r\n`.
 
---mboxrd::
+`--mboxrd`::
 	Input is of the "mboxrd" format and "^>+From " line escaping is
 	reversed.
 
diff --git a/Documentation/git-maintenance.txt b/Documentation/git-maintenance.txt
index c69b3cec4f..b333fd2cd9 100644
--- a/Documentation/git-maintenance.txt
+++ b/Documentation/git-maintenance.txt
@@ -29,7 +29,7 @@ Git repository.
 SUBCOMMANDS
 -----------
 
-register::
+`register`::
 	Initialize Git config values so any scheduled maintenance will
 	start running on this repository. This adds the repository to the
 	`maintenance.repo` config variable in the current user's global
@@ -55,25 +55,25 @@ task:
 setting `maintenance.auto = false` in the current repository. This config
 setting will remain after a `git maintenance unregister` command.
 
-run::
+`run`::
 	Run one or more maintenance tasks. If one or more `--task` options
 	are specified, then those tasks are run in that order. Otherwise,
 	the tasks are determined by which `maintenance.<task>.enabled`
 	config options are true. By default, only `maintenance.gc.enabled`
 	is true.
 
-start::
+`start`::
 	Start running maintenance on the current repository. This performs
 	the same config updates as the `register` subcommand, then updates
 	the background scheduler to run `git maintenance run --scheduled`
 	on an hourly basis.
 
-stop::
+`stop`::
 	Halt the background maintenance schedule. The current repository
 	is not removed from the list of maintained repositories, in case
 	the background maintenance is restarted later.
 
-unregister::
+`unregister`::
 	Remove the current repository from background maintenance. This
 	only removes the repository from the configured list. It does not
 	stop the background maintenance processes from running.
@@ -81,7 +81,7 @@ unregister::
 TASKS
 -----
 
-commit-graph::
+`commit-graph`::
 	The `commit-graph` job updates the `commit-graph` files incrementally,
 	then verifies that the written data is correct. The incremental
 	write is safe to run alongside concurrent Git processes since it
@@ -89,7 +89,7 @@ commit-graph::
 	`commit-graph-chain` file. They will be deleted by a later run based
 	on the expiration delay.
 
-prefetch::
+`prefetch`::
 	The `prefetch` task updates the object directory with the latest
 	objects from all registered remotes. For each remote, a `git fetch`
 	command is run. The refmap is custom to avoid updating local or remote
@@ -104,7 +104,7 @@ already be obtained, so the real fetch would go faster.  In the ideal case,
 it will just become an update to a bunch of remote-tracking branches without
 any object transfer.
 
-gc::
+`gc`::
 	Clean up unnecessary files and optimize the local repository. "GC"
 	stands for "garbage collection," but this task performs many
 	smaller tasks. This task can be expensive for large repositories,
@@ -112,7 +112,7 @@ gc::
 	be disruptive in some situations, as it deletes stale data. See
 	linkgit:git-gc[1] for more details on garbage collection in Git.
 
-loose-objects::
+`loose-objects`::
 	The `loose-objects` job cleans up loose objects and places them into
 	pack-files. In order to prevent race conditions with concurrent Git
 	commands, it follows a two-step process. First, it deletes any loose
@@ -127,7 +127,7 @@ loose-objects::
 	advisable to enable both the `loose-objects` and `gc` tasks at the
 	same time.
 
-incremental-repack::
+`incremental-repack`::
 	The `incremental-repack` job repacks the object directory
 	using the `multi-pack-index` feature. In order to prevent race
 	conditions with concurrent Git commands, it follows a two-step
@@ -145,7 +145,7 @@ incremental-repack::
 	which is a special case that attempts to repack all pack-files
 	into a single pack-file.
 
-pack-refs::
+`pack-refs`::
 	The `pack-refs` task collects the loose reference files and
 	collects them into a single file. This speeds up operations that
 	need to iterate across many references. See linkgit:git-pack-refs[1]
@@ -153,7 +153,7 @@ pack-refs::
 
 OPTIONS
 -------
---auto::
+`--auto`::
 	When combined with the `run` subcommand, run maintenance tasks
 	only if certain thresholds are met. For example, the `gc` task
 	runs when the number of loose objects exceeds the number stored
@@ -161,7 +161,7 @@ OPTIONS
 	exceeds the `gc.autoPackLimit` config setting. Not compatible with
 	the `--schedule` option.
 
---schedule::
+`--schedule`::
 	When combined with the `run` subcommand, run maintenance tasks
 	only if certain time conditions are met, as specified by the
 	`maintenance.<task>.schedule` config value for each `<task>`.
@@ -171,10 +171,10 @@ OPTIONS
 	the `--task=<task>` option(s) or those with
 	`maintenance.<task>.enabled` set to true.
 
---quiet::
+`--quiet`::
 	Do not report progress or other information over `stderr`.
 
---task=<task>::
+`--task=<task>`::
 	If this option is specified one or more times, then only run the
 	specified tasks in the specified order. If no `--task=<task>`
 	arguments are specified, then only the tasks with
diff --git a/Documentation/git-merge-base.txt b/Documentation/git-merge-base.txt
index 323bc045bf..272ef445e3 100644
--- a/Documentation/git-merge-base.txt
+++ b/Documentation/git-merge-base.txt
@@ -40,24 +40,24 @@ As a consequence, the 'merge base' is not necessarily contained in each of the
 commit arguments if more than two commits are specified. This is different
 from linkgit:git-show-branch[1] when used with the `--merge-base` option.
 
---octopus::
+`--octopus`::
 	Compute the best common ancestors of all supplied commits,
 	in preparation for an n-way merge.  This mimics the behavior
 	of `git show-branch --merge-base`.
 
---independent::
+`--independent`::
 	Instead of printing merge bases, print a minimal subset of
 	the supplied commits with the same ancestors.  In other words,
 	among the commits given, list those which cannot be reached
 	from any other.  This mimics the behavior of `git show-branch
 	--independent`.
 
---is-ancestor::
+`--is-ancestor`::
 	Check if the first <commit> is an ancestor of the second <commit>,
 	and exit with status 0 if true, or with status 1 if not.
 	Errors are signaled by a non-zero status that is not 1.
 
---fork-point::
+`--fork-point`::
 	Find the point at which a branch (or any history that leads
 	to <commit>) forked from another branch (or any reference)
 	<ref>. This does not just look for the common ancestor of
@@ -68,8 +68,8 @@ from linkgit:git-show-branch[1] when used with the `--merge-base` option.
 
 OPTIONS
 -------
--a::
---all::
+`-a`::
+`--all`::
 	Output all merge bases for the commits, instead of just one.
 
 DISCUSSION
diff --git a/Documentation/git-merge-file.txt b/Documentation/git-merge-file.txt
index 427f93cd8c..d7605b60f0 100644
--- a/Documentation/git-merge-file.txt
+++ b/Documentation/git-merge-file.txt
@@ -60,19 +60,19 @@ OPTIONS
 	looks like it came from files x, y and z instead of
 	from files a, b and c.
 
--p::
+`-p`::
 	Send results to standard output instead of overwriting
 	`<current-file>`.
 
--q::
+`-q`::
 	Quiet; do not warn about conflicts.
 
 --diff3::
 	Show conflicts in "diff3" style.
 
---ours::
---theirs::
---union::
+`--ours`::
+`--theirs`::
+`--union`::
 	Instead of leaving conflicts in the file, resolve conflicts
 	favouring our (or their or both) side of the lines.
 
diff --git a/Documentation/git-merge-index.txt b/Documentation/git-merge-index.txt
index be978144d5..a1cef44c33 100644
--- a/Documentation/git-merge-index.txt
+++ b/Documentation/git-merge-index.txt
@@ -23,16 +23,16 @@ OPTIONS
 \--::
 	Do not interpret any more arguments as options.
 
--a::
+`-a`::
 	Run merge against all files in the index that need merging.
 
--o::
+`-o`::
 	Instead of stopping at the first failed merge, do all of them
 	in one shot - continue with merging even when previous merges
 	returned errors, and only return the error code after all the
 	merges.
 
--q::
+`-q`::
 	Do not complain about a failed merge program (a merge program
 	failure usually indicates conflicts during the merge). This is for
 	porcelains which might want to emit custom messages.
diff --git a/Documentation/git-merge.txt b/Documentation/git-merge.txt
index 029c7807db..de57a4fb54 100644
--- a/Documentation/git-merge.txt
+++ b/Documentation/git-merge.txt
@@ -75,24 +75,24 @@ used to give a good default for automated `git merge`
 invocations. The automated message can include the branch description.
 
 -F <file>::
---file=<file>::
+`--file=<file>`::
 	Read the commit message to be used for the merge commit (in
 	case one is created).
 +
 If `--log` is specified, a shortlog of the commits being merged
 will be appended to the specified message.
 
---rerere-autoupdate::
---no-rerere-autoupdate::
+`--rerere-autoupdate`::
+`--no-rerere-autoupdate`::
 	Allow the rerere mechanism to update the index with the
 	result of auto-conflict resolution if possible.
 
---overwrite-ignore::
---no-overwrite-ignore::
+`--overwrite-ignore`::
+`--no-overwrite-ignore`::
 	Silently overwrite ignored files from the merge result. This
 	is the default behavior. Use `--no-overwrite-ignore` to abort.
 
---abort::
+`--abort`::
 	Abort the current conflict resolution process, and
 	try to reconstruct the pre-merge state. If an autostash entry is
 	present, apply it to the worktree.
@@ -108,12 +108,12 @@ which case `git merge --abort` applies the stash entry to the worktree
 whereas `git reset --merge` will save the stashed changes in the stash
 list.
 
---quit::
+`--quit`::
 	Forget about the current merge in progress. Leave the index
 	and the working tree as-is. If `MERGE_AUTOSTASH` is present, the
 	stash entry will be saved to the stash list.
 
---continue::
+`--continue`::
 	After a `git merge` stops due to conflicts you can conclude the
 	merge by running `git merge --continue` (see "HOW TO RESOLVE
 	CONFLICTS" section below).
diff --git a/Documentation/git-mergetool.txt b/Documentation/git-mergetool.txt
index 530f8a278f..1a5b30b293 100644
--- a/Documentation/git-mergetool.txt
+++ b/Documentation/git-mergetool.txt
@@ -25,7 +25,7 @@ the merge tool program on every file with merge conflicts.
 OPTIONS
 -------
 -t <tool>::
---tool=<tool>::
+`--tool=<tool>`::
 	Use the merge resolution program specified by <tool>.
 	Valid values include emerge, gvimdiff, kdiff3,
 	meld, vimdiff, and tortoisemerge. Run `git mergetool --tool-help`
@@ -64,35 +64,35 @@ variable `mergetool.<tool>.trustExitCode` can be set to `true`.
 Otherwise, `git mergetool` will prompt the user to indicate the
 success of the resolution after the custom tool has exited.
 
---tool-help::
+`--tool-help`::
 	Print a list of merge tools that may be used with `--tool`.
 
--y::
---no-prompt::
+`-y`::
+`--no-prompt`::
 	Don't prompt before each invocation of the merge resolution
 	program.
 	This is the default if the merge resolution program is
 	explicitly specified with the `--tool` option or with the
 	`merge.tool` configuration variable.
 
---prompt::
+`--prompt`::
 	Prompt before each invocation of the merge resolution program
 	to give the user a chance to skip the path.
 
--g::
---gui::
+`-g`::
+`--gui`::
 	When `git-mergetool` is invoked with the `-g` or `--gui` option
 	the default merge tool will be read from the configured
 	`merge.guitool` variable instead of `merge.tool`. If
 	`merge.guitool` is not set, we will fallback to the tool
 	configured under `merge.tool`.
 
---no-gui::
+`--no-gui`::
 	This overrides a previous `-g` or `--gui` setting and reads the
 	default merge tool will be read from the configured `merge.tool`
 	variable.
 
--O<orderfile>::
+`-O<orderfile>`::
 	Process files in the order specified in the
 	<orderfile>, which has one shell glob pattern per line.
 	This overrides the `diff.orderFile` configuration variable
diff --git a/Documentation/git-mktag.txt b/Documentation/git-mktag.txt
index 1ba01b1a9b..2a38aeae34 100644
--- a/Documentation/git-mktag.txt
+++ b/Documentation/git-mktag.txt
@@ -14,7 +14,7 @@ SYNOPSIS
 OPTIONS
 -------
 
---strict::
+`--strict`::
 	By default mktag turns on the equivalent of
 	linkgit:git-fsck[1] `--strict` mode. Use `--no-strict` to
 	disable it.
diff --git a/Documentation/git-mktree.txt b/Documentation/git-mktree.txt
index 709e05ab6f..0f6e9fcecc 100644
--- a/Documentation/git-mktree.txt
+++ b/Documentation/git-mktree.txt
@@ -20,16 +20,16 @@ built is written to the standard output.
 
 OPTIONS
 -------
--z::
+`-z`::
 	Read the NUL-terminated `ls-tree -z` output instead.
 
---missing::
+`--missing`::
 	Allow missing objects.  The default behaviour (without this option)
 	is to verify that each tree entry's sha1 identifies an existing
 	object.  This option has no effect on the treatment of gitlink entries
 	(aka "submodules") which are always allowed to be missing.
 
---batch::
+`--batch`::
 	Allow building of more than one tree object before exiting.  Each
 	tree is separated by as single blank line. The final new-line is
 	optional.  Note - if the `-z` option is used, lines are terminated
diff --git a/Documentation/git-multi-pack-index.txt b/Documentation/git-multi-pack-index.txt
index ff56181795..b269392221 100644
--- a/Documentation/git-multi-pack-index.txt
+++ b/Documentation/git-multi-pack-index.txt
@@ -19,38 +19,38 @@ Write or verify a multi-pack-index (MIDX) file.
 OPTIONS
 -------
 
---object-dir=<dir>::
+`--object-dir=<dir>`::
 	Use given directory for the location of Git objects. We check
 	`<dir>/packs/multi-pack-index` for the current MIDX file, and
 	`<dir>/packs` for the pack-files to index.
 
---[no-]progress::
+`--[no-]progress`::
 	Turn progress on/off explicitly. If neither is specified, progress is
 	shown if standard error is connected to a terminal.
 
 The following subcommands are available:
 
-write::
+`write`::
 	Write a new MIDX file. The following options are available for
 	the `write` sub-command:
 +
 --
-	--preferred-pack=<pack>::
+	`--preferred-pack=<pack>`::
 		Optionally specify the tie-breaking pack used when
 		multiple packs contain the same object. If not given,
 		ties are broken in favor of the pack with the lowest
 		mtime.
 --
 
-verify::
+`verify`::
 	Verify the contents of the MIDX file.
 
-expire::
+`expire`::
 	Delete the pack-files that are tracked 	by the MIDX file, but
 	have no objects referenced by the MIDX. Rewrite the MIDX file
 	afterward to remove all references to these pack-files.
 
-repack::
+`repack`::
 	Create a new pack-file containing objects in small pack-files
 	referenced by the multi-pack-index. If the size given by the
 	`--batch-size=<size>` argument is zero, then create a pack
diff --git a/Documentation/git-mv.txt b/Documentation/git-mv.txt
index 183e7d5770..0944651f6a 100644
--- a/Documentation/git-mv.txt
+++ b/Documentation/git-mv.txt
@@ -28,20 +28,20 @@ committed.
 
 OPTIONS
 -------
--f::
---force::
+`-f`::
+`--force`::
 	Force renaming or moving of a file even if the target exists
--k::
+`-k`::
 	Skip move or rename actions which would lead to an error
 	condition. An error happens when a source is neither existing nor
 	controlled by Git, or when it would overwrite an existing
 	file unless `-f` is given.
--n::
---dry-run::
+`-n`::
+`--dry-run`::
 	Do nothing; only show what would happen
 
--v::
---verbose::
+`-v`::
+`--verbose`::
 	Report the names of files as they are moved.
 
 SUBMODULES
diff --git a/Documentation/git-name-rev.txt b/Documentation/git-name-rev.txt
index c6c1f89117..526914f710 100644
--- a/Documentation/git-name-rev.txt
+++ b/Documentation/git-name-rev.txt
@@ -21,16 +21,16 @@ format parsable by `git rev-parse`.
 OPTIONS
 -------
 
---tags::
+`--tags`::
 	Do not use branch names, but only tags to name the commits
 
---refs=<pattern>::
+`--refs=<pattern>`::
 	Only use refs whose names match a given shell pattern.  The pattern
 	can be one of branch name, tag name or fully qualified ref name. If
 	given multiple times, use refs whose names match any of the given shell
 	patterns. Use `--no-refs` to clear any previous ref patterns given.
 
---exclude=<pattern>::
+`--exclude=<pattern>`::
 	Do not use any ref whose name matches a given shell pattern. The
 	pattern can be one of branch name, tag name or fully qualified ref
 	name. If given multiple times, a ref will be excluded when it matches
@@ -39,26 +39,26 @@ OPTIONS
 	does not match any `--exclude` patterns. Use `--no-exclude` to clear the
 	list of exclude patterns.
 
---all::
+`--all`::
 	List all commits reachable from all refs
 
---stdin::
+`--stdin`::
 	Transform stdin by substituting all the 40-character SHA-1
 	hexes (say $hex) with "$hex ($rev_name)".  When used with
 	`--name-only`, substitute with "$rev_name", omitting $hex
 	altogether.  Intended for the scripter's use.
 
---name-only::
+`--name-only`::
 	Instead of printing both the SHA-1 and the name, print only
 	the name.  If given with `--tags` the usual tag prefix of
 	"tags/" is also omitted from the name, matching the output
 	of `git-describe` more closely.
 
---no-undefined::
+`--no-undefined`::
 	Die with error code != 0 when a reference is undefined,
 	instead of printing `undefined`.
 
---always::
+`--always`::
 	Show uniquely abbreviated commit object as fallback.
 
 EXAMPLES
diff --git a/Documentation/git-notes.txt b/Documentation/git-notes.txt
index ffc6fc51a7..16afea280d 100644
--- a/Documentation/git-notes.txt
+++ b/Documentation/git-notes.txt
@@ -53,13 +53,13 @@ notes across commands that rewrite commits.
 SUBCOMMANDS
 -----------
 
-list::
+`list`::
 	List the notes object for a given object. If no object is
 	given, show a list of all note objects and the objects they
 	annotate (in the format "<note object> <annotated object>").
 	This is the default subcommand if no subcommand is given.
 
-add::
+`add`::
 	Add notes for a given object (defaults to `HEAD`). Abort if the
 	object already has notes (use `-f` to overwrite existing notes).
 	However, if you're using `add` interactively (using an editor
@@ -67,7 +67,7 @@ add::
 	the existing notes will be opened in the editor (like the `edit`
 	subcommand).
 
-copy::
+`copy`::
 	Copy the notes for the first object onto the second object (defaults to
 	`HEAD`). Abort if the second object already has notes, or if the first
 	object has none (use -f to overwrite existing notes to the
@@ -84,17 +84,17 @@ on standard input, and copy the notes from each <from-object> to its
 corresponding <to-object>.  (The optional `<rest>` is ignored so that
 the command can read the input given to the `post-rewrite` hook.)
 
-append::
+`append`::
 	Append to the notes of an existing object (defaults to `HEAD`).
 	Creates a new notes object if needed.
 
-edit::
+`edit`::
 	Edit the notes for a given object (defaults to `HEAD`).
 
-show::
+`show`::
 	Show the notes for a given object (defaults to `HEAD`).
 
-merge::
+`merge`::
 	Merge the given notes ref into the current notes ref.
 	This will try to merge the changes made by the given
 	notes ref (called "remote") since the merge-base (if
@@ -109,28 +109,28 @@ When done, the user can either finalize the merge with
 `git notes merge --commit`, or abort the merge with
 `git notes merge --abort`.
 
-remove::
+`remove`::
 	Remove the notes for given objects (defaults to `HEAD`). When
 	giving zero or one object from the command line, this is
 	equivalent to specifying an empty note message to
 	the `edit` subcommand.
 
-prune::
+`prune`::
 	Remove all notes for non-existing/unreachable objects.
 
-get-ref::
+`get-ref`::
 	Print the current notes ref. This provides an easy way to
 	retrieve the current notes ref (e.g. from scripts).
 
 OPTIONS
 -------
--f::
---force::
+`-f`::
+`--force`::
 	When adding notes to an object that already has notes,
 	overwrite the existing notes (instead of aborting).
 
 -m <msg>::
---message=<msg>::
+`--message=<msg>`::
 	Use the given note message (instead of prompting).
 	If multiple `-m` options are given, their values
 	are concatenated as separate paragraphs.
@@ -138,24 +138,24 @@ OPTIONS
 	single line between paragraphs will be stripped out.
 
 -F <file>::
---file=<file>::
+`--file=<file>`::
 	Take the note message from the given file.  Use '-' to
 	read the note message from the standard input.
 	Lines starting with `#` and empty lines other than a
 	single line between paragraphs will be stripped out.
 
 -C <object>::
---reuse-message=<object>::
+`--reuse-message=<object>`::
 	Take the given blob object (for example, another note) as the
 	note message. (Use `git notes copy <object>` instead to
 	copy notes between objects.)
 
 -c <object>::
---reedit-message=<object>::
+`--reedit-message=<object>`::
 	Like `-C`, but with `-c` the editor is invoked, so that
 	the user can further edit the note message.
 
---allow-empty::
+`--allow-empty`::
 	Allow an empty note object to be stored. The default behavior is
 	to automatically remove empty notes.
 
@@ -166,22 +166,22 @@ OPTIONS
 	begins with `notes/`, `refs/` and otherwise `refs/notes/` is prefixed
 	to form a full name of the ref.
 
---ignore-missing::
+`--ignore-missing`::
 	Do not consider it an error to request removing notes from an
 	object that does not have notes attached to it.
 
---stdin::
+`--stdin`::
 	Also read the object names to remove notes from the standard
 	input (there is no reason you cannot combine this with object
 	names from the command line).
 
--n::
---dry-run::
+`-n`::
+`--dry-run`::
 	Do not remove anything; just report the object names whose notes
 	would be removed.
 
 -s <strategy>::
---strategy=<strategy>::
+`--strategy=<strategy>`::
 	When merging notes, resolve notes conflicts using the given
 	strategy. The following strategies are recognized: "manual"
 	(default), "ours", "theirs", "union" and "cat_sort_uniq".
@@ -189,7 +189,7 @@ OPTIONS
 	See the "NOTES MERGE STRATEGIES" section below for more
 	information on each notes merge strategy.
 
---commit::
+`--commit`::
 	Finalize an in-progress `git notes merge`. Use this option
 	when you have resolved the conflicts that `git notes merge`
 	stored in `.git/NOTES_MERGE_WORKTREE`. This amends the partial
@@ -198,17 +198,17 @@ OPTIONS
 	`.git/NOTES_MERGE_WORKTREE`. The notes ref stored in the
 	`.git/NOTES_MERGE_REF` symref is updated to the resulting commit.
 
---abort::
+`--abort`::
 	Abort/reset an in-progress `git notes merge`, i.e. a notes merge
 	with conflicts. This simply removes all files related to the
 	notes merge.
 
--q::
---quiet::
+`-q`::
+`--quiet`::
 	When merging notes, operate quietly.
 
--v::
---verbose::
+`-v`::
+`--verbose`::
 	When merging notes, be more verbose.
 	When pruning notes, report all object names whose notes are
 	removed.
diff --git a/Documentation/git-p4.txt b/Documentation/git-p4.txt
index a74866d84f..90280af75b 100644
--- a/Documentation/git-p4.txt
+++ b/Documentation/git-p4.txt
@@ -205,8 +205,8 @@ All commands except clone accept these options.
 --git-dir <dir>::
 	Set the `GIT_DIR` environment variable.  See linkgit:git[1].
 
--v::
---verbose::
+`-v`::
+`--verbose`::
 	Provide more progress information.
 
 Sync options
@@ -233,7 +233,7 @@ Git repository:
     $ git p4 sync --branch=refs/remotes/p4/proj2 //depot/proj2
 ----
 
---detect-branches::
+`--detect-branches`::
 	Use the branch detection algorithm to find new paths in p4.  It is
 	documented below in "BRANCH DETECTION".
 
@@ -242,18 +242,18 @@ Git repository:
 	line.  Normally, `git p4` inspects the current p4 repository
 	state and detects the changes it should import.
 
---silent::
+`--silent`::
 	Do not print any progress information.
 
---detect-labels::
+`--detect-labels`::
 	Query p4 for labels associated with the depot paths, and add
 	them as tags in Git. Limited usefulness as only imports labels
 	associated with new changelists. Deprecated.
 
---import-labels::
+`--import-labels`::
 	Import labels from p4 into Git.
 
---import-local::
+`--import-local`::
 	By default, p4 branches are stored in `refs/remotes/p4/`,
 	where they will be treated as remote-tracking branches by
 	linkgit:git-branch[1] and other commands.  This option instead
@@ -277,7 +277,7 @@ Git repository:
 	one block of changes of the given size. The default block size
 	is 500, which should usually be suitable.
 
---keep-path::
+`--keep-path`::
 	The mapping of file names from the p4 depot path to Git, by
 	default, involves removing the entire depot path.  With this
 	option, the full p4 depot path is retained in Git.  For example,
@@ -285,7 +285,7 @@ Git repository:
 	'//depot/main/', becomes 'foo/bar.c'.  With `--keep-path`, the
 	Git path is instead 'depot/main/foo/bar.c'.
 
---use-client-spec::
+`--use-client-spec`::
 	Use a client spec to find the list of interesting files in p4.
 	See the "CLIENT SPEC" section below.
 
@@ -302,7 +302,7 @@ options described above.
 	component in the p4 depot path is used to create a new
 	directory.
 
---bare::
+`--bare`::
 	Perform a bare clone.  See linkgit:git-clone[1].
 
 Submit options
@@ -314,22 +314,22 @@ These options can be used to modify `git p4 submit` behavior.
 	p4.  By default, this is the most recent p4 commit reachable
 	from `HEAD`.
 
--M::
+`-M`::
 	Detect renames.  See linkgit:git-diff[1].  Renames will be
 	represented in p4 using explicit 'move' operations.  There
 	is no corresponding option to detect copies, but there are
 	variables for both moves and copies.
 
---preserve-user::
+`--preserve-user`::
 	Re-author p4 changes before submitting to p4.  This option
 	requires p4 admin privileges.
 
---export-labels::
+`--export-labels`::
 	Export tags from Git as p4 labels. Tags found in Git are applied
 	to the perforce working directory.
 
--n::
---dry-run::
+`-n`::
+`--dry-run`::
 	Show just what commits would be submitted to p4; do not change
 	state in Git or p4.
 
@@ -340,7 +340,7 @@ These options can be used to modify `git p4 submit` behavior.
 	submit manually or revert.  This option always stops after the
 	first (oldest) commit.  Git tags are not exported to p4.
 
---shelve::
+`--shelve`::
 	Instead of submitting create a series of shelved changelists.
 	After creating each shelve, the relevant files are reverted/deleted.
 	If you have multiple commits pending multiple shelves will be created.
@@ -365,7 +365,7 @@ These options can be used to modify `git p4 submit` behavior.
     Submit only the specified commit or range of commits, instead of the full
     list of changes that are in the current Git branch.
 
---disable-rebase::
+`--disable-rebase`::
     Disable the automatic rebase after all commits have been successfully
     submitted. Can also be set with `git-p4.disableRebase`.
 
@@ -427,13 +427,13 @@ Rebase options
 ~~~~~~~~~~~~~~
 These options can be used to modify `git p4 rebase` behavior.
 
---import-labels::
+`--import-labels`::
 	Import p4 labels.
 
 Unshelve options
 ~~~~~~~~~~~~~~~~
 
---origin::
+`--origin`::
     Sets the `git` refspec against which the shelved P4 changelist is compared.
     Defaults to p4/master.
 
diff --git a/Documentation/git-pack-objects.txt b/Documentation/git-pack-objects.txt
index 118fdeac35..4a924ccd32 100644
--- a/Documentation/git-pack-objects.txt
+++ b/Documentation/git-pack-objects.txt
@@ -48,7 +48,7 @@ transport by their peers.
 
 OPTIONS
 -------
-base-name::
+`base-name`::
 	Write into pairs of files (.pack and .idx), using
 	<base-name> to determine the name of the created file.
 	When this option is used, the two files in a pair are written in
@@ -56,11 +56,11 @@ base-name::
 	based on the pack content and is written to the standard
 	output of the command.
 
---stdout::
+`--stdout`::
 	Write the pack contents (what would have been written to
 	.pack file) out to the standard output.
 
---revs::
+`--revs`::
 	Read the revision arguments from the standard input, instead of
 	individual object names.  The revision arguments are processed
 	the same way as `git rev-list` with the `--objects` flag
@@ -69,23 +69,23 @@ base-name::
 	Besides revisions, `--not` or `--shallow <SHA-1>` lines are
 	also accepted.
 
---unpacked::
+`--unpacked`::
 	This implies `--revs`.  When processing the list of
 	revision arguments read from the standard input, limit
 	the objects packed to those that are not already packed.
 
---all::
+`--all`::
 	This implies `--revs`.  In addition to the list of
 	revision arguments read from the standard input, pretend
 	as if all refs under `refs/` are specified to be
 	included.
 
---include-tag::
+`--include-tag`::
 	Include unasked-for annotated tags if the object they
 	reference was included in the resulting packfile.  This
 	can be useful to send new tags to native Git clients.
 
---stdin-packs::
+`--stdin-packs`::
 	Read the basenames of packfiles (e.g., `pack-1234abcd.pack`)
 	from the standard input, instead of object names or revision
 	arguments. The resulting pack contains all objects listed in the
@@ -95,8 +95,8 @@ base-name::
 Incompatible with `--revs`, or options that imply `--revs` (such as
 `--all`), with the exception of `--unpacked`, which is compatible.
 
---window=<n>::
---depth=<n>::
+`--window=<n>`::
+`--depth=<n>`::
 	These two options affect how the objects contained in
 	the pack are stored using delta compression.  The
 	objects are first internally sorted by type, size and
@@ -110,7 +110,7 @@ Incompatible with `--revs`, or options that imply `--revs` (such as
 The default value for `--window` is 10 and `--depth` is 50. The maximum
 depth is 4095.
 
---window-memory=<n>::
+`--window-memory=<n>`::
 	This option provides an additional limit on top of `--window`;
 	the window size will dynamically scale down so as to not take
 	up more than '<n>' bytes in memory.  This is useful in
@@ -121,7 +121,7 @@ depth is 4095.
 	`--window-memory=0` makes memory usage unlimited.  The default
 	is taken from the `pack.windowMemory` configuration variable.
 
---max-pack-size=<n>::
+`--max-pack-size=<n>`::
 	In unusual scenarios, you may not be able to create files
 	larger than a certain size on your filesystem, and this option
 	can be used to tell the command to split the output packfile
@@ -133,38 +133,38 @@ depth is 4095.
 	The default is unlimited, unless the config variable
 	`pack.packSizeLimit` is set.
 
---honor-pack-keep::
+`--honor-pack-keep`::
 	This flag causes an object already in a local pack that
 	has a .keep file to be ignored, even if it would have
 	otherwise been packed.
 
---keep-pack=<pack-name>::
+`--keep-pack=<pack-name>`::
 	This flag causes an object already in the given pack to be
 	ignored, even if it would have otherwise been
 	packed. `<pack-name>` is the pack file name without
 	leading directory (e.g. `pack-123.pack`). The option could be
 	specified multiple times to keep multiple packs.
 
---incremental::
+`--incremental`::
 	This flag causes an object already in a pack to be ignored
 	even if it would have otherwise been packed.
 
---local::
+`--local`::
 	This flag causes an object that is borrowed from an alternate
 	object store to be ignored even if it would have otherwise been
 	packed.
 
---non-empty::
+`--non-empty`::
         Only create a packed archive if it would contain at
         least one object.
 
---progress::
+`--progress`::
 	Progress status is reported on the standard error stream
 	by default when it is attached to a terminal, unless -q
 	is specified. This flag forces progress status even if
 	the standard error stream is not directed to a terminal.
 
---all-progress::
+`--all-progress`::
 	When `--stdout` is specified then progress report is
 	displayed during the object count and compression phases
 	but inhibited during the write-out phase. The reason is
@@ -175,30 +175,30 @@ depth is 4095.
 	report for the write-out phase as well even if `--stdout` is
 	used.
 
---all-progress-implied::
+`--all-progress-implied`::
 	This is used to imply `--all-progress` whenever progress display
 	is activated.  Unlike `--all-progress` this flag doesn't actually
 	force any progress display by itself.
 
--q::
+`-q`::
 	This flag makes the command not to report its progress
 	on the standard error stream.
 
---no-reuse-delta::
+`--no-reuse-delta`::
 	When creating a packed archive in a repository that
 	has existing packs, the command reuses existing deltas.
 	This sometimes results in a slightly suboptimal pack.
 	This flag tells the command not to reuse existing deltas
 	but compute them from scratch.
 
---no-reuse-object::
+`--no-reuse-object`::
 	This flag tells the command not to reuse existing object data at all,
 	including non deltified object, forcing recompression of everything.
 	This implies `--no-reuse-delta`. Useful only in the obscure case where
 	wholesale enforcement of a different compression level on the
 	packed data is desired.
 
---compression=<n>::
+`--compression=<n>`::
 	Specifies compression level for newly-compressed data in the
 	generated pack.  If not specified,  pack compression level is
 	determined first by pack.compression,  then by core.compression,
@@ -206,7 +206,7 @@ depth is 4095.
 	Add `--no-reuse-object` if you want to force a uniform compression
 	level on all data no matter the source.
 
---[no-]sparse::
+`--[no-]sparse`::
 	Toggle the "sparse" algorithm to determine which objects to include in
 	the pack, when combined with the `--revs` option. This algorithm
 	only walks trees that appear in paths that introduce new objects.
@@ -217,7 +217,7 @@ depth is 4095.
 	it defaults to the value of `pack.useSparse`, which is true unless
 	otherwise specified.
 
---thin::
+`--thin`::
 	Create a "thin" pack by omitting the common objects between a
 	sender and a receiver in order to reduce network transfer. This
 	option only makes sense in conjunction with `--stdout`.
@@ -227,12 +227,12 @@ required objects and is thus unusable by Git without making it
 self-contained. Use `git index-pack --fix-thin`
 (see linkgit:git-index-pack[1]) to restore the self-contained property.
 
---shallow::
+`--shallow`::
 	Optimize a pack that will be provided to a client with a shallow
 	repository.  This option, combined with `--thin`, can result in a
 	smaller pack at the cost of speed.
 
---delta-base-offset::
+`--delta-base-offset`::
 	A packed archive can express the base object of a delta as
 	either a 20-byte object name or as an offset in the
 	stream, but ancient versions of Git don't understand the
@@ -248,7 +248,7 @@ Note: Porcelain commands such as `git gc` (see linkgit:git-gc[1]),
 in modern Git when they put objects in your repository into pack files.
 So does `git bundle` (see linkgit:git-bundle[1]) when it creates a bundle.
 
---threads=<n>::
+`--threads=<n>`::
 	Specifies the number of threads to spawn when searching for best
 	delta matches.  This requires that pack-objects be compiled with
 	pthreads otherwise this option is ignored with a warning.
@@ -263,19 +263,19 @@ So does `git bundle` (see linkgit:git-bundle[1]) when it creates a bundle.
 	to force the version for the generated pack index, and to force
 	64-bit index entries on objects located above the given offset.
 
---keep-true-parents::
+`--keep-true-parents`::
 	With this option, parents that are hidden by grafts are packed
 	nevertheless.
 
---filter=<filter-spec>::
+`--filter=<filter-spec>`::
 	Requires `--stdout`.  Omits certain objects (usually blobs) from
 	the resulting packfile.  See linkgit:git-rev-list[1] for valid
 	`<filter-spec>` forms.
 
---no-filter::
+`--no-filter`::
 	Turns off any previous `--filter=` argument.
 
---missing=<missing-action>::
+`--missing=<missing-action>`::
 	A debug option to help with future "partial clone" development.
 	This option specifies how missing objects are handled.
 +
@@ -293,27 +293,27 @@ allow object traversal to continue for EXPECTED promisor missing objects.
 No fetch of a missing object will occur.  An unexpected missing object will
 raise an error.
 
---exclude-promisor-objects::
+`--exclude-promisor-objects`::
 	Omit objects that are known to be in the promisor remote.  (This
 	option has the purpose of operating only on locally created objects,
 	so that when we repack, we still maintain a distinction between
 	locally created objects [without .promisor] and objects from the
 	promisor remote [with .promisor].)  This is used with partial clone.
 
---keep-unreachable::
+`--keep-unreachable`::
 	Objects unreachable from the refs in packs named with
 	`--unpacked`= option are added to the resulting pack, in
 	addition to the reachable objects that are not in packs marked
 	with *.keep files. This implies `--revs`.
 
---pack-loose-unreachable::
+`--pack-loose-unreachable`::
 	Pack unreachable loose objects (and their loose counterparts
 	removed). This implies `--revs`.
 
---unpack-unreachable::
+`--unpack-unreachable`::
 	Keep unreachable objects in loose form. This implies `--revs`.
 
---delta-islands::
+`--delta-islands`::
 	Restrict delta matches based on "islands". See DELTA ISLANDS
 	below.
 
diff --git a/Documentation/git-pack-redundant.txt b/Documentation/git-pack-redundant.txt
index a288be2c12..cc028d80de 100644
--- a/Documentation/git-pack-redundant.txt
+++ b/Documentation/git-pack-redundant.txt
@@ -29,14 +29,14 @@ OPTIONS
 -------
 
 
---all::
+`--all`::
 	Processes all packs. Any filenames on the command line are ignored.
 
---alt-odb::
+`--alt-odb`::
 	Don't require objects present in packs from alternate object
 	directories to be present in local packs.
 
---verbose::
+`--verbose`::
 	Outputs some statistics to stderr. Has a small performance penalty.
 
 SEE ALSO
diff --git a/Documentation/git-pack-refs.txt b/Documentation/git-pack-refs.txt
index f77bd0e27f..3235e5129e 100644
--- a/Documentation/git-pack-refs.txt
+++ b/Documentation/git-pack-refs.txt
@@ -45,7 +45,7 @@ unpacked.
 OPTIONS
 -------
 
---all::
+`--all`::
 
 The command by default packs all tags and refs that are already
 packed, and leaves other refs
@@ -54,7 +54,7 @@ developed and packing their tips does not help performance.
 This option causes branch tips to be packed as well.  Useful for
 a repository with many branches of historical interests.
 
---no-prune::
+`--no-prune`::
 
 The command usually removes loose refs under `$GIT_DIR/refs`
 hierarchy after packing them.  This option tells it not to.
diff --git a/Documentation/git-patch-id.txt b/Documentation/git-patch-id.txt
index 5e8747f673..e50d13c6ed 100644
--- a/Documentation/git-patch-id.txt
+++ b/Documentation/git-patch-id.txt
@@ -30,7 +30,7 @@ This can be used to make a mapping from patch ID to commit ID.
 OPTIONS
 -------
 
---stable::
+`--stable`::
 	Use a "stable" sum of hashes as the patch ID. With this option:
 	 - Reordering file diffs that make up a patch does not affect the ID.
 	   In particular, two patches produced by comparing the same two trees
@@ -47,7 +47,7 @@ OPTIONS
 
 	This is the default if `patchid.stable` is set to true.
 
---unstable::
+`--unstable`::
 	Use an "unstable" hash as the patch ID. With this option,
 	the result produced is compatible with the patch-id value produced
 	by `git` 1.9 and older.  Users with pre-existing databases storing
diff --git a/Documentation/git-prune-packed.txt b/Documentation/git-prune-packed.txt
index 77603fd5e2..9b4414a34e 100644
--- a/Documentation/git-prune-packed.txt
+++ b/Documentation/git-prune-packed.txt
@@ -28,13 +28,13 @@ disk storage, etc.
 
 OPTIONS
 -------
--n::
---dry-run::
+`-n`::
+`--dry-run`::
         Don't actually remove any objects, only show those that would have been
         removed.
 
--q::
---quiet::
+`-q`::
+`--quiet`::
 	Squelch the progress indicator.
 
 SEE ALSO
diff --git a/Documentation/git-prune.txt b/Documentation/git-prune.txt
index 382e5f70f4..1e4a2a648f 100644
--- a/Documentation/git-prune.txt
+++ b/Documentation/git-prune.txt
@@ -33,16 +33,16 @@ not desired, see linkgit:git-repack[1].
 OPTIONS
 -------
 
--n::
---dry-run::
+`-n`::
+`--dry-run`::
 	Do not remove anything; just report what it would
 	remove.
 
--v::
---verbose::
+`-v`::
+`--verbose`::
 	Report all removed objects.
 
---progress::
+`--progress`::
 	Show progress.
 
 --expire <time>::
diff --git a/Documentation/git-pull.txt b/Documentation/git-pull.txt
index a64a137a89..7b83ac3577 100644
--- a/Documentation/git-pull.txt
+++ b/Documentation/git-pull.txt
@@ -74,14 +74,14 @@ pulling or stash them away with linkgit:git-stash[1].
 OPTIONS
 -------
 
--q::
---quiet::
+`-q`::
+`--quiet`::
 	This is passed to both underlying `git-fetch` to squelch reporting of
 	during transfer, and underlying `git-merge` to squelch output during
 	merging.
 
--v::
---verbose::
+`-v`::
+`--verbose`::
 	Pass `--verbose` to `git-fetch` and `git-merge`.
 
 --[no-]recurse-submodules[=yes|on-demand|no]::
@@ -101,7 +101,7 @@ Options related to merging
 
 include::merge-options.txt[]
 
--r::
+`-r`::
 --rebase[=false|true|merges|preserve|interactive]::
 	When true, rebase the current branch on top of the upstream
 	branch after fetching. If there is a remote-tracking branch
@@ -131,7 +131,7 @@ It rewrites history, which does not bode well when you
 published that history already.  Do *not* use this option
 unless you have read linkgit:git-rebase[1] carefully.
 
---no-rebase::
+`--no-rebase`::
 	Override earlier `--rebase`.
 
 Options related to fetching
diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
index 7811e2c73b..c33ebe5f4a 100644
--- a/Documentation/git-push.txt
+++ b/Documentation/git-push.txt
@@ -47,7 +47,7 @@ local one.
 
 OPTIONS[[OPTIONS]]
 ------------------
-<repository>::
+`<repository>`::
 	The "remote" repository that is destination of a push
 	operation.  This parameter can be either a URL
 	(see the section <<URLS,GIT URLS>> below) or the name
@@ -146,11 +146,11 @@ already exists on the remote side.
 +
 `tag <tag>` means the same as `refs/tags/<tag>:refs/tags/<tag>`.
 
---all::
+`--all`::
 	Push all branches (i.e. refs under `refs/heads/`); cannot be
 	used with other <refspec>.
 
---prune::
+`--prune`::
 	Remove remote branches that don't have a local counterpart. For example
 	a remote branch `tmp` will be removed if a local branch with the same
 	name doesn't exist any more. This also respects refspecs, e.g.
@@ -158,7 +158,7 @@ already exists on the remote side.
 	make sure that remote `refs/tmp/foo` will be removed if `refs/heads/foo`
 	doesn't exist.
 
---mirror::
+`--mirror`::
 	Instead of naming each ref to push, specifies that all
 	refs under `refs/` (which includes but is not
 	limited to `refs/heads/`, `refs/remotes/`, and `refs/tags/`)
@@ -169,26 +169,26 @@ already exists on the remote side.
 	if the configuration option `remote.<remote>.mirror` is
 	set.
 
--n::
---dry-run::
+`-n`::
+`--dry-run`::
 	Do everything except actually send the updates.
 
---porcelain::
+`--porcelain`::
 	Produce machine-readable output.  The output status line for each ref
 	will be tab-separated and sent to stdout instead of stderr.  The full
 	symbolic names of the refs will be given.
 
--d::
---delete::
+`-d`::
+`--delete`::
 	All listed refs are deleted from the remote repository. This is
 	the same as prefixing all refs with a colon.
 
---tags::
+`--tags`::
 	All refs under `refs/tags` are pushed, in
 	addition to refspecs explicitly listed on the command
 	line.
 
---follow-tags::
+`--follow-tags`::
 	Push all the refs that would be pushed without this option,
 	and also push annotated tags in `refs/tags` that are missing
 	from the remote but are pointing at commit-ish that are
@@ -196,7 +196,7 @@ already exists on the remote side.
 	with configuration variable `push.followTags`.  For more
 	information, see `push.followTags` in linkgit:git-config[1].
 
---[no-]signed::
+`--[no-]signed`::
 --signed=(true|false|if-asked)::
 	GPG-sign the push request to update refs on the receiving
 	side, to allow it to be checked by the hooks and/or be
@@ -207,13 +207,13 @@ already exists on the remote side.
 	will also fail if the actual call to `gpg --sign` fails.  See
 	linkgit:git-receive-pack[1] for the details on the receiving end.
 
---[no-]atomic::
+`--[no-]atomic`::
 	Use an atomic transaction on the remote side if available.
 	Either all refs are updated, or on error, no refs are updated.
 	If the server does not support atomic pushes the push will fail.
 
 -o <option>::
---push-option=<option>::
+`--push-option=<option>`::
 	Transmit the given string to the server, which passes them to
 	the pre-receive as well as the post-receive hook. The given string
 	must not contain a NUL or LF character.
@@ -224,15 +224,15 @@ already exists on the remote side.
 	line, the values of configuration variable `push.pushOption`
 	are used instead.
 
---receive-pack=<git-receive-pack>::
---exec=<git-receive-pack>::
+`--receive-pack=<git-receive-pack>`::
+`--exec=<git-receive-pack>`::
 	Path to the `git-receive-pack` program on the remote
 	end.  Sometimes useful when pushing to a remote
 	repository over ssh, and you do not have the program in
 	a directory on the default `$PATH`.
 
---[no-]force-with-lease::
---force-with-lease=<refname>::
+`--[no-]force-with-lease`::
+`--force-with-lease=<refname>`::
 --force-with-lease=<refname>:<expect>::
 	Usually, `git push` refuses to update a remote ref that is
 	not an ancestor of the local ref used to overwrite it.
@@ -329,8 +329,8 @@ verify if updates from the remote-tracking refs that may have been
 implicitly updated in the background are integrated locally before
 allowing a forced update.
 
--f::
---force::
+`-f`::
+`--force`::
 	Usually, the command refuses to update a remote ref that is
 	not an ancestor of the local ref used to overwrite it.
 	Also, when `--force-with-lease` option is used, the command refuses
@@ -349,7 +349,7 @@ one branch, use a `+` in front of the refspec to push (e.g `git push
 origin +master` to force a push to the `master` branch). See the
 `<refspec>...` section above for details.
 
---[no-]force-if-includes::
+`--[no-]force-if-includes`::
 	Force an update only if the tip of the remote-tracking ref
 	has been integrated locally.
 +
@@ -365,40 +365,40 @@ a "no-op".
 +
 Specifying `--no-force-if-includes` disables this behavior.
 
---repo=<repository>::
+`--repo=<repository>`::
 	This option is equivalent to the <repository> argument. If both
 	are specified, the command-line argument takes precedence.
 
--u::
---set-upstream::
+`-u`::
+`--set-upstream`::
 	For every branch that is up to date or successfully pushed, add
 	upstream (tracking) reference, used by argument-less
 	linkgit:git-pull[1] and other commands. For more information,
 	see `branch.<name>.merge` in linkgit:git-config[1].
 
---[no-]thin::
+`--[no-]thin`::
 	These options are passed to linkgit:git-send-pack[1]. A thin transfer
 	significantly reduces the amount of sent data when the sender and
 	receiver share many of the same objects in common. The default is
 	`--thin`.
 
--q::
---quiet::
+`-q`::
+`--quiet`::
 	Suppress all output, including the listing of updated refs,
 	unless an error occurs. Progress is not reported to the standard
 	error stream.
 
--v::
---verbose::
+`-v`::
+`--verbose`::
 	Run verbosely.
 
---progress::
+`--progress`::
 	Progress status is reported on the standard error stream
 	by default when it is attached to a terminal, unless -q
 	is specified. This flag forces progress status even if the
 	standard error stream is not directed to a terminal.
 
---no-recurse-submodules::
+`--no-recurse-submodules`::
 --recurse-submodules=check|on-demand|only|no::
 	May be used to make sure all submodule commits used by the
 	revisions to be pushed are available on a remote-tracking branch.
@@ -414,7 +414,7 @@ Specifying `--no-force-if-includes` disables this behavior.
 	to override the `push.recurseSubmodules` configuration variable when no
 	submodule recursion is required.
 
---[no-]verify::
+`--[no-]verify`::
 	Toggle the pre-push hook (see linkgit:githooks[5]).  The
 	default is `--verify`, giving the hook a chance to prevent the
 	push.  With `--no-verify`, the hook is bypassed completely.
@@ -452,7 +452,7 @@ If `--porcelain` is used, then each line of the output is of the form:
 The status of up-to-date refs is shown only if `--porcelain` or `--verbose`
 option is used.
 
-flag::
+`flag`::
 	A single character indicating the status of the ref:
 (space);; for a successfully pushed fast-forward;
 `+`;; for a successful forced update;
@@ -461,7 +461,7 @@ flag::
 `!`;; for a ref that was rejected or failed to push; and
 `=`;; for a ref that was up to date and did not need pushing.
 
-summary::
+`summary`::
 	For a successfully pushed ref, the summary shows the old and new
 	values of the ref in a form suitable for using as an argument to
 	`git log` (this is `<old>..<new>` in most cases, and
@@ -470,7 +470,7 @@ summary::
 For a failed update, more details are given:
 +
 --
-rejected::
+`rejected`::
 	Git did not try to send the ref at all, typically because it
 	is not a fast-forward and you did not force the update.
 
@@ -489,16 +489,16 @@ remote failure::
 	break in the network connection, or other transient error.
 --
 
-from::
+`from`::
 	The name of the local ref being pushed, minus its
 	`refs/<type>/` prefix. In the case of deletion, the
 	name of the local ref is omitted.
 
-to::
+`to`::
 	The name of the remote ref being updated, minus its
 	`refs/<type>/` prefix.
 
-reason::
+`reason`::
 	A human-readable explanation. In the case of successfully pushed
 	refs, no explanation is needed. For a failed ref, the reason for
 	failure is described.
diff --git a/Documentation/git-quiltimport.txt b/Documentation/git-quiltimport.txt
index 831bf55ed8..c3ec9efe38 100644
--- a/Documentation/git-quiltimport.txt
+++ b/Documentation/git-quiltimport.txt
@@ -31,8 +31,8 @@ preserved as the 1 line subject in the Git description.
 OPTIONS
 -------
 
--n::
---dry-run::
+`-n`::
+`--dry-run`::
 	Walk through the patches in the series and warn
 	if we cannot find all of the necessary information to commit
 	a patch.  At the time of this writing only missing author
@@ -56,7 +56,7 @@ The default for the series file is <patches>/series
 or the value of the `$QUILT_SERIES` environment
 variable.
 
---keep-non-patch::
+`--keep-non-patch`::
 	Pass `-b` flag to `git mailinfo` (see linkgit:git-mailinfo[1]).
 
 GIT
diff --git a/Documentation/git-range-diff.txt b/Documentation/git-range-diff.txt
index 2de9ca2d08..8703bef8ef 100644
--- a/Documentation/git-range-diff.txt
+++ b/Documentation/git-range-diff.txt
@@ -43,7 +43,7 @@ There are three ways to specify the commit ranges:
 
 OPTIONS
 -------
---no-dual-color::
+`--no-dual-color`::
 	When the commit diffs differ, `git range-diff` recreates the
 	original diffs' coloring, and adds outer -/+ diff markers with
 	the *background* being red/green to make it easier to see e.g.
@@ -61,7 +61,7 @@ This is known to `range-diff` as "dual coloring". Use `--no-dual-color`
 to revert to color all lines according to the outer diff markers
 (and completely ignore the inner diff when it comes to color).
 
---creation-factor=<percent>::
+`--creation-factor=<percent>`::
 	Set the creation/deletion cost fudge factor to `<percent>`.
 	Defaults to 60. Try a larger value if `git range-diff` erroneously
 	considers a large change a total rewrite (deletion of one commit
@@ -69,15 +69,15 @@ to revert to color all lines according to the outer diff markers
 	See the ``Algorithm`` section below for an explanation why this is
 	needed.
 
---left-only::
+`--left-only`::
 	Suppress commits that are missing from the first specified range
 	(or the "left range" when using the `<rev1>...<rev2>` format).
 
---right-only::
+`--right-only`::
 	Suppress commits that are missing from the second specified range
 	(or the "right range" when using the `<rev1>...<rev2>` format).
 
---[no-]notes[=<ref>]::
+`--[no-]notes[=<ref>]`::
 	This flag is passed to the `git log` program
 	(see linkgit:git-log[1]) that generates the patches.
 
diff --git a/Documentation/git-read-tree.txt b/Documentation/git-read-tree.txt
index 2b2bd665e0..e242a2553a 100644
--- a/Documentation/git-read-tree.txt
+++ b/Documentation/git-read-tree.txt
@@ -31,22 +31,22 @@ will be in unmerged state when `git read-tree` returns.
 
 OPTIONS
 -------
--m::
+`-m`::
 	Perform a merge, not just a read.  The command will
 	refuse to run if your index file has unmerged entries,
 	indicating that you have not finished previous merge you
 	started.
 
---reset::
+`--reset`::
 	Same as `-m`, except that unmerged entries are discarded instead
 	of failing. When used with `-u`, updates leading to loss of
 	working tree changes will not abort the operation.
 
--u::
+`-u`::
 	After a successful merge, update the files in the work
 	tree with the result of the merge.
 
--i::
+`-i`::
 	Usually a merge requires the index file as well as the
 	files in the working tree to be up to date with the
 	current head commit, in order not to lose local
@@ -55,21 +55,21 @@ OPTIONS
 	trees that are not directly related to the current
 	working tree status into a temporary index file.
 
--n::
---dry-run::
+`-n`::
+`--dry-run`::
 	Check if the command would error out, without updating the index
 	or the files in the working tree for real.
 
--v::
+`-v`::
 	Show the progress of checking files out.
 
---trivial::
+`--trivial`::
 	Restrict three-way merge by `git read-tree` to happen
 	only if there is no file-level merging required, instead
 	of resolving merge for trivial cases and leaving
 	conflicting files unresolved in the index.
 
---aggressive::
+`--aggressive`::
 	Usually a three-way merge by `git read-tree` resolves
 	the merge for really trivial cases and leaves other
 	cases unresolved in the index, so that porcelains can
@@ -82,13 +82,13 @@ OPTIONS
 * when both sides add a path identically.  The resolution
   is to add that path.
 
---prefix=<prefix>::
+`--prefix=<prefix>`::
 	Keep the current index contents, and read the contents
 	of the named tree-ish under the directory at `<prefix>`.
 	The command will refuse to overwrite entries that already
 	existed in the original index file.
 
---exclude-per-directory=<gitignore>::
+`--exclude-per-directory=<gitignore>`::
 	When running the command with `-u` and `-m` options, the
 	merge result may need to overwrite paths that are not
 	tracked in the current branch.  The command usually
@@ -103,7 +103,7 @@ OPTIONS
 	file (usually '.gitignore') and allows such an untracked
 	but explicitly ignored file to be overwritten.
 
---index-output=<file>::
+`--index-output=<file>`::
 	Instead of writing the results out to `$GIT_INDEX_FILE`,
 	write the resulting index in the named file.  While the
 	command is operating, the original index file is locked
@@ -115,22 +115,22 @@ OPTIONS
 	directories the index file and index output file are
 	located in.
 
---[no-]recurse-submodules::
+`--[no-]recurse-submodules`::
 	Using `--recurse-submodules` will update the content of all active
 	submodules according to the commit recorded in the superproject by
 	calling read-tree recursively, also setting the submodules' `HEAD` to be
 	detached at that commit.
 
---no-sparse-checkout::
+`--no-sparse-checkout`::
 	Disable sparse checkout support even if `core.sparseCheckout`
 	is true.
 
---empty::
+`--empty`::
 	Instead of reading tree object(s) into the index, just empty
 	it.
 
--q::
---quiet::
+`-q`::
+`--quiet`::
 	Quiet, suppress feedback messages.
 
 <tree-ish#>::
diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index 1c5eaf8cf7..f32ffaa011 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -218,7 +218,7 @@ As a special case, you may use "A\...B" as a shortcut for the
 merge base of A and B if there is exactly one merge base. You can
 leave out at most one of A and B, in which case it defaults to `HEAD`.
 
---keep-base::
+`--keep-base`::
 	Set the starting point at which to create the new commits to the
 	merge base of <upstream> <branch>. Running
 	`git rebase --keep-base <upstream> <branch>` is equivalent to
@@ -236,31 +236,31 @@ the merge base to determine the _set of commits_ which will be rebased.
 +
 See also INCOMPATIBLE OPTIONS below.
 
-<upstream>::
+`<upstream>`::
 	Upstream branch to compare against.  May be any valid commit,
 	not just an existing branch name. Defaults to the configured
 	upstream for the current branch.
 
-<branch>::
+`<branch>`::
 	Working branch; defaults to `HEAD`.
 
---continue::
+`--continue`::
 	Restart the rebasing process after having resolved a merge conflict.
 
---abort::
+`--abort`::
 	Abort the rebase operation and reset `HEAD` to the original
 	branch. If <branch> was provided when the rebase operation was
 	started, then `HEAD` will be reset to <branch>. Otherwise `HEAD`
 	will be reset to where it was when the rebase operation was
 	started.
 
---quit::
+`--quit`::
 	Abort the rebase operation but `HEAD` is not reset back to the
 	original branch. The index and working tree are also left
 	unchanged as a result. If a temporary stash entry was created
 	using `--autostash`, it will be saved to the stash list.
 
---apply::
+`--apply`::
 	Use applying strategies to rebase (calling `git-am`
 	internally).  This option may become a no-op in the future
 	once the merge backend handles everything the apply one does.
@@ -286,8 +286,8 @@ preliminary step (unless `--reapply-cherry-picks` is passed).
 +
 See also INCOMPATIBLE OPTIONS below.
 
---no-keep-empty::
---keep-empty::
+`--no-keep-empty`::
+`--keep-empty`::
 	Do not keep commits that start empty before the rebase
 	(i.e. that do not change anything from its parent) in the
 	result.  The default is to keep commits which start empty,
@@ -307,8 +307,8 @@ see the `--empty` flag.
 +
 See also INCOMPATIBLE OPTIONS below.
 
---reapply-cherry-picks::
---no-reapply-cherry-picks::
+`--reapply-cherry-picks`::
+`--no-reapply-cherry-picks`::
 	Reapply all clean cherry-picks of any upstream commit instead
 	of preemptively dropping them. (If these commits then become
 	empty after rebasing, because they contain a subset of already
@@ -325,7 +325,7 @@ commits, potentially improving performance.
 +
 See also INCOMPATIBLE OPTIONS below.
 
---allow-empty-message::
+`--allow-empty-message`::
 	No-op.  Rebasing commits with an empty message used to fail
 	and this option would override that behavior, allowing commits
 	with empty messages to be rebased.  Now commits with an empty
@@ -333,19 +333,19 @@ See also INCOMPATIBLE OPTIONS below.
 +
 See also INCOMPATIBLE OPTIONS below.
 
---skip::
+`--skip`::
 	Restart the rebasing process by skipping the current patch.
 
---edit-todo::
+`--edit-todo`::
 	Edit the todo list during an interactive rebase.
 
---show-current-patch::
+`--show-current-patch`::
 	Show the current patch in an interactive rebase or when rebase
 	is stopped because of conflicts. This is the equivalent of
 	`git show REBASE_HEAD`.
 
--m::
---merge::
+`-m`::
+`--merge`::
 	Use merging strategies to rebase.  When the recursive (default) merge
 	strategy is used, this allows rebase to be aware of renames on the
 	upstream side.  This is the default.
@@ -359,7 +359,7 @@ other words, the sides are swapped.
 See also INCOMPATIBLE OPTIONS below.
 
 -s <strategy>::
---strategy=<strategy>::
+`--strategy=<strategy>`::
 	Use the given merge strategy.
 	If there is no `-s` option `git merge-recursive` is used
 	instead.  This implies `--merge`.
@@ -372,7 +372,7 @@ which makes little sense.
 See also INCOMPATIBLE OPTIONS below.
 
 -X <strategy-option>::
---strategy-option=<strategy-option>::
+`--strategy-option=<strategy-option>`::
 	Pass the <strategy-option> through to the merge strategy.
 	This implies `--merge` and, if no strategy has been
 	specified, `-s recursive`.  Note the reversal of 'ours' and
@@ -380,44 +380,44 @@ See also INCOMPATIBLE OPTIONS below.
 +
 See also INCOMPATIBLE OPTIONS below.
 
---rerere-autoupdate::
---no-rerere-autoupdate::
+`--rerere-autoupdate`::
+`--no-rerere-autoupdate`::
 	Allow the rerere mechanism to update the index with the
 	result of auto-conflict resolution if possible.
 
--S[<keyid>]::
---gpg-sign[=<keyid>]::
---no-gpg-sign::
+`-S[<keyid>]`::
+`--gpg-sign[=<keyid>]`::
+`--no-gpg-sign`::
 	GPG-sign commits. The `keyid` argument is optional and
 	defaults to the committer identity; if specified, it must be
 	stuck to the option without a space. `--no-gpg-sign` is useful to
 	countermand both `commit.gpgSign` configuration variable, and
 	earlier `--gpg-sign`.
 
--q::
---quiet::
+`-q`::
+`--quiet`::
 	Be quiet. Implies `--no-stat`.
 
--v::
---verbose::
+`-v`::
+`--verbose`::
 	Be verbose. Implies `--stat`.
 
---stat::
+`--stat`::
 	Show a diffstat of what changed upstream since the last rebase. The
 	diffstat is also controlled by the configuration option `rebase.stat`.
 
--n::
---no-stat::
+`-n`::
+`--no-stat`::
 	Do not show a diffstat as part of the rebase process.
 
---no-verify::
+`--no-verify`::
 	This option bypasses the pre-rebase hook.  See also linkgit:githooks[5].
 
---verify::
+`--verify`::
 	Allows the pre-rebase hook to run, which is the default.  This option can
 	be used to override `--no-verify`.  See also linkgit:githooks[5].
 
--C<n>::
+`-C<n>`::
 	Ensure at least <n> lines of surrounding context match before
 	and after each change.  When fewer lines of surrounding
 	context exist they all must match.  By default no context is
@@ -425,9 +425,9 @@ See also INCOMPATIBLE OPTIONS below.
 +
 See also INCOMPATIBLE OPTIONS below.
 
---no-ff::
---force-rebase::
--f::
+`--no-ff`::
+`--force-rebase`::
+`-f`::
 	Individually replay all rebased commits instead of fast-forwarding
 	over the unchanged ones.  This ensures that the entire history of
 	the rebased branch is composed of new commits.
@@ -438,8 +438,8 @@ successfully without needing to "revert the reversion" (see the
 link:howto/revert-a-faulty-merge.html[revert-a-faulty-merge How-To] for
 details).
 
---fork-point::
---no-fork-point::
+`--fork-point`::
+`--no-fork-point`::
 	Use reflog to find a better common ancestor between <upstream>
 	and <branch> when calculating which commits have been
 	introduced by <branch>.
@@ -459,7 +459,7 @@ with `--keep-base` in order to drop those commits from your branch.
 +
 See also INCOMPATIBLE OPTIONS below.
 
---ignore-whitespace::
+`--ignore-whitespace`::
 	Ignore whitespace differences when trying to reconcile
 differences. Currently, each backend implements an approximation of
 this behavior:
@@ -475,35 +475,35 @@ when merging. Unfortunately, this means that any patch hunks that were
 intended to modify whitespace and nothing else will be dropped, even
 if the other side had no changes that conflicted.
 
---whitespace=<option>::
+`--whitespace=<option>`::
 	This flag is passed to the `git apply` program
 	(see linkgit:git-apply[1]) that applies the patch.
 	Implies `--apply`.
 +
 See also INCOMPATIBLE OPTIONS below.
 
---committer-date-is-author-date::
+`--committer-date-is-author-date`::
 	Instead of using the current time as the committer date, use
 	the author date of the commit being rebased as the committer
 	date. This option implies `--force-rebase`.
 
---ignore-date::
---reset-author-date::
+`--ignore-date`::
+`--reset-author-date`::
 	Instead of using the author date of the original commit, use
 	the current time as the	author date of the rebased commit.  This
 	option implies `--force-rebase`.
 +
 See also INCOMPATIBLE OPTIONS below.
 
---signoff::
+`--signoff`::
 	Add a `Signed-off-by` trailer to all the rebased commits. Note
 	that if `--interactive` is given then only commits marked to be
 	picked, edited or reworded will have the trailer added.
 +
 See also INCOMPATIBLE OPTIONS below.
 
--i::
---interactive::
+`-i`::
+`--interactive`::
 	Make a list of the commits which are about to be rebased.  Let the
 	user edit that list before rebasing.  This mode can also be used to
 	split commits (see SPLITTING COMMITS below).
@@ -514,7 +514,7 @@ have the long commit hash prepended to the format.
 +
 See also INCOMPATIBLE OPTIONS below.
 
--r::
+`-r`::
 --rebase-merges[=(rebase-cousins|no-rebase-cousins)]::
 	By default, a rebase will simply drop merge commits from the todo
 	list, and put the rebased commits into a single, linear branch.
@@ -541,8 +541,8 @@ explicit `exec git merge -s <strategy> [...]` commands.
 +
 See also REBASING MERGES and INCOMPATIBLE OPTIONS below.
 
--p::
---preserve-merges::
+`-p`::
+`--preserve-merges`::
 	[DEPRECATED: use `--rebase-merges` instead] Recreate merge commits
 	instead of flattening the history by replaying commits a merge commit
 	introduces. Merge conflict resolutions or manual amendments to merge
@@ -579,7 +579,7 @@ without an explicit `--interactive`.
 +
 See also INCOMPATIBLE OPTIONS below.
 
---root::
+`--root`::
 	Rebase all commits reachable from <branch>, instead of
 	limiting them with an <upstream>.  This allows you to rebase
 	the root commit(s) on a branch.  When used with `--onto`, it
@@ -591,8 +591,8 @@ See also INCOMPATIBLE OPTIONS below.
 +
 See also INCOMPATIBLE OPTIONS below.
 
---autosquash::
---no-autosquash::
+`--autosquash`::
+`--no-autosquash`::
 	When the commit log message begins with "squash! ..." or "fixup! ..."
 	or "amend! ...", and there is already a commit in the todo list that
 	matches the same `...`, automatically modify the todo list of
@@ -611,16 +611,16 @@ used to override and disable this setting.
 +
 See also INCOMPATIBLE OPTIONS below.
 
---autostash::
---no-autostash::
+`--autostash`::
+`--no-autostash`::
 	Automatically create a temporary stash entry before the operation
 	begins, and apply it after the operation ends.  This means
 	that you can run rebase on a dirty worktree.  However, use
 	with care: the final stash application after a successful
 	rebase might result in non-trivial conflicts.
 
---reschedule-failed-exec::
---no-reschedule-failed-exec::
+`--reschedule-failed-exec`::
+`--no-reschedule-failed-exec`::
 	Automatically reschedule `exec` commands that failed. This only makes
 	sense in interactive mode (or when an `--exec` option was provided).
 
diff --git a/Documentation/git-reflog.txt b/Documentation/git-reflog.txt
index c33a577a00..6aca5d9fa2 100644
--- a/Documentation/git-reflog.txt
+++ b/Documentation/git-reflog.txt
@@ -69,15 +69,15 @@ Options for `show`
 Options for `expire`
 ~~~~~~~~~~~~~~~~~~~~
 
---all::
+`--all`::
 	Process the reflogs of all references.
 
---single-worktree::
+`--single-worktree`::
 	By default when `--all` is specified, reflogs from all working
 	trees are processed. This option limits the processing to reflogs
 	from the current working tree only.
 
---expire=<time>::
+`--expire=<time>`::
 	Prune entries older than the specified time. If this option is
 	not specified, the expiration time is taken from the
 	configuration setting `gc.reflogExpire`, which in turn
@@ -85,7 +85,7 @@ Options for `expire`
 	of their age; `--expire=never` turns off pruning of reachable
 	entries (but see `--expire-unreachable`).
 
---expire-unreachable=<time>::
+`--expire-unreachable=<time>`::
 	Prune entries older than `<time>` that are not reachable from
 	the current tip of the branch. If this option is not
 	specified, the expiration time is taken from the configuration
@@ -95,17 +95,17 @@ Options for `expire`
 	turns off early pruning of unreachable entries (but see
 	`--expire`).
 
---updateref::
+`--updateref`::
 	Update the reference to the value of the top reflog entry (i.e.
 	<ref>@\{0\}) if the previous top entry was pruned.  (This
 	option is ignored for symbolic references.)
 
---rewrite::
+`--rewrite`::
 	If a reflog entry's predecessor is pruned, adjust its "old"
 	SHA-1 to be equal to the "new" SHA-1 field of the entry that
 	now precedes it.
 
---stale-fix::
+`--stale-fix`::
 	Prune any reflog entries that point to "broken commits". A
 	broken commit is a commit that is not reachable from any of
 	the reference tips and that refers, directly or indirectly, to
@@ -116,12 +116,12 @@ has the same cost as `git prune`.  It is primarily intended to fix
 corruption caused by garbage collecting using older versions of Git,
 which didn't protect objects referred to by reflogs.
 
--n::
---dry-run::
+`-n`::
+`--dry-run`::
 	Do not actually prune any entries; just show what would have
 	been pruned.
 
---verbose::
+`--verbose`::
 	Print extra information on screen.
 
 
diff --git a/Documentation/git-remote.txt b/Documentation/git-remote.txt
index 318b2220a2..f2d8f3723d 100644
--- a/Documentation/git-remote.txt
+++ b/Documentation/git-remote.txt
@@ -32,8 +32,8 @@ Manage the set of repositories ("remotes") whose branches you track.
 OPTIONS
 -------
 
--v::
---verbose::
+`-v`::
+`--verbose`::
 	Be a little more verbose and show remote url after name.
 	NOTE: This must be placed between `remote` and subcommand.
 
@@ -44,7 +44,7 @@ COMMANDS
 With no arguments, shows a list of existing remotes.  Several
 subcommands are available to perform operations on the remotes.
 
-'add'::
+`add`::
 
 Add a remote named <name> for the repository at
 <url>.  The command `git fetch <name>` can then be used to create and
@@ -80,7 +80,7 @@ because a fetch would overwrite any local commits.
 When a push mirror is created with `--mirror=push`, then `git push`
 will always behave as if `--mirror` was passed.
 
-'rename'::
+`rename`::
 
 Rename the remote named <old> to <new>. All remote-tracking branches and
 configuration settings for the remote are updated.
@@ -89,13 +89,13 @@ In case <old> and <new> are the same, and <old> is a file under
 `$GIT_DIR/remotes` or `$GIT_DIR/branches`, the remote is converted to
 the configuration file format.
 
-'remove'::
-'rm'::
+`remove`::
+`rm`::
 
 Remove the remote named <name>. All remote-tracking branches and
 configuration settings for the remote are removed.
 
-'set-head'::
+`set-head`::
 
 Sets or deletes the default branch (i.e. the target of the
 symbolic-ref `refs/remotes/<name>/HEAD`) for
@@ -120,7 +120,7 @@ remote set-head origin master` will set the symbolic-ref `refs/remotes/origin/HE
 `refs/remotes/origin/master` already exists; if not it must be fetched first.
 +
 
-'set-branches'::
+`set-branches`::
 
 Changes the list of branches tracked by the named remote.
 This can be used to track a subset of the available remote branches
@@ -132,7 +132,7 @@ The named branches will be interpreted as if specified with the
 With `--add`, instead of replacing the list of currently tracked
 branches, adds to that list.
 
-'get-url'::
+`get-url`::
 
 Retrieves the URLs for a remote. Configurations for `insteadOf` and
 `pushInsteadOf` are expanded here. By default, only the first URL is listed.
@@ -141,7 +141,7 @@ With `--push`, push URLs are queried rather than fetch URLs.
 +
 With `--all`, all URLs for the remote will be listed.
 
-'set-url'::
+`set-url`::
 
 Changes URLs for the remote. Sets first URL for remote <name> that matches
 regex <oldurl> (first URL if no <oldurl> is given) to <newurl>. If
@@ -163,14 +163,14 @@ fetch from one place (e.g. your upstream) and push to another (e.g.
 your publishing repository), use two separate remotes.
 
 
-'show'::
+`show`::
 
 Gives some information about the remote <name>.
 +
 With `-n` option, the remote heads are not queried first with
 `git ls-remote <name>`; cached information is used instead.
 
-'prune'::
+`prune`::
 
 Deletes stale references associated with <name>. By default, stale
 remote-tracking branches under <name> are deleted, but depending on
@@ -184,7 +184,7 @@ depending on various configuration.
 With `--dry-run` option, report what branches would be pruned, but do not
 actually prune them.
 
-'update'::
+`update`::
 
 Fetch updates for remotes or remote groups in the repository as defined by
 `remotes.<group>`. If neither group nor remote is specified on the command line,
diff --git a/Documentation/git-repack.txt b/Documentation/git-repack.txt
index c99a70e426..864196273b 100644
--- a/Documentation/git-repack.txt
+++ b/Documentation/git-repack.txt
@@ -28,7 +28,7 @@ engines, disk storage, etc.
 OPTIONS
 -------
 
--a::
+`-a`::
 	Instead of incrementally packing the unpacked objects,
 	pack everything referenced into a single pack.
 	Especially useful when packing a repository that is used
@@ -46,7 +46,7 @@ have an associated ".promisor" file, these packfiles will be repacked
 into another separate pack, and an empty ".promisor" file corresponding
 to the new separate pack will be written.
 
--A::
+`-A`::
 	Same as `-a`, unless `-d` is used.  Then any unreachable
 	objects in a previous pack become loose, unpacked objects,
 	instead of being left in the old pack.  Unreachable objects
@@ -57,37 +57,37 @@ to the new separate pack will be written.
 	will be pruned according to normal expiry rules
 	with the next `git gc` invocation. See linkgit:git-gc[1].
 
--d::
+`-d`::
 	After packing, if the newly created packs make some
 	existing packs redundant, remove the redundant packs.
 	Also run  `git prune-packed` to remove redundant
 	loose object files.
 
--l::
+`-l`::
 	Pass the `--local` option to `git pack-objects`. See
 	linkgit:git-pack-objects[1].
 
--f::
+`-f`::
 	Pass the `--no-reuse-delta` option to `git-pack-objects`, see
 	linkgit:git-pack-objects[1].
 
--F::
+`-F`::
 	Pass the `--no-reuse-object` option to `git-pack-objects`, see
 	linkgit:git-pack-objects[1].
 
--q::
+`-q`::
 	Pass the `-q` option to `git pack-objects`. See
 	linkgit:git-pack-objects[1].
 
--n::
+`-n`::
 	Do not update the server information with
 	`git update-server-info`.  This option skips
 	updating local catalog files needed to publish
 	this repository (or a direct copy of it)
 	over HTTP or FTP.  See linkgit:git-update-server-info[1].
 
---window=<n>::
---depth=<n>::
+`--window=<n>`::
+`--depth=<n>`::
 	These two options affect how the objects contained in the pack are
 	stored using delta compression. The objects are first internally
 	sorted by type, size and optionally names and compared against the
@@ -99,10 +99,10 @@ to the new separate pack will be written.
 The default value for `--window` is 10 and `--depth` is 50. The maximum
 depth is 4095.
 
---threads=<n>::
+`--threads=<n>`::
 	This option is passed through to `git pack-objects`.
 
---window-memory=<n>::
+`--window-memory=<n>`::
 	This option provides an additional limit on top of `--window`;
 	the window size will dynamically scale down so as to not take
 	up more than '<n>' bytes in memory.  This is useful in
@@ -115,7 +115,7 @@ depth is 4095.
 	Note that the actual memory usage will be the limit multiplied
 	by the number of threads used by linkgit:git-pack-objects[1].
 
---max-pack-size=<n>::
+`--max-pack-size=<n>`::
 	Maximum size of each output pack file. The size can be suffixed with
 	"k", "m", or "g". The minimum size allowed is limited to 1 MiB.
 	If specified, multiple packfiles may be created, which also
@@ -123,15 +123,15 @@ depth is 4095.
 	The default is unlimited, unless the config variable
 	`pack.packSizeLimit` is set.
 
--b::
---write-bitmap-index::
+`-b`::
+`--write-bitmap-index`::
 	Write a reachability bitmap index as part of the repack. This
 	only makes sense when used with `-a` or `-A`, as the bitmaps
 	must be able to refer to all reachable objects. This option
 	overrides the setting of `repack.writeBitmaps`.  This option
 	has no effect if multiple packfiles are created.
 
---pack-kept-objects::
+`--pack-kept-objects`::
 	Include objects in `.keep` files when repacking.  Note that we
 	still do not delete `.keep` packs after `pack-objects` finishes.
 	This means that we may duplicate objects, but this makes the
@@ -140,33 +140,33 @@ depth is 4095.
 	with `-b` or `repack.writeBitmaps`, as it ensures that the
 	bitmapped packfile has the necessary objects.
 
---keep-pack=<pack-name>::
+`--keep-pack=<pack-name>`::
 	Exclude the given pack from repacking. This is the equivalent
 	of having `.keep` file on the pack. `<pack-name>` is the
 	pack file name without leading directory (e.g. `pack-123.pack`).
 	The option could be specified multiple times to keep multiple
 	packs.
 
---unpack-unreachable=<when>::
+`--unpack-unreachable=<when>`::
 	When loosening unreachable objects, do not bother loosening any
 	objects older than `<when>`. This can be used to optimize out
 	the write of any objects that would be immediately pruned by
 	a follow-up `git prune`.
 
--k::
---keep-unreachable::
+`-k`::
+`--keep-unreachable`::
 	When used with `-ad`, any unreachable objects from existing
 	packs will be appended to the end of the packfile instead of
 	being removed. In addition, any unreachable loose objects will
 	be packed (and their loose counterparts removed).
 
--i::
---delta-islands::
+`-i`::
+`--delta-islands`::
 	Pass the `--delta-islands` option to `git-pack-objects`, see
 	linkgit:git-pack-objects[1].
 
--g=<factor>::
---geometric=<factor>::
+`-g=<factor>`::
+`--geometric=<factor>`::
 	Arrange resulting pack structure so that each successive pack
 	contains at least `<factor>` times the number of objects as the
 	next-largest pack.
diff --git a/Documentation/git-replace.txt b/Documentation/git-replace.txt
index 3da7c4de90..fc6fc6ae6f 100644
--- a/Documentation/git-replace.txt
+++ b/Documentation/git-replace.txt
@@ -57,13 +57,13 @@ achieve the same effect as the `--no-replace-objects` option.
 
 OPTIONS
 -------
--f::
---force::
+`-f`::
+`--force`::
 	If an existing replace ref for the same object exists, it will
 	be overwritten (instead of failing).
 
--d::
---delete::
+`-d`::
+`--delete`::
 	Delete existing replace refs for the given objects.
 
 --edit <object>::
@@ -75,7 +75,7 @@ OPTIONS
 	newly created object. See linkgit:git-var[1] for details about
 	how the editor will be chosen.
 
---raw::
+`--raw`::
 	When editing, provide the raw object contents rather than
 	pretty-printed ones. Currently this only affects trees, which
 	will be shown in their binary form. This is harder to work with,
@@ -91,7 +91,7 @@ OPTIONS
 	commit. Use `--convert-graft-file` to convert a
 	`$GIT_DIR/info/grafts` file and use replace refs instead.
 
---convert-graft-file::
+`--convert-graft-file`::
 	Creates graft commits for all entries in `$GIT_DIR/info/grafts`
 	and deletes that file upon success. The purpose is to help users
 	with transitioning off of the now-deprecated graft file.
@@ -103,7 +103,7 @@ OPTIONS
 	Typing `git replace` without arguments, also lists all replace
 	refs.
 
---format=<format>::
+`--format=<format>`::
 	When listing, use the specified <format>, which can be one of
 	'short', 'medium' and 'long'. When omitted, the format
 	defaults to 'short'.
diff --git a/Documentation/git-request-pull.txt b/Documentation/git-request-pull.txt
index e9e703a814..58b5b5dd08 100644
--- a/Documentation/git-request-pull.txt
+++ b/Documentation/git-request-pull.txt
@@ -26,17 +26,17 @@ the repository named by `<url>`.
 
 OPTIONS
 -------
--p::
+`-p`::
 	Include patch text in the output.
 
-<start>::
+`<start>`::
 	Commit to start at.  This names a commit that is already in
 	the upstream history.
 
-<url>::
+`<url>`::
 	The repository URL to be pulled from.
 
-<end>::
+`<end>`::
 	Commit to end at (defaults to `HEAD`).  This names the commit
 	at the tip of the history you are asking to be pulled.
 +
diff --git a/Documentation/git-rerere.txt b/Documentation/git-rerere.txt
index 687b08d56c..2e5e6329a2 100644
--- a/Documentation/git-rerere.txt
+++ b/Documentation/git-rerere.txt
@@ -35,7 +35,7 @@ Normally, `git rerere` is run without arguments or user-intervention.
 However, it has several commands that allow it to interact with
 its working state.
 
-'clear'::
+`clear`::
 
 Reset the metadata used by rerere if a merge resolution is to be
 aborted.  Calling `git am [--skip|--abort]` or `git rebase [--skip|--abort]`
@@ -46,24 +46,24 @@ will automatically invoke this command.
 Reset the conflict resolutions which rerere has recorded for the current
 conflict in <pathspec>.
 
-'diff'::
+`diff`::
 
 Display diffs for the current state of the resolution.  It is
 useful for tracking what has changed while the user is resolving
 conflicts.  Additional arguments are passed directly to the system
 'diff' command installed in PATH.
 
-'status'::
+`status`::
 
 Print paths with conflicts whose merge resolution rerere will record.
 
-'remaining'::
+`remaining`::
 
 Print paths with conflicts that have not been autoresolved by rerere.
 This includes paths whose resolutions cannot be tracked by rerere,
 such as conflicting submodules.
 
-'gc'::
+`gc`::
 
 Prune records of conflicted merges that
 occurred a long time ago.  By default, unresolved conflicts older
diff --git a/Documentation/git-reset.txt b/Documentation/git-reset.txt
index 58fe574e71..7e44572383 100644
--- a/Documentation/git-reset.txt
+++ b/Documentation/git-reset.txt
@@ -53,13 +53,13 @@ section of linkgit:git-add[1] to learn how to operate the `--patch` mode.
 	defaults to `--mixed`. The `<mode>` must be one of the following:
 +
 --
---soft::
+`--soft`::
 	Does not touch the index file or the working tree at all (but
 	resets the head to `<commit>`, just like all modes do). This leaves
 	all your changed files "Changes to be committed", as `git status`
 	would put it.
 
---mixed::
+`--mixed`::
 	Resets the index but not the working tree (i.e., the changed files
 	are preserved but not marked for commit) and reports what has not
 	been updated. This is the default action.
@@ -67,11 +67,11 @@ section of linkgit:git-add[1] to learn how to operate the `--patch` mode.
 If `-N` is specified, removed paths are marked as intent-to-add (see
 linkgit:git-add[1]).
 
---hard::
+`--hard`::
 	Resets the index and working tree. Any changes to tracked files in the
 	working tree since `<commit>` are discarded.
 
---merge::
+`--merge`::
 	Resets the index and updates the files in the working tree that are
 	different between `<commit>` and `HEAD`, but keeps those which are
 	different between the index and working tree (i.e. which have changes
@@ -82,13 +82,13 @@ linkgit:git-add[1]).
 In other words, `--merge` does something like a `git read-tree -u -m <commit>`,
 but carries forward unmerged index entries.
 
---keep::
+`--keep`::
 	Resets index entries and updates files in the working tree that are
 	different between `<commit>` and `HEAD`.
 	If a file that is different between `<commit>` and `HEAD` has local
 	changes, reset is aborted.
 
---[no-]recurse-submodules::
+`--[no-]recurse-submodules`::
 	When the working tree is updated, using `--recurse-submodules` will
 	also recursively reset the working tree of all active submodules
 	according to the commit recorded in the superproject, also setting
@@ -102,14 +102,14 @@ between the three commands.
 OPTIONS
 -------
 
--q::
---quiet::
---no-quiet::
+`-q`::
+`--quiet`::
+`--no-quiet`::
 	Be quiet, only report errors. The default behavior is set by the
 	`reset.quiet` config option. `--quiet` and `--no-quiet` will
 	override the default behavior.
 
---pathspec-from-file=<file>::
+`--pathspec-from-file=<file>`::
 	Pathspec is passed in `<file>` instead of commandline args. If
 	`<file>` is exactly `-` then standard input is used. Pathspec
 	elements are separated by LF or CR/LF. Pathspec elements can be
@@ -117,7 +117,7 @@ OPTIONS
 	(see linkgit:git-config[1]). See also `--pathspec-file-nul` and
 	global `--literal-pathspecs`.
 
---pathspec-file-nul::
+`--pathspec-file-nul`::
 	Only meaningful with `--pathspec-from-file`. Pathspec elements are
 	separated with NUL character and all other characters are taken
 	literally (including newlines and quotes).
diff --git a/Documentation/git-restore.txt b/Documentation/git-restore.txt
index 19ca46df30..25a7160aab 100644
--- a/Documentation/git-restore.txt
+++ b/Documentation/git-restore.txt
@@ -33,7 +33,7 @@ THIS COMMAND IS EXPERIMENTAL. THE BEHAVIOR MAY CHANGE.
 OPTIONS
 -------
 -s <tree>::
---source=<tree>::
+`--source=<tree>`::
 	Restore the working tree files with the content from the given
 	tree. It is common to specify the source tree by naming a
 	commit, branch or tag associated with it.
@@ -45,8 +45,8 @@ As a special case, you may use `"A...B"` as a shortcut for the
 merge base of `A` and `B` if there is exactly one merge base. You can
 leave out at most one of `A` and `B`, in which case it defaults to `HEAD`.
 
--p::
---patch::
+`-p`::
+`--patch`::
 	Interactively select hunks in the difference between the
 	restore source and the restore location. See the ``Interactive
 	Mode'' section of linkgit:git-add[1] to learn how to operate
@@ -55,27 +55,27 @@ leave out at most one of `A` and `B`, in which case it defaults to `HEAD`.
 Note that `--patch` can accept no pathspec and will prompt to restore
 all modified paths.
 
--W::
---worktree::
--S::
---staged::
+`-W`::
+`--worktree`::
+`-S`::
+`--staged`::
 	Specify the restore location. If neither option is specified,
 	by default the working tree is restored. Specifying `--staged`
 	will only restore the index. Specifying both restores both.
 
--q::
---quiet::
+`-q`::
+`--quiet`::
 	Quiet, suppress feedback messages. Implies `--no-progress`.
 
---progress::
---no-progress::
+`--progress`::
+`--no-progress`::
 	Progress status is reported on the standard error stream
 	by default when it is attached to a terminal, unless `--quiet`
 	is specified. This flag enables progress reporting even if not
 	attached to a terminal, regardless of `--quiet`.
 
---ours::
---theirs::
+`--ours`::
+`--theirs`::
 	When restoring files in the working tree from the index, use
 	stage #2 ('ours') or #3 ('theirs') for unmerged paths.
 +
@@ -83,33 +83,33 @@ Note that during `git rebase` and `git pull --rebase`, 'ours' and
 'theirs' may appear swapped. See the explanation of the same options
 in linkgit:git-checkout[1] for details.
 
--m::
---merge::
+`-m`::
+`--merge`::
 	When restoring files on the working tree from the index,
 	recreate the conflicted merge in the unmerged paths.
 
---conflict=<style>::
+`--conflict=<style>`::
 	The same as `--merge` option above, but changes the way the
 	conflicting hunks are presented, overriding the
 	`merge.conflictStyle` configuration variable.  Possible values
 	are "merge" (default) and "diff3" (in addition to what is
 	shown by "merge" style, shows the original contents).
 
---ignore-unmerged::
+`--ignore-unmerged`::
 	When restoring files on the working tree from the index, do
 	not abort the operation if there are unmerged entries and
 	neither `--ours`, `--theirs`, `--merge` or `--conflict` is
 	specified. Unmerged paths on the working tree are left alone.
 
---ignore-skip-worktree-bits::
+`--ignore-skip-worktree-bits`::
 	In sparse checkout mode, by default is to only update entries
 	matched by `<pathspec>` and sparse patterns in
 	`$GIT_DIR/info/sparse-checkout`. This option ignores the sparse
 	patterns and unconditionally restores any files in
 	`<pathspec>`.
 
---recurse-submodules::
---no-recurse-submodules::
+`--recurse-submodules`::
+`--no-recurse-submodules`::
 	If `<pathspec>` names an active submodule and the restore location
 	includes the working tree, the submodule will only be updated if
 	this option is given, in which case its working tree will be
@@ -119,14 +119,14 @@ in linkgit:git-checkout[1] for details.
 	not be updated. Just like linkgit:git-checkout[1], this will detach
 	`HEAD` of the submodule.
 
---overlay::
---no-overlay::
+`--overlay`::
+`--no-overlay`::
 	In overlay mode, the command never removes files when
 	restoring. In no-overlay mode, tracked files that do not
 	appear in the `--source` tree are removed, to make them match
 	`<tree>` exactly. The default is no-overlay mode.
 
---pathspec-from-file=<file>::
+`--pathspec-from-file=<file>`::
 	Pathspec is passed in `<file>` instead of commandline args. If
 	`<file>` is exactly `-` then standard input is used. Pathspec
 	elements are separated by LF or CR/LF. Pathspec elements can be
@@ -134,7 +134,7 @@ in linkgit:git-checkout[1] for details.
 	(see linkgit:git-config[1]). See also `--pathspec-file-nul` and
 	global `--literal-pathspecs`.
 
---pathspec-file-nul::
+`--pathspec-file-nul`::
 	Only meaningful with `--pathspec-from-file`. Pathspec elements are
 	separated with NUL character and all other characters are taken
 	literally (including newlines and quotes).
diff --git a/Documentation/git-rev-parse.txt b/Documentation/git-rev-parse.txt
index bbace2dc5e..d84a853018 100644
--- a/Documentation/git-rev-parse.txt
+++ b/Documentation/git-rev-parse.txt
@@ -30,10 +30,10 @@ Operation Modes
 
 Each of these options must appear first on the command line.
 
---parseopt::
+`--parseopt`::
 	Use `git rev-parse` in option parsing mode (see PARSEOPT section below).
 
---sq-quote::
+`--sq-quote`::
 	Use `git rev-parse` in shell quoting mode (see SQ-QUOTE
 	section below). In contrast to the `--sq` option below, this
 	mode does only quoting. Nothing else is done to command input.
@@ -41,34 +41,34 @@ Each of these options must appear first on the command line.
 Options for --parseopt
 ~~~~~~~~~~~~~~~~~~~~~~
 
---keep-dashdash::
+`--keep-dashdash`::
 	Only meaningful in `--parseopt` mode. Tells the option parser to echo
 	out the first `--` met instead of skipping it.
 
---stop-at-non-option::
+`--stop-at-non-option`::
 	Only meaningful in `--parseopt` mode.  Lets the option parser stop at
 	the first non-option argument.  This can be used to parse sub-commands
 	that take options themselves.
 
---stuck-long::
+`--stuck-long`::
 	Only meaningful in `--parseopt` mode. Output the options in their
 	long form if available, and with their arguments stuck.
 
 Options for Filtering
 ~~~~~~~~~~~~~~~~~~~~~
 
---revs-only::
+`--revs-only`::
 	Do not output flags and parameters not meant for
 	`git rev-list` command.
 
---no-revs::
+`--no-revs`::
 	Do not output flags and parameters meant for
 	`git rev-list` command.
 
---flags::
+`--flags`::
 	Do not output non-flag parameters.
 
---no-flags::
+`--no-flags`::
 	Do not output flag parameters.
 
 Options for Output
@@ -95,7 +95,7 @@ cd "$(git rev-parse --show-toplevel)"
 eval "set $(git rev-parse --sq --prefix "$prefix" -- "$@")"
 ----
 
---verify::
+`--verify`::
 	Verify that exactly one parameter is provided, and that it
 	can be turned into a raw 20-byte SHA-1 that can be used to
 	access the object database. If so, emit it to the standard
@@ -114,14 +114,14 @@ Note that if you are verifying a name from an untrusted source, it is
 wise to use `--end-of-options` so that the name argument is not mistaken
 for another option.
 
--q::
---quiet::
+`-q`::
+`--quiet`::
 	Only meaningful in `--verify` mode. Do not output an error
 	message if the first argument is not a valid object name;
 	instead exit with non-zero status silently.
 	SHA-1s for valid object names are printed to stdout on success.
 
---sq::
+`--sq`::
 	Usually the output is made one line per flag and
 	parameter.  This option makes output a single line,
 	properly quoted for consumption by shell.  Useful when
@@ -130,13 +130,13 @@ for another option.
 	`git diff-*`). In contrast to the `--sq-quote` option,
 	the command input is still interpreted as usual.
 
---short[=length]::
+`--short[=length]`::
 	Same as `--verify` but shortens the object name to a unique
 	prefix with at least `length` characters. The minimum length
 	is 4, the default is the effective value of the `core.abbrev`
 	configuration variable (see linkgit:git-config[1]).
 
---not::
+`--not`::
 	When showing object names, prefix them with '{caret}' and
 	strip '{caret}' prefix from the object names that already have
 	one.
@@ -146,12 +146,12 @@ for another option.
 	The option `core.warnAmbiguousRefs` is used to select the strict
 	abbreviation mode.
 
---symbolic::
+`--symbolic`::
 	Usually the object names are output in SHA-1 form (with
 	possible '{caret}' prefix); this option makes them output in a
 	form as close to the original input as possible.
 
---symbolic-full-name::
+`--symbolic-full-name`::
 	This is similar to `--symbolic`, but it omits input that
 	are not refs (i.e. branch or tag names; or more
 	explicitly disambiguating "heads/master" form, when you
@@ -162,12 +162,12 @@ for another option.
 Options for Objects
 ~~~~~~~~~~~~~~~~~~~
 
---all::
+`--all`::
 	Show all refs found in `refs/`.
 
---branches[=pattern]::
---tags[=pattern]::
---remotes[=pattern]::
+`--branches[=pattern]`::
+`--tags[=pattern]`::
+`--remotes[=pattern]`::
 	Show all branches, tags, or remote-tracking branches,
 	respectively (i.e., refs found in `refs/heads`,
 	`refs/tags`, or `refs/remotes`, respectively).
@@ -176,14 +176,14 @@ If a `pattern` is given, only refs matching the given shell glob are
 shown.  If the pattern does not contain a globbing character (`?`,
 `*`, or `[`), it is turned into a prefix match by appending `/*`.
 
---glob=pattern::
+`--glob=pattern`::
 	Show all refs matching the shell glob pattern `pattern`. If
 	the pattern does not start with `refs/`, this is automatically
 	prepended.  If the pattern does not contain a globbing
 	character (`?`, `*`, or `[`), it is turned into a prefix
 	match by appending `/*`.
 
---exclude=<glob-pattern>::
+`--exclude=<glob-pattern>`::
 	Do not include refs matching '<glob-pattern>' that the next `--all`,
 	`--branches`, `--tags`, `--remotes`, or `--glob` would otherwise
 	consider. Repetitions of this option accumulate exclusion patterns
@@ -197,7 +197,7 @@ respectively, and they must begin with `refs/` when applied to `--glob`
 or `--all`. If a trailing '/{asterisk}' is intended, it must be given
 explicitly.
 
---disambiguate=<prefix>::
+`--disambiguate=<prefix>`::
 	Show every object whose name begins with the given prefix.
 	The <prefix> must be at least 4 hexadecimal digits long to
 	avoid listing each and every object in the repository by
@@ -206,7 +206,7 @@ explicitly.
 Options for Files
 ~~~~~~~~~~~~~~~~~
 
---local-env-vars::
+`--local-env-vars`::
 	List the GIT_* environment variables that are local to the
 	repository (e.g. GIT_DIR or GIT_WORK_TREE, but not GIT_EDITOR).
 	Only the names of the variables are listed, not their value,
@@ -224,7 +224,7 @@ instance of this option.
 
 The following options are modified by `--path-format`:
 
---git-dir::
+`--git-dir`::
 	Show `$GIT_DIR` if defined. Otherwise show the path to
 	the .git directory. The path shown, when relative, is
 	relative to the current working directory.
@@ -233,7 +233,7 @@ If `$GIT_DIR` is not defined and the current directory
 is not detected to lie in a Git repository or work tree
 print a message to stderr and exit with nonzero status.
 
---git-common-dir::
+`--git-common-dir`::
 	Show `$GIT_COMMON_DIR` if defined, else `$GIT_DIR`.
 
 --resolve-git-dir <path>::
@@ -249,46 +249,46 @@ print a message to stderr and exit with nonzero status.
 	`$GIT_OBJECT_DIRECTORY` is set to /foo/bar then `git rev-parse
 	--git-path objects/abc` returns /foo/bar/abc.
 
---show-toplevel::
+`--show-toplevel`::
 	Show the (by default, absolute) path of the top-level directory
 	of the working tree. If there is no working tree, report an error.
 
---show-superproject-working-tree::
+`--show-superproject-working-tree`::
 	Show the absolute path of the root of the superproject's
 	working tree (if exists) that uses the current repository as
 	its submodule.  Outputs nothing if the current repository is
 	not used as a submodule by any project.
 
---shared-index-path::
+`--shared-index-path`::
 	Show the path to the shared index file in split index mode, or
 	empty if not in split-index mode.
 
 The following options are unaffected by `--path-format`:
 
---absolute-git-dir::
+`--absolute-git-dir`::
 	Like `--git-dir`, but its output is always the canonicalized
 	absolute path.
 
---is-inside-git-dir::
+`--is-inside-git-dir`::
 	When the current working directory is below the repository
 	directory print "true", otherwise "false".
 
---is-inside-work-tree::
+`--is-inside-work-tree`::
 	When the current working directory is inside the work tree of the
 	repository print "true", otherwise "false".
 
---is-bare-repository::
+`--is-bare-repository`::
 	When the repository is bare print "true", otherwise "false".
 
---is-shallow-repository::
+`--is-shallow-repository`::
 	When the repository is shallow print "true", otherwise "false".
 
---show-cdup::
+`--show-cdup`::
 	When the command is invoked from a subdirectory, show the
 	path of the top-level directory relative to the current
 	directory (typically a sequence of "../", or an empty string).
 
---show-prefix::
+`--show-prefix`::
 	When the command is invoked from a subdirectory, show the
 	path of the current directory relative to the top-level
 	directory.
@@ -303,13 +303,13 @@ The following options are unaffected by `--path-format`:
 Other Options
 ~~~~~~~~~~~~~
 
---since=datestring::
---after=datestring::
+`--since=datestring`::
+`--after=datestring`::
 	Parse the date string, and output the corresponding
 	`--max-age`= parameter for `git rev-list`.
 
---until=datestring::
---before=datestring::
+`--until=datestring`::
+`--before=datestring`::
 	Parse the date string, and output the corresponding
 	`--min-age`= parameter for `git rev-list`.
 
diff --git a/Documentation/git-revert.txt b/Documentation/git-revert.txt
index 0ebe45153e..5fde44478f 100644
--- a/Documentation/git-revert.txt
+++ b/Documentation/git-revert.txt
@@ -41,8 +41,8 @@ OPTIONS
 	default, see linkgit:git-rev-list[1] and its `--no-walk`
 	option.
 
--e::
---edit::
+`-e`::
+`--edit`::
 	With this option, `git revert` will let you edit the commit
 	message prior to committing the revert. This is the default if
 	you run the command from a terminal.
@@ -63,19 +63,19 @@ reverted merge.  This may or may not be what you want.
 See the link:howto/revert-a-faulty-merge.html[revert-a-faulty-merge How-To] for
 more details.
 
---no-edit::
+`--no-edit`::
 	With this option, `git revert` will not start the commit
 	message editor.
 
---cleanup=<mode>::
+`--cleanup=<mode>`::
 	This option determines how the commit message will be cleaned up before
 	being passed on to the commit machinery. See linkgit:git-commit[1] for more
 	details. In particular, if the '<mode>' is given a value of `scissors`,
 	scissors will be appended to `MERGE_MSG` before being passed on in the case
 	of a conflict.
 
--n::
---no-commit::
+`-n`::
+`--no-commit`::
 	Usually the command automatically creates some commits with
 	commit log messages stating which commits were
 	reverted.  This flag applies the changes necessary
@@ -88,32 +88,32 @@ more details.
 This is useful when reverting more than one commits'
 effect to your index in a row.
 
--S[<keyid>]::
---gpg-sign[=<keyid>]::
---no-gpg-sign::
+`-S[<keyid>]`::
+`--gpg-sign[=<keyid>]`::
+`--no-gpg-sign`::
 	GPG-sign commits. The `keyid` argument is optional and
 	defaults to the committer identity; if specified, it must be
 	stuck to the option without a space. `--no-gpg-sign` is useful to
 	countermand both `commit.gpgSign` configuration variable, and
 	earlier `--gpg-sign`.
 
--s::
---signoff::
+`-s`::
+`--signoff`::
 	Add a `Signed-off-by` trailer at the end of the commit message.
 	See the signoff option in linkgit:git-commit[1] for more information.
 
---strategy=<strategy>::
+`--strategy=<strategy>`::
 	Use the given merge strategy.  Should only be used once.
 	See the MERGE STRATEGIES section in linkgit:git-merge[1]
 	for details.
 
--X<option>::
---strategy-option=<option>::
+`-X<option>`::
+`--strategy-option=<option>`::
 	Pass the merge strategy-specific option through to the
 	merge strategy.  See linkgit:git-merge[1] for details.
 
---rerere-autoupdate::
---no-rerere-autoupdate::
+`--rerere-autoupdate`::
+`--no-rerere-autoupdate`::
 	Allow the rerere mechanism to update the index with the
 	result of auto-conflict resolution if possible.
 
diff --git a/Documentation/git-rm.txt b/Documentation/git-rm.txt
index 24eb799d6e..d1f49a0bea 100644
--- a/Documentation/git-rm.txt
+++ b/Documentation/git-rm.txt
@@ -43,17 +43,17 @@ of directory `d2`.
 +
 For more details, see the 'pathspec' entry in linkgit:gitglossary[7].
 
--f::
---force::
+`-f`::
+`--force`::
 	Override the up-to-date check.
 
--n::
---dry-run::
+`-n`::
+`--dry-run`::
 	Don't actually remove any file(s).  Instead, just show
 	if they exist in the index and would otherwise be removed
 	by the command.
 
--r::
+`-r`::
         Allow recursive removal when a leading directory name is
         given.
 
@@ -62,20 +62,20 @@ For more details, see the 'pathspec' entry in linkgit:gitglossary[7].
 	the list of files, (useful when filenames might be mistaken
 	for command-line options).
 
---cached::
+`--cached`::
 	Use this option to unstage and remove paths only from the index.
 	Working tree files, whether modified or not, will be
 	left alone.
 
---ignore-unmatch::
+`--ignore-unmatch`::
 	Exit with a zero status even if no files matched.
 
--q::
---quiet::
+`-q`::
+`--quiet`::
 	`git rm` normally outputs one line (in the form of an `rm` command)
 	for each file removed. This option suppresses that output.
 
---pathspec-from-file=<file>::
+`--pathspec-from-file=<file>`::
 	Pathspec is passed in `<file>` instead of commandline args. If
 	`<file>` is exactly `-` then standard input is used. Pathspec
 	elements are separated by LF or CR/LF. Pathspec elements can be
@@ -83,7 +83,7 @@ For more details, see the 'pathspec' entry in linkgit:gitglossary[7].
 	(see linkgit:git-config[1]). See also `--pathspec-file-nul` and
 	global `--literal-pathspecs`.
 
---pathspec-file-nul::
+`--pathspec-file-nul`::
 	Only meaningful with `--pathspec-from-file`. Pathspec elements are
 	separated with NUL character and all other characters are taken
 	literally (including newlines and quotes).
diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
index 9455d4c654..6e96c23492 100644
--- a/Documentation/git-send-email.txt
+++ b/Documentation/git-send-email.txt
@@ -45,7 +45,7 @@ OPTIONS
 Composing
 ~~~~~~~~~
 
---annotate::
+`--annotate`::
 	Review and edit each patch you're about to send. Default is the value
 	of `sendemail.annotate`. See the CONFIGURATION section for
 	`sendemail.multiEdit`.
@@ -62,7 +62,7 @@ This option may be specified multiple times.
 +
 This option may be specified multiple times.
 
---compose::
+`--compose`::
 	Invoke a text editor (see GIT_EDITOR in linkgit:git-var[1])
 	to edit an introductory message for the patch series.
 +
@@ -76,7 +76,7 @@ Missing From or In-Reply-To headers will be prompted for.
 +
 See the CONFIGURATION section for `sendemail.multiEdit`.
 
---from=<address>::
+`--from=<address>`::
 	Specify the sender of the emails.  If not specified on the command line,
 	the value of the `sendemail.from` configuration option is used.  If
 	neither the command-line option nor `sendemail.from` are set, then the
@@ -84,12 +84,12 @@ See the CONFIGURATION section for `sendemail.multiEdit`.
 	the value of GIT_AUTHOR_IDENT, or GIT_COMMITTER_IDENT if that is not
 	set, as returned by `git var -l`.
 
---reply-to=<address>::
+`--reply-to=<address>`::
 	Specify the address where replies from recipients should go to.
 	Use this if replies to messages should go to another address than what
 	is specified with the `--from` parameter.
 
---in-reply-to=<identifier>::
+`--in-reply-to=<identifier>`::
 	Make the first mail (or all the mails with `--no-thread`) appear as a
 	reply to the given Message-Id, which avoids breaking threads to
 	provide a new patch series.
@@ -111,7 +111,7 @@ illustration below where `[PATCH v2 0/3]` is in reply to `[PATCH 0/2]`:
 Only necessary if `--compose` is also set.  If `--compose`
 is not set, this will be prompted for.
 
---subject=<string>::
+`--subject=<string>`::
 	Specify the initial subject of the email thread.
 	Only necessary if `--compose` is also set.  If `--compose`
 	is not set, this will be prompted for.
@@ -133,7 +133,7 @@ This option may be specified multiple times.
 +
 Note that no attempts whatsoever are made to validate the encoding.
 
---compose-encoding=<encoding>::
+`--compose-encoding=<encoding>`::
 	Specify encoding of compose message. Default is the value of the
 	`sendemail.composeencoding`; if that is unspecified, UTF-8 is assumed.
 
@@ -149,8 +149,8 @@ Note that no attempts whatsoever are made to validate the encoding.
 Default is the value of the `sendemail.transferEncoding` configuration
 value; if that is unspecified, default to `auto`.
 
---xmailer::
---no-xmailer::
+`--xmailer`::
+`--no-xmailer`::
 	Add (or prevent adding) the "X-Mailer:" header.  By default,
 	the header is added, but it can be turned off by setting the
 	`sendemail.xmailer` configuration variable to `false`.
@@ -158,7 +158,7 @@ value; if that is unspecified, default to `auto`.
 Sending
 ~~~~~~~
 
---envelope-sender=<address>::
+`--envelope-sender=<address>`::
 	Specify the envelope sender used to send the emails.
 	This is useful if your default address is not the address that is
 	subscribed to a list. In order to use the 'From' address, set the
@@ -167,19 +167,19 @@ Sending
 	`sendemail.envelopeSender` configuration variable; if that is
 	unspecified, choosing the envelope sender is left to your MTA.
 
---smtp-encryption=<encryption>::
+`--smtp-encryption=<encryption>`::
 	Specify the encryption to use, either 'ssl' or 'tls'.  Any other
 	value reverts to plain SMTP.  Default is the value of
 	`sendemail.smtpEncryption`.
 
---smtp-domain=<FQDN>::
+`--smtp-domain=<FQDN>`::
 	Specifies the Fully Qualified Domain Name (FQDN) used in the
 	HELO/EHLO command to the SMTP server.  Some servers require the
 	FQDN to match your IP address.  If not set, `git send-email` attempts
 	to determine your FQDN automatically.  Default is the value of
 	`sendemail.smtpDomain`.
 
---smtp-auth=<mechanisms>::
+`--smtp-auth=<mechanisms>`::
 	Whitespace-separated list of allowed SMTP-AUTH mechanisms. This setting
 	forces using only the listed mechanisms. Example:
 +
@@ -194,7 +194,7 @@ is specified, all mechanisms supported by the SASL library can be used. The
 special value 'none' maybe specified to completely disable authentication
 independently of `--smtp-user`
 
---smtp-pass[=<password>]::
+`--smtp-pass[=<password>]`::
 	Password for SMTP-AUTH. The argument is optional: If no
 	argument is specified, then the empty string is used as
 	the password. Default is the value of `sendemail.smtpPass`,
@@ -206,10 +206,10 @@ or on the command line. If a username has been specified (with
 specified (with `--smtp-pass` or `sendemail.smtpPass`), then
 a password is obtained using `git-credential`.
 
---no-smtp-auth::
+`--no-smtp-auth`::
 	Disable SMTP authentication. Short hand for `--smtp-auth=none`
 
---smtp-server=<host>::
+`--smtp-server=<host>`::
 	If set, specifies the outgoing SMTP server to use (e.g.
 	`smtp.example.com` or a raw IP address).  Alternatively it can
 	specify a full pathname of a sendmail-like program instead;
@@ -219,7 +219,7 @@ a password is obtained using `git-credential`.
 	`/usr/sbin`, `/usr/lib` and `$PATH` if such program is
 	available, falling back to `localhost` otherwise.
 
---smtp-server-port=<port>::
+`--smtp-server-port=<port>`::
 	Specifies a port different from the default port (SMTP
 	servers typically listen to smtp port 25, but may also listen to
 	submission port 587, or the common SSL smtp port 465);
@@ -227,7 +227,7 @@ a password is obtained using `git-credential`.
 	are also accepted. The port can also be set with the
 	`sendemail.smtpServerPort` configuration variable.
 
---smtp-server-option=<option>::
+`--smtp-server-option=<option>`::
 	If set, specifies the outgoing SMTP server option to use.
 	Default value can be specified by the `sendemail.smtpServerOption`
 	configuration option.
@@ -236,10 +236,10 @@ The `--smtp-server-option` option must be repeated for each option you want
 to pass to the server. Likewise, different lines in the configuration files
 must be used for each option.
 
---smtp-ssl::
+`--smtp-ssl`::
 	Legacy alias for `--smtp-encryption ssl`.
 
---smtp-ssl-cert-path::
+`--smtp-ssl-cert-path`::
 	Path to a store of trusted CA certificates for SMTP SSL/TLS
 	certificate validation (either a directory that has been processed
 	by 'c_rehash', or a single file containing one or more PEM format
@@ -250,7 +250,7 @@ must be used for each option.
 	backing SSL library's compiled-in default otherwise (which should
 	be the best choice on most platforms).
 
---smtp-user=<user>::
+`--smtp-user=<user>`::
 	Username for SMTP-AUTH. Default is the value of `sendemail.smtpUser`;
 	if a username is not specified (with `--smtp-user` or `sendemail.smtpUser`),
 	then authentication is not attempted.
@@ -260,7 +260,7 @@ must be used for each option.
 	commands and replies will be printed. Useful to debug TLS
 	connection and authentication problems.
 
---batch-size=<num>::
+`--batch-size=<num>`::
 	Some email servers (e.g. smtp.163.com) limit the number emails to be
 	sent per session (connection) and this will lead to a failure when
 	sending many messages.  With this option, send-email will disconnect after
@@ -270,7 +270,7 @@ must be used for each option.
 	your password every time this happens.  Defaults to the
 	`sendemail.smtpBatchSize` configuration variable.
 
---relogin-delay=<int>::
+`--relogin-delay=<int>`::
 	Waiting $<int> seconds before reconnecting to SMTP server. Used together
 	with `--batch-size` option.  Defaults to the `sendemail.smtpReloginDelay`
 	configuration variable.
@@ -282,23 +282,23 @@ Automating
 	Clears any list of "To:", "Cc:", "Bcc:" addresses previously
 	set via config.
 
---no-identity::
+`--no-identity`::
 	Clears the previously read value of `sendemail.identity` set
 	via config, if any.
 
---to-cmd=<command>::
+`--to-cmd=<command>`::
 	Specify a command to execute once per patch file which
 	should generate patch file specific "To:" entries.
 	Output of this command must be single email address per line.
 	Default is the value of `sendemail.tocmd` configuration value.
 
---cc-cmd=<command>::
+`--cc-cmd=<command>`::
 	Specify a command to execute once per patch file which
 	should generate patch file specific "Cc:" entries.
 	Output of this command must be single email address per line.
 	Default is the value of `sendemail.ccCmd` configuration value.
 
---[no-]chain-reply-to::
+`--[no-]chain-reply-to`::
 	If this is set, each email will be sent as a reply to the previous
 	email sent.  If disabled with `--no-chain-reply-to`, all emails after
 	the first will be sent as replies to the first email sent.  When using
@@ -306,30 +306,30 @@ Automating
 	entire patch series. Disabled by default, but the `sendemail.chainReplyTo`
 	configuration variable can be used to enable it.
 
---identity=<identity>::
+`--identity=<identity>`::
 	A configuration identity. When given, causes values in the
 	`sendemail.<identity>` subsection to take precedence over
 	values in the `sendemail` section. The default identity is
 	the value of `sendemail.identity`.
 
---[no-]signed-off-by-cc::
+`--[no-]signed-off-by-cc`::
 	If this is set, add emails found in the `Signed-off-by` trailer or Cc: lines to the
 	cc list. Default is the value of `sendemail.signedoffbycc` configuration
 	value; if that is unspecified, default to `--signed-off-by-cc`.
 
---[no-]cc-cover::
+`--[no-]cc-cover`::
 	If this is set, emails found in Cc: headers in the first patch of
 	the series (typically the cover letter) are added to the cc list
 	for each email set. Default is the value of `sendemail.cccover`
 	configuration value; if that is unspecified, default to `--no-cc-cover`.
 
---[no-]to-cover::
+`--[no-]to-cover`::
 	If this is set, emails found in To: headers in the first patch of
 	the series (typically the cover letter) are added to the to list
 	for each email set. Default is the value of `sendemail.tocover`
 	configuration value; if that is unspecified, default to `--no-to-cover`.
 
---suppress-cc=<category>::
+`--suppress-cc=<category>`::
 	Specify an additional category of recipients to suppress the
 	auto-cc of:
 +
@@ -354,12 +354,12 @@ Default is the value of `sendemail.suppresscc` configuration value; if
 that is unspecified, default to 'self' if `--suppress-from` is
 specified, as well as 'body' if `--no-signed-off-cc` is specified.
 
---[no-]suppress-from::
+`--[no-]suppress-from`::
 	If this is set, do not add the From: address to the cc: list.
 	Default is the value of `sendemail.suppressFrom` configuration
 	value; if that is unspecified, default to `--no-suppress-from`.
 
---[no-]thread::
+`--[no-]thread`::
 	If this is set, the In-Reply-To and References headers will be
 	added to each email sent.  Whether each mail refers to the
 	previous email (`deep` threading per `git format-patch`
@@ -381,7 +381,7 @@ recipient's MUA.
 Administering
 ~~~~~~~~~~~~~
 
---confirm=<mode>::
+`--confirm=<mode>`::
 	Confirm just before sending:
 +
 --
@@ -397,20 +397,20 @@ Default is the value of `sendemail.confirm` configuration value; if that
 is unspecified, default to 'auto' unless any of the suppress options
 have been specified, in which case default to 'compose'.
 
---dry-run::
+`--dry-run`::
 	Do everything except actually send the emails.
 
---[no-]format-patch::
+`--[no-]format-patch`::
 	When an argument may be understood either as a reference or as a file name,
 	choose to understand it as a format-patch argument (`--format-patch`)
 	or as a file name (`--no-format-patch`). By default, when such a conflict
 	occurs, `git send-email` will fail.
 
---quiet::
+`--quiet`::
 	Make `git-send-email` less verbose.  One line per email should be
 	all that is output.
 
---[no-]validate::
+`--[no-]validate`::
 	Perform sanity checks on patches.
 	Currently, validation means the following:
 +
@@ -426,14 +426,14 @@ have been specified, in which case default to 'compose'.
 Default is the value of `sendemail.validate`; if this is not set,
 default to `--validate`.
 
---force::
+`--force`::
 	Send emails even if safety checks would prevent it.
 
 
 Information
 ~~~~~~~~~~~
 
---dump-aliases::
+`--dump-aliases`::
 	Instead of the normal operation, dump the shorthand alias names from
 	the configured alias file(s), one per line in alphabetical order. Note,
 	this only includes the alias name and not its expanded email addresses.
@@ -457,7 +457,7 @@ differences and limitations from the standard formats are
 described below:
 +
 --
-sendmail;;
+`sendmail`;;
 *	Quoted aliases and quoted addresses are not supported: lines that
 	contain a `"` symbol are ignored.
 *	Redirection to a file (`/path/name`) or pipe (`|command`) is not
diff --git a/Documentation/git-send-pack.txt b/Documentation/git-send-pack.txt
index c0303d72eb..2852d3981b 100644
--- a/Documentation/git-send-pack.txt
+++ b/Documentation/git-send-pack.txt
@@ -25,20 +25,20 @@ updates it from the current repository, sending named refs.
 
 OPTIONS
 -------
---receive-pack=<git-receive-pack>::
+`--receive-pack=<git-receive-pack>`::
 	Path to the `git-receive-pack` program on the remote
 	end.  Sometimes useful when pushing to a remote
 	repository over ssh, and you do not have the program in
 	a directory on the default `$PATH`.
 
---exec=<git-receive-pack>::
+`--exec=<git-receive-pack>`::
 	Same as `--receive-pack`=<git-receive-pack>.
 
---all::
+`--all`::
 	Instead of explicitly specifying which refs to update,
 	update all heads that locally exist.
 
---stdin::
+`--stdin`::
 	Take the list of refs from stdin, one per line. If there
 	are refs specified on the command line in addition to this
 	option, then the refs from stdin are processed after those
@@ -48,29 +48,29 @@ If `--stateless-rpc` is specified together with this option then
 the list of refs must be in packet format (pkt-line). Each ref must
 be in a separate packet, and the list must end with a flush packet.
 
---dry-run::
+`--dry-run`::
 	Do everything except actually send the updates.
 
---force::
+`--force`::
 	Usually, the command refuses to update a remote ref that
 	is not an ancestor of the local ref used to overwrite it.
 	This flag disables the check.  What this means is that
 	the remote repository can lose commits; use it with
 	care.
 
---verbose::
+`--verbose`::
 	Run verbosely.
 
---thin::
+`--thin`::
 	Send a "thin" pack, which records objects in deltified form based
 	on objects not included in the pack to reduce network traffic.
 
---atomic::
+`--atomic`::
 	Use an atomic transaction for updating the refs. If any of the refs
 	fails to update then the entire push will fail without changing any
 	refs.
 
---[no-]signed::
+`--[no-]signed`::
 --signed=(true|false|if-asked)::
 	GPG-sign the push request to update refs on the receiving
 	side, to allow it to be checked by the hooks and/or be
@@ -81,18 +81,18 @@ be in a separate packet, and the list must end with a flush packet.
 	will also fail if the actual call to `gpg --sign` fails.  See
 	linkgit:git-receive-pack[1] for the details on the receiving end.
 
---push-option=<string>::
+`--push-option=<string>`::
 	Pass the specified string as a push option for consumption by
 	hooks on the server side.  If the server doesn't support push
 	options, error out.  See linkgit:git-push[1] and
 	linkgit:githooks[5] for details.
 
-<host>::
+`<host>`::
 	A remote host to house the repository.  When this
 	part is specified, `git-receive-pack` is invoked via
 	ssh.
 
-<directory>::
+`<directory>`::
 	The repository to update.
 
 <ref>...::
diff --git a/Documentation/git-sh-i18n.txt b/Documentation/git-sh-i18n.txt
index 23c504bbd8..ea8fc781e8 100644
--- a/Documentation/git-sh-i18n.txt
+++ b/Documentation/git-sh-i18n.txt
@@ -27,7 +27,7 @@ without GNU gettext.
 FUNCTIONS
 ---------
 
-gettext::
+`gettext`::
 	Currently a dummy fall-through function implemented as a wrapper
 	around `printf(1)`. Will be replaced by a real gettext
 	implementation in a later version.
diff --git a/Documentation/git-sh-setup.txt b/Documentation/git-sh-setup.txt
index ed33a46a77..d1e999d60e 100644
--- a/Documentation/git-sh-setup.txt
+++ b/Documentation/git-sh-setup.txt
@@ -33,11 +33,11 @@ variables, but does *not* export them to the environment.
 FUNCTIONS
 ---------
 
-die::
+`die`::
 	exit after emitting the supplied error message to the
 	standard error stream.
 
-usage::
+`usage`::
 	die with the usage message.
 
 set_reflog_action::
diff --git a/Documentation/git-shortlog.txt b/Documentation/git-shortlog.txt
index d9226b63da..c3f6997d2e 100644
--- a/Documentation/git-shortlog.txt
+++ b/Documentation/git-shortlog.txt
@@ -26,20 +26,20 @@ reference to the current repository.
 OPTIONS
 -------
 
--n::
---numbered::
+`-n`::
+`--numbered`::
 	Sort output according to the number of commits per author instead
 	of author alphabetic order.
 
--s::
---summary::
+`-s`::
+`--summary`::
 	Suppress commit description and provide a commit count summary only.
 
--e::
---email::
+`-e`::
+`--email`::
 	Show the email address of each author.
 
---format[=<format>]::
+`--format[=<format>]`::
 	Instead of the commit subject, use some other information to
 	describe each commit.  '<format>' can be any string accepted
 	by the `--format` option of `git log`, such as '* [%h] %s'.
@@ -47,7 +47,7 @@ OPTIONS
 
 	Each pretty-printed commit will be rewrapped before it is shown.
 
---group=<type>::
+`--group=<type>`::
 	Group commits based on `<type>`. If no `--group` option is
 	specified, the default is `author`. `<type>` is one of:
 +
@@ -76,8 +76,8 @@ value (but again, only once per unique value in that commit). For
 example, `git shortlog --group=author --group=trailer:co-authored-by`
 counts both authors and co-authors.
 
--c::
---committer::
+`-c`::
+`--committer`::
 	This is an alias for `--group=committer`.
 
 -w[<width>[,<indent1>[,<indent2>]]]::
diff --git a/Documentation/git-show-branch.txt b/Documentation/git-show-branch.txt
index 79f65ce0aa..017390e1ed 100644
--- a/Documentation/git-show-branch.txt
+++ b/Documentation/git-show-branch.txt
@@ -30,46 +30,46 @@ no <rev> or <glob> is given on the command line.
 
 OPTIONS
 -------
-<rev>::
+`<rev>`::
 	Arbitrary extended SHA-1 expression (see linkgit:gitrevisions[7])
 	that typically names a branch head or a tag.
 
-<glob>::
+`<glob>`::
 	A glob pattern that matches branch or tag names under
 	refs/.  For example, if you have many topic
 	branches under refs/heads/topic, giving
 	`topic/*` would show all of them.
 
--r::
---remotes::
+`-r`::
+`--remotes`::
 	Show the remote-tracking branches.
 
--a::
---all::
+`-a`::
+`--all`::
 	Show both remote-tracking branches and local branches.
 
---current::
+`--current`::
 	With this option, the command includes the current
 	branch to the list of revs to be shown when it is not
 	given on the command line.
 
---topo-order::
+`--topo-order`::
         By default, the branches and their commits are shown in
         reverse chronological order.  This option makes them
         appear in topological order (i.e., descendant commits
         are shown before their parents).
 
---date-order::
+`--date-order`::
 	This option is similar to `--topo-order` in the sense that no
 	parent comes before all of its children, but otherwise commits
 	are ordered according to their commit date.
 
---sparse::
+`--sparse`::
 	By default, the output omits merges that are reachable
 	from only one tip being shown.  This option makes them
 	visible.
 
---more=<n>::
+`--more=<n>`::
 	Usually the command stops output upon showing the commit
 	that is the common ancestor of all the branches.  This
 	flag tells the command to go <n> more common commits
@@ -77,21 +77,21 @@ OPTIONS
 	<reference>s given, without showing the commit ancestry
 	tree.
 
---list::
+`--list`::
 	Synonym to `--more=-1`
 
---merge-base::
+`--merge-base`::
 	Instead of showing the commit list, determine possible
 	merge bases for the specified commits. All merge bases
 	will be contained in all specified commits. This is
 	different from how linkgit:git-merge-base[1] handles
 	the case of three or more commits.
 
---independent::
+`--independent`::
 	Among the <reference>s given, display only the ones that
 	cannot be reached from any other <reference>.
 
---no-name::
+`--no-name`::
 	Do not show naming strings for each commit.
 
 --sha1-name::
@@ -100,7 +100,7 @@ OPTIONS
 	of "master"), name them with the unique prefix of their
 	object names.
 
---topics::
+`--topics`::
 	Shows only commits that are NOT on the first branch given.
 	This helps track topic branches by hiding any commit that
 	is already in the main line of development.  When given
@@ -108,7 +108,7 @@ OPTIONS
 	will show the revisions given by `git rev-list {caret}master
 	topic1 topic2`
 
--g::
+`-g`::
 --reflog[=<n>[,<base>]] [<ref>]::
 	Shows <n> most recent ref-log entries for the given
 	ref.  If <base> is given, <n> entries going back from
@@ -116,12 +116,12 @@ OPTIONS
 	When no explicit <ref> parameter is given, it defaults to the
 	current branch (or `HEAD` if it is detached).
 
---color[=<when>]::
+`--color[=<when>]`::
 	Color the status sign (one of these: `*` `!` `+` `-`) of each commit
 	corresponding to the branch it's in.
 	The value must be always (the default), never, or auto.
 
---no-color::
+`--no-color`::
 	Turn off colored output, even when the configuration file gives the
 	default to color output.
 	Same as `--color=never`.
diff --git a/Documentation/git-show-ref.txt b/Documentation/git-show-ref.txt
index 2a3699cb7f..3d8e1f455b 100644
--- a/Documentation/git-show-ref.txt
+++ b/Documentation/git-show-ref.txt
@@ -33,47 +33,47 @@ the `.git` directory.
 OPTIONS
 -------
 
---head::
+`--head`::
 
 	Show the `HEAD` reference, even if it would normally be filtered out.
 
---heads::
---tags::
+`--heads`::
+`--tags`::
 
 	Limit to `refs/heads` and `refs/tags`, respectively.  These options
 	are not mutually exclusive; when given both, references stored in
 	`refs/heads` and `refs/tags` are displayed.
 
--d::
---dereference::
+`-d`::
+`--dereference`::
 
 	Dereference tags into object IDs as well. They will be shown with "{caret}{}"
 	appended.
 
--s::
---hash[=<n>]::
+`-s`::
+`--hash[=<n>]`::
 
 	Only show the SHA-1 hash, not the reference name. When combined with
 	`--dereference` the dereferenced tag will still be shown after the SHA-1.
 
---verify::
+`--verify`::
 
 	Enable stricter reference checking by requiring an exact ref path.
 	Aside from returning an error code of 1, it will also print an error
 	message if `--quiet` was not specified.
 
---abbrev[=<n>]::
+`--abbrev[=<n>]`::
 
 	Abbreviate the object name.  When using `--hash`, you do
 	not have to say `--hash --abbrev`; `--hash=n` would do.
 
--q::
---quiet::
+`-q`::
+`--quiet`::
 
 	Do not print any results to stdout. When combined with `--verify` this
 	can be used to silently check if a reference exists.
 
---exclude-existing[=<pattern>]::
+`--exclude-existing[=<pattern>]`::
 
 	Make `git show-ref` act as a filter that reads refs from stdin of the
 	form "`^(?:<anything>\s)?<refname>(?:\^{})?$`"
diff --git a/Documentation/git-sparse-checkout.txt b/Documentation/git-sparse-checkout.txt
index efadc656e8..1655282b58 100644
--- a/Documentation/git-sparse-checkout.txt
+++ b/Documentation/git-sparse-checkout.txt
@@ -27,10 +27,10 @@ THE FUTURE.
 
 COMMANDS
 --------
-'list'::
+`list`::
 	Describe the patterns in the sparse-checkout file.
 
-'init'::
+`init`::
 	Enable the `core.sparseCheckout` setting. If the
 	sparse-checkout file does not exist, then populate it with
 	patterns that match every file in the root directory and
@@ -46,7 +46,7 @@ When `--cone` is provided, the `core.sparseCheckoutCone` setting is
 also set, allowing for better performance with a limited set of
 patterns (see 'CONE PATTERN SET' below).
 
-'set'::
+`set`::
 	Write a set of patterns to the sparse-checkout file, as given as
 	a list of arguments following the 'set' subcommand. Update the
 	working directory to match the new patterns. Enable the
@@ -63,14 +63,14 @@ directories. The input format matches the output of `git ls-tree --name-only`.
 This includes interpreting pathnames that begin with a double quote (") as
 C-style quoted strings.
 
-'add'::
+`add`::
 	Update the sparse-checkout file to include additional patterns.
 	By default, these patterns are read from the command-line arguments,
 	but they can be read from stdin using the `--stdin` option. When
 	`core.sparseCheckoutCone` is enabled, the given patterns are interpreted
 	as directory names as in the 'set' subcommand.
 
-'reapply'::
+`reapply`::
 	Reapply the sparsity pattern rules to paths in the working tree.
 	Commands like merge or rebase can materialize paths to do their
 	work (e.g. in order to show you a conflict), and other
@@ -80,7 +80,7 @@ C-style quoted strings.
 	after cleaning up affected paths (e.g. resolving conflicts, undoing
 	or committing changes, etc.).
 
-'disable'::
+`disable`::
 	Disable the `core.sparseCheckout` config setting, and restore the
 	working directory to include all files. Leaves the sparse-checkout
 	file intact so a later `git sparse-checkout init` command may
diff --git a/Documentation/git-stash.txt b/Documentation/git-stash.txt
index 142e5f3751..974b16963c 100644
--- a/Documentation/git-stash.txt
+++ b/Documentation/git-stash.txt
@@ -125,7 +125,7 @@ the stash entry is applied on top of the commit that was `HEAD` at the
 time `git stash` was run, it restores the originally stashed state
 with no conflicts.
 
-clear::
+`clear`::
 	Remove all the stash entries. Note that those entries will then
 	be subject to pruning, and may be impossible to recover (see
 	'Examples' below for a possible strategy).
@@ -134,7 +134,7 @@ drop [-q|--quiet] [<stash>]::
 
 	Remove a single stash entry from the list of stash entries.
 
-create::
+`create`::
 
 	Create a stash entry (which is a regular commit object) and
 	return its object name, without storing it anywhere in the ref
@@ -142,7 +142,7 @@ create::
 	This is intended to be useful for scripts.  It is probably not
 	the command you want to use; see "push" above.
 
-store::
+`store`::
 
 	Store a given stash created via `git stash create` (which is a
 	dangling merge commit) in the stash ref, updating the stash
@@ -151,16 +151,16 @@ store::
 
 OPTIONS
 -------
--a::
---all::
+`-a`::
+`--all`::
 	This option is only valid for `push` and `save` commands.
 +
 All ignored and untracked files are also stashed and then cleaned
 up with `git clean`.
 
--u::
---include-untracked::
---no-include-untracked::
+`-u`::
+`--include-untracked`::
+`--no-include-untracked`::
 	When used with the `push` and `save` commands,
 	all untracked files are also stashed and then cleaned up with
 	`git clean`.
@@ -168,12 +168,12 @@ up with `git clean`.
 When used with the `show` command, show the untracked files in the stash
 entry as part of the diff.
 
---only-untracked::
+`--only-untracked`::
 	This option is only valid for the `show` command.
 +
 Show only the untracked files in the stash entry as part of the diff.
 
---index::
+`--index`::
 	This option is only valid for `pop` and `apply` commands.
 +
 Tries to reinstate not only the working tree's changes, but also
@@ -181,15 +181,15 @@ the index's ones. However, this can fail, when you have conflicts
 (which are stored in the index, where you therefore can no longer
 apply the changes as they were originally).
 
--k::
---keep-index::
---no-keep-index::
+`-k`::
+`--keep-index`::
+`--no-keep-index`::
 	This option is only valid for `push` and `save` commands.
 +
 All changes already added to the index are left intact.
 
--p::
---patch::
+`-p`::
+`--patch`::
 	This option is only valid for `push` and `save` commands.
 +
 Interactively select hunks from the diff between `HEAD` and the
@@ -203,7 +203,7 @@ to learn how to operate the `--patch` mode.
 The `--patch` option implies `--keep-index`.  You can use
 `--no-keep-index` to override this.
 
---pathspec-from-file=<file>::
+`--pathspec-from-file=<file>`::
 	This option is only valid for `push` command.
 +
 Pathspec is passed in `<file>` instead of commandline args. If
@@ -213,15 +213,15 @@ quoted as explained for the configuration variable `core.quotePath`
 (see linkgit:git-config[1]). See also `--pathspec-file-nul` and
 global `--literal-pathspecs`.
 
---pathspec-file-nul::
+`--pathspec-file-nul`::
 	This option is only valid for `push` command.
 +
 Only meaningful with `--pathspec-from-file`. Pathspec elements are
 separated with NUL character and all other characters are taken
 literally (including newlines and quotes).
 
--q::
---quiet::
+`-q`::
+`--quiet`::
 	This option is only valid for `apply`, `drop`, `pop`, `push`,
 	`save`, `store` commands.
 +
@@ -242,7 +242,7 @@ too, leaving files that do not match the pathspec intact.
 +
 For more details, see the 'pathspec' entry in linkgit:gitglossary[7].
 
-<stash>::
+`<stash>`::
 	This option is only valid for `apply`, `branch`, `drop`, `pop`,
 	`show` commands.
 +
diff --git a/Documentation/git-status.txt b/Documentation/git-status.txt
index 2abb6d69f5..bb8f0f4bdd 100644
--- a/Documentation/git-status.txt
+++ b/Documentation/git-status.txt
@@ -24,18 +24,18 @@ third are what you _could_ commit by running `git add` before running
 OPTIONS
 -------
 
--s::
---short::
+`-s`::
+`--short`::
 	Give the output in the short-format.
 
--b::
---branch::
+`-b`::
+`--branch`::
 	Show the branch and tracking info even in short-format.
 
---show-stash::
+`--show-stash`::
 	Show the number of entries currently stashed away.
 
---porcelain[=<version>]::
+`--porcelain[=<version>]`::
 	Give the output in an easy-to-parse format for scripts.
 	This is similar to the short output, but will remain stable
 	across Git versions and regardless of user configuration. See
@@ -44,19 +44,19 @@ OPTIONS
 The version parameter is used to specify the format version.
 This is optional and defaults to the original version 'v1' format.
 
---long::
+`--long`::
 	Give the output in the long-format. This is the default.
 
--v::
---verbose::
+`-v`::
+`--verbose`::
 	In addition to the names of files that have been changed, also
 	show the textual changes that are staged to be committed
 	(i.e., like the output of `git diff --cached`). If `-v` is specified
 	twice, then also show the changes in the working tree that
 	have not yet been staged (i.e., like the output of `git diff`).
 
--u[<mode>]::
---untracked-files[=<mode>]::
+`-u[<mode>]`::
+`--untracked-files[=<mode>]`::
 	Show untracked files.
 +
 --
@@ -84,7 +84,7 @@ The default can be changed using the `status.showUntrackedFiles`
 configuration variable documented in linkgit:git-config[1].
 --
 
---ignore-submodules[=<when>]::
+`--ignore-submodules[=<when>]`::
 	Ignore changes to submodules when looking for changes. <when> can be
 	either "none", "untracked", "dirty" or "all", which is the default.
 	Using "none" will consider the submodule modified when it either contains
@@ -99,7 +99,7 @@ configuration variable documented in linkgit:git-config[1].
 	(and suppresses the output of submodule summaries when the config option
 	`status.submoduleSummary` is set).
 
---ignored[=<mode>]::
+`--ignored[=<mode>]`::
 	Show ignored files as well.
 +
 --
@@ -123,28 +123,28 @@ a directory does not match an ignore pattern, but all contents are
 ignored, then the directory is not shown, but all contents are shown.
 --
 
--z::
+`-z`::
 	Terminate entries with NUL, instead of LF.  This implies
 	the `--porcelain=v1` output format if no other format is given.
 
---column[=<options>]::
---no-column::
+`--column[=<options>]`::
+`--no-column`::
 	Display untracked files in columns. See configuration variable
 	`column.status` for option syntax. `--column` and `--no-column`
 	without options are equivalent to 'always' and 'never'
 	respectively.
 
---ahead-behind::
---no-ahead-behind::
+`--ahead-behind`::
+`--no-ahead-behind`::
 	Display or do not display detailed ahead/behind counts for the
 	branch relative to its upstream branch.  Defaults to true.
 
---renames::
---no-renames::
+`--renames`::
+`--no-renames`::
 	Turn on/off rename detection regardless of user configuration.
 	See also linkgit:git-diff[1] `--no-renames`.
 
---find-renames[=<n>]::
+`--find-renames[=<n>]`::
 	Turn on rename detection, optionally setting the similarity
 	threshold.
 	See also linkgit:git-diff[1] `--find-renames`.
diff --git a/Documentation/git-stripspace.txt b/Documentation/git-stripspace.txt
index 6397de9cb3..bed4f35d0b 100644
--- a/Documentation/git-stripspace.txt
+++ b/Documentation/git-stripspace.txt
@@ -35,12 +35,12 @@ the repository.
 
 OPTIONS
 -------
--s::
---strip-comments::
+`-s`::
+`--strip-comments`::
 	Skip and remove all lines starting with comment character (default '#').
 
--c::
---comment-lines::
+`-c`::
+`--comment-lines`::
 	Prepend comment character and blank to each line. Lines will automatically
 	be terminated with a newline. On empty lines, only the comment character
 	will be prepended.
diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
index 6cbf6a9ba1..95868792c9 100644
--- a/Documentation/git-submodule.txt
+++ b/Documentation/git-submodule.txt
@@ -146,7 +146,7 @@ the configuration variable. If neither is given, a 'checkout' is performed.
 The 'update' procedures supported both from the command line as well as
 through the `submodule.<name>.update` configuration are:
 
-	checkout;; the commit recorded in the superproject will be
+	`checkout`;; the commit recorded in the superproject will be
 	    checked out in the submodule on a detached `HEAD`.
 +
 If `--force` is specified, the submodule will be checked out (using
@@ -154,10 +154,10 @@ If `--force` is specified, the submodule will be checked out (using
 in the index of the containing repository already matches the commit
 checked out in the submodule.
 
-	rebase;; the current branch of the submodule will be rebased
+	`rebase`;; the current branch of the submodule will be rebased
 	    onto the commit recorded in the superproject.
 
-	merge;; the commit recorded in the superproject will be merged
+	`merge`;; the commit recorded in the superproject will be merged
 	    into the current branch in the submodule.
 
 The following 'update' procedures are only available via the
@@ -169,7 +169,7 @@ The following 'update' procedures are only available via the
 	    is set to '!command', the remainder after the exclamation mark
 	    is the custom command.
 
-	none;; the submodule is not updated.
+	`none`;; the submodule is not updated.
 
 If the submodule is not yet initialized, and you just want to use the
 setting as stored in `.gitmodules`, you can automatically initialize the
@@ -246,7 +246,7 @@ sync [--recursive] [--] [<path>...]::
 If `--recursive` is specified, this command will recurse into the
 registered submodules, and sync any nested submodules within.
 
-absorbgitdirs::
+`absorbgitdirs`::
 	If a `git` directory of a submodule is inside the submodule,
 	move the `git` directory of the submodule into its superproject's
 	`$GIT_DIR/modules` path and then connect the `git` directory and
@@ -262,18 +262,18 @@ This command is recursive by default.
 
 OPTIONS
 -------
--q::
---quiet::
+`-q`::
+`--quiet`::
 	Only print error messages.
 
---progress::
+`--progress`::
 	This option is only valid for add and update commands.
 	Progress status is reported on the standard error stream
 	by default when it is attached to a terminal, unless -q
 	is specified. This flag forces progress status even if the
 	standard error stream is not directed to a terminal.
 
---all::
+`--all`::
 	This option is only valid for the deinit command. Unregister all
 	submodules in the working tree.
 
@@ -286,8 +286,8 @@ OPTIONS
 	same name as the current branch in the current repository.  If the
 	option is not specified, it defaults to the remote `HEAD`.
 
--f::
---force::
+`-f`::
+`--force`::
 	This option is only valid for add, deinit and update commands.
 	When running add, allow adding an otherwise ignored submodule path.
 	When running deinit the submodule working trees will be removed even
@@ -299,25 +299,25 @@ OPTIONS
 	containing repository matches the commit checked out in the
 	submodule.
 
---cached::
+`--cached`::
 	This option is only valid for status and summary commands.  These
 	commands typically use the commit found in the submodule `HEAD`, but
 	with this option, the commit stored in the index is used instead.
 
---files::
+`--files`::
 	This option is only valid for the summary command. This command
 	compares the commit in the index with that in the submodule `HEAD`
 	when this option is used.
 
--n::
---summary-limit::
+`-n`::
+`--summary-limit`::
 	This option is only valid for the summary command.
 	Limit the summary size (number of commits shown in total).
 	Giving 0 will disable the summary; a negative number means unlimited
 	(the default). This limit only applies to modified submodules. The
 	size is always limited to 1 for added/deleted/typechanged submodules.
 
---remote::
+`--remote`::
 	This option is only valid for the update command.  Instead of using
 	the superproject's recorded SHA-1 to update the submodule, use the
 	status of the submodule's remote-tracking branch.  The remote used
@@ -348,12 +348,12 @@ to distribute the default upstream branch with the superproject and
 `branch.<name>.merge` if you want a more native feel while working in
 the submodule itself.
 
--N::
---no-fetch::
+`-N`::
+`--no-fetch`::
 	This option is only valid for the update command.
 	Don't fetch new objects from the remote site.
 
---checkout::
+`--checkout`::
 	This option is only valid for the update command.
 	Checkout the commit recorded in the superproject on a detached `HEAD`
 	in the submodule. This is the default behavior, the main use of
@@ -362,7 +362,7 @@ the submodule itself.
 	If the key `submodule.$name.update` is either not explicitly set or
 	set to `checkout`, this option is implicit.
 
---merge::
+`--merge`::
 	This option is only valid for the update command.
 	Merge the commit recorded in the superproject into the current branch
 	of the submodule. If this option is given, the submodule's `HEAD` will
@@ -372,7 +372,7 @@ the submodule itself.
 	If the key `submodule.$name.update` is set to `merge`, this option is
 	implicit.
 
---rebase::
+`--rebase`::
 	This option is only valid for the update command.
 	Rebase the current branch onto the commit recorded in the
 	superproject. If this option is given, the submodule's `HEAD` will not
@@ -381,12 +381,12 @@ the submodule itself.
 	If the key `submodule.$name.update` is set to `rebase`, this option is
 	implicit.
 
---init::
+`--init`::
 	This option is only valid for the update command.
 	Initialize all submodules for which `git submodule init` has not been
 	called so far before updating.
 
---name::
+`--name`::
 	This option is only valid for the add command. It sets the submodule's
 	name to the given string instead of defaulting to its path. The name
 	must be valid as a directory name and may not end with a '/'.
@@ -400,25 +400,25 @@ the submodule itself.
 for linkgit:git-clone[1]'s `--reference`, `--shared`, and `--dissociate`
 options carefully.
 
---dissociate::
+`--dissociate`::
 	This option is only valid for add and update commands.  These
 	commands sometimes need to clone a remote repository. In this case,
 	this option will be passed to the linkgit:git-clone[1] command.
 +
 *NOTE*: see the NOTE for the `--reference` option.
 
---recursive::
+`--recursive`::
 	This option is only valid for foreach, update, status and sync commands.
 	Traverse submodules recursively. The operation is performed not
 	only in the submodules of the current repo, but also
 	in any nested submodules inside those submodules (and so on).
 
---depth::
+`--depth`::
 	This option is valid for add and update commands. Create a 'shallow'
 	clone with a history truncated to the specified number of revisions.
 	See linkgit:git-clone[1]
 
---[no-]recommend-shallow::
+`--[no-]recommend-shallow`::
 	This option is only valid for the update command.
 	The initial clone of a submodule will use the recommended
 	`submodule.<name>.shallow` as provided by the `.gitmodules` file
@@ -430,7 +430,7 @@ options carefully.
 	Clone new submodules in parallel with as many jobs.
 	Defaults to the `submodule.fetchJobs` option.
 
---[no-]single-branch::
+`--[no-]single-branch`::
 	This option is only valid for the update command.
 	Clone only one branch during update: `HEAD` or one specified by `--branch`.
 
diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
index 727ea0603c..6fca35c8cb 100644
--- a/Documentation/git-svn.txt
+++ b/Documentation/git-svn.txt
@@ -43,8 +43,8 @@ COMMANDS
 --tags=<tags_subdir>;;
 -b<branches_subdir>;;
 --branches=<branches_subdir>;;
--s;;
---stdlayout;;
+`-s`;;
+`--stdlayout`;;
 	These are optional command-line options for `init`.  Each of
 	these flags can point to a relative repository path
 	(`--tags=project/tags`) or a full url
@@ -55,24 +55,24 @@ COMMANDS
 	a shorthand way of setting trunk,tags,branches as the relative paths,
 	which is the Subversion default. If any of the other options are given
 	as well, they take precedence.
---no-metadata;;
+`--no-metadata`;;
 	Set the 'noMetadata' option in the [svn-remote] config.
 	This option is not recommended, please read the `svn.noMetadata`
 	section of this manpage before using this option.
---use-svm-props;;
+`--use-svm-props`;;
 	Set the 'useSvmProps' option in the [svn-remote] config.
---use-svnsync-props;;
+`--use-svnsync-props`;;
 	Set the 'useSvnsyncProps' option in the [svn-remote] config.
---rewrite-root=<URL>;;
+`--rewrite-root=<URL>`;;
 	Set the 'rewriteRoot' option in the [svn-remote] config.
---rewrite-uuid=<UUID>;;
+`--rewrite-uuid=<UUID>`;;
 	Set the 'rewriteUUID' option in the [svn-remote] config.
---username=<user>;;
+`--username=<user>`;;
 	For transports that SVN handles authentication for (http,
 	https, and plain svn), specify the username.  For other
 	transports (e.g. `svn+ssh://`), you must include the username in
 	the URL, e.g. `svn+ssh://foo@svn.bar.com/project`
---prefix=<prefix>;;
+`--prefix=<prefix>`;;
 	This allows one to specify a prefix which is prepended
 	to the names of remotes if trunk/branches/tags are
 	specified.  The prefix does not automatically include a
@@ -95,19 +95,19 @@ If you still want the old default, you can get it by passing
 `--prefix ""` on the command line (`--prefix=""` may not work if
 your Perl's Getopt::Long is < v2.37).
 
---ignore-refs=<regex>;;
+`--ignore-refs=<regex>`;;
 	When passed to `init` or `clone` this regular expression will
 	be preserved as a config key.  See `fetch` for a description
 	of `--ignore-refs`.
---ignore-paths=<regex>;;
+`--ignore-paths=<regex>`;;
 	When passed to `init` or `clone` this regular expression will
 	be preserved as a config key.  See `fetch` for a description
 	of `--ignore-paths`.
---include-paths=<regex>;;
+`--include-paths=<regex>`;;
 	When passed to `init` or `clone` this regular expression will
 	be preserved as a config key.  See `fetch` for a description
 	of `--include-paths`.
---no-minimize-url;;
+`--no-minimize-url`;;
 	When tracking multiple directories (using `--stdlayout`,
 	`--branches`, or `--tags` options), `git svn` will attempt to connect
 	to the root (or highest allowed level) of the Subversion
@@ -128,7 +128,7 @@ your Perl's Getopt::Long is < v2.37).
 This automatically updates the rev_map if needed (see
 `$GIT_DIR/svn/\**/.rev_map.*` in the FILES section below for details).
 
---localtime;;
+`--localtime`;;
 	Store Git commit times in the local time zone instead of UTC.  This
 	makes `git log` (even without `--date=local`) show the same times
 	that `svn log` would in the local time zone.
@@ -139,10 +139,10 @@ repository to be able to interoperate with someone else's local Git
 repository, either don't use this option or you should both use it in
 the same local time zone.
 
---parent;;
+`--parent`;;
 	Fetch only from the SVN parent of the current `HEAD`.
 
---ignore-refs=<regex>;;
+`--ignore-refs=<regex>`;;
 	Ignore refs for branches or tags matching the Perl regular
 	expression. A negative look-ahead assertion like
 	`^refs/remotes/origin/(?!tags/wanted-tag|wanted-branch).*$`
@@ -154,7 +154,7 @@ config key: `svn-remote.<name>.ignore-refs`
 If the ignore-refs configuration key is set, and the command-line
 option is also given, both regular expressions will be used.
 
---ignore-paths=<regex>;;
+`--ignore-paths=<regex>`;;
 	This allows one to specify a Perl regular expression that will
 	cause skipping of all matching paths from checkout from SVN.
 	The `--ignore-paths` option should match for every `fetch`
@@ -183,7 +183,7 @@ Skip "branches" and "tags" of first level directories;;
 ------------------------------------------------------------------------
 --
 
---include-paths=<regex>;;
+`--include-paths=<regex>`;;
 	This allows one to specify a Perl regular expression that will
 	cause the inclusion of only matching paths from checkout from SVN.
 	The `--include-paths` option should match for every `fetch`
@@ -194,7 +194,7 @@ Skip "branches" and "tags" of first level directories;;
 [verse]
 config key: `svn-remote.<name>.include-paths`
 
---log-window-size=<n>;;
+`--log-window-size=<n>`;;
 	Fetch <n> log entries per request when scanning Subversion history.
 	The default is 100. For very large Subversion repositories, larger
 	values may be needed for `clone`/'fetch' to complete in reasonable
@@ -212,14 +212,14 @@ config key: `svn-remote.<name>.include-paths`
 	affecting the working tree; and the `rebase` command will be
 	able to update the working tree with the latest changes.
 
---preserve-empty-dirs;;
+`--preserve-empty-dirs`;;
 	Create a placeholder file in the local Git repository for each
 	empty directory fetched from Subversion.  This includes directories
 	that become empty by removing all entries in the Subversion
 	repository (but not the directory itself).  The placeholder files
 	are also tracked and removed when no longer necessary.
 
---placeholder-filename=<filename>;;
+`--placeholder-filename=<filename>`;;
 	Set the name of placeholder files created by `--preserve-empty-dirs`.
 	Default: "`.gitignore`"
 
@@ -241,8 +241,8 @@ and have no uncommitted changes.
 This automatically updates the rev_map if needed (see
 `$GIT_DIR/svn/\**/.rev_map.*` in the FILES section below for details).
 
--l;;
---local;;
+`-l`;;
+`--local`;;
 	Do not `fetch` remotely; only run `git rebase` against the
 	last fetched commit from the upstream SVN.
 
@@ -258,7 +258,7 @@ branch, not on the current branch.
 +
 Use of `dcommit` is preferred to `set-tree` (below).
 +
---no-rebase;;
+`--no-rebase`;;
 	After committing, do not rebase or reset.
 --commit-url <URL>;;
 	Commit to this SVN URL (the full path).  This is intended to
@@ -278,7 +278,7 @@ If you rather want to set the commit URL for an entire SVN repository use
 Using this option for any other purpose (don't ask) is very strongly
 discouraged.
 
---mergeinfo=<mergeinfo>;;
+`--mergeinfo=<mergeinfo>`;;
 	Add the given merge information during the `dcommit`
 	(e.g. `--mergeinfo="/branches/foo:1-10"`). All svn server versions can
 	store this information (as a property), and svn clients starting from
@@ -294,7 +294,7 @@ svn:mergeinfo property in the SVN repository when possible. Currently, this can
 only be done when dcommitting non-fast-forward merges where all parents but the
 first have already been pushed into SVN.
 
---interactive;;
+`--interactive`;;
 	Ask the user to confirm that a patch set should actually be sent to SVN.
 	For each patch, one may answer "yes" (accept this patch), "no" (discard this
 	patch), "all" (accept all patches), or "quit".
@@ -305,17 +305,17 @@ committing anything to SVN.
 `branch`::
 	Create a branch in the SVN repository.
 
--m;;
---message;;
+`-m`;;
+`--message`;;
 	Allows to specify the commit message.
 
--t;;
---tag;;
+`-t`;;
+`--tag`;;
 	Create a tag by using the tags_subdir instead of the branches_subdir
 	specified during `git svn` init.
 
--d<path>;;
---destination=<path>;;
+`-d<path>`;;
+`--destination=<path>`;;
 
 	If more than one `--branches` (or `--tags`) option was given to the `init`
 	or `clone` command, you must provide the location of the branch (or
@@ -330,11 +330,11 @@ committing anything to SVN.
 where <name> is the name of the SVN repository as specified by the `-R` option to
 `init` (or "svn" by default).
 
---username;;
+`--username`;;
 	Specify the SVN username to perform the commit as.  This option overrides
 	the 'username' configuration property.
 
---commit-url;;
+`--commit-url`;;
 	Use the specified URL to connect to the destination Subversion
 	repository.  This is useful in cases where the source SVN
 	repository is read-only.  This option overrides configuration
@@ -343,7 +343,7 @@ where <name> is the name of the SVN repository as specified by the `-R` option t
 	git config --get-all svn-remote.<name>.commiturl
 +
 
---parents;;
+`--parents`;;
 	Create parent folders. This parameter is equivalent to the parameter
 	`--parents` on svn cp commands and is useful for non-standard repository
 	layouts.
@@ -363,23 +363,23 @@ The following features from `svn log' are supported:
 --revision=<n>[:<n>];;
 	is supported, non-numeric args are not:
 	HEAD, NEXT, BASE, PREV, etc ...
--v;;
---verbose;;
+`-v`;;
+`--verbose`;;
 	it's not completely compatible with the `--verbose`
 	output in svn log, but reasonably close.
---limit=<n>;;
+`--limit=<n>`;;
 	is NOT the same as `--max-count`, doesn't count
 	merged/excluded commits
---incremental;;
+`--incremental`;;
 	supported
 --
 +
 New features:
 +
 --
---show-commit;;
+`--show-commit`;;
 	shows the Git commit sha1, as well
---oneline;;
+`--oneline`;;
 	our version of `--pretty=oneline`
 --
 +
@@ -397,26 +397,26 @@ Any other arguments are passed directly to `git log`
 	the version of the file in the `HEAD` revision is annotated. Unknown
 	arguments are passed directly to `git blame`.
 +
---git-format;;
+`--git-format`;;
 	Produce output in the same format as `git blame`, but with
 	SVN revision numbers instead of Git commit hashes. In this mode,
 	changes that haven't been committed to SVN (including local
 	working-copy edits) are shown as revision 0.
 
-'find-rev'::
+`find-rev`::
 	When given an SVN revision number of the form 'rN', returns the
 	corresponding Git commit hash (this can optionally be followed by a
 	tree-ish to specify which branch should be searched).  When given a
 	tree-ish, returns the corresponding SVN revision number.
 +
--B;;
---before;;
+`-B`;;
+`--before`;;
 	Don't require an exact match if given an SVN revision, instead find
 	the commit corresponding to the state of the SVN repository (on the
 	current branch) at the specified revision.
 +
--A;;
---after;;
+`-A`;;
+`--after`;;
 	Don't require an exact match if given an SVN revision; if there is
 	not an exact match return the closest match searching forward in the
 	history.
@@ -466,12 +466,12 @@ denotes such an object, or it is requested by invoking an editor (see
 `--edit` option below).
 
 -m <msg>;;
---message=<msg>;;
+`--message=<msg>`;;
 	Use the given `msg` as the commit message. This option
 	disables the `--edit` option.
 
 -F <filename>;;
---file=<filename>;;
+`--file=<filename>`;;
 	Take the commit message from the given file. This option
 	disables the `--edit` option.
 
@@ -529,11 +529,11 @@ Follow 'reset' with a `fetch` and then `git reset` or `git rebase` to
 move local branches onto the new tree.
 
 -r <n>;;
---revision=<n>;;
+`--revision=<n>`;;
 	Specify the most recent revision to keep.  All later revisions
 	are discarded.
--p;;
---parent;;
+`-p`;;
+`--parent`;;
 	Discard the specified revision as well, keeping the nearest
 	parent instead.
 Example:;;
@@ -591,15 +591,15 @@ This can allow you to make partial mirrors when running `fetch`;
 but is generally not recommended because history will be skipped
 and lost.
 
--::
---stdin::
+`-`::
+`--stdin`::
 	Only used with the `set-tree` command.
 +
 Read a list of commits from stdin and commit them in reverse
 order.  Only the leading sha1 is read from each line, so
 `git rev-list --pretty=oneline` output can be used.
 
---rmdir::
+`--rmdir`::
 	Only used with the `dcommit`, `set-tree` and `commit-diff` commands.
 +
 Remove directories from the SVN tree if there are no files left
@@ -611,8 +611,8 @@ the commit to SVN act like Git.
 [verse]
 config key: `svn.rmdir`
 
--e::
---edit::
+`-e`::
+`--edit`::
 	Only used with the `dcommit`, `set-tree` and `commit-diff` commands.
 +
 Edit the commit message before committing to SVN.  This is off by
@@ -622,8 +622,8 @@ tree objects.
 [verse]
 config key: `svn.edit`
 
--l<num>::
---find-copies-harder::
+`-l<num>`::
+`--find-copies-harder`::
 	Only used with the `dcommit`, `set-tree` and `commit-diff` commands.
 +
 They are both passed directly to `git diff-tree`; see
@@ -633,8 +633,8 @@ linkgit:git-diff-tree[1] for more information.
 config key: `svn.l`
 config key: `svn.findcopiesharder`
 
--A<filename>::
---authors-file=<filename>::
+`-A<filename>`::
+`--authors-file=<filename>`::
 	Syntax is compatible with the file used by `git cvsimport` but
 	an empty email address can be supplied with '<>':
 +
@@ -651,7 +651,7 @@ after the authors-file is modified should continue operation.
 [verse]
 config key: `svn.authorsfile`
 
---authors-prog=<filename>::
+`--authors-prog=<filename>`::
 	If this option is specified, for each SVN committer name that
 	does not exist in the authors file, the given file is executed
 	with the committer name as the first argument.  The program is
@@ -667,25 +667,25 @@ not found, it is searched like any other command in `$PATH`.
 [verse]
 config key: `svn.authorsProg`
 
--q::
---quiet::
+`-q`::
+`--quiet`::
 	Make `git svn` less verbose. Specify a second time to make it
 	even less verbose.
 
--m::
---merge::
--s<strategy>::
---strategy=<strategy>::
--p::
---rebase-merges::
+`-m`::
+`--merge`::
+`-s<strategy>`::
+`--strategy=<strategy>`::
+`-p`::
+`--rebase-merges`::
 --preserve-merges (DEPRECATED)::
 	These are only used with the `dcommit` and `rebase` commands.
 +
 Passed directly to `git rebase` when using `dcommit` if a
 `git reset` cannot be used (see `dcommit`).
 
--n::
---dry-run::
+`-n`::
+`--dry-run`::
 	This can be used with the `dcommit`, `rebase`, `branch` and
 	`tag` commands.
 +
@@ -699,7 +699,7 @@ repository that will be fetched from.
 For `branch` and `tag`, display the urls that will be used for copying when
 creating the branch or tag.
 
---use-log-author::
+`--use-log-author`::
 	When retrieving svn commits into Git (as part of `fetch`, `rebase`, or
 	`dcommit` operations), look for the first `From:` line or `Signed-off-by` trailer
 	in the log message and use that as the author string.
@@ -707,7 +707,7 @@ creating the branch or tag.
 [verse]
 config key: `svn.useLogAuthor`
 
---add-author-from::
+`--add-author-from`::
 	When committing to svn from Git (as part of `set-tree` or `dcommit`
 	operations), if the existing log message doesn't already have a
 	`From:` or `Signed-off-by` trailer, append a `From:` line based on the
@@ -733,7 +733,7 @@ ADVANCED OPTIONS
 	this allows SVN multiple repositories to be tracked.
 	Default: "svn"
 
---follow-parent::
+`--follow-parent`::
 	This option is only relevant if we are tracking branches (using
 	one of the repository layout options `--trunk`, `--tags`,
 	`--branches`, `--stdlayout`). For each tracked branch, try to find
diff --git a/Documentation/git-switch.txt b/Documentation/git-switch.txt
index da16df9efa..44ae45e838 100644
--- a/Documentation/git-switch.txt
+++ b/Documentation/git-switch.txt
@@ -33,13 +33,13 @@ THIS COMMAND IS EXPERIMENTAL. THE BEHAVIOR MAY CHANGE.
 
 OPTIONS
 -------
-<branch>::
+`<branch>`::
 	Branch to switch to.
 
-<new-branch>::
+`<new-branch>`::
 	Name for the new branch.
 
-<start-point>::
+`<start-point>`::
 	The starting point for the new branch. Specifying a
 	`<start-point>` allows you to create a branch based on some
 	other point in history than where `HEAD` currently points. (Or,
@@ -78,14 +78,14 @@ $ git branch -f <new-branch>
 $ git switch <new-branch>
 ------------
 
--d::
---detach::
+`-d`::
+`--detach`::
 	Switch to a commit for inspection and discardable
 	experiments. See the "DETACHED HEAD" section in
 	linkgit:git-checkout[1] for details.
 
---guess::
---no-guess::
+`--guess`::
+`--no-guess`::
 	If `<branch>` is not found but there does exist a tracking
 	branch in exactly one remote (call it `<remote>`) with a
 	matching name, treat as equivalent to
@@ -107,19 +107,19 @@ ambiguous but exists on the `origin` remote. See also
 The default behavior can be set via the `checkout.guess` configuration
 variable.
 
--f::
---force::
+`-f`::
+`--force`::
 	An alias for `--discard-changes`.
 
---discard-changes::
+`--discard-changes`::
 	Proceed even if the index or the working tree differs from
 	`HEAD`. Both the index and working tree are restored to match
 	the switching target. If `--recurse-submodules` is specified,
 	submodule content is also restored to match the switching
 	target. This is used to throw away local changes.
 
--m::
---merge::
+`-m`::
+`--merge`::
 	If you have local modifications to one or more files that are
 	different between the current branch and the branch to which
 	you are switching, the command refuses to switch branches in
@@ -133,26 +133,26 @@ paths are left unmerged, and you need to resolve the conflicts
 and mark the resolved paths with `git add` (or `git rm` if the merge
 should result in deletion of the path).
 
---conflict=<style>::
+`--conflict=<style>`::
 	The same as `--merge` option above, but changes the way the
 	conflicting hunks are presented, overriding the
 	`merge.conflictStyle` configuration variable.  Possible values are
 	"merge" (default) and "diff3" (in addition to what is shown by
 	"merge" style, shows the original contents).
 
--q::
---quiet::
+`-q`::
+`--quiet`::
 	Quiet, suppress feedback messages.
 
---progress::
---no-progress::
+`--progress`::
+`--no-progress`::
 	Progress status is reported on the standard error stream
 	by default when it is attached to a terminal, unless `--quiet`
 	is specified. This flag enables progress reporting even if not
 	attached to a terminal, regardless of `--quiet`.
 
--t::
---track::
+`-t`::
+`--track`::
 	When creating a new branch, set up "upstream" configuration.
 	`-c` is implied. See `--track` in linkgit:git-branch[1] for
 	details.
@@ -167,7 +167,7 @@ given name has no slash, or the above guessing results in an empty
 name, the guessing is aborted.  You can explicitly give a name with
 `-c` in such a case.
 
---no-track::
+`--no-track`::
 	Do not set up "upstream" configuration, even if the
 	`branch.autoSetupMerge` configuration variable is true.
 
@@ -175,14 +175,14 @@ name, the guessing is aborted.  You can explicitly give a name with
 	Create a new 'orphan' branch, named `<new-branch>`. All
 	tracked files are removed.
 
---ignore-other-worktrees::
+`--ignore-other-worktrees`::
 	`git switch` refuses when the wanted ref is already
 	checked out by another worktree. This option makes it check
 	the ref out anyway. In other words, the ref can be held by
 	more than one worktree.
 
---recurse-submodules::
---no-recurse-submodules::
+`--recurse-submodules`::
+`--no-recurse-submodules`::
 	Using `--recurse-submodules` will update the content of all
 	active submodules according to the commit recorded in the
 	superproject. If nothing (or `--no-recurse-submodules`) is
diff --git a/Documentation/git-symbolic-ref.txt b/Documentation/git-symbolic-ref.txt
index 0c19b1e70e..9fa1564a56 100644
--- a/Documentation/git-symbolic-ref.txt
+++ b/Documentation/git-symbolic-ref.txt
@@ -32,21 +32,21 @@ a regular file whose contents is `ref: refs/heads/master`.
 OPTIONS
 -------
 
--d::
---delete::
+`-d`::
+`--delete`::
 	Delete the symbolic ref <name>.
 
--q::
---quiet::
+`-q`::
+`--quiet`::
 	Do not issue an error message if the <name> is not a
 	symbolic ref but a detached `HEAD`; instead exit with
 	non-zero status silently.
 
---short::
+`--short`::
 	When showing the value of <name> as a symbolic ref, try to shorten the
 	value, e.g. from `refs/heads/master` to `master`.
 
--m::
+`-m`::
 	Update the reflog for <name> with <reason>.  This is valid only
 	when creating or updating a symbolic ref.
 
diff --git a/Documentation/git-tag.txt b/Documentation/git-tag.txt
index 6de16cec54..6f125deee3 100644
--- a/Documentation/git-tag.txt
+++ b/Documentation/git-tag.txt
@@ -57,38 +57,38 @@ lightweight tags by default.
 
 OPTIONS
 -------
--a::
---annotate::
+`-a`::
+`--annotate`::
 	Make an unsigned, annotated tag object
 
--s::
---sign::
+`-s`::
+`--sign`::
 	Make a GPG-signed tag, using the default e-mail address's key.
 	The default behavior of tag GPG-signing is controlled by `tag.gpgSign`
 	configuration variable if it exists, or disabled otherwise.
 	See linkgit:git-config[1].
 
---no-sign::
+`--no-sign`::
 	Override `tag.gpgSign` configuration variable that is
 	set to force each and every tag to be signed.
 
 -u <keyid>::
---local-user=<keyid>::
+`--local-user=<keyid>`::
 	Make a GPG-signed tag, using the given key.
 
--f::
---force::
+`-f`::
+`--force`::
 	Replace an existing tag with the given name (instead of failing)
 
--d::
---delete::
+`-d`::
+`--delete`::
 	Delete existing tags with the given names.
 
--v::
---verify::
+`-v`::
+`--verify`::
 	Verify the GPG signature of the given tag names.
 
--n<num>::
+`-n<num>`::
 	<num> specifies how many lines from the annotation, if any,
 	are printed when using -l. Implies `--list`.
 +
@@ -96,8 +96,8 @@ The default is not to print any annotation lines.
 If no number is given to `-n`, only the first line is printed.
 If the tag is not annotated, the commit message is displayed instead.
 
--l::
---list::
+`-l`::
+`--list`::
 	List tags. With optional `<pattern>...`, e.g. `git tag --list
 	'v-*'`, list only the tags that match the pattern(s).
 +
@@ -109,7 +109,7 @@ This option is implicitly supplied if any other list-like option such
 as `--contains` is provided. See the documentation for each of those
 options for details.
 
---sort=<key>::
+`--sort=<key>`::
 	Sort based on the key given.  Prefix `-` to sort in
 	descending order of the value. You may use the `--sort=<key>` option
 	multiple times, in which case the last key becomes the primary
@@ -122,17 +122,17 @@ options for details.
 	variable if it exists, or lexicographic order otherwise. See
 	linkgit:git-config[1].
 
---color[=<when>]::
+`--color[=<when>]`::
 	Respect any colors specified in the `--format` option. The
 	`<when>` field must be one of `always`, `never`, or `auto` (if
 	`<when>` is absent, behave as if `always` was given).
 
--i::
---ignore-case::
+`-i`::
+`--ignore-case`::
 	Sorting and filtering tags are case insensitive.
 
---column[=<options>]::
---no-column::
+`--column[=<options>]`::
+`--no-column`::
 	Display tag listing in columns. See configuration variable
 	`column.tag` for option syntax. `--column` and `--no-column`
 	without options are equivalent to 'always' and 'never' respectively.
@@ -160,7 +160,7 @@ This option is only applicable when listing tags without annotation lines.
 	specified). Implies `--list`.
 
 -m <msg>::
---message=<msg>::
+`--message=<msg>`::
 	Use the given tag message (instead of prompting).
 	If multiple `-m` options are given, their values are
 	concatenated as separate paragraphs.
@@ -168,46 +168,46 @@ This option is only applicable when listing tags without annotation lines.
 	is given.
 
 -F <file>::
---file=<file>::
+`--file=<file>`::
 	Take the tag message from the given file.  Use '-' to
 	read the message from the standard input.
 	Implies `-a` if none of `-a`, `-s`, or `-u <keyid>`
 	is given.
 
--e::
---edit::
+`-e`::
+`--edit`::
 	The message taken from file with `-F` and command line with
 	`-m` are usually used as the tag message unmodified.
 	This option lets you further edit the message taken from these sources.
 
---cleanup=<mode>::
+`--cleanup=<mode>`::
 	This option sets how the tag message is cleaned up.
 	The  '<mode>' can be one of 'verbatim', 'whitespace' and 'strip'.  The
 	'strip' mode is default. The 'verbatim' mode does not change message at
 	all, 'whitespace' removes just leading/trailing whitespace lines and
 	'strip' removes both whitespace and commentary.
 
---create-reflog::
+`--create-reflog`::
 	Create a reflog for the tag. To globally enable reflogs for tags, see
 	`core.logAllRefUpdates` in linkgit:git-config[1].
 	The negated form `--no-create-reflog` only overrides an earlier
 	`--create-reflog`, but currently does not negate the setting of
 	`core.logAllRefUpdates`.
 
---format=<format>::
+`--format=<format>`::
 	A string that interpolates `%(fieldname)` from a tag ref being shown
 	and the object it points at.  The format is the same as
 	that of linkgit:git-for-each-ref[1].  When unspecified,
 	defaults to `%(refname:strip=2)`.
 
-<tagname>::
+`<tagname>`::
 	The name of the tag to create, delete, or describe.
 	The new tag name must pass all checks defined by
 	linkgit:git-check-ref-format[1].  Some of these checks
 	may restrict the characters allowed in a tag name.
 
-<commit>::
-<object>::
+`<commit>`::
+`<object>`::
 	The object that the new tag will refer to, usually a commit.
 	Defaults to `HEAD`.
 
diff --git a/Documentation/git-unpack-objects.txt b/Documentation/git-unpack-objects.txt
index ad10299337..cb989b6aac 100644
--- a/Documentation/git-unpack-objects.txt
+++ b/Documentation/git-unpack-objects.txt
@@ -27,24 +27,24 @@ new packs and replace existing ones.
 
 OPTIONS
 -------
--n::
+`-n`::
         Dry run.  Check the pack file without actually unpacking
 	the objects.
 
--q::
+`-q`::
 	The command usually shows percentage progress.  This
 	flag suppresses it.
 
--r::
+`-r`::
 	When unpacking a corrupt packfile, the command dies at
 	the first corruption.  This flag tells it to keep going
 	and make the best effort to recover as many objects as
 	possible.
 
---strict::
+`--strict`::
 	Don't write objects with broken content or links.
 
---max-input-size=<size>::
+`--max-input-size=<size>`::
 	Die, if the pack is larger than <size>.
 
 GIT
diff --git a/Documentation/git-update-index.txt b/Documentation/git-update-index.txt
index 02adf7aa81..7a4925b3c6 100644
--- a/Documentation/git-update-index.txt
+++ b/Documentation/git-update-index.txt
@@ -41,35 +41,35 @@ using the various options:
 
 OPTIONS
 -------
---add::
+`--add`::
 	If a specified file isn't in the index already then it's
 	added.
 	Default behaviour is to ignore new files.
 
---remove::
+`--remove`::
 	If a specified file is in the index but is missing then it's
 	removed.
 	Default behavior is to ignore removed file.
 
---refresh::
+`--refresh`::
 	Looks at the current index and checks to see if merges or
 	updates are needed by checking stat() information.
 
--q::
+`-q`::
         Quiet.  If `--refresh` finds that the index needs an update, the
         default behavior is to error out.  This option makes
 	`git update-index` continue anyway.
 
---ignore-submodules::
+`--ignore-submodules`::
 	Do not try to update submodules.  This option is only respected
 	when passed before `--refresh`.
 
---unmerged::
+`--unmerged`::
         If `--refresh` finds unmerged changes in the index, the default
 	behavior is to error out.  This option makes `git update-index`
         continue anyway.
 
---ignore-missing::
+`--ignore-missing`::
 	Ignores missing files during a `--refresh`
 
 --cacheinfo <mode>,<object>,<path>::
@@ -79,13 +79,13 @@ OPTIONS
 	arguments as three separate parameters, but new users are
 	encouraged to use a single-parameter form.
 
---index-info::
+`--index-info`::
         Read index information from stdin.
 
 --chmod=(+|-)x::
         Set the execute permissions on the updated files.
 
---[no-]assume-unchanged::
+`--[no-]assume-unchanged`::
 	When this flag is specified, the object names recorded
 	for the paths are not updated.  Instead, this option
 	sets/unsets the "assume unchanged" bit for the
@@ -103,46 +103,46 @@ in the index e.g. when merging in a commit;
 thus, in case the assumed-untracked file is changed upstream,
 you will need to handle the situation manually.
 
---really-refresh::
+`--really-refresh`::
 	Like `--refresh`, but checks stat information unconditionally,
 	without regard to the "assume unchanged" setting.
 
---[no-]skip-worktree::
+`--[no-]skip-worktree`::
 	When one of these flags is specified, the object name recorded
 	for the paths are not updated. Instead, these options
 	set and unset the "skip-worktree" bit for the paths. See
 	section "Skip-worktree bit" below for more information.
 
 
---[no-]ignore-skip-worktree-entries::
+`--[no-]ignore-skip-worktree-entries`::
 	Do not remove skip-worktree (AKA "index-only") entries even when
 	the `--remove` option was specified.
 
---[no-]fsmonitor-valid::
+`--[no-]fsmonitor-valid`::
 	When one of these flags is specified, the object name recorded
 	for the paths are not updated. Instead, these options
 	set and unset the "fsmonitor valid" bit for the paths. See
 	section "File System Monitor" below for more information.
 
--g::
---again::
+`-g`::
+`--again`::
 	Runs `git update-index` itself on the paths whose index
 	entries are different from those from the `HEAD` commit.
 
---unresolve::
+`--unresolve`::
 	Restores the 'unmerged' or 'needs updating' state of a
 	file during a merge if it was cleared by accident.
 
---info-only::
+`--info-only`::
 	Do not create objects in the object database for all
 	<file> arguments that follow this flag; just insert
 	their object IDs into the index.
 
---force-remove::
+`--force-remove`::
 	Remove the file from the index even when the working directory
 	still has such a file. (Implies `--remove`.)
 
---replace::
+`--replace`::
 	By default, when a file `path` exists in the index,
 	`git update-index` refuses an attempt to add `path/file`.
 	Similarly if a file `path/file` exists, a file `path`
@@ -150,12 +150,12 @@ you will need to handle the situation manually.
 	that conflict with the entry being added are
 	automatically removed with warning messages.
 
---stdin::
+`--stdin`::
 	Instead of taking list of paths from the command line,
 	read list of paths from the standard input.  Paths are
 	separated by LF (i.e. one path per line) by default.
 
---verbose::
+`--verbose`::
         Report what is being added and removed from index.
 
 --index-version <n>::
@@ -170,12 +170,12 @@ time. Version 4 is relatively young (first released in 1.8.0 in
 October 2012). Other Git implementations such as JGit and libgit2
 may not support it yet.
 
--z::
+`-z`::
 	Only meaningful with `--stdin` or `--index-info`; paths are
 	separated with NUL character instead of LF.
 
---split-index::
---no-split-index::
+`--split-index`::
+`--no-split-index`::
 	Enable or disable split index mode. If split-index mode is
 	already enabled and `--split-index` is given again, all
 	changes in `$GIT_DIR/index` are pushed back to the shared index
@@ -187,8 +187,8 @@ emitted when the change goes against the configured value, as the
 configured value will take effect next time the index is read and this
 will remove the intended effect of the option.
 
---untracked-cache::
---no-untracked-cache::
+`--untracked-cache`::
+`--no-untracked-cache`::
 	Enable or disable untracked cache feature. Please use
 	`--test-untracked-cache` before enabling it.
 +
@@ -198,7 +198,7 @@ emitted when the change goes against the configured value, as the
 configured value will take effect next time the index is read and this
 will remove the intended effect of the option.
 
---test-untracked-cache::
+`--test-untracked-cache`::
 	Only perform tests on the working directory to make sure
 	untracked cache can be used. You have to manually enable
 	untracked cache using `--untracked-cache` or
@@ -208,14 +208,14 @@ will remove the intended effect of the option.
 	explains what is not working as needed, otherwise the exit
 	code is 0 and OK is printed.
 
---force-untracked-cache::
+`--force-untracked-cache`::
 	Same as `--untracked-cache`. Provided for backwards
 	compatibility with older versions of Git where
 	`--untracked-cache` used to imply `--test-untracked-cache` but
 	this option would enable the extension unconditionally.
 
---fsmonitor::
---no-fsmonitor::
+`--fsmonitor`::
+`--no-fsmonitor`::
 	Enable or disable files system monitor feature. These options
 	take effect whatever the value of the `core.fsmonitor`
 	configuration variable (see linkgit:git-config[1]). But a warning
@@ -226,7 +226,7 @@ will remove the intended effect of the option.
 \--::
 	Do not interpret any more arguments as options.
 
-<file>::
+`<file>`::
 	Files to act on.
 	Note that files beginning with '.' are discarded. This includes
 	`./file` and `dir/./file`. If you don't want this, then use
diff --git a/Documentation/git-update-ref.txt b/Documentation/git-update-ref.txt
index 794dea70ec..7a81e39a4f 100644
--- a/Documentation/git-update-ref.txt
+++ b/Documentation/git-update-ref.txt
@@ -99,45 +99,45 @@ In either format, values can be specified in any form that Git
 recognizes as an object name.  Commands in any other format or a
 repeated <ref> produce an error.  Command meanings are:
 
-update::
+`update`::
 	Set <ref> to <newvalue> after verifying <oldvalue>, if given.
 	Specify a zero <newvalue> to ensure the ref does not exist
 	after the update and/or a zero <oldvalue> to make sure the
 	ref does not exist before the update.
 
-create::
+`create`::
 	Create <ref> with <newvalue> after verifying it does not
 	exist.  The given <newvalue> may not be zero.
 
-delete::
+`delete`::
 	Delete <ref> after verifying it exists with <oldvalue>, if
 	given.  If given, <oldvalue> may not be zero.
 
-verify::
+`verify`::
 	Verify <ref> against <oldvalue> but do not change it.  If
 	<oldvalue> is zero or missing, the ref must not exist.
 
-option::
+`option`::
 	Modify behavior of the next command naming a <ref>.
 	The only valid option is `no-deref` to avoid dereferencing
 	a symbolic ref.
 
-start::
+`start`::
 	Start a transaction. In contrast to a non-transactional session, a
 	transaction will automatically abort if the session ends without an
 	explicit commit. This command may create a new empty transaction when
 	the current one has been committed or aborted already.
 
-prepare::
+`prepare`::
 	Prepare to commit the transaction. This will create lock files for all
 	queued reference updates. If one reference could not be locked, the
 	transaction will be aborted.
 
-commit::
+`commit`::
 	Commit all reference updates queued for the transaction, ending the
 	transaction.
 
-abort::
+`abort`::
 	Abort the transaction, releasing all locks if the transaction is in
 	prepared state.
 
diff --git a/Documentation/git-upload-pack.txt b/Documentation/git-upload-pack.txt
index fdb7edc727..98e5f7aa3f 100644
--- a/Documentation/git-upload-pack.txt
+++ b/Documentation/git-upload-pack.txt
@@ -25,23 +25,23 @@ repository.  For push operations, see `git send-pack`.
 OPTIONS
 -------
 
---[no-]strict::
+`--[no-]strict`::
 	Do not try `<directory>/.git/` if <directory> is no Git directory.
 
---timeout=<n>::
+`--timeout=<n>`::
 	Interrupt transfer after <n> seconds of inactivity.
 
---stateless-rpc::
+`--stateless-rpc`::
 	Perform only a single read-write cycle with stdin and stdout.
 	This fits with the HTTP POST request processing model where
 	a program may read the request, write a response, and must exit.
 
---advertise-refs::
+`--advertise-refs`::
 	Only the initial ref advertisement is output, and the program exits
 	immediately. This fits with the HTTP GET request model, where
 	no request content is received but a response must be produced.
 
-<directory>::
+`<directory>`::
 	The repository to sync from.
 
 SEE ALSO
diff --git a/Documentation/git-var.txt b/Documentation/git-var.txt
index 1105e8a1cc..a33b76589a 100644
--- a/Documentation/git-var.txt
+++ b/Documentation/git-var.txt
@@ -17,7 +17,7 @@ Prints a Git logical variable.
 
 OPTIONS
 -------
--l::
+`-l`::
 	Cause the logical variables to be listed. In addition, all the
 	variables of the Git configuration file `.git/config` are listed
 	as well. (However, the configuration variables listing functionality
diff --git a/Documentation/git-verify-commit.txt b/Documentation/git-verify-commit.txt
index 87ed1cae5d..9e95556274 100644
--- a/Documentation/git-verify-commit.txt
+++ b/Documentation/git-verify-commit.txt
@@ -16,12 +16,12 @@ Validates the GPG signature created by `git commit -S`.
 
 OPTIONS
 -------
---raw::
+`--raw`::
 	Print the raw gpg status output to standard error instead of the normal
 	human-readable output.
 
--v::
---verbose::
+`-v`::
+`--verbose`::
 	Print the contents of the commit object before validating it.
 
 <commit>...::
diff --git a/Documentation/git-verify-pack.txt b/Documentation/git-verify-pack.txt
index 8163a86940..6e0b6f6a62 100644
--- a/Documentation/git-verify-pack.txt
+++ b/Documentation/git-verify-pack.txt
@@ -23,13 +23,13 @@ OPTIONS
 <pack>.idx ...::
 	The idx files to verify.
 
--v::
---verbose::
+`-v`::
+`--verbose`::
 	After verifying the pack, show list of objects contained
 	in the pack and a histogram of delta chain length.
 
--s::
---stat-only::
+`-s`::
+`--stat-only`::
 	Do not verify the pack contents; only show the histogram of delta
 	chain length.  With `--verbose`, list of objects is also shown.
 
diff --git a/Documentation/git-verify-tag.txt b/Documentation/git-verify-tag.txt
index 343e209fc5..f89ca539c8 100644
--- a/Documentation/git-verify-tag.txt
+++ b/Documentation/git-verify-tag.txt
@@ -16,12 +16,12 @@ Validates the gpg signature created by `git tag`.
 
 OPTIONS
 -------
---raw::
+`--raw`::
 	Print the raw gpg status output to standard error instead of the normal
 	human-readable output.
 
--v::
---verbose::
+`-v`::
+`--verbose`::
 	Print the contents of the tag object before validating it.
 
 <tag>...::
diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktree.txt
index 95fa3b673c..d44084a7f4 100644
--- a/Documentation/git-worktree.txt
+++ b/Documentation/git-worktree.txt
@@ -92,7 +92,7 @@ checked out in the new working tree, if it's not checked out anywhere
 else, otherwise the command will refuse to create the working tree (unless
 `--force` is used).
 
-list::
+`list`::
 
 List details of each working tree.  The main working tree is listed first,
 followed by each of the linked working trees.  The output details include
@@ -101,7 +101,7 @@ branch currently checked out (or "detached `HEAD`" if none), "locked" if
 the worktree is locked, "prunable" if the worktree can be pruned by `prune`
 command.
 
-lock::
+`lock`::
 
 If a working tree is on a portable device or network share which
 is not always mounted, lock it to prevent its administrative
@@ -109,7 +109,7 @@ files from being pruned automatically. This also prevents it from
 being moved or deleted. Optionally, specify a reason for the lock
 with `--reason`.
 
-move::
+`move`::
 
 Move a working tree to a new location. Note that the main working tree
 or linked working trees containing submodules cannot be moved with this
@@ -117,11 +117,11 @@ command. (The `git worktree repair` command, however, can reestablish
 the connection with linked working trees if you move the main working
 tree manually.)
 
-prune::
+`prune`::
 
 Prune working tree information in `$GIT_DIR/worktrees`.
 
-remove::
+`remove`::
 
 Remove a working tree. Only clean working trees (no untracked files
 and no modification in tracked files) can be removed. Unclean working
@@ -150,15 +150,15 @@ manually, then running `repair` in the main working tree and specifying the
 new `<path>` of each linked working tree will reestablish all connections
 in both directions.
 
-unlock::
+`unlock`::
 
 Unlock a working tree, allowing it to be pruned, moved or deleted.
 
 OPTIONS
 -------
 
--f::
---force::
+`-f`::
+`--force`::
 	By default, `add` refuses to create a new working tree when
 	`<commit-ish>` is a branch name and is already checked out by
 	another working tree, or if `<path>` is already assigned to some
@@ -183,18 +183,18 @@ To remove a locked working tree, specify `--force` twice.
 	exists. `-B` overrides this safeguard, resetting `<new-branch>` to
 	`<commit-ish>`.
 
--d::
---detach::
+`-d`::
+`--detach`::
 	With `add`, detach `HEAD` in the new working tree. See "DETACHED HEAD"
 	in linkgit:git-checkout[1].
 
---[no-]checkout::
+`--[no-]checkout`::
 	By default, `add` checks out `<commit-ish>`, however, `--no-checkout` can
 	be used to suppress checkout in order to make customizations,
 	such as configuring sparse-checkout. See "Sparse checkout"
 	in linkgit:git-read-tree[1].
 
---[no-]guess-remote::
+`--[no-]guess-remote`::
 	With `worktree add <path>`, without `<commit-ish>`, instead
 	of creating a new branch from `HEAD`, if there exists a tracking
 	branch in exactly one remote matching the basename of `<path>`,
@@ -204,33 +204,33 @@ To remove a locked working tree, specify `--force` twice.
 This can also be set up as the default behaviour by using the
 `worktree.guessRemote` config option.
 
---[no-]track::
+`--[no-]track`::
 	When creating a new branch, if `<commit-ish>` is a branch,
 	mark it as "upstream" from the new branch.  This is the
 	default if `<commit-ish>` is a remote-tracking branch.  See
 	`--track` in linkgit:git-branch[1] for details.
 
---lock::
+`--lock`::
 	Keep the working tree locked after creation. This is the
 	equivalent of `git worktree lock` after `git worktree add`,
 	but without a race condition.
 
--n::
---dry-run::
+`-n`::
+`--dry-run`::
 	With `prune`, do not remove anything; just report what it would
 	remove.
 
---porcelain::
+`--porcelain`::
 	With `list`, output in an easy-to-parse format for scripts.
 	This format will remain stable across Git versions and regardless of user
 	configuration.  See below for details.
 
--q::
---quiet::
+`-q`::
+`--quiet`::
 	With `add`, suppress feedback messages.
 
--v::
---verbose::
+`-v`::
+`--verbose`::
 	With `prune`, report all removals.
 +
 With `list`, output additional information about worktrees (see below).
@@ -244,7 +244,7 @@ older than `<time>`.
 --reason <string>::
 	With `lock`, an explanation why the working tree is locked.
 
-<worktree>::
+`<worktree>`::
 	Working trees can be identified by path, either relative or
 	absolute.
 +
diff --git a/Documentation/git-write-tree.txt b/Documentation/git-write-tree.txt
index 295a8715cb..6b0156286a 100644
--- a/Documentation/git-write-tree.txt
+++ b/Documentation/git-write-tree.txt
@@ -27,7 +27,7 @@ now, you need to have done a `git update-index` phase before you did the
 
 OPTIONS
 -------
---missing-ok::
+`--missing-ok`::
 	Normally `git write-tree` ensures that the objects referenced by the
 	directory exist in the object database.  This option disables this
 	check.
diff --git a/Documentation/git.txt b/Documentation/git.txt
index 4c6fca3128..d1389f92c1 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -39,10 +39,10 @@ or https://git-scm.com/docs.
 
 OPTIONS
 -------
---version::
+`--version`::
 	Prints the Git suite version that the `git` program came from.
 
---help::
+`--help`::
 	Prints the synopsis and a list of the most commonly used
 	commands. If the option `--all` or `-a` is given then all
 	available commands are printed. If a Git command is named this
@@ -80,7 +80,7 @@ config file). Including the equals but with an empty value (like `git -c
 foo.bar= ...`) sets `foo.bar` to the empty string which `git config
 --type=bool` will convert to `false`.
 
---config-env=<name>=<envvar>::
+`--config-env=<name>=<envvar>`::
 	Like `-c <name>=<value>`, give configuration variable
 	'<name>' a value, where <envvar> is the name of an
 	environment variable from which to retrieve the value. Unlike
@@ -102,36 +102,36 @@ Note that this might add security for variables such as
 the value, but not e.g. `url.<base>.insteadOf` where the
 sensitive information can be part of the key.
 
---exec-path[=<path>]::
+`--exec-path[=<path>]`::
 	Path to wherever your core Git programs are installed.
 	This can also be controlled by setting the GIT_EXEC_PATH
 	environment variable. If no path is given, `git` will print
 	the current setting and then exit.
 
---html-path::
+`--html-path`::
 	Print the path, without trailing slash, where Git's HTML
 	documentation is installed and exit.
 
---man-path::
+`--man-path`::
 	Print the manpath (see `man(1)`) for the man pages for
 	this version of Git and exit.
 
---info-path::
+`--info-path`::
 	Print the path where the Info files documenting this
 	version of Git are installed and exit.
 
--p::
---paginate::
+`-p`::
+`--paginate`::
 	Pipe all output into 'less' (or if set, `$PAGER`) if standard
 	output is a terminal.  This overrides the `pager.<cmd>`
 	configuration options (see the "Configuration Mechanism" section
 	below).
 
--P::
---no-pager::
+`-P`::
+`--no-pager`::
 	Do not pipe Git output into a pager.
 
---git-dir=<path>::
+`--git-dir=<path>`::
 	Set the path to the repository (".git" directory). This can also be
 	controlled by setting the `GIT_DIR` environment variable. It can be
 	an absolute path or relative path to current working directory.
@@ -150,7 +150,7 @@ environment variable)
 If you just want to run `git` as if it was started in `<path>` then use
 `git -C <path>`.
 
---work-tree=<path>::
+`--work-tree=<path>`::
 	Set the path to the working tree. It can be an absolute path
 	or a path relative to the current working directory.
 	This can also be controlled by setting the GIT_WORK_TREE
@@ -158,47 +158,47 @@ If you just want to run `git` as if it was started in `<path>` then use
 	variable (see `core.worktree` in linkgit:git-config[1] for a
 	more detailed discussion).
 
---namespace=<path>::
+`--namespace=<path>`::
 	Set the Git namespace.  See linkgit:gitnamespaces[7] for more
 	details.  Equivalent to setting the `GIT_NAMESPACE` environment
 	variable.
 
---super-prefix=<path>::
+`--super-prefix=<path>`::
 	Currently for internal use only.  Set a prefix which gives a path from
 	above a repository down to its root.  One use is to give submodules
 	context about the superproject that invoked it.
 
---bare::
+`--bare`::
 	Treat the repository as a bare repository.  If GIT_DIR
 	environment is not set, it is set to the current working
 	directory.
 
---no-replace-objects::
+`--no-replace-objects`::
 	Do not use replacement refs to replace Git objects. See
 	linkgit:git-replace[1] for more information.
 
---literal-pathspecs::
+`--literal-pathspecs`::
 	Treat pathspecs literally (i.e. no globbing, no pathspec magic).
 	This is equivalent to setting the `GIT_LITERAL_PATHSPECS` environment
 	variable to `1`.
 
---glob-pathspecs::
+`--glob-pathspecs`::
 	Add "glob" magic to all pathspec. This is equivalent to setting
 	the `GIT_GLOB_PATHSPECS` environment variable to `1`. Disabling
 	globbing on individual pathspecs can be done using pathspec
 	magic ":(literal)"
 
---noglob-pathspecs::
+`--noglob-pathspecs`::
 	Add "literal" magic to all pathspec. This is equivalent to setting
 	the `GIT_NOGLOB_PATHSPECS` environment variable to `1`. Enabling
 	globbing on individual pathspecs can be done using pathspec
 	magic ":(glob)"
 
---icase-pathspecs::
+`--icase-pathspecs`::
 	Add "icase" magic to all pathspec. This is equivalent to setting
 	the `GIT_ICASE_PATHSPECS` environment variable to `1`.
 
---no-optional-locks::
+`--no-optional-locks`::
 	Do not perform optional operations that require locks. This is
 	equivalent to setting the `GIT_OPTIONAL_LOCKS` to `0`.
 
@@ -365,35 +365,35 @@ list and more details about the configuration mechanism.
 
 Identifier Terminology
 ----------------------
-<object>::
+`<object>`::
 	Indicates the object name for any type of object.
 
-<blob>::
+`<blob>`::
 	Indicates a blob object name.
 
-<tree>::
+`<tree>`::
 	Indicates a tree object name.
 
-<commit>::
+`<commit>`::
 	Indicates a commit object name.
 
-<tree-ish>::
+`<tree-ish>`::
 	Indicates a tree, commit or tag object name.  A
 	command that takes a <tree-ish> argument ultimately wants to
 	operate on a <tree> object but automatically dereferences
 	<commit> and <tag> objects that point at a <tree>.
 
-<commit-ish>::
+`<commit-ish>`::
 	Indicates a commit or tag object name.  A
 	command that takes a <commit-ish> argument ultimately wants to
 	operate on a <commit> object but automatically dereferences
 	<tag> objects that point at a <commit>.
 
-<type>::
+`<type>`::
 	Indicates that an object type is required.
 	Currently one of: `blob`, `tree`, `commit`, or `tag`.
 
-<file>::
+`<file>`::
 	Indicates a filename - almost always relative to the
 	root of the tree structure `GIT_INDEX_FILE` describes.
 
@@ -402,14 +402,14 @@ Symbolic Identifiers
 Any Git command accepting any <object> can also use the following
 symbolic notation:
 
-HEAD::
+`HEAD`::
 	indicates the head of the current branch.
 
-<tag>::
+`<tag>`::
 	a valid tag 'name'
 	(i.e. a `refs/tags/<tag>` reference).
 
-<head>::
+`<head>`::
 	a valid head 'name'
 	(i.e. a `refs/heads/<head>` reference).
 
diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
index a5cfef7f86..0440adf4fc 100644
--- a/Documentation/gitattributes.txt
+++ b/Documentation/gitattributes.txt
@@ -29,13 +29,13 @@ listed on the line are given to the path.
 
 Each attribute can be in one of these states for a given path:
 
-Set::
+`Set`::
 
 	The path has the attribute with special value "true";
 	this is specified by listing only the name of the
 	attribute in the attribute list.
 
-Unset::
+`Unset`::
 
 	The path has the attribute with special value "false";
 	this is specified by listing the name of the attribute
@@ -48,7 +48,7 @@ Set to a value::
 	followed by an equal sign `=` and its value in the
 	attribute list.
 
-Unspecified::
+`Unspecified`::
 
 	No pattern matches the path, and nothing says if
 	the path has or does not have the attribute, the
@@ -129,13 +129,13 @@ Note that setting `core.autocrlf` to `true` or `input` overrides
 `core.eol` (see the definitions of those options in
 linkgit:git-config[1]).
 
-Set::
+`Set`::
 
 	Setting the `text` attribute on a path enables end-of-line
 	normalization and marks the path as a text file.  End-of-line
 	conversion takes place without guessing the content type.
 
-Unset::
+`Unset`::
 
 	Unsetting the `text` attribute on a path tells Git not to
 	attempt any end-of-line conversion upon checkin or checkout.
@@ -147,7 +147,7 @@ Set to string value "auto"::
 	text, its line endings are converted to LF on checkin.
 	When the file has been committed with CRLF, no conversion is done.
 
-Unspecified::
+`Unspecified`::
 
 	If the `text` attribute is unspecified, Git uses the
 	`core.autocrlf` configuration variable to determine if the
@@ -707,26 +707,26 @@ shown on the hunk header `@@ -k,l +n,m @@` line, tell Git to use an
 external command to generate the diff, or ask Git to convert binary
 files to a text format before generating the diff.
 
-Set::
+`Set`::
 
 	A path to which the `diff` attribute is set is treated
 	as text, even when they contain byte values that
 	normally never appear in text files, such as NUL.
 
-Unset::
+`Unset`::
 
 	A path to which the `diff` attribute is unset will
 	generate `Binary files differ` (or a binary patch, if
 	binary patches are enabled).
 
-Unspecified::
+`Unspecified`::
 
 	A path to which the `diff` attribute is unspecified
 	first gets its contents inspected, and if it looks like
 	text and is smaller than `core.bigFileThreshold`, it is treated
 	as text. Otherwise it would generate `Binary files differ`.
 
-String::
+`String`::
 
 	Diff is shown using the specified diff driver.  Each driver may
 	specify one or more options, as described in the following
@@ -1000,20 +1000,20 @@ The attribute `merge` affects how three versions of a file are
 merged when a file-level merge is necessary during `git merge`,
 and other commands such as `git revert` and `git cherry-pick`.
 
-Set::
+`Set`::
 
 	Built-in 3-way merge driver is used to merge the
 	contents in a way similar to 'merge' command of `RCS`
 	suite.  This is suitable for ordinary text files.
 
-Unset::
+`Unset`::
 
 	Take the version from the current branch as the
 	tentative merge result, and declare that the merge has
 	conflicts.  This is suitable for binary files that do
 	not have a well-defined merge semantics.
 
-Unspecified::
+`Unspecified`::
 
 	By default, this uses the same built-in 3-way merge
 	driver as is the case when the `merge` attribute is set.
@@ -1021,7 +1021,7 @@ Unspecified::
 	different merge driver to be used with paths for which the
 	`merge` attribute is unspecified.
 
-String::
+`String`::
 
 	3-way merge is performed using the specified custom
 	merge driver.  The built-in 3-way merge driver can be
@@ -1036,7 +1036,7 @@ Built-in merge drivers
 There are a few built-in low-level merge drivers defined that
 can be asked for via the `merge` attribute.
 
-text::
+`text`::
 
 	Usual 3-way file level merge for text files.  Conflicted
 	regions are marked with conflict markers `<<<<<<<`,
@@ -1045,13 +1045,13 @@ text::
 	from the merged branch appears after the `=======`
 	marker.
 
-binary::
+`binary`::
 
 	Keep the version from your branch in the work tree, but
 	leave the path in the conflicted state for the user to
 	sort out.
 
-union::
+`union`::
 
 	Run 3-way file level merge for text files, but take
 	lines from both versions, instead of leaving conflict
@@ -1132,22 +1132,22 @@ The `core.whitespace` configuration variable allows you to define what
 the project (See linkgit:git-config[1]).  This attribute gives you finer
 control per path.
 
-Set::
+`Set`::
 
 	Notice all types of potential whitespace errors known to Git.
 	The tab width is taken from the value of the `core.whitespace`
 	configuration variable.
 
-Unset::
+`Unset`::
 
 	Do not notice anything as error.
 
-Unspecified::
+`Unspecified`::
 
 	Use the value of the `core.whitespace` configuration variable to
 	decide what to notice as error.
 
-String::
+`String`::
 
 	Specify a comma separate list of common whitespace problems to
 	notice in the same format as the `core.whitespace` configuration
diff --git a/Documentation/gitcli.txt b/Documentation/gitcli.txt
index 0fb18e3f35..d96e17ef5f 100644
--- a/Documentation/gitcli.txt
+++ b/Documentation/gitcli.txt
@@ -111,7 +111,7 @@ Magic Options
 Commands which have the enhanced option parser activated all understand a
 couple of magic command-line options:
 
--h::
+`-h`::
 	gives a pretty printed usage of the command.
 +
 ---------------------------------------------
@@ -132,7 +132,7 @@ when there are things on the command line other than `-h`, but `git
 subcmd -h` without anything else on the command line is meant to
 consistently give the usage.
 
---help-all::
+`--help-all`::
 	Some Git commands take options that are only used for plumbing or that
 	are deprecated, and such options are hidden from the default usage. This
 	option gives the full list of options.
diff --git a/Documentation/gitcore-tutorial.txt b/Documentation/gitcore-tutorial.txt
index aa11b4562b..15c5ca122f 100644
--- a/Documentation/gitcore-tutorial.txt
+++ b/Documentation/gitcore-tutorial.txt
@@ -1011,7 +1011,7 @@ $ git fetch <remote-repository>
 One of the following transports can be used to name the
 repository to download from:
 
-SSH::
+`SSH`::
 	`remote.machine:/path/to/repo.git/` or
 +
 `ssh://remote.machine/path/to/repo.git/`
diff --git a/Documentation/gitcredentials.txt b/Documentation/gitcredentials.txt
index a11e72ca4c..b3be044e9e 100644
--- a/Documentation/gitcredentials.txt
+++ b/Documentation/gitcredentials.txt
@@ -66,12 +66,12 @@ storage provided by the OS or other programs.
 To use a helper, you must first select one to use. Git currently
 includes the following helpers:
 
-cache::
+`cache`::
 
 	Cache credentials in memory for a short period of time. See
 	linkgit:git-credential-cache[1] for details.
 
-store::
+`store`::
 
 	Store credentials indefinitely on disk. See
 	linkgit:git-credential-store[1] for details.
@@ -152,7 +152,7 @@ above.
 
 The following options are available in either location:
 
-helper::
+`helper`::
 
 	The name of an external credential helper, and any associated options.
 	If the helper name is not an absolute path, then the string `git
@@ -171,11 +171,11 @@ the helper list to empty (so you may override a helper set by a
 lower-priority config file by configuring the empty-string helper,
 followed by whatever set of helpers you would like).
 
-username::
+`username`::
 
 	A default username, if one is not provided in the URL.
 
-useHttpPath::
+`useHttpPath`::
 
 	By default, Git does not consider the "path" component of an http URL
 	to be worth matching via external helpers. This means that a credential
diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
index ce1aa25d5a..cf3e4b4011 100644
--- a/Documentation/githooks.txt
+++ b/Documentation/githooks.txt
@@ -571,7 +571,7 @@ thus has access to these notes.
 
 The following command-specific comments apply:
 
-rebase::
+`rebase`::
 	For the 'squash' and 'fixup' operation, all commits that were
 	squashed are listed as being rewritten to the squashed commit.
 	This means that there will be several lines sharing the same
diff --git a/Documentation/gitk.txt b/Documentation/gitk.txt
index bc0cb104cc..4fd7300cc4 100644
--- a/Documentation/gitk.txt
+++ b/Documentation/gitk.txt
@@ -35,13 +35,13 @@ rev-list options and arguments
 This manual page describes only the most frequently used options.  See
 linkgit:git-rev-list[1] for a complete list.
 
---all::
+`--all`::
 
 	Show all refs (branches, tags, etc.).
 
---branches[=<pattern>]::
---tags[=<pattern>]::
---remotes[=<pattern>]::
+`--branches[=<pattern>]`::
+`--tags[=<pattern>]`::
+`--remotes[=<pattern>]`::
 
 	Pretend as if all the branches (tags, remote branches, resp.)
 	are listed on the command line as '<commit>'. If '<pattern>'
@@ -49,38 +49,38 @@ linkgit:git-rev-list[1] for a complete list.
 	pattern lacks '?', '{asterisk}', or '[', '/{asterisk}' at the
 	end is implied.
 
---since=<date>::
+`--since=<date>`::
 
 	Show commits more recent than a specific date.
 
---until=<date>::
+`--until=<date>`::
 
 	Show commits older than a specific date.
 
---date-order::
+`--date-order`::
 
 	Sort commits by date when possible.
 
---merge::
+`--merge`::
 
 	After an attempt to merge stops with conflicts, show the commits on
 	the history between two branches (i.e. the `HEAD` and the `MERGE_HEAD`)
 	that modify the conflicted files and do not exist on all the heads
 	being merged.
 
---left-right::
+`--left-right`::
 
 	Mark which side of a symmetric difference a commit is reachable
 	from.  Commits from the left side are prefixed with a `<`
 	symbol and those from the right with a `>` symbol.
 
---full-history::
+`--full-history`::
 
 	When filtering history with '<path>...', does not prune some
 	history.  (See "History simplification" in linkgit:git-log[1]
 	for a more detailed explanation.)
 
---simplify-merges::
+`--simplify-merges`::
 
 	Additional option to `--full-history` to remove some needless
 	merges from the resulting history, as there are no selected
@@ -88,7 +88,7 @@ linkgit:git-rev-list[1] for a complete list.
 	simplification" in linkgit:git-log[1] for a more detailed
 	explanation.)
 
---ancestry-path::
+`--ancestry-path`::
 
 	When given a range of commits to display
 	(e.g. 'commit1..commit2' or 'commit2 {caret}commit1'), only
@@ -118,7 +118,7 @@ include::line-range-options.txt[]
 `gitk`-specific options
 ~~~~~~~~~~~~~~~~~~~~~
 
---argscmd=<command>::
+`--argscmd=<command>`::
 
 	Command to be run each time `gitk` has to determine the revision
 	range to show.  The command is expected to print on its
@@ -127,7 +127,7 @@ include::line-range-options.txt[]
 	'<revision range>' if the set of commits to show may vary
 	between refreshes.
 
---select-commit=<ref>::
+`--select-commit=<ref>`::
 
 	Select the specified commit after loading the graph.
 	Default behavior is equivalent to specifying `--select-commit=HEAD`.
diff --git a/Documentation/gitmodules.txt b/Documentation/gitmodules.txt
index ea6b4427c6..861a8ae778 100644
--- a/Documentation/gitmodules.txt
+++ b/Documentation/gitmodules.txt
@@ -68,19 +68,19 @@ submodule.<name>.ignore::
 	a submodule as modified. The following values are supported:
 +
 --
-	all;; The submodule will never be considered modified (but will
+	`all`;; The submodule will never be considered modified (but will
 	    nonetheless show up in the output of status and commit when it has
 	    been staged).
 
-	dirty;; All changes to the submodule's work tree will be ignored, only
+	`dirty`;; All changes to the submodule's work tree will be ignored, only
 	    committed differences between the `HEAD` of the submodule and its
 	    recorded state in the superproject are taken into account.
 
-	untracked;; Only untracked files in submodules will be ignored.
+	`untracked`;; Only untracked files in submodules will be ignored.
 	    Committed differences and modifications to tracked files will show
 	    up.
 
-	none;; No modifications to submodules are ignored, all of committed
+	`none`;; No modifications to submodules are ignored, all of committed
 	    differences, and modifications to tracked and untracked files are
 	    shown. This is the default option.
 
diff --git a/Documentation/gitremote-helpers.txt b/Documentation/gitremote-helpers.txt
index e92b9113f2..80681ed5c0 100644
--- a/Documentation/gitremote-helpers.txt
+++ b/Documentation/gitremote-helpers.txt
@@ -94,7 +94,7 @@ must provide.
 
 Capabilities for Pushing
 ^^^^^^^^^^^^^^^^^^^^^^^^
-'connect'::
+`connect`::
 	Can attempt to connect to `git receive-pack` (for pushing),
 	`git upload-pack`, etc for communication using
 	git's native packfile protocol. This
@@ -102,7 +102,7 @@ Capabilities for Pushing
 +
 Supported commands: 'connect'.
 
-'stateless-connect'::
+`stateless-connect`::
 	Experimental; for internal use only.
 	Can attempt to connect to a remote server for communication
 	using git's wire-protocol version 2.  See the documentation
@@ -110,13 +110,13 @@ Supported commands: 'connect'.
 +
 Supported commands: 'stateless-connect'.
 
-'push'::
+`push`::
 	Can discover remote refs and push local commits and the
 	history leading up to them to new or existing remote refs.
 +
 Supported commands: 'list for-push', 'push'.
 
-'export'::
+`export`::
 	Can discover remote refs and push specified objects from a
 	fast-import stream to remote refs.
 +
@@ -128,7 +128,7 @@ connecting (see the 'connect' command under COMMANDS).
 When choosing between 'push' and 'export', Git prefers 'push'.
 Other frontends may have some other order of preference.
 
-'no-private-update'::
+`no-private-update`::
 	When using the 'refspec' capability, `git` normally updates the
 	private ref on successful push. This update is disabled when
 	the remote-helper declares the capability 'no-private-update'.
@@ -136,7 +136,7 @@ Other frontends may have some other order of preference.
 
 Capabilities for Fetching
 ^^^^^^^^^^^^^^^^^^^^^^^^^
-'connect'::
+`connect`::
 	Can try to connect to `git upload-pack` (for fetching),
 	`git receive-pack`, etc for communication using the
 	Git's native packfile protocol. This
@@ -144,7 +144,7 @@ Capabilities for Fetching
 +
 Supported commands: 'connect'.
 
-'stateless-connect'::
+`stateless-connect`::
 	Experimental; for internal use only.
 	Can attempt to connect to a remote server for communication
 	using git's wire-protocol version 2.  See the documentation
@@ -152,19 +152,19 @@ Supported commands: 'connect'.
 +
 Supported commands: 'stateless-connect'.
 
-'fetch'::
+`fetch`::
 	Can discover remote refs and transfer objects reachable from
 	them to the local object store.
 +
 Supported commands: 'list', 'fetch'.
 
-'import'::
+`import`::
 	Can discover remote refs and output objects reachable from
 	them as a stream in fast-import format.
 +
 Supported commands: 'list', 'import'.
 
-'check-connectivity'::
+`check-connectivity`::
 	Can guarantee that when a clone is requested, the received
 	pack is self contained and is connected.
 
@@ -177,7 +177,7 @@ Other frontends may have some other order of preference.
 Miscellaneous capabilities
 ^^^^^^^^^^^^^^^^^^^^^^^^^^
 
-'option'::
+`option`::
 	For specifying settings like `verbosity` (how much output to
 	write to stderr) and `depth` (how much history is wanted in the
 	case of a shallow clone) that affect how other commands are
@@ -208,7 +208,7 @@ interact with, and to let the private namespace refs point to this
 local repository, while the refs/remotes namespace is used to track
 the remote repository.
 
-'bidi-import'::
+`bidi-import`::
 	This modifies the 'import' capability.
 	The fast-import commands 'cat-blob' and 'ls' can be used by remote-helpers
 	to retrieve information about blobs and trees that already exist in
@@ -233,12 +233,12 @@ the remote repository.
 	marks specified in <file> before processing any input. For details,
 	read up on `--import-marks=<file>` in linkgit:git-fast-export[1].
 
-'signed-tags'::
+`signed-tags`::
 	This modifies the 'export' capability, instructing Git to pass
 	`--signed-tags=verbatim` to linkgit:git-fast-export[1].  In the
 	absence of this capability, Git will use `--signed-tags=warn-strip`.
 
-'object-format'::
+`object-format`::
 	This indicates that the helper is able to interact with the remote
 	side using an explicit hash algorithm extension.
 
@@ -248,7 +248,7 @@ COMMANDS
 
 Commands are given by the caller on the helper's standard input, one per line.
 
-'capabilities'::
+`capabilities`::
 	Lists the capabilities of the helper, one per line, ending
 	with a blank line. Each capability may be preceded with '*',
 	which marks them mandatory for Git versions using the remote
@@ -257,7 +257,7 @@ Commands are given by the caller on the helper's standard input, one per line.
 +
 Support for this command is mandatory.
 
-'list'::
+`list`::
 	Lists the refs, one per line, in the format "<value> <name>
 	[<attr> ...]". The value may be a hex sha1 hash, "@<dest>" for
 	a symref, ":<keyword> <value>" for a key-value pair, or
@@ -370,7 +370,7 @@ stdin.
 +
 Supported if the helper has the "import" capability.
 
-'export'::
+`export`::
 	Instructs the remote helper that any subsequent input is
 	part of a fast-import stream (generated by `git fast-export`)
 	containing objects which should be pushed to the remote.
@@ -433,7 +433,7 @@ The 'list' command produces a list of refs in which each ref
 may be followed by a list of attributes. The following ref list
 attributes are defined.
 
-'unchanged'::
+`unchanged`::
 	This ref is unchanged since the last import or fetch, although
 	the helper cannot necessarily determine what value that produced.
 
@@ -443,7 +443,7 @@ REF LIST KEYWORDS
 The 'list' command may produce a list of key-value pairs.
 The following keys are defined.
 
-'object-format'::
+`object-format`::
 	The refs are using the given hash algorithm.  This keyword is only
 	used if the server and client both support the object-format
 	extension.
diff --git a/Documentation/gitrepository-layout.txt b/Documentation/gitrepository-layout.txt
index 95a98f7802..c639ea8cc6 100644
--- a/Documentation/gitrepository-layout.txt
+++ b/Documentation/gitrepository-layout.txt
@@ -31,7 +31,7 @@ submodule working tree, without losing the submodule repository.
 
 These things may exist in a Git repository.
 
-objects::
+`objects`::
 	Object store associated with this repository.  Usually
 	an object store is self sufficient (i.e. all the objects
 	that are referred to by an object found in it are also
@@ -91,7 +91,7 @@ objects/info/http-alternates::
 	this object store borrows objects from, to be used when
 	the repository is fetched over HTTP.
 
-refs::
+`refs`::
 	References are stored in subdirectories of this
 	directory.  The `git prune` command knows to preserve
 	objects reachable from refs found in this directory and
@@ -117,13 +117,13 @@ refs/replace/`<obj-sha1>`::
 	maintained by linkgit:git-replace[1]. Such refs can be exchanged
 	between repositories while grafts are not.
 
-packed-refs::
+`packed-refs`::
 	records the same information as refs/heads/, refs/tags/,
 	and friends record in a more efficient way.  See
 	linkgit:git-pack-refs[1]. This file is ignored if `$GIT_COMMON_DIR`
 	is set and `$GIT_COMMON_DIR/packed-refs` will be used instead.
 
-HEAD::
+`HEAD`::
 	A symref (see glossary) to the `refs/heads/` namespace
 	describing the currently active branch.  It does not mean
 	much if the repository is not associated with any working tree
@@ -140,7 +140,7 @@ being a symref to point at the current branch.  Such a state
 is often called 'detached `HEAD`.'  See linkgit:git-checkout[1]
 for details.
 
-config::
+`config`::
 	Repository specific configuration file. This file is ignored
 	if `$GIT_COMMON_DIR` is set and `$GIT_COMMON_DIR/config` will be
 	used instead.
@@ -150,7 +150,7 @@ config.worktree::
 	working directory in multiple working directory setup (see
 	linkgit:git-worktree[1]).
 
-branches::
+`branches`::
 	A slightly deprecated way to store shorthands to be used
 	to specify a URL to `git fetch`, `git pull` and `git push`.
 	A file can be stored as `branches/<name>` and then
@@ -162,7 +162,7 @@ branches::
 	`$GIT_COMMON_DIR/branches` will be used instead.
 
 
-hooks::
+`hooks`::
 	Hooks are customization scripts used by various Git
 	commands.  A handful of sample hooks are installed when
 	`git init` is run, but all of them are disabled by
@@ -172,13 +172,13 @@ hooks::
 	each hook. This directory is ignored if `$GIT_COMMON_DIR` is set
 	and `$GIT_COMMON_DIR/hooks` will be used instead.
 
-common::
+`common`::
 	When multiple working trees are used, most of files in
 	`$GIT_DIR` are per-worktree with a few known exceptions. All
 	files under 'common' however will be shared between all
 	working trees.
 
-index::
+`index`::
 	The current index file for the repository.  It is
 	usually not found in a bare repository.
 
@@ -186,7 +186,7 @@ sharedindex.<SHA-1>::
 	The shared index part, to be referenced by `$GIT_DIR/index` and
 	other temporary index files. Only valid in split index mode.
 
-info::
+`info`::
 	Additional information about the repository is recorded
 	in this directory. This directory is ignored if `$GIT_COMMON_DIR`
 	is set and `$GIT_COMMON_DIR/info` will be used instead.
@@ -228,7 +228,7 @@ info/sparse-checkout::
 	This file stores sparse checkout patterns.
 	See also: linkgit:git-read-tree[1].
 
-remotes::
+`remotes`::
 	Stores shorthands for URL and default refnames for use
 	when interacting with remote repositories via `git fetch`,
 	`git pull` and `git push` commands.  See the REMOTES section
@@ -237,7 +237,7 @@ remotes::
 	directory is ignored if `$GIT_COMMON_DIR` is set and
 	`$GIT_COMMON_DIR/remotes` will be used instead.
 
-logs::
+`logs`::
 	Records of changes made to refs are stored in this directory.
 	See linkgit:git-update-ref[1] for more information. This
 	directory is ignored (except logs/HEAD) if `$GIT_COMMON_DIR` is
@@ -249,24 +249,24 @@ logs/refs/heads/`name`::
 logs/refs/tags/`name`::
 	Records all changes made to the tag named `name`.
 
-shallow::
+`shallow`::
 	This is similar to `info/grafts` but is internally used
 	and maintained by shallow clone mechanism.  See `--depth`
 	option to linkgit:git-clone[1] and linkgit:git-fetch[1]. This
 	file is ignored if `$GIT_COMMON_DIR` is set and
 	`$GIT_COMMON_DIR/shallow` will be used instead.
 
-commondir::
+`commondir`::
 	If this file exists, `$GIT_COMMON_DIR` (see linkgit:git[1]) will
 	be set to the path specified in this file if it is not
 	explicitly set. If the specified path is relative, it is
 	relative to `$GIT_DIR`. The repository with commondir is
 	incomplete without the repository pointed by "commondir".
 
-modules::
+`modules`::
 	Contains the `git`-repositories of the submodules.
 
-worktrees::
+`worktrees`::
 	Contains administrative data for linked
 	working trees. Each subdirectory contains the working tree-related
 	part of a linked working tree. This directory is ignored if
diff --git a/Documentation/gitweb.conf.txt b/Documentation/gitweb.conf.txt
index 8a8d3f9acf..9cd1e9dc67 100644
--- a/Documentation/gitweb.conf.txt
+++ b/Documentation/gitweb.conf.txt
@@ -624,7 +624,7 @@ As one can see it lacks the \'sub' element.
 The meaning of each part of feature configuration is described
 below:
 
-default::
+`default`::
 	List (array reference) of feature parameters (if there are any),
 	used also to toggle (enable or disable) given feature.
 +
@@ -638,7 +638,7 @@ section.
 To disable features that accept parameters (are configurable), you
 need to set this element to empty list i.e. `[]`.
 
-override::
+`override`::
 	If this field has a true value then the given feature is
 	overridable, which means that it can be configured
 	(or enabled/disabled) on a per-repository basis.
@@ -648,7 +648,7 @@ config variable in the per-repository Git configuration file.
 +
 *Note* that no feature is overridable by default.
 
-sub::
+`sub`::
 	Internal detail of implementation.  What is important is that
 	if this field is not present then per-repository override for
 	given feature is not supported.
@@ -663,7 +663,7 @@ below.  This should be a complete list, but ultimately the authoritative
 and complete list is in gitweb.cgi source code, with features described
 in the comments.
 
-blame::
+`blame`::
 	Enable the "blame" and "blame_incremental" blob views, showing for
 	each line the last commit that modified it; see linkgit:git-blame[1].
 	This can be very CPU-intensive and is therefore disabled by default.
@@ -671,7 +671,7 @@ blame::
 This feature can be configured on a per-repository basis via
 repository's `gitweb.blame` configuration variable (boolean).
 
-snapshot::
+`snapshot`::
 	Enable and configure the "snapshot" action, which allows user to
 	download a compressed archive of any tree or commit, as produced
 	by linkgit:git-archive[1] and possibly additionally compressed.
@@ -688,7 +688,7 @@ repository's `gitweb.snapshot` configuration variable, which contains
 a comma separated list of formats or "none" to disable snapshots.
 Unknown values are ignored.
 
-grep::
+`grep`::
 	Enable grep search, which lists the files in currently selected
 	tree (directory) containing the given string; see linkgit:git-grep[1].
 	This can be potentially CPU-intensive, of course.  Enabled by default.
@@ -696,7 +696,7 @@ grep::
 This feature can be configured on a per-repository basis via
 repository's `gitweb.grep` configuration variable (boolean).
 
-pickaxe::
+`pickaxe`::
 	Enable the so called pickaxe search, which will list the commits
 	that introduced or removed a given string in a file.  This can be
 	practical and quite faster alternative to "blame" action, but it is
@@ -709,7 +709,7 @@ linkgit:gitdiffcore[7] for more details).
 This feature can be configured on a per-repository basis by setting
 repository's `gitweb.pickaxe` configuration variable (boolean).
 
-show-sizes::
+`show-sizes`::
 	Enable showing size of blobs (ordinary files) in a "tree" view, in a
 	separate column, similar to what `ls -l` does; see description of
 	`-l` option in linkgit:git-ls-tree[1] manpage.  This costs a bit of
@@ -718,7 +718,7 @@ show-sizes::
 This feature can be configured on a per-repository basis via
 repository's `gitweb.showSizes` configuration variable (boolean).
 
-patches::
+`patches`::
 	Enable and configure "patches" view, which displays list of commits in email
 	(plain text) output format; see also linkgit:git-format-patch[1].
 	The value is the maximum number of patches in a patchset generated
@@ -730,7 +730,7 @@ patches::
 This feature can be configured on a per-repository basis via
 repository's `gitweb.patches` configuration variable (integer).
 
-avatar::
+`avatar`::
 	Avatar support.  When this feature is enabled, views such as
 	"shortlog" or "commit" will display an avatar associated with
 	the email of each committer and author.
@@ -751,7 +751,7 @@ default font sizes or lineheights are changed (e.g. via adding extra
 CSS stylesheet in `@stylesheets`), it may be appropriate to change
 these values.
 
-highlight::
+`highlight`::
 	Server-side syntax highlight support in "blob" view.  It requires
 	`$highlight_bin` program to be available (see the description of
 	this variable in the "Configuration variables" section above),
@@ -773,7 +773,7 @@ repository's `gitweb.remote_heads` configuration variable (boolean).
 
 The remaining features cannot be overridden on a per project basis.
 
-search::
+`search`::
 	Enable text search, which will list the commits which match author,
 	committer or commit text to a given string; see the description of
 	`--author`, `--committer` and `--grep` options in linkgit:git-log[1]
@@ -781,7 +781,7 @@ search::
 +
 Project specific override is not supported.
 
-forks::
+`forks`::
 	If this feature is enabled, `gitweb` considers projects in
 	subdirectories of project root (basename) to be forks of existing
 	projects.  For each project +$projname.git+, projects in the
@@ -797,7 +797,7 @@ in that file.
 +
 Project specific override is not supported.
 
-actions::
+`actions`::
 	Insert custom links to the action bar of all project pages.  This
 	allows you to link to third-party scripts integrating into `gitweb`.
 +
@@ -823,7 +823,7 @@ This adds a link titled "graphiclog" after the "summary" link, leading to
 +
 Project specific override is not supported.
 
-timed::
+`timed`::
 	Enable displaying how much time and how many Git commands it took to
 	generate and display each page in the page footer (at the bottom of
 	page).  For example the footer might contain: "This page took 6.53325
@@ -831,7 +831,7 @@ timed::
 +
 Project specific override is not supported.
 
-javascript-timezone::
+`javascript-timezone`::
 	Enable and configure the ability to change a common time zone for dates
 	in `gitweb` output via JavaScript.  Dates in `gitweb` output include
 	authordate and committerdate in "commit", "commitdiff" and "log"
@@ -859,7 +859,7 @@ time zones in the form of "+/-HHMM", such as "+0200".
 +
 Project specific override is not supported.
 
-extra-branch-refs::
+`extra-branch-refs`::
 	List of additional directories under `refs` which are going to
 	be used as branch refs. For example if you have a gerrit setup
 	where all branches under refs/heads/ are official,
diff --git a/Documentation/gitweb.txt b/Documentation/gitweb.txt
index f164857d83..3ade8b7d72 100644
--- a/Documentation/gitweb.txt
+++ b/Documentation/gitweb.txt
@@ -280,24 +280,24 @@ five components:
 .../gitweb.cgi/<repo>/<action>/<revision>:/<path>?<arguments>
 -----------------------------------------------------------------------
 
-repo::
+`repo`::
 	The repository the action will be performed on.
 +
 All actions except for those that list all available projects,
 in whatever form, require this parameter.
 
-action::
+`action`::
 	The action that will be run.  Defaults to 'projects_list' if repo
 	is not set, and to 'summary' otherwise.
 
-revision::
+`revision`::
 	Revision shown.  Defaults to `HEAD`.
 
-path::
+`path`::
 	The path within the <repository> that the action is performed on,
 	for those actions that require it.
 
-arguments::
+`arguments`::
 	Any arguments that control the behaviour of the action.
 
 Some actions require or allow to specify two revisions, and sometimes even two
@@ -327,21 +327,21 @@ project_list::
 	Lists the available Git repositories.  This is the default command if no
 	repository is specified in the URL.
 
-summary::
+`summary`::
 	Displays summary about given repository.  This is the default command if
 	no action is specified in URL, and only repository is specified.
 
-heads::
-remotes::
+`heads`::
+`remotes`::
 	Lists all local or all remote-tracking branches in given repository.
 +
 The latter is not available by default, unless configured.
 
-tags::
+`tags`::
 	List all tags (lightweight and annotated) in given repository.
 
-blob::
-tree::
+`blob`::
+`tree`::
 	Shows the files and directories in a given repository path, at given
 	revision.  This is default command if no action is specified in the URL,
 	and path is given.
@@ -350,10 +350,10 @@ blob_plain::
 	Returns the raw data for the file in given repository, at given path and
 	revision.  Links to this action are marked 'raw'.
 
-blobdiff::
+`blobdiff`::
 	Shows the difference between two revisions of the same file.
 
-blame::
+`blame`::
 blame_incremental::
 	Shows the blame (also called annotation) information for a file. On a
 	per line basis it shows the revision in which that line was last changed
@@ -363,34 +363,34 @@ blame_incremental::
 +
 This action is disabled by default for performance reasons.
 
-commit::
-commitdiff::
+`commit`::
+`commitdiff`::
 	Shows information about a specific commit in a repository.  The 'commit'
 	view shows information about commit in more detail, the 'commitdiff'
 	action shows changeset for given commit.
 
-patch::
+`patch`::
 	Returns the commit in plain text mail format, suitable for applying with
 	linkgit:git-am[1].
 
-tag::
+`tag`::
 	Display specific annotated tag (tag object).
 
-log::
-shortlog::
+`log`::
+`shortlog`::
 	Shows log information (commit message or just commit subject) for a
 	given branch (starting from given revision).
 +
 The 'shortlog' view is more compact; it shows one commit per line.
 
-history::
+`history`::
 	Shows history of the file or directory in a given repository path,
 	starting from given revision (defaults to `HEAD`, i.e. default branch).
 +
 This view is similar to 'shortlog' view.
 
-rss::
-atom::
+`rss`::
+`atom`::
 	Generates an RSS (or Atom) feed of changes to repository.
 
 
diff --git a/Documentation/glossary-content.txt b/Documentation/glossary-content.txt
index cc8bfc5cfb..122b5a71ea 100644
--- a/Documentation/glossary-content.txt
+++ b/Documentation/glossary-content.txt
@@ -352,19 +352,19 @@ A pathspec with only a colon means "there is no pathspec". This form
 should not be combined with other pathspec.
 +
 --
-top;;
+`top`;;
 	The magic word `top` (magic signature: `/`) makes the pattern
 	match from the root of the working tree, even when you are
 	running the command from inside a subdirectory.
 
-literal;;
+`literal`;;
 	Wildcards in the pattern such as `*` or `?` are treated
 	as literal characters.
 
-icase;;
+`icase`;;
 	Case insensitive match.
 
-glob;;
+`glob`;;
 	Git treats the pattern as a shell glob suitable for
 	consumption by fnmatch(3) with the FNM_PATHNAME flag:
 	wildcards in the pattern will not match a / in the pathname.
@@ -393,7 +393,7 @@ full pathname may have special meaning:
 +
 Glob magic is incompatible with literal magic.
 
-attr;;
+`attr`;;
 After `attr:` comes a space separated list of "attribute
 requirements", all of which must be met in order for the
 path to be considered a match; this is in addition to the
@@ -416,7 +416,7 @@ these forms:
 Note that when matching against a tree object, attributes are still
 obtained from working tree, not from the given tree object.
 
-exclude;;
+`exclude`;;
 	After a path matches any non-exclude pathspec, it will be run
 	through all exclude pathspecs (magic signature: `!` or its
 	synonym `^`). If it matches, the path is ignored.  When there
diff --git a/Documentation/merge-options.txt b/Documentation/merge-options.txt
index 6f6f31874b..ec6b02f79a 100644
--- a/Documentation/merge-options.txt
+++ b/Documentation/merge-options.txt
@@ -1,5 +1,5 @@
---commit::
---no-commit::
+`--commit`::
+`--no-commit`::
 	Perform the merge and commit the result. This option can
 	be used to override `--no-commit`.
 +
@@ -12,9 +12,9 @@ therefore there is no way to stop those merges with `--no-commit`.
 Thus, if you want to ensure your branch is not changed or updated
 by the merge command, use `--no-ff` with `--no-commit`.
 
---edit::
--e::
---no-edit::
+`--edit`::
+`-e`::
+`--no-edit`::
 	Invoke an editor before committing successful mechanical merge to
 	further edit the auto-generated merge message, so that the user
 	can explain and justify the merge. The `--no-edit` option can be
@@ -32,16 +32,16 @@ they run `git merge`. To make it easier to adjust such scripts to the
 updated behaviour, the environment variable `GIT_MERGE_AUTOEDIT` can be
 set to `no` at the beginning of them.
 
---cleanup=<mode>::
+`--cleanup=<mode>`::
 	This option determines how the merge message will be cleaned up before
 	committing. See linkgit:git-commit[1] for more details. In addition, if
 	the '<mode>' is given a value of `scissors`, scissors will be appended
 	to `MERGE_MSG` before being passed on to the commit machinery in the
 	case of a merge conflict.
 
---ff::
---no-ff::
---ff-only::
+`--ff`::
+`--no-ff`::
+`--ff-only`::
 	Specifies how a merge is handled when the merged-in history is
 	already a descendant of the current history.  `--ff` is the
 	default unless merging an annotated (and possibly signed) tag
@@ -59,17 +59,17 @@ could instead be resolved as a fast-forward.
 With `--ff-only`, resolve the merge as a fast-forward when possible.
 When not possible, refuse to merge and exit with a non-zero status.
 
--S[<keyid>]::
---gpg-sign[=<keyid>]::
---no-gpg-sign::
+`-S[<keyid>]`::
+`--gpg-sign[=<keyid>]`::
+`--no-gpg-sign`::
 	GPG-sign the resulting merge commit. The `keyid` argument is
 	optional and defaults to the committer identity; if specified,
 	it must be stuck to the option without a space. `--no-gpg-sign`
 	is useful to countermand both `commit.gpgSign` configuration variable,
 	and earlier `--gpg-sign`.
 
---log[=<n>]::
---no-log::
+`--log[=<n>]`::
+`--no-log`::
 	In addition to branch names, populate the log message with
 	one-line descriptions from at most <n> actual commits that are being
 	merged. See also linkgit:git-fmt-merge-msg[1].
@@ -79,17 +79,17 @@ actual commits being merged.
 
 include::signoff-option.txt[]
 
---stat::
--n::
---no-stat::
+`--stat`::
+`-n`::
+`--no-stat`::
 	Show a diffstat at the end of the merge. The diffstat is also
 	controlled by the configuration option merge.stat.
 +
 With `-n` or `--no-stat` do not show a diffstat at the end of the
 merge.
 
---squash::
---no-squash::
+`--squash`::
+`--no-squash`::
 	Produce the working tree and index state as if a real merge
 	happened (except for the merge information), but do not actually
 	make a commit, move the `HEAD`, or record `$GIT_DIR/MERGE_HEAD`
@@ -103,12 +103,12 @@ option can be used to override `--squash`.
 +
 With `--squash`, `--commit` is not allowed, and will fail.
 
---no-verify::
+`--no-verify`::
 	This option bypasses the pre-merge and commit-msg hooks.
 	See also linkgit:githooks[5].
 
 -s <strategy>::
---strategy=<strategy>::
+`--strategy=<strategy>`::
 	Use the given merge strategy; can be supplied more than
 	once to specify them in the order they should be tried.
 	If there is no `-s` option, a built-in list of strategies
@@ -116,34 +116,34 @@ With `--squash`, `--commit` is not allowed, and will fail.
 	head, `git merge-octopus` otherwise).
 
 -X <option>::
---strategy-option=<option>::
+`--strategy-option=<option>`::
 	Pass merge strategy specific option through to the merge
 	strategy.
 
---verify-signatures::
---no-verify-signatures::
+`--verify-signatures`::
+`--no-verify-signatures`::
 	Verify that the tip commit of the side branch being merged is
 	signed with a valid key, i.e. a key that has a valid uid: in the
 	default trust model, this means the signing key has been signed by
 	a trusted key.  If the tip commit of the side branch is not signed
 	with a valid key, the merge is aborted.
 
---summary::
---no-summary::
+`--summary`::
+`--no-summary`::
 	Synonyms to `--stat` and `--no-stat`; these are deprecated and will be
 	removed in the future.
 
 ifndef::git-pull[]
--q::
---quiet::
+`-q`::
+`--quiet`::
 	Operate quietly. Implies `--no-progress`.
 
--v::
---verbose::
+`-v`::
+`--verbose`::
 	Be verbose.
 
---progress::
---no-progress::
+`--progress`::
+`--no-progress`::
 	Turn progress on/off explicitly. If neither is specified,
 	progress is shown if standard error is connected to a terminal.
 	Note that not all merge strategies may support progress
@@ -151,15 +151,15 @@ ifndef::git-pull[]
 
 endif::git-pull[]
 
---autostash::
---no-autostash::
+`--autostash`::
+`--no-autostash`::
 	Automatically create a temporary stash entry before the operation
 	begins, and apply it after the operation ends.  This means
 	that you can run the operation on a dirty worktree.  However, use
 	with care: the final stash application after a successful
 	merge might result in non-trivial conflicts.
 
---allow-unrelated-histories::
+`--allow-unrelated-histories`::
 	By default, `git merge` command refuses to merge histories
 	that do not share a common ancestor.  This option can be
 	used to override this safety when merging histories of two
diff --git a/Documentation/merge-strategies.txt b/Documentation/merge-strategies.txt
index 2912de706b..49162dfc20 100644
--- a/Documentation/merge-strategies.txt
+++ b/Documentation/merge-strategies.txt
@@ -6,14 +6,14 @@ backend 'merge strategies' to be chosen with `-s` option.  Some strategies
 can also take their own options, which can be passed by giving `-X<option>`
 arguments to `git merge` and/or `git pull`.
 
-resolve::
+`resolve`::
 	This can only resolve two heads (i.e. the current branch
 	and another branch you pulled from) using a 3-way merge
 	algorithm.  It tries to carefully detect criss-cross
 	merge ambiguities and is considered generally safe and
 	fast.
 
-recursive::
+`recursive`::
 	This can only resolve two heads using a 3-way merge
 	algorithm.  When there is more than one common
 	ancestor that can be used for 3-way merge, it creates a
@@ -29,7 +29,7 @@ recursive::
 +
 The 'recursive' strategy can take the following options:
 
-ours;;
+`ours`;;
 	This option forces conflicting hunks to be auto-resolved cleanly by
 	favoring 'our' version.  Changes from the other tree that do not
 	conflict with our side are reflected in the merge result.
@@ -39,11 +39,11 @@ This should not be confused with the 'ours' merge strategy, which does not
 even look at what the other tree contains at all.  It discards everything
 the other tree did, declaring 'our' history contains all that happened in it.
 
-theirs;;
+`theirs`;;
 	This is the opposite of 'ours'; note that, unlike 'ours', there is
 	no 'theirs' merge strategy to confuse this merge option with.
 
-patience;;
+`patience`;;
 	With this option, 'merge-recursive' spends a little extra time
 	to avoid mismerges that sometimes occur due to unimportant
 	matching lines (e.g., braces from distinct functions).  Use
@@ -56,10 +56,10 @@ diff-algorithm=[patience|minimal|histogram|myers];;
 	lines (such as braces from distinct functions).  See also
 	linkgit:git-diff[1] `--diff-algorithm`.
 
-ignore-space-change;;
-ignore-all-space;;
-ignore-space-at-eol;;
-ignore-cr-at-eol;;
+`ignore-space-change`;;
+`ignore-all-space`;;
+`ignore-space-at-eol`;;
+`ignore-cr-at-eol`;;
 	Treats lines with the indicated type of whitespace change as
 	unchanged for the sake of a three-way merge.  Whitespace
 	changes mixed with other changes to a line are not ignored.
@@ -72,7 +72,7 @@ ignore-cr-at-eol;;
   version includes a substantial change, 'their' version is used;
 * Otherwise, the merge proceeds in the usual way.
 
-renormalize;;
+`renormalize`;;
 	This runs a virtual check-out and check-in of all three stages
 	of a file when resolving a three-way merge.  This option is
 	meant to be used when merging branches with different clean
@@ -80,39 +80,39 @@ renormalize;;
 	branches with differing checkin/checkout attributes" in
 	linkgit:gitattributes[5] for details.
 
-no-renormalize;;
+`no-renormalize`;;
 	Disables the `renormalize` option.  This overrides the
 	`merge.renormalize` configuration variable.
 
-no-renames;;
+`no-renames`;;
 	Turn off rename detection. This overrides the `merge.renames`
 	configuration variable.
 	See also linkgit:git-diff[1] `--no-renames`.
 
-find-renames[=<n>];;
+`find-renames[=<n>]`;;
 	Turn on rename detection, optionally setting the similarity
 	threshold.  This is the default. This overrides the
 	'merge.renames' configuration variable.
 	See also linkgit:git-diff[1] `--find-renames`.
 
-rename-threshold=<n>;;
+`rename-threshold=<n>`;;
 	Deprecated synonym for `find-renames=<n>`.
 
-subtree[=<path>];;
+`subtree[=<path>]`;;
 	This option is a more advanced form of 'subtree' strategy, where
 	the strategy makes a guess on how two trees must be shifted to
 	match with each other when merging.  Instead, the specified path
 	is prefixed (or stripped from the beginning) to make the shape of
 	two trees to match.
 
-octopus::
+`octopus`::
 	This resolves cases with more than two heads, but refuses to do
 	a complex merge that needs manual resolution.  It is
 	primarily meant to be used for bundling topic branch
 	heads together.  This is the default merge strategy when
 	pulling or merging more than one branch.
 
-ours::
+`ours`::
 	This resolves any number of heads, but the resulting tree of the
 	merge is always that of the current branch head, effectively
 	ignoring all changes from all other branches.  It is meant to
@@ -120,7 +120,7 @@ ours::
 	branches.  Note that this is different from the -Xours option to
 	the 'recursive' merge strategy.
 
-subtree::
+`subtree`::
 	This is a modified recursive strategy. When merging trees A and
 	B, if B corresponds to a subtree of A, B is first adjusted to
 	match the tree structure of A, instead of reading the trees at
diff --git a/Documentation/pretty-options.txt b/Documentation/pretty-options.txt
index f055f56c37..ccb85eabc0 100644
--- a/Documentation/pretty-options.txt
+++ b/Documentation/pretty-options.txt
@@ -1,5 +1,5 @@
---pretty[=<format>]::
---format=<format>::
+`--pretty[=<format>]`::
+`--format=<format>`::
 
 	Pretty-print the contents of the commit logs in a given format,
 	where '<format>' can be one of 'oneline', 'short', 'medium',
@@ -14,7 +14,7 @@ format.  When '=<format>' part is omitted, it defaults to 'medium'.
 Note: you can specify the default pretty format in the repository
 configuration (see linkgit:git-config[1]).
 
---abbrev-commit::
+`--abbrev-commit`::
 	Instead of showing the full 40-byte hexadecimal commit object
 	name, show a prefix that names the object uniquely.
 	`--abbrev=<n>` (which also modifies diff output, if it is displayed)
@@ -23,16 +23,16 @@ configuration (see linkgit:git-config[1]).
 This should make `--pretty=oneline` a whole lot more readable for
 people using 80-column terminals.
 
---no-abbrev-commit::
+`--no-abbrev-commit`::
 	Show the full 40-byte hexadecimal commit object name. This negates
 	`--abbrev-commit`, either explicit or implied by other options such
 	as `--oneline`. It also overrides the `log.abbrevCommit` variable.
 
---oneline::
+`--oneline`::
 	This is a shorthand for `--pretty=oneline --abbrev-commit`
 	used together.
 
---encoding=<encoding>::
+`--encoding=<encoding>`::
 	The commit objects record the encoding used for the log message
 	in their encoding header; this option can be used to tell the
 	command to re-code the commit log message in the encoding
@@ -42,9 +42,9 @@ people using 80-column terminals.
 	verbatim; this means that invalid sequences in the original
 	commit may be copied to the output.
 
---expand-tabs=<n>::
---expand-tabs::
---no-expand-tabs::
+`--expand-tabs=<n>`::
+`--expand-tabs`::
+`--no-expand-tabs`::
 	Perform a tab expansion (replace each tab with enough spaces
 	to fill to the next display column that is multiple of '<n>')
 	in the log message before showing it in the output.
@@ -57,7 +57,7 @@ message by 4 spaces (i.e.  'medium', which is the default, 'full',
 and 'fuller').
 
 ifndef::git-rev-list[]
---notes[=<ref>]::
+`--notes[=<ref>]`::
 	Show the notes (see linkgit:git-notes[1]) that annotate the
 	commit, when showing the commit log message.  This is the default
 	for `git log`, `git show` and `git whatchanged` commands when
@@ -78,19 +78,19 @@ being displayed. Examples: `--notes=foo` will show only notes from
 `refs/notes/foo`; `--notes=foo --notes` will show both notes from
 `refs/notes/foo` and from the default notes ref(s).
 
---no-notes::
+`--no-notes`::
 	Do not show notes. This negates the above `--notes` option, by
 	resetting the list of notes refs from which notes are shown.
 	Options are parsed in the order given on the command line, so e.g.
 	`--notes --notes=foo --no-notes --notes=bar` will only show notes
 	from `refs/notes/bar`.
 
---show-notes[=<ref>]::
---[no-]standard-notes::
+`--show-notes[=<ref>]`::
+`--[no-]standard-notes`::
 	These options are deprecated. Use the above `--notes`/`--no-notes`
 	options instead.
 endif::git-rev-list[]
 
---show-signature::
+`--show-signature`::
 	Check the validity of a signed commit object by passing the signature
 	to `gpg --verify` and show the output.
diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
index fb491660d6..7053aa6170 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -13,44 +13,44 @@ has a line that matches `<pattern>`), unless otherwise noted.
 Note that these are applied before commit
 ordering and formatting options, such as `--reverse`.
 
--<number>::
+`-<number>`::
 -n <number>::
---max-count=<number>::
+`--max-count=<number>`::
 	Limit the number of commits to output.
 
---skip=<number>::
+`--skip=<number>`::
 	Skip 'number' commits before starting to show the commit output.
 
---since=<date>::
---after=<date>::
+`--since=<date>`::
+`--after=<date>`::
 	Show commits more recent than a specific date.
 
---until=<date>::
---before=<date>::
+`--until=<date>`::
+`--before=<date>`::
 	Show commits older than a specific date.
 
 ifdef::git-rev-list[]
---max-age=<timestamp>::
---min-age=<timestamp>::
+`--max-age=<timestamp>`::
+`--min-age=<timestamp>`::
 	Limit the commits output to specified time range.
 endif::git-rev-list[]
 
---author=<pattern>::
---committer=<pattern>::
+`--author=<pattern>`::
+`--committer=<pattern>`::
 	Limit the commits output to ones with author/committer
 	header lines that match the specified pattern (regular
 	expression).  With more than one `--author=<pattern>`,
 	commits whose author matches any of the given patterns are
 	chosen (similarly for multiple `--committer=<pattern>`).
 
---grep-reflog=<pattern>::
+`--grep-reflog=<pattern>`::
 	Limit the commits output to ones with reflog entries that
 	match the specified pattern (regular expression). With
 	more than one `--grep-reflog`, commits whose reflog message
 	matches any of the given patterns are chosen.  It is an
 	error to use this option unless `--walk-reflogs` is in use.
 
---grep=<pattern>::
+`--grep=<pattern>`::
 	Limit the commits output to ones with log message that
 	matches the specified pattern (regular expression).  With
 	more than one `--grep=<pattern>`, commits whose message
@@ -62,35 +62,35 @@ When `--notes` is in effect, the message from the notes is
 matched as if it were part of the log message.
 endif::git-rev-list[]
 
---all-match::
+`--all-match`::
 	Limit the commits output to ones that match all given `--grep`,
 	instead of ones that match at least one.
 
---invert-grep::
+`--invert-grep`::
 	Limit the commits output to ones with log message that do not
 	match the pattern specified with `--grep=<pattern>`.
 
--i::
---regexp-ignore-case::
+`-i`::
+`--regexp-ignore-case`::
 	Match the regular expression limiting patterns without regard to letter
 	case.
 
---basic-regexp::
+`--basic-regexp`::
 	Consider the limiting patterns to be basic regular expressions;
 	this is the default.
 
--E::
---extended-regexp::
+`-E`::
+`--extended-regexp`::
 	Consider the limiting patterns to be extended regular expressions
 	instead of the default basic regular expressions.
 
--F::
---fixed-strings::
+`-F`::
+`--fixed-strings`::
 	Consider the limiting patterns to be fixed strings (don't interpret
 	pattern as a regular expression).
 
--P::
---perl-regexp::
+`-P`::
+`--perl-regexp`::
 	Consider the limiting patterns to be Perl-compatible regular
 	expressions.
 +
@@ -98,20 +98,20 @@ Support for these types of regular expressions is an optional
 compile-time dependency. If Git wasn't compiled with support for them
 providing this option will cause it to die.
 
---remove-empty::
+`--remove-empty`::
 	Stop when a given path disappears from the tree.
 
---merges::
+`--merges`::
 	Print only merge commits. This is exactly the same as `--min-parents=2`.
 
---no-merges::
+`--no-merges`::
 	Do not print commits with more than one parent. This is
 	exactly the same as `--max-parents=1`.
 
---min-parents=<number>::
---max-parents=<number>::
---no-min-parents::
---no-max-parents::
+`--min-parents=<number>`::
+`--max-parents=<number>`::
+`--no-min-parents`::
+`--no-max-parents`::
 	Show only commits which have at least (or at most) that many parent
 	commits. In particular, `--max-parents=1` is the same as `--no-merges`,
 	`--min-parents=2` is the same as `--merges`.  `--max-parents=0`
@@ -121,7 +121,7 @@ providing this option will cause it to die.
 again.  Equivalent forms are `--min-parents=0` (any commit has 0 or more
 parents) and `--max-parents=-1` (negative numbers denote no upper limit).
 
---first-parent::
+`--first-parent`::
 	Follow only the first parent commit upon seeing a merge
 	commit.  This option can give a better overview when
 	viewing the evolution of a particular topic branch,
@@ -135,39 +135,39 @@ This option also changes default diff format for merge commits
 to `first-parent`, see `--diff-merges=first-parent` for details.
 endif::git-log[]
 
---not::
+`--not`::
 	Reverses the meaning of the '{caret}' prefix (or lack thereof)
 	for all following revision specifiers, up to the next `--not`.
 
---all::
+`--all`::
 	Pretend as if all the refs in `refs/`, along with `HEAD`, are
 	listed on the command line as '<commit>'.
 
---branches[=<pattern>]::
+`--branches[=<pattern>]`::
 	Pretend as if all the refs in `refs/heads` are listed
 	on the command line as '<commit>'. If '<pattern>' is given, limit
 	branches to ones matching given shell glob. If pattern lacks '?',
 	'{asterisk}', or '[', '/{asterisk}' at the end is implied.
 
---tags[=<pattern>]::
+`--tags[=<pattern>]`::
 	Pretend as if all the refs in `refs/tags` are listed
 	on the command line as '<commit>'. If '<pattern>' is given, limit
 	tags to ones matching given shell glob. If pattern lacks '?', '{asterisk}',
 	or '[', '/{asterisk}' at the end is implied.
 
---remotes[=<pattern>]::
+`--remotes[=<pattern>]`::
 	Pretend as if all the refs in `refs/remotes` are listed
 	on the command line as '<commit>'. If '<pattern>' is given, limit
 	remote-tracking branches to ones matching given shell glob.
 	If pattern lacks '?', '{asterisk}', or '[', '/{asterisk}' at the end is implied.
 
---glob=<glob-pattern>::
+`--glob=<glob-pattern>`::
 	Pretend as if all the refs matching shell glob '<glob-pattern>'
 	are listed on the command line as '<commit>'. Leading `refs/`,
 	is automatically prepended if missing. If pattern lacks '?', '{asterisk}',
 	or '[', '/{asterisk}' at the end is implied.
 
---exclude=<glob-pattern>::
+`--exclude=<glob-pattern>`::
 
 	Do not include refs matching '<glob-pattern>' that the next `--all`,
 	`--branches`, `--tags`, `--remotes`, or `--glob` would otherwise
@@ -182,11 +182,11 @@ respectively, and they must begin with `refs/` when applied to `--glob`
 or `--all`. If a trailing '/{asterisk}' is intended, it must be given
 explicitly.
 
---reflog::
+`--reflog`::
 	Pretend as if all objects mentioned by reflogs are listed on the
 	command line as `<commit>`.
 
---alternate-refs::
+`--alternate-refs`::
 	Pretend as if all objects mentioned as ref tips of alternate
 	repositories were listed on the command line. An alternate
 	repository is any repository whose object directory is specified
@@ -194,7 +194,7 @@ explicitly.
 	be modified by `core.alternateRefsCommand`, etc. See
 	linkgit:git-config[1].
 
---single-worktree::
+`--single-worktree`::
 	By default, all working trees will be examined by the
 	following options when there are more than one (see
 	linkgit:git-worktree[1]): `--all`, `--reflog` and
@@ -202,33 +202,33 @@ explicitly.
 	This option forces them to examine the current working tree
 	only.
 
---ignore-missing::
+`--ignore-missing`::
 	Upon seeing an invalid object name in the input, pretend as if
 	the bad input was not given.
 
 ifndef::git-rev-list[]
---bisect::
+`--bisect`::
 	Pretend as if the bad bisection ref `refs/bisect/bad`
 	was listed and as if it was followed by `--not` and the good
 	bisection refs `refs/bisect/good-*` on the command
 	line.
 endif::git-rev-list[]
 
---stdin::
+`--stdin`::
 	In addition to the '<commit>' listed on the command
 	line, read them from the standard input. If a `--` separator is
 	seen, stop reading commits and start reading paths to limit the
 	result.
 
 ifdef::git-rev-list[]
---quiet::
+`--quiet`::
 	Don't print anything to standard output.  This form
 	is primarily meant to allow the caller to
 	test the exit status to see if a range of objects is fully
 	connected (or not).  It is faster than redirecting stdout
 	to `/dev/null` as the output does not have to be formatted.
 
---disk-usage::
+`--disk-usage`::
 	Suppress normal output; instead, print the sum of the bytes used
 	for on-disk storage by the selected commits or objects. This is
 	equivalent to piping the output into `git cat-file
@@ -238,11 +238,11 @@ ifdef::git-rev-list[]
 	"on-disk storage" means.
 endif::git-rev-list[]
 
---cherry-mark::
+`--cherry-mark`::
 	Like `--cherry-pick` (see below) but mark equivalent commits
 	with `=` rather than omitting them, and inequivalent ones with `+`.
 
---cherry-pick::
+`--cherry-pick`::
 	Omit any commit that introduces the same change as
 	another commit on the ``other side'' when the set of
 	commits are limited with symmetric difference.
@@ -255,8 +255,8 @@ cherry-picked from the other branch (for example, ``3rd on b'' may be
 cherry-picked from branch `A`). With this option, such pairs of commits are
 excluded from the output.
 
---left-only::
---right-only::
+`--left-only`::
+`--right-only`::
 	List only commits on the respective side of a symmetric difference,
 	i.e. only those which would be marked `<` resp. `>` by
 	`--left-right`.
@@ -267,15 +267,15 @@ commits from `B` which are in `A` or are patch-equivalent to a commit in
 More precisely, `--cherry-pick --right-only --no-merges` gives the exact
 list.
 
---cherry::
+`--cherry`::
 	A synonym for `--right-only --cherry-mark --no-merges`; useful to
 	limit the output to the commits on our side and mark those that
 	have been applied to the other side of a forked history with
 	`git log --cherry upstream...mybranch`, similar to
 	`git cherry upstream mybranch`.
 
--g::
---walk-reflogs::
+`-g`::
+`--walk-reflogs`::
 	Instead of walking the commit ancestry chain, walk
 	reflog entries from the most recent one to older ones.
 	When this option is used you cannot specify commits to
@@ -309,22 +309,22 @@ See also linkgit:git-reflog[1].
 +
 Under `--pretty=reference`, this information will not be shown at all.
 
---merge::
+`--merge`::
 	After a failed merge, show refs that touch files having a
 	conflict and don't exist on all heads to merge.
 
---boundary::
+`--boundary`::
 	Output excluded boundary commits. Boundary commits are
 	prefixed with `-`.
 
 ifdef::git-rev-list[]
---use-bitmap-index::
+`--use-bitmap-index`::
 
 	Try to speed up the traversal using the pack bitmap index (if
 	one is available). Note that when traversing with `--objects`,
 	trees and blobs will not have their associated path printed.
 
---progress=<header>::
+`--progress=<header>`::
 	Show progress reports on stderr as objects are considered. The
 	`<header>` text will be printed with each progress update.
 endif::git-rev-list[]
@@ -339,10 +339,10 @@ is how to do it, as there are various strategies to simplify the history.
 
 The following options select the commits to be shown:
 
-<paths>::
+`<paths>`::
 	Commits modifying the given <paths> are selected.
 
---simplify-by-decoration::
+`--simplify-by-decoration`::
 	Commits that are referred by some branch or tag are selected.
 
 Note that extra commits can be shown to give a meaningful history.
@@ -355,28 +355,28 @@ Default mode::
 	branches if the end result is the same (i.e. merging branches
 	with the same content)
 
---show-pulls::
+`--show-pulls`::
 	Include all commits from the default mode, but also any merge
 	commits that are not TREESAME to the first parent but are
 	TREESAME to a later parent. This mode is helpful for showing
 	the merge commits that "first introduced" a change to a branch.
 
---full-history::
+`--full-history`::
 	Same as the default mode, but does not prune some history.
 
---dense::
+`--dense`::
 	Only the selected commits are shown, plus some to have a
 	meaningful history.
 
---sparse::
+`--sparse`::
 	All commits in the simplified history are shown.
 
---simplify-merges::
+`--simplify-merges`::
 	Additional option to `--full-history` to remove some needless
 	merges from the resulting history, as there are no selected
 	commits contributing to this merge.
 
---ancestry-path::
+`--ancestry-path`::
 	When given a range of commits to display (e.g. 'commit1..commit2'
 	or 'commit2 {caret}commit1'), only display commits that exist
 	directly on the ancestry chain between the 'commit1' and
@@ -497,18 +497,18 @@ rewritten to contain `E`'s parent `I`.  The same happened for `C` and
 In addition to the above settings, you can change whether TREESAME
 affects inclusion:
 
---dense::
+`--dense`::
 	Commits that are walked are included if they are not TREESAME
 	to any parent.
 
---sparse::
+`--sparse`::
 	All commits that are walked are included.
 +
 Note that without `--full-history`, this still simplifies merges: if
 one of the parents is TREESAME, we follow only that one, so the other
 sides of the merge are never walked.
 
---simplify-merges::
+`--simplify-merges`::
 	First, build a history graph in the same way that
 	`--full-history` with parent rewriting does (see above).
 +
@@ -555,7 +555,7 @@ Note the major differences in `N`, `P`, and `Q` over `--full-history`:
 
 There is another simplification mode available:
 
---ancestry-path::
+`--ancestry-path`::
 	Limit the displayed commits to those directly on the ancestry
 	chain between the ``from'' and ``to'' commits in the given commit
 	range. I.e. only display commits that are ancestor of the ``to''
@@ -685,7 +685,7 @@ into the important branch. This commit may have information about why
 the change `X` came to override the changes from `A` and `B` in its
 commit message.
 
---show-pulls::
+`--show-pulls`::
 	In addition to the commits shown in the default history, show
 	each merge commit that is not TREESAME to its first parent but
 	is TREESAME to a later parent.
@@ -734,7 +734,7 @@ ifdef::git-rev-list[]
 Bisection Helpers
 ~~~~~~~~~~~~~~~~~
 
---bisect::
+`--bisect`::
 	Limit output to the one commit object which is roughly halfway between
 	included and excluded commits. Note that the bad bisection ref
 	`refs/bisect/bad` is added to the included commits (if it
@@ -758,7 +758,7 @@ introduces a regression is thus reduced to a binary search: repeatedly
 generate and test new 'midpoint's until the commit chain is of length
 one.
 
---bisect-vars::
+`--bisect-vars`::
 	This calculates the same as `--bisect`, except that refs in
 	`refs/bisect/` are not used, and except that this outputs
 	text ready to be eval'ed by the shell. These lines will assign the
@@ -770,7 +770,7 @@ one.
 	`bisect_bad`, and the number of commits we are bisecting right now to
 	`bisect_all`.
 
---bisect-all::
+`--bisect-all`::
 	This outputs all the commit objects between the included and excluded
 	commits, ordered by their distance to the included and excluded
 	commits. Refs in `refs/bisect/` are not used. The farthest
@@ -793,15 +793,15 @@ Commit Ordering
 
 By default, the commits are shown in reverse chronological order.
 
---date-order::
+`--date-order`::
 	Show no parents before all of its children are shown, but
 	otherwise show commits in the commit timestamp order.
 
---author-date-order::
+`--author-date-order`::
 	Show no parents before all of its children are shown, but
 	otherwise show commits in the author timestamp order.
 
---topo-order::
+`--topo-order`::
 	Show no parents before all of its children are shown, and
 	avoid showing commits on multiple lines of history
 	intermixed.
@@ -825,7 +825,7 @@ With `--topo-order`, they would show 8 6 5 3 7 4 2 1 (or 8 7 4 2 6 5
 avoid showing the commits from two parallel development track mixed
 together.
 
---reverse::
+`--reverse`::
 	Output the commits chosen to be shown (see Commit Limiting
 	section above) in reverse order. Cannot be combined with
 	`--walk-reflogs`.
@@ -838,49 +838,49 @@ Object Traversal
 These options are mostly targeted for packing of Git repositories.
 
 ifdef::git-rev-list[]
---objects::
+`--objects`::
 	Print the object IDs of any object referenced by the listed
 	commits.  `--objects foo ^bar` thus means ``send me
 	all object IDs which I need to download if I have the commit
 	object _bar_ but not _foo_''.
 
---in-commit-order::
+`--in-commit-order`::
 	Print tree and blob ids in order of the commits. The tree
 	and blob ids are printed after they are first referenced
 	by a commit.
 
---objects-edge::
+`--objects-edge`::
 	Similar to `--objects`, but also print the IDs of excluded
 	commits prefixed with a ``-'' character.  This is used by
 	linkgit:git-pack-objects[1] to build a ``thin'' pack, which records
 	objects in deltified form based on objects contained in these
 	excluded commits to reduce network traffic.
 
---objects-edge-aggressive::
+`--objects-edge-aggressive`::
 	Similar to `--objects-edge`, but it tries harder to find excluded
 	commits at the cost of increased time.  This is used instead of
 	`--objects-edge` to build ``thin'' packs for shallow repositories.
 
---indexed-objects::
+`--indexed-objects`::
 	Pretend as if all trees and blobs used by the index are listed
 	on the command line.  Note that you probably want to use
 	`--objects`, too.
 
---unpacked::
+`--unpacked`::
 	Only useful with `--objects`; print the object IDs that are not
 	in packs.
 
---object-names::
+`--object-names`::
 	Only useful with `--objects`; print the names of the object IDs
 	that are found. This is the default behavior.
 
---no-object-names::
+`--no-object-names`::
 	Only useful with `--objects`; does not print the names of the object
 	IDs that are found. This inverts `--object-names`. This flag allows
 	the output to be more easily parsed by commands such as
 	linkgit:git-cat-file[1].
 
---filter=<filter-spec>::
+`--filter=<filter-spec>`::
 	Only useful with one of the `--objects*`; omits objects (usually
 	blobs) from the list of printed objects.  The '<filter-spec>'
 	may be one of the following:
@@ -927,14 +927,14 @@ Other arbitrary characters can also be encoded. For instance,
 'combine:tree:3+blob:none' and 'combine:tree%3A3+blob%3Anone' are
 equivalent.
 
---no-filter::
+`--no-filter`::
 	Turn off any previous `--filter=` argument.
 
---filter-print-omitted::
+`--filter-print-omitted`::
 	Only useful with `--filter=`; prints a list of the objects omitted
 	by the filter.  Object IDs are prefixed with a ``~'' character.
 
---missing=<missing-action>::
+`--missing=<missing-action>`::
 	A debug option to help with future "partial clone" development.
 	This option specifies how missing objects are handled.
 +
@@ -952,7 +952,7 @@ Unexpected missing objects will raise an error.
 The form `--missing=print` is like 'allow-any', but will also print a
 list of the missing objects.  Object IDs are prefixed with a ``?'' character.
 
---exclude-promisor-objects::
+`--exclude-promisor-objects`::
 	(For internal use only.)  Prefilter object traversal at
 	promisor boundary.  This is used with partial clone.  This is
 	stronger than `--missing=allow-promisor` because it limits the
@@ -969,7 +969,7 @@ endif::git-rev-list[]
 	by commit time.
 	Cannot be combined with `--graph`.
 
---do-walk::
+`--do-walk`::
 	Overrides a previous `--no-walk`.
 endif::git-shortlog[]
 
@@ -985,10 +985,10 @@ endif::git-rev-list[]
 
 include::pretty-options.txt[]
 
---relative-date::
+`--relative-date`::
 	Synonym for `--date=relative`.
 
---date=<format>::
+`--date=<format>`::
 	Only takes effect for dates shown in human-readable format, such
 	as when using `--pretty`. `log.date` config variable sets a default
 	value for the log command's `--date` option. By default, dates
@@ -1053,25 +1053,25 @@ format placeholders. When using `-local`, the correct syntax is
 	- the time zone is omitted when the local time zone is used
 
 ifdef::git-rev-list[]
---header::
+`--header`::
 	Print the contents of the commit in raw-format; each record is
 	separated with a NUL character.
 endif::git-rev-list[]
 
---parents::
+`--parents`::
 	Print also the parents of the commit (in the form "commit parent...").
 	Also enables parent rewriting, see 'History Simplification' above.
 
---children::
+`--children`::
 	Print also the children of the commit (in the form "commit child...").
 	Also enables parent rewriting, see 'History Simplification' above.
 
 ifdef::git-rev-list[]
---timestamp::
+`--timestamp`::
 	Print the raw commit timestamp.
 endif::git-rev-list[]
 
---left-right::
+`--left-right`::
 	Mark which side of a symmetric difference a commit is reachable from.
 	Commits from the left side are prefixed with `<` and those from
 	the right with `>`.  If combined with `--boundary`, those
@@ -1100,7 +1100,7 @@ you would get an output like this:
 	-xxxxxxx... 1st on a
 -----------------------------------------------------------------------
 
---graph::
+`--graph`::
 	Draw a text-based graphical representation of the commit history
 	on the left hand side of the output.  This may cause extra lines
 	to be printed in between commits, in order for the graph history
@@ -1112,7 +1112,7 @@ This enables parent rewriting, see 'History Simplification' above.
 This implies the `--topo-order` option by default, but the
 `--date-order` option may also be specified.
 
---show-linear-break[=<barrier>]::
+`--show-linear-break[=<barrier>]`::
 	When `--graph` is not used, all history branches are flattened
 	which can make it hard to see that the two consecutive commits
 	do not belong to a linear branch. This option puts a barrier
@@ -1120,7 +1120,7 @@ This implies the `--topo-order` option by default, but the
 	is the string that will be shown instead of the default one.
 
 ifdef::git-rev-list[]
---count::
+`--count`::
 	Print a number stating how many commits would have been
 	listed, and suppress all other output.  When used together
 	with `--left-right`, instead print the counts for left and
diff --git a/Documentation/sequencer.txt b/Documentation/sequencer.txt
index 3bceb56474..093d09fcaf 100644
--- a/Documentation/sequencer.txt
+++ b/Documentation/sequencer.txt
@@ -1,16 +1,16 @@
---continue::
+`--continue`::
 	Continue the operation in progress using the information in
 	`.git/sequencer`.  Can be used to continue after resolving
 	conflicts in a failed cherry-pick or revert.
 
---skip::
+`--skip`::
 	Skip the current commit and continue with the rest of the
 	sequence.
 
---quit::
+`--quit`::
 	Forget about the current operation in progress.  Can be used
 	to clear the sequencer state after a failed cherry-pick or
 	revert.
 
---abort::
+`--abort`::
 	Cancel the operation and return to the pre-sequence state.
diff --git a/Documentation/signoff-option.txt b/Documentation/signoff-option.txt
index 597d057c6e..08daf5d568 100644
--- a/Documentation/signoff-option.txt
+++ b/Documentation/signoff-option.txt
@@ -1,8 +1,8 @@
 ifdef::git-commit[]
--s::
+`-s`::
 endif::git-commit[]
---signoff::
---no-signoff::
+`--signoff`::
+`--no-signoff`::
 	Add a `Signed-off-by` trailer by the committer at the end of the commit
 	log message.  The meaning of a signoff depends on the project
 	to which you're committing.  For example, it may certify that
-- 
2.31.1.133.g84d06cdc06

