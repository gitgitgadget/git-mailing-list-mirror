Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9D96A1F406
	for <e@80x24.org>; Mon, 14 May 2018 01:37:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751894AbeENBhn (ORCPT <rfc822;e@80x24.org>);
        Sun, 13 May 2018 21:37:43 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:37538 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751362AbeENBhm (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 13 May 2018 21:37:42 -0400
Received: by mail-wr0-f196.google.com with SMTP id h5-v6so10522750wrm.4
        for <git@vger.kernel.org>; Sun, 13 May 2018 18:37:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=J+9qGzG+MoJZ6sWzjwAXuhM6nWzNse1h7oPreznD+Ls=;
        b=qMIGhuSwgrkT+PLhDv88m94GplWFpE7tt4Lw5Fx9K++nrKCdemkZuCpdqxPBpzPy7X
         P5V5Jr3CvKNjyr0D/meutiPHyTRieBdoPZaZs6Bz2GgZRQBP7Usg//UFJl7ztv+2P8Hc
         Umy1tNtiaJLhTSxsqw1ozqLUvmmdnVDuCJKx794PLWBF2cVdcnJxUGEfuOYQN2hBhAa6
         dwkHDnq9eq+nJETi7e92xVZ03Gbf1fyaBEY5EIpOfK2vjJZFbRvjD6HoCPBptVsX28ma
         A4GjW0KupHmIWsoc7I6f1PwE3Z/rPcWQ0Cp8Zp4ecmiwdK4LGOh0E01l3bUGcXunTgmw
         pGTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=J+9qGzG+MoJZ6sWzjwAXuhM6nWzNse1h7oPreznD+Ls=;
        b=TOMa9o10+z0t66KiURo6o3cMfMxfFAqaZPxw6Ukvz3a5zDbRW/2rnATHYfFrMW92u5
         kvHEYr9+nItN4mBPoSg6pEL4C+SjoZ01sug7Ri6qu5tmzaIO4DpdgfDblVrniREtUUyQ
         23ZlRP9x0kai+LCSLyjrOr8C58P7jZjFo5bgGYHqXAyKXAc1FlP4rpnf3XoCkZa0kSil
         zoIUdE11y+QDhA+iKnmrLH4E9zJyLZOiqZ8KNO1Sg5b88EOZs2/IQ2D92tWbGO4jiKdX
         TtZNuYQGKep/hI8QTeVGSB5HaYZ+GNJOPcoHAJCNamLJekTRE3HzxjjrNQ1T7vsTl89Y
         J2Bw==
X-Gm-Message-State: ALKqPwdPN6OukaQ5Lpt1ttHTpKxNyWw3K9Ehd+eyC58GFFKZfl6a0+HP
        UasYFU/L2q2258HkRHDqKmA=
X-Google-Smtp-Source: AB8JxZoQn/HT2sRgSpdoBAFCcIiiQV87x0HtpywA0aeyM+81d+dW8LER+KW0vG7aQSDQdQqehRHjxw==
X-Received: by 2002:adf:df07:: with SMTP id y7-v6mr5144642wrl.279.1526261860552;
        Sun, 13 May 2018 18:37:40 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id w11-v6sm10925870wrn.86.2018.05.13.18.37.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 13 May 2018 18:37:38 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Jeff King <peff@peff.net>, Duy Nguyen <pclouds@gmail.com>,
        Git List <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] fast-export: avoid NULL pointer arithmetic
References: <d50a4d5d-3b99-453e-1b52-4e733453fb78@web.de>
        <99d443cd-e817-7db5-f758-bf4cf47f7c06@web.de>
        <xmqqo9hniy1v.fsf@gitster-ct.c.googlers.com>
        <654fac2a-8dca-7bee-2bab-a3986aa7e52d@web.de>
        <xmqqbmdnhr8b.fsf@gitster-ct.c.googlers.com>
        <xmqq7eoahk49.fsf@gitster-ct.c.googlers.com>
        <CACsJy8AN4nssu1+x0x9Kmz1BB1aXO7_UBFCjpyULMeC5K-Fzvw@mail.gmail.com>
        <20180511085634.GC22086@sigill.intra.peff.net>
        <CACsJy8CnJYsgDe11tK4JzH2sDRuLwgoUz=HCso5qOhEfyZNH5Q@mail.gmail.com>
        <20180511133419.GA2170@duynguyen.home>
        <20180511174237.GA19670@sigill.intra.peff.net>
        <80397e16-8667-e0cd-4049-aad453d35e6f@web.de>
Date:   Mon, 14 May 2018 10:37:38 +0900
In-Reply-To: <80397e16-8667-e0cd-4049-aad453d35e6f@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Sat, 12 May 2018 10:45:16 +0200")
Message-ID: <xmqqwow7c90d.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

René Scharfe <l.s.r@web.de> writes:

> Storing integer values in pointers is a trick that seems to have worked
> so far for fast-export.  A portable way to avoid that trick without
> requiring more memory would be to use a union.
>
> Or we could roll our own custom hash map, as I mused in an earlier post.
> That would duplicate quite a bit of code; are there reusable pieces
> hidden within that could be extracted into common functions?

Hmm, this together with your follow-up does not look too bad, but it
does introduce quite a lot of code that could be refactored, so I am
not sure if I really like it or not.

>
> ---
>  builtin/fast-export.c | 105 ++++++++++++++++++++++++++++++++----------
>  1 file changed, 81 insertions(+), 24 deletions(-)
>
> diff --git a/builtin/fast-export.c b/builtin/fast-export.c
> index 530df12f05..627b0032f3 100644
> --- a/builtin/fast-export.c
> +++ b/builtin/fast-export.c
> @@ -14,7 +14,6 @@
>  #include "diffcore.h"
>  #include "log-tree.h"
>  #include "revision.h"
> -#include "decorate.h"
>  #include "string-list.h"
>  #include "utf8.h"
>  #include "parse-options.h"
> @@ -71,9 +70,65 @@ static int parse_opt_tag_of_filtered_mode(const struct option *opt,
>  	return 0;
>  }
>  
> -static struct decoration idnums;
> +struct object_mark_entry {
> +	const struct object *base;
> +	uint32_t mark;
> +};
> +
> +struct object_marks {
> +	unsigned int size;
> +	unsigned int nr;
> +	struct object_mark_entry *entries;
> +};
> +
> +static struct object_marks idnums;
>  static uint32_t last_idnum;
>  
> +static unsigned int hash_obj(const struct object *obj, unsigned int n)
> +{
> +	return sha1hash(obj->oid.hash) % n;
> +}
> +
> +static void set_object_mark(struct object_marks *n, const struct object *base,
> +			    uint32_t mark)
> +{
> +	unsigned int size = n->size;
> +	struct object_mark_entry *entries = n->entries;
> +	unsigned int j = hash_obj(base, size);
> +
> +	while (entries[j].base) {
> +		if (entries[j].base == base) {
> +			entries[j].mark = mark;
> +			return;
> +		}
> +		if (++j >= size)
> +			j = 0;
> +	}
> +	entries[j].base = base;
> +	entries[j].mark = mark;
> +	n->nr++;
> +}
> +
> +static void grow_object_marks(struct object_marks *n)
> +{
> +	unsigned int i;
> +	unsigned int old_size = n->size;
> +	struct object_mark_entry *old_entries = n->entries;
> +
> +	n->size = (old_size + 1000) * 3 / 2;
> +	n->entries = xcalloc(n->size, sizeof(n->entries[0]));
> +	n->nr = 0;
> +
> +	for (i = 0; i < old_size; i++) {
> +		const struct object *base = old_entries[i].base;
> +		uint32_t mark = old_entries[i].mark;
> +
> +		if (mark)
> +			set_object_mark(n, base, mark);
> +	}
> +	free(old_entries);
> +}
> +
>  static int has_unshown_parent(struct commit *commit)
>  {
>  	struct commit_list *parent;
> @@ -156,20 +211,13 @@ static void anonymize_path(struct strbuf *out, const char *path,
>  	}
>  }
>  
> -/* Since intptr_t is C99, we do not use it here */
> -static inline uint32_t *mark_to_ptr(uint32_t mark)
> -{
> -	return ((uint32_t *)NULL) + mark;
> -}
> -
> -static inline uint32_t ptr_to_mark(void * mark)
> -{
> -	return (uint32_t *)mark - (uint32_t *)NULL;
> -}
> -
>  static inline void mark_object(struct object *object, uint32_t mark)
>  {
> -	add_decoration(&idnums, object, mark_to_ptr(mark));
> +	unsigned int nr = idnums.nr + 1;
> +
> +	if (nr > idnums.size * 2 / 3)
> +		grow_object_marks(&idnums);
> +	return set_object_mark(&idnums, object, mark);
>  }
>  
>  static inline void mark_next_object(struct object *object)
> @@ -179,10 +227,21 @@ static inline void mark_next_object(struct object *object)
>  
>  static int get_object_mark(struct object *object)
>  {
> -	void *decoration = lookup_decoration(&idnums, object);
> -	if (!decoration)
> +	unsigned int j;
> +
> +	/* nothing to lookup */
> +	if (!idnums.size)
>  		return 0;
> -	return ptr_to_mark(decoration);
> +	j = hash_obj(object, idnums.size);
> +	for (;;) {
> +		struct object_mark_entry *ref = idnums.entries + j;
> +		if (ref->base == object)
> +			return ref->mark;
> +		if (!ref->base)
> +			return 0;
> +		if (++j == idnums.size)
> +			j = 0;
> +	}
>  }
>  
>  static void show_progress(void)
> @@ -897,8 +956,7 @@ static void handle_tags_and_duplicates(void)
>  static void export_marks(char *file)
>  {
>  	unsigned int i;
> -	uint32_t mark;
> -	struct decoration_entry *deco = idnums.entries;
> +	struct object_mark_entry *entry = idnums.entries;
>  	FILE *f;
>  	int e = 0;
>  
> @@ -907,15 +965,14 @@ static void export_marks(char *file)
>  		die_errno("Unable to open marks file %s for writing.", file);
>  
>  	for (i = 0; i < idnums.size; i++) {
> -		if (deco->base && deco->base->type == 1) {
> -			mark = ptr_to_mark(deco->decoration);
> -			if (fprintf(f, ":%"PRIu32" %s\n", mark,
> -				oid_to_hex(&deco->base->oid)) < 0) {
> +		if (entry->base && entry->base->type == 1) {
> +			if (fprintf(f, ":%"PRIu32" %s\n", entry->mark,
> +				    oid_to_hex(&entry->base->oid)) < 0) {
>  			    e = 1;
>  			    break;
>  			}
>  		}
> -		deco++;
> +		entry++;
>  	}
>  
>  	e |= ferror(f);
