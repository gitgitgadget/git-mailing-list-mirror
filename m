Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7B93C433F5
	for <git@archiver.kernel.org>; Tue,  5 Oct 2021 13:21:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D4D0161090
	for <git@archiver.kernel.org>; Tue,  5 Oct 2021 13:21:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235030AbhJENXD (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 Oct 2021 09:23:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234983AbhJENWz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Oct 2021 09:22:55 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD3C8C061749
        for <git@vger.kernel.org>; Tue,  5 Oct 2021 06:21:03 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id p21so6636661wmq.1
        for <git@vger.kernel.org>; Tue, 05 Oct 2021 06:21:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=2HRlxeP3tz/uNY5+unoDO9/v7e3CHEEqIbEgAsKvEsY=;
        b=OWNRDww1IBqNcEJLodYknz4ejxx44n1r1OgP+zY6fJzpWoAeQecEWkGSw/oI4Y1UMG
         036qqtQ9eTqs3KoC5hADJ3qWOmDuzIqpiYrYmkJeVLLt7WXjXkLC2e7r3CNYe3TIn7Sg
         OfHSgA1pNf2cwY5UkiHZIDiRYby51e4umLLA3a+AD9WYJqSTn3GO3qHihbaKTG71lTFL
         KNzuq5rWg6A09Z4fp6slfvCSjdWXqB0BdQEuPQCc9lJL7BTBtGdujtsPe62katm2ACPo
         jXV9UdAHlo/Q6vfKisWpKxFN1y5RMoNCIyTuq6LgEnsjK5CPR0twZsKxjp2jS0vr4mGH
         kUbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=2HRlxeP3tz/uNY5+unoDO9/v7e3CHEEqIbEgAsKvEsY=;
        b=gQnuzJTGJS/MyQkZwy2g4eRxrK5QZHPk/1y9yz9eVhk5DSOz7wo4iQRNDRBi7/A3mp
         Xq7bP2RZCu05gJ8j39279bsmD4A7KKoSqh6hPVP834mED1RE0umT2OuoVzeo8MMAnhGP
         lYgT81dQteq8h7d+B2KEtI52Gnng18YvFNiemaebsaiPIxB20/KquqIRNvuYVL+Mokyo
         Vks8Utm7Ei0Ys9xHbDFZTFFwC8SFr230MjfXZs4lRTZZLhjRXcZLjwfS7l1WB/jY2s65
         47c1eVEtVIXmHihvCDYoTIImMoFrlDCE7m3gR0lcXxluNv9MKMcElWGvzP+LJpDlr6Oo
         mU3w==
X-Gm-Message-State: AOAM533YhrSddF1bOyMuMEIxq5m0/1bFMoObxW8bnI/04TO8AWphtbfn
        CpJUOyMtJkzedCoPRvCjwf1qdQH9q4Q=
X-Google-Smtp-Source: ABdhPJwbryv3r8lybsPmtRrJpCr3X4p6qQ0nN9F39ui7VySIw3LjDyXMzCvIVo7gvblSFZnUYJfJmA==
X-Received: by 2002:a1c:7f11:: with SMTP id a17mr3398257wmd.166.1633440062535;
        Tue, 05 Oct 2021 06:21:02 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t12sm14638556wrw.12.2021.10.05.06.21.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Oct 2021 06:21:02 -0700 (PDT)
Message-Id: <aa963eefae75d41983201e24398bc5692267b91b.1633440057.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1048.v2.git.1633440057.gitgitgadget@gmail.com>
References: <pull.1048.git.1633013461.gitgitgadget@gmail.com>
        <pull.1048.v2.git.1633440057.gitgitgadget@gmail.com>
From:   "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 05 Oct 2021 13:20:57 +0000
Subject: [PATCH v2 7/7] unpack-trees: improve performance of next_cache_entry
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     stolee@gmail.com, gitster@pobox.com, newren@gmail.com,
        Taylor Blau <me@ttaylorr.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Victoria Dye <vdye@github.com>, Victoria Dye <vdye@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Victoria Dye <vdye@github.com>

To find the first non-unpacked cache entry, `next_cache_entry` iterates
through index, starting at `cache_bottom`. The performance of this in full
indexes is helped by `cache_bottom` advancing with each invocation of
`mark_ce_used` (called by `unpack_index_entry`). However, the presence of
sparse directories can prevent the `cache_bottom` from advancing in a sparse
index case, effectively forcing `next_cache_entry` to search from the
beginning of the index each time it is called.

The `cache_bottom` must be preserved for the sparse index (see 17a1bb570b
(unpack-trees: preserve cache_bottom, 2021-07-14)).  Therefore, to retain
the benefit `cache_bottom` provides in non-sparse index cases, a separate
`hint` position indicates the first position `next_cache_entry` should
search, updated each execution with a new position.  The performance of `git
reset -- does-not-exist` (testing the "worst case" in which all entries in
the index are unpacked with `next_cache_entry`) is significantly improved
for the sparse index case:

Test          before            after
------------------------------------------------------
(full-v3)     0.79(0.38+0.30)   0.91(0.43+0.34) +15.2%
(full-v4)     0.80(0.38+0.29)   0.85(0.40+0.35) +6.2%
(sparse-v3)   0.76(0.43+0.69)   0.44(0.08+0.67) -42.1%
(sparse-v4)   0.71(0.40+0.65)   0.41(0.09+0.65) -42.3%

Signed-off-by: Victoria Dye <vdye@github.com>
---
 unpack-trees.c | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/unpack-trees.c b/unpack-trees.c
index 8ea0a542da8..b94733de6be 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -645,17 +645,24 @@ static void mark_ce_used_same_name(struct cache_entry *ce,
 	}
 }
 
-static struct cache_entry *next_cache_entry(struct unpack_trees_options *o)
+static struct cache_entry *next_cache_entry(struct unpack_trees_options *o, int *hint)
 {
 	const struct index_state *index = o->src_index;
 	int pos = o->cache_bottom;
 
+	if (*hint > pos)
+		pos = *hint;
+
 	while (pos < index->cache_nr) {
 		struct cache_entry *ce = index->cache[pos];
-		if (!(ce->ce_flags & CE_UNPACKED))
+		if (!(ce->ce_flags & CE_UNPACKED)) {
+			*hint = pos + 1;
 			return ce;
+		}
 		pos++;
 	}
+
+	*hint = pos;
 	return NULL;
 }
 
@@ -1365,12 +1372,13 @@ static int unpack_callback(int n, unsigned long mask, unsigned long dirmask, str
 
 	/* Are we supposed to look at the index too? */
 	if (o->merge) {
+		int hint = -1;
 		while (1) {
 			int cmp;
 			struct cache_entry *ce;
 
 			if (o->diff_index_cached)
-				ce = next_cache_entry(o);
+				ce = next_cache_entry(o, &hint);
 			else
 				ce = find_cache_entry(info, p);
 
@@ -1690,7 +1698,7 @@ static int verify_absent(const struct cache_entry *,
 int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options *o)
 {
 	struct repository *repo = the_repository;
-	int i, ret;
+	int i, hint, ret;
 	static struct cache_entry *dfc;
 	struct pattern_list pl;
 	int free_pattern_list = 0;
@@ -1763,13 +1771,15 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
 		info.pathspec = o->pathspec;
 
 		if (o->prefix) {
+			hint = -1;
+
 			/*
 			 * Unpack existing index entries that sort before the
 			 * prefix the tree is spliced into.  Note that o->merge
 			 * is always true in this case.
 			 */
 			while (1) {
-				struct cache_entry *ce = next_cache_entry(o);
+				struct cache_entry *ce = next_cache_entry(o, &hint);
 				if (!ce)
 					break;
 				if (ce_in_traverse_path(ce, &info))
@@ -1790,8 +1800,9 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
 
 	/* Any left-over entries in the index? */
 	if (o->merge) {
+		hint = -1;
 		while (1) {
-			struct cache_entry *ce = next_cache_entry(o);
+			struct cache_entry *ce = next_cache_entry(o, &hint);
 			if (!ce)
 				break;
 			if (unpack_index_entry(ce, o) < 0)
-- 
gitgitgadget
