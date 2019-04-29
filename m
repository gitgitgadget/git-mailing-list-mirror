Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 481D81F453
	for <e@80x24.org>; Mon, 29 Apr 2019 05:20:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727203AbfD2FUH (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Apr 2019 01:20:07 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:34880 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727141AbfD2FUG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Apr 2019 01:20:06 -0400
Received: by mail-pl1-f194.google.com with SMTP id w24so4520455plp.2
        for <git@vger.kernel.org>; Sun, 28 Apr 2019 22:20:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2n5CerAfZCu4BU7TIKgW8ZBzLofMTpXO1bus3wYmSV0=;
        b=tYp+jOI7G5mGv/Ih3Ff6HbyWDlCoguyXvBXtjqIq/AnGWiqmuQ45vVV7giazEHOIYg
         bM7i+gcZKLgaP4efDCjbLco0nF61ck3jymmStMwhqbojLeqNkzOSIlZMHqNFpIXQHZ0S
         +n1PlQ17Oi6yUM8YmIFTHKkzshQMvg0zxdbqsCnfpSyswUTTrWoeodO0QEueuytciJkP
         itJ2188ery1nH/z71zV12t/FmlYLlNuAcDP0xTdD1SIEaAPuxLquTF01KFoQECCfU5cR
         IFRt1Loy8eJJ+cp4l5loYeKFIYByLGp6ZsWZ0Hxh0SSfXIsHP346OQefBwAZ13hM+Ja3
         lJ0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2n5CerAfZCu4BU7TIKgW8ZBzLofMTpXO1bus3wYmSV0=;
        b=RvF0eNIQZC/Xo699xLlhv+gwKasqZvfITDnYUDaqD9RXXqhdsuimWAnA+BfD8mQWRW
         2bgMNOgKKELa+0x12eoBAk3dPWAPMqD7akV0JM4060FCVMQHZjC7yMGPR0uT0/xS21Ma
         HhAIGJPRUhDIWn/QJf1sinAfTHhxADFdj3AMVmv1bp44pkMcShzlf00H80uxPpcmFymJ
         AbtgTvm7nzVymScNJyRRFGNzJmlf6svgNW5pDYjI+PSLyEXAXcsev7SngVnDUJvpeflI
         VsDC26puoDd1dXiGOG4W+aK5EluCMZQk6ZaLImrljVmKoa/TabHcwlltengXC4EnFQIG
         mYKA==
X-Gm-Message-State: APjAAAVThnyG4O17IzTybdTUE/6B1XNSvfbp92azP7cA2Qm2srFW1OLM
        z32qmD8hkjIV/vey6IuF00QE+puyqnw=
X-Google-Smtp-Source: APXvYqxiayFcBuyCEnLLEjfDGIhU58AmtkVMYqTOdWaZ7G0OTrWmZAziiSN1pqknkFxBNQF1cxIRFQ==
X-Received: by 2002:a17:902:bf4a:: with SMTP id u10mr27647344pls.63.1556515205365;
        Sun, 28 Apr 2019 22:20:05 -0700 (PDT)
Received: from localhost.localdomain (cpe-23-241-199-231.socal.res.rr.com. [23.241.199.231])
        by smtp.gmail.com with ESMTPSA id r4sm45564843pgl.69.2019.04.28.22.20.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 28 Apr 2019 22:20:04 -0700 (PDT)
From:   nbelakovski@gmail.com
To:     git@vger.kernel.org
Cc:     szeder.dev@gmail.com, Nickolai Belakovski <nbelakovski@gmail.com>
Subject: [PATCH v10 3/3] branch: add worktree info on verbose output
Date:   Sun, 28 Apr 2019 22:19:44 -0700
Message-Id: <20190429051944.77164-4-nbelakovski@gmail.com>
X-Mailer: git-send-email 2.14.2
In-Reply-To: <20190429051944.77164-1-nbelakovski@gmail.com>
References: <CAC05386q2iGoiJ_fRgwoOTF23exEN2D1+oh4VjajEvYQ58O1TQ@mail.gmail.com>
 <20190429051944.77164-1-nbelakovski@gmail.com>
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
 t/t3203-branch-output.sh     | 19 +++++++++++++++++++
 3 files changed, 27 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.txt
index 7d18dffc4b..d11d00583a 100644
--- a/Documentation/git-branch.txt
+++ b/Documentation/git-branch.txt
@@ -172,8 +172,10 @@ This option is only applicable in non-verbose mode.
 	When in list mode,
 	show sha1 and commit subject line for each head, along with
 	relationship to upstream branch (if any). If given twice, print
-	the name of the upstream branch, as well (see also `git remote
-	show <remote>`).
+	the path of the linked worktree (if any) and the name of the upstream
+	branch, as well (see also `git remote show <remote>`).  Note that the
+	current worktree's HEAD will not have its path printed (it will always
+	be your current directory).
 
 -q::
 --quiet::
diff --git a/builtin/branch.c b/builtin/branch.c
index a295380f45..2cb45e42e1 100644
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
index a3436bf25a..4bef8c7569 100755
--- a/t/t3203-branch-output.sh
+++ b/t/t3203-branch-output.sh
@@ -328,4 +328,23 @@ test_expect_success '--color overrides auto-color' '
 	test_cmp expect.color actual
 '
 
+test_expect_success 'verbose output lists worktree path' '
+	one=$(git rev-parse --short HEAD) &&
+	two=$(git rev-parse --short master) &&
+	cat >expect <<-EOF &&
+	* (HEAD detached from fromtag) $one one
+	  ambiguous                    $one one
+	  branch-one                   $two two
+	+ branch-two                   $one ($(pwd)/worktree_dir) one
+	  master                       $two two
+	  ref-to-branch                $two two
+	  ref-to-remote                $two two
+	EOF
+	git worktree add worktree_dir branch-two &&
+	git branch -vv >actual &&
+	rm -r worktree_dir &&
+	git worktree prune &&
+	test_i18ncmp expect actual
+'
+
 test_done
-- 
2.14.2

