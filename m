Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15ADFC6FA82
	for <git@archiver.kernel.org>; Tue, 20 Sep 2022 20:33:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230236AbiITUdo (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Sep 2022 16:33:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230207AbiITUd0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Sep 2022 16:33:26 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62CD175CD5
        for <git@vger.kernel.org>; Tue, 20 Sep 2022 13:33:16 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id g3so6390037wrq.13
        for <git@vger.kernel.org>; Tue, 20 Sep 2022 13:33:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date;
        bh=LRAZFpHOU5+ay4ne+GDRmL5kg+GCUi05Q3xa/zAhpco=;
        b=UNltnlfe05uwxerHKB0WLdCWfRSrqnWktiyV1S5egJaxXsJ/l/w8qxRr5MrKJUZBX1
         upBbOcqhkpPFu4OJbW5NnLO2zZHVMq6tA1BBvGa7c5FoiXi0TeUtEtiTC/eUbzbQJ7/K
         ve8PEEub1m+EaDxOCCuAw5YmyBQ+VxGsMav4pbc0Djz4Hrk/tfJq6Ams7vNPuhz60Epe
         C7zeoIutFYFx15XHCHSC0/rmzdZrc5+utWBV94yPJx3qCR2W6As3Bc0Uc07czuxE+FvK
         klNI8oNPiNYy4WxPA6tjXqQ7URpMQrnMq+OnOaIRzlGKNg2+u5J8HbOAShOmHi+Hfzv6
         W6og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date;
        bh=LRAZFpHOU5+ay4ne+GDRmL5kg+GCUi05Q3xa/zAhpco=;
        b=kVcH/9jvFHBpCBmHCuGGf1WFUbvNnmGBEIZcyoBdh7rm3czSt5ZuDF13VVcFFDDkSH
         BGDvrDjqQEsren99TWMMvRFpNLWPpg63pkM8vLrBcgrSiQDm50o1dBQNFo1yJ6GI5+mV
         twXF/6sfVgaaXvLEEBdPNhNhnFiHaMyu0BLxzOlP6ngwkfuF5ky36U+a7OE7BMcP1XDW
         dDXI2LLp1Pv8DF20rwguVs8z2G6T1qs0iWuAFhe8tSXCcc94m87g4n0aoHXTWVKRnbvn
         lEvyEnITbH/ZKE8FN42mrQndHy/W6e3u7snsYskY8uIkCLL1FvI7C//YGmdbm+fbl4mh
         xT2A==
X-Gm-Message-State: ACrzQf1ba/QEp4VfkAKpbOoUU6qchQi4maDK4C2IHZYT7jzEgN1jIZGA
        16NjLiaxTwtq4an15/HvkdUgumeuqQ4=
X-Google-Smtp-Source: AMsMyM7UBZyCy6hGdFxVvMl+pEUJ4y0yisgO+/pANjwFog4L07ftXOtjfu0gxfEiKz74qpZEly9hEg==
X-Received: by 2002:adf:e9d2:0:b0:22a:e4e2:37f1 with SMTP id l18-20020adfe9d2000000b0022ae4e237f1mr13042765wrn.339.1663705994376;
        Tue, 20 Sep 2022 13:33:14 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o35-20020a05600c512300b003a5b6086381sm739678wms.48.2022.09.20.13.33.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Sep 2022 13:33:13 -0700 (PDT)
Message-Id: <d7c25bf96c6e952e1dd6f886b58cdaa5d9a6422e.1663705986.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1326.v10.git.1663705986.gitgitgadget@gmail.com>
References: <pull.1326.v9.git.1663616277.gitgitgadget@gmail.com>
        <pull.1326.v10.git.1663705986.gitgitgadget@gmail.com>
From:   "Eric DeCosta via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 20 Sep 2022 20:33:06 +0000
Subject: [PATCH v10 6/6] fsmonitor: add documentation for allowRemote and
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
Call-out experimental nature of 'fsmonitor.allowRemote' and limited file
system support for 'fsmonitor.socketDir'.

Signed-off-by: Eric DeCosta <edecosta@mathworks.com>
---
 Documentation/git-fsmonitor--daemon.txt | 48 +++++++++++++++++++++++--
 1 file changed, 45 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-fsmonitor--daemon.txt b/Documentation/git-fsmonitor--daemon.txt
index cc142fb8612..6ad3e518ae0 100644
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
@@ -63,13 +63,55 @@ CAVEATS
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
+When `core.fsmonitor` is set to `true` (see linkgit:git-config[1])
+the fsmonitor daemon will pay attention to the following configuration
+variables:
+
+`fsmonitor.allowRemote`::
+	By default, the daemon refuses to work against network-mounted
+	repositories. Setting `fsmonitor.allowRemote` to `true` overrides
+	this behavior.
+
+`fsmonitor.socketDir`::
+    This Mac OS-specific option, if set, specifies the directory in
+    which to create the Unix domain socket used for communication
+    between fsmonitor and various Git commands. The directory must
+    reside on a native Mac OS filesystem as discussed above.
+
 GIT
 ---
 Part of the linkgit:git[1] suite
-- 
gitgitgadget
