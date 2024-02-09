Received: from wfout1-smtp.messagingengine.com (wfout1-smtp.messagingengine.com [64.147.123.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4D5B65BA7
	for <git@vger.kernel.org>; Fri,  9 Feb 2024 07:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707463408; cv=none; b=gVbLLCLSvhcyc14aN6wq4H9yzQ+HaeMWu65OVJlBDvcsdBkw41Sjdjw3PSZgqZ1CcIDD+BxAPLlHs6dQN9q2FfGvOONXaUjLQuMPF4JYnCki2EE39bR3fiFXlITGMVgnfAA6bvLEnozQdvV+6W5l6s63KvauuGOVqFhD2omdGX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707463408; c=relaxed/simple;
	bh=gq2DETqOF6jaFMmYfh4Wsss+vevXJ+8yVB5yOAEAgnA=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=US5e/yrVpJwSgO5U6WLz3n25g1ACM70R+WK5m9ozJyXJfb1wHaUfQs5+rt9PylugV7gZVUBo/rVaGD+IrJOET5ff4KdQYwwuYdBwBv+b4R2U0rMEUDReI1Jxw+vJ0TYtdR4C3dQuCjmR+e60XYkCK3g4LfM5ELh7Tx7OJYToA/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Fr7ZL9M7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HIPguQFx; arc=none smtp.client-ip=64.147.123.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Fr7ZL9M7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HIPguQFx"
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfout.west.internal (Postfix) with ESMTP id DE9251C00091
	for <git@vger.kernel.org>; Fri,  9 Feb 2024 02:23:25 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Fri, 09 Feb 2024 02:23:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1707463405; x=1707549805; bh=D9M55pJmpT
	yqrzRR1sFbbfV4E2MrrqVwsFUjFYQ+qgE=; b=Fr7ZL9M72hjZShqLcPxXiMYLY0
	ftSrKXAkfMCFaEg9X+ZuVrHUuFzuFLSCQbwEL27b2OGeNZqtFvY4fNs8e8IDmiw/
	baFBC7PF24+Pk74QQNwNP7myFhKqdSiBRcOJPA2vP1ddJv6U2fS8mrrEnAHIRpa5
	sWagtbI42mbHwn5j2vV3bM0Q1wOojQ/9/KIt3KXlpdyYEhwu2P92PDIW1+OGUQ87
	OHbhaqEq1A2pacEUtdLVSDl6M1eBd52OiEc3K/VvEp/aMgPClLt2NH7w30sDRQrq
	y9FIBk3yt8gAKrLEecFzn09Fi0/CAOaAytTWn3l+CHc8ux0uU59lpIOQgQ6w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1707463405; x=1707549805; bh=D9M55pJmpTyqrzRR1sFbbfV4E2Mr
	rqVwsFUjFYQ+qgE=; b=HIPguQFxSBT2tH9Bfz46rfQVNwf26mHgMS+fYm6L7KTb
	xc0hh0ItemqRfCIvF8wcZ1lz03bsYaJ/nr7Lq4YQN5D7iEC6LnjgpCf+F6/SuIER
	SNgnkLD3CNxGk1qAjNXxyCwa1q4tgGAMCEL/+BEE9BsIxEZ1KQm2CeZZdGl4bjjD
	7v6ruPuP9gEyyl8T1rQqtjkRyZySxCKDcVYqQ9jad4xLwZ7A0Xz/A9dq6IhtMAIo
	Vl3KSDQmIwJfAD/J+6ezyB7RudRWYIZsNiw+nOWBoN3qGsd+PZ4UobfdoSlprqcA
	aOR3K5rqaBQo2mXeD/PiZbg4rcV4srki+9odmV0SEA==
X-ME-Sender: <xms:7dLFZRVb5c2VKjSIc-vgs2le2vxtcUYYVC7moFGLAeRok7mTDzxmNw>
    <xme:7dLFZRnCzi_G1va9-pO0pv18SWUBPhm59V5pieuCcf-e6SQQDsWUSJ5BSxtk3fc9m
    cu0SJgcZ0wo_OtLzQ>
X-ME-Received: <xmr:7dLFZdZy17EhZUVV05lOuZ7ZkrRqiA3Y_2XbqdeliPUpM3-k_Rp41O17Co6Y5fRDuyWYyMh3Nb4lQwBtFDgj4Ymz7RA4eOzm4VpAD_HLCaq4MS0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrtdehgddutdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecuvehluhhsthgvrhfuihiivgepvdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:7dLFZUWVEwCr1WBl3kz2VtbtlinsseRBEs3dztfw-ssGs2nbDiNmkQ>
    <xmx:7dLFZblQUk7h8I0J4hjJGWwkqWJAh_HfUSsaPk9jTpcytW9GtZ7THg>
    <xmx:7dLFZRcxBad0RXXQnqq_jJenYsRLuyozWtl42x6kj9U3wi0PfGlOqg>
    <xmx:7dLFZTskjLVAMKaaBSQ5Mtzc8FKm_DQDu_gg3J1M9d0YBwXGd7lM8u17etM>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Fri, 9 Feb 2024 02:23:24 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id d19cf47d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Fri, 9 Feb 2024 07:19:48 +0000 (UTC)
Date: Fri, 9 Feb 2024 08:23:22 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 4/7] t1404: make D/F conflict tests compatible with reftable
 backend
Message-ID: <70c6f980126aabb2ade336861e816cf1fe6e9110.1707463221.git.ps@pks.im>
References: <cover.1707463221.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="xwORT3AxbzUM7lXm"
Content-Disposition: inline
In-Reply-To: <cover.1707463221.git.ps@pks.im>


--xwORT3AxbzUM7lXm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Some of the tests in t1404 exercise whether Git correctly aborts
transactions when there is a directory/file conflict with ref names.
While these tests are all marked to require the "files" backend, they do
in fact apply to the "reftable" backend as well.

This may not make much sense on the surface: D/F conflicts only exist
because the "files" backend uses the filesystem to store loose refs, and
thus the restriction theoretically shouldn't apply to the "reftable"
backend. But for now, the "reftable" backend artificially restricts the
creation of such conflicting refs so that it is a drop-in replacement
for the "files" backend. This also ensures that the "reftable" backend
can easily be used on the server side without causing issues for clients
which only know to use the "files" backend.

The only difference between the "files" and "reftable" backends is a
slightly different error message. Adapt the tests to accomodate for this
difference and remove the REFFILES prerequisite so that we start testing
with both backends.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/t1404-update-ref-errors.sh | 37 +++++++++++++++++-------------------
 1 file changed, 17 insertions(+), 20 deletions(-)

diff --git a/t/t1404-update-ref-errors.sh b/t/t1404-update-ref-errors.sh
index 00b7013705..98e9158bd2 100755
--- a/t/t1404-update-ref-errors.sh
+++ b/t/t1404-update-ref-errors.sh
@@ -92,9 +92,6 @@ df_test() {
 	else
 		delname=3D"$delref"
 	fi &&
-	cat >expected-err <<-EOF &&
-	fatal: cannot lock ref $SQ$addname$SQ: $SQ$delref$SQ exists; cannot creat=
e $SQ$addref$SQ
-	EOF
 	$pack &&
 	if $add_del
 	then
@@ -103,7 +100,7 @@ df_test() {
 		printf "%s\n" "delete $delname" "create $addname $D"
 	fi >commands &&
 	test_must_fail git update-ref --stdin <commands 2>output.err &&
-	test_cmp expected-err output.err &&
+	grep "fatal:\( cannot lock ref $SQ$addname$SQ:\)\? $SQ$delref$SQ exists; =
cannot create $SQ$addref$SQ" output.err &&
 	printf "%s\n" "$C $delref" >expected-refs &&
 	git for-each-ref --format=3D"%(objectname) %(refname)" $prefix/r >actual-=
refs &&
 	test_cmp expected-refs actual-refs
@@ -191,69 +188,69 @@ test_expect_success 'one new ref is a simple prefix o=
f another' '
=20
 '
=20
-test_expect_success REFFILES 'D/F conflict prevents add long + delete shor=
t' '
+test_expect_success 'D/F conflict prevents add long + delete short' '
 	df_test refs/df-al-ds --add-del foo/bar foo
 '
=20
-test_expect_success REFFILES 'D/F conflict prevents add short + delete lon=
g' '
+test_expect_success 'D/F conflict prevents add short + delete long' '
 	df_test refs/df-as-dl --add-del foo foo/bar
 '
=20
-test_expect_success REFFILES 'D/F conflict prevents delete long + add shor=
t' '
+test_expect_success 'D/F conflict prevents delete long + add short' '
 	df_test refs/df-dl-as --del-add foo/bar foo
 '
=20
-test_expect_success REFFILES 'D/F conflict prevents delete short + add lon=
g' '
+test_expect_success 'D/F conflict prevents delete short + add long' '
 	df_test refs/df-ds-al --del-add foo foo/bar
 '
=20
-test_expect_success REFFILES 'D/F conflict prevents add long + delete shor=
t packed' '
+test_expect_success 'D/F conflict prevents add long + delete short packed'=
 '
 	df_test refs/df-al-dsp --pack --add-del foo/bar foo
 '
=20
-test_expect_success REFFILES 'D/F conflict prevents add short + delete lon=
g packed' '
+test_expect_success 'D/F conflict prevents add short + delete long packed'=
 '
 	df_test refs/df-as-dlp --pack --add-del foo foo/bar
 '
=20
-test_expect_success REFFILES 'D/F conflict prevents delete long packed + a=
dd short' '
+test_expect_success 'D/F conflict prevents delete long packed + add short'=
 '
 	df_test refs/df-dlp-as --pack --del-add foo/bar foo
 '
=20
-test_expect_success REFFILES 'D/F conflict prevents delete short packed + =
add long' '
+test_expect_success 'D/F conflict prevents delete short packed + add long'=
 '
 	df_test refs/df-dsp-al --pack --del-add foo foo/bar
 '
=20
 # Try some combinations involving symbolic refs...
=20
-test_expect_success REFFILES 'D/F conflict prevents indirect add long + de=
lete short' '
+test_expect_success 'D/F conflict prevents indirect add long + delete shor=
t' '
 	df_test refs/df-ial-ds --sym-add --add-del foo/bar foo
 '
=20
-test_expect_success REFFILES 'D/F conflict prevents indirect add long + in=
direct delete short' '
+test_expect_success 'D/F conflict prevents indirect add long + indirect de=
lete short' '
 	df_test refs/df-ial-ids --sym-add --sym-del --add-del foo/bar foo
 '
=20
-test_expect_success REFFILES 'D/F conflict prevents indirect add short + i=
ndirect delete long' '
+test_expect_success 'D/F conflict prevents indirect add short + indirect d=
elete long' '
 	df_test refs/df-ias-idl --sym-add --sym-del --add-del foo foo/bar
 '
=20
-test_expect_success REFFILES 'D/F conflict prevents indirect delete long +=
 indirect add short' '
+test_expect_success 'D/F conflict prevents indirect delete long + indirect=
 add short' '
 	df_test refs/df-idl-ias --sym-add --sym-del --del-add foo/bar foo
 '
=20
-test_expect_success REFFILES 'D/F conflict prevents indirect add long + de=
lete short packed' '
+test_expect_success 'D/F conflict prevents indirect add long + delete shor=
t packed' '
 	df_test refs/df-ial-dsp --sym-add --pack --add-del foo/bar foo
 '
=20
-test_expect_success REFFILES 'D/F conflict prevents indirect add long + in=
direct delete short packed' '
+test_expect_success 'D/F conflict prevents indirect add long + indirect de=
lete short packed' '
 	df_test refs/df-ial-idsp --sym-add --sym-del --pack --add-del foo/bar foo
 '
=20
-test_expect_success REFFILES 'D/F conflict prevents add long + indirect de=
lete short packed' '
+test_expect_success 'D/F conflict prevents add long + indirect delete shor=
t packed' '
 	df_test refs/df-al-idsp --sym-del --pack --add-del foo/bar foo
 '
=20
-test_expect_success REFFILES 'D/F conflict prevents indirect delete long p=
acked + indirect add short' '
+test_expect_success 'D/F conflict prevents indirect delete long packed + i=
ndirect add short' '
 	df_test refs/df-idlp-ias --sym-add --sym-del --pack --del-add foo/bar foo
 '
=20
--=20
2.43.GIT


--xwORT3AxbzUM7lXm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmXF0ukACgkQVbJhu7ck
PpSHkA//dT4jR5Q0ZdSjA+uJDZYbyaO+rc2GKVR4fnz48dvQQguLMzAHrZiQib/K
7KkBQKAHU4K4RIAi0zeXaucioXCZeg8Nq5O0G6NooWnCy4rUreH8NRp7JOuoYFJy
y7lxUfNikHLKy4tFkJOPlpmPWGq2XHxTQMg7ZcyEhwF8e6scU75ton/e2g2suABH
FdoCubCbBbB4frqAZ9iw/UuIVbuE3rwSgV2iJacN/VxOSPztyW2haU87Latv5Xgt
J9sevZqmju2hMeNGnf5eF3excrJ695dDtH5nDTMmxYh9I/ijh85SzS+JxL4HDup9
bj7ZGyMDgbDFmNUJOGZCPBDHcfq7NU6TVZHcoKotX/0nmeEszdn6L2FWzXGHCiWX
3Ar5rbhAZjVHshUz+KMYIectXOUBPHnOHT/NQ7+iuMKIQHDfUmCkUPCGutrRm0RU
l3GO3fkt27xBV2ESZpN/Npp7q09oZr4FGO0KUIA1odeOPFq65Q7SSd2o/m/UPziN
ZNn6ptyGb8eR73sAWH7r8hrpqxXJCqhvntfZXseZhuNwx6quuvfsnUsnyiCtA/Vi
qR43c6eHMWGSVkKV9jorKO1pJAHf9QU+a5QScOUb9S3buzPzkbfmffrtYrkUKysN
3nwSd1/JNymBFEFtR9vSojMIIsLaeZFSBlTtypiE/IJMuykebd4=
=EESI
-----END PGP SIGNATURE-----

--xwORT3AxbzUM7lXm--
