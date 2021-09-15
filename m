Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FC0CC433EF
	for <git@archiver.kernel.org>; Wed, 15 Sep 2021 17:49:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2163F61164
	for <git@archiver.kernel.org>; Wed, 15 Sep 2021 17:49:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230035AbhIORu5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Sep 2021 13:50:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbhIORu5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Sep 2021 13:50:57 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D388CC061574
        for <git@vger.kernel.org>; Wed, 15 Sep 2021 10:49:37 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id n10so6426226eda.10
        for <git@vger.kernel.org>; Wed, 15 Sep 2021 10:49:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=BSFsaWihuxYIrdd9hT0f/fx2/Dl5V8yQ8bR61Zp1GAU=;
        b=pmZadmMANn6hIV7ylAiigYGKXErpnVbefGIE05EwnnRqUhsP/YZA5XrxiVQvJz6jvm
         PKD2QJsd/t8/Sovvk2cK/JdadDLRMr6F7egVXzejjlr9p07ywQCNPMVsjB1RPuWAxb9i
         rZ4FCWNiTUI8YyY/wsDaId9aa7PhPjk/gsI86cDteeLI/7FTGpjd2pzG4wSFmAOFs3oP
         lFMXAsF1wWzTSvUO6smTx+BNxdrScNUP+o5IQA66c2sZkPw7PWfWVcFlQFQQtwh82xVN
         caiKiLp4PS840wc7G/LVzhSKn+knwNK6oFkycYadW3oLr8egUEiK8OuWDSJFOZ8Nxxtn
         lOeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=BSFsaWihuxYIrdd9hT0f/fx2/Dl5V8yQ8bR61Zp1GAU=;
        b=ZVfd2ySYqiLEdSnPp9jowF7BQ1yPS5SA2ik/gIPsNjElP7wFMks85B5lLqtkdPsj9s
         f4Ve4CmiAM+rAEH1/is247ocU5ZCcGBVvhOO4flXTnjlDsvC/TqKGDzELeUhZSFZE2Ox
         /X39n6c9qXHRYbQkgxB3lyf54eyGUyeiA2rEQO5SFmien2G59QKkkbE1haFMETGel2f5
         0XQXfuh1r/RWOKUKUSkkavPAom+pFOYFkJK5AcW5d2WNrhhxCri2FeTLAF3hQtBhA0aw
         ME7frswNgLxaqzuXUJ/NFZb+o3Hdu5gI+0miThXxhVzuuy4+mfzlPdxpkpSesA3buA5B
         GjSg==
X-Gm-Message-State: AOAM531TOtMe9f1dtx2TWJaZ/HBgR2bv+9EXGBsZCwX1wV/bTY2ZvWg7
        kN93Wu78xeuQsX7xr6qAkI0=
X-Google-Smtp-Source: ABdhPJwOovMCXL7MVVq97TWB3q3asQeO4Uw98IyBDvQMBdVe/C+isQZyLxLl29ZHbJmuuCrMWokjyA==
X-Received: by 2002:a05:6402:27c6:: with SMTP id c6mr1299544ede.111.1631728176347;
        Wed, 15 Sep 2021 10:49:36 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id s7sm322351edu.23.2021.09.15.10.49.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Sep 2021 10:49:35 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Marvin =?utf-8?Q?H=C3=A4user?= <mhaeuser@posteo.de>
Cc:     git@vger.kernel.org,
        Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= 
        <carenas@gmail.com>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>,
        Drew DeVault <sir@cmpwn.com>, Simon Ser <contact@emersion.fr>,
        xiaoqiang zhao <zxq_yx_007@163.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Christian Ludwig <chrissicool@gmail.com>
Subject: Re: [PATCH] send-email: Avoid incorrect header propagation
Date:   Wed, 15 Sep 2021 19:47:01 +0200
References: <20210830153001.29961-1-mhaeuser@posteo.de>
 <0c753ae6-cc2c-2d70-c510-5370a0b4dcf9@posteo.de>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <0c753ae6-cc2c-2d70-c510-5370a0b4dcf9@posteo.de>
Message-ID: <87o88tn2z5.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Sep 15 2021, Marvin H=C3=A4user wrote:

> Ping? :)

Hi there. The patch you sent has been picked up after you sent it and
has now been merged to the master branch of git.git. See
https://github.com/git/git/commit/bd29bcf9136 and your commit at
https://github.com/git/git/commit/e0821134846

This means it'll be in the next release, v2.34, set to come out
mid-to-late November.

Thanks a lot for contributing to git, for future submissions you can
keep an eye on the What's Cooking summaries that get sent out to the
list, for your patch see:
https://lore.kernel.org/git/?q=3D%22send-email%3A+avoid+incorrect+header+pr=
opagation%22
