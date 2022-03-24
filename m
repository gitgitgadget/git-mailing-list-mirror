Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD06FC433F5
	for <git@archiver.kernel.org>; Thu, 24 Mar 2022 16:49:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347176AbiCXQvY (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Mar 2022 12:51:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244475AbiCXQvX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Mar 2022 12:51:23 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BADF90CDA
        for <git@vger.kernel.org>; Thu, 24 Mar 2022 09:49:51 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id t11so7481179wrm.5
        for <git@vger.kernel.org>; Thu, 24 Mar 2022 09:49:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=GykMGxH+vcSxKSOuzIgVgE2plWrsxxaHhbdq7JLSrgU=;
        b=oWaXRooSU+xtyqbbgylRi6e0DNbXfBhfDlUfN3TnI+DcR/Wpb4v42Ivnob2TeZYiEa
         i1QWep5FQmls4IAcbdRLsbs0xdDO3GAnYD4AFaNVf5ZCsIuSMpI0S2GtZQzVu4GUnuty
         cJwXVxJx7qlFFitKgQ4qC0+Y8BeivaHx7Z2Jiu2+AoTXIVF4x4L0fa1Ha3L4c17FiWF4
         B3AXEt2QWUT2gup4AkLSL0LIUb+NwId6AXa3B9jVvGB13hDqDcRW0CbCgqs6H6KdZsek
         ETnuHlOlTDlH/lBEA6KV3pDgvBVrEacUffKyfLOpKWdsBCEbPlew6fkajcgfBQ6XyO9H
         yioQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=GykMGxH+vcSxKSOuzIgVgE2plWrsxxaHhbdq7JLSrgU=;
        b=gscIlyYLa5+Oa51cjtEEFFiFt01yL2fty+eFBw6zTbSi6vYuTEds9AnmDSJIRx5KaX
         23Tl9QQC0L1pGRzsYf0l0Zp8fAlfeGqTmKbhke6/SGNICUJyHazR9caxklMTeygLdveT
         Pe80LZfUmG6ngF7F0SsVbwNum80jIdBuzHPonX7o/g2Xg63lMh66zZYOx2Sf+uDO2ARj
         hgpRyq/rz+2x29A1OVYiF0BOoVg3wy3HpwiNMSxGFYQsKHYODoeeFUdJ53ezY7JwSz0Q
         y8YWEe2Sf970BUbeHfjhTB0nd3oVcSO0gdwjFYSls7AVugsxEhwf3be7b7yrWPr9nMb5
         29Yw==
X-Gm-Message-State: AOAM531sV7KC/zAqXB/QIsHZ10/M8DP0QS6qt4FXpDUi+ElSkJPVjtHH
        QKLc4YQhdl0m52R2BgRvwKIR1Pzy3to=
X-Google-Smtp-Source: ABdhPJyu8H92IQ9s9GIyQKEk+W2FHWcW1zGFE3271npHzeH8GCyu5CM/IBNjHy5ysO3GB+ODCo9LFQ==
X-Received: by 2002:a5d:4091:0:b0:203:f2a6:66f0 with SMTP id o17-20020a5d4091000000b00203f2a666f0mr5262932wrp.481.1648140589596;
        Thu, 24 Mar 2022 09:49:49 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l15-20020a05600c4f0f00b0038cbdf5221dsm5732980wmq.41.2022.03.24.09.49.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Mar 2022 09:49:48 -0700 (PDT)
Message-Id: <e98373f997f5994a08423b3f42b6ddadb3a2a511.1648140586.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1041.v8.git.1648140586.gitgitgadget@gmail.com>
References: <pull.1041.v7.git.1647972010.gitgitgadget@gmail.com>
        <pull.1041.v8.git.1648140586.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 24 Mar 2022 16:49:17 +0000
Subject: [PATCH v8 01/30] fsmonitor: enhance existing comments, clarify
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

