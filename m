Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B8F02F361E
	for <git@vger.kernel.org>; Wed, 19 Nov 2025 07:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763538661; cv=none; b=q2eLd30+92gjVEheHJt72MVvknLDDkENfEMiI8tfCeFT4YFn60xMZ1jPA7vbvJP+hk+ogM1FYsCNCaD4/nhOs8beKxAo/2yayWW7GfO01PwwDKhKbho77PIMGIyXWRyHndkza+Zem94Vyuf35ANGGJSM2r4VMHMqg5leFqMWsTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763538661; c=relaxed/simple;
	bh=yfLHafiRoCdM8MVEtGhOR64ebCzXBJ8QQVABVmpII8Y=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=JCeYKiWz5qAi8hjsuItjg6e+YrIg2UnhO6UOzHZxEmfSYbuiviswXlqFG+O5lBbugcg6H3Ap6RlwRbrjXnXjmHNGVfyyf/4UwSV8XGHNVVmrHr0EsgjhHtQKAHI5/jVK5gelvgxIMCD/M4J7dkrT8YzoQvZLBJ7OHy6YprfpnCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=LPCiiRok; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=V4q1pJMv; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="LPCiiRok";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="V4q1pJMv"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 9D9B21400224
	for <git@vger.kernel.org>; Wed, 19 Nov 2025 02:50:58 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Wed, 19 Nov 2025 02:50:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm3; t=1763538658; x=1763625058; bh=p7FtOFph1u
	U92fI2Q18n7S+PE2E6YPyv3C27ipZ45xI=; b=LPCiiRokrJxSuIqxEvokE0kASx
	poryz/O8+38+IVh7w5nqLKV5OQ1a16hSJ3CrsWWogg/ASbNzL+7M6+zzHWqhpMsF
	p4SBb6967SS94SdjHllEiJN4WFeruEbFAFvvgBdIvsWGFBSECTbi70tl58opXdCR
	eod6hbqT0B7mx+MnlRZBsX5GWOZo8/OpXyPybGNxCq4gEQGsP8XNf5Veh9lfehev
	5SHCwG7HVaHvf6oy+TC0EvMnnT7wXv5ncdumQNk7am5UkEMnp/9XY3/gfkWlbcyt
	Ln+Vqnl7kN0ccOM/R6GBf9tuP+681Mls9qTi0RJJL2PKvJ5OZVgzwSMLQkNg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1763538658; x=1763625058; bh=p7FtOFph1uU92fI2Q18n7S+PE2E6
	YPyv3C27ipZ45xI=; b=V4q1pJMvwG8r8vj8YLKQshvBFqApNU0S4HVA3UHroC+1
	qF+J5IHZH2RD7W3eI8DYeMJL59pMAbmyfFtWWE30L9hfmYvPhWt9GqMoNa6RS8d2
	FAU+cGnd25DJ+YiB2B002S4xq3U3k4SK2FYPf5NL6UAqI9JTWxEIH+7b+QQFtgyf
	H6zdcPaCbTh2jyqyXXXztepH7HcT3eluQe9x49i2A2IDe7PfRep6dfS34PKWGLTn
	YxA83GZG+YX2VzzsZABjHzsvMPPt8r3PSmRUXsbF2Tq7E78aWE1H2WK3xht5NV1g
	4ROaHE72qJyrpcv+XDWoInhf3KPb7JiqsfUhcQN/Jw==
X-ME-Sender: <xms:4nYdaT9cd6M6pwOOfyEPf6TeKyVMcWiWkcKfbS4NhnY5J8LWnMfRkQ>
    <xme:4nYdaWr1ZimSUYFelpIHV57oJy3zPxujJQ9_PUyGA19rzPwFB9fT648g2KtQbpbFi
    VxXdYHE9J3n39wNAQfwUJmesygCT5moP5fEtpWprJ4-vAg08ciw>
X-ME-Received: <xmr:4nYdaWolLsdnd021aTNeLiPUhkk4tY3q9Lvul4JYFu-H5MHqXAdzQtl2KBgt4-b0HmeDYrv1Tm3nUtRQEmd7FZUz3ZqhRbHj9NDecW1XbQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvvdefieehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhufffkfggtgfgvfevofesthejredtre
    dtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhs
    rdhimheqnecuggftrfgrthhtvghrnhepveeugeektdetieegjeeuheeuudfgveelfeevhe
    euhefgteffffevhfeuhfeukeevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
    pehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddpmhhoug
    gvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhr
    gh
X-ME-Proxy: <xmx:4nYdaUmrcBZ5_Dox1OyLVKZLqrR-A1cbjkri5rN5pVVdq-8rM82OpQ>
    <xmx:4nYdaYF5TZ6y7jPVw3VPc47XJNWOITonrIsibBz-Ic7PtiSkmQQ_NQ>
    <xmx:4nYdadqOvaTEXGXLcWWArpNb5og4Agn2j-6ZjnueWQtFt8wjVgIbNg>
    <xmx:4nYdaU64BD8mlRfndiJSf1VWdEooCSi9RuNwbgWeftGEWFJn4xzkFQ>
    <xmx:4nYdafte-vKPCz7uUOsKeTLKjoBeBR7ll2N0f010HXUSY83Y5hEGhyVS>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 19 Nov 2025 02:50:58 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 3a265c7d (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO)
	for <git@vger.kernel.org>;
	Wed, 19 Nov 2025 07:50:56 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 00/13] Centralize management of object database sources
Date: Wed, 19 Nov 2025 08:50:48 +0100
Message-Id: <20251119-b4-pks-odb-creation-v1-0-2b2ed2612cb6@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANh2HWkC/x2MSQqAMAwAvyI5G2iK+1fEQ5dUg6DSigji3y0eB
 2bmgcRROMFQPBD5kiT7loHKAtxitplRfGbQStdEqkVb4bEm3L1FF9mc2ce+cdQFbyx5Dbk8Ige
 5/+s4ve8H9p39gWUAAAA=
X-Change-ID: 20251107-b4-pks-odb-creation-96c18fdab1d2
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.3

Hi,

currently, the creation of the object databases is handled both by
"setup.c" and by "odb.c". While it's expected that "setup.c" is the one
setting up the object database itself, what's less so is that there is a
shared responsibility for managing its sources:

  - The primary object database source gets created in "setup.c".

  - The temporary source used during ODB transactions is handled by
    "setup.c" when changing the current working directory.

  - Relative paths stored in object database sources get updated by
    "setup.c" when changing the current working directory.

This means that the management of ODB sources is somewhat cluttered and
thus hard to understand. Furthermore, it has the consequence that
"setup.c" reaches into internals of the ODB that really shouldn't be any
of its concern.

This patch series cleans that up and moves all handling of ODB sources
into "odb.c". This hopefully makes the logic easier to understand and it
will allow us to eventually handle the logic for different backends in a
single central location.

The series is structured as follows:

  - Patches 1 to 5 clean up some smaller nuisances in the vicinity.

  - Patches 6 to 9 refactor a couple of callsites that play weird games
    with the object database. These cause us to re-initialize the ODB
    multiple times, which will not be allowed anymore at the end of this
    series.

  - Patches 10 to 13 move the logic that manages object sources from
    "setup.c" into "odb.c".

This series is built on top of v2.52.0 with ps/object-source-loose at
3e5e360888 (object-file: refactor writing objects via a stream,
2025-11-03) merged into it.

Thanks!

Patrick

---
Patrick Steinhardt (13):
      path: move `enter_repo()` into "setup.c"
      setup: convert `set_git_dir()` to have file scope
      odb: adopt logic to close object databases
      odb: refactor `odb_clear()` to `odb_free()`
      odb: move logic to disable ref updates into repo
      oidset: introduce `oidset_equal()`
      builtin/index-pack: fix deferred fsck outside repos
      t/helper: stop setting up `the_repository` repeatedly
      http-push: stop setting up `the_repository` for each reference
      odb: handle initialization of sources in `odb_new()`
      chdir-notify: add function to unregister listeners
      odb: handle changing a repository's commondir
      odb: handle recreation of quarantine directories

 builtin/clone.c            |   2 +-
 builtin/gc.c               |   2 +-
 builtin/index-pack.c       |  21 ++++-
 builtin/receive-pack.c     |   2 +-
 builtin/repack.c           |   2 +-
 builtin/upload-archive.c   |   2 +-
 builtin/upload-pack.c      |   2 +-
 chdir-notify.c             |  18 ++++
 chdir-notify.h             |   2 +
 fsck.c                     |   6 ++
 fsck.h                     |   7 ++
 http-backend.c             |   1 +
 http-push.c                |   5 +-
 midx-write.c               |   2 +-
 odb.c                      |  98 +++++++++++++++++----
 odb.h                      |  37 +++++---
 oidset.c                   |  16 ++++
 oidset.h                   |   9 +-
 packfile.c                 |  15 ----
 packfile.h                 |   1 -
 path.c                     | 100 ---------------------
 path.h                     |  15 ----
 refs.c                     |   2 +-
 repository.c               |  27 ++----
 repository.h               |  10 ++-
 run-command.c              |   2 +-
 scalar.c                   |   2 +-
 setup.c                    | 214 +++++++++++++++++++++++++++++++--------------
 setup.h                    |  39 ++++++++-
 t/helper/test-repository.c |  16 +---
 t/t5302-pack-index.sh      |  16 ++++
 31 files changed, 414 insertions(+), 279 deletions(-)


---
base-commit: 0ce8ad0c2b447fea8e7abd0236367a9f38ce92fe
change-id: 20251107-b4-pks-odb-creation-96c18fdab1d2

