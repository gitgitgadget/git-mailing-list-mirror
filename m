Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FREEMAIL_REPLYTO_END_DIGIT,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E3E7C433E9
	for <git@archiver.kernel.org>; Mon,  1 Mar 2021 08:50:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6321664DE0
	for <git@archiver.kernel.org>; Mon,  1 Mar 2021 08:50:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233646AbhCAItS (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Mar 2021 03:49:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233549AbhCAIrk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Mar 2021 03:47:40 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2DCCC06174A
        for <git@vger.kernel.org>; Mon,  1 Mar 2021 00:46:55 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id i10so1843482pfk.4
        for <git@vger.kernel.org>; Mon, 01 Mar 2021 00:46:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references:reply-to
         :mime-version:content-transfer-encoding;
        bh=ZqyQqnN/r9Yp2nVabx5VAmks8N5fv9M2AVAwzn2f2LI=;
        b=B0LL4ZPultqRwEOXcX6CaD4kb3TBq75/xZ+23Uq+zQj3oj3pOtnx+w9CasSc9vtJik
         vnKXTvEx9lB9FTmj9gyPXVYR9WRflF0LhwowxQgB/950d8UDhwSWAaDKXlTxa5qIE2zF
         /0h5Yz5/5DHpUnbn4/qGwV1q96Omk2j5zes+269HaPc79UuBYexzjdKx2OYvdHOKdtWv
         94XMpOnJYwRbcknEGooDATMccZocOF39JceC497W6D53yR6JH0zqVx6SRNinhCcFR8Ni
         CEpTvNCgQLFsHx4sIM8DA20Clq38UQtCTXOWjzMirnntpWCXO7+/FY/Fr/w3pst+QpwV
         YXdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:reply-to:mime-version:content-transfer-encoding;
        bh=ZqyQqnN/r9Yp2nVabx5VAmks8N5fv9M2AVAwzn2f2LI=;
        b=a2pkaGzSUj6ldgQdwVQvTLAK27qko5aEVoTtMhLe2Nlu/HvX+zp6G3TEEbZ58Nl1L9
         ZdIv5rv8QOZeQBNO0tRH6PcDyu9WyvCL3FP+gMd63OtLAZy9Z2hgJeZm9ddqaM1NqkeB
         f6aFMjilXiN8bLCrBN46DEVN4lFkn0atybgW3TICU9n0bTCVeUK2ywYko7OSMcUeaTc9
         nm9nhVt0wa4jVtc8fFXy65DleZZuLc9GHfetiTGropIGD6VMxT4laFTjylRSB3D/A2Zv
         7uKXW2nx+lKWNFNaA16qxLTEipPO0qdGcScprt5rJOQn5iQSJMtXjHIdvzfSraZMzkk1
         4y/A==
X-Gm-Message-State: AOAM531GzPoRBF9jDAN2mMpeq7qdL9aF4kh57NdOMCLDI8Eg8iJeCg2r
        YqX+RDCYfjeciKQscvKvxaRTnbqnaCQ0BQ==
X-Google-Smtp-Source: ABdhPJzJhPf8KlCAountqotwyDBkwvGpJeugP+o1oAf9QfrGUYn5BYX+bM9IP5k+JmaO+Wtsk64XWA==
X-Received: by 2002:a05:6a00:a95:b029:1ee:471f:e323 with SMTP id b21-20020a056a000a95b02901ee471fe323mr11307770pfl.69.1614588415319;
        Mon, 01 Mar 2021 00:46:55 -0800 (PST)
Received: from localhost.localdomain ([2405:204:302d:d8af:c047:a272:aff7:4de6])
        by smtp.googlemail.com with ESMTPSA id b34sm16781426pgl.63.2021.03.01.00.46.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Mar 2021 00:46:55 -0800 (PST)
From:   Charvi Mendiratta <charvi077@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, christian.couder@gmail.com,
        phillip.wood123@gmail.com, Charvi Mendiratta <charvi077@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v3 5/6] t3437: use --fixup with options to create amend! commit
Date:   Mon,  1 Mar 2021 14:15:13 +0530
Message-Id: <20210301084512.27170-6-charvi077@gmail.com>
X-Mailer: git-send-email 2.29.0.rc1
In-Reply-To: <20210301084512.27170-1-charvi077@gmail.com>
References: <20210301084512.27170-1-charvi077@gmail.com>
Reply-To: 20210217072904.16257-1-charvi077@gmail.com
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We taught `git commit --fixup` to create "amend!" commit. Let's also
update the tests and use it to setup the rebase tests.

Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Mentored-by: Phillip Wood <phillip.wood@dunelm.org.uk>
Signed-off-by: Charvi Mendiratta <charvi077@gmail.com>
---
 t/t3437-rebase-fixup-options.sh | 30 +++---------------------------
 1 file changed, 3 insertions(+), 27 deletions(-)

diff --git a/t/t3437-rebase-fixup-options.sh b/t/t3437-rebase-fixup-options.sh
index a5a20354e3..d0bdc7ed02 100755
--- a/t/t3437-rebase-fixup-options.sh
+++ b/t/t3437-rebase-fixup-options.sh
@@ -72,40 +72,16 @@ test_expect_success 'setup' '
 	git commit --fixup=HEAD -a &&
 	git tag B1 &&
 	test_tick &&
-	git commit --allow-empty -F - <<-EOF &&
-	amend! B
-	$EMPTY
-	B
-	$EMPTY
-	edited 1
-	EOF
+	FAKE_COMMIT_AMEND="edited 1" git commit --fixup=reword:B &&
 	test_tick &&
-	git commit --allow-empty -F - <<-EOF &&
-	amend! amend! B
-	$EMPTY
-	B
-	$EMPTY
-	edited 1
-	$EMPTY
-	edited 2
-	EOF
+	FAKE_COMMIT_AMEND="edited 2" git commit --fixup=reword:HEAD &&
 	echo B2 >B &&
 	test_tick &&
 	FAKE_COMMIT_AMEND="edited squash" git commit --squash=HEAD -a &&
 	git tag B2 &&
 	echo B3 >B &&
 	test_tick &&
-	git commit -a -F - <<-EOF &&
-	amend! amend! amend! B
-	$EMPTY
-	B
-	$EMPTY
-	edited 1
-	$EMPTY
-	edited 2
-	$EMPTY
-	edited 3
-	EOF
+	FAKE_COMMIT_AMEND="edited 3" git commit -a --fixup=amend:HEAD^ &&
 	git tag B3 &&
 
 	GIT_AUTHOR_NAME="Rebase Author" &&
-- 
2.29.0.rc1

