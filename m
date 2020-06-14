Return-Path: <SRS0=22YV=73=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F31BC433E0
	for <git@archiver.kernel.org>; Sun, 14 Jun 2020 06:35:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 33D5E206B7
	for <git@archiver.kernel.org>; Sun, 14 Jun 2020 06:35:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=goodman-wilson.com header.i=@goodman-wilson.com header.b="kWDl6rd1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725613AbgFNGdB (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 14 Jun 2020 02:33:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725265AbgFNGdB (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 Jun 2020 02:33:01 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFBC7C03E96F
        for <git@vger.kernel.org>; Sat, 13 Jun 2020 23:33:00 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id o15so14053985ejm.12
        for <git@vger.kernel.org>; Sat, 13 Jun 2020 23:33:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=goodman-wilson.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=unB72RruCwp+13pX3q3NwGkmykkDCsNBcuukMDCoffA=;
        b=kWDl6rd11wnmVUVeUHswlJbrpwNCaMI+cdBbisrQK+8OawgE+IyhL53so6LYlwXaHv
         4UvWkr+XZcHEMBHRRf3mCfXdBJ5MT38r8xqERP+tsmBqV9DWxIUe9u5OrTk03DNiF7EH
         Z/dq9xZrcDt9Cpq7sO6jpRrwzssfnGdNXjKrk3dcYjcTD0Zz5HQZthf59eE2oUbcQ0a7
         quVp0ddYwlNsd4vyZss3RK3moZy1Y+toW17oyhUuq3RoSz0MroaELfbKqIA5fXBjxAIo
         fEXnk2wljsFLn6u5Im4Orqq0xRTkiqPbUemAlMOt4BgBTGZI0pEG4cCW/W3k9ioFm/mJ
         YYJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=unB72RruCwp+13pX3q3NwGkmykkDCsNBcuukMDCoffA=;
        b=G6DYdq3JvT1XTtW3StLAzaUm6Cvbc+ufL2zVLgmFqlisjNBsvajZJW0IJnk0BHR484
         DiJyCNQ1kLHI2vwdH31PeDWzfcN97iKaMFUg4kiS3t2XCMM0winDDNDAdE8QM9TVlEL9
         x3vaWuNCq5U7w8U2zWmLaqgNPucoNGC28xNiLl7mGr7ksOYypktHf5yWYySUiP+qP81Z
         N6huIwxSvdNGDdz2VNwe5FKsMPf2TusNHppaYbGBt0++7MfT3FrEh2SmTQIhTNQuhH0O
         FijMWyZYChXcdlS7e8aDv5UUAfl6icDkWSpQ28uQH5z6j43p+swNbXU+Th39e1NNrpGk
         I0+Q==
X-Gm-Message-State: AOAM5333yhv/MrQ+nshfh0g41vkBimkmNyGEbO4hwOB7Tki0z92Ipv9n
        LNNiMO/cDJPU7lkTcPRVazo9ssAWP1aeqpsXPetvIw==
X-Google-Smtp-Source: ABdhPJyD2r+vNNAHRUCGJteOoORfNKK8wxtmrw1nDFXDxUK13zPdNwEKBdVTpiHHtxF5vX+APfnB3owUUCtNcAxZEvg=
X-Received: by 2002:a17:906:4c42:: with SMTP id d2mr21214352ejw.474.1592116377038;
 Sat, 13 Jun 2020 23:32:57 -0700 (PDT)
MIME-Version: 1.0
References: <xmqqy2oqxyp3.fsf@gitster.c.googlers.com> <0dd6b6c2-4ea4-498d-4481-7f65988db293@gmail.com>
In-Reply-To: <0dd6b6c2-4ea4-498d-4481-7f65988db293@gmail.com>
From:   Don Goodman-Wilson <don@goodman-wilson.com>
Date:   Sun, 14 Jun 2020 08:32:45 +0200
Message-ID: <CAGA3LAeXzYokcpU8RnFdF7N5vC-geOdJSY5_Mjc-yssvbpjmgw@mail.gmail.com>
Subject: Re: Rename offensive terminology (master)
To:     =?UTF-8?Q?S=C3=A9rgio_Augusto_Vianna?= <sergio.a.vianna@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Simon Pieters <simon@bocoup.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I am an American living in Europe. Let me offer an analogy. Like all
analogies, this one is imperfect, but I think it will serve to make my
point.

As an American, I don't understand French humor. It's simply beyond
me. I've had it explained to me numerous times, but of course
explaining a joke can't impart its inherent humor. But none of this
should come as a surprise to anyone, as humor is a deeply cultural
artifact, something that can only truly be understood by those raised
within that culture. Even so, we can all appreciate the concept of
humor generally. More to the point, I certainly don't go around
denying that French humor exists, on the basis that I don't get it.

In the same way, something I've learned living in Europe is that many
(if not most) non-native English speakers realize just how explosive
certain English locutions can be to American native speakers. That's
totally understanable as, like French humor, you have to have been
raised in the culture to really understand that fact. Like humor, we
all have a sense of what offensiveness means, and like humor, this
explosive content is a deeply cultural artifact, something that can
only truly be understood by those raised within that culture. The
visceral feeling of explosive content will probably always be beyond
grasping, just as French humor will probably never make me laugh.

But to deny that explosive content on the basis that you don't
personally feel it, that you've never experienced it? To claim that it
is "meaningless", that some people are "perpetually offended"? That's
willful ignorance on your part, a bad-faith effort to engage in
serious intellectual conversation about what is good and right, and
has no place in a discussion about creating an inclusive space for all
developers, let alone trying to bring about a more just world.

Don Goodman-Wilson

On Sun, Jun 14, 2020 at 2:50 AM S=C3=A9rgio Augusto Vianna
<sergio.a.vianna@gmail.com> wrote:
>
> Then why create all this disruption by changing the default from master
> to "main" if you will offer a feature to set the default on creation?
> Americans were discussing trump's tiny hands last week and will have
> moved on to any other meaningless subject the next one. You can
> literally never please the perpetually offended. Taking this kind of
> slacktivism and creating problems for other people is a disgusting level
> of entitlement that only americans display. You really care about
> others? Remember there's other countries in the world.
>
