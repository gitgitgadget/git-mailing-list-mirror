Received: from fout7-smtp.messagingengine.com (fout7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 548D018C19
	for <git@vger.kernel.org>; Mon,  8 Apr 2024 06:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712558826; cv=none; b=RwxGojrhJbvRAPIJGxMZUvhjQPHoFRnNYZ8FF/6VAWJ72G1tQwxVejSm04PuGPmVBZIAm1BiqNL3ObMatVUTlxbs0lMskfq0iENdJUt4bDXqMhR+2Jlqjrk7c5smc6La4cfYzOB3z08b713uBEoMaGLmX/noa3fJPwMFBmRDO4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712558826; c=relaxed/simple;
	bh=JFV/MKjdnLvBPCp1XO5nX2oRi78aS25wdfRaG+ECzgQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vBMIn18/Hqe5qwAY733Xn1r1QWzTCcbXIbR7qDaqa06gc/6NaOVjFexRXjhMkjzUniD/wqeRP4+q/zz0lVCrIUaA8FYYQflq768/bPKWk4W7xhZYzhBZ/aW29iuEbSNeyLnmv0Aob5mry7om0+Bkv/ZAzqswjhGWj+RbnvAdShs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=c4VCPaP7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hvcOguXw; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="c4VCPaP7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hvcOguXw"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfout.nyi.internal (Postfix) with ESMTP id 9EFEC13800C6;
	Mon,  8 Apr 2024 02:47:04 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Mon, 08 Apr 2024 02:47:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1712558824; x=1712645224; bh=izJ7JLWhJ+
	n9h+Qs5qguxPuKcao5C+fV8wsoVSY4xrY=; b=c4VCPaP7JlronPHNRXMOujQrWm
	v9tmX3ZK+CYt5BYHHIERESXCxeWHOUkvm5npLyhIxXmh/J22r8wOfK3Sxo5xKfKS
	JfkrcD1RsaR3CP/Ft1d5ZSWrQxX7rlSWmJR8gv1UmBN8Z1+40HW4xhf5dpwzJnRp
	95eIRNQE4eCa3RAht2jseRqlviWp/q8nVRF0arUZ5+YFsaCBnBL2p6MYyHavirLV
	faLJt+kostgkzpNENTcBtXXujlbjILKEx5rfNdeXYONDbF3vj8STY5Yb9XJgBdnL
	mNEeDvCgljZwYJogHlQd871xzuly+SbB3pzWDzcjfUH4S8cGjF6PG58Haq1w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1712558824; x=1712645224; bh=izJ7JLWhJ+n9h+Qs5qguxPuKcao5
	C+fV8wsoVSY4xrY=; b=hvcOguXwgnM/pUVZlX5BEuV9m0Bq2Bo2iQEMMu/BLYKP
	snHtRuFN63rc60u6MVaxiZMNo+MUHZf3Q2MEf4P4r87qSQ9IAbgKYSWDF6UG9rzA
	4rY+PhEzB8UqVkCqkMiDpfrmZjsBA3wPyKnzGUGQQgFzpJIU+OdrB8UQ6CffY526
	otvynbf1U27U8Kslxt1NRnNe4n+B7QWJ6wxRLTh8dGmDsnz3R/IqDNdUCwbCuLPh
	3R/BIl9TiEVOY/V9fXd1gOm8VvjlNyaVvcn3lg4I6M+L7kgLVfEk4PnYWn4E3Ppw
	iAq2hVn2hALsd20+R40MEVZA/mzhNNJl1YrOo37LYQ==
X-ME-Sender: <xms:6JITZhoJ1x0fSFw8blSBRQj4PiP3qcd3VXiRQYK5PlwfLwwO7m4RMQ>
    <xme:6JITZjpYqh5hY3vTBq1VNpW3pUVpnihDEJ-v-Zday7Tmrx0J3JvhT5q7JO0wiRnef
    tvqQBg0vNbY5G49ZA>
X-ME-Received: <xmr:6JITZuMEpLJtbKoli_ujshUMgicjS-9gq2E934x_9zDX31C25joqw9AlZurzrR_YtdhhRyC32MNT-q3og702uyWifd8nvE0cGFBoVBitJh9uPdW9cQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudeghedguddtlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedvnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:6JITZs5yYQz8gyvEpj6o7ZiYcRrvd_n50CO07B2FeoOw3_1JZqeJtw>
    <xmx:6JITZg66zojUxTI8Nv4k6pbizbBQ4Va5R8J695AJSgm-2jUvdjXEeg>
    <xmx:6JITZkho_CR78ao0mlgAf4ybPkEK2hplu2tsjR1MTJQKQdc7FVjTCQ>
    <xmx:6JITZi6oJor90FJcobNNMLUvIhtDSJrBy5DXrWW-KtDqq74-2RHuQg>
    <xmx:6JITZqTKlbJXNLd5ahqjzbj7hivkD2Nt0ehArY6LyirfJoRCCOBW_SCr>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 Apr 2024 02:47:03 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 70dd9b4a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 8 Apr 2024 06:46:57 +0000 (UTC)
Date: Mon, 8 Apr 2024 08:47:00 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Han-Wen Nienhuys <hanwenn@gmail.com>,
	Josh Steadmon <steadmon@google.com>,
	Luca Milanesio <luca.milanesio@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 11/12] t0610: fix non-portable variable assignment
Message-ID: <cedf5929d1ea989cbf87bad48e35c0d191b624c3.1712555682.git.ps@pks.im>
References: <cover.1712235356.git.ps@pks.im>
 <cover.1712555682.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="6cJco/6NFMJdyJ4A"
Content-Disposition: inline
In-Reply-To: <cover.1712555682.git.ps@pks.im>


--6cJco/6NFMJdyJ4A
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Older versions of the Dash shell fail to parse `local var=3Dval`
assignments in some cases when `val` is unquoted. Such failures can be
observed e.g. with Ubuntu 20.04 and older, which has a Dash version that
still has this bug.

Such an assignment has been introduced in t0610. The issue wasn't
detected for a while because this test used to only run when the
GIT_TEST_DEFAULT_REF_FORMAT environment variable was set to "refatble".
We have dropped that requirement now though, meaning that it runs
unconditionally, inclluding on jobs which use such older versions of
Ubuntu.

We have worked around such issues in the past, e.g. in ebee5580ca
(parallel-checkout: avoid dash local bug in tests, 2021-06-06), by
quoting the `val` side. Apply the same fix to t0610.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/t0610-reftable-basics.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/t/t0610-reftable-basics.sh b/t/t0610-reftable-basics.sh
index aa9282007c..dfa7e274ea 100755
--- a/t/t0610-reftable-basics.sh
+++ b/t/t0610-reftable-basics.sh
@@ -78,9 +78,9 @@ test_expect_success 'init: reinitializing reftable with f=
iles backend fails' '
 '
=20
 test_expect_perms () {
-	local perms=3D"$1"
-	local file=3D"$2"
-	local actual=3D$(ls -l "$file") &&
+	local perms=3D"$1" &&
+	local file=3D"$2" &&
+	local actual=3D"$(ls -l "$file")" &&
=20
 	case "$actual" in
 	$perms*)
--=20
2.44.GIT


--6cJco/6NFMJdyJ4A
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYTkuMACgkQVbJhu7ck
PpSYMw//TDlgkmzONp+Dswln7cxKOfvOPzrf9p4HDbpwLCo6R0DBRmiF8Kt6TCdw
U+e2A0BZMrQ2LnIUWNF5AeFWboOuTSWVkBl032HTDhtchmGF5Vu3JfGNd0KMxuKv
i89pwiZN1R2ay5VoMMPSiq/ynvwAKcN8av+xGI5+pmdyneXtf/uWLNgqEGfxhYNN
f2JEwX+8HyfScrxDwLiCWSzadQpIMrG03hv9X+han6esvVJWxM4i7EMCgZPU7zzq
j4HfV+bq1SZPc85Z+nkgroUTi4ytjcqOJkrcsFuSrJHn0ZyN0OnHfBrrs51R63Xu
3LZ3fmiEWi0LedxGEf10ewoS5ZuAEimKzUSz/y0fzX5iOJJL4uOMWQ6WWHLf2z36
X6qolPwy9HgPMVNswzcUX+zG/MtlyMPRQ2PkCqI14cmm2SePcSc76D5C4KMjmZeZ
eR9PzTAU9HAVgyRbhovmG3DPRpSQ+g+qXeyxdRvfRExexay0gSm9ZfZN+JBgXjdQ
agNWco+co5HVGV7+yWWoMINCG2FOqzBVwiIefz/h9F9o3YBVp9cC591gcAg8uyaS
6uYfsD4Rh4BrDzZfT7RYz7sS43W5CraULFHt4sa0jOgSbOyevpnc3L0+CI0/Dhfi
4i+lFccBGEogF1DsDFQ44hDBB+yHzQdGpGcXIH02AwhESEIh+iQ=
=HWjT
-----END PGP SIGNATURE-----

--6cJco/6NFMJdyJ4A--
