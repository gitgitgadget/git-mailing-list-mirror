Return-Path: <SRS0=6awY=5X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3AAFC2BA1A
	for <git@archiver.kernel.org>; Tue,  7 Apr 2020 16:59:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7801A20771
	for <git@archiver.kernel.org>; Tue,  7 Apr 2020 16:59:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UU8vQ0zG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726494AbgDGQ71 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Apr 2020 12:59:27 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:33733 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726386AbgDGQ71 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Apr 2020 12:59:27 -0400
Received: by mail-ed1-f65.google.com with SMTP id z65so4992074ede.0
        for <git@vger.kernel.org>; Tue, 07 Apr 2020 09:59:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=wjn++9g5UP8jm1ToTBhW+UorXcoDX50VNdSzbwow8ko=;
        b=UU8vQ0zGmwIG8B6WKOC5Qkxccoyqi+8PIzq+nQtzulLGOY+Be+V5EDCMZpmJUT08mZ
         FEvGQUKQZxYr57KFqeEJIO0K6KhOKEaNjtFGrQV/Vko30qdmW4fcVtjq2vngDhz9nyUm
         0srnGhFP/HSGxw1UMbuIhiO0OP4DaxO0rFClf9vYJV919LW21V+BbaXoCil5jQLl7kBQ
         mWJc8JONCvnX3cK66Bc2WAja7C/wawSULjculvLrXwDfPhgKbbCt7dlF33XEFYSypYRy
         O/V3n3I2u71BXK5Iv3kKeDMtFe3dXKof42T8Ll9vWFDqh/DLore9l0YsrapZGw1axG2t
         axuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=wjn++9g5UP8jm1ToTBhW+UorXcoDX50VNdSzbwow8ko=;
        b=UTmF5Aj1ffABzhT6/pdRZpARgjkyssra+bRoJekpikrxEXrl+oL2FrGclch9fylc0F
         QWq3dmuKHRYnZpmDpzOFS5fEGKGexJDNKoxF442Yt7pQQ0A07Y/xGZopyn2ct7zBkOca
         PAPiL4TG27xiSiIxsNRp0Lso3j+PJYdMAFKEhpegQmNMsCHO+FASg8Z4Vu07dGYsGuaR
         SFgn1J65QkHRgXbgGAIlAoJA5RXWTB+2Q8JXdj0Mrb9xfPzlQzapo5fz99H/hAnqc643
         Lx1Ol/0qy0bMvlE+zmwq+IjQAEEqhXksu/GkppLkcc6EDUduZL+nbgSHFuPnCgkbBJR2
         CuaA==
X-Gm-Message-State: AGi0PubGouNpmPBnj+FMu+t4t0njAw9E9IMW3qIGLLsAPSIJw10OaJ3E
        FdhBT+UiLckwmT66fbv+cirAt0/I
X-Google-Smtp-Source: APiQypJOQ9I3JyB6AMgKDUfhV7Dp5yIwDj9M2DgTr0J0lbDHwyH45lN5F8p42bCgtSWihIi0fiPfnw==
X-Received: by 2002:a17:906:c7c3:: with SMTP id dc3mr2541054ejb.128.1586278764594;
        Tue, 07 Apr 2020 09:59:24 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b15sm2720895edn.69.2020.04.07.09.59.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2020 09:59:24 -0700 (PDT)
Message-Id: <pull.746.v2.git.git.1586278763462.gitgitgadget@gmail.com>
In-Reply-To: <pull.746.git.git.1585773096145.gitgitgadget@gmail.com>
References: <pull.746.git.git.1585773096145.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 07 Apr 2020 16:59:23 +0000
Subject: [PATCH v2] sequencer: honor GIT_REFLOG_ACTION
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     jrnieder@gmail.com, elbrus@debian.org,
        ijackson@chiark.greenend.org.uk, phillip.wood@dunelm.org.uk,
        alban.gruin@gmail.com, Johannes.Schindelin@gmx.de,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

There is a lot of code to honor GIT_REFLOG_ACTION throughout git,
including some in sequencer.c; unfortunately, reflog_message() and its
callers ignored it.  Instruct reflog_message() to check the existing
environment variable, and use it when present as an override to
action_name().

Also restructure pick_commits() to only temporarily modify
GIT_REFLOG_ACTION for a short duration and then restore the old value,
so that when we do this setting within a loop we do not keep adding "
(pick)" substrings and end up with a reflog message of the form
    rebase (pick) (pick) (pick) (finish): returning to refs/heads/master

Signed-off-by: Elijah Newren <newren@gmail.com>
---
    sequencer: honor GIT_REFLOG_ACTION
    
    Changes since v1:
    
     * Just use preprocessor constant (instead of mix of it and string
       constant)
     * Add a comment next to code that surprised both Phillip and Dscho

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-746%2Fnewren%2Fhonor-reflog-action-in-sequencer-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-746/newren/honor-reflog-action-in-sequencer-v2
Pull-Request: https://github.com/git/git/pull/746

Range-diff vs v1:

 1:  5c6d74af194 ! 1:  a12cc2d2c3a sequencer: honor GIT_REFLOG_ACTION
     @@ sequencer.c: static const char *reflog_message(struct replay_opts *opts,
       {
       	va_list ap;
       	static struct strbuf buf = STRBUF_INIT;
     -+	char *reflog_action = getenv("GIT_REFLOG_ACTION");
     ++	char *reflog_action = getenv(GIT_REFLOG_ACTION);
       
       	va_start(ap, fmt);
       	strbuf_reset(&buf);
     @@ sequencer.c: static int pick_commits(struct repository *r,
       	int res = 0, reschedule = 0;
      +	char *prev_reflog_action;
       
     ++	/* Note that 0 for 3rd parameter of setenv means set only if not set */
       	setenv(GIT_REFLOG_ACTION, action_name(opts), 0);
      +	prev_reflog_action = xstrdup(getenv(GIT_REFLOG_ACTION));
       	if (opts->allow_ff)


 sequencer.c               | 10 ++++++++--
 t/t3406-rebase-message.sh | 16 ++++++++--------
 2 files changed, 16 insertions(+), 10 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index e528225e787..24a62d5aa5d 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -3708,10 +3708,11 @@ static const char *reflog_message(struct replay_opts *opts,
 {
 	va_list ap;
 	static struct strbuf buf = STRBUF_INIT;
+	char *reflog_action = getenv(GIT_REFLOG_ACTION);
 
 	va_start(ap, fmt);
 	strbuf_reset(&buf);
-	strbuf_addstr(&buf, action_name(opts));
+	strbuf_addstr(&buf, reflog_action ? reflog_action : action_name(opts));
 	if (sub_action)
 		strbuf_addf(&buf, " (%s)", sub_action);
 	if (fmt) {
@@ -3799,8 +3800,11 @@ static int pick_commits(struct repository *r,
 			struct replay_opts *opts)
 {
 	int res = 0, reschedule = 0;
+	char *prev_reflog_action;
 
+	/* Note that 0 for 3rd parameter of setenv means set only if not set */
 	setenv(GIT_REFLOG_ACTION, action_name(opts), 0);
+	prev_reflog_action = xstrdup(getenv(GIT_REFLOG_ACTION));
 	if (opts->allow_ff)
 		assert(!(opts->signoff || opts->no_commit ||
 				opts->record_origin || opts->edit));
@@ -3845,12 +3849,14 @@ static int pick_commits(struct repository *r,
 		}
 		if (item->command <= TODO_SQUASH) {
 			if (is_rebase_i(opts))
-				setenv("GIT_REFLOG_ACTION", reflog_message(opts,
+				setenv(GIT_REFLOG_ACTION, reflog_message(opts,
 					command_to_string(item->command), NULL),
 					1);
 			res = do_pick_commit(r, item->command, item->commit,
 					     opts, is_final_fixup(todo_list),
 					     &check_todo);
+			if (is_rebase_i(opts))
+				setenv(GIT_REFLOG_ACTION, prev_reflog_action, 1);
 			if (is_rebase_i(opts) && res < 0) {
 				/* Reschedule */
 				advise(_(rescheduled_advice),
diff --git a/t/t3406-rebase-message.sh b/t/t3406-rebase-message.sh
index 61b76f33019..927a4f4a4e4 100755
--- a/t/t3406-rebase-message.sh
+++ b/t/t3406-rebase-message.sh
@@ -89,22 +89,22 @@ test_expect_success 'GIT_REFLOG_ACTION' '
 	git checkout -b reflog-topic start &&
 	test_commit reflog-to-rebase &&
 
-	git rebase --apply reflog-onto &&
+	git rebase reflog-onto &&
 	git log -g --format=%gs -3 >actual &&
 	cat >expect <<-\EOF &&
-	rebase finished: returning to refs/heads/reflog-topic
-	rebase: reflog-to-rebase
-	rebase: checkout reflog-onto
+	rebase (finish): returning to refs/heads/reflog-topic
+	rebase (pick): reflog-to-rebase
+	rebase (start): checkout reflog-onto
 	EOF
 	test_cmp expect actual &&
 
 	git checkout -b reflog-prefix reflog-to-rebase &&
-	GIT_REFLOG_ACTION=change-the-reflog git rebase --apply reflog-onto &&
+	GIT_REFLOG_ACTION=change-the-reflog git rebase reflog-onto &&
 	git log -g --format=%gs -3 >actual &&
 	cat >expect <<-\EOF &&
-	rebase finished: returning to refs/heads/reflog-prefix
-	change-the-reflog: reflog-to-rebase
-	change-the-reflog: checkout reflog-onto
+	change-the-reflog (finish): returning to refs/heads/reflog-prefix
+	change-the-reflog (pick): reflog-to-rebase
+	change-the-reflog (start): checkout reflog-onto
 	EOF
 	test_cmp expect actual
 '

base-commit: 274b9cc25322d9ee79aa8e6d4e86f0ffe5ced925
-- 
gitgitgadget
