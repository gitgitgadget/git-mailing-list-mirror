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
	by dcvr.yhbt.net (Postfix) with ESMTP id F3D411F731
	for <e@80x24.org>; Wed,  7 Aug 2019 18:57:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389421AbfHGS5Z (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Aug 2019 14:57:25 -0400
Received: from mail-pl1-f201.google.com ([209.85.214.201]:49618 "EHLO
        mail-pl1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388849AbfHGS5Z (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Aug 2019 14:57:25 -0400
Received: by mail-pl1-f201.google.com with SMTP id 65so53554137plf.16
        for <git@vger.kernel.org>; Wed, 07 Aug 2019 11:57:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=8pWHU0VX2sxqhaQaw0+jKNS+pFgW2uare0LdAauOU/Y=;
        b=tSnRN223xCN8QX5DUe+uD6rWc+47qe5StnGJAwFpLufG4mKGbBXoTiUe4ed698tyrd
         vVy8o2hprTlJWNG2bc4vFb2kC5keM9/JhA0iLMVlBz5GrE87v4XgQS19PYluF1ngk053
         X/YkIb7obOm+SGBOgABMt7nwkFDrOSOm8lHPaZtx/LHiSgii3+clEGPo+i+sMgBjEkjD
         vs4Z3bOjrEyxGJHZQhvhjIDN3XduBv6v2vs6mjsBxDM6/eAd5Hm5+vGIXZl7M1jgiWUl
         6QCxjuNn0M1qQpkMPwvmb+9a3Xn3UxGybzpXfEbuMb3klT2PvW5pH8MLPOdUtw4yYYsH
         tRzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=8pWHU0VX2sxqhaQaw0+jKNS+pFgW2uare0LdAauOU/Y=;
        b=N+5ZvvUuAMas6B22QFNpLLveSOeiZxqroQAi6jZb2Jk9kH7LRSVxPgL1m786v62B70
         qMsbdxycO6n23RIMGFuxIQZ7WY8JCi9koMosrAdtdMcvmYKjtK7W9OWyHf6LHgF4DuC5
         PqkPSL0BYA81nEHJirEVqa2GEaQ2ZSBEkQ9xcsBrczIdQ0FnCrATtGo24A2/3ua1AX19
         pUOQEFpNsVQd+Ov5vNfyBN7xQEJ3QtU26YDYu/AslGKmwN7++quvFGlFDhC1DLB4xC0E
         wupyVYyOGVgVF8qRxXxK9TGHtZSAhItPVOfQJAL75b/zLHdJdx4gNNSZKsgz+dy7ceZN
         BFYQ==
X-Gm-Message-State: APjAAAVVWKg7EvgK2eol7CUzVpFyKR4txmVzV+2ELSQjwYel+9Jskvgx
        PCekUZ/dFLGL4WH2Wmx0laNSvqyggwZKlEwPzjrQKTqgT5qpLCZzZA6OAii62pbE8OAIYbtjZj5
        Py1Cs0Ka5D2jQ8m2fAHYi7j4KzYUqgUQNvWog/FJlwF9yHCLhAjefmVsgpsxkueQ=
X-Google-Smtp-Source: APXvYqxNu9GK6yMK9zYgmBE+RTc3ZN0CvwhhkIycwLrsVloEtBrwWTl0Z2q/2NKvyGpZSegncEl8I+lS++yxAw==
X-Received: by 2002:a63:29c4:: with SMTP id p187mr9157667pgp.330.1565204244671;
 Wed, 07 Aug 2019 11:57:24 -0700 (PDT)
Date:   Wed,  7 Aug 2019 11:57:06 -0700
In-Reply-To: <cover.1565203880.git.steadmon@google.com>
Message-Id: <02a97eb369e7f99c426a4d8fd5efd2c9d1af1e5f.1565203880.git.steadmon@google.com>
Mime-Version: 1.0
References: <cover.1565044345.git.steadmon@google.com> <cover.1565203880.git.steadmon@google.com>
X-Mailer: git-send-email 2.22.0.770.g0f2c4a37fd-goog
Subject: [PATCH v5 2/4] merge: do no-verify like commit
From:   Josh Steadmon <steadmon@google.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, git@grubix.eu, martin.agren@gmail.com
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

[js: * reworded commit message
     * squashed documentation changes from original series' patch 3/4
]

Signed-off-by: Michael J Gruber <git@grubix.eu>
Signed-off-by: Josh Steadmon <steadmon@google.com>
---
 Documentation/git-merge.txt     | 2 +-
 Documentation/merge-options.txt | 4 ++++
 builtin/merge.c                 | 6 +++---
 3 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-merge.txt b/Documentation/git-merge.txt
index 01fd52dc70..092529c619 100644
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
 'git merge' (--continue | --abort | --quit)
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
index e2ccbc44e2..4425a7a12e 100644
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
 
@@ -842,7 +842,7 @@ static void prepare_to_commit(struct commit_list *remoteheads)
 			abort_commit(remoteheads, NULL);
 	}
 
-	if (verify_msg && run_commit_hook(0 < option_edit, get_index_file(),
+	if (!no_verify && run_commit_hook(0 < option_edit, get_index_file(),
 					  "commit-msg",
 					  git_path_merge_msg(the_repository), NULL))
 		abort_commit(remoteheads, NULL);
-- 
2.22.0.770.g0f2c4a37fd-goog

