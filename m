Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97E10C433EF
	for <git@archiver.kernel.org>; Tue, 14 Jun 2022 11:28:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234631AbiFNL2N (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Jun 2022 07:28:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232149AbiFNL2L (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Jun 2022 07:28:11 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE814393CC
        for <git@vger.kernel.org>; Tue, 14 Jun 2022 04:28:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1655206061;
        bh=Jsdq5CWSgJmchB59HMenGRn/vzKt0rjgX1sCW0b4eMg=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=iVYDdR3FnVS3NJKdY8lQuKQ93brGUqIa7k6I+bIoUfhqZlzG/fTd4vCWzZ+QxfrvW
         OR4bFQh6E4PTQRTUWbnN81D5Yf5cX8k6fx7R8JGmKjU5cg0JNGacsw5bZjskva0V4j
         R22PDjrT4OpI19k45vKUMaS9VjjLLjeUmjkQiSKY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.19.123.239] ([89.1.215.185]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MNKhm-1oLLgV1Qra-00OqCk; Tue, 14
 Jun 2022 13:27:41 +0200
Date:   Tue, 14 Jun 2022 13:27:37 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>, git@vger.kernel.org,
        Rohit Ashiwal <rohit.ashiwal265@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Jeff King <peff@peff.net>,
        "brian m . carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v3 5/5] archive-tar: use internal gzip by default
In-Reply-To: <xmqqk09k449y.fsf@gitster.g>
Message-ID: <nycvar.QRO.7.76.6.2206141109270.353@tvgsbejvaqbjf.bet>
References: <pull.145.git.gitgitgadget@gmail.com> <217a2f4d-4fc2-aaed-f5c2-1b7e134b046d@web.de> <d9e75b24-c351-e226-011d-5a5cc2e1c858@web.de> <xmqqk09k449y.fsf@gitster.g>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1813118815-1655206061=:353"
X-Provags-ID: V03:K1:g/Xfe16oGcgh67DhKDPEZJMasrdsx5QdN5uZvdzxA7KN6bhY5Ac
 XGNcWDVxGHyLJMYWjUtezOriGJEPXp495ko6Z1+K54kumkBmQU2pRrW6c6XsmO4eLG3fSgG
 SHI+q/7lx+1hdUho/7ioBDlwXm3lviubEfvTHMZXuN2OILjsAio2imsuzoTyLG5z3JhA15J
 fqCFRxUEOdRWMC0CyAQ3g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:eXf9xLZxers=:IeFrOiGAcmfSbnvZ+Zv/uR
 +1txY13F7D+5B+Ou2PUpPeRm2vwwDi0/d8fyMqdpn78JwzBCAHItnxrorgitbdWqmTHUoIYDl
 FWupxy8GHysI1wiwInGGhqWS/9mfuVx6b2hltYBm3qJalrSc2DxvIfRyeFG671q1BNBx+DUK7
 WR9FmIkw/1c6v2Lgw7qn8+3NjHK9J7QYjainMxamqKfYBDlbcXR9uwYdlv/XQZqoLsFnEDELP
 XcWCsOV7h7bUmhMLCb2vZXSnI+M7wqiR/ySJ3CSLkqg5ejNbHas73KOzJRXllnvNbUNNDNOmJ
 cKPbd1zTaeGHVVlR49KoHMk/z+SxbeZr1pEKY2yShM2W1eXzaVyHVeJYGTDIwpGH1PHl/49Kr
 Q4KqLTMOhYyhgUBkXh+l2T+nCBDxJfLAeJ2Q8U5pLPtbvFDf1jvCgCTHaC1geNuD2i32nCrl/
 4LcyR2tsJbQrhPnInG6mkh8g+U5A0gl414g39iuf/cp1f8AdA3v3lD29D2TUruAkPitBMW9wt
 FxUrpcAvMas074avX8fJxEXNArXdB+FlhU1od42n5zOrJ+ml1uulv+oWiljtYxqbbrxIIi5H0
 ySmkyqCpxJy1KnXKEOyl7D7nhuKXW9utHvvCxUa45UeXDMEcIUomW5Db7tPOLNgIe9Xdhs0rp
 WZ1wpcrHYeYVy526fHIXpWN4ycwQfCH97m+sPBsiaSQRDy2UmNdPqYmZ0fyfEAGiigaAEvbpB
 3KL1Lqyjgb5DRA5fEPtHTO2mjslYnBNdqhFxQOTOix7q/reraMHHkBms3pDvfj8HlT9ueq45h
 SyvqciMAnErZ4PYS7LSdw+sgbKC/4+omUb1AbZQi69zk+/rTZqYYxGQDT95y+1jCxvKIJeGcB
 hmvjJZYOSbDamutSxFzptf/cTuUAcf11kWJgMUJ1pY4lGvc1KR0CORhaxRqEMC2FA/mmEU23y
 Ui/I18ZSIUvIPZWrGhuJNHcQ28hTjjjBpL7zpytomgP4PjaEURKoAyUwOjaoe2NoQwOyVzaov
 YZuqnMqOZPCQqpJZVXSUxAyMXOhYVxpz3gV2hrml1UqX+alYrQz8F03QSK6mQNEpkqu3NQmKt
 99K91kuhLK08y9OeYl0yd+KQqIc+w723yvYiYuanKZC7q4yrTbH2rWVyA==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1813118815-1655206061=:353
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Junio,

On Mon, 13 Jun 2022, Junio C Hamano wrote:

> Ren=C3=A9 Scharfe <l.s.r@web.de> writes:
>
> > -test_expect_success GZIP 'git archive --format=3Dtar.gz' '
> > +test_expect_success 'git archive --format=3Dtar.gz' '
> >  	git archive --format=3Dtar.gz HEAD >j1.tar.gz &&
> >  	test_cmp_bin j.tgz j1.tar.gz
> >  '
>
> Curiously, this breaks for me.  It is understandable if we are not
> producing byte-for-byte identical output with internal gzip.

Indeed, I can reproduce this, too. In particular, `j.tgz` and `j1.tar.gz`
differ like this in my test run:

-00000000  1f 8b 08 1a 00 2e ca 09  00 03 04 00 89 45 fc 83 |.............=
E..|
+00000000  1f 8b 08 1a 00 35 2a 10  00 03 04 00 89 45 fc 83 |.....5*......=
E..|

and

-00000010  7d fc 00 f1 d0 ec b7 63  8c 30 cc 9b e6 db b6 6d |}......c.0...=
..m|
+00000010  7d fc 00 54 ff ec b7 63  8c 30 cc 9b e6 db b6 6d |}..T...c.0...=
..m|

According to https://datatracker.ietf.org/doc/html/rfc1952#page-5, the
difference in the first line is the mtime. For reference, this is the
version with `git -c tar.tgz.command=3D"gzip -cn" archive --format=3Dtgz
HEAD`:

00000000  1f 8b 08 00 00 00 00 00  00 03 ec b7 63 8c 30 cc |............c.=
0.|

In other words, `gzip` forces the `mtim` member to all zeros, which makes
sense.

The recorded mtimes are a bit funny, according to
https://wolf-tungsten.github.io/gzip-analyzer/, they are 1975-03-17
00:36:32 and 1978-08-05 22:45:36, respectively...

And the mtime actually changes all the time.

What's even more funny: if I comment out the `deflateSetHeader()`, the
mtime header field is left at all-zeros. This is on Ubuntu 18.04 with
zlib1g 1:1.2.11.dfsg-0ubuntu2.

So I dug in a bit deeper and what do you know, the `deflateHeader()`
function is implemented like this
(https://github.com/madler/zlib/blob/21767c654d31/deflate.c#L557-L565):

	int ZEXPORT deflateSetHeader (strm, head)
	    z_streamp strm;
	    gz_headerp head;
	{
	    if (deflateStateCheck(strm) || strm->state->wrap !=3D 2)
		return Z_STREAM_ERROR;
	    strm->state->gzhead =3D head;
	    return Z_OK;
	}

Now, the caller is implemented like this:

	static void tgz_set_os(git_zstream *strm, int os)
	{
	#if ZLIB_VERNUM >=3D 0x1221
		struct gz_header_s gzhead =3D { .os =3D os };
		deflateSetHeader(&strm->z, &gzhead);
	#endif
	}

The biggest problem is not that the return value of `deflateSetHeader()`
is ignored. The biggest problem is that it passes the address of a heap
variable to the `deflateSetHeader()` function, which then stores it away
in another struct that lives beyond the point when we return from
`tgz_set_os()`.

In other words, this is the very issue I pointed out as GCC not catching:
https://lore.kernel.org/git/nycvar.QRO.7.76.6.2205272235220.349@tvgsbejvaq=
bjf.bet/

The solution is to move the heap variable back into a scope that matches
the lifetime of the compression:

=2D- snip --
diff --git a/archive-tar.c b/archive-tar.c
index 60669eb7b9c..3d77e0f7509 100644
=2D-- a/archive-tar.c
+++ b/archive-tar.c
@@ -460,17 +460,12 @@ static void tgz_write_block(const void *data)

 static const char internal_gzip_command[] =3D "git archive gzip";

-static void tgz_set_os(git_zstream *strm, int os)
-{
-#if ZLIB_VERNUM >=3D 0x1221
-	struct gz_header_s gzhead =3D { .os =3D os };
-	deflateSetHeader(&strm->z, &gzhead);
-#endif
-}
-
 static int write_tar_filter_archive(const struct archiver *ar,
 				    struct archiver_args *args)
 {
+#if ZLIB_VERNUM >=3D 0x1221
+	struct gz_header_s gzhead =3D { .os =3D 3 }; /* Unix, for reproducibilit=
y */
+#endif
 	struct strbuf cmd =3D STRBUF_INIT;
 	struct child_process filter =3D CHILD_PROCESS_INIT;
 	int r;
@@ -481,7 +476,10 @@ static int write_tar_filter_archive(const struct arch=
iver *ar,
 	if (!strcmp(ar->filter_command, internal_gzip_command)) {
 		write_block =3D tgz_write_block;
 		git_deflate_init_gzip(&gzstream, args->compression_level);
-		tgz_set_os(&gzstream, 3); /* Unix, for reproducibility */
+#if ZLIB_VERNUM >=3D 0x1221
+		if (deflateSetHeader(&gzstream.z, &gzhead) !=3D Z_OK)
+			BUG("deflateSetHeader() called too late");
+#endif
 		gzstream.next_out =3D outbuf;
 		gzstream.avail_out =3D sizeof(outbuf);

=2D- snap --

With this, the test passes for me.

Ren=C3=A9, would you mind squashing this into your patch series?

Thank you,
Dscho

--8323328-1813118815-1655206061=:353--
