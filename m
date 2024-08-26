Received: from fhigh6-smtp.messagingengine.com (fhigh6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C606884A5C
	for <git@vger.kernel.org>; Mon, 26 Aug 2024 07:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724656898; cv=none; b=kuStazj/TxUaq5weZu5jiNH4i6xNVpf+0yPqURzkxTEHV2liAmXcezXmLLVcoaT+q9vzwZSddMo6BaIrem+FFTQQQStexWUCALiOLYOSOxOui/RUzkGtRx7NbgNuidxq58pWkA22FwQRZJBBfwQa1zJ7bySJTlIL9GLYV/NoOR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724656898; c=relaxed/simple;
	bh=oa2kjnRqmesl1TXNUVjoqwVC8jrHZidhb9LazqSumIE=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=bP5mtta178hOA1Imt1Nhui38SRc8LVTw+42vw9dwU5tPC+PkscPWBqdoP8DAwotjD+nIMVgvzUTkt4UKrmHGGY+EEx/NTvCYRwifaoWAfjF2/V03QG87JtOgnPmMwN3wWHgnAdHQ9FmFJj6hr2f39VhLjLPDihuSieYNnDMC/DA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=j3v00uIf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KLW2kgpZ; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="j3v00uIf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KLW2kgpZ"
Received: from phl-compute-08.internal (phl-compute-08.nyi.internal [10.202.2.48])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id ABD1711481BC
	for <git@vger.kernel.org>; Mon, 26 Aug 2024 03:21:35 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Mon, 26 Aug 2024 03:21:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to; s=fm1;
	 t=1724656895; x=1724743295; bh=WTPkMhmuZo2yux5FF0pf9Zf8tSIpQoPn
	Q1yC40EYsGQ=; b=j3v00uIfyPqY5ExodOfBIladHHKiN5pyq6iQA3qsn3zV8OPj
	9FucOSyuRSy8tOK0UsYUHInR6DJHqAcScUSGtmGFVq8CjwTXS0OOuF/sWXgW8kx7
	nRv6KBzDAYUGY/V31y4YaZnm10sXiYVcdLkoLNm8OZusBuQ06+e8EttqUcZDpBXS
	mypDjTU4gHgW6+c21x6Sw/EVhLoflpJAZFO66K+t7zJcSUSL128+7AaNmaY9k9lG
	qfnGoFo/i68yght+6q6gjEVN9Pg748by563p/7xLstgVBM6vpd9v44ORPS0kLYrf
	1Gsay1Y7TPDYA1ourxL2ADECsHJAXK8aS3qF+w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1724656895; x=1724743295; bh=WTPkMhmuZo2yux5FF0pf9Zf8tSIpQoPnQ1y
	C40EYsGQ=; b=KLW2kgpZ/ZDlQe5EgjPtfgd5g/61rNGLIsliqUSxnmzG0Qy/umf
	kby2B9B/WePi1Ew24HQyJwTyags1PVx9GJK954XuLOWKPAs4/OGoh8W5dl3v1I40
	wR6D+X6Cxy4ZHBc0ab6nVQ1bYz1gMjDvYNdYuAdcZg6A9XF8tW0DlS0N/9HLPkR4
	OflVNqR77D1VtODTs8gnIMVOMm1JLz43nrmzoRTLcQdjFQiY6zR1mXp42gx2NKgm
	0YMa6UzqYxqgwyoO/q9VAqfoWgyh8Jogs53omSBvH8BCL3wpDYWDpPaI6rBPn/YM
	F6VbqGc12FjRfuL13gWOk7VhGR3YjkMFhpw==
X-ME-Sender: <xms:_yzMZvkzNFb1ujnAbCbqmqf2Gx6EQPNNRhAeY35ICtYUom2uw640Fg>
    <xme:_yzMZi3zbbpDS2086Ndxq3JIh-h7kN6xI9whprStIMYPwClx_iRQaQ5hkM2GiWNgJ
    tn4ethuJXSQli8NBA>
X-ME-Received: <xmr:_yzMZlpQJ1Tw0ATNMklmxSLIW4TaOEVFS8vT14jI25hWGapi1zoKI2q2zI-4Z8t8sNmV7aWs7fYKudrDsy-XB3mtSmnG5VMMTZlX4vAjhz5mlb4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddvjedguddukecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvf
    fukfggtggusehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgr
    rhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeekgfetjefgheeggf
    etjeegveetueeggeefffeggeejieevveetveekgfefffdthfenucffohhmrghinhepghhi
    thhlrggsrdgtohhmpdhhthhtphdrshhhnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddp
    mhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlh
    drohhrgh
X-ME-Proxy: <xmx:_yzMZnl-yYoGtEltuoLhIYny70u_nBEW-IQtPNrmMa7ADjexMd-Kmw>
    <xmx:_yzMZt1TO-FiOKpHBArrZBuYLBn-GVo8YGx6YiKD5Tl3DZmh4WNCBg>
    <xmx:_yzMZmvfPaqFjqbFgH0vcysF5BKtljq2qkXGCAXLWZDoQEoNX6ByJA>
    <xmx:_yzMZhXUU0ZaHdnEBwBCzkQViuPRUOndKuO2ouiy7EQNPVLPhx3L4Q>
    <xmx:_yzMZu9_WpO7UtS1Y3ffak8wEnUIxtqlsBFaI4jhoPMzAtrsRVdk05A2>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 26 Aug 2024 03:21:34 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 43cb449e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Mon, 26 Aug 2024 07:21:31 +0000 (UTC)
Date: Mon, 26 Aug 2024 09:21:31 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 00/22] Memory leak fixes (pt.6)
Message-ID: <cover.1724656120.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

here's another round of memory leak fixes. This is the second-last round
of "general" leak fixes -- so once this and the next series are merged,
I have made a full pass over all failing test suites. There will still
be a bunch of memory leaks, namely ~86 failing test suites.

I have documented a bunch of remaining leaks at [1]. Most of them are a
bit more involved to fix, so they will likely require separate series.
These issues relate to:

  - Simplifying commit history causes us to rewrite their parents, but
    we don't free the old parents in some cases. Hit e.g. by t6012.

  - The describe atom infrastructure as used by git-for-each-ref(1) is
    leaky. Hit e.g. by t6300, t6302.

  - Breaking rewrites causes memory leaks. Hit e.g. by t7524.

  - Cloning repositories causes us to re-initialize `the_repository`.
    This surfaces lifetime management issues with the `struct remote`
    that we use, which reuses storage held by `the_repository`. Hit e.g.
    by t5558.

  - The GPG interface is leaky. Hit e.g. by t7510, t7528.

If you want to do some puzzling, please feel free to pick up any of
these leaks :) I won't start working on them before I have the final
part of memory leak fixes merged.

This patch series builds on top of 6a09c36371 (The eighth batch,
2024-08-23) with Junio's ps/leakfixes-part-5 at 13b23d2da5 (transport:
fix leaking negotiation tips, 2024-08-22) merged into it.

Patrick

[1]: https://gitlab.com/groups/gitlab-org/-/epics/14943

Patrick Steinhardt (22):
  t/test-lib: allow skipping leak checks for passing tests
  fetch-pack: fix memory leaks on fetch negotiation
  send-pack: fix leaking common object IDs
  builtin/push: fix leaking refspec query result
  upload-pack: fix leaking child process data on reachability checks
  submodule: fix leaking fetch task data
  builtin/submodule--helper: fix leaking refs on push-check
  remote: fix leaking tracking refs
  remote: fix leak in reachability check of a remote-tracking ref
  send-pack: fix leaking push cert nonce
  gpg-interface: fix misdesigned signing key interfaces
  object: clear grafts when clearing parsed object pool
  shallow: free grafts when unregistering them
  shallow: fix leaking members of `struct shallow_info`
  negotiator/skipping: fix leaking commit entries
  builtin/repack: fix leaking line buffer when packing promisors
  builtin/pack-objects: plug leaking list of keep-packs
  builtin/grep: fix leaking object context
  builtin/fmt-merge-msg: fix leaking buffers
  match-trees: fix leaking prefixes in `shift_tree()`
  merge-ort: fix two leaks when handling directory rename modifications
  builtin/repack: fix leaking keep-pack list

 builtin/fmt-merge-msg.c              |  2 ++
 builtin/grep.c                       |  1 +
 builtin/pack-objects.c               |  1 +
 builtin/push.c                       |  8 +++--
 builtin/repack.c                     |  3 ++
 builtin/submodule--helper.c          |  2 ++
 builtin/tag.c                        |  3 +-
 commit.c                             | 23 ++++--------
 commit.h                             |  3 +-
 fetch-pack.c                         |  3 ++
 gpg-interface.c                      | 26 ++++++++------
 gpg-interface.h                      |  4 +--
 match-trees.c                        | 10 ++++--
 merge-ort.c                          |  4 ++-
 negotiator/skipping.c                |  7 ++--
 object.c                             | 14 +++++++-
 object.h                             |  4 ++-
 remote.c                             |  6 +++-
 repository.c                         |  2 +-
 send-pack.c                          | 52 ++++++++++++++++++----------
 shallow.c                            | 15 ++++++--
 submodule.c                          |  2 ++
 t/t5516-fetch-push.sh                |  1 +
 t/t5526-fetch-submodules.sh          |  1 +
 t/t5531-deep-submodule-push.sh       |  1 +
 t/t5533-push-cas.sh                  |  1 +
 t/t5534-push-signed.sh               |  1 +
 t/t5537-fetch-shallow.sh             |  1 +
 t/t5538-push-shallow.sh              |  1 +
 t/t5549-fetch-push-http.sh           |  1 +
 t/t5552-skipping-fetch-negotiator.sh |  2 ++
 t/t5616-partial-clone.sh             |  1 +
 t/t6132-pathspec-exclude.sh          |  1 +
 t/t6135-pathspec-with-attrs.sh       |  2 ++
 t/t6200-fmt-merge-msg.sh             |  1 +
 t/t6409-merge-subtree.sh             |  1 +
 t/t6423-merge-rename-directories.sh  |  1 +
 t/t6500-gc.sh                        |  1 +
 t/t7703-repack-geometric.sh          |  1 +
 t/test-lib.sh                        | 11 +++++-
 upload-pack.c                        | 22 ++++++++----
 41 files changed, 175 insertions(+), 72 deletions(-)

-- 
2.46.0.164.g477ce5ccd6.dirty

