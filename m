Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E766F20D0C
	for <e@80x24.org>; Thu, 22 Jun 2017 19:02:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753731AbdFVTCg (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Jun 2017 15:02:36 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:33605 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753483AbdFVTCf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Jun 2017 15:02:35 -0400
Received: by mail-wr0-f194.google.com with SMTP id x23so6868414wrb.0
        for <git@vger.kernel.org>; Thu, 22 Jun 2017 12:02:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=FIz0iQ0BVddcEZpK2RRIqeT9gkisPGOZxGtR1WzYbKs=;
        b=F4Le/lUXMx3Npr3VoVa4jyT5kfCJUnLH5HkQvAxjiTJ5eRA/QS+bfSTFD6D0bOR/PJ
         pJfB/nbu8AGVxbBUtYBvgyEpYmFkFUn14SsOfm17E4lHfuVCuj3tKUrjFUBj8Tn8Kbb6
         nvzJ7fLZyN7sjfTQTwdjC0G4y0wh2ZFhsqqZU2CfUJz3gCr4+g1K8QAaMf4nEbS7ylFu
         tzsyJJEt/X5RdTyS5pl0dAh6N+wCSG6C/2gkg7gGkK9nJuG076hLwz0TGdJ4FdLbfniJ
         SrR6hRNrMqTTXnoxZTjJh83ndZ5ZCOzjLXrdaQwlkTuwXcOZb/q29RQuNcohPnAATgXU
         g3kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=FIz0iQ0BVddcEZpK2RRIqeT9gkisPGOZxGtR1WzYbKs=;
        b=bN6ogho5EwPBzKj1QNH2wTmrIvQ+4+WbjBUsYG7KAkrWsWGqolc1o0IeqTWs2Kzzkw
         6Xg5KpY/2cru4lajtkEIv03dicmxCUWqKKCn0kQQGjw7rOKwC4f1S0Rx42ntDX+zlaG1
         eB2ZyQwLCifX/7HK2aLfw4ZlT2mMquRYhoO+yEb/ID0/ArbmBJd3BL9a7ns6mS7oRRRp
         BiwXvOF0XjyduiuSOaS40mkwCv4PDZqsDzrfgQPcjTKLIuPmbf1xV/ATcpaDR74kx99w
         7zB1Wr3kNddWB2aL359yiSlaIv/2dNasIznbDz5Ar/M+2uNnKiTnPKQ2bRVaILGCk6fp
         X3Cg==
X-Gm-Message-State: AKS2vOwSE5A+2g8MWH2Ek/PogQjSkFu9ELya0Ml1by1Iy9zPrEziM0H0
        c2xdhsbxkboxVjgw
X-Received: by 10.28.105.83 with SMTP id e80mr2841545wmc.108.1498158139741;
        Thu, 22 Jun 2017 12:02:19 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id 32sm2771112wry.31.2017.06.22.12.02.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 22 Jun 2017 12:02:19 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Michael Haggerty <mhagger@alum.mit.edu>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 3/3] t1700: make sure split-index respects core.sharedrepository
Date:   Thu, 22 Jun 2017 21:01:58 +0200
Message-Id: <20170622190158.13265-3-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.13.1.516.g05ec6e13aa
In-Reply-To: <20170622190158.13265-1-chriscool@tuxfamily.org>
References: <20170622190158.13265-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a test to check that both the split-index file and the
shared-index file are created using the right permissions
when core.sharedrepository is set.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 t/t1700-split-index.sh | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/t/t1700-split-index.sh b/t/t1700-split-index.sh
index af3ec0da5a..a52b92e82b 100755
--- a/t/t1700-split-index.sh
+++ b/t/t1700-split-index.sh
@@ -370,4 +370,16 @@ test_expect_success 'check splitIndex.sharedIndexExpire set to "never" and "now"
 	test $(ls .git/sharedindex.* | wc -l) -le 2
 '
 
+test_expect_success POSIXPERM 'split index respects core.sharedrepository' '
+	git config core.sharedrepository 0666 &&
+	: >seventeen &&
+	git update-index --add seventeen &&
+	echo "-rw-rw-rw-" >expect &&
+	test_modebits .git/index >actual &&
+	test_cmp expect actual &&
+	newest_shared_index=$(ls -t .git/sharedindex.* | head -1) &&
+	test_modebits "$newest_shared_index" >actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
2.13.1.516.g05ec6e13aa

