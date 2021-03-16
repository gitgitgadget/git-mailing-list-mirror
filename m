Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5E31C433DB
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 05:49:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9569F650F0
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 05:49:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233279AbhCPFtA (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Mar 2021 01:49:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235605AbhCPFss (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Mar 2021 01:48:48 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A8DBC06174A
        for <git@vger.kernel.org>; Mon, 15 Mar 2021 22:48:48 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id 101-20020a9d04ee0000b02901b506659320so6278864otm.7
        for <git@vger.kernel.org>; Mon, 15 Mar 2021 22:48:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Sn4JmFI4I0JBukhVjg06aZDgastlqeGeZta2hzhibZs=;
        b=BOD9DgcEoHHKjKYttGXem7DRa+z04g5VPPOCv8BiVeaeeu/EUfManN3ogNLCT5tuop
         Irx2ZxXoXFskB7jQwnHSp/aGCmQ+HX4xC+AcWeE2HCccF14B5K6n+Pq1SxMVHYz1xBgu
         OWBhupZYL0RqkYstxu66qSrJnjRDjb4jp5Tx43Rh+PmwiK9U9cseMU77HzmO1UXjG8vz
         v0hf4y1CO8Nhm1K1IJevO7samIU4NSOHPVveYHq7/i7rR67ry5+aYmTK8l01xluCDaIu
         lVcHNh3bKoXpky/IKRlBteW4AEVciaGCEYgmNJhw14uSRRpFhTaWTGItEPNedAiDwv4j
         qjQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Sn4JmFI4I0JBukhVjg06aZDgastlqeGeZta2hzhibZs=;
        b=pdX75kLn9xuBID/rcpqCbvIcZDvymXqnqg8Aqv8OhL8bpfNbHFjdRtpYtYhEVyy6dK
         dbzAXOwIYSkcx0NjY3HLTmXWDdsZCsCQ1rl+K9f5LoLCnmN6w0EW5RUIIzbqwQQfYRLF
         exO+BGN232YmBEU81IIwFAripNCM8Wvz0AYM/EIF1AmebYitD24pDfS64Xk0dBtj+t2L
         VIkfN3g4lpoiiM7BQIEkBhV7w6pQ250yl0AShVPWrWVz3mxOrbMIDf+cAYyg1DW6tmDD
         7N3lQqX3MgVfgdbIKyQbAk9fYEtaVniHsbssmQ98v7S2fwoxUL26Ae2HIw0F50w58Lux
         h4Bg==
X-Gm-Message-State: AOAM533YsZuL2d0CDIp2OuOWu0Nz7U2EqdEhB2Ou7UazDyVeqYs1twKw
        ZsdeOCbxey9M0UB9PtE4lqsCvopLhZ6IyyihzP8=
X-Google-Smtp-Source: ABdhPJzG1RZSNH+f9LBKbBt3uG4As/vIrParYRV8x4LdIHfjTP3x3lWH5HHb0VAxT0XDO6QiRz/x19nR8NZg46HJ/LQ=
X-Received: by 2002:a05:6830:8f:: with SMTP id a15mr2167944oto.299.1615873727614;
 Mon, 15 Mar 2021 22:48:47 -0700 (PDT)
MIME-Version: 1.0
References: <pull.885.v3.git.1614859926974.gitgitgadget@gmail.com>
 <pull.885.v4.git.1614928211635.gitgitgadget@gmail.com> <CAPig+cSd-e76bOQY8yoZnRDbuQbZ_FNHJ5TV6BC+dAofPmk7DQ@mail.gmail.com>
In-Reply-To: <CAPig+cSd-e76bOQY8yoZnRDbuQbZ_FNHJ5TV6BC+dAofPmk7DQ@mail.gmail.com>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Tue, 16 Mar 2021 13:48:36 +0800
Message-ID: <CAOLTT8T14P1VfbbXnXpAV-6GfZ8jXUqqCVaY1Uxs3UtfnFvKvw@mail.gmail.com>
Subject: Re: [PATCH v4] format-patch: allow a non-integral version numbers
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Denton Liu <liu.denton@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> =E4=BA=8E2021=E5=B9=B43=E6=9C=8816=
=E6=97=A5=E5=91=A8=E4=BA=8C =E4=B8=8A=E5=8D=887:41=E5=86=99=E9=81=93=EF=BC=
=9A
>
> On Fri, Mar 5, 2021 at 2:10 AM ZheNing Hu via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
> > Usually we can only use `format-patch -v<n>` to generate integral
> > version numbers patches, but sometimes a same fixup should be
> > labeled as a non-integral version like `v1.1`, so teach `format-patch`
> > to allow a non-integral version which may be helpful to send those
> > patches.
> >
> > `<n>` can be any string, such as `-v1.1`.  In the case where it
> > is a non-integral value, the "Range-diff" and "Interdiff"
> > headers will not include the previous version.
> >
> > Signed-off-by: ZheNing Hu <adlternative@gmail.com>
> > ---
> > diff --git a/Documentation/git-format-patch.txt b/Documentation/git-for=
mat-patch.txt
> > @@ -221,6 +221,7 @@ populated with placeholder text.
> >         `--reroll-count=3D4` may produce `v4-0001-add-makefile.patch`
> >         file that has "Subject: [PATCH v4 1/20] Add makefile" in it.
> > +       now can support non-integrated version number like `-v1.1`.
>
> Let's drop "now" from the beginning of the sentence since it is only
> meaningful for people who have read this documentation previously, but
> not for people newly learning about the option. Perhaps just say:
>
>     `<n>` may be a fractional number.
>
I agree with you.
> > diff --git a/builtin/log.c b/builtin/log.c
> > @@ -1862,11 +1863,13 @@ int cmd_format_patch(int argc, const char **arg=
v, const char *prefix)
> > -       if (0 < reroll_count) {
> > +       if (reroll_count_string) {
> >                 struct strbuf sprefix =3D STRBUF_INIT;
> > +
> > +               strtol_i(reroll_count_string, 10, &reroll_count);
> > +               strbuf_addf(&sprefix, "%s v%s",
> > +                           rev.subject_prefix, reroll_count_string);
> > +               rev.reroll_count =3D reroll_count_string;
>
> This code can be confusing to readers since it appears to ignore the
> result of strtol_i(), and it's difficult for the reader to understand
> the difference between `reroll_count` and `reroll_count_string` and
> why you need both variables. I was going to suggest that you write an
> /* in-code comment */ here explaining why you don't care if the reroll
> count parsed correctly as a number. However, now that I'm examining
> the code again, I think it would be clearer if you move the strtol_i()
> call into the diff_title() function since -- following your changes --
> that function is the only code which cares whether `reroll_count` can
> be parsed as a number (the rest of the code, after your change, just
> uses it as a string).

Well, The reason `strtol_i` does not check the return value is that
`strtol_i` will
only modify the value of `reroll_count` if the `reroll_count_string`
we provide is
 an integer string, so if `reroll_count_string` is not an integer string, t=
hen
`reroll_count` will remain -1, and then `diff_title` will only execute

        if (reroll_count <=3D 0)
                strbuf_addstr(sb, generic);

So don't need check strtol_i return value. But what you said to put
`strtol_i` in
`diff_title` is indeed a good idea. Of course, we need to modify the declar=
ation
 and parameters of `diff_title`.
