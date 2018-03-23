Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 77B1B1F404
	for <e@80x24.org>; Fri, 23 Mar 2018 20:41:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751976AbeCWUlk (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Mar 2018 16:41:40 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:46514 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751960AbeCWUli (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Mar 2018 16:41:38 -0400
Received: by mail-wr0-f194.google.com with SMTP id d1so1348148wrj.13
        for <git@vger.kernel.org>; Fri, 23 Mar 2018 13:41:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=5AVydSidi7uJ8AvUMGFoEmO5BPpgEyGcwFfE/v1iyRM=;
        b=IPs23rz8ffR/jWHoV0TZGrqgAo8oUDhtTKHTedXbrsLJIQ9RVOIkoKyKQ3WwP2eXyg
         tOL/gFJEeTfPw5B5QM2EOBN9R4ZsYgR7CqNdaP34SgXZJ8xbZW7veLxFDTRUDSFkMQ73
         g1fcdDbiLM7xSIcyx/FKxwe6OtmhM5p19HClnOVH2OCdQOZ04Wxkx4NtlNqh82VzzOZJ
         WIIV1pwcBf3P05DMiNCoCsmR9tUFf/pd1i1g7b4QGdDJJylgOyNx6LsgS0oXHWW1yRLv
         r8CpesHr5fkAZlGNpPhd2j+bzCF8Y9yzjIYyuryaFFSCWLg9SxE7LrE6JRYN5tZCq/m5
         YQVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=5AVydSidi7uJ8AvUMGFoEmO5BPpgEyGcwFfE/v1iyRM=;
        b=CQRROmAtujVwzbt958VatPDflEyCl3IQ5ggAeRvbrAC4AzIVAZCbDhM1zhw5weUFHA
         IP1G3pZQ7eBOTu4736sItsyxkWnYZBEZoHXTNUuJjQhcY1lqbmXPYIAGyC/RTbwDfNzw
         14sfgYbsulgIoCUWWLkvCrQduMI9DyhUlRkKUhLv2bdD7h6HhqQFmeJnGbR/yBkIAp4o
         Gu/Mg3SdBOGKr0Zz/2Mek/9TiKDV3FDiuayp0OpDa79yND5TYFSZtW6KqOoaTbrSiFBE
         t8WLcwYCdvN5I/azTpGZikk7aWzDAk8qLcoU8gAo0Q1Ii834QjmQM5RgBgFFTT4xPOBy
         Jzbw==
X-Gm-Message-State: AElRT7HfZr5OjPONKJFPgTdS8qvbbQ/kvALQ3YG1yEcdmQsHaw0fbWph
        zWdXp8iWAkF4/iStUa4zc1U=
X-Google-Smtp-Source: AG47ELvFew1TWR4VwYiBG5kC9/UTn55cKoH6kWkNIph49k0mVPG/N0bUyo8l4489SJIn26Fd9LCDWw==
X-Received: by 10.223.193.129 with SMTP id x1mr15435824wre.166.1521837696222;
        Fri, 23 Mar 2018 13:41:36 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id 59sm8938242wrj.5.2018.03.23.13.41.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 23 Mar 2018 13:41:35 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jameson Miller <jamill@microsoft.com>
Cc:     git@vger.kernel.org, peff@peff.net
Subject: Re: [PATCH v2 5/5] Expand implementation of mem-pool type
References: <20180321164152.204869-1-jamill@microsoft.com>
        <20180323144408.213145-6-jamill@microsoft.com>
Date:   Fri, 23 Mar 2018 13:41:34 -0700
In-Reply-To: <20180323144408.213145-6-jamill@microsoft.com> (Jameson Miller's
        message of "Fri, 23 Mar 2018 10:44:08 -0400")
Message-ID: <xmqqk1u2ikxt.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jameson Miller <jamill@microsoft.com> writes:

> +void mem_pool_discard(struct mem_pool *mem_pool)
> +{
> +	struct mp_block *block, *block_to_free;
> +	for (block = mem_pool->mp_block; block;)
> +	{
> +		block_to_free = block;
> +		block = block->next_block;
> +		free(block_to_free);
> +	}
> +
> +	free(mem_pool);
> +}

This can be used as a (half-)valid justification to the unadvertised
behaviour change made in [2/5] where a large allocation is still
given its own block and connected to a pool (as opposed to bypassing
the pool subsystem altogether).  If an instance of pool does not
keep track of all the pieces of memory mem_pool_alloc() hands out,
mem_pool_discard() cannot be used to reclaim all of the resources.

It however still does not justify how pool_alloc_block_with_size()
appends the new block at the end of the "next" list, which is
scanned for unused spaces when a new request comes in.  "We need to
keep track of them so that disard() can release" would justify a
pointer in the pool struct that chains together allocation blocks,
each of which hosts the memory for a single large allocation request
without extra room to carve out memory for subsequent small
requests.  That pointer does not have to be the usual "mp_block"
pointer.

> diff --git a/mem-pool.h b/mem-pool.h
> index 829ad58ecf..d9e7f21541 100644
> --- a/mem-pool.h
> +++ b/mem-pool.h
> @@ -21,6 +21,17 @@ struct mem_pool {
>  	size_t pool_alloc;
>  };
>  
> +/*
> + * Initialize mem_pool with specified parameters for initial size and
> + * how much to grow when a larger memory block is required.
> + */
> +void mem_pool_init(struct mem_pool **mem_pool, size_t alloc_growth_size, size_t initial_size);
> +
> +/*
> + * Discard a memory pool and free all the memory it is responsible for.
> + */
> +void mem_pool_discard(struct mem_pool *mem_pool);
> +
>  /*
>   * Alloc memory from the mem_pool.
>   */
> @@ -31,4 +42,17 @@ void *mem_pool_alloc(struct mem_pool *pool, size_t len);
>   */
>  void *mem_pool_calloc(struct mem_pool *pool, size_t count, size_t size);
>  
> +/*
> + * Move the memory associated with the 'src' pool to the 'dst' pool. The 'src'
> + * pool will be empty and not contain any memory. It still needs to be free'd
> + * with a call to `mem_pool_discard`.
> + */
> +void mem_pool_combine(struct mem_pool *dst, struct mem_pool *src);
> +
> +/*
> + * Check if a memory pointed at by 'mem' is part of the range of
> + * memory managed by the specified mem_pool.
> + */
> +int mem_pool_contains(struct mem_pool *mem_pool, void *mem);
> +
>  #endif

When adding a new "API", we prefer to see its usage demonstrated
with its first user, either in the same patch or in later steps in
the same series.  That would make it easier to evaluate its worth
fairly.

Thanks.


