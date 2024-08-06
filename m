Received: from fout6-smtp.messagingengine.com (fout6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 142A515F409
	for <git@vger.kernel.org>; Tue,  6 Aug 2024 09:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722934878; cv=none; b=rxSI+RwCEPGnBSuwpetnTsPdQi/Mx7wF/jOMauCbmfNVPbn23JxRI9DaIW1mYeRbr1MFfN2XIa8lvP+33slrmzrKfL4RV0m/sGPLAqhjoWP8oSIuZqSJHIXMEcFE7minm0fr4sKNi5UwTZZIE0ztz1l6qMY/m5910E1p7ZCDwK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722934878; c=relaxed/simple;
	bh=+Z1/Un/qWq/yY3MzCUrqELTGcS/ZhrBHLmrjtLY8Y/Q=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RsLGVN6ZzIKRoTb9e10ITipC1pzcUNzEmnZ5SuVzFP/J7RIiYWaSKeNHIPZL6e/WGA4P1ivRSEGzD7vbEkuAejwuxk4ZZHbD/wZ1aVdB4TcVDnNOtXhQQxO3ob+ePpcXzAbyajOq1A6Bzj8fsreqREIx/FBJc7DxuQquk37aC4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=eg8royJw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eW7igtmC; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="eg8royJw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eW7igtmC"
Received: from compute8.internal (compute8.nyi.internal [10.202.2.227])
	by mailfout.nyi.internal (Postfix) with ESMTP id 3B49F138FCB9
	for <git@vger.kernel.org>; Tue,  6 Aug 2024 05:01:16 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute8.internal (MEProxy); Tue, 06 Aug 2024 05:01:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1722934876; x=1723021276; bh=RWNd7SS+Wc
	MyL7Wn/s3EMCGlw9FhIRXCsH2fN1yMvUA=; b=eg8royJw1aOVNIlInUkLOO24Fa
	6w3cwskesP/dXeZhTkLV8brtIuokVOAoaez7FTrGNGFtn7rlsDXACofaz4By3Cyj
	htCiQ9V1MhhMCbQn6A4w+r5mQLRfgl4fiTlLiHXoPMpx4fbSnh46s8HDMt8UuR05
	a0ucdozGhVeuFZLBap7J5/scH9Qy9YVMowUhmBodtjOcYX9ov2LaUZX4bNtyH3T3
	i0vIfCXqVuYWic36r42BJVwPoPPI9FSF3XpgN5bvcvxTYvfiIuwN0ZLjZkczUuKd
	Yza5O132nL7HKAzovW0mgcVRnoHaExVuP3Xh64Z/MAUohnpDf2t0PU5Bp3SA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1722934876; x=1723021276; bh=RWNd7SS+WcMyL7Wn/s3EMCGlw9Fh
	IRXCsH2fN1yMvUA=; b=eW7igtmCP97ky5Y+DOtWrRcdLoG92PSUTxMBP6QsWTv5
	dZykoOj/n8hWCpidSKMhCto5k+ZtGseS3xJ8VVr12+qCU/owF3VwCTzmG8fqV9n0
	QpkbZRpuSs6D4UT9wfSkALRjlKLRXS0zOzBLmBSrwc6pUtq93Yb4ssOPI0KnuYRa
	cDpeZ8kxz0YtOCm8OpARsg3G6r9XcsxwIgs9jXQTSGY2psuOAB8legpKCbW1Qi+0
	P4kpDXWccXfjDDHsje/K0C6dZBf9+YcmuRur/Ab43JMzezqdVfrB84yahjugfuh/
	NdDRCzf7EE6HWROdYCgQTC+u5jYzVQk0F7eKvK1EOg==
X-ME-Sender: <xms:XOaxZnkJgR7jC4ZlKNAFLXKvmbKZv4bjlL2kZ3KilpWZCLb4Oei9yQ>
    <xme:XOaxZq3a9dy6TaaSbWp6_6DqFCVAVvzOrpiKJ6uURH0zVMLQA9lcaPylD2Y3f2u4m
    VhmXlyNY1rCSUvb5Q>
X-ME-Received: <xmr:XOaxZtrhAYxnR8dIGw632aW1Wx8UbwtV6WYmhwr72s1xl6W-MBiLL0y84HQgNyDfuW86oi5W-HVqaCqz2AevKH9UUWIHXkxHxy9Y1GRcbypt>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrkeekgddtkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggtuggjsehgtderre
    dttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeehgefhtdefueffheekgfffudelffejtdfhvd
    ejkedthfehvdelgfetgfdvtedthfenucevlhhushhtvghrufhiiigvpeehnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedt
X-ME-Proxy: <xmx:XOaxZvlxktPfgWceT5gu9KE-ai42XWYYDlfXrbI-wb7IPGu3AsWr-A>
    <xmx:XOaxZl0BkOPoPV7o6lgDWVgz6Yg_TZtYQC9tgh_QaHP4yJpaeuyFuA>
    <xmx:XOaxZuu-LK5iS39gfZDuWiOi38LBy6HlWVa7XKDAgPRa5mnzzW6FEA>
    <xmx:XOaxZpX91Znyc6PJi7GkfJThrBznRXn908uIWw4B24yPkfi1mFcw9g>
    <xmx:XOaxZm9j_nVzVRY6mYLJv8HJy2w_ueKtoZXCDImKWbKj41FWFv2P3ydQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 6 Aug 2024 05:01:15 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id dd1e3e92 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Tue, 6 Aug 2024 09:01:13 +0000 (UTC)
Date: Tue, 6 Aug 2024 11:01:13 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 21/22] diff: free state populated via options
Message-ID: <a49bb2e0cc0e89c8dbd49e56169b5ed17f8faa54.1722933643.git.ps@pks.im>
References: <cover.1722933642.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ygJ6m2mRduYdTmsS"
Content-Disposition: inline
In-Reply-To: <cover.1722933642.git.ps@pks.im>


--ygJ6m2mRduYdTmsS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The `objfind` and `anchors` members of `struct diff_options` are
populated via option parsing, but are never freed in `diff_free()`. Fix
this to plug those memory leaks.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 diff.c                   | 10 ++++++++++
 t/t4064-diff-oidfind.sh  |  2 ++
 t/t4065-diff-anchored.sh |  1 +
 t/t4069-remerge-diff.sh  |  1 +
 4 files changed, 14 insertions(+)

diff --git a/diff.c b/diff.c
index 9251c47b72..4035a9374d 100644
--- a/diff.c
+++ b/diff.c
@@ -6717,6 +6717,16 @@ void diff_free(struct diff_options *options)
 	if (options->no_free)
 		return;
=20
+	if (options->objfind) {
+		oidset_clear(options->objfind);
+		FREE_AND_NULL(options->objfind);
+	}
+
+	for (size_t i =3D 0; i < options->anchors_nr; i++)
+		free(options->anchors[i]);
+	FREE_AND_NULL(options->anchors);
+	options->anchors_nr =3D options->anchors_alloc =3D 0;
+
 	diff_free_file(options);
 	diff_free_ignore_regex(options);
 	clear_pathspec(&options->pathspec);
diff --git a/t/t4064-diff-oidfind.sh b/t/t4064-diff-oidfind.sh
index 6d8c8986fc..846f285f77 100755
--- a/t/t4064-diff-oidfind.sh
+++ b/t/t4064-diff-oidfind.sh
@@ -1,6 +1,8 @@
 #!/bin/sh
=20
 test_description=3D'test finding specific blobs in the revision walking'
+
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
=20
 test_expect_success 'setup ' '
diff --git a/t/t4065-diff-anchored.sh b/t/t4065-diff-anchored.sh
index b3f510f040..647537c12e 100755
--- a/t/t4065-diff-anchored.sh
+++ b/t/t4065-diff-anchored.sh
@@ -2,6 +2,7 @@
=20
 test_description=3D'anchored diff algorithm'
=20
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
=20
 test_expect_success '--anchored' '
diff --git a/t/t4069-remerge-diff.sh b/t/t4069-remerge-diff.sh
index 07323ebafe..888714bbd3 100755
--- a/t/t4069-remerge-diff.sh
+++ b/t/t4069-remerge-diff.sh
@@ -2,6 +2,7 @@
=20
 test_description=3D'remerge-diff handling'
=20
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
=20
 # This test is ort-specific
--=20
2.46.0.dirty


--ygJ6m2mRduYdTmsS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmax5lgACgkQVbJhu7ck
PpT2kxAAlnkDB9Q3zE6I79xQ/1sPy2hEsSOkblk9CrxYZwcXsAOTxcCT4c9n6CwP
5jbBSXtstvoHJrec2BqlabD0RaQMlROnaffwRBJqis2HBkzBQqi//4GCQB/OexpD
EDfPmd2NPYrRisx/NQIcXZ6/B/AljrDXCjl58ptPMV+1m7zFfQBFjh2pnCKDFObZ
uu9xZQdGuZhu4Lhkg/ZJiBwlzs1tgX4wXzzupXS1n39c8HF/cgZL3A3CdjGkvLcW
gJRpLV9izg+DAwBOl8CAzMOki65UIDO3yqgazweUlwzZc8m2lk+RqqarYFaSvFrp
ksALCUCYO38LMD15VbvCZvMsRUvz7u3xEWfFAwOTNR6zRKsjaQ+g9AE/z3UhwpMo
xrjEJm7hX++JGd4BPkaSduW/9BBpo0gnJ2PaS4b4YhwakpsyfRQH6FGjmIOKYQdX
qVR8sy92Kjj8sDmrk9GwRQ5G2VEgqABtfiY3v7qrfUzIVYP0PBJZhB98zJmjkgAJ
HDdj9OR8ayysZ2G3Lo806iy7saOS+s9qvclXDXOR0Kms/n15n0H3MVz442ktc7t/
p7J+xjJ5rmQckYNzm1mnImtvrQMUpSvZVCjuw427IjKcLCiEpOCjFXZrpDQ1DMPD
J4Eb2OzASMk8DHkBa7n5tC3DEin7eD3+I+HfSi74QA0MKanY7W0=
=97Pe
-----END PGP SIGNATURE-----

--ygJ6m2mRduYdTmsS--
