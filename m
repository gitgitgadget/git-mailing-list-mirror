Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D8541B582
	for <git@vger.kernel.org>; Fri, 26 Jan 2024 10:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.26
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706265107; cv=none; b=IddKNYu7Ne/dXQNsdVIKLNBBM7F++bceUPunqW7uCISb3LW4f61L+aH4yIH4vWC0Xk8M392Z6gxaFRvhJrGhgrQD/nk21Qp+Sx94ioGs51SA/pNg5Tkmt7hdpNBt0PCOiCGenQukOScouUpkb1weNnjGx78ihRIZ8ax4/hfERZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706265107; c=relaxed/simple;
	bh=fdpXZTvbUVaFFfjZEDf5T9PpB6428W+0FUWxh8i75ls=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dlzV1e+Nq4d5B+rdldfizZMxVfz7VnH9afOm+egYqAWCQyp1HSk3Ob939bq9kOvVrAtRSTYQ3pfMCoRFTTfrigUsS4UbZ0L5eBZ7wido0fq7XrIs34HhOjMke4HjYgHgNXmZN3k87WcBgmul+9257CfvPbq3QEnq2cHayf3vfo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ESRStHCF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nHjK5QpR; arc=none smtp.client-ip=66.111.4.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ESRStHCF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nHjK5QpR"
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.nyi.internal (Postfix) with ESMTP id 655B65C0085
	for <git@vger.kernel.org>; Fri, 26 Jan 2024 05:31:45 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Fri, 26 Jan 2024 05:31:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1706265105; x=1706351505; bh=HrjVUcdA1c
	PPfAVRzg5Y04T7GcBWAY1weCdYg/YyVbw=; b=ESRStHCFBwO1rijSP29AinYcCO
	eV6KXEZVY9aJZ4HFzllmqGIc7SNnjEiEwjvnAIOgeABxSDJhVAnyp86W3f8NwNAY
	BjXG6RINVn+xLhapplTNfnHFSZfQCpLkHB2SaSKKYknkKzPexUQvbdKuxxPj2zMb
	9090iIj7ja2r4g8qzzXwGQkTeO5wl0WOnEI+3l8jTgXzeqdFhBl1E9nBvs+JYV6K
	2B9zs3fqQL2DR/RKXt105cAD35n1UhcCkyTaEmRWRR0bwFQPMD3pcJOXO+GvRswQ
	mwLOMMRLPi5vz+o1k+aqMcoA6ZyXXvFaivvap31EV/4O664Vl1lHQ85cwzsg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1706265105; x=1706351505; bh=HrjVUcdA1cPPfAVRzg5Y04T7GcBW
	AY1weCdYg/YyVbw=; b=nHjK5QpR/Px0XP0PxdMwMrkUTEb64edBLqMJQC1W+vlG
	6H5TohvIzG1qgL2g4hSNMRQAxzkuEvdd5w6NIs40udNbnKynLGVb1BLjNt24I1uC
	KHDoSog6XKz96ZO0yPIfIjfk9+jMuDqxyridHHbg+5r9yw8m0tCR5DgIE1M6Bm/8
	bWniTqq7Zg5qo1LmNow05vDTiTOlabWdRFoRa6c5HZtL0HqQ4vY4B94OeG9y712k
	eqWq4LI1WHktTmRV7uyLzDfmy+xhJzad+pyRyg5Qbp6WBOZMdnQI8mm8rIRdH1SH
	t7+76dwMvwxiELXqA0Uu1N0LU1E59i3KecGhcbSyaA==
X-ME-Sender: <xms:EYqzZVeFlRTdNbU6zYw14WvSWRq8QVkTgzOLOOC60y1snQ55ClCC_Q>
    <xme:EYqzZTMMoL-oJp005vP9qyXb64AxGKLvBzX6fNDwjUNu_7RGyc47xC2QD26hrmFz8
    rEdZu3Gel6KgB5C5w>
X-ME-Received: <xmr:EYqzZehbf9Kf9wxEmdY787OoNtdqLDQcOkQWOKhFt5zaUTsOQQXuwG4r80cjjJMZUD-b7hEHB1go4kOMNAjh8kXyrfDbv26nNQMgvHrCkJD98R1vAQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdeljedgudehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:EYqzZe_9jztu5SUaewyTdmY9McD5YUOoceAhzPeBolmGYSXGEt8k3Q>
    <xmx:EYqzZRudC1GiHOui6tv82ZyBpuC7jgir5gkho04W_0KbfnvEFFksPA>
    <xmx:EYqzZdHC4rB5zmqVs2SuTLZ_gv8RUW_lpYscvU1zaxqs3B6mXu2cNw>
    <xmx:EYqzZW5yWPs0rmTZDXyVoPK_Vb22cEyrCUx95y9mlR89YGkaYZrBgw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Fri, 26 Jan 2024 05:31:44 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 2acece6b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Fri, 26 Jan 2024 10:28:26 +0000 (UTC)
Date: Fri, 26 Jan 2024 11:31:34 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 1/5] reftable/reader: be more careful about errors in indexed
 seeks
Message-ID: <ecf834a2996f554aa046839dedb835385ef84df5.1706263918.git.ps@pks.im>
References: <cover.1706263918.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="mkn7AjpTvwCig03B"
Content-Disposition: inline
In-Reply-To: <cover.1706263918.git.ps@pks.im>


--mkn7AjpTvwCig03B
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

When doing an indexed seek we first need to do a linear seek in order to
find the index block for our wanted key. We do not check the returned
error of the linear seek though. This is likely not an issue because the
next call to `table_iter_next()` would return error, too. But it very
much is a code smell when an error variable is being assigned to without
actually checking it.

Safeguard the code by checking for errors.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/reader.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/reftable/reader.c b/reftable/reader.c
index 64dc366fb1..278f727a3d 100644
--- a/reftable/reader.c
+++ b/reftable/reader.c
@@ -509,6 +509,9 @@ static int reader_seek_indexed(struct reftable_reader *=
r,
 		goto done;
=20
 	err =3D reader_seek_linear(&index_iter, &want_index);
+	if (err < 0)
+		goto done;
+
 	while (1) {
 		err =3D table_iter_next(&index_iter, &index_result);
 		table_iter_block_done(&index_iter);
--=20
2.43.GIT


--mkn7AjpTvwCig03B
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmWzigYACgkQVbJhu7ck
PpSzbA/+MbF2K7KF+4uTVVqvqnyzddVXGAmcgaP9vSKFVCMd3NfLj71YBj9hdgwI
bYOdckMNAk4kjzDvq1Fxm5/TaYbUZ5ArTJaq7aQkJqDuJ8OZxxw9PqBnFRZmZlV7
zL3sYQMoAjZFnuRNLzXKPf7bWfc+AomX6FEjW/3Z7tzMPXXgx/nklLAa2WRLEnAJ
qpGoc5k2Mbd5W7AAjj2St3OVSRm1C+jF5TfjIvdI2XE8WQyQdLSP0oNeJkqTwXMm
78erSjCuDOn9MXjC/5xDcqGT8QfseD6Wxm7cOEn3Kvagq4loFcOo4mq09qMUPBzF
NZcCzNEFJbSVIA0XX96voSKyBL3ehzThSdUYWb0pcnc3mIN5qu1LnMmyvkWLtciv
6v13erp5+gKjfJkFn1H7k+42ShNGqy7Ki4rrsUt2rbk2L8M7Kn2UffaxyCzuW2MD
iU901ldsrxwTuECNcRWGXe4s2o7VRE7mkHGiCnT0s3iHxpofiu89GDfSFK5sfsj/
kFFbeF+vLlItPV1RCaPxU2G7UpuPcZWu2lwXnPoOzT+5whHyGKUoRJ3q5owa0d/8
g2s76UPe1K5sosFxAzujXEu/GLZHUFQ+3stu/pbHbx2jQNzdTu59PPVdroTNz+pI
7QtLtIr3ZL/VCiLwKSqcImU/UCNSnDtQRlteJ//54HVvoP1ZVKg=
=NTsZ
-----END PGP SIGNATURE-----

--mkn7AjpTvwCig03B--
