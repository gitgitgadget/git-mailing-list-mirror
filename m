Received: from fout7-smtp.messagingengine.com (fout7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA1822C85F
	for <git@vger.kernel.org>; Mon,  8 Apr 2024 06:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712558821; cv=none; b=lk+mdCkZpFSkmbJ3I1DGI9tQKRHbWq+zXmYGuOGCXCzZfQfpS+lg2WLHWZg6SOl/9Qie+zUaII/HlRhwOT1GB/ySavneh8Hxb2HfwwCuELcLT+fJElNcoSMAmTgGlPyTccSzxMMKkba2OTjVJ0mHDqjy2MLOQyLQ/b0CJEND9nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712558821; c=relaxed/simple;
	bh=tKvSZ9cxWofjNdXYfT1eI64E+Wvk1W/X3j1wIr8ANwM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rV9fLHCdMZyTaGmbWp8UzeYavNAyaAHv/sVbx0gSCcojZL1yqVqL8wf8kXA9RYWXjmA7XJiBQJMBXHlQ5vYi+fsCdo5j2CkCIVLxFEjyyQuacjUoqpeE7ggbN9pjJVrKo89GElK3iMvuL9Phxt71E5jNEL7hp4WzHf4rWNBfiek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Sm7Z46H/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Y6buKYvU; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Sm7Z46H/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Y6buKYvU"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfout.nyi.internal (Postfix) with ESMTP id 3EC381380059;
	Mon,  8 Apr 2024 02:46:59 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Mon, 08 Apr 2024 02:46:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1712558819; x=1712645219; bh=GBKjNuA4SZ
	B2uZhqDHra+VqG8DOSEpQEFmfu2LkRQ8Q=; b=Sm7Z46H/Vkz4Jm5RjS5Kzg01GL
	Za7kNbZFwtt3KbXm95wXoW6K8E9SjyFXv/jzLnAjiZKlS9ksftMqJ4fzi6JmHi2G
	SdgMSE3mtMY4JjC5bSbCH1RWsnXQWYKzrCeAP5HSHoS2dsml4fFEGfQis9H61Yra
	PCjujuecybtU1Og64Je7xocPyq8w4hnFaG72366EwgwACEUjNNdcw8kgpIC57+FA
	mVoRgEnlsSaYH61waMmW0OWySVZJkF3PThYWcSPznDbBVcOQ0su5Yk4PsfswJ5XN
	1WSDvaBwbwHtCv1yIOfzUKH4Lstl3t4iGhRckKT18QffYf2PBgRyKLsN/smw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1712558819; x=1712645219; bh=GBKjNuA4SZB2uZhqDHra+VqG8DOS
	EpQEFmfu2LkRQ8Q=; b=Y6buKYvUXU+RGwm5hmRZbpDIgjUAfX8U+UPXs9DM+nuv
	DKT5UBqg/L16GoIBD0RGOc6UAAoxMn5e2Lqy4PopcGw8BL44AfbdxBrTnkZtlGhJ
	2k/6/CVwWUNEt043Gu0zxYwJm5e+0+sDRYqvKB0QQRHatgF4i/FSS97vH6BbI64d
	B3GGOiUYhjhdxLO67MtOvgRpAJjy1SPMyaQNRVtvh5+qdv+NndSPB7wFcHwC1eky
	P6+mllLYfBWsnoFmDo/polOcLMeJncNRVrF/tdy96ieu3h3bhiZrTAnGBPc8lprl
	XpMyFBl/an4wUetgJEIT7HCyIGFTf5pXu17ZGEVzIQ==
X-ME-Sender: <xms:45ITZjcm3PWVpRukWYTmnNQ4lBHEdovr5jGKpfzbJbQ2hxWlYh3KXw>
    <xme:45ITZpPLu61bJXJc55s3Epp5b8HoTKZqJG2lPYBIIWa8h1ieFusnM1qa1oKj3VHCY
    3PjihhUKuhGL0T1BA>
X-ME-Received: <xmr:45ITZsgXwM5IVejqHf8p8D2Yj1cavhs0Up3esDN_SRK4eXftC_se-Q7b92hEEbf25CAS0ap7G-6QRo_L1TkJ8-I6r9atfzPfGFc_sQGJmdAwh6fl9A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudeghedguddtlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:45ITZk88az76Z3j3djigpYwO50QQ5axrs2DLe57l1JsLpy7fV5AnQA>
    <xmx:45ITZvtr70Jj_rUXBLW6YLNtH4T2w43c63dNEidOh-rOASWUqHQtIA>
    <xmx:45ITZjEYP1HacXj93SCmItNfkNwh-iVOC39jwui3CKVWOubWWWS4SQ>
    <xmx:45ITZmPkYoXQrcd_likxTcGTN1dCpFyUnh_kfwaiIEKNzkQ9I25aXA>
    <xmx:45ITZlUsZoZmWmNmHUDsnQxPIswGj_S70q-wsZaCbxKPh2ARCcp25xrk>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 Apr 2024 02:46:58 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 3ea203de (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 8 Apr 2024 06:46:52 +0000 (UTC)
Date: Mon, 8 Apr 2024 08:46:55 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Han-Wen Nienhuys <hanwenn@gmail.com>,
	Josh Steadmon <steadmon@google.com>,
	Luca Milanesio <luca.milanesio@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 10/12] t06xx: always execute backend-specific tests
Message-ID: <fc3472cdf300c3fc5d6270c3f2fc3cf0e9d3989f.1712555682.git.ps@pks.im>
References: <cover.1712235356.git.ps@pks.im>
 <cover.1712555682.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="TGOhEI8im6woLP1/"
Content-Disposition: inline
In-Reply-To: <cover.1712555682.git.ps@pks.im>


--TGOhEI8im6woLP1/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The tests in t06xx exercise specific ref formats. Next to probing some
basic functionality, these tests also exercise other low-level details
specific to the format. Those tests are only executed though in case
`GIT_TEST_DEFAULT_REF_FORMAT` is set to the ref format of the respective
backend-under-test.

Ideally, we would run the full test matrix for ref formats such that our
complete test suite is executed with every supported format on every
supported platform. This is quite an expensive undertaking though, and
thus we only execute e.g. the "reftable" tests on macOS and Linux. As a
result, we basically have no test coverage for the "reftable" format at
all on other platforms like Windows.

Adapt these tests so that they override `GIT_TEST_DEFAULT_REF_FORMAT`,
which means that they'll always execute. This increases test coverage on
platforms that don't run the full test matrix, which at least gives us
some basic test coverage on those platforms for the "reftable" format.

This of course comes at the cost of running those tests multiple times
on platforms where we do run the full test matrix. But arguably, this is
a good thing because it will also cause us to e.g. run those tests with
the address sanitizer and other non-standard parameters.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/t0600-reffiles-backend.sh   | 8 ++------
 t/t0601-reffiles-pack-refs.sh | 9 +++------
 t/t0610-reftable-basics.sh    | 9 +++------
 3 files changed, 8 insertions(+), 18 deletions(-)

diff --git a/t/t0600-reffiles-backend.sh b/t/t0600-reffiles-backend.sh
index 64214340e7..a390cffc80 100755
--- a/t/t0600-reffiles-backend.sh
+++ b/t/t0600-reffiles-backend.sh
@@ -4,16 +4,12 @@ test_description=3D'Test reffiles backend'
=20
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=3Dmain
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+GIT_TEST_DEFAULT_REF_FORMAT=3Dfiles
+export GIT_TEST_DEFAULT_REF_FORMAT
=20
 TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
=20
-if ! test_have_prereq REFFILES
-then
-	skip_all=3D'skipping reffiles specific tests'
-	test_done
-fi
-
 test_expect_success 'setup' '
 	git commit --allow-empty -m Initial &&
 	C=3D$(git rev-parse HEAD) &&
diff --git a/t/t0601-reffiles-pack-refs.sh b/t/t0601-reffiles-pack-refs.sh
index c309d2bae8..157f79fe52 100755
--- a/t/t0601-reffiles-pack-refs.sh
+++ b/t/t0601-reffiles-pack-refs.sh
@@ -9,18 +9,15 @@ test_description=3D'git pack-refs should not change the b=
ranch semantic
 This test runs git pack-refs and git show-ref and checks that the branch
 semantic is still the same.
 '
+
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=3Dmain
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+GIT_TEST_DEFAULT_REF_FORMAT=3Dfiles
+export GIT_TEST_DEFAULT_REF_FORMAT
=20
 TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
=20
-if ! test_have_prereq REFFILES
-then
-	skip_all=3D'skipping reffiles specific tests'
-	test_done
-fi
-
 test_expect_success 'enable reflogs' '
 	git config core.logallrefupdates true
 '
diff --git a/t/t0610-reftable-basics.sh b/t/t0610-reftable-basics.sh
index 686781192e..aa9282007c 100755
--- a/t/t0610-reftable-basics.sh
+++ b/t/t0610-reftable-basics.sh
@@ -4,17 +4,14 @@
 #
=20
 test_description=3D'reftable basics'
+
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=3Dmain
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+GIT_TEST_DEFAULT_REF_FORMAT=3Dreftable
+export GIT_TEST_DEFAULT_REF_FORMAT
=20
 . ./test-lib.sh
=20
-if ! test_have_prereq REFTABLE
-then
-	skip_all=3D'skipping reftable tests; set GIT_TEST_DEFAULT_REF_FORMAT=3Dre=
ftable'
-	test_done
-fi
-
 INVALID_OID=3D$(test_oid 001)
=20
 test_expect_success 'init: creates basic reftable structures' '
--=20
2.44.GIT


--TGOhEI8im6woLP1/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYTkt4ACgkQVbJhu7ck
PpQOIw//QczYWorVMM2KnTGHxmamsxy65oz25ooiCVHJ/ffQwQ6tJ9iFOpJA1xtj
xXSw9zn80bPCmF8ReOCh5cYkhr8+KneN0Jtg1uDO3fArlAMtv48MxoWMTSksZa91
dWzjevLOsXD80DNtnISJJIqr+USId0hIMepbnFmlDYdvSEfJfUGrEnS0a66F1UXj
EK9wR1I/JqFaPRX+WRa52CLXA3moFdSiEFCqx213nPUo7CVJEk6GI/xdOfX1BWC/
3UaMgXba15TdrL+nvrfWQcpirUCG8hD2/Rhox+6j28DY4woQRQTroq2m9QY0HJZ5
Zm6RZ4N/lveLhGG8wmUPgVbhKbCy6jaQlxx3GlQNV+rDAikOEaAVDdm+0rIoc9Ss
B+TQ7ZaLnO1AihRAzpu3w6Wj+4aY5oIHSgHvc8vNEI/IhBdf/aovCLVqhipztZIr
AAx4mSR7hC9HJbWnSwWP4Utkxxch1YsFXZDh85euX30pc8PjbMovrz16uwnMXwfn
d6wEcHC9RBlVLpPd+qV2glrryrpAyRLbHjJkROQTGjYD0cRCZJbW3xP+aL4AcATm
r8EbDvxH77Ik8Ez/mOAKAQY7lIwmfpODaxW4f9NBvDvAPQpSbXS3srxhqhgtCw7N
Dbg5y6C9HUpUN6QC7aEZ6yX1nrUwKAOaeWfKxrv2dCWkpMZw8do=
=/vKI
-----END PGP SIGNATURE-----

--TGOhEI8im6woLP1/--
