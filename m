Return-Path: <SRS0=BxWL=AF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64E7CC433E0
	for <git@archiver.kernel.org>; Wed, 24 Jun 2020 13:00:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 41AFE20C09
	for <git@archiver.kernel.org>; Wed, 24 Jun 2020 13:00:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="KgGzG35r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390230AbgFXNAm (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Jun 2020 09:00:42 -0400
Received: from mout.gmx.net ([212.227.17.21]:50431 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389933AbgFXNAl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Jun 2020 09:00:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1593003629;
        bh=4gzwPRc2oodG1YbkEQj80mke5I92FmPtxdVIp+6795o=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=KgGzG35rgPezs4THpZvbMKlxETJwKqJxMvhS70LPLgBIAbYQXr76DaaBJECnaQpdn
         eSaq5nMOtqWQybab0lbx47CPcCWjMvaeW75evXpBV7FRDupal6BtC4hrpwjQVFGd06
         b5/KbRqTbW5VQh/C5919tREfAXqsFc6ZxSHn4KVE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.227.237] ([89.1.212.7]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MryTF-1j2h6P3Dhl-00nwG8; Wed, 24
 Jun 2020 15:00:28 +0200
Date:   Wed, 24 Jun 2020 15:00:29 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, don@goodman-wilson.com, stolee@gmail.com,
        peff@peff.net, sandals@crustytoothpaste.net,
        Matt Rogers <mattr94@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Taylor Blau <me@ttaylorr.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Alban Gruin <alban.gruin@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Denton Liu <liu.denton@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
Subject: Re: [PATCH v3 7/8] remote: use the configured default branch name
 when appropriate
In-Reply-To: <xmqqbll99sl5.fsf@gitster.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.2006241459000.54@tvgsbejvaqbjf.bet>
References: <pull.656.v2.git.1592225416.gitgitgadget@gmail.com> <pull.656.v3.git.1592951611.gitgitgadget@gmail.com> <00a1b281e5ae4cf14435a6745cc55fc248f378a5.1592951611.git.gitgitgadget@gmail.com> <xmqqbll99sl5.fsf@gitster.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:oXxmpzQ7xhVA77bagk5hbIGptOfct4NNjB8cEUCvavJaSjDIWia
 EdCA8mC1+W1uTWC5l44dzLW+33DwdIw0OwgYsEZPmSZgifJwixjq5AojF83Ntd0mBREndF2
 p1VCPdrBg1BA4pR3pI+qaWIrAyD9jD9I5SAGEjiKSRHztRQLI68A/F7Ynx2MulqZXssIFib
 HVuo1Tb1nuC9ccMKqmfeQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:631WqZEz5eQ=:OuO0tOl7NlozCE6rgYj2l2
 n6YgxR5gdkeVlxUyK4oXLfFgu8vSdbOY2DgSSDWXBzO4pehiymzAUJy6mhlG8oTapg6fuNrGy
 kux42ZSj0aCZZUoHIhqYoMY5MQNx+gHzvlC1UEwcUK5oJD3VXCc3wzVI0b5POvjaSYc0z/3pm
 Bvqi+nhPR4OnRZ406RP3LUkQqkdMpttNJwz7vPWP1NUhV8C6EA14S8wTwCQFk/16XCr2c+kAz
 HQeWkcND27CNdbUMYye8/J2Mo3pwsIAIAMJqdfCbMqBEKV8x0mGVeOlqKlO0dxNVU0bBdLcSA
 3TGkI6z2u1OUk7Un0b2iZY4Hih+KmofWHljgBY4Jo/P7/Guk3cCO/ZWFx2rt5pr7u7GIM4rl3
 7l8I0UOOAEB2z97Prv2+saoRhofOlPtHjoXqV97LL7fs5PNw/0K0whNoRm5lSwRe+wJgaMmw7
 WE+TcI2MKao9f6Ns82QF7LIBSIkZGpbda+dDWtzKiHdiYXAMjW178K0Vq84ILKbMsK+/KwsdA
 MCnwNYAsHnEzrfRjFc2uCpcdB49Zfq9GfAHasUM7OwxnbXAelKzLyIbpOd0qZ/UFHS8YUpOGA
 /87fP16x4hBdDaecxFZek/atVTrT/co1Z9ATawhce0Mm/uksRM4DHJBY2/s4u98x3ZxybLX+0
 Fa6j8ReiSwNwD90ZVoZTePfetC+lZdzkH22Vesau0Te37BK+mmFW7iyr2KiwyeQzmTtEnZlU1
 CLYzCwbXa57+PiXAhy5uFFaOyKrrFYTvVNnyv1aULk8AJluE6VIlmapZfB1WdI462qvTTXY59
 HmnX/Dvnq33dLtqbCNSrS3PZW6yCq4BUhRByVviVs/j/po3Oy7Ev9kpC0uD5J7POAFZy1iMm4
 qybBeUY/oUYkhsPwe/w7AbguEIjdI7bZH4g5nI9Iwq7skqgripUfi3ehRexZBK30q8KZM4izo
 7sFNfWz31mXBO8vTdHYRvMmFIhkyzPJ5Vh9Zd23KqqUeZPW5jBF772uenp7owXbdgpkQdGB/5
 R3DleMMPiY2XpLgC2dFb0oNtCsZikOYoDf+cCq2fiqpcT8+Uf+LCUSjBoYeuiaMmRxP9EEOig
 4yPTLQoeX9eRCfmCWhj72Z5JYfBKrKUYBDCZqCMKRni4MgtG45nm0XOh04hxZngCZCzYsdzos
 RCY6yC4Oq871VzhgFhuqCmHKLFtIPyWziBJq8+2tisO5Wx1PmZNWHUI25esVBhzFHS4O5a2AY
 WNvvoIrGaYiVnyRhi
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Tue, 23 Jun 2020, Junio C Hamano wrote:

> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
>
> > diff --git a/remote.c b/remote.c
> > index 534c6426f1..965129adc3 100644
> > --- a/remote.c
> > +++ b/remote.c
> > @@ -276,7 +276,7 @@ static void read_branches_file(struct remote *remo=
te)
> >
> >  	/*
> >  	 * The branches file would have URL and optionally
> > -	 * #branch specified.  The "master" (or specified) branch is
> > +	 * #branch specified.  The main (or specified) branch is
> >  	 * fetched and stored in the local branch matching the
> >  	 * remote name.
> >  	 */
>
> Isn't this a bit premature here?

Actually, it is just wrong. It should talk about the default branch
instead.

Ciao,
Dscho
