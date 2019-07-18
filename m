Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.7 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BC67C1F461
	for <e@80x24.org>; Thu, 18 Jul 2019 22:57:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391701AbfGRW5t (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Jul 2019 18:57:49 -0400
Received: from mail-pl1-f202.google.com ([209.85.214.202]:50699 "EHLO
        mail-pl1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391694AbfGRW5t (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Jul 2019 18:57:49 -0400
Received: by mail-pl1-f202.google.com with SMTP id d6so14685592pls.17
        for <git@vger.kernel.org>; Thu, 18 Jul 2019 15:57:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=TwXFnN45bQNJGnf+JFRU3LRku9SErp7XAGlWfvtMdTg=;
        b=LwuVdUaEwUlgVGPwTqIsRqph3mYCBeK4IA9pyD5+qex4xijADT1kxxk4p5u65xrdTv
         oPFwHxhbWYJHnNAQtOaC/8rz9cg54R0OXFC08nns29xlDCLthFI0dwC9VM7+Q1nLIeNh
         ViPYAA2wP6BqtdrKXzEVibxJBcQKKdeuofRapSXTrRNd9W7l9KQlAePzIhxUBDnw/xY/
         lBsJnOf7JGlvfE0ggKhqNGxMmn79qQ4kgFB2qdUOW2ys0P/EM7kPRsEDDpJjbKQsD3T7
         UtKS6o8x3193AM2LcloZySIXD8skNdLl8BoTt2VvZadPkVsy2nU0QeF86ruzsGaLmLhT
         1bsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=TwXFnN45bQNJGnf+JFRU3LRku9SErp7XAGlWfvtMdTg=;
        b=lO8x8DbO9kL8AqQ0SqirdSccleN2Bh1K75h+RS+G4tjy4kkp6F8HhP20y2ow4y4XjF
         bgBHeJqGneZdaSevyoMsPBM0KhG2SnIFURSeys+ugy0cvbBsqtKc7z2WSjYz2PVk4dmc
         tU/ovsd+8WlKQrGhiMrcrdZlRF8p4Z00YdApuN7ZNtFEnNWq64Hzam68S3vbUA4iiWC+
         eulRzlJ0GK1B8UFzC2g1NV8zfTs3+SPrd/3EscKM2nlXaKd9OX1XPYGDY6WdX5vgANQ4
         S3V0c9X6ppHCfNumwBhel9L81VX5/Xusy841dz+C7FgBiRDFjJ/uTOXbQ7glkdZpjSjb
         BkeQ==
X-Gm-Message-State: APjAAAV3F9zVnZx1d/bOVMfSQFoJR/cy3nWQq7jkPEI6vHeD7aTQA32E
        xeK9ee8KhKpJjQ8XqKbvP7uYHJW73HdwePDAr43TbuLy/DLliJc3OTVE0cCqFyDiphUU6UfUpYP
        FR+pnpPd4d4tBa3wFF6iyeeG1EtjqiY0YY7afa2pVojzI73UHFrFfbLvexAC53dw=
X-Google-Smtp-Source: APXvYqy7pcyaFm4U0xnFNzViCpGMh8vNizEGf1CdwYNLUgWz7iKNhG7tGZk1CFAzgkKlym4vecN0+OrKA/PuRA==
X-Received: by 2002:a63:f401:: with SMTP id g1mr51705764pgi.314.1563490668072;
 Thu, 18 Jul 2019 15:57:48 -0700 (PDT)
Date:   Thu, 18 Jul 2019 15:57:38 -0700
In-Reply-To: <cover.1563490164.git.steadmon@google.com>
Message-Id: <36406a85beaf63d356fa9818463f73140acf1ec9.1563490164.git.steadmon@google.com>
Mime-Version: 1.0
References: <xmqqbml6pgfm.fsf@gitster.mtv.corp.google.com> <cover.1563490164.git.steadmon@google.com>
X-Mailer: git-send-email 2.22.0.657.g960e92d24f-goog
Subject: [PATCH v2 2/4] merge: do no-verify like commit
From:   Josh Steadmon <steadmon@google.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, git@grubix.eu, stefanbeller@gmail.com,
        martin.agren@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Michael J Gruber <git@grubix.eu>

f8b863598c ("builtin/merge: honor commit-msg hook for merges", 2017-09-07)
introduced the no-verify flag to merge for bypassing the commit-msg
hook, though in a different way from the implementation in commit.c.

Change the implementation in merge.c to be the same as in commit.c so
that both do the same in the same way. This also changes the output of
"git merge --help" to be more clear that the hook return code is
respected by default.

[js: reworded commit message, and moved documentation changes from patch
 3/4 to this commit.]

Signed-off-by: Michael J Gruber <git@grubix.eu>
Signed-off-by: Josh Steadmon <steadmon@google.com>
---
 Documentation/git-merge.txt     | 2 +-
 Documentation/merge-options.txt | 4 ++++
 builtin/merge.c                 | 6 +++---
 3 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-merge.txt b/Documentation/git-merge.txt
index c01cfa6595..f71ed1d0f9 100644
--- a/Documentation/git-merge.txt
+++ b/Documentation/git-merge.txt
@@ -10,7 +10,7 @@ SYNOPSIS
 --------
 [verse]
 'git merge' [-n] [--stat] [--no-commit] [--squash] [--[no-]edit]
-	[-s <strategy>] [-X <strategy-option>] [-S[<keyid>]]
+	[--no-verify] [-s <strategy>] [-X <strategy-option>] [-S[<keyid>]]
 	[--[no-]allow-unrelated-histories]
 	[--[no-]rerere-autoupdate] [-m <msg>] [-F <file>] [<commit>...]
 'git merge' --abort
diff --git a/Documentation/merge-options.txt b/Documentation/merge-options.txt
index 79a00d2a4a..d6a9f4b96f 100644
--- a/Documentation/merge-options.txt
+++ b/Documentation/merge-options.txt
@@ -105,6 +105,10 @@ option can be used to override --squash.
 +
 With --squash, --commit is not allowed, and will fail.
 
+--no-verify::
+	This option bypasses the pre-merge and commit-msg hooks.
+	See also linkgit:githooks[5].
+
 -s <strategy>::
 --strategy=<strategy>::
 	Use the given merge strategy; can be supplied more than
diff --git a/builtin/merge.c b/builtin/merge.c
index 5cd7752191..5bbef203f3 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -81,7 +81,7 @@ static int show_progress = -1;
 static int default_to_upstream = 1;
 static int signoff;
 static const char *sign_commit;
-static int verify_msg = 1;
+static int no_verify;
 
 static struct strategy all_strategy[] = {
 	{ "recursive",  DEFAULT_TWOHEAD | NO_TRIVIAL },
@@ -287,7 +287,7 @@ static struct option builtin_merge_options[] = {
 	  N_("GPG sign commit"), PARSE_OPT_OPTARG, NULL, (intptr_t) "" },
 	OPT_BOOL(0, "overwrite-ignore", &overwrite_ignore, N_("update ignored files (default)")),
 	OPT_BOOL(0, "signoff", &signoff, N_("add Signed-off-by:")),
-	OPT_BOOL(0, "verify", &verify_msg, N_("verify commit-msg hook")),
+	OPT_BOOL(0, "no-verify", &no_verify, N_("bypass commit-msg hook")),
 	OPT_END()
 };
 
@@ -854,7 +854,7 @@ static void prepare_to_commit(struct commit_list *remoteheads)
 			abort_commit(remoteheads, NULL);
 	}
 
-	if (verify_msg && run_commit_hook(0 < option_edit, get_index_file(),
+	if (!no_verify && run_commit_hook(0 < option_edit, get_index_file(),
 					  "commit-msg",
 					  git_path_merge_msg(the_repository), NULL))
 		abort_commit(remoteheads, NULL);
-- 
2.22.0.657.g960e92d24f-goog

