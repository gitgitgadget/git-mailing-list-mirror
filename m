Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 776731F97E
	for <e@80x24.org>; Mon, 15 Oct 2018 00:02:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726545AbeJOHpK (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 Oct 2018 03:45:10 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:50600 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726515AbeJOHpH (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 15 Oct 2018 03:45:07 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:90d0:bd19:fb95:28cb])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id AA25761B85;
        Mon, 15 Oct 2018 00:02:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1539561743;
        bh=mjd0zMgzkK8tSp46oKlKDrn4KKPMjOt4j3PKVZ5QUzk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=tAgBKQ+bYiLVjFhxaUIvVcX+fC4ddmEt6NSv+9/C4MamgQOxSHTxmYNpoKlIaHVf2
         q6jWWWwFAxtDwJ6i6SAje1wROYgRtDYAsNSEpjzNHHp5u+HuZMHMPGbXotv1cHGSq+
         Ctk5DxYS5etbPHR24CFv6tVHudPHTehYvY04lwJ+ieUv/klk/PPe/ShLrkhQrNIUNr
         m2f15Sn/+uS0OSilw1v2VRw/T/udou0khgZapWbPndjDcQS14Rcyr2Np/nbVFM5hxE
         pjk3JWBiio+ppgaARxuJmLXwC4KmvY9TFQE5VgvbXWtaJlLAM2Gj0ZbrG/pC4xhqBa
         wGVO5kwfX3HtQSDTeCbOlhorbW0w93dGozGFv3AMdf9PfZ8D+Mmp2FcYyuvmHiNmDO
         y3Y6Ph91/VhoVcVXVzUs7dj+euJffVeGBjGfgtrj3bYEALwIfZWoqiSMogkS0QjoZ4
         gr3Y3gAmg9fv0fCpfMiIU4wtep/CHekojJVgEL5QYYrU61wsSrK
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Stefan Beller <sbeller@google.com>
Subject: [PATCH v2 11/15] tag: express constant in terms of the_hash_algo
Date:   Mon, 15 Oct 2018 00:01:58 +0000
Message-Id: <20181015000202.951965-12-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.19.1.568.g152ad8e336
In-Reply-To: <20181015000202.951965-1-sandals@crustytoothpaste.net>
References: <20181015000202.951965-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 tag.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tag.c b/tag.c
index 1db663d716..7445b8f6ea 100644
--- a/tag.c
+++ b/tag.c
@@ -144,7 +144,7 @@ int parse_tag_buffer(struct repository *r, struct tag *item, const void *data, u
 		return 0;
 	item->object.parsed = 1;
 
-	if (size < GIT_SHA1_HEXSZ + 24)
+	if (size < the_hash_algo->hexsz + 24)
 		return -1;
 	if (memcmp("object ", bufptr, 7) || parse_oid_hex(bufptr + 7, &oid, &bufptr) || *bufptr++ != '\n')
 		return -1;
