Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F133FC433FE
	for <git@archiver.kernel.org>; Tue,  1 Mar 2022 19:50:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237461AbiCATuo (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Mar 2022 14:50:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237536AbiCATuU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Mar 2022 14:50:20 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED7A858E6C
        for <git@vger.kernel.org>; Tue,  1 Mar 2022 11:49:12 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id q7-20020a7bce87000000b00382255f4ca9so1363472wmj.2
        for <git@vger.kernel.org>; Tue, 01 Mar 2022 11:49:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=61m4XDoLYC6T0oD6FkGBetkfkc/04h98VYKs/QcSYyY=;
        b=lynnvt/FqF13/1mSAj32xyifmDyjbOY5OiUBTYWv5vulaxdOjQ1xtLDPQfS+QVtjUa
         lSO4UNW0G9F/WYKyId3dDmp7BSlN70coPmVQ5EL+RPmZRPmsKzSRQIuCKcFbA5YGOf2H
         jl3kovS0mNlt+ocHMkbTH4ZFq5wTe38B7x/qQvGVbV4MZjOHHrFBjssM6fadYQQ48lXw
         8p6PdmRHVaEmNK62GnuKYQB7bi0crrFyiND+tyfC0jBkEi7N/6eUR8OP2i75JO8qD95V
         C9bmx4RmeNAMLiYWQjHsOG9t/pYho+ulPc1dZJyqwO0xeqnt43zk3wSJOEYI4pvSk23F
         Px6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=61m4XDoLYC6T0oD6FkGBetkfkc/04h98VYKs/QcSYyY=;
        b=3LeyzSFBpweoJuJN7+GH0clkWOzgaL1BTrvAaO8g1XD22pP9ZlH5ZOeOoMD4qrwjIP
         l8rfiiuBUdfeehSCBneKAvGq+IywRVTI5z5hkOj3SPQxcn8nfPIpW2nTE8i3tkBQTEqQ
         fLRmlMCgmxIqC0aMr3dvyuP9L/S0FH39oBZpqTsiykeQ997dpXKFuzVrqSgwY9VINxSr
         80NFCmu1RHnxeIsoCA2d8b9fWfN1HSmMKZUoS5f1hjonRlEfnESVDojfvozhX0Zf9crZ
         pI8PyWwJoqPahlvxl3F6RHUJdxFaFhjsluXKj0RKqAhLBisU3VWR2UfMI9aokQG148p7
         UlIA==
X-Gm-Message-State: AOAM533yPHtZyCiboT9ctslDw2d7dwUBpJBR1pit/GEPdqtcLaWFS3pf
        deqvMN41lLHB0d/SEt/xeEx4m9ItJx8=
X-Google-Smtp-Source: ABdhPJwBy71IqhmWCwhXHGJRbgglRFVG8EwX3mw0maBN88NXkSZIRBvELOnJVp3LMNNoA8PzFvy4YQ==
X-Received: by 2002:a7b:c455:0:b0:380:a646:eb0e with SMTP id l21-20020a7bc455000000b00380a646eb0emr17905468wmi.170.1646164118070;
        Tue, 01 Mar 2022 11:48:38 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m3-20020a5d6243000000b001e33760776fsm14533911wrv.10.2022.03.01.11.48.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Mar 2022 11:48:37 -0800 (PST)
Message-Id: <e957baa9d77873239ab0e0056138fd490f029f5c.1646164112.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1163.v3.git.1646164112.gitgitgadget@gmail.com>
References: <pull.1163.v2.git.1646056423.gitgitgadget@gmail.com>
        <pull.1163.v3.git.1646164112.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 01 Mar 2022 19:48:32 +0000
Subject: [PATCH v3 5/5] commit-graph: fix generation number v2 overflow values
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     me@ttaylorr.com, gitster@pobox.com, abhishekkumar8222@gmail.com,
        avarab@gmail.com, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

The Generation Data Chunk was implemented and tested in e8b63005c
(commit-graph: implement generation data chunk, 2021-01-16), but the
test was carefully constructed to work on systems with 32-bit dates.
Since the corrected commit date offsets still required more than 31
bits, this triggered writing the generation_data_overflow chunk.

However, upon closer look, the
write_graph_chunk_generation_data_overflow() method writes the offsets
to the chunk (as dictated by the format) but fill_commit_graph_info()
treats the value in the chunk as if it is the full corrected commit date
(not an offset). For some reason, this does not cause an issue when
using the FUTURE_DATE specified in t5318-commit-graph.sh, but it does
show up as a failure in 'git commit-graph verify' if we increase that
FUTURE_DATE to be above four billion.

Fix this error and create a 64-bit timestamp version of the test so we
can test these larger values.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 commit-graph.c                     |  2 +-
 t/t5328-commit-graph-64bit-time.sh | 27 +++++++++++++++++++++++++++
 2 files changed, 28 insertions(+), 1 deletion(-)

diff --git a/commit-graph.c b/commit-graph.c
index 8e52bb09552..b86a6a634fe 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -806,7 +806,7 @@ static void fill_commit_graph_info(struct commit *item, struct commit_graph *g,
 				die(_("commit-graph requires overflow generation data but has none"));
 
 			offset_pos = offset ^ CORRECTED_COMMIT_DATE_OFFSET_OVERFLOW;
-			graph_data->generation = get_be64(g->chunk_generation_data_overflow + 8 * offset_pos);
+			graph_data->generation = item->date + get_be64(g->chunk_generation_data_overflow + 8 * offset_pos);
 		} else
 			graph_data->generation = item->date + offset;
 	} else
diff --git a/t/t5328-commit-graph-64bit-time.sh b/t/t5328-commit-graph-64bit-time.sh
index 28114bcaf47..093f0c067af 100755
--- a/t/t5328-commit-graph-64bit-time.sh
+++ b/t/t5328-commit-graph-64bit-time.sh
@@ -36,4 +36,31 @@ test_expect_success 'lower layers have overflow chunk' '
 
 graph_git_behavior 'overflow' '' HEAD~2 HEAD
 
+test_expect_success 'set up and verify repo with generation data overflow chunk' '
+	mkdir repo &&
+	cd repo &&
+	git init &&
+	test_commit --date "$UNIX_EPOCH_ZERO" 1 &&
+	test_commit 2 &&
+	test_commit --date "$UNIX_EPOCH_ZERO" 3 &&
+	git commit-graph write --reachable &&
+	graph_read_expect 3 generation_data &&
+	test_commit --date "$FUTURE_DATE" 4 &&
+	test_commit 5 &&
+	test_commit --date "$UNIX_EPOCH_ZERO" 6 &&
+	git branch left &&
+	git reset --hard 3 &&
+	test_commit 7 &&
+	test_commit --date "$FUTURE_DATE" 8 &&
+	test_commit 9 &&
+	git branch right &&
+	git reset --hard 3 &&
+	test_merge M left right &&
+	git commit-graph write --reachable &&
+	graph_read_expect 10 "generation_data generation_data_overflow" &&
+	git commit-graph verify
+'
+
+graph_git_behavior 'overflow 2' repo left right
+
 test_done
-- 
gitgitgadget
