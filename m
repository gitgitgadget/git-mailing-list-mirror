Received: from fhigh3-smtp.messagingengine.com (fhigh3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFF0D39FC5
	for <git@vger.kernel.org>; Sat,  6 Apr 2024 15:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712418830; cv=none; b=GSzKF+HAPCRq19hPPsezk40K/YhwvIKKZvJRA8MbKmSGw/5Om7Q7twYWTv2ksMUhv5Rck96k8GQzylvDIxuiNkOhfAzvRMnMKgeYiWAAqnIXHFzFTFqs/AgQ1gt/KqxM12g8Cez+++R+RuMojd9KIxYZvb9peO0gcIX6Z2ixFD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712418830; c=relaxed/simple;
	bh=++lS7JHr7niVV2FWDEFJh62Eh0fr6zpOdcx7qMH95Fg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mZ0eErtRwMpPOUpEVTwgJKBVNmpvEktGRRWImQEylhRtHhaMaBGQaowspH94MZxKqUgNwxTDE/cvh3Zp6vvHl1adTJa3yEcqsqlADyJ5Pchx4vpi7o7uWFwaEVYafkray5vvf/HLJXkyNfv0h4hmSsxvwO7tDjDQOgDsVe/zjys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=eB2Gwzk/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MyZuN9/O; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="eB2Gwzk/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MyZuN9/O"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 531F411400DD;
	Sat,  6 Apr 2024 11:53:46 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Sat, 06 Apr 2024 11:53:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1712418826; x=1712505226; bh=vprQAfAqZg
	q9DE+0ivllh7rk3U2KLSyvw7R88okjaGE=; b=eB2Gwzk/LhZNLcTpFHBmAu05IL
	LJZz76xHRGpGD+XrvlkVR16yTI+jRde9t9oUNJYQTJrraUYWxtuJ4DyfZToOjFDD
	JxuTDudMhkW34jDMPPp16OTwkGcPU+94+q/yjbNnFHAcGyF9ckb/1OrhAuCSgILk
	J2ipeDKjMFETXNCdpz+ibMFREEEI3y3+i/ssb+Dlly7z+9N7I1ee5fKdbINV1lW4
	B395LdKu71hYx8Hf0tAzMjnBAqeAlTUyMcv0S4mOSQgNT5fvM0B0J5TmAh6u81IQ
	ttt/PgGHc1hjM0+OB6dKHrAxYydGfI3gQDMDqfMh9dJ5LSK40US+JmL0FJMg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1712418826; x=1712505226; bh=vprQAfAqZgq9DE+0ivllh7rk3U2K
	LSyvw7R88okjaGE=; b=MyZuN9/OcY8sOOy4/hdCaiuA0mcjZ1j53elDHDUk+f3n
	Mc8RVY44Gji6DMGfWmja3pSOTcOhNB1poul1DXnsM2wXe9EUg4O/bmN2vC49MQd7
	lrJy9Z6zsU6rpo8PAnTewiXaS5yD52I2UO0JfYi9VC2yn7LYNfmSlkyeTFfQVfAi
	Ypn8+zYgx+ZCdN5RyWViHo9ckFfSM4FDQtTwk/9Vgg+xrqfVGo7L6BA3Fy/3W3dq
	PqC/TxI9AEvaLP1HJgmB/UNwCyoTn7huieNhtu0SqF1rXQpenQrtDnLcDjHpmP91
	KJAZDn+Vj2/CC5mZBrIve3kUuGEmNigMQNUv71JXWA==
X-ME-Sender: <xms:CXARZtNHKVhI8_fVxacRkgmhfX8c4PCO6WoCfPmeEykhremxTvZPfw>
    <xme:CXARZv9ClRjaesZmE3-b9HvD4nA3SGDPm2x3YpTxio4qJuCtmbuV4L4HNEFJV23Vc
    twXVJKGcu9ISL10Dw>
X-ME-Received: <xmr:CXARZsT4Mm5jZ2MqQKBzbEIKko3V78e6u1hbuxOI1HLNgqvob7WBOL1TMm8HzVELvv5D9QHVAgT7JemZpYBU9MV3L73hrKcgmrN9WIpoXJtV-X_kcA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudegvddgleehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtjeenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepteeuvefhhfdufedvgeeiueeileegtdfhgeeftdeuveejjedtgfejhedujeeutddu
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:CnARZptvx0jW3eEsj9_kEf92D4ptQ7Kk4SgkmreliTmp6Y4alOJPOA>
    <xmx:CnARZleLV7R2mqoJxvKtQVe2z6Pk8YEwQE-d2jjvN1UkkqkGvGD2qA>
    <xmx:CnARZl0akddUlA9TE98UjkRbekVBTFcsNpnVqFtxVaRTM4awJL8IjQ>
    <xmx:CnARZh9Z0YwNfMBac0WhLL5AeFp2FocMF-4MALRBnr9hkTe62gwaQQ>
    <xmx:CnARZtRHFAzaBPYu9kdUVRUz6khcSFJLgmgaXPrvqTuLFfrHx4W-yyk2>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 6 Apr 2024 11:53:44 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 461a011e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Sat, 6 Apr 2024 15:53:40 +0000 (UTC)
Date: Sat, 6 Apr 2024 17:53:40 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Han-Wen Nienhuys <hanwenn@gmail.com>
Cc: git@vger.kernel.org, Josh Steadmon <steadmon@google.com>,
	Luca Milanesio <luca.milanesio@gmail.com>,
	JGit Developers list <jgit-dev@eclipse.org>
Subject: Re: [PATCH 12/12] t0612: add tests to exercise Git/JGit reftable
 compatibility
Message-ID: <ZhFwBJ3UqBJsq8xh@ncase>
References: <cover.1712235356.git.ps@pks.im>
 <db66dd4155d80b714719e80ff90f64c1d36b97d0.1712235356.git.ps@pks.im>
 <CAOw_e7b5wDKOcY9hSty+c+z-NWVUgri3h3ScF0qd1Y6cmfsyVA@mail.gmail.com>
 <Zg_HPQFlNazTlDRa@ncase>
 <CAOw_e7bx=KEeA6sdoDPti6LvxU9Pmr9ZyzyrXfyTmT3DUcHL6w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="0yjI66+ECLZ8zeYJ"
Content-Disposition: inline
In-Reply-To: <CAOw_e7bx=KEeA6sdoDPti6LvxU9Pmr9ZyzyrXfyTmT3DUcHL6w@mail.gmail.com>


--0yjI66+ECLZ8zeYJ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 06, 2024 at 03:03:20PM +0200, Han-Wen Nienhuys wrote:
> On Fri, Apr 5, 2024 at 11:41=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wr=
ote:
> > > > +test_expect_success 'JGit repository can be read by CGit' '
> > > > +       test_when_finished "rm -rf repo" &&
> > > > +       # JGit does not provide a way to create a reftable-enabled =
repository.
> > >
> > > You can do "jgit init && jgit convert-refstorage --format=3Dreftable"
> >
> > Perfect, thanks for this hint!
>=20
> on a tangent: I wrote this a long time ago, and it does no locking,
> which probably leads to unpleasant surprises if it is run in parallel
> with other ref updates. What would be a foolproof way to stop other
> processes from stomping over the repo while the conversion is ongoing?
> Maybe create a packed-refs.lock file?

Yes, this is indeed a problem that I have been thinking about quite a
lot recently as I want to introduce migration tooling in the next
release cycle. I was quite happy to learn that you've got something in
JGit and was hoping that you found a way to avoid races. Too bad you
seem to have the same issue as I do right now.

In any case, creating a "packed-refs.lock" is not sufficient. While it
does protect against ref deletion and repacking refs, it doesn't protect
against ref creation and updates. And in fact there is no way to guard
against these at all as all that the "files" backend does is to create
or update a single loose file without taking any central lock.

I was briefly thinking about a "migration" repository extension. Once
the migration starts we add "extensions.ref-migration" to the repo,
which is an extension that no client knows how to handle. Consequently,
while the extension is set, any _new_ Git processes would bail out and
refuse to update the repository.

That only solves part of the problem though. What it doesn't protect
against is already-running Git processes that have already read the
config.

There are of course very hacky ways to get closer to the goal. E.g.:

    1. Repack all refs.

    2. Delete the now-empty "refs/" hierarchy.

    3. Create a file "refs" with invalid contents.

    4. Lock the "packed-refs" file.

    5. Lock the "HEAD" file.

Now you can be sure that there is no way to create or update normal
refs. But it's still incomplete as pseudo-refs can be written to. And it
does feel very fragile overall, especially if you need to roll back the
migration due to whatever reason.

So I dunno, until now I didn't yet find any way to reliably avoid racy
ref updates during a conversion. If you or anybody else got some ideas
I'd be very happy to hear about them.

Patrick

--0yjI66+ECLZ8zeYJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYRb/4ACgkQVbJhu7ck
PpTmeA//csYy9iUaV8gCk0F4/+/rIQeb+lVEmOdPzQKompJHGzNgP4DhPophwOia
8G3Nh6ScJDgv6LvnfZFvI+RUdlywRPibmlVmg1BxbgMkjB/IKtk389Zvwe0MCd+x
UTQzDguLmn40Zlj0wqZatbP610TEmY8jXVx7qrguyUfz7j2m5kFwCUZDCXNUh6XO
3VdeB7NZvBYtRSoWp8STjORVKvmCjlO2W+/ZobNWxE/ethFD2KfQg2ZoxpT6xQw4
5suOfQ10b6sxTzSn+EAF5nrx8owXVrME9HHCTHV4LaZBUqcqoNw6oWX+PZBPzLl8
UZc3BH8+i7WXdefbKgEZNMrA8pZz51aFiAif5b9JndTH5kZ/sg8So6HxdTGX+FJb
/3TrAGZnombjU5os/hJOPBhMI4U7Mg+7bQmX8DIUzJ7/8/UE9qkl3rpu8+8bzQXw
OcuzM2B2WXy53sxNKKLv5qHqDos6IN1/r1i4JByt77FeNgOs9WmJLUbruBSU97Th
v4CPFFvSkQQzCVgkXMqJoqkNWpUOA8vCSFEaB4FnBohWcDwHr9BJqx0IFgEvJQ6A
vYhQIAXQUgwTd3cq9OhcdURpRG3ZTG32CPXscmqgKdgY9ED+48gXoL1PWa49+OXQ
0W0SqbhAYv5LgFy5oqJq0DduHk51w/Y/EH8yTqJBcT5z0bVRb8g=
=mL75
-----END PGP SIGNATURE-----

--0yjI66+ECLZ8zeYJ--
