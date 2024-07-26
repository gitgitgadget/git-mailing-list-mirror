Received: from fhigh1-smtp.messagingengine.com (fhigh1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B0DDA3D
	for <git@vger.kernel.org>; Fri, 26 Jul 2024 12:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721996043; cv=none; b=q/0ROSJlH8WPU86dvxucEWJCZmB9Oh8e8tuKQX5kDt8q69d4B/pQtDzOqTSf5sk52RYLv7FB+5ibOs9ZMlN5RL4TE4NGE+Uegu5UTOPfolkbNbHh20owZ1jaBAFgsX4xSzpao7CZfCePMNfATzFioQxh5XdUKq6vQghsyYcLgT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721996043; c=relaxed/simple;
	bh=bovDlaA8IqMrn24FF+5FwoTdQctZyMqGHloc0qfpbn0=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=eZlRZMGz2Lz9TOyvl+5w5fuy3muMzqIYq38tOe4qOXEECxiUV2uP/1WbrzA6jP0TT6VQxIJvpSjHVw01oK2IsJRglCiPe1TMGRT+XCMFS3HYKokjTzxy2NbuQK0hp7Di7J1Te70okKAjISrgr8dp3/xgd96DlnrV1lyMCcDQWEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=eImanR2y; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XCkDKthe; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="eImanR2y";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XCkDKthe"
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 1271211401F4
	for <git@vger.kernel.org>; Fri, 26 Jul 2024 08:13:59 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Fri, 26 Jul 2024 08:13:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to; s=fm3;
	 t=1721996039; x=1722082439; bh=sIxncD2rmAdyI5HVsUToDUlKHIrShE4H
	HZbHPgn14CY=; b=eImanR2ydL0wQnWgK+qLA5uCzMf3X45Mh9bnxBoPq9ri88J9
	+oC8Hy6yUeI1pUFtgm5TGfUH+63zzPhgis+R5RXjq4FLEnGjHE7dJttRuQF05v1a
	o0BT0aG/cm7xcmSZ4sFrrZ42ZbzVcnhKdBi/Tn+VEr3BQ7qv3D4FkSS9V0+eAN/M
	n1KSVBdrxPuCqBPZvXm6KuOCry/aH/cp2pxWsiyauYKz/pqOJzPO+O3xsPhKnjp5
	hn1TaZclONK5+O3YJ8kCwIGnjGIcEkbk6f4Z/miXH6zUnZuM1ak4RjXzFisB1Rar
	RxcbGF40cTGipSpQ2bFhK1HU7BOy9I7kQ6l5Yw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1721996039; x=1722082439; bh=sIxncD2rmAdyI5HVsUToDUlKHIrShE4HHZb
	HPgn14CY=; b=XCkDKtheAAPqoYAqJFgwfgEXxgbBFcybmNBemhnK/wCmnVcqhMr
	QFbzet4YKDFJd9/8uP8FI+ysPwsTfTJHZ8XmlCTuzyP6UX8W0ohzJBypAQUO6E7x
	oiU8r2dlMahIWyPXgtjQROxPL5zOjTDti+qn2m9FZInYQZKBmfjqPJbRsyBuAXB5
	DpNWxS6DUxVzvadffKN2VTVBz5Gsx8i/29zKdppNu2Ge0yg1VKPJltfcgz4NYrdn
	Zd2YXsGjwQ1WpRxA9r/t9mVLP+FDuEekotFSkWDxzZ8YGe4z2h30LIPdb9vrwxwb
	KDXK1xD/izdR5AJoeVwecMT0Sq5AxeXLl/A==
X-ME-Sender: <xms:BpOjZnjH66w2pHQaUrViTDACP_8_tdMQTeoP2OskyH9SJi53nFf9jA>
    <xme:BpOjZkDaL7Bj0wM66Dh4HrhMtBpcEiZe6sLwjuO11u5gkzyIaYpAEVwucuN48pmUj
    T1OSd2WiPXUCN2VmQ>
X-ME-Received: <xmr:BpOjZnHF1awdWkcCPGCxdlu1FTCgWrTHgINozN9g95eZy3PfsYpDgYlfVMEEAGWgc3HuRX0O7eundLWL9Rzt0WpQDR8xhqISrIiqAI_MenEFnhoi>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrieehgdehtdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfggtggusehgtderredttd
    dvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdr
    ihhmqeenucggtffrrghtthgvrhhnpeejieefvdeuleffgfejudffvdeghfeigfejgfdvvd
    efudevffefveffhffgkeeiffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhep
    mhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedt
X-ME-Proxy: <xmx:BpOjZkQDeO0K3R2co2Bo9BUEITj4KqsvJEw6vj15ZCqMOftCRQLxXg>
    <xmx:BpOjZkxA_CVvIKpSN9DOcSrMF0WgBmfi8neYAoSIPnIeJ8GyFFx0Zw>
    <xmx:BpOjZq5EIn3qLdcyTQWG6mr2cDevU6oxIE3BgROSIOF9enCxEQ4VCA>
    <xmx:BpOjZpwjUbj3Xpxzl2p4WUzZeH6_lbLMoAG46H3VUiHoNH4jT_I4Kg>
    <xmx:B5OjZhqzqvZWWaWZM26xAw4YzEohemX9Sp6CvCUtkNeEslzxmIW0MUFg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Fri, 26 Jul 2024 08:13:57 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id c631e4bf (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Fri, 26 Jul 2024 12:12:35 +0000 (UTC)
Date: Fri, 26 Jul 2024 14:13:43 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 00/23] Memory leak fixes (pt.3)
Message-ID: <cover.1721995576.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="uG+OkPG1mTORAMns"
Content-Disposition: inline


--uG+OkPG1mTORAMns
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

I originally wanted to hold off with sending out this series until v2.46
was out. But I saw that Junio sent out some patches which are plugging
the same leaks as I did, so I dedcided to send it out now to avoid some
duplicated work.

There isn't really any structure to this series, I just happened to pick
some random test suites that fail with the leak checker enabled and then
fixed those. Naturally, I've also got part 4 of this series of patch
series in the pipeline already :) As mentioned elsewhere, I hope to get
the number of failing test suites to zero this year. Let's see whether
this is realistic.

Patrick

Patrick Steinhardt (23):
  builtin/replay: plug leaking `advance_name` variable
  builtin/log: fix leaking branch name when creating cover letters
  builtin/describe: fix memory leak with `--contains=3D`
  builtin/describe: fix leaking array when running diff-index
  builtin/describe: fix trivial memory leak when describing blob
  builtin/name-rev: fix various trivial memory leaks
  builtin/submodule--helper: fix various trivial memory leaks
  builtin/ls-remote: fix leaking `pattern` strings
  builtin/remote: fix leaking strings in `branch_list`
  builtin/remote: fix various trivial memory leaks
  builtin/stash: fix various trivial memory leaks
  builtin/rev-parse: fix memory leak with `--parseopt`
  builtin/show-branch: fix several memory leaks
  builtin/credential-store: fix leaking credential
  builtin/rerere: fix various trivial memory leaks
  builtin/shortlog: fix various trivial memory leaks
  builtin/worktree: fix leaking derived branch names
  builtin/credential-cache: fix trivial leaks
  t/test-repository: fix leaking repository
  object-name: fix leaking commit list items
  entry: fix leaking pathnames during delayed checkout
  convert: fix leaking config strings
  commit-reach: fix trivial memory leak when computing reachability

 builtin/credential-cache.c              |  9 ++++-
 builtin/credential-store.c              |  1 +
 builtin/describe.c                      | 25 ++++++++++--
 builtin/log.c                           |  4 +-
 builtin/ls-remote.c                     | 11 ++++--
 builtin/name-rev.c                      |  6 ++-
 builtin/remote.c                        | 44 ++++++++++++++++-----
 builtin/replay.c                        | 20 +++++++---
 builtin/rerere.c                        |  8 +++-
 builtin/rev-parse.c                     |  5 ++-
 builtin/shortlog.c                      |  1 +
 builtin/show-branch.c                   | 52 +++++++++++++++++--------
 builtin/stash.c                         | 18 ++++++++-
 builtin/submodule--helper.c             | 13 +++++--
 builtin/worktree.c                      |  7 ++--
 commit-reach.c                          |  1 +
 convert.c                               | 14 +++++--
 entry.c                                 |  4 +-
 object-name.c                           | 26 ++++++++-----
 rerere.c                                |  9 ++++-
 t/helper/test-repository.c              |  4 +-
 t/t0021-conversion.sh                   |  1 +
 t/t0301-credential-cache.sh             |  2 +
 t/t0302-credential-store.sh             |  2 +
 t/t0303-credential-external.sh          |  1 +
 t/t1502-rev-parse-parseopt.sh           |  2 +
 t/t1511-rev-parse-caret.sh              |  1 +
 t/t2030-unresolve-info.sh               |  1 +
 t/t2080-parallel-checkout-basics.sh     |  1 +
 t/t2082-parallel-checkout-attributes.sh |  1 +
 t/t2400-worktree-add.sh                 |  1 +
 t/t2501-cwd-empty.sh                    |  1 +
 t/t3201-branch-contains.sh              |  1 +
 t/t3202-show-branch.sh                  |  1 +
 t/t3206-range-diff.sh                   |  1 +
 t/t3650-replay-basics.sh                |  1 +
 t/t3903-stash.sh                        |  1 +
 t/t3904-stash-patch.sh                  |  2 +
 t/t3905-stash-include-untracked.sh      |  1 +
 t/t4200-rerere.sh                       |  1 +
 t/t4201-shortlog.sh                     |  1 +
 t/t5318-commit-graph.sh                 |  2 +
 t/t5512-ls-remote.sh                    |  1 +
 t/t5514-fetch-multiple.sh               |  1 +
 t/t5520-pull.sh                         |  1 +
 t/t5528-push-default.sh                 |  1 +
 t/t5535-fetch-push-symref.sh            |  1 +
 t/t5543-atomic-push.sh                  |  1 +
 t/t5570-git-daemon.sh                   |  1 +
 t/t6007-rev-list-cherry-pick-file.sh    |  1 +
 t/t6010-merge-base.sh                   |  1 +
 t/t6120-describe.sh                     |  1 +
 t/t6133-pathspec-rev-dwim.sh            |  2 +
 t/t7064-wtstatus-pv2.sh                 |  1 +
 t/t7400-submodule-basic.sh              |  1 +
 t/t9902-completion.sh                   |  1 +
 t/t9903-bash-prompt.sh                  |  1 +
 57 files changed, 251 insertions(+), 73 deletions(-)

--=20
2.46.0.rc1.dirty


--uG+OkPG1mTORAMns
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmajkvYACgkQVbJhu7ck
PpTbbQ//bnGcHc58zk6msA3bfe3eXab/J+rBgAbioLyf8IoiHzC0/rzGGixbJuEA
9dWdqq2+dVZ7GM1G5JKYZCAzsE0iO/qI9yzvDdfjJj1iOOo7bnNL8w6DHHMTaaso
ZQuylgZ0tmIR+nfk0ddVwdf60CInIhl8QzYkNzjXG8szP+F/Gv9GzWOyUyt81sD4
Cg0mkiEGvL8nE+j4BaVnH9UYMK9jg1ng3kYRGRzoS8KidQFutvHlKC2TRImhc3JF
LfYBYrlpveF6Bl5rYyeZLjopJn29cIzij5MzmHQshqoeMnBpVB46syiym3gXqBok
JQGvs2EnNrIKs6QKexLVU/O3l3MH3bOvixGuDMrO47GSo0nZ1vesNVfKbfh9tOUg
h/ytCXXDj3l1O6TPXDu9Q1beqI2zqroOpIjTzqi5ZXRbHaMHbuCFgwhv2IPKnLLA
oUHQ8n6ZtrnaKkroRoy0sNuA+uUD5/rd1fWD2FAz2spgGKUxrYQF28I0gHnbElVJ
tjg9dFwy232zNvrkUp1gBo1aegrPwMk3OQQLC3xWfLMSwtMa9ghfY+d96BqYmPzm
31p55HzWTJsacyNQRob/S3pNA2lACtOX9WeVHdYyXsHz5jRvi53msGpzDbIToksD
9rpU1tUh37JW8FfQNKIrQjJq8DNULUJdW+GokQh5GR+iuBvZZZ8=
=AcIZ
-----END PGP SIGNATURE-----

--uG+OkPG1mTORAMns--
