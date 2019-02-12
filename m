Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 39FC51F453
	for <e@80x24.org>; Tue, 12 Feb 2019 22:27:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730882AbfBLW1S (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Feb 2019 17:27:18 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:39974 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728320AbfBLW1F (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Feb 2019 17:27:05 -0500
Received: by mail-ed1-f66.google.com with SMTP id 10so248840eds.7
        for <git@vger.kernel.org>; Tue, 12 Feb 2019 14:27:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9b6WJxQkqzKuMVIeWdt6VXP2PktlQs/OwfmEifFc4rg=;
        b=cDH4XQQ+5BeVv446UVHOXrQvyxmy7nRbJc3J4WP6dIXcxpge47SSBAg0mGPbQnXQCC
         R2Cdrd93LjIhHm03zCtx82BCc8Ek+kExXqpH9E66ImtVj/mitY5+/jwCo7BZskuxVY0l
         c3Ej58/xHl9WdZ8J7AhAQnDhBVDRmriHJSyOY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9b6WJxQkqzKuMVIeWdt6VXP2PktlQs/OwfmEifFc4rg=;
        b=q8QqGK8Dg4OjVdnpt2311n0T5KqyFKNcQWWZguTIW+l+fJi8mg2VAtmeMcG5s+1OZH
         h2dAMjwXQD4SlpW1PvykLxmrgqfTqdNIwXSr+rvSU4l+3F9ytA2wyGszCXadpf0FDjxQ
         YEPQDqLEXFUQv7PtB96n4iRDgSr+I75cE2yeZZ+nNorxBipbmoWuiz5bYO8zOghi2JP7
         VcWPTaZyXuIzD5iL4rrq6fel13zNSzwuBvDjPRIexob0Cf4QLgpESs+gtkoMpPH42HTV
         WJ52Hcnzt7sWHk46hPdz3sVQ9zk8YbZnXT6FEcRqAVnGZYhUmro7Ay1Ubd0Vhbmc0uVe
         ajYQ==
X-Gm-Message-State: AHQUAuYXn86oTIJ+zSilr/Jqos1enJSkAQjvWK8NgL6dTQFQtpHIQ3yO
        r/lrNij5fX+B3NS6OU9q+Fp8tjL6YoR2lCUp
X-Google-Smtp-Source: AHgI3IZKpNR6y70/VKimazbEBu1SQ2IHZ0twafw2l/6TfE/I+uhordeqOns8YYzjsuRzo7z+yh37mQ==
X-Received: by 2002:a17:906:595a:: with SMTP id g26mr4332621ejr.88.1550010423051;
        Tue, 12 Feb 2019 14:27:03 -0800 (PST)
Received: from prevas-ravi.waoo.dk (ip-5-186-119-174.cgn.fibianet.dk. [5.186.119.174])
        by smtp.gmail.com with ESMTPSA id ay20sm3349582ejb.32.2019.02.12.14.27.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Feb 2019 14:27:02 -0800 (PST)
From:   Rasmus Villemoes <rv@rasmusvillemoes.dk>
To:     git@vger.kernel.org
Cc:     Rasmus Villemoes <rv@rasmusvillemoes.dk>
Subject: [RFC PATCH 3/5] builtin/grep.c: add shorthand for &todo[todo_end] in add_work()
Date:   Tue, 12 Feb 2019 23:26:52 +0100
Message-Id: <20190212222654.7432-4-rv@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190212222654.7432-1-rv@rasmusvillemoes.dk>
References: <20190212222654.7432-1-rv@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Rasmus Villemoes <rv@rasmusvillemoes.dk>
---
 builtin/grep.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/builtin/grep.c b/builtin/grep.c
index 211ae54222..92b9e6198d 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -93,18 +93,20 @@ static int skip_first_line;
 
 static void add_work(struct grep_opt *opt, const struct grep_source *gs)
 {
+	struct work_item *w;
+
 	grep_lock();
 
 	while ((todo_end+1) % ARRAY_SIZE(todo) == todo_done) {
 		pthread_cond_wait(&cond_write, &grep_mutex);
 	}
 
-	todo[todo_end].source = *gs;
+	w = &todo[todo_end];
+	w->source = *gs;
 	if (opt->binary != GREP_BINARY_TEXT)
-		grep_source_load_driver(&todo[todo_end].source,
-					opt->repo->index);
-	todo[todo_end].done = 0;
-	strbuf_reset(&todo[todo_end].out);
+		grep_source_load_driver(&w->source, opt->repo->index);
+	w->done = 0;
+	strbuf_reset(&w->out);
 	todo_end = (todo_end + 1) % ARRAY_SIZE(todo);
 
 	pthread_cond_signal(&cond_add);
-- 
2.20.1

