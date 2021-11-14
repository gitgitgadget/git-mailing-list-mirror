Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFE51C433EF
	for <git@archiver.kernel.org>; Sun, 14 Nov 2021 19:01:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BCA7E60E97
	for <git@archiver.kernel.org>; Sun, 14 Nov 2021 19:01:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236187AbhKNTEc (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 14 Nov 2021 14:04:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234564AbhKNTEa (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 Nov 2021 14:04:30 -0500
Received: from mail-vk1-xa2c.google.com (mail-vk1-xa2c.google.com [IPv6:2607:f8b0:4864:20::a2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2065C061746
        for <git@vger.kernel.org>; Sun, 14 Nov 2021 11:01:35 -0800 (PST)
Received: by mail-vk1-xa2c.google.com with SMTP id s17so887333vka.5
        for <git@vger.kernel.org>; Sun, 14 Nov 2021 11:01:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=9lGN/GXU5oscdxiErRsg8HBdYvtUy/1YP5itSFpqbxE=;
        b=dFVfY0uM8tiICi75w/qgE9wO3Y3/Fs3PccizHI0nGU4Mics3X2gQcDb//nGSiah6D7
         PCPvzQV7r72FxD0zGAxpH4sNaFFKEdtekerXsHtcy51jDJ4Go8VCq34/FvdGcroKjXLd
         iZvXsQI99+xzwca+aMzenoqxk6bDRk+KMFVHeaUO8ooPfFsYo9pR1Scll4kLQGwC9Psp
         aSYtBz5nGQxenGSwZAEXzxYe25f3tQDFg5moMbq16N7/WAa5fydymGhe38IFGDJ1+m77
         2SqeC3Bx73R2iHdIgNfZTR/4Kp+MuM1XCWhwvM2cALioAU2RM2Ff7LdCFFM2MQtOxY+T
         W5Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=9lGN/GXU5oscdxiErRsg8HBdYvtUy/1YP5itSFpqbxE=;
        b=vaB8aKP5aUXJySdVe//NtsNwwSHn9CqbEy4Lup6zB3IMfIT/eCAZ8BtpSfs2aErNz3
         EriLKMYANaZ0BNy0T0xkw8rw7Ul/HWcaT67IN+yEIhLlmfTx0WJ9S86Jap7AlmxxtBtx
         4mEIQ0A/Qzlh4Bo1Bp6Jy7BtoDfoCBJd6vsq9kvf59VrmB5UGqK6wHW8y3xr3xpeDs4D
         oIqVsjboE4kPj50bSiNppKWYVuQjpF+rWZx+1kucCUBu0JcGlrCmSVVJtgkZROr7Cr9Q
         7+BItvJ6e8d8mUm0+nm9De0/X0uCPiHkzdgkuS6C1yM/S6tokdPzRZgbFfCpzxcV8Znm
         T7Ng==
X-Gm-Message-State: AOAM532lxZS0uBQzrGgIBbmFl64PFf4AJ1FsxXS8FaqeF8eX/YBgFEue
        4jB1KlsiigytDmI7Ku/IW7NgqQM5XgpJp0UTRLaCD6tp
X-Google-Smtp-Source: ABdhPJxZi4/RGb5nwR4TCCn7Bf3aAkmFB22I86rkxzp+ItOArNifJi6hrpzTuJJhH3iXndX3eO1E2xvZaVxPlYeqDz8=
X-Received: by 2002:a05:6122:2201:: with SMTP id bb1mr49618643vkb.19.1636916495010;
 Sun, 14 Nov 2021 11:01:35 -0800 (PST)
MIME-Version: 1.0
References: <20211113122833.174330-1-gotlouemail@gmail.com>
 <20211113130508.zziheannky6dcilj@gmail.com> <2b2386b9-045d-a0b8-6dbc-8a9d0c446bea@gmail.com>
 <xmqq7ddbme7q.fsf@gitster.g> <211114.868rxqu7hr.gmgdl@evledraar.gmail.com>
 <xmqqilwulims.fsf@gitster.g> <211114.86zgq6si94.gmgdl@evledraar.gmail.com>
In-Reply-To: <211114.86zgq6si94.gmgdl@evledraar.gmail.com>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Sun, 14 Nov 2021 11:01:24 -0800
Message-ID: <CAPUEspgHm2py_irKKFucrnnCHrgAHraQkSnAJngORGVegzn3Nw@mail.gmail.com>
Subject: Re: Is 'for (int i = [...]' bad for C STD compliance reasons?
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Nov 14, 2021 at 10:31 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
> The issue on CentOS 6 isn't one of incompatibility with C99, but that
> the version of GCC refuses to compile C99 code without -std=3Dc99 or
> -std=3Dgnu99. See [1] downthread of one of your links.

FWIW while CentOS 6 is EOL, CentOS 7 (gcc 4.8.5) is also affected and
has at least one more year of "support".

You are correct that without a specific -std flag the build will
break, and unlike what is expected from all other C99 features that
were supported by gnu89 (the default until gcc >=3D 5) and that are
currently in use.  The fact that the pedantic rollout went smoothly is
encouraging in that respect, but take into consideration that is also
limited only to DEVELOPER=3D1.

Carlo

PS. there is a CI job in travis but travis is dead
