Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6863B28B4EF
	for <git@vger.kernel.org>; Tue, 22 Jul 2025 11:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753183268; cv=none; b=epIsN/fm2rXC1eapFW8NDIYiml9wzKIYRBaJDKhEuT8dZ3I/ERREPGmTsr5DBdQ0o8T3ASCN46+iks+87RgPzNrC5amMQC0OUWZlU6MVxP2STVuDFLZ3WQOim5amIvA+XBPvCk+NDMpaapzkVuVkWlE+e5BkR7AlUxZ1IK8oaQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753183268; c=relaxed/simple;
	bh=n8X0hlSMZJ+Y+/u12ANuIrsSQYGKq++LjOFWSVkI6HA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=f22aXPiY05/JYJJmZlkPM0AgDZgrjG7/CkR6WRU74GLCZ3mjLuppe8bxM+gqg9NOTXaz56+8hKsiHKj6yugiWSdl0YA5hxwMUXYp72ukeSV3KbtneuEStDunuMbytd8GQjglqvGOyGvPGnriOtQQYpniaRGBlWRtYCNVnHy8AyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=DOkKrB04; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=e2JaxA8B; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="DOkKrB04";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="e2JaxA8B"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 813161D0025A;
	Tue, 22 Jul 2025 07:21:04 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Tue, 22 Jul 2025 07:21:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm2; t=1753183264; x=1753269664; bh=dmm/SozbS+
	OW0XaaRnP+VAMsK90VvMoU9qopMbnK7wA=; b=DOkKrB0471ckOi1pvT1H0cYjc4
	QuzbAw+Ckb7Fz7d6b62J3pU3DSUkdoIbtYWI+G9A/RXz/zde1MgyVyYWXOpldQb8
	UUof7KB96BbmIIUe5N0wKED2xCU37u482eW/Fal6iVIAxXp6cRU2KDeDZEiKu2P0
	6laTKixzDqUmXG0/gC6scw/lm6tbNEo4ZhMLxzStj6EtV8TNL8xJjqofiJAHIHPs
	5NjX6CJCgbip+OO/HE6LKVsC+POpo5g7cZF02PQPRdZqHTgml3WC/zpPHcL9n7tX
	pDsP/A6Byvvh66N+2goz9KW/kr3hkmrtMcOD4D22oYphyKRb8jc9gj/TQDDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1753183264; x=1753269664; bh=dmm/SozbS+OW0XaaRnP+VAMsK90V
	vMoU9qopMbnK7wA=; b=e2JaxA8BKqyhEBSS08jcijtypxBtxoImTG66+lO10GhP
	LLkjyBY3lB9mos34E3uLNTUtcpq/J+XEkR7nlcqRWWLvnMY+sf0tlZYIIKtBBLLV
	zLk7EyTZamQj8sH0GTefrTCr+bAzqLYr/dpDXGyqMNlRs092eeJFJmKLO/uzmzif
	B4d9l29PtI7DUPyWx0ySMlxHl/UnzSlYCOlCVR5YItG3t3+gUJRdOEjYhrWDxATk
	l6ntumwA73xvQqWGegkDBZk2Ml+OtP6mQ95BYaqAQ2fn2fcXuXFsi9yUIVGQNCqv
	E90JF8qUamsZz8aCHVUiPSKQQMeJ4fIWfZkby2CF5A==
X-ME-Sender: <xms:IHR_aM1oV_WJP9-cVC-xUQPJyOOro_IT4VCM31nWqpYS5E205pqobw>
    <xme:IHR_aHTDpJURyNMEAJ7wppG3hYGzJLnZJL0imxjFZKb9f44TrHBopEwH_UHb7z3xc
    WzuBZDKq2lfdaeOdw>
X-ME-Received: <xmr:IHR_aGu5i60hctPku_1bwjfDXYKvQmqpaLQIGyFTsW-2eU7QOQtnqZlJv5Rh1hrzLHua7fTGT9wvdyO3NdVmn2TvtbK7atD2ME1kUjTitg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdejgeejiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhufffkfggtgfgvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgtkhcu
    ufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepve
    eugeektdetieegjeeuheeuudfgveelfeevheeuhefgteffffevhfeuhfeukeevnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrd
    himhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohep
    khgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvgh
    gvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:IHR_aEaSfg9yTA1-8zFPa7Is93htmHUOceygrWjrWAMWBj9GkX1T9w>
    <xmx:IHR_aDsXb3qGrPa2bAeRZdsexPOpJLvK-xmFaSDVzQkSQm25hqEmgg>
    <xmx:IHR_aOGYJGDAWqkuK2XyXtyhfuykIEuKlejkgrtOzV7_PRVtlWFHQA>
    <xmx:IHR_aGw1LZD6KD-maO94Wjg17SZQz_4NbBAz5Hnibuy2_jlU3Jda9A>
    <xmx:IHR_aHH63I6EQ1U5cVCLJ4MOfnqPuACgqbJBq7jrNR2rbW-gxcgNqL7r>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 22 Jul 2025 07:21:03 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id ec09f823 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 22 Jul 2025 11:21:01 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 0/8] refs: fix migration of reflog entries
Date: Tue, 22 Jul 2025 13:20:49 +0200
Message-Id: <20250722-pks-reflog-append-v1-0-183e5949de16@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABF0f2gC/x2MWwqAIBAArxL73YJtT7pK9GG62VKYKEQQ3T3pc
 xhmHkgchROMxQORL0ly+gxVWYDZtHeMYjMDKWpVT4RhTxh5PU6HOgT2Fru6qXqyg17IQO5C1nL
 /z2l+3w9dXOB3YwAAAA==
X-Change-ID: 20250722-pks-reflog-append-634172d8ab2c
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.14.2

Hi,

after the announcement that "reftable" will become the default backend
in Git 3.0 I've revived the efforts to implement this backend in
libgit2. I'm happy to report that this implementation is almost done by
now: out of 3000 tests only four are failing now.

For two of these tests I have been completely puzzled why those are
failing, as everything really looked perfectly fine in libgit2. As it
turned out, the bug wasn't in libgit2 though, but in Git. Namely, the
way we migrate reflog entries between storage formats is broken in two
ways:

  - The identity we write into the reflog entries is wrong.

  - The old commit ID of reflog entries is always set to all-zeroes.
    This is what caused the libgit2 tests to fail, as I used `git refs
    migrate` to convert test repositories to use reftables.

This patch series fixes both of these issues. Furthermore, it also adds
a new `git reflog write` subcommand to write new reflog entries for a
specific reference. This command was helpful to reproduce some test
constellations in libgit2.

Thanks!

Patrick

---
Patrick Steinhardt (8):
      Documentation/git-reflog: convert to use synopsis type
      builtin/reflog: improve grouping of subcommands
      refs: export `ref_transaction_update_reflog()`
      builtin/reflog: implement subcommand to write new entries
      ident: fix type of string length parameter
      refs: fix identity for migrated reflogs
      refs: stop unsetting REF_HAVE_OLD for log-only updates
      refs: fix invalid old object IDs when migrating reflogs

 Documentation/git-reflog.adoc |  17 +++----
 builtin/reflog.c              | 103 ++++++++++++++++++++++++++++++++++--------
 ident.c                       |   2 +-
 ident.h                       |   2 +-
 refs.c                        |  58 +++++++++++++-----------
 refs.h                        |  24 +++++++++-
 refs/files-backend.c          |  25 ++++++++--
 refs/reftable-backend.c       |  26 +++++++----
 t/meson.build                 |   1 +
 t/t1421-reflog-write.sh       |  81 +++++++++++++++++++++++++++++++++
 t/t1460-refs-migrate.sh       |  22 ++++++---
 11 files changed, 283 insertions(+), 78 deletions(-)


---
base-commit: 3f2a94875d2f41fe4758a439f68d8b73cfb19d0f
change-id: 20250722-pks-reflog-append-634172d8ab2c

