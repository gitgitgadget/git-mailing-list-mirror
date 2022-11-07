Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DCB7C433FE
	for <git@archiver.kernel.org>; Mon,  7 Nov 2022 14:35:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231958AbiKGOfk (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Nov 2022 09:35:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231949AbiKGOfh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Nov 2022 09:35:37 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 042251EB
        for <git@vger.kernel.org>; Mon,  7 Nov 2022 06:35:34 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id b2so30630911eja.6
        for <git@vger.kernel.org>; Mon, 07 Nov 2022 06:35:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IPDkYIvEyE/qyP0nBGC6LX7KO3XWc3FaHSsHlqDYEwE=;
        b=kW2Ji07qjgk99TDBPCm1d1FqFsnIRh6URV4GXBpR5RuZFiFUP3aPBb/bzn60+4iTXW
         JSP2u084m1EQ1K9XmLJZE1wDXJysYAJKzMOLkTKqree+kt/Hqna55s2JaU1FtfrrOWQr
         ZGeiQ1/iGO9a+jKRb8nNLGQe9i9Nn6ktxD8wR3gH8fan896S5sUBGuldjxgp2y6hAbL5
         6knYjYe7SIqdKyiY5iy3AGdKsFRTHpacF6pa+wSOsTrdfRL7DYhwuPXv1crPJL4qwCh9
         4xGM4KnHdQt19gsu0X1vH8rdSl+VVHo8tfSbsWUAC3kYJ2SRyfA9KBc/rL9mrasInnwS
         NNIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IPDkYIvEyE/qyP0nBGC6LX7KO3XWc3FaHSsHlqDYEwE=;
        b=WW6kCmsxgkMCGJL4LKW+kwKbnyCXrH9zZhy44CgIMIUvtY/q2mycN9eGI9U8FRmECD
         cReWn6cdjqYnrm0HiM2aChVsniTwKAqTS91afs9ZHHsw6l3lLuBMnYOP7bd9iCG2priN
         ty0yeyFnRSpRCI5hUT8Rw6hPy7gipIZ9QYu1I8tC2mKrZaVhehGY/2ZMvH9HIS1y+ifp
         2w+LUBOMylaK4kPsUFR89E4zWEA3mR5BhPakNeS3L+99WeNtpLXuIYO9/dks3ZNZ2Tga
         uG8xAm7ugU+lE6AaM6Z4mnid/RiNlVoeqBy2hFfWUKEI0Ivs8cVsTU4XcPm46m4aShz7
         CQdg==
X-Gm-Message-State: ACrzQf3IjXN2xhOhsuEqjDWBNQcbtAzyLnH1622lZE6x9GmfUsksujNi
        cVfYXpi1639Helr/j2d34WzymnenVmU=
X-Google-Smtp-Source: AMsMyM4yomzDazhp/Lxda+5vo7sK5fe6omWbeVH7cg8q+hopAYRVcSb9uqXyfs2tpXMm4HLgSOdrGA==
X-Received: by 2002:a17:907:7f0a:b0:7ad:d150:c760 with SMTP id qf10-20020a1709077f0a00b007add150c760mr40874029ejc.409.1667831732416;
        Mon, 07 Nov 2022 06:35:32 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id k8-20020a1709062a4800b007ad9c826d75sm3544885eje.61.2022.11.07.06.35.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 06:35:32 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1os3Dn-0007XU-25;
        Mon, 07 Nov 2022 15:35:31 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: ab/make-bin-wrappers (was: What's cooking in git.git (Nov 2022,
 #01; Thu, 3))
Date:   Mon, 07 Nov 2022 15:33:40 +0100
References: <Y2RldUHTwNzmez73@nand.local>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <Y2RldUHTwNzmez73@nand.local>
Message-ID: <221107.86h6zax26k.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Nov 03 2022, Taylor Blau wrote:

> * ab/make-bin-wrappers (2022-10-31) 4 commits
>  - Makefile: simplify $(test_bindir_programs) rule by splitting it up
>  - Makefile: rename "test_bindir_programs" variable, pre-declare
>  - Makefile: define "TEST_{PROGRAM,OBJS}" variables earlier
>  - Makefile: factor sed-powered '#!/bin/sh' munging into a variable
>
>  Resolve issues with the bin-wrappers/% rules where "make
>  bin-wrappers/git" would generate the script but not "git" itself.
>
>  Waiting for review.
>  source: <cover-v3-0.4-00000000000-20221031T222249Z-avarab@gmail.com>

On my end I'm waiting to see what you and/or Jeff think about:
https://lore.kernel.org/git/221101.86edun5tgn.gmgdl@evledraar.gmail.com/

I.e. i can certainly re-roll with a one-line fix, but don't see how it's
useful to have a "make" target produce a wrapper that doesn't work.
