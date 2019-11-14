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
	by dcvr.yhbt.net (Postfix) with ESMTP id 869461F4B5
	for <e@80x24.org>; Thu, 14 Nov 2019 20:47:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726930AbfKNUrX (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Nov 2019 15:47:23 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:41909 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726828AbfKNUrX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Nov 2019 15:47:23 -0500
Received: by mail-pl1-f194.google.com with SMTP id d29so3177077plj.8
        for <git@vger.kernel.org>; Thu, 14 Nov 2019 12:47:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5ckFk1SKge4sl8AzBKrIMNXLchM2nADw8OthvBu1SiM=;
        b=neI0DlHc6ntfdkmbeYdptLfA1VJfFBzlQ6ucGhIHtpWAygwIi6gSM/e5NU0PuO9v6Q
         EXTIOp1A7bqR1TE7fDd531bWjrjzFQ3Jx+dPkOPQYFD8CAmByJTjfOl+ti9M0WZ3y6lR
         2mcIe6E0cGxg0iChoaVcU3qrzCXo+SnSNbIc/AZXrgiuTElPtCXnj09+vo/yl+fJHAvi
         pv3QHC7+Eb0YRmVCR/Lixb95SmSZ2hvYRGRhPvNQLXkVnIMpkfoPc6751avVmG+NgmiY
         uRHWDm2l6LPOeUjySBUFEPoBCwqPa/KQrWPBRyZxRZowewINQyVcPk8WaKbX1hP6zyWw
         0P9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5ckFk1SKge4sl8AzBKrIMNXLchM2nADw8OthvBu1SiM=;
        b=uhgobBWBjp+llnytPjVX0xSq2Ha+Bntp0vWgSl43+mUgLgKxgFzlL87duGitQHDD43
         Re7hzqwVSU/Au2Injx2D/8QVfmf8F9QpKCLf29yREF6ZZMLp691jLWPmW+MyYsFpDgQw
         053r9ZDSgR5AAyDzy0J+YyebASskpgf2Jb5GsA3xNUOUtwIj93V088q53BSV7IOaV/UX
         mbhWlZKfcpMjGONYobJq4xlEmHSnIG8RzOQ+cO4QUZN20PJpOyaZJcJfJEZvB//qb3jm
         48WfvzPhX1UtqeK81jlmHEijFpDH5izPB6A6UAXbQee/Lqj73Pu86jzjTjFUinfOO5pb
         0afQ==
X-Gm-Message-State: APjAAAVRZiawFHaUebf6qhQT4aH2NYFwc2Ehu1soB33oKmQ/NssyOiAj
        kyXgiLcJxEq9dG6Jr6+GV6p5mvSk
X-Google-Smtp-Source: APXvYqwXIHF1M/KKHSPNjbtw6ZYwoZ5OpdgzY6otzURuWakOwCfh4s8JwJk7pXmfL6uU7KdRXJxWwQ==
X-Received: by 2002:a17:902:bb84:: with SMTP id m4mr11359870pls.255.1573764441225;
        Thu, 14 Nov 2019 12:47:21 -0800 (PST)
Received: from generichostname ([204.14.239.54])
        by smtp.gmail.com with ESMTPSA id e5sm5861530pjv.29.2019.11.14.12.47.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2019 12:47:20 -0800 (PST)
Date:   Thu, 14 Nov 2019 12:47:19 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Subject: [PATCH v3 06/10] pretty.c: inline initalize format_context
Message-ID: <301e3adcdcf77b993bd3cbe934a2336536d1d580.1573764280.git.liu.denton@gmail.com>
References: <cover.1573241590.git.liu.denton@gmail.com>
 <cover.1573764280.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1573764280.git.liu.denton@gmail.com>
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
2.24.0.346.gee0de6d492

