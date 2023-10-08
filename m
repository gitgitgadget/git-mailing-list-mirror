Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D49DE95A8F
	for <git@archiver.kernel.org>; Sun,  8 Oct 2023 06:45:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344500AbjJHGpt (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 8 Oct 2023 02:45:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344463AbjJHGpj (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Oct 2023 02:45:39 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D740EB
        for <git@vger.kernel.org>; Sat,  7 Oct 2023 23:45:35 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-3296b49c546so1669808f8f.3
        for <git@vger.kernel.org>; Sat, 07 Oct 2023 23:45:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696747534; x=1697352334; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n+LxlLvO3CGNUBQnzBJKxqmEEBGyBzkIuK8HqcBDxds=;
        b=TmSOPD3gWKWIT6ItwQYAwXqQSx9K5AgkKcvPYBNiqZUflNSuxICoG5hY+UKgDBNiFR
         MKvkNYwmJD5HP91SWzXQalCEcU2BVhTDE0BvJVF78EMZVJdDdYzSDJErBiSRHPGtjz+l
         SdstkMan4WL4y6cua8NlLXQJRpcwxIKNnh1eEUNjSPI0qUeLxflbvngjeAnbcKcHUVmN
         ePBjuJBszBkiahkSkMvSJa10PYrEh+HmG0nSqF2YXvc+nqpBbeuuILQXP3cxGuccHuBb
         qFMhAho1KYPaebbUpi6aElxMNLgHXZHRyIVTv5izV71O6uEsIf4B4SG0Irp7ThZCK1bs
         /s/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696747534; x=1697352334;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n+LxlLvO3CGNUBQnzBJKxqmEEBGyBzkIuK8HqcBDxds=;
        b=h5ChMxBWJznp1lzhP4wOyG82RzJSauTKPInvfHhq3J6KGBAjweuWnH06oVh0TThd0F
         yNErYaayRfRuZSDPsFn+DMgcEWvKoroZurI018EyaIRkP4N29qwaSuL77zmLwJlRnOve
         Y8Bul3LlomXs2b6wi4iSIzMNbaSoogKcUuOg0L3W2l3ffSeBhGDu5RM6NButA08NCgPA
         T2/tvmq+aaY2IQPHCm5zuLFPrO9GqcVmkKh4/Kp/TrYk3KGbGsJ8UvJCAkLeKNWo4Kre
         DW/yEJwcYcDEVScBhxc9CTvxTYBt3VsLLzBVHqgg0qvhwo1PNcg9mOuc28kOlGJSFv3E
         Zg4w==
X-Gm-Message-State: AOJu0Yz81behxnTiNxb4GYjq0z4MUcI3QV1JunUapvxvWkJ5SBgrQxox
        wp/sfoyA+BkISjsFuB7ij7OOP8gNLVI=
X-Google-Smtp-Source: AGHT+IH2Dzlomz0BUvqTkAwXgAdygGoVCpeejv6b9DPEhRL5tks1D/bWLf+VZF/s9oRXTz14af/ocQ==
X-Received: by 2002:adf:f546:0:b0:317:634c:46e9 with SMTP id j6-20020adff546000000b00317634c46e9mr10792194wrp.43.1696747534087;
        Sat, 07 Oct 2023 23:45:34 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z9-20020adff749000000b00318147fd2d3sm6036344wrp.41.2023.10.07.23.45.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Oct 2023 23:45:33 -0700 (PDT)
Message-ID: <aa350fd858bc1eeddac67c4d678210f77fd9f0b8.1696747529.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1595.git.1696747527.gitgitgadget@gmail.com>
References: <pull.1595.git.1696747527.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 08 Oct 2023 06:45:07 +0000
Subject: [PATCH 05/25] documentation: add missing words
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
 Documentation/config/advice.txt            | 2 +-
 Documentation/config/checkout.txt          | 2 +-
 Documentation/config/http.txt              | 2 +-
 Documentation/config/mergetool.txt         | 2 +-
 Documentation/config/sendemail.txt         | 2 +-
 Documentation/git-checkout.txt             | 2 +-
 Documentation/git-credential-cache.txt     | 2 +-
 Documentation/git-credential-store.txt     | 2 +-
 Documentation/git-difftool.txt             | 2 +-
 Documentation/git-fetch-pack.txt           | 2 +-
 Documentation/git-mktag.txt                | 2 +-
 Documentation/git-prune-packed.txt         | 2 +-
 Documentation/git-restore.txt              | 2 +-
 Documentation/gitprotocol-v2.txt           | 2 +-
 Documentation/howto/use-git-daemon.txt     | 2 +-
 Documentation/technical/api-simple-ipc.txt | 2 +-
 Documentation/technical/partial-clone.txt  | 2 +-
 Documentation/technical/racy-git.txt       | 2 +-
 Documentation/technical/rerere.txt         | 2 +-
 19 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/Documentation/config/advice.txt b/Documentation/config/advice.txt
index c548a91e676..f4864a2d58b 100644
--- a/Documentation/config/advice.txt
+++ b/Documentation/config/advice.txt
@@ -101,7 +101,7 @@ advice.*::
 		otherwise caused a remote-tracking branch to be
 		checked out. See the `checkout.defaultRemote`
 		configuration variable for how to set a given remote
-		to used by default in some situations where this
+		to be used by default in some situations where this
 		advice would be printed.
 	amWorkDir::
 		Advice that shows the location of the patch file when
diff --git a/Documentation/config/checkout.txt b/Documentation/config/checkout.txt
index bfbca90f0e9..a54faab238a 100644
--- a/Documentation/config/checkout.txt
+++ b/Documentation/config/checkout.txt
@@ -39,6 +39,6 @@ well the parallel version performs.
 checkout.thresholdForParallelism::
 	When running parallel checkout with a small number of files, the cost
 	of subprocess spawning and inter-process communication might outweigh
-	the parallelization gains. This setting allows to define the minimum
+	the parallelization gains. This setting allows you to define the minimum
 	number of files for which parallel checkout should be attempted. The
 	default is 100.
diff --git a/Documentation/config/http.txt b/Documentation/config/http.txt
index 1d805fdddbc..2d4e0c9b869 100644
--- a/Documentation/config/http.txt
+++ b/Documentation/config/http.txt
@@ -254,7 +254,7 @@ http.lowSpeedLimit, http.lowSpeedTime::
 
 http.noEPSV::
 	A boolean which disables using of EPSV ftp command by curl.
-	This can helpful with some "poor" ftp servers which don't
+	This can be helpful with some "poor" ftp servers which don't
 	support EPSV mode. Can be overridden by the `GIT_CURL_FTP_NO_EPSV`
 	environment variable. Default is false (curl will use EPSV).
 
diff --git a/Documentation/config/mergetool.txt b/Documentation/config/mergetool.txt
index e9abde9d60c..fe4ba0271b5 100644
--- a/Documentation/config/mergetool.txt
+++ b/Documentation/config/mergetool.txt
@@ -22,7 +22,7 @@ mergetool.<tool>.trustExitCode::
 	For a custom merge command, specify whether the exit code of
 	the merge command can be used to determine whether the merge was
 	successful.  If this is not set to true then the merge target file
-	timestamp is checked and the merge assumed to have been successful
+	timestamp is checked and the merge is assumed to have been successful
 	if the file has been updated, otherwise the user is prompted to
 	indicate the success of the merge.
 
diff --git a/Documentation/config/sendemail.txt b/Documentation/config/sendemail.txt
index 92a9ebe98c6..51b1b5fe7e3 100644
--- a/Documentation/config/sendemail.txt
+++ b/Documentation/config/sendemail.txt
@@ -91,7 +91,7 @@ sendemail.smtpBatchSize::
 	See also the `--batch-size` option of linkgit:git-send-email[1].
 
 sendemail.smtpReloginDelay::
-	Seconds wait before reconnecting to smtp server.
+	Seconds to wait before reconnecting to smtp server.
 	See also the `--relogin-delay` option of linkgit:git-send-email[1].
 
 sendemail.forbidSendmailVariables::
diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkout.txt
index a30e3ebc51f..240c54639e8 100644
--- a/Documentation/git-checkout.txt
+++ b/Documentation/git-checkout.txt
@@ -43,7 +43,7 @@ $ git checkout -b <branch> --track <remote>/<branch>
 You could omit `<branch>`, in which case the command degenerates to
 "check out the current branch", which is a glorified no-op with
 rather expensive side-effects to show only the tracking information,
-if exists, for the current branch.
+if it exists, for the current branch.
 
 'git checkout' -b|-B <new-branch> [<start-point>]::
 
diff --git a/Documentation/git-credential-cache.txt b/Documentation/git-credential-cache.txt
index f473994a864..487cc557a87 100644
--- a/Documentation/git-credential-cache.txt
+++ b/Documentation/git-credential-cache.txt
@@ -16,7 +16,7 @@ DESCRIPTION
 
 This command caches credentials for use by future Git programs.
 The stored credentials are kept in memory of the cache-daemon
-process (instead of written to a file) and are forgotten after a
+process (instead of being written to a file) and are forgotten after a
 configurable timeout. Credentials are forgotten sooner if the
 cache-daemon dies, for example if the system restarts. The cache
 is accessible over a Unix domain socket, restricted to the current
diff --git a/Documentation/git-credential-store.txt b/Documentation/git-credential-store.txt
index 76b07988563..71864a87264 100644
--- a/Documentation/git-credential-store.txt
+++ b/Documentation/git-credential-store.txt
@@ -33,7 +33,7 @@ OPTIONS
 
 	Use `<path>` to lookup and store credentials. The file will have its
 	filesystem permissions set to prevent other users on the system
-	from reading it, but will not be encrypted or otherwise
+	from reading it, but it will not be encrypted or otherwise
 	protected. If not specified, credentials will be searched for from
 	`~/.git-credentials` and `$XDG_CONFIG_HOME/git/credentials`, and
 	credentials will be written to `~/.git-credentials` if it exists, or
diff --git a/Documentation/git-difftool.txt b/Documentation/git-difftool.txt
index ac0ac6fa022..179e5ae2162 100644
--- a/Documentation/git-difftool.txt
+++ b/Documentation/git-difftool.txt
@@ -78,7 +78,7 @@ with custom merge tool commands and has the same value as `$MERGED`.
 	Print a list of diff tools that may be used with `--tool`.
 
 --[no-]symlinks::
-	'git difftool''s default behavior is create symlinks to the
+	'git difftool''s default behavior is to create symlinks to the
 	working tree when run in `--dir-diff` mode and the right-hand
 	side of the comparison yields the same content as the file in
 	the working tree.
diff --git a/Documentation/git-fetch-pack.txt b/Documentation/git-fetch-pack.txt
index 46747d5f429..b3467664d30 100644
--- a/Documentation/git-fetch-pack.txt
+++ b/Documentation/git-fetch-pack.txt
@@ -69,7 +69,7 @@ be in a separate packet, and the list must end with a flush packet.
 
 --upload-pack=<git-upload-pack>::
 	Use this to specify the path to 'git-upload-pack' on the
-	remote side, if is not found on your $PATH.
+	remote side, if it is not found on your $PATH.
 	Installations of sshd ignores the user's environment
 	setup scripts for login shells (e.g. .bash_profile) and
 	your privately installed git may not be found on the system
diff --git a/Documentation/git-mktag.txt b/Documentation/git-mktag.txt
index cd8fe9169e8..7a014962343 100644
--- a/Documentation/git-mktag.txt
+++ b/Documentation/git-mktag.txt
@@ -27,7 +27,7 @@ write a tag found in `my-tag`:
 The difference is that mktag will die before writing the tag if the
 tag doesn't pass a linkgit:git-fsck[1] check.
 
-The "fsck" check done mktag is stricter than what linkgit:git-fsck[1]
+The "fsck" check done by mktag is stricter than what linkgit:git-fsck[1]
 would run by default in that all `fsck.<msg-id>` messages are promoted
 from warnings to errors (so e.g. a missing "tagger" line is an error).
 
diff --git a/Documentation/git-prune-packed.txt b/Documentation/git-prune-packed.txt
index 844d6f808a0..db742dcfeea 100644
--- a/Documentation/git-prune-packed.txt
+++ b/Documentation/git-prune-packed.txt
@@ -15,7 +15,7 @@ SYNOPSIS
 DESCRIPTION
 -----------
 This program searches the `$GIT_OBJECT_DIRECTORY` for all objects that currently
-exist in a pack file as well as the independent object directories.
+exist in a pack file as well as in the independent object directories.
 
 All such extra objects are removed.
 
diff --git a/Documentation/git-restore.txt b/Documentation/git-restore.txt
index ad546a37cff..975825b44aa 100644
--- a/Documentation/git-restore.txt
+++ b/Documentation/git-restore.txt
@@ -199,7 +199,7 @@ the same as using linkgit:git-reset[1])
 $ git restore --staged hello.c
 ------------
 
-or you can restore both the index and the working tree (this the same
+or you can restore both the index and the working tree (this is the same
 as using linkgit:git-checkout[1])
 
 ------------
diff --git a/Documentation/gitprotocol-v2.txt b/Documentation/gitprotocol-v2.txt
index acb97ad0c22..8c1e7c61eac 100644
--- a/Documentation/gitprotocol-v2.txt
+++ b/Documentation/gitprotocol-v2.txt
@@ -29,7 +29,7 @@ protocol.  Protocol v2 will improve upon v1 in the following ways:
     semantics the http remote helper can simply act as a proxy
 
 In protocol v2 communication is command oriented.  When first contacting a
-server a list of capabilities will advertised.  Some of these capabilities
+server a list of capabilities will be advertised.  Some of these capabilities
 will be commands which a client can request be executed.  Once a command
 has completed, a client can reuse the connection and request that other
 commands be executed.
diff --git a/Documentation/howto/use-git-daemon.txt b/Documentation/howto/use-git-daemon.txt
index 7af2e52cf31..2cad9b3ca53 100644
--- a/Documentation/howto/use-git-daemon.txt
+++ b/Documentation/howto/use-git-daemon.txt
@@ -4,7 +4,7 @@ How to use git-daemon
 =====================
 
 Git can be run in inetd mode and in stand alone mode. But all you want is
-let a coworker pull from you, and therefore need to set up a Git server
+to let a coworker pull from you, and therefore need to set up a Git server
 real quick, right?
 
 Note that git-daemon is not really chatty at the moment, especially when
diff --git a/Documentation/technical/api-simple-ipc.txt b/Documentation/technical/api-simple-ipc.txt
index 6c127b5dddf..d88b1ef206e 100644
--- a/Documentation/technical/api-simple-ipc.txt
+++ b/Documentation/technical/api-simple-ipc.txt
@@ -20,7 +20,7 @@ IPC-client.
 
 The IPC-client routines within a client application process connect
 to the IPC-server and send a request message and wait for a response.
-When received, the response is returned back the caller.
+When received, the response is returned back to the caller.
 
 For example, the `fsmonitor--daemon` feature will be built as a server
 application on top of the IPC-server library routines.  It will have
diff --git a/Documentation/technical/partial-clone.txt b/Documentation/technical/partial-clone.txt
index b01cff6912a..1719c723f5c 100644
--- a/Documentation/technical/partial-clone.txt
+++ b/Documentation/technical/partial-clone.txt
@@ -3,7 +3,7 @@ Partial Clone Design Notes
 
 The "Partial Clone" feature is a performance optimization for Git that
 allows Git to function without having a complete copy of the repository.
-The goal of this work is to allow Git better handle extremely large
+The goal of this work is to allow Git to better handle extremely large
 repositories.
 
 During clone and fetch operations, Git downloads the complete contents
diff --git a/Documentation/technical/racy-git.txt b/Documentation/technical/racy-git.txt
index 783e87e6aa4..02ae508d227 100644
--- a/Documentation/technical/racy-git.txt
+++ b/Documentation/technical/racy-git.txt
@@ -11,7 +11,7 @@ write out the next tree object to be committed.  The state is
 "virtual" in the sense that it does not necessarily have to, and
 often does not, match the files in the working tree.
 
-There are cases Git needs to examine the differences between the
+There are cases where Git needs to examine the differences between the
 virtual working tree state in the index and the files in the
 working tree.  The most obvious case is when the user asks `git
 diff` (or its low level implementation, `git diff-files`) or
diff --git a/Documentation/technical/rerere.txt b/Documentation/technical/rerere.txt
index 3f9259cb1e4..5f4dd7c1028 100644
--- a/Documentation/technical/rerere.txt
+++ b/Documentation/technical/rerere.txt
@@ -60,7 +60,7 @@ By resolving this conflict, to leave line D, the user declares:
     what AB and AC wanted to do.
 
 As branch AC2 refers to the same commit as AC, the above implies that
-this is also compatible what AB and AC2 wanted to do.
+this is also compatible with what AB and AC2 wanted to do.
 
 By extension, this means that rerere should recognize that the above
 conflicts are the same.  To do this, the labels on the conflict
-- 
gitgitgadget

