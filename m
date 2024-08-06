Received: from fout6-smtp.messagingengine.com (fout6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BE9B1BE22F
	for <git@vger.kernel.org>; Tue,  6 Aug 2024 08:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722934780; cv=none; b=JBEIT0OyxArJgp72z/057jEbcoJSdAByETO8i9F2aI3B1LZxeh2L3aazGfk/MdvUubY+CmKxCYTgWXmcroqTcEdlJEQ3gaVqE7Is84Zt4p0/G/egBV2b+YPuqLE4ncmp41uWGEqMXOqqCuIHSSMZxQP84skNKFDPJYDwysQXi8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722934780; c=relaxed/simple;
	bh=kYR0YT3r80GV7fSh53jtLOqUcKoENlVL+XlkZDkpytk=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ccH6Bx9UHEXQzpa1VcB1nxF40H47WcsOePjNjh4aCkg1aZDDgdnN0fuAKhCeuP7Pv1nwFozz+hpHqkLNQnVhEjWqFs4XfB4v3afYi76RGj7Qq8hBnMuUfO5S1Bzw9E54WnCiNWGjG7nPUw1pQYL2DSIj95mfwRRdCBCf8/NGhrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=mCoPLna/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=u3x175ch; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="mCoPLna/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="u3x175ch"
Received: from compute8.internal (compute8.nyi.internal [10.202.2.227])
	by mailfout.nyi.internal (Postfix) with ESMTP id 6F7F1138FCB8
	for <git@vger.kernel.org>; Tue,  6 Aug 2024 04:59:37 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute8.internal (MEProxy); Tue, 06 Aug 2024 04:59:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to; s=fm3;
	 t=1722934777; x=1723021177; bh=BMF/3+C9yrystrb88ACdOlKyHynHRBUy
	j8Rwt9hDWyc=; b=mCoPLna/aEcUFiWQd/KiWrdiGQj/jINnp879RKT6h+EiSJPz
	uOxL8HYJEZOdTvDW3lN0b14GHyjINXWLJrXNuduk4Uk0YKI2t89Zezo8ysMh9u/h
	Jlo+lYs/+mlmTIH31PdxA/f9d4MuTLEeeFsAMqOjIGUXevETQofuRewQS/B3CUOB
	dz8oN3BbCdetSmmq7nwWKLOqYBddNeKchdsSmHF5o/GepDTn0O2xcfjGx/yK9UOF
	ad7EmA/Ll2ezhnV/PZhuWEzM53Ga8kAxthCPseXDuqmJr0RVfGhU0nCiD1tcxYun
	aDp/K5HG6iDGd0ftleUpIEUgmM6a4w2nBJ+1Sg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1722934777; x=1723021177; bh=BMF/3+C9yrystrb88ACdOlKyHynHRBUyj8R
	wt9hDWyc=; b=u3x175chYPofO59LWwtpjKUQpsskpo5HlPPfVJZym7J1xT0HhCJ
	XwD0BJslCswG+kPdnXTWFQMr0qDmSlhTWrgEbr4bHjWyUDr4M837wEu6rwU7c7fe
	WpDUHC3Gxx0dPYdWL3Chw28IY79ncIkLatA2zxOUh88ZCtxdzhAe/oi90qKclY06
	3jJfDTJqg9bZlM/WKnKWOHFuPBi0O3jFjXSomUsG5qyHh+SuVoe+o4e4hlU7bx77
	Z2cTvmhrURQh3EpsIaLLgXMCeHmZiqQLkv/6m/FB4G3GppGShRQ9BIwBIdYUtAPQ
	KP3hx+sq0NywEG9qnyWRMqv4WIFaJoDeQTA==
X-ME-Sender: <xms:-eWxZpcQG1SrAQTJcZKp7trxq94kZUyvF70rmsZJcdHDDm90UFbBpw>
    <xme:-eWxZnPWl6UdPr9316p_2CJvUV3jWdBjVsED0XfSm_qDZ26hUrpzPukxKzH0wvuWk
    LlnvdzAvu9xzvmBvw>
X-ME-Received: <xmr:-eWxZij5tU-OlI1XeW9tHrZzyH5OCpTrZVDG5JU4T4bipqGnXcArUHqWv4HspA4v_8i2qNgW6k6vJ4dyOipIHMyJnuUsIMQjelKWuVQOP4Ws>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrkeekgddtkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfggtggusehgtderredttd
    dvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdr
    ihhmqeenucggtffrrghtthgvrhhnpeejieefvdeuleffgfejudffvdeghfeigfejgfdvvd
    efudevffefveffhffgkeeiffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhep
    mhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedt
X-ME-Proxy: <xmx:-eWxZi9yGBToI1mJ6ot3mcQ1NvF0LMvqav5c8B08jhziLr-X_QNQ0w>
    <xmx:-eWxZluclsb8g7OkT3NDO_BhkhTi-5o97UZ1SPqQBHk82kHnSPFGLA>
    <xmx:-eWxZhHxZG2RqeEcdfx3QBf91gszb6jgmvLep7iddEvCxgYKSoqPQg>
    <xmx:-eWxZsN72bAZlQ5ZQ3ojTiDf3W0Op7tWTl94k9kP4qN910zvCUVGvg>
    <xmx:-eWxZmX0M5PACNNGjBSl0bRS6lRrB9RfY2RpcybVlWBybA0NZ2TAP1-J>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 6 Aug 2024 04:59:36 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 52138a7f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Tue, 6 Aug 2024 08:59:32 +0000 (UTC)
Date: Tue, 6 Aug 2024 10:59:32 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 00/22] Memory leak fixes (pt.4)
Message-ID: <cover.1722933642.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="YGH5ZIUPJMd9LUn2"
Content-Disposition: inline


--YGH5ZIUPJMd9LUn2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

the third set of memory leak fixes was merged to `next`, so this is the
next part of more or less random memory leak fixes all over the place.
With this series, we're at ~155 leaking test suites. Naturally, I've
already got v5 in the pipeline, which brings us down to ~120.

The series is built on top of 406f326d27 (The second batch, 2024-08-01)
with ps/leakfixes-part-3 at f30bfafcd4 (commit-reach: fix trivial memory
leak when computing reachability, 2024-08-01) merged into it.

Thanks!

Patrick

Patrick Steinhardt (22):
  remote: plug memory leak when aliasing URLs
  git: fix leaking system paths
  object-file: fix memory leak when reading corrupted headers
  object-name: fix leaking symlink paths in object context
  bulk-checkin: fix leaking state TODO
  read-cache: fix leaking hashfile when writing index fails
  submodule-config: fix leaking name enrty when traversing submodules
  config: fix leaking comment character config
  builtin/rebase: fix leaking `commit.gpgsign` value
  builtin/notes: fix leaking `struct notes_tree` when merging notes
  builtin/fast-import: plug trivial memory leaks
  builtin/fast-export: fix leaking diff options
  builtin/fast-export: plug leaking tag names
  merge-ort: unconditionally release attributes index
  sequencer: release todo list on error paths
  unpack-trees: clear index when not propagating it
  diff: fix leak when parsing invalid ignore regex option
  builtin/format-patch: fix various trivial memory leaks
  userdiff: fix leaking memory for configured diff drivers
  builtin/log: fix leak when showing converted blob contents
  diff: free state populated via options
  builtin/diff: free symmetric diff members

 builtin/diff.c                        | 10 ++-
 builtin/fast-export.c                 | 19 ++++--
 builtin/fast-import.c                 |  8 ++-
 builtin/log.c                         | 13 +++-
 builtin/notes.c                       |  9 ++-
 builtin/rebase.c                      |  8 +++
 bulk-checkin.c                        |  2 +
 config.c                              |  2 +
 csum-file.c                           |  2 +-
 csum-file.h                           | 10 +++
 diff.c                                | 16 ++++-
 environment.c                         |  3 +-
 environment.h                         |  1 +
 git.c                                 | 12 +++-
 merge-ort.c                           |  3 +-
 object-file.c                         |  1 +
 object-name.c                         |  1 +
 range-diff.c                          |  6 +-
 read-cache.c                          | 97 ++++++++++++++++-----------
 remote.c                              |  2 +
 sequencer.c                           | 65 +++++++++++++-----
 submodule-config.c                    | 18 +++--
 t/t0210-trace2-normal.sh              |  2 +-
 t/t1006-cat-file.sh                   |  1 +
 t/t1050-large.sh                      |  1 +
 t/t1450-fsck.sh                       |  1 +
 t/t1601-index-bogus.sh                |  2 +
 t/t2107-update-index-basic.sh         |  1 +
 t/t3310-notes-merge-manual-resolve.sh |  1 +
 t/t3311-notes-merge-fanout.sh         |  1 +
 t/t3404-rebase-interactive.sh         |  1 +
 t/t3435-rebase-gpg-sign.sh            |  1 +
 t/t3507-cherry-pick-conflict.sh       |  1 +
 t/t3510-cherry-pick-sequence.sh       |  1 +
 t/t3705-add-sparse-checkout.sh        |  1 +
 t/t4013-diff-various.sh               |  1 +
 t/t4014-format-patch.sh               |  1 +
 t/t4018-diff-funcname.sh              |  1 +
 t/t4030-diff-textconv.sh              |  2 +
 t/t4042-diff-textconv-caching.sh      |  2 +
 t/t4048-diff-combined-binary.sh       |  1 +
 t/t4064-diff-oidfind.sh               |  2 +
 t/t4065-diff-anchored.sh              |  1 +
 t/t4068-diff-symmetric-merge-base.sh  |  1 +
 t/t4069-remerge-diff.sh               |  1 +
 t/t4108-apply-threeway.sh             |  1 +
 t/t4209-log-pickaxe.sh                |  2 +
 t/t6421-merge-partial-clone.sh        |  1 +
 t/t6428-merge-conflicts-sparse.sh     |  1 +
 t/t7008-filter-branch-null-sha1.sh    |  1 +
 t/t7030-verify-tag.sh                 |  1 +
 t/t7817-grep-sparse-checkout.sh       |  1 +
 t/t9300-fast-import.sh                |  1 +
 t/t9304-fast-import-marks.sh          |  2 +
 t/t9351-fast-export-anonymize.sh      |  1 +
 unpack-trees.c                        |  2 +
 userdiff.c                            | 38 ++++++++---
 userdiff.h                            |  4 ++
 58 files changed, 289 insertions(+), 103 deletions(-)

--=20
2.46.0.dirty


--YGH5ZIUPJMd9LUn2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmax5fMACgkQVbJhu7ck
PpQw4g/+KTaolv8rD0Gy4z2UlEFncA/HjtJQMVfaxL+SNVUhEtnAFq5f/sGn0jDj
AQhfPQors/2QAeTqwa8RzfNFI9RZVqnak/dyD/G6LQI6xUVExa02Zpjt8FazuQtZ
YRgYZoS2OwntKubzudP8yR0/BtrPwu8G5Dq5P3YRkE/BBNZsbA1cP6uTTeM3TGbv
gsTsp0hCeydwfJq1Um3uxertaRaRrITjPoHaXL8L9s6nm/CxXLq20bUJplRfdeIV
trCW52Tj2tddGnRq7l7sC51ME349aJIYWNRdkN6OEu9hxyqhMXFcGs4KN5H/RHRc
2mL/TMyj353dJhU+Azt/1ASW5TAb6eCFpflwxxSYOhB4ponjreZsa/1Hy1k6ag8n
KIOZVyIOtZAUppXVnnZfcRvKT6SSD3hkKF5tkBaqV8acm+Q+Y+VmGkzIzq4Lvbvf
zpcbzzwWRjsEjbwNYaP7QG7uElgyYgH2MO0ZrP47qOrSS/2OuyojPVHmhiB7zzQe
YppfruHuWrBjsLrGa+yJnC4UO3fXsLjqYjTqWk2mHJ4oxb/9/BYDZHgLEX0J/4YO
6pEklNNjnFB9QYXHFOK2SeS5XU7Vabz/Kjrr58cc3v5YAPrSHH29TYqnyjYMf0pc
8FfT8VeeUsEI8i4fzBlLejP5x9O4z/EMc+3iIkaGAmRX2qUBEV4=
=h6L4
-----END PGP SIGNATURE-----

--YGH5ZIUPJMd9LUn2--
