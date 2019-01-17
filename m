Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 922C51F453
	for <e@80x24.org>; Thu, 17 Jan 2019 13:07:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727648AbfAQNHi (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Jan 2019 08:07:38 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:40459 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727632AbfAQNHi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Jan 2019 08:07:38 -0500
Received: by mail-pl1-f195.google.com with SMTP id u18so4730038plq.7
        for <git@vger.kernel.org>; Thu, 17 Jan 2019 05:07:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ddP83ZcrhPIiCcBI8JCtho8akXJN2eKjaDIavEx7vFI=;
        b=iTCZ0NJPxczFDgOZIr4GCxckomGOP4S8GrbvYGGr0IIx231octnNdwod/imhk1udiF
         TPELjLEe0Vpoj8Vkm9geFvIdZQ7lRKogHr37/+PJuTq6FSFhxS4Lt/TO8IujI5bt2Hvw
         AokVpCw3Jz+6UBc+meKWNctLxUhVE0U8yazV4b1dptIUC8Z1AhLl4wLmjpmhCt0QmZf/
         Cwfu3T7w4GCs3r0DqdiMgJKTb70dLyeZ3Me8bO0/k5Mkmiq+KSHQVJ42WrzFEHhfqG4G
         7e0x3ccPS7hDNQDZkNgCLNHWD/vXW+m9vwgWBgcZmgq72+WQQyfPTuHKXdLhzHG23IJ8
         KQZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ddP83ZcrhPIiCcBI8JCtho8akXJN2eKjaDIavEx7vFI=;
        b=AFe8aUashcifUfHSpyex5vkqbtffeqzzrOf6noF3MSp8+IKCf2GZ4+K50rFsj+5ow8
         a0gbni+je9n1CVKHNcEAmkGly1bsYyL/2JlSiu7bZnHSuuTfNZAWp7x2iw7FA2aAodwW
         BIitUkzZy1BoDZmQI6BZhUEds5qpFsucEitpFzgC8/Q4yI9736xsA/gooo6UEpWxYkMs
         85NaixdwIWXHyWcE8q8tgXc6KUefLojsIfAOlGMlm+EEuGQbgyZuSJsqggX1c6HwnF3w
         cREHzwq5Cw3Nhll6laiUPGVhXX7Vl8V+smnwGg4XOn6eVzw4lf2J8WLv4ORxVcTaQP1a
         IoJQ==
X-Gm-Message-State: AJcUukcu6DCgaFiTjLcnJsWbSGuRtMqezzdY4oig3BYEviStyVMOBiBl
        y3zfM2WKim+C6tePUemAvdcnoEda
X-Google-Smtp-Source: ALg8bN68u5W/YA8cfeBgZZkdc4/pQsYVwU0aFS71bYVqU9cDHS6m80UiYCWInoNBsr6wxaGOiypzhw==
X-Received: by 2002:a17:902:7b91:: with SMTP id w17mr14914305pll.111.1547730457556;
        Thu, 17 Jan 2019 05:07:37 -0800 (PST)
Received: from ash ([115.72.21.220])
        by smtp.gmail.com with ESMTPSA id n22sm4814638pfh.166.2019.01.17.05.07.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Jan 2019 05:07:36 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Thu, 17 Jan 2019 20:07:32 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 13/76] diff.c: convert -U|--unified
Date:   Thu, 17 Jan 2019 20:05:12 +0700
Message-Id: <20190117130615.18732-14-pclouds@gmail.com>
X-Mailer: git-send-email 2.20.0.482.g66447595a7
In-Reply-To: <20190117130615.18732-1-pclouds@gmail.com>
References: <20190117130615.18732-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 Documentation/diff-options.txt |  2 +-
 diff.c                         | 23 ++++++++++++++++++++---
 parse-options.h                |  5 +++--
 3 files changed, 24 insertions(+), 6 deletions(-)

diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index b94d332f71..0711734b12 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -36,7 +36,7 @@ endif::git-format-patch[]
 -U<n>::
 --unified=<n>::
 	Generate diffs with <n> lines of context instead of
-	the usual three.
+	the usual three. Implies `--patch`.
 ifndef::git-format-patch[]
 	Implies `-p`.
 endif::git-format-patch[]
diff --git a/diff.c b/diff.c
index 7b78af623b..5e31b95426 100644
--- a/diff.c
+++ b/diff.c
@@ -4865,6 +4865,22 @@ static int parse_objfind_opt(struct diff_options *opt, const char *arg)
 	return 1;
 }
 
+static int diff_opt_unified(const struct option *opt,
+			    const char *arg, int unset)
+{
+	struct diff_options *options = opt->value;
+	char *s;
+
+	BUG_ON_OPT_NEG(unset);
+
+	options->context = strtol(arg, &s, 10);
+	if (*s)
+		return error(_("%s expects a numerical value"), "--unified");
+	enable_patch_output(&options->output_format);
+
+	return 0;
+}
+
 static void prep_parse_options(struct diff_options *options)
 {
 	struct option parseopts[] = {
@@ -4875,6 +4891,9 @@ static void prep_parse_options(struct diff_options *options)
 		OPT_BITOP('u', NULL, &options->output_format,
 			  N_("generate patch"),
 			  DIFF_FORMAT_PATCH, DIFF_FORMAT_NO_OUTPUT),
+		OPT_CALLBACK_F('U', "unified", options, N_("<n>"),
+			       N_("generate diffs with <n> lines context"),
+			       PARSE_OPT_NONEG, diff_opt_unified),
 		OPT_END()
 	};
 
@@ -4903,9 +4922,7 @@ int diff_opt_parse(struct diff_options *options,
 		return ac;
 
 	/* Output format options */
-	if (opt_arg(arg, 'U', "unified", &options->context))
-		enable_patch_output(&options->output_format);
-	else if (!strcmp(arg, "--raw"))
+	if (!strcmp(arg, "--raw"))
 		options->output_format |= DIFF_FORMAT_RAW;
 	else if (!strcmp(arg, "--patch-with-raw")) {
 		enable_patch_output(&options->output_format);
diff --git a/parse-options.h b/parse-options.h
index ce75278804..7d83e2971d 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -134,6 +134,8 @@ struct option {
 #define OPT_SET_INT_F(s, l, v, h, i, f) { OPTION_SET_INT, (s), (l), (v), NULL, \
 					  (h), PARSE_OPT_NOARG | (f), NULL, (i) }
 #define OPT_BOOL_F(s, l, v, h, f)   OPT_SET_INT_F(s, l, v, h, 1, f)
+#define OPT_CALLBACK_F(s, l, v, a, h, f, cb)			\
+	{ OPTION_CALLBACK, (s), (l), (v), (a), (h), (f), (cb) }
 
 #define OPT_END()                   { OPTION_END }
 #define OPT_ARGUMENT(l, h)          { OPTION_ARGUMENT, 0, (l), NULL, NULL, \
@@ -164,8 +166,7 @@ struct option {
 #define OPT_EXPIRY_DATE(s, l, v, h) \
 	{ OPTION_CALLBACK, (s), (l), (v), N_("expiry-date"),(h), 0,	\
 	  parse_opt_expiry_date_cb }
-#define OPT_CALLBACK(s, l, v, a, h, f) \
-	{ OPTION_CALLBACK, (s), (l), (v), (a), (h), 0, (f) }
+#define OPT_CALLBACK(s, l, v, a, h, f) OPT_CALLBACK_F(s, l, v, a, h, 0, f)
 #define OPT_NUMBER_CALLBACK(v, h, f) \
 	{ OPTION_NUMBER, 0, NULL, (v), NULL, (h), \
 	  PARSE_OPT_NOARG | PARSE_OPT_NONEG, (f) }
-- 
2.20.0.482.g66447595a7

