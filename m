Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DD6711F424
	for <e@80x24.org>; Wed,  9 May 2018 23:41:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965975AbeEIXlN (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 May 2018 19:41:13 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:40953 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965244AbeEIXlM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 May 2018 19:41:12 -0400
Received: by mail-pf0-f196.google.com with SMTP id f189-v6so135140pfa.7
        for <git@vger.kernel.org>; Wed, 09 May 2018 16:41:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4mNvGtTAmkgPnKgKUBUUGBqZbuslgVuJJfTswSiDFt8=;
        b=B60SZq422GTO8Ggrq5Dkbs/iSdk0ot9e7OXRRNp7UkccbjxpIokr9rIc+qiec1YOPk
         aYimDcnkeGFlwP/8El74gYjyq7boEG76eh3v5W60HYQkpnoieRIdN9V3AvGJj2L4m44F
         ASzeGwutokWeqUiKPtegyzbs0oOGNWGeJ09hTRDIZAe17AaL5tuitZtPpXonD8qkIRAw
         FvqaMHOhW6KOyvRUGzd0ym6Wk5wOZsECvkNOq3lveHC9x+Ei2EhBFiXg36HrI8kUJZ2G
         +byzPbh4rpJYsQZ4IavV3wvsOjuH8YWHE1YgZTecc+TMKRz83FFBNWA8+J17AxRG1luZ
         7K0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4mNvGtTAmkgPnKgKUBUUGBqZbuslgVuJJfTswSiDFt8=;
        b=dy6d7EfztBodu4BTO6ADkQ+YOWojXTd7ypNNKue4Jgps7qa9sp+SLiuiIHSbK2Mz6o
         e7uxY2ALxYgbvDIId6BtYWqPAqnvDsDbiCpfX+5X7grne/BOCP3SF7lYrVbxlLGHR12v
         qDNq2ffKyiPOv/CZG5VNA4Gr5pC1RmRqqXHbyoiY7OryRmeTXb45wCDLqeRU9LosdbO9
         LZzuXfNPLb+PcXoAvG/hpOROYVZ2GMgWsvAICp17te+IAvWEcaKzkSW1gAiOrqiZPeU4
         IIViHbbSAPirYCRvrps3USlOojNmrOIvO6F6FrY4L1HBhg7obacumq1+TxNZzfZBYmo/
         +kww==
X-Gm-Message-State: ALQs6tDn1ywistCu7Oojn3bj88tMzUD9u7WCjBE68FVzSwdMvMoT6NTw
        UmHz+5by8zYeqLLWlMWaor127wT/8BE=
X-Google-Smtp-Source: AB8JxZrrBpWCpNKjT1u+6ufjVUqp2uM1u0+UU3b87h5cL5dpzZ5TcYTuygFvJfaNJ6xRna+FhvIzsQ==
X-Received: by 2002:a65:5b4d:: with SMTP id y13-v6mr37209565pgr.152.1525909271304;
        Wed, 09 May 2018 16:41:11 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id r20sm62713526pff.152.2018.05.09.16.41.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 09 May 2018 16:41:10 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: [PATCH 2/2] replace-object.c: remove the_repository from prepare_replace_object
Date:   Wed,  9 May 2018 16:40:59 -0700
Message-Id: <20180509234059.52156-2-sbeller@google.com>
X-Mailer: git-send-email 2.17.0.255.g8bfb7c0704
In-Reply-To: <20180509234059.52156-1-sbeller@google.com>
References: <20180509234059.52156-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This was missed in 5982da9d2ce (replace-object: allow
prepare_replace_object to handle arbitrary repositories, 2018-04-11)

Technically the code works correctly as the replace_map is the same
size in different repositories, however it is hard to read. So convert
the code to the familiar pattern of dereferencing the pointer that we
assign in the sizeof itself.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 replace_object.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/replace_object.c b/replace_object.c
index 246b98cd4f1..801b5c16789 100644
--- a/replace_object.c
+++ b/replace_object.c
@@ -37,7 +37,7 @@ static void prepare_replace_object(struct repository *r)
 		return;
 
 	r->objects->replace_map =
-		xmalloc(sizeof(*the_repository->objects->replace_map));
+		xmalloc(sizeof(*r->objects->replace_map));
 	oidmap_init(r->objects->replace_map, 0);
 
 	for_each_replace_ref(r, register_replace_ref, NULL);
-- 
2.17.0.255.g8bfb7c0704

