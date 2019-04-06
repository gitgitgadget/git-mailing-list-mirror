Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2F17A20248
	for <e@80x24.org>; Sat,  6 Apr 2019 11:37:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726637AbfDFLhQ (ORCPT <rfc822;e@80x24.org>);
        Sat, 6 Apr 2019 07:37:16 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:43692 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726036AbfDFLhP (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 Apr 2019 07:37:15 -0400
Received: by mail-pf1-f194.google.com with SMTP id c8so4756364pfd.10
        for <git@vger.kernel.org>; Sat, 06 Apr 2019 04:37:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IHO0+//mUhxK1MPr5Z2K783mNYx8bk2aaztVe1lrmyQ=;
        b=EeOAbQB2iuYkeMU9YmbkZBO3NQxDCmZdUp95uxGSkI3Gt5KaM7y6o/ORpZZF6EeXtw
         WxnJVnIV7uQ8MJ/aIzP54yB27u8huECfm9KbHdvva5VWFZEAB7uZLurL0tfJRF/okr47
         l/4Q+tnDVmMZFgQyGxyuGahJzqVNEtpEfLwzDdNcxZnaMe+vwcPLxxD3eTRZYiCowNsi
         PB3wUHsHj5VWZGZ9n0p25kdln4BokV/jVj+8MBbSAdpMgFgNhAYSGvZcQaBWH4nJgybn
         +YZz15/KpOptE9ksfvLql99EU18G6NH3l8NeBKzTS9P8ZUb5MjG8bPfNCNx4iQKCP3vg
         ouaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IHO0+//mUhxK1MPr5Z2K783mNYx8bk2aaztVe1lrmyQ=;
        b=Y+wsQlI/JelFAeYqqOY1FCGPoR8tuLhwht3zQ7zGCGiWFqQ7qwgdydqv32CxFG6Nfe
         CwHkGN9IiBAkWeG/jlt88LKXxe+el5rWEvIU/Z4dy4xAoLv0VS9PFQuPQiO4LQqLlsGs
         0IZjFeslGNhONiL6gSHy2swaAUJCHAdTu/HpVgq86aKPh5nT8XXa8ZMbrHnvM28Wg7H2
         4X9ODQiaezXJs/ChfplyC8PEF+ofMQzgrfxcKPcjyabk/7GsA2VN++2T2u4dL6K/+eGb
         zCAp2d9fw1CGUhWMib7/kLv8cV94jrvEjKABtFl25bOoOSAKvIBxWfB6jfy62ps2W9X3
         OODg==
X-Gm-Message-State: APjAAAU2HQ/eW2XWgI9nOUJve8dpTNzShos32SZFjRT1uQdPA3loW8cr
        NoXz4XtKRt9amhE6uFMDO7bI10GY
X-Google-Smtp-Source: APXvYqw2TDMjLU/HFyGZwV15M9vvk5BNhexB3AV0ganDItWzkLEeD55nU2a3vmKQYYXm6MZd9jTeVg==
X-Received: by 2002:a65:62d2:: with SMTP id m18mr17503993pgv.122.1554550635277;
        Sat, 06 Apr 2019 04:37:15 -0700 (PDT)
Received: from ash ([116.102.217.71])
        by smtp.gmail.com with ESMTPSA id e21sm34254875pfd.177.2019.04.06.04.37.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 06 Apr 2019 04:37:14 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Sat, 06 Apr 2019 18:37:10 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, stefanbeller@gmail.com,
        szeder.dev@gmail.com,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH v3 22/33] sha1-name.c: remove the_repo from get_describe_name()
Date:   Sat,  6 Apr 2019 18:34:42 +0700
Message-Id: <20190406113453.5149-23-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.479.g47ac719cd3
In-Reply-To: <20190406113453.5149-1-pclouds@gmail.com>
References: <20190403113457.20399-1-pclouds@gmail.com>
 <20190406113453.5149-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 sha1-name.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/sha1-name.c b/sha1-name.c
index fb80306f1a..1cda854f02 100644
--- a/sha1-name.c
+++ b/sha1-name.c
@@ -1097,7 +1097,9 @@ static int peel_onion(const char *name, int len, struct object_id *oid,
 	return 0;
 }
 
-static int get_describe_name(const char *name, int len, struct object_id *oid)
+static int get_describe_name(struct repository *r,
+			     const char *name, int len,
+			     struct object_id *oid)
 {
 	const char *cp;
 	unsigned flags = GET_OID_QUIETLY | GET_OID_COMMIT;
@@ -1111,7 +1113,7 @@ static int get_describe_name(const char *name, int len, struct object_id *oid)
 			if (ch == 'g' && cp[-1] == '-') {
 				cp++;
 				len -= cp - name;
-				return get_short_oid(the_repository,
+				return get_short_oid(r,
 						     cp, len, oid, flags);
 			}
 		}
@@ -1162,7 +1164,7 @@ static enum get_oid_result get_oid_1(const char *name, int len,
 		return FOUND;
 
 	/* It could be describe output that is "SOMETHING-gXXXX" */
-	ret = get_describe_name(name, len, oid);
+	ret = get_describe_name(the_repository, name, len, oid);
 	if (!ret)
 		return FOUND;
 
-- 
2.21.0.479.g47ac719cd3

