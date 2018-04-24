Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 68AD31F424
	for <e@80x24.org>; Tue, 24 Apr 2018 00:09:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932677AbeDXAJR (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Apr 2018 20:09:17 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:44101 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932672AbeDXAJL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Apr 2018 20:09:11 -0400
Received: by mail-pg0-f67.google.com with SMTP id l12so9486448pgp.11
        for <git@vger.kernel.org>; Mon, 23 Apr 2018 17:09:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=V+M5zm/sBDSx63+5KsE3HgnbZuX1U/ZtbZY+4qtg9E4=;
        b=K4i+bQV0oZcB4AN5NBERflXeNxxzor2+vhyzhIHERuu1wxKPrDEyCYcct47T80s9b+
         NNu7JWAeAtC3XBQzAk9CMGRAXFf7ND4nj8vNwcwmsICzG/zWr1xGRNGDBUKAtoqOHAQG
         kAth7JEtz7E5Zn9d/4nOyYh4d7UUwDvNrn5v5kf1346ZTpF1eYXd40hASGgOfXOAK2/N
         aW+/E1Qjl74CoIXo0vIjYpVoWe4/fArKoq/oNflQXB70L0WX0pTeuIYZiF8ncKE6aDou
         jf7vOc00gG6fammiZKKtoeVu0LnpRGx/c3oRgI90tZf0fYNAVor5aLjTfRh/xYXRRj1m
         mgFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=V+M5zm/sBDSx63+5KsE3HgnbZuX1U/ZtbZY+4qtg9E4=;
        b=J9QIimuxmHYks32QyH7Og1E3J+tiWMBxITvqxXbur1rGM3x8Za/yn2URMM+/XnoYEt
         0AbzhchDesaOzIHC1klJHyERdjZ/ofyJjNDTw2wDz3eYmDv+4DWPMomfd7mTZ6VHOXe0
         9+OUvAs98mUqgusULl3gYW9TIL7NMPOZiyQWgWf15STtegq8m4GUYBmu46UcirJCM4AK
         pGg20iweZCd/8KyiBy7I9t4zeXqfwRuKDljX+SVd7xga96jD+yXLtWla3BLp62V86ggR
         lMnKAGiJY9ya52LaB337R3nTANlZKZzyt5rnASDLZmwLezFZJxJ6wVBHRnvVWonBcies
         EmPw==
X-Gm-Message-State: ALQs6tBODWftl77jlFxjKOBom8Ffr+SaU0Wa38QVMBU1opz834oS+MTH
        Krvkml9E+nXIM56jpP0cXLshklWo2fA=
X-Google-Smtp-Source: AIpwx49jN8imEN4yUSgUwm/rd29CgF9JZxParmGo0znTKawD26+Kk/qLi5CI7/B3QsKIYcAD2zteYQ==
X-Received: by 10.99.122.5 with SMTP id v5mr18470629pgc.184.1524528550579;
        Mon, 23 Apr 2018 17:09:10 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id y14sm22454499pfe.172.2018.04.23.17.09.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 23 Apr 2018 17:09:09 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, sunshine@sunshineco.com,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH 3/3] builtin/blame: add new coloring scheme config
Date:   Mon, 23 Apr 2018 17:09:00 -0700
Message-Id: <20180424000900.175235-4-sbeller@google.com>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d-goog
In-Reply-To: <20180424000900.175235-1-sbeller@google.com>
References: <20180424000900.175235-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a config option that allows selecting the default color scheme for
blame. The command line still takes precedence over the configuration.

It is to be seen, how color.ui will integrate with blame coloring.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 Documentation/config.txt |  5 +++++
 builtin/blame.c          | 18 ++++++++++++++++++
 t/t8012-blame-colors.sh  |  4 ++++
 3 files changed, 27 insertions(+)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 1496fa4917..c03e20cf23 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1240,6 +1240,11 @@ everything older than one year blue, recent changes between one month and
 one year old are kept white, and lines introduced within the last month are
 colored red.
 
+blame.coloring::
+	This determines the coloring scheme to be applied to blame
+	output. It can be 'repeatedLines', 'highlightRecent',
+	or 'none' which is the default.
+
 color.ui::
 	This variable determines the default value for variables such
 	as `color.diff` and `color.grep` that control the use of color
diff --git a/builtin/blame.c b/builtin/blame.c
index d1d469c0b5..fede1cf1e3 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -49,6 +49,7 @@ static int abbrev = -1;
 static int no_whole_file_rename;
 static int show_progress;
 static char repeated_meta_color[COLOR_MAXLEN];
+static int coloring_mode;
 
 static struct date_mode blame_date_mode = { DATE_ISO8601 };
 static size_t blame_date_width;
@@ -702,6 +703,20 @@ static int git_blame_config(const char *var, const char *value, void *cb)
 		return 0;
 	}
 
+	if (!strcmp(var, "blame.coloring")) {
+		if (!strcmp(value, "repeatedLines")) {
+			coloring_mode |= OUTPUT_COLOR_LINE;
+		} else if (!strcmp(value, "highlightRecent")) {
+			coloring_mode |= OUTPUT_SHOW_AGE_WITH_COLOR;
+		} else if (!strcmp(value, "none")) {
+			coloring_mode &= ~(OUTPUT_COLOR_LINE |
+					    OUTPUT_SHOW_AGE_WITH_COLOR);
+		} else {
+			warning(_("invalid value for blame.coloring"));
+			return 0;
+		}
+	}
+
 	if (git_diff_heuristic_config(var, value, cb) < 0)
 		return -1;
 	if (userdiff_config(var, value) < 0)
@@ -1046,6 +1061,9 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 
 	blame_coalesce(&sb);
 
+	if (!(output_option & (OUTPUT_COLOR_LINE | OUTPUT_SHOW_AGE_WITH_COLOR)))
+		output_option |= coloring_mode;
+
 	if (!(output_option & OUTPUT_PORCELAIN)) {
 		find_alignment(&sb, &output_option);
 		if (!*repeated_meta_color &&
diff --git a/t/t8012-blame-colors.sh b/t/t8012-blame-colors.sh
index ae9aa79d4e..ed38f74de9 100755
--- a/t/t8012-blame-colors.sh
+++ b/t/t8012-blame-colors.sh
@@ -8,6 +8,8 @@ PROG='git blame -c'
 
 test_expect_success 'colored blame colors contiguous lines' '
 	git -c color.blame.repeatedLines=yellow blame --color-lines --abbrev=12 hello.c >actual.raw &&
+	git -c color.blame.repeatedLines=yellow -c blame.coloring=repeatedLines blame --abbrev=12 hello.c >actual.raw.2 &&
+	test_cmp actual.raw actual.raw.2 &&
 	test_decode_color <actual.raw >actual &&
 	grep "<YELLOW>" <actual >darkened &&
 	grep "(F" darkened > F.expect &&
@@ -18,6 +20,8 @@ test_expect_success 'colored blame colors contiguous lines' '
 
 test_expect_success 'color by age consistently colors old code' '
 	git blame --color-by-age hello.c >actual.raw &&
+	git -c blame.coloring=highlightRecent blame hello.c >actual.raw.2 &&
+	test_cmp actual.raw actual.raw.2 &&
 	test_decode_color <actual.raw >actual &&
 	grep "<BLUE>" <actual >colored &&
 	test_line_count = 10 colored
-- 
2.17.0.441.gb46fe60e1d-goog

