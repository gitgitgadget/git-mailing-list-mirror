Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 39C801F428
	for <e@80x24.org>; Wed, 29 Aug 2018 17:12:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728173AbeH2VKc (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 Aug 2018 17:10:32 -0400
Received: from mail-wr1-f46.google.com ([209.85.221.46]:43550 "EHLO
        mail-wr1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727716AbeH2VKb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Aug 2018 17:10:31 -0400
Received: by mail-wr1-f46.google.com with SMTP id k5-v6so5525416wre.10
        for <git@vger.kernel.org>; Wed, 29 Aug 2018 10:12:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=HbeuqUJhFda7JpaWW9CO5a8d95AdXV3jtEBS66Jx/XU=;
        b=l1tHlAOW3fkGB4S77GDec/MTsKp8QSNwIeG8sRd0RVy+TGjizzFmUE1Ew1g6qAnRg0
         K9+W34nmJUpfXUpG5TKKldXx6m5PsMsyL22ghYejf9MQHXcxvuqxur0C8iF3QV8G1Q2o
         8/51VHLJ1H0irI3t0eqvrX8JV8ISCKheYdRirMz3GJE31Iv19cokWVDcj59jp3CPw0h0
         iUkYWYifDPDppQUoJuwYomPxUjeKh7O5A7E/DzOvVV6vRVPQAv1LOV3AffCDYlTzHCYq
         EGvqgXqhhUo7+YS9+ab2x09bXG3kkPx8LYozxU/7iCSNfDQssArRibi8GpGf9KVFb9qV
         eXkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=HbeuqUJhFda7JpaWW9CO5a8d95AdXV3jtEBS66Jx/XU=;
        b=smMsJ00GGdzW93EUGU7zwNQqqwCGBdlUDHpx476c4AKLqRqthZWoPrsT0VBeeOhCC/
         7VdoRvV+tMbnka/Z9ypRAS/FhLdC4u9eUa06DHwmSo3Aeldwj4TYQM8CvkXp6M4m92nB
         u9iLnjdNzpfbgxpDRHaZok+eobXq6vq5wV+kyFGp91gbF7X1/kUU3IklAu6YCQsMzhF1
         IzzFIDGNtiQ4fJxuPY1SimwKl7IxNx+baiwXY0TNaOx41jjUX1/7SWMsYBF1o5rAOxCP
         H6wVDLt7KkgalaFJqK9jYmJaTPESvSXgDDL7EAfEUgx4s0f+lq/TsbiixJqxLxmIJxwe
         jXrg==
X-Gm-Message-State: APzg51DzCHAfz0TVb9dw2p9TeOFkBFdBGTWTEviB9Ug4+oLSjz0hjBsd
        XKA5uxFlZFvoiJ2D4qimBu4=
X-Google-Smtp-Source: ANB0VdYshcUBrc8Lf3juNKKrOTxyhv7MpyBidW1i/pFn9NX+ko80fT5OmajeGLdnUF8nJlfW/sdHaA==
X-Received: by 2002:a5d:438d:: with SMTP id i13-v6mr5176854wrq.156.1535562756910;
        Wed, 29 Aug 2018 10:12:36 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id 144-v6sm7684443wma.19.2018.08.29.10.12.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 29 Aug 2018 10:12:36 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ben Peart <Ben.Peart@microsoft.com>
Cc:     "git\@vger.kernel.org" <git@vger.kernel.org>,
        "pclouds\@gmail.com" <pclouds@gmail.com>
Subject: Re: [PATCH v2 2/3] read-cache: load cache extensions on worker thread
References: <20180823154053.20212-1-benpeart@microsoft.com>
        <20180829152500.46640-1-benpeart@microsoft.com>
        <20180829152500.46640-3-benpeart@microsoft.com>
Date:   Wed, 29 Aug 2018 10:12:35 -0700
In-Reply-To: <20180829152500.46640-3-benpeart@microsoft.com> (Ben Peart's
        message of "Wed, 29 Aug 2018 15:25:20 +0000")
Message-ID: <xmqqk1o9cd18.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ben Peart <Ben.Peart@microsoft.com> writes:

> This is possible because the current extensions don't access the cache
> entries in the index_state structure so are OK that they don't all exist
> yet.
>
> The CACHE_EXT_TREE, CACHE_EXT_RESOLVE_UNDO, and CACHE_EXT_UNTRACKED
> extensions don't even get a pointer to the index so don't have access to the
> cache entries.
>
> CACHE_EXT_LINK only uses the index_state to initialize the split index.
> CACHE_EXT_FSMONITOR only uses the index_state to save the fsmonitor last
> update and dirty flags.

Good to see such an analysis here.  Once we define an extension
section, which requires us to have the cache entries before
populating it, this scheme would falls down, of course, but the
extension mechanism is all about protecting ourselves from the
future changes, so we'd at least need a good feel for how we read an
unknown extension from the future with the current code.  Perhaps
just like the main cache entries were pre-scanned to apportion them
to worker threads, we can pre-scan the sections and compare them
with a white-list built into our binary before deciding that it is
safe to read them in parallel (and otherwise, we ask the last thread
for reading extensions to wait until the workers that read the main
index all return)?

> -/*
> -* A thread proc to run the load_cache_entries() computation
> -* across multiple background threads.
> -*/

This one was mis-indented (lacking SP before '*') but they are gone
so ... ;-)

> @@ -1978,6 +1975,36 @@ static void *load_cache_entries_thread(void *_data)
>  	return NULL;
>  }
>  
> +static void *load_index_extensions_thread(void *_data)
> +{
> +	struct load_cache_entries_thread_data *p = _data;
> +	unsigned long src_offset = p->start_offset;
> +
> +	while (src_offset <= p->mmap_size - the_hash_algo->rawsz - 8) {
> +		/* After an array of active_nr index entries,
> +		 * there can be arbitrary number of extended
> +		 * sections, each of which is prefixed with
> +		 * extension name (4-byte) and section length
> +		 * in 4-byte network byte order.
> +		 */
> +		uint32_t extsize;
> +		memcpy(&extsize, (char *)p->mmap + src_offset + 4, 4);
> +		extsize = ntohl(extsize);
> +		if (read_index_extension(p->istate,
> +								(const char *)p->mmap + src_offset,
> +								(char *)p->mmap + src_offset + 8,
> +								extsize) < 0) {

Overly deep indentation.  Used a wrong tab-width?

> +	/* allocate an extra thread for loading the index extensions */
>  	ce_per_thread = DIV_ROUND_UP(istate->cache_nr, nr_threads);
> -	data = xcalloc(nr_threads, sizeof(struct load_cache_entries_thread_data));
> +	data = xcalloc(nr_threads + 1, sizeof(struct load_cache_entries_thread_data));
>  
>  	/*
>  	 * Loop through index entries starting a thread for every ce_per_thread
> -	 * entries. Exit the loop when we've created the final thread (no need
> -	 * to parse the remaining entries.
> +	 * entries.
>  	 */

I see.  Now the pre-parsing process needs to go through all the
cache entries to find the beginning of the extensions section.

>  	consumed = thread = 0;
> -	for (i = 0; ; i++) {
> +	for (i = 0; i < istate->cache_nr; i++) {
>  		struct ondisk_cache_entry *ondisk;
>  		const char *name;
>  		unsigned int flags;
> @@ -2055,9 +2082,7 @@ static unsigned long load_cache_entries(struct index_state *istate,
>  			if (pthread_create(&p->pthread, NULL, load_cache_entries_thread, p))
>  				die("unable to create load_cache_entries_thread");
>  
> -			/* exit the loop when we've created the last thread */
> -			if (++thread == nr_threads)
> -				break;
> +			++thread;

This is not C++, and in (void) context, the codebase always prefers
post-increment.

> @@ -2086,7 +2111,18 @@ static unsigned long load_cache_entries(struct index_state *istate,
>  			src_offset += (name - ((char *)ondisk)) + expand_name_field(previous_name, name);
>  	}
>  
> -	for (i = 0; i < nr_threads; i++) {
> +	/* create a thread to load the index extensions */
> +	struct load_cache_entries_thread_data *p = &data[thread];

This probably triggers decl-after-statement.

> +	p->istate = istate;
> +	mem_pool_init(&p->ce_mem_pool, 0);
> +	p->mmap = mmap;
> +	p->mmap_size = mmap_size;
> +	p->start_offset = src_offset;
> +
> +	if (pthread_create(&p->pthread, NULL, load_index_extensions_thread, p))
> +		die("unable to create load_index_extensions_thread");
> +
> +	for (i = 0; i < nr_threads + 1; i++) {
>  		struct load_cache_entries_thread_data *p = data + i;
>  		if (pthread_join(p->pthread, NULL))
>  			die("unable to join load_cache_entries_thread");
