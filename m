Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27812C32771
	for <git@archiver.kernel.org>; Wed, 28 Sep 2022 14:27:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234320AbiI1O1e (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Sep 2022 10:27:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234369AbiI1O1a (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Sep 2022 10:27:30 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F118AB05B
        for <git@vger.kernel.org>; Wed, 28 Sep 2022 07:27:28 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id m4so5738350wrr.5
        for <git@vger.kernel.org>; Wed, 28 Sep 2022 07:27:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:reply-to:subject:user-agent:mime-version:date:message-id:from
         :from:to:cc:subject:date;
        bh=q6u/LummMTLtzq3j3xG32TaTsicRHhP/lNCeNq+9psU=;
        b=MVxAYp4RdUwy45hbyUcoAb3hvdyz/NJu7SdbZ5mTULBk3d6SH6u3BzXEJuHbQt1RTd
         923BsIFRwNg0T4jbn67/qDQCc3fuIj/1dyEgLkWrN5KPSAjZ7PKagfP7q/kYIrInbiAK
         38PRzjtFzG4eNcw44Vx/RdF1RdcAvo1QXwjJh8PKIuDO/w/Lduyjusm763JVHOL516Ot
         uEznXLP7z1xQT4petKpvY5TmA/SuRaSgzChYtcYhREKUe/mOHOs3ary4D5ZH7BXvogMi
         09FJblvUVW8RqIVebYiwblri6mWKPm4xthNjav9X09q9u16vgEBlQ0Ws2Xpwy1RwnIdK
         Iyuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:reply-to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date;
        bh=q6u/LummMTLtzq3j3xG32TaTsicRHhP/lNCeNq+9psU=;
        b=U+dCJT1OuiDz1vypOM2n3lUzaPBU21LqmKPkrNwNEZPVDWhJDIK/2Wc1URto8dU9Vg
         qqhQ5+4Sg4VfILZZ4rb8hz4oNscnwxEag1TPvwZDQsPbZ2sQdjxxSjKLHHoqCOlzeUW5
         DngMuyjWb89MAnKTh0YeMpoLrshFQih/FsujjLuoWRNgRdEQlQtAA9FurUChNbn8eXoj
         X/TZHe6CBIAn/qgzu5zLbjDVio4Eu/tRHaMKAgqbIGm80o4gAIYVpH2Uxt2R163z7B8R
         LIlp8YWQlM+1tD4G01iuCQkFoV8/XLvShvE60SVq9LQHZdZ2zlFzunDWG8qE/B6FXLAg
         u8uA==
X-Gm-Message-State: ACrzQf09Dxb+H2dYYlyI9t6cZr9SSuFwhXUguwr2lks2MLJ515rwO5cg
        KusCjqHB2dr1QKiFENcqWDpqZdZ+ZGM=
X-Google-Smtp-Source: AMsMyM4K/X7HBzQdaV8ksrY3PNFY1oZJq2Yebylq+ZVQp75snXopqZH9O8e/gM8uAwigI2p6gGkN4g==
X-Received: by 2002:a05:6000:70e:b0:22a:c7f5:c5f7 with SMTP id bs14-20020a056000070e00b0022ac7f5c5f7mr20803132wrb.333.1664375246729;
        Wed, 28 Sep 2022 07:27:26 -0700 (PDT)
Received: from [192.168.1.74] ([31.185.185.144])
        by smtp.gmail.com with ESMTPSA id p9-20020adfe609000000b0022add5a6fb1sm4436665wrm.30.2022.09.28.07.27.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Sep 2022 07:27:26 -0700 (PDT)
From:   Phillip Wood <phillip.wood123@gmail.com>
X-Google-Original-From: Phillip Wood <phillip.wood@dunelm.org.uk>
Message-ID: <a7ddab8a-ddd6-a8bf-496d-4ce7757d89cf@dunelm.org.uk>
Date:   Wed, 28 Sep 2022 15:27:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH 06/10] evolve: add support for writing metacommits
Reply-To: phillip.wood@dunelm.org.uk
To:     Stefan Xenos via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Christophe Poucet <christophe.poucet@gmail.com>,
        Stefan Xenos <sxenos@google.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFy?= =?UTF-8?Q?mason?= 
        <avarab@gmail.com>
References: <pull.1356.git.1663959324.gitgitgadget@gmail.com>
 <56c6770997bbdb1b3b87c2c410dd7f158b03f2d6.1663959325.git.gitgitgadget@gmail.com>
Content-Language: en-US
In-Reply-To: <56c6770997bbdb1b3b87c2c410dd7f158b03f2d6.1663959325.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Chris

On 23/09/2022 19:55, Stefan Xenos via GitGitGadget wrote:
> From: Stefan Xenos <sxenos@google.com>
> 
> metacommit.c supports the creation of metacommits and
> adds the API needed to create and update changes.
> 
> Create the "modify_change" function that can be called from modification
> commands like "rebase" and "git amend" to record obsolescences in the
> change graph.
> 
> Create the "record_metacommit" function for recording more complicated
> commit relationships in the commit graph.
> 
> Create the "write_metacommit" function for low-level creation of
> metacommits.

The commit message fails to mention that we do not create a 
"parent-type" header when we create a metacommit but instead abuse the 
commit message.

As with the other patches there are a lot of style comments, but to try 
and limit the noise I've only commented on one instance of each - you 
should apply the comments to all occurrences in all patches.

I've left a couple of questions where I'm not sure exactly what the code 
is trying to do but apart from an easily fixed NULL pointer de-reference 
and not actually creating the "parent-type" header it looks pretty good. 
I was glad to see that there are no obvious memory leaks. I do think the 
patches in this series would be easier to follow if the function 
parameter names were nouns rather than verbs.

> Signed-off-by: Stefan Xenos <sxenos@google.com>
> Signed-off-by: Chris Poucet <poucet@google.com>
> ---
>   Makefile     |   1 +
>   metacommit.c | 404 +++++++++++++++++++++++++++++++++++++++++++++++++++
>   metacommit.h |  58 ++++++++
>   3 files changed, 463 insertions(+)
>   create mode 100644 metacommit.c
>   create mode 100644 metacommit.h
> 
> diff --git a/Makefile b/Makefile
> index 2b847e7e7de..68082ef94c7 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1000,6 +1000,7 @@ LIB_OBJS += merge-ort.o
>   LIB_OBJS += merge-ort-wrappers.o
>   LIB_OBJS += merge-recursive.o
>   LIB_OBJS += merge.o
> +LIB_OBJS += metacommit.o
>   LIB_OBJS += metacommit-parser.o

I think the code to parse and create metacommits (as well as the change 
table code) could quite happily live in the same file.

> diff --git a/metacommit.c b/metacommit.c
> new file mode 100644
> index 00000000000..d2b859a4d3b
> --- /dev/null
> +++ b/metacommit.c
> @@ -0,0 +1,404 @@
> +#include "cache.h"
> +#include "metacommit.h"
> +#include "commit.h"
> +#include "change-table.h"
> +#include "refs.h"
> +
> +void init_metacommit_data(struct metacommit_data *state)
> +{
> +	memset(state, 0, sizeof(*state));
> +}
We'd normally use an initializer macro instead

	#define METACOMMIT_DATA_INIT = { 0 }

> +void clear_metacommit_data(struct metacommit_data *state)
> +{
> +	oid_array_clear(&state->replace);
> +	oid_array_clear(&state->origin);
> +}
> +
> +static void compute_default_change_name(struct commit *initial_commit,
> +	struct strbuf* result)
> +{
> +	struct strbuf default_name;

The canonical way to initialize an strbuf that is not on the heap is

	struct strbuf buf = STRBUF_INIT;

> +	const char *buffer;
> +	const char *subject;
> +	const char *eol;
> +	int len;
> +	strbuf_init(&default_name, 0);
> +	buffer = get_commit_buffer(initial_commit, NULL);
> +	find_commit_subject(buffer, &subject);
> +	eol = strchrnul(subject, '\n');
> +	for (len = 0;subject < eol && len < 10; ++subject, ++len) {

There's a space missing after the first ';'. We prefer post-increments 
to pre-increments unless the pre-increment is significant.

> +		char next = *subject;
> +		if (isspace(next))
> +			continue;
> +
> +		strbuf_addch(&default_name, next);
> +	}
> +	sanitize_refname_component(default_name.buf, result);

I suspect we need to call unuse_commit_buffer(initial_commit) here.

> +}
> +
> +/**
> + * Computes a change name for a change rooted at the given initial commit. Good
> + * change names should be memorable, unique, and easy to type. They are not
> + * required to match the commit comment.
> + */
> +static void compute_change_name(struct commit *initial_commit, struct strbuf* result)
> +{
> +	struct strbuf default_name;
> +	struct object_id unused;
> +
> +	strbuf_init(&default_name, 0);
> +	if (initial_commit)
> +		compute_default_change_name(initial_commit, &default_name);
> +	else
> +		strbuf_addstr(&default_name, "change");

What does it mean to call this function with initial_commit == NULL?

> +	strbuf_addstr(result, "refs/metas/");
> +	strbuf_addbuf(result, &default_name);
> +	/* If there is already a change of this name, append a suffix */
> +	if (!read_ref(result->buf, &unused)) {
> +		int suffix = 2;
> +		int original_length = result->len;

This is one of many places where we have a size_t len or nr member and 
assign it to an int. I think it would be clearer to use a size_t instead 
to avoid adding any more signed<->unsigned conversions.

> +
> +		while (1) {
> +			strbuf_addf(result, "%d", suffix);
> +			if (read_ref(result->buf, &unused))
> +				break;
> +			strbuf_remove(result, original_length, result->len - original_length);
> +			++suffix;
> +		}
> +	}
> +
> +	strbuf_release(&default_name);
> +}
> +
> +struct resolve_metacommit_callback_data

While there are some structs with a _callback_data suffix in the code 
base, it is far more common to use _context and name any corresponding 
variables ctx.

> +{
> +	struct change_table* active_changes;
> +	struct string_list *changes;
> +	struct oid_array *heads;
> +};
> +
> +static int resolve_metacommit_callback(const char *refname, void *cb_data)
> +{
> +	struct resolve_metacommit_callback_data *data = (struct resolve_metacommit_callback_data *)cb_data;

We don't use redundant casts such as this.

> +	struct change_head *chhead;
> +
> +	chhead = get_change_head(data->active_changes, refname);

This is really a comment on the previous patch but are there uses of 
for_each_change_referencing() for which just the refname is sufficient? 
It might be more convenient to pass the change head into the callback as 
well.

> +
> +	if (data->changes)
> +		string_list_append(data->changes, refname)->util = &(chhead->head);

We don't use redundant parentheses such as this (and this patch does not 
use them consistently)

> +	if (data->heads)
> +		oid_array_append(data->heads, &(chhead->head));
> +
> +	return 0;
> +}
> +
> +/**
> + * Produces the final form of a metacommit based on the current change refs.
> + */
> +static void resolve_metacommit(
> +	struct repository* repo,
> +	struct change_table* active_changes,
> +	const struct metacommit_data *to_resolve,

[testing my understanding] This is the metacommit we want to update

> +	struct metacommit_data *resolved_output,

This is the updated metacommit returned to the user

> +	struct string_list *to_advance,

Is also an output? It ends up as a list of refname to change head mappings

> +	int allow_append)
> +{
> +	int i;
> +	int len = to_resolve->replace.nr;
> +	struct resolve_metacommit_callback_data cbdata;

This would be a good place to a designated initializer.

	struct resolve_metacommit_context ctx = {
		.active_changes = active_changes,
		.changes = to_advance,
		.heads = &resolved_output->replace
	};

> +	int old_change_list_length = to_advance->nr;
> +	struct commit* content;
> +
> +	oidcpy(&resolved_output->content, &to_resolve->content);
> +
> +	/* First look for changes that point to any of the replacement edges in the
> +	 * metacommit. These will be the changes that get advanced by this
> +	 * metacommit. */

Style: '/*' & '*/' should be on their own lines.

> +	resolved_output->abandoned = to_resolve->abandoned;
> +	cbdata.active_changes = active_changes;
> +	cbdata.changes = to_advance;
> +	cbdata.heads = &(resolved_output->replace);
> +
> +	if (allow_append) {
> +		for (i = 0; i < len; i++) {
> +			int old_number = resolved_output->replace.nr;
> +			for_each_change_referencing(active_changes, &(to_resolve->replace.oid[i]),
> +				resolve_metacommit_callback, &cbdata);
> +			/* If no changes were found, use the unresolved value. */
> +			if (old_number == resolved_output->replace.nr)
> +				oid_array_append(&(resolved_output->replace), &(to_resolve->replace.oid[i]));

We see if there are any refs under refs/metas/ which point to 
'to_resolve' or its content and if there are we add those refs and the 
corresponding change head to 'to_advance'. If we don't find any refs 
then we copy the replace oid from 'to_resolve' to 'resolved_output'

If allow_append is false then we ignore all the replace oids in 'to_resolve'

> +		}
> +	}
> +
> +	cbdata.changes = NULL;
> +	cbdata.heads = &(resolved_output->origin);
> +
> +	len = to_resolve->origin.nr;
> +	for (i = 0; i < len; i++) {
> +		int old_number = resolved_output->origin.nr;
> +		for_each_change_referencing(active_changes, &(to_resolve->origin.oid[i]),
> +			resolve_metacommit_callback, &cbdata);
> +		if (old_number == resolved_output->origin.nr)
> +			oid_array_append(&(resolved_output->origin), &(to_resolve->origin.oid[i]));
> +	}

This is copying the origin oids in the same way as we copied the replace 
oids above.

> +	/* If no changes were advanced by this metacommit, we'll need to create a new
> +	 * one. */
> +	if (to_advance->nr == old_change_list_length) {
> +		struct strbuf change_name;
> +
> +		strbuf_init(&change_name, 80);
> +		content = lookup_commit_reference_gently(repo, &(to_resolve->content), 1);
> +
> +		compute_change_name(content, &change_name);
> +		string_list_append(to_advance, change_name.buf);
> +		strbuf_release(&change_name);
> +	}
> +}
> +
> +static void lookup_commits(
> +	struct repository *repo,
> +	struct oid_array *to_lookup,
> +	struct commit_list **result)
> +{
> +	int i = to_lookup->nr;
> +
> +	while (--i >= 0) {
> +		struct object_id *next = &(to_lookup->oid[i]);
> +		struct commit *commit = lookup_commit_reference_gently(repo, next, 1);
> +		commit_list_insert(commit, result);
> +	}

We walk backwards because commit_list_insert prepends to the list - good.

> +}
> +
> +#define PARENT_TYPE_PREFIX "parent-type "
> +
> +/**
> + * Creates a new metacommit object with the given content. Writes the object
> + * id of the newly-created commit to result.
> + */
> +int write_metacommit(struct repository *repo, struct metacommit_data *state,
> +	struct object_id *result)
> +{
> +	struct commit_list *parents = NULL;
> +	struct strbuf comment;
> +	int i;
> +	struct commit *content;
> +
> +	strbuf_init(&comment, strlen(PARENT_TYPE_PREFIX)
> +		+ 1 + 2 * (state->origin.nr + state->replace.nr));
> +	lookup_commits(repo, &state->origin, &parents);
> +	lookup_commits(repo, &state->replace, &parents);
> +	content = lookup_commit_reference_gently(repo, &state->content, 1);
> +	if (!content) {
> +		strbuf_release(&comment);
> +		free_commit_list(parents);
> +		return -1;
> +	}
> +	commit_list_insert(content, &parents);
> +
> +	strbuf_addstr(&comment, PARENT_TYPE_PREFIX);
> +	strbuf_addstr(&comment, state->abandoned ? "a" : "c");
> +	for (i = 0; i < state->replace.nr; i++)
> +		strbuf_addstr(&comment, " r");
> +
> +	for (i = 0; i < state->origin.nr; i++)
> +		strbuf_addstr(&comment, " o"); > +	/* The parents list will be freed by this call. */
> +	commit_tree(comment.buf, comment.len, repo->hash_algo->empty_tree, parents,
> +		result, NULL, NULL);

It would be relatively easy to use commit_tree_extended() with 
extra_headers so that we create a commit with a "parent-type" header 
rather than abusing the commit message.

	struct commit_extra_header extra = { .key = "parent-type" };
	
	/* build header value in strbuf */

	extra.value = buf.buf;
	extra.len = buf.len;
	commit_tree_extended("", 0, repo->hash_algo->empty_tree,
			     parents, result, NULL, NULL, NULL,
			     &extra);

> +
> +	strbuf_release(&comment);
> +	return 0;
> +}
> +
> +/**
> + * Returns true iff the given metacommit is abandoned, has one or more origin
> + * parents, or has one or more replacement parents.
> + */
> +static int is_nontrivial_metacommit(struct metacommit_data *state)
> +{
> +	return state->replace.nr || state->origin.nr || state->abandoned;
> +}
> +
> +/*
> + * Records the relationships described by the given metacommit in the
> + * repository.
> + *
> + * If override_change is NULL (the default), an attempt will be made
> + * to append to existing changes wherever possible instead of creating new ones.
> + * If override_change is non-null, only the given change ref will be updated.

So override_head is the refname of an existing change?

> + * options is a bitwise combination of the UPDATE_OPTION_* flags.
> + */
> +int record_metacommit(
> +	struct repository *repo,
> +	const struct metacommit_data *metacommit, const char *override_change,
> +	int options, struct strbuf *err)
> +{
> +		struct change_table chtable;
> +		struct string_list changes;
> +		int result;
> +
> +		change_table_init(&chtable);
> +		change_table_add_all_visible(&chtable, repo);
> +		string_list_init_dup(&changes);
> +
> +		result = record_metacommit_withresult(repo, &chtable, metacommit,
> +			override_change, options, err, &changes);
> +
> +		string_list_clear(&changes, 0);
> +		change_table_clear(&chtable);
> +		return result;
> +}
> +
> +/*
> + * Records the relationships described by the given metacommit in the
> + * repository.
> + *
> + * If override_change is NULL (the default), an attempt will be made
> + * to append to existing changes wherever possible instead of creating new ones.
> + * If override_change is non-null, only the given change ref will be updated.
> + *
> + * The changes list is filled in with the list of change refs that were updated,
> + * with the util pointers pointing to the old object IDS for those changes.
> + * The object ID pointers all point to objects owned by the change_table and
> + * will go out of scope when the change_table is destroyed.

That potentially sounds like an invitation to create use after free bugs 
unless we're careful. Does this function need to be public?

> + *
> + * options is a bitwise combination of the UPDATE_OPTION_* flags.
> + */
> +int record_metacommit_withresult(
> +	struct repository *repo,
> +	struct change_table *chtable,
> +	const struct metacommit_data *metacommit,
> +	const char *override_change,
> +	int options, struct strbuf *err,
> +	struct string_list *changes)
> +{
> +	static const char *msg = "updating change";
> +	struct metacommit_data resolved_metacommit;
> +	struct object_id commit_target;
> +	struct ref_transaction *transaction = NULL;
> +	struct change_head *overridden_head;
> +	const struct object_id *old_head;
> +
> +	int i;
> +	int ret = 0;
> +	int force = (options & UPDATE_OPTION_FORCE);
> +
> +	init_metacommit_data(&resolved_metacommit);
> +
> +	resolve_metacommit(repo, chtable, metacommit, &resolved_metacommit, changes,
> +		(options & UPDATE_OPTION_NOAPPEND) == 0);
> +
> +	if (override_change) {
> +		string_list_clear(changes, 0);
> +		overridden_head = get_change_head(chtable, override_change);
> +		if (!overridden_head) {

We enter this branch if overridden_head is NULL

> +			/* This is an existing change */
> +			old_head = &overridden_head->head;

Here we de-reference overridden_head which is NULL

> +			if (!force) {
> +				if (!oid_array_readonly_contains(&(resolved_metacommit.replace),
> +					&overridden_head->head)) {
> +					/* Attempted non-fast-forward change */
> +					strbuf_addf(err, _("non-fast-forward update to '%s'"),
> +						override_change);
> +					ret = -1;
> +					goto cleanup;
> +				}
> +			}
> +		} else

Style: if one branch of an if statement requires braces then all 
branches should have braces.

> +			/* ...then this is a newly-created change */
> +			old_head = null_oid();
> +
> +		/* The expected "current" head of the change is stored in the util
> +		 * pointer. */
> +		string_list_append(changes, override_change)->util = (void*)old_head;

No need to cast here

> +	}
> +
> +	if (is_nontrivial_metacommit(&resolved_metacommit)) {
> +		/* If there are any origin or replacement parents, create a new metacommit
> +		 * object. */
> +		if (write_metacommit(repo, &resolved_metacommit, &commit_target) < 0) {
> +			ret = -1;
> +			goto cleanup;
> +		}
> +	} else
> +		/**
> +		 * If the metacommit would only contain a content commit, point to the
> +		 * commit itself rather than creating a trivial metacommit.
> +		 */
> +		oidcpy(&commit_target, &(resolved_metacommit.content));

Oh, is this optimization why we don't insist on metacommits but also 
allow ordinary commits to be added to the change table?

> diff --git a/metacommit.h b/metacommit.h
> new file mode 100644
> index 00000000000..fdb253f0f04
> --- /dev/null
> +++ b/metacommit.h
> @@ -0,0 +1,58 @@
> +#ifndef METACOMMIT_H
> +#define METACOMMIT_H
> +
> +#include "hash.h"
> +#include "oid-array.h"
> +#include "repository.h"
> +#include "string-list.h"
> +
> +
> +struct change_table;
> +
> +/* If specified, non-fast-forward changes are permitted. */
> +#define UPDATE_OPTION_FORCE     0x0001
> +/**
> + * If specified, no attempt will be made to append to existing changes.
> + * Normally, if a metacommit points to a commit in its replace or origin
> + * list and an existing change points to that same commit as its content, the
> + * new metacommit will attempt to append to that same change. This may replace
> + * the commit parent with one or more metacommits from the head of the appended
> + * changes. This option disables this behavior, and will always create a new
> + * change rather than reusing existing changes.
> + */
> +#define UPDATE_OPTION_NOAPPEND  0x0002
> +
> +/* Metacommit Data */
> +
> +struct metacommit_data {
> +	struct object_id content;
> +	struct oid_array replace;
> +	struct oid_array origin;
> +	int abandoned;
> +};
> +
> +extern void init_metacommit_data(struct metacommit_data *state);
> +
> +extern void clear_metacommit_data(struct metacommit_data *state);
> +
> +extern int record_metacommit(struct repository *repo,
> +	const struct metacommit_data *metacommit,
> +	const char* override_change, int options, struct strbuf *err);
> +
> +extern int record_metacommit_withresult(
> +	struct repository *repo,
> +	struct change_table *chtable,
> +	const struct metacommit_data *metacommit,
> +	const char *override_change,
> +	int options,
> +	struct strbuf *err,
> +	struct string_list *changes);

Does this need to be public? i.e. why would one call this rather than 
record_metacommit()?

> +extern void modify_change(struct repository *repo,
> +	const struct object_id *old_commit, const struct object_id *new_commit,
> +	struct strbuf *err);
> +
> +extern int write_metacommit(struct repository *repo, struct metacommit_data *state,
> +	struct object_id *result);

The documentation for the flags is very welcome but this header could to 
with the api being documented as well.

Best Wishes

Phillip
