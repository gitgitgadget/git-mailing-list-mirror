Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A02DE10F1
	for <git@vger.kernel.org>; Tue, 29 Jul 2025 08:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753779332; cv=none; b=D14MSVaW0kClMjRNuGdCycM7iNfApFZZ4ovLQNaHoPcKsRV9HJYaAsg7Yhgi5bXAymrGfWjR3/z9bJu4Qm4syYSOm7rwgoQKs/3rlVlSlRoRxicw97MxCbYbWozb5OClEe7MrXcfP1pgN5y4Dz9DuOK7ZpPIqF4LNzQFWLY2+F4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753779332; c=relaxed/simple;
	bh=J+2HKDPg+iVwNYNU5mL5SRYXwMUy1Lw6ec1v42j7dyo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=ouwlG95QVkRUK46XZXTFtZx2jCILCNU8SP8SRnnLUaFg/FdjWytyRC8oHwsk9npQCXVSKjrtA+zlUGAhFNLBcAxrGuSAS8CbBW/1CEGzYNMNmA+bp8R3YcyOOEfKn0z7KQd+1X3xO4rIKHrksknt/xisomSYRfaZHEks+BZf0yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=a+45XUtq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=A44mTfNE; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="a+45XUtq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="A44mTfNE"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 844751D00727;
	Tue, 29 Jul 2025 04:55:29 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Tue, 29 Jul 2025 04:55:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1753779329;
	 x=1753865729; bh=VgByHsWeUYKSaWqkOlN5ZvBornfOowi6dF76Kx3J7K4=; b=
	a+45XUtqpFqJ4eM7LrvBkxLNliYHKcFQNRvuZWTtJcgh/pSN+bsLVWM4J4ZUbsW3
	Bmzcs4b2D0twTVTmamAqLQLK8aN6U3XAs5fdETt9OfpAQKnVF902gW+fVHGDPM6t
	XVbiLGlnXLPOEn7FSYQt4S4k1AtvdhuY82rBClTCoTt8lmm77of7oOVxwjLwQgxq
	rZ9V8V/lWp9gVEjMZJ3gNGzCofimaMzsDM9kqGbq2DBOsFfqtbg5l5bG8BfCTXj2
	mUheDFIx9Q3Tb589C94fSjJCclOFden5EwX6ZmYxcHmYXCLzaCxLgCrpJ4LhslEC
	mSVwLicks84pW1SWgTfGrQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1753779329; x=
	1753865729; bh=VgByHsWeUYKSaWqkOlN5ZvBornfOowi6dF76Kx3J7K4=; b=A
	44mTfNEu6kJcE5dAlnzNRi/T3ERDMVZhm1hrmr2lX6dUr3dfYaXG976i6PClCRGd
	MRjUr8INFT3Se2TpaVQM9QJWAxv8fSv9lZ6nKJdGxrjXQ5C2NZ6myBhbvwHQgRmd
	sdSHcqhulPAIpQjzemQQ0mmq0uFojVELyCccaPZcDxcb+5lQtuCDuJ4zjcQLDxgn
	cQXvJFwsKSoKbBELd8IutsT9TJ3tIvpU2xmaRpKz5V5XrLLeyXMxuBxTZN2hHFlF
	0ogmr+Qkwmgwt+fGVFX5YLOiORAjidyiN/Z7pgZmJWcX1kHdU4Ij+bPlONQoWzzA
	MSWFUdLcPxCKSsYn84wKA==
X-ME-Sender: <xms:gIyIaB3dhEqOnswZvrJO1mw3Vrb4Qt5L7CsuPSuNgtekd0PqufFK4g>
    <xme:gIyIaE8IFJ16Vcf3wXMNJtDXwMicdvd6uH5ezDFVt3TRqm1HZVLDwlxrif6dWUM8-
    3quJtOxiJVCu32H7w>
X-ME-Received: <xmr:gIyIaBo5Xxn9DgrGjr5MYPiqI5EdQDNn9Hpgv8dYHCzpFf1U-hZ_FKkEFlXA1LaWafTLPeoRDbgDK_cwUJtt8G2zquS7qFBFKVqF7zA4i3Y>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdelgeeifecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhufffkfggtgfgjghfvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epteeuueehhffhiedtueehtddtieekfedtudehtdehfefhgeffveeggedthfehuedvnecu
    ffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeel
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehs
    iigvuggvrhdruggvvhesghhmrghilhdrtghomhdprhgtphhtthhopegsvghnrdhknhhosg
    hlvgesghhmrghilhdrtghomhdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgr
    ihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtph
    htthhopehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtgho
    mhdprhgtphhtthhopehjlhhtohgslhgvrhesghhmrghilhdrtghomhdprhgtphhtthhope
    htohhonhesihhothgtlhdrtghomh
X-ME-Proxy: <xmx:gIyIaOTbUAy65aBrKKEJ_Sj_JgquJxqe8qQHcl4J9yxr9bMxtXvnVA>
    <xmx:gIyIaEMuzmO0KxHxmUFIXPUH1hebOWJdENZyORcLOYW5Ry8kAisMQg>
    <xmx:gIyIaMjgJEXNi1tip84QZVEI4EoLmlKBitQ41tXGHKIO-onhDxWDnA>
    <xmx:gIyIaBlM07KLbZaHVMFCm-2SRj1ktS51QkC8pH3-AamzjBvPNReEcg>
    <xmx:gYyIaHawDWDPj4YZU6o78qJBnAfTItFnQIw4ynCw9rsRf7zy1pw-fo3u>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 29 Jul 2025 04:55:27 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 339f2951 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 29 Jul 2025 08:55:25 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v3 0/9] refs: fix migration of reflog entries
Date: Tue, 29 Jul 2025 10:55:18 +0200
Message-Id: <20250729-pks-reflog-append-v3-0-9614d310f073@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHeMiGgC/32NwQ6CMAxAf8XsbA3rGANP/ofxAKxAo8KymUVD+
 HcHB+PBeHxt3+ssAnmmII67WXiKHHgaE6j9TrRDPfYEbBMLzFBnBhHcNYCn7jb1UDtHo4VC5dK
 gLesGW5E8l9b83JrnS+KBw2Pyr+1FlOv0Xy1KyECWinSVV5ZkcUo3B76LNRXxW9e/dEw65WTah
 lSnTfnRl2V5AyeywNvuAAAA
X-Change-ID: 20250722-pks-reflog-append-634172d8ab2c
In-Reply-To: <20250722-pks-reflog-append-v1-0-183e5949de16@pks.im>
References: <20250722-pks-reflog-append-v1-0-183e5949de16@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, 
 Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>, 
 =?utf-8?q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>, 
 Toon Claes <toon@iotcl.com>, Jeff King <peff@peff.net>, 
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
 Ben Knoble <ben.knoble@gmail.com>
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

Changes in v2:
  - !!! The base of this topic has changed so that it sits on top of
    v2.50.1. This is done so that we can backport this change to older
    release tracks.
  - A couple of typo fixes and clarifications for commit messages.
  - Reorder sections in git-reflog(1) manpage according to the
    reordering we have in the synopsis.
  - Add a section for the new `write` command.
  - Improve test coverage for the `git reflog write` command.
  - Avoid `cat`ing a file into a Bash loop.
  - Remove a stale comment.
  - Make `ref_update_expects_existing_old_ref()` a bit more straight
    forward.
  - Link to v1: https://lore.kernel.org/r/20250722-pks-reflog-append-v1-0-183e5949de16@pks.im

Changes in v3:
  - `git reflog write` now requires fully-qualified refnames.
  - A new commit that plugs one part of the race around splitting of
    reflogs for HEAD in the "files" backend.
  - Link to v2: https://lore.kernel.org/r/20250725-pks-reflog-append-v2-0-e4e7cbe3f578@pks.im

Thanks!

Patrick

---
Patrick Steinhardt (9):
      Documentation/git-reflog: convert to use synopsis type
      builtin/reflog: improve grouping of subcommands
      refs: export `ref_transaction_update_reflog()`
      builtin/reflog: implement subcommand to write new entries
      ident: fix type of string length parameter
      refs: fix identity for migrated reflogs
      refs/files: detect race when generating reflog entry for HEAD
      refs: stop unsetting REF_HAVE_OLD for log-only updates
      refs: fix invalid old object IDs when migrating reflogs

 Documentation/git-reflog.adoc |  76 ++++++++++++++------------
 builtin/reflog.c              | 103 ++++++++++++++++++++++++++++-------
 ident.c                       |   2 +-
 ident.h                       |   2 +-
 refs.c                        |  60 +++++++++++---------
 refs.h                        |  24 +++++++-
 refs/files-backend.c          |  65 +++++++++++++++++++---
 refs/refs-internal.h          |   3 +-
 refs/reftable-backend.c       |  26 ++++++---
 t/meson.build                 |   1 +
 t/t1421-reflog-write.sh       | 124 ++++++++++++++++++++++++++++++++++++++++++
 t/t1460-refs-migrate.sh       |  22 +++++---
 12 files changed, 401 insertions(+), 107 deletions(-)

Range-diff versus v2:

 1:  65f4647df02 =  1:  027ac6d12f3 Documentation/git-reflog: convert to use synopsis type
 2:  e53a402a88d =  2:  1570cac0cb9 builtin/reflog: improve grouping of subcommands
 3:  4d060861f50 =  3:  af43c907fa0 refs: export `ref_transaction_update_reflog()`
 4:  ddd471f9891 !  4:  4322f98fcdd builtin/reflog: implement subcommand to write new entries
    @@ Documentation/git-reflog.adoc: The "exists" subcommand checks whether a ref has
      
     +The "write" subcommand writes a single entry to the reflog of a given
     +reference. This new entry is appended to the reflog and will thus become
    -+the most recent entry. Both the old and new object IDs must not be
    -+abbreviated and must point to existing objects. The reflog message gets
    -+normalized.
    ++the most recent entry. The reference name must be fully qualified. Both the old
    ++and new object IDs must not be abbreviated and must point to existing objects.
    ++The reflog message gets normalized.
     +
      The "delete" subcommand deletes single entries from the reflog, but
      not the reflog itself. Its argument must be an _exact_ entry (e.g. "`git
    @@ builtin/reflog.c: static int cmd_reflog_drop(int argc, const char **argv, const
     +		usage_with_options(reflog_write_usage, options);
     +
     +	ref = argv[0];
    -+	if (check_refname_format(ref, REFNAME_ALLOW_ONELEVEL))
    ++	if (!is_root_ref(ref) && check_refname_format(ref, 0))
     +		die(_("invalid reference name: %s"), ref);
     +
     +	ret = get_oid_hex_algop(argv[1], &old_oid, repo->hash_algo);
    @@ t/t1421-reflog-write.sh (new)
     +	)
     +'
     +
    ++test_expect_success 'unqualified refname is rejected' '
    ++	test_when_finished "rm -rf repo" &&
    ++	git init repo &&
    ++	(
    ++		cd repo &&
    ++		test_must_fail git reflog write unqualified $ZERO_OID $ZERO_OID first 2>err &&
    ++		test_grep "invalid reference name: " err
    ++	)
    ++'
    ++
     +test_expect_success 'nonexistent object IDs' '
     +	test_when_finished "rm -rf repo" &&
     +	git init repo &&
    @@ t/t1421-reflog-write.sh (new)
     +	)
     +'
     +
    ++test_expect_success 'can write to root ref' '
    ++	test_when_finished "rm -rf repo" &&
    ++	git init repo &&
    ++	(
    ++		cd repo &&
    ++		test_commit initial &&
    ++		COMMIT_OID=$(git rev-parse HEAD) &&
    ++
    ++		git reflog write ROOT_REF_HEAD $ZERO_OID $COMMIT_OID first &&
    ++		test_reflog_matches . ROOT_REF_HEAD <<-EOF
    ++		$ZERO_OID $COMMIT_OID $SIGNATURE	first
    ++		EOF
    ++	)
    ++'
    ++
     +test_done
 5:  67028ef4439 =  5:  66de5312e83 ident: fix type of string length parameter
 6:  a6bf88a4e89 =  6:  2b9fe08cf76 refs: fix identity for migrated reflogs
 -:  ----------- >  7:  7f87327e17c refs/files: detect race when generating reflog entry for HEAD
 7:  71b0f753dd3 =  8:  792a1d7ce61 refs: stop unsetting REF_HAVE_OLD for log-only updates
 8:  2d88a1e57b8 =  9:  121630b9d64 refs: fix invalid old object IDs when migrating reflogs

---
base-commit: d82adb61ba2fd11d8f2587fca1b6bd7925ce4044
change-id: 20250722-pks-reflog-append-634172d8ab2c

