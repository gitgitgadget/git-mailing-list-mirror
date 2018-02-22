Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B53E01F404
	for <e@80x24.org>; Thu, 22 Feb 2018 00:47:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751540AbeBVArN (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Feb 2018 19:47:13 -0500
Received: from mail-pl0-f67.google.com ([209.85.160.67]:41293 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751405AbeBVArM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Feb 2018 19:47:12 -0500
Received: by mail-pl0-f67.google.com with SMTP id k8so1942009pli.8
        for <git@vger.kernel.org>; Wed, 21 Feb 2018 16:47:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KmD6wumF1MfSCpkqN/z3f/zlMNXmb8PtFkeDJ0emlqk=;
        b=M9+/Yb05Ho7mLQMgicXAWimus+VBZqmYmQ4Fh2XEZpKe6NYeGIppWq60PYGm2ksdKC
         RdjWrsbhdl0Iev5bADGLKiUVp7RShER6zps+tvN2+GxqksCRsgp1mLr3v/vi/9r5HG23
         oESVPaZmapr7pldJtZvEKt5PbmJYKEs3NA8PEmpwu7cVtJffXLaIfNct/Sq57pMQiAou
         j6ppNimN+cmbj3QIB3LECjzAkRVwWRojWEpKRi1P72kC73d6gDs9NDF7m/Eg+Lxe88+q
         9zdjZ6a+xmipfNZ2q8rCDiwC7nrpTzAY6AaTFcpI8wROR40ZJd1/GxbA7btLBSIuNrVm
         XDvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KmD6wumF1MfSCpkqN/z3f/zlMNXmb8PtFkeDJ0emlqk=;
        b=jC2V1H+cmmwSJkka5kGEYiGgfypeEYXgSBHqrZwxK5tFCaX0+p9iMXe4QNDfXovU5Y
         uxq1Kx4nqCXQc8oxAxmQiPAs0P1nurzrD35pftMDcB8gFzMZmUEBTxoLs0WnkbgirXlW
         OqBZSRqjgVb4oYBgGPtf7jHuId6n4U3HNxi9PAUlDmn6cSAUdRExuO857Hc/ao7W7+8s
         VWq5F2p5Su1nYxzM3JOvLvah6TgRK2ue4mWz1KJUSA9+X90moVKDsAMF2z7v397JHgOW
         pnYB8yfbKgucOlecdEXlZ6c3afLbwacow0L7H5EffwjScTd4Fjiu/gr+ArlltFqUT1Vu
         SRnA==
X-Gm-Message-State: APf1xPD3kCvwO1ini7wplk2b2WpJVPj5LHK02P7EfywFipD1WIaPCVRG
        xUUpf17csrkrX2MQqbgv5X5iRg==
X-Google-Smtp-Source: AH8x2255S6GFMfjCj7a2B2KsMHnfafQEcNDFG3hbZL3H/akJuV3hIdwTOt82UZyljO3TAqFfDaUaGg==
X-Received: by 2002:a17:902:7586:: with SMTP id j6-v6mr4599050pll.301.1519260432174;
        Wed, 21 Feb 2018 16:47:12 -0800 (PST)
Received: from google.com ([2620:0:100e:422:ff43:9291:7eda:b712])
        by smtp.gmail.com with ESMTPSA id 63sm60935858pgi.71.2018.02.21.16.47.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 21 Feb 2018 16:47:11 -0800 (PST)
Date:   Wed, 21 Feb 2018 16:47:10 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, jonathantanmy@google.com,
        pclouds@gmail.com, sunshine@sunshineco.com,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 08/27] pack: move approximate object count to object store
Message-ID: <20180222004710.GF127348@google.com>
References: <20180216174626.24677-1-sbeller@google.com>
 <20180221015430.96054-1-sbeller@google.com>
 <20180221015430.96054-9-sbeller@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180221015430.96054-9-sbeller@google.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 02/20, Stefan Beller wrote:
> The approximate_object_count() function maintains a rough count of
> objects in a repository to estimate how long object name abbreviates
> should be.  Object names are scoped to a repository and the
> appropriate length may differ by repository, so the object count
> should not be global.
> 
> Signed-off-by: Stefan Beller <sbeller@google.com>
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
> ---
>  object-store.h | 10 +++++++++-
>  packfile.c     | 11 +++++------
>  2 files changed, 14 insertions(+), 7 deletions(-)
> 
> diff --git a/object-store.h b/object-store.h
> index 6cecba3951..bd1e4fcd8b 100644
> --- a/object-store.h
> +++ b/object-store.h
> @@ -93,6 +93,14 @@ struct raw_object_store {
>  	struct alternate_object_database *alt_odb_list;
>  	struct alternate_object_database **alt_odb_tail;
>  
> +	/*
> +	 * A fast, rough count of the number of objects in the repository.
> +	 * These two fields are not meant for direct access. Use
> +	 * approximate_object_count() instead.
> +	 */
> +	unsigned long approximate_object_count;
> +	unsigned approximate_object_count_valid : 1;

Patch looks fine and is effectively a no-op, though what is the need for
both of these variables?  Maybe it can be simplified down to just use
one?  Just musing as its out of the scope of this patch and we probably
shouldn't try to change that in this series.

> +
>  	/*
>  	 * Whether packed_git has already been populated with this repository's
>  	 * packs.
> @@ -107,7 +115,7 @@ struct raw_object_store {
>   * that macro on member variables. Use NULL instead as that is defined
>   * and accepted, deferring the real init to prepare_packed_git_mru(). */
>  #define __MRU_INIT { NULL, NULL }
> -#define RAW_OBJECT_STORE_INIT { NULL, NULL, __MRU_INIT, NULL, NULL, 0 }
> +#define RAW_OBJECT_STORE_INIT { NULL, NULL, __MRU_INIT, NULL, NULL, 0, 0, 0 }
>  
>  void raw_object_store_clear(struct raw_object_store *o);
>  
> diff --git a/packfile.c b/packfile.c
> index a8a2e7fe43..693bafbc98 100644
> --- a/packfile.c
> +++ b/packfile.c
> @@ -803,8 +803,6 @@ static void prepare_packed_git_one(char *objdir, int local)
>  	strbuf_release(&path);
>  }
>  
> -static int approximate_object_count_valid;
> -
>  /*
>   * Give a fast, rough count of the number of objects in the repository. This
>   * ignores loose objects completely. If you have a lot of them, then either
> @@ -814,8 +812,8 @@ static int approximate_object_count_valid;
>   */
>  unsigned long approximate_object_count(void)
>  {
> -	static unsigned long count;
> -	if (!approximate_object_count_valid) {
> +	if (!the_repository->objects.approximate_object_count_valid) {
> +		unsigned long count;
>  		struct packed_git *p;
>  
>  		prepare_packed_git();
> @@ -825,8 +823,9 @@ unsigned long approximate_object_count(void)
>  				continue;
>  			count += p->num_objects;
>  		}
> +		the_repository->objects.approximate_object_count = count;
>  	}
> -	return count;
> +	return the_repository->objects.approximate_object_count;
>  }
>  
>  static void *get_next_packed_git(const void *p)
> @@ -901,7 +900,7 @@ void prepare_packed_git(void)
>  
>  void reprepare_packed_git(void)
>  {
> -	approximate_object_count_valid = 0;
> +	the_repository->objects.approximate_object_count_valid = 0;
>  	the_repository->objects.packed_git_initialized = 0;
>  	prepare_packed_git();
>  }
> -- 
> 2.16.1.291.g4437f3f132-goog
> 

-- 
Brandon Williams
