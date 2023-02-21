Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00406C636D7
	for <git@archiver.kernel.org>; Tue, 21 Feb 2023 17:05:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234754AbjBURFv (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Feb 2023 12:05:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234638AbjBURFu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Feb 2023 12:05:50 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FEF14ED9
        for <git@vger.kernel.org>; Tue, 21 Feb 2023 09:05:40 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id c5so5901566wrr.5
        for <git@vger.kernel.org>; Tue, 21 Feb 2023 09:05:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sj67puax3WXLzGSTUXmLvZkKEzYRihgZoHHagbpQPMo=;
        b=SEcfJMJ/LbU+CuVA9DO4VNkXleXZ2TAcwCA+P5+nDdaA8hWmopSBTZCicRHN8TDvBU
         2/4RjxlBRhI6wUmbF/et77jWRrNNubWz6iFbdk+Ur44bo2dw9rXhOPg2jOt+jriLirw5
         4C6p3KBHM9857lhx0JDGTUTH2pLc647t+TCaGtlq5SLjxFtxsmNMZFI7Th+wN38RuWsc
         qZOLA/cdJaTuLkGq0uCNz3ostoiyIJ0nuhLpWPKhpc3YurC5pdNOBCGxfAiSBHp+p8U1
         VD0S2NiPWUz+3dh6/A+wS7Ts+5LvkpXIcOeHi+evtQs+wMrlBnVipQ//WgMVjJL0Qpcc
         l4aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sj67puax3WXLzGSTUXmLvZkKEzYRihgZoHHagbpQPMo=;
        b=2VWfVyGEqdNQEJuC6zpZ/aFfg/9vrJ1B1v0EdpYUCVlLU1MPhg/wFcoIzLjeBtVVZr
         A5uMLsAklUZbdotCFhuAMLBPS01/kKZTd3lOsGt0aEYnizY564eh9QJTPXH8RDdGjW0/
         hqaDzE801bWM4BbuY9Ukx6s8iq89OuI/hOmzJijkcGtFR07EOTrGyDhcYGZWnjNXT4ID
         xRy/Wgd5/oQwQ/dM0XhDf0FkP8458p3z/LFFGfNQblioNAeHB8rOhZzsfse0s8ab3VqJ
         W1OSPrZDH0xee03rQ6Ou/ZpdI5KU2zYgp1PRpklEDjTfPdCzmHTqYKB7XMAzC47GtHDX
         wuBw==
X-Gm-Message-State: AO0yUKWcUqAaybf9gVvcWwTbe5NlUcZM4kRRmFhglneBzquO+nNmE2fM
        mmCj8owMy4tnLxGqTyZqw+6m5hRcMDc=
X-Google-Smtp-Source: AK7set+OpLxnOSZq9uD3/C0SgRib5VTOhP03oVhqDJnzQeKQQ9nrr7jzv+TmwfttdbBeFJDvMk4DvQ==
X-Received: by 2002:adf:ff92:0:b0:2c7:6c7:7bc2 with SMTP id j18-20020adfff92000000b002c706c77bc2mr1663581wrr.38.1676999138270;
        Tue, 21 Feb 2023 09:05:38 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k9-20020a5d6289000000b002c56af32e8csm4030920wru.35.2023.02.21.09.05.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Feb 2023 09:05:37 -0800 (PST)
Message-Id: <pull.1482.v3.git.1676999137195.gitgitgadget@gmail.com>
In-Reply-To: <pull.1482.v2.git.1676902774366.gitgitgadget@gmail.com>
References: <pull.1482.v2.git.1676902774366.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 21 Feb 2023 17:05:37 +0000
Subject: [PATCH v3] rebase -i: check labels and refs when parsing todo list
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
    
    Changes from V2:
    
     * Fix some whitespace issues pointed out by Stolee.
    
    Thanks to Stolee for his comments on V1, I've updated the patch based on
    those, there are no functional changes but the code is hopefully
    clearer.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1482%2Fphillipwood%2Frebase-check-labels-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1482/phillipwood/rebase-check-labels-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/1482

Range-diff vs v2:

 1:  2cc62fe5986 ! 1:  52a23db3cfe rebase -i: check labels and refs when parsing todo list
     @@ sequencer.c: static int is_command(enum todo_command command, const char **bol)
      +{
      +	switch (command) {
      +	case TODO_LABEL:
     -+	  /*
     -+	   * '#' is not a valid label as the merge command uses it to
     -+	   * separate merge parents from the commit subject.
     -+	   */
     -+	  if (!strcmp(arg, "#") ||
     ++		/*
     ++		 * '#' is not a valid label as the merge command uses it to
     ++		 * separate merge parents from the commit subject.
     ++		 */
     ++		if (!strcmp(arg, "#") ||
      +		    check_refname_format(arg, REFNAME_ALLOW_ONELEVEL))
      +			return error(_("'%s' is not a valid label"), arg);
      +		break;


 sequencer.c                   | 39 ++++++++++++++++++++++++++++++++++-
 t/t3404-rebase-interactive.sh | 23 +++++++++++++++++++++
 2 files changed, 61 insertions(+), 1 deletion(-)

diff --git a/sequencer.c b/sequencer.c
index 3e4a1972897..ff83a55bb36 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -2477,6 +2477,34 @@ static int is_command(enum todo_command command, const char **bol)
 		 (*bol = p));
 }
 
+static int check_label_or_ref_arg(enum todo_command command, const char *arg)
+{
+	switch (command) {
+	case TODO_LABEL:
+		/*
+		 * '#' is not a valid label as the merge command uses it to
+		 * separate merge parents from the commit subject.
+		 */
+		if (!strcmp(arg, "#") ||
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
