Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E65FECAAD8
	for <git@archiver.kernel.org>; Tue, 13 Sep 2022 20:28:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229935AbiIMU2M (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Sep 2022 16:28:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229976AbiIMU17 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Sep 2022 16:27:59 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9410066115
        for <git@vger.kernel.org>; Tue, 13 Sep 2022 13:27:48 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id n17-20020a05600c501100b003a84bf9b68bso10221663wmr.3
        for <git@vger.kernel.org>; Tue, 13 Sep 2022 13:27:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date;
        bh=025X2g9D0LRmHIXCb4ajLdQRUPyvqsq2+nEHj3JaJps=;
        b=KH1/pwXcn7n27DNRPMKyKXQwNsuL9Wu//9Xgxr9FzFv3OXYj4T7j9tFrhADCJoQ6zN
         9f7hsB25WPousQTLMlakei4WyBggQnONBTsjGXeB/2dnVJxEHdyuSpHDIRqGqp/93mmY
         wGCmnLFziHm1YoJwRYmwx9ZpMXQhH9iF4JDUbOeFf9OqOo/+MEeZOqSqXvsx/9mNROEw
         XBfM3BEvZrA7k6y3I9QiBB+FqwcHEJ4R9xlRf1KWHUFVGBt6H1WYLEbbJBDBTF/mH6C0
         U4QqxfmM1+/7l3v1+p/DIQYl6Cy1wrhQRnC5mGSgxUPdSCzyeRoOTz00mdHHi/4C9kvF
         BEhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date;
        bh=025X2g9D0LRmHIXCb4ajLdQRUPyvqsq2+nEHj3JaJps=;
        b=0xj16zd+yt1/Y5tpMLQhCOebGXNverjr5qRbR7njZRM6JjGz/Dg9NY/McSgzfNkpoj
         MpqJfnw321KrNHLlq77II/M5F7h7TbfxRyujd2czc05J+e/FvyeoegAQFExogX9WYXME
         jZ7YnjTXKT91uVDQz+eS6JIEy23ea4PfiwF6CCeWrvYjBdl/a+8IyJY9FPNXQcFQKOSP
         lCMBNBH2T8lQlarjiUhO2sxpZB09A6XESfUxlVZaMODO1Lk/VSjcEj6UR/rV6NMzlDmd
         quVpu2Mc8V+09F5Yg9w1Sf/YARRfX3Hwyr0gou7Vg/KqcugXyIdYQiz9bpj/lncK63xq
         9Rcw==
X-Gm-Message-State: ACgBeo1tA1a4MxZ7I+yj6ogXzE8TzsLpFyAgv+ne+VBpNBNeVshhMh3E
        KXnfHR/EknVfHPmI/Fb2RvrJOg8QYl4=
X-Google-Smtp-Source: AA6agR75NTXMmems1m8oRuSkenbOgyxCe+e3OXqCry4M0ZWVWwHnkjX6tP8VBzAim0M5MCIrpUjifA==
X-Received: by 2002:a05:600c:384e:b0:3a9:6f5a:b6aa with SMTP id s14-20020a05600c384e00b003a96f5ab6aamr706801wmr.131.1663100866775;
        Tue, 13 Sep 2022 13:27:46 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u16-20020adfdb90000000b00225213fd4a9sm11400407wri.33.2022.09.13.13.27.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Sep 2022 13:27:46 -0700 (PDT)
Message-Id: <d2c95e34d3ab927e69aa176981719df4fbc563e7.1663100859.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1326.v6.git.1663100858.gitgitgadget@gmail.com>
References: <pull.1326.v5.git.1662840031.gitgitgadget@gmail.com>
        <pull.1326.v6.git.1663100858.gitgitgadget@gmail.com>
From:   "Eric DeCosta via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 13 Sep 2022 20:27:38 +0000
Subject: [PATCH v6 6/6] fsmonitor: add documentation for allowRemote and
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
