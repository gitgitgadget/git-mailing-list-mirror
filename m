Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4F46D1F461
	for <e@80x24.org>; Sat, 24 Aug 2019 04:57:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725973AbfHXE5F (ORCPT <rfc822;e@80x24.org>);
        Sat, 24 Aug 2019 00:57:05 -0400
Received: from mail-vk1-f194.google.com ([209.85.221.194]:46039 "EHLO
        mail-vk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725906AbfHXE5F (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Aug 2019 00:57:05 -0400
Received: by mail-vk1-f194.google.com with SMTP id r13so2857000vke.12
        for <git@vger.kernel.org>; Fri, 23 Aug 2019 21:57:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FXmdXxdoxwLmnQqUN8VEfT8SM6Co5qjJGKQwJFROqw8=;
        b=FDNbjXxJIWSv+lCJmre2LN/NF/T0ACAkCty8l/epFweVp1LDXdEpIOYX332j6zyKUv
         InDIEzlzDF2Dw8rQQixo7v8uqa7YVOF8hD8orR6zaVHUi+8aDeTsjw28bj/yVyp91GfG
         F9uYL61KE0i3PtR+5oohDCAUtmgqyeE4OprvNajYYPNllZkpiZEPYjfzrj5GGHld2KMJ
         TbHeVYDLqQE8Qa/iX5gJljAC04bIYO6jhrpFG+Y+1Ls7QmG3MGXIvT27iEV8PWlWnexb
         jqqcRREgl4dpXlmooLWU7bm3N4camg0S4P2qysEpiM4LGx8iucMlkFzYTz1cVIrQjDe0
         efow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FXmdXxdoxwLmnQqUN8VEfT8SM6Co5qjJGKQwJFROqw8=;
        b=GAB4M533O06fmaaMRxDzIHYSgKmzueIRTL23h0EY/S0B5pFalYo/+GPBXSOiqHpM/G
         FpUKQbZhOQZTXnJ+yK5hfCqFi9ATffHsu6XL7o8LrtBbPxSBR8Eyi1cXh91+mDLRFqMu
         tn8lkBnx2XbqpktK8DuIGoNRZ9xwCEhstmQYNK2Sc1SPQzNhAmiJ0OCmYt0SEQqXaxqs
         AoPfyvar2s8dK7J28LAx8x370Hp6Og+7OnCQ4xbRhWJDhZvojrfhXPHeXz34Zufa2uO0
         jcPJkeeF23PX+OpsFmUtAhkAFZhLISpLrbSb3ZjeA2IDVp60+T9r2YgkLoXKqTkj3uov
         tueQ==
X-Gm-Message-State: APjAAAVjmYtKtUhA3hDvaM0tmPPq6kPSdhfs+egzdc8pgnAzMkz1xZZz
        sZaxynfwwF2VcE9n7F0jbAGZcEquDYsUDDOmzFI=
X-Google-Smtp-Source: APXvYqzk1rxcEfCqT+J/MKjQGVLX6nrEXP5fE0UYo23wBJPGAsgyusyYPBAu+lBzJpWZV9RPU1S/tlXC+AS92QWXpmo=
X-Received: by 2002:a1f:b9c6:: with SMTP id j189mr4225201vkf.1.1566622624033;
 Fri, 23 Aug 2019 21:57:04 -0700 (PDT)
MIME-Version: 1.0
References: <pull.316.git.gitgitgadget@gmail.com> <b99acea4a09a6ed5302e5e622a6b6eb35d2d01b1.1566313865.git.gitgitgadget@gmail.com>
In-Reply-To: <b99acea4a09a6ed5302e5e622a6b6eb35d2d01b1.1566313865.git.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 23 Aug 2019 21:56:52 -0700
Message-ID: <CABPp-BFMtO=7UGVZPbqh3tthSetvz5F=W3S=RsryPSuchmZeZw@mail.gmail.com>
Subject: Re: [PATCH 8/9] sparse-checkout: use hashmaps for cone patterns
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 20, 2019 at 8:12 AM Derrick Stolee via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Derrick Stolee <dstolee@microsoft.com>
>
> The parent and recursive patterns allowed by the "cone mode"
> option in sparse-checkout are restrictive enough that we
> can avoid using the regex parsing. Everything is based on
> prefix matches, so we can use hashsets to store the prefixes
> from the sparse-checkout file. When checking a path, we can
> strip path entries from the path and check the hashset for
> an exact match.
>
> As a test, I created a cone-mode sparse-checkout file for the
> Linux repository that actually includes every file. This was
> constructed by taking every folder in the Linux repo and creating
> the pattern pairs here:
>
>         /$folder/*
>         !/$folder/*/*
>
> This resulted in a sparse-checkout file sith 8,296 patterns.
> Running 'git read-tree -mu HEAD' on this file had the following
> performance:
>
>         core.sparseCheckout=false: 0.21 s (0.00 s)
>          core.sparseCheckout=true: 3.75 s (3.50 s)
>          core.sparseCheckout=cone: 0.23 s (0.01 s)

Nice!

> The times in parentheses above correspond to the time spent
> in the first clear_ce_flags() call, according to the trace2
> performance traces.
>
> While this example is contrived, it demonstrates how these
> patterns can slow the sparse-checkout feature.
>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  Documentation/git-sparse-checkout.txt |   1 -
>  dir.c                                 | 154 +++++++++++++++++++++++++-
>  dir.h                                 |  27 +++++
>  t/t1091-sparse-checkout-builtin.sh    |   8 ++
>  4 files changed, 183 insertions(+), 7 deletions(-)
>
> diff --git a/Documentation/git-sparse-checkout.txt b/Documentation/git-sparse-checkout.txt
> index 463319055b..7ade827370 100644
> --- a/Documentation/git-sparse-checkout.txt
> +++ b/Documentation/git-sparse-checkout.txt
> @@ -85,7 +85,6 @@ negate patterns. For example, to remove the file `unwanted`:
>  !unwanted
>  ----------------
>
> -
>  ## CONE PATTERN SET
>
>  The full pattern set allows for arbitrary pattern matches and complicated
> diff --git a/dir.c b/dir.c
> index d021c908e5..2c5ff89a72 100644
> --- a/dir.c
> +++ b/dir.c
> @@ -599,6 +599,99 @@ void parse_exclude_pattern(const char **pattern,
>         *patternlen = len;
>  }
>
> +static int el_hashmap_cmp(const void *unused_cmp_data,
> +                         const void *a, const void *b, const void *key)
> +{
> +       const struct exclude_entry *ee1 = a;
> +       const struct exclude_entry *ee2 = b;
> +
> +       return strncmp(ee1->pattern, ee2->pattern, ee1->patternlen);
> +}
> +
> +static void add_exclude_to_hashsets(struct exclude_list *el, struct exclude *x)

Is this for something that is logically an "include" or an "exclude"?
The earlier use of "exclude" for "include"s now how me totally confused
and makes me know I'll have to read the code really carefully and may
still get messed up.

I don't know if there's a better way, but re-using .gitignore internals
for sparse-checkout stuff leads to this inverted switcheroo and makes
things hard to follow.  Is it too late or too hard to easily rename the
"exclude" stuff used by gitignore to something else more neutral?
Sigh...

> +{
> +       struct exclude_entry *e;
> +       char *truncated;
> +       char *data = NULL;
> +
> +       if (!el->use_cone_patterns)
> +               return;
> +
> +       if (x->patternlen >= 4 &&
> +           !strcmp(x->pattern + x->patternlen - 4, "/*/*")) {
> +               if (!(x->flags & EXC_FLAG_NEGATIVE)) {
> +                       /* Not a cone pattern. */
> +                       el->use_cone_patterns = 0;
> +                       warning(_("unrecognized pattern: '%s'"), x->pattern);
> +                       goto clear_hashmaps;
> +               }
> +
> +               truncated = xstrdup(x->pattern);
> +               truncated[x->patternlen - 4] = 0;
> +
> +               e = xmalloc(sizeof(struct exclude_entry));
> +               e->pattern = truncated;
> +               e->patternlen = x->patternlen - 4;
> +               hashmap_entry_init(e, memhash(e->pattern, e->patternlen));
> +
> +               if (!hashmap_get(&el->recursive_hashmap, e, NULL)) {
> +                       /* We did not see the "parent" included */
> +                       warning(_("unrecognized negative pattern: '%s'"), x->pattern);
> +                       free(truncated);
> +                       goto clear_hashmaps;
> +               }
> +
> +               hashmap_add(&el->parent_hashmap, e);
> +               hashmap_remove(&el->recursive_hashmap, e, &data);
> +               free(data);
> +               return;
> +       }
> +
> +       if (x->patternlen >= 2 &&
> +           !strcmp(x->pattern + x->patternlen - 2, "/*")) {
> +               if (x->flags & EXC_FLAG_NEGATIVE) {
> +                       warning(_("unrecognized negative pattern: '%s'"), x->pattern);
> +                       goto clear_hashmaps;
> +               }
> +
> +               e = xmalloc(sizeof(struct exclude_entry));
> +
> +               truncated = xstrdup(x->pattern);
> +               truncated[x->patternlen - 2] = 0;
> +               e->pattern = truncated;
> +               e->patternlen = x->patternlen - 2;
> +               hashmap_entry_init(e, memhash(e->pattern, e->patternlen));
> +
> +               hashmap_add(&el->recursive_hashmap, e);
> +
> +               if (hashmap_get(&el->parent_hashmap, e, NULL)) {
> +                       /* we already included this at the parent level */
> +                       warning(_("your sparse-checkout file may have issues: pattern '%s' is repeated"),
> +                               x->pattern);
> +                       hashmap_remove(&el->parent_hashmap, e, &data);
> +                       free(data);
> +               }
> +               return;
> +       }
> +
> +clear_hashmaps:
> +       hashmap_free(&el->parent_hashmap, 1);
> +       hashmap_free(&el->recursive_hashmap, 1);
> +       el->use_cone_patterns = 0;
> +}
> +
> +static int hashmap_contains_path(struct hashmap *map,
> +                                struct strbuf *pattern)
> +{
> +       struct exclude_entry e;
> +
> +       /* Check straight mapping */
> +       e.pattern = pattern->buf;
> +       e.patternlen = pattern->len;
> +       hashmap_entry_init(&e, memhash(e.pattern, e.patternlen));
> +       return !!hashmap_get(map, &e, NULL);
> +}
> +
>  void add_exclude(const char *string, const char *base,
>                  int baselen, struct exclude_list *el, int srcpos)
>  {
> @@ -623,6 +716,8 @@ void add_exclude(const char *string, const char *base,
>         ALLOC_GROW(el->excludes, el->nr + 1, el->alloc);
>         el->excludes[el->nr++] = x;
>         x->el = el;
> +
> +       add_exclude_to_hashsets(el, x);
>  }
>
>  static int read_skip_worktree_file_from_index(const struct index_state *istate,
> @@ -848,6 +943,10 @@ static int add_excludes_from_buffer(char *buf, size_t size,
>         int i, lineno = 1;
>         char *entry;
>
> +       el->use_cone_patterns = core_sparse_checkout == SPARSE_CHECKOUT_CONE ? 1 : 0;
> +       hashmap_init(&el->recursive_hashmap, el_hashmap_cmp, NULL, 0);
> +       hashmap_init(&el->parent_hashmap, el_hashmap_cmp, NULL, 0);
> +
>         el->filebuf = buf;
>
>         if (skip_utf8_bom(&buf, size))
> @@ -1070,18 +1169,61 @@ static struct exclude *last_exclude_matching_from_list(const char *pathname,
>
>  /*
>   * Scan the list and let the last match determine the fate.
> - * Return 1 for exclude, 0 for include and -1 for undecided.
> + * Return 0 for exclude, 1 for include and -1 for undecided.

Um...this doesn't make me feel any better about whether we're going to
run into bugs about "include" vs. "exclude".

>   */
>  int is_excluded_from_list(const char *pathname,
>                           int pathlen, const char *basename, int *dtype,
>                           struct exclude_list *el, struct index_state *istate)
>  {
>         struct exclude *exclude;
> -       exclude = last_exclude_matching_from_list(pathname, pathlen, basename,
> -                                                 dtype, el, istate);
> -       if (exclude)
> -               return exclude->flags & EXC_FLAG_NEGATIVE ? 0 : 1;
> -       return -1; /* undecided */
> +       struct strbuf parent_pathname = STRBUF_INIT;
> +       int result = 0;
> +       const char *slash_pos;
> +
> +       if (!el->use_cone_patterns) {
> +               exclude = last_exclude_matching_from_list(pathname, pathlen, basename,
> +                                                               dtype, el, istate);
> +
> +               if (exclude)
> +                       return exclude->flags & EXC_FLAG_NEGATIVE ? 0 : 1;
> +
> +               return -1; /* undecided */
> +       }
> +
> +       strbuf_addch(&parent_pathname, '/');
> +       strbuf_add(&parent_pathname, pathname, pathlen);
> +       slash_pos = strrchr(parent_pathname.buf, '/');
> +
> +       if (slash_pos == parent_pathname.buf) {
> +               /* include every file in root */
> +               result = 1;
> +               goto done;
> +       }
> +
> +       strbuf_setlen(&parent_pathname, slash_pos - parent_pathname.buf);
> +
> +       if (hashmap_contains_path(&el->parent_hashmap, &parent_pathname)) {
> +               result = 1;
> +               goto done;
> +       }
> +
> +       while (parent_pathname.len) {
> +               if (hashmap_contains_path(&el->recursive_hashmap,
> +                                         &parent_pathname)) {
> +                       result = -1;
> +                       goto done;
> +               }
> +
> +               slash_pos = strrchr(parent_pathname.buf, '/');
> +               if (slash_pos == parent_pathname.buf)
> +                       break;
> +
> +               strbuf_setlen(&parent_pathname, slash_pos - parent_pathname.buf);
> +       }
> +
> +done:
> +       strbuf_release(&parent_pathname);
> +       return result;
>  }
>
>  static struct exclude *last_exclude_matching_from_lists(struct dir_struct *dir,
> diff --git a/dir.h b/dir.h
> index 680079bbe3..2d3356d1c0 100644
> --- a/dir.h
> +++ b/dir.h
> @@ -4,6 +4,7 @@
>  /* See Documentation/technical/api-directory-listing.txt */
>
>  #include "cache.h"
> +#include "hashmap.h"
>  #include "strbuf.h"
>
>  struct dir_entry {
> @@ -37,6 +38,13 @@ struct exclude {
>         int srcpos;
>  };
>
> +/* used for hashmaps for cone patterns */
> +struct exclude_entry {
> +       struct hashmap_entry ent;
> +       char *pattern;
> +       size_t patternlen;
> +};
> +
>  /*
>   * Each excludes file will be parsed into a fresh exclude_list which
>   * is appended to the relevant exclude_list_group (either EXC_DIRS or
> @@ -55,6 +63,25 @@ struct exclude_list {
>         const char *src;
>
>         struct exclude **excludes;
> +
> +       /*
> +        * While scanning the excludes, we attempt to match the patterns
> +        * with a more restricted set that allows us to use hashsets for
> +        * matching logic, which is faster than the linear lookup in the
> +        * excludes array above. If non-zero, that check succeeded.
> +        */
> +       unsigned use_cone_patterns;
> +
> +       /*
> +        * Stores paths where everything starting with those paths
> +        * is included.
> +        */
> +       struct hashmap recursive_hashmap;
> +
> +       /*
> +        * Used to check single-level parents of blobs.
> +        */
> +       struct hashmap parent_hashmap;
>  };
>
>  /*
> diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkout-builtin.sh
> index 8cc377b839..60f10864a1 100755
> --- a/t/t1091-sparse-checkout-builtin.sh
> +++ b/t/t1091-sparse-checkout-builtin.sh
> @@ -134,6 +134,14 @@ test_expect_success 'cone mode: match patterns' '
>         test_cmp expect dir
>  '
>
> +test_expect_success 'cone mode: warn on bad pattern' '
> +       test_when_finished mv sparse-checkout repo/.git/info &&
> +       cp repo/.git/info/sparse-checkout . &&
> +       echo "!/deep/deeper/*" >>repo/.git/info/sparse-checkout &&
> +       git -C repo read-tree -mu HEAD 2>err &&
> +       test_i18ngrep "unrecognized negative pattern" err
> +'
> +
>  test_expect_success 'sparse-checkout disable' '
>         git -C repo sparse-checkout disable &&
>         test_path_is_missing repo/.git/info/sparse-checkout &&
> --
> gitgitgadget

So, uh, I saw the exclude vs. include thing, started scanning to see
if it was going to get better, saw the next include/exclude thing that
triggered a bell, and I more or less just scrolled quickly to the
bottom checking if anything might catch my eye.  So I didn't look at
this patch very closely at all.  I decided to just start playing with
the series instead...and as far as that goes, this patch is probably
fine because my testing seemed to work.
