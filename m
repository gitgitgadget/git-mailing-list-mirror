Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AF32C433B4
	for <git@archiver.kernel.org>; Thu, 13 May 2021 17:43:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5086361352
	for <git@archiver.kernel.org>; Thu, 13 May 2021 17:43:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231197AbhEMRpB (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 May 2021 13:45:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231189AbhEMRo7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 May 2021 13:44:59 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B05F5C06138A
        for <git@vger.kernel.org>; Thu, 13 May 2021 10:43:39 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id h16so9723156pfk.0
        for <git@vger.kernel.org>; Thu, 13 May 2021 10:43:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9WJwmkzOsprGMaVBN39hO4gLS97x4Wd09rqyFIMPnds=;
        b=VH6T7KHU+PGqlvZaW5dgH686Fdd5vrH+YxulythrLvEC344b0+uH2zNQuKCNVxTWZQ
         I8mw/9E3wXXskdJNr+zh+gnigdOThs8QsC6mCNmfRRizQKoaj4EeV1cde1mU+lx29pHY
         VvXkuG4DlILwCx9zWGOd40HNVdhglhpV1I5cNXSLe03gUlx9krSyi8udKqorwzUDOYYH
         s8Sud1TIO1gDjUTm/aIA9seudbeTE4jCnzXnQdmHUuYEBCTGGKO4Lql6cDTluxs3i/7o
         QiBJwRugOKm1An5SFFLsVatTqznR1vfZHB7LTpHDg9NBc+uOFetscwtgwjZ2UWQLM/6e
         shnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9WJwmkzOsprGMaVBN39hO4gLS97x4Wd09rqyFIMPnds=;
        b=rOKY/qHBE7ssE+JTiakiG2TxjIzI+UwH9Jw414MgNOPgKtOJOzBHwkHRbYUoAz6Upl
         YL+0i49hM5IGkm7NEw0Y5/qd28LCpPWVJvQOEZNdWs3eHY/56k0kL2tP3vqAOL/oQFtY
         18gfZF7yBwhBGReABUf+js/uLGAg8fpXlgv6fPpdSIMu5fmNZN7b7BCW0F+IZ7wmv+py
         gQcm8f/CS0bySf3T5cRZ2yW5zDcWOq9YJCl+F9958Nnq5Re7tVMN1hljYLoqu7RbqYfE
         miHol+RsOcpGKWNz4pS/AsU75972TjF9QkcQXGOuRNQMPGsdTlCiQ4vdBLlsOaLVApXE
         Ce8Q==
X-Gm-Message-State: AOAM530SuDLQadQKRjwwDIf3Z+hmnTTWHLGkAZ2WT2786rdqm2JYNExu
        rYm/HwG6yRKn4kubaZS4DVds63YpsF10qzkQ2d8=
X-Google-Smtp-Source: ABdhPJwu3OnsZdoOI20y9skpGcmd46QmaUTqdiX9b9HHk8Lf13p8xTexX0e0vOnGygUDSRLL8oLaiUQPEMey84WBdVI=
X-Received: by 2002:a17:90a:9312:: with SMTP id p18mr6345536pjo.171.1620927819142;
 Thu, 13 May 2021 10:43:39 -0700 (PDT)
MIME-Version: 1.0
References: <20210512222803.508446-1-felipe.contreras@gmail.com> <20210512222803.508446-8-felipe.contreras@gmail.com>
In-Reply-To: <20210512222803.508446-8-felipe.contreras@gmail.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Thu, 13 May 2021 19:43:26 +0200
Message-ID: <CAN0heSoWPUvc+kQO2oXx1XnpOp7=jesGJ80XZm6EjTe15RxQLQ@mail.gmail.com>
Subject: Re: [PATCH 7/8] doc: improve asciidoc dependencies
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, 13 May 2021 at 00:28, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
>
> asciidoc needs asciidoc.conf, asciidoctor asciidoctor-extensions.rb.
>
> Neither needs the other.

> -ASCIIDOC_DEPS = asciidoc.conf asciidoctor-extensions.rb GIT-ASCIIDOCFLAGS
> +ASCIIDOC_DEPS = asciidoc.conf GIT-ASCIIDOCFLAGS

> +ASCIIDOC_DEPS = asciidoctor-extensions.rb GIT-ASCIIDOCFLAGS

Thanks. I was a bit lazy in a15ef383e7 ("Documentation/Makefile: add
missing dependency on asciidoctor-extensions", 2019-02-27).

We end up with some duplication. We could pull GIT-ASCIIDOCFLAGS into
some ASCIIDOC_DEPS_COMMON. But with just one such common dependency, it
seems unnecessary and overly complicated. We can pull out the common
dependencies when we actually gain something from it.

Martin
