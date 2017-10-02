Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3F4C6202DD
	for <e@80x24.org>; Mon,  2 Oct 2017 05:25:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750770AbdJBFZb (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Oct 2017 01:25:31 -0400
Received: from mail-pg0-f47.google.com ([74.125.83.47]:52928 "EHLO
        mail-pg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750752AbdJBFZa (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Oct 2017 01:25:30 -0400
Received: by mail-pg0-f47.google.com with SMTP id i195so2444465pgd.9
        for <git@vger.kernel.org>; Sun, 01 Oct 2017 22:25:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dtipQPBRpflhXJ53G/njvWk1SM6jwRYbIsMLB4Dq8yQ=;
        b=OxpVN9QAVSkfd1LZ159ML9WBIkEQJoVkx77wzrJ9Z1oMZhz/NNldyOlWwU2gQcU3FM
         7HerusqReQWnHyvNaZTVxFAKD0DtZODNSgdfC7ngeJ7X11v9N+0nRXkvZ97CLFtLk9XH
         uOLzOR3Bf+yFTJ5N0dM3VDBhtV2LrinceVvAQuET89HP+XpVfgH3wl8B2uvKDY/GLDqa
         K1wo/fMb46IUrLHgu1j5iABO97Dqu0atAWzYws+u6zVOoPFZFGC4zNR7NkkXFOpXWArT
         Q7FPv+2jQktTpru52W7K7wLGsmuZBVHPlFyDSJh2lK6vNNBz5++AqDbgu6fJQCuXthri
         pd9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=dtipQPBRpflhXJ53G/njvWk1SM6jwRYbIsMLB4Dq8yQ=;
        b=mHc1VAOgi9Z7t/KlEz0poyfIcqD1Nyx1IhgOt3rokSIhAWSBEzU9umw59dCbavzkwA
         fiUfCyhNJdzaDMBtLmyBIyxHWhqwMMc/NEArGHwUWtADPxOa03omTCCIw0c8qaNy2IEt
         rnd0lBjyyUF8yELLELxVMkkzqs27SAPdZjBblYxK46WtoRBxieCN6tWJoSOtPwK8L8n9
         2x1wD0Y82j9xf7pv07OcQBZB3SQ6E/zZ9jfAxrHFZb2NrjS2AqhAdungs4fgLc4fRN3d
         Kdlk7EhRPn2U4LqIXeavduR2SZJIGf0rGdiCWcjxb3wM7bWlPAu0aLmmbBfMNBfSkaS6
         qu7A==
X-Gm-Message-State: AHPjjUhQgzoctSDV3Mx7I2PpwOd7f8zImhkBtk+p98fLJbw6GNGtj9uc
        lFiBQ8471CeJSkrxzke5U5KABB4sM+0=
X-Google-Smtp-Source: AOwi7QCoIogA+gIBtoSuP+R65HwR+MPeCcbSVDTsnAm/rBbQbTUPGhaC5MDcwvNCImAq0oWozMLISw==
X-Received: by 10.98.137.150 with SMTP id n22mr13760767pfk.104.1506921929316;
        Sun, 01 Oct 2017 22:25:29 -0700 (PDT)
Received: from localhost ([205.175.97.239])
        by smtp.gmail.com with ESMTPSA id a25sm17947970pfg.111.2017.10.01.22.25.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 01 Oct 2017 22:25:27 -0700 (PDT)
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, Taylor Blau <me@ttaylorr.com>
Subject: [PATCH v6 1/7] pretty.c: delimit "%(trailers)" arguments with ","
Date:   Sun,  1 Oct 2017 22:25:18 -0700
Message-Id: <20171002052524.12627-1-me@ttaylorr.com>
X-Mailer: git-send-email 2.14.1.145.gb3622a4ee
In-Reply-To: <20171002052326.GA10729@D-10-157-251-166.dhcp4.washington.edu>
References: <20171002052326.GA10729@D-10-157-251-166.dhcp4.washington.edu>
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

