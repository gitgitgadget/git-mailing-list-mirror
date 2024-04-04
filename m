Received: from fout3-smtp.messagingengine.com (fout3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E0E52907
	for <git@vger.kernel.org>; Thu,  4 Apr 2024 05:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712207246; cv=none; b=I/ufTj8JTL6AQhNsqdvpwx6xROOzgltYRj03xYEA2apURmBOxfWJ688Bmvp2SvxbfLWuWkuMDtAFcSqrr/pE1NDRUHylx5hmJUxUdJV0bdFnJRD57OPUxuLAN+mi3jom1atZR6/Uh8KAKCdv02FiEAJBdnQqZmYWCTPKGsQyLSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712207246; c=relaxed/simple;
	bh=ii6u5/JXi8lOtz+lOV/g6xN2/wI1L34+F/jgjBlswQA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JMA3nuw8VgPs2Xb4jJlGELZ4bUvoV5wSJuNn3GeClbllFKGiNmUt3MwxxATOCmb+PsEOHZLEtna30CjRG2SUHxm4aHPmsV3xFu51cum5t7CpBDJR7lk0p84GQmzQdshqk5cMu+8OtBBbCVLB6uWTDP38sag5CamkC05G/SPOQYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=EaocVRZS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UIDuBGmb; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="EaocVRZS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UIDuBGmb"
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfout.nyi.internal (Postfix) with ESMTP id D4B87138015E;
	Thu,  4 Apr 2024 01:07:22 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Thu, 04 Apr 2024 01:07:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1712207242; x=1712293642; bh=afCQAo+DWr
	dCi7VSbUPK0+YVjinco4QkmuBvL0nrKKk=; b=EaocVRZSyycEKj/Vq86trmelub
	xXotJihVKraji2sCtk8vdBa4In/QZnBToxECVNPYiaVbBeRZVW2wUROHd+k3rBbB
	YtvLCEOBECRUQ/Ue/X8U+81wlpgHhZPx8Yudoh6UlF8WIaJOW5wswhZPpvOQXvwS
	Agak9ZrlKl+pjxTA5ofVDGVXhCXri8sUkLWb2fri/sPcmkI8TCrrCRpAV6IRGRkM
	2WjNPdBV/FAnYq1+kY7TYAMiNAwm+FvQe+9+7bqMs4yi6WfDxgrkiCGUBMvMx6dV
	5o8A8bu/viuhMgtsgBAOpMC1Cbm9lG5MFTlipY97hPOPf6WvFdyxNKfxPNpg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1712207242; x=1712293642; bh=afCQAo+DWrdCi7VSbUPK0+YVjinc
	o4QkmuBvL0nrKKk=; b=UIDuBGmbw/tpmuijaLYYJKkE6eOMD3qDMviAHT81mvbD
	93Q2XzGEntIsItOTYbjXKeGmbvA5yXDtN1M0y9EwvmthrnbOE9szp2/uUtdacjHd
	+rskFaRpAQxNqJF+1lZjb23yn5U4OADriGy8YCVLBDjl5JWBAn/P3eoIcVaNw0CS
	oFiq75z2v9UJ0pckqMkbM1wwnSCf7STtaMCV8po6dkj97KC/KZN6zHrFNcZrIc98
	uRMTf+5U8yYHNs+lhChuDX+kF/w+ZDMjefP6mZeE4UR2093THHOYo1c7meNTypbS
	QsgWOt3upMzQ+jdO5Absxh+/zfbRx4m2J8pWu/xuTw==
X-ME-Sender: <xms:ijUOZjI2-cCJJ7FKAUs2txxSGZcpssg236qP8OTUloWdyb5eTtiaVw>
    <xme:ijUOZnIb26osAUyBqKNZNFvYOC48nFiotE0wl3pb69-1bFKauAnfhaPHdMM_3K9KW
    1cBio5sB41NDGKKNw>
X-ME-Received: <xmr:ijUOZrtza7oaGzMMyI0wJk1wyWMaB5LkNVXsisn5Yz66o2WgRdcstj02WcF4RRt1yCR7ZW1EDd5biks-wWngXVDInk4pNfndwhfOjmMgrMqUqnzm>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudefjedgleduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpedtieetveevudekkeehieeuvedtiefggf
    ethfekleegvedtjeeuleelffetueeiueenucffohhmrghinhepphhkshdrihhmnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrd
    himh
X-ME-Proxy: <xmx:ijUOZsa0AQna2u-PAsRM3wBjvoKzHNECTV7yMZrHDdIc0sArZUvEig>
    <xmx:ijUOZqag7_QsT85Q_eNnOpQmkXSK6erkGn5REdxxgjAxOoasdPb1lA>
    <xmx:ijUOZgAnSyIOquJHpod24AvG9Jj7x5gTVGJO57lRJsRz9nHstQkCUg>
    <xmx:ijUOZoYsp4UCM2mT0n_73PDpVjgYh8B4GSijIqjKRMqq0q1IPTDIZg>
    <xmx:ijUOZqFskaG13C1naxFQZn9AnnJB1K_syKYXvO-1q-Elz_6Kh-rMBIJM>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 4 Apr 2024 01:07:21 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id aa9e7e50 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 4 Apr 2024 05:07:17 +0000 (UTC)
Date: Thu, 4 Apr 2024 07:07:18 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (Apr 2024, #02; Wed, 3)
Message-ID: <Zg41hugeDA-6En50@tanuki>
References: <xmqq8r1u59cm.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2wa8M4YKVxkj4nM5"
Content-Disposition: inline
In-Reply-To: <xmqq8r1u59cm.fsf@gitster.g>


--2wa8M4YKVxkj4nM5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 03, 2024 at 04:12:41PM -0700, Junio C Hamano wrote:
> * ps/reftable-binsearch-updates (2024-04-03) 7 commits
>  - reftable/block: avoid decoding keys when searching restart points
>  - reftable/record: extract function to decode key lengths
>  - reftable/block: fix error handling when searching restart points
>  - reftable/block: refactor binary search over restart points
>  - reftable/refname: refactor binary search over refnames
>  - reftable/basics: improve `binsearch()` test
>  - reftable/basics: fix return type of `binsearch()` to be `size_t`
>=20
>  Reftable code clean-up and some bugfixes.
>=20
>  Will merge to 'next'?
>  source: <cover.1712123093.git.ps@pks.im>

Yes, this one is ready to go now in my opinion. Thanks.

Patrick

--2wa8M4YKVxkj4nM5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYONYUACgkQVbJhu7ck
PpSNbRAApxDgccWPue9GRrtOzF88HFX6/JwGmfLHXdt8SSyHB4oyKcNilvBBODe9
8OOYGnfeu41QYxviIUBCFHlfm4u5AFvlaOJOw8IsTTXHQoDJREC/x7W8h1dj76/s
/zLhKiEuOE25Fv0XavlyTEDwoAxHcxSmEi5EyXhxLDsWieOMc0VsCIqE4MAhF55u
ty+6Vgq4urMgY4cDO40HWTDgEdkPbBWFVV0xL+r55+XhWAKerlu7N34L6thZYoUS
v1QhAJhS5prXmgmr+2ZJYzSosh0V6otFGKxxb44iqcs+YHm8bLMxd/ETadNnAPUX
+gL8NB0Y4DYIsbind8ROdeaV4KgP3zYOXtzFA39Y5yaVhRmzpkeQ+TheFbFFTKyP
OCH7U078zaFe2pyulCluuiDCgCYvwnFt0wvfSjMXBPhartv1y8AHSxdO0NN0KJoS
1HixSUAsl4G7E+tKLZcWCxZ1lx72+4BqAAS1vMUkxAd4kwbbtC1MkVAXL7WZJKo9
Aed+/zKHulTkF4tUSIFHdWNuqPf/sfTKV1iMbL0JIUmrKDQ8/GVrOJG+LyMQVfTr
9VKxYKzTWbS14kaUs8WaImCxUpOZ1EKWuJg2Qh5YavF5VEpJeWopVyjQhjDAzEBG
zZrG9tUl///YB3lcnfePb+9/atGx534AVjja3eXVwUjIbhCZz+g=
=i/qu
-----END PGP SIGNATURE-----

--2wa8M4YKVxkj4nM5--
