Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC5D9C433EF
	for <git@archiver.kernel.org>; Tue, 22 Mar 2022 18:24:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232158AbiCVSZe (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Mar 2022 14:25:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240330AbiCVSZY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Mar 2022 14:25:24 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50290692A9
        for <git@vger.kernel.org>; Tue, 22 Mar 2022 11:23:56 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id r64so11844883wmr.4
        for <git@vger.kernel.org>; Tue, 22 Mar 2022 11:23:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=aGhX76dz325gkGkIrL9UlyaHr3ziBUV0IbljHMDHg+g=;
        b=GW69XiKo2T/Xo2pKsYW+LWIVSmqjRk4do21ccvdTPZJg7IcbQcpYd/qfst22QPFgUc
         gJCUl2AGkpry7LLAJLj10AP54Ncs7uvx4Vl2fR2BJafe/4Q7S2XBJPZVXfxTTKDp+3p0
         yXqmYlLjI9U7D1nXPOPfn5HwcP3wa43ESB8xVAa1UNieiET0RI6KQv9F3FoU7GmEsUmw
         bMudwMkhCUw9/R4WiKZW0osXcptxc0Atp5knD2pu0gSxO0o8iBJkKUOPixzr+8X0V3nq
         UnnRgzX5Zik5zqYT9eRgo1b1f9rTthqA1fqQlM6SJVDWg72WXE4SB/pWSBzYQfJhHdH9
         gNKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=aGhX76dz325gkGkIrL9UlyaHr3ziBUV0IbljHMDHg+g=;
        b=iuNu0h9ZpthW3E2CNmHDJWocQWXHjDvFsGf0NnksZHcbS16IFVB4NutxHbnTYtCSpz
         lBaT8LrwTdwR2B5hJuqjWGYcXs8YdvzFKtmM0cqGaIH2jJIHZEvwljr0ZvU5tPH7MWbL
         oCc3jYVa7/4xBda6onT/T6m6bSnTakpis8AFaunuqbtgS4bgDCqTonKUocYmUB7MJmsu
         OJSQbNiZDNjjvXmaqGRIVUyqDhoDFPra/sk0JijHoRcXYf8vg+fAqjRljjxUenVDfpMI
         c9jZ6CfgXtgz4s3ws+lAMUiw1mkiX3qzK1r8tyiOFqAqAhdgEe4f6kiQKMyxR3xL6fZd
         I79w==
X-Gm-Message-State: AOAM5312Qd3XKhUuWT9PMGdbML8kSfS8I2vZj0wDNwVOuOKfabMIcdzM
        /pCLr2FBPCVfnBa6QDBee43syT47ibY=
X-Google-Smtp-Source: ABdhPJx146YANg8jgunnul68Wey41i4Zu/4w4W0eJFjbXgOmRFxWrBNrjwDku/xSK+w8mjoKs+BcHA==
X-Received: by 2002:a7b:c5d0:0:b0:389:fe85:3d79 with SMTP id n16-20020a7bc5d0000000b00389fe853d79mr5263864wmk.77.1647973434443;
        Tue, 22 Mar 2022 11:23:54 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v124-20020a1cac82000000b0037c3d08e0e7sm2358758wme.29.2022.03.22.11.23.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Mar 2022 11:23:53 -0700 (PDT)
Message-Id: <0f0a5b5ca1630985b9a91fa0e6c5fc951561679c.1647973380.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1143.v3.git.1647973380.gitgitgadget@gmail.com>
References: <pull.1143.v2.git.1646777727.gitgitgadget@gmail.com>
        <pull.1143.v3.git.1647973380.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 22 Mar 2022 18:22:53 +0000
Subject: [PATCH v3 20/27] fsmonitor: optimize processing of directory events
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
        rsbecker@nexbridge.com, Jeff Hostetler <jeffhost@microsoft.com>,
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

