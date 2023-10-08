Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4ABEE95A82
	for <git@archiver.kernel.org>; Sun,  8 Oct 2023 06:46:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344529AbjJHGqE (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 8 Oct 2023 02:46:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344499AbjJHGpn (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Oct 2023 02:45:43 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF4E5DE
        for <git@vger.kernel.org>; Sat,  7 Oct 2023 23:45:34 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-4054496bde3so32184635e9.1
        for <git@vger.kernel.org>; Sat, 07 Oct 2023 23:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696747533; x=1697352333; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ht5kEqW6kedHzxAv0k9KE/AkdIKMuD8sN4azUKVfJXE=;
        b=UajvIYAt2Fsj/1aRNDk/80V7hxQUkq/an8ekPRriVEelekV37myuUvkAY0jZX6Rl33
         6sYoD/PCJ8AQcFhKto52BbNlkeayuvj5ob4IEr4h2PTTIzTSm0c4NnYidQUm7c5FQ+w1
         /laatlLQdOBu6cN76AhU1X8BUgcnUZW5fzOtHMv0cY9o64R9mT8oNQUmVb1cQs4Hvkkb
         HjzGA447yhGLqJ6Ed1N29ziTKD7eMNmhRqasKNhoQS+8pcboywbJxO4/VdQHXWk/j5q3
         P+aFps4Y1kTKHrFDOY1c2K+TtNrnyX60tapYmM54FjZXEqNsS2hBf+4zvp2AEQPSk1Kp
         o/ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696747533; x=1697352333;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ht5kEqW6kedHzxAv0k9KE/AkdIKMuD8sN4azUKVfJXE=;
        b=MTUCilUfie/njEGalZCDmXpWtwekM2tyzcx1hwcswnSu25P9KbgC/MBcbW5/ugl64X
         lcMeQ+1sgTo2vuyGZV2MkTCEurNW95u26iYwRbSP6/W7d5G1JyJ/A1GRhkS+WekyyLpf
         eYdB3ud8Q4E3CX1b8UE7wUG2KKOQwD610rOOTPGk3LQpMw6T3qJrhZAQOOYl72ab4lJS
         StNhOYyLTPM6yV1W2ZZnM6H9OBnsYxPYkli+BIQql/dZC/1yz/1QepMcG1WhrTz5/a9t
         PcxPHa9hqaiKVEKvmym+v5HPF6Bso0ZynDmVp76NYNH5w26pCrgTNWfaxMHS3KFN3K4N
         6izA==
X-Gm-Message-State: AOJu0Yx1jGimLxfXegpPMrBniMuWqB82W9whHI5Q6SxOM6y4ElIeCYnF
        L+e3rX4Icxr817pMVrSHM+bFGKE2r2s=
X-Google-Smtp-Source: AGHT+IHs9/VLBTXcDjQhEP9wCtPyskGruKLbnOCTZOmkgrsUklLniNHXvTwYDPDght5XAyanO+p86Q==
X-Received: by 2002:a5d:4144:0:b0:31a:d4e4:4f63 with SMTP id c4-20020a5d4144000000b0031ad4e44f63mr10399732wrq.18.1696747531659;
        Sat, 07 Oct 2023 23:45:31 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n20-20020adf8b14000000b003296b62d413sm5547110wra.82.2023.10.07.23.45.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Oct 2023 23:45:31 -0700 (PDT)
Message-ID: <37dffdf9fbd0a869d9a2814df590c029e887c595.1696747529.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1595.git.1696747527.gitgitgadget@gmail.com>
References: <pull.1595.git.1696747527.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 08 Oct 2023 06:45:03 +0000
Subject: [PATCH 01/25] documentation: wording improvements
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
 Documentation/CodingGuidelines                |  4 ++--
 Documentation/ToolsForGit.txt                 |  2 +-
 Documentation/config.txt                      |  4 ++--
 Documentation/config/apply.txt                |  2 +-
 Documentation/config/branch.txt               |  2 +-
 Documentation/config/clone.txt                |  4 ++--
 Documentation/config/credential.txt           |  2 +-
 Documentation/config/fetch.txt                |  4 ++--
 Documentation/config/fsck.txt                 |  4 ++--
 Documentation/config/fsmonitor--daemon.txt    |  2 +-
 Documentation/config/gc.txt                   |  2 +-
 Documentation/config/gpg.txt                  |  2 +-
 Documentation/config/http.txt                 |  2 +-
 Documentation/config/imap.txt                 |  2 +-
 Documentation/config/mergetool.txt            |  2 +-
 Documentation/config/pack.txt                 |  6 +++---
 Documentation/config/receive.txt              |  2 +-
 Documentation/config/safe.txt                 |  4 ++--
 Documentation/config/submodule.txt            |  2 +-
 Documentation/config/trace2.txt               |  2 +-
 Documentation/config/transfer.txt             |  4 ++--
 Documentation/config/user.txt                 |  2 +-
 Documentation/diff-generate-patch.txt         |  4 ++--
 Documentation/diff-options.txt                |  2 +-
 Documentation/git-apply.txt                   |  2 +-
 Documentation/git-archive.txt                 | 16 ++++++++--------
 Documentation/git-bugreport.txt               |  9 +++++----
 Documentation/git-checkout-index.txt          |  2 +-
 Documentation/git-count-objects.txt           |  4 ++--
 Documentation/git-credential.txt              |  2 +-
 Documentation/git-diff-index.txt              |  4 ++--
 Documentation/git-diff-tree.txt               |  2 +-
 Documentation/git-fast-import.txt             |  2 +-
 Documentation/git-hash-object.txt             |  8 ++++----
 Documentation/git-help.txt                    |  2 +-
 Documentation/git-http-backend.txt            | 10 +++++-----
 Documentation/git-http-fetch.txt              |  2 +-
 Documentation/git-http-push.txt               |  4 ++--
 Documentation/git-index-pack.txt              | 10 +++++-----
 Documentation/git-init.txt                    |  2 +-
 Documentation/git-ls-files.txt                |  6 +++---
 Documentation/git-maintenance.txt             |  6 +++---
 Documentation/git-merge.txt                   |  2 +-
 Documentation/git-mergetool.txt               |  2 +-
 Documentation/git-mktree.txt                  |  4 ++--
 Documentation/git-range-diff.txt              |  2 +-
 Documentation/git-read-tree.txt               |  2 +-
 Documentation/git-remote-ext.txt              |  2 +-
 Documentation/git-repack.txt                  |  2 +-
 Documentation/git-restore.txt                 |  2 +-
 Documentation/git-rev-list.txt                |  2 +-
 Documentation/git-rev-parse.txt               |  2 +-
 Documentation/git-send-email.txt              |  4 ++--
 Documentation/git-send-pack.txt               | 10 +++++-----
 Documentation/git-status.txt                  |  2 +-
 Documentation/git-stripspace.txt              |  2 +-
 Documentation/git-var.txt                     |  2 +-
 Documentation/git-whatchanged.txt             |  2 +-
 Documentation/gitformat-bundle.txt            |  6 +++---
 Documentation/githooks.txt                    |  2 +-
 Documentation/gitprotocol-capabilities.txt    | 14 +++++++-------
 Documentation/gitprotocol-http.txt            |  4 ++--
 Documentation/gitweb.txt                      |  4 ++--
 Documentation/howto/maintain-git.txt          |  4 ++--
 Documentation/howto/using-merge-subtree.txt   |  2 +-
 Documentation/i18n.txt                        |  2 +-
 Documentation/mergetools/vimdiff.txt          |  4 ++--
 Documentation/technical/api-simple-ipc.txt    |  2 +-
 Documentation/technical/bitmap-format.txt     |  2 +-
 Documentation/technical/parallel-checkout.txt |  2 +-
 Documentation/technical/partial-clone.txt     |  2 +-
 Documentation/technical/racy-git.txt          |  6 +++---
 Documentation/technical/reftable.txt          |  2 +-
 Documentation/urls.txt                        |  4 ++--
 74 files changed, 134 insertions(+), 133 deletions(-)

diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuidelines
index 65af8d82ced..99b22ff2345 100644
--- a/Documentation/CodingGuidelines
+++ b/Documentation/CodingGuidelines
@@ -1,5 +1,5 @@
-Like other projects, we also have some guidelines to keep to the
-code.  For Git in general, a few rough rules are:
+Like other projects, we also have some guidelines for our code.  For
+Git in general, a few rough rules are:
 
  - Most importantly, we never say "It's in POSIX; we'll happily
    ignore your needs should your system not conform to it."
diff --git a/Documentation/ToolsForGit.txt b/Documentation/ToolsForGit.txt
index 5060d0d2314..5d01e8191aa 100644
--- a/Documentation/ToolsForGit.txt
+++ b/Documentation/ToolsForGit.txt
@@ -32,7 +32,7 @@ information on using the script.
 
 This is adapted from Linux's suggestion in its CodingStyle document:
 
-- To follow rules of the CodingGuideline, it's useful to put the following in
+- To follow the rules in CodingGuidelines, it's useful to put the following in
 GIT_CHECKOUT/.dir-locals.el, assuming you use cperl-mode:
 ----
 ;; note the first part is useful for C editing, too
diff --git a/Documentation/config.txt b/Documentation/config.txt
index 229b63a454c..9273c7f1c65 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -11,7 +11,7 @@ file. The file `/etc/gitconfig` can be used to store a system-wide
 default configuration.
 
 The configuration variables are used by both the Git plumbing
-and the porcelains. The variables are divided into sections, wherein
+and the porcelain commands. The variables are divided into sections, wherein
 the fully qualified variable name of the variable itself is the last
 dot-separated segment and the section name is everything before the last
 dot. The variable names are case-insensitive, allow only alphanumeric
@@ -103,7 +103,7 @@ was found.  See below for examples.
 Conditional includes
 ~~~~~~~~~~~~~~~~~~~~
 
-You can include a config file from another conditionally by setting a
+You can conditionally include a config file from another by setting a
 `includeIf.<condition>.path` variable to the name of the file to be
 included.
 
diff --git a/Documentation/config/apply.txt b/Documentation/config/apply.txt
index 8fb8ef763df..3f9ff19db6b 100644
--- a/Documentation/config/apply.txt
+++ b/Documentation/config/apply.txt
@@ -2,7 +2,7 @@ apply.ignoreWhitespace::
 	When set to 'change', tells 'git apply' to ignore changes in
 	whitespace, in the same way as the `--ignore-space-change`
 	option.
-	When set to one of: no, none, never, false tells 'git apply' to
+	When set to one of: no, none, never, false, it tells 'git apply' to
 	respect all whitespace differences.
 	See linkgit:git-apply[1].
 
diff --git a/Documentation/config/branch.txt b/Documentation/config/branch.txt
index 445341a906b..2b05ed3574b 100644
--- a/Documentation/config/branch.txt
+++ b/Documentation/config/branch.txt
@@ -36,7 +36,7 @@ branch.sort::
 
 branch.<name>.remote::
 	When on branch <name>, it tells 'git fetch' and 'git push'
-	which remote to fetch from/push to.  The remote to push to
+	which remote to fetch from or push to.  The remote to push to
 	may be overridden with `remote.pushDefault` (for all branches).
 	The remote to push to, for the current branch, may be further
 	overridden by `branch.<name>.pushRemote`.  If no remote is
diff --git a/Documentation/config/clone.txt b/Documentation/config/clone.txt
index 26f4fb137a7..a16b1b6fa34 100644
--- a/Documentation/config/clone.txt
+++ b/Documentation/config/clone.txt
@@ -4,8 +4,8 @@ clone.defaultRemoteName::
 	option to linkgit:git-clone[1].
 
 clone.rejectShallow::
-	Reject to clone a repository if it is a shallow one, can be overridden by
-	passing option `--reject-shallow` in command line. See linkgit:git-clone[1]
+	Reject to clone a repository if it is a shallow one; this can be overridden by
+	passing the `--reject-shallow` option on the command line. See linkgit:git-clone[1]
 
 clone.filterSubmodules::
 	If a partial clone filter is provided (see `--filter` in
diff --git a/Documentation/config/credential.txt b/Documentation/config/credential.txt
index 512f31876e1..075ef8c9750 100644
--- a/Documentation/config/credential.txt
+++ b/Documentation/config/credential.txt
@@ -31,6 +31,6 @@ credentialCache.ignoreSIGHUP::
 
 credentialStore.lockTimeoutMS::
 	The length of time, in milliseconds, for git-credential-store to retry
-	when trying to lock the credentials file. Value 0 means not to retry at
+	when trying to lock the credentials file. A value of 0 means not to retry at
 	all; -1 means to try indefinitely. Default is 1000 (i.e., retry for
 	1s).
diff --git a/Documentation/config/fetch.txt b/Documentation/config/fetch.txt
index 568f0f75b30..c1a7cdd6bf4 100644
--- a/Documentation/config/fetch.txt
+++ b/Documentation/config/fetch.txt
@@ -52,8 +52,8 @@ fetch.pruneTags::
 
 fetch.output::
 	Control how ref update status is printed. Valid values are
-	`full` and `compact`. Default value is `full`. See section
-	OUTPUT in linkgit:git-fetch[1] for detail.
+	`full` and `compact`. Default value is `full`. See the
+	OUTPUT section in linkgit:git-fetch[1] for detail.
 
 fetch.negotiationAlgorithm::
 	Control how information about the commits in the local repository
diff --git a/Documentation/config/fsck.txt b/Documentation/config/fsck.txt
index a3c865df567..fec3eefb5b8 100644
--- a/Documentation/config/fsck.txt
+++ b/Documentation/config/fsck.txt
@@ -17,7 +17,7 @@ Unlike variables like `color.ui` and `core.editor` the
 `receive.fsck.<msg-id>` and `fetch.fsck.<msg-id>` variables will not
 fall back on the `fsck.<msg-id>` configuration if they aren't set. To
 uniformly configure the same fsck settings in different circumstances
-all three of them they must all set to the same values.
+all three of them must be set to the same values.
 +
 When `fsck.<msg-id>` is set, errors can be switched to warnings and
 vice versa by configuring the `fsck.<msg-id>` setting where the
@@ -59,7 +59,7 @@ Unlike variables like `color.ui` and `core.editor` the
 `receive.fsck.skipList` and `fetch.fsck.skipList` variables will not
 fall back on the `fsck.skipList` configuration if they aren't set. To
 uniformly configure the same fsck settings in different circumstances
-all three of them they must all set to the same values.
+all three of them must be set to the same values.
 +
 Older versions of Git (before 2.20) documented that the object names
 list should be sorted. This was never a requirement, the object names
diff --git a/Documentation/config/fsmonitor--daemon.txt b/Documentation/config/fsmonitor--daemon.txt
index c225c6c9e74..671f9b94628 100644
--- a/Documentation/config/fsmonitor--daemon.txt
+++ b/Documentation/config/fsmonitor--daemon.txt
@@ -1,5 +1,5 @@
 fsmonitor.allowRemote::
-    By default, the fsmonitor daemon refuses to work against network-mounted
+    By default, the fsmonitor daemon refuses to work with network-mounted
     repositories. Setting `fsmonitor.allowRemote` to `true` overrides this
     behavior.  Only respected when `core.fsmonitor` is set to `true`.
 
diff --git a/Documentation/config/gc.txt b/Documentation/config/gc.txt
index ca47eb20088..17e2a8cc176 100644
--- a/Documentation/config/gc.txt
+++ b/Documentation/config/gc.txt
@@ -24,7 +24,7 @@ gc.auto::
 	default value is 6700.
 +
 Setting this to 0 disables not only automatic packing based on the
-number of loose objects, but any other heuristic `git gc --auto` will
+number of loose objects, but also any other heuristic `git gc --auto` will
 otherwise use to determine if there's work to do, such as
 `gc.autoPackLimit`.
 
diff --git a/Documentation/config/gpg.txt b/Documentation/config/gpg.txt
index 37e2831cd51..a31faab2edd 100644
--- a/Documentation/config/gpg.txt
+++ b/Documentation/config/gpg.txt
@@ -4,7 +4,7 @@ gpg.program::
 	same command-line interface as GPG, namely, to verify a detached
 	signature, "`gpg --verify $signature - <$file`" is run, and the
 	program is expected to signal a good signature by exiting with
-	code 0, and to generate an ASCII-armored detached signature, the
+	code 0.  To generate an ASCII-armored detached signature, the
 	standard input of "`gpg -bsau $key`" is fed with the contents to be
 	signed, and the program is expected to send the result to its
 	standard output.
diff --git a/Documentation/config/http.txt b/Documentation/config/http.txt
index 51a70781e58..1d805fdddbc 100644
--- a/Documentation/config/http.txt
+++ b/Documentation/config/http.txt
@@ -260,7 +260,7 @@ http.noEPSV::
 
 http.userAgent::
 	The HTTP USER_AGENT string presented to an HTTP server.  The default
-	value represents the version of the client Git such as git/1.7.1.
+	value represents the version of the Git client such as git/1.7.1.
 	This option allows you to override this value to a more common value
 	such as Mozilla/4.0.  This may be necessary, for instance, if
 	connecting through a firewall that restricts HTTP connections to a set
diff --git a/Documentation/config/imap.txt b/Documentation/config/imap.txt
index 06166fb5c04..fa0dccc3d83 100644
--- a/Documentation/config/imap.txt
+++ b/Documentation/config/imap.txt
@@ -37,7 +37,7 @@ imap.preformattedHTML::
 	format=fixed email.  Default is `false`.
 
 imap.authMethod::
-	Specify authenticate method for authentication with IMAP server.
+	Specify the authentication method for authenticating with the IMAP server.
 	If Git was built with the NO_CURL option, or if your curl version is older
 	than 7.34.0, or if you're running git-imap-send with the `--no-curl`
 	option, the only supported method is 'CRAM-MD5'. If this is not set
diff --git a/Documentation/config/mergetool.txt b/Documentation/config/mergetool.txt
index 56a7eeeffb4..e9abde9d60c 100644
--- a/Documentation/config/mergetool.txt
+++ b/Documentation/config/mergetool.txt
@@ -47,7 +47,7 @@ mergetool.meld.useAutoMerge::
 
 mergetool.vimdiff.layout::
 	The vimdiff backend uses this variable to control how its split
-	windows look like. Applies even if you are using Neovim (`nvim`) or
+	windows appear. Applies even if you are using Neovim (`nvim`) or
 	gVim (`gvim`) as the merge tool. See BACKEND SPECIFIC HINTS section
 ifndef::git-mergetool[]
 	in linkgit:git-mergetool[1].
diff --git a/Documentation/config/pack.txt b/Documentation/config/pack.txt
index 3748136d141..dcd4c871b3a 100644
--- a/Documentation/config/pack.txt
+++ b/Documentation/config/pack.txt
@@ -83,7 +83,7 @@ pack.indexVersion::
 	the new pack index with capabilities for packs larger than 4 GB
 	as well as proper protection against the repacking of corrupted
 	packs.  Version 2 is the default.  Note that version 2 is enforced
-	and this config option ignored whenever the corresponding pack is
+	and this config option is ignored whenever the corresponding pack is
 	larger than 2 GB.
 +
 If you have an old Git that does not understand the version 2 `*.idx` file,
@@ -102,8 +102,8 @@ pack.packSizeLimit::
 	in the creation of multiple packfiles.
 +
 Note that this option is rarely useful, and may result in a larger total
-on-disk size (because Git will not store deltas between packs), as well
-as worse runtime performance (object lookup within multiple packs is
+on-disk size (because Git will not store deltas between packs) and
+worse runtime performance (object lookup within multiple packs is
 slower than a single pack, and optimizations like reachability bitmaps
 cannot cope with multiple packs).
 +
diff --git a/Documentation/config/receive.txt b/Documentation/config/receive.txt
index 85d5b5a3d2d..ae526cbf584 100644
--- a/Documentation/config/receive.txt
+++ b/Documentation/config/receive.txt
@@ -19,7 +19,7 @@ receive.certNonceSeed::
 	key.
 
 receive.certNonceSlop::
-	When a `git push --signed` sent a push certificate with a
+	When a `git push --signed` sends a push certificate with a
 	"nonce" that was issued by a receive-pack serving the same
 	repository within this many seconds, export the "nonce"
 	found in the certificate to `GIT_PUSH_CERT_NONCE` to the
diff --git a/Documentation/config/safe.txt b/Documentation/config/safe.txt
index bde7f31459b..577df40223a 100644
--- a/Documentation/config/safe.txt
+++ b/Documentation/config/safe.txt
@@ -14,7 +14,7 @@ repository that contains a bare repository and running a Git command
 within that directory.
 +
 This config setting is only respected in protected configuration (see
-<<SCOPES>>). This prevents the untrusted repository from tampering with
+<<SCOPES>>). This prevents untrusted repositories from tampering with
 this value.
 
 safe.directory::
@@ -32,7 +32,7 @@ override any such directories specified in the system config), add a
 `safe.directory` entry with an empty value.
 +
 This config setting is only respected in protected configuration (see
-<<SCOPES>>). This prevents the untrusted repository from tampering with this
+<<SCOPES>>). This prevents untrusted repositories from tampering with this
 value.
 +
 The value of this setting is interpolated, i.e. `~/<path>` expands to a
diff --git a/Documentation/config/submodule.txt b/Documentation/config/submodule.txt
index 6490527b45b..665419fa135 100644
--- a/Documentation/config/submodule.txt
+++ b/Documentation/config/submodule.txt
@@ -2,7 +2,7 @@ submodule.<name>.url::
 	The URL for a submodule. This variable is copied from the .gitmodules
 	file to the git config via 'git submodule init'. The user can change
 	the configured URL before obtaining the submodule via 'git submodule
-	update'. If neither submodule.<name>.active or submodule.active are
+	update'. If neither submodule.<name>.active nor submodule.active are
 	set, the presence of this variable is used as a fallback to indicate
 	whether the submodule is of interest to git commands.
 	See linkgit:git-submodule[1] and linkgit:gitmodules[5] for details.
diff --git a/Documentation/config/trace2.txt b/Documentation/config/trace2.txt
index fe1642f0d40..3b6bca2b7ae 100644
--- a/Documentation/config/trace2.txt
+++ b/Documentation/config/trace2.txt
@@ -66,6 +66,6 @@ trace2.destinationDebug::
 
 trace2.maxFiles::
 	Integer.  When writing trace files to a target directory, do not
-	write additional traces if we would exceed this many files. Instead,
+	write additional traces if doing so would exceed this many files. Instead,
 	write a sentinel file that will block further tracing to this
 	directory. Defaults to 0, which disables this check.
diff --git a/Documentation/config/transfer.txt b/Documentation/config/transfer.txt
index c3ac767d1e4..55e13428db1 100644
--- a/Documentation/config/transfer.txt
+++ b/Documentation/config/transfer.txt
@@ -7,7 +7,7 @@ transfer.credentialsInUrl::
 	and any other direct use of the configured URL.
 +
 Note that this is currently limited to detecting credentials in
-`remote.<name>.url` configuration, it won't detect credentials in
+`remote.<name>.url` configuration; it won't detect credentials in
 `remote.<name>.pushurl` configuration.
 +
 You might want to enable this to prevent inadvertent credentials
@@ -26,7 +26,7 @@ exposure, e.g. because:
   documented in procfs(5) allows for configuring this behavior.
 +
 If such concerns don't apply to you then you probably don't need to be
-concerned about credentials exposure due to storing that sensitive
+concerned about credentials exposure due to storing sensitive
 data in git's configuration files. If you do want to use this, set
 `transfer.credentialsInUrl` to one of these values:
 +
diff --git a/Documentation/config/user.txt b/Documentation/config/user.txt
index ec9233b060a..958e62464a5 100644
--- a/Documentation/config/user.txt
+++ b/Documentation/config/user.txt
@@ -10,7 +10,7 @@ committer.email::
 	If you need the `author` or `committer` to be different, the
 	`author.name`, `author.email`, `committer.name` or
 	`committer.email` variables can be set.
-	Also, all of these can be overridden by the `GIT_AUTHOR_NAME`,
+	All of these can be overridden by the `GIT_AUTHOR_NAME`,
 	`GIT_AUTHOR_EMAIL`, `GIT_COMMITTER_NAME`,
 	`GIT_COMMITTER_EMAIL` and `EMAIL` environment variables.
 +
diff --git a/Documentation/diff-generate-patch.txt b/Documentation/diff-generate-patch.txt
index 546adf79e5a..55df903abd1 100644
--- a/Documentation/diff-generate-patch.txt
+++ b/Documentation/diff-generate-patch.txt
@@ -146,7 +146,7 @@ information about detected contents movement (renames and
 copying detection) are designed to work with diff of two
 <tree-ish> and are not used by combined diff format.
 
-3.   It is followed by two-line from-file/to-file header
+3.   It is followed by a two-line from-file/to-file header:
 
        --- a/file
        +++ b/file
@@ -157,7 +157,7 @@ files.
 +
 However, if the --combined-all-paths option is provided, instead of a
 two-line from-file/to-file you get a N+1 line from-file/to-file header,
-where N is the number of parents in the merge commit
+where N is the number of parents in the merge commit:
 
        --- a/file
        --- a/file
diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index 35fae7c87c8..8917ce7a9e1 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -733,7 +733,7 @@ matches "`fooasdfbar`" and "`foo/bar/baz/asdf`" but not "`foobarx`".
 --rotate-to=<file>::
 	Discard the files before the named <file> from the output
 	(i.e. 'skip to'), or move them to the end of the output
-	(i.e. 'rotate to').  These were invented primarily for use
+	(i.e. 'rotate to').  These options were invented primarily for the use
 	of the `git difftool` command, and may not be very useful
 	otherwise.
 
diff --git a/Documentation/git-apply.txt b/Documentation/git-apply.txt
index 5e16e6db7e2..b6e7510d068 100644
--- a/Documentation/git-apply.txt
+++ b/Documentation/git-apply.txt
@@ -159,7 +159,7 @@ discouraged.
 
 --allow-binary-replacement::
 --binary::
-	Historically we did not allow binary patch applied
+	Historically we did not allow binary patch application
 	without an explicit permission from the user, and this
 	flag was the way to do so.  Currently we always allow binary
 	patch application, so this is a no-op.
diff --git a/Documentation/git-archive.txt b/Documentation/git-archive.txt
index 6bab201d375..98526f2beba 100644
--- a/Documentation/git-archive.txt
+++ b/Documentation/git-archive.txt
@@ -21,14 +21,14 @@ structure for the named tree, and writes it out to the standard
 output.  If <prefix> is specified it is
 prepended to the filenames in the archive.
 
-'git archive' behaves differently when given a tree ID versus when
-given a commit ID or tag ID.  In the first case the current time is
-used as the modification time of each file in the archive.  In the latter
-case the commit time as recorded in the referenced commit object is
-used instead.  Additionally the commit ID is stored in a global
-extended pax header if the tar format is used; it can be extracted
-using 'git get-tar-commit-id'. In ZIP files it is stored as a file
-comment.
+'git archive' behaves differently when given a tree ID as opposed to a
+commit ID or tag ID. When a tree ID is provided, the current time is
+used as the modification time of each file in the archive. On the
+other hand, when a commit ID or tag ID is provided, the commit time as
+recorded in the referenced commit object is used instead.
+Additionally the commit ID is stored in a global extended pax header
+if the tar format is used; it can be extracted using 'git
+get-tar-commit-id'. In ZIP files it is stored as a file comment.
 
 OPTIONS
 -------
diff --git a/Documentation/git-bugreport.txt b/Documentation/git-bugreport.txt
index eca726e5791..392d9eb6aec 100644
--- a/Documentation/git-bugreport.txt
+++ b/Documentation/git-bugreport.txt
@@ -13,10 +13,11 @@ SYNOPSIS
 
 DESCRIPTION
 -----------
-Captures information about the user's machine, Git client, and repository state,
-as well as a form requesting information about the behavior the user observed,
-into a single text file which the user can then share, for example to the Git
-mailing list, in order to report an observed bug.
+Collects information about the user's machine, Git client, and repository
+state, in addition to a form requesting information about the behavior the
+user observed, and stores it in a single text file which the user can then
+share, for example to the Git mailing list, in order to report an observed
+bug.
 
 The following information is requested from the user:
 
diff --git a/Documentation/git-checkout-index.txt b/Documentation/git-checkout-index.txt
index 01dbd5cbf54..d1738f43308 100644
--- a/Documentation/git-checkout-index.txt
+++ b/Documentation/git-checkout-index.txt
@@ -18,7 +18,7 @@ SYNOPSIS
 
 DESCRIPTION
 -----------
-Will copy all files listed from the index to the working directory
+Copies all listed files from the index to the working directory
 (not overwriting existing files).
 
 OPTIONS
diff --git a/Documentation/git-count-objects.txt b/Documentation/git-count-objects.txt
index cb9b4d2e460..b28cc3a510a 100644
--- a/Documentation/git-count-objects.txt
+++ b/Documentation/git-count-objects.txt
@@ -12,7 +12,7 @@ SYNOPSIS
 
 DESCRIPTION
 -----------
-This counts the number of unpacked object files and disk space consumed by
+Counts the number of unpacked object files and disk space consumed by
 them, to help you decide when it is a good time to repack.
 
 
@@ -20,7 +20,7 @@ OPTIONS
 -------
 -v::
 --verbose::
-	Report in more detail:
+	Provide more detailed reports:
 +
 count: the number of loose objects
 +
diff --git a/Documentation/git-credential.txt b/Documentation/git-credential.txt
index a220afed4f3..918a0aa42b2 100644
--- a/Documentation/git-credential.txt
+++ b/Documentation/git-credential.txt
@@ -94,7 +94,7 @@ unlocked) before it returned `password=secr3t`.
      that `git credential` will ask for a new password in its next
      invocation. In either case, `git credential` should be fed with
      the credential description obtained from step (2) (which also
-     contain the ones provided in step (1)).
+     contains the fields provided in step (1)).
 
 [[IOFMT]]
 INPUT/OUTPUT FORMAT
diff --git a/Documentation/git-diff-index.txt b/Documentation/git-diff-index.txt
index c30d8f0da8a..4de1d4c8f11 100644
--- a/Documentation/git-diff-index.txt
+++ b/Documentation/git-diff-index.txt
@@ -13,10 +13,10 @@ SYNOPSIS
 
 DESCRIPTION
 -----------
-Compares the content and mode of the blobs found in a tree object
+Compare the content and mode of the blobs found in a tree object
 with the corresponding tracked files in the working tree, or with the
 corresponding paths in the index.  When <path> arguments are present,
-compares only paths matching those patterns.  Otherwise all tracked
+compare only paths matching those patterns.  Otherwise all tracked
 files are compared.
 
 OPTIONS
diff --git a/Documentation/git-diff-tree.txt b/Documentation/git-diff-tree.txt
index 274d5eaba93..81caad5c95c 100644
--- a/Documentation/git-diff-tree.txt
+++ b/Documentation/git-diff-tree.txt
@@ -15,7 +15,7 @@ SYNOPSIS
 
 DESCRIPTION
 -----------
-Compares the content and mode of the blobs found via two tree objects.
+Compare the content and mode of blobs found via two tree objects.
 
 If there is only one <tree-ish> given, the commit is compared with its parents
 (see --stdin below).
diff --git a/Documentation/git-fast-import.txt b/Documentation/git-fast-import.txt
index 8b5dd6add00..a6a054f86d2 100644
--- a/Documentation/git-fast-import.txt
+++ b/Documentation/git-fast-import.txt
@@ -622,7 +622,7 @@ in octal.  Git only supports the following modes:
 * `100755` or `755`: A normal, but executable, file.
 * `120000`: A symlink, the content of the file will be the link target.
 * `160000`: A gitlink, SHA-1 of the object refers to a commit in
-  another repository. Git links can only be specified by SHA or through
+  another repository. Git links can only be specified either by SHA or through
   a commit mark. They are used to implement submodules.
 * `040000`: A subdirectory.  Subdirectories can only be specified by
   SHA or through a tree mark set with `--import-marks`.
diff --git a/Documentation/git-hash-object.txt b/Documentation/git-hash-object.txt
index 8577f7a7d40..ef4719ae41c 100644
--- a/Documentation/git-hash-object.txt
+++ b/Documentation/git-hash-object.txt
@@ -39,10 +39,10 @@ OPTIONS
 	of from the command-line.
 
 --path::
-	Hash object as it were located at the given path. The location of
-	file does not directly influence on the hash value, but path is
-	used to determine what Git filters should be applied to the object
-	before it can be placed to the object database, and, as result of
+	Hash object as if it were located at the given path. The location of
+	the file does not directly influence the hash value, but the path is
+	used to determine which Git filters should be applied to the object
+	before it can be placed in the object database.  As a result of
 	applying filters, the actual blob put into the object database may
 	differ from the given file. This option is mainly useful for hashing
 	temporary files located outside of the working directory or files
diff --git a/Documentation/git-help.txt b/Documentation/git-help.txt
index 2b0b5e390dc..7cb4b4bda18 100644
--- a/Documentation/git-help.txt
+++ b/Documentation/git-help.txt
@@ -109,7 +109,7 @@ other display programs (see below).
 	format. A web browser will be used for that purpose.
 +
 The web browser can be specified using the configuration variable
-`help.browser`, or `web.browser` if the former is not set. If none of
+`help.browser`, or `web.browser` if the former is not set. If neither of
 these config variables is set, the 'git web{litdd}browse' helper script
 (called by 'git help') will pick a suitable default. See
 linkgit:git-web{litdd}browse[1] for more information about this.
diff --git a/Documentation/git-http-backend.txt b/Documentation/git-http-backend.txt
index 0c5c0dde19f..f37ddaded82 100644
--- a/Documentation/git-http-backend.txt
+++ b/Documentation/git-http-backend.txt
@@ -23,7 +23,7 @@ discussion of `GIT_PROTOCOL` in the ENVIRONMENT section below.
 It verifies that the directory has the magic file
 "git-daemon-export-ok", and it will refuse to export any Git directory
 that hasn't explicitly been marked for export this way (unless the
-`GIT_HTTP_EXPORT_ALL` environmental variable is set).
+`GIT_HTTP_EXPORT_ALL` environment variable is set).
 
 By default, only the `upload-pack` service is enabled, which serves
 'git fetch-pack' and 'git ls-remote' clients, which are invoked from
@@ -42,12 +42,12 @@ http.getanyfile::
 	any file within the repository, including objects that are
 	no longer reachable from a branch but are still present.
 	It is enabled by default, but a repository can disable it
-	by setting this configuration item to `false`.
+	by setting this configuration value to `false`.
 
 http.uploadpack::
 	This serves 'git fetch-pack' and 'git ls-remote' clients.
 	It is enabled by default, but a repository can disable it
-	by setting this configuration item to `false`.
+	by setting this configuration value to `false`.
 
 http.receivepack::
 	This serves 'git send-pack' clients, allowing push.  It is
@@ -265,12 +265,12 @@ by the invoking web server, including:
 * QUERY_STRING
 * REQUEST_METHOD
 
-The `GIT_HTTP_EXPORT_ALL` environmental variable may be passed to
+The `GIT_HTTP_EXPORT_ALL` environment variable may be passed to
 'git-http-backend' to bypass the check for the "git-daemon-export-ok"
 file in each repository before allowing export of that repository.
 
 The `GIT_HTTP_MAX_REQUEST_BUFFER` environment variable (or the
-`http.maxRequestBuffer` config variable) may be set to change the
+`http.maxRequestBuffer` config option) may be set to change the
 largest ref negotiation request that git will handle during a fetch; any
 fetch requiring a larger buffer will not succeed.  This value should not
 normally need to be changed, but may be helpful if you are fetching from
diff --git a/Documentation/git-http-fetch.txt b/Documentation/git-http-fetch.txt
index 319062c021b..4ec7c68d3b9 100644
--- a/Documentation/git-http-fetch.txt
+++ b/Documentation/git-http-fetch.txt
@@ -31,7 +31,7 @@ commit-id::
 	Report what is downloaded.
 
 -w <filename>::
-        Writes the commit-id into the filename under $GIT_DIR/refs/<filename> on
+	Writes the commit-id into the specified filename under $GIT_DIR/refs/<filename> on
         the local end after the transfer is complete.
 
 --stdin::
diff --git a/Documentation/git-http-push.txt b/Documentation/git-http-push.txt
index 7c6a6dd7f6a..8b4a5791c8c 100644
--- a/Documentation/git-http-push.txt
+++ b/Documentation/git-http-push.txt
@@ -83,8 +83,8 @@ and where it is pushed is determined by using the destination side.
 Without `--force`, the <src> ref is stored at the remote only if
 <dst> does not exist, or <dst> is a proper subset (i.e. an
 ancestor) of <src>.  This check, known as "fast-forward check",
-is performed in order to avoid accidentally overwriting the
-remote ref and lose other peoples' commits from there.
+is performed to avoid accidentally overwriting the
+remote ref and losing other peoples' commits from there.
 
 With `--force`, the fast-forward check is disabled for all refs.
 
diff --git a/Documentation/git-index-pack.txt b/Documentation/git-index-pack.txt
index 4e71c256ecb..6486620c3d8 100644
--- a/Documentation/git-index-pack.txt
+++ b/Documentation/git-index-pack.txt
@@ -16,10 +16,10 @@ SYNOPSIS
 
 DESCRIPTION
 -----------
-Reads a packed archive (.pack) from the specified file, and
-builds a pack index file (.idx) for it. Optionally writes a
+Reads a packed archive (.pack) from the specified file,
+builds a pack index file (.idx) for it, and optionally writes a
 reverse-index (.rev) for the specified pack. The packed
-archive together with the pack index can then be placed in
+archive, together with the pack index, can then be placed in
 the objects/pack/ directory of a Git repository.
 
 
@@ -68,8 +68,8 @@ OPTIONS
 	updated to use objects contained in the pack.
 
 --keep=<msg>::
-	Like --keep create a .keep file before moving the index into
-	its final destination, but rather than creating an empty file
+	Like --keep, create a .keep file before moving the index into
+	its final destination.  However, instead of creating an empty file
 	place '<msg>' followed by an LF into the .keep file.  The '<msg>'
 	message can later be searched for within all .keep files to
 	locate any which have outlived their usefulness.
diff --git a/Documentation/git-init.txt b/Documentation/git-init.txt
index 160dea1372c..30ab86ab96a 100644
--- a/Documentation/git-init.txt
+++ b/Documentation/git-init.txt
@@ -99,7 +99,7 @@ specified.
 
 'group' (or 'true')::
 
-Make the repository group-writable, (and g+sx, since the git group may be not
+Make the repository group-writable, (and g+sx, since the git group may not be
 the primary group of all users). This is used to loosen the permissions of an
 otherwise safe umask(2) value. Note that the umask still applies to the other
 permission bits (e.g. if umask is '0022', using 'group' will not remove read
diff --git a/Documentation/git-ls-files.txt b/Documentation/git-ls-files.txt
index 1bc0328bb78..60d1cca1496 100644
--- a/Documentation/git-ls-files.txt
+++ b/Documentation/git-ls-files.txt
@@ -25,12 +25,12 @@ SYNOPSIS
 
 DESCRIPTION
 -----------
-This merges the file listing in the index with the actual working
+This command merges the file listing in the index with the actual working
 directory list, and shows different combinations of the two.
 
-One or more of the options below may be used to determine the files
+Several flags can be used to determine which files are
 shown, and each file may be printed multiple times if there are
-multiple entries in the index or multiple statuses are applicable for
+multiple entries in the index or if multiple statuses are applicable for
 the relevant file selection options.
 
 OPTIONS
diff --git a/Documentation/git-maintenance.txt b/Documentation/git-maintenance.txt
index 805e5a2e3a0..51d0f7e94b6 100644
--- a/Documentation/git-maintenance.txt
+++ b/Documentation/git-maintenance.txt
@@ -102,9 +102,9 @@ prefetch::
 	requested refs within `refs/prefetch/`. Also, tags are not updated.
 +
 This is done to avoid disrupting the remote-tracking branches. The end users
-expect these refs to stay unmoved unless they initiate a fetch.  With prefetch
-task, however, the objects necessary to complete a later real fetch would
-already be obtained, so the real fetch would go faster.  In the ideal case,
+expect these refs to stay unmoved unless they initiate a fetch.  However,
+with the prefetch task, the objects necessary to complete a later real fetch
+would already be obtained, making the real fetch faster.  In the ideal case,
 it will just become an update to a bunch of remote-tracking branches without
 any object transfer.
 
diff --git a/Documentation/git-merge.txt b/Documentation/git-merge.txt
index 8625c5cb0ec..e8ab3403191 100644
--- a/Documentation/git-merge.txt
+++ b/Documentation/git-merge.txt
@@ -336,7 +336,7 @@ After seeing a conflict, you can do two things:
 You can work through the conflict with a number of tools:
 
  * Use a mergetool.  `git mergetool` to launch a graphical
-   mergetool which will work you through the merge.
+   mergetool which will work through the merge with you.
 
  * Look at the diffs.  `git diff` will show a three-way diff,
    highlighting changes from both the `HEAD` and `MERGE_HEAD`
diff --git a/Documentation/git-mergetool.txt b/Documentation/git-mergetool.txt
index 07535f6576e..800a3cbe6f3 100644
--- a/Documentation/git-mergetool.txt
+++ b/Documentation/git-mergetool.txt
@@ -115,7 +115,7 @@ These are safe to remove once a file has been merged and its
 `git mergetool` session has completed.
 
 Setting the `mergetool.keepBackup` configuration variable to `false`
-causes `git mergetool` to automatically remove the backup as files
+causes `git mergetool` to automatically remove the backup files as files
 are successfully merged.
 
 BACKEND SPECIFIC HINTS
diff --git a/Documentation/git-mktree.txt b/Documentation/git-mktree.txt
index 76b44f4da10..383f09dd333 100644
--- a/Documentation/git-mktree.txt
+++ b/Documentation/git-mktree.txt
@@ -25,13 +25,13 @@ OPTIONS
 
 --missing::
 	Allow missing objects.  The default behaviour (without this option)
-	is to verify that each tree entry's sha1 identifies an existing
+	is to verify that each tree entry's hash identifies an existing
 	object.  This option has no effect on the treatment of gitlink entries
 	(aka "submodules") which are always allowed to be missing.
 
 --batch::
 	Allow building of more than one tree object before exiting.  Each
-	tree is separated by a single blank line. The final new-line is
+	tree is separated by a single blank line. The final newline is
 	optional.  Note - if the `-z` option is used, lines are terminated
 	with NUL.
 
diff --git a/Documentation/git-range-diff.txt b/Documentation/git-range-diff.txt
index 0b393715d70..605a92e224e 100644
--- a/Documentation/git-range-diff.txt
+++ b/Documentation/git-range-diff.txt
@@ -70,7 +70,7 @@ to revert to color all lines according to the outer diff markers
 	Defaults to 60. Try a larger value if `git range-diff` erroneously
 	considers a large change a total rewrite (deletion of one commit
 	and addition of another), and a smaller one in the reverse case.
-	See the ``Algorithm`` section below for an explanation why this is
+	See the ``Algorithm`` section below for an explanation of why this is
 	needed.
 
 --left-only::
diff --git a/Documentation/git-read-tree.txt b/Documentation/git-read-tree.txt
index b09707474df..32065318532 100644
--- a/Documentation/git-read-tree.txt
+++ b/Documentation/git-read-tree.txt
@@ -25,7 +25,7 @@ fast-forward (i.e. 2-way) merge, or a 3-way merge, with the `-m`
 flag.  When used with `-m`, the `-u` flag causes it to also update
 the files in the work tree with the result of the merge.
 
-Trivial merges are done by 'git read-tree' itself.  Only conflicting paths
+Only trivial merges are done by 'git read-tree' itself.  Only conflicting paths
 will be in unmerged state when 'git read-tree' returns.
 
 OPTIONS
diff --git a/Documentation/git-remote-ext.txt b/Documentation/git-remote-ext.txt
index 88ea7e1cc01..17d84f23c99 100644
--- a/Documentation/git-remote-ext.txt
+++ b/Documentation/git-remote-ext.txt
@@ -82,7 +82,7 @@ begins with `ext::`.  Examples:
 
 "ext::ssh -i /home/foo/.ssh/somekey user&#64;host.example %S 'foo/repo'"::
 	Like host.example:foo/repo, but use /home/foo/.ssh/somekey as
-	keypair and user as user on remote side. This avoids needing to
+	keypair and user as user on remote side. This avoids the need to
 	edit .ssh/config.
 
 "ext::socat -t3600 - ABSTRACT-CONNECT:/git-server %G/somerepo"::
diff --git a/Documentation/git-repack.txt b/Documentation/git-repack.txt
index 4017157949e..cbc0ece61e3 100644
--- a/Documentation/git-repack.txt
+++ b/Documentation/git-repack.txt
@@ -165,7 +165,7 @@ depth is 4095.
 	Exclude the given pack from repacking. This is the equivalent
 	of having `.keep` file on the pack. `<pack-name>` is the
 	pack file name without leading directory (e.g. `pack-123.pack`).
-	The option could be specified multiple times to keep multiple
+	The option can be specified multiple times to keep multiple
 	packs.
 
 --unpack-unreachable=<when>::
diff --git a/Documentation/git-restore.txt b/Documentation/git-restore.txt
index c70444705b5..ad546a37cff 100644
--- a/Documentation/git-restore.txt
+++ b/Documentation/git-restore.txt
@@ -105,7 +105,7 @@ in linkgit:git-checkout[1] for details.
 	specified. Unmerged paths on the working tree are left alone.
 
 --ignore-skip-worktree-bits::
-	In sparse checkout mode, by default is to only update entries
+	In sparse checkout mode, the default is to only update entries
 	matched by `<pathspec>` and sparse patterns in
 	$GIT_DIR/info/sparse-checkout. This option ignores the sparse
 	patterns and unconditionally restores any files in
diff --git a/Documentation/git-rev-list.txt b/Documentation/git-rev-list.txt
index 51029a22715..fbe913ee746 100644
--- a/Documentation/git-rev-list.txt
+++ b/Documentation/git-rev-list.txt
@@ -17,7 +17,7 @@ DESCRIPTION
 :git-rev-list: 1
 include::rev-list-description.txt[]
 
-'rev-list' is a very essential Git command, since it
+'rev-list' is an essential Git command, since it
 provides the ability to build and traverse commit ancestry graphs. For
 this reason, it has a lot of different options that enables it to be
 used by commands as different as 'git bisect' and
diff --git a/Documentation/git-rev-parse.txt b/Documentation/git-rev-parse.txt
index 6a4968f68a3..2294e9a519a 100644
--- a/Documentation/git-rev-parse.txt
+++ b/Documentation/git-rev-parse.txt
@@ -36,7 +36,7 @@ Each of these options must appear first on the command line.
 --sq-quote::
 	Use 'git rev-parse' in shell quoting mode (see SQ-QUOTE
 	section below). In contrast to the `--sq` option below, this
-	mode does only quoting. Nothing else is done to command input.
+	mode only does quoting. Nothing else is done to command input.
 
 Options for --parseopt
 ~~~~~~~~~~~~~~~~~~~~~~
diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
index 492a82323da..e90d041817e 100644
--- a/Documentation/git-send-email.txt
+++ b/Documentation/git-send-email.txt
@@ -468,8 +468,8 @@ Information
 
 --dump-aliases::
 	Instead of the normal operation, dump the shorthand alias names from
-	the configured alias file(s), one per line in alphabetical order. Note,
-	this only includes the alias name and not its expanded email addresses.
+	the configured alias file(s), one per line in alphabetical order. Note
+	that this only includes the alias name and not its expanded email addresses.
 	See 'sendemail.aliasesfile' for more information about aliases.
 
 
diff --git a/Documentation/git-send-pack.txt b/Documentation/git-send-pack.txt
index 595b002152f..e76c262d7f9 100644
--- a/Documentation/git-send-pack.txt
+++ b/Documentation/git-send-pack.txt
@@ -55,7 +55,7 @@ be in a separate packet, and the list must end with a flush packet.
 --force::
 	Usually, the command refuses to update a remote ref that
 	is not an ancestor of the local ref used to overwrite it.
-	This flag disables the check.  What this means is that
+	This flag disables the check.  This means that
 	the remote repository can lose commits; use it with
 	care.
 
@@ -117,7 +117,7 @@ When one or more '<ref>' are specified explicitly (whether on the
 command line or via `--stdin`), it can be either a
 single pattern, or a pair of such pattern separated by a colon
 ":" (this means that a ref name cannot have a colon in it).  A
-single pattern '<name>' is just a shorthand for '<name>:<name>'.
+single pattern '<name>' is just shorthand for '<name>:<name>'.
 
 Each pattern pair consists of the source side (before the colon)
 and the destination side (after the colon).  The ref to be
@@ -143,9 +143,9 @@ name. See linkgit:git-rev-parse[1].
 
 Without `--force`, the <src> ref is stored at the remote only if
 <dst> does not exist, or <dst> is a proper subset (i.e. an
-ancestor) of <src>.  This check, known as "fast-forward check",
-is performed in order to avoid accidentally overwriting the
-remote ref and lose other peoples' commits from there.
+ancestor) of <src>.  This check, known as the "fast-forward check",
+is performed to avoid accidentally overwriting the
+remote ref and losing other people's commits from there.
 
 With `--force`, the fast-forward check is disabled for all refs.
 
diff --git a/Documentation/git-status.txt b/Documentation/git-status.txt
index b27d127b5e2..51f38218f0d 100644
--- a/Documentation/git-status.txt
+++ b/Documentation/git-status.txt
@@ -251,7 +251,7 @@ Submodules have more state and instead report
 		m    the submodule has modified content
 		?    the submodule has untracked files
 
-since modified content or untracked files in a submodule cannot be added
+This is since modified content or untracked files in a submodule cannot be added
 via `git add` in the superproject to prepare a commit.
 
 'm' and '?' are applied recursively. For example if a nested submodule
diff --git a/Documentation/git-stripspace.txt b/Documentation/git-stripspace.txt
index 2438f76da05..3dc630da4b7 100644
--- a/Documentation/git-stripspace.txt
+++ b/Documentation/git-stripspace.txt
@@ -41,7 +41,7 @@ OPTIONS
 
 -c::
 --comment-lines::
-	Prepend comment character and blank to each line. Lines will automatically
+	Prepend the comment character and a blank space to each line. Lines will automatically
 	be terminated with a newline. On empty lines, only the comment character
 	will be prepended.
 
diff --git a/Documentation/git-var.txt b/Documentation/git-var.txt
index c38fb3968bc..0680568dfda 100644
--- a/Documentation/git-var.txt
+++ b/Documentation/git-var.txt
@@ -19,7 +19,7 @@ no value.
 OPTIONS
 -------
 -l::
-	Cause the logical variables to be listed. In addition, all the
+	Display the logical variables. In addition, all the
 	variables of the Git configuration file .git/config are listed
 	as well. (However, the configuration variables listing functionality
 	is deprecated in favor of `git config -l`.)
diff --git a/Documentation/git-whatchanged.txt b/Documentation/git-whatchanged.txt
index 8b63ceb00e7..5cbb31f33e3 100644
--- a/Documentation/git-whatchanged.txt
+++ b/Documentation/git-whatchanged.txt
@@ -20,7 +20,7 @@ New users are encouraged to use linkgit:git-log[1] instead.  The
 `whatchanged` command is essentially the same as linkgit:git-log[1]
 but defaults to show the raw format diff output and to skip merges.
 
-The command is kept primarily for historical reasons; fingers of
+The command is primarily kept for historical reasons; fingers of
 many people who learned Git long before `git log` was invented by
 reading Linux kernel mailing list are trained to type it.
 
diff --git a/Documentation/gitformat-bundle.txt b/Documentation/gitformat-bundle.txt
index 00e0a20e657..f1acf196e10 100644
--- a/Documentation/gitformat-bundle.txt
+++ b/Documentation/gitformat-bundle.txt
@@ -86,10 +86,10 @@ In the bundle format, there can be a comment following a prerequisite obj-id.
 This is a comment and it has no specific meaning. The writer of the bundle MAY
 put any string here. The reader of the bundle MUST ignore the comment.
 
-Note on the shallow clone and a Git bundle
-~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+Note on shallow clones and Git bundles
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
-Note that the prerequisites does not represent a shallow-clone boundary. The
+Note that the prerequisites do not represent a shallow-clone boundary. The
 semantics of the prerequisites and the shallow-clone boundaries are different,
 and the Git bundle v2 format cannot represent a shallow clone repository.
 
diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
index 86f804720ae..63eb030b34d 100644
--- a/Documentation/githooks.txt
+++ b/Documentation/githooks.txt
@@ -345,7 +345,7 @@ for the user.
 
 The default 'update' hook, when enabled--and with
 `hooks.allowunannotated` config option unset or set to false--prevents
-unannotated tags to be pushed.
+unannotated tags from being pushed.
 
 [[proc-receive]]
 proc-receive
diff --git a/Documentation/gitprotocol-capabilities.txt b/Documentation/gitprotocol-capabilities.txt
index 0fb5ea0c1ca..5d5e39a7039 100644
--- a/Documentation/gitprotocol-capabilities.txt
+++ b/Documentation/gitprotocol-capabilities.txt
@@ -61,8 +61,8 @@ complete cut across the DAG, or the client has said "done".
 Without multi_ack, a client sends have lines in --date-order until
 the server has found a common base.  That means the client will send
 have lines that are already known by the server to be common, because
-they overlap in time with another branch that the server hasn't found
-a common base on yet.
+they overlap in time with another branch on which the server hasn't found
+a common base yet.
 
 For example suppose the client has commits in caps that the server
 doesn't and the server has commits in lower case that the client
@@ -135,7 +135,7 @@ to disable the feature in a backwards-compatible manner.
 side-band, side-band-64k
 ------------------------
 
-This capability means that server can send, and client understand multiplexed
+This capability means that the server can send, and the client can understand, multiplexed
 progress reports and error info interleaved with the packfile itself.
 
 These two options are mutually exclusive. A modern client always
@@ -163,14 +163,14 @@ Further, with side-band and its up to 1000-byte messages, it's actually
 same deal, you have up to 65519 bytes of data and 1 byte for the stream
 code.
 
-The client MUST send only maximum of one of "side-band" and "side-
-band-64k".  Server MUST diagnose it as an error if client requests
+The client MUST send only one of "side-band" and "side-
+band-64k".  The server MUST diagnose it as an error if client requests
 both.
 
 ofs-delta
 ---------
 
-Server can send, and client understand PACKv2 with delta referring to
+The server can send, and the client can understand, PACKv2 with delta referring to
 its base by position in pack rather than by an obj-id.  That is, they can
 send/read OBJ_OFS_DELTA (aka type 6) in a packfile.
 
@@ -252,7 +252,7 @@ the current shallow boundary, instead of the depth from remote refs.
 no-progress
 -----------
 
-The client was started with "git clone -q" or something, and doesn't
+The client was started with "git clone -q" or something similar, and doesn't
 want that side band 2.  Basically the client just says "I do not
 wish to receive stream 2 on sideband, so do not send it to me, and if
 you did, I will drop it on the floor anyway".  However, the sideband
diff --git a/Documentation/gitprotocol-http.txt b/Documentation/gitprotocol-http.txt
index ccc13f0a407..fcc2b25ee9f 100644
--- a/Documentation/gitprotocol-http.txt
+++ b/Documentation/gitprotocol-http.txt
@@ -379,7 +379,7 @@ C: Place any object seen into set `advertised`.
 C: Build an empty set, `common`, to hold the objects that are later
    determined to be on both ends.
 
-C: Build a set, `want`, of the objects from `advertised` the client
+C: Build a set, `want`, of the objects from `advertised` that the client
    wants to fetch, based on what it saw during ref discovery.
 
 C: Start a queue, `c_pending`, ordered by commit time (popping newest
@@ -423,7 +423,7 @@ multiple commands. Object names MUST be given using the object format
 negotiated through the `object-format` capability (default SHA-1).
 
 The `have` list is created by popping the first 32 commits
-from `c_pending`.  Less can be supplied if `c_pending` empties.
+from `c_pending`.  Fewer can be supplied if `c_pending` empties.
 
 If the client has sent 256 "have" commits and has not yet
 received one of those back from `s_common`, or the client has
diff --git a/Documentation/gitweb.txt b/Documentation/gitweb.txt
index af6bf3c45ec..bb9cbad7f3f 100644
--- a/Documentation/gitweb.txt
+++ b/Documentation/gitweb.txt
@@ -20,13 +20,13 @@ Gitweb provides a web interface to Git repositories.  Its features include:
 * Browsing every revision of the repository.
 * Viewing the contents of files in the repository at any revision.
 * Viewing the revision log of branches, history of files and directories,
-  see what was changed when, by who.
+  seeing what was changed, when, and by whom.
 * Viewing the blame/annotation details of any file (if enabled).
 * Generating RSS and Atom feeds of commits, for any branch.
   The feeds are auto-discoverable in modern web browsers.
 * Viewing everything that was changed in a revision, and step through
   revisions one at a time, viewing the history of the repository.
-* Finding commits which commit messages matches given search term.
+* Finding commits whose commit messages match a given search term.
 
 See http://repo.or.cz/w/git.git/tree/HEAD:/gitweb/[] for gitweb source code,
 browsed using gitweb itself.
diff --git a/Documentation/howto/maintain-git.txt b/Documentation/howto/maintain-git.txt
index d07c6d44e53..29c473e5e04 100644
--- a/Documentation/howto/maintain-git.txt
+++ b/Documentation/howto/maintain-git.txt
@@ -104,7 +104,7 @@ by doing the following:
    files in mbox format).
 
  - Write his own patches to address issues raised on the list but
-   nobody has stepped up solving.  Send it out just like other
+   nobody has stepped up to solve.  Send it out just like other
    contributors do, and pick them up just like patches from other
    contributors (see above).
 
@@ -417,7 +417,7 @@ are merged together, the reference to the variable newly added by
 the latter topic will still use the old name in the result.
 
 The Meta/Reintegrate script that is used by redo-jch and redo-seen
-scripts implements a crude but usable way to work this issue around.
+scripts implements a crude but usable way to work around this issue.
 When the script merges branch $X, it checks if "refs/merge-fix/$X"
 exists, and if so, the effect of it is squashed into the result of
 the mechanical merge.  In other words,
diff --git a/Documentation/howto/using-merge-subtree.txt b/Documentation/howto/using-merge-subtree.txt
index a499a94ac22..3bd581ac359 100644
--- a/Documentation/howto/using-merge-subtree.txt
+++ b/Documentation/howto/using-merge-subtree.txt
@@ -11,7 +11,7 @@ Message-ID: <BAYC1-PASMTP12374B54BA370A1E1C6E78AE4E0@CEZ.ICE>
 How to use the subtree merge strategy
 =====================================
 
-There are situations where you want to include contents in your project
+There are situations where you want to include content in your project
 from an independently developed project. You can just pull from the
 other project as long as there are no conflicting paths.
 
diff --git a/Documentation/i18n.txt b/Documentation/i18n.txt
index 6c6baeeeb75..0efb1153d27 100644
--- a/Documentation/i18n.txt
+++ b/Documentation/i18n.txt
@@ -46,7 +46,7 @@ mind.
 ------------
 +
 Commit objects created with the above setting record the value
-of `i18n.commitEncoding` in its `encoding` header.  This is to
+of `i18n.commitEncoding` in their `encoding` header.  This is to
 help other people who look at them later.  Lack of this header
 implies that the commit log message is encoded in UTF-8.
 
diff --git a/Documentation/mergetools/vimdiff.txt b/Documentation/mergetools/vimdiff.txt
index 2d631e9b1f2..c36c5479392 100644
--- a/Documentation/mergetools/vimdiff.txt
+++ b/Documentation/mergetools/vimdiff.txt
@@ -32,10 +32,10 @@ have special meaning:
   - `+` is used to "open a new tab"
   - `,` is used to "open a new vertical split"
   - `/` is used to "open a new horizontal split"
-  - `@` is used to indicate which is the file containing the final version after
+  - `@` is used to indicate the file containing the final version after
     solving the conflicts. If not present, `MERGED` will be used by default.
 
-The precedence of the operators is this one (you can use parentheses to change
+The precedence of the operators is as follows (you can use parentheses to change
 it):
 
     `@` > `+` > `/` > `,`
diff --git a/Documentation/technical/api-simple-ipc.txt b/Documentation/technical/api-simple-ipc.txt
index d44ada98e7d..6c127b5dddf 100644
--- a/Documentation/technical/api-simple-ipc.txt
+++ b/Documentation/technical/api-simple-ipc.txt
@@ -102,4 +102,4 @@ stateless request, receive an application-specific
 response, and disconnect.  It is a one round trip facility for
 querying the server.  The Simple-IPC routines hide the socket,
 named pipe, and thread pool details and allow the application
-layer to focus on the application at hand.
+layer to focus on the task at hand.
diff --git a/Documentation/technical/bitmap-format.txt b/Documentation/technical/bitmap-format.txt
index c2e652b71a7..687c58cebcc 100644
--- a/Documentation/technical/bitmap-format.txt
+++ b/Documentation/technical/bitmap-format.txt
@@ -114,7 +114,7 @@ result in an empty bitmap (no bits set).
 
     * N entries with compressed bitmaps, one for each indexed commit
 +
-Where `N` is the total amount of entries in this bitmap index.
+Where `N` is the total number of entries in this bitmap index.
 Each entry contains the following:
 
 	** {empty}
diff --git a/Documentation/technical/parallel-checkout.txt b/Documentation/technical/parallel-checkout.txt
index 47c9b6183cf..91a5eb26efd 100644
--- a/Documentation/technical/parallel-checkout.txt
+++ b/Documentation/technical/parallel-checkout.txt
@@ -185,7 +185,7 @@ quite straightforward: for each parallel-eligible entry, the main
 process must remove all files that prevent this entry from being written
 (before enqueueing it). This includes any non-directory file in the
 leading path of the entry. Later, when a worker gets assigned the entry,
-it looks again for the non-directories files and for an already existing
+it looks again for the non-directory files and for an already existing
 file at the entry's path. If any of these checks finds something, the
 worker knows that there was a path collision.
 
diff --git a/Documentation/technical/partial-clone.txt b/Documentation/technical/partial-clone.txt
index 92fcee2bfff..b01cff6912a 100644
--- a/Documentation/technical/partial-clone.txt
+++ b/Documentation/technical/partial-clone.txt
@@ -265,7 +265,7 @@ Future Work
 - Improve the way to specify the order in which promisor remotes are
   tried.
 +
-For example this could allow to specify explicitly something like:
+For example this could allow specifying explicitly something like:
 "When fetching from this remote, I want to use these promisor remotes
 in this order, though, when pushing or fetching to that remote, I want
 to use those promisor remotes in that order."
diff --git a/Documentation/technical/racy-git.txt b/Documentation/technical/racy-git.txt
index ceda4bbfda4..783e87e6aa4 100644
--- a/Documentation/technical/racy-git.txt
+++ b/Documentation/technical/racy-git.txt
@@ -165,9 +165,9 @@ Avoiding runtime penalty
 
 In order to avoid the above runtime penalty, post 1.4.2 Git used
 to have a code that made sure the index file
-got timestamp newer than the youngest files in the index when
-there are many young files with the same timestamp as the
-resulting index file would otherwise would have by waiting
+got a timestamp newer than the youngest files in the index when
+there were many young files with the same timestamp as the
+resulting index file otherwise would have by waiting
 before finishing writing the index file out.
 
 I suspected that in practice the situation where many paths in the
diff --git a/Documentation/technical/reftable.txt b/Documentation/technical/reftable.txt
index 6a67cc4174f..d7d066d876a 100644
--- a/Documentation/technical/reftable.txt
+++ b/Documentation/technical/reftable.txt
@@ -115,7 +115,7 @@ Varint encoding
 Varint encoding is identical to the ofs-delta encoding method used
 within pack files.
 
-Decoder works such as:
+Decoder works as follows:
 
 ....
 val = buf[ptr] & 0x7f
diff --git a/Documentation/urls.txt b/Documentation/urls.txt
index 1c229d75815..4e79c1589ec 100644
--- a/Documentation/urls.txt
+++ b/Documentation/urls.txt
@@ -6,9 +6,9 @@ address of the remote server, and the path to the repository.
 Depending on the transport protocol, some of this information may be
 absent.
 
-Git supports ssh, git, http, and https protocols (in addition, ftp,
+Git supports ssh, git, http, and https protocols (in addition, ftp
 and ftps can be used for fetching, but this is inefficient and
-deprecated; do not use it).
+deprecated; do not use them).
 
 The native transport (i.e. git:// URL) does no authentication and
 should be used with caution on unsecured networks.
-- 
gitgitgadget

