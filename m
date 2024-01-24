Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E575F17BA7
	for <git@vger.kernel.org>; Wed, 24 Jan 2024 08:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706085920; cv=none; b=mSCPsUAj3+oniGjLO4JrGkTGX4uHKcIsdxZUikh6ByTUvg5AuulEzdWKYdWHHaxaqST6ONSNUs4Pu0EkeUFz0xbh9jDorU0EtIbbaQn6HfG3YfTdKWe8Ccu6B7Bo7i3+9C0moASc9Lknvz3fsVKBgl9HQAF1YPPoXPzRcW0sP4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706085920; c=relaxed/simple;
	bh=sVk6RHTOHgVv7eXOkfQdo+dM5q9krh+FP1KMYcsopzQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jdGkgwaQWCAn+2zR11Yq65vcvHKDaML44BcZEjvQCBg1bIbBpoabfECyiVRu9hnKbMDrOytBOr0vriUFohJ9jAEMKNNYLGGQj7zc/0a+vDPuIetoNhP/diDkMJ6eU5WUEPKAkFlGnhqxN4M2poiRk+iNbYS+eoDxqD+gnlbA0iU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=SUwdcNzg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Sg25j+ef; arc=none smtp.client-ip=64.147.123.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="SUwdcNzg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Sg25j+ef"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.west.internal (Postfix) with ESMTP id B3AC53200AEB;
	Wed, 24 Jan 2024 03:45:17 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Wed, 24 Jan 2024 03:45:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1706085917; x=1706172317; bh=28kkoTR9hx
	Fd+b5burZKsFuLkbASjrfM5ha9ImfZW+4=; b=SUwdcNzgApFICQZyvnX3/2856E
	X+ETs8tyOab2Qj0rOdIbexoryfzmChaW3h0BsPklwXmTrLVeVfAHRHw4vve6Bswo
	kLtm26VG8sYju5h6msPhjULCMhG7Pl1pj1dc3SBSi0YesiWp89JlwV74sTs/zDJD
	Sf9gbPnheUGi1AmRFlS/AyTkjdq8aqI9Nv+yuqcZfADWlxgcnl5+U+K6XXLR4gic
	zKX6DCkcN6KqwIfTSCzEnCnByJUhL7jyaKbbk8WCvd1RC4XapqOkI1GZkPmoMDeI
	EKAd4Bq7wYprzhgX/EntclX/+z0GnmZr/Pv+YLZAvJ9xdbSmmU6fxKiDZ05Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1706085917; x=1706172317; bh=28kkoTR9hxFd+b5burZKsFuLkbAS
	jrfM5ha9ImfZW+4=; b=Sg25j+efGOFuI+fWpbTtpEWMXc7+bqvb2mJI6zWjdwlA
	UOEg6e0ohTFi+o0zYbOs86ke7ERyN9MWq3EYh9EsfRqIYScioslaFuyhqMJzm4QX
	1ZAWsIaHl/1tsODqRf6ScVzHPwBIlmwWWEpXZKto0fWC/x9KRnemIv0LEBWDcErr
	yGbG9a8E7QzAgSxhlqRBBjkiIiM3Nt0e1aiPGNWKrpB+ZLTB1Fw6uuYZ37+e+vFH
	qFj54rht5pbLyQXtimHe4wbKyjqWBTc/IrFHEkxRJT1ji/H8RdUAPitST4WNN1QY
	7Vu1ZEZ0TwkSK2wA95EEFwZZWBYwGafYcUxUbP199Q==
X-ME-Sender: <xms:Hc6wZe3JYdRz9e9t1hM8qrYXEORxS7LVBBZRU1NNfcWpjxDkWGjqJg>
    <xme:Hc6wZREEgD0sf-27oulGL7jnNXRpaWuxBYMBIEnMAEqyOCwqxj5FOsnYW0jXYZYcq
    p5a3oJamozSkwy6Rw>
X-ME-Received: <xmr:Hc6wZW5ZNag15sHYTfO-bKlD2VjQ-Pjvz369iSiCwsFZIc4t3SIBb7f7vKxTzOOCBB4VIk768StwmuioGAgHGNVMC8HFepXizPflhcDJ1wgwVg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdeltddgleduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:Hc6wZf1TW6dKWKiEgeqzpKTZkGAjrZ7aC41vqPLrNknBG5P0J6TPUg>
    <xmx:Hc6wZRHV114ZEWZfQomlbo3bd9NV6fGJuiD7P3EER3VQeknyMcxXTQ>
    <xmx:Hc6wZY-a5fUgHCSa1XjLN0XxcZOEykMghqr4J1QHohCTqmeEcQiqAA>
    <xmx:Hc6wZVjt8QL5mrKjjatKh0QxN5QgnFJM2xDCSLwn3C0dG26PuuqeNg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 24 Jan 2024 03:45:15 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id a427360a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 24 Jan 2024 08:42:09 +0000 (UTC)
Date: Wed, 24 Jan 2024 09:45:13 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>, Eric Sunshine <sunshine@sunshineco.com>,
	Toon Claes <toon@iotcl.com>,
	Christian Couder <christian.couder@gmail.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v3 3/6] t1302: make tests more robust with new extensions
Message-ID: <ec90320ff1d5c0a6e5657ef77096c90d816f0513.1706085756.git.ps@pks.im>
References: <cover.1704802213.git.ps@pks.im>
 <cover.1706085756.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="6Uk/XQXbIbW3+lY8"
Content-Disposition: inline
In-Reply-To: <cover.1706085756.git.ps@pks.im>


--6Uk/XQXbIbW3+lY8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

In t1302 we exercise logic around "core.repositoryFormatVersion" and
extensions. These tests are not particularly robust against extensions
like the newly introduced "refStorage" extension as we tend to clobber
the repository's config file. We thus overwrite any extensions that were
set, which may render the repository inaccessible in case it has to be
accessed with a non-default ref storage.

Refactor the tests to be more robust:

  - Check the DEFAULT_REPO_FORMAT prereq to determine the expected
    repository format version. This helps to ensure that we only need to
    update the prereq in a central place when new extensions are added.
    Furthermore, this allows us to stop seeding the now-unneeded object
    ID cache that was only used to figure out the repository version.

  - Use a separate repository to rewrite ".git/config" to test
    combinations of the repository format version and extensions. This
    ensures that we don't break the main test repository. While we could
    rewrite these tests to not overwrite preexisting extensions, it
    feels cleaner like this so that we can test extensions standalone
    without interference from the environment.

  - Do not rewrite ".git/config" when exercising the "preciousObjects"
    extension.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/t1302-repo-version.sh | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/t/t1302-repo-version.sh b/t/t1302-repo-version.sh
index 179474fa65..42caa0d297 100755
--- a/t/t1302-repo-version.sh
+++ b/t/t1302-repo-version.sh
@@ -9,10 +9,6 @@ TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
=20
 test_expect_success 'setup' '
-	test_oid_cache <<-\EOF &&
-	version sha1:0
-	version sha256:1
-	EOF
 	cat >test.patch <<-\EOF &&
 	diff --git a/test.txt b/test.txt
 	new file mode 100644
@@ -28,7 +24,12 @@ test_expect_success 'setup' '
 '
=20
 test_expect_success 'gitdir selection on normal repos' '
-	test_oid version >expect &&
+	if test_have_prereq DEFAULT_REPO_FORMAT
+	then
+		echo 0
+	else
+		echo 1
+	fi >expect &&
 	git config core.repositoryformatversion >actual &&
 	git -C test config core.repositoryformatversion >actual2 &&
 	test_cmp expect actual &&
@@ -79,8 +80,13 @@ mkconfig () {
=20
 while read outcome version extensions; do
 	test_expect_success "$outcome version=3D$version $extensions" "
-		mkconfig $version $extensions >.git/config &&
-		check_${outcome}
+		test_when_finished 'rm -rf extensions' &&
+		git init extensions &&
+		(
+			cd extensions &&
+			mkconfig $version $extensions >.git/config &&
+			check_${outcome}
+		)
 	"
 done <<\EOF
 allow 0
@@ -94,7 +100,8 @@ allow 1 noop-v1
 EOF
=20
 test_expect_success 'precious-objects allowed' '
-	mkconfig 1 preciousObjects >.git/config &&
+	git config core.repositoryFormatVersion 1 &&
+	git config extensions.preciousObjects 1 &&
 	check_allow
 '
=20
--=20
2.43.GIT


--6Uk/XQXbIbW3+lY8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmWwzhkACgkQVbJhu7ck
PpR/bBAAkZUYzmRSc/rJtwqNUajVKbGcxYS61KgBp1RWyvbHVlraSIV1rekf4e3r
J/1R2xvNle3ixxWW1RbtYLVHR15X3BlPUKqiheEPKOox5qlCemsythpP8/OouGag
wcJaeU4TqErGA5iiH2R4tPOe3ptNG+nasc5+EJ5S1RdnGzSYeHvlZoyXmsE18Pmg
cuxA23WaQ9J8tTRyZJyhZEeSXJVkgUgjCnDyDPX1NM0XlqK8vGdJhneGUuZjlK+4
B63bnHf2+sw1MfcbOsBXmAlvOR8GE06+LRCXo3oWD0WyLsDV0ryynvy1rryThDqd
GxWlAaBAawLeN2167YKKZy3vagpYLK6aOLePpU97SlYNB6vIBHFmi3eWNpUUBIgV
uy6mdhOidG9a9FV+85F7KJdJUS8xPy9omoMaWJJvBZvCabNTuXtwaSfNCZlaNuOw
aLPkcbRwp6eODbIwJqbrn9wITdz3PE+4RXTCCoGQF+9NqOkZQQ5B1CK3s3wS9WSY
Z/XkBcdWHIL125r3rv9kN7kK23ILHmxBEcTU2TCpsxzkl9v7+GVdcbtnulJbabb0
GH2zB6im984jJrGnnlVVttzLetdKLZfp7CAlM1xbK93ooEh3t9+emyp6g5eS/9fX
x8kjKu1aTJVbA47WZIEhxAvHAQ0cDT3JXV4Rh5hPDouHOSwdxLM=
=8rHJ
-----END PGP SIGNATURE-----

--6Uk/XQXbIbW3+lY8--
