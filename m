Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFA45C433F5
	for <git@archiver.kernel.org>; Sun,  9 Oct 2022 14:38:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230253AbiJIOij (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 9 Oct 2022 10:38:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230146AbiJIOh4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Oct 2022 10:37:56 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6DA027CCD
        for <git@vger.kernel.org>; Sun,  9 Oct 2022 07:37:51 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id bk15so13614880wrb.13
        for <git@vger.kernel.org>; Sun, 09 Oct 2022 07:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Oi1JhA2Y49B3vsv8LyQZ/nUzDuStw5WBLGMA8BZqLVA=;
        b=P0ZcnYOjTLOBkaF1l7Hg5kp1y2NFOp0EZum0L/c9Q7y6Ps06jMhUALqywCICDexy9r
         dv+782m3MK79/fhIWHBl3+5Pk9itBgyQEqNSDJYGYY7x2qywx9gRdIFATtJAJVOJ1cuk
         xw+SIRAE61lH1jTdAdacL0FMpndqCew4P77Rsy8uD+r8Mc3+tCxL/ZVKkV5LTFb17FeV
         ldxtOzZFPSiYKHAdh6Efk44lFj0ilOcvUsWncXzakJqj/tDt/BnvioB3fgGwGfl+WH8j
         2jhwfvWcBRqCRFZRzErlmetM7mufCBTbdMWV1zOBfXT2lZ/CjM5p4ZLFASu7kJZXnvvf
         HXIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Oi1JhA2Y49B3vsv8LyQZ/nUzDuStw5WBLGMA8BZqLVA=;
        b=g7Cdd/dgYX7Y/vW04sdP2ihvt8gJG89tdU/+0m2yBlHhUlqwkXQ1FapsfipLSC9lYT
         tm47UGFXGGAMYlblyujKYVF32HTk8MlIQ82BKWMS61/C5ueAZtc3jSg5x+wFkSsMCJ4w
         bOmZUMA80/5JjgjpCdLkmjdSuVIyEBk9bR3fK3N/0Hgk4uHucKL2UBfmQszTIlpRbgVI
         8XI2pd67yuRzcAXlOidSM+/J3ee//rf8M4R0w5jA+UkDdYcSoLOzxc5dGkfJqKj/23sn
         GKz9nDqqV5umNBpTKMFGnio8JGXe9Ms3lKkg8H7UZ+Fu68kGC8/rmKeqFSe8oiydYuqG
         jd0Q==
X-Gm-Message-State: ACrzQf30L7rPBNEZn9YqRaQg2y3tiePGki7U26bLKiOCIQN3mMLJWoY8
        HGTaFvCon5EvVBCGT5/hcldqmyxHtDc=
X-Google-Smtp-Source: AMsMyM4CaIqsgpPouXzqJgVCRoJiabd/mXx1p3fP191CYhT4qlICh0eZFy1HTprga2dDuH5aJEPx+Q==
X-Received: by 2002:a5d:490f:0:b0:22e:4bae:c06d with SMTP id x15-20020a5d490f000000b0022e4baec06dmr8716990wrq.549.1665326271175;
        Sun, 09 Oct 2022 07:37:51 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k16-20020adfe8d0000000b0022cd0c8c696sm6536344wrn.103.2022.10.09.07.37.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Oct 2022 07:37:50 -0700 (PDT)
Message-Id: <77ed35b3b80de9ecfea179357115428ab89d9864.1665326258.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1352.git.git.1665326258.gitgitgadget@gmail.com>
References: <pull.1352.git.git.1665326258.gitgitgadget@gmail.com>
From:   "Eric DeCosta via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 09 Oct 2022 14:37:38 +0000
Subject: [PATCH 12/12] fsmonitor: update doc for Linux
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
