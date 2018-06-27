Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0AA101F516
	for <e@80x24.org>; Wed, 27 Jun 2018 17:02:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934465AbeF0RC1 (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Jun 2018 13:02:27 -0400
Received: from mail-yw0-f196.google.com ([209.85.161.196]:42439 "EHLO
        mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932406AbeF0RC0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Jun 2018 13:02:26 -0400
Received: by mail-yw0-f196.google.com with SMTP id i143-v6so950219ywc.9
        for <git@vger.kernel.org>; Wed, 27 Jun 2018 10:02:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=PjXANvmz7OoERvjKiEza5QkPJugOpJJJSsFTaiAugTQ=;
        b=V5EZzOR5RLyw8qEyfjFqliYujBhO3+M+0Mbuj7jICKLJ3pNvZgYXbwJvrhK6FFFLJC
         dzjG67+CfT6wsuxKxxlyu85tBDl+VXA333WZLQ9OpXp+wGrSnWD+Zwo5XPyspAlx9z9G
         mWgjwYdYZo3esxCXTXbxV8JEkdN9xpD0IVvDw8lTZJLgoBAtHqsXJHMsfOujOMFVltNw
         1r0yDE7QVinUT/7kfpvEB+BTxodUITUf2DgUtV8R6Q9xPKTT0YuVLRrXQ2TT4ah2Kmgz
         PEekhpMl2Kbo7M09Y1bSgQBEo6jMzI6dsebWDK45BO0QUcnSpGuUok0OqGumsvr5kG+6
         Fhuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=PjXANvmz7OoERvjKiEza5QkPJugOpJJJSsFTaiAugTQ=;
        b=GxGq7Qjw6MWCshWzL1RM4VtvT3UJOJvTWfswZqjbcO8GhRlqu8HXh2WlA7xIvPevha
         eTV0OB6WvihnSqyyyPsmTYkFAtKsrcFeu9Kqdn9ujZUdjMZGemXEtIlQPh75vrpQMV8g
         A9e9BojeosSETT/C1O79OyU3OE6dJ/3jiRVuYDGUAxRW/RW5nGhKjfAkEiX3YEHOpJ1c
         3DCQR42e7vGaqeBlmmXeUP9VzXGjKRrAQCbFKycWFX0oY2u4B+vaPA0a+ealqChi//8X
         3D/MzpYwLR0eoBqVJrcoCkXKn4ks0Oe84crRPFQ/wvQ/doAAGLf5x5tLzuL7Oz0SWABU
         rJKg==
X-Gm-Message-State: APt69E16Jf/CVTkcaOTFXcBmUGSDefGy28CKZnLELW4i1YvkPXUl+9nK
        a7IFbQmz9y6fhnUU24c8ZsOiDymD3LXXDozL7Kp/pA==
X-Google-Smtp-Source: AAOMgpcMBlDhyjVT5C+Vm59U7fD1juoZRbsanOG+xszuTO9amgz6ZNswUTCq+mbVO+Kvj89I8yY99aGIqdbaA0XpyCQ=
X-Received: by 2002:a81:e544:: with SMTP id c4-v6mr3194780ywm.345.1530118944991;
 Wed, 27 Jun 2018 10:02:24 -0700 (PDT)
MIME-Version: 1.0
References: <20180620223253.226092-1-sbeller@google.com> <20180622081713.5360-1-szeder.dev@gmail.com>
 <xmqqmuviq2n7.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqmuviq2n7.fsf@gitster-ct.c.googlers.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 27 Jun 2018 10:02:14 -0700
Message-ID: <CAGZ79kamPSvDT+qjjF+KmvXqq2HmVoSDaGGnQ3YbiAUFSm-+1Q@mail.gmail.com>
Subject: Re: [PATCH] submodule.c: report the submodule that an error occurs in
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 25, 2018 at 8:58 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> SZEDER G=C3=A1bor <szeder.dev@gmail.com> writes:
>
> >> When an error occurs in updating the working tree of a submodule in
> >> submodule_move_head, tell the user which submodule the error occurred =
in.
> >>
> >> The call to read-tree contains a super-prefix, such that the read-tree
> >> will correctly report any path related issues, but some error messages
> >> do not contain a path, for example:
> >>
> >>   ~/gerrit$ git checkout --recurse-submodules origin/master
> >>   ~/gerrit$ fatal: failed to unpack tree object 07672f31880ba80300b384=
92df9d0acfcd6ee00a
> >>
> >> Give the hint which submodule has a problem.
> >>
> >> Signed-off-by: Stefan Beller <sbeller@google.com>
> >> ---
> >>  submodule.c               | 2 +-
> >>  t/lib-submodule-update.sh | 3 ++-
> >>  2 files changed, 3 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/submodule.c b/submodule.c
> >> index 939d6870ecd..ebd092a14fd 100644
> >> --- a/submodule.c
> >> +++ b/submodule.c
> >> @@ -1668,7 +1668,7 @@ int submodule_move_head(const char *path,
> >>      argv_array_push(&cp.args, new_head ? new_head : empty_tree_oid_he=
x());
> >>
> >>      if (run_command(&cp)) {
> >> -            ret =3D -1;
> >> +            ret =3D error(_("Submodule '%s' could not be updated."), =
path);
> >
> > This is a translated error message ...
> >
> >>              goto out;
> >>      }
> >>
> >> diff --git a/t/lib-submodule-update.sh b/t/lib-submodule-update.sh
> >> index 1f38a85371a..e27f5d8541d 100755
> >> --- a/t/lib-submodule-update.sh
> >> +++ b/t/lib-submodule-update.sh
> >> @@ -781,7 +781,8 @@ test_submodule_recursing_with_args_common() {
> >>              (
> >>                      cd submodule_update &&
> >>                      git branch -t invalid_sub1 origin/invalid_sub1 &&
> >> -                    test_must_fail $command invalid_sub1 &&
> >> +                    test_must_fail $command invalid_sub1 2>err &&
> >> +                    grep sub1 err &&
> >
> > ... so the test should use 'test_i18ngrep' to check it.
>
> Thanks for being a careful reviewer, as always.
>
> Will tweak locally to skip one round-trip.

Thanks for tweaking locally. I reviewed your queued patch and
it looks good to me. Thanks!

I remember deliberately not using the i18n grep as we grep for
a part that should stay the same in all languages. However I
forgot that details of the test suite implementation (it doesn't
have a real translation, so it doesn't matter that this particular
piece of the message will show up in all translations)

Sorry for my mishap in thinking there.

Thanks,
Stefan
