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
	by dcvr.yhbt.net (Postfix) with ESMTP id 73B701F453
	for <e@80x24.org>; Sat, 19 Jan 2019 00:52:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727178AbfASAwI (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Jan 2019 19:52:08 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:53907 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726033AbfASAwI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Jan 2019 19:52:08 -0500
Received: by mail-wm1-f65.google.com with SMTP id d15so6076565wmb.3
        for <git@vger.kernel.org>; Fri, 18 Jan 2019 16:52:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=HQNvYHfMJ0LYkFmuNkE5z8pnzeZ7OdKsfugtWKKbqCE=;
        b=ru3wMrhSt+KTkonyQo16L+sXuFwyXwO0qOAkW7x0RbBuJH2cyKewTaVlCK2UqUQpDv
         AQKFM2G2/DCAMbYMb5NugtELi5Vutxv0WuhiGVNV5l9Lme+cZ2kTA4Bb/GgVh24llFFL
         DoZi1tXHIZOlq+SqDUaT5X4BsxEsoXDeIUdncMLiSn9AXlFWIv53um8Asng9Sma+Vv0w
         cEzFiYnfoYI2VZPFQlCRchQAIVj22+iwgfG88drf1UK2YzXYmiIqYeY5WBj81BNSPQlx
         Do/H82kzvRr6cH3I+jM64ezfoDgDM/1USVt3wGNe7tQcEm3AFXpuz+mavV8bgCecChyl
         1kbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HQNvYHfMJ0LYkFmuNkE5z8pnzeZ7OdKsfugtWKKbqCE=;
        b=g2rem6FuJkc6xcVcrWsYxrCrUDa9Vp7Vu46t01hztPXQbx7rshOVWnGRiWJ2eyAYBx
         YchQwSGn10G4Nj/VZVUQFSIOO8z9EMszM5gVVYkooVoLuU8Kj/ZTtzBAfw/XV4DH8s29
         Ma0PFwQiKhFgi8qIz55wkf3HbYZcgTFpNufbniUDKGv3Aa24RkSCydN4PDb3RvfNC159
         YYnMjrnUeUw006wa/1uy9hVehtbHWxnsTnf8+d3zWrWXAYykT3VFDfQ6zx3r6Yxi3k7q
         5UmdCowayNrM3Fc+TKgbBUOuFxRm+NvPwaHt2RDZLNo7N7lAbuUvzn8HtkgVboYBLQZ5
         Ro8A==
X-Gm-Message-State: AJcUuke0PP4syzw7RGBnSXWzYjT+/3GcEN63fXJPQyN2ykmh2YkJ05He
        b0Ssn7YitbmNQUL8YCZe/m0=
X-Google-Smtp-Source: ALg8bN48Tn9fbm4j6mLA/bp95bkH1SQH/Gcsb7ocvfaYKMzdEwhWI3006/+tks+dX5wCnoQJJCA4Sg==
X-Received: by 2002:a1c:68d7:: with SMTP id d206mr16669948wmc.43.1547859125910;
        Fri, 18 Jan 2019 16:52:05 -0800 (PST)
Received: from szeder.dev (x4dbd9ead.dyn.telefonica.de. [77.189.158.173])
        by smtp.gmail.com with ESMTPSA id c13sm95321054wrb.38.2019.01.18.16.52.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Jan 2019 16:52:04 -0800 (PST)
Date:   Sat, 19 Jan 2019 01:52:02 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Ben Peart <peartben@gmail.com>
Cc:     git@vger.kernel.org, benpeart@microsoft.com, asottile@umich.edu,
        pclouds@gmail.com, gitster@pobox.com
Subject: Re: [PATCH v1 2/2] checkout: fix regression in checkout -b on
 intitial checkout
Message-ID: <20190119005202.GO840@szeder.dev>
References: <CA+dzEB=DH0irkFaRzkKERSjdZ=EJ+mG3Ri2Xeobx9Yu_eDd+jg@mail.gmail.com>
 <20190118185558.17688-1-peartben@gmail.com>
 <20190118185558.17688-3-peartben@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190118185558.17688-3-peartben@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 18, 2019 at 01:55:58PM -0500, Ben Peart wrote:
> From: Ben Peart <benpeart@microsoft.com>
> 
> When doing a 'checkout -b' do a full checkout including updating the working
> tree when doing the initial checkout.  This fixes the regression in behavior
> caused by fa655d8411 checkout: optimize "git checkout -b <new_branch>"
> 
> Signed-off-by: Ben Peart <benpeart@microsoft.com>
> ---
>  builtin/checkout.c         | 6 ++++++
>  t/t2018-checkout-branch.sh | 2 +-
>  2 files changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/builtin/checkout.c b/builtin/checkout.c
> index 6fadf412e8..af6b5c8336 100644
> --- a/builtin/checkout.c
> +++ b/builtin/checkout.c
> @@ -517,6 +517,12 @@ static int skip_merge_working_tree(const struct checkout_opts *opts,
>  	if (core_apply_sparse_checkout && !checkout_optimize_new_branch)
>  		return 0;
>  
> +	/*
> +	 * We must do the merge if this is the initial checkout
> +	 */
> +	if (is_cache_unborn())
> +		return 0;
> +
>  	/*
>  	 * We must do the merge if we are actually moving to a new commit.
>  	 */

This patch breaks 'checkout -b checkout.optimizeNewBranch interaction'
in 't1090-sparse-checkout-scope.sh':

  + cp .git/info/sparse-checkout .git/info/sparse-checkout.bak
  + test_when_finished
                  mv -f .git/info/sparse-checkout.bak .git/info/sparse-checkout
                  git checkout master
  
  + test 0 = 0
  + test_cleanup={
                  mv -f .git/info/sparse-checkout.bak .git/info/sparse-checkout
                  git checkout master
  
                  } && (exit "$eval_ret"); eval_ret=$?; :
  + echo /b
  + git ls-files -t b
  + test S b = S b
  + git -c checkout.optimizeNewBranch=true checkout -b fast
  Switched to a new branch 'fast'
  + git ls-files -t b
  + test H b = S b
  error: last command exited with $?=1
  not ok 4 - checkout -b checkout.optimizeNewBranch interaction


