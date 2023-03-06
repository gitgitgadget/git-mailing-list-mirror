Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28796C678D4
	for <git@archiver.kernel.org>; Mon,  6 Mar 2023 14:07:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231139AbjCFOHj (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Mar 2023 09:07:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230348AbjCFOHS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Mar 2023 09:07:18 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C201F25E38
        for <git@vger.kernel.org>; Mon,  6 Mar 2023 06:06:51 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id l7-20020a05600c4f0700b003e79fa98ce1so5262169wmq.2
        for <git@vger.kernel.org>; Mon, 06 Mar 2023 06:06:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678111603;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yp3Iyv77kMPOfk15oV0GgT+x6zh09VJd0pKm+NeiPD4=;
        b=MVvVJmNQJDb87lrRN+JmXxlmOanQOstEO6h0UW88VW4045jMRzF6QqkUE3RVIGCCT/
         g+KvpAIk0T7DEQakeUzppRJxX1/oGZyuMoRCiLljFV7Bni2RjC8y0M6xvkCLcF0asm3w
         D81zJYshzYgj4TF1qCgm/GI0W+Dcgoi9GzbieSuWdsjGKWbLAiqTbfSOFhPpEHMgoYOR
         tgVXCYow4jT8hcKeh1cVWxQmSI1T7QZG2SUdnimvm89lpnEXzxC9VP/OgEnq95tq9Exw
         cupnNMXj+vc8nFhxqn/GoOYj/yx2y0sQwQI9jPM/4XGxf9aqxe9OkNg8HuSkGcqZ7CpP
         RNSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678111603;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Yp3Iyv77kMPOfk15oV0GgT+x6zh09VJd0pKm+NeiPD4=;
        b=WGzpLDqf9SQ3MyiKZljhEh4SyQqVKYGo91Q3SfUQzblF6jACUNtrAGy+USREEgJ4lm
         QKi3bFtqebBdOF+HFAQGMcmmA/bykRKNWIwCp6due+M2JpcBBjUwbYFixh7qvNCu48TN
         iiOp8yP3KHy7nrowPirjegdnEM/tqQYQIwMFVtftGOkJ3bTa5fcn18ZaOqJ8QjM4GFmO
         bZwP5M8vxHfza5F1TEADqQVLY5tx+RHyIbcMVw9c82cAxpDQylzSLxuHjvrWCW2fTi4m
         ab+0m/xCyOfwhjBjtT7FC4xKCDBpNgmbc7exEWwkcXRqknHQbV4cma954APz8nOJzQuH
         ICMg==
X-Gm-Message-State: AO0yUKXgWmxrDhqt60B8oeY5zEFC0+YfOXiVnvuy2RGwo3wBZp6ZJDam
        1afQ4771EeN8LNdNKqvH0e8hcgXRhRk=
X-Google-Smtp-Source: AK7set9GwSJq9f3Yqcf1rZ65p4lG/H/o/KsLKJmfzjWDQOXp6UvZvDpaAZ2+tFRM8kjsxEyGUtFBWg==
X-Received: by 2002:a05:600c:3b16:b0:3eb:5990:aea4 with SMTP id m22-20020a05600c3b1600b003eb5990aea4mr10438336wms.12.1678111603114;
        Mon, 06 Mar 2023 06:06:43 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h22-20020a05600c351600b003daf6e3bc2fsm21075097wmq.1.2023.03.06.06.06.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Mar 2023 06:06:42 -0800 (PST)
Message-Id: <c6e6581e0ea8717520f6116c7136d6d084589e94.1678111599.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1489.git.1678111598.gitgitgadget@gmail.com>
References: <pull.1489.git.1678111598.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 06 Mar 2023 14:06:35 +0000
Subject: [PATCH 5/8] commit-graph: return generation from memory
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, me@ttaylorr.com, vdye@github.com,
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
 commit-graph.c          | 9 ++++-----
 t/t5318-commit-graph.sh | 2 +-
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index deccf984a0d..f04b02be1bb 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -111,17 +111,16 @@ uint32_t commit_graph_position(const struct commit *c)
 	return data ? data->graph_pos : COMMIT_NOT_FROM_GRAPH;
 }
 
+
 timestamp_t commit_graph_generation(const struct commit *c)
 {
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

