Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0296321847
	for <e@80x24.org>; Wed,  2 May 2018 00:28:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753676AbeEBA2V (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 May 2018 20:28:21 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:37616 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751825AbeEBA0X (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 1 May 2018 20:26:23 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:e6b3:18ff:fe98:41a3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 223C7609A1;
        Wed,  2 May 2018 00:26:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1525220782;
        bh=4z6E+tUUtBEuMMvHlma8c+nxgH6pcP1G22caF/CVBBg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=WyO6InblVYeljbp7ffvhddy91VdSViXWeAHDtrMc//jiIm3qFdYm357HF4F13EHVL
         nnOKELozFzq6VKhqEfTqYAAUhO1KTEGe4yQUFb0r5y7Kbe0S9ajhiA8Pi16LEb/MMv
         qFko68XxaRcT7h+C1c8i5lgDVUs4UUT7C1Qlh5QNs6rXNzfehlAbMaWhmdkvVEGz9D
         tV9jmzGIgyIigVy2fHEnujcFpNIEy6PQ/S74NkuzFpD3R15PhI4jd3M2g6H2tP5xi9
         j4lciwlDQbF26IkSPUnPc7podhD4qCZO0WN+wajxNjAqGGXh9KA1uLQo2YiJhtjBG2
         W5bo7+UCyvwVOkudOeHu9SQwzZKWFpT4/JjvUNGE7whh0qTMPvwrdYLnOB5tUcFQoo
         ohyaDxGySjqBd5u0RkQ0kefLhWt3ti4Ot09PDn/CpqucUQrwcqVkt2uKt/lwHDcWiQ
         vIWBCLCGfjqZIDUkwGh8YPBVzaONshaj5KjY43tiH61Zk8sO1U3
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v2 03/42] Remove unused member in struct object_context
Date:   Wed,  2 May 2018 00:25:31 +0000
Message-Id: <20180502002610.915892-4-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d
In-Reply-To: <20180502002610.915892-1-sandals@crustytoothpaste.net>
References: <20180502002610.915892-1-sandals@crustytoothpaste.net>
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The tree member of struct object_context is unused except in one place
where we write to it.  Since there are no users of this member, remove
it.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 cache.h     | 1 -
 sha1-name.c | 1 -
 2 files changed, 2 deletions(-)

diff --git a/cache.h b/cache.h
index af6693f352..be9fab43ec 100644
--- a/cache.h
+++ b/cache.h
@@ -1306,7 +1306,6 @@ static inline int hex2chr(const char *s)
 #define FALLBACK_DEFAULT_ABBREV 7
 
 struct object_context {
-	unsigned char tree[20];
 	unsigned mode;
 	/*
 	 * symlink_path is only used by get_tree_entry_follow_symlinks,
diff --git a/sha1-name.c b/sha1-name.c
index 5b93bf8da3..7043652a24 100644
--- a/sha1-name.c
+++ b/sha1-name.c
@@ -1698,7 +1698,6 @@ static int get_oid_with_context_1(const char *name,
 								   name, len);
 				}
 			}
-			hashcpy(oc->tree, tree_oid.hash);
 			if (flags & GET_OID_RECORD_PATH)
 				oc->path = xstrdup(filename);
 
