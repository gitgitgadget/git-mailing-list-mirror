Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A93F3C433E0
	for <git@archiver.kernel.org>; Thu, 11 Feb 2021 09:47:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7872A64E87
	for <git@archiver.kernel.org>; Thu, 11 Feb 2021 09:47:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230090AbhBKJrg (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Feb 2021 04:47:36 -0500
Received: from mout.gmx.net ([212.227.15.15]:54751 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229919AbhBKJmi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Feb 2021 04:42:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1613036447;
        bh=fvHa5VdVtR243yuPA2a1GFv4ypAJbf0GncGxD7xhf/g=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=d7UnGWz5G2B011esQOi6wGLRtZvf+8uTDvKCgkrbhhkNcsotvJYTLLGCOWrhpo5z7
         0wuvWhcZ2FPungYZAKFIJcj4mABanDxJqYyCns7TYI3KlCvXUR0ssHSY6tFpmawdK5
         6oJ0q6cJv2eiVtdCP/fS4U3vt8tTDgOr41O+iWp0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.19.95.40] ([213.196.212.209]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mj8qd-1lmkvq2Jcb-00f9wp; Thu, 11
 Feb 2021 10:40:47 +0100
Date:   Thu, 11 Feb 2021 10:40:45 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Micha=C5=82_K=C4=99pie=C5=84?= <michal@isc.org>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH 1/2] diff: add an API for deferred freeing
In-Reply-To: <878s7vcnqo.fsf@evledraar.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2102111039080.29765@tvgsbejvaqbjf.bet>
References: <20201020064809.14297-1-michal@isc.org> <20210205141320.18076-1-avarab@gmail.com> <nycvar.QRO.7.76.6.2102101557160.29765@tvgsbejvaqbjf.bet> <878s7vcnqo.fsf@evledraar.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-441505537-1613036447=:29765"
X-Provags-ID: V03:K1:PguJwlhDaVT2x0TdGqurGNs4di/YJKZybL0xiroo+i5kSJmnSWF
 lUiqbx4xhGe/kDMnMSz2pKD8y7kNTQh3V2YOC15lOpqVCllawCAjh9ou6uLXVVi7dbb4AY6
 v7Gf7KcabAjufJuq+mw3kTGbHgInrOCgqgJXyQugdaORnEl2N79uhBZ/+tf/doBuICUVr/S
 8Nt0e8UHVMdyFEkDQZ7aw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:lQ2ZXTSOjRo=:dfbtxB3+tgQ42yQ/JuH0E7
 6MHLypJMa9aYGpKN6NglkF3kT0Nr5ZW55BINhxC8kT/zsEH5n7I7d0PgxwL6h26BDFftCuGlM
 nZEFmY5iOmESuYLdB5IrwsBiMqHlj7XnXiY7aV9Eufl39JSUOfqob3w7aHW4QsU/zD6gzH/DZ
 C4dj3FMlK2rjWWkCOy3gPKEoGodibydc+uxrE/3aALKo6gZUPwpZRpu/CDv50QjvTJxLjLzY8
 igVbDIDWVHpdcvw2lV7UXR+8/56eo87AqeLzt8gEw7i7FTq4D4lf51xfrxewmwUmU/octK7zo
 19W+jYnuQy13Nje/IIgOM0zYqcKXIKIA0j4DvJ6d84gOeeuHqHB/Xepepoj0+1thkT+gJP8ak
 CGrbObheFHDTNFBWdUl+Fd1HccSOY0Dcv/JJKE+KREMJH1OLm0ra/dv2FYvgExZGX9OikG0m6
 LEy9lX/PgnKBdaY+EqmSsLHKSqVQ7C2v2t1eN9KjCi69La4Gcu6yJGJnzkBK2etGSQ1OKlcGU
 kkgJrP8qsvgSaTRa9RKiUVldB1aW6bC/IxDcXfkWL4zromKBHwhvYyrAEke3r9w4p7Shvk9vM
 tSLJUy/SzDhXzEiMBg/wDYLslwUh5IBdFgmLAjz768IWwDA4nersgsYF7cqHMhcnPGbeW5B9q
 r1u9nwxK9PeRlgODcgE598w7h3jXx1wzILiHWGxzRyKLAGCsdrDNHYpyBbvfY/ZOxXS5oWVnf
 CSmuQBS39gZTSNzMQr/od5HPpt8+dlcVVsB4HZ/9U6Pibpt7071yt3fTr/5WC2547tiRfV2ox
 zY/NxvGtZg8yLAPrrEe95u5SNgSvy5bvyVKGeM87hQmi3ebGal5dh90WSqdcnsEryqB6Pvi/9
 ntrq4Jx2yokSsbeNXWzX02OWAIH4+XS8s1maHcPCM=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-441505537-1613036447=:29765
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi =C3=86var,

On Thu, 11 Feb 2021, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> On Wed, Feb 10 2021, Johannes Schindelin wrote:
>
> > On Fri, 5 Feb 2021, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> >
> >> Add a diff_free() function to free anything we may have allocated in
> >> the "diff_options" struct, and the ability to make calling it a noop
> >> by setting "no_free" in "diff_options".
> >
> > Why do we need a `no_free` flag? Why not simply set the `free()`d (or
> > `fclose()`d) attributes to `NULL`?

Hmm. That was not even clear to me until I read this reply.

Doesn't this indicate that the closing is done at the wrong layer? If we
want to call a function N times and only at the last iteration should it
clean up our resources, doesn't that indicate that the clean-up should be
pulled out from that function?

I thought that's exactly what you did, but I must have glanced over
something obvious...

Ciao,
Dscho

--8323328-441505537-1613036447=:29765--
