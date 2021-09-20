Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02FEBC433EF
	for <git@archiver.kernel.org>; Mon, 20 Sep 2021 14:48:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C694E610A3
	for <git@archiver.kernel.org>; Mon, 20 Sep 2021 14:48:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240782AbhITOuK (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Sep 2021 10:50:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240821AbhITOuJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Sep 2021 10:50:09 -0400
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com [IPv6:2607:f8b0:4864:20::c32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7064CC061574
        for <git@vger.kernel.org>; Mon, 20 Sep 2021 07:48:41 -0700 (PDT)
Received: by mail-oo1-xc32.google.com with SMTP id q26-20020a4adc5a000000b002918a69c8eeso5924529oov.13
        for <git@vger.kernel.org>; Mon, 20 Sep 2021 07:48:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=dOcRMPrZE95pl9I89SKIRFQPpVIeadDYmBvQ7qHfZ+8=;
        b=RhbpfMtRZZ9svKLsj1axL4B64sj3cgHkzKZHl7DxEHJqq8VaGsPcH4xb8c5SZDdXWu
         /nwjnmiwXsnD45PlvBOq3exBSCUtMSiY4ZGy/63ziJtBnQt2mQ5UE3HBFNbi/MiNXoUh
         qze4wMxWxphCms2djt7hgFrpcDCkBr9VA0qfxunizU1W6BwzvizaGhw9fL1W3yAqKFof
         ZKCxV0CI1v1uJj1BAOQBlSN3wYCUn7jqnTadSVMr11cSqt+uqqdwd5D3c8bliCaM6zOZ
         j4FEviWdtCN2i55I2LBPc8M6lP+48LGwAum7aVgV2vS+8FRIgkSR/779uAQIq3PTARRP
         hbZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=dOcRMPrZE95pl9I89SKIRFQPpVIeadDYmBvQ7qHfZ+8=;
        b=xaGnCG5mptsRWDGR4W+6pFotqlkUzBBbQZOHV1xoa+z1P+GiiKCrQQFsKn81TWU5hD
         y9s5hAfeAra2xhii37UaXUjDYccDBXg5dXR5zZ9V4RZ56TJU7D7a+18L/mAgFIHCJmfU
         2G9zhtodfBXX208MBu3f1Vxz1cbpwsPXaPV/J9MN+39CKjEeaADOxBkQ2c2ictoGW5yK
         7IHbnjglUmqxqgwCw31tS9OQLOxcamFs9HijvWfOqU8zTwspz2tepPuh5InBQRtPSvgY
         fVbT0THWCOsjaIdlo8gVHUXtwCQMZPOYG3DrwTUT5my8uDtGutBebrhqctU6wUvXh0jN
         /p2g==
X-Gm-Message-State: AOAM530DkjIAPGSUezNLOIJRMXY3n7Jop3ASXdypji6+y80iHenqprrN
        5TFbLzqkLpFu1Y8zRPWoaiZUxPbeeFeod8MZcChYAQc8gMnCHg==
X-Google-Smtp-Source: ABdhPJzLgWHdrptMUzbH24PzQPyDSOjqOO+lMMSN4wtj5A2mMrbjKEKRJD1RMp0rx4hj/NFAPVJoEYXzozOSJbkaJxo=
X-Received: by 2002:a05:6820:555:: with SMTP id n21mr20225061ooj.56.1632149320648;
 Mon, 20 Sep 2021 07:48:40 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1036.git.1632006923.gitgitgadget@gmail.com>
 <b634136a74b37a6f73bc3038f79031e040423883.1632006923.git.gitgitgadget@gmail.com>
 <871r5kd6dg.fsf@evledraar.gmail.com>
In-Reply-To: <871r5kd6dg.fsf@evledraar.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 20 Sep 2021 07:48:28 -0700
Message-ID: <CABPp-BEqiYKAqP1QvMB1rqqQjiP7Yn0tbhaHb7OdVfcpaE3hjw@mail.gmail.com>
Subject: Re: [PATCH 1/6] t2500: add various tests for nuking untracked files
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Fedor Biryukov <fedor.birjukov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Sep 19, 2021 at 6:47 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
> On Sat, Sep 18 2021, Elijah Newren via GitGitGadget wrote:
>
> > +     test_create_repo reset_$1 &&
>
> s/test_create_repo/git init/ these days (also for the rest).

Ah, from your f0d4d398e2 ("test-lib: split up and deprecate
test_create_repo()", 2021-05-10).  Interesting history; I'll
switchover to git init.

> > +             mkdir foo.t &&
> > +             echo precious >foo.t/file &&
> > +             cp foo.t/file expect &&
> > +
> > +             test_must_fail git reset --merge work 2>error &&
> > +             test_cmp expect foo.t/file &&
> > +             grep "Updating.*foo.t.*would lose untracked files" error
>
> The test is ambiguous about whether we complain about foo.t/file, or
> foo.t, if there was foo.t{file,file-two} would we complain just once or
> twice?
>
> I think it's just the directory, but probably worthwhile for the test to
> make the distinction. If it's a "a/sub/dir/file" do we complain about
> "a/" or "a/sub/dir/" ?

Yeah, I'll switch it to grep "Updating .foo.t. would lose untracked files" =
error

to make it clearer (where I'm using '.' instead of attempting to
escape single quote characters appropriately).
