Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 02F341F4C0
	for <e@80x24.org>; Tue, 22 Oct 2019 16:01:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389010AbfJVQBN (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Oct 2019 12:01:13 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:39925 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387746AbfJVQBM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Oct 2019 12:01:12 -0400
Received: by mail-wm1-f66.google.com with SMTP id r141so7109247wme.4
        for <git@vger.kernel.org>; Tue, 22 Oct 2019 09:01:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6lWBdDQulmMPcNxOU3ipuFhAi6IYPgxiJGzdC5sCce0=;
        b=rpa4dtEtswFLmdNAmL1oA4jTmAsWd96OlLZqes8W5lsraLFuPFY62cdhRmv61VtWS8
         AYYjXaPftupH7TWPwiuoMwis2ZoFTJn35SthT/6khZ8U8PxA1y/xqZuziYXd0SyeCPYS
         hbD9ixUO3Sy0/kem90nAavxWR716UHvNfcUbmGrr/0FImUiL5JgOJ3nEf1LBp9p+4Dc9
         yMxAP4u6ES4SSZIy2GZe8+U/ITUF2UxRvzG5Vih9jFkzEMrS0bIfaCcq6L4Az4BRiFDB
         o72mN15q0UlgHzZ/+7BCk5OszV7XjHWZ1QBe99Pp2pessAaTXpEoE9mkeWt05lXgUgbb
         X2hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6lWBdDQulmMPcNxOU3ipuFhAi6IYPgxiJGzdC5sCce0=;
        b=ONCCwIn/ej5obC5s6J2Ez6UnWCWRi9hlANgAMPY/JFAI2hRpL4FfDcYVLZJiGs2V2H
         Z/sFglva8BOTNJoBzvDy8GCeV8xVcHC2vcakgfkjBHitGL89aCMqDza4dIXXPB6Ix1SZ
         vcNi+5OL/iQIWKaTYEx+MNa+sbfLs4X6OtukkQ7HgG0RTzaLaL1P9oDj0Gt/i4+fIPt1
         4S4DAqTlLt5iCFlOGCLPgfhi4nidH4gNNw4q+JXDO+2d1TET59dkL5WxlHfgLpCI9sOs
         dmDf4XPCd0wbYXsYB6tQOuqEwI4QGftQX84REKWVteU1wewibtNK48EPrVdlpzQErLnY
         34qw==
X-Gm-Message-State: APjAAAX4pkoXaIdxXz/WAfG0LLXH0zQ4AcGHAh0f5u00e2XBiuy3r1TE
        t0H8yM7ibqfmrbnOnRdctlY=
X-Google-Smtp-Source: APXvYqzdgWBDWXqV/ZYUqKVb3usXCeOMLB4WCV4Lc5a7S9Naj9w5oQ1qC6ArsF/Z8YQYqGYvPUgt0w==
X-Received: by 2002:a1c:4456:: with SMTP id r83mr3566849wma.2.1571760068557;
        Tue, 22 Oct 2019 09:01:08 -0700 (PDT)
Received: from szeder.dev (x4dbe0456.dyn.telefonica.de. [77.190.4.86])
        by smtp.gmail.com with ESMTPSA id g69sm5937598wme.31.2019.10.22.09.01.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Oct 2019 09:01:07 -0700 (PDT)
Date:   Tue, 22 Oct 2019 18:01:05 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 2/2] git_path(): handle `.lock` files correctly
Message-ID: <20191022160105.GE4348@szeder.dev>
References: <pull.401.v2.git.1571350077.gitgitgadget@gmail.com>
 <pull.401.v3.git.1571694882.gitgitgadget@gmail.com>
 <8b1f4f089a6d4a2293507a1a77668c828598e84f.1571694882.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8b1f4f089a6d4a2293507a1a77668c828598e84f.1571694882.git.gitgitgadget@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 21, 2019 at 09:54:42PM +0000, Johannes Schindelin via GitGitGadget wrote:
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
> 
> Ever since worktrees were introduced, the `git_path()` function _really_
> needed to be called e.g. to get at the path to `logs/HEAD` (`HEAD` is
> specific to the worktree, and therefore so is its reflog). However, the
> wrong path is returned for `logs/HEAD.lock`.
> 
> This does not matter as long as the Git executable is doing the asking,
> as the path for that `logs/HEAD.lock` file is constructed from
> `git_path("logs/HEAD")` by appending the `.lock` suffix.
> 
> However, Git GUI just learned to use `--git-path` instead of appending
> relative paths to what `git rev-parse --git-dir` returns (and as a
> consequence not only using the correct hooks directory, but also using
> the correct paths in worktrees other than the main one). While it does
> not seem as if Git GUI in particular is asking for `logs/HEAD.lock`,
> let's be safe rather than sorry.
> 
> Side note: Git GUI _does_ ask for `index.lock`, but that is already
> resolved correctly, due to `update_common_dir()` preferring to leave
> unknown paths in the (worktree-specific) git directory.
> 
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  path.c               |  8 +++++++-
>  t/t1500-rev-parse.sh | 15 +++++++++++++++
>  2 files changed, 22 insertions(+), 1 deletion(-)
> 
> diff --git a/path.c b/path.c
> index e3da1f3c4e..5ff64e7a8a 100644
> --- a/path.c
> +++ b/path.c
> @@ -349,10 +349,16 @@ static int check_common(const char *unmatched, void *value, void *baton)
>  static void update_common_dir(struct strbuf *buf, int git_dir_len,
>  			      const char *common_dir)
>  {
> -	char *base = buf->buf + git_dir_len;
> +	char *base = buf->buf + git_dir_len, *base2 = NULL;
> +
> +	if (ends_with(base, ".lock"))
> +		base = base2 = xstrndup(base, strlen(base) - 5);

Hm, this adds the magic number 5 and calls strlen(base) twice, because
ends_with() calls strip_suffix(), which calls strlen().  Calling
strip_suffix() directly would allow us to avoid the magic number and
the second strlen():

  size_t len;
  if (strip_suffix(base, ".lock", &len))
          base = base2 = xstrndup(base, len);

>  	init_common_trie();
>  	if (trie_find(&common_trie, base, check_common, NULL) > 0)
>  		replace_dir(buf, git_dir_len, common_dir);
> +
> +	free(base2);
>  }
>  
>  void report_linked_checkout_garbage(void)
> diff --git a/t/t1500-rev-parse.sh b/t/t1500-rev-parse.sh
> index 01abee533d..d318a1eeef 100755
> --- a/t/t1500-rev-parse.sh
> +++ b/t/t1500-rev-parse.sh
> @@ -116,6 +116,21 @@ test_expect_success 'git-path inside sub-dir' '
>  	test_cmp expect actual
>  '
>  
> +test_expect_success 'git-path in worktree' '
> +	test_tick &&
> +	git commit --allow-empty -m empty &&
> +	git worktree add --detach wt &&
> +	test_write_lines >expect \
> +		"$(pwd)/.git/worktrees/wt/logs/HEAD" \
> +		"$(pwd)/.git/worktrees/wt/logs/HEAD.lock" \
> +		"$(pwd)/.git/worktrees/wt/index" \
> +		"$(pwd)/.git/worktrees/wt/index.lock" &&
> +	git -C wt rev-parse >actual \
> +		--git-path logs/HEAD --git-path logs/HEAD.lock \
> +		--git-path index --git-path index.lock &&
> +	test_cmp expect actual
> +'

I think this test better fits into 't0060-path-utils.sh': it already
checks 'logs/HEAD' and 'index' in a different working tree (well, with
GIT_COMMON_DIR set, but that's the same), and it has a helper function
to make each of the two new .lock tests a one-liner.

>  test_expect_success 'rev-parse --is-shallow-repository in shallow repo' '
>  	test_commit test_commit &&
>  	echo true >expect &&
> -- 
> gitgitgadget
