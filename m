Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B183AC7EE24
	for <git@archiver.kernel.org>; Wed, 10 May 2023 22:56:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236703AbjEJW4D (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 May 2023 18:56:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236613AbjEJWzz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 May 2023 18:55:55 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9217A59C8
        for <git@vger.kernel.org>; Wed, 10 May 2023 15:55:42 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-3063b5f32aaso5127423f8f.2
        for <git@vger.kernel.org>; Wed, 10 May 2023 15:55:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683759341; x=1686351341;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rvdkpK4i29JGsdPGIKFzCvz8x5oqDToMx3woCvX7opM=;
        b=CUsn4cnIsFLzddTTa5ekZHOFlh0DcDzw1nOdrmY7fe+k/tXiYzdz6XXWY/uGtVPyIE
         Aky1P9N9SQ2e/3xHZDML3e/DxiLrjRXQXR5A0lOvmGeZBuhMLcapPGiL91Q9f2tYSfiP
         WYV286j32+SmUlH4TQJSFp0CKaPaHVzqPGkG66/Xkv5U/bW3P46rT/RYONBcbVptqLi5
         lTJiylrvxhr9eh5l+TvRSviSPi216xyf6oKDMqHtWttYhlvcBi5Ur2MhbRLdLnX0do+J
         7oe4NEm1TOqzDgeO4O/6j1oDaRI+lVY2xejTXyhqm61e9weBZ87wT2u8oSbla06lP/8U
         cjSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683759341; x=1686351341;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rvdkpK4i29JGsdPGIKFzCvz8x5oqDToMx3woCvX7opM=;
        b=GCbRyIjoIyfXCWo5C7QhJXG0nVuUuKD99n1zERYJEHLWUhy7qGa4KHufD/Vk2hcD8Y
         T6XSx/tWdb2MNfwRsvFjTLXqagJWW/0mVZEIsulPFMVcbvbLDhkhC+Cv5yIJpqsEnX1c
         Jwa+TUUGx0eLz/qdhZRfV18KEUyimgPucTNM9lSN/xiaRzdX3TMoF/WyFFIugBhx3b0a
         kzZrcnTU+c76nNmfuEDvIm+JKsGQZIBhy8PtlFbgQRmRXk/m07DxfIUORj/sG76mJ4l/
         vx+xLv3ckQrySbjhK6Tg47wnd285NH6nrruQruHBcNJADxoA5ZS93jho2VPYSBI1qEbe
         xXxg==
X-Gm-Message-State: AC+VfDxezOqap0Dm34Gw1cANjvz8I8CSpuk1TQ6zOCsqG1BBStBZ5jG1
        lGlKNxz15dtxEhWKZGdVnVmNtuBgDPs=
X-Google-Smtp-Source: ACHHUZ688wOMSyf8IFllsDSWa07lau3W3lIPJJn5TypZ/GYiQN7mxesiexjlsFn/UkS80gq+J9VZYw==
X-Received: by 2002:a5d:6406:0:b0:306:32c4:7e7b with SMTP id z6-20020a5d6406000000b0030632c47e7bmr14033026wru.41.1683759340884;
        Wed, 10 May 2023 15:55:40 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o18-20020a05600c379200b003f17300c7dcsm23720845wmr.48.2023.05.10.15.55.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 May 2023 15:55:40 -0700 (PDT)
Message-Id: <d12d5469f8cbc21ce1efbffc8e7569c534b5a305.1683759339.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1531.git.1683759338.gitgitgadget@gmail.com>
References: <pull.1531.git.1683759338.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 10 May 2023 22:55:38 +0000
Subject: [PATCH 2/2] rebase -r: fix the total number shown in the progress
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <derrickstolee@github.com>,
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
 sequencer.c              | 12 ++++++++----
 t/t3430-rebase-merges.sh |  7 +++++++
 2 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index f5d89abdc5e..46dd07df0f2 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -2609,7 +2609,7 @@ int todo_list_parse_insn_buffer(struct repository *r, char *buf,
 	char *p = buf, *next_p;
 	int i, res = 0, fixup_okay = file_exists(rebase_path_done());
 
-	todo_list->current = todo_list->nr = 0;
+	todo_list->current = todo_list->nr = todo_list->total_nr = 0;
 
 	for (i = 1; *p; i++, p = next_p) {
 		char *eol = strchrnul(p, '\n');
@@ -2628,7 +2628,8 @@ int todo_list_parse_insn_buffer(struct repository *r, char *buf,
 			item->arg_offset = p - buf;
 			item->arg_len = (int)(eol - p);
 			item->commit = NULL;
-		}
+		} else if (item->command == TODO_COMMENT)
+			todo_list->total_nr--;
 
 		if (fixup_okay)
 			; /* do nothing */
@@ -6039,7 +6040,7 @@ int complete_action(struct repository *r, struct replay_opts *opts, unsigned fla
 	struct todo_list new_todo = TODO_LIST_INIT;
 	struct strbuf *buf = &todo_list->buf, buf2 = STRBUF_INIT;
 	struct object_id oid = onto->object.oid;
-	int res;
+	int new_total_nr, res;
 
 	find_unique_abbrev_r(shortonto, &oid, DEFAULT_ABBREV);
 
@@ -6066,6 +6067,7 @@ int complete_action(struct repository *r, struct replay_opts *opts, unsigned fla
 		return error(_("nothing to do"));
 	}
 
+	new_total_nr = todo_list->total_nr - count_commands(todo_list);
 	res = edit_todo_list(r, todo_list, &new_todo, shortrevisions,
 			     shortonto, flags);
 	if (res == -1)
@@ -6088,11 +6090,13 @@ int complete_action(struct repository *r, struct replay_opts *opts, unsigned fla
 		return -1;
 	}
 
+	new_total_nr += count_commands(&new_todo);
+	new_todo.total_nr = new_total_nr;
+
 	/* Expand the commit IDs */
 	todo_list_to_strbuf(r, &new_todo, &buf2, -1, 0);
 	strbuf_swap(&new_todo.buf, &buf2);
 	strbuf_release(&buf2);
-	new_todo.total_nr -= new_todo.nr;
 	if (todo_list_parse_insn_buffer(r, new_todo.buf.buf, &new_todo) < 0)
 		BUG("invalid todo list after expanding IDs:\n%s",
 		    new_todo.buf.buf);
diff --git a/t/t3430-rebase-merges.sh b/t/t3430-rebase-merges.sh
index f351701fec2..8da99a075dc 100755
--- a/t/t3430-rebase-merges.sh
+++ b/t/t3430-rebase-merges.sh
@@ -517,4 +517,11 @@ test_expect_success '--rebase-merges with message matched with onto label' '
 	EOF
 '
 
+test_expect_success 'progress shows the correct total' '
+	git checkout -b progress H &&
+	git rebase --rebase-merges --force-rebase --verbose A 2> err &&
+	grep "^Rebasing.*14.$" err >progress &&
+	test_line_count = 14 progress
+'
+
 test_done
-- 
gitgitgadget
