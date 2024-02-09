Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2292365BA6
	for <git@vger.kernel.org>; Fri,  9 Feb 2024 07:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707463404; cv=none; b=FECh1pBbVdQ7eQdRuTK6FLMpcUvFX5g/VHDVhMDiq7Wxa13lwAoqfibSpr1wBqHBaDaQHY/4RoHXCsW9KucNPPXB26Bpx1lfFhZBJG35Rkip/jRFllaD2dSxB4qu9IYnWYOLl8J0gkKVtMpF0JPDogoxdBVSqekuVr/eksLlSKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707463404; c=relaxed/simple;
	bh=cIGGivZUOTOAsdXUCX5xfP57ESqBUQpSzCY3J96xxzg=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KodgMMLbVzdF9E6MMhrlBsw7quzYrhGocu305jRosoj5lXj/uyI+rqO42oBfdgG0OS7id0FFrMmq3hIDyOgnlN0te11O+T4nZLkuvMyTJu9WCy9J8y7GOONsx0jS4eZ9I/ccriOB9WGQ8NlzLVW+UXeCC+B6+Z14/Mk1iV9siSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=EyYDG96o; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=i1hhkDJV; arc=none smtp.client-ip=64.147.123.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="EyYDG96o";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="i1hhkDJV"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.west.internal (Postfix) with ESMTP id 51F2C3200A9C
	for <git@vger.kernel.org>; Fri,  9 Feb 2024 02:23:21 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Fri, 09 Feb 2024 02:23:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1707463400; x=1707549800; bh=KpMF1qlFyO
	E7YXi633QcknyHhIUv/RQ6NP4bMcXHe4k=; b=EyYDG96oZ+oiQ6b581JmWmQ9fW
	U/MarCnY6w4j7tq4zNXS6B0w7rkg/wdyARMaQZQsaEImH9J/A3XHhL47YLZiKUjf
	8p4YDwuXqf+0u1CCWiGFsIlHNk8yJ17q+ywYPHPCpNGs1De5FRjthReDJtx9eFuG
	U3U/iMf3TQzfiZdBoQlk8WzTgr6n3GlEKu4/mx544NuGLH1EhgdKfECuw1mAxNSc
	vXZnYxARq2qGMi2a617yfysAVEcC5k3rsOTdttxmDfwDnCw0RU0cWMzU5om+6pkk
	V65mRjdPOo4qOpKs0nJu6vasdlZYlpikXvjlPXsKlgT+My0ozRgBJyn4vBTQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1707463400; x=1707549800; bh=KpMF1qlFyOE7YXi633QcknyHhIUv
	/RQ6NP4bMcXHe4k=; b=i1hhkDJVZllUeNdHAvWt4SGh68Lzwcy8YdSuZpdPQVnA
	3Z9Bh6DEFkTfPYwvAhYV+q1+HN/IIupNXOyKiNMk9EWRdov13fU0YqBLG/yDYKGy
	j7ZttRP48aAspY23ETKXvVnMqyIY6Q2ZyClVnqAxrhGk04DAUdbgqMzqzPLfYCtF
	6PVPbtB3MmqiWJ7psyNzag41V49pDt2Gi2VzPI0Gsx4EZ/ace95ap1t7EIt3OnLO
	jlLW1nYVz4CgsDee7B+z4hytrtqQDA4WQj3X3w+BFISW0G1Isl0UaI870XVVdJxc
	nxYqPKrBbhvY8g+jfTsyVBcl+7+HxAC9eiRMyFPsYw==
X-ME-Sender: <xms:6NLFZcnQVpbJ8OG8vxK0I-s5lTHQVBjDMD01GR67lPwKv1BphsRWTg>
    <xme:6NLFZb2XzRH3aIwfwkInd7mH1bntJ1Acb2RXdeceRcA9xval5Zlf5XS9SXeRGB9-Y
    n-26bTj1ow67eDNNQ>
X-ME-Received: <xmr:6NLFZarBeQpGzNm3m9iJU09sdMQgDDa_OswTM_zzLOS14Uke9mv4nluvQ0qXZly3C1gsAVvmh2zgUrAyFOxuOiUk2jtlIB1M1CQccscvUOAxd9U>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrtdehgddutdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:6NLFZYmdcRNa5MHvzsS_juTbegDp6s36kXiOj2FCdrI0inHd4TT7WA>
    <xmx:6NLFZa3teJ9dmbx40NS9uiO8AY49y2UqQrosiBXtyMYHTF543pq_fw>
    <xmx:6NLFZfs8aS79CAhhPMR_BOPQNfpPrJqr2qc1DJV6Vvt5ZD9ppQ931A>
    <xmx:6NLFZf-p2bS0DqXalVj2ktjTN-jpi--8c8EqjUa9HSj7l4XQXOGcUA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Fri, 9 Feb 2024 02:23:20 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id b951426a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Fri, 9 Feb 2024 07:19:44 +0000 (UTC)
Date: Fri, 9 Feb 2024 08:23:18 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 3/7] t1400: exercise reflog with gaps with reftable backend
Message-ID: <9d8eed354ee3f0c9f66c22d92afd4c4c80f102e4.1707463221.git.ps@pks.im>
References: <cover.1707463221.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="D9gFv0dhVyBD9j0i"
Content-Disposition: inline
In-Reply-To: <cover.1707463221.git.ps@pks.im>


--D9gFv0dhVyBD9j0i
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

In t1400, we have a test that exercises whether we print a warning
message as expected when the reflog contains entries which have a gap
between the old entry's new object ID and the new entry's old object ID.
While the logic should apply to all ref backends, the test setup writes
into `.git/logs` directly and is thus "files"-backend specific.

Refactor the test to instead use `git reflog delete` to create the gap
and drop the REFFILES prerequisite.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/t1400-update-ref.sh | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
index 3294b7ce08..3aeb103d34 100755
--- a/t/t1400-update-ref.sh
+++ b/t/t1400-update-ref.sh
@@ -426,15 +426,15 @@ test_expect_success 'Query "main@{2005-05-28}" (past =
end of history)' '
 rm -f expect
 git update-ref -d $m
=20
-test_expect_success REFFILES 'query reflog with gap' '
+test_expect_success 'query reflog with gap' '
 	test_when_finished "git update-ref -d $m" &&
=20
-	git update-ref $m $F &&
-	cat >.git/logs/$m <<-EOF &&
-	$Z $A $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 1117150320 -0500
-	$A $B $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 1117150380 -0500
-	$D $F $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 1117150680 -0500
-	EOF
+	GIT_COMMITTER_DATE=3D"1117150320 -0500" git update-ref $m $A &&
+	GIT_COMMITTER_DATE=3D"1117150380 -0500" git update-ref $m $B &&
+	GIT_COMMITTER_DATE=3D"1117150480 -0500" git update-ref $m $C &&
+	GIT_COMMITTER_DATE=3D"1117150580 -0500" git update-ref $m $D &&
+	GIT_COMMITTER_DATE=3D"1117150680 -0500" git update-ref $m $F &&
+	git reflog delete $m@{2} &&
=20
 	git rev-parse --verify "main@{2005-05-26 23:33:01}" >actual 2>stderr &&
 	echo "$B" >expect &&
--=20
2.43.GIT


--D9gFv0dhVyBD9j0i
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmXF0uUACgkQVbJhu7ck
PpQEbw/+KN6TXEQ2xOIlUb8ZOH9OmRoUsUBZDPloqmlJp5636eDet/pvcc2bQQPw
Kv2rFoFmxF03UZHO0y/h5EysMFJDjx6f227/i3QIX1lpjtC28iF89di+BadDCKXk
ryyiym7Q6krAqAQu0YsVchA+3dhe6tbqb1ThodHI1n+MKg5kT7FqWOTfTIiizqin
tPmLbR6W4i1MintpwyEza5+KuOHNw9c3zIaydUv+tLNlNXg0D6vZR8QyRVzLd/0j
V07C1HDEupj1qqqC+38KW6RmnotGFsHk9G96QoZct+9y97J9fHg1rHah4E99ihKS
pSbOrqs92k1E61U6DLiIPsnRsZwZDlnjk2FC/clotcoriBRBSuTYIlyDjK7h1OS+
OrbiaK0ehglBKWbSBoGEhm0Eq3H2r9CE5VZDuL5iDSkEOtjs6lIZu3jnUWMtL/qZ
AY8K66fsOGiU7vbLlzXT9QddXVDnC5+rg5nt/VTb+MjCz3yufgsIFglgJeqduWBW
hUUMI7sx3qsROQkGMY7bctTXg0/ffzCyC8X8tpOgebdlD4t0whmYJplx+z23Zf72
Om5qC557vcycO+YCh/382+QTW2e+mGsefHTwzTIWGen/40+IB4sBEkdUAvMevxxT
2Tg7G9IRyTteCS0D8NSg4thEaFIuuHm/BtcZO5pZI36Tb2potJc=
=JWA4
-----END PGP SIGNATURE-----

--D9gFv0dhVyBD9j0i--
