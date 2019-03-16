Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1787A20248
	for <e@80x24.org>; Sat, 16 Mar 2019 01:38:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726736AbfCPBic (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Mar 2019 21:38:32 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:43315 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726649AbfCPBic (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Mar 2019 21:38:32 -0400
Received: by mail-pf1-f195.google.com with SMTP id c8so838960pfd.10
        for <git@vger.kernel.org>; Fri, 15 Mar 2019 18:38:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=I+pmuiRF1vn0PNUriOKb1kA/CI3kf5evv0H1tYz1MWo=;
        b=pg0gKyeCXElz1idcCUxTmu9DfZCeM2Zi/hbviKo4ECyxeB2mgUATdN1uXpNoUwET+4
         QSwqWYg8a1Mt5bbVb2joxCVd9sPyrVHpxHVg1IhWs/hFf9tiOkcPaoIBp9hs6s7M2I8K
         iCkmf6Z2MqDGX7/I1QQS13D9yvHjZkVlZ/MF+DnMO/8QCab7DIijhyNr7YJ3PzXSPTyC
         orRb0pdZoVSUcPQlkXZag/55tmzituIBdpH36Gkc4NLOJ+IZ+RacO93TlLVsSbsmmuv2
         hWSwvJSg6kBRYbHD+rZJft56gRr1IhFNiiP0m9u4fBy8VZxtpg1iPpiSEtIAaysjtSPu
         Io9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=I+pmuiRF1vn0PNUriOKb1kA/CI3kf5evv0H1tYz1MWo=;
        b=Ql6uZUMTQOVw6NniD0wcOD4jvDkZMR4rtBP4mGz9wRSzShDp5svLn3HjlS4PjM0+Au
         obVQNbvf5+se53Paw3ryqH/fBG0IHyctTwnjFyI9l302vrIBhh/xiuPSSKJmj2oOUDU0
         KKzLVc+iKditVMa69ab83qXpGX6484EOBqXSvsvTaiTDjARO3RaX4r2P7UAqVklWLnBr
         hChsjWfQZ2hQwa86oZMMR2N6R/51JUP4wdDIC0rmjHSGcVAxlwsPo5d1WwVortshkYkp
         XkvriR1DLdqFqzy9GrSh2qYQ63uLk3g5yBirT8ODqSuM3UQrGplWdxw4xmZKxYaLl1RW
         H29g==
X-Gm-Message-State: APjAAAWp29qkbok+86Md54R8iuOT3h2sc5uAaq326prV0kQX8BH88jkT
        cxwJ20F2YYPTrKsCtAXHpzYnxEtT
X-Google-Smtp-Source: APXvYqwq5I7rjXnZj23fgNABWmUDV2D96qtxGKEm6aQmhGYhBcP8vmIfTTklO98vHRTC8sn4RlAu2Q==
X-Received: by 2002:a65:6241:: with SMTP id q1mr6410962pgv.340.1552700311564;
        Fri, 15 Mar 2019 18:38:31 -0700 (PDT)
Received: from localhost.localdomain (173-8-128-22-SFBA.hfc.comcastbusiness.net. [173.8.128.22])
        by smtp.gmail.com with ESMTPSA id b138sm5817623pfb.48.2019.03.15.18.38.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 15 Mar 2019 18:38:30 -0700 (PDT)
From:   nbelakovski@gmail.com
To:     git@vger.kernel.org
Cc:     peff@peff.net, gitster@pobox.com, rafa.almas@gmail.com,
        avarab@gmail.com, Nickolai Belakovski <nbelakovski@gmail.com>
Subject: [PATCH v9 3/3] branch: add worktree info on verbose output
Date:   Fri, 15 Mar 2019 18:38:07 -0700
Message-Id: <20190316013807.38756-4-nbelakovski@gmail.com>
X-Mailer: git-send-email 2.14.2
In-Reply-To: <20190316013807.38756-1-nbelakovski@gmail.com>
References: <CAC05386q2iGoiJ_fRgwoOTF23exEN2D1+oh4VjajEvYQ58O1TQ@mail.gmail.com>
 <20190316013807.38756-1-nbelakovski@gmail.com>
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
index 350b039063..3d1872babc 100644
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
index ceb74e0826..e5dc23e225 100755
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
+	test_cmp expect actual
+'
+
 test_done
-- 
2.14.2

