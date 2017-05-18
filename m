Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 44FA9201CF
	for <e@80x24.org>; Thu, 18 May 2017 23:22:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932622AbdERXW2 (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 May 2017 19:22:28 -0400
Received: from mail-pg0-f53.google.com ([74.125.83.53]:35859 "EHLO
        mail-pg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754833AbdERXWY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 May 2017 19:22:24 -0400
Received: by mail-pg0-f53.google.com with SMTP id x64so29454433pgd.3
        for <git@vger.kernel.org>; Thu, 18 May 2017 16:22:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=AXX8GcoYb+XtAHXMzmlz5uyPnWG0unFfn3nhWGZpyHk=;
        b=ssHf2VxxpwvT4/4nEZy4+SbAECH8gi+1ZnUNu0SY9vohsfrU8YwLnAcCWbUy8HvH/E
         pbbHbgnnEA3CyXtqhOyxkaZmJ8CIGwF9JYGHz8HiXxXSAuMFp+UDO1hCpUsdXwnPDghu
         W/Xms4F2xC+Ns2GiXdlwpp2vQXGw4f5bCZA7i29mtzC0srIBZ976lIXMcyh+i21aYs1+
         QGOZNiWWUKoClG8pc+QYBZw1OcxYUNl8v7AHMnQkELhYdFxXq0mVSvVEKK1SqzZfHx14
         tlzhbKr27pndaEUMRPB4xtGm0Kbk/X6mJWlaT5TJSS09GOYtGP7uwsIPnlv4oypT9YT+
         ruyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=AXX8GcoYb+XtAHXMzmlz5uyPnWG0unFfn3nhWGZpyHk=;
        b=VUnKG8XYCQjNlmLkunD/eSJGz9Q1iw5/cpfOFqFpEtkQ36TpkTPdiKYr4S8GHmZwq8
         65r9GihTMXHa1fSxBOAQu6vQnX5eb01JF94nlbtqZGhPcuXnhA4KFPTrhgrDWxa7xlkj
         lkITrgd5oIUHxEe5MW5MArikDgzQFoqW7de/8d2LV9gqyaYlO5b9XWzq5rLOZe5pNYNG
         +xeBhw4J3NqyDHv8SwXbMsNZ7thKFAUt+xeEqVcEnjw5i7BUcSowtxCbjqHEdCbdIylh
         7ac0k/g0mjpLdyjN02lGTRQ/UCzS9MnWSG2mwGU4jUHizgGgKJl8ZwWVP0bR4XkBirO1
         wb+g==
X-Gm-Message-State: AODbwcAWcjGX8WemEKvJfihJE8dLSHw+/Vv/oKLDXmyDfSiufArGl+wA
        j0QGheh+e5zkLmpg
X-Received: by 10.84.232.3 with SMTP id h3mr7847815plk.42.1495149743197;
        Thu, 18 May 2017 16:22:23 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id d3sm12579575pfg.30.2017.05.18.16.22.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 18 May 2017 16:22:22 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Johannes.Schindelin@gmx.de, gitster@pobox.com, peff@peff.net,
        sbeller@google.com, jrnieder@gmail.com, pclouds@gmail.com,
        Brandon Williams <bmwill@google.com>
Subject: [WIP/RFC 11/23] ls-files: convert show_ru_info to take an index
Date:   Thu, 18 May 2017 16:21:22 -0700
Message-Id: <20170518232134.163059-12-bmwill@google.com>
X-Mailer: git-send-email 2.13.0.303.g4ebf302169-goog
In-Reply-To: <20170518232134.163059-1-bmwill@google.com>
References: <20170518232134.163059-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 builtin/ls-files.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index 3d4e497cc..755dfc8d6 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -292,14 +292,14 @@ static void show_ce_entry(const char *tag, const struct cache_entry *ce)
 	strbuf_release(&name);
 }
 
-static void show_ru_info(void)
+static void show_ru_info(const struct index_state *istate)
 {
 	struct string_list_item *item;
 
-	if (!the_index.resolve_undo)
+	if (!istate->resolve_undo)
 		return;
 
-	for_each_string_list_item(item, the_index.resolve_undo) {
+	for_each_string_list_item(item, istate->resolve_undo) {
 		const char *path = item->string;
 		struct resolve_undo_info *ui = item->util;
 		int i, len;
@@ -685,7 +685,7 @@ int cmd_ls_files(int argc, const char **argv, const char *cmd_prefix)
 	}
 	show_files(&dir);
 	if (show_resolve_undo)
-		show_ru_info();
+		show_ru_info(&the_index);
 
 	if (ps_matched) {
 		int bad;
-- 
2.13.0.303.g4ebf302169-goog

