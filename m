Return-Path: <SRS0=sJPh=5P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FA7DC43331
	for <git@archiver.kernel.org>; Mon, 30 Mar 2020 17:37:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 069CF20781
	for <git@archiver.kernel.org>; Mon, 30 Mar 2020 17:37:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="CJANnhKp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bluq86Ut"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729089AbgC3Rhd (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Mar 2020 13:37:33 -0400
Received: from wout1-smtp.messagingengine.com ([64.147.123.24]:59221 "EHLO
        wout1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727368AbgC3Rhd (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 30 Mar 2020 13:37:33 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id E3057705;
        Mon, 30 Mar 2020 13:37:31 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Mon, 30 Mar 2020 13:37:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=WvAskKrbwFmnN3wiOx592NvglZF
        uAi+0r/AwUNe6p88=; b=CJANnhKpUs2W+x9vbTBijMtbxLWTg/GyGHT5mb4lDhf
        8TJHMTXPLdlXaCgperOMC/VCt7KZ2FJJxSHuFqE7Wnt2O3nrg7P5BtXIVNnjSEpH
        eYnhC3UCTsPs59LH5sawS0ZKLI8GRxRER1U+J4wrSyLAI1FH+TNeP65GFrV+iKik
        GLZ4TSj1ezq9WepYEvqCUB7j1wwmx+HrK6PBTv04/kBQylUYPP7VR3G91G3mJAUC
        Rs+Yyca7vXzrXhvV34VNhfJaScYQ8S9nzZSkH4e3d6sBLLMwD11pXZiKbWgxzgC0
        hYXPi+xje/BLBjNWprVfcmnTq0Ucb9PItF0PrQprlPA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=WvAskK
        rbwFmnN3wiOx592NvglZFuAi+0r/AwUNe6p88=; b=bluq86Utm9ejTIBodGC1as
        MZWPBrqCUf5eD4E2pSI0w5SeErrebhHIsz+pf7BpbKDfJ/19+uOAD4CMbUtZURb2
        sOuDjFtHtJKUwcFAwS6KGk3jpt55p+yuXzKQdSX3oAe4TpZNxOIg6g23ZlveRrCe
        6R6KI92wphR6WrmVoPGwkGZ3nTdfG3FmWXFv3QPWog/VU3eYTRDKAdGa8BHzZqrq
        ZQWN0ln4QFQy04FgKeyR/LqP1/URPoQBM/4gJAvGDuZh0oxosrcdtRn0XV+mGLqT
        4rs/ne/6buz/dEjqjUZN3EUD7Atb9/c+8s1kuaVqvvgKS9NbvnhnXcaHnuMbFPWw
        ==
X-ME-Sender: <xms:Wi6CXmPWsDuFOhDDmOT2EWs81TecetFfyHz_7iwo-jtbcE1KEmamTw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrudeihedgudduhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecukfhppeejkedrhe
    egrddvvddtrddutddvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghi
    lhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:Wi6CXkNy4uwq6pnAjnX6f8Fg80cZro8sQXbcnLOA9ZoQd1rO2Ewi8A>
    <xmx:Wi6CXgHNNdkExwff4ta1Nij8FtmMG3sZaUgecxJu5wTwtC3sWgikDA>
    <xmx:Wi6CXuMG1SmDpp1Cfu-2Unw43DblH4EMHOaNxDAfeUw7lrKr_Smu3Q>
    <xmx:Wy6CXkLiMxPE4qNAkruAXGopxD1BZ9Zo98D4gxeJSsaYybU5Xj3D3Q>
Received: from vm-mail.pks.im (x4e36dc66.dyn.telefonica.de [78.54.220.102])
        by mail.messagingengine.com (Postfix) with ESMTPA id 6EB25306CA1F;
        Mon, 30 Mar 2020 13:37:30 -0400 (EDT)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id b56071c6 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Mon, 30 Mar 2020 17:37:27 +0000 (UTC)
Date:   Mon, 30 Mar 2020 19:37:32 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH 4/9] update-ref: organize commands in an array
Message-ID: <20200330173718.GA4837@ncase.pks.im>
References: <cover.1585129842.git.ps@pks.im>
 <50ffc263293571f8af71fd1d253ac238c6909229.1585129842.git.ps@pks.im>
 <xmqqh7y9fq29.fsf@gitster.c.googlers.com>
 <20200330080551.GA186019@ncase.pks.im>
 <xmqqwo7193zj.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="4jXrM3lyYWu4nBt5"
Content-Disposition: inline
In-Reply-To: <xmqqwo7193zj.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--4jXrM3lyYWu4nBt5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 30, 2020 at 09:55:44AM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
>=20
> >> 	for (i =3D 0; i < ARRAY_SIZE(command); i++) {
> >> 		const char *eoc;
> >> 		if (!skip_prefix(next, commands[i].prefix, &eoc) ||
> >> 		    *eoc !=3D ' ')
> >> 			continue;
> >> 		cmd =3D &command[i];
> >>                 next =3D eoc;
> >> 		break;
> >> 	}
> >
> > The reason why I moved those `skip_prefix` calls into each of the
> > respective commands is that this patch series introduces calls that do
> > not accept a trailing space at all. Thus we cannot handle the space
> > generically here, as that would was soon as we introduce the set of new
> > commands.
>=20
> That's not a good excuse, though, is it?  The command[] structure
> can say "this takes parameters" or even "this takes N parameters",
> and the field being zero (i.e. "does not take parameters" or "takes
> zero parameters") would mean you do not want a trailing SP, no?
>=20
> I also suspect that the "extra lines" thing we'd see in a later step
> is correlated with this, but we'll see.
>=20
> Thanks.

You've got a point there. I'll convert this for the next version,
thanks!

Patrick

--4jXrM3lyYWu4nBt5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAl6CLloACgkQVbJhu7ck
PpRRIBAAktLA4JzRrSYejb+Lz0T3DGaEYeMEXYNNQTzUfSmqsjJiuoFmnAuUeqMZ
Bi65sMouCtK1k7GINRKuVUinRdkJ+3H209MJrRb+JQ/CCVbZz4NL6fKj0o/E/g+e
QC1Nox9BcVuXeLw3ddMBEi+paSry59gTV/fx1M0Dg7KmSIWlWLmEycdSd+mdYm3F
AsuqgH/eKIQgZIVn8YszFtFUU2Uc5UylQKv4zOhXZ1X4cGcmasXkdrvldc+qGlL6
2SdwW05DFT3ZQfpG0OJJMy6Zy10+xAA0X9tiQWZ2473TjgJ7tAiGK6K36NJNfC5s
NSpyWaI7ax+wyp9vJt8cJirCEpeuhwRf0wkHh5H3/QbiIIFuiBglvQQHPrbjnInk
ayJif6CTNABW5FHMsFZlb5qoXXEG+rRAUnJh2f6b9E/l31HuxqmpOJWzwoGxKytC
NleibS78sKr2WrzwBCl4kl0ThGm1kbwopYbONUyE4mzGPP1gpI07HnnV+qzCj4lj
sTDAz/f81rRpdqgLw8c2/TFZ5vUq/X+VUp5PiyCot9H+QPYFY3iA4V8hws8ZB/PU
QKIvLbjSdJ9h1IFQpLuGNESj4dPrG3AItYR4ZlGnk4vUKdXqFvGqf+5UI9+ApdjV
mf4qiE20/JQNDEkEhSChPl8m9sdt5O0iFrG9pAGRpxwbbkbHUHY=
=2gIv
-----END PGP SIGNATURE-----

--4jXrM3lyYWu4nBt5--
