Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6C1BF1F404
	for <e@80x24.org>; Fri, 23 Mar 2018 17:15:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751715AbeCWRPi (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Mar 2018 13:15:38 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:37155 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751427AbeCWRPh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Mar 2018 13:15:37 -0400
Received: by mail-wm0-f68.google.com with SMTP id 139so4863021wmn.2
        for <git@vger.kernel.org>; Fri, 23 Mar 2018 10:15:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=dbYW0S31t2q+TQtYCIuwm7grItXTYvn4HozPyEffSa0=;
        b=uSl+kjGI9lJQ/VH8XSD9buzOchWZksIMJwZjI38SQ8fKvr4kG4fyy4bgT6mGZ6Mneu
         AlcBfd3TeNBq44l0Wu/lvX0BfDcIp1doSyhMqRyHBFs8h55c+Hd37uf5bb48pzaIMNX4
         5yFv5ndE44JMhGPOG8leRtA9Xtp+VGI9bjiWyWALUGlpXA4BJCUXUVWT71p2pXsLkCJR
         uiz8gf9FK/U6NvvIEq0Fg1BEJ9Bor0OkfS8Sr96D4lukpb0L6XN4ZMea4rFrqruM5sNp
         d0sT+slYIktYURPBBzW1+VnN3NFnd/7oA0aQXMltnRHMSywj+/v2x40aXeaA6KpjjK7h
         w2VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=dbYW0S31t2q+TQtYCIuwm7grItXTYvn4HozPyEffSa0=;
        b=nXRzR5gJ4Qs2h0ygieUZLEc4d1PzjwrX2dAnM14QzJRN3pUgP1wpIvmTnT/HTnKfX5
         Zmu/4qOx/M2W6AD0utW8lQAyRAVxRQA3kRTUnqfUYPf6i4jKGSeIo6zaaRYKiBCuwgej
         Oezg0qmUMQxt89z3T06bXKpvFldLNo5xcXFYGnA8halUp5tjnCAV6821GoTqfLVIFxAI
         olR1J+7Tb2gyqkbtSPzN8IBgijyIxj/QLdKIKPNKbNswtJrovwGXnI1KOu8ZS0VoJtj7
         uqTyiLPLmEuO78R+Te+WrT1mUhyTEhgFXdo67oNt7kU38nzi2zMXEjSnbT04EqUrBuLO
         MN+A==
X-Gm-Message-State: AElRT7EoYh89TuhAvEOO6kJ1JFlhk1v/12+b5MbLqhNsVxqcfdvpIkff
        yeb4gu399pHsR1RBjMU1Lf8=
X-Google-Smtp-Source: AG47ELtrJXWGJczUtHGlNtKWCCtnJzOZwm+NU7CV3/wswuk8OEAWRZYCh72ZvgVknOSQxv7W806rmQ==
X-Received: by 10.28.196.79 with SMTP id u76mr8880157wmf.102.1521825335259;
        Fri, 23 Mar 2018 10:15:35 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id e27sm32396wre.86.2018.03.23.10.15.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 23 Mar 2018 10:15:34 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jameson Miller <jamill@microsoft.com>
Cc:     git@vger.kernel.org, peff@peff.net
Subject: Re: [PATCH v2 2/5] fast-import: introduce mem_pool type
References: <20180321164152.204869-1-jamill@microsoft.com>
        <20180323144408.213145-3-jamill@microsoft.com>
Date:   Fri, 23 Mar 2018 10:15:34 -0700
In-Reply-To: <20180323144408.213145-3-jamill@microsoft.com> (Jameson Miller's
        message of "Fri, 23 Mar 2018 10:44:05 -0400")
Message-ID: <xmqqk1u2k91l.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jameson Miller <jamill@microsoft.com> writes:

> Introduce the mem_pool type and wrap the existing mp_block in this new
> type. The new mem_pool type will allow for the memory pool logic to be
> reused outside of fast-import. This type will be moved into its own file
> in a future commit.
>
> Signed-off-by: Jameson Miller <jamill@microsoft.com>
> ---
>  fast-import.c | 108 +++++++++++++++++++++++++++++++++++++++++++++++-----------
>  1 file changed, 89 insertions(+), 19 deletions(-)
>
> diff --git a/fast-import.c b/fast-import.c
> index 6c3215d7c3..1262d9e6be 100644
> --- a/fast-import.c
> +++ b/fast-import.c
> @@ -216,6 +216,19 @@ struct mp_block {
>  	uintmax_t space[FLEX_ARRAY]; /* more */
>  };
>  
> +struct mem_pool {
> +	struct mp_block *mp_block;
> +
> +	/*
> +	 * The amount of available memory to grow the pool by.
> +	 * This size does not include the overhead for the mp_block.
> +	 */
> +	size_t block_alloc;
> +
> +	/* The total amount of memory allocated by the pool. */
> +	size_t pool_alloc;
> +};

OK, so the existing fast-import one knows that it only needs a
single instance, but by introducing this structure, we made it
possible to have more than one instance of it, and more importantly,
all the necessary pieces of info to manage it are available to those
who have a pointer to this instance.

>  struct atom_str {
>  	struct atom_str *next_atom;
>  	unsigned short str_len;
> @@ -304,9 +317,7 @@ static int global_argc;
>  static const char **global_argv;
>  
>  /* Memory pools */
> -static size_t mem_pool_alloc = 2*1024*1024 - sizeof(struct mp_block);
> -static size_t total_allocd;
> -static struct mp_block *mp_block_head;
> +static struct mem_pool fi_mem_pool =  {0, 2*1024*1024 - sizeof(struct mp_block), 0 };

And this struct instance represents the <list of blocks, block_alloc
and pool_alloc> for fast-import's use, which used to be separate
global variables that are file-scope static here.

Good.

>  /* Atom management */
>  static unsigned int atom_table_sz = 4451;
> @@ -324,6 +335,7 @@ static off_t pack_size;
>  /* Table of objects we've written. */
>  static unsigned int object_entry_alloc = 5000;
>  static struct object_entry_pool *blocks;
> +static size_t total_allocd = 0;

This one is now used as a total across all the mempool instances and
is kept outside the struct, which is OK.

Do not initialize a var in BSS with an explicit "= 0".

> @@ -634,6 +646,60 @@ static unsigned int hc_str(const char *s, size_t len)
>  	return r;
>  }
>  
> +static struct mp_block *pool_alloc_block()

Should spell this as:

	static struct mp_block *pool_alloc_block(void)

But it is somewhat curious; if we are moving to make this reusable,
shouldn't this be accepting "struct mem_pool *pool" from the caller
and using pool->pool_alloc, pool->block_alloc, etc. instead of
always using the global instance, which fi_mem_pool is?

> +{
> +	struct mp_block *p;
> +
> +	fi_mem_pool.pool_alloc += sizeof(struct mp_block) + fi_mem_pool.block_alloc;

This addition, just like the addition on the next line, potentially
overflows and wraps-around, so it is probably a candidate for
st_add(), but IIUC, pool_alloc is only for usage stats, so it may
not be too bad an offence.  In any case, the above is done as close
to the original and is good for a refactoring patch.

> +	p = xmalloc(st_add(sizeof(struct mp_block), fi_mem_pool.block_alloc));
> +	p->next_block = fi_mem_pool.mp_block;
> +	p->next_free = (char *)p->space;
> +	p->end = p->next_free + fi_mem_pool.block_alloc;
> +	fi_mem_pool.mp_block = p;
> +
> +	return p;
> +}

So this is one half of the original pool_alloc(), that allocated a
new block and queued it to the pool when a not-too-large allocation
is requested (the other half that dealt with large allocations
bypassed the pool mechanism altogether).

> +/*
> + * Allocates a block of memory with a specific size and
> + * appends it to the memory pool's list of blocks.
> + *
> + * This function is used to allocate blocks with sizes
> + * different than the default "block_alloc" size for the mem_pool.
> + *
> + * There are two use cases:
> + *  1) The initial block allocation for a memory pool.
> + *
> + *  2) large" blocks of a specific size, where the entire memory block
> + *     is going to be used. This means the block will not have any
> + *     available memory for future allocations. The block is placed at
> + *     the end of the list so that it will be the last block searched
> + *     for available space.

If we know the block won't have any leftover space, what's the point
of "searching for available space" in it in the first place, even if
you make it the last?

> + */
> +static struct mp_block *pool_alloc_block_with_size(size_t block_alloc)
> +{

Same comment on passing a "pool" instance as parameter applies to
this function.

> +	struct mp_block *p, *block;
> +
> +	fi_mem_pool.pool_alloc += sizeof(struct mp_block) + block_alloc;
> +	p = xmalloc(st_add(sizeof(struct mp_block), block_alloc));
> +
> +	block = fi_mem_pool.mp_block;
> +	if (block) {
> +		while (block->next_block)
> +			block = block->next_block;
> +
> +		block->next_block = p;

If there were a need to append to the end (and also a need to
iterate from the beginning), keep an extra pointer in the "pool"
instance to make it an O(1) operation.  Or perhaps this list can be
managed with list.h?

It is unclear why this and pool_alloc_block() need to exist as
separate functions.  80% of the code are shared between them.

> +	} else {
> +		fi_mem_pool.mp_block = p;
> +	}
> +
> +	p->next_block = NULL;
> +	p->next_free = (char *)p->space;
> +	p->end = p->next_free + block_alloc;
> +
> +	return p;
> +}
> +
>  static void *pool_alloc(size_t len)
>  {
>  	struct mp_block *p;
> @@ -643,21 +709,25 @@ static void *pool_alloc(size_t len)
>  	if (len & (sizeof(uintmax_t) - 1))
>  		len += sizeof(uintmax_t) - (len & (sizeof(uintmax_t) - 1));
>  
> -	for (p = mp_block_head; p; p = p->next_block)
> -		if ((p->end - p->next_free >= len))
> -			break;
> +	p = fi_mem_pool.mp_block;
> +
> +	/*
> +	 * In performance profiling, there was a minor perf benefit to
> +	 * check for available memory in the head block via the if
> +	 * statement, and only going through the loop when needed.
> +	 */

Don't mix premature optimization in a refactoring patch, please.

> +	if (p &&
> +	   (p->end - p->next_free < len)) {
> +		for (p = p->next_block; p; p = p->next_block)
> +			if (p->end - p->next_free >= len)
> +				break;
> +	}
>  
>  	if (!p) {
> -		if (len >= (mem_pool_alloc/2)) {
> -			total_allocd += len;
> -			return xmalloc(len);
> -		}
> -		total_allocd += sizeof(struct mp_block) + mem_pool_alloc;
> -		p = xmalloc(st_add(sizeof(struct mp_block), mem_pool_alloc));
> -		p->next_block = mp_block_head;
> -		p->next_free = (char *) p->space;
> -		p->end = p->next_free + mem_pool_alloc;
> -		mp_block_head = p;
> +		if (len >= (fi_mem_pool.block_alloc / 2))
> +			p = pool_alloc_block_with_size(len);
> +		else
> +			p = pool_alloc_block();

So we used to fulfill large request directly from xmalloc() but now
we create a new block, which is large enough to fulfill the request
but otherwise unusable for helping later requests, and queue that to
the mem_pool structure.

It _might_ be a justifiable change in behaviour, but is entirely
unexpected from a refactoring patch that wants to "wrap the existing
mp_block in this new type", especially without justifying why in the
proposed log message.
