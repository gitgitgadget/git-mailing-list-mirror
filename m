Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D5EB71F461
	for <e@80x24.org>; Sun, 18 Aug 2019 18:28:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727059AbfHRS2P (ORCPT <rfc822;e@80x24.org>);
        Sun, 18 Aug 2019 14:28:15 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:38709 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726927AbfHRS2P (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 18 Aug 2019 14:28:15 -0400
Received: by mail-wm1-f66.google.com with SMTP id m125so1097061wmm.3
        for <git@vger.kernel.org>; Sun, 18 Aug 2019 11:28:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rOuvYwCPrEvpM1MdzqfsZnAM2NuXgVbgQdSPCyG2SKc=;
        b=rN7EgwjDiGx5Z/xfdwniwzVJfv5iLdtSt+Wq6XHofwLZYZRMbPWQKgnLzqdYDKPsKe
         Tyov6ROGX9mYobAhSlzPhgQ9gUBUi2c2TrT0zCEYebkRzrSKE7rC37qO4aXM9m9uV30Q
         ISX4Pf6Ioy8YE9PgH1Ast6R8w2/NChsA5ZCdbfu14mC6/keIIP4luE0VwCnbJ1ve/Or5
         AivFzKZenE6MWN5ZlgIRa5qJALG2LP0SVTJ5z/UtDZNXH03Uu1FqimIhNJa22RWqClHE
         93ygKKvI+d1GRq+K21WlqGTrX4r3czXT5vVcnxDcAPqEWir8pNvuEXR0CB1pmn/SzTA8
         FX5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rOuvYwCPrEvpM1MdzqfsZnAM2NuXgVbgQdSPCyG2SKc=;
        b=jKwHnTrXkZocw+xUftuvEuSyhjRkLhDB5asQFSfJKt6sXQmPxQWMOPCUON+abCTOis
         GD73DgsnLXuh5YzIwy/RH/6F8VnUQBQ9WFm6FwFJwwz6RjoVd+qSPumohCPE1BVmlPdf
         1Z1icNW+JLJYVVGARQiu/mePU7LoRu3lpcSfFARGKugtmRWBkFabhyRq+bBZWOBMNF/S
         fXrOeQVtWXy92oJHCW7JPqQ+e0Q3osPRHe19iok2qT+U+e8dJkxQBKfZFmlaPEMShxLo
         Vz4mL65zoUKL4VjWG2+dvsNE8ImDRLGoVsCghZfZu8hT5/Ok5W9/Nb0h67uoKw173BEX
         6q4w==
X-Gm-Message-State: APjAAAVvjg7GGgjul8Lod4K5l1qbSosQVhTiRzojwV7iCygK/Rm4YWkM
        8/1+EtU5tJu6AYbxhSoqrBlwtZ36
X-Google-Smtp-Source: APXvYqxo/t4zhzh5WKViAgJ67N8rDuq55/yXQtLIpa9vS2UZTDBpr9zuhFpLCnEZtYs/cvHOyj1YwA==
X-Received: by 2002:a1c:6782:: with SMTP id b124mr17642142wmc.143.1566152893183;
        Sun, 18 Aug 2019 11:28:13 -0700 (PDT)
Received: from localhost.localdomain (x4db53457.dyn.telefonica.de. [77.181.52.87])
        by smtp.gmail.com with ESMTPSA id c201sm24112584wmd.33.2019.08.18.11.28.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 18 Aug 2019 11:28:12 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Thomas Rast <tr@thomasrast.ch>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [RFC PATCH 2/5] line-log: remove unused fields from 'struct line_log_data'
Date:   Sun, 18 Aug 2019 20:27:58 +0200
Message-Id: <20190818182801.7580-3-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.23.0.349.g73f10e387d
In-Reply-To: <20190818182801.7580-1-szeder.dev@gmail.com>
References: <20190818182801.7580-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Remove the unused fields 'status', 'arg_alloc', 'arg_nr' and 'args'
from 'struct line_log_data'.  They were already part of the struct
when it was introduced in commit 12da1d1f6 (Implement line-history
search (git log -L), 2013-03-28), but as far as I can tell none of
them have ever been actually used.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 line-log.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/line-log.h b/line-log.h
index 8ee7a2bd4a..882c5055bb 100644
--- a/line-log.h
+++ b/line-log.h
@@ -46,10 +46,7 @@ void sort_and_merge_range_set(struct range_set *);
 struct line_log_data {
 	struct line_log_data *next;
 	char *path;
-	char status;
 	struct range_set ranges;
-	int arg_alloc, arg_nr;
-	const char **args;
 	struct diff_filepair *pair;
 	struct diff_ranges diff;
 };
-- 
2.23.0.349.g73f10e387d

