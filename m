Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 363B6E95A67
	for <git@archiver.kernel.org>; Sun,  8 Oct 2023 06:45:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344521AbjJHGp5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 8 Oct 2023 02:45:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344489AbjJHGpm (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Oct 2023 02:45:42 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64705EA
        for <git@vger.kernel.org>; Sat,  7 Oct 2023 23:45:38 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-3231d6504e1so3268167f8f.2
        for <git@vger.kernel.org>; Sat, 07 Oct 2023 23:45:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696747536; x=1697352336; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fD2xxP8QaDBqZ3I2dQSA/KmC/lyDjSCbTyJgXuPT4Hg=;
        b=irArxaJozzOm/hkWop/MATyS2jo7y0poIM5cFydWg2C06JB4vt0uMxsft/+pZYeEas
         p7eNSpO4ccj7Du8VrONqewzDA3eCBt6VdZEmA/5tfL6I87rtyfdp0V6+MmquYftpEpGQ
         cuU6KxF5HL1sZMgU6aXdxUce3H066ry2EtbrR4DZJ6Hhbz3lw6cR0SwHWlraGfWZZ7md
         RUpPmn7tPn+XVAyiYEH4ltpHbvCRmx0v+QvcuD2phQbK1KJ5XqjiCtBhFwU44MkR1//l
         oE4SKf5SDH+nK/FOciaOpDNkmppV7J1jO1aYwKj0mvccNzERJnvCsD5nrOVc3QZWU+FO
         0Z2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696747536; x=1697352336;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fD2xxP8QaDBqZ3I2dQSA/KmC/lyDjSCbTyJgXuPT4Hg=;
        b=cPxrj5QDY2PedW50VNrW7GKb3C2pFZ5uLkYeN/ri0a5y7Px44Aj7EnM0vovXvMDlsY
         aVLphKebIPirLaRmV04c6Mv/QGZcJFgtaI1qCdzHbrk2B4Hub08xPCtQ7GeSnraU8Yd6
         dokAsfDZ+lUbBisWrgg6wuPJV+BGFEUdufKTd2H6Jlgtj1iyYj4k/MYBk9djxRLIrHIT
         19qqn/4NB2BIUnifNq2uw/vU/geaNaa0BSzC2o6LfgjdIQW56KLHTiNR5E8ayz9F6uNb
         yQOQ5x1VpBXaEfPiuQIHmWfhCXsp7LPAeVrFcSMrVBaM1fhF4QSiTzff8zsd+7Eo4G/i
         ID/g==
X-Gm-Message-State: AOJu0YyMmRiIxYkFqTqX5knSJ2Vq6rMLfBD3c7nL0IIJtPg0wTHjfynu
        BpagtcPrhQZoV8NY/dDTAhkBranopvA=
X-Google-Smtp-Source: AGHT+IGS4W10Ma3OXEjE3vgmeCvR+ZMcqF0CjQfwokDrtTT0/2mQhduU1on1a08W+79PRjmrSmblZQ==
X-Received: by 2002:a5d:5889:0:b0:329:6be4:e199 with SMTP id n9-20020a5d5889000000b003296be4e199mr6164374wrf.13.1696747536273;
        Sat, 07 Oct 2023 23:45:36 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a8-20020a5d4568000000b00327bf4f2f16sm6004451wrc.30.2023.10.07.23.45.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Oct 2023 23:45:35 -0700 (PDT)
Message-ID: <2411c4eae232896a6bccfb9575ea128f12409477.1696747529.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1595.git.1696747527.gitgitgadget@gmail.com>
References: <pull.1595.git.1696747527.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 08 Oct 2023 06:45:11 +0000
Subject: [PATCH 09/25] documentation: fix verb tense
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
 Documentation/config/advice.txt      | 2 +-
 Documentation/config/clone.txt       | 2 +-
 Documentation/config/column.txt      | 2 +-
 Documentation/git-clean.txt          | 2 +-
 Documentation/git-help.txt           | 6 +++---
 Documentation/git-whatchanged.txt    | 2 +-
 Documentation/gitcli.txt             | 4 ++--
 Documentation/gitformat-chunk.txt    | 2 +-
 Documentation/gitformat-pack.txt     | 6 +++---
 Documentation/gitsubmodules.txt      | 4 ++--
 Documentation/gitweb.conf.txt        | 2 +-
 Documentation/gitweb.txt             | 4 ++--
 Documentation/technical/reftable.txt | 2 +-
 13 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/Documentation/config/advice.txt b/Documentation/config/advice.txt
index f524af4e899..c8e38a0e5cd 100644
--- a/Documentation/config/advice.txt
+++ b/Documentation/config/advice.txt
@@ -87,7 +87,7 @@ advice.*::
 	detachedHead::
 		Advice shown when you used
 		linkgit:git-switch[1] or linkgit:git-checkout[1]
-		to move to the detach HEAD state, to instruct how to
+		to move to the detached HEAD state, to instruct how to
 		create a local branch after the fact.
 	suggestDetachingHead::
 		Advice shown when linkgit:git-switch[1] refuses to detach HEAD
diff --git a/Documentation/config/clone.txt b/Documentation/config/clone.txt
index a16b1b6fa34..d037b57f729 100644
--- a/Documentation/config/clone.txt
+++ b/Documentation/config/clone.txt
@@ -4,7 +4,7 @@ clone.defaultRemoteName::
 	option to linkgit:git-clone[1].
 
 clone.rejectShallow::
-	Reject to clone a repository if it is a shallow one; this can be overridden by
+	Reject cloning a repository if it is a shallow one; this can be overridden by
 	passing the `--reject-shallow` option on the command line. See linkgit:git-clone[1]
 
 clone.filterSubmodules::
diff --git a/Documentation/config/column.txt b/Documentation/config/column.txt
index 76aa2f29dc2..9f30322362d 100644
--- a/Documentation/config/column.txt
+++ b/Documentation/config/column.txt
@@ -43,7 +43,7 @@ column.branch::
 	See `column.ui` for details.
 
 column.clean::
-	Specify the layout when list items in `git clean -i`, which always
+	Specify the layout when listing items in `git clean -i`, which always
 	shows files and directories in columns. See `column.ui` for details.
 
 column.status::
diff --git a/Documentation/git-clean.txt b/Documentation/git-clean.txt
index 5e1a3d5148c..69331e3f05a 100644
--- a/Documentation/git-clean.txt
+++ b/Documentation/git-clean.txt
@@ -103,7 +103,7 @@ filter by pattern::
    This shows the files and directories to be deleted and issues an
    "Input ignore patterns>>" prompt. You can input space-separated
    patterns to exclude files and directories from deletion.
-   E.g. "*.c *.h" will excludes files end with ".c" and ".h" from
+   E.g. "*.c *.h" will exclude files ending with ".c" and ".h" from
    deletion. When you are satisfied with the filtered result, press
    ENTER (empty) back to the main menu.
 
diff --git a/Documentation/git-help.txt b/Documentation/git-help.txt
index 7cb4b4bda18..ee18a2b7432 100644
--- a/Documentation/git-help.txt
+++ b/Documentation/git-help.txt
@@ -48,7 +48,7 @@ OPTIONS
 -------
 -a::
 --all::
-	Prints all the available commands on the standard output.
+	Print all the available commands on the standard output.
 
 --no-external-commands::
 	When used with `--all`, exclude the listing of external "git-*"
@@ -69,10 +69,10 @@ OPTIONS
 
 -g::
 --guides::
-	Prints a list of the Git concept guides on the standard output.
+	Print a list of the Git concept guides on the standard output.
 
 --user-interfaces::
-	Prints a list of the repository, command and file interfaces
+	Print a list of the repository, command and file interfaces
 	documentation on the standard output.
 +
 In-repository file interfaces such as `.git/info/exclude` are
diff --git a/Documentation/git-whatchanged.txt b/Documentation/git-whatchanged.txt
index 5cbb31f33e3..ee8c1aa0ca4 100644
--- a/Documentation/git-whatchanged.txt
+++ b/Documentation/git-whatchanged.txt
@@ -18,7 +18,7 @@ Shows commit logs and diff output each commit introduces.
 
 New users are encouraged to use linkgit:git-log[1] instead.  The
 `whatchanged` command is essentially the same as linkgit:git-log[1]
-but defaults to show the raw format diff output and to skip merges.
+but defaults to showing the raw format diff output and skipping merges.
 
 The command is primarily kept for historical reasons; fingers of
 many people who learned Git long before `git log` was invented by
diff --git a/Documentation/gitcli.txt b/Documentation/gitcli.txt
index 1819a5a1859..f0986881bac 100644
--- a/Documentation/gitcli.txt
+++ b/Documentation/gitcli.txt
@@ -23,7 +23,7 @@ arguments.  Here are the rules:
     A subcommand may take dashed options (which may take their own
     arguments, e.g. "--max-parents 2") and arguments.  You SHOULD
     give dashed options first and then arguments.  Some commands may
-    accept dashed options after you have already gave non-option
+    accept dashed options after you have already given non-option
     arguments (which may make the command ambiguous), but you should
     not rely on it (because eventually we may find a way to fix
     these ambiguity by enforcing the "options then args" rule).
@@ -42,7 +42,7 @@ arguments.  Here are the rules:
    `git diff HEAD --` to ask for the latter.
 
  * Without disambiguating `--`, Git makes a reasonable guess, but errors
-   out and asking you to disambiguate when ambiguous.  E.g. if you have a
+   out and asks you to disambiguate when ambiguous.  E.g. if you have a
    file called HEAD in your work tree, `git diff HEAD` is ambiguous, and
    you have to say either `git diff HEAD --` or `git diff -- HEAD` to
    disambiguate.
diff --git a/Documentation/gitformat-chunk.txt b/Documentation/gitformat-chunk.txt
index 76ea678398a..3315df6201d 100644
--- a/Documentation/gitformat-chunk.txt
+++ b/Documentation/gitformat-chunk.txt
@@ -67,7 +67,7 @@ caller is responsible for opening the `hashfile` and writing header
 information so the file format is identifiable before the chunk-based
 format begins.
 
-Then, call `add_chunk()` for each chunk that is intended for write. This
+Then, call `add_chunk()` for each chunk that is intended for writing. This
 populates the `chunkfile` with information about the order and size of
 each chunk to write. Provide a `chunk_write_fn` function pointer to
 perform the write of the chunk data upon request.
diff --git a/Documentation/gitformat-pack.txt b/Documentation/gitformat-pack.txt
index 42afb953e8c..f5d07a125d9 100644
--- a/Documentation/gitformat-pack.txt
+++ b/Documentation/gitformat-pack.txt
@@ -117,7 +117,7 @@ the delta data is a sequence of instructions to reconstruct the object
 from the base object. If the base object is deltified, it must be
 converted to canonical form first. Each instruction appends more and
 more data to the target object until it's complete. There are two
-supported instructions so far: one for copy a byte range from the
+supported instructions so far: one for copying a byte range from the
 source object and one for inserting new data embedded in the
 instruction itself.
 
@@ -137,7 +137,7 @@ copy. Offset and size are in little-endian order.
 
 All offset and size bytes are optional. This is to reduce the
 instruction size when encoding small offsets or sizes. The first seven
-bits in the first octet determines which of the next seven octets is
+bits in the first octet determine which of the next seven octets is
 present. If bit zero is set, offset1 is present. If bit one is set
 offset2 is present and so on.
 
@@ -163,7 +163,7 @@ converted to 0x10000.
 
 This is the instruction to construct target object without the base
 object. The following data is appended to the target object. The first
-seven bits of the first octet determines the size of data in
+seven bits of the first octet determine the size of data in
 bytes. The size must be non-zero.
 
 ==== Reserved instruction
diff --git a/Documentation/gitsubmodules.txt b/Documentation/gitsubmodules.txt
index 941858a6ecc..13678ead045 100644
--- a/Documentation/gitsubmodules.txt
+++ b/Documentation/gitsubmodules.txt
@@ -78,7 +78,7 @@ Submodule operations can be configured using the following mechanisms
 
  * The command line for those commands that support taking submodules
    as part of their pathspecs. Most commands have a boolean flag
-   `--recurse-submodules` which specify whether to recurse into submodules.
+   `--recurse-submodules` which specifies whether to recurse into submodules.
    Examples are `grep` and `checkout`.
    Some commands take enums, such as `fetch` and `push`, where you can
    specify how submodules are affected.
@@ -274,7 +274,7 @@ will not be checked out by default; you can instruct `clone` to recurse
 into submodules. The `init` and `update` subcommands of `git submodule`
 will maintain submodules checked out and at an appropriate revision in
 your working tree. Alternatively you can set `submodule.recurse` to have
-`checkout` recursing into submodules (note that `submodule.recurse` also
+`checkout` recurse into submodules (note that `submodule.recurse` also
 affects other Git commands, see linkgit:git-config[1] for a complete list).
 
 
diff --git a/Documentation/gitweb.conf.txt b/Documentation/gitweb.conf.txt
index 34b1d6e2243..b078fef6f5c 100644
--- a/Documentation/gitweb.conf.txt
+++ b/Documentation/gitweb.conf.txt
@@ -53,7 +53,7 @@ following order:
    `/etc/gitweb-common.conf`),
 
  * either per-instance configuration file (defaults to 'gitweb_config.perl'
-   in the same directory as the installed gitweb), or if it does not exists
+   in the same directory as the installed gitweb), or if it does not exist
    then fallback system-wide configuration file (defaults to `/etc/gitweb.conf`).
 
 Values obtained in later configuration files override values obtained earlier
diff --git a/Documentation/gitweb.txt b/Documentation/gitweb.txt
index bb9cbad7f3f..41ce55e266a 100644
--- a/Documentation/gitweb.txt
+++ b/Documentation/gitweb.txt
@@ -8,7 +8,7 @@ gitweb - Git web interface (web frontend to Git repositories)
 SYNOPSIS
 --------
 To get started with gitweb, run linkgit:git-instaweb[1] from a Git repository.
-This would configure and start your web server, and run web browser pointing to
+This will configure and start your web server, and run a web browser pointing to
 gitweb.
 
 
@@ -24,7 +24,7 @@ Gitweb provides a web interface to Git repositories.  Its features include:
 * Viewing the blame/annotation details of any file (if enabled).
 * Generating RSS and Atom feeds of commits, for any branch.
   The feeds are auto-discoverable in modern web browsers.
-* Viewing everything that was changed in a revision, and step through
+* Viewing everything that was changed in a revision, and stepping through
   revisions one at a time, viewing the history of the repository.
 * Finding commits whose commit messages match a given search term.
 
diff --git a/Documentation/technical/reftable.txt b/Documentation/technical/reftable.txt
index 84637f96e77..6def498efd5 100644
--- a/Documentation/technical/reftable.txt
+++ b/Documentation/technical/reftable.txt
@@ -247,7 +247,7 @@ uint32( hash_id )
 ....
 
 The header is identical to `version_number=1`, with the 4-byte hash ID
-("sha1" for SHA1 and "s256" for SHA-256) append to the header.
+("sha1" for SHA1 and "s256" for SHA-256) appended to the header.
 
 For maximum backward compatibility, it is recommended to use version 1 when
 writing SHA1 reftables.
-- 
gitgitgadget

