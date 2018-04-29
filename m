Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C5ECE1F428
	for <e@80x24.org>; Sun, 29 Apr 2018 18:19:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754101AbeD2STS (ORCPT <rfc822;e@80x24.org>);
        Sun, 29 Apr 2018 14:19:18 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:35244 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754064AbeD2STK (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 29 Apr 2018 14:19:10 -0400
Received: by mail-lf0-f66.google.com with SMTP id r125-v6so9384702lfe.2
        for <git@vger.kernel.org>; Sun, 29 Apr 2018 11:19:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=latKK9preKgRvscoHiakGHKHkRjdprOzfgY3uaUrNcs=;
        b=bUV/x2yetw0rI6yx/KZIJcfoBQXRReOlSfatdBElId3ESmSOy8MsUBZGAmBZALCitC
         uFXDXwNcOCYY8zarySRWpKX4joSo1pM7k5NgCnbdmlWoP4kErkbhVYnXW0QZ1eX04AYD
         4Ie2DWvO9cIrYGisrLQrl2tt14iow5PSLo9lhl/UJGYrUoHv8BYYhbZaY+p3XTvrl7yh
         ChiVxq1gbG6bPs9riKoFvrJ+OmSBq6ndZEelKurfp9PjwxA8I7X6dDpFEbuVdGniyHSo
         PWpCth2eb3fAGvtKLr96U7PmjkDuvMmq6QtcI4nVLcjY1w0Nct+5NAfEd0cmzF1H8VIY
         vJsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=latKK9preKgRvscoHiakGHKHkRjdprOzfgY3uaUrNcs=;
        b=mrAqxZ200YEOaEETYZkejToUbajzfyhlkV73RTGYHWA4huAhdebE7pDcZlZC4JGPT9
         fOy6Pwgixy6MfIBoEdWI234pDLocdj+3uhcR5HUg1d+LolT6aQmv7tvukUZzgDNTGk6R
         w9+4JhA2UfpjFN6N+MKrO261x8DXn+hhHuJ8b2wcvdu1CSzwgUpTCchdF/2cmqVC91x2
         gLKbQFebcoQmudJ9YgvCsn+HCYg5OJ/4sL9C2sMu13m70SF5QHB3l5bKsH9svkloNYsw
         Sv5NBsoWpelkbKkpZY61Lr8a3t+HjvwEn+0HRhdqyIlFCBb7pTTxR5KCxaApZQXbrUiW
         Qt5g==
X-Gm-Message-State: ALQs6tBd8UkP73zVyb5kuH8TQjXJGDaDLuNJAiS9JffXy6pP8RNEJW8r
        1rrlaFxd0sr/PO7i42yydpY=
X-Google-Smtp-Source: AB8JxZqrsHzks3kQQgR3vEHizR6WrnJA11yWQa68qdHzzdz6Ra8xh8klajf4f99+c3FchpZ5eNvkUA==
X-Received: by 2002:a2e:2f07:: with SMTP id v7-v6mr6208604ljv.56.1525025948783;
        Sun, 29 Apr 2018 11:19:08 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id r78-v6sm975376ljb.20.2018.04.29.11.19.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 29 Apr 2018 11:19:08 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, sunshine@sunshineco.com,
        szeder.dev@gmail.com
Subject: [PATCH v5 05/10] git.c: convert --list-*builtins to --list-cmds=*
Date:   Sun, 29 Apr 2018 20:18:39 +0200
Message-Id: <20180429181844.21325-6-pclouds@gmail.com>
X-Mailer: git-send-email 2.17.0.664.g8924eee37a
In-Reply-To: <20180429181844.21325-1-pclouds@gmail.com>
References: <20180421165414.30051-1-pclouds@gmail.com>
 <20180429181844.21325-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Even if these are hidden options, let's make them a bit more generic
since we're introducing more listing types shortly.

This also allows combining multiple listing types, which is usually
now (for combining parseopt and builtins) but future types will
benefit from this.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 contrib/completion/git-completion.bash |  2 +-
 git.c                                  | 27 ++++++++++++++++++++------
 t/t0012-help.sh                        |  2 +-
 3 files changed, 23 insertions(+), 8 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 01dd9ff07a..d7b448fd94 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -3044,7 +3044,7 @@ __git_complete_common () {
 __git_cmds_with_parseopt_helper=
 __git_support_parseopt_helper () {
 	test -n "$__git_cmds_with_parseopt_helper" ||
-		__git_cmds_with_parseopt_helper="$(__git --list-parseopt-builtins)"
+		__git_cmds_with_parseopt_helper="$(__git --list-cmds=parseopt)"
 
 	case " $__git_cmds_with_parseopt_helper " in
 	*" $1 "*)
diff --git a/git.c b/git.c
index f598fae7b7..ea9bbfb6a3 100644
--- a/git.c
+++ b/git.c
@@ -38,6 +38,25 @@ static int use_pager = -1;
 
 static void list_builtins(unsigned int exclude_option, char sep);
 
+static int list_cmds(const char *spec)
+{
+	while (*spec) {
+		const char *sep = strchrnul(spec, ',');
+		int len = sep - spec;
+
+		if (len == 8 && !strncmp(spec, "builtins", 8))
+			list_builtins(0, '\n');
+		else if (len == 8 && !strncmp(spec, "parseopt", 8))
+			list_builtins(NO_PARSEOPT, ' ');
+		else
+			die(_("unsupported command listing type '%s'"), spec);
+		spec += len;
+		if (*spec == ',')
+			spec++;
+	}
+	return 0;
+}
+
 static void commit_pager_choice(void) {
 	switch (use_pager) {
 	case 0:
@@ -223,12 +242,8 @@ static int handle_options(const char ***argv, int *argc, int *envchanged)
 			}
 			(*argv)++;
 			(*argc)--;
-		} else if (!strcmp(cmd, "--list-builtins")) {
-			list_builtins(0, '\n');
-			exit(0);
-		} else if (!strcmp(cmd, "--list-parseopt-builtins")) {
-			list_builtins(NO_PARSEOPT, ' ');
-			exit(0);
+		} else if (skip_prefix(cmd, "--list-cmds=", &cmd)) {
+			exit(list_cmds(cmd));
 		} else {
 			fprintf(stderr, _("unknown option: %s\n"), cmd);
 			usage(git_usage_string);
diff --git a/t/t0012-help.sh b/t/t0012-help.sh
index c096f33505..3c91a9024a 100755
--- a/t/t0012-help.sh
+++ b/t/t0012-help.sh
@@ -59,7 +59,7 @@ test_expect_success 'git help' '
 '
 
 test_expect_success 'generate builtin list' '
-	git --list-builtins >builtins
+	git --list-cmds=builtins >builtins
 '
 
 while read builtin
-- 
2.17.0.664.g8924eee37a

