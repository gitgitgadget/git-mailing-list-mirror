Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DA5991F453
	for <e@80x24.org>; Fri,  1 Feb 2019 22:04:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726652AbfBAWEf (ORCPT <rfc822;e@80x24.org>);
        Fri, 1 Feb 2019 17:04:35 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:44870 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726054AbfBAWEf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Feb 2019 17:04:35 -0500
Received: by mail-pf1-f195.google.com with SMTP id u6so3865431pfh.11
        for <git@vger.kernel.org>; Fri, 01 Feb 2019 14:04:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=Uj0gr9DoHHdKBkQsWhVD6KKHOCm0Hb8ua7S4FSAnrTQ=;
        b=R3Zm/NlvRg6nxmZVXhiBeIkc9dOk61JpieiEVojFkOf7nZLoyuhe8iYEzmbRxjR0QL
         WXZd4tPmZMLJ+IUP6znM9n8TlDbkbyqxWk2UuWo9V7zJaTzhFQqoj4puxz40Dab+UEU0
         lWqOP2h0NkUpSpVZmYxwS1mXvfWHh59qAKoY1xQmq38GfEt+vaRL2EsBWsTSbqkz3pLr
         fhirTgyhUI1Qc8mpRBoEur/o0CIXizJBCh2CDXcAgBH8hLjOCyi8/aVdx5tGVa3rKyQv
         C993YS2gu0JV2FUyp4Vx536Ad4CFnp30vY5+Y3M4Pp6vpoUr1v7918pNLQxcZZqLXWzj
         mLyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=Uj0gr9DoHHdKBkQsWhVD6KKHOCm0Hb8ua7S4FSAnrTQ=;
        b=iEy3h3U2V9e1bqzr/SbbhMYtPTRBziohqmD6/Gw3Zo8wZC6dE+hQWGJ1ORI75e0nzB
         fZwyvZYtMsOX8CYqOrN+oXSHi+tE/DGsINBsMG+wgofV8KFl/MRoE+B/QX2PAnxlICEh
         JDxPMTeGNawWrMc1QPYBo3SFx+Wi5PlHR5CZyWRx3jzDBtRcRlZFoCSOPQmS5WREaG+D
         YPvmYa8iOdFYU6Ct9vTJW6fDFe+nL+Jhg0RYBpWJTXL01n0PLtEU7uCSKsoUKRLPNCQv
         kcaF51MDMqeXVF+F19W7XMCGukApk7iBsPIn4jHbbvy9Jsp3FlSYf04WOsARFdqlWxeE
         uqgA==
X-Gm-Message-State: AJcUukd/Ap0+hzuaOvvkJwx62nD3u7I3FCRKm1Otfa3BzvsnosTm251y
        tRi+Yz7K5HiENWHNE+3cvnA4OZEz6eY=
X-Google-Smtp-Source: ALg8bN620q3khdgGUEcd7/LMZPZf5CBGvoV531Wkczxux37H3+wjILmz2qCQ6GkoXH1x0++YHqGlng==
X-Received: by 2002:a62:184e:: with SMTP id 75mr40457284pfy.28.1549058674013;
        Fri, 01 Feb 2019 14:04:34 -0800 (PST)
Received: from localhost.localdomain (cpe-23-241-199-231.socal.res.rr.com. [23.241.199.231])
        by smtp.gmail.com with ESMTPSA id h128sm12131281pgc.15.2019.02.01.14.04.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 01 Feb 2019 14:04:33 -0800 (PST)
From:   nbelakovski@gmail.com
To:     git@vger.kernel.org
Cc:     peff@peff.net, rafa.almas@gmail.com, gitster@pobox.com,
        avarab@gmail.com, Nickolai Belakovski <nbelakovski@gmail.com>
Subject: [PATCH v7 3/3] branch: Add an extra verbose output displaying worktree path for refs checked out in a linked worktree
Date:   Fri,  1 Feb 2019 14:04:20 -0800
Message-Id: <20190201220420.36216-4-nbelakovski@gmail.com>
X-Mailer: git-send-email 2.14.2
In-Reply-To: <20190201220420.36216-1-nbelakovski@gmail.com>
References: <"<CAC05386q2iGoiJ_fRgwoOTF23exEN2D1+oh4VjajEvYQ58O1TQ@mail.gmail.com>">
 <20190201220420.36216-1-nbelakovski@gmail.com>
In-Reply-To: <CAC05386q2iGoiJ_fRgwoOTF23exEN2D1+oh4VjajEvYQ58O1TQ@mail.gmail.com>
References: <CAC05386q2iGoiJ_fRgwoOTF23exEN2D1+oh4VjajEvYQ58O1TQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Nickolai Belakovski <nbelakovski@gmail.com>

Signed-off-by: Nickolai Belakovski <nbelakovski@gmail.com>
---
 Documentation/git-branch.txt | 6 ++++--
 builtin/branch.c             | 4 ++++
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.txt
index b3eca6ffdc..778be7080f 100644
--- a/Documentation/git-branch.txt
+++ b/Documentation/git-branch.txt
@@ -167,8 +167,10 @@ This option is only applicable in non-verbose mode.
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

