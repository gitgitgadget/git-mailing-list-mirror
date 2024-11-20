Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8192F19C542
	for <git@vger.kernel.org>; Wed, 20 Nov 2024 13:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732109993; cv=none; b=PFSX3tLwj/JRcGycdB6Um5hbQShrPBSGQHQAUNm76DBVdwWgamckJ17y339tSyr5rl+uydlWCfA0id71lg8sgUa03y6RFT23C6d1AYpVfwzyCeF46GRk43fjSG5LHMLd9eZRifij2bRxhcQWr2TNnUizZ0yMeGszOo6J8IoEP8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732109993; c=relaxed/simple;
	bh=e1pi0/+NJzO7TjmBVowuxweu8TKZWK8vBYwozSPjYio=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=YAtXCzh7TkQ+z3x9Yrl8Sm41l4Ht+iybb5/8DsYz6NZB6vlZoTA5ubLc3Ct5p2oVt7k01D9/PSMHFu2Ji8Qo5maE8Uxb1pTSNeR3IdqF2Jkn1ci0au2Or/tWqkMfguKVf71Ce2eaEKEYXm25ccQVASx3H+sEaktUqIdqv7IH3pI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Hz8/IZof; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FXkSaTQw; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Hz8/IZof";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FXkSaTQw"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfout.phl.internal (Postfix) with ESMTP id 63AA01380368;
	Wed, 20 Nov 2024 08:39:48 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Wed, 20 Nov 2024 08:39:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1732109988;
	 x=1732196388; bh=iX1XmsH3NXW5Yk/3AIpN4XrBaDnnwQRx2U07ijuwAkc=; b=
	Hz8/IZofUuEBRvgDLFxIy5FocJr9pNz6c9X6JjhTCgIeQ/L89UH/TRDkgnBboHDA
	nG2qwtEnD/FDqrukejdExa6Sxvf919nQjwOTQyoXIFXAUsq9j6/ep6i4HgDp5jfS
	q2b6eDr9mhHQ/fNBJLz7an/Bjs4M0b8BF5UsuRGx5UxS/rA0CuXQRhYo1U0cJB77
	X6gx+/4aLJpBmXKrpFOzfS0eVOLloqj/YmldyEqmrqvyY2r23J3cdEm9f6g0d/RY
	u0VVWwQdH4yIt8O/OEhXJUKSN0TK5Fu5l7cOn1PS6Q3xRFKDOfq5SfAlLVsyMvqV
	UuTsp2Rce3Oyd2s4eudsRg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1732109988; x=
	1732196388; bh=iX1XmsH3NXW5Yk/3AIpN4XrBaDnnwQRx2U07ijuwAkc=; b=F
	XkSaTQwSeepOcE5fwbCfgI7j18jsmxLZ61lCiSKOeTauewkE56hdHAe9z7R4O6lA
	xtMGoGbrDCFOJzkC8gC0QHrDusHsvDopHvEdJVHilubfRSDJXXO7wlGZJsbe2M3N
	aFLphLVecL7z7gwiS6YDkkBhbiHs36MXT0p2yyzi0V355WFl/KUvWjG/3/1UqJOn
	NfV6v1m0EYQKOo0qovdatSeOTq6GELppXw8cTYkK+se6uBmVM7Gh4iNVi77fx14Y
	ia8nP8E7GVVe7L9gtwZK2GTbJX5wpUiFETn9TsqgGwgCsZjhhDeSfDrfDWyGpsR4
	OCzILJV34Zl1zvMzO8x0w==
X-ME-Sender: <xms:o-Y9ZzF744PWmvKxRZcA6ldKJdQNqgofzme7AJ_UUMwdN1fecLNvSA>
    <xme:o-Y9ZwWWq98wTPmZ-ZHfui5z9gQLedaeSqIVcF-Ra4CrZSBPyMVDXQroka0hSI2cv
    VfMGbMty5JgMPHISA>
X-ME-Received: <xmr:o-Y9Z1K20_6yNHPw3tECvkgfmI8gofY0AmGt3VxK24H5BHmmUaHftnQy399YDgV6_k3Q8GoBVk3f8kWo5RztnGE-_qcVm2P32tKK6qO5JIYdGg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrfeeggdehgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhufffkfggtgfgjghfvfevofesthejredtredtjeen
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepvddvvdeufeelgfduteefheeghfefffdugfdvledutedv
    ieethfffheejleeuueevnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghdphhhtthhpug
    drshhhpdhhthhtphdqshhhrghllhhofidrshhhpdhhthhtphdqphhushhhqdifvggsuggr
    vhdrshhhpdhhthhtphdqphhushhhqdhsmhgrrhhtrdhshhdphhhtthhprdhshhdphhhtth
    hpqdhfvghttghhqdguuhhmsgdrshhhpdhhthhtphdqfhgvthgthhdqshhmrghrthdrshhh
    pdhhthhtphdqshhmrghrthdqtghomhhmohhnrdhshhdphhhtthhpqdhgvghtrdhshhdphh
    htthhpqdgsrggtkhgvnhguqdhnohhsvghrvhgvrhdrshhhpdhhthhtphdqsggrtghkvghn
    ugdrshhhpdhhthhtphdqsggrtghkvghnugdqtghonhhtvghnthdqlhgvnhhgthhhrdhshh
    dphhhtthhpqdgruhhthhdrshhhpdhhthhtphdqphhrohighidrshhhpdhhthhtphdqtghu
    rhhlqdhvvghrsghoshgvrdhshhdphhhtthhpqdhsthgrthhushdrshhhnecuvehluhhsth
    gvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdp
    nhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepthhooh
    hnsehiohhttghlrdgtohhmpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgt
    phhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhhjuh
    hsthhosehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:o-Y9ZxG5bSr8J_l_yFrdKPgntsjpxVpjpJ8cYs5q0y4CUt8Lw5OLyQ>
    <xmx:pOY9Z5XW7DoY2_12ax0Jr_wOgj6YRm8zQFaedKHYiOJ6oY9kpGPvqg>
    <xmx:pOY9Z8PX42dt2HjewW1w_jZn2tIXSTNt-1nah2q7MyIhA-dbpFfGig>
    <xmx:pOY9Z42hPWR9OWFH4q3Ncp_scylIDURapIqo-iBUYjFB4V0Wqssb7g>
    <xmx:pOY9Z_z0mnS0Y5LaVTQ7pMuiwcrfhPP8T89o5ZUimQDvGFXklnWR341_>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 20 Nov 2024 08:39:46 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id d4d9962c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 20 Nov 2024 13:38:53 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v3 00/27] Memory leak fixes (pt.10, final)
Date: Wed, 20 Nov 2024 14:39:29 +0100
Message-Id: <20241120-b4-pks-leak-fixes-pt10-v3-0-d67f08f45c74@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJLmPWcC/4VPSw7CIBC9imHtEKCUpq68h3FB69CSaouARNP07
 tJq3Dq7N2/eZ2YS0FsM5LCbicdkg53GDIr9jrS9HjsEe8mYCCYkzwONBDcEuKIewNgnBnCRM9D
 KaFVWRhrdkix2Hjc2a0/njHsb4uRfW07i65a0U0JPeVWwmvFaKNrZSF04Zntqb2RVJbFd/gtPA
 hgoXsrG1Nywhv08lk8Vj/dHfi1++yzLG/FI5JP4AAAA
X-Change-ID: 20241111-b4-pks-leak-fixes-pt10-a6fa657f4fac
In-Reply-To: <cover.1730901926.git.ps@pks.im>
References: <cover.1730901926.git.ps@pks.im>
To: git@vger.kernel.org
Cc: =?utf-8?q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>, 
 Jeff King <peff@peff.net>, Toon Claes <toon@iotcl.com>
X-Mailer: b4 0.14.2

Hi,

this is the last part of my series of memory leak fixes. This series
goes a bit further than past series:

  - Patches 1 to 16 plug remaining memory leaks exposed by our test
    suite.

  - Patches 17 to 22 remove the last remaining `UNLEAK()` annotations
    and ultimately remove the macro itself.

  - Patch 23 works around a bug in the leak sanitizer itself.

  - Patches 24 and 25 drop annotations where leak-free tests pass with
    the leak sanitizer.

  - Patches 26 and 27 unconditionally enable leak checking in all newly
    added tests and then drop the `TEST_PASSES_SANITIZE_LEAK`
    annotation.

So once this series lands, the expectation is that any newly added test
needs to be leak free by default. We still have an escape hatch in the
form of the SANITIZE_LEAK prerequisite, but patch authors are expected
to provide good arguments why their test cannot be made leak free.

Changes in v3:

  - Fix bounds checking in `strvec_splice()`.

  - Rename `pos` to `idx` in `strvec_splice()`.

  - Drop no-op code when finding bisection points with
    `FIND_BISECT_ALL`.

Link to v1: https://lore.kernel.org/r/cover.1730901926.git.ps@pks.im
Link to v2: https://lore.kernel.org/r/20241111-b4-pks-leak-fixes-pt10-v2-0-6154bf91f0b0@pks.im

Thanks!

Patrick

---
Patrick Steinhardt (27):
      builtin/blame: fix leaking blame entries with `--incremental`
      bisect: fix leaking good/bad terms when reading multipe times
      bisect: fix leaking string in `handle_bad_merge_base()`
      bisect: fix leaking `current_bad_oid`
      bisect: fix multiple leaks in `bisect_next_all()`
      bisect: fix leaking commit list items in `check_merge_base()`
      bisect: fix various cases where we leak commit list items
      line-log: fix leak when rewriting commit parents
      strvec: introduce new `strvec_splice()` function
      git: refactor alias handling to use a `struct strvec`
      git: refactor builtin handling to use a `struct strvec`
      split-index: fix memory leak in `move_cache_to_base_index()`
      builtin/sparse-checkout: fix leaking sanitized patterns
      help: refactor to not use globals for reading config
      help: fix leaking `struct cmdnames`
      help: fix leaking return value from `help_unknown_cmd()`
      builtin/help: fix leaks in `check_git_cmd()`
      builtin/init-db: fix leaking directory paths
      builtin/branch: fix leaking sorting options
      t/helper: fix leaking commit graph in "read-graph" subcommand
      global: drop `UNLEAK()` annotation
      git-compat-util: drop now-unused `UNLEAK()` macro
      t5601: work around leak sanitizer issue
      t: mark some tests as leak free
      t: remove unneeded !SANITIZE_LEAK prerequisites
      test-lib: unconditionally enable leak checking
      t: remove TEST_PASSES_SANITIZE_LEAK annotations

 bisect.c                                           |  56 +++++++---
 bisect.h                                           |   2 +-
 blame.c                                            |   1 +
 blame.h                                            |   2 +-
 builtin/blame.c                                    |  12 +-
 builtin/branch.c                                   |  33 ++++--
 builtin/clone.c                                    |   1 -
 builtin/diff.c                                     |   1 -
 builtin/help.c                                     |  13 ++-
 builtin/init-db.c                                  |  34 +++---
 builtin/sparse-checkout.c                          |  61 ++++++----
 ci/lib.sh                                          |   1 -
 git-compat-util.h                                  |  20 ----
 git.c                                              | 124 +++++++++++----------
 help.c                                             |  58 +++++-----
 help.h                                             |   2 +-
 line-log.c                                         |   1 +
 revision.c                                         |   4 +-
 split-index.c                                      |   6 +-
 strvec.c                                           |  19 ++++
 strvec.h                                           |   9 ++
 t/README                                           |  21 ----
 t/helper/test-read-graph.c                         |   3 +-
 t/lib-git-svn.sh                                   |   4 -
 t/t0001-init.sh                                    |   1 -
 t/t0002-gitfile.sh                                 |   1 -
 t/t0003-attributes.sh                              |   1 -
 t/t0004-unwritable.sh                              |   1 -
 t/t0005-signals.sh                                 |   1 -
 t/t0006-date.sh                                    |   1 -
 t/t0007-git-var.sh                                 |   1 -
 t/t0008-ignores.sh                                 |   1 -
 t/t0010-racy-git.sh                                |   1 -
 t/t0012-help.sh                                    |   1 -
 t/t0013-sha1dc.sh                                  |   1 -
 t/t0017-env-helper.sh                              |   1 -
 t/t0018-advice.sh                                  |   1 -
 t/t0019-json-writer.sh                             |   1 -
 t/t0020-crlf.sh                                    |   1 -
 t/t0021-conversion.sh                              |   1 -
 t/t0022-crlf-rename.sh                             |   1 -
 t/t0023-crlf-am.sh                                 |   1 -
 t/t0024-crlf-archive.sh                            |   1 -
 t/t0025-crlf-renormalize.sh                        |   1 -
 t/t0026-eol-config.sh                              |   1 -
 t/t0027-auto-crlf.sh                               |   1 -
 t/t0028-working-tree-encoding.sh                   |   1 -
 t/t0029-core-unsetenvvars.sh                       |   1 -
 t/t0030-stripspace.sh                              |   1 -
 t/t0033-safe-directory.sh                          |   1 -
 t/t0035-safe-bare-repository.sh                    |   1 -
 t/t0040-parse-options.sh                           |   1 -
 t/t0041-usage.sh                                   |   1 -
 t/t0050-filesystem.sh                              |   1 -
 t/t0052-simple-ipc.sh                              |   1 -
 t/t0055-beyond-symlinks.sh                         |   1 -
 t/t0056-git-C.sh                                   |   1 -
 t/t0060-path-utils.sh                              |   1 -
 t/t0061-run-command.sh                             |   1 -
 t/t0062-revision-walking.sh                        |   1 -
 t/t0063-string-list.sh                             |   1 -
 t/t0066-dir-iterator.sh                            |   1 -
 t/t0067-parse_pathspec_file.sh                     |   1 -
 t/t0068-for-each-repo.sh                           |   1 -
 t/t0070-fundamental.sh                             |   1 -
 t/t0071-sort.sh                                    |   1 -
 t/t0080-unit-test-output.sh                        |   1 -
 t/t0081-find-pack.sh                               |   1 -
 t/t0090-cache-tree.sh                              |   1 -
 t/t0091-bugreport.sh                               |   1 -
 t/t0092-diagnose.sh                                |   1 -
 t/t0095-bloom.sh                                   |   3 +-
 t/t0100-previous.sh                                |   1 -
 t/t0101-at-syntax.sh                               |   1 -
 t/t0200-gettext-basic.sh                           |   1 -
 t/t0201-gettext-fallbacks.sh                       |   1 -
 t/t0202-gettext-perl.sh                            |   1 -
 t/t0203-gettext-setlocale-sanity.sh                |   1 -
 t/t0204-gettext-reencode-sanity.sh                 |   1 -
 t/t0210-trace2-normal.sh                           |   1 -
 t/t0211-trace2-perf.sh                             |   1 -
 t/t0212-trace2-event.sh                            |   1 -
 t/t0300-credentials.sh                             |   1 -
 t/t0301-credential-cache.sh                        |   1 -
 t/t0302-credential-store.sh                        |   1 -
 t/t0303-credential-external.sh                     |   1 -
 t/t0410-partial-clone.sh                           |   1 -
 t/t0411-clone-from-partial.sh                      |   1 -
 t/t0450-txt-doc-vs-help.sh                         |   1 -
 t/t0500-progress-display.sh                        |   1 -
 t/t0600-reffiles-backend.sh                        |   1 -
 t/t0601-reffiles-pack-refs.sh                      |   1 -
 t/t0602-reffiles-fsck.sh                           |   1 -
 t/t0610-reftable-basics.sh                         |   1 -
 t/t0611-reftable-httpd.sh                          |   1 -
 t/t0612-reftable-jgit-compatibility.sh             |   1 -
 t/t0613-reftable-write-options.sh                  |   1 -
 t/t1000-read-tree-m-3way.sh                        |   1 -
 t/t1001-read-tree-m-2way.sh                        |   1 -
 t/t1002-read-tree-m-u-2way.sh                      |   1 -
 t/t1003-read-tree-prefix.sh                        |   1 -
 t/t1004-read-tree-m-u-wf.sh                        |   1 -
 t/t1005-read-tree-reset.sh                         |   1 -
 t/t1006-cat-file.sh                                |   1 -
 t/t1007-hash-object.sh                             |   1 -
 t/t1008-read-tree-overlay.sh                       |   1 -
 t/t1009-read-tree-new-index.sh                     |   1 -
 t/t1010-mktree.sh                                  |   1 -
 t/t1011-read-tree-sparse-checkout.sh               |   1 -
 t/t1012-read-tree-df.sh                            |   1 -
 t/t1013-read-tree-submodule.sh                     |   1 -
 t/t1014-read-tree-confusing.sh                     |   1 -
 t/t1015-read-index-unmerged.sh                     |   1 -
 t/t1016-compatObjectFormat.sh                      |   1 -
 t/t1020-subdirectory.sh                            |   1 -
 t/t1021-rerere-in-workdir.sh                       |   1 -
 t/t1022-read-tree-partial-clone.sh                 |   1 -
 t/t1050-large.sh                                   |   1 -
 t/t1051-large-conversion.sh                        |   1 -
 t/t1060-object-corruption.sh                       |   1 -
 t/t1090-sparse-checkout-scope.sh                   |   1 -
 t/t1091-sparse-checkout-builtin.sh                 |   1 -
 t/t1092-sparse-checkout-compatibility.sh           |   1 -
 t/t1100-commit-tree-options.sh                     |   1 -
 t/t1300-config.sh                                  |   1 -
 t/t1301-shared-repo.sh                             |   1 -
 t/t1302-repo-version.sh                            |   1 -
 t/t1303-wacky-config.sh                            |   1 -
 t/t1304-default-acl.sh                             |   1 -
 t/t1305-config-include.sh                          |   1 -
 t/t1306-xdg-files.sh                               |   1 -
 t/t1307-config-blob.sh                             |   1 -
 t/t1308-config-set.sh                              |   1 -
 t/t1309-early-config.sh                            |   1 -
 t/t1310-config-default.sh                          |   1 -
 t/t1350-config-hooks-path.sh                       |   1 -
 t/t1400-update-ref.sh                              |   1 -
 t/t1401-symbolic-ref.sh                            |   1 -
 t/t1402-check-ref-format.sh                        |   1 -
 t/t1403-show-ref.sh                                |   1 -
 t/t1404-update-ref-errors.sh                       |   1 -
 t/t1405-main-ref-store.sh                          |   1 -
 t/t1406-submodule-ref-store.sh                     |   1 -
 t/t1407-worktree-ref-store.sh                      |   1 -
 t/t1408-packed-refs.sh                             |   1 -
 t/t1409-avoid-packing-refs.sh                      |   1 -
 t/t1410-reflog.sh                                  |   1 -
 t/t1411-reflog-show.sh                             |   1 -
 t/t1412-reflog-loop.sh                             |   1 -
 t/t1413-reflog-detach.sh                           |   1 -
 t/t1414-reflog-walk.sh                             |   1 -
 t/t1415-worktree-refs.sh                           |   1 -
 t/t1416-ref-transaction-hooks.sh                   |   1 -
 t/t1417-reflog-updateref.sh                        |   1 -
 t/t1418-reflog-exists.sh                           |   1 -
 t/t1419-exclude-refs.sh                            |   1 -
 t/t1420-lost-found.sh                              |   1 -
 t/t1430-bad-ref-name.sh                            |   1 -
 t/t1450-fsck.sh                                    |   1 -
 t/t1451-fsck-buffer.sh                             |   1 -
 t/t1460-refs-migrate.sh                            |   1 -
 t/t1500-rev-parse.sh                               |   1 -
 t/t1501-work-tree.sh                               |   1 -
 t/t1502-rev-parse-parseopt.sh                      |   1 -
 t/t1503-rev-parse-verify.sh                        |   1 -
 t/t1504-ceiling-dirs.sh                            |   1 -
 t/t1505-rev-parse-last.sh                          |   1 -
 t/t1506-rev-parse-diagnosis.sh                     |   1 -
 t/t1507-rev-parse-upstream.sh                      |   1 -
 t/t1508-at-combinations.sh                         |   1 -
 t/t1510-repo-setup.sh                              |   1 -
 t/t1511-rev-parse-caret.sh                         |   1 -
 t/t1512-rev-parse-disambiguation.sh                |   1 -
 t/t1513-rev-parse-prefix.sh                        |   1 -
 t/t1514-rev-parse-push.sh                          |   1 -
 t/t1515-rev-parse-outside-repo.sh                  |   1 -
 t/t1517-outside-repo.sh                            |   1 -
 t/t1600-index.sh                                   |   1 -
 t/t1601-index-bogus.sh                             |   1 -
 t/t1701-racy-split-index.sh                        |   1 -
 t/t1800-hook.sh                                    |   1 -
 t/t2000-conflict-when-checking-files-out.sh        |   1 -
 t/t2002-checkout-cache-u.sh                        |   1 -
 t/t2003-checkout-cache-mkdir.sh                    |   1 -
 t/t2004-checkout-cache-temp.sh                     |   1 -
 t/t2005-checkout-index-symlinks.sh                 |   1 -
 t/t2006-checkout-index-basic.sh                    |   1 -
 t/t2007-checkout-symlink.sh                        |   1 -
 t/t2008-checkout-subdir.sh                         |   1 -
 t/t2009-checkout-statinfo.sh                       |   1 -
 t/t2010-checkout-ambiguous.sh                      |   1 -
 t/t2011-checkout-invalid-head.sh                   |   1 -
 t/t2012-checkout-last.sh                           |   1 -
 t/t2013-checkout-submodule.sh                      |   1 -
 t/t2014-checkout-switch.sh                         |   1 -
 t/t2015-checkout-unborn.sh                         |   1 -
 t/t2016-checkout-patch.sh                          |   1 -
 t/t2017-checkout-orphan.sh                         |   1 -
 t/t2018-checkout-branch.sh                         |   1 -
 t/t2019-checkout-ambiguous-ref.sh                  |   1 -
 t/t2020-checkout-detach.sh                         |   1 -
 t/t2021-checkout-overwrite.sh                      |   1 -
 t/t2022-checkout-paths.sh                          |   1 -
 t/t2023-checkout-m.sh                              |   1 -
 t/t2024-checkout-dwim.sh                           |   1 -
 t/t2025-checkout-no-overlay.sh                     |   1 -
 t/t2026-checkout-pathspec-file.sh                  |   1 -
 t/t2027-checkout-track.sh                          |   1 -
 t/t2030-unresolve-info.sh                          |   1 -
 t/t2050-git-dir-relative.sh                        |   1 -
 t/t2060-switch.sh                                  |   1 -
 t/t2070-restore.sh                                 |   1 -
 t/t2071-restore-patch.sh                           |   1 -
 t/t2072-restore-pathspec-file.sh                   |   1 -
 t/t2080-parallel-checkout-basics.sh                |   1 -
 t/t2081-parallel-checkout-collisions.sh            |   1 -
 t/t2082-parallel-checkout-attributes.sh            |   1 -
 t/t2100-update-cache-badpath.sh                    |   1 -
 t/t2101-update-index-reupdate.sh                   |   1 -
 t/t2102-update-index-symlinks.sh                   |   1 -
 t/t2103-update-index-ignore-missing.sh             |   1 -
 t/t2104-update-index-skip-worktree.sh              |   1 -
 t/t2105-update-index-gitfile.sh                    |   1 -
 t/t2106-update-index-assume-unchanged.sh           |   1 -
 t/t2107-update-index-basic.sh                      |   1 -
 t/t2108-update-index-refresh-racy.sh               |   1 -
 t/t2200-add-update.sh                              |   1 -
 t/t2201-add-update-typechange.sh                   |   1 -
 t/t2202-add-addremove.sh                           |   1 -
 t/t2203-add-intent.sh                              |   1 -
 t/t2204-add-ignored.sh                             |   1 -
 t/t2205-add-worktree-config.sh                     |   1 -
 t/t2300-cd-to-toplevel.sh                          |   1 -
 t/t2400-worktree-add.sh                            |   1 -
 t/t2401-worktree-prune.sh                          |   1 -
 t/t2402-worktree-list.sh                           |   1 -
 t/t2403-worktree-move.sh                           |   1 -
 t/t2404-worktree-config.sh                         |   1 -
 t/t2405-worktree-submodule.sh                      |   1 -
 t/t2406-worktree-repair.sh                         |   1 -
 t/t2407-worktree-heads.sh                          |  17 ++-
 t/t2408-worktree-relative.sh                       |   1 -
 t/t2500-untracked-overwriting.sh                   |   1 -
 t/t2501-cwd-empty.sh                               |   1 -
 t/t3000-ls-files-others.sh                         |   1 -
 t/t3001-ls-files-others-exclude.sh                 |   1 -
 t/t3002-ls-files-dashpath.sh                       |   1 -
 t/t3003-ls-files-exclude.sh                        |   1 -
 t/t3004-ls-files-basic.sh                          |   1 -
 t/t3005-ls-files-relative.sh                       |   1 -
 t/t3006-ls-files-long.sh                           |   1 -
 t/t3007-ls-files-recurse-submodules.sh             |   1 -
 t/t3008-ls-files-lazy-init-name-hash.sh            |   1 -
 t/t3009-ls-files-others-nonsubmodule.sh            |   1 -
 t/t3010-ls-files-killed-modified.sh                |   1 -
 t/t3011-common-prefixes-and-directory-traversal.sh |   1 -
 t/t3012-ls-files-dedup.sh                          |   1 -
 t/t3013-ls-files-format.sh                         |   1 -
 t/t3020-ls-files-error-unmatch.sh                  |   1 -
 t/t3040-subprojects-basic.sh                       |   1 -
 t/t3050-subprojects-fetch.sh                       |   1 -
 t/t3060-ls-files-with-tree.sh                      |   1 -
 t/t3070-wildmatch.sh                               |   1 -
 t/t3100-ls-tree-restrict.sh                        |   1 -
 t/t3101-ls-tree-dirname.sh                         |   1 -
 t/t3102-ls-tree-wildcards.sh                       |   1 -
 t/t3103-ls-tree-misc.sh                            |   1 -
 t/t3104-ls-tree-format.sh                          |   1 -
 t/t3105-ls-tree-output.sh                          |   1 -
 t/t3200-branch.sh                                  |   1 -
 t/t3201-branch-contains.sh                         |   1 -
 t/t3202-show-branch.sh                             |   1 -
 t/t3203-branch-output.sh                           |   1 -
 t/t3204-branch-name-interpretation.sh              |   1 -
 t/t3205-branch-color.sh                            |   1 -
 t/t3206-range-diff.sh                              |   1 -
 t/t3207-branch-submodule.sh                        |   1 -
 t/t3211-peel-ref.sh                                |   1 -
 t/t3300-funny-names.sh                             |   1 -
 t/t3301-notes.sh                                   |   1 -
 t/t3302-notes-index-expensive.sh                   |   1 -
 t/t3303-notes-subtrees.sh                          |   1 -
 t/t3304-notes-mixed.sh                             |   1 -
 t/t3305-notes-fanout.sh                            |   1 -
 t/t3306-notes-prune.sh                             |   1 -
 t/t3307-notes-man.sh                               |   1 -
 t/t3308-notes-merge.sh                             |   1 -
 t/t3309-notes-merge-auto-resolve.sh                |   1 -
 t/t3310-notes-merge-manual-resolve.sh              |   1 -
 t/t3311-notes-merge-fanout.sh                      |   1 -
 t/t3320-notes-merge-worktrees.sh                   |   1 -
 t/t3321-notes-stripspace.sh                        |   1 -
 t/t3400-rebase.sh                                  |   1 -
 t/t3401-rebase-and-am-rename.sh                    |   1 -
 t/t3402-rebase-merge.sh                            |   1 -
 t/t3403-rebase-skip.sh                             |   1 -
 t/t3404-rebase-interactive.sh                      |   1 -
 t/t3405-rebase-malformed.sh                        |   1 -
 t/t3406-rebase-message.sh                          |   1 -
 t/t3407-rebase-abort.sh                            |   1 -
 t/t3408-rebase-multi-line.sh                       |   1 -
 t/t3409-rebase-environ.sh                          |   1 -
 t/t3412-rebase-root.sh                             |   1 -
 t/t3413-rebase-hook.sh                             |   1 -
 t/t3415-rebase-autosquash.sh                       |   1 -
 t/t3416-rebase-onto-threedots.sh                   |   1 -
 t/t3417-rebase-whitespace-fix.sh                   |   1 -
 t/t3418-rebase-continue.sh                         |   1 -
 t/t3419-rebase-patch-id.sh                         |   1 -
 t/t3420-rebase-autostash.sh                        |   1 -
 t/t3421-rebase-topology-linear.sh                  |   1 -
 t/t3422-rebase-incompatible-options.sh             |   1 -
 t/t3423-rebase-reword.sh                           |   1 -
 t/t3424-rebase-empty.sh                            |   1 -
 t/t3425-rebase-topology-merges.sh                  |   1 -
 t/t3426-rebase-submodule.sh                        |   1 -
 t/t3427-rebase-subtree.sh                          |   1 -
 t/t3428-rebase-signoff.sh                          |   1 -
 t/t3429-rebase-edit-todo.sh                        |   1 -
 t/t3430-rebase-merges.sh                           |   1 -
 t/t3431-rebase-fork-point.sh                       |   1 -
 t/t3432-rebase-fast-forward.sh                     |   1 -
 t/t3433-rebase-across-mode-change.sh               |   1 -
 t/t3434-rebase-i18n.sh                             |   1 -
 t/t3435-rebase-gpg-sign.sh                         |   1 -
 t/t3436-rebase-more-options.sh                     |   1 -
 t/t3437-rebase-fixup-options.sh                    |   1 -
 t/t3438-rebase-broken-files.sh                     |   1 -
 t/t3500-cherry.sh                                  |   1 -
 t/t3501-revert-cherry-pick.sh                      |   1 -
 t/t3502-cherry-pick-merge.sh                       |   1 -
 t/t3503-cherry-pick-root.sh                        |   1 -
 t/t3504-cherry-pick-rerere.sh                      |   1 -
 t/t3505-cherry-pick-empty.sh                       |   1 -
 t/t3506-cherry-pick-ff.sh                          |   1 -
 t/t3507-cherry-pick-conflict.sh                    |   1 -
 t/t3508-cherry-pick-many-commits.sh                |   1 -
 t/t3509-cherry-pick-merge-df.sh                    |   1 -
 t/t3510-cherry-pick-sequence.sh                    |   1 -
 t/t3511-cherry-pick-x.sh                           |   1 -
 t/t3512-cherry-pick-submodule.sh                   |   1 -
 t/t3513-revert-submodule.sh                        |   1 -
 t/t3514-cherry-pick-revert-gpg.sh                  |   1 -
 t/t3600-rm.sh                                      |   1 -
 t/t3601-rm-pathspec-file.sh                        |   1 -
 t/t3602-rm-sparse-checkout.sh                      |   1 -
 t/t3650-replay-basics.sh                           |   1 -
 t/t3700-add.sh                                     |   1 -
 t/t3701-add-interactive.sh                         |   1 -
 t/t3702-add-edit.sh                                |   1 -
 t/t3703-add-magic-pathspec.sh                      |   1 -
 t/t3704-add-pathspec-file.sh                       |   1 -
 t/t3705-add-sparse-checkout.sh                     |   1 -
 t/t3800-mktag.sh                                   |   1 -
 t/t3900-i18n-commit.sh                             |   1 -
 t/t3901-i18n-patch.sh                              |   1 -
 t/t3902-quoted.sh                                  |   1 -
 t/t3903-stash.sh                                   |   1 -
 t/t3904-stash-patch.sh                             |   1 -
 t/t3905-stash-include-untracked.sh                 |   1 -
 t/t3906-stash-submodule.sh                         |   1 -
 t/t3907-stash-show-config.sh                       |   1 -
 t/t3908-stash-in-worktree.sh                       |   1 -
 t/t3909-stash-pathspec-file.sh                     |   1 -
 t/t3920-crlf-messages.sh                           |   1 -
 t/t4000-diff-format.sh                             |   1 -
 t/t4001-diff-rename.sh                             |   1 -
 t/t4002-diff-basic.sh                              |   1 -
 t/t4003-diff-rename-1.sh                           |   1 -
 t/t4004-diff-rename-symlink.sh                     |   1 -
 t/t4005-diff-rename-2.sh                           |   1 -
 t/t4006-diff-mode.sh                               |   1 -
 t/t4007-rename-3.sh                                |   1 -
 t/t4008-diff-break-rewrite.sh                      |   1 -
 t/t4009-diff-rename-4.sh                           |   1 -
 t/t4010-diff-pathspec.sh                           |   1 -
 t/t4011-diff-symlink.sh                            |   1 -
 t/t4012-diff-binary.sh                             |   1 -
 t/t4013-diff-various.sh                            |   1 -
 t/t4014-format-patch.sh                            |   1 -
 t/t4015-diff-whitespace.sh                         |   1 -
 t/t4016-diff-quote.sh                              |   1 -
 t/t4017-diff-retval.sh                             |   1 -
 t/t4018-diff-funcname.sh                           |   1 -
 t/t4019-diff-wserror.sh                            |   1 -
 t/t4020-diff-external.sh                           |   5 +-
 t/t4021-format-patch-numbered.sh                   |   1 -
 t/t4022-diff-rewrite.sh                            |   1 -
 t/t4023-diff-rename-typechange.sh                  |   1 -
 t/t4024-diff-optimize-common.sh                    |   1 -
 t/t4025-hunk-header.sh                             |   1 -
 t/t4026-color.sh                                   |   1 -
 t/t4027-diff-submodule.sh                          |   1 -
 t/t4028-format-patch-mime-headers.sh               |   1 -
 t/t4029-diff-trailing-space.sh                     |   1 -
 t/t4030-diff-textconv.sh                           |   1 -
 t/t4031-diff-rewrite-binary.sh                     |   1 -
 t/t4032-diff-inter-hunk-context.sh                 |   1 -
 t/t4033-diff-patience.sh                           |   1 -
 t/t4034-diff-words.sh                              |   1 -
 t/t4035-diff-quiet.sh                              |   1 -
 t/t4036-format-patch-signer-mime.sh                |   1 -
 t/t4037-diff-r-t-dirs.sh                           |   1 -
 t/t4038-diff-combined.sh                           |   1 -
 t/t4039-diff-assume-unchanged.sh                   |   1 -
 t/t4040-whitespace-status.sh                       |   1 -
 t/t4041-diff-submodule-option.sh                   |   1 -
 t/t4042-diff-textconv-caching.sh                   |   1 -
 t/t4043-diff-rename-binary.sh                      |   1 -
 t/t4044-diff-index-unique-abbrev.sh                |   1 -
 t/t4045-diff-relative.sh                           |   1 -
 t/t4046-diff-unmerged.sh                           |   1 -
 t/t4047-diff-dirstat.sh                            |   1 -
 t/t4048-diff-combined-binary.sh                    |   1 -
 t/t4049-diff-stat-count.sh                         |   1 -
 t/t4050-diff-histogram.sh                          |   1 -
 t/t4051-diff-function-context.sh                   |   1 -
 t/t4052-stat-output.sh                             |   1 -
 t/t4053-diff-no-index.sh                           |   1 -
 t/t4054-diff-bogus-tree.sh                         |   1 -
 t/t4055-diff-context.sh                            |   1 -
 t/t4056-diff-order.sh                              |   1 -
 t/t4057-diff-combined-paths.sh                     |   1 -
 t/t4058-diff-duplicates.sh                         |   1 -
 t/t4059-diff-submodule-not-initialized.sh          |   1 -
 t/t4060-diff-submodule-option-diff-format.sh       |   1 -
 t/t4061-diff-indent.sh                             |   1 -
 t/t4062-diff-pickaxe.sh                            |   1 -
 t/t4063-diff-blobs.sh                              |   1 -
 t/t4064-diff-oidfind.sh                            |   1 -
 t/t4065-diff-anchored.sh                           |   1 -
 t/t4066-diff-emit-delay.sh                         |   1 -
 t/t4067-diff-partial-clone.sh                      |   1 -
 t/t4068-diff-symmetric-merge-base.sh               |   1 -
 t/t4069-remerge-diff.sh                            |   1 -
 t/t4100-apply-stat.sh                              |   1 -
 t/t4101-apply-nonl.sh                              |   1 -
 t/t4102-apply-rename.sh                            |   1 -
 t/t4103-apply-binary.sh                            |   1 -
 t/t4104-apply-boundary.sh                          |   1 -
 t/t4105-apply-fuzz.sh                              |   1 -
 t/t4106-apply-stdin.sh                             |   1 -
 t/t4107-apply-ignore-whitespace.sh                 |   1 -
 t/t4108-apply-threeway.sh                          |   1 -
 t/t4109-apply-multifrag.sh                         |   1 -
 t/t4110-apply-scan.sh                              |   1 -
 t/t4111-apply-subdir.sh                            |   1 -
 t/t4112-apply-renames.sh                           |   1 -
 t/t4113-apply-ending.sh                            |   1 -
 t/t4114-apply-typechange.sh                        |   1 -
 t/t4115-apply-symlink.sh                           |   1 -
 t/t4116-apply-reverse.sh                           |   1 -
 t/t4117-apply-reject.sh                            |   1 -
 t/t4118-apply-empty-context.sh                     |   1 -
 t/t4119-apply-config.sh                            |   1 -
 t/t4120-apply-popt.sh                              |   1 -
 t/t4121-apply-diffs.sh                             |   1 -
 t/t4122-apply-symlink-inside.sh                    |   1 -
 t/t4123-apply-shrink.sh                            |   1 -
 t/t4124-apply-ws-rule.sh                           |   1 -
 t/t4125-apply-ws-fuzz.sh                           |   1 -
 t/t4126-apply-empty.sh                             |   1 -
 t/t4127-apply-same-fn.sh                           |   1 -
 t/t4128-apply-root.sh                              |   1 -
 t/t4129-apply-samemode.sh                          |   1 -
 t/t4130-apply-criss-cross-rename.sh                |   1 -
 t/t4131-apply-fake-ancestor.sh                     |   1 -
 t/t4132-apply-removal.sh                           |   1 -
 t/t4133-apply-filenames.sh                         |   1 -
 t/t4134-apply-submodule.sh                         |   1 -
 t/t4135-apply-weird-filenames.sh                   |   1 -
 t/t4136-apply-check.sh                             |   1 -
 t/t4137-apply-submodule.sh                         |   1 -
 t/t4138-apply-ws-expansion.sh                      |   1 -
 t/t4139-apply-escape.sh                            |   1 -
 t/t4140-apply-ita.sh                               |   1 -
 t/t4141-apply-too-large.sh                         |   1 -
 t/t4150-am.sh                                      |   1 -
 t/t4151-am-abort.sh                                |   1 -
 t/t4152-am-subjects.sh                             |   1 -
 t/t4153-am-resume-override-opts.sh                 |   1 -
 t/t4200-rerere.sh                                  |   1 -
 t/t4201-shortlog.sh                                |   1 -
 t/t4202-log.sh                                     |   1 -
 t/t4203-mailmap.sh                                 |   1 -
 t/t4204-patch-id.sh                                |   1 -
 t/t4205-log-pretty-formats.sh                      |   1 -
 t/t4206-log-follow-harder-copies.sh                |   1 -
 t/t4207-log-decoration-colors.sh                   |   1 -
 t/t4208-log-magic-pathspec.sh                      |   1 -
 t/t4209-log-pickaxe.sh                             |   1 -
 t/t4210-log-i18n.sh                                |   1 -
 t/t4212-log-corrupt.sh                             |   1 -
 t/t4213-log-tabexpand.sh                           |   1 -
 t/t4214-log-graph-octopus.sh                       |   1 -
 t/t4215-log-skewed-merges.sh                       |   1 -
 t/t4216-log-bloom.sh                               |   1 -
 t/t4217-log-limit.sh                               |   1 -
 t/t4252-am-options.sh                              |   1 -
 t/t4253-am-keep-cr-dos.sh                          |   1 -
 t/t4254-am-corrupt.sh                              |   1 -
 t/t4255-am-submodule.sh                            |   1 -
 t/t4256-am-format-flowed.sh                        |   1 -
 t/t4257-am-interactive.sh                          |   1 -
 t/t4258-am-quoted-cr.sh                            |   1 -
 t/t4300-merge-tree.sh                              |   1 -
 t/t4301-merge-tree-write-tree.sh                   |   1 -
 t/t5000-tar-tree.sh                                |   1 -
 t/t5001-archive-attr.sh                            |   1 -
 t/t5002-archive-attr-pattern.sh                    |   1 -
 t/t5003-archive-zip.sh                             |   1 -
 t/t5004-archive-corner-cases.sh                    |   1 -
 t/t5100-mailinfo.sh                                |   1 -
 t/t5150-request-pull.sh                            |   1 -
 t/t5200-update-server-info.sh                      |   1 -
 t/t5300-pack-object.sh                             |   1 -
 t/t5301-sliding-window.sh                          |   1 -
 t/t5302-pack-index.sh                              |   1 -
 t/t5303-pack-corruption-resilience.sh              |   1 -
 t/t5304-prune.sh                                   |   1 -
 t/t5305-include-tag.sh                             |   1 -
 t/t5306-pack-nobase.sh                             |   1 -
 t/t5307-pack-missing-commit.sh                     |   1 -
 t/t5308-pack-detect-duplicates.sh                  |   1 -
 t/t5309-pack-delta-cycles.sh                       |   1 -
 t/t5310-pack-bitmaps.sh                            |   1 -
 t/t5311-pack-bitmaps-shallow.sh                    |   1 -
 t/t5312-prune-corruption.sh                        |   1 -
 t/t5313-pack-bounds-checks.sh                      |   1 -
 t/t5314-pack-cycle-detection.sh                    |   1 -
 t/t5315-pack-objects-compression.sh                |   1 -
 t/t5316-pack-delta-depth.sh                        |   1 -
 t/t5317-pack-objects-filter-objects.sh             |   1 -
 t/t5318-commit-graph.sh                            |   1 -
 t/t5319-multi-pack-index.sh                        |   1 -
 t/t5320-delta-islands.sh                           |   1 -
 t/t5321-pack-large-objects.sh                      |   1 -
 t/t5322-pack-objects-sparse.sh                     |   1 -
 t/t5323-pack-redundant.sh                          |   1 -
 t/t5324-split-commit-graph.sh                      |   1 -
 t/t5325-reverse-index.sh                           |   1 -
 t/t5326-multi-pack-bitmaps.sh                      |   1 -
 t/t5327-multi-pack-bitmaps-rev.sh                  |   1 -
 t/t5328-commit-graph-64bit-time.sh                 |   1 -
 t/t5329-pack-objects-cruft.sh                      |   1 -
 t/t5330-no-lazy-fetch-with-commit-graph.sh         |   1 -
 t/t5331-pack-objects-stdin.sh                      |   1 -
 t/t5332-multi-pack-reuse.sh                        |   1 -
 t/t5333-pseudo-merge-bitmaps.sh                    |   1 -
 t/t5334-incremental-multi-pack-index.sh            |   1 -
 t/t5351-unpack-large-objects.sh                    |   1 -
 t/t5400-send-pack.sh                               |   1 -
 t/t5401-update-hooks.sh                            |   1 -
 t/t5402-post-merge-hook.sh                         |   1 -
 t/t5403-post-checkout-hook.sh                      |   1 -
 t/t5404-tracking-branches.sh                       |   1 -
 t/t5405-send-pack-rewind.sh                        |   1 -
 t/t5406-remote-rejects.sh                          |   1 -
 t/t5407-post-rewrite-hook.sh                       |   1 -
 t/t5408-send-pack-stdin.sh                         |   1 -
 t/t5409-colorize-remote-messages.sh                |   1 -
 t/t5410-receive-pack-alternates.sh                 |   1 -
 t/t5411-proc-receive-hook.sh                       |   1 -
 t/t5500-fetch-pack.sh                              |   1 -
 t/t5501-fetch-push-alternates.sh                   |   1 -
 t/t5502-quickfetch.sh                              |   1 -
 t/t5503-tagfollow.sh                               |   1 -
 t/t5504-fetch-receive-strict.sh                    |   1 -
 t/t5505-remote.sh                                  |   1 -
 t/t5506-remote-groups.sh                           |   1 -
 t/t5507-remote-environment.sh                      |   1 -
 t/t5509-fetch-push-namespaces.sh                   |   1 -
 t/t5510-fetch.sh                                   |   1 -
 t/t5511-refspec.sh                                 |   1 -
 t/t5512-ls-remote.sh                               |   1 -
 t/t5513-fetch-track.sh                             |   1 -
 t/t5514-fetch-multiple.sh                          |   1 -
 t/t5515-fetch-merge-logic.sh                       |   1 -
 t/t5516-fetch-push.sh                              |   1 -
 t/t5517-push-mirror.sh                             |   1 -
 t/t5518-fetch-exit-status.sh                       |   1 -
 t/t5519-push-alternates.sh                         |   1 -
 t/t5520-pull.sh                                    |   1 -
 t/t5521-pull-options.sh                            |   1 -
 t/t5522-pull-symlink.sh                            |   1 -
 t/t5523-push-upstream.sh                           |   1 -
 t/t5524-pull-msg.sh                                |   1 -
 t/t5525-fetch-tagopt.sh                            |   1 -
 t/t5526-fetch-submodules.sh                        |   1 -
 t/t5527-fetch-odd-refs.sh                          |   1 -
 t/t5528-push-default.sh                            |   1 -
 t/t5529-push-errors.sh                             |   1 -
 t/t5530-upload-pack-error.sh                       |   1 -
 t/t5531-deep-submodule-push.sh                     |   1 -
 t/t5532-fetch-proxy.sh                             |   1 -
 t/t5533-push-cas.sh                                |   1 -
 t/t5534-push-signed.sh                             |   1 -
 t/t5535-fetch-push-symref.sh                       |   1 -
 t/t5536-fetch-conflicts.sh                         |   1 -
 t/t5537-fetch-shallow.sh                           |   1 -
 t/t5538-push-shallow.sh                            |   1 -
 t/t5539-fetch-http-shallow.sh                      |   1 -
 t/t5540-http-push-webdav.sh                        |   1 -
 t/t5541-http-push-smart.sh                         |   1 -
 t/t5542-push-http-shallow.sh                       |   1 -
 t/t5543-atomic-push.sh                             |   1 -
 t/t5544-pack-objects-hook.sh                       |   1 -
 t/t5545-push-options.sh                            |   1 -
 t/t5546-receive-limits.sh                          |   1 -
 t/t5547-push-quarantine.sh                         |   1 -
 t/t5548-push-porcelain.sh                          |   1 -
 t/t5549-fetch-push-http.sh                         |   1 -
 t/t5550-http-fetch-dumb.sh                         |   1 -
 t/t5551-http-fetch-smart.sh                        |   1 -
 t/t5552-skipping-fetch-negotiator.sh               |   1 -
 t/t5553-set-upstream.sh                            |   1 -
 t/t5554-noop-fetch-negotiator.sh                   |   1 -
 t/t5555-http-smart-common.sh                       |   1 -
 t/t5557-http-get.sh                                |   1 -
 t/t5560-http-backend-noserver.sh                   |   1 -
 t/t5561-http-backend.sh                            |   1 -
 t/t5562-http-backend-content-length.sh             |   1 -
 t/t5563-simple-http-auth.sh                        |   1 -
 t/t5564-http-proxy.sh                              |   1 -
 t/t5570-git-daemon.sh                              |   1 -
 t/t5571-pre-push-hook.sh                           |   1 -
 t/t5572-pull-submodule.sh                          |   1 -
 t/t5573-pull-verify-signatures.sh                  |   1 -
 t/t5574-fetch-output.sh                            |   1 -
 t/t5580-unc-paths.sh                               |   1 -
 t/t5581-http-curl-verbose.sh                       |   1 -
 t/t5582-fetch-negative-refspec.sh                  |   1 -
 t/t5583-push-branches.sh                           |   1 -
 t/t5600-clone-fail-cleanup.sh                      |   1 -
 t/t5601-clone.sh                                   |  26 +++--
 t/t5602-clone-remote-exec.sh                       |   1 -
 t/t5603-clone-dirname.sh                           |   1 -
 t/t5604-clone-reference.sh                         |   1 -
 t/t5605-clone-local.sh                             |   1 -
 t/t5606-clone-options.sh                           |   1 -
 t/t5607-clone-bundle.sh                            |   1 -
 t/t5609-clone-branch.sh                            |   1 -
 t/t5610-clone-detached.sh                          |   1 -
 t/t5611-clone-config.sh                            |   1 -
 t/t5612-clone-refspec.sh                           |   1 -
 t/t5613-info-alternate.sh                          |   1 -
 t/t5614-clone-submodules-shallow.sh                |   1 -
 t/t5615-alternate-env.sh                           |   1 -
 t/t5616-partial-clone.sh                           |   1 -
 t/t5617-clone-submodules-remote.sh                 |   1 -
 t/t5618-alternate-refs.sh                          |   1 -
 t/t5619-clone-local-ambiguous-transport.sh         |   1 -
 t/t5700-protocol-v1.sh                             |   1 -
 t/t5701-git-serve.sh                               |   1 -
 t/t5702-protocol-v2.sh                             |   1 -
 t/t5703-upload-pack-ref-in-want.sh                 |   1 -
 t/t5704-protocol-violations.sh                     |   1 -
 t/t5705-session-id-in-capabilities.sh              |   1 -
 t/t5730-protocol-v2-bundle-uri-file.sh             |   1 -
 t/t5731-protocol-v2-bundle-uri-git.sh              |   1 -
 t/t5732-protocol-v2-bundle-uri-http.sh             |   1 -
 t/t5750-bundle-uri-parse.sh                        |   1 -
 t/t5801-remote-helpers.sh                          |   1 -
 t/t5802-connect-helper.sh                          |   1 -
 t/t5810-proto-disable-local.sh                     |   1 -
 t/t5811-proto-disable-git.sh                       |   1 -
 t/t5812-proto-disable-http.sh                      |   1 -
 t/t5813-proto-disable-ssh.sh                       |   1 -
 t/t5814-proto-disable-ext.sh                       |   1 -
 t/t5815-submodule-protos.sh                        |   1 -
 t/t5900-repo-selection.sh                          |   1 -
 t/t6000-rev-list-misc.sh                           |   1 -
 t/t6001-rev-list-graft.sh                          |   1 -
 t/t6002-rev-list-bisect.sh                         |   1 -
 t/t6003-rev-list-topo-order.sh                     |   1 -
 t/t6004-rev-list-path-optim.sh                     |   1 -
 t/t6005-rev-list-count.sh                          |   1 -
 t/t6006-rev-list-format.sh                         |   1 -
 t/t6007-rev-list-cherry-pick-file.sh               |   1 -
 t/t6008-rev-list-submodule.sh                      |   1 -
 t/t6009-rev-list-parent.sh                         |   1 -
 t/t6010-merge-base.sh                              |   1 -
 t/t6011-rev-list-with-bad-commit.sh                |   1 -
 t/t6012-rev-list-simplify.sh                       |   1 -
 t/t6013-rev-list-reverse-parents.sh                |   1 -
 t/t6014-rev-list-all.sh                            |   1 -
 t/t6016-rev-list-graph-simplify-history.sh         |   1 -
 t/t6017-rev-list-stdin.sh                          |   1 -
 t/t6018-rev-list-glob.sh                           |   1 -
 t/t6019-rev-list-ancestry-path.sh                  |   1 -
 t/t6020-bundle-misc.sh                             |   1 -
 t/t6021-rev-list-exclude-hidden.sh                 |   1 -
 t/t6022-rev-list-missing.sh                        |   1 -
 t/t6040-tracking-info.sh                           |   1 -
 t/t6041-bisect-submodule.sh                        |   1 -
 t/t6050-replace.sh                                 |   1 -
 t/t6060-merge-index.sh                             |   1 -
 t/t6100-rev-list-in-order.sh                       |   1 -
 t/t6101-rev-parse-parents.sh                       |   1 -
 t/t6102-rev-list-unexpected-objects.sh             |   1 -
 t/t6110-rev-list-sparse.sh                         |   1 -
 t/t6111-rev-list-treesame.sh                       |   1 -
 t/t6112-rev-list-filters-objects.sh                |   1 -
 t/t6113-rev-list-bitmap-filters.sh                 |   1 -
 t/t6114-keep-packs.sh                              |   1 -
 t/t6115-rev-list-du.sh                             |   1 -
 t/t6120-describe.sh                                |   1 -
 t/t6130-pathspec-noglob.sh                         |   1 -
 t/t6131-pathspec-icase.sh                          |   1 -
 t/t6132-pathspec-exclude.sh                        |   1 -
 t/t6133-pathspec-rev-dwim.sh                       |   1 -
 t/t6134-pathspec-in-submodule.sh                   |   1 -
 t/t6135-pathspec-with-attrs.sh                     |   1 -
 t/t6136-pathspec-in-bare.sh                        |   1 -
 t/t6200-fmt-merge-msg.sh                           |   1 -
 t/t6300-for-each-ref.sh                            |   1 -
 t/t6301-for-each-ref-errors.sh                     |   1 -
 t/t6302-for-each-ref-filter.sh                     |   1 -
 t/t6400-merge-df.sh                                |   1 -
 t/t6401-merge-criss-cross.sh                       |   1 -
 t/t6402-merge-rename.sh                            |   1 -
 t/t6403-merge-file.sh                              |   1 -
 t/t6404-recursive-merge.sh                         |   1 -
 t/t6405-merge-symlinks.sh                          |   1 -
 t/t6406-merge-attr.sh                              |   1 -
 t/t6407-merge-binary.sh                            |   1 -
 t/t6408-merge-up-to-date.sh                        |   1 -
 t/t6409-merge-subtree.sh                           |   1 -
 t/t6411-merge-filemode.sh                          |   1 -
 t/t6412-merge-large-rename.sh                      |   1 -
 t/t6413-merge-crlf.sh                              |   1 -
 t/t6414-merge-rename-nocruft.sh                    |   1 -
 t/t6415-merge-dir-to-symlink.sh                    |   1 -
 t/t6416-recursive-corner-cases.sh                  |   1 -
 t/t6417-merge-ours-theirs.sh                       |   1 -
 t/t6418-merge-text-auto.sh                         |   1 -
 t/t6421-merge-partial-clone.sh                     |   1 -
 t/t6422-merge-rename-corner-cases.sh               |   1 -
 t/t6423-merge-rename-directories.sh                |   1 -
 t/t6424-merge-unrelated-index-changes.sh           |   1 -
 t/t6425-merge-rename-delete.sh                     |   1 -
 t/t6426-merge-skip-unneeded-updates.sh             |   1 -
 t/t6427-diff3-conflict-markers.sh                  |   1 -
 t/t6428-merge-conflicts-sparse.sh                  |   1 -
 t/t6429-merge-sequence-rename-caching.sh           |   1 -
 t/t6430-merge-recursive.sh                         |   1 -
 t/t6431-merge-criscross.sh                         |   1 -
 t/t6432-merge-recursive-space-options.sh           |   1 -
 t/t6433-merge-toplevel.sh                          |   1 -
 t/t6434-merge-recursive-rename-options.sh          |   1 -
 t/t6435-merge-sparse.sh                            |   1 -
 t/t6436-merge-overwrite.sh                         |   1 -
 t/t6437-submodule-merge.sh                         |   1 -
 t/t6438-submodule-directory-file-conflicts.sh      |   1 -
 t/t6439-merge-co-error-msgs.sh                     |   1 -
 t/t6500-gc.sh                                      |   1 -
 t/t6501-freshen-objects.sh                         |   1 -
 t/t6600-test-reach.sh                              |   1 -
 t/t6700-tree-depth.sh                              |   1 -
 t/t7001-mv.sh                                      |   1 -
 t/t7002-mv-sparse-checkout.sh                      |   1 -
 t/t7003-filter-branch.sh                           |   1 -
 t/t7004-tag.sh                                     |   1 -
 t/t7005-editor.sh                                  |   1 -
 t/t7006-pager.sh                                   |   1 -
 t/t7007-show.sh                                    |   1 -
 t/t7008-filter-branch-null-sha1.sh                 |   1 -
 t/t7010-setup.sh                                   |   1 -
 t/t7011-skip-worktree-reading.sh                   |   1 -
 t/t7012-skip-worktree-writing.sh                   |   1 -
 t/t7030-verify-tag.sh                              |   1 -
 t/t7031-verify-tag-signed-ssh.sh                   |   1 -
 t/t7060-wtstatus.sh                                |   1 -
 t/t7061-wtstatus-ignore.sh                         |   1 -
 t/t7062-wtstatus-ignorecase.sh                     |   1 -
 t/t7063-status-untracked-cache.sh                  |   1 -
 t/t7064-wtstatus-pv2.sh                            |   1 -
 t/t7101-reset-empty-subdirs.sh                     |   1 -
 t/t7102-reset.sh                                   |   1 -
 t/t7103-reset-bare.sh                              |   1 -
 t/t7104-reset-hard.sh                              |   1 -
 t/t7105-reset-patch.sh                             |   1 -
 t/t7106-reset-unborn-branch.sh                     |   1 -
 t/t7107-reset-pathspec-file.sh                     |   1 -
 t/t7110-reset-merge.sh                             |   1 -
 t/t7111-reset-table.sh                             |   1 -
 t/t7112-reset-submodule.sh                         |   1 -
 t/t7113-post-index-change-hook.sh                  |   1 -
 t/t7201-co.sh                                      |   1 -
 t/t7300-clean.sh                                   |   1 -
 t/t7301-clean-interactive.sh                       |   1 -
 t/t7400-submodule-basic.sh                         |   1 -
 t/t7401-submodule-summary.sh                       |   1 -
 t/t7402-submodule-rebase.sh                        |   1 -
 t/t7403-submodule-sync.sh                          |   1 -
 t/t7406-submodule-update.sh                        |   1 -
 t/t7407-submodule-foreach.sh                       |   1 -
 t/t7408-submodule-reference.sh                     |   1 -
 t/t7409-submodule-detached-work-tree.sh            |   1 -
 t/t7411-submodule-config.sh                        |   1 -
 t/t7412-submodule-absorbgitdirs.sh                 |   1 -
 t/t7413-submodule-is-active.sh                     |   1 -
 t/t7414-submodule-mistakes.sh                      |   1 -
 t/t7416-submodule-dash-url.sh                      |   1 -
 t/t7417-submodule-path-url.sh                      |   1 -
 t/t7418-submodule-sparse-gitmodules.sh             |   1 -
 t/t7419-submodule-set-branch.sh                    |   1 -
 t/t7420-submodule-set-url.sh                       |   1 -
 t/t7421-submodule-summary-add.sh                   |   1 -
 t/t7422-submodule-output.sh                        |   1 -
 t/t7423-submodule-symlinks.sh                      |   1 -
 t/t7424-submodule-mixed-ref-formats.sh             |   1 -
 t/t7450-bad-git-dotfiles.sh                        |   1 -
 t/t7500-commit-template-squash-signoff.sh          |   1 -
 t/t7501-commit-basic-functionality.sh              |   1 -
 t/t7502-commit-porcelain.sh                        |   1 -
 t/t7503-pre-commit-and-pre-merge-commit-hooks.sh   |   1 -
 t/t7504-commit-msg-hook.sh                         |   1 -
 t/t7505-prepare-commit-msg-hook.sh                 |   1 -
 t/t7506-status-submodule.sh                        |   1 -
 t/t7507-commit-verbose.sh                          |   1 -
 t/t7508-status.sh                                  |   1 -
 t/t7509-commit-authorship.sh                       |   1 -
 t/t7510-signed-commit.sh                           |   1 -
 t/t7511-status-index.sh                            |   1 -
 t/t7512-status-help.sh                             |   1 -
 t/t7513-interpret-trailers.sh                      |   1 -
 t/t7514-commit-patch.sh                            |   1 -
 t/t7515-status-symlinks.sh                         |   1 -
 t/t7516-commit-races.sh                            |   1 -
 t/t7517-per-repo-email.sh                          |   1 -
 t/t7518-ident-corner-cases.sh                      |   1 -
 t/t7519-status-fsmonitor.sh                        |   1 -
 t/t7520-ignored-hook-warning.sh                    |   1 -
 t/t7521-ignored-mode.sh                            |   1 -
 t/t7524-commit-summary.sh                          |   1 -
 t/t7525-status-rename.sh                           |   1 -
 t/t7526-commit-pathspec-file.sh                    |   1 -
 t/t7528-signed-commit-ssh.sh                       |   1 -
 t/t7600-merge.sh                                   |   1 -
 t/t7601-merge-pull-config.sh                       |   1 -
 t/t7602-merge-octopus-many.sh                      |   1 -
 t/t7603-merge-reduce-heads.sh                      |   1 -
 t/t7604-merge-custom-message.sh                    |   1 -
 t/t7605-merge-resolve.sh                           |   1 -
 t/t7606-merge-custom.sh                            |   1 -
 t/t7607-merge-state.sh                             |   1 -
 t/t7608-merge-messages.sh                          |   1 -
 t/t7609-mergetool--lib.sh                          |   1 -
 t/t7610-mergetool.sh                               |   1 -
 t/t7611-merge-abort.sh                             |   1 -
 t/t7612-merge-verify-signatures.sh                 |   1 -
 t/t7614-merge-signoff.sh                           |   1 -
 t/t7615-diff-algo-with-mergy-operations.sh         |   1 -
 t/t7700-repack.sh                                  |   1 -
 t/t7701-repack-unpack-unreachable.sh               |   1 -
 t/t7702-repack-cyclic-alternate.sh                 |   1 -
 t/t7703-repack-geometric.sh                        |   1 -
 t/t7704-repack-cruft.sh                            |   1 -
 t/t7800-difftool.sh                                |   1 -
 t/t7810-grep.sh                                    |   1 -
 t/t7811-grep-open.sh                               |   1 -
 t/t7812-grep-icase-non-ascii.sh                    |   1 -
 t/t7813-grep-icase-iso.sh                          |   1 -
 t/t7814-grep-recurse-submodules.sh                 |   1 -
 t/t7815-grep-binary.sh                             |   1 -
 t/t7816-grep-binary-pattern.sh                     |   1 -
 t/t7817-grep-sparse-checkout.sh                    |   1 -
 t/t7900-maintenance.sh                             |   1 -
 t/t8001-annotate.sh                                |   1 -
 t/t8002-blame.sh                                   |   1 -
 t/t8003-blame-corner-cases.sh                      |   1 -
 t/t8004-blame-with-conflicts.sh                    |   1 -
 t/t8005-blame-i18n.sh                              |   1 +
 t/t8006-blame-textconv.sh                          |   1 -
 t/t8007-cat-file-textconv.sh                       |   1 -
 t/t8008-blame-formats.sh                           |   1 -
 t/t8009-blame-vs-topicbranches.sh                  |   1 -
 t/t8010-cat-file-filters.sh                        |   1 -
 t/t8011-blame-split-file.sh                        |   1 -
 t/t8012-blame-colors.sh                            |   1 -
 t/t8013-blame-ignore-revs.sh                       |   1 -
 t/t8014-blame-ignore-fuzzy.sh                      |   1 -
 t/t9001-send-email.sh                              |   1 -
 t/t9002-column.sh                                  |   1 -
 t/t9003-help-autocorrect.sh                        |   1 -
 t/t9200-git-cvsexportcommit.sh                     |   1 -
 t/t9210-scalar.sh                                  |   1 -
 t/t9211-scalar-clone.sh                            |   1 -
 t/t9300-fast-import.sh                             |   1 -
 t/t9301-fast-import-notes.sh                       |   1 -
 t/t9302-fast-import-unpack-limit.sh                |   1 -
 t/t9303-fast-import-compression.sh                 |   1 -
 t/t9304-fast-import-marks.sh                       |   1 -
 t/t9350-fast-export.sh                             |   1 -
 t/t9351-fast-export-anonymize.sh                   |   1 -
 t/t9400-git-cvsserver-server.sh                    |   1 -
 t/t9401-git-cvsserver-crlf.sh                      |   1 -
 t/t9402-git-cvsserver-refs.sh                      |   1 -
 t/t9500-gitweb-standalone-no-errors.sh             |   1 -
 t/t9501-gitweb-standalone-http-status.sh           |   1 -
 t/t9502-gitweb-standalone-parse-output.sh          |   1 -
 t/t9600-cvsimport.sh                               |   1 -
 t/t9601-cvsimport-vendor-branch.sh                 |   1 -
 t/t9602-cvsimport-branches-tags.sh                 |   1 -
 t/t9603-cvsimport-patchsets.sh                     |   1 -
 t/t9604-cvsimport-timestamps.sh                    |   1 -
 t/t9700-perl-git.sh                                |   1 -
 t/t9800-git-p4-basic.sh                            |   1 -
 t/t9801-git-p4-branch.sh                           |   1 -
 t/t9802-git-p4-filetype.sh                         |   1 -
 t/t9803-git-p4-shell-metachars.sh                  |   1 -
 t/t9804-git-p4-label.sh                            |   1 -
 t/t9805-git-p4-skip-submit-edit.sh                 |   1 -
 t/t9806-git-p4-options.sh                          |   1 -
 t/t9808-git-p4-chdir.sh                            |   1 -
 t/t9809-git-p4-client-view.sh                      |   1 -
 t/t9810-git-p4-rcs.sh                              |   1 -
 t/t9811-git-p4-label-import.sh                     |   1 -
 t/t9812-git-p4-wildcards.sh                        |   1 -
 t/t9813-git-p4-preserve-users.sh                   |   1 -
 t/t9814-git-p4-rename.sh                           |   1 -
 t/t9815-git-p4-submit-fail.sh                      |   1 -
 t/t9816-git-p4-locked.sh                           |   1 -
 t/t9817-git-p4-exclude.sh                          |   1 -
 t/t9818-git-p4-block.sh                            |   1 -
 t/t9819-git-p4-case-folding.sh                     |   1 -
 t/t9820-git-p4-editor-handling.sh                  |   1 -
 t/t9821-git-p4-path-variations.sh                  |   1 -
 t/t9822-git-p4-path-encoding.sh                    |   1 -
 t/t9823-git-p4-mock-lfs.sh                         |   1 -
 t/t9825-git-p4-handle-utf16-without-bom.sh         |   1 -
 t/t9826-git-p4-keep-empty-commits.sh               |   1 -
 t/t9827-git-p4-change-filetype.sh                  |   1 -
 t/t9828-git-p4-map-user.sh                         |   1 -
 t/t9829-git-p4-jobs.sh                             |   1 -
 t/t9830-git-p4-symlink-dir.sh                      |   1 -
 t/t9831-git-p4-triggers.sh                         |   1 -
 t/t9832-unshelve.sh                                |   1 -
 t/t9833-errors.sh                                  |   1 -
 t/t9834-git-p4-file-dir-bug.sh                     |   1 -
 t/t9835-git-p4-metadata-encoding-python2.sh        |   1 -
 t/t9836-git-p4-metadata-encoding-python3.sh        |   1 -
 t/t9850-shell.sh                                   |   1 -
 t/t9901-git-web--browse.sh                         |   1 -
 t/t9902-completion.sh                              |   1 -
 t/t9903-bash-prompt.sh                             |   1 -
 t/test-lib.sh                                      |  72 +-----------
 t/unit-tests/strvec.c                              |  65 +++++++++++
 usage.c                                            |  15 ---
 950 files changed, 361 insertions(+), 1249 deletions(-)

Range-diff versus v2:

 1:  89f354b667 =  1:  08acbe8895 builtin/blame: fix leaking blame entries with `--incremental`
 2:  e50952aba3 =  2:  49269d747b bisect: fix leaking good/bad terms when reading multipe times
 3:  c38a4e15b8 =  3:  83cd85b609 bisect: fix leaking string in `handle_bad_merge_base()`
 4:  d2b48a08c2 =  4:  88a218045c bisect: fix leaking `current_bad_oid`
 5:  496421e0fe =  5:  1c1f77497f bisect: fix multiple leaks in `bisect_next_all()`
 6:  aeb9cacf64 =  6:  f02bbfde18 bisect: fix leaking commit list items in `check_merge_base()`
 7:  a8afd12467 !  7:  6e6d490b8a bisect: fix various cases where we leak commit list items
    @@ Commit message
     
      ## bisect.c ##
     @@ bisect.c: void find_bisection(struct commit_list **commit_list, int *reaches,
    - 			free_commit_list(list->next);
    - 			best = list;
      			best->next = NULL;
    -+		} else {
    -+			for (p = list; p != best; p = next) {
    -+				next = p->next;
    -+				free(p);
    -+			}
      		}
      		*reaches = weight(best);
     +	} else {
 8:  f503331f08 =  8:  13e2158c23 line-log: fix leak when rewriting commit parents
 9:  3edb9e0fe9 !  9:  3a9b0fa44a strvec: introduce new `strvec_splice()` function
    @@ strvec.c: void strvec_pushv(struct strvec *array, const char **items)
      		strvec_push(array, *items);
      }
      
    -+void strvec_splice(struct strvec *array, size_t pos, size_t len,
    ++void strvec_splice(struct strvec *array, size_t idx, size_t len,
     +		   const char **replacement, size_t replacement_len)
     +{
    -+	if (pos + len > array->alloc)
    ++	if (idx + len > array->nr)
     +		BUG("range outside of array boundary");
     +	if (replacement_len > len)
     +		ALLOC_GROW(array->v, array->nr + (replacement_len - len) + 1,
     +			   array->alloc);
     +	for (size_t i = 0; i < len; i++)
    -+		free((char *)array->v[pos + i]);
    ++		free((char *)array->v[idx + i]);
     +	if (replacement_len != len) {
    -+		memmove(array->v + pos + replacement_len, array->v + pos + len,
    -+			(array->nr - pos - len + 1) * sizeof(char *));
    ++		memmove(array->v + idx + replacement_len, array->v + idx + len,
    ++			(array->nr - idx - len + 1) * sizeof(char *));
     +		array->nr += (replacement_len - len);
     +	}
     +	for (size_t i = 0; i < replacement_len; i++)
    -+		array->v[pos + i] = xstrdup(replacement[i]);
    ++		array->v[idx + i] = xstrdup(replacement[i]);
     +}
     +
      const char *strvec_replace(struct strvec *array, size_t idx, const char *replacement)
    @@ strvec.h: void strvec_pushl(struct strvec *, ...);
      void strvec_pushv(struct strvec *, const char **);
      
     +/*
    -+ * Replace `len` values starting at `pos` with the provided replacement
    -+ * strings. If `len` is zero this is effectively an insert at the given `pos`.
    ++ * Replace `len` values starting at `idx` with the provided replacement
    ++ * strings. If `len` is zero this is effectively an insert at the given `idx`.
     + * If `replacement_len` is zero this is effectively a delete of `len` items
    -+ * starting at `pos`.
    ++ * starting at `idx`.
     + */
    -+void strvec_splice(struct strvec *array, size_t pos, size_t len,
    ++void strvec_splice(struct strvec *array, size_t idx, size_t len,
     +		   const char **replacement, size_t replacement_len);
     +
      /**
10:  f4c5b4b029 = 10:  0e30d61ee3 git: refactor alias handling to use a `struct strvec`
11:  a30376077d = 11:  9dc3f5da99 git: refactor builtin handling to use a `struct strvec`
12:  6fc481018e = 12:  6a7bb2d4ec split-index: fix memory leak in `move_cache_to_base_index()`
13:  011ee82856 = 13:  5147a45e70 builtin/sparse-checkout: fix leaking sanitized patterns
14:  41c6aa41ba = 14:  1e1f0025e2 help: refactor to not use globals for reading config
15:  d2b9042512 = 15:  92fb58121b help: fix leaking `struct cmdnames`
16:  75228ba160 = 16:  a8f1cb44f8 help: fix leaking return value from `help_unknown_cmd()`
17:  f2da0c4825 = 17:  9e76f20ad5 builtin/help: fix leaks in `check_git_cmd()`
18:  fb369114b7 = 18:  2d0fa8a922 builtin/init-db: fix leaking directory paths
19:  bf7e34819e = 19:  598e385ad3 builtin/branch: fix leaking sorting options
20:  ec0f1d5f44 = 20:  469adc7754 t/helper: fix leaking commit graph in "read-graph" subcommand
21:  fad027056e = 21:  fe36f95eee global: drop `UNLEAK()` annotation
22:  dc9b641e6a = 22:  3898a90c35 git-compat-util: drop now-unused `UNLEAK()` macro
23:  1a1d34e9d3 = 23:  52e17f51cb t5601: work around leak sanitizer issue
24:  3d89a0c792 = 24:  972a56f3d5 t: mark some tests as leak free
25:  d0925d3731 = 25:  2cad683eab t: remove unneeded !SANITIZE_LEAK prerequisites
26:  b9f4007910 = 26:  de43715991 test-lib: unconditionally enable leak checking
27:  96313e3e47 = 27:  59637d5fea t: remove TEST_PASSES_SANITIZE_LEAK annotations

---
base-commit: b0c643d6a710e2b092902a3941655176b358bfd0
change-id: 20241111-b4-pks-leak-fixes-pt10-a6fa657f4fac

