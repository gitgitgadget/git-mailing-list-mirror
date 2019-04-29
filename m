Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2A2D71F453
	for <e@80x24.org>; Mon, 29 Apr 2019 21:33:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729409AbfD2VdA (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Apr 2019 17:33:00 -0400
Received: from mout.gmx.net ([212.227.17.20]:40117 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729370AbfD2VdA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Apr 2019 17:33:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1556573568;
        bh=5z6n5zVfHXS0eZbuxBmba8WIcKEWStubRH94qs3t0Ng=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=ZiaXQNErYdylYvRf8GvHJxKl2mD3tWQsQWKGnFCQQ2/7Ql65fMghhlcyvSRXYBEkb
         2Z4sGQlsvrGK51pbtChRv8ryYC7gEWxfSLVdPFSNIZDXXTdnhNl+qs382wEGV38IY8
         p97ID2mXxM3qkQr5TwX1GF4PNGcb7J80H/r63HZ0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.20.96.188] ([12.174.135.204]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LoEcP-1gsUly3IUb-00gJK9; Mon, 29
 Apr 2019 23:32:48 +0200
Date:   Mon, 29 Apr 2019 17:32:50 -0400 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: dscho@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Jeff King <peff@peff.net>,
        Rohit Ashiwal via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Rohit Ashiwal <rohit.ashiwal265@gmail.com>
Subject: Re: [PATCH 1/2] archive: replace write_or_die() calls with
 write_block_or_die()
In-Reply-To: <xmqqd0l8tjph.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1904291732370.45@tvgsbejvaqbjf.bet>
References: <pull.145.git.gitgitgadget@gmail.com> <7a9525a78a7b7b237150b9264cf675a4a0b37267.1555110278.git.gitgitgadget@gmail.com> <20190413013451.GB2040@sigill.intra.peff.net> <xmqqzhouwizg.fsf@gitster-ct.c.googlers.com> <nycvar.QRO.7.76.6.1904261028220.45@tvgsbejvaqbjf.bet>
 <xmqqd0l8tjph.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:Dg+cGewTUgOw9RDFXnvQwXJEfqtskq7t4E1ZknLoM87zMh9LJ31
 +UJebsEJlT3N28g5b3svda8qL1Bt+95DnpLOz1xKgmDAeTPPTwrlhdGY63xMtGWoTkZX7Fm
 atLWUidHPaLUic125zcyzbDNCeIuvki8SnhDNXzipI9DFxNzbPPp2gPkmz+ohWibUuUCFfc
 9LcWksvNtnnwPqMik/xFg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:bzzOEW6Dvx4=:0reNLg6UJKWobaTODMtP5M
 01eeRKmhNPNUr/3TuLB4TGsagCamYJD0XA0oTLzeetVfs8V0fDzx2sFQ6VciS6MfvQqQ0vftJ
 eID1f5zs3wlmsX3D5p+06Pq9QD0F03Psnd6A9oAFmFbOoDuRHov/A0gFRv6BQYtFob2kudiVe
 xyPuOVfcL4GBn/2khS6a/3PpqOBORX0m+F5cm1WunHonluVQFH73YWif01YdlOWsPpM+EnTUj
 rBZt7t/8carVeINf0MbHVmZGbmhRRDFZiVved82UKPYuRlJeAzGKhIQelnoD/2FlRG94se7+I
 EXpYDwjjv/2Gq0lxM/5UAaqvEArTBUECpKWpvwNA081BO7TpoEAyRoXSrufeVZfTXgtE/rt6Y
 ky5ZboegXxOmc0wqHcOZSwhamTqmk7G8X0Dgt9fAu2/e2qkavtAnk/jVf3yOazvAmsOHnHJbX
 WYJ81eICHR2msK6+8jqXrqHvChsxCMe495k7O3bx4/B91hAYlvPu5XEVRojmXBMcWfIeSecS2
 ALz5bq2ErZ95kRgnrM/NMZTa4M4nTxsiI9lv/wC8uunt+fDyml6GKaUB23TFUBp1Glg4gQkZE
 dsG4lfqz72Mb81zBdnXOgnvqmeNmjMdhuRxjtjO5JOGYltzYxhT831a51OXXxRKXesoonGvMT
 F8g21xIjLPE/dt6g7hkK17BaJocvd4w9o/f5jaJIFY5zOL4ZXNx8ozfYKEOQYBw+MSdUXdFk1
 TeXwfWNoGf5jXInoqmX3840CkfUSKYNvlg3bG4uRMeBt0vca4ylb/HNpmedtlqpycihi0RUwl
 ALynqnnKDYWm9bfHTew/v74CsgGLvyalxHx2lTg8TVEdu6T/bQVCvJWzBwVODiaVLoeOT+t0v
 WNsUFzRSHtCMC8e1RLXy6bbe3e620i/MT01JtYhJaQuROzVbk49xPLMSmKAjdzFGPELze7Hg2
 xMZKzmeBzcg==
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Sat, 27 Apr 2019, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
> >> >> +/* writes out the whole block, or dies if fails */
> >> >> +static void write_block_or_die(const char *block) {
> >> >> +	if (gzip) {
> >> >> +		if (gzwrite(gzip, block, (unsigned) BLOCKSIZE) !=3D BLOCKSIZE)
> >> >> +			die(_("gzwrite failed"));
> >> >> +	} else {
> >> >> +		write_or_die(1, block, BLOCKSIZE);
> >> >> +	}
> >> >> +}
> >>
> >> I agree everything you said you your two review messages.
> >>
> >> One thing you did not mention but I found disturbing was that this
> >> does not take size argument but hardcodes BLOCKSIZE.
> >
> > That is very much on purpose, as this code really is specific to the `=
tar`
> > file format, which has a fixed, well-defined block size. It would make=
 it
> > easier to introduce a bug if that was a parameter.
>
> I am not so sure for two reasons.
>
> One is that its caller is full of BLOCKSIZE constants passed as
> parameters (instead of calling a specialized function that hardcodes
> the BLOCKSIZE without taking it as a parameter), and this being a
> file-scope static, it does not really matter with respect to an
> accidental bug of mistakenly changing BLOCKSIZE either in the caller
> or callee.

I guess I can try to find some time next week to clean up those callers.
But honestly, I do not really think that this cleanup falls squarely into
the goal of this here patch series.

> Another is that I am not sure how your "fixed format" argument
> meshes with the "-b blocksize" parameter to affect the tar/pax
> output.  The format may be fixed, but it is parameterized.  If
> we ever need to grow the ability to take "-b", having the knowledge
> that our current code is limited to the fixed BLOCKSIZE in a single
> function (i.e. the caller of this function , not the callee) would
> be less error prone.

This argument would hold a lot more water if the following lines were not
part of archive-tar.c:

	#define RECORDSIZE      (512)
	#define BLOCKSIZE       (RECORDSIZE * 20)

	static char block[BLOCKSIZE];

If you can tell me how the `-b` (run-time) parameter can affect the
(compile-time) `BLOCKSIZE` constant, maybe I can start to understand your
concern.

:-)

Ciao,
Dscho

P.S.: I just looked, and I do not even see a `-b` option of `git archive`,
so I suspect that you talked about the generic tar file format? I was not
talking about each and every implementation of the tar file format here, I
was talking about the tar file format that Git generates.
