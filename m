Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28010200B9B
	for <git@vger.kernel.org>; Mon,  2 Dec 2024 12:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733141103; cv=none; b=XLvHThzJClKZpP4Rq+xCSqVJBqGyBOfVpazOJXrLmmPMurn3BErH05DHIsFjnbkf2DH0i4qdFO7239kE7g3VzoH8z37GADkZa5w9WhXTXAwlyjpA5w2H2NXohpwbuosLQF4BfrBdHlNl9DbtJBDTF+B1R1elFL0R+bn9qj6p1n8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733141103; c=relaxed/simple;
	bh=PC6xvZtQm9JfYv3OsrcAC8cWv+Z1qC8v2mKs+8/M0aw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=If8KQWhdhCZqC5F4LD9kQk7pGFEjSMnVwydgykyjTB2wYWNJU+IlfKIxRKl3VUp3hXRcZyFv4l9AKC8RpGLhcScClUQojmGyXZ2AO1DTv+ViIbNarOFNBELCGcv+vDiqdoG8NPS/8f8a5hF9xXOIIguKMxvpCAzWzwz0luEc3Y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=nRdHqzns; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BPH/CgxV; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="nRdHqzns";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BPH/CgxV"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id 4146F11400F3;
	Mon,  2 Dec 2024 07:04:58 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Mon, 02 Dec 2024 07:04:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1733141098;
	 x=1733227498; bh=QQUDSOqM9RbV2whPAhGHGVTXBHsb/1Cla+IxYUIzsEk=; b=
	nRdHqznsJJ9ZN/KlUOIlVLDfW/UregID4hB42EMs+BDHp1gKFegHPB1SAth28B3Q
	1ddxLnfG9Ka3tla7FEkbBi7vmB3gysYXd6OXaimhU37iEFu3T7eNmY+HC8+bD+gg
	Eg4o2A9qOqeJW/t+e8/p3uA9qYO7WnnQlykFMH+dTtyURqzxM8gmfuqfbsN0nlHh
	YERXazFEIhUuKxzVoCAdTxqHa/USBIleW2QA7/IFa5oZuYRxv0Ss+s8iTj60rAhV
	asizgkTwkcbBp1SVJ7QczLgHVNUGKs+y4yGB45o3QcFGqc1AQVj+BLlB/wHb/2XH
	MreOE2/qcRABAzrTQCkY1Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1733141098; x=
	1733227498; bh=QQUDSOqM9RbV2whPAhGHGVTXBHsb/1Cla+IxYUIzsEk=; b=B
	PH/CgxV6lg3ArNs1Ff2rUDT/tL91vDav7XTmAeb/rORKgtwJ9BJ/DRQT4g3c1Apy
	xRub/sqqeBcMyxMbB+1Qd2aiDiVRWZVkENhA1fswUC47JgKOCD5xkm6TrO/B9+Zh
	QUvZyi6MPbiJpBRYKoutOPuvNyhhXf8cdBv/c381WiPX2Otgnv9MhV6zzxEiR7gy
	GHlIjI8Yuwk0QXOjV6zB5YeJlEUUV3JC+LhQtTYYBhAQvdDG69cEhoqqaFdn17Nz
	NZTENLcpE1OUJ1LbAaAw0iyYMTTLVu9TLHucMW/6UQSCAgLqain0q/tnu9jtbR8P
	0btIPJ/pn03R3gyzSMxKw==
X-ME-Sender: <xms:aaJNZxS7zezQgB8ibZgjqDSCXT7avmgRRu3oaUch5CxgJHYtHzoI3Q>
    <xme:aaJNZ6y7EsDDKiDVdWtbRIuSi0BNYhTzoQeY7DWJ1ZUnLXbHt7pa16VcaOc7QgXhm
    V3pz3SP2_WFQyma1Q>
X-ME-Received: <xmr:aaJNZ23Ihr5xmKTlZQWzkT2oxWjYHuind2TCOecfF-6JDD1abTchwjE6KpOtgSQADfLzT7QCQ-U2aTi-RR9ZEFafwMGjX1gneJXw7dj9NZQs1-RwZQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrheelgdefhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffufffkgg
    gtgfgjfhfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeehgeetheejve
    duleefkeelvdelgeehudetgedtuddvhfekgeevvdekvdettddvudenucffohhmrghinhep
    khgvrhhnvghlrdhorhhgpdhmrghkrdguvghvnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohep
    fedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepshhhvghjihgrlhhuohesghhmrg
    hilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhr
    tghpthhtohepphgvfhhfsehpvghffhdrnhgvth
X-ME-Proxy: <xmx:aaJNZ5Cw1MZnuxIyWP_bz-LzL8lz5RO74yjKkG1hgOMvrMBMwCLjjw>
    <xmx:aaJNZ6hRNKBmEkAi_9E0_ISsDrfoxf1i8ruyCYyS92lRTdTZqUkONA>
    <xmx:aaJNZ9pQaq8PnZk2IHZgfuHTsb_6-nN9l5TFM94Wvw6Lh73nGJi-wg>
    <xmx:aaJNZ1jafTyG_oary9_dsybx5qVT_zxS02PKSa6TqPAA2cGIT-Yghg>
    <xmx:aqJNZ7s3FqB5g9kr2X2gzwRKfIP5q_8pFOcfNPSSnJ7XZAudXFSiypet>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Dec 2024 07:04:56 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 9f751669 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 2 Dec 2024 12:03:39 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 00/14] Start compiling with `-Wsign-compare`
Date: Mon, 02 Dec 2024 13:04:32 +0100
Message-Id: <20241202-pks-sign-compare-v2-0-e7f0ad92a749@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFCiTWcC/2WNwQrCMBBEf6Xs2ZUmBG08+R/SQxI37SJtQiJBK
 fl3Y8GTxzfMvNkgU2LKcOk2SFQ4c1gbyEMHbjbrRMj3xiB7qYSQA8ZHxszTii4s0SRC7fxZCWk
 dCQNtFhN5fu3K29h45vwM6b0/FPFNfzL9LysCe/RO9SerB2WdvrbKkRcYa60fcPl2+60AAAA=
X-Change-ID: 20241128-pks-sign-compare-9cf7412bce1a
In-Reply-To: <20241129-pks-sign-compare-v1-0-fc406b984bc9@pks.im>
References: <20241129-pks-sign-compare-v1-0-fc406b984bc9@pks.im>
To: git@vger.kernel.org
Cc: shejialuo <shejialuo@gmail.com>, Jeff King <peff@peff.net>
X-Mailer: b4 0.14.2

Hi,

when compiling with DEVELOPER=YesPlease, we explicitly disable the
"-Wsign-compare" warning. This is mostly because our code base is full
of cases where we don't bother at all whether something should be signed
or unsigned, and enabling the warning would thus cause tons of warnings
to pop up.

Unfortunately, disabling this warning also masks real issues. There have
been multiple CVEs in the Git project that would have been flagged by
this warning (e.g. CVE-2022-39260, CVE-2022-41903 and several fixes in
the vicinity of these CVEs). Furthermore, the final audit report by
X41 D-Sec, who are the ones who have discovered some of the CVEs, hinted
that it might be a good idea to become more strict in this context.

Now simply enabling the warning globally does not fly due to the stated
reason above that we simply have too many sites where we use the wrong
integer types. Instead, this patch series introduces a new macro that
allows us to explicitly mark files that generate such warnings. Like
this, we can adapt the codebase over time and hopefully make this class
of vulnerabilities harder to land.

Changes in v2:

  - Explode the 6th patch into multiple patches with more careful
    analysis and refactorings

  - Drop the conversion of "gettext.c". To do it properly we'd have to
    fix the return type of `utf8_strwidth()`, which we have already
    marked as a todo.

  - Link to v1: https://lore.kernel.org/r/20241129-pks-sign-compare-v1-0-fc406b984bc9@pks.im

There are a couple of trivial conflicts with kn/midx-wo-the-repository,
but I don't think it makes sense to make that a dependency of this
sereis. Let me know in case you disagree and I'll change the base of
this series.

Thanks!

Patrick

---
Patrick Steinhardt (14):
      git-compat-util: introduce macros to disable "-Wsign-compare" warnings
      compat/regex: explicitly ignore "-Wsign-compare" warnings
      compat/win32: fix -Wsign-compare warning in "wWinMain()"
      global: mark code units that generate warnings with `-Wsign-compare`
      config.mak.dev: drop `-Wno-sign-compare`
      diff.h: fix index used to loop through unsigned integer
      global: trivial conversions to fix `-Wsign-compare` warnings
      daemon: fix loops that have mismatching integer types
      daemon: fix type of `max_connections`
      gpg-interface: address -Wsign-comparison warnings
      builtin/blame: fix type of `length` variable when emitting object ID
      builtin/patch-id: fix type of `get_one_patchid()`
      scalar: address -Wsign-compare warnings
      t/helper: don't depend on implicit wraparound

 add-interactive.c                    |  1 +
 add-patch.c                          |  1 +
 advice.c                             |  7 ++-----
 apply.c                              |  1 +
 archive.c                            |  1 +
 attr.c                               |  1 +
 base85.c                             |  3 +--
 bisect.c                             |  1 +
 blame.c                              |  1 +
 bloom.c                              |  2 ++
 builtin/add.c                        |  9 +++++----
 builtin/am.c                         |  1 +
 builtin/bisect.c                     |  2 ++
 builtin/blame.c                      | 11 +++++++++--
 builtin/branch.c                     |  2 ++
 builtin/cat-file.c                   |  3 +++
 builtin/checkout--worker.c           |  2 ++
 builtin/checkout-index.c             |  3 +++
 builtin/checkout.c                   |  2 ++
 builtin/clean.c                      |  3 +++
 builtin/clone.c                      |  3 +++
 builtin/commit.c                     |  3 +++
 builtin/describe.c                   |  2 ++
 builtin/diff-files.c                 |  3 +++
 builtin/diff-index.c                 |  2 ++
 builtin/diff-tree.c                  |  1 +
 builtin/diff.c                       |  3 +++
 builtin/difftool.c                   |  5 ++++-
 builtin/fast-export.c                |  3 +++
 builtin/fast-import.c                |  2 ++
 builtin/fetch-pack.c                 |  2 ++
 builtin/fetch.c                      |  3 +++
 builtin/for-each-repo.c              |  5 +++--
 builtin/fsmonitor--daemon.c          |  2 ++
 builtin/gc.c                         |  3 +++
 builtin/grep.c                       |  3 +++
 builtin/help.c                       |  6 +++---
 builtin/index-pack.c                 |  2 ++
 builtin/log.c                        |  3 +++
 builtin/ls-files.c                   |  3 +++
 builtin/mailsplit.c                  |  6 ++++--
 builtin/merge-file.c                 |  2 ++
 builtin/merge-index.c                |  2 ++
 builtin/merge-ours.c                 |  2 ++
 builtin/merge-tree.c                 |  6 +++---
 builtin/merge.c                      |  3 +++
 builtin/mv.c                         |  2 ++
 builtin/name-rev.c                   |  2 ++
 builtin/pack-objects.c               |  2 ++
 builtin/pack-redundant.c             |  4 ++--
 builtin/pack-refs.c                  |  1 +
 builtin/patch-id.c                   | 16 +++++++++-------
 builtin/prune.c                      |  2 ++
 builtin/pull.c                       |  4 ++--
 builtin/push.c                       |  6 ++++--
 builtin/range-diff.c                 |  1 +
 builtin/rebase.c                     |  3 +++
 builtin/receive-pack.c               |  2 ++
 builtin/reflog.c                     |  1 +
 builtin/remote.c                     |  2 ++
 builtin/repack.c                     |  2 ++
 builtin/replay.c                     |  4 +++-
 builtin/rerere.c                     |  9 +++++----
 builtin/reset.c                      |  2 ++
 builtin/rev-list.c                   |  2 ++
 builtin/rev-parse.c                  |  3 +++
 builtin/revert.c                     |  1 +
 builtin/rm.c                         |  3 +++
 builtin/shortlog.c                   |  1 +
 builtin/show-branch.c                |  2 ++
 builtin/show-index.c                 |  2 ++
 builtin/sparse-checkout.c            |  2 ++
 builtin/stash.c                      |  7 +++----
 builtin/submodule--helper.c          |  8 ++++----
 builtin/tag.c                        |  3 +++
 builtin/unpack-objects.c             |  2 ++
 builtin/update-index.c               |  3 +++
 builtin/update-ref.c                 |  2 ++
 builtin/var.c                        |  5 +++--
 builtin/worktree.c                   |  2 ++
 bulk-checkin.c                       |  1 +
 bundle-uri.c                         |  1 +
 bundle.c                             |  1 +
 cache-tree.c                         |  1 +
 chunk-format.c                       |  1 +
 color.c                              |  2 ++
 column.c                             |  2 ++
 combine-diff.c                       |  1 +
 commit-graph.c                       |  1 +
 commit-reach.c                       |  1 +
 commit.c                             |  3 +--
 compat/fsmonitor/fsm-listen-darwin.c |  3 +--
 compat/mingw.c                       |  1 +
 compat/poll/poll.c                   |  2 ++
 compat/regex/regex.c                 |  2 ++
 compat/terminal.c                    |  3 +--
 compat/win32/headless.c              | 17 +++++++++--------
 compat/win32mmap.c                   |  2 ++
 compat/winansi.c                     |  2 ++
 config.c                             |  1 +
 config.mak.dev                       |  1 -
 connect.c                            |  1 +
 convert.c                            |  1 +
 credential.c                         |  1 +
 daemon.c                             | 31 +++++++++++++------------------
 date.c                               |  2 ++
 decorate.c                           |  3 +++
 delta-islands.c                      |  1 +
 diagnose.c                           |  7 +++----
 diff-delta.c                         |  2 ++
 diff-lib.c                           |  1 +
 diff-no-index.c                      |  2 ++
 diff.c                               |  1 +
 diff.h                               |  3 +--
 diffcore-order.c                     |  1 +
 diffcore-pickaxe.c                   |  3 +++
 diffcore-rename.c                    |  3 +--
 diffcore-rotate.c                    |  1 +
 dir.c                                |  1 +
 entry.c                              |  4 ++--
 ewah/ewah_bitmap.c                   |  5 ++---
 ewah/ewah_io.c                       |  3 +++
 ewah/ewah_rlw.c                      |  3 +++
 fetch-pack.c                         |  1 +
 fmt-merge-msg.c                      |  1 +
 fsmonitor.c                          |  1 +
 gettext.c                            |  2 ++
 git-compat-util.h                    | 10 ++++++++++
 git.c                                | 20 +++++++-------------
 gpg-interface.c                      | 14 ++++++--------
 graph.c                              |  1 +
 grep.c                               |  2 ++
 help.c                               |  1 +
 help.h                               |  8 +++-----
 hex.c                                |  6 ++----
 http-backend.c                       |  1 +
 http-push.c                          |  3 +--
 http-walker.c                        |  1 +
 http.c                               |  1 +
 imap-send.c                          |  1 +
 json-writer.c                        |  2 ++
 kwset.c                              |  2 ++
 line-log.c                           |  2 ++
 list-objects-filter-options.c        |  4 +---
 list-objects.c                       |  7 ++-----
 log-tree.c                           |  1 +
 ls-refs.c                            |  4 +---
 mailinfo.c                           |  1 +
 mailmap.c                            |  1 +
 match-trees.c                        |  1 +
 mem-pool.c                           |  2 ++
 merge-ll.c                           |  1 +
 merge-ort.c                          |  1 +
 merge-recursive.c                    |  1 +
 merge.c                              |  4 ++--
 midx-write.c                         |  1 +
 midx.c                               |  1 +
 name-hash.c                          |  1 +
 notes-merge.c                        |  1 +
 notes.c                              |  1 +
 object-file-convert.c                |  1 +
 object-file.c                        |  1 +
 object-name.c                        |  1 +
 object.c                             |  1 +
 pack-bitmap-write.c                  |  1 +
 pack-bitmap.c                        |  1 +
 pack-check.c                         |  1 +
 packfile.c                           |  1 +
 parallel-checkout.c                  |  1 +
 path.c                               |  4 ++--
 pathspec.c                           |  1 +
 pkt-line.c                           |  3 +--
 preload-index.c                      |  1 +
 pretty.c                             |  1 +
 progress.c                           |  1 +
 pseudo-merge.c                       |  1 +
 quote.c                              |  2 ++
 range-diff.c                         |  1 +
 read-cache.c                         |  1 +
 ref-filter.c                         |  1 +
 reflog.c                             |  1 +
 refs.c                               |  1 +
 refs/debug.c                         |  3 +--
 refs/files-backend.c                 |  1 +
 refs/iterator.c                      |  2 ++
 refs/packed-backend.c                |  1 +
 refspec.c                            |  1 +
 reftable/system.h                    |  2 ++
 remote-curl.c                        |  1 +
 remote.c                             |  1 +
 rerere.c                             |  1 +
 resolve-undo.c                       |  1 +
 revision.c                           |  1 +
 run-command.c                        |  1 +
 scalar.c                             |  6 +++---
 send-pack.c                          |  5 ++---
 sequencer.c                          |  1 +
 serve.c                              |  7 ++-----
 server-info.c                        |  1 +
 setup.c                              |  1 +
 shallow.c                            |  1 +
 sideband.c                           |  1 +
 sparse-index.c                       |  1 +
 split-index.c                        |  1 +
 strbuf.c                             |  2 ++
 string-list.c                        |  2 ++
 strvec.c                             |  3 +--
 submodule-config.c                   |  1 +
 submodule.c                          |  1 +
 symlinks.c                           |  2 ++
 t/helper/test-bloom.c                |  9 ++-------
 t/helper/test-cache-tree.c           |  1 +
 t/helper/test-config.c               |  1 +
 t/helper/test-csprng.c               |  3 +--
 t/helper/test-drop-caches.c          |  2 ++
 t/helper/test-dump-fsmonitor.c       |  3 +--
 t/helper/test-dump-split-index.c     |  3 +--
 t/helper/test-dump-untracked-cache.c |  6 +++---
 t/helper/test-genrandom.c            |  2 +-
 t/helper/test-genzeros.c             |  2 ++
 t/helper/test-hash-speed.c           |  5 ++---
 t/helper/test-mergesort.c            |  2 ++
 t/helper/test-parse-options.c        |  5 ++---
 t/helper/test-path-utils.c           |  1 +
 t/helper/test-reach.c                |  3 +--
 t/helper/test-ref-store.c            |  3 +--
 t/helper/test-run-command.c          |  2 ++
 t/helper/test-string-list.c          |  2 ++
 t/helper/test-tool.c                 |  3 +--
 t/helper/test-trace2.c               |  1 +
 t/unit-tests/lib-reftable.c          |  2 ++
 t/unit-tests/t-example-decorate.c    |  4 ++--
 t/unit-tests/t-prio-queue.c          |  2 +-
 t/unit-tests/t-reftable-readwrite.c  |  2 ++
 t/unit-tests/t-reftable-stack.c      |  2 ++
 t/unit-tests/t-trailer.c             |  2 ++
 t/unit-tests/test-lib.c              |  2 ++
 tag.c                                |  1 +
 tmp-objdir.c                         |  3 +--
 trace.c                              |  1 +
 trace2.c                             |  2 ++
 trace2/tr2_sysenv.c                  |  2 ++
 trace2/tr2_tgt_event.c               |  2 ++
 trace2/tr2_tgt_perf.c                |  2 ++
 trailer.c                            |  3 +--
 transport-helper.c                   | 13 ++++++-------
 transport.c                          | 13 ++++---------
 tree-diff.c                          |  1 +
 unix-socket.c                        |  2 ++
 unpack-trees.c                       |  1 +
 upload-pack.c                        |  1 +
 urlmatch.c                           |  2 ++
 usage.c                              |  3 ++-
 userdiff.c                           |  1 +
 utf8.c                               |  2 ++
 version.c                            |  3 +--
 versioncmp.c                         |  3 +--
 worktree.c                           |  1 +
 wrapper.c                            |  3 +++
 ws.c                                 |  3 +++
 wt-status.c                          |  1 +
 xdiff-interface.c                    |  1 +
 xdiff/xdiffi.c                       |  1 +
 xdiff/xinclude.h                     |  2 ++
 264 files changed, 501 insertions(+), 219 deletions(-)

Range-diff versus v1:

 1:  5b2c782738 =  1:  8e09b200d8 git-compat-util: introduce macros to disable "-Wsign-compare" warnings
 2:  c1eb141fdf =  2:  3ce15e5f23 compat/regex: explicitly ignore "-Wsign-compare" warnings
 3:  680691933b =  3:  04494a895f compat/win32: fix -Wsign-compare warning in "wWinMain()"
 4:  4505bb4c98 =  4:  de1e889371 global: mark code units that generate warnings with `-Wsign-compare`
 5:  6e7facfc57 =  5:  16ca92124c config.mak.dev: drop `-Wno-sign-compare`
 6:  08bccc364c <  -:  ---------- global: fix unsigned integer promotions in ternary statements
 7:  5fbc479fcb !  6:  5b3768ec93 diff.h: fix index used to loop through unsigned integer
    @@ builtin/am.c
      #include "builtin.h"
      #include "abspath.h"
     
    - ## builtin/blame.c ##
    -@@
    -  */
    - 
    - #define USE_THE_REPOSITORY_VARIABLE
    --#define DISABLE_SIGN_COMPARE_WARNINGS
    - 
    - #include "builtin.h"
    - #include "config.h"
    -
      ## builtin/diff-tree.c ##
     @@
      #define USE_THE_REPOSITORY_VARIABLE
    @@ builtin/pack-refs.c
      #include "builtin.h"
      #include "config.h"
     
    - ## builtin/patch-id.c ##
    -@@
    - #define USE_THE_REPOSITORY_VARIABLE
    --#define DISABLE_SIGN_COMPARE_WARNINGS
    - 
    - #include "builtin.h"
    - #include "config.h"
    -
      ## builtin/range-diff.c ##
     @@
      #define USE_THE_REPOSITORY_VARIABLE
 8:  70591c7cbf !  7:  88382a6e93 global: trivial conversions to fix `-Wsign-compare` warnings
    @@ Metadata
      ## Commit message ##
         global: trivial conversions to fix `-Wsign-compare` warnings
     
    -    We have a bunch of loops all over the place which iterate through a
    -    signed integer with an unsigned index, which generates warnings. Address
    -    these sites for trivial cases and enable `-Wsign-compare` warnings for
    -    these code units.
    +    We have a bunch of loops which iterate up to an unsigned boundary using
    +    a signed index, which generates warnigs because we compare a signed and
    +    unsigned value in the loop condition. Address these sites for trivial
    +    cases and enable `-Wsign-compare` warnings for these code units.
    +
    +    This patch only adapts those code units where we can drop the
    +    `DISABLE_SIGN_COMPARE_WARNINGS` macro in the same step.
     
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
     
    @@ git.c: static int run_argv(int *argcp, const char ***argv)
      
      				strbuf_addf(&sb, "\n  %s", item->string);
     
    - ## gpg-interface.c ##
    -@@
    - #define USE_THE_REPOSITORY_VARIABLE
    --#define DISABLE_SIGN_COMPARE_WARNINGS
    - 
    - #include "git-compat-util.h"
    - #include "commit.h"
    -@@ gpg-interface.c: static struct gpg_format *use_format = &gpg_format[0];
    - 
    - static struct gpg_format *get_format_by_name(const char *str)
    - {
    --	int i;
    --
    --	for (i = 0; i < ARRAY_SIZE(gpg_format); i++)
    -+	for (size_t i = 0; i < ARRAY_SIZE(gpg_format); i++)
    - 		if (!strcmp(gpg_format[i].name, str))
    - 			return gpg_format + i;
    - 	return NULL;
    -@@ gpg-interface.c: static struct gpg_format *get_format_by_name(const char *str)
    - 
    - static struct gpg_format *get_format_by_sig(const char *sig)
    - {
    --	int i, j;
    -+	int j;
    - 
    --	for (i = 0; i < ARRAY_SIZE(gpg_format); i++)
    -+	for (size_t i = 0; i < ARRAY_SIZE(gpg_format); i++)
    - 		for (j = 0; gpg_format[i].sigs[j]; j++)
    - 			if (starts_with(sig, gpg_format[i].sigs[j]))
    - 				return gpg_format + i;
    -@@ gpg-interface.c: static void parse_gpg_output(struct signature_check *sigc)
    - {
    - 	const char *buf = sigc->gpg_status;
    - 	const char *line, *next;
    --	int i, j;
    -+	int j;
    - 	int seen_exclusive_status = 0;
    - 
    - 	/* Iterate over all lines */
    -@@ gpg-interface.c: static void parse_gpg_output(struct signature_check *sigc)
    - 			continue;
    - 
    - 		/* Iterate over all search strings */
    --		for (i = 0; i < ARRAY_SIZE(sigcheck_gpg_status); i++) {
    -+		for (size_t i = 0; i < ARRAY_SIZE(sigcheck_gpg_status); i++) {
    - 			if (skip_prefix(line, sigcheck_gpg_status[i].check, &line)) {
    - 				/*
    - 				 * GOODSIG, BADSIG etc. can occur only once for
    -
      ## help.h ##
     @@ help.h: static inline void list_config_item(struct string_list *list,
      #define define_list_config_array(array)					\
    @@ refs/debug.c: static void print_update(int i, const char *refname,
      		print_update(i, u->refname, &u->old_oid, &u->new_oid, u->flags,
      			     u->type, u->msg);
     
    - ## scalar.c ##
    -@@
    -  */
    - 
    - #define USE_THE_REPOSITORY_VARIABLE
    --#define DISABLE_SIGN_COMPARE_WARNINGS
    - 
    - #include "git-compat-util.h"
    - #include "abspath.h"
    -@@ scalar.c: static int cmd_reconfigure(int argc, const char **argv)
    - 		NULL
    - 	};
    - 	struct string_list scalar_repos = STRING_LIST_INIT_DUP;
    --	int i, res = 0;
    -+	int res = 0;
    - 	struct strbuf commondir = STRBUF_INIT, gitdir = STRBUF_INIT;
    - 
    - 	argc = parse_options(argc, argv, NULL, options,
    -@@ scalar.c: static int cmd_reconfigure(int argc, const char **argv)
    - 
    - 	git_config(get_scalar_repos, &scalar_repos);
    - 
    --	for (i = 0; i < scalar_repos.nr; i++) {
    -+	for (size_t i = 0; i < scalar_repos.nr; i++) {
    - 		int succeeded = 0;
    - 		struct repository *old_repo, r = { NULL };
    - 		const char *dir = scalar_repos.items[i].string;
    -
      ## send-pack.c ##
     @@
      #define USE_THE_REPOSITORY_VARIABLE
 9:  4ca309206e =  8:  8ee047d15f daemon: fix loops that have mismatching integer types
10:  632f0ca66a =  9:  1869daa9c9 daemon: fix type of `max_connections`
 -:  ---------- > 10:  792587b3a5 gpg-interface: address -Wsign-comparison warnings
 -:  ---------- > 11:  eeb25af26a builtin/blame: fix type of `length` variable when emitting object ID
 -:  ---------- > 12:  4376e88629 builtin/patch-id: fix type of `get_one_patchid()`
 -:  ---------- > 13:  076ac8f65d scalar: address -Wsign-compare warnings
 -:  ---------- > 14:  9d566adc73 t/helper: don't depend on implicit wraparound

---
base-commit: cc01bad4a9f566cf4453c7edd6b433851b0835e2
change-id: 20241128-pks-sign-compare-9cf7412bce1a

