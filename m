Received: from wfhigh5-smtp.messagingengine.com (wfhigh5-smtp.messagingengine.com [64.147.123.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DC4D16FF2B
	for <git@vger.kernel.org>; Tue, 12 Mar 2024 04:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710218791; cv=none; b=aX8OVZwwS49BAVi1EtSFjKVwX7EnZFTWC/5iMRry6AUbbJGu2p301r6R3p0EbRV73kG1NGWIAnIff+NeYTisMgOcmCBP7jkMJtVIUaE0WKeyDN8VnmweoI9sv9ilIC54PWXVH2WtSY5h+84oqCypIjsPYaQ9XyMRfu/oyUX+QsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710218791; c=relaxed/simple;
	bh=Z+YMjc9r6m4AxD+Lkk7ZXws88AVBm9LOoaIa/cU9o2M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FvQ0k/K8ZHVRwIQv1Lg31eaOLvh2N7i4zpk2hBJIlxVPw7DfocWXJ93X9i1ekTiz4K50MK9+Qb2YNJ1fj0QMeAPxH3xFwjV5Rf3TfFeHyPZgS8htt+DYJ5ki8MzCDcCtz0PS6L9M3GcgF++4rKMvbL0+LkHrvV2Wb1tMzqwaeQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=tBj9oFEp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=chJxA6oP; arc=none smtp.client-ip=64.147.123.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="tBj9oFEp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="chJxA6oP"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.west.internal (Postfix) with ESMTP id 5823D1800089;
	Tue, 12 Mar 2024 00:46:26 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Tue, 12 Mar 2024 00:46:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1710218785; x=1710305185; bh=LQuiKPV28w
	9y7TxfFri9EcwhLCDPT72ukhC7jAeFf0E=; b=tBj9oFEpNRFFTbUXgMfDzoMttD
	kSsGu5wGHUb7uUHyzy33URC6SeEMQAFnPHWRdB7SmjyQdeP9ggMNuveZd5qhNtC+
	QEHiWjNVxdf03yehx/MNyYlxO1HVBrkgMepuU9+Js9sUto9drM5cg0dcJumX2xwE
	nL4y68Kscu8I3+FkCceCqxlslHm1i+dCBxlQKC0/7YEX5ZU+1TobXCsOB72DZMRg
	a6r7lMss+Bqbjhi5Xyv5XVlNFWQ1+E+Cksia5cvDCqC4JD8z5IFyRfo9BVvuOCqb
	/Wm9rlpZbAGzp8knSQvAGWyS+640a+1U+FyDVh+KweXqKB6vHwmqlE48TbAA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1710218785; x=1710305185; bh=LQuiKPV28w9y7TxfFri9EcwhLCDP
	T72ukhC7jAeFf0E=; b=chJxA6oPcJcvDFztQkAnbmknPcFs24+pF7503eAeGZ5b
	4ZplXwgwDZtbIn0DEn083a1y+Twalzr5oOgKKBeYl5bq5EXrWp62SLBNMui7U/VR
	78Hs2SQIabnZsmzfyrbZHXk4B5NMo3yU6QBXc0awCr26uhLHckpFmkUd87tswgkk
	1lNOvuJWrZFLA31T2xSYljOJHU78Tg/i3+QhD3UuyhY87HCvrqx6wI9VDUWQvKT8
	gcQmFp4cjtZ0nkyODhinXFLtecGMYIG8OpFTqmxfQ0VzgW8BbkUEJE34rnjrB3xa
	jprZY6BxAVIBZfCsXmYY3QU9nkgV4EdbNyQlleRkeg==
X-ME-Sender: <xms:Id7vZYlilg7GKjB41uwzvxpl-Za0Quhcev6VRaJMEv3LknI6Zwwu5A>
    <xme:Id7vZX0m0T77OOGZgbIRzj7Nk6FGgGSws385epWoxeaaCs8-kZ22yX3ZTQeTsFMEi
    M_b6ZAb-w74ff1Gvw>
X-ME-Received: <xmr:Id7vZWoJPoAWbIJ2FYBKeZdkuVGt2oe-xou_LTaJpcKqeMgTVs01TV6RJ4-0zG2boSgJbPEqTDmbJhA37WaYnPVxPoA5eNPMwrC9gmVRmlMkX73m>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrjedvgdejiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepjeelgeelfeefkeduhfeiffetleekteekud
    dvleevfeeltdfhvedtgfelgfelgfejnecuffhomhgrihhnpehpkhhsrdhimhdpmhgvrhhg
    vggurdhpshenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:Id7vZUmqejVbj8UBUb_TKTeGGAQzqWSBLwpyw3aKFeuNhyYry-C4MQ>
    <xmx:Id7vZW3bx39W3j2U-tw1KBwebp1MAGNf2IQRFhZPa_wICgkCHfqOBw>
    <xmx:Id7vZbv3nkYw-TnSDU7BVgz5t5j3sbiiwUcqwfJOV21v2DGoV6INMw>
    <xmx:Id7vZSUOQ-GB9FZXiw8C659rTco6GYRgZTkWSAvO8jM0dMlt2RLklw>
    <xmx:Id7vZbx5Cq_-uSgxAKVkSGVV3FutgPJQrYC5faaKHiy_sDbp75BLz0xJvE0>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 12 Mar 2024 00:46:24 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 2c10cd06 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 12 Mar 2024 04:41:42 +0000 (UTC)
Date: Tue, 12 Mar 2024 05:46:16 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (Mar 2024, #03; Mon, 11)
Message-ID: <Ze_eGIYeDY1YpptQ@tanuki>
References: <xmqqy1aol1lv.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="9Y8pD6t01rWhEDAh"
Content-Disposition: inline
In-Reply-To: <xmqqy1aol1lv.fsf@gitster.g>


--9Y8pD6t01rWhEDAh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 11, 2024 at 05:45:16PM -0700, Junio C Hamano wrote:
> * ps/reftable-block-search-fix (2024-03-07) 2 commits
>  - reftable/block: fix binary search over restart counter
>  - reftable/record: fix memory leak when decoding object records
>=20
>  The reftable code has its own custom binary search function whose
>  comparison callback has an unusual interface, which caused the
>  binary search to degenerate into a linear search, which has been
>  corrected.
>=20
>  Will merge to 'next'?
>  source: <cover.1709843663.git.ps@pks.im>

The binary search logic still isn't perfect, but the series already
fixes some issues. I'll send the follow-up fixes in a separate
patch series next week.

So yes, I think this can be merged.

> * ps/reftable-reflog-iteration-perf (2024-03-05) 8 commits
>  - refs/reftable: track last log record name via strbuf
>  - reftable/record: use scratch buffer when decoding records
>  - reftable/record: reuse message when decoding log records
>  - reftable/record: reuse refnames when decoding log records
>  - reftable/record: avoid copying author info
>  - reftable/record: convert old and new object IDs to arrays
>  - refs/reftable: reload correct stack when creating reflog iter
>  - Merge branch 'ps/reftable-iteration-perf-part2' into ps/reftable-reflo=
g-iteration-perf
>  (this branch uses ps/reftable-iteration-perf-part2.)
>=20
>  The code to iterate over reflogs in the reftable has been optimized
>  to reduce memory allocation and deallocation.
>=20
>  Reviewed-by: Josh Steadmon <steadmon@google.com>
>  cf. <Ze9eX-aaWoVaqsPP@google.com>
>=20
>  Will merge to 'next'?
>  source: <cover.1709640322.git.ps@pks.im>

Fine with me, too. Josh was asking for a test for the first patch, but
I don't really have an idea for how to write one.

> * ps/reftable-stack-tempfile (2024-03-07) 4 commits
>  - reftable/stack: register compacted tables as tempfiles
>  - reftable/stack: register lockfiles during compaction
>  - reftable/stack: register new tables as tempfiles
>  - lockfile: report when rollback fails
>=20
>  The code in reftable backend that creates new table files works
>  better with the tempfile framework to avoid leaving cruft after a
>  failure.
>=20
>  Will merge to 'next'?
>  source: <cover.1709816483.git.ps@pks.im>

This one should be good to go, as well.

Thanks!

Patrick

--9Y8pD6t01rWhEDAh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmXv3hcACgkQVbJhu7ck
PpSizRAAqyw/WpLMV6gnXbBR7z0RMHmoCOW0IRP/aSU3rr3dnrc6fZegFDvPmiym
kSMfo6oI6yuCmlckP87fgz0766TaL6/vQIFKLiIF6wYKvtBCix9RI15pQknXqHA5
t21fAxAiMPDSIoM1Uje4IDJ1Kygckin14RKpHqejrpkxa0B2AjtLc312rDAbYeDj
Be4GvsOtxehgYv+Qa0CeHrVQ0uxP0FoPR3yYP455Yae10kbt7RwYEy5hAbKnbVNS
IBg76mNvNVAlKIeTPuawIEnr3ATdHbjM9cI0G9y49G113h5E8wlrjQXznR34tZmJ
9PdplbAXeIqrzkNQr9zk2fmx28swy/Q8stct6jBted4w7kAW7BGyrwmUzXJT3vuX
mO5KLc7i6bIeVIthUi1yNiKiIVDIssYEujbL0msVAoHtNdGpYOnXPAmb+VhaQshc
+tKWVTQie9/P272iQaieTgYjFpmtnyi/bUB8tJm7iWqJ4ffUzNvHBGWpE9nr9/ix
fH0raJTM0BepIAahGMB1pBjqAvgMp4//W4CrZ5lx4DS4RNpbYjcfoxq7RaqpE16p
tN9D0WgzR602isktvfO0zz+EVDxeQU4LaAtZ1nAdPYAkYaQiNtzboHaBVj4i0vFL
6MH5OeR3abgO3CTdpYpC6g0rSfeCNlN6BvK+ntxZPCJCjXmplWY=
=ZH5v
-----END PGP SIGNATURE-----

--9Y8pD6t01rWhEDAh--
