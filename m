Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3D7BC83F1D
	for <git@archiver.kernel.org>; Wed, 30 Aug 2023 18:29:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231889AbjH3S3d (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Aug 2023 14:29:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343750AbjH3QoU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Aug 2023 12:44:20 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DD2019A
        for <git@vger.kernel.org>; Wed, 30 Aug 2023 09:44:18 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-594e1154756so64397087b3.2
        for <git@vger.kernel.org>; Wed, 30 Aug 2023 09:44:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693413857; x=1694018657; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=4Jp/c5phBFct3TYWG4B5bYT8Dn2fmoiJY9/aSuGAeWE=;
        b=5juOe1Rh4Z8dgU33yWSW4Nm3WHzd9oTe4U3EGNVsq5Iwf737tus/A9UdLKqKlWLMgO
         tSbNvoWluG9haVCDK3rt88RLlNGYlRG333luk7fZnJ9g/QNyJ/XTqqL/yW2YFjowMBz0
         ROOAUNCEOelgaRMsst7d8EODQjYHMvxVGi/NIPup+RTJwYpizryVOeEKb6oYhDpbACU8
         Epv9qj0ietIdzX9ZM86W325LK9wvO6NMpjs3Zc4MbnogDVBQtWV3ZxlpFxc5UToSvTIF
         ezTYtGL4+7unoPBnOnhbBRqNjyXygYeeJXNKiDkNT/uwAzGRoPbfByyfX8t8LrmQYuXM
         SOWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693413857; x=1694018657;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4Jp/c5phBFct3TYWG4B5bYT8Dn2fmoiJY9/aSuGAeWE=;
        b=HH7UXG+BVQGDX4gOKO+/uCsx3zjOrIENF1OdXPUL4FeDRzvmIOIpnYqUo4hld/gU2K
         kwpKN61ys32GgRt4vbva8+ID6zBJ2LVD+7pfaX2OOa7xNMJQBI/5zfNSm/5thmxENe9i
         GyeDMKBEGeZAb6Z/UASsF3DK+d1df6DxSqshs628ydFImz9t9Ft2otvcQYvb1CVIZcV/
         PkO4IFWnICUoofqNdBCpXpdJK5DsjT19uEzMWKvr9Y36QtJJXBpcciECQXEDo0snPuQp
         V3kPsm1dPLuswPfuH3joPKM3iayxmx/yJLj6CsFbWij1ehKM59jwmlvs4eQfPbCTBLED
         DQUg==
X-Gm-Message-State: AOJu0Ywo1rwxykQ9UcI0RuCXSMXjx1GH8MCs1vXW+9145/bLPvtW/WkB
        kORckiPOO9WMymXAWcobdMUIzizO3Py5u+D4dewjpRuszX6o71S2oc7d70B5kWTcKUCHadU6XlS
        mwt1u0Fm6Ph8RZRcXW0F4Vldkr3A4Du52jrynFnFg94lEIFNa51dZtK/au2dEj1jZGYujq/FKqw
        3g
X-Google-Smtp-Source: AGHT+IGd21/ocXpGOm/J/mwsf8vBJLlVeQNrnTJ18jKT4kd2ve1J21UDNL8gEUpEJeHYY3khadMaeMlOps9cwjmCOBSR
X-Received: from jonathantanmy0.svl.corp.google.com ([2620:15c:2d3:204:2899:32d6:b7e3:8e6e])
 (user=jonathantanmy job=sendgmr) by 2002:a81:b188:0:b0:586:5d03:67c8 with
 SMTP id p130-20020a81b188000000b005865d0367c8mr89440ywh.3.1693413857268; Wed,
 30 Aug 2023 09:44:17 -0700 (PDT)
Date:   Wed, 30 Aug 2023 09:43:49 -0700
In-Reply-To: <cover.1693413637.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1692654233.git.me@ttaylorr.com> <cover.1693413637.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.42.0.rc2.253.gd59a3bf2b4-goog
Message-ID: <3de6cd8460de51c3d866b0df9c219dd985f7433f.1693413637.git.jonathantanmy@google.com>
Subject: [PATCH v2 09/15] bloom: prepare to discard incompatible Bloom filters
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        "SZEDER =?utf-8?B?R8OhYm9y?=" <szeder.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Taylor Blau <me@ttaylorr.com>

Callers use the inline `get_bloom_filter()` implementation as a thin
wrapper around `get_or_compute_bloom_filter()`. The former calls the
latter with a value of "0" for `compute_if_not_present`, making
`get_bloom_filter()` the default read-only path for fetching an existing
Bloom filter.

Callers expect the value returned from `get_bloom_filter()` is usable,
that is that it's compatible with the configured value corresponding to
`commitGraph.changedPathsVersion`.

This is OK, since the commit-graph machinery only initializes its BDAT
chunk (thereby enabling it to service Bloom filter queries) when the
Bloom filter hash_version is compatible with our settings. So any value
returned by `get_bloom_filter()` is trivially useable.

However, subsequent commits will load the BDAT chunk even when the Bloom
filters are built with incompatible hash versions. Prepare to handle
this by teaching `get_bloom_filter()` to discard filters that are
incompatible with the configured hash version.

Callers who wish to read incompatible filters (e.g., for upgrading
filters from v1 to v2) may use the lower level routine,
`get_or_compute_bloom_filter()`.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 bloom.c | 20 +++++++++++++++++++-
 bloom.h | 20 ++++++++++++++++++--
 2 files changed, 37 insertions(+), 3 deletions(-)

diff --git a/bloom.c b/bloom.c
index 9b6a30f6f6..739fa093ba 100644
--- a/bloom.c
+++ b/bloom.c
@@ -250,6 +250,23 @@ static void init_truncated_large_filter(struct bloom_filter *filter,
 	filter->version = version;
 }
 
+struct bloom_filter *get_bloom_filter(struct repository *r, struct commit *c)
+{
+	struct bloom_filter *filter;
+	int hash_version;
+
+	filter = get_or_compute_bloom_filter(r, c, 0, NULL, NULL);
+	if (!filter)
+		return NULL;
+
+	prepare_repo_settings(r);
+	hash_version = r->settings.commit_graph_changed_paths_version;
+
+	if (!(hash_version == -1 || hash_version == filter->version))
+		return NULL; /* unusable filter */
+	return filter;
+}
+
 struct bloom_filter *get_or_compute_bloom_filter(struct repository *r,
 						 struct commit *c,
 						 int compute_if_not_present,
@@ -275,7 +292,8 @@ struct bloom_filter *get_or_compute_bloom_filter(struct repository *r,
 						     filter, graph_pos);
 	}
 
-	if (filter->data && filter->len)
+	if ((filter->data && filter->len) &&
+	    (!settings || settings->hash_version == filter->version))
 		return filter;
 	if (!compute_if_not_present)
 		return NULL;
diff --git a/bloom.h b/bloom.h
index 330a140520..bfe389e29c 100644
--- a/bloom.h
+++ b/bloom.h
@@ -110,8 +110,24 @@ struct bloom_filter *get_or_compute_bloom_filter(struct repository *r,
 						 const struct bloom_filter_settings *settings,
 						 enum bloom_filter_computed *computed);
 
-#define get_bloom_filter(r, c) get_or_compute_bloom_filter( \
-	(r), (c), 0, NULL, NULL)
+/*
+ * Find the Bloom filter associated with the given commit "c".
+ *
+ * If any of the following are true
+ *
+ *   - the repository does not have a commit-graph, or
+ *   - the repository disables reading from the commit-graph, or
+ *   - the given commit does not have a Bloom filter computed, or
+ *   - there is a Bloom filter for commit "c", but it cannot be read
+ *     because the filter uses an incompatible version of murmur3
+ *
+ * , then `get_bloom_filter()` will return NULL. Otherwise, the corresponding
+ * Bloom filter will be returned.
+ *
+ * For callers who wish to inspect Bloom filters with incompatible hash
+ * versions, use get_or_compute_bloom_filter().
+ */
+struct bloom_filter *get_bloom_filter(struct repository *r, struct commit *c);
 
 int bloom_filter_contains(const struct bloom_filter *filter,
 			  const struct bloom_key *key,
-- 
2.42.0.rc2.253.gd59a3bf2b4-goog

