Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DAF8C1F454
	for <e@80x24.org>; Fri,  8 Nov 2019 20:08:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388776AbfKHUIb (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Nov 2019 15:08:31 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:33040 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388378AbfKHUI3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Nov 2019 15:08:29 -0500
Received: by mail-pf1-f195.google.com with SMTP id c184so5378485pfb.0
        for <git@vger.kernel.org>; Fri, 08 Nov 2019 12:08:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wNCQJQlkOva73o8g3XoQtN11SPK9APmln6xrWZvBFig=;
        b=OOYTqpDzaVhjQwp4tOOSn6uY/bNiaWOXckI2ddvszlbztpQ9W0EmaFuDzSoH71mCLY
         qPrhe6Yrlh8QGD2nroLceH1EgzevMiWdhKq+uJ678N/1Bp2mZFv6ePOJbzQl1QO/H9eV
         PXuMFQgqAHnNZZrrUhRh5lDvYoyXT99HIlS4ktLLpWnEqRaJAbmEatfltpCObSjHxOFe
         g2ZUYQ6XW35vYw3godXnytUNMo/rc+aogWUg23kc9jssN6B7o4DpHSn5y8oLx7Kg8cwl
         B8EzCGF80lfmn2Unu6kZhUdaifswbCdAz7WtyyET5zgIOzzquVmmm1PrFyZp6udT8UbX
         Oupg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wNCQJQlkOva73o8g3XoQtN11SPK9APmln6xrWZvBFig=;
        b=cMgIzRZW5Oksk3BlDH0ENOshE4jn5IpJ7sSftt4FmHzDQEDi/fWGp5z06WR6s3buwR
         Avlmt6Fh//e9pM+nafO9QQLvYCtIROtUe4LKbsS4QpSDGi+SxoH9vyNnryg+inWs6H4A
         m0s9ouyrd68ESBtWn9xQRW6FmSrQD0BegWT3l1eZZPHq13hUG2MUWk5nyA72Fsbaf7Ua
         YOllYeun8WdewVjwty3HCmdD7xasE5jVm+CT82W4jvv8pUNM8Vh5LouM7dHPerZwpIGA
         Mx26FmOmgvx2tV2pu6nc4LKmPcBvlBkVjqtx3zslQ8llw+IeVKyUNEI7ckwHOdJDkSMw
         JAmw==
X-Gm-Message-State: APjAAAWhlDtOpzBvpcoq5GPw025xe971FelJRl5bXq8gfVIEKKHZ9ppL
        Fx95n2YsxdnIfBDbhFf011M0MwbT
X-Google-Smtp-Source: APXvYqwwoFVSSesXZuQhOM0Cb31xpL5KhvyWwqfI/O9+0fla1eA5lchL7ErnxRFIOs3PUqh7KM6N0Q==
X-Received: by 2002:a17:90a:d205:: with SMTP id o5mr16226323pju.46.1573243707839;
        Fri, 08 Nov 2019 12:08:27 -0800 (PST)
Received: from generichostname ([204.14.239.137])
        by smtp.gmail.com with ESMTPSA id 65sm12461080pff.2.2019.11.08.12.08.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2019 12:08:27 -0800 (PST)
Date:   Fri, 8 Nov 2019 12:08:25 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 05/10] pretty.c: inline initalize format_context
Message-ID: <a2e90c78e64633824000da41fb0b72afb8f1ab52.1573241590.git.liu.denton@gmail.com>
References: <cover.1572897736.git.liu.denton@gmail.com>
 <cover.1573241590.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1573241590.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Instead of memsetting and then initializing the fields in the struct,
move the initialization of `format_context` to its assignment.

In preparation for a future commit where we mechanically move lines from
repo_format_commit_message() into a helper function,
`format_context.wrap_start` is not generically used so move its
assignment closer to its use.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 pretty.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/pretty.c b/pretty.c
index b32f036953..6f2b0ad917 100644
--- a/pretty.c
+++ b/pretty.c
@@ -1610,14 +1610,13 @@ void repo_format_commit_message(struct repository *r,
 				const char *format, struct strbuf *sb,
 				const struct pretty_print_context *pretty_ctx)
 {
-	struct format_commit_context context;
+	struct format_commit_context context = {
+		.commit = commit,
+		.pretty_ctx = pretty_ctx
+	};
 	const char *output_enc = pretty_ctx->output_encoding;
 	const char *utf8 = "UTF-8";
 
-	memset(&context, 0, sizeof(context));
-	context.commit = commit;
-	context.pretty_ctx = pretty_ctx;
-	context.wrap_start = sb->len;
 	/*
 	 * convert a commit message to UTF-8 first
 	 * as far as 'format_commit_item' assumes it in UTF-8
@@ -1626,6 +1625,7 @@ void repo_format_commit_message(struct repository *r,
 					       &context.commit_encoding,
 					       utf8);
 
+	context.wrap_start = sb->len;
 	strbuf_expand(sb, format, format_commit_item, &context);
 	rewrap_message_tail(sb, &context, 0, 0, 0);
 
-- 
2.24.0.298.g3e88fbd976

