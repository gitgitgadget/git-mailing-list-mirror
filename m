Received: from wfout4-smtp.messagingengine.com (wfout4-smtp.messagingengine.com [64.147.123.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63C93126F32
	for <git@vger.kernel.org>; Mon,  3 Jun 2024 09:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717407017; cv=none; b=nQ1RZCA2otPwriCcJ4nULqYWudDlYlAA3UUup02M0W0Vk0uIOCEoXe3HRyX5A7Wp7/yNtXQ3PumfiXY48VVjC2pw0eD+jcjDGZepjawyZ2F537Kd/uaL8gL9t6OmRz98+oRQIKVatiRQ81ILZRiPYgwmhtCiQs7pDNE23rAmZs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717407017; c=relaxed/simple;
	bh=z8bVAMK/X0wydEABvtbP25Fn8N/F/By0ZyQybYLDHCw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bb20Gk9gJdCc640jyuorr36z9CoAVLrBLPe7emf1Uv9Gg8wKrcxYDJi7t1Q9RaLSeqTjY8rFHbeRM2Pv6XMNXwSLr4du0oBYjb/HvhCPrXtCv6pjZtlnN/0pVoZHY0tnZxBRIrz3FRNkfVIy3NlrPoXub9Ls+5TyFL7P8jYgT8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=S2GltjHa; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=B2tzxw55; arc=none smtp.client-ip=64.147.123.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="S2GltjHa";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="B2tzxw55"
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfout.west.internal (Postfix) with ESMTP id 58C7A1C000E6;
	Mon,  3 Jun 2024 05:30:15 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Mon, 03 Jun 2024 05:30:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1717407015; x=1717493415; bh=OJJwSDUE3x
	vGKOpfiqIyN8De1oYdBVuX66ZMkhd8zHk=; b=S2GltjHaSMSdxotqCVzLyKGSH4
	t5Xt8bXxxD3CBwe5W4v65NgWpuSvxNCoaQ5J5fwbQD+3CyloMjEgZKOJtUynRXgs
	SrkrXkvHjLXL21fAdQLmeOK5Y4ZZP7cx1bVi0ue9/TylTs7fnvRqBN/a6qIV4PVd
	4BSl6CVgTZw/rF8t+2F9vIfCG6m2itSklKEHaE0uS8wdQ2cnsswx/H0i9OaKEOc8
	/5VcamIWEUmIoa5STgZQqONLz9J7DChwe3Ja9E5ol2vRTBQ1MWO1aeTAMkdzt3Sc
	fDQ/E4fB/PMcNQ0cGB05ElmzjAlOklm5Ur4wRXnLkWa9Znim5s4u+b0le3eQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717407015; x=1717493415; bh=OJJwSDUE3xvGKOpfiqIyN8De1oYd
	BVuX66ZMkhd8zHk=; b=B2tzxw552i7hn1Vx3g33dv2A4c2XzAg6MbG19uUxpdlz
	BxmU8zw55n8vf6Htks+6hSTj5NHwPDCCyhxYgazX+Qn6X/sZcbqmllkThUTY6466
	bOg+SARjfbWUJrbjxKpV0qErzUrwN1sIpvVQmoqVOBL864JjgGxz5rqITsKlnNbj
	Xas9Ft6g9I2f434Ah9YypIcXDZiSTejL3Z307OZJ730EPGKHMuD2OwNBR2kN06cO
	ItlY1go/GqFmzDw24Y2wrLEcVbb6OwNjYF9NTDbM4YwLUqG6UN2u5UYFfT1zfvCY
	TEocY4SAN1Pd1gtQHuxWIsujuyG+j3wVqw1dwHDh3Q==
X-ME-Sender: <xms:Jo1dZj3Fk-SUk6qHM5ZbaaPENAOBC0Wz7DtbAwAXoBgPFkb0yb_CEg>
    <xme:Jo1dZiHlURhQtZGCQWprSAcbc5W8ajEWPfLzLJo-t0BM0Sy0pniTnONvu6_W_HbEI
    IHnth_ovqdf07TcrA>
X-ME-Received: <xmr:Jo1dZj6Nhr4gxfc5ZV36uqBEZMg9XFnvI2kZ00gfj81wnqOhHiU5OVwmaRox2TJcZ229yqZJOw2f6VlYJJRdroDvvQyv4EC6KHD5sf1FfLDjXvYx>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdelvddgudejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:Jo1dZo1DO0CKUorduYFXOwtnN7FgDk1u2LxFyEtfs-dJINRT-92cyQ>
    <xmx:Jo1dZmE1LGDdgdP0zhfVZur2ZCR-czTjzW6bH4l8Kqyx3S9baPlwTg>
    <xmx:Jo1dZp98Gn-w9jKAkD1SL6o2oxdsZQkAdOgjp2vN7f3sEzjq_jMNxA>
    <xmx:Jo1dZjl7byF_EyETpY4pD6Frkyye8C_yZJx0tdO7fw9EMgxVUlvGSw>
    <xmx:Jo1dZjPvqQqE_vKOAcv7OYqeKN0YN1oRGS59QkPNHH1wQ2c1NBgoHn9E>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Jun 2024 05:30:13 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id afa74192 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 3 Jun 2024 09:29:49 +0000 (UTC)
Date: Mon, 3 Jun 2024 11:30:11 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v4 01/12] setup: unset ref storage when reinitializing
 repository version
Message-ID: <afb705f6a080d93284919ae951d7b24d0a43cc08.1717402363.git.ps@pks.im>
References: <cover.1716451672.git.ps@pks.im>
 <cover.1717402363.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ghR/dVnupzDZCrW+"
Content-Disposition: inline
In-Reply-To: <cover.1717402363.git.ps@pks.im>


--ghR/dVnupzDZCrW+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

When reinitializing a repository's version we may end up unsetting the
hash algorithm when it matches the default hash algorithm. If we didn't
do that then the previously configured value might remain intact.

While the same issue exists for the ref storage extension, we don't do
this here. This has been fine for most of the part because it is not
supported to re-initialize a repository with a different ref storage
format anyway. We're about to introduce a new command to migrate ref
storages though, so this is about to become an issue there.

Prepare for this and unset the ref storage format when reinitializing a
repository with the "files" format.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 setup.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/setup.c b/setup.c
index 7975230ffb..8c84ec9d4b 100644
--- a/setup.c
+++ b/setup.c
@@ -2028,6 +2028,8 @@ void initialize_repository_version(int hash_algo,
 	if (ref_storage_format !=3D REF_STORAGE_FORMAT_FILES)
 		git_config_set("extensions.refstorage",
 			       ref_storage_format_to_name(ref_storage_format));
+	else if (reinit)
+		git_config_set_gently("extensions.refstorage", NULL);
 }
=20
 static int is_reinit(void)
--=20
2.45.1.410.g58bac47f8e.dirty


--ghR/dVnupzDZCrW+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZdjSIACgkQVbJhu7ck
PpT83Q/9G0VAINKp7BKQlYal7yMjEvsW6CY6+2EaPg7vJoYiO001xJFnYevG2Wym
RQWddYQVI8VD3y1oIbus7ovG5ukhHAEAaDv+Kik53FwSQDxOkGlUe7t9UtxrE5Ib
mVgyllR3ohgr1w7WwcoKC33k/WXPv/yZo1AsiNixFhmJMzhTRwCIJQ3MvvzO2KCR
rIpuTzA4vWYMGHtvKNIXM2eeJOXiGczTYZHw2AA+uWecJLuhcgtiHLKhyv20iMn+
Zzmvi8McgV02Syr7LgOmKp2pwCN1joxwcmk7i23VYl/2+xY7t4Gk+a6Cgn4gS6PE
JQotviqXnhUBhxHGxv5x9B5b7rnJKSVurP+/203MAytvsVqCMmM7TS87wDz/Fgkx
T2O9NrEry3Dq8IFaXAKRm+f+Q0+fMBgCUcYMS7niGwnRNkAd9tLHozufYNjHXovy
9G55qH0uCWnSqQb9D8lWka2680jfmHoTS8THvOSai0/GVLmgdivAAJ8iP2UIitHQ
0zPCdyHrWD8S8/9CJeu49i7e13rT5sUEVX1MEOn4bmNApdlOlOXnNJHHYPmV7zfq
K+vdEpWk3KSc8XUenHcijYBQASkv5OrI9swvPUUxdoimQ1kNXpu1iFE9VxoqOeB/
dZzEOPDFZNuQKGcrtBf5FtLnFruvJ7LQWmhseNyYzlFA7Xt3OuM=
=LmEO
-----END PGP SIGNATURE-----

--ghR/dVnupzDZCrW+--
