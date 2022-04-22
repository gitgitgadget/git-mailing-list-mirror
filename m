Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8830CC433F5
	for <git@archiver.kernel.org>; Fri, 22 Apr 2022 22:36:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233309AbiDVWjt (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Apr 2022 18:39:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234382AbiDVWiP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Apr 2022 18:38:15 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 728D5288EFC
        for <git@vger.kernel.org>; Fri, 22 Apr 2022 14:30:19 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id c190-20020a1c35c7000000b0038e37907b5bso8798196wma.0
        for <git@vger.kernel.org>; Fri, 22 Apr 2022 14:30:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=aGhX76dz325gkGkIrL9UlyaHr3ziBUV0IbljHMDHg+g=;
        b=ixQkfS41njWr9cKspAsIm465T0Ls7faAg5C2gd9gvuTU1G0hXXQDzh+jhaD5A5AE1L
         DOX/ueK6cbMGaTB06kLXRfXWYxsEgYa1j3yZX9LIYzaq0X5rm7C2erF17P1zVXzpEWAZ
         xMQFf964Rd0er/HRGsAbwn8ZuTS1vtA9njJ095nY3s1n86AlXKMcLE1hBbL1gaLrodzF
         RNeGFVM3XpEAX6lMher/LmOo9mmkq14K4nluzQkWtofS12yn/cFdDzcORGe/Zb8nviqO
         BcP1U/RdM4bUpQXR5zXiYxdwiGmV8GIBenvms/DZeYc3lTIE5szKYdNVEbZGLOo1Xb0D
         5N6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=aGhX76dz325gkGkIrL9UlyaHr3ziBUV0IbljHMDHg+g=;
        b=yTNk0gfZkNTRsdgtylo+xFpWlWecMoZTDajVBrhHPlhY/Wm+5wqBfHjxQoWwvsQ8Yv
         8WBfOq6S38PnS7GgOC9vEAfAQtcsLg1Hrseo0EM8dR+zcEVXcqHqM/fhCI1rMKcXH9cG
         C/AT2hTr3KToql8dymL++fFSP3M7wLWpLMDBrTLCTcpqRlbvJcmJXRTnhk4yMhuoZZUT
         5bj4lBg7ty60HAFTbMqBOMXYBzOmOO/W5xdayut8EcgkabvMb2NXGJGQ7fb+1wYo1ySD
         Ajhhua3KzmpDHKIqC44ZiA71L6+whfsQIi8vz2YClBTXXq2mJx2Elz8X7Dan9pnky7aa
         XO1g==
X-Gm-Message-State: AOAM533c2RtqU2jxMm0/O6EHhUYqbwqDCEzjw7sy4N5S4B9CFmy7uYp+
        T+Fklo8CHyjCZBwVDVCf70X/Bmzq9y0=
X-Google-Smtp-Source: ABdhPJyeOr6+a1zHPrVnS9m95aXf+ct3p9cHNquJIj/4I7bfmhPGesA6Ldj81n45TJMDs7hIg6+qPQ==
X-Received: by 2002:a1c:2b86:0:b0:392:ae97:2fec with SMTP id r128-20020a1c2b86000000b00392ae972fecmr5680882wmr.165.1650663017463;
        Fri, 22 Apr 2022 14:30:17 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p1-20020a1c7401000000b0038ed3bb00c9sm2434354wmc.6.2022.04.22.14.30.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Apr 2022 14:30:16 -0700 (PDT)
Message-Id: <48af0813deccab924d3591b4df025b17bf309260.1650662994.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1143.v6.git.1650662994.gitgitgadget@gmail.com>
References: <pull.1143.v5.git.1650487398.gitgitgadget@gmail.com>
        <pull.1143.v6.git.1650662994.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 22 Apr 2022 21:29:46 +0000
Subject: [PATCH v6 20/28] fsmonitor: optimize processing of directory events
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff Hostetler <git@jeffhostetler.com>,
        Derrick Stolee <derrickstolee@github.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>,
        Torsten =?unknown-8bit?Q?B=C3=B6gershausen?= <tboegi@web.de>,
        rsbecker@nexbridge.com, Bagas Sanjaya <bagasdotme@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Teach Git to perform binary search over the cache-entries for a directory
notification and then linearly scan forward to find the immediate children.

Previously, when the FSMonitor reported a modified directory Git would
perform a linear search on the entire cache-entry array for all
entries matching that directory prefix and invalidate them.  Since the
cache-entry array is already sorted, we can use a binary search to
find the first matching entry and then only linearly walk forward and
invalidate entries until the prefix changes.

Also, the original code would invalidate anything having the same
directory prefix.  Since a directory event should only be received for
items that are immediately within the directory (and not within
sub-directories of it), only invalidate those entries and not the
whole subtree.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 fsmonitor.c | 71 ++++++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 54 insertions(+), 17 deletions(-)

diff --git a/fsmonitor.c b/fsmonitor.c
index 292a6742b4f..e1229c289cf 100644
--- a/fsmonitor.c
+++ b/fsmonitor.c
@@ -184,30 +184,68 @@ static int query_fsmonitor_hook(struct repository *r,
 static void fsmonitor_refresh_callback(struct index_state *istate, char *name)
 {
 	int i, len = strlen(name);
-	if (name[len - 1] == '/') {
+	int pos = index_name_pos(istate, name, len);
+
+	trace_printf_key(&trace_fsmonitor,
+			 "fsmonitor_refresh_callback '%s' (pos %d)",
+			 name, pos);
 
+	if (name[len - 1] == '/') {
 		/*
-		 * TODO We should binary search to find the first path with
-		 * TODO this directory prefix.  Then linearly update entries
-		 * TODO while the prefix matches.  Taking care to search without
-		 * TODO the trailing slash -- because '/' sorts after a few
-		 * TODO interesting special chars, like '.' and ' '.
+		 * The daemon can decorate directory events, such as
+		 * moves or renames, with a trailing slash if the OS
+		 * FS Event contains sufficient information, such as
+		 * MacOS.
+		 *
+		 * Use this to invalidate the entire cone under that
+		 * directory.
+		 *
+		 * We do not expect an exact match because the index
+		 * does not normally contain directory entries, so we
+		 * start at the insertion point and scan.
 		 */
+		if (pos < 0)
+			pos = -pos - 1;
 
 		/* Mark all entries for the folder invalid */
-		for (i = 0; i < istate->cache_nr; i++) {
-			if (istate->cache[i]->ce_flags & CE_FSMONITOR_VALID &&
-			    starts_with(istate->cache[i]->name, name))
-				istate->cache[i]->ce_flags &= ~CE_FSMONITOR_VALID;
+		for (i = pos; i < istate->cache_nr; i++) {
+			if (!starts_with(istate->cache[i]->name, name))
+				break;
+			istate->cache[i]->ce_flags &= ~CE_FSMONITOR_VALID;
 		}
-		/* Need to remove the / from the path for the untracked cache */
+
+		/*
+		 * We need to remove the traling "/" from the path
+		 * for the untracked cache.
+		 */
 		name[len - 1] = '\0';
+	} else if (pos >= 0) {
+		/*
+		 * We have an exact match for this path and can just
+		 * invalidate it.
+		 */
+		istate->cache[pos]->ce_flags &= ~CE_FSMONITOR_VALID;
 	} else {
-		int pos = index_name_pos(istate, name, strlen(name));
-
-		if (pos >= 0) {
-			struct cache_entry *ce = istate->cache[pos];
-			ce->ce_flags &= ~CE_FSMONITOR_VALID;
+		/*
+		 * The path is not a tracked file -or- it is a
+		 * directory event on a platform that cannot
+		 * distinguish between file and directory events in
+		 * the event handler, such as Windows.
+		 *
+		 * Scan as if it is a directory and invalidate the
+		 * cone under it.  (But remember to ignore items
+		 * between "name" and "name/", such as "name-" and
+		 * "name.".
+		 */
+		pos = -pos - 1;
+
+		for (i = pos; i < istate->cache_nr; i++) {
+			if (!starts_with(istate->cache[i]->name, name))
+				break;
+			if ((unsigned char)istate->cache[i]->name[len] > '/')
+				break;
+			if (istate->cache[i]->name[len] == '/')
+				istate->cache[i]->ce_flags &= ~CE_FSMONITOR_VALID;
 		}
 	}
 
@@ -215,7 +253,6 @@ static void fsmonitor_refresh_callback(struct index_state *istate, char *name)
 	 * Mark the untracked cache dirty even if it wasn't found in the index
 	 * as it could be a new untracked file.
 	 */
-	trace_printf_key(&trace_fsmonitor, "fsmonitor_refresh_callback '%s'", name);
 	untracked_cache_invalidate_path(istate, name, 0);
 }
 
-- 
gitgitgadget

