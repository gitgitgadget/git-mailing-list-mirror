Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF7FBC04A68
	for <git@archiver.kernel.org>; Wed, 27 Jul 2022 18:03:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242993AbiG0SDi (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Jul 2022 14:03:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242983AbiG0SDR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Jul 2022 14:03:17 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74561BA4E6
        for <git@vger.kernel.org>; Wed, 27 Jul 2022 10:07:13 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id mi13-20020a17090b4b4d00b001ef9759d26aso2272276pjb.0
        for <git@vger.kernel.org>; Wed, 27 Jul 2022 10:07:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:from:to:cc;
        bh=uROGNp1P9QtiofS9M1Z+CumNzSd1AXmJTgYZxxLbmoY=;
        b=kHPu3t8OgS4P81fRzIuH4nFSOoy0FET5OKayT3ItZKTUy3LXG4ef/+84YSG8/Sq6G1
         J8f2J9Q2cFmMYFmapfg48h1CipUdfzotpQxJUPGBw9BEvFKEefNI3TV1TVdtMxd3yoRc
         z6RimckP8kFoS2b55tygBoOf/qt629AIBTQyRYkRInCT2OxDdMQc6JhNdn3txn7v/X0u
         eedD0Wn8qOE7wW8lWaBQ8K0ja5IYEuOQ6S4pV8uhYHMPEzlv5FW8v97lnonZ8JWG6qA1
         gQ+UcQKDilvjwo/8VcYPACV30igd0pMOQp44mOwc0vhkJIOoGiugbNewUcYRigGfO9d2
         D72g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:x-gm-message-state:from:to
         :cc;
        bh=uROGNp1P9QtiofS9M1Z+CumNzSd1AXmJTgYZxxLbmoY=;
        b=gvRakulZsbCoMwx6dBN1si0dvO8Snz5a9NkE2lFBx8JJXiskC8CfqW+IKFiNGSh2jr
         3ucltRK9GAsHMgvSoC8tSHmRt/4ri/5ZrYTJiMO5y7BcCi7fLuQZhPuzQevj3bIczQhE
         GxUVYr4BAi4aOGrvUHQDm2Hl6IiEkgRCIXa80iuluMY/HQ85RLmk5FsQl3adCLad8Y/0
         w3ynZ7tvGbMULOQGLaTASMQaEyx9z0G/hEOQLcoL/Ram+IhFcutP9enmDbSfa2c2opvn
         7I1WU4hjn3c3LlcmE9oxNh6o0PUfEb+r22tGvlS8i7nXc7heKKA9NsxrWBCtnmBrSqw5
         Dwrw==
X-Gm-Message-State: AJIora9EGZ2Pm2H2JqvKtPTJB561oSDu+7PsePhcWSDrgrRXAGeDUeok
        EmHi/B4IMi3EhAWwEzGQofaSQZ/iXvtanw==
X-Google-Smtp-Source: AGRyM1sqJzCmaomOnLh283Gqc8osCWHp13cXvEChsM2LHR0BG6haTIl7fZe4pp8gMRIu5rX8FELic1rnx29d4w==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:90a:8a8d:b0:1f3:155:3324 with SMTP id
 x13-20020a17090a8a8d00b001f301553324mr5541808pjn.89.1658941632485; Wed, 27
 Jul 2022 10:07:12 -0700 (PDT)
Date:   Wed, 27 Jul 2022 10:07:11 -0700
In-Reply-To: <220727.86v8rilxx1.gmgdl@evledraar.gmail.com>
Message-Id: <kl6la68uscw0.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <pull.1299.git.git.1658855372189.gitgitgadget@gmail.com>
 <pull.1299.v2.git.git.1658874067077.gitgitgadget@gmail.com> <220727.86v8rilxx1.gmgdl@evledraar.gmail.com>
Subject: Re: nonnull v.s. BUG() if !x (was: [PATCH v2] config.c: NULL check
 when reading protected config)
From:   Glen Choo <chooglen@google.com>
To:     "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>,
        Glen Choo via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <derrickstolee@github.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> On Tue, Jul 26 2022, Glen Choo via GitGitGadget wrote:
>
>> From: Glen Choo <chooglen@google.com>
>
>> +	if (!filename)
>> +		BUG("filename cannot be NULL");
>
> Looks good, but as an aside I wonder if we wouldn't get better code
> analysis with "nonnull" for this sort of thing, but we can leave this
> for now:
> https://gcc.gnu.org/onlinedocs/gcc-12.1.0/gcc/Common-Function-Attributes.=
html#Common-Function-Attributes

Interesting. I wonder how good the analysis is vs the cost, e.g. it's
useful if it detects _maybe_ NULL variables, but it might be too
expensive if it requires us to mark all of our variables as non-NULL.
