Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 498861F45F
	for <e@80x24.org>; Tue,  7 May 2019 15:15:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726666AbfEGPPg (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 May 2019 11:15:36 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:38518 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726085AbfEGPPf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 May 2019 11:15:35 -0400
Received: by mail-wm1-f68.google.com with SMTP id f2so15685874wmj.3
        for <git@vger.kernel.org>; Tue, 07 May 2019 08:15:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mC1+eN3GvRipsiWSn9SRcIfXNV/wjKsSQg7GlkXgV5s=;
        b=oa39apC6Q4l0Gq66/DLkqPCu0q3y3YXhTvVtKoXQli4icge1BaUZepvLNkibAT94Lq
         Mwf1E0TMshsJunuPncg2wijaE/jOiQYCcuyLSQhXeB1enKkOmR9ZmchmjOsY4uFysjFX
         KiGsbAANjguLPnVbDOcOIdNU+xBq6ZrYYATlXs9WQvnQZQbD1S/zJuazjppQAj3rCJHq
         yBqRldReoAlEvdDZI4rhmaLK6Or2fx3whhwp2hwAqTBUGvtHQqiFnWlmtRnr5sBCgU9O
         D/ZO8OKVVVZV4QUOEKZfpQa6brZzYxMuLKAJ1xuPPK2WfSa82EfwRNdALnW7jJ4hswzu
         JV4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mC1+eN3GvRipsiWSn9SRcIfXNV/wjKsSQg7GlkXgV5s=;
        b=C3dcTDw0OvVRBLXwWTtX9Ti9/k/+b57fJEP78RiPKD9a2Sfbir56KQQXDOiRGRvPDG
         iPg3Alj35aMYoct33ysnJ3kdlxKSPdAoMUpk9ViN5+151if+r2ZzaxKhSWeWnhfmxlw3
         0FVEb4n93G7YKs3z6bXBzHSA0ur3Lh2r+S7NCakXxYZAJ7DTpOyPhRVvAt47FaJz2UOD
         XnEZc1Oyus+kWNCq6HhS8v4pEUiXqrzrVn8NjCjW2yMzX/gQ/1W2x5DIAK02RP1RT+VK
         MPrlwXATWmAsY/QGFQGn6x0hLz09nBlw9LMckEUmktCTW1v0aKx2OaX0AxIWPR3nBAZ0
         CDNg==
X-Gm-Message-State: APjAAAWIqihk9Af2DARejVNGNKtw851rjDvLS/vVV7T7rcRMB/Z24FNM
        Jv2AJAQ9fDzEslEWEHzhgOs=
X-Google-Smtp-Source: APXvYqy3+46ir1YflVigqx03vkyZKMkqfOxKzkpuA+RoqPzH0BEPrqUZDEf2kg9aNftnZ55SYuLeNA==
X-Received: by 2002:a1c:7a12:: with SMTP id v18mr21953747wmc.69.1557242133747;
        Tue, 07 May 2019 08:15:33 -0700 (PDT)
Received: from szeder.dev (x4db46d44.dyn.telefonica.de. [77.180.109.68])
        by smtp.gmail.com with ESMTPSA id z7sm18696511wme.26.2019.05.07.08.15.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 May 2019 08:15:33 -0700 (PDT)
Date:   Tue, 7 May 2019 17:15:31 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Phillip Wood <phillip.wood@dunelm.org.uk>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] rebase --abort: cleanup refs/rewritten
Message-ID: <20190507151530.GO14763@szeder.dev>
References: <20190426103212.8097-1-phillip.wood123@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190426103212.8097-1-phillip.wood123@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 26, 2019 at 11:32:12AM +0100, Phillip Wood wrote:
> From: Phillip Wood <phillip.wood@dunelm.org.uk>
> 
> When `rebase -r` finishes it removes any refs under refs/rewritten
> that it has created. However if the rebase is aborted these refs are
> not removed. This can cause problems for future rebases. For example I
> recently wanted to merge a updated version of a topic branch into an
> integration branch so ran `rebase -ir` and removed the picks and label
> for the topic branch from the todo list so that
>     merge -C <old-merge> topic
> would pick up the new version of topic. Unfortunately
> refs/rewritten/topic already existed from a previous rebase that had
> been aborted so the rebase just used the old topic, not the new one.
> 
> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> ---
> 
> Notes:
>     This is based on pw/rebase-i-internal, it would be nicer to base it on
>     maint but there are function name clashes adding sequencer.h to rebase.c
>     an maint. Those clashes are fixed in pw/rebase-i-internal
> 
>  builtin/rebase.c         | 13 ++++++++++---
>  t/t3430-rebase-merges.sh |  8 ++++++++
>  2 files changed, 18 insertions(+), 3 deletions(-)
> 
> diff --git a/builtin/rebase.c b/builtin/rebase.c
> index 82bd50a1b4..e2e49c8239 100644
> --- a/builtin/rebase.c
> +++ b/builtin/rebase.c
> @@ -761,9 +761,16 @@ static int finish_rebase(struct rebase_options *opts)
>  	 * user should see them.
>  	 */
>  	run_command_v_opt(argv_gc_auto, RUN_GIT_CMD);
> -	strbuf_addstr(&dir, opts->state_dir);
> -	remove_dir_recursively(&dir, 0);
> -	strbuf_release(&dir);
> +	if (opts->type == REBASE_INTERACTIVE) {
> +		struct replay_opts replay = REPLAY_OPTS_INIT;

This patch and the topic 'pw/rebase-abort-clean-rewritten' can't be
compiled on its own, because it starts using 'struct replay_opts'
here, which is defined in 'sequencer.h', but 'builtin/rebase.c'
doesn't include that header yet.  (Though 'pu' already builds fine,
because commit 0609b741a4 (rebase -i: combine rebase--interactive.c
with rebase.c, 2019-04-17) in the parallel topic
'pw/rebase-i-internal' adds the necessary #include.)

So, to keep future bisects from potentially tipping over the compiler
error, this patch should either #include "sequencer.h", or be applied
on top of 'pw/rebase-i-internal'.

> +
> +		replay.action = REPLAY_INTERACTIVE_REBASE;
> +		sequencer_remove_state(&replay);
> +	} else {
> +		strbuf_addstr(&dir, opts->state_dir);
> +		remove_dir_recursively(&dir, 0);
> +		strbuf_release(&dir);
> +	}
>  
>  	return 0;
>  }
> diff --git a/t/t3430-rebase-merges.sh b/t/t3430-rebase-merges.sh
> index 4c69255ee6..6ebebf7098 100755
> --- a/t/t3430-rebase-merges.sh
> +++ b/t/t3430-rebase-merges.sh
> @@ -224,6 +224,14 @@ test_expect_success 'refs/rewritten/* is worktree-local' '
>  	test_cmp_rev HEAD "$(cat wt/b)"
>  '
>  
> +test_expect_success '--abort cleans up refs/rewritten' '
> +	git checkout -b abort-cleans-refs-rewritten H &&
> +	GIT_SEQUENCE_EDITOR="echo break >>" git rebase -ir @^ &&
> +	git rev-parse --verify refs/rewritten/onto &&
> +	git rebase --abort &&
> +	test_must_fail git rev-parse --verify refs/rewritten/onto
> +'
> +
>  test_expect_success 'post-rewrite hook and fixups work for merges' '
>  	git checkout -b post-rewrite &&
>  	test_commit same1 &&
> -- 
> 2.21.0
> 
