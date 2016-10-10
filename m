Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 699CE207EC
	for <e@80x24.org>; Mon, 10 Oct 2016 03:58:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752104AbcJJD6B (ORCPT <rfc822;e@80x24.org>);
        Sun, 9 Oct 2016 23:58:01 -0400
Received: from mail-out6.apple.com ([17.151.62.28]:46186 "EHLO
        mail-in6.apple.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751689AbcJJD56 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Oct 2016 23:57:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; d=apple.com; s=mailout2048s; c=relaxed/simple;
        q=dns/txt; i=@apple.com; t=1476071877;
        h=From:Sender:Reply-To:Subject:Date:Message-Id:To:Cc:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=QPS3p4x/kmK9t3EYxCozTA1q0dGA1lGUhdofGHAzzA4=;
        b=jagu+tno6h8BLhXptuCKaNc/7rtJ0EHu7X8pBID4H+x35AchKABFge8MVFv/w0SU
        GRYVDbB5vZV61Td0i7Oy5H239Nn0HVnyMsVPx2h/MUxHLxwnQJzyzzJEJczLMcT5
        KE0Gpjy8+MQsR9L5sS3ztOPx8I2kBQYrL5J3K1TSimt8YwRMFpQDMbMIvpZZgz1V
        WunUVY0pEl2AJYCvmxvYfXAdoPvpZgKkWmDfFuADzHzWvLaRgu7YPjD8Am/AbcCY
        FFtVQ4h61Fw66CvmC6XtbmDyUmdXUieJHRV3ESfjESUL23+NGXNgMjPqpWl4e5TU
        8H63pPKEBTCTwm6DTGLxJQ==;
Received: from relay3.apple.com (relay3.apple.com [17.128.113.83])
        by mail-in6.apple.com (Apple Secure Mail Relay) with SMTP id B7.B1.06862.5C11BF75; Sun,  9 Oct 2016 20:57:57 -0700 (PDT)
X-AuditID: 11973e15-945b79a000001ace-e6-57fb11c5b82d
Received: from smtp.filemaker.com (Unknown_Domain [17.153.27.88])
        by relay3.apple.com (Apple SCV relay) with SMTP id 2F.60.13773.5C11BF75; Sun,  9 Oct 2016 20:57:57 -0700 (PDT)
From:   Jeremy Huddleston Sequoia <jeremyhu@apple.com>
To:     git@vger.kernel.org
Cc:     Jeremy Huddleston Sequoia <jeremyhu@apple.com>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] t3700-add.sh: Avoid filename collission between tests which could lead to test failure
Date:   Sun,  9 Oct 2016 20:57:56 -0700
Message-Id: <20161010035756.38408-1-jeremyhu@apple.com>
X-Mailer: git-send-email 2.10.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrDJMWRmVeSWpSXmKPExsUi2FAYrHtU8He4wc7N5hZdV7qZLBp6rzBb
        XFh9m92B2WPnrLvsHhcvKXt83iQXwBzFZZOSmpNZllqkb5fAlXF08XnGgovsFQe/HGVvYJzP
        1sXIySEhYCKx9+hf1i5GLg4hgb2MElu6nzDCJNaf2skMkdjEKHH9awMrSIINKHHrz2kWEFtE
        QFzi7fGZ7CA2s0ATo8SFPdEgtrBAusTkoyfAalgEVCXWfXgO1ssrYC7RfOcU1AJ5iQtXT7GA
        LJAQ2MsqMbPxBOsERp4FjAyrGIVyEzNzdDPzzPQSCwpyUvWS83M3MYK8P91OdAfjmVVWhxgF
        OBiVeHgTZvwKF2JNLCuuzD3EKM3BoiTOe34HUEggPbEkNTs1tSC1KL6oNCe1+BAjEwenVAPj
        DRvJm693R625Y9W7d/1Du4Yg497NBqfkU7jvz14WFxbmwXrPxdNe+rmOymfDoqh60Uwjvz+n
        ub3WnG9ZXXJ53v2byx0cvvPZh7Ll8hRNeWN0tNb+qB8n3/rWjQz9FwInP5/hFhZms/Lkw+5H
        93TWl0v5vD7sx526fF1gQOrtScsb+rvnPTupxFKckWioxVxUnAgAqqhrG98BAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrCJMWRmVeSWpSXmKPExsUiOFM6Qveo4O9wg68NxhZdV7qZLBp6rzBb
        nGmxtbiw+ja7A4vH1pM/2Dx2zrrL7nHxkrLH501yASxRXDYpqTmZZalF+nYJXBlHF59nLLjI
        XnHwy1H2Bsb5bF2MnBwSAiYS60/tZIawxSQu3FsPFOfiEBLYxChx/WsDK0iCDajo1p/TLCC2
        iIC4xNvjM9lBbGaBJkaJC3uiQWxhgXSJyUdPgNWwCKhKrPvwHKyXV8BcovnOKUaIBfISF66e
        YpnAyLWAkWEVo0BRak5ipbFeYkFBTqpecn7uJkaQXxsKg3cw/llmdYhRgINRiYfXoeZXuBBr
        YllxZe4hRgkOZiUR3l7u3+FCvCmJlVWpRfnxRaU5qcWHGKU5WJTEeT00foQLCaQnlqRmp6YW
        pBbBZJk4OKWAvp718fM79pStS8NmCHI5cLPLh2hzHth2/lruoqZVKlsE8k3zfzZLHYpLyu3v
        MrB8Iff7vOkbtQ+6gXPPMViXbFzDqPtUQ93D9OCW2ppq2cCwX/dO/Hr7ymx6Jd//j3GLLFOV
        FhnOU7la9lkpjqtZM3lTT8fP98/PlhhdV9Jf2nDGmZXnt2K0EktxRqKhFnNRcSIAEeopPOcB
        AAA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Regressed-in: 610d55af0f082f6b866dc858e144c03d8ed4424c
Signed-off-by: Jeremy Huddleston Sequoia <jeremyhu@apple.com>
CC: Thomas Gummerer <t.gummerer@gmail.com>
CC: Junio C Hamano <gitster@pobox.com>
---
 t/t3700-add.sh | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/t/t3700-add.sh b/t/t3700-add.sh
index 924a266..3ccb19b 100755
--- a/t/t3700-add.sh
+++ b/t/t3700-add.sh
@@ -354,11 +354,11 @@ test_expect_success 'git add --chmod=[+-]x changes index with already added file
 	git add foo3 &&
 	git add --chmod=+x foo3 &&
 	test_mode_in_index 100755 foo3 &&
-	echo foo >xfoo3 &&
-	chmod 755 xfoo3 &&
-	git add xfoo3 &&
-	git add --chmod=-x xfoo3 &&
-	test_mode_in_index 100644 xfoo3
+	echo foo >xfoo4 &&
+	chmod 755 xfoo4 &&
+	git add xfoo4 &&
+	git add --chmod=-x xfoo4 &&
+	test_mode_in_index 100644 xfoo4
 '
 
 test_expect_success POSIXPERM 'git add --chmod=[+-]x does not change the working tree' '
-- 
2.10.1

