Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF7D9C433F5
	for <git@archiver.kernel.org>; Fri, 11 Mar 2022 22:46:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229776AbiCKWrg (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Mar 2022 17:47:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbiCKWrY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Mar 2022 17:47:24 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1388293F29
        for <git@vger.kernel.org>; Fri, 11 Mar 2022 14:22:18 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id 19so5898237wmy.3
        for <git@vger.kernel.org>; Fri, 11 Mar 2022 14:22:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=E24EvvwnkSyOCEJmsHGJhLe1DkHNnlgm4bHeLK+leKE=;
        b=SY7KGzrTOC510bZZ1bb8PYBgkjN/nj4uYeTo3zxjsiPnjRdmfp6uqM9hfL8pjKx88p
         LZu+maaaHVRdXfqet5a5g8hlEsHER6D4Y76EsMKBsg3ByO5WdW01FHyXymckjen8g/fg
         xVnWjguLljgS6gT46xfNI5wXRGbDSAeNNpOKXNSQOazIj606a+piAZfqDK4cmjktozSz
         DDq56zr5OhUEjDDIBvigBHrnIVgzt2VZAhkYiWIx+Hs+tcDhje58rj94JIatg8tuIF9b
         IYKjTMjFLaLxV3efGy4hqXxTOT0cM8+0OKPnjXYG7M/Tc22ZryqAaWmkrrONgSE7w+F9
         1kxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=E24EvvwnkSyOCEJmsHGJhLe1DkHNnlgm4bHeLK+leKE=;
        b=uLiWruPtoWY0J4UeZEzeYHdSpjaazNN+lj1qvrGN1C87xMwvLzwtTVtny35aiBXMzV
         4u6UmgJ92UvxhzgXdK+HjBOCRrf9LW4Vhiy0ZvGmjAjTVepsNREWpwsFnTxFLgUKc6y6
         A8Yn4YC9J94z/h0tZsCPmwSAdOsYwta6dw5J0sOCZ9RUpiqRPEhrIOCQBLFHTj3UVRYS
         iNC382PTYcQNqDzPAoXwVqp0X6V9rDSc12WCobwrXoUHJ50wPUWOw6g+pyCmbtQ/2sIM
         zFd4FjxLphjz/lAyLyV14UoUIZCBqUi8xmvz7P/zeOzJa+RGqGTfiUqxQfUxa8HINuht
         Ofxg==
X-Gm-Message-State: AOAM533kAHzBKDl74X9if08Xo4Tibt+yPUIgV3wwFEIn+9kiPVQH4JJA
        rOtnXo6+LhaTLFElxicPUzGNyewY1V4=
X-Google-Smtp-Source: ABdhPJyipR8Zx+v0NMQZ8WMl2Zbg7MhwWqHznF3zjZI61J/QHiQraNyHUryJGnMktoEcESTsO5pUNA==
X-Received: by 2002:a7b:cd96:0:b0:381:201e:ba06 with SMTP id y22-20020a7bcd96000000b00381201eba06mr17180005wmj.78.1647033313230;
        Fri, 11 Mar 2022 13:15:13 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m9-20020a05600c4f4900b00389e8184edcsm4324707wmq.35.2022.03.11.13.15.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Mar 2022 13:15:12 -0800 (PST)
Message-Id: <d9592c7a0b798d0b5ab60580afbe36cd48d12616.1647033303.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1174.git.1647033303.gitgitgadget@gmail.com>
References: <pull.1174.git.1647033303.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 11 Mar 2022 21:14:58 +0000
Subject: [PATCH 11/16] fsmonitor-ipc: add _() to calls to die()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff Hostetler <jeffhost@microsoft.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

fixup! fsmonitor-ipc: create client routines for git-fsmonitor--daemon

Fix translation markings.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 fsmonitor-ipc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fsmonitor-ipc.c b/fsmonitor-ipc.c
index 91a535f1219..789e7397baa 100644
--- a/fsmonitor-ipc.c
+++ b/fsmonitor-ipc.c
@@ -152,7 +152,7 @@ int fsmonitor_ipc__send_command(const char *command,
 	state = ipc_client_try_connect(fsmonitor_ipc__get_path(), &options,
 				       &connection);
 	if (state != IPC_STATE__LISTENING) {
-		die("fsmonitor--daemon is not running");
+		die(_("fsmonitor--daemon is not running"));
 		return -1;
 	}
 
@@ -161,7 +161,7 @@ int fsmonitor_ipc__send_command(const char *command,
 	ipc_client_close_connection(connection);
 
 	if (ret == -1) {
-		die("could not send '%s' command to fsmonitor--daemon", c);
+		die(_("could not send '%s' command to fsmonitor--daemon"), c);
 		return -1;
 	}
 
-- 
gitgitgadget

