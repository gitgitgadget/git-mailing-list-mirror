Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD394C32771
	for <git@archiver.kernel.org>; Wed, 28 Sep 2022 20:12:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234352AbiI1UMo (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Sep 2022 16:12:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233585AbiI1UMY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Sep 2022 16:12:24 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB008A2860
        for <git@vger.kernel.org>; Wed, 28 Sep 2022 13:12:21 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id cc5so21463046wrb.6
        for <git@vger.kernel.org>; Wed, 28 Sep 2022 13:12:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date;
        bh=NZZ/jRI252DzMeVq+3yot+76+uTRZX0nJIDrWhlOFuE=;
        b=hyM7fq/Am70DmNavvxWH5jzLzA4IwFqTpE/IeYrInrgxZvWVA7/TxA+AJQ497VNuzs
         Pi0vw8LbMXUECNwUg6AcD32QGvW45nF3+D4db0Lyv5TzEDW+8hmgQpgvf/VKKYbPi9lw
         vAPnBQGz94BnpDpuUt88CWl05JLh5OrG4E3o7kRzLtga1zEQQETDBYUUoiGvzyWatrqd
         LraVFyjguPIUdGiuxpVx0pWMVTxYxCLqj0ryF968cgh/7eufRhZlExKFVceY8Ggt+H2v
         k3G+k00pb/KXzEsswGXFk7ErljjCHOQd9WrNmfDf84DWkjWssEBld014vPAEWxofpoTb
         P5rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date;
        bh=NZZ/jRI252DzMeVq+3yot+76+uTRZX0nJIDrWhlOFuE=;
        b=UrqsWI2iX64jNuts+gqcnkuSmFp/Df8tWaarD3SEGIJJrndzL5yxGA32/qI7EnzTGK
         GO1cGgUcEVqE/DZcGyGrc20TOM6P0v4aS8sqDom10fMUPc7SDvss2xHukhPeOmNVKZIo
         dYel6nJpqX5tM+NWyGe8P6D+aybUvfmGaQmA0xlJ3jgjsj3EZRXxJaxgOdRHoagpzDHZ
         dwfUkeBSRAeV5TviAAFinbGj6VvOjXE/7JtFiz6j+rb17SsiU/KEkUyQWGao9168gpUz
         f55yFYdXkaPNgY2EjgXChYDiVyiwKccU3IPHrVb/fpqkpAOMpb/QVmSyf8vMiJCRawMZ
         Td8g==
X-Gm-Message-State: ACrzQf2onKZVNNvmHWo2EAXft6XOLfEj2aT3Vl5yE3d1URduUh7jGH/S
        780fStdZhzXpj2NzS3ZE+64U36TUg30=
X-Google-Smtp-Source: AMsMyM5UbZ0Lq28FIIa11Zhfg5j9cAryT+bL8uNt0FCzeWlINPX9lcfoTnXJpbQX3l6+JBVbOpf4xQ==
X-Received: by 2002:a05:6000:1446:b0:22b:968:446 with SMTP id v6-20020a056000144600b0022b09680446mr21520282wrx.493.1664395939770;
        Wed, 28 Sep 2022 13:12:19 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o2-20020adfeac2000000b00228c375d81bsm5111319wrn.2.2022.09.28.13.12.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Sep 2022 13:12:19 -0700 (PDT)
Message-Id: <ed14fbd009eae5f67524e5aba99d0a917f29ae7f.1664395931.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1326.v14.git.1664395931.gitgitgadget@gmail.com>
References: <pull.1326.v13.git.1664312253.gitgitgadget@gmail.com>
        <pull.1326.v14.git.1664395931.gitgitgadget@gmail.com>
From:   "Eric DeCosta via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 28 Sep 2022 20:12:11 +0000
Subject: [PATCH v14 6/6] fsmonitor: add documentation for allowRemote and
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
