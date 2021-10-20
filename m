Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB5C4C433F5
	for <git@archiver.kernel.org>; Wed, 20 Oct 2021 14:30:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D380D6138D
	for <git@archiver.kernel.org>; Wed, 20 Oct 2021 14:30:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231180AbhJTOcm (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Oct 2021 10:32:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230268AbhJTOc0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Oct 2021 10:32:26 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6589C061760
        for <git@vger.kernel.org>; Wed, 20 Oct 2021 07:30:11 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id 188so24825706iou.12
        for <git@vger.kernel.org>; Wed, 20 Oct 2021 07:30:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=LJRS+l3pt6+Fnn0TgdcK/z6AsbH+qSNJJu2Nm0kKIS8=;
        b=rvwOFW/MC4FnG/T/LgKOaO/1fc12j7cv4sWPSaSbyJN9PYuMLUJ41w5aFheL/+pHZQ
         xR+DXvzLdPTGf+89tTc/XkCm1bzP2NO1x3VLBNux2RU0yoAn/Cz6J58GOeXPbc8HuZEk
         lU7d+Y46BO/hY+nxY5Iuh4zVGnPot8VqzWiWJNl8k20FnKI9rW7aJ/lPDRLCpYchEZXs
         tZ0K8f+QpEduc8aNapXrxKiM/vNvFw+WJYJgylyxI85d2jsuLbBAEliOMl/gFo/gWKZy
         3KORpgGaDGsgeJUgcWDb4lP39ZdaW/6uUe/oof+OasOOcwbm9KZQGW4tdGypW4eBzIcj
         /ckQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LJRS+l3pt6+Fnn0TgdcK/z6AsbH+qSNJJu2Nm0kKIS8=;
        b=lDuC3obVWl85SXjtQt+DQmzPGQ0T8xMIMnzNMzePKbmSBPOpujzUNC1YmzHLJAni92
         DtqoYm+HrRz3OfsEBiU7KTOvW9gCuUXfc+IHCrsibBUnp9RyiPSCjZdFSBBZsQub8nxy
         2xlievZy3hILy5agEItC0QrPgDjGzPoLWxWtDBIZW8FAPHptqW/Z8nELRm1Rs00xSygG
         suIshZZB1Hr/sTrEvNSOBs4ld2KpSKZsbu9AJO+wLKF+PO2trxOwHpEKNy4ugRhWL9mX
         AAFnrTN9qt4+yMwvEo2fxXRWWbPz3B4IC6HkPrJYTpl9edAUbcbIa7aBeK+aHZvaXNgs
         FlCA==
X-Gm-Message-State: AOAM533HysMZyYeXSB46A+KsDL87wtRUpRw7d43LjP21a7pXR3sHT4cU
        srd/exwhu0M9Abqi1cWHedDOYA==
X-Google-Smtp-Source: ABdhPJxStZ48HqlfynwosFDuLgd3tu6tRaI/qVttMf6oPNcd4dGrsEr8BUCpPMaHw2QnuFMYpqDtSA==
X-Received: by 2002:a5d:9283:: with SMTP id s3mr67298iom.75.1634740211145;
        Wed, 20 Oct 2021 07:30:11 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id u2sm1074701ion.54.2021.10.20.07.30.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Oct 2021 07:30:10 -0700 (PDT)
Date:   Wed, 20 Oct 2021 10:30:09 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: What's cooking in git.git (Oct 2021, #02; Wed, 6)
Message-ID: <YXAn8d/Pwz/4ro5c@nand.local>
References: <xmqqfstdr8b5.fsf@gitster.g>
 <YV5aaD418SyZqS/1@coredump.intra.peff.net>
 <YV5dmkkuCqAY2qqG@coredump.intra.peff.net>
 <YV5yi+AejPGO9qOi@nand.local>
 <YV/BMkZrj4xQyvUL@coredump.intra.peff.net>
 <nycvar.QRO.7.76.6.2110080946060.395@tvgsbejvaqbjf.bet>
 <YWC49+xCh+zum8Ms@coredump.intra.peff.net>
 <nycvar.QRO.7.76.6.2110201416390.56@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.2110201416390.56@tvgsbejvaqbjf.bet>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 20, 2021 at 02:27:30PM +0200, Johannes Schindelin wrote:
> Hi Peff,
>
> On Fri, 8 Oct 2021, Jeff King wrote:
>
> > On Fri, Oct 08, 2021 at 09:51:33AM +0200, Johannes Schindelin wrote:
> >
> > > FWIW I have set up an Azure Pipeline to keep Git for Windows' `main`
> > > branch covered by Coverity:
> > >
> > > https://dev.azure.com/git-for-windows/git/_build?definitionId=35
> > >
> > > It essentially calls into this scripted code:
> > > https://github.com/git-for-windows/build-extra/blob/4676f286a1ec830a5038b32400808a353dc6c48d/please.sh#L1820-L1915
> >
> > Do you have any objection to adding something like the Action I showed
> > eariler? It would do nothing in git-for-windows/git unless you set up
> > the right environment, so there shouldn't be any downside.
>
> No objection. I'd just ask to use `${{github.repository}}` instead of
> hard-coding `peff/git`, and to really not run the workflow unless
> configured. So something like this:
>
> [...]
>
> I am very much in favor of having this in git/git. Do you want to provide
> the commit message, or do you want me to shepher this?

This all looks good to me. FWIW, I was planning on picking this up
myself, but I'm happy to have been beaten to it ;). The only thing
missing is having a project for git.git set up on Coverity's website.

I'd be happy to look into that if you wanted to polish this up and
submit it. We should be able to proceed independently, since this will
all be a noop without setting the various Coverity secrets inside of
git/git.

Thanks,
Taylor
