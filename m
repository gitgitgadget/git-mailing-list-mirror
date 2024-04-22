Received: from wfhigh1-smtp.messagingengine.com (wfhigh1-smtp.messagingengine.com [64.147.123.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2818C2BAEB
	for <git@vger.kernel.org>; Mon, 22 Apr 2024 06:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713767712; cv=none; b=gboaOkqPUhzSD6rVpmmj6xlwjDj1qGOJ0xfKDP8ecwK/F5ojly8ujcoxsAcKGzNMOxxAV277pfc1hexFT15AG3JafVSCLdI5Txve28awTwtq1+8pzlfp/PWYnF6zeXnvNeVeCgHiOTNFunyZZVRrITSv5AR9erJk8GYxcHKLgBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713767712; c=relaxed/simple;
	bh=ViA69DBkuCoLZD09MTBQLrgijSlDt+dPk7IB/RET9fI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CQoP5C2BusJc/N/R4a87wHWUn9WuXRTUbodP5ieAsD1hJEINwBU6KS4hLtKjj2aoVfhN6dYdAH9E/8OZANeBQExi80FLRFI1o1O23k+/CbA9ov4jFs5rJMjIKQR4SiMtpwW9mAcLWCd0zEHyKe5qvswrJvHScIT6Nd6pyyCncO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=KRCf9Euf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SyrBcZ4g; arc=none smtp.client-ip=64.147.123.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="KRCf9Euf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SyrBcZ4g"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfhigh.west.internal (Postfix) with ESMTP id 2461418000CF;
	Mon, 22 Apr 2024 02:35:10 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Mon, 22 Apr 2024 02:35:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1713767709; x=1713854109; bh=wSUfi2cQfF
	hBvyRZE40eFydKinVGqyXFCG7161vjQ2I=; b=KRCf9EufUVTstx7R8KxSb69v4o
	ebOPzsi1WO2KzpA5UGO8Wz9F++RsYG8qo8OJXOFDfQAoPoRLri1mp1QlT+S/SnW8
	lK4WDI7dvMWEM12Gs7xiO7VOq0p3G3uxDaaOwVftqwEoY9Df4aML4+F2FHteeDG4
	ycLJUshzdWDRYowBT7lK78KKKltY8uAO9v8Q6QepoOuY1HzwyvR7Hyz3GyeYUbDA
	1llsnbpAzQffNvp7+jKmWerzBWqiSErfqz4BIBUeCxEbjHRJgMH+wDWlQN7vhmSa
	o2nAxJT0e7S1a4iwxcFOPP57oMMvDU8wwCGv4jCsOKUmkwJeUk7YydUrjgWg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1713767709; x=1713854109; bh=wSUfi2cQfFhBvyRZE40eFydKinVG
	qyXFCG7161vjQ2I=; b=SyrBcZ4gsf/Gzm/uUiNHHKbf0XkKYe+Vfl6pUlkoo3WN
	KknbI4lSE0kXW3XL9F3gbmQNlmtvKAgJlIGaOiJqc3vbd+f1iQVWyGIcEVtMugY7
	uJBZ/DknyxG4FpEHtFcPs3FAl3uqXOGLV2polhF+KFwVZ+u9/41E+wnGgVuuOYn+
	9I2ANNKAaLLdyYhcoCXsM2T7w0kMiFUL63icZ2eM78HIrfz/avVJDba7T5rURpmg
	b3wv9JOqCTGOkT+jvRBgIdFa/Iqb8IQ1UTqM1BDTgWw8irEI6pE191gXI3FzJozO
	hpkwa4ejotYvIfp3EEO97fnpMP1+ibP9EvcSiinkFg==
X-ME-Sender: <xms:HQUmZszwXJDh0mXDYi8oIAN6HiMzbZEgiEvnOot9rbfK2mJ5ctUrIQ>
    <xme:HQUmZgTr7yOdPgCHjovWDQ5VO9ngnzFiL7M2-N94YiJt2myhmksPv-f0-QPmWcOMi
    90stB8eJ4XeOxUCMg>
X-ME-Received: <xmr:HQUmZuUAXfEUCYQIU4ulDimsZxsakbb7WE7fhUHvZDV9C29JwRNQs6K4Yn-0KEZKtMQ3_btXQtbE5phw4QRfTWzoKrg7cKcvwR0tsmglIVQ-1kgX>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudekkedguddtkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesgh
    dtreertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhs
    sehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepueektdevtdffveeljeetgfehheeige
    ekleduvdeffeeghefgledttdehjeelffetnecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:HQUmZqiLZgH3U2IONg8REZnek22wlK1fAneIRVmyDBjWiBxuNIML5g>
    <xmx:HQUmZuAqRmWNhdTHdVx9jJkx3q-719_2UFxSkRos554EMxIXganPbw>
    <xmx:HQUmZrIdzHAGNG4ZygostUZXSozEBlpnfpJtEyiagHTNZJYPO3ujNg>
    <xmx:HQUmZlAiTJjtIRGBgN56gpOOcyv6_qxb_1hRBxMRsZ6pOZqdrmygsg>
    <xmx:HQUmZhO017EgeDOQDVR5y9CjFpnZcPJOr_ru5_gGHirWz8SH4Ucstw_d>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 22 Apr 2024 02:35:08 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 01e21422 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 22 Apr 2024 06:35:03 +0000 (UTC)
Date: Mon, 22 Apr 2024 08:35:06 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/2] docs: improve changelog entry for `git pack-refs --auto`
Message-ID: <2f8c2d54d73cd53f6d310513fe5aeed05a5b7a4f.1713767605.git.ps@pks.im>
References: <cover.1713767605.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="plKAopWAEEMSHXrx"
Content-Disposition: inline
In-Reply-To: <cover.1713767605.git.ps@pks.im>


--plKAopWAEEMSHXrx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The changelog entry for the new `git pack-refs --auto` mode only says
that the new flag is useful, but doesn't really say what it does. Add
some more information.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/RelNotes/2.45.0.txt | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/RelNotes/2.45.0.txt b/Documentation/RelNotes/2.4=
5.0.txt
index 0570dcd877..0fc29bc3ad 100644
--- a/Documentation/RelNotes/2.45.0.txt
+++ b/Documentation/RelNotes/2.45.0.txt
@@ -77,8 +77,10 @@ UI, Workflows & Features
    skip showing the hunk immediately after it has already been shown, and
    an additional action to explicitly ask to reshow the current hunk.
=20
- * "git pack-refs" learned the "--auto" option, which is a useful
-   addition to be triggered from "git gc --auto".
+ * "git pack-refs" learned the "--auto" option, which defers the decision =
of
+   whether and how to pack to the ref backend. This is used by the reftable
+   backend to avoid repacking of an already-optimal ref database. The new =
mode
+   is triggered from "git gc --auto".
=20
  * "git add -u <pathspec>" and "git commit [-i] <pathspec>" did not
    diagnose a pathspec element that did not match any files in certain
--=20
2.45.0-rc0


--plKAopWAEEMSHXrx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYmBRkACgkQVbJhu7ck
PpQ7UQ/+ODjy5rXqxTELuSgx4DRyY6gmJceYpkFbcG0ZruF06jlMrX9qBB6Vp345
U+E8Vc8dXueWKsBO2cYfoTNr2zDB+iJ1cVBIHq9QQwumTO/qTWrOiBClWVq+ZNDj
se5KDc2E03Io62lMy2kUv1zyW7sb2fq9VxMDDRj6iPzOzPqPF+yEJiuCPkMjX4Nq
T8J3cdJfZ+ovMEf+d/+nCk7SChlw7VboJiq4f7Z5bzs//xThAJHqwrtTYHW1kCR8
RGKC7DDRdJNUQl8K8e9NPOQaZ1eC6Ht0Dn1BHLjiVswZqj0IFevKZJzq6Iv/KdHE
VytxXf2euphGjHzR6qlwTgzZMeLgIJB4otLrWqJ4oidUm1lRF3sINiFc2uzb5pDl
t3s74R9PZw4v1RdaNWSWlumdmI6iekFLp3H6eEwbpZ7Dl06RFcw7VIed37bHA9Yu
q/LAd/tWE7xN5hzhN4Ky0Imx8okzVIwiK7bHW7MT6R7Qf3LGoJbqigBOkpLl0Y9c
L1w1q339NAPg9NS3cPwEksvy4Wn4lzyKAzsWtBl/KTBcHpoPyjalJ1PP27NJ6BGj
UzvTAOjBZJt5Ny5+AWPcuaqSafqdhAUhCn8eYgIVzTJIUsl9ABVru1lPo9sFwfbz
y5k0DPym/cVgWLcTYJmChriHWg7+pkhC/3Sr7CNVQ15IwsIEwHM=
=MIQj
-----END PGP SIGNATURE-----

--plKAopWAEEMSHXrx--
