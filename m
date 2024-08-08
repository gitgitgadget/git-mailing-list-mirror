Received: from fhigh4-smtp.messagingengine.com (fhigh4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC40818E749
	for <git@vger.kernel.org>; Thu,  8 Aug 2024 14:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723125985; cv=none; b=kp67V1QqXIboTlnmU3SaOVhnL9+0vSm41M8EIJgx/VkgRqNYsLSUDpVg9rvZtcpYLiyy8PB84218KmhIUh+UokEROhnDjzI31oiNdOR1NHteF5QjS+7MJMszKINSkxkvNrr17gAYEUXs6IAPrRj087WFtSqaa0mgs+ty5IgEw2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723125985; c=relaxed/simple;
	bh=llTkx/B4OIpnbso2sWqEJgYV9Su/yABh98HDbrbSRz8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uVpPcPBKh/IQUCJleKQqad18larWfPl+CZfFr9hdaFGjQ4NShI2jj922uyebFNfnyM+j+6v0aS4z0971K+Xzy/JsS00FlhKlP1Q66Pr6Syf7bHni/yUBncn8QFNm7B/thI6y2ionpVRhHCs0n92+lHVAE0NnS8MBc4ESqRyVeNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=HDvV7Vp4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=P8vI5xjB; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="HDvV7Vp4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="P8vI5xjB"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id C109511509C2;
	Thu,  8 Aug 2024 10:06:22 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Thu, 08 Aug 2024 10:06:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1723125982; x=1723212382; bh=4NjMY1h/RA
	ppN0/7zb27xhG049ctrstRQasmLNjxHpc=; b=HDvV7Vp4ZndKFU1i+Z/5UIDZ/m
	MQEhcu6+7M2Ytdkjoq14OgMpAx/tpIfv0Ht9LHXAxvNzSSJGEu0AACpqu3Owx8gR
	Bzt+DyNxCMGS1BGwQdz9AGFLTDFkzig9wRA5EbVPbxHuqUXQYH9nBFRg0qydQdDU
	cuS86vdo827W2puARYlshLXaG6B5CGTujU8bZWMatVYlF8hzOi1pboJyhnqBzKJU
	X9E9XXMuhSMYOYFEvNJbRHDnbMg+DO0XOr9fc79cxB9By6YQiBY4iMJ6THCWcI2S
	CwZxrUTynjYpmttjKA9swklt8wG9UeBDAJnrhvLyNmljqjc/mAH/0DvUNXcg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723125982; x=1723212382; bh=4NjMY1h/RAppN0/7zb27xhG049ct
	rstRQasmLNjxHpc=; b=P8vI5xjBTk4xJaXvztfST9nlLElPfN5KsrO7qQhEi1pj
	Ir+UwOtUxsfhRB+0VEUfet5aTptysmncVkZ2C7tIWFw68qXIRRYXIPo8YUojYJWz
	AieDUYTJpUgWI9Gz3AtSxkaSvSTKqytvK/jy6idVfn7BdnkEojEtgRy6fhRBJxEx
	mc7LT3UA6aoEZXI37qFHlzRMSajLSDzNX+JTnGLEmYSh0V6PRaDCLB3xcJKFsb04
	4gO34aGzDcL7uQJtmcz57biC74iUIUaZx+Z2udroM4q9FYxgk8KJoGdbxH2F5Sy7
	cr/DYieaAMby2NND5Y81i3zLS97NmXSjz4xoHBRq4g==
X-ME-Sender: <xms:3tC0Zs3QrMqsp5UApYP0ZQgDfNG5RVH7A2zrduUz6wAWcGuggRey2A>
    <xme:3tC0ZnExHxpb96PxwcS3RWyjKnA6Pz5KOVEdkTKSaxRS8-I9Qk-yH-3Br_SB10AH5
    IRkish6ZbBWAurpwA>
X-ME-Received: <xmr:3tC0Zk7rP6_mJdy_QAuqOA0ejZofOduI8S0wO1dD2r7SE-6wpo50tcnw13i0Z0VBg70NCSF4JZvHnaE3r2sOosyWTQcFpxMGHkU94NzS_wdsO9Tg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrledvgdejvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecu
    hfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqe
    enucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeeh
    gfeltddtheejleffteenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpd
    hrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehgihht
    sehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhlthhosghlvghrsehgmh
    grihhlrdgtohhm
X-ME-Proxy: <xmx:3tC0Zl2wauDcOv81VkIdQcx_GNxRemnvXVMf03BMbTNKyIakSARKfw>
    <xmx:3tC0ZvFp4N_ewLpnOviE4ns_p0MQCTu68WuC3u8Ns08u0gg2QpAODQ>
    <xmx:3tC0Zu89zhofUvxF_m9cztA6rWyG4vGwcvT0HYTSY6uLApGTM2X4mQ>
    <xmx:3tC0ZkmqZoIDMnan5GSPErIuISA8RAXOBVPCATJExNur1qnbBa0I2g>
    <xmx:3tC0ZjjZfdt5HkpisheqcKVyzaE-msC3I0Jp6onlPfgIUVI4n8gqQcmR>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 8 Aug 2024 10:06:21 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id e974f05c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 8 Aug 2024 14:06:14 +0000 (UTC)
Date: Thu, 8 Aug 2024 16:06:19 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>,
	Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v3 1/9] reftable/stack: refactor function to gather table
 sizes
Message-ID: <6d2b54ba8e448eaa2584976e1fe73c798842833f.1723123606.git.ps@pks.im>
References: <cover.1722435214.git.ps@pks.im>
 <cover.1723123606.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="v9UP2GR3gqF6hEiU"
Content-Disposition: inline
In-Reply-To: <cover.1723123606.git.ps@pks.im>


--v9UP2GR3gqF6hEiU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Refactor the function that gathers table sizes to be more idiomatic. For
one, use `REFTABLE_CALLOC_ARRAY()` instead of `reftable_calloc()`.
Second, avoid using an integer to iterate through the tables in the
reftable stack given that `stack_len` itself is using a `size_t`.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/stack.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/reftable/stack.c b/reftable/stack.c
index 737591125e..ba8234b486 100644
--- a/reftable/stack.c
+++ b/reftable/stack.c
@@ -1305,14 +1305,15 @@ struct segment suggest_compaction_segment(uint64_t =
*sizes, size_t n,
=20
 static uint64_t *stack_table_sizes_for_compaction(struct reftable_stack *s=
t)
 {
-	uint64_t *sizes =3D
-		reftable_calloc(st->merged->stack_len, sizeof(*sizes));
 	int version =3D (st->opts.hash_id =3D=3D GIT_SHA1_FORMAT_ID) ? 1 : 2;
 	int overhead =3D header_size(version) - 1;
-	int i =3D 0;
-	for (i =3D 0; i < st->merged->stack_len; i++) {
+	uint64_t *sizes;
+
+	REFTABLE_CALLOC_ARRAY(sizes, st->merged->stack_len);
+
+	for (size_t i =3D 0; i < st->merged->stack_len; i++)
 		sizes[i] =3D st->readers[i]->size - overhead;
-	}
+
 	return sizes;
 }
=20
--=20
2.46.0.46.g406f326d27.dirty


--v9UP2GR3gqF6hEiU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAma00NoACgkQVbJhu7ck
PpT4Aw//WWJxlKhHtq6XUntZaCzQ+DTglDt2aHqQxYrhA5U218o3u0iWLD5949GL
1pWYICXBckcwcNfwkH23ecjxwde+iBsyZcurXLPBJl91nqqWwbBYJvHKg9Vy2e7w
K7XbTTM7y6S8aNzGRh9RykUM+teGWEmBSUMUIf/a9k6NaZjvbrKPfLrOpbxmk5Ut
IM6StitxQnw5XwUFaYSKnbpmz+O+mC61Na7kR3lvURGjgvpRgri6ZjE9DbmJKsR6
USZm55Sm1TQt+3I+FaKpRlW+T7+aV9J6hlr2knHg8iE5Y3+lMIBgzKaqSY+XmN3M
LZsTu749wovIRVTsEgX1435FrTfs7MJIHUpGDp/WyUjfSkasbxPdnp5IJ9y8OaFR
+B94LL2rUXdvmYd1Whpz4hD+X3qd0/zfiMPBNGfAKRWfRMQQ0HMWS8ShFUS6MDvE
NEScL7xCh2VxSVU9P7kpMUHOqHDVCm6QzGOeKkZgvdX3KkOzo7Rq3DSKv+AfznJ4
Ko/Kq+9WLH3VdRoS2Nd5spbxDvzMkJGGk4VWmD243Qd87nNWqBFe7xYcSdXx8jVt
qMyvWng4Pp/Q8WU9Onid7+GqN5lAeDUnY5GPiHBSyZM7sLckZkpStKe6/704Xdqe
4rZWgXBbti0B/6z8bRLU/RBsPU1A9vtQN2ns/KB50ELPvxE/R9k=
=Jp2d
-----END PGP SIGNATURE-----

--v9UP2GR3gqF6hEiU--
