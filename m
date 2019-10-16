Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 656F31F4C0
	for <e@80x24.org>; Wed, 16 Oct 2019 11:04:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404854AbfJPLEq (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 Oct 2019 07:04:46 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:38521 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726083AbfJPLEp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Oct 2019 07:04:45 -0400
Received: by mail-wm1-f68.google.com with SMTP id 3so2276630wmi.3
        for <git@vger.kernel.org>; Wed, 16 Oct 2019 04:04:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=EdPcsJVYci8TVrRez2lYTdFtNG75TIrksnd79jsgpuo=;
        b=UtAkMmjwIlPuUn2EVDg/xXD2Kd9T/na7m2YPuhBWrK5bkHrVqkEKKjcSwOc1HYBQLB
         XnfrAzG2HefI4wUQb3UwAMKa2MIKOa7igq/A1k3l4Dqso4D1kuIxN/rfJZKHCqIavnYG
         pjZdB6kS+PYi6Kf5/OIja/SpsZRvzE2WD28UVvFIuW1mtvgHulamF3nUS3EavUjSxlqi
         uVSOT4Aiv7F8Di7vbvZvTOBDvc0Iougjn8WY+Us/Ai6maUlucXKEFAoqeOTqzlaxP6dS
         L9+pDco3B5OyMA1wu+y8aDpk8/oVbNTKhM4E4IZEM3mMTPRv+qROE4pKmZXEdqMi47ga
         vmuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=EdPcsJVYci8TVrRez2lYTdFtNG75TIrksnd79jsgpuo=;
        b=tWyedoLr8F/37j9S1jmbgNhe8gCWaUiJBmbOKfoO+Ha64yqyPrOuggRewKN2sl2dMh
         bm2kvvQdWGcvmKAxTrfR69K4S+T/t0+uOgmB8SyfSN/DJTGW2OpZAquB3846Y1/ZkCKv
         47Nc5in1uTTUTHUT+FPjJ+Qxex9YJP5DOLiayP5/8+NB5AVazVR2VMmTTnRfCMt2YhPH
         wEVP3unDOuqcSaE2YiGDUCRj+1y3r9DwhdTkbyfKBqE5sxRsbidU7nmqqWgEw5qmiH0d
         0zcamx4jn/ql+vSzEfbnhBy1jbrGM4WVZdlTYU8aBOlBlYu29KhQ7TLiMfKETkJn5hk3
         ZHlQ==
X-Gm-Message-State: APjAAAWLSRO5EhxZ9SR5RvB7niYNxgx60yp2eKVzDsJu9UBWdUKdfpHD
        3+0wxC2CZud8/n82J38k1MY=
X-Google-Smtp-Source: APXvYqz3IRxadFauQ29QkyXqmLCkardkK2eARA3xFI9+MIG/Ixut3ajza9/N3tdTWd/0t2ybSS5fRg==
X-Received: by 2002:a1c:e455:: with SMTP id b82mr2867027wmh.41.1571223883285;
        Wed, 16 Oct 2019 04:04:43 -0700 (PDT)
Received: from szeder.dev (x4d0c5ad0.dyn.telefonica.de. [77.12.90.208])
        by smtp.gmail.com with ESMTPSA id v11sm2072583wml.30.2019.10.16.04.04.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Oct 2019 04:04:42 -0700 (PDT)
Date:   Wed, 16 Oct 2019 13:04:40 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] git_path(): handle `.lock` files correctly
Message-ID: <20191016110440.GV29845@szeder.dev>
References: <pull.401.git.1571209637.gitgitgadget@gmail.com>
 <f08c90ea02f6811b310a01301acf46da133f38a9.1571209637.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f08c90ea02f6811b310a01301acf46da133f38a9.1571209637.git.gitgitgadget@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 16, 2019 at 07:07:17AM +0000, Johannes Schindelin via GitGitGadget wrote:
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
> 
> Ever since worktrees were introduced, the `git_path()` function _really_
> needed to be called e.g. to get at the `index`. However, the wrong path
> is returned for `index.lock`.

Could you give an example where it returns the wrong path for
'index.lock'?  I tried to reproduce this issue in a working tree, but
no matter what I've tried, 'git rev-parse --git-dir index.lock' always
returned the right path.

> This does not matter as long as the Git executable is doing the asking,
> as the path for that `index.lock` file is constructed from
> `git_path("index")` by appending the `.lock` suffix.
> 
> However, Git GUI just learned to use `--git-path` instead of appending
> relative paths to what `git rev-parse --git-dir` returns (and as a
> consequence not only using the correct hooks directory, but also using
> the correct paths in worktrees other than the main one). And one of the
> paths it is looking for is... you guessed it... `index.lock`.
> 
> So let's make that work as script writers would expect it to.
> 
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  path.c               |  4 ++--
>  t/t1500-rev-parse.sh | 15 +++++++++++++++
>  2 files changed, 17 insertions(+), 2 deletions(-)
> 
> diff --git a/path.c b/path.c
> index e3da1f3c4e..ff85692b45 100644
> --- a/path.c
> +++ b/path.c
> @@ -268,7 +268,7 @@ static int trie_find(struct trie *root, const char *key, match_fn fn,
>  	int result;
>  	struct trie *child;
>  
> -	if (!*key) {
> +	if (!*key || !strcmp(key, ".lock")) {
>  		/* we have reached the end of the key */
>  		if (root->value && !root->len)
>  			return fn(key, root->value, baton);
> @@ -288,7 +288,7 @@ static int trie_find(struct trie *root, const char *key, match_fn fn,
>  
>  	/* Matched the entire compressed section */
>  	key += i;
> -	if (!*key)
> +	if (!*key || !strcmp(key, ".lock"))
>  		/* End of key */
>  		return fn(key, root->value, baton);
>  
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

Without the fix applied this test fails with:

  + test_cmp expect actual
  --- expect      2019-10-16 10:20:31.047229423 +0000
  +++ actual      2019-10-16 10:20:31.051229519 +0000
  @@ -1,4 +1,4 @@
   /home/szeder/src/git/t/trash directory.t1500-rev-parse/.git/worktrees/wt/logs/HEAD
  -/home/szeder/src/git/t/trash directory.t1500-rev-parse/.git/worktrees/wt/logs/HEAD.lock
  +/home/szeder/src/git/t/trash directory.t1500-rev-parse/.git/logs/HEAD.lock
   /home/szeder/src/git/t/trash directory.t1500-rev-parse/.git/worktrees/wt/index
   /home/szeder/src/git/t/trash directory.t1500-rev-parse/.git/worktrees/wt/index.lock
  error: last command exited with $?=1

So the path of 'index.lock' seems to be fine already, it's the path of
the lockfile for HEAD's reflog that's indeed wrong and makes the test
fail.

On a related note, I'm not sure whether the path of the reflogs
directory is right while in a different working tree...  Both with and
without this patch I get a path pointing to the main working tree:

  $ ./git -C WT/ rev-parse --git-path logs
  /home/szeder/src/git/.git/logs

However, I'm not sure what the right path should be in the first
place, given that each working tree has its own 'logs' directory, but
only for HEAD's reflog, while everything else goes to the main working
tree's 'logs' directory.

> +'
> +
>  test_expect_success 'rev-parse --is-shallow-repository in shallow repo' '
>  	test_commit test_commit &&
>  	echo true >expect &&
> -- 
> gitgitgadget
