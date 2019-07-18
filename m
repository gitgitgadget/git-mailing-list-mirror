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
	by dcvr.yhbt.net (Postfix) with ESMTP id 3A7D71F461
	for <e@80x24.org>; Thu, 18 Jul 2019 22:57:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391708AbfGRW5w (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Jul 2019 18:57:52 -0400
Received: from mail-vk1-f202.google.com ([209.85.221.202]:43488 "EHLO
        mail-vk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391694AbfGRW5v (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Jul 2019 18:57:51 -0400
Received: by mail-vk1-f202.google.com with SMTP id j140so13144681vke.10
        for <git@vger.kernel.org>; Thu, 18 Jul 2019 15:57:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=4cU0LLDVKLhVe4AeBhhuQQwQ7kiukvWT8gMlsJwTZcY=;
        b=HDskbwvByb6O3sV3WNYvQ50c8xgJuhZcBOAeBNC/H50j9a4ifptZZU/3U5355NRS9V
         5JAKCa8Ls/XJfK40M9tTLBr8hP/9p/asuAPvsKL6shr/xY4jbLj2ukyDFmLSMIHy//IQ
         dxBWwmK/tgbjdirYtMWuWGLgs7oyUd1DwI30swUZc07QVXdQncpNGESlQAsohlyqLEN3
         EGVwhEOm7W5mHdWdiAXuHsiNJWRbAipev3drwFPaqyUFs0cFdts7spbRvdEcZGo/qGu6
         pe/dqy8GlVI5mB95wRw+/ndB0ntF7G0oZnJTVe7hLsEXfnvbDyqXn4FjDJ23MaEq1fBo
         tXgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=4cU0LLDVKLhVe4AeBhhuQQwQ7kiukvWT8gMlsJwTZcY=;
        b=CsX/06Grn2l4cK9D2RI+TExYmalY+d+qX5Kc9MahnUxON6Ev5IfBZvA6JOJdbjE/1B
         yuxMsqHFgI8BlYe7TFBn9bhHS/3ChRxXFPdASEdkgDmd4x7WkW0kuD5wHMhwq25WI/CV
         ddnT/V+KPHVAy+mVXBcwbft4bctJ6qHafK/2LEMT6N2xZAwnjRUA0IgKiOh6rfnBgzXE
         6t+pC848AZOTLC7+QTr5BA2Xr2KkOg9gWzhiVlsW9DFS5QpFaUj9AASnDhoDiUPHOKvU
         jFwNjLgUS81quj3ZfET6SMlRSyeT1gneuiptcpzCfYMQzj44BhM5jpJnj6HXI3FfAaJU
         csGQ==
X-Gm-Message-State: APjAAAX56EDDVsYQfNEz2qbZst21+sBUt48zRlgybLvPy6e/T4R1ionH
        VoHFPaa8a4rJGveGPkR889MjpwJnH5AbfhzhjVETdrBmB4Z+AhZPQEsDa+HG1N8+DhUjYAhLkEG
        lOrPn27wtS+F0YbYElRm/X5pasBT79ngTFhS47k2eAcnj+X6A3eVSC/zvIqrPp/E=
X-Google-Smtp-Source: APXvYqylgCDtyqwtM73MejpCmlP0NAG2c0BLwYNrPgeOecTLbB4gzQt7yilT5HO28mZ1mlNQE92D8N1ToAaAyQ==
X-Received: by 2002:ac5:c907:: with SMTP id t7mr19537936vkl.30.1563490670481;
 Thu, 18 Jul 2019 15:57:50 -0700 (PDT)
Date:   Thu, 18 Jul 2019 15:57:39 -0700
In-Reply-To: <cover.1563490164.git.steadmon@google.com>
Message-Id: <2440ad35e420db868596435dea3d634e37dbe671.1563490164.git.steadmon@google.com>
Mime-Version: 1.0
References: <xmqqbml6pgfm.fsf@gitster.mtv.corp.google.com> <cover.1563490164.git.steadmon@google.com>
X-Mailer: git-send-email 2.22.0.657.g960e92d24f-goog
Subject: [PATCH v2 3/4] merge: --no-verify to bypass pre-merge hook
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

Analogous to commit, introduce a '--no-verify' option which bypasses the
pre-merge hook. The shorthand '-n' is taken by the (non-existing)
'--no-stat' already.

[js: cleaned up trailing whitespace, moved some documentation changes
 from this commit to 2/4.]

Signed-off-by: Michael J Gruber <git@grubix.eu>
Signed-off-by: Josh Steadmon <steadmon@google.com>
---
 Documentation/githooks.txt | 2 +-
 builtin/merge.c            | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
index dcc6606d44..6a93478dcf 100644
--- a/Documentation/githooks.txt
+++ b/Documentation/githooks.txt
@@ -108,7 +108,7 @@ pre-merge
 
 This hook is invoked by 'git merge' when doing an automatic merge
 commit; it is equivalent to 'pre-commit' for a non-automatic commit
-for a merge.
+for a merge, and can be bypassed with the `--no-verify` option.
 
 prepare-commit-msg
 ~~~~~~~~~~~~~~~~~~
diff --git a/builtin/merge.c b/builtin/merge.c
index 5bbef203f3..5ed3472c84 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -287,7 +287,7 @@ static struct option builtin_merge_options[] = {
 	  N_("GPG sign commit"), PARSE_OPT_OPTARG, NULL, (intptr_t) "" },
 	OPT_BOOL(0, "overwrite-ignore", &overwrite_ignore, N_("update ignored files (default)")),
 	OPT_BOOL(0, "signoff", &signoff, N_("add Signed-off-by:")),
-	OPT_BOOL(0, "no-verify", &no_verify, N_("bypass commit-msg hook")),
+	OPT_BOOL(0, "no-verify", &no_verify, N_("bypass pre-merge and commit-msg hooks")),
 	OPT_END()
 };
 
@@ -818,7 +818,7 @@ static void prepare_to_commit(struct commit_list *remoteheads)
 	struct strbuf msg = STRBUF_INIT;
 	const char *index_file = get_index_file();
 
-	if (run_commit_hook(0 < option_edit, index_file, "pre-merge", NULL))
+	if (!no_verify && run_commit_hook(0 < option_edit, index_file, "pre-merge", NULL))
 		abort_commit(remoteheads, NULL);
 	/*
 	 * Re-read the index as pre-merge hook could have updated it,
-- 
2.22.0.657.g960e92d24f-goog

