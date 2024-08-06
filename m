Received: from fhigh3-smtp.messagingengine.com (fhigh3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8C311BDAB8
	for <git@vger.kernel.org>; Tue,  6 Aug 2024 09:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722934883; cv=none; b=s5SMxJU19CdEVJA36VEVG1vse8eY8dkAvPmoxbfZ9RjiJ731fU5kMDrDppXNZID5zXL9tT6E1/0t8T0BpSWnWmO6lzt/xgl/XWQOGA+8R+mKLpgGdzCMiXFH2E2dzz7WGhLPSqEHLMDoTuqEVgbezE0v8j4ISWWtTzXz5lvePow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722934883; c=relaxed/simple;
	bh=ZclYzd3Xp/pucf7u+yZFATP6xc1Arw/qfGliChDq4hs=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GrL6uB0jhQqP8QD+gJhDefXCa+47fGpG33hxny8vlRXddoYrj1F5bihw1VXaMdbI46yPVlUmiK8qvG6nurh4H12kGY++TmuHjMcVmksRaVhJMp2ZMrfrVrkZ0aTOoadFRi75pyDsAvMw1A6ezJJXlmrsx83iB1m3KSMfspi6rlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=NQGKRrYt; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=t+UIuJyj; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="NQGKRrYt";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="t+UIuJyj"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 1B3B2114FBD9
	for <git@vger.kernel.org>; Tue,  6 Aug 2024 05:01:21 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Tue, 06 Aug 2024 05:01:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1722934881; x=1723021281; bh=q+xAjQuWj0
	/Loedc3EqR7JDNyoDS8duca2E+AAj1z5A=; b=NQGKRrYt7+M7W2cDev5/F4rx5E
	IYtilMItyYMaF9YhSdm1dVRfn8rRi2xkXcBoNnjlqPZQoL8rGro05bNubFjr41rU
	fYcEmIpQTNpTTJwA8Q330tcZZTANBNhNZAYl/ruOpbSK/EeC4W9etdoE3wXU0Osr
	8+xLUwcV7Zvb888Xs+cVu2emMUsU9SSjUbhx4HmrFrIqEsPENac4qp9h90527e5c
	FwmKfU39FUn9F9edqeWB7/SHovKXfBt8Zl1tTF0Dg2dSrK4ED5DUh+nbWKrw/0ue
	wBSuU2stDgcCnt47fTWghL+lZu3a9WNObemC/9shRgrR/cCIGHoIaRFwYdEg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1722934881; x=1723021281; bh=q+xAjQuWj0/Loedc3EqR7JDNyoDS
	8duca2E+AAj1z5A=; b=t+UIuJyjxfilvtcCFqNeRTxyNnbPgPK9dVGUaBNshwoJ
	wz0e0B0rMSrYzbcmtTbfgv7J7eJ8HEVOkWhAnL+mMpv8Uk1d7UOesbQ3tJygZ0CL
	8fSjD0Q4TyzJESafjlQ1LA39dFcG1SvI5k9/DoLneWP46/jtBMkiZZ/xngURob+2
	AIJSQFcN2G9Mt4JS5JqwG69OB8i67pzXaL3NR6bBrXQmbHo0Ebf3GYAGi/kjBrJl
	cvR7dKcrICyB0iTAfiocVnfWmkmOLMxAz6lCyXC8sUABpwpgF41oLILOJkTKZWUN
	pqmEUIQ7Cc0ccT+Nh311KYcXE0nL90IEjbe33+tKaw==
X-ME-Sender: <xms:YOaxZgGy5x8VZsQ0gsiK_YafW7LPZG3mNGzaMtmUSczGzHIKnjLaIw>
    <xme:YOaxZpXMdf45Ap5afZGcNyPCSYNdaHrlrZV50RhQEG6VhEnrXixe73ONRpAxosI-R
    i4X7OVSmQXpMxaJXw>
X-ME-Received: <xmr:YOaxZqJRsvTNZ1KOReqQE2LL8fWnu9e5g_Y5Nxnyu6hVrCQWLbXkrP7APzsCoeAmbPzP6M-wZBc1IfximICDeV6CldqtdsZIvsD87ETfzvPn>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrkeekgddtlecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggtuggjsehgtderre
    dttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeehgefhtdefueffheekgfffudelffejtdfhvd
    ejkedthfehvdelgfetgfdvtedthfenucevlhhushhtvghrufhiiigvpeegnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedt
X-ME-Proxy: <xmx:YOaxZiG6f2cTnUopl-CD9rWMolFmzLxSfd_B3s7e3jVMAqmaphXYDA>
    <xmx:YOaxZmWqS0M0wVsvDCagidT4Zg_xmSbZIk5Jk4g4vCfj0IQojQVSVA>
    <xmx:YOaxZlPnUM7ITs74CTsSlFj6pH7kE-lMQ8o8jf7GpCSlZKJUdmNrcw>
    <xmx:YOaxZt2haDWXY9cbtqzXosO963kzAVGGuTrjkr_vAhkGwsKYkWacnQ>
    <xmx:YeaxZpeILS3sSXbGP9ahGpTMxUqcQp-doAdnRrMrVwFjax0Px-TeJ6WP>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 6 Aug 2024 05:01:20 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id f0362ebd (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Tue, 6 Aug 2024 09:01:18 +0000 (UTC)
Date: Tue, 6 Aug 2024 11:01:18 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 22/22] builtin/diff: free symmetric diff members
Message-ID: <fb525994043434be21c31bf0226056302f482f54.1722933643.git.ps@pks.im>
References: <cover.1722933642.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="pcX2/XYGnhCt6R3p"
Content-Disposition: inline
In-Reply-To: <cover.1722933642.git.ps@pks.im>


--pcX2/XYGnhCt6R3p
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

We populate a `struct symdiff` in case the user has requested a
symmetric diff. Part of this is to populate a `skip` bitmap that
indicates whihc commits shall be ignored in the diff. But while this
bitmap is dynamically allocated, we never free it.

Fix this by introducing and calling a new `symdiff_release()` function
that does this for us.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/diff.c                       | 10 +++++++++-
 t/t4068-diff-symmetric-merge-base.sh |  1 +
 t/t4108-apply-threeway.sh            |  1 +
 3 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/builtin/diff.c b/builtin/diff.c
index 9b6cdabe15..f87f68a5bc 100644
--- a/builtin/diff.c
+++ b/builtin/diff.c
@@ -388,6 +388,13 @@ static void symdiff_prepare(struct rev_info *rev, stru=
ct symdiff *sym)
 	sym->skip =3D map;
 }
=20
+static void symdiff_release(struct symdiff *sdiff)
+{
+	if (!sdiff)
+		return;
+	bitmap_free(sdiff->skip);
+}
+
 int cmd_diff(int argc, const char **argv, const char *prefix)
 {
 	int i;
@@ -398,7 +405,7 @@ int cmd_diff(int argc, const char **argv, const char *p=
refix)
 	struct object_array_entry *blob[2];
 	int nongit =3D 0, no_index =3D 0;
 	int result;
-	struct symdiff sdiff;
+	struct symdiff sdiff =3D {0};
=20
 	/*
 	 * We could get N tree-ish in the rev.pending_objects list.
@@ -619,6 +626,7 @@ int cmd_diff(int argc, const char **argv, const char *p=
refix)
 		refresh_index_quietly();
 	release_revisions(&rev);
 	object_array_clear(&ent);
+	symdiff_release(&sdiff);
 	UNLEAK(blob);
 	return result;
 }
diff --git a/t/t4068-diff-symmetric-merge-base.sh b/t/t4068-diff-symmetric-=
merge-base.sh
index eff63c16b0..4d6565e728 100755
--- a/t/t4068-diff-symmetric-merge-base.sh
+++ b/t/t4068-diff-symmetric-merge-base.sh
@@ -5,6 +5,7 @@ test_description=3D'behavior of diff with symmetric-diff se=
tups and --merge-base'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=3Dmain
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
=20
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
=20
 # build these situations:
diff --git a/t/t4108-apply-threeway.sh b/t/t4108-apply-threeway.sh
index c558282bc0..3211e1e65f 100755
--- a/t/t4108-apply-threeway.sh
+++ b/t/t4108-apply-threeway.sh
@@ -5,6 +5,7 @@ test_description=3D'git apply --3way'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=3Dmain
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
=20
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
=20
 print_sanitized_conflicted_diff () {
--=20
2.46.0.dirty


--pcX2/XYGnhCt6R3p
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmax5l0ACgkQVbJhu7ck
PpRZgBAAnOqMq/YQogReYdAmxJVio/s5yhqZNJ64kIKtf237DZhrXGpoNeIHE66N
MdQxJX3m1GvNCdf9NerbdYik4vq61i9DEKMsY/cweVap+9FxtPmAh3O5HELoSG6A
mec6PL9dR9WTVX4E4MCnN3A61Y6TnGoe9v+oRwUueyjeBVDlZ6giXZr2bif0JUms
hirMJRTnegUtYYIkrjWisVqFpt2Mwx/juaMM9ZZJzFYdNo4VypChgTWCVr0cWmCE
BL9nlNzBrmg5U19qy/O0fyDgkGS21EJJt9ebd0opOddiotmqm1dASiINKzO95Ag3
cqVKqdo98LegxspH+i1r+QRhoVL/U9VrgMe9jIW0r9TdZF/zKOoDqUVDyo4J/urE
7Rw7CgMo3XDdwGLMbjT0yEFLGV94phaX2yvMt+JeNDYFS+Az6usaPrQjL7wLuYRA
J3yPFEp6yjKf7+Raqn+aN1+D7f2jS6WNL+stpUCK1cWTIiwrWIMAqyHUTrzXJHsK
jfbHHYoztdOiGM9cpMAPl8O/GZsqHbmkgN72+Bnr2I1wzPjTsd+zkZBjVtCmX+tj
ibtp4SQv630Qbd/bcLgQI6G6++pYsDbRRlMpyu5GIrdUPCSlndBxa1geOW5JylYZ
2eh2+vrlrsglCMl/ZImVeNpAA0/g0va4nhgYZOpYVQfqG2m5g9c=
=YWB1
-----END PGP SIGNATURE-----

--pcX2/XYGnhCt6R3p--
