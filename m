Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DD2AC27C76
	for <git@archiver.kernel.org>; Wed, 25 Jan 2023 05:12:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233302AbjAYFLn (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Jan 2023 00:11:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230252AbjAYFLl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Jan 2023 00:11:41 -0500
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F9A848593
        for <git@vger.kernel.org>; Tue, 24 Jan 2023 21:11:39 -0800 (PST)
Received: by mail-lj1-x22a.google.com with SMTP id o12so189130ljp.11
        for <git@vger.kernel.org>; Tue, 24 Jan 2023 21:11:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CcP3QiqN1LqpqcP+BDTGnnwag020qnf1Xz4VDqytZa4=;
        b=GiAogqp6CoNYfkvlAy8qwU1OJRmfACh5wvG8sUbUL5WDoz402QwSD4Sst8qaQA67QO
         xF2f7FmcD5aKh/GrBgpk6FLczu7o8FTgVmoUneEDV1I7b/HOJ9vfydTEiOyzh/0Cyy6V
         IY/ZAwy/Z1jhptGF9BFmQvvD0Mpo7oFT8ID3s5mAjeruVE8j4W4U6/66OgyFPS10Gsvm
         WaZN9mymGWZOvvWPpFzKAgIwqlUeIpZ0CV3qeUkQ7/Lx/hps6y5uDx/cnyqCjuqQkq94
         VNOk8jhxqdJGlE5Bj8N4T6BV+8Az2t0hmwW+XKrF5jqe+3/olyC2+FjC63k3XzYy5SPe
         r5wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CcP3QiqN1LqpqcP+BDTGnnwag020qnf1Xz4VDqytZa4=;
        b=yCU4SgsmStMx3k1t6sXOZFsE/I/dWYuM5hLA/7iVYP7UIWvzFHpGW7dRz6D1VysU4O
         yoFmCya1I/6nsH9lmFMFHkffqRaRL0JJ4gl+KXp542LlQNg7DGnHhwJSYT3YvuJCCsxi
         yIh1eeoIoCiHGWahosZDqbebx9zU9SaTtpWHRPmO3ShGNd0OGMhdFWk4YQmdNv1hTKuQ
         l6RJ46LYLAULoYXVagAl/Ie3aZwaOBicHyVFOTpiKt4pWo2syAnacZ8lnIaKEPA135/l
         yu5goPnBc4/KyxavlpfUPL51I43BjysvikDw4aOwEcXKC4nxlW1opyNR0T3FXc9nUVQ4
         r5Tg==
X-Gm-Message-State: AFqh2krgTccCCDMyXOPYLrhMlEastEIdLZD8LSOd7ArrDQ8bgn3K6u2O
        knzJQywwIdzk4mS0qaje+SrQN1xz+JdAEzD9ylM=
X-Google-Smtp-Source: AMrXdXtY+vnxYqmpXoER42B9OfHXD3O7zruZjrmkhoepj7sUyy04k2Z/6rmO7/tVJpqti0SIdrlXzW2HUTIP15ThHdI=
X-Received: by 2002:a2e:9842:0:b0:289:c64d:cba2 with SMTP id
 e2-20020a2e9842000000b00289c64dcba2mr2852920ljj.325.1674623497104; Tue, 24
 Jan 2023 21:11:37 -0800 (PST)
MIME-Version: 1.0
References: <pull.1459.git.1673456518993.gitgitgadget@gmail.com> <pull.1459.v2.git.1674474371817.gitgitgadget@gmail.com>
In-Reply-To: <pull.1459.v2.git.1674474371817.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 24 Jan 2023 21:11:24 -0800
Message-ID: <CABPp-BExS8UGfGzT+w9R_p0sY+_=A0-nRzU5QTOKwfBSmX6c3A@mail.gmail.com>
Subject: Re: [PATCH v2] ls-tree: add --sparse-filter-oid argument
To:     William Sprent via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Victoria Dye <vdye@github.com>,
        William Sprent <williams@unity3d.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It looks like =C3=86var and Victoria have both given really good reviews
already, but I think I spotted some additional things to comment on.

On Mon, Jan 23, 2023 at 3:46 AM William Sprent via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: William Sprent <williams@unity3d.com>
>
> There is currently no way to ask git the question "which files would be
> part of a sparse checkout of commit X with sparse checkout patterns Y".
> One use-case would be that tooling may want know whether sparse checkouts
> of two commits contain the same content even if the full trees differ.

Could you say more about this usecase?  Why does tooling need or want
to know this; won't a checkout of the new commit end up being quick
and simple?  (I'm not saying your usecase is bad, just curious that it
had never occurred to me, and I'm afraid I'm still not sure what your
purpose might be.)

> Another interesting use-case would be for tooling to use in conjunction
> with 'git update-index --index-info'.

Sorry, I'm not following.  Could you expound on this a bit?

> 'rev-list --objects --filter=3Dsparse:oid' comes close, but as rev-list i=
s
> concerned with objects rather than directory trees, it leaves files out
> when the same blob occurs in at two different paths.

s/in at/at/ ?

> It is possible to ask git about the sparse status of files currently in
> the index with 'ls-files -t'. However, this does not work well when the
> caller is interested in another commit, intererested in sparsity

s/intererested/interested/

> patterns that aren't currently in '.git/info/sparse-checkout', or when
> working in with bare repo.

s/in with bare/with a bare/ or s/in with bare/in a bare/?

> To fill this gap, add a new argument to ls-tree '--sparse-filter-oid'
> which takes the object id of a blob containing sparse checkout patterns
> that filters the output of 'ls-tree'. When filtering with given sparsity
> patterns, 'ls-tree' only outputs blobs and commit objects that
> match the given patterns.

This seems slightly unfortunate in that it makes things difficult for
cone mode users to take advantage of.  They will have to figure out
how to translate their directory list into sparse checkout patterns
before passing it along, and currently the only way to do that is via
`git sparse-checkout set <patterns>` and reading the patterns from
$GIT_DIR/info/sparse-checkout, but that toggles the sparsity of the
current working tree and avoiding changing the current sparse-checkout
was something you listed in your commit message as something you
wanted to avoid.

> While it may be valid in some situations to output a tree object -- e.g.
> when a cone pattern matches all blobs recursively contained in a tree --
> it is less unclear what should be output if a sparse pattern matches
> parts of a tree.
>
> To allow for reusing the pattern matching logic found in
> 'path_in_sparse_checkout_1()' in 'dir.c' with arbitrary patterns,
> extract the pattern matching part of the function into its own new
> function 'recursively_match_path_with_sparse_patterns()'.
>
> Signed-off-by: William Sprent <williams@unity3d.com>
> ---
>     ls-tree: add --sparse-filter-oid argument
>
>     I'm resubmitting this change as rebased on top of 'master', as it
>     conflicted with the topic 'ls-tree.c: clean-up works' 1
>     [https://public-inbox.org/git/20230112091135.20050-1-tenglong.tl@alib=
aba-inc.com],
>     which was merged to 'master' recently.
>
>     This versions also incorporates changes based on the comments made in=
 2
>     [https://public-inbox.org/git/CAPig+cRgZ0CrkqY7mufuWmhf6BC8yXjXXuOTEQ=
juz+Y0NA+N7Q@mail.gmail.com/].
>
>     I'm also looping in contributors that have touched ls-tree and/or
>     sparse-checkouts recently. I hope that's okay.

Of course!  It's encouraged, even.

[...]
> diff --git a/builtin/ls-tree.c b/builtin/ls-tree.c
[...]
> +static void init_sparse_filter_data(struct sparse_filter_data **d, struc=
t ls_tree_options *options,
> +       const char *sparse_oid_name, read_tree_fn_t fn)
> +{
> +       struct object_id sparse_oid;
> +       struct object_context oc;
> +
> +       (*d) =3D xcalloc(1, sizeof(**d));
> +       (*d)->fn =3D fn;
> +       (*d)->pl.use_cone_patterns =3D core_sparse_checkout_cone;

Hmm, so the behavior still depends upon the current sparse-checkout
(or lack thereof), despite the documentation and rationale of your
feature as being there to check how a different sparse checkout would
behave?

I would hate to unconditionally turn cone_patterns off, since that
would come with a huge performance penalty for the biggest repos.  But
turning it unconditionally on wouldn't be good for the non-cone users.
This probably suggests we need something like another flag, or perhaps
separate flags for each mode.  Separate flags might provide the
benefit of allowing cone mode users to specify directories rather than
patterns, which would make it much easier for them to use.

[...]
> +static int path_matches_sparse_checkout_patterns(struct strbuf *full_pat=
h, struct pattern_list *pl, int dtype)
> +{
> +       enum pattern_match_result match =3D recursively_match_path_with_s=
parse_patterns(full_path->buf, the_repository->index, dtype, pl);
> +       return match > 0;

So your new caller doesn't care about the pattern_match_result, it
just wants to know if it got MATCHED or MATCHED_RECURSIVELY...

[...]
> diff --git a/dir.c b/dir.c
> index 4e99f0c868f..122ebced08e 100644
> --- a/dir.c
> +++ b/dir.c
> @@ -1457,45 +1457,50 @@ int init_sparse_checkout_patterns(struct index_st=
ate *istate)
>         return 0;
>  }
>
> -static int path_in_sparse_checkout_1(const char *path,
> -                                    struct index_state *istate,
> -                                    int require_cone_mode)
> +int recursively_match_path_with_sparse_patterns(const char *path,

You claim it returns an int here, but previously you presumed an enum
pattern_match_result from the new caller.

> +                                               struct index_state *istat=
e,
> +                                               int dtype,
> +                                               struct pattern_list *pl)
>  {
> -       int dtype =3D DT_REG;
>         enum pattern_match_result match =3D UNDECIDED;
>         const char *end, *slash;
> -
> -       /*
> -        * We default to accepting a path if the path is empty, there are=
 no
> -        * patterns, or the patterns are of the wrong type.
> -        */
> -       if (!*path ||
> -           init_sparse_checkout_patterns(istate) ||
> -           (require_cone_mode &&
> -            !istate->sparse_checkout_patterns->use_cone_patterns))
> -               return 1;
> -
>         /*
>          * If UNDECIDED, use the match from the parent dir (recursively),=
 or
>          * fall back to NOT_MATCHED at the topmost level. Note that cone =
mode
>          * never returns UNDECIDED, so we will execute only one iteration=
 in
>          * this case.
>          */
> -       for (end =3D path + strlen(path);
> -            end > path && match =3D=3D UNDECIDED;
> +       for (end =3D path + strlen(path); end > path && match =3D=3D UNDE=
CIDED;
>              end =3D slash) {
> -
>                 for (slash =3D end - 1; slash > path && *slash !=3D '/'; =
slash--)
>                         ; /* do nothing */
>
>                 match =3D path_matches_pattern_list(path, end - path,
>                                 slash > path ? slash + 1 : path, &dtype,
> -                               istate->sparse_checkout_patterns, istate)=
;
> +                               pl, istate);
>
>                 /* We are going to match the parent dir now */
>                 dtype =3D DT_DIR;
>         }
> -       return match > 0;
> +
> +       return match;

Um, this last line seems like a potentially scary change in behavior.
Why should UNDECIDED return a non-zero value?  Previously, we returned
a 0 value for both UNDECIDED and NOT_MATCHED, but you've changed that
here.  If the change in this last line is actually correct, it should
be split out into its own commit and explained in detail in the commit
message.

> +}
> +
> +static int path_in_sparse_checkout_1(const char *path,
> +                                    struct index_state *istate,
> +                                    int require_cone_mode)
> +{
> +       /*
> +        * We default to accepting a path if the path is empty, there are=
 no
> +        * patterns, or the patterns are of the wrong type.
> +        */
> +       if (!*path ||
> +           init_sparse_checkout_patterns(istate) ||
> +           (require_cone_mode &&
> +            !istate->sparse_checkout_patterns->use_cone_patterns))
> +               return 1;
> +
> +       return recursively_match_path_with_sparse_patterns(path, istate, =
DT_REG, istate->sparse_checkout_patterns) > 0;

Oh, you compare to > 0 here...and digging around your only other
caller just immediately compares to > 0 as well.

Why not just have recursively_match_path_with_sparse_patterns() do the
> 0 check?  If it does, returning int is fine.  If it doesn't, it
should be declared to return enum pattern_match_result.
