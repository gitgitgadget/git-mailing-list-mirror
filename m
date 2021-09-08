Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEF76C433EF
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 00:54:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CBF8A61131
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 00:54:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345432AbhIHAzq (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Sep 2021 20:55:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343915AbhIHAzp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Sep 2021 20:55:45 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8D2EC061575
        for <git@vger.kernel.org>; Tue,  7 Sep 2021 17:54:37 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id y34so1368834lfa.8
        for <git@vger.kernel.org>; Tue, 07 Sep 2021 17:54:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=iVAIHg10e75PxwpopXSb/8pDNklV1TMQwk113eJlU/U=;
        b=dwF/l76sEPvw15T8aHb2LtBxxjaeiGkjD1opQaPrGMWlY+SznycuHlivdcIGAPdG8y
         5DSx/jqopu6JsO0S1riAk4UE/Ib2sahAxSqRE6VBuJIGvK7vpQkMsHPiJ+wp8awVq9D5
         hGk3P+436coIOEGc8+0DviMUHN9g15ckPaWDAMjCU/27x/1OVcIxu0bY1zGgs+HTIibs
         uoG4WeCVvdRwP5hbsw3HsZSJd6ZWCR/sWZrWIrA/SiqDV4wzUx0102E0h6zv6IdGner7
         wb5DXG/625Y2mNqgbnBSiMosXBe6AZh8Dz8a8R/wFZ+wKK2zRzIqOZECGRipkBVizMyF
         LTvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=iVAIHg10e75PxwpopXSb/8pDNklV1TMQwk113eJlU/U=;
        b=EfNCF1pOCyGkFA4Fc1ytiCe86HWO+y3Nno9XfM/4LAPZdfBhJuFkoEk6AAFaUvtV5z
         RkORn2FxqW4FJhwm9mjaTC3OkYOqXPns9Vv5mxo3SsEQToKW3OyowmAl3QFRviXD4WTS
         SgO3CrRoZ4IA3BOk3XFYKXraPb4zNridZbT4CMR8mDcGhLzsGpVqYTNk9+s5h9y/MsVd
         uAzGlYmuN4uiQ5/+RwUYgnjtBs/TZGeBLF8Abe3Al9coybU9UEV800j5WgIqXbdzqSVw
         H0VFfC5HSvCohujtrbBeSAJu7CRLOFyMALkIxf4cg7fpBVYDHWEv+UTHcig4wSN7Eu0n
         FDZg==
X-Gm-Message-State: AOAM5339ImuxrsPBCLOle4tigIglGwBN3CpgcxwADcvtprAEoiSnUj1n
        3EdAGSUDFy8dylRffeQ33VUXWfQQJtLgE1y/2YU=
X-Google-Smtp-Source: ABdhPJxRFFJU1cFkPHV8TeKSOUPFWt2E+p+IhJd6k7lMiAPyCcLBwhqNVJTDHy5c6x5Hirdz1i6wf70r4/DTvs1RQls=
X-Received: by 2002:a05:6512:10d6:: with SMTP id k22mr788749lfg.575.1631062476239;
 Tue, 07 Sep 2021 17:54:36 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1076.git.git.1629856292.gitgitgadget@gmail.com>
 <pull.1076.v2.git.git.1630108177.gitgitgadget@gmail.com> <CANQDOdeEic1ktyGU=dLEPi=FkU84Oqv9hDUEkfAXcS0WTwRJtQ@mail.gmail.com>
 <003701d7a422$21c32740$654975c0$@nexbridge.com>
In-Reply-To: <003701d7a422$21c32740$654975c0$@nexbridge.com>
From:   Neeraj Singh <nksingh85@gmail.com>
Date:   Tue, 7 Sep 2021 17:54:27 -0700
Message-ID: <CANQDOdcKsUqrQ6K6MEBoXS1BW8_tO8mx4tcq6nvqyiuM4e2CmA@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] Implement a batched fsync option for core.fsyncObjectFiles
To:     "Randall S. Becker" <rsbecker@nexbridge.com>
Cc:     "Neeraj K. Singh via GitGitGadget" <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Christoph Hellwig <hch@lst.de>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        "Neeraj K. Singh" <neerajsi@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 7, 2021 at 12:54 PM Randall S. Becker
<rsbecker@nexbridge.com> wrote:
>
> On September 7, 2021 3:44 PM, Neeraj Singh wrote:
> >On Fri, Aug 27, 2021 at 4:49 PM Neeraj K. Singh via GitGitGadget <gitgit=
gadget@gmail.com> wrote:
> >>
> >> Thanks to everyone for review so far! I've responded to the previous
> >> feedback and changed the patch series a bit.
> >>
> >> Changes since v1:
> >>
> >>  * Switch from futimes(2) to futimens(2), which is in POSIX.1-2008. Co=
ntrary
> >>    to dscho's suggestion, I'm still implementing the Windows version i=
n the
> >>    same patch and I'm not doing autoconf detection since this is a POS=
IX
> >>    function.
>
> While POSIX.1-2008, this function is not available on every single POSIX-=
compliant platform. Please make sure that the code will not cause a breakag=
e on some platforms - the ones I maintain, in particular. Neither futimes n=
or futimens is available on either NonStop ia64 or x86. The platform only h=
as utime, so this needs to be wrapped with an option in config.mak.uname.
>
> Thanks,
> Randall

Ugh. Fair enough.  How do other contributors feel about me moving back
to utime, but instead just doing the utime over in
builtins/pack-objects.c?  The idea would be to eliminate the mtime
logic entirely from write_loose_object and just do it at the top-level
in loosen_unused_packed_objects.

Thanks,
Neeraj
