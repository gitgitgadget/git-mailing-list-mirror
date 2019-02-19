Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4F0F81F453
	for <e@80x24.org>; Tue, 19 Feb 2019 08:34:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727584AbfBSIcA (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Feb 2019 03:32:00 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:43326 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725765AbfBSIb7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Feb 2019 03:31:59 -0500
Received: by mail-pg1-f194.google.com with SMTP id v28so9777018pgk.10
        for <git@vger.kernel.org>; Tue, 19 Feb 2019 00:31:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=b+xwehpvwbMf3v9eFk3nSXkTiGqJqNpjqgaBgrhCga8=;
        b=d7hg8ga0MekkBySSfRB3LoRa8iLsqY0CJH8ZH1yhsilz3i8LbVXwjfyVZplofRbLiZ
         4iYvDOTc7nE4sRFgmi594LbcAVgJLwVt5TaiAhD6vFCjSr/itU3v0m3qXpfZ3FiaKN4t
         aFb/kyq6z89SeEFxbqM32b4MM6NZtfV342QtXXzq02rAs6YsLWeYEmeyGNAvheCoVhzC
         54/kQx+Gs6srNoLh1xuaHfrXpeX0b0PWFt97bMqGAacjAcK5OSvQ2G4WtueyXYeXE5d4
         6l17jo/wWn0UubPSZZ7CpNedMU0bzL6jO3Ay6g3+tt1RstITV4d7TZ7bE5dnFM7/zsTE
         J6sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=b+xwehpvwbMf3v9eFk3nSXkTiGqJqNpjqgaBgrhCga8=;
        b=kAu+oAp6xr34Pi9XzeNbuv76zH/iBKVYIAuxDn66Op9dzrdJWMXbsuQFM9R8cxVBxm
         1URVJYwC2OpCRZXdMYS6jvPNH5gqh9ZHYqbcHmkd6sfqV+D1ohsUydjN9B8J0zNLrRKJ
         LQ7rAoFGCyCxLs3TzbUOV0sDv9SpTRd71btQaGor5UPoWw7FYxviZJ4q3sarCUg5qyp4
         b2NymQoEmgqK7sHDHKMhaX/dewHLnIvC9oj70yVO4u8vVceiyK925ssU9mdLZZYJTEH8
         91796ztQFZQ48TQUarQ4SbCDynVXV/3AXetF98X48/5wPPIn+UwoHG6CaZiKvNRbISmc
         4QXg==
X-Gm-Message-State: AHQUAuYqSRvc7110kfw9V4r+CwxnuhWuesHiz1xBIOkDv29NmP/9zOzX
        TBy9EaGG52SIYjOIIhj3lRqrfMnF
X-Google-Smtp-Source: AHgI3IaUekg+ob1qxtFDrIkEQeh/9+WSFDcblpOwiRdWs6g1XS4qMQDzIQEK+bF3Cw7GSl0+1TnDpw==
X-Received: by 2002:a62:1706:: with SMTP id 6mr27925268pfx.28.1550565118606;
        Tue, 19 Feb 2019 00:31:58 -0800 (PST)
Received: from localhost.localdomain (pdadde822.hkidnt01.ap.so-net.ne.jp. [218.221.232.34])
        by smtp.gmail.com with ESMTPSA id f62sm25190120pgc.67.2019.02.19.00.31.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 19 Feb 2019 00:31:58 -0800 (PST)
From:   nbelakovski@gmail.com
To:     git@vger.kernel.org
Cc:     peff@peff.net, rafa.almas@gmail.com, gitster@pobox.com,
        avarab@gmail.com, Nickolai Belakovski <nbelakovski@gmail.com>
Subject: [PATCH v8 3/3] branch: add worktree info on verbose output
Date:   Tue, 19 Feb 2019 17:31:23 +0900
Message-Id: <20190219083123.27686-4-nbelakovski@gmail.com>
X-Mailer: git-send-email 2.14.2
In-Reply-To: <20190219083123.27686-1-nbelakovski@gmail.com>
References: <CAC05386q2iGoiJ_fRgwoOTF23exEN2D1+oh4VjajEvYQ58O1TQ@mail.gmail.com>
 <20190219083123.27686-1-nbelakovski@gmail.com>
In-Reply-To: <CAC05386q2iGoiJ_fRgwoOTF23exEN2D1+oh4VjajEvYQ58O1TQ@mail.gmail.com>
References: <CAC05386q2iGoiJ_fRgwoOTF23exEN2D1+oh4VjajEvYQ58O1TQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Nickolai Belakovski <nbelakovski@gmail.com>

To display worktree path for refs checked out in a linked worktree

Signed-off-by: Nickolai Belakovski <nbelakovski@gmail.com>
---
 Documentation/git-branch.txt |  6 ++++--
 builtin/branch.c             |  4 ++++
 t/t3203-branch-output.sh     | 21 ++++++++++++++++++++-
 3 files changed, 28 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.txt
index f2e5a07d64..326a45f648 100644
--- a/Documentation/git-branch.txt
+++ b/Documentation/git-branch.txt
@@ -168,8 +168,10 @@ This option is only applicable in non-verbose mode.
 	When in list mode,
 	show sha1 and commit subject line for each head, along with
 	relationship to upstream branch (if any). If given twice, print
-	the name of the upstream branch, as well (see also `git remote
-	show <remote>`).
+	the path of the linked worktree, if applicable (not applicable
+	for current worktree since user's path will already be in current
+	worktree) and the name of the upstream branch, as well (see also
+	`git remote show <remote>`).
 
 -q::
 --quiet::
diff --git a/builtin/branch.c b/builtin/branch.c
index c2a86362bb..0b8ba9e4c5 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -367,9 +367,13 @@ static char *build_format(struct ref_filter *filter, int maxwidth, const char *r
 		strbuf_addf(&local, " %s ", obname.buf);
 
 		if (filter->verbose > 1)
+		{
+			strbuf_addf(&local, "%%(if:notequals=*)%%(HEAD)%%(then)%%(if)%%(worktreepath)%%(then)(%s%%(worktreepath)%s) %%(end)%%(end)",
+				    branch_get_color(BRANCH_COLOR_WORKTREE), branch_get_color(BRANCH_COLOR_RESET));
 			strbuf_addf(&local, "%%(if)%%(upstream)%%(then)[%s%%(upstream:short)%s%%(if)%%(upstream:track)"
 				    "%%(then): %%(upstream:track,nobracket)%%(end)] %%(end)%%(contents:subject)",
 				    branch_get_color(BRANCH_COLOR_UPSTREAM), branch_get_color(BRANCH_COLOR_RESET));
+		}
 		else
 			strbuf_addf(&local, "%%(if)%%(upstream:track)%%(then)%%(upstream:track) %%(end)%%(contents:subject)");
 
diff --git a/t/t3203-branch-output.sh b/t/t3203-branch-output.sh
index 94ab05ad59..012ddde7f2 100755
--- a/t/t3203-branch-output.sh
+++ b/t/t3203-branch-output.sh
@@ -241,7 +241,6 @@ test_expect_success 'git branch --format option' '
 '
 
 test_expect_success '"add" a worktree' '
-	mkdir worktree_dir &&
 	git worktree add -b master_worktree worktree_dir master
 '
 
@@ -285,4 +284,24 @@ test_expect_success '--color overrides auto-color' '
 	test_cmp expect.color actual
 '
 
+# This test case has some special code to strip the first 30 characters or so
+# of the output so that we do not have to put commit hashes into the expect
+test_expect_success 'verbose output lists worktree path' '
+	cat >expect <<-EOF &&
+	one
+	one
+	two
+	one
+	two
+	($(pwd)/worktree_dir) two
+	two
+	two
+	EOF
+	git branch -vv >tmp &&
+	SUBSTRLENGTH=$(head -1 tmp | awk "{print index(\$0, \"one\")}") &&
+	awk -v substrlength="$SUBSTRLENGTH" "{print substr(\$0,substrlength,length(\$0))}" <tmp >actual &&
+	test_cmp expect actual
+'
+
+
 test_done
-- 
2.14.2

