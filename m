Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B8D6C3DA6E
	for <git@archiver.kernel.org>; Fri, 23 Dec 2022 10:44:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235995AbiLWKoW (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Dec 2022 05:44:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230374AbiLWKoV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Dec 2022 05:44:21 -0500
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com [IPv6:2001:4860:4864:20::2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F6D313D4E
        for <git@vger.kernel.org>; Fri, 23 Dec 2022 02:44:20 -0800 (PST)
Received: by mail-oa1-x2f.google.com with SMTP id 586e51a60fabf-1433ef3b61fso5531064fac.10
        for <git@vger.kernel.org>; Fri, 23 Dec 2022 02:44:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+F98HqCGD+7zZyeAQXJx8YckYBcqT/5m1ldxnQWmclw=;
        b=YNJV/LoG9lYfuSUiEu3di4NUJ2qPGC1kSYIMFreelmVJ/G3M49/MdnOhIxiR48OXuj
         cli7+jH7ae90LBt9XkpTHgswzUfJm/bUNWyRLG2+b9mpbrtm9vq3BSLqT4B6YruAbjnF
         B61eTzhgXgScXqVtlLAZR2fvG5Hu1lN3n3SZTlQSvLThOa8d9CeE9efLovgsW6Y6MfEE
         Nzq+cU0Yzh1a5oxyeaDkGJHjjK5uG306FfAuANQzKhfRP0dU+drHr30N2FM25NWmo9JH
         rpgfiBlOq5nGvKOtuEIcSSf8MGs4PIcWLW0MqiXtc8Zqtb0AENv9VGIOfiQuhC9rhSFM
         drxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+F98HqCGD+7zZyeAQXJx8YckYBcqT/5m1ldxnQWmclw=;
        b=dARGdaTgevEum0HcHzwX++qF3bXmFswUv45jnBXH4MKrucAjURGSVSb6qZX5+RS9VH
         rzCsw61BDqp+EAH7PLnZHfjK6/nRXydUFdMs/FrSUWL2ERWSYG/Q/fRsvvJXqtbE/mQt
         ITOp4OgNsBeWl152KrEEfWXa7UTpspAYLBzBfsEHuQp4npbvUPO3I88EzXuKp2velL3g
         ueB0ibtVpB5tcEmoqC9Syfm9YtyUcOwLaC24nzYmIymKAXHdzMYrGpNYZbQN9pLqtymu
         FqtI+b11SaARVl0heswsjal4upuTIYRkzp96MGs9Gi8XFTM/z3GOjwFwiFH/1Ziw253I
         /rdg==
X-Gm-Message-State: AFqh2kpptBXm45ZsMaM7cydzhSnR8uCG+8a0frk62b3xT6Edm2CCz+Je
        KH3e+OZJP0hDS+nq+0ohcN9Ac8Fnhfw1zDACI4M=
X-Google-Smtp-Source: AMrXdXvS61atIzlo1Nvkk0nBOzcUDHtcVqX6nFAbZFTO3qftGWw/q9eJ4qk2fAMxJYU2vGqJQkem6qfLG27kIFThlJI=
X-Received: by 2002:a05:6870:d24b:b0:14c:1850:5947 with SMTP id
 h11-20020a056870d24b00b0014c18505947mr607687oac.270.1671792259228; Fri, 23
 Dec 2022 02:44:19 -0800 (PST)
MIME-Version: 1.0
References: <cover.1671630304.git.karthik.188@gmail.com> <a161dbdf8b70354716d0bfeccc707c242c7f33a1.1671630304.git.karthik.188@gmail.com>
 <cc2e5f1e-8f53-ad83-1f5d-ae910ab60c53@dunelm.org.uk>
In-Reply-To: <cc2e5f1e-8f53-ad83-1f5d-ae910ab60c53@dunelm.org.uk>
From:   Karthik Nayak <karthik.188@gmail.com>
Date:   Fri, 23 Dec 2022 11:43:52 +0100
Message-ID: <CAOLa=ZS=b+6S2ym1P0mxqf9EH4hV9TH9gdYKpeOTDZT3SPREkg@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] attr: add flag `--revision` to work with revisions
To:     phillip.wood@dunelm.org.uk
Cc:     git@vger.kernel.org, Toon Claes <toon@iotcl.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello Phillip,

On Wed, Dec 21, 2022 at 9:57 PM Phillip Wood <phillip.wood123@gmail.com> wrote:
> > Since we use a tree-ish object, the user can pass "--revision
> > HEAD:subdirectory" and all the attributes will be looked up as if
> > subdirectory was the root directory of the repository.
>
> We should be clear in the documentation and option help that --revision
> takes a tree-ish (i.e. --revision=<tree-ish>). Maybe calling the option
> --tree would be clearer.
>

I think we had a discussion around this a bit earlier in the series.
https://lore.kernel.org/git/CAOLa=ZTSzUh2Ma_EMHHWcDunGyKMaUW9BaG=QdegtMqLd+69Wg@mail.gmail.com/

Mostly, that the idea of using `--revision` was taken from
`git-svn(1)`. I'm good to make that change,
what do you think would be best? `--source` or `-tree`? I like
`--tree` better, but I'm open to suggestions.

>
> The implementation looks good apart from failing to bail out if it
> cannot parse the argument to --revision (perhaps we should add a test
> for that). I've left a few suggestions below.
>

Thank you for the review!

> > Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
> > Signed-off-by: Toon Claes <toon@iotcl.com>
> > Co-authored-by: toon@iotcl.com
>
> > diff --git a/attr.c b/attr.c
> > index 42ad6de8c7..6c69e82080 100644
> > --- a/attr.c
> > +++ b/attr.c
> > @@ -11,8 +11,12 @@
> >   #include "exec-cmd.h"
> >   #include "attr.h"
> >   #include "dir.h"
> > +#include "strbuf.h"
> > +#include "tree-walk.h"
>
> These new includes are not required.
>

Will remove!

>  > diff --git a/attr.h b/attr.h
>  > index 3fb40cced0..f4a2bedd68 100644
>  > --- a/attr.h
>  > +++ b/attr.h
>  > @@ -1,6 +1,8 @@
>  >  #ifndef ATTR_H
>  >  #define ATTR_H
>  >
>  > +#include "hash.h"
>
> This include is not required.
>

Will remove!

> > diff --git a/builtin/check-attr.c b/builtin/check-attr.c
> > index 0fef10eb6b..04640e0297 100644
> > --- a/builtin/check-attr.c
> > +++ b/builtin/check-attr.c
> > @@ -1,3 +1,4 @@
> > +#include "repository.h"
>
> This include is not required. Also please add any new includes below
> cache.h as Junio has previously mentioned.
>

Understood. I missed this.

> > +     if (revision) {
> > +             tree_oid = xmalloc(sizeof(struct object_id));
>
> I think we prefer 'var = xmalloc(sizeof(*var));' to avoid errors if the
> type of var changes. This allocation does not appear to be freed
> anywhere. We could avoid the allocation by delcaring an automatic
> variable above and setting tree_oid to point to it here.
>

Understood, let me do that.

> > +             if (repo_get_oid_tree(the_repository, revision, tree_oid))
> > +                     error("%s: not a valid revision", revision);
>
> We should die() here rather than continuing with a bad tree.
>

Will switch to `die(...)`

> > +     git $git_opts check-attr --revision $revision test -- "$path" >actual 2>err &&
>
> err is never used. Should we be doing 'test_must_be_empty err'?
>

Yeah this makes sense, let me add it in.

> > +     echo "$path: test: $expect" >expect &&
> > +     test_cmp expect actual
> >   }
> >
> > [...]
> > +test_expect_success 'setup branches' '
> > +     (
> > +             echo "f test=f" &&
> > +             echo "a/i test=n"
> > +     )
>
> We'd normally write this as
>
>         test_write_lines "f test=f" "a/i test=n" | git hash-object ...
>
> However I think it would be simpler to create the commit with something like
>
> mkdir -p foo/bar &&
> test_commit --printf "add .gitattributes" foo/bar/.gitattributes \
>         "t test=f\na/i test=n\n" tag-1 &&
> rm -r foo/bar/.gitattributes
>
> which would also reduce the number of processes. Failing that a helper
> function to reduce the duplication would be a good idea.
>

Thanks for this, my method was mostly put together with what I could make work,
this is much cleaner. We don't need to ` rm -r foo/bar/.gitattributes`
as far as I see.

> | git hash-object -w --stdin >id &&
> > +     git update-index --add --cacheinfo 100644,$(cat id),foo/bar/.gitattributes &&
> > +     git write-tree >id &&
> > +     tree_id=$(cat id) &&
>
> For future reference it is perfectly fine to write
>         tree_oid=$(git write-tree) &&
>
> as we will still detect a non-zero exit code from git.
>

Noted.

> > +     git commit-tree $tree_id -m "random commit message" >id &&
> > +     commit_id=$(cat id) &&
> > +     git update-ref refs/heads/branch1 $commit_id &&
> > +
> > +     (
> > +             echo "g test=g" &&
> > +             echo "a/i test=m"
> > +     ) | git hash-object -w --stdin >id &&
> > +     git update-index --add --cacheinfo 100644,$(cat id),foo/bar/.gitattributes &&
> > +     git write-tree >id &&
> > +     tree_id=$(cat id) &&
> > +     git commit-tree $tree_id -m "random commit message" >id &&
> > +     commit_id=$(cat id) &&
> > +     git update-ref refs/heads/branch2 $commit_id
> > +'
> > [...]
> >   test_expect_success 'setup bare' '
> >       git clone --template= --bare . bare.git
> >   '
> > @@ -306,6 +347,27 @@ test_expect_success 'bare repository: check that .gitattribute is ignored' '
> >       )
> >   '
> >
> > +test_expect_success 'bare repository: with --revision' '
> > +     (
> > +             cd bare.git &&
>
> You could create a bare clone of the existing repo rather than having to
> recreate the commits here.
>

Makes sense, let me simplify this too.


-- 
- Karthik
