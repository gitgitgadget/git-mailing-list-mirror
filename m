Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3739F1F4B5
	for <e@80x24.org>; Tue, 19 Nov 2019 00:21:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727111AbfKSAV0 (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Nov 2019 19:21:26 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:43719 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726911AbfKSAVZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Nov 2019 19:21:25 -0500
Received: by mail-pg1-f193.google.com with SMTP id b1so938891pgq.10
        for <git@vger.kernel.org>; Mon, 18 Nov 2019 16:21:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ATydt2gStsPzGlfw35c/TIvcRfCbOqX6DXYPyWRJPGg=;
        b=VDjA+ZmtIDAjDHhNv8unLOC+dlBYnixgv82laRJY4TE97bOkmr7GcVRprRvntvFiJV
         IncmRk6p6PuRzNyfA2ybaRiWMZxEUqDYQ7g0f0L6Ys1ParFsbooRWSeABmRjTCBHFrJQ
         Ma6XQao8/L3u2nazWGmAQYmUvRXjuPfUlMNscGe15GMBCVPan9ax80oQ49mHEFiWnclx
         j7ONLK/LVsBtHOpTihSyXEECXnc5N65mQbYVnHD3/mx3V+oCFkzJqZuIb44UA7mz30yx
         QF+Fuu+c82Fs+ENnuWuOGO1tQDHEA5m8cG1becF7HW16o7nvK47MjhWxliMU+QSeKGu6
         hoYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ATydt2gStsPzGlfw35c/TIvcRfCbOqX6DXYPyWRJPGg=;
        b=hwFf02ufC6OTpa2BeLOIeUrSpLWCh8Fo3x6MfZrTWvA/4ys2fXPyGyyN980bI4rpWL
         LKu4O/MBsyGcYgGwPrKhyXVsDzLqW5M8TZcAnbtXZ3LCj5fXRwLNKbPVWIPn4ngzEHsu
         Y2FKqwrgZK5BFFTqWLrkjuLK86SCEy/mje8aUNpolzx+1kVUbpOfzxhyrtwKqSokJ3ud
         zrm4/GDObh3r1JUxCJXfZ3yjDLJbdp75p4Sh0PLJ688fqYr8s3l61Qt3TPPvrQ3JtsU6
         2GF79xYOiboAaMmk/MztOsVjSZaaad1mMAhQeP3lXmHH3I4ulGBgOiz7QOvaQtrERw2k
         7LPA==
X-Gm-Message-State: APjAAAXmAQH4ubkzcyxfQQgzlQI1JhDnxWDHzVN8ldlB6pcKSOZthMvQ
        +qCoTVnp6Pn+QIhCPqXa/OSfJokC
X-Google-Smtp-Source: APXvYqzX5Cg+CDJFDCRY5P088AD1Ez8AMDa4tGMfcX+K+2+l8Iigzj4o2DRzEoHTTICkmbE/Mlpjww==
X-Received: by 2002:a63:4a1a:: with SMTP id x26mr2096971pga.298.1574122884760;
        Mon, 18 Nov 2019 16:21:24 -0800 (PST)
Received: from generichostname ([204.14.239.83])
        by smtp.gmail.com with ESMTPSA id s1sm14657064pgk.9.2019.11.18.16.21.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2019 16:21:24 -0800 (PST)
Date:   Mon, 18 Nov 2019 16:21:22 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Todd Zullinger <tmz@pobox.com>
Subject: [PATCH v4 06/11] pretty.c: inline initalize format_context
Message-ID: <34e1b6a7ac8e1f6f678bee35e9356dead5f45e0b.1574122784.git.liu.denton@gmail.com>
References: <cover.1573764280.git.liu.denton@gmail.com>
 <cover.1574122784.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1574122784.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Instead of memsetting and then initializing the fields in the struct,
move the initialization of `format_context` to its assignment.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 pretty.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/pretty.c b/pretty.c
index 93eb6e8370..4d633f14fa 100644
--- a/pretty.c
+++ b/pretty.c
@@ -1617,14 +1617,14 @@ void repo_format_commit_message(struct repository *r,
 				const char *format, struct strbuf *sb,
 				const struct pretty_print_context *pretty_ctx)
 {
-	struct format_commit_context context;
+	struct format_commit_context context = {
+		.commit = commit,
+		.pretty_ctx = pretty_ctx,
+		.wrap_start = sb->len
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
-- 
2.24.0.420.g9ac4901264

