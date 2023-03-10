Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D9F3C6FD1F
	for <git@archiver.kernel.org>; Fri, 10 Mar 2023 17:21:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231439AbjCJRVY (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Mar 2023 12:21:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230467AbjCJRVN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Mar 2023 12:21:13 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C5E5112A41
        for <git@vger.kernel.org>; Fri, 10 Mar 2023 09:21:10 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id m25-20020a7bcb99000000b003e7842b75f2so3920046wmi.3
        for <git@vger.kernel.org>; Fri, 10 Mar 2023 09:21:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678468868;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tP+3SWSR2sc0gnbxgUHoUFsEM9juLjWHmzj1WESClb4=;
        b=Jp/eawYyfrzZXOWoMNGzSDqLEwrd7vj5Vl0Kp69cr/dZv0KjhQLAIXPHMSrgn9CD9j
         GZmRqSrmH+EAOwkk6eMn5x/y2KXrQfM3J8tzZUOod6NFJPw6sLgwTvY074Q/QO+4Ktde
         qs2EIG99QmC+SnorS+CLvfdEY0YJulCENP1OtIBqPmzWVjTdVwlMRM8blulsm0gQ6V/Q
         fK44b19qL9NrmudN/Vbjo0TvbvJsplKno3U3zfxbBbbIlfR/WNbI/YZGJY9ES9h8pSXT
         DXMRIhZkFMgvYPUQopigY2kMtUkMOZ8pJl+zLN3XSsy8TZoJ5aQiV/MadglzqoTwhKLK
         WNzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678468868;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tP+3SWSR2sc0gnbxgUHoUFsEM9juLjWHmzj1WESClb4=;
        b=nEClsWRnbk99wa4T8pNcUSt2AzGi/Ar2j6XtIkELr5aoo/5gMx78FoKvqJhQ3ZnNbB
         4NAXZxQgtV433YWlBbAqATNwchVMwvy7qRHaNacjrf0WbgvWemHZcKIdzNdFIYXG2iXA
         m6SrAHwhkI+8PxjdUN6HmzA3hOvGwPKnVjpEhDVf77CCCSfCjsHJBABegDQmG+BlvsBX
         Z2SoP6EMFsrvOQQQSBTxEma5BxjNCr6ZaiA1pdfdpOhY0l3Sk1UCpaCXZXk5d3UpOsSu
         +xrezwg4U5wqh6MXgztYpjb+hwZBt67ZOXUeEpo0w8fooa9IcjCqgcRU//+EznIWJ22L
         roZA==
X-Gm-Message-State: AO0yUKUIzZZhqL7CzyuI2P5Sbl/G6FKYFrDwB7NCDeJNAej9YxkNMTL6
        6j+ZlSFe7aqp0hat3M7VKKkxQNJMMFE=
X-Google-Smtp-Source: AK7set+SW8zXJ+jU7FzPXiOFaRX/N3qsptS3GNFvKDVhzY8OCI1G3jaeLH9m8Ze6QkEbR3fyJC757w==
X-Received: by 2002:a05:600c:4712:b0:3eb:2b88:a69a with SMTP id v18-20020a05600c471200b003eb2b88a69amr3623852wmo.14.1678468868576;
        Fri, 10 Mar 2023 09:21:08 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c17-20020adffb11000000b002c592535839sm314838wrr.17.2023.03.10.09.21.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Mar 2023 09:21:08 -0800 (PST)
Message-Id: <3cf3380144347630137fece29dbc991d31ff3af2.1678468864.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1489.v2.git.1678468863.gitgitgadget@gmail.com>
References: <pull.1489.git.1678111598.gitgitgadget@gmail.com>
        <pull.1489.v2.git.1678468863.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 10 Mar 2023 17:20:59 +0000
Subject: [PATCH v2 4/8] commit-graph: return generation from memory
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, me@ttaylorr.com, vdye@github.com,
        Jeff King <peff@peff.net>,
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
 commit-graph.c          | 8 +++-----
 t/t5318-commit-graph.sh | 2 +-
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index deccf984a0d..b4da4e05067 100644
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

