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
	by dcvr.yhbt.net (Postfix) with ESMTP id 6F75B1F463
	for <e@80x24.org>; Thu, 19 Sep 2019 21:47:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404753AbfISVrX (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Sep 2019 17:47:23 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33562 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389341AbfISVrW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Sep 2019 17:47:22 -0400
Received: by mail-wr1-f65.google.com with SMTP id b9so4713757wrs.0
        for <git@vger.kernel.org>; Thu, 19 Sep 2019 14:47:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DuD3G6Wnstjdqq/ZU3fbCUz147/UNOC45pou1uLCWgE=;
        b=Fxn5I5TrkskelU7F+QwSq7VnMiMw8ko+4zPCPlIOTBcbIFIxWnlfN4gW5H42iKDk4Y
         u0lZkbcP7nJo27BFRavby4BDb0iW18OEY6gU/QFW9vzrETGm/i7C434BvZQaFrW99xLt
         kJkpkxt+P/Rbwvs9ZGj3QYeW0rU8968pGPIWdlH6IrbKS6JAT3m/+jO/dNSsFpSCX34o
         d1ldwNAq2f7cugZZ7xOQfWGHsVvR/xUYIQ9Z60wCzmeazVzcqKtnno0MZh/oxMMALY5c
         T7bkfR3mNN2WBL50AeFHOtYAEpPvqC+vSVwNcrNjNL8MfG813VT7BhTB+Q5e54+Bqm6e
         +WgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DuD3G6Wnstjdqq/ZU3fbCUz147/UNOC45pou1uLCWgE=;
        b=lXHH2FN2j/8LqTyNIFE3jN73qce8M5whiFVj1ZLYC3FYTx6+vgWJy1f1as1uafLq4b
         j42ZOLEd59YF71PCkhiSfNg+fTjdPKBNSxr+bGSqNuwQS4fLtY2GxZJjhcB9DiV6SbWn
         7eN+mMF4OKa76l+tO+uEYNnhDGsHBTJUDaltjCLmLTss7Fl4+FIhmreJ73Q0PsYwXuS4
         /8SdTCA6W4c/c+Pvxb0hhqxuQ5oE5xRJfY2XOfdp4zb/GE9+UJ7t+8WyP14EZL7IF6vk
         OwLCzfCMP3Ko5nyJyyW0J1pCBu3vW/yQOUeRAW3RtjgkBqcOuUNB39FXCuFyiuNg0IH9
         vi8g==
X-Gm-Message-State: APjAAAVBXUeuFeCKWa3PuqoanervdURkpi976ttrm0PAuIXuqXcCrlnp
        9UNRlH9DlEYTGnGgvtAwG5g=
X-Google-Smtp-Source: APXvYqyOnIiy1CwBUW69iLzsYej8yOig4qiawfg42unKtt3uBjQ8M6E2ZoANZBqr8Iep0snaq6ESlQ==
X-Received: by 2002:a5d:424c:: with SMTP id s12mr8399960wrr.221.1568929640321;
        Thu, 19 Sep 2019 14:47:20 -0700 (PDT)
Received: from localhost.localdomain (x4db63806.dyn.telefonica.de. [77.182.56.6])
        by smtp.gmail.com with ESMTPSA id b12sm12280wrt.21.2019.09.19.14.47.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 19 Sep 2019 14:47:19 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 01/15] t6120-describe: correct test repo history graph in comment
Date:   Thu, 19 Sep 2019 23:46:56 +0200
Message-Id: <20190919214712.7348-2-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.23.0.331.g4e51dcdf11
In-Reply-To: <20190919214712.7348-1-szeder.dev@gmail.com>
References: <20190919214712.7348-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

At the top of 't6120-describe.sh' an ASCII graph illustrates the
repository's history used in this test script.  This graph is a bit
misleading, because it swapped the second merge commit's first and
second parents.

When describing/naming a commit it does make a difference which parent
is the first and which is the second/Nth, so update this graph to
accurately represent that second merge.

While at it, move this history graph from the 'test_description'
variable to a regular comment.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 t/t6120-describe.sh | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/t/t6120-describe.sh b/t/t6120-describe.sh
index 2b883d8174..0bf7e0c8bc 100755
--- a/t/t6120-describe.sh
+++ b/t/t6120-describe.sh
@@ -1,15 +1,14 @@
 #!/bin/sh
 
-test_description='test describe
+test_description='test describe'
+
+#       ,---o----o----o-----.
+#      /   D,R   e           \
+#  o--o-----o-------------o---o----x
+#      \    B            /
+#       `---o----o----o-'
+#                A    c
 
-                       B
-        .--------------o----o----o----x
-       /                   /    /
- o----o----o----o----o----.    /
-       \        A    c        /
-        .------------o---o---o
-                   D,R   e
-'
 . ./test-lib.sh
 
 check_describe () {
-- 
2.23.0.331.g4e51dcdf11

