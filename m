Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7D34C433EF
	for <git@archiver.kernel.org>; Tue, 19 Jul 2022 18:34:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240148AbiGSSeI (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Jul 2022 14:34:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238688AbiGSSeC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jul 2022 14:34:02 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 989DD5D0EA
        for <git@vger.kernel.org>; Tue, 19 Jul 2022 11:33:56 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id a5so22855940wrx.12
        for <git@vger.kernel.org>; Tue, 19 Jul 2022 11:33:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=d63QqvRU2VpxTaCaClZN5NrhUCrW+qPKp3gtb7pegQ0=;
        b=CiVQ8iokxoc6vH9Fz48eWXcHUddqJELEhU/dQM0nZL4lClGQvuLjha71+/FMh2JL2m
         1H5hYRQCdidacHIlZhxtk/0lIBhDoSZzJAeEHtN5Ge1lfgkWuaum5e6YOQmnx4YXUOP9
         4rE5qDEeuTPtTtNJq0XHCGc5KFnp9QRTr3vVH5ColkGcgDRF7dC9kMSQzlCRwj2qHfMf
         KNB6+qUgCy2mtnJwlHQ02QLDCSGIsfqX6jW06bXeTqtiXKBIZpR9Fcx2XqJgpI9nShBG
         zN0Mj6Nl4ZvTBVxqcDWL6BlYVQ6sLD4CjpW6s4EyIVtLtzf37wuyHdgt367oPcy8GnGu
         5FhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=d63QqvRU2VpxTaCaClZN5NrhUCrW+qPKp3gtb7pegQ0=;
        b=cMiQ83Fjs38sZwzT+GW2O5fOucAkYqmtWtJ09Hm2M9YSepDceaBg55Objhb1AR1ge3
         PULXxIvJgWh0LfnWDciWL56ZZ1lY2eOcyuAKRjijlIAIZyNjDjUaa26b2MLNomQSTeV/
         JiFApV9J2QFecNtA3MTiY5FsMeq+UpFQEcVuTcO0WQxA0kbvsNxhM9Xr2e/2XZTHIWES
         5JXHehGJUy/uvJKFqrSBA98Nmh4qGdsjlPyOSGyJsaxxWiQY2w+k8KjJByYKEdxDdHLl
         HGLpaNQ4jAUtYjbTPI9modl0YUb0UGQtjvjODH50NHUzcjH/KG6etznpqksYF+wSL1Qc
         j9yw==
X-Gm-Message-State: AJIora+k7W6qTnW0tgE+suUUfTmED2SOHgTq6/oVge6KomemNxy8FaRh
        gaGKMuAWZmD8s+5NRDSAiaNl09qZ6gI=
X-Google-Smtp-Source: AGRyM1v28zNvySTVaOtosVWiyaU5Siv0n2603PMf/8K55q7ird6b1qG0KXzT4fVwtDpBzrh0hQorWA==
X-Received: by 2002:a05:6000:18a1:b0:21d:b2d0:ad47 with SMTP id b1-20020a05600018a100b0021db2d0ad47mr29138587wri.271.1658255634807;
        Tue, 19 Jul 2022 11:33:54 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v6-20020a5d6106000000b0021d9233e7e6sm16637427wrt.54.2022.07.19.11.33.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jul 2022 11:33:54 -0700 (PDT)
Message-Id: <7b3d660196062d169627024e838be1ae6b905bd2.1658255624.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1247.v5.git.1658255624.gitgitgadget@gmail.com>
References: <pull.1247.v4.git.1657631225.gitgitgadget@gmail.com>
        <pull.1247.v5.git.1658255624.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 19 Jul 2022 18:33:38 +0000
Subject: [PATCH v5 06/12] sequencer: add update-ref command
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, johannes.schindelin@gmx.de, me@ttaylorr.com,
        Jeff Hostetler <git@jeffhostetler.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        SZEDER =?UTF-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

Add the boilerplate for an "update-ref" command in the sequencer. This
connects to the current no-op do_update_ref() which will be filled in
after more connections are created.

The syntax in the todo list will be "update-ref <ref-name>" to signal
that we should store the current commit as the value for updating
<ref-name> at the end of the rebase.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 rebase-interactive.c |  3 +++
 sequencer.c          | 14 +++++++++++++-
 sequencer.h          |  1 +
 3 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/rebase-interactive.c b/rebase-interactive.c
index 22394224faa..1ff07647af3 100644
--- a/rebase-interactive.c
+++ b/rebase-interactive.c
@@ -57,6 +57,9 @@ void append_todo_help(int command_count,
 "        create a merge commit using the original merge commit's\n"
 "        message (or the oneline, if no original merge commit was\n"
 "        specified); use -c <commit> to reword the commit message\n"
+"u, update-ref <ref> = track a placeholder for the <ref> to be updated\n"
+"                      to this position in the new commits. The <ref> is\n"
+"                      updated at the end of the rebase\n"
 "\n"
 "These lines can be re-ordered; they are executed from top to bottom.\n");
 	unsigned edit_todo = !(shortrevisions && shortonto);
diff --git a/sequencer.c b/sequencer.c
index 2711182e43f..0dc9c05c5bb 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1719,6 +1719,7 @@ static struct {
 	[TODO_LABEL] = { 'l', "label" },
 	[TODO_RESET] = { 't', "reset" },
 	[TODO_MERGE] = { 'm', "merge" },
+	[TODO_UPDATE_REF] = { 'u', "update-ref" },
 	[TODO_NOOP] = { 0,   "noop" },
 	[TODO_DROP] = { 'd', "drop" },
 	[TODO_COMMENT] = { 0,   NULL },
@@ -2480,7 +2481,7 @@ static int parse_insn_line(struct repository *r, struct todo_item *item,
 			     command_to_string(item->command));
 
 	if (item->command == TODO_EXEC || item->command == TODO_LABEL ||
-	    item->command == TODO_RESET) {
+	    item->command == TODO_RESET || item->command == TODO_UPDATE_REF) {
 		item->commit = NULL;
 		item->arg_offset = bol - buf;
 		item->arg_len = (int)(eol - bol);
@@ -4079,6 +4080,11 @@ leave_merge:
 	return ret;
 }
 
+static int do_update_ref(struct repository *r, const char *ref_name)
+{
+	return 0;
+}
+
 static int is_final_fixup(struct todo_list *todo_list)
 {
 	int i = todo_list->current;
@@ -4454,6 +4460,12 @@ static int pick_commits(struct repository *r,
 				return error_with_patch(r, item->commit,
 							arg, item->arg_len,
 							opts, res, 0);
+		} else if (item->command == TODO_UPDATE_REF) {
+			struct strbuf ref = STRBUF_INIT;
+			strbuf_add(&ref, arg, item->arg_len);
+			if ((res = do_update_ref(r, ref.buf)))
+				reschedule = 1;
+			strbuf_release(&ref);
 		} else if (!is_noop(item->command))
 			return error(_("unknown command %d"), item->command);
 
diff --git a/sequencer.h b/sequencer.h
index 3ae541bb145..2cf5c1b9a38 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -95,6 +95,7 @@ enum todo_command {
 	TODO_LABEL,
 	TODO_RESET,
 	TODO_MERGE,
+	TODO_UPDATE_REF,
 	/* commands that do nothing but are counted for reporting progress */
 	TODO_NOOP,
 	TODO_DROP,
-- 
gitgitgadget

