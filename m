Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E102C1F453
	for <e@80x24.org>; Thu, 17 Jan 2019 13:10:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728160AbfAQNKg (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Jan 2019 08:10:36 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:45831 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725898AbfAQNKf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Jan 2019 08:10:35 -0500
Received: by mail-pg1-f196.google.com with SMTP id y4so4420976pgc.12
        for <git@vger.kernel.org>; Thu, 17 Jan 2019 05:10:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=s2kY0r0FOMhAG4CkmYnLRdF/6CRIrEaV+llLDI76xuU=;
        b=h4LHLfi2j1hqExMItgVSR/jjhjU0QP8PNbW9dwI1O1pZQaS87rj8yT9iMw8DAwjp99
         8DDoAcEiEKZ9Meln2kHDeqK43mzKPQIZRLTi+kkfXzjxiCK2N2fD3sllzg4sIEQFj9dg
         C7B3VacTRwm9+LGqsDm57hiq9nAKwTuFhS/jLBW/zJZqNz6cqxHfcQ461oSrdAkmmO+X
         Q6ocdP/vsefVBfeloDRxNPH01Yq/sQ9qbYFV7vx6uZMPE9ZhXatD87GzCxKwpEV/GE0W
         gEdfYbQm32XRCaRe88uX4LRnsVq7dDl51oEZFc+FTBVol5qqUKI/sy45mgaBPyUSbTTW
         P18g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=s2kY0r0FOMhAG4CkmYnLRdF/6CRIrEaV+llLDI76xuU=;
        b=s795qQVP43++WLsHUKEjVcxEaYP0kfL9tnG17JvYT5PaMwQ3miocgJhnpIwiXvUuYR
         Eri7/RIREFbHQ+SKhbxTFWDrBdMSdYU7QpWQBOHL2IAQISLQv0WOwwHkNg4nt46Lak0x
         bNB2U0mqSOvJZz6NKFQxRupERVork9evWsofFdwCDZw/lwrpQBPkQcFJaFgl5U4XC2xY
         q3BQa/ofKGiD5c2mrp2h10Qn2tvFjkaFXOdclrylF09GPugzgh/Wm22+3BzBpXjpHkWm
         4dev95PqEYDnN1KdMz4u+d0E/9f0VLtiqp0TVrNCcwIRnDCTKcqbAooeyuabjrJ0S+dJ
         lG4Q==
X-Gm-Message-State: AJcUukefuECMHaOJTpXgJ5OVu5i4eyMuS9V4x4LFl6xRkwWDTjDzNyF6
        O2miKOml+nNGpfGmrq/V8FDaDG9G
X-Google-Smtp-Source: ALg8bN6M+Vg3oLV89HQfwsKhDReAhNXWrtXBJyHV3X8YvmWBV9VhnU1EsaZ0Mf8zyYv4qBNt55sP3A==
X-Received: by 2002:a62:ca05:: with SMTP id n5mr14959792pfg.154.1547730634670;
        Thu, 17 Jan 2019 05:10:34 -0800 (PST)
Received: from ash ([115.72.21.220])
        by smtp.gmail.com with ESMTPSA id q7sm1702452pgp.40.2019.01.17.05.10.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Jan 2019 05:10:34 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Thu, 17 Jan 2019 20:10:30 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 49/76] diff.c: convert --word-diff-regex
Date:   Thu, 17 Jan 2019 20:05:48 +0700
Message-Id: <20190117130615.18732-50-pclouds@gmail.com>
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
 diff.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/diff.c b/diff.c
index b80eefe9bc..3e55c2fd1f 100644
--- a/diff.c
+++ b/diff.c
@@ -5096,6 +5096,18 @@ static int diff_opt_word_diff(const struct option *opt,
 	return 0;
 }
 
+static int diff_opt_word_diff_regex(const struct option *opt,
+				    const char *arg, int unset)
+{
+	struct diff_options *options = opt->value;
+
+	BUG_ON_OPT_NEG(unset);
+	if (options->word_diff == DIFF_WORDS_NONE)
+		options->word_diff = DIFF_WORDS_PLAIN;
+	options->word_regex = arg;
+	return 0;
+}
+
 static void prep_parse_options(struct diff_options *options)
 {
 	struct option parseopts[] = {
@@ -5261,6 +5273,9 @@ static void prep_parse_options(struct diff_options *options)
 		OPT_CALLBACK_F(0, "word-diff", options, N_("<mode>"),
 			       N_("show word diff, using <mode> to delimit changed words"),
 			       PARSE_OPT_NONEG | PARSE_OPT_OPTARG, diff_opt_word_diff),
+		OPT_CALLBACK_F(0, "word-diff-regex", options, N_("<regex>"),
+			       N_("use <regex> to decide what a word is"),
+			       PARSE_OPT_NONEG, diff_opt_word_diff_regex),
 
 		OPT_GROUP(N_("Diff other options")),
 		OPT_CALLBACK_F(0, "relative", options, N_("<prefix>"),
@@ -5324,12 +5339,6 @@ int diff_opt_parse(struct diff_options *options,
 		options->use_color = 1;
 		options->word_diff = DIFF_WORDS_COLOR;
 	}
-	else if ((argcount = parse_long_opt("word-diff-regex", av, &optarg))) {
-		if (options->word_diff == DIFF_WORDS_NONE)
-			options->word_diff = DIFF_WORDS_PLAIN;
-		options->word_regex = optarg;
-		return argcount;
-	}
 	else if (!strcmp(arg, "--exit-code"))
 		options->flags.exit_with_status = 1;
 	else if (!strcmp(arg, "--quiet"))
-- 
2.20.0.482.g66447595a7

