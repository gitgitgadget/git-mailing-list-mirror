Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 07D9F1F8CF
	for <e@80x24.org>; Fri,  9 Jun 2017 16:50:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751732AbdFIQuw (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Jun 2017 12:50:52 -0400
Received: from mail-pg0-f50.google.com ([74.125.83.50]:33843 "EHLO
        mail-pg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751626AbdFIQuv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Jun 2017 12:50:51 -0400
Received: by mail-pg0-f50.google.com with SMTP id v18so28283185pgb.1
        for <git@vger.kernel.org>; Fri, 09 Jun 2017 09:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9kSrfaRd20GjIsnirTkXCSfobMdCeZSH/GsOF1tOWno=;
        b=sBQUM5k5diTV1pLNgE2DCZeIAzXlJScpIJjtVcfTLju+5OSE/iAC3YNWASRK270vMh
         L6mzh6D7864ycsgk2pclM/MdBjqRBXEU+EjPudA6Qy4xAEi935B/ncKQlVO/LS3e8QlL
         Ja1c5wSuBpMSSSk0i6r/2C8TGp5/MCx412WOkutUcLMYnZnwidGGRlQJIgOYCXZrS918
         Han0ylWBP5awR8UphUoljFlVFJ3xMpe34e5tv1xibHjR2ML4wIsVbSwB96ntt8BpFFtV
         NwJQOreDhmASXe64kQozpYEazBsSOaF2xFSo9K0m6jObg8g1W0HwFEur7jlKd4zCeDo2
         nphw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9kSrfaRd20GjIsnirTkXCSfobMdCeZSH/GsOF1tOWno=;
        b=lfj9dOeMVA+BqRTkGblOymnh+EGDfBWg6UXS1Dx9Fg51SroRco4nbwtcKCF5UrqkLt
         Y+hpNFr2pVqUQJ7Um73AokggVPojGRitU7QtK0M2JdxbtKnKJrJHs8IcePUes0Zz4YZZ
         G9UFmZzVKLruJhcZniJCyudLsLIUjWQPAZDgdXF0lTMFBxX9+yuHLmGsBCGmV6UtGczn
         +P3JSyDSWSljLBAYq7mWDRrz5wb/zZApAiasuPYGoHlITzwjD2cx6TuPNvxMm77goBqr
         Gn6/us70B9vPWQTNwZTuqcJABBN2Mbu8X1kWwU/ADLEod5UEaiCXGmiVAxabj62ukmRK
         YXBw==
X-Gm-Message-State: AODbwcCiEm2j0h9YvOl51EHULGtYRUBvUsWC6495ankyn6aHrhVgRSX6
        lMtLMjeCHB2l5wcRE1BJZg==
X-Received: by 10.98.160.220 with SMTP id p89mr28476982pfl.184.1497027050781;
        Fri, 09 Jun 2017 09:50:50 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:95c0:15a:33cb:7a91])
        by smtp.gmail.com with ESMTPSA id f1sm3402444pgc.8.2017.06.09.09.50.49
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 09 Jun 2017 09:50:49 -0700 (PDT)
Date:   Fri, 9 Jun 2017 09:50:48 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Emily Xie <emilyxxie@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, novalis@novalis.org
Subject: Re: [PATCH] pathspec: die on empty strings as pathspec
Message-ID: <20170609165048.GC81269@google.com>
References: <20170607033308.33550-1-emilyxxie@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170607033308.33550-1-emilyxxie@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 06/06, Emily Xie wrote:
> An empty string as a pathspec element matches all paths.  A buggy
> script, however, could accidentally assign an empty string to a
> variable that then gets passed to a Git command invocation, e.g.:
> 
>   path=... compute a path to be removed in $path ...
>         git rm -r "$path"
> 
> which would unintentionally remove all paths in the current
> directory.
> 
> The fix for this issue comprises of two steps. Step 1, which warns
> that empty strings as pathspecs will become invalid, has already
> been implemented in commit d426430 ("pathspec: warn on empty strings
> as pathspec", 2016-06-22).
> 
> This patch is step 2. It removes the warning and throws an error
> instead.
> 
> Signed-off-by: Emily Xie <emilyxxie@gmail.com>
> Reported-by: David Turner <novalis@novalis.org>
> ---
>  pathspec.c     | 10 ++++------
>  t/t3600-rm.sh  |  5 ++---
>  t/t3700-add.sh |  5 ++---
>  3 files changed, 8 insertions(+), 12 deletions(-)
> 
> diff --git a/pathspec.c b/pathspec.c
> index 50f76ff..65e18b1 100644
> --- a/pathspec.c
> +++ b/pathspec.c
> @@ -605,7 +605,7 @@ void parse_pathspec(struct pathspec *pathspec,
>  {
>  	struct pathspec_item *item;
>  	const char *entry = argv ? *argv : NULL;
> -	int i, n, prefixlen, warn_empty_string, nr_exclude = 0;
> +	int i, n, prefixlen, nr_exclude = 0;
>  
>  	memset(pathspec, 0, sizeof(*pathspec));
>  
> @@ -638,12 +638,10 @@ void parse_pathspec(struct pathspec *pathspec,
>  	}
>  
>  	n = 0;
> -	warn_empty_string = 1;
>  	while (argv[n]) {
> -		if (*argv[n] == '\0' && warn_empty_string) {
> -			warning(_("empty strings as pathspecs will be made invalid in upcoming releases. "
> -				  "please use . instead if you meant to match all paths"));
> -			warn_empty_string = 0;
> +		if (*argv[n] == '\0') {
> +			die("empty string is not a valid pathspec. "
> +				  "please use . instead if you meant to match all paths");

The spacing (indentation) of the second line here is really weird.

>  		}
>  		n++;
>  	}
> diff --git a/t/t3600-rm.sh b/t/t3600-rm.sh
> index 5f9913b..c787eac 100755
> --- a/t/t3600-rm.sh
> +++ b/t/t3600-rm.sh
> @@ -858,9 +858,8 @@ test_expect_success 'rm files with two different errors' '
>  	test_i18ncmp expect actual
>  '
>  
> -test_expect_success 'rm empty string should invoke warning' '
> -	git rm -rf "" 2>output &&
> -	test_i18ngrep "warning: empty strings" output
> +test_expect_success 'rm empty string should fail' '
> +	test_must_fail git rm -rf ""
>  '
>  
>  test_done
> diff --git a/t/t3700-add.sh b/t/t3700-add.sh
> index f3a4b4a..40a0d2b 100755
> --- a/t/t3700-add.sh
> +++ b/t/t3700-add.sh
> @@ -331,9 +331,8 @@ test_expect_success 'git add --dry-run --ignore-missing of non-existing file out
>  	test_i18ncmp expect.err actual.err
>  '
>  
> -test_expect_success 'git add empty string should invoke warning' '
> -	git add "" 2>output &&
> -	test_i18ngrep "warning: empty strings" output
> +test_expect_success 'git add empty string should fail' '
> +	test_must_fail git add ""
>  '
>  
>  test_expect_success 'git add --chmod=[+-]x stages correctly' '
> -- 
> 2.8.4
> 

-- 
Brandon Williams
