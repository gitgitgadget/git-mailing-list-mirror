Received: from wfhigh5-smtp.messagingengine.com (wfhigh5-smtp.messagingengine.com [64.147.123.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 385B7146D69
	for <git@vger.kernel.org>; Thu, 23 May 2024 12:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716467183; cv=none; b=XfcSnRQ0lLJ8qKyQP2HbHNvv22CCIiY2mlIEcHXZ0hzI6VroUvxufiwPSSB7QXbA3U9D1j0bUe9aUeNpUOzyjYUbVQ7vF4MYOfV26Ag2j86eXCUXBeR6XRifHhnJg5hGgnAbwhRMXl0O1+0iFaS63d1N2ObfHHCZM9wsVuk6Cfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716467183; c=relaxed/simple;
	bh=UGVsn6o+hMlmBHvbvtAdUpZc1+sfkPjqgsn3fNS/unQ=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J061kULaDbDS6pS1Dqm1SN0Avam9yxoRLQlcEMoOdoiWhZg7bK1WXTI3Bmon3H1DuPDGSEIM4iQKfBPW/xYpEpivXBAoH8c8gRgHA8fMwzHvHDqkYjErRgwfuV6upbP84OSEqnXURBIvUpLmmRwlpjY3QGsygDF5Lhwu8ZqWbBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=WE+YbIy/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fMAXRJDh; arc=none smtp.client-ip=64.147.123.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="WE+YbIy/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fMAXRJDh"
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfhigh.west.internal (Postfix) with ESMTP id AD7DD18000F4
	for <git@vger.kernel.org>; Thu, 23 May 2024 08:26:21 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Thu, 23 May 2024 08:26:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1716467181; x=1716553581; bh=sccGEolJYJ
	iHQxw0DZy3RGybHEYQmB+DWKrwtCrWUlY=; b=WE+YbIy/ziBA+qprzDZAwQuAqN
	hEuSzRwgSkUXscqy+uYaDTtyVQmqqHA7JySbIihfQ6kRTXtd0YWpic0BYH9GgK1w
	5KPL/0RJKIub6ufnnCD7/mH4ysr9XQ0J7Lt9+kS6tfUv4phI3IYPGPZKuaaesZtZ
	LkUFku2lO9c9F8rxICZQ6kXyCKgf9f1J8VyNdE3nJYauNm59Z6pxAA4XatLrm+vT
	C5MvalASWOoiueCQbrEAW088l734F1acM0tVB/VflhQoNGAR7dNlmWtnXHC6Br4i
	oD4r5XellbOZA8KGv1wgIxXEcxgEtAysfNiXV9OofwZMFzlFDuW8FNkC0QAA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1716467181; x=1716553581; bh=sccGEolJYJiHQxw0DZy3RGybHEYQ
	mB+DWKrwtCrWUlY=; b=fMAXRJDhEE8tP2TrjjbPbzl5rkjqgPF8EEIFLc/QKzEs
	9DTr7MTgXMd2ZaTd6U07cxh99vKzldgCr0Sv4GeYHKOg55MFTDXz07NGag86iktz
	iqLuk3mN1XVbveB9nj/PORVEHteCZgBHsgJGg9l25T8aIuEowmhctEsxsr+9fevm
	PtPmw9HiUPL/9/CEKMkrdtJCBsS/9vwljuMjqQn+AytjIyJBZMaSsjHj69L4wMOL
	AKG+1JRddpggZg95j5RsieJdpsMbCSDVA8iPK/Zz1ZB8F5kj5jpf/8h8bxzodSch
	Swd4l7UD1zDUVuwj7PepQZhj5JX95BPyNLOXspIrZg==
X-ME-Sender: <xms:7TVPZmtGd_BUWLMAyqxEQ0yKeijREr6U4_oCKC-Zieu2rXAKW_fJmg>
    <xme:7TVPZrc5p4jcOxUjvsIRErLUmYxVbAEqfrK3tlXWWBOJOhGs7mCfRpvhh7sT0BMKS
    klWBLS5vaXGD4I0fQ>
X-ME-Received: <xmr:7TVPZhxVIksQvGXYzmr9TeFQsTBcN3NxK8TZmHp-1fjjam0Z5oHDnKl-YmCaTLykMpntKtd0HiYnSTyk7Q3DN2LbM_nLvhlwRl8P4WMXQg-c_uLO_A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeiiedgheduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecuvehluhhsthgvrhfuihiivgepudenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:7TVPZhPRyNguk9O_T0AVOxnQ2hwE7dJp3PG2qOm64t06489oeUC31g>
    <xmx:7TVPZm_bHy3av8T-He5TV114aaJyaNmA0CL9rL7HkLBA5K830Ri53Q>
    <xmx:7TVPZpXE8OIfpgpcT7Szwftc86q-_EbEYx6LX8icV7sjShTK7d2jDw>
    <xmx:7TVPZvciG9MeSylqxiSQWSU9MwDsNIWJmdKgEJX5X0GCnltXYHW2DA>
    <xmx:7TVPZsnL08tzVoX1YG0wp7tPD6GefP35OBv7w3qMRIJTfOc_wWKByPJa>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Thu, 23 May 2024 08:26:20 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 4121c826 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Thu, 23 May 2024 12:26:14 +0000 (UTC)
Date: Thu, 23 May 2024 14:26:18 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 14/20] commit-reach: fix memory leak in `ahead_behind()`
Message-ID: <a11ce6a0edc5eb1ac29b4ccc3e775ac3501c4ce5.1716465556.git.ps@pks.im>
References: <cover.1716465556.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="BfY4sJXNNtp94bgf"
Content-Disposition: inline
In-Reply-To: <cover.1716465556.git.ps@pks.im>


--BfY4sJXNNtp94bgf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

We use a priority queue in `ahead_behind()` to compute the ahead/behind
count for commits. We may not iterate through all commits part of that
queue though in case all of its entries are stale. Consequently, as we
never make the effort to release the remaining commits, we end up
leaking bit arrays that we have allocated for each of the contained
commits.

Plug this leak and mark the corresponding test as leak free.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 commit-reach.c           | 4 ++++
 t/t3203-branch-output.sh | 2 ++
 2 files changed, 6 insertions(+)

diff --git a/commit-reach.c b/commit-reach.c
index 8f9b008f87..384aee1ab3 100644
--- a/commit-reach.c
+++ b/commit-reach.c
@@ -1106,6 +1106,10 @@ void ahead_behind(struct repository *r,
=20
 	/* STALE is used here, PARENT2 is used by insert_no_dup(). */
 	repo_clear_commit_marks(r, PARENT2 | STALE);
+	while (prio_queue_peek(&queue)) {
+		struct commit *c =3D prio_queue_get(&queue);
+		free_bit_array(c);
+	}
 	clear_bit_arrays(&bit_arrays);
 	clear_prio_queue(&queue);
 }
diff --git a/t/t3203-branch-output.sh b/t/t3203-branch-output.sh
index 758963b189..e627f08a17 100755
--- a/t/t3203-branch-output.sh
+++ b/t/t3203-branch-output.sh
@@ -1,6 +1,8 @@
 #!/bin/sh
=20
 test_description=3D'git branch display tests'
+
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-terminal.sh
=20
--=20
2.45.1.216.g4365c6fcf9.dirty


--BfY4sJXNNtp94bgf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZPNekACgkQVbJhu7ck
PpQVPw/8C4/qJDxumaQ/a7jF37eQVhA7Z30CNFXmH2OtsBUDGeq96o7jo979hLRA
z0Bl2MorfNlSLuZ+N49UiOA8ek5GQPjp9G7zew8kOL8H4J2yV+fB+FICUyoU7RjN
nscBFAd+CIe692JpcaQCvS7TG6a9xBlY+jBdiztRKV8u5f056qyxNdWwmDP75w5j
7TuYTTqt9wve9Z+gsag9Hn2p4efH26l5FoTYY8SE1chJDs2BClu1RRnEfigQd44g
c+4jTxEvQ63VcTw1ggYkX4hTMBS55cG2/km26B0JSI5zgkb56kFENg8ytylVz3QA
lhxtOD/utSy2wcM2KVruVlm7oNXdgwvJdJE1OnoIgjdZOLMxsHDEGd5n+g/uxuN5
KmRfzgOotXqTopd/Jl5lPpAOsxMe838B68U1cJPgaT0e4k4WCXP7YC74mlo0yUGZ
uxLAC1yu+QIaVx7L2Gp6Q8AGLcbchUZ8w0RglwsUOADmjNuaROIRf1BkFUI8C1HT
2VVDjHNxmhIvQ2VtCPaI4HG+Q39TJ9DL1XjG6qx3tfDIWf20QxieGkWiO/d8V2lD
UVc1KYCX6f7NbtT3n0KmYMweS1gsm2iiPWlX3FhFIAQP/Scz7ZUy55ZXfI0CA97f
vITb+ACnFoyBGWkYgpG580UKsgE25bqXxU7iu89brY7gvVFbTdA=
=vBnI
-----END PGP SIGNATURE-----

--BfY4sJXNNtp94bgf--
