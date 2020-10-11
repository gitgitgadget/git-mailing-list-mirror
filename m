Return-Path: <SRS0=tPyM=DS=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 653ABC433DF
	for <git@archiver.kernel.org>; Sun, 11 Oct 2020 08:09:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1CA942072D
	for <git@archiver.kernel.org>; Sun, 11 Oct 2020 08:09:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BW7O76ki"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729168AbgJKIJP (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 11 Oct 2020 04:09:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725844AbgJKIJO (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Oct 2020 04:09:14 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3755C0613CE
        for <git@vger.kernel.org>; Sun, 11 Oct 2020 01:09:13 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id p13so13725798edi.7
        for <git@vger.kernel.org>; Sun, 11 Oct 2020 01:09:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=f2Igv92gl9AeZFZasnlOz3HwsMoNn08c2uo3rOint/A=;
        b=BW7O76kin9VM0ygVHutItp0iVpm5FCTpEjaLQzt08Qsjw8m/1lz/E0LBMu9fB4owwO
         eZkd5P/BivuPg98bc6QK1DPGasHu+9Ynx+KrFco0lvzf3cIXu5rSf/8v87vCcf2SaJKA
         x0V1U9E4y+pAi2BdZvSaiIvsO1KUlGQwS3766/ujIEjF5+nXWKEYWrZ2Jlj1HGDTZ2Gg
         LR7hM2lrKbOhHADOjA1GfVN6Zkh1nlJR2P+JBj9KBVYkA11zORXI8T/MQ/7YQqDBamqq
         00WKWqVCRFQ0wv2hZWiT+vJP3LYPy4ZJoxyeH772Cjsj5H5NMyURACQdEv22FGomGUYa
         aTdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=f2Igv92gl9AeZFZasnlOz3HwsMoNn08c2uo3rOint/A=;
        b=UxQWnhmmfJXlF7dyAR24yOOyonW9oWqONM/sYkD5gFUn6krRfSTQokoeCrtvTlulS5
         en6yNDmDHlcm4gD7DixLXkVzmBx5T+nIi839f1Kwlsi6RuwGxAJALH3GJXEw7vDEoiOF
         dl/MluKm2bq8N6Eq77P/5yWpThhavvmhXvtuwDUskmohYAKEB3iww4ZMryl/W3oxgKby
         GwD0gH18vTRKyog71GsAQSJU8MeiyGlhobm7bOBS5GF+oIE59Hr/Snd4BtrNXhCxs2WZ
         JUELCNtN/LIfGis5WMLOH4ip2QP1h7uQEIWtFh3+Fmh3WTOejyh/hQGfMmcEboejAqbH
         xr3g==
X-Gm-Message-State: AOAM530Wj9zv7JBqcIqPwZCb+WnrfhGQyNgaksa38IAP69tsqe63zRkY
        UnEp2ufwzWwHt1QVbyvbzTUrijjPxi52IDN7IuPNKuCW3FE=
X-Google-Smtp-Source: ABdhPJxLPzR9VWPsIP51VDI+jPLf3YWAyR/2fe9UAUl7ZkdeYNTWC49f1OxsGYUDWkkJmlXDw7iXDnsgTprZR5e5b1A=
X-Received: by 2002:a05:6402:384:: with SMTP id o4mr8084474edv.387.1602403752569;
 Sun, 11 Oct 2020 01:09:12 -0700 (PDT)
MIME-Version: 1.0
References: <CAPSFM5eK1RFTbdTbF8dHMzcRh1SnSfzqh_5re22qS=KFoVRNJg@mail.gmail.com>
In-Reply-To: <CAPSFM5eK1RFTbdTbF8dHMzcRh1SnSfzqh_5re22qS=KFoVRNJg@mail.gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Sun, 11 Oct 2020 10:09:01 +0200
Message-ID: <CAP8UFD1m2zXUm1PXmJKW2MxA9XZVUOkBFA62jLP7jx6_DCYZGw@mail.gmail.com>
Subject: Re: [Outreachy] Introduction
To:     Charvi Mendiratta <charvi077@gmail.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Charvi,

On Sun, Oct 11, 2020 at 1:13 AM Charvi Mendiratta <charvi077@gmail.com> wrote:
>
> Hello everyone !
>
> I am Charvi Mendiratta, one of the outreachy applicant. I would like
> to work on the project "Improve droping and rewording commits in Git
> interactive rebase".

Welcome to the Git project and its mailing list!

> Till now I have installed and built the project and going through the
> guidelines of patch submission and project details .
>
> Also, getting on micro projects
> https://git.github.io/Outreachy-21-Microprojects/
> Firstly to get familiar and hands on with the patch based submission I
> am looking to start with one of the micro projects that is "Modernize
> a test script".

Great!

> These are test scripts  t7001,t7101,t7102 ,t7201 that require the same
> changes of styling . I would like to once confirm if anyone else is
> not working on the same ?

Someone recently started working on modernizing t7001. You can see
that by searching the mailing list archive:

https://public-inbox.org/git/?q=t7001

You will find:

https://public-inbox.org/git/20200925170256.11490-1-shubhunic@gmail.com/

About t7101,t7102 and t7201, yeah, it looks like they could be
modernized a bit, and no one is working on that yet. So feel free to
do it!

Best,
Christian.
