Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6C4542095B
	for <e@80x24.org>; Tue, 21 Mar 2017 13:01:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932152AbdCUNBQ (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Mar 2017 09:01:16 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:32893 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757135AbdCUNAv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Mar 2017 09:00:51 -0400
Received: by mail-wr0-f193.google.com with SMTP id g10so22360628wrg.0
        for <git@vger.kernel.org>; Tue, 21 Mar 2017 06:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=m/vTZkimqwvYcqPINtxDjVJ94URmqCKdLYTeNPmKSI0=;
        b=FJR+r+HolF7iXtmiGmxTjl2+0tsFQz6Ib8k02CGKC77If0cQ3ceuG2T030bMiPMjKf
         Jm56cmfFdX+ByMLZhgk+CSaUE0lPP1ZIvjL82oMMDckT369JYSBisQ7Hhsh8a33EY+/f
         r0eA9l8z+QupJ7u96ylcHC+VucpMHiLEz5P6zuhuDub1hD3Mq+x1ABnfgUmkQUKv7SMf
         fcD3+K7uVg/Rkj8k/nBAG5VveZXckalLRbUAX9RSAEvEWvrB8QigDo909iYG6wv38vn9
         RPrTkJ/c4IRWxUOGWoAaibog6p8X5I3e3Tcf8FefCUXW77H3zkGEIbDS8f680udpYYe/
         Yb6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=m/vTZkimqwvYcqPINtxDjVJ94URmqCKdLYTeNPmKSI0=;
        b=Ljl/RsJLEH4HW9b2Q3AoItlRY3BktdxelFVMPZ3Smq87BGPZYsq4CXzDqMiPbmFUnY
         g39AVQd24Aj1r3uX03saP/APM6Q6hDFTic1d70JUPaJPMG3c7tMsgSVuWHv/SfmxOpNv
         Gs5S44Ozm6H4Y+8DIoSsx6bLiJzgT261rkj5Z5jIeLQyD1wXiRqR41Xhz8EGqll6zGZi
         jS4wK2Sg0cXDMDtjgYtrNe+CRUWiU7aG/xisgl+pMbWAU4rkAt2ZUSRYgL1OlVzxxWU7
         QEGX/xS4X58EX+zdWDxil/E+oU/4jZ3vyj8DmjGPUoxkZMCy0On6FKJNjpr2PxCyCJK8
         YZuQ==
X-Gm-Message-State: AFeK/H0wsJgO+9bcK6tJEYD1C1S8UOViOlrgKSpkyzoeKFUnWAlPqDDBqZCBuybnjLzbOw==
X-Received: by 10.223.142.34 with SMTP id n31mr29569238wrb.11.1490101228838;
        Tue, 21 Mar 2017 06:00:28 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id 63sm17555072wmg.22.2017.03.21.06.00.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 21 Mar 2017 06:00:28 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Lars Hjemli <hjemli@gmail.com>,
        Jeff King <peff@peff.net>,
        Christian Couder <christian.couder@gmail.com>,
        Carlos Rica <jasampler@gmail.com>,
        Samuel Tardieu <sam@rfc1149.net>,
        Tom Grennan <tmgrennan@gmail.com>,
        Karthik Nayak <karthik.188@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 09/16] tag: add more incompatibles mode tests
Date:   Tue, 21 Mar 2017 12:58:54 +0000
Message-Id: <20170321125901.10652-10-avarab@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170321125901.10652-1-avarab@gmail.com>
References: <20170321125901.10652-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Amend the test suite to test for more invalid uses like "-l -a"
etc. This mainly tests the `(argc == 0 && !cmdmode)` ->
`((create_tag_object || force) && (cmdmode != 0))` code path in
builtin/tag.c.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t7004-tag.sh | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
index 63ee2cf727..958c77ab86 100755
--- a/t/t7004-tag.sh
+++ b/t/t7004-tag.sh
@@ -1455,6 +1455,19 @@ test_expect_success 'checking that initial commit is in all tags' "
 
 test_expect_success 'mixing incompatibles modes and options is forbidden' '
 	test_must_fail git tag -a &&
+	test_must_fail git tag -a -l &&
+	test_must_fail git tag -s &&
+	test_must_fail git tag -s -l &&
+	test_must_fail git tag -m &&
+	test_must_fail git tag -m -l &&
+	test_must_fail git tag -m "hlagh" &&
+	test_must_fail git tag -m "hlagh" -l &&
+	test_must_fail git tag -F &&
+	test_must_fail git tag -F -l &&
+	test_must_fail git tag -f &&
+	test_must_fail git tag -f -l &&
+	test_must_fail git tag -a -s -m -F &&
+	test_must_fail git tag -a -s -m -F -l &&
 	test_must_fail git tag -l -v &&
 	test_must_fail git tag -n 100 &&
 	test_must_fail git tag -l -m msg &&
-- 
2.11.0

