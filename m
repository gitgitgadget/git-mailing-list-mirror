Received: from fout4-smtp.messagingengine.com (fout4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37603135410
	for <git@vger.kernel.org>; Thu, 16 May 2024 08:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715846658; cv=none; b=JWfh5A0LbhKncycACpfMxoOGPexVZltqc3vYk4MWG2ZcoB6YTbG/0ZS2k+p+sAQDAByTYBVCE+ztO4kwR0oqWo4swe8HHAaUTyS7/aw2q+DlE19YIUQA/Mi57PjOJuOiciKOCSNxPjYauUlhjubLX2Km2nFKeE+iYgd8jrsCQYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715846658; c=relaxed/simple;
	bh=OaWdoZIHT3/QXFbztvv7sKKzzc7yb0T+RIu+U0XvB1w=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=QAdbEtWnc0VGk8/pegk/ttzTrl+2XXKexmPL0ZdU/BN79v8uA1c3N/DBi7+Cpy6aHZ/ccYzac0TNK1d3vuWHlx8E8VMZEi+XUnthIJSCnW/52FBb1gMTmUSR77TFaIOt4Ec5m1BAhP2pjoqvfXyzm1NO40jA3BptXDRXn4aSolk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=GlfvB3M1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Xi0H3JRp; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="GlfvB3M1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Xi0H3JRp"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfout.nyi.internal (Postfix) with ESMTP id 14FA11380282
	for <git@vger.kernel.org>; Thu, 16 May 2024 04:04:15 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Thu, 16 May 2024 04:04:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to; s=fm3;
	 t=1715846655; x=1715933055; bh=RsjAKkxy3DNtsOCCEDVtjiel+q6D+2Rb
	XfW7aTfZhSg=; b=GlfvB3M19btMHGtdPyDyLRJGFOEfH5xIuZ9rnWxXqLk9c1s5
	eoiFdDey+m5EiOIXsh5ppsdhq7r09MQigPIk/9px8sATOBtOv7T9T+yB/jdNFpk5
	LJCEcqEHu76cDVwxmN87TIZXOhQ2UcQ1OIBIYo2tOBHg4Txu+6DfGJwvhY69EsBY
	kRD2W69ou7zhgz6zNeZDvd7e3tJexFJwz+LFmm4FsmtUupdc2mfwmFT4nfUxrhsS
	Nq/aYRUdw+QlI5qJ6ufKRJzk/MrcHqh04xovjHznRBC8fTJWCiGGVOhbizum2xEx
	iydhaWF1M8Te6p7x8ZIfvKxOKOPytbvmd4aanw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1715846655; x=1715933055; bh=RsjAKkxy3DNtsOCCEDVtjiel+q6D+2RbXfW
	7aTfZhSg=; b=Xi0H3JRpIlQxaRGTaAojEpNGPEOeG1MSrt3Caw006I2vC5z6upN
	UBNHCimNTT27YoGXELBVo72wU3fsOxxJkUN4aHXm6H200uNd7HgjqEGnMBSihsfO
	0sTJXBAFJl8U5dUkyHzMq5/8eKVFJpjhdlJopa9147OMAMNnX4/P5CdPpbj5uRDF
	OK+mTIBfv1KrK8SnZvrTXw/GH8pY/cExzoH5AiQEACEkh+MQ+/BcjTHpw9j8uAz2
	F48K/lgYg7J2PatRsvL8Eyu0umdKKU601a0v7S9dXG1FzjZqhxtO6vPOS/OObn20
	w56JV5BgfAhwAiATgDbRiACSW0+R3elyefA==
X-ME-Sender: <xms:_r1FZmG8Xx5cwSB4ntGgopIhR7ghKcffLAhB5D9dhdZtnaKbSiEP4Q>
    <xme:_r1FZnV3ZAHkYBDtZ8BmBCBiRcKjOjfv1iijBNC-Thk-gUvTRw8qb7l0pq0GVXXLz
    sbk9A75DzfcqHSGFQ>
X-ME-Received: <xmr:_r1FZgJTVmgQsU19BJs45cRIQtOiaVPL2VEggea4PWp3r3PKzQ5CrtDAj_TjncokOMIaksKtb6-7Sem1eF_ugm6AiJGje6Wyqzz79odzcqHUHYg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdehtddgtdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkgggtugesghdtreertd
    dtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhs
    rdhimheqnecuggftrfgrthhtvghrnhepjeeifedvueelfffgjeduffdvgefhiefgjefgvd
    dvfeduvefffeevfffhgfekieffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
    pehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:_r1FZgGQEIKN0H0uBZcRzPyAEdxhw1kyPNGft8kU47CsVdGZE_ochQ>
    <xmx:_r1FZsX6nR1sPVAF6DhC08U5wLhmSg_6txPbTqZxkvh4slWV74uRWg>
    <xmx:_r1FZjNgExC_rgnytlrfUBcNJtlNPncd37Fn_056QEtBI8qF5nhxYw>
    <xmx:_r1FZj1ZT5w9bx2he7ck-fSwSTX4oa9AeLS21Qcej_EUwX0u4mTK6A>
    <xmx:_71FZnc6D5g4B3BJPNWQXSqt-w_2npKMS-aWrnK4iK9fXFl9MUUJ042f>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Thu, 16 May 2024 04:04:14 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id ffecc256 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Thu, 16 May 2024 08:03:46 +0000 (UTC)
Date: Thu, 16 May 2024 10:04:09 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 00/16] refs: drop all references to `the_repository`
Message-ID: <cover.1715836916.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="iYAY3GKZk6nMyzr6"
Content-Disposition: inline


--iYAY3GKZk6nMyzr6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

in "ps/refs-without-the-repository", we have removed all functions in
the refs API that could be trivially converted to accept a proper ref
store as input. This was a mechanical change, and because the resulting
patches were quite large by themselves already, I decided to push out
further dependencies on `the_repository` in refs-related code to a
follow up.

This patch series here is that follow-up and removes all references to
`the_repository` in "refs.c" and "refs/". This includes both explicit
use of `the_repository`, but also implicit use via `the_hash_algo`.

The series is based on 19fe900cfc (The fourth batch, 2024-05-15) and
pulls in "ps/refs-without-the-repository" at c8f815c208 (refs: remove
functions without ref store, 2024-05-07) as dependency. It applies
cleanly to both next and seen at the current point in time.

Patrick

Patrick Steinhardt (16):
  refs: adjust names for `init` and `init_db` callbacks
  refs: rename `init_db` callback to avoid confusion
  refs: implement releasing ref storages
  refs: track ref stores via strmap
  refs: pass repo when retrieving submodule ref store
  refs: refactor `resolve_gitlink_ref()` to accept a repository
  refs: retrieve worktree ref stores via associated repository
  refs: convert iteration over replace refs to accept ref store
  refs: pass ref store when detecting dangling symrefs
  refs: move object peeling into "object.c"
  refs: pass repo when peeling objects
  refs: drop `git_default_branch_name()`
  refs: remove `dwim_log()`
  refs/files: use correct repository
  refs/files: remove references to `the_hash_algo`
  refs/packed: remove references to `the_hash_algo`

 attr.c                      |   3 +-
 builtin/clone.c             |   5 +-
 builtin/describe.c          |   2 +-
 builtin/fetch.c             |   3 +-
 builtin/gc.c                |   2 +-
 builtin/pack-objects.c      |   6 +-
 builtin/reflog.c            |   2 +-
 builtin/remote.c            |   3 +-
 builtin/repack.c            |   2 +-
 builtin/replace.c           |  13 +-
 builtin/show-ref.c          |   2 +-
 builtin/submodule--helper.c |  14 +-
 builtin/update-index.c      |   5 +-
 builtin/var.c               |   2 +-
 builtin/worktree.c          |   2 +-
 combine-diff.c              |   3 +-
 commit-graph.c              |   2 +-
 diff-lib.c                  |   3 +-
 dir.c                       |   3 +-
 ls-refs.c                   |   2 +-
 midx-write.c                |   2 +-
 object-file.c               |   2 +-
 object.c                    |  23 ++++
 object.h                    |  35 +++++
 read-cache.c                |   5 +-
 ref-filter.c                |   2 +-
 reflog-walk.c               |   4 +-
 reflog.c                    |   2 +-
 refs.c                      | 266 ++++++++++--------------------------
 refs.h                      |  51 +++----
 refs/debug.c                |  15 +-
 refs/files-backend.c        |  58 ++++----
 refs/iterator.c             |   6 +-
 refs/packed-backend.c       |  66 +++++----
 refs/packed-backend.h       |   6 +-
 refs/ref-cache.c            |   5 +-
 refs/refs-internal.h        |  55 ++------
 refs/reftable-backend.c     |  38 +++++-
 remote.c                    |  12 +-
 replace-object.c            |  10 +-
 repository.c                |  12 ++
 repository.h                |  14 ++
 setup.c                     |   7 +-
 submodule.c                 |   3 +-
 t/helper/test-reach.c       |   2 +-
 t/helper/test-ref-store.c   |   2 +-
 tag.c                       |   4 +-
 tag.h                       |   2 +-
 unpack-trees.c              |   3 +-
 upload-pack.c               |   2 +-
 worktree.c                  |   2 +
 worktree.h                  |   2 +
 52 files changed, 405 insertions(+), 392 deletions(-)

--=20
2.45.1.190.g19fe900cfc.dirty


--iYAY3GKZk6nMyzr6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZFvfQACgkQVbJhu7ck
PpTTsg//e5Rxp7JHB7xHf7/JZN33txA8t8Hr1nCMPbq09JnM52xXRc2rerFmCGFw
uwWvrKzkzIw0lcX3Hp/PPE1sMSwI96Vh1rVCeCLG9yd5NjWkX38G92IECn3FTvCm
SNTvt7rIkinJnM38si/5+nHMdYGiQ7YalAJMDkWa+2mp12RJ5ZSg8RyT1yjp/SVG
XRyuhXmg/eJDPiV6y3L2K7/akabxvN1e7n4QLnz4tzjKye9bgWYSdMaLGbKV8ilw
8ndzMsWIzkSPFV2U/VlFZnRkQLFPZOUBwqm4mHHLJLUGVKpVq6HwZhP546bpQH1E
2gcpdaSeBWgXcwLJI6zvlB1DUU6tqqxK8wLOTWFUXs5rVQcp5539JZmCfPjnqOQE
pq/LXZE0peo0VmYLHSfS5s6WjDsBYjT5zrQ+q8OJn1BcdwVOld1FJJo6YpS47Zx1
2ihlcSnDHks5/LQ09KEj197S8ULAwAnmSxAmgXkEy8T07Uf0k96iJmcFLxTrzlbJ
k4aDtDD177N/KVvvdRLQT37jJQanVHeVaF88XiJut3ycqMEun9/CdEPKTogpepj7
N0zHvRJIZlCT+OzuZ0rR3aqQqq4BLbxQC5uKXj0n4KK6+xHL2A6bT3ShguU6YICe
y564vgfgKsLE2U3iMfhUwhTeuOypY31JF49oBj7byDu2VNpQCJI=
=Gt3d
-----END PGP SIGNATURE-----

--iYAY3GKZk6nMyzr6--
