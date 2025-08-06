Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A9D5273FE
	for <git@vger.kernel.org>; Wed,  6 Aug 2025 05:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754459666; cv=none; b=YMgRi87afGp3MXMNjs+qww2ONQ1zKtPEGL63lgZk7LZuQL7eCfA5cGtmqLhNZzMg9QK1ZWCjqenUQUuvhM5ZiSMxFc51RnVNhBiWySA60ETvH3PrneejHchug8PloI9DzArapMCrOa3p326nzkEQd/2tyNmbhma1TCHuGtuR2SQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754459666; c=relaxed/simple;
	bh=3/914ZmBGgNcvQlwOLcu0FhhrOWExYE3vZuX7KcJuM0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=OBTuQIfiIVOw5WP9PxiXWuNnQQzlz2hNS3anDJarlV++1XRjaRt4m676Lyki3myi/3f15WZcIf2XgrQ31OwnCYi9CNLCSg5Hz4WI0RdxUE/kZE3Sqa8sC07Xz0/GYY4c/vzId1TGO5wKsngpCEfgradLHIYAh9VWv79Flf1bNfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=iZtqID0d; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=N2NCZe12; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="iZtqID0d";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="N2NCZe12"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 3CD567A0124;
	Wed,  6 Aug 2025 01:54:23 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Wed, 06 Aug 2025 01:54:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1754459663;
	 x=1754546063; bh=a+A+Zvmct0PJ0+9aVMeNCWBOCf5LcSZJy+hXOo/p3Js=; b=
	iZtqID0dUnIRwQPAFEYBydcDhf/3s0GcjSL/DBmIdPiGm5/TrnO29Y0lC1qZ/5SR
	DNkYXJXGbpg/cE2qura8dBA29G/602vqVUxBz4QtfwHnPMW131JLY0NSu8K/fo3P
	sSk9kHv5jKJTWWECyqt8G0ZZXrnvC9kkJaNZfRn5M+v1xxg0dkaK2ignIsDF5JGv
	77pyIbCnW/bPgG/O6dfNOENHyMjmJowfwIT55zPrR+JTOhfJ9vXRGkmoHbtBA6uH
	9ZmYIdg+8zQploltv7u5OP6GCJgbNeQKvq+kqmAG/EMtyp9VuGTtd98qaHR9QxGg
	3Q4R7iHHis4Ac9vCqshCpg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1754459663; x=
	1754546063; bh=a+A+Zvmct0PJ0+9aVMeNCWBOCf5LcSZJy+hXOo/p3Js=; b=N
	2NCZe12j8dLWzdbYpRLvF2Q+6ovsmhk2hdE/+eoP3mJ/pTH9whmyG8NR6yevUgbH
	6lVqxHS7Q81FCVatoJsboZiVsxlqKgXex1xE/Bj1uzzxAPzZSYbK9FM4/D+vs1Ni
	8sAf0M3cAtFIW09PTg2f3Dnvnr+adde9FKIfHZpSkOxFkEY3UEHdnI2KgjYgpbpZ
	the6118pa8fkS6AuMp8mCMXJo2JfuGJOhjuO4LPah1ADkZP565JorFbBMV3djz+X
	Jc1Z+pmv8DfoowISZoJZQQ58F6TDL1MpjdMb4OWN+0bBGetf3mhAmLgZgLExCa+D
	yCIEsq4kQuPbcFbgBDh3Q==
X-ME-Sender: <xms:Du6SaFWGpElLcKc6FB8Tbe9-8so4xWgUkEtFgHHIxShK3j-AzsYDcw>
    <xme:Du6SaBTJvyu9LRmc4gAiQsuo4H6TmkZarXs3l9DJCtFrFsq3odrazvRX9e6cNzeUL
    zhFW3oSDdu8acnNtA>
X-ME-Received: <xmr:Du6SaN2WNdaYo0zAAxNn9KYGoD4Aos2mBIFXNjvLamtVKesaemY4rSjoLviIqFkExuwKiE6DdtroxVljHa9sBOEAUd7iyZA2UpfnHY6u_w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduudejvdeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffufffkgggtgfgjfhfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeetueeuhefhhfeitdeuhedttdeikeeftdduhedtheefhfegffevgeegtdfhheeuvden
    ucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohep
    uddtpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehkrghrthhhihhkrddukeekse
    hgmhgrihhlrdgtohhmpdhrtghpthhtohepshiivgguvghrrdguvghvsehgmhgrihhlrdgt
    ohhmpdhrtghpthhtohepsggvnhdrkhhnohgslhgvsehgmhgrihhlrdgtohhmpdhrtghpth
    htohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepphgvfhhfsehp
    vghffhdrnhgvthdprhgtphhtthhopehkrhhishhtohhffhgvrhhhrghughhssggrkhhkse
    hfrghsthhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgt
    ohhmpdhrtghpthhtohepjhhnrdgrvhhilhgrsehfrhgvvgdrfhhrpdhrtghpthhtohepgh
    hithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:Du6SaBeiNXAZ3GMrAtbMcFD075FQLg0e0rUvbNAaJzHDYBEzxKgZ3g>
    <xmx:Du6SaFMlrS4kobaBOB9ePHXjYhBOESRI30Zkbgtw9QBwspd9Af9QuQ>
    <xmx:Du6SaFXfhWXk4GLD83O4LCHqM2cHXuiXzsNyDh1FMlUT1lBJ5oqqLQ>
    <xmx:Du6SaNyFdNuA3JLJ1OqKqZnSscTx_xi-T961xZL_nFcLvNjUVCZgVg>
    <xmx:D-6SaLAskNwIaV7zl2UbXhDF6FC2rvyrUmc6aB6uuvO-yrUDTo1_vopp>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 6 Aug 2025 01:54:21 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 0934abf6 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 6 Aug 2025 05:54:20 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v6 0/9] refs: fix migration of reflog entries
Date: Wed, 06 Aug 2025 07:54:11 +0200
Message-Id: <20250806-pks-reflog-append-v6-0-a50839653766@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAPukmgC/33OwW6DMAwG4Fepcl4mx04I2WnvMfUAxGmjbYDIh
 DpVvPtMDxtIaMc/zvfbd1V4ylzUy+muJp5zyUMvoXo6qe7a9BfWOUpWCOjAI+rxveiJ08dw0c0
 4ch91RdZ4jHXTYqfEjTLOt0fn21nyNZevYfp+rJjN+vpf22w0aFMTu2BDZFO9yp/n/KnWqhm33
 B1xFM6WfdcyJefrHactD0echIfK2EgGEnjacfvHa7BH3K7HExpKnDwC7Ljb8sPjnXBwEIKPLYT
 ofvmyLD8+EbiLqwEAAA==
X-Change-ID: 20250722-pks-reflog-append-634172d8ab2c
In-Reply-To: <20250722-pks-reflog-append-v1-0-183e5949de16@pks.im>
References: <20250722-pks-reflog-append-v1-0-183e5949de16@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, 
 Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>, 
 =?utf-8?q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>, 
 Toon Claes <toon@iotcl.com>, Jeff King <peff@peff.net>, 
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
 Ben Knoble <ben.knoble@gmail.com>, 
 =?utf-8?q?Jean-No=C3=ABl_AVILA?= <jn.avila@free.fr>
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

Changes in v4:
  - Improve one of the tests to use an existing abbreviated object ID
    instead of a non-existing one to make sure that we indeed fail due
    to the abbreviation.
  - Don't abort the transaction when HEAD has been racily updated, but
    drop the log-only update instead.
  - Link to v3: https://lore.kernel.org/r/20250729-pks-reflog-append-v3-0-9614d310f073@pks.im

Changes in v5:
  - Revert back to the logic that aborts the transaction if we see a
    racy HEAD update. It's the pragmatic thing to do for an edge case
    that is very unlikely to ever happen.
  - Link to v4: https://lore.kernel.org/r/20250804-pks-reflog-append-v4-0-13213fef7200@pks.im

Changes in v6:
  - Convert options to use backticks in git-reflog(1) to appease the
    upcoming new manpage linter.
  - Link to v5: https://lore.kernel.org/r/20250805-pks-reflog-append-v5-0-050997db09d5@pks.im

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

 Documentation/git-reflog.adoc |  96 +++++++++++++++++---------------
 builtin/reflog.c              | 103 +++++++++++++++++++++++++++-------
 ident.c                       |   2 +-
 ident.h                       |   2 +-
 refs.c                        |  60 +++++++++++---------
 refs.h                        |  24 +++++++-
 refs/files-backend.c          |  65 +++++++++++++++++++---
 refs/refs-internal.h          |   3 +-
 refs/reftable-backend.c       |  26 ++++++---
 t/meson.build                 |   1 +
 t/t1421-reflog-write.sh       | 126 ++++++++++++++++++++++++++++++++++++++++++
 t/t1460-refs-migrate.sh       |  22 +++++---
 12 files changed, 413 insertions(+), 117 deletions(-)

Range-diff versus v5:

 1:  22b0ea5e69 <  -:  ---------- Documentation/git-reflog: convert to use synopsis type
 -:  ---------- >  1:  289dcbe595 Documentation/git-reflog: convert to use synopsis type
 2:  bf5d901269 !  2:  0363c102e6 builtin/reflog: improve grouping of subcommands
    @@ Documentation/git-reflog.adoc: Options for `show`
     +Options for `drop`
     +~~~~~~~~~~~~~~~~~~
     +
    -+--all::
    ++`--all`::
     +	Drop the reflogs of all references from all worktrees.
     +
    -+--single-worktree::
    ++`--single-worktree`::
     +	By default when `--all` is specified, reflogs from all working
     +	trees are dropped. This option limits the processing to reflogs
     +	from the current working tree only.
    @@ Documentation/git-reflog.adoc: which didn't protect objects referred to by reflo
     -Options for `drop`
     -~~~~~~~~~~~~~~~~~~
     -
    ----all::
    +-`--all`::
     -	Drop the reflogs of all references from all worktrees.
     -
    ----single-worktree::
    +-`--single-worktree`::
     -	By default when `--all` is specified, reflogs from all working
     -	trees are dropped. This option limits the processing to reflogs
     -	from the current working tree only.
 3:  709148c2a2 =  3:  ff885b29f4 refs: export `ref_transaction_update_reflog()`
 4:  3ad459bf6e =  4:  8ad1992cc9 builtin/reflog: implement subcommand to write new entries
 5:  207546401a =  5:  bb5dddf606 ident: fix type of string length parameter
 6:  0791e82645 =  6:  e15eba8029 refs: fix identity for migrated reflogs
 7:  e5c0280a36 =  7:  c83037d9a4 refs/files: detect race when generating reflog entry for HEAD
 8:  c31e03ebcb =  8:  8be3d5c126 refs: stop unsetting REF_HAVE_OLD for log-only updates
 9:  61acc7af7a =  9:  11a21b71f6 refs: fix invalid old object IDs when migrating reflogs

---
base-commit: d82adb61ba2fd11d8f2587fca1b6bd7925ce4044
change-id: 20250722-pks-reflog-append-634172d8ab2c

