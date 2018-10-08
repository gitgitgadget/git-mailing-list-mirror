Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 13C661F97E
	for <e@80x24.org>; Mon,  8 Oct 2018 21:57:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726568AbeJIFLH (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Oct 2018 01:11:07 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:49342 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725782AbeJIFLG (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 9 Oct 2018 01:11:06 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:e17d:6d35:bfb8:6a25])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 41F3460791;
        Mon,  8 Oct 2018 21:57:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1539035836;
        bh=mjd0zMgzkK8tSp46oKlKDrn4KKPMjOt4j3PKVZ5QUzk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=zPAMLASm+fzYQ/hT0z9Mv6Icm8DBv7prL2vy9ep0nU5p9uJuZmuaIM5i2ev9cdAG/
         28DSeNUGNWGgsod2Qj+mdcRypyaYYBWvJDNUaEgNe4Nw5AP5T8dkc7KPS8AoujAGj9
         /aCuv9Fov8/z0CevSVFRkHa21R1WjfpELXcunbobiY563C41zsPp67uUwB6R6uiTVf
         uBd1rJtad93PVXJgXfu35gN3VcoWiEy3EWy1TLSj40P7u0tRDrrARLiLWGaGmmvww6
         FE61VWzk9NecEGXPkp07yHzaIBsZfB8OjbOUACwSDz1jcuY9fZ6TpXpeKD7DN8zxWn
         zndXJwUrBKNeWOC9/eEg/IZCR8RMugNiQwAKfO7wNRdxnZKYXvqrhCc/8JMizHBrE5
         HHjiv+FcOgLB3KryJUh9aXMT5T889KmJp2SyjyDjeYx23y1TZZ03AYqotwvZwo0Wtr
         8RGHQnrHabHkJwpuR4mdLEOn4k4YEA0+AnMwibvJN5oCYj4Bltc
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 10/14] tag: express constant in terms of the_hash_algo
Date:   Mon,  8 Oct 2018 21:56:57 +0000
Message-Id: <20181008215701.779099-11-sandals@crustytoothpaste.net>
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
