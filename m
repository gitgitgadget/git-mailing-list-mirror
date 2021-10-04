Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F338EC433EF
	for <git@archiver.kernel.org>; Mon,  4 Oct 2021 16:29:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D868161184
	for <git@archiver.kernel.org>; Mon,  4 Oct 2021 16:29:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237000AbhJDQbI (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 Oct 2021 12:31:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236970AbhJDQbH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Oct 2021 12:31:07 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5E6FC061745
        for <git@vger.kernel.org>; Mon,  4 Oct 2021 09:29:17 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id b8so32476686edk.2
        for <git@vger.kernel.org>; Mon, 04 Oct 2021 09:29:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=07Jfz2O8thnrFludzmaEuTe66pkTL2qYbnNKgF/UdxQ=;
        b=VeUSV5KuLeJs3538SUeTk1cV1nxAv14gDOiViRnTIMxsMaKlpSa6MVBg+T0z+0jbJ2
         TNMV6wjSrafqEfyK2ShlRrwjX4VxInEh3JFi0cMP7nOTDTqcLAPSl/GKckT6/QO/2Uei
         NG6tikugCSpjfDNVVP2EGj/tkvzXqlWDnuRe1TF+ouSGdZ3CyJhR1WA2uVRg2qpW+jmR
         41bNl4w4+lH8eCaHJyB7ZTrNe4inRx0wkcbq6NStFisk0NfhT+myjlBrPaAb4dSWjwrk
         ukB0MUUY+QRNLq2D8b4dMnaaHo6a+dXoyb0oKwh+BBKq2pCV5E7jiic6BgRwCQ2pEYqp
         Gi5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=07Jfz2O8thnrFludzmaEuTe66pkTL2qYbnNKgF/UdxQ=;
        b=V+0Xdi+CSkOC55dT2taX3klX114XTivhCDhfLEk8A/ohjQpepUv6i0fTm70nSfPymt
         eyMh6efm1cGkSEd49zhoQ0j9g9jp3rUp+rVSXI9qka4mj5fUHiOr/bcTugaqvHFhdCJA
         xjWXODyaSppqbRcwVI7cepWZLmkn7WHygUs+4KcW4A+LBTNFxQmrgeoPX37tIrz88Kd2
         9I3lxo8AO1aeqKvf9+YHr7d/VkNH4J+R6dCUOmKu3skXyou9IUytDqvFA1niB3freVs8
         Et7ATvdOdPVNj4++pW0o39nrh89WH02sfWzEdt9Ofqwh4wF8Zaw2P+54qzk/dpzyI0JO
         /QJw==
X-Gm-Message-State: AOAM531mnRNQlq8kz9PK7lkyjkjzUk4xeG9WJ92enU6XtQf58mEwJOzb
        1N6FbZMbvEsYnXrkXvF2Jr1qkau629n+oN/GWKk=
X-Google-Smtp-Source: ABdhPJws7thFkW3i+DQjSErDY5QwcPSIlhq1M6E7cuyprwilY6HEKyT5wANwMPOlXOKL5XQBN+2ofhiQWriWimfL+Gs=
X-Received: by 2002:a50:cd02:: with SMTP id z2mr1083980edi.241.1633364910982;
 Mon, 04 Oct 2021 09:28:30 -0700 (PDT)
MIME-Version: 1.0
References: <cover-00.10-00000000000-20211004T002226Z-avarab@gmail.com>
 <patch-04.10-9d62edd35bf-20211004T002226Z-avarab@gmail.com>
 <CABPp-BH4ubjJ98Nvgp2iyKxmU9X+ypw4m1o=iL9Z4vSNZ-QTDw@mail.gmail.com> <87lf38n6e4.fsf@evledraar.gmail.com>
In-Reply-To: <87lf38n6e4.fsf@evledraar.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 4 Oct 2021 09:28:18 -0700
Message-ID: <CABPp-BGN_cyLVRRcz_BfriK5Gw=3mdUoSmePT4qFSmV6uYgJ3Q@mail.gmail.com>
Subject: Re: [PATCH 04/10] unpack-trees API: don't have clear_unpack_trees_porcelain()
 reset
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

On Mon, Oct 4, 2021 at 8:42 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avar=
ab@gmail.com> wrote:
>
> On Mon, Oct 04 2021, Elijah Newren wrote:
>
> > On Sun, Oct 3, 2021 at 5:46 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <=
avarab@gmail.com> wrote:
> >>
> >> Change the clear_unpack_trees_porcelain() to be like a *_release()
> >> function, not a *_reset() (in strbuf.c terms). Let's move the only API
> >> user that relied on the latter to doing its own
> >> unpack_trees_options_init(). See the commit that introduced
> >> unpack_trees_options_init() for details on the control flow involved
> >> here.
> >>
> >> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.co=
m>
> >> ---
> >>  merge-recursive.c | 1 +
> >>  unpack-trees.c    | 1 -
> >>  2 files changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/merge-recursive.c b/merge-recursive.c
> >> index d24a4903f1d..a77f66b006c 100644
> >> --- a/merge-recursive.c
> >> +++ b/merge-recursive.c
> >> @@ -442,6 +442,7 @@ static void unpack_trees_finish(struct merge_optio=
ns *opt)
> >>  {
> >>         discard_index(&opt->priv->orig_index);
> >>         clear_unpack_trees_porcelain(&opt->priv->unpack_opts);
> >> +       unpack_trees_options_init(&opt->priv->unpack_opts);
> >
> > This is wrong.  It suggests that unpack_opts is used after
> > unpack_trees_finish() (other than an outer merge first calling
> > unpack_trees_start() again), which can only serve to greatly confuse
> > future readers.  Drop this hunk.
>
> Sure, but (and also re:
> https://lore.kernel.org/git/CABPp-BEA2myh2Np_YpFWnE+jqmT5vz7ohigZ0=3D2tL-=
wizgYQmg@mail.gmail.com/)
> if you'd like not initialize things in merge_start() just for good
> measure wouldn't the diff-at-the-end on top of your 5bf7e5779ec
> (merge-recursive: split internal fields into a separate struct,
> 2019-08-17) also make sense?

Sorry, I can't parse this sentence.  Could you retry?

> I.e. the reason I entered this particular rabbit hole was in looking at
> existing members of "struct merge_options_internal" & past commits and
> seeing how we did its initialization. That canary on top passes all our
> tests, and per my reading we also don't use "df_conflict_file_set" until
> as late as the things we setup in unpack_trees_start(). Should those be
> moved to do the post-merge_start() setup at the same time?

It appears df_conflict_file_set has some theoretical memory leaks
(though in practice unlikely and quite small in the few cases that
could be constructed to trigger it).  Initializing it nearer to use
and free'ing when done (in merge_trees_internal()) would  make more
sense, yes.

But, merge-recursive.c right now is supposed to be the stable fallback
in case someone runs into an issue with merge-ort.  I'd rather keep it
stable in preparation for deleting it, not churning its code
unnecessarily.

> >>  }
> >>
> >>  static int save_files_dirs(const struct object_id *oid,
> >> diff --git a/unpack-trees.c b/unpack-trees.c
> >> index 94767d3f96f..e7365322e82 100644
> >> --- a/unpack-trees.c
> >> +++ b/unpack-trees.c
> >> @@ -197,7 +197,6 @@ void clear_unpack_trees_porcelain(struct unpack_tr=
ees_options *opts)
> >>  {
> >>         strvec_clear(&opts->msgs_to_free);
> >>         dir_clear(&opts->dir);
> >> -       memset(opts->msgs, 0, sizeof(opts->msgs));
> >
> > This seems like a very dangerous change.  You want to leave opts->msgs
> > pointing at freed memory?
>
> Yes, as argued in
> http://lore.kernel.org/git/87bl45niqs.fsf@evledraar.gmail.com; In this
> series we can see that nothing re-uses it, so it's as safe as our
> strbuf_release(), or a plain free().

strbuf_release() sets sb->buf to strbuf_slopbuf, and sets sb->len =3D
sb->alloc =3D 0.  The strbuf can thus be reused after calling
strbuf_release().

strvec_clear() also calls strvec_init() afterwards to set the vector
to be usable though 0-sized.

hashmap_clear() also clears out existing data, but makes it ready for
reuse (as per 6da1a25814)

strmap_clear(), strintmap_clear(), and strset_clear() also set up the
data structure for reuse.

There's a longstanding presumption that something named `*_clear()`
will make it still usable afterwards.  Rename it to end with `_free`
if you want it to be an analogy to free() where usage afterwards would
cause use-after-free errors.

> Maybe I'm misunderstanding what you're getting at, and I could
> understand a "let's just reset it for good measure" POV. But I can't
> square your view that we shouldn't do setup in merge_start() for good
> measure in case some new future code accidentally uses the data earlier
> (which I'm fine with), but then also not finding it OK to skip the
> memset() here ...

No existing caller needs to make use of the fact that it's a `_clear`
function rather than a `_free` function, but if you want to take
advantage of that to do less work, you should both call it out in your
commit message and rename the function.  You didn't do either.  In
fact, your existing commit message mentions strbuf_release(), which
reinforces the `_clear` presumption of reusability and thus makes me
flag the change as dangerous.
