Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 863131F463
	for <e@80x24.org>; Mon, 30 Sep 2019 22:31:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726784AbfI3WbL (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Sep 2019 18:31:11 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:38383 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726103AbfI3WbK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Sep 2019 18:31:10 -0400
Received: by mail-pg1-f194.google.com with SMTP id x10so8170232pgi.5
        for <git@vger.kernel.org>; Mon, 30 Sep 2019 15:31:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=iOXBcr4jAhRQgotFpqjpGZfGHjtxS6artB8lA9X6dcs=;
        b=mo7dJnbexhT5eg/0p5y+bYmOYy9aX5yNqN2gtpfyiXWMs8Yq/527+KJpps0kEf5GBT
         budSWJF5/ItdxO/9/jo49mi2u/n1sANG4Mej5bWNNym+5aLBJg90Hri/juOXCF9IpZLH
         GXlzXGUEds1l+TzmWAjCZX4nOByZ2kP+oMjB+iSgHbRjrWDgN8ODpe1wPSHpMafoXszo
         kozq5Q7mhRI+ZF/KJmlRrEth/CWANwLJDHijOKYFqz9QmBn97OLkHMjZGogrt+zu6ctN
         IqFU+JOcuxjtLvtpczD4n3lbXtNDEDas8rFldkpzZ0oCSQEYSeIijEMB8SOPy5mCrfib
         bV4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=iOXBcr4jAhRQgotFpqjpGZfGHjtxS6artB8lA9X6dcs=;
        b=lMunNa0NVaTRfAGCgI1Oxnnxns8dr4NGM7Ag8QXuDdSZ7yNNLQLtmTfo/nzEwIy5Ev
         xtQKa8fhEEKn1DIm+0T4wOj6ItVmfSHFCMXt5PhWTDrLzorua1/uGYFyjSpXEkBt+vZj
         zA9bjDQu48AHN2kKhWUoeEdxl3ZlzY0RPvHWpn24VM8oh51fRq+nWFLbY4mRITRnRlT3
         8hdtzvKxrjQXA5DZfQrbwnngLv4rzdvLJKxqeueXUmzOfqE853ilvXFVw2FUinklkoSq
         RsR5zWcEN2yIf7VuBMcAND+MAbMSaFSv2FeZ7BIJmmgFQFpF91oFe463G56DYNjqHOMq
         J7/A==
X-Gm-Message-State: APjAAAXlroSAvosAh+3P66ZOgq4edf9vD87UuVc17FY+qHt9s9jo4tLE
        TSxePJ9NkNJb0ZdAiYrJNBEgBxZE
X-Google-Smtp-Source: APXvYqx1RpOLKrCsz8euLC1aK297FpQhAqQbVCdPSACIlz/eF1zU/PmcD1SFT1oU83dTAz+bkcpl7g==
X-Received: by 2002:a17:90a:28c5:: with SMTP id f63mr1714546pjd.67.1569882668939;
        Mon, 30 Sep 2019 15:31:08 -0700 (PDT)
Received: from generichostname ([204.14.239.137])
        by smtp.gmail.com with ESMTPSA id k124sm15879276pgc.6.2019.09.30.15.31.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 Sep 2019 15:31:07 -0700 (PDT)
Date:   Mon, 30 Sep 2019 15:31:05 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>
Subject: Re: [PATCH] dir: special case check for the possibility that
 pathspec is NULL
Message-ID: <20190930223105.GA86525@generichostname>
References: <20190927171034.GA6542@generichostname>
 <20190930191106.16128-1-newren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190930191106.16128-1-newren@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Elijah,

On Mon, Sep 30, 2019 at 12:11:06PM -0700, Elijah Newren wrote:
> Commits 404ebceda01c ("dir: also check directories for matching
> pathspecs", 2019-09-17) and 89a1f4aaf765 ("dir: if our pathspec might
> match files under a dir, recurse into it", 2019-09-17) added calls to
> match_pathspec() and do_match_pathspec() passing along their pathspec
> parameter.  Both match_pathspec() and do_match_pathspec() assume the
> pathspec argument they are given is non-NULL.  It turns out that
> unpack-tree.c's verify_clean_subdirectory() calls read_directory() with
> pathspec == NULL, and it is possible on case insensitive filesystems for
> that NULL to make it to these new calls to match_pathspec() and
> do_match_pathspec().  Add appropriate checks on the NULLness of pathspec
> to avoid a segfault.
> 
> In case the negation throws anyone off (one of the calls was to
> do_match_pathspec() while the other was to !match_pathspec(), yet no
> negation of the NULLness of pathspec is used), there are two ways to
> understand the differences:
>   * The code already handled the pathspec == NULL cases before this
>     series, and this series only tried to change behavior when there was
>     a pathspec, thus we only want to go into the if-block if pathspec is
>     non-NULL.
>   * One of the calls is for whether to recurse into a subdirectory, the
>     other is for after we've recursed into it for whether we want to
>     remove the subdirectory itself (i.e. the subdirectory didn't match
>     but something under it could have).  That difference in situation
>     leads to the slight differences in logic used (well, that and the
>     slightly unusual fact that we don't want empty pathspecs to remove
>     untracked directories by default).
> 
> Helped-by: Denton Liu <liu.denton@gmail.com>
> Helped-by: SZEDER Gábor <szeder.dev@gmail.com>
> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
> This patch applies on top of en/clean-nested-with-ignored, which is now
> in next.
> 
> Denton found and analyzed one issue and provided the patch for the
> match_pathspec() call, SZEDER figured out why the issue only reproduced
> for some folks and not others and provided the testcase, and I looked
> through the remainder of the series and noted the do_match_pathspec()
> call that should have the same check.

Thanks for catching what I missed.

> 
> So, I'm not sure who should be author and who should be helped-by; I
> feel like their contributions are possibly bigger than mine.  While I
> tried to reproduce and debug, they ended up doing the work, and I just
> looked through the rest of the series for similar issues and wrote up
> a commit message.  *shrug*

Eh, it doesn't really matter to me. GitHub appears to have de facto
standardised the Co-authored-by: trailer to allow credit to be split
amonst multiple authors so _maybe_ we could use that, but I'm pretty
impartial.

> 
>  dir.c                 |  8 +++++---
>  t/t0050-filesystem.sh | 23 +++++++++++++++++++++++
>  2 files changed, 28 insertions(+), 3 deletions(-)
> 
> diff --git a/dir.c b/dir.c
> index 7ff79170fc..bd39b86be4 100644
> --- a/dir.c
> +++ b/dir.c
> @@ -1962,8 +1962,9 @@ static enum path_treatment read_directory_recursive(struct dir_struct *dir,
>  			((state == path_untracked) &&
>  			 (get_dtype(cdir.de, istate, path.buf, path.len) == DT_DIR) &&
>  			 ((dir->flags & DIR_SHOW_IGNORED_TOO) ||
> -			  do_match_pathspec(istate, pathspec, path.buf, path.len,
> -					    baselen, NULL, DO_MATCH_LEADING_PATHSPEC) == MATCHED_RECURSIVELY_LEADING_PATHSPEC))) {
> +			  (pathspec &&
> +			   do_match_pathspec(istate, pathspec, path.buf, path.len,
> +					     baselen, NULL, DO_MATCH_LEADING_PATHSPEC) == MATCHED_RECURSIVELY_LEADING_PATHSPEC)))) {
>  			struct untracked_cache_dir *ud;
>  			ud = lookup_untracked(dir->untracked, untracked,
>  					      path.buf + baselen,
> @@ -1975,7 +1976,8 @@ static enum path_treatment read_directory_recursive(struct dir_struct *dir,
>  			if (subdir_state > dir_state)
>  				dir_state = subdir_state;
>  
> -			if (!match_pathspec(istate, pathspec, path.buf, path.len,
> +			if (pathspec &&
> +			    !match_pathspec(istate, pathspec, path.buf, path.len,
>  					    0 /* prefix */, NULL,
>  					    0 /* do NOT special case dirs */))
>  				state = path_none;
> diff --git a/t/t0050-filesystem.sh b/t/t0050-filesystem.sh
> index 192c94eccd..edb30f9eb2 100755
> --- a/t/t0050-filesystem.sh
> +++ b/t/t0050-filesystem.sh
> @@ -131,4 +131,27 @@ $test_unicode 'merge (silent unicode normalization)' '
>  	git merge topic
>  '
>  
> +test_expect_success CASE_INSENSITIVE_FS 'checkout with no pathspec and a case insensitive fs' '
> +	git init repo &&
> +	(
> +		cd repo &&
> +
> +		>Gitweb &&
> +		git add Gitweb &&
> +		git commit -m "add Gitweb" &&
> +
> +		git checkout --orphan todo &&
> +		git reset --hard &&
> +		# the subdir is crucial, without it there is no segfault

We should either remove this comment or change the justification. A
future reader may be confused at what particular segfault this refers
to.

> +		mkdir -p gitweb/subdir &&
> +		>gitweb/subdir/file &&
> +		# it is not strictly necessary to add and commit the
> +		# gitweb directory, its presence is sufficient

Same here, its presence is sufficient to... what?

Thanks,

Denton

> +		git add gitweb &&
> +		git commit -m "add gitweb/subdir/file" &&
> +
> +		git checkout master
> +	)
> +'
> +
>  test_done
> -- 
> 2.22.1.14.g885c22d24b
> 
