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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C61D7C43460
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 04:06:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F82461168
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 04:06:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231714AbhDIEHC (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Apr 2021 00:07:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231147AbhDIEGq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Apr 2021 00:06:46 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1C07C0613D7
        for <git@vger.kernel.org>; Thu,  8 Apr 2021 21:05:54 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id a4so4214380wrr.2
        for <git@vger.kernel.org>; Thu, 08 Apr 2021 21:05:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jdSw7js+Ujmct6JNWPIbVRl4FlREKiLhn3D7skqd0vY=;
        b=OS1pAEOIC1eEq0ToZwZIqjwqxACJTKENafUgFX2v1mJMvKf3LTMoAK49ISG0Vc3+Zx
         oYy34xYai6Bq3LOiGPAtN85dxfHq3Ckh0qaaEiWuu1zHVO2+LOWN9Ri6/zkPG/o+4qzi
         vFWkjSn1h2U6sPBhnE3VKGGgNKsAXq93OYNGUNeYvBNq1o1eSk8BrlROxXcREbGMl7CU
         m+IfVz46qguEDkJnwjt3pupICBJOKmN/3pflMwjorNaGPKNK6iIbCOs9C3UC853zWBU9
         o4xsomhqZ9IfhyoAGlDLW2FIwG13NYubWEES7ObAYbKjmmTi/um07RSjouIz9UBnY8N4
         nebQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jdSw7js+Ujmct6JNWPIbVRl4FlREKiLhn3D7skqd0vY=;
        b=cuFr319t17bEhWcKoSfIP48H5DMjoykC53zCb/vkrI934BwLvb4xU6Tg6FAkzKKvE9
         +p5U1r1s6rD6gUp0WRJFGgvC1b4TIG3ZHZmf+9MwaFV3nrKeYwrgo5KGkib4cJ2j2gyh
         s05LytJfSDkleQLWGm9IXCX039yLNcZlI2xU4t8jgNlkbhEekbLCMzskS8VYvnDA/q/L
         FNBQrcqJ5k784VS8y6ELwx1VCRidfN9gIpjMI5tPmFpvWiygep03zevp0TO+ROlJSeUl
         2B4sJTwhD1j2AgKNnKRD5Vt1DV7ZZ9nEd1S0FzPdtUUO2qSMy7ZSzUtqvcmTdrCMU9uV
         bO3A==
X-Gm-Message-State: AOAM533YtaLuG214mhqPuTbpB8DpVzlOHk0sKN1rI6+dWmH65BNdgHOz
        dkEf0aBFHc3kukLwNrkdevPjTNbF76CQJA==
X-Google-Smtp-Source: ABdhPJz5hFdj73ktwhwf2gAeMPEGLuobTVCr8JbmOS+5gtUCgYaXRcaWF/k3B7GY4DB3Jg1sNyyy3Q==
X-Received: by 2002:adf:f692:: with SMTP id v18mr5887755wrp.206.1617941153163;
        Thu, 08 Apr 2021 21:05:53 -0700 (PDT)
Received: from Inspiron.home (2a01cb04010c420080e637770dc2ae3c.ipv6.abo.wanadoo.fr. [2a01:cb04:10c:4200:80e6:3777:dc2:ae3c])
        by smtp.gmail.com with ESMTPSA id c9sm2064636wrr.78.2021.04.08.21.05.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Apr 2021 21:05:52 -0700 (PDT)
From:   Firmin Martin <firminmartin24@gmail.com>
To:     git@vger.kernel.org
Cc:     Firmin Martin <firminmartin24@gmail.com>
Subject: [RFC PATCH v1 13/13] doc: typeset common programs in monospace
Date:   Fri,  9 Apr 2021 06:03:01 +0200
Message-Id: <20210409040301.3260358-14-firminmartin24@gmail.com>
X-Mailer: git-send-email 2.31.1.133.g84d06cdc06
In-Reply-To: <20210409040301.3260358-1-firminmartin24@gmail.com>
References: <20210409040301.3260358-1-firminmartin24@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Wrap common programs with backticks as indicated in the
CodingGuidelines.

The following command and regex helped to find out a partial list of
such program.

    grep -RPoh "'[a-z]+'" *.txt | sort | uniq | less

Signed-off-by: Firmin Martin <firminmartin24@gmail.com>
---
 Documentation/git-archive.txt       |  2 +-
 Documentation/git-bisect-lk2009.txt |  2 +-
 Documentation/git-fast-import.txt   |  4 ++--
 Documentation/git-grep.txt          |  4 ++--
 Documentation/git-help.txt          | 24 ++++++++++++------------
 Documentation/git-send-email.txt    |  2 +-
 Documentation/git-var.txt           |  6 +++---
 Documentation/git-web--browse.txt   |  6 +++---
 Documentation/git.txt               |  4 ++--
 Documentation/gitcore-tutorial.txt  |  6 +++---
 Documentation/gitremote-helpers.txt |  2 +-
 11 files changed, 31 insertions(+), 31 deletions(-)

diff --git a/Documentation/git-archive.txt b/Documentation/git-archive.txt
index 830ff2b680..2139a96e48 100644
--- a/Documentation/git-archive.txt
+++ b/Documentation/git-archive.txt
@@ -34,7 +34,7 @@ OPTIONS
 -------
 
 `--format=<fmt>`::
-	Format of the resulting archive: 'tar' or 'zip'. If this option
+	Format of the resulting archive: `tar` or `zip`. If this option
 	is not given, and the output file is specified, the format is
 	inferred from the filename if possible (e.g. writing to "foo.zip"
 	makes the output to be in the zip format). Otherwise the output
diff --git a/Documentation/git-bisect-lk2009.txt b/Documentation/git-bisect-lk2009.txt
index de5f221613..bcee1bb298 100644
--- a/Documentation/git-bisect-lk2009.txt
+++ b/Documentation/git-bisect-lk2009.txt
@@ -1355,4 +1355,4 @@ References
 - [[[6]]] https://lwn.net/Articles/277872/[Jonathan Corbet. 'Bisection divides users and developers'. LWN.net.]
 - [[[7]]] https://lore.kernel.org/lkml/20071207113734.GA14598@elte.hu/[Ingo Molnar. 'Re: BUG 2.6.23-rc3 can't see sd partitions on Alpha'. Linux-kernel mailing list.]
 - [[[8]]] https://www.kernel.org/pub/software/scm/git/docs/git-bisect.html[Junio C Hamano and the git-list. 'git-bisect(1) Manual Page'. Linux Kernel Archives.]
-- [[[9]]] https://github.com/Ealdwulf/bbchop[Ealdwulf. 'bbchop'. GitHub.]
+- [[[9]]] https://github.com/Ealdwulf/bbchop[Ealdwulf. `bbchop`. GitHub.]
diff --git a/Documentation/git-fast-import.txt b/Documentation/git-fast-import.txt
index 6830332297..f304c6ff18 100644
--- a/Documentation/git-fast-import.txt
+++ b/Documentation/git-fast-import.txt
@@ -1118,7 +1118,7 @@ Output uses the same format as `git ls-tree <tree> -- <path>`:
 
 The <dataref> represents the blob, tree, or commit object at <path>
 and can be used in later 'get-mark', 'cat-blob', 'filemodify', or
-'ls' commands.
+`ls` commands.
 
 If there is no file or subtree at that path, `git fast-import` will
 instead report
@@ -1164,7 +1164,7 @@ The <feature> part of the command may be any one of the following:
 `cat-blob`::
 `ls`::
 	Require that the backend support the 'get-mark', 'cat-blob',
-	or 'ls' command respectively.
+	or `ls` command respectively.
 	Versions of fast-import not supporting the specified command
 	will exit with a message indicating so.
 	This lets the import error out early with a clear message,
diff --git a/Documentation/git-grep.txt b/Documentation/git-grep.txt
index 0a0d0f3f57..f1186a6685 100644
--- a/Documentation/git-grep.txt
+++ b/Documentation/git-grep.txt
@@ -49,7 +49,7 @@ CONFIGURATION
 
 `grep.patternType`::
 	Set the default matching behavior. Using a value of 'basic', 'extended',
-	'fixed', or 'perl' will enable the `--basic-regexp`, `--extended-regexp`,
+	'fixed', or `perl` will enable the `--basic-regexp`, `--extended-regexp`,
 	`--fixed-strings`, or `--perl-regexp` option accordingly, while the
 	value 'default' will return to the default matching behavior.
 
@@ -196,7 +196,7 @@ providing this option will cause it to die.
 
 `-O[<pager>]`::
 `--open-files-in-pager[=<pager>]`::
-	Open the matching files in the pager (not the output of 'grep').
+	Open the matching files in the pager (not the output of `grep`).
 	If the pager happens to be `less` or `vi`, and the user
 	specified only one pattern, the first file is positioned at
 	the first match automatically. The `pager` argument is
diff --git a/Documentation/git-help.txt b/Documentation/git-help.txt
index 070ef46a8d..eb5e843efc 100644
--- a/Documentation/git-help.txt
+++ b/Documentation/git-help.txt
@@ -25,7 +25,7 @@ If the option `--guides` or `-g` is given, a list of the
 Git concept guides is also printed on the standard output.
 
 If a command, or a guide, is given, a manual page for that command or
-guide is brought up. The 'man' program is used by default for this
+guide is brought up. The `man` program is used by default for this
 purpose, but this can be overridden by other options or configuration
 variables.
 
@@ -68,11 +68,11 @@ OPTIONS
 
 `-m`::
 `--man`::
-	Display manual page for the command in the 'man' format. This
+	Display manual page for the command in the `man` format. This
 	option may be used to override a value set in the
 	`help.format` configuration variable.
 +
-By default the 'man' program will be used to display the manual page,
+By default the `man` program will be used to display the manual page,
 but the `man.viewer` configuration variable may be used to choose
 other display programs (see below).
 
@@ -113,13 +113,13 @@ section above and linkgit:git-web{litdd}browse[1].
 man.viewer
 ~~~~~~~~~~
 
-The `man.viewer` configuration variable will be checked if the 'man'
+The `man.viewer` configuration variable will be checked if the `man`
 format is chosen. The following values are currently supported:
 
-* "man": use the 'man' program as usual,
-* "woman": use 'emacsclient' to launch the "woman" mode in emacs
-  (this only works starting with emacsclient versions 22),
-* "konqueror": use 'kfmclient' to open the man page in a new konqueror
+* `man`: use the `man` program as usual,
+* `woman`: use `emacsclient` to launch the `woman` mode in emacs
+  (this only works starting with `emacsclient` versions 22),
+* `konqueror`: use `kfmclient` to open the man page in a new `konqueror`
   tab (see 'Note about konqueror' below).
 
 Values for other tools can be used if there is a corresponding
@@ -142,7 +142,7 @@ DISPLAY is not set) and in that case emacs' woman mode will be tried.
 
 If everything fails, or if no viewer is configured, the viewer specified
 in the `GIT_MAN_VIEWER` environment variable will be tried.  If that
-fails too, the 'man' program will be tried anyway.
+fails too, the `man` program will be tried anyway.
 
 man.<tool>.path
 ~~~~~~~~~~~~~~~
@@ -166,15 +166,15 @@ page passed as arguments.
 Note about konqueror
 ~~~~~~~~~~~~~~~~~~~~
 
-When 'konqueror' is specified in the `man.viewer` configuration
-variable, we launch 'kfmclient' to try to open the man page on an
+When `konqueror` is specified in the `man.viewer` configuration
+variable, we launch `kfmclient` to try to open the man page on an
 already opened konqueror in a new tab if possible.
 
 For consistency, we also try such a trick if `man.konqueror.path` is
 set to something like `A_PATH_TO/konqueror`. That means we will try to
 launch `A_PATH_TO/kfmclient` instead.
 
-If you really want to use 'konqueror', then you can use something like
+If you really want to use `konqueror`, then you can use something like
 the following:
 
 ------------------------------------------------
diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
index 87ef1ceff3..bec5b881b3 100644
--- a/Documentation/git-send-email.txt
+++ b/Documentation/git-send-email.txt
@@ -449,7 +449,7 @@ CONFIGURATION
 
 `sendemail.aliasFileType`::
 	Format of the file(s) specified in `sendemail.aliasesFile`. Must be
-	one of 'mutt', 'mailrc', 'pine', 'elm', or 'gnus', or 'sendmail'.
+	one of `mutt`, `mailrc`, `pine`, `elm`, or `gnus`, or `sendmail`.
 +
 What an alias file in each format looks like can be found in
 the documentation of the email program of the same name. The
diff --git a/Documentation/git-var.txt b/Documentation/git-var.txt
index 82448d40a4..4de20c2de7 100644
--- a/Documentation/git-var.txt
+++ b/Documentation/git-var.txt
@@ -44,17 +44,17 @@ VARIABLES
     --nofork`.  The order of preference is the `$GIT_EDITOR`
     environment variable, then `core.editor` configuration, then
     `$VISUAL`, then `$EDITOR`, and then the default chosen at compile
-    time, which is usually 'vi'.
+    time, which is usually `vi`.
 ifdef::git-default-editor[]
     The build you are using chose '{git-default-editor}' as the default.
 endif::git-default-editor[]
 
 `GIT_PAGER`::
-    Text viewer for use by Git commands (e.g., 'less').  The value
+    Text viewer for use by Git commands (e.g., `less`).  The value
     is meant to be interpreted by the shell.  The order of preference
     is the `$GIT_PAGER` environment variable, then `core.pager`
     configuration, then `$PAGER`, and then the default chosen at
-    compile time (usually 'less').
+    compile time (usually `less`).
 ifdef::git-default-pager[]
     The build you are using chose '{git-default-pager}' as the default.
 endif::git-default-pager[]
diff --git a/Documentation/git-web--browse.txt b/Documentation/git-web--browse.txt
index 5aebb3093d..93706059bc 100644
--- a/Documentation/git-web--browse.txt
+++ b/Documentation/git-web--browse.txt
@@ -87,15 +87,15 @@ the URLs passed as arguments.
 NOTE ABOUT KONQUEROR
 --------------------
 
-When 'konqueror' is specified by a command-line option or a
-configuration variable, we launch 'kfmclient' to try to open the HTML
+When `konqueror` is specified by a command-line option or a
+configuration variable, we launch `kfmclient` to try to open the HTML
 man page on an already opened konqueror in a new tab if possible.
 
 For consistency, we also try such a trick if `browser.konqueror.path` is
 set to something like `A_PATH_TO/konqueror`. That means we will try to
 launch `A_PATH_TO/kfmclient` instead.
 
-If you really want to use 'konqueror', then you can use something like
+If you really want to use `konqueror`, then you can use something like
 the following:
 
 ------------------------------------------------
diff --git a/Documentation/git.txt b/Documentation/git.txt
index 2328f8bd0b..1e03ac1d91 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -122,7 +122,7 @@ sensitive information can be part of the key.
 
 `-p`::
 `--paginate`::
-	Pipe all output into 'less' (or if set, `$PAGER`) if standard
+	Pipe all output into `less` (or if set, `$PAGER`) if standard
 	output is a terminal.  This overrides the `pager.<cmd>`
 	configuration options (see the "Configuration Mechanism" section
 	below).
@@ -637,7 +637,7 @@ other
 `GIT_SSH`::
 `GIT_SSH_COMMAND`::
 	If either of these environment variables is set then `git fetch`
-	and `git push` will use the specified command instead of 'ssh'
+	and `git push` will use the specified command instead of `ssh`
 	when they need to connect to a remote system.
 	The command-line parameters passed to the configured command are
 	determined by the ssh variant.  See `ssh.variant` option in
diff --git a/Documentation/gitcore-tutorial.txt b/Documentation/gitcore-tutorial.txt
index 15c5ca122f..c9f2d75aef 100644
--- a/Documentation/gitcore-tutorial.txt
+++ b/Documentation/gitcore-tutorial.txt
@@ -69,7 +69,7 @@ Initialized empty Git repository in .git/
 which is just Git's way of saying that you haven't been doing anything
 strange, and that it will have created a local `.git` directory setup for
 your new project. You will now have a `.git` directory, and you can
-inspect that with 'ls'. For your new empty project, it should show you
+inspect that with `ls`. For your new empty project, it should show you
 three entries, among other things:
 
  - a file called `HEAD`, that has `ref: refs/heads/master` in it.
@@ -635,7 +635,7 @@ in the new repository to make sure that the index file is up to date.
 
 Note that the second point is true even across machines. You can
 duplicate a remote Git repository with *any* regular copy mechanism, be it
-'scp', 'rsync' or 'wget'.
+`scp`, `rsync` or `wget`.
 
 When copying a remote repository, you'll want to at a minimum update the
 index cache when you do this, and especially with other peoples'
@@ -1028,7 +1028,7 @@ Local directory::
 +
 This transport is the same as SSH transport but uses 'sh' to run
 both ends on the local machine instead of running other end on
-the remote machine via 'ssh'.
+the remote machine via `ssh`.
 
 Git Native::
 	`git://remote.machine/path/to/repo.git/`
diff --git a/Documentation/gitremote-helpers.txt b/Documentation/gitremote-helpers.txt
index 02ae4993bc..145179b788 100644
--- a/Documentation/gitremote-helpers.txt
+++ b/Documentation/gitremote-helpers.txt
@@ -210,7 +210,7 @@ the remote repository.
 
 `bidi-import`::
 	This modifies the 'import' capability.
-	The fast-import commands 'cat-blob' and 'ls' can be used by remote-helpers
+	The fast-import commands 'cat-blob' and `ls` can be used by remote-helpers
 	to retrieve information about blobs and trees that already exist in
 	fast-import's memory. This requires a channel from fast-import to the
 	remote-helper.
-- 
2.31.1.133.g84d06cdc06

