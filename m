Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8F3BC11F64
	for <git@archiver.kernel.org>; Mon, 28 Jun 2021 17:39:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B21F961C65
	for <git@archiver.kernel.org>; Mon, 28 Jun 2021 17:39:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233859AbhF1RmN (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Jun 2021 13:42:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232719AbhF1RmM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Jun 2021 13:42:12 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7615EC061574
        for <git@vger.kernel.org>; Mon, 28 Jun 2021 10:39:45 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id u11so22940870oiv.1
        for <git@vger.kernel.org>; Mon, 28 Jun 2021 10:39:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=qSZEi7G4UqqopNvPFCC5GNRtEFYG3E5lEfhC3UMZTWc=;
        b=M/NGVaR6a+PbFpyB1ke/KbF7E8rDL+zqdz0ixALL726JFODyDokzVILi57Y2SrqmHT
         94U7BS1dI41Pqv8TP+wHqsG3htVjhFecVJdUIV1RPAxQ+ku5kbx5Qx2GdKia2o9+k8SP
         K03b6/j62pw7lQD7DJTVzz0EzaHGccx9YRtaFWTgPN/fYSz+adLINDfewSOtonLYbunU
         eX8xl3mx5P45Qo+6oaf3qUDnJhHXESOEYZLnv9YZonTxNjh5uS9t/luK3S14n/D9ttD2
         uAFLj6NW9CRiwJlNbtyO4K+DyG/UCoD4RcvARe+4Ycx1x0Qqvo/1ppiHWUccn1vPRkby
         x1mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=qSZEi7G4UqqopNvPFCC5GNRtEFYG3E5lEfhC3UMZTWc=;
        b=cX2phvrjinkNpys4Nuf8I9BLQEfpZLbTaBczCA13N/KTwvQQxZ4DPnRlSwKWmuVLAt
         YCS8NjHG99D+ArWzqopZesA8Oj/pM2VErMK4j+8UH9t6BKIjsek2VYoN4IbhLHQ05k4B
         iVyszHyTFZ2HST1aFraoOjIqgWxGNJy8VCqA2lgAnSfCLwMYfJK1hjdqCEZkbQT7GU2s
         w9BtRM0DhBDWTfq42bYp3woweg5K/wuXxlOdUwObH6QMF595dHme7Tia1GMP6IWUzPdr
         0+4zbtT8jluaRwAJFBR/rEFr11CLpMwf+tTMu46IdelFxO+8d1icQkthU/TOs223BgYM
         FcNQ==
X-Gm-Message-State: AOAM530fUQvxgv1sbVuc+aDC2Dcbe6Njp8eiz2Wnc08+FBzk4lx63TI2
        f1kXfYTxLVcTA/QiiqpyK0Q=
X-Google-Smtp-Source: ABdhPJwXyeC0FM1PHKPGNPIDYFxXg9DwrB0nho1wX1Bv0Q/oMOy/AESwqkwOPWHrjFKGvAWYkVAPLg==
X-Received: by 2002:aca:b5c3:: with SMTP id e186mr17831724oif.43.1624901984794;
        Mon, 28 Jun 2021 10:39:44 -0700 (PDT)
Received: from localhost (fixed-187-189-165-231.totalplay.net. [187.189.165.231])
        by smtp.gmail.com with ESMTPSA id q82sm2602105ooq.37.2021.06.28.10.39.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jun 2021 10:39:44 -0700 (PDT)
Date:   Mon, 28 Jun 2021 12:39:38 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Alex Henrie <alexhenrie24@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Message-ID: <60da095a5ce4_1a78f20847@natae.notmuch>
In-Reply-To: <87k0megtlo.fsf@evledraar.gmail.com>
References: <20210627000855.530985-1-alexhenrie24@gmail.com>
 <CABPp-BGko7BP6ZMyRKwKrv0xz7FM9ehe67HSAtzgHF9eV2TD3A@mail.gmail.com>
 <60d7fbb770397_b8dfe2087d@natae.notmuch>
 <CABPp-BGXQ4vbFf6Gx21X-Ms+1VQsZfod1waNJZQxVmB7b-gD7Q@mail.gmail.com>
 <60d8ab7fe0761_ba5a2208b@natae.notmuch>
 <CAMMLpeQaY0z_baVQspJhAX0wanaJwneFoM5rG=xwFUmLEE-QaQ@mail.gmail.com>
 <60d8edbb3803f_70e20886@natae.notmuch>
 <87k0megtlo.fsf@evledraar.gmail.com>
Subject: Re: [PATCH] pull: abort by default if fast-forwarding is impossible
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> =

> On Sun, Jun 27 2021, Felipe Contreras wrote:

> > Personally I prefer to run prove instead, because the output is less
> > verbose, and there's a nice summary at the end:
> >
> >   prove t[0-9][0-9][0-9][0-9]-*.sh
> =

> I also like "prove" better (well, I added the support for it, so
> ...). It's generally better to use e.g.:
> =

>     make test DEFAULT_TEST_TARGET=3Dprove GIT_PROVE_OPTS=3D"--jobs $(np=
roc)"

Or just add "-j$(nproc)" to ~/.proverc so you don't need to specify
GIT_PROVE_OPTS every time.

> Since we do some basic checking via the Makefile that effectively form =
a
> part of our tests.
> =

> FWIW for your one-liner it can be just:
> =

>     prove t[0-9]*.sh
> =

> Alex: You might also find that if you specify --root as the path to a
> ramdisk the tests are much faster, e.g. on my Linux boxes I set
> --root=3D/run/user/`id -u`/git.

Or TEST_OUTPUT_DIRECTORY=3D/tmp/git.

-- =

Felipe Contreras=
