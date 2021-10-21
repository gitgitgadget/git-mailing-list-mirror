Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E3E1C433F5
	for <git@archiver.kernel.org>; Thu, 21 Oct 2021 14:25:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 750BF6128B
	for <git@archiver.kernel.org>; Thu, 21 Oct 2021 14:25:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231485AbhJUO1o (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Oct 2021 10:27:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230123AbhJUO13 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Oct 2021 10:27:29 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46028C061348
        for <git@vger.kernel.org>; Thu, 21 Oct 2021 07:25:13 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id e12so1421303wra.4
        for <git@vger.kernel.org>; Thu, 21 Oct 2021 07:25:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=SbbdgLi1cHIa2BbYx4STh/bPoVh7i9SdShiJl1YSCVc=;
        b=lRExW6176SINaLQR1KnRrdEoJg1tUFMPq4eHZbB+4DDXI16pNe8YHbcmB8uIRYxskh
         0ZN06kiV9nFax19T77JRwp32QSMflxYXJr9i8S7ovpPWeehDLAmHUf6DFRuRyxpxz6tD
         Yas66/1VAQBJtsL/mJobjCJw1GA/kB/zpzCEQXA07YhRhNM04p0krl0B0hWfArhgsIdE
         ai0VhcuuYNDIMzeR1Pk1KjSU1bfdHTROtAoDHx72Qi1WYncwpDEnyRCSeuS2R3npOG+R
         b0iJt1RLdXir6KjfwNmRTKQ8ExHvCoOMS8Wf3Z2RCZ2g5jAKabrvSQz3bWPmZJbVVmam
         0qbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=SbbdgLi1cHIa2BbYx4STh/bPoVh7i9SdShiJl1YSCVc=;
        b=idzh0OQrc1Vo1YQh73ZLBKKinPf3aC75ncs+PD+oKQQuUfeK31OdCyC4mkD4NETUxw
         FhygSQ7UzvdHuY0Px/zariSRAcA0hFdkQNKkr57Ilo8VJms4SAJ4dYLIyudkrx2aJsjW
         2Jx3fBxLJmBx5K6Fj6IWH5oioHHpMXeKaKFJn6MY49/HCt0Uy2df8pTaMPufVq6GCzxm
         2sSr66BpcE/Z1ubIu6dmaW+P5mRD5wFCsqXM6yso2rsXL3ebo+uwgLG1/D7/IOPHqxRt
         Zz+hEBLyw0YWDW2OiyRM2IcoaobZe64ck9xnxqK0pbNUZypclQumFtxp1Kn9pu1gW/4y
         I/0Q==
X-Gm-Message-State: AOAM5327jQGjVyoVNvV/3+VyWS2S0YBhycN8PH2wswXKO30S0W33TzXD
        WrZR41j9dhHhHdxbMEExhunl5jgvRIs=
X-Google-Smtp-Source: ABdhPJwWbaLMXqTyXiK8irm0h06d9VRsW9HI1itZt/62i7QtJit4dUlgCAXGXNnFdpSV0N5T4Sg0jg==
X-Received: by 2002:a5d:4b90:: with SMTP id b16mr243711wrt.118.1634826311930;
        Thu, 21 Oct 2021 07:25:11 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l2sm5060137wrw.42.2021.10.21.07.25.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 07:25:11 -0700 (PDT)
Message-Id: <ecc40795fa26ea86525421682303449f70132216.1634826309.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1041.v4.git.1634826309.gitgitgadget@gmail.com>
References: <pull.1041.v3.git.1634157107.gitgitgadget@gmail.com>
        <pull.1041.v4.git.1634826309.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 21 Oct 2021 14:24:41 +0000
Subject: [PATCH v4 01/29] fsmonitor: enhance existing comments
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

