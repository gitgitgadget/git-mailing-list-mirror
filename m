Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDF68CE7A81
	for <git@archiver.kernel.org>; Mon, 25 Sep 2023 12:51:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230208AbjIYMvl (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Sep 2023 08:51:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjIYMvj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Sep 2023 08:51:39 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2144CC6
        for <git@vger.kernel.org>; Mon, 25 Sep 2023 05:51:33 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 5E8445C0055;
        Mon, 25 Sep 2023 08:51:32 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Mon, 25 Sep 2023 08:51:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1695646292; x=1695732692; bh=lw
        pkRAQlIGShmNP2gpUhfjEd/+xw/eaw5BhBerlhUSE=; b=VIurVsSr3nnMGOlS14
        Oa8bPwWIZ/a1a1KivtX5wc+HQsJinc4lF4+eGdaYjx3Hj19Fp/SpO/HdbmRSVc7x
        WlpWcvoK/zQ1j8Ot6CGFStppsfK6AYobkthvl+RnUfthBlkrGyr7W9MsdarvxV66
        T09kSoMGHi4i/autqx7edc7+Zfg5WGOB2MQB8xFOoVq99OMKXDW60lfaTe5/08Z0
        gTlbkIe2S6ybbZr3o19VqiyzyIAqplHnzby8inA9495ojWrLZlmM3Km35/bbj5z2
        cXJID9reKDKUdlslGZfoO36wovnRsShcIFDGP1vQ89rXvnEzSqqo3P0ccFSsj1Ki
        9tKQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1695646292; x=1695732692; bh=lwpkRAQlIGShm
        NP2gpUhfjEd/+xw/eaw5BhBerlhUSE=; b=Gu3ojjnX8iMxpHNEUls4wQCCzJVNb
        p1O1Z+8MBtipG4jVLiWaz5Gt8tIMqybuTsqGJWQTXgO1f/ugoq69OzRfMvqWwNA8
        1qk+5XrAy3X8mkT5VZBqAwRkwI04bhEozw/0cfHbGd38Isqhv5/GNDN18xT4MS8r
        gjtHyhh20Vq2OG959SHQ34oea3ixwBZ/loXVIkeRr/yAzju9mJIch3pj7y07mhBZ
        I8mF158ohbmVSof8cKx7B1Z3Ngt5zWBlfOvokD8Tp4Mf4hi0L37PlVya/tw+0Pwj
        XVUXBEnqfzbD/N8x6KUjAn7DMkTKuG+T+fuZlk++x1MGh6NlviG4XD1kg==
X-ME-Sender: <xms:VIIRZeCgOvyrCDKL1T-lJyZ_VIGms1B4mY1HGrJm0jiKQxkPsiiooA>
    <xme:VIIRZYjb9ecMkwDpjTf5DTbab8T_AwgD_R-I1GP2jXz2BjFBUKzxgFtrfEX_lYkRq
    7BnMKlHZcXrudHfKw>
X-ME-Received: <xmr:VIIRZRkBq--zkzucD-WRYyKEGvyIS0eOIcqjsFaCE3wyGuYNzqwEHqn_LPGlIy_V5VBcSj7UeM8OaqHUQyDlJnWmKhU3k6ev0_ZpUW3GsJHb>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudelgedgheehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:VIIRZcxZu6T17IhkOlpqjjNdb4OQxw2W3MHaXUYoAQZVX51Ex-5KUw>
    <xmx:VIIRZTRIxmK07sKcI9Z_zEbsH_ttHQs0k4sEGLpJkKggaR2oiFbm3g>
    <xmx:VIIRZXYSIlxAvQl9J5D5xFrnW0YfKJGp9UqpTtarUWa2OMyFkQk6EA>
    <xmx:VIIRZaJSv2Kx4SFgV5q3Cc71Mq8nX-tKKv0d1_utxHUrl9npB2FaYA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 25 Sep 2023 08:51:31 -0400 (EDT)
Received: by vm-mail (OpenSMTPD) with ESMTPSA id 00af04d9 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Mon, 25 Sep 2023 12:51:30 +0000 (UTC)
Date:   Mon, 25 Sep 2023 14:51:29 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH] revision: make pseudo-opt flags read via stdin behave
 consistently
Message-ID: <ZRGCUYxsN_jgkmCO@tanuki>
References: <b93d4c8c23552abab64084b62f27944e7e192c0c.1695290733.git.ps@pks.im>
 <xmqqmsxf5owk.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="EgtN0nvF1XxOV6zE"
Content-Disposition: inline
In-Reply-To: <xmqqmsxf5owk.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--EgtN0nvF1XxOV6zE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 21, 2023 at 12:04:11PM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
[snip]
> > Signed-off-by: Patrick Steinhardt <ps@pks.im>
> > Reported-by: Christian Couder <christian.couder@gmail.com>
> > ---
> >  Documentation/rev-list-options.txt |  6 +++++-
> >  revision.c                         | 10 +++++-----
> >  t/t6017-rev-list-stdin.sh          | 21 +++++++++++++++++++++
> >  3 files changed, 31 insertions(+), 6 deletions(-)
> >
> > diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-lis=
t-options.txt
> > index a4a0cb93b2..9bf13bac53 100644
> > --- a/Documentation/rev-list-options.txt
> > +++ b/Documentation/rev-list-options.txt
> > @@ -151,6 +151,8 @@ endif::git-log[]
> >  --not::
> >  	Reverses the meaning of the '{caret}' prefix (or lack thereof)
> >  	for all following revision specifiers, up to the next `--not`.
> > +	When used on the command line before --stdin, the revisions passed
> > +	through stdin will not be affected by it.
>=20
> Do we also need to say "when read from --stdin, the revisions passed
> on the command line are not affected" as well?  I know you have it
> where you explian "--stdin" in the next hunk, but since you are
> adding one-half of the interaction, it may be less confusing to also
> mention the other half at the same time.

Doesn't hurt to make this more explicit as well, yes. I'll send a v2
that adds this bit.

Thanks!

Patrick

> > @@ -240,7 +242,9 @@ endif::git-rev-list[]
> >  	them from standard input as well. This accepts commits and
> >  	pseudo-options like `--all` and `--glob=3D`. When a `--` separator
> >  	is seen, the following input is treated as paths and used to
> > -	limit the result.
> > +	limit the result. Flags like `--not` which are read via standard input
> > +	are only respected for arguments passed in the same way and will not
> > +	influence any subsequent command line arguments.
>=20
> Other than that, looking good, and the changes to the code look all
> sensible.
>=20
> Thanks.

--EgtN0nvF1XxOV6zE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmURglAACgkQVbJhu7ck
PpSRYQ//TEuDiZQ9uu5JG3Zl3q4I23sjHszpbWoayfNRreJmCIvm6D/qTlUskMv5
+lUunq6Nkc3+qHFr0Igdxw3X93OX50Z/zPfyKirzDBswgrpKeXTk1F2+2libyHGo
jDFCRCi3cl0MXu171TYnCkdotFTkjBvUj5l5MnRN+1rxlVJ3PkDEpitMkIP0BnF+
TwTycSoD5x1Nh6Ks5yYPkpdnV+gQhdOsQLW0wBAv07uRMxpykue7mDLRY94+lYMx
T3nsM2gNJCc0AYhx0s2/ycW5TsBLTjk7sKnix2t5YJilHt3VCrzVNKQ3cFjId7Bl
kro/affR9nMABJ0wWA8Kp8GFDwqWJu/wJiyo3uGHUpihhhAmFOwLNC+5gCpKW/mj
UdGiRSzZpfDWtl8wLwlrbIDSCT4PI/Jus8CfZJKOJrjVnpvaWomWl0RaHOeXc91S
vlq/He84m66idVI3Ta5EBfY8RqonYxjlAqHYG1phlZX48vRmwG2ycJDSwEvrl/6x
O3+UPgWfm53vUeXRQpBqfXu3koMkAomehHOIl5oeD4b+TD8kwPtf4qHYXRhNDizn
Ou7nF7mHs3KjmWNypswcvkue95Xtgk0ZyiXRL6o0+hwsP245FFydDLMyEWxZIcMK
KhmYM1FuB3n/wmDbYHmqF3ySfXQ/0TC29lMquLcqzlh+eRK9erI=
=+CiE
-----END PGP SIGNATURE-----

--EgtN0nvF1XxOV6zE--
