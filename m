Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B163C433F5
	for <git@archiver.kernel.org>; Fri, 11 Mar 2022 22:47:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229842AbiCKWsr (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Mar 2022 17:48:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229758AbiCKWsL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Mar 2022 17:48:11 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09C6C283B60
        for <git@vger.kernel.org>; Fri, 11 Mar 2022 14:23:02 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id l1-20020a05600c4f0100b00389645443d2so6160971wmq.2
        for <git@vger.kernel.org>; Fri, 11 Mar 2022 14:23:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=9g2wyL2OIZo9JPKszsWzDlTklgXo2s1AMtEwqOGQR8I=;
        b=nOqUJH51cYaZumrB3/knd9zXUoe14Z05SWhP9yOjNky7uaeNHKtdT2yZEqhFKwgLAr
         WwH/afZ72FrmSn+Aw9ZvSAIOvcov/SGZyLTdksFf3aVK2J76t4lDpP86Z65IqjXHWLIk
         wg4xWh3qDK+gBhKjokFod7SAu2uHbtfwDu7ya1QLNE3cqvzXGniuMFEdyUzADHj0QXRq
         HtYu+MvT/vLznZPG+vA1Pf3dqifEba1EAMq5xsKRBCt1D6D2Fz7coHF0YQFsmysGdbW2
         eu3a/gfv2aBtXV/EHlTHYi+3IdgZBL23Ac/o7bSfmh6vHFuZrDkK1jGzwDxXDNxKZ9kz
         REBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=9g2wyL2OIZo9JPKszsWzDlTklgXo2s1AMtEwqOGQR8I=;
        b=MyWJEiRyQ398k2BmslppLXiQNMy2RcWMUxKZzT2wxF2aAf0UXu134JpkqI0VtGak03
         evMQkIj50UwiaxZHtJ1V+cYW/H7ITHevfJSkOSAkotTilfctegcazamEbUM6f4/WMbg7
         UJMe1Afb9CB7RL/bdMOlFT5D8/rtuvFTJyEeMqYsKsbL//nNLAe7SA+wIOsYLkBbALOz
         VN4z34qwi/Ap45CAkOaQd+vxoOOF9TabsiSlrI1AmPQ9io/XBh0A9jMP247mXnsqsF00
         Roqry4ewcIhLuxu5cHkLR643DtkkMxjeAnYPAAQtIegL5BtNywys8B8WfbD3irN31RG5
         3mPw==
X-Gm-Message-State: AOAM531g/H+EYoeMEGoc5Gud7wlU9KoTyZoP1mec7FJgtQhFKDnAzy1e
        negSkrouCnB4hT07huHexOJEWaswWws=
X-Google-Smtp-Source: ABdhPJx6ExOwdnuYYrDz0fIprCHgirD4ycjahqUCMySRtH9+65vtPJEtodSu8m3cnVHp769L4KFDQw==
X-Received: by 2002:a1c:2bc3:0:b0:381:3dd5:5707 with SMTP id r186-20020a1c2bc3000000b003813dd55707mr16872718wmr.31.1647033316422;
        Fri, 11 Mar 2022 13:15:16 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g5-20020a5d64e5000000b00203914f5313sm3917129wri.114.2022.03.11.13.15.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Mar 2022 13:15:16 -0800 (PST)
Message-Id: <118ba1b5d04283da93b46f24201827c4a226d3fa.1647033303.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1174.git.1647033303.gitgitgadget@gmail.com>
References: <pull.1174.git.1647033303.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 11 Mar 2022 21:15:02 +0000
Subject: [PATCH 15/16] fsmonitor--daemon: add _() to calls to error()
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

fixup! fsmonitor--daemon: implement 'start' command

Fixup translation on die().

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 builtin/fsmonitor--daemon.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/builtin/fsmonitor--daemon.c b/builtin/fsmonitor--daemon.c
index b3687a200ef..a30ecf6cfac 100644
--- a/builtin/fsmonitor--daemon.c
+++ b/builtin/fsmonitor--daemon.c
@@ -1381,7 +1381,7 @@ static int try_to_start_background_daemon(void)
 	 * immediately exited).
 	 */
 	if (fsmonitor_ipc__get_state() == IPC_STATE__LISTENING)
-		die("fsmonitor--daemon is already running '%s'",
+		die(_("fsmonitor--daemon is already running '%s'"),
 		    the_repository->worktree);
 
 	if (fsmonitor__announce_startup) {
@@ -1411,13 +1411,13 @@ static int try_to_start_background_daemon(void)
 	default:
 	case SBGR_ERROR:
 	case SBGR_CB_ERROR:
-		return error("daemon failed to start");
+		return error(_("daemon failed to start"));
 
 	case SBGR_TIMEOUT:
-		return error("daemon not online yet");
+		return error(_("daemon not online yet"));
 
 	case SBGR_DIED:
-		return error("daemon terminated");
+		return error(_("daemon terminated"));
 	}
 }
 
-- 
gitgitgadget

