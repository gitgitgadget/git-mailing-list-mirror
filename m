Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9DAFC4332F
	for <git@archiver.kernel.org>; Fri, 14 Oct 2022 21:46:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229751AbiJNVqs (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Oct 2022 17:46:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229988AbiJNVqh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Oct 2022 17:46:37 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC9D44D4C8
        for <git@vger.kernel.org>; Fri, 14 Oct 2022 14:46:01 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id a10so9508066wrm.12
        for <git@vger.kernel.org>; Fri, 14 Oct 2022 14:46:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Oi1JhA2Y49B3vsv8LyQZ/nUzDuStw5WBLGMA8BZqLVA=;
        b=naZ4cg7tt4tUhw1MoOR/WMrw4TbLg6ZdwMVGI31B6LN1dkbB5Cgcfa8JEkgCyWEs6v
         qR7x3y5TqsrplKCO5GKWWPiCubss5HO9r4NnAhYoDBccyRnxdujWulx/q+M1tnUply0u
         c71Nao/qX+U/200f71mS90urDY/KLrT61IY7A6YZhlB1WihrcPvRVmxXsjQEFKVnCNEz
         byb72SKIVR2KsOm+YwLsVHs8VGWUyL/c/aaysl4+xMtDYUvyHbLq5WqZR+28rxq8+w9q
         hJEeHA+e7D8tDPuKD4j8ED2riVn3p0zgdIsGh3q0apyeHT/r02r4kid8ByPTdiSTQL9G
         mH0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Oi1JhA2Y49B3vsv8LyQZ/nUzDuStw5WBLGMA8BZqLVA=;
        b=2Msj8V0pR6w0bHHBYZuQf/Uw8F/W1Yd1zM2V10QMthnptSuoRbEatXPv7v3u3b5OwJ
         d4bV7n1+5v51m9ohOD5CD3vjkSFa9o6Q9yLrHZAk8O/qvIKwsXuFkeQjo1Xr5k09zDcz
         1bk+hZGoWwUjqJtG2J+NLCMqoUJY3OUFtgLXMf1nhyhhJc3jK6p6UGG/JC7UJn8Sxfip
         vERNTNkpak8qJ9KZtynvK5X4u9lrZ3hUuWh3QL8n5LmA5w817/EvYuu/xmgg8Mz/1/9Q
         J7dsWBBvMscr/BvRsIAvDozpdJ+5IHci23/kN/9IhsJN9XhafVd8/pTW27O4rdsOvFGy
         /msA==
X-Gm-Message-State: ACrzQf1WVqzaWn8teLCEs6penlym6PWp8MLo31ThQhX/iWXQkhmENC/R
        U4LNm0lyOoJ/++CCEJ6mA2PC+JZ4T2A=
X-Google-Smtp-Source: AMsMyM73LkIOHMBaxNfXEqlWC7R3aoLAuLtF73zAGQHlpk70McifgrQiXAcTAkh3xuyNIwkK+r0B4w==
X-Received: by 2002:a5d:64e3:0:b0:231:86ac:978a with SMTP id g3-20020a5d64e3000000b0023186ac978amr4382653wri.283.1665783960138;
        Fri, 14 Oct 2022 14:46:00 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a13-20020a05600c348d00b003c6c76b43a1sm3050228wmq.13.2022.10.14.14.45.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Oct 2022 14:45:59 -0700 (PDT)
Message-Id: <dd73e126810615dac744e7097df66a921336018f.1665783945.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1352.v2.git.git.1665783944.gitgitgadget@gmail.com>
References: <pull.1352.git.git.1665326258.gitgitgadget@gmail.com>
        <pull.1352.v2.git.git.1665783944.gitgitgadget@gmail.com>
From:   "Eric DeCosta via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 14 Oct 2022 21:45:44 +0000
Subject: [PATCH v2 12/12] fsmonitor: update doc for Linux
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Eric DeCosta <edecosta@mathworks.com>,
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
