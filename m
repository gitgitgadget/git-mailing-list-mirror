Return-Path: <SRS0=7OUv=6W=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83788C38A2A
	for <git@archiver.kernel.org>; Fri,  8 May 2020 06:19:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F63B20708
	for <git@archiver.kernel.org>; Fri,  8 May 2020 06:19:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k91T4EQy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726325AbgEHGTL (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 May 2020 02:19:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726009AbgEHGTK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 May 2020 02:19:10 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58FC5C05BD43
        for <git@vger.kernel.org>; Thu,  7 May 2020 23:19:10 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id pg17so392493ejb.9
        for <git@vger.kernel.org>; Thu, 07 May 2020 23:19:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cF5n7LOqIOFQU2K/Ylt7oqK6hGYHfDFasrcX88QvNmM=;
        b=k91T4EQybCj7/C5YF8eWkEtuENoaQ6e0Zgd0GOL4gmwSxqEjoVSGc0SwjuqXWQ2svf
         wp3BVcpnYXEvbZ8ck7hqA5FoLKtY2DEMN12nhmOK3zDcG939kjnarAKYrJso5yGAYPbl
         dL3J4a8Zf8Ky6TJUAjPKycRAs5IJgAl9mCGHCCakZR+pwlGcHftFFlXpzls2RzVz4DXa
         IsNRfqFiuifpM+WU3tVpVUy2JNN281t+4i21AbWqt7GBwQjwM5b8jcsgPCdlJ7q1r+Os
         Mbl+iOtt0E01IHTLn+AmFSlSldQiXSATB3QYnXn9VcM81zgqSLjhUeS5urA56UBWJpKg
         M+LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cF5n7LOqIOFQU2K/Ylt7oqK6hGYHfDFasrcX88QvNmM=;
        b=puzKi2DufYvN5zAMD+PsY9jjj+M764TyLxbH9iGXYLpxAA3cWvm7T4qj6tgITTKvpF
         kPU+7Ut9gDJ5cQwkOxMwbyh0rqHhI7GQJRefxTgtnJmm62wqk7rpZPy5xFdkynvzOLo0
         YXAPQURd6LbGGdU9VjjDetljHLsgSBxJG2L1SzZ0dmiwpFJHMcKTvYqN3MrVoo5gvM/X
         wig/sGQRcIH8noiJ9QSeWUlDA6/8UKsO2HKR8BPo37d/hF62egq5gJatQMFiFUrS6Hin
         kChW1DI0Ti5epxEgNIBPCQt6X/18Cerm03hutyxALefmb6FtKIF4l7Y2x9xnp8GOdgvo
         3XXA==
X-Gm-Message-State: AGi0PuYiVROzY2brMy2/YCxD260TILKDtskkZbN1dHZyPQjEJG4L/y0j
        oz0Myy5b4NECykC13DQZ+4eYgJ3gBzOGnoaMlBM=
X-Google-Smtp-Source: APiQypL+r3VIbvuT+XiI5UVEvg30hznNR3RiefTwDpJyOSoOQBOjN17R0WIyBkpIIzR1PxSfTx5KGVFss+TJMmtVbTY=
X-Received: by 2002:a17:906:8286:: with SMTP id h6mr592091ejx.28.1588918748781;
 Thu, 07 May 2020 23:19:08 -0700 (PDT)
MIME-Version: 1.0
References: <20200506073717.9789-1-shouryashukla.oo@gmail.com>
 <xmqqtv0t6l84.fsf@gitster.c.googlers.com> <20200506181239.GA5683@konoha>
 <xmqqwo5o6hzp.fsf@gitster.c.googlers.com> <20200507044028.GA5168@konoha>
 <xmqqv9l849i4.fsf@gitster.c.googlers.com> <20200508054728.GA8615@konoha>
In-Reply-To: <20200508054728.GA8615@konoha>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Fri, 8 May 2020 08:18:57 +0200
Message-ID: <CAP8UFD0=_8D8hkT5VVPV_F++dr131bkjby357fA+QfhQxktcMg@mail.gmail.com>
Subject: Re: [PATCH v4] submodule: port subcommand 'set-url' from shell to C
To:     Shourya Shukla <shouryashukla.oo@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, chrisitan.couder@gmail.com,
        Denton Liu <liu.denton@gmail.com>, git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 8, 2020 at 7:51 AM Shourya Shukla
<shouryashukla.oo@gmail.com> wrote:
>
> On 06/05 10:08, Junio C Hamano wrote:

> > Specifically, I would write "!path", not "path == NULL".  I thought
> > a rule for that is in the CodingGuidelines (I didn't double check,
> > though).
>
> I could not find a rule like that in the CodingGuidelines.
> Should I add it?
> https://github.com/git/git/blob/master/Documentation/CodingGuidelines

Sure.

> > The comparison on argc is to see if we are even allowed to access
> > argv[0] and/or argv[1].  In practice, if what main() got from the
> > outside world in argv[] is passed directly to you, argv[n] would
> > never be NULL as long as n < argc, but there are a few levels of
> > callchain between main() and you (i.e. module_set_url()), so not
> > counting on that would be sensible.
>
> Understood. I will add the NULL check as well.

Thanks,
Christian.
