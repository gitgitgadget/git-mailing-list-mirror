Received: from fout7-smtp.messagingengine.com (fout7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 836441F944
	for <git@vger.kernel.org>; Wed,  7 Feb 2024 07:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707290437; cv=none; b=gEaaQxStTXo5MswgRpBxtLM7kmip9R2WGHF8Wyk6+eUnyRoLwuTgel6BtamwVGLzEseFlWXjSASTqXeEdF3aTfj1ScO7vvX3VquLyy625JpCoihLpM3gvwMAGYYf0wgQpL3inv2yU4IxZkesU7R7kQxlyBjSiuU1OF87gmfX71E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707290437; c=relaxed/simple;
	bh=O07ihZwc5oosmQpLYYo1sYchYnRsgeJkXMkh/7VhyBQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FtRyX/lazmfbwT3moFxTD8R1arx6Q5U0oqxf+OUfU9mbPEfOKJ7rBAacdotfEgqLQAP5c0EetddNFaRBgSeQiNmtSjPXX5f9wJ7SuMwch6ng8X+gjGSJhSVTgQCPtVkq/aY1t2c+l0LdV0CjoACTiyhR9n9RRYteSVLRCIOmz1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=SPYirwed; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IRDDJuYQ; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="SPYirwed";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IRDDJuYQ"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfout.nyi.internal (Postfix) with ESMTP id 2618D13800AA;
	Wed,  7 Feb 2024 02:20:33 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Wed, 07 Feb 2024 02:20:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1707290433; x=1707376833; bh=v2dZghdNAR
	85p4Id3KCPWg7A38d9yZyVbFoh+yMwLBI=; b=SPYirwedtOTgqnh2+9x1pM05uo
	OkDxDPps7t7FiiNn6C8bsFapR6t9ugPrebXcJMrzXPa6tU17GWO2/Ku270fOfpTh
	p0SgbRWdZnnHq5PxFWHqTfn8dgK0kp2TK9pUzjdkVVM1syeKX3IIj8hJfG56Ema/
	HSI+mLPtSuZegaGRdfaw/HVq38Fn7HkvJ6+OFIp22xv6smMKKsXCl2Zk9qIYdKH/
	3DCAgm4yzeHD0CoMJA/nWaM0F/PRBY3gG1TODCG9X73AhxIqhIu04UA04/tqs1kr
	oUWxPbcWsgJ+H4ENsCIDbIXxmDhoFT0/OxtMa39QogwVQ/2LqGUJjn9i+sOA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1707290433; x=1707376833; bh=v2dZghdNAR85p4Id3KCPWg7A38d9
	yZyVbFoh+yMwLBI=; b=IRDDJuYQOqLvhMX3P7hUa7XBWTsomh7U5AlPLtlHF1ll
	K2eHiG1xQ+VhQIG9lUx3g+1Fb1lP950mYdBZ0qK70GPzDpMAO1e5q4Gjxwl6aO4e
	zrbVfL7mPVu1NwpYH+ubzuJMgmQHPhfzNJPlSzEaBWLePyi41Cu75brFu9aMu4NZ
	jQm/hricp0uEuEb5h/FI54Wk7pgbm+m/aPg3vHGOy9DpcNnGBJYbyMalgQLBGNAB
	dMqXjS9Z6evFUcQ11qorSGAbtqN6HChER8hIjWejHuilnWdBk+0skcn9udpCzzOI
	JKBZXzwgeIBzF/jaaQc6jbsH+MM9LsbT1tbUhUQIGQ==
X-ME-Sender: <xms:QC_DZcR2jAmb3_JXImyO_wOBYLER0t1vamLicF91lDCsNCcDCcXLkA>
    <xme:QC_DZZzFKAA_kaNyjDxHHz1KP7ow3XUTgDzXMAIa4r_USbnDGCErG0nQWUKMDdN1s
    2UxCPsNvPshYrqafw>
X-ME-Received: <xmr:QC_DZZ2jFh4V5-dhQ4PVMWHfZJyeZz7X0lbh_DeAqgb1qtRFtj22XlggWjQUPGTYNjitNaBO-RqpDSZRL38j27AFZhIAnRMDAE-WdZANAoePHw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrtddugddutdehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepvdehteeggfevueevhedtleelveeigfefieduiefgvdfffeegvdeitefgteevveeu
    necuffhomhgrihhnpehhthhtphgurdhshhenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:QS_DZQAkQma7lMZfm9HnlTCNC6NEUZgZ-3PbJq5iuFdgh-oW8RB4vg>
    <xmx:QS_DZVgYxWKeLjKx7mzFUR10M1UHOQhIByDVQVZZQ77YwkX39N5coQ>
    <xmx:QS_DZcoJ0WMTHNvSujaE3kCXav_uwUEQNnBKxAL4wbvNSEa5_8VNwA>
    <xmx:QS_DZVdQnyH67E8zRNe6IQhQtev5NY1fjOM9hIzZdLRC0-qkjXMJ7A>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 7 Feb 2024 02:20:32 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 051f942f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 7 Feb 2024 07:16:57 +0000 (UTC)
Date: Wed, 7 Feb 2024 08:20:27 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Han-Wen Nienhuys <hanwen@google.com>,
	Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v4 0/2] refs: introduce reftable backend
Message-ID: <cover.1707288261.git.ps@pks.im>
References: <cover.1706601199.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="JnyNhzG0Y0NjXNiI"
Content-Disposition: inline
In-Reply-To: <cover.1706601199.git.ps@pks.im>


--JnyNhzG0Y0NjXNiI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

this is the fourth version of my patch series that introduces the
reftable backend.

Changes compared to v3:

  - kn/for-all-refs has been reverted due to discussions around its user
    interface. I have thus evicted the patch series as a dependency and
    dropped handling of DO_FOR_EACH_INCLUDE_ALL_REFS.

  - ps/reftable-compacted-tables-permission-fix has been merged to
    "master" now, fixing permissions on "tables.list" when compacting
    reftables. I've marked the corresponding test as succeeding.

  - jc/reftable-core-fsync has been merged to "master" now, which adds
    fsyncing logic to reftable. I've marked the corresponding test as
    succeeding.

  - I noticed that the fsync tests fail on macOS because there we use a
    different fsync method by default. I fixed that by explicitly saying
    which fsync method should be used in the corresponding tests.

  - I also noticed that the second fsync test reused "trace2.txt" from
    the first fsync test because it only appends to the file. Thus, we
    saw two fsync events instead of one. I fixed that by truncating the
    file.

The patch series is based on the current "master" branch at 235986be82
(The fourteenth batch, 2024-02-06).

Thanks!

Patrick

Patrick Steinhardt (2):
  refs: introduce reftable backend
  ci: add jobs to test with the reftable backend

 .github/workflows/main.yml                    |    9 +
 .gitlab-ci.yml                                |    9 +
 Documentation/ref-storage-format.txt          |    2 +
 .../technical/repository-version.txt          |    5 +-
 Makefile                                      |    1 +
 ci/lib.sh                                     |    2 +-
 ci/run-build-and-tests.sh                     |    3 +
 contrib/workdir/git-new-workdir               |    2 +-
 path.c                                        |    2 +-
 path.h                                        |    1 +
 refs.c                                        |    1 +
 refs/refs-internal.h                          |    1 +
 refs/reftable-backend.c                       | 2297 +++++++++++++++++
 repository.h                                  |    5 +-
 t/t0610-reftable-basics.sh                    |  887 +++++++
 t/t0611-reftable-httpd.sh                     |   26 +
 t/test-lib.sh                                 |    2 +
 17 files changed, 3248 insertions(+), 7 deletions(-)
 create mode 100644 refs/reftable-backend.c
 create mode 100755 t/t0610-reftable-basics.sh
 create mode 100755 t/t0611-reftable-httpd.sh

Range-diff against v3:
1:  d83e66e980 ! 1:  5de60d46bd refs: introduce reftable backend
    @@ refs/reftable-backend.c (new)
     +			break;
     +
     +		/*
    -+		 * Unless DO_FOR_EACH_INCLUDE_ALL_REFS is set, we only list
    -+		 * refs starting with "refs/" to mimic the "files" backend.
    ++		 * The files backend only lists references contained in
    ++		 * "refs/". We emulate the same behaviour here and thus skip
    ++		 * all references that don't start with this prefix.
     +		 */
    -+		if (!(iter->flags & DO_FOR_EACH_INCLUDE_ALL_REFS) &&
    -+		    !starts_with(iter->ref.refname, "refs/"))
    ++		if (!starts_with(iter->ref.refname, "refs/"))
     +			continue;
     +
     +		if (iter->prefix &&
    @@ t/t0610-reftable-basics.sh (new)
     +	test_cmp expect actual
     +}
     +
    -+# A fix for this is in flight via jc/reftable-core-fsync.
    -+test_expect_failure 'ref transaction: writes are synced' '
    ++test_expect_success 'ref transaction: writes are synced' '
     +	test_when_finished "rm -rf repo" &&
     +	git init repo &&
     +	test_commit -C repo initial &&
     +
     +	GIT_TRACE2_EVENT=3D"$(pwd)/trace2.txt" \
     +	GIT_TEST_FSYNC=3Dtrue \
    -+		git -C repo -c core.fsync=3Dreference update-ref refs/heads/branch =
HEAD &&
    ++		git -C repo -c core.fsync=3Dreference \
    ++		-c core.fsyncMethod=3Dfsync update-ref refs/heads/branch HEAD &&
     +	check_fsync_events trace2.txt <<-EOF
     +	"name":"hardware-flush","count":2
     +	EOF
    @@ t/t0610-reftable-basics.sh (new)
     +
     +for umask in 002 022
     +do
    -+	# A fix for this is in flight via ps/reftable-compacted-tables-permi=
ssion-fix.
    -+	test_expect_failure POSIXPERM 'pack-refs: honors core.sharedReposito=
ry' '
    ++	test_expect_success POSIXPERM 'pack-refs: honors core.sharedReposito=
ry' '
     +		test_when_finished "rm -rf repo" &&
     +		(
     +			umask $umask &&
    @@ t/t0610-reftable-basics.sh (new)
     +	'
     +done
     +
    -+# A fix for this is in flight.
    -+test_expect_failure 'packed-refs: writes are synced' '
    ++test_expect_success 'packed-refs: writes are synced' '
     +	test_when_finished "rm -rf repo" &&
     +	git init repo &&
     +	test_commit -C repo initial &&
     +	test_line_count =3D 2 table-files &&
     +
    ++	: >trace2.txt &&
     +	GIT_TRACE2_EVENT=3D"$(pwd)/trace2.txt" \
     +	GIT_TEST_FSYNC=3Dtrue \
    -+		git -C repo -c core.fsync=3Dreference pack-refs &&
    ++		git -C repo -c core.fsync=3Dreference \
    ++		-c core.fsyncMethod=3Dfsync pack-refs &&
     +	check_fsync_events trace2.txt <<-EOF
     +	"name":"hardware-flush","count":2
     +	EOF
2:  146bb95c03 =3D 2:  30e5feb28c ci: add jobs to test with the reftable ba=
ckend

base-commit: 235986be822c9f8689be2e9a0b7804d0b1b6d821
--=20
2.43.GIT


--JnyNhzG0Y0NjXNiI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmXDLzoACgkQVbJhu7ck
PpTlVQ/+PWmjnWehBC4dcRYoV9FPG+64fyxR6pFf3ZSOCV6UxJuxDqtQFe8rfpFe
a9/DJNJ7wtSR/ZSF3tJEfcRYRySDedGlr3TxUnUDcsFEVCt8LED11PD8J23jHYsu
f9LJV+MLiFyiYZQmZZgHbcysdRM5my/geb1395Jw3HoX73ohtpzk1J4mYKJU224t
xZbtm9x31pSl7ZpLo4YomXgwVlxD1C01XRs/WGtMeYzqQx52+qAbFyCcETgs4dRL
DfkOIKC1FTo0kmqbJ4OZdKrEKB9EOkZafpbprKmoLKJXbXidq4Zxh2xfsgz5+pgO
kqSN4/coYtxcMD0B26BqtYt4vYtJn7/9ujv53gJp9Eredl+7UKX2+EAXElSNQph6
fc4lAltii8PaT9pF5I5PWPneivCLh9Or+qliCyWu94x3uw9U6qiefNeq5ouH1oAH
cIsgFsnu8yyMoNEYxKT/G1Q4PMA5ZKvAgjAaU2Wbi8OC7Y+505F7ymCQjQFaWi1o
zDhPCLZ/2vuhryWLcx4BLengpYBvBkaFmnbzSMX88aXEhWLbNI/JgY4frC8e+tOF
PtLde09l3RIFGTqrdQopeZpxy9yeDrVeGSmSTwl2meSG0y+l+a3NHppQrw1j+adW
YnuRK0IaHNPT0TEdgbY3B9/QhCjKHaAhNGiKhQwExB0654pOofo=
=Sjs7
-----END PGP SIGNATURE-----

--JnyNhzG0Y0NjXNiI--
