Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0E0001F6DC
	for <e@80x24.org>; Wed, 25 Jan 2017 21:31:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752373AbdAYVan (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Jan 2017 16:30:43 -0500
Received: from mail-lf0-f65.google.com ([209.85.215.65]:34103 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752114AbdAYVam (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Jan 2017 16:30:42 -0500
Received: by mail-lf0-f65.google.com with SMTP id q89so22232181lfi.1
        for <git@vger.kernel.org>; Wed, 25 Jan 2017 13:30:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=J5O3rtjtHcYKgVwpde56XZxHu7VFyyh1nC7MijrSC00=;
        b=cF13Ysk7WQK9D6zrFrSbA8BezTffDl35pCBR2Q/MYVUab9KRrkfJbDjC9znL+gMYf7
         1LvgfeOvstbjQEAi8A1oJMMiApF+nPMw4X4vQyBGm6SPLuuMV5oriIWt9AVjwjIqtLXB
         9REjqXnFQLguKeX4Ob8lJan0D6UYL47VwOoHJY/MYUbFRQwXtaE92+STZ/GrebN6hBrL
         KXV3zDN+U3YqQl+f9G9bN2ofgS3+6j1w7KVg2kikwi1XJda9SlWPQUHICvbbJ5fcZh6w
         +ezqRYF/fsahQsfdM38kmBTuMCiLohajJ9EnqM+DL85EbGz8ZV77lbc3aDQM0IK6miBC
         P7UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=J5O3rtjtHcYKgVwpde56XZxHu7VFyyh1nC7MijrSC00=;
        b=nXZIkF6Vat+QKljEh9UVsK+YRr12W2VK7WPE35TC9TEl1ccqtbLWHaeDoFD+xN5hSf
         CiUXqmH4RjW+o17NZy/2cR1Vq5W5kJxp7GmevUKXRcg4yUEK+Qe6EdszP/TBB7bDzz66
         bcq7JtF/mgQ9gMMgFd++UHluCThso9SqfxzOlMWvo3zKuHgsuRUlDzK0Vi7BO+3AY6bz
         syESUp6gtTyatp7ezc40QJHmO94OIQEijcTcGQWw3f4tgUpSQHmK9sdW0YLAqovcDnrJ
         9ZXPmFkLHq3T5iEOdDmF03CSx3F34LZETUqj0KU+T2WSF+h/gvClRmfDYC28xZfYAdSc
         FDpQ==
X-Gm-Message-State: AIkVDXJjaZv2B9Rr5fK9ZzyvO7BLnPlKwNdnkGrXMTPaSeplE956QLwya0h5rB9JTT1xxBROswZwKqChMXjltw==
X-Received: by 10.46.1.153 with SMTP id f25mr15946385lji.47.1485379840690;
 Wed, 25 Jan 2017 13:30:40 -0800 (PST)
MIME-Version: 1.0
Received: by 10.25.145.14 with HTTP; Wed, 25 Jan 2017 13:30:20 -0800 (PST)
In-Reply-To: <20170125212721.7tbxkqsdtsv2n5mx@sigill.intra.peff.net>
References: <20170121140806.tjs6wad3x4srdv3q@sigill.intra.peff.net>
 <20170125125054.7422-1-pclouds@gmail.com> <20170125125054.7422-5-pclouds@gmail.com>
 <20170125205718.ksqstdnazmgbkehy@sigill.intra.peff.net> <20170125212721.7tbxkqsdtsv2n5mx@sigill.intra.peff.net>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Wed, 25 Jan 2017 13:30:20 -0800
Message-ID: <CA+P7+xovOx9ebo6MU0e4v==+76jtoMXz45+LnBPFifHbjqFU4w@mail.gmail.com>
Subject: Re: [PATCH 4/5] revision.c: refactor ref selection handler after --exclude
To:     Jeff King <peff@peff.net>
Cc:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 25, 2017 at 1:27 PM, Jeff King <peff@peff.net> wrote:
> On Wed, Jan 25, 2017 at 03:57:18PM -0500, Jeff King wrote:
>
>> IOW, the ref-selector options build up until a group option is given,
>> which acts on the built-up options (over that group) and then resets the
>> built-up options. Doing "--unrelated" as above is orthogonal (though I
>> think in practice nobody would do that, because it's hard to read).
>
> So here's what I would have expected your series to look more like (with
> probably one patch adding clear_ref_selection_options, and the other
> adding the decorate stuff):
>

I agree that this is how I would have expected it to work as well.

Thanks,
Jake

> diff --git a/revision.c b/revision.c
> index b37dbec37..2f67707c7 100644
> --- a/revision.c
> +++ b/revision.c
> @@ -1156,6 +1156,11 @@ static int handle_one_ref(const char *path, const struct object_id *oid,
>
>         if (ref_excluded(cb->all_revs->ref_excludes, path))
>             return 0;
> +       if (cb->all_revs->decorate_reflog) {
> +               /* TODO actually do it for real */
> +               warning("would decorate %s", path);
> +               return 0; /* do not add it as a tip */
> +       }
>
>         object = get_reference(cb->all_revs, path, oid->hash, cb->all_flags);
>         add_rev_cmdline(cb->all_revs, object, path, REV_CMD_REF, cb->all_flags);
> @@ -1188,6 +1193,12 @@ void add_ref_exclusion(struct string_list **ref_excludes_p, const char *exclude)
>         string_list_append(*ref_excludes_p, exclude);
>  }
>
> +static void clear_ref_selection_options(struct rev_info *revs)
> +{
> +       clear_ref_exclusion(&revs->ref_excludes);
> +       revs->decorate_reflog = 0;
> +}
> +
>  static void handle_refs(const char *submodule, struct rev_info *revs, unsigned flags,
>                 int (*for_each)(const char *, each_ref_fn, void *))
>  {
> @@ -2080,10 +2091,10 @@ static int handle_revision_pseudo_opt(const char *submodule,
>         if (!strcmp(arg, "--all")) {
>                 handle_refs(submodule, revs, *flags, for_each_ref_submodule);
>                 handle_refs(submodule, revs, *flags, head_ref_submodule);
> -               clear_ref_exclusion(&revs->ref_excludes);
> +               clear_ref_selection_options(revs);
>         } else if (!strcmp(arg, "--branches")) {
>                 handle_refs(submodule, revs, *flags, for_each_branch_ref_submodule);
> -               clear_ref_exclusion(&revs->ref_excludes);
> +               clear_ref_selection_options(revs);
>         } else if (!strcmp(arg, "--bisect")) {
>                 read_bisect_terms(&term_bad, &term_good);
>                 handle_refs(submodule, revs, *flags, for_each_bad_bisect_ref);
> @@ -2091,15 +2102,15 @@ static int handle_revision_pseudo_opt(const char *submodule,
>                 revs->bisect = 1;
>         } else if (!strcmp(arg, "--tags")) {
>                 handle_refs(submodule, revs, *flags, for_each_tag_ref_submodule);
> -               clear_ref_exclusion(&revs->ref_excludes);
> +               clear_ref_selection_options(revs);
>         } else if (!strcmp(arg, "--remotes")) {
>                 handle_refs(submodule, revs, *flags, for_each_remote_ref_submodule);
> -               clear_ref_exclusion(&revs->ref_excludes);
> +               clear_ref_selection_options(revs);
>         } else if ((argcount = parse_long_opt("glob", argv, &optarg))) {
>                 struct all_refs_cb cb;
>                 init_all_refs_cb(&cb, revs, *flags);
>                 for_each_glob_ref(handle_one_ref, optarg, &cb);
> -               clear_ref_exclusion(&revs->ref_excludes);
> +               clear_ref_selection_options(revs);
>                 return argcount;
>         } else if ((argcount = parse_long_opt("exclude", argv, &optarg))) {
>                 add_ref_exclusion(&revs->ref_excludes, optarg);
> @@ -2108,17 +2119,19 @@ static int handle_revision_pseudo_opt(const char *submodule,
>                 struct all_refs_cb cb;
>                 init_all_refs_cb(&cb, revs, *flags);
>                 for_each_glob_ref_in(handle_one_ref, arg + 11, "refs/heads/", &cb);
> -               clear_ref_exclusion(&revs->ref_excludes);
> +               clear_ref_selection_options(revs);
>         } else if (starts_with(arg, "--tags=")) {
>                 struct all_refs_cb cb;
>                 init_all_refs_cb(&cb, revs, *flags);
>                 for_each_glob_ref_in(handle_one_ref, arg + 7, "refs/tags/", &cb);
> -               clear_ref_exclusion(&revs->ref_excludes);
> +               clear_ref_selection_options(revs);
>         } else if (starts_with(arg, "--remotes=")) {
>                 struct all_refs_cb cb;
>                 init_all_refs_cb(&cb, revs, *flags);
>                 for_each_glob_ref_in(handle_one_ref, arg + 10, "refs/remotes/", &cb);
> -               clear_ref_exclusion(&revs->ref_excludes);
> +               clear_ref_selection_options(revs);
> +       } else if (!strcmp(arg, "--decorate-reflog")) {
> +               revs->decorate_reflog = 1;
>         } else if (!strcmp(arg, "--reflog")) {
>                 add_reflogs_to_pending(revs, *flags);
>         } else if (!strcmp(arg, "--indexed-objects")) {
> diff --git a/revision.h b/revision.h
> index 9fac1a607..c74879829 100644
> --- a/revision.h
> +++ b/revision.h
> @@ -66,6 +66,8 @@ struct rev_info {
>         /* excluding from --branches, --refs, etc. expansion */
>         struct string_list *ref_excludes;
>
> +       int decorate_reflog;
> +
>         /* Basic information */
>         const char *prefix;
>         const char *def;
