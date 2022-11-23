Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A72D4C4332F
	for <git@archiver.kernel.org>; Wed, 23 Nov 2022 19:01:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239338AbiKWTB0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Nov 2022 14:01:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239427AbiKWTBF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Nov 2022 14:01:05 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2BE1922E4
        for <git@vger.kernel.org>; Wed, 23 Nov 2022 11:00:56 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id e11so17920999wru.8
        for <git@vger.kernel.org>; Wed, 23 Nov 2022 11:00:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Oi1JhA2Y49B3vsv8LyQZ/nUzDuStw5WBLGMA8BZqLVA=;
        b=UmAFrMfHBOhFifoeTxJB/lTArTwZWGYEFJu2bnZuW5LtEyTvf0xn/E3rPzbReneijI
         aMKyBZdeb2e91yrJOW2bI5o+iYrpUyLf8NoHU1gluRyMWEbDaBPzwV9DTCx4+tZwd9ag
         QresmKH+n551uYgUnidxbRordFZPfWYM/OlROspRc2nPL00KxITLJhsurJcX6/T6C4QE
         F2negrB78T5MRD0maWGSWXVJOSQDgEta6EdFKOXiUdeK+iCLJ37mCw3WBAwPDR1AmNT7
         3oCuuL5YIbLIpMRsYCj///0HLl1OrYUrZ/30N7nQod8nUe5Xq02xJYlcS0DkhEXVRYVr
         qTgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Oi1JhA2Y49B3vsv8LyQZ/nUzDuStw5WBLGMA8BZqLVA=;
        b=Y7XhESvTA7P4qEHURK7wRbAFz3xAL73rONr3YViYBGNTYBZwKP0WKsU2f30RDXftxP
         kfpsbCKHVMtwmoR83p8GsYoOhETRl+wYhMlrQPttiMeEtaouAWWupwal+5QK2WusYKPy
         MvRFmnTksN+NlLus4od0ZOR0YlW/bvY1Vgq2SQW/i1Z9rzTrqfOzFMvxeozR3RelcSR0
         aCfy2DWoJc+fpdsWAnvurzF+qmSUKQQGE/aiFm8zsK4HvdTcZeW2gO1DGpuPBJiiVOtU
         OJOPxvB8x7cRZa7fU04cPWqnkNcsOy7d4jn4TgHVN+E47y0+opZhLankm8ZSvVp/RF20
         /WRw==
X-Gm-Message-State: ANoB5pk+DjxKxGKM6joR9ZPjMhWsMLw5fZUTBodEN4OG9jJ0WfPvIN3V
        CXkCt4bByJuOVuPbrY8kW2R9vlbwPVo=
X-Google-Smtp-Source: AA0mqf4rpT2h8PmZBU34/2/WM6+AcXQrFAjszIETg0jIUGj7Z9Strm3BSrTtRdDtpeSPHO2fn6UxIQ==
X-Received: by 2002:adf:e305:0:b0:236:6089:cc5e with SMTP id b5-20020adfe305000000b002366089cc5emr9394907wrj.118.1669230054373;
        Wed, 23 Nov 2022 11:00:54 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e19-20020a05600c219300b003c6bd12ac27sm2960179wme.37.2022.11.23.11.00.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Nov 2022 11:00:53 -0800 (PST)
Message-Id: <5afd03fa6ca3a790eb06213573d9be3c40dee492.1669230044.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1352.v4.git.git.1669230044.gitgitgadget@gmail.com>
References: <pull.1352.v3.git.git.1668641019.gitgitgadget@gmail.com>
        <pull.1352.v4.git.git.1669230044.gitgitgadget@gmail.com>
From:   "Eric DeCosta via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 23 Nov 2022 19:00:44 +0000
Subject: [PATCH v4 6/6] fsmonitor: update doc for Linux
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Glen Choo <chooglen@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Taylor Blau <me@ttaylorr.com>,
        Eric DeCosta <edecosta@mathworks.com>,
        Eric DeCosta <edecosta@mathworks.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Eric DeCosta <edecosta@mathworks.com>

Update the documentation for Linux.

Signed-off-by: Eric DeCosta <edecosta@mathworks.com>
---
 Documentation/config/fsmonitor--daemon.txt |  4 ++--
 Documentation/git-fsmonitor--daemon.txt    | 24 ++++++++++++++--------
 2 files changed, 18 insertions(+), 10 deletions(-)

diff --git a/Documentation/config/fsmonitor--daemon.txt b/Documentation/config/fsmonitor--daemon.txt
index c225c6c9e74..2cafb040d96 100644
--- a/Documentation/config/fsmonitor--daemon.txt
+++ b/Documentation/config/fsmonitor--daemon.txt
@@ -4,8 +4,8 @@ fsmonitor.allowRemote::
     behavior.  Only respected when `core.fsmonitor` is set to `true`.
 
 fsmonitor.socketDir::
-    This Mac OS-specific option, if set, specifies the directory in
+    Mac OS and Linux-specific option. If set, specifies the directory in
     which to create the Unix domain socket used for communication
     between the fsmonitor daemon and various Git commands. The directory must
-    reside on a native Mac OS filesystem.  Only respected when `core.fsmonitor`
+    reside on a native filesystem.  Only respected when `core.fsmonitor`
     is set to `true`.
diff --git a/Documentation/git-fsmonitor--daemon.txt b/Documentation/git-fsmonitor--daemon.txt
index 8238eadb0e1..c2b08229c74 100644
--- a/Documentation/git-fsmonitor--daemon.txt
+++ b/Documentation/git-fsmonitor--daemon.txt
@@ -76,23 +76,31 @@ repositories; this may be overridden by setting `fsmonitor.allowRemote` to
 correctly with all network-mounted repositories and such use is considered
 experimental.
 
-On Mac OS, the inter-process communication (IPC) between various Git
+On Linux and Mac OS, the inter-process communication (IPC) between various Git
 commands and the fsmonitor daemon is done via a Unix domain socket (UDS) -- a
-special type of file -- which is supported by native Mac OS filesystems,
-but not on network-mounted filesystems, NTFS, or FAT32.  Other filesystems
-may or may not have the needed support; the fsmonitor daemon is not guaranteed
-to work with these filesystems and such use is considered experimental.
+special type of file -- which is supported by many native Linux and Mac OS
+filesystems, but not on network-mounted filesystems, NTFS, or FAT32.  Other
+filesystems may or may not have the needed support; the fsmonitor daemon is not
+guaranteed to work with these filesystems and such use is considered
+experimental.
 
 By default, the socket is created in the `.git` directory, however, if the
 `.git` directory is on a network-mounted filesystem, it will be instead be
 created at `$HOME/.git-fsmonitor-*` unless `$HOME` itself is on a
 network-mounted filesystem in which case you must set the configuration
-variable `fsmonitor.socketDir` to the path of a directory on a Mac OS native
+variable `fsmonitor.socketDir` to the path of a directory on a native
 filesystem in which to create the socket file.
 
 If none of the above directories (`.git`, `$HOME`, or `fsmonitor.socketDir`)
-is on a native Mac OS file filesystem the fsmonitor daemon will report an
-error that will cause the daemon and the currently running command to exit.
+is on a native Linux or Mac OS filesystem the fsmonitor daemon will report
+an error that will cause the daemon to exit and the currently running command
+to issue a warning.
+
+On Linux, the fsmonitor daemon registers a watch for each directory in the
+repository.  The default per-user limit for the number of watches on most Linux
+systems is 8192.  This may not be sufficient for large repositories or if
+multiple instances of the fsmonitor daemon are running.
+See https://watchexec.github.io/docs/inotify-limits.html[Linux inotify limits] for more information.
 
 CONFIGURATION
 -------------
-- 
gitgitgadget
