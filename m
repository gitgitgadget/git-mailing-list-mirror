Received: from fhigh3-smtp.messagingengine.com (fhigh3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6900E135A75
	for <git@vger.kernel.org>; Tue, 27 Feb 2024 08:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709023546; cv=none; b=ccmdFTfnnc6fKGs+BUZLeeG/vv6tyQMbgQjeO5qMx38aoS+LAUiV4aez1TDFXi0xy9oarA1pba/IJ0xeVGcTvT+qmdjuWLzLVBNK63PjOUaa0iAmorSs/vVvIiYFJP+mnOKHofXu8lpoOb5ALCF1PZvqfulIUG4y7bz8Wc5jOrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709023546; c=relaxed/simple;
	bh=yiEJwFMVo3zYMsurFIVQ8tv0qC8YuWtoLxLfMZ7izPg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZUz3o0G7/haB3/sUE23F5eaRxlAlOmPEhkKi0kLUzdym+iKzx4o9taBAr2RLL1eathCAww7nJJy5Ia+4/uL1b9bc+QZafePsJj8q3Q2uJMWnDlNGYrNQeJDFLPo6bDOFzb6y8ktLli7j1W4pLlQAwPUqacqeNjFKOnHAiBB+2hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=W1ScbmQr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XNjQqHst; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="W1ScbmQr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XNjQqHst"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 72A0A11400AD;
	Tue, 27 Feb 2024 03:45:43 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Tue, 27 Feb 2024 03:45:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1709023543; x=1709109943; bh=JDMs6XOifc
	nUNgUL5dM3KK2z3zbAz7hsTdxFlrlhrYI=; b=W1ScbmQr3/HeOITXZf7cn+bR8J
	1UcnfcesPk+kVgOHxcm85jiQ10VfgixwKghFqdEbRQcbfyBC4GN/And6m78yHkaT
	JwztVUhBKi+UJjvmhepcv2JcnDwxgjiACccfd7Pl4MofJeYQ7PbXsVt0trjgDep/
	0G08M1nbzMTQKmW2ReDN8Nwhd2eGUzK1Xor2w290AcRCaB3+gkmfAll0SMjIYAsd
	XqOE8aers+Cbzive6nfGFjwA6JyQ/tmZAxEgXO+Qb04PPuhcvn5ktu9YkN2rpxJA
	SYvu/B3GsN5RX6KRbydsu+1G1uF/s4ftD8EWYYuVozH57FUfztaRZeg1Ykrw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1709023543; x=1709109943; bh=JDMs6XOifcnUNgUL5dM3KK2z3zbA
	z7hsTdxFlrlhrYI=; b=XNjQqHstor6JxPXUBeQcS/BhQUIMfMLs2a7yXRU0LXQK
	fURG8B19GTdpLU4RImuD3a6nEytCsCnBQMjgNrSUixepxGRKTwv2uXC0gQsZcBD3
	tGe5hQO6PBQVN2+82IEixnnrxhS7TYykfj0EIt+8kvIAcVLOedFCwxl9tFy2rt0Z
	Lb07vK8A3gV7oWssQ+QRl+udVuE8KZ5gAn4ebt0YaRIMVG3vq8bA+XRkCCSYqc64
	74achQ8cqakqaErFTq9FnPv2hDYsX/zD0JR+O2Ca7E7jTqJVOSlIP7xDOgRtZeAO
	75Kc6zSmV8qu6tpWIK6MzJZf/VsfIvRy7+CUMXav1Q==
X-ME-Sender: <xms:NqHdZcBcphF9vzRmeR8t-6RGzWPgXQk1bOMfOe5RL80Ag9scTunSrw>
    <xme:NqHdZegZIETooD33u_u7L_EIhUPK3G1pwMzTloooZRlu2OmVxc8DQpTh8TR1Mqikw
    zgeWq-XHEOp9r0YXA>
X-ME-Received: <xmr:NqHdZfnPMeLDEyERsBDDxcGgXXgbezJjjvK-8VmY6pfgJQEKisuHB2aY12D8AS_xXJIflbte7w9P8AgYgHEQoX3B67Yq8XvrY6QNp-qm2P22qvOS>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrgeefgdduvddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegke
    eluddvfeefgeehgfeltddtheejleffteenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:NqHdZSyvfvxkoWI-WIjBlRxBTjYug0_kdQ7hpoYTErlQb1Gqaxoc6w>
    <xmx:NqHdZRTiJTQFaLSXDmEN4QEgzR0g5QFr2ezYsgAjNpTHF88HjokDXA>
    <xmx:NqHdZdbWlYCOmBKoKwCsG2jt1MdKhQp4YDa6t5mLpkI1B7AzJeXT8g>
    <xmx:N6HdZfON_ZLHHONMXjbwy8jD1vkPQKepEdsotJEqTfM6LmJRUUNTdA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 27 Feb 2024 03:45:41 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 06794d02 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 27 Feb 2024 08:41:24 +0000 (UTC)
Date: Tue, 27 Feb 2024 09:45:38 +0100
From: Patrick Steinhardt <ps@pks.im>
To: phillip.wood@dunelm.org.uk
Cc: rsbecker@nexbridge.com,
	'Torsten =?iso-8859-1?Q?B=F6gershausen'?= <tboegi@web.de>,
	git@vger.kernel.org
Subject: Re: [BUG] 2.44.0 t7704.9 Fails on NonStop ia64
Message-ID: <Zd2hMmIzHKQ7JE45@tanuki>
References: <01bd01da681a$b8d70a70$2a851f50$@nexbridge.com>
 <01be01da681e$0c349090$249db1b0$@nexbridge.com>
 <20240225191954.GA28646@tb-raspi4>
 <01ca01da682a$5f6a7b60$1e3f7220$@nexbridge.com>
 <5e807c1c-20a0-407b-9fc2-acd38521ba45@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7DrGFtClYeNJjpUF"
Content-Disposition: inline
In-Reply-To: <5e807c1c-20a0-407b-9fc2-acd38521ba45@gmail.com>


--7DrGFtClYeNJjpUF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 26, 2024 at 03:32:14PM +0000, Phillip Wood wrote:
> Hi Randal
>=20
> [cc'ing Patrick for the reftable writer]
>=20
> > The question is which call is bad? The cruft stuff is
> > relatively new and I don't know the code.
> >=20
> > > > reftable/writer.c:              int n =3D w->write(w->write_arg, ze=
roed,
> > > > w->pending_padding);
> > > > reftable/writer.c:      n =3D w->write(w->write_arg, data, len);
>=20
> Neither of these appear to check for short writes and reftable_fd_write()=
 is
> a thin wrapper around write(). Maybe reftable_fd_write() should be using
> write_in_full()?

It already does starting with 85a8c899ce (reftable: handle interrupted
writes, 2023-12-11):

```
static ssize_t reftable_fd_write(void *arg, const void *data, size_t sz)
{
	int *fdp =3D (int *)arg;
	return write_in_full(*fdp, data, sz);
}
```

Patrick

--7DrGFtClYeNJjpUF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmXdoTEACgkQVbJhu7ck
PpQWXA/+OZGbu6ImM11TX9dfJkGLsBmnVTuoqLSpTpbYCOvEF61ZtYurXvfFryUe
a3V7EfiEf9ywXQpkrtUW+KV1Har89/PxPClu8WUVMFvmzPPvcRhjMfr/vvNu9E+y
hJJqpEGJAhbAcSSIIZBszUn+qn3MHU8d+CYPefHY34k1XOKrpmWbZGjHVk++PY9C
+mx3HwP0j2HvdtdTE7lsJbP07Sph8mBKyY9wGBe10ROzTlWdtnFpbYgov3Ebzkv5
7PpwL58LILNxwe/hbz+X8ZwyiyPX2bBQbrgdU+QBFRKGE7LSaDVJF/gjQENdvPZK
w9V7bbCsRI6EN+XNuXoPw8l1MsiSkVV70qbNFigiGodDQWEOfL+CvBduumg4AnZi
3mQAbqzeEdTYcpJpITjHZrTgdxZZQxBOV5Vok0X8GrJP5HC4bG8pR1eJK0iThK1N
jcnN8Rtkq6wg1fHqf3UVVSmAzxwtecTpjxBmATRoVEJFtENeHCzlHRbm7B6JQrEp
uyNR4MR9LUZQXzT12rOY8JtQpYKRqSICKIQD1CswkEhV1m9G+DvRUzMBs43JRq+N
0X7sXwFk45vJT47aLM/2tWPbnsb+mGcNnBEKm9fR0UGz++uLqjYKBazVFyghH2w5
+Op3NdhWDzIRsq/QL1yS8BdkX9SEGqKi0RnCpsACHWXF53S6dTM=
=oN+X
-----END PGP SIGNATURE-----

--7DrGFtClYeNJjpUF--
