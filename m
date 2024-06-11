Received: from wfhigh5-smtp.messagingengine.com (wfhigh5-smtp.messagingengine.com [64.147.123.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61443176ACE
	for <git@vger.kernel.org>; Tue, 11 Jun 2024 09:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718097563; cv=none; b=qKTorckFw9xhsgI7zkYzuE8fFMiZ6UQD11+gM6Bxx9WSdm1AkdM8tViHHEN0QSyct6mQxwQiIkE442SD47eXKwxlDFUKkvM5nCNp2E++1Y6uvjdHkkvseGphuWM8VmwRtxR39BTWJxDTjlljvxWngXhzCv5l5fvx2oI/OfMmm9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718097563; c=relaxed/simple;
	bh=06ZHgXWrevArChxjSCFhefx2BSVBtjnblN3va/fojXI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R79DfWpZLH5ElygLN62LiFbhfoOw7rfpxWyTxlvLpvT99ON2vd1E1Dup558zZXkoWrJANQgrJ6hHyJRoVH97wV44AlvS6wBYm/9DCfwLw9ClG0IwmFl6jHZirMB4P6pDJmGScGJDOs4cN8UDPzw+K/oNIJcFBxT79TrcVHIjTUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=IstQpwrj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=N/Im0kgD; arc=none smtp.client-ip=64.147.123.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="IstQpwrj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="N/Im0kgD"
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfhigh.west.internal (Postfix) with ESMTP id B10DC180012B;
	Tue, 11 Jun 2024 05:19:21 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Tue, 11 Jun 2024 05:19:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1718097561; x=1718183961; bh=wSLs7W7Mim
	xNhavTJNOzStgHa62aNkX4vfiOBGxstS4=; b=IstQpwrjvLmWI+eGsFj+ySzQ/l
	GZVQcsbPY2W4ZFp5QOa3u4/GCUcV2iEizy/AjMX2MVvCxRgMgiNJRzV4eiatrJJw
	8pEMQ2KVUYAPcewnXFnkDWNw5H2ExkG9rJKNIy68ALhxKX+SOCprJoov3uvG7n93
	ocvJWHFNUVFZAP5yxVP9iEVXpY6+pLjZbGuzrfOFAEqh2VEqeF4492hCKoA2GYjk
	O2YlW/sJ9IMAEMKjpjnKoDVq/6PftF5QgQ+Hk9lsUnCBuCuVWIuluuMZMZ6Be2QS
	hG8wE/fYzLk+fVpJDpU1L778RFb7yXSb1hM+PPYVhbU+KI4mhGFqpwwv1cIA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1718097561; x=1718183961; bh=wSLs7W7MimxNhavTJNOzStgHa62a
	NkX4vfiOBGxstS4=; b=N/Im0kgDXgrtSg1M9/vxgJ4EgLZguUEUQXiG/PpCCuYg
	/05+2U8l2TkOA2xxPA6XPsbis2Wh/mQFaKf9sc+l5G8YEU+5JgViBSF14x/w/VGZ
	D01jkMTBdiPwivvYgjM4BOJnNPTaBWGgO75j05DtaYg6fig6u0ijsOYg38N9ICT+
	heHXIrH8031QohPNrI0cmlQkq+UCLT3S3aiDoCMAmz65X5oJnBuR6LhSxorvzVF+
	5GIbNpLnRnoz9S8jeRRaN8fhtzebAnvIDZz0SYhdo+KJSQjq86kOk9sNFrR4MH8u
	AxoX+dhCMpReurUYEVbvNIfpc35knsPaX6PEBEZfZw==
X-ME-Sender: <xms:mRZoZo82K2MFK4-phm8vPhUvJ3CHQbjn7N1MNMdIAms6N1ao1oM-JQ>
    <xme:mRZoZgvRNKIpsAL-Fk9uUXGokplALywyp6wTxdOO7jBqghOJFLtum8H6Ry950vnYm
    TykiLaMJ847KP3ykg>
X-ME-Received: <xmr:mRZoZuA70buvIvSTWaqyoDkzCR96mor4tT9lHVAUr0f9W8F6w6HP2m53Zqz4pxHW2IQs7sHTNH9v5H33ZXHph648W3ovg2Q08OwRERFMiroWpOpsjiNO>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfeduvddgudegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:mRZoZocqRatQn1h2fIALd8LTZdjB0hHId3ZprUrOO5Sof1Mwibo9og>
    <xmx:mRZoZtMpYJPyG4oQNoqYKtyX70ow0Bx44uOBrOmV8eNX3ySlQoehAw>
    <xmx:mRZoZin97y70PGMcC3hngVXe6jEeAnh7VCODs5Kfs7QnXK6S9A1W-g>
    <xmx:mRZoZvsxC_xenGdyhLW5XNt59rsEq7Fo3SjVIIuxsf4XAusAYviRvQ>
    <xmx:mRZoZup-wQ4grcfIe-e3MQ_VFEvMTcZXIlQbVLnnVZo_NuByTf_RkJJR>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 11 Jun 2024 05:19:20 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 14755405 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 11 Jun 2024 09:19:11 +0000 (UTC)
Date: Tue, 11 Jun 2024 11:19:17 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Phillip Wood <phillip.wood123@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v2 01/29] revision: fix memory leak when reversing revisions
Message-ID: <f602bb5444b49058e3782e013fcec61ea486a16a.1718095906.git.ps@pks.im>
References: <cover.1717402439.git.ps@pks.im>
 <cover.1718095906.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Mi/M7GtjlLYiM4JH"
Content-Disposition: inline
In-Reply-To: <cover.1718095906.git.ps@pks.im>


--Mi/M7GtjlLYiM4JH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

When reversing revisions in a rev walk, `get_revision()` will allocate a
new commit list and assign it to `revs->commits`. It does not free the
old list though, which makes it leak. Fix this.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 revision.c                          | 1 +
 t/t3508-cherry-pick-many-commits.sh | 1 +
 2 files changed, 2 insertions(+)

diff --git a/revision.c b/revision.c
index 7ddf0f151a..af95502d92 100644
--- a/revision.c
+++ b/revision.c
@@ -4430,6 +4430,7 @@ struct commit *get_revision(struct rev_info *revs)
 		reversed =3D NULL;
 		while ((c =3D get_revision_internal(revs)))
 			commit_list_insert(c, &reversed);
+		free_commit_list(revs->commits);
 		revs->commits =3D reversed;
 		revs->reverse =3D 0;
 		revs->reverse_output_stage =3D 1;
diff --git a/t/t3508-cherry-pick-many-commits.sh b/t/t3508-cherry-pick-many=
-commits.sh
index 2d53ce754c..afa7727a4a 100755
--- a/t/t3508-cherry-pick-many-commits.sh
+++ b/t/t3508-cherry-pick-many-commits.sh
@@ -5,6 +5,7 @@ test_description=3D'test cherry-picking many commits'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=3Dmain
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
=20
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
=20
 check_head_differs_from() {
--=20
2.45.2.436.gcd77e87115.dirty


--Mi/M7GtjlLYiM4JH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZoFpQACgkQVbJhu7ck
PpQ5RxAAkQSofzI/TtrBSkC8o/jpYHlKTW20F9fos2CDnRyT1rOJebDpYykVzX3i
MUcuGKkPCRuxxWgngiWtTZoFMgQl6lg7l6SXKfsxEL9HkcSZ0QIK9mbHHOaT6TWk
lxRquoMLhrBOundhgr0xlGuidtmLi2yxBA/Sz885fJHzUbbRVXSsgOuFrnm/9Bpu
KYgG2YqHF+oR9qQmAb0u/LCOhPitFWTBr98bMVsm9TzKNg/fB6ZU77uuezW9uYq0
X9Zlu4FjrG1B8twhDqNX42hsWcXamNbKomxzkw6ozpR3uPpu9wDKO6OySqcHqu4D
+cViD+0H21Ape8mgrBj1brDYiihtXrlO8k+QwliNaAsrP4mFJBkiOVXCMjPUT0P9
I0bC2sEncpzjTpTdumV8+5pJvPssy6DAzlhT0eGS0LEr1/JsZUcmndnapyFdzNgT
6WyTyhIaFpWGZM0N5bA7BXrJJD0KWUEQQmxj7N8pAdb0cEqWEW6Dl9zyKM8wLtai
m1WSLcw4rE53AzLdGrYY30cEriPEgkXC9+cyU/AD3+q3C4DhykhEdwaPruUr1AYN
nLnOnh7XJoIAENtzi4/2Ohujk7/LcoOMuIfIgKIQvXOnUAU3I6KQvzj4LXck7U+x
qD5Ph9LAcejNGsbqg0ZAHOrmmZSSs7lUdQ7YL+HlXtohkow6qxk=
=Ku8s
-----END PGP SIGNATURE-----

--Mi/M7GtjlLYiM4JH--
