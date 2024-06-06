Received: from fhigh3-smtp.messagingengine.com (fhigh3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFE00153517
	for <git@vger.kernel.org>; Thu,  6 Jun 2024 10:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717668194; cv=none; b=NxB9wMAo7JSrSwUhDOD17r4vMf1TX6VWOPbyINjw1Bb4FcAnyNUHJhpOeoQV2EqoEttoRtX+l4icyf+9Z9I6gmJtVAbu5l4+H3y5gRjKpD6WMkN08bJZ0Nk/qx2NXHUuChgDDdQ0Z4i1YyeHcXQRjaqKjyB1QfMwV/nsjluEjtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717668194; c=relaxed/simple;
	bh=QcLL5lQbLbpenKXXI0F0/yvy8dwniwTkkiNTfO81uRg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Etw6H6V3UlSCO+GmXeJNYZXcn1klW349tiVmBaafAm0FUfAqIea8J2OlgM+i3KEG254JZKnje4EVcn/dOsZsOJVjcnIbW5Q9EsiL97YMkOXgy2kbLMkm1uTxu2GoZbZzYCLdyDiHlPYyPmPBGwlaKqRIc+vWrIO+eEs4+9OcalE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Oi5yobWi; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=E1vhyKWI; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Oi5yobWi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="E1vhyKWI"
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 1620F11401E6;
	Thu,  6 Jun 2024 06:03:12 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Thu, 06 Jun 2024 06:03:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1717668192; x=1717754592; bh=tCRkBCiLal
	iraoOf3N10vr8aZ+6RjSoAV1b6/uZv0BM=; b=Oi5yobWiRVnkRYlW1u6XvseTJ4
	SB5UUNO+qjNoEUOGoCxnNJyEFBPej9M/AZt2hD5l4Yc7iFLsSg4g/O0VUvaNd2Fw
	nYxy3n852qc3jQKiIR/FPeOLLbR55lyzy+fr/5k+66tPtGhdk5W//UuMVBGHe0oc
	vhDNzi82VYioS/UPBO+rBpCiY9b+Tu7mvyR/Xq2dzEw78zbpaLVaCpjenxxmH5Wd
	RJMXKHr9fZkkMUvXKW4OVG8lV8InCWqYhRyvUqGX01q1ovrK8MoySo+N+0ZChaOv
	+GWbQZS37WoRtqI1ZtEJ51zcZn6B4m23krTS86sR2GMm/Xql+FHK7tx/qvJQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717668192; x=1717754592; bh=tCRkBCiLaliraoOf3N10vr8aZ+6R
	jSoAV1b6/uZv0BM=; b=E1vhyKWIC11LBSpDCDyMlDH20sasKtRXviafNIIkUGfE
	gBg/15ItmOOjEVHxrMa9QOJU0ZmAOCd2e6A6/oc2Fu8l8BqqNU1ePmYER2HyElIE
	uSQdsCptAiwM2Sg4EGyaFOyNQxnVDWrubJHd+SEoixl+ByLJNV8qjq0772QIaq68
	08SfqzWLu7CbsEPfJcPjVhIUQVDW+wFeyNeWonFsbKwHv/9vahOY4rRUYbt2rcPn
	z6PwotaW3DThXjq2f1odok/o+DjQDgsXk30c0AJLboB17f0RoOs5GGRIqXVjlMC+
	2fC98nzmUIyEHcnETwrbz50A+G/Dq62D9RjSu6d0zA==
X-ME-Sender: <xms:X4lhZvxDbiAI7n5aZfrUCvJwhfwxtVnqp0oe1BcmmWwcpldNF6kaEA>
    <xme:X4lhZnR2TVy1BQ4_XX1PjMu979d6v0QHwPeSf9wufd-BLR6v6izp0ah6BcB2nPe6M
    RPYBwXMvpvOxnwTgQ>
X-ME-Received: <xmr:X4lhZpX_t6e1F0stbf0adGg_yDoLD-S120Npbts319jG5tyb0tkvJhN2M33C5ljeMAo2liQpWvoHK0O9bxGk5oILqjZIlCtkOljn0zo0L40oNtce>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdelkedgvdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:X4lhZpgcN9Fr-ZQL_K60Czm9_zXKdxxDeGE3wpLQ4uDv0wdS_EXMUQ>
    <xmx:X4lhZhCBiwAIYY4Un1TH5D3tVYPgIjk1pvHG5LnD3mEjXMK33YATAQ>
    <xmx:X4lhZiLwAO2keEfbeSd70cU56aBNR_hDmP235cZKOMv0CnMBSbZ1Mg>
    <xmx:X4lhZgBcGg9vEY4h3QA8RVSXwX_1mGsmg651CL7vK2sC0v2AHhTe3Q>
    <xmx:YIlhZs9qe_LsGxHYnrQmteLaWaud3KvonfvT7sWzt2d75kw1NIz0o5wk>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Jun 2024 06:03:10 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 4ab7200b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 6 Jun 2024 10:02:39 +0000 (UTC)
Date: Thu, 6 Jun 2024 12:03:07 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v4 12/27] object-file: mark cached object buffers as const
Message-ID: <ZmGJW4Ruz_ZafNZ8@tanuki>
References: <cover.1716983704.git.ps@pks.im>
 <cover.1717504517.git.ps@pks.im>
 <ecca8e973df77cfc8233ab63bf7d1f6fa83031a3.1717504517.git.ps@pks.im>
 <xmqqr0dapq1s.fsf@gitster.g>
 <xmqqmsnyppo3.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="J5Pb0HPaC2B8VDUN"
Content-Disposition: inline
In-Reply-To: <xmqqmsnyppo3.fsf@gitster.g>


--J5Pb0HPaC2B8VDUN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 05, 2024 at 11:10:20PM -0700, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>=20
> >> +	co_buf =3D xmalloc(len);
> >> +	memcpy(co_buf, buf, len);
> >> =20
> >>  	hash_object_file(the_hash_algo, buf, len, type, oid);
> >>  	if (repo_has_object_file_with_flags(the_repository, oid, OBJECT_INFO=
_QUICK | OBJECT_INFO_SKIP_FETCH_OBJECT) ||
> >
> > There is an early return around here.  Perhaps we are leaking co_buf
> > when we hit it?
>=20
> Indeed, that seems to be the case.  With the attached at the tip of
> the branch and rebuilding 'seen' seems to pass these 6130, 7010, 8002
> tests with SANTIZE=3Dleak.

Indeed, thanks. Rolled into my local version now.

Patrick

--J5Pb0HPaC2B8VDUN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZhiVoACgkQVbJhu7ck
PpR2RQ/8Cr6BpXsbYB1JOJMz/n9nY301XicHFkvgeSHLJFlmHx+G0qWq1co57KL3
EYyELo5GwbuOvplJyjiZ34fbfqKaMusWtvih07azFFDvYDKtXKucWSSjiwm/rodE
PRJn0QTAbV7E6xYiQt9uB0kwWcGo1gxBC+NRQ7e2DMEXCZ5i3EFEdLm3EwPLWShw
KfxDrfEhCR3WGB+IEXojJzAxMkcFzUmJnX4HaoIg4XcF7WE52Apvwm1i92QCfmcf
TS0B+lwma5wT9498RZTh3NpaJMpS3NFxCWY6HgqFgqXntnpcWcraWhM7A7Mx8P8D
CveoXN7mhyMIWKQhI5ek2eS9NhMJcLVvKqyMiv1QX8L+ekXjCAGndMPLffknszU3
vJwJO4NhF2QKpnbgVHxpIN6l6dZRM4UqWAF4GVow0WBh/n/kGbQQGaLHnMfepGHd
DAJftcq2p1c2CGjkJ+0N8CTLVsDtUXd7nOM7brPB2IB6yq5UsQf2qz300+5vAMYN
nrhdeWOm8u36nq3bbTQT0iBNZI+BiYDgYH1GyyZKsiQsou+jSe1Q901wsbF5qupY
wkKPgIxG2Gg46zfR3SsHthn9rjKDE0ojQzffeb5TF9yBX2fujNTkO3N7+AFAo4VF
mHIgdM+DcfuoYrmAW46e6+9RNB62x+WZovWPhB4o8XlF8zJKqHY=
=4d5h
-----END PGP SIGNATURE-----

--J5Pb0HPaC2B8VDUN--
