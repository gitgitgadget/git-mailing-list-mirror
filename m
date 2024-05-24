Received: from fhigh2-smtp.messagingengine.com (fhigh2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 405BF85274
	for <git@vger.kernel.org>; Fri, 24 May 2024 10:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716545067; cv=none; b=CHhbJ+T5csG0WGejuNdt6ujrXLd+MQr2/xwZoak+3j+BS/ovOmq97xPRJ3p30vu+CzB21tTpQZQX7ghQJXo3bF0yBIpdWhJhQ1c+b+/v05QDw+p4E4jxASauijLD7IuK3FFCzzL0t8LSaYyobHFN6vhomw01hdjqES+cLJvbwqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716545067; c=relaxed/simple;
	bh=kuFAWJYbOZN5wVBUrT9OMGeT2npXSMruV0Zp1DtlfaE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J1ylnyApvOaD07WD4eiRqtMZTMQzGAfJefoR8OccMC3mijl/ISBTmbuYETv7UHnaw2H9lgAva61TxwlkvpbmsatlL0UUBU/1TGPzYWGbmjx2mw1dn0SbqrrbpDhoq27Ml7raTwFU9gzqLkXODbQdShRS9dk3e7YG9JFEClK9q0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=UFbsMVrU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZJjeJuwl; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="UFbsMVrU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZJjeJuwl"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 59AA3114009F;
	Fri, 24 May 2024 06:04:25 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Fri, 24 May 2024 06:04:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1716545065; x=1716631465; bh=w2dN1vuJ7N
	0WNbEXtlKr1LVVDyTv6V9foEvzaYrK7bs=; b=UFbsMVrUDdE1ICcpKIfEL8zzJK
	+uWpWgGgxtHBL3X0x6bIKBtCh5+ydOTZNYdJaax1DSGrZ3aIcASy04FIZ8PwrDc1
	mchYrLmlj52ySAvGAZ3BV9iLTmsuOiDtzNOEMVOGZSus6OgneeRgve0Bm8OSUn9B
	kKxoN+kfCVOLRLBn+31nraoZw7VDHKrmTx7QBe/sC2pSRvdS4ReE35yhky/uofiu
	kNQn2oCfwIc/yDTxnKeE1ssu8847Uk89nLFd4HFb2RgIRQMLtwuZrhPGP+Zbgpob
	XzIiJB7sxO4ZDve7RpT4mRtCEMoAw0qY8AjAfER28s8PlOkIX6wOo/B0oHOA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1716545065; x=1716631465; bh=w2dN1vuJ7N0WNbEXtlKr1LVVDyTv
	6V9foEvzaYrK7bs=; b=ZJjeJuwlG3aLXnRxY7EaWSX9DBqxZSO+3eo29xTYmOYg
	8v8wmIxdI9a39j9wJz1mQRh1LuX5NNa0S1r53Kb7ohAoEN2cuHhwpyqeGfwe/c0X
	uvd6S5DnnDnPFL9Bv3xmo/UvbCqACal8+lP27NKExjy/21LdWBBvsyS7WOi/33cR
	YzcTu/pHwXTut6Tbb5SVPocWgZQsxobCJFzPZqt/7WY7lu+OtqubTE69s2wyH6KM
	Zt9ig6E1MUXXh32VzDW7TCmtRNaX5yIMdJdAa8rreeqNq51o2blEeCJhtJZppLLQ
	rJjSq1phuYq4X+mL52gA33ga5G1Oixj5zE7dtOfv8w==
X-ME-Sender: <xms:KWZQZrnvEdJUIacVbw2SO0SZJLLdtPJcEpPHh4FOfWj1IRz4SRbStQ>
    <xme:KWZQZu1jhUN66OJdmxE8uaP8a6L1h-a4AIz2GGBdUfyuMo8J3yWCPGkUANVQP695k
    ka5xw-v0F_Qp1vjPA>
X-ME-Received: <xmr:KWZQZhrSbjOdjI1_IlSbfHavhaEOCxcGXOPFEvb5k0Dnht0N3cg8PkaPs9SmU0XaohyeThTpKeqmp2HFy9cxZfaf6lUkAaGr6R3FNJCcgFjtFsg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeikedgvdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:KWZQZjk9zvffnjY0GEnCVYnbuYxbD0YQEGpTRrYu6-H9ILz_MfLNdQ>
    <xmx:KWZQZp0Loeg5ij2BA1klQ0DREVTYNp46e-sgCQa8D4qotJrwRNcB9Q>
    <xmx:KWZQZiucoxiUDUtzD1EohonHDU3ydBVbgvoYuZnFXpOwCdghgg83xQ>
    <xmx:KWZQZtWxOTB_iA8zA7DkWRePOrZjvWY8lZ-WA_CPMtJnCfieDegIlw>
    <xmx:KWZQZiw89fdh2RPQ061-peCpUMuZWhPlZlUPEbRWHng77TxYS_seFXpH>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 24 May 2024 06:04:24 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id a93e3454 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 24 May 2024 10:04:21 +0000 (UTC)
Date: Fri, 24 May 2024 12:04:22 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 15/21] commit-reach: fix memory leak in `ahead_behind()`
Message-ID: <64b92156f878caf91dcf75f0d562ead672ef9eea.1716541556.git.ps@pks.im>
References: <cover.1716465556.git.ps@pks.im>
 <cover.1716541556.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="MyFzgU1Ng4mkvs2R"
Content-Disposition: inline
In-Reply-To: <cover.1716541556.git.ps@pks.im>


--MyFzgU1Ng4mkvs2R
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

We use a priority queue in `ahead_behind()` to compute the ahead/behind
count for commits. We may not iterate through all commits part of that
queue though in case all of its entries are stale. Consequently, as we
never make the effort to release the remaining commits, we end up
leaking bit arrays that we have allocated for each of the contained
commits.

Plug this leak and mark the corresponding test as leak free.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 commit-reach.c           | 4 ++++
 t/t3203-branch-output.sh | 2 ++
 2 files changed, 6 insertions(+)

diff --git a/commit-reach.c b/commit-reach.c
index 8f9b008f87..384aee1ab3 100644
--- a/commit-reach.c
+++ b/commit-reach.c
@@ -1106,6 +1106,10 @@ void ahead_behind(struct repository *r,
=20
 	/* STALE is used here, PARENT2 is used by insert_no_dup(). */
 	repo_clear_commit_marks(r, PARENT2 | STALE);
+	while (prio_queue_peek(&queue)) {
+		struct commit *c =3D prio_queue_get(&queue);
+		free_bit_array(c);
+	}
 	clear_bit_arrays(&bit_arrays);
 	clear_prio_queue(&queue);
 }
diff --git a/t/t3203-branch-output.sh b/t/t3203-branch-output.sh
index 758963b189..e627f08a17 100755
--- a/t/t3203-branch-output.sh
+++ b/t/t3203-branch-output.sh
@@ -1,6 +1,8 @@
 #!/bin/sh
=20
 test_description=3D'git branch display tests'
+
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-terminal.sh
=20
--=20
2.45.1.216.g4365c6fcf9.dirty


--MyFzgU1Ng4mkvs2R
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZQZiUACgkQVbJhu7ck
PpQ/+Q/8DWKisFk1oo3z+NRPyiG0c2zDlW3TqEvJGpkKUu5iR10CO1m9Ks2s1klU
owRpSMbj51IDRvu67nUJRjhJw1fOVpW0MYGaNrSFTNB8QnqgBYJYgaEkt3pTkAIx
TfNzLIAQNidNNCy02RAjjtkl1o7U6+vGSVhWz4lpQyDDGCzzvsLzW1rlKnmHTRnk
IkF9GvYfmQNxOYZDjqGsuj+oTVKKcPhZMKi8NnArFzr+fcjQdX7er1cmaX03WF+R
LdlNs2ZJyf5UGYFN6S81JuQGPSOyG4NGHQ1iVrOkzBFjLjC4tDlKo6j/b7LIrzqX
eQ9CKhI0BINDMoca9Gpuk6/ComDhLLB6MtGDw95auNd1kk+3XoWSz6nfkzjv4BsB
nF3mhqhNjKbVbfwPBKS9zzDXgXJqZdeCHZ4KKhT9zR+TyNBQoyR1H1CH1IPtO5A3
fkcu1OwAMjAw/TN20P3byCh7+Zj0oYc4kPydo77wHkr8f3tYNaht/JftZFePbERl
ho5gi68KYku0uiOMABYubE0wNiAZ3z0qWWNS5zHNcibujSMMSDvdG13L9nWyhFqW
4mL6XUx4NsQRCVVfcj+oIjyifpGG7LzWj20xloRfShWVHnAQKwdkRb+5eYohXtMH
HqsOO9nvDURVpuanRMHGcaTy5XYhKTCS3U+xoBiVOwQgp+Y9TPM=
=3jpc
-----END PGP SIGNATURE-----

--MyFzgU1Ng4mkvs2R--
