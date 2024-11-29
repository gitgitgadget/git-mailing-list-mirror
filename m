Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96291156991
	for <git@vger.kernel.org>; Fri, 29 Nov 2024 13:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732886030; cv=none; b=ZA4d0nowhJ/KXS3nduZlA0JsTTyIw2SGVF5kvRb85lW2CuZs/+RLWW0jr8HRpwK0+jybZBnn+alCWkqCRXP7w8tSPkfbcayO7PMQ/1G5mbjRUBkUTW1NWMfS9I+KfOgjDjPKyhBdUsci9BO0pJDj+HjLg2oHHZm9V6dUbnDldRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732886030; c=relaxed/simple;
	bh=BRahPjj+/UErlRxsxeaLxYhzlX1dG29eqcpRA3xzBa4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=MO7qzIseL/FpBhu7/VtXDn1Q7YfmDysWgPZPOh2e1fJfHwOiyydj0Gbnr5vucjA0CTTuYIKWCMudC2KjouVxCSANWygJ1uPe1IQPWVsY6H5f/JSYG/gkuhQkcyxNNrG2zD4PLmIdUziPQdWxZrsQSzrxOh/6brvt4n9+76O4Iuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=nNWoPbJN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=5I3tO6UA; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="nNWoPbJN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="5I3tO6UA"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 8C70D2540103
	for <git@vger.kernel.org>; Fri, 29 Nov 2024 08:13:46 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Fri, 29 Nov 2024 08:13:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm1; t=1732886026; x=1732972426; bh=Unc9qJkHwR
	C9/dq04nHyCbZ9HdPSynGiUi0BLiUid8k=; b=nNWoPbJNaM3M7Qc7pKfykv5Gns
	KhdIOmtwdwFhKj0a+pLTBXN9/rVl0cpEisY9dKI787k/M+GPPerRSmtL4hoNZnYJ
	tAwS0N9/4fKQo9IKZaUi8MJSGnTLtvBw/dpYwBhtIzIcVMj6oaHolPw33funvzVe
	T4fMJA4q9xrl1ivrx8HveYJi+/zdKp3KG/R5nrPbDuaERPyMx8uRXiDvglRmQ7zD
	BQijcbL3VuUkASh2zhYhr4Wcl7XgP03obaqqU2QqLPhD3+xUoXhDp0qL8pYCJT3g
	iWaJhJohkrHDTTwCXggZBgX2UII10hla91y1nWi0g/Ae3/Q1UmUhF4SThcLw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1732886026; x=1732972426; bh=Unc9qJkHwRC9/dq04nHyCbZ9HdPS
	ynGiUi0BLiUid8k=; b=5I3tO6UATjo76IiBWifUzQPl7XclKMJKsx2KU9zqFKJQ
	cgcYPwH3rS1Tn5S4I9ntREsWSM5Vdy6/8NO3DmJLtRqCSj8xqasXB2IbnpmTBSO4
	rSSx2IfOFKIp1KvM7a51fc76Mp/GRP7ArE2nSPcciJPNnzRx0hD/j3Oi+6Z0PbmR
	5aYwBJcBVx6qtWZsHeey9zB3wjEux+TggZ1aemLjFxDCaG0zmLZarBs9ZKEebrWW
	tpckc88eecLujW/I+1XnHo+wHs7bptsv7oQdcQ+IQ+zly8sOA/2MepjzIWdiqXNV
	XuOYRvvelFlPd02zN7V5D5QrzOBZ6WHi+qe6GGtBSg==
X-ME-Sender: <xms:Cr5JZ-L5OZZmVLC28bGam-7y2jdYWwvdhF6h-UySNUaiWN5cZwKstg>
    <xme:Cr5JZ2KNfq3PfVlksR-TbnV30d7-FQfFIlCCJwfARrjJ5cuaW8RqLA2glxG_vNnew
    LUzTuHvt-c5B6Sosw>
X-ME-Received: <xmr:Cr5JZ-uWoNu-wRar2o7Kz0gJs-KoM7ovCXIiPbmIRbYLItNTvsZmUtaOazl2nkiBIlZbUO9WvFTwuOsu6WM7Dn0aP1GXflVUPyaUg1l5qPrOCK3o7Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrheefgdegkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecuogfvvgigthfqnhhlhidqqd
    etfeejfedqtdegucdlhedtmdenucfjughrpefhufffkfggtgfgvfevofesthejredtredt
    jeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepveejheduueehgeehhffhveeukeetieeuleetveel
    keefleetffevlefffffhkeegnecuffhomhgrihhnpehmrghkrdguvghvnecuvehluhhsth
    gvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdp
    nhgspghrtghpthhtohepuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhith
    esvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:Cr5JZzbQfvqgRh7r6ebp4tPaU4kS0Xe1h20ZGRDpRK210p5KWYLNLg>
    <xmx:Cr5JZ1bvGpkuVltO7gQyiRP18MoqSxN3oyDOGbiUXhvo2H7StCnEyA>
    <xmx:Cr5JZ_DHrRt1ZrW_oBX5nCEn_ZVoAFO8BD8cYeOBWuWr_-HsX26MZA>
    <xmx:Cr5JZ7ZSfc5h8NyAxLb3arAIu8GUBrilWkx-wUBuhGoMWZprVPgy6w>
    <xmx:Cr5JZ0xsz8qVDR8LjL6T1tm0hVINVEcHUXDQ3L-GMvT93NGmZ0QNqr0r>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Fri, 29 Nov 2024 08:13:45 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 63f14f69 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Fri, 29 Nov 2024 13:12:33 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 00/10] Start compiling with `-Wsign-compare`
Date: Fri, 29 Nov 2024 14:13:21 +0100
Message-Id: <20241129-pks-sign-compare-v1-0-fc406b984bc9@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPG9SWcC/x3MSwqAMAwA0atI1gZMEfxcRVzUGmsQa2lABOndL
 S7fYuYF5SSsMFYvJL5F5QoFVFfgdhs8o6zFYBrTEpke46Go4gO664w2MQ5u61oyi2OyULKYeJP
 nX05zzh/FYBdeYgAAAA==
X-Change-ID: 20241128-pks-sign-compare-9cf7412bce1a
To: git@vger.kernel.org
Cc: 
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

There are a couple of trivial conflicts with kn/midx-wo-the-repository,
but I don't think it makes sense to make that a dependency of this
sereis. Let me know in case you disagree and I'll change the base of
this series.

Thanks!

Patrick

---
Patrick Steinhardt (10):
      git-compat-util: introduce macros to disable "-Wsign-compare" warnings
      compat/regex: explicitly ignore "-Wsign-compare" warnings
      compat/win32: fix -Wsign-compare warning in "wWinMain()"
      global: mark code units that generate warnings with `-Wsign-compare`
      config.mak.dev: drop `-Wno-sign-compare`
      global: fix unsigned integer promotions in ternary statements
      diff.h: fix index used to loop through unsigned integer
      global: trivial conversions to fix `-Wsign-compare` warnings
      daemon: fix loops that have mismatching integer types
      daemon: fix type of `max_connections`

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
 builtin/blame.c                      |  5 ++++-
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
 builtin/patch-id.c                   |  3 ++-
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
 dir.c                                |  5 +++--
 entry.c                              |  4 ++--
 ewah/ewah_bitmap.c                   |  5 ++---
 ewah/ewah_io.c                       |  3 +++
 ewah/ewah_rlw.c                      |  3 +++
 fetch-pack.c                         |  1 +
 fmt-merge-msg.c                      |  1 +
 fsmonitor.c                          |  1 +
 gettext.c                            |  2 +-
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
 strbuf.c                             |  4 +++-
 string-list.c                        |  2 ++
 strvec.c                             |  3 +--
 submodule-config.c                   |  1 +
 submodule.c                          |  1 +
 symlinks.c                           |  2 ++
 t/helper/test-bloom.c                |  9 ++-------
 t/helper/test-cache-tree.c           |  1 +
 t/helper/test-config.c               |  1 +
 t/helper/test-csprng.c               |  2 +-
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
 264 files changed, 491 insertions(+), 215 deletions(-)


---
base-commit: cc01bad4a9f566cf4453c7edd6b433851b0835e2
change-id: 20241128-pks-sign-compare-9cf7412bce1a

