Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56231C433F5
	for <git@archiver.kernel.org>; Mon, 25 Oct 2021 14:40:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 388A660E0B
	for <git@archiver.kernel.org>; Mon, 25 Oct 2021 14:40:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232620AbhJYOnE (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Oct 2021 10:43:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230174AbhJYOnD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Oct 2021 10:43:03 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47C7DC061745
        for <git@vger.kernel.org>; Mon, 25 Oct 2021 07:40:39 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id z14so12137676wrg.6
        for <git@vger.kernel.org>; Mon, 25 Oct 2021 07:40:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=FpvVLJw4h77Ut7w4EbUvHxfHmSbbF5VxjXAlWygqQVg=;
        b=GESSHLDKC2/cQNUW0B84gR6IqmDD8IJj4c57vwjJOkTCSVhvbkrvHSaNmNCcg0Pnl6
         nbB3PB2yiFoelZiciJG2xl6+clLBCMXtd3+RCgSpXyFI4iy1bfN5qgj7esbWTkffZc4T
         NiO7oGEhKhp0Ul1mcSQl/+8HIWmYdv8GNVEoG70Lnt3FLxUXy8objA3YCwniLxGYfHNi
         5flzlvFf5ZCgATnXDSMo+OS2o7nNtdGQlDK8ZCJUTxgKJPH2TItREoBex5ywkOsqpD1I
         R1pfSla1gWIc6a5Ueo32Alk0Ki7Uax57lUuZIJ1RIboD/dzFrSqib5JAmzu1ofRdsoS5
         7HOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=FpvVLJw4h77Ut7w4EbUvHxfHmSbbF5VxjXAlWygqQVg=;
        b=zW17oWmJqwoaoT0aSD4STXp2kub++mMpk0kNG8RqVYGRNadtuP/LkEj1zKJ9aUxuKo
         xkgWgzIHJVEzzK//7Cuy/aotFU2oiFm4f4CKgoYt9Mes25Aki1Ljc2Y9HQL6YoYAMoDg
         5kdvJuMzzvf3ToN6wiJRTvNxsx2Vnix9YJ/z/ydfin6pngcgrvCg4McutJYxXq3rmnNb
         DIhWHrzu0eSNejkmGk6RjA2+t2e2ZLxzuTnqZKO4OloBiNoyQUsWGgpeCsjcrhRjRklN
         b63knXpisaZG8ynVjXz/FlXAvEi7mSHpNlKwt+Ix33JdYIgfpOu7bmIK1JaZm41ivcWN
         SgrA==
X-Gm-Message-State: AOAM53385LkufASw1iZIlDHpNoVgfeI4JNWs1KFi4oE9a/od8xSZyCUW
        wJwSi81wE7thcvSnwbpPSf3cE8xHVINyAw==
X-Google-Smtp-Source: ABdhPJzuR0LjD9sqU6bIhVhBKueR6p2UUXdd23MaKQ82zhPXVHrhHwXEQoAI1LTNncdeU1kCnVQSNg==
X-Received: by 2002:adf:efc7:: with SMTP id i7mr20226292wrp.410.1635172837777;
        Mon, 25 Oct 2021 07:40:37 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id a26sm1449550wmm.46.2021.10.25.07.40.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Oct 2021 07:40:37 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mf19Q-001ZH4-Rn;
        Mon, 25 Oct 2021 16:40:36 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Fabian Stelzer <fs@gigacodes.de>
Cc:     Marco Beck <mbeck@eaddrinuse.net>, git@vger.kernel.org
Subject: Re: [PATCH] gpg-interface: allow selecting key id with env variable
Date:   Mon, 25 Oct 2021 16:38:32 +0200
References: <20211024193625.148-1-mbeck@eaddrinuse.net>
 <xmqqsfwq40w7.fsf@gitster.g> <YXXMroOBvDERXIMP@octopus.int.carobme.de>
 <8661a491-5ef1-a469-878f-7dd81d4a1aa2@gigacodes.de>
 <YXZpyWesc8VRWYwr@octopus.int.carobme.de>
 <bc6b915a-7aa0-298b-e1ec-bf548e4dbdfc@gigacodes.de>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.6
In-reply-to: <bc6b915a-7aa0-298b-e1ec-bf548e4dbdfc@gigacodes.de>
Message-ID: <211025.86h7d5gobf.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Oct 25 2021, Fabian Stelzer wrote:

> On 25.10.21 10:24, Marco Beck wrote:
>> On Mon, Oct 25, 2021 at 09:31:33AM +0200, Fabian Stelzer wrote:
>>=20
>>> [includeIf "gitdir:~/projects/work/"]
>>> =C2=A0path =3D ".gitconfig.work"
>>=20
>> Yeah, that's what I added to my config recently just for signing key
>> selection. I'm using direnv[1] for some time now to switch between
>> different "profiles" (more than just Git settings) by just setting
>> some environment variables and it was nice to have everything in one
>> place. That's why I disliked adding the includeIf to my .gitconfig.
>>=20
>> Thanks anyway,
>> Marco
>>=20
>> [1] https://direnv.net/
>
> If you insist on using environment variables there is:
> GIT_CONFIG_KEY_<n>
> GIT_CONFIG_VALUE_<n>
>
> https://git-scm.com/docs/git-config
>
> A bit clunky in my opinion but you can set any config variable via env va=
rs:
>
> e.g.:
> GIT_CONFIG_COUNT=3D1 GIT_CONFIG_KEY_0=3Duser.name GIT_CONFIG_VALUE_0=3Dte=
sting

Although to be fair that's quite clunky if you're setting N number of
these.

Marco: Would the "include by env" method discussed in the thread at
https://lore.kernel.org/git/patch-1.1-1fe6f60d2bf-20210924T005553Z-avarab@g=
mail.com
be a better fit for what you're trying to do here, and eliminate the
need for you to have an env variable setting for this config key in
particular?

Anyway, aside from that I wonder if we shouldn't just have this env
variable anyway for consistency with the user.name, user.email
etc. equivalents, which we probaby wouldn't add today if they didn't
exist, but since we have them already...
