Received: from wfout5-smtp.messagingengine.com (wfout5-smtp.messagingengine.com [64.147.123.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C8C07EF0D
	for <git@vger.kernel.org>; Fri, 19 Apr 2024 09:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713520281; cv=none; b=g7in81/HdZwPFlTc/Iki89E/v5A7kt2+gXGXTHP6WI5McmsWfxL7dH8KoTJXgRQC7LHjSghKIFlFbhLARYK+9ppLrYT0aHIlGo9xgtErhim1nYMgA+PFhE5CozI8mTy/qL8KzCbAbNDtCuOyyACZ42LUP+67iHDeDf/mCV+MozI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713520281; c=relaxed/simple;
	bh=d5A/LlYiZO7YIwy6qOv+3uRbQCrk+UPy0OYN2xJQaoc=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cJeWKKHNyjvereY7ixmQSI7/+MoJOg/KW8AaLDVPNT9OIyngtR2/ohcfnisUW42RTUhqcTid8uCLmcmTAtQNXZTZvsfB4QxQvFcQOf5gt2XF0X322VViSzZP+5ld90la88A+qBqLrvedsVPsFM0mJyG1405KGfJvbiPW3Jfa70E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=s+8U+aCT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Nry7p3Hg; arc=none smtp.client-ip=64.147.123.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="s+8U+aCT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Nry7p3Hg"
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfout.west.internal (Postfix) with ESMTP id 915F41C00154
	for <git@vger.kernel.org>; Fri, 19 Apr 2024 05:51:19 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Fri, 19 Apr 2024 05:51:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1713520279; x=1713606679; bh=YfMZr7reAX
	e4PX9Qnk3B4tf2yY1EDDtJt1qVwkFjH0o=; b=s+8U+aCTFuwEBfVOU0cfxhHbaq
	vu5+QVGfGFYstzD8ZPHEdhaVw5Eq+pJGlF/LvFDd9IbmQzwqJ7wiiBa7OYpx7huk
	oCCDW58mqCv9XklRKNIDykYN3nXNL0HPnuADp1dh/u9bF461AMlmysjToF83zGaZ
	41po+Zusm4v/3SdjduEo98SPxH0dOarqCp6pmZ9BDHzRP04cVzTaigJjwOngNmQd
	cUx0mzBqywikesPr4WT7rWIJWSsstu4SL46HVVzIW0xoV1iXMj5zEWdoHM/Ypyyu
	Z6D4kvpw10n4OKqvUzQDVoraVspaiiXe1df9yDG/T7fNtPU87KLnpwoZ9QKw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1713520279; x=1713606679; bh=YfMZr7reAXe4PX9Qnk3B4tf2yY1E
	DDtJt1qVwkFjH0o=; b=Nry7p3HgfRIYQ1Qxr1iE9puS53zeFYTeSb0YVM6Slt9o
	3xpJAlkAwpvI2Q9yxboC+VyY3g3xCFK1DBRmfOTmjiq54Foqyal0GJ1PAGHGQ9C9
	uEVuvpIIBxtFbX0PgAN3QvQtOjfmwSnTwDZ3aAeIToHe4o0zpEBVwE7jJiN5i07Z
	N6a5OEZOvs0c7IWueo4GBcgd+2iAyA6XWCm5U/x4DA7uMfIM+GwSrBz0V6DlGwU0
	nn//Bo+6dUEY5m4ffHN7I+FQxSiIpaNJdf606p75Qg3u2BjJVDvGaJz2tWOsz7nS
	R7MbKhOoun7FrsB9XqZkRUkw/XteCU5oKXqptLWjWg==
X-ME-Sender: <xms:lj4iZnd0ZYSzjw-uHOcQ9WjR-Ubv0_wcfQPnioMy4AiEO8dBFkApPA>
    <xme:lj4iZtOcf13BFZ_5xRijnHfda4WlnNMAt9KW-RTkjqirgp62mKrIRP9AYAFvWrDk4
    hZn2uhU97cVynVPxw>
X-ME-Received: <xmr:lj4iZgiwH_rMhn14NkCpVDhPlenr0eaLTmr84wQBiXr2fN_0wTYefAGKtsAiOFC-OIRxV69k9vSaUwpwPhDiW_k2hTgpYfpxHmlpLSYVqZjDWrGtaQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudekvddgvdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:lj4iZo-P6HPsp16BqGpnWXtRmIlSOIuqBnSuc7Y82fmUJJODmXZNrw>
    <xmx:lj4iZjteF-G-pa5vOfVcV8LRTT0TlMOXH8krk3KJhA5go13kx1bsCQ>
    <xmx:lj4iZnG95l4jeRWosAnBzGiSm6t4yKNh-nNJ6nSFlMJ2TnKB919P5w>
    <xmx:lj4iZqPAO8toR3QHqoJgeQEQkTL_QPblNAzmBOe1nTGmsOeQpi36Bg>
    <xmx:lz4iZsVdJg7NGwJ87AYi2gyCxQd5xD9pwiBSlzla5rtkYefpkdnmcWFP>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Fri, 19 Apr 2024 05:51:18 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id bb749787 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Fri, 19 Apr 2024 09:50:51 +0000 (UTC)
Date: Fri, 19 Apr 2024 11:51:15 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 02/11] parse-options-cb: only abbreviate hashes when hash
 algo is known
Message-ID: <5daaaed2b961841d539eb88e104db57ed95809f9.1713519789.git.ps@pks.im>
References: <cover.1713519789.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="j0s4hwHQngW5jdGJ"
Content-Disposition: inline
In-Reply-To: <cover.1713519789.git.ps@pks.im>


--j0s4hwHQngW5jdGJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The `OPT__ABBREV()` option can be used to add an option that abbreviates
object IDs. When given an length longer than `the_hash_algo->hexsz`,
then it will instead set the length to that maximum length.

It may not always be guaranteed that we have `the_hash_algo` initialized
properly as the hash algortihm can only be set up after we have set up
`the_repository`. In that case, the hash would always be truncated to
the hex length of SHA1, which may not be what the user desires.

In practice it's not a problem as all commands that use `OPT__ABBREV()`
also have `RUN_SETUP` set and thus cannot work without a repository.
Consequently, both `the_repository` and `the_hash_algo` would be
properly set up.

Regardless of that, harden the code to not truncate the length when we
didn't set up a repository.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 parse-options-cb.c       |  3 ++-
 t/t0040-parse-options.sh | 17 +++++++++++++++++
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/parse-options-cb.c b/parse-options-cb.c
index bdc7fae497..d99d688d3c 100644
--- a/parse-options-cb.c
+++ b/parse-options-cb.c
@@ -7,6 +7,7 @@
 #include "environment.h"
 #include "gettext.h"
 #include "object-name.h"
+#include "setup.h"
 #include "string-list.h"
 #include "strvec.h"
 #include "oid-array.h"
@@ -29,7 +30,7 @@ int parse_opt_abbrev_cb(const struct option *opt, const c=
har *arg, int unset)
 				     opt->long_name);
 		if (v && v < MINIMUM_ABBREV)
 			v =3D MINIMUM_ABBREV;
-		else if (v > the_hash_algo->hexsz)
+		else if (startup_info->have_repository && v > the_hash_algo->hexsz)
 			v =3D the_hash_algo->hexsz;
 	}
 	*(int *)(opt->value) =3D v;
diff --git a/t/t0040-parse-options.sh b/t/t0040-parse-options.sh
index 8bb2a8b453..45a773642f 100755
--- a/t/t0040-parse-options.sh
+++ b/t/t0040-parse-options.sh
@@ -176,6 +176,23 @@ test_expect_success 'long options' '
 	test_cmp expect output
 '
=20
+test_expect_success 'abbreviate to something longer than SHA1 length' '
+	cat >expect <<-EOF &&
+	boolean: 0
+	integer: 0
+	magnitude: 0
+	timestamp: 0
+	string: (not set)
+	abbrev: 100
+	verbose: -1
+	quiet: 0
+	dry run: no
+	file: (not set)
+	EOF
+	test-tool parse-options --abbrev=3D100 >output &&
+	test_cmp expect output
+'
+
 test_expect_success 'missing required value' '
 	cat >expect <<-\EOF &&
 	error: switch `s'\'' requires a value
--=20
2.44.GIT


--j0s4hwHQngW5jdGJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYiPpIACgkQVbJhu7ck
PpTw5w//eWuYo0wKGsjZ8L8p4uJR6LJSyt4IC2ETDScFoxd5HmTwBdAqTCJf1dlm
hN2kG2JmWEkOis9TI5PHfBwyHljDihl6dzCJ1XMVvAc05MVkGvRTVdPKVXC5rUnJ
18G1Icg6nowX51JS41uKfhDNXw8ZhCHuZoqffsVYTHwzQ8t50L2E12IgB5TjDWc3
fNmQ3ihRIHCkJrJQ8OrRSsCYS9oOA9XdwpBIyQJ2AzJpxYpNMoDMG+JVerCx0bgT
s1Otsg0IYrxpxCQwoPPN4OlM6UofyYApvt/OiYLVg49UxHFvMNwPFhH/prJLTkZd
IUIcm9E6EvhjfSiVdesBr8D8ExHO9JgWYqXhFJKfdKdi9EiGUmDk49wMy4jc1fdh
1gzRUVwxo4TsQ34YGPTM43dZ83FgF44cyNKhiueLCCi3kootZy9sokA3scEpvS8U
+P3Ux0JKtqVvmVitFT5GtJ/OQ+AAdcWKnNGR869No8p7CBtaXJjaOUGEQANx7UFU
aK+TV2naMfEFPHbUv1yF+gt+PLmzCtAzbrQ/RxHEPB7xwdIefzymfieyBFLM1Hvr
l19zCiL5Rc+g/BOAhXYIMhrkXVy6h4TN2MajHRUjGkCdANmFo6Gb1+UFG7rxGVW8
EmBpVl3PpdjyPpUQj8jcWV+ErO+gzxeryx+ghokVIb68eFelqi4=
=N3Hu
-----END PGP SIGNATURE-----

--j0s4hwHQngW5jdGJ--
