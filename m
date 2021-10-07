Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 121DDC433F5
	for <git@archiver.kernel.org>; Thu,  7 Oct 2021 21:15:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EAD9361058
	for <git@archiver.kernel.org>; Thu,  7 Oct 2021 21:15:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235284AbhJGVRr (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Oct 2021 17:17:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233929AbhJGVRl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Oct 2021 17:17:41 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B61D9C061764
        for <git@vger.kernel.org>; Thu,  7 Oct 2021 14:15:47 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id v25so23045141wra.2
        for <git@vger.kernel.org>; Thu, 07 Oct 2021 14:15:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=nEih7G58FeXZR7VfCiUcLv0bmQevEM54qXiHHW/Vpvo=;
        b=ozBHfKP3Xxaby73C2wHvd6XMm7+bzgzsfxgR1swh7E2WoSodQBjaM/U2WtnWLdcShV
         sqDwB/AAVpE4TmIlzeH++/bUiB39AI+WgG9irsLZdn5mIN3rgwFcaDAJL0TV7ZMQIo5P
         F+25ydHNJn3wZKKQB2geXPKG2j4viUrEXECEnZDOISLo9KBzt/QbetfSYJc4EqqZVkCm
         pDT96iuEU2UOx04YkxmSV8sJZFyT3p4GDCSuchQWj3JAqhPqE5Ph5iZVsRPQHH6DTzEi
         ZZHjvydUmS53prZTqdMpB5zOPFR04SQ5ILxeJZa8X68Qdkn/5JOvj1OnoahGGV0upmXn
         pRXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=nEih7G58FeXZR7VfCiUcLv0bmQevEM54qXiHHW/Vpvo=;
        b=IAY5N9bbhQECm8i+xduUbDNO/Hgkfw5xa66v9QWAAdhAXvsaWWDj+kpOn4ZVPH4CdB
         T7KSx/vyOLEoSVntkY39L8UWee7kY7xeKKz23KfhP/0ioC6Jg8wAhJF910fBQq9GfKQs
         Ws673ll5hhy1CGx7Tmawq93JFA6HVpP7edWRQmhhFRXcQAOyOQJPaKl8aw9J44ywxVsx
         32ohyl1KnF0/Vg788M+E6LdakBr7P/eMfkd7nI/+WVQMFP6TZmw4JpjCJAlxMAKfeUtS
         Bp8DZ2RNTdCsMmgblMIqTI09K5QiRHrfs5bV8wqPa72WXhNmMIjWxic723z0nHRie/k7
         4OEg==
X-Gm-Message-State: AOAM533a8KZbPIIDCEE4RQQpDYqi4u3W6JfwBTA89kbzsiOqtkGBNc34
        5bvKlhkFTZJAt35UBV9gEvKzl9Q9YYU=
X-Google-Smtp-Source: ABdhPJxvizPGvkd9Wh9g7rN12oAy8t4MjBjwIDs0EyXa6yKXXGXp3LBe9GSykBmHAOmJx+q/gxOq5A==
X-Received: by 2002:a1c:7e04:: with SMTP id z4mr19054227wmc.95.1633641346204;
        Thu, 07 Oct 2021 14:15:46 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y6sm450462wro.63.2021.10.07.14.15.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Oct 2021 14:15:45 -0700 (PDT)
Message-Id: <c7145e039f3644339ba47296f4bad15aafc6b17a.1633641339.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1048.v3.git.1633641339.gitgitgadget@gmail.com>
References: <pull.1048.v2.git.1633440057.gitgitgadget@gmail.com>
        <pull.1048.v3.git.1633641339.gitgitgadget@gmail.com>
From:   "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 07 Oct 2021 21:15:38 +0000
Subject: [PATCH v3 8/8] unpack-trees: improve performance of next_cache_entry
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     stolee@gmail.com, gitster@pobox.com, newren@gmail.com,
        Taylor Blau <me@ttaylorr.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Victoria Dye <vdye@github.com>,
        Victoria Dye <vdye@github.com>
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
(unpack-trees: preserve cache_bottom, 2021-07-14)). Therefore, to retain the
benefit `cache_bottom` provides in non-sparse index cases, a separate `hint`
position indicates the first position `next_cache_entry` should search,
updated each execution with a new position.

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
