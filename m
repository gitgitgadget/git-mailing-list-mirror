Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 082D9C4332F
	for <git@archiver.kernel.org>; Wed, 13 Oct 2021 20:31:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD55D610E5
	for <git@archiver.kernel.org>; Wed, 13 Oct 2021 20:31:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229730AbhJMUd5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Oct 2021 16:33:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbhJMUdy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Oct 2021 16:33:54 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C06BC061746
        for <git@vger.kernel.org>; Wed, 13 Oct 2021 13:31:50 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id r7so12374697wrc.10
        for <git@vger.kernel.org>; Wed, 13 Oct 2021 13:31:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=SbbdgLi1cHIa2BbYx4STh/bPoVh7i9SdShiJl1YSCVc=;
        b=qhLFc3b1EwRUG+ABE24ZmwptquItd5itHZqrof30ypd6zX7SzSF2F6NYtXr6TqS8ex
         JX2LCJgLO9RfkKNZNjQpiAJecWsWRB05F3p3RbkV8l4zHdu6E8koy2ol4z1KI+SbQHLB
         irWqxYgc85zCLlhh9W7I4z2f7yQe691wKFwPr1tF0mkUDUEoLvAwvAICTjL+TfK9Fi34
         8HSkLkz1qLKMIj5DTLNT9/7t+YLAnou1x/8IPJvxSgZ10vuj10Z4q27gLr/Omw8Zu2W7
         BrYej8wvIYiA/U8vN8BHy4NyfjQwX7TV6DCcrc5VrE25piXn7G2ZbPEZLezHTRbfQVEO
         89xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=SbbdgLi1cHIa2BbYx4STh/bPoVh7i9SdShiJl1YSCVc=;
        b=mUtypCAMRdgtqL7EGgbsOWtP7Vn19lr2GHWTXKgttaXQZTjidioIuJGkjZbrUK4A0P
         CTFPebNB3xn9D1d1ufpKATmLbWnr8IrR/euei+qniG+wrdlY9TqKWfKc6rTenZU/X2d8
         9yAI6Dpg0nqrg2wXHVurh4IZwUMG77RtZsbSyDEl5hK/zqo5RZa9u4eRqGt2tjCqkDUB
         sUNLsSu9vFnNNCheSOpKy9y/PYyP8IQBf06Y6rFJVe3zeAg5uoPcfS7op6rTLdXj514h
         rUsLJHTDp0JSWoa3KuQaAWgdzQjolp+/mb5YxPhv7DinhvedsiJC2pPYwtfA6ExmnlPT
         RNYQ==
X-Gm-Message-State: AOAM531kdEJ184pOXZ25P9kSmABq7M7n5q/S5i86iHFIgEh6eKt4/sAt
        eeeGQOFZI14ULXzdAy04iAXsvZ55Jew=
X-Google-Smtp-Source: ABdhPJzMcx+oZIVQVW5MRKTAYGyzvfsjATsUTH0BsFGTk+YqALm3reOTFqJAZM4mJbQaZiI4gTORjA==
X-Received: by 2002:a05:600c:b43:: with SMTP id k3mr1476648wmr.142.1634157109289;
        Wed, 13 Oct 2021 13:31:49 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y191sm6919753wmc.36.2021.10.13.13.31.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Oct 2021 13:31:49 -0700 (PDT)
Message-Id: <cb25eeaf72dfe25bfa62bd550a0cabf8817bf914.1634157107.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1041.v3.git.1634157107.gitgitgadget@gmail.com>
References: <pull.1041.v2.git.1633614772.gitgitgadget@gmail.com>
        <pull.1041.v3.git.1634157107.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 13 Oct 2021 20:31:43 +0000
Subject: [PATCH v3 1/5] fsmonitor: enhance existing comments
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Jeff Hostetler <git@jeffhostetler.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 fsmonitor.c | 37 ++++++++++++++++++++++++++++++-------
 1 file changed, 30 insertions(+), 7 deletions(-)

diff --git a/fsmonitor.c b/fsmonitor.c
index ab9bfc60b34..ec4c46407c5 100644
--- a/fsmonitor.c
+++ b/fsmonitor.c
@@ -301,9 +301,25 @@ void refresh_fsmonitor(struct index_state *istate)
 			core_fsmonitor, query_success ? "success" : "failure");
 	}
 
-	/* a fsmonitor process can return '/' to indicate all entries are invalid */
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
 	if (query_success && query_result.buf[bol] != '/') {
-		/* Mark all entries returned by the monitor as dirty */
+		/*
+		 * Mark all pathnames returned by the monitor as dirty.
+		 *
+		 * This updates both the cache-entries and the untracked-cache.
+		 */
 		buf = query_result.buf;
 		for (i = bol; i < query_result.len; i++) {
 			if (buf[i] != '\0')
@@ -318,11 +334,15 @@ void refresh_fsmonitor(struct index_state *istate)
 		if (istate->untracked)
 			istate->untracked->use_fsmonitor = 1;
 	} else {
-
-		/* We only want to run the post index changed hook if we've actually changed entries, so keep track
-		 * if we actually changed entries or not */
+		/*
+		 * We received a trivial response, so invalidate everything.
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
@@ -330,7 +350,10 @@ void refresh_fsmonitor(struct index_state *istate)
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

