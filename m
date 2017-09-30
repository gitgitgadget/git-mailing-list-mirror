Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8B7B72047F
	for <e@80x24.org>; Sat, 30 Sep 2017 18:46:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751217AbdI3Sqk (ORCPT <rfc822;e@80x24.org>);
        Sat, 30 Sep 2017 14:46:40 -0400
Received: from mail-pf0-f180.google.com ([209.85.192.180]:51059 "EHLO
        mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751099AbdI3Sqj (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Sep 2017 14:46:39 -0400
Received: by mail-pf0-f180.google.com with SMTP id m63so1215694pfk.7
        for <git@vger.kernel.org>; Sat, 30 Sep 2017 11:46:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=WknMCNROrrY63QfTT08OkBdFlXrkua0kiaKuuTbdNgg=;
        b=xPkJh7ABVvhXCOIUkyIgLdJFO6gx84w32F/++L3he/SITSrkmb10XiLVXC7zhAqQgp
         lyhsUgIPrWzepNc85+kRrFv98smhJRNbaYQhQotAtzdYhCIvwh/v+YRgg3Z6alIx7KON
         5o0hpvovKyKObL7IGbbItXZXW/gGnyHqY8HWd82FcMM0EEOi3X3Hvt35PMI0GcSvPQnD
         9H5XZNkCFJzhYT4lOM84vbcMq3AcpO/KS77CcqPkTDMviGxM7cgaCRMa0W7//l/gO3qG
         l1MN4J3mKZEnu7LNMDAWANbwemZXtIuPRQf9Pny2F4P9GuFbL1UmUcdp/G+iHQ/xwJix
         hKVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=WknMCNROrrY63QfTT08OkBdFlXrkua0kiaKuuTbdNgg=;
        b=XMkSlpzDCM/RYsNtucwjVH6KPwRrX3jyASkgyZ55107KlU/MYf94vJukwicfNgFXVx
         /kp9rtLBRQ8SH5qsVyps7kNn4gvZGle2e1wBWbfPqN2xQD6DFME42B7ucUuArgoH4kct
         Sn1QdGsLcv2M7zkXjWUQXxUzwrFHUGrHfSlkmjXvLUG4H+PdV0ZRVzL1IgP5pGWz3hB7
         OAZPttr7GG+18cvKmyicYyA2eQDctEzz28TDk8lARn5kmzqpS/ZZSxuUX4VtYHMg9XXE
         wijUxfKsuFJh/2asRpv+RdMyyQVJx5wa4Q3CLB02S7g5BtiyxhuE1hfRq57Y5XBTYprU
         soQA==
X-Gm-Message-State: AMCzsaX3XPK9Wh7G5T7ZMJ29I9h1BY6+dp9hUo+b/WZgNmNn1rMoc3gJ
        g6q1y8ybS13yvXK6rPxoMVtNdfsF7os=
X-Google-Smtp-Source: AOwi7QBvfPBX5sJ6t4N1OnDR6xlvQDIUqfQJokUh3+rG0vFqc+VR0u/Mnie9igTjWSAD0UBlvVA0bQ==
X-Received: by 10.99.165.73 with SMTP id r9mr1851196pgu.437.1506797198401;
        Sat, 30 Sep 2017 11:46:38 -0700 (PDT)
Received: from localhost ([205.175.97.239])
        by smtp.gmail.com with ESMTPSA id n10sm11453608pfh.121.2017.09.30.11.46.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 30 Sep 2017 11:46:37 -0700 (PDT)
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, Taylor Blau <me@ttaylorr.com>
Subject: [PATCH v2 1/6] pretty.c: delimit "%(trailers)" arguments with ","
Date:   Sat, 30 Sep 2017 11:46:24 -0700
Message-Id: <20170930184629.75900-1-me@ttaylorr.com>
X-Mailer: git-send-email 2.14.1.145.gb3622a4ee
In-Reply-To: <20170930184151.GB43975@D-10-157-251-166.dhcp4.washington.edu>
References: <20170930184151.GB43975@D-10-157-251-166.dhcp4.washington.edu>
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
 pretty.c                      | 34 +++++++++++++++++++++++++++++-----
 t/t4205-log-pretty-formats.sh |  4 ++--
 2 files changed, 31 insertions(+), 7 deletions(-)

diff --git a/pretty.c b/pretty.c
index 0e23fe3c0..eeb51746c 100644
--- a/pretty.c
+++ b/pretty.c
@@ -1036,6 +1036,25 @@ static size_t parse_padding_placeholder(struct strbuf *sb,
 	return 0;
 }
 
+static int match_placeholder_arg(const char *to_parse,
+																const char *candidate,
+																const char **end)
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
+
 static size_t format_commit_one(struct strbuf *sb, /* in UTF-8 */
 				const char *placeholder,
 				void *context)
@@ -1265,11 +1284,16 @@ static size_t format_commit_one(struct strbuf *sb, /* in UTF-8 */
 
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

