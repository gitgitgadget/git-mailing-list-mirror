Received: from fout6-smtp.messagingengine.com (fout6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8C4014002
	for <git@vger.kernel.org>; Thu, 15 Feb 2024 08:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707985560; cv=none; b=la7sOwkNGh6SknEZ7LTbWJs+H5ezBay98eMkBUJ49VWy07PEciIr/kUn4r2I+Nfurcs14KMpcoDOTUZ7nIANpoDAMAPhBdcnMJtd4eY5RVywcXWsNy1HjR+pADTyyDrezb1m03ai3r8A7JK7/Zcmw0fYIjDFQ7HfZMLyEm6WXqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707985560; c=relaxed/simple;
	bh=X15oyPW34DPJLaU+4ODY1+rASEZxHwUEkNhQjfOebD8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lkg6Sj9/8LpPAqRDz+HNcsyqPnZ7RI0ts7CihhIhhqPwHFlAsO1YjPxg2NMQ5oe9wnUHefLWRaSxb4HQSM+ZQ/F2zkBZ4kHfhSUUGn5muMlscRDRyR9UlvzqAUwA1pIiP+7AipziM6w+ZByI3mHor+bQ6Slet62gaEdcaBz+2gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=i/qvWkxA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NfdTDM9N; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="i/qvWkxA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NfdTDM9N"
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfout.nyi.internal (Postfix) with ESMTP id A8F1013800B0;
	Thu, 15 Feb 2024 03:25:57 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Thu, 15 Feb 2024 03:25:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1707985557; x=1708071957; bh=20P3PiEWmH
	udXQQfqGoB4cSiEj7sk26CMyIu0K/FCJc=; b=i/qvWkxACqwOpOI9wALZip4C10
	CTPid2SRzZJZVRcxup+1ZpPrI3GNono01zRzh8N8kWq+KWH5IPnRAWsZs4+kdblD
	iSgZg/Yf81Z8T6Hcj0z2vWCFRVAfHD1wX+6lZMPYyeoBb+fXtoY7Y6jaiLgB12Du
	Xtu2VpJWznM0txxKHZQJ5xsRWkIouxQrb9vm9RSB3hKuZfSKCxGqUA3xN0VuCNlZ
	ZOdq2QDnjUmislNbdFzzQP6buyS/gHSYbUmAS8oYIkmayZdDKnYzV5lDn3ubk2Rs
	UTIBrep7fC1WBAWh3Z3UrJVNfDjfQ/C9F4CL8yY14YYjwcTLWwpqnkWXAfOQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1707985557; x=1708071957; bh=20P3PiEWmHudXQQfqGoB4cSiEj7s
	k26CMyIu0K/FCJc=; b=NfdTDM9NnZIUQ7EqzOycwvnxTcbveHvjreaQ/zReofsE
	Y3zaA7ZV2yeJbbV1JqZfk0I4uL3llykwuvBNHIXvprELO0ohvgaRbwWz59xkSvKj
	Bd68DYT2kla1H/ECHJ+jGj9D/UFbzV8gzPxzGXwI3aZRlDp6jtloV3v39S3PIgoy
	uei4oOGNYxfrvMCvc25XtFqA6lcgpILKtJEqns6Esd3BDW/cD7cdm0+kQ37trmkn
	w4JyudL3b25WnCIyIfax0UgYstnFSn2ZqV5IyEHil2PSxzDDcxc8SxGylM0SvMTo
	Y9RysVWpp8HXNePV3xvVjNhbLgEfHkxU1cL72FdbVw==
X-ME-Sender: <xms:lcrNZWoND4JytzWRUO5l7XdjqaxZsVej7jgufGzf3adrvHVDQzgzKA>
    <xme:lcrNZUoOJHh1GkCAyeMAZfUL062Fw4UQ7JThuXUJd1f9B084lteGJdcMERTT-LYTC
    jWQRoDy6taDm0K6rw>
X-ME-Received: <xmr:lcrNZbPpyNv3cFpMwe1lHQJtRHIMqOmAtETuAaOr_UnC7yKuOGUpeHk2LdfEylxW6kesUk7b6lWnQS8eLutL7f_M2NqsRe6CRDBAnS06G-Kl>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudelgdeihecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleffteen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:lcrNZV6_aQaGFrfbO-c47qnokUJM2uGVjPPx-_uhO9WCJsCV2_3OEA>
    <xmx:lcrNZV6z4Ocei-fEkYR_FW2F5ZW7LXSe7o9mEJmmS7CRLTzgIlMkHA>
    <xmx:lcrNZVhvYftWPxUM22M-s1a8iTgZu0pOgzObiBS9vYVtspRSpf8u3w>
    <xmx:lcrNZflnF5Hv5Aofe6DZ5KhFP5PPGJUUhDaLOD67tgmnnS9rGAeW7Q>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 15 Feb 2024 03:25:56 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id a09d9a0d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 15 Feb 2024 08:22:05 +0000 (UTC)
Date: Thu, 15 Feb 2024 09:25:55 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 7/7] t7003: ensure filter-branch prunes reflogs with the
 reftable backend
Message-ID: <8fb6de37ce20bedcea6df9018e5a8a75eefb48c8.1707985173.git.ps@pks.im>
References: <cover.1707463221.git.ps@pks.im>
 <cover.1707985173.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="25DWyXi/6bpuujep"
Content-Disposition: inline
In-Reply-To: <cover.1707985173.git.ps@pks.im>


--25DWyXi/6bpuujep
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

In t7003 we conditionally check whether the reflog for branches pruned
by git-filter-branch(1) get deleted based on whether or not we use the
"files" backend. Same as with the preceding commit, this condition was
added because in its initial iteration the "reftable" backend did not
delete reflogs when their corresponding ref was deleted. Since then, the
backend has been aligned to behave the same as the "files" backend
though, which makes this check unnecessary.

Remove it.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/t7003-filter-branch.sh | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/t/t7003-filter-branch.sh b/t/t7003-filter-branch.sh
index f6aebe92ff..5ab4d41ee7 100755
--- a/t/t7003-filter-branch.sh
+++ b/t/t7003-filter-branch.sh
@@ -396,10 +396,7 @@ test_expect_success '--prune-empty is able to prune en=
tire branch' '
 	git branch prune-entire B &&
 	git filter-branch -f --prune-empty --index-filter "git update-index --rem=
ove A.t B.t" prune-entire &&
 	test_must_fail git rev-parse refs/heads/prune-entire &&
-	if test_have_prereq REFFILES
-	then
-		test_must_fail git reflog exists refs/heads/prune-entire
-	fi
+	test_must_fail git reflog exists refs/heads/prune-entire
 '
=20
 test_expect_success '--remap-to-ancestor with filename filters' '
--=20
2.44.0-rc0


--25DWyXi/6bpuujep
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmXNypIACgkQVbJhu7ck
PpST3w/8CkSgXYH87AA4g3aRm0T+jTDLTxivwY2ZJu+otdFbuSOmGCePpohqH9b0
D6mE88938pl3qJChDc2CWz2GDnH+7ZsYcrQodjtR407LArX6Ik//SHe+5qZOKG5O
CPy60wr5P5A5Bcbt+YZtiuEyo3uRqzy6y38f+I/zZAEkzL2+3HN2VPw31ntZYzF4
DhHQvaa8PzJctzoeWODAd2rDb0wgHFc0Eh9Ct5JnfpAqoCaszaDxJa0TbdnHgJ9J
67uzQkk81ZmD2WbsGKs4FO+xzWxTplC2aqAPHgdKRqlau3bcjCoCYDAMWI15awfJ
yDxXSXF+03O0TPKTQH4EoPqctSbd3SWQiAHJPwHZ4CnY0yNsCMCQF9XhRU0XXkTq
CRAbFlDuMIC5EMG8Wd2+CuDLoS1hjWaCyyz7R04QhYcfz4yzaJAcQsuozqBtvYt2
k3Omo/IREn5bANys6OLOlOpeS4B5QFyY+NrKz3ny5uA86sBIRmVUwM+3gjujqY7m
CJnyNbCUSY3oZNBGmGNDNbvT9qYkI4TL1Mf8mu17gWd91rdA9w6l+sFDb5I20l5F
oVF2J/BMd+ah9l7ttbmyc6dNZBZfTdjLshHdWJPVm/RG2IXfmtQYB11cGmsbTA5W
BNzX2sZSYMMdh2lRcy4OhXYTYaDbc8XyRDedDy7hubaUkdAE57U=
=tur6
-----END PGP SIGNATURE-----

--25DWyXi/6bpuujep--
