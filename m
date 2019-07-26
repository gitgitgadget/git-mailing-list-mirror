Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BD9241F462
	for <e@80x24.org>; Fri, 26 Jul 2019 15:53:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727985AbfGZPxT (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Jul 2019 11:53:19 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:42135 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387474AbfGZPxR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Jul 2019 11:53:17 -0400
Received: by mail-pf1-f195.google.com with SMTP id q10so24705442pff.9
        for <git@vger.kernel.org>; Fri, 26 Jul 2019 08:53:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jBhHPgtxODdD8djD550WnXUjkZobaTeU989dQBu38Ug=;
        b=QOG8ekogU0xsW+ctK3G7Hn7H74eQbLKXrMl7CDuAkFahY6WektjeXIIdzN1iuzEJmD
         FNguU+2uFAeSZ9kfwHPwYm0zFEoo86CDHbpr6cfpr3NOKi8bZxjxBm/LdeODgm8dDV1I
         9M3pf5xldR8sVH7bL7/UKxcRlhb5tWRkPxm89FaWni1xY+t1M0qcD0BGcRY/WXkRTyew
         ZUTJ6DM63kCoHj9s43tFZGY3AaqCUWFw8YT30Z/gyj6+J8nibs8z8oEmubQXc88Z6c5T
         Pl2zogUGjMz6UAcREacNZ3lGkNaCIHJvuEFlq0N7wFT8hSdUjceqKzbYFSFvGpOJXJf4
         +h7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jBhHPgtxODdD8djD550WnXUjkZobaTeU989dQBu38Ug=;
        b=PjyLwToWcav1wY3LQAuaqmctXnM7krfcJVGWIQ2S3XxskZLrEL6YNVM2F/uytRoXX1
         TeJEbHj3jEf8RcuIe58WnOe0RQCL6o+kU8myZ/uJVovGyS8wmnD23Htd8ClMGgP14BTU
         EHTRia42qkQLFcqP7nlgjTp1DUpa2chajIX8XxVM0l22AZa2ZIMVA0BGXRNk5t37n1Ny
         YMTRiE8PtVV+wERAQlGXD/cSNP+mG7xWIR+6y0DKf2igYax5RnyXfReL2rM/cmPMa2nf
         fTvZnPmG0N4zn9JgvPSMURELjxF2iK0ePvK+rwpisN/VRcXW99cejc1zQecKk0Ph/3NZ
         v8Jw==
X-Gm-Message-State: APjAAAWUg4Odss/h/is3+9f1bf9oEk+8Vo9QYApGAXkqR16lna4GJ35O
        iUKQfEllXylkorDv37a7z69lKTYB
X-Google-Smtp-Source: APXvYqzZ7SbuvFguHtlXxEqeuN62fka2K9VBSepo5JM+a1TMZYd+4+dquEMnbBqq1bieRBMo9OJaMw==
X-Received: by 2002:a65:4b89:: with SMTP id t9mr22808596pgq.55.1564156395899;
        Fri, 26 Jul 2019 08:53:15 -0700 (PDT)
Received: from newren2-linux.yojoe.local ([8.4.231.67])
        by smtp.gmail.com with ESMTPSA id f27sm36669638pgm.60.2019.07.26.08.53.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 26 Jul 2019 08:53:14 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH v2 10/20] merge-recursive: rename 'mrtree' to 'result_tree', for clarity
Date:   Fri, 26 Jul 2019 08:52:48 -0700
Message-Id: <20190726155258.28561-11-newren@gmail.com>
X-Mailer: git-send-email 2.22.0.550.g71c37a0928.dirty
In-Reply-To: <20190726155258.28561-1-newren@gmail.com>
References: <20190725174611.14802-1-newren@gmail.com>
 <20190726155258.28561-1-newren@gmail.com>
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
index 8114e77b98..f36962b7b5 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -3482,7 +3482,7 @@ static int merge_recursive_internal(struct merge_options *opt,
 {
 	struct commit_list *iter;
 	struct commit *merged_merge_bases;
-	struct tree *mrtree;
+	struct tree *result_tree;
 	int clean;
 
 	if (show(opt, 4)) {
@@ -3552,14 +3552,15 @@ static int merge_recursive_internal(struct merge_options *opt,
 				     repo_get_commit_tree(opt->repo, h2),
 				     repo_get_commit_tree(opt->repo,
 							  merged_merge_bases),
-				     &mrtree);
+				     &result_tree);
 	if (clean < 0) {
 		flush_output(opt);
 		return clean;
 	}
 
 	if (opt->call_depth) {
-		*result = make_virtual_commit(opt->repo, mrtree, "merged tree");
+		*result = make_virtual_commit(opt->repo, result_tree,
+					      "merged tree");
 		commit_list_insert(h1, &(*result)->parents);
 		commit_list_insert(h2, &(*result)->parents->next);
 	}
-- 
2.22.0.550.g71c37a0928.dirty

