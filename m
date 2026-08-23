Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81664342173
	for <git@vger.kernel.org>; Sun, 23 Aug 2026 17:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787505590; cv=none; b=Wzo6pbBIKsjAEFKHS6iCuICeScuy2JKynnFKQT9KNlJd4iR8Qv6gG9cOWOA8/uEHbbJ998EqrxNN8Dt+rytyj8+wi0oxdtcOSWOmI99hStY4s2ev50ZELXlYzMDaRCuzq6AcUXjAqAwoibOTOVGYNdZ5uMAtj88EiggRpfJwt7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787505590; c=relaxed/simple;
	bh=CUV5Zxdpu1kM2Cz1wI4ztR584+QgjAmcCVp+GF5kdCw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VEeK6EugV9VCVMSpWzWBy8ONlZFebvT/FbN4e0cwksT6hQLkETJkfOcdNICMg2bJehMFxDoOhJjN6u43tdGJoVhWShPyB0dzK1LczjuDPxR9mJspgNjYTPbrd+HAt5HTS7HsbcljwpUCX0YPZxc5yR0ngDSGhJrmb1fWjNH3Dzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NerEG5Yv; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NerEG5Yv"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2d5655cc850so30891385ad.3
        for <git@vger.kernel.org>; Sun, 23 Aug 2026 10:19:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787505571; x=1788110371; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fv3XRVsWAoNqeDItT5iNznME53LqAmXXiuMBO1RDgvs=;
        b=NerEG5YvJLwIFITsDggCSVJvk5Ws/Gr/ykssn+83RII4JssBmIOiAiC/VD3jDKN5rJ
         BazJC2za66smBBt0PcG3mBq3YrIrCLkUKTyhtM8afMI0CR4WeakD0qBGB9Lesv3Rpc+8
         QskGYpD7jdor4i741Fh1QZ4K5AG9geTcHoQrkOBree0E7Gz5jD7Vdgl1HBc5AnDktKAX
         8UyZtHjqDCrPt+TBpIuvDu0nbLreZlAN+vgEE4vFOqys1JCyJGZx09KHQmj7+3aGT0r/
         FhTN5sgGkV8IDkSNcjLJW47EwCqNiQF652Oar1iChnFcjHZ/ofKcCoUWdvfa3XirJGpi
         m4fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787505571; x=1788110371;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=fv3XRVsWAoNqeDItT5iNznME53LqAmXXiuMBO1RDgvs=;
        b=jRGy5ievPlBPJnXkMhzXG2+2lxL6nZD0H2Am8jiTNcoquS4/OaJ8IPKKtfIxyvrr6g
         cpZXZ7af6rK1bh9prcDuBwPBVSmYGWRa4p8qCbtWnl7khQ8OQ8SgrsJ8vIhOG1c6QfC/
         9SRpdY1TaxBShsRwGq4dAQ9wZtovyo1v9DLeneeWRe3KNcvOPwAqjGDlvex1b/FIuylP
         Qc61+KcOoDWRYxACO3u6A8p86v1KfClis2I7E7kh/83o8reNUKv7XXTM42Oe+KPJf5Sn
         VLO7OSjYKRzvMipcxjRbs6n2KxrtEwe9SecRuQdna/2jY4mp4o52hXb2fC4ajI6oRR8G
         RmlQ==
X-Gm-Message-State: AFuF++lvZjzFYjOQh9+vQVb5sHFAmH64s+O0HVJcXxSn7ZTjHIzteAEY
	WgNcsR0luow6XMyeHhQdpHzKldirTE9tyKJMK42bkGOK+cdKKNVaXxx3/PSO4A==
X-Gm-Gg: AR+sD125Ks6io+7iQqHNmTh00n/w4Bz79+xuSyd7jdJG3n8YPDdV63LYkwC8F3dYyxw
	2wtzdsd5OvunbwjMqOfvgFXjhyn7z+UXLxB6oyxcbv9UYSbgJnZuc/Ei9DDJA1BEX/x3uWIu/5B
	ClocqkOz2pSrY3gkDcWhbx4PfmLh1e6Mc21MPS+ctUdZUE2AOUcP+AtDFc4nmQvFoiiIfmcE/gt
	qBYTFiFajY1eyucv9AuPZzf9eLH96W13Rc2rVR1+QhToW41TVe0oDJI6a/T79ctW1XxAZU44w9U
	eqtcbb2KywLLOIrYqW9/8DZGd6twvA2s7Jn4X3Z+6M+NLsRjpADnw+RDpSnvIWRK3N9PP2albrV
	Jwbcr54oEv6QV5/0Wsmpd8Pd6cQIs0FTo15y++Arbm3pGo5aKftRx72nGPC0l8j7gsYdLQJ2xoa
	GLlL/HPpJqRwVyhoVj/mQz3KyU8VRi79pXGwMV2qksh0m5dy/SYIybUdlnyGYh1JQmsD4U7bZG+
	1Z6LLtsq2yDlRpP4kCpu5fP36ZyYu25rRRRUJau7X4ZelURnpEGV0u/6JgSYaICNma+R2cbkV3U
	MU5GvvcGsAaIbp0y6gABA/JxWI0WVlys1DM00+G2m9ge3PdDK32tioJz
X-Received: by 2002:a17:903:26c3:b0:2cf:4339:aaa with SMTP id d9443c01a7336-2d64b0c72d2mr414626565ad.12.1787505568884;
        Sun, 23 Aug 2026 10:19:28 -0700 (PDT)
Received: from localhost (192-184-169-91.fiber.dynamic.sonic.net. [192.184.169.91])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-327f909a51fsm16449576eec.4.2026.08.23.10.19.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Aug 2026 10:19:28 -0700 (PDT)
From: Michael Montalbo <mmontalbo@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <pks@pks.im>
Subject: [RFC PATCH 07/14] odb: gather the odb sources under odb/
Date: Sun, 23 Aug 2026 10:18:51 -0700
Message-ID: <20260823171915.2662373-8-mmontalbo@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260823171915.2662373-1-mmontalbo@gmail.com>
References: <20260823171915.2662373-1-mmontalbo@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move the 23 odb C sources and 26 headers into odb/ as renames. Repoint
every reference to their old paths to the new ones: the #include lines
across the tree, the Makefile and meson.build build entries, the
Documentation/Makefile argument, and the tutorial #include examples.

Signed-off-by: Michael Montalbo <mmontalbo@gmail.com>
---
 .gitorganize                                  | 98 +++++++++----------
 Documentation/Makefile                        |  4 +-
 Documentation/MyFirstContribution.adoc        |  2 +-
 Documentation/MyFirstObjectWalk.adoc          |  2 +-
 Makefile                                      | 46 ++++-----
 add-interactive.c                             |  4 +-
 add-patch.c                                   |  4 +-
 apply.c                                       |  6 +-
 apply.h                                       |  2 +-
 archive-tar.c                                 |  2 +-
 archive-zip.c                                 |  2 +-
 archive.c                                     | 10 +-
 attr.c                                        |  6 +-
 bisect.c                                      | 10 +-
 blame.c                                       | 10 +-
 blame.h                                       |  2 +-
 bloom.c                                       |  8 +-
 branch.c                                      |  4 +-
 builtin/add.c                                 |  4 +-
 builtin/am.c                                  |  4 +-
 builtin/apply.c                               |  2 +-
 builtin/backfill.c                            | 14 +--
 builtin/bisect.c                              |  4 +-
 builtin/blame.c                               |  8 +-
 builtin/branch.c                              |  4 +-
 builtin/cat-file.c                            | 10 +-
 builtin/check-attr.c                          |  2 +-
 builtin/checkout.c                            | 12 +--
 builtin/clone.c                               |  8 +-
 builtin/commit-graph.c                        |  8 +-
 builtin/commit-tree.c                         |  6 +-
 builtin/commit.c                              |  4 +-
 builtin/count-objects.c                       |  2 +-
 builtin/describe.c                            | 12 +--
 builtin/diff-files.c                          |  2 +-
 builtin/diff-index.c                          |  2 +-
 builtin/diff-pairs.c                          |  4 +-
 builtin/diff-tree.c                           |  6 +-
 builtin/diff.c                                |  8 +-
 builtin/difftool.c                            |  4 +-
 builtin/fast-export.c                         | 12 +--
 builtin/fast-import.c                         | 14 +--
 builtin/fetch-pack.c                          |  4 +-
 builtin/fetch.c                               | 10 +-
 builtin/for-each-ref.c                        |  4 +-
 builtin/fsck.c                                | 18 ++--
 builtin/gc.c                                  |  6 +-
 builtin/get-tar-commit-id.c                   |  2 +-
 builtin/grep.c                                | 12 +--
 builtin/hash-object.c                         |  6 +-
 builtin/history.c                             |  8 +-
 builtin/index-pack.c                          | 22 ++---
 builtin/last-modified.c                       |  8 +-
 builtin/log.c                                 | 18 ++--
 builtin/ls-files.c                            |  4 +-
 builtin/ls-tree.c                             |  6 +-
 builtin/merge-base.c                          |  4 +-
 builtin/merge-file.c                          |  6 +-
 builtin/merge-recursive.c                     |  4 +-
 builtin/merge-tree.c                          | 12 +--
 builtin/merge.c                               |  6 +-
 builtin/mktag.c                               |  8 +-
 builtin/mktree.c                              |  6 +-
 builtin/multi-pack-index.c                    |  4 +-
 builtin/mv.c                                  |  2 +-
 builtin/name-rev.c                            | 10 +-
 builtin/notes.c                               |  6 +-
 builtin/pack-objects.c                        | 22 ++---
 builtin/pack-redundant.c                      |  2 +-
 builtin/patch-id.c                            |  2 +-
 builtin/prune.c                               | 10 +-
 builtin/pull.c                                |  4 +-
 builtin/range-diff.c                          |  2 +-
 builtin/read-tree.c                           |  8 +-
 builtin/rebase.c                              |  6 +-
 builtin/receive-pack.c                        | 16 +--
 builtin/reflog.c                              |  2 +-
 builtin/refs.c                                |  2 +-
 builtin/remote.c                              |  2 +-
 builtin/replace.c                             | 10 +-
 builtin/replay.c                              |  2 +-
 builtin/repo.c                                | 10 +-
 builtin/reset.c                               |  8 +-
 builtin/rev-list.c                            | 14 +--
 builtin/rev-parse.c                           |  8 +-
 builtin/rm.c                                  |  6 +-
 builtin/send-pack.c                           |  2 +-
 builtin/shortlog.c                            |  2 +-
 builtin/show-branch.c                         |  6 +-
 builtin/show-index.c                          |  2 +-
 builtin/show-ref.c                            |  6 +-
 builtin/sparse-checkout.c                     |  4 +-
 builtin/stash.c                               |  8 +-
 builtin/submodule--helper.c                   |  6 +-
 builtin/tag.c                                 | 12 +--
 builtin/unpack-file.c                         |  6 +-
 builtin/unpack-objects.c                      | 12 +--
 builtin/update-index.c                        |  8 +-
 builtin/update-ref.c                          |  4 +-
 builtin/upload-pack.c                         |  4 +-
 builtin/verify-commit.c                       |  4 +-
 builtin/verify-tag.c                          |  4 +-
 builtin/worktree.c                            |  4 +-
 builtin/write-tree.c                          |  2 +-
 bundle-uri.c                                  |  2 +-
 bundle.c                                      |  6 +-
 cache-tree.c                                  | 10 +-
 cache-tree.h                                  |  4 +-
 checkout.c                                    |  2 +-
 checkout.h                                    |  2 +-
 chunk-format.c                                |  2 +-
 chunk-format.h                                |  2 +-
 combine-diff.c                                | 10 +-
 commit-graph.c                                | 18 ++--
 commit-graph.h                                |  4 +-
 commit-reach.c                                |  4 +-
 commit-reach.h                                |  4 +-
 common-init.c                                 |  4 +-
 compat/mingw.c                                |  2 +-
 compat/sha1-chunked.c                         |  2 +-
 config.c                                      |  4 +-
 connect.c                                     |  2 +-
 connected.c                                   |  2 +-
 convert.c                                     |  2 +-
 convert.h                                     |  2 +-
 csum-file.c                                   |  2 +-
 csum-file.h                                   |  2 +-
 decorate.c                                    |  2 +-
 delta-islands.c                               | 12 +--
 diagnose.c                                    |  2 +-
 diff-lib.c                                    |  6 +-
 diff-no-index.c                               |  2 +-
 diff.c                                        | 10 +-
 diff.h                                        |  2 +-
 diffcore-break.c                              |  4 +-
 diffcore-pickaxe.c                            |  2 +-
 diffcore-rename.c                             |  4 +-
 diffcore.h                                    |  2 +-
 dir.c                                         |  4 +-
 dir.h                                         |  2 +-
 entry.c                                       |  2 +-
 environment.c                                 |  4 +-
 fetch-object-info.c                           |  4 +-
 fetch-pack.c                                  | 14 +--
 fetch-pack.h                                  |  2 +-
 fmt-merge-msg.c                               |  6 +-
 fsmonitor.h                                   |  2 +-
 git.c                                         |  4 +-
 gpg-interface.c                               |  2 +-
 graph.c                                       |  2 +-
 grep.c                                        |  2 +-
 help.c                                        |  2 +-
 hex.c                                         |  2 +-
 hex.h                                         |  2 +-
 http-backend.c                                |  6 +-
 http-push.c                                   | 14 +--
 http-walker.c                                 |  4 +-
 http.c                                        |  4 +-
 khash.h                                       |  2 +-
 line-log.c                                    |  8 +-
 list-objects-filter-options.h                 |  2 +-
 list-objects-filter.c                         | 10 +-
 list-objects.c                                | 12 +--
 log-tree.c                                    | 16 +--
 ls-refs.c                                     |  2 +-
 mailmap.c                                     |  4 +-
 merge-blobs.c                                 |  4 +-
 merge-ort-wrappers.c                          |  8 +-
 merge-ort.c                                   | 16 +--
 merge-ort.h                                   |  2 +-
 merge.c                                       |  8 +-
 meson.build                                   | 46 ++++-----
 midx-write.c                                  |  4 +-
 midx.c                                        |  2 +-
 name-hash.c                                   |  2 +-
 negotiator/default.c                          |  4 +-
 negotiator/skipping.c                         |  4 +-
 notes-cache.c                                 |  6 +-
 notes-merge.c                                 |  8 +-
 notes-utils.c                                 |  2 +-
 notes.c                                       |  8 +-
 alloc.c => odb/alloc.c                        | 12 +--
 alloc.h => odb/alloc.h                        |  0
 blob.c => odb/blob.c                          |  4 +-
 blob.h => odb/blob.h                          |  2 +-
 cbtree.c => odb/cbtree.c                      |  2 +-
 cbtree.h => odb/cbtree.h                      |  0
 commit-slab-decl.h => odb/commit-slab-decl.h  |  0
 commit-slab-impl.h => odb/commit-slab-impl.h  |  0
 commit-slab.h => odb/commit-slab.h            |  4 +-
 commit.c => odb/commit.c                      | 20 ++--
 commit.h => odb/commit.h                      |  2 +-
 fsck.c => odb/fsck.c                          | 18 ++--
 fsck.h => odb/fsck.h                          |  4 +-
 hash-lookup.c => odb/hash-lookup.c            |  4 +-
 hash-lookup.h => odb/hash-lookup.h            |  0
 hash.c => odb/hash.c                          |  2 +-
 hash.h => odb/hash.h                          |  0
 loose.c => odb/loose.c                        | 10 +-
 loose.h => odb/loose.h                        |  0
 match-trees.c => odb/match-trees.c            | 10 +-
 match-trees.h => odb/match-trees.h            |  0
 .../object-file-convert.c                     | 10 +-
 .../object-file-convert.h                     |  2 +-
 object-file.c => odb/object-file.c            | 12 +--
 object-file.h => odb/object-file.h            |  4 +-
 object-name.c => odb/object-name.c            | 16 +--
 object-name.h => odb/object-name.h            |  2 +-
 object.c => odb/object.c                      | 16 +--
 object.h => odb/object.h                      |  2 +-
 odb.c => odb/odb.c                            | 14 +--
 odb.h => odb/odb.h                            |  6 +-
 oid-array.c => odb/oid-array.c                |  4 +-
 oid-array.h => odb/oid-array.h                |  2 +-
 oidmap.c => odb/oidmap.c                      |  4 +-
 oidmap.h => odb/oidmap.h                      |  2 +-
 oidset.c => odb/oidset.c                      |  2 +-
 oidset.h => odb/oidset.h                      |  0
 oidtree.c => odb/oidtree.c                    |  4 +-
 oidtree.h => odb/oidtree.h                    |  4 +-
 replace-object.c => odb/replace-object.c      |  8 +-
 replace-object.h => odb/replace-object.h      |  4 +-
 odb/source-files.c                            |  8 +-
 odb/source-inmemory.c                         |  6 +-
 odb/source-loose.c                            | 10 +-
 odb/source.c                                  |  2 +-
 odb/source.h                                  |  4 +-
 odb/streaming.c                               |  4 +-
 odb/streaming.h                               |  4 +-
 tag.c => odb/tag.c                            | 14 +--
 tag.h => odb/tag.h                            |  2 +-
 tmp-objdir.c => odb/tmp-objdir.c              |  6 +-
 tmp-objdir.h => odb/tmp-objdir.h              |  0
 odb/transaction.h                             |  2 +-
 tree-walk.c => odb/tree-walk.c                |  8 +-
 tree-walk.h => odb/tree-walk.h                |  2 +-
 tree.c => odb/tree.c                          | 12 +--
 tree.h => odb/tree.h                          |  2 +-
 oss-fuzz/fuzz-pack-idx.c                      |  2 +-
 pack-bitmap-write.c                           | 14 +--
 pack-bitmap.c                                 |  6 +-
 pack-check.c                                  |  4 +-
 pack-mtimes.c                                 |  2 +-
 pack-objects.c                                |  2 +-
 pack-objects.h                                |  2 +-
 pack-revindex.c                               |  2 +-
 pack-write.c                                  |  2 +-
 pack.h                                        |  2 +-
 packfile.c                                    | 16 +--
 packfile.h                                    |  6 +-
 parallel-checkout.c                           |  2 +-
 parse-options-cb.c                            |  6 +-
 patch-ids.c                                   |  4 +-
 path-walk.c                                   | 18 ++--
 path-walk.h                                   |  2 +-
 path.c                                        |  2 +-
 pretty.c                                      |  6 +-
 promisor-remote.c                             |  2 +-
 protocol-caps.c                               |  6 +-
 prune-packed.c                                |  2 +-
 pseudo-merge.c                                |  6 +-
 range-diff.c                                  |  4 +-
 reachable.c                                   |  6 +-
 read-cache-ll.h                               |  2 +-
 read-cache.c                                  | 12 +--
 read-cache.h                                  |  2 +-
 rebase-interactive.c                          |  6 +-
 ref-filter.c                                  | 12 +--
 ref-filter.h                                  |  4 +-
 reflog-walk.c                                 |  2 +-
 reflog.c                                      |  6 +-
 refs.c                                        | 10 +-
 refs.h                                        |  4 +-
 refs/files-backend.c                          |  4 +-
 refs/packed-backend.c                         |  4 +-
 refs/ref-cache.c                              |  2 +-
 refs/ref-cache.h                              |  2 +-
 refs/reftable-backend.c                       |  4 +-
 refspec.c                                     |  2 +-
 remote-curl.c                                 |  2 +-
 remote.c                                      |  6 +-
 remote.h                                      |  2 +-
 repack-midx.c                                 |  6 +-
 repack.c                                      |  2 +-
 replay.c                                      |  4 +-
 replay.h                                      |  2 +-
 repository.c                                  |  6 +-
 rerere.c                                      |  4 +-
 reset.c                                       |  6 +-
 reset.h                                       |  2 +-
 resolve-undo.c                                |  2 +-
 resolve-undo.h                                |  2 +-
 revision.c                                    | 18 ++--
 revision.h                                    |  8 +-
 send-pack.c                                   |  6 +-
 sequencer.c                                   | 16 +--
 serve.c                                       |  2 +-
 server-info.c                                 | 10 +-
 setup.c                                       |  4 +-
 shallow.c                                     | 10 +-
 shallow.h                                     |  4 +-
 sparse-index.c                                |  2 +-
 split-index.c                                 |  2 +-
 split-index.h                                 |  2 +-
 submodule-config.c                            |  6 +-
 submodule-config.h                            |  2 +-
 submodule.c                                   | 10 +-
 t/helper/test-bitmap.c                        |  2 +-
 t/helper/test-bloom.c                         |  2 +-
 t/helper/test-cache-tree.c                    |  2 +-
 t/helper/test-dump-cache-tree.c               |  4 +-
 t/helper/test-find-pack.c                     |  4 +-
 t/helper/test-hash-speed.c                    |  2 +-
 t/helper/test-match-trees.c                   |  6 +-
 t/helper/test-pack-deltas.c                   |  2 +-
 t/helper/test-pack-mtimes.c                   |  2 +-
 t/helper/test-partial-clone.c                 |  2 +-
 t/helper/test-path-walk.c                     |  6 +-
 t/helper/test-reach.c                         |  6 +-
 t/helper/test-read-graph.c                    |  2 +-
 t/helper/test-read-midx.c                     |  2 +-
 t/helper/test-ref-store.c                     |  2 +-
 t/helper/test-reftable.c                      |  2 +-
 t/helper/test-repository.c                    |  6 +-
 t/helper/test-revision-walking.c              |  4 +-
 t/helper/test-scrap-cache-tree.c              |  2 +-
 t/helper/test-sha1.c                          |  2 +-
 t/helper/test-sha256.c                        |  2 +-
 t/helper/test-submodule-config.c              |  4 +-
 t/helper/test-synthesize.c                    |  6 +-
 t/unit-tests/lib-oid.h                        |  2 +-
 t/unit-tests/u-example-decorate.c             |  2 +-
 t/unit-tests/u-odb-inmemory.c                 |  4 +-
 t/unit-tests/u-oid-array.c                    |  2 +-
 t/unit-tests/u-oidmap.c                       |  4 +-
 t/unit-tests/u-oidtree.c                      |  4 +-
 trailer.c                                     |  2 +-
 transport-helper.c                            |  4 +-
 transport.c                                   |  4 +-
 tree-diff.c                                   |  6 +-
 unpack-trees.c                                |  6 +-
 unpack-trees.h                                |  2 +-
 upload-pack.c                                 |  8 +-
 walker.c                                      | 12 +--
 wt-status.c                                   | 10 +-
 xdiff-interface.c                             |  2 +-
 xdiff-interface.h                             |  2 +-
 347 files changed, 1006 insertions(+), 1006 deletions(-)
 rename alloc.c => odb/alloc.c (95%)
 rename alloc.h => odb/alloc.h (100%)
 rename blob.c => odb/blob.c (89%)
 rename blob.h => odb/blob.h (96%)
 rename cbtree.c => odb/cbtree.c (99%)
 rename cbtree.h => odb/cbtree.h (100%)
 rename commit-slab-decl.h => odb/commit-slab-decl.h (100%)
 rename commit-slab-impl.h => odb/commit-slab-impl.h (100%)
 rename commit-slab.h => odb/commit-slab.h (97%)
 rename commit.c => odb/commit.c (99%)
 rename commit.h => odb/commit.h (99%)
 rename fsck.c => odb/fsck.c (99%)
 rename fsck.h => odb/fsck.h (99%)
 rename hash-lookup.c => odb/hash-lookup.c (98%)
 rename hash-lookup.h => odb/hash-lookup.h (100%)
 rename hash.c => odb/hash.c (99%)
 rename hash.h => odb/hash.h (100%)
 rename loose.c => odb/loose.c (98%)
 rename loose.h => odb/loose.h (100%)
 rename match-trees.c => odb/match-trees.c (98%)
 rename match-trees.h => odb/match-trees.h (100%)
 rename object-file-convert.c => odb/object-file-convert.c (98%)
 rename object-file-convert.h => odb/object-file-convert.h (96%)
 rename object-file.c => odb/object-file.c (99%)
 rename object-file.h => odb/object-file.h (99%)
 rename object-name.c => odb/object-name.c (99%)
 rename object-name.h => odb/object-name.h (99%)
 rename object.c => odb/object.c (98%)
 rename object.h => odb/object.h (99%)
 rename odb.c => odb/odb.c (99%)
 rename odb.h => odb/odb.h (99%)
 rename oid-array.c => odb/oid-array.c (97%)
 rename oid-array.h => odb/oid-array.h (99%)
 rename oidmap.c => odb/oidmap.c (97%)
 rename oidmap.h => odb/oidmap.h (99%)
 rename oidset.c => odb/oidset.c (99%)
 rename oidset.h => odb/oidset.h (100%)
 rename oidtree.c => odb/oidtree.c (98%)
 rename oidtree.h => odb/oidtree.h (97%)
 rename replace-object.c => odb/replace-object.c (96%)
 rename replace-object.h => odb/replace-object.h (97%)
 rename tag.c => odb/tag.c (97%)
 rename tag.h => odb/tag.h (96%)
 rename tmp-objdir.c => odb/tmp-objdir.c (99%)
 rename tmp-objdir.h => odb/tmp-objdir.h (100%)
 rename tree-walk.c => odb/tree-walk.c (99%)
 rename tree-walk.h => odb/tree-walk.h (99%)
 rename tree.c => odb/tree.c (97%)
 rename tree.h => odb/tree.h (98%)

diff --git a/.gitorganize b/.gitorganize
index 522821522e..5da6d0b2b1 100644
--- a/.gitorganize
+++ b/.gitorganize
@@ -30,8 +30,6 @@ advice.c component=? role=lib prefix=advice includes=setup:2 cochange=transport:
 advice.h component=? role=public prefix=advice cochange=transport:14,index:9,odb:6,submodule:4,pack:3
 alias.c component=setup role=lib prefix=alias includes=setup:2 cochange=setup:8,diff:4,transport:3,convert:2,index:2
 alias.h component=setup role=header prefix=completion cochange=setup:3,transport:2,pack:1,revision:1
-alloc.c component=odb role=lib prefix=alloc includes=odb:6,setup:1 cochange=odb:54,revision:8,diff:6,pack:6,index:3
-alloc.h component=odb role=header prefix=alloc cochange=odb:16,refs:1,revision:1
 apply.c component=? role=lib prefix=apply includes=index:5,setup:4,odb:3,diff:2,merge:2 cochange=index:93,setup:43,diff:41,odb:26,merge:24
 apply.h component=? role=public prefix=apply includes=odb:1 cochange=diff:2
 archive-tar.c component=archive role=lib prefix=archive-tar includes=archive:1,odb:1,setup:1 cochange=archive:59,index:12,diff:9,odb:9,transport:8
@@ -47,8 +45,6 @@ bisect.c component=revision role=lib prefix=bisect includes=odb:5,revision:5,set
 bisect.h component=revision role=header prefix=bisect cochange=revision:29,odb:2
 blame.c component=revision role=lib prefix=blame includes=odb:5,diff:2,index:2,pack:2,revision:2 cochange=diff:68,revision:66,odb:56,index:29,pack:22
 blame.h component=revision role=header prefix=blame includes=diff:1,odb:1 cochange=revision:19,odb:7,diff:4,archive:1,index:1
-blob.c component=odb role=lib prefix=object includes=odb:2 cochange=odb:131,transport:12,pack:11,revision:10,refs:5
-blob.h component=odb role=header prefix=blob includes=odb:1 cochange=odb:33,revision:4,pack:3,transport:2
 bloom.c component=pack role=lib prefix=bloom includes=odb:4,diff:2,pack:2,setup:2 cochange=pack:38,revision:25,diff:15,odb:6,index:2
 bloom.h component=pack role=header prefix=bloom cochange=pack:28,revision:12,odb:1
 branch.c component=? role=lib prefix=branch includes=refs:3,setup:3,odb:2,submodule:1,transport:1 cochange=refs:62,transport:41,setup:28,index:19,revision:12
@@ -60,8 +56,6 @@ bundle.c component=transport role=lib prefix=bundle includes=odb:3,revision:3,se
 bundle.h component=transport role=header prefix=bundle includes=revision:1 cochange=transport:37,revision:5
 cache-tree.c component=index role=lib prefix=cache-tree includes=odb:5,index:2,setup:1,transport:1 cochange=index:94,odb:69,revision:27,transport:21,diff:20
 cache-tree.h component=index role=header prefix=cache-tree includes=odb:2 cochange=index:42,diff:4,revision:4,odb:3,refs:1
-cbtree.c component=odb role=lib prefix=cbtree includes=odb:1 cochange=odb:9,diff:1,merge:1,pack:1
-cbtree.h component=odb role=header prefix=cbtree cochange=odb:12,pack:3,setup:1,transport:1
 chdir-notify.c component=? role=lib prefix=chdir-notify includes=revision:1 cochange=index:2,archive:1,merge:1,revision:1
 chdir-notify.h component=? role=public prefix=chdir-notify
 checkout.c component=index role=lib prefix=checkout includes=setup:2,index:1,odb:1,refs:1,transport:1 cochange=transport:16,refs:6,setup:5,index:3,odb:2
@@ -77,11 +71,6 @@ commit-graph.c component=pack role=lib prefix=commit-graph includes=odb:9,pack:4
 commit-graph.h component=pack role=header prefix=commit-graph includes=odb:2 cochange=pack:92,odb:14,setup:9,revision:8,transport:5
 commit-reach.c component=revision role=lib prefix=commit-reach includes=revision:3,odb:2,pack:1,refs:1 cochange=revision:38,odb:17,pack:15,transport:9,index:5
 commit-reach.h component=revision role=header prefix=commit-reach includes=odb:2 cochange=revision:32,odb:9,transport:8,pack:3,refs:3
-commit-slab-decl.h component=odb role=header prefix=commit-slab cochange=odb:6,revision:1
-commit-slab-impl.h component=odb role=header prefix=commit-slab cochange=odb:7,pack:3,revision:1,setup:1,transport:1
-commit-slab.h component=odb role=header prefix=commit-slab includes=odb:2 cochange=odb:8,revision:2,transport:2,index:1,merge:1
-commit.c component=odb role=lib prefix=commit includes=odb:10,setup:4,revision:3,diff:1,index:1 cochange=odb:403,revision:147,transport:87,pack:57,setup:45
-commit.h component=odb role=header prefix=commit includes=odb:1 cochange=odb:237,revision:205,transport:49,pack:25,notes:22
 common-exit.c component=? role=lib prefix=common-main
 common-init.c component=? role=lib prefix=common-main includes=odb:2,setup:2,convert:1 cochange=setup:1
 common-init.h component=? role=public prefix=common-main
@@ -146,8 +135,6 @@ fetch-pack.h component=transport role=header prefix=fetch-pack includes=odb:1,re
 fmt-merge-msg.c component=merge role=lib prefix=fmt-merge-msg includes=odb:3,diff:2,revision:2,setup:2,merge:1 cochange=revision:10,odb:7,index:6,diff:4,setup:4
 fmt-merge-msg.h component=merge role=header prefix=fmt-merge-msg cochange=merge:3,setup:2
 for-each-ref.h component=? role=public prefix=?
-fsck.c component=odb role=lib prefix=fsck includes=odb:9,setup:3,convert:1,index:1,pack:1 cochange=odb:113,revision:46,transport:43,pack:20,setup:15
-fsck.h component=odb role=header prefix=fsck includes=odb:2 cochange=odb:50,diff:5,revision:5,transport:5,refs:4
 fsmonitor--daemon.h component=index role=header prefix=fsmonitor--daemon includes=index:1 cochange=index:1
 fsmonitor-ipc.c component=index role=lib prefix=fsmonitor includes=index:1,setup:1 cochange=index:6,transport:2,merge:1,notes:1,pack:1
 fsmonitor-ipc.h component=index role=header prefix=fsmonitor cochange=index:2
@@ -170,10 +157,6 @@ graph.c component=revision role=lib prefix=graph includes=revision:2,odb:1,setup
 graph.h component=revision role=header prefix=graph includes=diff:1 cochange=revision:19,diff:2,odb:1
 grep.c component=? role=lib prefix=grep includes=diff:4,odb:1,revision:1,setup:1 cochange=diff:40,revision:28,transport:10,index:7,refs:7
 grep.h component=? role=public prefix=grep includes=diff:1 cochange=revision:23,diff:10,transport:4,index:2,refs:2
-hash-lookup.c component=odb role=lib prefix=hash includes=odb:2,index:1 cochange=pack:14,odb:12,diff:1,index:1,merge:1
-hash-lookup.h component=odb role=header prefix=hash-lookup cochange=odb:10,pack:8,diff:1,merge:1,revision:1
-hash.c component=odb role=lib prefix=hash includes=odb:1 cochange=odb:15,diff:2,setup:2,index:1,transport:1
-hash.h component=odb role=header prefix=hash includes=setup:1 cochange=odb:32,pack:11,index:9,diff:7,transport:4
 hashmap.c component=? role=lib prefix=hashmap cochange=diff:33,revision:19,index:17,refs:13,submodule:13
 hashmap.h component=? role=public prefix=hashmap cochange=diff:39,revision:23,index:18,submodule:14,refs:13
 help.c component=? role=lib prefix=help includes=setup:4,index:1,odb:1,refs:1,transport:1 cochange=setup:19,transport:19,diff:9,index:8,odb:7
@@ -218,16 +201,12 @@ lockfile.c component=? role=lib prefix=lockfile includes=setup:1 cochange=refs:1
 lockfile.h component=? role=public prefix=lockfile cochange=index:5,revision:4,diff:3,refs:3,odb:2
 log-tree.c component=revision role=lib prefix=format-patch includes=odb:8,revision:5,diff:3,setup:3,refs:2 cochange=revision:222,diff:112,odb:112,refs:31,transport:16
 log-tree.h component=revision role=header prefix=format-patch cochange=revision:64,diff:11,refs:3,odb:2,transport:2
-loose.c component=odb role=lib prefix=loose includes=odb:5,setup:1 cochange=odb:31,pack:18,setup:7,transport:6,refs:2
-loose.h component=odb role=header prefix=loose cochange=odb:8,setup:3
 ls-refs.c component=refs role=lib prefix=ls-refs includes=setup:3,refs:2,odb:1,transport:1 cochange=refs:26,transport:17,pack:10,revision:5,odb:4
 ls-refs.h component=refs role=header prefix=ls-refs cochange=transport:11,refs:5,submodule:1
 mailinfo.c component=? role=lib prefix=mailinfo includes=setup:2 cochange=transport:5,index:3,notes:3,odb:3,revision:3
 mailinfo.h component=? role=public prefix=mailinfo
 mailmap.c component=? role=lib prefix=mailmap includes=setup:3,odb:2 cochange=setup:13,transport:11,refs:10,index:8,revision:5
 mailmap.h component=? role=public prefix=mailmap cochange=setup:8,revision:4,transport:2,diff:1,index:1
-match-trees.c component=odb role=lib prefix=match-trees includes=odb:5,setup:1 cochange=odb:33,index:15,notes:15,revision:12,pack:10
-match-trees.h component=odb role=header prefix=match-trees cochange=merge:1,odb:1
 mem-pool.c component=? role=lib prefix=mem-pool cochange=index:6
 mem-pool.h component=? role=public prefix=mem-pool cochange=index:4
 merge-blobs.c component=merge role=lib prefix=object-store includes=merge:2,odb:2 cochange=merge:9,notes:3,diff:2,convert:1,odb:1
@@ -254,24 +233,55 @@ notes-utils.c component=notes role=lib prefix=commit includes=setup:2,notes:1,od
 notes-utils.h component=notes role=header prefix=notes includes=notes:1 cochange=notes:17,odb:6
 notes.c component=notes role=lib prefix=notes includes=odb:4,setup:2,notes:1,refs:1 cochange=notes:63,odb:58,revision:41,transport:36,index:24
 notes.h component=notes role=header prefix=notes cochange=notes:55,revision:20,setup:9,odb:3,refs:2
-object-file-convert.c component=odb role=lib prefix=object-file-convert includes=odb:5,setup:1 cochange=odb:8,setup:2,transport:1
-object-file-convert.h component=odb role=header prefix=object-file-convert includes=odb:1 cochange=odb:4
-object-file.c component=odb role=lib prefix=object-file includes=odb:6,index:2,pack:2,setup:2,convert:1 cochange=odb:183,pack:96,index:55,setup:30,transport:27
-object-file.h component=odb role=header prefix=object-file includes=odb:2 cochange=odb:113,pack:30,index:12,notes:5,transport:5
-object-name.c component=odb role=lib prefix=object-name includes=odb:8,setup:5,index:2,revision:2,pack:1 cochange=odb:46,pack:31,revision:23,setup:19,refs:18
-object-name.h component=odb role=header prefix=object-name includes=odb:1 cochange=odb:5,revision:3,refs:2,index:1
-object.c component=odb role=lib prefix=object includes=odb:8,index:1,pack:1 cochange=odb:265,pack:61,revision:55,transport:34,refs:17
-object.h component=odb role=header prefix=object includes=odb:1 cochange=odb:187,revision:54,transport:41,pack:29,refs:20
-odb.c component=odb role=lib prefix=odb includes=odb:7,pack:3,setup:3,index:1,submodule:1 cochange=odb:123,pack:64,setup:13,transport:12,index:8
-odb.h component=odb role=header prefix=odb includes=odb:3 cochange=odb:117,pack:71,transport:16,setup:13,index:10
-oid-array.c component=odb role=lib prefix=oid-array includes=odb:2 cochange=odb:13,pack:10,merge:2,diff:1,revision:1
-oid-array.h component=odb role=header prefix=oid-array includes=odb:1 cochange=odb:3,diff:1,index:1,refs:1,revision:1
-oidmap.c component=odb role=lib prefix=oidmap includes=odb:2 cochange=diff:11,revision:7,odb:6,refs:5,index:4
-oidmap.h component=odb role=header prefix=oidmap includes=odb:1 cochange=odb:6,revision:4,index:2,transport:2,convert:1
-oidset.c component=odb role=lib prefix=oidset includes=odb:1 cochange=odb:17,convert:2,diff:2,transport:2,index:1
-oidset.h component=odb role=header prefix=oidset cochange=odb:17,revision:1,transport:1
-oidtree.c component=odb role=lib prefix=oidtree includes=odb:2 cochange=odb:14,index:3,setup:2,diff:1,merge:1
-oidtree.h component=odb role=header prefix=oidtree includes=odb:2 cochange=odb:9
+odb/alloc.c component=odb role=lib prefix=alloc includes=odb:6,setup:1 cochange=odb:54,revision:8,diff:6,pack:6,index:3
+odb/alloc.h component=odb role=header prefix=alloc cochange=odb:16,refs:1,revision:1
+odb/blob.c component=odb role=lib prefix=object includes=odb:2 cochange=odb:131,transport:12,pack:11,revision:10,refs:5
+odb/blob.h component=odb role=header prefix=blob includes=odb:1 cochange=odb:33,revision:4,pack:3,transport:2
+odb/cbtree.c component=odb role=lib prefix=cbtree includes=odb:1 cochange=odb:9,diff:1,merge:1,pack:1
+odb/cbtree.h component=odb role=header prefix=cbtree cochange=odb:12,pack:3,setup:1,transport:1
+odb/commit-slab-decl.h component=odb role=header prefix=commit-slab cochange=odb:6,revision:1
+odb/commit-slab-impl.h component=odb role=header prefix=commit-slab cochange=odb:7,pack:3,revision:1,setup:1,transport:1
+odb/commit-slab.h component=odb role=header prefix=commit-slab includes=odb:2 cochange=odb:8,revision:2,transport:2,index:1,merge:1
+odb/commit.c component=odb role=lib prefix=commit includes=odb:10,setup:4,revision:3,diff:1,index:1 cochange=odb:403,revision:147,transport:87,pack:57,setup:45
+odb/commit.h component=odb role=header prefix=commit includes=odb:1 cochange=odb:237,revision:205,transport:49,pack:25,notes:22
+odb/fsck.c component=odb role=lib prefix=fsck includes=odb:9,setup:3,convert:1,index:1,pack:1 cochange=odb:113,revision:46,transport:43,pack:20,setup:15
+odb/fsck.h component=odb role=header prefix=fsck includes=odb:2 cochange=odb:50,diff:5,revision:5,transport:5,refs:4
+odb/hash-lookup.c component=odb role=lib prefix=hash includes=odb:2,index:1 cochange=pack:14,odb:12,diff:1,index:1,merge:1
+odb/hash-lookup.h component=odb role=header prefix=hash-lookup cochange=odb:10,pack:8,diff:1,merge:1,revision:1
+odb/hash.c component=odb role=lib prefix=hash includes=odb:1 cochange=odb:15,diff:2,setup:2,index:1,transport:1
+odb/hash.h component=odb role=header prefix=hash includes=setup:1 cochange=odb:32,pack:11,index:9,diff:7,transport:4
+odb/loose.c component=odb role=lib prefix=loose includes=odb:5,setup:1 cochange=odb:31,pack:18,setup:7,transport:6,refs:2
+odb/loose.h component=odb role=header prefix=loose cochange=odb:8,setup:3
+odb/match-trees.c component=odb role=lib prefix=match-trees includes=odb:5,setup:1 cochange=odb:33,index:15,notes:15,revision:12,pack:10
+odb/match-trees.h component=odb role=header prefix=match-trees cochange=merge:1,odb:1
+odb/object-file-convert.c component=odb role=lib prefix=object-file-convert includes=odb:5,setup:1 cochange=odb:8,setup:2,transport:1
+odb/object-file-convert.h component=odb role=header prefix=object-file-convert includes=odb:1 cochange=odb:4
+odb/object-file.c component=odb role=lib prefix=object-file includes=odb:6,index:2,pack:2,setup:2,convert:1 cochange=odb:183,pack:96,index:55,setup:30,transport:27
+odb/object-file.h component=odb role=header prefix=object-file includes=odb:2 cochange=odb:113,pack:30,index:12,notes:5,transport:5
+odb/object-name.c component=odb role=lib prefix=object-name includes=odb:8,setup:5,index:2,revision:2,pack:1 cochange=odb:46,pack:31,revision:23,setup:19,refs:18
+odb/object-name.h component=odb role=header prefix=object-name includes=odb:1 cochange=odb:5,revision:3,refs:2,index:1
+odb/object.c component=odb role=lib prefix=object includes=odb:8,index:1,pack:1 cochange=odb:265,pack:61,revision:55,transport:34,refs:17
+odb/object.h component=odb role=header prefix=object includes=odb:1 cochange=odb:187,revision:54,transport:41,pack:29,refs:20
+odb/odb.c component=odb role=lib prefix=odb includes=odb:7,pack:3,setup:3,index:1,submodule:1 cochange=odb:123,pack:64,setup:13,transport:12,index:8
+odb/odb.h component=odb role=header prefix=odb includes=odb:3 cochange=odb:117,pack:71,transport:16,setup:13,index:10
+odb/oid-array.c component=odb role=lib prefix=oid-array includes=odb:2 cochange=odb:13,pack:10,merge:2,diff:1,revision:1
+odb/oid-array.h component=odb role=header prefix=oid-array includes=odb:1 cochange=odb:3,diff:1,index:1,refs:1,revision:1
+odb/oidmap.c component=odb role=lib prefix=oidmap includes=odb:2 cochange=diff:11,revision:7,odb:6,refs:5,index:4
+odb/oidmap.h component=odb role=header prefix=oidmap includes=odb:1 cochange=odb:6,revision:4,index:2,transport:2,convert:1
+odb/oidset.c component=odb role=lib prefix=oidset includes=odb:1 cochange=odb:17,convert:2,diff:2,transport:2,index:1
+odb/oidset.h component=odb role=header prefix=oidset cochange=odb:17,revision:1,transport:1
+odb/oidtree.c component=odb role=lib prefix=oidtree includes=odb:2 cochange=odb:14,index:3,setup:2,diff:1,merge:1
+odb/oidtree.h component=odb role=header prefix=oidtree includes=odb:2 cochange=odb:9
+odb/replace-object.c component=odb role=lib prefix=refs includes=odb:4,refs:1,setup:1 cochange=odb:8,setup:6,refs:5,pack:3,diff:2
+odb/replace-object.h component=odb role=header prefix=replace-object includes=odb:2,setup:1 cochange=odb:11,setup:9,pack:4,revision:3,merge:1
+odb/tag.c component=odb role=lib prefix=tag includes=odb:7,setup:2,pack:1 cochange=odb:189,transport:36,pack:32,revision:29,refs:14
+odb/tag.h component=odb role=header prefix=tag includes=odb:1 cochange=odb:60,transport:10,revision:8,refs:7,pack:6
+odb/tmp-objdir.c component=odb role=lib prefix=tmp-objdir includes=odb:3,setup:2,index:1 cochange=pack:24,odb:23,setup:8,transport:5,revision:3
+odb/tmp-objdir.h component=odb role=header prefix=tmp-objdir cochange=odb:8,revision:3,setup:1
+odb/tree-walk.c component=odb role=lib prefix=tree-walk includes=odb:4,index:3,setup:1 cochange=odb:70,index:61,diff:31,revision:24,pack:13
+odb/tree-walk.h component=odb role=header prefix=tree-walk includes=odb:1 cochange=odb:64,diff:23,index:23,revision:21,notes:7
+odb/tree.c component=odb role=lib prefix=tree includes=odb:6,setup:2 cochange=odb:212,revision:45,index:36,pack:25,transport:21
+odb/tree.h component=odb role=header prefix=tree includes=odb:1 cochange=odb:75,revision:12,archive:8,index:6,pack:5
 pack-bitmap-write.c component=pack role=lib prefix=pack-bitmap-write includes=odb:7,pack:6,revision:2,setup:2,diff:1 cochange=pack:132,odb:32,revision:27,transport:10,diff:4
 pack-bitmap.c component=pack role=lib prefix=pack-bitmap includes=pack:7,odb:3,revision:3,setup:2,diff:1 cochange=pack:232,revision:30,odb:18,transport:14,refs:7
 pack-bitmap.h component=pack role=header prefix=pack-bitmap includes=pack:2,refs:1 cochange=pack:117,refs:5,odb:2,setup:2,revision:1
@@ -363,8 +373,6 @@ repack-midx.c component=pack role=lib prefix=repack includes=odb:3,pack:3,refs:1
 repack-promisor.c component=pack role=lib prefix=repack-promisor includes=pack:3,setup:1 cochange=pack:8,odb:3,revision:2
 repack.c component=pack role=lib prefix=repack includes=pack:3,index:1,odb:1,setup:1 cochange=pack:31,transport:2,odb:1
 repack.h component=pack role=header prefix=repack includes=revision:1 cochange=pack:28
-replace-object.c component=odb role=lib prefix=refs includes=odb:4,refs:1,setup:1 cochange=odb:8,setup:6,refs:5,pack:3,diff:2
-replace-object.h component=odb role=header prefix=replace-object includes=odb:2,setup:1 cochange=odb:11,setup:9,pack:4,revision:3,merge:1
 replay.c component=? role=lib prefix=replay includes=odb:2,merge:1,refs:1,revision:1,setup:1 cochange=transport:1
 replay.h component=? role=public prefix=replay includes=odb:1
 repo-settings.c component=setup role=lib prefix=repo-settings includes=setup:4,pack:2 cochange=setup:65,pack:17,index:8,transport:8,odb:6
@@ -428,15 +436,11 @@ submodule.c component=submodule role=lib prefix=submodule includes=odb:5,setup:4
 submodule.h component=submodule role=header prefix=submodule cochange=submodule:128,index:22,diff:21,transport:17,setup:6
 symlinks.c component=index role=lib prefix=symlinks includes=index:1,setup:1 cochange=index:23,diff:3,archive:2,convert:1,revision:1
 symlinks.h component=index role=header prefix=symlinks cochange=index:9,diff:1
-tag.c component=odb role=lib prefix=tag includes=odb:7,setup:2,pack:1 cochange=odb:189,transport:36,pack:32,revision:29,refs:14
-tag.h component=odb role=header prefix=tag includes=odb:1 cochange=odb:60,transport:10,revision:8,refs:7,pack:6
 tar.h component=? role=public prefix=tar-tree
 tempfile.c component=? role=lib prefix=tempfile cochange=pack:5,setup:4,index:3,odb:3,revision:3
 tempfile.h component=? role=public prefix=tempfile includes=revision:1 cochange=revision:3,diff:2,index:2,setup:2
 thread-utils.c component=? role=lib prefix=thread-utils cochange=diff:1
 thread-utils.h component=? role=public prefix=thread-utils cochange=transport:1
-tmp-objdir.c component=odb role=lib prefix=tmp-objdir includes=odb:3,setup:2,index:1 cochange=pack:24,odb:23,setup:8,transport:5,revision:3
-tmp-objdir.h component=odb role=header prefix=tmp-objdir cochange=odb:8,revision:3,setup:1
 trace.c component=? role=lib prefix=trace includes=setup:2 cochange=setup:26,transport:13,index:11,odb:4,diff:2
 trace.h component=? role=public prefix=trace cochange=transport:6,index:5,odb:4,pack:3,revision:3
 trace2.c component=? role=lib prefix=trace2 includes=setup:2 cochange=setup:2
@@ -448,10 +452,6 @@ transport-internal.h component=transport role=header prefix=transport includes=t
 transport.c component=transport role=lib prefix=transport includes=transport:12,setup:3,odb:2,refs:2,submodule:1 cochange=transport:482,refs:35,setup:31,submodule:29,revision:21
 transport.h component=transport role=header prefix=transport includes=transport:2,revision:1 cochange=transport:249,submodule:6,odb:4,revision:2,diff:1
 tree-diff.c component=diff role=lib prefix=tree-diff includes=odb:3,diff:2,index:1,setup:1 cochange=diff:115,odb:56,revision:53,index:36,notes:12
-tree-walk.c component=odb role=lib prefix=tree-walk includes=odb:4,index:3,setup:1 cochange=odb:70,index:61,diff:31,revision:24,pack:13
-tree-walk.h component=odb role=header prefix=tree-walk includes=odb:1 cochange=odb:64,diff:23,index:23,revision:21,notes:7
-tree.c component=odb role=lib prefix=tree includes=odb:6,setup:2 cochange=odb:212,revision:45,index:36,pack:25,transport:21
-tree.h component=odb role=header prefix=tree includes=odb:1 cochange=odb:75,revision:12,archive:8,index:6,pack:5
 unicode-width.h component=? role=public prefix=unicode
 unix-socket.c component=? role=lib prefix=unix-socket cochange=diff:3,revision:2,setup:1
 unix-socket.h component=? role=public prefix=unix-socket
diff --git a/Documentation/Makefile b/Documentation/Makefile
index 2699f0b24a..c5b52b6e7a 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -505,10 +505,10 @@ lint-docs-man-section-order: $(LINT_DOCS_MAN_SECTION_ORDER)
 .PHONY: lint-docs-fsck-msgids
 LINT_DOCS_FSCK_MSGIDS = .build/lint-docs/fsck-msgids.ok
 $(LINT_DOCS_FSCK_MSGIDS): lint-fsck-msgids.perl
-$(LINT_DOCS_FSCK_MSGIDS): ../fsck.h fsck-msgids.adoc
+$(LINT_DOCS_FSCK_MSGIDS): ../odb/fsck.h fsck-msgids.adoc
 	$(call mkdir_p_parent_template)
 	$(QUIET_GEN)$(PERL_PATH) lint-fsck-msgids.perl \
-		../fsck.h fsck-msgids.adoc $@
+		../odb/fsck.h fsck-msgids.adoc $@
 lint-docs-fsck-msgids: $(LINT_DOCS_FSCK_MSGIDS)
 
 ## Lint: delimited sections
diff --git a/Documentation/MyFirstContribution.adoc b/Documentation/MyFirstContribution.adoc
index 34bfa2e3a9..4b50aaa40e 100644
--- a/Documentation/MyFirstContribution.adoc
+++ b/Documentation/MyFirstContribution.adoc
@@ -428,7 +428,7 @@ require a full format object to be passed.
 Add the following includes:
 
 ----
-#include "commit.h"
+#include "odb/commit.h"
 #include "pretty.h"
 #include "strbuf.h"
 ----
diff --git a/Documentation/MyFirstObjectWalk.adoc b/Documentation/MyFirstObjectWalk.adoc
index 413a9fdb05..87b2433b2c 100644
--- a/Documentation/MyFirstObjectWalk.adoc
+++ b/Documentation/MyFirstObjectWalk.adoc
@@ -779,7 +779,7 @@ be processed in order to populate that list.
 First, add the `struct oidset` and related items we will use to iterate it:
 
 ----
-#include "oidset.h"
+#include "odb/oidset.h"
 
 ...
 
diff --git a/Makefile b/Makefile
index 86297e9459..a95b87d970 100644
--- a/Makefile
+++ b/Makefile
@@ -1103,7 +1103,7 @@ LIB_OBJS += add-interactive.o
 LIB_OBJS += add-patch.o
 LIB_OBJS += advice.o
 LIB_OBJS += alias.o
-LIB_OBJS += alloc.o
+LIB_OBJS += odb/alloc.o
 LIB_OBJS += apply.o
 LIB_OBJS += archive-tar.o
 LIB_OBJS += archive-zip.o
@@ -1112,13 +1112,13 @@ LIB_OBJS += attr.o
 LIB_OBJS += base85.o
 LIB_OBJS += bisect.o
 LIB_OBJS += blame.o
-LIB_OBJS += blob.o
+LIB_OBJS += odb/blob.o
 LIB_OBJS += bloom.o
 LIB_OBJS += branch.o
 LIB_OBJS += bundle-uri.o
 LIB_OBJS += bundle.o
 LIB_OBJS += cache-tree.o
-LIB_OBJS += cbtree.o
+LIB_OBJS += odb/cbtree.o
 LIB_OBJS += chdir-notify.o
 LIB_OBJS += checkout.o
 LIB_OBJS += chunk-format.o
@@ -1127,7 +1127,7 @@ LIB_OBJS += column.o
 LIB_OBJS += combine-diff.o
 LIB_OBJS += commit-graph.o
 LIB_OBJS += commit-reach.o
-LIB_OBJS += commit.o
+LIB_OBJS += odb/commit.o
 LIB_OBJS += common-exit.o
 LIB_OBJS += common-init.o
 LIB_OBJS += compat/nonblock.o
@@ -1172,7 +1172,7 @@ LIB_OBJS += fetch-negotiator.o
 LIB_OBJS += fetch-object-info.o
 LIB_OBJS += fetch-pack.o
 LIB_OBJS += fmt-merge-msg.o
-LIB_OBJS += fsck.o
+LIB_OBJS += odb/fsck.o
 LIB_OBJS += fsmonitor.o
 LIB_OBJS += fsmonitor-ipc.o
 LIB_OBJS += fsmonitor-settings.o
@@ -1181,8 +1181,8 @@ LIB_OBJS += git-zlib.o
 LIB_OBJS += gpg-interface.o
 LIB_OBJS += graph.o
 LIB_OBJS += grep.o
-LIB_OBJS += hash-lookup.o
-LIB_OBJS += hash.o
+LIB_OBJS += odb/hash-lookup.o
+LIB_OBJS += odb/hash.o
 LIB_OBJS += hashmap.o
 LIB_OBJS += help.o
 LIB_OBJS += hex.o
@@ -1200,11 +1200,11 @@ LIB_OBJS += list-objects-filter.o
 LIB_OBJS += list-objects.o
 LIB_OBJS += lockfile.o
 LIB_OBJS += log-tree.o
-LIB_OBJS += loose.o
+LIB_OBJS += odb/loose.o
 LIB_OBJS += ls-refs.o
 LIB_OBJS += mailinfo.o
 LIB_OBJS += mailmap.o
-LIB_OBJS += match-trees.o
+LIB_OBJS += odb/match-trees.o
 LIB_OBJS += mem-pool.o
 LIB_OBJS += merge-blobs.o
 LIB_OBJS += merge-ll.o
@@ -1221,11 +1221,11 @@ LIB_OBJS += notes-cache.o
 LIB_OBJS += notes-merge.o
 LIB_OBJS += notes-utils.o
 LIB_OBJS += notes.o
-LIB_OBJS += object-file-convert.o
-LIB_OBJS += object-file.o
-LIB_OBJS += object-name.o
-LIB_OBJS += object.o
-LIB_OBJS += odb.o
+LIB_OBJS += odb/object-file-convert.o
+LIB_OBJS += odb/object-file.o
+LIB_OBJS += odb/object-name.o
+LIB_OBJS += odb/object.o
+LIB_OBJS += odb/odb.o
 LIB_OBJS += odb/source.o
 LIB_OBJS += odb/source-files.o
 LIB_OBJS += odb/source-inmemory.o
@@ -1233,10 +1233,10 @@ LIB_OBJS += odb/source-loose.o
 LIB_OBJS += odb/source-packed.o
 LIB_OBJS += odb/streaming.o
 LIB_OBJS += odb/transaction.o
-LIB_OBJS += oid-array.o
-LIB_OBJS += oidmap.o
-LIB_OBJS += oidset.o
-LIB_OBJS += oidtree.o
+LIB_OBJS += odb/oid-array.o
+LIB_OBJS += odb/oidmap.o
+LIB_OBJS += odb/oidset.o
+LIB_OBJS += odb/oidtree.o
 LIB_OBJS += organize/gitorganize-format.o
 LIB_OBJS += organize/labeler-protocol.o
 LIB_OBJS += organize/organize.o
@@ -1310,7 +1310,7 @@ LIB_OBJS += repack-filtered.o
 LIB_OBJS += repack-geometry.o
 LIB_OBJS += repack-midx.o
 LIB_OBJS += repack-promisor.o
-LIB_OBJS += replace-object.o
+LIB_OBJS += odb/replace-object.o
 LIB_OBJS += replay.o
 LIB_OBJS += repo-settings.o
 LIB_OBJS += repository.o
@@ -1339,10 +1339,10 @@ LIB_OBJS += sub-process.o
 LIB_OBJS += submodule-config.o
 LIB_OBJS += submodule.o
 LIB_OBJS += symlinks.o
-LIB_OBJS += tag.o
+LIB_OBJS += odb/tag.o
 LIB_OBJS += tempfile.o
 LIB_OBJS += thread-utils.o
-LIB_OBJS += tmp-objdir.o
+LIB_OBJS += odb/tmp-objdir.o
 LIB_OBJS += trace.o
 LIB_OBJS += trace2.o
 LIB_OBJS += trace2/tr2_cfg.o
@@ -1361,8 +1361,8 @@ LIB_OBJS += trailer.o
 LIB_OBJS += transport-helper.o
 LIB_OBJS += transport.o
 LIB_OBJS += tree-diff.o
-LIB_OBJS += tree-walk.o
-LIB_OBJS += tree.o
+LIB_OBJS += odb/tree-walk.o
+LIB_OBJS += odb/tree.o
 LIB_OBJS += unpack-trees.o
 LIB_OBJS += upload-pack.o
 LIB_OBJS += url.o
diff --git a/add-interactive.c b/add-interactive.c
index 3cf8a1dbf8..51ddcc4e87 100644
--- a/add-interactive.c
+++ b/add-interactive.c
@@ -5,7 +5,7 @@
 #include "color.h"
 #include "diffcore.h"
 #include "gettext.h"
-#include "hash.h"
+#include "odb/hash.h"
 #include "hex.h"
 #include "preload-index.h"
 #include "read-cache-ll.h"
@@ -17,7 +17,7 @@
 #include "dir.h"
 #include "run-command.h"
 #include "prompt.h"
-#include "tree.h"
+#include "odb/tree.h"
 
 void init_add_i_state(struct add_i_state *s, struct repository *r,
 		      struct interactive_options *opts)
diff --git a/add-patch.c b/add-patch.c
index f27edcbe8d..1b4c53e4ce 100644
--- a/add-patch.c
+++ b/add-patch.c
@@ -4,14 +4,14 @@
 #include "git-compat-util.h"
 #include "add-patch.h"
 #include "advice.h"
-#include "commit.h"
+#include "odb/commit.h"
 #include "config.h"
 #include "diff.h"
 #include "editor.h"
 #include "environment.h"
 #include "gettext.h"
 #include "hex.h"
-#include "object-name.h"
+#include "odb/object-name.h"
 #include "pager.h"
 #include "read-cache-ll.h"
 #include "repository.h"
diff --git a/apply.c b/apply.c
index f00b7ba4d3..ba486ab51d 100644
--- a/apply.c
+++ b/apply.c
@@ -14,7 +14,7 @@
 #include "abspath.h"
 #include "base85.h"
 #include "config.h"
-#include "odb.h"
+#include "odb/odb.h"
 #include "delta.h"
 #include "diff.h"
 #include "dir.h"
@@ -25,8 +25,8 @@
 #include "merge-ll.h"
 #include "lockfile.h"
 #include "name-hash.h"
-#include "object-name.h"
-#include "object-file.h"
+#include "odb/object-name.h"
+#include "odb/object-file.h"
 #include "parse-options.h"
 #include "path.h"
 #include "quote.h"
diff --git a/apply.h b/apply.h
index 5f2f03d3ed..7c22776d41 100644
--- a/apply.h
+++ b/apply.h
@@ -1,7 +1,7 @@
 #ifndef APPLY_H
 #define APPLY_H
 
-#include "hash.h"
+#include "odb/hash.h"
 #include "lockfile.h"
 #include "string-list.h"
 #include "strmap.h"
diff --git a/archive-tar.c b/archive-tar.c
index 0fc70d13a8..318b9bcc24 100644
--- a/archive-tar.c
+++ b/archive-tar.c
@@ -11,7 +11,7 @@
 #include "hex.h"
 #include "tar.h"
 #include "archive.h"
-#include "odb.h"
+#include "odb/odb.h"
 #include "odb/streaming.h"
 #include "strbuf.h"
 #include "run-command.h"
diff --git a/archive-zip.c b/archive-zip.c
index 97ea8d60d6..53c50ebc44 100644
--- a/archive-zip.c
+++ b/archive-zip.c
@@ -11,7 +11,7 @@
 #include "git-zlib.h"
 #include "hex.h"
 #include "utf8.h"
-#include "odb.h"
+#include "odb/odb.h"
 #include "odb/streaming.h"
 #include "strbuf.h"
 #include "userdiff.h"
diff --git a/archive.c b/archive.c
index 59790be986..c0d2e0c44b 100644
--- a/archive.c
+++ b/archive.c
@@ -9,15 +9,15 @@
 #include "gettext.h"
 #include "git-zlib.h"
 #include "hex.h"
-#include "object-name.h"
+#include "odb/object-name.h"
 #include "path.h"
 #include "pretty.h"
 #include "setup.h"
 #include "refs.h"
-#include "odb.h"
-#include "commit.h"
-#include "tree.h"
-#include "tree-walk.h"
+#include "odb/odb.h"
+#include "odb/commit.h"
+#include "odb/tree.h"
+#include "odb/tree-walk.h"
 #include "attr.h"
 #include "archive.h"
 #include "parse-options.h"
diff --git a/attr.c b/attr.c
index 0e63f1b6de..e829149cb4 100644
--- a/attr.c
+++ b/attr.c
@@ -22,11 +22,11 @@
 #include "read-cache-ll.h"
 #include "refs.h"
 #include "revision.h"
-#include "odb.h"
+#include "odb/odb.h"
 #include "setup.h"
 #include "thread-utils.h"
-#include "tree-walk.h"
-#include "object-name.h"
+#include "odb/tree-walk.h"
+#include "odb/object-name.h"
 
 char *git_attr_tree;
 
diff --git a/bisect.c b/bisect.c
index d426fcd5a9..2dea7139ad 100644
--- a/bisect.c
+++ b/bisect.c
@@ -3,7 +3,7 @@
 
 #include "git-compat-util.h"
 #include "config.h"
-#include "commit.h"
+#include "odb/commit.h"
 #include "diff.h"
 #include "environment.h"
 #include "gettext.h"
@@ -15,12 +15,12 @@
 #include "run-command.h"
 #include "log-tree.h"
 #include "bisect.h"
-#include "oid-array.h"
+#include "odb/oid-array.h"
 #include "strvec.h"
-#include "commit-slab.h"
+#include "odb/commit-slab.h"
 #include "commit-reach.h"
-#include "object-name.h"
-#include "odb.h"
+#include "odb/object-name.h"
+#include "odb/odb.h"
 #include "path.h"
 #include "dir.h"
 
diff --git a/blame.c b/blame.c
index 126e232416..d1cba8811f 100644
--- a/blame.c
+++ b/blame.c
@@ -3,10 +3,10 @@
 
 #include "git-compat-util.h"
 #include "refs.h"
-#include "odb.h"
+#include "odb/odb.h"
 #include "cache-tree.h"
 #include "mergesort.h"
-#include "commit.h"
+#include "odb/commit.h"
 #include "convert.h"
 #include "diff.h"
 #include "diffcore.h"
@@ -16,11 +16,11 @@
 #include "read-cache.h"
 #include "revision.h"
 #include "setup.h"
-#include "tag.h"
+#include "odb/tag.h"
 #include "trace2.h"
 #include "blame.h"
-#include "alloc.h"
-#include "commit-slab.h"
+#include "odb/alloc.h"
+#include "odb/commit-slab.h"
 #include "bloom.h"
 #include "commit-graph.h"
 
diff --git a/blame.h b/blame.h
index 3b34be0e5c..97137099e3 100644
--- a/blame.h
+++ b/blame.h
@@ -1,7 +1,7 @@
 #ifndef BLAME_H
 #define BLAME_H
 
-#include "oidset.h"
+#include "odb/oidset.h"
 #include "xdiff-interface.h"
 #include "prio-queue.h"
 
diff --git a/bloom.c b/bloom.c
index caf22f9831..e61cb05246 100644
--- a/bloom.c
+++ b/bloom.c
@@ -6,10 +6,10 @@
 #include "diffcore.h"
 #include "hashmap.h"
 #include "commit-graph.h"
-#include "commit.h"
-#include "commit-slab.h"
-#include "tree.h"
-#include "tree-walk.h"
+#include "odb/commit.h"
+#include "odb/commit-slab.h"
+#include "odb/tree.h"
+#include "odb/tree-walk.h"
 #include "config.h"
 #include "repository.h"
 
diff --git a/branch.c b/branch.c
index 22f4f46b96..7593a499a9 100644
--- a/branch.c
+++ b/branch.c
@@ -7,14 +7,14 @@
 #include "environment.h"
 #include "gettext.h"
 #include "hex.h"
-#include "object-name.h"
+#include "odb/object-name.h"
 #include "path.h"
 #include "refs.h"
 #include "refspec.h"
 #include "remote.h"
 #include "repository.h"
 #include "sequencer.h"
-#include "commit.h"
+#include "odb/commit.h"
 #include "worktree.h"
 #include "submodule-config.h"
 #include "run-command.h"
diff --git a/builtin/add.c b/builtin/add.c
index eab8f03cad..5d6dd91f70 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -14,8 +14,8 @@
 #include "gettext.h"
 #include "pathspec.h"
 #include "run-command.h"
-#include "object-file.h"
-#include "odb.h"
+#include "odb/object-file.h"
+#include "odb/odb.h"
 #include "odb/transaction.h"
 #include "parse-options.h"
 #include "path.h"
diff --git a/builtin/am.c b/builtin/am.c
index e9623b8307..f138a8fe3d 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -23,11 +23,11 @@
 #include "lockfile.h"
 #include "cache-tree.h"
 #include "refs.h"
-#include "commit.h"
+#include "odb/commit.h"
 #include "diff.h"
 #include "unpack-trees.h"
 #include "branch.h"
-#include "object-name.h"
+#include "odb/object-name.h"
 #include "preload-index.h"
 #include "sequencer.h"
 #include "revision.h"
diff --git a/builtin/apply.c b/builtin/apply.c
index d642a40251..5fb37cb965 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -1,7 +1,7 @@
 #define USE_THE_REPOSITORY_VARIABLE
 #include "builtin.h"
 #include "gettext.h"
-#include "hash.h"
+#include "odb/hash.h"
 #include "apply.h"
 
 static const char * const apply_usage[] = {
diff --git a/builtin/backfill.c b/builtin/backfill.c
index e71e0f4742..3685713205 100644
--- a/builtin/backfill.c
+++ b/builtin/backfill.c
@@ -6,16 +6,16 @@
 #include "config.h"
 #include "parse-options.h"
 #include "repository.h"
-#include "commit.h"
+#include "odb/commit.h"
 #include "dir.h"
 #include "environment.h"
 #include "hex.h"
-#include "tree.h"
-#include "tree-walk.h"
-#include "object.h"
-#include "odb.h"
-#include "oid-array.h"
-#include "oidset.h"
+#include "odb/tree.h"
+#include "odb/tree-walk.h"
+#include "odb/object.h"
+#include "odb/odb.h"
+#include "odb/oid-array.h"
+#include "odb/oidset.h"
 #include "promisor-remote.h"
 #include "strmap.h"
 #include "string-list.h"
diff --git a/builtin/bisect.c b/builtin/bisect.c
index 93420ac0ea..a1b7fc9407 100644
--- a/builtin/bisect.c
+++ b/builtin/bisect.c
@@ -6,13 +6,13 @@
 #include "environment.h"
 #include "gettext.h"
 #include "hex.h"
-#include "object-name.h"
+#include "odb/object-name.h"
 #include "parse-options.h"
 #include "bisect.h"
 #include "refs.h"
 #include "strvec.h"
 #include "run-command.h"
-#include "oid-array.h"
+#include "odb/oid-array.h"
 #include "path.h"
 #include "prompt.h"
 #include "quote.h"
diff --git a/builtin/blame.c b/builtin/blame.c
index 48d5251c6d..c88fc489f7 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -13,7 +13,7 @@
 #include "environment.h"
 #include "gettext.h"
 #include "hex.h"
-#include "commit.h"
+#include "odb/commit.h"
 #include "diff.h"
 #include "revision.h"
 #include "quote.h"
@@ -26,13 +26,13 @@
 #include "line-range.h"
 #include "line-log.h"
 #include "progress.h"
-#include "object-name.h"
-#include "odb.h"
+#include "odb/object-name.h"
+#include "odb/odb.h"
 #include "pager.h"
 #include "blame.h"
 #include "refs.h"
 #include "setup.h"
-#include "tag.h"
+#include "odb/tag.h"
 #include "write-or-die.h"
 
 static const char blame_usage[] = N_("git blame [<options>] [<rev-opts>] [<rev>] [--] <file>");
diff --git a/builtin/branch.c b/builtin/branch.c
index a613148fc7..c50c28c720 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -13,9 +13,9 @@
 #include "editor.h"
 #include "environment.h"
 #include "refs.h"
-#include "commit.h"
+#include "odb/commit.h"
 #include "gettext.h"
-#include "object-name.h"
+#include "odb/object-name.h"
 #include "remote.h"
 #include "parse-options.h"
 #include "branch.h"
diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index e85e2cfc1b..ccd6b33827 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -18,13 +18,13 @@
 #include "list-objects-filter-options.h"
 #include "parse-options.h"
 #include "userdiff.h"
-#include "oid-array.h"
+#include "odb/oid-array.h"
 #include "packfile.h"
-#include "object-file.h"
-#include "object-name.h"
-#include "odb.h"
+#include "odb/object-file.h"
+#include "odb/object-name.h"
+#include "odb/odb.h"
 #include "odb/streaming.h"
-#include "replace-object.h"
+#include "odb/replace-object.h"
 #include "promisor-remote.h"
 #include "mailmap.h"
 #include "write-or-die.h"
diff --git a/builtin/check-attr.c b/builtin/check-attr.c
index 217d83ea7d..02ff3b4eb5 100644
--- a/builtin/check-attr.c
+++ b/builtin/check-attr.c
@@ -4,7 +4,7 @@
 #include "attr.h"
 #include "environment.h"
 #include "gettext.h"
-#include "object-name.h"
+#include "odb/object-name.h"
 #include "quote.h"
 #include "setup.h"
 #include "parse-options.h"
diff --git a/builtin/checkout.c b/builtin/checkout.c
index 55e3a89a85..2dcebb2cb2 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -6,7 +6,7 @@
 #include "branch.h"
 #include "cache-tree.h"
 #include "checkout.h"
-#include "commit.h"
+#include "odb/commit.h"
 #include "config.h"
 #include "diff.h"
 #include "dir.h"
@@ -17,9 +17,9 @@
 #include "merge-ll.h"
 #include "lockfile.h"
 #include "mem-pool.h"
-#include "object-file.h"
-#include "object-name.h"
-#include "odb.h"
+#include "odb/object-file.h"
+#include "odb/object-name.h"
+#include "odb/odb.h"
 #include "parse-options.h"
 #include "path.h"
 #include "preload-index.h"
@@ -36,8 +36,8 @@
 #include "submodule.h"
 #include "symlinks.h"
 #include "trace2.h"
-#include "tree.h"
-#include "tree-walk.h"
+#include "odb/tree.h"
+#include "odb/tree-walk.h"
 #include "unpack-trees.h"
 #include "wt-status.h"
 #include "xdiff-interface.h"
diff --git a/builtin/clone.c b/builtin/clone.c
index 5b25cca510..6d6a756a12 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -24,10 +24,10 @@
 #include "parse-options.h"
 #include "refs.h"
 #include "refspec.h"
-#include "object-file.h"
-#include "odb.h"
-#include "tree.h"
-#include "tree-walk.h"
+#include "odb/object-file.h"
+#include "odb/odb.h"
+#include "odb/tree.h"
+#include "odb/tree-walk.h"
 #include "unpack-trees.h"
 #include "transport.h"
 #include "strbuf.h"
diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
index d62005edc0..0758af3b64 100644
--- a/builtin/commit-graph.c
+++ b/builtin/commit-graph.c
@@ -1,17 +1,17 @@
 #define USE_THE_REPOSITORY_VARIABLE
 #include "builtin.h"
-#include "commit.h"
+#include "odb/commit.h"
 #include "config.h"
 #include "environment.h"
 #include "gettext.h"
 #include "hex.h"
 #include "parse-options.h"
 #include "commit-graph.h"
-#include "odb.h"
+#include "odb/odb.h"
 #include "progress.h"
-#include "replace-object.h"
+#include "odb/replace-object.h"
 #include "strbuf.h"
-#include "tag.h"
+#include "odb/tag.h"
 #include "trace2.h"
 
 #define BUILTIN_COMMIT_GRAPH_VERIFY_USAGE \
diff --git a/builtin/commit-tree.c b/builtin/commit-tree.c
index 30535db131..598ef30372 100644
--- a/builtin/commit-tree.c
+++ b/builtin/commit-tree.c
@@ -9,10 +9,10 @@
 #include "environment.h"
 #include "gettext.h"
 #include "hex.h"
-#include "object-name.h"
-#include "odb.h"
+#include "odb/object-name.h"
+#include "odb/odb.h"
 
-#include "commit.h"
+#include "odb/commit.h"
 #include "parse-options.h"
 
 static const char * const commit_tree_usage[] = {
diff --git a/builtin/commit.c b/builtin/commit.c
index 28f6174503..e5a6c0b889 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -18,14 +18,14 @@
 #include "editor.h"
 #include "environment.h"
 #include "diff.h"
-#include "commit.h"
+#include "odb/commit.h"
 #include "add-interactive.h"
 #include "gettext.h"
 #include "revision.h"
 #include "wt-status.h"
 #include "run-command.h"
 #include "strbuf.h"
-#include "object-name.h"
+#include "odb/object-name.h"
 #include "parse-options.h"
 #include "path.h"
 #include "preload-index.h"
diff --git a/builtin/count-objects.c b/builtin/count-objects.c
index 18f6e33b6f..e256779b1f 100644
--- a/builtin/count-objects.c
+++ b/builtin/count-objects.c
@@ -13,7 +13,7 @@
 #include "parse-options.h"
 #include "quote.h"
 #include "packfile.h"
-#include "object-file.h"
+#include "odb/object-file.h"
 
 static unsigned long garbage;
 static off_t size_garbage;
diff --git a/builtin/describe.c b/builtin/describe.c
index c0abc931a5..75961c5945 100644
--- a/builtin/describe.c
+++ b/builtin/describe.c
@@ -7,10 +7,10 @@
 #include "gettext.h"
 #include "hex.h"
 #include "lockfile.h"
-#include "commit.h"
-#include "tag.h"
+#include "odb/commit.h"
+#include "odb/tag.h"
 #include "refs.h"
-#include "object-name.h"
+#include "odb/object-name.h"
 #include "parse-options.h"
 #include "read-cache-ll.h"
 #include "revision.h"
@@ -19,12 +19,12 @@
 #include "setup.h"
 #include "strvec.h"
 #include "run-command.h"
-#include "odb.h"
+#include "odb/odb.h"
 #include "list-objects.h"
-#include "commit-slab.h"
+#include "odb/commit-slab.h"
 #include "wildmatch.h"
 #include "prio-queue.h"
-#include "oidset.h"
+#include "odb/oidset.h"
 
 #define MAX_TAGS	(FLAG_BITS - 1)
 #define DEFAULT_CANDIDATES 10
diff --git a/builtin/diff-files.c b/builtin/diff-files.c
index ea91347ce2..c5b7548e55 100644
--- a/builtin/diff-files.c
+++ b/builtin/diff-files.c
@@ -11,7 +11,7 @@
 #include "config.h"
 #include "diff.h"
 #include "diff-merges.h"
-#include "commit.h"
+#include "odb/commit.h"
 #include "preload-index.h"
 #include "revision.h"
 
diff --git a/builtin/diff-index.c b/builtin/diff-index.c
index 3db7cffede..a23f444348 100644
--- a/builtin/diff-index.c
+++ b/builtin/diff-index.c
@@ -5,7 +5,7 @@
 #include "config.h"
 #include "diff.h"
 #include "diff-merges.h"
-#include "commit.h"
+#include "odb/commit.h"
 #include "preload-index.h"
 #include "revision.h"
 #include "setup.h"
diff --git a/builtin/diff-pairs.c b/builtin/diff-pairs.c
index 71c045331a..315fc7357a 100644
--- a/builtin/diff-pairs.c
+++ b/builtin/diff-pairs.c
@@ -3,9 +3,9 @@
 #include "diff.h"
 #include "diffcore.h"
 #include "gettext.h"
-#include "hash.h"
+#include "odb/hash.h"
 #include "hex.h"
-#include "object.h"
+#include "odb/object.h"
 #include "parse-options.h"
 #include "revision.h"
 #include "strbuf.h"
diff --git a/builtin/diff-tree.c b/builtin/diff-tree.c
index 8b8f8b54e4..a3e1e5e020 100644
--- a/builtin/diff-tree.c
+++ b/builtin/diff-tree.c
@@ -3,14 +3,14 @@
 #include "builtin.h"
 #include "config.h"
 #include "diff.h"
-#include "commit.h"
+#include "odb/commit.h"
 #include "gettext.h"
 #include "hex.h"
 #include "log-tree.h"
 #include "read-cache-ll.h"
 #include "revision.h"
-#include "tmp-objdir.h"
-#include "tree.h"
+#include "odb/tmp-objdir.h"
+#include "odb/tree.h"
 
 static struct rev_info log_tree_opt;
 
diff --git a/builtin/diff.c b/builtin/diff.c
index 18b1083e98..c9ccc7e6c5 100644
--- a/builtin/diff.c
+++ b/builtin/diff.c
@@ -12,9 +12,9 @@
 #include "ewah/ewok.h"
 #include "lockfile.h"
 #include "color.h"
-#include "commit.h"
+#include "odb/commit.h"
 #include "gettext.h"
-#include "tag.h"
+#include "odb/tag.h"
 #include "diff.h"
 #include "diff-merges.h"
 #include "diffcore.h"
@@ -23,8 +23,8 @@
 #include "revision.h"
 #include "log-tree.h"
 #include "setup.h"
-#include "oid-array.h"
-#include "tree.h"
+#include "odb/oid-array.h"
+#include "odb/tree.h"
 
 #define DIFF_NO_INDEX_EXPLICIT 1
 #define DIFF_NO_INDEX_IMPLICIT 2
diff --git a/builtin/difftool.c b/builtin/difftool.c
index bc7b2ea443..075112d344 100644
--- a/builtin/difftool.c
+++ b/builtin/difftool.c
@@ -29,8 +29,8 @@
 #include "strvec.h"
 #include "strbuf.h"
 #include "lockfile.h"
-#include "object-file.h"
-#include "odb.h"
+#include "odb/object-file.h"
+#include "odb/odb.h"
 #include "dir.h"
 #include "entry.h"
 #include "setup.h"
diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index 50278bef7a..472877f0e5 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -14,11 +14,11 @@
 #include "hex.h"
 #include "refs.h"
 #include "refspec.h"
-#include "object-file.h"
-#include "odb.h"
-#include "commit.h"
-#include "object.h"
-#include "tag.h"
+#include "odb/object-file.h"
+#include "odb/odb.h"
+#include "odb/commit.h"
+#include "odb/object.h"
+#include "odb/tag.h"
 #include "diff.h"
 #include "diffcore.h"
 #include "log-tree.h"
@@ -29,7 +29,7 @@
 #include "parse-options.h"
 #include "quote.h"
 #include "remote.h"
-#include "blob.h"
+#include "odb/blob.h"
 #include "gpg-interface.h"
 
 static const char *const fast_export_usage[] = {
diff --git a/builtin/fast-import.c b/builtin/fast-import.c
index 4bed9edd7d..1d560d4e71 100644
--- a/builtin/fast-import.c
+++ b/builtin/fast-import.c
@@ -8,10 +8,10 @@
 #include "hex.h"
 #include "config.h"
 #include "lockfile.h"
-#include "object.h"
-#include "blob.h"
-#include "tree.h"
-#include "commit.h"
+#include "odb/object.h"
+#include "odb/blob.h"
+#include "odb/tree.h"
+#include "odb/commit.h"
 #include "delta.h"
 #include "pack.h"
 #include "path.h"
@@ -22,9 +22,9 @@
 #include "dir.h"
 #include "run-command.h"
 #include "packfile.h"
-#include "object-file.h"
-#include "object-name.h"
-#include "odb.h"
+#include "odb/object-file.h"
+#include "odb/object-name.h"
+#include "odb/odb.h"
 #include "mem-pool.h"
 #include "commit-reach.h"
 #include "khash.h"
diff --git a/builtin/fetch-pack.c b/builtin/fetch-pack.c
index 316badd969..c6ae0197ab 100644
--- a/builtin/fetch-pack.c
+++ b/builtin/fetch-pack.c
@@ -4,12 +4,12 @@
 #include "builtin.h"
 #include "gettext.h"
 #include "hex.h"
-#include "object-file.h"
+#include "odb/object-file.h"
 #include "pkt-line.h"
 #include "fetch-pack.h"
 #include "remote.h"
 #include "connect.h"
-#include "oid-array.h"
+#include "odb/oid-array.h"
 #include "protocol.h"
 
 static const char fetch_pack_usage[] =
diff --git a/builtin/fetch.c b/builtin/fetch.c
index ab7db2be06..2089e7823e 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -13,11 +13,11 @@
 #include "hex.h"
 #include "refs.h"
 #include "refspec.h"
-#include "object-name.h"
-#include "odb.h"
-#include "oidset.h"
-#include "oid-array.h"
-#include "commit.h"
+#include "odb/object-name.h"
+#include "odb/odb.h"
+#include "odb/oidset.h"
+#include "odb/oid-array.h"
+#include "odb/commit.h"
 #include "string-list.h"
 #include "remote.h"
 #include "transport.h"
diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
index 4a2fc421db..d3399455ef 100644
--- a/builtin/for-each-ref.c
+++ b/builtin/for-each-ref.c
@@ -1,10 +1,10 @@
 #include "builtin.h"
-#include "commit.h"
+#include "odb/commit.h"
 #include "config.h"
 #include "environment.h"
 #include "for-each-ref.h"
 #include "gettext.h"
-#include "object.h"
+#include "odb/object.h"
 #include "parse-options.h"
 #include "ref-filter.h"
 #include "strbuf.h"
diff --git a/builtin/fsck.c b/builtin/fsck.c
index a6c054e45b..3176941c1d 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -2,24 +2,24 @@
 #include "gettext.h"
 #include "hex.h"
 #include "config.h"
-#include "commit.h"
-#include "tree.h"
-#include "blob.h"
-#include "tag.h"
+#include "odb/commit.h"
+#include "odb/tree.h"
+#include "odb/blob.h"
+#include "odb/tag.h"
 #include "refs.h"
 #include "pack.h"
 #include "cache-tree.h"
-#include "fsck.h"
+#include "odb/fsck.h"
 #include "parse-options.h"
 #include "progress.h"
 #include "packfile.h"
-#include "object-file.h"
-#include "object-name.h"
-#include "odb.h"
+#include "odb/object-file.h"
+#include "odb/object-name.h"
+#include "odb/odb.h"
 #include "odb/streaming.h"
 #include "path.h"
 #include "read-cache-ll.h"
-#include "replace-object.h"
+#include "odb/replace-object.h"
 #include "resolve-undo.h"
 #include "run-command.h"
 #include "sparse-index.h"
diff --git a/builtin/gc.c b/builtin/gc.c
index de2f9e7fed..f2fdc2c69d 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -26,11 +26,11 @@
 #include "run-command.h"
 #include "sigchain.h"
 #include "strvec.h"
-#include "commit.h"
+#include "odb/commit.h"
 #include "commit-graph.h"
 #include "packfile.h"
-#include "object-file.h"
-#include "odb.h"
+#include "odb/object-file.h"
+#include "odb/odb.h"
 #include "path.h"
 #include "reflog.h"
 #include "rerere.h"
diff --git a/builtin/get-tar-commit-id.c b/builtin/get-tar-commit-id.c
index e4cd1627b4..d78ecd8ab9 100644
--- a/builtin/get-tar-commit-id.c
+++ b/builtin/get-tar-commit-id.c
@@ -2,7 +2,7 @@
  * Copyright (c) 2005, 2006 Rene Scharfe
  */
 #include "builtin.h"
-#include "commit.h"
+#include "odb/commit.h"
 #include "tar.h"
 
 static const char builtin_get_tar_commit_id_usage[] =
diff --git a/builtin/grep.c b/builtin/grep.c
index d3d86abe01..d13858caec 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -13,8 +13,8 @@
 #include "gettext.h"
 #include "hex.h"
 #include "config.h"
-#include "tag.h"
-#include "tree-walk.h"
+#include "odb/tag.h"
+#include "odb/tree-walk.h"
 #include "parse-options.h"
 #include "string-list.h"
 #include "run-command.h"
@@ -25,11 +25,11 @@
 #include "setup.h"
 #include "submodule.h"
 #include "submodule-config.h"
-#include "object-name.h"
-#include "odb.h"
+#include "odb/object-name.h"
+#include "odb/odb.h"
 #include "odb/source.h"
-#include "oid-array.h"
-#include "oidset.h"
+#include "odb/oid-array.h"
+#include "odb/oidset.h"
 #include "pager.h"
 #include "path.h"
 #include "promisor-remote.h"
diff --git a/builtin/hash-object.c b/builtin/hash-object.c
index f306b0643f..335575862c 100644
--- a/builtin/hash-object.c
+++ b/builtin/hash-object.c
@@ -11,9 +11,9 @@
 #include "environment.h"
 #include "gettext.h"
 #include "hex.h"
-#include "object-file.h"
-#include "odb.h"
-#include "blob.h"
+#include "odb/object-file.h"
+#include "odb/odb.h"
+#include "odb/blob.h"
 #include "quote.h"
 #include "parse-options.h"
 #include "setup.h"
diff --git a/builtin/history.c b/builtin/history.c
index 000155ad9c..a2aa224bd1 100644
--- a/builtin/history.c
+++ b/builtin/history.c
@@ -2,7 +2,7 @@
 
 #include "builtin.h"
 #include "cache-tree.h"
-#include "commit.h"
+#include "odb/commit.h"
 #include "commit-reach.h"
 #include "config.h"
 #include "editor.h"
@@ -11,7 +11,7 @@
 #include "hex.h"
 #include "lockfile.h"
 #include "merge-ort.h"
-#include "oidmap.h"
+#include "odb/oidmap.h"
 #include "parse-options.h"
 #include "path.h"
 #include "read-cache.h"
@@ -21,8 +21,8 @@
 #include "revision.h"
 #include "sequencer.h"
 #include "strvec.h"
-#include "tree.h"
-#include "tree-walk.h"
+#include "odb/tree.h"
+#include "odb/tree-walk.h"
 #include "unpack-trees.h"
 #include "wt-status.h"
 
diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index bc86925ad0..aa0e04eeee 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -9,24 +9,24 @@
 #include "hex.h"
 #include "pack.h"
 #include "csum-file.h"
-#include "blob.h"
-#include "commit.h"
-#include "tag.h"
-#include "tree.h"
+#include "odb/blob.h"
+#include "odb/commit.h"
+#include "odb/tag.h"
+#include "odb/tree.h"
 #include "progress.h"
-#include "fsck.h"
+#include "odb/fsck.h"
 #include "strbuf.h"
 #include "thread-utils.h"
 #include "packfile.h"
 #include "pack-revindex.h"
-#include "object-file.h"
-#include "odb.h"
+#include "odb/object-file.h"
+#include "odb/odb.h"
 #include "odb/streaming.h"
-#include "oid-array.h"
-#include "oidset.h"
+#include "odb/oid-array.h"
+#include "odb/oidset.h"
 #include "path.h"
-#include "replace-object.h"
-#include "tree-walk.h"
+#include "odb/replace-object.h"
+#include "odb/tree-walk.h"
 #include "promisor-remote.h"
 #include "run-command.h"
 #include "setup.h"
diff --git a/builtin/last-modified.c b/builtin/last-modified.c
index 5478182f2e..e8827b5dc6 100644
--- a/builtin/last-modified.c
+++ b/builtin/last-modified.c
@@ -2,8 +2,8 @@
 #include "bloom.h"
 #include "builtin.h"
 #include "commit-graph.h"
-#include "commit-slab.h"
-#include "commit.h"
+#include "odb/commit-slab.h"
+#include "odb/commit.h"
 #include "config.h"
 #include "diff.h"
 #include "diffcore.h"
@@ -11,8 +11,8 @@
 #include "ewah/ewok.h"
 #include "hashmap.h"
 #include "hex.h"
-#include "object-name.h"
-#include "object.h"
+#include "odb/object-name.h"
+#include "odb/object.h"
 #include "parse-options.h"
 #include "prio-queue.h"
 #include "quote.h"
diff --git a/builtin/log.c b/builtin/log.c
index 350b35c556..ab381e529e 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -14,20 +14,20 @@
 #include "gettext.h"
 #include "hex.h"
 #include "refs.h"
-#include "object-name.h"
-#include "odb.h"
+#include "odb/object-name.h"
+#include "odb/odb.h"
 #include "odb/streaming.h"
 #include "pager.h"
 #include "color.h"
-#include "commit.h"
+#include "odb/commit.h"
 #include "diff.h"
 #include "diffcore.h"
 #include "diff-merges.h"
 #include "revision.h"
 #include "log-tree.h"
-#include "oid-array.h"
-#include "oidset.h"
-#include "tag.h"
+#include "odb/oid-array.h"
+#include "odb/oidset.h"
+#include "odb/tag.h"
 #include "reflog-walk.h"
 #include "patch-ids.h"
 #include "path.h"
@@ -40,15 +40,15 @@
 #include "version.h"
 #include "mailmap.h"
 #include "progress.h"
-#include "commit-slab.h"
+#include "odb/commit-slab.h"
 #include "advice.h"
 #include "utf8.h"
 
 #include "commit-reach.h"
 #include "promisor-remote.h"
 #include "range-diff.h"
-#include "tmp-objdir.h"
-#include "tree.h"
+#include "odb/tmp-objdir.h"
+#include "odb/tree.h"
 #include "userdiff.h"
 #include "write-or-die.h"
 
diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index b044520f9e..fc3f8f4a72 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -15,7 +15,7 @@
 #include "quote.h"
 #include "dir.h"
 #include "gettext.h"
-#include "object-name.h"
+#include "odb/object-name.h"
 #include "strbuf.h"
 #include "parse-options.h"
 #include "resolve-undo.h"
@@ -26,7 +26,7 @@
 #include "setup.h"
 #include "sparse-index.h"
 #include "submodule.h"
-#include "odb.h"
+#include "odb/odb.h"
 #include "hex.h"
 
 
diff --git a/builtin/ls-tree.c b/builtin/ls-tree.c
index 46edaffc2e..4f7d1d2b6d 100644
--- a/builtin/ls-tree.c
+++ b/builtin/ls-tree.c
@@ -10,9 +10,9 @@
 #include "environment.h"
 #include "gettext.h"
 #include "hex.h"
-#include "object-name.h"
-#include "odb.h"
-#include "tree.h"
+#include "odb/object-name.h"
+#include "odb/odb.h"
+#include "odb/tree.h"
 #include "path.h"
 #include "quote.h"
 #include "parse-options.h"
diff --git a/builtin/merge-base.c b/builtin/merge-base.c
index a87011c6cd..191e4e7fa0 100644
--- a/builtin/merge-base.c
+++ b/builtin/merge-base.c
@@ -1,11 +1,11 @@
 #define USE_THE_REPOSITORY_VARIABLE
 #include "builtin.h"
 #include "config.h"
-#include "commit.h"
+#include "odb/commit.h"
 #include "environment.h"
 #include "gettext.h"
 #include "hex.h"
-#include "object-name.h"
+#include "odb/object-name.h"
 #include "parse-options.h"
 #include "commit-reach.h"
 
diff --git a/builtin/merge-file.c b/builtin/merge-file.c
index 8fa5765239..22a6862a13 100644
--- a/builtin/merge-file.c
+++ b/builtin/merge-file.c
@@ -5,9 +5,9 @@
 #include "abspath.h"
 #include "diff.h"
 #include "hex.h"
-#include "object-file.h"
-#include "object-name.h"
-#include "odb.h"
+#include "odb/object-file.h"
+#include "odb/object-name.h"
+#include "odb/odb.h"
 #include "config.h"
 #include "gettext.h"
 #include "setup.h"
diff --git a/builtin/merge-recursive.c b/builtin/merge-recursive.c
index 17aa4db37a..2e7bef9ee4 100644
--- a/builtin/merge-recursive.c
+++ b/builtin/merge-recursive.c
@@ -2,9 +2,9 @@
 #include "builtin.h"
 #include "advice.h"
 #include "gettext.h"
-#include "hash.h"
+#include "odb/hash.h"
 #include "merge-ort-wrappers.h"
-#include "object-name.h"
+#include "odb/object-name.h"
 
 static const char builtin_merge_recursive_usage[] =
 	"git %s <base>... -- <head> <remote> ...";
diff --git a/builtin/merge-tree.c b/builtin/merge-tree.c
index 49f41e520f..27f2944ece 100644
--- a/builtin/merge-tree.c
+++ b/builtin/merge-tree.c
@@ -2,21 +2,21 @@
 
 #include "builtin.h"
 #include "environment.h"
-#include "tree-walk.h"
+#include "odb/tree-walk.h"
 #include "xdiff-interface.h"
 #include "help.h"
 #include "gettext.h"
 #include "hex.h"
-#include "commit.h"
+#include "odb/commit.h"
 #include "commit-reach.h"
 #include "merge-ort.h"
-#include "object-name.h"
-#include "odb.h"
+#include "odb/object-name.h"
+#include "odb/odb.h"
 #include "parse-options.h"
-#include "blob.h"
+#include "odb/blob.h"
 #include "merge-blobs.h"
 #include "quote.h"
-#include "tree.h"
+#include "odb/tree.h"
 #include "config.h"
 #include "strvec.h"
 #include "write-or-die.h"
diff --git a/builtin/merge.c b/builtin/merge.c
index 5b4eb23a83..56f89b2944 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -18,7 +18,7 @@
 #include "environment.h"
 #include "gettext.h"
 #include "hex.h"
-#include "object-name.h"
+#include "odb/object-name.h"
 #include "parse-options.h"
 #include "lockfile.h"
 #include "repository.h"
@@ -28,7 +28,7 @@
 #include "diff-merges.h"
 #include "refs.h"
 #include "refspec.h"
-#include "commit.h"
+#include "odb/commit.h"
 #include "diffcore.h"
 #include "path.h"
 #include "revision.h"
@@ -45,7 +45,7 @@
 #include "fmt-merge-msg.h"
 #include "sequencer.h"
 #include "string-list.h"
-#include "tag.h"
+#include "odb/tag.h"
 #include "alias.h"
 #include "branch.h"
 #include "commit-reach.h"
diff --git a/builtin/mktag.c b/builtin/mktag.c
index 37c17e6beb..eb25acc4a5 100644
--- a/builtin/mktag.c
+++ b/builtin/mktag.c
@@ -4,10 +4,10 @@
 #include "hex.h"
 #include "parse-options.h"
 #include "strbuf.h"
-#include "replace-object.h"
-#include "object-file.h"
-#include "odb.h"
-#include "fsck.h"
+#include "odb/replace-object.h"
+#include "odb/object-file.h"
+#include "odb/odb.h"
+#include "odb/fsck.h"
 #include "config.h"
 
 static char const * const builtin_mktag_usage[] = {
diff --git a/builtin/mktree.c b/builtin/mktree.c
index 4084e32476..fc414d5b31 100644
--- a/builtin/mktree.c
+++ b/builtin/mktree.c
@@ -8,10 +8,10 @@
 #include "hex.h"
 #include "quote.h"
 #include "strbuf.h"
-#include "tree.h"
+#include "odb/tree.h"
 #include "parse-options.h"
-#include "object-file.h"
-#include "odb.h"
+#include "odb/object-file.h"
+#include "odb/odb.h"
 
 static struct treeent {
 	unsigned mode;
diff --git a/builtin/multi-pack-index.c b/builtin/multi-pack-index.c
index 6e73c85cde..10af1beb5c 100644
--- a/builtin/multi-pack-index.c
+++ b/builtin/multi-pack-index.c
@@ -8,10 +8,10 @@
 #include "midx.h"
 #include "strbuf.h"
 #include "trace2.h"
-#include "odb.h"
+#include "odb/odb.h"
 #include "odb/source.h"
 #include "odb/source-files.h"
-#include "replace-object.h"
+#include "odb/replace-object.h"
 #include "repository.h"
 
 #define BUILTIN_MIDX_WRITE_USAGE \
diff --git a/builtin/mv.c b/builtin/mv.c
index 373d4aeba3..e347c100c0 100644
--- a/builtin/mv.c
+++ b/builtin/mv.c
@@ -14,7 +14,7 @@
 #include "environment.h"
 #include "gettext.h"
 #include "name-hash.h"
-#include "object-file.h"
+#include "odb/object-file.h"
 #include "path.h"
 #include "pathspec.h"
 #include "lockfile.h"
diff --git a/builtin/name-rev.c b/builtin/name-rev.c
index 60cbbfb4b7..d2870bd37c 100644
--- a/builtin/name-rev.c
+++ b/builtin/name-rev.c
@@ -6,14 +6,14 @@
 #include "gettext.h"
 #include "hex.h"
 #include "config.h"
-#include "commit.h"
-#include "tag.h"
+#include "odb/commit.h"
+#include "odb/tag.h"
 #include "refs.h"
-#include "object-name.h"
+#include "odb/object-name.h"
 #include "pager.h"
 #include "parse-options.h"
-#include "hash-lookup.h"
-#include "commit-slab.h"
+#include "odb/hash-lookup.h"
+#include "odb/commit-slab.h"
 #include "commit-graph.h"
 #include "wildmatch.h"
 #include "mem-pool.h"
diff --git a/builtin/notes.c b/builtin/notes.c
index 9f1f0ec840..2cf1437346 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -14,9 +14,9 @@
 #include "gettext.h"
 #include "hex.h"
 #include "notes.h"
-#include "object-file.h"
-#include "object-name.h"
-#include "odb.h"
+#include "odb/object-file.h"
+#include "odb/object-name.h"
+#include "odb/odb.h"
 #include "path.h"
 
 #include "pretty.h"
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 1ec5b6f206..3e4c5442dc 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -7,14 +7,14 @@
 #include "hex.h"
 #include "config.h"
 #include "attr.h"
-#include "object.h"
-#include "commit.h"
-#include "tag.h"
+#include "odb/object.h"
+#include "odb/commit.h"
+#include "odb/tag.h"
 #include "delta.h"
 #include "pack.h"
 #include "pack-revindex.h"
 #include "csum-file.h"
-#include "tree-walk.h"
+#include "odb/tree-walk.h"
 #include "diff.h"
 #include "revision.h"
 #include "list-objects.h"
@@ -26,16 +26,16 @@
 #include "pack-bitmap.h"
 #include "delta-islands.h"
 #include "reachable.h"
-#include "oid-array.h"
+#include "odb/oid-array.h"
 #include "strvec.h"
 #include "strmap.h"
 #include "list.h"
 #include "packfile.h"
-#include "object-file.h"
-#include "object-file-convert.h"
-#include "odb.h"
+#include "odb/object-file.h"
+#include "odb/object-file-convert.h"
+#include "odb/odb.h"
 #include "odb/streaming.h"
-#include "replace-object.h"
+#include "odb/replace-object.h"
 #include "dir.h"
 #include "midx.h"
 #include "trace2.h"
@@ -44,8 +44,8 @@
 #include "pack-mtimes.h"
 #include "parse-options.h"
 #include "pkt-line.h"
-#include "blob.h"
-#include "tree.h"
+#include "odb/blob.h"
+#include "odb/tree.h"
 #include "path-walk.h"
 
 /*
diff --git a/builtin/pack-redundant.c b/builtin/pack-redundant.c
index 86749bb7e7..10e1ce6ab5 100644
--- a/builtin/pack-redundant.c
+++ b/builtin/pack-redundant.c
@@ -13,7 +13,7 @@
 #include "hex.h"
 
 #include "packfile.h"
-#include "odb.h"
+#include "odb/odb.h"
 #include "strbuf.h"
 
 #define BLKSIZE 512
diff --git a/builtin/patch-id.c b/builtin/patch-id.c
index 22f36ecf80..e2c1375b41 100644
--- a/builtin/patch-id.c
+++ b/builtin/patch-id.c
@@ -5,7 +5,7 @@
 #include "diff.h"
 #include "environment.h"
 #include "gettext.h"
-#include "hash.h"
+#include "odb/hash.h"
 #include "hex.h"
 #include "parse-options.h"
 #include "setup.h"
diff --git a/builtin/prune.c b/builtin/prune.c
index 55635a891f..301f59e897 100644
--- a/builtin/prune.c
+++ b/builtin/prune.c
@@ -1,7 +1,7 @@
 #define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "builtin.h"
-#include "commit.h"
+#include "odb/commit.h"
 #include "diff.h"
 #include "dir.h"
 #include "environment.h"
@@ -13,10 +13,10 @@
 #include "path.h"
 #include "progress.h"
 #include "prune-packed.h"
-#include "replace-object.h"
-#include "object-file.h"
-#include "object-name.h"
-#include "odb.h"
+#include "odb/replace-object.h"
+#include "odb/object-file.h"
+#include "odb/object-name.h"
+#include "odb/odb.h"
 #include "shallow.h"
 
 static const char * const prune_usage[] = {
diff --git a/builtin/pull.c b/builtin/pull.c
index db3ee0aab3..cb3d76cb16 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -15,10 +15,10 @@
 #include "gettext.h"
 #include "hex.h"
 #include "merge.h"
-#include "object-name.h"
+#include "odb/object-name.h"
 #include "parse-options.h"
 #include "run-command.h"
-#include "oid-array.h"
+#include "odb/oid-array.h"
 #include "remote.h"
 #include "dir.h"
 #include "path.h"
diff --git a/builtin/range-diff.c b/builtin/range-diff.c
index e54c0f7fe1..7e37a00d9e 100644
--- a/builtin/range-diff.c
+++ b/builtin/range-diff.c
@@ -2,7 +2,7 @@
 
 #include "builtin.h"
 #include "gettext.h"
-#include "object-name.h"
+#include "odb/object-name.h"
 #include "parse-options.h"
 #include "range-diff.h"
 #include "config.h"
diff --git a/builtin/read-tree.c b/builtin/read-tree.c
index 999a82ecdf..8898354baa 100644
--- a/builtin/read-tree.c
+++ b/builtin/read-tree.c
@@ -10,10 +10,10 @@
 #include "gettext.h"
 #include "hex.h"
 #include "lockfile.h"
-#include "object.h"
-#include "object-name.h"
-#include "tree.h"
-#include "tree-walk.h"
+#include "odb/object.h"
+#include "odb/object-name.h"
+#include "odb/tree.h"
+#include "odb/tree-walk.h"
 #include "cache-tree.h"
 #include "unpack-trees.h"
 #include "parse-options.h"
diff --git a/builtin/rebase.c b/builtin/rebase.c
index 10a306310c..7b8366e5cd 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -20,11 +20,11 @@
 #include "config.h"
 #include "unpack-trees.h"
 #include "lockfile.h"
-#include "object-file.h"
-#include "object-name.h"
+#include "odb/object-file.h"
+#include "odb/object-name.h"
 #include "parse-options.h"
 #include "path.h"
-#include "commit.h"
+#include "odb/commit.h"
 #include "diff.h"
 #include "wt-status.h"
 #include "revision.h"
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 86933d8d7e..5ec79a4595 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -3,25 +3,25 @@
 
 #include "builtin.h"
 #include "abspath.h"
-#include "commit.h"
+#include "odb/commit.h"
 #include "commit-reach.h"
 #include "config.h"
 #include "connect.h"
 #include "connected.h"
 #include "environment.h"
 #include "exec-cmd.h"
-#include "fsck.h"
+#include "odb/fsck.h"
 #include "gettext.h"
 #include "gpg-interface.h"
 #include "hex.h"
 #include "hook.h"
 #include "lockfile.h"
-#include "object.h"
-#include "object-file.h"
-#include "object-name.h"
-#include "odb.h"
-#include "oid-array.h"
-#include "oidset.h"
+#include "odb/object.h"
+#include "odb/object-file.h"
+#include "odb/object-name.h"
+#include "odb/odb.h"
+#include "odb/oid-array.h"
+#include "odb/oidset.h"
 #include "pack.h"
 #include "packfile.h"
 #include "parse-options.h"
diff --git a/builtin/reflog.c b/builtin/reflog.c
index 1211c58fa4..b709cb0e3c 100644
--- a/builtin/reflog.c
+++ b/builtin/reflog.c
@@ -4,7 +4,7 @@
 #include "config.h"
 #include "gettext.h"
 #include "hex.h"
-#include "odb.h"
+#include "odb/odb.h"
 #include "revision.h"
 #include "reachable.h"
 #include "wildmatch.h"
diff --git a/builtin/refs.c b/builtin/refs.c
index 5cd21c25fe..37936353be 100644
--- a/builtin/refs.c
+++ b/builtin/refs.c
@@ -1,6 +1,6 @@
 #include "builtin.h"
 #include "config.h"
-#include "fsck.h"
+#include "odb/fsck.h"
 #include "pack-refs.h"
 #include "parse-options.h"
 #include "refs.h"
diff --git a/builtin/remote.c b/builtin/remote.c
index de989ea3ba..b5b54ded27 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -16,7 +16,7 @@
 #include "rebase.h"
 #include "refs.h"
 #include "refspec.h"
-#include "odb.h"
+#include "odb/odb.h"
 #include "strvec.h"
 #include "commit-reach.h"
 #include "progress.h"
diff --git a/builtin/replace.c b/builtin/replace.c
index aed6b2c8de..793226006c 100644
--- a/builtin/replace.c
+++ b/builtin/replace.c
@@ -18,11 +18,11 @@
 #include "parse-options.h"
 #include "path.h"
 #include "run-command.h"
-#include "object-file.h"
-#include "object-name.h"
-#include "odb.h"
-#include "replace-object.h"
-#include "tag.h"
+#include "odb/object-file.h"
+#include "odb/object-name.h"
+#include "odb/odb.h"
+#include "odb/replace-object.h"
+#include "odb/tag.h"
 #include "wildmatch.h"
 
 static const char * const git_replace_usage[] = {
diff --git a/builtin/replay.c b/builtin/replay.c
index 39e3a86f6c..4ea7c42215 100644
--- a/builtin/replay.c
+++ b/builtin/replay.c
@@ -7,7 +7,7 @@
 #include "builtin.h"
 #include "config.h"
 #include "hex.h"
-#include "object-name.h"
+#include "odb/object-name.h"
 #include "parse-options.h"
 #include "refs.h"
 #include "replay.h"
diff --git a/builtin/repo.c b/builtin/repo.c
index 84e012f83f..473072b44d 100644
--- a/builtin/repo.c
+++ b/builtin/repo.c
@@ -1,11 +1,11 @@
 #define USE_THE_REPOSITORY_VARIABLE
 
 #include "builtin.h"
-#include "commit.h"
+#include "odb/commit.h"
 #include "environment.h"
-#include "hash.h"
+#include "odb/hash.h"
 #include "hex.h"
-#include "odb.h"
+#include "odb/odb.h"
 #include "parse-options.h"
 #include "path.h"
 #include "path-walk.h"
@@ -18,8 +18,8 @@
 #include "strbuf.h"
 #include "string-list.h"
 #include "shallow.h"
-#include "tree.h"
-#include "tree-walk.h"
+#include "odb/tree.h"
+#include "odb/tree-walk.h"
 #include "utf8.h"
 
 #define REPO_INFO_USAGE \
diff --git a/builtin/reset.c b/builtin/reset.c
index 78e69bd84b..55539f565c 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -15,17 +15,17 @@
 #include "config.h"
 #include "environment.h"
 #include "gettext.h"
-#include "hash.h"
+#include "odb/hash.h"
 #include "hex.h"
 #include "lockfile.h"
-#include "object.h"
+#include "odb/object.h"
 #include "pretty.h"
 #include "refs.h"
 #include "diff.h"
 #include "diffcore.h"
-#include "tree.h"
+#include "odb/tree.h"
 #include "branch.h"
-#include "object-name.h"
+#include "odb/object-name.h"
 #include "parse-options.h"
 #include "path.h"
 #include "repository.h"
diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index 02818b81c6..0c55dc5b96 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -3,7 +3,7 @@
 
 #include "builtin.h"
 #include "config.h"
-#include "commit.h"
+#include "odb/commit.h"
 #include "diff.h"
 #include "environment.h"
 #include "gettext.h"
@@ -11,10 +11,10 @@
 #include "revision.h"
 #include "list-objects.h"
 #include "list-objects-filter-options.h"
-#include "object.h"
-#include "object-name.h"
-#include "object-file.h"
-#include "odb.h"
+#include "odb/object.h"
+#include "odb/object-name.h"
+#include "odb/object-file.h"
+#include "odb/odb.h"
 #include "pack-bitmap.h"
 #include "parse-options.h"
 #include "log-tree.h"
@@ -22,8 +22,8 @@
 #include "bisect.h"
 #include "progress.h"
 #include "reflog-walk.h"
-#include "oidset.h"
-#include "oidmap.h"
+#include "odb/oidset.h"
+#include "odb/oidmap.h"
 #include "packfile.h"
 #include "commit-reach.h"
 #include "quote.h"
diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index 43693454d5..f3bf7831b7 100644
--- a/builtin/rev-parse.c
+++ b/builtin/rev-parse.c
@@ -12,14 +12,14 @@
 #include "abspath.h"
 #include "bisect.h"
 #include "config.h"
-#include "commit.h"
+#include "odb/commit.h"
 #include "environment.h"
 #include "gettext.h"
-#include "hash.h"
+#include "odb/hash.h"
 #include "hex.h"
 #include "refs.h"
 #include "quote.h"
-#include "object-name.h"
+#include "odb/object-name.h"
 #include "parse-options.h"
 #include "path.h"
 #include "diff.h"
@@ -32,7 +32,7 @@
 #include "submodule.h"
 #include "commit-reach.h"
 #include "shallow.h"
-#include "object-file-convert.h"
+#include "odb/object-file-convert.h"
 
 #define DO_REVS		1
 #define DO_NOREV	2
diff --git a/builtin/rm.c b/builtin/rm.c
index 081d0bc375..c856b88d09 100644
--- a/builtin/rm.c
+++ b/builtin/rm.c
@@ -13,9 +13,9 @@
 #include "lockfile.h"
 #include "dir.h"
 #include "gettext.h"
-#include "hash.h"
-#include "tree-walk.h"
-#include "object-name.h"
+#include "odb/hash.h"
+#include "odb/tree-walk.h"
+#include "odb/object-name.h"
 #include "parse-options.h"
 #include "read-cache.h"
 
diff --git a/builtin/send-pack.c b/builtin/send-pack.c
index d6cdbae472..2597a47bde 100644
--- a/builtin/send-pack.c
+++ b/builtin/send-pack.c
@@ -9,7 +9,7 @@
 #include "send-pack.h"
 #include "quote.h"
 #include "transport.h"
-#include "oid-array.h"
+#include "odb/oid-array.h"
 #include "gettext.h"
 #include "protocol.h"
 #include "parse-options.h"
diff --git a/builtin/shortlog.c b/builtin/shortlog.c
index 4c78d2e5ba..cbcf2fb637 100644
--- a/builtin/shortlog.c
+++ b/builtin/shortlog.c
@@ -2,7 +2,7 @@
 
 #include "builtin.h"
 #include "config.h"
-#include "commit.h"
+#include "odb/commit.h"
 #include "diff.h"
 #include "environment.h"
 #include "gettext.h"
diff --git a/builtin/show-branch.c b/builtin/show-branch.c
index 2435e8aeda..c58abc872f 100644
--- a/builtin/show-branch.c
+++ b/builtin/show-branch.c
@@ -5,17 +5,17 @@
 #include "config.h"
 #include "environment.h"
 #include "gettext.h"
-#include "hash.h"
+#include "odb/hash.h"
 #include "hex.h"
 #include "pretty.h"
 #include "refs.h"
 #include "color.h"
 #include "strvec.h"
-#include "object-name.h"
+#include "odb/object-name.h"
 #include "parse-options.h"
 
 #include "dir.h"
-#include "commit-slab.h"
+#include "odb/commit-slab.h"
 #include "date.h"
 #include "wildmatch.h"
 #include "prio-queue.h"
diff --git a/builtin/show-index.c b/builtin/show-index.c
index 24f0230967..55c3c409ae 100644
--- a/builtin/show-index.c
+++ b/builtin/show-index.c
@@ -3,7 +3,7 @@
 
 #include "builtin.h"
 #include "gettext.h"
-#include "hash.h"
+#include "odb/hash.h"
 #include "hex.h"
 #include "pack.h"
 #include "parse-options.h"
diff --git a/builtin/show-ref.c b/builtin/show-ref.c
index d508441632..e4b186b930 100644
--- a/builtin/show-ref.c
+++ b/builtin/show-ref.c
@@ -5,9 +5,9 @@
 #include "gettext.h"
 #include "hex.h"
 #include "refs/refs-internal.h"
-#include "object-name.h"
-#include "odb.h"
-#include "object.h"
+#include "odb/object-name.h"
+#include "odb/odb.h"
+#include "odb/object.h"
 #include "string-list.h"
 #include "parse-options.h"
 
diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
index cb4a037b77..e2186fdd33 100644
--- a/builtin/sparse-checkout.c
+++ b/builtin/sparse-checkout.c
@@ -7,8 +7,8 @@
 #include "dir.h"
 #include "environment.h"
 #include "gettext.h"
-#include "object-file.h"
-#include "object-name.h"
+#include "odb/object-file.h"
+#include "odb/object-name.h"
 #include "parse-options.h"
 #include "path.h"
 #include "pathspec.h"
diff --git a/builtin/stash.c b/builtin/stash.c
index 72c52571f8..2af975aaff 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -5,9 +5,9 @@
 #include "config.h"
 #include "environment.h"
 #include "gettext.h"
-#include "hash.h"
+#include "odb/hash.h"
 #include "hex.h"
-#include "object-name.h"
+#include "odb/object-name.h"
 #include "parse-options.h"
 #include "refs.h"
 #include "lockfile.h"
@@ -30,8 +30,8 @@
 #include "reflog.h"
 #include "reflog-walk.h"
 #include "add-interactive.h"
-#include "oid-array.h"
-#include "commit.h"
+#include "odb/oid-array.h"
+#include "odb/commit.h"
 
 #define INCLUDE_ALL_FILES 2
 
diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index e7cd3225fa..96c83476df 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -26,9 +26,9 @@
 #include "revision.h"
 #include "diffcore.h"
 #include "diff.h"
-#include "object-file.h"
-#include "object-name.h"
-#include "odb.h"
+#include "odb/object-file.h"
+#include "odb/object-name.h"
+#include "odb/odb.h"
 #include "odb/source.h"
 #include "advice.h"
 #include "branch.h"
diff --git a/builtin/tag.c b/builtin/tag.c
index 06c125b53c..e3eee35e88 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -17,21 +17,21 @@
 #include "gettext.h"
 #include "hex.h"
 #include "refs.h"
-#include "object-file.h"
-#include "object-name.h"
-#include "odb.h"
+#include "odb/object-file.h"
+#include "odb/object-name.h"
+#include "odb/odb.h"
 #include "path.h"
-#include "tag.h"
+#include "odb/tag.h"
 #include "parse-options.h"
 #include "diff.h"
 #include "revision.h"
 #include "gpg-interface.h"
-#include "oid-array.h"
+#include "odb/oid-array.h"
 #include "column.h"
 #include "ref-filter.h"
 #include "date.h"
 #include "write-or-die.h"
-#include "object-file-convert.h"
+#include "odb/object-file-convert.h"
 #include "trailer.h"
 
 static const char * const git_tag_usage[] = {
diff --git a/builtin/unpack-file.c b/builtin/unpack-file.c
index 387389ed49..47f43f5a87 100644
--- a/builtin/unpack-file.c
+++ b/builtin/unpack-file.c
@@ -3,9 +3,9 @@
 #include "config.h"
 #include "environment.h"
 #include "hex.h"
-#include "object-file.h"
-#include "object-name.h"
-#include "odb.h"
+#include "odb/object-file.h"
+#include "odb/object-name.h"
+#include "odb/odb.h"
 
 static char *create_temp_file(struct object_id *oid)
 {
diff --git a/builtin/unpack-objects.c b/builtin/unpack-objects.c
index 4263edfbec..e5891809dd 100644
--- a/builtin/unpack-objects.c
+++ b/builtin/unpack-objects.c
@@ -7,19 +7,19 @@
 #include "gettext.h"
 #include "git-zlib.h"
 #include "hex.h"
-#include "object-file.h"
-#include "odb.h"
+#include "odb/object-file.h"
+#include "odb/odb.h"
 #include "odb/streaming.h"
 #include "odb/transaction.h"
-#include "object.h"
+#include "odb/object.h"
 #include "delta.h"
 #include "pack.h"
-#include "blob.h"
-#include "replace-object.h"
+#include "odb/blob.h"
+#include "odb/replace-object.h"
 #include "strbuf.h"
 #include "progress.h"
 #include "decorate.h"
-#include "fsck.h"
+#include "odb/fsck.h"
 #include "packfile.h"
 
 static int dry_run, quiet, recover, has_errors, strict;
diff --git a/builtin/update-index.c b/builtin/update-index.c
index 241abd4332..992f496efd 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -11,14 +11,14 @@
 #include "config.h"
 #include "environment.h"
 #include "gettext.h"
-#include "hash.h"
+#include "odb/hash.h"
 #include "hex.h"
 #include "lockfile.h"
 #include "quote.h"
 #include "cache-tree.h"
-#include "tree-walk.h"
-#include "object-file.h"
-#include "odb.h"
+#include "odb/tree-walk.h"
+#include "odb/object-file.h"
+#include "odb/odb.h"
 #include "odb/transaction.h"
 #include "refs.h"
 #include "resolve-undo.h"
diff --git a/builtin/update-ref.c b/builtin/update-ref.c
index 6355c3dd3e..e7ac68f495 100644
--- a/builtin/update-ref.c
+++ b/builtin/update-ref.c
@@ -5,10 +5,10 @@
 #include "config.h"
 #include "environment.h"
 #include "gettext.h"
-#include "hash.h"
+#include "odb/hash.h"
 #include "hex.h"
 #include "refs.h"
-#include "object-name.h"
+#include "odb/object-name.h"
 #include "parse-options.h"
 #include "quote.h"
 
diff --git a/builtin/upload-pack.c b/builtin/upload-pack.c
index 32831fb879..dc37ffb70c 100644
--- a/builtin/upload-pack.c
+++ b/builtin/upload-pack.c
@@ -6,11 +6,11 @@
 #include "pkt-line.h"
 #include "parse-options.h"
 #include "protocol.h"
-#include "replace-object.h"
+#include "odb/replace-object.h"
 #include "upload-pack.h"
 #include "serve.h"
 #include "setup.h"
-#include "commit.h"
+#include "odb/commit.h"
 #include "environment.h"
 
 static const char * const upload_pack_usage[] = {
diff --git a/builtin/verify-commit.c b/builtin/verify-commit.c
index 62398acd72..3ec03f016c 100644
--- a/builtin/verify-commit.c
+++ b/builtin/verify-commit.c
@@ -9,8 +9,8 @@
 #include "config.h"
 #include "environment.h"
 #include "gettext.h"
-#include "object-name.h"
-#include "commit.h"
+#include "odb/object-name.h"
+#include "odb/commit.h"
 #include "parse-options.h"
 #include "gpg-interface.h"
 
diff --git a/builtin/verify-tag.c b/builtin/verify-tag.c
index 4a261b2369..791679a4d8 100644
--- a/builtin/verify-tag.c
+++ b/builtin/verify-tag.c
@@ -9,8 +9,8 @@
 #include "config.h"
 #include "environment.h"
 #include "gettext.h"
-#include "tag.h"
-#include "object-name.h"
+#include "odb/tag.h"
+#include "odb/object-name.h"
 #include "parse-options.h"
 #include "gpg-interface.h"
 #include "ref-filter.h"
diff --git a/builtin/worktree.c b/builtin/worktree.c
index 654d27c3e1..7c2ed274f9 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -11,8 +11,8 @@
 #include "environment.h"
 #include "gettext.h"
 #include "hex.h"
-#include "object-file.h"
-#include "object-name.h"
+#include "odb/object-file.h"
+#include "odb/object-name.h"
 #include "parse-options.h"
 #include "path.h"
 #include "strvec.h"
diff --git a/builtin/write-tree.c b/builtin/write-tree.c
index e3bd1a40db..2e463ab394 100644
--- a/builtin/write-tree.c
+++ b/builtin/write-tree.c
@@ -9,7 +9,7 @@
 #include "environment.h"
 #include "gettext.h"
 #include "hex.h"
-#include "tree.h"
+#include "odb/tree.h"
 #include "cache-tree.h"
 #include "parse-options.h"
 
diff --git a/bundle-uri.c b/bundle-uri.c
index 2bb2eb99e4..948265330b 100644
--- a/bundle-uri.c
+++ b/bundle-uri.c
@@ -14,7 +14,7 @@
 #include "fetch-pack.h"
 #include "remote.h"
 #include "trace2.h"
-#include "odb.h"
+#include "odb/odb.h"
 
 static struct {
 	enum bundle_list_heuristic heuristic;
diff --git a/bundle.c b/bundle.c
index b64716f252..81d241e6d0 100644
--- a/bundle.c
+++ b/bundle.c
@@ -7,10 +7,10 @@
 #include "environment.h"
 #include "gettext.h"
 #include "hex.h"
-#include "odb.h"
+#include "odb/odb.h"
 #include "repository.h"
-#include "object.h"
-#include "commit.h"
+#include "odb/object.h"
+#include "odb/commit.h"
 #include "diff.h"
 #include "revision.h"
 #include "list-objects.h"
diff --git a/cache-tree.c b/cache-tree.c
index d92f513286..1c4295761a 100644
--- a/cache-tree.c
+++ b/cache-tree.c
@@ -5,14 +5,14 @@
 #include "gettext.h"
 #include "hex.h"
 #include "lockfile.h"
-#include "tree.h"
-#include "tree-walk.h"
+#include "odb/tree.h"
+#include "odb/tree-walk.h"
 #include "cache-tree.h"
-#include "object-file.h"
-#include "odb.h"
+#include "odb/object-file.h"
+#include "odb/odb.h"
 #include "odb/transaction.h"
 #include "read-cache-ll.h"
-#include "replace-object.h"
+#include "odb/replace-object.h"
 #include "repository.h"
 #include "promisor-remote.h"
 #include "trace.h"
diff --git a/cache-tree.h b/cache-tree.h
index f8bddae523..fbfa3691e1 100644
--- a/cache-tree.h
+++ b/cache-tree.h
@@ -1,8 +1,8 @@
 #ifndef CACHE_TREE_H
 #define CACHE_TREE_H
 
-#include "tree.h"
-#include "tree-walk.h"
+#include "odb/tree.h"
+#include "odb/tree-walk.h"
 
 struct cache_tree;
 struct cache_tree_sub {
diff --git a/checkout.c b/checkout.c
index 1588b116ee..966a70c267 100644
--- a/checkout.c
+++ b/checkout.c
@@ -1,7 +1,7 @@
 #define USE_THE_REPOSITORY_VARIABLE
 
 #include "git-compat-util.h"
-#include "object-name.h"
+#include "odb/object-name.h"
 #include "remote.h"
 #include "refspec.h"
 #include "repository.h"
diff --git a/checkout.h b/checkout.h
index 55920e7aeb..718e29080a 100644
--- a/checkout.h
+++ b/checkout.h
@@ -1,7 +1,7 @@
 #ifndef CHECKOUT_H
 #define CHECKOUT_H
 
-#include "hash.h"
+#include "odb/hash.h"
 
 /*
  * Check if the branch name uniquely matches a branch name on a remote
diff --git a/chunk-format.c b/chunk-format.c
index 51b5a2c959..08b90762d4 100644
--- a/chunk-format.c
+++ b/chunk-format.c
@@ -5,7 +5,7 @@
 #include "chunk-format.h"
 #include "csum-file.h"
 #include "gettext.h"
-#include "hash.h"
+#include "odb/hash.h"
 #include "trace2.h"
 
 /*
diff --git a/chunk-format.h b/chunk-format.h
index 212a0a6af1..e10fcdbfcb 100644
--- a/chunk-format.h
+++ b/chunk-format.h
@@ -1,7 +1,7 @@
 #ifndef CHUNK_FORMAT_H
 #define CHUNK_FORMAT_H
 
-#include "hash.h"
+#include "odb/hash.h"
 
 struct hashfile;
 struct chunkfile;
diff --git a/combine-diff.c b/combine-diff.c
index 717d537688..1c33937f21 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -2,22 +2,22 @@
 #define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "git-compat-util.h"
-#include "odb.h"
-#include "commit.h"
+#include "odb/odb.h"
+#include "odb/commit.h"
 #include "convert.h"
 #include "diff.h"
 #include "diffcore.h"
 #include "environment.h"
 #include "hex.h"
-#include "object-name.h"
+#include "odb/object-name.h"
 #include "quote.h"
 #include "xdiff-interface.h"
 #include "xdiff/xmacros.h"
 #include "log-tree.h"
 #include "refs.h"
-#include "tree.h"
+#include "odb/tree.h"
 #include "userdiff.h"
-#include "oid-array.h"
+#include "odb/oid-array.h"
 #include "revision.h"
 
 static int compare_paths(const struct combine_diff_path *one,
diff --git a/commit-graph.c b/commit-graph.c
index 49e8f63930..abf7c404b3 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -8,24 +8,24 @@
 #include "hex.h"
 #include "lockfile.h"
 #include "packfile.h"
-#include "commit.h"
-#include "object.h"
+#include "odb/commit.h"
+#include "odb/object.h"
 #include "refs.h"
-#include "hash-lookup.h"
+#include "odb/hash-lookup.h"
 #include "commit-graph.h"
-#include "odb.h"
-#include "oid-array.h"
+#include "odb/odb.h"
+#include "odb/oid-array.h"
 #include "path.h"
-#include "alloc.h"
+#include "odb/alloc.h"
 #include "hashmap.h"
-#include "replace-object.h"
+#include "odb/replace-object.h"
 #include "progress.h"
 #include "bloom.h"
-#include "commit-slab.h"
+#include "odb/commit-slab.h"
 #include "shallow.h"
 #include "json-writer.h"
 #include "trace2.h"
-#include "tree.h"
+#include "odb/tree.h"
 #include "chunk-format.h"
 
 void git_test_write_commit_graph_or_die(struct odb_source *source)
diff --git a/commit-graph.h b/commit-graph.h
index 13ca4ff010..69ecf99feb 100644
--- a/commit-graph.h
+++ b/commit-graph.h
@@ -1,8 +1,8 @@
 #ifndef COMMIT_GRAPH_H
 #define COMMIT_GRAPH_H
 
-#include "odb.h"
-#include "oidset.h"
+#include "odb/odb.h"
+#include "odb/oidset.h"
 
 #define GIT_TEST_COMMIT_GRAPH "GIT_TEST_COMMIT_GRAPH"
 #define GIT_TEST_COMMIT_GRAPH_DIE_ON_PARSE "GIT_TEST_COMMIT_GRAPH_DIE_ON_PARSE"
diff --git a/commit-reach.c b/commit-reach.c
index b53c6b1cdf..9b4715fd65 100644
--- a/commit-reach.c
+++ b/commit-reach.c
@@ -1,14 +1,14 @@
 #define USE_THE_REPOSITORY_VARIABLE
 
 #include "git-compat-util.h"
-#include "commit.h"
+#include "odb/commit.h"
 #include "commit-graph.h"
 #include "decorate.h"
 #include "hex.h"
 #include "prio-queue.h"
 #include "ref-filter.h"
 #include "revision.h"
-#include "tag.h"
+#include "odb/tag.h"
 #include "commit-reach.h"
 #include "ewah/ewok.h"
 
diff --git a/commit-reach.h b/commit-reach.h
index f908d305b1..5d27ef9889 100644
--- a/commit-reach.h
+++ b/commit-reach.h
@@ -1,8 +1,8 @@
 #ifndef COMMIT_REACH_H
 #define COMMIT_REACH_H
 
-#include "commit.h"
-#include "commit-slab.h"
+#include "odb/commit.h"
+#include "odb/commit-slab.h"
 
 struct commit_list;
 struct ref_filter;
diff --git a/common-init.c b/common-init.c
index d26c9c1f20..7e6b392800 100644
--- a/common-init.c
+++ b/common-init.c
@@ -5,10 +5,10 @@
 #include "exec-cmd.h"
 #include "gettext.h"
 #include "attr.h"
-#include "odb.h"
+#include "odb/odb.h"
 #include "parse.h"
 #include "repository.h"
-#include "replace-object.h"
+#include "odb/replace-object.h"
 #include "setup.h"
 #include "strbuf.h"
 #include "trace2.h"
diff --git a/compat/mingw.c b/compat/mingw.c
index 4c2f26d454..785de5beb7 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -3,7 +3,7 @@
 
 #include "git-compat-util.h"
 #include "abspath.h"
-#include "alloc.h"
+#include "odb/alloc.h"
 #include "config.h"
 #include "dir.h"
 #include "environment.h"
diff --git a/compat/sha1-chunked.c b/compat/sha1-chunked.c
index 0446f9983f..30a0d96e92 100644
--- a/compat/sha1-chunked.c
+++ b/compat/sha1-chunked.c
@@ -1,5 +1,5 @@
 #include "git-compat-util.h"
-#include "hash.h"
+#include "odb/hash.h"
 
 int git_SHA1_Update_Chunked(platform_SHA_CTX *c, const void *data, size_t len)
 {
diff --git a/config.c b/config.c
index 1bdd702e7a..eacc6847a2 100644
--- a/config.c
+++ b/config.c
@@ -25,8 +25,8 @@
 #include "quote.h"
 #include "hashmap.h"
 #include "string-list.h"
-#include "object-name.h"
-#include "odb.h"
+#include "odb/object-name.h"
+#include "odb/odb.h"
 #include "path.h"
 #include "utf8.h"
 #include "color.h"
diff --git a/connect.c b/connect.c
index feb0420b0f..e54c88f5e2 100644
--- a/connect.c
+++ b/connect.c
@@ -13,7 +13,7 @@
 #include "connect.h"
 #include "url.h"
 #include "string-list.h"
-#include "oid-array.h"
+#include "odb/oid-array.h"
 #include "path.h"
 #include "transport.h"
 #include "trace2.h"
diff --git a/connected.c b/connected.c
index 929b9bd28d..1aafa86101 100644
--- a/connected.c
+++ b/connected.c
@@ -3,7 +3,7 @@
 #include "git-compat-util.h"
 #include "gettext.h"
 #include "hex.h"
-#include "odb.h"
+#include "odb/odb.h"
 #include "run-command.h"
 #include "sigchain.h"
 #include "connected.h"
diff --git a/convert.c b/convert.c
index 036506842c..25c800eea2 100644
--- a/convert.c
+++ b/convert.c
@@ -8,7 +8,7 @@
 #include "copy.h"
 #include "gettext.h"
 #include "hex.h"
-#include "object-file.h"
+#include "odb/object-file.h"
 #include "attr.h"
 #include "run-command.h"
 #include "quote.h"
diff --git a/convert.h b/convert.h
index 0a6e4086b8..dc6a49dc7d 100644
--- a/convert.h
+++ b/convert.h
@@ -4,7 +4,7 @@
 #ifndef CONVERT_H
 #define CONVERT_H
 
-#include "hash.h"
+#include "odb/hash.h"
 #include "string-list.h"
 
 struct index_state;
diff --git a/csum-file.c b/csum-file.c
index fe18ee1de3..483608d1ec 100644
--- a/csum-file.c
+++ b/csum-file.c
@@ -11,7 +11,7 @@
 #include "git-compat-util.h"
 #include "csum-file.h"
 #include "git-zlib.h"
-#include "hash.h"
+#include "odb/hash.h"
 #include "progress.h"
 
 static void verify_buffer_or_die(struct hashfile *f,
diff --git a/csum-file.h b/csum-file.h
index 6ed74d1637..dd7aeb2813 100644
--- a/csum-file.h
+++ b/csum-file.h
@@ -1,7 +1,7 @@
 #ifndef CSUM_FILE_H
 #define CSUM_FILE_H
 
-#include "hash.h"
+#include "odb/hash.h"
 #include "write-or-die.h"
 
 struct progress;
diff --git a/decorate.c b/decorate.c
index 9f24925263..262c9198eb 100644
--- a/decorate.c
+++ b/decorate.c
@@ -4,7 +4,7 @@
  */
 
 #include "git-compat-util.h"
-#include "object.h"
+#include "odb/object.h"
 #include "decorate.h"
 
 static unsigned int hash_obj(const struct object *obj, unsigned int n)
diff --git a/delta-islands.c b/delta-islands.c
index e71a7e1c05..0c0d222ab3 100644
--- a/delta-islands.c
+++ b/delta-islands.c
@@ -1,14 +1,14 @@
 #define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "git-compat-util.h"
-#include "object.h"
-#include "commit.h"
+#include "odb/object.h"
+#include "odb/commit.h"
 #include "gettext.h"
 #include "hex.h"
-#include "tag.h"
-#include "tree.h"
+#include "odb/tag.h"
+#include "odb/tree.h"
 #include "pack.h"
-#include "tree-walk.h"
+#include "odb/tree-walk.h"
 #include "diff.h"
 #include "progress.h"
 #include "refs.h"
@@ -16,7 +16,7 @@
 #include "pack-bitmap.h"
 #include "pack-objects.h"
 #include "delta-islands.h"
-#include "oid-array.h"
+#include "odb/oid-array.h"
 #include "config.h"
 
 KHASH_INIT(str, const char *, void *, 1, kh_str_hash_func, kh_str_hash_equal)
diff --git a/diagnose.c b/diagnose.c
index 5092bf80d3..6858f39f45 100644
--- a/diagnose.c
+++ b/diagnose.c
@@ -7,7 +7,7 @@
 #include "gettext.h"
 #include "hex.h"
 #include "strvec.h"
-#include "odb.h"
+#include "odb/odb.h"
 #include "packfile.h"
 #include "parse-options.h"
 #include "repository.h"
diff --git a/diff-lib.c b/diff-lib.c
index 086476bd77..313b6136b1 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -6,13 +6,13 @@
 #define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "git-compat-util.h"
-#include "commit.h"
+#include "odb/commit.h"
 #include "diff.h"
 #include "diffcore.h"
 #include "gettext.h"
-#include "hash.h"
+#include "odb/hash.h"
 #include "hex.h"
-#include "object-name.h"
+#include "odb/object-name.h"
 #include "read-cache.h"
 #include "revision.h"
 #include "cache-tree.h"
diff --git a/diff-no-index.c b/diff-no-index.c
index f320424f05..552cd95679 100644
--- a/diff-no-index.c
+++ b/diff-no-index.c
@@ -9,7 +9,7 @@
 #include "git-compat-util.h"
 #include "abspath.h"
 #include "color.h"
-#include "commit.h"
+#include "odb/commit.h"
 #include "diff.h"
 #include "diffcore.h"
 #include "gettext.h"
diff --git a/diff.c b/diff.c
index cfe515af4e..22265895a7 100644
--- a/diff.c
+++ b/diff.c
@@ -23,7 +23,7 @@
 #include "color.h"
 #include "run-command.h"
 #include "utf8.h"
-#include "odb.h"
+#include "odb/odb.h"
 #include "userdiff.h"
 #include "submodule.h"
 #include "hashmap.h"
@@ -31,17 +31,17 @@
 #include "merge-ll.h"
 #include "string-list.h"
 #include "strvec.h"
-#include "tmp-objdir.h"
+#include "odb/tmp-objdir.h"
 #include "graph.h"
-#include "oid-array.h"
+#include "odb/oid-array.h"
 #include "packfile.h"
 #include "pager.h"
 #include "parse-options.h"
 #include "help.h"
 #include "promisor-remote.h"
 #include "dir.h"
-#include "object-file.h"
-#include "object-name.h"
+#include "odb/object-file.h"
+#include "odb/object-name.h"
 #include "read-cache-ll.h"
 #include "setup.h"
 #include "strmap.h"
diff --git a/diff.h b/diff.h
index bb5cddaf34..502bf24432 100644
--- a/diff.h
+++ b/diff.h
@@ -4,7 +4,7 @@
 #ifndef DIFF_H
 #define DIFF_H
 
-#include "hash.h"
+#include "odb/hash.h"
 #include "pathspec.h"
 #include "strbuf.h"
 #include "color.h"
diff --git a/diffcore-break.c b/diffcore-break.c
index b5bcc956cc..70860c8abc 100644
--- a/diffcore-break.c
+++ b/diffcore-break.c
@@ -6,8 +6,8 @@
 
 #include "git-compat-util.h"
 #include "diffcore.h"
-#include "hash.h"
-#include "object.h"
+#include "odb/hash.h"
+#include "odb/object.h"
 #include "promisor-remote.h"
 
 static int should_break(struct repository *r,
diff --git a/diffcore-pickaxe.c b/diffcore-pickaxe.c
index b0915be86f..f7a745fb49 100644
--- a/diffcore-pickaxe.c
+++ b/diffcore-pickaxe.c
@@ -10,7 +10,7 @@
 #include "diffcore.h"
 #include "xdiff-interface.h"
 #include "kwset.h"
-#include "oidset.h"
+#include "odb/oidset.h"
 #include "pretty.h"
 #include "quote.h"
 
diff --git a/diffcore-rename.c b/diffcore-rename.c
index c797d8ed2f..68abf77c4d 100644
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -8,10 +8,10 @@
 #include "git-compat-util.h"
 #include "diff.h"
 #include "diffcore.h"
-#include "object-file.h"
+#include "odb/object-file.h"
 #include "hashmap.h"
 #include "mem-pool.h"
-#include "oid-array.h"
+#include "odb/oid-array.h"
 #include "progress.h"
 #include "promisor-remote.h"
 #include "string-list.h"
diff --git a/diffcore.h b/diffcore.h
index d75038d1b3..fa6125d0bf 100644
--- a/diffcore.h
+++ b/diffcore.h
@@ -4,7 +4,7 @@
 #ifndef DIFFCORE_H
 #define DIFFCORE_H
 
-#include "hash.h"
+#include "odb/hash.h"
 
 struct diff_options;
 struct mem_pool;
diff --git a/dir.c b/dir.c
index 95d8a1cce9..c9005a0ac1 100644
--- a/dir.c
+++ b/dir.c
@@ -17,7 +17,7 @@
 #include "environment.h"
 #include "gettext.h"
 #include "name-hash.h"
-#include "object-file.h"
+#include "odb/object-file.h"
 #include "path.h"
 #include "refs.h"
 #include "repository.h"
@@ -34,7 +34,7 @@
 #include "submodule-config.h"
 #include "symlinks.h"
 #include "trace2.h"
-#include "tree.h"
+#include "odb/tree.h"
 #include "hex.h"
 
  /*
diff --git a/dir.h b/dir.h
index 83e0f648a8..239c7efb1e 100644
--- a/dir.h
+++ b/dir.h
@@ -1,7 +1,7 @@
 #ifndef DIR_H
 #define DIR_H
 
-#include "hash.h"
+#include "odb/hash.h"
 #include "hashmap.h"
 #include "pathspec.h"
 #include "statinfo.h"
diff --git a/entry.c b/entry.c
index 1c4f0f4407..823a433539 100644
--- a/entry.c
+++ b/entry.c
@@ -1,7 +1,7 @@
 #define USE_THE_REPOSITORY_VARIABLE
 
 #include "git-compat-util.h"
-#include "odb.h"
+#include "odb/odb.h"
 #include "odb/streaming.h"
 #include "dir.h"
 #include "environment.h"
diff --git a/environment.c b/environment.c
index 76ee65e62b..40b993ec90 100644
--- a/environment.c
+++ b/environment.c
@@ -23,12 +23,12 @@
 #include "ident.h"
 #include "lockfile.h"
 #include "mailmap.h"
-#include "object-name.h"
+#include "odb/object-name.h"
 #include "repository.h"
 #include "config.h"
 #include "refs.h"
 #include "fmt-merge-msg.h"
-#include "commit.h"
+#include "odb/commit.h"
 #include "strvec.h"
 #include "pager.h"
 #include "path.h"
diff --git a/fetch-object-info.c b/fetch-object-info.c
index ba7e179c44..30cf131aed 100644
--- a/fetch-object-info.c
+++ b/fetch-object-info.c
@@ -3,8 +3,8 @@
 #include "hex.h"
 #include "pkt-line.h"
 #include "connect.h"
-#include "oid-array.h"
-#include "odb.h"
+#include "odb/oid-array.h"
+#include "odb/odb.h"
 #include "fetch-object-info.h"
 #include "string-list.h"
 
diff --git a/fetch-pack.c b/fetch-pack.c
index 626f799712..b172114879 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -11,8 +11,8 @@
 #include "lockfile.h"
 #include "refs.h"
 #include "pkt-line.h"
-#include "commit.h"
-#include "tag.h"
+#include "odb/commit.h"
+#include "odb/tag.h"
 #include "pack.h"
 #include "sideband.h"
 #include "fetch-pack.h"
@@ -21,15 +21,15 @@
 #include "connect.h"
 #include "trace2.h"
 #include "version.h"
-#include "oid-array.h"
-#include "oidset.h"
+#include "odb/oid-array.h"
+#include "odb/oidset.h"
 #include "packfile.h"
-#include "odb.h"
-#include "object-name.h"
+#include "odb/odb.h"
+#include "odb/object-name.h"
 #include "path.h"
 #include "connected.h"
 #include "fetch-negotiator.h"
-#include "fsck.h"
+#include "odb/fsck.h"
 #include "shallow.h"
 #include "commit-reach.h"
 #include "commit-graph.h"
diff --git a/fetch-pack.h b/fetch-pack.h
index 6d0dec7f41..14e4ba1079 100644
--- a/fetch-pack.h
+++ b/fetch-pack.h
@@ -4,7 +4,7 @@
 #include "string-list.h"
 #include "protocol.h"
 #include "list-objects-filter-options.h"
-#include "oidset.h"
+#include "odb/oidset.h"
 
 struct oid_array;
 
diff --git a/fmt-merge-msg.c b/fmt-merge-msg.c
index 14441f23ae..6e11ad0fa9 100644
--- a/fmt-merge-msg.c
+++ b/fmt-merge-msg.c
@@ -5,13 +5,13 @@
 #include "config.h"
 #include "environment.h"
 #include "refs.h"
-#include "object-name.h"
-#include "odb.h"
+#include "odb/object-name.h"
+#include "odb/odb.h"
 #include "diff.h"
 #include "diff-merges.h"
 #include "hex.h"
 #include "revision.h"
-#include "tag.h"
+#include "odb/tag.h"
 #include "string-list.h"
 #include "branch.h"
 #include "fmt-merge-msg.h"
diff --git a/fsmonitor.h b/fsmonitor.h
index 5195a8624d..59591ee49e 100644
--- a/fsmonitor.h
+++ b/fsmonitor.h
@@ -4,7 +4,7 @@
 #include "fsmonitor-ll.h"
 #include "dir.h"
 #include "fsmonitor-settings.h"
-#include "object.h"
+#include "odb/object.h"
 #include "read-cache-ll.h"
 #include "trace.h"
 
diff --git a/git.c b/git.c
index cd2d325585..619219afef 100644
--- a/git.c
+++ b/git.c
@@ -6,12 +6,12 @@
 #include "exec-cmd.h"
 #include "gettext.h"
 #include "help.h"
-#include "object-file.h"
+#include "odb/object-file.h"
 #include "pager.h"
 #include "read-cache-ll.h"
 #include "run-command.h"
 #include "alias.h"
-#include "replace-object.h"
+#include "odb/replace-object.h"
 #include "setup.h"
 #include "attr.h"
 #include "shallow.h"
diff --git a/gpg-interface.c b/gpg-interface.c
index 95abf1ef4e..034bed7aaa 100644
--- a/gpg-interface.c
+++ b/gpg-interface.c
@@ -1,7 +1,7 @@
 #define USE_THE_REPOSITORY_VARIABLE
 
 #include "git-compat-util.h"
-#include "commit.h"
+#include "odb/commit.h"
 #include "config.h"
 #include "date.h"
 #include "gettext.h"
diff --git a/graph.c b/graph.c
index 28bef1b88f..66c2be423e 100644
--- a/graph.c
+++ b/graph.c
@@ -3,7 +3,7 @@
 #include "git-compat-util.h"
 #include "gettext.h"
 #include "config.h"
-#include "commit.h"
+#include "odb/commit.h"
 #include "color.h"
 #include "graph.h"
 #include "revision.h"
diff --git a/grep.c b/grep.c
index 1d75d31421..5041c388b9 100644
--- a/grep.c
+++ b/grep.c
@@ -5,7 +5,7 @@
 #include "gettext.h"
 #include "grep.h"
 #include "hex.h"
-#include "odb.h"
+#include "odb/odb.h"
 #include "pretty.h"
 #include "userdiff.h"
 #include "xdiff-interface.h"
diff --git a/help.c b/help.c
index 46241492ce..ccc42f09e0 100644
--- a/help.c
+++ b/help.c
@@ -9,7 +9,7 @@
 #include "run-command.h"
 #include "levenshtein.h"
 #include "gettext.h"
-#include "hash.h"
+#include "odb/hash.h"
 #include "help.h"
 #include "command-list.h"
 #include "string-list.h"
diff --git a/hex.c b/hex.c
index f02832140d..6aabaf45e7 100644
--- a/hex.c
+++ b/hex.c
@@ -1,7 +1,7 @@
 #define USE_THE_REPOSITORY_VARIABLE
 
 #include "git-compat-util.h"
-#include "hash.h"
+#include "odb/hash.h"
 #include "hex.h"
 #include "strbuf.h"
 
diff --git a/hex.h b/hex.h
index f15c7e2220..e6dd268faf 100644
--- a/hex.h
+++ b/hex.h
@@ -1,7 +1,7 @@
 #ifndef HEX_H
 #define HEX_H
 
-#include "hash.h"
+#include "odb/hash.h"
 #include "hex-ll.h"
 
 /*
diff --git a/http-backend.c b/http-backend.c
index c7566b1d12..9b7ae96579 100644
--- a/http-backend.c
+++ b/http-backend.c
@@ -10,8 +10,8 @@
 #include "repository.h"
 #include "refs.h"
 #include "pkt-line.h"
-#include "object.h"
-#include "tag.h"
+#include "odb/object.h"
+#include "odb/tag.h"
 #include "exec-cmd.h"
 #include "run-command.h"
 #include "string-list.h"
@@ -19,7 +19,7 @@
 #include "setup.h"
 #include "strvec.h"
 #include "packfile.h"
-#include "odb.h"
+#include "odb/odb.h"
 #include "protocol.h"
 #include "date.h"
 #include "write-or-die.h"
diff --git a/http-push.c b/http-push.c
index 786a2e9c0d..858aa9db33 100644
--- a/http-push.c
+++ b/http-push.c
@@ -4,9 +4,9 @@
 #include "environment.h"
 #include "hex.h"
 #include "repository.h"
-#include "commit.h"
-#include "tag.h"
-#include "blob.h"
+#include "odb/commit.h"
+#include "odb/tag.h"
+#include "odb/blob.h"
 #include "http.h"
 #include "diff.h"
 #include "revision.h"
@@ -15,12 +15,12 @@
 #include "setup.h"
 #include "sigchain.h"
 #include "strvec.h"
-#include "tree.h"
-#include "tree-walk.h"
+#include "odb/tree.h"
+#include "odb/tree-walk.h"
 #include "url.h"
 #include "packfile.h"
-#include "object-file.h"
-#include "odb.h"
+#include "odb/object-file.h"
+#include "odb/odb.h"
 #include "commit-reach.h"
 
 #ifdef EXPAT_NEEDS_XMLPARSE_H
diff --git a/http-walker.c b/http-walker.c
index abafca84d6..dba84c0ef5 100644
--- a/http-walker.c
+++ b/http-walker.c
@@ -9,8 +9,8 @@
 #include "list.h"
 #include "transport.h"
 #include "packfile.h"
-#include "object-file.h"
-#include "odb.h"
+#include "odb/object-file.h"
+#include "odb/odb.h"
 
 struct alt_base {
 	char *base;
diff --git a/http.c b/http.c
index a0d399b274..81b58bd8d2 100644
--- a/http.c
+++ b/http.c
@@ -19,8 +19,8 @@
 #include "transport.h"
 #include "packfile.h"
 #include "string-list.h"
-#include "object-file.h"
-#include "odb.h"
+#include "odb/object-file.h"
+#include "odb/odb.h"
 #include "tempfile.h"
 #include "date.h"
 #include "trace2.h"
diff --git a/khash.h b/khash.h
index ff88163177..665ade151f 100644
--- a/khash.h
+++ b/khash.h
@@ -26,7 +26,7 @@
 #ifndef __AC_KHASH_H
 #define __AC_KHASH_H
 
-#include "hash.h"
+#include "odb/hash.h"
 
 #define AC_VERSION_KHASH_H "0.2.8"
 
diff --git a/line-log.c b/line-log.c
index 0179f138f7..2c9c11e5d3 100644
--- a/line-log.c
+++ b/line-log.c
@@ -4,10 +4,10 @@
 #include "diffcore.h"
 #include "line-range.h"
 #include "hex.h"
-#include "tag.h"
-#include "tree.h"
+#include "odb/tag.h"
+#include "odb/tree.h"
 #include "diff.h"
-#include "commit.h"
+#include "odb/commit.h"
 #include "decorate.h"
 #include "repository.h"
 #include "revision.h"
@@ -17,7 +17,7 @@
 #include "setup.h"
 #include "strvec.h"
 #include "bloom.h"
-#include "tree-walk.h"
+#include "odb/tree-walk.h"
 
 static void range_set_grow(struct range_set *rs, size_t extra)
 {
diff --git a/list-objects-filter-options.h b/list-objects-filter-options.h
index 77d7bbc846..96cbe9c89b 100644
--- a/list-objects-filter-options.h
+++ b/list-objects-filter-options.h
@@ -2,7 +2,7 @@
 #define LIST_OBJECTS_FILTER_OPTIONS_H
 
 #include "gettext.h"
-#include "object.h"
+#include "odb/object.h"
 #include "strbuf.h"
 
 struct option;
diff --git a/list-objects-filter.c b/list-objects-filter.c
index c912ff3079..a34e07c061 100644
--- a/list-objects-filter.c
+++ b/list-objects-filter.c
@@ -4,15 +4,15 @@
 #include "dir.h"
 #include "gettext.h"
 #include "hex.h"
-#include "commit.h"
+#include "odb/commit.h"
 #include "diff.h"
 #include "revision.h"
 #include "list-objects-filter.h"
 #include "list-objects-filter-options.h"
-#include "oidmap.h"
-#include "oidset.h"
-#include "object-name.h"
-#include "odb.h"
+#include "odb/oidmap.h"
+#include "odb/oidset.h"
+#include "odb/object-name.h"
+#include "odb/odb.h"
 
 /* Remember to update object flag allocation in object.h */
 /*
diff --git a/list-objects.c b/list-objects.c
index 724d723c48..b8a673ed69 100644
--- a/list-objects.c
+++ b/list-objects.c
@@ -1,20 +1,20 @@
 #define USE_THE_REPOSITORY_VARIABLE
 
 #include "git-compat-util.h"
-#include "tag.h"
-#include "commit.h"
+#include "odb/tag.h"
+#include "odb/commit.h"
 #include "gettext.h"
 #include "hex.h"
-#include "tree.h"
-#include "blob.h"
+#include "odb/tree.h"
+#include "odb/blob.h"
 #include "diff.h"
-#include "tree-walk.h"
+#include "odb/tree-walk.h"
 #include "revision.h"
 #include "list-objects.h"
 #include "list-objects-filter.h"
 #include "list-objects-filter-options.h"
 #include "packfile.h"
-#include "odb.h"
+#include "odb/odb.h"
 #include "trace.h"
 #include "environment.h"
 
diff --git a/log-tree.c b/log-tree.c
index 83a3c4bf9b..c9fde242a1 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -3,24 +3,24 @@
 
 #include "git-compat-util.h"
 #include "commit-reach.h"
-#include "commit-slab.h"
+#include "odb/commit-slab.h"
 #include "config.h"
 #include "diff.h"
 #include "diffcore.h"
 #include "environment.h"
 #include "hex.h"
-#include "object-name.h"
-#include "object-file.h"
+#include "odb/object-name.h"
+#include "odb/object-file.h"
 #include "repository.h"
-#include "tmp-objdir.h"
-#include "commit.h"
-#include "tag.h"
+#include "odb/tmp-objdir.h"
+#include "odb/commit.h"
+#include "odb/tag.h"
 #include "graph.h"
 #include "log-tree.h"
 #include "merge-ort.h"
 #include "reflog-walk.h"
 #include "refs.h"
-#include "replace-object.h"
+#include "odb/replace-object.h"
 #include "revision.h"
 #include "string-list.h"
 #include "color.h"
@@ -30,7 +30,7 @@
 #include "help.h"
 #include "range-diff.h"
 #include "strmap.h"
-#include "tree.h"
+#include "odb/tree.h"
 #include "wildmatch.h"
 #include "write-or-die.h"
 #include "pager.h"
diff --git a/ls-refs.c b/ls-refs.c
index 9759826ca7..e29ef0947f 100644
--- a/ls-refs.c
+++ b/ls-refs.c
@@ -3,7 +3,7 @@
 #include "git-compat-util.h"
 #include "environment.h"
 #include "gettext.h"
-#include "hash.h"
+#include "odb/hash.h"
 #include "hex.h"
 #include "repository.h"
 #include "refs.h"
diff --git a/mailmap.c b/mailmap.c
index 1386ab208c..558b1972f8 100644
--- a/mailmap.c
+++ b/mailmap.c
@@ -2,8 +2,8 @@
 #include "environment.h"
 #include "string-list.h"
 #include "mailmap.h"
-#include "object-name.h"
-#include "odb.h"
+#include "odb/object-name.h"
+#include "odb/odb.h"
 #include "setup.h"
 #include "config.h"
 
diff --git a/merge-blobs.c b/merge-blobs.c
index 16a75bd1e3..96210edd16 100644
--- a/merge-blobs.c
+++ b/merge-blobs.c
@@ -2,9 +2,9 @@
 
 #include "git-compat-util.h"
 #include "merge-ll.h"
-#include "blob.h"
+#include "odb/blob.h"
 #include "merge-blobs.h"
-#include "odb.h"
+#include "odb/odb.h"
 
 static int fill_mmfile_blob(mmfile_t *f, struct blob *obj)
 {
diff --git a/merge-ort-wrappers.c b/merge-ort-wrappers.c
index 2110844f53..846753abdf 100644
--- a/merge-ort-wrappers.c
+++ b/merge-ort-wrappers.c
@@ -1,16 +1,16 @@
 #include "git-compat-util.h"
 #include "gettext.h"
-#include "hash.h"
+#include "odb/hash.h"
 #include "hex.h"
 #include "lockfile.h"
 #include "merge-ort.h"
 #include "merge-ort-wrappers.h"
 #include "read-cache-ll.h"
 #include "repository.h"
-#include "tag.h"
-#include "tree.h"
+#include "odb/tag.h"
+#include "odb/tree.h"
 
-#include "commit.h"
+#include "odb/commit.h"
 
 static int unclean(struct merge_options *opt, struct tree *head)
 {
diff --git a/merge-ort.c b/merge-ort.c
index c410a5d353..35d30dcf06 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -20,11 +20,11 @@
 #include "git-compat-util.h"
 #include "merge-ort.h"
 
-#include "alloc.h"
+#include "odb/alloc.h"
 #include "advice.h"
 #include "attr.h"
 #include "cache-tree.h"
-#include "commit.h"
+#include "odb/commit.h"
 #include "commit-reach.h"
 #include "config.h"
 #include "diff.h"
@@ -35,12 +35,12 @@
 #include "hex.h"
 #include "entry.h"
 #include "merge-ll.h"
-#include "match-trees.h"
+#include "odb/match-trees.h"
 #include "mem-pool.h"
-#include "object-file.h"
-#include "object-name.h"
-#include "odb.h"
-#include "oid-array.h"
+#include "odb/object-file.h"
+#include "odb/object-name.h"
+#include "odb/odb.h"
+#include "odb/oid-array.h"
 #include "path.h"
 #include "promisor-remote.h"
 #include "read-cache-ll.h"
@@ -49,7 +49,7 @@
 #include "sparse-index.h"
 #include "strmap.h"
 #include "trace2.h"
-#include "tree.h"
+#include "odb/tree.h"
 #include "unpack-trees.h"
 #include "xdiff-interface.h"
 
diff --git a/merge-ort.h b/merge-ort.h
index 6045579825..da1d63131a 100644
--- a/merge-ort.h
+++ b/merge-ort.h
@@ -1,7 +1,7 @@
 #ifndef MERGE_ORT_H
 #define MERGE_ORT_H
 
-#include "hash.h"
+#include "odb/hash.h"
 #include "strbuf.h"
 
 struct commit;
diff --git a/merge.c b/merge.c
index 0f5e823e63..f46d968b70 100644
--- a/merge.c
+++ b/merge.c
@@ -2,16 +2,16 @@
 
 #include "git-compat-util.h"
 #include "gettext.h"
-#include "hash.h"
+#include "odb/hash.h"
 #include "hex.h"
 #include "lockfile.h"
 #include "merge.h"
-#include "commit.h"
+#include "odb/commit.h"
 #include "repository.h"
 #include "run-command.h"
 #include "resolve-undo.h"
-#include "tree.h"
-#include "tree-walk.h"
+#include "odb/tree.h"
+#include "odb/tree-walk.h"
 #include "unpack-trees.h"
 
 static const char *merge_argument(struct commit *commit)
diff --git a/meson.build b/meson.build
index 38ec7d4f40..6586f8ae9f 100644
--- a/meson.build
+++ b/meson.build
@@ -312,7 +312,7 @@ libgit_sources = [
   'add-patch.c',
   'advice.c',
   'alias.c',
-  'alloc.c',
+  'odb/alloc.c',
   'apply.c',
   'archive-tar.c',
   'archive-zip.c',
@@ -321,13 +321,13 @@ libgit_sources = [
   'base85.c',
   'bisect.c',
   'blame.c',
-  'blob.c',
+  'odb/blob.c',
   'bloom.c',
   'branch.c',
   'bundle-uri.c',
   'bundle.c',
   'cache-tree.c',
-  'cbtree.c',
+  'odb/cbtree.c',
   'chdir-notify.c',
   'checkout.c',
   'chunk-format.c',
@@ -336,7 +336,7 @@ libgit_sources = [
   'combine-diff.c',
   'commit-graph.c',
   'commit-reach.c',
-  'commit.c',
+  'odb/commit.c',
   'common-exit.c',
   'common-init.c',
   'compiler-tricks/not-constant.c',
@@ -377,7 +377,7 @@ libgit_sources = [
   'fetch-object-info.c',
   'fetch-pack.c',
   'fmt-merge-msg.c',
-  'fsck.c',
+  'odb/fsck.c',
   'fsmonitor.c',
   'fsmonitor-ipc.c',
   'fsmonitor-settings.c',
@@ -386,8 +386,8 @@ libgit_sources = [
   'gpg-interface.c',
   'graph.c',
   'grep.c',
-  'hash-lookup.c',
-  'hash.c',
+  'odb/hash-lookup.c',
+  'odb/hash.c',
   'hashmap.c',
   'help.c',
   'hex.c',
@@ -405,11 +405,11 @@ libgit_sources = [
   'list-objects.c',
   'lockfile.c',
   'log-tree.c',
-  'loose.c',
+  'odb/loose.c',
   'ls-refs.c',
   'mailinfo.c',
   'mailmap.c',
-  'match-trees.c',
+  'odb/match-trees.c',
   'mem-pool.c',
   'merge-blobs.c',
   'merge-ll.c',
@@ -426,11 +426,11 @@ libgit_sources = [
   'notes-merge.c',
   'notes-utils.c',
   'notes.c',
-  'object-file-convert.c',
-  'object-file.c',
-  'object-name.c',
-  'object.c',
-  'odb.c',
+  'odb/object-file-convert.c',
+  'odb/object-file.c',
+  'odb/object-name.c',
+  'odb/object.c',
+  'odb/odb.c',
   'odb/source.c',
   'odb/source-files.c',
   'odb/source-inmemory.c',
@@ -438,10 +438,10 @@ libgit_sources = [
   'odb/source-packed.c',
   'odb/streaming.c',
   'odb/transaction.c',
-  'oid-array.c',
-  'oidmap.c',
-  'oidset.c',
-  'oidtree.c',
+  'odb/oid-array.c',
+  'odb/oidmap.c',
+  'odb/oidset.c',
+  'odb/oidtree.c',
   'organize/gitorganize-format.c',
   'organize/labeler-protocol.c',
   'organize/organize.c',
@@ -515,7 +515,7 @@ libgit_sources = [
   'repack-geometry.c',
   'repack-midx.c',
   'repack-promisor.c',
-  'replace-object.c',
+  'odb/replace-object.c',
   'replay.c',
   'repo-settings.c',
   'repository.c',
@@ -544,10 +544,10 @@ libgit_sources = [
   'submodule-config.c',
   'submodule.c',
   'symlinks.c',
-  'tag.c',
+  'odb/tag.c',
   'tempfile.c',
   'thread-utils.c',
-  'tmp-objdir.c',
+  'odb/tmp-objdir.c',
   'trace.c',
   'trace2.c',
   'trace2/tr2_cfg.c',
@@ -566,8 +566,8 @@ libgit_sources = [
   'transport-helper.c',
   'transport.c',
   'tree-diff.c',
-  'tree-walk.c',
-  'tree.c',
+  'odb/tree-walk.c',
+  'odb/tree.c',
   'unpack-trees.c',
   'upload-pack.c',
   'url.c',
diff --git a/midx-write.c b/midx-write.c
index 580724d21a..bb4ceaede7 100644
--- a/midx-write.c
+++ b/midx-write.c
@@ -4,8 +4,8 @@
 #include "hex.h"
 #include "lockfile.h"
 #include "packfile.h"
-#include "object-file.h"
-#include "hash-lookup.h"
+#include "odb/object-file.h"
+#include "odb/hash-lookup.h"
 #include "midx.h"
 #include "progress.h"
 #include "trace2.h"
diff --git a/midx.c b/midx.c
index 76c3f92cc3..47f67c4295 100644
--- a/midx.c
+++ b/midx.c
@@ -5,7 +5,7 @@
 #include "dir.h"
 #include "hex.h"
 #include "packfile.h"
-#include "hash-lookup.h"
+#include "odb/hash-lookup.h"
 #include "midx.h"
 #include "progress.h"
 #include "trace2.h"
diff --git a/name-hash.c b/name-hash.c
index 83757db874..1464b6d066 100644
--- a/name-hash.c
+++ b/name-hash.c
@@ -13,7 +13,7 @@
 #include "environment.h"
 #include "gettext.h"
 #include "name-hash.h"
-#include "object.h"
+#include "odb/object.h"
 #include "read-cache-ll.h"
 #include "thread-utils.h"
 #include "trace.h"
diff --git a/negotiator/default.c b/negotiator/default.c
index 19cdf3808c..404db17785 100644
--- a/negotiator/default.c
+++ b/negotiator/default.c
@@ -2,12 +2,12 @@
 
 #include "git-compat-util.h"
 #include "default.h"
-#include "../commit.h"
+#include "odb/commit.h"
 #include "../fetch-negotiator.h"
 #include "../prio-queue.h"
 #include "../refs.h"
 #include "../repository.h"
-#include "../tag.h"
+#include "odb/tag.h"
 
 /* Remember to update object flag allocation in object.h */
 #define COMMON		(1U << 2)
diff --git a/negotiator/skipping.c b/negotiator/skipping.c
index db90fa77b5..e1218d2a93 100644
--- a/negotiator/skipping.c
+++ b/negotiator/skipping.c
@@ -2,13 +2,13 @@
 
 #include "git-compat-util.h"
 #include "skipping.h"
-#include "../commit.h"
+#include "odb/commit.h"
 #include "../fetch-negotiator.h"
 #include "../hex.h"
 #include "../prio-queue.h"
 #include "../refs.h"
 #include "../repository.h"
-#include "../tag.h"
+#include "odb/tag.h"
 
 /* Remember to update object flag allocation in object.h */
 /*
diff --git a/notes-cache.c b/notes-cache.c
index 74cef802bd..abe0964bba 100644
--- a/notes-cache.c
+++ b/notes-cache.c
@@ -2,11 +2,11 @@
 
 #include "git-compat-util.h"
 #include "notes-cache.h"
-#include "object-file.h"
-#include "odb.h"
+#include "odb/object-file.h"
+#include "odb/odb.h"
 #include "pretty.h"
 #include "repository.h"
-#include "commit.h"
+#include "odb/commit.h"
 #include "refs.h"
 #include "strbuf.h"
 
diff --git a/notes-merge.c b/notes-merge.c
index 118cad2518..2b025b6d3d 100644
--- a/notes-merge.c
+++ b/notes-merge.c
@@ -3,12 +3,12 @@
 
 #include "git-compat-util.h"
 #include "advice.h"
-#include "commit.h"
+#include "odb/commit.h"
 #include "gettext.h"
 #include "refs.h"
-#include "object-file.h"
-#include "object-name.h"
-#include "odb.h"
+#include "odb/object-file.h"
+#include "odb/object-name.h"
+#include "odb/odb.h"
 #include "path.h"
 #include "repository.h"
 #include "diff.h"
diff --git a/notes-utils.c b/notes-utils.c
index 5c1c75d5b8..b6275dfa26 100644
--- a/notes-utils.c
+++ b/notes-utils.c
@@ -2,7 +2,7 @@
 
 #include "git-compat-util.h"
 #include "config.h"
-#include "commit.h"
+#include "odb/commit.h"
 #include "environment.h"
 #include "gettext.h"
 #include "refs.h"
diff --git a/notes.c b/notes.c
index ec9c2cb150..ef44dae00d 100644
--- a/notes.c
+++ b/notes.c
@@ -6,12 +6,12 @@
 #include "environment.h"
 #include "hex.h"
 #include "notes.h"
-#include "object-file.h"
-#include "object-name.h"
-#include "odb.h"
+#include "odb/object-file.h"
+#include "odb/object-name.h"
+#include "odb/odb.h"
 #include "utf8.h"
 #include "strbuf.h"
-#include "tree-walk.h"
+#include "odb/tree-walk.h"
 #include "string-list.h"
 #include "refs.h"
 
diff --git a/alloc.c b/odb/alloc.c
similarity index 95%
rename from alloc.c
rename to odb/alloc.c
index 533a045c2a..e0f0146bf8 100644
--- a/alloc.c
+++ b/odb/alloc.c
@@ -9,13 +9,13 @@
  * for the new allocation is.
  */
 #include "git-compat-util.h"
-#include "object.h"
-#include "blob.h"
-#include "tree.h"
-#include "commit.h"
+#include "odb/object.h"
+#include "odb/blob.h"
+#include "odb/tree.h"
+#include "odb/commit.h"
 #include "repository.h"
-#include "tag.h"
-#include "alloc.h"
+#include "odb/tag.h"
+#include "odb/alloc.h"
 
 #define BLOCKING 1024
 
diff --git a/alloc.h b/odb/alloc.h
similarity index 100%
rename from alloc.h
rename to odb/alloc.h
diff --git a/blob.c b/odb/blob.c
similarity index 89%
rename from blob.c
rename to odb/blob.c
index 3fb2922b1a..cd4b34a2b3 100644
--- a/blob.c
+++ b/odb/blob.c
@@ -1,6 +1,6 @@
 #include "git-compat-util.h"
-#include "blob.h"
-#include "alloc.h"
+#include "odb/blob.h"
+#include "odb/alloc.h"
 
 const char *blob_type = "blob";
 
diff --git a/blob.h b/odb/blob.h
similarity index 96%
rename from blob.h
rename to odb/blob.h
index 74555c90c4..cebe385c9b 100644
--- a/blob.h
+++ b/odb/blob.h
@@ -1,7 +1,7 @@
 #ifndef BLOB_H
 #define BLOB_H
 
-#include "object.h"
+#include "odb/object.h"
 
 extern const char *blob_type;
 
diff --git a/cbtree.c b/odb/cbtree.c
similarity index 99%
rename from cbtree.c
rename to odb/cbtree.c
index 8f5edbb80a..6f1699385e 100644
--- a/cbtree.c
+++ b/odb/cbtree.c
@@ -5,7 +5,7 @@
  * git clone https://github.com/agl/critbit.git
  */
 #include "git-compat-util.h"
-#include "cbtree.h"
+#include "odb/cbtree.h"
 
 static inline uint8_t *cb_node_key(struct cb_tree *t, struct cb_node *node)
 {
diff --git a/cbtree.h b/odb/cbtree.h
similarity index 100%
rename from cbtree.h
rename to odb/cbtree.h
diff --git a/commit-slab-decl.h b/odb/commit-slab-decl.h
similarity index 100%
rename from commit-slab-decl.h
rename to odb/commit-slab-decl.h
diff --git a/commit-slab-impl.h b/odb/commit-slab-impl.h
similarity index 100%
rename from commit-slab-impl.h
rename to odb/commit-slab-impl.h
diff --git a/commit-slab.h b/odb/commit-slab.h
similarity index 97%
rename from commit-slab.h
rename to odb/commit-slab.h
index 8e72a30536..8a736bdf72 100644
--- a/commit-slab.h
+++ b/odb/commit-slab.h
@@ -1,8 +1,8 @@
 #ifndef COMMIT_SLAB_H
 #define COMMIT_SLAB_H
 
-#include "commit-slab-decl.h"
-#include "commit-slab-impl.h"
+#include "odb/commit-slab-decl.h"
+#include "odb/commit-slab-impl.h"
 
 /*
  * define_commit_slab(slabname, elemtype) creates boilerplate code to define
diff --git a/commit.c b/odb/commit.c
similarity index 99%
rename from commit.c
rename to odb/commit.c
index ad26f0b40a..d0e036876c 100644
--- a/commit.c
+++ b/odb/commit.c
@@ -1,36 +1,36 @@
 #define USE_THE_REPOSITORY_VARIABLE
 
 #include "git-compat-util.h"
-#include "tag.h"
-#include "commit.h"
+#include "odb/tag.h"
+#include "odb/commit.h"
 #include "commit-graph.h"
 #include "environment.h"
 #include "gettext.h"
 #include "hex.h"
 #include "repository.h"
-#include "object-name.h"
-#include "odb.h"
+#include "odb/object-name.h"
+#include "odb/odb.h"
 #include "utf8.h"
 #include "diff.h"
 #include "revision.h"
 #include "notes.h"
-#include "alloc.h"
+#include "odb/alloc.h"
 #include "gpg-interface.h"
 #include "mergesort.h"
-#include "commit-slab.h"
+#include "odb/commit-slab.h"
 #include "prio-queue.h"
-#include "hash-lookup.h"
+#include "odb/hash-lookup.h"
 #include "wt-status.h"
 #include "advice.h"
 #include "refs.h"
 #include "commit-reach.h"
 #include "setup.h"
 #include "shallow.h"
-#include "tree.h"
+#include "odb/tree.h"
 #include "hook.h"
 #include "parse.h"
-#include "object-file.h"
-#include "object-file-convert.h"
+#include "odb/object-file.h"
+#include "odb/object-file-convert.h"
 
 static struct commit_extra_header *read_commit_extra_header_lines(const char *buf, size_t len, const char **);
 
diff --git a/commit.h b/odb/commit.h
similarity index 99%
rename from commit.h
rename to odb/commit.h
index 1061ed791b..a93c0f8d65 100644
--- a/commit.h
+++ b/odb/commit.h
@@ -1,7 +1,7 @@
 #ifndef COMMIT_H
 #define COMMIT_H
 
-#include "object.h"
+#include "odb/object.h"
 #include "add-interactive.h"
 
 struct signature_check;
diff --git a/fsck.c b/odb/fsck.c
similarity index 99%
rename from fsck.c
rename to odb/fsck.c
index 94c8651c7d..e76779109a 100644
--- a/fsck.c
+++ b/odb/fsck.c
@@ -3,21 +3,21 @@
 #include "dir.h"
 #include "environment.h"
 #include "hex.h"
-#include "odb.h"
+#include "odb/odb.h"
 #include "path.h"
 #include "repository.h"
-#include "object.h"
+#include "odb/object.h"
 #include "attr.h"
-#include "blob.h"
-#include "tree.h"
-#include "tree-walk.h"
-#include "commit.h"
-#include "tag.h"
-#include "fsck.h"
+#include "odb/blob.h"
+#include "odb/tree.h"
+#include "odb/tree-walk.h"
+#include "odb/commit.h"
+#include "odb/tag.h"
+#include "odb/fsck.h"
 #include "refs.h"
 #include "url.h"
 #include "utf8.h"
-#include "oidset.h"
+#include "odb/oidset.h"
 #include "packfile.h"
 #include "submodule-config.h"
 #include "config.h"
diff --git a/fsck.h b/odb/fsck.h
similarity index 99%
rename from fsck.h
rename to odb/fsck.h
index e77935c8a9..1e3fc862de 100644
--- a/fsck.h
+++ b/odb/fsck.h
@@ -1,8 +1,8 @@
 #ifndef GIT_FSCK_H
 #define GIT_FSCK_H
 
-#include "object.h"
-#include "oidset.h"
+#include "odb/object.h"
+#include "odb/oidset.h"
 
 enum fsck_msg_type {
 	/* for internal use only */
diff --git a/hash-lookup.c b/odb/hash-lookup.c
similarity index 98%
rename from hash-lookup.c
rename to odb/hash-lookup.c
index 5f808caa51..cf2d4a0245 100644
--- a/hash-lookup.c
+++ b/odb/hash-lookup.c
@@ -1,8 +1,8 @@
 #define USE_THE_REPOSITORY_VARIABLE
 
 #include "git-compat-util.h"
-#include "hash.h"
-#include "hash-lookup.h"
+#include "odb/hash.h"
+#include "odb/hash-lookup.h"
 #include "read-cache-ll.h"
 
 static uint32_t take2(const struct object_id *oid, size_t ofs)
diff --git a/hash-lookup.h b/odb/hash-lookup.h
similarity index 100%
rename from hash-lookup.h
rename to odb/hash-lookup.h
diff --git a/hash.c b/odb/hash.c
similarity index 99%
rename from hash.c
rename to odb/hash.c
index 82f7e24404..e02dcea558 100644
--- a/hash.c
+++ b/odb/hash.c
@@ -1,5 +1,5 @@
 #include "git-compat-util.h"
-#include "hash.h"
+#include "odb/hash.h"
 #include "hex.h"
 
 static const struct object_id empty_tree_oid = {
diff --git a/hash.h b/odb/hash.h
similarity index 100%
rename from hash.h
rename to odb/hash.h
diff --git a/loose.c b/odb/loose.c
similarity index 98%
rename from loose.c
rename to odb/loose.c
index aa3cb1b4fc..58af1f7910 100644
--- a/loose.c
+++ b/odb/loose.c
@@ -1,16 +1,16 @@
 #include "git-compat-util.h"
-#include "hash.h"
+#include "odb/hash.h"
 #include "path.h"
-#include "object-file.h"
-#include "odb.h"
+#include "odb/object-file.h"
+#include "odb/odb.h"
 #include "odb/source-files.h"
 #include "hex.h"
 #include "repository.h"
 #include "wrapper.h"
 #include "gettext.h"
-#include "loose.h"
+#include "odb/loose.h"
 #include "lockfile.h"
-#include "oidtree.h"
+#include "odb/oidtree.h"
 
 static const char *loose_object_header = "# loose-object-idx\n";
 
diff --git a/loose.h b/odb/loose.h
similarity index 100%
rename from loose.h
rename to odb/loose.h
diff --git a/match-trees.c b/odb/match-trees.c
similarity index 98%
rename from match-trees.c
rename to odb/match-trees.c
index 2a43c0fa1a..4062373e11 100644
--- a/match-trees.c
+++ b/odb/match-trees.c
@@ -2,12 +2,12 @@
 
 #include "git-compat-util.h"
 #include "hex.h"
-#include "match-trees.h"
+#include "odb/match-trees.h"
 #include "strbuf.h"
-#include "tree.h"
-#include "tree-walk.h"
-#include "object-file.h"
-#include "odb.h"
+#include "odb/tree.h"
+#include "odb/tree-walk.h"
+#include "odb/object-file.h"
+#include "odb/odb.h"
 #include "repository.h"
 
 static int score_missing(unsigned mode)
diff --git a/match-trees.h b/odb/match-trees.h
similarity index 100%
rename from match-trees.h
rename to odb/match-trees.h
diff --git a/object-file-convert.c b/odb/object-file-convert.c
similarity index 98%
rename from object-file-convert.c
rename to odb/object-file-convert.c
index 63ee18630b..cad75963f7 100644
--- a/object-file-convert.c
+++ b/odb/object-file-convert.c
@@ -5,12 +5,12 @@
 #include "strbuf.h"
 #include "hex.h"
 #include "repository.h"
-#include "hash.h"
-#include "object.h"
-#include "loose.h"
-#include "commit.h"
+#include "odb/hash.h"
+#include "odb/object.h"
+#include "odb/loose.h"
+#include "odb/commit.h"
 #include "gpg-interface.h"
-#include "object-file-convert.h"
+#include "odb/object-file-convert.h"
 
 int repo_oid_to_algop(struct repository *repo, const struct object_id *srcoid,
 		      const struct git_hash_algo *to, struct object_id *dest)
diff --git a/object-file-convert.h b/odb/object-file-convert.h
similarity index 96%
rename from object-file-convert.h
rename to odb/object-file-convert.h
index 9b3cc5e533..a9c454e76e 100644
--- a/object-file-convert.h
+++ b/odb/object-file-convert.h
@@ -5,7 +5,7 @@ struct repository;
 struct object_id;
 struct git_hash_algo;
 struct strbuf;
-#include "object.h"
+#include "odb/object.h"
 
 int repo_oid_to_algop(struct repository *repo, const struct object_id *src,
 		      const struct git_hash_algo *to, struct object_id *dest);
diff --git a/object-file.c b/odb/object-file.c
similarity index 99%
rename from object-file.c
rename to odb/object-file.c
index ec35c318bc..c4841cc289 100644
--- a/object-file.c
+++ b/odb/object-file.c
@@ -13,13 +13,13 @@
 #include "convert.h"
 #include "dir.h"
 #include "environment.h"
-#include "fsck.h"
+#include "odb/fsck.h"
 #include "gettext.h"
 #include "hex.h"
-#include "loose.h"
-#include "object-file-convert.h"
-#include "object-file.h"
-#include "odb.h"
+#include "odb/loose.h"
+#include "odb/object-file-convert.h"
+#include "odb/object-file.h"
+#include "odb/odb.h"
 #include "odb/streaming.h"
 #include "odb/transaction.h"
 #include "pack.h"
@@ -29,7 +29,7 @@
 #include "setup.h"
 #include "strvec.h"
 #include "tempfile.h"
-#include "tmp-objdir.h"
+#include "odb/tmp-objdir.h"
 
 static int get_conv_flags(unsigned flags)
 {
diff --git a/object-file.h b/odb/object-file.h
similarity index 99%
rename from object-file.h
rename to odb/object-file.h
index 805f2cfa28..5e9b61fe17 100644
--- a/object-file.h
+++ b/odb/object-file.h
@@ -2,8 +2,8 @@
 #define OBJECT_FILE_H
 
 #include "git-zlib.h"
-#include "object.h"
-#include "odb.h"
+#include "odb/object.h"
+#include "odb/odb.h"
 #include "odb/source-loose.h"
 #include "odb/transaction.h"
 
diff --git a/object-name.c b/odb/object-name.c
similarity index 99%
rename from object-name.c
rename to odb/object-name.c
index 83efba0ba6..98c88e7337 100644
--- a/object-name.c
+++ b/odb/object-name.c
@@ -2,21 +2,21 @@
 #define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "git-compat-util.h"
-#include "object-name.h"
+#include "odb/object-name.h"
 #include "advice.h"
 #include "config.h"
 #include "environment.h"
 #include "gettext.h"
 #include "hex.h"
-#include "tag.h"
-#include "commit.h"
-#include "tree.h"
-#include "tree-walk.h"
+#include "odb/tag.h"
+#include "odb/commit.h"
+#include "odb/tree.h"
+#include "odb/tree-walk.h"
 #include "refs.h"
 #include "remote.h"
 #include "dir.h"
-#include "odb.h"
-#include "oid-array.h"
+#include "odb/odb.h"
+#include "odb/oid-array.h"
 #include "pretty.h"
 #include "read-cache-ll.h"
 #include "repo-settings.h"
@@ -25,7 +25,7 @@
 #include "midx.h"
 #include "commit-reach.h"
 #include "date.h"
-#include "object-file-convert.h"
+#include "odb/object-file-convert.h"
 #include "prio-queue.h"
 
 static int get_oid_oneline(struct repository *r, const char *, struct object_id *,
diff --git a/object-name.h b/odb/object-name.h
similarity index 99%
rename from object-name.h
rename to odb/object-name.h
index 167a9154ea..ecc161a086 100644
--- a/object-name.h
+++ b/odb/object-name.h
@@ -1,7 +1,7 @@
 #ifndef OBJECT_NAME_H
 #define OBJECT_NAME_H
 
-#include "object.h"
+#include "odb/object.h"
 #include "strbuf.h"
 
 struct object_id;
diff --git a/object.c b/odb/object.c
similarity index 98%
rename from object.c
rename to odb/object.c
index 23b84aa7e2..8a34e52eca 100644
--- a/object.c
+++ b/odb/object.c
@@ -3,16 +3,16 @@
 #include "git-compat-util.h"
 #include "gettext.h"
 #include "hex.h"
-#include "object.h"
-#include "replace-object.h"
-#include "object-file.h"
+#include "odb/object.h"
+#include "odb/replace-object.h"
+#include "odb/object-file.h"
 #include "odb/streaming.h"
-#include "blob.h"
+#include "odb/blob.h"
 #include "statinfo.h"
-#include "tree.h"
-#include "commit.h"
-#include "tag.h"
-#include "alloc.h"
+#include "odb/tree.h"
+#include "odb/commit.h"
+#include "odb/tag.h"
+#include "odb/alloc.h"
 #include "commit-graph.h"
 
 unsigned int get_max_object_index(const struct repository *repo)
diff --git a/object.h b/odb/object.h
similarity index 99%
rename from object.h
rename to odb/object.h
index 8fb03ff90a..8070b40b5e 100644
--- a/object.h
+++ b/odb/object.h
@@ -1,7 +1,7 @@
 #ifndef OBJECT_H
 #define OBJECT_H
 
-#include "hash.h"
+#include "odb/hash.h"
 
 struct buffer_slab;
 struct repository;
diff --git a/odb.c b/odb/odb.c
similarity index 99%
rename from odb.c
rename to odb/odb.c
index bd02d8ad54..ffa2881e9f 100644
--- a/odb.c
+++ b/odb/odb.c
@@ -8,24 +8,24 @@
 #include "hex.h"
 #include "khash.h"
 #include "lockfile.h"
-#include "loose.h"
+#include "odb/loose.h"
 #include "midx.h"
-#include "object-file-convert.h"
-#include "object-file.h"
-#include "object-name.h"
-#include "odb.h"
+#include "odb/object-file-convert.h"
+#include "odb/object-file.h"
+#include "odb/object-name.h"
+#include "odb/odb.h"
 #include "odb/source-inmemory.h"
 #include "packfile.h"
 #include "path.h"
 #include "promisor-remote.h"
 #include "quote.h"
-#include "replace-object.h"
+#include "odb/replace-object.h"
 #include "run-command.h"
 #include "setup.h"
 #include "strbuf.h"
 #include "strvec.h"
 #include "submodule.h"
-#include "tmp-objdir.h"
+#include "odb/tmp-objdir.h"
 #include "trace2.h"
 #include "write-or-die.h"
 
diff --git a/odb.h b/odb/odb.h
similarity index 99%
rename from odb.h
rename to odb/odb.h
index 8eb4e85d64..476660a706 100644
--- a/odb.h
+++ b/odb/odb.h
@@ -1,9 +1,9 @@
 #ifndef ODB_H
 #define ODB_H
 
-#include "object.h"
-#include "oidset.h"
-#include "oidmap.h"
+#include "odb/object.h"
+#include "odb/oidset.h"
+#include "odb/oidmap.h"
 #include "string-list.h"
 #include "thread-utils.h"
 
diff --git a/oid-array.c b/odb/oid-array.c
similarity index 97%
rename from oid-array.c
rename to odb/oid-array.c
index 9cac974395..15425abc3f 100644
--- a/oid-array.c
+++ b/odb/oid-array.c
@@ -1,8 +1,8 @@
 #define USE_THE_REPOSITORY_VARIABLE
 
 #include "git-compat-util.h"
-#include "oid-array.h"
-#include "hash-lookup.h"
+#include "odb/oid-array.h"
+#include "odb/hash-lookup.h"
 
 void oid_array_append(struct oid_array *array, const struct object_id *oid)
 {
diff --git a/oid-array.h b/odb/oid-array.h
similarity index 99%
rename from oid-array.h
rename to odb/oid-array.h
index f60f9af674..fdde085587 100644
--- a/oid-array.h
+++ b/odb/oid-array.h
@@ -1,7 +1,7 @@
 #ifndef OID_ARRAY_H
 #define OID_ARRAY_H
 
-#include "hash.h"
+#include "odb/hash.h"
 
 /**
  * The API provides storage and manipulation of sets of object identifiers.
diff --git a/oidmap.c b/odb/oidmap.c
similarity index 97%
rename from oidmap.c
rename to odb/oidmap.c
index a1ef53577f..80c5605bb6 100644
--- a/oidmap.c
+++ b/odb/oidmap.c
@@ -1,6 +1,6 @@
 #include "git-compat-util.h"
-#include "hash.h"
-#include "oidmap.h"
+#include "odb/hash.h"
+#include "odb/oidmap.h"
 
 static int oidmap_neq(const void *hashmap_cmp_fn_data UNUSED,
 		      const struct hashmap_entry *e1,
diff --git a/oidmap.h b/odb/oidmap.h
similarity index 99%
rename from oidmap.h
rename to odb/oidmap.h
index acddcaecdd..f0cdebf688 100644
--- a/oidmap.h
+++ b/odb/oidmap.h
@@ -1,7 +1,7 @@
 #ifndef OIDMAP_H
 #define OIDMAP_H
 
-#include "hash.h"
+#include "odb/hash.h"
 #include "hashmap.h"
 
 /*
diff --git a/oidset.c b/odb/oidset.c
similarity index 99%
rename from oidset.c
rename to odb/oidset.c
index c8ff0b385c..c37bb183eb 100644
--- a/oidset.c
+++ b/odb/oidset.c
@@ -1,5 +1,5 @@
 #include "git-compat-util.h"
-#include "oidset.h"
+#include "odb/oidset.h"
 #include "hex.h"
 #include "strbuf.h"
 
diff --git a/oidset.h b/odb/oidset.h
similarity index 100%
rename from oidset.h
rename to odb/oidset.h
diff --git a/oidtree.c b/odb/oidtree.c
similarity index 98%
rename from oidtree.c
rename to odb/oidtree.c
index e43f18026e..b1f4c1d232 100644
--- a/oidtree.c
+++ b/odb/oidtree.c
@@ -3,8 +3,8 @@
  * May be used to replace oid-array for prefix (abbreviation) matches
  */
 #include "git-compat-util.h"
-#include "oidtree.h"
-#include "hash.h"
+#include "odb/oidtree.h"
+#include "odb/hash.h"
 
 struct oidtree_node {
 	struct cb_node base;
diff --git a/oidtree.h b/odb/oidtree.h
similarity index 97%
rename from oidtree.h
rename to odb/oidtree.h
index baa5a436ea..41d241a5de 100644
--- a/oidtree.h
+++ b/odb/oidtree.h
@@ -1,8 +1,8 @@
 #ifndef OIDTREE_H
 #define OIDTREE_H
 
-#include "cbtree.h"
-#include "hash.h"
+#include "odb/cbtree.h"
+#include "odb/hash.h"
 #include "mem-pool.h"
 
 /*
diff --git a/replace-object.c b/odb/replace-object.c
similarity index 96%
rename from replace-object.c
rename to odb/replace-object.c
index 03d0f1f083..32d778f55e 100644
--- a/replace-object.c
+++ b/odb/replace-object.c
@@ -1,12 +1,12 @@
 #include "git-compat-util.h"
 #include "gettext.h"
 #include "hex.h"
-#include "oidmap.h"
-#include "odb.h"
-#include "replace-object.h"
+#include "odb/oidmap.h"
+#include "odb/odb.h"
+#include "odb/replace-object.h"
 #include "refs.h"
 #include "repository.h"
-#include "commit.h"
+#include "odb/commit.h"
 
 static int register_replace_ref(const struct reference *ref, void *cb_data)
 {
diff --git a/replace-object.h b/odb/replace-object.h
similarity index 97%
rename from replace-object.h
rename to odb/replace-object.h
index 4c9f2a2383..d7139028a3 100644
--- a/replace-object.h
+++ b/odb/replace-object.h
@@ -1,9 +1,9 @@
 #ifndef REPLACE_OBJECT_H
 #define REPLACE_OBJECT_H
 
-#include "oidmap.h"
+#include "odb/oidmap.h"
 #include "repository.h"
-#include "odb.h"
+#include "odb/odb.h"
 
 struct replace_object {
 	struct oidmap_entry original;
diff --git a/odb/source-files.c b/odb/source-files.c
index 4f8e7ad7e3..279a2ccab6 100644
--- a/odb/source-files.c
+++ b/odb/source-files.c
@@ -1,12 +1,12 @@
 #include "git-compat-util.h"
 #include "abspath.h"
-#include "blob.h"
+#include "odb/blob.h"
 #include "chdir-notify.h"
 #include "config.h"
 #include "gettext.h"
 #include "lockfile.h"
-#include "object-file.h"
-#include "odb.h"
+#include "odb/object-file.h"
+#include "odb/odb.h"
 #include "odb/source.h"
 #include "odb/source-files.h"
 #include "odb/source-loose.h"
@@ -19,7 +19,7 @@
 #include "strbuf.h"
 #include "string-list.h"
 #include "strvec.h"
-#include "tree.h"
+#include "odb/tree.h"
 #include "write-or-die.h"
 
 static void odb_source_files_reparent(const char *name UNUSED,
diff --git a/odb/source-inmemory.c b/odb/source-inmemory.c
index 3e71611b8e..288b51848e 100644
--- a/odb/source-inmemory.c
+++ b/odb/source-inmemory.c
@@ -1,9 +1,9 @@
 #include "git-compat-util.h"
-#include "object-file.h"
-#include "odb.h"
+#include "odb/object-file.h"
+#include "odb/odb.h"
 #include "odb/source-inmemory.h"
 #include "odb/streaming.h"
-#include "oidtree.h"
+#include "odb/oidtree.h"
 #include "repository.h"
 
 struct inmemory_object {
diff --git a/odb/source-loose.c b/odb/source-loose.c
index a292eb7efc..2b073d2a22 100644
--- a/odb/source-loose.c
+++ b/odb/source-loose.c
@@ -3,14 +3,14 @@
 #include "chdir-notify.h"
 #include "gettext.h"
 #include "hex.h"
-#include "loose.h"
-#include "object-file.h"
-#include "object-file-convert.h"
-#include "odb.h"
+#include "odb/loose.h"
+#include "odb/object-file.h"
+#include "odb/object-file-convert.h"
+#include "odb/odb.h"
 #include "odb/source-files.h"
 #include "odb/source-loose.h"
 #include "odb/streaming.h"
-#include "oidtree.h"
+#include "odb/oidtree.h"
 #include "path.h"
 #include "repository.h"
 #include "strbuf.h"
diff --git a/odb/source.c b/odb/source.c
index 30188b806d..2a2e1d0060 100644
--- a/odb/source.c
+++ b/odb/source.c
@@ -1,5 +1,5 @@
 #include "git-compat-util.h"
-#include "object-file.h"
+#include "odb/object-file.h"
 #include "odb/source-files.h"
 #include "odb/source.h"
 #include "packfile.h"
diff --git a/odb/source.h b/odb/source.h
index 4bc037b8d6..8f063363cb 100644
--- a/odb/source.h
+++ b/odb/source.h
@@ -1,8 +1,8 @@
 #ifndef ODB_SOURCE_H
 #define ODB_SOURCE_H
 
-#include "object.h"
-#include "odb.h"
+#include "odb/object.h"
+#include "odb/odb.h"
 #include "odb/transaction.h"
 
 enum odb_source_type {
diff --git a/odb/streaming.c b/odb/streaming.c
index 20531e864c..c3a06f5622 100644
--- a/odb/streaming.c
+++ b/odb/streaming.c
@@ -6,10 +6,10 @@
 #include "convert.h"
 #include "environment.h"
 #include "repository.h"
-#include "odb.h"
+#include "odb/odb.h"
 #include "odb/source.h"
 #include "odb/streaming.h"
-#include "replace-object.h"
+#include "odb/replace-object.h"
 
 #define FILTER_BUFFER (1024*16)
 
diff --git a/odb/streaming.h b/odb/streaming.h
index c023671780..552239e80e 100644
--- a/odb/streaming.h
+++ b/odb/streaming.h
@@ -4,8 +4,8 @@
 #ifndef STREAMING_H
 #define STREAMING_H 1
 
-#include "object.h"
-#include "odb.h"
+#include "odb/object.h"
+#include "odb/odb.h"
 
 struct object_database;
 struct odb_read_stream;
diff --git a/tag.c b/odb/tag.c
similarity index 97%
rename from tag.c
rename to odb/tag.c
index 1a00ded6eb..7be23b04c1 100644
--- a/tag.c
+++ b/odb/tag.c
@@ -2,13 +2,13 @@
 
 #include "git-compat-util.h"
 #include "environment.h"
-#include "tag.h"
-#include "object-name.h"
-#include "odb.h"
-#include "commit.h"
-#include "tree.h"
-#include "blob.h"
-#include "alloc.h"
+#include "odb/tag.h"
+#include "odb/object-name.h"
+#include "odb/odb.h"
+#include "odb/commit.h"
+#include "odb/tree.h"
+#include "odb/blob.h"
+#include "odb/alloc.h"
 #include "gpg-interface.h"
 #include "hex.h"
 #include "packfile.h"
diff --git a/tag.h b/odb/tag.h
similarity index 96%
rename from tag.h
rename to odb/tag.h
index 534687c4ca..bfac5aa506 100644
--- a/tag.h
+++ b/odb/tag.h
@@ -1,7 +1,7 @@
 #ifndef TAG_H
 #define TAG_H
 
-#include "object.h"
+#include "odb/object.h"
 
 extern const char *tag_type;
 
diff --git a/tmp-objdir.c b/odb/tmp-objdir.c
similarity index 99%
rename from tmp-objdir.c
rename to odb/tmp-objdir.c
index d199d39e7c..b9ba5c4cd3 100644
--- a/tmp-objdir.c
+++ b/odb/tmp-objdir.c
@@ -1,16 +1,16 @@
 #include "git-compat-util.h"
-#include "tmp-objdir.h"
+#include "odb/tmp-objdir.h"
 #include "abspath.h"
 #include "chdir-notify.h"
 #include "dir.h"
 #include "environment.h"
-#include "object-file.h"
+#include "odb/object-file.h"
 #include "path.h"
 #include "string-list.h"
 #include "strbuf.h"
 #include "strvec.h"
 #include "quote.h"
-#include "odb.h"
+#include "odb/odb.h"
 #include "odb/source.h"
 #include "repository.h"
 
diff --git a/tmp-objdir.h b/odb/tmp-objdir.h
similarity index 100%
rename from tmp-objdir.h
rename to odb/tmp-objdir.h
diff --git a/odb/transaction.h b/odb/transaction.h
index 4cb2eafcbf..56c8bec5f9 100644
--- a/odb/transaction.h
+++ b/odb/transaction.h
@@ -2,7 +2,7 @@
 #define ODB_TRANSACTION_H
 
 #include "gettext.h"
-#include "odb.h"
+#include "odb/odb.h"
 
 /*
  * A transaction may be started for an object database prior to writing new
diff --git a/tree-walk.c b/odb/tree-walk.c
similarity index 99%
rename from tree-walk.c
rename to odb/tree-walk.c
index a67f06b9eb..51e8037ef5 100644
--- a/tree-walk.c
+++ b/odb/tree-walk.c
@@ -1,14 +1,14 @@
 #define USE_THE_REPOSITORY_VARIABLE
 
 #include "git-compat-util.h"
-#include "tree-walk.h"
+#include "odb/tree-walk.h"
 #include "dir.h"
 #include "gettext.h"
 #include "hex.h"
-#include "object-file.h"
-#include "odb.h"
+#include "odb/object-file.h"
+#include "odb/odb.h"
 #include "trace2.h"
-#include "tree.h"
+#include "odb/tree.h"
 #include "pathspec.h"
 #include "json-writer.h"
 #include "environment.h"
diff --git a/tree-walk.h b/odb/tree-walk.h
similarity index 99%
rename from tree-walk.h
rename to odb/tree-walk.h
index 9646c47ac5..cada7e93c6 100644
--- a/tree-walk.h
+++ b/odb/tree-walk.h
@@ -1,7 +1,7 @@
 #ifndef TREE_WALK_H
 #define TREE_WALK_H
 
-#include "hash.h"
+#include "odb/hash.h"
 
 struct index_state;
 struct repository;
diff --git a/tree.c b/odb/tree.c
similarity index 97%
rename from tree.c
rename to odb/tree.c
index 53f7395e9f..f1a9779d1a 100644
--- a/tree.c
+++ b/odb/tree.c
@@ -1,11 +1,11 @@
 #include "git-compat-util.h"
 #include "hex.h"
-#include "tree.h"
-#include "object-name.h"
-#include "odb.h"
-#include "commit.h"
-#include "alloc.h"
-#include "tree-walk.h"
+#include "odb/tree.h"
+#include "odb/object-name.h"
+#include "odb/odb.h"
+#include "odb/commit.h"
+#include "odb/alloc.h"
+#include "odb/tree-walk.h"
 #include "repository.h"
 #include "environment.h"
 
diff --git a/tree.h b/odb/tree.h
similarity index 98%
rename from tree.h
rename to odb/tree.h
index 677382eed8..cebfcfe80e 100644
--- a/tree.h
+++ b/odb/tree.h
@@ -1,7 +1,7 @@
 #ifndef TREE_H
 #define TREE_H
 
-#include "object.h"
+#include "odb/object.h"
 
 struct pathspec;
 struct repository;
diff --git a/oss-fuzz/fuzz-pack-idx.c b/oss-fuzz/fuzz-pack-idx.c
index d2a92f34d9..5b033dbd93 100644
--- a/oss-fuzz/fuzz-pack-idx.c
+++ b/oss-fuzz/fuzz-pack-idx.c
@@ -1,5 +1,5 @@
 #include "git-compat-util.h"
-#include "odb.h"
+#include "odb/odb.h"
 #include "packfile.h"
 
 int LLVMFuzzerTestOneInput(const uint8_t *data, size_t size);
diff --git a/pack-bitmap-write.c b/pack-bitmap-write.c
index acbea89031..64233d6cd0 100644
--- a/pack-bitmap-write.c
+++ b/pack-bitmap-write.c
@@ -4,25 +4,25 @@
 #include "environment.h"
 #include "gettext.h"
 #include "hex.h"
-#include "odb.h"
-#include "commit.h"
+#include "odb/odb.h"
+#include "odb/commit.h"
 #include "diff.h"
 #include "revision.h"
 #include "progress.h"
 #include "pack.h"
 #include "pack-bitmap.h"
-#include "hash-lookup.h"
+#include "odb/hash-lookup.h"
 #include "pack-objects.h"
 #include "path.h"
 #include "commit-reach.h"
 #include "prio-queue.h"
 #include "trace2.h"
-#include "tree.h"
-#include "tree-walk.h"
+#include "odb/tree.h"
+#include "odb/tree-walk.h"
 #include "pseudo-merge.h"
-#include "oid-array.h"
+#include "odb/oid-array.h"
 #include "config.h"
-#include "alloc.h"
+#include "odb/alloc.h"
 #include "refs.h"
 #include "strmap.h"
 #include "midx.h"
diff --git a/pack-bitmap.c b/pack-bitmap.c
index e85bd69ba4..908a00ec0c 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -1,11 +1,11 @@
 #define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "git-compat-util.h"
-#include "commit.h"
+#include "odb/commit.h"
 #include "gettext.h"
 #include "hex.h"
 #include "strbuf.h"
-#include "tag.h"
+#include "odb/tag.h"
 #include "diff.h"
 #include "revision.h"
 #include "progress.h"
@@ -17,7 +17,7 @@
 #include "packfile.h"
 #include "repository.h"
 #include "trace2.h"
-#include "odb.h"
+#include "odb/odb.h"
 #include "list-objects-filter-options.h"
 #include "midx.h"
 #include "config.h"
diff --git a/pack-check.c b/pack-check.c
index c3b8db7c5c..358c68ef11 100644
--- a/pack-check.c
+++ b/pack-check.c
@@ -7,8 +7,8 @@
 #include "pack.h"
 #include "progress.h"
 #include "packfile.h"
-#include "object-file.h"
-#include "odb.h"
+#include "odb/object-file.h"
+#include "odb/odb.h"
 #include "odb/streaming.h"
 
 struct idx_entry {
diff --git a/pack-mtimes.c b/pack-mtimes.c
index 8e1f2dec0e..903c1039c8 100644
--- a/pack-mtimes.c
+++ b/pack-mtimes.c
@@ -1,7 +1,7 @@
 #include "git-compat-util.h"
 #include "gettext.h"
 #include "pack-mtimes.h"
-#include "odb.h"
+#include "odb/odb.h"
 #include "packfile.h"
 #include "strbuf.h"
 
diff --git a/pack-objects.c b/pack-objects.c
index 48510dd343..35ecc8831e 100644
--- a/pack-objects.c
+++ b/pack-objects.c
@@ -1,5 +1,5 @@
 #include "git-compat-util.h"
-#include "object.h"
+#include "odb/object.h"
 #include "pack.h"
 #include "pack-objects.h"
 #include "packfile.h"
diff --git a/pack-objects.h b/pack-objects.h
index e97e84ddcb..8b9fc2e36b 100644
--- a/pack-objects.h
+++ b/pack-objects.h
@@ -1,7 +1,7 @@
 #ifndef PACK_OBJECTS_H
 #define PACK_OBJECTS_H
 
-#include "odb.h"
+#include "odb/odb.h"
 #include "thread-utils.h"
 #include "pack.h"
 #include "packfile.h"
diff --git a/pack-revindex.c b/pack-revindex.c
index 62387ae632..613d1bb897 100644
--- a/pack-revindex.c
+++ b/pack-revindex.c
@@ -1,7 +1,7 @@
 #include "git-compat-util.h"
 #include "gettext.h"
 #include "pack-revindex.h"
-#include "odb.h"
+#include "odb/odb.h"
 #include "packfile.h"
 #include "strbuf.h"
 #include "trace2.h"
diff --git a/pack-write.c b/pack-write.c
index 24033a9101..86af0ac730 100644
--- a/pack-write.c
+++ b/pack-write.c
@@ -6,7 +6,7 @@
 #include "csum-file.h"
 #include "remote.h"
 #include "chunk-format.h"
-#include "object-file.h"
+#include "odb/object-file.h"
 #include "pack-mtimes.h"
 #include "pack-objects.h"
 #include "pack-revindex.h"
diff --git a/pack.h b/pack.h
index 1cde92082b..2b0be52ded 100644
--- a/pack.h
+++ b/pack.h
@@ -1,7 +1,7 @@
 #ifndef PACK_H
 #define PACK_H
 
-#include "object.h"
+#include "odb/object.h"
 #include "csum-file.h"
 
 struct packed_git;
diff --git a/packfile.c b/packfile.c
index 0eee45055f..2936cbf3fa 100644
--- a/packfile.c
+++ b/packfile.c
@@ -10,15 +10,15 @@
 #include "dir.h"
 #include "packfile.h"
 #include "delta.h"
-#include "hash-lookup.h"
-#include "commit.h"
-#include "object.h"
-#include "tag.h"
+#include "odb/hash-lookup.h"
+#include "odb/commit.h"
+#include "odb/object.h"
+#include "odb/tag.h"
 #include "trace.h"
-#include "tree-walk.h"
-#include "tree.h"
-#include "object-file.h"
-#include "odb.h"
+#include "odb/tree-walk.h"
+#include "odb/tree.h"
+#include "odb/object-file.h"
+#include "odb/odb.h"
 #include "odb/streaming.h"
 #include "midx.h"
 #include "commit-graph.h"
diff --git a/packfile.h b/packfile.h
index e1f77152b5..9859bfb5e0 100644
--- a/packfile.h
+++ b/packfile.h
@@ -2,11 +2,11 @@
 #define PACKFILE_H
 
 #include "list.h"
-#include "object.h"
-#include "odb.h"
+#include "odb/object.h"
+#include "odb/odb.h"
 #include "odb/source-files.h"
 #include "odb/source-packed.h"
-#include "oidset.h"
+#include "odb/oidset.h"
 #include "packfile-list.h"
 #include "repository.h"
 
diff --git a/parallel-checkout.c b/parallel-checkout.c
index 0bf4bd6d4a..85d1c25a81 100644
--- a/parallel-checkout.c
+++ b/parallel-checkout.c
@@ -5,7 +5,7 @@
 #include "config.h"
 #include "entry.h"
 #include "gettext.h"
-#include "hash.h"
+#include "odb/hash.h"
 #include "hex.h"
 #include "parallel-checkout.h"
 #include "pkt-line.h"
diff --git a/parse-options-cb.c b/parse-options-cb.c
index 976cc86385..7826b8ad43 100644
--- a/parse-options-cb.c
+++ b/parse-options-cb.c
@@ -3,16 +3,16 @@
 #include "git-compat-util.h"
 #include "parse-options.h"
 #include "branch.h"
-#include "commit.h"
+#include "odb/commit.h"
 #include "color.h"
 #include "date.h"
 #include "environment.h"
 #include "gettext.h"
-#include "object-name.h"
+#include "odb/object-name.h"
 #include "setup.h"
 #include "string-list.h"
 #include "strvec.h"
-#include "oid-array.h"
+#include "odb/oid-array.h"
 
 /*----- some often used options -----*/
 
diff --git a/patch-ids.c b/patch-ids.c
index 1fbc88cbec..946744e7d9 100644
--- a/patch-ids.c
+++ b/patch-ids.c
@@ -1,7 +1,7 @@
 #include "git-compat-util.h"
 #include "diff.h"
-#include "commit.h"
-#include "hash.h"
+#include "odb/commit.h"
+#include "odb/hash.h"
 #include "hex.h"
 #include "patch-ids.h"
 
diff --git a/path-walk.c b/path-walk.c
index 9ca3248ea8..ed4d3211d2 100644
--- a/path-walk.c
+++ b/path-walk.c
@@ -3,27 +3,27 @@
  */
 #include "git-compat-util.h"
 #include "path-walk.h"
-#include "blob.h"
-#include "commit.h"
+#include "odb/blob.h"
+#include "odb/commit.h"
 #include "dir.h"
 #include "hashmap.h"
 #include "hex.h"
 #include "list-objects.h"
 #include "list-objects-filter-options.h"
-#include "object-name.h"
-#include "odb.h"
-#include "object.h"
-#include "oid-array.h"
+#include "odb/object-name.h"
+#include "odb/odb.h"
+#include "odb/object.h"
+#include "odb/oid-array.h"
 #include "path.h"
 #include "prio-queue.h"
 #include "repository.h"
 #include "revision.h"
 #include "string-list.h"
 #include "strmap.h"
-#include "tag.h"
+#include "odb/tag.h"
 #include "trace2.h"
-#include "tree.h"
-#include "tree-walk.h"
+#include "odb/tree.h"
+#include "odb/tree-walk.h"
 
 static const char *root_path = "";
 
diff --git a/path-walk.h b/path-walk.h
index a2652b2d46..f094610500 100644
--- a/path-walk.h
+++ b/path-walk.h
@@ -2,7 +2,7 @@
  * path-walk.h : Methods and structures for walking the object graph in batches
  * by the paths that can reach those objects.
  */
-#include "object.h" /* Required for 'enum object_type'. */
+#include "odb/object.h" /* Required for 'enum object_type'. */
 
 struct rev_info;
 struct oid_array;
diff --git a/path.c b/path.c
index c3a709a928..3a3a66155a 100644
--- a/path.c
+++ b/path.c
@@ -14,7 +14,7 @@
 #include "submodule-config.h"
 #include "path.h"
 #include "packfile.h"
-#include "odb.h"
+#include "odb/odb.h"
 #include "lockfile.h"
 #include "exec-cmd.h"
 
diff --git a/pretty.c b/pretty.c
index d8a9f370f6..461e8cd527 100644
--- a/pretty.c
+++ b/pretty.c
@@ -3,10 +3,10 @@
 
 #include "git-compat-util.h"
 #include "config.h"
-#include "commit.h"
+#include "odb/commit.h"
 #include "environment.h"
 #include "gettext.h"
-#include "hash.h"
+#include "odb/hash.h"
 #include "hex.h"
 #include "utf8.h"
 #include "diff.h"
@@ -21,7 +21,7 @@
 #include "gpg-interface.h"
 #include "trailer.h"
 #include "run-command.h"
-#include "object-name.h"
+#include "odb/object-name.h"
 
 /*
  * The limit for formatting directives, which enable the caller to append
diff --git a/promisor-remote.c b/promisor-remote.c
index 43505d1e1a..b2188d34c7 100644
--- a/promisor-remote.c
+++ b/promisor-remote.c
@@ -3,7 +3,7 @@
 #include "git-compat-util.h"
 #include "gettext.h"
 #include "hex.h"
-#include "odb.h"
+#include "odb/odb.h"
 #include "promisor-remote.h"
 #include "config.h"
 #include "trace2.h"
diff --git a/protocol-caps.c b/protocol-caps.c
index 02261be14d..edac5dbd05 100644
--- a/protocol-caps.c
+++ b/protocol-caps.c
@@ -3,9 +3,9 @@
 #include "gettext.h"
 #include "hex.h"
 #include "pkt-line.h"
-#include "hash.h"
-#include "object.h"
-#include "odb.h"
+#include "odb/hash.h"
+#include "odb/object.h"
+#include "odb/odb.h"
 #include "repository.h"
 #include "string-list.h"
 #include "strbuf.h"
diff --git a/prune-packed.c b/prune-packed.c
index d49dc11957..f536ef1eaf 100644
--- a/prune-packed.c
+++ b/prune-packed.c
@@ -2,7 +2,7 @@
 
 #include "git-compat-util.h"
 #include "gettext.h"
-#include "object-file.h"
+#include "odb/object-file.h"
 #include "packfile.h"
 #include "progress.h"
 #include "prune-packed.h"
diff --git a/pseudo-merge.c b/pseudo-merge.c
index 22b8600d68..0809a2bcb3 100644
--- a/pseudo-merge.c
+++ b/pseudo-merge.c
@@ -4,14 +4,14 @@
 #include "git-compat-util.h"
 #include "pseudo-merge.h"
 #include "date.h"
-#include "oid-array.h"
+#include "odb/oid-array.h"
 #include "strbuf.h"
 #include "config.h"
 #include "string-list.h"
 #include "refs.h"
 #include "pack-bitmap.h"
-#include "commit.h"
-#include "alloc.h"
+#include "odb/commit.h"
+#include "odb/alloc.h"
 #include "progress.h"
 #include "hex.h"
 
diff --git a/range-diff.c b/range-diff.c
index 8e2dd2eb19..be9f872396 100644
--- a/range-diff.c
+++ b/range-diff.c
@@ -5,7 +5,7 @@
 #include "environment.h"
 #include "gettext.h"
 #include "range-diff.h"
-#include "object-name.h"
+#include "odb/object-name.h"
 #include "string-list.h"
 #include "run-command.h"
 #include "strvec.h"
@@ -13,7 +13,7 @@
 #include "xdiff-interface.h"
 #include "linear-assignment.h"
 #include "diffcore.h"
-#include "commit.h"
+#include "odb/commit.h"
 #include "pager.h"
 #include "pretty.h"
 #include "repository.h"
diff --git a/reachable.c b/reachable.c
index 3079d2c5f4..2a62adf7f5 100644
--- a/reachable.c
+++ b/reachable.c
@@ -4,8 +4,8 @@
 #include "gettext.h"
 #include "hex.h"
 #include "refs.h"
-#include "commit.h"
-#include "blob.h"
+#include "odb/commit.h"
+#include "odb/blob.h"
 #include "diff.h"
 #include "revision.h"
 #include "reachable.h"
@@ -14,7 +14,7 @@
 #include "list-objects.h"
 #include "packfile.h"
 #include "worktree.h"
-#include "object-file.h"
+#include "odb/object-file.h"
 #include "pack-bitmap.h"
 #include "pack-mtimes.h"
 #include "config.h"
diff --git a/read-cache-ll.h b/read-cache-ll.h
index 8eb266cfd1..312e65ff3c 100644
--- a/read-cache-ll.h
+++ b/read-cache-ll.h
@@ -1,7 +1,7 @@
 #ifndef READ_CACHE_LL_H
 #define READ_CACHE_LL_H
 
-#include "hash.h"
+#include "odb/hash.h"
 #include "hashmap.h"
 #include "statinfo.h"
 
diff --git a/read-cache.c b/read-cache.c
index c076984858..8f6b812b5f 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -18,17 +18,17 @@
 #include "cache-tree.h"
 #include "refs.h"
 #include "dir.h"
-#include "object-file.h"
-#include "odb.h"
+#include "odb/object-file.h"
+#include "odb/odb.h"
 #include "odb/transaction.h"
-#include "oid-array.h"
-#include "tree.h"
-#include "commit.h"
+#include "odb/oid-array.h"
+#include "odb/tree.h"
+#include "odb/commit.h"
 #include "environment.h"
 #include "gettext.h"
 #include "mem-pool.h"
 #include "name-hash.h"
-#include "object-name.h"
+#include "odb/object-name.h"
 #include "path.h"
 #include "preload-index.h"
 #include "read-cache.h"
diff --git a/read-cache.h b/read-cache.h
index ab9d40aa81..69a7118a66 100644
--- a/read-cache.h
+++ b/read-cache.h
@@ -2,7 +2,7 @@
 #define READ_CACHE_H
 
 #include "read-cache-ll.h"
-#include "object.h"
+#include "odb/object.h"
 #include "pathspec.h"
 #include "environment.h"
 
diff --git a/rebase-interactive.c b/rebase-interactive.c
index 809f76a87b..df9c2d1275 100644
--- a/rebase-interactive.c
+++ b/rebase-interactive.c
@@ -1,7 +1,7 @@
 #define USE_THE_REPOSITORY_VARIABLE
 
 #include "git-compat-util.h"
-#include "commit.h"
+#include "odb/commit.h"
 #include "editor.h"
 #include "environment.h"
 #include "gettext.h"
@@ -9,10 +9,10 @@
 #include "rebase-interactive.h"
 #include "repository.h"
 #include "strbuf.h"
-#include "commit-slab.h"
+#include "odb/commit-slab.h"
 #include "config.h"
 #include "dir.h"
-#include "object-name.h"
+#include "odb/object-name.h"
 
 static const char edit_todo_list_advice[] =
 N_("You can fix this with 'git rebase --edit-todo' "
diff --git a/ref-filter.c b/ref-filter.c
index bdf54f6f59..8a3d056577 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -11,17 +11,17 @@
 #include "run-command.h"
 #include "refs.h"
 #include "wildmatch.h"
-#include "object-name.h"
-#include "odb.h"
-#include "oid-array.h"
+#include "odb/object-name.h"
+#include "odb/odb.h"
+#include "odb/oid-array.h"
 #include "repo-settings.h"
 #include "repository.h"
-#include "commit.h"
+#include "odb/commit.h"
 #include "mailmap.h"
 #include "ident.h"
 #include "remote.h"
 #include "color.h"
-#include "tag.h"
+#include "odb/tag.h"
 #include "quote.h"
 #include "ref-filter.h"
 #include "revision.h"
@@ -29,7 +29,7 @@
 #include "versioncmp.h"
 #include "trailer.h"
 #include "wt-status.h"
-#include "commit-slab.h"
+#include "odb/commit-slab.h"
 #include "commit-reach.h"
 #include "worktree.h"
 #include "hashmap.h"
diff --git a/ref-filter.h b/ref-filter.h
index 9361296e2a..11180f9570 100644
--- a/ref-filter.h
+++ b/ref-filter.h
@@ -2,8 +2,8 @@
 #define REF_FILTER_H
 
 #include "gettext.h"
-#include "oid-array.h"
-#include "commit.h"
+#include "odb/oid-array.h"
+#include "odb/commit.h"
 #include "string-list.h"
 #include "strvec.h"
 #include "commit-reach.h"
diff --git a/reflog-walk.c b/reflog-walk.c
index 4dbeaa93a7..4058cfa6df 100644
--- a/reflog-walk.c
+++ b/reflog-walk.c
@@ -1,7 +1,7 @@
 #define USE_THE_REPOSITORY_VARIABLE
 
 #include "git-compat-util.h"
-#include "commit.h"
+#include "odb/commit.h"
 #include "refs.h"
 #include "diff.h"
 #include "repository.h"
diff --git a/reflog.c b/reflog.c
index 04edbe5670..178ef7fe44 100644
--- a/reflog.c
+++ b/reflog.c
@@ -6,12 +6,12 @@
 #include "environment.h"
 #include "gettext.h"
 #include "parse-options.h"
-#include "odb.h"
+#include "odb/odb.h"
 #include "reflog.h"
 #include "refs.h"
 #include "revision.h"
-#include "tree.h"
-#include "tree-walk.h"
+#include "odb/tree.h"
+#include "odb/tree-walk.h"
 #include "wildmatch.h"
 
 static struct reflog_expire_entry_option *find_cfg_ent(struct reflog_expire_options *opts,
diff --git a/refs.c b/refs.c
index 92d5df5b71..e01163be2a 100644
--- a/refs.c
+++ b/refs.c
@@ -15,9 +15,9 @@
 #include "refs.h"
 #include "refs/refs-internal.h"
 #include "hook.h"
-#include "object-name.h"
-#include "odb.h"
-#include "object.h"
+#include "odb/object-name.h"
+#include "odb/odb.h"
+#include "odb/object.h"
 #include "path.h"
 #include "submodule.h"
 #include "worktree.h"
@@ -25,10 +25,10 @@
 #include "repo-settings.h"
 #include "setup.h"
 #include "date.h"
-#include "commit.h"
+#include "odb/commit.h"
 #include "wildmatch.h"
 #include "ident.h"
-#include "fsck.h"
+#include "odb/fsck.h"
 
 /*
  * List of all available backends
diff --git a/refs.h b/refs.h
index 9979446d15..1746d1035c 100644
--- a/refs.h
+++ b/refs.h
@@ -1,8 +1,8 @@
 #ifndef REFS_H
 #define REFS_H
 
-#include "object-name.h"
-#include "commit.h"
+#include "odb/object-name.h"
+#include "odb/commit.h"
 #include "repository.h"
 #include "repo-settings.h"
 
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 1cc20aa486..ef7532e727 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -6,9 +6,9 @@
 #include "../copy.h"
 #include "../environment.h"
 #include "../gettext.h"
-#include "../hash.h"
+#include "odb/hash.h"
 #include "../hex.h"
-#include "../fsck.h"
+#include "odb/fsck.h"
 #include "../refs.h"
 #include "../repo-settings.h"
 #include "refs-internal.h"
diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index b9b04b7010..c7005a9ecc 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -3,9 +3,9 @@
 #include "../git-compat-util.h"
 #include "../config.h"
 #include "../dir.h"
-#include "../fsck.h"
+#include "odb/fsck.h"
 #include "../gettext.h"
-#include "../hash.h"
+#include "odb/hash.h"
 #include "../hex.h"
 #include "../refs.h"
 #include "refs-internal.h"
diff --git a/refs/ref-cache.c b/refs/ref-cache.c
index ffef01a597..a4182ea57f 100644
--- a/refs/ref-cache.c
+++ b/refs/ref-cache.c
@@ -1,5 +1,5 @@
 #include "../git-compat-util.h"
-#include "../hash.h"
+#include "odb/hash.h"
 #include "../refs.h"
 #include "../repository.h"
 #include "refs-internal.h"
diff --git a/refs/ref-cache.h b/refs/ref-cache.h
index f635d2d824..7a4fe77a41 100644
--- a/refs/ref-cache.h
+++ b/refs/ref-cache.h
@@ -1,7 +1,7 @@
 #ifndef REFS_REF_CACHE_H
 #define REFS_REF_CACHE_H
 
-#include "hash.h"
+#include "odb/hash.h"
 
 struct ref_dir;
 struct ref_store;
diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
index 028f0211af..9d6194c4e6 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -4,9 +4,9 @@
 #include "../config.h"
 #include "../dir.h"
 #include "../environment.h"
-#include "../fsck.h"
+#include "odb/fsck.h"
 #include "../gettext.h"
-#include "../hash.h"
+#include "odb/hash.h"
 #include "../hex.h"
 #include "../ident.h"
 #include "../iterator.h"
diff --git a/refspec.c b/refspec.c
index 7cb479983b..f3cb1b0748 100644
--- a/refspec.c
+++ b/refspec.c
@@ -2,7 +2,7 @@
 
 #include "git-compat-util.h"
 #include "gettext.h"
-#include "hash.h"
+#include "odb/hash.h"
 #include "hex.h"
 #include "string-list.h"
 #include "strvec.h"
diff --git a/remote-curl.c b/remote-curl.c
index 2c35dd5240..a6a145c046 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -17,7 +17,7 @@
 #include "string-list.h"
 #include "strvec.h"
 #include "credential.h"
-#include "oid-array.h"
+#include "odb/oid-array.h"
 #include "send-pack.h"
 #include "setup.h"
 #include "protocol.h"
diff --git a/remote.c b/remote.c
index fe62068463..89dc91429a 100644
--- a/remote.c
+++ b/remote.c
@@ -12,10 +12,10 @@
 #include "urlmatch.h"
 #include "refs.h"
 #include "refspec.h"
-#include "object-name.h"
-#include "odb.h"
+#include "odb/object-name.h"
+#include "odb/odb.h"
 #include "path.h"
-#include "commit.h"
+#include "odb/commit.h"
 #include "diff.h"
 #include "revision.h"
 #include "dir.h"
diff --git a/remote.h b/remote.h
index cca02033b9..fbf552cc2f 100644
--- a/remote.h
+++ b/remote.h
@@ -1,7 +1,7 @@
 #ifndef REMOTE_H
 #define REMOTE_H
 
-#include "hash.h"
+#include "odb/hash.h"
 #include "hashmap.h"
 #include "refspec.h"
 #include "string-list.h"
diff --git a/repack-midx.c b/repack-midx.c
index 64c7f8d0f4..a9df431952 100644
--- a/repack-midx.c
+++ b/repack-midx.c
@@ -1,11 +1,11 @@
 #include "git-compat-util.h"
 #include "repack.h"
-#include "hash.h"
+#include "odb/hash.h"
 #include "hex.h"
 #include "lockfile.h"
 #include "midx.h"
-#include "odb.h"
-#include "oidset.h"
+#include "odb/odb.h"
+#include "odb/oidset.h"
 #include "pack-bitmap.h"
 #include "path.h"
 #include "refs.h"
diff --git a/repack.c b/repack.c
index d2aa58e134..16da2e35cb 100644
--- a/repack.c
+++ b/repack.c
@@ -1,7 +1,7 @@
 #include "git-compat-util.h"
 #include "dir.h"
 #include "midx.h"
-#include "odb.h"
+#include "odb/odb.h"
 #include "packfile.h"
 #include "path.h"
 #include "repack.h"
diff --git a/replay.c b/replay.c
index 463c900d6c..9e29f29ff6 100644
--- a/replay.c
+++ b/replay.c
@@ -4,13 +4,13 @@
 #include "environment.h"
 #include "hex.h"
 #include "merge-ort.h"
-#include "object-name.h"
+#include "odb/object-name.h"
 #include "refs.h"
 #include "replay.h"
 #include "revision.h"
 #include "sequencer.h"
 #include "strmap.h"
-#include "tree.h"
+#include "odb/tree.h"
 
 /*
  * We technically need USE_THE_REPOSITORY_VARIABLE for DEFAULT_ABBREV, but
diff --git a/replay.h b/replay.h
index 491db145e3..7ec371d6a5 100644
--- a/replay.h
+++ b/replay.h
@@ -1,7 +1,7 @@
 #ifndef REPLAY_H
 #define REPLAY_H
 
-#include "hash.h"
+#include "odb/hash.h"
 
 struct repository;
 struct rev_info;
diff --git a/repository.c b/repository.c
index db4f9d006e..72434e3a50 100644
--- a/repository.c
+++ b/repository.c
@@ -2,17 +2,17 @@
 #include "abspath.h"
 #include "repository.h"
 #include "hook.h"
-#include "odb.h"
+#include "odb/odb.h"
 #include "odb/source.h"
 #include "config.h"
 #include "gettext.h"
-#include "object.h"
+#include "odb/object.h"
 #include "lockfile.h"
 #include "path.h"
 #include "read-cache-ll.h"
 #include "remote.h"
 #include "setup.h"
-#include "loose.h"
+#include "odb/loose.h"
 #include "submodule-config.h"
 #include "sparse-index.h"
 #include "trace2.h"
diff --git a/rerere.c b/rerere.c
index 3d3bd0db16..6ff20d0692 100644
--- a/rerere.c
+++ b/rerere.c
@@ -18,8 +18,8 @@
 #include "merge-ll.h"
 #include "path.h"
 #include "pathspec.h"
-#include "object-file.h"
-#include "odb.h"
+#include "odb/object-file.h"
+#include "odb/odb.h"
 #include "strmap.h"
 
 #define RESOLVED 0
diff --git a/reset.c b/reset.c
index 71254bde93..950d45d07d 100644
--- a/reset.c
+++ b/reset.c
@@ -3,11 +3,11 @@
 #include "gettext.h"
 #include "hex.h"
 #include "lockfile.h"
-#include "object-name.h"
+#include "odb/object-name.h"
 #include "refs.h"
 #include "reset.h"
-#include "tree-walk.h"
-#include "tree.h"
+#include "odb/tree-walk.h"
+#include "odb/tree.h"
 #include "unpack-trees.h"
 #include "hook.h"
 
diff --git a/reset.h b/reset.h
index 4c992ba671..52055ad68d 100644
--- a/reset.h
+++ b/reset.h
@@ -1,7 +1,7 @@
 #ifndef RESET_H
 #define RESET_H
 
-#include "hash.h"
+#include "odb/hash.h"
 #include "repository.h"
 
 #define GIT_REFLOG_ACTION_ENVIRONMENT "GIT_REFLOG_ACTION"
diff --git a/resolve-undo.c b/resolve-undo.c
index 52c45e5a49..a54b6c0f79 100644
--- a/resolve-undo.c
+++ b/resolve-undo.c
@@ -2,7 +2,7 @@
 
 #include "git-compat-util.h"
 #include "dir.h"
-#include "hash.h"
+#include "odb/hash.h"
 #include "read-cache.h"
 #include "resolve-undo.h"
 #include "sparse-index.h"
diff --git a/resolve-undo.h b/resolve-undo.h
index 7ed11a1c59..b10c197cf0 100644
--- a/resolve-undo.h
+++ b/resolve-undo.h
@@ -6,7 +6,7 @@ struct index_state;
 struct pathspec;
 struct string_list;
 
-#include "hash.h"
+#include "odb/hash.h"
 
 struct resolve_undo_info {
 	unsigned int mode[3];
diff --git a/revision.c b/revision.c
index 50dc8b1991..9e90f909da 100644
--- a/revision.c
+++ b/revision.c
@@ -6,14 +6,14 @@
 #include "environment.h"
 #include "gettext.h"
 #include "hex.h"
-#include "object-name.h"
-#include "object-file.h"
-#include "odb.h"
-#include "oidset.h"
-#include "tag.h"
-#include "blob.h"
-#include "tree.h"
-#include "commit.h"
+#include "odb/object-name.h"
+#include "odb/object-file.h"
+#include "odb/odb.h"
+#include "odb/oidset.h"
+#include "odb/tag.h"
+#include "odb/blob.h"
+#include "odb/tree.h"
+#include "odb/commit.h"
 #include "diff.h"
 #include "diff-merges.h"
 #include "refs.h"
@@ -28,7 +28,7 @@
 #include "line-log.h"
 #include "log-tree.h"
 #include "mailmap.h"
-#include "commit-slab.h"
+#include "odb/commit-slab.h"
 #include "cache-tree.h"
 #include "bisect.h"
 #include "packfile.h"
diff --git a/revision.h b/revision.h
index acf6d06b24..e0ff7aa0f2 100644
--- a/revision.h
+++ b/revision.h
@@ -1,14 +1,14 @@
 #ifndef REVISION_H
 #define REVISION_H
 
-#include "commit.h"
+#include "odb/commit.h"
 #include "grep.h"
 #include "notes.h"
-#include "object-name.h"
-#include "oidset.h"
+#include "odb/object-name.h"
+#include "odb/oidset.h"
 #include "pretty.h"
 #include "diff.h"
-#include "commit-slab-decl.h"
+#include "odb/commit-slab-decl.h"
 #include "decorate.h"
 #include "ident.h"
 #include "list-objects-filter-options.h"
diff --git a/send-pack.c b/send-pack.c
index 3bb5afc687..97dcfac586 100644
--- a/send-pack.c
+++ b/send-pack.c
@@ -1,10 +1,10 @@
 #include "git-compat-util.h"
 #include "config.h"
-#include "commit.h"
+#include "odb/commit.h"
 #include "date.h"
 #include "gettext.h"
 #include "hex.h"
-#include "odb.h"
+#include "odb/odb.h"
 #include "pkt-line.h"
 #include "sideband.h"
 #include "run-command.h"
@@ -13,7 +13,7 @@
 #include "send-pack.h"
 #include "transport.h"
 #include "version.h"
-#include "oid-array.h"
+#include "odb/oid-array.h"
 #include "gpg-interface.h"
 #include "shallow.h"
 #include "parse-options.h"
diff --git a/sequencer.c b/sequencer.c
index 83c3849205..67ab3cdf0d 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -11,12 +11,12 @@
 #include "hex.h"
 #include "lockfile.h"
 #include "dir.h"
-#include "object-file.h"
-#include "object-name.h"
-#include "odb.h"
-#include "object.h"
+#include "odb/object-file.h"
+#include "odb/object-name.h"
+#include "odb/odb.h"
+#include "odb/object.h"
 #include "pager.h"
-#include "commit.h"
+#include "odb/commit.h"
 #include "sequencer.h"
 #include "run-command.h"
 #include "hook.h"
@@ -40,9 +40,9 @@
 #include "notes-utils.h"
 #include "sigchain.h"
 #include "unpack-trees.h"
-#include "oidmap.h"
-#include "oidset.h"
-#include "commit-slab.h"
+#include "odb/oidmap.h"
+#include "odb/oidset.h"
+#include "odb/commit-slab.h"
 #include "alias.h"
 #include "commit-reach.h"
 #include "rebase-interactive.h"
diff --git a/serve.c b/serve.c
index 2b07d922b3..95cf3d8ea4 100644
--- a/serve.c
+++ b/serve.c
@@ -1,7 +1,7 @@
 #include "git-compat-util.h"
 #include "repository.h"
 #include "config.h"
-#include "hash.h"
+#include "odb/hash.h"
 #include "pkt-line.h"
 #include "version.h"
 #include "ls-refs.h"
diff --git a/server-info.c b/server-info.c
index 4243e24edc..75ead482e1 100644
--- a/server-info.c
+++ b/server-info.c
@@ -5,13 +5,13 @@
 #include "hex.h"
 #include "repository.h"
 #include "refs.h"
-#include "object.h"
-#include "commit.h"
-#include "tag.h"
+#include "odb/object.h"
+#include "odb/commit.h"
+#include "odb/tag.h"
 #include "packfile.h"
 #include "path.h"
-#include "object-file.h"
-#include "odb.h"
+#include "odb/object-file.h"
+#include "odb/odb.h"
 #include "server-info.h"
 #include "strbuf.h"
 #include "tempfile.h"
diff --git a/setup.c b/setup.c
index 20d29f31f4..fe8e9ffdc5 100644
--- a/setup.c
+++ b/setup.c
@@ -7,8 +7,8 @@
 #include "exec-cmd.h"
 #include "gettext.h"
 #include "hex.h"
-#include "object-file.h"
-#include "object-name.h"
+#include "odb/object-file.h"
+#include "odb/object-name.h"
 #include "refs.h"
 #include "repository.h"
 #include "config.h"
diff --git a/shallow.c b/shallow.c
index 8e244a5669..25116d7a6e 100644
--- a/shallow.c
+++ b/shallow.c
@@ -5,16 +5,16 @@
 #include "repository.h"
 #include "tempfile.h"
 #include "lockfile.h"
-#include "odb.h"
-#include "commit.h"
-#include "tag.h"
+#include "odb/odb.h"
+#include "odb/commit.h"
+#include "odb/tag.h"
 #include "pkt-line.h"
 #include "refs.h"
-#include "oid-array.h"
+#include "odb/oid-array.h"
 #include "path.h"
 #include "diff.h"
 #include "revision.h"
-#include "commit-slab.h"
+#include "odb/commit-slab.h"
 #include "list-objects.h"
 #include "commit-reach.h"
 #include "shallow.h"
diff --git a/shallow.h b/shallow.h
index 6a64db42c9..0cb1d5ba70 100644
--- a/shallow.h
+++ b/shallow.h
@@ -1,9 +1,9 @@
 #ifndef SHALLOW_H
 #define SHALLOW_H
 
-#include "commit.h"
+#include "odb/commit.h"
 #include "lockfile.h"
-#include "object.h"
+#include "odb/object.h"
 #include "repository.h"
 #include "strbuf.h"
 
diff --git a/sparse-index.c b/sparse-index.c
index c1fa231a89..8e00862442 100644
--- a/sparse-index.c
+++ b/sparse-index.c
@@ -9,7 +9,7 @@
 #include "read-cache-ll.h"
 #include "repository.h"
 #include "sparse-index.h"
-#include "tree.h"
+#include "odb/tree.h"
 #include "pathspec.h"
 #include "trace2.h"
 #include "cache-tree.h"
diff --git a/split-index.c b/split-index.c
index 6ba210738c..2737cc6118 100644
--- a/split-index.c
+++ b/split-index.c
@@ -2,7 +2,7 @@
 
 #include "git-compat-util.h"
 #include "gettext.h"
-#include "hash.h"
+#include "odb/hash.h"
 #include "mem-pool.h"
 #include "read-cache-ll.h"
 #include "repository.h"
diff --git a/split-index.h b/split-index.h
index 1a153f47ba..6bfab742aa 100644
--- a/split-index.h
+++ b/split-index.h
@@ -1,7 +1,7 @@
 #ifndef SPLIT_INDEX_H
 #define SPLIT_INDEX_H
 
-#include "hash.h"
+#include "odb/hash.h"
 
 struct index_state;
 struct strbuf;
diff --git a/submodule-config.c b/submodule-config.c
index f75997402a..094e64d8fd 100644
--- a/submodule-config.c
+++ b/submodule-config.c
@@ -12,12 +12,12 @@
 #include "submodule-config.h"
 #include "submodule.h"
 #include "strbuf.h"
-#include "object-name.h"
-#include "odb.h"
+#include "odb/object-name.h"
+#include "odb/odb.h"
 #include "odb/source.h"
 #include "parse-options.h"
 #include "thread-utils.h"
-#include "tree-walk.h"
+#include "odb/tree-walk.h"
 #include "url.h"
 #include "urlmatch.h"
 
diff --git a/submodule-config.h b/submodule-config.h
index f55d4e3b61..3f4f0bf454 100644
--- a/submodule-config.h
+++ b/submodule-config.h
@@ -3,7 +3,7 @@
 
 #include "config.h"
 #include "submodule.h"
-#include "tree-walk.h"
+#include "odb/tree-walk.h"
 
 /**
  * The submodule config cache API allows to read submodule
diff --git a/submodule.c b/submodule.c
index 5c92575888..d091b484a4 100644
--- a/submodule.c
+++ b/submodule.c
@@ -9,7 +9,7 @@
 #include "submodule.h"
 #include "dir.h"
 #include "diff.h"
-#include "commit.h"
+#include "odb/commit.h"
 #include "environment.h"
 #include "gettext.h"
 #include "hex.h"
@@ -18,16 +18,16 @@
 #include "diffcore.h"
 #include "refs.h"
 #include "string-list.h"
-#include "oid-array.h"
+#include "odb/oid-array.h"
 #include "strvec.h"
 #include "thread-utils.h"
 #include "path.h"
 #include "remote.h"
 #include "worktree.h"
 #include "parse-options.h"
-#include "object-file.h"
-#include "object-name.h"
-#include "odb.h"
+#include "odb/object-file.h"
+#include "odb/object-name.h"
+#include "odb/odb.h"
 #include "commit-reach.h"
 #include "read-cache-ll.h"
 #include "setup.h"
diff --git a/t/helper/test-bitmap.c b/t/helper/test-bitmap.c
index 8547ef67e2..f1f48e973d 100644
--- a/t/helper/test-bitmap.c
+++ b/t/helper/test-bitmap.c
@@ -3,7 +3,7 @@
 #include "test-tool.h"
 #include "git-compat-util.h"
 #include "hex.h"
-#include "odb.h"
+#include "odb/odb.h"
 #include "pack-bitmap.h"
 #include "pseudo-merge.h"
 #include "setup.h"
diff --git a/t/helper/test-bloom.c b/t/helper/test-bloom.c
index 0c65befbf0..48ff2c6024 100644
--- a/t/helper/test-bloom.c
+++ b/t/helper/test-bloom.c
@@ -3,7 +3,7 @@
 #include "test-tool.h"
 #include "bloom.h"
 #include "hex.h"
-#include "commit.h"
+#include "odb/commit.h"
 #include "repository.h"
 #include "setup.h"
 
diff --git a/t/helper/test-cache-tree.c b/t/helper/test-cache-tree.c
index d42e260092..9f613d2911 100644
--- a/t/helper/test-cache-tree.c
+++ b/t/helper/test-cache-tree.c
@@ -4,7 +4,7 @@
 #include "test-tool.h"
 #include "gettext.h"
 #include "hex.h"
-#include "tree.h"
+#include "odb/tree.h"
 #include "cache-tree.h"
 #include "parse-options.h"
 #include "read-cache-ll.h"
diff --git a/t/helper/test-dump-cache-tree.c b/t/helper/test-dump-cache-tree.c
index ccb41a4239..849727d69b 100644
--- a/t/helper/test-dump-cache-tree.c
+++ b/t/helper/test-dump-cache-tree.c
@@ -1,9 +1,9 @@
 #define USE_THE_REPOSITORY_VARIABLE
 
 #include "test-tool.h"
-#include "hash.h"
+#include "odb/hash.h"
 #include "hex.h"
-#include "tree.h"
+#include "odb/tree.h"
 #include "cache-tree.h"
 #include "read-cache-ll.h"
 #include "repository.h"
diff --git a/t/helper/test-find-pack.c b/t/helper/test-find-pack.c
index 28d5b1fe09..c7475ed4d9 100644
--- a/t/helper/test-find-pack.c
+++ b/t/helper/test-find-pack.c
@@ -1,8 +1,8 @@
 #define USE_THE_REPOSITORY_VARIABLE
 
 #include "test-tool.h"
-#include "object-name.h"
-#include "odb.h"
+#include "odb/object-name.h"
+#include "odb/odb.h"
 #include "packfile.h"
 #include "parse-options.h"
 #include "setup.h"
diff --git a/t/helper/test-hash-speed.c b/t/helper/test-hash-speed.c
index 89b0268011..4c71b04c57 100644
--- a/t/helper/test-hash-speed.c
+++ b/t/helper/test-hash-speed.c
@@ -1,5 +1,5 @@
 #include "test-tool.h"
-#include "hash.h"
+#include "odb/hash.h"
 
 #define NUM_SECONDS 3
 
diff --git a/t/helper/test-match-trees.c b/t/helper/test-match-trees.c
index 006ce5278e..b6122af08f 100644
--- a/t/helper/test-match-trees.c
+++ b/t/helper/test-match-trees.c
@@ -2,11 +2,11 @@
 
 #include "test-tool.h"
 #include "hex.h"
-#include "match-trees.h"
-#include "object-name.h"
+#include "odb/match-trees.h"
+#include "odb/object-name.h"
 #include "repository.h"
 #include "setup.h"
-#include "tree.h"
+#include "odb/tree.h"
 
 int cmd__match_trees(int ac UNUSED, const char **av)
 {
diff --git a/t/helper/test-pack-deltas.c b/t/helper/test-pack-deltas.c
index 840797cf0d..7e5791c7ab 100644
--- a/t/helper/test-pack-deltas.c
+++ b/t/helper/test-pack-deltas.c
@@ -4,7 +4,7 @@
 #include "git-compat-util.h"
 #include "delta.h"
 #include "git-zlib.h"
-#include "hash.h"
+#include "odb/hash.h"
 #include "hex.h"
 #include "pack.h"
 #include "pack-objects.h"
diff --git a/t/helper/test-pack-mtimes.c b/t/helper/test-pack-mtimes.c
index b774056799..b915059322 100644
--- a/t/helper/test-pack-mtimes.c
+++ b/t/helper/test-pack-mtimes.c
@@ -3,7 +3,7 @@
 #include "test-tool.h"
 #include "hex.h"
 #include "strbuf.h"
-#include "odb.h"
+#include "odb/odb.h"
 #include "packfile.h"
 #include "pack-mtimes.h"
 #include "setup.h"
diff --git a/t/helper/test-partial-clone.c b/t/helper/test-partial-clone.c
index 87c59108e0..76fc0329fc 100644
--- a/t/helper/test-partial-clone.c
+++ b/t/helper/test-partial-clone.c
@@ -3,7 +3,7 @@
 #include "test-tool.h"
 #include "hex.h"
 #include "repository.h"
-#include "odb.h"
+#include "odb/odb.h"
 #include "setup.h"
 
 /*
diff --git a/t/helper/test-path-walk.c b/t/helper/test-path-walk.c
index 4233badb58..f41c6be2c6 100644
--- a/t/helper/test-path-walk.c
+++ b/t/helper/test-path-walk.c
@@ -5,15 +5,15 @@
 #include "environment.h"
 #include "hex.h"
 #include "list-objects-filter-options.h"
-#include "object-name.h"
-#include "object.h"
+#include "odb/object-name.h"
+#include "odb/object.h"
 #include "pretty.h"
 #include "revision.h"
 #include "setup.h"
 #include "parse-options.h"
 #include "strbuf.h"
 #include "path-walk.h"
-#include "oid-array.h"
+#include "odb/oid-array.h"
 
 static const char * const path_walk_usage[] = {
 	N_("test-tool path-walk <options> -- <revision-options>"),
diff --git a/t/helper/test-reach.c b/t/helper/test-reach.c
index 5d86a96c17..4151cfbe25 100644
--- a/t/helper/test-reach.c
+++ b/t/helper/test-reach.c
@@ -1,15 +1,15 @@
 #define USE_THE_REPOSITORY_VARIABLE
 
 #include "test-tool.h"
-#include "commit.h"
+#include "odb/commit.h"
 #include "commit-reach.h"
 #include "gettext.h"
 #include "hex.h"
-#include "object-name.h"
+#include "odb/object-name.h"
 #include "ref-filter.h"
 #include "setup.h"
 #include "string-list.h"
-#include "tag.h"
+#include "odb/tag.h"
 
 static void print_sorted_commit_ids(struct commit_list *list)
 {
diff --git a/t/helper/test-read-graph.c b/t/helper/test-read-graph.c
index 9f07b9c25a..965700a698 100644
--- a/t/helper/test-read-graph.c
+++ b/t/helper/test-read-graph.c
@@ -3,7 +3,7 @@
 #include "test-tool.h"
 #include "commit-graph.h"
 #include "repository.h"
-#include "odb.h"
+#include "odb/odb.h"
 #include "bloom.h"
 #include "setup.h"
 
diff --git a/t/helper/test-read-midx.c b/t/helper/test-read-midx.c
index fb16ec0176..9be143ee6c 100644
--- a/t/helper/test-read-midx.c
+++ b/t/helper/test-read-midx.c
@@ -4,7 +4,7 @@
 #include "hex.h"
 #include "midx.h"
 #include "repository.h"
-#include "odb.h"
+#include "odb/odb.h"
 #include "pack-bitmap.h"
 #include "packfile.h"
 #include "setup.h"
diff --git a/t/helper/test-ref-store.c b/t/helper/test-ref-store.c
index 5a9a3053d9..1fbdc52fc5 100644
--- a/t/helper/test-ref-store.c
+++ b/t/helper/test-ref-store.c
@@ -5,7 +5,7 @@
 #include "refs.h"
 #include "setup.h"
 #include "worktree.h"
-#include "odb.h"
+#include "odb/odb.h"
 #include "path.h"
 #include "repository.h"
 #include "strbuf.h"
diff --git a/t/helper/test-reftable.c b/t/helper/test-reftable.c
index fc49fafc34..e469f850ce 100644
--- a/t/helper/test-reftable.c
+++ b/t/helper/test-reftable.c
@@ -1,5 +1,5 @@
 #include "git-compat-util.h"
-#include "hash.h"
+#include "odb/hash.h"
 #include "hex.h"
 #include "reftable/system.h"
 #include "reftable/reftable-constants.h"
diff --git a/t/helper/test-repository.c b/t/helper/test-repository.c
index 9ba94cdffa..530e37b01d 100644
--- a/t/helper/test-repository.c
+++ b/t/helper/test-repository.c
@@ -2,13 +2,13 @@
 
 #include "test-tool.h"
 #include "commit-graph.h"
-#include "commit.h"
+#include "odb/commit.h"
 #include "environment.h"
 #include "hex.h"
-#include "object.h"
+#include "odb/object.h"
 #include "repository.h"
 #include "setup.h"
-#include "tree.h"
+#include "odb/tree.h"
 
 static void test_parse_commit_in_graph(const char *gitdir, const char *worktree,
 				       const struct object_id *commit_oid)
diff --git a/t/helper/test-revision-walking.c b/t/helper/test-revision-walking.c
index 24d7f29417..1b7f569f01 100644
--- a/t/helper/test-revision-walking.c
+++ b/t/helper/test-revision-walking.c
@@ -11,10 +11,10 @@
 #define USE_THE_REPOSITORY_VARIABLE
 
 #include "test-tool.h"
-#include "commit.h"
+#include "odb/commit.h"
 #include "diff.h"
 #include "line-log.h"
-#include "object-name.h"
+#include "odb/object-name.h"
 #include "repository.h"
 #include "revision.h"
 #include "setup.h"
diff --git a/t/helper/test-scrap-cache-tree.c b/t/helper/test-scrap-cache-tree.c
index 7b5ce501d9..f4f7df067d 100644
--- a/t/helper/test-scrap-cache-tree.c
+++ b/t/helper/test-scrap-cache-tree.c
@@ -5,7 +5,7 @@
 #include "read-cache-ll.h"
 #include "repository.h"
 #include "setup.h"
-#include "tree.h"
+#include "odb/tree.h"
 #include "cache-tree.h"
 
 int cmd__scrap_cache_tree(int ac UNUSED, const char **av UNUSED)
diff --git a/t/helper/test-sha1.c b/t/helper/test-sha1.c
index 349540c4df..c45e56c23f 100644
--- a/t/helper/test-sha1.c
+++ b/t/helper/test-sha1.c
@@ -1,5 +1,5 @@
 #include "test-tool.h"
-#include "hash.h"
+#include "odb/hash.h"
 
 int cmd__sha1(int ac, const char **av)
 {
diff --git a/t/helper/test-sha256.c b/t/helper/test-sha256.c
index 7fd0aa1fcd..078ce7d78b 100644
--- a/t/helper/test-sha256.c
+++ b/t/helper/test-sha256.c
@@ -1,5 +1,5 @@
 #include "test-tool.h"
-#include "hash.h"
+#include "odb/hash.h"
 
 int cmd__sha256(int ac, const char **av)
 {
diff --git a/t/helper/test-submodule-config.c b/t/helper/test-submodule-config.c
index 3f30292179..7a756d4f8d 100644
--- a/t/helper/test-submodule-config.c
+++ b/t/helper/test-submodule-config.c
@@ -2,8 +2,8 @@
 
 #include "test-tool.h"
 #include "config.h"
-#include "hash.h"
-#include "object-name.h"
+#include "odb/hash.h"
+#include "odb/object-name.h"
 #include "repository.h"
 #include "setup.h"
 #include "submodule-config.h"
diff --git a/t/helper/test-synthesize.c b/t/helper/test-synthesize.c
index fd116c87ba..57013566cc 100644
--- a/t/helper/test-synthesize.c
+++ b/t/helper/test-synthesize.c
@@ -3,10 +3,10 @@
 #include "test-tool.h"
 #include "git-compat-util.h"
 #include "git-zlib.h"
-#include "hash.h"
+#include "odb/hash.h"
 #include "hex.h"
-#include "object-file.h"
-#include "object.h"
+#include "odb/object-file.h"
+#include "odb/object.h"
 #include "pack.h"
 #include "parse-options.h"
 #include "parse.h"
diff --git a/t/unit-tests/lib-oid.h b/t/unit-tests/lib-oid.h
index 4031775104..4f47d1b0c3 100644
--- a/t/unit-tests/lib-oid.h
+++ b/t/unit-tests/lib-oid.h
@@ -1,7 +1,7 @@
 #ifndef LIB_OID_H
 #define LIB_OID_H
 
-#include "hash.h"
+#include "odb/hash.h"
 
 /*
  * Convert arbitrary hex string to object_id.
diff --git a/t/unit-tests/u-example-decorate.c b/t/unit-tests/u-example-decorate.c
index 9b1d1ce753..2f01340c21 100644
--- a/t/unit-tests/u-example-decorate.c
+++ b/t/unit-tests/u-example-decorate.c
@@ -1,7 +1,7 @@
 #define USE_THE_REPOSITORY_VARIABLE
 
 #include "unit-test.h"
-#include "object.h"
+#include "odb/object.h"
 #include "decorate.h"
 #include "repository.h"
 
diff --git a/t/unit-tests/u-odb-inmemory.c b/t/unit-tests/u-odb-inmemory.c
index 2def1b9a62..4f923f7267 100644
--- a/t/unit-tests/u-odb-inmemory.c
+++ b/t/unit-tests/u-odb-inmemory.c
@@ -1,9 +1,9 @@
 #include "unit-test.h"
 #include "hex.h"
-#include "object-file.h"
+#include "odb/object-file.h"
 #include "odb/source-inmemory.h"
 #include "odb/streaming.h"
-#include "oidset.h"
+#include "odb/oidset.h"
 #include "repository.h"
 #include "strbuf.h"
 
diff --git a/t/unit-tests/u-oid-array.c b/t/unit-tests/u-oid-array.c
index e48a433f21..71e62892f1 100644
--- a/t/unit-tests/u-oid-array.c
+++ b/t/unit-tests/u-oid-array.c
@@ -2,7 +2,7 @@
 
 #include "unit-test.h"
 #include "lib-oid.h"
-#include "oid-array.h"
+#include "odb/oid-array.h"
 #include "hex.h"
 
 static void fill_array(struct oid_array *array, const char *hexes[], size_t n)
diff --git a/t/unit-tests/u-oidmap.c b/t/unit-tests/u-oidmap.c
index 00481df63f..74417ced32 100644
--- a/t/unit-tests/u-oidmap.c
+++ b/t/unit-tests/u-oidmap.c
@@ -1,7 +1,7 @@
 #include "unit-test.h"
 #include "lib-oid.h"
-#include "oidmap.h"
-#include "hash.h"
+#include "odb/oidmap.h"
+#include "odb/hash.h"
 #include "hex.h"
 
 /*
diff --git a/t/unit-tests/u-oidtree.c b/t/unit-tests/u-oidtree.c
index f0d5ebb733..7372b87674 100644
--- a/t/unit-tests/u-oidtree.c
+++ b/t/unit-tests/u-oidtree.c
@@ -1,7 +1,7 @@
 #include "unit-test.h"
 #include "lib-oid.h"
-#include "oidtree.h"
-#include "hash.h"
+#include "odb/oidtree.h"
+#include "odb/hash.h"
 #include "hex.h"
 #include "strvec.h"
 
diff --git a/trailer.c b/trailer.c
index 6d8ec7fa8d..33fd1df188 100644
--- a/trailer.c
+++ b/trailer.c
@@ -6,7 +6,7 @@
 #include "gettext.h"
 #include "string-list.h"
 #include "run-command.h"
-#include "commit.h"
+#include "odb/commit.h"
 #include "strvec.h"
 #include "trailer.h"
 #include "list.h"
diff --git a/transport-helper.c b/transport-helper.c
index b109fbd8c3..59f61f23c6 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -4,11 +4,11 @@
 #include "transport.h"
 #include "quote.h"
 #include "run-command.h"
-#include "commit.h"
+#include "odb/commit.h"
 #include "environment.h"
 #include "gettext.h"
 #include "hex.h"
-#include "object-name.h"
+#include "odb/object-name.h"
 #include "repository.h"
 #include "remote.h"
 #include "string-list.h"
diff --git a/transport.c b/transport.c
index 42b0a2d0bd..5b83cf9e73 100644
--- a/transport.c
+++ b/transport.c
@@ -22,12 +22,12 @@
 #include "submodule.h"
 #include "strbuf.h"
 #include "string-list.h"
-#include "oid-array.h"
+#include "odb/oid-array.h"
 #include "sigchain.h"
 #include "trace2.h"
 #include "transport-internal.h"
 #include "protocol.h"
-#include "object-name.h"
+#include "odb/object-name.h"
 #include "color.h"
 #include "bundle-uri.h"
 #include "sideband.h"
diff --git a/tree-diff.c b/tree-diff.c
index 2f5c956d02..b33c45b696 100644
--- a/tree-diff.c
+++ b/tree-diff.c
@@ -7,9 +7,9 @@
 #include "git-compat-util.h"
 #include "diff.h"
 #include "diffcore.h"
-#include "hash.h"
-#include "tree.h"
-#include "tree-walk.h"
+#include "odb/hash.h"
+#include "odb/tree.h"
+#include "odb/tree-walk.h"
 #include "repository.h"
 #include "dir.h"
 
diff --git a/unpack-trees.c b/unpack-trees.c
index 154d6d40a1..d6e05207a8 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -11,8 +11,8 @@
 #include "gettext.h"
 #include "hex.h"
 #include "name-hash.h"
-#include "tree.h"
-#include "tree-walk.h"
+#include "odb/tree.h"
+#include "odb/tree-walk.h"
 #include "cache-tree.h"
 #include "unpack-trees.h"
 #include "progress.h"
@@ -26,7 +26,7 @@
 #include "symlinks.h"
 #include "trace2.h"
 #include "fsmonitor.h"
-#include "odb.h"
+#include "odb/odb.h"
 #include "promisor-remote.h"
 #include "entry.h"
 #include "parallel-checkout.h"
diff --git a/unpack-trees.h b/unpack-trees.h
index 5867e26e17..d9d3ce09fd 100644
--- a/unpack-trees.h
+++ b/unpack-trees.h
@@ -5,7 +5,7 @@
 #include "read-cache-ll.h"
 #include "strvec.h"
 #include "string-list.h"
-#include "tree-walk.h"
+#include "odb/tree-walk.h"
 
 #define MAX_UNPACK_TREES 8
 
diff --git a/upload-pack.c b/upload-pack.c
index a52856d869..5c12af2219 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -10,10 +10,10 @@
 #include "pkt-line.h"
 #include "sideband.h"
 #include "repository.h"
-#include "odb.h"
-#include "oid-array.h"
-#include "object.h"
-#include "commit.h"
+#include "odb/odb.h"
+#include "odb/oid-array.h"
+#include "odb/object.h"
+#include "odb/commit.h"
 #include "diff.h"
 #include "revision.h"
 #include "list-objects-filter-options.h"
diff --git a/walker.c b/walker.c
index e3de77f092..876865d20a 100644
--- a/walker.c
+++ b/walker.c
@@ -5,13 +5,13 @@
 #include "hex.h"
 #include "walker.h"
 #include "repository.h"
-#include "odb.h"
-#include "commit.h"
+#include "odb/odb.h"
+#include "odb/commit.h"
 #include "strbuf.h"
-#include "tree.h"
-#include "tree-walk.h"
-#include "tag.h"
-#include "blob.h"
+#include "odb/tree.h"
+#include "odb/tree-walk.h"
+#include "odb/tag.h"
+#include "odb/blob.h"
 #include "refs.h"
 #include "progress.h"
 #include "prio-queue.h"
diff --git a/wt-status.c b/wt-status.c
index 57772c7501..950ebc3418 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -4,15 +4,15 @@
 #include "git-compat-util.h"
 #include "advice.h"
 #include "wt-status.h"
-#include "object.h"
+#include "odb/object.h"
 #include "dir.h"
-#include "commit.h"
+#include "odb/commit.h"
 #include "diff.h"
 #include "environment.h"
 #include "gettext.h"
-#include "hash.h"
+#include "odb/hash.h"
 #include "hex.h"
-#include "object-name.h"
+#include "odb/object-name.h"
 #include "path.h"
 #include "revision.h"
 #include "diffcore.h"
@@ -29,7 +29,7 @@
 #include "strbuf.h"
 #include "trace.h"
 #include "trace2.h"
-#include "tree.h"
+#include "odb/tree.h"
 #include "utf8.h"
 #include "worktree.h"
 #include "lockfile.h"
diff --git a/xdiff-interface.c b/xdiff-interface.c
index db6938689f..af18a34ba0 100644
--- a/xdiff-interface.c
+++ b/xdiff-interface.c
@@ -5,7 +5,7 @@
 #include "gettext.h"
 #include "config.h"
 #include "hex.h"
-#include "odb.h"
+#include "odb/odb.h"
 #include "strbuf.h"
 #include "xdiff-interface.h"
 #include "xdiff/xtypes.h"
diff --git a/xdiff-interface.h b/xdiff-interface.h
index ce54e1c0e0..3ace6f0bc0 100644
--- a/xdiff-interface.h
+++ b/xdiff-interface.h
@@ -1,7 +1,7 @@
 #ifndef XDIFF_INTERFACE_H
 #define XDIFF_INTERFACE_H
 
-#include "hash.h"
+#include "odb/hash.h"
 #include "xdiff/xdiff.h"
 
 struct object_database;
-- 
2.54.0

