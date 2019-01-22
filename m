Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8498F1F453
	for <e@80x24.org>; Tue, 22 Jan 2019 23:23:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726907AbfAVXXY (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Jan 2019 18:23:24 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:39959 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726741AbfAVXXX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Jan 2019 18:23:23 -0500
Received: by mail-pf1-f194.google.com with SMTP id i12so144796pfo.7
        for <git@vger.kernel.org>; Tue, 22 Jan 2019 15:23:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=MJ4XOKpK59zkhiiUtopH1ZCvJueDIfsnNfu19jHmmtI=;
        b=Bih51gC6v/+yyUte5YeX9wfaG3zvZrpysYeGkx0mlDKZtOULtRZw4B3rozR1JFgGP7
         nhrt1fsyBDwq1JC0BFwlqYm1aQl3Lqi/Zn/dNW/7FdiCA7kvk5xypDHBErGIrWQljdjc
         G+hzLB83m/pyJd7R9GjvboenLBBoXPR4nJbU9ttfHrPDftGJYOLiUMZM/bffA/DcM5VK
         +ZhQqGEn7trSANzA8wX95X1jL2D+HhAyopczB7sit6JPf5Ew34YWfp5HnIb0AuY8/j4p
         2KKsECwpS28q25LxHnLfwKaUzyBxOrK+RChj5FERkITufDOMe1s9oZcm3FG/rP80C4uu
         PqDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=MJ4XOKpK59zkhiiUtopH1ZCvJueDIfsnNfu19jHmmtI=;
        b=Lxm16rtgUZJXQOgw0ov5Ft8PKR2Jv6cpg+m690AN98LKg8lRpoPXLjhppNeLCcUnlb
         HzMLG8U4pUqNa7eqKEed5fa0oD+WrFR8ZrRbq8lRsgUYArzpZpWJHzSFBTMLW+yOeTu1
         jiKiIri+jOauj+11bLWlNlVl69iR1tjjcYM7mmi+XUCtrRl+Nl0XluMK2WS2pllnNPcw
         6rGuWllJtgV5qVuBEpBls66MfuXIGBrQn0K9cJm3Na6AiYbAoEmlm6I/fhZb1qwm/6Nv
         ufuO6nnGtZGnszrLScgYouYYS4zZk0iddux3QdFu6x62mhI9LD3S6//NIkxZXWQttGnR
         uAGw==
X-Gm-Message-State: AJcUukeCXcvpGwwpUrZY1CMu9Rh0/aTh58+MbRf+NCenDk9DDBezJgzn
        8uBZTyST04VrC/Am4KgaYkudnuPt
X-Google-Smtp-Source: ALg8bN5n88pwotWTmoNPuzz/BAzphDXuglbThsY+FDYAFOxOept/oXlW1XNfo/uFTq/KagyGGh/+Kg==
X-Received: by 2002:a63:7e1a:: with SMTP id z26mr33067336pgc.216.1548199402298;
        Tue, 22 Jan 2019 15:23:22 -0800 (PST)
Received: from localhost.localdomain ([12.167.51.36])
        by smtp.gmail.com with ESMTPSA id 84sm23608057pfk.134.2019.01.22.15.23.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 22 Jan 2019 15:23:21 -0800 (PST)
From:   nbelakovski@gmail.com
To:     git@vger.kernel.org
Cc:     peff@peff.net, rafa.almas@gmail.com, gitster@pobox.com,
        avarab@gmail.com, Nickolai Belakovski <nbelakovski@gmail.com>
Subject: [PATCH v6 3/3] branch: Add an extra verbose output displaying worktree path for refs checked out in a linked worktree
Date:   Tue, 22 Jan 2019 15:23:01 -0800
Message-Id: <20190122232301.95971-4-nbelakovski@gmail.com>
X-Mailer: git-send-email 2.14.2
In-Reply-To: <20190122232301.95971-1-nbelakovski@gmail.com>
References: <CAC05386q2iGoiJ_fRgwoOTF23exEN2D1+oh4VjajEvYQ58O1TQ@mail.gmail.com>
 <20190122232301.95971-1-nbelakovski@gmail.com>
In-Reply-To: <CAC05386q2iGoiJ_fRgwoOTF23exEN2D1+oh4VjajEvYQ58O1TQ@mail.gmail.com>
References: <CAC05386q2iGoiJ_fRgwoOTF23exEN2D1+oh4VjajEvYQ58O1TQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Nickolai Belakovski <nbelakovski@gmail.com>

---
 Documentation/git-branch.txt | 7 +++++--
 builtin/branch.c             | 4 ++++
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.txt
index b3eca6ffdc..a1aef00af0 100644
--- a/Documentation/git-branch.txt
+++ b/Documentation/git-branch.txt
@@ -163,12 +163,15 @@ This option is only applicable in non-verbose mode.
 
 -v::
 -vv::
+-vvv::
 --verbose::
 	When in list mode,
 	show sha1 and commit subject line for each head, along with
 	relationship to upstream branch (if any). If given twice, print
-	the name of the upstream branch, as well (see also `git remote
-	show <remote>`).
+	the path of the linked worktree, if applicable (not applicable
+	for main worktree since user's path will already be in main
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
 
-- 
2.14.2

