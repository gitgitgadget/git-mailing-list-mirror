Received: from wfhigh1-smtp.messagingengine.com (wfhigh1-smtp.messagingengine.com [64.147.123.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 905CC12EBF5
	for <git@vger.kernel.org>; Thu,  7 Mar 2024 15:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709825207; cv=none; b=k+3HNFT2mxFwcMkbwsS/vcgaYeRnCIXKkTmj/VQo2ngxo2wkr+7o4HYQKR+29fPrZPri3Bm5tGSXWGA5jgCNSLWig3rA6ahLgVDrwFZ+LJGUtSL1XBewsEXNI3STnEsOPmOKl+VhrE5tQvTfwPuDbfGRoNXG5LDDv6fllBFdDmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709825207; c=relaxed/simple;
	bh=O9emFKzkTYt5xNx1EA1lOHSAZVf3cNtVo5oiELE69IA=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=luNx+etU4iseA9ECFA4tv/cXBLuVJW0YkxBCUd1eYIipqQrn3rciZMhxDD2l1D5059qtW41nhMEzXDZvQZdGaUmohALL0k3PS1Fetk6pQFibDRRz0Ux/bkT5nvmiIvs+kCq/isMPmx9M2ILNg0omARKAJdf0bwd/iIwxA1OIpTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=X6yJJnbq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iX5xIriK; arc=none smtp.client-ip=64.147.123.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="X6yJJnbq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iX5xIriK"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfhigh.west.internal (Postfix) with ESMTP id AD089180009D
	for <git@vger.kernel.org>; Thu,  7 Mar 2024 10:26:44 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Thu, 07 Mar 2024 10:26:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to; s=fm1;
	 t=1709825204; x=1709911604; bh=UU6cDQ3X+THmlLH0GHHOXvC8CvC8jIls
	PSpH8GUEyCc=; b=X6yJJnbqVzxr49TXtTESPvkGmJZhGrrZ1iPANDhZnke7ACKa
	x6jykJ8uCaPRDfyJftwwZoHzPovM54Z3nTvc7oHZCTyRLb+jHa3NeIx4g0hpDQaW
	PdNrvll/bfSCw11eDxIXUHL1wC1sb31oNiZkgZkwOk8xAzHe7M+5OVclIa0z7K1m
	xQ30kDQw3Ql/kHfNkUqDG5nZz1bEo4gBx2bYHxVu/orzl5y/mEUfqG0wjoBZQAgb
	5p/2UWi4DEfQb5qdRSH3AOYDJ7C+VVkkIT3WjZaidr3E8TZ1fgzXTUvLK114aQMS
	t3U7uxj9K5scrKvAyIsoqXfDNPROcygAqUae7w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1709825204; x=1709911604; bh=UU6cDQ3X+THmlLH0GHHOXvC8CvC8jIlsPSp
	H8GUEyCc=; b=iX5xIriKQLt/jHXGDSa2qQUeIWESXRMDLm0+O/NeTegVZicTKq6
	0yl7togGwSoY+SagZZgEoreILVHYfKBBFZDfb55Cqqxsif3czRZyu7mZd/MusxN5
	XUI01ONieJwcqQzlZtiF0njgNpdvrROlmo/LKNettGdmwrYnPOvc4rbM9jmx6po7
	ESj5Libft3prFFOOGiDvpMbHf6KAdZ9RuuqxhS+uvDH4O4l58iL3a4hy4R67n9wu
	8+ql819yotcexQbKHNL4/OsJPlSC0LvMIaniMtW6rkZ/0Y8rIyaEG4+osxMC+/sw
	BQ5wKQq0OtFxyq3C1onpJOp6m2WHQMq7VWw==
X-ME-Sender: <xms:tNzpZfoOqaS96LcC-T9WxJ8o6LqGNWFIPTJg-46fZ5EHOd9J8jSevQ>
    <xme:tNzpZZoY3uEefFCcMQEj20gUDgTkIFt_epxu2rgWXj5Xsl1PBwBc6LQdhGCsrt13g
    -B7EL8iIfA-S2i8xA>
X-ME-Received: <xmr:tNzpZcMtA-ei7oyv3pBjtVPQ7m-jIPrvVHEhT8LHViDXMqA1rOBHV15JKSk_zUoR6yWdV_efjbEoLHZ9WrVHuXVufudUMcFlVg1VUVKbivT3Pg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrieefgdejiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfggtggusehgtderredttd
    dvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdr
    ihhmqeenucggtffrrghtthgvrhhnpeejieefvdeuleffgfejudffvdeghfeigfejgfdvvd
    efudevffefveffhffgkeeiffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhep
    mhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:tNzpZS4aH8ZUVU0ZK2ddVGGUP6BrCM1fTd6-E5DHhqYg7YMZFJkNpw>
    <xmx:tNzpZe49b4_ciwhPMhFaZx62xJAveBhjGujkqoIllxlXvet5lRXlpA>
    <xmx:tNzpZajOTwDHEIl27g29kckQpykBCsS0-qsSO3Ivm8ZyWI8naYx2lA>
    <xmx:tNzpZUT9QVH5vLI0wKOUzBOfQ09E8J6Xoh0nEGbZ3vDWDnX2CTsDqIYnnlE>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Thu, 7 Mar 2024 10:26:43 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id d1ead4d6 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Thu, 7 Mar 2024 15:22:08 +0000 (UTC)
Date: Thu, 7 Mar 2024 16:26:38 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH] reftable/block: fix binary search over restart counter
Message-ID: <a4312698cceab5f2438c9dd34465da21d719e256.1709825186.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="HJZWxFgtkMtBheg8"
Content-Disposition: inline


--HJZWxFgtkMtBheg8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Records store their keys prefix-compressed. As many records will share a
common prefix (e.g. "refs/heads/"), this can end up saving quite a bit
of disk space. The downside of this is that it is not possible to just
seek into the middle of a block and consume the corresponding record
because it may depend on prefixes read from preceding records.

To help with this usecase, the reftable format writes every n'th record
without using prefix compression, which is called a "restart". The list
of restarts is stored at the end of each block so that a reader can
figure out entry points at which to read a full record without having to
read all preceding records.

This allows us to do a binary search over the records in a block when
searching for a particular key by iterating through the restarts until
we have found the section in which our record must be located. From
thereon we perform a linear search to locate the desired record.

This mechanism is broken though. In `block_reader_seek()` we call
`binsearch()` over the count of restarts in the current block. The
function we pass to compare records with each other computes the key at
the current index and then compares it to our search key by calling
`strbuf_cmp()`, returning its result directly. But `binsearch()` expects
us to return a truish value that indicates whether the current index is
smaller than the searched-for key. And unless our key exactly matches
the value at the restart counter we always end up returning a truish
value.

The consequence is that `binsearch()` essentially always returns 0,
indicacting to us that we must start searching right at the beginning of
the block. This works by chance because we now always do a linear scan
=66rom the start of the block, and thus we would still end up finding the
desired record. But needless to say, this makes the optimization quite
useless.

Fix this bug by returning whether the current key is smaller than the
searched key. As the current behaviour was correct it is not possible to
write a test. Furthermore it is also not really possible to demonstrate
in a benchmark that this fix speeds up seeking records.

This may cause the reader to question whether this binary search makes
sense in the first place if it doesn't even help with performance. But
it would end up helping if we were to read a reftable with a much larger
block size. Blocks can be up to 16MB in size, in which case it will
become much more important to avoid the linear scan. We are not yet
ready to read or write such larger blocks though, so we have to live
without a benchmark demonstrating this.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/block.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/reftable/block.c b/reftable/block.c
index 72eb73b380..3d7a7022e7 100644
--- a/reftable/block.c
+++ b/reftable/block.c
@@ -302,7 +302,7 @@ static int restart_key_less(size_t idx, void *args)
=20
 	result =3D strbuf_cmp(&a->key, &rkey);
 	strbuf_release(&rkey);
-	return result;
+	return result <=3D 0;
 }
=20
 void block_iter_copy_from(struct block_iter *dest, struct block_iter *src)
--=20
2.44.0


--HJZWxFgtkMtBheg8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmXp3KkACgkQVbJhu7ck
PpT98w/+KDtFN5HFI8JNl5lPxQx1TusCVtalbD4BPu42JZhK/Jtql8Eb8ZFaDmgP
lPThTUta6CHCvALskUGPfU4DZE8xu+gWmtJww6w8tgmyZYiJayJ0la7ozvaB7TKV
FicTn0rdex6/8oFOlMVC8o9YEBIs/LXE6v/6OkYWuati33q+RTWfxk5HTNwfiGMt
1ZRX1RWXHtcYTgSCCAoKIfWytWlJxg/UeXwHGmhm49uhARIdmee2gX2qIoY1jOlu
SSxtM0E7Bo4lL+jxJOUYcT8ktmDqQaw6CmMpA4LbudHxANoHC3dcoktF6dhXuGCP
IQwVhaA3JWBq5oDmFZOmoiotqq8kfea7W0MqBAPVHlGxocp6cFndamIrSgh5GpPG
TVX63xEZpj5i4XSrw43eqaKsIPb3sYmVtJ6W6ugm93VkEX9jCH8b7LC2/tDm4mQO
bA+n5X2BE2PumJ4tFbkDzBR1p1BJgxwf8sgCqKGknVrKKeqw3Nvkkd3C1LsVGirO
lIlgfFO8KEj/gnEyBR/y52PJ/Fx7EeO1bcUiTAELbGuhx7eRs0PGH5pbBSwV+HEo
82YGjIFBztOaD+X/tp9Ux5lMLroPi3i3VcHLnSkQAKab6mFgJ9lmh+suA5AR3jOt
O78i2SjTXH5f1f/r2+RT8P14jRh09DX81X+1eovkLwsSfTbA0nM=
=yZXa
-----END PGP SIGNATURE-----

--HJZWxFgtkMtBheg8--
