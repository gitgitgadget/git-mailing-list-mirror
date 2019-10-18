Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 037EF1F4C0
	for <e@80x24.org>; Fri, 18 Oct 2019 11:42:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436663AbfJRLmJ (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Oct 2019 07:42:09 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41087 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729803AbfJRLmJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Oct 2019 07:42:09 -0400
Received: by mail-wr1-f68.google.com with SMTP id p4so5898254wrm.8
        for <git@vger.kernel.org>; Fri, 18 Oct 2019 04:42:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4W/wkMkunrrCHXuaOkllrsvW/tolMfkAU6MJxM9tVtY=;
        b=g0a/gZHqRKj6WXeL4MKoQ6a011PYAiEjUUABt9kkTKdU/4dLIpaDhsvQUE1DJXb+Sx
         gy/kIiN/SfE/GGXMzCnuLig85AJaSJ36SeVdlax0aeaeA8KS00bNqk7v1LoyCGRTAqCt
         wzVBhZaNn/Q4MyC09hgz4kNzXUlG7U69C+dINQHk6ntyaJQTx1jPe4aMa4jhbk3WXVs/
         v3udtHqpgVG3CXVkKPfkYFBQPu5kMsZDWA6tY4jzzeW41/FNUa7UiS+w1FKN/Z7SNPfK
         gvlikNWh+8rXZBpfxmlR+p5Kv22h4ShV8I6vyKeJu+1ZHyhCVTe0g7L0zKi7csp6PnkL
         ZV5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4W/wkMkunrrCHXuaOkllrsvW/tolMfkAU6MJxM9tVtY=;
        b=FpHbWdwzhD1CtDIZ9cFHBqCKHcc5ZEuR5sdC8nb7gFb/jl5i+Ma5+tE1KuIv0wG0U1
         FNbu9rIyKRQY9GYuxiKm3zsr81llfm0POiim9HJHOELuPwfocbPmoAtSEJMS9psb3RFL
         ni0TqD68AN9C6FJUIGHaY3FMbngZ0j2ceNSoVyxctXx4FBO/yENFNn63nSae9efqBWww
         mP5Q16HbBNPNplmJLmuFRdoVKDL4G/r5HEb8CtZlfJffkb64ODksXIV9iKRHbQ55GMf0
         BESsnFuoyhlNqCMCkyxb1zWk+mYBy1R0PdiAx7FaPQFPTEvfet8tw2LDeYV7XG7tajoh
         zmUA==
X-Gm-Message-State: APjAAAUWsG4qahKZiqRW3USHDhi/ZgGdC+7PURJi+TrKMb69FbCAzL+s
        y5gaZYNtPN43QT/XVSrPURs=
X-Google-Smtp-Source: APXvYqyRU9P4wZ0VNSJcaR6c7XFzTxcmvW/B+KOEXZGa4R6JGKINpbpzgxZWBQb+FGcy2ZSMPl+jbw==
X-Received: by 2002:adf:e886:: with SMTP id d6mr7731155wrm.188.1571398927358;
        Fri, 18 Oct 2019 04:42:07 -0700 (PDT)
Received: from localhost.localdomain (x4dbd7267.dyn.telefonica.de. [77.189.114.103])
        by smtp.gmail.com with ESMTPSA id e9sm14611523wme.3.2019.10.18.04.42.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 18 Oct 2019 04:42:06 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 1/2] path.c: fix field name in 'struct common_dir'
Date:   Fri, 18 Oct 2019 13:42:01 +0200
Message-Id: <20191018114202.5452-2-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.23.0.1084.gae250eaa40
In-Reply-To: <20191018114202.5452-1-szeder.dev@gmail.com>
References: <20191018110618.GZ29845@szeder.dev>
 <20191018114202.5452-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

An array of 'struct common_dir' instances is used to specify whether
various paths in the '.git' directory are worktree-specific or belong
to the main worktree.  Confusingly, the path is recorded in the
struct's 'dirname' field, even though it can be a regular file, e.g.
'gc.pid'.

Rename this 'dirname' field to 'path' to avoid future confusion.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 path.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/path.c b/path.c
index e3da1f3c4e..eeb43e1d25 100644
--- a/path.c
+++ b/path.c
@@ -103,7 +103,7 @@ struct common_dir {
 	unsigned is_dir:1;
 	/* Not common even though its parent is */
 	unsigned exclude:1;
-	const char *dirname;
+	const char *path;
 };
 
 static struct common_dir common_list[] = {
@@ -320,8 +320,8 @@ static void init_common_trie(void)
 	if (common_trie_done_setup)
 		return;
 
-	for (p = common_list; p->dirname; p++)
-		add_to_trie(&common_trie, p->dirname, p);
+	for (p = common_list; p->path; p++)
+		add_to_trie(&common_trie, p->path, p);
 
 	common_trie_done_setup = 1;
 }
@@ -365,8 +365,8 @@ void report_linked_checkout_garbage(void)
 		return;
 	strbuf_addf(&sb, "%s/", get_git_dir());
 	len = sb.len;
-	for (p = common_list; p->dirname; p++) {
-		const char *path = p->dirname;
+	for (p = common_list; p->path; p++) {
+		const char *path = p->path;
 		if (p->ignore_garbage)
 			continue;
 		strbuf_setlen(&sb, len);
-- 
2.23.0.1084.gae250eaa40

