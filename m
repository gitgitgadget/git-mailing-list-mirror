Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2D64D1F404
	for <e@80x24.org>; Sun,  4 Feb 2018 22:13:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752154AbeBDWNN (ORCPT <rfc822;e@80x24.org>);
        Sun, 4 Feb 2018 17:13:13 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34855 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751797AbeBDWNK (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 4 Feb 2018 17:13:10 -0500
Received: by mail-wm0-f65.google.com with SMTP id r78so22368735wme.0
        for <git@vger.kernel.org>; Sun, 04 Feb 2018 14:13:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2aXvetPI3VFxjNWXqqf8mcw1zz0TgbawfCCf2L0vATQ=;
        b=uHbZWw1sbnfg50ogSEqPx1uXY7NPWz7G6c5gR66FYlNo5h67W6mmwGn2PBf73DZ36Q
         Dce9CJ+7qxvTDg7tV/cVftwPJSt/HZr5XVYQWHsLidogFB1y/RXA/KjHxVtpZfEtr6Eq
         tO9erS05rB07Cxjh6toB4Q8CqaQRk745D7T4gxwJCQILZBciAUa0CK8hfUt3oECcNqnc
         UYLNNkkt1aOo+j7l6l1CDm0gzkABvAEosBJet1GaO4bnTGuJpM1rHMBKMdg7I81V5vw2
         BCW1KpHYRvXrxkxu2GeGptAlPZ4CYhvE+wyuSHNwMthfkeRJktmTpQk/koYXxbAvshcT
         8qIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2aXvetPI3VFxjNWXqqf8mcw1zz0TgbawfCCf2L0vATQ=;
        b=mHKBOiq/2niwLs2lGhldO929xhr0sC6jc21yTmeUxSnSIJmst61SMhVrwc4Kamvh/O
         fZpdnMON85rib1vzMx9wu1pDSao5lNIKeG88eH5CMmLF72UdKDx34m3EuF5vTVTZlIHP
         jo0teIf8k1tjUc3jxyP+KI2kWeM1G60jpg1Njk1voEdRANtqaKNcwaibR/JScjIJhja0
         7YhDCLYX+lBlKCANcucvL8q0mywoUnDk+Pv/XwJlZKSmOElea8fsesn8GICz/6iZN1fh
         dtPxg47AXxW+R5IwWsKtbKZFTLrrp0qruuTlRChHfeencLKj5ABY0qCj+RRfuUJMIcyg
         AmXw==
X-Gm-Message-State: AKwxytfof75j4wM8DQlErsROdyAM3qpZr+TbQOHNd1u8cWXghGRhdYnn
        DQxMvGsLUo2DDgUd5I4MGTl9D+RF
X-Google-Smtp-Source: AH8x224FeMe8YQ0F35a0hn6PRmj9dvU+gNpU+VF2scADjzVRcHaWUHPteJiIodScoiVcFHGOryYwdg==
X-Received: by 10.28.177.7 with SMTP id a7mr8003675wmf.143.1517782388462;
        Sun, 04 Feb 2018 14:13:08 -0800 (PST)
Received: from localhost (cpc73832-dals21-2-0-cust969.20-2.cable.virginm.net. [81.110.231.202])
        by smtp.gmail.com with ESMTPSA id x18sm6036001wrg.82.2018.02.04.14.13.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 04 Feb 2018 14:13:07 -0800 (PST)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v2 1/3] worktree: improve message when creating a new worktree
Date:   Sun,  4 Feb 2018 22:13:03 +0000
Message-Id: <20180204221305.28300-2-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.16.1.101.gde0f0111ea
In-Reply-To: <20180204221305.28300-1-t.gummerer@gmail.com>
References: <20180121120208.12760-1-t.gummerer@gmail.com>
 <20180204221305.28300-1-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently 'git worktree add' produces output like the following, when
'--no-checkout' is not given:

    Preparing foo (identifier foo)
    HEAD is now at 26da330922 <title>

where the first line is written to stderr, and the second line coming
from 'git reset --hard' is written to stdout, even though both lines are
supposed to tell the user what has happened.  In addition to someone not
familiar with 'git worktree', this might seem as if the current HEAD was
modified, not the HEAD in the new working tree.

If the '--no-checkout' flag is given, the output of 'git worktree add'
is just:

    Preparing foo (identifier foo)

even though the HEAD is set to a commit, which is just not checked out.

Fix these inconsistencies by making the 'git reset --hard' call quiet,
and printing the message ourselves instead.

Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---

We might want to do something similar for the 'git branch' command in
the 'add()' function, which currently prints some output if a branch
is set up to track a remote.  I couldn't find a good way to convey
that information in the output here, without making it too verbose,
and it's probably not great to loose that output either.

If anyone has any suggestions for that, I'd be glad to hear them :)

 builtin/worktree.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/builtin/worktree.c b/builtin/worktree.c
index 7cef5b120b..d1549e441d 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -303,7 +303,7 @@ static int add_worktree(const char *path, const char *refname,
 	strbuf_addf(&sb, "%s/commondir", sb_repo.buf);
 	write_file(sb.buf, "../..");
 
-	fprintf_ln(stderr, _("Preparing %s (identifier %s)"), path, name);
+	fprintf(stderr, _("Preparing %s (identifier %s)"), path, name);
 
 	argv_array_pushf(&child_env, "%s=%s", GIT_DIR_ENVIRONMENT, sb_git.buf);
 	argv_array_pushf(&child_env, "%s=%s", GIT_WORK_TREE_ENVIRONMENT, path);
@@ -320,10 +320,19 @@ static int add_worktree(const char *path, const char *refname,
 	if (ret)
 		goto done;
 
+	fprintf(stderr, _(", setting HEAD to %s"),
+		find_unique_abbrev(commit->object.oid.hash, DEFAULT_ABBREV));
+
+	strbuf_reset(&sb);
+	pp_commit_easy(CMIT_FMT_ONELINE, commit, &sb);
+	if (sb.len > 0)
+		fprintf(stderr, " %s", sb.buf);
+	fputc('\n', stderr);
+
 	if (opts->checkout) {
 		cp.argv = NULL;
 		argv_array_clear(&cp.args);
-		argv_array_pushl(&cp.args, "reset", "--hard", NULL);
+		argv_array_pushl(&cp.args, "reset", "--hard", "--quiet", NULL);
 		cp.env = child_env.argv;
 		ret = run_command(&cp);
 		if (ret)
-- 
2.16.1.101.gde0f0111ea

