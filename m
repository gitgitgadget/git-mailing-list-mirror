Return-Path: <SRS0=EOdt=3U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A57AC2D0DB
	for <git@archiver.kernel.org>; Fri, 31 Jan 2020 20:16:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B3DB214D8
	for <git@archiver.kernel.org>; Fri, 31 Jan 2020 20:16:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sh8WFk1n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726670AbgAaUQf (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 31 Jan 2020 15:16:35 -0500
Received: from mail-wr1-f54.google.com ([209.85.221.54]:38426 "EHLO
        mail-wr1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726488AbgAaUQ1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Jan 2020 15:16:27 -0500
Received: by mail-wr1-f54.google.com with SMTP id y17so10151024wrh.5
        for <git@vger.kernel.org>; Fri, 31 Jan 2020 12:16:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=SNXe42SXsr/Nmr5yTN07lWZrSqUv3TG4EiTph2yOymM=;
        b=Sh8WFk1n/8A30xKkqja57VM6uGm86SVENRxF8yc16pKXMARWd6MBnXt4VcVXLOur3R
         dHMtRSl7WsFwXp5JOlhvyiwoOOZ9HBPoe9+rKIpzXP/k0ft4BZ2HILAajPwQAlp50GYY
         macBxoUsOhDnf645MnS3VxnyxWhHzd0Nth9gU2NWT+8Batr+qIrEFXvAcUxI3+v1+81k
         meIfC4jT8C2EAc4i7EQmTqcEiyjjoA2xa0JN21IiTm14lAQr6vrybeV5T4bFjF3a6zOe
         LMGv275p1aDEKi7+OAoAEE7pS81DXm0TKq3KBg728ILfJNrQNHAThzOVPjRiTHurMHk0
         Us7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=SNXe42SXsr/Nmr5yTN07lWZrSqUv3TG4EiTph2yOymM=;
        b=ksC6qghcH1V9rwR6fL4TNTWlesgWtYbl4Iuztn4aDCrGQJ2Jxh9s3q+qiNqSUQ9W+O
         AvvMyo499ppAQhlk2IreWYXEO7r+L9zqSsrl08KQVonuaoX5aATXzHss9iTmW+FhVm7M
         p6seqZ/gLntVllzrEfVC8lVEphYdj8eC+9LZQwtZOlHM9UemOsDApCXH2qpJHD12dHvJ
         StCWZnbG5CNHoVRCbJR6a8/zpF9amWw5LVCTFUseKO1sPf+j+ajzHMmDGyH2IoD1MiXV
         PipD06ldD9vqt5t2DjO2ynELZbu7hWyA7AIsXVc9yFJjRuIIW7xUPCd7Dsj/LtdqnBQJ
         pjlA==
X-Gm-Message-State: APjAAAUy6y+olweQBioU5COtKyC8YRal/DzzhQjJayarr2zucX6lCYuB
        lTHKcu3QNvwk590LdZ07xHcT+tp9
X-Google-Smtp-Source: APXvYqxZwwQCR5pW81Yvtequ5mQoNfOtpJpA/+JwEaLN5uVRLFpI5pJJRpJOS874jDzxr4xC7P8utw==
X-Received: by 2002:adf:f182:: with SMTP id h2mr136731wro.364.1580501785152;
        Fri, 31 Jan 2020 12:16:25 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e8sm13030143wrt.7.2020.01.31.12.16.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jan 2020 12:16:24 -0800 (PST)
Message-Id: <e2c6f85617f5e92c2fc52d2f869295bb0eefc242.1580501775.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.513.v4.git.1580501775.gitgitgadget@gmail.com>
References: <pull.513.v3.git.1580236003.gitgitgadget@gmail.com>
        <pull.513.v4.git.1580501775.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 31 Jan 2020 20:16:12 +0000
Subject: [PATCH v4 12/15] sparse-checkout: use C-style quotes in 'list'
 subcommand
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     me@ttaylorr.com, peff@peff.net, newren@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

When in cone mode, the 'git sparse-checkout list' subcommand lists
the directories included in the sparse cone. When these directories
contain odd characters, such as a backslash, then we need to use
C-style quotes similar to 'git ls-tree'.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 builtin/sparse-checkout.c          | 6 ++++--
 t/t1091-sparse-checkout-builtin.sh | 7 +++++--
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
index 6083aa10f2..facdb6bda7 100644
--- a/builtin/sparse-checkout.c
+++ b/builtin/sparse-checkout.c
@@ -78,8 +78,10 @@ static int sparse_checkout_list(int argc, const char **argv)
 
 		string_list_sort(&sl);
 
-		for (i = 0; i < sl.nr; i++)
-			printf("%s\n", sl.items[i].string);
+		for (i = 0; i < sl.nr; i++) {
+			quote_c_style(sl.items[i].string, NULL, stdout, 0);
+			printf("\n");
+		}
 
 		return 0;
 	}
diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkout-builtin.sh
index a46a310740..545e8d5ebe 100755
--- a/t/t1091-sparse-checkout-builtin.sh
+++ b/t/t1091-sparse-checkout-builtin.sh
@@ -406,7 +406,8 @@ test_expect_success BSLASHPSPEC 'pattern-checks: escaped "*"' '
 	EOF
 	test_cmp expect escaped/.git/info/sparse-checkout &&
 	check_read_tree_errors escaped "a zbad\\dir zdoes*exist" &&
-	git -C escaped ls-tree -d --name-only HEAD | git -C escaped sparse-checkout set --stdin &&
+	git -C escaped ls-tree -d --name-only HEAD >list-expect &&
+	git -C escaped sparse-checkout set --stdin <list-expect &&
 	cat >expect <<-\EOF &&
 	/*
 	!/*/
@@ -417,7 +418,9 @@ test_expect_success BSLASHPSPEC 'pattern-checks: escaped "*"' '
 	/zdoes\*exist/
 	EOF
 	test_cmp expect escaped/.git/info/sparse-checkout &&
-	check_files escaped "a deep folder1 folder2 zbad\\dir zdoes*exist"
+	check_files escaped "a deep folder1 folder2 zbad\\dir zdoes*exist" &&
+	git -C escaped sparse-checkout list >list-actual &&
+	test_cmp list-expect list-actual
 '
 
 test_done
-- 
gitgitgadget

