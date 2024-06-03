Received: from wfout4-smtp.messagingengine.com (wfout4-smtp.messagingengine.com [64.147.123.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23FE883CA3
	for <git@vger.kernel.org>; Mon,  3 Jun 2024 09:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717407994; cv=none; b=OOMRMWoL6KC2RcFb9lDkBygKxmdy9EM0h3AFINzYckJVvXtKT9LAHYXGc4knz2uYx2+bt5UWxIg/luuiGmMf/sLO08mZpFn1cfWJUGIf33yqo6SWwo3GABIx2ERM6rxjHE858PW85J1FdAuuJQ8vAfKh+gyS8mtWmdqM/oy490M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717407994; c=relaxed/simple;
	bh=/dnwZuOB/A4DIzjvJJ7SkQMJd/XTxb71C5AKxoI8tBQ=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cghXgJOHimB3Ot+0tjLnRGGAtRiqY9zgJqrh+65CJm/lFZ03NGSBrcjqIeeZXpsQqHZ6s0mbgJqdLMPuDqkEWhQA+1yNvt8VL5SysIGFF5/PHhs9uYhneKiLQVwJeAzGfUpKOyrWfkRFgCMalEFQZwBE0wBq2l868pRYa9TJ1KU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=DXl7e2Ir; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=b6NGDJqA; arc=none smtp.client-ip=64.147.123.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="DXl7e2Ir";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="b6NGDJqA"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfout.west.internal (Postfix) with ESMTP id 654F91C0008C
	for <git@vger.kernel.org>; Mon,  3 Jun 2024 05:46:32 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Mon, 03 Jun 2024 05:46:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1717407992; x=1717494392; bh=GxY8rSieCA
	mV5WD5J3JMfCUW2wA1CZVJtX3aLCc+9RU=; b=DXl7e2IrNiDOPn78M3M08RHxAo
	00NfckmQa9th9Doyd1zgrUE8wKrRGZXeX6a80HvA3Va7H+z9v4800goTgQ3KR+j3
	GBs+9vCdt029YwCzOgnImpbwmLV5P3o+OvMF4BE+GuvE0z1fpVgUiu6SygA9Zdy/
	NfnOxzodMMgHFYNnMZWF/Icz6cv99/LwVw4FI4N7p9uuK4/5cKO3gBQf6VqgCQCU
	TgbQKO1eGeq+cAVKE8H/2JyUTsexwr0L6B0r4I9UUWQBOsVMF9zH4CZZLLd/A9Eg
	eI5q6QSoKVQF/nGinBEnJ+EBQSLioBbK9ACAjPbiQJ6TCkfFwyC/BXUWCbnA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717407992; x=1717494392; bh=GxY8rSieCAmV5WD5J3JMfCUW2wA1
	CZVJtX3aLCc+9RU=; b=b6NGDJqAQvwkeLOH9Ha6XjXoFV/WhjpknPa3m9uH3bhP
	e9IZX1kN9LSs3w53Y0nMkU5bRK6gKYtWLcbMnZ66p/JoDUPZtqthyfILyTjc/7CM
	YsUDqnmTNBpUB8J4drIK/+yf7CL3l/IohpyCiyn0N0wWyOKLhFPqb2jeXFuoAqyJ
	0o2LDYuhOejjZM4+3JZJTSXE6Y1+CzNmJRbwg/t95hmGcO3A7U3zcL9Q41MpWmhb
	7tqFwOp7PHByz0fbh/PMf9K6WXV/m2SBBQ6L9IzZNw2WCHk1gx0eBKgYceeHBRtf
	URKrnFFW1tGbPF5adTJgvWOeY/l3u1xqXOveUY+qSQ==
X-ME-Sender: <xms:95BdZkW0cU1vPYuGEc03wkkrYC4mnC_US70Yx449NV5T4B7oAMnvMw>
    <xme:95BdZonb8W5N7tXMFOT_C_jyS0hozVbhKhNYaxSXDT8iK10_gHvR2ZuifoGqQ5ZGu
    OJZnVZtMVpLwKFf3w>
X-ME-Received: <xmr:95BdZobn46-DcuwSByJgjTse2xmqLF8guDD7b6t83BLrKMGruaPZsPpmaLxRmxR-tiJ__DBQ-lxPVq6d2Ig0j7yzDn8CpLfIu-hGYnmxWNZwSJhJ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdelvddgudelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:95BdZjVkd46z0Xre9kFjL9BGqcsT3ETkhWksKOPrgGR2U9RPgavaBw>
    <xmx:95BdZukM_X8f0S4DBZsqfit5jtzijCopMVcjCdP6y9tOVOFGD-Td1Q>
    <xmx:95BdZodxCk7NDbOGaagT-5LM55Wad05I8a-2uv4KYnrjKbf-1iuM8A>
    <xmx:95BdZgEyg8nP7WDDidyW0fK6-e6BRAQkvXyjoDhKtYDdiMyfCKCTNw>
    <xmx:-JBdZivhoAZB6mcY724Wxa_3CKGU5fNF2GJX-JwqOEFkoKOOe6m-ICLX>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 3 Jun 2024 05:46:31 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 7fd9b776 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Mon, 3 Jun 2024 09:46:06 +0000 (UTC)
Date: Mon, 3 Jun 2024 11:46:28 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 01/29] revision: fix memory leak when reversing revisions
Message-ID: <a88a6fa266696e1b7ce0a5a10edd04d0c52ea912.1717402439.git.ps@pks.im>
References: <cover.1717402439.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="886tQWh2lTUEK9KL"
Content-Disposition: inline
In-Reply-To: <cover.1717402439.git.ps@pks.im>


--886tQWh2lTUEK9KL
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
2.45.1.410.g58bac47f8e.dirty


--886tQWh2lTUEK9KL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZdkPMACgkQVbJhu7ck
PpRI8Q//b2UHwly53gQ8cVwOH/CXaS10xHjuz2ecS4Nm27BoHGqxIR2D3PntzfgK
5kYTvjow92Wjwi0Kvyutp8rsIxLjzcHVVuTbxLht25m8n6ygOaxCh4YvPA83osaU
v3ARbif2uFAEo/f+4PmPdAnJW0COvHyO50SDUoYfR7hjflUrPbq48rJvbYugVU/v
Js62uQbKY/3jtjkyxuQPAI2vTcHj2AyL5Kt13eDRSxDnhtVRD99Mpxs80NEwxKWl
oQeX2fMRLM2mjTGNK+UCFVNlrS83fs50ahnDhi0tSNf61p3WcJWT/cFqkr67vhw2
uqIRwR8jMs/Wlpa1VuYPH+sc3MPVhk7SkQWlfiVzYWC+jXBVlOHkiSNdY/Av9O6u
5hj+tuWrofiEtcax1KGDd56AdO+gls63XVyV4z0l6bJj8lnm+fBZOCB31XOJPhtf
P6w9L4cgi2PMi3ov1NVxZ9Y6ekEjg7h/bhtuktbmEX/wtUOMsman5Gmtw8UV0Y1m
9/CUig8j4d+lF6XtgtP1sM8ZPPU7ZxYXWvcowgDqs+TMu+IEW42tou37oZ61krBd
BE16ln3oJAf+psQmup1vOFAaQTXJhPw8fvFXDaeCvLGUUXCNuvlqmBdP1AyS5h1v
9og+/pF/VwtFW3BN4aSXy0ApgugIL30An6vU0Kznx3rDJ1w7VK8=
=4eU0
-----END PGP SIGNATURE-----

--886tQWh2lTUEK9KL--
