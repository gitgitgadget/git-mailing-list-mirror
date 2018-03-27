Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A3F271F404
	for <e@80x24.org>; Tue, 27 Mar 2018 16:10:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752953AbeC0QKD (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Mar 2018 12:10:03 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34417 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752864AbeC0QJq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Mar 2018 12:09:46 -0400
Received: by mail-wm0-f66.google.com with SMTP id a20so22004843wmd.1
        for <git@vger.kernel.org>; Tue, 27 Mar 2018 09:09:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=7/sfP9n5bnXNbhlIrPkiyS0/oDZWZHzqns9+z+2o3CI=;
        b=Va+xffRRyzWMl6zg6KbAOA6XyxzzCbm7MbEi7UU+HqsoTrTJso3uy3O0+mHazSy4/7
         NVeBKaJ2nRvV7Akm+XaGJHW7lEdPcL8iKmOII1ySe/cd1b7Go+QGV1ixbssOI9XkF7yn
         6B0kjh58hNUCkDy7egCGaXFXl5jIGPn3pzXUfG8hNFMA8BEZ08l+3/x7INlN0n+v1boW
         v35ChR9tVJBy+nBBi9FSJyKk67khAE29i847CYv1WHWSMKBgJ0/Kl6QwiwUKSu2MtiXr
         oFMwmHG9psTdASEwfKCfglr1llpKd16nXH+kZnHcnHe4sfYL01btz2OWnWrPpuvYhAgM
         iKlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=7/sfP9n5bnXNbhlIrPkiyS0/oDZWZHzqns9+z+2o3CI=;
        b=SfXUE9sTWupykkPeiYuawz0X7OZWvCVomsLo5YmnZpL1KjHDc3GutFs7thXzZk392l
         Nyiedqhddzso4ZOveP0nnTHGFvau/qkG6jQbrDTrZJKWz/2cEHklD45u+PIhEAliGS5A
         S/1cLGt7SFsf7HUchFSnKboXV2+NtsygO2muucmjMgz3djZqTS4pnPx48WM3Nz8cg/Sx
         Rnq9UhKkB3pSv+FUyguhMywiC+HwQkAzOZMNXJ2gmef0eaHKe+SH7seHIvJXh/law3AG
         7jWIWuENA4Zk0bYwAQFdu7aX+B2NEJQG5oFf2dO8RPIbeETbCunBOCVoTp0vm+JH2CyH
         LhEA==
X-Gm-Message-State: AElRT7HE5zge2/DzVtEZdk0WRbFGWJER1c1TkoDgSSQlxXSlIFDs9sgq
        ThZJo7FSFMiichF49r6PCIA=
X-Google-Smtp-Source: AG47ELs4ht0xu3O2E5oRaVYEV2k8GCf1pD6OwY2yU7NDHfIhWJrseaFRCmNqyCHJiSruTYFge5ctZg==
X-Received: by 10.28.19.193 with SMTP id 184mr17630276wmt.158.1522166984563;
        Tue, 27 Mar 2018 09:09:44 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id t14sm1740033wra.7.2018.03.27.09.09.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 27 Mar 2018 09:09:43 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jameson Miller <jamill@microsoft.com>
Cc:     git@vger.kernel.org, peff@peff.net
Subject: Re: [PATCH v3 2/3] fast-import: introduce mem_pool type
References: <20180321164152.204869-1-jamill@microsoft.com>
        <20180326170351.197793-3-jamill@microsoft.com>
Date:   Tue, 27 Mar 2018 09:09:43 -0700
In-Reply-To: <20180326170351.197793-3-jamill@microsoft.com> (Jameson Miller's
        message of "Mon, 26 Mar 2018 13:03:50 -0400")
Message-ID: <xmqqpo3pa4ag.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jameson Miller <jamill@microsoft.com> writes:

> Introduce the mem_pool type which encapsulates all the information
> necessary to manage a pool of memory.This change moves the existing
> variables in fast-import used to support the global memory pool to use
> this structure.
>
> These changes allow for the multiple instances of a memory pool to
> exist and be reused outside of fast-import. In a future commit the
> mem_pool type will be moved to its own file.
>
> Signed-off-by: Jameson Miller <jamill@microsoft.com>
> ---
>  fast-import.c | 80 +++++++++++++++++++++++++++++++++++++----------------------
>  1 file changed, 51 insertions(+), 29 deletions(-)

Thanks, this got much easier to read and reason about.

> @@ -304,9 +317,7 @@ static int global_argc;
>  static const char **global_argv;
>  
>  /* Memory pools */
> -static size_t mem_pool_alloc = 2*1024*1024 - sizeof(struct mp_block);
> -static size_t total_allocd;
> -static struct mp_block *mp_block_head;
> +static struct mem_pool fi_mem_pool =  {0, 2*1024*1024 - sizeof(struct mp_block), 0 };
>  
>  /* Atom management */
>  static unsigned int atom_table_sz = 4451;
> @@ -324,6 +335,7 @@ static off_t pack_size;
>  /* Table of objects we've written. */
>  static unsigned int object_entry_alloc = 5000;
>  static struct object_entry_pool *blocks;
> +static size_t total_allocd;

So the design decision made at this step is that pool_alloc field
keeps track of the per-pool allocation, while total_allocd is a sum
across instances of pools.  That sounds appropriate for stats.

> @@ -634,7 +646,21 @@ static unsigned int hc_str(const char *s, size_t len)
>  	return r;
>  }
>  
> -static void *pool_alloc(size_t len)
> +static struct mp_block *mem_pool_alloc_block(struct mem_pool *mem_pool, size_t block_alloc)
> +{
> +	struct mp_block *p;
> +
> +	mem_pool->pool_alloc += sizeof(struct mp_block) + block_alloc;
> +	p = xmalloc(st_add(sizeof(struct mp_block), block_alloc));
> +	p->next_block = mem_pool->mp_block;
> +	p->next_free = (char *)p->space;
> +	p->end = p->next_free + block_alloc;
> +	mem_pool->mp_block = p;

This, compared to what used to happen in mem_pool_alloc()'s original
code, ignores total_allocd.  I cannot tell if that is an intentional
change or a mistake.

> +
> +	return p;
> +}
> +
> +static void *mem_pool_alloc(struct mem_pool *mem_pool, size_t len)
>  {
>  	struct mp_block *p;
>  	void *r;
> @@ -643,21 +669,17 @@ static void *pool_alloc(size_t len)
>  	if (len & (sizeof(uintmax_t) - 1))
>  		len += sizeof(uintmax_t) - (len & (sizeof(uintmax_t) - 1));
>  
> -	for (p = mp_block_head; p; p = p->next_block)
> -		if ((p->end - p->next_free >= len))
> -			break;
> +	for (p = mem_pool->mp_block; p; p = p->next_block)
> +		if (p->end - p->next_free >= len)
> +	       		break;
>  
>  	if (!p) {
> -		if (len >= (mem_pool_alloc/2)) {
> -			total_allocd += len;
> +		if (len >= (mem_pool->block_alloc / 2)) {
> +			mem_pool->pool_alloc += len;
>  			return xmalloc(len);

It is unfair to account this piece of memory to the mem_pool, as we
ended up not carving it out from here.  Did you mean to increment
total_allocd by len instead, perhaps?

And I do agree with the idea in the previous round to make these
oversized pieces of memory allocated here to be freeable via the
mem_pool instance (I only found it questionable to use the main
"here are the list of blocks that we could carve small pieces out"
list), and anticipate that a later step in the series would change
this part to do so.  With that anticipation, I very much appreciate
that this step did not mix that and stayed as close to the original
(except for the possible mis-accounting).  It makes it very clear
what is going on in each separate step in the series.

>  		}
> -		total_allocd += sizeof(struct mp_block) + mem_pool_alloc;

This is what I noticed got lost in the pool-alloc-block helper above.

> -		p = xmalloc(st_add(sizeof(struct mp_block), mem_pool_alloc));
> -		p->next_block = mp_block_head;
> -		p->next_free = (char *) p->space;
> -		p->end = p->next_free + mem_pool_alloc;
> -		mp_block_head = p;
> +
> +		p = mem_pool_alloc_block(mem_pool, mem_pool->block_alloc);
>  	}
>  
>  	r = p->next_free;
> @@ -665,10 +687,10 @@ static void *pool_alloc(size_t len)
>  	return r;
>  }
>  
> -static void *pool_calloc(size_t count, size_t size)
> +static void *mem_pool_calloc(struct mem_pool *mem_pool, size_t count, size_t size)
>  {
> -	size_t len = count * size;
> -	void *r = pool_alloc(len);
> +	size_t len = st_mult(count, size);

Nice ;-)

> +	void *r = mem_pool_alloc(mem_pool, len);
>  	memset(r, 0, len);
>  	return r;
>  }
