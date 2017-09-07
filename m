Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C79DC20286
	for <e@80x24.org>; Thu,  7 Sep 2017 19:06:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753640AbdIGTGM (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Sep 2017 15:06:12 -0400
Received: from mail-pf0-f182.google.com ([209.85.192.182]:34986 "EHLO
        mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751829AbdIGTGL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Sep 2017 15:06:11 -0400
Received: by mail-pf0-f182.google.com with SMTP id g13so892254pfm.2
        for <git@vger.kernel.org>; Thu, 07 Sep 2017 12:06:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=TwmTrHt/vAq/hfUsp65G9d7uxVr+b+Zh9x4lFULyh3w=;
        b=SDrn0dK4H6+jjyp6CtF1FBDZMfWEuj18kCxPMAZA7KSBo167j5U+0Q8iKxmXk0SQ6e
         TC0x1C1YzZF80P6a0UcvyDiqgKxb2o17coOniRias6ODiIWUo+IRWc0zd4Gn6c5DXO/O
         dOxj/gkKCnQ18ZOEEfwJ3I0h6p81JirHb84F2Kp9iKtTbO//Uz2K09XB86NQzEMWxqdq
         GqWewaFe2lGXOt1YyfkkJXA7gJ5K7hTKErBea9w12s74bdVfxwKOAs+jVoAh2a9w2+ra
         T3vwrLFhks20CEgSeLf9pvHVAZY5OITGfwvgUdjcxJyVSblK5eeEQhh20CzpQ/0nFICS
         qNzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TwmTrHt/vAq/hfUsp65G9d7uxVr+b+Zh9x4lFULyh3w=;
        b=CzXQXKfhgzjxTjhPrtYo+A5t7rLnS4EvTg68gcAD/dpBEA5sArSiBxD/ciwIV6adhT
         7nfqrf158v05LC3+Og8xq22URxFJ8ZqNRY/CPjYzBkY/Bm8Mx47AXD2Vkofq5bd7RenT
         ++IL90w/CqRxjeYpQ16k8/rpwMIfocKtQ/XA1ysqufNBQ/Kybaot3zVWvHx441ylOeTg
         nXOvRu9ZQTSdJyAjhDrTsWCe/sk9lB9MglDUQLQc7jT/tfrwuj8TMkLT9t5o+8r+s1G5
         qMTdgvxp+w95h0duZ9hC9yYXOH546TJ45D5tf3OcfQtJTI9F5x/cadifj57cKPGSdhql
         QYXQ==
X-Gm-Message-State: AHPjjUhlwQD9NA7A1rMQTyfUhwijYuegHjcwCtQtu1hO638Rp6lQzjlA
        360pa61hihD+O6+vbRnxlQ==
X-Google-Smtp-Source: ADKCNb6B/arLnpzrTlJ7m7nOQk44QYjOzEaaC3HeXKdHcIkOD36T9wJrP1tPZ8J/Wz8QSkbnzpHW0Q==
X-Received: by 10.84.194.3 with SMTP id g3mr428834pld.246.1504811170949;
        Thu, 07 Sep 2017 12:06:10 -0700 (PDT)
Received: from google.com ([2620:0:100e:402:d455:1462:371d:b69c])
        by smtp.gmail.com with ESMTPSA id v2sm303211pgo.38.2017.09.07.12.06.09
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 07 Sep 2017 12:06:10 -0700 (PDT)
Date:   Thu, 7 Sep 2017 12:06:08 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 09/10] set_git_dir: handle feeding gitdir to itself
Message-ID: <20170907190608.GA59643@google.com>
References: <20170905130149.agc3zp3s6i6e5aki@sigill.intra.peff.net>
 <20170905130501.xwc2ud2pwpbhqsli@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170905130501.xwc2ud2pwpbhqsli@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 09/05, Jeff King wrote:
> Ideally we'd free the existing gitdir field before assigning
> the new one, to avoid a memory leak. But we can't do so
> safely because some callers do the equivalent of:
> 
>   set_git_dir(get_git_dir());
> 
> We can detect that case as a noop, but there are even more
> complicated cases like:
> 
>   set_git_dir(remove_leading_path(worktree, get_git_dir());
> 
> where we really do need to do some work, but the original
> string must remain valid.
> 
> Rather than put the burden on callers to make a copy of the
> string (only to free it later, since we'll make a copy of it
> ourselves), let's solve the problem inside set_git_dir(). We
> can make a copy of the pointer for the old gitdir, and then
> avoid freeing it until after we've made our new copy.
> 

This patch and the one before it look good to me.  Thanks for fixing
this issue!

> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  repository.c | 10 +++-------
>  setup.c      |  5 -----
>  2 files changed, 3 insertions(+), 12 deletions(-)
> 
> diff --git a/repository.c b/repository.c
> index 52f1821c6b..97c732bd48 100644
> --- a/repository.c
> +++ b/repository.c
> @@ -56,16 +56,12 @@ static void repo_setup_env(struct repository *repo)
>  void repo_set_gitdir(struct repository *repo, const char *path)
>  {
>  	const char *gitfile = read_gitfile(path);
> +	char *old_gitdir = repo->gitdir;
>  
> -	/*
> -	 * NEEDSWORK: Eventually we want to be able to free gitdir and the rest
> -	 * of the environment before reinitializing it again, but we have some
> -	 * crazy code paths where we try to set gitdir with the current gitdir
> -	 * and we don't want to free gitdir before copying the passed in value.
> -	 */
>  	repo->gitdir = xstrdup(gitfile ? gitfile : path);
> -
>  	repo_setup_env(repo);
> +
> +	free(old_gitdir);
>  }
>  
>  /*
> diff --git a/setup.c b/setup.c
> index 23950173fc..6d8380acd2 100644
> --- a/setup.c
> +++ b/setup.c
> @@ -399,11 +399,6 @@ void setup_work_tree(void)
>  	if (getenv(GIT_WORK_TREE_ENVIRONMENT))
>  		setenv(GIT_WORK_TREE_ENVIRONMENT, ".", 1);
>  
> -	/*
> -	 * NEEDSWORK: this call can essentially be set_git_dir(get_git_dir())
> -	 * which can cause some problems when trying to free the old value of
> -	 * gitdir.
> -	 */
>  	set_git_dir(remove_leading_path(git_dir, work_tree));
>  	initialized = 1;
>  }
> -- 
> 2.14.1.721.gc5bc1565f1
> 

-- 
Brandon Williams
