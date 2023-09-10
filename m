Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56C2EEE57DF
	for <git@archiver.kernel.org>; Sun, 10 Sep 2023 08:30:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346522AbjIJIaa (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 10 Sep 2023 04:30:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346524AbjIJIa3 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 Sep 2023 04:30:29 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D25C197
        for <git@vger.kernel.org>; Sun, 10 Sep 2023 01:30:23 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-99c3c8adb27so425006066b.1
        for <git@vger.kernel.org>; Sun, 10 Sep 2023 01:30:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694334621; x=1694939421; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=eJbOo+3mq2kyzgg9Pw2nPtQW1ziXZqvXpyDw+0/W9Ic=;
        b=YfrV1evldvCODj9Q8Ih9/H//4UlgpvpAQWae7/vRgxEMipRFWem93cNpc7hPcKZRj9
         QoCLok+sQVjWxb2ugsmLBTJmyq/xrRueNug+6gLijGbrPWYuVJZz4wglNK8iXcueMHvy
         KvvnwXCWo4Hmz4jSRelH+S46BxK6GMHGj340JMPSuJ9aaQmoz4Ye6FT+fD1JZCqpxNFY
         ede0d7w5sh9WUMEFwEW5PyBrl3ZMaCv9eGpm9c6RbhLl2aP63LZ4aDg5zjPnxf/bZGjB
         IIFIuAJaOZMufuZC+1ciB6zPSLJqK60LwX6xX9Y/JzMAIntfCYhJ9s3NlC+Zle1GtZPs
         Vk0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694334621; x=1694939421;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eJbOo+3mq2kyzgg9Pw2nPtQW1ziXZqvXpyDw+0/W9Ic=;
        b=TU0u087z04viqFbvSyd5E6XBNW5e/Hjebgyo9tZzQ9/UYZyp31VbYGcbrebINdL8lY
         Mtm0sWIDOvc8Dkiq9LWZdXE80s9DdtKRWyt461NUsfe+Ep2Zxhtv5NYoVd2lSt8SRuc+
         rlS5Z6NH6KjtwMsA4JUH6SMvfnGVX+yKucOn0H+Xsivu0PaT7ScA3I5occZSH6qVo6ym
         FiD7Mrb8KTRMkrlFbRBGALu56UITKp5lmRdk+PVlhobvZdzxX4latnzphvb66nOdGxKy
         FmG5wPmQxAVp9V34pvAAvAEfsIkWGsDmyOdZfZPsKj9vJT8/nQIxPvC77g/CTNMKQ8UP
         PEaw==
X-Gm-Message-State: AOJu0YzeTACnUvFCgwbI9/CrYOWwX8A32IeGjOMXimMFhH6rbS1C4DfY
        VwMJ34VZVg1Qy7L2ZAuiudb02CSwQdA=
X-Google-Smtp-Source: AGHT+IEwNQh8slj/9RRsuljUh+/LmGJxJBasHG0G9a1ym8BKnm0EewEoD5NDQg8CqC/E+LwgRNX1/g==
X-Received: by 2002:a17:906:8449:b0:99c:a23b:b4f4 with SMTP id e9-20020a170906844900b0099ca23bb4f4mr5364358ejy.2.1694334621227;
        Sun, 10 Sep 2023 01:30:21 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g14-20020a17090669ce00b0099b42c90830sm3508061ejs.36.2023.09.10.01.30.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Sep 2023 01:30:20 -0700 (PDT)
Message-ID: <pull.1586.git.1694334620260.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 10 Sep 2023 08:30:20 +0000
Subject: [PATCH] maintenance(systemd): support the Windows Subsystem for Linux
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

When running in the Windows Subsystem for Linux (WSL), it is usually
necessary to use the Git Credential Manager for authentication when
performing the background fetches.

This requires interoperability between the Windows Subsystem for Linux
and the Windows host to work, which uses so-called vsocks, i.e. sockets
intended for communcations between virtual machines and the host they
are running on.

However, when Git is configured to run background maintenance via
`systemd`, the address families available to those maintenance processes
are restricted, and did not include `AF_VSOCK`. This leads to problems
e.g. when a background fetch tries to access github.com:

	systemd[437]: Starting Optimize Git repositories data...
	git[747387]: WSL (747387) ERROR: UtilBindVsockAnyPort:285: socket failed 97
	git[747381]: fatal: could not read Username for 'https://github.com': No such device or address
	git[747381]: error: failed to prefetch remotes
	git[747381]: error: task 'prefetch' failed
	systemd[437]: git-maintenance@hourly.service: Main process exited, code=exited, status=1/FAILURE
	systemd[437]: git-maintenance@hourly.service: Failed with result 'exit-code'.
	systemd[437]: Failed to start Optimize Git repositories data.

Address this (pun intended) by adding the `AF_VSOCK` address family to
the allow list.

This fixes https://github.com/microsoft/git/issues/604.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
    maintenance(systemd): support the Windows Subsystem for Linux
    
    https://github.com/microsoft/git/issues/604 reports a bug where git
    maintenance start does not work in the Windows Subsystem for Linux
    (WSL), and this patch fixes it.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1586%2Fdscho%2Fscheduled-maintenance-in-wsl-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1586/dscho/scheduled-maintenance-in-wsl-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1586

 builtin/gc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index 5c4315f0d81..719cae9a88a 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -2397,7 +2397,7 @@ static int systemd_timer_write_unit_templates(const char *exec_path)
 	       "LockPersonality=yes\n"
 	       "MemoryDenyWriteExecute=yes\n"
 	       "NoNewPrivileges=yes\n"
-	       "RestrictAddressFamilies=AF_UNIX AF_INET AF_INET6\n"
+	       "RestrictAddressFamilies=AF_UNIX AF_INET AF_INET6 AF_VSOCK\n"
 	       "RestrictNamespaces=yes\n"
 	       "RestrictRealtime=yes\n"
 	       "RestrictSUIDSGID=yes\n"

base-commit: 43c8a30d150ecede9709c1f2527c8fba92c65f40
-- 
gitgitgadget
