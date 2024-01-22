Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4B593A8F6
	for <git@vger.kernel.org>; Mon, 22 Jan 2024 10:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705919544; cv=none; b=FGjZM4uzDR93XrAd8YLKNi0ISRX95a3mJSaCQVl7Qdkm2zF8j/P2f88M76qQydEeOTvAgR0U6FsPdiiMe5XSUX7gBBVwmYvSeM2IK3bRm6U3oTqvv+VMlIyAIvy67OiiYapsgTl3SIK0GBPcRr0hOr09/g74+9yaOCcd9ZaGJrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705919544; c=relaxed/simple;
	bh=AeTsk/JQ0GH1BxNMc6Ux4dVacYcJzWt1+S3Afda+hX4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p2XzEz1hzm2C/0vHPzdeFRgwkB55TckIbEOQiKCKhbIYrjIMj8khLWsSsmL9QTP/iQCUwI6l5BzCo7XCVWcyuC3ZxJAZlnmj23h3Mfz3JvMup4+MxzkjUJqwUI4hQn2ABHNXDpasnckWW9s6oj/n39dOyRhADJn7ak12/DP0whM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ZeY+gbPG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WIYTcjR/; arc=none smtp.client-ip=64.147.123.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ZeY+gbPG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WIYTcjR/"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailout.west.internal (Postfix) with ESMTP id 849F53200A74;
	Mon, 22 Jan 2024 05:32:20 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Mon, 22 Jan 2024 05:32:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1705919540; x=1706005940; bh=4wBQ7IB4Jw
	5w0Vfgaf7alRL2e4ZiZuPzGwdS9ZOiI7k=; b=ZeY+gbPGlomLEcXPX4gNXCDMQS
	3aIm2LSqkIS4P9PYnhxoR0IWGB3lQrYnQkkp1wr/T9g07pI6DJBzG+1U/O4rAo9d
	NvIlRKVpRttBVTCP45r7ZtaidlW4VUESziPebreU0IhSKeAfc48a4Wlzgh/fGTLk
	1RoVVNt2ldO55W5RNLEY9UT8l6egKSVUIqbqgUz6Coe2+ssP6jSZjECoxhg13B7a
	Z8ahYbQv4RZQEcsXKiZRK8s7Wz/Wj96kJm/KoSPRdJouRe7p1oMYgJF94uZ6315N
	ywK6O5KfGH0io2Z1S5qat4ad73A7VPvr2vaZreSPVuO15EHn/M0z4pbM8iaQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1705919540; x=1706005940; bh=4wBQ7IB4Jw5w0Vfgaf7alRL2e4Zi
	ZuPzGwdS9ZOiI7k=; b=WIYTcjR/23e1oPAFT7ioKNRtX94nCQU/EjKWTFLXpV3w
	1+TraBBuKd+qbiWgPN4gc2Grn67lOK8o0KH3nSYP6fQ3ZG/buMBy5x+X/1DcRzWL
	jbjhXgZW84VWu7q6lgVqGAh7szoLY5DjWQNB8pIz4fQKWtl6lnieUQFLbSsThr5G
	6QuG6z2IzsnLQrGVvwdfo9YUdLbHAw7sMWdaVDJl8ux6ci75U4m+o8dxv/S456os
	J2AXIHkGP21zRkj5/ZgK5UCnoJk813a/yLKLcm4cqm42IWOP4e3cGiceQhr1+Wgk
	2Cb6ZGzsbrKRqKdfLAvMiHInyyoggKVIVs04AJFhVA==
X-ME-Sender: <xms:M0SuZS1iw_mkSuJXNvDMlJwcExXiTyeIiKGNkHoX3poBmelH1ayzTQ>
    <xme:M0SuZVFX17GHES5-Le5jFLUBozcEeP5nrilUNpCSL6j0Z6ON8KNPI_RdyrHsMNNqI
    04oTNckI-N-AnGisg>
X-ME-Received: <xmr:M0SuZa5LL-XT_Aof7gGon0Tj7WUfRiQiS-7aQKIyhbvXedGoLrwECBokCySSiYbU0LImswa3wiEm_LZiGX3a2s5Hd4m0-6dmluGMXQvuEhbhYes>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdekiedgudehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegke
    eluddvfeefgeehgfeltddtheejleffteenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:M0SuZT35bACoy9RSOU2wAFwelg0Unu-0EcvYN0Tcg-F8AoT9ABuUfA>
    <xmx:M0SuZVGx0vwDiyX1RODogc3hfLYvOKfB-jWO3k0E3Bv5mAkS5FinWg>
    <xmx:M0SuZc_hlibVSS-or1AIgbuN-LtTTsb2V7W0fOsQHEjMDdRxua4W4g>
    <xmx:NESuZYPwjBWjqFOUeIS5mkD2yTDaZzvvc2RmOWWAHy6q_GlzTey_8w>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 22 Jan 2024 05:32:19 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 0218ab41 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 22 Jan 2024 10:29:14 +0000 (UTC)
Date: Mon, 22 Jan 2024 11:32:14 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 2/2] reftable/stack: fix race in up-to-date check
Message-ID: <Za5ELqZps0DLbb5q@tanuki>
References: <cover.1705585037.git.ps@pks.im>
 <713e51a25c1c4cfa830db97f71cd7c39e85864d4.1705585037.git.ps@pks.im>
 <20240120010559.GE117170@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3YSKiw0PpEkzwspn"
Content-Disposition: inline
In-Reply-To: <20240120010559.GE117170@coredump.intra.peff.net>


--3YSKiw0PpEkzwspn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 19, 2024 at 08:05:59PM -0500, Jeff King wrote:
> On Thu, Jan 18, 2024 at 02:41:56PM +0100, Patrick Steinhardt wrote:
>=20
> > Refactor the code to stop using `stat_validity_check()`. Instead, we
> > manually stat(3P) the file descriptors to make relevant information
> > available. On Windows and MSYS2 the result will have both `st_dev` and
> > `st_ino` set to 0, which allows us to address the first issue by not
> > using the stat-based cache in that case. It also allows us to make sure
> > that we always compare `st_dev` and `st_ino`, addressing the second
> > issue.
>=20
> I didn't think too hard about the details, but does this mean that
> every user of stat_validity_check() has the same issue? The other big
> one is packed-refs (for which the code was originally written). Should
> this fix go into that API?

In theory, the issue is the same for the `packed-refs` file. But in
practice it's much less likely to be an issue:

  - The file gets rewritten a lot less frequently than the "tables.list"
    file, making the race less likely in the first place. It can only
    happen when git-pack-refs(1) races with concurrent readers, whereas
    it can happen for any two concurrent process with reftables.

  - Due to entries in the `packed-refs` being of variable length it's
    less likely that the size will be exactly the same after the file
    has been rewritten. For reftables we have constant-length entries in
    the "tables.list", so it's likely to happen there.

  - It is very unlikely that we have the same issue with inode reuse
    with the packed-refs file. The only reason why we have it with the
    reftable backend is that it is very likely that we end up writing to
    "tables.list" twice, once for the normal update and once for auto
    compaction.

So overall, I doubt that it's all that critical in practice for the
packed-refs backend. It _is_ possible to happen, but chances are
significantly lower. I cannot recall a single report of this issue,
which underpins how unlikely it seems to be for the files backend.

Also, applying the same fix for the packed-refs would essentially mean
that the caching mechanism is now ineffective on Windows systems where
we do not have proper `st_dev` and `st_ino` values available. I think
this is a no-go in the context of packed-refs because we don't have a
second-level caching mechanism like we do in the reftable backend. It's
not great that we have to reread the "tables.list" file on Windows
systems for now, but at least it's better than having to reread the
complete "packed-refs" file like we'd have to do with the files backend.

Patrick

--3YSKiw0PpEkzwspn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmWuRC0ACgkQVbJhu7ck
PpSwORAAq3i2gGllX9X9G9PPPojLRaUb4zWJCEuIHreBKLdMnPjz3oXudXcPezsL
Qd7MERBoA6k/Y/+unwmv4aIm5Jjp1PIn8ITQerHq/Mp3pjQCpKRMizE7RW1TLRy4
fB8caIXnqhHj9d8GhAKgoRC+x/O5Ds5E6rxaU0xcGSAkDgBFQYmyHwqLSUx1OkOx
CWp11fKPfLqLDqoK2t4eSoEvQbACEvWg1dxphAyvtwlS5y1i22tTPzohFyRcqYnp
3g4toj9VtbImBM+/J7/MsQmCOvVU1DhQCUscSgJ2WjU+ccjPdFr620AyFhM2PFvu
2gb3FSH1HBqAz6GW+0emt4mqv6iBaycD8SUqXcUbIh1OyK0X3Un4oiar+y1IVCJy
YbnZRCfxnCJPSj2MFzPbIBt3X4ZZkZz5CZMG1hBIMAltuueErlZsBtQzVgx/Ww9C
LdWeUGEQYpaqSd4t/4FHjVc7OuJQHzK6bXcJamle6x4hzcW0znFz+xJxdBoyY966
0hqAWHuC+JwUPX//4NGZJwhX8uBAiLhZDIhY1WIyO3WjOamk/bvBgt9zCosb4DPt
81NpxpYn2kKdvGcZIkR3nvf1MTiBkUKKfTqT7rKFnKKA4Xv5Mxa3siHxOBjTa+Yd
w2Di3XsQKKOzM5fERa3STelo5C9+4BJ8t8Og0IyBJI5TST/Gcjk=
=D1wz
-----END PGP SIGNATURE-----

--3YSKiw0PpEkzwspn--
