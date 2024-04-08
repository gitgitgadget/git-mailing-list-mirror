Received: from fhigh3-smtp.messagingengine.com (fhigh3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 712B12C85F
	for <git@vger.kernel.org>; Mon,  8 Apr 2024 06:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712558811; cv=none; b=uqHvbWe6+t1AfcfAYeYU+HmSwAuimdUoc7Z21ewrOHcUJd0R/c4WfcDtSV0MQbrAI/8lhWrFfek4B0t+1WTzh5qsshwCWK4TFZE/Qi8fy7+jj4/otiTnksJPsZ8fY07XlsftwsVoA2Tm2kiHz8fyOtXjuKmz366J8BEKueKOWSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712558811; c=relaxed/simple;
	bh=Yk1Jbuj2wauZGkBDoO2CcMrPAJumAk3xNmRqdYcaejQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PzhOql1BsMevM4+PmGmHipoNckVzVx4CBT9pRLecOaPtQo2AYEWDhoR6BFuoOUBz+qCc4cnuq7yCCsdMPSp/CkEFh6eT79cFbUyGNaMYD6/WB1nKYF424pRGCA4+XP1foVpZ5YUxuNHw8D9i1sQpZ8I1flgtpt+1zJ2EuSdvYqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=O1jfcjmD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=wsc5DkCg; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="O1jfcjmD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="wsc5DkCg"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 7D54611400CE;
	Mon,  8 Apr 2024 02:46:49 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Mon, 08 Apr 2024 02:46:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1712558809; x=1712645209; bh=j53eWXgYvR
	UQ6aa3gp7gJdU8Sm0tjaI/Mxcz6ZG1Z4E=; b=O1jfcjmD4TTt9WImzVEbwbHi9Z
	x7od0TrJSKnS9cKKDK14OfOpBrD9tXPu+gzWRVA7lX8vnJH2VsLucasHmdd09v8k
	a6hQNl47ES9CYR9U1udYRBB/DcFBTRG08VHGgM0aKgA5f8yf7lKn1QqJq9BDCthj
	17byfgXe9FRO4aeRaLXWhs/uugqngEzA/ag4nkuHAmJOF9Nj42xpi2jVdFUsi5H5
	pf2pKhti+/bkq912QcmAxMEHW9cTq5SKXLeNep+hc2GLsOouXASsI6kH/iqxeo2d
	kvWn1qRH0PGVe0JccEtqlerptHgLvyrUO38cQ09qWXp9zyx7JwnJ2cO5vRjA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1712558809; x=1712645209; bh=j53eWXgYvRUQ6aa3gp7gJdU8Sm0t
	jaI/Mxcz6ZG1Z4E=; b=wsc5DkCgTOph2G76mkLoeJ3PfSlAyekbKzNYhe2wDSo5
	FgdfpywuyJ1peT53nPnbf4GxSuriwFW/dUo5zsb/abRtTPdO/GxH0zcu0ar86YwA
	+F0ScipsX2krRkTVM+B225wjK/J+1Jqpilpms4PUSI/GMsEWJWrdoX5+i/h5fxil
	3Of7baaR49AOg2k6sLEnllUUfjp+atdkGqfUcLiderQl5pdPRqskyAf2rBHHjcmg
	67MaLLGiavZLwWzLYsGWs1Uv4mcJCwOZ2J5ccLIZjBTAeUFwZ7dZpnM+oIQPR6ZT
	JBkkmnY0WNpoW7s9foaElbQrttW2UiUIfdj470Nnww==
X-ME-Sender: <xms:2ZITZpRiVhLjtnKlikLam1XZp8emCzKxyO1TvUZoFsgVHwwnmHxNZg>
    <xme:2ZITZiwNv-vfbFkHnYcoSGU8tzR_CsiqWrvKb-ql2tF8UTo6_MDYby1e0l-mVaROn
    P2E8jwsFaP2Lx55Lw>
X-ME-Received: <xmr:2ZITZu17HkpUI19PiEj5SKk3If-TheBU3ce41WkIUiRt8QAFvloZTKURBCNvIpNkQ0AY-A-N5BWOx1z_SOoekuNxCsnUyEbrHMTI1_i0ntX9CW_Gug>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudeghedguddutdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedvnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:2ZITZhAesfsYDmPSRs7iWkNggqSK8rzqiB2ZrVmIg0hOpiTGBuXbBA>
    <xmx:2ZITZijxbx4I9NdD8P143RaNdklGv4w_KDyfeB5wSxABMtyT8OO3FA>
    <xmx:2ZITZlo6GgoqhBbyJ4IZRzEBGrYr9axm7-Kv7DVurAe7VLwC95285A>
    <xmx:2ZITZthFLScMM5zQrzXsSLVHExUTxjSevvsIh7xtShjoQR5NcqemrA>
    <xmx:2ZITZkYyayLwxn646SmEHcmVMy3kmz1tgG93vag7__Xcx8hid-mkiC2b>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 Apr 2024 02:46:48 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id a57d301e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 8 Apr 2024 06:46:42 +0000 (UTC)
Date: Mon, 8 Apr 2024 08:46:46 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Han-Wen Nienhuys <hanwenn@gmail.com>,
	Josh Steadmon <steadmon@google.com>,
	Luca Milanesio <luca.milanesio@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 08/12] ci: make Perforce binaries executable for all users
Message-ID: <5240046a0fe604efa8840d023df4833c12bad952.1712555682.git.ps@pks.im>
References: <cover.1712235356.git.ps@pks.im>
 <cover.1712555682.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="uOhWPpdaWdBs8NKn"
Content-Disposition: inline
In-Reply-To: <cover.1712555682.git.ps@pks.im>


--uOhWPpdaWdBs8NKn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The Perforce binaries are only made executable for the current user. On
GitLab CI though we execute tests as a different user than "root", and
thus these binaries may not be executable by that test user at all. This
has gone unnoticed so far because those binaries are optional -- in case
they don't exist we simply skip over tests requiring them.

Fix the setup so that we set the executable bits for all users.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 ci/install-dependencies.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ci/install-dependencies.sh b/ci/install-dependencies.sh
index f4eb125fd2..068c478025 100755
--- a/ci/install-dependencies.sh
+++ b/ci/install-dependencies.sh
@@ -47,7 +47,7 @@ ubuntu-*)
 	mkdir --parents "$CUSTOM_PATH"
 	wget --quiet --directory-prefix=3D"$CUSTOM_PATH" \
 		"$P4WHENCE/bin.linux26x86_64/p4d" "$P4WHENCE/bin.linux26x86_64/p4"
-	chmod u+x "$CUSTOM_PATH/p4d" "$CUSTOM_PATH/p4"
+	chmod a+x "$CUSTOM_PATH/p4d" "$CUSTOM_PATH/p4"
=20
 	wget --quiet "$LFSWHENCE/git-lfs-linux-amd64-$LINUX_GIT_LFS_VERSION.tar.g=
z"
 	tar -xzf "git-lfs-linux-amd64-$LINUX_GIT_LFS_VERSION.tar.gz" -C "$CUSTOM_=
PATH" --strip-components=3D1 "git-lfs-$LINUX_GIT_LFS_VERSION/git-lfs"
--=20
2.44.GIT


--uOhWPpdaWdBs8NKn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYTktUACgkQVbJhu7ck
PpSyuw//Qggh84K5UYFCmLIoWwfaOzUcb6zFWc8VfCYF/l7JRlAM5mOo+q/5Gu3m
qWRUH+wlDK9V4TdGqkyJQIdlQhCyP3npjY4SZxxFzkJpO5DTrpgKsuviEelDwQ+V
SFG1rn34js74CJZCCumTacDuuIkhUktZRBP9z0vB907WGxOq7ZBvvdj7jyPKwAa5
BIQZ4BILWfu9tAKPRCRln8BkH0mME4EDA37UQOuyj+LH1jmvl91Le4KFsDAJ5DPy
9IlpJ0vLFUMiBNNeSjveqbLeRzlhj14bCYXnqtwgCoJ3vSYbx+YEpbRdn0YBEESm
iIjCT6mOh/eh8GDz3COsPuCNPIEG8ZE1OKiTZUoeABboV0twZ/+mJw/juuSVuVmN
l42kGmFgpWVTm9s/EFN3nVQyCWwUsuewLAeBYPX9STIz359eDDazdAX/SpZb9XOH
MXE2nriaXANIDkjOjK44UCK/rKhgFuxXyb/DKIuRfIkxUjnaVajwYi3FE9BI111V
s+jl+gF9v+PEZBvFSi4y2+HDCtOhYxSUJwvCH2l36Am6WalvH5kTJHxXgXowwgIY
Qg8ok7pZ9OBM9BuYIchCPF6x/eOVNugsSU3dRND7vpl+PEEuGyQTr6Xc6qSsnOHT
C/v6vQZ6b7wrAu6Gs42hf4ZyAljJeWlUuz7/XN4QtSkMSIPsDDg=
=8aDS
-----END PGP SIGNATURE-----

--uOhWPpdaWdBs8NKn--
