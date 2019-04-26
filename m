Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5555D1F462
	for <e@80x24.org>; Fri, 26 Apr 2019 14:28:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726253AbfDZO22 (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Apr 2019 10:28:28 -0400
Received: from mout.gmx.net ([212.227.15.15]:56765 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726060AbfDZO21 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Apr 2019 10:28:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1556288895;
        bh=gPtri+9pmbKMcTR2UB2ip4RO2mHIzdlpW+Qbvga1GtM=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=Um1pfZ52hv6LXKfgLkTIP0DKuSSnsfpO1SX+LKQHMv16h+lzRuntr81FraSlxt/hA
         uf7ctACHn7g/DyUQWEEz8YzHf6MzVRs6MXouv4xMp+DtvP2eZEJR0sAjqZxUdIxPGD
         8g4+MZKIIBVLpQO6I5vvpLJ4V8eAw+Qczl2Ux3Ss=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [10.106.210.8] ([167.220.152.136]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MgeoI-1gseh906V2-00h46h; Fri, 26
 Apr 2019 16:28:15 +0200
Date:   Fri, 26 Apr 2019 10:28:12 -0400 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: dscho@gitforwindows.org
To:     Jeff King <peff@peff.net>
cc:     Rohit Ashiwal via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Rohit Ashiwal <rohit.ashiwal265@gmail.com>
Subject: Re: [PATCH 1/2] archive: replace write_or_die() calls with
 write_block_or_die()
In-Reply-To: <20190413013451.GB2040@sigill.intra.peff.net>
Message-ID: <nycvar.QRO.7.76.6.1904261026070.45@tvgsbejvaqbjf.bet>
References: <pull.145.git.gitgitgadget@gmail.com> <7a9525a78a7b7b237150b9264cf675a4a0b37267.1555110278.git.gitgitgadget@gmail.com> <20190413013451.GB2040@sigill.intra.peff.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:Ik9AMqhjCZ6xCP0D7iWJ4AO1WdWIcqOdjpnIJo4r6a7GtQ0TEGD
 djqHn8j7Ssu3nTuXzHkkKgqbTJxeLtu1PjO0ayH606eyaJDmp+944YliAp2AjkNeziieWLj
 QUteXv/CSe25Q/Z8GeXUIxjcT6kkDsDVNVqLg2uArzjbFgOhPp7h503dIYJGFH1YrzXqhOG
 cm20+Ar1ZGI2KpH5PsSYQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:GTy80DHz/f0=:C5Z5zI02AaoYaJ7s6Myzco
 RMImrPxBEywyf4TQXmyI/VMhz9Tup5e3/GNWaeVUg8sNqwVhoNyMDidU7p0yt2tTyK+u9kAQy
 lc8FIBs8C9YcBQGBnA/SvPKKBAAInQU0Vt37cw/JZMm94MENZppVG/Aw2g6dWANZQQadikRua
 BRleChRDCvWdR7uvs5O1IYidd4RShhpN2fHKd+JFcRpAlt/iNprSRCwUELCfRcMU9aFDAY2dS
 sVsytepX5s0J88cXOI7I2UAX4DBvwYcdcXuVdIMMtq5cX1/v9R+eHOibWQzVLu386B7TZ/nLn
 LzdxhAVRD2/bkOY3zT1cavOgz35a6DCTBG4DOuPbbHG/Vi3kyrrwbPu8bThNgrHIIlWxhdHT8
 Y+S6U/cAek0tGBmZw3HcBleRP1V+a5xXvtxnEQM8CeB9gj+TBU/zzoM2WS65lvH3Qos2p1Z+3
 XWlP62eIeCT96MBDupBwanPQkQjzda+DhyuZZfTrki0AWZZU6U7EaMbCIcDexkUE44s4Q0/wQ
 10A05r9UfHKilLUCB0Sjk8Rm44bzt7JkNcE9H1qw5tGPxHQxeG5YCjJzWq1IIcvN5p5Z9BsU2
 fe9b/YzXBKuJVCJeH3KoYFdMR07G3LMX4HZDrB6cCwHNi9eN63hMuPUG6+vF6Ep3/D9dFUeQs
 uNM8YHiTcTzPe/H6Uunaa/gIyVQ3ipxNlFMglEdmex8NhrT0M7itOgI06yesj7RrAwdVOFIGC
 IG71vI9Mx81WZn7SEUfQQZyen04ETLvl+VCW62zlWLDEj1Do6YmluCbrJJ7oRVswUuUcMssM1
 RHuo0uj/cA2dZ43kJzNzhDTvRsJXxuyKxW708dov8XMjhWpUuvjurQ9cHP4osWtHSeq/I5Sbk
 XXSWJ3Mb441pCDTMLXk6TOsh5DtxhyMzCHA8IbUoN7zu4g5d/v3ScB3WwoDhbRVuo+LCHsY04
 RZYbcV6CCzw==
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Fri, 12 Apr 2019, Jeff King wrote:

> On Fri, Apr 12, 2019 at 04:04:39PM -0700, Rohit Ashiwal via GitGitGadget=
 wrote:
>
> > From: Rohit Ashiwal <rohit.ashiwal265@gmail.com>
> >
> > MinGit for Windows comes without `gzip` bundled inside, git-archive us=
es
> > `gzip -cn` to compress tar files but for this to work, gzip needs to b=
e
> > present on the host system.
> >
> > In the next commit, we will change the gzip compression so that we no
> > longer spawn `gzip` but let zlib perform the compression in the same
> > process instead.
> >
> > In preparation for this, we consolidate all the block writes into a
> > single function.
>
> Sounds like a good preparatory step. This part confused me, though:
>
> > @@ -38,11 +40,21 @@ static int write_tar_filter_archive(const struct a=
rchiver *ar,
> >  #define USTAR_MAX_MTIME 077777777777ULL
> >  #endif
> >
> > +/* writes out the whole block, or dies if fails */
> > +static void write_block_or_die(const char *block) {
> > +	if (gzip) {
> > +		if (gzwrite(gzip, block, (unsigned) BLOCKSIZE) !=3D BLOCKSIZE)
> > +			die(_("gzwrite failed"));
> > +	} else {
> > +		write_or_die(1, block, BLOCKSIZE);
> > +	}
> > +}
>
> What is gzwrite()? At first I thought this was an out-of-sequence bit of
> the series, but it turns out that this is a zlib.h interface. So the
> idea (I think) is that here we introduce a "gzip" variable that is
> always false, and this first conditional arm is effectively dead code.
> And then in a later patch we'd set up "gzip" and it would become
> not-dead.
>
> I think it would be less confusing if this just factored out
> write_block_or_die(), which starts as a thin wrapper and then grows the
> gzip parts in the next patch.

Yes, I missed this in my pre-submission review. Sorry about that!

> A few nits on the code itself:
>
> > +static gzFile gzip;
> > [...]
> > +       if (gzip) {
>
> Is it OK for us to ask about the truthiness of this opaque type? That
> works if it's really a pointer behind the scenes, but it seems like it
> would be equally OK for zlib to declare it as a struct.
>
> It looks OK in my version of zlib, and that library tends to be fairly
> conservative so I wouldn't be surprised if it was that way back to the
> beginning and remains that way for eternity. But it feels like a bad
> pattern.

It is even part of the public API that `gzFile` is `typedef`'d to a
pointer. So I think in the interest of simplicity, I'll leave it at that
(but I'll mention this in the commit message).

> > +		if (gzwrite(gzip, block, (unsigned) BLOCKSIZE) !=3D BLOCKSIZE)
>
> This cast is interesting. All of the matching write_or_die() calls are
> promoting it to a size_t, which is also unsigned.
>
> BLOCKSIZE is a constant. Should we be defining it with a "U" in the
> first place?

Yep, good idea.

Ciao,
Dscho
