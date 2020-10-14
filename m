Return-Path: <SRS0=g1uB=DW=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD924C43457
	for <git@archiver.kernel.org>; Thu, 15 Oct 2020 02:14:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 527482225C
	for <git@archiver.kernel.org>; Thu, 15 Oct 2020 02:14:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="noxLeiLP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730119AbgJOCOi (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Oct 2020 22:14:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728551AbgJOCOh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Oct 2020 22:14:37 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A977C05BD1D
        for <git@vger.kernel.org>; Wed, 14 Oct 2020 15:38:53 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id hk7so623279pjb.2
        for <git@vger.kernel.org>; Wed, 14 Oct 2020 15:38:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VdCxLwUpHsK0J70i0yhLDPPfqN4GTBz4Ow8PavNMfBk=;
        b=noxLeiLPiUB5Jd/gUKfS3rKrNi/Ia872nNDxkxBK7zQX91Ah5P75FOdIqFmc2q7kX6
         EdodWZhdgaUmrkGpdxdCs2+Z2lbg1i/akVt87oZBqdTTXIzWvXS1h1a5EQQpBayHYRj9
         sLNT22q8JICVgY3XSUSp6O40MgflFTt+Uq17uZ5Ekser8eF5MFzCMjAj1v1vl6jePWYK
         MEU7dK3k7Un3rHrWsuYvSJ6ADwnLqOx1QJ5phGIsCD4XaDW6TEsoBXWDMOhacLVsYtIs
         ZuTSIRChFwhUnMO+AuOWt22/rBLv+PplUUEVmnkL4Fvf/6FZILg6iFKAlet268YYS479
         gNQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VdCxLwUpHsK0J70i0yhLDPPfqN4GTBz4Ow8PavNMfBk=;
        b=bY7wFCByca+8nM0xXeRTRc+bZnwLiEmY0cJhhdyzHwM1mxstvXaJFM4bVKYrbRTqsp
         +4xYCua9Qx/nSczNZvDWkymLVdYqOC4lI0tEy5r41jiF3cUud307DDr4MgpMbEiokq+1
         65H/JAp/lDte5k8klR/DPqMm9oEI67AZkomYBRes0Qn5jn/M7Cw+Y1bOjGLiPmzpYKlJ
         sea07AHPcwHszeAyl3DnJWnBr9o4K6NsbSXWI8gszN3+hXERM6fCnTObTZZkcqPXMxoV
         PQ7P/9TxXOiIwP92rqQ1eFODOx6nicR6JYrcFa2dt+dhMnjHfida6SM9pXKGpslchXvp
         buBg==
X-Gm-Message-State: AOAM533TWJodrhlqh5VP+4wMmChc9OSE/JrL7DYV8Bajap8E+Nq+ovcJ
        IzuVjkyhA9+kTxRHu16E36RU2hfMDrHMMJRJqu6DfQ==
X-Google-Smtp-Source: ABdhPJz6dFk6wserP2oxyRqkfWhthAWEqfJMpJvXzDzubFbuZ5Day1QoA4Jfi8guXffwvzco/TA9dr5hml6Z+5jLt00=
X-Received: by 2002:a17:902:bd48:b029:d2:8ce7:2d4c with SMTP id
 b8-20020a170902bd48b02900d28ce72d4cmr1172936plx.42.1602715133031; Wed, 14 Oct
 2020 15:38:53 -0700 (PDT)
MIME-Version: 1.0
References: <20201013191729.2524700-1-smcallis@google.com> <20201013191729.2524700-3-smcallis@google.com>
 <20201013211453.GB3678071@coredump.intra.peff.net> <CAM4o00eCKP1+f=xBw4LJfNqrstEnutAe9StxknW9qLMtPBdhKQ@mail.gmail.com>
 <CAM4o00fO++JMNdES03JKRyxmZtiLjkrJ2nux0-TZYBdH2+0ijA@mail.gmail.com> <20201014193456.GA365553@coredump.intra.peff.net>
In-Reply-To: <20201014193456.GA365553@coredump.intra.peff.net>
From:   Sean McAllister <smcallis@google.com>
Date:   Wed, 14 Oct 2020 16:38:36 -0600
Message-ID: <CAM4o00eZjr2apH6WO-sTvuOfR-cuiSh1yhh3j=14ZFstXDz7bA@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] http: automatically retry some requests
To:     Jeff King <peff@peff.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Masaya Suzuki <masayasuzuki@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Some large projects (Android, Chrome), use git with a distributed
backend to feed changes to automated builders and such.  We can
actually get into a case where DDOS mitigation kicks in and 429s start
going out.  In that case I think it's pretty important that we honor
the Retry-After field so we're good citizens and whoever's running the
backend service has some options for traffic shaping to manage load.
In general you're right it doesn't matter _that_ much but in at least
the specific case I have in my head, it does.

On Wed, Oct 14, 2020 at 1:34 PM Jeff King <peff@peff.net> wrote:
>
> On Wed, Oct 14, 2020 at 01:10:46PM -0600, Sean McAllister wrote:
>
> > On Wed, Oct 14, 2020 at 1:09 PM Sean McAllister <smcallis@google.com> wrote:
> > >
> > > On Tue, Oct 13, 2020 at 3:14 PM Jeff King <peff@peff.net> wrote:
> > > >
> > > > I do think you could be leveraging CURLINFO_RETRY_AFTER rather than
> > > > implementing your own header parsing, though.
> > > >
> > > Ah I didn't know about CURLINFO_RETRY_AFTER, I'll look at that and use
> > > it if I can.
> > >
> > I took a look, it looks like CURLINFO_RETRY_AFTER was only added in
> > 7.66 (September, 2019),  so
> > I don't think it's reasonable to rely on it for getting the
> > Retry-After value in this case.
>
> I agree that's pretty recent.
>
> How important is it that we respect it? I.e., we'd have some sane retry
> behavior if the header is missing anyway. On older curl versions, how
> bad would it be to just use that fallback behavior all the time?
>
> -Peff
