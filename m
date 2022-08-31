Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63913ECAAD3
	for <git@archiver.kernel.org>; Wed, 31 Aug 2022 16:09:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231727AbiHaQJd (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 31 Aug 2022 12:09:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231454AbiHaQJW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Aug 2022 12:09:22 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD426C3F69
        for <git@vger.kernel.org>; Wed, 31 Aug 2022 09:09:15 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id k6-20020a05600c1c8600b003a54ecc62f6so8279881wms.5
        for <git@vger.kernel.org>; Wed, 31 Aug 2022 09:09:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc;
        bh=Zg7O1XjMqNJ0aoj0nTaeReoT+ibJ7sZub876zOA0gsY=;
        b=f75KbIW3tBpD4pLYwNbFjabreI1uUCGTN9jZzxHbxB7V9yj47I6pixqpVdibzdkpdZ
         4ySKboIKJxP2Abk/LTe5qma5aERlVidnBQrAMEU7P+4ydfmCmURKmKRQ/T6B3mdU5Yom
         tnbV279zD/hvKeJ4pxGu68sVV7nhh9b/z3kuxBj8A/oxm0ZvgOStQnCEiqr+tPAGtvrH
         8PwfOJueGiMh+UGv/Yz47OeHt+VrcsmSGYWMIRJsKch/uW9aRY3yUguZHwwPxsU00Rpn
         ZZxZU+4GGD/fH2JK8uewIjspZsB1MEA7A72j62bNQ13dXTZypbXTI6y1HHYIrT51lS08
         VBjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc;
        bh=Zg7O1XjMqNJ0aoj0nTaeReoT+ibJ7sZub876zOA0gsY=;
        b=CoAg436aYseoHt+NBbwT3sWeQov7bwXplJTTfVd7bbn6Z993aGW8LuDYkn03Eu2lmI
         Wi0UCvo4OhShmK9LKxJREqNlTHUhB+eeK7xzWbkLLa6sH6tiIvpftK2vu5tqWKSDCuEo
         OBaSIoxAgstk6WOZz1R5jIuHl+itxlguEwVU6cFiK5+3sh7ZSBrMSdcDj2vOHsFATJSO
         jgzwbs3kQTr7+C1AQd1Jven9RvAk58QAMV1s/US0vjeuqSa5GpoTOuM8fPqO1Zjn8hDP
         VwhgHY4++rsyV7ZpEs8GDxr+VeL8GuxHEN6jb5Kmc3uMqZaB2it9a64OZjlEbrJi/Igv
         0niQ==
X-Gm-Message-State: ACgBeo24UfQ71pKLTfB3D0YyEUqqH975hHBUgEyj7iK3G1rVgP7bp6pJ
        FeGiwwak0XYoLx3sHKtUqTd9dqFmI9A=
X-Google-Smtp-Source: AA6agR6o+aEycLIssOMvcFHUA083j7opI9lp7hVe+XP0NdL834yELwlxEq32vNbFek4fzjfc3osNTw==
X-Received: by 2002:a05:600c:418a:b0:3a5:e724:21d4 with SMTP id p10-20020a05600c418a00b003a5e72421d4mr2547777wmh.168.1661962154175;
        Wed, 31 Aug 2022 09:09:14 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c16-20020adffb50000000b00226d473ebd6sm10952364wrs.86.2022.08.31.09.09.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 09:09:13 -0700 (PDT)
Message-Id: <56cabf3be3b9e228bc948da372db4c9d11fd3926.1661962145.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1326.v4.git.1661962145.gitgitgadget@gmail.com>
References: <pull.1326.v3.git.1661280941.gitgitgadget@gmail.com>
        <pull.1326.v4.git.1661962145.gitgitgadget@gmail.com>
From:   "Eric DeCosta via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 31 Aug 2022 16:09:04 +0000
Subject: [PATCH v4 4/4] fsmonitor: normalize FSEvents event paths to the real
 path
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

Consider the following network working directory that is mounted under
/System/Volumes/Data:

/network/working/directory

The git working directory path is:

/System/Volumes/Data/network/working/directory

The paths reported by FSEvents always start with /network. fsmonitor
expects paths to be under the working directory; therefore it
fails to match /network/... and ignores the change.

Change things such that if fsmonitor.allowRemote is true that the
paths reported via FSEevents are normalized to the real path.

Signed-off-by: Eric DeCosta <edecosta@mathworks.com>
---
 compat/fsmonitor/fsm-listen-darwin.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/compat/fsmonitor/fsm-listen-darwin.c b/compat/fsmonitor/fsm-listen-darwin.c
index 8e208e8289e..2ed828649ff 100644
--- a/compat/fsmonitor/fsm-listen-darwin.c
+++ b/compat/fsmonitor/fsm-listen-darwin.c
@@ -26,6 +26,7 @@
 #include "fsmonitor.h"
 #include "fsm-listen.h"
 #include "fsmonitor--daemon.h"
+#include "fsmonitor-settings.h"
 
 struct fsm_listen_data
 {
@@ -183,7 +184,6 @@ static void my_add_path(struct fsmonitor_batch *batch, const char *path)
 	free(composed);
 }
 
-
 static void fsevent_callback(ConstFSEventStreamRef streamRef,
 			     void *ctx,
 			     size_t num_of_events,
@@ -209,7 +209,12 @@ static void fsevent_callback(ConstFSEventStreamRef streamRef,
 		/*
 		 * On Mac, we receive an array of absolute paths.
 		 */
-		path_k = paths[k];
+		if (fsm_settings__get_allow_remote(the_repository) > 0) {
+			strbuf_reset(&tmp);
+			strbuf_realpath_forgiving(&tmp, paths[k], 0);
+			path_k = tmp.buf;
+		} else
+			path_k = paths[k];
 
 		/*
 		 * If you want to debug FSEvents, log them to GIT_TRACE_FSMONITOR.
@@ -237,6 +242,7 @@ static void fsevent_callback(ConstFSEventStreamRef streamRef,
 
 			fsmonitor_force_resync(state);
 			fsmonitor_batch__free_list(batch);
+			batch = NULL;
 			string_list_clear(&cookie_list, 0);
 
 			/*
@@ -313,7 +319,6 @@ static void fsevent_callback(ConstFSEventStreamRef streamRef,
 
 		case IS_WORKDIR_PATH:
 			/* try to queue normal pathnames */
-
 			if (trace_pass_fl(&trace_fsmonitor))
 				log_flags_set(path_k, event_flags[k]);
 
-- 
gitgitgadget
