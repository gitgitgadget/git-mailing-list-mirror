Received: from flow-a7-smtp.messagingengine.com (flow-a7-smtp.messagingengine.com [103.168.172.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7EC31D5CC2
	for <git@vger.kernel.org>; Thu,  5 Dec 2024 09:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733391420; cv=none; b=mrwTYvSBf3gcJZq2EtQO1CYZdm66omIFn9TX6HGNqPnNjfi4OLOnwhnsX6ry4QtdIalLntqASonkvqEtvpLcmMHnKPCw+qGQnxWHzgVM0VtEIjKeuhq+JXNxXG40f2CI2OZlZOP38unoJHzlEPhPyjzNr5ll3nTvgYmUJHSb+aY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733391420; c=relaxed/simple;
	bh=tPGi3gPUWYikLwnGewTguUzZjvP8uWzJDMbu5Lf0+iI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=azKVQkyqNVUnl7ARfKTUNV7GsK8vnkqYH0IM/pu7yh2aRY3846l1xUdog00d6UoHXrYJQ3rYkWvXCJ1bEOXe8kEpcsAuXGJwtwiw9DgSj6j4oUt/sIcn+RdtEpfRRo/U466uEdBgdSDtWqHLFaz134YL4ZocivH4+y1sfKhZS58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=JI6jSR3+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=zT32oqCy; arc=none smtp.client-ip=103.168.172.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="JI6jSR3+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="zT32oqCy"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailflow.phl.internal (Postfix) with ESMTP id 9DDCE2005BF;
	Thu,  5 Dec 2024 04:36:53 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Thu, 05 Dec 2024 04:36:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1733391413;
	 x=1733398613; bh=iI0WBaIvFAIvosV7F1+B2M992mABXScZcd1q5N1+HE4=; b=
	JI6jSR3+u2P6fyB2JZaC0a/IP8DeUElg+CNAiN58Wke2isEyY9smiZhBBUdxO8Ez
	biqGhDJAGku7YI+jJ1lcPXj3Ko1tDt+59+FXzgZRKz4jniJjKQqx2LIP2zn6kRdm
	1/kC2ekZj9uY6ZAQXBPp9h2mlAPEes1wehkX/VolZjIT+Xp7LO0Y6Tp8lGWYHnNi
	LI1nY2LQ+/EuoO9D3PW+Of0t6dIc4sOQrXWfWuBS4Uv4vS/DrOgUpbkRBeubxWpt
	g30BT9A+N7eKx25nb96K2QlBFKXItJnupsn8cFgNITv7WggyfqjNi/uHQZjCK/eS
	2s9bUp7MCBTf67njxO11/Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1733391413; x=
	1733398613; bh=iI0WBaIvFAIvosV7F1+B2M992mABXScZcd1q5N1+HE4=; b=z
	T32oqCygsIDXPHMhJJ4fCPfgN9lz7TcSuVvTxQCp38URMBJiJUQ8nYKVk2rThfV+
	Z0JQ9pSvXrTHS3v//q9yXI0ZVKVKUFDZwPQa3pkRAKws27qrS9M0QDIj0mfjFwsa
	+zaAavpJOK1TRwMbss0GZKKeqnhhtwkQjchxk5l4lEeO/EQItZvvKZbegWpjebXU
	AufK5Iowz4I6di/Nngv1UNZLYh04JjsSjKMG1veyVw7e7oxAva9Yvfx6Fuzx8G8J
	N94dMG/aUHH5q7yQRsqRrxuT7jxlyg4A497Iy6oSpvD1OktdcIWEQDXKGyOnM0IK
	BbVtOsGOBbQ2Tt7idoQVg==
X-ME-Sender: <xms:NXRRZyot0tdStUoLM-Hk2l1Q95w3XIoK9XlnH0gpfMfhtg9pB3dHug>
    <xme:NXRRZwoTvw_-VyET4IWxPbLFmt8dJdED5v5lC-IDSNohU92zIv5LsZ4B-HQFYGUJD
    Xx_Gn_PjP22H008Qw>
X-ME-Received: <xmr:NXRRZ3NvDpDSXUSDbcRGlZTjH_78tlnVEK-prPpRzMeCgi9I0d5kFfU33gUieIHgv_wQbPtQBdx9FdM0Sn15CkBfS0iwCGu1k9O4Go3EWkDnzQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrieejgddthecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecuogfuphgrmhgfrhhlucdlfe
    dttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtkeertdertdejnecuhfhrohhm
    pefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtf
    frrghtthgvrhhnpeefveetvddvjeeivdduueejudehgeehleeggfeiheevkeduveekhffg
    tdfhgffhheenucffohhmrghinhepghhnuhdrohhrghdpghhoohhglhgvrdgtohhmnecuuf
    hprghmfghrlhephhhtthhpmedssdiffiifrdhgnhhurdhorhhgsdhlihgtvghnshgvshen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehshhgvjhhirghluhhosehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsth
    gvrhesphhosghogidrtghomhdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhr
    tghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:NXRRZx4yLgtnBQnGgy1Z0L_kiT341yvd5JAAjL6ERB8x4I8o0Kq7OQ>
    <xmx:NXRRZx4PnrdWL02Lt4lULnK-9sA3MFcRaox8L2mAXYZUJy7EgSbVGA>
    <xmx:NXRRZxgAcKRkQyQDxupkEyl1Mq0OmEWFkSGEO2DmEHPSxB_2YctNxw>
    <xmx:NXRRZ74rg_wqEbzI78T8qWCXP7KGXqpC2iru-SHrcGylDftKmFyH4Q>
    <xmx:NXRRZzQjwh2P-1Pq6Pa38AkUOvkHrdlkWeNmuTQbaV_YtDKubp1_5_wC>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Dec 2024 04:36:52 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 7625eb51 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 5 Dec 2024 09:35:29 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 05 Dec 2024 10:36:26 +0100
Subject: [PATCH v3 04/15] global: mark code units that generate warnings
 with `-Wsign-compare`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241205-pks-sign-compare-v3-4-e211ee089717@pks.im>
References: <20241205-pks-sign-compare-v3-0-e211ee089717@pks.im>
In-Reply-To: <20241205-pks-sign-compare-v3-0-e211ee089717@pks.im>
To: git@vger.kernel.org
Cc: shejialuo <shejialuo@gmail.com>, Jeff King <peff@peff.net>, 
 Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.2

Mark code units that generate warnings with `-Wsign-compare`. This
allows for a structured approach to get rid of all such warnings over
time in a way that can be easily measured.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 add-interactive.c                    | 1 +
 add-patch.c                          | 1 +
 advice.c                             | 2 ++
 apply.c                              | 1 +
 archive.c                            | 1 +
 attr.c                               | 1 +
 base85.c                             | 2 ++
 bisect.c                             | 1 +
 blame.c                              | 1 +
 bloom.c                              | 2 ++
 builtin/add.c                        | 3 +++
 builtin/am.c                         | 2 ++
 builtin/bisect.c                     | 2 ++
 builtin/blame.c                      | 3 +++
 builtin/branch.c                     | 3 +++
 builtin/cat-file.c                   | 3 +++
 builtin/checkout--worker.c           | 2 ++
 builtin/checkout-index.c             | 3 +++
 builtin/checkout.c                   | 2 ++
 builtin/clean.c                      | 3 +++
 builtin/clone.c                      | 3 +++
 builtin/commit.c                     | 3 +++
 builtin/describe.c                   | 2 ++
 builtin/diff-files.c                 | 3 +++
 builtin/diff-index.c                 | 2 ++
 builtin/diff-tree.c                  | 2 ++
 builtin/diff.c                       | 3 +++
 builtin/difftool.c                   | 3 +++
 builtin/fast-export.c                | 3 +++
 builtin/fast-import.c                | 2 ++
 builtin/fetch-pack.c                 | 2 ++
 builtin/fetch.c                      | 3 +++
 builtin/for-each-repo.c              | 2 ++
 builtin/fsmonitor--daemon.c          | 2 ++
 builtin/gc.c                         | 3 +++
 builtin/grep.c                       | 3 +++
 builtin/help.c                       | 4 +++-
 builtin/index-pack.c                 | 2 ++
 builtin/log.c                        | 3 +++
 builtin/ls-files.c                   | 3 +++
 builtin/mailsplit.c                  | 3 +++
 builtin/merge-file.c                 | 2 ++
 builtin/merge-index.c                | 2 ++
 builtin/merge-ours.c                 | 3 +++
 builtin/merge-tree.c                 | 2 ++
 builtin/merge.c                      | 3 +++
 builtin/mv.c                         | 2 ++
 builtin/name-rev.c                   | 2 ++
 builtin/pack-objects.c               | 2 ++
 builtin/pack-redundant.c             | 2 ++
 builtin/pack-refs.c                  | 2 ++
 builtin/patch-id.c                   | 2 ++
 builtin/prune.c                      | 2 ++
 builtin/pull.c                       | 2 ++
 builtin/push.c                       | 3 +++
 builtin/range-diff.c                 | 2 ++
 builtin/rebase.c                     | 3 +++
 builtin/receive-pack.c               | 2 ++
 builtin/reflog.c                     | 2 ++
 builtin/remote.c                     | 2 ++
 builtin/repack.c                     | 2 ++
 builtin/replay.c                     | 4 +++-
 builtin/rerere.c                     | 2 ++
 builtin/reset.c                      | 3 +++
 builtin/rev-list.c                   | 2 ++
 builtin/rev-parse.c                  | 3 +++
 builtin/revert.c                     | 2 ++
 builtin/rm.c                         | 3 +++
 builtin/shortlog.c                   | 2 ++
 builtin/show-branch.c                | 2 ++
 builtin/show-index.c                 | 2 ++
 builtin/sparse-checkout.c            | 2 ++
 builtin/stash.c                      | 2 ++
 builtin/submodule--helper.c          | 2 ++
 builtin/tag.c                        | 3 +++
 builtin/unpack-objects.c             | 2 ++
 builtin/update-index.c               | 3 +++
 builtin/update-ref.c                 | 2 ++
 builtin/var.c                        | 3 +++
 builtin/worktree.c                   | 2 ++
 bulk-checkin.c                       | 1 +
 bundle-uri.c                         | 1 +
 bundle.c                             | 1 +
 cache-tree.c                         | 1 +
 chunk-format.c                       | 1 +
 color.c                              | 2 ++
 column.c                             | 2 ++
 combine-diff.c                       | 1 +
 commit-graph.c                       | 1 +
 commit-reach.c                       | 1 +
 commit.c                             | 1 +
 compat/fsmonitor/fsm-listen-darwin.c | 2 ++
 compat/mingw.c                       | 1 +
 compat/poll/poll.c                   | 2 ++
 compat/terminal.c                    | 2 ++
 compat/win32mmap.c                   | 2 ++
 compat/winansi.c                     | 2 ++
 config.c                             | 1 +
 connect.c                            | 1 +
 convert.c                            | 1 +
 credential.c                         | 1 +
 csum-file.c                          | 1 +
 daemon.c                             | 1 +
 date.c                               | 2 ++
 decorate.c                           | 3 +++
 delta-islands.c                      | 1 +
 diagnose.c                           | 1 +
 diff-delta.c                         | 2 ++
 diff-lib.c                           | 1 +
 diff-merges.c                        | 2 ++
 diff-no-index.c                      | 2 ++
 diff.c                               | 1 +
 diffcore-order.c                     | 3 +++
 diffcore-pickaxe.c                   | 3 +++
 diffcore-rename.c                    | 1 +
 diffcore-rotate.c                    | 3 +++
 dir.c                                | 1 +
 entry.c                              | 1 +
 ewah/ewah_bitmap.c                   | 3 +++
 ewah/ewah_io.c                       | 3 +++
 ewah/ewah_rlw.c                      | 3 +++
 fetch-pack.c                         | 1 +
 fmt-merge-msg.c                      | 1 +
 fsmonitor.c                          | 1 +
 gettext.c                            | 2 ++
 git.c                                | 1 +
 gpg-interface.c                      | 1 +
 graph.c                              | 1 +
 grep.c                               | 2 ++
 help.c                               | 1 +
 hex.c                                | 1 +
 http-backend.c                       | 1 +
 http-push.c                          | 1 +
 http-walker.c                        | 1 +
 http.c                               | 1 +
 imap-send.c                          | 1 +
 json-writer.c                        | 2 ++
 kwset.c                              | 2 ++
 line-log.c                           | 2 ++
 list-objects-filter-options.c        | 1 +
 list-objects-filter.c                | 1 +
 list-objects.c                       | 1 +
 log-tree.c                           | 1 +
 ls-refs.c                            | 1 +
 mailinfo.c                           | 1 +
 mailmap.c                            | 1 +
 match-trees.c                        | 1 +
 mem-pool.c                           | 2 ++
 merge-ll.c                           | 1 +
 merge-ort.c                          | 1 +
 merge-recursive.c                    | 1 +
 merge.c                              | 1 +
 midx-write.c                         | 1 +
 midx.c                               | 1 +
 name-hash.c                          | 1 +
 notes-merge.c                        | 1 +
 notes.c                              | 1 +
 object-file-convert.c                | 1 +
 object-file.c                        | 1 +
 object-name.c                        | 1 +
 object.c                             | 1 +
 pack-bitmap-write.c                  | 1 +
 pack-bitmap.c                        | 1 +
 pack-check.c                         | 1 +
 packfile.c                           | 1 +
 parallel-checkout.c                  | 1 +
 patch-ids.c                          | 2 ++
 path.c                               | 1 +
 pathspec.c                           | 1 +
 pkt-line.c                           | 2 ++
 preload-index.c                      | 1 +
 pretty.c                             | 1 +
 progress.c                           | 1 +
 pseudo-merge.c                       | 1 +
 quote.c                              | 2 ++
 range-diff.c                         | 1 +
 reachable.c                          | 1 +
 read-cache.c                         | 1 +
 ref-filter.c                         | 1 +
 reflog-walk.c                        | 1 +
 reflog.c                             | 1 +
 refs.c                               | 1 +
 refs/debug.c                         | 2 ++
 refs/files-backend.c                 | 1 +
 refs/iterator.c                      | 2 ++
 refs/packed-backend.c                | 1 +
 refspec.c                            | 1 +
 reftable/system.h                    | 2 ++
 remote-curl.c                        | 1 +
 remote.c                             | 1 +
 rerere.c                             | 1 +
 resolve-undo.c                       | 1 +
 revision.c                           | 1 +
 run-command.c                        | 1 +
 scalar.c                             | 1 +
 send-pack.c                          | 1 +
 sequencer.c                          | 1 +
 serve.c                              | 1 +
 server-info.c                        | 1 +
 setup.c                              | 1 +
 shallow.c                            | 1 +
 sideband.c                           | 1 +
 sparse-index.c                       | 1 +
 split-index.c                        | 1 +
 strbuf.c                             | 2 ++
 string-list.c                        | 2 ++
 strvec.c                             | 2 ++
 submodule-config.c                   | 1 +
 submodule.c                          | 1 +
 symlinks.c                           | 2 ++
 t/helper/test-bloom.c                | 1 +
 t/helper/test-cache-tree.c           | 1 +
 t/helper/test-config.c               | 1 +
 t/helper/test-csprng.c               | 2 ++
 t/helper/test-drop-caches.c          | 2 ++
 t/helper/test-dump-fsmonitor.c       | 1 +
 t/helper/test-dump-split-index.c     | 1 +
 t/helper/test-dump-untracked-cache.c | 1 +
 t/helper/test-genrandom.c            | 2 ++
 t/helper/test-genzeros.c             | 2 ++
 t/helper/test-hash-speed.c           | 2 ++
 t/helper/test-mergesort.c            | 2 ++
 t/helper/test-parse-options.c        | 2 ++
 t/helper/test-path-utils.c           | 1 +
 t/helper/test-reach.c                | 1 +
 t/helper/test-ref-store.c            | 1 +
 t/helper/test-revision-walking.c     | 1 +
 t/helper/test-run-command.c          | 2 ++
 t/helper/test-string-list.c          | 2 ++
 t/helper/test-tool.c                 | 2 ++
 t/helper/test-trace2.c               | 1 +
 t/unit-tests/lib-reftable.c          | 2 ++
 t/unit-tests/t-example-decorate.c    | 1 +
 t/unit-tests/t-prio-queue.c          | 2 ++
 t/unit-tests/t-reftable-readwrite.c  | 2 ++
 t/unit-tests/t-reftable-stack.c      | 2 ++
 t/unit-tests/t-trailer.c             | 2 ++
 t/unit-tests/test-lib.c              | 2 ++
 tag.c                                | 1 +
 tmp-objdir.c                         | 1 +
 trace.c                              | 1 +
 trace2.c                             | 2 ++
 trace2/tr2_sysenv.c                  | 2 ++
 trace2/tr2_tgt_event.c               | 2 ++
 trace2/tr2_tgt_perf.c                | 2 ++
 trailer.c                            | 1 +
 transport-helper.c                   | 1 +
 transport.c                          | 1 +
 tree-diff.c                          | 1 +
 unix-socket.c                        | 2 ++
 unpack-trees.c                       | 1 +
 upload-pack.c                        | 1 +
 urlmatch.c                           | 2 ++
 usage.c                              | 3 +++
 userdiff.c                           | 1 +
 utf8.c                               | 2 ++
 version.c                            | 1 +
 versioncmp.c                         | 1 +
 worktree.c                           | 1 +
 wrapper.c                            | 3 +++
 ws.c                                 | 3 +++
 wt-status.c                          | 1 +
 xdiff-interface.c                    | 1 +
 xdiff/xdiffi.c                       | 1 +
 xdiff/xinclude.h                     | 2 ++
 265 files changed, 439 insertions(+), 2 deletions(-)

diff --git a/add-interactive.c b/add-interactive.c
index 49042b30261cc507d1094a007617764c1266eaed..d0f8c10e6fd460c67c564a1040d12780dfafbc69 100644
--- a/add-interactive.c
+++ b/add-interactive.c
@@ -1,4 +1,5 @@
 #define USE_THE_REPOSITORY_VARIABLE
+#define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "git-compat-util.h"
 #include "add-interactive.h"
diff --git a/add-patch.c b/add-patch.c
index 557903310deb23b2b8362bb4688b3d0cd2a1577b..7b598e14df016402ca41e1998466b5ba45623f90 100644
--- a/add-patch.c
+++ b/add-patch.c
@@ -1,4 +1,5 @@
 #define USE_THE_REPOSITORY_VARIABLE
+#define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "git-compat-util.h"
 #include "add-interactive.h"
diff --git a/advice.c b/advice.c
index 6b879d805c03049a2db67aaebfe3a1cd3aa2297c..c2da976543c946a02d532e6dc3fe53bec86ee2a2 100644
--- a/advice.c
+++ b/advice.c
@@ -1,3 +1,5 @@
+#define DISABLE_SIGN_COMPARE_WARNINGS
+
 #include "git-compat-util.h"
 #include "advice.h"
 #include "config.h"
diff --git a/apply.c b/apply.c
index a3fc2d5330f91c02af853039281d48fc17cf8e57..4a7b6120ac866e5bdae532da1d6946e94c7ec207 100644
--- a/apply.c
+++ b/apply.c
@@ -8,6 +8,7 @@
  */
 
 #define USE_THE_REPOSITORY_VARIABLE
+#define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "git-compat-util.h"
 #include "abspath.h"
diff --git a/archive.c b/archive.c
index a7a92ff83937f86b3ec5c2c3f2d68f9b8cdbf6f1..b9c200cba618ebc642859f2b3c58731157ed0eba 100644
--- a/archive.c
+++ b/archive.c
@@ -1,4 +1,5 @@
 #define USE_THE_REPOSITORY_VARIABLE
+#define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "git-compat-util.h"
 #include "abspath.h"
diff --git a/attr.c b/attr.c
index c605d2c1703808668830947331fd4bc9c2a8fb54..67f11c96a524df4fc33817b0668b408c231767c4 100644
--- a/attr.c
+++ b/attr.c
@@ -7,6 +7,7 @@
  */
 
 #define USE_THE_REPOSITORY_VARIABLE
+#define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "git-compat-util.h"
 #include "config.h"
diff --git a/base85.c b/base85.c
index bbacdca31b3bc3c1020d49e8e0c4c539a1232cbc..a6b827203965714bddbf673fecb0198b3ceef237 100644
--- a/base85.c
+++ b/base85.c
@@ -1,3 +1,5 @@
+#define DISABLE_SIGN_COMPARE_WARNINGS
+
 #include "git-compat-util.h"
 #include "base85.h"
 
diff --git a/bisect.c b/bisect.c
index 4713226fad4e16ebbda4ba2e8d13c6eaf7d4bfb2..82c241c94dbcd1de4f57e5572048f1cb71e73a9a 100644
--- a/bisect.c
+++ b/bisect.c
@@ -1,4 +1,5 @@
 #define USE_THE_REPOSITORY_VARIABLE
+#define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "git-compat-util.h"
 #include "config.h"
diff --git a/blame.c b/blame.c
index 90633380cd583b689693e6cfe65c26a79448b00d..22f24f4221e3753d5f7c8cbc021ab40a66ba7019 100644
--- a/blame.c
+++ b/blame.c
@@ -1,4 +1,5 @@
 #define USE_THE_REPOSITORY_VARIABLE
+#define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "git-compat-util.h"
 #include "refs.h"
diff --git a/bloom.c b/bloom.c
index c4286341059991c00ae0f2728c4dc30a1ffa6b07..0c8d2cebf9c4ed92b7f38a749c0a089c6116a644 100644
--- a/bloom.c
+++ b/bloom.c
@@ -1,3 +1,5 @@
+#define DISABLE_SIGN_COMPARE_WARNINGS
+
 #include "git-compat-util.h"
 #include "bloom.h"
 #include "diff.h"
diff --git a/builtin/add.c b/builtin/add.c
index 7d353077921ad8850088f237ce96fc481039cd0d..ff6a7d7fd0868cafb98327ec4ffa81dcac66e4bb 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -3,6 +3,9 @@
  *
  * Copyright (C) 2006 Linus Torvalds
  */
+
+#define DISABLE_SIGN_COMPARE_WARNINGS
+
 #include "builtin.h"
 #include "advice.h"
 #include "config.h"
diff --git a/builtin/am.c b/builtin/am.c
index bfa95147cf403f9ce6b61afdd08077837fda2c48..f3b6546b3049a90fe32801087151e992623e7f17 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -5,6 +5,8 @@
  */
 
 #define USE_THE_REPOSITORY_VARIABLE
+#define DISABLE_SIGN_COMPARE_WARNINGS
+
 #include "builtin.h"
 #include "abspath.h"
 #include "advice.h"
diff --git a/builtin/bisect.c b/builtin/bisect.c
index 21d17a6c1a83e51fb82b53703b95d89bd9028830..e4dd9a4f40219e8053e3c768e25e786f3c6e1ce0 100644
--- a/builtin/bisect.c
+++ b/builtin/bisect.c
@@ -1,4 +1,6 @@
 #define USE_THE_REPOSITORY_VARIABLE
+#define DISABLE_SIGN_COMPARE_WARNINGS
+
 #include "builtin.h"
 #include "copy.h"
 #include "environment.h"
diff --git a/builtin/blame.c b/builtin/blame.c
index e407a22da3bacf6bd26a6738e0ab0292ffadc216..f0d209791e44025b1965cd447cf4fc1e2ca5f009 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -4,7 +4,10 @@
  * Copyright (c) 2006, 2014 by its authors
  * See COPYING for licensing conditions
  */
+
 #define USE_THE_REPOSITORY_VARIABLE
+#define DISABLE_SIGN_COMPARE_WARNINGS
+
 #include "builtin.h"
 #include "config.h"
 #include "color.h"
diff --git a/builtin/branch.c b/builtin/branch.c
index fd1611ebf559f7665114c41ee379db24fdb357fd..bf54f974cf1289a94d74b22d1aaa71569d44a1ac 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -4,7 +4,10 @@
  * Copyright (c) 2006 Kristian Høgsberg <krh@redhat.com>
  * Based on git-branch.sh by Junio C Hamano.
  */
+
 #define USE_THE_REPOSITORY_VARIABLE
+#define DISABLE_SIGN_COMPARE_WARNINGS
+
 #include "builtin.h"
 #include "config.h"
 #include "color.h"
diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index bfdfb51c7cb7b3cba47ae77b9041814fe9307407..825d7d83b24da068316618e3aceaf57c6461a13e 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -3,7 +3,10 @@
  *
  * Copyright (C) Linus Torvalds, 2005
  */
+
 #define USE_THE_REPOSITORY_VARIABLE
+#define DISABLE_SIGN_COMPARE_WARNINGS
+
 #include "builtin.h"
 #include "config.h"
 #include "convert.h"
diff --git a/builtin/checkout--worker.c b/builtin/checkout--worker.c
index ff6cdccc21dfd246f9bc37fab993e042cffd3960..b81002a1dfb4bbb05d2386ae9f03140bced1c82a 100644
--- a/builtin/checkout--worker.c
+++ b/builtin/checkout--worker.c
@@ -1,4 +1,6 @@
 #define USE_THE_REPOSITORY_VARIABLE
+#define DISABLE_SIGN_COMPARE_WARNINGS
+
 #include "builtin.h"
 #include "config.h"
 #include "entry.h"
diff --git a/builtin/checkout-index.c b/builtin/checkout-index.c
index 6dd38eb05d49d6de451a063756b950122c626d21..a81501098d9fdbfd117ec9dcb76e9108b86b0ea3 100644
--- a/builtin/checkout-index.c
+++ b/builtin/checkout-index.c
@@ -4,7 +4,10 @@
  * Copyright (C) 2005 Linus Torvalds
  *
  */
+
 #define USE_THE_REPOSITORY_VARIABLE
+#define DISABLE_SIGN_COMPARE_WARNINGS
+
 #include "builtin.h"
 #include "config.h"
 #include "gettext.h"
diff --git a/builtin/checkout.c b/builtin/checkout.c
index c449558e663a34b5aadfd9d18f3ca36d18432301..1f92e8297bba3bdbeb75a71de20607a9ac531e96 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -1,4 +1,6 @@
 #define USE_THE_REPOSITORY_VARIABLE
+#define DISABLE_SIGN_COMPARE_WARNINGS
+
 #include "builtin.h"
 #include "advice.h"
 #include "branch.h"
diff --git a/builtin/clean.c b/builtin/clean.c
index 9c48dd02711c6e60628ab6ac5402d4271ea1a378..053c94fc6bd12ac535a779b496f52b9547f95765 100644
--- a/builtin/clean.c
+++ b/builtin/clean.c
@@ -5,7 +5,10 @@
  *
  * Based on git-clean.sh by Pavel Roskin
  */
+
 #define USE_THE_REPOSITORY_VARIABLE
+#define DISABLE_SIGN_COMPARE_WARNINGS
+
 #include "builtin.h"
 #include "abspath.h"
 #include "config.h"
diff --git a/builtin/clone.c b/builtin/clone.c
index c0013c75cdc7672abced893c36d2aaf4ff246045..f775c19e3c417748e1f0221d04f5e2d10900f738 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -7,7 +7,10 @@
  *
  * Clone a repository into a different directory that does not yet exist.
  */
+
 #define USE_THE_REPOSITORY_VARIABLE
+#define DISABLE_SIGN_COMPARE_WARNINGS
+
 #include "builtin.h"
 
 #include "abspath.h"
diff --git a/builtin/commit.c b/builtin/commit.c
index 71d674138c9a2b4e0967a95989f02363aa37beba..ef5e622c07746f86bb6d2fb2b909361bef1d1b10 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -4,7 +4,10 @@
  * Copyright (c) 2007 Kristian Høgsberg <krh@redhat.com>
  * Based on git-commit.sh by Junio C Hamano and Linus Torvalds
  */
+
 #define USE_THE_REPOSITORY_VARIABLE
+#define DISABLE_SIGN_COMPARE_WARNINGS
+
 #include "builtin.h"
 #include "advice.h"
 #include "config.h"
diff --git a/builtin/describe.c b/builtin/describe.c
index 7330a77b38ea7e4f8cf3c9ba14d247eaecd150f2..9045e583b7877276a1d62d6a972d2ab40a8ccdc0 100644
--- a/builtin/describe.c
+++ b/builtin/describe.c
@@ -1,4 +1,6 @@
 #define USE_THE_REPOSITORY_VARIABLE
+#define DISABLE_SIGN_COMPARE_WARNINGS
+
 #include "builtin.h"
 #include "config.h"
 #include "environment.h"
diff --git a/builtin/diff-files.c b/builtin/diff-files.c
index e0e0ccec2343a285d85d6bf319395d1b98c042d2..604b04bb2c8694716fb3f6ba630d955959f6ceb9 100644
--- a/builtin/diff-files.c
+++ b/builtin/diff-files.c
@@ -3,7 +3,10 @@
  *
  * Copyright (C) Linus Torvalds, 2005
  */
+
 #define USE_THE_REPOSITORY_VARIABLE
+#define DISABLE_SIGN_COMPARE_WARNINGS
+
 #include "builtin.h"
 #include "config.h"
 #include "diff.h"
diff --git a/builtin/diff-index.c b/builtin/diff-index.c
index ad503624c027df90b9ea0ea8919e2aefd0df0b84..ebc824602e02e67cadfffa8022afef314d367bfa 100644
--- a/builtin/diff-index.c
+++ b/builtin/diff-index.c
@@ -1,4 +1,6 @@
 #define USE_THE_REPOSITORY_VARIABLE
+#define DISABLE_SIGN_COMPARE_WARNINGS
+
 #include "builtin.h"
 #include "config.h"
 #include "diff.h"
diff --git a/builtin/diff-tree.c b/builtin/diff-tree.c
index 4b6656bb9f79a6365c23668e075ad3a073f9e648..a4df2d0c130392f74b4da38dc5d0cd493d88f0e4 100644
--- a/builtin/diff-tree.c
+++ b/builtin/diff-tree.c
@@ -1,4 +1,6 @@
 #define USE_THE_REPOSITORY_VARIABLE
+#define DISABLE_SIGN_COMPARE_WARNINGS
+
 #include "builtin.h"
 #include "config.h"
 #include "diff.h"
diff --git a/builtin/diff.c b/builtin/diff.c
index dca52d4221ed19d27950bee9022ae7efb1d2f17a..69616dece1f60338be7a492eb29c98ec5f080b07 100644
--- a/builtin/diff.c
+++ b/builtin/diff.c
@@ -3,7 +3,10 @@
  *
  * Copyright (c) 2006 Junio C Hamano
  */
+
 #define USE_THE_REPOSITORY_VARIABLE
+#define DISABLE_SIGN_COMPARE_WARNINGS
+
 #include "builtin.h"
 #include "config.h"
 #include "ewah/ewok.h"
diff --git a/builtin/difftool.c b/builtin/difftool.c
index 40e971e2259db4935e4cb253d69acbbbaf1616af..1914708a764d3f0637b327768a7f5cf8a6f96c13 100644
--- a/builtin/difftool.c
+++ b/builtin/difftool.c
@@ -11,7 +11,10 @@
  *
  * Copyright (C) 2016 Johannes Schindelin
  */
+
 #define USE_THE_REPOSITORY_VARIABLE
+#define DISABLE_SIGN_COMPARE_WARNINGS
+
 #include "builtin.h"
 
 #include "abspath.h"
diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index e17f262e8e4d1c26f6235f1758febaef6fa2e1a0..a5c82eef1ded4dae5b4128781868e2c656eedfbd 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -3,7 +3,10 @@
  *
  * Copyright (C) 2007 Johannes E. Schindelin
  */
+
 #define USE_THE_REPOSITORY_VARIABLE
+#define DISABLE_SIGN_COMPARE_WARNINGS
+
 #include "builtin.h"
 #include "config.h"
 #include "gettext.h"
diff --git a/builtin/fast-import.c b/builtin/fast-import.c
index 51c8228cb7b0b45fab2d15be3f90dca02ce584aa..ce6e16b1f6cf157cf6a77174c03efd405977aed2 100644
--- a/builtin/fast-import.c
+++ b/builtin/fast-import.c
@@ -1,4 +1,6 @@
 #define USE_THE_REPOSITORY_VARIABLE
+#define DISABLE_SIGN_COMPARE_WARNINGS
+
 #include "builtin.h"
 #include "abspath.h"
 #include "environment.h"
diff --git a/builtin/fetch-pack.c b/builtin/fetch-pack.c
index 62e8c3aa6b8e8b2adc93edd5a3cbd9ecfb0bca75..bed2816c2d4a2167ecae6cb0c472493aa032aa94 100644
--- a/builtin/fetch-pack.c
+++ b/builtin/fetch-pack.c
@@ -1,4 +1,6 @@
 #define USE_THE_REPOSITORY_VARIABLE
+#define DISABLE_SIGN_COMPARE_WARNINGS
+
 #include "builtin.h"
 #include "gettext.h"
 #include "hex.h"
diff --git a/builtin/fetch.c b/builtin/fetch.c
index 06b46119585baa9ee5fcb5cb2f516165774f2a2a..884c9e9e73da61c1755a81001c71dc3b61f736b5 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1,7 +1,10 @@
 /*
  * "git fetch"
  */
+
 #define USE_THE_REPOSITORY_VARIABLE
+#define DISABLE_SIGN_COMPARE_WARNINGS
+
 #include "builtin.h"
 #include "advice.h"
 #include "config.h"
diff --git a/builtin/for-each-repo.c b/builtin/for-each-repo.c
index fae7f91cf15f7e5b5964d59bbc0f19b4f08146fc..7e36be9d8a55e9454668b935e8d13f52cdc0f62a 100644
--- a/builtin/for-each-repo.c
+++ b/builtin/for-each-repo.c
@@ -1,4 +1,6 @@
 #define USE_THE_REPOSITORY_VARIABLE
+#define DISABLE_SIGN_COMPARE_WARNINGS
+
 #include "builtin.h"
 #include "config.h"
 #include "gettext.h"
diff --git a/builtin/fsmonitor--daemon.c b/builtin/fsmonitor--daemon.c
index f3f6bd330b9ec9fa0c900c8e1f4b3963dfe8c8d6..029dc64d6c70fdc52b420053004729b794f4b322 100644
--- a/builtin/fsmonitor--daemon.c
+++ b/builtin/fsmonitor--daemon.c
@@ -1,4 +1,6 @@
 #define USE_THE_REPOSITORY_VARIABLE
+#define DISABLE_SIGN_COMPARE_WARNINGS
+
 #include "builtin.h"
 #include "abspath.h"
 #include "config.h"
diff --git a/builtin/gc.c b/builtin/gc.c
index d52735354c9f87ba4e8acb593dd11aa0482223e1..d064762bf8892a805a8bf9e259b5fd888e37ad74 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -9,7 +9,10 @@
  *
  * Copyright (c) 2006 Shawn O. Pearce
  */
+
 #define USE_THE_REPOSITORY_VARIABLE
+#define DISABLE_SIGN_COMPARE_WARNINGS
+
 #include "builtin.h"
 #include "abspath.h"
 #include "date.h"
diff --git a/builtin/grep.c b/builtin/grep.c
index 98b85c7fcaccc4b22dc2eacce074cdca99999f3d..d00ee76f24cfdea8ac15e08f812aa5868906940c 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -3,7 +3,10 @@
  *
  * Copyright (c) 2006 Junio C Hamano
  */
+
 #define USE_THE_REPOSITORY_VARIABLE
+#define DISABLE_SIGN_COMPARE_WARNINGS
+
 #include "builtin.h"
 #include "abspath.h"
 #include "gettext.h"
diff --git a/builtin/help.c b/builtin/help.c
index 4a5a0790704b402e6f989118a0f90b52eb49dae1..f45cbd8b32ba1401725e01068ca468bb09eb3aef 100644
--- a/builtin/help.c
+++ b/builtin/help.c
@@ -1,8 +1,10 @@
-
 /*
  * Builtin help command
  */
+
 #define USE_THE_REPOSITORY_VARIABLE
+#define DISABLE_SIGN_COMPARE_WARNINGS
+
 #include "builtin.h"
 #include "config.h"
 #include "exec-cmd.h"
diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 95babdc5ea7e724ea6785e4c269869116b21c11f..54c7faf6ee3af8add04533c68196c6475d05d8c0 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -1,4 +1,6 @@
 #define USE_THE_REPOSITORY_VARIABLE
+#define DISABLE_SIGN_COMPARE_WARNINGS
+
 #include "builtin.h"
 #include "config.h"
 #include "delta.h"
diff --git a/builtin/log.c b/builtin/log.c
index 368f6580a6eb8843592d3fc10d87bf85df03fb9e..cb41a035c6ead57e4d466ae0042a40435ebcde2f 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -4,7 +4,10 @@
  * (C) Copyright 2006 Linus Torvalds
  *		 2006 Junio Hamano
  */
+
 #define USE_THE_REPOSITORY_VARIABLE
+#define DISABLE_SIGN_COMPARE_WARNINGS
+
 #include "builtin.h"
 #include "abspath.h"
 #include "config.h"
diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index e016b0415d167e910f5b5b56ac8b06e6f49c130d..15499cd12b6bd5f97e24e3ca63f313fcc7f14e23 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -5,7 +5,10 @@
  *
  * Copyright (C) Linus Torvalds, 2005
  */
+
 #define USE_THE_REPOSITORY_VARIABLE
+#define DISABLE_SIGN_COMPARE_WARNINGS
+
 #include "builtin.h"
 #include "config.h"
 #include "convert.h"
diff --git a/builtin/mailsplit.c b/builtin/mailsplit.c
index b8f7150ce9a5b47bbb15a13f392bdd8698efe2a9..52481f7f2ee75f0cc6a384fdc78ddd1ccad584df 100644
--- a/builtin/mailsplit.c
+++ b/builtin/mailsplit.c
@@ -4,6 +4,9 @@
  * It just splits a mbox into a list of files: "0001" "0002" ..
  * so you can process them further from there.
  */
+
+#define DISABLE_SIGN_COMPARE_WARNINGS
+
 #include "builtin.h"
 #include "gettext.h"
 #include "string-list.h"
diff --git a/builtin/merge-file.c b/builtin/merge-file.c
index cb42865eb524bc9cd66f64fbe016c56df4869c87..7e315f374b2425d0c9c4069597c158670d13caab 100644
--- a/builtin/merge-file.c
+++ b/builtin/merge-file.c
@@ -1,4 +1,6 @@
 #define USE_THE_REPOSITORY_VARIABLE
+#define DISABLE_SIGN_COMPARE_WARNINGS
+
 #include "builtin.h"
 #include "abspath.h"
 #include "diff.h"
diff --git a/builtin/merge-index.c b/builtin/merge-index.c
index a5b87ee3c5e3dec5aefd195848f566b7cb4fc8f3..342699edb77c97cd36eb2ac00d2495b3d64c6481 100644
--- a/builtin/merge-index.c
+++ b/builtin/merge-index.c
@@ -1,4 +1,6 @@
 #define USE_THE_REPOSITORY_VARIABLE
+#define DISABLE_SIGN_COMPARE_WARNINGS
+
 #include "builtin.h"
 #include "hex.h"
 #include "read-cache-ll.h"
diff --git a/builtin/merge-ours.c b/builtin/merge-ours.c
index 1fcf53f0054e94e413aedd062189e3bc57079dcf..3672c6353f3219c48a2f10f9011cdd48d702265f 100644
--- a/builtin/merge-ours.c
+++ b/builtin/merge-ours.c
@@ -7,7 +7,10 @@
  *
  * Pretend we resolved the heads, but declare our tree trumps everybody else.
  */
+
 #define USE_THE_REPOSITORY_VARIABLE
+#define DISABLE_SIGN_COMPARE_WARNINGS
+
 #include "git-compat-util.h"
 #include "builtin.h"
 #include "diff.h"
diff --git a/builtin/merge-tree.c b/builtin/merge-tree.c
index c5ed472967a692754b93af5eb1a96de698b8e704..3328144029a50894ef7fa3afe0f44133db406cda 100644
--- a/builtin/merge-tree.c
+++ b/builtin/merge-tree.c
@@ -1,4 +1,6 @@
 #define USE_THE_REPOSITORY_VARIABLE
+#define DISABLE_SIGN_COMPARE_WARNINGS
+
 #include "builtin.h"
 #include "tree-walk.h"
 #include "xdiff-interface.h"
diff --git a/builtin/merge.c b/builtin/merge.c
index 51038eaca849fa44cf7225d91c1aa828e8fc4d83..a2712a0babfafc94efbbba0040de332f2c6d25d8 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -5,7 +5,10 @@
  *
  * Based on git-merge.sh by Junio C Hamano.
  */
+
 #define USE_THE_REPOSITORY_VARIABLE
+#define DISABLE_SIGN_COMPARE_WARNINGS
+
 #include "builtin.h"
 
 #include "abspath.h"
diff --git a/builtin/mv.c b/builtin/mv.c
index 472a27873767b80cb63d84f05903292d6dd661e1..55a7d471dca0126c86add94f4577f0c9795fb0d6 100644
--- a/builtin/mv.c
+++ b/builtin/mv.c
@@ -3,7 +3,9 @@
  *
  * Copyright (C) 2006 Johannes Schindelin
  */
+
 #define USE_THE_REPOSITORY_VARIABLE
+#define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "builtin.h"
 #include "abspath.h"
diff --git a/builtin/name-rev.c b/builtin/name-rev.c
index 765eb20a9312e42eb5bdcec41526b3a9d6ea2393..beac166b5cb4149e2c29e8e4ccde7cfa2ceb2d61 100644
--- a/builtin/name-rev.c
+++ b/builtin/name-rev.c
@@ -1,4 +1,6 @@
 #define USE_THE_REPOSITORY_VARIABLE
+#define DISABLE_SIGN_COMPARE_WARNINGS
+
 #include "builtin.h"
 #include "environment.h"
 #include "gettext.h"
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 676a5867090cfd954e4e4c7f334b081ee4999cb0..a5d6f8db603c092b95a33674eb47d205aac0c8ce 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -1,4 +1,6 @@
 #define USE_THE_REPOSITORY_VARIABLE
+#define DISABLE_SIGN_COMPARE_WARNINGS
+
 #include "builtin.h"
 #include "environment.h"
 #include "gettext.h"
diff --git a/builtin/pack-redundant.c b/builtin/pack-redundant.c
index d2c1c4e5ec14711a54b8483106e9ed05fbe960bf..978c42aae7b86f0ce049eea0ac0b9bcfcf598348 100644
--- a/builtin/pack-redundant.c
+++ b/builtin/pack-redundant.c
@@ -5,7 +5,9 @@
 * This file is licensed under the GPL v2.
 *
 */
+
 #define USE_THE_REPOSITORY_VARIABLE
+#define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "builtin.h"
 #include "gettext.h"
diff --git a/builtin/pack-refs.c b/builtin/pack-refs.c
index 2d83c1ed2ac8c7fcf5568e46f56ae308447cfadf..71175a713a07a1e89050a869c92bd472bea15f87 100644
--- a/builtin/pack-refs.c
+++ b/builtin/pack-refs.c
@@ -1,4 +1,6 @@
 #define USE_THE_REPOSITORY_VARIABLE
+#define DISABLE_SIGN_COMPARE_WARNINGS
+
 #include "builtin.h"
 #include "config.h"
 #include "gettext.h"
diff --git a/builtin/patch-id.c b/builtin/patch-id.c
index 93b398e391e00ca77c0cccc78c55044e4a194c15..56585757477911c96bbb9ef2cf3710691b8e744e 100644
--- a/builtin/patch-id.c
+++ b/builtin/patch-id.c
@@ -1,4 +1,6 @@
 #define USE_THE_REPOSITORY_VARIABLE
+#define DISABLE_SIGN_COMPARE_WARNINGS
+
 #include "builtin.h"
 #include "config.h"
 #include "diff.h"
diff --git a/builtin/prune.c b/builtin/prune.c
index 2b1de01339fc0446f4927bf58544e085b1669c3c..aeff9ca1b35c3f09c6bd334cbf52864df437fe05 100644
--- a/builtin/prune.c
+++ b/builtin/prune.c
@@ -1,4 +1,6 @@
 #define USE_THE_REPOSITORY_VARIABLE
+#define DISABLE_SIGN_COMPARE_WARNINGS
+
 #include "builtin.h"
 #include "commit.h"
 #include "diff.h"
diff --git a/builtin/pull.c b/builtin/pull.c
index edc56907aa252a092a63a5c963b62c9f1fb64aaa..6f8a32620c378f22f36cee4480d975d273bb04ff 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -7,6 +7,8 @@
  */
 
 #define USE_THE_REPOSITORY_VARIABLE
+#define DISABLE_SIGN_COMPARE_WARNINGS
+
 #include "builtin.h"
 #include "advice.h"
 #include "config.h"
diff --git a/builtin/push.c b/builtin/push.c
index 51c609f2089e64a54d824fdb243e5b49524f854e..7174efed6dce226a0dfbd117f996ce67b45a2625 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -1,7 +1,10 @@
 /*
  * "git push"
  */
+
 #define USE_THE_REPOSITORY_VARIABLE
+#define DISABLE_SIGN_COMPARE_WARNINGS
+
 #include "builtin.h"
 #include "advice.h"
 #include "branch.h"
diff --git a/builtin/range-diff.c b/builtin/range-diff.c
index 1b33ab66a7b2013224f1c8f29854433d76776a0e..aa88a46d9ee3fcc61817834c770b3de352d78e7a 100644
--- a/builtin/range-diff.c
+++ b/builtin/range-diff.c
@@ -1,4 +1,6 @@
 #define USE_THE_REPOSITORY_VARIABLE
+#define DISABLE_SIGN_COMPARE_WARNINGS
+
 #include "builtin.h"
 #include "gettext.h"
 #include "object-name.h"
diff --git a/builtin/rebase.c b/builtin/rebase.c
index bbaca3c5d578359148cb469c0312717ef8774326..0498fff3c96d5756fe01bdc0547e470fd6bfb2bd 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -3,7 +3,10 @@
  *
  * Copyright (c) 2018 Pratik Karki
  */
+
 #define USE_THE_REPOSITORY_VARIABLE
+#define DISABLE_SIGN_COMPARE_WARNINGS
+
 #include "builtin.h"
 
 #include "abspath.h"
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index ab5b20e39c5038cdf6e6f05f4d66278a9c1ac156..fd93330f92a1a5c4cbae077e6f0b684013bcc744 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -1,4 +1,6 @@
 #define USE_THE_REPOSITORY_VARIABLE
+#define DISABLE_SIGN_COMPARE_WARNINGS
+
 #include "builtin.h"
 #include "abspath.h"
 
diff --git a/builtin/reflog.c b/builtin/reflog.c
index 22df6834f71098ab8378e4423967f0fb87858340..d2bda133adf6b1e7e23d9347db51cb496eaecacc 100644
--- a/builtin/reflog.c
+++ b/builtin/reflog.c
@@ -1,4 +1,6 @@
 #define USE_THE_REPOSITORY_VARIABLE
+#define DISABLE_SIGN_COMPARE_WARNINGS
+
 #include "builtin.h"
 #include "config.h"
 #include "gettext.h"
diff --git a/builtin/remote.c b/builtin/remote.c
index 909360096513fc72445f54b13ee92d7a95111ce1..89a56dc3d5d71464d3960febf70972d146b53d4f 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -1,4 +1,6 @@
 #define USE_THE_REPOSITORY_VARIABLE
+#define DISABLE_SIGN_COMPARE_WARNINGS
+
 #include "builtin.h"
 #include "config.h"
 #include "gettext.h"
diff --git a/builtin/repack.c b/builtin/repack.c
index d6bb37e84ae2e3715c48791b97f6798177629684..fd2ef166de085c117e1921874906cb5b9a481f99 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -1,4 +1,6 @@
 #define USE_THE_REPOSITORY_VARIABLE
+#define DISABLE_SIGN_COMPARE_WARNINGS
+
 #include "builtin.h"
 #include "config.h"
 #include "dir.h"
diff --git a/builtin/replay.c b/builtin/replay.c
index 2d12a4e403fa7d4499de0911191b545e31a1e95f..1afc6d1ee0cb738fa7fa3f2b5c8ce0dd7802e7da 100644
--- a/builtin/replay.c
+++ b/builtin/replay.c
@@ -2,9 +2,11 @@
  * "git replay" builtin command
  */
 
+#define USE_THE_REPOSITORY_VARIABLE
+#define DISABLE_SIGN_COMPARE_WARNINGS
+
 #include "git-compat-util.h"
 
-#define USE_THE_REPOSITORY_VARIABLE
 #include "builtin.h"
 #include "environment.h"
 #include "hex.h"
diff --git a/builtin/rerere.c b/builtin/rerere.c
index f7143c3f5d5670c83ff9995e756cd12ea7626863..706a9472133862a0dd513a4cee454403f5de748b 100644
--- a/builtin/rerere.c
+++ b/builtin/rerere.c
@@ -1,4 +1,6 @@
 #define USE_THE_REPOSITORY_VARIABLE
+#define DISABLE_SIGN_COMPARE_WARNINGS
+
 #include "builtin.h"
 #include "config.h"
 #include "gettext.h"
diff --git a/builtin/reset.c b/builtin/reset.c
index 7154f88826d4c48680eb08466968fb05d4bd9f77..f34d22190f489fb522fb70584ae2d777a895afbf 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -7,7 +7,10 @@
  *
  * Copyright (c) 2005, 2006 Linus Torvalds and Junio C Hamano
  */
+
 #define USE_THE_REPOSITORY_VARIABLE
+#define DISABLE_SIGN_COMPARE_WARNINGS
+
 #include "builtin.h"
 #include "advice.h"
 #include "config.h"
diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index 3078787115f9f11b46799bc52e5f1a4cd5278cd1..9b41d0b62a4936b1ead43ccad1ba4b932e5db9ea 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -1,4 +1,6 @@
 #define USE_THE_REPOSITORY_VARIABLE
+#define DISABLE_SIGN_COMPARE_WARNINGS
+
 #include "builtin.h"
 #include "config.h"
 #include "commit.h"
diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index 8401b4d7ab64f06b55fb055899d2eb36dc3810a2..949747a6b6c7f8ee854dd6027fd4bc7cee7f82be 100644
--- a/builtin/rev-parse.c
+++ b/builtin/rev-parse.c
@@ -3,7 +3,10 @@
  *
  * Copyright (C) Linus Torvalds, 2005
  */
+
 #define USE_THE_REPOSITORY_VARIABLE
+#define DISABLE_SIGN_COMPARE_WARNINGS
+
 #include "builtin.h"
 
 #include "abspath.h"
diff --git a/builtin/revert.c b/builtin/revert.c
index b7917dddd3e15e1d845c002bd31affdfd61d3cae..4b57c2c38378e02342e678cb8936b80637b98c5e 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -1,4 +1,6 @@
 #define USE_THE_REPOSITORY_VARIABLE
+#define DISABLE_SIGN_COMPARE_WARNINGS
+
 #include "git-compat-util.h"
 #include "builtin.h"
 #include "parse-options.h"
diff --git a/builtin/rm.c b/builtin/rm.c
index eaff027258db4d7e7d1ca73f914d4bf756aa691d..12ae086a556ce3cfb522835cfa93e1d4c33b6e6c 100644
--- a/builtin/rm.c
+++ b/builtin/rm.c
@@ -3,7 +3,10 @@
  *
  * Copyright (C) Linus Torvalds 2006
  */
+
 #define USE_THE_REPOSITORY_VARIABLE
+#define DISABLE_SIGN_COMPARE_WARNINGS
+
 #include "builtin.h"
 #include "advice.h"
 #include "config.h"
diff --git a/builtin/shortlog.c b/builtin/shortlog.c
index c86b75d9813ad9207a773e95ce897b65929e86b9..1c46f13a16346c9a3ba41a92e0aec0428179b939 100644
--- a/builtin/shortlog.c
+++ b/builtin/shortlog.c
@@ -1,4 +1,6 @@
 #define USE_THE_REPOSITORY_VARIABLE
+#define DISABLE_SIGN_COMPARE_WARNINGS
+
 #include "builtin.h"
 #include "config.h"
 #include "commit.h"
diff --git a/builtin/show-branch.c b/builtin/show-branch.c
index cd6bdf63bc103de7a4bffe61416e720f80cf3482..fce6b404e9265baafb4f173d2adad414b24984de 100644
--- a/builtin/show-branch.c
+++ b/builtin/show-branch.c
@@ -1,4 +1,6 @@
 #define USE_THE_REPOSITORY_VARIABLE
+#define DISABLE_SIGN_COMPARE_WARNINGS
+
 #include "builtin.h"
 #include "config.h"
 #include "environment.h"
diff --git a/builtin/show-index.c b/builtin/show-index.c
index f164c01bbea4003ee97cdc4b3f7131b5b7def9ad..3152d3c74bf2ad43efb85ba08ec726cab3bc1d07 100644
--- a/builtin/show-index.c
+++ b/builtin/show-index.c
@@ -1,4 +1,6 @@
 #define USE_THE_REPOSITORY_VARIABLE
+#define DISABLE_SIGN_COMPARE_WARNINGS
+
 #include "builtin.h"
 #include "gettext.h"
 #include "hash.h"
diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
index 49aedc1de81a17b8b491cded7fa71b384e0e8be9..5768863306cb8a2cf5f8f30fc1ccd3ac7dad849d 100644
--- a/builtin/sparse-checkout.c
+++ b/builtin/sparse-checkout.c
@@ -1,4 +1,6 @@
 #define USE_THE_REPOSITORY_VARIABLE
+#define DISABLE_SIGN_COMPARE_WARNINGS
+
 #include "builtin.h"
 #include "config.h"
 #include "dir.h"
diff --git a/builtin/stash.c b/builtin/stash.c
index 1399a1bbe2c222ed3e1c33ac2dd17bd1148f709c..c859888439dcb352c741e15232d8a3e551ff7842 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -1,4 +1,6 @@
 #define USE_THE_REPOSITORY_VARIABLE
+#define DISABLE_SIGN_COMPARE_WARNINGS
+
 #include "builtin.h"
 #include "abspath.h"
 #include "config.h"
diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index b6b5f1ebde7c2e4780af4097a0c4d6d838948aee..160d2d6a22498e9ee8449720b0efe9248cb275d1 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -1,4 +1,6 @@
 #define USE_THE_REPOSITORY_VARIABLE
+#define DISABLE_SIGN_COMPARE_WARNINGS
+
 #include "builtin.h"
 #include "abspath.h"
 #include "environment.h"
diff --git a/builtin/tag.c b/builtin/tag.c
index c37c0a68fdaa168af3e53474b5b0a1300191d867..0a6141462da8f2590464c87332005dfefc0d9bb4 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -5,7 +5,10 @@
  *                    Carlos Rica <jasampler@gmail.com>
  * Based on git-tag.sh and mktag.c by Linus Torvalds.
  */
+
 #define USE_THE_REPOSITORY_VARIABLE
+#define DISABLE_SIGN_COMPARE_WARNINGS
+
 #include "builtin.h"
 #include "advice.h"
 #include "config.h"
diff --git a/builtin/unpack-objects.c b/builtin/unpack-objects.c
index 02b8d02f63f0a216b52de38cb47e010c7bfccb07..2197d6d9332117636f31abadb5aff70424ba305d 100644
--- a/builtin/unpack-objects.c
+++ b/builtin/unpack-objects.c
@@ -1,4 +1,6 @@
 #define USE_THE_REPOSITORY_VARIABLE
+#define DISABLE_SIGN_COMPARE_WARNINGS
+
 #include "builtin.h"
 #include "bulk-checkin.h"
 #include "config.h"
diff --git a/builtin/update-index.c b/builtin/update-index.c
index 45b4a8b5556e08688c615577f4931a173eb7435d..74bbad9f87d86da0ae5520c39718bbe91098d5e0 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -3,7 +3,10 @@
  *
  * Copyright (C) Linus Torvalds, 2005
  */
+
 #define USE_THE_REPOSITORY_VARIABLE
+#define DISABLE_SIGN_COMPARE_WARNINGS
+
 #include "builtin.h"
 #include "bulk-checkin.h"
 #include "config.h"
diff --git a/builtin/update-ref.c b/builtin/update-ref.c
index 8a98615dc8613a1be3b17c6d688ab9c0208ed003..ffe259ee6bbc7d43172db749337932a8a6b03723 100644
--- a/builtin/update-ref.c
+++ b/builtin/update-ref.c
@@ -1,4 +1,6 @@
 #define USE_THE_REPOSITORY_VARIABLE
+#define DISABLE_SIGN_COMPARE_WARNINGS
+
 #include "builtin.h"
 #include "config.h"
 #include "gettext.h"
diff --git a/builtin/var.c b/builtin/var.c
index 2ecaed51b441963ddbfb6983403bd364d4fd72fd..74aa39dd6bfb261170152d7dd3dc3d724bec61bc 100644
--- a/builtin/var.c
+++ b/builtin/var.c
@@ -3,7 +3,10 @@
  *
  * Copyright (C) Eric Biederman, 2005
  */
+
 #define USE_THE_REPOSITORY_VARIABLE
+#define DISABLE_SIGN_COMPARE_WARNINGS
+
 #include "builtin.h"
 
 #include "attr.h"
diff --git a/builtin/worktree.c b/builtin/worktree.c
index dae63dedf4cac2621f51f95a39aa456b33acd894..118edaf4b9145a22163db7308c993ac50f8cbc3e 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -1,4 +1,6 @@
 #define USE_THE_REPOSITORY_VARIABLE
+#define DISABLE_SIGN_COMPARE_WARNINGS
+
 #include "builtin.h"
 #include "abspath.h"
 #include "advice.h"
diff --git a/bulk-checkin.c b/bulk-checkin.c
index 2753d5bbe4af3d1cae43df41426a3ee4a6974f41..4a70a70a951cfd1a488339a33bf3a76b5152a344 100644
--- a/bulk-checkin.c
+++ b/bulk-checkin.c
@@ -3,6 +3,7 @@
  */
 
 #define USE_THE_REPOSITORY_VARIABLE
+#define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "git-compat-util.h"
 #include "bulk-checkin.h"
diff --git a/bundle-uri.c b/bundle-uri.c
index 0df66e28729e5cd8649850d641bd385500a94b45..38e1d66d79036bb9a5d4891d33459e2c1d397ca8 100644
--- a/bundle-uri.c
+++ b/bundle-uri.c
@@ -1,4 +1,5 @@
 #define USE_THE_REPOSITORY_VARIABLE
+#define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "git-compat-util.h"
 #include "bundle-uri.h"
diff --git a/bundle.c b/bundle.c
index 4773b51eb1df8057466c87f48445c49bc1f594ee..0501b74252e63e8278bc857517a5f168df7ce10e 100644
--- a/bundle.c
+++ b/bundle.c
@@ -1,4 +1,5 @@
 #define USE_THE_REPOSITORY_VARIABLE
+#define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "git-compat-util.h"
 #include "lockfile.h"
diff --git a/cache-tree.c b/cache-tree.c
index c595e8612044c7c909e87dbaf193416f3d6b1ca6..bcbcad3d61a09cb9d5a53a36f7dd12c36f3ec67b 100644
--- a/cache-tree.c
+++ b/cache-tree.c
@@ -1,4 +1,5 @@
 #define USE_THE_REPOSITORY_VARIABLE
+#define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "git-compat-util.h"
 #include "gettext.h"
diff --git a/chunk-format.c b/chunk-format.c
index 2dde24e6a317ce82ac23f8ba8d1c9da6315bfca0..51b5a2c959a1cf2c7ff0939f1d13ef94029fca37 100644
--- a/chunk-format.c
+++ b/chunk-format.c
@@ -1,4 +1,5 @@
 #define USE_THE_REPOSITORY_VARIABLE
+#define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "git-compat-util.h"
 #include "chunk-format.h"
diff --git a/color.c b/color.c
index 227a5ab2f42ef99e578c837f59b2b40986a3c9e3..7df8862c710794044cdd1e44c50e7dbf64576af2 100644
--- a/color.c
+++ b/color.c
@@ -1,3 +1,5 @@
+#define DISABLE_SIGN_COMPARE_WARNINGS
+
 #include "git-compat-util.h"
 #include "config.h"
 #include "color.h"
diff --git a/column.c b/column.c
index 50bbccc92ee86cf754a6b3250e52338a1870c990..93fae316b454ad3fe325f3e6227bb120d68c824d 100644
--- a/column.c
+++ b/column.c
@@ -1,3 +1,5 @@
+#define DISABLE_SIGN_COMPARE_WARNINGS
+
 #include "git-compat-util.h"
 #include "config.h"
 #include "column.h"
diff --git a/combine-diff.c b/combine-diff.c
index 33d0ed7097569c57247f68c1f995a0bb23be0afa..641bc92dbdbc136b61d69527f4ad5386a2d2c6de 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -1,4 +1,5 @@
 #define USE_THE_REPOSITORY_VARIABLE
+#define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "git-compat-util.h"
 #include "object-store-ll.h"
diff --git a/commit-graph.c b/commit-graph.c
index 5bd89c0acdd03df1328d75707136cfd2937582a5..7623a158c8e76c122466c54e8d68cd3519c5e381 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -1,4 +1,5 @@
 #define USE_THE_REPOSITORY_VARIABLE
+#define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "git-compat-util.h"
 #include "config.h"
diff --git a/commit-reach.c b/commit-reach.c
index c3518aa3606f36d872ae096e6c3231d7dc6062a6..e3edd1199529792fafbaa03999c5b7b202f7cf1b 100644
--- a/commit-reach.c
+++ b/commit-reach.c
@@ -1,4 +1,5 @@
 #define USE_THE_REPOSITORY_VARIABLE
+#define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "git-compat-util.h"
 #include "commit.h"
diff --git a/commit.c b/commit.c
index cc03a9303623ad39a770c397d442cc4a7fad84c0..9c1f9fa2367e8c0930c8446e88b9368472dc6ade 100644
--- a/commit.c
+++ b/commit.c
@@ -1,4 +1,5 @@
 #define USE_THE_REPOSITORY_VARIABLE
+#define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "git-compat-util.h"
 #include "tag.h"
diff --git a/compat/fsmonitor/fsm-listen-darwin.c b/compat/fsmonitor/fsm-listen-darwin.c
index dfa551459d2d1be3f3076c28ff77d497e95a4eda..58f3878a22666ea8a0bd5bfc215eadf06de747c0 100644
--- a/compat/fsmonitor/fsm-listen-darwin.c
+++ b/compat/fsmonitor/fsm-listen-darwin.c
@@ -23,6 +23,8 @@
 #endif
 #endif
 
+#define DISABLE_SIGN_COMPARE_WARNINGS
+
 #include "git-compat-util.h"
 #include "fsmonitor-ll.h"
 #include "fsm-listen.h"
diff --git a/compat/mingw.c b/compat/mingw.c
index 63f36c893bfe96f223daa6c4c18d20fa3a347c2e..408b1a310238a0077e1d239b832ace4719385975 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -1,4 +1,5 @@
 #define USE_THE_REPOSITORY_VARIABLE
+#define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "../git-compat-util.h"
 #include "win32.h"
diff --git a/compat/poll/poll.c b/compat/poll/poll.c
index afa6d245846a41f2232c1e6e633e2f015d419fd7..a2becd16cd0bd019aae9a4dba9ff5bf10cd5b1c6 100644
--- a/compat/poll/poll.c
+++ b/compat/poll/poll.c
@@ -18,6 +18,8 @@
    You should have received a copy of the GNU General Public License along
    with this program; if not, see <http://www.gnu.org/licenses/>.  */
 
+#define DISABLE_SIGN_COMPARE_WARNINGS
+
 /* To bump the minimum Windows version to Windows Vista */
 #include "git-compat-util.h"
 
diff --git a/compat/terminal.c b/compat/terminal.c
index d54efa1c5d6ebf63274b4878bc69be9db09a7124..7fe515b9c88e266f075043c0d48a6cbce5dacea2 100644
--- a/compat/terminal.c
+++ b/compat/terminal.c
@@ -1,3 +1,5 @@
+#define DISABLE_SIGN_COMPARE_WARNINGS
+
 #include "git-compat-util.h"
 #include "compat/terminal.h"
 #include "gettext.h"
diff --git a/compat/win32mmap.c b/compat/win32mmap.c
index a4ab4cb939399ba1d7becc45fcda72902741f22d..e9519343167be1f98b127d27c8e05a1389345435 100644
--- a/compat/win32mmap.c
+++ b/compat/win32mmap.c
@@ -1,3 +1,5 @@
+#define DISABLE_SIGN_COMPARE_WARNINGS
+
 #include "../git-compat-util.h"
 
 void *git_mmap(void *start, size_t length, int prot, int flags, int fd, off_t offset)
diff --git a/compat/winansi.c b/compat/winansi.c
index 1b3f916b9fc409008e2c99da6ab73a0435892acf..ac2ffb78691a7d6bcae3b29e75019c8fb9339a67 100644
--- a/compat/winansi.c
+++ b/compat/winansi.c
@@ -4,6 +4,8 @@
 
 #undef NOGDI
 
+#define DISABLE_SIGN_COMPARE_WARNINGS
+
 #include "../git-compat-util.h"
 #include <wingdi.h>
 #include <winreg.h>
diff --git a/config.c b/config.c
index a11bb85da303a7267e86a7a0b420fe22881e4d4f..969bd8630f86172912e4085a8103d9199642e701 100644
--- a/config.c
+++ b/config.c
@@ -7,6 +7,7 @@
  */
 
 #define USE_THE_REPOSITORY_VARIABLE
+#define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "git-compat-util.h"
 #include "abspath.h"
diff --git a/connect.c b/connect.c
index 58f53d8dcbb87d4ec4e90a926ad3fadfec337d5d..10fad43e98652f8c441866c982103fc2a5a01321 100644
--- a/connect.c
+++ b/connect.c
@@ -1,4 +1,5 @@
 #define USE_THE_REPOSITORY_VARIABLE
+#define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "git-compat-util.h"
 #include "config.h"
diff --git a/convert.c b/convert.c
index c9a31eb4f03d6caa7bedba4b5237c42344f304c5..9cc0ca20ca07768282df966e45b3605bfc4f5d7b 100644
--- a/convert.c
+++ b/convert.c
@@ -1,4 +1,5 @@
 #define USE_THE_REPOSITORY_VARIABLE
+#define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "git-compat-util.h"
 #include "advice.h"
diff --git a/credential.c b/credential.c
index 6dea3859ece3389c97dc773a2466eb291a1617e8..a995031c5f5d842f8e82d5e44e4f7a3e51a9e815 100644
--- a/credential.c
+++ b/credential.c
@@ -1,4 +1,5 @@
 #define USE_THE_REPOSITORY_VARIABLE
+#define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "git-compat-util.h"
 #include "abspath.h"
diff --git a/csum-file.c b/csum-file.c
index c203ebf11b344404311603246e76ad035b92e1a9..c14bacc7f9e5f56fcdb06a3abc7ac9babc45041a 100644
--- a/csum-file.c
+++ b/csum-file.c
@@ -9,6 +9,7 @@
  */
 
 #define USE_THE_REPOSITORY_VARIABLE
+#define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "git-compat-util.h"
 #include "progress.h"
diff --git a/daemon.c b/daemon.c
index a40e435c6370cf1cfd2cef082184445f31748643..68789ceb222eeb389d58998fd00388f289868fc3 100644
--- a/daemon.c
+++ b/daemon.c
@@ -1,4 +1,5 @@
 #define USE_THE_REPOSITORY_VARIABLE
+#define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "git-compat-util.h"
 #include "abspath.h"
diff --git a/date.c b/date.c
index bee9fe8f102596cd2f5cae946a907dd63862ee13..a1b26a8dce697cbaea58b34e91d08ea446fba352 100644
--- a/date.c
+++ b/date.c
@@ -4,6 +4,8 @@
  * Copyright (C) Linus Torvalds, 2005
  */
 
+#define DISABLE_SIGN_COMPARE_WARNINGS
+
 #include "git-compat-util.h"
 #include "date.h"
 #include "gettext.h"
diff --git a/decorate.c b/decorate.c
index 69aeb142b45e9fee08d61dace73f6dc2bce1c2d0..e161e13772891f6566b1063f7b7410e6adaad7bc 100644
--- a/decorate.c
+++ b/decorate.c
@@ -2,6 +2,9 @@
  * decorate.c - decorate a git object with some arbitrary
  * data.
  */
+
+#define DISABLE_SIGN_COMPARE_WARNINGS
+
 #include "git-compat-util.h"
 #include "object.h"
 #include "decorate.h"
diff --git a/delta-islands.c b/delta-islands.c
index 844355125935ad64614f1cabbfd15a8e58ce185b..1c465a6041914538bcb8be51c500653d8fa1a626 100644
--- a/delta-islands.c
+++ b/delta-islands.c
@@ -1,4 +1,5 @@
 #define USE_THE_REPOSITORY_VARIABLE
+#define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "git-compat-util.h"
 #include "object.h"
diff --git a/diagnose.c b/diagnose.c
index cc2d535b60d7c886640f458f062cf5720f9cf36b..f340996e27b994c1ab58654bf248305a45833adc 100644
--- a/diagnose.c
+++ b/diagnose.c
@@ -1,4 +1,5 @@
 #define USE_THE_REPOSITORY_VARIABLE
+#define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "git-compat-util.h"
 #include "diagnose.h"
diff --git a/diff-delta.c b/diff-delta.c
index 77fea08dfb04d3a6ec12e11dbd321084d9028722..a4faf73829be00c1e5d3d12d56a87085cc1abcfd 100644
--- a/diff-delta.c
+++ b/diff-delta.c
@@ -11,6 +11,8 @@
  * published by the Free Software Foundation.
  */
 
+#define DISABLE_SIGN_COMPARE_WARNINGS
+
 #include "git-compat-util.h"
 #include "delta.h"
 
diff --git a/diff-lib.c b/diff-lib.c
index 3cf353946f51ca4ef96ab4a2add7cd97eacf258e..c6d3bc4d37d557dd9312c0ac7d56e80ffab15dbd 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -3,6 +3,7 @@
  */
 
 #define USE_THE_REPOSITORY_VARIABLE
+#define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "git-compat-util.h"
 #include "commit.h"
diff --git a/diff-merges.c b/diff-merges.c
index 45507588a2797b8d3618e3a19a2854d12051157b..0adfe7f5c06b586500361f47ed0d05124c8c9f70 100644
--- a/diff-merges.c
+++ b/diff-merges.c
@@ -1,3 +1,5 @@
+#define DISABLE_SIGN_COMPARE_WARNINGS
+
 #include "git-compat-util.h"
 #include "diff-merges.h"
 
diff --git a/diff-no-index.c b/diff-no-index.c
index c5fb06e6d1a90d60de54ed5a31573fd4998c4623..6f277892d3aef64910809f39c6faaf43d9778d60 100644
--- a/diff-no-index.c
+++ b/diff-no-index.c
@@ -4,6 +4,8 @@
  * Copyright (c) 2008 by Junio C Hamano
  */
 
+#define DISABLE_SIGN_COMPARE_WARNINGS
+
 #include "git-compat-util.h"
 #include "abspath.h"
 #include "color.h"
diff --git a/diff.c b/diff.c
index dceac20d18f03dfb72632f4466ed5a8a8e51bc14..97417cc2a185b520a6af0b11425132ab5c4c54af 100644
--- a/diff.c
+++ b/diff.c
@@ -3,6 +3,7 @@
  */
 
 #define USE_THE_REPOSITORY_VARIABLE
+#define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "git-compat-util.h"
 #include "abspath.h"
diff --git a/diffcore-order.c b/diffcore-order.c
index 912513d3e67a9b277dd24a93992c456a061b196f..ec59d3d9bcc85753352f5faba7982da1c4455b95 100644
--- a/diffcore-order.c
+++ b/diffcore-order.c
@@ -1,6 +1,9 @@
 /*
  * Copyright (C) 2005 Junio C Hamano
  */
+
+#define DISABLE_SIGN_COMPARE_WARNINGS
+
 #include "git-compat-util.h"
 #include "gettext.h"
 #include "diff.h"
diff --git a/diffcore-pickaxe.c b/diffcore-pickaxe.c
index 43fef8e8ba4e8273bcd664ce60d418e092b7931c..a52d569911c48e1527cf7f3dc6e546d8449bd32f 100644
--- a/diffcore-pickaxe.c
+++ b/diffcore-pickaxe.c
@@ -2,6 +2,9 @@
  * Copyright (C) 2005 Junio C Hamano
  * Copyright (C) 2010 Google Inc.
  */
+
+#define DISABLE_SIGN_COMPARE_WARNINGS
+
 #include "git-compat-util.h"
 #include "diff.h"
 #include "diffcore.h"
diff --git a/diffcore-rename.c b/diffcore-rename.c
index 1b1c1a6a1fabb6c4a45ccf763c4155108373b7f4..08ebb1fc3d087ffe666f747ebf5301a8f6f8b2d8 100644
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -4,6 +4,7 @@
  */
 
 #define USE_THE_REPOSITORY_VARIABLE
+#define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "git-compat-util.h"
 #include "diff.h"
diff --git a/diffcore-rotate.c b/diffcore-rotate.c
index 73ca20b331253c5282506747b8aca2fd145bfa3d..941a022d5e6e79592967166f1ffc7fcd62086010 100644
--- a/diffcore-rotate.c
+++ b/diffcore-rotate.c
@@ -2,6 +2,9 @@
  * Copyright (C) 2021, Google LLC.
  * Based on diffcore-order.c, which is Copyright (C) 2005, Junio C Hamano
  */
+
+#define DISABLE_SIGN_COMPARE_WARNINGS
+
 #include "git-compat-util.h"
 #include "gettext.h"
 #include "diff.h"
diff --git a/dir.c b/dir.c
index 7f35a3e3175355bad4f64bf4e65cf05d9bd6356f..5b2181e5899ce951791aa5e46ccdbb2d71ce6144 100644
--- a/dir.c
+++ b/dir.c
@@ -7,6 +7,7 @@
  */
 
 #define USE_THE_REPOSITORY_VARIABLE
+#define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "git-compat-util.h"
 #include "abspath.h"
diff --git a/entry.c b/entry.c
index 3143b9996bf491f7ceddf2d39de741ed5c35ef11..93bd6a78ffac4ba3b5b6ac64ec0fd23c9793e56f 100644
--- a/entry.c
+++ b/entry.c
@@ -1,4 +1,5 @@
 #define USE_THE_REPOSITORY_VARIABLE
+#define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "git-compat-util.h"
 #include "object-store-ll.h"
diff --git a/ewah/ewah_bitmap.c b/ewah/ewah_bitmap.c
index 8785cbc54a821cd2cb89ba0226a29a233d8c19ff..9be9bb3758cf0bc267d09d59b3b23a127b3e4721 100644
--- a/ewah/ewah_bitmap.c
+++ b/ewah/ewah_bitmap.c
@@ -16,6 +16,9 @@
  * You should have received a copy of the GNU General Public License
  * along with this program; if not, see <http://www.gnu.org/licenses/>.
  */
+
+#define DISABLE_SIGN_COMPARE_WARNINGS
+
 #include "git-compat-util.h"
 #include "ewok.h"
 #include "ewok_rlw.h"
diff --git a/ewah/ewah_io.c b/ewah/ewah_io.c
index 9035ee65ea8db67c373492fcb1755f8b1499679e..da005523b0531c355bd99fb3d4d794af1b098d55 100644
--- a/ewah/ewah_io.c
+++ b/ewah/ewah_io.c
@@ -16,6 +16,9 @@
  * You should have received a copy of the GNU General Public License
  * along with this program; if not, see <http://www.gnu.org/licenses/>.
  */
+
+#define DISABLE_SIGN_COMPARE_WARNINGS
+
 #include "git-compat-util.h"
 #include "ewok.h"
 #include "strbuf.h"
diff --git a/ewah/ewah_rlw.c b/ewah/ewah_rlw.c
index 5093d43e2f00e2bec4290c1fe918d8a0593e2e8c..76b4c6c19eda358a99ce398e5085b6132bc30371 100644
--- a/ewah/ewah_rlw.c
+++ b/ewah/ewah_rlw.c
@@ -16,6 +16,9 @@
  * You should have received a copy of the GNU General Public License
  * along with this program; if not, see <http://www.gnu.org/licenses/>.
  */
+
+#define DISABLE_SIGN_COMPARE_WARNINGS
+
 #include "git-compat-util.h"
 #include "ewok.h"
 #include "ewok_rlw.h"
diff --git a/fetch-pack.c b/fetch-pack.c
index fe1fb3c1b7c8c39e99270cecff5309995806bf05..961cbe2fe338f459553aeb260f0a8b4362a32e6c 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -1,4 +1,5 @@
 #define USE_THE_REPOSITORY_VARIABLE
+#define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "git-compat-util.h"
 #include "repository.h"
diff --git a/fmt-merge-msg.c b/fmt-merge-msg.c
index 6acb37b48020c1f0ce2d5034c478cbb783409502..5b63c3b088a17a1563494cc2811f10649d196d30 100644
--- a/fmt-merge-msg.c
+++ b/fmt-merge-msg.c
@@ -1,4 +1,5 @@
 #define USE_THE_REPOSITORY_VARIABLE
+#define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "git-compat-util.h"
 #include "config.h"
diff --git a/fsmonitor.c b/fsmonitor.c
index 309a2541cbeebe142096176c213056872a0aae6f..98b2b476f086842e67509a9bc0044bfec5fd12fd 100644
--- a/fsmonitor.c
+++ b/fsmonitor.c
@@ -1,4 +1,5 @@
 #define USE_THE_REPOSITORY_VARIABLE
+#define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "git-compat-util.h"
 #include "config.h"
diff --git a/gettext.c b/gettext.c
index 57facbc21ec2545e5bdeb1e738445ad403f419b4..8d08a61f8487dc30559e5e5d6d31cf06a92789e1 100644
--- a/gettext.c
+++ b/gettext.c
@@ -2,6 +2,8 @@
  * Copyright (c) 2010 Ævar Arnfjörð Bjarmason
  */
 
+#define DISABLE_SIGN_COMPARE_WARNINGS
+
 #include "git-compat-util.h"
 #include "abspath.h"
 #include "environment.h"
diff --git a/git.c b/git.c
index c2c1b8e22c2d91824ad6d631ea9374424ab53435..69a17f7c13c6204de59687085e77ede5edef660f 100644
--- a/git.c
+++ b/git.c
@@ -1,4 +1,5 @@
 #define USE_THE_REPOSITORY_VARIABLE
+#define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "builtin.h"
 #include "config.h"
diff --git a/gpg-interface.c b/gpg-interface.c
index 07335987a6b9ceaf6edc2da71c2e636b0513372f..a67d80475bf9d8452de0c3ae9bb08ceeb4c11c4b 100644
--- a/gpg-interface.c
+++ b/gpg-interface.c
@@ -1,4 +1,5 @@
 #define USE_THE_REPOSITORY_VARIABLE
+#define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "git-compat-util.h"
 #include "commit.h"
diff --git a/graph.c b/graph.c
index bf000fdbe11f09a771a0b8a8254004d8348d7895..52205f75c37cf3467ac5e9de1574425d6c203359 100644
--- a/graph.c
+++ b/graph.c
@@ -1,4 +1,5 @@
 #define USE_THE_REPOSITORY_VARIABLE
+#define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "git-compat-util.h"
 #include "gettext.h"
diff --git a/grep.c b/grep.c
index e95cded4149d33d33a9d2027939df4eefba535d1..4e155ee9e66367e00e72c4541aefb2d755d59f25 100644
--- a/grep.c
+++ b/grep.c
@@ -1,3 +1,5 @@
+#define DISABLE_SIGN_COMPARE_WARNINGS
+
 #include "git-compat-util.h"
 #include "config.h"
 #include "gettext.h"
diff --git a/help.c b/help.c
index 4ad4ebdd2cfddb3191bb4f6d593a55d3c5d3ed14..85ae367e759b1225678ae0bc7019346043713a69 100644
--- a/help.c
+++ b/help.c
@@ -1,4 +1,5 @@
 #define USE_THE_REPOSITORY_VARIABLE
+#define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "git-compat-util.h"
 #include "config.h"
diff --git a/hex.c b/hex.c
index 5ca78a7744113b15ecb154f08ac0ecb524c86d66..e62406c182ae54ad9475424f0be00e2d9a6bcaab 100644
--- a/hex.c
+++ b/hex.c
@@ -1,4 +1,5 @@
 #define USE_THE_REPOSITORY_VARIABLE
+#define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "git-compat-util.h"
 #include "hash.h"
diff --git a/http-backend.c b/http-backend.c
index 73eec4ea3d844345ab607488490227d3dbacc02a..33cf3782826f6cca696ecb8c85cea7f4a0829b46 100644
--- a/http-backend.c
+++ b/http-backend.c
@@ -1,4 +1,5 @@
 #define USE_THE_REPOSITORY_VARIABLE
+#define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "git-compat-util.h"
 #include "config.h"
diff --git a/http-push.c b/http-push.c
index 4d24e6b8d4e092591d5687be2bdb3840fa74893c..a5e8c3e9003074c125f562769b26ffe11985c0c3 100644
--- a/http-push.c
+++ b/http-push.c
@@ -1,4 +1,5 @@
 #define USE_THE_REPOSITORY_VARIABLE
+#define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "git-compat-util.h"
 #include "environment.h"
diff --git a/http-walker.c b/http-walker.c
index 43cde0ebe51c3fa311e9b42fb0608763e777b2f5..7918ddc0968dd3bef50da6d76e5b1a9e61279112 100644
--- a/http-walker.c
+++ b/http-walker.c
@@ -1,4 +1,5 @@
 #define USE_THE_REPOSITORY_VARIABLE
+#define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "git-compat-util.h"
 #include "repository.h"
diff --git a/http.c b/http.c
index 58242b9d2dd595e9e0a5cb2d9bc6f38927546328..c74332607d54de2db23fc1be237fa77b2b838e77 100644
--- a/http.c
+++ b/http.c
@@ -1,4 +1,5 @@
 #define USE_THE_REPOSITORY_VARIABLE
+#define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "git-compat-util.h"
 #include "git-curl-compat.h"
diff --git a/imap-send.c b/imap-send.c
index 488c06e6139fb72290a0f49268e7d847ce60a403..e31aede2a7bbc4d37b7c1ec3b3396685f01eea6e 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -22,6 +22,7 @@
  */
 
 #define USE_THE_REPOSITORY_VARIABLE
+#define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "git-compat-util.h"
 #include "config.h"
diff --git a/json-writer.c b/json-writer.c
index 25b9201f9c0bce3c7f268301250cbe42f630fdd1..8c5187e9fdda81455531c6ad42f7f2d4d8b81a9b 100644
--- a/json-writer.c
+++ b/json-writer.c
@@ -1,3 +1,5 @@
+#define DISABLE_SIGN_COMPARE_WARNINGS
+
 #include "git-compat-util.h"
 #include "json-writer.h"
 
diff --git a/kwset.c b/kwset.c
index 695e47b7ccfaf1aaa0e866933dffa8b7fcc51868..1714eada608b86b14acf82ec4832c3c4d7e9205c 100644
--- a/kwset.c
+++ b/kwset.c
@@ -32,6 +32,8 @@
    String Matching:  An Aid to Bibliographic Search," CACM June 1975,
    Vol. 18, No. 6, which describes the failure function used below. */
 
+#define DISABLE_SIGN_COMPARE_WARNINGS
+
 #include "git-compat-util.h"
 
 #include "kwset.h"
diff --git a/line-log.c b/line-log.c
index bca9bd804073df9b77b2859063ac5ad4d3b24e0f..d8dbb339489bf999cc7017e0baec879c8b84ec97 100644
--- a/line-log.c
+++ b/line-log.c
@@ -1,3 +1,5 @@
+#define DISABLE_SIGN_COMPARE_WARNINGS
+
 #include "git-compat-util.h"
 #include "diffcore.h"
 #include "line-range.h"
diff --git a/list-objects-filter-options.c b/list-objects-filter-options.c
index fa72e81e4ad130590546a0003de67648bc1736c6..d1f7c56e6f973062ce69312718dbda79f4b944cd 100644
--- a/list-objects-filter-options.c
+++ b/list-objects-filter-options.c
@@ -1,4 +1,5 @@
 #define USE_THE_REPOSITORY_VARIABLE
+#define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "git-compat-util.h"
 #include "config.h"
diff --git a/list-objects-filter.c b/list-objects-filter.c
index dc598a081bb25283a1f0d287baf3805da2955106..4afa3029dca926baff81fba4a553b31dfed551a1 100644
--- a/list-objects-filter.c
+++ b/list-objects-filter.c
@@ -1,4 +1,5 @@
 #define USE_THE_REPOSITORY_VARIABLE
+#define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "git-compat-util.h"
 #include "dir.h"
diff --git a/list-objects.c b/list-objects.c
index 985d008799d0bb20a56ccaf6f821c699125373f6..2075c69496cde719e3f8deeb05dd5e14f589f036 100644
--- a/list-objects.c
+++ b/list-objects.c
@@ -1,4 +1,5 @@
 #define USE_THE_REPOSITORY_VARIABLE
+#define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "git-compat-util.h"
 #include "tag.h"
diff --git a/log-tree.c b/log-tree.c
index 83cc4b1cfb798c923a8147364e63ceaebf1dacf8..d08eb672a933900558b305b31860f6753a470bf0 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -1,4 +1,5 @@
 #define USE_THE_REPOSITORY_VARIABLE
+#define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "git-compat-util.h"
 #include "commit-reach.h"
diff --git a/ls-refs.c b/ls-refs.c
index c824aea7146a3e825c54b62bc7a77da82365940f..89a796a3561502893e160917bf04fb66af54397b 100644
--- a/ls-refs.c
+++ b/ls-refs.c
@@ -1,4 +1,5 @@
 #define USE_THE_REPOSITORY_VARIABLE
+#define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "git-compat-util.h"
 #include "environment.h"
diff --git a/mailinfo.c b/mailinfo.c
index d1f42bd7e3e692aceb6806cedd71af1546c8aa4e..aa263bf490881daa915a03a681c00979f138d09b 100644
--- a/mailinfo.c
+++ b/mailinfo.c
@@ -1,4 +1,5 @@
 #define USE_THE_REPOSITORY_VARIABLE
+#define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "git-compat-util.h"
 #include "config.h"
diff --git a/mailmap.c b/mailmap.c
index 9f9fa3199a85f82fd57381086943059ed0a9ff3f..f35d20ed7fd1ef251e65419805fec49a3c30bcbb 100644
--- a/mailmap.c
+++ b/mailmap.c
@@ -1,4 +1,5 @@
 #define USE_THE_REPOSITORY_VARIABLE
+#define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "git-compat-util.h"
 #include "environment.h"
diff --git a/match-trees.c b/match-trees.c
index 147b03abf18f65a7c0a0f262960e4a4b740d27b7..a1c8b91eaef8fa7c1714e6c2b4ec78ac365ae99d 100644
--- a/match-trees.c
+++ b/match-trees.c
@@ -1,4 +1,5 @@
 #define USE_THE_REPOSITORY_VARIABLE
+#define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "git-compat-util.h"
 #include "hex.h"
diff --git a/mem-pool.c b/mem-pool.c
index a3ba38831d94d6fcde4de9c19972c3df7a369ee2..62441dcc71968f3aaaccdac4dea3cb4ff2f18708 100644
--- a/mem-pool.c
+++ b/mem-pool.c
@@ -2,6 +2,8 @@
  * Memory Pool implementation logic.
  */
 
+#define DISABLE_SIGN_COMPARE_WARNINGS
+
 #include "git-compat-util.h"
 #include "mem-pool.h"
 #include "gettext.h"
diff --git a/merge-ll.c b/merge-ll.c
index 62fc625552dcd3a598bd2de80ae93c96ea5c98cf..b2dc26da4fe92d2c922435fa5dad381f996ef26b 100644
--- a/merge-ll.c
+++ b/merge-ll.c
@@ -5,6 +5,7 @@
  */
 
 #define USE_THE_REPOSITORY_VARIABLE
+#define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "git-compat-util.h"
 #include "config.h"
diff --git a/merge-ort.c b/merge-ort.c
index 11029c10be3d2bed33b7d7cf49e83a183fe56a18..46e78c3ffa68e62dec08e8619800fcae28a9dd9d 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -15,6 +15,7 @@
  */
 
 #define USE_THE_REPOSITORY_VARIABLE
+#define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "git-compat-util.h"
 #include "merge-ort.h"
diff --git a/merge-recursive.c b/merge-recursive.c
index ed64a4c537ca8925c0336164a5ae30a4fd7cd6fe..5dfaf32b2c18809209da4a0fa306b23b7e08c98e 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -5,6 +5,7 @@
  */
 
 #define USE_THE_REPOSITORY_VARIABLE
+#define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "git-compat-util.h"
 #include "merge-recursive.h"
diff --git a/merge.c b/merge.c
index fe3efa4b24b7d10514cda3c3dfa6a06093dfc1f4..da04fff3baa6b64e2581ac86186b99db914a6858 100644
--- a/merge.c
+++ b/merge.c
@@ -1,4 +1,5 @@
 #define USE_THE_REPOSITORY_VARIABLE
+#define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "git-compat-util.h"
 #include "gettext.h"
diff --git a/midx-write.c b/midx-write.c
index b3a5f6c51669349dc26edf94b5c25b8fea033322..f1a6f83baee834ab9b40ee2e566b515d06cbb4c5 100644
--- a/midx-write.c
+++ b/midx-write.c
@@ -1,4 +1,5 @@
 #define USE_THE_REPOSITORY_VARIABLE
+#define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "git-compat-util.h"
 #include "abspath.h"
diff --git a/midx.c b/midx.c
index e82d4f2e65496b3e26c6e21c42e274406111aa3b..504e03327ab0dd135e4772ec8b9de4bdd77da3f5 100644
--- a/midx.c
+++ b/midx.c
@@ -1,4 +1,5 @@
 #define USE_THE_REPOSITORY_VARIABLE
+#define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "git-compat-util.h"
 #include "config.h"
diff --git a/name-hash.c b/name-hash.c
index 95528e3bcd2a3e36cf72faa7ed629c3175492bbb..d66de1cdfd563336f468817306664dea9a4a9e7a 100644
--- a/name-hash.c
+++ b/name-hash.c
@@ -7,6 +7,7 @@
  */
 
 #define USE_THE_REPOSITORY_VARIABLE
+#define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "git-compat-util.h"
 #include "environment.h"
diff --git a/notes-merge.c b/notes-merge.c
index dadbbabf86da6a3acf82c1a292700b483b5dfb5d..8d701ed428aa621cc21871c49a0776bccf4be916 100644
--- a/notes-merge.c
+++ b/notes-merge.c
@@ -1,4 +1,5 @@
 #define USE_THE_REPOSITORY_VARIABLE
+#define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "git-compat-util.h"
 #include "advice.h"
diff --git a/notes.c b/notes.c
index f4f18daf07ec5257130c515d0b80166de9c4bde5..f5344230505afbdbbac1519e7605d541e6f94f11 100644
--- a/notes.c
+++ b/notes.c
@@ -1,4 +1,5 @@
 #define USE_THE_REPOSITORY_VARIABLE
+#define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "git-compat-util.h"
 #include "config.h"
diff --git a/object-file-convert.c b/object-file-convert.c
index 3887d6d57b7965074702829403b36518ab7022e6..eba71955cf7b8821b9e6d0129c7542cf10c652a8 100644
--- a/object-file-convert.c
+++ b/object-file-convert.c
@@ -1,4 +1,5 @@
 #define USE_THE_REPOSITORY_VARIABLE
+#define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "git-compat-util.h"
 #include "gettext.h"
diff --git a/object-file.c b/object-file.c
index 891eaa2b4bee2e6b5da1211c950fafa9aa40a807..5b792b3dd42cecde43a1b18abc164fd368cbcd69 100644
--- a/object-file.c
+++ b/object-file.c
@@ -8,6 +8,7 @@
  */
 
 #define USE_THE_REPOSITORY_VARIABLE
+#define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "git-compat-util.h"
 #include "abspath.h"
diff --git a/object-name.c b/object-name.c
index c892fbe80aa7173dfcc1995de5a75bc322c6adb7..d396778efc02b4b3818c3ba8d34e209c537c4129 100644
--- a/object-name.c
+++ b/object-name.c
@@ -1,4 +1,5 @@
 #define USE_THE_REPOSITORY_VARIABLE
+#define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "git-compat-util.h"
 #include "object-name.h"
diff --git a/object.c b/object.c
index 94ea8fb8d2c4f9877e0b89759e890c44d6392698..100bf9b8d12beb1bdaa0c222e51e920471d891c7 100644
--- a/object.c
+++ b/object.c
@@ -1,4 +1,5 @@
 #define USE_THE_REPOSITORY_VARIABLE
+#define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "git-compat-util.h"
 #include "gettext.h"
diff --git a/pack-bitmap-write.c b/pack-bitmap-write.c
index 49758e2525f01afc4c31a97a8128e5d92f7f7939..4f8be53c2bd75f83a0555e2a5510c2bbca07b36d 100644
--- a/pack-bitmap-write.c
+++ b/pack-bitmap-write.c
@@ -1,4 +1,5 @@
 #define USE_THE_REPOSITORY_VARIABLE
+#define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "git-compat-util.h"
 #include "environment.h"
diff --git a/pack-bitmap.c b/pack-bitmap.c
index 4fa9dfc771a30545281b8a5e2b7d26dc5682c285..b2ad04c05c370bd84be2e3dbcadeb4cad86a7f64 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -1,4 +1,5 @@
 #define USE_THE_REPOSITORY_VARIABLE
+#define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "git-compat-util.h"
 #include "commit.h"
diff --git a/pack-check.c b/pack-check.c
index e883dae3f24bb4c04c2f0ddf520e0e91bd209f07..8d9f6da7ce45f8a1bd83e0768d47d7e5ebe88493 100644
--- a/pack-check.c
+++ b/pack-check.c
@@ -1,4 +1,5 @@
 #define USE_THE_REPOSITORY_VARIABLE
+#define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "git-compat-util.h"
 #include "environment.h"
diff --git a/packfile.c b/packfile.c
index 9560f0a33c6f26d0d14dfe81320f5a760cc585df..f38c207fb6b15ea52440c850d9dee103f5dbd940 100644
--- a/packfile.c
+++ b/packfile.c
@@ -1,4 +1,5 @@
 #define USE_THE_REPOSITORY_VARIABLE
+#define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "git-compat-util.h"
 #include "environment.h"
diff --git a/parallel-checkout.c b/parallel-checkout.c
index 01736f1352a5dc58886dfd3cb05a46d2a32e829d..7cc6b3052819ac640968a6dd01c0c7db1c7accb0 100644
--- a/parallel-checkout.c
+++ b/parallel-checkout.c
@@ -1,4 +1,5 @@
 #define USE_THE_REPOSITORY_VARIABLE
+#define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "git-compat-util.h"
 #include "config.h"
diff --git a/patch-ids.c b/patch-ids.c
index a5683b462c6e7692ceff3218213b9747a9b6cc02..8b891980732fd33f89bb8b1ef1bf9ad6717120ec 100644
--- a/patch-ids.c
+++ b/patch-ids.c
@@ -1,3 +1,5 @@
+#define DISABLE_SIGN_COMPARE_WARNINGS
+
 #include "git-compat-util.h"
 #include "diff.h"
 #include "commit.h"
diff --git a/path.c b/path.c
index 93491bab141c5633691f5172e450052800da63ed..1f210048047b72370d87a6161c4af0142c17cf6a 100644
--- a/path.c
+++ b/path.c
@@ -3,6 +3,7 @@
  */
 
 #define USE_THE_REPOSITORY_VARIABLE
+#define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "git-compat-util.h"
 #include "abspath.h"
diff --git a/pathspec.c b/pathspec.c
index 0fc6f84a6e629858ca6d1e65a3c1af352d043e95..89663645e13dd49499b7f6cf8b1fdf663145981d 100644
--- a/pathspec.c
+++ b/pathspec.c
@@ -1,4 +1,5 @@
 #define USE_THE_REPOSITORY_VARIABLE
+#define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "git-compat-util.h"
 #include "abspath.h"
diff --git a/pkt-line.c b/pkt-line.c
index 24479eae4dbe2a44b15a10f86b15bfc6f865bb34..90ea2b6974b1d0957cfdc5e2f9a2c30720723f12 100644
--- a/pkt-line.c
+++ b/pkt-line.c
@@ -1,3 +1,5 @@
+#define DISABLE_SIGN_COMPARE_WARNINGS
+
 #include "git-compat-util.h"
 #include "copy.h"
 #include "pkt-line.h"
diff --git a/preload-index.c b/preload-index.c
index 7926eb09a695f7c5ea0e0de1e48690caf6c6fa6f..ab94d6f39967ea4358f51ff8384aa60927bfe259 100644
--- a/preload-index.c
+++ b/preload-index.c
@@ -3,6 +3,7 @@
  */
 
 #define USE_THE_REPOSITORY_VARIABLE
+#define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "git-compat-util.h"
 #include "pathspec.h"
diff --git a/pretty.c b/pretty.c
index 098378720a44c71cdec69f1b3cb4485806357e2a..0bc8ad8a9a8bc1b0002e3634dbf9588569dc61bd 100644
--- a/pretty.c
+++ b/pretty.c
@@ -1,4 +1,5 @@
 #define USE_THE_REPOSITORY_VARIABLE
+#define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "git-compat-util.h"
 #include "config.h"
diff --git a/progress.c b/progress.c
index 0d44c18edc0c522c3d8fb4769c26009439cc61ce..a8fdfceb5cd12879ebac80589bb5b5e8661c2627 100644
--- a/progress.c
+++ b/progress.c
@@ -10,6 +10,7 @@
 
 #define GIT_TEST_PROGRESS_ONLY
 #define USE_THE_REPOSITORY_VARIABLE
+#define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "git-compat-util.h"
 #include "pager.h"
diff --git a/pseudo-merge.c b/pseudo-merge.c
index bb59965ed26d5bbddb17149f8460bfe175722898..971f54cfe1a895aed00f6d0a65c62aafc83a0cc8 100644
--- a/pseudo-merge.c
+++ b/pseudo-merge.c
@@ -1,4 +1,5 @@
 #define USE_THE_REPOSITORY_VARIABLE
+#define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "git-compat-util.h"
 #include "pseudo-merge.h"
diff --git a/quote.c b/quote.c
index 3c05194496f65f879f437abd29823986ef118f47..b9f6bdc775c4686c192b8b339adac7e664af8e0f 100644
--- a/quote.c
+++ b/quote.c
@@ -1,3 +1,5 @@
+#define DISABLE_SIGN_COMPARE_WARNINGS
+
 #include "git-compat-util.h"
 #include "path.h"
 #include "quote.h"
diff --git a/range-diff.c b/range-diff.c
index 10885ba301389754869b7cdc73f7596e6cb069ea..eea172bcc993a634bbec1d73ac296374b38d232f 100644
--- a/range-diff.c
+++ b/range-diff.c
@@ -1,4 +1,5 @@
 #define USE_THE_REPOSITORY_VARIABLE
+#define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "git-compat-util.h"
 #include "environment.h"
diff --git a/reachable.c b/reachable.c
index 3e9b3dd0a46cb410b8f032784115c78084c5dbd9..34079e1ae9b20313c86c7962f518aa266b7153ea 100644
--- a/reachable.c
+++ b/reachable.c
@@ -1,4 +1,5 @@
 #define USE_THE_REPOSITORY_VARIABLE
+#define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "git-compat-util.h"
 #include "gettext.h"
diff --git a/read-cache.c b/read-cache.c
index 01d0b3ad22565da67fbba9c1aa0fd3cb4e97589d..15d79839c205176f9161f537aa706dac44b3023c 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -5,6 +5,7 @@
  */
 
 #define USE_THE_REPOSITORY_VARIABLE
+#define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "git-compat-util.h"
 #include "bulk-checkin.h"
diff --git a/ref-filter.c b/ref-filter.c
index 84c603610723eacf15349e0c5809a771de418bfd..23054694c2c96014ef411a225c6c941eb8d2d56c 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -1,4 +1,5 @@
 #define USE_THE_REPOSITORY_VARIABLE
+#define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "git-compat-util.h"
 #include "environment.h"
diff --git a/reflog-walk.c b/reflog-walk.c
index c7070b13b004b7c207a3f99740999f582c15c1b0..b53628ed5372235d840ce481d22a90cf10ad5c8a 100644
--- a/reflog-walk.c
+++ b/reflog-walk.c
@@ -1,4 +1,5 @@
 #define USE_THE_REPOSITORY_VARIABLE
+#define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "git-compat-util.h"
 #include "commit.h"
diff --git a/reflog.c b/reflog.c
index aeab78c9b71573c0e043f2de833a7e97580d20f6..1b5f031f6d787f3e454471252c7a600dcb765a15 100644
--- a/reflog.c
+++ b/reflog.c
@@ -1,4 +1,5 @@
 #define USE_THE_REPOSITORY_VARIABLE
+#define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "git-compat-util.h"
 #include "gettext.h"
diff --git a/refs.c b/refs.c
index 7866cd7378da95b3cdd508500633958802d166d0..729a61ba0042214da89421a4673797dd33d4d5ac 100644
--- a/refs.c
+++ b/refs.c
@@ -3,6 +3,7 @@
  */
 
 #define USE_THE_REPOSITORY_VARIABLE
+#define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "git-compat-util.h"
 #include "advice.h"
diff --git a/refs/debug.c b/refs/debug.c
index 45e2e784a0f8c49f492eaa9d371aa44f8c7916c3..5082e83c8d6b08a5ae75f353b853746bcee217b6 100644
--- a/refs/debug.c
+++ b/refs/debug.c
@@ -1,3 +1,5 @@
+#define DISABLE_SIGN_COMPARE_WARNINGS
+
 #include "git-compat-util.h"
 #include "hex.h"
 #include "refs-internal.h"
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 0824c0b8a946909791da36ddb4171db4ad98913b..5d6f1152e61e47dfa319fc175871909c941461fb 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1,4 +1,5 @@
 #define USE_THE_REPOSITORY_VARIABLE
+#define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "../git-compat-util.h"
 #include "../config.h"
diff --git a/refs/iterator.c b/refs/iterator.c
index 8e999d81fc638fc52b470819a79ece7ee08842cb..d25e568bf0b7684611ea74b1bb658ad4b816cc2d 100644
--- a/refs/iterator.c
+++ b/refs/iterator.c
@@ -3,6 +3,8 @@
  * documentation about the design and use of reference iterators.
  */
 
+#define DISABLE_SIGN_COMPARE_WARNINGS
+
 #include "git-compat-util.h"
 #include "refs.h"
 #include "refs/refs-internal.h"
diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index 07c57fd541a5039d5fcb93d9bf78e1916f67b219..7848be99e1a7a003d60732578edf217ad679c037 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -1,4 +1,5 @@
 #define USE_THE_REPOSITORY_VARIABLE
+#define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "../git-compat-util.h"
 #include "../config.h"
diff --git a/refspec.c b/refspec.c
index 994901f55b8e3723dcc21e3c33d3e401960fe7fd..6d86e04442ca2132c318616fd6ebd4b94a28e4eb 100644
--- a/refspec.c
+++ b/refspec.c
@@ -1,4 +1,5 @@
 #define USE_THE_REPOSITORY_VARIABLE
+#define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "git-compat-util.h"
 #include "gettext.h"
diff --git a/reftable/system.h b/reftable/system.h
index 5ec85833434727c720abb4ba00dc7a22c8ac5d26..d3b8a55f4be3c5ca6e0278cf4334e45172a6be03 100644
--- a/reftable/system.h
+++ b/reftable/system.h
@@ -11,6 +11,8 @@ license that can be found in the LICENSE file or at
 
 /* This header glues the reftable library to the rest of Git */
 
+#define DISABLE_SIGN_COMPARE_WARNINGS
+
 #include "git-compat-util.h"
 #include "lockfile.h"
 #include "tempfile.h"
diff --git a/remote-curl.c b/remote-curl.c
index 9a71e0430188475d44f8118b361416d9d02ecb83..a24e3a8b9abcc9f01d862a18dbd237fdad8d3d3a 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -1,4 +1,5 @@
 #define USE_THE_REPOSITORY_VARIABLE
+#define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "git-compat-util.h"
 #include "git-curl-compat.h"
diff --git a/remote.c b/remote.c
index 10104d11e3cba1908cd35f22b54e167755770404..a6d8c15189d03d3b3ac1c749bebdce3fd4ed558c 100644
--- a/remote.c
+++ b/remote.c
@@ -1,4 +1,5 @@
 #define USE_THE_REPOSITORY_VARIABLE
+#define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "git-compat-util.h"
 #include "abspath.h"
diff --git a/rerere.c b/rerere.c
index d01e98bf653b043ce949f291bec9ad790f057eff..e7fa6426b399e0337435003e2816ea9d021a379b 100644
--- a/rerere.c
+++ b/rerere.c
@@ -1,4 +1,5 @@
 #define USE_THE_REPOSITORY_VARIABLE
+#define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "git-compat-util.h"
 #include "abspath.h"
diff --git a/resolve-undo.c b/resolve-undo.c
index 8c9911affbe409cdc635f7fd1270225c30a51236..b5a9dfb4acc51173b1d9b7b1b044a1fc611d3f74 100644
--- a/resolve-undo.c
+++ b/resolve-undo.c
@@ -1,4 +1,5 @@
 #define USE_THE_REPOSITORY_VARIABLE
+#define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "git-compat-util.h"
 #include "dir.h"
diff --git a/revision.c b/revision.c
index 8df75b82249b36e7e3ee9a4a151f085c189acc45..4d435e3297ba087094c3d9df55df0cbeeecce909 100644
--- a/revision.c
+++ b/revision.c
@@ -1,4 +1,5 @@
 #define USE_THE_REPOSITORY_VARIABLE
+#define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "git-compat-util.h"
 #include "config.h"
diff --git a/run-command.c b/run-command.c
index 94f2f3079ff754a0445e1c443c4991691879d04e..402138b8b53ae8e74897cbafeaaf226850135f65 100644
--- a/run-command.c
+++ b/run-command.c
@@ -1,4 +1,5 @@
 #define USE_THE_REPOSITORY_VARIABLE
+#define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "git-compat-util.h"
 #include "run-command.h"
diff --git a/scalar.c b/scalar.c
index ac0cb579d3f00551fc0afe75f724208c367d8dc3..87bb30991bf768534a988608d9b194dc8b5ba78a 100644
--- a/scalar.c
+++ b/scalar.c
@@ -3,6 +3,7 @@
  */
 
 #define USE_THE_REPOSITORY_VARIABLE
+#define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "git-compat-util.h"
 #include "abspath.h"
diff --git a/send-pack.c b/send-pack.c
index 6677c44e8acd19f16706ad2d78f72fee889daa55..6e68074e50dbc48622b0e63e56cfbe3560dcd605 100644
--- a/send-pack.c
+++ b/send-pack.c
@@ -1,4 +1,5 @@
 #define USE_THE_REPOSITORY_VARIABLE
+#define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "git-compat-util.h"
 #include "config.h"
diff --git a/sequencer.c b/sequencer.c
index 353d804999b88d5fd5dcf1254d80781f20e62f2e..99a5e02461f019d877b5ff7674fb45c6e28dba10 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1,4 +1,5 @@
 #define USE_THE_REPOSITORY_VARIABLE
+#define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "git-compat-util.h"
 #include "abspath.h"
diff --git a/serve.c b/serve.c
index d674764a25d4cdb68a89cfcf991cbee94fa8cfe3..1e08fa92510c5f78e675aa0e91c8505018d5dcfa 100644
--- a/serve.c
+++ b/serve.c
@@ -1,4 +1,5 @@
 #define USE_THE_REPOSITORY_VARIABLE
+#define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "git-compat-util.h"
 #include "repository.h"
diff --git a/server-info.c b/server-info.c
index c5af4cd98a6696a15cda42a4a41a76bb729db93a..ef2f3f4b5c7b04c46520b2fd9d4352b806658f40 100644
--- a/server-info.c
+++ b/server-info.c
@@ -1,4 +1,5 @@
 #define USE_THE_REPOSITORY_VARIABLE
+#define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "git-compat-util.h"
 #include "dir.h"
diff --git a/setup.c b/setup.c
index 7b648de0279116b381eea46800ad130606926103..8084465197cb7fe3f91389458b44f619612c8930 100644
--- a/setup.c
+++ b/setup.c
@@ -1,4 +1,5 @@
 #define USE_THE_REPOSITORY_VARIABLE
+#define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "git-compat-util.h"
 #include "abspath.h"
diff --git a/shallow.c b/shallow.c
index 4bb1518dbc80747d2641a5a80291ab159270804c..82a8da3d730b2f4f6bda462c8ac347f0b10da993 100644
--- a/shallow.c
+++ b/shallow.c
@@ -1,4 +1,5 @@
 #define USE_THE_REPOSITORY_VARIABLE
+#define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "git-compat-util.h"
 #include "hex.h"
diff --git a/sideband.c b/sideband.c
index 02805573fab85d602a83e5bc54dfb5ba404ab44b..251e9615ed0239d77556d4ff92fe5570f083d6fe 100644
--- a/sideband.c
+++ b/sideband.c
@@ -1,4 +1,5 @@
 #define USE_THE_REPOSITORY_VARIABLE
+#define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "git-compat-util.h"
 #include "color.h"
diff --git a/sparse-index.c b/sparse-index.c
index 2107840bfc56714ec4cbe31253035b063e363ed7..5634abafaa07ed77ad24d10457b7f1f3ec6108ec 100644
--- a/sparse-index.c
+++ b/sparse-index.c
@@ -1,4 +1,5 @@
 #define USE_THE_REPOSITORY_VARIABLE
+#define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "git-compat-util.h"
 #include "environment.h"
diff --git a/split-index.c b/split-index.c
index 120c8190b187bc8c6c73630f06f5dd4dc994df30..d225f0da541de35367c22f841920c02f73ab51fa 100644
--- a/split-index.c
+++ b/split-index.c
@@ -1,4 +1,5 @@
 #define USE_THE_REPOSITORY_VARIABLE
+#define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "git-compat-util.h"
 #include "gettext.h"
diff --git a/strbuf.c b/strbuf.c
index 3d2189a7f648dcba44e85aa1b2047b00b3f871df..8ddd4b06c595ac3f8b38a65d3e1ca4b340fddf9f 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -1,3 +1,5 @@
+#define DISABLE_SIGN_COMPARE_WARNINGS
+
 #include "git-compat-util.h"
 #include "gettext.h"
 #include "hex-ll.h"
diff --git a/string-list.c b/string-list.c
index 954569f381d8d7ea2e1c6f1333b1e8379ffe2fe8..bf061fec563d742b79c4ab2ffc1734da4f6c4d9e 100644
--- a/string-list.c
+++ b/string-list.c
@@ -1,3 +1,5 @@
+#define DISABLE_SIGN_COMPARE_WARNINGS
+
 #include "git-compat-util.h"
 #include "string-list.h"
 
diff --git a/strvec.c b/strvec.c
index f712070f5745d5f998d0846ac4009441dddfa500..03d6eee6cdd1b17b1dec8be7fb148a9317464b2b 100644
--- a/strvec.c
+++ b/strvec.c
@@ -1,3 +1,5 @@
+#define DISABLE_SIGN_COMPARE_WARNINGS
+
 #include "git-compat-util.h"
 #include "strvec.h"
 #include "strbuf.h"
diff --git a/submodule-config.c b/submodule-config.c
index 9c8c37b25986aabc7098b53953ac1ecf85375ed0..a25059ed7f8d8fbacf97d2a3a6ea5cf18da2ecfe 100644
--- a/submodule-config.c
+++ b/submodule-config.c
@@ -1,4 +1,5 @@
 #define USE_THE_REPOSITORY_VARIABLE
+#define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "git-compat-util.h"
 #include "dir.h"
diff --git a/submodule.c b/submodule.c
index 7ec564854d03398ff8acf4e280d48125c47f2876..ed1441923d9e3f4f98e476c5899f54c6ed445ae2 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1,4 +1,5 @@
 #define USE_THE_REPOSITORY_VARIABLE
+#define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "git-compat-util.h"
 #include "abspath.h"
diff --git a/symlinks.c b/symlinks.c
index b29e340c2da43e9ac35adcda05322b1e068017ca..9cc090d42c089f82178de90514d592cf70a5822f 100644
--- a/symlinks.c
+++ b/symlinks.c
@@ -1,3 +1,5 @@
+#define DISABLE_SIGN_COMPARE_WARNINGS
+
 #include "git-compat-util.h"
 #include "gettext.h"
 #include "setup.h"
diff --git a/t/helper/test-bloom.c b/t/helper/test-bloom.c
index 97541daf7157b1a8adda5fb97f839208a5e99fd0..8d4ef441312e2059058c6465b0c084e6f31921cc 100644
--- a/t/helper/test-bloom.c
+++ b/t/helper/test-bloom.c
@@ -1,4 +1,5 @@
 #define USE_THE_REPOSITORY_VARIABLE
+#define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "test-tool.h"
 #include "bloom.h"
diff --git a/t/helper/test-cache-tree.c b/t/helper/test-cache-tree.c
index 5cdef3ebefc6281499f80a01456b8cf6c6944d5c..3ae45cec3be6390c8220dab95a403c573ce719a2 100644
--- a/t/helper/test-cache-tree.c
+++ b/t/helper/test-cache-tree.c
@@ -1,4 +1,5 @@
 #define USE_THE_REPOSITORY_VARIABLE
+#define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "test-tool.h"
 #include "gettext.h"
diff --git a/t/helper/test-config.c b/t/helper/test-config.c
index 33247f0e92e01ddf24e219894fea6b3aa66de26e..75e028ab2a04497d3438bf46e936e0c4eb44ae8d 100644
--- a/t/helper/test-config.c
+++ b/t/helper/test-config.c
@@ -1,4 +1,5 @@
 #define USE_THE_REPOSITORY_VARIABLE
+#define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "test-tool.h"
 #include "config.h"
diff --git a/t/helper/test-csprng.c b/t/helper/test-csprng.c
index 65d14973c520ea739543080d6d6fe8c1641d9f34..ea9b9b656307d32bdc1f2e15a91793b1dda9c463 100644
--- a/t/helper/test-csprng.c
+++ b/t/helper/test-csprng.c
@@ -1,3 +1,5 @@
+#define DISABLE_SIGN_COMPARE_WARNINGS
+
 #include "test-tool.h"
 #include "git-compat-util.h"
 
diff --git a/t/helper/test-drop-caches.c b/t/helper/test-drop-caches.c
index 73e551cfc222695c31bfc6897d12dc025c87b439..7055d94354fbfa1dda8c7bafbcdd8f426786ec05 100644
--- a/t/helper/test-drop-caches.c
+++ b/t/helper/test-drop-caches.c
@@ -1,3 +1,5 @@
+#define DISABLE_SIGN_COMPARE_WARNINGS
+
 #include "test-tool.h"
 #include "git-compat-util.h"
 
diff --git a/t/helper/test-dump-fsmonitor.c b/t/helper/test-dump-fsmonitor.c
index 1b7f37a84fb2ac1bfc110376e18d4ed4e2fd3d3c..7b78f9d182d89dae4878e0ecf3e0bd99f79bfd39 100644
--- a/t/helper/test-dump-fsmonitor.c
+++ b/t/helper/test-dump-fsmonitor.c
@@ -1,4 +1,5 @@
 #define USE_THE_REPOSITORY_VARIABLE
+#define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "test-tool.h"
 #include "read-cache-ll.h"
diff --git a/t/helper/test-dump-split-index.c b/t/helper/test-dump-split-index.c
index a6720faf9ca99d4e523cb2ce056b74867bd4a024..f31b44a7677a96ed2f2eec870ded3af8d1b2a79e 100644
--- a/t/helper/test-dump-split-index.c
+++ b/t/helper/test-dump-split-index.c
@@ -1,4 +1,5 @@
 #define USE_THE_REPOSITORY_VARIABLE
+#define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "test-tool.h"
 #include "hex.h"
diff --git a/t/helper/test-dump-untracked-cache.c b/t/helper/test-dump-untracked-cache.c
index b2e70837a90a94d628a3d027fe28092a8ba348d9..ae057958000e41959ec452c6577287fbd8475173 100644
--- a/t/helper/test-dump-untracked-cache.c
+++ b/t/helper/test-dump-untracked-cache.c
@@ -1,4 +1,5 @@
 #define USE_THE_REPOSITORY_VARIABLE
+#define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "test-tool.h"
 #include "dir.h"
diff --git a/t/helper/test-genrandom.c b/t/helper/test-genrandom.c
index 99b8dc1e2d9cdc3a0e0f464fdeee0f94733d00d1..5b51e6648d8e698b09f400efcf67a0708c226e9d 100644
--- a/t/helper/test-genrandom.c
+++ b/t/helper/test-genrandom.c
@@ -4,6 +4,8 @@
  * Copyright (C) 2007 by Nicolas Pitre, licensed under the GPL version 2.
  */
 
+#define DISABLE_SIGN_COMPARE_WARNINGS
+
 #include "test-tool.h"
 #include "git-compat-util.h"
 
diff --git a/t/helper/test-genzeros.c b/t/helper/test-genzeros.c
index 47af843b6816005f2370fb130bc9f2bde873c029..b895436a32de602c3cdf2a2d491c7a4b1e76df9d 100644
--- a/t/helper/test-genzeros.c
+++ b/t/helper/test-genzeros.c
@@ -1,3 +1,5 @@
+#define DISABLE_SIGN_COMPARE_WARNINGS
+
 #include "test-tool.h"
 #include "git-compat-util.h"
 
diff --git a/t/helper/test-hash-speed.c b/t/helper/test-hash-speed.c
index 7de822af5168d12cfd1146f7ab8eacc02273f570..81a446dd64e4134585f90a01c28e95edf0b059de 100644
--- a/t/helper/test-hash-speed.c
+++ b/t/helper/test-hash-speed.c
@@ -1,3 +1,5 @@
+#define DISABLE_SIGN_COMPARE_WARNINGS
+
 #include "test-tool.h"
 #include "hash.h"
 
diff --git a/t/helper/test-mergesort.c b/t/helper/test-mergesort.c
index 328bfe29778c46094579327c995a0d56d7435f10..791e12879388de328b2448d4b3f55cfe4ab87a97 100644
--- a/t/helper/test-mergesort.c
+++ b/t/helper/test-mergesort.c
@@ -1,3 +1,5 @@
+#define DISABLE_SIGN_COMPARE_WARNINGS
+
 #include "test-tool.h"
 #include "mem-pool.h"
 #include "mergesort.h"
diff --git a/t/helper/test-parse-options.c b/t/helper/test-parse-options.c
index 5250913d99eba18a28878d3904cb7b2399670d02..f6acd09941b9d14af3dff6f5d90a478bb7e8dd85 100644
--- a/t/helper/test-parse-options.c
+++ b/t/helper/test-parse-options.c
@@ -1,3 +1,5 @@
+#define DISABLE_SIGN_COMPARE_WARNINGS
+
 #include "test-tool.h"
 #include "parse-options.h"
 #include "strbuf.h"
diff --git a/t/helper/test-path-utils.c b/t/helper/test-path-utils.c
index 3129aa28fd2859125c78da3fd286ea609db706e2..72ac8d1b1b011de48ddc62dfae4b21f4132559a0 100644
--- a/t/helper/test-path-utils.c
+++ b/t/helper/test-path-utils.c
@@ -1,4 +1,5 @@
 #define USE_THE_REPOSITORY_VARIABLE
+#define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "test-tool.h"
 #include "abspath.h"
diff --git a/t/helper/test-reach.c b/t/helper/test-reach.c
index 84deee604adb4ba28150de8356ad0fe318ecbb35..25c232464df1639766c2db013d6e5b4b7021cbb2 100644
--- a/t/helper/test-reach.c
+++ b/t/helper/test-reach.c
@@ -1,4 +1,5 @@
 #define USE_THE_REPOSITORY_VARIABLE
+#define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "test-tool.h"
 #include "commit.h"
diff --git a/t/helper/test-ref-store.c b/t/helper/test-ref-store.c
index 65346dee551ccd781a88786f0c8465f60b286cde..b1c2b8b3eb0686b9a62780687ecce17682416308 100644
--- a/t/helper/test-ref-store.c
+++ b/t/helper/test-ref-store.c
@@ -1,4 +1,5 @@
 #define USE_THE_REPOSITORY_VARIABLE
+#define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "test-tool.h"
 #include "hex.h"
diff --git a/t/helper/test-revision-walking.c b/t/helper/test-revision-walking.c
index 071f5bd1e21974ba2104a76305a5156ee2c2961f..3b931a34a2a2198287fb7f0175ac11e6f2ba0059 100644
--- a/t/helper/test-revision-walking.c
+++ b/t/helper/test-revision-walking.c
@@ -9,6 +9,7 @@
  */
 
 #define USE_THE_REPOSITORY_VARIABLE
+#define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "test-tool.h"
 #include "commit.h"
diff --git a/t/helper/test-run-command.c b/t/helper/test-run-command.c
index 61eb1175fe53f482b92bd4cda75ea34ce3d62cba..3719f23cc2d02f0a6c1760a3263bbc6a0f335fcb 100644
--- a/t/helper/test-run-command.c
+++ b/t/helper/test-run-command.c
@@ -8,6 +8,8 @@
  * published by the Free Software Foundation.
  */
 
+#define DISABLE_SIGN_COMPARE_WARNINGS
+
 #include "test-tool.h"
 #include "run-command.h"
 #include "strvec.h"
diff --git a/t/helper/test-string-list.c b/t/helper/test-string-list.c
index e2aad611d1c8bbc110c877c7d7555c046b82e7db..6f10c5a43540b8001cf878a6cb0a0bb11bdee882 100644
--- a/t/helper/test-string-list.c
+++ b/t/helper/test-string-list.c
@@ -1,3 +1,5 @@
+#define DISABLE_SIGN_COMPARE_WARNINGS
+
 #include "test-tool.h"
 #include "strbuf.h"
 #include "string-list.h"
diff --git a/t/helper/test-tool.c b/t/helper/test-tool.c
index 1ebb69a5dc4c1716fe21e1640eecf5f5f05c130d..b626f64eca47cce16abdd9915462af46c66b0044 100644
--- a/t/helper/test-tool.c
+++ b/t/helper/test-tool.c
@@ -1,3 +1,5 @@
+#define DISABLE_SIGN_COMPARE_WARNINGS
+
 #include "git-compat-util.h"
 #include "test-tool.h"
 #include "test-tool-utils.h"
diff --git a/t/helper/test-trace2.c b/t/helper/test-trace2.c
index c588c273ce73f18ab487d6125d7387601a86bb21..415df078c1638a3a1fdf5b555efbef63e68be43b 100644
--- a/t/helper/test-trace2.c
+++ b/t/helper/test-trace2.c
@@ -1,4 +1,5 @@
 #define USE_THE_REPOSITORY_VARIABLE
+#define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "test-tool.h"
 #include "strvec.h"
diff --git a/t/unit-tests/lib-reftable.c b/t/unit-tests/lib-reftable.c
index 2ddf480588d36ae0bd2e45870dc9739acedd93ae..7bc742e4f7a420eb35c0b15e03a5136751a1948f 100644
--- a/t/unit-tests/lib-reftable.c
+++ b/t/unit-tests/lib-reftable.c
@@ -1,3 +1,5 @@
+#define DISABLE_SIGN_COMPARE_WARNINGS
+
 #include "lib-reftable.h"
 #include "test-lib.h"
 #include "reftable/constants.h"
diff --git a/t/unit-tests/t-example-decorate.c b/t/unit-tests/t-example-decorate.c
index 8bf0709c41f6814ba6b12184c9e316cf972a5415..61da8e1c8bedb6313369bc5eefd63b5aa54f78d6 100644
--- a/t/unit-tests/t-example-decorate.c
+++ b/t/unit-tests/t-example-decorate.c
@@ -1,4 +1,5 @@
 #define USE_THE_REPOSITORY_VARIABLE
+#define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "test-lib.h"
 #include "object.h"
diff --git a/t/unit-tests/t-prio-queue.c b/t/unit-tests/t-prio-queue.c
index fe6ae37935b8a8de9f4446dda7598b0c2b8bfc76..a3d1aabab5ce08aedbce2ff815d0676d8784bad6 100644
--- a/t/unit-tests/t-prio-queue.c
+++ b/t/unit-tests/t-prio-queue.c
@@ -1,3 +1,5 @@
+#define DISABLE_SIGN_COMPARE_WARNINGS
+
 #include "test-lib.h"
 #include "prio-queue.h"
 
diff --git a/t/unit-tests/t-reftable-readwrite.c b/t/unit-tests/t-reftable-readwrite.c
index d279b86df0aeda11b3fb4d2c15803760ae394941..d38092ff8317c93fe8f9d61ed5d31e25895dd69e 100644
--- a/t/unit-tests/t-reftable-readwrite.c
+++ b/t/unit-tests/t-reftable-readwrite.c
@@ -6,6 +6,8 @@ license that can be found in the LICENSE file or at
 https://developers.google.com/open-source/licenses/bsd
 */
 
+#define DISABLE_SIGN_COMPARE_WARNINGS
+
 #include "test-lib.h"
 #include "lib-reftable.h"
 #include "reftable/basics.h"
diff --git a/t/unit-tests/t-reftable-stack.c b/t/unit-tests/t-reftable-stack.c
index 72f6747064f62106e87c9a90e5fe315139d46e60..4377c0af1b8fbd174bd6d25c693954244c31f802 100644
--- a/t/unit-tests/t-reftable-stack.c
+++ b/t/unit-tests/t-reftable-stack.c
@@ -6,6 +6,8 @@ license that can be found in the LICENSE file or at
 https://developers.google.com/open-source/licenses/bsd
 */
 
+#define DISABLE_SIGN_COMPARE_WARNINGS
+
 #include "test-lib.h"
 #include "lib-reftable.h"
 #include "reftable/merged.h"
diff --git a/t/unit-tests/t-trailer.c b/t/unit-tests/t-trailer.c
index e1c6ad7461ed2ebe1e0671f27342d415b96ec19b..184593e73d6e238e188ec85de744d22fe9ea9b66 100644
--- a/t/unit-tests/t-trailer.c
+++ b/t/unit-tests/t-trailer.c
@@ -1,3 +1,5 @@
+#define DISABLE_SIGN_COMPARE_WARNINGS
+
 #include "test-lib.h"
 #include "trailer.h"
 
diff --git a/t/unit-tests/test-lib.c b/t/unit-tests/test-lib.c
index fa1f95965c709aeefb98aa787ad1b7023d557e36..87e1f5c201f253a3b35dda823cdc0dadbf7e723b 100644
--- a/t/unit-tests/test-lib.c
+++ b/t/unit-tests/test-lib.c
@@ -1,3 +1,5 @@
+#define DISABLE_SIGN_COMPARE_WARNINGS
+
 #include "test-lib.h"
 
 enum result {
diff --git a/tag.c b/tag.c
index d24170e34062f05f06f3f791f3e2a3a296dc5022..332fc338e9a3a60d593c12edb599e565bdc66422 100644
--- a/tag.c
+++ b/tag.c
@@ -1,4 +1,5 @@
 #define USE_THE_REPOSITORY_VARIABLE
+#define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "git-compat-util.h"
 #include "environment.h"
diff --git a/tmp-objdir.c b/tmp-objdir.c
index 9da0071cba837586241994367d0d3392dbb1bfab..b9084d0ac3cf8b4de879951a6f2480f26635172b 100644
--- a/tmp-objdir.c
+++ b/tmp-objdir.c
@@ -1,4 +1,5 @@
 #define USE_THE_REPOSITORY_VARIABLE
+#define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "git-compat-util.h"
 #include "tmp-objdir.h"
diff --git a/trace.c b/trace.c
index d8c43773ae8b96bff61db1835cd1f19694be56b3..2cfd25942ee725b022e8dea26096f01f2164a407 100644
--- a/trace.c
+++ b/trace.c
@@ -22,6 +22,7 @@
  */
 
 #define USE_THE_REPOSITORY_VARIABLE
+#define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "git-compat-util.h"
 #include "abspath.h"
diff --git a/trace2.c b/trace2.c
index f894532d05331c48607fc3434b8d31937f951a4b..82d16e2783d98690a72934f873f145fc890d5f1a 100644
--- a/trace2.c
+++ b/trace2.c
@@ -1,3 +1,5 @@
+#define DISABLE_SIGN_COMPARE_WARNINGS
+
 #include "git-compat-util.h"
 #include "config.h"
 #include "repository.h"
diff --git a/trace2/tr2_sysenv.c b/trace2/tr2_sysenv.c
index 048cdd543830418bfe53957b278ab654ecfdcb66..01379c5cad8438c8d5ef38c3cfe9e27c6ff0d478 100644
--- a/trace2/tr2_sysenv.c
+++ b/trace2/tr2_sysenv.c
@@ -1,3 +1,5 @@
+#define DISABLE_SIGN_COMPARE_WARNINGS
+
 #include "git-compat-util.h"
 #include "config.h"
 #include "dir.h"
diff --git a/trace2/tr2_tgt_event.c b/trace2/tr2_tgt_event.c
index 45b0850a5ec5c8d1e35df940da003fa9bbddd2ba..69ee40449fa4a79b70495627c856a8b5a422f09b 100644
--- a/trace2/tr2_tgt_event.c
+++ b/trace2/tr2_tgt_event.c
@@ -1,3 +1,5 @@
+#define DISABLE_SIGN_COMPARE_WARNINGS
+
 #include "git-compat-util.h"
 #include "config.h"
 #include "json-writer.h"
diff --git a/trace2/tr2_tgt_perf.c b/trace2/tr2_tgt_perf.c
index a6f9a8a193e058fc164a8e9bd8dc823b7a317a85..298ae27f9d7f24bdca70e064d215de7f57aad625 100644
--- a/trace2/tr2_tgt_perf.c
+++ b/trace2/tr2_tgt_perf.c
@@ -1,3 +1,5 @@
+#define DISABLE_SIGN_COMPARE_WARNINGS
+
 #include "git-compat-util.h"
 #include "config.h"
 #include "repository.h"
diff --git a/trailer.c b/trailer.c
index 46f0e4610bf5b949dedbe0132a8f3a3f0fffc644..b7e406328534e8904c7fe7980e22d7777e6c4002 100644
--- a/trailer.c
+++ b/trailer.c
@@ -1,4 +1,5 @@
 #define USE_THE_REPOSITORY_VARIABLE
+#define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "git-compat-util.h"
 #include "config.h"
diff --git a/transport-helper.c b/transport-helper.c
index bc27653cdee211bd68cfc624b0fefd66fa1917fc..387c67d5bd198e01250addbcfc12b59868d2007e 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -1,4 +1,5 @@
 #define USE_THE_REPOSITORY_VARIABLE
+#define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "git-compat-util.h"
 #include "transport.h"
diff --git a/transport.c b/transport.c
index 47fda6a7732f4b8cdcb6e750f36b896a988ffd0b..abf0ff57066edb0f88d5ab06306e4d58c98017dd 100644
--- a/transport.c
+++ b/transport.c
@@ -1,4 +1,5 @@
 #define USE_THE_REPOSITORY_VARIABLE
+#define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "git-compat-util.h"
 #include "advice.h"
diff --git a/tree-diff.c b/tree-diff.c
index 5eab8af631b78955589d1bb73031ecc854303c51..d9237ffd9bf6fe2579277ed97f1628f3b863ccad 100644
--- a/tree-diff.c
+++ b/tree-diff.c
@@ -3,6 +3,7 @@
  */
 
 #define USE_THE_REPOSITORY_VARIABLE
+#define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "git-compat-util.h"
 #include "diff.h"
diff --git a/unix-socket.c b/unix-socket.c
index 79800d80636fc57fa8cc2696e33013c1c29e86b3..483c9c448c3964ca3dc46da7060671fc778211c4 100644
--- a/unix-socket.c
+++ b/unix-socket.c
@@ -1,3 +1,5 @@
+#define DISABLE_SIGN_COMPARE_WARNINGS
+
 #include "git-compat-util.h"
 #include "strbuf.h"
 #include "unix-socket.h"
diff --git a/unpack-trees.c b/unpack-trees.c
index e10a9d12091ea286757881be19fea9dff21f0e32..b3be5d542f5fc5a02b8838101f7334ff44b2c626 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -1,4 +1,5 @@
 #define USE_THE_REPOSITORY_VARIABLE
+#define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "git-compat-util.h"
 #include "advice.h"
diff --git a/upload-pack.c b/upload-pack.c
index 43006c0614cabab1d47e29540d88d7b89b8f7d14..728b2477fcc71fbf9b6f6aaa53ef3581a6bf7eaf 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -1,4 +1,5 @@
 #define USE_THE_REPOSITORY_VARIABLE
+#define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "git-compat-util.h"
 #include "config.h"
diff --git a/urlmatch.c b/urlmatch.c
index 1d0254abacbc3f393062351bc55ccd9bef32051a..eea8300489d79bdb18170d447027020d158fc108 100644
--- a/urlmatch.c
+++ b/urlmatch.c
@@ -1,3 +1,5 @@
+#define DISABLE_SIGN_COMPARE_WARNINGS
+
 #include "git-compat-util.h"
 #include "gettext.h"
 #include "hex-ll.h"
diff --git a/usage.c b/usage.c
index 7a2f7805f57737fa3d9e653ff6c9345719dc79b8..00696d447bade5474c279a3ba4f58ecb48d9fb35 100644
--- a/usage.c
+++ b/usage.c
@@ -3,6 +3,9 @@
  *
  * Copyright (C) Linus Torvalds, 2005
  */
+
+#define DISABLE_SIGN_COMPARE_WARNINGS
+
 #include "git-compat-util.h"
 #include "gettext.h"
 #include "trace2.h"
diff --git a/userdiff.c b/userdiff.c
index d43d8360d17227852f33e41fa41efdc1cfc4c74a..340c4eb4f77ab17798d25383fa4b6135c661b67a 100644
--- a/userdiff.c
+++ b/userdiff.c
@@ -1,4 +1,5 @@
 #define USE_THE_REPOSITORY_VARIABLE
+#define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "git-compat-util.h"
 #include "config.h"
diff --git a/utf8.c b/utf8.c
index 6bfaefa28ebbbfd145b30b58fe0e937ea921ec91..35a02519392e650a065c72646aa2340b989448cf 100644
--- a/utf8.c
+++ b/utf8.c
@@ -1,3 +1,5 @@
+#define DISABLE_SIGN_COMPARE_WARNINGS
+
 #include "git-compat-util.h"
 #include "strbuf.h"
 #include "utf8.h"
diff --git a/version.c b/version.c
index 41b718c29e1b9fc2981d7d14a3d25e69c31a3030..d5aadab709e06dcd55765f36ba8e949cfa1541f1 100644
--- a/version.c
+++ b/version.c
@@ -1,3 +1,4 @@
+#define DISABLE_SIGN_COMPARE_WARNINGS
 #include "git-compat-util.h"
 #include "version.h"
 #include "strbuf.h"
diff --git a/versioncmp.c b/versioncmp.c
index e3b2a6e330a3e830d4ef1a953a209716313646f5..71cef7e85862270b537df3dface350a6462e94ed 100644
--- a/versioncmp.c
+++ b/versioncmp.c
@@ -1,4 +1,5 @@
 #define USE_THE_REPOSITORY_VARIABLE
+#define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "git-compat-util.h"
 #include "config.h"
diff --git a/worktree.c b/worktree.c
index 77ff484d3ec48c547ee4e3d958dfa28a52c1eaa7..86b36f5190253d1fb373208061ce109e69d86a10 100644
--- a/worktree.c
+++ b/worktree.c
@@ -1,4 +1,5 @@
 #define USE_THE_REPOSITORY_VARIABLE
+#define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "git-compat-util.h"
 #include "abspath.h"
diff --git a/wrapper.c b/wrapper.c
index f87d90bf5794a55418d657160f3c86735c1e4bd7..fa79fd6ec9e144509f34e007bb2ffa458d69e695 100644
--- a/wrapper.c
+++ b/wrapper.c
@@ -1,6 +1,9 @@
 /*
  * Various trivial helper wrappers around standard functions
  */
+
+#define DISABLE_SIGN_COMPARE_WARNINGS
+
 #include "git-compat-util.h"
 #include "abspath.h"
 #include "parse.h"
diff --git a/ws.c b/ws.c
index 9456e2fdbe3766b89497cf740b6280770daf5fd8..70acee3337f2418ccf3f5d124815e4d24d56e073 100644
--- a/ws.c
+++ b/ws.c
@@ -3,6 +3,9 @@
  *
  * Copyright (c) 2007 Junio C Hamano
  */
+
+#define DISABLE_SIGN_COMPARE_WARNINGS
+
 #include "git-compat-util.h"
 #include "attr.h"
 #include "strbuf.h"
diff --git a/wt-status.c b/wt-status.c
index 6a8c05d1cff165dda8f42b843bf78490ac624d4e..3ee918176422c7c8c045fadae67c39a7d57e987e 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -1,4 +1,5 @@
 #define USE_THE_REPOSITORY_VARIABLE
+#define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "git-compat-util.h"
 #include "advice.h"
diff --git a/xdiff-interface.c b/xdiff-interface.c
index d5dc88661e72078df3ce9e39a3ea7e15fd46092e..3bd61f26e9043e1dd7b2eea98dbe0ac6c5280ab4 100644
--- a/xdiff-interface.c
+++ b/xdiff-interface.c
@@ -1,4 +1,5 @@
 #define USE_THE_REPOSITORY_VARIABLE
+#define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "git-compat-util.h"
 #include "gettext.h"
diff --git a/xdiff/xdiffi.c b/xdiff/xdiffi.c
index 344c2dfc3eb443a721cc45b6ba3be56e9f186c97..4685ba613778149dba84d080869d1b6d7fc2654c 100644
--- a/xdiff/xdiffi.c
+++ b/xdiff/xdiffi.c
@@ -19,6 +19,7 @@
  *  Davide Libenzi <davidel@xmailserver.org>
  *
  */
+#define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "xinclude.h"
 
diff --git a/xdiff/xinclude.h b/xdiff/xinclude.h
index a4285ac0eb2840fb3d128b81ab4e19ca3fa673ae..7e56542526a9fe9669a435929b877382b2b4e835 100644
--- a/xdiff/xinclude.h
+++ b/xdiff/xinclude.h
@@ -23,6 +23,8 @@
 #if !defined(XINCLUDE_H)
 #define XINCLUDE_H
 
+#define DISABLE_SIGN_COMPARE_WARNINGS
+
 #include "git-compat-util.h"
 #include "xmacros.h"
 #include "xdiff.h"

-- 
2.47.0.366.g5daf58cba8.dirty

