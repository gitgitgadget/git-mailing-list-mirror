Received: from fout5-smtp.messagingengine.com (fout5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3467F1DDEC
	for <git@vger.kernel.org>; Mon, 19 Feb 2024 14:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708353323; cv=none; b=qrzw5prApwU0p7HzbWFQmiG3nyBuXk2yYBW5H81IdaoonfWJsO+3hUByaaFqsNzVwUSoyKEyeMZwUObd2vZTQ/8r5o6QlxIot5o/+i7rqodF73xMfMRFRlY3k7YfFvAmHwrSGLGtY03lSqxQP7sGpw2tXoOQgrHcxtnREvhYxb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708353323; c=relaxed/simple;
	bh=E0PpTx/Sg/4P/8wHdgWHO+RJy90C7Wx7KQ1HW4pPq/Q=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=elJiWSBrY2bzTKaE/6+edeWZIArBBTi7wrELtOc1Ku2HTBRbzSOMsKsWc4MXXf5oP9WwPlarDyj5ryQTGGXbWB5Cq3FbKBSlnyM504Nep/K/AexbVdhq1s2Sd/f/9PQn0sWIPhJhdy8T/rJ7DkdYlndAEbvbvVcRTLXUBMWAlkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=eAo0NiBx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KmUJagZM; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="eAo0NiBx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KmUJagZM"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id 0749B1380102
	for <git@vger.kernel.org>; Mon, 19 Feb 2024 09:35:19 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Mon, 19 Feb 2024 09:35:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to; s=fm1;
	 t=1708353319; x=1708439719; bh=N1b+3dKWI3yPA1UHMk1w4jVm1IASYsU5
	BRh6HqKzBM8=; b=eAo0NiBxdqBZRi18OZD10abGkfWb0Cw29M3HincsFafNMhcQ
	fQ/xHr+muq94EVV2g3j/eH3g92lQtNxoPrPPIH2Ddf+RKCQ7qSh/lQ1leKFZyPe4
	5Iiam+jC5QE5x9bRTKp4Mo1hX0Uf4fdCsYCPUPLMaLe1PWUU8v7oLbtJ21SJgv3z
	bnU9BKOvAn5Uhb1HHEOmqSQsREfHxEh5TCYCRCcSP++on5HBG4dM8IqP0NLu5nX5
	Xk2r3o9zaabViHXcyKOqRV5dGhn+kn/gRZn95ilb9hAqQWVQkypasqbhCELHNi1B
	Gd8ZMnrPhYY57x2ueuKskVGEmi2vlbbjH/dd9g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1708353319; x=1708439719; bh=N1b+3dKWI3yPA1UHMk1w4jVm1IASYsU5BRh
	6HqKzBM8=; b=KmUJagZM7xAOkKLw+/UmBqx5ZZYfrrFUrQHCCc0ZLJRJwKj+9ao
	swcoJBeabEw1pgnOpc1gxAzPj2F60ynppK7VIpWjMPfUGJkY6r6saFrERgjScUqX
	1O+AQKv54N2DU1NJfWoYtMABG8yHj8uNhIva5qDXF2ZxSlmdY2VnBGDJeMz/R4pN
	JH78MuWwUvCaQg9GLrGdNovLE8AeoRrXAbYVfLy0Iw3eICXOe6sW5LfaWC4XZQIU
	HvNBjEZzeLW1ASyyoT0vmyogwZcweDdOhDzpG/EyyWnSyfd0QTkXCWvW6b+iWXpa
	M13+hkEE09FOWodNg0NBLvdtwDIwaTZF2Xw==
X-ME-Sender: <xms:JmfTZYfjoFoZ15miWoE9XzG54N2WZddqd-EqRvGbD3zqOx6pB3kKSg>
    <xme:JmfTZaNGVj1RH-VrWiTSEbV8SeDfP5iMbbFU6FdOTiDIs4d6fN_b2OfjY9L5N3zgx
    2XESXcjyvjYr2dUAw>
X-ME-Received: <xmr:JmfTZZjd1hCu3dSJ94NKMMJZtJ8JAA50vU_PCuSNNyyZBZfis5P0st48ihNvpdgA1KO90CNkf1HpAYegSkBP-3XaW5hJg8QC_2bhYQENcUjrZxbn>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdekgdeihecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfggtggusehgtderredttd
    dvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdr
    ihhmqeenucggtffrrghtthgvrhhnpeejieefvdeuleffgfejudffvdeghfeigfejgfdvvd
    efudevffefveffhffgkeeiffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhep
    mhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:JmfTZd9VlpNhb9YAQ0E-_peNirWWswezX8eyUjwGBt3xleKQV7An1Q>
    <xmx:JmfTZUuuALDWlewqoj9B7v1wUdea3ibGwLLrJ535VY59g6maSJAitw>
    <xmx:JmfTZUE07MQ6n_uYrGEJppQKYODzE678D8Og7zCZDz58peLSOF-oyw>
    <xmx:J2fTZRWeSGtgH4NccksaxnC_w60msrp0kwuCDG59axZQyMIfuSnYtQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 19 Feb 2024 09:35:18 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 726f28ae (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Mon, 19 Feb 2024 14:31:15 +0000 (UTC)
Date: Mon, 19 Feb 2024 15:35:14 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 0/6] reflog: introduce subcommand to list reflogs
Message-ID: <cover.1708353264.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Rvgc72OV+k6vL3em"
Content-Disposition: inline


--Rvgc72OV+k6vL3em
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

this patch series introduces a new `git reflog list` subcommand that
lists all reflogs of the current repository. This addresses an issue
with discoverability as there is no way for a user to learn about which
reflogs exist. While this isn't all that bad with the "files" backend as
a user could in the worst case figure out which reflogs exist by walking
the ".git/logs" directory, with the "reftable" backend it's basically
impossible to achieve this.

While I think this is sufficient motivation to have such a subcommand
nowadays already, I think the need for such a thing will grow in the
future. It was noted in multiple threads that we may eventually want to
lift the artificial limitations in the "reftable" backend where reflogs
are deleted together with their refs. This limitation is inherited from
the "files" backend, which may otherwise hit issues with directory/file
conflicts if it didn't delete reflogs.

Once that limitation is lifted for the "reftable" backend though, it
will become even more important to give users the tools to discover
reflogs that do not have a corresponding ref.

The series is structured as follows:

  - Patches 1-3 extend the dir iterator so that it can sort directory
    entries lexicographically. This is required such that we can list
    reflogs with deterministic ordering.

  - Patch 4 refactors the reflog iterator interface to demonstrate that
    the object ID and flags aren't needed nowadays, and patch 5 builds
    on top of that and stops resolving the refs altogether. This allows
    us to also surface reflogs of broken refs.

  - Patch 6 introduces the new subcommand.

The series depends on Junio's ps/reftable-backend at 8a0bebdeae
(refs/reftable: fix leak when copying reflog fails, 2024-02-08): the
change in behaviour in patches 4 and 5 apply to both backends.

Patrick

Patrick Steinhardt (6):
  dir-iterator: pass name to `prepare_next_entry_data()` directly
  dir-iterator: support iteration in sorted order
  refs/files: sort reflogs returned by the reflog iterator
  refs: drop unused params from the reflog iterator callback
  refs: stop resolving ref corresponding to reflogs
  builtin/reflog: introduce subcommand to list reflogs

 Documentation/git-reflog.txt   |  3 ++
 builtin/fsck.c                 |  4 +-
 builtin/reflog.c               | 37 +++++++++++++-
 dir-iterator.c                 | 93 ++++++++++++++++++++++++++--------
 dir-iterator.h                 |  3 ++
 refs.c                         | 23 +++++++--
 refs.h                         | 11 +++-
 refs/files-backend.c           | 22 ++------
 refs/reftable-backend.c        | 12 +----
 revision.c                     |  4 +-
 t/helper/test-ref-store.c      | 18 ++++---
 t/t0600-reffiles-backend.sh    | 24 ++++-----
 t/t1405-main-ref-store.sh      |  8 +--
 t/t1406-submodule-ref-store.sh |  8 +--
 t/t1410-reflog.sh              | 69 +++++++++++++++++++++++++
 15 files changed, 251 insertions(+), 88 deletions(-)

--=20
2.44.0-rc1


--Rvgc72OV+k6vL3em
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmXTZyEACgkQVbJhu7ck
PpQhIg/7BZbW19JrV9/4gIwrpVUzYGLAc2+o8Bh7eW+Z30Fhy9KEzY1/IRuXhvin
1lZ5m+u7ryuQop2PuqYLZgB5bfHNVyXS4NBlvqVRHEFLdQaYO/OZ/eYDDeBsrbpn
SouDKGns7PNFFF1AuYBKVOt7kv7feDpSe9TMyvnHbTKnq58MoMGUltNoYp0qqE90
HWha0pG5/sYSlTz/btzGMR2SazhCTmiJyHBsckE84Cf2CUPIQ6Qb+J4PB7MKvRRJ
9BBsSOnnCyDU7sy10Ok/X13oNHT1zFRtRqW7ArXAi5VktC30/oZKXQRxK4QoQSJW
m2MgrFUHefuU+ORxOhIS6WFiOaE71uQfkcXZmRphhZHOA1X9fPRAVoMHsqNBcaP2
AoKDIW+Abg0t0c1RAdVRnqTthfwPTv9NV292IX4wslsmBABwPnGJ1nvqZOWXLRQT
M8OoRaDGCgLm2u0WBACusV0llyMJ/2megINF5w+RUrUPAPtO4YBdnKr9obnn0G8U
6SeWC9NkaWPnIppQH+dusKC2LSVtNv3i3NLPNdFtp2OsgsqE0g+diuuyTDurzz62
dm+PGbX4ai4tjxbBLRCYDfnQtkmrjnpUCu9rSvOp7Bxh4/MXouM6FHS70ztGS6eD
a9vzswderleEw9C6r2XrdKezM5jNj39S3EpRalIUuPNq3H4RxY8=
=Ma+n
-----END PGP SIGNATURE-----

--Rvgc72OV+k6vL3em--
