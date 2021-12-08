Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92CFDC433FE
	for <git@archiver.kernel.org>; Wed,  8 Dec 2021 14:58:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235619AbhLHPBs (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Dec 2021 10:01:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235592AbhLHPBm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Dec 2021 10:01:42 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12B4EC061A32
        for <git@vger.kernel.org>; Wed,  8 Dec 2021 06:58:10 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id p18so1959807wmq.5
        for <git@vger.kernel.org>; Wed, 08 Dec 2021 06:58:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=oAz1BXO35jPyviQ4+93z2pC8F5URTOyYHE54QL5vpXg=;
        b=G4Hdc2Y6Hst/1wmeSZlsjpRJToFcXc5jaJoQe/tKu6xdQlW5CdDzXpsAoxG2jPpe9J
         z8i/y96DKMIXsdzEm6b4tPT5XlmtwiIwr9yel/3kyCb3YzHSifWBJTnpwEwKnf86wT7r
         1FGJgwrz4Pn8m9VMF7O0gk0QAVET612x++H9jvVzT/FTO2S/9T6IMZRLcUzYsV8xadj3
         esHAE86FDYeuGMpoAyQLo4p64KWzWorkSs3Cv9kCReYR3s+zMiC6iTpfPYJGCYsB3pVk
         /zBW1TRLzjqf0AJPhAfoqWLYiRY15FXph8BqbTAEA+/a5KO5kledHh0lzpFYeyMgpg6D
         Fhgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=oAz1BXO35jPyviQ4+93z2pC8F5URTOyYHE54QL5vpXg=;
        b=FNPwtIop/5/f3XHf0KhvxGcQA0CLBvEm3kaJ++4A7mQo5DWq/stGnRcJeeLsqewknA
         yGpU2ewnDm41HwjqF0/YuXfuIMJCTFIRFluIXywPP27/jGjSQfSJNGNUA/WdT/0XF4DB
         D/n1pmGFtt7+aovd9sciyipcKFwDw+ECNE9qzqaO4VTcxceKWNfRoVdd5rBO00YKEQeB
         Q6iO9B7YO6/0tEyHVpe+aQqqTU3TN9q9Jm3Rp/P0m4axUt1rDsno/kj0sDM4p+D2P+W/
         wmO1zNlS+eQ8gp7Hc60rzGVRBbnrlrL9YkC5mGM1U/6AwKZLevhIsSEWWAryI1izouh4
         iw5Q==
X-Gm-Message-State: AOAM530WsCdsrGW3ueNjR/Ss2mZ57kIxJ4QgY1zfFOrXPWmLDmZzWdSI
        iLuJsL+3kzLsCu4vNetp5mpyVmk7vKw=
X-Google-Smtp-Source: ABdhPJxjS77Ocmqnnw48udf3Vvq5Fdbc3W3W9diHF4uFh2QLC9Iyp68u89t90oa5zG3c5h7H7qI9MA==
X-Received: by 2002:a1c:4d8:: with SMTP id 207mr16746266wme.23.1638975488465;
        Wed, 08 Dec 2021 06:58:08 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b197sm2906225wmb.24.2021.12.08.06.58.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Dec 2021 06:58:08 -0800 (PST)
Message-Id: <341fe183c18ee28b459ba26f2c8c369d9367c328.1638975482.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1049.v2.git.1638975481.gitgitgadget@gmail.com>
References: <pull.1049.git.1633082702.gitgitgadget@gmail.com>
        <pull.1049.v2.git.1638975481.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 08 Dec 2021 14:57:54 +0000
Subject: [PATCH v2 07/14] create_autostash(): remove unneeded parameter
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Philippe Blain <levraiphilippeblain@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Elijah Newren <newren@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Phillip Wood <phillip.wood@dunelm.org.uk>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

The default_reflog parameter of create_autostash() is passed to
reset_head(). However as creating a stash does not involve updating
any refs the parameter is not used by reset_head(). Removing the
parameter from create_autostash() simplifies the callers.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 builtin/merge.c  | 6 ++----
 builtin/rebase.c | 8 ++++----
 sequencer.c      | 5 ++---
 sequencer.h      | 3 +--
 4 files changed, 9 insertions(+), 13 deletions(-)

diff --git a/builtin/merge.c b/builtin/merge.c
index ea3112e0c0b..cb0e4e22258 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -1565,8 +1565,7 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 
 		if (autostash)
 			create_autostash(the_repository,
-					 git_path_merge_autostash(the_repository),
-					 "merge");
+					 git_path_merge_autostash(the_repository));
 		if (checkout_fast_forward(the_repository,
 					  &head_commit->object.oid,
 					  &commit->object.oid,
@@ -1637,8 +1636,7 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 
 	if (autostash)
 		create_autostash(the_repository,
-				 git_path_merge_autostash(the_repository),
-				 "merge");
+				 git_path_merge_autostash(the_repository));
 
 	/* We are going to make a new commit. */
 	git_committer_info(IDENT_STRICT);
diff --git a/builtin/rebase.c b/builtin/rebase.c
index 2e5a535b54e..832e6954827 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -1658,10 +1658,10 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 	if (repo_read_index(the_repository) < 0)
 		die(_("could not read index"));
 
-	if (options.autostash) {
-		create_autostash(the_repository, state_dir_path("autostash", &options),
-				 DEFAULT_REFLOG_ACTION);
-	}
+	if (options.autostash)
+		create_autostash(the_repository,
+				 state_dir_path("autostash", &options));
+
 
 	if (require_clean_work_tree(the_repository, "rebase",
 				    _("Please commit or stash them."), 1, 1)) {
diff --git a/sequencer.c b/sequencer.c
index 3d3c3fbe305..5c65f5f1ac5 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -4094,8 +4094,7 @@ static enum todo_command peek_command(struct todo_list *todo_list, int offset)
 	return -1;
 }
 
-void create_autostash(struct repository *r, const char *path,
-		      const char *default_reflog_action)
+void create_autostash(struct repository *r, const char *path)
 {
 	struct strbuf buf = STRBUF_INIT;
 	struct lock_file lock_file = LOCK_INIT;
@@ -4132,7 +4131,7 @@ void create_autostash(struct repository *r, const char *path,
 		write_file(path, "%s", oid_to_hex(&oid));
 		printf(_("Created autostash: %s\n"), buf.buf);
 		if (reset_head(r, NULL, NULL, RESET_HEAD_HARD, NULL, NULL,
-			       default_reflog_action) < 0)
+			       "") < 0)
 			die(_("could not reset --hard"));
 
 		if (discard_index(r->index) < 0 ||
diff --git a/sequencer.h b/sequencer.h
index 05a7d2ba6b3..da64473636b 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -197,8 +197,7 @@ void commit_post_rewrite(struct repository *r,
 			 const struct commit *current_head,
 			 const struct object_id *new_head);
 
-void create_autostash(struct repository *r, const char *path,
-		      const char *default_reflog_action);
+void create_autostash(struct repository *r, const char *path);
 int save_autostash(const char *path);
 int apply_autostash(const char *path);
 int apply_autostash_oid(const char *stash_oid);
-- 
gitgitgadget

