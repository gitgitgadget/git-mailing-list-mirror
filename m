Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF210C6FD1D
	for <git@archiver.kernel.org>; Mon, 20 Mar 2023 11:27:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231150AbjCTL13 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Mar 2023 07:27:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229925AbjCTL1K (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Mar 2023 07:27:10 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7179565B9
        for <git@vger.kernel.org>; Mon, 20 Mar 2023 04:27:03 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id j24so1069995wrd.0
        for <git@vger.kernel.org>; Mon, 20 Mar 2023 04:27:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679311621;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=phli6c0KvFlEOLWT6ac0nc3wr3Jb+y2NaXDRHce8eIs=;
        b=h8T2o9p11jGrp6a8hVVjWs50Mo11Sbe05+Wm/mL2zNK+9Jo1oWSKdz3gIZRKYTajGh
         ZyZzrpj1JxiEcf+r22mSmLo1iuLORT5RFElKHM/66kkCMKbNIHnpw0Ex9pa4jMlzRYH3
         cBSkBwHlmfhBXoXtIGUb8OVcsGx4xrhhWnW8YFnyGW7bertG+kJZ1YDuIgtQGkcxKAet
         ZIBoLxRg6iGe/CytGt1ALm8QBl0bFf8KhfGgK+IYhz37MtO2eG1qkmstMXx945Vq1/yi
         ktNTrexxcPzv2vaiiqeM5f9yxsnP/bcLjZ59pxm32xfNdGgsoyZuw2w21ffNRF9DPSOj
         DnHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679311621;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=phli6c0KvFlEOLWT6ac0nc3wr3Jb+y2NaXDRHce8eIs=;
        b=V9uEP4w+KcfhUk5eDzWlFm8fP6CN9+O3ShnXf1Ov/er0IO5+9YYXqbcCu2+a7Vywn/
         Tb4uRpLcE+6igqFqlyk1H0NRYrxXV9pyiPhxsJZqZD4nhsHwoVvzMLvoYrmM2Y8ZUC5G
         pX2sc1UzLOxkoKo0XLfIUuOQa5Y3LgTwERSIfrBnqZrG3/PjgeX8uj2tYVoXoSVfELpA
         Ghf7DN6VKDWOCgL/CEtDgH8HWKLBD56qg6UTFAxfdJiFGcNxcu4uFLjdo279iUNTvvkv
         jADLbED/qMrp4tbE9dOOhkOAuKLw0bBuxLzKYYm7dU59uxusD7jlYsBWnD00Lg8IVtRV
         oATw==
X-Gm-Message-State: AO0yUKWJBGQY+elbybTwmWsJ6KKUU0m0kRjMx4CHvYvjgNloKI+YTUjG
        KrZd73mhCreCR2lF3+g/EaDvSYWzvqY=
X-Google-Smtp-Source: AK7set+XFQnC+1loUEQRHwjZ7wyGRXVqAdrTFT4z2mI1NChBjJTtXxgXnCmCqB42Kk5DgpidFBKVcQ==
X-Received: by 2002:a5d:6949:0:b0:2d1:7ade:aac with SMTP id r9-20020a5d6949000000b002d17ade0aacmr11824028wrw.0.1679311621071;
        Mon, 20 Mar 2023 04:27:01 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f18-20020adff452000000b002c5d3f0f737sm8701264wrp.30.2023.03.20.04.27.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Mar 2023 04:27:00 -0700 (PDT)
Message-Id: <fed76f0f08ea42af6f6207c49e8801d867d01313.1679311616.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1489.v4.git.1679311615.gitgitgadget@gmail.com>
References: <pull.1489.v3.git.1678902343.gitgitgadget@gmail.com>
        <pull.1489.v4.git.1679311615.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 20 Mar 2023 11:26:51 +0000
Subject: [PATCH v4 5/9] commit-graph: return generation from memory
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, me@ttaylorr.com, vdye@github.com,
        Jeff King <peff@peff.net>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Jonathan Tan <jonathantanmy@google.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

The commit_graph_generation() method used to report a value of
GENERATION_NUMBER_INFINITY if the commit_graph_data_slab had an instance
for the given commit but the graph_pos indicated the commit was not in
the commit-graph file.

However, an upcoming change will introduce the ability to set generation
values in-memory without writing the commit-graph file. Thus, we can no
longer trust 'graph_pos' to indicate whether or not the generation
member can be trusted.

Instead, trust the 'generation' member if the commit has a value in the
slab _and_ the 'generation' member is non-zero. Otherwise, treat it as
GENERATION_NUMBER_INFINITY.

This only makes a difference for a very old case for the commit-graph:
the very first Git release to write commit-graph files wrote zeroes in
the topological level positions. If we are parsing a commit-graph with
all zeroes, those commits will now appear to have
GENERATION_NUMBER_INFINITY (as if they were not parsed from the
commit-graph).

I attempted several variations to work around the need for providing an
uninitialized 'generation' member, but this was the best one I found. It
does require a change to a verification test in t5318 because it reports
a different error than the one about non-zero generation numbers.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 commit-graph.c          | 8 +++-----
 t/t5318-commit-graph.sh | 2 +-
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index d1c98681e88..63a56483cf6 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -116,12 +116,10 @@ timestamp_t commit_graph_generation(const struct commit *c)
 	struct commit_graph_data *data =
 		commit_graph_data_slab_peek(&commit_graph_data_slab, c);
 
-	if (!data)
-		return GENERATION_NUMBER_INFINITY;
-	else if (data->graph_pos == COMMIT_NOT_FROM_GRAPH)
-		return GENERATION_NUMBER_INFINITY;
+	if (data && data->generation)
+		return data->generation;
 
-	return data->generation;
+	return GENERATION_NUMBER_INFINITY;
 }
 
 static struct commit_graph_data *commit_graph_data_at(const struct commit *c)
diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
index 049c5fc8ead..b6e12115786 100755
--- a/t/t5318-commit-graph.sh
+++ b/t/t5318-commit-graph.sh
@@ -630,7 +630,7 @@ test_expect_success 'detect incorrect generation number' '
 
 test_expect_success 'detect incorrect generation number' '
 	corrupt_graph_and_verify $GRAPH_BYTE_COMMIT_GENERATION "\01" \
-		"non-zero generation number"
+		"commit-graph generation for commit"
 '
 
 test_expect_success 'detect incorrect commit date' '
-- 
gitgitgadget

