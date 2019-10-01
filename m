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
	by dcvr.yhbt.net (Postfix) with ESMTP id C422F1F4BD
	for <e@80x24.org>; Tue,  1 Oct 2019 18:41:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726114AbfJASlB (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 Oct 2019 14:41:01 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:34388 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726038AbfJASlB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Oct 2019 14:41:01 -0400
Received: by mail-pf1-f194.google.com with SMTP id b128so8695021pfa.1
        for <git@vger.kernel.org>; Tue, 01 Oct 2019 11:41:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=BqCL3DMHszq4Ty9ahmAL0fAUaLjjXOCRwT/fRfibEWE=;
        b=a3pBvQn9MeGlRVtSCeK/yN32+7H63etjTZo0P5bnx100uFZAroA7v6zMImzvIy+8Zz
         uexrkPv6wpW8cbn3EgWg0qiIVkVXAC97PBGcCdHn+Jfk4QEHi2JvpAdtAyo3pn0kXpmY
         o/6l/N49OZ/30anLrxi9dYf5BJadsnopn23O99yc7PZ7BlZgDJHKga+TIHFm/zR98FIB
         4i7QqpC5gEG5k5R1gSKu+4PqPDYpse96SjIZanQLhRFZ/r4lNsvHtOUaCXGbItRIAZ6M
         MzDEsIwmYc9AouirrOplS0phoNS56s7L2+e8g/SJ4UwHaZSKVdYmcN/4wDXDfSmsiMmU
         9lSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=BqCL3DMHszq4Ty9ahmAL0fAUaLjjXOCRwT/fRfibEWE=;
        b=CrqXerAXLY6Zw+23+N/4qjcvOHosCJU6y12oyux2105+uIuxb8l+DNjgr/i1tbYRfu
         zSdtVIdgPw5kz8QyQp8F73/yDP/mXt5m4mWKukKyHlBHa8qe7KVfTWaPlt9RybNwYCj/
         X1oeJAUfyv1PkImSnttZgzLdKrNNEG0HkJn+Y0QNQx1fu8/28hAZ0gY8iRYg9RIuaOI1
         xFUFGBLMXJmJPTKsPOicFsHImktr4WRPu47FJD+0iPM+dRZS0oEnVLuD5AGkdCRHkru8
         KpYiKy3+llGPYekppoQsWpNAMil4KmWqSiMOf6iqLfg17XlCD6n+sVHiu4WKExnTEX+g
         3p4Q==
X-Gm-Message-State: APjAAAVvbqrPrx7Ja4G1geW81svJG4gQvl4vQUB0pRWoeZQtpexs/Y9r
        OwI9Ocr0yxtL6MiV1/coj5w=
X-Google-Smtp-Source: APXvYqyaMgh7obs10uar2tcKz35K0yYSu+maw8WmlIgy6dr2VDk7Bj90l5CXYOvzZT7vecHGcZEFxg==
X-Received: by 2002:a63:8e42:: with SMTP id k63mr32110846pge.114.1569955259805;
        Tue, 01 Oct 2019 11:40:59 -0700 (PDT)
Received: from generichostname ([204.14.239.53])
        by smtp.gmail.com with ESMTPSA id l7sm3507207pjy.12.2019.10.01.11.40.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2019 11:40:51 -0700 (PDT)
Date:   Tue, 1 Oct 2019 11:40:49 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>
Subject: Re: [PATCH v2] dir: special case check for the possibility that
 pathspec is NULL
Message-ID: <20191001184049.GA30113@generichostname>
References: <20190930191106.16128-1-newren@gmail.com>
 <20191001183005.16977-1-newren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191001183005.16977-1-newren@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Elijah,

On Tue, Oct 01, 2019 at 11:30:05AM -0700, Elijah Newren wrote:

[...]

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
> index 192c94eccd..a840919967 100755
> --- a/t/t0050-filesystem.sh
> +++ b/t/t0050-filesystem.sh
> @@ -131,4 +131,25 @@ $test_unicode 'merge (silent unicode normalization)' '
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
> +		mkdir -p gitweb/subdir &&
> +		>gitweb/subdir/file &&
> +		# it is not strictly necessary to add and commit the

Probably not worth a reroll but we're missing "gitweb directory" at the
end of the comment. Other than that, it looks good to me.

Thanks again for the prompt fix,

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
> 2.23.0.25.g3f4444bfd7.dirty
> 
