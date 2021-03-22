Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44B4EC433C1
	for <git@archiver.kernel.org>; Mon, 22 Mar 2021 21:14:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F0AB461934
	for <git@archiver.kernel.org>; Mon, 22 Mar 2021 21:14:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231411AbhCVVNw (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Mar 2021 17:13:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230264AbhCVVNR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Mar 2021 17:13:17 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06A24C061574
        for <git@vger.kernel.org>; Mon, 22 Mar 2021 14:13:17 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id x126so12009527pfc.13
        for <git@vger.kernel.org>; Mon, 22 Mar 2021 14:13:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=h88/hav2nx/qsl+BSBrF71MeDMvvkn+SjsYOnwlASnY=;
        b=MjXDsEPlKdcUD/HT71Pz+YWj0l1W/L5fgxG6iS96djKHrj4MYxiMarDsEOv/+Hq8hN
         mMVlEOypHv+9V2bgC4Xt7ssiuZsBv6MPRa1aHJciGCNkPdPDpwn2+90ypJHOUwqngW1Z
         g7kSLN+K/VnJDmo9KOQLUFz4xGFAR+IV7hLfM9KFkjN7hIEu7nMJgK/4h3l5Bo0dQ0TD
         zz4qYPkOTuw8Q3dIEshZbhWslGl3fmXrhB8N+RUidl2TpGrDc9zrbyNuH7kw3acxG72F
         Q4bPKm7CoO3nXByt+mxGqNzI2IkOMCf/wlO+u52Ooquisb1spceNgoncoR1e45Nr0Vq8
         mJ9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=h88/hav2nx/qsl+BSBrF71MeDMvvkn+SjsYOnwlASnY=;
        b=WomPGyc+iztaWFvmStcY5B6UNBP45dJCRaY2pvOOJ2HqrqBBXfchRasx9bDrbztpt+
         /Q9uut2eKTXt/RiKRtQlwVi/cKGWMfnmtS57TOzXpH8HK/W0j6StiYFoDXfKLetZ3VKG
         EWB4oWSZL8T3PTs4ZxwRvGgsrv7cCNeOcsXOzWza3nopUXicFvg3i1eMiZMI8CfdtKQe
         U8p3i3dCvBO4PvAuhsRH/A6xvKLgE5RsCLdanGOTQ9fL47Rtd2JyElnhDzPPAofQuPuS
         3CMy5Oz3IVyrmcF7B0EOtscJWUOGkg8AXzJCZL1G+GJsK2NIqI1N9rTHS1nspLWSD2gX
         0tOw==
X-Gm-Message-State: AOAM531I1vPH3NIOBcQYN9cOl9EdS/kNfgzBJv8beYvrPuCR51jUOFIP
        IjgrKvYaPVZ+jqmUkunKW2Iabm8P7CaaRvv8P+W39eknsxxuYHPt/g8=
X-Google-Smtp-Source: ABdhPJzGiRLNWIbFzu//B59W7SCFxOX4ATat5kNIXIBPpmrWKJzpK158yjkhN1RfQ4tyOr7T4tSn7BlRzE09QYeWEtA=
X-Received: by 2002:a17:902:e752:b029:e6:822c:355c with SMTP id
 p18-20020a170902e752b02900e6822c355cmr1547937plf.69.1616447596560; Mon, 22
 Mar 2021 14:13:16 -0700 (PDT)
MIME-Version: 1.0
References: <20210322162008.468779-1-robert.foss@linaro.org> <875z1jqgpq.fsf@evledraar.gmail.com>
In-Reply-To: <875z1jqgpq.fsf@evledraar.gmail.com>
From:   Robert Foss <robert.foss@linaro.org>
Date:   Mon, 22 Mar 2021 22:13:05 +0100
Message-ID: <CAG3jFysGE-Wq2ReXmNa2VGPOWMW_MDn++Xv_WvAYW9EiQjAbdA@mail.gmail.com>
Subject: Re: [PATCH v1] git-send-email: Respect core.hooksPath setting
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Drew DeVault <sir@cmpwn.com>,
        Rafael Aquini <aquini@redhat.com>,
        =?UTF-8?Q?Marcelo_Arenas_Bel=C3=B3n?= <carenas@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hey =C3=86var,

Thank you for the quick feedback.

On Mon, 22 Mar 2021 at 17:46, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avara=
b@gmail.com> wrote:
>
>
> On Mon, Mar 22 2021, Robert Foss wrote:
>
> > get-send-email currently makes the assumption that the
> > 'sendemail-validate' hook exists inside of the repository.
> >
> > Since the introduction of `core.hooksPath` configuration option in
> > v2.9, this is no longer true.
> >
> > Instead of assuming a hardcoded repo relative path, query
> > git for the actual path of the hooks directory.
> >
> > Signed-off-by: Robert Foss <robert.foss@linaro.org>
> > ---
> >
> >
> > This patch does not include a test for this bug fix.
> > This is entirely due to me not being able to think up a way
> > to test this. So I'm very much open to suggestions.
>
> There's an "invoke hook" test in t9001-send-email.sh which should be
> easy to tweak (or mostly copy/pasted to another test) to run the same
> way once the hook is moved from .git/hooks to somedir/ and -c
> core.hooksPath=3Dsomedir is set.

Ack


>
> >  git-send-email.perl | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> >
> > diff --git a/git-send-email.perl b/git-send-email.perl
> > index 1f425c0809..3934dceb70 100755
> > --- a/git-send-email.perl
> > +++ b/git-send-email.perl
> > @@ -1942,8 +1942,9 @@ sub validate_patch {
> >       my ($fn, $xfer_encoding) =3D @_;
> >
> >       if ($repo) {
> > -             my $validate_hook =3D catfile(catdir($repo->repo_path(), =
'hooks'),
> > -                                         'sendemail-validate');
> > +             my $hook_path =3D $repo->command('rev-parse', '--git-path=
', 'hooks');
> > +             chomp($hook_path);
> > +             my $validate_hook =3D catfile($hook_path, 'sendemail-vali=
date');
>
> This looks like it work, small nits:
>
> 1. This would be better in perl/Git.pm, it already has various accessors
>    etc. for these rev-parse'd values. You could just pass a a new
>    GetHooksPath =3D> 1 to Git->repository() and if so populate this, then
>    call that as $repo->git_path_hooks.

I reworked this, but being a level 1 perl coder I don't quite grok the
"GetHooksPath =3D> 1 to Git->repository()" part of your suggestion.

https://github.com/robertfoss/git/commit/9388d1f66b8d182f0dcc869f627736596a=
f382da

This is what I came up with.

>
> 2. FWIW it's more idiomatic in perl to just do : chomp(my $x =3D y()); no=
t
>    my $x =3D y(); chomp $x. The chomp operator works in-place, but once
>    you'd use the helpers in Git.pm for this they'd do all that for you.
>
> >               my $hook_error;
> >               if (-x $validate_hook) {
> >                       my $target =3D abs_path($fn);
>

Ack
