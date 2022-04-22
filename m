Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23D91C433EF
	for <git@archiver.kernel.org>; Fri, 22 Apr 2022 09:22:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1445904AbiDVJZB (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Apr 2022 05:25:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377251AbiDVJY4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Apr 2022 05:24:56 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4394403D4
        for <git@vger.kernel.org>; Fri, 22 Apr 2022 02:22:01 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id g23so2676905edy.13
        for <git@vger.kernel.org>; Fri, 22 Apr 2022 02:22:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=qr6xC9syLQOTy8C1JImFbJ8iB3xyMRtbIt49pqnm7Jo=;
        b=EYyPNEzQbRQMs2IrCHXf+K/vWJTAheQdLDnkQiKjCIc6EKUh6OBHv9BYt/kUh5UH5o
         oF0bIjoFcLJuNvyjZdvuY42swqLsfYaiEAeVtyIT/YT7bURwtfvfXb3cwCsr7fUz3RrZ
         CzrbYJlmhr9uwq5Pbjs5jPTyACk8CtBwVVO5EwIowL6A5NDK5QjDo287muwT7tz+Vr+Q
         HOujtBVzhnADZiurqYSyxK5D5HHulTg+tdHEhvvKsTAuhCVg1QpYd7Ruyn4zdc8Z4o8z
         Jn6F+yQgFjH+f9zMm1s3ynTLiRbF4dWQuRYcGFAvm0/Cvs5g7N5Qeb+V+m39LhfehkC4
         jonQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=qr6xC9syLQOTy8C1JImFbJ8iB3xyMRtbIt49pqnm7Jo=;
        b=CE5jWYjkqLCgK2S3Or8vcFak6vyBMjlZhTVbjutNoUdTJ4Z4rSB4Rz2BY73L4BFuGM
         PL2JG1HVnFvmWSt2nv+KMH4euWcj0j1vsyRZK9xQYEzdtu30z2HMRgT0+vNbejx0cCB1
         T8Ckedy8cPc5dP9YwynPlN4ySkgqiR32yBIzR4IvB6/ge/EzETZz/P+8JdyYaTzR6t/l
         Hees8H7FTTaD3q3J7ciGLwld2+VqbF4g2Us+uwU+h+Z8+aEk7cekWlIr26/VE4fHiuaQ
         jRL8QunhZowOA/DqA1UCi8h2CRmxhUR9tfH0j6nQnYq3jEzFMKZqP2C+iCuTf+xXhihf
         vp2w==
X-Gm-Message-State: AOAM5321N6yEsYHfF/vUPLZNpQ4jRvapLBQFnYomx3rbsP4p7XORyQPZ
        oCbeDRfW8NvX6Wh9BazIybNCiKwdGtWSfw==
X-Google-Smtp-Source: ABdhPJxMNZgPAhWRl0ZFORweoidt7lE63fbix9Lxjd/jNLclxLpbGYETgCip0yF9SAn1FXqefpa//g==
X-Received: by 2002:aa7:c9ce:0:b0:425:c396:dde with SMTP id i14-20020aa7c9ce000000b00425c3960ddemr399650edt.397.1650619320062;
        Fri, 22 Apr 2022 02:22:00 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id b25-20020a056402139900b0041904036ab1sm671157edv.5.2022.04.22.02.21.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Apr 2022 02:21:59 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nhpUE-008dIO-VT;
        Fri, 22 Apr 2022 11:21:58 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Derrick Stolee <stolee@gmail.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 0/2] CI: don't fail OSX tests due to brew v.s.
 perforce.com mis-matchy
Date:   Fri, 22 Apr 2022 11:21:43 +0200
References: <cover-0.2-00000000000-20220421T124225Z-avarab@gmail.com>
 <20220421213024.xzkzuy3l7q5assxo@carlos-mbp.lan>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <20220421213024.xzkzuy3l7q5assxo@carlos-mbp.lan>
Message-ID: <220422.86h76l5v7t.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Apr 21 2022, Carlo Marcelo Arenas Bel=C3=B3n wrote:

> On Thu, Apr 21, 2022 at 02:53:50PM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>> For the past days we've again had CI failures due to "brew install"
>> detecting a SHA-256 mismatch when trying to install the perforce
>
> Since the only reason why that is a concern is because it aborts the
> rest of the run and is a recurring problem, wouldn't it be better to
> tell the script to continue regardless and therefore skip all perforce
> tests?
>
> Sure, there is a window where that integration could be broken which
> will be only visible once the perforce cask gets fixed and perforce
> installs again, but wouldn't that be less intrusive and overall safer
> than the currently proposed change?

I tried to answer all of this in the updated v3 CL. Thanks!:
https://lore.kernel.org/git/cover-v2-0.3-00000000000-20220422T085958Z-avara=
b@gmail.com/
