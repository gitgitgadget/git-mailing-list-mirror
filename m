Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 496B1C433DB
	for <git@archiver.kernel.org>; Sat, 27 Feb 2021 07:01:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1229D64EC4
	for <git@archiver.kernel.org>; Sat, 27 Feb 2021 07:01:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229849AbhB0HA5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 27 Feb 2021 02:00:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbhB0HAz (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Feb 2021 02:00:55 -0500
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE2E1C06174A
        for <git@vger.kernel.org>; Fri, 26 Feb 2021 23:00:15 -0800 (PST)
Received: by mail-oi1-x22a.google.com with SMTP id l64so12272481oig.9
        for <git@vger.kernel.org>; Fri, 26 Feb 2021 23:00:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=SHxqq7cB1dee+A9a8T7ikzKd69sr7lN8GbSve6SSPi4=;
        b=gn742cg7wchMwDgrEPsb0CF+tfEoZmaTmL8c1cZSeTIUuQsJLAU5AAQWBIRf+U4n2n
         0pcALM/U1XGRji5evRn6ca/+qK2nFaMll0YCKlmdBYS1ZOS59Texi7cW3W3h+cBoPJVO
         zKfV1BRMkhj4MoVdbfxqf1Ktt7kYa1ZnPOV5RhOlhfgOkTDLqlNcg1XOYWHk997hcpJr
         1GqCHJ0+6ZSYD37PBOHeV56AyX13EJ8mPlY/vztt111TruN7xmWOdA5ZdwS3fIyEmJdk
         vWZtWC8BdZSNIUucqWF/4cIeo89aFEoC4V7D+T8dLEr2PB2pdGp2K3VF1GnvBYPyOzjv
         mNqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=SHxqq7cB1dee+A9a8T7ikzKd69sr7lN8GbSve6SSPi4=;
        b=MJpNhl3MT/ICN8WSVNh98XTygPfS1Kl73bBLgmRAwKMZ/deXrWX4W7rPn+ktTp3TDl
         Ma1fzpUduzS0+z1tJDS71kQzonuRY0WUfmLVJurinaWKXMpUbJuHn0LO5ck0bRef+5UD
         o1c3a9T6Z4wQ7FjgliX4Bse11G4JJEGBURwymIu6BAzdX4YC07o4uy/c5N3CkTodwwYD
         lgi7jCv6FOr7N29VNSRM8XPSC2vA2G80Bt80Tfn3Nfc8GTUIBpb3VKdwQKySY3mMVgk6
         E6l2G+IvXFlxL55/YU71vI4Xm8DHxy1IUk1NG7IsesdFz/n3EyLJx7P+oCGsSCX07yBs
         zV7Q==
X-Gm-Message-State: AOAM533BmAgREvqA7OqKJtuMeRO8m+TJyjDaAT/pNDKBmnk/LBDYXTsf
        9twiJcK/8XozYSc0WpMFzyMiXFU37MAQm2RtPwM=
X-Google-Smtp-Source: ABdhPJwnAZ8puBFVTEaqdhaTpqn66AuNLVOJcN0dmPA+B5FZ5xJ9NJkCAmsKXqCdVaiTjBfQbLdt7PnVE8mByC87dQw=
X-Received: by 2002:aca:4c5:: with SMTP id 188mr4770390oie.44.1614409214556;
 Fri, 26 Feb 2021 23:00:14 -0800 (PST)
MIME-Version: 1.0
References: <pull.885.git.1614269753194.gitgitgadget@gmail.com> <CAPig+cQcyJJnuOq9wtJjgEi7OgO39wBf+hHkVxaQ4z-RehvgNA@mail.gmail.com>
In-Reply-To: <CAPig+cQcyJJnuOq9wtJjgEi7OgO39wBf+hHkVxaQ4z-RehvgNA@mail.gmail.com>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Sat, 27 Feb 2021 15:00:02 +0800
Message-ID: <CAOLTT8SLbpDV6_hnLqeimMrhLrNKmAS2rTbVwdjhDLuW_jCW_w@mail.gmail.com>
Subject: Re: [PATCH] format-patch: allow a non-integral version numbers
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

Eric Sunshine <sunshine@sunshineco.com> =E4=BA=8E2021=E5=B9=B42=E6=9C=8826=
=E6=97=A5=E5=91=A8=E4=BA=94 =E4=B8=8A=E5=8D=881:57=E5=86=99=E9=81=93=EF=BC=
=9A
>
> On Thu, Feb 25, 2021 at 11:19 AM ZheNing Hu via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
> > Usually we can only use `format-patch -v<n>` to generate integral
> > version numbers patches, but if we can provide `format-patch` with
> > non-integer versions numbers of patches, this may help us to send patch=
es
> > such as "v1.1" versions sometimes.
>
> On the Git project itself, fractional or non-numeric re-roll "numbers"
> are not necessarily encouraged[1], so this feature may not be
> particularly useful here, though perhaps some other project might
> benefit from it(?). Usually, you would want to justify why the change
> is desirable. Denton did give a bit of justification in his
> proposal[2] for this feature, so perhaps update this commit message by
> copying some of what he wrote as justification.
>
OK, I will remember it.
> [1]: I think I've only seen Denton send fractional re-rolls; other
> people sometimes send a periodic "fixup!" patch, but both approaches
> place extra burden on the project maintainer than merely re-rolling
> the entire series with a new integer re-roll count.
>
> [2]: https://github.com/gitgitgadget/git/issues/882
>
> > Signed-off-by: ZheNing Hu <adlternative@gmail.com>
> > ---
> > diff --git a/Documentation/git-format-patch.txt b/Documentation/git-for=
mat-patch.txt
> > @@ -215,12 +215,12 @@ populated with placeholder text.
> >  -v <n>::
> >  --reroll-count=3D<n>::
> > -       Mark the series as the <n>-th iteration of the topic. The
> > +       Mark the series as the specified version of the topic. The
> >         output filenames have `v<n>` prepended to them, and the
> >         subject prefix ("PATCH" by default, but configurable via the
> >         `--subject-prefix` option) has ` v<n>` appended to it.  E.g.
> > -       `--reroll-count=3D4` may produce `v4-0001-add-makefile.patch`
> > -       file that has "Subject: [PATCH v4 1/20] Add makefile" in it.
> > +       `--reroll-count 4.4` may produce `v4.4-0001-add-makefile.patch`
> > +       file that has "Subject: [PATCH v4.4 1/20] Add makefile" in it.
>
> I'm not sure we want to encourage the use of fractional re-roll counts
> by using it in an example like this. It would probably be better to
> leave the example as-is. If you really want people to know that
> fractional re-roll counts are supported, perhaps add separate sentence
> saying that they are.
Yes, but the original description `<n>-th iteration` may imply that the ver=
sion
number is an integer. Is there any good way to solve it?
>
> > diff --git a/builtin/log.c b/builtin/log.c
> > @@ -1662,13 +1662,13 @@ static void print_bases(struct base_tree_info *=
bases, FILE *file)
> > -static const char *diff_title(struct strbuf *sb, int reroll_count,
> > +static const char *diff_title(struct strbuf *sb, const char *reroll_co=
unt,
> >                        const char *generic, const char *rerolled)
> >  {
> > -       if (reroll_count <=3D 0)
> > +       if (!reroll_count)
> >                 strbuf_addstr(sb, generic);
> >         else /* RFC may be v0, so allow -v1 to diff against v0 */
> > -               strbuf_addf(sb, rerolled, reroll_count - 1);
> > +               strbuf_addf(sb, rerolled, "last version");
> >         return sb->buf;
> >  }
>
> There are a couple problems here (at least). First, the string "last
> version" should be localizable, `_("last version")`. Second, in
> Denton's proposal[2], he suggested using the string "last version"
> _only_ if the re-roll count is not an integer. What you have here
> applies "last version" unconditionally when -v is used so that the
> outcome is _always_ "Range-diff since last version". If that's what
> you intend to do, there's no reason to do any sort of interpolation
> using the template "Range-diff since %". What Denton had in mind was
> this (using pseudo-code):
>
>     if re-roll count not specified:
>         message =3D "Range-diff"
>     else if re-roll count is integer:
>         message =3D "Range-diff since v%d", re-roll
>     else:
>         message =3D "Range-diff since v%s", re-roll
>
> However, there isn't a good reason to favor "Range-diff since last
> version" over the simpler generic message "Range-diff". So, the above
> should be collapsed to:interpolation
>
>     if re-roll count is specified and integer:
>         message =3D "Range-diff since v%d", re-roll
>     else:
>         message =3D "Range-diff"
>
You mean using "Range-diff since %" may not be as
 good as" Range-diff" without sorting. I agree with you.
> > @@ -2080,7 +2080,7 @@ int cmd_format_patch(int argc, const char **argv,=
 const char *prefix)
> > -                                            _("Interdiff against v%d:"=
));
> > +                                            _("Interdiff against %s:")=
);
> > @@ -2099,7 +2099,7 @@ int cmd_format_patch(int argc, const char **argv,=
 const char *prefix)
> > -                                            _("Range-diff against v%d:=
"));
> > +                                            _("Range-diff against %s:"=
));
>
> If you follow my recommendation above using the simplified
> conditional, then you don't need to drop the "v" since you won't be
> saying "last version".

Your suggestion is very good and easy to implement, but I may have
made some changes in Junio suggestion later, that is, I used the
 `previous_count` method to provide it to `diff_title()`. I will explain
my thoughts and problems in my reply to Junio. You'll see it later.
Thank you for your help.

--
ZheNing Hu
