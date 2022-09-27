Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B41CDC07E9D
	for <git@archiver.kernel.org>; Tue, 27 Sep 2022 13:32:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232835AbiI0NcA (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Sep 2022 09:32:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232818AbiI0Nbc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Sep 2022 09:31:32 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 959B518D0CA
        for <git@vger.kernel.org>; Tue, 27 Sep 2022 06:27:48 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id z6so15045119wrq.1
        for <git@vger.kernel.org>; Tue, 27 Sep 2022 06:27:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:from:to:cc:subject:date;
        bh=kw5sEieFkpgJzVLkBBtwftOO9BdMRE8iMmbCofIe+rk=;
        b=nuhcAKidDIvPO9JMCep25qT6CvAe5AJwhRSVq9c5xKwRaVKTV4tjPoqMHEbjcIdKfw
         c1DfNOWiSMHoUPwRM5xWANnoPEIDEm6p0GXLbdtHqrGD3O2I4vhuN1WABSBlqcacs5mT
         gmCfouCZcVeX+eYvuLd+wy79K5L46kXnDZUxIA7Yfwom45MVC675IljKv/4gc9MgUK1u
         nh4itstq9ESvRxRMqeqiw5Sc1U6YFofu6ANIBnMxt+iBUq0BN7v/7RK2dHGsAJQI5Ls+
         I35IAA5jMXU7HxN9PuNtezqxSqGSACzU9k0Wyt/ddCI9kwBf495a927660t+nk7nOx7R
         OK4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:x-gm-message-state:from:to:cc:subject:date;
        bh=kw5sEieFkpgJzVLkBBtwftOO9BdMRE8iMmbCofIe+rk=;
        b=GlluMsT6EbO/ILARvd+8BeP6WlyJABSDkyeOvCj0Y15vKlRkVk7p/9V/KFuLQmyEhW
         L3pRl9WHufHV1bwKT3zo7Lcjyuub6Et5udUK8kBSJXmllxfBHXuBA4aHICrpw42WUw94
         LYj+unzzD7VNzhLrTF8yf8mVEgw0eNQigOJECwECnYrWa8c7r4JR4Qcm8q7k+6XNsg9g
         DZ2HswPFhr89EEV2oir9V/drOUjLQLTp+xdclhNEEM0XekB0YuoSrxdV07rnrZVs6ecn
         ULK8aRRr60Zcq8QGBklUMsBL9Yvsh/jhbCNVQ/bHnX8rohq6DiX/2hdheYaNkX4MDrqh
         iy+w==
X-Gm-Message-State: ACrzQf0AVW7Pl9qWv8U5aSuzobK/wgGkxwjE/cZpYUTdDd+DlRfRxVe3
        pSAqb3lEva00EoW/IhJ2cWA=
X-Google-Smtp-Source: AMsMyM4xwHcvLVU50pXqQrBYj2xW3EIhnBuavaoqkKRBSzG/rQ6nmNlceUlqtfVEUkj4qqwXmfWRTg==
X-Received: by 2002:a5d:6da2:0:b0:228:64ca:3978 with SMTP id u2-20020a5d6da2000000b0022864ca3978mr16790669wrs.542.1664285266954;
        Tue, 27 Sep 2022 06:27:46 -0700 (PDT)
Received: from [192.168.1.74] ([31.185.185.144])
        by smtp.gmail.com with ESMTPSA id y1-20020a056000108100b002250c35826dsm1720448wrw.104.2022.09.27.06.27.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Sep 2022 06:27:46 -0700 (PDT)
From:   Phillip Wood <phillip.wood123@gmail.com>
X-Google-Original-From: Phillip Wood <phillip.wood@dunelm.org.uk>
Message-ID: <3c61e0b3-5526-f42e-48a7-c4465d06ccb3@dunelm.org.uk>
Date:   Tue, 27 Sep 2022 14:27:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 05/10] evolve: add the change-table structure
Content-Language: en-US
To:     Stefan Xenos via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Christophe Poucet <christophe.poucet@gmail.com>,
        Stefan Xenos <sxenos@google.com>
References: <pull.1356.git.1663959324.gitgitgadget@gmail.com>
 <2b3a00a6702eb8fb12e45b833ca74155939588ef.1663959325.git.gitgitgadget@gmail.com>
In-Reply-To: <2b3a00a6702eb8fb12e45b833ca74155939588ef.1663959325.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Chris

On 23/09/2022 19:55, Stefan Xenos via GitGitGadget wrote:
> From: Stefan Xenos <sxenos@google.com>
> 
> A change table stores a list of changes, and supports efficient lookup
> from a commit hash to the list of changes that reference that commit
> directly.
> 
> It can be used to look up content commits or metacommits at the head
> of a change, but does not support lookup of commits referenced as part
> of the commit history.
> 
> Signed-off-by: Stefan Xenos <sxenos@google.com>
> Signed-off-by: Chris Poucet <poucet@google.com>

 > diff --git a/change-table.h b/change-table.h
 > new file mode 100644
 > index 00000000000..166b5ed8073
 > --- /dev/null
 > +++ b/change-table.h
 > @@ -0,0 +1,132 @@
 > +#ifndef CHANGE_TABLE_H
 > +#define CHANGE_TABLE_H
 > +
 > +#include "oidmap.h"
 > +
 > +struct commit;
 > +struct ref_filter;
 > +
 > +/**

We tend to just use '/*' rather than '/**'

 > + * This struct holds a list of change refs. The first element is 
stored inline,
 > + * to optimize for small lists.
 > + */
 > +struct change_list {
 > +	/**
 > +	 * Ref name for the first change in the list, or null if none.
 > +	 *
 > +	 * This field is private. Use for_each_change_in to read.
 > +	 */
 > +	const char* first_refname;
 > +	/**
 > +	 * List of additional change refs. Note that this is empty if the list
 > +	 * contains 0 or 1 elements.
 > +	 *
 > +	 * This field is private. Use for_each_change_in to read.
 > +	 */
 > +	struct string_list additional_refnames;

Splitting this feels like a premature optimization. We don't have any 
tests yet, let alone any real-world experience using this code. Also if 
we want to save memory for lists with a single entry why are we 
embedding the struct string_list rather than just storing a pointer to it?

I think it would be simpler to use a struct strset to hold the refnames 
as we don't need the util field offered by struct string_list.

 > +/**
 > + * Holds information about the head of a single change.
 > + */
 > +struct change_head {
 > +	/**
 > +	 * The location pointed to by the head of the change. May be a 
commit or a
 > +	 * metacommit.
 > +	 */
 > +	struct object_id head;

I found this duality between commits and metacommits rather confusing - 
why isn't the head always a metacommit?

 > +/**
 > + * Holds information about the heads of each change, and permits 
effecient

s/effecient/efficient/

 > + * lookup from a commit to the changes that reference it directly.
 > + *
 > + * All fields should be considered private. Use the change_table 
functions
 > + * to interact with this struct.
 > + */
 > +struct change_table {
 > +	/**
 > +	 * Memory pool for the objects allocated by the change table.
 > +	 */
 > +	struct mem_pool memory_pool;
 > +	/* Map object_id to commit_change_list_entry structs. */
 > +	struct oidmap oid_to_metadata_index;
 > +	/**
 > +	 * List of ref names. The util value points to a change_head structure
 > +	 * allocated from memory_pool.
 > +	 */
 > +	struct string_list refname_to_change_head;

I think these days we'd use a strmap for this for O(1) lookups.

 > +};
 > +
 > +extern void change_table_init(struct change_table *to_initialize);

The struct change_table argument to all these functions changes its name 
more often than a criminal on the run. I would find it much easier to 
follow the code if we consistently called this argument "table"

 > + * Adds all changes matching the given ref filter to the given 
change_table
 > + * struct.
 > + */
 > +extern void change_table_add_matching_filter(struct change_table 
*to_modify,
 > +	struct repository* repo, struct ref_filter *filter);

I can't see any callers outside of change-table.c so do we really need 
to export this function.

> diff --git a/change-table.c b/change-table.c
> new file mode 100644
> index 00000000000..c61ba29f1ed
> --- /dev/null
> +++ b/change-table.c
> @@ -0,0 +1,179 @@
> +#include "cache.h"
> +#include "change-table.h"
> +#include "commit.h"
> +#include "ref-filter.h"
> +#include "metacommit-parser.h"
> +
> +void change_table_init(struct change_table *to_initialize)
> +{
> +	memset(to_initialize, 0, sizeof(*to_initialize));
> +	mem_pool_init(&to_initialize->memory_pool, 0);
> +	to_initialize->memory_pool.block_alloc = 4*1024 - sizeof(struct mp_block);

If we're using a mempool to minimize the allocation overhead we should 
leave .block_alloc set to the default value of 1MB rather than changing 
it to 4kB

> +	oidmap_init(&to_initialize->oid_to_metadata_index, 0);
> +	string_list_init_dup(&to_initialize->refname_to_change_head);
> +}
> +
> +static void change_list_clear(struct change_list *to_clear) {
> +	string_list_clear(&to_clear->additional_refnames, 0);
> +}
> +
> +static void commit_change_list_entry_clear(
> +	struct commit_change_list_entry *to_clear) {
> +	change_list_clear(&to_clear->changes);
> +}
> +
> +void change_table_clear(struct change_table *to_clear)
> +{
> +	struct oidmap_iter iter;
> +	struct commit_change_list_entry *next;
> +	for (next = oidmap_iter_first(&to_clear->oid_to_metadata_index, &iter);
> +		next;
> +		next = oidmap_iter_next(&iter)) {
> +
> +		commit_change_list_entry_clear(next);
> +	}
> +
> +	oidmap_free(&to_clear->oid_to_metadata_index, 0);
> +	string_list_clear(&to_clear->refname_to_change_head, 0);
> +	mem_pool_discard(&to_clear->memory_pool, 0);
> +}
> +
> +static void add_head_to_commit(struct change_table *to_modify,
> +	const struct object_id *to_add, const char *refname)

I found the function and argument names rather confusing. If I've 
understood the code correctly then this function is adding an assoation 
between the commit "to_add" and "refname". Despite its name "to_add" may 
already exist in the change table.

The formatting is a bit off as well (as are most of the function 
declarations in this patch and the next), we'd write that as

static void add_head_to_commit(struct change_table *table,
			       const struct object_id *to_add,
			       const char *refname)

> +{
> +	struct commit_change_list_entry *entry;
> +
> +	/**
> +	 * Note: the indices in the map are 1-based. 0 is used to indicate a missing
> +	 * element.
> +	 */

I'm confused by this comment, what indices is it talking about?

> +	entry = oidmap_get(&to_modify->oid_to_metadata_index, to_add);
> +	if (!entry) {
> +		entry = mem_pool_calloc(&to_modify->memory_pool, 1,
> +			sizeof(*entry));
> +		oidcpy(&entry->entry.oid, to_add);
> +		oidmap_put(&to_modify->oid_to_metadata_index, entry);
> +		string_list_init_nodup(&entry->changes.additional_refnames);
> +	}
> +
> +	if (!entry->changes.first_refname)
> +		entry->changes.first_refname = refname;
> +	else
> +		string_list_insert(&entry->changes.additional_refnames, refname);

This is an example of the complexity added by the current definition of 
struct change_list.

> +void change_table_add(struct change_table *to_modify, const char *refname,
> +	struct commit *to_add)
> +{
> +	struct change_head *new_head;
> +	struct string_list_item *new_item;
> +	int metacommit_type;
> +
> +	new_head = mem_pool_calloc(&to_modify->memory_pool, 1,
> +		sizeof(*new_head));
> +
> +	oidcpy(&new_head->head, &to_add->object.oid);
> +
> +	metacommit_type = get_metacommit_content(to_add, &new_head->content);
> +	if (metacommit_type == METACOMMIT_TYPE_NONE)
> +		oidcpy(&new_head->content, &to_add->object.oid);

If to_add is not a metacommit then the content is to_add itself, 
otherwise it will have been set by the call to get_metacommit_content().

> +	new_head->abandoned = (metacommit_type == METACOMMIT_TYPE_ABANDONED);

Style: I don't think we normally bother with parentheses here

> +	new_head->remote = starts_with(refname, "refs/remote/");
> +	new_head->hidden = starts_with(refname, "refs/hiddenmetas/");
> +
> +	new_item = string_list_insert(&to_modify->refname_to_change_head, refname);
> +	new_item->util = new_head;
> +	/* Use pointers to the copy of the string we're retaining locally */

string_list_insert() copied the string and we're using that copy. Saying 
we're retaining it locally when it will outlive this function call is 
confusing.

> +	refname = new_item->string;
> +
> +	if (!oideq(&new_head->content, &new_head->head))
> +		add_head_to_commit(to_modify, &new_head->content, refname);

If to_add is a metacommit then we remember the link between refname and 
the content commit.

> +	add_head_to_commit(to_modify, &new_head->head, refname);

We also remember the link between refname and to_add

> +}
> +
> +void change_table_add_all_visible(struct change_table *to_modify,
> +	struct repository* repo)
> +{
> +	struct ref_filter filter;

rather than using memset we'd write (the same goes for all the other 
memset() calls in this series, unless they're operation on a heap 
allocation)

	struct ref_filter filter = { 0 };

> +	const char *name_patterns[] = {NULL};
> +	memset(&filter, 0, sizeof(filter));
> +	filter.kind = FILTER_REFS_CHANGES;
> +	filter.name_patterns = name_patterns;
> +
> +	change_table_add_matching_filter(to_modify, repo, &filter);
> +}
> +
> +void change_table_add_matching_filter(struct change_table *to_modify,
> +	struct repository* repo, struct ref_filter *filter)
> +{
> +	struct ref_array matching_refs;
> +	int i;
> +
> +	memset(&matching_refs, 0, sizeof(matching_refs));
> +	filter_refs(&matching_refs, filter, filter->kind);
> +
> +	/**
> +	 * Determine the object id for the latest content commit for each change.
> +	 * Fetch the commit at the head of each change ref. If it's a normal commit,
> +	 * that's the commit we want. If it's a metacommit, locate its content parent
> +	 * and use that.
> +	 */
> +
> +	for (i = 0; i < matching_refs.nr; i++) {
> +		struct ref_array_item *item = matching_refs.items[i];
> +		struct commit *commit = item->commit;
> +
> +		commit = lookup_commit_reference_gently(repo, &item->objectname, 1);

We're assigning commit twice - why do we need to look it up if 
filter_refs returns it?

There are a number of places where we call 
lookup_commit_reference_gently(..., 1) to silence the warning if the 
objectname does not dereference to a commit. It is not clear to me that 
we want to hide those errors. Indeed I think we should be doing

		commit = lookup_commit_reference(repo, oid)
		if (!commit)
			BUG("commit missing ...")

unless there is a good reason that the lookup can fail.

> +		if (commit)
> +			change_table_add(to_modify, item->refname, commit);
> +	}
> +
> +	ref_array_clear(&matching_refs);
> +}

> +int for_each_change_referencing(struct change_table *table,
> +	const struct object_id *referenced_commit_id, each_change_fn fn, void *cb_data)
> +{
> +	const struct change_list *changes;
> +	int i;
> +	int retvalue;

We normally use "ret" for this

> +	struct commit_change_list_entry *entry;
> +
> +	entry = oidmap_get(&table->oid_to_metadata_index,
> +		referenced_commit_id);

This should be indented to start below the '(' of the function call.

> +	/* If this commit isn't referenced by any changes, it won't be in the map */
> +	if (!entry)
> +		return 0;
> +	changes = &entry->changes;
> +	if (!changes->first_refname)
> +		return 0;
> +	retvalue = fn(changes->first_refname, cb_data);
> +	for (i = 0; retvalue == 0 && i < changes->additional_refnames.nr; i++)
> +		retvalue = fn(changes->additional_refnames.items[i].string, cb_data);

Using an strset for struct change_list would simplify this

> +	return retvalue;
> +}
> +
> +struct change_head* get_change_head(struct change_table *heads,
> +	const char* refname)
> +{
> +	struct string_list_item *item = string_list_lookup(
> +		&heads->refname_to_change_head, refname);
> +
> +	if (!item)
> +		return NULL;
> +
> +	return (struct change_head *)item->util;

We don't bother with casting void* pointers like this. In any case this 
whole function could become

	return strmap_get(table, refname)

if we used an strmap instead of a string_list.


Aside from the style issues and using api's that have been added since 
Stefan wrote these patches this looks pretty sound. The only thing I 
don't really get why the public api allows normal commits to be added to 
the change table (I can see why we might want to add the content commit 
as well when we add a metacommit but that should be done internally)

Best Wishes

Phillip
