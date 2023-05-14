Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6E88C77B7D
	for <git@archiver.kernel.org>; Sun, 14 May 2023 18:06:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230339AbjENR7Q (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 14 May 2023 13:59:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjENR7P (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 May 2023 13:59:15 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD0C435AF
        for <git@vger.kernel.org>; Sun, 14 May 2023 10:59:12 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-3f4ad71b00eso31343355e9.2
        for <git@vger.kernel.org>; Sun, 14 May 2023 10:59:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684087150; x=1686679150;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=PDlPMXWjwxiVASoA8oKnaFu3s1ygkcHvph+ZqgyKUYk=;
        b=VvPm/LKEx7iGq1zpdaUra8OTRh5iUXsojSLxUBa6jm/EVZdJj9osdozkSD155vCuNC
         aA+aIPOlDEw0me6fYyV9CK4wDucVHcFiliSFq3Ucm2KnRDCBaL+m6FDRrYIp7p8Oqv7h
         KwC3vlCRhsT0Mmiyioa+UEVhnwWdJnBJMxgayHATLbBMrNpBDe7nyD54pPhrSlp7z9TO
         nZ/3HI4UVMpWxJu6hhmYKoz5NSUIe5L9e2FFzL5L7PCVD60pGU4vFMzAUKVcVSFStLI0
         eZYAsQeIdqIGK52WrAdkIlxT3Qp9N5rortSrVKIhArwEh2GZ43C6HzYysMed58hFGrhq
         l2Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684087150; x=1686679150;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PDlPMXWjwxiVASoA8oKnaFu3s1ygkcHvph+ZqgyKUYk=;
        b=Sjzke9RplZUFADouj7nX/4D3T5COXQTDKXgntU4LxfOW4WHxCWAGH7ilCGxclAP6Hh
         7W2AIfJlq+lb+PWc9vqbTVmyMF8oKYsx9DQq5z7Ueds2YOgVxHgkV+hPpKYF6BFfUVc9
         DFwY5vCcStXo5F+3c7ibwH4Y/MNMqaoTDkIuCmCtY07S+mpzo5hgxrNxls3+TV32r44Q
         WTOwMS743i1P3nySJ+jvJky2I/E2Od8xnjb2wAPhp73GADGMm4LQHUXtdCXdxWu3q0ZN
         2Uhv0LqbHb2X3oX3tP894BCc8jyjyANwRhx2EAbtjYMRbL/WLF16ElAyINpAZkGpFWOP
         OJ+A==
X-Gm-Message-State: AC+VfDymte65uswmBGQn7B8YRMuMHxkd6G/DyZ1j9Jbt8vZMvAD0WD70
        uXlXYcco4PXW0/Dc1jYxoeg=
X-Google-Smtp-Source: ACHHUZ5HX999mgOJPSEXi2ellquqjWLSBdo7VkFUvGOdXJGVG097UMW9lO7uL+lH/MfbiwRLpLRvEQ==
X-Received: by 2002:a05:600c:2101:b0:3f4:2174:b28f with SMTP id u1-20020a05600c210100b003f42174b28fmr17655482wml.2.1684087149560;
        Sun, 14 May 2023 10:59:09 -0700 (PDT)
Received: from [192.168.1.212] ([90.255.142.254])
        by smtp.gmail.com with ESMTPSA id f26-20020a7bcd1a000000b003f423f5b659sm21943958wmj.10.2023.05.14.10.59.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 14 May 2023 10:59:09 -0700 (PDT)
Message-ID: <42b3c24a-8c3f-df03-18b8-312520d6c963@gmail.com>
Date:   Sun, 14 May 2023 18:59:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 0/2] Fix two rebase bugs related to total_nr
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Derrick Stolee <derrickstolee@github.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
References: <pull.1531.git.1683759338.gitgitgadget@gmail.com>
 <pull.1531.v2.git.1683965487.gitgitgadget@gmail.com>
Content-Language: en-US
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <pull.1531.v2.git.1683965487.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Dscho

On 13/05/2023 09:11, Johannes Schindelin via GitGitGadget wrote:
> I recently picked up work where I regularly rebase large branch thickets
> consisting of thousands of commits. During those rebases, I could not fail
> to notice that the progress initially showed a total number around 2,100,
> when the actual number of commands was more like 1,850. And indeed, when
> resuming the rebase after being interrupted due to a break command or due to
> a merge conflict, the progress showed the correct number!
> 
> So I set out to fix this, stumbling over an incorrect use of total_nr in the
> --update-refs code, so I fixed that, too.
> 
> Note: These patches apply cleanly on top of ds/rebase-update-ref as well as
> on top of the current main branch.
> 
> Changes since v1:
> 
>   * Clarified the pattern expected by the test case in the progress output,
>     as suggested by Junio.
>   * Simplified the code as suggested by Phillipp, based on the insight that
>     complete_action() (naming is hard!) is only called at the very beginning
>     of a rebase, and therefore there cannot be any already-done commands in
>     the todo list.

This version looks good to me, thanks for re-rolling

Phillip

> Johannes Schindelin (2):
>    rebase --update-refs: fix loops
>    rebase -r: fix the total number shown in the progress
> 
>   sequencer.c              | 13 ++++++++-----
>   t/t3430-rebase-merges.sh |  8 ++++++++
>   2 files changed, 16 insertions(+), 5 deletions(-)
> 
> 
> base-commit: 4611884ea883908a9638cafbd824c401c41cf7f6
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1531%2Fdscho%2Ffix-rebase-i-progress-v2
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1531/dscho/fix-rebase-i-progress-v2
> Pull-Request: https://github.com/gitgitgadget/git/pull/1531
> 
> Range-diff vs v1:
> 
>   1:  2ac7c7a7c61 = 1:  2ac7c7a7c61 rebase --update-refs: fix loops
>   2:  d12d5469f8c ! 2:  cac809bcffd rebase -r: fix the total number shown in the progress
>       @@ Commit message
>            Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
>        
>         ## sequencer.c ##
>       +@@ sequencer.c: void todo_list_release(struct todo_list *todo_list)
>       + static struct todo_item *append_new_todo(struct todo_list *todo_list)
>       + {
>       + 	ALLOC_GROW(todo_list->items, todo_list->nr + 1, todo_list->alloc);
>       +-	todo_list->total_nr++;
>       + 	return todo_list->items + todo_list->nr++;
>       + }
>       +
>        @@ sequencer.c: int todo_list_parse_insn_buffer(struct repository *r, char *buf,
>         	char *p = buf, *next_p;
>         	int i, res = 0, fixup_okay = file_exists(rebase_path_done());
>       @@ sequencer.c: int todo_list_parse_insn_buffer(struct repository *r, char *buf,
>         	for (i = 1; *p; i++, p = next_p) {
>         		char *eol = strchrnul(p, '\n');
>        @@ sequencer.c: int todo_list_parse_insn_buffer(struct repository *r, char *buf,
>       - 			item->arg_offset = p - buf;
>       - 			item->arg_len = (int)(eol - p);
>         			item->commit = NULL;
>       --		}
>       -+		} else if (item->command == TODO_COMMENT)
>       -+			todo_list->total_nr--;
>       + 		}
>         
>       ++		if (item->command != TODO_COMMENT)
>       ++			todo_list->total_nr++;
>       ++
>         		if (fixup_okay)
>         			; /* do nothing */
>       + 		else if (is_fixup(item->command))
>        @@ sequencer.c: int complete_action(struct repository *r, struct replay_opts *opts, unsigned fla
>       - 	struct todo_list new_todo = TODO_LIST_INIT;
>       - 	struct strbuf *buf = &todo_list->buf, buf2 = STRBUF_INIT;
>       - 	struct object_id oid = onto->object.oid;
>       --	int res;
>       -+	int new_total_nr, res;
>       -
>       - 	find_unique_abbrev_r(shortonto, &oid, DEFAULT_ABBREV);
>       -
>       -@@ sequencer.c: int complete_action(struct repository *r, struct replay_opts *opts, unsigned fla
>       - 		return error(_("nothing to do"));
>       - 	}
>       -
>       -+	new_total_nr = todo_list->total_nr - count_commands(todo_list);
>       - 	res = edit_todo_list(r, todo_list, &new_todo, shortrevisions,
>       - 			     shortonto, flags);
>       - 	if (res == -1)
>       -@@ sequencer.c: int complete_action(struct repository *r, struct replay_opts *opts, unsigned fla
>       - 		return -1;
>       - 	}
>       -
>       -+	new_total_nr += count_commands(&new_todo);
>       -+	new_todo.total_nr = new_total_nr;
>       -+
>       - 	/* Expand the commit IDs */
>         	todo_list_to_strbuf(r, &new_todo, &buf2, -1, 0);
>         	strbuf_swap(&new_todo.buf, &buf2);
>         	strbuf_release(&buf2);
>        -	new_todo.total_nr -= new_todo.nr;
>       ++	/* Nothing is done yet, and we're reparsing, so let's reset the count */
>       ++	new_todo.total_nr = 0;
>         	if (todo_list_parse_insn_buffer(r, new_todo.buf.buf, &new_todo) < 0)
>         		BUG("invalid todo list after expanding IDs:\n%s",
>         		    new_todo.buf.buf);
>       @@ t/t3430-rebase-merges.sh: test_expect_success '--rebase-merges with message matc
>        +test_expect_success 'progress shows the correct total' '
>        +	git checkout -b progress H &&
>        +	git rebase --rebase-merges --force-rebase --verbose A 2> err &&
>       -+	grep "^Rebasing.*14.$" err >progress &&
>       ++	# Expecting "Rebasing (N/14)" here, no bogus total number
>       ++	grep "^Rebasing.*/14.$" err >progress &&
>        +	test_line_count = 14 progress
>        +'
>        +
> 
