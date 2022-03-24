Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53D20C433EF
	for <git@archiver.kernel.org>; Thu, 24 Mar 2022 16:52:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351903AbiCXQyJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Mar 2022 12:54:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351940AbiCXQwn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Mar 2022 12:52:43 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85DD5B188C
        for <git@vger.kernel.org>; Thu, 24 Mar 2022 09:50:27 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id p189so3098615wmp.3
        for <git@vger.kernel.org>; Thu, 24 Mar 2022 09:50:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=OqCROC5s98+c4tM5gHnUYLicOFeDXUaj+atK5YqejLE=;
        b=puJvJcJ9WRiByttAPCNVrbuBqK3vuoyf169OHLIOeA+CJkxjTPvbi5P7h5gbMAFqGB
         T4jdRA5c3VCrB4VNTjoPVirwiImnbVcWmxMocPq6Smksdn6fzIJdhCIClDTxPhsJkoaK
         9rfgk6dghHhXFujQM+G6CkQsW+GPRxqQzFFDExA5l5V7Az/j6uOGNkK0FKtz/xsr3WOE
         eS+4cbb9W/XMdY6o4CRiAD0lTajLgQz7mwOWT6cl6OtsTfp1f8C89S1uOL+tmQoEp/B3
         UqUnR8LxQNVjcZd/e8X8BLHRWF1hPLa9oxuO+lMqAe2Bt6TsGjk377puNXNurLG6VIDV
         8rTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=OqCROC5s98+c4tM5gHnUYLicOFeDXUaj+atK5YqejLE=;
        b=bWMJ+tOXH10Bqn/bUOgRicqnFcSk/AQ3h0u8oL6eT86Nh0M0JCUy75+vFHCXu0UMDA
         8t7Vi85t0NC+5IHj/rYCqUdtMPwJ4SP+HDK1U6dStl5kxvLr4ldvjoJahUCMqekP4Cu1
         c1LbYCMzl72LWrXYmxDd1bYIQvaA9d70+n4FWV0CPDajA8cHOFiQ2pJx60HUkkrqgmiN
         nz/q26PqVUYbDGla7IlXnRXVUIkT0Nt2SqB/Y1EuAp/M0cYTr3OnASROWslwkgvO6r0e
         FBX0KaViM3m1CHOpGcVqgI5RXXMtTZtyk1ixAC8W6ptgPysJ8eL0eiOhiS7XLIZZh4TV
         H//Q==
X-Gm-Message-State: AOAM532y0A1BQXHKM7pmk10664QAaKzdfcyawoYXXRF0L21Dqt37vq9k
        v9AM3iK+IFp9S4kLltO0TIl82NkhMwI=
X-Google-Smtp-Source: ABdhPJz08zWrvOqCA+t9QxY/XVpZSpJ8vUO2704uhvpN2y+PtPLTsSsL+sPJgu+9KWokLx3BboD5RA==
X-Received: by 2002:a05:600c:3016:b0:38c:8786:d3b6 with SMTP id j22-20020a05600c301600b0038c8786d3b6mr5566135wmh.135.1648140625794;
        Thu, 24 Mar 2022 09:50:25 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q14-20020a1cf30e000000b0038986a18ec8sm2410125wmq.46.2022.03.24.09.50.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Mar 2022 09:50:24 -0700 (PDT)
Message-Id: <4caf1d89b841726e9b76372bd6b238d5ebbffa5e.1648140586.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1041.v8.git.1648140586.gitgitgadget@gmail.com>
References: <pull.1041.v7.git.1647972010.gitgitgadget@gmail.com>
        <pull.1041.v8.git.1648140586.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 24 Mar 2022 16:49:45 +0000
Subject: [PATCH v8 29/30] fsmonitor: force update index after large responses
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

Measure the time taken to apply the FSMonitor query result
to the index and the untracked-cache.

Set the `FSMONITOR_CHANGED` bit on `istate->cache_changed` when
FSMonitor returns a very large repsonse to ensure that the index is
written to disk.

Normally, when the FSMonitor response includes a tracked file, the
index is always updated.  Similarly, the index might be updated when
the response alters the untracked-cache (when enabled).  However, in
cases where neither of those cause the index to be considered changed,
the FSMonitor response is wasted.  Subsequent Git commands will make
requests with the same token and receive the same response.

If that response is very large, performance may suffer.  It would be
more efficient to force update the index now (and the token in the
index extension) in order to reduce the size of the response received
by future commands.

This was observed on Windows after a large checkout.  On Windows, the
kernel emits events for the files that are changed as they are
changed.  However, it might delay events for the containing
directories until the system is more idle (or someone scans the
directory (so it seems)).  The first status following a checkout would
get the list of files.  The subsequent status commands would get the
list of directories as the events trickled out.  But they would never
catch up because the token was not advanced because the index wasn't
updated.

This list of directories caused `wt_status_collect_untracked()` to
unnecessarily spend time actually scanning them during each command.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 fsmonitor.c | 55 ++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 54 insertions(+), 1 deletion(-)

diff --git a/fsmonitor.c b/fsmonitor.c
index a38b5710eb3..292a6742b4f 100644
--- a/fsmonitor.c
+++ b/fsmonitor.c
@@ -219,6 +219,43 @@ static void fsmonitor_refresh_callback(struct index_state *istate, char *name)
 	untracked_cache_invalidate_path(istate, name, 0);
 }
 
+/*
+ * The number of pathnames that we need to receive from FSMonitor
+ * before we force the index to be updated.
+ *
+ * Note that any pathname within the set of received paths MAY cause
+ * cache-entry or istate flag bits to be updated and thus cause the
+ * index to be updated on disk.
+ *
+ * However, the response may contain many paths (such as ignored
+ * paths) that will not update any flag bits.  And thus not force the
+ * index to be updated.  (This is fine and normal.)  It also means
+ * that the token will not be updated in the FSMonitor index
+ * extension.  So the next Git command will find the same token in the
+ * index, make the same token-relative request, and receive the same
+ * response (plus any newly changed paths).  If this response is large
+ * (and continues to grow), performance could be impacted.
+ *
+ * For example, if the user runs a build and it writes 100K object
+ * files but doesn't modify any source files, the index would not need
+ * to be updated.  The FSMonitor response (after the build and
+ * relative to a pre-build token) might be 5MB.  Each subsequent Git
+ * command will receive that same 100K/5MB response until something
+ * causes the index to be updated.  And `refresh_fsmonitor()` will
+ * have to iterate over those 100K paths each time.
+ *
+ * Performance could be improved if we optionally force update the
+ * index after a very large response and get an updated token into
+ * the FSMonitor index extension.  This should allow subsequent
+ * commands to get smaller and more current responses.
+ *
+ * The value chosen here does not need to be precise.  The index
+ * will be updated automatically the first time the user touches
+ * a tracked file and causes a command like `git status` to
+ * update an mtime to be updated and/or set a flag bit.
+ */
+static int fsmonitor_force_update_threshold = 100;
+
 void refresh_fsmonitor(struct index_state *istate)
 {
 	struct strbuf query_result = STRBUF_INIT;
@@ -362,25 +399,39 @@ apply_results:
 	 *     information and that we should consider everything
 	 *     invalid.  We call this a trivial response.
 	 */
+	trace2_region_enter("fsmonitor", "apply_results", istate->repo);
+
 	if (query_success && !is_trivial) {
 		/*
 		 * Mark all pathnames returned by the monitor as dirty.
 		 *
 		 * This updates both the cache-entries and the untracked-cache.
 		 */
+		int count = 0;
+
 		buf = query_result.buf;
 		for (i = bol; i < query_result.len; i++) {
 			if (buf[i] != '\0')
 				continue;
 			fsmonitor_refresh_callback(istate, buf + bol);
 			bol = i + 1;
+			count++;
 		}
-		if (bol < query_result.len)
+		if (bol < query_result.len) {
 			fsmonitor_refresh_callback(istate, buf + bol);
+			count++;
+		}
 
 		/* Now mark the untracked cache for fsmonitor usage */
 		if (istate->untracked)
 			istate->untracked->use_fsmonitor = 1;
+
+		if (count > fsmonitor_force_update_threshold)
+			istate->cache_changed |= FSMONITOR_CHANGED;
+
+		trace2_data_intmax("fsmonitor", istate->repo, "apply_count",
+				   count);
+
 	} else {
 		/*
 		 * We failed to get a response or received a trivial response,
@@ -409,6 +460,8 @@ apply_results:
 		if (istate->untracked)
 			istate->untracked->use_fsmonitor = 0;
 	}
+	trace2_region_leave("fsmonitor", "apply_results", istate->repo);
+
 	strbuf_release(&query_result);
 
 	/* Now that we've updated istate, save the last_update_token */
-- 
gitgitgadget

