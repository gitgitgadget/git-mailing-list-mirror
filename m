Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D801B1F461
	for <e@80x24.org>; Sat, 17 Aug 2019 18:42:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726406AbfHQSmU (ORCPT <rfc822;e@80x24.org>);
        Sat, 17 Aug 2019 14:42:20 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:34947 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726362AbfHQSmQ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Aug 2019 14:42:16 -0400
Received: by mail-pg1-f193.google.com with SMTP id n4so4602456pgv.2
        for <git@vger.kernel.org>; Sat, 17 Aug 2019 11:42:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7VWzNJ897IQ/+Pe/a92f7onUVWLrqB8+tLQYZjmRZaM=;
        b=dOF85R31fYYGxFdvF9ms/QG/zmeRrRTSRy7BQOW+tMMDcBboP9BSDNcyDd1cFbGaD7
         WkVtEdi+MmH29jsZBa3mEB4Iz//PhgCj4dJz1YnCvrSNOchvSG9y6Xx2K0taf8l5eqaS
         TZ1UqsXhi2/rDikQhSErRXjoqPfbWH5aJWH+gysnVsUQ+McP7rmQNUlcU3Cug3UFpdqe
         nFYEG5f+jiChDBLp1uSgJUWoLNP315w5Kh7MifsC64KqP4YoUW86MT0cvmrMHR7aNIvf
         Qr0NHbzYxG+UhOoJbpR6O3QjQumHWLyRlAzbr+VQ9kIN2cZKkzVlvnmazLDtqIi1aq5i
         UUhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7VWzNJ897IQ/+Pe/a92f7onUVWLrqB8+tLQYZjmRZaM=;
        b=T58g57FIFwtK1pggzAdgN7WEpo0Y49VXJE3YvONZNz2AghmB9YJmHAQ8LTaVYfNgqS
         LLiLeLF/25+QWCg+LmhYhLPwzkiPdBhNuIDtF60r8N+wVA0XMHknnAHseKbppD2I3YWR
         nBVaefWnSmySPiFdsRYhQWt6xngPxkRnje6km9g6YKrNz15VL+Oc/T0kyTBqq85lRioI
         WB05v5gZk5XpyqWhhlK0RGpvnG3EtEc8uzzbG+DhoI3nNTjoZ7IaEbQe/eqbQgpDbWs/
         22w7msvyED7JLBuaSPHnFxpyEZFJn3s/QFu/5on6ZKj00mIxvEKL2KYVAbDjzqWl7IKo
         e6oA==
X-Gm-Message-State: APjAAAW1y2xF2gppvJgga5WmYqprfL8liZsQOn5/N8lPXJxEiYzO48xI
        VAWfUeHTDEyh88ZBE5MrHoB66TZx
X-Google-Smtp-Source: APXvYqxkTbF7ZvMAkBX6NTEzOmuI+TUCXtmC1qosS9oRWCG1pGlpjCXYVSrlDru1k6NxLCGGeFzU9A==
X-Received: by 2002:a63:b60b:: with SMTP id j11mr1697231pgf.283.1566067335146;
        Sat, 17 Aug 2019 11:42:15 -0700 (PDT)
Received: from newren2-linux.yojoe.local ([8.4.231.67])
        by smtp.gmail.com with ESMTPSA id j15sm9990422pfr.146.2019.08.17.11.42.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 17 Aug 2019 11:42:14 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH v4 15/24] merge-recursive: rename 'mrtree' to 'result_tree', for clarity
Date:   Sat, 17 Aug 2019 11:41:35 -0700
Message-Id: <20190817184144.32179-16-newren@gmail.com>
X-Mailer: git-send-email 2.23.0.rc2.28.g5f89f15d7b.dirty
In-Reply-To: <20190817184144.32179-1-newren@gmail.com>
References: <20190815214053.16594-1-newren@gmail.com>
 <20190817184144.32179-1-newren@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It is not at all clear what 'mr' was supposed to stand for, at least not
to me.  Pick a clearer name for this variable.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-recursive.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 32871132a6..1823a87706 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -3477,7 +3477,7 @@ static int merge_recursive_internal(struct merge_options *opt,
 {
 	struct commit_list *iter;
 	struct commit *merged_merge_bases;
-	struct tree *mrtree;
+	struct tree *result_tree;
 	int clean;
 	const char *ancestor_name;
 	struct strbuf merge_base_abbrev = STRBUF_INIT;
@@ -3557,7 +3557,7 @@ static int merge_recursive_internal(struct merge_options *opt,
 				     repo_get_commit_tree(opt->repo, h2),
 				     repo_get_commit_tree(opt->repo,
 							  merged_merge_bases),
-				     &mrtree);
+				     &result_tree);
 	strbuf_release(&merge_base_abbrev);
 	if (clean < 0) {
 		flush_output(opt);
@@ -3565,7 +3565,8 @@ static int merge_recursive_internal(struct merge_options *opt,
 	}
 
 	if (opt->call_depth) {
-		*result = make_virtual_commit(opt->repo, mrtree, "merged tree");
+		*result = make_virtual_commit(opt->repo, result_tree,
+					      "merged tree");
 		commit_list_insert(h1, &(*result)->parents);
 		commit_list_insert(h2, &(*result)->parents->next);
 	}
-- 
2.23.0.rc2.28.g5f89f15d7b.dirty

