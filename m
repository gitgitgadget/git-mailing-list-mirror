Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DD7521F453
	for <e@80x24.org>; Thu,  1 Nov 2018 13:46:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728654AbeKAWte (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Nov 2018 18:49:34 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:43413 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727963AbeKAWtd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Nov 2018 18:49:33 -0400
Received: by mail-qk1-f196.google.com with SMTP id r71so12265356qkr.10
        for <git@vger.kernel.org>; Thu, 01 Nov 2018 06:46:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4XHtyEd7Lj8CK8zT8JQIjck/3o2ljdc8qaO6uLQfdCE=;
        b=YOiuBBqM0rWSONsq5Xl1hh2Gzw3MucQkAVU24W+Vqfs5lwacACO7JKlliznunNEVNW
         awN+PdyVj+COKAqN1Ikneq4DsFRzkM5Dhyz7Ei9ZSSvcFYnmfRbvtArfRWRx2Y9+Mp7K
         GF4WXW8lEipKLm4EJhaHqr7mUfzh5kHF44F3qzE4oBC5hY0igWVpXItBcvBUMgUc77ul
         T5B62ernajy2kxhFWguu93nU15Y3ov0QgMTXzasCUUzrg/zzGSEC+7hDStEv3rQmeZFK
         jpmFrUDfKh1HqcaH+eXWo9HlKlpHjxFDKlGXQHFuNHcLVlZ0xOnURjmmK79icfCE+Bjy
         Prew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4XHtyEd7Lj8CK8zT8JQIjck/3o2ljdc8qaO6uLQfdCE=;
        b=hhyqOjqrWcneTNNdDtLA+QUuYA3sqSvJI1ItndtCqMhLR5ln3lpsvHiZRfOUUib2iY
         f6fkaxoEwGuJRzDikTK22z1rOCqCs1WL//pmOpHtAVs2Z8i+NM27BKR6vJOKK9zVJASa
         87rbtts0iVYgSEt1rlf+Iu3Vjdw4T6bYs6xeehoy+kMmlsuaclMsWaKtkiiraFLxLyUU
         p9ZDqz8/q2Y+ScJhvoikHIWEPFiAHiIGS1UG9kE7gAJJuaR9Y0T2gpDVe0mtLUKaIseo
         zFGwefhHXQc7B07icqksE+y9jD/EBeH7/ZthrbiqY86Q4WAM448DG5l51dGYYjr8VjXb
         FXIg==
X-Gm-Message-State: AGRZ1gI1b93GQdyK9YvSPCzSNIr4gQm4f3yQEGR5/nwP4cVF/MVZ847K
        1v5DiuTYwtMOEOk4jEkFz1KWnsNR
X-Google-Smtp-Source: AJdET5fk9G434J+xUh4suyLpMGx0IrPSVteGShZ56CXQNZk2isG3fKAODhcjvtjVqlE9DNcx1iWyww==
X-Received: by 2002:a37:e20b:: with SMTP id g11mr6313633qki.21.1541079990055;
        Thu, 01 Nov 2018 06:46:30 -0700 (PDT)
Received: from stolee-linux.mshome.net ([167.220.148.125])
        by smtp.gmail.com with ESMTPSA id f75sm7347357qkf.96.2018.11.01.06.46.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Nov 2018 06:46:29 -0700 (PDT)
From:   Derrick Stolee <stolee@gmail.com>
X-Google-Original-From: Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, avarab@gmail.com, szeder.dev@gmail.com,
        peff@peff.net, jnareb@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v5 3/7] test-reach: add rev-list tests
Date:   Thu,  1 Nov 2018 13:46:19 +0000
Message-Id: <20181101134623.84055-4-dstolee@microsoft.com>
X-Mailer: git-send-email 2.19.1.542.gc4df23f792
In-Reply-To: <20181101134623.84055-1-dstolee@microsoft.com>
References: <pull.25.v4.git.gitgitgadget@gmail.com>
 <20181101134623.84055-1-dstolee@microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The rev-list command is critical to Git's functionality. Ensure it
works in the three commit-graph environments constructed in
t6600-test-reach.sh. Here are a few important types of rev-list
operations:

* Basic: git rev-list --topo-order HEAD
* Range: git rev-list --topo-order compare..HEAD
* Ancestry: git rev-list --topo-order --ancestry-path compare..HEAD
* Symmetric Difference: git rev-list --topo-order compare...HEAD

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 t/t6600-test-reach.sh | 84 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 84 insertions(+)

diff --git a/t/t6600-test-reach.sh b/t/t6600-test-reach.sh
index 9d65b8b946..288f703b7b 100755
--- a/t/t6600-test-reach.sh
+++ b/t/t6600-test-reach.sh
@@ -243,4 +243,88 @@ test_expect_success 'commit_contains:miss' '
 	test_three_modes commit_contains --tag
 '
 
+test_expect_success 'rev-list: basic topo-order' '
+	git rev-parse \
+		commit-6-6 commit-5-6 commit-4-6 commit-3-6 commit-2-6 commit-1-6 \
+		commit-6-5 commit-5-5 commit-4-5 commit-3-5 commit-2-5 commit-1-5 \
+		commit-6-4 commit-5-4 commit-4-4 commit-3-4 commit-2-4 commit-1-4 \
+		commit-6-3 commit-5-3 commit-4-3 commit-3-3 commit-2-3 commit-1-3 \
+		commit-6-2 commit-5-2 commit-4-2 commit-3-2 commit-2-2 commit-1-2 \
+		commit-6-1 commit-5-1 commit-4-1 commit-3-1 commit-2-1 commit-1-1 \
+	>expect &&
+	run_three_modes git rev-list --topo-order commit-6-6
+'
+
+test_expect_success 'rev-list: first-parent topo-order' '
+	git rev-parse \
+		commit-6-6 \
+		commit-6-5 \
+		commit-6-4 \
+		commit-6-3 \
+		commit-6-2 \
+		commit-6-1 commit-5-1 commit-4-1 commit-3-1 commit-2-1 commit-1-1 \
+	>expect &&
+	run_three_modes git rev-list --first-parent --topo-order commit-6-6
+'
+
+test_expect_success 'rev-list: range topo-order' '
+	git rev-parse \
+		commit-6-6 commit-5-6 commit-4-6 commit-3-6 commit-2-6 commit-1-6 \
+		commit-6-5 commit-5-5 commit-4-5 commit-3-5 commit-2-5 commit-1-5 \
+		commit-6-4 commit-5-4 commit-4-4 commit-3-4 commit-2-4 commit-1-4 \
+		commit-6-3 commit-5-3 commit-4-3 \
+		commit-6-2 commit-5-2 commit-4-2 \
+		commit-6-1 commit-5-1 commit-4-1 \
+	>expect &&
+	run_three_modes git rev-list --topo-order commit-3-3..commit-6-6
+'
+
+test_expect_success 'rev-list: range topo-order' '
+	git rev-parse \
+		commit-6-6 commit-5-6 commit-4-6 \
+		commit-6-5 commit-5-5 commit-4-5 \
+		commit-6-4 commit-5-4 commit-4-4 \
+		commit-6-3 commit-5-3 commit-4-3 \
+		commit-6-2 commit-5-2 commit-4-2 \
+		commit-6-1 commit-5-1 commit-4-1 \
+	>expect &&
+	run_three_modes git rev-list --topo-order commit-3-8..commit-6-6
+'
+
+test_expect_success 'rev-list: first-parent range topo-order' '
+	git rev-parse \
+		commit-6-6 \
+		commit-6-5 \
+		commit-6-4 \
+		commit-6-3 \
+		commit-6-2 \
+		commit-6-1 commit-5-1 commit-4-1 \
+	>expect &&
+	run_three_modes git rev-list --first-parent --topo-order commit-3-8..commit-6-6
+'
+
+test_expect_success 'rev-list: ancestry-path topo-order' '
+	git rev-parse \
+		commit-6-6 commit-5-6 commit-4-6 commit-3-6 \
+		commit-6-5 commit-5-5 commit-4-5 commit-3-5 \
+		commit-6-4 commit-5-4 commit-4-4 commit-3-4 \
+		commit-6-3 commit-5-3 commit-4-3 \
+	>expect &&
+	run_three_modes git rev-list --topo-order --ancestry-path commit-3-3..commit-6-6
+'
+
+test_expect_success 'rev-list: symmetric difference topo-order' '
+	git rev-parse \
+		commit-6-6 commit-5-6 commit-4-6 \
+		commit-6-5 commit-5-5 commit-4-5 \
+		commit-6-4 commit-5-4 commit-4-4 \
+		commit-6-3 commit-5-3 commit-4-3 \
+		commit-6-2 commit-5-2 commit-4-2 \
+		commit-6-1 commit-5-1 commit-4-1 \
+		commit-3-8 commit-2-8 commit-1-8 \
+		commit-3-7 commit-2-7 commit-1-7 \
+	>expect &&
+	run_three_modes git rev-list --topo-order commit-3-8...commit-6-6
+'
+
 test_done
-- 
2.19.1.542.gc4df23f792

