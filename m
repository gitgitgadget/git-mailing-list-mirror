Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4514220A10
	for <e@80x24.org>; Mon,  2 Oct 2017 00:33:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751337AbdJBAdL (ORCPT <rfc822;e@80x24.org>);
        Sun, 1 Oct 2017 20:33:11 -0400
Received: from mail-pf0-f180.google.com ([209.85.192.180]:48252 "EHLO
        mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750969AbdJBAdK (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 1 Oct 2017 20:33:10 -0400
Received: by mail-pf0-f180.google.com with SMTP id n24so2137065pfk.5
        for <git@vger.kernel.org>; Sun, 01 Oct 2017 17:33:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dtipQPBRpflhXJ53G/njvWk1SM6jwRYbIsMLB4Dq8yQ=;
        b=nfVGFxaSJ7a2VQFVe0GTC1X3H9PkZ2XF5feOSY8bbfWuk4czWysSpEricLfoppvaMm
         CQjJdBg45u6BoJzJXCc+bEYd+PebBEamEwcoyXtNw0zbRMwKqOPWgAv+7mKgoEsyFHpD
         A6e1R50n5upG4C+2DSfutGGhrQlXTO/OeXKkifG6bWwHI7ClpCH6vj6+5ANvptGkZWXr
         0lMLuRRBJXoNjMyJtZjCnY6+Wc2ubzondTN2gMRWGnp/QFtdboDUovgL3LlLfxDyu/pi
         z9yM2KdGZ37ZZ/yu6M90jPp0NSnIfej7w6KyCRRXZKK09Hme1TDW9iFrb9ZnaYBFuyME
         ItkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=dtipQPBRpflhXJ53G/njvWk1SM6jwRYbIsMLB4Dq8yQ=;
        b=R4rj9DRHRWQ+KGHLmPDGhKXIWlEzI9oGr65rFhea6Op3AUN8DfPc9K/1P5gSYNjG7c
         ADIHlrLP7YPDANmF6UnRfMVOYNuKOT+0B0wsEUUAltOe/mktGg5Sp1VYZbw4chNTGxn5
         jy/XB7KZ2HA8zgLM9wOFHNYYKqIq7j4kFMVuIPQyte7iaD3B/naEFClhOX7+Oo7nQOEG
         paW5myzTD5Yg4GBtmTxn45303lzVThkiRuyfEb821o66O5sJ+M95PU15n7qSI8cIjw6v
         4m/4tM6RKz5Ak4+iG/O1KOLldUNO6r//al3+ST6uwG+olS56lY8cfgqJb4evf9Vdo/g4
         rsFw==
X-Gm-Message-State: AHPjjUiOG/TEndbnLRL8Ht8CAdEKO9QK2N6xWrRliqOtgp/2aFkMnmbx
        ve8qVl0IhoH+wOtkCk1qkvanOAjq/KM=
X-Google-Smtp-Source: AOwi7QAY1+bjnB9JHgHO8XMsxZwWllElSPjUA5XauBOUm2NFLMdIJ8U5n7JBe/iR9yo6e0kCMg3uQg==
X-Received: by 10.98.155.76 with SMTP id r73mr13288331pfd.182.1506904389445;
        Sun, 01 Oct 2017 17:33:09 -0700 (PDT)
Received: from localhost ([205.175.97.239])
        by smtp.gmail.com with ESMTPSA id p10sm16246947pfd.152.2017.10.01.17.33.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 01 Oct 2017 17:33:07 -0700 (PDT)
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, Taylor Blau <me@ttaylorr.com>
Subject: [PATCH v5 1/6] pretty.c: delimit "%(trailers)" arguments with ","
Date:   Sun,  1 Oct 2017 17:32:59 -0700
Message-Id: <20171002003304.77514-1-me@ttaylorr.com>
X-Mailer: git-send-email 2.14.1.145.gb3622a4ee
In-Reply-To: <20171002003116.GA69902@D-10-157-251-166.dhcp4.washington.edu>
References: <20171002003116.GA69902@D-10-157-251-166.dhcp4.washington.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In preparation for adding consistent "%(trailers)" atom options to
`git-for-each-ref(1)`'s "--format" argument, change "%(trailers)" in
pretty.c to separate sub-arguments with a ",", instead of a ":".

Multiple sub-arguments are given either as "%(trailers:unfold,only)" or
"%(trailers:only,unfold)".

This change disambiguates between "top-level" arguments, and arguments
given to the trailers atom itself. It is consistent with the behavior of
"%(upstream)" and "%(push)" atoms.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 pretty.c                      | 32 +++++++++++++++++++++++++++-----
 t/t4205-log-pretty-formats.sh |  4 ++--
 2 files changed, 29 insertions(+), 7 deletions(-)

diff --git a/pretty.c b/pretty.c
index 94eab5c89..7500fe694 100644
--- a/pretty.c
+++ b/pretty.c
@@ -1056,6 +1056,23 @@ static size_t parse_padding_placeholder(struct strbuf *sb,
 	return 0;
 }
 
+static int match_placeholder_arg(const char *to_parse, const char *candidate,
+				const char **end)
+{
+	const char *p;
+	if (!(skip_prefix(to_parse, candidate, &p)))
+		return 0;
+	if (*p == ',') {
+		*end = p + 1;
+		return 1;
+	}
+	if (*p == ')') {
+		*end = p;
+		return 1;
+	}
+	return 0;
+}
+
 static size_t format_commit_one(struct strbuf *sb, /* in UTF-8 */
 				const char *placeholder,
 				void *context)
@@ -1285,11 +1302,16 @@ static size_t format_commit_one(struct strbuf *sb, /* in UTF-8 */
 
 	if (skip_prefix(placeholder, "(trailers", &arg)) {
 		struct process_trailer_options opts = PROCESS_TRAILER_OPTIONS_INIT;
-		while (*arg == ':') {
-			if (skip_prefix(arg, ":only", &arg))
-				opts.only_trailers = 1;
-			else if (skip_prefix(arg, ":unfold", &arg))
-				opts.unfold = 1;
+		if (*arg == ':') {
+			arg++;
+			for (;;) {
+				if (match_placeholder_arg(arg, "only", &arg))
+					opts.only_trailers = 1;
+				else if (match_placeholder_arg(arg, "unfold", &arg))
+					opts.unfold = 1;
+				else
+					break;
+			}
 		}
 		if (*arg == ')') {
 			format_trailers_from_commit(sb, msg + c->subject_off, &opts);
diff --git a/t/t4205-log-pretty-formats.sh b/t/t4205-log-pretty-formats.sh
index ec5f53010..977472f53 100755
--- a/t/t4205-log-pretty-formats.sh
+++ b/t/t4205-log-pretty-formats.sh
@@ -588,8 +588,8 @@ test_expect_success '%(trailers:unfold) unfolds trailers' '
 '
 
 test_expect_success ':only and :unfold work together' '
-	git log --no-walk --pretty="%(trailers:only:unfold)" >actual &&
-	git log --no-walk --pretty="%(trailers:unfold:only)" >reverse &&
+	git log --no-walk --pretty="%(trailers:only,unfold)" >actual &&
+	git log --no-walk --pretty="%(trailers:unfold,only)" >reverse &&
 	test_cmp actual reverse &&
 	{
 		grep -v patch.description <trailers | unfold &&
-- 
2.14.1.145.gb3622a4ee

