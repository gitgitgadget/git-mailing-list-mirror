Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EA845203BD
	for <e@80x24.org>; Fri, 28 Oct 2016 18:56:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964858AbcJ1S4J (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Oct 2016 14:56:09 -0400
Received: from mail-pf0-f177.google.com ([209.85.192.177]:33426 "EHLO
        mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1034224AbcJ1S4A (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Oct 2016 14:56:00 -0400
Received: by mail-pf0-f177.google.com with SMTP id 197so41759061pfu.0
        for <git@vger.kernel.org>; Fri, 28 Oct 2016 11:56:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Md6dlcYC32231eXJTTKomQ2nnRoqAMwvbF9LgQytofE=;
        b=YFQaNe/t/25GQvqw4669ULyyQJvlR6hWC4zWyT9E93GYPUL6g589kmk6TwXQy81Wqp
         DuI6BEVGDz3kZkPj8/6doHqF02d4qmAE1Xb7nkQ42Khj3ZEJyyVkSjZlFGz2NpBsAT4o
         SZZNxcfvOpnMSQ1XsdaxdxpXL5+6t3RMrOLC1UQgDNAR3LsjySC/hBXbFkxLtzY2q6yp
         b9bZqk/gOipkl88Ph7M29xa56ooS5dLcaGinIhOreZRRFqWmyxrtv/OOQLeLV0pIyEjr
         7NenNRg8byShzq4ZI1XVtxtrvgi2PiLwjmsPkQXvPW3VgvWtIzt1974bKiOAJj7VqScf
         +YHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Md6dlcYC32231eXJTTKomQ2nnRoqAMwvbF9LgQytofE=;
        b=i9RfKbz1U2mci7chQPaFGeFd06FMibyq/Lo6JG98QHJv3UxdMa66fEA661lh+CR/1H
         QOfUCXeJLFFTVBCTTDOomHd3A+DsbCMtc5FcOGEXCGk40LvZeIS1Xl9gLWjEXNjheLt0
         ZnuVMNGNLVF+zPLYd1rW/0C5I2A6pdxpcxH7K6XOw5f5hfWWK45tdCtpMNX9KBCY9Z/T
         E9OTz4IWgnnUpMKQuWCUgfe1G5S0mszc3igS26tk4pegiRTSnMsM9Ldpd69MHhrlBTjR
         A2aJh+E7TJteWidiThx8qADW34XNssaj27+1vYbkjjkwYnI2xGVngcTgHQeFK0yMVFZI
         XOGg==
X-Gm-Message-State: ABUngvfnL035s031aUw3Iix31rSjEPrBK6cHqUlz+kabMZyFCSZZQTSZiO0hmFgnwuhsNqbg
X-Received: by 10.99.237.69 with SMTP id m5mr22775755pgk.113.1477680959858;
        Fri, 28 Oct 2016 11:55:59 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:91ed:bb99:5319:17e9])
        by smtp.gmail.com with ESMTPSA id l7sm20535179pfk.80.2016.10.28.11.55.59
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 28 Oct 2016 11:55:59 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     bmwill@google.com, pclouds@gmail.com, git@vger.kernel.org,
        Stefan Beller <sbeller@google.com>
Subject: [PATCHv2 21/36] attr.c: rename a local variable check
Date:   Fri, 28 Oct 2016 11:54:47 -0700
Message-Id: <20161028185502.8789-22-sbeller@google.com>
X-Mailer: git-send-email 2.10.1.714.ge3da0db
In-Reply-To: <20161028185502.8789-1-sbeller@google.com>
References: <20161028185502.8789-1-sbeller@google.com>
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
index 47ab59c157..c85685da29 100644
--- a/attr.c
+++ b/attr.c
@@ -686,12 +686,12 @@ static int macroexpand_one(int attr_nr, int rem);
 
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
2.10.1.714.ge3da0db

