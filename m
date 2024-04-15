Received: from fout2-smtp.messagingengine.com (fout2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B256A1DFD2
	for <git@vger.kernel.org>; Mon, 15 Apr 2024 11:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713181359; cv=none; b=ZjdZt9FXj8mO4s8eL59F/8qzLy5yUJwZ6C2Eke5LDWTcP4pd1tVmhsJtfrbo4VnIXUz44ONzEGxWYganYcAPklGFpE52GbbxJ0XG5lzA6OyKkYNlBHzE6C6K5eHRLcMAeermJEBFB4jdeFEHclFJRa7fQTD6hpqei+kkRLt9tKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713181359; c=relaxed/simple;
	bh=etGlHFMdj66vcoKuKY9cke6tBwg2+UtVq+D8jRNr+5c=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=QBmPnFUWOvvZ6Xx5eSU6y1jc65rbPzqXQhYWBDAiQqDKQa1Kmy+cauhutxmGmJJ4GPEsLk6brJa2uUdfcp6KbjzYHqYlD27MtN9ntmCwCyAMEPfo47SiQPcxPOiON25B6ov1Rxlg0yxtoZ834EXyznITV9Rt17gBzfIgAfAuo88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=OcK0swpb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NJrTnewB; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="OcK0swpb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NJrTnewB"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfout.nyi.internal (Postfix) with ESMTP id 7DB5C138082D
	for <git@vger.kernel.org>; Mon, 15 Apr 2024 07:42:35 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Mon, 15 Apr 2024 07:42:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to; s=fm2;
	 t=1713181355; x=1713267755; bh=exsJbHYFA44OR0999AnVL2Mf63n+qwgg
	AUrqn7dXM3c=; b=OcK0swpbdIk1OOFM5B0OW2sGbneB6ronD+h0XYyE81iElzhr
	1JEpjaBkn4M04aG9l3vHpWekj8Qcd5bS9WjuAnm8pDOZRC+oOTfpxkx49p5+1+eA
	T6qvT+kLQCs6QnBIbp2I92zrmXzzS50Q45kN03WZUAcS4QB1lNGx2VGN/lCnFvRs
	PL5AR2kIa+vPJdhHKUvCRe7htrG2jmDPeNPJ6MyxTSSploA9v0PkA5ysD/F99oMd
	7jLSP9VkNiJ2ZPViH+Y6nw1waCkp56njFOD6fH5sMFC28zBzbH2ebcUsSqRkNuuV
	AGVcO3KSrGqgyWjnnwEQCuUvoz/E86mEmyjlJw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1713181355; x=1713267755; bh=exsJbHYFA44OR0999AnVL2Mf63n+qwggAUr
	qn7dXM3c=; b=NJrTnewBk6G38lUb42RJGwCMmn+HT5IWrhdVuVKQfmNDW4EmXYS
	1ArlsF2Hzj7V+MOZGEDnqPU/65+1OUlTttG68hQhaBtK3ftISByrKBWqzQgVOoD0
	+GiG5JuER41Ve4Dcyw50wlqRj9PKmnksJWvE9cOX+XQnU4g+12pL8nohQ8XquzK/
	bcI+8Re6Z0xtBeOo47Ao8WpAsoNMBSObIapdWgMi7v4bKjxWH7QCJdhfqgEQ6H7G
	C2MoYx3LCQ7d+3bylrGpcuZb5HZ2s5I5sGwCuL1RGSHL4u9IbePL+NXgBNkVTD60
	eIzJ6AKJiW7GMP3ovl2roLuhQaLBm+IXl7g==
X-ME-Sender: <xms:qxIdZl_gJVNkueTN7kAE9n59SmxJpilnfZVa87z2iU266jZlsYac1g>
    <xme:qxIdZpv-P_BnfvyWd2F6Z6IoKPkNdrI4Sbj7jYTgxQFOovOCuXOCGtcbYXOf39CdH
    b-jTfZqbElU4UlIAA>
X-ME-Received: <xmr:qxIdZjACQ-Jk8RBeMHEhiCK562p9CW9hWU7FyLOsqJvOHdq6RUU6aSgiPOWqYqmCZIShw6kJo0qtY-3awB6BN4elTMWceryOsTIvU6TG06hypM8q9g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudejvddggeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkgggtugesghdtreertd
    dtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhs
    rdhimheqnecuggftrfgrthhtvghrnhepjeeifedvueelfffgjeduffdvgefhiefgjefgvd
    dvfeduvefffeevfffhgfekieffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
    pehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:qxIdZpd6onOD1Ak9z5p1RYZmJF-QVehjptKMDdVGWETAZy--RIunFQ>
    <xmx:qxIdZqOgyWeSWBA7Tpf9LjKjektlQJcICIATelSyym5jEGXCZmKO5w>
    <xmx:qxIdZrlzVkhjr-tCjJkTJUSlckeXbm9SDnOUQsZliFEUeeiK_4XmEw>
    <xmx:qxIdZksN8QfH02EMEDAl3Ij4EcnRfFRmmsCddry2PFUEPD_qeJGPBw>
    <xmx:qxIdZs2hP268GNNhqrAL92Giso8UiejQXlTLcqhcjnTXzdHUb8BKUhSc>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 15 Apr 2024 07:42:34 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id ab49ad94 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Mon, 15 Apr 2024 11:42:12 +0000 (UTC)
Date: Mon, 15 Apr 2024 13:42:30 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 0/5] global: drop external `the_index` variable
Message-ID: <cover.1713180749.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="6kF4Cr5VcyonWT5n"
Content-Disposition: inline


--6kF4Cr5VcyonWT5n
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

this patch series converts remaining users of `the_index` to stop using
it, instead using `the_repository->index`. This gets rid of one more
global variable and brings a project over the finish line that has
started back in 2007.

I realize that this patch series is quite large, and that reviewers will
eventually start to just gloss over things because the conversions are
kind of boring, too. Also, due to the size it's quite likely to conflict
with in-flight topics. So if you think that this is too large, please
let me know and I will happily split this up into multiple series.

The motivation of these patches comes from the introduction of the ref
format extension. I found it really hard to reason about the state of
`the_repository` and would like to continue its deprecation in favor of
explicitly passing down a `struct repository *`. Getting rid of
`the_index` is a first easy step into that direction to make things more
self-contained.

Patrick

Patrick Steinhardt (5):
  t/helper: stop using `the_index`
  builtin: stop using `the_index`
  repository: initialize index in `repo_init()`
  builtin/clone: stop using `the_index`
  repository: drop global `the_index` variable

 builtin/add.c                        |  48 +++++------
 builtin/am.c                         |  36 ++++----
 builtin/cat-file.c                   |   3 +-
 builtin/check-attr.c                 |   5 +-
 builtin/check-ignore.c               |   7 +-
 builtin/checkout-index.c             |  22 ++---
 builtin/checkout.c                   |  87 ++++++++++---------
 builtin/clean.c                      |   7 +-
 builtin/clone.c                      |   7 +-
 builtin/commit.c                     |  81 +++++++++---------
 builtin/describe.c                   |   3 +-
 builtin/diff-tree.c                  |   3 +-
 builtin/diff.c                       |   6 +-
 builtin/difftool.c                   |   4 +-
 builtin/merge-index.c                |  17 ++--
 builtin/merge-tree.c                 |   3 +-
 builtin/merge.c                      |  31 ++++---
 builtin/mv.c                         |  68 +++++++--------
 builtin/pull.c                       |   4 +-
 builtin/read-tree.c                  |  15 ++--
 builtin/rebase.c                     |   3 +-
 builtin/replay.c                     |   1 -
 builtin/reset.c                      |  32 +++----
 builtin/rev-parse.c                  |   6 +-
 builtin/rm.c                         |  40 ++++-----
 builtin/stash.c                      |  45 +++++-----
 builtin/submodule--helper.c          |  21 +++--
 builtin/update-index.c               | 122 +++++++++++++--------------
 builtin/write-tree.c                 |   6 +-
 repository.c                         |  32 ++++---
 repository.h                         |   3 -
 t/helper/test-cache-tree.c           |  17 ++--
 t/helper/test-dump-cache-tree.c      |   5 +-
 t/helper/test-dump-split-index.c     |  11 ++-
 t/helper/test-dump-untracked-cache.c |   3 +-
 t/helper/test-lazy-init-name-hash.c  |  39 +++++----
 t/helper/test-read-cache.c           |   9 +-
 t/helper/test-scrap-cache-tree.c     |   7 +-
 t/helper/test-write-cache.c          |   3 +-
 39 files changed, 420 insertions(+), 442 deletions(-)

--=20
2.44.GIT


--6kF4Cr5VcyonWT5n
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYdEqYACgkQVbJhu7ck
PpQkKQ//bPfsEjj3O4weODee8JKhHovBZsOMWNbbSanB9EzpRdV3Y0sV5EQ0lrP8
J4soy6Rb7Ha/aQRhwUcNmf5RkMR7lgRlDfER/136mG1G6c65xC/AkbLCuxFNVifz
gYy1X4lnX6tIKUYgrMaypwYVfP/aCUyWgouL7UnQMRY84EBGyb8A/aIIWCbRDGlR
KB6aw20nyEseZvfH4kmv1iQRXi0i1mhNsM7i9KKLb1ig/1Ohwon3LFfXT0qjOUCw
nrML69r17sCrju85/K8v3d6N/5GT7H7Gm3syR3ioCJwIto9euR7GyPUKSB0nlep9
7ZaU/XKB+sdamApyfW0Vzono+f1oQbKWvsjJSfP3tsSyZ4Wh8HUGyBlNo9yUrZPw
acoOZugUqRVvRFTHE5Xwv9dPj3iKWme0ZnSm/5dkOcxqKOiIJiUIAUiHRCcZ0kh9
Iy04+op2giUIMoeSdBy2AYXQQHeOtH+pNMunk9wbzY60y+alaiwOT+2W6Sd7vUMm
6pLQCIhllWWd9d0FPkh6tXzTfblJQHH3C5vOPCqe+D8XD1l2CpD5awZbwV5m/jB5
YS53NjbEuM8Ts8pMiae+Ur+IomV+xwgJ5qPdSLWT33TvlYtWpRizBZ4mzVoD064t
742WW+aLrzCMhgTFjNbIhj9eo4IB0plc1uBUlpTr4RKetC6WTWI=
=qUVW
-----END PGP SIGNATURE-----

--6kF4Cr5VcyonWT5n--
