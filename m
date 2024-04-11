Received: from fhigh1-smtp.messagingengine.com (fhigh1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56CBF1448C8
	for <git@vger.kernel.org>; Thu, 11 Apr 2024 09:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712826675; cv=none; b=BD7bjAcxwcKiYA5VvsdIxAEVq+HDHp72yGvVuGcXQBvNJ68LpLcdLAkgpy21LHq6pt/7Asw6JktFaF+MQ5McCdqC2lsslkpdGAkQbg2rO8wIKBHrt/zSW0sj6lqzkLWWAitj9p1NHxpOOd/LgsaqOhEw4sCBR4tSzs0j4x3r/zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712826675; c=relaxed/simple;
	bh=j4v++WAgSF6wM8d18uCMI5TmhqyXBvJ/veVexaGB4kQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GYXauXSqshjoeRE0jBYeHGnIn0ChA9n9uAcjjn39obV0FgiGh6WrdDBbKqKRRq0ELZmWNTodZQwco1l9k3YvScBmV0JpAWLTBCgmqhRt/OsPxARyJ6KTLvMAA3W0lCoLRnOkQNEfflI4VxXL+67ETu4EdUeA+cJlX91z8ayEOaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=KWcCYQrF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=H0aSJkLF; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="KWcCYQrF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="H0aSJkLF"
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 97CF11140198;
	Thu, 11 Apr 2024 05:11:13 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Thu, 11 Apr 2024 05:11:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1712826673; x=1712913073; bh=6aSWjJ12Fu
	xT9lPiMEBv9PFjB3APa8lRCKefDAMrz88=; b=KWcCYQrFKW1dDTznnzeE1eFMQT
	2C8GobMmUilS8w4E5n/LBbKgpyK7Fw1OoBREAAeALgl1hDCVvx4cYQ20yQ+4ajrU
	cNs0HtWXF2YtebFom7evigrSNgzG/Xht849pOihj+iPvynSc84dCU7gq7ZzdTMBt
	M/FZ8R1432DunlMGgT9dzjZs5iTedpbqTmvJVhAKO0JGtJ9Q33Zm8fcsiyctlK7d
	HsP4IpGyMkXf3kO9C67LxePHoc73j+w0PyG+5quwT+UmTqpFCa9vVH9JdVmWoZZl
	h7L74jmkubVYORiZMv/dvbi1JkNBubGuO9eN/Ei14fNwAq3y8V3GY0YfHFrQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1712826673; x=1712913073; bh=6aSWjJ12FuxT9lPiMEBv9PFjB3AP
	a8lRCKefDAMrz88=; b=H0aSJkLFh42IBEZkVDnZmKgi1HVQIVPXqMndVuq/SJMN
	cQGVL2Z6M4dxm49Hmqwy+GywZcNYQ3j88ycxFMob9YDNja40uitDk3n4B8wCFT1d
	LrQcJTGRjUCj3yFFdd1+zIROWzmBOcn9T53KM1gQ9xD0ouwkIPEjeKSaOiM3qjIp
	rDzVv6uesa/yrfPRZAD7cVxZld3MB3NTKnhGaRm9YRgHpQgdIGPoG11kX/L+FNsJ
	+0czil0UFPxVQ/3Evz+oq2Vj9wTXIj9vfQw8P5iFkHcNZ/ovp/zBY4/32re03JXo
	BEFXPfVd5FZMtK1/+0LSI/7/lR4okAjWm3eVv0KpCg==
X-ME-Sender: <xms:MakXZjMTfhjqkssb-43bF1aRqgBUhYjZj0OoRZ8JOIjHyVEKXAq5YA>
    <xme:MakXZt8a6OeTi5UuqJ5cYmmb8PSIe9EzjdLe3YPt1EatZP_PxzSQLnYGURrG7vjdI
    RHt6j93iWxgfQjiJg>
X-ME-Received: <xmr:MakXZiQj7GQJYWY6nSlUpdPeh9dLSt5S1yE3RFxeyE75_ToNjCoRThNjNL83kp_mjAwMB_ycmSwqon-w5vQoOIOLaMPSJi16GL-TC97eZN8aNLFG>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudehkedgudefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:MakXZnu6MALa-s6xl72qcLhNDa1X1CR0LJA9WJHtBHox2qHXS3V60Q>
    <xmx:MakXZres8YVYroVwJeeu_ChQtqZvr5aXUYY14nmxUi9gqAdx3HRcRA>
    <xmx:MakXZj2QrZT-7yaYjThfy6NyZ0nlhF8_0amaNlP0iIrX4lAfhAoRJQ>
    <xmx:MakXZn_JVo5Z4aXEYM7B5HQeFyrIGK_G1uh8OdHVIcqUNPJQcI7lcQ>
    <xmx:MakXZtsamnEMVsbIuon-qHUK7ed8Cp1Kv0FS3_eMHP7rzc3BA9fLkVQs>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 11 Apr 2024 05:11:11 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id c3240194 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 11 Apr 2024 09:11:00 +0000 (UTC)
Date: Thu, 11 Apr 2024 11:11:09 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Han-Wen Nienhuys <hanwenn@gmail.com>,
	Josh Steadmon <steadmon@google.com>,
	Luca Milanesio <luca.milanesio@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Toon Claes <toon@iotcl.com>, Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v3 13/13] t0612: add tests to exercise Git/JGit reftable
 compatibility
Message-ID: <a9cd20eebcd2407604b9d534088197696f74bba1.1712825204.git.ps@pks.im>
References: <cover.1712235356.git.ps@pks.im>
 <cover.1712825204.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="rMvzjH94yE/ZJAOV"
Content-Disposition: inline
In-Reply-To: <cover.1712825204.git.ps@pks.im>


--rMvzjH94yE/ZJAOV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

While the reftable format is a recent introduction in Git, JGit already
knows to read and write reftables since 2017. Given the complexity of
the format there is a very real risk of incompatibilities between those
two implementations, which is something that we really want to avoid.

Add some basic tests that verify that reftables written by Git and JGit
can be read by the respective other implementation. For now this test
suite is rather small, only covering basic functionality. But it serves
as a good starting point and can be extended over time.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/t0612-reftable-jgit-compatibility.sh | 132 +++++++++++++++++++++++++
 1 file changed, 132 insertions(+)
 create mode 100755 t/t0612-reftable-jgit-compatibility.sh

diff --git a/t/t0612-reftable-jgit-compatibility.sh b/t/t0612-reftable-jgit=
-compatibility.sh
new file mode 100755
index 0000000000..d0d7e80b49
--- /dev/null
+++ b/t/t0612-reftable-jgit-compatibility.sh
@@ -0,0 +1,132 @@
+#!/bin/sh
+
+test_description=3D'reftables are compatible with JGit'
+
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=3Dmain
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+GIT_TEST_DEFAULT_REF_FORMAT=3Dreftable
+export GIT_TEST_DEFAULT_REF_FORMAT
+
+# JGit does not support the 'link' DIRC extension.
+GIT_TEST_SPLIT_INDEX=3D0
+export GIT_TEST_SPLIT_INDEX
+
+. ./test-lib.sh
+
+if ! test_have_prereq JGIT
+then
+	skip_all=3D'skipping reftable JGit tests; JGit is not present in PATH'
+	test_done
+fi
+
+if ! test_have_prereq SHA1
+then
+	skip_all=3D'skipping reftable JGit tests; JGit does not support SHA256 re=
ftables'
+	test_done
+fi
+
+test_commit_jgit () {
+	touch "$1" &&
+	jgit add "$1" &&
+	jgit commit -m "$1"
+}
+
+test_same_refs () {
+	git show-ref --head >cgit.actual &&
+	jgit show-ref >jgit-tabs.actual &&
+	tr "\t" " " <jgit-tabs.actual >jgit.actual &&
+	test_cmp cgit.actual jgit.actual
+}
+
+test_same_ref () {
+	git rev-parse "$1" >cgit.actual &&
+	jgit rev-parse "$1" >jgit.actual &&
+	test_cmp cgit.actual jgit.actual
+}
+
+test_same_reflog () {
+	git reflog "$*" >cgit.actual &&
+	jgit reflog "$*" >jgit-newline.actual &&
+	sed '/^$/d' <jgit-newline.actual >jgit.actual &&
+	test_cmp cgit.actual jgit.actual
+}
+
+test_expect_success 'CGit repository can be read by JGit' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		test_commit A &&
+		test_same_refs &&
+		test_same_ref HEAD &&
+		test_same_reflog HEAD
+	)
+'
+
+test_expect_success 'JGit repository can be read by CGit' '
+	test_when_finished "rm -rf repo" &&
+	jgit init repo &&
+	(
+		cd repo &&
+
+		touch file &&
+		jgit add file &&
+		jgit commit -m "initial commit" &&
+
+		# Note that we must convert the ref storage after we have
+		# written the default branch. Otherwise JGit will end up with
+		# no HEAD at all.
+		jgit convert-ref-storage --format=3Dreftable &&
+
+		test_same_refs &&
+		test_same_ref HEAD &&
+		# Interestingly, JGit cannot read its own reflog here. CGit can
+		# though.
+		printf "%s HEAD@{0}: commit (initial): initial commit" "$(git rev-parse =
--short HEAD)" >expect &&
+		git reflog HEAD >actual &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_success 'mixed writes from JGit and CGit' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+
+		test_commit A &&
+		test_commit_jgit B &&
+		test_commit C &&
+		test_commit_jgit D &&
+
+		test_same_refs &&
+		test_same_ref HEAD &&
+		test_same_reflog HEAD
+	)
+'
+
+test_expect_success 'JGit can read multi-level index' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+
+		test_commit A &&
+		awk "
+		    BEGIN {
+			print \"start\";
+			for (i =3D 0; i < 10000; i++)
+			    printf \"create refs/heads/branch-%d HEAD\n\", i;
+			print \"commit\";
+		    }
+		" >input &&
+		git update-ref --stdin <input &&
+
+		test_same_refs &&
+		test_same_ref refs/heads/branch-1 &&
+		test_same_ref refs/heads/branch-5738 &&
+		test_same_ref refs/heads/branch-9999
+	)
+'
+
+test_done
--=20
2.44.GIT


--rMvzjH94yE/ZJAOV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYXqSwACgkQVbJhu7ck
PpTDwhAAndnnAdPbOZNj+tY93WLkj3fm8/9lJBuw/tEisr851wRmixCv2fU1kwaq
Pt6bbzTvEOurAhTm4heIqCz7qUlMTtFQAVhfUDB85CC7abwOoNQz8FUu/zt6jRd6
JWqbJqZrcpCAywGlullVb+lGX8301annOoi5KbiHngBNkSO1AsEhEzYweHFbovHl
l5Ml5zDNHbx+YdJidWROTCQNYMOGcbvSMKy/h4mdu8Of5W1/nMIzn8XXdjy5vV/x
33so/fOD5ZaGTqg/MEat84zYWDaFXaqr2uAWjUXr75+qeS0YkOyvb2uirfsJBTHy
0iPEtXkqB0nFHSm7BwGoZvaM5gc31FYcFPXKQ4czmGEllxgA8LoB2HsgTdlusrk5
AollJ9FioUibrbs0spmlx0W5QPA81L9GhKfej/G/mV+cG9GxTdm6MghBP3WnaJ1x
cuYJK/iwb58tYL/1SZYlRuU2lMZyBshraPIbmxQ40J58gFAA9NpTqBxbbjQKJxvT
eYDsAEn6sQhrsdHKCp3Z9+9vN55zwzy2B9D9U15xle4cwNdptSPnlMZs+X18q30K
ydnQG2lIGJ2V8zEEDjI3lVe2fRkgZPyB+TSdLwBFY8dGKrNxbLmWHIiXTE/64UF7
9gLpa+xA9sTBh0JscTNid6o5GnHRUX6TRtHLwCTeByE/FqlSefc=
=iZ5Q
-----END PGP SIGNATURE-----

--rMvzjH94yE/ZJAOV--
