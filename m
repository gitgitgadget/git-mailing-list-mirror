Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 850551F462
	for <e@80x24.org>; Thu, 20 Jun 2019 08:30:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726445AbfFTIay (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Jun 2019 04:30:54 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:40893 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726175AbfFTIax (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Jun 2019 04:30:53 -0400
Received: by mail-wm1-f65.google.com with SMTP id v19so2183460wmj.5
        for <git@vger.kernel.org>; Thu, 20 Jun 2019 01:30:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bAy/tuS4kuRcRk9ClUC32w5qgALHhZumXtI3PYos/M8=;
        b=QbSxj4OySuHRmGPxNzlXILF9chCnRTw/5nfUMrd3G4euJp54LLnB3ZAIdQoOIiwHeI
         Z5TXSbGSIkVPRoWJAYhpBxoY1lC8gKELwS+YSLcOPQ/qT/5fHepAwwmEJb57BXET5TyZ
         Rv8uR3bnp0t3ykNVjzt+NCBA6vyOePmIKht5gM7iNscgszUFYqmqobGncMOSb/8Qp6WY
         gn4Zlu7TL2oIjt+2v/UYY9l/gXfB1tdnRU/upz77ccgFghMfQtNjKMBfGZGJbnK/Qoby
         GWJeiEjlHSYGrjF8GyYNppBhFjMEpCMq/7pyTrv9vR01gnLVItDMkoHZt6Rw47SCZszc
         D0oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bAy/tuS4kuRcRk9ClUC32w5qgALHhZumXtI3PYos/M8=;
        b=EQFCoVdNYpTgdYx7GzFIrvfIP31UI32KZXIc9VVJVPLQh686wbSKSI9Wh5QWcM8vYr
         fLTNKhPhqaB2kGdolEuzUNnYTwvMY8lWXZD8i3p5lzljfj151N8NbHIC0DaEW0E+lpa5
         O9iTy/C2uWlcSASu9jTV5Dp6yHWKjQt2VXZd3DjC/fR+XxMh1UuMKNN5iIcfotNCmMhn
         h9Z7EwOClS5LOYUKE3rXlZJfjlZwX+W2O8AuUE0jjuawp/igqtRgzWg8S9Zz14TCGDz9
         UJkf2wmUc0O0IWn8ilm5+K6tonBKMmWclNBRVD/Au6RBxu56G6SqRUU/ZtWB3uYE9xLP
         t0+Q==
X-Gm-Message-State: APjAAAV/EvbafdYNVlS19INhTxXhoSKC84PTAEeZcl2N3eZ0sLzgGJkl
        d7r92YImJTLa7CJsD5MhmFfqKmm2DUw=
X-Google-Smtp-Source: APXvYqxBIZL6hWFGrByB+pgUTY/RUyDLYRdCVZU8PG/HkcQPHLrRt0IAhR1TIJEBOS9qWsSuwi0Zhw==
X-Received: by 2002:a1c:6641:: with SMTP id a62mr1693189wmc.175.1561019452139;
        Thu, 20 Jun 2019 01:30:52 -0700 (PDT)
Received: from localhost.localdomain (73.38.126.78.rev.sfr.net. [78.126.38.73])
        by smtp.gmail.com with ESMTPSA id f204sm5578039wme.18.2019.06.20.01.30.51
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 20 Jun 2019 01:30:51 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Derrick Stolee <stolee@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 2/2] sha1-file: use OBJECT_INFO_NO_FETCH_IF_MISSING
Date:   Thu, 20 Jun 2019 10:30:26 +0200
Message-Id: <20190620083026.14524-3-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190620083026.14524-1-chriscool@tuxfamily.org>
References: <20190620083026.14524-1-chriscool@tuxfamily.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently the OBJECT_INFO_FOR_PREFETCH flag is used to check
if we should fetch objects from promisor remotes when we
haven't found them elsewhere.

Now that OBJECT_INFO_NO_FETCH_IF_MISSING exists, let's use
it instead to be more correct in case this new flag is ever
used without OBJECT_INFO_QUICK.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 sha1-file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sha1-file.c b/sha1-file.c
index ed5c50dac4..2116ff1e70 100644
--- a/sha1-file.c
+++ b/sha1-file.c
@@ -1379,7 +1379,7 @@ int oid_object_info_extended(struct repository *r, const struct object_id *oid,
 		/* Check if it is a missing object */
 		if (fetch_if_missing && repository_format_partial_clone &&
 		    !already_retried && r == the_repository &&
-		    !(flags & OBJECT_INFO_FOR_PREFETCH)) {
+		    !(flags & OBJECT_INFO_NO_FETCH_IF_MISSING)) {
 			/*
 			 * TODO Investigate having fetch_object() return
 			 * TODO error/success and stopping the music here.
-- 
2.22.0

