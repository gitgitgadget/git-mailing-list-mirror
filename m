Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29EA2C433EF
	for <git@archiver.kernel.org>; Thu,  7 Oct 2021 13:53:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 11AF5611EE
	for <git@archiver.kernel.org>; Thu,  7 Oct 2021 13:53:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241877AbhJGNzE (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Oct 2021 09:55:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241758AbhJGNyv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Oct 2021 09:54:51 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B394C061755
        for <git@vger.kernel.org>; Thu,  7 Oct 2021 06:52:58 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id r18so19381290wrg.6
        for <git@vger.kernel.org>; Thu, 07 Oct 2021 06:52:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=OPR/cD4g5iSikjECMnICO/QPaQt/LlN2JVqikY/G/54=;
        b=aMbhNmi5D4RKuQ/yzBmoxjqNE1QxYwkHmJDP/6XsBfhlIfGvHCvttsXPEuK1ISTjP8
         pNYbH6XM/Ixbw5UB/6hOHXr5hI3WBuufVLL7YtDG/lqNdGItXckrgsqnvqnSyRLg4uLA
         o58NIklE1V3gZUR7x8Iom0TW1GtZf319ERUHnaovhLj2wCf6K5pVTbqSp+elK2TQVwLB
         RUdPIBFpdWAZd1LIMpDP3N2x2TR/KLS9iBPwvMeR60o1WDUy/wHrFiiPWUX4iChoUNqz
         lDv6f+OfXi8iYD6by7yZRJTUeYGbQqN3GhdUJ0M8BlmFpYJPlIh0btIU4NSNOhIq2DJd
         s0Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=OPR/cD4g5iSikjECMnICO/QPaQt/LlN2JVqikY/G/54=;
        b=So39MAoB6/roHaoJjcRSeysc8hkkPGQ/npt1wl89D2I1EAEQOWOy/KZHp4JS5q3LEq
         XqMHdDGZQugvOjiAzD2Ly0GMtSHwBa9KRcHQudxlFsI7UfuyFO1Hz6B7kvPcX2zRJMn0
         hy8JR/Rr1kR5gUq46ZQdZr3mfPDVtp27HcfRGgsnFm8NIkqMbv5022M07NdEKTfM7q44
         RAuFd6Z2oinCCuG0tyiApxGimhqgAtSuefPZaVMK/8EPe89q1DHC3J2Z1cioSvWPzpBr
         qArVrG2CJP4TE9MiGYl9lAvAHf6PJV1j7WRbNcIFWJHoPDjMGFWM2bFyvzgLWrobAvUH
         1pSw==
X-Gm-Message-State: AOAM5306sHzMq8hkvS4A8OdmvqaOg9WcyJ051AWSoontygwxkCHCoFV/
        TqmKYGTkrVrdl9RQTrOLlKmKEXAeK4U=
X-Google-Smtp-Source: ABdhPJxNEVpKCnj4sNxCgNTYjTsJFwCzJPNgw13rv04xLMBWlMWWKwF2jYGm9DaZLxIv7k/3TzMi0g==
X-Received: by 2002:a05:600c:350f:: with SMTP id h15mr16699711wmq.144.1633614776752;
        Thu, 07 Oct 2021 06:52:56 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 61sm24628890wrl.94.2021.10.07.06.52.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Oct 2021 06:52:56 -0700 (PDT)
Message-Id: <8608c8718d8f839a1ae3e6d4f8f8cc2247c26111.1633614772.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1041.v2.git.1633614772.gitgitgadget@gmail.com>
References: <pull.1041.git.1631822063.gitgitgadget@gmail.com>
        <pull.1041.v2.git.1633614772.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 07 Oct 2021 13:52:51 +0000
Subject: [PATCH v2 4/5] fsmonitor: use IPC to query the builtin FSMonitor
 daemon
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
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

