Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CA7DC433FE
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 17:18:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 718BC61354
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 17:18:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242025AbhI1RU1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Sep 2021 13:20:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242026AbhI1RU0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Sep 2021 13:20:26 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E3A6C06161C
        for <git@vger.kernel.org>; Tue, 28 Sep 2021 10:18:46 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id x27so95913451lfu.5
        for <git@vger.kernel.org>; Tue, 28 Sep 2021 10:18:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GuKwViF4YPaADlVoBTPBfEeX/xkKJvUXrfsIJy5PhLo=;
        b=Uvw2P637tVlPSK65XkyQVId2i2MxvCH4+08oPAe0ecLtf/0gBinZDNBagOe0OYlHZE
         H8ih8JCr+mR/uBMr/b0cyj1HOWgqBuQ3MY1ab/4Xrrmz/HYDczDPZZ25OxhLGPAewd+l
         2bP+as2QVCxFd9QrdxUJV6+Gt2A+4tvLsC45MlgVHqEnYI/BXohl8I5yuoOzWn2WPB0h
         0SJV7V+eS+/wFU72arWfa4phckhQQzA51MvbkcCab7Q4cN2h265+/CXqMnJQcoY57xae
         LyJG18z5cm2ezJ/MWRonovyOIqIC1TqDAuBJ8AYuw/cjGq4kUvO0Fi5f+EtgDA3Bvs1z
         R9+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GuKwViF4YPaADlVoBTPBfEeX/xkKJvUXrfsIJy5PhLo=;
        b=s869IGrax7uk2T0pNKUNKFLhngMg0ieRnSPLai9PsclJrKv+Fp8hKnXHeGvnWcm0Sg
         DAoJNfRDCgV8Y+y11OAfGD1iQgmW4GLa2LAfEkdu4K4HDoXb152IzjBMkirs4Y07H++k
         Do+qwP5uGObyjoixHdOk5d0wCzHdiJCHIrKVDm9aWNd4F1m6n0bwPNbfDacARsme6oUr
         yOk91qEiBNyrNNxx22vegm6Wq7pqrGjTuMH0U2yI312ZSMGb3vd7fuWNKl2/ExO3Dzgw
         1D/1T4YXp8/cb6DG1gZO7QJRO93iKv9EDvQ+VtuyL5i+mZQGGUnc4JCSVMkr/Ywj0BM1
         +8pQ==
X-Gm-Message-State: AOAM532dsYZQ48GC60pxlv5cLalBL2oF7vQLapdhTQh35Osnv5ITgD5j
        +YYA62JvEjk6K7bKwUZoGWHjRmk2PBacr8AAPg8beg==
X-Google-Smtp-Source: ABdhPJz1d1uhV4dw8tPBtm7YMUpAxF8WozXhJby5RUS2IXBhjpGLeYMSTvl//Dt3BDTiYHWQ3z1uY+ReIS+YE7L7IZo=
X-Received: by 2002:a05:6512:3c8c:: with SMTP id h12mr6783729lfv.640.1632849524837;
 Tue, 28 Sep 2021 10:18:44 -0700 (PDT)
MIME-Version: 1.0
References: <8c266e58dede247b2c97ad2870c7c24c3b35ed55.1632848754.git.matheus.bernardino@usp.br>
 <CAPig+cS1xrXHBbxwcwL_WKdnU9_MSTZffMtn3FxdUGuQX85XbA@mail.gmail.com>
In-Reply-To: <CAPig+cS1xrXHBbxwcwL_WKdnU9_MSTZffMtn3FxdUGuQX85XbA@mail.gmail.com>
From:   Matheus Tavares <matheus.bernardino@usp.br>
Date:   Tue, 28 Sep 2021 14:18:34 -0300
Message-ID: <CAHd-oW4fNNp+A_fFeqbTeOwDV+ss0-0x=rt0HOi2m1txrh+1ZQ@mail.gmail.com>
Subject: Re: [PATCH] grep: demonstrate bug with textconv attributes and submodules
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 28, 2021 at 2:16 PM Eric Sunshine <sunshine@sunshineco.com> wrote:
>
> On Tue, Sep 28, 2021 at 1:08 PM Matheus Tavares
> <matheus.bernardino@usp.br> wrote:
> > In some circumstances, "git grep --textconv --recurse-submodules"
> > ignores the textconv attributes from the submodules and erroneuosly
> > apply the attributes defined in the superproject on the submodules'
> > files. The textconv cache is also saved on the superproject, even for
> > submodule objects.
>
> s/erroneuosly/erroneously/
>
> Also, perhaps: s/apply/applies/
>
> > Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
> > diff --git a/t/t7814-grep-recurse-submodules.sh b/t/t7814-grep-recurse-submodules.sh
> > @@ -441,4 +441,107 @@ test_expect_success 'grep --recurse-submodules with --cached ignores worktree mo
> > +test_expect_failure 'grep --textconv corectly reads submodule .gitattributes' '
>
> Here and in remaining newly added tests: s/corectly/correctly/
>
> > +test_expect_failure 'grep saves textconv cache in the appropriated repository' '
>
> s/appropriated/appropriate/

Oops, I should have been more careful with the writing. Thanks for
catching those!
