Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 66E441F404
	for <e@80x24.org>; Mon,  5 Feb 2018 21:58:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752059AbeBEV6K (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Feb 2018 16:58:10 -0500
Received: from mail-pl0-f68.google.com ([209.85.160.68]:36468 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752037AbeBEV6I (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Feb 2018 16:58:08 -0500
Received: by mail-pl0-f68.google.com with SMTP id v3so12691897plg.3
        for <git@vger.kernel.org>; Mon, 05 Feb 2018 13:58:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xOqHsp95dmqvy0gjdIMtFo40ZzjdvJLzp7R/V+JbVyw=;
        b=rFXrtOt4wlNsjLUEqj36e5mDdnSH0NmjDvh3eWM8K3Pd8vYFmNF/GAWBmbDvAtPTy0
         YrWzGWTWXU/rAOlQW80292ZP5Lu+boc2DrA8hvcE1BHg2sQJ7GgSzBVAAloYV5nJUlnd
         dWmlABzgzLN8ct2FSA2oj2Vyec5rW7v6yB/d5uMDEG2IOLcssxFuODHr17jEn3W3O5aE
         ndHDK4+L2VRPy/8+DNmkTGkCXJMxjgtExIYSnM2GBex1Z4YCwYsAo/Z2k3sihJCFMgb6
         pKmS1HbfcGIjKLAokmOMB3qFxWa/l8L1SHVHMh4CpoNSfd04MmAm6u92HpF5Hw2kkTRJ
         kL8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xOqHsp95dmqvy0gjdIMtFo40ZzjdvJLzp7R/V+JbVyw=;
        b=CDTM+4jPgE/wPlbcdt8ScIonCtzDIkeUrAylMVnQWaulPblkkWfA7Fya30LCoiusl3
         Nt+cTppqyA5F9uFN4lVJh/ae4llfbsXWwkqinaYEi3EWKHYll3VrTWEqohVozU7zPLqU
         HG8IhOVELJNtjnQF9x95VU9o0eSucD5g21NMLd4hREBdJFi9x+VHdqs5rsbHhzAIe1FD
         EIqYZg7XCU2omO6p0ipYLjAY9kwKU0J47dQ+zXog0ZXzL8RTFqQ3WwcFomSzA/1KtbSU
         no+NqLzQ4UsH/obOlrZNRpFrfbAFlDCF1BaNTzGS+Bbr6hmz3pHQG1tviWvrOrOOu6D/
         5pKg==
X-Gm-Message-State: APf1xPAqCjwnDcsSpARqQ4e9PQryplx5XbgNUV2ToVLjtlyrtfQOZMvb
        swUSs0w2Kaf3Jb9yXXqKcPZaXA==
X-Google-Smtp-Source: AH8x224QoQfjMlp/QqGovx4OJmMfHtzy64bSiCn3mhScEFpt8MwK5mhkoc2XnCehnltCos8onmQPFw==
X-Received: by 2002:a17:902:33c1:: with SMTP id b59-v6mr231975plc.111.1517867887634;
        Mon, 05 Feb 2018 13:58:07 -0800 (PST)
Received: from google.com ([2620:0:100e:422:ff43:9291:7eda:b712])
        by smtp.gmail.com with ESMTPSA id t8sm12665380pgn.93.2018.02.05.13.58.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Feb 2018 13:58:06 -0800 (PST)
Date:   Mon, 5 Feb 2018 13:58:05 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Ben Peart <benpeart@microsoft.com>
Cc:     git@vger.kernel.org, pclouds@gmail.com, avarab@gmail.com
Subject: Re: [PATCH v1] dir.c: don't flag the index as dirty for changes to
 the untracked cache
Message-ID: <20180205215805.GA90084@google.com>
References: <20180205195619.31064-1-benpeart@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180205195619.31064-1-benpeart@microsoft.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 02/05, Ben Peart wrote:
> The untracked cache saves its current state in the UNTR index extension.
> Currently, _any_ change to that state causes the index to be flagged as dirty
> and written out to disk.  Unfortunately, the cost to write out the index can
> exceed the savings gained by using the untracked cache.  Since it is a cache
> that can be updated from the current state of the working directory, there is
> no functional requirement that the index be written out for every change to the
> untracked cache.
> 
> Update the untracked cache logic so that it no longer forces the index to be
> written to disk except in the case where the extension is being turned on or
> off.  When some other git command requires the index to be written to disk, the
> untracked cache will take advantage of that to save it's updated state as well.
> This results in a performance win when looked at over common sequences of git
> commands (ie such as a status followed by add, commit, etc).
> 
> After this patch, all the logic to track statistics for the untracked cache
> could be removed as it is only used by debug tracing used to debug the untracked
> cache.

So we don't need to update it every time because its just a cache
and if its inaccurate between status calls that's ok?  So only
operations like add and commit will actually write out the untracked
cache (as a part of writing out the index).  Sounds ok.

What benefit is there to using the untracked cache then?  Sounds like
you should just turn it off instead?
(I'm sure this is a naive question :D )

> 
> Signed-off-by: Ben Peart <benpeart@microsoft.com>
> ---
> 
> Notes:
>     Base Ref: master
>     Web-Diff: https://github.com/benpeart/git/commit/20c2e8d787
>     Checkout: git fetch https://github.com/benpeart/git untracked-cache-v1 && git checkout 20c2e8d787
> 
>  dir.c                             | 3 ++-
>  t/t7063-status-untracked-cache.sh | 3 +++
>  2 files changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/dir.c b/dir.c
> index 7c4b45e30e..da93374f0c 100644
> --- a/dir.c
> +++ b/dir.c
> @@ -2297,7 +2297,8 @@ int read_directory(struct dir_struct *dir, struct index_state *istate,
>  				 dir->untracked->gitignore_invalidated,
>  				 dir->untracked->dir_invalidated,
>  				 dir->untracked->dir_opened);
> -		if (dir->untracked == istate->untracked &&
> +		if (getenv("GIT_TEST_UNTRACKED_CACHE") &&
> +			dir->untracked == istate->untracked &&
>  		    (dir->untracked->dir_opened ||
>  		     dir->untracked->gitignore_invalidated ||
>  		     dir->untracked->dir_invalidated))
> diff --git a/t/t7063-status-untracked-cache.sh b/t/t7063-status-untracked-cache.sh
> index e5fb892f95..6ef520e823 100755
> --- a/t/t7063-status-untracked-cache.sh
> +++ b/t/t7063-status-untracked-cache.sh
> @@ -14,6 +14,9 @@ test_description='test untracked cache'
>  # See <20160803174522.5571-1-pclouds@gmail.com> if you want to know
>  # more.
>  
> +GIT_TEST_UNTRACKED_CACHE=true
> +export GIT_TEST_UNTRACKED_CACHE
> +
>  sync_mtime () {
>  	find . -type d -ls >/dev/null
>  }
> 
> base-commit: 5be1f00a9a701532232f57958efab4be8c959a29
> -- 
> 2.15.0.windows.1
> 

-- 
Brandon Williams
