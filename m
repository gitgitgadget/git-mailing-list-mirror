Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FC2FC00145
	for <git@archiver.kernel.org>; Mon, 12 Dec 2022 21:58:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233626AbiLLV6d (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Dec 2022 16:58:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233529AbiLLV6P (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Dec 2022 16:58:15 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38011EE33
        for <git@vger.kernel.org>; Mon, 12 Dec 2022 13:58:14 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id u12so13678520wrr.11
        for <git@vger.kernel.org>; Mon, 12 Dec 2022 13:58:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Oi1JhA2Y49B3vsv8LyQZ/nUzDuStw5WBLGMA8BZqLVA=;
        b=N0t3WVxvK9Qb5XIjNiXKMtw8l2oGHu5pv6cZHkOlMPOsy1E6ZIRt1ulOJOFIsXRuOw
         S1i1L1lFFP+jUXZvu1KkJw2mv70/6tA/JDHrG4/HTS9s/cG+K6nZv1VjP0oDVZ6RTXa4
         mS/kplIehH7GCdYvqpOfkNlstQHdesBcz8BYWo37f72ckjwsB7twTVK+FXui7/oBCxw4
         cYS7W2lSMKL/4JClbzHRUF2RnwKphlIh093Ariqew7hnBcNk3na4ExlIkgJzgcC7c3j6
         lDy9/dHSaDpfBqJq/Bf0VU6GgqjuiKF7J/AHYtG9E2EOnKxRGdHoQLCI1uqAqYUN5THG
         qstg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Oi1JhA2Y49B3vsv8LyQZ/nUzDuStw5WBLGMA8BZqLVA=;
        b=af7aQRFp2nHaz/jHWeEz6yRPRILqc/QrwuKaovXBm0ZjWVcbIOunvubmoiSCm9U7cI
         epEeftquzj2bOojAi7I5NRFxgeXG8vs98wWc01THYyjeW1ekomFm79rXm7q5zrJ6DuQa
         2/hmjoldx4ITboksWCFz2VlPa0fJ2d59vIEOqSBEpzhvZ8FoHaoAYDVUqd7X58L6nQbn
         sobhi8a0MxyRx0+4umrVQ5nIcS1Y4xndwo5XUAQtDNYj4/Dz9/VNMdx/xESHnw2mqQ8n
         W1WAnCa0/O1mFOlNupDfGEBUEgaENKygpgdmCLJdqFZRYK5L3YP3hEX6JhKJTTyvJUak
         HrBQ==
X-Gm-Message-State: ANoB5pkW1LjuPfBEQcHDjm+qRpI6BpP9Qq3WSLI7C+dQrPAKDOBw50aK
        gFgn7BRN+i2uU6cEce4Cm6fP/VMezmM=
X-Google-Smtp-Source: AA0mqf5WwpF/c9DAHGgRit+/AJpE1qeRm+ASzAR8H/FZ41OPQ4onRr49IAeGwYJYUeu14zOI6NNOQA==
X-Received: by 2002:a5d:5043:0:b0:242:87d0:bf30 with SMTP id h3-20020a5d5043000000b0024287d0bf30mr10580520wrt.4.1670882292439;
        Mon, 12 Dec 2022 13:58:12 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a18-20020adffb92000000b002424b695f7esm9881021wrr.46.2022.12.12.13.58.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Dec 2022 13:58:12 -0800 (PST)
Message-Id: <827410c22ee4846067c79fb83d9e3d9a961be121.1670882286.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1352.v5.git.git.1670882286.gitgitgadget@gmail.com>
References: <pull.1352.v4.git.git.1669230044.gitgitgadget@gmail.com>
        <pull.1352.v5.git.git.1670882286.gitgitgadget@gmail.com>
From:   "Eric DeCosta via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 12 Dec 2022 21:58:05 +0000
Subject: [PATCH v5 6/6] fsmonitor: update doc for Linux
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
