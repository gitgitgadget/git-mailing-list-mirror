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
	by dcvr.yhbt.net (Postfix) with ESMTP id 26C411F454
	for <e@80x24.org>; Mon,  4 Nov 2019 20:04:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729074AbfKDUD7 (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Nov 2019 15:03:59 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:42759 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728332AbfKDUD7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Nov 2019 15:03:59 -0500
Received: by mail-pg1-f195.google.com with SMTP id s23so8750703pgo.9
        for <git@vger.kernel.org>; Mon, 04 Nov 2019 12:03:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ajk4p9YJkLKcm/THm7WAAf8oXLtntlz+KmZyJalxkrA=;
        b=q8KbXz/k4CFXpvrA9BLq4cTB4n0yMr20F95kpolBeNF8/RD4Pdg+Lzo5+058gHDfmZ
         Yv+8W1klOh51Zg1WM1HnFy93r46IXW0v4lWyQfH4O3WS+8m3DzGkfUraSZb4P/lG8zt2
         DU1H+30iYRo4hqiumkZ0qV1biDS0UEcWiv9JmKuAYpOBOOJq6HU1ryrHfiS/e6olFcKU
         58wIofJd4UcW7VS9VAnbKTiX6Wb5CNIvsIsdgB/6TjBCZyvgKjOHtKsEM7Yv31RR8Qlj
         s+DcAWsadcyqs4F5yeoeNn1qobAm5VBnttwhnV9nspxvTL0VW9p5mWwwnxRLIc62wZAJ
         kYdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ajk4p9YJkLKcm/THm7WAAf8oXLtntlz+KmZyJalxkrA=;
        b=IW3NtX3zI0+uPcHkEPDrPYhnbyMo3umArnuerBAfWkmSqxF8M4x8MI2H1xui4cxSM7
         Wa2vNWUhkxY/ZoUKqnpCK702vSSFnmsUtweiKXpmqx9tj8R0QfripF/dYNEbtv97Fe56
         yC8ANgF6o/iCKhlblAzxPXL7/8r2ZSWxwMYK4fYsmUbWw9ZZwMBMisAb481rjQIaJPT8
         YXcU0pVc2KslCGLobpN3ZlsnX5oKXqi4dSdqDhNR6fMJ9zPo0vQtSEqXsU754cNma2NI
         XRdqBD97WQrCiSKcMmRP6VDGRQYjB3pV2HiCHktKsP5HMMfO2B3gRQP4RQ1+nfi9HGiu
         lVWw==
X-Gm-Message-State: APjAAAV3kdMhfRdKVZAGN1NYS3RLxOWlzjn/4RL/DJjb+dLe0VIzfRCq
        5Vgyb1EeD0y7ELxkgogTkLHxTnjb
X-Google-Smtp-Source: APXvYqyAdTKD9s9tA9Gp4ZDpbOGFX2DxLTGmaaSWZsICpQfse3bbGlSe6vc/xtKF+PUT/vTieD2fGQ==
X-Received: by 2002:a62:5c07:: with SMTP id q7mr32447108pfb.159.1572897838148;
        Mon, 04 Nov 2019 12:03:58 -0800 (PST)
Received: from generichostname ([204.14.236.210])
        by smtp.gmail.com with ESMTPSA id s66sm5642758pfb.38.2019.11.04.12.03.57
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2019 12:03:57 -0800 (PST)
Date:   Mon, 4 Nov 2019 15:03:55 -0500
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Subject: [PATCH 4/8] pretty.c: inline initalize format_context
Message-ID: <1551e903225bb4f7652341382d0c1cf71b9bd7d4.1572897736.git.liu.denton@gmail.com>
References: <cover.1572897736.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1572897736.git.liu.denton@gmail.com>
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
2.24.0.rc2.262.g2d07a97ef5

