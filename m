Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F131C6FD1D
	for <git@archiver.kernel.org>; Wed, 15 Mar 2023 17:46:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232679AbjCORqv (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Mar 2023 13:46:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232237AbjCORqZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Mar 2023 13:46:25 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCF2F113C1
        for <git@vger.kernel.org>; Wed, 15 Mar 2023 10:45:55 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id j19-20020a05600c191300b003eb3e1eb0caso1584674wmq.1
        for <git@vger.kernel.org>; Wed, 15 Mar 2023 10:45:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678902347;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tP+3SWSR2sc0gnbxgUHoUFsEM9juLjWHmzj1WESClb4=;
        b=Y0e0/5t7U9K3yOXssPx5GXSzVBYxYhO4KlGMax7u9wXlgBrHFpH94CxOR1Re6LbDOe
         eHHL6qz6/ZsBVYaq1iEMuu7Gqp0PRfvrwZ8kCCZdghjfvVZyPtctx+d49ot+U8DGY9Y2
         8OU+7/nqP+JGJQPXHtQRbiftYo8CqZ4XUXRx/UrmBK7ng+i8Vl3m7saiIuU0dda0H/P+
         fAMOqNLQaeIHmKkQIpH5XNWGhIOL3cpjzFpOZD1nQ+f0AG3GqRMknd6+dyg0bZJ3JK63
         fSV/IeG9pkn9Atcz9OHU6xQ5vq3pCJQGtEMcNsvG9rqmasRT1bsGDRUTkjOK6Jlgv3y+
         jvUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678902347;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tP+3SWSR2sc0gnbxgUHoUFsEM9juLjWHmzj1WESClb4=;
        b=TdtRrVoi1Up2B2c1WxeBOiTVRRi8m/8K3zBvI5NrZfjteQkEfm88huPj9y6tFussLO
         iafCpd0yt/UOwPdoQGVb2L8FvE+zUbMO7nuKKFXgqjG1QS3ztJpk2cSK9WDqd1I58E+t
         3GH0rktRha5et0Cu42qh/s3YVTvpb7T0QMvMdI1j+KS6liRg8CHZw/ErbBWQbo8JZ0JQ
         6EyQh8i9fxhI93TPsgOnjxNb5IG0b+Wo0OpQhSAvJMjW/fBaIBe3rd6tY1BNBDsQ1JA7
         HWJPACOp6/l/vnhey6waoxnY6uxHcpGn6MyGGRYIWC/T05SHQN0Fii9AWEtpaC0UNBIg
         KrJQ==
X-Gm-Message-State: AO0yUKUmC981stB/b9ieGV0OX9iVw1Gdho+2mnHl1rYqohw8EsSj4Wqy
        AwKCwfApSkzGgEvV8Jp1BNgNEcqvlTU=
X-Google-Smtp-Source: AK7set8rMLnLORMfeo9VFMkcFOhZv3T/e+IWmOEa0TjteCspk6bzGthfJW7c3x/AfQTgfOE26LoukQ==
X-Received: by 2002:a05:600c:470b:b0:3ed:38e7:af59 with SMTP id v11-20020a05600c470b00b003ed38e7af59mr1792363wmo.39.1678902347432;
        Wed, 15 Mar 2023 10:45:47 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e4-20020a05600c4e4400b003e8f0334db8sm2643224wmq.5.2023.03.15.10.45.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 10:45:47 -0700 (PDT)
Message-Id: <abd3e7a67beb80ef687253ddb8bb5fe7a769357f.1678902343.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1489.v3.git.1678902343.gitgitgadget@gmail.com>
References: <pull.1489.v2.git.1678468863.gitgitgadget@gmail.com>
        <pull.1489.v3.git.1678902343.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 15 Mar 2023 17:45:39 +0000
Subject: [PATCH v3 4/8] commit-graph: return generation from memory
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, me@ttaylorr.com, vdye@github.com,
        Jeff King <peff@peff.net>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Derrick Stolee <derrickstolee@github.com>,
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

