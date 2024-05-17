Received: from wfhigh1-smtp.messagingengine.com (wfhigh1-smtp.messagingengine.com [64.147.123.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AABDA2F853
	for <git@vger.kernel.org>; Fri, 17 May 2024 08:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715933971; cv=none; b=cZxrQqS/sb0EH5/T8pHBDjMgcNzdrUDrmRfiPzB8kCZbnHLxCI9Ake3VrZaNoTC9eOqHGEyJb+YCpymsQmGJfFCBS17HR+DydA4Z/F6khwFFEUFKaoHRQ+yVwkEiA1xKX4vyjMeOvzu5vGdPhvs9RLGWmMK9LU1rQB1QAYRCxpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715933971; c=relaxed/simple;
	bh=L5URsni2ZQTUt4m6WFC0tWzkh43nIZjczGFw6lrQrjo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B+LMxP1ibwB/W4gq+9tB5DWHz9MdzP41f1Jo9cPb8VCojMmqmQLBwX61ABNkis10FHN0YMJrwd2dhS42c+C63tFWM3OmTXMmqrSSS3n7y5Kwkl7xDf1waUQP5iUt0KvtfyOnDbuG0QWkPj8lE3dYq03j77LkZtZMKqPc2QIw5j4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Y4pVzWdO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=I0XJiEBf; arc=none smtp.client-ip=64.147.123.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Y4pVzWdO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="I0XJiEBf"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.west.internal (Postfix) with ESMTP id D351E180017A;
	Fri, 17 May 2024 04:19:28 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Fri, 17 May 2024 04:19:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1715933968; x=1716020368; bh=IAdzOo6+r3
	RZV2GnAlQ+hlyw7zawHgTgPk/F/+8jiQY=; b=Y4pVzWdO16452I9Az9ba3OcuYB
	cFc2N0Mil+PykhbI2fc1duPkAZPBnEJaOiYn9E3IBHOLmIBs312Y46Oa5ub6o7fx
	8tHuYPiY+HHKbXauues8KkAFdmPSJEdOqFsoWKKkx0uahdMV886j+KfmVmO5tyd0
	9uticuL5ow1PuiJT4WlrzJl0B/V//G5o3whNbGumhcUEafLeEh0mnvJUAjPEMwib
	c18iLpcI0ihK3O8zUPXo8WLhXJJpU4efwHbZfpQm6W3FcTZSf/DUqRtBKl4PSYkM
	RpKMOSyik5NEcW9guHX5OYbHCwXdr5qweL6TPrUWyNub6qS0O96v2z9RKlQQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715933968; x=1716020368; bh=IAdzOo6+r3RZV2GnAlQ+hlyw7zaw
	HgTgPk/F/+8jiQY=; b=I0XJiEBfjipK+WbPiVhdsRO20jgiurwC3BEKSLglA6hy
	GxaIwikOjh64y9NFjeN9LOXAvUyTOR3tVc7OWbNqbuDIT5uKDmONtWlg9KAXjYkA
	3J6FPk/WqN1+hILRlMbtLwttvGTydtcU7d0mX3I8+mIrixL4rtEQm7EobxIYK3dn
	CpvG85okURoJugzAKPf3HyDVyXtFPHCXvF4QdVv0VGP9bCOu9OWiu2ul6SFON+8y
	9ALfJU7TeQf7qxZlItvGp9LedA7T1VDkLzv7S4k9KaD4HpiTbZ07TFVJGq77VVBP
	6gGNnakzzBi0ZrfS0nrKQ5BQNWs+lIH6JErSW/Gmmw==
X-ME-Sender: <xms:EBNHZr6oKILNR5YEXJQfirCO_d3ZUcoRB4m0ysc2grC6rZuuQJhOuA>
    <xme:EBNHZg6pCI5eylkADy9_EMJh6p5fCn4joTAgYDCr2UBfeMAeG2ZIK8nBvLWIUFBVp
    aDHmFhl8gDO8LuN3g>
X-ME-Received: <xmr:EBNHZifn2jU9zf7UE01Ph93YlJFU6PHc4GB1lJcoy3UBO7xmCYxvjcCY-jJm6l0wGnih49dtXRmd9a8MelM3jlk95F1TzOExFgc0vveeqIoKGcuaYg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdehfedgheelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:EBNHZsLhuMhJ-XORMoEaLaBNP_ll7_G-1kvA3II9A3uPs8nrHKX2_A>
    <xmx:EBNHZvIvqCjATItWEeUG75mQ7mLuPP9qYuUKhACdx4fZtaQVK_Do_Q>
    <xmx:EBNHZlxyrvr-z790BqyUoeuhBbDBGp7EUJ2qb1spwq55l8hLidQp4w>
    <xmx:EBNHZrLqch7X50yAhtXB2gXvMz0zb1FMtncSIL7GxYU88WhoSQpecw>
    <xmx:EBNHZn1HeDo02xqb0y9o3T4atzkDXkxXX4hLG8gGisGgXswHalNBacU9>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 May 2024 04:19:27 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 1546f4ec (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 17 May 2024 08:19:00 +0000 (UTC)
Date: Fri, 17 May 2024 10:19:24 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 15/16] refs/files: remove references to `the_hash_algo`
Message-ID: <20c2bb4cbbb8eb1604c9a6a650b36cb05cd1dbf0.1715929858.git.ps@pks.im>
References: <cover.1715929858.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="4rxOC84lypW90+Mw"
Content-Disposition: inline
In-Reply-To: <cover.1715929858.git.ps@pks.im>


--4rxOC84lypW90+Mw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Remove references to `the_hash_algo` in favor of the hash algo specified
by the repository associated with the files ref store.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 refs/files-backend.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 235c8580d1..735a5acefe 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1822,7 +1822,7 @@ static int write_ref_to_lockfile(struct files_ref_sto=
re *refs,
 		}
 	}
 	fd =3D get_lock_file_fd(&lock->lk);
-	if (write_in_full(fd, oid_to_hex(oid), the_hash_algo->hexsz) < 0 ||
+	if (write_in_full(fd, oid_to_hex(oid), refs->base.repo->hash_algo->hexsz)=
 < 0 ||
 	    write_in_full(fd, &term, 1) < 0 ||
 	    fsync_component(FSYNC_COMPONENT_REFERENCE, get_lock_file_fd(&lock->lk=
)) < 0 ||
 	    close_ref_gently(lock) < 0) {
@@ -3223,7 +3223,7 @@ static int files_reflog_expire(struct ref_store *ref_=
store,
 			rollback_lock_file(&reflog_lock);
 		} else if (update &&
 			   (write_in_full(get_lock_file_fd(&lock->lk),
-				oid_to_hex(&cb.last_kept_oid), the_hash_algo->hexsz) < 0 ||
+				oid_to_hex(&cb.last_kept_oid), refs->base.repo->hash_algo->hexsz) < 0 =
||
 			    write_str_in_full(get_lock_file_fd(&lock->lk), "\n") < 0 ||
 			    close_ref_gently(lock) < 0)) {
 			status |=3D error("couldn't write %s",
--=20
2.45.1.190.g19fe900cfc.dirty


--4rxOC84lypW90+Mw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZHEwsACgkQVbJhu7ck
PpQ2vxAAoQyyRsekQWgpUcxmYsBmyOJcdT0nxlK3E060i4z3Y39KAE7rCxIk9MIL
iZrZaK/tR+fIQjbUPPHnLugiUsRKPXXudPH6L/TGAn9ohxMu7QwxSQKDPLL3j8wm
QQAIvbfD+gb+Q+4/wTm1A3wYA7uQosdlHlxyX6bYTv3JelIA8HDKY7RDG/Dfu4iS
JSja1WUA5kTWeGsGDAR12Yk1WyUS3eajDebseH0LVAKqzto8mEfD4kTwn7Ksrtju
Fmu6kwM3olW8DJaI08+enjev9X7aH4ga+9z92mDMqNLz0yBbbpcHu9ufJ+mmdZ7y
UrDBWs0AU+gUOrwx/6rUirJcQ2SEMIsI8xI/UL/UR3SwwRrQ5UctBw6pDkARXnvO
F7FyURoOLj757vkF7A7Pu+ZCU3OLN3+tpwmZF9MXghNDGwlCruEHY42DRV/bZWaL
xlC9SM6okv5HewwK8p4KNDS9G1hLLAAUJ+pZnWW5w+2G8fcUuaq2GmipYUYCT3hB
dOZZ1CbJYQsOpxOP0CMNVVHoGYm0BXlQeJZzNNrEQW+ex3ya1I3gTSFNQefyXUOA
rOLfgM/IO403A89ZGkXfK5cgXMnl8IVAECbZLebR8UwvbUDv2WCm5Jhd3pNHn08w
0hx4nSQEuWEpU3jRLs4N2UMTRGp+Jh3NpSXLKaVpo/1nToETZUk=
=0kDM
-----END PGP SIGNATURE-----

--4rxOC84lypW90+Mw--
