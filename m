Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AAAD32FA2A
	for <git@vger.kernel.org>; Tue, 31 Mar 2026 23:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775001476; cv=none; b=PODC0BvcMyTGLQhutlrgt/x5orEiN4R43VMqw4pVGLdU/7kw6bzuk8zVb7NF8+hOGyNCuX5mGEa5b/i12rgQMeKXHHnr6dD6p5ZUbhM2w+d2SvRcFvRzDjI6ErC1QzTbIYGrzhXfU6b3KjJyFM+NSRXDkvCh6+QE9qipEmG7eyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775001476; c=relaxed/simple;
	bh=TgNhA64yhJaxFLa/+xvgFqkVPm10i2sXw10QAMFaaTc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=smzPjvECB5GCdxNiR/Lhv2kjnNI5yCTR6cetfxzDGRVmOJ/PDydi+EtOoyOB65fgz8mqGzK/iypWQiWJF/nPC2fyb0dIw+6WpwctZDFpYJUI8gxXgpogK2AFhjwvktsmHQr7RuadX1LAryIGmTA7ptAyw6dT3IyqzgR6oZQ9zI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=x5Fx8mhY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XEVrxlCm; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="x5Fx8mhY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XEVrxlCm"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id B04DEEC0253
	for <git@vger.kernel.org>; Tue, 31 Mar 2026 19:57:53 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Tue, 31 Mar 2026 19:57:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm2; t=1775001473; x=1775087873; bh=cTzIwbuVmU
	KzvTrc7qnUVRoFH1FAIp540QfktrkXp6Y=; b=x5Fx8mhYFFDh5qZ90g3iUs46ar
	KIkg/gCHahVzxiLZBYbYs82Ed1lf4wQtYCY/F3F9rhpC5LFPiyI9X3wI5ty2q7NS
	t1rOkr9nYBCLVPokZvpFEwi3qS2rnSqGptz52PVkys+zF6NDDv6EkgdQL9g4mg0D
	88h0pmJXO6G8gzirP9Gk/AdjGD4MmvPdRq4oXUgCQrKEgQ6yLwFIXy+6c8pRurEq
	pOCyXPzvwhkUGuNABacHlN8AGmTIhZHlt0jzPLhQn+SOqsgjqgLnAuea3epmaQVr
	EkT+XbHGvexS0V6c9SagDXo99EeYait+Sk8VDFOLE499ueAr0bCF4hV/5sWw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1775001473; x=1775087873; bh=cTzIwbuVmUKzvTrc7qnUVRoFH1FA
	Ip540QfktrkXp6Y=; b=XEVrxlCmWKNRHgvps87bVPDaeTvSkYd4vYKG9ubWvjpz
	F02/qaxVjhkjVZnG8sI+c8+HjMIESUb3sOffLqIgEZhjhJHwZiBQL6ywRdw0e1Lm
	f5iZYUDVeBfLkuXwEnddjqcL00jX5NwDyVIX5T0r1QxyLLo+/rzHlMHKb3zPovoy
	beGHNJk5clhZHT0zK3/P4BL3fZj00U9Abf74Sl9h5RkCnlXrM+CBDPLxU10YNToM
	TjP3IjrJcaKL5yURX2dCkxquXOl0JOnD3FPwwnioCzIfrpYO8TO65qGvfsc9iq3a
	vpHtiIvnFTMCVj+KGZWO1wNwRVvFeq28W7lVfBwUCQ==
X-ME-Sender: <xms:gV_MaaNlAesOmnycRD49oqiG8GSUJfYbvUdnVxixUHiblDAqPPSFWQ>
    <xme:gV_Maf7MzANe-kiuQDIHlQLuQqbdWXhXl0eFPpPx5AVrt6STQzKi6aRzv-yk2UZKf
    Eg3le1QqcMpj1vDBWrjON8hMMHaqjfUknoOm0WEf8maRlJ6kk8XaA>
X-ME-Received: <xmr:gV_MaW7nqVhTr65scjT9n_GMEGKV7gupQxTCSd9yLrc5LgTxZ_v2Zl52dOM-Bv20HYCUkVUTrmtSdgmjLgpDLWUWU3rFsM1okyzGJT7ZNlQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduheekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucenucfjughrpefhufffkfggtgfgvfevofesthejredtredtje
    enucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhi
    mheqnecuggftrfgrthhtvghrnhepveeugeektdetieegjeeuheeuudfgveelfeevheeuhe
    fgteffffevhfeuhfeukeevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehm
    rghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddpmhhouggvpe
    hsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:gV_Maf3eIYyOYogJrFyTAAWDUSbAR2AiVkOxsRo-FaNk0tj2virLbA>
    <xmx:gV_MaSU1JLFWEoeKrC1j8ee_RcNqen4Fc7dTfca6jv9wE1mYmeIpPQ>
    <xmx:gV_Maa7L8MmKroVqCBFsPParF71PutcX8VvVr5byPZKoE-k3ab4VNQ>
    <xmx:gV_MaZIW7AkQWUxE-sSQLYbm97T5jfJw_Ws8_GaYtw6gkkhhgDAVvA>
    <xmx:gV_Maa_n7ySimtOmM-IlMFNdNuc3xWTxCFuH5FzPR05U0Y0-CcTl6jNV>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 31 Mar 2026 19:57:53 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 69b166cf (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Tue, 31 Mar 2026 23:57:51 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 0/6] odb: small set of cleanups
Date: Wed, 01 Apr 2026 01:57:45 +0200
Message-Id: <20260401-pks-odb-cleanups-v1-0-89adba9ada68@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHlfzGkC/x3MQQqAIBBA0avErBswg8quEi00pxoKE4ciiO6et
 HyL/x8QSkwCffFAoouFj5BRlQVMqw0LIfts0Eo3qtYK4yZ4eIfTTjacUbBVlpzvvDGmg5zFRDP
 f/3IY3/cDXes7RmIAAAA=
X-Change-ID: 20260320-pks-odb-cleanups-70aebd8d9998
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.15.0

Hi,

this patch series contains a small set of cleanups that I have
accumulated over time, but that didn't fit into any of the other patch
series I've sent out recently.

This patch is based on 270e10ad6d (The 23rd batch, 2026-03-30) with
ps/odb-generic-object-name-handling at 83869e15fa (odb: introduce
generic `odb_find_abbrev_len()`, 2026-03-20) merged into it.

Thanks!

Patrick

---
Patrick Steinhardt (6):
      CodingGuidelines: document our style for flags
      treewide: use enum for `odb_for_each_object()` flags
      odb: rename `odb_write_object()` flags
      odb: use enum for `odb_write_object` flags
      odb: rename `odb_has_object()` flags
      odb: drop unneeded headers and forward decls

 Documentation/CodingGuidelines | 12 ++++++++++++
 builtin/cat-file.c             |  2 +-
 builtin/fetch.c                |  4 ++--
 builtin/fsck.c                 |  2 +-
 builtin/index-pack.c           |  2 +-
 builtin/receive-pack.c         |  2 +-
 builtin/remote.c               |  2 +-
 builtin/show-ref.c             |  2 +-
 builtin/unpack-objects.c       |  2 +-
 cache-tree.c                   | 10 +++++-----
 fetch-pack.c                   |  4 ++--
 http-push.c                    |  8 ++++----
 http-walker.c                  |  4 ++--
 list-objects.c                 |  2 +-
 notes.c                        |  2 +-
 object-file.c                  |  9 +++++----
 object-file.h                  |  3 ++-
 odb.c                          | 10 +++++-----
 odb.h                          | 30 ++++++++++++------------------
 odb/source-files.c             |  2 +-
 odb/source.h                   |  4 ++--
 packfile.c                     |  2 +-
 packfile.h                     |  2 +-
 reflog.c                       |  2 +-
 refs.c                         |  2 +-
 remote.c                       |  2 +-
 shallow.c                      |  6 +++---
 walker.c                       |  2 +-
 28 files changed, 72 insertions(+), 64 deletions(-)


---
base-commit: 04728db51b447d5e2d1a2748f7c70d30dbe5eb7a
change-id: 20260320-pks-odb-cleanups-70aebd8d9998

