Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F11E5C77B7D
	for <git@archiver.kernel.org>; Sat, 13 May 2023 08:11:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230322AbjEMILh (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 13 May 2023 04:11:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229882AbjEMILd (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 May 2023 04:11:33 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AFAE5BBB
        for <git@vger.kernel.org>; Sat, 13 May 2023 01:11:31 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-3078cc99232so7606874f8f.3
        for <git@vger.kernel.org>; Sat, 13 May 2023 01:11:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683965490; x=1686557490;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z+s5DaJefzAhT6TdVJO+G2ByL3ErX7v3EXgeOba0WUU=;
        b=YFcCTNQ3eXejbj4oghgExMDbkY5LGRq4TRg33SgAxGNN60lokk8G9N6KlgfJ0CAwqZ
         oO2XE+m1W4DP2uZE6Ut9+lzFy1pll5lYXtywqivz7QkwVhVCRxOUt4EbqtXdUGYqU1uB
         q6eLV3vwUVijUXfOVfVY1YZMXtuEf1iSclX55Lu6QlepkopNJUdRB1mWja8GNEENNnyd
         w/kw2jI0oqIXOLaWJqzJG/W2FzDpCLvBDDh0oSWbtWkarEFdNkmhxo5MFUXh3Re2F+Yk
         2U7gYkJBiXWtAnQNSg6FFgKH9xXWR4z4xN5h4U3Zr34dDH9HsAtHpW5idN4KEfTYvFfu
         MrYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683965490; x=1686557490;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z+s5DaJefzAhT6TdVJO+G2ByL3ErX7v3EXgeOba0WUU=;
        b=Vu/jol6millWdAnpK+etvIrtemx6ANgePqP41R9PbqcId1RL8L2UIUBD9NFsWyeRY4
         vz/oviDUop3O8oVUFQIWiunHm7dFR+Xb4G/sFjScs/f3LnHByFKCK+IltrdE1YhoG3N6
         qJ09HYmhhcfCONBThJzr59YYaHJ2/uMIGv+4t2VPjlEMdphL0dNk6yBQgz8uwEkprYNh
         lHYn6kKPj1NLX2lUqtknQwIoCxrigtxX/nN+wGG4WV7BJKVBTqvArAw9SiO9TWbkmooj
         e0hEa9K76BpkTofyHOcUfYnjfeFByR5SowIxJ90Rt/d2F00ErcLiFxCAQs6azLQoA+4J
         l6DA==
X-Gm-Message-State: AC+VfDwbDaS6qwJJ+Rh87T/+zbEfHfIUcF98XYX/bYXT5TX5IGHGQ4kX
        kvR5wqxcWBCRqjGztd6OE2De3g3RhsU=
X-Google-Smtp-Source: ACHHUZ7zrhHpIUm/r17D7ZrXV7vst7RKUlcXKavOso8j9LZ/liKWTD1A7WWqcRzzEiOoKS2CW1VP2A==
X-Received: by 2002:adf:dd02:0:b0:2f9:9911:93d1 with SMTP id a2-20020adfdd02000000b002f9991193d1mr21258497wrm.24.1683965489708;
        Sat, 13 May 2023 01:11:29 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a4-20020adffac4000000b00304ae802f02sm25637840wrs.66.2023.05.13.01.11.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 May 2023 01:11:29 -0700 (PDT)
Message-Id: <cac809bcffd8ac6905ff823e1ab3503160ac54fd.1683965487.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1531.v2.git.1683965487.gitgitgadget@gmail.com>
References: <pull.1531.git.1683759338.gitgitgadget@gmail.com>
        <pull.1531.v2.git.1683965487.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 13 May 2023 08:11:26 +0000
Subject: [PATCH v2 2/2] rebase -r: fix the total number shown in the progress
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <derrickstolee@github.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

For regular, non-`--rebase-merges` runs, there is very little work to do
for the parser when determining the total number of commands in a rebase
script: it is simply the number of lines after stripping the commented
lines and then trimming the trailing empty line, if any.

The `--rebase-merges` mode complicates things by introducing empty lines
and comments in the middle of the script. These should _not_ be counted
as commands, and indeed, when an interactive rebase is interrupted and
subsequently resumed, the total number of commands can magically shrink,
sometimes dramatically.

The reason for this strange behavior is that empty lines _are_ counted
in `edit_todo_list()` (but not the comments, as they are stripped via
`strbuf_stripspace(..., 1)`, which is a bug.

Let's fix this so that the correct total number is shown from the
get-go, by carefully adjusting it according to what's in the rebase
script. Extra care needs to be taken in case the user edits the script:
the number of commands might be different after the user edited than
beforehand.

Note: Even though commented lines are skipped in `edit_todo_list()`, we
still need to handle `TODO_COMMENT` items by decrementing the
already-incremented `total_nr` again: empty lines are also marked as
`TODO_COMMENT`.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 sequencer.c              | 9 ++++++---
 t/t3430-rebase-merges.sh | 8 ++++++++
 2 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index f5d89abdc5e..9fb8ef17618 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -2453,7 +2453,6 @@ void todo_list_release(struct todo_list *todo_list)
 static struct todo_item *append_new_todo(struct todo_list *todo_list)
 {
 	ALLOC_GROW(todo_list->items, todo_list->nr + 1, todo_list->alloc);
-	todo_list->total_nr++;
 	return todo_list->items + todo_list->nr++;
 }
 
@@ -2609,7 +2608,7 @@ int todo_list_parse_insn_buffer(struct repository *r, char *buf,
 	char *p = buf, *next_p;
 	int i, res = 0, fixup_okay = file_exists(rebase_path_done());
 
-	todo_list->current = todo_list->nr = 0;
+	todo_list->current = todo_list->nr = todo_list->total_nr = 0;
 
 	for (i = 1; *p; i++, p = next_p) {
 		char *eol = strchrnul(p, '\n');
@@ -2630,6 +2629,9 @@ int todo_list_parse_insn_buffer(struct repository *r, char *buf,
 			item->commit = NULL;
 		}
 
+		if (item->command != TODO_COMMENT)
+			todo_list->total_nr++;
+
 		if (fixup_okay)
 			; /* do nothing */
 		else if (is_fixup(item->command))
@@ -6092,7 +6094,8 @@ int complete_action(struct repository *r, struct replay_opts *opts, unsigned fla
 	todo_list_to_strbuf(r, &new_todo, &buf2, -1, 0);
 	strbuf_swap(&new_todo.buf, &buf2);
 	strbuf_release(&buf2);
-	new_todo.total_nr -= new_todo.nr;
+	/* Nothing is done yet, and we're reparsing, so let's reset the count */
+	new_todo.total_nr = 0;
 	if (todo_list_parse_insn_buffer(r, new_todo.buf.buf, &new_todo) < 0)
 		BUG("invalid todo list after expanding IDs:\n%s",
 		    new_todo.buf.buf);
diff --git a/t/t3430-rebase-merges.sh b/t/t3430-rebase-merges.sh
index f351701fec2..499c31a8d9a 100755
--- a/t/t3430-rebase-merges.sh
+++ b/t/t3430-rebase-merges.sh
@@ -517,4 +517,12 @@ test_expect_success '--rebase-merges with message matched with onto label' '
 	EOF
 '
 
+test_expect_success 'progress shows the correct total' '
+	git checkout -b progress H &&
+	git rebase --rebase-merges --force-rebase --verbose A 2> err &&
+	# Expecting "Rebasing (N/14)" here, no bogus total number
+	grep "^Rebasing.*/14.$" err >progress &&
+	test_line_count = 14 progress
+'
+
 test_done
-- 
gitgitgadget
