Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E08CBE95A92
	for <git@archiver.kernel.org>; Sun,  8 Oct 2023 06:45:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344516AbjJHGpv (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 8 Oct 2023 02:45:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344474AbjJHGpj (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Oct 2023 02:45:39 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C3EEF1
        for <git@vger.kernel.org>; Sat,  7 Oct 2023 23:45:36 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-405417465aaso33736845e9.1
        for <git@vger.kernel.org>; Sat, 07 Oct 2023 23:45:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696747535; x=1697352335; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P3H6+CVL3uSYZ/Fb70xWDz66baGKxkURk09nurDxByg=;
        b=ARakxAS5ohyn4kMkIER2Z1KWtP8Ymkr2ty2VjNxsrNuiBRqHRxNig85eRfZWB8lN7Y
         dCbkzTQMOwaQAwQ42LqulSBlenLq2zX1OGK0QOQk6wtQ/QnfUb4Hg/Yl9PhlaUwYP4Db
         qBEnbZQBMxAHuB5fyAAKGisNftZHhQmFxC6Kw7fXmoA/Cb8Kfz88BUY/7IRXH5KUFyo2
         ydKlNAWNkmlD8G+qj6Fi63bVM4mnHRJCG3KZX/uZy8xA8tKy6afe71ksQPaU5pJzoqAM
         5DbVqCEdFHS0FulivnnXKVnSKab3LAr5JBCZ15/tfI36HgTuqsIVPhe/QvUCCVMw3Uhy
         nH4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696747535; x=1697352335;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P3H6+CVL3uSYZ/Fb70xWDz66baGKxkURk09nurDxByg=;
        b=dbCH2dRT2PM+tQGQoNad4XwEB4i/c6Klou8Q86mcNLuxPBzbttcUozGPSfZMoIJN1I
         zHQOPryWlEubBmMaLon5B1M1UI4nZhg1m/iKyWuz4Nf0tOzPXv7dG1SRIHQdXBf2Aq41
         RzaakknoMqXjNslYaQwfkGOe+MCM8HF6f/5d0dHTFHqi71W4A/WHqxjI2Gn2jXlsvCiU
         kMhms1JSWd2pqw4QYf++0ZNdP4SXPQrpZrb84reUXKVgKkJKlQ6Z1WfX/Okm1i6vMuei
         mch0X9YCLVn7HJvJZfABgmWAtoBgzrZ+pUzXBGeNuO1U2tzbGWhIFWskCk/mga4dHSym
         VuHg==
X-Gm-Message-State: AOJu0YxDRn9t8ov3FmEoaMGUZ/kbDEUoG+yczUN/RTd76+NGNAhmJs8a
        hhr9dXcAq9N4JuzJDxTXx3A060sOkwU=
X-Google-Smtp-Source: AGHT+IEYb1I9srkTVgfCov0Nh7DRo6QCcAg+uuxdhzmhqswMd6K+Vqf5WYGT9nrfs8X+m27qWA2zYQ==
X-Received: by 2002:a5d:558f:0:b0:31f:91ae:4509 with SMTP id i15-20020a5d558f000000b0031f91ae4509mr10209862wrv.40.1696747534595;
        Sat, 07 Oct 2023 23:45:34 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g7-20020adfe407000000b003232d122dbfsm6028369wrm.66.2023.10.07.23.45.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Oct 2023 23:45:34 -0700 (PDT)
Message-ID: <72fea54e2bef4e207376ac6505384fa84dee6d5f.1696747529.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1595.git.1696747527.gitgitgadget@gmail.com>
References: <pull.1595.git.1696747527.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 08 Oct 2023 06:45:08 +0000
Subject: [PATCH 06/25] documentation: remove extraneous words
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
 Documentation/config/branch.txt               | 2 +-
 Documentation/config/gpg.txt                  | 2 +-
 Documentation/config/log.txt                  | 2 +-
 Documentation/config/sendemail.txt            | 2 +-
 Documentation/diff-generate-patch.txt         | 2 +-
 Documentation/git-diff-tree.txt               | 2 +-
 Documentation/git-fsmonitor--daemon.txt       | 2 +-
 Documentation/githooks.txt                    | 2 +-
 Documentation/gitprotocol-common.txt          | 2 +-
 Documentation/gitprotocol-http.txt            | 2 +-
 Documentation/pull-fetch-param.txt            | 2 +-
 Documentation/technical/parallel-checkout.txt | 2 +-
 Documentation/technical/partial-clone.txt     | 2 +-
 Documentation/technical/rerere.txt            | 2 +-
 Documentation/urls-remotes.txt                | 2 +-
 15 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/Documentation/config/branch.txt b/Documentation/config/branch.txt
index 2b05ed3574b..3bec6daf71a 100644
--- a/Documentation/config/branch.txt
+++ b/Documentation/config/branch.txt
@@ -64,7 +64,7 @@ branch.<name>.merge::
 	handled like the remote part of a refspec, and must match a
 	ref which is fetched from the remote given by
 	"branch.<name>.remote".
-	The merge information is used by 'git pull' (which at first calls
+	The merge information is used by 'git pull' (which first calls
 	'git fetch') to lookup the default branch for merging. Without
 	this option, 'git pull' defaults to merge the first refspec fetched.
 	Specify multiple values to get an octopus merge.
diff --git a/Documentation/config/gpg.txt b/Documentation/config/gpg.txt
index a31faab2edd..248d99d70b8 100644
--- a/Documentation/config/gpg.txt
+++ b/Documentation/config/gpg.txt
@@ -38,7 +38,7 @@ gpg.minTrustLevel::
 * `ultimate`
 
 gpg.ssh.defaultKeyCommand::
-	This command that will be run when user.signingkey is not set and a ssh
+	This command will be run when user.signingkey is not set and a ssh
 	signature is requested. On successful exit a valid ssh public key
 	prefixed with `key::` is expected in the first line of its output.
 	This allows for a script doing a dynamic lookup of the correct public
diff --git a/Documentation/config/log.txt b/Documentation/config/log.txt
index 5f96cf87fb9..6e04fbe4f48 100644
--- a/Documentation/config/log.txt
+++ b/Documentation/config/log.txt
@@ -9,7 +9,7 @@ log.date::
 	`--date` option.  See linkgit:git-log[1] for details.
 +
 If the format is set to "auto:foo" and the pager is in use, format
-"foo" will be the used for the date format. Otherwise "default" will
+"foo" will be used for the date format. Otherwise "default" will
 be used.
 
 log.decorate::
diff --git a/Documentation/config/sendemail.txt b/Documentation/config/sendemail.txt
index 51b1b5fe7e3..792e68a4456 100644
--- a/Documentation/config/sendemail.txt
+++ b/Documentation/config/sendemail.txt
@@ -36,7 +36,7 @@ sendemail.aliasesFile::
 
 sendemail.aliasFileType::
 	Format of the file(s) specified in sendemail.aliasesFile. Must be
-	one of 'mutt', 'mailrc', 'pine', 'elm', or 'gnus', or 'sendmail'.
+	one of 'mutt', 'mailrc', 'pine', 'elm', 'gnus', or 'sendmail'.
 +
 What an alias file in each format looks like can be found in
 the documentation of the email program of the same name. The
diff --git a/Documentation/diff-generate-patch.txt b/Documentation/diff-generate-patch.txt
index 55df903abd1..49ad31fca2a 100644
--- a/Documentation/diff-generate-patch.txt
+++ b/Documentation/diff-generate-patch.txt
@@ -77,7 +77,7 @@ separate lines indicate the old and the new mode.
 
 5.  Hunk headers mention the name of the function to which the hunk
     applies.  See "Defining a custom hunk-header" in
-    linkgit:gitattributes[5] for details of how to tailor to this to
+    linkgit:gitattributes[5] for details of how to tailor this to
     specific languages.
 
 
diff --git a/Documentation/git-diff-tree.txt b/Documentation/git-diff-tree.txt
index 81caad5c95c..37ca32c396f 100644
--- a/Documentation/git-diff-tree.txt
+++ b/Documentation/git-diff-tree.txt
@@ -104,7 +104,7 @@ include::pretty-options.txt[]
 	This flag changes the way a merge commit patch is displayed,
 	in a similar way to the `-c` option. It implies the `-c`
 	and `-p` options and further compresses the patch output
-	by omitting uninteresting hunks whose the contents in the parents
+	by omitting uninteresting hunks whose contents in the parents
 	have only two variants and the merge result picks one of them
 	without modification.  When all hunks are uninteresting, the commit
 	itself and the commit log message is not shown, just like in any other
diff --git a/Documentation/git-fsmonitor--daemon.txt b/Documentation/git-fsmonitor--daemon.txt
index 8238eadb0e1..f50a28b09f9 100644
--- a/Documentation/git-fsmonitor--daemon.txt
+++ b/Documentation/git-fsmonitor--daemon.txt
@@ -84,7 +84,7 @@ may or may not have the needed support; the fsmonitor daemon is not guaranteed
 to work with these filesystems and such use is considered experimental.
 
 By default, the socket is created in the `.git` directory, however, if the
-`.git` directory is on a network-mounted filesystem, it will be instead be
+`.git` directory is on a network-mounted filesystem, it will instead be
 created at `$HOME/.git-fsmonitor-*` unless `$HOME` itself is on a
 network-mounted filesystem in which case you must set the configuration
 variable `fsmonitor.socketDir` to the path of a directory on a Mac OS native
diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
index 63eb030b34d..34e2c656de3 100644
--- a/Documentation/githooks.txt
+++ b/Documentation/githooks.txt
@@ -384,7 +384,7 @@ following example for the protocol, the letter 'S' stands for
     H: PKT-LINE(ok <ref>)
     # NO, I reject it.
     H: PKT-LINE(ng <ref> <reason>)
-    # Fall through, let 'receive-pack' to execute it.
+    # Fall through, let 'receive-pack' execute it.
     H: PKT-LINE(ok <ref>)
     H: PKT-LINE(option fall-through)
     # OK, but has an alternate reference.  The alternate reference name
diff --git a/Documentation/gitprotocol-common.txt b/Documentation/gitprotocol-common.txt
index 1486651bd10..cdc9d6e7075 100644
--- a/Documentation/gitprotocol-common.txt
+++ b/Documentation/gitprotocol-common.txt
@@ -13,7 +13,7 @@ SYNOPSIS
 DESCRIPTION
 -----------
 
-This document sets defines things common to various over-the-wire
+This document defines things common to various over-the-wire
 protocols and file formats used in Git.
 
 ABNF Notation
diff --git a/Documentation/gitprotocol-http.txt b/Documentation/gitprotocol-http.txt
index fcc2b25ee9f..21b73b7a1f5 100644
--- a/Documentation/gitprotocol-http.txt
+++ b/Documentation/gitprotocol-http.txt
@@ -42,7 +42,7 @@ both the "smart" and "dumb" HTTP protocols used by Git operate
 by appending additional path components onto the end of the user
 supplied `$GIT_URL` string.
 
-An example of a dumb client requesting for a loose object:
+An example of a dumb client requesting a loose object:
 
   $GIT_URL:     http://example.com:8080/git/repo.git
   URL request:  http://example.com:8080/git/repo.git/objects/d0/49f6c27a2244e12041955e262a404c7faba355
diff --git a/Documentation/pull-fetch-param.txt b/Documentation/pull-fetch-param.txt
index 26bf06d991b..74143ef0d24 100644
--- a/Documentation/pull-fetch-param.txt
+++ b/Documentation/pull-fetch-param.txt
@@ -80,7 +80,7 @@ configuration which'll amend these rules, and nothing like a
 +
 As with pushing with linkgit:git-push[1], all of the rules described
 above about what's not allowed as an update can be overridden by
-adding an the optional leading `+` to a refspec (or using `--force`
+adding an optional leading `+` to a refspec (or using `--force`
 command line option). The only exception to this is that no amount of
 forcing will make the `refs/heads/*` namespace accept a non-commit
 object.
diff --git a/Documentation/technical/parallel-checkout.txt b/Documentation/technical/parallel-checkout.txt
index 1a5fe09b51d..b5f54dcd451 100644
--- a/Documentation/technical/parallel-checkout.txt
+++ b/Documentation/technical/parallel-checkout.txt
@@ -63,7 +63,7 @@ improvements over the sequential code, but there was still too much lock
 contention. A `perf` profiling indicated that around 20% of the runtime
 during a local Linux clone (on an SSD) was spent in locking functions.
 For this reason this approach was rejected in favor of using multiple
-child processes, which led to a better performance.
+child processes, which led to better performance.
 
 Multi-Process Solution
 ----------------------
diff --git a/Documentation/technical/partial-clone.txt b/Documentation/technical/partial-clone.txt
index 1719c723f5c..29876ca582a 100644
--- a/Documentation/technical/partial-clone.txt
+++ b/Documentation/technical/partial-clone.txt
@@ -322,7 +322,7 @@ Footnotes
 
 [a] expensive-to-modify list of missing objects:  Earlier in the design of
     partial clone we discussed the need for a single list of missing objects.
-    This would essentially be a sorted linear list of OIDs that the were
+    This would essentially be a sorted linear list of OIDs that were
     omitted by the server during a clone or subsequent fetches.
 
 This file would need to be loaded into memory on every object lookup.
diff --git a/Documentation/technical/rerere.txt b/Documentation/technical/rerere.txt
index 5f4dd7c1028..580f23360a2 100644
--- a/Documentation/technical/rerere.txt
+++ b/Documentation/technical/rerere.txt
@@ -145,7 +145,7 @@ Nested conflicts
 Nested conflicts are handled very similarly to "simple" conflicts.
 Similar to simple conflicts, the conflict is first normalized by
 stripping the labels from conflict markers, stripping the common ancestor
-version, and the sorting the conflict hunks, both for the outer and the
+version, and sorting the conflict hunks, both for the outer and the
 inner conflict.  This is done recursively, so any number of nested
 conflicts can be handled.
 
diff --git a/Documentation/urls-remotes.txt b/Documentation/urls-remotes.txt
index ae8c2db427b..3504afbf2e9 100644
--- a/Documentation/urls-remotes.txt
+++ b/Documentation/urls-remotes.txt
@@ -33,7 +33,7 @@ config file would appear like this:
 ------------
 
 The `<pushurl>` is used for pushes only. It is optional and defaults
-to `<URL>`. Pushing to a remote affects all defined pushurls or to all
+to `<URL>`. Pushing to a remote affects all defined pushurls or all
 defined urls if no pushurls are defined. Fetch, however, will only
 fetch from the first defined url if multiple urls are defined.
 
-- 
gitgitgadget

