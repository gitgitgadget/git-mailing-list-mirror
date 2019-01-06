Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B1453211B4
	for <e@80x24.org>; Sun,  6 Jan 2019 00:26:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726389AbfAFA0f (ORCPT <rfc822;e@80x24.org>);
        Sat, 5 Jan 2019 19:26:35 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:34318 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726364AbfAFA0e (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 Jan 2019 19:26:34 -0500
Received: by mail-pf1-f196.google.com with SMTP id h3so20053089pfg.1
        for <git@vger.kernel.org>; Sat, 05 Jan 2019 16:26:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=gmj9cOKjf9eNaado/rGoApnApEIcP5otGDSKvJ8ILbs=;
        b=BsktX3OagfOUAnsIAbHw4nIrAvCiKSouMWymABnK5+uXHth2ZoHxYGGYnvOZXPGBy+
         mvzTuEhAVdRAgktJTDPDElbNMYg7p+OdqoS+VEveDclPJ5JpLqtAALmKkbm+fRApthka
         MIIqb58EsZ4WKyQXR5Pu9uKUDWUP/VOoZcxo112psRkIRq0L8ZUKXGI/CaYGWRJonYna
         Emp4pdWlW+HipMqooRPZarUaq3BiPSprTpACWRACrDdW7to2QiPMXX2szeWhX/mpBfIN
         36Kq6Xbe5qv4hfa+bVeAOoWPMlmlrZnBitsYKf3CmwhhnT24ehERPrKeiWkKR8x5zHz7
         JWEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=gmj9cOKjf9eNaado/rGoApnApEIcP5otGDSKvJ8ILbs=;
        b=kvjj0JPbDBVsK2g5py5DZz5l5qk6r3w111wn12ir1LrJ+/Eer8cQdaBSi2jm+CScV7
         LYlP2YG4rl8kLbKlLae+V5HXNyJsnYEdBLOj45kgfVXlu5DGhHNPk60U9Zv/qtruxMkM
         GZhNhkmviFmdbt7IgmPmkX1RAbRITc/9D375xCKl8MyRmH2mtD8nuF2QWiNK1zbsC4w/
         dG1rE31G/5tWPoUpuD8PupwaCl2K/c1mK9xf7QiRa5pPf4nFnWm1VPoF7/5Hzgoxy/CK
         szmwbW9wHcMNEOKAahEY70n8Px830kAWUB6jb/ySNkxjXx3PDPqibS5ZkcbEiziU45TS
         9WwA==
X-Gm-Message-State: AJcUukdosCk24iiO8q5XngjbGKLRHswS+am3R5Wj5mAiEF5crT74VjhB
        11RXe6mTL3ZeuPcTt+uybCFDfDgf
X-Google-Smtp-Source: ALg8bN5iiOqTCfdH3wTlTRTBhpSiQjtrr77JN2YqSDkTUZnHIqK/AcsKUOKQGglIHNS5A1DHJac/1w==
X-Received: by 2002:a63:5207:: with SMTP id g7mr6339344pgb.253.1546734392586;
        Sat, 05 Jan 2019 16:26:32 -0800 (PST)
Received: from localhost.localdomain (cpe-23-241-199-231.socal.res.rr.com. [23.241.199.231])
        by smtp.gmail.com with ESMTPSA id e16sm85376485pfn.46.2019.01.05.16.26.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 05 Jan 2019 16:26:32 -0800 (PST)
From:   nbelakovski@gmail.com
To:     git@vger.kernel.org
Cc:     peff@peff.net, rafa.almas@gmail.com, gitster@pobox.com,
        avarab@gmail.com, Nickolai Belakovski <nbelakovski@gmail.com>
Subject: [PATCH v5 3/3] branch: Add an extra verbose output displaying worktree path for refs checked out in a linked worktree
Date:   Sat,  5 Jan 2019 16:26:19 -0800
Message-Id: <20190106002619.54741-4-nbelakovski@gmail.com>
X-Mailer: git-send-email 2.14.2
In-Reply-To: <20190106002619.54741-1-nbelakovski@gmail.com>
References: <CAC05386q2iGoiJ_fRgwoOTF23exEN2D1+oh4VjajEvYQ58O1TQ@mail.gmail.com>
 <20190106002619.54741-1-nbelakovski@gmail.com>
In-Reply-To: <CAC05386q2iGoiJ_fRgwoOTF23exEN2D1+oh4VjajEvYQ58O1TQ@mail.gmail.com>
References: <CAC05386q2iGoiJ_fRgwoOTF23exEN2D1+oh4VjajEvYQ58O1TQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Nickolai Belakovski <nbelakovski@gmail.com>

---
 Documentation/git-branch.txt | 5 ++++-
 builtin/branch.c             | 4 ++++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.txt
index b3eca6ffdc..6d1fc59e32 100644
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
 	the name of the upstream branch, as well (see also `git remote
-	show <remote>`).
+	show <remote>`). If given 3 times, print the path of the linked
+	worktree, if applicable (not applicable for main worktree since
+	its path will be a subset of $PWD)
 
 -q::
 --quiet::
diff --git a/builtin/branch.c b/builtin/branch.c
index 2a24153b78..56589a3684 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -366,6 +366,10 @@ static char *build_format(struct ref_filter *filter, int maxwidth, const char *r
 		strbuf_addstr(&local, branch_get_color(BRANCH_COLOR_RESET));
 		strbuf_addf(&local, " %s ", obname.buf);
 
+		if (filter->verbose > 2)
+			strbuf_addf(&local, "%s%%(if:notequals=*)%%(HEAD)%%(then)%%(if)%%(worktreepath)%%(then)%%(worktreepath) %%(end)%%(end)%s",
+				    branch_get_color(BRANCH_COLOR_WORKTREE), branch_get_color(BRANCH_COLOR_RESET));
+
 		if (filter->verbose > 1)
 			strbuf_addf(&local, "%%(if)%%(upstream)%%(then)[%s%%(upstream:short)%s%%(if)%%(upstream:track)"
 				    "%%(then): %%(upstream:track,nobracket)%%(end)] %%(end)%%(contents:subject)",
-- 
2.14.2

