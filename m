Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF97AC433EF
	for <git@archiver.kernel.org>; Mon, 20 Sep 2021 15:15:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A0875610A3
	for <git@archiver.kernel.org>; Mon, 20 Sep 2021 15:15:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236587AbhITPQz (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Sep 2021 11:16:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230165AbhITPQy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Sep 2021 11:16:54 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C98BC061574
        for <git@vger.kernel.org>; Mon, 20 Sep 2021 08:15:28 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id t4so43798501qkb.9
        for <git@vger.kernel.org>; Mon, 20 Sep 2021 08:15:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=H/MMQSJQB/xytJTh5Q50+nwhusuCL/pls7c/6HFgsi4=;
        b=Tg6kX1aZ1iyOiUG0ZtJ7/qClFyhgpRHyCwrTszY4Z1J7FZ+CrgxN6gfFRcIFCQS4r9
         Hd7sY2jMk6wgw4sh7EpjCGv6LoRwFrqH70iKUKii+Xaf+7G72gMpG32sbSWH+/VmpM2z
         UasnexUZok/ZVmjGASVBCOJR6BV3mpD1pYzecjzsj9f3oFukAeCP6X5HwfOslOT5lkLq
         2ppaAURiOgwNIHrdK3jO1erY3OkN05vganYcxPo+Q+bVhwJpaaJ0dmbULR0K64gZbg4y
         CcGcOQ5Ik32R3PbdQ5gxzxy5mk1q9qmzwALzgpHEcWwLu+QzfSWHEJZnPKdFJEVyNuS7
         GMNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H/MMQSJQB/xytJTh5Q50+nwhusuCL/pls7c/6HFgsi4=;
        b=RFzULY9NOVBIBc93McQ8EMrzeYcXhc1Ke5oo7/8jiKBbVw+tSmmA9Vrbo7BGTIFqJL
         PPW038HnvbS8pK2J7X0VpdLOfQbCASJYqZY7OCw8PtPZAcsRwu/Ho7V/rxFJfbUxVnv8
         M5pPqNdLEO9FQXypZf2c5uxnYnuhLxb54eXMr6okfqM4sik+A/fxv7JH3Jx2KpRmtrhc
         UUQjxaie5W3lLRuYSDhWIuUiHWobLVhe9LPvFxJFHJvLqTVNMWHWFiwQH0QujVDPV7tA
         gwVHS8HkOwpL2qcSprNkvfQkkokIEMGRZ8UIG2yUA/MWzSuYzqAiwwFhK7RE8vq3S+AP
         zfgA==
X-Gm-Message-State: AOAM531Dv99RqniN9FGDDsNede5pdbU+UgSGGtxio3BEqxqH5UTjFcrN
        jr2Jchtq2rmeHwp00Prd1B6osn/qxr5KpOMcCSnwvalSz1M=
X-Google-Smtp-Source: ABdhPJxUQife1xWcblu88br30pmpPupluaWfxvHlApokLxvY+bytRJGmfpvfKxNKB7++yLzJ6TDUAwbiGysYUu+hxMI=
X-Received: by 2002:a25:6902:: with SMTP id e2mr34621233ybc.526.1632150926643;
 Mon, 20 Sep 2021 08:15:26 -0700 (PDT)
MIME-Version: 1.0
References: <YTGLLQCvlnT17jo8@nand.local> <YUYPgF6tRQ5ERYWL@nand.local>
 <CAOLTT8SbS9-grLnn2TOL6XdR3yMkd=YrUnq=FLCo6r03Fqbg9A@mail.gmail.com> <CAP8UFD37tQdbcgsMJPYE7KaO1ajwznFRUrG=9=S1WNNM-YZsqw@mail.gmail.com>
In-Reply-To: <CAP8UFD37tQdbcgsMJPYE7KaO1ajwznFRUrG=9=S1WNNM-YZsqw@mail.gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Mon, 20 Sep 2021 17:15:14 +0200
Message-ID: <CAP8UFD2SsZyckX0tpCN-16BJ_mX6iHgd+VNSvfr-kirq2knVyg@mail.gmail.com>
Subject: Re: Git in Outreachy?
To:     ZheNing Hu <adlternative@gmail.com>
Cc:     Christian Couder <chriscool@tuxfamily.org>,
        Taylor Blau <ttaylorr@github.com>,
        Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Taylor Blau <me@ttaylorr.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 20, 2021 at 4:52 PM Christian Couder
<christian.couder@gmail.com> wrote:

> I will also prepare soon a page with a few micro-projects. Of course
> more micro-project and regular project ideas are very welcome!

So here is the page:

https://git.github.io/Outreachy-23-Microprojects/

It's very similar as last year's page
(https://git.github.io/Outreachy-21-Microprojects/). The differences
are:

- added new "Replace a run_command*() call by direct calls to C functions" idea
- removed "Unify the meaning of -dirty between diff and describe" idea
as it looks a bit complex for a micro-project (though I can add it
back if someone disagree with this opinion).
