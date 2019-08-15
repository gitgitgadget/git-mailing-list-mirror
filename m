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
	by dcvr.yhbt.net (Postfix) with ESMTP id CB7A21F45A
	for <e@80x24.org>; Thu, 15 Aug 2019 21:41:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732960AbfHOVlc (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Aug 2019 17:41:32 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:46211 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732317AbfHOVlb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Aug 2019 17:41:31 -0400
Received: by mail-pl1-f195.google.com with SMTP id c2so1545896plz.13
        for <git@vger.kernel.org>; Thu, 15 Aug 2019 14:41:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Gc1r6LorNzKEfO3o/SB0SreV5RX1iP2TsbZSogbZrXQ=;
        b=sCujMQUDHbNnsVP/1qaZTSFwVTIb5IqKx2GbU7AfjIZgxSh+voTnvBkalbuh9qc1g5
         F8oeuJS07O76EzNjUdUqLV+Xs/9X8wX1npItBbf7V8OUE+l6G2Gp9ddMGYy5SzqJ/hr9
         dIyXfTuHfljRrmTkNtulelNZJiHF40hzpBX49SBoKy18nJoLIEht1c//YBBGPH07dzit
         QaA4nang0OwTQhwRm5gId2/mI8MjIoXHiRLDTjV6Cdneussl3reGt6l8U2Kc4rZjhPXc
         ZPfoQ6nNqVI6hqWMp18W/batwxZIO3tWLzkpOOMT/bk2nfu0n85laKoBTvUOkYC7YRop
         tt9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Gc1r6LorNzKEfO3o/SB0SreV5RX1iP2TsbZSogbZrXQ=;
        b=bip/YylomirdVCRxNRA8/XbcoQf7RKWCKQN7224GrcMicXlFT7ddConFHw3dcQXDN/
         PY0yVsr2GJgHXdVqc2mTImwnXTJLg36FPjP5n5n32zjXCqmn12tojyHpJNJJKCJXlFF8
         1f9y82fKjQp3aUIaCuPKSz+wTQTU3XadvrfRT3STy9EUzjYAeAqVDPZy3l88OMa7cxZa
         l4iwnfVkLypsi4p0duzHhW65rOWOHVjhb+MdrDyNj8SneHEfE4iCLZCzg5NKxdpILg8L
         YYYERQaX3Hbn7KcgFHskw7kNFboS9e8J45ZCxlV4uPnvm13BXUavGJ3kq+Ahso54TSbu
         +zsQ==
X-Gm-Message-State: APjAAAVYINKRKWSfJnr3jgGpM5hhDndlRXbYkLONx6hUlLW+RbIXyuSB
        ZwoOI/0SJfKr5IRtQUL2BD5/2E40
X-Google-Smtp-Source: APXvYqziuLvookp2aAPkeGmBS5VaRhs1yoFEtL/xQgfFKKq6yUSZm9wgg/5RBT2WFDrIoru1hPoNzg==
X-Received: by 2002:a17:902:8ecc:: with SMTP id x12mr3846627plo.258.1565905290009;
        Thu, 15 Aug 2019 14:41:30 -0700 (PDT)
Received: from newren2-linux.yojoe.local ([8.4.231.67])
        by smtp.gmail.com with ESMTPSA id i124sm4131966pfe.61.2019.08.15.14.41.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 15 Aug 2019 14:41:28 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Derrick Stolee <stolee@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH v3 15/24] merge-recursive: rename 'mrtree' to 'result_tree', for clarity
Date:   Thu, 15 Aug 2019 14:40:44 -0700
Message-Id: <20190815214053.16594-16-newren@gmail.com>
X-Mailer: git-send-email 2.23.0.rc2.32.g2123e9e4e4
In-Reply-To: <20190815214053.16594-1-newren@gmail.com>
References: <20190726155258.28561-1-newren@gmail.com>
 <20190815214053.16594-1-newren@gmail.com>
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
index d0153ba971..bffb5eac7d 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -3477,7 +3477,7 @@ static int merge_recursive_internal(struct merge_options *opt,
 {
 	struct commit_list *iter;
 	struct commit *merged_merge_bases;
-	struct tree *mrtree;
+	struct tree *result_tree;
 	int clean;
 	int num_merge_bases;
 	struct strbuf merge_base_abbrev = STRBUF_INIT;
@@ -3562,7 +3562,7 @@ static int merge_recursive_internal(struct merge_options *opt,
 				     repo_get_commit_tree(opt->repo, h2),
 				     repo_get_commit_tree(opt->repo,
 							  merged_merge_bases),
-				     &mrtree);
+				     &result_tree);
 	strbuf_release(&merge_base_abbrev);
 	if (clean < 0) {
 		flush_output(opt);
@@ -3570,7 +3570,8 @@ static int merge_recursive_internal(struct merge_options *opt,
 	}
 
 	if (opt->call_depth) {
-		*result = make_virtual_commit(opt->repo, mrtree, "merged tree");
+		*result = make_virtual_commit(opt->repo, result_tree,
+					      "merged tree");
 		commit_list_insert(h1, &(*result)->parents);
 		commit_list_insert(h2, &(*result)->parents->next);
 	}
-- 
2.23.0.rc2.32.g2123e9e4e4

