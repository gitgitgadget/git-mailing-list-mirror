Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12B99C636CC
	for <git@archiver.kernel.org>; Tue,  7 Feb 2023 18:18:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232185AbjBGSSd (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Feb 2023 13:18:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230204AbjBGSRm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Feb 2023 13:17:42 -0500
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93A433D083
        for <git@vger.kernel.org>; Tue,  7 Feb 2023 10:17:24 -0800 (PST)
Received: by mail-pj1-x1049.google.com with SMTP id s20-20020a17090b071400b00230ecf76407so1280765pjz.3
        for <git@vger.kernel.org>; Tue, 07 Feb 2023 10:17:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZYwZxXuZCKch3x+Vy3R4rbmwqBPB6ajawKXYoGOyBuA=;
        b=MdDbQNiq7IjnFetyJLPTQXKwkT+WH9LieGM10L/jyQrPHKa12f9xJtP1PieAd6tKGR
         /5ojHFfbWKBjXsCHKDMwW5X35MrhvMnZOvQonIBaZ9yuXFwrPo5sq4Yw4DcB7eLBS91G
         KouRxIsa3K/P1eBmxMqy5yvaYCcflBFW7v8wyioCnVScWXWEeiBL4SEdbQA/JN8mcKNP
         p8iixey7zjmI7BwlphD4RTvDSa9ZlJgvmDZJe+kQYPvhncwPnyRWGmuLkEulvkkjHFc+
         2V+TzMtTDkSUFRvAY1zuoRrml6yvCG8ym3zU/KwHuy+tFlfuOIEa4BXEM50ckX6lUtFU
         PrSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZYwZxXuZCKch3x+Vy3R4rbmwqBPB6ajawKXYoGOyBuA=;
        b=2kphz1VYug+6SbQiDflm0BGLxiyQ8cY1xq5t1/QW5qMYGbJMzbGrjrqgTyf/ARbTJi
         nE4cd/xZjTarilA4woGsPlmM3dWnaADfQ6sXHC88K1qb2YjfjecmJGONCEBwLrjytY5p
         HRpDMoViGrdAoxWEk5uie1c+izunjB+O3jkje9mWb6sqjvHq5KDG4Cy5XGeMu7kHnNpO
         6ipGXHkyq9LZnEkMXSwymEDMv7s1lLOixHr+r0C+gH4NHANKt8epdKH97aPcuGe3dthh
         gnL8ALQLNZBD+dmQ3+PEDa5OagRRWndBFeFgdwvJrVXhiXG3Ed8wluWuxuccMtqfrsBI
         A7Zw==
X-Gm-Message-State: AO0yUKVybWgktT/GQzI3/R3TEi07GYsXO3N+yH4Sd3lSf4dRT4YY3dFh
        WBMkDk5P0y/vqrG7OFt11EZOGq1Q0eR/C+CdsNnosGKWydn2aERFe9N1ZWA492yXLkVNJQJc5xM
        N64lhTNQ1Pj14ZoVNBTXffTbPU/zbvRObMVXeCmemms5BcLhQty/go3Rg5HYPxbiukA==
X-Google-Smtp-Source: AK7set/na8FLmR3HRtWtdWgJzoG1aLZFn+IW8/UVY9Mo9icHQKU2nH6xusQQPQYqQDcRH/faaYiDbKDRife/e4k=
X-Received: from barleywine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3bd4])
 (user=calvinwan job=sendgmr) by 2002:a63:935a:0:b0:4cd:1e13:2866 with SMTP id
 w26-20020a63935a000000b004cd1e132866mr790927pgm.117.1675793843804; Tue, 07
 Feb 2023 10:17:23 -0800 (PST)
Date:   Tue,  7 Feb 2023 18:17:04 +0000
In-Reply-To: <20230117193041.708692-1-calvinwan@google.com>
Mime-Version: 1.0
References: <20230117193041.708692-1-calvinwan@google.com>
X-Mailer: git-send-email 2.39.1.519.gcb327c4b5f-goog
Message-ID: <20230207181706.363453-6-calvinwan@google.com>
Subject: [PATCH v7 5/7] diff-lib: refactor out diff_change logic
From:   Calvin Wan <calvinwan@google.com>
To:     git@vger.kernel.org
Cc:     Calvin Wan <calvinwan@google.com>, avarab@gmail.com,
        chooglen@google.com, newren@gmail.com, jonathantanmy@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Refactor out logic that sets up the diff_change call into a helper
function for a future patch.

Signed-off-by: Calvin Wan <calvinwan@google.com>
---
 diff-lib.c | 46 +++++++++++++++++++++++++++++-----------------
 1 file changed, 29 insertions(+), 17 deletions(-)

diff --git a/diff-lib.c b/diff-lib.c
index dec040c366..7101cfda3f 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -88,6 +88,31 @@ static int match_stat_with_submodule(struct diff_options *diffopt,
 	return changed;
 }
 
+static int diff_change_helper(struct diff_options *options,
+	      unsigned newmode, unsigned dirty_submodule,
+	      int changed, struct index_state *istate,
+	      struct cache_entry *ce)
+{
+	unsigned int oldmode;
+	const struct object_id *old_oid, *new_oid;
+
+	if (!changed && !dirty_submodule) {
+		ce_mark_uptodate(ce);
+		mark_fsmonitor_valid(istate, ce);
+		if (!options->flags.find_copies_harder)
+			return 1;
+	}
+	oldmode = ce->ce_mode;
+	old_oid = &ce->oid;
+	new_oid = changed ? null_oid() : &ce->oid;
+	diff_change(options, oldmode, newmode,
+			old_oid, new_oid,
+			!is_null_oid(old_oid),
+			!is_null_oid(new_oid),
+			ce->name, 0, dirty_submodule);
+	return 0;
+}
+
 int run_diff_files(struct rev_info *revs, unsigned int option)
 {
 	int entries, i;
@@ -105,11 +130,10 @@ int run_diff_files(struct rev_info *revs, unsigned int option)
 		diff_unmerged_stage = 2;
 	entries = istate->cache_nr;
 	for (i = 0; i < entries; i++) {
-		unsigned int oldmode, newmode;
+		unsigned int newmode;
 		struct cache_entry *ce = istate->cache[i];
 		int changed;
 		unsigned dirty_submodule = 0;
-		const struct object_id *old_oid, *new_oid;
 
 		if (diff_can_quit_early(&revs->diffopt))
 			break;
@@ -245,21 +269,9 @@ int run_diff_files(struct rev_info *revs, unsigned int option)
 			newmode = ce_mode_from_stat(ce, st.st_mode);
 		}
 
-		if (!changed && !dirty_submodule) {
-			ce_mark_uptodate(ce);
-			mark_fsmonitor_valid(istate, ce);
-			if (!revs->diffopt.flags.find_copies_harder)
-				continue;
-		}
-		oldmode = ce->ce_mode;
-		old_oid = &ce->oid;
-		new_oid = changed ? null_oid() : &ce->oid;
-		diff_change(&revs->diffopt, oldmode, newmode,
-			    old_oid, new_oid,
-			    !is_null_oid(old_oid),
-			    !is_null_oid(new_oid),
-			    ce->name, 0, dirty_submodule);
-
+		if (diff_change_helper(&revs->diffopt, newmode, dirty_submodule,
+				       changed, istate, ce))
+			continue;
 	}
 	diffcore_std(&revs->diffopt);
 	diff_flush(&revs->diffopt);
-- 
2.39.1.519.gcb327c4b5f-goog

