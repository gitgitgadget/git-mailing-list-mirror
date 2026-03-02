Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E0461E1A33
	for <git@vger.kernel.org>; Mon,  2 Mar 2026 12:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772453594; cv=none; b=ndhmndklb7nUO0nnSmNr8StY7VI1nJU5gc2uhid/BbAeflVJiIhlvRfZiKp+z96cCHGEX57VYGhaffi95DC+a+9rm2xIDF5oURpIjHeILs5g6eyBoDAPYDdSOo9vAVwKZg+4wvyCEvbSdxNOi7490VmZCw/x0AmV8UwdiuHKF2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772453594; c=relaxed/simple;
	bh=KwEm5f/9PwEDp2SHnAQEDJAbSso5hrE8xfQzcdp5KTw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=u/qSo1iZniPfFudH51R9ke6h8mMMsXwu9Ra0O2vB/KJW/NLN+N6twM1Nhb4oFr9n++fBLASZAbj6sLaDNZgB5iTTru/pb0MY5RNLV3OVln++FzZdsGc66h1khAN8dLJDlvFDujQ0eyf4hVn2g+paNxFjojmFSfgvDTCDSGkcb54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=fGD3EPTi; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FsJGsJ6m; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="fGD3EPTi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FsJGsJ6m"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 68C187A0196;
	Mon,  2 Mar 2026 07:13:12 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Mon, 02 Mar 2026 07:13:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm1; t=1772453592; x=1772539992; bh=nfOrYyDjL7
	miMeiMUkn7SOd+RqfLmWbNWkPWjZUiAJQ=; b=fGD3EPTiWIVbbQRLtirAOO01Om
	TQNLwsIvFlMvORMkGlL2PRiBOVFeeleQiYy292vsYTwO0zNB3/0UtX/GN352wNEZ
	822RNiY9vrrDySX0+yZPWewCOl701Qc8h4f7oM72y2M4YEGs7j/T0HOHz8hvYDY6
	h3g/PWYmz/wu2udMlSLl4/r7MURfGrFtI27vz3dNVY59JE8EcflRjfNdgSK/EHXx
	r8H4uvGcirqcPzadw23BJOVhAWV//8Ny67ywsf7lNfE0BZ9l6VW2pN4r/EG1Otw0
	c67Tgd/aeGugm3gYHywyrgd7b0uDBEpG3CnLKheSU+m/DX5GPblgiA/hS14g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1772453592; x=1772539992; bh=nfOrYyDjL7miMeiMUkn7SOd+RqfL
	mWbNWkPWjZUiAJQ=; b=FsJGsJ6mffKxmxJU4bC6b/StDvg6rBFZ4/2AKB0aL8KP
	scgh75SxJu1aidSc+ZYd6DhTh6NL4B9umtv3c/DwuY8b76dspSHZritS0ctWV3fk
	6tJtVozsqHEVzV0A6ga47ZjH234BsKF9nrPc9eG23LXs3MzTckFT83zMJRcsEIVF
	0spq3xv4gpZv5AeXMkJKOjRb9HEfyKjasK1i6GcMkV2nW8sssJzWxirhrNQrxQHt
	HkqDx98bUaCUoBlAs7eJbVUGnfc/g6eZPX5YdBAs57VQ4T1VGA8odL1bDf/OMf/T
	kZLO3mMZYn3aA29Aa9Pb1+HaUDVVi5wJ14SBB2GBag==
X-ME-Sender: <xms:2H6laXhDZdVmKfGnnb2ur_vALkxc_4aUa60EZ-EKJrvWzl6fwOw-Ug>
    <xme:2H6laaAp7_HjqYVWegz0sTzapHtWV5JMJd2ta0MX6cLiszhhOP72KR7253MYlUdjU
    -IMWf9ZVTtFJKnr5Ayy6z6RGj8GncocwzvX3AayMZGIU3JQCfwi>
X-ME-Received: <xmr:2H6laUtvAzaY1MlL13BJyiAOa9tZISxW6eFctMA4EMTEw7RYxm9OPbs4KXIFL8V0zQJdQOO3cwVRMkaGLnnijuj_N0Bo8bQCjR4UnmMRkA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvheejieegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffufffkgggtgffvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    evueegkedtteeigeejueehuedugfevleefveehueehgfetffffvefhuefhueekveenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehnvgifrhgvnhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkh
    gvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:2H6lafYNcuBkDDImGN-tOw7Gm1kLGhdojbkjKcEMk22YfpfSd8ubxQ>
    <xmx:2H6laXVzqSWOof9e-D1PB_CqYd4GqIo_nJ1O9ARj8f7IxWx5mw6uSg>
    <xmx:2H6laT4yVcrmyKa2R7jHheNcBQV2065aGnYR4ZGJ2_8UDAiOXfGYCQ>
    <xmx:2H6laSjLJqLuoNO_LMUQPkDPitvCCJsbXyTEwFAyO4zBwLaZh6nRQg>
    <xmx:2H6laXRQUS9EeO_fUu51FuKe6cfKqY3_t9X0o80zA7XmKXFo-w72VzLV>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Mar 2026 07:13:11 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 66554ff4 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 2 Mar 2026 12:13:10 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 0/8] history: introduce "split" subcommand
Date: Mon, 02 Mar 2026 13:13:04 +0100
Message-Id: <20260302-pks-history-split-v1-0-444fc987a324@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANB+pWkC/x2MQQqAIBAAvxJ7bsEKgvpKdNBaaylMXIlC/HvSZ
 WAOMwmEApPAWCUIdLPw5Yo0dQXLrt1GyGtxaFXbqwL0h+DOEq/woviTI1rT6aFbbd8YDaXzgSw
 //3Oac/4AXLGDQGMAAAA=
X-Change-ID: 20260202-pks-history-split-fb3a93df61ba
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>
X-Mailer: b4 0.14.3

Hi,

this patch series introduces `git history split` as an easy way to split
up one commit into multiple commits. This subcommand has already been
introduced in earlier versions of my git-history(1) patch series, but I
eventually decided to evict them from this series so that we can rather
focus more on basic decisions.

In any case, the current version of this patch series matches (to the
best of my knowledge) the latest agreements on the mailing list around
its behaviour. Most importantly:

  - It will ask for commit messages for both commits, not only the first
    commit, which has been a bit of a discussion point.

  - It is not possible to edit hunks. This results in a mode where
    conflicts are not possible as the tree of the second commit will
    always match the tree of the original commit. Conflict handling for
    subsequent subcommands will be a bigger topic, as it probably
    depends on support for first-class conflicts.

  - We also update dependent branches, same as with the latest iteration
    of `git history reword`.

The patch series is built on top of 2cc7191751 (The 8th batch,
2026-02-27) with aa/add-p-no-auto-advance at 417b181f99 (add-patch:
allow interfile navigation when selecting hunks, 2026-02-14) merged into
it.

Thanks!

Patrick

---
Patrick Steinhardt (8):
      add-patch: split out header from "add-interactive.h"
      add-patch: split out `struct interactive_options`
      add-patch: remove dependency on "add-interactive" subsystem
      add-patch: add support for in-memory index patching
      add-patch: allow disabling editing of hunks
      cache-tree: allow writing in-memory index as tree
      builtin/history: split out extended function to create commits
      builtin/history: implement "split" subcommand

 Documentation/git-history.adoc |  62 ++++
 add-interactive.c              | 177 ++--------
 add-interactive.h              |  48 +--
 add-patch.c                    | 363 ++++++++++++++++----
 add-patch.h                    |  74 ++++
 builtin/add.c                  |  26 +-
 builtin/checkout.c             |   9 +-
 builtin/commit.c               |  16 +-
 builtin/history.c              | 317 +++++++++++++++--
 builtin/reset.c                |  20 +-
 builtin/stash.c                |  54 +--
 cache-tree.c                   |   4 +-
 cache-tree.h                   |   3 +-
 commit.h                       |   2 +-
 t/meson.build                  |   1 +
 t/t3452-history-split.sh       | 757 +++++++++++++++++++++++++++++++++++++++++
 16 files changed, 1592 insertions(+), 341 deletions(-)


---
base-commit: caec355702b7a86dadec53344ba65ae33558cfa8
change-id: 20260202-pks-history-split-fb3a93df61ba

