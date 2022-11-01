Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0069CC4332F
	for <git@archiver.kernel.org>; Tue,  1 Nov 2022 19:41:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbiKATl6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Nov 2022 15:41:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbiKATl4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Nov 2022 15:41:56 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B76A3186D6
        for <git@vger.kernel.org>; Tue,  1 Nov 2022 12:41:55 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id p21so10663330plr.7
        for <git@vger.kernel.org>; Tue, 01 Nov 2022 12:41:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=smEg0+9NV2DKLBoGWb8FFa439VLVJRkKUGL9F9N9j9U=;
        b=beK+Zqbcv2ilEVMkggcpffCr6V8ze+uWs3OWuhGrgTDJQn7xm5wvM+j0+1MRQojgk1
         wXBQ9+lWYyKUON4tcMkLc780kti8QBybZpCQEsX7mYsJTSFPAu6SbXk053Tlx59mwluh
         d2RwukXcilWcCggZn4K1BOQgFwTDFRC5TPflboKApXp3K4v4uDJ/DGJweS5rKMWX5fXx
         Zthr2QYPEMBtSyKSn1ptLbQtI3Q5xPaRMGF6DFKVm7CNUb1iBMPVBSvvutUsPSLz4d7C
         MrOvLWJUx8lvdz9mBtN67XmDCKMInkyRrrTvSOkjJ3TjLpUnupd6vTECCWgeae356ojO
         OVSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=smEg0+9NV2DKLBoGWb8FFa439VLVJRkKUGL9F9N9j9U=;
        b=q1gjBrr3xnYBzDD8HpOvzQ+OgYWdtIEE3jQH0SqdJl1ymnHIfVhWvxqnqoQP0WRrEN
         6DS7FbCXwXY2ln185FI3hLI3Hwg644UgNLEIbB+2jJ3aDtd8QbpTDGvTGzodoqXfspQm
         c+zn7XiOA/ObLDEQKbn0+H1hBhlRPKDD41f+sHGs8DyUx0I5cz6p22MzddPy1aDnXrJW
         9QH8JaLZXiBZkVqNXl8Tw4QN8njurNmq2d1sQB9Ivga65Tdb7kSa4vnUP1EBdqWxLes0
         kn7p2OIACTuTcvD4AJvVAQCnFjC6jEA/o4D/5bjNTDCjuBxH2ihYxA8DpDB5kn0Kxry4
         II0A==
X-Gm-Message-State: ACrzQf1KRA6J9+GXCSxDWr6YN3hNE5CjY0/fNQcg9epcVwW/M9w6XiS9
        Amxqo9zSVyRaueqU7h/9G8rX0mIN7/mMu0H5Zno=
X-Google-Smtp-Source: AMsMyM6wbmUvnZaTZHcDQmbhCiPijJu0Owrs5fL2QVMAG/2rpmwV2etzJ4Aa2Bfd31SaIhESPBLia3tSXoisH6xeHrw=
X-Received: by 2002:a17:902:f791:b0:17c:c1dd:a3b5 with SMTP id
 q17-20020a170902f79100b0017cc1dda3b5mr20938560pln.141.1667331715240; Tue, 01
 Nov 2022 12:41:55 -0700 (PDT)
MIME-Version: 1.0
References: <f1a5f758-d81f-5985-9b5d-2f0dbfaac071@opensuse.org> <CAN0heSryxTbJXrRs7-aCNb6u9qXJnYjX7++Ji8jd=YeYTJfoaA@mail.gmail.com>
In-Reply-To: <CAN0heSryxTbJXrRs7-aCNb6u9qXJnYjX7++Ji8jd=YeYTJfoaA@mail.gmail.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Tue, 1 Nov 2022 20:41:43 +0100
Message-ID: <CAN0heSoc+jKxseyyR-=8+ATc8rdY5UyFWZPepaQsGn9m+Hpfmg@mail.gmail.com>
Subject: Re: git can not be built for s390x since update to git-2.38.0
To:     Sarah Julia Kriesch <sarah.kriesch@opensuse.org>
Cc:     git@vger.kernel.org, andreas.stieger@gmx.de,
        Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 1 Nov 2022 at 20:05, Martin =C3=85gren <martin.agren@gmail.com> wro=
te:
>
> Hi Sarah,
>
> On Tue, 1 Nov 2022 at 19:38, Sarah Julia Kriesch
> <sarah.kriesch@opensuse.org> wrote:
> >
> > I am one of the zsystems Maintainers (s390x architecture) at openSUSE
> > and git can not be built any more since the update from 2.37.3 to
> > 2.38.0, and with 2.38.1 afterwards. We have tried to debug it.
> >
> > There is no real test error output, but we can identify, that it is
> > happening in the test part with check-chainlint.
>
> > [  387s] make[1]: *** [Makefile:83: check-chainlint] Error 1
> > [  387s] make[1]: Leaving directory
> > '/home/abuild/rpmbuild/BUILD/git-2.38.1/t'
> > [  387s] make[1]: *** Waiting for unfinished jobs....
> > [  388s] make: *** [Makefile:3075: test] Error 2
> > [  388s] error: Bad exit status from /var/tmp/rpm-tmp.ztqAAp (%check)
>
> > How can we fix this issue?
>
> You can disable this feature by setting the GIT_TEST_CHAIN_LINT
> environment variable to "0". That should hopefully allow you to run the
> tests successfully.
>
> That shouldn't risk you anything, like reduce test coverage or similar.
> That the tests are chainlint-ok (roughly speaking, that they are written
> the way the Git project likes its tests) has already been established by
> many others at this point.

On further reading, it appears this error happens in the
"check-chainlint" target without even checking this environment variable
(that happens elsewhere). I doubt my original suggestion will be a
complete workaround.

One approach might be to patch the "check-chainlint" target into a
no-op, possibly combined with turning off the chainlinting as I
mentioned above. My makefile-foo is unfortunately not sufficiently
advanced to immediately spot what might be going on here.

At any rate, all of the above is just about working around the issue. As
for a proper fix, let's hope someone like Eric can chime in.

Martin
