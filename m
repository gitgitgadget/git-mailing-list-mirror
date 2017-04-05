Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2907D20966
	for <e@80x24.org>; Wed,  5 Apr 2017 17:49:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755374AbdDERtX (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Apr 2017 13:49:23 -0400
Received: from mail-pg0-f49.google.com ([74.125.83.49]:32839 "EHLO
        mail-pg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754384AbdDERrb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Apr 2017 13:47:31 -0400
Received: by mail-pg0-f49.google.com with SMTP id x125so11525194pgb.0
        for <git@vger.kernel.org>; Wed, 05 Apr 2017 10:47:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=DIAPeS8v/aRg669Y8n8mkkoUiWsSYdsEhm/WSBRdjDw=;
        b=A4iuyE962L0BbathFUT7skvmPdK8VE9JlPv6IBYVBQReCorMTl3eX1r5ErN6oqXNLw
         xmcy/tYDDuLP5Pfm7V8SSO36lgGzmcXQpOH8tolpXirowgw53xRBki1Ew6nrkl3Uxb2M
         P1R8/WOJf8IT8BlKQQBDxlKp6HpfMkWY/3jkEtX46JDiOwvlBnESPlet6wn7jjCiqz8r
         CatTao2a1tAeM2fBkBIPgbzcqyiibipVcqTjY4c9WNCQzLjMJ0YnM1cKC6NVysbRmYxn
         IUjIYl9hZMmnKZjE+mNkM1Nw7eZB7Pxs6+ne1gKxNLPLrJWVZOfJ2YxfZU+lABYTmkoT
         WHwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=DIAPeS8v/aRg669Y8n8mkkoUiWsSYdsEhm/WSBRdjDw=;
        b=M8K22OTXQDQ6tmIPfskTIDMRu9g1YwjBnG4SKQMd4ajlK44XZUJJ+HOhqNAVyr4zj4
         MBv9357HwMUs/FUTmOMm3l0G27ghpqh3md/m6WEvIhk7VQGyAAgEfYfjo9W1OWFCreOq
         nSVTvakbK9LBTGWNfhc/qRLc65krxJ8eoD+UCNUe1KAQs2i+KafT4XEEazCN8GCbsbd8
         79mIn7yGDPpB1dPeAr9Fg/Dtmr+kHt5teu0nMQ7uGfpEqlPtVq+ZgUCply5//0rM0WCy
         DjrOgifND3VIQEth0Gcx0YOV/vOC/NnY5K3TQqOpJeXLQUxCSWZFowkp5KA4MMPPEQ9d
         QV5g==
X-Gm-Message-State: AFeK/H0u1dKW1uB0UhwrhYsa5m8g7zFJ3EmkqA17QRmaHjerGTJ0Z+e19UWA8UrnaZc+CqKk
X-Received: by 10.84.232.205 with SMTP id x13mr38020990plm.102.1491414450587;
        Wed, 05 Apr 2017 10:47:30 -0700 (PDT)
Received: from roshar.mtv.corp.google.com ([100.96.238.26])
        by smtp.gmail.com with ESMTPSA id m69sm38726623pfc.33.2017.04.05.10.47.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 05 Apr 2017 10:47:29 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>, jrnieder@gmail.com
Subject: [PATCH v3 3/5] remote: expose parse_push_refspec function
Date:   Wed,  5 Apr 2017 10:47:17 -0700
Message-Id: <20170405174719.1297-4-bmwill@google.com>
X-Mailer: git-send-email 2.12.2.715.g7642488e1d-goog
In-Reply-To: <20170405174719.1297-1-bmwill@google.com>
References: <20170331235623.166408-1-bmwill@google.com>
 <20170405174719.1297-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A future patch needs access to the 'parse_push_refspec()' function so
let's export the function so other modules can use it.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 remote.c | 2 +-
 remote.h | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/remote.c b/remote.c
index 9f83fe2c4..d335a6417 100644
--- a/remote.c
+++ b/remote.c
@@ -630,7 +630,7 @@ struct refspec *parse_fetch_refspec(int nr_refspec, const char **refspec)
 	return parse_refspec_internal(nr_refspec, refspec, 1, 0);
 }
 
-static struct refspec *parse_push_refspec(int nr_refspec, const char **refspec)
+struct refspec *parse_push_refspec(int nr_refspec, const char **refspec)
 {
 	return parse_refspec_internal(nr_refspec, refspec, 0, 0);
 }
diff --git a/remote.h b/remote.h
index dd8c51757..42c8f017b 100644
--- a/remote.h
+++ b/remote.h
@@ -169,6 +169,7 @@ struct ref *ref_remove_duplicates(struct ref *ref_map);
 
 int valid_fetch_refspec(const char *refspec);
 struct refspec *parse_fetch_refspec(int nr_refspec, const char **refspec);
+extern struct refspec *parse_push_refspec(int nr_refspec, const char **refspec);
 
 void free_refspec(int nr_refspec, struct refspec *refspec);
 
-- 
2.12.2.715.g7642488e1d-goog

