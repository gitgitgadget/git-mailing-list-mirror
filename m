Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D732C433B4
	for <git@archiver.kernel.org>; Thu,  6 May 2021 11:01:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 27C4961154
	for <git@archiver.kernel.org>; Thu,  6 May 2021 11:01:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234508AbhEFLCH (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 May 2021 07:02:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234655AbhEFLCG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 May 2021 07:02:06 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B612C061574
        for <git@vger.kernel.org>; Thu,  6 May 2021 04:01:04 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id v22so242633oic.2
        for <git@vger.kernel.org>; Thu, 06 May 2021 04:01:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=tgtGGFbk/0tahTo5rOnzDq+6zOyNokxECWAdMQkVDhg=;
        b=R0k55xHg902V2KsPw4nOqONdkDLtOVODHyydpfJzxGuWywefdLskdtLYd/E9Tk69eM
         +LSbyudW6DFOTCC6G+jMgY/1ExHiubmMI52sdxpAzR67B8T4ghD4rIvVS46Sva3RuD9S
         Xe2ZSKaR2NX9i5O7acqGWJia8W2B+vWHNnf39WugSdS9EcFFcXn6o2bk0LVYabFVSeWJ
         tVwTHAw/s8Et1UYvrOf5sN+5DgHge1u6VsyOhFy39zGaVxE9oeaDtPfg6GfnEP7B6Qgl
         Zfij3CZJr8SkPbYZDnxFGmFsBvMhdws2VAKwCAgwTfA/I4ap89XRuOcF+rDcodupo0nf
         65aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=tgtGGFbk/0tahTo5rOnzDq+6zOyNokxECWAdMQkVDhg=;
        b=uXcs42XXUYLq4AH0YoZISSXHn8BgtWln3LScK+jTxg032jJRMefha8KYV4Dxccdted
         LydfWgibsgZL3UCqCYxIGomh2UD2LJCkOXgLKSPL6m6TsYCT4FFF7NNXqLbuBWngSmHd
         ZDIS6rXtjC9MeOoSbwbQ+VcoM7ldwSMBqB8ZfTf7xkBlM0JwMIu2OWc1RMJzaZBTB4yN
         u1uFsYa2kds+B30wpEjtkPBF82tu5LW0JUWUs7/v58vJMsE8a9Szh4FGFgecDaKcSAAN
         lPYyKU0ucIrfKtpknFkedxlk+ZwCcwF2VtLII3DPeiezvPPK13hiDHF8rc3Z/IOxRKki
         gATg==
X-Gm-Message-State: AOAM533GYLM/7V2LH3F/2jv6OW1ax3fcVhtsYo0xUoKkQzBTaLFpYcOw
        izx80Vc3P/1rVeAgAxsg0DxuAkjGPLsnWQ==
X-Google-Smtp-Source: ABdhPJydhoxIeV8f++HJaV9+ddZuY20e26RGzALJSQBorES8imM5j5vohTJ+XF707JUH7EHYN/nW2A==
X-Received: by 2002:aca:b9c1:: with SMTP id j184mr2687902oif.134.1620298863370;
        Thu, 06 May 2021 04:01:03 -0700 (PDT)
Received: from localhost ([2806:2f0:4060:638f:a2c5:89ff:fe0c:1151])
        by smtp.gmail.com with ESMTPSA id 3sm441864ood.46.2021.05.06.04.01.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 May 2021 04:01:02 -0700 (PDT)
Date:   Thu, 06 May 2021 06:00:51 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Elijah Newren <newren@gmail.com>,
        =?UTF-8?B?R8OhYm9yIEZhcmthcw==?= <gabor.farkas@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Message-ID: <6093cc63a4e81_325720840@natae.notmuch>
In-Reply-To: <xmqq35v01ua3.fsf@gitster.g>
References: <CAPiPmQnb=XMaF2+YkryEbiX8zA=jwa5y=fbAGk9jpCExpbS4Rw@mail.gmail.com>
 <CABPp-BHBcjSQbkotrzwDtVRSC-qqjEyP4m=biY-0+=Jdg9ETQw@mail.gmail.com>
 <877dkdwgfe.fsf@evledraar.gmail.com>
 <xmqq35v01ua3.fsf@gitster.g>
Subject: Re: git switch/restore, still experimental?
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
> =

> > I mean, I see why. You don't want a typo of "master" as "maaster" to
> > create a new "maaster" branch, so really that's out. But it really
> > should be:
> >
> >     # -n or -N for --new / --new --force (the latter just in case of =
a
> >     # race, and just for consistency)
> >     git switch -n doesnotexist
> =

> I do not see why --new is better than --create;

I do. Different languages equal different minds.

New in this context is an adjetive: it is a modifier of a noun, in this
case, a branch.

Create is a verb; it's an action.

Linguistically speaking they could not be more different.


You don't do two verbs at a time. Either you sleep, or you eat, but you
don't do both. Similarly you don't switch and create. Doesn't make
sense.

If you use natural language:

  1. Git, switch to a new branch

  2. Git, switch, create, branch

One of these simply flows, the other is complete gibberish. I think
anyone familiar with English can identify which is which.

Cheers.

-- =

Felipe Contreras=
