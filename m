Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F63FC433EF
	for <git@archiver.kernel.org>; Thu, 21 Oct 2021 14:25:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA6C46121F
	for <git@archiver.kernel.org>; Thu, 21 Oct 2021 14:25:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231520AbhJUO1q (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Oct 2021 10:27:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230471AbhJUO1b (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Oct 2021 10:27:31 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42239C061220
        for <git@vger.kernel.org>; Thu, 21 Oct 2021 07:25:15 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id r10so1138743wra.12
        for <git@vger.kernel.org>; Thu, 21 Oct 2021 07:25:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=OPR/cD4g5iSikjECMnICO/QPaQt/LlN2JVqikY/G/54=;
        b=N9scvFgH5p2rFJbW8mj+FK35EiKStRJK2YLcM7GjM0sDUFpMP9FtgxPAtZL0v9Emw4
         0Yel/7U5rjdNH2KFAQPYgjNLAMgFWcuADtgixc13LLY2armnqp3i74er0O3B1zC9blkB
         sRgvwSupvuibfJGGh34KPP7DfWMzwK3lXiKjeFDceby5NtltuOYUuvAPokMd0Yduz7Cd
         St7ww3gR8WDNtMqiFJuhevrEm3dvVviZfvioFEtadGuc+FUvr4nKSpT0woE6HZMNQqvw
         q38mOm9rDDY/Gmt0xcLQaVEO2tZsv+IIgwtFdgw294xwGPiT0xhnlkDXiEddpxuzsGip
         HfsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=OPR/cD4g5iSikjECMnICO/QPaQt/LlN2JVqikY/G/54=;
        b=x3cCEDkGbEptKo9A3LC5GvtySNZ/5L1lpchxpDgzkhM+AT3DTk8P3WJAjsreOx+PVe
         vFxIai6HPd8G8DD7G2XomfV/mIuHJTCOZG3pi89ZPMMzR2cT82K9ldfRux4RLzVTI3Ee
         URBJ9vrEE74j4/pnY5D+P907gvPuPH+eud0IdrCGf5Js7Vvq43jNODuvYF/XmuSu0saw
         /zXVbv2G7V8tqveiFFzM+PzfnjBZbFeIUXOQQ8nbLvExEHgSQVFmj1UIO2FvBDrLKJwg
         7fDhXrl/spAsAcf2ozdynMSlU0x0gMAXfehRKvisovXYqOkWZCk7mDyoXwyoAp0+4sji
         pWfQ==
X-Gm-Message-State: AOAM531R2CHGpnFzx8Mud0H0MGVd0VwXl24LQoKwl7bOWBvAIXW/YVpe
        NHVybm/3Zhg5WfoMeG/nCDPKgs+k0eI=
X-Google-Smtp-Source: ABdhPJwexu7FsT1g50q3zXm1xnprB1YGovb5NaUGQBjZWkzQzPgYJTCOmQ+fi7Y42KtEqnBQ2TYZhw==
X-Received: by 2002:a5d:6e8d:: with SMTP id k13mr7647142wrz.295.1634826313847;
        Thu, 21 Oct 2021 07:25:13 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r4sm6639049wrz.58.2021.10.21.07.25.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 07:25:13 -0700 (PDT)
Message-Id: <de82c72618265c644c6ef65fedbf95e056b420a7.1634826309.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1041.v4.git.1634826309.gitgitgadget@gmail.com>
References: <pull.1041.v3.git.1634157107.gitgitgadget@gmail.com>
        <pull.1041.v4.git.1634826309.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 21 Oct 2021 14:24:44 +0000
Subject: [PATCH v4 04/29] fsmonitor: use IPC to query the builtin FSMonitor
 daemon
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff Hostetler <git@jeffhostetler.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Use simple IPC to directly communicate with the new builtin file
system monitor daemon when `core.useBuiltinFSMonitor` is set.

The `core.fsmonitor` setting has already been defined as a HOOK
pathname.  Historically, this has been set to a HOOK script that will
talk with Watchman.  For compatibility reasons, we do not want to
overload that definition (and cause problems if users have multiple
versions of Git installed).

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 fsmonitor.c | 34 ++++++++++++++++++++++++++++++++--
 1 file changed, 32 insertions(+), 2 deletions(-)

diff --git a/fsmonitor.c b/fsmonitor.c
index 63174630c0e..695fb0ce4e7 100644
--- a/fsmonitor.c
+++ b/fsmonitor.c
@@ -254,8 +254,37 @@ void refresh_fsmonitor(struct index_state *istate)
 	trace_printf_key(&trace_fsmonitor, "refresh fsmonitor");
 
 	if (fsm_mode == FSMONITOR_MODE_IPC) {
-		/* TODO */
-		return;
+		query_success = !fsmonitor_ipc__send_query(
+			istate->fsmonitor_last_update ?
+			istate->fsmonitor_last_update : "builtin:fake",
+			&query_result);
+		if (query_success) {
+			/*
+			 * The response contains a series of nul terminated
+			 * strings.  The first is the new token.
+			 *
+			 * Use `char *buf` as an interlude to trick the CI
+			 * static analysis to let us use `strbuf_addstr()`
+			 * here (and only copy the token) rather than
+			 * `strbuf_addbuf()`.
+			 */
+			buf = query_result.buf;
+			strbuf_addstr(&last_update_token, buf);
+			bol = last_update_token.len + 1;
+		} else {
+			/*
+			 * The builtin daemon is not available on this
+			 * platform -OR- we failed to get a response.
+			 *
+			 * Generate a fake token (rather than a V1
+			 * timestamp) for the index extension.  (If
+			 * they switch back to the hook API, we don't
+			 * want ambiguous state.)
+			 */
+			strbuf_addstr(&last_update_token, "builtin:fake");
+		}
+
+		goto apply_results;
 	}
 
 	assert(fsm_mode == FSMONITOR_MODE_HOOK);
@@ -321,6 +350,7 @@ void refresh_fsmonitor(struct index_state *istate)
 				 query_success ? "success" : "failure");
 	}
 
+apply_results:
 	/*
 	 * The response from FSMonitor (excluding the header token) is
 	 * either:
-- 
gitgitgadget

