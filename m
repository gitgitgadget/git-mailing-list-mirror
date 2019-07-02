Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C64331F461
	for <e@80x24.org>; Tue,  2 Jul 2019 09:14:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727125AbfGBJOU (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 Jul 2019 05:14:20 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:42695 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725868AbfGBJOS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Jul 2019 05:14:18 -0400
Received: by mail-pl1-f194.google.com with SMTP id ay6so42987plb.9
        for <git@vger.kernel.org>; Tue, 02 Jul 2019 02:14:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Rb1nWn+A40/Zry7ruwBK+f18yIUJSKYTzlWcCA6FuC4=;
        b=cJs8HOOg2j2w1mD6ifiMh8B9RlnJhGuEmIihLcNOScsbCvCSQkwtG8KaQ/yyAsAVYK
         kdQcf1XMCmZsj2j/GQZuNxHml75KFOy2PwodUC497Z4Qh2bBYEO+WRfhDaNxFwYRO+dv
         xg6iZ83gvgFDSD1eAxSFhDPrGc+/lXEEzj+9Xhos8w1qDGVQU3IHQTxm2a/tpNr6eIBo
         6aTG6NyFbgr8qmFLFYXEYda4JB42VTYqykYu2Epv66IfIZaYDNGSo/3MEBzUdkDYKV81
         Saoc3F4++rXrINuuafP8kceWxLzSPUg8hn9z8dDv+o1KXqHw81TQhhUSXrR05iv3DMhd
         yckA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Rb1nWn+A40/Zry7ruwBK+f18yIUJSKYTzlWcCA6FuC4=;
        b=F89qtzXOs0BTVgqKd4n9CHwg2JF6MUld1QIDdsDo26AiCCSPE8HRkUuO0vfM5gzDWd
         KbS99fWw9iyZiaCaAAP7wT25RUYk92NvYcQIAIAFfBeqn/G8Ijw7h6yN7tqnpEuyxBzj
         VG+Enn7fLGyynH+vVuvp9VyAqXnwEppiM8R5zZ7LLpvoNc6qD4TOaoP74iRvaObUwTl0
         ATmYuuPAG0cPV5SU6pz0azHhRE5DT9HBbryXXB+EB9TVyLMckN9lQqQ6vPYShXoC35FZ
         yIgwYSoJh56fM5uNlA2RaC7WRcFFye17Y/Jt14ce9TnnJ/xe0jrID/PJNXCnoN4WyegM
         wgJA==
X-Gm-Message-State: APjAAAW9DCVpb+jUaMWa3l5vT7advrSFGN4Pdqhf9Kz5SowrqmJlyKu8
        qQWbch2a5rMZltR6b3TneVo=
X-Google-Smtp-Source: APXvYqw1SjeZprd9AmcUQSOMdMdsNsTQ3Wdssc3Md4rbzmQci1/Zyp8ovvO+urHX6I9JDM1aseu+yw==
X-Received: by 2002:a17:902:20b:: with SMTP id 11mr34549300plc.78.1562058857568;
        Tue, 02 Jul 2019 02:14:17 -0700 (PDT)
Received: from ar135.iitr.local ([103.37.200.218])
        by smtp.gmail.com with ESMTPSA id q198sm20499178pfq.155.2019.07.02.02.14.13
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 02 Jul 2019 02:14:16 -0700 (PDT)
From:   Rohit Ashiwal <rohit.ashiwal265@gmail.com>
To:     rohit.ashiwal265@gmail.com
Cc:     git@vger.kernel.org, newren@gmail.com, t.gummerer@gmail.com,
        phillip.wood123@gmail.com, martin.agren@gmail.com,
        jrnieder@gmail.com
Subject: [GSoC][PATCH v8 1/5] sequencer: add advice for revert
Date:   Tue,  2 Jul 2019 14:41:25 +0530
Message-Id: <20190702091129.7531-2-rohit.ashiwal265@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190702091129.7531-1-rohit.ashiwal265@gmail.com>
References: <20190608191958.4593-1-rohit.ashiwal265@gmail.com>
 <20190702091129.7531-1-rohit.ashiwal265@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In the case of merge conflicts, while performing a revert, we are
currently advised to use `git cherry-pick --<sequencer-options>`.
Introduce a separate advice message for `git revert`. Also change
the signature of `create_seq_dir` to handle which advice to display
selectively.

Signed-off-by: Rohit Ashiwal <rohit.ashiwal265@gmail.com>
---
 Documentation/config/advice.txt |  2 ++
 advice.c                        |  2 ++
 advice.h                        |  1 +
 sequencer.c                     | 35 +++++++++++++++++++++++++++------
 4 files changed, 34 insertions(+), 6 deletions(-)

diff --git a/Documentation/config/advice.txt b/Documentation/config/advice.txt
index ec4f6ae658..1cd9096c98 100644
--- a/Documentation/config/advice.txt
+++ b/Documentation/config/advice.txt
@@ -57,6 +57,8 @@ advice.*::
 	resolveConflict::
 		Advice shown by various commands when conflicts
 		prevent the operation from being performed.
+	sequencerInUse::
+		Advice shown when a sequencer command is already in progress.
 	implicitIdentity::
 		Advice on how to set your identity configuration when
 		your information is guessed from the system username and
diff --git a/advice.c b/advice.c
index ce5f374ecd..b101f0c264 100644
--- a/advice.c
+++ b/advice.c
@@ -15,6 +15,7 @@ int advice_status_u_option = 1;
 int advice_commit_before_merge = 1;
 int advice_reset_quiet_warning = 1;
 int advice_resolve_conflict = 1;
+int advice_sequencer_in_use = 1;
 int advice_implicit_identity = 1;
 int advice_detached_head = 1;
 int advice_set_upstream_failure = 1;
@@ -71,6 +72,7 @@ static struct {
 	{ "commitBeforeMerge", &advice_commit_before_merge },
 	{ "resetQuiet", &advice_reset_quiet_warning },
 	{ "resolveConflict", &advice_resolve_conflict },
+	{ "sequencerInUse", &advice_sequencer_in_use },
 	{ "implicitIdentity", &advice_implicit_identity },
 	{ "detachedHead", &advice_detached_head },
 	{ "setupStreamFailure", &advice_set_upstream_failure },
diff --git a/advice.h b/advice.h
index e50f02cdfe..ebc838d7bc 100644
--- a/advice.h
+++ b/advice.h
@@ -15,6 +15,7 @@ extern int advice_status_u_option;
 extern int advice_commit_before_merge;
 extern int advice_reset_quiet_warning;
 extern int advice_resolve_conflict;
+extern int advice_sequencer_in_use;
 extern int advice_implicit_identity;
 extern int advice_detached_head;
 extern int advice_set_upstream_failure;
diff --git a/sequencer.c b/sequencer.c
index f88a97fb10..0ef2622a69 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -2650,15 +2650,38 @@ static int walk_revs_populate_todo(struct todo_list *todo_list,
 	return 0;
 }
 
-static int create_seq_dir(void)
+static int create_seq_dir(struct repository *r)
 {
-	if (file_exists(git_path_seq_dir())) {
-		error(_("a cherry-pick or revert is already in progress"));
-		advise(_("try \"git cherry-pick (--continue | --quit | --abort)\""));
+	enum replay_action action;
+	const char *in_progress_error = NULL;
+	const char *in_progress_advice = NULL;
+
+	if (!sequencer_get_last_command(r, &action)) {
+		switch (action) {
+		case REPLAY_REVERT:
+			in_progress_error = _("revert is already in progress");
+			in_progress_advice =
+			_("try \"git revert (--continue | --abort | --quit)\"");
+			break;
+		case REPLAY_PICK:
+			in_progress_error = _("cherry-pick is already in progress");
+			in_progress_advice =
+			_("try \"git cherry-pick (--continue | --abort | --quit)\"");
+			break;
+		default:
+			BUG("unexpected action in create_seq_dir");
+		}
+	}
+	if (in_progress_error) {
+		error("%s", in_progress_error);
+		if (advice_sequencer_in_use)
+			advise("%s", in_progress_advice);
 		return -1;
-	} else if (mkdir(git_path_seq_dir(), 0777) < 0)
+	}
+	if (mkdir(git_path_seq_dir(), 0777) < 0)
 		return error_errno(_("could not create sequencer directory '%s'"),
 				   git_path_seq_dir());
+
 	return 0;
 }
 
@@ -4237,7 +4260,7 @@ int sequencer_pick_revisions(struct repository *r,
 	 */
 
 	if (walk_revs_populate_todo(&todo_list, opts) ||
-			create_seq_dir() < 0)
+			create_seq_dir(r) < 0)
 		return -1;
 	if (get_oid("HEAD", &oid) && (opts->action == REPLAY_REVERT))
 		return error(_("can't revert as initial commit"));
-- 
2.21.0

