Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 258FDC433EF
	for <git@archiver.kernel.org>; Fri, 11 Mar 2022 22:44:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbiCKWpP (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Mar 2022 17:45:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbiCKWpE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Mar 2022 17:45:04 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E24CF2A2B8F
        for <git@vger.kernel.org>; Fri, 11 Mar 2022 14:20:39 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id e24so14919154wrc.10
        for <git@vger.kernel.org>; Fri, 11 Mar 2022 14:20:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=3c7ydlmQ53sqRJH1OosOcQSL0/HsDNFwmPeVLl3iFxs=;
        b=ZTkeitpcxMaWjLxNYCKTdd3ExzvKzmI0PkmYnbIq1O7NDUkYBGHv6SArUrxBd+7z0B
         DOisZGu1I1e3jFAvYwf/tVOTyx8ClFvs6j5gddIKkNVW53c5CNkEwXlOT17PijK1bzbN
         nnQaPw5riYj/2PvcnpHpl7li3NOXctb30vMUTLz3uCSH5ftgMQCuoMqgeDhG6t8YdqhS
         UhynQJAlM1cfRms7kANA5cRcLCdQKP3EpJZYHYVpUa5026Zwb7SdAZkaJMJ07EN/b1jv
         MvXLrNZZexOpyPxVtzC2//Nb5sZRreY/ASHpevjLZG8vzCh2KYILYhAoW6fNnP2WhU3C
         MQlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=3c7ydlmQ53sqRJH1OosOcQSL0/HsDNFwmPeVLl3iFxs=;
        b=iOXbqjH4xCjI4zZzc2hcfRIg0FxPwRdZCBDgyUkaVzlmtCCgRqxCZrKAcr2ba9v1ph
         bkJ00B6yY/Y4gJhEIFsA08NLOVvT7QufAC1PeTJPxgDcW2eLDeNMOuzz452pEZlwT7Do
         aYAe52o7cXQnSMkmJfDOyCxoPro8SXv7PgC8NW5wXZZf5BhnTAJCU4ewsr+q/jWhESSZ
         7ppTKWHEDoqk/w+Toh9+WgZq7XuRCJtZa2qirMudv2alOA/msN5CdjLEPxU2UuLxvHm8
         C9lgPyfiL0NrJLMVfBRqtcV++PgwGyltffPT5FOMyJacTJVc4PpISJEIwIMi37ba3Fhw
         IJOQ==
X-Gm-Message-State: AOAM532TmUbcAxCdl3MlBUs+7Bqu+ou7moc6FJScqkFbT1DGUbMfKKNN
        b+pHw/MNFJl9pOzxphzxT6aG2W+ihso=
X-Google-Smtp-Source: ABdhPJxT/JV3XSxYqkpoDqa8BVoSCy4C2OR5knltDARJDRcyilQZae3c3hwxtaON1AfGTgx0ayB7kQ==
X-Received: by 2002:a5d:69d0:0:b0:1f1:fd05:e863 with SMTP id s16-20020a5d69d0000000b001f1fd05e863mr8769989wrw.223.1647033305871;
        Fri, 11 Mar 2022 13:15:05 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p26-20020a7bcc9a000000b00389f80668cesm962222wma.28.2022.03.11.13.15.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Mar 2022 13:15:05 -0800 (PST)
Message-Id: <b120972a441d3081519af0e31bb0c639df148287.1647033303.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1174.git.1647033303.gitgitgadget@gmail.com>
References: <pull.1174.git.1647033303.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 11 Mar 2022 21:14:49 +0000
Subject: [PATCH 02/16] update-index: convert advise() messages back to
 warning()
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

fixup! update-index: convert fsmonitor warnings to advise

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 builtin/update-index.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/builtin/update-index.c b/builtin/update-index.c
index d335f1ac72a..75d646377cc 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -1238,18 +1238,18 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 	if (fsmonitor > 0) {
 		enum fsmonitor_mode fsm_mode = fsm_settings__get_mode(r);
 		if (fsm_mode == FSMONITOR_MODE_DISABLED) {
-			advise(_("core.fsmonitor is unset; "
-				 "set it if you really want to "
-				 "enable fsmonitor"));
+			warning(_("core.fsmonitor is unset; "
+				  "set it if you really want to "
+				  "enable fsmonitor"));
 		}
 		add_fsmonitor(&the_index);
 		report(_("fsmonitor enabled"));
 	} else if (!fsmonitor) {
 		enum fsmonitor_mode fsm_mode = fsm_settings__get_mode(r);
 		if (fsm_mode > FSMONITOR_MODE_DISABLED)
-			advise(_("core.fsmonitor is set; "
-				 "remove it if you really want to "
-				 "disable fsmonitor"));
+			warning(_("core.fsmonitor is set; "
+				  "remove it if you really want to "
+				  "disable fsmonitor"));
 		remove_fsmonitor(&the_index);
 		report(_("fsmonitor disabled"));
 	}
-- 
gitgitgadget

