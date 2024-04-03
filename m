Received: from fout5-smtp.messagingengine.com (fout5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40F4745941
	for <git@vger.kernel.org>; Wed,  3 Apr 2024 06:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712124115; cv=none; b=cBWieUN6XjNhDibn/SCP04QGawuCDnvfRJWwWVENkzq2CGuyY23kBi77UzkGIZB01lkTLRKgY7JuF3SmEdKBdaRRWtbwYD24a0ZUhtdSRKAEQauYvAaa2SUo9PLL08YOysOuoftZgtmqVza2doSCIQZKhNcO8mNomGKRkD330xE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712124115; c=relaxed/simple;
	bh=W4VKfYCrb0FvDN2/hAJ9yXzD5uam6cJ5a0lWUalIAwc=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wl0c4/wn2lqBIzO0adYvafoBerSrqKU7JkzvO04FFp3aKX2+TSYydMwNFeuEnoIfkT9f1dHU0p7sUOrYHL5hgQHr2Q9Y/LRI3CwY3OlR3Lp4eKv/QwhN5b/A/I4VVp5rqmSJcfL7X+K2M9P/n1sdOhbxTw9QZKzNuEq3DX4J/8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=FaxGbzcG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=pShpkvrd; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="FaxGbzcG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pShpkvrd"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfout.nyi.internal (Postfix) with ESMTP id 3C59F1380097
	for <git@vger.kernel.org>; Wed,  3 Apr 2024 02:01:52 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Wed, 03 Apr 2024 02:01:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1712124112; x=1712210512; bh=coK+ZJyQch
	qmoz+PfyQmljsbNEIfpEZE37lKymUECD4=; b=FaxGbzcG6CAgQuVhBJ2wQKU/Yi
	8RXONhukN2ZVIaQVsKpiZkXMwsqZWPXImRze5SO/8AJHXbh5/VG8cVWMOyM3KL/X
	wWEnXQNewjY90/sI30gCs4qJ2BPb6w0qlpDlBrZ+C1hMOV55dqy4F1I6E9VRxmf8
	fKuuKAkwlujMlzsLLWyE7QdMJn62rtXHMHjuerhCuR75lsPG4EkGDBv3korCzxuQ
	n5i/XGlCwu3nNZgyiLaiaTL4QSaZB2fRQxLf55HqMn6KEC6yd5LzfuYVcfvJBznB
	8fy5lbfZv9pDuaSZjOJ7+Nk4+miC/ePDzXCIE+5FjZLgwJLN7+hT5UwG4D5g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1712124112; x=1712210512; bh=coK+ZJyQchqmoz+PfyQmljsbNEIf
	pEZE37lKymUECD4=; b=pShpkvrdI8rdYtCZneOP/kVlLtBjUoPnclSwTdSGK3b6
	QNZe1hs7KJzi6GJWbJxG2lxJQecnGyFE0Y9j4iJGVs4rV6jn8rNbPegERQbEw1ET
	pAu/DCRP/YjISofE+OEGsB6IkG3oWNDdYH5cjPoitr9OeOc/IPhcbdovZWxBMFSn
	R2aNFZbwhln7sFSg10cERfRZWaobGjCWTpcRzt4e8AXf3LL1nUmNQ1a2BgSMQCrz
	MC6vImyQ7WpFjwNLDnYHkwmKPijX30qrLg15+W7/Xdj9UnEv3Q5mJPL0gNlUmrsL
	8GfNzoN0A8jlgvKfone1u/DrU38/Hhhtw5FIcx+3/Q==
X-ME-Sender: <xms:0PAMZjoa8pt09LIf1Yc0RduxGr3zV7oBdFTgIw3JKzb1cKCyS3ulgw>
    <xme:0PAMZtpiE6sZBjOo9QlcZUA7zpuiKz8ueZ4m9ZbHymq0-gw60iCgQFax8SIFQQSpa
    a4yLXAaWhsgPQO7wg>
X-ME-Received: <xmr:0PAMZgNLaWYwp3uJhScQ1nKj_kT2kZjaE6kJv4nLssI_Ifq6gja5FxcspClJBGtAGk_XpfAZoBshUX42nUyt10uAdoyoJfMirKJzpMuLzQnKVA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudeffedguddtudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeehgefhtdefueffheekgfffudelffejtd
    fhvdejkedthfehvdelgfetgfdvtedthfenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:0PAMZm4O4Tn8iRIRYzHlke5K-OejoUPEholykP5ls6TG1Od9SgoWwA>
    <xmx:0PAMZi69dcWtcWc4mBrJfCZnCVo5VLLouiJcxsky1RdaTIGB3Jmcng>
    <xmx:0PAMZuh8Z6ZX_WzkCb-0honLOD1EpQr9XKB6x1ubr5KhgoWWgjpiMA>
    <xmx:0PAMZk4wxpyKwizxuTlFZt7sPWOnDO2xQX1Isf-9JK-vWdmqxekH2w>
    <xmx:0PAMZiECHjsnOQIaevNdl6ByamHGjyIlN8E5uSa4wiqgwSvSBTtchEqg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 3 Apr 2024 02:01:51 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id b01ac259 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Wed, 3 Apr 2024 06:01:39 +0000 (UTC)
Date: Wed, 3 Apr 2024 08:01:46 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: Re: [PATCH v2 4/7] reftable/block: refactor binary search over
 restart points
Message-ID: <Zgzwyjwo780Ry1XL@tanuki>
References: <cover.1711109214.git.ps@pks.im>
 <cover.1711361340.git.ps@pks.im>
 <5e20d93ae000359f2231bf950a930cfc4898ced2.1711361340.git.ps@pks.im>
 <45v2z6uszlkanwl5qhvio4ikrrytztohbmdpnmdwiefyznclum@xhbvlvnfmkmq>
 <Zgw9PlgGDcmwLnDB@tanuki>
 <ympg3oam4pty53qnxhtnla2xac73gdqsoclwsuzcmjd4dn4xre@j64veypnecrj>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Npp7oF3JHXYPJLW5"
Content-Disposition: inline
In-Reply-To: <ympg3oam4pty53qnxhtnla2xac73gdqsoclwsuzcmjd4dn4xre@j64veypnecrj>


--Npp7oF3JHXYPJLW5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 02, 2024 at 12:46:30PM -0500, Justin Tobler wrote:
> On 24/04/02 07:15PM, Patrick Steinhardt wrote:
> > On Tue, Apr 02, 2024 at 11:42:29AM -0500, Justin Tobler wrote:
> > > On 24/03/25 11:10AM, Patrick Steinhardt wrote:
> > > > When seeking a record in our block reader we perform a binary search
> > > > over the block's restart points so that we don't have to do a linear
> > > > scan over the whole block. The logic to do so is quite intricate th=
ough,
> > > > which makes it hard to understand.
> > > >=20
> > > > Improve documentation and rename some of the functions and variable=
s so
> > > > that the code becomes easier to understand overall. This refactoring
> > > > should not result in any change in behaviour.
> > > >=20
> > > > Signed-off-by: Patrick Steinhardt <ps@pks.im>
> > > > ---
> > > ... =20
> > > > -	i =3D binsearch(br->restart_count, &restart_key_less, &args);
> > > > +	/*
> > > > +	 * Perform a binary search over the block's restart points, which
> > > > +	 * avoids doing a linear scan over the whole block. Like this, we
> > > > +	 * identify the section of the block that should contain our key.
> > > > +	 *
> > > > +	 * Note that we explicitly search for the first restart point _gr=
eater_
> > > > +	 * than the sought-after record, not _greater or equal_ to it. In=
 case
> > > > +	 * the sought-after record is located directly at the restart poi=
nt we
> > > > +	 * would otherwise start doing the linear search at the preceding
> > > > +	 * restart point. While that works alright, we would end up scann=
ing
> > > > +	 * too many record.
> > > > +	 */
> > > > +	i =3D binsearch(br->restart_count, &restart_needle_less, &args);
> > > > +
> > > > +	/*
> > > > +	 * Now there are multiple cases:
> > > > +	 *
> > > > +	 *   - `i =3D=3D 0`: The wanted record must be contained before t=
he first
> > > > +	 *     restart point. We will thus start searching for the record=
 in
> > > > +	 *     that section after accounting for the header offset.
> > >=20
> > > To clarify my understanding, does a restart_offset not exist at the
> > > beginning of a block? I was originally under the impression that the
> > > first reset point would be at the beginning of the block (or just aft=
er
> > > the header). If this was the case, the first restart point being grea=
ter
> > > would indicate that the wanted record is not contained within the blo=
ck.
> >=20
> > It wouldn't make much sense to include it as a restart point. A restart
> > point is a point where the prefix compression will be reset such that
> > the record at that point can be read without reading preceding records.
> > This is always implicitly true for the first record in a block as it is
> > never prefix-compressed. Consequently, writing a restart point for the
> > first record would be a waste of disk space.
>=20
> Thanks Patrick! Good to know :)
>=20
> From Documentation/technical/reftable.txt:
>=20
> > As the first ref block shares the first file block with the file
> > header, all restart_offset in the first block are relative to the
> > start of the file (position 0), and include the file header. This=20
> > forces the first restart_offset to be 28.
>=20
> I'm assumming this is out-of-date.

That paragraph actually made me re-check my own assumptions. Turns out
my claim is wrong. The function responsible for registering restarts is
`block_writer_register_restart()`, which gets a parameter `is_restart`
that is determined by `reftable_encode_key()`. And that function in turn
will set `restart =3D 1` whenever `prefix_len =3D=3D 0`. And given that the
first record always has `prefix_len =3D=3D 0`, it will thus have a restart
point, as well.

I'll update the comment like this:

diff --git a/reftable/block.c b/reftable/block.c
index 8bb4e43cec..298e8c56b9 100644
--- a/reftable/block.c
+++ b/reftable/block.c
@@ -417,9 +417,12 @@ int block_reader_seek(struct block_reader *br, struct =
block_iter *it,
 	/*
 	 * Now there are multiple cases:
 	 *
-	 *   - `i =3D=3D 0`: The wanted record must be contained before the first
-	 *     restart point. We will thus start searching for the record in
-	 *     that section after accounting for the header offset.
+	 *   - `i =3D=3D 0`: The wanted record is smaller than the record found at
+	 *     the first restart point. As the first restart point is the first
+	 *     record in the block, our wanted record cannot be located in this
+	 *     block at all. We still need to position the iterator so that the
+	 *     next call to `block_iter_next()` will yield an end-of-iterator
+	 *     signal.
 	 *
 	 *   - `i =3D=3D restart_count`: The wanted record was not found at any of
 	 *     the restart points. As there is no restart point at the end of

Thanks for making me challenge my own assumptions!

Patrick

--Npp7oF3JHXYPJLW5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYM8MkACgkQVbJhu7ck
PpSoFA//QgwuqyyhowzB2TxvfEKd9HxpWr09CQu34ZZsKy9LYwq3GvN3AiY8UHtR
he/dsuhGkK8/XeurAb2tBe2jLeEXHWuHWgeeur65h/ojocFbeh2tjRlUu3w/NCGn
UWUI+QtCdPPql5E0PQJV8b3EIYyqfWagcjgizG4uYLulGB+JR9oUIsXlHjc/l9P2
h3X3USGtlRm1o5v26P5agdcMB86ynYnTILDW48YugCaY6CPHwVfL1YJTQwlPow8v
EA2nsyy2qFp18nantDkj/e1Fm6FeG2f7aQ8BIm99WpX8Do+NdQnTs9DIaR5vPi/2
3SUPhbDZw6p4Rl+8NDGMJJMN7Ka6OLxZe1KBAigQnkL3PnqJP6r08LLnD9+0tKO7
/tmGnul1ctAAY5KumcMUIFk9Bd8aMjSb/4/riVjCQFJWvJHo0e4xKcQFW+p5Phyq
zCxTJVjj1RTT5KCqKJ49dK4nFigHKTYp3M5SbskUAxrgOrgu+Lk4CT7NbTdruJHQ
8QAB7p25y1lA8PIlvzXIIf1WAQ5YY1XU0SYAMGhQa251o7TusjMtwigWVti/Ihsd
3jNWrYv1FxcqH3u5Z1LE3m1/5+Tytscf23HVxKnRzG56vi4c4mAiJlijC2ZhrSxD
19gZRkNiWRPZHcCkv1ym6LCmdV8U5/fPvui7RARgL4lVG3JucCU=
=MuMH
-----END PGP SIGNATURE-----

--Npp7oF3JHXYPJLW5--
