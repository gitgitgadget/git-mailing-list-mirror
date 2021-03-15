Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A095C433E6
	for <git@archiver.kernel.org>; Mon, 15 Mar 2021 07:56:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DCAF564E6F
	for <git@archiver.kernel.org>; Mon, 15 Mar 2021 07:56:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230239AbhCOH41 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Mar 2021 03:56:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230092AbhCOH4F (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Mar 2021 03:56:05 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 963A3C061574
        for <git@vger.kernel.org>; Mon, 15 Mar 2021 00:56:05 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id q5so7320061pgk.5
        for <git@vger.kernel.org>; Mon, 15 Mar 2021 00:56:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZqyQqnN/r9Yp2nVabx5VAmks8N5fv9M2AVAwzn2f2LI=;
        b=lsE+zMnUlF7ZWndD4h4mKQpbTfkfALG6S5QTQ6QCRSH4a6QoLdoMUnBW/+K3r2Wo/w
         5tsVApESYX2SXIpHTELR1AQKYWgfDwK9Oz0mbxKwvJrwmVRYVp+x4ignXzIoCSQmOnRE
         tI4jEko87J2uQYS6M37kGUG+NslI0uImtFLlu5PLaS5BYAiYF4z2Tk0ewdm+IGXyDr/q
         ZMKe5e58WkU7i1VV1qTyUcZdd5WIdj5Ex8BkOGRGzcVP2/l6jAer5d3f9tC78JONDtju
         YGYlwgz2qt45lHdwlTrAjpfW1a8SrPIBWC00ZdM4QiH9/HFOiXUvM8doo8WQip4cR3ZJ
         FRhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZqyQqnN/r9Yp2nVabx5VAmks8N5fv9M2AVAwzn2f2LI=;
        b=bmsxU0vRyvVjdi3oRQrBoHOt6rOXhTBh3smyfTFld462MeIGt7KRs9t9jack+OkOfX
         /DIrNpMjYAxl3MXja37oHLZF3WcSg4zVg6YUOPbJF91CshupxEG+9RpJUzXH1luB+7kD
         /DpDCnX77+W2y3xMsiGZmV4dtxUryLGOgRni2uL0sXe12hnX6imHIfAlOuourDjruN5F
         +ys3jkyNWkRO0liIXG+LLTqCK1I7HCIFNfJhI0UtpTr+XTG2DRsfhHuuSEyGXW2SqZMi
         cQanln/BU6Is8yxIpEEFQXTtkdjstvjTIWB55M9tP6w2iL+K4Thc/jvTi1NNBms8+RB4
         qJcw==
X-Gm-Message-State: AOAM533r1Qjwus6MmU8JqlrAm4u1lxnucu4k0sLwlT71MYL5o0JdmrNa
        JjRYPhOo72PcYKeXpJfTKgG994fHimq9xw==
X-Google-Smtp-Source: ABdhPJwYVJcGCVHlknO+4WXrI3J/2ohb+2GCD0lDWcJVYvefa3ED/f9iTC6JzEwyRRCvx/MEjJhz+g==
X-Received: by 2002:a63:2e06:: with SMTP id u6mr21710372pgu.444.1615794965053;
        Mon, 15 Mar 2021 00:56:05 -0700 (PDT)
Received: from localhost.localdomain ([223.233.99.139])
        by smtp.googlemail.com with ESMTPSA id fs9sm9350911pjb.40.2021.03.15.00.56.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Mar 2021 00:56:04 -0700 (PDT)
From:   Charvi Mendiratta <charvi077@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, sunshine@sunshineco.com,
        christian.couder@gmail.com, phillip.wood123@gmail.com,
        Charvi Mendiratta <charvi077@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v6 5/6] t3437: use --fixup with options to create amend! commit
Date:   Mon, 15 Mar 2021 13:24:35 +0530
Message-Id: <20210315075435.18229-6-charvi077@gmail.com>
X-Mailer: git-send-email 2.29.0.rc1
In-Reply-To: <20210310194306.32565-1-charvi077@gmail.com>
References: <20210310194306.32565-1-charvi077@gmail.com>
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

