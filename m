Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E9CAC77B7C
	for <git@archiver.kernel.org>; Sat, 13 May 2023 08:11:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229991AbjEMILd (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 13 May 2023 04:11:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbjEMILc (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 May 2023 04:11:32 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3906172C
        for <git@vger.kernel.org>; Sat, 13 May 2023 01:11:30 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-3063433fa66so7010814f8f.3
        for <git@vger.kernel.org>; Sat, 13 May 2023 01:11:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683965489; x=1686557489;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RqlBIK+zBl1yvWwCOixElczk1eBb8RxKXCDIoHEfXfY=;
        b=KvNLUDdYER+l7e8O4MVTyBNaZ09wx+eWItPipMEB7AGD+4eFUkgZYyzJQ+DhKekDLC
         fOXA6tyBm+YvxQaXhMrsqXNE2D0lmICpbaH1Ung+azp7XemgiXiJ6T2vG4MJRP5Gz7zv
         IX0ne2zfMUWV9tTJhsK8Vdf1EV/gYuhPRN2qGYFOJzuQb7SUaiPd25/ZsWsCh/woQHxp
         dqCDai+2lIuMThe9LeOW4tsuXeslhKuRiIvJo4dbQC7w6NBzE+N6ZY4OiXQjzhZWu1Xp
         ZQS3dSuy8kvcz+5jWrOCe6syxQBjhPPyjgvjKww/NNF7aOhZbcHAqFzFj66LrrmD3Vyl
         /Sag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683965489; x=1686557489;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RqlBIK+zBl1yvWwCOixElczk1eBb8RxKXCDIoHEfXfY=;
        b=cR0Dk2KpMMEy8O0jWOC2raKR282GhECxJBZLJlLRwrd008zq27Q6VseSrsB5yBovgU
         TqjrkJENl9p/TwWQwIIVTStec1/qt4q3i7SRDflmsnvubPdfejDAPmAvvyEVbNXyGr0r
         n0L7RgPZ+e9MA3SXhSXXZYHdDAcqnjkmTB8i1sCJCMNAiPv/iU2DjEcGjvHxtN2wbIte
         8gBlGqJv0/eCKRNOqR1YR6PSaMDSQSvjfsGOP1QTjMF22CZljY+qigMUJtW8yMSJk02/
         JMuigplR3O3GFUfzMIYuwyNKri6k8iO9LFd74CeSX9NXCXfTj+MrY7u+aCllBhOlhFe2
         vJwg==
X-Gm-Message-State: AC+VfDwSf4hBZi35gZjZJnR9ThOkANaYnPnW2jDqj1N7sLaak9kDvmkQ
        q+/iFV9w4x2du4btb84LTAyNsuSkqZg=
X-Google-Smtp-Source: ACHHUZ5JSKsC5umSIEc+mEM49Bf2IhMTGzuT3g6tlEHjVVw80wvG5zpOeefaurkimyUO1hWgmqe3Ow==
X-Received: by 2002:a05:6000:1813:b0:2f7:80d9:bb2f with SMTP id m19-20020a056000181300b002f780d9bb2fmr19616439wrh.22.1683965488764;
        Sat, 13 May 2023 01:11:28 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x16-20020a05600c21d000b003f318be9442sm31122845wmj.40.2023.05.13.01.11.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 May 2023 01:11:28 -0700 (PDT)
Message-Id: <pull.1531.v2.git.1683965487.gitgitgadget@gmail.com>
In-Reply-To: <pull.1531.git.1683759338.gitgitgadget@gmail.com>
References: <pull.1531.git.1683759338.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 13 May 2023 08:11:24 +0000
Subject: [PATCH v2 0/2] Fix two rebase bugs related to total_nr
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <derrickstolee@github.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I recently picked up work where I regularly rebase large branch thickets
consisting of thousands of commits. During those rebases, I could not fail
to notice that the progress initially showed a total number around 2,100,
when the actual number of commands was more like 1,850. And indeed, when
resuming the rebase after being interrupted due to a break command or due to
a merge conflict, the progress showed the correct number!

So I set out to fix this, stumbling over an incorrect use of total_nr in the
--update-refs code, so I fixed that, too.

Note: These patches apply cleanly on top of ds/rebase-update-ref as well as
on top of the current main branch.

Changes since v1:

 * Clarified the pattern expected by the test case in the progress output,
   as suggested by Junio.
 * Simplified the code as suggested by Phillipp, based on the insight that
   complete_action() (naming is hard!) is only called at the very beginning
   of a rebase, and therefore there cannot be any already-done commands in
   the todo list.

Johannes Schindelin (2):
  rebase --update-refs: fix loops
  rebase -r: fix the total number shown in the progress

 sequencer.c              | 13 ++++++++-----
 t/t3430-rebase-merges.sh |  8 ++++++++
 2 files changed, 16 insertions(+), 5 deletions(-)


base-commit: 4611884ea883908a9638cafbd824c401c41cf7f6
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1531%2Fdscho%2Ffix-rebase-i-progress-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1531/dscho/fix-rebase-i-progress-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1531

Range-diff vs v1:

 1:  2ac7c7a7c61 = 1:  2ac7c7a7c61 rebase --update-refs: fix loops
 2:  d12d5469f8c ! 2:  cac809bcffd rebase -r: fix the total number shown in the progress
     @@ Commit message
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
       ## sequencer.c ##
     +@@ sequencer.c: void todo_list_release(struct todo_list *todo_list)
     + static struct todo_item *append_new_todo(struct todo_list *todo_list)
     + {
     + 	ALLOC_GROW(todo_list->items, todo_list->nr + 1, todo_list->alloc);
     +-	todo_list->total_nr++;
     + 	return todo_list->items + todo_list->nr++;
     + }
     + 
      @@ sequencer.c: int todo_list_parse_insn_buffer(struct repository *r, char *buf,
       	char *p = buf, *next_p;
       	int i, res = 0, fixup_okay = file_exists(rebase_path_done());
     @@ sequencer.c: int todo_list_parse_insn_buffer(struct repository *r, char *buf,
       	for (i = 1; *p; i++, p = next_p) {
       		char *eol = strchrnul(p, '\n');
      @@ sequencer.c: int todo_list_parse_insn_buffer(struct repository *r, char *buf,
     - 			item->arg_offset = p - buf;
     - 			item->arg_len = (int)(eol - p);
       			item->commit = NULL;
     --		}
     -+		} else if (item->command == TODO_COMMENT)
     -+			todo_list->total_nr--;
     + 		}
       
     ++		if (item->command != TODO_COMMENT)
     ++			todo_list->total_nr++;
     ++
       		if (fixup_okay)
       			; /* do nothing */
     + 		else if (is_fixup(item->command))
      @@ sequencer.c: int complete_action(struct repository *r, struct replay_opts *opts, unsigned fla
     - 	struct todo_list new_todo = TODO_LIST_INIT;
     - 	struct strbuf *buf = &todo_list->buf, buf2 = STRBUF_INIT;
     - 	struct object_id oid = onto->object.oid;
     --	int res;
     -+	int new_total_nr, res;
     - 
     - 	find_unique_abbrev_r(shortonto, &oid, DEFAULT_ABBREV);
     - 
     -@@ sequencer.c: int complete_action(struct repository *r, struct replay_opts *opts, unsigned fla
     - 		return error(_("nothing to do"));
     - 	}
     - 
     -+	new_total_nr = todo_list->total_nr - count_commands(todo_list);
     - 	res = edit_todo_list(r, todo_list, &new_todo, shortrevisions,
     - 			     shortonto, flags);
     - 	if (res == -1)
     -@@ sequencer.c: int complete_action(struct repository *r, struct replay_opts *opts, unsigned fla
     - 		return -1;
     - 	}
     - 
     -+	new_total_nr += count_commands(&new_todo);
     -+	new_todo.total_nr = new_total_nr;
     -+
     - 	/* Expand the commit IDs */
       	todo_list_to_strbuf(r, &new_todo, &buf2, -1, 0);
       	strbuf_swap(&new_todo.buf, &buf2);
       	strbuf_release(&buf2);
      -	new_todo.total_nr -= new_todo.nr;
     ++	/* Nothing is done yet, and we're reparsing, so let's reset the count */
     ++	new_todo.total_nr = 0;
       	if (todo_list_parse_insn_buffer(r, new_todo.buf.buf, &new_todo) < 0)
       		BUG("invalid todo list after expanding IDs:\n%s",
       		    new_todo.buf.buf);
     @@ t/t3430-rebase-merges.sh: test_expect_success '--rebase-merges with message matc
      +test_expect_success 'progress shows the correct total' '
      +	git checkout -b progress H &&
      +	git rebase --rebase-merges --force-rebase --verbose A 2> err &&
     -+	grep "^Rebasing.*14.$" err >progress &&
     ++	# Expecting "Rebasing (N/14)" here, no bogus total number
     ++	grep "^Rebasing.*/14.$" err >progress &&
      +	test_line_count = 14 progress
      +'
      +

-- 
gitgitgadget
