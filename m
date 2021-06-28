Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 762D4C11F64
	for <git@archiver.kernel.org>; Mon, 28 Jun 2021 19:44:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 50E0E61425
	for <git@archiver.kernel.org>; Mon, 28 Jun 2021 19:44:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236376AbhF1Tqw (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Jun 2021 15:46:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233988AbhF1Tqs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Jun 2021 15:46:48 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1CDEC061574
        for <git@vger.kernel.org>; Mon, 28 Jun 2021 12:44:21 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id w127so23306197oig.12
        for <git@vger.kernel.org>; Mon, 28 Jun 2021 12:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=ZCwZ7i8Txwwrb3m39CHYP8h3QrCYPgbCcxZ8fv08+yo=;
        b=kvLUv/4KkdI2MaeFuGyVp6h2k2ADh0CNlecypKsHBn1ukvK8He+4rVNqTBIJC1fbSt
         isOxvapyuKxOD8IzdL3MCgNNV3MK9zCHY8Orph2az2C8qKLqgBcvtIAGcs42Tgy7HMBp
         YqugwV/2vt7eIchU8uDloiNGfNUPbiaWUILlUu0n2nWrEm2RidlnGY/cf9aLORK4WT3e
         4ubZ+Dxdl4mWkQj6LSi/gDBuJlZsJcF0Qo4NGpQJ4r6G95bZ2Oi42eiz6MMV5yECyQTr
         0gTwauALOaGWEvLT2qDJGf91qXx+sXzNssqu1PHuFrZ6F8x2oRdibFGxMvFfcFTOl9hp
         vjsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=ZCwZ7i8Txwwrb3m39CHYP8h3QrCYPgbCcxZ8fv08+yo=;
        b=jRDjTsMpA8+Htc8UCuLACUIEk9Dx9gUzZRr9aGmbzKBTEGIQEOObvDTko8RUrD/yJw
         TPaW0Z7paxSG3rYyBnXq2I8JiWv4lqkQg99PVHjlav+S572MSGlMNpxJpxO24Iuyz8hw
         ijpaHBTnlhXywtFAtlO6akV6OWurqyTEW20kNqlWBUMSXsBg1WgTiJQ//H85TI0uLkrV
         e6xvoKsyZkKeIRw8NNaArJwOXIrgdosHRl2GpRccrA7pkR8O5YQVHupXp6MZhhsjsVz8
         SrRt/t1DGWMWrG22jngLjLrmnzPWAl6kwC7x4idfO9T1tLCIgXCLDR65MniHO4vxel/f
         dq8w==
X-Gm-Message-State: AOAM53164RzuwBrOdLgunJF7HdaecMZzsTXXSqNvyzJrJEew5tMMY36C
        Kc10yQ6CAVwUvI19/LGgVqE=
X-Google-Smtp-Source: ABdhPJyz3rc6BeghKT07bnT15OQCZ/XkRRRvXibosLY3uLxAIFW+7+EZvQRG3j/rmZjuUfJSOPaaTg==
X-Received: by 2002:a05:6808:4:: with SMTP id u4mr11848944oic.106.1624909460930;
        Mon, 28 Jun 2021 12:44:20 -0700 (PDT)
Received: from localhost (fixed-187-189-165-231.totalplay.net. [187.189.165.231])
        by smtp.gmail.com with ESMTPSA id l44sm3744740ota.47.2021.06.28.12.44.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jun 2021 12:44:20 -0700 (PDT)
Date:   Mon, 28 Jun 2021 14:44:18 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     "Randall S. Becker" <rsbecker@nexbridge.com>,
        'Felipe Contreras' <felipe.contreras@gmail.com>,
        git@vger.kernel.org
Cc:     'Junio C Hamano' <gitster@pobox.com>, git@vger.kernel.org,
        =?UTF-8?B?J8OGdmFyIEFybmZqw7Zyw7AgQmphcm1hc29uJw==?= 
        <avarab@gmail.com>, 'Jeff King' <peff@peff.net>
Message-ID: <60da2692e8029_1d6fc20855@natae.notmuch>
In-Reply-To: <029101d76c54$9f713c50$de53b4f0$@nexbridge.com>
References: <60bfadc0aca09_1abb8f208fd@natae.notmuch>
 <60da10df509f0_1b95d2089c@natae.notmuch>
 <029001d76c4d$f3277550$d9765ff0$@nexbridge.com>
 <60da1c8de0ca7_1cdb420832@natae.notmuch>
 <029101d76c54$9f713c50$de53b4f0$@nexbridge.com>
Subject: RE: How dow we educate our users to configure less?
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Randall S. Becker wrote:
> On June 28, 2021 3:02 PM, Felipe Contreras wrote:
> >Randall S. Becker wrote:
> >> On June 28, 2021 2:12 PM, Felipe Contreras wrote:
> >> >Felipe Contreras wrote:
> >> >> It has been suggested that we "educate our users" to configure le=
ss
> >> >> in the right way, instead of colorizing man pages ourselves [1].
> >> >>
> >> >> The question is *how*? Nobody has answered that.
> >> >>
> >> >> This is a continuation of the thread below.
> >> >
> >> >> I am still waiting for an explanation.
> >> >>
> >> >> How does the user properly colorize man pages for both man and gi=
t
> >> >> in a way that works in all distributions?
> >> >
> >> >No response.
> >>
> >> I think you're looking for something does not exist because it is
> >> platform and environment dependent.
> >
> >Yes, but there's always some common denominator.
> >
> >> There are two ways to configure git to work with 'less' on NonStop a=
nd
> >> neither is identical to Ubuntu or Windows.
> >
> >But I'm not talking about configuring git to work with less.
> >
> >Once you have less configured, how do you add colors? For example how =
do you turn bold into red bold?
> >
> >> Don't even get me started on what less does in a TSO/ISPF environmen=
t
> >> where everything is some single colour on black unless your emulator=

> >> supports 3279 emulation.
> >
> >Is it even possible to add color there? I'm talking about platforms wh=
ere color is possible in the first place.
> >
> >> >It's safe to say at this point that nobody knows what that configur=
ation would look like.
> >>
> >> Nobody, perhaps, knows how to do this on every platform in the known=

> >> universe =F0=9F=98=8A. There is no "one way" to do this consistently=
 everywhere.
> >
> >In the platforms where color is supported, and you have less, what doe=
s this do?
> >
> >  LESS_TERMCAP_md=3D$'\e[1;31m' LESS_TERMCAP_me=3D$'\e[m' git help git=

> =

> This only works in bash/shell. So if you are not initiating from a shel=
l, you cannot use this technique.

I know. The technique is not the point. You can use whatever technique
you want to get LESS_TERMCAP_md and LESS_TERMCAP_me set on the
environment before launching `git help git` in whatever way you want.

Now, clearly that technique would vary platform by platform, which is
precisely why I'm proposing to do it inside `git help` itself [1].

Clearly this would work on every platform that has less and color and
it's technique-independent:

  setenv("LESS_TERMCAP_md", GIT_COLOR_BOLD_RED, 0);
  setenv("LESS_TERMCAP_me", GIT_COLOR_RESET, 0);

Would it not?

[1] https://lore.kernel.org/git/20210626025040.104428-1-felipe.contreras@=
gmail.com/

-- =

Felipe Contreras=
