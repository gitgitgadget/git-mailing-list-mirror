Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1441C4332F
	for <git@archiver.kernel.org>; Sat, 17 Dec 2022 23:10:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230039AbiLQXKF (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 17 Dec 2022 18:10:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiLQXKE (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Dec 2022 18:10:04 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F402F5FA7
        for <git@vger.kernel.org>; Sat, 17 Dec 2022 15:10:02 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id p13-20020a05600c468d00b003cf8859ed1bso4095725wmo.1
        for <git@vger.kernel.org>; Sat, 17 Dec 2022 15:10:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WDWjjv2i9dxkH1aM0awrZBbFUb3swnvJKWAy6QNp1y8=;
        b=ZstcDNTDQJPyI5pj7np6gUKJwoOjM+bs0BcdBbXoXODB3BoH3BqmkwlHy4ViChLXme
         Lcb8+uZelsykZz7UxpddPkj7d8D8Whw/H5Ii7PyBvrzpD9Pz2AmnOOMUFbpk21+KQy3l
         JrBb2+ZHeRz5vwLmFd707Xg2+D5hJkr012xXwm2sKa0bHed5930LwQCoxs6C6XI+2RuZ
         ONiRe9nGR5gN/ldiPVJ4LiFp/yQxgLyX+8qKrRXwrxLfOiqrCFJvEj9pMEnrAx0MDSzU
         p39KIomDtp6kX+N0fTgXx4V4ikzlW9bqTVGZvc8/2XVjeXE4uDCx1EUSNdgylnyZ2Pyt
         JnmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WDWjjv2i9dxkH1aM0awrZBbFUb3swnvJKWAy6QNp1y8=;
        b=mE+dXDjCnsGY3qOnAAXFQQvFsunOPmiAI9dI4bCSggd2s9b+int1xi6xgmRiDxTS6Q
         3lQ8RETSJaBITki5RJJ3FzKJAv5avGWjLhf2vXaNEe/yzHFDDmRfpst9AOnO+a7jey3c
         o6q9xQ23SnQL0irfGcMttguqK3clEwNxFOSgUeqMO7rrYex2gAFIouH3YsSPeL1zQA8J
         GCEL/rLvl++NJw46TJ6E5HTWW2m4GPOCWa2pMUQHsv+7YZKyKZXwZi6q1G42O3oJM0De
         aznckN3omK4oE05ve7d1VRHPvwZTnI6ejTlvBiXhjG2Zxe6h0/kpLWvCog0t7LJ476BK
         wANA==
X-Gm-Message-State: ANoB5pmbwXKZuytbYYPMHi2ycB5Uv5Ybrj2gVytAND7DHIo3C8hJBMj2
        KsuujY5rjey8Ewg4R7f2+yDSiTNOwFQ=
X-Google-Smtp-Source: AA0mqf6eiDl+Zdmcvfw7xNOw+Mhk4Uuhwg+Q4jx7ASqfxH8xEjTGb98sCYdz3OMscTuL3gOmuWCoeg==
X-Received: by 2002:a05:600c:1c90:b0:3d2:274d:be7c with SMTP id k16-20020a05600c1c9000b003d2274dbe7cmr18419436wms.19.1671318601105;
        Sat, 17 Dec 2022 15:10:01 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d22-20020a05600c34d600b003a6125562e1sm7191271wmq.46.2022.12.17.15.10.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Dec 2022 15:10:00 -0800 (PST)
Message-Id: <pull.1424.v2.git.1671318599482.gitgitgadget@gmail.com>
In-Reply-To: <pull.1424.git.1668972017089.gitgitgadget@gmail.com>
References: <pull.1424.git.1668972017089.gitgitgadget@gmail.com>
From:   "Sean Allred via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 17 Dec 2022 23:09:59 +0000
Subject: [PATCH v2] var: add GIT_SEQUENCE_EDITOR variable
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Sean Allred <allred.sean@gmail.com>,
        Sean Allred <code@seanallred.com>,
        Sean Allred <allred.sean@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Sean Allred <allred.sean@gmail.com>

The editor program used by Git when editing the sequencer "todo" file
is determined by examining a few environment variables and also
affected by configuration variables. Introduce "git var
GIT_SEQUENCE_EDITOR" to give users access to the final result of the
logic without having to know the exact details.

This is very similar in spirit to 44fcb497 (Teach git var about
GIT_EDITOR, 2009-11-11) that introduced "git var GIT_EDITOR".

Signed-off-by: Sean Allred <allred.sean@gmail.com>
---
    var: add GIT_SEQUENCE_EDITOR variable
    
    In my case, I'm overriding the sequence editor in git rebase -i to do
    some pre-processing on the todo file, but I'd still like to open up the
    editor for further manipulation/verification of the todo steps. Just
    using GIT_EDITOR here will clobber folks' expectations that their
    custom-built sequence editor pops up (e.g. VSCode or Git Cola).
    
    Changes since v1:
    
     * rebased on current main
     * following new, simplified patterns from my previous pull-request
       merged in d8184580

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1424%2Fvermiculus%2Fsa%2Fgit-var-sequence-editor-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1424/vermiculus/sa/git-var-sequence-editor-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1424

Range-diff vs v1:

 1:  aa5ac73ab39 ! 1:  c9683fabf3d var: add GIT_SEQUENCE_EDITOR variable
     @@ Metadata
       ## Commit message ##
          var: add GIT_SEQUENCE_EDITOR variable
      
     -    Provides the same benefits to scripts as exposing GIT_EDITOR, but
     -    allows distinguishing the 'sequence' editor from the 'core' editor.
     +    The editor program used by Git when editing the sequencer "todo" file
     +    is determined by examining a few environment variables and also
     +    affected by configuration variables. Introduce "git var
     +    GIT_SEQUENCE_EDITOR" to give users access to the final result of the
     +    logic without having to know the exact details.
      
     -    See also 44fcb4977cbae67f4698306ccfe982420ceebcbf.
     +    This is very similar in spirit to 44fcb497 (Teach git var about
     +    GIT_EDITOR, 2009-11-11) that introduced "git var GIT_EDITOR".
      
          Signed-off-by: Sean Allred <allred.sean@gmail.com>
      
     @@ Documentation/git-var.txt: ifdef::git-default-editor[]
       endif::git-default-editor[]
       
      +GIT_SEQUENCE_EDITOR::
     -+    Text editor for use by Git sequencer commands. Like `GIT_EDITOR`,
     -+    the value is meant to be interpreted by the shell when it is used.
     -+    The order of preference is the `$GIT_SEQUENCE_EDITOR` environment
     -+    variable, then `sequence.editor` configuration, and then the value
     -+    of `git var GIT_EDITOR`.
     ++    Text editor used to edit the 'todo' file while running `git rebase
     ++    -i`. Like `GIT_EDITOR`, the value is meant to be interpreted by
     ++    the shell when it is used. The order of preference is the
     ++    `$GIT_SEQUENCE_EDITOR` environment variable, then
     ++    `sequence.editor` configuration, and then the value of `git var
     ++    GIT_EDITOR`.
      +
       GIT_PAGER::
           Text viewer for use by Git commands (e.g., 'less').  The value
     @@ Documentation/git-var.txt: ifdef::git-default-editor[]
      
       ## builtin/var.c ##
      @@ builtin/var.c: static const char *editor(int flag)
     - 	return pgm;
     + 	return git_editor();
       }
       
      +static const char *sequence_editor(int flag)
      +{
     -+	const char *pgm = git_sequence_editor();
     -+
     -+	if (!pgm && flag & IDENT_STRICT)
     -+		die("Terminal is dumb, but EDITOR unset");
     -+
     -+	return pgm;
     ++	return git_sequence_editor();
      +}
      +
       static const char *pager(int flag)
     @@ builtin/var.c: static struct git_var git_vars[] = {
       	{ "", NULL },
      
       ## t/t0007-git-var.sh ##
     -@@ t/t0007-git-var.sh: test_expect_success 'get GIT_DEFAULT_BRANCH with configuration' '
     +@@ t/t0007-git-var.sh: test_expect_success 'get GIT_EDITOR with configuration and environment variable
       	)
       '
       


 Documentation/git-var.txt |  8 ++++++++
 builtin/var.c             |  6 ++++++
 t/t0007-git-var.sh        | 38 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 52 insertions(+)

diff --git a/Documentation/git-var.txt b/Documentation/git-var.txt
index 0ab5bfa7d72..f40202b8e3a 100644
--- a/Documentation/git-var.txt
+++ b/Documentation/git-var.txt
@@ -50,6 +50,14 @@ ifdef::git-default-editor[]
     The build you are using chose '{git-default-editor}' as the default.
 endif::git-default-editor[]
 
+GIT_SEQUENCE_EDITOR::
+    Text editor used to edit the 'todo' file while running `git rebase
+    -i`. Like `GIT_EDITOR`, the value is meant to be interpreted by
+    the shell when it is used. The order of preference is the
+    `$GIT_SEQUENCE_EDITOR` environment variable, then
+    `sequence.editor` configuration, and then the value of `git var
+    GIT_EDITOR`.
+
 GIT_PAGER::
     Text viewer for use by Git commands (e.g., 'less').  The value
     is meant to be interpreted by the shell.  The order of preference
diff --git a/builtin/var.c b/builtin/var.c
index a1a2522126f..a80c1df86fd 100644
--- a/builtin/var.c
+++ b/builtin/var.c
@@ -14,6 +14,11 @@ static const char *editor(int flag)
 	return git_editor();
 }
 
+static const char *sequence_editor(int flag)
+{
+	return git_sequence_editor();
+}
+
 static const char *pager(int flag)
 {
 	const char *pgm = git_pager(1);
@@ -36,6 +41,7 @@ static struct git_var git_vars[] = {
 	{ "GIT_COMMITTER_IDENT", git_committer_info },
 	{ "GIT_AUTHOR_IDENT",   git_author_info },
 	{ "GIT_EDITOR", editor },
+	{ "GIT_SEQUENCE_EDITOR", sequence_editor },
 	{ "GIT_PAGER", pager },
 	{ "GIT_DEFAULT_BRANCH", default_branch },
 	{ "", NULL },
diff --git a/t/t0007-git-var.sh b/t/t0007-git-var.sh
index 433d242897c..eeb8539c1bc 100755
--- a/t/t0007-git-var.sh
+++ b/t/t0007-git-var.sh
@@ -109,6 +109,44 @@ test_expect_success 'get GIT_EDITOR with configuration and environment variable
 	)
 '
 
+test_expect_success 'get GIT_SEQUENCE_EDITOR without configuration' '
+	(
+		sane_unset GIT_SEQUENCE_EDITOR &&
+		git var GIT_EDITOR >expect &&
+		git var GIT_SEQUENCE_EDITOR >actual &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_success 'get GIT_SEQUENCE_EDITOR with configuration' '
+	test_config sequence.editor foo &&
+	(
+		sane_unset GIT_SEQUENCE_EDITOR &&
+		echo foo >expect &&
+		git var GIT_SEQUENCE_EDITOR >actual &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_success 'get GIT_SEQUENCE_EDITOR with environment variable' '
+	(
+		sane_unset GIT_SEQUENCE_EDITOR &&
+		echo bar >expect &&
+		GIT_SEQUENCE_EDITOR=bar git var GIT_SEQUENCE_EDITOR >actual &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_success 'get GIT_SEQUENCE_EDITOR with configuration and environment variable' '
+	test_config sequence.editor foo &&
+	(
+		sane_unset GIT_SEQUENCE_EDITOR &&
+		echo bar >expect &&
+		GIT_SEQUENCE_EDITOR=bar git var GIT_SEQUENCE_EDITOR >actual &&
+		test_cmp expect actual
+	)
+'
+
 # For git var -l, we check only a representative variable;
 # testing the whole output would make our test too brittle with
 # respect to unrelated changes in the test suite's environment.

base-commit: 57e2c6ebbe7108b35ba30184dcbcb6c34c929ad8
-- 
gitgitgadget
