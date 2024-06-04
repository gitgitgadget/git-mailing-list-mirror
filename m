Received: from fout1-smtp.messagingengine.com (fout1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 267F5146593
	for <git@vger.kernel.org>; Tue,  4 Jun 2024 12:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717504745; cv=none; b=ndeRCnEJFSpxE/+7Qkpxp2Ri5Zy3ytECQQda4TwnXg06XaNuiSybtSrZQM0FZjsVmVPIYXzSwIgIKk5zmu2bt/dGt/7lwqztdUWpVl73916N1lhrvbLERHZa3g2v7SZ40CCpUCnp5GknLq/URKLxwCa+yc06qfU6xEFK2vnVO6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717504745; c=relaxed/simple;
	bh=sCWBO2ue/3vbEUw5LkQl7LCNY5IBcGeireWQq1HYh1E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uEvUtiKMX3rZwXkjwbALN6faWT22xFtJLGk5++dKNRsvyfp5ThaWaSGHYIEtrpIKdIOET5TwawLrNNbkw09m57qMQn8jHwzOF7qJNVTNPrEmNTk/IX0eRMSQ3XIhP7ceNkMV6+LGGNHbGnYUNUPn4GnnEihmUd8+vYoKQTkmmlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=TSffYtCm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iRu/7fsr; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="TSffYtCm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iRu/7fsr"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfout.nyi.internal (Postfix) with ESMTP id 3A0951380157;
	Tue,  4 Jun 2024 08:39:03 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Tue, 04 Jun 2024 08:39:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1717504743; x=1717591143; bh=LT9E6raZ22
	5KgUyvcz7cv+bC00qi2afoGwkoBQwJg64=; b=TSffYtCmj9fq//T69GzQrmSmuh
	ZrPRxwbjMhxnOygw1uVY5eN1CAf7H7OLOSs1hnF0zpj8WCgwgievGvRzx0sB2ojN
	ug82Lbywkx1fTjK27O0kscbIAtDVTBe6Oi+M8gETwtI6DVDIsHUzV12H3sGtwC5j
	2JE0ikSjTpL1UH7g/igy9nun7+wdHKFQVrMDUs7IKt/aOi1xCWITvqHccAKkDs8o
	tJniCnQn8Jfctu83TMBwRc+aWVcfN9oWX+SjfyleVpoc4+JRhptdFFglRxwlAAEL
	GbfXSTffIE9YZxL/d770HKqoNegYIRE/BE8Dn8GSPu+9/RQdwCpb0NacZ3Cw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717504743; x=1717591143; bh=LT9E6raZ225KgUyvcz7cv+bC00qi
	2afoGwkoBQwJg64=; b=iRu/7fsru7sfnP4OVvI/eKAalqNC/UFd+cAYKQ2tPQAW
	KnU8CDdDgiwjZAKPOZduzj026d8pKONM2GPirqZHjW+Y6EHRLbCJW1DiTdCsCX2a
	pWe9rZ45Id+td4IHGuh3tKEFq0Su4wIsqKE+09htHfMr4lfBmbOiZkn7K1wiCj1w
	oHWearuFcClmJ0rgTY5q+PTxCxsZVefq+CWOF+envibwrt1RHUmgzCiyi5SeVF0p
	UTck3XtSn5rxCc2tR2/XgxJEltVI0x2hx+zqpg/FVF7XHRtsiolXS/3x0UVZkYiZ
	aYhOMTN7rdTQgLbpsSOhjc0c5tCTB1yGGGvAXqgH3g==
X-ME-Sender: <xms:5wpfZuAnnuRy1EEvJhk6ypvJBM8ieLNzqQ2bUVFCwlsUViXOFbbVZg>
    <xme:5wpfZohWoLn8DISkR7TbyLAaCVQ6lbMBA_AemhGGoCYUet8KeeUYLo79vGbUQ7PnY
    Lq1EU3P6fqKRpebpg>
X-ME-Received: <xmr:5wpfZhlgw8MoW2xYia5aAG8zEui9O6V3zpAr2dd20TD-G06yTW9NETSccf4vPAD_SteMVhGtsQm1WpDir5UA0O_fNamkP41_LReoOrZR1kwDj-nu>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdelgedghedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgepieenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:5wpfZszMdWwawnuHXpbBP1AFzJvqrqPtoKpyP1Agfw7UqzJh9wqAjA>
    <xmx:5wpfZjQ_e_RQyc3HInIumANBpry7P7Noc8SIVYogmbRP6I0NMUTlFw>
    <xmx:5wpfZnY9GbCofKBCupNisKbJQMK3r4XUwMfoTWlOW_OPjozBPqQf4Q>
    <xmx:5wpfZsTAXBfZzXff2PZDUFkqLkWX6L1PzhWrT2uK23NZT3uGBJ00pw>
    <xmx:5wpfZhMk9Iv82mA-XVTFf6-J5S14bs9n8IIWRbApLqkUIKSu_3YsoR4g>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 4 Jun 2024 08:39:01 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 9f57da7c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 4 Jun 2024 12:38:35 +0000 (UTC)
Date: Tue, 4 Jun 2024 14:38:59 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v4 26/27] builtin/merge: always store allocated strings in
 `pull_twohead`
Message-ID: <78ac075644c222d27ee3c5faec41c955037dbf12.1717504517.git.ps@pks.im>
References: <cover.1716983704.git.ps@pks.im>
 <cover.1717504517.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="sgknDvyXl/2AXvXL"
Content-Disposition: inline
In-Reply-To: <cover.1717504517.git.ps@pks.im>


--sgknDvyXl/2AXvXL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The `pull_twohead` configuration may sometimes contain an allocated
string, and sometimes it may contain a string constant. Refactor this to
instead always store an allocated string such that we can release its
resources without risk.

While at it, manage the lifetime of other config strings, as well. Note
that we explicitly don't free `cleanup_arg` here. This is because the
variable may be assigned a string constant via command line options.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/merge.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/builtin/merge.c b/builtin/merge.c
index daed2d4e1e..fb3eb15b89 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -611,17 +611,19 @@ static int git_merge_config(const char *k, const char=
 *v,
 		return 0;
 	}
=20
-	if (!strcmp(k, "merge.diffstat") || !strcmp(k, "merge.stat"))
+	if (!strcmp(k, "merge.diffstat") || !strcmp(k, "merge.stat")) {
 		show_diffstat =3D git_config_bool(k, v);
-	else if (!strcmp(k, "merge.verifysignatures"))
+	} else if (!strcmp(k, "merge.verifysignatures")) {
 		verify_signatures =3D git_config_bool(k, v);
-	else if (!strcmp(k, "pull.twohead"))
+	} else if (!strcmp(k, "pull.twohead")) {
+		FREE_AND_NULL(pull_twohead);
 		return git_config_string(&pull_twohead, k, v);
-	else if (!strcmp(k, "pull.octopus"))
+	} else if (!strcmp(k, "pull.octopus")) {
+		FREE_AND_NULL(pull_octopus);
 		return git_config_string(&pull_octopus, k, v);
-	else if (!strcmp(k, "commit.cleanup"))
+	} else if (!strcmp(k, "commit.cleanup")) {
 		return git_config_string(&cleanup_arg, k, v);
-	else if (!strcmp(k, "merge.ff")) {
+	} else if (!strcmp(k, "merge.ff")) {
 		int boolval =3D git_parse_maybe_bool(v);
 		if (0 <=3D boolval) {
 			fast_forward =3D boolval ? FF_ALLOW : FF_NO;
@@ -1294,7 +1296,7 @@ int cmd_merge(int argc, const char **argv, const char=
 *prefix)
 	if (!pull_twohead) {
 		char *default_strategy =3D getenv("GIT_TEST_MERGE_ALGORITHM");
 		if (default_strategy && !strcmp(default_strategy, "ort"))
-			pull_twohead =3D "ort";
+			pull_twohead =3D xstrdup("ort");
 	}
=20
 	init_diff_ui_defaults();
@@ -1793,6 +1795,8 @@ int cmd_merge(int argc, const char **argv, const char=
 *prefix)
 	}
 	strbuf_release(&buf);
 	free(branch_to_free);
+	free(pull_twohead);
+	free(pull_octopus);
 	discard_index(the_repository->index);
 	return ret;
 }
--=20
2.45.1.410.g58bac47f8e.dirty


--sgknDvyXl/2AXvXL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZfCuIACgkQVbJhu7ck
PpS9JA//aFtlklsi5vAy8MNdxwMh7cldZhFGr7lBnVeWNo3zT9A3yQotOcHKNSKf
gu9BhuS9XLyZ+Scx9IIckre0XsU4T5BLNWuyTmV7Jc5Q79gyux38wJtanmxoVYyS
FES4h1sYUoByNDb5cC1q6I3ahLROhOsQdRYhqUPTEsyvllFqIkzq9SbjDZzdfs+T
KfQ7CuRKlv4zfviBOb0uXOniejkcLo2/1HcgHEYTpzt5YAjSwwTpN8hiN0MhqVBG
sCjyUxcCW/XZth20d0xa7dlvxKC9ebnoSDWQxQ8fQ5Z0aiA3seEEbVebKbDWgf3f
R1Xjn6Pl9OE/LPm/7C80m+yKr+YrhIguLXaIxiqgz1CJvGdPvD3GmJ2Pb8JpkjLi
PIDwGFGy8wPQFiwb+UV2k4cFAytCjGT/1OHHiVHBzMjZJ+j6sIEkGDFmmkD75m+k
+B1RY5JF8tV1wkAaAHZZO3ewUOzjtJ0mICAu2zec5z/99cHdXAYv/Bhf6dE9jFud
AIUXsSytSIcsRqV20FX2nss7xxir0B9vT7gLXg3YyHpkJ+Y1UmYZqy51DTFegPQI
0a5KPE5VX7fSPwFZdSYZivX7wvw96TafmILA6WjfQtSKSITTMNnrqsuNJkNJtWP3
3FKj6/4fqRZLa/L0iDgTwIMASIUSTOWAz5YXLjGr3pCgz9XH5nM=
=rh6Q
-----END PGP SIGNATURE-----

--sgknDvyXl/2AXvXL--
