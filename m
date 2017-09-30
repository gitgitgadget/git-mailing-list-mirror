Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 80B9B20281
	for <e@80x24.org>; Sat, 30 Sep 2017 06:22:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751731AbdI3GWv (ORCPT <rfc822;e@80x24.org>);
        Sat, 30 Sep 2017 02:22:51 -0400
Received: from mail-pf0-f177.google.com ([209.85.192.177]:55191 "EHLO
        mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751644AbdI3GWt (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Sep 2017 02:22:49 -0400
Received: by mail-pf0-f177.google.com with SMTP id d187so786342pfg.11
        for <git@vger.kernel.org>; Fri, 29 Sep 2017 23:22:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=OxA6Mw7900ZIBFAlRJT2FU9A9YMx9InFfcCnKuWk/FQ=;
        b=fNTVzOohp/O2Yy7QLXO2NwoNQnkRXTz9TKTc2yzzCEzFdeeD1olfnSwG8qp4iWkDH9
         VeCTuW9QfLQD+fxjYQbHhomZibwLI0o/GGhxrS5Fs0o9xeRKzU0MFEogT+JS8SEKTTvR
         QoHOCgesFpO+nc2PmopUD3rjBY+MKbBo5kuWv/yCYKrW1C63TiozYf5biDhdtJH6c4LX
         R7eUY9px+s10zcCFM1uPtS7zhF3MmEhSY3sSD/V9cWHRZvBKM0Os9F23G7UbEOE9IJ3r
         h3C3gfi+OXqLHTpXi3Sva2YsNyPcBaxY0hGWrAkmJluA9JFEK2bd09HU1dpon+QOOIeh
         6zGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=OxA6Mw7900ZIBFAlRJT2FU9A9YMx9InFfcCnKuWk/FQ=;
        b=b6U9/Mu092hSp2Ifp9uFFqRza3eao8LJgxWTitDv10scTfP4xxou98fxzn7ipKBRQP
         KFhAe0ymkFsjhuqfkklnvNQt9YUW0dA6NKSq4kbhSn4RyV0VT9B6sx+XUfZq34vDS8Ql
         +RRLGE4dk/AcPbRPvf+x1AwZ6rMh5i4S1KBZAmXeqlMdFtJuphrxTDsNyeSypvUa0fvK
         ERNidCzKfQWOSqZknBylrLsBE45bWjUUMiJANeJmbVpdVn9Rk3GACFvecp8hwdkycqBd
         ol6FScADEYi/q1YlaZRuoFFs/yKnpv6cntQK/GDkdnJCspJZJZKez6zXcllZEFoiTfuz
         bK6A==
X-Gm-Message-State: AMCzsaXltQ5vNoPJ7+zcnsn25ngZT+Fp4d8vFnw7q+1GxRsu3YQrYWfb
        ScvSW7l65BNZM2GZrdbxnbGPWnWTj7w=
X-Google-Smtp-Source: AOwi7QC86su04sDSus72X0ZtyKBp5k0ZRyDOBJH/4FQtjale6rJ0Y0aMZyeD8dE0/0N0fIA7Y0NSNA==
X-Received: by 10.98.238.24 with SMTP id e24mr1470076pfi.188.1506752568565;
        Fri, 29 Sep 2017 23:22:48 -0700 (PDT)
Received: from localhost ([205.175.97.239])
        by smtp.gmail.com with ESMTPSA id u20sm8727696pfh.171.2017.09.29.23.22.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Sep 2017 23:22:47 -0700 (PDT)
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, Taylor Blau <me@ttaylorr.com>
Subject: [PATCH 1/5] pretty.c: delimit "%(trailers)" arguments with ","
Date:   Fri, 29 Sep 2017 23:22:34 -0700
Message-Id: <20170930062238.87077-2-me@ttaylorr.com>
X-Mailer: git-send-email 2.14.1.145.gb3622a4ee
In-Reply-To: <20170930062238.87077-1-me@ttaylorr.com>
References: <20170930062238.87077-1-me@ttaylorr.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In preparation for adding consistent "%(trailers)" atom options to
`git-for-each-ref(1)`'s "--format" argument, change "%(trailers)" in pretty.c
to separate sub-arguments with a ",", instead of a ":".

Multiple sub-arguments are given either as "%(trailers:unfold,only)" or
"%(trailers:only,unfold)".

This change disambiguates between "top-level" arguments, and arguments given to
the trailers atom itself. It is consistent with the behavior of "%(upstream)"
and "%(push)" atoms.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 pretty.c                      | 13 ++++++++-----
 t/t4205-log-pretty-formats.sh |  4 ++--
 2 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/pretty.c b/pretty.c
index 0e23fe3c0..68f736912 100644
--- a/pretty.c
+++ b/pretty.c
@@ -1265,11 +1265,14 @@ static size_t format_commit_one(struct strbuf *sb, /* in UTF-8 */
 
 	if (skip_prefix(placeholder, "(trailers", &arg)) {
 		struct process_trailer_options opts = PROCESS_TRAILER_OPTIONS_INIT;
-		while (*arg == ':') {
-			if (skip_prefix(arg, ":only", &arg))
-				opts.only_trailers = 1;
-			else if (skip_prefix(arg, ":unfold", &arg))
-				opts.unfold = 1;
+		if (skip_prefix(arg, ":", &arg)) {
+			while (*arg != ')') {
+				skip_prefix(arg, ",", &arg);
+				if (skip_prefix(arg, "only", &arg))
+					opts.only_trailers = 1;
+				else if (skip_prefix(arg, "unfold", &arg))
+					opts.unfold = 1;
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

