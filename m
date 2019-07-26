Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D40281F462
	for <e@80x24.org>; Fri, 26 Jul 2019 04:48:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725872AbfGZEse (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Jul 2019 00:48:34 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:33782 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725836AbfGZEse (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Jul 2019 00:48:34 -0400
Received: by mail-pg1-f193.google.com with SMTP id f20so14901119pgj.0
        for <git@vger.kernel.org>; Thu, 25 Jul 2019 21:48:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YF83dDDrqpWc+ojydVE0JZNsZD+hnlk4UTiy/UHfbKM=;
        b=ArV8uswC6qXjZofKzs+KQCn0Aqmzc1rWAvxGzxaAad+h2i+N0h4F2pq70j4PwhEFAq
         BCHKbV07C+9w44A68skcDmLdkbtJXRbTT3WoQPXVa5kAcAu2xRQ7wInUtJ+2qLPMcvvF
         pThMn2rCS2PD9fiAfo5hVrrz4heqo4tTqla3Jma63UiBvU98l6cmxUYRDVaWDjXqzP+F
         WnSo88VOg85tHSLFNW+rq1SfaOdBTR0e0y6YTJrUc1lrjEQ3bDkX4AlJb/qyCN4VjqPO
         wZlV3zxAWQ10b9BW6yB23bLL242lqRo3cYoxrFvN1kTixfYDrVM6NMHa6gVvkXHNi9fd
         9xAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YF83dDDrqpWc+ojydVE0JZNsZD+hnlk4UTiy/UHfbKM=;
        b=jzv2UMxp8Ik0aT5MypR7LeRhgXjis20qKDICu2BsmC/Tr2ZVJqAot9KRQJV/UcG44+
         rAUemlvfsrLTV13kBoUH6MFxGWXyo+XGSrIjcHj+6R00+plZ52FDprOwtJfMPIi2oRC+
         pzF5Xde519atn7oKIEgSvlZ94KMxXyrLeFK/q4BdMVTggO+Ws83LdqEaZytGog08IT24
         /0a5Ipum/P2tXRHC1vje0ioiih/utHXPE/DNCPeIXa/k5tv1nYBywN1N2MMgUQSXTiT2
         umSTyNQxlgUUGp2SFQrxk0L4zaA42GrzVf9Fe+CFkUOpwCO/iQomzIADVYGrjFAtTOGp
         taAQ==
X-Gm-Message-State: APjAAAVo8zgD+TPkyUHaoBxPKbWLynXM5dOHWhXki/z7PgAZf/gbrb5b
        1uHTTtESYVdoh2F4tGfpPbQ=
X-Google-Smtp-Source: APXvYqw9ZIwZ39Bz/tM+MhghBUFeH5t7q+1hc5HWThCsJSRW45zXYVdNy7bo585H24YQMsLywb1q+w==
X-Received: by 2002:a17:90a:9b08:: with SMTP id f8mr96777963pjp.103.1564116514015;
        Thu, 25 Jul 2019 21:48:34 -0700 (PDT)
Received: from localhost.localdomain (92.18.24.136.in-addr.arpa. [136.24.18.92])
        by smtp.googlemail.com with ESMTPSA id f15sm34942046pgu.2.2019.07.25.21.48.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 25 Jul 2019 21:48:33 -0700 (PDT)
From:   Varun Naik <vcnaik94@gmail.com>
To:     vcnaik94@gmail.com
Cc:     git@vger.kernel.org, pclouds@gmail.com
Subject: [PATCH v2] reset: unstage empty deleted ita files
Date:   Thu, 25 Jul 2019 21:48:06 -0700
Message-Id: <20190726044806.2216-1-vcnaik94@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190712150235.12633-1-vcnaik94@gmail.com>
References: <20190712150235.12633-1-vcnaik94@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It is possible to delete a committed file from the index and then add it
as intent-to-add. After `git reset HEAD`, the file should be identical
in the index and HEAD. This patch provides the desired behavior even
when the file is empty in the index.

Signed-off-by: Varun Naik <vcnaik94@gmail.com>
---
CC Duy because you seem to be the one who is most involved in changes to
ita behavior.

The test description was incorrect, so I changed that now. I also
figured out how to fix the related problem in "restore"; separate patch
coming soon.

 builtin/reset.c  |  1 +
 t/t7102-reset.sh | 11 +++++++++++
 2 files changed, 12 insertions(+)

diff --git a/builtin/reset.c b/builtin/reset.c
index 26ef9a7bd0..47a088f4b7 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -163,6 +163,7 @@ static int read_from_tree(const struct pathspec *pathspec,
 	opt.format_callback_data = &intent_to_add;
 	opt.flags.override_submodule_config = 1;
 	opt.repo = the_repository;
+	opt.ita_invisible_in_index = 1;
 
 	if (do_diff_cache(tree_oid, &opt))
 		return 1;
diff --git a/t/t7102-reset.sh b/t/t7102-reset.sh
index 97be0d968d..9f3854e8f0 100755
--- a/t/t7102-reset.sh
+++ b/t/t7102-reset.sh
@@ -566,4 +566,15 @@ test_expect_success 'reset --mixed sets up work tree' '
 	test_must_be_empty actual
 '
 
+test_expect_success 'reset --mixed adds deleted intent-to-add file back to index' '
+	echo "nonempty" >nonempty &&
+	>empty &&
+	git add nonempty empty &&
+	git commit -m "create files to be deleted" &&
+	git rm --cached nonempty empty &&
+	git add -N nonempty empty &&
+	git reset HEAD nonempty empty &&
+	git diff --staged --exit-code
+'
+
 test_done
-- 
2.22.0

