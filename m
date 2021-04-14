Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7EA3C433B4
	for <git@archiver.kernel.org>; Wed, 14 Apr 2021 09:36:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B57D2611B0
	for <git@archiver.kernel.org>; Wed, 14 Apr 2021 09:36:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230102AbhDNJgW (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Apr 2021 05:36:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229914AbhDNJgV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Apr 2021 05:36:21 -0400
Received: from mail-vk1-xa31.google.com (mail-vk1-xa31.google.com [IPv6:2607:f8b0:4864:20::a31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5A4BC061574
        for <git@vger.kernel.org>; Wed, 14 Apr 2021 02:36:00 -0700 (PDT)
Received: by mail-vk1-xa31.google.com with SMTP id u23so144998vkl.12
        for <git@vger.kernel.org>; Wed, 14 Apr 2021 02:36:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=QjccawiBAcVOJcA2lIESWnjAeZVgHCNQ6P3T5bOaUJc=;
        b=i/6L2T4ZGGNkF7jS93OiJd+HEOvmK4WAebCwnYjHUCxq4NwXzKfAqEonS+93ybcvmp
         bEoEPCB2oT2eUvpMdXWLqw3qqHpUGB978hDYkEajPc8X3wwyHRWlqpLlWOADf9mTLOoD
         63za+RoYVtU9qoOcgCqenFye8Yhl/X1FmlgJbVERuTWWG6Rc9cno4mPm93G2d+wB76pU
         GFg7qL4LFyteZrCULGK3uCIzU27Wp3b3gqDVSC+sjUAjcrKAdiTu4RzfrXcU7ElQ1EtM
         3ug45haSKcxWeDPH6oQ4lTArnyzMGIRr+CyrTxafEAuN6lIAkPx4iFmV/7NdoKUSxO2h
         dIYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=QjccawiBAcVOJcA2lIESWnjAeZVgHCNQ6P3T5bOaUJc=;
        b=bFeijWDObsH8T/y6PARgEbDw3FHo+fyrF2ByA6SVRfvgOkHA3M/6uTkUSWFXa1Iet8
         mMtSISnaaIaz3idFv1kMLeNsTLxgJVKkFIwOFSYPxx3HFKW2n2G4wJct1jFO00IwzrJU
         bi0ZMO9GoT74RS9sbqhk1jJ8FMmzrAdFmVaT1NwFrfc1I4ToHGKyLBjDcYXf9PmMOzP3
         l9Xls5WUKYhVe+YVYuGKvA+sLIggVSX13w6LDryOGkaYNZcaPdfhuSLKaXXHj9Tkbmgo
         eN+HSNzZ4MGofaQe1HSlahwd1UN9Q/ldSOMeJNIZ4NMma+ILQiFVOkT2gnH31KMukqJr
         uVqQ==
X-Gm-Message-State: AOAM5315Qn8SFT0UUZyKYJNX/DXi+4pOYB9+6Jwiln+G+Us25KBzWxbl
        Zoblgon/8R9DXvKsTVGdRaGWQ/OdjkyI8GSIVFE=
X-Google-Smtp-Source: ABdhPJxPPLQLuTfTgjTP9Iw2efq9QwFoHt+xKf1mpx2cSE7IflhW98Rz94DQVArzDubOkMqAbkjDlFsGl9c8mbh7+Zg=
X-Received: by 2002:a1f:aa43:: with SMTP id t64mr27564132vke.22.1618392959625;
 Wed, 14 Apr 2021 02:35:59 -0700 (PDT)
MIME-Version: 1.0
References: <CAEaE=iyUGiPK-HX850mEgC=X6atEhbjJ0dCK0dci0nOCahPhgQ@mail.gmail.com>
 <YHYxtvKgKz+Uv2xO@camp.crustytoothpaste.net>
In-Reply-To: <YHYxtvKgKz+Uv2xO@camp.crustytoothpaste.net>
From:   Vitaly VS <strikervitaly@gmail.com>
Date:   Wed, 14 Apr 2021 12:35:48 +0300
Message-ID: <CAEaE=izSNyxRcvMd5bArHnmi0F2G83nouge9e_qxiQmA0AsWog@mail.gmail.com>
Subject: Re: Git via MITM transparent proxy with HTTPS Interception
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Vitaly VS <strikervitaly@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thank you for the fast response.

About our network environment
We are Cisco WSA(Servers SW, ASA, ISR) that proxies http/https
traffic. Client requests a website, network device redirects traffic
to WSA using WCCPv2, then WSA proxies the request to Cisco ASA
Firewall and internet.

Yes, that our transparent proxy is not completely transparent because
HTTPS Interception.
If network guys turning off HTTPS Interception for github.com "git
clone" work well through the transparent proxy...

Disabled https interception for github is a security issue for
us(corporate risks, code leak, etc). That's why I asked about can the
git client working with https interception.

Proxy didn't alter any of the contents of the stream(that says to me
our SecOps), but I've not received decrypted traffic yet to be sure.
HTTPS traffic caching but we are also disabled this feature for github.

Common downloads with curl or browser from the same sources from
github or gitlab working well.

Brian, really thank you for pdf but we haven't Client-end TLS
interception on our clients.

=D1=81=D1=80, 14 =D0=B0=D0=BF=D1=80. 2021 =D0=B3. =D0=B2 03:05, brian m. ca=
rlson <sandals@crustytoothpaste.net>:

>
> On 2021-04-13 at 12:07:58, Vitaly VS wrote:
> > Hello! Can a Git client work properly through a MITM transparent proxy
> > with HTTPS interception?
>
> Yes, with some important caveats.  The proxy must be completely
> transparent.  It must not modify or impede the data in any way, it must
> speak both HTTP 1.1 and HTTP 2 correctly and fully, and the proxy must
> speak TLS completely correctly, including terminating the connection in
> accordance with the protocol.  It must be completely impossible to tell
> that a proxy is being used.
>
> I do want to point out that TLS interception is by definition a security
> vulnerability and almost always significantly weakens security, often by
> using weaker protocols, breaking or disabling certificate verification,
> and impeding the upgrading and interoperability of the protocol[0].  You
> should definitely read and understand the literature about TLS
> intercepting proxies and have personally verified that your
> implementation is free of vulnerabilities before deploying.  You
> shouldn't rely on your implementer for this information, because they
> usually aren't aware that their implementation has vulnerabilities.
>
> Also, my experience is that many, many proxies of this nature are
> completely broken and don't work correctly, so if you are not fully
> aware of what's going on and haven't fully tested your implementation,
> you shouldn't deploy this technology.  I frequently answer questions
> from users in scenarios such as this who are having problems due to a
> broken proxy and often have to tell them to contact their network
> administrator.  I therefore do not in any sense recommend deploying such
> infrastructure.
>
> Git really does need a properly functioning HTTP and TLS implementation
> and things tend to break in a variety of ways when encountering broken
> proxies.  I would say "exciting ways", but I recognize them all now and
> they're not exciting anymore.
>
> > Getting a bunch of errors when trying to "git clone https://SOME_REPO.g=
it"
> > On small REPOs (about 1-5 MB) there is a chance that the clone will be
> > successful, but mostly I get these errors:
>
> Your proxy is broken and doesn't speak the protocol correctly.  It isn't
> a transparent proxy.  You should either remove it or contact your
> network administrator to have it removed.
>
> [0] https://www.ftc.gov/system/files/documents/public_comments/2016/09/00=
019-129028.pdf
> --
> brian m. carlson (he/him or they/them)
> Houston, Texas, US
