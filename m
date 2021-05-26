Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F583C47087
	for <git@archiver.kernel.org>; Wed, 26 May 2021 00:24:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 22DD36109F
	for <git@archiver.kernel.org>; Wed, 26 May 2021 00:24:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232294AbhEZA0Y (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 May 2021 20:26:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230366AbhEZA0Y (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 May 2021 20:26:24 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EC3BC061574
        for <git@vger.kernel.org>; Tue, 25 May 2021 17:24:54 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id h24-20020a9d64180000b029036edcf8f9a6so6069942otl.3
        for <git@vger.kernel.org>; Tue, 25 May 2021 17:24:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=8Uqjt6jo3Jz5swJNELa5Kubu3HQ6Uk392keaixENYSM=;
        b=u/HBKHSGWvU0xGu1Fc/ZhfSxMEkpper1NDTgy8tIPGzxnQyHUUquxyw6n87J2zTp6+
         g6AorjdSRNkxrD3PHsyDhwRajNb3oE+/CotLojDp1GSWQ9jeJBvK8Ezk4qfeRl6edBBp
         MlQyZ9pL2EwtpNOQnLwlndvnTZZv2wnHakKCbJUzWyF+kZgbWKPXs7Lxq3IErPdmoWhL
         jMWuPZ23zi8UY3ejzU/Zvw2NcxYFRONzQBH+21BtRFuMFiLImq6tt/ch+9rilJCbnepI
         WKow+sH6igYdfKtwumwm8ETW+6ehJRkFu6XmT0lTh6rmoNvORYfJmUBMJT8D7XC5ik1/
         2gDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=8Uqjt6jo3Jz5swJNELa5Kubu3HQ6Uk392keaixENYSM=;
        b=P0Pw/PcoddNX1PxNUMuctNhNtRYniRyTvnuaDptKl9bIH2x3xIJnTD3Stv61OWLRiU
         5ubsMBxaVPZz0nXOeMqwn6Yy0tv9jFMadIOPgC5w79ksYZyOT08RCe4FOF9PUHHRl0qQ
         ox8babouRdL5OGUIsNpmr0o04wj+g/jcAm9mTPRySMyAllxWUapgDeiYjnof6O0fiNzF
         bu11sblmm31HelIHM6xNKRd24/2XoOHD00GSMfFnSwD6LphmVBDTP5fCK0uvop5Kstpq
         sj3ePlQlC8RJ2e2N6FulRTOlrTHkHKXxWrRhPtQfr7f+xgXcjs5j5gWLQdFHgG+bAVfO
         hSGQ==
X-Gm-Message-State: AOAM533J6wmHMl7IPoiX7M+CcNjrap3d0ovmrEmjWXWFf22ANNcAW8RT
        yRyZKNafJtCBegc4jjFIALM=
X-Google-Smtp-Source: ABdhPJxHuYWcxWC8ci0b8yLXckAC0B5Rz4e2hz7iNjWqz/qG8aUt62+qd2avvC6aqiGsHvocy9hkIg==
X-Received: by 2002:a05:6830:1d81:: with SMTP id y1mr259980oti.24.1621988693326;
        Tue, 25 May 2021 17:24:53 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id q26sm4027589otn.0.2021.05.25.17.24.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 May 2021 17:24:52 -0700 (PDT)
Date:   Tue, 25 May 2021 19:24:50 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        =?UTF-8?B?TWFydGluIMOFZ3Jlbg==?= <martin.agren@gmail.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Message-ID: <60ad9552dd14c_2c31c2088a@natae.notmuch>
In-Reply-To: <60ad769938b70_294de208fc@natae.notmuch>
References: <20210521222941.525901-1-felipe.contreras@gmail.com>
 <20210521222941.525901-4-felipe.contreras@gmail.com>
 <xmqqcztgj9za.fsf@gitster.g>
 <60abf32038579_1b209208d2@natae.notmuch>
 <xmqqwnrnh626.fsf@gitster.g>
 <60ac9f332eeec_225d820832@natae.notmuch>
 <xmqqim36eo12.fsf@gitster.g>
 <60ad769938b70_294de208fc@natae.notmuch>
Subject: Re: [PATCH v3 3/5] doc: remove unnecessary rm instances
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Felipe Contreras wrote:
> Junio C Hamano wrote:
> > Felipe Contreras <felipe.contreras@gmail.com> writes:
> > =

> > > Junio C Hamano wrote:
> > >> Felipe Contreras <felipe.contreras@gmail.com> writes:
> > >> >  * helped-by: 17% (1336)
> > >> =

> > >> I actually think people use this one to say "person X gave a
> > >> valuable input in the review discussion", which is exactly the cas=
e
> > >> here, and that was why I wondered you needed to invent a completel=
y
> > >> new one.
> > >
> > > I think the opposite: "helped-by" encompasses virtually anything...=

> > =

> > But your own stats disagrees with your opinion, so don't invent a
> > new thing, period.
> =

> Stats don't have opinions.

Plus, here are some instances of commit trailer lines used only *once*
by big names of git.git (they are the authors).

2014-02-18: brought-to-attention-by: Junio C Hamano
2012-03-16: discussion-triggered-by: Junio C Hamano
2011-04-26: heavylifting-by: Junio C Hamano
2010-06-23: initial-fix-by: Junio C Hamano
2008-10-23: tested-on-freebsd-by: Junio C Hamano
2008-10-23: tested-on-aix-by: Junio C Hamano
2008-08-19: tested-on-mingw-by: Junio C Hamano
2008-03-23: reference: Junio C Hamano

2020-12-11: initial-patch-by: Johannes Schindelin
2020-11-19: pointed-out-by: Johannes Schindelin
2020-08-12: simplified-testcase-and-bisection-by: Elijah Newren
2020-04-27: documentation-by: Elijah Newren
2019-10-10: inspired-by-a-patch-by: Johannes Schindelin
2018-07-16: explanation-by: Stefan Beller
2018-01-04: also-reported-by: Johannes Schindelin
2017-09-23: reported-at: Jeff King
2017-01-06: test-provided-by: Stefan Beller
2016-10-07: issue-found-by: Jakub Nar=C4=99bski
2016-09-04: benchmarked-by: Christian Couder
2016-05-11: initial-test-by: Johannes Schindelin
2016-05-03: fix-proposed-by: Stefan Beller
2016-01-13: assisted-by: Johannes Schindelin
2016-01-12: derived-from-code-by: Johannes Schindelin
2015-09-24: history-dug-by: Jeff King
2015-09-09: reported-and-suggested-by: Johannes Schindelin
2015-06-30: clever-idea-by: Jeff King
2015-05-20: test-adapted-from: Jeff King
2015-03-03: edited-by: Stefan Beller
2014-12-12: tweaked-by: Michael Haggerty
2014-12-08: analyzed-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy
2014-11-02: adapted-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy
2014-06-08: reminded-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy
2013-12-28: clarified-by: Jeff King
2013-08-21: revised-by: Shawn O. Pearce
2013-08-16: reported-and-analyzed-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8D=
c Duy
2013-07-09: more-spots-found-by: Jeff King
2013-02-23: brown-paper-bag-fixes-by: Jeff King
2012-10-12: initial-work-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy
2012-07-22: reported-tested-and-explained-by: Jonathan Nieder
2011-09-22: tracked-down-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy
2011-09-16: originally-by: Jakub Nar=C4=99bski
2011-04-28: inspired-by-patch-by: Jakub Nar=C4=99bski
2011-04-28: inspired-by-code-by: Jakub Nar=C4=99bski
2011-04-28: based-on-code-by: Jakub Nar=C4=99bski
2011-01-06: works-around: Jonathan Nieder
2011-01-02: helpd-by: Jonathan Nieder
2009-12-07: looks-fine-to-me-by: Jeff King
2009-11-11: originally-submitted-by: Jonathan Nieder
2009-05-15: looks-right-to-me-by: Johannes Schindelin
2008-12-26: patch-by: Shawn O. Pearce
2008-12-07: kind-of-noticed-by: Jakub Nar=C4=99bski
2008-07-03: backtraced-by: Shawn O. Pearce
2008-06-13: deemed-obviously-correct-by: Shawn O. Pearce
2008-03-29: patch-submitted-by: Eric Wong
2007-12-07: test-proposed-by: Jakub Nar=C4=99bski
2007-11-17: completely-acked-by: Jeff King
2007-09-12: proposed-by: Shawn O. Pearce
2007-06-03: hopefully-signed-off-by: Johannes Schindelin
2007-05-19: confirmed-by: Eric Wong

-- =

Felipe Contreras=
