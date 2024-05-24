Received: from fhigh8-smtp.messagingengine.com (fhigh8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C12E8749C
	for <git@vger.kernel.org>; Fri, 24 May 2024 06:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716533907; cv=none; b=mc0VdbAjTvl64FR51bDxtg2lW19/RB9GwsH9k4WItjQtCVHxyMC2LCEdbu4uF2qpeDH4+HOX8nixEaAT4x6d8lXvJUwaRQDtSFn4pewulY2kccPZEQIn8u0XASB+91diRFk4C9k8F3OVNd+upPfomfidDd/o7qjrjSsA2NQo4HQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716533907; c=relaxed/simple;
	bh=QQXfnFrG/IFCOwoB4JX9Ppl/T6k06/9e846nudGlI0Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kEjd5LPnnMPQU2DnRFoFNhY7JzH5XnRPSyvhB94r19xaHwKsxICrd7nx35dp2Wwub7hjftu05OpTosBd7G1MUrmoRsAaTrLUanJ6XBlKffJzVBNGr6e94E9p2bUWbFiYkbLuCBf6gxhDe33oMpJpPEzeub/oPhiK0tohte98tYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=De7a2kxd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cDKcNToD; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="De7a2kxd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cDKcNToD"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 13D9111401C4;
	Fri, 24 May 2024 02:58:25 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Fri, 24 May 2024 02:58:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1716533905; x=1716620305; bh=r0wY7mCZYL
	KemOrOZd4iA9X7eVTc9Q4zEK9W+qPwAMQ=; b=De7a2kxd61y6GAMfLIzzLhnOTz
	rQ7D5Hm9Z0/x+4bUitu14WYjPiawgJg/8/tfArkvPcckYnH9m3p3dpNfsPx89hKm
	tu/n5qEuK1rfJhU6VVd4WECEBK231Zs7gWQ0bNl/uTFBo2LsCN8D5fivLcfjXJYZ
	IP9FSY7unAoMdwRL/E+laTzs3Ocj3JGGmNZzDfTuj6QRiRu7dw6Z9zPOeqRULLe4
	wvJ/fkgbH22ubbnIPugqcW7umbXAGOYUlvIxDB8gsYveUTAe6NR60lRSZGYEmVaJ
	U6gOoMqfwZ0ZihhQnHS19vYda5wMY6xkUla17tZ1oP9eS6v4O8sfN/n/sLxw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1716533905; x=1716620305; bh=r0wY7mCZYLKemOrOZd4iA9X7eVTc
	9Q4zEK9W+qPwAMQ=; b=cDKcNToDP4SWVo2jUOH50reCIJQKo4x0oTqBnND9cpOf
	gdabLrLAzZkaROcMsOjTdv5sH6ZqKARdC25F9bs67d3fJ/W9XCKN/C/VDZ5CKtxZ
	Wih8t1gM+R/mQomFWvRvA+M6ytTqS9QOVPWfk2r8qTixikyURm6PCYh2Venm3o1m
	IcADsz5hLmxSz2twhitC/OyyEDl1/HJ5VDoL9nTPAXoKcva5o/vo6jErXch9/V0b
	FAEeYt4ut/eH5sk9Bpyy1rNJczLaa/qaK1kbPhrO2a87bHv3jPhaCRFU3WjbKMF6
	B2XZYEhTWGx8V8pkAWp9BRUJGEW8iZMgVecDhtxfLw==
X-ME-Sender: <xms:kDpQZhXpZVzfBleRweulchA0TP3k8wvmInCsGkE4wJgeZtc9UrUpgg>
    <xme:kDpQZhk4H0QLSUJit-F2dCKD6zbedfz2xYLfBOmrjX-zJHPPzPSYvIoUZfjAWOrQg
    D9sLqYWFKG6ujvXCA>
X-ME-Received: <xmr:kDpQZtawHWqkBiLDD13oKnrR7mksUolckFy01XTbatAZgxrFtkmwqynl_f_6o-Q_tElbaNbWr1tG6AcNLWnigDR1U-S6dk4Z5tRMbBaHVGEly9g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeijedgudduvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesgh
    dtreertddtudenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhs
    sehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepfedvleefueetgeeitdekheelffekke
    fgffduhfduvdefffdtheekiefhkeejkeehnecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:kDpQZkX7r7mcmr3WPGj9voQJZHzGPCHgHlJgTLwdzsecK2CObhrxoA>
    <xmx:kDpQZrm-jeGuAOQK6qd9vAHZ2fc2wA-cKfL1eds_HmRM3Umzvs69YQ>
    <xmx:kDpQZhcHJyR1j-QxbkogMSG7BtUEnjMzMt_mADfPbs7JNFZYwxOI1A>
    <xmx:kDpQZlFAzmJAeFh2Y05YFPs91qlCEGMXyG1VjUYAJDcAijbNzdh9mQ>
    <xmx:kTpQZgyKQlHnY3LeP2olc3dvtezvQN-hJ0lBA_3jgv8vBiLllLJOrJPF>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 24 May 2024 02:58:24 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id f6532b62 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 24 May 2024 06:58:21 +0000 (UTC)
Date: Fri, 24 May 2024 08:58:21 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 12/20] config: plug various memory leaks
Message-ID: <ZlA6jZmKomOu1p_S@tanuki>
References: <cover.1716465556.git.ps@pks.im>
 <b2f8878b55564c4bf4848642e419c44c1a9d9005.1716465556.git.ps@pks.im>
 <xmqq7cfkv4cr.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="B5qbT9uZ5EyXiLb9"
Content-Disposition: inline
In-Reply-To: <xmqq7cfkv4cr.fsf@gitster.g>


--B5qbT9uZ5EyXiLb9
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 23, 2024 at 10:13:24AM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> > diff --git a/t/t4210-log-i18n.sh b/t/t4210-log-i18n.sh
> > index 75216f19ce..7120030b5c 100755
> > --- a/t/t4210-log-i18n.sh
> > +++ b/t/t4210-log-i18n.sh
> > @@ -1,6 +1,8 @@
> >  #!/bin/sh
> > =20
> >  test_description=3D'test log with i18n features'
> > +
> > +TEST_PASSES_SANITIZE_LEAK=3Dtrue
> >  . ./lib-gettext.sh
> > =20
> >  # two forms of =E9
>=20
> You've been sending your patches as "multipart/signed" (which by the
> way was cumbersome enough for me but that is primarily the problem
> with Emacs/GNUS and we should handle multipart/signed well), whose
> header reads like so:
>=20
> Content-Type: multipart/signed; micalg=3Dpgp-sha512;
> 	protocol=3D"application/pgp-signature"; boundary=3D"ovDSRLSkA00eIgbN"

Well, signing is of dubious value anyway, but it does have the upside of
stressing our toolchain a bit more and thus making it (hopefully) more
robust :) If it bothers you, then I can probably stop doing so. But for
now I will keep it as-is.

> The "message" part in it says that it is encoded in iso-8859-1:
>=20
>     --ovDSRLSkA00eIgbN
>     Content-Type: text/plain; charset=3Diso-8859-1
>     Content-Disposition: inline
>     Content-Transfer-Encoding: quoted-printable
>=20
>     ...
>     diff --git a/t/t4210-log-i18n.sh b/t/t4210-log-i18n.sh
>     index 75216f19ce..7120030b5c 100755
>     --- a/t/t4210-log-i18n.sh
>     +++ b/t/t4210-log-i18n.sh
>     @@ -1,6 +1,8 @@
>      #!/bin/sh
>     =3D20
>      test_description=3D3D'test log with i18n features'
>     +
>     +TEST_PASSES_SANITIZE_LEAK=3D3Dtrue
>      . ./lib-gettext.sh
>     =3D20
>      # two forms of =3DE9
>=20
> But the source in t/t4210-log-i18n.sh actually is written in UTF-8.
> The thing is, the "-u" option (recode into utf-8" is supposed to be
> the default for "git am", and it is passed down to the underlying
> mailinfo machinery in builtin/am.c:parse_mail().
>=20
> But apparently that is not working correctly.  I see in the patch an
> unrecoded byte E9 in the resulting patch file that is fed to the
> underlying "git apply" machinery, failing the application.

Hm. I'll double check mail headers before sending out the next iteration.

Patrick

--B5qbT9uZ5EyXiLb9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZQOowACgkQVbJhu7ck
PpQedw/6An5JPrAy5tROLDk//vYwHYqBeGMRPRh22LZNWtNABAjyMFJo7WKgIfQ/
H2IUjknmMuwTtTv4/JZOsBy4/e/OwXO7bFCIC78WeKUqnEC08VBKv68jSKaMhC0Z
7ze30lYShxqAKaz8Yk6znfcwr3jeVCLbSjlodP9LM9PTWX3s2TsY9sYQBIsPq8qM
ISVMa0A0HWYquuwWVC3815C1O02Pvj4oIezP4/pg53MMp3XR/UfK0J0xLUI+H/5p
pLsW0TBHyNfBgUOsDtl198/+TSmCKsxJIEiyV4rT5eCDyNcGt3WjIcA9e19HxGPD
euy6E21o0qt3mCCz7l0zanGdC1RvuLj7x7VzpSkTpiZFQwHPBZnf7TGTPuZkQL53
TWeISmVusxpgVjCJJWehebLDTAZvT9CEXqPbTzseZkIsLK7cSLJKSUVF4mBRD+Yn
zVftMOnNT9HfhBIIwRBI92m8oy/y26q3fhtNheF3292X0P+75tm0RmIHhcipfvJm
IQHHk820ySyisDdcTu9ME+sM8OCd69PlRTQq+YffW+oIjjhfX5okcty9bx2u2m3Z
ALp04PnKMr1Ary7qV+cwrq9XX6Qm+Tk7uk5GbkG0zou8u+OoT/MkgsPs+swVaEDr
P1vD3Zv8BvwpQKAdH2vRm9KCOJBdiJeT15TG/29cvj8C2vxTuqU=
=Pgvi
-----END PGP SIGNATURE-----

--B5qbT9uZ5EyXiLb9--
