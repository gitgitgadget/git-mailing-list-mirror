Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 51C49200B9
	for <e@80x24.org>; Mon,  7 May 2018 17:53:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752755AbeEGRxQ (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 May 2018 13:53:16 -0400
Received: from mail-lf0-f45.google.com ([209.85.215.45]:39077 "EHLO
        mail-lf0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752716AbeEGRxH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 May 2018 13:53:07 -0400
Received: by mail-lf0-f45.google.com with SMTP id j193-v6so41892276lfg.6
        for <git@vger.kernel.org>; Mon, 07 May 2018 10:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=WsjqwLJTRvlqEJa3PQeAeZlGrW6Luixy3a9oN9750BM=;
        b=B61l4g1AFL/gGp8YBLABztnU4NleO1FYk+ddyScNOAk6NogaVtT8BATgAePRWFKaDG
         nvH24BF4azvRJnbIDLhvn5ktDjtiGuVMSDtL7T9FkKAZoiC1QWm2PiNjif5nRZkvPZEq
         Cd5W4c6gs3BnUlLisGnwP2iV20bRFnnag7dzH/Xy26et4BgeHN4xpdKzwhScYdCamnVq
         yk2WlZOedCU9uo1oDpyBAaylAPt0jxeYvIzLOrnnuycbdRnCaS6uq98C/hGdXAvRs51n
         rfnu3cLdpa2YaJ9cbK4QjQyX/ly50lnukHB9wJVI1TlnicsUlfpxlSjg16gnDtNM7Hvt
         0xoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=WsjqwLJTRvlqEJa3PQeAeZlGrW6Luixy3a9oN9750BM=;
        b=enl34Ea/AiyYTVu3o72fc0gYz8qfuO3dvZ+B6+Ml/liTJ1JYUIVFWoFj70Kmi1kKl2
         djkwyNHswO2KhWmqhA85Gq7KiKdXJGwbKmsJGvTugsgWC9/Z6Gi368KSeMNepUvZ0AJY
         D48kaFviLfg1HFzKKT0wzwIni5BNMh0DLCZXIl3G37HeZcs6nazwEJ5+ePMFAGuyuQ6A
         8WALztIRuXXH6mIcmh759mtXr/ihDeoc6iUYubatl39pJioc942TjLRCLEm7Bbbcyb6W
         tiFwvXgViQP4/l5GelZxqsM/gBAVvnbCf5lx78tXTwRDRPapA1eoBwCI5ixzsOAnOW8Y
         W6Jw==
X-Gm-Message-State: ALKqPwf/d+SO824gLM+8T6AMC8PEc16KFyMQICcSg94Vaq//cP81IS3O
        fqin031mPQAXzI3Emb+sDCo=
X-Google-Smtp-Source: AB8JxZrvHiiWmiNlCxyT0+yRKQRr0ZHw1qWj3xqGzuRWqaPDwq2k/4DJJxZnflCv3/g3Al94VCYzMg==
X-Received: by 2002:a2e:1218:: with SMTP id t24-v6mr2511762lje.143.1525715586428;
        Mon, 07 May 2018 10:53:06 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id v6-v6sm4376865ljk.83.2018.05.07.10.53.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 May 2018 10:53:05 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, sunshine@sunshineco.com,
        szeder.dev@gmail.com
Subject: [PATCH v6 05/13] git.c: convert --list-* to --list-cmds=*
Date:   Mon,  7 May 2018 19:52:14 +0200
Message-Id: <20180507175222.12114-6-pclouds@gmail.com>
X-Mailer: git-send-email 2.17.0.705.g3525833791
In-Reply-To: <20180507175222.12114-1-pclouds@gmail.com>
References: <20180429181844.21325-1-pclouds@gmail.com>
 <20180507175222.12114-1-pclouds@gmail.com>
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
---
 contrib/completion/git-completion.bash |  2 +-
 git.c                                  | 30 ++++++++++++++++++++------
 t/t0012-help.sh                        |  2 +-
 3 files changed, 26 insertions(+), 8 deletions(-)

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
index 3a89893712..b2842a22e2 100644
--- a/git.c
+++ b/git.c
@@ -38,6 +38,23 @@ static int use_pager = -1;
 
 static void list_builtins(unsigned int exclude_option, char sep);
 
+static int list_cmds(const char *spec)
+{
+	while (*spec) {
+		const char *sep = strchrnul(spec, ',');
+		int len = sep - spec;
+
+		if (len == 8 && !strncmp(spec, "builtins", 8))
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
@@ -223,12 +240,13 @@ static int handle_options(const char ***argv, int *argc, int *envchanged)
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

