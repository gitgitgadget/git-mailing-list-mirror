Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAC24C433EF
	for <git@archiver.kernel.org>; Mon, 28 Feb 2022 13:53:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236796AbiB1Nyc (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Feb 2022 08:54:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234281AbiB1Ny1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Feb 2022 08:54:27 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF48441303
        for <git@vger.kernel.org>; Mon, 28 Feb 2022 05:53:47 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id r187-20020a1c2bc4000000b003810e6b192aso6093739wmr.1
        for <git@vger.kernel.org>; Mon, 28 Feb 2022 05:53:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=oDE4QNW/5aFqi9CIDpcte7lNYk/6m0lvjDtvQYQ2WJQ=;
        b=UBsQhZnVbkQ+I4xDjljZ5w4UJjRBJPWLwp7ySya/UIWoMQPXFGBC2i5CROchv6sJhs
         XUCTLHrRei4MXHfXl/Tfi5UKiZeCMNtAOnEN649iGiVj/q+vcjf3r9Ufyu7bHQQgghHH
         T6rZRcmZbIBeRgg7XBuaRiXyJmu8Mpi1y8IJkm3F7YlwaM6UBbnYq8btsX/C2L5cXUv2
         fNfhW9GoKtduTzw5brMLoP+OjtuOz9Zm6KbeBNhTuNFMZJCNAD2LpllHCDd157T5LRdm
         qr/uISOpx+8jbmKX1ptcJGg2e3aGGeMo8g74TxUQA0oTuJEVcnPJer/eM4EmeHdMpgrE
         /EKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=oDE4QNW/5aFqi9CIDpcte7lNYk/6m0lvjDtvQYQ2WJQ=;
        b=V7kXVxHKpO2PdRRNHVbqCjt9JAi8yiXk1N/WK5jYQ7XUoArVl2dwgITlaJvGjR7083
         qYEq5B8Rpjnb9bKC/jDAGIl2WpILi5yxeKHuyqI15YO7LEjLUe/DhRbYjU7e+9ba3CUR
         Ug/cSDnzpIroK/YeYamQDHlro2NTI42oCwEM+307WpBth1qGHHuVuQEQ3OeNF5DtIAqK
         0zisgOZjV9RDFeV+DjjdnN3RNlhGqyXMm+LU/PG1hb6Wh8dxG9wwoYm54IKLPjTjYZDE
         nUmmTqRb4M61pvLkcE8KeAd2b6ptHcraeqfAaFezzLfhwQBpjlmZtKNKNl89DTAdD/6o
         fnug==
X-Gm-Message-State: AOAM531/l3togY4LlBohC1SQDSRmMakSzeYXpuNMw0xjqWoynq/x8qhL
        DeroTlPmxJqaIYnBOpjyU7w7nfsBZv8=
X-Google-Smtp-Source: ABdhPJzNKQD/TtjhwjkQz23cojERR4mBOZv4vk2vZzoDzwER+vA9fn/HSeF0sFv2g4ZeQAfgKp5oMQ==
X-Received: by 2002:a05:600c:42c4:b0:380:da32:26e3 with SMTP id j4-20020a05600c42c400b00380da3226e3mr13612240wme.142.1646056426249;
        Mon, 28 Feb 2022 05:53:46 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v20-20020a7bcb54000000b0037fa63db8aasm14563001wmj.5.2022.02.28.05.53.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Feb 2022 05:53:45 -0800 (PST)
Message-Id: <cbcbf10e6994d469abc5463d08165e6a2ba73153.1646056423.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1163.v2.git.1646056423.gitgitgadget@gmail.com>
References: <pull.1163.git.1645735117.gitgitgadget@gmail.com>
        <pull.1163.v2.git.1646056423.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 28 Feb 2022 13:53:41 +0000
Subject: [PATCH v2 2/4] commit-graph: fix ordering bug in generation numbers
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

When computing the generation numbers for a commit-graph, we compute
the corrected commit dates and then check if their offsets from the
actual dates is too large to fit in the 32-bit Generation Data chunk.
However, there is a problem with this approach: if we have parsed the
generation data from the previous commit-graph, then we continue the
loop because the corrected commit date is already computed. This causes
an under-count in the number of overflow values.

It is incorrect to add an increment to num_generation_data_overflows
next to this 'continue' statement, because we might start
double-counting commits that are computed because of the depth-first
search walk from a commit with an earlier OID.

Instead, iterate over the full commit list at the end, checking the
offsets to see how many grow beyond the maximum value.

Update a test in t5318 to use a larger time value, which will help
demonstrate this bug in more cases. It still won't hit all potential
cases until the next change, which reenables reading generation numbers.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 commit-graph.c          | 10 +++++++---
 t/t5318-commit-graph.sh |  4 ++--
 2 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index 265c010122e..a19bd96c2ee 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -1556,12 +1556,16 @@ static void compute_generation_numbers(struct write_commit_graph_context *ctx)
 				if (current->date && current->date > max_corrected_commit_date)
 					max_corrected_commit_date = current->date - 1;
 				commit_graph_data_at(current)->generation = max_corrected_commit_date + 1;
-
-				if (commit_graph_data_at(current)->generation - current->date > GENERATION_NUMBER_V2_OFFSET_MAX)
-					ctx->num_generation_data_overflows++;
 			}
 		}
 	}
+
+	for (i = 0; i < ctx->commits.nr; i++) {
+		struct commit *c = ctx->commits.list[i];
+		timestamp_t offset = commit_graph_data_at(c)->generation - c->date;
+		if (offset > GENERATION_NUMBER_V2_OFFSET_MAX)
+			ctx->num_generation_data_overflows++;
+	}
 	stop_progress(&ctx->progress);
 }
 
diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
index 2b05026cf6d..f9bffe38013 100755
--- a/t/t5318-commit-graph.sh
+++ b/t/t5318-commit-graph.sh
@@ -467,10 +467,10 @@ test_expect_success 'warn on improper hash version' '
 	)
 '
 
-test_expect_success 'lower layers have overflow chunk' '
+test_expect_success TIME_IS_64BIT,TIME_T_IS_64BIT 'lower layers have overflow chunk' '
 	cd "$TRASH_DIRECTORY/full" &&
 	UNIX_EPOCH_ZERO="@0 +0000" &&
-	FUTURE_DATE="@2147483646 +0000" &&
+	FUTURE_DATE="@4147483646 +0000" &&
 	rm -f .git/objects/info/commit-graph &&
 	test_commit --date "$FUTURE_DATE" future-1 &&
 	test_commit --date "$UNIX_EPOCH_ZERO" old-1 &&
-- 
gitgitgadget

