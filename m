Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,RDNS_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (unknown [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26016C433C1
	for <git@archiver.kernel.org>; Sun, 21 Mar 2021 03:10:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E8AC6197E
	for <git@archiver.kernel.org>; Sun, 21 Mar 2021 03:10:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229821AbhCUCqg (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 20 Mar 2021 22:46:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229787AbhCUCqE (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 Mar 2021 22:46:04 -0400
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com [IPv6:2607:f8b0:4864:20::c32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AE4CC061574
        for <git@vger.kernel.org>; Sat, 20 Mar 2021 19:46:04 -0700 (PDT)
Received: by mail-oo1-xc32.google.com with SMTP id i25-20020a4aa1190000b02901bbd9429832so3290573ool.0
        for <git@vger.kernel.org>; Sat, 20 Mar 2021 19:46:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=0GY4VH06NWtV1tcZL7/THsAUipuICZ/qE4o6Sd7nkTI=;
        b=hxDGZ+mlm9iNDdhK9QEdWC9u8tlxCw5SPOZpR/QN6dYAwD5ZP69YrU13fBlQxJ9R9h
         kkw9FCU9Vt9Yu9e+qd3e8FnTdaboC4WXgJLx/8OJF+SmaP7tX3y5otr4HdW0oueAu47o
         i7GkAX49MllXfkHSpaXta99d7vpWLPk7J7koyEX7dSTEiNutKWYBnrJYrGmWCV1+K9KF
         R850J8z12wDnWCmba53QSqGWMmfg3uXNEGYwkUW7Xh2rcXGgf1ELu65maeYLzH61/XKD
         g6cjp94YN2/9d/LzfSY1vGfR+WPi07ceOvNV7jBfXRiuP4cBqtfWNYjrugPwrUm7mft5
         4TNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=0GY4VH06NWtV1tcZL7/THsAUipuICZ/qE4o6Sd7nkTI=;
        b=hy5QKYAaatKrTZbBMxxKrW+r53wEA/fAqg5/K8WvsQx0hWTJSBQijCaRLv3KARwVOx
         YmASp2BqWABIY+pgzxmEdxb7HlyWrHCoMEOU0GICKS9YDYKJsWxX8RGz8A5yUSyrPaJ0
         pd2J2fY7ovu1E3cVJmVTIKgozB/lcoYwPwWGVzG+rTb36b10ooudl+WNRC0KBz2UIsd2
         o1hcVC+sv+pQzF31Mo7Wj/6fwRl2zufOo/ClhcVRr3VgcF5Y4ilwYKvOoXWBHTAkpMC3
         mCJNINCg7FLOnx2hwRGofuAXMVTW1UXGt5y9RwZJYodU8e7ObGLjJLMgHdGqgewnKa1Z
         zCEg==
X-Gm-Message-State: AOAM530EM0QjInnLVVjBdFt6lX7B3X8cqsjxiQNBVNH5N519NwA85RO7
        VkzEufwyjFmSBRJKu1nqYhSId9TwTRY5/XACdmY=
X-Google-Smtp-Source: ABdhPJzmrskYQlMlMnFjGsYyvAOTaHBsXfsHr8nwRU2oDrrkVDPYWxsdJSUQac0GhC2Qs/dT9vQcy19NUstJiIkQmyA=
X-Received: by 2002:a4a:4958:: with SMTP id z85mr6694498ooa.3.1616294757958;
 Sat, 20 Mar 2021 19:45:57 -0700 (PDT)
MIME-Version: 1.0
References: <pull.885.v7.git.1616152884317.gitgitgadget@gmail.com>
 <pull.885.v8.git.1616252178414.gitgitgadget@gmail.com> <xmqqv99lk3c7.fsf@gitster.g>
In-Reply-To: <xmqqv99lk3c7.fsf@gitster.g>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Sun, 21 Mar 2021 10:45:46 +0800
Message-ID: <CAOLTT8S+MWM9h0pMppwd6sH-01hbkhAkKneQD-MxPLHn=jbOLA@mail.gmail.com>
Subject: Re: [PATCH v8] format-patch: allow a non-integral version numbers
To:     Junio C Hamano <gitster@pobox.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Denton Liu <liu.denton@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> =E4=BA=8E2021=E5=B9=B43=E6=9C=8821=E6=97=
=A5=E5=91=A8=E6=97=A5 =E4=B8=8A=E5=8D=883:55=E5=86=99=E9=81=93=EF=BC=9A
>
> "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> As the patch text itself (assuming that the vague "compared with the
> previous iteration" is acceptable) is getting solid, let's nitpick
> the proposed log message so that we can start considering a merge to
> 'next'.

I also think that this patch series has been on the mailing list for a
long time.

>
> I won't review the t/ part of the patch as I know others on CC are
> better at reviewing the tests than I am ;-)
>

Maybe I should look at Eric Sunshine's opinion :)

>
> > From: ZheNing Hu <adlternative@gmail.com>
> >
> > Usually we can only use `format-patch -v<n>` to generate integral
> > version numbers patches,
>
> The "only" sounds as if you are saying that "there is no tool other
> than 'format-patch -v' we can use", which might be technically true,
> but is not what you want to stress to your readers here.  You are
> sayig that usually people only use integral version numbers.
>

You are right, this may be another place where I am not clear.
"only" should be refers to "intergral version", not "format-patch".

> > but sometimes a small fixup should be
> > labeled as a non-integral version like `v1.1`, so teach `format-patch`
> > to allow a non-integral version which may be helpful to send those
> > patches.
>
> Also, I do not think we want to encourage such use of fractional
> iteration numbers.  We can merely enable, without saying it is a
> good idea or a bad idea, leaving judgment to each project that may
> or may not accept a patch versioned in such a way.  So avoid "should
> be".

Yes, it is more appropriate to use words similar to "can be" than "should b=
e".

>
> That makes the first part of the log message to be something like:
>
>     The `-v<n>` option of `format-patch` can give nothing but an
>     integral iteration number to patches in a series.  Some people,
>     however, prefer to mark a new iteration with only a small fixup
>     with a non integral iteration number (e.g. an "oops, that was
>     wrong" fix-up patch for v4 iteration may be labeled as "v4.1").
>
>     Allow `format-patch` to take such a non-integral iteration
>     number.
>
> > `<n>` can be any string, such as '3.1' or '4rev2'. In the case
> > where it is a non-integral value, the "Range-diff" and "Interdiff"
> > headers will not include the previous version.
>
> This part is well written and can stay as-is.
>
> > Signed-off-by: ZheNing Hu <adlternative@gmail.com>
> > ---
> >     [GSOC] format-patch: allow a non-integral version numbers
> >
> >     There is a small question: in the case of --reroll-count=3D<n>, "n"=
 is an
> >     integer, we output "n-1" in the patch instead of "m" specified by
> >     --previous-count=3D<m>,Should we switch the priority of these two: =
let "m"
> >     output?
>
> Didn't I answer this question already?
>

Sorry, forgot to update GGG cover-letter messages.

> > diff --git a/Documentation/git-format-patch.txt b/Documentation/git-for=
mat-patch.txt
> > index 3e49bf221087..e2c29a856451 100644
> > --- a/Documentation/git-format-patch.txt
> > +++ b/Documentation/git-format-patch.txt
> > @@ -221,6 +221,11 @@ populated with placeholder text.
> >       `--subject-prefix` option) has ` v<n>` appended to it.  E.g.
> >       `--reroll-count=3D4` may produce `v4-0001-add-makefile.patch`
> >       file that has "Subject: [PATCH v4 1/20] Add makefile" in it.
> > +      `<n>` may be a non-integer number.  E.g. `--reroll-count=3D4.4`
>
> Is it on purpose that `<n>` here has an extra SP before it?
>
> > +     may produce `v4.4-0001-add-makefile.patch` file that has
> > +     "Subject: [PATCH v4.4 1/20] Add makefile" in it.
> > +     `--reroll-count=3D4rev2` may produce `v4rev2-0001-add-makefile.pa=
tch`
> > +     file that has "Subject: [PATCH v4rev2 1/20] Add makefile" in it.
>
> I am not sure it is worth repeating the whole explanation already
> given to "v4" for two other.  By just mentioning that the "v4" could
> be "v4.4" or "v4vis", the readers are intelligent enough to infer
> what you mean, I would think.  Also be honest to readers by telling
> them what they lose if they use a non-integral reroll count.
>
>         `<n>` does not have to be an integer (e.g. "--reroll-count=3D4.4"=
,
>         or "--reroll-count=3D4rev2" are allowed), but the downside of
>         using such a reroll-count is that the range-diff/interdiff
>         with the previous version does not state exactly which
>         version the new interation is compared against.
>
> or something like that, perhaps?
>

This way of writing is much more concise than what I did before.
I need to exercise my ability to write documents :p

> Thanks.

Thanks, Junio.
