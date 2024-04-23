Received: from fout5-smtp.messagingengine.com (fout5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EE27208A8
	for <git@vger.kernel.org>; Tue, 23 Apr 2024 05:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713848883; cv=none; b=qBEyE3At/1psj6fKWMZHlkp5OM/vtYajPT+1aR4xph5wHbzq740I2dMJKqoPMfnlCiLnkgcUso6hae3/9COM2NVRZlrDC+//FZU2iLaOtbsrSKIMUHf4vP9AMuk/2Uqs8c7hYr5zRTBqQlBD7tHgl+9v6U4tH9S/Vjzd4bWFZQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713848883; c=relaxed/simple;
	bh=5lGQGYybA9/RznX/ZXkSG5k0aks2Qnv7d1hrYIOHQvE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=muOqB5qDR76SzRDLWudP83AqY1UO4i3Q//5Gl0vZeFBsD6WxB916Y6eQwGCDuDJmMz5wR+9bLgkSLOMBhKIGZSTYgG4NFXDtWmzMasjweQaJb9QEZ0XHOpGqQIDoG7O/OqwgMET5d+yKNioqnsozQiq09ijGYV39vSLfH4VknPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=mlToV19b; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Nq2UYXsD; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="mlToV19b";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Nq2UYXsD"
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfout.nyi.internal (Postfix) with ESMTP id 710E21380254;
	Tue, 23 Apr 2024 01:08:01 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Tue, 23 Apr 2024 01:08:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1713848881; x=1713935281; bh=xgP4stn3/D
	5OeFhn35AhHN/LOpQVSH3O+jgUKM8DEOs=; b=mlToV19bcDHRceQ+yuvOx3/vM0
	yL6ORUYxynKJ+WYIcTOpb4fE6AnQQ1iKwuBPY5dju4SmuNZ91tGvuxmPeX7HyqQN
	BDs4LsS6VGMLOs7uBErGzdUyWXOZkAn/vhzTzZOB25jIFH764whRrT0De4ne2/+l
	EZxPwFvrRID+3id8GsDxdHuSjX5oJzltPf5pYr8qRkEbCMSlWlRiNHEFvHUajl4R
	7AESz9JB4l2RE0pLuxlOW79uhxSwbLB16fn/czPVYVIe9K5pFZRnUKf8BpyXfshZ
	o1N4RQUxdOW30WEH4/5G71TpL41kwuo6lzBTM96LXer6eO95CW6IyzCvU07w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1713848881; x=1713935281; bh=xgP4stn3/D5OeFhn35AhHN/LOpQV
	SH3O+jgUKM8DEOs=; b=Nq2UYXsDGNzc4yVziIhl7Z3Wg1XxlFiAH7yRlrh+HRqF
	5IQD77G3/qOdV+Pu0S0+yVDGvc4G/JlQQXYUoguc/j+YnwOmcDwmufsdjA/Q/av0
	+/ZszJMHDuneFt4GzAgfextW3eQzvH7H/7YMgkOdCWbEDUSdFQyvV83vFl3nqk8W
	/2pytTVW4/HzQ1SRe7A8+Rrmtu7480wI5ZCc5omQ3F5l/dW96PzwKoZYl2Kerm4z
	PikMu0HlFU42B270SzGqutYNQgor4ZhqAfZfTGBRfQqDoRjAEmukOFYxIlj9Gkyh
	FYmwEzCVMIk7LYShwPxjgLkHVO96srfMrVlds12Djg==
X-ME-Sender: <xms:MUInZu92Y2Hjn1N54TGZSztby9NYyDRfFHngtObjjnSMi7od47675g>
    <xme:MUInZut5fgK-cjW8N8d-FBIhvygPbe426PzdkGz4_fKYSYv_rLZFfqc0XhCkiLL6X
    HqBDLHR2NJsirfXNA>
X-ME-Received: <xmr:MUInZkBjZ9c_nXSufbRaCIGuqxfHQpujPaSWM4KPSZQ0mXWT2aJvfo9PCpFBpEEXIWfkkWiIxIEGCM1KPj9_j1I-PLzKbnUAnYmyor1_2sghP0BO>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudeltddgleegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:MUInZmcuFN5MB063G6AHplQE0pGUv96NnvTb6zXcUDIpK_zMZIUgBQ>
    <xmx:MUInZjMQgAWO1OWpkrHzIOmpBdEpk54kSpBPTk6klh3bHi0OaHsQXw>
    <xmx:MUInZglU_w8tfYQpdVZDeQ0d0BdRcIiVWius6OTOZhuY7PIGs_S7IQ>
    <xmx:MUInZltvIO6Y062QB605keK8OCX-PPEkFoIJWq69uZ_skfXzD7IMIA>
    <xmx:MUInZopucMl4NssdArF2pGg9d2aoQ24conh4vTPpbtaEtX2FpCQzL8rC>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 23 Apr 2024 01:08:00 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 4c2dd633 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 23 Apr 2024 05:07:52 +0000 (UTC)
Date: Tue, 23 Apr 2024 07:07:57 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v2 07/12] builtin/rev-parse: allow shortening to more than 40
 hex characters
Message-ID: <ccfda3c2d2bafd9803ac26936f872b59d14ee1b9.1713848619.git.ps@pks.im>
References: <cover.1713519789.git.ps@pks.im>
 <cover.1713848619.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="vEhakksIBKbJLhdA"
Content-Disposition: inline
In-Reply-To: <cover.1713848619.git.ps@pks.im>


--vEhakksIBKbJLhdA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The `--short=3D` option for git-rev-parse(1) allows the user to specify
to how many characters object IDs should be shortened to. The option is
broken though for SHA256 repositories because we set the maximum allowed
hash size to `the_hash_algo->hexsz` before we have even set up the repo.
Consequently, `the_hash_algo` will always be SHA1 and thus we truncate
every hash after at most 40 characters.

Fix this by accessing `the_hash_algo` only after we have set up the
repo.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/rev-parse.c  | 5 ++---
 t/t1500-rev-parse.sh | 6 ++++++
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index 624182e507..d7b87c605e 100644
--- a/builtin/rev-parse.c
+++ b/builtin/rev-parse.c
@@ -687,7 +687,6 @@ int cmd_rev_parse(int argc, const char **argv, const ch=
ar *prefix)
 	const char *name =3D NULL;
 	struct object_context unused;
 	struct strbuf buf =3D STRBUF_INIT;
-	const int hexsz =3D the_hash_algo->hexsz;
 	int seen_end_of_options =3D 0;
 	enum format_type format =3D FORMAT_DEFAULT;
=20
@@ -863,8 +862,8 @@ int cmd_rev_parse(int argc, const char **argv, const ch=
ar *prefix)
 				abbrev =3D strtoul(arg, NULL, 10);
 				if (abbrev < MINIMUM_ABBREV)
 					abbrev =3D MINIMUM_ABBREV;
-				else if (hexsz <=3D abbrev)
-					abbrev =3D hexsz;
+				else if ((int)the_hash_algo->hexsz <=3D abbrev)
+					abbrev =3D the_hash_algo->hexsz;
 				continue;
 			}
 			if (!strcmp(arg, "--sq")) {
diff --git a/t/t1500-rev-parse.sh b/t/t1500-rev-parse.sh
index a669e592f1..30c31918fd 100755
--- a/t/t1500-rev-parse.sh
+++ b/t/t1500-rev-parse.sh
@@ -304,4 +304,10 @@ test_expect_success 'rev-parse --bisect includes bad, =
excludes good' '
 	test_cmp expect actual
 '
=20
+test_expect_success '--short=3D truncates to the actual hash length' '
+	git rev-parse HEAD >expect &&
+	git rev-parse --short=3D100 HEAD >actual &&
+	test_cmp expect actual
+'
+
 test_done
--=20
2.45.0-rc0


--vEhakksIBKbJLhdA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYnQiwACgkQVbJhu7ck
PpTSAQ//W+qrcahAAcQ04rchVf1UFLcSPv4332sAA1wnA9AEaGGYfTrLXwgHNiKS
bAPJvvc1EAZNThWCxrclonFZrhdHpUkSuMWe9hjq80fZriMC7nWLTaq7GM06/dQd
p0S8DjVGPWvXmGtZYFkXLHu6g5WEP69UepJVzWvpdRiySVbcUBd/Wbjr+v9dZVsi
7jv3hv+WZt18NnjwNb5qB+CV3t0gNdn1HWqfKXulUZoGkAjN/sq4YNGLXUgTUUgu
4KfYFg2jOpc4ifAZaGBIJ0WAqbvicEzgt9jZdzaypGvWPb7t9fbfl8Qao1rfPT3L
4/jVKHQ+5xffSMHt1WGD7v1IIGqsCkIl2vzrgbZ3xQW6k3uR6tDw9wkdgU6KLJvJ
5S6wNoffZD6ZemBFBHA08TbFlKvH3EJ+6RjHXOb2YUjmXTiX/qLnI8Vuy8k9pfhY
KRtSbG8+Qv12TBgkNo9yGKPf4Jx3+KB2qBxO9Zz6jK4FGlgD1+Z8gT5k/i0AocWg
lJjGo7V4ER5LTi6GcQh+UxwwpsvjvUGJoJsEKWCPSeQbWhLGgp9MMoFO1h17wn2F
Yi4HMTJx/s8sOsgdvu7VK6EfUAP3hEyFgP69zhdxugs/jCNZA7yzcHvFPc0OVY6x
m96H79MI4wGtZVBZEf5eR5qBlO/EFyyenWFFPxAAvwxZGnmW4Qw=
=ivu5
-----END PGP SIGNATURE-----

--vEhakksIBKbJLhdA--
