Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E2AEE1F453
	for <e@80x24.org>; Wed, 26 Sep 2018 16:14:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728221AbeIZW2F (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Sep 2018 18:28:05 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:37435 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728557AbeIZW2E (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Sep 2018 18:28:04 -0400
Received: by mail-lf1-f65.google.com with SMTP id a82-v6so8368410lfa.4
        for <git@vger.kernel.org>; Wed, 26 Sep 2018 09:14:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=djmsgCX1wF28w5+WIB2+7YI1cv9kDYXtgMnbHj5MGZI=;
        b=u7A6QbGr+4MiZKSRJTl31YPTBnACpbZ64HD36KwxUG2+YtCqcOYbPaE6Axhc+2XJ8D
         +W1OqoZeo9R8mHHxhGcGUPzTA9GkigNoBec0sZCOBqJvfeK7oi7yT5uOSWH/D1aFTDIe
         yejnsq9CVmRbpfGnpB6nTeZhu8m5b45hnDJSEooLxCvtf8lfSOpj3y9C+Zl63wMn877a
         SloF3ZhmJg21rKm8HMkfqr2U676WuIRlL8ld+q0dmGgww/xeDHT2vRkfUgXpydkDees6
         YXuhBA8MqprtY1YCvSF+RLEAkfCN8x9FE3M7db5I/IP0qn8vyARhuA5NtHGGqGZrm98B
         ihCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=djmsgCX1wF28w5+WIB2+7YI1cv9kDYXtgMnbHj5MGZI=;
        b=ryPW6QJdgapLKDW1F/+hNo7KyPnhXJli45PLUVFb8ksRiQdQZjmf7dEVyfLKp52jfb
         uxxMV2Vy7HpUsyeDrZF0CciRKJ4YfGAYLvOyCmQ6HuJ8SVmaELjBsUg8VegJx5xIQ4+X
         /pS2OvR3T3eNBF5rGNDW4YwZW/8zmUQl1ffqaPfQn9sVdCB0ELBUJEVpFuhEVPTxi3RN
         srVAkWay4qqyNnn4IBK8ZnNQyx55V0Nuo9B4lS9eqQ3CoNEXobo6pUbBUh5kqUpoOpzf
         eD1sWaM72GIn+4if7brvDSgttb5PQrdEVHrJ+OvOe8hwqcRcuZ/T2TCTP9wzEvyODK6o
         LZ2A==
X-Gm-Message-State: ABuFfoizK+7Pitf67Wy7m5pr/cNcGWfyK4o9iyoYm5EOn6TMO3UvyVI4
        YZQXwewf84fanInFcdqteW86F1+g
X-Google-Smtp-Source: ACcGV61xG/tEeL68Gy6BjHWucD2vu1D2Z0HMxpfi3zWvoZRwX7WZpqJaFN/iX6dRq8fgm1FIIBeY2w==
X-Received: by 2002:a19:1063:: with SMTP id f96-v6mr4536403lfi.88.1537978462978;
        Wed, 26 Sep 2018 09:14:22 -0700 (PDT)
Received: from localhost.localdomain (31-211-229-121.customers.ownit.se. [31.211.229.121])
        by smtp.gmail.com with ESMTPSA id b132-v6sm1088664lfe.56.2018.09.26.09.14.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 26 Sep 2018 09:14:22 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     Alexander Pyhalov <apyhalov@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH] t7005-editor: quote filename to fix whitespace-issue
Date:   Wed, 26 Sep 2018 18:14:11 +0200
Message-Id: <20180926161411.10697-1-martin.agren@gmail.com>
X-Mailer: git-send-email 2.19.0.216.g2d3b1c576c
In-Reply-To: <20180926121107.GH27036@localhost>
References: <20180926121107.GH27036@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Alexander Pyhalov <apyhalov@gmail.com>

Commit 4362da078e (t7005-editor: get rid of the SPACES_IN_FILENAMES
prereq, 2018-05-14) removed code for detecting whether spaces in
filenames work. Since we rely on spaces throughout the test suite
("trash directory.t1234-foo"), testing whether we can use the filename
"e space.sh" was redundant and unnecessary.

In simplifying the code, though, this introduced a regression around how
spaces are handled, not in the /name/ of the editor script, but /in/ the
script itself. The script just does `echo space >$1`, where $1 is for
example "/foo/t/trash directory.t7005-editor/.git/COMMIT_EDITMSG".

With most shells, or with Bash in posix mode, $1 will not be subjected
to field splitting. But if we invoke Bash directly, which will happen if
we build Git with SHELL_PATH=/bin/bash, it will detect and complain
about an "ambiguous redirect". More details can be found in [1], thanks
to SZEDER Gábor.

Make sure that the editor script quotes "$1" to remove the ambiguity.

[1] https://public-inbox.org/git/20180926121107.GH27036@localhost/

Signed-off-by: Alexander Pyhalov <apyhalov@gmail.com>
Commit-message-by: Martin Ågren <martin.agren@gmail.com>
Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 SZEDER wrote:
 > Let me put on my POSIX-lawyer hat for a moment to explain this :)

 Thanks for an excellent explanation.

 > Sidenote: this test should use the write_script helper to create this
 > editor script.

 Yes. I've punted on that for now.

 Here's my updated commit message as part of a proper patch. Thanks
 Alexander for the analysis and the diff, and thanks Eric and SZEDER for
 getting me on the right track with the commit message.

 t/t7005-editor.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t7005-editor.sh b/t/t7005-editor.sh
index b2ca77b338..5fcf281dfb 100755
--- a/t/t7005-editor.sh
+++ b/t/t7005-editor.sh
@@ -112,7 +112,7 @@ do
 done
 
 test_expect_success 'editor with a space' '
-	echo "echo space >\$1" >"e space.sh" &&
+	echo "echo space >\"\$1\"" >"e space.sh" &&
 	chmod a+x "e space.sh" &&
 	GIT_EDITOR="./e\ space.sh" git commit --amend &&
 	test space = "$(git show -s --pretty=format:%s)"
-- 
2.19.0.216.g2d3b1c576c

