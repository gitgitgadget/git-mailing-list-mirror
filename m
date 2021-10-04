Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9FE9C433FE
	for <git@archiver.kernel.org>; Mon,  4 Oct 2021 15:06:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 891CD60EE0
	for <git@archiver.kernel.org>; Mon,  4 Oct 2021 15:06:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235463AbhJDPIW (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 Oct 2021 11:08:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235461AbhJDPIR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Oct 2021 11:08:17 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7198C061745
        for <git@vger.kernel.org>; Mon,  4 Oct 2021 08:06:27 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id r18so65952444edv.12
        for <git@vger.kernel.org>; Mon, 04 Oct 2021 08:06:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Bq61P6D0Jnz6xbWmO5USVQbKs/lUttrBFLhn9lUYDdM=;
        b=qlPyMKBwWZC5I50Qi7smRRMPxrOZ4P7h+OGMbe0Sxmlbk3NOTqJzStDmpo5Fx6CxLc
         lFH49syMDftPZMIH4bCUiFPnPQd15qI12ctTRWNlk3wSnxv34Ee6dwtes1xT4Yup6HZj
         KLqdxZD9oLvfIX910+0mjZ8RrDbspxNX48ea6eFIc1mX3yHR8o82OENYxz9MVmO8mGVs
         B16L7UharR8aPkEjNZ6hH0KGxUgCL6YBqVmHeqs7g7fefY4yj93iL+0k5TfLItk7xKWW
         QdsOARKEUbBVE4GuJGwj+GZhxcq8qtBgywG/49qdsfPZSKymNnawrfd9x4bT/TVfJvWZ
         X1Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Bq61P6D0Jnz6xbWmO5USVQbKs/lUttrBFLhn9lUYDdM=;
        b=lMgSM1BCFJ6fYH+ZH1pRyOYlt63gq+QLDK08fOYA1+5samjIHaIhtxnSrNKj5svkcP
         5VhN56mU6NKY0KsM7lTs6iJ3RO9RG8U5oTuhBWZMEZz9eXZR8GMBvjQysQ3pQ5An013t
         NojhOCwgN1GO4p8rWZfgE2YcUJO71SvdOXyB8MwynF3BhUAfxooWeBzf/0dRsOtsYdqX
         4jjxRgu7ZDgS34D34jVaqcGoYYn20gOMlECyjiORwnW9eKQfyWfCn4kxB7A3/LBp6BEP
         Xx7K+oL0tjCWorF8ufH+u4tVlIQdJUHpP0fVvfingJCkj8wIZEL1O61hxL7ma2+kGgnp
         JIQA==
X-Gm-Message-State: AOAM532gLndpgqepMxqoZlvPASKqx4bIS63UVaA7JQn0sEilTPz/Iwe1
        R2aH4fcaC1HWjAzGrdr5thNKlSALnCEkBwJv7eg=
X-Google-Smtp-Source: ABdhPJxT39tqahy46KrhR/CtJNd1gZjSd5bvHhKAk4KsXwzcWJdKgDHT7Mw0uvgD2JOTnGLinf/3A8a6aRX4LTjYbE4=
X-Received: by 2002:a17:906:544f:: with SMTP id d15mr18186650ejp.520.1633359851090;
 Mon, 04 Oct 2021 08:04:11 -0700 (PDT)
MIME-Version: 1.0
References: <cover-00.10-00000000000-20211004T002226Z-avarab@gmail.com>
 <patch-02.10-050399cbfbf-20211004T002226Z-avarab@gmail.com>
 <CABPp-BFYxWXZQXvDSrM1Y1ZaQ1d2TENQDvx1cyawvrDO1OvExA@mail.gmail.com> <87y278n8tt.fsf@evledraar.gmail.com>
In-Reply-To: <87y278n8tt.fsf@evledraar.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 4 Oct 2021 08:04:00 -0700
Message-ID: <CABPp-BEA2myh2Np_YpFWnE+jqmT5vz7ohigZ0=2tL-wizgYQmg@mail.gmail.com>
Subject: Re: [PATCH 02/10] merge-recursive.c: call a new unpack_trees_options_init()
 function
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>,
        =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>,
        Andrzej Hunt <ajrhunt@google.com>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 4, 2021 at 7:49 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avar=
ab@gmail.com> wrote:
>
> On Mon, Oct 04 2021, Elijah Newren wrote:
>
> > On Sun, Oct 3, 2021 at 5:46 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <=
avarab@gmail.com> wrote:
> >>
> >> In the preceding commit we introduced a new UNPACK_TREES_OPTIONS_INIT
> >> macro, but "merge-recursive.c" could not be converted to it since
> >> it (re-)initializes a "struct unpack_trees_options" on the heap.
> >>
> >> In order to convert use the macro as the source of truth for
> >> initialization we need to not only convert the initialization in
> >> unpack_trees_start(), but also call the new
> >> unpack_trees_options_init() just after the CALLOC_ARRAY() in
> >> merge_start().
> >
> > Um...why?
>
> Replied below.
>
> >> When we call merge_trees() we'll call merge_start() followed by
> >> merge_trees_internal(), and it will call unpack_trees_start() before
> >> it does much of anything. So it's covered by an initialization in
> >> unpack_trees_start().
> >>
> >> But when merge_recursive() is called it will call merge_start()
> >> followed by merge_recursive_internal(), which won't call
> >> unpack_trees_start() until its own call call to
> >> merge_trees_internal(), but in the meantime it might end up using that
> >> calloc'd "struct unpack_trees_options".
> >
> > Nothing in merge-recursive.c usings unpack_opts before
> > unpack_trees_start() or after unpack_trees_finish().  If anyone
> > attempts to use it elsewhere, that would itself be a bug.  So, I'd
> > replace the above three paragraphs with:
> >
> > "Change the initialization of opt->priv_unpack_opts from using memset
> > to 0, with unpack_trees_options_init()."
> >
> > or something like that, and then drop your change to merge_start().
>
> Sure, I'll defer to you about being confident about that. I didn't want
> to leave a copy if it hanging without the proper initialization in case
> there were new callers.
>
> >> This was OK before, as setup_unpack_trees_porcelain() would call
> >> strvec_init(), and our "struct dir_struct" in turn is OK with being
> >> NULL'd. Let's convert the former to macro initialization, we'll deal
> >> with the latter in a subsequent commit.
> >
> > This is quite confusing; it's really hard to understand how this
> > relates to the rest of the commit message.  I have to read the code to
> > see what you're doing, and then write my own commit message in my head
> > because the wording in this paragraph still doesn't parse.
> >
> > I'd make the change strvec_init/STRVEC_INIT changes be a separate
> > patch.  I suspect it'll be easier to write the commit message for it
> > as a standalone commit as well.
>
> Sure, FWIW I had it split up locally, and figured it would be easier to
> explain if the API usage change came with the initialization change that
> made it possible.
>
> >>
> >> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.co=
m>
> >> ---
> >>  merge-recursive.c | 3 ++-
> >>  unpack-trees.c    | 8 ++++++--
> >>  unpack-trees.h    | 5 ++++-
> >>  3 files changed, 12 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/merge-recursive.c b/merge-recursive.c
> >> index e594d4c3fa1..d24a4903f1d 100644
> >> --- a/merge-recursive.c
> >> +++ b/merge-recursive.c
> >> @@ -405,7 +405,7 @@ static int unpack_trees_start(struct merge_options=
 *opt,
> >>         struct tree_desc t[3];
> >>         struct index_state tmp_index =3D { NULL };
> >>
> >> -       memset(&opt->priv->unpack_opts, 0, sizeof(opt->priv->unpack_op=
ts));
> >> +       unpack_trees_options_init(&opt->priv->unpack_opts);
> >>         if (opt->priv->call_depth)
> >>                 opt->priv->unpack_opts.index_only =3D 1;
> >>         else
> >> @@ -3704,6 +3704,7 @@ static int merge_start(struct merge_options *opt=
, struct tree *head)
> >>
> >>         CALLOC_ARRAY(opt->priv, 1);
> >>         string_list_init_dup(&opt->priv->df_conflict_file_set);
> >> +       unpack_trees_options_init(&opt->priv->unpack_opts);
> >
> > Drop this hunk.
>
> Speaking of splitting things up in more understandable ways: If we're
> going to hard rely on the interaction between merge_start() and
> unpack_trees_start() wouldn't it make sense to lead with a change that
> dropped that memset, which if this invariant holds is also redundant to
> the CALLOC() of opt->priv in merge_start() in the pre-image.

It is not redundant, and that would be a very confusing change.
merge-recursive is so named because its main driving function contains
recursive calls to itself.  merge_start() is not involved in that
recursion.  For readability, we should initialize unpack_opts before
each use.
