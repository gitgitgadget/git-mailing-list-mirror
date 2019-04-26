Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6145A1F453
	for <e@80x24.org>; Fri, 26 Apr 2019 14:54:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726228AbfDZOyY (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Apr 2019 10:54:24 -0400
Received: from mout.gmx.net ([212.227.17.22]:42691 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726169AbfDZOyX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Apr 2019 10:54:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1556290447;
        bh=O322hojfrQoCOzGNvnsxgYqzi2c/Ru1IW8duG5utQ2s=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=UveFdUO6jt5toNlfaWuQlBO301D6yggmkfoi9C36QNOv4HCqNALEKKQ9auNh3xOOS
         c8LnncEHH2zahQbEJcEyJmrr+ywr04g4d6T4P2mAZJqKYxO3yiGZmY0dYZhSKgnvQx
         sre4iJRlCJylgSrv7R4dhu5lj9+a5fW7qTCFzpN8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [10.106.210.8] ([167.220.152.8]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0Li0dC-1gxdfA2Nl4-00n8oE; Fri, 26
 Apr 2019 16:54:06 +0200
Date:   Fri, 26 Apr 2019 10:54:04 -0400 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: dscho@gitforwindows.org
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
cc:     Jeff King <peff@peff.net>,
        Rohit Ashiwal via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Rohit Ashiwal <rohit.ashiwal265@gmail.com>
Subject: Re: [PATCH 2/2] archive: avoid spawning `gzip`
In-Reply-To: <20190413221646.GL12419@genre.crustytoothpaste.net>
Message-ID: <nycvar.QRO.7.76.6.1904261051310.45@tvgsbejvaqbjf.bet>
References: <pull.145.git.gitgitgadget@gmail.com> <44d5371ae6808ec40e8f52c3dc258a85c878b27e.1555110278.git.gitgitgadget@gmail.com> <20190413015102.GC2040@sigill.intra.peff.net> <20190413221646.GL12419@genre.crustytoothpaste.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:GKV5GvArzALzQb0bPRgOKWLWi0BI/lKzloFMZzDwnH29kXKMDZi
 nfMsEN8Gz8Z4qLm3S0/YOk2rsHFfKj1Pnen2Vvr1zmVW+CFvP/TPfhVjKWXjfsjR7LRMufA
 W9XqXmnQG72gxPkiJpniMaRO09d5cH9MVzmm7qD23GnlLnW2pDPqv0w+ykgjP4FWKTFhazp
 qcRLhNd2/x+jKEmXCB5ww==
X-UI-Out-Filterresults: notjunk:1;V03:K0:e+/b5aIaSsY=:8qZOJpB6CagEXxdvZZvG/Q
 Z+vNnF8rSdcs6odfLyNTMhgggaCA3ewq6IfyecAsn59ryU1ggWDbhLZ/rioRLAKmNVHuIVj+V
 n1hvfcjl3kNLzvRESNxJ/1x9JU+ZVa239oMSCmFHMQyx4RbuOjI9NxoH5tYbZ8G5xUgfS/UD1
 ltPHhch8VfVL627Rl/KH+DPMQuWRFO8X4mzlHm3dIPb2EwofcR7f42PZbljE7FUp0185s7fhY
 LWWZ26mhjaId3P8VJ9/M/CGhymaKvRothXGBnbCgc7G3Hc3zZRghPS42NdKmRfVxFaS3ZdOG/
 rhkYyz2v3irNA8NJbW25G8uaK4Vb2KjrBoAL5lA91JRSqiqev/lWdhuRHDLI/2Wcnnwv2d8YB
 sqrHjvLHFDfNwtOD/AZTyn2FtlkgsYWdgCcaVF9rVU1vkhBgHa5tcmYnjiog/9C3ZmcMVledk
 ybZ7Z9UArZPsFI/7UFIU+5DJvX9OigASuam+ZFs02I8xSngMsjECnnckBS1sxF6X5jZkKAEZZ
 AkdwRyQ1VIdihWvWuMG7X2XTqFVBLE9DUSqOUzBj8TqfI9l9+sEXb6DzGr1eLW5zwTsAPiBVP
 J8DknGh4pRFQ24GphIaCzJ2Xsx8I4YJBsLxlhIidF770XwYdMzBVpzvBu0FW3PQyNJ0+8WbnH
 7nld8XxPALkqEBLGGXXBsmtoCtdqpjX6rlUG1mHqQX8hMum1Z5YYbc0lIkTKxmruXE45ZfW0w
 oSConv1RKhuD/7IlUEssENjWNcriD06UuW7B9iuz66mbee8ybx6BBdfF7FXCpoHL9YZ0rZ7Dv
 XLKijfiDe3pQIQ5FNyrS2xGVwBNsPE+7CGYPd1oBEQIct0IPmzSOK8klUBg+bHkk7/7QJHtSJ
 FV2YgK9jg2KSQyyIwDwpccaGe8tKh6+H24tvsByow/q1nET4BALfU5ir0ulu8IBAVqpRilyxy
 fHZbIH3lXJA==
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi brian,

On Sat, 13 Apr 2019, brian m. carlson wrote:

> On Fri, Apr 12, 2019 at 09:51:02PM -0400, Jeff King wrote:
> > I wondered how you were going to kick this in, since users can define
> > arbitrary filters. I think it's kind of neat to automagically convert
> > "gzip -cn" (which also happens to be the default). But I think we shou=
ld
> > mention that in the Documentation, in case somebody tries to use a
> > custom version of gzip and wonders why it isn't kicking in.
> >
> > Likewise, it might make sense in the tests to put a poison gzip in the
> > $PATH so that we can be sure we're using our internal code, and not ju=
st
> > calling out to gzip (on platforms that have it, of course).
> >
> > The alternative is that we could use a special token like ":zlib" or
> > something to indicate that the internal implementation should be used
> > (and then tweak the baked-in default, too). That might be less
> > surprising for users, but most people would still get the benefit sinc=
e
> > they'd be using the default config.
>
> I agree that a special value (or NULL, if that's possible) would be
> nicer here. That way, if someone does specify a custom gzip, we honor
> it, and it serves to document the code better. For example, if someone
> symlinked pigz to gzip and used "gzip -cn", then they might not get the
> parallelization benefits they expected.

I went with `:zlib`. The `NULL` value would not really work, as there is
no way to specify that via `archive.tgz.command`.

About the symlinked thing: I do not really want to care to support such
hacks. If you want a different compressor than the default (which can
change), you should specify it specifically.

> I'm fine overall with the idea of bringing the compression into the
> binary using zlib, provided that we preserve the "-n" behavior
> (producing reproducible archives).

Thanks for voicing this concern. I had a look at zlib's source code, and
it looks like it requires an extra function call (that we don't call) to
make the resulting file non-reproducible. In other words, it has the
opposite default behavior from `gzip`.

Ciao,
Dscho
