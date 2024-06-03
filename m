Received: from wfhigh7-smtp.messagingengine.com (wfhigh7-smtp.messagingengine.com [64.147.123.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C9F51292F2
	for <git@vger.kernel.org>; Mon,  3 Jun 2024 09:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717408066; cv=none; b=ZiYQNDksY98PwMr4ciGSL59qPnRqrnpQBdSI5ONkp34HDmBpKpwTRDs0Ubaf/UVLpq94QcZ0YeMyg51fHQA6nxjLRlxJSN7PsgHY5ZLS1sBGDZ+Is0z2tADDcaX6+1RLtokXj5p6j4JtLw9eiDRZRslPtqYfSqQ0+/K0ede2IUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717408066; c=relaxed/simple;
	bh=PpCm+XtWU59ASkrLNmbW/3aC7d2IdYxUA3Znd2176iM=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AWYSBAJL3ta1YPu8Haf5tk2CrUs5W+blV+ymfSdHU5Oe4469PE2xesHP/EJaToKCH0lJWpRAXnxT6ia1jpARdbVHcO6St1WpCOlGYjvcVNl6JmnrPTu7LUUWaZTu4EuhmXaMCU3dFqqo2DkQN6vfx0SX8sTx7KSkVTPvlooqpXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ByYgtZcZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QdFmxij2; arc=none smtp.client-ip=64.147.123.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ByYgtZcZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QdFmxij2"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfhigh.west.internal (Postfix) with ESMTP id 92CDD18000BA
	for <git@vger.kernel.org>; Mon,  3 Jun 2024 05:47:44 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Mon, 03 Jun 2024 05:47:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1717408064; x=1717494464; bh=ctMkIef9iA
	RCVpoYx1i0SjllqaHoXAJOVXVBBr3Tx48=; b=ByYgtZcZ0KGkEo6uXH9q3tE0tF
	ZjQnWwHQPxXJiyV+KO/OHEs3EHNkSZ0lQD3XVJguj/SRm3BpEYeJPyx69rWOgMfH
	IJb6njo4Mn6KK6B70DWpPmvQDSX8nWixJI5dwNsM7uuRLO8mu9o/PIumnwM/zvjS
	3/u4cWJlEMUg4Rb5RLAH16FiMiJOXK2oZQRsSwtWaz4TpKcfGzhS8+D4gi4EYzy7
	Sx1Urv7SEC9QxeheIVw7cA4++B1aYaPfW9e0VR3jbkaao6LR3ulcDldNUpYF0sV3
	WPxwx5Ilr0J4I4HDu8wakubH8DzrfIKsp4EYi4tmgBKhx6lRxSabGkz/8VdA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717408064; x=1717494464; bh=ctMkIef9iARCVpoYx1i0SjllqaHo
	XAJOVXVBBr3Tx48=; b=QdFmxij2MXt2RxH+hj1sWfweQM5MXEvYV6Fg9Z+JCj1k
	YJzEbFuqys0z1M1CuXUVKLeG/nAM/UCsivfijCJ7+V1mSN7jdWLZM/qHllpfdNGD
	DxrDRTbRxjjYIAJwOoF++eBz6ehWQselgst64uq7LB6uGvdtrv/q9i96EsqimdN1
	WNXymGb8Z38v8XArhkhUt2c9VCH2I+ToiELRr/f5upmGuu8dXhsuiKy267RhDNd5
	tfudfSSMJ+JW3+juOzkzXEO13Qjp/n/ZhV8wyoFPnFA/aEiygCIKWJQTaCHx6SwQ
	VGFASVfprryBF6iPrT5W1r8uRKFCF72vOPGW50GLDg==
X-ME-Sender: <xms:QJFdZtZsSMbaIXxHD13Bo3qEleqb8kyQcRW6FRr37LN2t67WI7IhCA>
    <xme:QJFdZka33K9ip6Rm_0VSA09yTePBkaONiZUTbdEM6rUYGNG2RKD6HoYduZVoXuEPY
    jeVofaDXfPMfWgfKA>
X-ME-Received: <xmr:QJFdZv9Ei81vnY-26EH7yJ74exWbYP6JhOg1ixl8tPSlbnddP_H0wUATBxvdX6ywWc1DbENr1vX1o07gjnFByDuHrqJuPeUv3GkbQLU-eXYBHpS3>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdelvddgvddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecuvehluhhsthgvrhfuihiivgepvdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:QJFdZrrmQKYEOFsEPOiEwvTDnaP264imFK7xzkwqpQoO5Bf7kX2kGA>
    <xmx:QJFdZoodqVQIT-ppYHoZU3TFyxLP_ALuATWksY9yr298C-mgmqWCog>
    <xmx:QJFdZhQsqmQGz92LqlWpr-vy6YtLnB97ZP6Sbj9EjrubjG_rqcXPuA>
    <xmx:QJFdZgpOHC0HvCvdLcPYHYjLfY6rMlhfpiVomB_76SqHgJ9Aro8CJQ>
    <xmx:QJFdZlBP5Lf1S_gGS5vIo3m2eiU6YfvNfNN-D2x_WqqZMbwcLlpdBmfY>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 3 Jun 2024 05:47:43 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id fa88d40f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Mon, 3 Jun 2024 09:47:18 +0000 (UTC)
Date: Mon, 3 Jun 2024 11:47:41 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 16/29] builtin/stash: fix leak in `show_stash()`
Message-ID: <8bde010d1d89fce2bbe45e7b136cae0944700419.1717402439.git.ps@pks.im>
References: <cover.1717402439.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="GcYLwc+iwgVRJ3R1"
Content-Disposition: inline
In-Reply-To: <cover.1717402439.git.ps@pks.im>


--GcYLwc+iwgVRJ3R1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

We leak the `revision_args()` variable. Fix this.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/stash.c              | 2 ++
 t/t3420-rebase-autostash.sh  | 1 +
 t/t3907-stash-show-config.sh | 1 +
 3 files changed, 4 insertions(+)

diff --git a/builtin/stash.c b/builtin/stash.c
index 628d848a0b..1ed0a9a5d9 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -975,7 +975,9 @@ static int show_stash(int argc, const char **argv, cons=
t char *prefix)
 	log_tree_diff_flush(&rev);
=20
 	ret =3D diff_result_code(&rev.diffopt);
+
 cleanup:
+	strvec_clear(&revision_args);
 	strvec_clear(&stash_args);
 	free_stash_info(&info);
 	release_revisions(&rev);
diff --git a/t/t3420-rebase-autostash.sh b/t/t3420-rebase-autostash.sh
index 1a820f1481..63e400b89f 100755
--- a/t/t3420-rebase-autostash.sh
+++ b/t/t3420-rebase-autostash.sh
@@ -7,6 +7,7 @@ test_description=3D'git rebase --autostash tests'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=3Dmain
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
=20
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
=20
 test_expect_success setup '
diff --git a/t/t3907-stash-show-config.sh b/t/t3907-stash-show-config.sh
index 10914bba7b..7a2eb98b86 100755
--- a/t/t3907-stash-show-config.sh
+++ b/t/t3907-stash-show-config.sh
@@ -2,6 +2,7 @@
=20
 test_description=3D'Test git stash show configuration.'
=20
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
=20
 test_expect_success 'setup' '
--=20
2.45.1.410.g58bac47f8e.dirty


--GcYLwc+iwgVRJ3R1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZdkTwACgkQVbJhu7ck
PpSEMw//dPaZdQ+32+Q3eUrGVEUVsDKrGhqgvFOtTt/ilEYZfnVTg/AtcuMn91Oe
wyFD99EjDZNdb4bVDJiqDGPSXjAN19IDPcQvzyafjMkZ2XwP5gEpVz4kvY4PWW/u
hx2DQ3fJ2fSPIYTwVMJiHIi+W8ZVXe/MunKvL9zfwcyu+feiVORSERoqZJ1UyYlu
1j9tKsnMVJM6uQzGK/YMeau+Q65yrFsRYZDwjmsZgjSMb43qIWBXXUuO4ZfA3f3r
uzVhSVDqyeAHFU+l091uJgKThyqqSdS3YHAJf2dREd6gWWGmMAhOJtqT0DfzVqlm
iGgYSEYSv3JzVe82ZCpqshnfcpxPU6CQvuO6icTgVuIFTJ69UsiQP9PQSF22L4xB
8TMdveqYT3Pz5H4hzB8CZ1T3+LafHopUoEntDhpKgy1b/LDJ9CFrzY/5D/OCFtLh
+hI4bhkrcDbJssCiqzaqot4hTb8KlWyXMq4yRAojrcuZ/0pjziFX3q9JdzvwJoJ6
iZok1AccibVGQllIyWVx3z9ww8A4M3rGZlKFspYCW46e+opwLcbJbIzgpy1GkXFb
ZpheM9B9fgnDkeGBzQaC6XdtM7uIBYMqQzOHH7h2ZOYPjoL/LDuma326DnQ1opF9
+tjTITZZPrnnNztFVgPPbcdhopNqOScaKGr6SejYR4BOC4nIkfU=
=U1zE
-----END PGP SIGNATURE-----

--GcYLwc+iwgVRJ3R1--
