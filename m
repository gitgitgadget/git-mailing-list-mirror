Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 21A2420259
	for <e@80x24.org>; Wed,  7 Dec 2016 15:36:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753352AbcLGPgy (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Dec 2016 10:36:54 -0500
Received: from mail-pf0-f193.google.com ([209.85.192.193]:35664 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752635AbcLGPgv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Dec 2016 10:36:51 -0500
Received: by mail-pf0-f193.google.com with SMTP id i88so11380171pfk.2
        for <git@vger.kernel.org>; Wed, 07 Dec 2016 07:36:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ktD89p+97GnC2lyJa4OXFfbzO+M4rYNII6cXGJxdBAI=;
        b=hcyDm2tBZK8iAl/QYoeaatmW+OhDfd9dsZWVG04Al/xVPplO+Erv0BakLgvt1L5nwx
         nRJAOJ+snn/Xa0jX0/NPNEK/UCRl618AGO23Y4V1NvqmUmjIYgZ5FkfrpsJ4DAUPuZMt
         er11gqU7Tfc3RqgkaK+fZrJpeYUvr4ju7UYoHDsRnnv4KSA3swd1upRt6VTv6TODUca3
         Yb3Wsv6YQUCboOJW8gjPJG+r7FQKMv8KccSwPH6VbD5CYBI7SompL96RN0gIV2qHkXQV
         BJi9rprSRulQpE/zv2hvm//QqepWeUytYV6LFouhpULA2K2xekSD56IUBMg4MQHuQxif
         GbtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ktD89p+97GnC2lyJa4OXFfbzO+M4rYNII6cXGJxdBAI=;
        b=mzvf0cT4dDk12Cy8ANFFJQP6iLtGT5aT84OqXJP10Omc26+qUdCF+t4cxxGtr4gwr0
         STpthLZcuwXAzBIj1X04ltGFfy1ENeI29g924owbCU+hnX8YxQUjFDhodnWnCOjq1IJO
         YfwN74L/t5ONvcm36UWlGbRqEyDF8sH/OKyyQz7QOGCpkssD5Wq4Z40mSZRowD9F1vgV
         TMvGWnYIkIlqH2antanrOPG9ZQxC/KWMDsySCHr3/c3LedG7KV/imasnoxAdpCg9aQfT
         AaTQ5wpqpDwQePxO7tB8ECWoFCvC/xarmCmFe7bkx4/Ct8FT3GvsHCndH2Z4sBTdGIUq
         F5Lg==
X-Gm-Message-State: AKaTC03Om+lQlmDks4PIu+3zKFkhiQa0ZHXjdI5Vk20aoyjx8OCRUqw/Ja6pe6aT8ak+ug==
X-Received: by 10.99.137.66 with SMTP id v63mr122300886pgd.117.1481124967209;
        Wed, 07 Dec 2016 07:36:07 -0800 (PST)
Received: from AamlaJuice.corp.endurance.com ([122.15.255.69])
        by smtp.gmail.com with ESMTPSA id l7sm43584459pfg.35.2016.12.07.07.36.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Dec 2016 07:36:06 -0800 (PST)
From:   Karthik Nayak <karthik.188@gmail.com>
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
To:     git@vger.kernel.org
Cc:     jacob.keller@gmail.com, gitster@pobox.com, jnareb@gmail.com,
        Karthik Nayak <karthik.188@gmail.com>,
        Karthik Nayak <Karthik.188@gmail.com>
Subject: [PATCH v8 02/19] ref-filter: include reference to 'used_atom' within 'atom_value'
Date:   Wed,  7 Dec 2016 21:06:10 +0530
Message-Id: <20161207153627.1468-3-Karthik.188@gmail.com>
X-Mailer: git-send-email 2.10.2
In-Reply-To: <20161207153627.1468-1-Karthik.188@gmail.com>
References: <20161207153627.1468-1-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Karthik Nayak <karthik.188@gmail.com>

Ensure that each 'atom_value' has a reference to its corresponding
'used_atom'. This let's us use values within 'used_atom' in the
'handler' function.

Hence we can get the %(align) atom's parameters directly from the
'used_atom' therefore removing the necessity of passing %(align) atom's
parameters to 'atom_value'.

This also acts as a preparatory patch for the upcoming patch where we
introduce %(if:equals=) and %(if:notequals=).

Signed-off-by: Karthik Nayak <Karthik.188@gmail.com>
---
 ref-filter.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index 2fed7fe..5166326 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -230,11 +230,9 @@ struct ref_formatting_state {
 
 struct atom_value {
 	const char *s;
-	union {
-		struct align align;
-	} u;
 	void (*handler)(struct atom_value *atomv, struct ref_formatting_state *state);
 	unsigned long ul; /* used for sorting when not FIELD_STR */
+	struct used_atom *atom;
 };
 
 /*
@@ -370,7 +368,7 @@ static void align_atom_handler(struct atom_value *atomv, struct ref_formatting_s
 	push_stack_element(&state->stack);
 	new = state->stack;
 	new->at_end = end_align_handler;
-	new->at_end_data = &atomv->u.align;
+	new->at_end_data = &atomv->atom->u.align;
 }
 
 static void if_then_else_handler(struct ref_formatting_stack **stack)
@@ -1070,6 +1068,7 @@ static void populate_value(struct ref_array_item *ref)
 		struct branch *branch = NULL;
 
 		v->handler = append_atom;
+		v->atom = atom;
 
 		if (*name == '*') {
 			deref = 1;
@@ -1134,7 +1133,6 @@ static void populate_value(struct ref_array_item *ref)
 				v->s = " ";
 			continue;
 		} else if (starts_with(name, "align")) {
-			v->u.align = atom->u.align;
 			v->handler = align_atom_handler;
 			continue;
 		} else if (!strcmp(name, "end")) {
-- 
2.10.2

