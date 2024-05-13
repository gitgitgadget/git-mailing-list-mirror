Received: from wfout1-smtp.messagingengine.com (wfout1-smtp.messagingengine.com [64.147.123.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7F345B1E8
	for <git@vger.kernel.org>; Mon, 13 May 2024 07:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715584513; cv=none; b=mlXqhmxDkJTIBPlOMthmYcQiTcX32/AQnQHrl64nTOgdr2xNgUQkDBwSKjOArj+Yup8KEi9OKc3dKs4gyrUMs3Yb65lU0FsO667oWbkybHhV6aq45VJCRRUa5ONBo8lplVZY4ASneewdPO+ibkqVfGNJ+mJEFjhI03jWqpADfDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715584513; c=relaxed/simple;
	bh=41bKQbkc7PXnTLyrULCtRD5BGIKNiZ1dIgUNMLDtnZ4=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=J0XaPW7Vz/IL7a75zvccvYyCfBdWF/feehQYyBgUaYIxr1ey+ydljDwN6RhjKbx+1O8/C72KpBhj0DCQh8kw7SoB0HOV3AHA1irhZeniaDQ4MgHSWaCoax2LQiviO4dLV8G+UogwipKXfZ/zAn+H4wwLqyPU1wcngk9ThMom6SQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=B18RTvGN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EqVMXh78; arc=none smtp.client-ip=64.147.123.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="B18RTvGN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EqVMXh78"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfout.west.internal (Postfix) with ESMTP id DBC641C00127
	for <git@vger.kernel.org>; Mon, 13 May 2024 03:15:09 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Mon, 13 May 2024 03:15:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to; s=fm3;
	 t=1715584509; x=1715670909; bh=WWpkL3yVbJ+ix1Pn4Z0ryZb9iO/JU0p0
	vMRYX7T3ibQ=; b=B18RTvGNTkh+gvJGPq5E18IrzJnO4OePWpf0aX16VedmAemR
	RMb39ffJe5yYUWDCdUT1ticKE9IjzFbU6Y3BKKKsqvPHpK6NZSrC90Hb+D8j7+e3
	A1LYmZehhiBvszQb1Nqo4AoiGUid2uHXc1z53il4KHcvfmCZXOhH8H3//zQWtUZS
	8O7FiMFO1sER9XotnNtNXvPTtUjKbjgS3nxIDduIcTvdqdSarvdpy+juLlkiYowG
	33RnC/HVy88uSi6l/rg0A4d5rbeKGcaPvEmUmiuCf7IiR0ORUwfYLHxX2rbkqK21
	ogh0s/WkDnWVMauEwPTk1LUiVAgKSe0sGqxuNg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1715584509; x=1715670909; bh=WWpkL3yVbJ+ix1Pn4Z0ryZb9iO/JU0p0vMR
	YX7T3ibQ=; b=EqVMXh78KvbXoaiEM5xQ753JIF460jUzdDdHkAenHSKmsVoGGeu
	7ntVr2EspVcjGzBUdjW6t+xhxelVieMhHPJCUgWVE4OFawl0RZkfeqoNn70wO7+x
	HKG7cKjD5AQypJBkbiYel3/SLLiDeCi3/cfq/gXMqJjDLPCMtWq1JZYBN/q1z8Zb
	Zsa4u/eMRxqnU5HxTBNwXpUlRonrLa6GYEVpCOW9UQv4yp5v2JYvU0Mpih8o5dUV
	2d3A1KnB8/5qsc8Sy2Mm4cdCywLzrbyPE+90/4dtrvVYoITQgzCiruJUygLqHg+F
	kOwGBbINoma02pMJZd6XtLXIjWkyjziC/cA==
X-ME-Sender: <xms:_b1BZkCnc-NeSoyI7dpbkJosqLDmthNdhljERbNmaLpYZPY-Vv-0YA>
    <xme:_b1BZmjSd7fq7WaXsU0T2nSCtK_ZWxu9jTM8ag4UxAuYYmhzKisVOMaBE9p81kZRP
    P4ye-HXtdcgZL_sew>
X-ME-Received: <xmr:_b1BZnleTuSUotEtpCg_Niq1K2PTikz9KvB6YkXPUEwO0L9eyAhJqeJzhd-E1kBOHXvkq8InuEOgTLMqv7GP3AbJnoYtnxWM1Zuk9hYcjqgYu-g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdegfedgudduhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfggtggusehgtderre
    dttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeejieefvdeuleffgfejudffvdeghfeigfejgf
    dvvdefudevffefveffhffgkeeiffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:_b1BZqxbrug_46XJRnAFc8Yci0ExNPJAPBIRrp0xvFRHSibtY2mT1Q>
    <xmx:_b1BZpRUbZ-ghlp4TeYb7f1s4ccyYZUBnxCQtkoOiuePd_0lkc-H2Q>
    <xmx:_b1BZlaX4OxYR4O7SqMgOuxPP0Ta-gICJlgJiqePZaT5d0N4QX13yw>
    <xmx:_b1BZiRFfS1MhLkqHQkoNKWiNbTsrpyI7_9gSatXMct1IgOByPpeyA>
    <xmx:_b1BZoKwnHjAI5Q4jeI2NOYv87uXeT9nqJbsMEYgoHmTT-UYYatom7gW>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 13 May 2024 03:15:08 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 84d6956b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Mon, 13 May 2024 07:14:48 +0000 (UTC)
Date: Mon, 13 May 2024 09:15:04 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 0/2] Fix use of uninitialized hash algos
Message-ID: <cover.1715582857.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="rkf0n8+62WHKumt8"
Content-Disposition: inline


--rkf0n8+62WHKumt8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

with c8aed5e8da (repository: stop setting SHA1 as the default object
hash, 2024-05-07), we have stopped setting up the default hash function
for `the_repository`. This change was done so that we stop implicitly
using SHA1 in places where we don't really intend to. Instead, code
where we try to access `the_hash_algo` without having `the_repository`
properly initialized will now crash hard.

I have found two more cases where this can now be triggered:

  - git-patch-id(1) can read diffs from stdin.

  - git-hash-object(1) can hash data from stdin.

Both cases can work without a repository, and if they don't have one
they will now crash.

I still consider it a good thing that we did the change regardless of
those crashes. In the case of git-patch-id(1) I would claim that using
`the_hash_algo` is wrong in the first place, as patch IDs should be
stable and are documented to always use SHA1. Thus, patch IDs in SHA256
repos are essentially broken. And in the case of git-hash-object(1), we
should expose a command line option to let the user specify the object
hash. So both cases demonstrate that there is room for improvement.

If these cases keep on popping up and we don't feel comfortable with it,
then we can still decide to drop c8aed5e8da. The remainder of the topic
that this commit was part of should in that case stay though, as those
are real bug fixes. We could then re-try in a subsequent release cycle.
But for now I don't think this would be warranted yet.

This topic depends on js/ps/undecided-is-not-necessarily-sha1 at
c8aed5e8da (repository: stop setting SHA1 as the default object hash,
2024-05-07).

Thanks!

Patrick

Patrick Steinhardt (2):
  builtin/patch-id: fix uninitialized hash function
  builtin/hash-object: fix uninitialized hash function

 builtin/hash-object.c  |  7 +++++++
 builtin/patch-id.c     | 13 +++++++++++++
 t/t1007-hash-object.sh |  6 ++++++
 t/t4204-patch-id.sh    | 34 ++++++++++++++++++++++++++++++++++
 4 files changed, 60 insertions(+)

--=20
2.45.GIT


--rkf0n8+62WHKumt8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZBvfcACgkQVbJhu7ck
PpQJ/w/9EoI0PM7cs5KlHdyIaMW7WuQu7XSqEVYTPFxzOpuPl/UDGKlh0x+xPfNV
cCCHTerWIPtM/NFOXCmI4aQS2LsNbl/+pWI7dAhiGIJF9p17/xv4Xsw6WpU4VxI9
HucnumX6tutjSt+gdbVNvdfTQQW5CLROX6mzHBBgcId+8JBXXWorMRGlAGq79aAz
Z20yOgH8fzKpnC9GfxAXd9TVgJBxCM/VUt3esMQ/5popcW9tpw34je3FN1HRwUXm
xYn3GeJJY00o9iVdUwJyVE9x/WEtgp9goLHRtnOJkaU1M/9nWXZGqscjOQwTsD6M
Enmh+19wEaW+9o5b38luPUVR7sRhNIH/PhQbCqVaLqjHmBZt41xRO5ietkKH+Kw5
cFqhibiHsYoGdnjk/7L6gfojjNbX8f3YpYrF2z4R4wAH2zopxzyLOV0ebaQW9E1Y
3sYJBdEqpukyZesfqHmNSPLdHYDY/FJDx3/C6BSgU2gJlffwgxnMQF2sY19hcwnd
XruTIIQ7WenPp2Yql6Ejr9YjcyVcVabxyZs38bMmSZIlhJUlWTbsauztalFGWC4j
Zcn7vTgjdKA86qS7AhA3BOYiDufs4rLhRED/pFDQoEr4uDSlc5RWATI76jWw3TMM
WXOwSPzNHX7ZswIbvy0eAbJDx7M645g07C1rNz8984aErygLCRM=
=dMUJ
-----END PGP SIGNATURE-----

--rkf0n8+62WHKumt8--
