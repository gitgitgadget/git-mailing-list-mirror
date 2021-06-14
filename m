Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF323C2B9F4
	for <git@archiver.kernel.org>; Mon, 14 Jun 2021 13:05:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C263C61244
	for <git@archiver.kernel.org>; Mon, 14 Jun 2021 13:05:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233532AbhFNNH4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Jun 2021 09:07:56 -0400
Received: from mail-wr1-f43.google.com ([209.85.221.43]:37501 "EHLO
        mail-wr1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232761AbhFNNHz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Jun 2021 09:07:55 -0400
Received: by mail-wr1-f43.google.com with SMTP id i94so14449026wri.4
        for <git@vger.kernel.org>; Mon, 14 Jun 2021 06:05:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=PQa5L1KH6AkV1ZWZqO7SPqfKkza6UvqSXdHO3NSlWVM=;
        b=AlDgWZTNL7JEr2Sg7qLSNddX3PJXCDVv1grhEsaJDjitnIMT/7kKYXt7lR2fNGlaaq
         34St4Ph0CNn4mr7SQsXaL3FrfMyqJFq1S3/nmE8eWYtRwLDZ/bIcihjqjAYrKY0+fyp/
         h50pBV91MfjL5otMCnHhkGfLXv9kiZTdruhlpp3T0u368074YzigAzR7a+yE1fUF6PkK
         rG29At0ubz4/hTpE/IP/tTtHIy0y3XkiqzJcWYHwGWkwdpBjesV0TGcwfhJq5YjrbAW3
         Nu4wlxJxDotE3T/i/5QMEE/XDQDLGWz60puGrge4gZkS7iktt0q/BGKMPEWgq9Y1hU9Q
         Rdbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=PQa5L1KH6AkV1ZWZqO7SPqfKkza6UvqSXdHO3NSlWVM=;
        b=L9gfS50MV+/4JG4SQcJ6LXhhOaL3Pf3LmZZcJym50uHSDF0BXIgMYgNJiZOnbOiX9W
         WOaZR2+QVvlpaH8CFAe8rEaJBU46s9NZYXcxGxYXw3XTDdMvNxGmNRADBviK2umzsOul
         0iYaObuyaraxNYqfTJ8XC4Ks36oWhYw/gW/39yFf5ZXnCIN7vOwswmIRTQFfrmwVCI5t
         0cFgeM5b6cxjCCO5GAGuBsY+ANi5vi7o2Oc9n8Ch6rh+OG/RVGgw7aHOo8YdzbQVbfko
         VV/BfvI6zGw8VX7ac7X436nEWMzC+4LqxOPcYG4gM/JTIa/0V2g6t25B7mxcuMhDfgMc
         X1Sg==
X-Gm-Message-State: AOAM530ICuuVrkTnjRGtckt4q2vLWRSU4cCyFFY5sinIM0JQP4f1jI1E
        oNEScF2VievLBUpmmxTJ67xch6CdFKg=
X-Google-Smtp-Source: ABdhPJwyGxCY19InqctOJBwOFAyd9T0qW9EU8VsMBLIBg6xcjrXvQbqf7Woz2A1wlEI+pUgGCbpPGw==
X-Received: by 2002:adf:ff88:: with SMTP id j8mr18729917wrr.10.1623675892364;
        Mon, 14 Jun 2021 06:04:52 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h9sm20100291wmm.33.2021.06.14.06.04.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jun 2021 06:04:52 -0700 (PDT)
Message-Id: <30f0ed447683506735ecc37f553b655f23769385.1623675889.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.981.git.1623675888.gitgitgadget@gmail.com>
References: <pull.981.git.1623675888.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 14 Jun 2021 13:04:41 +0000
Subject: [PATCH 03/10] diff: simplify allow-indentation-change delta
 calculation
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Phillip Wood <phillip.wood@dunelm.org.uk>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

Now that we reliably end a block when the sign changes we don't need
the whitespace delta calculation to rely on the sign.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 diff.c | 13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/diff.c b/diff.c
index a0c43a104768..19c8954ec546 100644
--- a/diff.c
+++ b/diff.c
@@ -864,23 +864,17 @@ static int compute_ws_delta(const struct emitted_diff_symbol *a,
 	    a_width = a->indent_width,
 	    b_off = b->indent_off,
 	    b_width = b->indent_width;
-	int delta;
 
 	if (a_width == INDENT_BLANKLINE && b_width == INDENT_BLANKLINE) {
 		*out = INDENT_BLANKLINE;
 		return 1;
 	}
 
-	if (a->s == DIFF_SYMBOL_PLUS)
-		delta = a_width - b_width;
-	else
-		delta = b_width - a_width;
-
 	if (a_len - a_off != b_len - b_off ||
 	    memcmp(a->line + a_off, b->line + b_off, a_len - a_off))
 		return 0;
 
-	*out = delta;
+	*out = a_width - b_width;
 
 	return 1;
 }
@@ -924,10 +918,7 @@ static int cmp_in_block_with_wsd(const struct diff_options *o,
 	 * match those of the current block and that the text of 'l' and 'cur'
 	 * after the indentation match.
 	 */
-	if (cur->es->s == DIFF_SYMBOL_PLUS)
-		delta = a_width - c_width;
-	else
-		delta = c_width - a_width;
+	delta = c_width - a_width;
 
 	/*
 	 * If the previous lines of this block were all blank then set its
-- 
gitgitgadget

