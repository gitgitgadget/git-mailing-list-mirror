Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DA1511F97F
	for <e@80x24.org>; Mon,  8 Oct 2018 21:57:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725965AbeJIFK7 (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Oct 2018 01:10:59 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:49284 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725782AbeJIFK7 (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 9 Oct 2018 01:10:59 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:e17d:6d35:bfb8:6a25])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 9F35C60781;
        Mon,  8 Oct 2018 21:57:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1539035830;
        bh=xI933Yv4HTTGHwtAmfAMzhJcKKRVfaX87LLoz+jygIY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=MmAUhWBgm8Kq600Wq4vrhK/5ZlEJivoSliLKbartNzGtbeYuDuh1nXt90NyeDuyBK
         QCmlu2lL2QeQEMCnw7PcDvSrNj5qKhirVmQ/AOYSauSHa/+VNmqf71RZwDMzsplQVE
         iBzFoD0NiQrxfYMqfTNo8jA6utOG1maKt4hzc282uVlIVS7jtP2+hzyEoK59ReuR73
         RrdWt1EpqE+VOHrRY6ENKJyKzQOG+8I+B5vdbFZFI27cLZwRONlJaPmJqDFYAu+xiX
         x6a9wXr7x2ZeBHlD/oADw/3eJeMbZstDv32QqQApisuJU5gNHENteS3gsmK5efMGkZ
         FR7igGDRoAN8IkpdQH4ZWjiRhfj8x3qFuRQdNlaXj60a+Tswy1dDmmu01xOIQ0wr09
         o6ANRxSabQemx1waGZbfl2xt38cQ7CmygqSs8F6CLbz6wTbl9sHzZA2pUP0BkNQYcD
         vSlDqJg6HPSr3z15YRhfbY6M1S8d0DooFI0q0KPj3V9V3WVCDEZ
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 02/14] builtin/repack: replace hard-coded constant
Date:   Mon,  8 Oct 2018 21:56:49 +0000
Message-Id: <20181008215701.779099-3-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.19.1.331.ge82ca0e54c
In-Reply-To: <20181008215701.779099-1-sandals@crustytoothpaste.net>
References: <20181008215701.779099-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 builtin/repack.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/repack.c b/builtin/repack.c
index c6a7943d5c..e77859062d 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -407,8 +407,8 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 
 	out = xfdopen(cmd.out, "r");
 	while (strbuf_getline_lf(&line, out) != EOF) {
-		if (line.len != 40)
-			die("repack: Expecting 40 character sha1 lines only from pack-objects.");
+		if (line.len != the_hash_algo->hexsz)
+			die("repack: Expecting full hex object ID lines only from pack-objects.");
 		string_list_append(&names, line.buf);
 	}
 	fclose(out);
