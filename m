Received: from wfout4-smtp.messagingengine.com (wfout4-smtp.messagingengine.com [64.147.123.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5078D15A4A3
	for <git@vger.kernel.org>; Tue,  2 Apr 2024 17:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712078997; cv=none; b=qoVkqPnFSVRJUZvjKM2z9KRIkdP8BvYizmiEqsHS8e4GegGEDuDINv4+FwPeXkkZlFEfip0f0QyDhWzUSRSUnCeFHrTY5ZMdKYCc4c9/Z+V4nAnTiuPkVSezHXOyGeNBgWufUwbBbXWb+U1gPG2qD8wdObE2nQaO3H11C937DW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712078997; c=relaxed/simple;
	bh=T8bMKV0ELM3UJ5ea3hhuv3XeHmA/84Wp6Qj7fqrlJ4E=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uGJ1m4X5BjvIhGCK6lIon5/2WwneXBs+3OSo2Fj19bnurdl1DqS0zPqI4UfNO7/L4goLadpUMAEw+stWc9fhMhL7dO3fqMfjWXhM9copuR2n+aCi7sgmJK4XQrUHHFlmHOoa0Amv1Qn1Lgs2CCalz2naHhFKDtRAYGoNvulynp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=iL+vgvYQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mKZ1xW6z; arc=none smtp.client-ip=64.147.123.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="iL+vgvYQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mKZ1xW6z"
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfout.west.internal (Postfix) with ESMTP id 991071C000D7
	for <git@vger.kernel.org>; Tue,  2 Apr 2024 13:29:55 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Tue, 02 Apr 2024 13:29:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1712078995; x=1712165395; bh=dfma8u2u2C
	WS6L0t7pMbfPcLQMtA90cgEETDUHbYPSM=; b=iL+vgvYQPF1yU5nUh1OCIA7unN
	SRzQ/Jc0xEGt1KPHKh8lvNRLt8T/YJ8yoG2aJHR5NYlffIHY6UdYIuo9nLtZ7fCi
	sfk4cd89y32Yo4uxKqZWJaXJP9lCbA3NIefVXDd0y8oCVQXu68ga9kSK3DB80VaI
	zk4+13npHrufTgvBKrmKOuxVRNAaA3upiRTp8zc/wvEQenZdaUM0tywlaeiz0/Ma
	L5vhZ9xiw4CocW2atMVATPGe8ztAM4mcfYviGBmJfOE8BiOnM8T8+4EIkDiWOQIu
	NiB8LvwcshCRX5H+LHSD3hE5qR17Gf0cidE5T51A9mDpOhgKZmgzOCUvqXjA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1712078995; x=1712165395; bh=dfma8u2u2CWS6L0t7pMbfPcLQMtA
	90cgEETDUHbYPSM=; b=mKZ1xW6z6+FxN3h4fVdXmMKwjqrlo9EWXMdGI+yLuYRc
	STJH3ZpO2xzRJMeyJ8TJP734DJVgXmu+jhakyWbcs+Emn7zGtfAz9B2Xo5nZ3bKC
	BFCD6C68OPWtn/RkQvBiK65MssBZWg1DrnA5YXhkYmRhjMgIdmPNfsIwlD4tN5f7
	u+H3uDtXHZy2n8UvW5nQNS6Iww6Ph7o8F8wlY15cHp0M5c6KI/3Qopu7gNBqFCeG
	q7A2KR+/jvrsZMjxcg/Efadv0kA2suxmiPjRRYRQ9CUuznBVm4TJ6UmzpuR5t//0
	aLGJzDYYbDta0sQnFJyOSIF4bYPOlv70ob0zN5sNnQ==
X-ME-Sender: <xms:kkAMZjuHuDNmecFtim86BykUQoc8Gy5d-geJUD0fLC5_wQR7sgKClw>
    <xme:kkAMZkeyauvbt4xcMUE_w-DaTR_8qpQMgJ7QPs7znhcZwXyHWfcly7ExtU7cCc-eo
    9wlYLgtHplhZ78Nng>
X-ME-Received: <xmr:kkAMZmwKbvuTifaosvevtswuukiWmvWpQjq9vm8y_IEI7Rq2LWZxLdxuzexE_CDCXE-x1BycJ0HSLkO36JP8paBjpqt70MnNjHBnXM6IKS69xW0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudefvddguddugecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeehgefhtdefueffheekgfffudelffejtd
    fhvdejkedthfehvdelgfetgfdvtedthfenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:kkAMZiPkqnOkN5-Ge9SJlG-B7VKLk-AdhMOrSQ1Eeq3IRHwERHtCrQ>
    <xmx:kkAMZj9ZQq_vEjcbb_ZegnQKDxB_7k2b11DtGCo_J5XJsfrJPYTl-A>
    <xmx:kkAMZiU2aaTsnFpsMkSbt2Bks_IOSK-NhussBbQKuAROKQeyXzX4GQ>
    <xmx:kkAMZkfdKvpNnjuwOIh_TUGwxPMtUnNx-ke25sDw9xlL_Yt9Oh9ZjA>
    <xmx:k0AMZlKv4ZAWwod7shVwWq59YmOQLLatVzcpjtZfEM5oWSwX5Hi3BMIK>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 2 Apr 2024 13:29:54 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 6dbdedaf (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Tue, 2 Apr 2024 17:29:45 +0000 (UTC)
Date: Tue, 2 Apr 2024 19:29:51 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 1/9] refs/reftable: fix D/F conflict error message on ref copy
Message-ID: <14b4dacd731a7d9c19029cd8a0c3b6170c31ae25.1712078736.git.ps@pks.im>
References: <cover.1712078736.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="dMB+5AQxFEiygoDG"
Content-Disposition: inline
In-Reply-To: <cover.1712078736.git.ps@pks.im>


--dMB+5AQxFEiygoDG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The `write_copy_table()` function is shared between the reftable
implementations for renaming and copying refs. The only difference
between those two cases is that the rename will also delete the old
reference, whereas copying won't.

This has resulted in a bug though where we don't properly verify refname
availability. When calling `refs_verify_refname_available()`, we always
add the old ref name to the list of refs to be skipped when computing
availability, which indicates that the name would be available even if
it already exists at the current point in time. This is only the right
thing to do for renames though, not for copies.

The consequence of this bug is quite harmless because the reftable
backend has its own checks for D/F conflicts further down in the call
stack, and thus we refuse the update regardless of the bug. But all the
user gets in this case is an uninformative message that copying the ref
has failed, without any further details.

Fix the bug and only add the old name to the skip-list in case we rename
the ref. Consequently, this error case will now be handled by
`refs_verify_refname_available()`, which knows to provide a proper error
message.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 refs/reftable-backend.c    |  3 ++-
 t/t0610-reftable-basics.sh | 33 +++++++++++++++++++++++++++++++++
 2 files changed, 35 insertions(+), 1 deletion(-)

diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
index e206d5a073..0358da14db 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -1351,7 +1351,8 @@ static int write_copy_table(struct reftable_writer *w=
riter, void *cb_data)
 	/*
 	 * Verify that the new refname is available.
 	 */
-	string_list_insert(&skip, arg->oldname);
+	if (arg->delete_old)
+		string_list_insert(&skip, arg->oldname);
 	ret =3D refs_verify_refname_available(&arg->refs->base, arg->newname,
 					    NULL, &skip, &errbuf);
 	if (ret < 0) {
diff --git a/t/t0610-reftable-basics.sh b/t/t0610-reftable-basics.sh
index 686781192e..055231a707 100755
--- a/t/t0610-reftable-basics.sh
+++ b/t/t0610-reftable-basics.sh
@@ -730,6 +730,39 @@ test_expect_success 'reflog: updates via HEAD update H=
EAD reflog' '
 	)
 '
=20
+test_expect_success 'branch: copying branch with D/F conflict' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		test_commit A &&
+		git branch branch &&
+		cat >expect <<-EOF &&
+		error: ${SQ}refs/heads/branch${SQ} exists; cannot create ${SQ}refs/heads=
/branch/moved${SQ}
+		fatal: branch copy failed
+		EOF
+		test_must_fail git branch -c branch branch/moved 2>err &&
+		test_cmp expect err
+	)
+'
+
+test_expect_success 'branch: moving branch with D/F conflict' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		test_commit A &&
+		git branch branch &&
+		git branch conflict &&
+		cat >expect <<-EOF &&
+		error: ${SQ}refs/heads/conflict${SQ} exists; cannot create ${SQ}refs/hea=
ds/conflict/moved${SQ}
+		fatal: branch rename failed
+		EOF
+		test_must_fail git branch -m branch conflict/moved 2>err &&
+		test_cmp expect err
+	)
+'
+
 test_expect_success 'worktree: adding worktree creates separate stack' '
 	test_when_finished "rm -rf repo worktree" &&
 	git init repo &&
--=20
2.44.GIT


--dMB+5AQxFEiygoDG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYMQI8ACgkQVbJhu7ck
PpSlBBAApdYgos2RP/VCWQn8t7o7/yRMifO7o69+ZcpJ4kwDIbqDRTpzbw63hhVr
OZCW7RIofm6BoZ9exUIyAUOjoI9u4w+ezfGLK5lsEcifzcEjr1MJRk6n7peBexLP
yoxluvDb/Kbvrk5RjG3eb3Nk14KTf9jtD1EhWy4wJn0XrzahW8IIOx93lDQGzWuA
2bUZuwV+xj7q+E57dGv++xo20F7Mv6U/uYiU2Ugi26cxH2tLjvRaG0Wqzvx09iqV
mUR7jKFgq7VCBXlRu21WqEg6dbT8+Y0ubViHG0tDvoEhv/5VFc7Nt04obaKFwPoc
OM7i+rSSAh2vFvjakFrnZwfvuhGHgwCDBX4as9wWlotmb2wrXDfvsew6SELRhSH8
0IJCPnvZ2OxAycgvysARTd1uivLIbKiwHLiyBEm0ismwfFT01DV4XahPG2h7wwb+
eE/8ci2L6WYaSXZNlzuRtyZWx0HNgr6ExgJq1AvltAtsziZhbCvkAmJGsLQKM1Bv
+qzAg0HlUkmR1c5/VX/XMKMTjFPjDjHd9nnNs0GkSHO/J3PMiCJHiZeK9trpF661
yzUbob5TmYXTLLU8NA29FOciasBK6L2L0obZt8GyzmwkoXHcOoGpUzteb94V5dLu
fJVnEZXrB4RZI+bFb1ACLGQdPi7VmzarOlJVnp/Q1Yts2rL7pWw=
=Ff8Z
-----END PGP SIGNATURE-----

--dMB+5AQxFEiygoDG--
