Received: from fhigh4-smtp.messagingengine.com (fhigh4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B02718C333
	for <git@vger.kernel.org>; Thu,  8 Aug 2024 13:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723122355; cv=none; b=dW9/iujzscTSoui6vBe3exZ/HUY+7DifoBt+vWSrDgT3UTyUpjUW8RZCfTaYOtnozMKGQzErMawVkLfucYd+QyX6Rc30AfJPmhK7EO7pe3As7MdWfH7joVn/ekzRpo96cEoGQiT0k0EtLs+awIe9dNTr299aYLq41zfXqxwNWn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723122355; c=relaxed/simple;
	bh=h66vPxNJLDUjULagXIM2P6YAg244y+cFx47hZ/bYtQ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ohRsf9Q8jtPadIoQRJK036AIAFYiqZYsZgbqZSXu51e+za08IK0R9u73DES+njjHHn4lqHEAOWoUK8O7pQ62nPbN+IyXeyNwcd+QfenSWdO+Qpar0wYxsj0a7BeHBJtzaWFdHc5wKM6szeGZZNDpcrhGRc3cgOjaBtogTdJFQiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=hMwZxXH0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eR2adLTm; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="hMwZxXH0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eR2adLTm"
Received: from compute8.internal (compute8.nyi.internal [10.202.2.227])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 5A6741151AC9;
	Thu,  8 Aug 2024 09:05:53 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute8.internal (MEProxy); Thu, 08 Aug 2024 09:05:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1723122353; x=1723208753; bh=5bU/hHktVI
	D3YUUZBxWmZSC1cDj7jCtG/YGcVhnvzms=; b=hMwZxXH0mA3vVBKZrCUb1sZt6x
	S1FFxaxy2SPa1hIWkvidh+yh/XgQ0ae/QDTNlu7ND5fEV2Rw1hMDt2Ctsg4gd5Zr
	ffKnyxVGlZpB93n0mkjDR04EcFvGV/Ib7erCWjGxQ21WsxnIe2otoMVI0cLO8wTp
	0DYnlKLLzQ3h5O9Dzi5wpwL32aoN6q6r+yzzrg0Ngm1GQU/rPivoxeDd7HQKDiFT
	baYDCUuLVcUV90eapU9ku5B1qru76W10sh9400rhdFEpoXANtsyBovISXT7sHN5k
	Td3RXLk2owta3/zpmugI27Qr8HLCBuZVZL52S1iN+glsjr3Uwm+VnoYQ1V5w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723122353; x=1723208753; bh=5bU/hHktVID3YUUZBxWmZSC1cDj7
	jCtG/YGcVhnvzms=; b=eR2adLTmI+VfWoZGiCR97RHSbE+8ZfORzeVnHFzlsXBh
	84DlagIRmO7g06BpsX+2VOL4GQcCTwTcOg8LhYfnAaZEfuqeatWBUg2LumVzn/am
	b3ecQUz5PXJI//ObLl6LUfcKA0dvz5uzf5AZ/hkrhcMatUhKeOyIwilhVNwkHx71
	6pCVhTzxnKx3sKRqPLapgkX5ghUuBPsibv+EBANMinY+929WHry1I94ouaFc/Ln4
	qhGf+xM4+45iB7g0r3WT88PYnBDGdadZ6bSN/mO6K5tk6KZCU2gx8oABtwjHS7Yt
	kIfF1SVn7V5lGe4rBOjvZxrUpuZNAYxGU2OWM6RRxw==
X-ME-Sender: <xms:scK0ZlH58eMdFn8IpekWdpiQiWRmoCefIdt9xAHMA5Z3SQvS_jZUpg>
    <xme:scK0ZqUJqNA7Bn0417Pl4e8OA-ZiyZf8Rt0OPz2TVMZRBjyYsLS0-tT4wYLVqeRNa
    -trE3D8S724vONTMA>
X-ME-Received: <xmr:scK0ZnKxssGH45xN_0yZZS_xxFRhoKg1cfo5M_-VQVMt8Tv1AxOz7WZS9BvQXibxfa5qCiZg241dWj6Ti088gyIl80y7qDHwy6mnZWNuBgtfRBOU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrledvgdeitdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecu
    hfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqe
    enucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeeh
    gfeltddtheejleffteenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepjhgrmhgvshesjhgrmhgvshhlihhurdhiohdprhgtphhtthho
    pehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:scK0ZrFlfbp7yea5mJFzxfqaDxI4Mkne4uC4RwujUrloqXpdvwxKpg>
    <xmx:scK0ZrUWMYpFUoz9XYWy0Cfze7qO4QikFgrhSWGjKLG1Ocfj1hPq_w>
    <xmx:scK0ZmPlD1e0aE0iGBTyqzNiULNv0uJfeqHXd727A73mfuPLbB3kFA>
    <xmx:scK0Zq0uvR37GChPT9ryrT10dLAswh-yrsjyciw0qVzXFDye6RzNgw>
    <xmx:scK0ZmR0fKL7xAxNb1mKg097pwem1m8unGQGoq_MFuI2PZ6gW08G5MSU>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 8 Aug 2024 09:05:52 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 3b0283d5 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 8 Aug 2024 13:05:45 +0000 (UTC)
Date: Thu, 8 Aug 2024 15:05:49 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: James Liu <james@jamesliu.io>, Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v2 17/22] diff: fix leak when parsing invalid ignore regex
 option
Message-ID: <edf6f148cd2f7bb140c878198a054ae7d9f708c2.1723121979.git.ps@pks.im>
References: <cover.1722933642.git.ps@pks.im>
 <cover.1723121979.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="OSg6u49fRoKb1fZx"
Content-Disposition: inline
In-Reply-To: <cover.1723121979.git.ps@pks.im>


--OSg6u49fRoKb1fZx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

When parsing invalid ignore regexes passed via the `-I` option we don't
free already-allocated memory, leading to a memory leak. Fix this.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 diff.c                  | 6 +++++-
 t/t4013-diff-various.sh | 1 +
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/diff.c b/diff.c
index ebb7538e04..9251c47b72 100644
--- a/diff.c
+++ b/diff.c
@@ -5464,9 +5464,13 @@ static int diff_opt_ignore_regex(const struct option=
 *opt,
 	regex_t *regex;
=20
 	BUG_ON_OPT_NEG(unset);
+
 	regex =3D xmalloc(sizeof(*regex));
-	if (regcomp(regex, arg, REG_EXTENDED | REG_NEWLINE))
+	if (regcomp(regex, arg, REG_EXTENDED | REG_NEWLINE)) {
+		free(regex);
 		return error(_("invalid regex given to -I: '%s'"), arg);
+	}
+
 	ALLOC_GROW(options->ignore_regex, options->ignore_regex_nr + 1,
 		   options->ignore_regex_alloc);
 	options->ignore_regex[options->ignore_regex_nr++] =3D regex;
diff --git a/t/t4013-diff-various.sh b/t/t4013-diff-various.sh
index 3855d68dbc..87d248d034 100755
--- a/t/t4013-diff-various.sh
+++ b/t/t4013-diff-various.sh
@@ -8,6 +8,7 @@ test_description=3D'Various diff formatting options'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=3Dmaster
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
=20
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-diff.sh
=20
--=20
2.46.0.46.g406f326d27.dirty


--OSg6u49fRoKb1fZx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAma0wq0ACgkQVbJhu7ck
PpTHYg//YcnVFUGHiSs/B+KiEm32PhEegp0xLcuGwTHONdbjhQGNlEemp516/yeZ
H4219PUlFyQ5zaYtsiA9LSbKKjPnEwC4VsJtRftmUf98uCnCpJwlTAzZY3Gc7Hyi
DdJRP2fesmFgsHj/xNw8qtYobcCXzZED9lIzvl7PmyqFuMIN25jwgXpJJ//UPVoY
oBKI7TekMcB5dPC4BNDC09572MPclWGk7bavEVPigio7NSfgwtca7pUUHl62Xe7b
AdQQP8rdGK1iKVmyRtKOzOI9dP7SCSS7iyDQNyj9tIY2BEZzN55+RbKZyp7O9xU7
BK80JA6ngcmnxe3no+7PJIwldJ3D9sXvk0AiFH/3l4x9ofm0ZxlG+GEUGHI4eNy0
CrerFGVQSBQaJEllOlUdfUyr0LAylFJPCSXgNtSQKAJakoD0Y2HFm7u+r3AtQl4I
Sf3+6m7RQ+cBbuf6w118nTXxfoeVjmb9xOGTPQy57vazJrD5DRtd+1UjAVRwfCdM
7+wzxnATKSTxs6VBzhhP4bvIZWn2ZFAxnrl7auY1O8GkvA23V7n/HxVD0bB1NtTy
ap+Z5JtpA/0MXTrMrGZHxDEKgInyRoiFbRvGMEfFS/ALzwkNEdsncBKag5ddVQ/g
wzMaYDFE2xjq3dUuooIOuGH2ioqm2agGvhjHCqb5FxxofnS0gLI=
=4Ksp
-----END PGP SIGNATURE-----

--OSg6u49fRoKb1fZx--
