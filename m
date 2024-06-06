Received: from fhigh4-smtp.messagingengine.com (fhigh4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37EC72E639
	for <git@vger.kernel.org>; Thu,  6 Jun 2024 10:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717669722; cv=none; b=Ry4nkkxvQ1ofgysssMb9JKVfuMnoOt9ggvEspkWnQ3ezBQC99jtTpJyOeQwv/vgNPBhLqBMa2BGSRT7b96sTEyTs+U/tEtfjBqUn6bzzssiR5F2vK3myFPMcaaFcZ3Xtz37EOjZYtVbrk9UEhBxwfi6/xzfqHh20lUYDYx5+cWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717669722; c=relaxed/simple;
	bh=dIWuhOJoEbpjR+t9pV57+aXRLzNxEqcEdIIAoJvUmjI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qTmRTdA2B8qdxqajTSF2BEAijBRE13/n921Dc4fl43KEGp1SgVRP13Ra/iTksBYFDx0LktM3uaA3mTIUVaT18Zvw8bqCMPkClMzNlUE/kWQgLPNZCNCaTkwP+hI7TIqAIjuypmZ85xPtgpp/xtWHUzo+JXzaJ9nG1QOlb+Gqr2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ozR4Qz5S; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ar00DSz9; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ozR4Qz5S";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ar00DSz9"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 7DFD21140138;
	Thu,  6 Jun 2024 06:28:40 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Thu, 06 Jun 2024 06:28:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1717669720; x=1717756120; bh=bFKY0aD7YS
	KCJJrtQfAuOK14cdSQN9OsGc7X3UWXvWo=; b=ozR4Qz5Sk/gLhInSyEUBbjWXlJ
	FwlirAgUyyo5vYYDeD2sFlUvzWDNWF3/Bj408i+xPbeO1UzTMRfyd5XpeH8A3S/d
	Oe+IY0DJHc4zpCnLq8W8WJbRmHG3ZpIIODF6FlWtSjNWwDd6U7mgimRLtLVkEkiJ
	h29z9IwVXDyKxxqW45qf6Q0pD/h9ov2USjW63/G2CL3wbCh8yf9SxfjiYuxDDdi0
	YYAtT7g/Z1gdUIi6oVKo/e6wwwGoK5c4dqhzSEGNIuZ3bbgDSheHkn4fp5MuKTY9
	U2TdbRQEKb82eOny0MpvfGCWU2PfpQFT9MCM6s6DxkPZ0N+yhL2dLyFoUydQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717669720; x=1717756120; bh=bFKY0aD7YSKCJJrtQfAuOK14cdSQ
	N9OsGc7X3UWXvWo=; b=ar00DSz9ILZF1immmE87vgZWtaAdarJlnc83NHTjRfyQ
	dr9I70p4dD5PySGXWsF8GW1tSkjYr9HOpfHUumkj4lqIUXYAtmdsdb6/2z7o89AK
	yYQnWwsDhj+6qEfJRYiuHYANdgOqDJXnQFZo6tWkpXlnVGfHm+LP6MCZ3TRJwMj5
	n2KrFSC1KiHRqZKA4TixXa9XucFefnO8WOIgK+3ooOp7irwkpn0XM5ZQarinLnh4
	T896jTa0ZRvp8KE5GLmL9DUlFtcw88n6nWf/DjM/LCl010Jxeck3AxJbv3LKxAUz
	f93L0ii8zNE1+/jZ9tu6SxyL0G/S0Rinbtjj96PIgA==
X-ME-Sender: <xms:WI9hZkgjia299-mJe10FWrQGiB-fo1SdWh-ClhcoIRGhblH5N7tdKQ>
    <xme:WI9hZtDRbFc4DkR1tBc2mUG-NJzve-lnpok_ec_L1MoGYbpMi6o3-mOnVo_BQH3YU
    JyoJsenXZ6FYA5LiA>
X-ME-Received: <xmr:WI9hZsGN9sBi-_51ev9nxfchc08tdNWzjYi36KuIJfkUQ6D0AdNwtg2dQBdyq5h8mlO_hQ1YzuhuoyYLsSNWsl1A0_FbsYKHTkGcC3Hx0JzxGBvh>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdelkedgvdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:WI9hZlQtJf0DhRLjo15kX15K_ConTJNWOoLn9C6zMfi8i4Yjdy_aVw>
    <xmx:WI9hZhyJQQ0ud2zCsdDSPG3NkEzKarRzmtLOgugs4lTimuu2dpLz0Q>
    <xmx:WI9hZj4lzbQpbNvidIMFpSxs73sg8Ae-o7Zs_tjgtrxbB8cqh1tpiQ>
    <xmx:WI9hZuwglNZoEpANcKeg7tjqFsywD73MhXq-q16OMng7mlg68szA1A>
    <xmx:WI9hZjthmFS9Bzv02wx2KVQEqmpC-ZYsq4_h0dHXvBAFLJW4gSz-wtII>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Jun 2024 06:28:39 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id b035274c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 6 Jun 2024 10:28:09 +0000 (UTC)
Date: Thu, 6 Jun 2024 12:28:37 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v5 11/27] ident: add casts for fallback name and GECOS
Message-ID: <030dbd0288170eb1cc8fa0186f3b5e022ff67c40.1717667854.git.ps@pks.im>
References: <cover.1716983704.git.ps@pks.im>
 <cover.1717667854.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="e4vzA5/XGSbIKFYK"
Content-Disposition: inline
In-Reply-To: <cover.1717667854.git.ps@pks.im>


--e4vzA5/XGSbIKFYK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

In `xgetpwuid_self()`, we return a fallback identity when it was not
possible to look up the current identity. This fallback identity needs
to be internal and must never be written to by the calles as specified
by getpwuid(3P). As both the `pw_name` and `pw_gecos` fields are marked
as non-constant though, it will cause a warning to assign constant
strings to them once compiling with `-Wwrite-strings`.

Add explicit casts to avoid the warning.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 ident.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/ident.c b/ident.c
index cc7afdbf81..caf41fb2a9 100644
--- a/ident.c
+++ b/ident.c
@@ -46,9 +46,9 @@ static struct passwd *xgetpwuid_self(int *is_bogus)
 	pw =3D getpwuid(getuid());
 	if (!pw) {
 		static struct passwd fallback;
-		fallback.pw_name =3D "unknown";
+		fallback.pw_name =3D (char *) "unknown";
 #ifndef NO_GECOS_IN_PWENT
-		fallback.pw_gecos =3D "Unknown";
+		fallback.pw_gecos =3D (char *) "Unknown";
 #endif
 		pw =3D &fallback;
 		if (is_bogus)
--=20
2.45.2.409.g7b0defb391.dirty


--e4vzA5/XGSbIKFYK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZhj1QACgkQVbJhu7ck
PpTq4g//RUBZri7EZFH8yYbg/pwWyJfmEtN0TfEL/pN1xZQOXg1Ryis7+VC8eyrd
bRp2Kjj5g/vhQrm6DFp37lfCcwceO1ZFn9/CRbAzQxyyWKdWv4rMUVvrp0mqq3wp
VpRSah5dytSP1J1uGY5+FgrW34kvqmgVSljD6JC5j+1qCHiKiTkcbuIjkM+4lLhR
vtV+JoI9RBPms05zuo8ogqmr4ZZW1MWEnSkvVErzVYk/weg+G+13DLjYXGbfQl4E
g7ZGU7bDVH12QIpdAZSHe2SI9JCl4xRg2mZBvUbXiBAOtmzSIYF5MXnqIDHfzreV
+TuR+WjXTi5Or0Lf2TlU7YqGWds9kaJix4Iyr0m3tVrbuyZnQKQWQAMS8aZPyDqe
0a7xZABuL9qOFx6qSY5L/jBn3m6gxkeltaCK6Mn9NLDZ0sWzKj595lc06x5Jc+Mg
fRVDHQIH+KAaJipbSaXXSdEPJqqjQi+ou4mGn/E45lEka5avJL7rwH5cLKrRoqGg
aL6EVWIyLV6C5qKTVkkLhv+LnL9mQ3NYQySM71ORLFafeYCSpl+gr6h480dQJEyf
Cuu/eEv7HwhgJl6HgshYDw4e6CviU6eJOKVu9X4TjSDm6uOnhCSWzBbqprKjoOze
awQHtsFKXz3FM3UhYDJ55AXaDUcMs+ib7YE/ZUoeWNA6xM3mTEo=
=7MZe
-----END PGP SIGNATURE-----

--e4vzA5/XGSbIKFYK--
