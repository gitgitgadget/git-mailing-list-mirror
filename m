Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 509E9C05027
	for <git@archiver.kernel.org>; Mon, 20 Feb 2023 14:19:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231466AbjBTOTk (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Feb 2023 09:19:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbjBTOTi (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Feb 2023 09:19:38 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FB1315573
        for <git@vger.kernel.org>; Mon, 20 Feb 2023 06:19:37 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id z8so1108292wrm.8
        for <git@vger.kernel.org>; Mon, 20 Feb 2023 06:19:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0c+DR4idj084DOUFSN6uuDmQT2Zd8m1Lg2KqOk4IJ0s=;
        b=p4yj+uKpubl/WR7ynguQhGJ0tVn/V7WU0yfcnW6qFS+G0IHj45RGgKXUWFn8RUkRCw
         FbIzM3+PTdTDrbfkrRXUOyRKMcNi1WoMagZxHLbVyTv67mAURb54EVyM5enkZ/5Z8Bi/
         +D2EvveEljruL32ktrmnPJekTe7O30K51m7+0PpGzZwbgcH7Rytb3PohxclDNv3gW2IR
         r+58c2HyJwE/E17e0xJuXimpQlrMG8lKLm1bCO1XL4CqA4OcOaTNbAMI2CtbYoFd23sD
         ydbKmMtvCkF/LBxPoMmiSfk/PrXxMGnGfyHXBV1oen2iOuR/zBv8y5irLPCjxKTHbXsf
         6bBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0c+DR4idj084DOUFSN6uuDmQT2Zd8m1Lg2KqOk4IJ0s=;
        b=XmO33ij1rmxzYH7W0NXP+ULuLAeE3XZm2f7B55KHOqUxK39gQ8ACG8OZcgB3hG7E9b
         nk+ge/ZM3SBFFp4i2v746pvs5bjFfgZFLqg4mHGkhhwOlvwVil8MpNHDdVqlzmGG18xL
         nYCFhJ/ggFL17oM0qBxQfrxFtxMMsJw39OGvf0VZBwYDorGoPKZ63oysWP+tOY9T3aug
         yWmlzzoa3iKoNRhQRAdd5yn5iKEsFSJpXU5q3daYfw2OYBXvypg8A4OZYGxKUGrhZsOi
         BTRSRR3KL1/cYIczpgjRVIRuTXyVexpoB/p/vT8Ssiwp9l1y0PIXin0do1U6TxFmHGr0
         Q/eA==
X-Gm-Message-State: AO0yUKWmP6/9xVAlR5H6A6xA9e/D4RnAnGEdC8tR9L4CRKH4LEt+rR2r
        AQRVrlsTEgp6XsPD2HaPSD9hcnJhbcI=
X-Google-Smtp-Source: AK7set9UC1hnNCHqw4M7miq/1IqbOeCZAaJjCl5N6BFfPT+RfUwyzgZ+aPXeBHm06dmkmF5WB8HSYA==
X-Received: by 2002:adf:dbd2:0:b0:2c3:e6b8:8cec with SMTP id e18-20020adfdbd2000000b002c3e6b88cecmr1762305wrj.49.1676902775583;
        Mon, 20 Feb 2023 06:19:35 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a9-20020a5d5709000000b002be099f78c0sm2136362wrv.69.2023.02.20.06.19.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Feb 2023 06:19:35 -0800 (PST)
Message-Id: <pull.1482.v2.git.1676902774366.gitgitgadget@gmail.com>
In-Reply-To: <pull.1482.git.1676644675638.gitgitgadget@gmail.com>
References: <pull.1482.git.1676644675638.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 20 Feb 2023 14:19:34 +0000
Subject: [PATCH v2] rebase -i: check labels and refs when parsing todo list
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <derrickstolee@github.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

Check that the argument to the "label" and "update-ref" commands is a
valid refname when the todo list is parsed rather than waiting until the
command is executed. This means that the user can deal with any errors
at the beginning of the rebase rather than having it stop halfway
through due to a typo in a label name. The "update-ref" command is
changed to reject single level refs as it is all to easy to type
"update-ref branch" which is incorrect rather than "update-ref
refs/heads/branch"

Note that it is not straight forward to check the arguments to "reset"
and "merge" commands as they may be any revision, not just a refname and
we do not have an equivalent of check_refname_format() for revisions.

Helped-by: Derrick Stolee <derrickstolee@github.com>
Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
    rebase -i: check labels and refs when parsing todo list
    
    Hopefully detecting these errors when the user edits the todo list will
    give a better experience.
    
    Thanks to Stolee for his comments on V1, I've updated the patch based on
    those, there are no functional changes but the code is hopefully
    clearer.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1482%2Fphillipwood%2Frebase-check-labels-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1482/phillipwood/rebase-check-labels-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1482

Range-diff vs v1:

 1:  5a31d880064 ! 1:  2cc62fe5986 rebase -i: check labels and refs when parsing todo list
     @@ Commit message
          and "merge" commands as they may be any revision, not just a refname and
          we do not have an equivalent of check_refname_format() for revisions.
      
     +    Helped-by: Derrick Stolee <derrickstolee@github.com>
          Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
      
       ## sequencer.c ##
     @@ sequencer.c: static int is_command(enum todo_command command, const char **bol)
       
      +static int check_label_or_ref_arg(enum todo_command command, const char *arg)
      +{
     -+	int allow_onelevel =
     -+		command == TODO_LABEL ? REFNAME_ALLOW_ONELEVEL : 0;
     ++	switch (command) {
     ++	case TODO_LABEL:
     ++	  /*
     ++	   * '#' is not a valid label as the merge command uses it to
     ++	   * separate merge parents from the commit subject.
     ++	   */
     ++	  if (!strcmp(arg, "#") ||
     ++		    check_refname_format(arg, REFNAME_ALLOW_ONELEVEL))
     ++			return error(_("'%s' is not a valid label"), arg);
     ++		break;
      +
     -+	if ((command == TODO_LABEL && !strcmp(arg, "#")) ||
     -+	    check_refname_format(arg, allow_onelevel)) {
     -+		if (command == TODO_LABEL)
     -+			error(_("'%s' is not a valid label"), arg);
     -+		else if (check_refname_format(arg, REFNAME_ALLOW_ONELEVEL))
     -+			error(_("'%s' is not a valid refname"), arg);
     -+		else
     -+			error(_("update-ref requires a fully qualified refname e.g. refs/heads/%s"),
     -+			      arg);
     -+		return -1;
     ++	case TODO_UPDATE_REF:
     ++		if (check_refname_format(arg, REFNAME_ALLOW_ONELEVEL))
     ++			return error(_("'%s' is not a valid refname"), arg);
     ++		if (check_refname_format(arg, 0))
     ++			return error(_("update-ref requires a fully qualified "
     ++				       "refname e.g. refs/heads/%s"), arg);
     ++		break;
     ++
     ++	default:
     ++		BUG("unexpected todo_command");
      +	}
      +
      +	return 0;
     @@ sequencer.c: static int is_command(enum todo_command command, const char **bol)
       			   const char *buf, const char *bol, char *eol)
       {
      @@ sequencer.c: static int parse_insn_line(struct repository *r, struct todo_item *item,
     - 		return error(_("missing arguments for %s"),
     - 			     command_to_string(item->command));
       
     --	if (item->command == TODO_EXEC || item->command == TODO_LABEL ||
     -+	if (item->command == TODO_LABEL ||
     + 	if (item->command == TODO_EXEC || item->command == TODO_LABEL ||
       	    item->command == TODO_RESET || item->command == TODO_UPDATE_REF) {
      +		int ret = 0;
      +
     -+		item->commit = NULL;
     -+		item->arg_offset = bol - buf;
     -+		item->arg_len = (int)(eol - bol);
     -+		if (item->command != TODO_RESET) {
     + 		item->commit = NULL;
     + 		item->arg_offset = bol - buf;
     + 		item->arg_len = (int)(eol - bol);
     +-		return 0;
     ++		if (item->command == TODO_LABEL ||
     ++		    item->command == TODO_UPDATE_REF) {
      +			saved = *eol;
      +			*eol = '\0';
      +			ret = check_label_or_ref_arg(item->command, bol);
      +			*eol = saved;
      +		}
      +		return ret;
     -+	}
     -+
     -+	if (item->command == TODO_EXEC) {
     - 		item->commit = NULL;
     - 		item->arg_offset = bol - buf;
     - 		item->arg_len = (int)(eol - bol);
     + 	}
     + 
     + 	if (item->command == TODO_FIXUP) {
      
       ## t/t3404-rebase-interactive.sh ##
     +@@ t/t3404-rebase-interactive.sh: test_expect_success '--update-refs: --edit-todo with no update-ref lines' '
     + '
     + 
     + test_expect_success '--update-refs: check failed ref update' '
     ++	test_when_finished "test_might_fail git rebase --abort" &&
     + 	git checkout -B update-refs-error no-conflict-branch &&
     + 	git branch -f base HEAD~4 &&
     + 	git branch -f first HEAD~3 &&
      @@ t/t3404-rebase-interactive.sh: test_expect_success '--update-refs: check failed ref update' '
     - 	tail -n 6 err >err.last &&
     - 	sed -e "s/Rebasing.*Successfully/Successfully/g" -e "s/^\t//g" \
     - 		<err.last >err.trimmed &&
     --	test_cmp expect err.trimmed
     -+	test_cmp expect err.trimmed &&
     -+	git rebase --abort
     -+'
     -+
     + 	test_cmp expect err.trimmed
     + '
     + 
      +test_expect_success 'bad labels and refs rejected when parsing todo list' '
     ++	test_when_finished "test_might_fail git rebase --abort" &&
      +	cat >todo <<-\EOF &&
      +	exec >execed
      +	label #
     @@ t/t3404-rebase-interactive.sh: test_expect_success '--update-refs: check failed
      +	grep "'\'':bad'\'' is not a valid refname" err &&
      +	grep "update-ref requires a fully qualified refname e.g. refs/heads/topic" \
      +		err &&
     -+	test_path_is_missing execed &&
     -+	git rebase --abort
     - '
     - 
     ++	test_path_is_missing execed
     ++'
     ++
       # This must be the last test in this file
     + test_expect_success '$EDITOR and friends are unchanged' '
     + 	test_editor_unchanged


 sequencer.c                   | 39 ++++++++++++++++++++++++++++++++++-
 t/t3404-rebase-interactive.sh | 23 +++++++++++++++++++++
 2 files changed, 61 insertions(+), 1 deletion(-)

diff --git a/sequencer.c b/sequencer.c
index 3e4a1972897..33bdc8bca43 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -2477,6 +2477,34 @@ static int is_command(enum todo_command command, const char **bol)
 		 (*bol = p));
 }
 
+static int check_label_or_ref_arg(enum todo_command command, const char *arg)
+{
+	switch (command) {
+	case TODO_LABEL:
+	  /*
+	   * '#' is not a valid label as the merge command uses it to
+	   * separate merge parents from the commit subject.
+	   */
+	  if (!strcmp(arg, "#") ||
+		    check_refname_format(arg, REFNAME_ALLOW_ONELEVEL))
+			return error(_("'%s' is not a valid label"), arg);
+		break;
+
+	case TODO_UPDATE_REF:
+		if (check_refname_format(arg, REFNAME_ALLOW_ONELEVEL))
+			return error(_("'%s' is not a valid refname"), arg);
+		if (check_refname_format(arg, 0))
+			return error(_("update-ref requires a fully qualified "
+				       "refname e.g. refs/heads/%s"), arg);
+		break;
+
+	default:
+		BUG("unexpected todo_command");
+	}
+
+	return 0;
+}
+
 static int parse_insn_line(struct repository *r, struct todo_item *item,
 			   const char *buf, const char *bol, char *eol)
 {
@@ -2525,10 +2553,19 @@ static int parse_insn_line(struct repository *r, struct todo_item *item,
 
 	if (item->command == TODO_EXEC || item->command == TODO_LABEL ||
 	    item->command == TODO_RESET || item->command == TODO_UPDATE_REF) {
+		int ret = 0;
+
 		item->commit = NULL;
 		item->arg_offset = bol - buf;
 		item->arg_len = (int)(eol - bol);
-		return 0;
+		if (item->command == TODO_LABEL ||
+		    item->command == TODO_UPDATE_REF) {
+			saved = *eol;
+			*eol = '\0';
+			ret = check_label_or_ref_arg(item->command, bol);
+			*eol = saved;
+		}
+		return ret;
 	}
 
 	if (item->command == TODO_FIXUP) {
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index 462cefd25df..efeb74ad50a 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -2072,6 +2072,7 @@ test_expect_success '--update-refs: --edit-todo with no update-ref lines' '
 '
 
 test_expect_success '--update-refs: check failed ref update' '
+	test_when_finished "test_might_fail git rebase --abort" &&
 	git checkout -B update-refs-error no-conflict-branch &&
 	git branch -f base HEAD~4 &&
 	git branch -f first HEAD~3 &&
@@ -2123,6 +2124,28 @@ test_expect_success '--update-refs: check failed ref update' '
 	test_cmp expect err.trimmed
 '
 
+test_expect_success 'bad labels and refs rejected when parsing todo list' '
+	test_when_finished "test_might_fail git rebase --abort" &&
+	cat >todo <<-\EOF &&
+	exec >execed
+	label #
+	label :invalid
+	update-ref :bad
+	update-ref topic
+	EOF
+	rm -f execed &&
+	(
+		set_replace_editor todo &&
+		test_must_fail git rebase -i HEAD 2>err
+	) &&
+	grep "'\''#'\'' is not a valid label" err &&
+	grep "'\'':invalid'\'' is not a valid label" err &&
+	grep "'\'':bad'\'' is not a valid refname" err &&
+	grep "update-ref requires a fully qualified refname e.g. refs/heads/topic" \
+		err &&
+	test_path_is_missing execed
+'
+
 # This must be the last test in this file
 test_expect_success '$EDITOR and friends are unchanged' '
 	test_editor_unchanged

base-commit: b1485644f936ee83a995ec24d23f713f4230a1ae
-- 
gitgitgadget
