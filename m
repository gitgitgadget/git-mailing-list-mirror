Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 826822018E
	for <e@80x24.org>; Fri, 26 Aug 2016 17:58:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753956AbcHZR6x (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Aug 2016 13:58:53 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36000 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753951AbcHZR6v (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Aug 2016 13:58:51 -0400
Received: by mail-wm0-f68.google.com with SMTP id i138so213947wmf.3
        for <git@vger.kernel.org>; Fri, 26 Aug 2016 10:58:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Ji7dXSDgbd7HmhgAAd3OZcjbxITZnEjHKSWWxcxeTQs=;
        b=U4PsBaLSsNNGLlnhT9SagNGaMcOJa534FEcnPUwLSWrj6FiVxnNUNXc8kVv51QQEl3
         83pLIAbfcZMT/6XCCskJHoGdOg2KsAX5wymOlt/XLBeQYrVgA8hH27nz7Mj7vswSqSM6
         q3uXpqUPzbiEw7sPUYyeDUiTusmebETKk1vA8FFPT87o04XbTP4MTAcDX5RB1tlns7a7
         OlU4/JopoRggph2WPnh/4yM1H3uOaEy5rGixk/O0L/apVH+vNy9pW3wAPG3Gi8L8zP6N
         zyn8jr+3bq9CcHnMBQuidiAaVKyDFCSxi9j4sQZdCqt31p5VtLOMCZqdjDUF4uAfGaI7
         2hUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Ji7dXSDgbd7HmhgAAd3OZcjbxITZnEjHKSWWxcxeTQs=;
        b=HY5Y9AyVIzgtChaZ0Lqf8EK/uMP5W7BrmjyGkPoRN/7EdxtV7G/mStZOeAP+qk3Eqz
         pNC5pW30lq+nL/oyweYb/u6lS46+DhKYYMOTfvV+sxsDTEVZh/tB12udF/ITnMN7avuo
         CzM/IpmyRcMCmGjJm2VKrifziBvt5wSXZRKbBZHotZGeiCj2WuFIYoHL1nLR/Cs/0G63
         0+Y3yqfKUO8SCAqDD4aSJ8jXTMO4srdU7zJqOzPS2mT51uYhM0PLMfubwGF/Dqq7JVhs
         tyXxSVP1uEiRTV3MyUm39iWDy/8DztnJ83YOfjeEUbi4wdpe7iPSEWUQx0/t8n/upT+7
         NERA==
X-Gm-Message-State: AE9vXwO0CMWLWmGxI01DM6bJc9DGhe83rqlAsgkkkcLrHIpvHDS4gzckOFx6+XI9Mmvpag==
X-Received: by 10.28.25.71 with SMTP id 68mr99961wmz.91.1472234329788;
        Fri, 26 Aug 2016 10:58:49 -0700 (PDT)
Received: from localhost (cable-86-56-27-135.cust.telecolumbus.net. [86.56.27.135])
        by smtp.gmail.com with ESMTPSA id n7sm21019627wjf.11.2016.08.26.10.58.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Aug 2016 10:58:49 -0700 (PDT)
From:   Ralf Thielow <ralf.thielow@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, larsxschneider@gmail.com, me@jnm2.com,
        philipoakley@iee.org, john@keeping.me.uk,
        johannes.schindelin@gmx.de, Ralf Thielow <ralf.thielow@gmail.com>
Subject: [PATCH v2 3/3] help: make option --help open man pages only for Git commands
Date:   Fri, 26 Aug 2016 19:58:36 +0200
Message-Id: <20160826175836.14073-4-ralf.thielow@gmail.com>
X-Mailer: git-send-email 2.9.2.912.gd0c0e83
In-Reply-To: <20160826175836.14073-1-ralf.thielow@gmail.com>
References: <20160818185719.4909-1-ralf.thielow@gmail.com>
 <20160826175836.14073-1-ralf.thielow@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If option --help is passed to a Git command, we try to open
the man page of that command.  However, we do it for both commands
and concepts.  Make sure it is an actual command.

This makes "git <concept> --help" not working anymore, while
"git help <concept>" still works.

Signed-off-by: Ralf Thielow <ralf.thielow@gmail.com>
---
 Documentation/git-help.txt |  5 +++--
 git.c                      | 15 ++++++++++++++-
 t/t0012-help.sh            |  8 ++++++++
 3 files changed, 25 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-help.txt b/Documentation/git-help.txt
index eeb1950..8d21e9f 100644
--- a/Documentation/git-help.txt
+++ b/Documentation/git-help.txt
@@ -29,8 +29,9 @@ guide is brought up. The 'man' program is used by default for this
 purpose, but this can be overridden by other options or configuration
 variables.
 
-Note that `git --help ...` is identical to `git help ...` because the
-former is internally converted into the latter.
+Note that `git --help ...` is almost identical to `git help ...` because
+the former is internally converted into the latter with option --exclude-guides
+being added.
 
 To display the linkgit:git[1] man page, use `git help git`.
 
diff --git a/git.c b/git.c
index 0f1937f..1c61151 100644
--- a/git.c
+++ b/git.c
@@ -522,21 +522,34 @@ static void strip_extension(const char **argv)
 
 static void handle_builtin(int argc, const char **argv)
 {
+	struct argv_array args = ARGV_ARRAY_INIT;
 	const char *cmd;
 	struct cmd_struct *builtin;
 
 	strip_extension(argv);
 	cmd = argv[0];
 
-	/* Turn "git cmd --help" into "git help cmd" */
+	/* Turn "git cmd --help" into "git help --exclude-guides cmd" */
 	if (argc > 1 && !strcmp(argv[1], "--help")) {
+		int i;
+
 		argv[1] = argv[0];
 		argv[0] = cmd = "help";
+
+		for (i = 0; i < argc; i++) {
+			argv_array_push(&args, argv[i]);
+			if (!i)
+				argv_array_push(&args, "--exclude-guides");
+		}
+
+		argc++;
+		argv = args.argv;
 	}
 
 	builtin = get_builtin(cmd);
 	if (builtin)
 		exit(run_builtin(builtin, argc, argv));
+	argv_array_clear(&args);
 }
 
 static void execv_dashed_external(const char **argv)
diff --git a/t/t0012-help.sh b/t/t0012-help.sh
index fb1abd7..2b90947 100755
--- a/t/t0012-help.sh
+++ b/t/t0012-help.sh
@@ -30,4 +30,12 @@ test_expect_success "--exclude-guides does not work for guides" "
 	test_i18ncmp expected actual
 "
 
+test_expect_success "--help does not work for guides" "
+	cat <<-EOF >expected &&
+		git: 'revisions' is not a git command. See 'git --help'.
+	EOF
+	test_must_fail git revisions --help 2>actual &&
+	test_i18ncmp expected actual
+"
+
 test_done
-- 
2.9.2.912.gd0c0e83

