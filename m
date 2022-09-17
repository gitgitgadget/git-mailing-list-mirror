Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60CEDECAAA1
	for <git@archiver.kernel.org>; Sat, 17 Sep 2022 01:12:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229816AbiIQBMo (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Sep 2022 21:12:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbiIQBMb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Sep 2022 21:12:31 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6102A024C
        for <git@vger.kernel.org>; Fri, 16 Sep 2022 18:12:29 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id l8so11727691wmi.2
        for <git@vger.kernel.org>; Fri, 16 Sep 2022 18:12:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date;
        bh=025X2g9D0LRmHIXCb4ajLdQRUPyvqsq2+nEHj3JaJps=;
        b=HBLLHxiC3WuqUv4KZJHL16tEcfEDKlZdqJoQU/ZvKe96Zo1WaqS4K9tngn7uF0LYpL
         XsLwMdPhz+989LnhfROz44r7UqWVoqKt5T8R6UeClj9Ky4XM0imN9oPt9Hgtb2LugNof
         fhdMqSzivYMjf26cnZQL4FsiOgfxzAvgluOoQZ/phhuWgCVIs2nOwguvqiTdYzWbdiyL
         SaJPghft2liYyhLGPT5bViT8nYo131VvPNTw1hd92rTYhC+rLrhjjMreoQ9QcCw3Ts5+
         1leuqM3zt9/TKA6vBgHgW41OXvcj+dH+3TLpZ8iFfx6GsyunVPnvHi3wQ4YP9JALm7GM
         /LAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date;
        bh=025X2g9D0LRmHIXCb4ajLdQRUPyvqsq2+nEHj3JaJps=;
        b=VKZ5AQZrwBixA/5hvZANN+FjEbSfvjR5NWdqyCLzeswK2hvy054E4SYemlRwKSve0Y
         JJZcPM3u3PzrCujMAWZDk8qiNZ5TGAT7cvtE0N0U5G6jpcQOIvlzpaEt3308MlmzF6kh
         AVyLJnj9OGBdv1/p6L5NFDU3aRguT15KR87j2+dcBXVpWEN2K/pIV8yZaMsahiPd2DTD
         /aw9sMHlDdB1XwkHX3QI8wmNqzXaDEKIU5aAt+ZQ5nc0JnnAJHOJ/gztbMd3kbM5gMHJ
         NABFslflPv3dnSfiyQxvPNhSfW6fginQ35TyT8Ji+u5QcIcopljWcbuzyO/aeFPzYa67
         WOwQ==
X-Gm-Message-State: ACgBeo1uOcEX9HqfJx8gmKYFcXkEL/8A31XK4se2OguUNSg8BwJS1Xdh
        F4PxWvTxmdvu9tgWmrCePcmQnTIJZsA=
X-Google-Smtp-Source: AA6agR7a67AdiQCvQfp7gUyE7pxFXi8WuC2RjevlyPds44iB1crERtDkUkqRCobHaSLGVeTbYWkgJA==
X-Received: by 2002:a1c:44d5:0:b0:3b4:9c41:439f with SMTP id r204-20020a1c44d5000000b003b49c41439fmr11731200wma.13.1663377148067;
        Fri, 16 Sep 2022 18:12:28 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q6-20020a05600c46c600b003b4935f04aasm4127016wmo.10.2022.09.16.18.12.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Sep 2022 18:12:27 -0700 (PDT)
Message-Id: <ddf4e3e6442b104447154b0a5d4954f274f4b5ef.1663377141.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1326.v8.git.1663377141.gitgitgadget@gmail.com>
References: <pull.1326.v7.git.1663358014.gitgitgadget@gmail.com>
        <pull.1326.v8.git.1663377141.gitgitgadget@gmail.com>
From:   "Eric DeCosta via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 17 Sep 2022 01:12:21 +0000
Subject: [PATCH v8 5/5] fsmonitor: add documentation for allowRemote and
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
 Documentation/git-fsmonitor--daemon.txt | 35 +++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/Documentation/git-fsmonitor--daemon.txt b/Documentation/git-fsmonitor--daemon.txt
index cc142fb8612..0adccd0eced 100644
--- a/Documentation/git-fsmonitor--daemon.txt
+++ b/Documentation/git-fsmonitor--daemon.txt
@@ -70,6 +70,41 @@ the change (as happening against the super repo).  However, the client
 will properly ignore these extra events, so performance may be affected
 but it will not cause an incorrect result.
 
+By default, the fsmonitor daemon refuses to work against network-mounted
+repositories; this my be overridden by setting `fsmonitor.allowRemote` to
+`true`. Note, however, that the fsmonitor daemon is not guaranteed to work
+correctly with all network-mounted repositores and such use is considered
+experimental.
+
+On Mac OS, the inter-process communication (IPC) between various Git
+commands and the fsmonitor daemon is done via a Unix domain socket (UDS).
+Usage of UDS requires the creation of a file which, by default, is created
+in the .git directory.  If the fsmonitor daemon detects that the .git directory
+is on a network-mounted file system, it will create the UDS file in $HOME.  If
+$HOME itself is on a network-mounted file system or if $HOME is not the desired
+location for the UDS file, 'fsmonitor.socketDir' may be set to any valid, local
+directory on a file system with proper support.  Mac OS native file systems have
+the required support.  File systems known to lack support include FAT32 and
+NTFS.  Other file systems may or many not have the needed support; the fsmonitor
+daemon is not guaranteed to work with these file systems and such use is
+considered experimental.
+
+CONFIGURATION
+-------------
+When `core.fsmonitor` is set to `true` (see linkgit:git-config[1])
+the fsmonitor daemon will pay attention to the following configuration
+variables:
+
+fsmonitor.allowRemote::
+	By default, the daemon refuses to work against network-mounted
+	repositories. Setting `fsmonitor.allowRemote` to `true` overrides
+	this behavior.
+
+fsmonitor.socketDir::
+	This option is only used by the Mac OS implementation of the fsmonitor
+	daemon.	If set, 'fsmonitor.socketDir' must be set to a valid, local
+	directory on a file system that can support Unix domain sockets (UDS).
+
 GIT
 ---
 Part of the linkgit:git[1] suite
-- 
gitgitgadget
