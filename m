Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7E76220A26
	for <e@80x24.org>; Thu, 28 Sep 2017 11:03:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752829AbdI1LDL (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Sep 2017 07:03:11 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56712 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751591AbdI1LDJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Sep 2017 07:03:09 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 43E87A1741;
        Thu, 28 Sep 2017 07:03:03 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ykzY47pKWw7k2aAbUuSI3hPmfic=; b=UXscxb
        sPi5KWTKdffjSeJtYu1SwiHz8p8SLqph8xWFpGLAkDTn8sn1GKGF08zV+9R7jPif
        ivTPOnMcxAhDdOZVoyUVtEUZAi3e6O/e/XR7a01yYr239A6117twf3nZb3hyYOpZ
        PVrL11awyq0GMEHAupgVAbXmXM64GSFW8OTyE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=E8RnjLJEN9HypeyOhcdPbyWpuFG75RHi
        ThFCwcFO48PAzcZWmaljO5FUn0YpDUw5uQOqcPtQoEWanfaR5uvPA4aXMkNiuqiO
        Kfsyj5T7MPPqIyny94KhYE+GbW95zP++Fq4FhKWSlJ83EyuM8NmtLU7Fr7KgNhHW
        aixXTB7tJ4c=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2A469A173F;
        Thu, 28 Sep 2017 07:03:03 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1C4BAA173A;
        Thu, 28 Sep 2017 07:03:02 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Olga Telezhnaya <olyatelezhnaya@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH Outreachy] mru: use double-linked list from list.h
References: <CAP8UFD24A8rxMfLMFmSStWnBMMeB58SqUdNoo3niQuc7LqRMMg@mail.gmail.com>
        <0102015ec7a3424b-529be659-bdb6-42c4-a48f-db264f33d53a-000000@eu-west-1.amazonses.com>
Date:   Thu, 28 Sep 2017 20:03:00 +0900
In-Reply-To: <0102015ec7a3424b-529be659-bdb6-42c4-a48f-db264f33d53a-000000@eu-west-1.amazonses.com>
        (Olga Telezhnaya's message of "Thu, 28 Sep 2017 08:38:39 +0000")
Message-ID: <xmqq8tgz13x7.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 987BE6F4-A43C-11E7-AD20-FE4B1A68708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Olga Telezhnaya <olyatelezhnaya@gmail.com> writes:

> Simplify mru.c, mru.h and related code by reusing the double-linked list implementation from list.h instead of a custom one.

An overlong line (I can locally wrap it, so the patch does not have
to be re-sent only to fix this alone).

> Signed-off-by: Olga Telezhnaia <olyatelezhnaya@gmail.com>

Thanks for making your "From:" name match the "Signed-off-by:" name;
anglicising like you did is probably more friendly to the readers
than writing both in Cyrillic, which is another valid way to make
them match.

> Mentored-by: Christian Couder <christian.couder@gmail.com>
> Mentored by: Jeff King <peff@peff.net>
> ---
>  builtin/pack-objects.c |  5 +++--
>  mru.c                  | 51 +++++++++++++++-----------------------------------
>  mru.h                  | 31 +++++++++++++-----------------
>  packfile.c             |  6 ++++--
>  4 files changed, 35 insertions(+), 58 deletions(-)

As Christian mentioned earlier, nice line reduction ;-)

> diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
> index f721137eaf881..ba812349e0aab 100644
> --- a/builtin/pack-objects.c
%> +++ b/builtin/pack-objects.c
> @@ -995,8 +995,8 @@ static int want_object_in_pack(const unsigned char *sha1,
>  			       struct packed_git **found_pack,
>  			       off_t *found_offset)
>  {
> -	struct mru_entry *entry;
>  	int want;
> +	struct list_head *pos;
>  
>  	if (!exclude && local && has_loose_object_nonlocal(sha1))
>  		return 0;
> @@ -1012,7 +1012,8 @@ static int want_object_in_pack(const unsigned char *sha1,
>  			return want;
>  	}
>  
> -	for (entry = packed_git_mru.head; entry; entry = entry->next) {
> +	list_for_each(pos, &packed_git_mru.list) {
> +		struct mru *entry = list_entry(pos, struct mru, list);
>  		struct packed_git *p = entry->item;
>  		off_t offset;

I was a bit surprised to see a change outside mru.[ch] like this
one.  The reason why I was surprised was because I expected mru.[ch]
would offer its own API that encapsulates enumeration like this one
and this patch would just be reimplementing that API using the list
API, instead of rewriting the users of mru API to directly access
the list API.

Alas, there is no such mru API that lets a mru user to iterate over
elements, so the original of the above code were using mru's
implementation detail directly.

We probably want to invent mru_for_each() that hides the fact that
mru is implemented in terms of list_head from the users of mru API
and use it here.

> diff --git a/mru.c b/mru.c
> index 9dedae0287ed2..8b6ba3d9b7fad 100644
> --- a/mru.c
> +++ b/mru.c
> @@ -1,50 +1,29 @@
>  #include "cache.h"
>  #include "mru.h"
>  
> -void mru_append(struct mru *mru, void *item)
> +void mru_append(struct mru *head, void *item)
>  {
> -	struct mru_entry *cur = xmalloc(sizeof(*cur));
> +	struct mru *cur = xmalloc(sizeof(*cur));
>  	cur->item = item;
> -	cur->prev = mru->tail;
> -	cur->next = NULL;
> -
> -	if (mru->tail)
> -		mru->tail->next = cur;
> -	else
> -		mru->head = cur;
> -	mru->tail = cur;
> +	list_add_tail(&cur->list, &head->list);
>  }
>  
> -void mru_mark(struct mru *mru, struct mru_entry *entry)
> +void mru_mark(struct mru *head, struct mru *entry)
>  {
> -	/* If we're already at the front of the list, nothing to do */
> -	if (mru->head == entry)
> -		return;
> -
> -	/* Otherwise, remove us from our current slot... */
> -	if (entry->prev)
> -		entry->prev->next = entry->next;
> -	if (entry->next)
> -		entry->next->prev = entry->prev;
> -	else
> -		mru->tail = entry->prev;
> -
> -	/* And insert us at the beginning. */
> -	entry->prev = NULL;
> -	entry->next = mru->head;
> -	if (mru->head)
> -		mru->head->prev = entry;
> -	mru->head = entry;
> +	/* To mark means to put at the front of the list. */
> +	list_del(&entry->list);
> +	list_add(&entry->list, &head->list);
>  }
>  
> -void mru_clear(struct mru *mru)
> +void mru_clear(struct mru *head)
>  {
> -	struct mru_entry *p = mru->head;
> -
> -	while (p) {
> -		struct mru_entry *to_free = p;
> -		p = p->next;
> +	struct list_head *p1;
> +	struct list_head *p2;
> +	struct mru *to_free;
> +	
> +	list_for_each_safe(p1, p2, &head->list) {
> +		to_free = list_entry(p1, struct mru, list);
>  		free(to_free);
>  	}
> -	mru->head = mru->tail = NULL;
> +	INIT_LIST_HEAD(&head->list);
>  }
> diff --git a/mru.h b/mru.h
> index 42e4aeaa1098a..36a332af0bf88 100644
> --- a/mru.h
> +++ b/mru.h
> @@ -1,6 +1,8 @@
>  #ifndef MRU_H
>  #define MRU_H
>  
> +#include "list.h"
> +
>  /**
>   * A simple most-recently-used cache, backed by a doubly-linked list.
>   *
> @@ -8,18 +10,15 @@
>   *
>   *   // Create a list.  Zero-initialization is required.
>   *   static struct mru cache;
> - *   mru_append(&cache, item);
> - *   ...
> + *   INIT_LIST_HEAD(&cache.list);

"Zero-initialization is required." is no longer true, it seems, and
the comment above needs to be updated, right?

More importantly, this leaks to the user of the API the fact that
mru is internally implemented in terms of the list API, which is
not necessary (when we want to update the implementation later, we'd
need to update all the users again).  Perhaps you'd want

	INIT_MRU(cache);

which is #define'd in this file, perhaps like so:

	#define INIT_MRU(mru)	INIT_LIST_HEAD(&((mru).list))



> - *   // Iterate in MRU order.
> - *   struct mru_entry *p;
> - *   for (p = cache.head; p; p = p->next) {
> - *	if (matches(p->item))
> - *		break;
> - *   }

Ah, here is a good piece that illustrates what I meant earlier.
This could have been something like:

	// Iterate in MRU order.
	struct mru *item;
	mru_for_each(item, &cache) {
		if (matches(item))
			break;
	}

and then the user would not have to know mru is implemented in terms
of the list API.

> + *   // Add new item to the end of the list.
> + *   void *item;
> + *   ...
> + *   mru_append(&cache, item);
>   *
>   *   // Mark an item as used, moving it to the front of the list.
> - *   mru_mark(&cache, p);
> + *   mru_mark(&cache, item);
>   *
>   *   // Reset the list to empty, cleaning up all resources.
>   *   mru_clear(&cache);
> @@ -29,17 +28,13 @@
>   * you will begin traversing the whole list again.
>   */
>  
> -struct mru_entry {
> -	void *item;
> -	struct mru_entry *prev, *next;
> -};
> -
>  struct mru {
> -	struct mru_entry *head, *tail;
> +	struct list_head list;
> +        void *item;
>  };
>  
> -void mru_append(struct mru *mru, void *item);
> -void mru_mark(struct mru *mru, struct mru_entry *entry);
> -void mru_clear(struct mru *mru);
> +void mru_append(struct mru *head, void *item);
> +void mru_mark(struct mru *head, struct mru *entry);
> +void mru_clear(struct mru *head);
>  
>  #endif /* MRU_H */
> diff --git a/packfile.c b/packfile.c
> index f69a5c8d607af..ae3b0b2e9c09a 100644
> --- a/packfile.c
> +++ b/packfile.c
> @@ -876,6 +876,7 @@ void prepare_packed_git(void)
>  	for (alt = alt_odb_list; alt; alt = alt->next)
>  		prepare_packed_git_one(alt->path, 0);
>  	rearrange_packed_git();
> +	INIT_LIST_HEAD(&packed_git_mru.list);
>  	prepare_packed_git_mru();
>  	prepare_packed_git_run_once = 1;
>  }
> @@ -1824,13 +1825,14 @@ static int fill_pack_entry(const unsigned char *sha1,
>   */
>  int find_pack_entry(const unsigned char *sha1, struct pack_entry *e)
>  {
> -	struct mru_entry *p;
> +	struct list_head *pos;
>  
>  	prepare_packed_git();
>  	if (!packed_git)
>  		return 0;
>  
> -	for (p = packed_git_mru.head; p; p = p->next) {
> +	list_for_each(pos, &packed_git_mru.list) {
> +		struct mru *p = list_entry(pos, struct mru, list);
>  		if (fill_pack_entry(sha1, e, p->item)) {
>  			mru_mark(&packed_git_mru, p);
>  			return 1;

The same comment as the first hunk applies here, too.

Thanks.
