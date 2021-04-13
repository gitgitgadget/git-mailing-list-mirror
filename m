Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBE02C433B4
	for <git@archiver.kernel.org>; Tue, 13 Apr 2021 19:55:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C2546613C7
	for <git@archiver.kernel.org>; Tue, 13 Apr 2021 19:55:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346334AbhDMTz4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Apr 2021 15:55:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231802AbhDMTz4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Apr 2021 15:55:56 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2C83C061574
        for <git@vger.kernel.org>; Tue, 13 Apr 2021 12:55:35 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id r128so2234580lff.4
        for <git@vger.kernel.org>; Tue, 13 Apr 2021 12:55:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=30dkLbmQNbgr0IchjJhc9nz5sJ9Kdx0inMo/p4DGR2E=;
        b=GTqbbezyuEbsMrWXON3uRuPgcPw2dCTKlYGZUgOX+tLPIe96B9p7KVfmqvYWhZSP/2
         E1FIXfi4Cs6/oVRYmVArMepuabM93vSkxHWYZ8X1rP6lVEM8Yp1J7OTslt+welKx/Qam
         glSyxIJWy1sU7BMmOPe7csHV//kGwyt4wdsGNdjipO9Of0rDptzG+rnBiUhtK+d4ctQK
         Txq2fVN3dVB5KLM+8K0lIMD9f7seYk/5YFdmY/uAG2uxDud4wtsM/jJHfNc8PiakFTgK
         epCdQq66OJHOikxZeFqiJTrj3Glw8dTdlI4k37RnlssAL7E77XzUE4Cwbh4jHsHtnpts
         F0fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=30dkLbmQNbgr0IchjJhc9nz5sJ9Kdx0inMo/p4DGR2E=;
        b=qPIj5MOnoswWMwtLRuQxmML/XYmlpB7NbxNQwyg8HC7vALBLwaXghVgX8ImorKIKGZ
         5l0H+WTRtKQHl9yzcgy6ZgHlRmxDEUoJSue1LsMKF4F/sF5B+Q/ahKfVIliTvJGHDj78
         S9EWZDLw4QS74qPIVR+120XNKdVjMhJYQWjNBHnYuXgTfxkiM7rHorL2s58z3dZhz1m3
         gt+A5Xi0CRz8iAbo5PG2rLo4VhNVC2DvjnOEPOg9h9o4C83OcAtuhmxcLEr5fCLA78yJ
         EGaBjvGXPe4yyOVbeSP6tsaYjotFrR0NOXVpMRHkNOd/P4Xa/46lmSVJORgpSOcoW9+s
         jPBw==
X-Gm-Message-State: AOAM533UuRuOqhlQIQJBsPJgeBCHzaM5huAsAyNQJ055LjYWJFCobJo6
        qpyBO7bpFZr4q9AEwBe38qyd6kz81hwPYfi3pQJMow==
X-Google-Smtp-Source: ABdhPJwUGbTuRz3+9JqFJNtG0o27LZcZN++DJmuKPcockoocwJtNgYkIj4QZH9345dJaKITDHNUk7lilGIiEHB7+MTs=
X-Received: by 2002:ac2:5d66:: with SMTP id h6mr24240861lft.359.1618343734204;
 Tue, 13 Apr 2021 12:55:34 -0700 (PDT)
MIME-Version: 1.0
References: <patch-1.1-f0542cd902c-20210413T121930Z-avarab@gmail.com>
 <cover-0.2-00000000000-20210413T122645Z-avarab@gmail.com> <patch-2.2-c2cb52b6605-20210413T122645Z-avarab@gmail.com>
 <CAHd-oW4G+7z3UM3qjhPp=2oqOPE4a49fweew0n+gheGtQEy5VA@mail.gmail.com> <87fszu2elw.fsf@evledraar.gmail.com>
In-Reply-To: <87fszu2elw.fsf@evledraar.gmail.com>
From:   Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Date:   Tue, 13 Apr 2021 16:55:23 -0300
Message-ID: <CAHd-oW6D7Tmp2TmrmGvXDt-NnT_wxhfr_bn_P_7=ot=m_2eyyA@mail.gmail.com>
Subject: Re: [PATCH 2/2] diff tests: rewrite flakyness-causing test "aid"
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 13, 2021 at 4:01 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
>
> On Tue, Apr 13 2021, Matheus Tavares Bernardino wrote:
>
> > On Tue, Apr 13, 2021 at 9:31 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
> > <avarab@gmail.com> wrote:
> >>  t/t4013-diff-various.sh | 25 +++++++++++++++----------
> >>  1 file changed, 15 insertions(+), 10 deletions(-)
> >>
> >> diff --git a/t/t4013-diff-various.sh b/t/t4013-diff-various.sh
> >> index 67f6411aff9..228ff100c61 100755
> >> --- a/t/t4013-diff-various.sh
> >> +++ b/t/t4013-diff-various.sh
> >> @@ -200,10 +200,12 @@ do
> >>         esac
> >>         test=3D$(echo "$label" | sed -e 's|[/ ][/ ]*|_|g')
> >>         pfx=3D$(printf "%04d" $test_count)
> >> -       expect=3D"$TEST_DIRECTORY/t4013/diff.$test"
> >> +       expect_relative=3D"t4013/diff.$test"
> >> +       expect=3D"$TEST_DIRECTORY/$expect_relative"
> >>         actual=3D"$pfx-diff.$test"
> >>
> >>         test_expect_$status "git $cmd # magic is ${magic:-(not used)}"=
 '
> >> +               test_when_finished "rm $actual" &&
> >
> > Nit: before these two patches, "$actual" was only removed when the
> > test succeeded. So, in case of failure, the failed output files would
> > still be there for debugging. It might be interesting to keep this
> > behavior and only remove "$actual" at the end of the test.
>
> Either I'm missing something or you are, that's how test_when_finished
> works.
>
> It's skipped under e.g. "--immediate --debug". See b586744a864 (test:
> skip clean-up when running under --immediate mode, 2011-06-27)

I was mostly thinking about the `artifacts` zip we get from our CI
when a test fails. I find the final trash dir quite useful for some
post-mortem analysis, especially to debug WIP tests that only fail
occasionally or test failures on OSes I don't have quick access to.
