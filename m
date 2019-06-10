Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E26A21F462
	for <e@80x24.org>; Mon, 10 Jun 2019 12:26:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389573AbfFJM0k (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Jun 2019 08:26:40 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37146 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389001AbfFJM0k (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Jun 2019 08:26:40 -0400
Received: by mail-wr1-f65.google.com with SMTP id v14so8973533wrr.4
        for <git@vger.kernel.org>; Mon, 10 Jun 2019 05:26:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hju3UN9jRxJqYtlJ3vjLWrD0nhX89mb95JWlYMsTSFk=;
        b=OpQ6QQ+fFYWBSIBeicKBG+Y20v+NMnw9oe1WwtdN15Gh/rNFPryowl3xJq2NdRd4+I
         pFV+osfB/18Smwyz5MbAjLmvd3o5VPu0xR+aiL4YZPf0ntM46B3/j1rEG7zMmS+bvwFZ
         t/eExWUbBzJE1WdN6SQEoZODfGagGzWJSO7NvxRbUZa/1SrOFQIYpCegBU+FiMvkecPM
         0BeR95gP9TMPv5L+YvdlVkR9DaKC72QRwRfU2MTSkZqVJFY3iwb2iGXOYVJY7NMnlQTG
         HMeEyJhgIKuMoLSeaWgCVMDrPngUPuwX+39cP7LR5C5EkW5L8S4W5Z7TJNViv7aUDosW
         ZiIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hju3UN9jRxJqYtlJ3vjLWrD0nhX89mb95JWlYMsTSFk=;
        b=SC10l+TS0kOf5Zem8emNfiQCVGoEpS21wi55e0DB0WlmwEImZb7dsyczV47GMTScaa
         kPaTDoPa6vckW3YskeE3dPbeVBpbDQRDTUnSm8wClswEXAllf9YVXpqHzdlqlDNzrawg
         6I2msr4q3NATyqewq9zOai2D9vGGl5GX6PE9ct2KYPkRpgfSvSiQ66qyqMc1uG3GQeCt
         GZCVnQVy5XiZtGlKCInZMcWZ5ub9TQTNQ3gVeDM/pgoYXZXCK+rBcL8x8op1XD9rMecl
         yVS58acvkFUaieUjf8PhIr7hez4oHsoQFUqWDNJN5Bu/jW6TQW/qD4YMt8UR6egQy/3Z
         dR7g==
X-Gm-Message-State: APjAAAULmKy1DEeLSTdqoIUC4yiWwbcetTMaxtkK0jlN5bAljUKSkYr0
        +yD3k4o4Avw2A3rfAuYXrCqdVnc8
X-Google-Smtp-Source: APXvYqxSGnCd8yFiHwYSLa+SAnE7SJcH3p2KavTKgU29rOqfqNRIgWumSoxP+SK6VFNww90rHB25PQ==
X-Received: by 2002:adf:a749:: with SMTP id e9mr45612387wrd.64.1560169598627;
        Mon, 10 Jun 2019 05:26:38 -0700 (PDT)
Received: from szeder.dev (x4d0c1d42.dyn.telefonica.de. [77.12.29.66])
        by smtp.gmail.com with ESMTPSA id v67sm11479040wme.24.2019.06.10.05.26.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Jun 2019 05:26:37 -0700 (PDT)
Date:   Mon, 10 Jun 2019 14:26:33 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH 1/1] diffcore-rename: speed up register_rename_src
Message-ID: <20190610122632.GA4012@szeder.dev>
References: <pull.142.git.gitgitgadget@gmail.com>
 <4ac75dd3635e39f9faa67fb1e88897663e3dc6cd.1560004960.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4ac75dd3635e39f9faa67fb1e88897663e3dc6cd.1560004960.git.gitgitgadget@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jun 08, 2019 at 07:42:42AM -0700, Jeff Hostetler via GitGitGadget wrote:
> From: Jeff Hostetler <jeffhost@microsoft.com>
> 
> Teach register_rename_src() to see if new file pair
> can simply be appended to the rename_src[] array before
> performing the binary search to find the proper insertion
> point.
> 
> This is a performance optimization.  This routine is called
> during run_diff_files in status and the caller is iterating
> over the sorted index, so we should expect to be able to
> append in the normal case.  The existing insert logic is
> preserved so we don't have to assume that, but simply take
> advantage of it if possible.

Could you add a command and performance figures to the commit message
to show off the benefits of this patch?

From the description it's clear that it's a performance optimization,
but it's unclear whether it has a noticeable, or at least measurable
effect, or it's "only" a micro-optimization.

I tried something more substantial than a simple 'git status':

  # without this patch
  $ time perf record -g ./git log --oneline -m --name-only v2.20.0 >/dev/null
  [ ... ]
  
  real    2m4.320s
  user    2m0.913s
  sys     0m2.284s
  $ perf report -g none |grep -E '(diffcore_rename|register_rename_src)'
      52.40%     0.79%  git      git                 [.] diffcore_rename
       0.01%     0.01%  git      git                 [.] register_rename_src

but it looks like that while more than half of the considerable
runtime is spent detecting renames, the time spent in
register_rename_src(), the function optimized in this patch, is
negligible.


> Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  diffcore-rename.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/diffcore-rename.c b/diffcore-rename.c
> index 07bd34b631..5bfc5f6c22 100644
> --- a/diffcore-rename.c
> +++ b/diffcore-rename.c
> @@ -82,6 +82,18 @@ static struct diff_rename_src *register_rename_src(struct diff_filepair *p)
>  
>  	first = 0;
>  	last = rename_src_nr;
> +
> +	if (last > 0) {
> +		struct diff_rename_src *src = &(rename_src[last-1]);
> +		int cmp = strcmp(one->path, src->p->one->path);
> +		if (!cmp)
> +			return src;
> +		if (cmp > 0) {
> +			first = last;
> +			goto append_it;
> +		}
> +	}
> +
>  	while (last > first) {
>  		int next = (last + first) >> 1;
>  		struct diff_rename_src *src = &(rename_src[next]);
> @@ -95,6 +107,7 @@ static struct diff_rename_src *register_rename_src(struct diff_filepair *p)
>  		first = next+1;
>  	}
>  
> +append_it:
>  	/* insert to make it at "first" */
>  	ALLOC_GROW(rename_src, rename_src_nr + 1, rename_src_alloc);
>  	rename_src_nr++;
> -- 
> gitgitgadget
