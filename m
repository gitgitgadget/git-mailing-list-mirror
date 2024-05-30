Received: from wfout5-smtp.messagingengine.com (wfout5-smtp.messagingengine.com [64.147.123.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AF2B25763
	for <git@vger.kernel.org>; Thu, 30 May 2024 04:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717043937; cv=none; b=bRdW8+2SybkCucubEQyZQp8C+u+rNHU1IVByWJ6zI5fl2MkLPD9UuTI4nQG80O/pqEQYAD9R4BL955929uEtyYKl6DPUR3oNikuliMmmssnvNVM/iKx7M0Mb+oFi3NnlmRKXThXCURaP8JGWTmixvZ0gbVvqjROnYUJ9aKwUoaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717043937; c=relaxed/simple;
	bh=vqBGDeYCg7dyJJxR+0gxhKcnZ2SU5BfTYVxXX7tTFJU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h9t6I8Mznn+PQce5kZ///zlBgC9usm7DHqOxjoAkQntypWKRsDOJ/XjZ9G8b5OKGNoOJuqEorn3XFDk/FlrL4N/BtpKm89zLwXN/Cbbe0quscUDKPFeyklm1XBZbTmQH9dSExMaOY/lm9FOy7bl96tef0yGzBkSKcgqlI6Bqt0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=O/zFG703; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EyqKOhD6; arc=none smtp.client-ip=64.147.123.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="O/zFG703";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EyqKOhD6"
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfout.west.internal (Postfix) with ESMTP id 61A6A1C0005B;
	Thu, 30 May 2024 00:38:54 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Thu, 30 May 2024 00:38:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1717043934; x=1717130334; bh=mgq+CwRNfH
	k/xgmVDKXLBUWtsLjgdTYamgkANTnYQxU=; b=O/zFG703m2EX+XhshtPUSs0iwu
	SsbpjyPkqQwbJ1rK6pxs6NMVh57jgWb8VwbBkDwYOAD2FHKTP8bagPEXD+LvF18U
	68o9w5Qjp+LIpUJBnG/xES/n1+wWhLyILT+7gZFMVMHvtvh+XcZq4Re7NKVIuDBs
	Wh+xjlkVRc2uryAFjbHvyYesMkooHGNeXOTn1j4uiMMO6TY4wgf5IlLhufP3Dra6
	cbqSE54DOSvXMZGyXRqy3SukzXG+J3bCIv7AqEM3DtZzr8V1jjTwYbmC5WLm0EmS
	g7uxUlObZZE+ss9GPmovwKpqfr8BUEIQUA2YbiXrYKDePDBL2L4cfiYIUdyw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717043934; x=1717130334; bh=mgq+CwRNfHk/xgmVDKXLBUWtsLjg
	dTYamgkANTnYQxU=; b=EyqKOhD6NPJLaJz2P8UMfq0WSOpiK9waD267cAtFYjp6
	hkLtID2ir29f7xFSuUwix9eO8hVYs26XzsZFvm2H07Ky/JtJBxTCHcaYvirVkqAK
	6mGgsfpH/CvFz4evdcaAYV3fKsQE7Eo6c40UbULNLteoTLTSBde1GLJDpPQCj63B
	EXyP2BuU3IRNfsA2bbAxQE2zqJpEmEUux8ZtSq3cmPGcq0qO43skQhg7f1wMjNdL
	UFk9LlbY5umWRrYo3xBxfdHeJ6Z69tvypZWTRFbOZWKyO3aj+lNZzYZgmiHQttew
	d83/KhItbG5k0dhSl0mKVp8Nl07xaZRaTz2258Z21g==
X-ME-Sender: <xms:3QJYZknEjLY-JlpF2v6kpUBXqGysX1H5t2rp_eikYqy3G0uP0Lo3rQ>
    <xme:3QJYZj1Fi7t8UEgKebi0ZnC4zc_MS0jZzIuu1fbsQ0ZjIGjxBmV-Ca1vq7-pER-eH
    QOykK27l_KxyZTfiQ>
X-ME-Received: <xmr:3QJYZiqhHayZU63Jx-UNU1pefJhHSV_RQx59eN0JNa1lxEWWbk743crYetELru3he-BAxuJvw_cJVlv9PyCzs1x4jjmw1yIiBGLV5IF0W5luNr8s7Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdekfedgvdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:3QJYZgnHBCuCV6_lINUxrId5fsJx7eL8d21WWIJ7j54wio2UtvM-PQ>
    <xmx:3QJYZi2ZaiJ8Gwu4cLsDnxGPTxbf9rIuxfZzALu9j2D95aoKsy6ieg>
    <xmx:3QJYZntCZCkPcJbx31vMritnWjO7eTgQXpbQTGYXKQ7GrZ2bUaD7rw>
    <xmx:3QJYZuVhbBmU2fXCjj-pLcs3YRMfPF_Ei9VxU1kNC7kZIsY1iIXh0w>
    <xmx:3gJYZu_ZMJlAihxO1T0yQLo76rdVgmC3ypVKZWkyRpRY6J7gyYXuY-MY>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 May 2024 00:38:52 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 65013b00 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 30 May 2024 04:38:36 +0000 (UTC)
Date: Thu, 30 May 2024 06:38:49 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Xing Xin <bupt_xingxin@163.com>
Cc: Xing Xin via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org,
	Karthik Nayak <karthik.188@gmail.com>,
	Xing Xin <xingxin.xx@bytedance.com>
Subject: Re: Re: [PATCH v3 2/4] unbundle: introduce unbundle_fsck_flags for
 fsckobjects handling
Message-ID: <ZlgC2TaXGjcNv2C0@tanuki>
References: <pull.1730.v2.git.1716208605926.gitgitgadget@gmail.com>
 <pull.1730.v3.git.1716824518.gitgitgadget@gmail.com>
 <057c697970ff49301cd9dc6adef099f53d440c3c.1716824518.git.gitgitgadget@gmail.com>
 <ZlXIDXfc_1lGb51J@tanuki>
 <1d097be.b642.18fc58dfb70.Coremail.bupt_xingxin@163.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="8JwlPPnYDnWWxFaS"
Content-Disposition: inline
In-Reply-To: <1d097be.b642.18fc58dfb70.Coremail.bupt_xingxin@163.com>


--8JwlPPnYDnWWxFaS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 30, 2024 at 02:12:47AM +0800, Xing Xin wrote:
> At 2024-05-28 20:03:25, "Patrick Steinhardt" <ps@pks.im> wrote:
> >On Mon, May 27, 2024 at 03:41:55PM +0000, Xing Xin via GitGitGadget wrot=
e:
> >[snip]
> >> diff --git a/bundle.h b/bundle.h
> >> index 021adbdcbb3..cfa9daddda6 100644
> >> --- a/bundle.h
> >> +++ b/bundle.h
> >> @@ -30,6 +30,11 @@ int create_bundle(struct repository *r, const char =
*path,
> >>  		  int argc, const char **argv, struct strvec *pack_options,
> >>  		  int version);
> >> =20
> >> +enum unbundle_fsck_flags {
> >> +	UNBUNDLE_FSCK_NEVER =3D 0,
> >> +	UNBUNDLE_FSCK_ALWAYS,
> >> +};
> >> +
> >>  enum verify_bundle_flags {
> >>  	VERIFY_BUNDLE_VERBOSE =3D (1 << 0),
> >>  	VERIFY_BUNDLE_QUIET =3D (1 << 1),
> >
> >Wouldn't this have been a natural fit for the new flag, e.g. via
> >something like `VERIFY_BUNDLE_FSCK`?
>=20
> It makes sense to me. Currently, verify_bundle_flags controls the amount
> of information displayed when checking a bundle's prerequisites. The
> newly added unbundle_fsck_flags is designed to check for broken objects
> during the unbundle process, which is essentially a form of bundle
> verification. I believe we should extend some object verification
> capabilities to the git bundle verify command as well, perhaps by adding
> a --fsck-objects option.
>=20
> With this in mind, I support adding new options to verify_bundle_flags.
> Since bundle.c:unbundle needs to combine multiple options, we must
> define new options using bitwise shifting:
>=20
> 	enum verify_bundle_flags {
> 		VERIFY_BUNDLE_VERBOSE =3D (1 << 0),
> 		VERIFY_BUNDLE_QUIET =3D (1 << 1),
> 		VERIFY_BUNDLE_FSCK_OBJECTS_ALWAYS =3D (1 << 2),
> 		VERIFY_BUNDLE_FSCK_OBJECTS_FOLLOW_FETCH =3D (1 << 3),
> 	};
>=20
> How about the naming? I'm not very good at naming :)

I later noticed that you extend the `unbundle_fsck_flags` in a later
patch. With that in mind I don't think it's all that important anymore
to merge those into the `verify_bundle_flags` as you would otherwise
allow for weirdness. What happens for example when both `ALWAYS` and
`FOLLOW_FETCH` are set?

So feel free to ignore this advice. If you still think it's a good idea
then the above naming looks okay to me.

Patrick

--8JwlPPnYDnWWxFaS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZYAtgACgkQVbJhu7ck
PpTV2g//atWZ3FxcFHbNmg0DfgfZ3P82ClX0usFY/BrqGGsiN//VMCA2NE/iUIvz
2XiDPl3O0JqL5AcKBnTdyOwLvW/hfLukZJA3FX3VLq1ZzndgvaNiJsHpP/GPXpx4
vjiC+PiBNWPVsTHX2mfs6jLo+ZRQxJ2qVDVG01C13nDn3aJZs6ufMrkfcIyE0VYN
U74dc1T1A/+WsMAyqY+A07PiZ4ZG3IfPgaFKL3qbtPHWxyQar/ts7QccLD1vDnH0
iKEjiXJzNtyyjR1VZTWKqrFcTp2XHXISAPnZhsEKeT/6emrYi1NO7C72Zd0VHheU
XH006RboZ2J9T1E1dTxhMGmA8S6+Xqg51j7WWgVbrgk4r8AQLmZhDU9wGkMnJ/8S
6pzPDYPBfaZ2BYPRO4C/n1bJFRS2/xmXdCzsVxON05126BAEMnkTOZF21WJDxFI+
jEWtofkDV1cMOTZDEbbLcfAM0LdrvO4s5V2/ursbLhabqMqESUqJQKcQB4rKhlox
z5zq6TGyn9OK6d4bf6idStZEUqpjBTmQ9ceWE21aLhBRUcQLgob4mkIrSVcG5r6B
P4qMsT6A6fFn8XcHOx9G8GNomvRpmpmy5pFLlyJu1YIx1HTitRKaMQjp7P1HGz3K
Wr9g5lkIKtvsSUjcLdo3qV9p27jV+ZjJ/uloLDIwXFW6mpzCR78=
=IQDp
-----END PGP SIGNATURE-----

--8JwlPPnYDnWWxFaS--
