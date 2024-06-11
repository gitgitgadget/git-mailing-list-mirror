Received: from wfout3-smtp.messagingengine.com (wfout3-smtp.messagingengine.com [64.147.123.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21540179206
	for <git@vger.kernel.org>; Tue, 11 Jun 2024 09:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718097625; cv=none; b=QOdwbl9Brj1MNcZ/2Wz+IwhVeFCwNeRdYKs2TNyGgBYVgYmTI94csm9t805/rxLXQnPrXWIKbz7ZZuHPnrTrfWmkYKa57CCla+LedIgXltpmNvuW8mD/Nmk320oMToKxpxMvSddh8mLJ9WQ1iDR6cMcuiYQUyonwWAbFLFvOWBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718097625; c=relaxed/simple;
	bh=emjPHHTCmpqzEQMFvrZ/0lswrzhcmO+9nb4tRkgeJ9A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pFnRevbCcZJg4i5wzpv1RB5+rl5njoKPvL+esbNMgXzIiabuDQ0N6goR6plkUULFfAUbhOLwvO22L4Futb3a8HP78WWH9Eg4JCW4H/unhrPDrYT2BB3NuvqUerlaC0QHZUlR+3v/LTNq60NPTqAeTxPS7lAnQtPauL4VVVz5EGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=m6jbRk/7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=niEY1d5Z; arc=none smtp.client-ip=64.147.123.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="m6jbRk/7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="niEY1d5Z"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfout.west.internal (Postfix) with ESMTP id 77C861C000FA;
	Tue, 11 Jun 2024 05:20:23 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Tue, 11 Jun 2024 05:20:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1718097623; x=1718184023; bh=zacEX3zn17
	D0lN9zSv6phYGY1Z8gkZAZTqiOd3YURCE=; b=m6jbRk/7RVxz2dekZcMmCQu6rx
	KlKa9a0iqKpR1N8Gk6FiJ9moHAo+z55bMpSUccXvjUNi+oaA0s3cfyT4hkymIJyZ
	edynFweKMMAFNws/VBc+PRsHqiUvR8+Q/e8TNA/t+DxaAm0fjnWnVLHQ9A0ED3yk
	6RPSzzJqpaJQll8hpQqTF13ug6RH36Urv00upVWh4xB1exdE7aYeNPf5HWXgx1ZE
	09/2oirliPp4mke4zeCXmLgAl0PnOVGvalrHf3mZXw1iYDxO9gGKsmBW+sSUmxQN
	HfJcHcKvR26bZblewQvcrkRQYlzU0vtvHhoRo4Ybdfp+kdounTOv/7ct4gFA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1718097623; x=1718184023; bh=zacEX3zn17D0lN9zSv6phYGY1Z8g
	kZAZTqiOd3YURCE=; b=niEY1d5ZwySBYWakYLelIhXdkHvwTaupqLcSL3BFU0oY
	OAMW5WpcYpd1GgBUj7pIgsXYQBrOyRKqyAOQ7otKpXLUg6jGY4ROTxPvEIZuKYfd
	MOB2FZh7JxDXZzYch7OKZT6/gm+hkUbQalXQnEi7kuzwOcYh9esqN1JEpqzg3T7E
	5I1FWv4MRDVa7THuOZDBb2S5II+glkzC34g4C/mWUbO5+Np0t8qFZWtIsjWbtNM1
	osZMsRfXFfvkF3Ik7EvqDlOtkAQHILNZjXyUt1/LvcOw1nItNIJA3rveH5RtYkBl
	/lHDQ7HSH1g85vqlOQRQOgz3T6XyNCsr0tDASFOHXA==
X-ME-Sender: <xms:1hZoZhUNJ8bjEVu7bZbFMMEAbWy6bXkZHzwKTwIY4yGhFlOGx1rEoA>
    <xme:1hZoZhmMswEpRDe2AmH1VSdb2e6-iX0HzBt8nLo6Y-HLob8S9JH7_tdGxiOHhp1Z7
    svW7uidBdJvbWo9zw>
X-ME-Received: <xmr:1hZoZtZ0vdXvKslNYacsgHwtLzBDufhBUybuZOWAoXRPOyKR5XBLxgQInr4TQta9ZnU-D-e33EjLbh8g-DsVD8BbpYt3ctKBA1MPaOOhSSJHgeC771LJ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfeduvddgudegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:1hZoZkVvzsZDVJya8D0l54pwVAoLpRkuvInnpgAheBWRfk9WoERXXQ>
    <xmx:1hZoZrkivcNQ2GJKhO0VO7bHDfFU3i8VyffjoOWyeDPBpl-2wma4pg>
    <xmx:1hZoZhebLDbk075USqUIojWxbbkR6p2H7lVuKJ1JuuiqgMj2_RzQ1g>
    <xmx:1hZoZlFEJoKTufJU7Ga-aLUowbqu3XlbR_x12f1KL5JwR3v2WCtpJw>
    <xmx:1xZoZpisDkmYVrBAlwPLcFVhUzlbHuvLIZ3hsZuo8AXOWF1eZil6bcet>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 11 Jun 2024 05:20:21 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 93ae3acd (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 11 Jun 2024 09:20:13 +0000 (UTC)
Date: Tue, 11 Jun 2024 11:20:19 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Phillip Wood <phillip.wood123@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v2 14/29] builtin/log: fix leaking commit list in
 git-cherry(1)
Message-ID: <7cb4f7517865c5187bf0d1061a9f34776ad66290.1718095906.git.ps@pks.im>
References: <cover.1717402439.git.ps@pks.im>
 <cover.1718095906.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="rdPXavJru61Wq88C"
Content-Disposition: inline
In-Reply-To: <cover.1718095906.git.ps@pks.im>


--rdPXavJru61Wq88C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

We're storing the list of commits that git-cherry(1) is about to print
into a temporary list. This list is never getting free'd and thus leaks.
Fix this.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/log.c     | 6 +++---
 t/t3500-cherry.sh | 1 +
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index 37ecb3ff8b..b36fa9d155 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -2675,16 +2675,16 @@ int cmd_cherry(int argc, const char **argv, const c=
har *prefix)
 		commit_list_insert(commit, &list);
 	}
=20
-	while (list) {
+	for (struct commit_list *l =3D list; l; l =3D l->next) {
 		char sign =3D '+';
=20
-		commit =3D list->item;
+		commit =3D l->item;
 		if (has_commit_patch_id(commit, &ids))
 			sign =3D '-';
 		print_commit(sign, commit, verbose, abbrev, revs.diffopt.file);
-		list =3D list->next;
 	}
=20
+	free_commit_list(list);
 	free_patch_ids(&ids);
 	return 0;
 }
diff --git a/t/t3500-cherry.sh b/t/t3500-cherry.sh
index 78c3eac54b..61ca87512d 100755
--- a/t/t3500-cherry.sh
+++ b/t/t3500-cherry.sh
@@ -11,6 +11,7 @@ checks that git cherry only returns the second patch in t=
he local branch
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=3Dmain
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
=20
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
=20
 GIT_AUTHOR_EMAIL=3Dbogus_email_address
--=20
2.45.2.436.gcd77e87115.dirty


--rdPXavJru61Wq88C
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZoFtIACgkQVbJhu7ck
PpQWaQ//U4PgQ9OnRI5E3RMRZTa4VihHeXzXWcSz/r+yKEXerT9fOCX1dek1pf1k
t8adjCE7mGLRuNTKDhju8TQ4tEVCXndl18ydrKbkHHOHDlUREFL7YBpRttiOJS0c
6u2qkb2xyB6V/t1uNYd4aZgmRhYjV+AYELp+WAHRspvhk0VX9H00WxWr6VA/xP1e
bg9N5yumyvKfmp0U8gEXgBG+0+CP7TGZoQvcBRUNSCtLmBjWt1SHT+ykDN4tcTZZ
JJwZDVw6WnYTo5VK5xdC1IGmahDZgO8UXxZt2Z2z5ada+Cep6v9BW8E5Ke4/3UUS
eWmhilwsKzfM2jYFh1uKOpmqlWP5Q5erFUw4g6nzjeKfQDAMzD3HkzGKF95a/JXt
9AW52oXYnpn7n50ujpdCXNfN9zAyOnPWq1v3t959gkfS6EZyhn3qEFyNRFjnwq0r
BfvoonfzeakwxlWZuGA6MjgcgJcOa/KPB9GRZF+GSUOJeN0qDmdC1y8td9GTJb64
3lWhhi/AsOibgOB+P/jwsJkT7GJPYCPuhI9DASsfmfKw+A/rwodInbXJfL6G37bi
cnmdd2IzWg6IqiLKAzrtikLUVQFT1f/oVALLPSyHhhNHmlg6dfQai4C5MsuaNUET
e/AKjqF0O1lWfRkjMSy0IKWhqzjZlyev0M7ypn7mytbLEQMhOwc=
=sJF+
-----END PGP SIGNATURE-----

--rdPXavJru61Wq88C--
