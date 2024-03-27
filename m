Received: from fout5-smtp.messagingengine.com (fout5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FC2425765
	for <git@vger.kernel.org>; Wed, 27 Mar 2024 06:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711521419; cv=none; b=ZDipQ0AMgbakJq+928uB+hZXuXbStG+09l0hbofH6IsSUZ//oclkIlXCs50B29uYIV8rQOFSzPdVOhTRjo3pEqjnqxMtxBHJAs5bA7hRvvCD15fltgidkoni7ma9L2piy4nsuO08WGV5gvughoyhrzmFUXJDHKL3DVpEVMlQnPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711521419; c=relaxed/simple;
	bh=y10Kb1f5IUmZNJesm5ilNbhrC/cmGAxur1TY8TiQqIg=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=d+MWsvrzqffAA7HwRkI+HMqettuNOVMCJlZVd1c8mTSsoZPNTc0IObmOq78XYXXhSf8t/1MGgGkDmv9pTYW0Zs0sQTg1DCi09+tF25ElehQXVf9B+FWcmWWpwnYAEOYgsH+KeQKHH3Hy1Vn/gUqrzJO9ydRLHmSbjOw4B4hS7uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=PS8sUymI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=l04YexIs; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="PS8sUymI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="l04YexIs"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfout.nyi.internal (Postfix) with ESMTP id 3480013800D7
	for <git@vger.kernel.org>; Wed, 27 Mar 2024 02:36:56 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Wed, 27 Mar 2024 02:36:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to; s=fm2;
	 t=1711521416; x=1711607816; bh=H41T6tV36oBLi0dJd1mMNfCLtuCNojQe
	rbwn/u/t7R8=; b=PS8sUymIiipg4wnVAq2iFSg7TYZLRwIFQOoeuW1pL/39+djj
	0ddZXbG1JcIHNPmPK4YRWsI+kBBcc8tphJ0Qrk6D0U6eHWnPybtWoHgfpyXMDqj0
	wjCl066athvx8vfGqU5bYO98vDqoNTaTMa75hqc8t34nF5vxbUlWLc4JXz3ODcbX
	iwOT6KfCDFtbZj+qKgS97ywuFsmjT8dt2LnOHaYreOnGwYYTKmONEyB7LChVE7ib
	xHFpTiTXyFQTWt6RCYStRsFdbXnF3YEWYGot+Cbccs/c9grydMX1x81xK3ebNzOX
	z4dJPQP+9dHlE+oQxl8/ucrVH0pkcuLHSEa9IQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1711521416; x=1711607816; bh=H41T6tV36oBLi0dJd1mMNfCLtuCNojQerbw
	n/u/t7R8=; b=l04YexIsfdNzi5i7aGaU0vrgTKXML9S51ItcYBqJ6FvTtM4BAmG
	dMG4qySxbRR+sczgr20Fms8PO/5duMXTH6Mz4UOnVzL9tRu2PzrW6nEENL6CNe0k
	WWi1+X52StE47Em8lY2rUMefj1Ei9bKlSiJuU4a/06+yHzJjJgOJxP4kap1lbTKN
	81IWcq4SgzZixYWMxzoKbwP1X9HmjW+XczmH3fCTfz/jDEVLxQeyPG9MrpZD1OFw
	ePYh037+6VYpwOONvkdRsqdHJTSfs3q4Xs9cPaCO38QLb5wvXpjop/6kVsqVo6R4
	lY526+zgn3KwdxCHksY2aw4qeC0vkUlVIUw==
X-ME-Sender: <xms:iL4DZoNC1Q7pDvSpeaP616fYHkM3WfkofadyQNsJovUsLh_MzuuTTA>
    <xme:iL4DZu8fSR1wt38w20F-A9m7v8eiLlgUumOHeX5jqTgfJ4MouMBaJztfHRSmsJ_Ba
    QnPbFXUkRpXhs0ouA>
X-ME-Received: <xmr:iL4DZvSqh9TMUsh4sVIudQbXFgYsuyax5F1dxUw2D_cEIaIxI4snVpURgQKiRuEFbfPAu2nHoefrvT1IUrRCWElEVgvyh3XKLeFiVCEaPy-ruQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledruddugedgleejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkgggtugesghdtreertd
    dtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhs
    rdhimheqnecuggftrfgrthhtvghrnhepjeeifedvueelfffgjeduffdvgefhiefgjefgvd
    dvfeduvefffeevfffhgfekieffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
    pehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:iL4DZgtuLteGCyNGThW7pxAcQ15NefyPTKEb41DNC1j3LbGD3mIIAg>
    <xmx:iL4DZgeBCo7hPVGRL2fixKSD_VLlcg-pfanrTX0IcDAW_Coa1SDc0w>
    <xmx:iL4DZk3Wv28iJCn0CKpBg5utol-QmaV5VeOdHZ3aYDk1PhBYTVU_TQ>
    <xmx:iL4DZk_-0LbEWuOuHfvULlSeNhBT_sssQgdUHBSfrSyR2kVE_URn2w>
    <xmx:iL4DZhoITJEyPXZ7jnGb5MArcx6xNnM3HGnuVzq4noL-0fGz-bmnEw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 27 Mar 2024 02:36:55 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id da32f37d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Wed, 27 Mar 2024 06:36:41 +0000 (UTC)
Date: Wed, 27 Mar 2024 07:36:53 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 0/9] reftable: optimize table and block iterators
Message-ID: <cover.1711519925.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="qAg+aKEi1eksBDrd"
Content-Disposition: inline


--qAg+aKEi1eksBDrd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

 * The code to iterate over reftable blocks has seen some optimization
   to reduce memory allocation and deallocation.

Preceding patch series have optimized memory allocation patterns when
iterating through ref or log records. This has led to a constant number
of allocations when decoding and yielding those records to our callers.
One thing that is still missing though is an optimization for the table
and block iterators which are responsible for iterating through the
separate blocks in the table. So while the number of allocations does
not scale with the number of refs (directly) anymore, it still scales
with the number of blocks.

This is getting tackled by this patch series now which refactors the
table and block iterators such that the former can reuse the latter
without reallocations. With this change iterating through records is now
using a truly constant number of allocations.

Patrick

Patrick Steinhardt (9):
  reftable/block: rename `block_reader_start()`
  reftable/block: merge `block_iter_seek()` and `block_reader_seek()`
  reftable/block: better grouping of functions
  reftable/block: introduce `block_reader_release()`
  reftable/block: move ownership of block reader into `struct
    table_iter`
  reftable/reader: iterate to next block in place
  reftable/block: reuse uncompressed blocks
  reftable/block: open-code call to `uncompress2()`
  reftable/block: reuse `zstream` state on inflation

 reftable/block.c      | 152 ++++++++++++++++++++++--------------
 reftable/block.h      |  49 +++++++-----
 reftable/block_test.c |   6 +-
 reftable/iter.c       |   2 +-
 reftable/reader.c     | 176 ++++++++++++++++++++++--------------------
 5 files changed, 222 insertions(+), 163 deletions(-)

--=20
2.44.GIT


--qAg+aKEi1eksBDrd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYDvoQACgkQVbJhu7ck
PpSgDg//dwElCwiIU96+mjlDytXF77CsJbQPv5YrpbsDnPJqzMiFeMT50tnmuCXN
3Z7pAshVmqwLVBWUG4QotGLlktlLMt23r4s2nC9Lrn8hCXFhDr4zpnmLaBWeLrLc
ApDNebjeuiV6dcHhHuazdjHNmP5eQ60j52pROSwUxeNLSfM31WiGfaDSbsJxxaZK
evtSdzEsMHH8j2y887sOFjJ9RwUAQkdMDmDxa8YcVPKUTpq44aepyha18I9nqVO6
B+N93iz2mBT1RDjvViN2064pu88ii4iXT++rFRceupVsDp3O9Sge8THiNL2yyQ3X
KjN1desRiB+EcnSnQHAvT3LFMqsux6jlgJbfiYwlmml/+o3R72+qMER2nIW8ofLy
G6LMfE9K5M4k11j00cy24jM5E9NzKjZ3L2XtTAaHmZ715WJYpvvd6YXZO50Mt/wk
EzExCUQRasFC3EraaIAQQGAVHgqHDoAbb0+ojJcgLy6oRfBxElGAH6rxP1FzaoGk
EgAjBjg1D5R7Lu9ejAHCdG/7HxJGpmYbiK+l4L386+JsGMT+KOSiHCQdm3HV/x/e
G+uEYdPGAX2mMtUf2+GUeOT2rrMEeK1xBsGjWOSFfbLBx/jHMGuxRBU8A/+UsMHv
SaFqiqaHpOZVLuab4ZNWfW7bfbVldBSJNXlQcDG0CzbQXyDuy4k=
=fBAA
-----END PGP SIGNATURE-----

--qAg+aKEi1eksBDrd--
