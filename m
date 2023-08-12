Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D124BC001B0
	for <git@archiver.kernel.org>; Sat, 12 Aug 2023 00:13:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236983AbjHLANF (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Aug 2023 20:13:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230500AbjHLANE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Aug 2023 20:13:04 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 233861FDD
        for <git@vger.kernel.org>; Fri, 11 Aug 2023 17:13:04 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-99d90ffed68so33450966b.0
        for <git@vger.kernel.org>; Fri, 11 Aug 2023 17:13:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691799182; x=1692403982;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NpzCCM6brO+ye4jeih0vJGmIRPtYG56hSei9GnEHMVw=;
        b=gKgeDpACcpDzxiDS0/mIb4amBVgIlpHxUq4uYN7egL3AZsHEphyqhXZiMM3BjQd8GN
         4zY5Tmc9liHjPGDjcc2Yxch2xnMmkSWBeprsqGNX4eacvQsrWEiTm/wKB42RHFXgrnFs
         gpdCLRzX26fw2gckOxooo3jUgMfbq7+lNjOur3Tzl23Skmg+7271ld7LoFWBzBfJrE/2
         q94rPoFRdAwDIqPq+TZfWeMgxh4i0mcl+IfiS1ReBOkMif4Q/ZMd/Eyu951BD7y7QmOO
         iHDM0Ux+P7DaawbIWIdhBWx5yifuMLDJfiOKKvS07Ic4pzK1ExsCNCdJ1l7wvCy/kmWR
         M6+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691799182; x=1692403982;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NpzCCM6brO+ye4jeih0vJGmIRPtYG56hSei9GnEHMVw=;
        b=amI+PEh8Y/mKkoOG5KnzfSsR+dExRV4hD3eTjWCcnEBL0PWyiNNRNRiQDGTz2tjP/c
         b4A3rQqX0d46aXvBw7yqBr50Q40PdLKjyeVrBW4QpwMZrNcCfV8yclE2XsxhnDlFf0yL
         IzKVhhizaxF2Bj7n477d1ao5dqWzsOG8snrs7cg6c/QyjAknLk8YfFGW3f62g/IX2IBm
         Ypv3ffI0iDctETDTZOFtVoN0Dt5lBIFFwd5TiHlaniwlLXAn4Rsr3lY/LT59zk3GkdLV
         xur55a7wnG6It/Za+M9jrbeo6eYIE6K2es2KTxKPRoSYIza45HP4+t75JmNdH+eu0RUE
         GiJQ==
X-Gm-Message-State: AOJu0YzvCjBh2FVUzu87eBqsKATba3DTALPDaDZlVv3xdBfgx0XUzUm0
        TGtYeHl57e0VGvu3QgJBQtohzSIYiBXZktJOeN+UZu35f0uPWg==
X-Google-Smtp-Source: AGHT+IFDckgktaxmg8PNtYmqu4mnQ6wkegalmB4HlYlbxvRx/wlAakNnDvcgdm98o0pIT/zqkalJGjYD9A6kpDIuL7M=
X-Received: by 2002:a17:907:9811:b0:98e:4f1:f987 with SMTP id
 ji17-20020a170907981100b0098e04f1f987mr8474164ejc.3.1691799182248; Fri, 11
 Aug 2023 17:13:02 -0700 (PDT)
MIME-Version: 1.0
References: <20230724085909.3831831-1-christian.couder@gmail.com>
 <20230808082608.582319-1-christian.couder@gmail.com> <ZNQI5vpcoXbkkPWa@nand.local>
In-Reply-To: <ZNQI5vpcoXbkkPWa@nand.local>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Sat, 12 Aug 2023 02:12:50 +0200
Message-ID: <CAP8UFD1HhvaAV2=_tYXQOsi57qq6U6Hp1-LEBCaM-9n-mmKHrg@mail.gmail.com>
Subject: Re: [PATCH v4 0/8] Repack objects into separate packfiles based on a filter
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        John Cai <johncai86@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Patrick Steinhardt <ps@pks.im>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 9, 2023 at 11:45=E2=80=AFPM Taylor Blau <me@ttaylorr.com> wrote=
:

> I took a look through the range-diff as well as the patches themselves
> again (skimming through the last three, which are much more
> straightforward than the preceding ones).
>
> Everything looks good to me here, and I think that this version is ready
> to get picked up once we're on the other side of 2.42.

Thanks again for your review!

> I left a couple of comments throughout, but none of them merit a reroll
> on their own. I think there are a couple of things we could easily
> ignore (marking parameters as "const", etc.), and a couple of things
> that we should probably take a look at after the dust has settled here.

The version 5 I just sent should fix all the small things that you
found in your review.

> We *may* want to fix up the test_must_fail invocation that has the
> environment variable on the left-hand side instead of using
> "test_must_fail env", but I don't know for sure.

This is fixed by squashing Junio's 'SQUASH???' commit in version 5.

> I do think that we should take another look at disabling the bitmap
> machinery when given `--filter`, but I think that, too, can be done in
> another series.

I agree. I plan to do it later when this is merged. I think it would
make it easier to use the new --filter feature, but it would require
changes in code, tests and documentation, which can be done later.

Thanks,
Christian.
