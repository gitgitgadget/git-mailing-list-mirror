Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6597CC433EF
	for <git@archiver.kernel.org>; Thu, 20 Jan 2022 03:29:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234781AbiATD32 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Jan 2022 22:29:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234380AbiATD30 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Jan 2022 22:29:26 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5504BC061574
        for <git@vger.kernel.org>; Wed, 19 Jan 2022 19:29:26 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id z22so22610053edd.12
        for <git@vger.kernel.org>; Wed, 19 Jan 2022 19:29:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=4UrOTSiFO+WJoneRlhH3yD0z3OE5MV1dZ8Wk1xumaSE=;
        b=m3QKrs/emBKyLzVJLp5Nxau5S19g4OlywXS44fp/mmSaNfkPHUYXVPRD3xwidrzsCB
         FRhzP/INV8akf8/QZ5EGpJQzKM8yEpsvwSp6e+5Bi5uc7f0XYWR6GcSDNs0nhwFoy18K
         /Mf0MneWDmb3OqB2jjrG/9rn1eaUus1uFlGIyE3XTDTQnL65ynQGsAn//9hiuEfIprzS
         7ofc87c6OGm4ZWKydCHTsV6iiQjZXGrF/ww9x+TUkPTbAeCSKZinpxvUaROo1somV4Pe
         0b3INPrlRnmBhJljkM4sAyxffw543H1IERgNcPmH34Bm8BeROEIDOILZhfvQOT5JE4Zd
         kGNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=4UrOTSiFO+WJoneRlhH3yD0z3OE5MV1dZ8Wk1xumaSE=;
        b=Bk9Sc1wBU+hwwvLkuJQ50onXTvRxJbPd4xq+MKsGBKENGKexvN6dRmMG0DzCWTe1AR
         9L1mSZEKhnqtdPpb6hS72zkyLqA/CFOnyLZQSOXbshXuQyyu3bIyuFBRSbJ75htD+e3Z
         9kIMa/9N7I13Pi6g6ui1Q+ZNS+jgBINEZWbP1Afr9xtkrESu/VDENE1OTjoTWjMOxziZ
         SqQ5XgNZiSZk3jTNorwY3gU788lxWG5U5Q0yBRoCvj/2HmQcOCP085TnDNCcOuzeSNQ2
         kBICFafetCoZS17W4DWfRWidxdbNN4mMPehPaRu2efyxVuFm87zgv+8fsvSZnAseFvJk
         XNyA==
X-Gm-Message-State: AOAM531F9Np+l0r69YzwiFfRYIYhgBvmp/rlZEE4nbtY92FCd+hkRsGY
        zrUdMh0OecKD7r4vIMhztnnndtCFfFH9GkuOxCc=
X-Google-Smtp-Source: ABdhPJzPHksYi0NDOqYtti0dZ9F/CPt2j7B8xdWCE9bFueXBmRB1vfqP2O02diEcsnB41CoSqgH6VOy8IfVcNwILadw=
X-Received: by 2002:a05:6402:2752:: with SMTP id z18mr34920767edd.153.1642649364863;
 Wed, 19 Jan 2022 19:29:24 -0800 (PST)
MIME-Version: 1.0
References: <pull.1103.v2.git.1640419159.gitgitgadget@gmail.com>
 <pull.1103.v3.git.1640907369.gitgitgadget@gmail.com> <b952f674df13a1c3e4bffa823490f905e862ef7c.1640907369.git.gitgitgadget@gmail.com>
 <220119.86h79zmzy5.gmgdl@evledraar.gmail.com>
In-Reply-To: <220119.86h79zmzy5.gmgdl@evledraar.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 19 Jan 2022 19:29:13 -0800
Message-ID: <CABPp-BHFk9hEFF92W0=MuQ0qOMuSmWz10xV0dYHzZAa=fDuNYA@mail.gmail.com>
Subject: Re: [PATCH v3 3/9] ll-merge: make callers responsible for showing warnings
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Sergey Organov <sorganov@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Neeraj Singh <nksingh85@gmail.com>,
        Johannes Altmanninger <aclopte@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 19, 2022 at 8:51 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
> On Thu, Dec 30 2021, Elijah Newren via GitGitGadget wrote:
>
> > Note that my methodology included first modifying ll_merge() to return
> > a struct, so that the compiler would catch all the callers for me and
> > ensure I had modified all of them.  After modifying all of them, I then
> > changed the struct to an enum.
> > [...]
> > -int ll_merge(mmbuffer_t *result_buf,
> > +enum ll_merge_result ll_merge(mmbuffer_t *result_buf,
> >            const char *path,
> >            mmfile_t *ancestor, const char *ancestor_label,
> >            mmfile_t *ours, const char *our_label,
> > diff --git a/ll-merge.h b/ll-merge.h
> > index aceb1b24132..e4a20e81a3a 100644
> > --- a/ll-merge.h
> > +++ b/ll-merge.h
> > @@ -82,13 +82,20 @@ struct ll_merge_options {
> >       long xdl_opts;
> >  };
> >
> > +enum ll_merge_result {
> > +     LL_MERGE_ERROR =3D -1,
> > +     LL_MERGE_OK =3D 0,
> > +     LL_MERGE_CONFLICT,
> > +     LL_MERGE_BINARY_CONFLICT,
> > +};
> > +
>
> Isn't the other side of the enum checking missing in many cases?
>
> E.g. ll_ext_merge() returns "enum ll_merge_result" now, and does:
>
>         status =3D run_command_v_opt(args, RUN_USING_SHELL);
>         ret =3D (status > 0) ? LL_MERGE_CONFLICT : status;
>
> And grepping at the tip of this series shows:
>
>     $ git grep LL_MERGE_OK
>     ll-merge.c:             ret =3D LL_MERGE_OK;
>     ll-merge.c:                     ret =3D LL_MERGE_OK;
>     ll-merge.c:                     ret =3D LL_MERGE_OK;
>     ll-merge.h:     LL_MERGE_OK =3D 0,
>
> Similar for LL_MERGE_CONFLICT, the only one that's used outside of the
> file itself and its header is LL_MERGE_BINARY_CONFLICT.
>
> I.e. shouldn't these codepaths:
>
>     git grep -w ll_merge
>
> Be doing a switch() on that new enum? E.g. we lose the type in
> three_way_merge() in apply.c, it seems to me that that function should
> switch over this new enum, and return the "int" that the callers of
> three_way_merge() care about (i.e. just <0, 0, 1, not this enum's -1, 0,
> 1, 2.

Actually, three_way_merge()'s callers operate on <0, 0, >0; 1 is not
special.  That's also the interface that ll_merge() traditionally
always used, and which still mostly applies, it's just they now want
to differentiate between two of the >0 cases (namely LL_MERGE_CONFLICT
vs. LL_MERGE_BINARY_CONFLICT).

That may sound like a big change, but since every single caller can
just specially check for LL_MERGE_BINARY_CONFLICT as a first step if
they care (some callers don't), and then drop back to using old code
as-is that assumes <0 vs. 0 vs. >0, that seems like a lot simpler
change.  And that's what this patch does.

Trying to convert all these callers over to switch statements seems
like unnecessary churn to me.  Since Junio has already reviewed a
former round of this patch and found it to his liking (modulo a
completely different one-line issue that I since corrected), I think
I'd like to stick with the patch as-is.  If folks feel really strongly
about changing something here, though, I can change the return type of
the ll_*merge() functions back to int.
