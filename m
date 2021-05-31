Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B28F0C47080
	for <git@archiver.kernel.org>; Tue,  1 Jun 2021 00:02:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B1E160FF3
	for <git@archiver.kernel.org>; Tue,  1 Jun 2021 00:02:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232356AbhFAAEg (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 May 2021 20:04:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232081AbhFAAEf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 May 2021 20:04:35 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEDCFC061574
        for <git@vger.kernel.org>; Mon, 31 May 2021 17:02:53 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id b17so15225710ede.0
        for <git@vger.kernel.org>; Mon, 31 May 2021 17:02:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=kuUzmbeOlFOhns2ffGspUJ5nMVvetWJidasggTJTbLs=;
        b=JQMqenDNfN+IHY0CeAa6X+UD0Jfv/scWrzk2bbw8jtqgE8tJu0TihvhlKKScSTh48a
         yC180b98MCc3pGDsa50NHJkQ6bFoi64aa7/yrS8y0y9ozYWs8faSgpIMsjL0nX4CIz1O
         jhBhG+D7edHsc9mO5E2fM2OfjCRahhpjxqNYmV8FrIUqujiRHMRbOQCMWfosmxM/gs6c
         FH4M9IbpiLebyttq1GUzmdI3lmXBTzJijs9AMrHtCzm4WO6bWb75KKghGTr6SwPGMQIM
         NtXPGCf4Gx/BtfJ4r1p0xa1RUmh6h7kvdKfOrk4YaOwY2tzMLgjBBRt89KQMdT7roRXe
         ckRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=kuUzmbeOlFOhns2ffGspUJ5nMVvetWJidasggTJTbLs=;
        b=iZ1GB56Iw059vNB67u4+xlZqeU3DP3dorDVGi7QoC9EbASBQEpVMDDvESMb2AObZHY
         hNe99TJbaRN9sjwemTL5VIRzRKHG1ED1l5Fe/eI0vBtJtRl7FgbWPU2jq4Qi65+OY46v
         khmAjEgLTu7DWtiEgFTPQyCPYW/fHh3eajo9xBxTrvOxw52pfH4bN4fI/z65zXAqEgZH
         lku1UafL5766QopPN1EftkUNmzzAprxRPf7DlsX+B6teoRqGKdzsahxBzZ7OkFfgItIR
         CplnQkXnnxjOn+3mbTVzRAydl78tyHITEsGrSL530Ead5do3g6DZWqdrl2AX2JbqOSuQ
         YFhA==
X-Gm-Message-State: AOAM530CdIwhM2rcZwJf+v1lCm6tM7mp6E9O4l48Yl3Ko77/t/b4ISjs
        U87UxlfYXP7G4uuRFkDcBMTf+/PdYOg=
X-Google-Smtp-Source: ABdhPJyUlwCnEn9TB5u7Z8RTRNovbvVFcdu1N81InjCOrFPkpt8tvfMia5JrN4tAcpyhNkYRoZAMKQ==
X-Received: by 2002:a05:6402:138c:: with SMTP id b12mr28416012edv.268.1622505772116;
        Mon, 31 May 2021 17:02:52 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id e25sm4433346eja.15.2021.05.31.17.02.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 May 2021 17:02:51 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Han-Wen Nienhuys <hanwenn@gmail.com>
Subject: Re: [PATCH v3 00/22] Prepare tests for reftable backend
Date:   Tue, 01 Jun 2021 01:57:51 +0200
References: <pull.1008.v2.git.git.1619519903.gitgitgadget@gmail.com>
 <pull.1008.v3.git.git.1622480197.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.5.12
In-reply-to: <pull.1008.v3.git.git.1622480197.gitgitgadget@gmail.com>
Message-ID: <87pmx61mfp.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, May 31 2021, Han-Wen Nienhuys via GitGitGadget wrote:

> Rewrites some tests to avoid direct filesystem access.
>
> Introduces the test prereq REFFILES to mark other tests that depend on
> specifics of the files ref backend.
>
> changes in v3 (relative to v2 from Apr 27)
>
>  * address avarab's feedback.

I've looked this v3 over, and I think this is ready to go, and would
like to see this get merged down to next etc. Any minor quibbles I might
have are far outweighed by a desire to get this whole topic back on
track.

A bit more detail:

Per my feedback on v2 I'm not sure we're getting the right trade-off of
over skipping tests v.s. asserting new behavior, but as noted there
we've got the chicken & egg problem that we don't have reftable yet, so
we can't assert the new behavior, just discuss it in the abstract.

So our goal with this shouldn't be to get this perfect, but just get the
tests closer to not being file-backend specific.

Once we have this topic in "master" and a re-rolled reftable on top we
can always (and I plan to do this) see where exactly we end up differing
under reftable v.s. file backend.

Maybe that'll result in a different approach for a few tests being
changed here.
