Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54618C7EE24
	for <git@archiver.kernel.org>; Thu, 11 May 2023 19:49:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239549AbjEKTtR (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 May 2023 15:49:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239296AbjEKTtA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 May 2023 15:49:00 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C388019AE
        for <git@vger.kernel.org>; Thu, 11 May 2023 12:48:31 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-b9a25f6aa0eso16599566276.1
        for <git@vger.kernel.org>; Thu, 11 May 2023 12:48:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683834509; x=1686426509;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=gRMkr+SycjDvz2+GlyrqXqvYM51IGPPLPMyTbt4DRGs=;
        b=xyTVF5xCciiHjOtzP61VNCV6aqvvdfvuo7dQq6IBUG+1s1pcaxuhuEfwp5q4tUkKzy
         maU987u3XNssFfv6EL+B23qPc77iECtPU3vKv/hMmd10JWeXmw/pO7dxxGzG6wL49G6/
         APochnoSds0cYJa1o7oLgf0Koh5yDl0rZAT4WMF96xLcOs640mVlGAWqLB7+bU90xZ3C
         h4I+43g5k7Kj/uC6Nb8hZNNAGsAwtnhfQ6mN+lgrxXcmR3EPeHjilHfowmPjF+APjRBH
         qLom2gffX8zV/vm8/tvU343RoEgDcpdrAJQaZPlFfksg+ll68zAo9BWi3gd5EWf0b3j1
         6IeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683834509; x=1686426509;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gRMkr+SycjDvz2+GlyrqXqvYM51IGPPLPMyTbt4DRGs=;
        b=FyRrMrzEi+5+CLR3nZT5oYsXN1SivcQuA9CxTR85n6F1JD74DLKE8rBQYUN7qtbALi
         BGRkvFFMzUJ0lDlH0XfVAf4WoHmJ9Wawy789cv4wp/MYfqj+S0tmzPW6e+SLplfuojhF
         SdeOWtpXYuSzAsrHSorw2WVMT9fj2zpTVjEVAffisrs+GTQf1BcWtraiAnzaqav6SEN9
         f8EAmY60y2/loTIwUMKIHupGe5RBtHEH1ovf39sg2sQDbgDViBjFmqip9Wkh94my9uVK
         CIfe+y++ZCrHoHUz1aWPEbfcmE3Rekf8emJLFiTJcYMHkyUZns/48RSbL25DqKg026NW
         GHWg==
X-Gm-Message-State: AC+VfDy6jxdjiWRJ+ESDpueuqlA6eJs63D2/clokWAgLF5ixwzwhdmop
        GODoCAbckeAG2K/nyysTkd/6IPOcSkT8gM3XSNH0vvQiyfCR9meH8tuClgM5KUvvrM5iVTR7hmj
        4ZRP4Mil/bjEUZNY8rrHc65VBr4UVahauhbitvx9WtX63Oofrxg2CjztO8/QaZbFgdw==
X-Google-Smtp-Source: ACHHUZ4F/f/e+Zsu32BoTsl9V+uOUKgjxFsJQflIUogBW87PkUC4jL7F52g7eblkKZgjuifBWYX0tbBh9+BvGUU=
X-Received: from barleywine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3bd4])
 (user=calvinwan job=sendgmr) by 2002:a05:6902:154b:b0:ba6:db51:a7e4 with SMTP
 id r11-20020a056902154b00b00ba6db51a7e4mr821917ybu.11.1683834509597; Thu, 11
 May 2023 12:48:29 -0700 (PDT)
Date:   Thu, 11 May 2023 19:48:18 +0000
In-Reply-To: <20230511194446.1492907-1-calvinwan@google.com>
Mime-Version: 1.0
References: <20230511194446.1492907-1-calvinwan@google.com>
X-Mailer: git-send-email 2.40.1.606.ga4b1b128d6-goog
Message-ID: <20230511194822.1493798-3-calvinwan@google.com>
Subject: [PATCH v5 3/7] credential-store: move related functions to
 credential-store file
From:   Calvin Wan <calvinwan@google.com>
To:     git@vger.kernel.org
Cc:     Calvin Wan <calvinwan@google.com>, newren@gmail.com, peff@peff.net,
        phillip.wood123@gmail.com, sunshine@sunshineco.com
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
index e1c0c326f2..90ad8b8892 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -691,9 +691,6 @@ int strbuf_check_branch_ref(struct strbuf *sb, const char *name);
 
 typedef int (*char_predicate)(char ch);
 
-int is_rfc3986_unreserved(char ch);
-int is_rfc3986_reserved_or_unreserved(char ch);
-
 void strbuf_addstr_urlencode(struct strbuf *sb, const char *name,
 			     char_predicate allow_unencoded_fn);
 
-- 
2.40.1.606.ga4b1b128d6-goog

