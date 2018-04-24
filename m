Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0E3F61F424
	for <e@80x24.org>; Tue, 24 Apr 2018 21:59:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751339AbeDXV72 (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Apr 2018 17:59:28 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:46115 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751213AbeDXV7U (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Apr 2018 17:59:20 -0400
Received: by mail-pf0-f194.google.com with SMTP id h69so13391850pfe.13
        for <git@vger.kernel.org>; Tue, 24 Apr 2018 14:59:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=hFxyQ3atK3wVBnz9I6srBSM7mcyc6imJff8CUmEtndw=;
        b=cbiipJqvUvQ2VH4q6FylsYJpTLAp1zPCVjWMNMk5D0CfUn4r9Tz//zKk792YaIaK35
         d1xBcJ00VL7RygeN4edTNklJVNT/eGNoKQYEkfoG3tTYG0+u+kAUNs1DmF+08wkLj9/Y
         jTLfwrx9VgMZCafEAQZasZZ7vRea3E4KfkqGgdCHd5u6ezdCBkBT8uGQmnVNXSGpgKwX
         HEGRCzPV9ttGyr/dfZs8eaLceFF4l7TvH3PEwfJqZWu9AOy3yP0XCaRFv8mE0/EwHWtI
         G2xHn7N7Ew3pfaG7B8t1vJzKgnrsIfeT3MKdS8UeMNnbgSU8WpcAhmaaw1gqJ0sisMT2
         LDzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=hFxyQ3atK3wVBnz9I6srBSM7mcyc6imJff8CUmEtndw=;
        b=onY5Ii+jLCty85sVJinixc5dwyoD7nTx4jKxBUPEsY1Nn9bnp4tQbtz8PnuTtBH250
         nicZbWaWjT2kbYI9rbu93JhvWXsMUhHVraq7TG/1O8YPhHxIwdVqiOmclmvK5AjL6eQx
         W5rfr7SnNNZeKr514329kS5wll9QbcU+PE7esUKRjKq5QveUrFyKH3NmhhL4jGpq9MOv
         VTDw6yZQeQ7vZslSALEBe5XPyCz3W5baSVjtVBVMPn9/BGXQe6tijhztzXP7VtFtYW5i
         2WOKxAyNoJDCTbJ1WfmwYwW0MK0CwO5rAdZNvILNmcYuJEqppgo26B26JGPeskT5wWDf
         zEQQ==
X-Gm-Message-State: ALQs6tByRHCU6Ho50kM+1NCZfBbuk2pQIj3mN29Q9ectDpYdIKQ7SF6o
        Fu9zwAynDEk2A1eOhbjGsea3vpNvK1g=
X-Google-Smtp-Source: AIpwx4/nj+eoEe92VaTQpGSGRcdW48g0+5+0IKLEhMkgyznw/xZ89a39JD76qTBTsFUUuSdd923Uww==
X-Received: by 10.167.131.217 with SMTP id j25mr25137140pfn.5.1524607159740;
        Tue, 24 Apr 2018 14:59:19 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id b89sm2364011pfd.85.2018.04.24.14.59.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 24 Apr 2018 14:59:19 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org, gitster@pobox.com
Cc:     bmwill@google.com, jonathantanmy@google.com,
        sandals@crustytoothpaste.net, Stefan Beller <sbeller@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCHv2 4/9] packfile: add repository argument to packed_to_object_type
Date:   Tue, 24 Apr 2018 14:59:04 -0700
Message-Id: <20180424215910.22201-5-sbeller@google.com>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d-goog
In-Reply-To: <20180424215910.22201-1-sbeller@google.com>
References: <20180424215910.22201-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a repository argument to allow the callers of packed_to_object_type
to be more specific about which repository to handle. This is a small
mechanical change; it doesn't change the implementation to handle
repositories other than the_repository yet.

As with the previous commits, use a macro to catch callers passing a
repository other than the_repository at compile time.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---
 packfile.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/packfile.c b/packfile.c
index d2b3f3503b..3ecfba66af 100644
--- a/packfile.c
+++ b/packfile.c
@@ -1124,11 +1124,13 @@ static int retry_bad_packed_offset_the_repository(struct packed_git *p, off_t ob
 
 #define POI_STACK_PREALLOC 64
 
-static enum object_type packed_to_object_type(struct packed_git *p,
-					      off_t obj_offset,
-					      enum object_type type,
-					      struct pack_window **w_curs,
-					      off_t curpos)
+#define packed_to_object_type(r, p, o, t, w, c) \
+	packed_to_object_type_##r(p, o, t, w, c)
+static enum object_type packed_to_object_type_the_repository(struct packed_git *p,
+							     off_t obj_offset,
+							     enum object_type type,
+							     struct pack_window **w_curs,
+							     off_t curpos)
 {
 	off_t small_poi_stack[POI_STACK_PREALLOC];
 	off_t *poi_stack = small_poi_stack;
@@ -1378,8 +1380,8 @@ int packed_object_info(struct packed_git *p, off_t obj_offset,
 
 	if (oi->typep || oi->type_name) {
 		enum object_type ptot;
-		ptot = packed_to_object_type(p, obj_offset, type, &w_curs,
-					     curpos);
+		ptot = packed_to_object_type(the_repository, p, obj_offset,
+					     type, &w_curs, curpos);
 		if (oi->typep)
 			*oi->typep = ptot;
 		if (oi->type_name) {
-- 
2.17.0.441.gb46fe60e1d-goog

