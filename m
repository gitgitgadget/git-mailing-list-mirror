Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 055C51F404
	for <e@80x24.org>; Wed, 21 Mar 2018 22:25:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753916AbeCUWZS (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Mar 2018 18:25:18 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:38456 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753744AbeCUWZR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Mar 2018 18:25:17 -0400
Received: by mail-pl0-f66.google.com with SMTP id m22-v6so4031803pls.5
        for <git@vger.kernel.org>; Wed, 21 Mar 2018 15:25:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=p45jikb6bPbkceAbaIN0naGhZ9yh1H1oGHN4gJKUw3c=;
        b=osDwbPKzF7bCxmTl5gbspQ3BTcg5evFltJFtugmSO+1cClMMIWyscsUkDgHqDQ0Z37
         84XOqEilLdJ0XayFprWVvvWXK/n/fRqMSiSEoq/Lo5VE4hvtCgpefhe/1nIpIAJzxqSp
         9it6SjM2jVk725ccn7fk+mT0QCjqRFG/CxdbDpAsssCFMHRVUd0bHk2iwqyAYyoSiHBs
         w4MMUt0EVzPxZeUaIIPEXFYwaOpG6OSwX0G9a5MZT6ZjY+oiZWDEpgzNyLVc/lWLrz+q
         nizwBFzjSDestsG2ErB1qSbBxOriUxHZKaCVqTZcES6PJPNGE3hYXowNU2tls/NB8f+n
         SLcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=p45jikb6bPbkceAbaIN0naGhZ9yh1H1oGHN4gJKUw3c=;
        b=oE6/K5isjtQBfhS5wLgL9psiv+YAYh6l9JyhkGw8bwRAji1feteLW1YVE9AH05PaSF
         STsvSiUD8b0R2IMYuU0hKiP/JRL6xuN8n6MBid8KKR2Hb4S27Y3lmBZBnaLZMsnjJy84
         ImwO86yOyPvpYte9805B8miqm3/L5AytfiIRhUVU7kGWddzylgWLElKBNuBemyWg78P5
         G2Kr/e3iKd6yQY5ghYI2PbJuWrLcHDEuEhkW2DR8KBQj+15CzQ2C4wfmFALTFKhIW28Y
         GDiLOalkNGdabj8xsLDjAJSRSTDOzABePsjWKLuvesjS97iPxmDx+7eo86JRbJC1BHZg
         2t/w==
X-Gm-Message-State: AElRT7GuVYgJ5yUzeI7CG4rXMsfvEqCwoKxugZwZjLAzUUvlfQtogCKa
        rPcau6Al1uTk6zsQjFBfkJZ3qw==
X-Google-Smtp-Source: AG47ELumqQMr38qDJkuu370D+BKTqsxDkPL0HMMEuT0TXhSuqtE7zSKLqTg7dXdp+4i9ohpezw4ZMQ==
X-Received: by 2002:a17:902:309:: with SMTP id 9-v6mr22853458pld.63.1521671116740;
        Wed, 21 Mar 2018 15:25:16 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:ff43:9291:7eda:b712])
        by smtp.gmail.com with ESMTPSA id v2sm9745705pgo.36.2018.03.21.15.25.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 21 Mar 2018 15:25:15 -0700 (PDT)
Date:   Wed, 21 Mar 2018 15:25:14 -0700
From:   Brandon Williams <bmwill@google.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 12/44] pack: move prepare_packed_git_run_once to object
 store
Message-ID: <20180321222514.GJ18406@google.com>
References: <CACsJy8DWrNzZM1K2vkx2XiETdAR5WhwXEdPijsxd0ZD4Lj=tZw@mail.gmail.com>
 <20180303113637.26518-1-pclouds@gmail.com>
 <20180303113637.26518-13-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180303113637.26518-13-pclouds@gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/03, Nguyễn Thái Ngọc Duy wrote:
> From: Stefan Beller <sbeller@google.com>
> 
> Each repository's object store can be initialized independently, so
> they must not share a run_once variable.

Looks good.

> 
> Signed-off-by: Stefan Beller <sbeller@google.com>
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
> Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
> ---
>  object-store.h | 6 ++++++
>  packfile.c     | 7 +++----
>  2 files changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/object-store.h b/object-store.h
> index 1f3e66a3b8..b954396615 100644
> --- a/object-store.h
> +++ b/object-store.h
> @@ -92,6 +92,12 @@ struct raw_object_store {
>  
>  	struct alternate_object_database *alt_odb_list;
>  	struct alternate_object_database **alt_odb_tail;
> +
> +	/*
> +	 * Whether packed_git has already been populated with this repository's
> +	 * packs.
> +	 */
> +	unsigned packed_git_initialized : 1;
>  };
>  
>  void raw_object_store_init(struct raw_object_store *o);
> diff --git a/packfile.c b/packfile.c
> index 1e38334ba2..caeab0f68c 100644
> --- a/packfile.c
> +++ b/packfile.c
> @@ -883,12 +883,11 @@ static void prepare_packed_git_mru(void)
>  		list_add_tail(&p->mru, &the_repository->objects.packed_git_mru);
>  }
>  
> -static int prepare_packed_git_run_once = 0;
>  void prepare_packed_git(void)
>  {
>  	struct alternate_object_database *alt;
>  
> -	if (prepare_packed_git_run_once)
> +	if (the_repository->objects.packed_git_initialized)
>  		return;
>  	prepare_packed_git_one(get_object_directory(), 1);
>  	prepare_alt_odb();
> @@ -896,13 +895,13 @@ void prepare_packed_git(void)
>  		prepare_packed_git_one(alt->path, 0);
>  	rearrange_packed_git();
>  	prepare_packed_git_mru();
> -	prepare_packed_git_run_once = 1;
> +	the_repository->objects.packed_git_initialized = 1;
>  }
>  
>  void reprepare_packed_git(void)
>  {
>  	approximate_object_count_valid = 0;
> -	prepare_packed_git_run_once = 0;
> +	the_repository->objects.packed_git_initialized = 0;
>  	prepare_packed_git();
>  }
>  
> -- 
> 2.16.1.435.g8f24da2e1a
> 

-- 
Brandon Williams
