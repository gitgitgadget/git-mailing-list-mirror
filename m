Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4BEAC433FE
	for <git@archiver.kernel.org>; Thu, 21 Oct 2021 14:26:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF2F76121F
	for <git@archiver.kernel.org>; Thu, 21 Oct 2021 14:26:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231220AbhJUO2Z (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Oct 2021 10:28:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231567AbhJUO1u (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Oct 2021 10:27:50 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D02DC06122A
        for <git@vger.kernel.org>; Thu, 21 Oct 2021 07:25:29 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id l38-20020a05600c1d2600b0030d80c3667aso864065wms.5
        for <git@vger.kernel.org>; Thu, 21 Oct 2021 07:25:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=K2JfkL/rCOOdVnhb4foqPuEr3y7Vo9Kxuasqs6sdWGE=;
        b=ZA8M48iM0Cmu91mgRXRC49Tar5wr40iBHftw4pnTfVl84eLSpsPfVPXObAqvFS0G0x
         +MlaKh6vw7AYdA27HpwmaxwqqQbVHO5XweAhwBGDl2mSMMVswN1Sn9Bbh/oYEmfh5alF
         t1N//w7/E8dvu5dUGt7Ojn5ncP/pXSH+80oN/M2gQnkw8cdGkQqSTQFZ5LnP4wu11Bvc
         kqCSN4DNu0u0v8vRD2rx5emajTqRPQxtdJ6p+az0/w8iOj5HpF1/knmp9Y2wxXKYAVv/
         CfrnF8aGirBc9cLH1uO0r0wIvCeU1QajpUGVIWU4CYEpflnspFeuG7pFc1fYXINf89ME
         Z+Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=K2JfkL/rCOOdVnhb4foqPuEr3y7Vo9Kxuasqs6sdWGE=;
        b=bwR5sPnTKWCeVk4fAb/l5Ya97LeQGUtbR+q4F3hoCOoA8K/YpO9e+7icalLfbmHdJM
         lY9NSCE+y9zTzHSdXCig1xcqVqW8Gwn1wno+veMynJNky69iiJJm8UEHsfv2/wURRNz5
         8Npry8WTFBhqf+eA9wb05qhacDFcoZaksBgUWuj6zye+vTOTgEFeixFpukZQFehaftfg
         FZxzc04tIEwsHvvE5E/jxJmyQfSXyom5le707G212AaaGMkyVWs5RFTUUgM9U+RMqgyx
         SwiIzYF7RtElBIUzHr4+2LDgez5D03iiv5zXbqF6luz5xxm0NJ6iYT98YL3GBPqm3YDk
         e6tA==
X-Gm-Message-State: AOAM532HMccUbzTFEB02OdWwvdV9Z6Ya4c3oGmbkPJLF6bQrlqF2B3ui
        Pfg3FzEwQFjZmTC70y1AGBpyX3DFv2E=
X-Google-Smtp-Source: ABdhPJx1qEUdZaPHuyhwwSOhBI03xTshzss/yZm8JoQ8ZnfTpRVAP4WlrMl6hxTd7P+bM8mU7iCADA==
X-Received: by 2002:a05:600c:a08:: with SMTP id z8mr21466863wmp.165.1634826327618;
        Thu, 21 Oct 2021 07:25:27 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 25sm8175899wmo.18.2021.10.21.07.25.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 07:25:27 -0700 (PDT)
Message-Id: <30e61b6d1adc9e0f4a515e98cb75be06c493e711.1634826309.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1041.v4.git.1634826309.gitgitgadget@gmail.com>
References: <pull.1041.v3.git.1634157107.gitgitgadget@gmail.com>
        <pull.1041.v4.git.1634826309.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 21 Oct 2021 14:25:08 +0000
Subject: [PATCH v4 28/29] fsmonitor: force update index after large responses
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
index 695fb0ce4e7..2befde1ffd2 100644
--- a/fsmonitor.c
+++ b/fsmonitor.c
@@ -233,6 +233,45 @@ static void fsmonitor_refresh_callback(struct index_state *istate, char *name)
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
@@ -364,25 +403,39 @@ apply_results:
 	 *     information and that we should consider everything
 	 *     invalid.  We call this a trivial response.
 	 */
+	trace2_region_enter("fsmonitor", "apply_results", istate->repo);
+
 	if (query_success && query_result.buf[bol] != '/') {
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
 		 * We received a trivial response, so invalidate everything.
@@ -410,6 +463,8 @@ apply_results:
 		if (istate->untracked)
 			istate->untracked->use_fsmonitor = 0;
 	}
+	trace2_region_leave("fsmonitor", "apply_results", istate->repo);
+
 	strbuf_release(&query_result);
 
 	/* Now that we've updated istate, save the last_update_token */
-- 
gitgitgadget

