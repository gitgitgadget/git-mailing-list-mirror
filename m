Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4854C47088
	for <git@archiver.kernel.org>; Thu, 27 May 2021 00:11:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A8AC613BE
	for <git@archiver.kernel.org>; Thu, 27 May 2021 00:11:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234699AbhE0AND (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 May 2021 20:13:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235088AbhE0AMb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 May 2021 20:12:31 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7C79C061364
        for <git@vger.kernel.org>; Wed, 26 May 2021 17:10:12 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id h12-20020ac8776c0000b02901f1228fdb1bso1668014qtu.6
        for <git@vger.kernel.org>; Wed, 26 May 2021 17:10:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=9jaoNTk9pxC7NibgJC3A3I0yeBCl7VuxCgMuBBolul0=;
        b=j/J/PonNn9ezcKJZGFF3kloADiv5B0huOeFYhS6wJEso4yb1eJTvRXC2NIteW3Zmkc
         upepo53BGYXNG2PQclCvRu7X7SEcTnABPoR8/EFKiy3Cu7zEMcEDQEGdOmfIlorqe76f
         bEl7+JhXaagPxtN+kW6Fc6jwoGHFG3UveNsuuvaJvq3bwAGpBADFBjxX8BO/IeGku4cV
         /OJzz6aZFqo20xGN5fhVUYWlmPUWgdVdydqZ546X4uxBFu5Yd3fvUrvYzFs0pOM1DqHO
         fP0ROJBOBNVRSC/DQBnj1QTzss6G5OGr3YRdbMpZhyo2+fZMqFI+Eg78gd9kXMp5UG+a
         PnXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=9jaoNTk9pxC7NibgJC3A3I0yeBCl7VuxCgMuBBolul0=;
        b=oPeILXchPMdRTuOpE8miS7WOkonhfWe9axdYYKaQV4q2GiYhTSNByVtfNl8LH//huD
         PsJb51CgA6jWm36I0de65alHwCCPdgrR3rf2JEwnGxkd5FrZ8d0ePjUp9DKFp5lwMwVI
         S5sDTGlq6nTYNoCPbp4AKxP9btXZNrTBSr9L+C2Sfn6LotHAovwUtvwpZqPikUo4mhOi
         RA09Zk6YHdN6eYwYIpp5mUPMcDa8RDlW/38dX/MugbfDCOTF21/nIMjijJM6XTWp6HAB
         5vs3q7hsfzOwZLjh11F5uXoZOTwaG4RPdQ9lsuH6rLasBTeT2//Tii6XhgPQjsDkZweU
         ZGmQ==
X-Gm-Message-State: AOAM5314W35UeGFYUnDAl91fmbwJnwvWXyOsFktSXqUU2HF9JaiHAMx8
        7BYksI1qQ1abmodBLN6Dg7VOZaryXO+6bwBxTBOXygw75V4z8WS5t2axT93yJm4tKImhZAp4R4j
        tk/XnjJUfmQxANdGjWlnGrvgftPPB4UAdlEWQy0tHQsmD+RbCqUhDV87AbmbwRyMQJeTlOmdXng
        ==
X-Google-Smtp-Source: ABdhPJxvtodiNvY/QmpNMJgAno/HcomOwqDO8y8Vj9D1oCrNJZsPcIWLJU5Q4tJ7YjXY/LpQlcwYyzUlcrFbJdKe6Ic=
X-Received: from podkayne.svl.corp.google.com ([2620:15c:2ce:0:c1a4:4d87:8b5a:d12c])
 (user=emilyshaffer job=sendgmr) by 2002:a0c:8e4c:: with SMTP id
 w12mr816661qvb.3.1622074211945; Wed, 26 May 2021 17:10:11 -0700 (PDT)
Date:   Wed, 26 May 2021 17:08:56 -0700
In-Reply-To: <20210527000856.695702-1-emilyshaffer@google.com>
Message-Id: <20210527000856.695702-38-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20210527000856.695702-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.31.1.818.g46aad6cb9e-goog
Subject: [PATCH v9 37/37] docs: link githooks and git-hook manpages
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since users may have an easier time finding 'man githooks' or 'git help
githooks' through tab-completion or muscle memory, reference the 'git
hook' commands. And in the 'git hook' manual, point users back to 'man
githooks' for specifics about the hook events themselves.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
---
 Documentation/git-hook.txt | 12 ++++++++++++
 Documentation/githooks.txt |  7 ++++---
 2 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-hook.txt b/Documentation/git-hook.txt
index 81b8e94994..24e00a6f4a 100644
--- a/Documentation/git-hook.txt
+++ b/Documentation/git-hook.txt
@@ -17,6 +17,13 @@ DESCRIPTION
 You can list and run configured hooks with this command. Later, you will be able
 to add and modify hooks with this command.
 
+In general, when instructions suggest adding a script to
+`.git/hooks/<something>`, you can specify it in the config instead by running
+`git config --add hook.<something>.command <path-to-script>` - this way you can
+share the script between multiple repos. That is, `cp ~/my-script.sh
+~/project/.git/hooks/pre-commit` would become `git config --add
+hook.pre-commit.command ~/my-script.sh`.
+
 This command parses the default configuration files for sections `hook` and
 `hookcmd`. `hook` is used to describe the commands which will be run during a
 particular hook event; commands are run in the order Git encounters them during
@@ -141,6 +148,11 @@ number of CPUs on the current system. Some hooks may be ineligible for
 parallelization: for example, 'commit-msg' intends hooks modify the commit
 message body and cannot be parallelized.
 
+HOOKS
+-----
+For a list of hooks which can be configured and how they work, see
+linkgit:githooks[5].
+
 CONFIGURATION
 -------------
 include::config/hook.txt[]
diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
index 42e66d4e2d..d780cb3b18 100644
--- a/Documentation/githooks.txt
+++ b/Documentation/githooks.txt
@@ -7,15 +7,16 @@ githooks - Hooks used by Git
 
 SYNOPSIS
 --------
+'git hook'
 $GIT_DIR/hooks/* (or \`git config core.hooksPath`/*)
 
 
 DESCRIPTION
 -----------
 
-Hooks are programs you can place in a hooks directory to trigger
-actions at certain points in git's execution. Hooks that don't have
-the executable bit set are ignored.
+Hooks are programs you can specify in your config (see linkgit:git-hook[1]) or
+place in a hooks directory to trigger actions at certain points in git's
+execution. Hooks that don't have the executable bit set are ignored.
 
 By default the hooks directory is `$GIT_DIR/hooks`, but that can be
 changed via the `core.hooksPath` configuration variable (see
-- 
2.31.1.818.g46aad6cb9e-goog

