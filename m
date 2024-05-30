Received: from fout3-smtp.messagingengine.com (fout3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAB9F47779
	for <git@vger.kernel.org>; Thu, 30 May 2024 07:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717052677; cv=none; b=fVCRl7GJ8wr1Q3SZaIGen9iaBcDfNlZNDaMdyr4vYFZGVUBHRTprwxHlLX2l8zfJKrBDI/1q62BzdekHn+K6yWBeWxt5N9iLCncV6ZsXljdneLnxITQs/RV33XSoZLPmcOQ/3bogCeo4Pxey1W3SHpRRYEbjt8AGq/WG4RdHTkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717052677; c=relaxed/simple;
	bh=Bv2oAH5DzUs2uvmK6Wpp1kNscj3rjsPAKgLtBSymkg8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AuEOI+8ZuF6Qe3+Ge3k5Hq1CUqs9NcwCRAImG7VAIrTGHNm1nrE7RkCodaHtoWmG2tYRcZt0RfRzai4oB+y1aZ+vFknMszm9x60AQzq71Xn5mIQIi4z080Cj4kJy3ADnChx+DJ0xGXeek657JkE34VSXbRX8Fr5gmO8EJDxuEc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=YbwPIOIc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=brmzJ4jt; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="YbwPIOIc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="brmzJ4jt"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfout.nyi.internal (Postfix) with ESMTP id CF8EB138014D;
	Thu, 30 May 2024 03:04:34 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Thu, 30 May 2024 03:04:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1717052674; x=1717139074; bh=Bv2oAH5DzU
	s2uvmK6Wpp1kNscj3rjsPAKgLtBSymkg8=; b=YbwPIOIcbEIvLyVRxTSeYRzbHu
	e6zOflAqVT8koC8fObxKAcyAJ2sZQNE52kFIMZ/QEZkALiVjC3dFyOlnjbqrZ3ec
	2DM3htXd4lJI8QM+A/OZw8uuycekR3jNniV/I2Kyrqc+cXbpdK3c2BA8p3Wd/qt9
	ZkpVOT7DdcY3VmGuizD6g5r+Drrr8h4O+AIKQC5y/hXMwleOqL+euL1vP5PTQP4G
	kT4yFPYx6nq41nTACNG++NVJpxQo/b+qwXm9/HavLq1TPlkbneW3yVfIRUbcA9sF
	cUSEORmbJdC7AXYex6Ro12ImtWdUqFiInNFUi56cXp4rwxisYOb4QyBK//Mg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717052674; x=1717139074; bh=Bv2oAH5DzUs2uvmK6Wpp1kNscj3r
	jsPAKgLtBSymkg8=; b=brmzJ4jtokSe0cBXbCb/AZwbOMXj0qHSvdRv1rsgV4jI
	9lubcP7N4L1NJJjrEl7JnTSjdjy7+VlefzthkbgO1SDa0vpRZgisM9GJLRyi3jX2
	E1DG0LOqkSW7A48cUxbXkxSVOHqZz5d2RSkZX/WwbJZP+JqRHrH+0Se4umQFAW00
	6xA68xL1E4c7+WGTdXqJp9I90/F07IDviRqNukHP3wjUjmEmYdTmzw+WkvYU2crE
	e+Wl7p5d/8CDIyL2njcorkuBq6MQWzsL+YLqLvJpbgCnvdjsteAUajRbqFn2n5dH
	66PB85gPJbm92Iud12q7qDYXIqCXSySYgWdaoEY0yw==
X-ME-Sender: <xms:AiVYZvCnBuqsSO5PZLaq4VT7lp0EZaA3awT5VvfJ3oTs53db7ZRiuQ>
    <xme:AiVYZlg97djcUWiw_TV5nI2i8TszXwsrvLBo4_E4St5AHGJmPYwHx4UFwl9clZQOH
    fa9LULWG1uqqPBvHg>
X-ME-Received: <xmr:AiVYZqmGoFaDIf5I4QRkaIOiue1gL4KPmJ5sG2JF75Gtin0BmqOs77TuSg5CEU0aNarrnQuTCKg0ieIhanFzIcKdPyW7YSaLitkxyZ1ELv_21J444w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdekfedgheekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:AiVYZhyYBBLNa72FLCV50m9-EhEbkWhmTIOp80bS3_IkjDr_uTpVZg>
    <xmx:AiVYZkSwsYqTamUapWEMkxaHcm5hBU3CpEkGsuOg0ANqvjrTYT_4pA>
    <xmx:AiVYZkbBm6lMSmP2gXp-ozuw33qXejaIEdMqm_FcbMK63_f8vnRayw>
    <xmx:AiVYZlTAG3oWaJOWGr4epfNM57Upmz4IPkvx6Ido-YvfFMvHGjGCCw>
    <xmx:AiVYZpJOL45N7lY4Q_04p06_42qjz6Ff0RO-0D7qKEu-urBIcfzGeRMa>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 May 2024 03:04:33 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id b3293b1e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 30 May 2024 07:04:15 +0000 (UTC)
Date: Thu, 30 May 2024 09:04:28 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>,
	Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH 3/5] mv: move src_dir cleanup to end of cmd_mv()
Message-ID: <Zlgk_MMDGlphfO9U@tanuki>
References: <20240530063857.GA1942535@coredump.intra.peff.net>
 <20240530064422.GC1949704@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="mZt4uBnvnpVk53I3"
Content-Disposition: inline
In-Reply-To: <20240530064422.GC1949704@coredump.intra.peff.net>


--mZt4uBnvnpVk53I3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 30, 2024 at 02:44:22AM -0400, Jeff King wrote:
> Commit b6f51e3db9 (mv: cleanup empty WORKING_DIRECTORY, 2022-08-09)
> added an auxiliary array where we store directory arguments that we see
> while processing the incoming arguments. After actually moving things,
> we then use that array to remove now-empty directories, and then
> immediately free the array.
>=20
> But if the actual move queues any errors in only_match_skip_worktree,
> that can cause us to jump straight to the "out" label to clean up,
> skipping the free() and leaking the array.
>=20
> Let's push the free() down past the "out" label so that we always clean
> up (the array is initialized to NULL, so this is always safe). We'll
> hold on to the memory a little longer than necessary, but clarity is
> more important than micro-optimizing here.
>=20
> Note that the adjacent "a_src_dir" strbuf does not suffer the same
> problem; it is only allocated during the removal step.
>=20
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> Reported as "new" by Coverity, but I think that is only because of the
> "goto out". Before your recent patches it was a straight "return", which
> was even worse. ;)

Ouf of curiosity, did you check whether this makes any additional tests
pass with SANITIZE=3Dleak?

The fix itself looks good to me, thanks.

Patrick

--mZt4uBnvnpVk53I3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZYJPwACgkQVbJhu7ck
PpQXRBAAgnIE71RI4ITIBj3VfbTSvI8HaDB5EvJBvGGU9kD2IY3RWf6R48IkgSi1
sbE2xQaMFIGbRr717wsNL9tVHA03kbWeCbN0JKO/rjKaeJAFm0U8USIs/ucERu6Q
eYemaXhp0q7u+Cjfxg0QfMw67SsLkHgyycYFCMgZ/6K8xLBLbwYHTr4ftPNuqoim
HjBZHrPskQJzd7e5c4UKagvmvOLUx8EEs3HQv1LAnDFp2JXBN1NCIl/Y939DXvsT
nnD1lLBDayzndQxqdmBHhJgXK0MdXs8O2F98Hau/6yJgAmG2l+AzAlMikMIbl5yB
U3EY3PI/1V+paHmlOcsYgHAywchvGY9FF3MElTyrekj5WXaJmBryOJZo8BaGkij0
xSJasaU2iqrwgxarp5a0epllVD73UQdKu6whm5xqqASbLWQk02JfOieQt3QK5dI3
UQAcwaxIx65oThATCnQWxbuTnzRUaotzvoQ5GgVKZoFV1xmKpc3RrOK0haPNMTt2
UDlUOfFjZoGJeMK4oz84t7gX0ZomXNdRb0rkCQT///F+EtP3LaQmUIuYjQKTlrY0
oGSiO2Y8xDLja/lVQhZAyw2PzQuZosgH5s3cAHYhYrhSmvK7KzJdW93nblOJeWwJ
8TjruJPFdKBAGUDi3mPe9WwJtVogenXg0I9D8ioXh4kJv/mMgJ4=
=K8tp
-----END PGP SIGNATURE-----

--mZt4uBnvnpVk53I3--
