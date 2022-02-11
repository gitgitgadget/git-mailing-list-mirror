Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2291BC433F5
	for <git@archiver.kernel.org>; Fri, 11 Feb 2022 20:57:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353615AbiBKU53 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Feb 2022 15:57:29 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353555AbiBKU4w (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Feb 2022 15:56:52 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0D9CD8B
        for <git@vger.kernel.org>; Fri, 11 Feb 2022 12:56:45 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id w11so17198071wra.4
        for <git@vger.kernel.org>; Fri, 11 Feb 2022 12:56:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=N6NEAnIeFxtgSrL3f9Vngd0RTpjHfgeeC0abZfHdDjg=;
        b=fQEiHBryG0Va24s7fl3JI5GCF+GY/D29l8Z6wRmFqThGAFkIqTFQS5qZgKhIOJT9Zr
         TqdVpmplCzO2vAAOMxG13+u7HFJMmYuYRJ3+mZPm+6W3uDQnrR2Z6GRjGQLgum0wBfNI
         zV0H/owsrFfVOOpisDyofn2sLMpYbmtIyatJbKMAhZitFhNFTZJcrlJ8Mz9MEeG6CRQS
         EV1Up4JvUhkkxlio120jKQdDvtoToZSLvuDw/o8/4jIxl/1seUHLADDnwXAs+jxiUKyk
         Pl9CfymGspTuSiMEDxxTklQs62/RdMqeCQLxlFkOF61YXIBmAScgmIHy1bqtl0sTl06s
         Flvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=N6NEAnIeFxtgSrL3f9Vngd0RTpjHfgeeC0abZfHdDjg=;
        b=Pa+nLYbvVbWXJAW1d4V7iK+iIzAgmyTcXW40rYkjRW9ngJS+X66O+l9y15W4cMoRO8
         JIyBsl3ZAnYFia5B/mRPPS7aM+1U7vjg1x4PPxCzGmh1lFO08l9bRnLaPxVTbPkwNZWz
         hudUmTVjjXfsbuUDZJbu/LvAWyaQh6FGvhsoZ0CbhzEwDky8Ctjm8+Z1ZtrCAG7KkxDV
         gPkwmI0xwMqGIvDdPn99JqEcKoNV26LIxRp773QxfIOWRwkOaOHgSGRVQOE8GA8woSIW
         IiYMCDp3cT+ZoR6QnIPu/IYQ9b/eKJVCvWj8bGHXdv0Zc/hlq1QTtMR/VaiE4nLtbLPj
         7VEA==
X-Gm-Message-State: AOAM5338fYuowoFw4WzfcqgLnGLxTV+cZzNlynJUDKRcRuiA6x3/2INd
        q7ck0EXm8LLHae7+T5qhPAiB+oz7HDg=
X-Google-Smtp-Source: ABdhPJwRLvOJ9P4I1XAOYTy/MCXkwaR//tdb2T0+22e0DbgaP5jybQtcM7D7n9mKBSzFtW8dy6Zotg==
X-Received: by 2002:adf:eb04:: with SMTP id s4mr2593880wrn.20.1644613004333;
        Fri, 11 Feb 2022 12:56:44 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r2sm13076704wrt.65.2022.02.11.12.56.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Feb 2022 12:56:43 -0800 (PST)
Message-Id: <aec44a21afda7f058aca274dcb93c1eec442784a.1644612979.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1041.v5.git.1644612979.gitgitgadget@gmail.com>
References: <pull.1041.v4.git.1634826309.gitgitgadget@gmail.com>
        <pull.1041.v5.git.1644612979.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 11 Feb 2022 20:56:17 +0000
Subject: [PATCH v5 28/30] fsmonitor: force update index after large responses
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Jeff Hostetler <git@jeffhostetler.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
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
---
 fsmonitor.c | 57 ++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 56 insertions(+), 1 deletion(-)

diff --git a/fsmonitor.c b/fsmonitor.c
index 4287aad6bbb..8e3499d0667 100644
--- a/fsmonitor.c
+++ b/fsmonitor.c
@@ -219,6 +219,45 @@ static void fsmonitor_refresh_callback(struct index_state *istate, char *name)
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
+ *
+ * NEEDSWORK: Does this need to be a config value?
+ */
+static int fsmonitor_force_update_threshold = 100;
+
 void refresh_fsmonitor(struct index_state *istate)
 {
 	struct strbuf query_result = STRBUF_INIT;
@@ -362,25 +401,39 @@ apply_results:
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
@@ -409,6 +462,8 @@ apply_results:
 		if (istate->untracked)
 			istate->untracked->use_fsmonitor = 0;
 	}
+	trace2_region_leave("fsmonitor", "apply_results", istate->repo);
+
 	strbuf_release(&query_result);
 
 	/* Now that we've updated istate, save the last_update_token */
-- 
gitgitgadget

