Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E90FF1F45F
	for <e@80x24.org>; Wed,  8 May 2019 15:54:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727780AbfEHPx5 (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 May 2019 11:53:57 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:41748 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727695AbfEHPxz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 May 2019 11:53:55 -0400
Received: by mail-ed1-f65.google.com with SMTP id m4so22540128edd.8
        for <git@vger.kernel.org>; Wed, 08 May 2019 08:53:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Xs0dnuZT2HlSNFfGJN34jFbb8FsInMLoBcXOCQalhbA=;
        b=tzjIp61xuH+On6Pm3gCwAfOdtFS9kucNfelwD1tF6CFQDuVhmju0zk4Z3LWSrwp1G5
         spbB8a9kbM+dhvVPJ7FvrXxQf9oEph20suX7kEgXjsq/ZhhLOU5vErO95NNNjphQTaeY
         0fmu2wT9l6dLGJMaqTDKnuwVLBjXgZ3zjXpayo1ywu6uTmTnngLbLjVcjkt2GiJ0rCwH
         J49/Lo4qNYJfUINPut0HxjKySi3o6zBd8WduR8TSqjbPOymQazfnN4hWMh65O8jylESk
         wCMdMdhQ88WXH9yf+ZiYn2wq9vCR51J7S7euxvcpc+ftDENEqRrnm2wt7zlpHeH7Y9oT
         UWmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Xs0dnuZT2HlSNFfGJN34jFbb8FsInMLoBcXOCQalhbA=;
        b=XXQMIWhRWm4nvEIKg05agdtQoDajYsnabdy2lmT4LPCCAhOHU2ZoOse7NXBJLW4I0S
         Tw9NdAfKENjEB9bav0XGlbXGLnuHVc6eaYki0XAXMqUWonmtqo9bMNKFUHIpGbz77pa7
         4nYCwsF9uRqj7n11ntQpymUVovRIwUS/g8fdlHJ9z8uzK1E9OoOLgwvEV9lv3o5gnIrz
         Jtzq1jgEUQBppgio9/8mScXycQaCwaZ/ZRvQUEyx/A/PJzahMOli4U3SQtgoB+r7dxd9
         158kq1QHHhvwLmCwkHAfCCybxmwRIlbyBC7Niv+0eslVWfu8DcCG3xohboL3s0VFnH5Y
         tJNQ==
X-Gm-Message-State: APjAAAXWbrpBPWfdPm6Dnw/3nntxuTDr7IHSN5fs/VSrhPnqyrY+vGmQ
        AtFHjiBsAbUmNXemXZQ1YSWvEVamnks=
X-Google-Smtp-Source: APXvYqx1Uk/ARHf+eI6AMbNk1cKcuISTDYJRRBhLTNg1PAu8lxSpsnEPPvW81yVwQ52tfW+HDZ9O9g==
X-Received: by 2002:a17:906:5fd7:: with SMTP id k23mr30058764ejv.201.1557330833777;
        Wed, 08 May 2019 08:53:53 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e35sm5348315eda.2.2019.05.08.08.53.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 May 2019 08:53:53 -0700 (PDT)
Date:   Wed, 08 May 2019 08:53:53 -0700 (PDT)
X-Google-Original-Date: Wed, 08 May 2019 15:53:36 GMT
Message-Id: <cf792d38ed8c6315b209f5a3c8b9dd010ff572a5.1557330827.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.184.git.gitgitgadget@gmail.com>
References: <pull.184.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 07/17] commit-graph: extract fill_oids_from_commit_hex()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     peff@peff.net, avarab@gmail.com, git@jeffhostetler.com,
        jrnieder@google.com, steadmon@google.com,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

The write_commit_graph() method is too complex, so we are
extracting methods one by one.

Extract fill_oids_from_commit_hex() that reads the given commit
id list and fille the oid list in the context.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 commit-graph.c | 72 ++++++++++++++++++++++++++++----------------------
 1 file changed, 40 insertions(+), 32 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index 80c7069aaa..fb25280df1 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -912,6 +912,44 @@ static int fill_oids_from_packs(struct write_commit_graph_context *ctx,
 	return 0;
 }
 
+static void fill_oids_from_commit_hex(struct write_commit_graph_context *ctx,
+				      struct string_list *commit_hex)
+{
+	uint32_t i;
+	struct strbuf progress_title = STRBUF_INIT;
+
+	if (ctx->report_progress) {
+		strbuf_addf(&progress_title,
+			    Q_("Finding commits for commit graph from %d ref",
+			       "Finding commits for commit graph from %d refs",
+			       commit_hex->nr),
+			    commit_hex->nr);
+		ctx->progress = start_delayed_progress(
+					progress_title.buf,
+					commit_hex->nr);
+	}
+	for (i = 0; i < commit_hex->nr; i++) {
+		const char *end;
+		struct object_id oid;
+		struct commit *result;
+
+		display_progress(ctx->progress, i + 1);
+		if (commit_hex->items[i].string &&
+		    parse_oid_hex(commit_hex->items[i].string, &oid, &end))
+			continue;
+
+		result = lookup_commit_reference_gently(ctx->r, &oid, 1);
+
+		if (result) {
+			ALLOC_GROW(ctx->oids.list, ctx->oids.nr + 1, ctx->oids.alloc);
+			oidcpy(&ctx->oids.list[ctx->oids.nr], &(result->object.oid));
+			ctx->oids.nr++;
+		}
+	}
+	stop_progress(&ctx->progress);
+	strbuf_release(&progress_title);
+}
+
 int write_commit_graph(const char *obj_dir,
 		       struct string_list *pack_indexes,
 		       struct string_list *commit_hex,
@@ -965,38 +1003,8 @@ int write_commit_graph(const char *obj_dir,
 			goto cleanup;
 	}
 
-	if (commit_hex) {
-		if (ctx->report_progress) {
-			strbuf_addf(&progress_title,
-				    Q_("Finding commits for commit graph from %d ref",
-				       "Finding commits for commit graph from %d refs",
-				       commit_hex->nr),
-				    commit_hex->nr);
-			ctx->progress = start_delayed_progress(
-						progress_title.buf,
-						commit_hex->nr);
-		}
-		for (i = 0; i < commit_hex->nr; i++) {
-			const char *end;
-			struct object_id oid;
-			struct commit *result;
-
-			display_progress(ctx->progress, i + 1);
-			if (commit_hex->items[i].string &&
-			    parse_oid_hex(commit_hex->items[i].string, &oid, &end))
-				continue;
-
-			result = lookup_commit_reference_gently(ctx->r, &oid, 1);
-
-			if (result) {
-				ALLOC_GROW(ctx->oids.list, ctx->oids.nr + 1, ctx->oids.alloc);
-				oidcpy(&ctx->oids.list[ctx->oids.nr], &(result->object.oid));
-				ctx->oids.nr++;
-			}
-		}
-		stop_progress(&ctx->progress);
-		strbuf_reset(&progress_title);
-	}
+	if (commit_hex)
+		fill_oids_from_commit_hex(ctx, commit_hex);
 
 	if (!pack_indexes && !commit_hex) {
 		if (ctx->report_progress)
-- 
gitgitgadget

