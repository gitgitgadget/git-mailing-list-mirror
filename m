Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1D44C433FE
	for <git@archiver.kernel.org>; Tue,  4 Oct 2022 14:48:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229706AbiJDOs5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Oct 2022 10:48:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbiJDOs4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Oct 2022 10:48:56 -0400
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com [IPv6:2607:f8b0:4864:20::c34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33A8C57553
        for <git@vger.kernel.org>; Tue,  4 Oct 2022 07:48:55 -0700 (PDT)
Received: by mail-oo1-xc34.google.com with SMTP id h1-20020a4aa741000000b004756c611188so8952831oom.4
        for <git@vger.kernel.org>; Tue, 04 Oct 2022 07:48:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=h3SqrwgoQLwCPTOII343wbldtNCPwVd5lp82uXXX0Eo=;
        b=SKl8ETaBD+m1osriP/aciDUaVCo0RKJAxXc1+BLUD8wMvw8JUu9MZLPPtXtwbCWVaZ
         JVxrB09QC1uMGQCWJfVnHbkHIyVxMF/DpenrnYrQ0I0sBDvk/So0OXjYegbJr3PD90Qk
         kaPH63BDo62KLWskBu0DD8hMle0/9MqjlaWPOzEjFKaLrzpcvSgUximU1O5FoDJKkmjJ
         ZTu1TH1A5FqinW40ZIQz93TmLeFvpwOOaCUS7Xh9u27T6ukjxRJAnySb0RBsOTiv1Mw+
         VKlje4wj3OjgAN8VNjH+EawP93iJM5lq00ZFDd5tKVBdEFkYbUDbF/f+hrowN9X2OmsW
         pTJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=h3SqrwgoQLwCPTOII343wbldtNCPwVd5lp82uXXX0Eo=;
        b=OsgK/g91CZ1ss3E0xLXDhDwX8MEfv2X3ltzf8z4W81BuDLmSJSQ2Fb9Tw0Idb6AJnH
         TUa0+gp6zxa7oYuWslC2aaOru4MrruSW529wkf9UTUvvs1E0HlhahMqJI3/NO7Y65ruQ
         6EQYxzpmC0RaAzO8Aqc3QpRUGmraTRbLurTf9vSYQA9VFvzwuv0bwGB5atImgup8nBE9
         u1DMugPAEuhsLIWuQDaq99rJP1Fe6/xYcuzJUKSjAkM/0ZvFOY/SLj5mvjVK7vdWmju7
         ecvFfLFkKdoo3p+qWBLICObhgsRaCegyZTcpsAi+gNFP97yamh3Q4cWSGe9V0ZbcrOfP
         Mlbg==
X-Gm-Message-State: ACrzQf0BvUeKiF2QCx2vajCgoozDgkO+/iyV39JtSVtDLHnulykxFfSZ
        GmZSSCzonapOEtTx/LkhtIIPVOTn4v4EXpCQOszaQPhm
X-Google-Smtp-Source: AMsMyM6rcjm0yAFliX9HQoi19ug69LHraG7xiJiCBYbZTUcCOa4QdmDdrYUSITBL6daPL/UxlmV/2sn1G+aQbwOiPQI=
X-Received: by 2002:a05:6830:1211:b0:659:81ae:924b with SMTP id
 r17-20020a056830121100b0065981ae924bmr9990829otp.356.1664894934393; Tue, 04
 Oct 2022 07:48:54 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1356.git.1663959324.gitgitgadget@gmail.com>
 <2b3a00a6702eb8fb12e45b833ca74155939588ef.1663959325.git.gitgitgadget@gmail.com>
 <3c61e0b3-5526-f42e-48a7-c4465d06ccb3@dunelm.org.uk>
In-Reply-To: <3c61e0b3-5526-f42e-48a7-c4465d06ccb3@dunelm.org.uk>
From:   Chris P <christophe.poucet@gmail.com>
Date:   Tue, 4 Oct 2022 16:48:42 +0200
Message-ID: <CAN84kKnsxZ2upEFD9Miv51KfxV-rFL7iZmPDS4nx6zb9agSXRA@mail.gmail.com>
Subject: Re: [PATCH 05/10] evolve: add the change-table structure
To:     phillip.wood@dunelm.org.uk
Cc:     Stefan Xenos via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Christophe Poucet <poucet@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

>  > +/**
>
> We tend to just use '/*' rather than '/**'

It seems there's some disagreement on this. Regardless, I changed the
ones in the implementation to be "/*"

>
>  > + * This struct holds a list of change refs. The first element is
> stored inline,
>  > + * to optimize for small lists.
>  > + */
>  > +struct change_list {
>  > +    /**
>  > +     * Ref name for the first change in the list, or null if none.
>  > +     *
>  > +     * This field is private. Use for_each_change_in to read.
>  > +     */
>  > +    const char* first_refname;
>  > +    /**
>  > +     * List of additional change refs. Note that this is empty if the list
>  > +     * contains 0 or 1 elements.
>  > +     *
>  > +     * This field is private. Use for_each_change_in to read.
>  > +     */
>  > +    struct string_list additional_refnames;
>
> Splitting this feels like a premature optimization. We don't have any
> tests yet, let alone any real-world experience using this code. Also if
> we want to save memory for lists with a single entry why are we
> embedding the struct string_list rather than just storing a pointer to it?

Agreed, simplified to a strset. Thanks for the suggestion.

>
> I think it would be simpler to use a struct strset to hold the refnames
> as we don't need the util field offered by struct string_list.

Done.

>
>  > +/**
>  > + * Holds information about the head of a single change.
>  > + */
>  > +struct change_head {
>  > +    /**
>  > +     * The location pointed to by the head of the change. May be a
> commit or a
>  > +     * metacommit.
>  > +     */
>  > +    struct object_id head;
>
> I found this duality between commits and metacommits rather confusing -
> why isn't the head always a metacommit?

There is no reason to create a metacommit for the first commit you create.
You only need one if you're replacing a commit with another commit.

>
>  > +/**
>  > + * Holds information about the heads of each change, and permits
> effecient
>
> s/effecient/efficient/

Done.

>
>  > + * lookup from a commit to the changes that reference it directly.
>  > + *
>  > + * All fields should be considered private. Use the change_table
> functions
>  > + * to interact with this struct.
>  > + */
>  > +struct change_table {
>  > +    /**
>  > +     * Memory pool for the objects allocated by the change table.
>  > +     */
>  > +    struct mem_pool memory_pool;
>  > +    /* Map object_id to commit_change_list_entry structs. */
>  > +    struct oidmap oid_to_metadata_index;
>  > +    /**
>  > +     * List of ref names. The util value points to a change_head structure
>  > +     * allocated from memory_pool.
>  > +     */
>  > +    struct string_list refname_to_change_head;
>
> I think these days we'd use a strmap for this for O(1) lookups.

Way better!

>
>  > +};
>  > +
>  > +extern void change_table_init(struct change_table *to_initialize);
>
> The struct change_table argument to all these functions changes its name
> more often than a criminal on the run. I would find it much easier to
> follow the code if we consistently called this argument "table"

Agreed, changed them all to "table".

>
>  > + * Adds all changes matching the given ref filter to the given
> change_table
>  > + * struct.
>  > + */
>  > +extern void change_table_add_matching_filter(struct change_table
> *to_modify,
>  > +    struct repository* repo, struct ref_filter *filter);
>
> I can't see any callers outside of change-table.c so do we really need
> to export this function.

Thanks for verifying, done.

> > +
> > +void change_table_init(struct change_table *to_initialize)
> > +{
> > +     memset(to_initialize, 0, sizeof(*to_initialize));
> > +     mem_pool_init(&to_initialize->memory_pool, 0);
> > +     to_initialize->memory_pool.block_alloc = 4*1024 - sizeof(struct mp_block);
>
> If we're using a mempool to minimize the allocation overhead we should
> leave .block_alloc set to the default value of 1MB rather than changing
> it to 4kB

Good question, I don't know the typical sizes that we'll get for these,
so for now just sticking with the default seems sensible.

> > +
> > +static void add_head_to_commit(struct change_table *to_modify,
> > +     const struct object_id *to_add, const char *refname)
>
> I found the function and argument names rather confusing. If I've
> understood the code correctly then this function is adding an assoation
> between the commit "to_add" and "refname". Despite its name "to_add" may
> already exist in the change table.
>
> The formatting is a bit off as well (as are most of the function
> declarations in this patch and the next), we'd write that as
>
> static void add_head_to_commit(struct change_table *table,
>                                const struct object_id *to_add,
>                                const char *refname)

Thanks, I wasn't clear on the guidelines. I hope the new format makes
more sense.

>
> > +{
> > +     struct commit_change_list_entry *entry;
> > +
> > +     /**
> > +      * Note: the indices in the map are 1-based. 0 is used to indicate a missing
> > +      * element.
> > +      */
>
> I'm confused by this comment, what indices is it talking about?

No idea, removed.

> > +
> > +     if (!entry->changes.first_refname)
> > +             entry->changes.first_refname = refname;
> > +     else
> > +             string_list_insert(&entry->changes.additional_refnames, refname);
>
> This is an example of the complexity added by the current definition of
> struct change_list.

Yes, simplified.

>
> > +void change_table_add(struct change_table *to_modify, const char *refname,
> > +     struct commit *to_add)
> > +{
> > +     struct change_head *new_head;
> > +     struct string_list_item *new_item;
> > +     int metacommit_type;
> > +
> > +     new_head = mem_pool_calloc(&to_modify->memory_pool, 1,
> > +             sizeof(*new_head));
> > +
> > +     oidcpy(&new_head->head, &to_add->object.oid);
> > +
> > +     metacommit_type = get_metacommit_content(to_add, &new_head->content);
> > +     if (metacommit_type == METACOMMIT_TYPE_NONE)
> > +             oidcpy(&new_head->content, &to_add->object.oid);
>
> If to_add is not a metacommit then the content is to_add itself,
> otherwise it will have been set by the call to get_metacommit_content().

Yes, added the comment.

>
> > +     new_head->abandoned = (metacommit_type == METACOMMIT_TYPE_ABANDONED);
>
> Style: I don't think we normally bother with parentheses here

I admit I prefer it here because operator priority isn't always
obvious (it could be read as
(new_head->abandoned = metacommit_type) == METACOMMIT_TYPE_ABANDONED;

>
> > +     new_head->remote = starts_with(refname, "refs/remote/");
> > +     new_head->hidden = starts_with(refname, "refs/hiddenmetas/");
> > +
> > +     new_item = string_list_insert(&to_modify->refname_to_change_head, refname);
> > +     new_item->util = new_head;
> > +     /* Use pointers to the copy of the string we're retaining locally */
>
> string_list_insert() copied the string and we're using that copy. Saying
> we're retaining it locally when it will outlive this function call is
> confusing.

This is now obsolete with the move to strmap.

>
> > +     refname = new_item->string;
> > +
> > +     if (!oideq(&new_head->content, &new_head->head))
> > +             add_head_to_commit(to_modify, &new_head->content, refname);
>
> If to_add is a metacommit then we remember the link between refname and
> the content commit.
>
> > +     add_head_to_commit(to_modify, &new_head->head, refname);
>
> We also remember the link between refname and to_add

Thanks, added the comment.

>
> > +}
> > +
> > +void change_table_add_all_visible(struct change_table *to_modify,
> > +     struct repository* repo)
> > +{
> > +     struct ref_filter filter;
>
> rather than using memset we'd write (the same goes for all the other
> memset() calls in this series, unless they're operation on a heap
> allocation)
>
>         struct ref_filter filter = { 0 };

Thanks, I wasn't aware of that trick.

>
> > +     const char *name_patterns[] = {NULL};
> > +     memset(&filter, 0, sizeof(filter));
> > +     filter.kind = FILTER_REFS_CHANGES;
> > +     filter.name_patterns = name_patterns;
> > +
> > +     change_table_add_matching_filter(to_modify, repo, &filter);
> > +}
> > +
> > +void change_table_add_matching_filter(struct change_table *to_modify,
> > +     struct repository* repo, struct ref_filter *filter)
> > +{
> > +     struct ref_array matching_refs;
> > +     int i;
> > +
> > +     memset(&matching_refs, 0, sizeof(matching_refs));
> > +     filter_refs(&matching_refs, filter, filter->kind);
> > +
> > +     /**
> > +      * Determine the object id for the latest content commit for each change.
> > +      * Fetch the commit at the head of each change ref. If it's a normal commit,
> > +      * that's the commit we want. If it's a metacommit, locate its content parent
> > +      * and use that.
> > +      */
> > +
> > +     for (i = 0; i < matching_refs.nr; i++) {
> > +             struct ref_array_item *item = matching_refs.items[i];
> > +             struct commit *commit = item->commit;
> > +
> > +             commit = lookup_commit_reference_gently(repo, &item->objectname, 1);
>
> We're assigning commit twice - why do we need to look it up if
> filter_refs returns it?

I think this is a case of missing logic if you look at what the
comment above it says.

>
> There are a number of places where we call
> lookup_commit_reference_gently(..., 1) to silence the warning if the
> objectname does not dereference to a commit. It is not clear to me that
> we want to hide those errors. Indeed I think we should be doing

Agreed, move to this.

>
>                 commit = lookup_commit_reference(repo, oid)
>                 if (!commit)
>                         BUG("commit missing ...")
>
> unless there is a good reason that the lookup can fail.

I can't think of any but then I'm not the original author.

>
> > +             if (commit)
> > +                     change_table_add(to_modify, item->refname, commit);
> > +     }
> > +
> > +     ref_array_clear(&matching_refs);
> > +}
>
> > +int for_each_change_referencing(struct change_table *table,
> > +     const struct object_id *referenced_commit_id, each_change_fn fn, void *cb_data)
> > +{
> > +     const struct change_list *changes;
> > +     int i;
> > +     int retvalue;
>
> We normally use "ret" for this

Done.

>
> > +     struct commit_change_list_entry *entry;
> > +
> > +     entry = oidmap_get(&table->oid_to_metadata_index,
> > +             referenced_commit_id);
>
> This should be indented to start below the '(' of the function call.

Done.

>
> > +     /* If this commit isn't referenced by any changes, it won't be in the map */
> > +     if (!entry)
> > +             return 0;
> > +     changes = &entry->changes;
> > +     if (!changes->first_refname)
> > +             return 0;
> > +     retvalue = fn(changes->first_refname, cb_data);
> > +     for (i = 0; retvalue == 0 && i < changes->additional_refnames.nr; i++)
> > +             retvalue = fn(changes->additional_refnames.items[i].string, cb_data);
>
> Using an strset for struct change_list would simplify this

Agreed! Simplified.

>
> > +     return retvalue;
> > +}
> > +
> > +struct change_head* get_change_head(struct change_table *heads,
> > +     const char* refname)
> > +{
> > +     struct string_list_item *item = string_list_lookup(
> > +             &heads->refname_to_change_head, refname);
> > +
> > +     if (!item)
> > +             return NULL;
> > +
> > +     return (struct change_head *)item->util;
>
> We don't bother with casting void* pointers like this. In any case this
> whole function could become
>
>         return strmap_get(table, refname)
>
> if we used an strmap instead of a string_list.
>
>
> Aside from the style issues and using api's that have been added since
> Stefan wrote these patches this looks pretty sound. The only thing I
> don't really get why the public api allows normal commits to be added to
> the change table (I can see why we might want to add the content commit
> as well when we add a metacommit but that should be done internally)
>
> Best Wishes
>
> Phillip
