Return-Path: <SRS0=DNVg=EI=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95177C4742C
	for <git@archiver.kernel.org>; Mon,  2 Nov 2020 20:44:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E1B12071A
	for <git@archiver.kernel.org>; Mon,  2 Nov 2020 20:44:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WJ4ChSdX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727140AbgKBUoK (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Nov 2020 15:44:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726881AbgKBUoB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Nov 2020 15:44:01 -0500
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A83C3C061A04
        for <git@vger.kernel.org>; Mon,  2 Nov 2020 12:44:01 -0800 (PST)
Received: by mail-oi1-x243.google.com with SMTP id c21so1038687oic.1
        for <git@vger.kernel.org>; Mon, 02 Nov 2020 12:44:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IR2/n85Xwj+gaLo7lHLgG8yfkiGkvuF41MAa2z6PnYA=;
        b=WJ4ChSdXJSSfLYFBCZ98VWNY+m6iGkeLx2Udzk0s/eEmXHDoIThJSCsxOm457glurj
         vkM5DpGdqwYo2u0q97YW0oLldpjfS5TZ8Y3zvIVO1JJ/ghcJQ54HLXkM1qufCHvNP3Ni
         YbdfWLDP0oM8V7YqwR/ns23mr2xxysa8j/UkK64iDQOriDtgKP9/w+Z6fJXMMshcKwwU
         c3/OHQecJhAPCIaTfm3+jL57dyomnuHmCmUoBooX33lBsBPjVUBVn3eyu7VEfdsOjEKS
         B2oDNtJVFLEYB6a0EAxyPi7oNIgL84WYLEpUMiGqIYSxm/HdP2U/yz3deIZSnYdt3OwB
         HsNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IR2/n85Xwj+gaLo7lHLgG8yfkiGkvuF41MAa2z6PnYA=;
        b=gjIMAK2EVhKHZatsTWVi8fSdYGkFL5vQeaDlioBulOuWJQ+7PxVB+LgpQ0W6NlxEX/
         0fw5B/NoRgfS7srJBuDbYScFdodZQemBI8VMkZuTLjshOnG4eokK9mAIEWcpOCTBx06V
         e2vN/i+He0tbYERoxVMBzDGW0iSPxrIZZ4Ym74N/1aUnPyt33/YXfSkk5IYPm0xyyZtF
         G6BrhedCzHhgXdAopOp66mkDq1fMGtldrcj5cWRRh+Or+0JKuS3EGHS1HlTBl5qCtmCe
         89u/wvWIbIiSluAx6916yrcGYRFuMmo7Akeepg6ZFreCEkzuIXkIS3FErxjGR3LqaXK7
         E8ZQ==
X-Gm-Message-State: AOAM530R/V5cOSPdvIr9pFzx8xmthy5AKJ6O56F0ZzH6Vc1EA4FpY8sm
        3/pMzM9szhCR37B0ALLTa6bV7YyexAHeAA==
X-Google-Smtp-Source: ABdhPJy7J9WmEFihu+Z+toPoRky8Kbps2Nc/lH4uGm0xwicpvNx1PsXP0p0YDdr0WQpmytcFddsMQQ==
X-Received: by 2002:aca:5dc5:: with SMTP id r188mr11603504oib.120.1604349840780;
        Mon, 02 Nov 2020 12:44:00 -0800 (PST)
Received: from tiger.attlocal.net ([2602:30a:2c28:20f0:7c1a:85e3:2ea9:5d7e])
        by smtp.gmail.com with ESMTPSA id t27sm3848512otc.14.2020.11.02.12.43.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 12:44:00 -0800 (PST)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>
Subject: [PATCH v2 11/20] merge-ort: add a preliminary simple process_entries() implementation
Date:   Mon,  2 Nov 2020 12:43:35 -0800
Message-Id: <20201102204344.342633-12-newren@gmail.com>
X-Mailer: git-send-email 2.29.0.471.ga4f56089c0
In-Reply-To: <20201102204344.342633-1-newren@gmail.com>
References: <20201102204344.342633-1-newren@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a process_entries() implementation that just loops over the paths
and processes each one individually with an auxiliary process_entry()
call.  Add a basic process_entry() as well, which handles several cases
but leaves a few of the more involved ones with die-not-implemented
messages.  Also, although process_entries() is supposed to create a
tree, it does not yet have code to do so -- except in the special case
of merging completely empty trees.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-ort.c | 106 +++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 105 insertions(+), 1 deletion(-)

diff --git a/merge-ort.c b/merge-ort.c
index 9900fa1bf8..92bbdc7255 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -323,10 +323,114 @@ static int detect_and_process_renames(struct merge_options *opt,
 	return clean;
 }
 
+/* Per entry merge function */
+static void process_entry(struct merge_options *opt,
+			  const char *path,
+			  struct conflict_info *ci)
+{
+	assert(!ci->merged.clean);
+	assert(ci->filemask >= 0 && ci->filemask <= 7);
+
+	if (ci->filemask == 0) {
+		/*
+		 * This is a placeholder for directories that were recursed
+		 * into; nothing to do in this case.
+		 */
+		return;
+	}
+
+	if (ci->df_conflict) {
+		die("Not yet implemented.");
+	}
+
+	/*
+	 * NOTE: Below there is a long switch-like if-elseif-elseif... block
+	 *       which the code goes through even for the df_conflict cases
+	 *       above.  Well, it will once we don't die-not-implemented above.
+	 */
+	if (ci->match_mask) {
+		ci->merged.clean = 1;
+		if (ci->match_mask == 6) {
+			/* stages[1] == stages[2] */
+			ci->merged.result.mode = ci->stages[1].mode;
+			oidcpy(&ci->merged.result.oid, &ci->stages[1].oid);
+		} else {
+			/* determine the mask of the side that didn't match */
+			unsigned int othermask = 7 & ~ci->match_mask;
+			int side = (othermask == 4) ? 2 : 1;
+
+			ci->merged.is_null = (ci->filemask == ci->match_mask);
+			ci->merged.result.mode = ci->stages[side].mode;
+			oidcpy(&ci->merged.result.oid, &ci->stages[side].oid);
+
+			assert(othermask == 2 || othermask == 4);
+			assert(ci->merged.is_null == !ci->merged.result.mode);
+		}
+	} else if (ci->filemask >= 6 &&
+		   (S_IFMT & ci->stages[1].mode) !=
+		   (S_IFMT & ci->stages[2].mode)) {
+		/*
+		 * Two different items from (file/submodule/symlink)
+		 */
+		die("Not yet implemented.");
+	} else if (ci->filemask >= 6) {
+		/*
+		 * TODO: Needs a two-way or three-way content merge, but we're
+		 * just being lazy and copying the version from HEAD and
+		 * leaving it as conflicted.
+		 */
+		ci->merged.clean = 0;
+		ci->merged.result.mode = ci->stages[1].mode;
+		oidcpy(&ci->merged.result.oid, &ci->stages[1].oid);
+	} else if (ci->filemask == 3 || ci->filemask == 5) {
+		/* Modify/delete */
+		die("Not yet implemented.");
+	} else if (ci->filemask == 2 || ci->filemask == 4) {
+		/* Added on one side */
+		int side = (ci->filemask == 4) ? 2 : 1;
+		ci->merged.result.mode = ci->stages[side].mode;
+		oidcpy(&ci->merged.result.oid, &ci->stages[side].oid);
+		ci->merged.clean = !ci->df_conflict && !ci->path_conflict;
+	} else if (ci->filemask == 1) {
+		/* Deleted on both sides */
+		ci->merged.is_null = 1;
+		ci->merged.result.mode = 0;
+		oidcpy(&ci->merged.result.oid, &null_oid);
+		ci->merged.clean = !ci->path_conflict;
+	}
+
+	/*
+	 * If still unmerged, record it separately.  This allows us to later
+	 * iterate over just unmerged entries when updating the index instead
+	 * of iterating over all entries.
+	 */
+	if (!ci->merged.clean)
+		strmap_put(&opt->priv->unmerged, path, ci);
+}
+
 static void process_entries(struct merge_options *opt,
 			    struct object_id *result_oid)
 {
-	die("Not yet implemented.");
+	struct hashmap_iter iter;
+	struct strmap_entry *e;
+
+	if (strmap_empty(&opt->priv->paths)) {
+		oidcpy(result_oid, opt->repo->hash_algo->empty_tree);
+		return;
+	}
+
+	strmap_for_each_entry(&opt->priv->paths, &iter, e) {
+		/*
+		 * WARNING: If ci->merged.clean is true, then ci does not
+		 * actually point to a conflict_info but a struct merge_info.
+		 */
+		struct conflict_info *ci = e->value;
+
+		if (!ci->merged.clean)
+			process_entry(opt, e->key, e->value);
+	}
+
+	die("Tree creation not yet implemented");
 }
 
 void merge_switch_to_result(struct merge_options *opt,
-- 
2.29.0.471.ga4f56089c0

