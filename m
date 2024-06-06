Received: from fout4-smtp.messagingengine.com (fout4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3652713D2A4
	for <git@vger.kernel.org>; Thu,  6 Jun 2024 08:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717660877; cv=none; b=XTNQKmcxkO/4pl4ugWXm3GXr0wMtriAFp3bYneeGZwYbydIgN/v42wxF5e3uz7FtmYjsubAcQ+PtYrsXMaVsM9RHGro5L9F2RaT8pGCzuxA71DRSF/nyY1f2K09Z6wkeXtfOPv8gUg2SXy5jOERmbu+o5vCOYLdNyoOLGIvWSac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717660877; c=relaxed/simple;
	bh=/DUChj8jSyEDoy9MZKHYdXG8m4yZzrlL8o+xzKZjxeM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KdRhjaaKBE+jeDEafDr4LjSJ2SYxZuLaODQeo67l2loHXl4lBsXYR3kPuBWfSd7nElvnRcnfdWOZiNVP2Oxing0TbxhzZGVIIoTYqGe0eDo7jGWKxNvYry/pmymN7OYIm98RvTsb7UbhH4M/GgJmlp6CDxZa9ZjVgJhv6XvQ138=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=UE3jBAbb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ODN3DbU9; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="UE3jBAbb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ODN3DbU9"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfout.nyi.internal (Postfix) with ESMTP id 51AB01380114;
	Thu,  6 Jun 2024 04:01:14 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Thu, 06 Jun 2024 04:01:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1717660874; x=1717747274; bh=N6mmtVu9q+
	gdATPS1RbBYm3U/hc/yIqsopF3O43JriM=; b=UE3jBAbbxNL4CzMGPVlvE5NxlM
	yIr6Af7Zzxp1KQ5usn243fvzmBr73rWXt/Q69oTTFIFpawW3niT3BwGo7Zo+115+
	e22AWI4zA00nII/k3HXdqjXUGeViJcDdH8LIbHeKBZ6xLewS4aFADMNGGTOP+XjE
	k2CnfZibUtKPoIqdglGZz03ysXWl/REw3RXfHYKcgJ7gdk+FJaZwql6zgOognwxH
	TQPbSmFgda24rlX2gQ14ETXwkak2azyVPE28oJDPMFbmW+uYUdibhBHQv+1lLUKC
	cIUR8X7HkFve8t5sSGuVvL3fUzRQxHiaAxpcztaQ/+P2tXmDRdflElm/uICg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717660874; x=1717747274; bh=N6mmtVu9q+gdATPS1RbBYm3U/hc/
	yIqsopF3O43JriM=; b=ODN3DbU9ZmlyowyAmwSvN5yOh7Xa5QaGSbcmQ34vgHOa
	NYfMIen84HWygZgZtN/J4qlNVlN0GQcCLO07pQNsTQ7/EHW/SZbHty3/UPOEA+Re
	Nxht/P2TtkRMwRUqSuzBQ/MREJvj7KLrsrZJX/k+oXfJKxB87KxiX53kkcQNBtUZ
	M7MEWE2L1W1142pdj0s60h0efoxeGjs0WzB0anv+xSPvp8soAS4yMQZFb8ewwpKo
	OMdqxk0cC5/mRdJ8XZhfRG9P3W1uRhJ6I2971bIpxYpyxGgzk/DWBCHCZokailMb
	dWzxlyDsr9CpuIAY6tZyum20qDLVVMwMmGzHQuGppA==
X-ME-Sender: <xms:yWxhZmY7EcU3z_J75FukHdR7xw3dLTCEd3dJ6hkFOoDiinaZNHDrjA>
    <xme:yWxhZpYKsuHORBQhnxU96RL3h2108D1YQ6JqYe4x8kb4yrmNGpkcPtpxzF6ozXHk4
    Ue-_Ef23N82drxgmA>
X-ME-Received: <xmr:yWxhZg-e-dscuVEI0VGbzMgVA4__YophPcJKaCZ9hWCBEfS0qXhse_M30GA7vgtDZB7EWlbXs5cRG-DEEqer0x30JX_oJj9RZgadeG_soMk-uDb3>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeljedguddvjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:yWxhZooyAept-W_X8a4qYwf8LS9XyrsJw-_JCuky2-egdRnk8eQraw>
    <xmx:yWxhZhpFZjVxgZRXfNsQGw_tRd1wFOFrq1Nmk0a7GsX0a3l2n4-W4Q>
    <xmx:yWxhZmRkf1_1FW0gVkOr8Mb2u426ayQOqfPpKOGj8-jONr_lzvpYjw>
    <xmx:yWxhZhooPdTnAUz6YhRoc1nIhKXzwRtWVnmipz9Pg2I4fKoG5pyDWw>
    <xmx:ymxhZoVy4vJydUQHdztcbvSmKOK2NeCAc3n9PPSOt1A9Ydi57hvCuhj1>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Jun 2024 04:01:13 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 198eea69 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 6 Jun 2024 08:00:42 +0000 (UTC)
Date: Thu, 6 Jun 2024 10:01:10 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: James Liu <james@jamesliu.io>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 3/4] gitlab-ci: add job to run `make check-docs`
Message-ID: <d6d3628797a70ffff32676d3fd64f5179b19c94d.1717660597.git.ps@pks.im>
References: <cover.1717564310.git.ps@pks.im>
 <cover.1717660597.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="GpjnK78ToHknmBiG"
Content-Disposition: inline
In-Reply-To: <cover.1717660597.git.ps@pks.im>


--GpjnK78ToHknmBiG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Add another job to execute `make check-docs`, which lints our
documentation and makes sure that expected manpages exist. This job
mirrors the same job that we already have for GitHub Actions.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 .gitlab-ci.yml | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index f676959ca0..37b991e080 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -122,3 +122,12 @@ check-whitespace:
     - ./ci/check-whitespace.sh "$CI_MERGE_REQUEST_TARGET_BRANCH_SHA"
   rules:
     - if: $CI_PIPELINE_SOURCE =3D=3D 'merge_request_event'
+
+documentation:
+  image: ubuntu:latest
+  variables:
+    jobname: Documentation
+  before_script:
+    - ./ci/install-dependencies.sh
+  script:
+    - ./ci/test-documentation.sh
--=20
2.45.2.409.g7b0defb391.dirty


--GpjnK78ToHknmBiG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZhbMUACgkQVbJhu7ck
PpSCrQ//XOvPeHuqRDzcd9wdkyFTgtjJRXRW7oRgd5/mh/jlHt9gebos6Cxio2DJ
mBdFT/YyTXxJStf0+rPGcHWj1j0BQOeMzhXvTrLqsgb7J17iwAJu3XF3qAIPsnZt
GbdMTzsokn18IPXDDvIjZ+HOr48XJnIQK2KoLbSDoPeDowFbYhjXWX9PyqMWO6Ov
SYiMmPuMk8Lmgc+ZCDFq0A3lTefx93XhNaX+2KQo0Ax7UNs4+eq0roxFE8Mw+jDF
Tfnxab8XJzQkU/Lqo2ZV/G2Kyn+J1mAa/vDOsLQeCLyReN2FXOMJHjzKMZJNg/0k
Q/NUqgowYljGIFoZSvSo+RbFECNLtqq4H/joNZhgnen6D3AKTP1rJz5W0OpaZcX+
t2wH+BSFmSUM7dy8B9aMdVjjJZ5+0QyT7Hb4UZyG/TxAYSpO5xgpVOn4m5Tl4hNv
1ZaenCnQ2KIOfqhYRWEX9pF/2feggSweMuE3KAQ1cQJffx72XvYjRQrrL5ft11je
mpKCEc1PAMIXTCZyfDNPsrLY/HBfNbnQz55cXG6m4hkba5t54aAHg12+5oolCRHz
rjmDxeqJkloOkkeXHQoKM8q2/4aVpvE4gHKYyuY1F+R7qlVUh8y6kWLKqA83lfTF
owxWeQL0fhKjB17nHwJz3KUWFd8xSbeFaCSQH5rVmmv26m9WyPM=
=4sob
-----END PGP SIGNATURE-----

--GpjnK78ToHknmBiG--
