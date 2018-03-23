Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E973A1F404
	for <e@80x24.org>; Fri, 23 Mar 2018 17:22:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752375AbeCWRWS (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Mar 2018 13:22:18 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:41179 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752469AbeCWRWK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Mar 2018 13:22:10 -0400
Received: by mail-lf0-f67.google.com with SMTP id o102-v6so19365729lfg.8
        for <git@vger.kernel.org>; Fri, 23 Mar 2018 10:22:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=plWC5CHMUJD5uNvtdNrgoR3ayadUwS+3LbBmOHbBCtE=;
        b=CvqlfaEYkDvSeuEGJYRLzT21pGnQ4VutAfwpWr82NhRBA91X/oRw6LLq+tSE1VeYIN
         RinKVEprrqS3oj5mVxX06qds+LXizcKtHQ1M8iHrDpHqLCfBrtUtD4IpCwU2E9Ei644u
         VnsvxKH8rdG2dItxmPjaLssEhHI40OmXFo8okg5DNtkIbhE+1xtTvDJZ25TisXZApMHq
         fKZv7zgf6A5u450MaAaZg9p5DVTsJIhPeUDs19WDU0BzYlwKuOT1QhFMPG1ToqpC6TJs
         piBVZmwHjImf8E6Mn7iv6xZpjhD0PSvbNAjnWpDsjqpV2JtfKSBxlyzivrFSD6CmHL65
         VFpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=plWC5CHMUJD5uNvtdNrgoR3ayadUwS+3LbBmOHbBCtE=;
        b=Fb8zOKexLZBlcEify2/9i+Ev2vuVbzf0w6M67WBgNRD7sFA1oRFrFWWO18ZUrbuRK0
         V+PVr6/5j1d4/Q2JqFkusvcgoprppG3O3otBslfGWDmYi195AC83SmowlmwBGNL4EKQi
         rFdsPbqHjy6oRQcLBTBmtl80x85xp+LYVsPv0zmEoJJ+7TXtALnxG8S4PATFA4dwMqGi
         T7XzR8objB2m1pcZEAGaI8iyq9q131Yzr13YQqFg6uPxsHeeyDdSniqeLbqLAs5c8Lkh
         EbuqvKTSbBMFL2mepyvEuhFn9R6P0JPfv2mCUXAu8eD4lA/Y0dYTizwjxVbL21/6QAXf
         riIg==
X-Gm-Message-State: AElRT7HwF9nZvS+35f01EWEfQJ6vET1lcobaeydg/PK5+SSWBAi69diw
        NiJq0qWhWGBudr+X4qUKptU=
X-Google-Smtp-Source: AG47ELuzAxHCFE724CWCgcMzcVWpNTz/68YzUB8X9c3yIQ7bfbSZ2ze/n01nKuibtnmJvoBwA4a+HQ==
X-Received: by 10.46.3.2 with SMTP id 2mr5082142ljd.111.1521825729471;
        Fri, 23 Mar 2018 10:22:09 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id g13sm1973028lja.65.2018.03.23.10.22.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Mar 2018 10:22:08 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, sbeller@google.com,
        Brandon Williams <bmwill@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 22/27] sha1_file: allow sha1_file_name to handle arbitrary repositories
Date:   Fri, 23 Mar 2018 18:21:16 +0100
Message-Id: <20180323172121.17725-23-pclouds@gmail.com>
X-Mailer: git-send-email 2.17.0.rc0.348.gd5a49e0b6f
In-Reply-To: <20180323172121.17725-1-pclouds@gmail.com>
References: <20180303113637.26518-1-pclouds@gmail.com>
 <20180323172121.17725-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Stefan Beller <sbeller@google.com>

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 object-store.h | 3 +--
 sha1_file.c    | 4 ++--
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/object-store.h b/object-store.h
index 03671745f4..d9cc875153 100644
--- a/object-store.h
+++ b/object-store.h
@@ -125,8 +125,7 @@ void raw_object_store_clear(struct raw_object_store *o);
  * Put in `buf` the name of the file in the local object database that
  * would be used to store a loose object with the specified sha1.
  */
-#define sha1_file_name(r, b, s) sha1_file_name_##r(b, s)
-void sha1_file_name_the_repository(struct strbuf *buf, const unsigned char *sha1);
+void sha1_file_name(struct repository *r, struct strbuf *buf, const unsigned char *sha1);
 
 #define map_sha1_file(r, s, sz) map_sha1_file_##r(s, sz)
 void *map_sha1_file_the_repository(const unsigned char *sha1, unsigned long *size);
diff --git a/sha1_file.c b/sha1_file.c
index 74c68ea776..aed9a558c5 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -323,9 +323,9 @@ static void fill_sha1_path(struct strbuf *buf, const unsigned char *sha1)
 	}
 }
 
-void sha1_file_name_the_repository(struct strbuf *buf, const unsigned char *sha1)
+void sha1_file_name(struct repository *r, struct strbuf *buf, const unsigned char *sha1)
 {
-	strbuf_addstr(buf, get_object_directory());
+	strbuf_addstr(buf, r->objects->objectdir);
 	strbuf_addch(buf, '/');
 	fill_sha1_path(buf, sha1);
 }
-- 
2.17.0.rc0.348.gd5a49e0b6f

