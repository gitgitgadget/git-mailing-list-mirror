Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2284E1F42D
	for <e@80x24.org>; Thu, 10 May 2018 08:47:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756950AbeEJIro (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 May 2018 04:47:44 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:34319 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756379AbeEJIrF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 May 2018 04:47:05 -0400
Received: by mail-lf0-f68.google.com with SMTP id r25-v6so1840305lfd.1
        for <git@vger.kernel.org>; Thu, 10 May 2018 01:47:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZXBMZD8z+AxXdgRgnWOQzhPMKgKVyFwqUnpWdO0hawc=;
        b=g/Bvlmxn2vhImTZLuRLCeeRtvWMubZuD+FzQr/u2aHoRHVWRROM3BVpxAiyEoV834A
         7NG8dGFl+qkZj5mGjFP/z/+3tkJSycb8v5utpVTJr49u4Hk9OkBdjHvPM3lKCBhEjJ2y
         kETmmtzjYEUCJCn7K+AMq2bVqKM9j9wdRvb2NjWzoBSAVyZzrMHUSj5ozuTVLj1jR2yB
         JZQUdw2g6ZH3+w/zUNLH6Jdm3ir2cw0mDcW4vCEPZduohJa/arxnPMNj6jSzrQ/Inpg2
         WBZPX6KyaetAwr4LV8rhOfmbuVUkPqTJ4JaWfu9Ba0PEVmIAc1fmfOSGjcbdhmhmF9iZ
         J5eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZXBMZD8z+AxXdgRgnWOQzhPMKgKVyFwqUnpWdO0hawc=;
        b=Gwl0ChQ+85IwexVFVnewlO1qNbk7GQMyim0JeI0UwfdN/6pkOt2phfZPrpU/XhYYVE
         ubBc+p/9hHWmC1VhfIy57CmTPH54di3S0CXcfKXb+PKmM7PnaEE1EHT0d/JzoHinew1S
         kzuhI30yRZ+3Io0hkLcgUtVJPT2kiJ+TQ5GbbOHo4yQeMcbfAKvZR+2VVgm7TE+aZRof
         7UvmcDRySrHgo5ViCjKehVDnWwViFM8MhV6hh0Xz2TQoY5uqdu0mMYpZBbWK+vnS1nmO
         JdOl7xUhTVqMU2TuAsXlqtqLE0LHRSq0IkdLZy1HQjHSDT7+4ne38edyc71dkRmsWdXC
         CwpA==
X-Gm-Message-State: ALKqPweAYS3J/8SRr1gOCg2MupPeUjgqo64g3Irh7QKfeEvE04xbLVIh
        nHXZVKk9US8Xpsv9c/9M3pg=
X-Google-Smtp-Source: AB8JxZoRVLinzvue7N3Bf3a54XEu7mV0vxZHY0Xcsbx52I6vP0BOV3GhLwFvafSWPmY30SThWg+CMw==
X-Received: by 2002:a2e:8350:: with SMTP id l16-v6mr501812ljh.28.1525942023837;
        Thu, 10 May 2018 01:47:03 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id l24-v6sm68024lje.42.2018.05.10.01.47.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 May 2018 01:47:03 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, sunshine@sunshineco.com,
        szeder.dev@gmail.com
Subject: [PATCH v7 05/13] git.c: convert --list-* to --list-cmds=*
Date:   Thu, 10 May 2018 10:46:44 +0200
Message-Id: <20180510084652.25880-6-pclouds@gmail.com>
X-Mailer: git-send-email 2.17.0.705.g3525833791
In-Reply-To: <20180510084652.25880-1-pclouds@gmail.com>
References: <20180507175222.12114-1-pclouds@gmail.com>
 <20180510084652.25880-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Even if these are hidden options, let's make them a bit more generic
since we're introducing more listing types shortly. The code is
structured to allow combining multiple listing types together because
we will soon add more types the 'builtins'.

'parseopt' remains separate because it has separate (SPC) to match
git-completion.bash needs and will not combine with others.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 contrib/completion/git-completion.bash |  2 +-
 git.c                                  | 37 +++++++++++++++++++++-----
 t/t0012-help.sh                        |  2 +-
 3 files changed, 33 insertions(+), 8 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index a757073945..3556838759 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -3049,7 +3049,7 @@ __git_complete_common () {
 __git_cmds_with_parseopt_helper=
 __git_support_parseopt_helper () {
 	test -n "$__git_cmds_with_parseopt_helper" ||
-		__git_cmds_with_parseopt_helper="$(__git --list-parseopt-builtins)"
+		__git_cmds_with_parseopt_helper="$(__git --list-cmds=parseopt)"
 
 	case " $__git_cmds_with_parseopt_helper " in
 	*" $1 "*)
diff --git a/git.c b/git.c
index 3a89893712..cd85355d81 100644
--- a/git.c
+++ b/git.c
@@ -38,6 +38,30 @@ static int use_pager = -1;
 
 static void list_builtins(unsigned int exclude_option, char sep);
 
+static int match_token(const char *spec, int len, const char *token)
+{
+	int token_len = strlen(token);
+
+	return len == token_len && !strncmp(spec, token, token_len);
+}
+
+static int list_cmds(const char *spec)
+{
+	while (*spec) {
+		const char *sep = strchrnul(spec, ',');
+		int len = sep - spec;
+
+		if (match_token(spec, len, "builtins"))
+			list_builtins(0, '\n');
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
@@ -223,12 +247,13 @@ static int handle_options(const char ***argv, int *argc, int *envchanged)
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
+			if (!strcmp(cmd, "parseopt")) {
+				list_builtins(NO_PARSEOPT, ' ');
+				exit(0);
+			} else {
+				exit(list_cmds(cmd));
+			}
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
2.17.0.705.g3525833791

