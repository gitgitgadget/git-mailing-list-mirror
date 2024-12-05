Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 368711A8F84
	for <git@vger.kernel.org>; Thu,  5 Dec 2024 09:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733391413; cv=none; b=pi+vpdy1b8f+Z88+dzzLbIFi8jfxwg4/yVr35mY6r6KuLsCX3qmshIJ5bDIo14fpTJoRsxwRIv1rwmQJI8S/PdfYnYGQ0ADZYjUeilAW48QcGglWQeMOd54exqjm+3x53EyXmWyrCckDMCV/B9YpEcRmbN9Ah9JQDnOXvlTgU3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733391413; c=relaxed/simple;
	bh=TJ+ZQb1jfjCyfHwsCG57+KeKPKq9uJLOwbOQrenTVJE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=W2muUC4tdkPEh4r2qnJT5G/+1RmJtA/Ca9r7EQuiOEqs6p3/pQu3uvnLKQJbHCG+nKW145Ynga7Yr/r2xYEF0VOlsOnjlBNSeLUSs7jyKaWKjFSEi9xQHfrHfgfkBB3LY5v6htwiGcY7vJ/zEx980QjPQUFqk+ywF6+KqNZ/FRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=uveGcsl9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=tC0iNZOV; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="uveGcsl9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="tC0iNZOV"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 1CD3B11401D5;
	Thu,  5 Dec 2024 04:36:50 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Thu, 05 Dec 2024 04:36:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1733391410;
	 x=1733477810; bh=+OMZYYGKER96Zql3ifaU0eGBMdm1TqnayHC2E13luB4=; b=
	uveGcsl9GKtlz/x78MvHQ15nftUc/1HRBKbd4a/9FHBFV7hjn3IdX7UI9xGwKEhr
	OHq1QIc3hobkqJ+dFGFv8ph4AETVcIdEQYZiluTfwP78ntvu56IhG1FkoC8pVKYk
	GhcyWx4RHRr8icowkzi9FySz+i3Y/UxQF1KfQ16YDNJ3sWgGXSYQ3cOLfOzPx+Fq
	kpfhOyeOFbcRYAMIUTFlPRsZeQBlYE+RPI7cHKbq1zvGtolsvCktgmLWTyCTyVQ/
	2e02p+YSb4tgUGF4d12kMT0KEAt5oxx0GnlDn3J9HFCcRzBygZoG4ikAVLtVqiwp
	yGKwQ4e+gzZ//2uXvDGOBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1733391410; x=
	1733477810; bh=+OMZYYGKER96Zql3ifaU0eGBMdm1TqnayHC2E13luB4=; b=t
	C0iNZOVqbNcFbmuRJAo1NYzFGbZtxWz12HnTyPHGsvw6O+H2tqGuRJB7frougXxE
	S+GkPF5hT5WzB0755KDVbI6LxJHzaPPkJrAJD1fnKagj5vSloqXCkm2hhmlRdWOM
	6n0u6H3tt85ImHoAV9vuoLxswVY7PqYxoYdnXGJTWpSjCr+yxnGOn5Fpjw3DEw+P
	wdidXICPTmM/XOUvhCNUCr639IlIoTFz+J3IOmxCKJu4gPJKixxGL4UWbrKQqJ6H
	9zioSrhShkIMDsJKtdzcEhpIJTTHej5v1IE9G6ghORh2l47ML+EbNgHlg/dJS6ny
	57gosnbQAIGsUraYhCETQ==
X-ME-Sender: <xms:MXRRZ1oWJWQWKQlV1FP7qUsgPVXY0QSoW_js86PTTUt2sQcHx6KGmA>
    <xme:MXRRZ3p8zeQTA6H-pc7nALN_AdElO_Nvbngahy1e_dxadXWw62nAe8lPuGG0livwW
    r0bbsbWjvUfaTp6Nw>
X-ME-Received: <xmr:MXRRZyP0K425Tchiu1_sq0q1JTxg_AXdidkaLvf5pKGpno6nAsWTy9Nb18CDzRyighvdAMg0JyYIytKbH1csTWajR-hQRchmLHT_szQbX2WmRQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrieejgddthecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffufffkgg
    gtgfgjfhfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeehgeetheejve
    duleefkeelvdelgeehudetgedtuddvhfekgeevvdekvdettddvudenucffohhmrghinhep
    khgvrhhnvghlrdhorhhgpdhmrghkrdguvghvnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohep
    gedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepshhhvghjihgrlhhuohesghhmrg
    hilhdrtghomhdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohep
    ghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrse
    hpohgsohigrdgtohhm
X-ME-Proxy: <xmx:MXRRZw7RNUi1UNaJVu46-oLBwhQ_mU69CIhX8wLF_-IT4Ft9mEX9sw>
    <xmx:MXRRZ05b6DHpHFLAWXEvMKhW_gK2eR8l8E1h2e5Soo_wYJ2Q9-xYLA>
    <xmx:MXRRZ4iQxVLdixKiZVy7Z4P1ep1gpDU1b4Jme2NNOJXSDNNtJxql0Q>
    <xmx:MXRRZ25L9l3mdZSakALe2CNvgBUYvnco49ryqUYrtygklu-Vxg093Q>
    <xmx:MnRRZ_2ZcKMVKRfhMl5s-cjmUKnQ-GQRP-I_FejvUNnwg1_Wes5EQ4ZH>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Dec 2024 04:36:48 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id e310d9fe (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 5 Dec 2024 09:35:26 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v3 00/15] Start compiling with `-Wsign-compare`
Date: Thu, 05 Dec 2024 10:36:22 +0100
Message-Id: <20241205-pks-sign-compare-v3-0-e211ee089717@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABd0UWcC/22NzQrCMAyAX2XkbKWtxa2efA/x0HXpFmQ/tFKUs
 Xc3G8gOegl8Id+XGRJGwgSXYoaImRKNA8PpUIDv3NCioIYZtNRGKV2J6ZFEonYQfuwnF1FYH0q
 jdO1ROWBtihjotSVvd+aO0nOM7+1DVuv2G7O/sayEFMEbea5tZWpvr3xypB7WUta7zeOPrdnGM
 kjXWO1Ks9vLsnwAPlBFnusAAAA=
X-Change-ID: 20241128-pks-sign-compare-9cf7412bce1a
In-Reply-To: <20241129-pks-sign-compare-v1-0-fc406b984bc9@pks.im>
References: <20241129-pks-sign-compare-v1-0-fc406b984bc9@pks.im>
To: git@vger.kernel.org
Cc: shejialuo <shejialuo@gmail.com>, Jeff King <peff@peff.net>, 
 Junio C Hamano <gitster@pobox.com>
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

Changes in v3:

  - Include Junio's fix for 32 bit platforms.

  - Improve a commit message.

  - Link to v2: https://lore.kernel.org/r/20241202-pks-sign-compare-v2-0-e7f0ad92a749@pks.im

There are a couple of trivial conflicts with kn/midx-wo-the-repository,
but I don't think it makes sense to make that a dependency of this
sereis. Let me know in case you disagree and I'll change the base of
this series.

Thanks!

Patrick

---
Junio C Hamano (1):
      sign-compare: 32-bit support

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
 csum-file.c                          |  2 +-
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
 pkt-line.c                           |  5 ++---
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
 265 files changed, 503 insertions(+), 221 deletions(-)

Range-diff versus v2:

 1:  c5d30a71fb =  1:  f3866ee766 git-compat-util: introduce macros to disable "-Wsign-compare" warnings
 2:  e320657277 =  2:  5b694e2b06 compat/regex: explicitly ignore "-Wsign-compare" warnings
 3:  a5b71acdf3 =  3:  2d04ae0627 compat/win32: fix -Wsign-compare warning in "wWinMain()"
 4:  fdd24ef3dc !  4:  1ef0944284 global: mark code units that generate warnings with `-Wsign-compare`
    @@ credential.c
      #include "git-compat-util.h"
      #include "abspath.h"
     
    + ## csum-file.c ##
    +@@
    +  */
    + 
    + #define USE_THE_REPOSITORY_VARIABLE
    ++#define DISABLE_SIGN_COMPARE_WARNINGS
    + 
    + #include "git-compat-util.h"
    + #include "progress.h"
    +
      ## daemon.c ##
     @@
      #define USE_THE_REPOSITORY_VARIABLE
 5:  547ca812ec =  5:  678673ffc8 config.mak.dev: drop `-Wno-sign-compare`
 6:  53615491cd =  6:  5342906326 diff.h: fix index used to loop through unsigned integer
 -:  ---------- >  7:  be0a36edbe sign-compare: 32-bit support
 7:  5220623358 =  8:  ac39ac5d02 global: trivial conversions to fix `-Wsign-compare` warnings
 8:  9096129c17 =  9:  c7fbaf15e8 daemon: fix loops that have mismatching integer types
 9:  add7fca26e = 10:  cfb144047d daemon: fix type of `max_connections`
10:  ac1cd2564d = 11:  2b8171aa1e gpg-interface: address -Wsign-comparison warnings
11:  6bab14c587 = 12:  2e5bd44217 builtin/blame: fix type of `length` variable when emitting object ID
12:  6b6a63b276 ! 13:  ff78b07003 builtin/patch-id: fix type of `get_one_patchid()`
    @@ Commit message
         In `get_one_patchid()` we assign either the result of `strlen()` or
         `remove_space()` to `len`. But while the former correctly returns a
         `size_t`, the latter returns an `int` to indicate the length of the
    -    string even though it cannot ever return a negative value. This causes a
    -    warning with "-Wsign-conversion".
    +    stripped string even though it cannot ever return a negative value. This
    +    causes a warning with "-Wsign-conversion".
     
         In fact, even `get_one_patchid()` itself is also using an integer as
         return value even though it always returns the length of the patch, and
13:  2a66935837 = 14:  7fab5dd6ab scalar: address -Wsign-compare warnings
14:  8a846a0c13 = 15:  7f02e005ef t/helper: don't depend on implicit wraparound

---
base-commit: cc01bad4a9f566cf4453c7edd6b433851b0835e2
change-id: 20241128-pks-sign-compare-9cf7412bce1a

