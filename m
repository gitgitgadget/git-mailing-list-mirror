Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 331E3C07E9D
	for <git@archiver.kernel.org>; Tue, 27 Sep 2022 20:58:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232599AbiI0U56 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Sep 2022 16:57:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232261AbiI0U5o (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Sep 2022 16:57:44 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42A2D18B4B0
        for <git@vger.kernel.org>; Tue, 27 Sep 2022 13:57:43 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id c11so16763240wrp.11
        for <git@vger.kernel.org>; Tue, 27 Sep 2022 13:57:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date;
        bh=NZZ/jRI252DzMeVq+3yot+76+uTRZX0nJIDrWhlOFuE=;
        b=AgCveodU+cNT+B6qUY0SVU5aLApIYhWBe93HOdSznALLlEDQEMZbsX/hkgjz7RTDof
         gfLyVN6W1ESBYCAFjXh9cE2hKZWK6IBwYwP330oQT6p1rWDO+O5jtaB6FMcoUmzomf1p
         FZLbfSLmr7bO5mTMHXEa9HH6UjGCDlFjs+Jn26x5ikqBfF3sYAKOnF795usa49iNLybf
         SJh1ZhhGCVF5el+l+QXR9DnkdnOCKGHeBEOpLoRFZUU1FJ/sR7sux8N1e02V4ndHKKm9
         3jpNL3SeAXE+5nRBvXTVN16opLkWRQv0DM0zb3vkjYyBY0+fvQEgd72Ns6kUFwkUbP3L
         nkcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date;
        bh=NZZ/jRI252DzMeVq+3yot+76+uTRZX0nJIDrWhlOFuE=;
        b=vDvoRO8bJrQfpL4xeBdLWFb+rHOmY3deCVjpgh0qaxeVP+u/K49QQrrQb9FKZo32Qt
         4QVtqNGakmEXG0hx3qMRL+BBcfzz4U3lmPOUX6k+IQcqXSLZaPW/pucZcy5/btis8BuL
         nUOk59PFKeJDyYISKR+g9e7sWvAW79Tq8ZTGT+eqoRUmK49Rjtuc6NOsQEta+MNvDfFD
         IdNh6QnLAASZpm7a6thz1aQNcFBvTVCm09h9EmyN+jCY+sm6giYFDwYL5hghNO5FLnvp
         0qMdUi58DR5icUS7Pa0Z3EdZuYjD2o1m5NZsn9QkDo6uLgGieZfjqAYJRzW9/nbQhP7o
         WzJA==
X-Gm-Message-State: ACrzQf0m+8ynwHqEVayc/LAVClNa97gcYfANWZlYcCtRK74JAVrn6qT4
        ni11DEt2YTkG6UNwUc23luIryKsYgrk=
X-Google-Smtp-Source: AMsMyM6BTnkzq3BogVUGt4OxAom5s92mrmF4nNrrf9hq5oV29cGjZmG1COeNnUu/RgRTVf8EKpBvlg==
X-Received: by 2002:a5d:59c3:0:b0:22a:4463:5a3a with SMTP id v3-20020a5d59c3000000b0022a44635a3amr17501891wry.123.1664312261603;
        Tue, 27 Sep 2022 13:57:41 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e12-20020adffc4c000000b0022ad393ba3csm2488486wrs.107.2022.09.27.13.57.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 13:57:41 -0700 (PDT)
Message-Id: <04f607b1f21ede3ef35af05846995e4f80906301.1664312254.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1326.v13.git.1664312253.gitgitgadget@gmail.com>
References: <pull.1326.v12.git.1664048782.gitgitgadget@gmail.com>
        <pull.1326.v13.git.1664312253.gitgitgadget@gmail.com>
From:   "Eric DeCosta via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 27 Sep 2022 20:57:33 +0000
Subject: [PATCH v13 6/6] fsmonitor: add documentation for allowRemote and
 socketDir options
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff Hostetler <git@jeffhostetler.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Torsten =?UTF-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Eric DeCosta <edecosta@mathworks.com>,
        Eric DeCosta <edecosta@mathworks.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Eric DeCosta <edecosta@mathworks.com>

Add documentation for 'fsmonitor.allowRemote' and 'fsmonitor.socketDir'.
Call-out experimental nature of 'fsmonitor.allowRemote' and limited
filesystem support for 'fsmonitor.socketDir'.

Signed-off-by: Eric DeCosta <edecosta@mathworks.com>
---
 Documentation/config.txt                   |  2 ++
 Documentation/config/fsmonitor--daemon.txt | 11 +++++++
 Documentation/git-fsmonitor--daemon.txt    | 37 ++++++++++++++++++++--
 3 files changed, 47 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/config/fsmonitor--daemon.txt

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 5b5b9765699..1e205831656 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -423,6 +423,8 @@ include::config/filter.txt[]
 
 include::config/fsck.txt[]
 
+include::config/fsmonitor--daemon.txt[]
+
 include::config/gc.txt[]
 
 include::config/gitcvs.txt[]
diff --git a/Documentation/config/fsmonitor--daemon.txt b/Documentation/config/fsmonitor--daemon.txt
new file mode 100644
index 00000000000..c225c6c9e74
--- /dev/null
+++ b/Documentation/config/fsmonitor--daemon.txt
@@ -0,0 +1,11 @@
+fsmonitor.allowRemote::
+    By default, the fsmonitor daemon refuses to work against network-mounted
+    repositories. Setting `fsmonitor.allowRemote` to `true` overrides this
+    behavior.  Only respected when `core.fsmonitor` is set to `true`.
+
+fsmonitor.socketDir::
+    This Mac OS-specific option, if set, specifies the directory in
+    which to create the Unix domain socket used for communication
+    between the fsmonitor daemon and various Git commands. The directory must
+    reside on a native Mac OS filesystem.  Only respected when `core.fsmonitor`
+    is set to `true`.
diff --git a/Documentation/git-fsmonitor--daemon.txt b/Documentation/git-fsmonitor--daemon.txt
index cc142fb8612..8238eadb0e1 100644
--- a/Documentation/git-fsmonitor--daemon.txt
+++ b/Documentation/git-fsmonitor--daemon.txt
@@ -3,7 +3,7 @@ git-fsmonitor{litdd}daemon(1)
 
 NAME
 ----
-git-fsmonitor--daemon - A Built-in File System Monitor
+git-fsmonitor--daemon - A Built-in Filesystem Monitor
 
 SYNOPSIS
 --------
@@ -17,7 +17,7 @@ DESCRIPTION
 -----------
 
 A daemon to watch the working directory for file and directory
-changes using platform-specific file system notification facilities.
+changes using platform-specific filesystem notification facilities.
 
 This daemon communicates directly with commands like `git status`
 using the link:technical/api-simple-ipc.html[simple IPC] interface
@@ -63,13 +63,44 @@ CAVEATS
 -------
 
 The fsmonitor daemon does not currently know about submodules and does
-not know to filter out file system events that happen within a
+not know to filter out filesystem events that happen within a
 submodule.  If fsmonitor daemon is watching a super repo and a file is
 modified within the working directory of a submodule, it will report
 the change (as happening against the super repo).  However, the client
 will properly ignore these extra events, so performance may be affected
 but it will not cause an incorrect result.
 
+By default, the fsmonitor daemon refuses to work against network-mounted
+repositories; this may be overridden by setting `fsmonitor.allowRemote` to
+`true`. Note, however, that the fsmonitor daemon is not guaranteed to work
+correctly with all network-mounted repositories and such use is considered
+experimental.
+
+On Mac OS, the inter-process communication (IPC) between various Git
+commands and the fsmonitor daemon is done via a Unix domain socket (UDS) -- a
+special type of file -- which is supported by native Mac OS filesystems,
+but not on network-mounted filesystems, NTFS, or FAT32.  Other filesystems
+may or may not have the needed support; the fsmonitor daemon is not guaranteed
+to work with these filesystems and such use is considered experimental.
+
+By default, the socket is created in the `.git` directory, however, if the
+`.git` directory is on a network-mounted filesystem, it will be instead be
+created at `$HOME/.git-fsmonitor-*` unless `$HOME` itself is on a
+network-mounted filesystem in which case you must set the configuration
+variable `fsmonitor.socketDir` to the path of a directory on a Mac OS native
+filesystem in which to create the socket file.
+
+If none of the above directories (`.git`, `$HOME`, or `fsmonitor.socketDir`)
+is on a native Mac OS file filesystem the fsmonitor daemon will report an
+error that will cause the daemon and the currently running command to exit.
+
+CONFIGURATION
+-------------
+
+include::includes/cmd-config-section-all.txt[]
+
+include::config/fsmonitor--daemon.txt[]
+
 GIT
 ---
 Part of the linkgit:git[1] suite
-- 
gitgitgadget
