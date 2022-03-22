Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AB98C433EF
	for <git@archiver.kernel.org>; Tue, 22 Mar 2022 18:00:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237129AbiCVSBs (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Mar 2022 14:01:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234014AbiCVSBr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Mar 2022 14:01:47 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CAA0654A1
        for <git@vger.kernel.org>; Tue, 22 Mar 2022 11:00:19 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id i186so2436355wma.3
        for <git@vger.kernel.org>; Tue, 22 Mar 2022 11:00:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=GykMGxH+vcSxKSOuzIgVgE2plWrsxxaHhbdq7JLSrgU=;
        b=iCRwUFx0mq/vEAHAMKv55NVomAXIxgf8/GMuNVUkZR55FQoqCbtKbkwnVb3XDpgJH2
         IsdyN9Cu3pRfqHo2XvO5Du8eJH4/YuHvbhnTEu0CY0Z93rFTzSaGRc2o2UgXUTSKb4V+
         FRzcakuE4bGMGcRJWIAJhKX4nWaSkEzO2oWqgaw/S4c7Nkm9eewZoc0Gas8ti4RQRtbv
         gTUuhzRE3YGM2kIEGHSv/HRU+XX0msxezIF9q4cWSvudUFVR3HfNaUrUnkiMY6wsnjF5
         FTOmRZfDYQeJaJfZBumwii3yZH/rEVSkZjpu1mXs+diTpn8Of/56hO0fptZO42M/elaj
         TNLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=GykMGxH+vcSxKSOuzIgVgE2plWrsxxaHhbdq7JLSrgU=;
        b=GpHJBH5BN96xbhna+Bk4tvE6Fl3K2ZKz2/tL+fO9ybC5lJQ7eriSzAJsbbDAewdMiM
         yBh05QCO2YyXOCQI75wlXRMUYHuzPgfvIQv9GN6ISFsrCNkSIY+54qtjJjrKHCWjgMRX
         dmwYRmEB/6f8+71Sq5sOV7D2JIsbAX39tyb/4ZlXm0U6LlF7qJA0VmI/pW0TiTTNquDy
         x2WbMhHp8ETx3ES6umyVVk6OKR7+C1AmAb3Yk4cImfcfTWJ789A6o2pHm9bv/MwIxOh2
         PdAJQLItOSfRsMimpn7mHun47JW83KPEhwc/l8C0DJDHcVIU5bP7G2wP3oLTozM5ATjq
         vI5Q==
X-Gm-Message-State: AOAM532Pv8SRGFuFG1YBdCmIfOk6BjggIafl8XuZ+W3aYzqA03LsxG5k
        IZjSPi1hB0IyorFicqOF3fhYWnKTLxs=
X-Google-Smtp-Source: ABdhPJwddy//LP/zRh+wseAwgLe7RipRNa1XOPnk+vfZlTEZGs+EthN771m0oiAXEp8fYOkSdrna0Q==
X-Received: by 2002:a05:600c:34c5:b0:38c:30e3:1e6c with SMTP id d5-20020a05600c34c500b0038c30e31e6cmr5128766wmq.144.1647972017634;
        Tue, 22 Mar 2022 11:00:17 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o16-20020a05600c4fd000b0038cbd198602sm1249261wmq.34.2022.03.22.11.00.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Mar 2022 11:00:15 -0700 (PDT)
Message-Id: <e98373f997f5994a08423b3f42b6ddadb3a2a511.1647972010.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1041.v7.git.1647972010.gitgitgadget@gmail.com>
References: <pull.1041.v6.git.1646160212.gitgitgadget@gmail.com>
        <pull.1041.v7.git.1647972010.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 22 Mar 2022 17:59:42 +0000
Subject: [PATCH v7 01/29] fsmonitor: enhance existing comments, clarify
 trivial response handling
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Jeff Hostetler <git@jeffhostetler.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Tao Klerks <tao@klerks.biz>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 fsmonitor.c | 64 ++++++++++++++++++++++++++++++++++-------------------
 1 file changed, 41 insertions(+), 23 deletions(-)

diff --git a/fsmonitor.c b/fsmonitor.c
index ab9bfc60b34..448d0ee33f5 100644
--- a/fsmonitor.c
+++ b/fsmonitor.c
@@ -168,29 +168,15 @@ static int query_fsmonitor(int version, const char *last_update, struct strbuf *
 
 	if (result)
 		trace2_data_intmax("fsm_hook", NULL, "query/failed", result);
-	else {
+	else
 		trace2_data_intmax("fsm_hook", NULL, "query/response-length",
 				   query_result->len);
 
-		if (fsmonitor_is_trivial_response(query_result))
-			trace2_data_intmax("fsm_hook", NULL,
-					   "query/trivial-response", 1);
-	}
-
 	trace2_region_leave("fsm_hook", "query", NULL);
 
 	return result;
 }
 
-int fsmonitor_is_trivial_response(const struct strbuf *query_result)
-{
-	static char trivial_response[3] = { '\0', '/', '\0' };
-
-	return query_result->len >= 3 &&
-		!memcmp(trivial_response,
-			&query_result->buf[query_result->len - 3], 3);
-}
-
 static void fsmonitor_refresh_callback(struct index_state *istate, char *name)
 {
 	int i, len = strlen(name);
@@ -238,6 +224,7 @@ void refresh_fsmonitor(struct index_state *istate)
 	struct strbuf last_update_token = STRBUF_INIT;
 	char *buf;
 	unsigned int i;
+	int is_trivial = 0;
 
 	if (!core_fsmonitor || istate->fsmonitor_has_run_once)
 		return;
@@ -283,6 +270,7 @@ void refresh_fsmonitor(struct index_state *istate)
 					query_success = 0;
 				} else {
 					bol = last_update_token.len + 1;
+					is_trivial = query_result.buf[bol] == '/';
 				}
 			} else if (hook_version < 0) {
 				hook_version = HOOK_INTERFACE_VERSION1;
@@ -294,16 +282,38 @@ void refresh_fsmonitor(struct index_state *istate)
 		if (hook_version == HOOK_INTERFACE_VERSION1) {
 			query_success = !query_fsmonitor(HOOK_INTERFACE_VERSION1,
 				istate->fsmonitor_last_update, &query_result);
+			if (query_success)
+				is_trivial = query_result.buf[0] == '/';
 		}
 
+		if (is_trivial)
+			trace2_data_intmax("fsm_hook", NULL,
+					   "query/trivial-response", 1);
+
 		trace_performance_since(last_update, "fsmonitor process '%s'", core_fsmonitor);
 		trace_printf_key(&trace_fsmonitor, "fsmonitor process '%s' returned %s",
 			core_fsmonitor, query_success ? "success" : "failure");
 	}
 
-	/* a fsmonitor process can return '/' to indicate all entries are invalid */
-	if (query_success && query_result.buf[bol] != '/') {
-		/* Mark all entries returned by the monitor as dirty */
+	/*
+	 * The response from FSMonitor (excluding the header token) is
+	 * either:
+	 *
+	 * [a] a (possibly empty) list of NUL delimited relative
+	 *     pathnames of changed paths.  This list can contain
+	 *     files and directories.  Directories have a trailing
+	 *     slash.
+	 *
+	 * [b] a single '/' to indicate the provider had no
+	 *     information and that we should consider everything
+	 *     invalid.  We call this a trivial response.
+	 */
+	if (query_success && !is_trivial) {
+		/*
+		 * Mark all pathnames returned by the monitor as dirty.
+		 *
+		 * This updates both the cache-entries and the untracked-cache.
+		 */
 		buf = query_result.buf;
 		for (i = bol; i < query_result.len; i++) {
 			if (buf[i] != '\0')
@@ -318,11 +328,16 @@ void refresh_fsmonitor(struct index_state *istate)
 		if (istate->untracked)
 			istate->untracked->use_fsmonitor = 1;
 	} else {
-
-		/* We only want to run the post index changed hook if we've actually changed entries, so keep track
-		 * if we actually changed entries or not */
+		/*
+		 * We failed to get a response or received a trivial response,
+		 * so invalidate everything.
+		 *
+		 * We only want to run the post index changed hook if
+		 * we've actually changed entries, so keep track if we
+		 * actually changed entries or not.
+		 */
 		int is_cache_changed = 0;
-		/* Mark all entries invalid */
+
 		for (i = 0; i < istate->cache_nr; i++) {
 			if (istate->cache[i]->ce_flags & CE_FSMONITOR_VALID) {
 				is_cache_changed = 1;
@@ -330,7 +345,10 @@ void refresh_fsmonitor(struct index_state *istate)
 			}
 		}
 
-		/* If we're going to check every file, ensure we save the results */
+		/*
+		 * If we're going to check every file, ensure we save
+		 * the results.
+		 */
 		if (is_cache_changed)
 			istate->cache_changed |= FSMONITOR_CHANGED;
 
-- 
gitgitgadget

