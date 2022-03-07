Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05C9BC433EF
	for <git@archiver.kernel.org>; Mon,  7 Mar 2022 06:09:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233227AbiCGGKg (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Mar 2022 01:10:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232119AbiCGGKf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Mar 2022 01:10:35 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98FF41CB3D
        for <git@vger.kernel.org>; Sun,  6 Mar 2022 22:09:41 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id bi12so16400102ejb.3
        for <git@vger.kernel.org>; Sun, 06 Mar 2022 22:09:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=klerks-biz.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=lqHDMuUguMDYP1qrWsIm3zmLskrYlzu2iqhQBn3/ybs=;
        b=hLCcCNeu4bg/h+GvUiYZ2BHWAmNHDgyZQkfJ+r2o319HDIwKOIC2ZiXsW2fTyUvBn3
         QJFB0xACeHry3uW7nP9+zDk5/1QiGJgaR3om28a4bTWuFEP56ie8Qi8hnNACk/b6Lud8
         42hyTJreGivAvVspimMN4DWXHq354G7IZsbdiDfpQQJamg8PDKbK7+YMqrElAxHzeJ0V
         tt4nsGZt8KpWjFABbAH1qkFg9LgkhzqHLX/NmtX3a+sSV9XQSO2FbwV4BZhixoX6pbmI
         wLxnQlVmPirJ49Y+kFe34UEsq6mcXII6mVnhkik4dC+4+oYxTur24X/Xn2ErmNVT+BoY
         tT3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=lqHDMuUguMDYP1qrWsIm3zmLskrYlzu2iqhQBn3/ybs=;
        b=myMFrFEV6GH//kz9Xgs0czHtNpHuDGfYZfqJ72blWPm/Q9ZFx+qJ8jtJOdojeKuRmT
         +OCetqBZ3Je3IEkRl29ZAGp83cLmEZzrvP3/oxJJpsSxcDyXTUinthnfaUlDh68cmb3R
         GiWKeZnX74ydqzd8GMPTxRT1sCC55EUTKly5jEZxInF8tuhkC+c1bdgDZWdV1egaht7T
         c42HSXKiCLcYOpj/N0MvQZ12b0i//SsJ8N3jzROToN8gZog28qNLUokRUaNIJzCdrQHZ
         ByjQwui3kgtfbwdxvHq7J/61KRpxVixhvCBB1sif75aAZZEiA+YYmqTML6FD5btk1Rb1
         ypkA==
X-Gm-Message-State: AOAM5321yNid8HAxrpeKNfq2OOMoK6mCvxexRLG5BYrN+injYVoH0c8B
        UzjKh4B1jhDAierCzm87EOKxZutDrt0JX+RP/8zwWw==
X-Google-Smtp-Source: ABdhPJwfKWcH2ipIN5F8QxPmsAHXWvY2WdmhwLrTyunAODAIrRowwOA6BvP9aiKV6YVyxCEzHfgP90gJ80xE1ptF7FM=
X-Received: by 2002:a17:906:4ad9:b0:6cf:93f:f77e with SMTP id
 u25-20020a1709064ad900b006cf093ff77emr7999490ejt.558.1646633380075; Sun, 06
 Mar 2022 22:09:40 -0800 (PST)
MIME-Version: 1.0
References: <CAPMMpoiTJAuadBEOPWOVa-kguSXMDvAhvD22B63QwYpu=H7xEw@mail.gmail.com>
 <220303.868rtr42mg.gmgdl@evledraar.gmail.com> <kl6l4k4ek73o.fsf@chooglen-macbookpro.roam.corp.google.com>
In-Reply-To: <kl6l4k4ek73o.fsf@chooglen-macbookpro.roam.corp.google.com>
From:   Tao Klerks <tao@klerks.biz>
Date:   Mon, 7 Mar 2022 07:09:28 +0100
Message-ID: <CAPMMpoh96fHi7RbcMxrwkinyXiy-to6cnVACNKQV8C-7_vZH=g@mail.gmail.com>
Subject: Re: What does it mean to have multiple upstream tracking branches?
To:     Glen Choo <chooglen@google.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git <git@vger.kernel.org>, Josh Steadmon <steadmon@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 3, 2022 at 11:24 PM Glen Choo <chooglen@google.com> wrote:
>
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
> >
> > Can you point out some existing tests where we end up with multiple
> > *.merge values? I looked a bit and couldn't find any.
> >
> > Or maybe it's only possible to get into that state with some command we
> > have a test blind spot for?
>
> Based on the discussion on that thread you mentioned, I don't think we
> have any such tests. I think the only way to get into this state is to
> manually modify the config.

There is now a way to get into such a state for a new branch, assuming
you were in such a state for an existing branch, and that is to use
"--track=3Dinherit" when creating a new branch, branching from one
previously manually set up that way.

>
> The only docs I could find on 'multiple values' are from
> Documentation/config/branch.txt:
>
>   branch.<name>.merge::
>     [...]
>     Specify multiple values to get an octopus merge.
>

Cool, hadn't seen that, thank you.
