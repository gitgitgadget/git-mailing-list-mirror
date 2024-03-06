Received: from fout7-smtp.messagingengine.com (fout7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 674C95C057
	for <git@vger.kernel.org>; Wed,  6 Mar 2024 07:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709710286; cv=none; b=L16L+Z5EFNI+edMq0AextJWldR0AKDWoZGEPU+w+XWpktGMsxMpWkKdV2xBfhNTvtBTlWhVlLvg/krGbn6tU7Ui/BwB8/L5SgzXSVch7oQdAoUS96caDjxo6h7RnsEeYiRgAdIeUD68ex7jS3xfRyH4urJcPa9lWpsZzmAKX/f4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709710286; c=relaxed/simple;
	bh=4sLa5APTuyJ5oQD//9c6DjoSnd5MabmrsSEoY0XXG4s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KzybgIZEd2roic5dKs//OrUDxYowiD0rk01iyY6J3IDHgZEGFEPIUSiHdIdx0AeXW8jgwXjVWSRnmdvbthwTTjIG+8MxRnVENNc7auVyLfgUzXTx8MoLG124MQCrClu9bZ83ygcJE012WmzYUyuUeGcFWKpiJZVCbNJAxgGrvhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=OxkF9Owp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PVJfmtiw; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="OxkF9Owp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PVJfmtiw"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfout.nyi.internal (Postfix) with ESMTP id 2B02B1380101;
	Wed,  6 Mar 2024 02:31:22 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Wed, 06 Mar 2024 02:31:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1709710282; x=1709796682; bh=+kkrw6Z0pq
	Wojk+LQ1pWOuW8J0tmKUM3DKJKN3NMmX4=; b=OxkF9Owpluecy8nx3Mof7Ycdrk
	ocJYlY8uxpMIWoEythg7CaBk/+T+K33qyeCUb3qTH+uEwEhly/mrgie5A20fwj7I
	rSdGjAsT1+41xNw50KRRj8aAQYilH5Rkg8cHAW3XhPrl2LqzSKFm+aKMCT7jLffN
	z0RD507vcXQ6wBS9PHlE5QA/WhT9l12i07Bjfd4ZL7Of8AwOtfjEeWkGE6Vmlo1T
	BRpuKX0qF6no0dKLHj12yoxdKHDY2zeuvQ25GwHS1/rJLH7EO1cavhzZ2Nmb4Htu
	wcaoGAiILctslflhIN+QC4xgjhZ0EDIOCV4k7XcA+P56N4//mKHqNymW4fEw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1709710282; x=1709796682; bh=+kkrw6Z0pqWojk+LQ1pWOuW8J0tm
	KUM3DKJKN3NMmX4=; b=PVJfmtiw5TXXaQhPMv3dEfTzDm4/CuJH+9zXyuUBDs0O
	5GCeyHk3F9RJnsoZVpUpo6lOd6E/L0HbX5IpLx4Sa+2GRRi6zvZJLDU36pwx6VgW
	u0HIMAgbLzEn9OeVVErfpDMSjyB43yCGfdQ4dQdCICYATpLjjPYi7fFbHaqnbyU/
	Fpxqm8zRIAf6oDpuItblu4UTpQJyad4ZjZjNk4h6fKNtArY5wHab33tUYCQgmoL8
	UnVfNwI8y+51bpyvz/odcR2NiW5s9eWavsM+rc/MLzDcHYRdCW7Tg/7Zaa0uZkfW
	F93MVPQZs2WQBNS0slMWfnbJ1XfOvkOcCWA8MHmDzA==
X-ME-Sender: <xms:yRvoZZ77ojtlE3By0wZIwgIqaJFv4L9LCunqvAR4GbziseD8RnNL7Q>
    <xme:yRvoZW4yExSyEDRobrMC98BFsNLhcD6dxsQtmsKNyunm-mJjSubOK9AZjGHbEZv4s
    WUZEhJ85oWglVexmQ>
X-ME-Received: <xmr:yRvoZQelQ6TdmpAYdyppNHBqoWNq9XSXZKRQKG_2IqNMLTwvBPYHkDcyKqGL8KM29Jy8hPZJj2bJ2ltDtA9eFj28dUyJrPoK4XF-IqKOZS42LVgymg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledriedtgddutdejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:yhvoZSL6aDCrKKbMm6pUlkQFCPKCZ_nyJGwfvp31M3Ho8kOnyXW5lw>
    <xmx:yhvoZdLQCD1WVo4sxPHKdqW60Jb9HLO3VW1Jmo07554Ts-GNEpi8Tw>
    <xmx:yhvoZbwx3AbPCIE71zsAIyRdIhyv7DUbitzrqCF5qkMUk93E8whsew>
    <xmx:yhvoZaG1kuAO4MZ4k8uWxryHzSM5-AkCKTeSTO8Ulrc8ym2n1TIteg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 6 Mar 2024 02:31:20 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 705fc242 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 6 Mar 2024 07:26:49 +0000 (UTC)
Date: Wed, 6 Mar 2024 08:31:15 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: John Cai via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org,
	John Cai <johncai86@gmail.com>
Subject: Re: [PATCH] show-ref: add --unresolved option
Message-ID: <Zegbw2i-PGfvb5q_@tanuki>
References: <pull.1684.git.git.1709592718743.gitgitgadget@gmail.com>
 <20240306004139.GB3797463@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ZlVeOFvooMssA4cP"
Content-Disposition: inline
In-Reply-To: <20240306004139.GB3797463@coredump.intra.peff.net>


--ZlVeOFvooMssA4cP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 05, 2024 at 07:41:39PM -0500, Jeff King wrote:
> On Mon, Mar 04, 2024 at 10:51:58PM +0000, John Cai via GitGitGadget wrote:
>=20
> > From: John Cai <johncai86@gmail.com>
> >=20
> > For reftable development, it would be handy to have a tool to provide
> > the direct value of any ref whether it be a symbolic ref or not.
> > Currently there is git-symbolic-ref, which only works for symbolic refs,
> > and git-rev-parse, which will resolve the ref. Let's add a --unresolved
> > option that will only take one ref and return whatever it points to
> > without dereferencing it.
>=20
> What about "git rev-parse --symbolic-full-name"? I don't think that
> behaves quite the same as your patch here:
>=20
>   - it is actually not a true no-deref; it resolves to the final name
>     and then prints it (so the behavior is the same for a single-level
>     symref, but I believe a multi-level symref chain like
>     one->two->three will print "three" when resolving "one").
>=20
>   - it always prints the resolved name, whereas your patch prints an oid
>     for non-symrefs
>=20
> I'm not sure if those are important or not, as I don't quite understand
> what you're trying to accomplish. I'd probably have just run:
>=20
>   git symbolic-ref -q $name || git rev-parse --verify $name
>=20
> I'm not opposed to making that more ergonomic, but I think we should
> avoid redundant plumbing options if we can (I'm not sure yet if this is
> redundant or not, but in general I find "show-ref" to be a weird mix of
> "rev-parse" and "for-each-ref" that I'd be just as happy if it did not
> exist).

Yeah, the proposed patch basically aims to do the above chained command
in an easier way. I think that this would be a nice addition to make
this easier to use and better discoverable. But in the long run what I
think would be really useful is to extend git-for-each-ref(1) and/or
git-show-ref(1) so that they can print all existing refs with their
direct values. Right now, it's impossible to get a globally consistent
view of all refs in the refdb with their unresolved values.

That will end up a bit more involved though. The ref iterators we have
right now do not provide any way to return symref targets to the caller,
so we would have to first extend the interfaces and adapt both backends
to support this. But this is kind of where I want to end up.

Patrick

--ZlVeOFvooMssA4cP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmXoG78ACgkQVbJhu7ck
PpQslQ//QvybzCasiog1JkzS53IabpVMxmiFqxA0kcLqLKEoBCM1HTDKEc8TvZl7
n4p5edYkr0ObDsaxHegV0VR9yPZt9KEQGivaDHQMWodILQ5010xuCdGWwV3YHExz
NbSBDC6llSztKiUUpj6XpVwzkp/Gm5/KBbIdcJKINEtgmEw4CLiNUXfnoWAphcSL
VaT8BsfVjpiq3G4jO+gEVSp6DJi1uPkM7Tk22cz9HJ/V18D95MxP3QKT1MdOj3Rs
+xRCxRmgTajVCuovkpr1k3UKd6hsg4qvxSsXeYJba+jqezr4YVrUCYNWNoulk/2Z
FIX8gpRb3uSUn+380A7BxMebCRP9Pu9+F1Hzs9eBmIsmMcS3gxrLfAonPumHI7PE
ylplwfM2iiztbPQZkS5SffV9LRJeZDfmglhewoZuP4LIY6fUjogll6inOWID14ha
CvXApl+xboGMaz5Y7IWNdd5jnYo6F3I4rAlgYz9zHFixYOl8/zGXyBZ6BpUjArrU
2VAeqW8eO6Ld/Sa+K8q0srGtJ46pcDUSGMiioTtLSAM9n0Hv97cCSI7ZLBoJNbrz
xIm4ULsyU5LhtXeuygQfi+LaNNlirB+MT50JUv/xjDs2UhPWV1t+mcZ1y/sFYoP3
fEXZJbd/OITdDBDVvod/Wu25hdMAO02aZDpjsQC1/adLMtccmNg=
=FCsA
-----END PGP SIGNATURE-----

--ZlVeOFvooMssA4cP--
