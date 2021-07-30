Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25589C4338F
	for <git@archiver.kernel.org>; Fri, 30 Jul 2021 16:41:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F11B56052B
	for <git@archiver.kernel.org>; Fri, 30 Jul 2021 16:41:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229676AbhG3Qlg (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Jul 2021 12:41:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbhG3Qle (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Jul 2021 12:41:34 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60871C061765
        for <git@vger.kernel.org>; Fri, 30 Jul 2021 09:41:27 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id f13so13963582edq.13
        for <git@vger.kernel.org>; Fri, 30 Jul 2021 09:41:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=IRDIIjHdXxaWHLYTX1y8A9BLzJ0rj8wph07Fthm4e34=;
        b=RdPpM+ms5vkKI/gYZvw7tNXmmm36R0H+wqtu8K9ETQtfsaogHWz5Br4wcwnHsuLvgi
         f60prkJNHxx8tsnBHp13S/usIdV4PmktICKBbyZgUej3+SzpdVbVnRFtbYH7LakjaMg1
         bScrx8tYYeAEr/hmBtLtiJcdbiInYL1Ybqwo6tVYG47++y1egeYMggYXgAHOlJMdKZIy
         D6QZhoXft423PnM8mGVF/Nqc1XGylqXDCrg6meQFcJAMRU19oqG1Ukmp6J40wSrcuMVn
         VamZaRG0pIOe4TaLJgQ1e2a+LBHPqTLHHRh/Zu7tuE+74jNul7e9mBN5My064+UWH7ob
         jZNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=IRDIIjHdXxaWHLYTX1y8A9BLzJ0rj8wph07Fthm4e34=;
        b=XojouNoxw+ybYfBjnr+5GYOo99J5nMoyVe0eCAryKtSkvtZ2FKouJ3aJ+S41K4mlUO
         1PjDpqQsaKWp7UeY0tQ35tUn0/0evd9pTt7BAKNIk47Bbhor1CJG5Qm0nysrDTKzTUtv
         NxTAqbgMYxDK1i8JVs2xi++jlh9X8D2kLbxOtpdP6X0QkhTyk6+3kssTVOyQPPQrsqAN
         RTjhDjngD5yxzwuMvZZuL5XdIKfLTR9TYjEH1rdiCu5Qdvbj1wu/nrVZPxT1hBKCBpvC
         pF7vWnlVtbt19hR9lLkz4Ur8W7FgeW1FxCYpB2REeW99EolQD+r0wWZNUZEYUu2mEcbs
         AAbw==
X-Gm-Message-State: AOAM530Gl2SFdRpShyGJYAIX9/C72v/XktneuUDIwx711MFxCYtnpjI9
        ZfuXRUR0JKDQjttyD7934uA=
X-Google-Smtp-Source: ABdhPJye7D+cTmpqq3e7PnVNodPuDq4qV6jtY2NxjjF7McsQqInZePmP/HEyRpUN50wGV92Tkkb0uQ==
X-Received: by 2002:aa7:de98:: with SMTP id j24mr3981069edv.139.1627663285787;
        Fri, 30 Jul 2021 09:41:25 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id h19sm948513edt.87.2021.07.30.09.41.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jul 2021 09:41:25 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Jeff King <peff@peff.net>,
        Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v2 4/7] merge-ort: switch our strmaps over to using
 memory pools
Date:   Fri, 30 Jul 2021 18:23:33 +0200
References: <pull.990.git.1627044897.gitgitgadget@gmail.com>
 <pull.990.v2.git.1627531121.gitgitgadget@gmail.com>
 <dd8839b284330892a3bbcafbc03d71489fc9b01f.1627531121.git.gitgitgadget@gmail.com>
 <YQLJOsvATnTBd9pB@coredump.intra.peff.net>
 <CABPp-BHzJ365Jed38s-VQb2PqRy7t=58sZwgmeVG=mqKeA2neg@mail.gmail.com>
 <YQMLBW6LAZmQ8nDz@coredump.intra.peff.net>
 <87bl6kq631.fsf@evledraar.gmail.com>
 <CABPp-BHc16hjYz-+073LCA_cxHP22zW2QO6ikKKcXpG8zS1gWQ@mail.gmail.com>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <CABPp-BHc16hjYz-+073LCA_cxHP22zW2QO6ikKKcXpG8zS1gWQ@mail.gmail.com>
Message-ID: <878s1nrbxn.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Jul 30 2021, Elijah Newren wrote:

> Hi =C3=86var,
>
> On Fri, Jul 30, 2021 at 7:33 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
> <avarab@gmail.com> wrote:
>>
>>
>> On Thu, Jul 29 2021, Jeff King wrote:
>>
>> > On Thu, Jul 29, 2021 at 12:37:52PM -0600, Elijah Newren wrote:
>> >
>> >> > Arguably, the existence of these function indirections is perhaps a=
 sign
>> >> > that the strmap API should provide a version of the clear functions=
 that
>> >> > takes "partial / not-partial" as a parameter.
>> >>
>> >> Are you suggesting a modification of str{map,intmap,set}_clear() to
>> >> take an extra parameter, or removing the
>> >> str{map,intmap,set}_partial_clear() functions and introducing new
>> >> functions that take a partial/not-partial parameter?  I think you're
>> >> suggesting the latter, and that makes more sense to me...but I'm
>> >> drawing blanks trying to come up with a reasonable function name.
>> >
>> > It does seem a shame to add the "partial" parameter to strmap_clear(),
>> > just because most callers don't need it (so they end up with this
>> > inscrutable "0" parameter).
>> >
>> > What if there was a flags field? Then it could be combined with the
>> > free_values parameter. The result is kind of verbose in two ways:
>> >
>> >  - now strset_clear(), etc, need a "flags" parameter, which they didn't
>> >    before (and is just "0" most of the time!)
>> >
>> >  - now "strmap_clear(foo, 1)" becomes "strmap_clear(foo, STRMAP_FREE_V=
ALUES)".
>> >    That's a lot longer, though arguably it's easier to understand since
>> >    the boolean is explained.
>> >
>> > Having gone through the exercise, I am not sure it is actually making
>> > anything more readable (messy patch is below for reference).
>>
>> I've got some WIP patches for string-list.h and strmap.h to make the API
>> nicer, and it's probably applicable to strset.h too.
>
> There is no strset.h; strset and strintmap along with strmap are part
> of strmap.h.
>
>> I.e. I found when using strset.h that it was a weird API to use, because
>> unlike string-list.h it didn't pay attention to your "dup" field when
>> freeing, you had to do it explicitly.
>
> Do you mean strmap.h instead of strset.h?

Yes, sorry. Brainfart.

> In general, if you are asking strmap/strset/strintmap to dup your keys
> and are explicitly freeing the strings, then you are misusing the API
> and either freeing pointers that were never allocated or getting
> double frees.  It's wrong to explicitly deallocate them because:
>   * When using a pool, we just allocate from the pool.  The memory
> will be freed when the pool is freed.
>   * When not using a pool, we use FLEXPTR_ALLOC_STR in order to make
> the string be part of the allocated strmap_entry.  The string's memory
> is deallocated when the strmap_entry is.
>
> The only reason to explicitly free keys in a strmap/strset/strintmap
> is if you do NOT have strdup_strings set and allocated the strings
> elsewhere and left your strmap as the only thing tracking the strings.

Yes, sorry. I think I was trying to address that case, i.e. it started
with fixing some memory leaks, but it's part of a branch of mine that's
in a messy WIP state of not passing the tests. Please ignore the rest of
the hunks to do with strmap.h.

I might have some worthwhile fixes there, maybe not. It mainly started
with carrying things over from similar changes in string-list.h.

>> And then in e.g. merge-ort.c there's this "strdup dance" pattern where
>> we flip the field back and forth.
>>
>> The below diff is exctracted from that WIP work, with the relevant two
>> API headers and then two changed API users for show (the tree-wide
>> changes are much larger).
>>
>> I think making the promise I make in the updated docs at "We guarantee
>> that the `clearfunc`[...]" in string-list.h makes for particularly nice
>> API behavior.
>>
>>  builtin/remote.c | 37 ++++++++++++++++++++---------------
>>  merge-ort.c      | 32 +++++++-----------------------
>>  string-list.h    | 59 +++++++++++++++++++++++++++++++++++++++++++++++++=
+++++--
>>  strmap.h         | 13 +++++++++++++
>>  4 files changed, 98 insertions(+), 43 deletions(-)
>>
>> diff --git a/builtin/remote.c b/builtin/remote.c
>> index 7f88e6ce9de..ec1dbd49f71 100644
>> --- a/builtin/remote.c
>> +++ b/builtin/remote.c
>> @@ -340,10 +340,24 @@ static void read_branches(void)
>>
>>  struct ref_states {
>>         struct remote *remote;
>> -       struct string_list new_refs, stale, tracked, heads, push;
>> +
>> +       struct string_list new_refs;
>> +       struct string_list stale;
>> +       struct string_list tracked;
>> +       struct string_list heads;
>> +       struct string_list push;
>> +
>>         int queried;
>>  };
>>
>> +#define REF_STATES_INIT { \
>> +       .new_refs =3D STRING_LIST_INIT_DUP, \
>> +       .stale =3D STRING_LIST_INIT_DUP, \
>> +       .tracked =3D STRING_LIST_INIT_DUP, \
>> +       .heads =3D STRING_LIST_INIT_DUP, \
>> +       .push =3D STRING_LIST_INIT_DUP, \
>> +}
>> +
>>  static int get_ref_states(const struct ref *remote_refs, struct ref_sta=
tes *states)
>>  {
>>         struct ref *fetch_map =3D NULL, **tail =3D &fetch_map;
>> @@ -355,9 +369,6 @@ static int get_ref_states(const struct ref *remote_r=
efs, struct ref_states *stat
>>                         die(_("Could not get fetch map for refspec %s"),
>>                                 states->remote->fetch.raw[i]);
>>
>> -       states->new_refs.strdup_strings =3D 1;
>> -       states->tracked.strdup_strings =3D 1;
>> -       states->stale.strdup_strings =3D 1;
>>         for (ref =3D fetch_map; ref; ref =3D ref->next) {
>>                 if (!ref->peer_ref || !ref_exists(ref->peer_ref->name))
>>                         string_list_append(&states->new_refs, abbrev_bra=
nch(ref->name));
>> @@ -406,7 +417,6 @@ static int get_push_ref_states(const struct ref *rem=
ote_refs,
>>
>>         match_push_refs(local_refs, &push_map, &remote->push, MATCH_REFS=
_NONE);
>>
>> -       states->push.strdup_strings =3D 1;
>>         for (ref =3D push_map; ref; ref =3D ref->next) {
>>                 struct string_list_item *item;
>>                 struct push_info *info;
>> @@ -449,7 +459,6 @@ static int get_push_ref_states_noquery(struct ref_st=
ates *states)
>>         if (remote->mirror)
>>                 return 0;
>>
>> -       states->push.strdup_strings =3D 1;
>>         if (!remote->push.nr) {
>>                 item =3D string_list_append(&states->push, _("(matching)=
"));
>>                 info =3D item->util =3D xcalloc(1, sizeof(struct push_in=
fo));
>> @@ -483,7 +492,6 @@ static int get_head_names(const struct ref *remote_r=
efs, struct ref_states *stat
>>         refspec.force =3D 0;
>>         refspec.pattern =3D 1;
>>         refspec.src =3D refspec.dst =3D "refs/heads/*";
>> -       states->heads.strdup_strings =3D 1;
>>         get_fetch_map(remote_refs, &refspec, &fetch_map_tail, 0);
>>         matches =3D guess_remote_head(find_ref_by_name(remote_refs, "HEA=
D"),
>>                                     fetch_map, 1);
>> @@ -905,7 +913,7 @@ static void clear_push_info(void *util, const char *=
string)
>>  {
>>         struct push_info *info =3D util;
>>         free(info->dest);
>> -       free(info);
>> +       /* note: fixed memleak here */
>>  }
>>
>>  static void free_remote_ref_states(struct ref_states *states)
>> @@ -1159,7 +1167,7 @@ static int get_one_entry(struct remote *remote, vo=
id *priv)
>>                 string_list_append(list, remote->name)->util =3D
>>                                 strbuf_detach(&url_buf, NULL);
>>         } else
>> -               string_list_append(list, remote->name)->util =3D NULL;
>> +               string_list_append(list, remote->name);
>>         if (remote->pushurl_nr) {
>>                 url =3D remote->pushurl;
>>                 url_nr =3D remote->pushurl_nr;
>> @@ -1179,10 +1187,9 @@ static int get_one_entry(struct remote *remote, v=
oid *priv)
>>
>>  static int show_all(void)
>>  {
>> -       struct string_list list =3D STRING_LIST_INIT_NODUP;
>> +       struct string_list list =3D STRING_LIST_INIT_DUP;
>>         int result;
>>
>> -       list.strdup_strings =3D 1;
>>         result =3D for_each_remote(get_one_entry, &list);
>>
>>         if (!result) {
>> @@ -1212,7 +1219,7 @@ static int show(int argc, const char **argv)
>>                 OPT_BOOL('n', NULL, &no_query, N_("do not query remotes"=
)),
>>                 OPT_END()
>>         };
>> -       struct ref_states states;
>> +       struct ref_states states =3D REF_STATES_INIT;
>>         struct string_list info_list =3D STRING_LIST_INIT_NODUP;
>>         struct show_info info;
>>
>> @@ -1334,8 +1341,7 @@ static int set_head(int argc, const char **argv)
>>         if (!opt_a && !opt_d && argc =3D=3D 2) {
>>                 head_name =3D xstrdup(argv[1]);
>>         } else if (opt_a && !opt_d && argc =3D=3D 1) {
>> -               struct ref_states states;
>> -               memset(&states, 0, sizeof(states));
>> +               struct ref_states states =3D REF_STATES_INIT;
>>                 get_remote_ref_states(argv[0], &states, GET_HEAD_NAMES);
>>                 if (!states.heads.nr)
>>                         result |=3D error(_("Cannot determine remote HEA=
D"));
>> @@ -1374,14 +1380,13 @@ static int set_head(int argc, const char **argv)
>>  static int prune_remote(const char *remote, int dry_run)
>>  {
>>         int result =3D 0;
>> -       struct ref_states states;
>> +       struct ref_states states =3D REF_STATES_INIT;
>>         struct string_list refs_to_prune =3D STRING_LIST_INIT_NODUP;
>>         struct string_list_item *item;
>>         const char *dangling_msg =3D dry_run
>>                 ? _(" %s will become dangling!")
>>                 : _(" %s has become dangling!");
>>
>> -       memset(&states, 0, sizeof(states));
>>         get_remote_ref_states(remote, &states, GET_REF_STATES);
>>
>>         if (!states.stale.nr) {
>
> Everything up to here looks like a very nice cleanup.
>
>> diff --git a/merge-ort.c b/merge-ort.c
>> index ec0c5904211..53ed78e7a01 100644
>> --- a/merge-ort.c
>> +++ b/merge-ort.c
>> @@ -432,16 +432,6 @@ struct conflict_info {
>>         assert((ci) && !(mi)->clean);        \
>>  } while (0)
>>
>> -static void free_strmap_strings(struct strmap *map)
>> -{
>> -       struct hashmap_iter iter;
>> -       struct strmap_entry *entry;
>> -
>> -       strmap_for_each_entry(map, &iter, entry) {
>> -               free((char*)entry->key);
>> -       }
>> -}
>> -
>>  static void clear_or_reinit_internal_opts(struct merge_options_internal=
 *opti,
>>                                           int reinitialize)
>>  {
>> @@ -455,13 +445,11 @@ static void clear_or_reinit_internal_opts(struct m=
erge_options_internal *opti,
>>                 reinitialize ? strset_partial_clear : strset_clear;
>>
>>         /*
>> -        * We marked opti->paths with strdup_strings =3D 0, so that we
>> -        * wouldn't have to make another copy of the fullpath created by
>> -        * make_traverse_path from setup_path_info().  But, now that we'=
ve
>> -        * used it and have no other references to these strings, it is =
time
>> -        * to deallocate them.
>> +        * We used the the pattern of re-using already allocated
>> +        * strings strmap_clear_strings() in make_traverse_path from
>> +        * setup_path_info(). Deallocate them.
>>          */
>> -       free_strmap_strings(&opti->paths);
>> +       strmap_clear_strings(&opti->paths, 0);
>>         strmap_func(&opti->paths, 1);
>>
>>         /*
>
> It's not clear to me that strmap should handle the freeing of the keys
> at all; maybe it should and strmap_clear_strings() makes sense to
> introduce.  However, this change is clearly wrong regardless, for two
> reasons: (1) You are double clearing since strmap_func() is also
> called afterwards, and (2) you are also ignoring the potential partial
> bit since strmap_func might be strmap_partial_clear() rather than
> strmap_clear().

*Nod*, see above.

>> @@ -472,15 +460,10 @@ static void clear_or_reinit_internal_opts(struct m=
erge_options_internal *opti,
>>         strmap_func(&opti->conflicted, 0);
>>
>>         /*
>> -        * opti->paths_to_free is similar to opti->paths; we created it =
with
>> -        * strdup_strings =3D 0 to avoid making _another_ copy of the fu=
llpath
>> -        * but now that we've used it and have no other references to th=
ese
>> -        * strings, it is time to deallocate them.  We do so by temporar=
ily
>> -        * setting strdup_strings to 1.
>> +        * opti->paths_to_free is similar to opti->paths; it's memory
>> +        * we borrowed and need to free with string_list_clear_strings().
>>          */
>> -       opti->paths_to_free.strdup_strings =3D 1;
>> -       string_list_clear(&opti->paths_to_free, 0);
>> -       opti->paths_to_free.strdup_strings =3D 0;
>> +       string_list_clear_strings(&opti->paths_to_free, 0);
>
> This is very nice.  I really like this new function and API.
>
>>         if (opti->attr_index.cache_nr) /* true iff opt->renormalize */
>>                 discard_index(&opti->attr_index);
>> @@ -2664,7 +2647,6 @@ static int collect_renames(struct merge_options *o=
pt,
>>          * and have no other references to these strings, it is time to
>>          * deallocate them.
>>          */
>> -       free_strmap_strings(&collisions);
>>         strmap_clear(&collisions, 1);
>>         return clean;
>>  }
>
> This hunk is wrong.

*nod*

>> diff --git a/string-list.h b/string-list.h
>> index 0d6b4692396..9eeea996888 100644
>> --- a/string-list.h
>> +++ b/string-list.h
>> @@ -109,6 +109,9 @@ void string_list_init_dup(struct string_list *list);
>>   */
>>  void string_list_init(struct string_list *list, int strdup_strings);
>>
>> +void string_list_cmp_init(struct string_list *list, int strdup_strings,
>> +                         compare_strings_fn cmp);
>> +
>
> Seems unrelated to what you were trying to highlight?

Yes, sorry. I just extracted all the diff WIP diff I had for
string-list.h, this bit was unrelated.

It's unrelated cleanup of various things that hardcoded all the fields
during their "init", just because they need strcasecmp or whatever
instead of strcmp.

>>  /** Callback function type for for_each_string_list */
>>  typedef int (*string_list_each_func_t)(struct string_list_item *, void =
*);
>>
>> @@ -129,14 +132,66 @@ void filter_string_list(struct string_list *list, =
int free_util,
>>   */
>>  void string_list_clear(struct string_list *list, int free_util);
>>
>> +/**
>> + * Free a string list initialized without `strdup_strings =3D 1`, but
>> + * where we also want to free() the strings. You usually want to just
>> + * use string_list_clear() after initializing with
>> + * `STRING_LIST_INIT_DUP' instead.
>> + *
>> + * Useful to free e.g. a string list whose strings came from
>> + * strbuf_detach() or other memory that we didn't initially allocate
>> + * on the heap, but which we now manage.
>> + *
>> + * Under the hood this is identical in behavior to temporarily setting
>> + * `strbuf_strings` to `1` for the duration of this function call, but
>> + * without the verbosity of performing that dance yourself.
>> + */
>> +void string_list_clear_strings(struct string_list *list, int free_util);
>> +
>> +/**
>> + * Clear only the `util` pointer, but not the `string`, even if
>> + * `strdup_strings =3D 1` is set. Useful for the idiom of doing e.g.:
>> + *
>> + *    string_list_append(&list, str + offs)->util =3D str;
>> + *
>> + * Where we add a string at some offset, own the string (so
>> + * effectively `strdup_strings =3D `), but can't free() the string
>> + * itself at the changed offset, but need to free the original data in
>> + * `util` instead.
>> + */
>> +void string_list_clear_util(struct string_list *list);
>> +
>>  /**
>>   * Callback type for `string_list_clear_func`.  The string associated
>>   * with the util pointer is passed as the second argument
>>   */
>>  typedef void (*string_list_clear_func_t)(void *p, const char *str);
>>
>> -/** Call a custom clear function on each util pointer */
>> -void string_list_clear_func(struct string_list *list, string_list_clear=
_func_t clearfunc);
>> +/**
>> + * Like string_list_clear() except that it first calls a custom clear
>> + * function on each util pointer.
>> + *
>> + * We guarantee that the `clearfunc` will be called on all util
>> + * pointers in a list before we proceed to free the first string or
>> + * util pointer, i.e. should you need to it's OK to peek at other util
>> + * items in the list itself, or to otherwise iterate it from within
>> + * the `clearfunc`.
>> + *
>> + * You do not need to free() the passed-in util pointer itself,
>> + * i.e. after calling all `clearfunc` this has the seme behavior as
>> + * string_list_clear() called with with `free_util =3D 1`.
>> + */
>> +void string_list_clear_func(struct string_list *list,
>> +                           string_list_clear_func_t clearfunc);
>> +
>> +/**
>> + * Like string_list_clear_func() but free the strings too, using the
>> + * same dance as described for string_list_clear_strings()
>> + * above. You'll usually want to initialize with
>> + * `STRING_LIST_INIT_DUP` and use string_list_clear_strings() instead.
>> + */
>> +void string_list_clear_strings_func(struct string_list *list,
>> +                                   string_list_clear_func_t clearfunc);
>>
>>  /**
>>   * Apply `func` to each item. If `func` returns nonzero, the
>
> string_list_clear_strings() looks very nice.  The others are probably
> good too, though I'm curious about the need for double walking the
> list to free it instead of doing it in a single walk; what callers
> need to walk the list and check out other values?

I think there were a couple of users that needed that, but maybe I'm
wrong. I think even if there's not clearly defining the callback freeing
semantics makes sense for caller sanity.

We double-walk now in string_list_clear(), this is mostly documenting
and extending current behavior to being able to clear any arbitrary
combination of string/util with an optional cb, regardless of your
strdup_strings state.

>> diff --git a/strmap.h b/strmap.h
>> index 1e152d832d6..337f6278e86 100644
>> --- a/strmap.h
>> +++ b/strmap.h
>> @@ -51,12 +51,25 @@ void strmap_init_with_options(struct strmap *map,
>>   */
>>  void strmap_clear(struct strmap *map, int free_values);
>>
>> +/**
>> + * To strmap_clear() what string_list_clear_strings() is to
>> + * string_list_clear(). I.e. free your keys too, which we used as-is
>> + * without `strdup_strings =3D 1`.
>> + */
>> +void strmap_clear_strings(struct strmap *map, int free_values);
>
> strmap.h doesn't depend on string-list.h, so the comment should be
> self-standing.  The analogy also doesn't seem to hold since we do NOT
> need to free the keys when strdup_strings is 1; Peff suggested
> FLEXPTR_ALLOC_STR specifically to avoid that extra allocation in that
> case.

*nod*, see above (i.e. maybe all this strmap.h stuff is wrong). FWIW
that comment was meant as a "if you're familiar with X in API A, this Y
in B works similarly".

>> +
>>  /*
>>   * Similar to strmap_clear() but leaves map->map->table allocated and
>>   * pre-sized so that subsequent uses won't need as many rehashings.
>>   */
>>  void strmap_partial_clear(struct strmap *map, int free_values);
>>
>> +/**
>> + * To strmap_partial_clear() what string_list_clear_strings() is to
>> + * string_list_clear(). See strmap_clear_strings() above.
>> + */
>> +void strmap_partial_clear_strings(struct strmap *map, int free_values);
>> +
>
> Same comment as above for strmap_clear_strings() applies here.

*nod*
