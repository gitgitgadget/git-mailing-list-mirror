Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDE65C63705
	for <git@archiver.kernel.org>; Wed,  7 Dec 2022 12:34:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229776AbiLGMeP (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Dec 2022 07:34:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbiLGMeN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Dec 2022 07:34:13 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 839294F195
        for <git@vger.kernel.org>; Wed,  7 Dec 2022 04:33:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1670416419; bh=jBzezZtTbDnsx3q2uh0z1es12Z3Fz03kFjSaskTAvPc=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=uNOzglAH5TgP37zyzq7EMMU6RsRAG9tZHavxhZO4B+Zc87sc3omanZrj9H5BxPwdE
         bxDFPQaK52EmcXecW+sGTWnFYlttv8cNQNyouxB/FgJpHqJqYn00K2EJkb0hCLgSil
         Sx7BZQZd1VZtZfj7YZQvI9gD4hkUllBZ6O2otrw8hS4e1MyovpsNPt4FbkSDH3mcOq
         dHvSZOkHYEVGcKK2mWLSkyUXBqw9qgDZPTURpwxgyYdEu0pprRI9K6lZd5eaNL43xb
         sVslS3/9h9gwVvP7xU/EN5AUUteG0G6NDklmoUD8wTJLHAcO6uFRVi9NufnZiOdm1e
         GSPZpiCEIUQMg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.24.155.134] ([89.1.213.44]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N6sn7-1otnv22ORb-018J4W; Wed, 07
 Dec 2022 13:33:39 +0100
Date:   Wed, 7 Dec 2022 13:33:37 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org, Oscar Dominguez <dominguez.celada@gmail.com>
Subject: Re: [PATCH] ci: use actions/{upload,download}-artifact@v3
In-Reply-To: <xmqqa640830q.fsf@gitster.g>
Message-ID: <s984sqs4-s134-q7q9-0260-o485683302o8@tzk.qr>
References: <pull.1354.git.git.1665388136.gitgitgadget@gmail.com>        <pull.1354.v2.git.git.1670234474721.gitgitgadget@gmail.com>        <xmqq1qpd9bys.fsf@gitster.g>        <2s9ppo74-r654-231r-7ss7-o08464s2so6p@tzk.qr>        <xmqqmt8085i6.fsf@gitster.g>
 <xmqqa640830q.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:hGNOvkPHtBFhsnfvMQk3xtdVixNL1r6lgOt9SU2yag5CWiHfp6X
 DxD8uvyVrGlNsdfM08Fhp6SpWArGoUmYEDbcU6giJiC28QHp4osd8mrCsicZLH81pKwGbPd
 u/xO+daAtiEKDM6ZmU2yu8TuoZ3B4TUP2Z6/9jEgWK0z/+0mmBq4loJabwWFUxHBpK5/Ros
 ixvE5+2wJ3ikTNYKbNa5w==
UI-OutboundReport: notjunk:1;M01:P0:4kj0eY1nmf4=;eNYiE1aVKg5i2XlGhgHjfPlqR3n
 haP34WwPF4Cuclxfcm7tZPrUdKphhfR4zteDE2cGQ7gdkOqMaZhLFbAOm2VI/qBdz1DA8WKnM
 0Su3aZKEx94+3uWpDQMJbzrMN3PAFFuUAvNkuUWYt2HHvCAiah01bNLebe3koyaCQfKjihdAe
 ned/zDldwxXaH1mAndt3FPuzp9TqKj2bjHUoq3itloL9L0Ned/T6Rh+KX3UOo2pW3bACSZUh9
 6P8OuZKjgKG1bejsr1n0ziqUv5ZoHvI8Du9Zyslzm87eQlIJAWZAoOVPPln3RjRzoVS00IQC7
 tgo+fJNu9mgC5vUQXxw6FrnNa4Aaaf7nRLHg+UETahqwdHHhWxOxJsRa2dd2C6XwtUK8H9y/7
 5+L1ddSvxrimGeyORruDUNI+QJMc+h6HrZEEMo5VX5UApKcV3nnU9vIgj89eRd7M0EhcFfzgx
 Amngx3INA/INdbWWi02dX3gr45aY7dnoUm0cXdOOocxmaybWLarIo5F2bdEY2OIHNniStiHC+
 bX+FHaoNgnEX8OcPpIT9Su7CYuaMGHPPGPi5y/H+hN+icSztF33FVix6kongzVwUKs9lvjO2T
 c0xyZ173WRz23UDnwruMdUj8YpPaLkkHr+nmmvEmckNW5GtkRlIkUAwpbwmRR+yqubkbE/ZQR
 56Q08XZaj/iuI0CAkbp2U7Tqb5ZKLBqQCg2j9gPUnZWZ+c4hT4ytI+ercdKejs+PpFth5Oe9H
 LYfXopLznFeWgjmEDFzOkjLlrBFWGH1lyJj8KMOmeGOIb8rwzzwCST4y0UrAcTxOozfyFugvJ
 xK7jK6B9SRA7DkeDgbvpUdGreBEmdUrsBQUIJbrQbR8FBYTtXobpj3ciTuXEHeYNgnQEqAQ6v
 NfgqdFztj2RyWDCoQSenL/bgzbGj+9VxYw1SnL8uopyvZwNbP4V8uym64k0UA4RYGyW+3SKYr
 wHaTfw==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Wed, 7 Dec 2022, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
>
> >> This is probably incorrect, but you wouldn't know until something fai=
led
> >> in the `linux32` job.
> >
> > Yeah, that was what I was afraid to see.
> >
> >> I already have a correct fix in
> >> https://github.com/git-for-windows/git/pull/4112/commits/b59c1e33fa62=
029f8d5dca801a8afb480514140c
> >> and was only waiting for the patch at the root of this here mail thre=
ad to
> >> advance further so I could contribute that fix, along with other
> >> replacements for deprecated operations.
> >
> > Wonderful.
> >
> >> Maybe we can move these changes forward in a more orderly manner, wit=
h
> >> Oscar's patch advancing to `next` once it is done, and the other patc=
hes
> >> following after that?
> >
> > That was what I was planning to do anyway.  Thanks.
>
> Eh, I should have made my intention clear.  I'll drop this one (as I
> posted it primarily to fish out those who are interested in and more
> capable than I am at clearing the deprecation warnings from the CI),
> will mark Oscar's for 'next' (if I haven't done so already), wait for
> your updates and queue them on a topic forked from Oscar's (or on
> the same Oscar's topic), and cook them for the first or the second
> batch of the next cycle.

Thank you for clarifying your intention, much appreciated.

Ciao,
Johannes
