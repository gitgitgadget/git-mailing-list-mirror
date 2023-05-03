Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 323BEC7EE21
	for <git@archiver.kernel.org>; Wed,  3 May 2023 18:51:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229752AbjECSvJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 May 2023 14:51:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbjECSux (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 May 2023 14:50:53 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6112D7EF0
        for <git@vger.kernel.org>; Wed,  3 May 2023 11:50:41 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id d2e1a72fcca58-63b68f53f0dso6030371b3a.1
        for <git@vger.kernel.org>; Wed, 03 May 2023 11:50:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683139841; x=1685731841;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=/R0a/kHnyx4o9/HChG7nHUd642uhvmHNwkgsegQmtY8=;
        b=Os0Q/C/UD0pEyAAMv/RQhMXmxWj1Mzuw2TFjbySPpTD5V/NtfEQk6v0PJWyHZG8Uvs
         D2neVt1puVirgcpAEgAKuCFnbrrWrfn2U+08QKsI+TBb60XUG8HRtHlErvSg7TtYifAF
         1wxjzOysjxDYtQA+vfb5SzGj9DAzlrH0HNImdh7EEkPGKJFZNWKhF2szds3hC42yNRly
         pY8RkkM6PdeRBGDMlbim66rD6Lg7xyBmCo0qQKrDqn9BXAL/WpOrFBPtZSq6+VpeKAWM
         Dge2AiK4kUvEbE3K7Y972Tdhc0MisQ1Q06ik7Hb7PG4x3/VtGaCHy02iUKxEM0MyXWwN
         azrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683139841; x=1685731841;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/R0a/kHnyx4o9/HChG7nHUd642uhvmHNwkgsegQmtY8=;
        b=X/i+gz5p9roiYGKbys6S86MzWPuZQ45pXHwSTNjLADmV0MsK0KnY5lWDm4Itt8wqXO
         IXdNthV1cgnbXq1GzvgE33mgpkfNeb/nmQMl1SuI2WbxG8yzaFnFJbUis3fws9xj5tKo
         FF4zc7NQ5fVJ21yWa8oVUcTvvj9tPnIum4Q4a/VWq4X3kKZksIR/6OlP83uYpA8Yy2ON
         wpw0B6dwl/AGpYhmoI1Jp/z58A3Nmg1/IWvsSqt8qnVmVJgXVgMWqMRd6uQfokfzyX3o
         eUH68hbX5g5QZIpXjbfjhe5fTP2JWlLvUWoSik9TIUY17c87rKM15T24+ut/vaoMCVXM
         RxXA==
X-Gm-Message-State: AC+VfDywMIDqLFCQOJLLSMKg0Z6kFIBuC+nlDAnXU2nRu+2m3DaE2b6h
        f0J4HW3mc1dtDM3lDk0qyRPxOG1RnR14E/qco6rscxiArbns47sXlNQA/FZV6TxS5jXsXrF3PdE
        MKsG4wiTqaQ9AiUhFi7JgAYHhHSH8Gi4UzIfUT1iO2uNuHF0HUNT9AXFwPcSLdhggMw==
X-Google-Smtp-Source: ACHHUZ4X46d5IKbHhbKsXn7stpUkw+eYPxwPTvyj2/K49JFbXqh9sB5/1tJgKUiGEDM7VBJPWq9xKNmU+Cpor3s=
X-Received: from barleywine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3bd4])
 (user=calvinwan job=sendgmr) by 2002:a05:6a00:26ec:b0:63b:7b21:3560 with SMTP
 id p44-20020a056a0026ec00b0063b7b213560mr5312191pfw.3.1683139840732; Wed, 03
 May 2023 11:50:40 -0700 (PDT)
Date:   Wed,  3 May 2023 18:50:27 +0000
In-Reply-To: <20230503184849.1809304-1-calvinwan@google.com>
Mime-Version: 1.0
References: <20230503184849.1809304-1-calvinwan@google.com>
X-Mailer: git-send-email 2.40.1.521.gf1e218fcd8-goog
Message-ID: <20230503185031.1810078-3-calvinwan@google.com>
Subject: [PATCH v2 3/7] credential-store: move related functions to
 credential-store file
From:   Calvin Wan <calvinwan@google.com>
To:     git@vger.kernel.org
Cc:     Calvin Wan <calvinwan@google.com>, newren@gmail.com, peff@peff.net
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

is_rfc3986_unreserved() and is_rfc3986_reserved_or_unreserved() are only
called from builtin/credential-store.c and they are only relevant to that
file so move those functions and make them static.

Signed-off-by: Calvin Wan <calvinwan@google.com>
---
 builtin/credential-store.c | 19 +++++++++++++++++++
 strbuf.c                   | 19 -------------------
 strbuf.h                   |  3 ---
 3 files changed, 19 insertions(+), 22 deletions(-)

diff --git a/builtin/credential-store.c b/builtin/credential-store.c
index 8977604eb9..4776118331 100644
--- a/builtin/credential-store.c
+++ b/builtin/credential-store.c
@@ -73,6 +73,25 @@ static void rewrite_credential_file(const char *fn, struct credential *c,
 		die_errno("unable to write credential store");
 }
 
+static int is_rfc3986_unreserved(char ch)
+{
+	return isalnum(ch) ||
+		ch == '-' || ch == '_' || ch == '.' || ch == '~';
+}
+
+static int is_rfc3986_reserved_or_unreserved(char ch)
+{
+	if (is_rfc3986_unreserved(ch))
+		return 1;
+	switch (ch) {
+		case '!': case '*': case '\'': case '(': case ')': case ';':
+		case ':': case '@': case '&': case '=': case '+': case '$':
+		case ',': case '/': case '?': case '#': case '[': case ']':
+			return 1;
+	}
+	return 0;
+}
+
 static void store_credential_file(const char *fn, struct credential *c)
 {
 	struct strbuf buf = STRBUF_INIT;
diff --git a/strbuf.c b/strbuf.c
index c3b6d48797..da2693b21f 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -809,25 +809,6 @@ void strbuf_addstr_xml_quoted(struct strbuf *buf, const char *s)
 	}
 }
 
-int is_rfc3986_reserved_or_unreserved(char ch)
-{
-	if (is_rfc3986_unreserved(ch))
-		return 1;
-	switch (ch) {
-		case '!': case '*': case '\'': case '(': case ')': case ';':
-		case ':': case '@': case '&': case '=': case '+': case '$':
-		case ',': case '/': case '?': case '#': case '[': case ']':
-			return 1;
-	}
-	return 0;
-}
-
-int is_rfc3986_unreserved(char ch)
-{
-	return isalnum(ch) ||
-		ch == '-' || ch == '_' || ch == '.' || ch == '~';
-}
-
 static void strbuf_add_urlencode(struct strbuf *sb, const char *s, size_t len,
 				 char_predicate allow_unencoded_fn)
 {
diff --git a/strbuf.h b/strbuf.h
index 20d0e37d9c..9e52fe7706 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -686,9 +686,6 @@ int strbuf_check_branch_ref(struct strbuf *sb, const char *name);
 
 typedef int (*char_predicate)(char ch);
 
-int is_rfc3986_unreserved(char ch);
-int is_rfc3986_reserved_or_unreserved(char ch);
-
 void strbuf_addstr_urlencode(struct strbuf *sb, const char *name,
 			     char_predicate allow_unencoded_fn);
 
-- 
2.40.1.521.gf1e218fcd8-goog

