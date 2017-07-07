Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D94C7202AE
	for <e@80x24.org>; Fri,  7 Jul 2017 02:33:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753257AbdGGCdh (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Jul 2017 22:33:37 -0400
Received: from mail-pf0-f171.google.com ([209.85.192.171]:34123 "EHLO
        mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753252AbdGGCdg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Jul 2017 22:33:36 -0400
Received: by mail-pf0-f171.google.com with SMTP id q85so9820984pfq.1
        for <git@vger.kernel.org>; Thu, 06 Jul 2017 19:33:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=CkiIAZUUv5Lv4DbyBF2lu0/YP+yaIWkjPtgKvKrM+U0=;
        b=iEpLtP5ti3VlfkzAAmpxBqxSmUMPIjaWRRfF/pwBMCBYol/0dqWjjXr+aq+PyZMJpf
         oytNcjFiOdCl/IkGwMiffpF3VFIDwz7WhfH9YmHPjl8f2b+aq6xpBnabcoDh3FlYwMVa
         BwcdhltbLYCzYDratpXBZtHJ5en0dJRTPeDxrzFpcGM4bz800L3fKY3C/LeSapIvY6UL
         jX7AvfG2kpQ5GnEUAgdkL+4QWXLkwmvn3miDyWa84dZShwd1fTLS07WViadxCM/vO8GD
         fY/oz9QspWZB7neWNCdFIoQU+CLuX/MUYdeznubI8Rg0XkGZS3Dw1GRwd9ov59VxpknN
         DNTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=CkiIAZUUv5Lv4DbyBF2lu0/YP+yaIWkjPtgKvKrM+U0=;
        b=AV7hN318/t9yjefT28eJZCBfl2o76TRbwm4IaAjTrEyF5JmY6LCiQYLuz8uqdUyJX5
         EOd0YplUtfwNGxAJSbCwSUhZ0PAB0hJkMa5h3fhRD3zndG7olCsGpUzpuyyTqohL1XQU
         hiih+1qTgK8WD1A0W7RI1BZ4mAxqtvNWvdoRdjgo9Gnge9QYuK3llO+Ystuub38xBUmK
         PS13X1Ffb8wFP5YUqDCZOpaFkExtcvAAYKicy9F/HCyXMmhUiAmdoqRfdPLpbUqASDnQ
         1fl+i9qrwOtLvRVBA2nq/kEPgFr2SEC+IclBiacxAjUlBmFebrIEf1jAXjro8yEw0wGY
         gnvQ==
X-Gm-Message-State: AIVw11282ZvXJqnzrZbOEDjTg5KT+2a2WmVDgForl2vNPsmT/cpou2rL
        Zp/BUERJcYtv7w==
X-Received: by 10.99.167.15 with SMTP id d15mr28821221pgf.42.1499394814902;
        Thu, 06 Jul 2017 19:33:34 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:f878:6796:f790:dc38])
        by smtp.gmail.com with ESMTPSA id w66sm3384836pfi.63.2017.07.06.19.33.33
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 06 Jul 2017 19:33:34 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org, peff@peff.net
Subject: Re: [RFC/WIP PATCH] object store classification
References: <20170706202739.6056-1-sbeller@google.com>
Date:   Thu, 06 Jul 2017 19:33:33 -0700
In-Reply-To: <20170706202739.6056-1-sbeller@google.com> (Stefan Beller's
        message of "Thu, 6 Jul 2017 13:27:39 -0700")
Message-ID: <xmqq7ezldlhe.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> Subject: Re: [RFC/WIP PATCH] object store classification

I thought you are writing different object-store backends and
classifying them into many categories (e.g. local, networked,
telepathic, etc.)

It is a logical next step to put per-repository things into
the_repository.  I skimmed the patch and the changes smelled sane,
but I didn't read it really carefully with fine toothed comb.

Thanks.  The remainder kept for reference, but no additional
comments in there.

> This continues the efforts of bw/repo-object, making our code base
> more object oriented by adding the object store to the the repository struct.
>
> Long term goal of the series that would evolve from this discussion:
> * Easier to implement submodule features as it can be in the same process.
>
> Short term goal:
> * get rid of 'add_submodule_odb' in submodule.c
>   When fetching or pushing we need to determine if a submodule needs processing
>   by finding out if certain commits are present.  To do this we add the submodule
>   objects as an alternate object database and do the processing in the same
>   process. In case of multiple submodules, this would pollute the object store
>   hence being slower and increasing memory usage, too.
>
> This patch only changes the object store code to be object oriented based
> on the repository struct.
>
> To go for the short term goal we'd need to convert a few more places, mostly
> all the construction (blob.c, tree.c, commit.c)
>
> This is marked RFC as I'd want to gather feedback if the approach, presented
> in the header files is sound.
>
> Thanks!
>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>
>   Peff, this area of the code seems performance sensitive for a variety of
>   use cases, specifically yours. So I cc'd you here. :)
>
>  object.c     | 77 +++++++++++++++++++++++++++++++++++-------------------------
>  object.h     | 51 ++++++++++++++++++++++++++++++++--------
>  repository.h |  6 +++++
>  3 files changed, 92 insertions(+), 42 deletions(-)
>
> diff --git a/object.c b/object.c
> index 06ba3a11d8..b5ec0bb2f9 100644
> --- a/object.c
> +++ b/object.c
> @@ -5,17 +5,15 @@
>  #include "commit.h"
>  #include "tag.h"
>  
> -static struct object **obj_hash;
> -static int nr_objs, obj_hash_size;
> -
> -unsigned int get_max_object_index(void)
> +unsigned int object_store_get_max_index(struct repository *r)
>  {
> -	return obj_hash_size;
> +	return r->objects.obj_hash_size;
>  }
>  
> -struct object *get_indexed_object(unsigned int idx)
> +struct object *object_store_get_indexed(struct repository *r,
> +					unsigned int idx)
>  {
> -	return obj_hash[idx];
> +	return r->objects.obj_hash[idx];
>  }
>  
>  static const char *object_type_strings[] = {
> @@ -82,11 +80,15 @@ static void insert_obj_hash(struct object *obj, struct object **hash, unsigned i
>   * Look up the record for the given sha1 in the hash map stored in
>   * obj_hash.  Return NULL if it was not found.
>   */
> -struct object *lookup_object(const unsigned char *sha1)
> +struct object *object_store_lookup(struct repository *r,
> +				   const unsigned char *sha1)
>  {
>  	unsigned int i, first;
>  	struct object *obj;
>  
> +	struct object **obj_hash = r->objects.obj_hash;
> +	int obj_hash_size = r->objects.obj_hash_size;
> +
>  	if (!obj_hash)
>  		return NULL;
>  
> @@ -114,29 +116,31 @@ struct object *lookup_object(const unsigned char *sha1)
>   * power of 2 (but at least 32).  Copy the existing values to the new
>   * hash map.
>   */
> -static void grow_object_hash(void)
> +static void grow_object_hash(struct repository *r)
>  {
>  	int i;
>  	/*
>  	 * Note that this size must always be power-of-2 to match hash_obj
>  	 * above.
>  	 */
> -	int new_hash_size = obj_hash_size < 32 ? 32 : 2 * obj_hash_size;
> +	int new_hash_size = r->objects.obj_hash_size < 32 ?
> +			32 : 2 * r->objects.obj_hash_size;
>  	struct object **new_hash;
>  
>  	new_hash = xcalloc(new_hash_size, sizeof(struct object *));
> -	for (i = 0; i < obj_hash_size; i++) {
> -		struct object *obj = obj_hash[i];
> +	for (i = 0; i < r->objects.obj_hash_size; i++) {
> +		struct object *obj = r->objects.obj_hash[i];
>  		if (!obj)
>  			continue;
>  		insert_obj_hash(obj, new_hash, new_hash_size);
>  	}
> -	free(obj_hash);
> -	obj_hash = new_hash;
> -	obj_hash_size = new_hash_size;
> +	free(r->objects.obj_hash);
> +	r->objects.obj_hash = new_hash;
> +	r->objects.obj_hash_size = new_hash_size;
>  }
>  
> -void *create_object(const unsigned char *sha1, void *o)
> +void *object_store_create(struct repository *r,
> +			  const unsigned char *sha1, void *o)
>  {
>  	struct object *obj = o;
>  
> @@ -145,15 +149,17 @@ void *create_object(const unsigned char *sha1, void *o)
>  	obj->flags = 0;
>  	hashcpy(obj->oid.hash, sha1);
>  
> -	if (obj_hash_size - 1 <= nr_objs * 2)
> -		grow_object_hash();
> +	if (r->objects.obj_hash_size - 1 <= r->objects.nr_objs * 2)
> +		grow_object_hash(r);
>  
> -	insert_obj_hash(obj, obj_hash, obj_hash_size);
> -	nr_objs++;
> +	insert_obj_hash(obj, r->objects.obj_hash, r->objects.obj_hash_size);
> +	r->objects.nr_objs++;
>  	return obj;
>  }
>  
> -void *object_as_type(struct object *obj, enum object_type type, int quiet)
> +void *object_as_type(struct object *obj,
> +		     enum object_type type,
> +		     int quiet)
>  {
>  	if (obj->type == type)
>  		return obj;
> @@ -172,15 +178,20 @@ void *object_as_type(struct object *obj, enum object_type type, int quiet)
>  	}
>  }
>  
> -struct object *lookup_unknown_object(const unsigned char *sha1)
> +struct object *object_store_lookup_unknown_object(struct repository *r,
> +						  const unsigned char *sha1)
>  {
> -	struct object *obj = lookup_object(sha1);
> +	struct object *obj = object_store_lookup(r, sha1);
>  	if (!obj)
> -		obj = create_object(sha1, alloc_object_node());
> +		obj = object_store_create(r, sha1, alloc_object_node());
>  	return obj;
>  }
>  
> -struct object *parse_object_buffer(const struct object_id *oid, enum object_type type, unsigned long size, void *buffer, int *eaten_p)
> +struct object *object_store_parse_object_buffer(struct repository *r,
> +						const struct object_id *oid,
> +						enum object_type type,
> +						unsigned long size,
> +						void *buffer, int *eaten_p)
>  {
>  	struct object *obj;
>  	*eaten_p = 0;
> @@ -230,17 +241,19 @@ struct object *parse_object_buffer(const struct object_id *oid, enum object_type
>  	return obj;
>  }
>  
> -struct object *parse_object_or_die(const struct object_id *oid,
> -				   const char *name)
> +struct object *object_store_parse_object_or_die(struct repository *r,
> +						const struct object_id *oid,
> +						const char *name)
>  {
> -	struct object *o = parse_object(oid);
> +	struct object *o = object_store_parse_object(r, oid);
>  	if (o)
>  		return o;
>  
>  	die(_("unable to parse object: %s"), name ? name : oid_to_hex(oid));
>  }
>  
> -struct object *parse_object(const struct object_id *oid)
> +struct object *object_store_parse_object(struct repository *r,
> +					 const struct object_id *oid)
>  {
>  	unsigned long size;
>  	enum object_type type;
> @@ -413,12 +426,12 @@ void object_array_remove_duplicates(struct object_array *array)
>  	}
>  }
>  
> -void clear_object_flags(unsigned flags)
> +void object_store_clear_object_flags(struct repository *r, unsigned flags)
>  {
>  	int i;
>  
> -	for (i=0; i < obj_hash_size; i++) {
> -		struct object *obj = obj_hash[i];
> +	for (i = 0; i < r->objects.obj_hash_size; i++) {
> +		struct object *obj = r->objects.obj_hash[i];
>  		if (obj)
>  			obj->flags &= ~flags;
>  	}
> diff --git a/object.h b/object.h
> index 33e5cc9943..1b2ab8ee88 100644
> --- a/object.h
> +++ b/object.h
> @@ -1,6 +1,8 @@
>  #ifndef OBJECT_H
>  #define OBJECT_H
>  
> +#include "repository.h"
> +
>  struct object_list {
>  	struct object *item;
>  	struct object_list *next;
> @@ -59,12 +61,15 @@ extern int type_from_string_gently(const char *str, ssize_t, int gentle);
>  /*
>   * Return the current number of buckets in the object hashmap.
>   */
> -extern unsigned int get_max_object_index(void);
> +extern unsigned int object_store_get_max_index(struct repository *r);
> +#define get_max_object_index() object_store_get_max_index(the_repository)
>  
>  /*
>   * Return the object from the specified bucket in the object hashmap.
>   */
> -extern struct object *get_indexed_object(unsigned int);
> +extern struct object *object_store_get_indexed(struct repository *r,
> +					       unsigned int);
> +#define get_indexed_object(i) object_store_get_indexed(the_repository, i)
>  
>  /*
>   * This can be used to see if we have heard of the object before, but
> @@ -78,34 +83,59 @@ extern struct object *get_indexed_object(unsigned int);
>   * half-initialised objects, the caller is expected to initialize them
>   * by calling parse_object() on them.
>   */
> -struct object *lookup_object(const unsigned char *sha1);
> +extern struct object *object_store_lookup(struct repository *r,
> +					  const unsigned char *sha1);
> +#define lookup_object(hash) object_store_lookup(the_repository, hash)
>  
> -extern void *create_object(const unsigned char *sha1, void *obj);
> +extern void *object_store_create(struct repository *r,
> +				 const unsigned char *sha1,
> +				 void *obj);
> +#define create_object(sha1, obj) object_store_create(the_repository, sha1, obj)
>  
> -void *object_as_type(struct object *obj, enum object_type type, int quiet);
> +extern void *object_as_type(struct object *obj,
> +			    enum object_type type,
> +			    int quiet);
>  
>  /*
>   * Returns the object, having parsed it to find out what it is.
>   *
>   * Returns NULL if the object is missing or corrupt.
>   */
> -struct object *parse_object(const struct object_id *oid);
> +extern struct object *object_store_parse_object(struct repository *r,
> +						const struct object_id *oid);
> +#define parse_object(sha1) \
> +	object_store_parse_object(the_repository, sha1)
>  
>  /*
>   * Like parse_object, but will die() instead of returning NULL. If the
>   * "name" parameter is not NULL, it is included in the error message
>   * (otherwise, the hex object ID is given).
>   */
> -struct object *parse_object_or_die(const struct object_id *oid, const char *name);
> +extern struct object *object_store_parse_object_or_die(struct repository *r,
> +						       const struct object_id *oid,
> +						       const char *name);
> +#define parse_object_or_die(oid, name) \
> +	object_store_parse_object_or_die(the_repository, oid, name)
>  
>  /* Given the result of read_sha1_file(), returns the object after
>   * parsing it.  eaten_p indicates if the object has a borrowed copy
>   * of buffer and the caller should not free() it.
>   */
> -struct object *parse_object_buffer(const struct object_id *oid, enum object_type type, unsigned long size, void *buffer, int *eaten_p);
> +struct object *object_store_parse_object_buffer(struct repository *r,
> +						const struct object_id *oid,
> +						enum object_type type,
> +						unsigned long size,
> +						void *buffer,
> +						int *eaten_p);
> +#define parse_object_buffer(oid, type, size, buffer, eaten_p) \
> +	object_store_parse_object_buffer(the_repository, oid, type, \
> +					 size, buffer, eaten_p)
>  
>  /** Returns the object, with potentially excess memory allocated. **/
> -struct object *lookup_unknown_object(const unsigned  char *sha1);
> +struct object *object_store_lookup_unknown_object(struct repository *r,
> +						  const unsigned char *sha1);
> +#define lookup_unknown_object(sha1) \
> +	object_store_lookup_unknown_object(the_repository, sha1)
>  
>  struct object_list *object_list_insert(struct object *item,
>  				       struct object_list **list_p);
> @@ -138,6 +168,7 @@ void object_array_remove_duplicates(struct object_array *array);
>   */
>  void object_array_clear(struct object_array *array);
>  
> -void clear_object_flags(unsigned flags);
> +extern void object_store_clear_object_flags(struct repository *r, unsigned flags);
> +#define clear_object_flags(flags) object_store_clear_object_flags(the_repository, flags);
>  
>  #endif /* OBJECT_H */
> diff --git a/repository.h b/repository.h
> index 417787f3ef..aeb50a19bc 100644
> --- a/repository.h
> +++ b/repository.h
> @@ -1,6 +1,8 @@
>  #ifndef REPOSITORY_H
>  #define REPOSITORY_H
>  
> +#include "object.h"
> +
>  struct config_set;
>  struct index_state;
>  struct submodule_cache;
> @@ -24,6 +26,10 @@ struct repository {
>  	 * Cannot be NULL after initialization.
>  	 */
>  	char *objectdir;
> +	struct object_store {
> +		struct object **obj_hash;
> +		int nr_objs, obj_hash_size;
> +	} objects;
>  
>  	/*
>  	 * Path to the repository's graft file.

