Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 55BD01F424
	for <e@80x24.org>; Wed, 25 Apr 2018 16:31:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755593AbeDYQbr (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Apr 2018 12:31:47 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:42477 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755449AbeDYQbf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Apr 2018 12:31:35 -0400
Received: by mail-lf0-f66.google.com with SMTP id u21-v6so24771305lfu.9
        for <git@vger.kernel.org>; Wed, 25 Apr 2018 09:31:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qSL+kyhLCpFPS6tdOe8xbccN41HUwXLaLSYWrTydqtA=;
        b=Sp+hfQ/C9BL1aYbRrsHZQpOFAVbGETNaekDkD6ASfd1uUdrIYQax0ogmHJCmZY4mdO
         foIzqooQtgp3j3tVRnjdCPjJyB3qmcxnSIQs8Xb3Y058RV5aXnMxTqBCHOVQ8WRIwbmk
         tlYlO5JJhqFYTAFGd+QZtDLk1p0AINmVuuoizGDkakMn/2m0SjSuVIHYYYv5TjfvCmAs
         PdnNwuxf3TTBRIpyQ76r69BXPP4KqCYHa1dBT1xVEzdJFvOv/33T9jPfLchSRP4OutYa
         XdYEU0q2dBSETC1o8sihCnV1OYJ8KdcUc61sB8JGdyBD1BjeXGyt+r6Kbjj5MOMelffO
         0X8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qSL+kyhLCpFPS6tdOe8xbccN41HUwXLaLSYWrTydqtA=;
        b=Tgkjy5po14NpruI2R4F4Kj0YtcQyBG9Bh7wOfXNHDpHFJPZpRrs8qlPRvc9RqMGWsF
         kFaUwZOiFhHLOgobbE32MQEWE04gCN7Kqz8Q7iAvQ/BiHjdb0FlxCnCqw/7o2A2X0GYd
         8d19xf3swIVnQxxekhlo4zdjEfMmgOkcF77g4Q4u1MCaCbUvT/8vCo/jWWq9snGGksNp
         Jepojmg9nD8Sdkko9Lv19DhysMNC0aDRnD7woU0+epfGMkfZMlMb2eSR235FqQfztM4e
         jtcVchika3P89Gv506uUcTY5HO7kShp2Oz6FGOcwdqp9D3xSk5lv4ZQdvrLUbtp886hH
         fxkQ==
X-Gm-Message-State: ALQs6tCmw7WxlZT+h5tqSdlyidvxiM54y643CSMlO8L2vFB5f8wRChsj
        dTc3haVDCKDfLjlmx7hAIVI=
X-Google-Smtp-Source: AIpwx4+9eNKP9KviQAREPhFILB0cm1M91RC4y7e2fz3AftYZ0CYAbhSbBwiv6eIo15xltuAyRsM7cg==
X-Received: by 10.46.128.76 with SMTP id p12mr19866087ljg.71.1524673894398;
        Wed, 25 Apr 2018 09:31:34 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id t24sm518370ljg.65.2018.04.25.09.31.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 Apr 2018 09:31:33 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, sunshine@sunshineco.com,
        szeder.dev@gmail.com
Subject: [PATCH v4/wip 06/12] git: accept multiple --list-cmds options
Date:   Wed, 25 Apr 2018 18:31:01 +0200
Message-Id: <20180425163107.10399-7-pclouds@gmail.com>
X-Mailer: git-send-email 2.17.0.519.gb89679a4aa
In-Reply-To: <20180425163107.10399-1-pclouds@gmail.com>
References: <20180421165414.30051-1-pclouds@gmail.com>
 <20180425163107.10399-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Later on we may support non-overlapping command groups to
--list-cmds. Allow the user to execute just one "git" process and get
multiple groups. This may matter for git-completion.bash on Windows
because we don't want the user to way for long when TAB-ing and
Windows is slow on launching new processes.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 git.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/git.c b/git.c
index 28bfa96d87..a46263306d 100644
--- a/git.c
+++ b/git.c
@@ -64,6 +64,7 @@ void setup_auto_pager(const char *cmd, int def)
 static int handle_options(const char ***argv, int *argc, int *envchanged)
 {
 	const char **orig_argv = *argv;
+	int commands_listed = 0;
 
 	while (*argc > 0) {
 		const char *cmd = (*argv)[0];
@@ -230,7 +231,7 @@ static int handle_options(const char ***argv, int *argc, int *envchanged)
 				list_builtins(NO_PARSEOPT, ' ');
 			else
 				die("unsupported command listing type '%s'", cmd);
-			exit(0);
+			commands_listed++;
 		} else {
 			fprintf(stderr, _("unknown option: %s\n"), cmd);
 			usage(git_usage_string);
@@ -239,6 +240,8 @@ static int handle_options(const char ***argv, int *argc, int *envchanged)
 		(*argv)++;
 		(*argc)--;
 	}
+	if (commands_listed)
+		exit(0);
 	return (*argv) - orig_argv;
 }
 
-- 
2.17.0.519.gb89679a4aa

