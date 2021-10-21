Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38B93C433F5
	for <git@archiver.kernel.org>; Thu, 21 Oct 2021 14:25:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 21DF46121E
	for <git@archiver.kernel.org>; Thu, 21 Oct 2021 14:25:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231533AbhJUO1s (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Oct 2021 10:27:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230483AbhJUO1c (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Oct 2021 10:27:32 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA3C6C061224
        for <git@vger.kernel.org>; Thu, 21 Oct 2021 07:25:15 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id a20-20020a1c7f14000000b003231d13ee3cso4049298wmd.3
        for <git@vger.kernel.org>; Thu, 21 Oct 2021 07:25:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=mTvrOF5Oxl2fj6dFUIoHOQKVR0HGP41/GTi9k3q3AiU=;
        b=gYXItNijxzvh/Fo/vTgq/shOn+PFuustWhHCKNXMePbX/RjWnMY1MVlbDPUGnlhBT1
         Vlo/DbxwHywIv3xOTCyXlSplEZTmKEDQ81KpY0PFzA7vUeQRuCyKEQyb9cbeTgNaJHtP
         ESiMvgqXarqyS5a/qHQP+vPqvCs3PDDzyIP5tAg4KjYI+FUQ4YOvYUBeJULWB6Ka7obH
         l8Tj4bQii7MMzQ0WpoCAFzzX0OsOILGx/yS9z1Y830vyq1mMxYSHCoE1LDvq3ZOIJPny
         6KHrwgLgNtFjNcp8og8XNSr7q5Uc75XXrrD3UFz24OiJOlMLRLbww1S4rWdqHjfABVNx
         S6nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=mTvrOF5Oxl2fj6dFUIoHOQKVR0HGP41/GTi9k3q3AiU=;
        b=QVqSYHbvr1rjRbjHDXIjFwPFICiWJaDsN7W1RTPiLzlCAZApnjB9PADbYrSZ/49XJk
         4MxzdGLvxhXB0l+YXQezXKoKxdsBoRqqs75gZhIKbovBTfh1vQEhJQ4YTUp59cEOy20s
         77cNhORaZVvU93Brc4JOVnQ+vy4uysObmCMOficrXsRIpG5JmuZA1OLSNO57LV4YsmmR
         U9Zq4P9Kd2oifjBukZUtYv63JwGJ/g+oqWGSUw8qP+Wl0+kJhtv7SqqwYiu/HkuRsIBG
         2LPHgHjb6ro2v7I4iRkNPaaqCkWeoDAcZWMWHjmuRxJ9jt++DttqiNyG2s6K/MNX3anA
         PW6Q==
X-Gm-Message-State: AOAM5325k7e+9pMZ9I8J7VORxfyRP2ZSLBfMZ29/3uoiurJ+/T1L8gH0
        odie+dhFfkqhQifDady+OgdmXVUMVxw=
X-Google-Smtp-Source: ABdhPJxuqtrsXi9PsJZz3Vou41XFcs7G0dEtwlZ7kEqy5hqude68iLXYM2J2CWGQvqjr5z5rILiSIA==
X-Received: by 2002:a1c:a950:: with SMTP id s77mr2180761wme.108.1634826314408;
        Thu, 21 Oct 2021 07:25:14 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s3sm6774698wmh.30.2021.10.21.07.25.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 07:25:14 -0700 (PDT)
Message-Id: <d365704d5517d15a1ad74c5b2a6e6d6a7dcaffb1.1634826309.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1041.v4.git.1634826309.gitgitgadget@gmail.com>
References: <pull.1041.v3.git.1634157107.gitgitgadget@gmail.com>
        <pull.1041.v4.git.1634826309.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 21 Oct 2021 14:24:45 +0000
Subject: [PATCH v4 05/29] fsmonitor: document builtin fsmonitor
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff Hostetler <git@jeffhostetler.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Document the new `core.useBuiltinFSMonitor` config value.

Update references to `core.fsmonitor` and `core.fsmonitorHookVersion` and
pointers to `Watchman` to refer to it.

Create `git-fsmonitor--daemon` manual page and describe its features.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 Documentation/config/core.txt           | 56 +++++++++++++-----
 Documentation/git-fsmonitor--daemon.txt | 75 +++++++++++++++++++++++++
 Documentation/git-update-index.txt      | 27 +++++----
 Documentation/githooks.txt              |  3 +-
 4 files changed, 134 insertions(+), 27 deletions(-)
 create mode 100644 Documentation/git-fsmonitor--daemon.txt

diff --git a/Documentation/config/core.txt b/Documentation/config/core.txt
index c04f62a54a1..4f6e519bc02 100644
--- a/Documentation/config/core.txt
+++ b/Documentation/config/core.txt
@@ -62,22 +62,50 @@ core.protectNTFS::
 	Defaults to `true` on Windows, and `false` elsewhere.
 
 core.fsmonitor::
-	If set, the value of this variable is used as a command which
-	will identify all files that may have changed since the
-	requested date/time. This information is used to speed up git by
-	avoiding unnecessary processing of files that have not changed.
-	See the "fsmonitor-watchman" section of linkgit:githooks[5].
+	If set, this variable contains the pathname of the "fsmonitor"
+	hook command.
++
+This hook command is used to identify all files that may have changed
+since the requested date/time. This information is used to speed up
+git by avoiding unnecessary scanning of files that have not changed.
++
+See the "fsmonitor-watchman" section of linkgit:githooks[5].
++
+Note: The value of this config setting is ignored if the
+built-in file system monitor is enabled (see `core.useBuiltinFSMonitor`).
 
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
++
+Note: The value of this config setting is ignored if the
+built-in file system monitor is enabled (see `core.useBuiltinFSMonitor`).
+
+core.useBuiltinFSMonitor::
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
+Note: if this config setting is set to `true`, the values of
+`core.fsmonitor` and `core.fsmonitorHookVersion` are ignored.
 
 core.trustctime::
 	If false, the ctime differences between the index and the
diff --git a/Documentation/git-fsmonitor--daemon.txt b/Documentation/git-fsmonitor--daemon.txt
new file mode 100644
index 00000000000..154e7684daa
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
+When `core.useBuiltinFSMonitor` is set to `true` (see
+linkgit:git-config[1]) commands, such as `git status`, will ask the
+daemon for changes and automatically start it (if necessary).
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
index 2853f168d97..c7c31b3fcf9 100644
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
@@ -508,17 +510,18 @@ performance by avoiding the cost of scanning the entire working directory
 looking for new files.
 
 If you want to enable (or disable) this feature, it is easier to use
-the `core.fsmonitor` configuration variable (see
-linkgit:git-config[1]) than using the `--fsmonitor` option to
-`git update-index` in each repository, especially if you want to do so
-across all repositories you use, because you can set the configuration
-variable in your `$HOME/.gitconfig` just once and have it affect all
-repositories you touch.
-
-When the `core.fsmonitor` configuration variable is changed, the
-file system monitor is added to or removed from the index the next time
-a command reads the index. When `--[no-]fsmonitor` are used, the file
-system monitor is immediately added to or removed from the index.
+the `core.fsmonitor` or `core.useBuiltinFSMonitor` configuration
+variable (see linkgit:git-config[1]) than using the `--fsmonitor`
+option to `git update-index` in each repository, especially if you
+want to do so across all repositories you use, because you can set the
+configuration variable in your `$HOME/.gitconfig` just once and have
+it affect all repositories you touch.
+
+When the `core.fsmonitor` or `core.useBuiltinFSMonitor` configuration
+variable is changed, the file system monitor is added to or removed
+from the index the next time a command reads the index. When
+`--[no-]fsmonitor` are used, the file system monitor is immediately
+added to or removed from the index.
 
 CONFIGURATION
 -------------
diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
index b51959ff941..b7d5e926f7b 100644
--- a/Documentation/githooks.txt
+++ b/Documentation/githooks.txt
@@ -593,7 +593,8 @@ fsmonitor-watchman
 
 This hook is invoked when the configuration option `core.fsmonitor` is
 set to `.git/hooks/fsmonitor-watchman` or `.git/hooks/fsmonitor-watchmanv2`
-depending on the version of the hook to use.
+depending on the version of the hook to use, unless overridden via
+`core.useBuiltinFSMonitor` (see linkgit:git-config[1]).
 
 Version 1 takes two arguments, a version (1) and the time in elapsed
 nanoseconds since midnight, January 1, 1970.
-- 
gitgitgadget

