Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23AFEC07E96
	for <git@archiver.kernel.org>; Fri,  9 Jul 2021 00:58:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EBF5F61468
	for <git@archiver.kernel.org>; Fri,  9 Jul 2021 00:58:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230089AbhGIBBe (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Jul 2021 21:01:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229843AbhGIBBe (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Jul 2021 21:01:34 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1340C061574
        for <git@vger.kernel.org>; Thu,  8 Jul 2021 17:58:51 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id w74so10149623oiw.8
        for <git@vger.kernel.org>; Thu, 08 Jul 2021 17:58:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5vmqmkAUSoOSZhUuyxFJShPZCULZ92xm2q6Pj2ITMWM=;
        b=WUwMWZ59Gkgs+Ng0mKIpfk5OyC0WW4VdtHS5zknIjleomu8+n6CYF3Fm5YjTRFBfQf
         0t8ENzDZdILPTR3irQD3vRm+u3cuKB/v9215dG2S1q7I8tn+yjCSRyKEd1THnAXI6urG
         4yqJl80ZvcBsPT3i4fDRKZ6C0fpXGsUp8lgKDcZ3sFKGMd22MvfuYxRPsQpr441sJflO
         7UHSt9lMTLwTq8BTyAVCBMhEPpb2dPd4F0Hceq+XEi/BBoeXR8uejZLP2wGyfXpvOf13
         yopYrGyG8X85YyYtxdjs/G51LC2T5gih92Z7C5J9Fi3Awpu5jkczlWzz0inpY4wFh2S3
         JAHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5vmqmkAUSoOSZhUuyxFJShPZCULZ92xm2q6Pj2ITMWM=;
        b=dbR0XulYc/+Xldgz0fwEbCrZSns0o0W58veLtFpbj/jrRBQfYRMXEtN73JoRWV0Fp8
         YJDtArncpgXFqSpibvlCTU9zHkowmr/qMgeirYE7J54rGIGtu7ibcKcDiuZ4LFewgVm2
         LTM3AYUiG13lnyXzmdG9EJtX9uTbLygwpPxWqZZYnaKd/tzxtR+fHMYyU60H7CRhipfM
         jdTvazOiKl7O8AxRh8/pUc1VH+rvrgdhvH7fBQir1u8+W37ZqsnLiCZn/tw9tb4ZE0an
         WoO6V5PmATmUw4OvMB7wklYuNX7aCZdIz5/XIbcErr5EzSeazwt56a6OzrhE7EV4un9n
         UgCg==
X-Gm-Message-State: AOAM5315vlvwlCmgnCc+T5bVnUUe7oQU8ndA0g1HsBrd4IOOjg3NvqyI
        eG5jhlxqHpKNvd1meZEtrewzIaBmETb9K9WgldA=
X-Google-Smtp-Source: ABdhPJyQue+EPYQXujReRYFaCZaG1vye0gEDSiwZVbgC6XcUgTgABn4HN+djvxavtoag1/gj8nGgCGcXFM05F1UwtWs=
X-Received: by 2002:aca:acc5:: with SMTP id v188mr5779183oie.167.1625792330939;
 Thu, 08 Jul 2021 17:58:50 -0700 (PDT)
MIME-Version: 1.0
References: <pull.932.v6.git.1624931502.gitgitgadget@gmail.com>
 <pull.932.v7.git.1624932293.gitgitgadget@gmail.com> <9f31c691af6780f0ea48bdcb5ff6d56b628f1a81.1624932294.git.gitgitgadget@gmail.com>
 <CABPp-BEcELkxaVT1nPca7VL=OcWaMQ4XYsbjNBuw6xbUw9x42w@mail.gmail.com>
In-Reply-To: <CABPp-BEcELkxaVT1nPca7VL=OcWaMQ4XYsbjNBuw6xbUw9x42w@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 8 Jul 2021 17:58:39 -0700
Message-ID: <CABPp-BHwTAKwFiWQ0-2P=_g+7HLK5FfOAz-uujRjLou1fXT3zw@mail.gmail.com>
Subject: Re: [PATCH v7 10/16] unpack-trees: handle dir/file conflict of sparse entries
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        Derrick Stolee <stolee@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 7, 2021 at 4:19 PM Elijah Newren <newren@gmail.com> wrote:
>
> On Mon, Jun 28, 2021 at 7:05 PM Derrick Stolee via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
> >
> > From: Derrick Stolee <dstolee@microsoft.com>
> >
> > Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> > ---
> >  t/t1092-sparse-checkout-compatibility.sh | 25 ++++++++++++++++++++++--
> >  unpack-trees.c                           |  5 ++++-
> >  2 files changed, 27 insertions(+), 3 deletions(-)
> >
> > diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
> > index 3f61e5686b5..4e6446e7545 100755
> > --- a/t/t1092-sparse-checkout-compatibility.sh
> > +++ b/t/t1092-sparse-checkout-compatibility.sh
> > @@ -95,6 +95,19 @@ test_expect_success 'setup' '
> >                 git add . &&
> >                 git commit -m "rename deep/deeper1/... to folder1/..." &&
> >
> > +               git checkout -b df-conflict base &&
> > +               rm -rf folder1 &&
> > +               echo content >folder1 &&
> > +               git add . &&
> > +               git commit -m df &&
> > +
> > +               git checkout -b fd-conflict base &&
> > +               rm a &&
> > +               mkdir a &&
> > +               echo content >a/a &&
> > +               git add . &&
> > +               git commit -m fd &&
> > +
> >                 git checkout -b deepest base &&
> >                 echo "updated deepest" >deep/deeper1/deepest/a &&
> >                 git commit -a -m "update deepest" &&
> > @@ -325,7 +338,11 @@ test_expect_success 'diff --staged' '
> >  test_expect_success 'diff with renames and conflicts' '
> >         init_repos &&
> >
> > -       for branch in rename-out-to-out rename-out-to-in rename-in-to-out
> > +       for branch in rename-out-to-out \
> > +                     rename-out-to-in \
> > +                     rename-in-to-out \
> > +                     df-conflict \
> > +                     fd-conflict
> >         do
> >                 test_all_match git checkout rename-base &&
> >                 test_all_match git checkout $branch -- .&&
> > @@ -338,7 +355,11 @@ test_expect_success 'diff with renames and conflicts' '
> >  test_expect_success 'diff with directory/file conflicts' '
> >         init_repos &&
> >
> > -       for branch in rename-out-to-out rename-out-to-in rename-in-to-out
> > +       for branch in rename-out-to-out \
> > +                     rename-out-to-in \
> > +                     rename-in-to-out \
> > +                     df-conflict \
> > +                     fd-conflict
> >         do
> >                 git -C full-checkout reset --hard &&
> >                 test_sparse_match git reset --hard &&
>
> Tests look good...
>
> > diff --git a/unpack-trees.c b/unpack-trees.c
> > index d141dffbd94..e63b2dcacbc 100644
> > --- a/unpack-trees.c
> > +++ b/unpack-trees.c
> > @@ -2617,7 +2617,10 @@ int twoway_merge(const struct cache_entry * const *src,
> >                          same(current, oldtree) && !same(current, newtree)) {
> >                         /* 20 or 21 */
> >                         return merged_entry(newtree, current, o);
> > -               } else
> > +               } else if (current && !oldtree && newtree &&
> > +                          S_ISSPARSEDIR(current->ce_mode) != S_ISSPARSEDIR(newtree->ce_mode))
> > +                       return merged_entry(newtree, current, o);
> > +               else
> >                         return reject_merge(current, o);
> >         }
> >         else if (newtree) {

t1092 still passes if you replace the
    return merged_entry(newtree, current, o);
line with
    die("This line is never hit.");

Is it possible that you thought you needed this block but further
refactoring removed the need?  Or that it is only needed by the later
ds/commit-and-checkout-with-sparse-index topic (which I haven't yet
reviewed, because I was reviewing this topic first)?  It seems this
code change should either be dropped, or moved out to the relevant
series that uses it.

> This seems wrong to me but I'm having a hard time nailing down a
> testcase to prove it.  The logic looks to me like "if the old tree as
> nothing in the index at the given path, and the newtree has something,
> and the index had something staged, but the newtree and staged index
> entry disagree on the type of the object, do some weird merged_entry()
> logic on both types of trees that tends to just take the newer I
> thought but who knows what functions like verify_uptodate(entry) do
> when entry is a sparse directory...".
>
> So, I'm not so sure about this.  Could you explain this a bit more?
>
> However, I did find a testcase that aborts with a fatal error...though
> I can't tell if it's even triggering the above logic; I think it isn't
> because I have an "ignoreme" on both sides of the history.  Here's the
> testcase:
>
> # Make a little test repo
> git init dumb
> cd dumb
>
> # Setup old commit
> touch tracked
> echo foo >ignoreme
> git add .
> git commit -m "Initial"
> git branch orig
>
> # Setup new commit
> git rm ignoreme
> mkdir ignoreme
> touch ignoreme/file
> git add ignoreme/file
> git commit -m "whatever"
>
> # Switch to old commit
> git checkout orig
>
> # Make index != new (and index != old)
> git rm ignoreme
> mkdir ignoreme
> echo user-data >ignoreme/file
> git add ignoreme/file
>
> # Sparsify
> GIT_TEST_SPARSE_INDEX=0 # GIT_TEST_SPARSE_INDEX is documented as a boolean;
>                         # but the traditional boolean value is ignored and it
>                         # really only cares about set/unset.  Confusing.
> git sparse-checkout init --cone --sparse-index
> git sparse-checkout set tracked
>
> # Check status and dirs/paths in index
> git status --porcelain
> test-tool read-cache --table
> test-tool read-cache --table --expand
>
> # Run a command that aborts with a fatal error
> git checkout -m master

It turns out that this testcase I provided still triggers the same
fatal error if you omit the --sparse-index flag, so it's not a
sparse-index-specific bug.

So, perhaps it shouldn't hold up this series, but given that a lot of
your correctness verification in t1092 relies on comparisons between
sparse checkouts and sparse indexes, it might be worth trying to get
to the root of this.
