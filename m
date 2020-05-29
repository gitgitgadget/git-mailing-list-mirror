Return-Path: <SRS0=mJAO=7L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE8DDC433DF
	for <git@archiver.kernel.org>; Fri, 29 May 2020 08:52:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9EAA520723
	for <git@archiver.kernel.org>; Fri, 29 May 2020 08:52:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KM1+DVSE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727037AbgE2Iv6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 May 2020 04:51:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727018AbgE2Ivv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 May 2020 04:51:51 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 558A8C08C5C8
        for <git@vger.kernel.org>; Fri, 29 May 2020 01:51:51 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id v19so2340592wmj.0
        for <git@vger.kernel.org>; Fri, 29 May 2020 01:51:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=utUv9LvPID6PTzOb9lGP8mk98660ET39XQtnFj1wxP8=;
        b=KM1+DVSEp/fzm4gIx8zdsY34+bUsnfP1aKv6TDxW6xrNVNceF/hFEhPmU5znhsrtSm
         cWuqSdQKwgHKwlMs2vt0WF3fL/U6i2+6tKCiEhfyPevkgItGrX2Dfzh7Ro8Bd5hwfhHm
         HAyZUNLVlnF7WjZWzlJL5W7XwYvb2nv9bR/9EPbnMhHMgLuQ7bQCH/seYdlmhHd4MHBU
         ZP9T8yt62oBmHeIsVo4s/D2cctKF2BdSyneFDiUy77sh2Z9F+w5V5AQC48XXo7aQ1Zmy
         dZ0u0Zoxmi8BPodkEuJKoDUlHMHuzZHouJpUySjDjBFM6DdtNtXIJko5VZISCSF+EW3Q
         vOpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=utUv9LvPID6PTzOb9lGP8mk98660ET39XQtnFj1wxP8=;
        b=NiHupPUXEAn9MpIxFiU2t7poZgALvgQ5+NVs9BqC3Ycnt+0At+r3wbBG/Am7GJpVjC
         rdc+X+dWjfTi8PRgstnlB43i1BRwwGLQkYGz6f+bXnVJOjxQkLYvGVVplCbSJ6CdkgK3
         ez0l0eJo2cdlP7t3Fsb7OLS0BbbPGr9PH9sWd2FOhMDmn5yeKct4kmyzOl+Nk1cPQYip
         VNewEpy63gOcss0E9Piepo3Yr0n99wZ5vW8aMHfUhpj3eyNJrriT89xMgQkzaMhV9Ca0
         W4SleRl0YgwoNGcpUWv3zeTTEpfDatV3cYkLGKv2r5xrCkcqC3u74mqxBPfOayI0h+YG
         OfUA==
X-Gm-Message-State: AOAM533rZS/8UxmrTs40D0iHu0ExuKB4272Q3HtW2rOm8DJIoMbuosVt
        HGXAuw8whaE9e8kJDKazzCWnkiuo
X-Google-Smtp-Source: ABdhPJyNDNiF/IhYWKlaaBlRf9wJuH3+TJe7JcywpC69eRrExfk8FfX2T8BEjXgIEf+yCq6kN5c4Bw==
X-Received: by 2002:a7b:c18a:: with SMTP id y10mr7917936wmi.73.1590742309726;
        Fri, 29 May 2020 01:51:49 -0700 (PDT)
Received: from localhost.localdomain (84-236-109-105.pool.digikabel.hu. [84.236.109.105])
        by smtp.gmail.com with ESMTPSA id f11sm3525255wrj.2.2020.05.29.01.51.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 May 2020 01:51:49 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Garima Singh <garima.singh@microsoft.com>,
        Derrick Stolee <stolee@gmail.com>,
        Jakub Narebski <jnareb@gmail.com>, Jeff King <peff@peff.net>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 34/34] commit-graph: use modified path Bloom filters with wildcards, if possible
Date:   Fri, 29 May 2020 10:50:38 +0200
Message-Id: <20200529085038.26008-35-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.27.0.rc1.431.g5c813f95dc
In-Reply-To: <20200529085038.26008-1-szeder.dev@gmail.com>
References: <20200529085038.26008-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Modified path Bloom filter don't store the names of modified paths,
they only set a couple of bits based on those paths' hashes.
Consequently, they can only be used when looking for the history of a
concrete path, so we disabled them when looking for pathspecs with
wildcards.

However, if the pathspec has "wildcard-less" leading directories, then
we can use modified path Bloom filters to skip commits that don't
modify those leading directories.  As a result, something like:

  git -c core.modifiedPathBloomFilters=1 rev-list HEAD -- 'compat/win32/pthread.*'

will take only ~0.045s instead of ~1.24s, achieving over 27x speedup.

For comparison, letting the shell do the wildcard matching, i.e. the
equivalent of using the pathspecs 'compat/win32/pthread.c' and
'compat/win32/pthread.h' takes ~0.311s without using modified path
Bloom filters: apparently tree-diff with wildcards can be considerably
more expensive that without wildcards, even if the wildcard is in the
last path component and that directory only contains a dozen files.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 commit-graph.c | 44 ++++++++++++++++++++++++++++++++++----------
 1 file changed, 34 insertions(+), 10 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index 8eb0cbedaf..db43877426 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -1023,9 +1023,9 @@ static void compute_modified_path_bloom_hashes_for_path(const char *path,
 void init_pathspec_bloom_fields(struct repository *r,
 				struct pathspec *pathspec)
 {
-	const unsigned bloom_compatible_magic = PATHSPEC_LITERAL;
+	const unsigned bloom_compatible_magic = PATHSPEC_LITERAL | PATHSPEC_GLOB;
 	struct commit_graph *graph = r->objects->commit_graph;
-	int i;
+	int i, can_use_modified_path_bloom_filters;
 
 	if (!graph)
 		return;
@@ -1033,15 +1033,14 @@ void init_pathspec_bloom_fields(struct repository *r,
 		return;
 	if (!pathspec->nr)
 		return;
-	if (pathspec->has_wildcard)
-		return;
 	if (pathspec->magic & ~bloom_compatible_magic)
 		return;
 
+	can_use_modified_path_bloom_filters = 1;
 	for (i = 0; i < pathspec->nr; i++) {
 		struct pathspec_item *pi = &pathspec->items[i];
 		const char *path = pi->match, *p;
-		size_t len = pi->len;
+		size_t nowildcard_len = pi->nowildcard_len;
 		int path_component_nr = 0, j;
 		uint32_t *hashes;
 		struct bloom_filter embedded_bf;
@@ -1051,14 +1050,29 @@ void init_pathspec_bloom_fields(struct repository *r,
 		 * slashes, but a trailing slash might still be present,
 		 * "remove" it.
 		 */
-		if (path[len - 1] == '/')
-			len--;
+		if (path[nowildcard_len - 1] == '/')
+			nowildcard_len--;
 
 		p = path;
 		do {
 			p = strchrnul(p + 1, '/');
-			path_component_nr++;
-		} while (p - path < len);
+			if (p - path <= nowildcard_len)
+				path_component_nr++;
+		} while (p - path < nowildcard_len);
+		/*
+		 * If a pathspec uses wildcards but has wildcard-less
+		 * leading directories, then we can use modified path Bloom
+		 * filters to skip commits that don't modify those leading
+		 * directories.
+		 * However, if there is even one pathspec that has a wilcard
+		 * in its first path component, then we have no choice but
+		 * to run tree-diff anyway, so don't bother with Bloom
+		 * filters at all in that case.
+		 */
+		if (!path_component_nr) {
+			can_use_modified_path_bloom_filters = 0;
+			break;
+		}
 
 		pi->modified_path_bloom_hashes_nr = path_component_nr * graph->num_modified_path_bloom_hashes;
 		ALLOC_ARRAY(pi->modified_path_bloom_hashes,
@@ -1084,7 +1098,17 @@ void init_pathspec_bloom_fields(struct repository *r,
 				      pi->modified_path_bloom_hashes_nr);
 	}
 
-	pathspec->can_use_modified_path_bloom_filters = 1;
+	if (can_use_modified_path_bloom_filters) {
+		pathspec->can_use_modified_path_bloom_filters = 1;
+	} else {
+		int j;
+		for (j = 0; j < i; j++) {
+			struct pathspec_item *pi = &pathspec->items[j];
+			FREE_AND_NULL(pi->modified_path_bloom_hashes);
+			pi->modified_path_bloom_hashes_nr = 0;
+			pi->modified_path_bloom_mask = 0;
+		}
+	}
 }
 
 struct packed_commit_list {
-- 
2.27.0.rc1.431.g5c813f95dc

