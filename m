Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F182955C08
	for <git@vger.kernel.org>; Wed, 31 Jan 2024 08:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706688069; cv=none; b=g5xoX3XRSpDZcMmHtPlGBE1RxC2XH8cs+F/++8HaVP3L/aqT+5KPSrA5xXwBzv78zNtdCqhAWmJBKI7PkzkJpJ9bAird5w+tZya91lAgRY6rsw0NQxZzLthwV394zrxGs/F6KEIWDg6U0D4sOutUauPjtxeH1jdAoF/kzU+Ye/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706688069; c=relaxed/simple;
	bh=FdHMtPNiRNMFaLjm17e+xvATgQ3JuT+D6hIziIdm2bA=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=eYLgRmVoEXwvxPkW3q50knNSy51MLa8UKeR6dL5xjOKjrRSaIjQYwJOZobONsBxqPWnwfyaE1cWgFpzwTbC1X6LFF+YNG7SMy+hicKqOepd9FEtK4DO11WcBFFu4BfBVWr8AGZVvCO2Z+mU1FZZCtWavQ/CBwIzELY/6qpwTZTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=mdFH4U42; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WJN3Ogc9; arc=none smtp.client-ip=66.111.4.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="mdFH4U42";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WJN3Ogc9"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.nyi.internal (Postfix) with ESMTP id C33115C011B
	for <git@vger.kernel.org>; Wed, 31 Jan 2024 03:01:05 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Wed, 31 Jan 2024 03:01:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to; s=fm3;
	 t=1706688065; x=1706774465; bh=xPgf0h16C7b0Zf8azgULCvd3f6vGOW6d
	WOunxCsEkOo=; b=mdFH4U425hlRYL+TXBN0xFmfKxVxmFZ01Lt9v7r4ertoaaCE
	niVpmvdvfnSJLB4CcodWEvc0yGoxK+y8+PBtifeQCZT0HRu+OLyTpRerV5tAaGzm
	fzLz3kB5KmWI6/pyPjm3ZJx6wAr52EE2+mdJ4eKRs8Z05zleNkkGUmse+wMzV7AJ
	2D2LueqRekU4aVj1VU8Wz69E1Z5idpodesAnVm9rmcWHAPRED1g11YemE+wWDJhf
	8l4/2G4CdCpp66+48nVjR2TC4bUMFEubNB2fDKpkPDvJ38hR5WxHfkwwK+HuUun7
	xpX2lOPfc2+NAEvHwz/9ktFQFeQR6EO5kMDTWA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1706688065; x=1706774465; bh=xPgf0h16C7b0Zf8azgULCvd3f6vGOW6dWOu
	nxCsEkOo=; b=WJN3Ogc9j5AY+wwQp7gO6ELW85DWxEeGWBVjlXAo9YJc+sYmXIo
	/D5HEnJG3yuO+WTJUN/9kukvNaWWCYJvUtiZJ2wKA+NTRY+hj4s/LsQ2OgzJSt/d
	7uLFHSTaVoUhV2xk86HI/1+HV11c9+9o0yyp473ttIyk02YOfBXeSVanOA6l6Iq0
	qcuelF0AJMRLzvv1w3gUqim5igchEPB0zQI5ephuO9ufAiM6AQxivp32/T47pvHb
	A3G1r/ydr+asVBdKAKrm0TtV1X0a6rxcNPjs2QnLi/pP1qWL6/cxejtmxeOk8hbr
	QgFXravGIYIRox7TRenE17Hpz5Nggz1hJwQ==
X-ME-Sender: <xms:Qf65ZdmBXyhz_80vBthFdGZYPgeo2iP8PBAxMaqY8Rt7CDcxfZXuUA>
    <xme:Qf65ZY1bVSnk_v5I5A1TiblgRPq2cKIJEfijZ6EDDP0Y54yIKP50f6LIiUNsHRMLt
    KzAkNjn4MOzEWvGow>
X-ME-Received: <xmr:Qf65ZToB9ezxWm4ZItUNhE2Z7jJAef5M7CSKXedXWCOc0iz4Kx9cZoKDQBsKfR3FzEAx3VkLvI-v40ue0_QKc2AnWCW4OozDs6LAaZKUs9Q8WZI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrfedtkedguddufecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfggtggusehgtderre
    dttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeejieefvdeuleffgfejudffvdeghfeigfejgf
    dvvdefudevffefveffhffgkeeiffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:Qf65ZdkNx7XI6qRPOrT3FqPix6lE_7oKbGDxBRRzCnQdbLTvhK-xJA>
    <xmx:Qf65Zb2fgWrSp40X_llW0XoC8rJCcJzvYAUnWHV4QW1eYtM3qlqVog>
    <xmx:Qf65Zctt13c6WAANCkDc2xoXqXMJ0OoXqko-XOQmUTnmEZtG_0npXw>
    <xmx:Qf65ZY9LBxPtv1LsVLIe8TGE8BtAC6jMawF26ty9yqYUY_yYdOxIaA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 31 Jan 2024 03:01:04 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 6f1d22d1 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Wed, 31 Jan 2024 07:57:42 +0000 (UTC)
Date: Wed, 31 Jan 2024 09:00:59 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 0/9] reftable: code style improvements
Message-ID: <cover.1706687982.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ACiHqbHuQpA22c2i"
Content-Disposition: inline


--ACiHqbHuQpA22c2i
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

this patch series contains a more or less random assortments of code
style improvements for the reftable library. The patch series is
structured as follows:

  - Patches 1-2 introduce macros to allocate and grow arrays. These are
    basically the same as our ALLOC_GROW and ALLOC_ARRAY macros, but
    specific to the reftable library.

  - Patches 3-6 refactor some code to use `size_t` to index into array
    slices instead of `int`.

  - Patches 7-9 are some more debatable cleanups that helped me
    personally to make sense of the code better.

I've been a bit hesitant to send out these patches as they may be
considered "noise", especially the last three ones. But the reftable
library feels quite alien in our codebase, which does increase the
mental overhead at least for me when reading its ccode.

I think it should be a goal of ours to align it closer to our normal
coding style, which will of course end up in quite a bit of churn over
time. A different approach would be to do these refactorings while
already touching the code anyway due to other reasons. But I found
myself doing the same refactorings over and over again in different
contexts for patch series I ultimately didn't end up sending, so I'd
really rather want to get those out of my way.

Anyway, please let me know how you feel about patch series like these.

Patrick

Patrick Steinhardt (9):
  reftable: introduce macros to grow arrays
  reftable: introduce macros to allocate arrays
  reftable/stack: fix parameter validation when compacting range
  reftable/stack: index segments with `size_t`
  reftable/stack: use `size_t` to track stack slices during compaction
  reftable/stack: use `size_t` to track stack length
  reftable/merged: refactor seeking of records
  reftable/merged: refactor initialization of iterators
  reftable/record: improve semantics when initializing records

 reftable/basics.c          |  15 ++--
 reftable/basics.h          |  17 ++++-
 reftable/block.c           |  25 +++---
 reftable/block_test.c      |   2 +-
 reftable/blocksource.c     |   4 +-
 reftable/iter.c            |   3 +-
 reftable/merged.c          | 100 +++++++++++-------------
 reftable/merged_test.c     |  52 ++++++-------
 reftable/pq.c              |   8 +-
 reftable/publicbasics.c    |   3 +-
 reftable/reader.c          |  12 ++-
 reftable/readwrite_test.c  |   8 +-
 reftable/record.c          |  43 +++--------
 reftable/record.h          |  10 +--
 reftable/record_test.c     |   8 +-
 reftable/refname.c         |   4 +-
 reftable/reftable-merged.h |   2 +-
 reftable/stack.c           | 151 +++++++++++++++++--------------------
 reftable/stack.h           |   6 +-
 reftable/stack_test.c      |   7 +-
 reftable/tree.c            |   4 +-
 reftable/writer.c          |  21 ++----
 22 files changed, 221 insertions(+), 284 deletions(-)


base-commit: bc7ee2e5e16f0d1e710ef8fab3db59ab11f2bbe7
--=20
2.43.GIT


--ACiHqbHuQpA22c2i
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmW5/joACgkQVbJhu7ck
PpRi2xAAi6AzpOIl7/ecx8kE55080GlGdL+2JkhMzIgT/xGZcfF9YXcGpQkZ42TN
xPslUxlVZsSI/CbZyrFZSxrvwSUMixyuFKfV6Ak267QhD3zhoYeUlmJ/QBQ0R294
NlKXcwz3l8lFxWvv0n+XiS27aF7WKy5qQldRMfCEKFvIA+BhGQxMrX5rdJbiYZbE
+l8BhUx8xbYXMdJIQYmDiRjVkVYxqXghIoEJjt+1eFBSWlGgiB1rlu4dmrEXaYtw
Jemf0HvzE7NVjUAWKaGJHfGVKKWo10iMSjtEoh6y5pNnH4ekiVK28pj8fmUhj5dP
yXUKrUgGOtRL4eFpk7tVtC0mpcXkSo0weICl4BLVWEsPChS7sQsT07ZoUua5VIYL
sPcpeV8Caq4ugu31ByiNYRL7SESGTarA05k0r+SbxtKGgjWwJD7JzNlrOd5Gwer3
aeJXm9h1Fm3f7CiYL5inykm9kDBwlAcKOwwOvXHXVnRvJN8+/5pv5sdlxMbfudnj
dIx3ZMRleH9rNBSuEyJt7T7zGo20Yq2JJX9HSFrB4FsjynzIm3NmcpMSKpFwcNVe
sqjr1yzAH5YrooLu+JCDxQy2cZxlKvIAmYrLcf6cE1YNcprPOHxeDR9NlGE6zilj
TKCXA5KsOOOi+AKZYxvv6CH51GsMDy/ljmqI6XfZu+8spgm15FE=
=0nl5
-----END PGP SIGNATURE-----

--ACiHqbHuQpA22c2i--
