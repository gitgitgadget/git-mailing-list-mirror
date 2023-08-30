Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CC04C83F23
	for <git@archiver.kernel.org>; Wed, 30 Aug 2023 18:29:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231254AbjH3S3W (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Aug 2023 14:29:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343749AbjH3QoS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Aug 2023 12:44:18 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE67019A
        for <git@vger.kernel.org>; Wed, 30 Aug 2023 09:44:15 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-58fc448ee4fso78587327b3.2
        for <git@vger.kernel.org>; Wed, 30 Aug 2023 09:44:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693413855; x=1694018655; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=8C8CUra17YXt4XMBvPMnKmKa95IXpXdnkc3dMK/9kuI=;
        b=tHv2NhmihkkkOceQAgNPdFbQZenTOHmfXAc5J37k2eIcgHTRIks1zDVUxuM5o5ZIMm
         88zZNJDo/mQBCmum2Ox0v99mmWsu8/pTbIf5Y2jlkeqJjUz/WMuOJvTsNpadG99j1Uxt
         7mbFGMypwhzXLE/w3m1LtpB8z3nzOgh7Db+x1GPwVbex9x+jzf90eVs/EnTebWOyOqOj
         L38Nh7HbF0E2eQgApp2rppbqXYNBgg+BW/9sfDPN1Dfeg6dMwvvDYVLUgQjOwkJx1hiB
         tD/WF4p8JntC40nWwFhEoQXWUqRvZLB/CkVRCfoyOO2DcPRZR8p6NDOoB39V3aEQmn/g
         zcxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693413855; x=1694018655;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8C8CUra17YXt4XMBvPMnKmKa95IXpXdnkc3dMK/9kuI=;
        b=NNpluswxcGIIK8kIArw0FYgJcnWkhRtd2ZlWMg/J0znB7EG2GzLtKFfDA0hULE0dBz
         urOfh7cmTgXCaBY+Nd7NbT+hvxElMrnN3S/d4boxM9/EYRh9JAllWB50QHxcIk0llmCF
         KgyEBGTjA6MoEr966ktH1I4UNjVo8aK1An8ZhrdvQOZeyTONT1xFrN4dwE/V/lizLnqr
         g56wvu+Zzb1WYJ5SQuKXVL3cc4tktAQRzEgonReaRqZfiblyFcF4fJmkfahNOWF/WGuF
         xduzjoyCIW4sTjs6b8veS40pD8fmTld07Q72JjU9M7ywHdf9RCaE2vw1e3DwNxxwTmhu
         v2PQ==
X-Gm-Message-State: AOJu0Yxo8Mu088LMo5ojUdLT5WkokBt/E0MgZq1GFc120JkQrCrGykk7
        apUo5AfCd7phVLYZR5CV6ZnYnyCTR8QAGCYZtRJX1LWwwfErCV+84/Ghddkbqbu0vA6SAduADzm
        VXmJvQqQyVatGrjPEGB7E21zNOzMRWlqdOwd+aPvi0pHojXzwt70xJJ5Ug83iu2hKEQMMHnCzUw
        ze
X-Google-Smtp-Source: AGHT+IFfQv+DTPaoDOfsszO/DCxj54LHO3FSXkEmVk6EfoZS3lyq8ES5yplc3aS4qizXHDJyEzbFqhFNfzNeB/HyAbyc
X-Received: from jonathantanmy0.svl.corp.google.com ([2620:15c:2d3:204:2899:32d6:b7e3:8e6e])
 (user=jonathantanmy job=sendgmr) by 2002:a81:a9c5:0:b0:584:41b7:30e7 with
 SMTP id g188-20020a81a9c5000000b0058441b730e7mr82486ywh.0.1693413855169; Wed,
 30 Aug 2023 09:44:15 -0700 (PDT)
Date:   Wed, 30 Aug 2023 09:43:48 -0700
In-Reply-To: <cover.1693413637.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1692654233.git.me@ttaylorr.com> <cover.1693413637.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.42.0.rc2.253.gd59a3bf2b4-goog
Message-ID: <a5bf23a7d303a2d16d3d75205bfc12d0149945ca.1693413637.git.jonathantanmy@google.com>
Subject: [PATCH v2 08/15] bloom: annotate filters with hash version
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

In subsequent commits, we will want to load existing Bloom filters out
of a commit-graph, even when the hash version they were computed with
does not match the value of `commitGraph.changedPathVersion`.

In order to differentiate between the two, add a "version" field to each
Bloom filter.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 bloom.c | 11 ++++++++---
 bloom.h |  1 +
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/bloom.c b/bloom.c
index ebef5cfd2f..9b6a30f6f6 100644
--- a/bloom.c
+++ b/bloom.c
@@ -55,6 +55,7 @@ int load_bloom_filter_from_graph(struct commit_graph *g,
 	filter->data = (unsigned char *)(g->chunk_bloom_data +
 					sizeof(unsigned char) * start_index +
 					BLOOMDATA_CHUNK_HEADER_SIZE);
+	filter->version = g->bloom_filter_settings->hash_version;
 
 	return 1;
 }
@@ -240,11 +241,13 @@ static int pathmap_cmp(const void *hashmap_cmp_fn_data UNUSED,
 	return strcmp(e1->path, e2->path);
 }
 
-static void init_truncated_large_filter(struct bloom_filter *filter)
+static void init_truncated_large_filter(struct bloom_filter *filter,
+					int version)
 {
 	filter->data = xmalloc(1);
 	filter->data[0] = 0xFF;
 	filter->len = 1;
+	filter->version = version;
 }
 
 struct bloom_filter *get_or_compute_bloom_filter(struct repository *r,
@@ -329,13 +332,15 @@ struct bloom_filter *get_or_compute_bloom_filter(struct repository *r,
 		}
 
 		if (hashmap_get_size(&pathmap) > settings->max_changed_paths) {
-			init_truncated_large_filter(filter);
+			init_truncated_large_filter(filter,
+						    settings->hash_version);
 			if (computed)
 				*computed |= BLOOM_TRUNC_LARGE;
 			goto cleanup;
 		}
 
 		filter->len = (hashmap_get_size(&pathmap) * settings->bits_per_entry + BITS_PER_WORD - 1) / BITS_PER_WORD;
+		filter->version = settings->hash_version;
 		if (!filter->len) {
 			if (computed)
 				*computed |= BLOOM_TRUNC_EMPTY;
@@ -355,7 +360,7 @@ struct bloom_filter *get_or_compute_bloom_filter(struct repository *r,
 	} else {
 		for (i = 0; i < diff_queued_diff.nr; i++)
 			diff_free_filepair(diff_queued_diff.queue[i]);
-		init_truncated_large_filter(filter);
+		init_truncated_large_filter(filter, settings->hash_version);
 
 		if (computed)
 			*computed |= BLOOM_TRUNC_LARGE;
diff --git a/bloom.h b/bloom.h
index 138d57a86b..330a140520 100644
--- a/bloom.h
+++ b/bloom.h
@@ -55,6 +55,7 @@ struct bloom_filter_settings {
 struct bloom_filter {
 	unsigned char *data;
 	size_t len;
+	int version;
 };
 
 /*
-- 
2.42.0.rc2.253.gd59a3bf2b4-goog

