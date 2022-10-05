Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8EC1C433FE
	for <git@archiver.kernel.org>; Wed,  5 Oct 2022 09:41:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229709AbiJEJlN (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Oct 2022 05:41:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229672AbiJEJlL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Oct 2022 05:41:11 -0400
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com [IPv6:2607:f8b0:4864:20::c31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07FB82B621
        for <git@vger.kernel.org>; Wed,  5 Oct 2022 02:41:10 -0700 (PDT)
Received: by mail-oo1-xc31.google.com with SMTP id c13-20020a4ac30d000000b0047663e3e16bso10452938ooq.6
        for <git@vger.kernel.org>; Wed, 05 Oct 2022 02:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=jf++MWWsGBiq4n4DSHhkiA0WLHWNlcaC9Fm0tbgKXHQ=;
        b=DCNGcOEl8j8QHM+ngayHWKqRIqlB+KmxTn4rJIGEaqMklroMQEH517aZ6b/opxJZ/y
         bcwHdAbHRI+Fk/w7OA4XaVb2YIs6rOswrDNIyeOTb2T2xXV3ChsjYHWLnOyNCXkMjUxA
         Ewz75GsMlVofU02kiJlSBB/CCd+JA7mYuy7r1Vp/6Cs968vIpRAqNua26qjEsXzauv8t
         FZJVvyRBEo/QvKbOhH9utES00xf0ZcB2vyPy4UTNt3vwFWXF+u2WNrx187htpOXm8VCN
         VXJ7jyTNzdkutFwKwEMtih/osxxscjRPAR1/c1V71rqZIfIgjKXPynWO0nCExfDgwqRN
         nKcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=jf++MWWsGBiq4n4DSHhkiA0WLHWNlcaC9Fm0tbgKXHQ=;
        b=ApxqvbED4vRgOsY5cv2kiCDKjozms19zPTWXUlj+vz3d2TlfO25SpRM7wZJL/EKx0J
         GIYnZ+8y44esV6TbbzLzTYCTWn1vK3VgDmzltqEgmxXa0HBFPks6upau+XgqoHb0TOG9
         eVtuQt44iAQWcgWCSLRfDlsGMkpsd6k7UPTyqJqWgwcCIwfVf1bDZSG+/xl55lD8g0rS
         j1sXR2e/RDpCpVNGlV9ORBmzZgQGVnaf2H83BXKicsoaTBC1W2apqTetdz7vRqiiS+W5
         8wYxrSKZSPdt8ysE1APg/ix+FY5buBzPgVAv6Xh6+rPWuJ5Kw5wOsiDlt++xc+bSt1P5
         /fOw==
X-Gm-Message-State: ACrzQf3lEw5Qz8GaARHVpufyKkZ7EmKSUWBI3RdUYmxV95EB7gsS29/f
        RaY6W1YdQ9mqh1KAbf1Y3yQythkJh5PyZ9Ch6hU=
X-Google-Smtp-Source: AMsMyM44xwdmTzwLGeeA+g3hYCuN65h0RNnGTwq5FmGG/mCmryualBbvbQlgDZMGQBst4mOB6k6aUJ3S1G6CFHBEvpg=
X-Received: by 2002:a05:6830:1211:b0:659:81ae:924b with SMTP id
 r17-20020a056830121100b0065981ae924bmr11492527otp.356.1664962869133; Wed, 05
 Oct 2022 02:41:09 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1356.git.1663959324.gitgitgadget@gmail.com>
 <56c6770997bbdb1b3b87c2c410dd7f158b03f2d6.1663959325.git.gitgitgadget@gmail.com>
 <a7ddab8a-ddd6-a8bf-496d-4ce7757d89cf@dunelm.org.uk>
In-Reply-To: <a7ddab8a-ddd6-a8bf-496d-4ce7757d89cf@dunelm.org.uk>
From:   Chris P <christophe.poucet@gmail.com>
Date:   Wed, 5 Oct 2022 11:40:57 +0200
Message-ID: <CAN84kKke+vSQ18wNM7h6BvTF9XBtSH96L0_qNOFn+V3fj2yNhg@mail.gmail.com>
Subject: Re: [PATCH 06/10] evolve: add support for writing metacommits
To:     phillip.wood@dunelm.org.uk
Cc:     git@vger.kernel.org,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Christophe Poucet <poucet@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

+cc my work account due to a bug in gitgitgadget

>
> I think the code to parse and create metacommits (as well as the change
> table code) could quite happily live in the same file.

I am considering this, it would hide the change_table as that doesn't
need to be exposed (for now at least).  My only concern is that it
would make the commit-msg rather unwieldy.

>
> > diff --git a/metacommit.c b/metacommit.c
> > new file mode 100644
> > index 00000000000..d2b859a4d3b
> > --- /dev/null
> > +++ b/metacommit.c
> > @@ -0,0 +1,404 @@
> > +#include "cache.h"
> > +#include "metacommit.h"
> > +#include "commit.h"
> > +#include "change-table.h"
> > +#include "refs.h"
> > +
> > +void init_metacommit_data(struct metacommit_data *state)
> > +{
> > +     memset(state, 0, sizeof(*state));
> > +}
> We'd normally use an initializer macro instead
>
>         #define METACOMMIT_DATA_INIT = { 0 }

Thanks, done.

>
> > +void clear_metacommit_data(struct metacommit_data *state)
> > +{
> > +     oid_array_clear(&state->replace);
> > +     oid_array_clear(&state->origin);
> > +}
> > +
> > +static void compute_default_change_name(struct commit *initial_commit,
> > +     struct strbuf* result)
> > +{
> > +     struct strbuf default_name;
>
> The canonical way to initialize an strbuf that is not on the heap is
>
>         struct strbuf buf = STRBUF_INIT;

Done.

>
> > +     const char *buffer;
> > +     const char *subject;
> > +     const char *eol;
> > +     int len;
> > +     strbuf_init(&default_name, 0);
> > +     buffer = get_commit_buffer(initial_commit, NULL);
> > +     find_commit_subject(buffer, &subject);
> > +     eol = strchrnul(subject, '\n');
> > +     for (len = 0;subject < eol && len < 10; ++subject, ++len) {
>
> There's a space missing after the first ';'. We prefer post-increments
> to pre-increments unless the pre-increment is significant.

Done and done :)

>
> > +             char next = *subject;
> > +             if (isspace(next))
> > +                     continue;
> > +
> > +             strbuf_addch(&default_name, next);
> > +     }
> > +     sanitize_refname_component(default_name.buf, result);
>
> I suspect we need to call unuse_commit_buffer(initial_commit) here.

Oh interesting, yes.

>
> > +}
> > +
> > +/**
> > + * Computes a change name for a change rooted at the given initial commit. Good
> > + * change names should be memorable, unique, and easy to type. They are not
> > + * required to match the commit comment.
> > + */
> > +static void compute_change_name(struct commit *initial_commit, struct strbuf* result)
> > +{
> > +     struct strbuf default_name;
> > +     struct object_id unused;
> > +
> > +     strbuf_init(&default_name, 0);
> > +     if (initial_commit)
> > +             compute_default_change_name(initial_commit, &default_name);
> > +     else
> > +             strbuf_addstr(&default_name, "change");
>
> What does it mean to call this function with initial_commit == NULL?

I don't know to be honest, the call site always seems to pass one in.
Changed it to BUG.

>
> > +     strbuf_addstr(result, "refs/metas/");
> > +     strbuf_addbuf(result, &default_name);
> > +     /* If there is already a change of this name, append a suffix */
> > +     if (!read_ref(result->buf, &unused)) {
> > +             int suffix = 2;
> > +             int original_length = result->len;
>
> This is one of many places where we have a size_t len or nr member and
> assign it to an int. I think it would be clearer to use a size_t instead
> to avoid adding any more signed<->unsigned conversions.

Done, I had to leave one place because it did while(i >= 0);

>
> > +
> > +             while (1) {
> > +                     strbuf_addf(result, "%d", suffix);
> > +                     if (read_ref(result->buf, &unused))
> > +                             break;
> > +                     strbuf_remove(result, original_length, result->len - original_length);
> > +                     ++suffix;
> > +             }
> > +     }
> > +
> > +     strbuf_release(&default_name);
> > +}
> > +
> > +struct resolve_metacommit_callback_data
>
> While there are some structs with a _callback_data suffix in the code
> base, it is far more common to use _context and name any corresponding
> variables ctx.

Done.

>
> > +{
> > +     struct change_table* active_changes;
> > +     struct string_list *changes;
> > +     struct oid_array *heads;
> > +};
> > +
> > +static int resolve_metacommit_callback(const char *refname, void *cb_data)
> > +{
> > +     struct resolve_metacommit_callback_data *data = (struct resolve_metacommit_callback_data *)cb_data;
>
> We don't use redundant casts such as this.

Thanks :)

>
> > +     struct change_head *chhead;
> > +
> > +     chhead = get_change_head(data->active_changes, refname);
>
> This is really a comment on the previous patch but are there uses of
> for_each_change_referencing() for which just the refname is sufficient?
> It might be more convenient to pass the change head into the callback as
> well.

I'm not sure, will investigate post-squash

>
> > +
> > +     if (data->changes)
> > +             string_list_append(data->changes, refname)->util = &(chhead->head);
>
> We don't use redundant parentheses such as this (and this patch does not
> use them consistently)

Done.

>
> > +     if (data->heads)
> > +             oid_array_append(data->heads, &(chhead->head));
> > +
> > +     return 0;
> > +}
> > +
> > +/**
> > + * Produces the final form of a metacommit based on the current change refs.
> > + */
> > +static void resolve_metacommit(
> > +     struct repository* repo,
> > +     struct change_table* active_changes,
> > +     const struct metacommit_data *to_resolve,
>
> [testing my understanding] This is the metacommit we want to update

Maybe you can help me find a bug.  If you run `git-change update`
twice without changing commits, it prints that it created a second
one, but then if you `git-change list` it doesn't show that last one
because it doesn't create an extra one if there's already a change
pointing at HEAD.

Also, thanks for all the comments, it's helping my understanding too.
In general do you want all these comments added to the code?

>
> > +     struct metacommit_data *resolved_output,
>
> This is the updated metacommit returned to the user
>
> > +     struct string_list *to_advance,
>
> Is also an output? It ends up as a list of refname to change head mappings

Yes, this is consumed in the change.c command.  I was considering
making this a strintmap that maps to an enum, because we need a
tristate (updated, created, untouched). But unfortunately the oids
assigned to `->util` are consumed later in the function.

>
> > +     int allow_append)
> > +{
> > +     int i;
> > +     int len = to_resolve->replace.nr;
> > +     struct resolve_metacommit_callback_data cbdata;
>
> This would be a good place to a designated initializer.
>
>         struct resolve_metacommit_context ctx = {
>                 .active_changes = active_changes,
>                 .changes = to_advance,
>                 .heads = &resolved_output->replace
>         };

I'm learning new C :D

>
> > +     int old_change_list_length = to_advance->nr;
> > +     struct commit* content;
> > +
> > +     oidcpy(&resolved_output->content, &to_resolve->content);
> > +
> > +     /* First look for changes that point to any of the replacement edges in the
> > +      * metacommit. These will be the changes that get advanced by this
> > +      * metacommit. */
>
> Style: '/*' & '*/' should be on their own lines.

Done

>
> > +     resolved_output->abandoned = to_resolve->abandoned;
> > +     cbdata.active_changes = active_changes;
> > +     cbdata.changes = to_advance;
> > +     cbdata.heads = &(resolved_output->replace);
> > +
> > +     if (allow_append) {
> > +             for (i = 0; i < len; i++) {
> > +                     int old_number = resolved_output->replace.nr;
> > +                     for_each_change_referencing(active_changes, &(to_resolve->replace.oid[i]),
> > +                             resolve_metacommit_callback, &cbdata);
> > +                     /* If no changes were found, use the unresolved value. */
> > +                     if (old_number == resolved_output->replace.nr)
> > +                             oid_array_append(&(resolved_output->replace), &(to_resolve->replace.oid[i]));
>
> We see if there are any refs under refs/metas/ which point to
> 'to_resolve' or its content and if there are we add those refs and the
> corresponding change head to 'to_advance'. If we don't find any refs
> then we copy the replace oid from 'to_resolve' to 'resolved_output'
>
> If allow_append is false then we ignore all the replace oids in 'to_resolve'
>
> > +             }
> > +     }
> > +
> > +     cbdata.changes = NULL;
> > +     cbdata.heads = &(resolved_output->origin);
> > +
> > +     len = to_resolve->origin.nr;
> > +     for (i = 0; i < len; i++) {
> > +             int old_number = resolved_output->origin.nr;
> > +             for_each_change_referencing(active_changes, &(to_resolve->origin.oid[i]),
> > +                     resolve_metacommit_callback, &cbdata);
> > +             if (old_number == resolved_output->origin.nr)
> > +                     oid_array_append(&(resolved_output->origin), &(to_resolve->origin.oid[i]));
> > +     }
>
> This is copying the origin oids in the same way as we copied the replace
> oids above.
>
> > +     /* If no changes were advanced by this metacommit, we'll need to create a new
> > +      * one. */
> > +     if (to_advance->nr == old_change_list_length) {
> > +             struct strbuf change_name;
> > +
> > +             strbuf_init(&change_name, 80);
> > +             content = lookup_commit_reference_gently(repo, &(to_resolve->content), 1);
> > +
> > +             compute_change_name(content, &change_name);
> > +             string_list_append(to_advance, change_name.buf);
> > +             strbuf_release(&change_name);
> > +     }
> > +}
> > +
> > +static void lookup_commits(
> > +     struct repository *repo,
> > +     struct oid_array *to_lookup,
> > +     struct commit_list **result)
> > +{
> > +     int i = to_lookup->nr;
> > +
> > +     while (--i >= 0) {
> > +             struct object_id *next = &(to_lookup->oid[i]);
> > +             struct commit *commit = lookup_commit_reference_gently(repo, next, 1);
> > +             commit_list_insert(commit, result);
> > +     }
>
> We walk backwards because commit_list_insert prepends to the list - good.
>
> > +}
> > +
> > +#define PARENT_TYPE_PREFIX "parent-type "
> > +
> > +/**
> > + * Creates a new metacommit object with the given content. Writes the object
> > + * id of the newly-created commit to result.
> > + */
> > +int write_metacommit(struct repository *repo, struct metacommit_data *state,
> > +     struct object_id *result)
> > +{
> > +     struct commit_list *parents = NULL;
> > +     struct strbuf comment;
> > +     int i;
> > +     struct commit *content;
> > +
> > +     strbuf_init(&comment, strlen(PARENT_TYPE_PREFIX)
> > +             + 1 + 2 * (state->origin.nr + state->replace.nr));
> > +     lookup_commits(repo, &state->origin, &parents);
> > +     lookup_commits(repo, &state->replace, &parents);
> > +     content = lookup_commit_reference_gently(repo, &state->content, 1);
> > +     if (!content) {
> > +             strbuf_release(&comment);
> > +             free_commit_list(parents);
> > +             return -1;
> > +     }
> > +     commit_list_insert(content, &parents);
> > +
> > +     strbuf_addstr(&comment, PARENT_TYPE_PREFIX);
> > +     strbuf_addstr(&comment, state->abandoned ? "a" : "c");
> > +     for (i = 0; i < state->replace.nr; i++)
> > +             strbuf_addstr(&comment, " r");
> > +
> > +     for (i = 0; i < state->origin.nr; i++)
> > +             strbuf_addstr(&comment, " o"); > +      /* The parents list will be freed by this call. */
> > +     commit_tree(comment.buf, comment.len, repo->hash_algo->empty_tree, parents,
> > +             result, NULL, NULL);
>
> It would be relatively easy to use commit_tree_extended() with
> extra_headers so that we create a commit with a "parent-type" header
> rather than abusing the commit message.
>
>         struct commit_extra_header extra = { .key = "parent-type" };
>
>         /* build header value in strbuf */
>
>         extra.value = buf.buf;
>         extra.len = buf.len;
>         commit_tree_extended("", 0, repo->hash_algo->empty_tree,
>                              parents, result, NULL, NULL, NULL,
>                              &extra);

Sounds like a potentially good idea, to avoid that people accidentally
create metacommits that aren't real.
What would that look like on the parsing side as well as the test-setup?

>
> > +
> > +     strbuf_release(&comment);
> > +     return 0;
> > +}
> > +
> > +/**
> > + * Returns true iff the given metacommit is abandoned, has one or more origin
> > + * parents, or has one or more replacement parents.
> > + */
> > +static int is_nontrivial_metacommit(struct metacommit_data *state)
> > +{
> > +     return state->replace.nr || state->origin.nr || state->abandoned;
> > +}
> > +
> > +/*
> > + * Records the relationships described by the given metacommit in the
> > + * repository.
> > + *
> > + * If override_change is NULL (the default), an attempt will be made
> > + * to append to existing changes wherever possible instead of creating new ones.
> > + * If override_change is non-null, only the given change ref will be updated.
>
> So override_head is the refname of an existing change?

Yes, this comes from the commandline with the option of '-g' (Which
unfortunately is not documented).
>
> > + * options is a bitwise combination of the UPDATE_OPTION_* flags.
> > + */
> > +int record_metacommit(
> > +     struct repository *repo,
> > +     const struct metacommit_data *metacommit, const char *override_change,
> > +     int options, struct strbuf *err)
> > +{
> > +             struct change_table chtable;
> > +             struct string_list changes;
> > +             int result;
> > +
> > +             change_table_init(&chtable);
> > +             change_table_add_all_visible(&chtable, repo);
> > +             string_list_init_dup(&changes);
> > +
> > +             result = record_metacommit_withresult(repo, &chtable, metacommit,
> > +                     override_change, options, err, &changes);
> > +
> > +             string_list_clear(&changes, 0);
> > +             change_table_clear(&chtable);
> > +             return result;
> > +}
> > +
> > +/*
> > + * Records the relationships described by the given metacommit in the
> > + * repository.
> > + *
> > + * If override_change is NULL (the default), an attempt will be made
> > + * to append to existing changes wherever possible instead of creating new ones.
> > + * If override_change is non-null, only the given change ref will be updated.
> > + *
> > + * The changes list is filled in with the list of change refs that were updated,
> > + * with the util pointers pointing to the old object IDS for those changes.
> > + * The object ID pointers all point to objects owned by the change_table and
> > + * will go out of scope when the change_table is destroyed.
>
> That potentially sounds like an invitation to create use after free bugs
> unless we're careful. Does this function need to be public?

So the change command uses the changes list to determine what to print
to the output.  It looks whether it's a new change or a created change
based on whether the oid is null or not.
We could return a strintmap instead that points at status per change.
I tried that approach but unfortunately, `changes` is used later in
this function. I could still consider a strintmap, it would just be
that there's some duplicative storage of information until the
function exits. LMKWYT.

>
> > + *
> > + * options is a bitwise combination of the UPDATE_OPTION_* flags.
> > + */
> > +int record_metacommit_withresult(
> > +     struct repository *repo,
> > +     struct change_table *chtable,
> > +     const struct metacommit_data *metacommit,
> > +     const char *override_change,
> > +     int options, struct strbuf *err,
> > +     struct string_list *changes)
> > +{
> > +     static const char *msg = "updating change";
> > +     struct metacommit_data resolved_metacommit;
> > +     struct object_id commit_target;
> > +     struct ref_transaction *transaction = NULL;
> > +     struct change_head *overridden_head;
> > +     const struct object_id *old_head;
> > +
> > +     int i;
> > +     int ret = 0;
> > +     int force = (options & UPDATE_OPTION_FORCE);
> > +
> > +     init_metacommit_data(&resolved_metacommit);
> > +
> > +     resolve_metacommit(repo, chtable, metacommit, &resolved_metacommit, changes,
> > +             (options & UPDATE_OPTION_NOAPPEND) == 0);
> > +
> > +     if (override_change) {
> > +             string_list_clear(changes, 0);
> > +             overridden_head = get_change_head(chtable, override_change);
> > +             if (!overridden_head) {
>
> We enter this branch if overridden_head is NULL

Good catch!

>
> > +                     /* This is an existing change */
> > +                     old_head = &overridden_head->head;
>
> Here we de-reference overridden_head which is NULL

Yep.

>
> > +                     if (!force) {
> > +                             if (!oid_array_readonly_contains(&(resolved_metacommit.replace),
> > +                                     &overridden_head->head)) {
> > +                                     /* Attempted non-fast-forward change */
> > +                                     strbuf_addf(err, _("non-fast-forward update to '%s'"),
> > +                                             override_change);
> > +                                     ret = -1;
> > +                                     goto cleanup;
> > +                             }
> > +                     }
> > +             } else
>
> Style: if one branch of an if statement requires braces then all
> branches should have braces.

Thanks, fixed.

>
> > +                     /* ...then this is a newly-created change */
> > +                     old_head = null_oid();
> > +
> > +             /* The expected "current" head of the change is stored in the util
> > +              * pointer. */
> > +             string_list_append(changes, override_change)->util = (void*)old_head;
>
> No need to cast here

Actually it's required because old_head is a const*
>
> > +     }
> > +
> > +     if (is_nontrivial_metacommit(&resolved_metacommit)) {
> > +             /* If there are any origin or replacement parents, create a new metacommit
> > +              * object. */
> > +             if (write_metacommit(repo, &resolved_metacommit, &commit_target) < 0) {
> > +                     ret = -1;
> > +                     goto cleanup;
> > +             }
> > +     } else
> > +             /**
> > +              * If the metacommit would only contain a content commit, point to the
> > +              * commit itself rather than creating a trivial metacommit.
> > +              */
> > +             oidcpy(&commit_target, &(resolved_metacommit.content));
>
> Oh, is this optimization why we don't insist on metacommits but also
> allow ordinary commits to be added to the change table?

Yes.

> > +
> > +extern int record_metacommit_withresult(
> > +     struct repository *repo,
> > +     struct change_table *chtable,
> > +     const struct metacommit_data *metacommit,
> > +     const char *override_change,
> > +     int options,
> > +     struct strbuf *err,
> > +     struct string_list *changes);
>
> Does this need to be public? i.e. why would one call this rather than
> record_metacommit()?

Turns out the change command needs the `changes` string_list.  I've
made this one private and extended the public one with the changes
list.
I could potentially still return a strintmap but I'm on the fence.

>
> > +extern void modify_change(struct repository *repo,
> > +     const struct object_id *old_commit, const struct object_id *new_commit,
> > +     struct strbuf *err);
> > +
> > +extern int write_metacommit(struct repository *repo, struct metacommit_data *state,
> > +     struct object_id *result);
>
> The documentation for the flags is very welcome but this header could to
> with the api being documented as well.
>
> Best Wishes
>
> Phillip



>
> > +extern void modify_change(struct repository *repo,
> > +     const struct object_id *old_commit, const struct object_id *new_commit,
> > +     struct strbuf *err);
> > +
> > +extern int write_metacommit(struct repository *repo, struct metacommit_data *state,
> > +     struct object_id *result);
>
> The documentation for the flags is very welcome but this header could to
> with the api being documented as well.
>
> Best Wishes
>
> Phillip
