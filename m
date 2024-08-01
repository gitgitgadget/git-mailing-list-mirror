Received: from fhigh2-smtp.messagingengine.com (fhigh2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA425187FEB
	for <git@vger.kernel.org>; Thu,  1 Aug 2024 10:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722508852; cv=none; b=V5Xa+Sg8oPcNUsf4jCf2LWyG2K/dr7YSFc56Q02lU106n7tPkjz3/DoXnjh32TKOHlQ1i1MoVILccU40ifMNA/M11v5B3yT3p1dnV/jdbT4DgG+FZwA/3SabO3Bf9LZ5DdUSRgsQp6iA/GIk+E2eZxciwUQrMT/zEWB621ef+vE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722508852; c=relaxed/simple;
	bh=o2ka25U3SOcMH+osajZ9PmBXhf4r07hQM/Zk4hnsMNc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KzKZ9embf1TOf1FRT+W+9KfjRiuHW2uo9lxIEdhQi4c6La9/gMLEIAyCdJfuFq71qy3dW0Cg13ddpa5cym3yAAn80g7VnCmT7uCE6NPn1tCXSBnHf75UCIFRN2V6JuT+0ITfQ2bD8QzT6TQjeR7qF26H0papjpIym7pBDVtnKE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=cVnPRl81; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=sI2SSTvW; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="cVnPRl81";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="sI2SSTvW"
Received: from compute8.internal (compute8.nyi.internal [10.202.2.227])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 2D594114ABD7;
	Thu,  1 Aug 2024 06:40:50 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute8.internal (MEProxy); Thu, 01 Aug 2024 06:40:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1722508850; x=1722595250; bh=0VfZorWqtF
	0PpQXojzSItu80HkmP2/veuIGj8rg8meE=; b=cVnPRl81ja8GZkOfgmB+e/AAER
	adYztEi7NpHGZP7vq0ZkyG618QEEp4MBF9gI61KvfhZ5xBqTFSSvfkfzLkrGRQce
	+oFtfFf7+k455+EAib/Pgl0RYusebHX8fxvpRTyVo3rKSWfPP7oq+pcobRJseBmo
	svd2x1ASQ9xxAAl7JYub2vik3NVVH/RUnrSYxHnctl+cM+WbEe1Ylu0aQ7q1g5Ve
	F10hnni57ZOhpC2GUFXuSt0j3pEZbx3lgt81wQXUG+1HCgXlwt2JH3tGp6wDbOhS
	43Em7FBx3+nynT2JURzq7QaPbG2Fsy5HA4i/z79thFOREDlN0pR83RxC4/aw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1722508850; x=1722595250; bh=0VfZorWqtF0PpQXojzSItu80HkmP
	2/veuIGj8rg8meE=; b=sI2SSTvWfgRNyOz0CgMA9IcvV2efeGgWNDfhO2bvTfxP
	LjByd6RFjXK8cYz1KfnHj3V6pVP9wRjI0ViQ3yRGJO6sYjrlKCKnD89IxcR3zDSb
	KWr8UtYlsaXOvsSDvHrTkME3J2noAolRbvkiNXFWxnmUch6Pfn2ofF3ErH9yiNrr
	rfPBAbs/8BAL8yJy0mGag0wrm05tV7ccIVIzgYgyhyIaMYhKDW86OROLa+QV3zQq
	riWqMd2DkheXitzLN+Yt3EPd6wqPAID+CQJu00vEIBa6MY5ZeIYRvigXUmChuRd8
	qR3cUU0GHd/kBNnJRdGiNmZWHw8S2IBPt0S30D9xLw==
X-ME-Sender: <xms:MmarZjnBIV0NLs6ZdzGyVeAdOrbL6NJu1teTIhvqtO8ttED_frVXjg>
    <xme:MmarZm2XetFKAhpDysE_npdK7I6hcI7W1KuP0P_pmm2FXBtVoJo_tW42YhlR2v3Gv
    v0MtEJFGemNeMgBdg>
X-ME-Received: <xmr:MmarZpq_GmtM_L4Ugy2OMDlvhg_EPMjUNw0-tQ9biG4Ci_n8MZtt-Vn5661jpds73hDOvA8XX6F3H-EspM2pAECY1D_jF5RDCu3hCgOYhyoyFVw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrjeekgdeftdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleffteen
    ucevlhhushhtvghrufhiiigvpeefnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopedt
X-ME-Proxy: <xmx:MmarZrlcYxVzR6YPf7Bi5ikErFX7KnpLqot2g4lTKTSFv_bpsRP5RQ>
    <xmx:MmarZh11bIUDeD5j0PNd2hWmIoeCCO0Pl1H_MPpA2Ag9DAevrm_DOg>
    <xmx:MmarZquHCN6mSSsWRoIprG7B2rVkv_QiE29HIDvR_WNDCW3C8Usmrw>
    <xmx:MmarZlX3xgHDCEoKR-cAyz6L6eitIXrq-JztvUoWg04yqhrzJp2xPw>
    <xmx:MmarZp-Aao2NDgO30UYDCv78ozoabywWT6ZG6EK8rRTaySD582UE0iwu>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 1 Aug 2024 06:40:48 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 432b7f44 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 1 Aug 2024 10:39:17 +0000 (UTC)
Date: Thu, 1 Aug 2024 12:40:46 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, Taylor Blau <me@ttaylorr.com>,
	Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?UnViw6lu?= Justo <rjusto@gmail.com>
Subject: [PATCH v2 18/24] builtin/worktree: fix leaking derived branch names
Message-ID: <dccaf695a999294ae7e1eb24944a0e565b833b6a.1722499961.git.ps@pks.im>
References: <cover.1721995576.git.ps@pks.im>
 <cover.1722499961.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="hIzf5Necj8pVUnfj"
Content-Disposition: inline
In-Reply-To: <cover.1722499961.git.ps@pks.im>


--hIzf5Necj8pVUnfj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

There are several heuristics that git-worktree(1) uses to derive the
name of the newly created branch when not given explicitly. These
heuristics all allocate a new string, but we only end up freeing that
string in a subset of cases.

Fix the remaining cases where we didn't yet free the derived branch
names. While at it, also free `opt_track`, which is being populated via
an `OPT_PASSTHRU()`.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/worktree.c      | 7 ++++---
 t/t2400-worktree-add.sh | 1 +
 t/t9902-completion.sh   | 1 +
 3 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/builtin/worktree.c b/builtin/worktree.c
index 1d51e54fcd..cec3ada6b0 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -769,7 +769,7 @@ static int add(int ac, const char **av, const char *pre=
fix)
 	char *branch_to_free =3D NULL;
 	char *new_branch_to_free =3D NULL;
 	const char *new_branch =3D NULL;
-	const char *opt_track =3D NULL;
+	char *opt_track =3D NULL;
 	const char *lock_reason =3D NULL;
 	int keep_locked =3D 0;
 	int used_new_branch_options;
@@ -846,7 +846,7 @@ static int add(int ac, const char **av, const char *pre=
fix)
 	if (opts.orphan && !new_branch) {
 		int n;
 		const char *s =3D worktree_basename(path, &n);
-		new_branch =3D xstrndup(s, n);
+		new_branch =3D new_branch_to_free =3D xstrndup(s, n);
 	} else if (opts.orphan) {
 		; /* no-op */
 	} else if (opts.detach) {
@@ -875,7 +875,7 @@ static int add(int ac, const char **av, const char *pre=
fix)
 			remote =3D unique_tracking_name(branch, &oid, NULL);
 			if (remote) {
 				new_branch =3D branch;
-				branch =3D remote;
+				branch =3D new_branch_to_free =3D remote;
 			}
 		}
=20
@@ -923,6 +923,7 @@ static int add(int ac, const char **av, const char *pre=
fix)
=20
 	ret =3D add_worktree(path, branch, &opts);
 	free(path);
+	free(opt_track);
 	free(branch_to_free);
 	free(new_branch_to_free);
 	return ret;
diff --git a/t/t2400-worktree-add.sh b/t/t2400-worktree-add.sh
index ba320dc417..cfc4aeb179 100755
--- a/t/t2400-worktree-add.sh
+++ b/t/t2400-worktree-add.sh
@@ -6,6 +6,7 @@ GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=3Dmain
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
=20
 TEST_CREATE_REPO_NO_TEMPLATE=3D1
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
=20
 . "$TEST_DIRECTORY"/lib-rebase.sh
diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index 932d5ad759..cc6aa9f0cd 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -16,6 +16,7 @@ test_untraceable=3DUnfortunatelyYes
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=3Dmaster
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
=20
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./lib-bash.sh
=20
 complete ()
--=20
2.46.0.dirty


--hIzf5Necj8pVUnfj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmarZi0ACgkQVbJhu7ck
PpSczxAArFkK8w08Ob9SrNB2AmYtjjeiAZd9p/fjKC/qGdxQWQ+bgi1N4phyOD4e
MN2wx1sjuWrbMvunroCTwX7aPHnF/HlVqbYkj900YiSet8YrWfNoqziY5REmQn1h
rRI1NnEVQZqbsKT5rRZ+L2wjhdQEGpd/fuVopx1h+hzz49AgFtBWMMkxaKrJhW4B
vlw+8T70R8/3RqXthnzmyKvlSgdbZAkz8HBRg0YJu2y9GGaDiWq2pp+D0D/Rs3oU
u+CzTCE+heIJAQdivyvCAO5M9Ou+VV80f5MygWVhfKscRg3h7wc5wqJcX6VT2NaS
Ufq0N/yx+SFd+0TcR44tIdGmp45fEKQpm22qZ594LIFuKjo4iy9wK8qAPYUbSE83
BNxO2sBZq8UbTVTZZFIhkmINhOXzaITV/iS+8bGGNMwCVHp9RGznz96+g2xU5CB1
SqAkOHObeps51lZbEVfKdjPxRG+7XP5U4AbQQYKZvFikJVbRdXeccTKPI/tL4h5z
ImO36Owy9/H7NLJsw0+S+dXfDoIBHXrHBt37V1nK6pDb7wQdcX1jz/p9pRJ4ufLx
5t6yx6Ow+j2C5DC+AHtGmhe4GUQ22h3ZIofbYr6Cbbj1u3+WetD+Uch4FRG+YPb+
2bY5JCdDlZIumPPfX5tDMI1Na241tyO0JkKViOCIHAx3kLvkv8c=
=HpYU
-----END PGP SIGNATURE-----

--hIzf5Necj8pVUnfj--
