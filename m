Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A502C433EF
	for <git@archiver.kernel.org>; Tue,  1 Mar 2022 18:43:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237029AbiCASoa (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Mar 2022 13:44:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237010AbiCASoW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Mar 2022 13:44:22 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5A39654D
        for <git@vger.kernel.org>; Tue,  1 Mar 2022 10:43:40 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id r65so423535wma.2
        for <git@vger.kernel.org>; Tue, 01 Mar 2022 10:43:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=C/9cpq+/7LFgJqbFs52lTGJrXKzcUu9HQhf3f89AGVk=;
        b=cHalcxtpcQ91IcsMVp9swxPtAEN3VnIaCkTJO0eugwQyS+QoCeNf2uC1ZpCzfuTHzP
         8N3wD+pBo4p5EU12HId84YR8MEpR9dCFMyaJGZAldf1gd+GqWBuAOkzYdfNKsaUylDqE
         ce4ymEXFzU2C60nnsRjSHeUve/90n3rdgl+y34ITeVmEnfKPIuRxSCn3J4LifMIHzC+5
         IdjTbnCBQY0s5lqnrmmPoNFwOdKVptEXrDk0NlozINIylZi5IHZTdSD1Ouo2QAOhdTVc
         BGZgvPSj2NQaF6awvPntss5muzosZP23lnQUVKFlxfJh91zfoa6c5kr20g8T2ffv7L77
         IfJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=C/9cpq+/7LFgJqbFs52lTGJrXKzcUu9HQhf3f89AGVk=;
        b=HNnXg2R+G5fA4lgo7zvFM1TNPYCanZo0ZOgKGFAk9jr62nc+n791DjDJUmbmhoHHRu
         R3w++ARERlG9OlOudgp7sR4jJ/lht3+kkSZhVpY+feycrJcwYDX3jd2ZmSdLUpmAlkkQ
         b3My6qUz4wyXk2CXTUIo4plGbxZQyxOeyzBwJ0mtN8hJmj5Ekgj1qW1JpGljn8Pj113o
         LiaOAyt70Jm+p107NO74/I/y1PZHILcn2hIW1HkkH32cPFcG0ItMf9RegAn3cm3WDaJw
         DtKHzTp9aQ6GDiA/wr0SYU/7ax6wBtltS+PMnRDnJXCjtmo43oPitiF8hLTPXs4rFsJM
         4RBw==
X-Gm-Message-State: AOAM531GxYQYlA2ntVVU9i54i1y1/mo5NcC/zs1Jwb2My3GyOQAtzEcZ
        uXHlaQIj6aSpHNwo4DlcqDdxq78blws=
X-Google-Smtp-Source: ABdhPJxoMM/IvrKI54IvOT3d46yqzdEfqz8i/GVexgjRniBf0qWVVvT9eFwAzclGfugHf9ZeaOkCSg==
X-Received: by 2002:a05:600c:240b:b0:380:f424:f2be with SMTP id 11-20020a05600c240b00b00380f424f2bemr17613360wmp.16.1646160219020;
        Tue, 01 Mar 2022 10:43:39 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x2-20020a7bc762000000b00380fd1ba4ebsm5615894wmk.9.2022.03.01.10.43.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Mar 2022 10:43:38 -0800 (PST)
Message-Id: <ce42d5bbaf605cd39c2a704bafbf9f6c567004f1.1646160212.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1041.v6.git.1646160212.gitgitgadget@gmail.com>
References: <pull.1041.v5.git.1644612979.gitgitgadget@gmail.com>
        <pull.1041.v6.git.1646160212.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 01 Mar 2022 18:43:07 +0000
Subject: [PATCH v6 05/30] fsmonitor: document builtin fsmonitor
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Jeff Hostetler <git@jeffhostetler.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Tao Klerks <tao@klerks.biz>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Document how `core.fsmonitor` can be set to a boolean to enable
or disable the builtin FSMonitor.

Update references to `core.fsmonitor` and `core.fsmonitorHookVersion` and
pointers to `Watchman` to refer to it.

Create `git-fsmonitor--daemon` manual page and describe its features.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/config/core.txt           | 60 +++++++++++++++-----
 Documentation/git-fsmonitor--daemon.txt | 75 +++++++++++++++++++++++++
 Documentation/git-update-index.txt      |  8 ++-
 3 files changed, 126 insertions(+), 17 deletions(-)
 create mode 100644 Documentation/git-fsmonitor--daemon.txt

diff --git a/Documentation/config/core.txt b/Documentation/config/core.txt
index c04f62a54a1..6303c36c7ed 100644
--- a/Documentation/config/core.txt
+++ b/Documentation/config/core.txt
@@ -62,22 +62,54 @@ core.protectNTFS::
 	Defaults to `true` on Windows, and `false` elsewhere.
 
 core.fsmonitor::
-	If set, the value of this variable is used as a command which
-	will identify all files that may have changed since the
-	requested date/time. This information is used to speed up git by
-	avoiding unnecessary processing of files that have not changed.
-	See the "fsmonitor-watchman" section of linkgit:githooks[5].
+	If set to true, enable the built-in file system monitor
+	daemon for this working directory (linkgit:git-fsmonitor--daemon[1]).
++
+Like hook-based file system monitors, the built-in file system monitor
+can speed up Git commands that need to refresh the Git index
+(e.g. `git status`) in a working directory with many files.  The
+built-in monitor eliminates the need to install and maintain an
+external third-party tool.
++
+The built-in file system monitor is currently available only on a
+limited set of supported platforms.  Currently, this includes Windows
+and MacOS.
++
+	Otherwise, this variable contains the pathname of the "fsmonitor"
+	hook command.
++
+This hook command is used to identify all files that may have changed
+since the requested date/time. This information is used to speed up
+git by avoiding unnecessary scanning of files that have not changed.
++
+See the "fsmonitor-watchman" section of linkgit:githooks[5].
++
+Note that if you concurrently use multiple versions of Git, such
+as one version on the command line and another version in an IDE
+tool, that the definition of `core.fsmonitor` was extended to
+allow boolean values in addition to hook pathnames.  Git versions
+2.35.1 and prior will not understand the boolean values and will
+consider the "true" or "false" values as hook pathnames to be
+invoked.  Git versions 2.26 thru 2.35.1 default to hook protocol
+V2 and will fall back to no fsmonitor (full scan).  Git versions
+prior to 2.26 default to hook protocol V1 and will silently
+assume there were no changes to report (no scan), so status
+commands may report incomplete results.  For this reason, it is
+best to upgrade all of your Git versions before using the built-in
+file system monitor.
 
 core.fsmonitorHookVersion::
-	Sets the version of hook that is to be used when calling fsmonitor.
-	There are currently versions 1 and 2. When this is not set,
-	version 2 will be tried first and if it fails then version 1
-	will be tried. Version 1 uses a timestamp as input to determine
-	which files have changes since that time but some monitors
-	like watchman have race conditions when used with a timestamp.
-	Version 2 uses an opaque string so that the monitor can return
-	something that can be used to determine what files have changed
-	without race conditions.
+	Sets the protocol version to be used when invoking the
+	"fsmonitor" hook.
++
+There are currently versions 1 and 2. When this is not set,
+version 2 will be tried first and if it fails then version 1
+will be tried. Version 1 uses a timestamp as input to determine
+which files have changes since that time but some monitors
+like Watchman have race conditions when used with a timestamp.
+Version 2 uses an opaque string so that the monitor can return
+something that can be used to determine what files have changed
+without race conditions.
 
 core.trustctime::
 	If false, the ctime differences between the index and the
diff --git a/Documentation/git-fsmonitor--daemon.txt b/Documentation/git-fsmonitor--daemon.txt
new file mode 100644
index 00000000000..0fedf5a4565
--- /dev/null
+++ b/Documentation/git-fsmonitor--daemon.txt
@@ -0,0 +1,75 @@
+git-fsmonitor--daemon(1)
+========================
+
+NAME
+----
+git-fsmonitor--daemon - A Built-in File System Monitor
+
+SYNOPSIS
+--------
+[verse]
+'git fsmonitor--daemon' start
+'git fsmonitor--daemon' run
+'git fsmonitor--daemon' stop
+'git fsmonitor--daemon' status
+
+DESCRIPTION
+-----------
+
+A daemon to watch the working directory for file and directory
+changes using platform-specific file system notification facilities.
+
+This daemon communicates directly with commands like `git status`
+using the link:technical/api-simple-ipc.html[simple IPC] interface
+instead of the slower linkgit:githooks[5] interface.
+
+This daemon is built into Git so that no third-party tools are
+required.
+
+OPTIONS
+-------
+
+start::
+	Starts a daemon in the background.
+
+run::
+	Runs a daemon in the foreground.
+
+stop::
+	Stops the daemon running in the current working
+	directory, if present.
+
+status::
+	Exits with zero status if a daemon is watching the
+	current working directory.
+
+REMARKS
+-------
+
+This daemon is a long running process used to watch a single working
+directory and maintain a list of the recently changed files and
+directories.  Performance of commands such as `git status` can be
+increased if they just ask for a summary of changes to the working
+directory and can avoid scanning the disk.
+
+When `core.fsmonitor` is set to `true` (see linkgit:git-config[1])
+commands, such as `git status`, will ask the daemon for changes and
+automatically start it (if necessary).
+
+For more information see the "File System Monitor" section in
+linkgit:git-update-index[1].
+
+CAVEATS
+-------
+
+The fsmonitor daemon does not currently know about submodules and does
+not know to filter out file system events that happen within a
+submodule.  If fsmonitor daemon is watching a super repo and a file is
+modified within the working directory of a submodule, it will report
+the change (as happening against the super repo).  However, the client
+will properly ignore these extra events, so performance may be affected
+but it will not cause an incorrect result.
+
+GIT
+---
+Part of the linkgit:git[1] suite
diff --git a/Documentation/git-update-index.txt b/Documentation/git-update-index.txt
index 2853f168d97..53ea48a04e2 100644
--- a/Documentation/git-update-index.txt
+++ b/Documentation/git-update-index.txt
@@ -498,7 +498,9 @@ FILE SYSTEM MONITOR
 This feature is intended to speed up git operations for repos that have
 large working directories.
 
-It enables git to work together with a file system monitor (see the
+It enables git to work together with a file system monitor (see
+linkgit:git-fsmonitor--daemon[1]
+and the
 "fsmonitor-watchman" section of linkgit:githooks[5]) that can
 inform it as to what files have been modified. This enables git to avoid
 having to lstat() every file to find modified files.
@@ -509,8 +511,8 @@ looking for new files.
 
 If you want to enable (or disable) this feature, it is easier to use
 the `core.fsmonitor` configuration variable (see
-linkgit:git-config[1]) than using the `--fsmonitor` option to
-`git update-index` in each repository, especially if you want to do so
+linkgit:git-config[1]) than using the `--fsmonitor` option to `git
+update-index` in each repository, especially if you want to do so
 across all repositories you use, because you can set the configuration
 variable in your `$HOME/.gitconfig` just once and have it affect all
 repositories you touch.
-- 
gitgitgadget

