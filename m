Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE678C433EF
	for <git@archiver.kernel.org>; Tue, 14 Jun 2022 16:30:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344159AbiFNQam (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Jun 2022 12:30:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343911AbiFNQaa (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Jun 2022 12:30:30 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30AB143EDE
        for <git@vger.kernel.org>; Tue, 14 Jun 2022 09:30:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1655224199;
        bh=m/xSLK1v195K5qU1EUgl41FZcW3CuWn+RIw43bbA0cw=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=XdqagD7Lp2TMxTHDjCaQ13LJpKK5VrLcPxIt0ujwb+5gvP5VNHD95a817JldKRutg
         ZDe+wm881qezpDfUjfJ3KMVjoPU/eqI0Kr3EUuC593gHgpgyK1hs21/s0w3kpzjfoa
         thnknDCV6ZBg4NetwQb2oLoJqXptVQUIBzla4lT0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.19.123.239] ([89.1.215.185]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MgNh1-1nVvLc07Qt-00hstW; Tue, 14
 Jun 2022 18:29:59 +0200
Date:   Tue, 14 Jun 2022 18:29:55 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Rohit Ashiwal <rohit.ashiwal265@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Jeff King <peff@peff.net>,
        "brian m . carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v3 5/5] archive-tar: use internal gzip by default
In-Reply-To: <28f6ec2a-1d94-b29a-4bfd-6a9e74c8edbf@web.de>
Message-ID: <nycvar.QRO.7.76.6.2206141802310.353@tvgsbejvaqbjf.bet>
References: <pull.145.git.gitgitgadget@gmail.com> <217a2f4d-4fc2-aaed-f5c2-1b7e134b046d@web.de> <d9e75b24-c351-e226-011d-5a5cc2e1c858@web.de> <xmqqk09k449y.fsf@gitster.g> <nycvar.QRO.7.76.6.2206141109270.353@tvgsbejvaqbjf.bet>
 <28f6ec2a-1d94-b29a-4bfd-6a9e74c8edbf@web.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1686721276-1655224199=:353"
X-Provags-ID: V03:K1:0aOSrA2k+jCMX9Bs2o9mQwyAUgDVeC1AcBvq/iF4aBHSw882WKN
 2bM9f63QLKSmP3oMO9XvOjUBGwMUUTkBs3tJdVKCHWs0SOEopvdXJyOejy+T3FqbKrL7x+l
 n2SLdU2M1TV4eAaaLmuxHqpmBvTolWqtprhF7GuVjGC/Hy+2y+PD61b5mYjW1gGWrpwj8x7
 dzQAAGXrT3UIQ0nopfpxw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:k8zWL8yxJmE=:3+UFuAAbXD0adfNzyKntIk
 JSQEYn7g6ITMSIphlQncOeJF37uk099kgkith2mdKrTTH8nQYX7fROIs4OOOv0xeKS85PfLw9
 PBpWBBsscnXqHzjqtLYMT2HVInMiiP1WKh/64zBv9urdSE026ppAHnQz1sOFfOEY0GayBmZfX
 Yu2QI7c1BtiQg+dEAzODW7wW9nhJpaZAf3UjGFbMN4eY8OgmrajTBk7aYa6mkPwkaG19kdoTx
 cxR4HwVCJRlIwZ5OQeTPiPKybXF1rw0osTK3HFmJI6nluWfCdcIjTWjLaGgmWobEYyEIjjVSS
 09HcXaEZa6RMzpENBjSrNokSUl4VB2NtnlOJ4WCQ3q9n5N4VZcveNrdLOwUfQ4P85rnKwRC/R
 03UVY+PZNjAeNKdxy0nAsxOOKt3/WmcZ0xhJdaVWLvKNoOLPyvzupPrSGP6EkynulCJuFuPyn
 i5VOCRxhpOShvMldJnhLMmzcTzaZub28m3Crn35hYGFN0bMXJDRqN91Rj94iC0c4R4Mgti7AG
 pY34OTbRWmDgdtHltRFFhWhI+sK7+Zof+wiyDZdlhl2Zo7ce5aNLQW4a/nwh+aKMKRwvFRfYu
 vmBtmWnTIlmnaMju8VRH7IZT5XbKmG2sjmnbq+1IZXcKFBhvjqgLCGdkUy7efaSTLVXPzmN7P
 h95hfPYqzhinTVaHqsIcWur50hPrVp308PngDH5hjPWITDRyT4dXbUCRfCgzN+sg9MufqDSSr
 +HeQ/Wpb1vfaYagyLgdBjdWasPDolKkj+8Qu5I2DvVMNGAPLpSz0lCzjlVbYbIGo5CLl579Am
 h/zwXRJCeFl8SIee160fe2Rb5sSQ07ymOdgIkb3AyGg9x1R2yLo5ER8CG9Fwqr6JlVskdqG5V
 P5tnIMN/8Y0QaVEwYIBKeIXR+8/G1X0KOxffBN+7XA2IBgZm2+omBdwxZjaCIxtc5FAAo0zqb
 6jot7NY0l2UxRx10ytBxpeAQf+noUOltlyexUdC9Fp0Hjgg7VgTsZ99wGH+lNu4vJePkhpv+T
 3JUu/DRqCyfOSxvhUtuZGz+Lx2qX6QOxrIFXIvAqsBXAUs44iHzPXga1wJtJ6WN65/47P6tE3
 t9kR51+hdvvc20ykdYBHbmP4MVhhdAZQ85SGiBQ5DOpIN/wa15bbOsxGQ==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1686721276-1655224199=:353
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Ren=C3=A9,

On Tue, 14 Jun 2022, Ren=C3=A9 Scharfe wrote:

> Am 14.06.22 um 13:27 schrieb Johannes Schindelin:
>
> > The solution is to move the heap variable back into a scope that match=
es
> > the lifetime of the compression:
> >
> > -- snip --
> > diff --git a/archive-tar.c b/archive-tar.c
> > index 60669eb7b9c..3d77e0f7509 100644
> > --- a/archive-tar.c
> > +++ b/archive-tar.c
> > @@ -460,17 +460,12 @@ static void tgz_write_block(const void *data)
> >
> >  static const char internal_gzip_command[] =3D "git archive gzip";
> >
> > -static void tgz_set_os(git_zstream *strm, int os)
> > -{
> > -#if ZLIB_VERNUM >=3D 0x1221
> > -	struct gz_header_s gzhead =3D { .os =3D os };
> > -	deflateSetHeader(&strm->z, &gzhead);
> > -#endif
> > -}
> > -
> >  static int write_tar_filter_archive(const struct archiver *ar,
> >  				    struct archiver_args *args)
> >  {
> > +#if ZLIB_VERNUM >=3D 0x1221
> > +	struct gz_header_s gzhead =3D { .os =3D 3 }; /* Unix, for reproducib=
ility */
> > +#endif
> >  	struct strbuf cmd =3D STRBUF_INIT;
> >  	struct child_process filter =3D CHILD_PROCESS_INIT;
> >  	int r;
> > @@ -481,7 +476,10 @@ static int write_tar_filter_archive(const struct =
archiver *ar,
> >  	if (!strcmp(ar->filter_command, internal_gzip_command)) {
> >  		write_block =3D tgz_write_block;
> >  		git_deflate_init_gzip(&gzstream, args->compression_level);
> > -		tgz_set_os(&gzstream, 3); /* Unix, for reproducibility */
> > +#if ZLIB_VERNUM >=3D 0x1221
> > +		if (deflateSetHeader(&gzstream.z, &gzhead) !=3D Z_OK)
> > +			BUG("deflateSetHeader() called too late");
> > +#endif
> >  		gzstream.next_out =3D outbuf;
> >  		gzstream.avail_out =3D sizeof(outbuf);
> >
> > -- snap --
>
> Good find, thank you!  A shorter solution would be to make gzhead static=
.

I should have said that I had considered this, but decided against it
because it would introduce yet another issue: it would render the code
needlessly un-multi-threadable. And that can be avoided _really_ easily.

Ciao,
Dscho

--8323328-1686721276-1655224199=:353--
