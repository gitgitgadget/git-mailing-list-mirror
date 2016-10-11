Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 33A1B2098A
	for <e@80x24.org>; Tue, 11 Oct 2016 00:22:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752844AbcJKAWC (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Oct 2016 20:22:02 -0400
Received: from mail-pf0-f174.google.com ([209.85.192.174]:34660 "EHLO
        mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752690AbcJKAWB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Oct 2016 20:22:01 -0400
Received: by mail-pf0-f174.google.com with SMTP id 190so1941767pfv.1
        for <git@vger.kernel.org>; Mon, 10 Oct 2016 17:22:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=hhmaLMZt3pIgilFjP/ugwWhRjAE3FSQyiuCjNWL56zQ=;
        b=CQZ4fPrNMFvbOSFgX+98/OGM6CbHETonsac7ru3bKdIcbFMADmsEuuTbFkNv+MpmcG
         GNjJUUWIIgFcbgt1XZL/KVCxZrmoc64rfTObRrE4cOuz9Ga4BLbMny59Lxib6law6f+q
         FBZVF5H/rIgTws4mOmrenEbMTRyPmLNmLru1u4SJ5MAWg8ZmN8/0M3ORoQwPf0T8xDxG
         RYn1Klo4jCi7EyTm3ancmIVJ/Xonvk/0qGMGcxm8VAryhwOHJIj8R+uCDxTFK9QPxwyl
         IZwH0bh2RDMgauCNTFzLFukI35/s84M3xfdaGo2YAdku6athXM/NMlNw0Ha/aCSQW05X
         oAMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=hhmaLMZt3pIgilFjP/ugwWhRjAE3FSQyiuCjNWL56zQ=;
        b=i7zxn55dNrKLqklPtl+YPFv7KtgZtZwM0sK7RmlPJGQi4cPzLFYSje3koEtKVz0IT1
         xgxEV98Me7nuJOnVGzuvB8g+KOitqJRULWKD6smuC42KVTbAWqhK3Lt0gy48ARnOan8r
         WrcJp3/GYp3dOY12hsRePZhuFHDxTGm3Q6CRDupR2Sf2JdydV4x1IXnmUzza9q0Gs0LM
         qohO/7clGSr9NQZ4mHhi3iHu8j05C6h67J2UH+1mOlgnC/pqQ4+T7chaMkmGuP5NBUgE
         OZU4M7gVuqjTpHVQ0Icngz3ZkSd1VMggURrOoPkgrhnCmQOQz/NpF0Tu1aSakqi0GyXQ
         EpfA==
X-Gm-Message-State: AA6/9RlK1+mCzoxQCNfEHUwuSfmZ1BzL8i+lTCCqDfa1x5YZSPRezJWWDxDKWF5jqwUy1MsG
X-Received: by 10.99.102.69 with SMTP id a66mr162144pgc.71.1476145320277;
        Mon, 10 Oct 2016 17:22:00 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:b8ee:61f5:e989:77a7])
        by smtp.gmail.com with ESMTPSA id f1sm531314pfa.29.2016.10.10.17.21.59
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 10 Oct 2016 17:21:59 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, bmwill@google.com, pclouds@gmail.com,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH 21/28] attr.c: rename a local variable check
Date:   Mon, 10 Oct 2016 17:21:08 -0700
Message-Id: <20161011002115.23312-22-sbeller@google.com>
X-Mailer: git-send-email 2.10.1.382.ga23ca1b.dirty
In-Reply-To: <20161011002115.23312-1-sbeller@google.com>
References: <20161011002115.23312-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Junio C Hamano <gitster@pobox.com>

Throughout this series, we are trying to use "check" to name an
instance of "git_attr_check" structure; let's rename a "check" that
refers to an array whose elements are git_attr_check_elem to avoid
confusion.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---
 attr.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/attr.c b/attr.c
index c1d5222..abf23d8 100644
--- a/attr.c
+++ b/attr.c
@@ -682,12 +682,12 @@ static int macroexpand_one(int attr_nr, int rem);
 
 static int fill_one(const char *what, struct match_attr *a, int rem)
 {
-	struct git_attr_check_elem *check = check_all_attr;
+	struct git_attr_check_elem *celem = check_all_attr;
 	int i;
 
 	for (i = a->num_attr - 1; 0 < rem && 0 <= i; i--) {
 		struct git_attr *attr = a->state[i].attr;
-		const char **n = &(check[attr->attr_nr].value);
+		const char **n = &(celem[attr->attr_nr].value);
 		const char *v = a->state[i].setto;
 
 		if (*n == ATTR__UNKNOWN) {
-- 
2.10.1.382.ga23ca1b.dirty

