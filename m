Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 152D78F49
	for <git@vger.kernel.org>; Mon, 13 Jan 2025 08:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736757242; cv=none; b=RBuZJ88Yw1136MgdTrlh/2jx1cM2Y5DQ/QK27NlQTdbUSoUOksY4We2dK31BE9fERV4KaOtRP1IkDfJr87RgO07+bZWWPLQ1idPTIMpNKDANtP0M16vm1HhzxQuxwq57Legds26p4E1jJxAxbEAzMqIQuGVtbGeKEri3SzYDlUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736757242; c=relaxed/simple;
	bh=2q/1fH2VQscPzbtRosxbEFpkgkJFZnhdWW/B2a2bMCg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=u/sbUAkl2i6+Wa1Wo/4lKi5MC9JVuju8eGOD7PlYxwCQqSk3L7CA0jwmvMSdBJJeSn1Sh61Mnl9qmGhlDw1TjCf7drzfg4fmRAb2JS8l9IorRBlq14rA0qRR9QocHD88gcJ7GzSGxvFPPy4t9HwTdhONqsTFdHXEx0oFVOEZUgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Xs/68HAE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Fnc8er7d; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Xs/68HAE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Fnc8er7d"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 082332540184;
	Mon, 13 Jan 2025 03:34:00 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Mon, 13 Jan 2025 03:34:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm2; t=1736757239; x=1736843639; bh=R42nAkDJDo
	U9dGIAS1y+WwwhVMvTnRjGYsZV90wz9JE=; b=Xs/68HAEHYvXP8rP5mNfZR9gpN
	qXxZIl1v8CkHphex3wp8p1xSw69US5D+927t0SbniRlLBv7b6Ihp6mpNvU88W2iu
	dpv9VqFNLjBnv6JJR+WujQJ8XB/1qXcC+PIo+8fc8pZiqJR9yBbqE18ofb6r2Rbw
	WSZoQTkrSrawIBVMVeBSwr9MTqTR2edTFKhRnFYbbO/kCAvbpnjHq4Jnvki4YCeG
	iJxj4H1KW9YgnZgTjvBJl7NBgjvpJFtQPkCnDszFboAgCuhOxpZst/qtLbW6CD5j
	wSgSlbPMseizC1sGBTE7BmJLSwCRA0SnrIZqgan3FUf8TZJzUaEfaWaVyeUg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1736757239; x=1736843639; bh=R42nAkDJDoU9dGIAS1y+WwwhVMvT
	nRjGYsZV90wz9JE=; b=Fnc8er7d17gCJbi47d/LNZ/glrrIEuhl44Y9UB+RZwXn
	kYGDB6hK6h2n4tpgL4VhQrWj8qKq1emut2UiYaKmte7mGVK1PBOsricU0bdqJAUi
	F6gBYmC+cifqjbN3pXWdr4OwBFZuEE/Agk9kktH14Or/OmS96ZU7IG8pdHvV+e1+
	crgHziUtKD123XPFYu/ijQJC1I381Fm1lOHwtSR6ZqELXpLEVIXWTVoGX5hANmKK
	YWTMYxWDt/ouxMKuK7yXBYhUrFbdt/NsEtM3PSHQF6Xw+b/zAee+VtfYB91LpfPD
	IMcPQQOrdTPJGPGIrbIpn1ZYUb9qZje2hq3Ko25MmA==
X-ME-Sender: <xms:98-EZ3uqYjC7ZcC-4yWpbvcopn8xomwwrw5RZkIe4_GbqgLv1SJaww>
    <xme:98-EZ4c0h1p5RwcC0bK15mCZVeNB3Y5DuvYs8B7sqKTp-y4b546LwQGuXjnDxxW2q
    LIm5EsOTB4ZXB8laQ>
X-ME-Received: <xmr:98-EZ6z_lno5g_SZmW-6f1regcqyncE7-OpT9C3rDwhyGCbo3L4kKeDeqTqVh0eeUDbqITEzpm-BG-wQVvYyfl7HBSYbNtvrP9zTHJGT6o2Dw3aA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudehfedguddulecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhufffkfggtgfgvfevofesthejredtredtjeen
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnheplefggedvleeggfethfeuiedvhfeugfetffevieehteeu
    tedtjeejiefhuedtieeunecuffhomhgrihhnpehgihhtlhgrsgdrtghomhdpghhithhhuh
    gsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhho
    mhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouh
    htpdhrtghpthhtohepvghstghhfigrrhhtiiesghgvnhhtohhordhorhhgpdhrtghpthht
    ohepvghvrghnrdhmrghrthhinhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtse
    hvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:98-EZ2PQcvuYDZP1IuP7Tw2FTOmoHLdBZgN2JHsv4eRlX8OOUW-CLA>
    <xmx:98-EZ39wo2ibaobxiT2wK5Z5Ka6yng1yX_anwi7cWXLThJ2Kswgh2Q>
    <xmx:98-EZ2Wco7xDN_jgWzEG2BNZJluytUcw23rGx2P8tDoS2zhwhZbGmA>
    <xmx:98-EZ4fm5YXTPz6hdYd_bEldbjhilGQCGkBFL-vUX3f14hgvRM9m-g>
    <xmx:98-EZ6ZJeyp2A6yUvDtXC50pI0-olfSDhfcWBcb1I4g8jlvb0K1PELkP>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 Jan 2025 03:33:58 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id f00de7f5 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 13 Jan 2025 08:33:56 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 0/9] meson: a couple of additions
Date: Mon, 13 Jan 2025 09:33:33 +0100
Message-Id: <20250113-b4-pks-meson-additions-v1-0-97f6a93f691d@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAN3PhGcC/x3MwQoCIRCA4VeROTcw2lrQq0SHVWdriFSciEB89
 5U9/ofv76DchBVupkPjn6iUPMOeDMTXmp+MkmaDI+fJ0hXDgvWt+GEtGdeU5DuFInkf7SWcybs
 AE9fGm/yP8f0xxg6jyCL/aAAAAA==
X-Change-ID: 20250107-b4-pks-meson-additions-055c16b3052b
To: git@vger.kernel.org
Cc: Evan Martin <evan.martin@gmail.com>, 
 Eli Schwartz <eschwartz@gentoo.org>
X-Mailer: b4 0.14.2

Hi,

this small patch series backfills in a couple of missing features into
Meson. It also improves test coverage of our Meson-based CI jobs so that
we compile with Meson with Visual Studio and compile fuzzers. CI runs
for GitLab and GitHub can be found at [1] and [2], respectively.

The series is built on top of fbe8d3079d (Git 2.48, 2025-01-10) with
ps/meson-weak-sha1-build at 6a0ee54f9a (meson: provide a summary of
configured backends, 2024-12-30) merged into it.

Thanks!

Patrick

[1]: https://gitlab.com/gitlab-org/git/-/merge_requests/280
[2]: https://github.com/git/git/pull/1870

---
Patrick Steinhardt (9):
      GIT-VERSION-GEN: simplify computing the dirty marker
      GIT-VERSION-GEN: move default version into a separate file
      meson: fix dependencies for generated headers
      meson: wire up development environments
      meson: wire up generation of distribution archive
      meson: wire up fuzzers
      meson: make the CSPRNG backend configurable
      meson: fix compilation with Visual Studio
      ci: wire up Visual Studio build with Meson

 .github/workflows/main.yml | 52 +++++++++++++++++++++++++++++++
 .gitlab-ci.yml             | 38 ++++++++++++++++++++++
 GIT-VERSION                |  1 +
 GIT-VERSION-GEN            | 17 +++++-----
 ci/run-build-and-tests.sh  |  3 +-
 meson.build                | 78 ++++++++++++++++++++++++++++++++++++----------
 meson_options.txt          |  4 +++
 oss-fuzz/meson.build       | 20 ++++++++++++
 8 files changed, 187 insertions(+), 26 deletions(-)


---
base-commit: 35a417ddf0eab983e4d5eb69e628aa198114bb05
change-id: 20250107-b4-pks-meson-additions-055c16b3052b

