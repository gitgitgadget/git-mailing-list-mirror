Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F3B121F87F
	for <e@80x24.org>; Mon, 12 Nov 2018 08:41:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728098AbeKLSdL (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Nov 2018 13:33:11 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:36595 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726207AbeKLSdL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Nov 2018 13:33:11 -0500
Received: by mail-pl1-f195.google.com with SMTP id w24-v6so4006505plq.3
        for <git@vger.kernel.org>; Mon, 12 Nov 2018 00:41:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UF1NsSIyAjJ4EdXkRr6CJOjxBuQ3bVqU1eKODoRDTHI=;
        b=YTHjWr9Otx/ipj2zjM+vqjrwzL/Csn799lbMMBLkxXuQhhyxZWH3ugcl6avlT3bAdV
         5K0FX81l43eA/qkA/1djY8258Rw6+c+T1WuFSlG3SlSPZISc2Nc3xShcY8VzMJdDgU+h
         LCkGyLJRO74oyATaWwX3hRYI6fOL8QQxSBHFuA7Du9fB/ayUCBtQ7dE6iwytZk/r+DhS
         6tPBkdtGQ26uPbTv8KieKFbx9ZDNByLHr7XB5RHq4xBh2VHlnvOR4WQ4ymg9S/g9aNS5
         7PiUzOOjtixnBrjshhEcOjcFDDh7Yk1fwwrpHGZkZG/okRUxm58ctvqvawDOc5HbeFvL
         NC5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UF1NsSIyAjJ4EdXkRr6CJOjxBuQ3bVqU1eKODoRDTHI=;
        b=uGBBpwWsX+kgCQpHRBDYxmd1jQd/tF6rDHtdDJ6juMrHWGewl94Id84nMjnw7BAxN8
         ZyHn1FsgqQWB/X+OHQXcjDWyDb2GbY4oRTIwOI/bAImf6my4jC/TT4XlGsCnL8cZlZim
         SgvuCPffcf8aBOVkBId+YI4GfwlfUWZmKKOj6HZIs9Rup/X9eGFYLoVg5riMTVIIusMj
         chWNEB1WWIFq2zP+YQ0WFbqhqE7kr8MBiufkGCkg2o2SD0KMj3aLN3dppY1PMDCdraXm
         gG4JCAacm5ubchlIXcmBxiKgkmFY6zMQtJhhhMF4hfu9RmQYnJbUcv53SX08VJVCV889
         auRw==
X-Gm-Message-State: AGRZ1gJoWKYruERYlSsjDa24/6E9deWxc2wMwg9lA9TgxnGLxwgFrPxl
        GpmUwEF22Itx1CIGRN73r+B1CwNj
X-Google-Smtp-Source: AJdET5dTgqZouEv+qMHWUiSC5AzNmN8ynOumVkfDmHKx9w80I5q92AtPKnq//CR1A4d64+BpgKdqpA==
X-Received: by 2002:a17:902:f81:: with SMTP id 1-v6mr45542plz.203.1542012060478;
        Mon, 12 Nov 2018 00:41:00 -0800 (PST)
Received: from localhost.localdomain (c-67-188-192-166.hsd1.ca.comcast.net. [67.188.192.166])
        by smtp.gmail.com with ESMTPSA id s186-v6sm35041337pfs.164.2018.11.12.00.40.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 12 Nov 2018 00:41:00 -0800 (PST)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     christian.couder@gmail.com, johannes.schindelin@gmx.de,
        peff@peff.net
Subject: [PATCH 2/2] read-cache: use time_t instead of unsigned long
Date:   Mon, 12 Nov 2018 00:40:31 -0800
Message-Id: <20181112084031.11769-3-carenas@gmail.com>
X-Mailer: git-send-email 2.19.1.856.g8858448bb
In-Reply-To: <20181112084031.11769-1-carenas@gmail.com>
References: <20181112084031.11769-1-carenas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

b968372279 ("read-cache: unlink old sharedindex files", 2017-03-06)
introduced get_shared_index_expire_date using unsigned long to track
the modification times of a shared index.

dddbad728c ("timestamp_t: a new data type for timestamps", 2017-04-26)
shows why that might problematic so move to time_t instead.

Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
 read-cache.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/read-cache.c b/read-cache.c
index 7b1354d759..5525d8e679 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -2625,9 +2625,9 @@ static int write_split_index(struct index_state *istate,
 
 static const char *shared_index_expire = "2.weeks.ago";
 
-static unsigned long get_shared_index_expire_date(void)
+static time_t get_shared_index_expire_date(void)
 {
-	static unsigned long shared_index_expire_date;
+	static time_t shared_index_expire_date;
 	static int shared_index_expire_date_prepared;
 
 	if (!shared_index_expire_date_prepared) {
@@ -2643,7 +2643,7 @@ static unsigned long get_shared_index_expire_date(void)
 static int should_delete_shared_index(const char *shared_index_path)
 {
 	struct stat st;
-	unsigned long expiration;
+	time_t expiration;
 
 	/* Check timestamp */
 	expiration = get_shared_index_expire_date();
-- 
2.19.1.856.g8858448bb

