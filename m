Received: from fout3-smtp.messagingengine.com (fout3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5F2C15CD43
	for <git@vger.kernel.org>; Wed, 29 May 2024 05:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716961980; cv=none; b=CKmuhydrJ5h72Xt/BixH4Z62jbS5Pj4GwGDwAkpxWNRf0Q0UFupc83Cby5KBsrHHypCnnmXuKSUebUR4W6Sr07hc8+Ff6n2sszONL1i3S8kJDI/9Jt+2IW6mH3faub5i45bwcyWvPUoFxn7cdot/TGrrVR1OJV6YF6kcP8JiEbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716961980; c=relaxed/simple;
	bh=pM2hxXBKkoEaiihx17P+dcazMsPK8gIuViwd2byWS1U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fQcenjuH2s8J0CJaUxyKlNFhOx6wb1DHH8MgzxfwLDT1GhXgH+23ByemnMvlTMIjb3Z8c5dPWhZHtMHfdtGjI9t/HFRCV/SdIpv7lMH96HDvGuzJi8eCM2yAcdi5Tq2lAnV7jdGwxsD+gsbghm+4NygdZL0xK9gzZoHl1583P68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=BEe1YY8P; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=chf7LUfi; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="BEe1YY8P";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="chf7LUfi"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfout.nyi.internal (Postfix) with ESMTP id 10B7213800EE;
	Wed, 29 May 2024 01:52:58 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Wed, 29 May 2024 01:52:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1716961978; x=1717048378; bh=npxWZfEe5X
	wcw10qspS+cqEiYlLcQ8sXnfJVStI/V1Y=; b=BEe1YY8Pui7SEaJwvg1jjqc/cI
	a0srcqwYDJ/PS75Gtl1lDd7zdlK1afTrJjYs8qtLmN/ZT5C7kIMEB65U2foe6UrP
	blbdEKEGp2OtRsVZPcTKx38bXFH330bhM01WOrupZgVDGQmdlrEeoj2LR6p99QOE
	wWHZWKBIv8avxqm3o+ydR5W664O9uQ4M7JdPnWsrOhHB5LYBQgzwarpC9e7dV0BA
	giqwjvvRcCcmSvqQALOxvopL2tdjXoHcoyODWdG7z8SCsXLO5QzZBDKcEOUNWfly
	8+RWfYdeEz9hRxR4ykKZmQWJZMIwRUAS5UP4F0/TZ90bcPYp8Glmm7xaZR4g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1716961978; x=1717048378; bh=npxWZfEe5Xwcw10qspS+cqEiYlLc
	Q8sXnfJVStI/V1Y=; b=chf7LUfioybYxf/Ee7dO81TG7/HjuQ6bFwmEFQTxXsVD
	6Osmf04seXWr/DtR9R8tYsM40x7gCmU/FP07iPUv5YqWhjuFozJcYKOueHpTRbXg
	X85zLfCZBNwYA5VRhYTerKY/iHKvM2vlQlA8bPRKkFGpWVKzOAcSo2NItgDE+BMG
	jUGf5IhUu3JGgFqezZ0f/4IdvOI4sYrwpOmr+JxCnVIdBKc6j3ySt6SXdJrZpZiL
	7Yvb2VYWFIv9jvpU572j2V3C8DN3G2tydtnSKApHglECAnKzc9zlsrRa1wxaZHpN
	GGihkfRPxgmZ/ql5En/68CDNEUgZ/+x/Y8Key0E7Ng==
X-ME-Sender: <xms:ucJWZuYUpwYxLDDLq1StLJNpXxT41Wmqqfvvpo0Ub0As0TxItgd2YQ>
    <xme:ucJWZham6PEfSzUaigq-_lVV10FaMgDrkVSUVlHudDwwE8kPqR_s2LeLfeGA0NC1j
    L3k4MygghJl9XYUug>
X-ME-Received: <xmr:ucJWZo_T7izx3OpqmqPGguff7hE3hXYXD4MA3eM21fmNkVTl9BvcKRKVvbdkCqySBrVmKJJoC-UTnKJCArrcVMXOd1BkfGOqA0s_t4R-QCBMIYSj>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdejledgleelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:ucJWZgr6eQKnoHchgMwyx5XttlrtUrnN0A4M1OyWitc6vFVR6voO_w>
    <xmx:ucJWZpo2EA5ShNarMmlnjXOmeDqevKhFlcS6kuNTZmunvfcE-yIVrg>
    <xmx:ucJWZuQ31PDJp3n-KCTP-CHFmzi-vyQ0A5nj0KrE_k4f_WBbk7CjRw>
    <xmx:ucJWZpo1YOV1y9j1jSmQ08JDr9FFBd-z2nqWDOJR87toWbjIkVuP6Q>
    <xmx:usJWZqd_O2IR4A4Y8axJcduap399AhiHk-YalEAtfT5jMUg-6UlD8RAX>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 29 May 2024 01:52:56 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id ce245af7 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 29 May 2024 05:52:42 +0000 (UTC)
Date: Wed, 29 May 2024 07:52:53 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Xing Xin via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org,
	Karthik Nayak <karthik.188@gmail.com>,
	blanet <bupt_xingxin@163.com>, Xing Xin <xingxin.xx@bytedance.com>
Subject: Re: [PATCH v3 3/4] fetch-pack: expose fsckObjects configuration logic
Message-ID: <ZlbCtUr9906gq300@tanuki>
References: <pull.1730.v2.git.1716208605926.gitgitgadget@gmail.com>
 <pull.1730.v3.git.1716824518.gitgitgadget@gmail.com>
 <67401d4fbcb3f07d31589bb8ec10060dcb77545e.1716824518.git.gitgitgadget@gmail.com>
 <ZlXIBrs5Q91r_-qU@tanuki>
 <xmqqikyx6ew9.fsf@gitster.g>
 <xmqqbk4p6e98.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="xidPWb7ecbRaXFBG"
Content-Disposition: inline
In-Reply-To: <xmqqbk4p6e98.fsf@gitster.g>


--xidPWb7ecbRaXFBG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 28, 2024 at 10:24:35AM -0700, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>=20
> > Patrick Steinhardt <ps@pks.im> writes:
> >
> >>> +int fetch_pack_fsck_objects(void)
> >>> +{
> >>> +	fetch_pack_setup();
> >>> +
> >>> +	return fetch_fsck_objects >=3D 0
> >>> +	       ? fetch_fsck_objects
> >>> +	       : transfer_fsck_objects >=3D 0
> >>> +	       ? transfer_fsck_objects
> >>> +	       : 0;
> >>> +}
> >>
> >> ... can we maybe rewrite it to something more customary here? The
> >> following is way easier to read, at least for me.
> >>
> >> 	int fetch_pack_fsck_objects(void)
> >> 	{
> >> 		fetch_pack_setup();
> >> 		if (fetch_fsck_objects >=3D 0 ||
> >> 		    transfer_fsck_objects >=3D 0)
> >> 			return 1;
> >> 		return 0;
> >> 	}
> >
> > But do they mean the same thing?  In a repository where
> >
> >     [fetch] fsckobjects =3D no
> >
> > is set, no matter what transfer.fsckobjects says (or left unspecified),
> > we want to return "no, we are not doing fsck".
>=20
> The original before it was made into a helper function was written
> as a cascade of ?: operators, because it had to be a single
> expression.  As the body of a helper function, we now can sprinkle
> multiple return statements in it.  I think the way that is easiest
> to understand is
>=20
> 	/* the most specific, if specified */
> 	if (fetch_fsck_objects >=3D 0)
> 		return fetch_fsck_objects;
> 	/* the less specific, catch-all for both directions */
> 	if (transfer_fsck_objects >=3D 0)
>         	return transfer_fsck_objects;
> 	/* the fallback hardcoded default */
> 	return 0;
>=20
> without the /* comments */.

Ah, right, didn't see this mail. My revised version looks the same as
yours, except for the added comments.

Patrick

--xidPWb7ecbRaXFBG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZWwrQACgkQVbJhu7ck
PpQjORAAj0Px1S9l4O4WltmVuYKec7CNmNk+hSxFGPyWxnxCklxT2SHitWytDFMm
MfYcJ3ea5Hg1kzW29yF7D5QUaqjiUB4jzRoQl797PPp3vL3jp7R86Laji9GtdEK8
dpqhzZ4g/EpqM9+fd0cOKtPwLs0+fl8bGllJbyGD4+qUlpBgMxsTUUeHjmks1iV+
ZMLuqyHqy/PmS+yPhNDHG81h02HaRzGwzr6AX5EeLZ/diXcqRvtWr6w0VrwPVNQ8
U2XnMiWgt3WkGEvlkOqdQz/b06En5I4lTQs7mVhC9HLOdPLbSgnWKOVwyVIBOItq
JgQaZww6EO/XP+YQE+Kfeh8GUZQcP2z7FthokxWXWfyLoKVhscN6NQ7RyEBlLiho
rWvu30ZO0iGe8crQ5cAXQ6XKgb2MR/a7eD4Zf2tV1FsY+uc8wGwQGHUIz5zEZENA
aPb6mdRFCAwQbDU56RtslKRzGmWM7B7zZEEh33QZEeoVo9/BRAqptYKKi8iX9Q28
4Fya6sJ8X9nqfID06AxopcpIVa+uaumMy8F4tVU7iVk/QgF0UDbX017t6wPhdBXm
sxCNWS9k9Ilbktaym6Td/StWGl+KFzdWBPFV6BY/btW3zJXL/SCyNyYu7vB6Cxqz
J/S4ADBFWn6SfLHGS2MYE6vinfdspiOJZjEwRld9eXX7a3fJi5w=
=zL6D
-----END PGP SIGNATURE-----

--xidPWb7ecbRaXFBG--
