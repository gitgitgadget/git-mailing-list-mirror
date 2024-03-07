Received: from wfout3-smtp.messagingengine.com (wfout3-smtp.messagingengine.com [64.147.123.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50EBF13959D
	for <git@vger.kernel.org>; Thu,  7 Mar 2024 20:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709843768; cv=none; b=bw5ez197E4iwG5dqS/ktnPOiiFmCGJtS5jJ/mjUg0RgsCrp7+ZJZbJgG7VJ5PqAbMnBJXvVI9123hePzUYet8UZZnePYHMH4vJjWzrm+VAOUT/iFuXCP0KaaL1s/QnwKgGAyVaVNd5pcKr2TYLLkOkol+Gr8qVoqFSeXFMnqplI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709843768; c=relaxed/simple;
	bh=rfGkUN9b6b0UGyJ4I6XbyyWkBeEry2eTNxa0pYZp/N0=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vbx4n1S1t4AwK3CVPbkEccq5rF9eKkxvMR6rxns6GuSoAJDdEw1mtn3vXb1gVNN6nBFZNWYR9UP+y+tyM/mGGK6ZlQ+u9LFCsI6b0h9VM8IQvdTtYHvxh/vIyZ4nW+gpGhDeQAQMHpFVDyAjyxQNHpdpU+gxcrAA0ZaoKhQi2fM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=evQ+Ig0l; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JxCXApaZ; arc=none smtp.client-ip=64.147.123.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="evQ+Ig0l";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JxCXApaZ"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfout.west.internal (Postfix) with ESMTP id 5691A1C000B3
	for <git@vger.kernel.org>; Thu,  7 Mar 2024 15:36:05 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Thu, 07 Mar 2024 15:36:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1709843764; x=1709930164; bh=LFT4peYgex
	UVtIUqJl80bljlEnxbilKthFXZL8JAp2s=; b=evQ+Ig0l0aSb7A3ItiA1EU9sf+
	A4zsHIakdHpzj+xo3NcBEveb4O2Ua9tba9qqv5EiMMLjljahHVlQV2x3gvxp1M12
	21+r3Wac1FjtFwGsXH2R6vZppwI+A+L4luhO/AG1+KkeYALW3f5o28ohk7F+ePWy
	THAGYBAX3bie02pwo+F/YdvEbM64yrPMeVNS8R6ahd2XNjR/JxbO/WfrdJePoht4
	/2b3B6ilb+d1u891JLWanv4dgdeKcsRA9KCBQoYFvyUuJL9w/wNvsSfW/cJJudC2
	O2F9zLZfBxdPFkJ41v1slgvtlmzniitt3ueRuLK4uolQ1yG+f8xQgzDi8t/w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1709843764; x=1709930164; bh=LFT4peYgexUVtIUqJl80bljlEnxb
	ilKthFXZL8JAp2s=; b=JxCXApaZaJfpeAj/RhVEKQhLpjG9NRPGTNj6WXn7MU7n
	cBF+riRb4KAxyxuH8xEDBUiQmKG9DeNsGUatAQHDEa9Jmr+fomRFADr1Qrs+FGFV
	qzQiUuf+KhIUmwFtOyyJvwu6L6r67KOQN7inR1pa8pufqV41tGdcrDyBHlJT+kWi
	QQtG79DVjj/lrdE4EEEpV/oOxZjIJrCPIa4b0u48TZryv1h/Y41m+v0GW1rqXOVh
	Np9IOvM8UrJMGMnXaskw3dUhETe429KvaFSktwVJECrcRemgV4v8pwTIt3o4ejEe
	l52ps3hHvFZ1FX28tRejKWJbbs8gD46eq6EY4LbGAA==
X-ME-Sender: <xms:NCXqZWDCIF4y1m6H8OCwfjF5OnDpD1RgR6isAskAi76kzZwVFgUHSQ>
    <xme:NCXqZQgfCzs_9i8qV6erJH_wRe9DM-6NICoB7Zvp8deH9uhRTi0gYARqCNyhCk5_3
    SZmlgWTqbahNUqlrg>
X-ME-Received: <xmr:NCXqZZm-XaR5C2DrfUBedaMZqkRNF2tDNp1cjU_i8TuD3JEPnqONILP4blW0kOO7aReZQTlNmZERttXf4wnmSSTpOptkhFdQ4wW2uDaHDR7VqQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrieefgddufeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:NCXqZUwJF90b5PTZ-ss4dLQVI4lQugq__rRtZI0c0jKtmqZHChD3kQ>
    <xmx:NCXqZbQBfYvX4ea-vJgR8m-62I8_mKdUnqcIHrRSPACLDWiM8b-zvg>
    <xmx:NCXqZfYNmN7G7q3JHaDrlXeJBnMA7JTK4srYXDHZQ4dcUHsK5cxNsw>
    <xmx:NCXqZSJyEXaz4qKa_7S1Q8lcxNIk-ePJZCR-C1qp1Ei6ZJ0dpWDFdWCLjWQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Thu, 7 Mar 2024 15:36:03 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 4f64b42f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Thu, 7 Mar 2024 20:31:32 +0000 (UTC)
Date: Thu, 7 Mar 2024 21:36:02 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH v2 2/2] reftable/block: fix binary search over restart counter
Message-ID: <370b608f9007abe9c0562d76894e2475d19867a1.1709843663.git.ps@pks.im>
References: <a4312698cceab5f2438c9dd34465da21d719e256.1709825186.git.ps@pks.im>
 <cover.1709843663.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="T2sD+gwJbjGEf3Dm"
Content-Disposition: inline
In-Reply-To: <cover.1709843663.git.ps@pks.im>


--T2sD+gwJbjGEf3Dm
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
index 72eb73b380..1663030386 100644
--- a/reftable/block.c
+++ b/reftable/block.c
@@ -302,7 +302,7 @@ static int restart_key_less(size_t idx, void *args)
=20
 	result =3D strbuf_cmp(&a->key, &rkey);
 	strbuf_release(&rkey);
-	return result;
+	return result < 0;
 }
=20
 void block_iter_copy_from(struct block_iter *dest, struct block_iter *src)
--=20
2.43.1


--T2sD+gwJbjGEf3Dm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmXqJTEACgkQVbJhu7ck
PpSJpg/9FrSmJ5IkG2NvnUdTtZVtWbHREFRfjazmqq+X5D/ZfRWenNZS2q8bTaR0
exqK8OytX9As/e2DIN3Nsu42n6nbsIsRndqR3e0I2Ub20iqT5IOyWWADkLPhBg7Z
vVLikoEmczELt7mRyvDyAoH071gW4+HoSFfqz+ch/UoqTsE+j3TXEBfQQ1W+z4UQ
dj8DBapRGat0MezHmD8OtBlov9t/sRg+xGcsKIRvFBpUg0IAMRcE5cXsQqxBWHMo
dpTxU3ha6peWsuC4Z56BDFlFjlSu7pD8l+H+9y9ZyhyRSpMueKZppuMhkCXCqj0/
g1U0snw8CF7xlf345HP0qHRJC6OoSRgsy3bNbdkCTQGllQiBp5rhV5ybzXHj+OsS
pxcYe4Dpvy7ds4zZB8V6nLHLki6H8TzOkzoBVctYbXIwDL0+Ld7V6oets+JjmFay
/1sWHtm8QygdEnCZkToOx2sd4sIhoDy/4Qj0bNLRmp9TFGfwOEQIvhDyJfJLAtc+
GAnkyBwca7moP3NuWip5e2SvLSZZyT8pxJtnlUPptigLK8FUGd/9DjPv0j8yr98L
fR0bc7cwqMEgcbFIt32Lf3CHu2uAfiucbzoQj3YR5EOIDfQ/CAuUUQX4BePfIors
WaHg40BI4jUqAvljcIP2M/BUqg/tFdpHFJnW97rRaaZLjyiwOkY=
=X4UO
-----END PGP SIGNATURE-----

--T2sD+gwJbjGEf3Dm--
