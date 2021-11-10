Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8653C433F5
	for <git@archiver.kernel.org>; Wed, 10 Nov 2021 14:37:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C1DC5611AD
	for <git@archiver.kernel.org>; Wed, 10 Nov 2021 14:37:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232171AbhKJOkj (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Nov 2021 09:40:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231743AbhKJOki (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Nov 2021 09:40:38 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E29C9C061764
        for <git@vger.kernel.org>; Wed, 10 Nov 2021 06:37:50 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id o8so11422752edc.3
        for <git@vger.kernel.org>; Wed, 10 Nov 2021 06:37:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=bNAgcDcYSZsJ12DV9pKSoACn6VSf6U3/OQhzc53AmGI=;
        b=j6HDoIJ3moF2kroc4+4nm6GluOzqOEaFply8BStdyPTR07KqR/FwqVGoC8XpPcCNtT
         cjVvuObHxr+4NxAfMhloucPVK18T53Hey2Xj1nsF8a2fHh9scANxhQgUgIZlCFMtvXhS
         FZxIPuqrBlsTSZ+ICCBMoiY054WhMtUySqRpFBmtmuczLmJzYZXYxMsybT/Ti5tZQtZF
         tYjByypgoApkv1Az2sEWPbB7Z/3y9E8GkYAb9fEvGC+GpqAOzC2xZ9fJtCVwg9HReSGh
         aWhycV1waFVfrDE0442+9VbfbbWQlLQOQiAYG38gZ2j9WdDKeuyP2gE/yED6UZvFRhKL
         6hwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=bNAgcDcYSZsJ12DV9pKSoACn6VSf6U3/OQhzc53AmGI=;
        b=7HVMyjzFA91fFtwSZWxnoh52LDXBrB4/IEotR5SdLPCnyxEznxaCGmdwkoF4t89wii
         xYpttqv3yFPppG+htQnVF7ei3Q/lyC1TQjg1WyTCkHkySkGJJ1k+rjrZuL7liwh8sest
         rLFu5xKffXnsCRLra0Ye4+PB1DqFhtbCTFavWB7sDUA71yYBKdN6eGCR1CeiYW9ne+LL
         9rmhYifNSApwFgOPAD4Gx9M6IoQHiMNXXov353D99RUS3lh9IGZjBKTDTeeMleXjH1Mf
         AMB8I8lNJeoE2fttVK2JDU8v6/0zfWnKobgYF94p+FLwRs5feHKoh6Qel0KwQZrKW2rR
         yX8A==
X-Gm-Message-State: AOAM532aVH7ASLpV19cxXLxcbCf1DYtvReqHhi9FSPq1W8AemwP5ZzjP
        KivfjaKCNrA3J4EQnG7oIVA=
X-Google-Smtp-Source: ABdhPJzTdl/Ea9uI7kIl00AX6UcQz94rJTdhaxlN0LGQPm5OpI43mPVFHPwL0jLAtZd6jlokFEYkdA==
X-Received: by 2002:aa7:d601:: with SMTP id c1mr68115edr.17.1636555069078;
        Wed, 10 Nov 2021 06:37:49 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id hc16sm9604662ejc.12.2021.11.10.06.37.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Nov 2021 06:37:48 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mkojU-0010ov-92;
        Wed, 10 Nov 2021 15:37:48 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     andre_pohlmann@posteo.de
Cc:     git@vger.kernel.org
Subject: Re: bug or a general misunderstanding
Date:   Wed, 10 Nov 2021 15:33:04 +0100
References: <0bb0056a59cda294d416762d7f8a9c47@posteo.de>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.9
In-reply-to: <0bb0056a59cda294d416762d7f8a9c47@posteo.de>
Message-ID: <211110.868rxwhy9v.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Nov 10 2021, andre_pohlmann@posteo.de wrote:

> Hello there
>
> I'm not sure if I'm in the right place here.
> Maybe it's a bug or a general misunderstanding of how GIT works.
>
> The following situation: I wanted to create a branch from a
> commit. From there on the work should be continued.
>
> The possible bug:
> The newly created branch is missing commits in the history. Not only
> are they not displayed, the code changes are not present.
> It doesn't matter if the branch is created by Visual Studio or GIT for
> Windows.
> Only in a branch created by GitHub Desktop the commits are present, as
> I would expect.
>
> Is this a bug or do I not understand how GIT works?
>
> Best regards and thank you for the effort
> Andr=C3=A9 Pohlmann

Hi there.

The mailing list you contacted is the Git development mailing list. I
think it's fair to assume that you haven't run into a bug in git, but
are in need of more basic resources on the topic of Git.

Git's pretty good at retaining your data, if you can't find it after
saving it in git the reason for why is likely to be explained by an
introductory tutorial.

A good resource to start with is: https://git-scm.com/community
