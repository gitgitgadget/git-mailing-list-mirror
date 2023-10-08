Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E29D8E95A67
	for <git@archiver.kernel.org>; Sun,  8 Oct 2023 06:46:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344527AbjJHGqC (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 8 Oct 2023 02:46:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344501AbjJHGpn (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Oct 2023 02:45:43 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BC45F7
        for <git@vger.kernel.org>; Sat,  7 Oct 2023 23:45:37 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-3248ac76acbso3146012f8f.1
        for <git@vger.kernel.org>; Sat, 07 Oct 2023 23:45:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696747535; x=1697352335; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eb+nMcDNGfUSTyplbBd8hsehlpXi2MGnaG1hjAiH6Ac=;
        b=Cb+FBVikoc69L82SWwHaxNNa4UqIZEID/LvtlTHcAnR5/fMF2q/2jM2fiECT3WoJHf
         duZqKYUoj6/3vwEnRT4FBCIzYOqPX+Dcj74gDjsYdlAfNOLGkO4D9ImYf9OCjpweQxh0
         5Ih20ZdW8XDTHlWGMhUySFFYBS8umv3ni/Pk/c2NxZwIp78gSwli/wiPT/V8UgeNUqz4
         R7d4XEMSsslRVJQ1id6mT+3z5kqNhjX4X2npeVk10jtD+0FiaLVmjIbgbRZoqIagkKYk
         Q3bU4m8uNFP7o/dTBfY3IpsZ8T77wcUwgg96SLS5S1xgm/wbpx6ok51IzcIevLXuinEt
         B0gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696747535; x=1697352335;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eb+nMcDNGfUSTyplbBd8hsehlpXi2MGnaG1hjAiH6Ac=;
        b=T1NmvuofCjTwMrd6Zpbnl3vFaYGPb/KqnPGY4iaUPdfWwUHHklJdEb/TnDITgyvMjc
         Cx078b5ywd30mm21paRSqcwflVDxzlGe3Hn4uQ7jkflBQwj4f/x0jvbGNY0RokmZY7n6
         gO8adDCLhQf1Y8HGdUQaxe1EyajwTMfdA9BGEatO32MhTThgE4hJaU+fqTq6gVU7pVoC
         jbyS/9v2RnDm5UqaHibxrdXkGJE4Ef3emUR+4qEOdJunzKD1KAk6Mthp/z+eGWIzeeYS
         yGhS3uL24/wXFbYLOlAy8wetMBXQa/7v74N/G6wZHHWu/gY6KcO767uygEtSJ5Jz4aTo
         LIzg==
X-Gm-Message-State: AOJu0YxPSzEJcKTQshrBT+gCoC3Ka6nIOOb8Zf6i7CPyOubs5d6YzRbs
        uBs2vUITjHc3+yQ2venVYAHq5jsdeJ8=
X-Google-Smtp-Source: AGHT+IHlW7vBcl7fbW/PgfThy3LJSGZ7DJNxd8ODVUyEvVTUEbgyO26ZYawUflS32773okQDET0VVQ==
X-Received: by 2002:adf:ea52:0:b0:320:b24:4361 with SMTP id j18-20020adfea52000000b003200b244361mr10665811wrn.34.1696747535105;
        Sat, 07 Oct 2023 23:45:35 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v6-20020adff686000000b0031980294e9fsm5947061wrp.116.2023.10.07.23.45.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Oct 2023 23:45:34 -0700 (PDT)
Message-ID: <36861d13e4ea36c34b3aa57b30092004f63f02f5.1696747529.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1595.git.1696747527.gitgitgadget@gmail.com>
References: <pull.1595.git.1696747527.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 08 Oct 2023 06:45:09 +0000
Subject: [PATCH 07/25] documentation: fix subject/verb agreement
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Diff best viewed with --color-diff.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 Documentation/CodingGuidelines                        | 2 +-
 Documentation/config/advice.txt                       | 2 +-
 Documentation/config/alias.txt                        | 2 +-
 Documentation/config/fsck.txt                         | 2 +-
 Documentation/config/gpg.txt                          | 2 +-
 Documentation/config/maintenance.txt                  | 2 +-
 Documentation/config/status.txt                       | 2 +-
 Documentation/fetch-options.txt                       | 2 +-
 Documentation/git-blame.txt                           | 2 +-
 Documentation/git-diff-tree.txt                       | 2 +-
 Documentation/git-format-patch.txt                    | 2 +-
 Documentation/git-fsck.txt                            | 4 ++--
 Documentation/git-init.txt                            | 2 +-
 Documentation/git-rev-list.txt                        | 2 +-
 Documentation/git-show-ref.txt                        | 2 +-
 Documentation/git-symbolic-ref.txt                    | 2 +-
 Documentation/gitdiffcore.txt                         | 2 +-
 Documentation/gitformat-bundle.txt                    | 2 +-
 Documentation/gitprotocol-capabilities.txt            | 2 +-
 Documentation/gitprotocol-pack.txt                    | 4 ++--
 Documentation/glossary-content.txt                    | 2 +-
 Documentation/howto/coordinate-embargoed-releases.txt | 2 +-
 Documentation/i18n.txt                                | 2 +-
 Documentation/technical/api-simple-ipc.txt            | 2 +-
 Documentation/technical/reftable.txt                  | 4 ++--
 25 files changed, 28 insertions(+), 28 deletions(-)

diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuidelines
index 99b22ff2345..c494e07460e 100644
--- a/Documentation/CodingGuidelines
+++ b/Documentation/CodingGuidelines
@@ -40,7 +40,7 @@ As for more concrete guidelines, just imitate the existing code
 contributing to). It is always preferable to match the _local_
 convention. New code added to Git suite is expected to match
 the overall style of existing code. Modifications to existing
-code is expected to match the style the surrounding code already
+code are expected to match the style the surrounding code already
 uses (even if it doesn't match the overall style of existing code).
 
 But if you must have a list of rules, here are some language
diff --git a/Documentation/config/advice.txt b/Documentation/config/advice.txt
index f4864a2d58b..f524af4e899 100644
--- a/Documentation/config/advice.txt
+++ b/Documentation/config/advice.txt
@@ -5,7 +5,7 @@ advice.*::
 +
 --
 	ambiguousFetchRefspec::
-		Advice shown when fetch refspec for multiple remotes map to
+		Advice shown when fetch refspec for multiple remotes maps to
 		the same remote-tracking branch namespace and causes branch
 		tracking set-up to fail.
 	fetchShowForcedUpdates::
diff --git a/Documentation/config/alias.txt b/Documentation/config/alias.txt
index f1ca739d574..01df96fab3d 100644
--- a/Documentation/config/alias.txt
+++ b/Documentation/config/alias.txt
@@ -4,7 +4,7 @@ alias.*::
 	`git last` is equivalent to `git cat-file commit HEAD`. To avoid
 	confusion and troubles with script usage, aliases that
 	hide existing Git commands are ignored. Arguments are split by
-	spaces, the usual shell quoting and escaping is supported.
+	spaces, the usual shell quoting and escaping are supported.
 	A quote pair or a backslash can be used to quote them.
 +
 Note that the first word of an alias does not necessarily have to be a
diff --git a/Documentation/config/fsck.txt b/Documentation/config/fsck.txt
index 9b167575530..0687e86ba10 100644
--- a/Documentation/config/fsck.txt
+++ b/Documentation/config/fsck.txt
@@ -44,7 +44,7 @@ fsck.skipList::
 	The path to a list of object names (i.e. one unabbreviated SHA-1 per
 	line) that are known to be broken in a non-fatal way and should
 	be ignored. On versions of Git 2.20 and later comments ('#'), empty
-	lines, and any leading and trailing whitespace is ignored. Everything
+	lines, and any leading and trailing whitespace are ignored. Everything
 	but a SHA-1 per line will error out on older versions.
 +
 This feature is useful when an established project should be accepted
diff --git a/Documentation/config/gpg.txt b/Documentation/config/gpg.txt
index 248d99d70b8..5cf32b179dc 100644
--- a/Documentation/config/gpg.txt
+++ b/Documentation/config/gpg.txt
@@ -25,7 +25,7 @@ gpg.<format>.program::
 gpg.minTrustLevel::
 	Specifies a minimum trust level for signature verification.  If
 	this option is unset, then signature verification for merge
-	operations require a key with at least `marginal` trust.  Other
+	operations requires a key with at least `marginal` trust.  Other
 	operations that perform signature verification require a key
 	with at least `undefined` trust.  Setting this option overrides
 	the required trust-level for all operations.  Supported values,
diff --git a/Documentation/config/maintenance.txt b/Documentation/config/maintenance.txt
index 18f05621314..69a4f05153e 100644
--- a/Documentation/config/maintenance.txt
+++ b/Documentation/config/maintenance.txt
@@ -12,7 +12,7 @@ maintenance.strategy::
 	then that value is used instead of the one provided by
 	`maintenance.strategy`. The possible strategy strings are:
 +
-* `none`: This default setting implies no task are run at any schedule.
+* `none`: This default setting implies no tasks are run at any schedule.
 * `incremental`: This setting optimizes for performing small maintenance
   activities that do not delete any data. This does not schedule the `gc`
   task, but runs the `prefetch` and `commit-graph` tasks hourly, the
diff --git a/Documentation/config/status.txt b/Documentation/config/status.txt
index 0fc704ab80b..f0336938cbc 100644
--- a/Documentation/config/status.txt
+++ b/Documentation/config/status.txt
@@ -47,7 +47,7 @@ status.showUntrackedFiles::
 	contain only untracked files, are shown with the directory name
 	only. Showing untracked files means that Git needs to lstat() all
 	the files in the whole repository, which might be slow on some
-	systems. So, this variable controls how the commands displays
+	systems. So, this variable controls how the commands display
 	the untracked files. Possible values are:
 +
 --
diff --git a/Documentation/fetch-options.txt b/Documentation/fetch-options.txt
index 41fc7ca3c67..9ee9fa659d2 100644
--- a/Documentation/fetch-options.txt
+++ b/Documentation/fetch-options.txt
@@ -43,7 +43,7 @@ the current repository has the same history as the source repository.
 --update-shallow::
 	By default when fetching from a shallow repository,
 	`git fetch` refuses refs that require updating
-	.git/shallow. This option updates .git/shallow and accept such
+	.git/shallow. This option updates .git/shallow and accepts such
 	refs.
 
 --negotiation-tip=<commit|glob>::
diff --git a/Documentation/git-blame.txt b/Documentation/git-blame.txt
index f69a871a96f..a927c7c9f33 100644
--- a/Documentation/git-blame.txt
+++ b/Documentation/git-blame.txt
@@ -128,7 +128,7 @@ at least once for each commit:
 - the filename in the commit that the line is attributed to.
 - the first line of the commit log message ("summary").
 
-The contents of the actual line is output after the above
+The contents of the actual line are output after the above
 header, prefixed by a TAB. This is to allow adding more
 header elements later.
 
diff --git a/Documentation/git-diff-tree.txt b/Documentation/git-diff-tree.txt
index 37ca32c396f..1e34f80daa9 100644
--- a/Documentation/git-diff-tree.txt
+++ b/Documentation/git-diff-tree.txt
@@ -107,7 +107,7 @@ include::pretty-options.txt[]
 	by omitting uninteresting hunks whose contents in the parents
 	have only two variants and the merge result picks one of them
 	without modification.  When all hunks are uninteresting, the commit
-	itself and the commit log message is not shown, just like in any other
+	itself and the commit log message are not shown, just like in any other
 	"empty diff" case.
 
 --combined-all-paths::
diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
index 711823a7f4e..aaafce24be2 100644
--- a/Documentation/git-format-patch.txt
+++ b/Documentation/git-format-patch.txt
@@ -55,7 +55,7 @@ A "message" generated by the command consists of three parts:
 * The "patch", which is the "diff -p --stat" output (see
   linkgit:git-diff[1]) between the commit and its parent.
 
-The log message and the patch is separated by a line with a
+The log message and the patch are separated by a line with a
 three-dash line.
 
 There are two ways to specify which commits to operate on.
diff --git a/Documentation/git-fsck.txt b/Documentation/git-fsck.txt
index b6a0f8a085c..e4980d28615 100644
--- a/Documentation/git-fsck.txt
+++ b/Documentation/git-fsck.txt
@@ -64,7 +64,7 @@ index file, all SHA-1 references in `refs` namespace, and all reflogs
 --connectivity-only::
 	Check only the connectivity of reachable objects, making sure
 	that any objects referenced by a reachable tag, commit, or tree
-	is present. This speeds up the operation by avoiding reading
+	are present. This speeds up the operation by avoiding reading
 	blobs entirely (though it does still check that referenced blobs
 	exist). This will detect corruption in commits and trees, but
 	not do any semantic checks (e.g., for format errors). Corruption
@@ -79,7 +79,7 @@ care about this output and want to speed it up further.
 	recorded with g+w bit set, which was created by older
 	versions of Git.  Existing repositories, including the
 	Linux kernel, Git itself, and sparse repository have old
-	objects that triggers this check, but it is recommended
+	objects that trigger this check, but it is recommended
 	to check new projects with this flag.
 
 --verbose::
diff --git a/Documentation/git-init.txt b/Documentation/git-init.txt
index 30ab86ab96a..138dc4a3bfe 100644
--- a/Documentation/git-init.txt
+++ b/Documentation/git-init.txt
@@ -115,7 +115,7 @@ Same as 'group', but make the repository readable by all users.
 '<perm>' is a 3-digit octal number prefixed with `0` and each file
 will have mode '<perm>'. '<perm>' will override users' umask(2)
 value (and not only loosen permissions as 'group' and 'all'
-does). '0640' will create a repository which is group-readable, but
+do). '0640' will create a repository which is group-readable, but
 not group-writable or accessible to others. '0660' will create a repo
 that is readable and writable to the current user and group, but
 inaccessible to others (directories and executable files get their
diff --git a/Documentation/git-rev-list.txt b/Documentation/git-rev-list.txt
index fbe913ee746..2e05c4b5109 100644
--- a/Documentation/git-rev-list.txt
+++ b/Documentation/git-rev-list.txt
@@ -19,7 +19,7 @@ include::rev-list-description.txt[]
 
 'rev-list' is an essential Git command, since it
 provides the ability to build and traverse commit ancestry graphs. For
-this reason, it has a lot of different options that enables it to be
+this reason, it has a lot of different options that enable it to be
 used by commands as different as 'git bisect' and
 'git repack'.
 
diff --git a/Documentation/git-show-ref.txt b/Documentation/git-show-ref.txt
index 2fe274b8faa..36e81b9dec4 100644
--- a/Documentation/git-show-ref.txt
+++ b/Documentation/git-show-ref.txt
@@ -144,7 +144,7 @@ use:
 -----------------------------------------------------------------------------
 
 This will show "refs/heads/master" but also "refs/remote/other-repo/master",
-if such references exists.
+if such references exist.
 
 When using the `--verify` flag, the command requires an exact path:
 
diff --git a/Documentation/git-symbolic-ref.txt b/Documentation/git-symbolic-ref.txt
index 102c83eb19e..761b154bcbb 100644
--- a/Documentation/git-symbolic-ref.txt
+++ b/Documentation/git-symbolic-ref.txt
@@ -27,7 +27,7 @@ symbolic ref.
 
 A symbolic ref is a regular file that stores a string that
 begins with `ref: refs/`.  For example, your `.git/HEAD` is
-a regular file whose contents is `ref: refs/heads/master`.
+a regular file whose content is `ref: refs/heads/master`.
 
 OPTIONS
 -------
diff --git a/Documentation/gitdiffcore.txt b/Documentation/gitdiffcore.txt
index 0d57f86abc4..5681ba3f330 100644
--- a/Documentation/gitdiffcore.txt
+++ b/Documentation/gitdiffcore.txt
@@ -173,7 +173,7 @@ Note that when rename detection is on but both copy and break
 detection are off, rename detection adds a preliminary step that first
 checks if files are moved across directories while keeping their
 filename the same.  If there is a file added to a directory whose
-contents is sufficiently similar to a file with the same name that got
+contents are sufficiently similar to a file with the same name that got
 deleted from a different directory, it will mark them as renames and
 exclude them from the later quadratic step (the one that pairwise
 compares all unmatched files to find the "best" matches, determined by
diff --git a/Documentation/gitformat-bundle.txt b/Documentation/gitformat-bundle.txt
index f1acf196e10..1b75cf71cec 100644
--- a/Documentation/gitformat-bundle.txt
+++ b/Documentation/gitformat-bundle.txt
@@ -67,7 +67,7 @@ A Git bundle consists of several parts.
 * "Capabilities", which are only in the v3 format, indicate functionality that
 	the bundle requires to be read properly.
 
-* "Prerequisites" lists the objects that are NOT included in the bundle and the
+* "Prerequisites" list the objects that are NOT included in the bundle and the
   reader of the bundle MUST already have, in order to use the data in the
   bundle. The objects stored in the bundle may refer to prerequisite objects and
   anything reachable from them (e.g. a tree object in the bundle can reference
diff --git a/Documentation/gitprotocol-capabilities.txt b/Documentation/gitprotocol-capabilities.txt
index 9adda577e51..388846d92e9 100644
--- a/Documentation/gitprotocol-capabilities.txt
+++ b/Documentation/gitprotocol-capabilities.txt
@@ -30,7 +30,7 @@ to be in effect. The client MUST NOT ask for capabilities the server
 did not say it supports.
 
 Server MUST diagnose and abort if capabilities it does not understand
-was sent.  Server MUST NOT ignore capabilities that client requested
+were sent.  Server MUST NOT ignore capabilities that client requested
 and server advertised.  As a consequence of these rules, server MUST
 NOT advertise capabilities it does not understand.
 
diff --git a/Documentation/gitprotocol-pack.txt b/Documentation/gitprotocol-pack.txt
index 01391cb300d..837b691c892 100644
--- a/Documentation/gitprotocol-pack.txt
+++ b/Documentation/gitprotocol-pack.txt
@@ -30,7 +30,7 @@ pkt-line Format
 ---------------
 
 The descriptions below build on the pkt-line format described in
-linkgit:gitprotocol-common[5]. When the grammar indicate `PKT-LINE(...)`, unless
+linkgit:gitprotocol-common[5]. When the grammar indicates `PKT-LINE(...)`, unless
 otherwise noted the usual pkt-line LF rules apply: the sender SHOULD
 include a LF, but the receiver MUST NOT complain if it is not present.
 
@@ -325,7 +325,7 @@ a positive depth, this step is skipped.
 
 If the client has requested a positive depth, the server will compute
 the set of commits which are no deeper than the desired depth. The set
-of commits start at the client's wants.
+of commits starts at the client's wants.
 
 The server writes 'shallow' lines for each
 commit whose parents will not be sent as a result. The server writes
diff --git a/Documentation/glossary-content.txt b/Documentation/glossary-content.txt
index 5a537268e27..65c89e7b3eb 100644
--- a/Documentation/glossary-content.txt
+++ b/Documentation/glossary-content.txt
@@ -186,7 +186,7 @@ current branch integrates with) obviously do not work, as there is no
 	points at the directory that is the real repository.
 
 [[def_grafts]]grafts::
-	Grafts enables two otherwise different lines of development to be joined
+	Grafts enable two otherwise different lines of development to be joined
 	together by recording fake ancestry information for commits. This way
 	you can make Git pretend the set of <<def_parent,parents>> a <<def_commit,commit>> has
 	is different from what was recorded when the commit was
diff --git a/Documentation/howto/coordinate-embargoed-releases.txt b/Documentation/howto/coordinate-embargoed-releases.txt
index e653775bab1..b9cb95e82f0 100644
--- a/Documentation/howto/coordinate-embargoed-releases.txt
+++ b/Documentation/howto/coordinate-embargoed-releases.txt
@@ -145,7 +145,7 @@ Opening a Security Advisory draft
 
 The first step is to https://github.com/git/git/security/advisories/new[open
 an advisory]. Technically, this is not necessary. However, it is the most
-convenient way to obtain the CVE number and it give us a private repository
+convenient way to obtain the CVE number and it gives us a private repository
 associated with it that can be used to collaborate on a fix.
 
 Notifying the Linux distributions
diff --git a/Documentation/i18n.txt b/Documentation/i18n.txt
index 0efb1153d27..3a866af4a42 100644
--- a/Documentation/i18n.txt
+++ b/Documentation/i18n.txt
@@ -34,7 +34,7 @@ project find it more convenient to use legacy encodings, Git
 does not forbid it.  However, there are a few things to keep in
 mind.
 
-. 'git commit' and 'git commit-tree' issues
+. 'git commit' and 'git commit-tree' issue
   a warning if the commit log message given to it does not look
   like a valid UTF-8 string, unless you explicitly say your
   project uses a legacy encoding.  The way to say this is to
diff --git a/Documentation/technical/api-simple-ipc.txt b/Documentation/technical/api-simple-ipc.txt
index d88b1ef206e..b4259098680 100644
--- a/Documentation/technical/api-simple-ipc.txt
+++ b/Documentation/technical/api-simple-ipc.txt
@@ -2,7 +2,7 @@ Simple-IPC API
 ==============
 
 The Simple-IPC API is a collection of `ipc_` prefixed library routines
-and a basic communication protocol that allow an IPC-client process to
+and a basic communication protocol that allows an IPC-client process to
 send an application-specific IPC-request message to an IPC-server
 process and receive an application-specific IPC-response message.
 
diff --git a/Documentation/technical/reftable.txt b/Documentation/technical/reftable.txt
index d7d066d876a..84637f96e77 100644
--- a/Documentation/technical/reftable.txt
+++ b/Documentation/technical/reftable.txt
@@ -46,7 +46,7 @@ search lookup, and range scans.
 
 Storage in the file is organized into variable sized blocks. Prefix
 compression is used within a single block to reduce disk space. Block
-size and alignment is tunable by the writer.
+size and alignment are tunable by the writer.
 
 Performance
 ^^^^^^^^^^^
@@ -288,7 +288,7 @@ The 2-byte `restart_count` stores the number of entries in the
 `restart_count` to binary search between restarts before starting a
 linear scan.
 
-Exactly `restart_count` 3-byte `restart_offset` values precedes the
+Exactly `restart_count` 3-byte `restart_offset` values precede the
 `restart_count`. Offsets are relative to the start of the block and
 refer to the first byte of any `ref_record` whose name has not been
 prefix compressed. Entries in the `restart_offset` list must be sorted,
-- 
gitgitgadget

