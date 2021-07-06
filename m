Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-23.7 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29B15C07E96
	for <git@archiver.kernel.org>; Tue,  6 Jul 2021 09:53:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0DB966199C
	for <git@archiver.kernel.org>; Tue,  6 Jul 2021 09:53:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231214AbhGFJ4B (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Jul 2021 05:56:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230472AbhGFJ4B (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Jul 2021 05:56:01 -0400
Received: from mail-ua1-x92a.google.com (mail-ua1-x92a.google.com [IPv6:2607:f8b0:4864:20::92a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9EFEC061574
        for <git@vger.kernel.org>; Tue,  6 Jul 2021 02:53:21 -0700 (PDT)
Received: by mail-ua1-x92a.google.com with SMTP id c20so8036130uar.12
        for <git@vger.kernel.org>; Tue, 06 Jul 2021 02:53:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Qj2H3auclOmuuDprK6GPmJa9aTy4nuW6U7nHhePrsjA=;
        b=GmecC7Yl0K27XMmyIb68VxPxd6aTVOum47QR3pBOXdGjvOY8/V56lAw/VBDpqBerA1
         GizdJNJlIVhKIQwwiVKFBn4QlM6K86ip2goW+aBWcTVn4snyxOBd7WB/XDMrYWXbJwb2
         oriWa5gO9ctUTiuGaUyTryKiagE3REe1Ct1veKAlGjgbpg8CFegVXnxXz/dUMoM1SQpM
         BuO7eiaoZhhZRFPXQonnj9EayumgGBZ57AL7f0PIz0EGE5JLJ6QWNufsP3Y7QXPEQLa5
         REBDIaa0C01ZTI1uOLr/Lfnvgj1W58qMwWmiHkCM8AAK/zd1tyxlZrmwQxtjOn5XDu+8
         tmNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Qj2H3auclOmuuDprK6GPmJa9aTy4nuW6U7nHhePrsjA=;
        b=rlS9YgN1GUzyWuNtRrvoNAd1H283nkKf0QoauxGYNPbydoO8TryIGDP9IDMZDUUCBu
         P8ToRNUfSMGPe3twJZ3KTws9LBSs4AQ1fV+HInC28gADnczhEohH1xWWKpLs3PHEQslt
         ZHzA1WBLFDc1vP3ufvF/P/UIVoOnrYeZ11A5u245JeRmrrmQGT0lJ2kPmW1wpeWFKuuE
         pnyy2WpUwVMRnyfRDp5xnYyWfOGglXaJV40Ca9ym+q1CJot8zyHwgYQOVb+AklsEwvor
         5oiyjpPtDZZWhbB3fc94yvHTRwXkX/avMLvvvfQmD2bicpGtsrb93oj8Vlb3fsYBUbTx
         708g==
X-Gm-Message-State: AOAM530J1iO9+xjd7cd76eq6jBgkgt3bRP7tuMFbAt6FuekOdCMbULv/
        DzcDa8VlznZdqA2dFFPWNX5VkrAJbNxS3MbjVFaFVA==
X-Google-Smtp-Source: ABdhPJwbrBawv5k9o38LlxVu8M5KkffuafHZW55/DgoF/CPc5xg999K2U9+ZSLNYhKhdLg/zpW7smflBHU119/jrYXg=
X-Received: by 2002:ab0:7305:: with SMTP id v5mr14859137uao.47.1625565200776;
 Tue, 06 Jul 2021 02:53:20 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1012.v2.git.git.1623329868.gitgitgadget@gmail.com>
 <pull.1012.v3.git.git.1625518566.gitgitgadget@gmail.com> <87v95o5ku8.fsf@evledraar.gmail.com>
In-Reply-To: <87v95o5ku8.fsf@evledraar.gmail.com>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Tue, 6 Jul 2021 11:53:08 +0200
Message-ID: <CAFQ2z_N_J499X_wd4RGR7jobs3O3NvQuobJ9UcQijkNYN712dw@mail.gmail.com>
Subject: Re: [PATCH v3 0/5] refs: cleanup errno sideband ref related functions
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>,
        Han-Wen Nienhuys <hanwenn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 6, 2021 at 2:48 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avar=
ab@gmail.com> wrote:
>
>
> On Mon, Jul 05 2021, Han-Wen Nienhuys via GitGitGadget wrote:
>
> > v5
>
> v3?

I erroneously closed out the github PR I used for the first 2 versions
of this change series.  (https://github.com/git/git/pull/1011)

> >  * address =C3=86var's comment; punt on clearing errno.
> > [...]
> >
> >           Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
> >           Reviewed-by: Jonathan Tan <jonathantanmy@google.com>
> >      +    Reviewed-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@g=
mail.com>
>
> FWIW per Documentation/SubmittingPatches:
>
>     . `Reviewed-by:`, unlike the other tags, can only be offered by the
>       reviewer and means that she is completely satisfied that the patch
>       is ready for application.  It is usually offered only after a
>       detailed review.
>
> It's not that I'm hard to please, but I can honestly say that I don't
> quite understand some parts of what you're gonig for, so that trailer is
> probably premature :)

oh, ok. Removed them.

Does that mean you'd have to repost my patchseries just to add the
reviewed-by header?

> To rephrase my comment on the v2 to hopefully better get at the
> point/question I had.
>
> It wasn't that I don't get why you wouldn't save/restore errno in
> general.
>
> It's that the pattern of doing so seems backwards to me. I.e. surely the
> goal here should be to one function at a time, and from the bottom-up,
> figure out where we rely on "errno" and convert that to a
> "failure_errno".
>
> Instead not even files_read_raw_ref() resets "errno =3D 0" at the end, so
> the errno /there/ can propagate upwards, and in this v3 we're not clearin=
g it at all.

I would really want errno to be an explicit output for more functions
in refs.h, but I don't have the time to see that through, and it's a
distraction from the reftable work, so I have changed the objective of
the patch series.

I'm limiting myself to explicitly propagating errno values that are
used beyond error reporting. The EINVAL value for
parse_loose_ref_contents is a borderline case: it has an extra "if ()"
body in lock_raw_ref, but it's for an error message.

This means that we should avoid clearing errno, because we'd otherwise
have to track down all the places where it's being put into
strerror(). The one case you found earlier is still there, and by not
clearing errno, I can keep this series smaller by not also having to
rework verify_lock/read_refs_full.

In general, it's frustrating to observe that the files backend is a
complex beast that nobody understands, but in order to replace it with
something more principled, I have to spend lots of time cleaning it
up.

> Having dug a bit further, it seems what you're doing, whether it's
> intentional or not, is relying on the parse_loose_ref_contents() setting
> EINVAL, but you clobber your *failure_errno with it whether it returned
> -1 or not.

I've added a failure_errno argument parse_loose_ref_contents now.

--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--
Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
