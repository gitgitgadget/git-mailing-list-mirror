Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91529C433FE
	for <git@archiver.kernel.org>; Sun,  9 Oct 2022 14:38:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230217AbiJIOiB (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 9 Oct 2022 10:38:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230141AbiJIOhs (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Oct 2022 10:37:48 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41FED27CCD
        for <git@vger.kernel.org>; Sun,  9 Oct 2022 07:37:47 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id bv10so10088706wrb.4
        for <git@vger.kernel.org>; Sun, 09 Oct 2022 07:37:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NZZ/jRI252DzMeVq+3yot+76+uTRZX0nJIDrWhlOFuE=;
        b=Z6QnnwL76/B0+k2XLphhue+RGYap+mtJB0Se946r/qIFdKv9Xq0I1rF40SNPf/9Hge
         1WE/Kt2VmS6NCUlU867qNF0lgf0WpzaTYTekAOWeIQu2kpzxIEry37j8sRSDQpZGZZSK
         C3y9yNTkRXGFMmtGbWIq0V9+fx/yexsII3N4sbjKDTv4JfjVJLgriUpzl+9OOdNihZs2
         hqaJsw1nLxJMQYVNFLeYxTOFrhp5/BZP96nGWYDUHa2sq970UB7izwOIh1+ZW76sCCWM
         wNWCeaz2FzvSVA6MOBncqax18T1cFshOonBkGRmb31EXfsUxoXlv7bKQEz7Sq6MVdwq2
         Q8TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NZZ/jRI252DzMeVq+3yot+76+uTRZX0nJIDrWhlOFuE=;
        b=mN3386Y2tDNoOeqFZV7wJqqzhJu6Hq/s+WjmMFkNxrLhyty2x7wnVpZBZ9fTL6hCHt
         x+dnmd4z3jXV6JxIEXb/einCPp0k48D10UD/MR/7nLqhjtoiFbfoXqT+aJbDIw4GshW7
         WeAQHx2nyUUbdW483wfgqikiPt5KTJPX5DGGqGt0VI+66EpZecKB2AyTTiuO3xGaHInI
         LwtGnF3n0wWNfGyVc3L+HCY5/wqJYGkoFqmLbxnUj7f+oUssUbHQm4ihId0d7fSpdeBu
         F04cevX/nIaVPYM62veVYS4gcbL/s+PO8CSCILuSmK5kJ5SB9gbraBqAUxZpYTexwqZr
         fqYA==
X-Gm-Message-State: ACrzQf1a6X5bcc1vItIqkB8IUwRlu9jiN9EVXs08qs9CYU/2RPyIpR8w
        MDMALkTemCXeoRYGxrHF2w3L2GB6Fls=
X-Google-Smtp-Source: AMsMyM5kLRTfKF2kJV8gFVJxiURQ4UUq2HUNApO8KOoOA7sw7mn0nZbonBe7dwsAfjxBcb5cR3fYFw==
X-Received: by 2002:adf:f011:0:b0:22e:4485:34c2 with SMTP id j17-20020adff011000000b0022e448534c2mr9432149wro.593.1665326265438;
        Sun, 09 Oct 2022 07:37:45 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l19-20020a05600c089300b003c5571c27a1sm3853675wmp.32.2022.10.09.07.37.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Oct 2022 07:37:44 -0700 (PDT)
Message-Id: <af7309745f759532fdb79794289d9e02de0e035c.1665326258.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1352.git.git.1665326258.gitgitgadget@gmail.com>
References: <pull.1352.git.git.1665326258.gitgitgadget@gmail.com>
From:   "Eric DeCosta via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 09 Oct 2022 14:37:32 +0000
Subject: [PATCH 06/12] fsmonitor: add documentation for allowRemote and
 socketDir options
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Eric DeCosta <edecosta@mathworks.com>,
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

