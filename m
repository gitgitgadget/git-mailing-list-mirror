Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 217A5C25B0E
	for <git@archiver.kernel.org>; Tue, 16 Aug 2022 18:47:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236026AbiHPSrX (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Aug 2022 14:47:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232654AbiHPSrV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Aug 2022 14:47:21 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96AFC80E8A
        for <git@vger.kernel.org>; Tue, 16 Aug 2022 11:47:20 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id h22so8828291qtu.2
        for <git@vger.kernel.org>; Tue, 16 Aug 2022 11:47:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=7Em8ygZeF4eF7racmFnLqkC46Tz5aAdkQbyzyhne1Fk=;
        b=v4O1OWHR8oRU/qIs+Sd+F3yq0Nj29sKcQz6wI4najIVoHT+Ezfb7yMMiUOWpxQ1z4K
         Zcnzb5zz/8P/OFTGMBW4aNXocYPL/gGL1fwP27X1cqJ8uCxAOy6B4s6cufLCjvHqN+ls
         g4GSRilArOL19tvxEGm3RrtBZ/tA6VSdO9+P1VW5xWUWRFvRPj+8ZZDfGLmUDeamH71C
         UVEG2L9SwuO6rZiMWW8DqjZusEPgXnuWa4qNRBdvPqLR9opwYeneGtO5sn+fp0n70luq
         4FplyaqAa7hihJpWLsrU9KagaxnynY4eHOREdwSfGWAxhEwgNhsivjU+gTEX1qbXAle4
         +u3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=7Em8ygZeF4eF7racmFnLqkC46Tz5aAdkQbyzyhne1Fk=;
        b=z/jnwrQMDL1OLJhHxm8h96rtNrcW3wds+FuNN/fSaB9ZUDJbwbzCNfAiAJU7kevRcb
         8KR9psPUbLcFKM2gMasBKcn0/Xzqjdy+EcNJW/1sAuSstr3J28l6Q2Q0MsxCXfcdgcv9
         sNyb8REpl0LQbKrmDxbMGmiRFvf6q1UsdTiXhIPy5F6bPZ9KrZBCpG2ayZpIRMIDKI4q
         JyLUlL8LWjnXldjShPBNMUp0pB28uXO+Gz87oGjK6DMruP5StZjbGLEoGgTc7V35p5Jn
         ZTiUukWCnEJ8ATfIF6JMQdH5/UVunVj5yZUtC9eotXt0jmnxSCays1ICLQRNEm8BRqrS
         VOIw==
X-Gm-Message-State: ACgBeo12hc6DUS6n7zxPiNkixfslLn0ipYjLbOFG5Avq1DYgaA3/BrfC
        /xbAHXOOXpnZZ4EJXpeD4VCw+g==
X-Google-Smtp-Source: AA6agR6BtSbNXBalONLFeT3dsR/R3aaIEA/o7qFI4v1KVlrQmthpKJJB7xkxKYBx2M4RUWR3TOXFkw==
X-Received: by 2002:a05:622a:188a:b0:344:569d:5d18 with SMTP id v10-20020a05622a188a00b00344569d5d18mr10934523qtc.223.1660675639733;
        Tue, 16 Aug 2022 11:47:19 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id cb24-20020a05622a1f9800b0031ef6dd9700sm10859527qtb.55.2022.08.16.11.47.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Aug 2022 11:47:19 -0700 (PDT)
Date:   Tue, 16 Aug 2022 14:47:18 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>,
        Abhradeep Chakraborty via GitGitGadget 
        <gitgitgadget@gmail.com>, git <git@vger.kernel.org>,
        Kaartic Sivaram <kaartic.sivaraam@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Philip Oakley <philipoakley@iee.email>,
        Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>
Subject: Re: [PATCH v5 3/6] pack-bitmap-write: learn
 pack.writeBitmapLookupTable and add tests
Message-ID: <YvvmNnjQVkzMTgVs@nand.local>
References: <59b465e5a7817c145172f25e73ad807c7ba67e84.1658342304.git.gitgitgadget@gmail.com>
 <p3r70610-8n52-s8q0-n641-onp4ps01330n@tzk.qr>
 <CAPOJW5xBUaAJtOvrefwbXv_WDTLa=6PTL5kEoOpRQfqqFAx3oA@mail.gmail.com>
 <6s4n3600-q5p7-92sr-4206-non3s8rr3n46@tzk.qr>
 <CAPOJW5yUi471cfAXuXaM4BCzVsfZ15J1Era4NuEpxEnmY6md9Q@mail.gmail.com>
 <p69r38sn-1ppn-q66q-9089-59394pq78772@tzk.qr>
 <CAPOJW5zYndyqwyN8xOcRQnwebqXciY-25hNL3fU=V5ac8fCpNA@mail.gmail.com>
 <s714sq49-o13q-5417-0o21-6397s3646q9o@tzk.qr>
 <CAPOJW5yNQvO3quG91jjC9pT-+NNhJta+H_E2R9-1wUzR+rPXnw@mail.gmail.com>
 <68r08n47-9o07-351s-710q-786q69429q86@tzk.qr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <68r08n47-9o07-351s-710q-786q69429q86@tzk.qr>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 10, 2022 at 11:09:40AM +0200, Johannes Schindelin wrote:
> Hi Abhradeep,
>
> On Tue, 9 Aug 2022, Abhradeep Chakraborty wrote:
>
> >  I noticed in the 'setup partial bitmaps' test case that if we comment
> > out the line `git repack &&` , it runs successfully.
> >
> >     test_expect_success 'setup partial bitmaps' '
> >         test_commit packed &&
> >         # git repack &&
> >         test_commit loose &&
> >         git multi-pack-index write --bitmap 2>err &&
> >         ...
> >     '
>
> That's interesting. Are the `.bitmap` and `.midx` files updated as part of
> that `repack`?

They aren't. You can cause a MIDX / bitmap to be updated during `git
repack` provided that the flags `--write-midx` and
`--write-bitmap-index` are given to `repack`.

But the point of that `git repack` in this test case specifically is to
ensure that the commit generated on the previous line is included in a
new pack, and that that pack makes its way into the MIDX.

So removing that invocation of `git repack` means that the set of packs
would be unchanged, and the `git multi-pack-index write --bitmap` would
be a noop. That should rule out the theory that the existing MIDX is
broken, since without the `git repack`, we'd be using that MIDX in
subsequent tests (which pass).

Thanks,
Taylor
