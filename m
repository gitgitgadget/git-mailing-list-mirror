Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E39D4C4332F
	for <git@archiver.kernel.org>; Fri, 25 Mar 2022 19:32:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230224AbiCYTdo (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Mar 2022 15:33:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230468AbiCYTc4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Mar 2022 15:32:56 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F8DE216FB9
        for <git@vger.kernel.org>; Fri, 25 Mar 2022 12:07:30 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id r204-20020a1c44d5000000b0038ccb70e239so135675wma.3
        for <git@vger.kernel.org>; Fri, 25 Mar 2022 12:07:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=GykMGxH+vcSxKSOuzIgVgE2plWrsxxaHhbdq7JLSrgU=;
        b=GUs1Y8GTmGubx9lG1XYDb21uEL1LwpQ5SgXwwNvcJ0DgYtW2ditw4hk/AMAVfOfFz4
         SxRJSrJgadvfuX5s/M5y1c6vkNK2gJDi+RV1f0X7vDxoAyjsl81L/aHweYa+2sGI0Kcu
         wja0zfZXy+i8Kwz2lqj2xil9dXDThujWgBeiI9cRUwXOp3q7wPyWmRlIWxl7HRJs62Wo
         d2yiPAbiRAq7Gfz2b8BLqUxbaGUJwN1IJviuIozCiQMcfzLKhG7U2wBe1UIuZ5+QUpIi
         H5AUR7ltD8z3uzJs6YV46Y5VdpT2LFE7BCX00JwzsJ8yqydKwylOFyAV0p6FIyNydpwL
         NDrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=GykMGxH+vcSxKSOuzIgVgE2plWrsxxaHhbdq7JLSrgU=;
        b=O6uOTv39Z4MaY6yIz6KjCvfDsXQyj1FiS9unNix7st15vBlU470RFYpEkl12jm1x/C
         gEc+tcJMzOMQGQ2MPrwKFI6m+PGuz+SryHBdx3USLR35DBCfbAQ61QdRcVHuOktgK6Yd
         waQXK4ba5j3Dgc9LwbNGbitR1ak2OCJLwAgrgTFz5lC50cg5hsjCfybRik5Q+0COpMGV
         TnCV8MGRuwm0JItHy1zaAeVqLTDBcdgyzKrd1nZQuwinZdZSFKGl9FKzM9KTiVV7G5n9
         l2MI+EMF/NUBKfPrNAoTT6k1IraDaTUOUVlNicM/g6L6s7CTFNUXO/igHnhk4+SPYifo
         PzPA==
X-Gm-Message-State: AOAM533/B+3XausFuSU6CsE1Pe9hJbzoTUZTqj1okDAtDTyCD0megs0l
        1VEJveGSqQkWBqftNWS5JDyICu2srks=
X-Google-Smtp-Source: ABdhPJx89/8i6IWtXFSBmisqvkun0yqR9y+bzYmfxpnCxaOZMPIIlgoE3IYeZCoO85VRpD8JFEZaLA==
X-Received: by 2002:a7b:c74c:0:b0:38c:7645:9896 with SMTP id w12-20020a7bc74c000000b0038c76459896mr11337272wmk.83.1648231395923;
        Fri, 25 Mar 2022 11:03:15 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s17-20020adfdb11000000b001f02d5fea43sm6096493wri.98.2022.03.25.11.03.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Mar 2022 11:03:15 -0700 (PDT)
Message-Id: <e98373f997f5994a08423b3f42b6ddadb3a2a511.1648231393.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1041.v9.git.1648231393.gitgitgadget@gmail.com>
References: <pull.1041.v8.git.1648140586.gitgitgadget@gmail.com>
        <pull.1041.v9.git.1648231393.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 25 Mar 2022 18:02:44 +0000
Subject: [PATCH v9 01/30] fsmonitor: enhance existing comments, clarify
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
        Tao Klerks <tao@klerks.biz>, rsbecker@nexbridge.com,
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

