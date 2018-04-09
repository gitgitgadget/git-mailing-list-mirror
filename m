Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ED16E1F404
	for <e@80x24.org>; Mon,  9 Apr 2018 23:24:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751970AbeDIXYV (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Apr 2018 19:24:21 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:44574 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751652AbeDIXYU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Apr 2018 19:24:20 -0400
Received: by mail-pf0-f193.google.com with SMTP id p15so6663159pff.11
        for <git@vger.kernel.org>; Mon, 09 Apr 2018 16:24:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=f6p8ILIYfjSQWi5yg/coU3kd1hJgXsC8LeV9YPgV14o=;
        b=AtIzhJ2WtIVMnIYvlxP2zQDeFAs4y3LzIFkPqKy1X7JZaH8dygDLPQ9yCbdhbxLwKW
         e19ziEPR/kNromsNPNXcm1x3FGO7sUrdF0MPSbpVCV+L95HPEr1TYS9PofmHFnGUa+v+
         gopFTvQd+kecNjdjBTAFi+CXDSrYe8oGlaxUk3ZUNoV8D0spVsOAYQ/g1JGxRA8Lt40p
         3VWHyty8f2L2M+DUb2MyZAVrL4p79CVzM4/TXdw9hiH0nnQl9L2t7X8oNrjfelxRYzNr
         FitLbvG8b/IZiLwVi5BJzTen3iCsE9R/gnxlwuzGF2jfeczikiyaWrxkHzbEo2gqdrJ0
         GrCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=f6p8ILIYfjSQWi5yg/coU3kd1hJgXsC8LeV9YPgV14o=;
        b=UdXPgALy+1IlqPlqUYnB/7HQycuRLhLSRzuldBxROePJMv1/HlJJdZUIZyxnQlFXFT
         gb9RAQz2w4sLoWOinIRyCuhSlDSt+0NmQeYXWyscS8jsYOqYIp0z0ZBhlXWxJmFgFg87
         EDA3CXTSMxz0HcPxUf/qLOe8/XddovhIRF4mz5qTTlppZYB/rMMseqOf5LLHOPOAv0ZQ
         VXsN+Vxe8kbs7+xuGEv2Q33Rh3qMMywGncq9leeF2rLIEk8bFf6sqPJ1LHidG2fWx8AE
         WteLaVkNBq0in8gBW7v3w0UXZ3TYCJJ9gJ5lGA4H/GeZ7I7AKzzlvBrMXQ5AsJFqjBVd
         rQ2Q==
X-Gm-Message-State: ALQs6tCL9B8xRVUvD9juam+0OXSWwTQtPjBBjJGpsZGjdmVRIqc7wj3s
        EmeMJjqWZIlwPDQHXu+pnl07sA==
X-Google-Smtp-Source: AIpwx4/u7I7AqsmJe9+6KAxyuQvUyRGbWdfgR2rLH7zELB4bnEuw74hE6++HTEMOgQS9/8m46OIalQ==
X-Received: by 10.167.134.80 with SMTP id a16mr724058pfo.172.1523316259250;
        Mon, 09 Apr 2018 16:24:19 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:ff43:9291:7eda:b712])
        by smtp.gmail.com with ESMTPSA id 81sm2600389pfl.92.2018.04.09.16.24.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 09 Apr 2018 16:24:18 -0700 (PDT)
Date:   Mon, 9 Apr 2018 16:24:16 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org, jonathantanmy@google.com,
        sunshine@sunshineco.com, pclouds@gmail.com, l.s.r@web.de,
        sandals@crustytoothpaste.net
Subject: Re: [PATCH 12/16] refs: store the main ref store inside the
 repository struct
Message-ID: <20180409232416.GA102627@google.com>
References: <20180406232136.253950-1-sbeller@google.com>
 <20180409224533.17764-1-sbeller@google.com>
 <20180409224533.17764-13-sbeller@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180409224533.17764-13-sbeller@google.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 04/09, Stefan Beller wrote:
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>  refs.c       | 13 +++++--------
>  refs.h       |  4 +---
>  repository.h |  3 +++
>  3 files changed, 9 insertions(+), 11 deletions(-)
> 
> diff --git a/refs.c b/refs.c
> index f58b9fb7df..b5be754a97 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -1608,9 +1608,6 @@ static struct ref_store_hash_entry *alloc_ref_store_hash_entry(
>  	return entry;
>  }
>  
> -/* A pointer to the ref_store for the main repository: */
> -static struct ref_store *main_ref_store;
> -
>  /* A hashmap of ref_stores, stored by submodule name: */
>  static struct hashmap submodule_ref_stores;
>  
> @@ -1652,13 +1649,13 @@ static struct ref_store *ref_store_init(const char *gitdir,
>  	return refs;
>  }
>  
> -struct ref_store *get_main_ref_store_the_repository(void)
> +struct ref_store *get_main_ref_store(struct repository *r)
>  {
> -	if (main_ref_store)
> -		return main_ref_store;
> +	if (r->main_ref_store)
> +		return r->main_ref_store;
>  
> -	main_ref_store = ref_store_init(get_git_dir(), REF_STORE_ALL_CAPS);
> -	return main_ref_store;
> +	r->main_ref_store = ref_store_init(r->gitdir, REF_STORE_ALL_CAPS);
> +	return r->main_ref_store;

I assume that since this takes in a git dir as a parameter
that the ref-store is in a good enough place to be embedded in a
repository struct (as in this would work with an arbitrary repo)?

>  }
>  
>  /*
> diff --git a/refs.h b/refs.h
> index ab3d2bec2f..f5ab68c0ed 100644
> --- a/refs.h
> +++ b/refs.h
> @@ -760,9 +760,7 @@ int reflog_expire(const char *refname, const struct object_id *oid,
>  
>  int ref_storage_backend_exists(const char *name);
>  
> -#define get_main_ref_store(r) \
> -	get_main_ref_store_##r()
> -struct ref_store *get_main_ref_store_the_repository(void);
> +struct ref_store *get_main_ref_store(struct repository *r);
>  /*
>   * Return the ref_store instance for the specified submodule. For the
>   * main repository, use submodule==NULL; such a call cannot fail. For
> diff --git a/repository.h b/repository.h
> index 09df94a472..7d0710b273 100644
> --- a/repository.h
> +++ b/repository.h
> @@ -26,6 +26,9 @@ struct repository {
>  	 */
>  	struct raw_object_store *objects;
>  
> +	/* The store in which the refs are held. */
> +	struct ref_store *main_ref_store;
> +
>  	/*
>  	 * Path to the repository's graft file.
>  	 * Cannot be NULL after initialization.
> -- 
> 2.17.0.484.g0c8726318c-goog
> 

-- 
Brandon Williams
