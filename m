Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 08BDF1F87F
	for <e@80x24.org>; Fri, 16 Nov 2018 11:04:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389474AbeKPVQG (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Nov 2018 16:16:06 -0500
Received: from smtp-out-5.talktalk.net ([62.24.135.69]:58498 "EHLO
        smtp-out-5.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727714AbeKPVQG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Nov 2018 16:16:06 -0500
Received: from lindisfarne.localdomain ([92.22.32.73])
        by smtp.talktalk.net with SMTP
        id NbuxgXotudJAeNbv3gYs1x; Fri, 16 Nov 2018 11:04:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1542366253;
        bh=cq6ANZQzpLSg4bBYz6u4fkfsF58l4H8ywxCh/yRoijg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
        b=T+zKc7MBrK0k/uNyzzt3xlMVpzuPfERPzRLHklBVDjLO8tz0KxJEhoEqHmhvil1J0
         C2ECT1kNT439ho4jaa/aMQ6SEi8fT3blUh+ctR79f3xD+VTZaoR1WyhYxVrrH6zBFw
         TgRZLORuJEkuuOC5SzPiE3DR3EBsUSmKYwcjoTpg=
X-Originating-IP: [92.22.32.73]
X-Spam: 0
X-OAuthority: v=2.3 cv=V8BTL9vi c=1 sm=1 tr=0 a=w3K0eKD2tyZHkEydg3BQCA==:117
 a=w3K0eKD2tyZHkEydg3BQCA==:17 a=evINK-nbAAAA:8 a=fEHHvVMFJPCt31FnbDYA:9
 a=w_u8L1OaBDE1ml0u:21 a=l9r9x5eE4M5FgKrO:21 a=RfR_gqz1fSpA9VikTjo0:22
From:   Phillip Wood <phillip.wood@talktalk.net>
To:     Git Mailing List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>
Cc:     Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v1 3/9] diff: allow --no-color-moved-ws
Date:   Fri, 16 Nov 2018 11:03:50 +0000
Message-Id: <20181116110356.12311-4-phillip.wood@talktalk.net>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181116110356.12311-1-phillip.wood@talktalk.net>
References: <20180924100604.32208-1-phillip.wood@talktalk.net>
 <20181116110356.12311-1-phillip.wood@talktalk.net>
MIME-Version: 1.0
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfLjH6KXhI4NEGJyMkK5HiGiHMMJkoHDLt8J2mUqouZhWlXil29pFKDf1HTRAb6lLhuBRH1iSPHGoeD8LVc1D5J4Xo8LM2oVzLacmZnOVKtrkMjypPFdv
 Vq5iQhz/r/bh4d2hJaWxU45NM1rId2EuPHNqF67vwpi7LqOUfQQq5EgLvcrJJrvAQ57ooEhIJ0ybimL9Iwy8RKglaYqcmMs3CQ3ItSQx9AjAlImrQSI8j8Co
 o/thJ4paG7j+tcSxnQ7/dA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

Allow --no-color-moved-ws and --color-moved-ws=no to cancel any previous
--color-moved-ws option.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 Documentation/diff-options.txt | 7 +++++++
 diff.c                         | 6 +++++-
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index 57a2f4cb7a..e1744fa80d 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -306,6 +306,8 @@ endif::git-diff[]
 	These modes can be given as a comma separated list:
 +
 --
+no::
+	Do not ignore whitespace when performing move detection.
 ignore-space-at-eol::
 	Ignore changes in whitespace at EOL.
 ignore-space-change::
@@ -322,6 +324,11 @@ allow-indentation-change::
 	other modes.
 --
 
+--no-color-moved-ws::
+	Do not ignore whitespace when performing move detection. This can be
+	used to override configuration settings. It is the same as
+	`--color-moved-ws=no`.
+
 --word-diff[=<mode>]::
 	Show a word diff, using the <mode> to delimit changed words.
 	By default, words are delimited by whitespace; see
diff --git a/diff.c b/diff.c
index 78cd3958f4..9b9811988b 100644
--- a/diff.c
+++ b/diff.c
@@ -304,7 +304,9 @@ static int parse_color_moved_ws(const char *arg)
 		strbuf_addstr(&sb, i->string);
 		strbuf_trim(&sb);
 
-		if (!strcmp(sb.buf, "ignore-space-change"))
+		if (!strcmp(sb.buf, "no"))
+			ret = 0;
+		else if (!strcmp(sb.buf, "ignore-space-change"))
 			ret |= XDF_IGNORE_WHITESPACE_CHANGE;
 		else if (!strcmp(sb.buf, "ignore-space-at-eol"))
 			ret |= XDF_IGNORE_WHITESPACE_AT_EOL;
@@ -5008,6 +5010,8 @@ int diff_opt_parse(struct diff_options *options,
 		if (cm < 0)
 			die("bad --color-moved argument: %s", arg);
 		options->color_moved = cm;
+	} else if (!strcmp(arg, "--no-color-moved-ws")) {
+		options->color_moved_ws_handling = 0;
 	} else if (skip_prefix(arg, "--color-moved-ws=", &arg)) {
 		options->color_moved_ws_handling = parse_color_moved_ws(arg);
 	} else if (skip_to_optional_arg_default(arg, "--color-words", &options->word_regex, NULL)) {
-- 
2.19.1

