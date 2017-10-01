Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E5A0920A2C
	for <e@80x24.org>; Sun,  1 Oct 2017 00:10:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751604AbdJAAKp (ORCPT <rfc822;e@80x24.org>);
        Sat, 30 Sep 2017 20:10:45 -0400
Received: from mail-pf0-f181.google.com ([209.85.192.181]:50060 "EHLO
        mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751202AbdJAAKp (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Sep 2017 20:10:45 -0400
Received: by mail-pf0-f181.google.com with SMTP id l188so1376783pfc.6
        for <git@vger.kernel.org>; Sat, 30 Sep 2017 17:10:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zgKeuT+HofTlfa97BYrXwYiphyS9i52srKYNlKgi0k8=;
        b=DY+fbINvymvOGNfaALcbc5wQ+XORgZ1l9Gf3HogtGpE7W+4tWOX2JeOe0dK4V8dWcv
         O7AZmrstsApwH6dfY/znxkN/H2agZRaKVxetFTSrK9SLkyRqA6XV4HSwkO3zqpXNeDJK
         zq6lLE0l4qFYrUkz7gVEG5IeSwWlBvCWe4mqt7nuwg0IgTItD9gqDzta4LPvVOnp03HA
         co6CLpjD2oGdeouqeDp1u/xbCsAK9qKuTgly3t3VBsGVlB4oxLglQgXlHrUA1ScutZvh
         3kBnbzvyv4LsNzdJdwJ1LhTzjPOV86eOL2bJS6UgwQ3oQg7IG1FIgO4Xa2+UqXauhYfs
         nrCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=zgKeuT+HofTlfa97BYrXwYiphyS9i52srKYNlKgi0k8=;
        b=cNoD3IHV0HKdvjw3rkEMEwZowHaqvKcOe1brpuIHZGipsh7lPVRROVAoujpCA4SY5I
         thnN8PMpU3D8vbvyC3sdwWdIMWRtBW08klNLs1XOU2HUTJwMnBgdwNPxQMGsi6fxxYBw
         ncknsZfR+S/gfmy6tEwlM55JVCeONv7vNy+j3Dbk1ZdGa7qMYMqoPJZ94kRrY80uWtrt
         SsYSa1k3ZpQeYJCYDQSZhqfnpbOuGwMFYuDkHYjaNYxUDOTLh4h3W0Cf2FjY6RGHJ1T8
         qvRenLd6ANCgoaNCgaACRxGpNxzOlS59GEXLOmbDzJ4VZ/xTiYCVQZ2i5GKG9+0UD06O
         GZTA==
X-Gm-Message-State: AHPjjUhYeAuf0/JjIuu5hrgjckU6YfOwR3CdoDsF9BaHlf/1k8YGAJHi
        /hsV4BrNrPnk98A6bSCSGFTRE1P6jp0=
X-Google-Smtp-Source: AOwi7QC4v1AEFlouUqPWc8NRpUq8oeeF0GtBMMdHoqtHy+44Rznm9+yeeoE21P8ccvTwl9ixWnk/bg==
X-Received: by 10.99.190.3 with SMTP id l3mr9202919pgf.79.1506816643881;
        Sat, 30 Sep 2017 17:10:43 -0700 (PDT)
Received: from localhost ([205.175.97.239])
        by smtp.gmail.com with ESMTPSA id e66sm11095374pfe.79.2017.09.30.17.10.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 30 Sep 2017 17:10:42 -0700 (PDT)
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, Taylor Blau <me@ttaylorr.com>
Subject: [PATCH v3 1/6] pretty.c: delimit "%(trailers)" arguments with ","
Date:   Sat, 30 Sep 2017 17:10:32 -0700
Message-Id: <20171001001037.23361-1-me@ttaylorr.com>
X-Mailer: git-send-email 2.14.1.145.gb3622a4ee
In-Reply-To: <20171001000647.GA20767@D-10-157-251-166.dhcp4.washington.edu>
References: <20171001000647.GA20767@D-10-157-251-166.dhcp4.washington.edu>
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
index 0e23fe3c0..9f8d75a84 100644
--- a/pretty.c
+++ b/pretty.c
@@ -1036,6 +1036,25 @@ static size_t parse_padding_placeholder(struct strbuf *sb,
 	return 0;
 }
 
+static int match_placeholder_arg(const char *to_parse,
+				const char *candidate,
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

