Received: from wfout7-smtp.messagingengine.com (wfout7-smtp.messagingengine.com [64.147.123.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A3BA136E39
	for <git@vger.kernel.org>; Thu, 13 Jun 2024 06:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718259253; cv=none; b=gZwI0uDpFODr9QbbTv7qUSYHKR7sXg2f0k8p6FlYTSUNKeh/BtS7/OlpWdCbf1h2/35hiHyXBcRpDlB8k4OtBnQN99RA2p4fbIAGbG7CDwn9RJTN3WPJm1lCjRG4cytIwTUoQh8CXiFDWVW9dXMdIsWsE+N+NuCKimyFWaAEDgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718259253; c=relaxed/simple;
	bh=YhXvWR9o5FE5PrVeQWspPv5iJHMZKZ4U95p+22ud+JA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o2X/3oU3MMhAQ6B9DYTyiZ64ezf0F3LbN5Q8vb7B5kLkmsXJ7USiFYL1kCNqNsTtus6w9zuCoSp3fO1pt3CFe6ozhBT2DL7H/ygHzPQjqVbysv8q5Dizz7nUcWfNd/O/3Lr5xXSM1r6RJusBTGhbeqp/Rfj/TkLhLmTxZoMeQMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=MI3nh2Mw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ds/XCaUt; arc=none smtp.client-ip=64.147.123.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="MI3nh2Mw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ds/XCaUt"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfout.west.internal (Postfix) with ESMTP id 758041C000D7;
	Thu, 13 Jun 2024 02:14:09 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Thu, 13 Jun 2024 02:14:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1718259249; x=1718345649; bh=vfhdJpPo23
	sbNp5llcKotFCpIqlXYxi6Rp5VkcSxFdk=; b=MI3nh2Mwywdcj/XiEc09Of+4qq
	rufhyxwYAvZ1lCV7srvcjVzfjbV5E1QWhkGmeyR0qPnsxBCnmlrSmFhY5ZMskjVw
	en2tSMiy5SmS16IU4yhHWB4xqXvkN/lr5MQCdUhFeQhrJ6sB7nm/T6vZPeRQDSxP
	UYBajwdUJwxr4lEFOIwqZoGi9Z3k1WKhgTA09uW6RzGopkitIDHFj4XuwvafzQ6Z
	IhjZ6rAoB1Bl6vYOXEpwaq4Roc1uGuVOJFhSL6RehSkQ/2Si/oddPRyrDBulSJzg
	bczLnL5N5/chjyrG7RyjDALLQo+wnRXFFB8+iZG127Z+DwM1ou0kXjECWCBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1718259249; x=1718345649; bh=vfhdJpPo23sbNp5llcKotFCpIqlX
	Yxi6Rp5VkcSxFdk=; b=ds/XCaUtoHOSwdoyE01DmzJrFBXSqNt7PpAsyxscr/8b
	H/HWssHeHy8o2hFNAIK8zkvMGHG6mYT+V/n+2o27M2ZE3kwDhjlmgXcDz19maJCJ
	Txsk79bn+Ov612mvplvnunuyei/qqa8Vpd7ybPM6cinYGIOklUuQLKc5lZ7Q6d+I
	Ct1IT/kCNlum9URFnoK47o4AQNigvtBJRhTCOa50XUUjbweJHFRQa2TSBIF55VTK
	K1IHrwU8otc68CKn9U80Dn4PWcpILbdGKhX3Bv8A1A3OEJW4D+Sxnqa8kSlylL5o
	AIGe1kt5Ow/SaRFbLJUkyMBdzgI/3Qopmx/55uyxiQ==
X-ME-Sender: <xms:MI5qZk_2FyBEDBy7W4pO2B1qmXzSClaIYSReQo1RUi31ORl6Os1CbQ>
    <xme:MI5qZsv1SAy8-YpHZF-KSjqQjx5Qu_4DRIhws5G-puJlhAOt6T-m1b_-RK_MxJbcM
    0h9ULqiLs49yotEvA>
X-ME-Received: <xmr:MI5qZqBhaWCvNdDQGq_ctj7kzKgBjlVCCBPTlWjFUkBUzi2CbbqoBXIl3btc1qlz7MFHsJXOPZOhzSaUHUWC58A5xr2VP5zOVbg8Ke3zk1ioTNIyJyY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfeduiedgjeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:MI5qZke9977vY7qM6bsPiqgfTqyFyfKby6IlfMZ6A2HI7lA8s472ow>
    <xmx:MI5qZpMlQS8GGCmSHuMyNGGmQAEn1HW0_6jpCmVnM7T80UNRVVXeVA>
    <xmx:MI5qZumt6USzT2JePdlD6IpGwf28E0TtauzFGvaO35am0iXBTdS3DQ>
    <xmx:MI5qZrvzJx1Cdg_rQo4_e8K6xeIsPgUPuFaJDWflMBMoiYtdC-6v1w>
    <xmx:MY5qZqqHeMTkMtCscRaW_blDWAt606m233QO3CTbGUdX4N93LC7DNT_8>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 13 Jun 2024 02:14:07 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id be807830 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 13 Jun 2024 06:13:55 +0000 (UTC)
Date: Thu, 13 Jun 2024 08:14:05 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Ghanshyam Thakkar <shyamthakkar001@gmail.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH v2 09/20] global: introduce `USE_THE_REPOSITORY_VARIABLE`
 macro
Message-ID: <cb3694ad0eabeaf05f6fe184648740ab614cbd97.1718259125.git.ps@pks.im>
References: <cover.1718106284.git.ps@pks.im>
 <cover.1718259125.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="rIrAXCpouaKX8OIm"
Content-Disposition: inline
In-Reply-To: <cover.1718259125.git.ps@pks.im>


--rIrAXCpouaKX8OIm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Use of the `the_repository` variable is deprecated nowadays, and we
slowly but steadily convert the codebase to not use it anymore. Instead,
callers should be passing down the repository to work on via parameters.

It is hard though to prove that a given code unit does not use this
variable anymore. The most trivial case, merely demonstrating that there
is no direct use of `the_repository`, is already a bit of a pain during
code reviews as the reviewer needs to manually verify claims made by the
patch author. The bigger problem though is that we have many interfaces
that implicitly rely on `the_repository`.

Introduce a new `USE_THE_REPOSITORY_VARIABLE` macro that allows code
units to opt into usage of `the_repository`. The intent of this macro is
to demonstrate that a certain code unit does not use this variable
anymore, and to keep it from new dependencies on it in future changes,
be it explicit or implicit

For now, the macro only guards `the_repository` itself as well as
`the_hash_algo`. There are many more known interfaces where we have an
implicit dependency on `the_repository`, but those are not guarded at
the current point in time. Over time though, we should start to add
guards as required (or even better, just remove them).

Define the macro as required in our code units. As expected, most of our
code still relies on the global variable. Nearly all of our builtins
rely on the variable as there is no way yet to pass `the_repository` to
their entry point. For now, declare the macro in "biultin.h" to keep the
required changes at least a little bit more contained.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 add-interactive.c                            | 2 ++
 add-patch.c                                  | 2 ++
 apply.c                                      | 2 ++
 archive-tar.c                                | 3 +++
 archive-zip.c                                | 3 +++
 archive.c                                    | 2 ++
 attr.c                                       | 2 ++
 bisect.c                                     | 2 ++
 blame.c                                      | 2 ++
 branch.c                                     | 2 ++
 builtin.h                                    | 8 ++++++++
 builtin/blame.c                              | 2 +-
 builtin/log.c                                | 2 +-
 bulk-checkin.c                               | 3 +++
 bundle-uri.c                                 | 2 ++
 bundle.c                                     | 2 ++
 cache-tree.c                                 | 2 ++
 checkout.c                                   | 2 ++
 chunk-format.c                               | 2 ++
 combine-diff.c                               | 2 ++
 commit-graph.c                               | 2 ++
 commit-reach.c                               | 2 ++
 commit.c                                     | 2 ++
 common-main.c                                | 2 ++
 compat/win32/trace2_win32_process_info.c     | 2 ++
 config.c                                     | 3 +++
 connected.c                                  | 2 ++
 convert.c                                    | 2 ++
 csum-file.c                                  | 3 +++
 delta-islands.c                              | 2 ++
 diagnose.c                                   | 2 ++
 diff-lib.c                                   | 3 +++
 diff.c                                       | 3 +++
 diffcore-break.c                             | 3 +++
 diffcore-rename.c                            | 3 +++
 dir.c                                        | 3 +++
 entry.c                                      | 2 ++
 environment.c                                | 3 +++
 fetch-pack.c                                 | 2 ++
 fmt-merge-msg.c                              | 2 ++
 fsck.c                                       | 2 ++
 fsmonitor-ipc.c                              | 2 ++
 git.c                                        | 2 ++
 hash-lookup.c                                | 2 ++
 hash.h                                       | 4 +++-
 help.c                                       | 2 ++
 hex.c                                        | 2 ++
 http-backend.c                               | 2 ++
 http-push.c                                  | 2 ++
 http-walker.c                                | 2 ++
 http.c                                       | 2 ++
 list-objects-filter-options.c                | 2 ++
 list-objects-filter.c                        | 2 ++
 list-objects.c                               | 2 ++
 log-tree.c                                   | 2 ++
 loose.c                                      | 2 ++
 ls-refs.c                                    | 2 ++
 mailmap.c                                    | 2 ++
 match-trees.c                                | 2 ++
 merge-blobs.c                                | 2 ++
 merge-ort.c                                  | 2 ++
 merge-recursive.c                            | 3 +++
 merge.c                                      | 2 ++
 midx-write.c                                 | 2 ++
 midx.c                                       | 2 ++
 negotiator/default.c                         | 2 ++
 negotiator/skipping.c                        | 2 ++
 notes-cache.c                                | 2 ++
 notes-merge.c                                | 2 ++
 notes-utils.c                                | 2 ++
 notes.c                                      | 2 ++
 object-file-convert.c                        | 2 ++
 object-file.c                                | 3 +++
 object-name.c                                | 2 ++
 object.c                                     | 2 ++
 oid-array.c                                  | 2 ++
 oss-fuzz/fuzz-commit-graph.c                 | 2 ++
 pack-bitmap-write.c                          | 2 ++
 pack-bitmap.c                                | 2 ++
 pack-check.c                                 | 2 ++
 pack-revindex.c                              | 2 ++
 pack-write.c                                 | 2 ++
 packfile.c                                   | 2 ++
 parse-options-cb.c                           | 2 ++
 path.c                                       | 3 +++
 pathspec.c                                   | 2 ++
 pretty.c                                     | 2 ++
 progress.c                                   | 2 ++
 promisor-remote.c                            | 2 ++
 range-diff.c                                 | 2 ++
 reachable.c                                  | 2 ++
 read-cache.c                                 | 3 +++
 rebase-interactive.c                         | 2 ++
 ref-filter.c                                 | 2 ++
 reflog-walk.c                                | 2 ++
 reflog.c                                     | 2 ++
 refs.c                                       | 2 ++
 refs/files-backend.c                         | 2 ++
 refs/packed-backend.c                        | 2 ++
 refs/reftable-backend.c                      | 2 ++
 refspec.c                                    | 2 ++
 remote-curl.c                                | 2 ++
 remote.c                                     | 2 ++
 repository.h                                 | 2 ++
 rerere.c                                     | 2 ++
 reset.c                                      | 2 ++
 resolve-undo.c                               | 2 ++
 revision.c                                   | 2 ++
 run-command.c                                | 2 ++
 scalar.c                                     | 2 ++
 send-pack.c                                  | 2 ++
 sequencer.c                                  | 2 ++
 serve.c                                      | 2 ++
 server-info.c                                | 2 ++
 setup.c                                      | 2 ++
 shallow.c                                    | 2 ++
 split-index.c                                | 2 ++
 streaming.c                                  | 3 +++
 submodule-config.c                           | 2 ++
 submodule.c                                  | 2 ++
 t/helper/test-bitmap.c                       | 2 ++
 t/helper/test-bloom.c                        | 2 ++
 t/helper/test-cache-tree.c                   | 2 ++
 t/helper/test-dump-cache-tree.c              | 2 ++
 t/helper/test-dump-fsmonitor.c               | 2 ++
 t/helper/test-dump-split-index.c             | 2 ++
 t/helper/test-dump-untracked-cache.c         | 2 ++
 t/helper/test-find-pack.c                    | 2 ++
 t/helper/test-fsmonitor-client.c             | 2 ++
 t/helper/test-lazy-init-name-hash.c          | 2 ++
 t/helper/test-match-trees.c                  | 2 ++
 t/helper/test-oidmap.c                       | 2 ++
 t/helper/test-pack-mtimes.c                  | 2 ++
 t/helper/test-reach.c                        | 2 ++
 t/helper/test-read-cache.c                   | 2 ++
 t/helper/test-read-graph.c                   | 2 ++
 t/helper/test-read-midx.c                    | 2 ++
 t/helper/test-ref-store.c                    | 2 ++
 t/helper/test-repository.c                   | 2 ++
 t/helper/test-revision-walking.c             | 2 ++
 t/helper/test-scrap-cache-tree.c             | 2 ++
 t/helper/test-submodule-config.c             | 2 ++
 t/helper/test-submodule-nested-repo-config.c | 2 ++
 t/helper/test-submodule.c                    | 2 ++
 t/helper/test-trace2.c                       | 2 ++
 t/helper/test-write-cache.c                  | 2 ++
 t/unit-tests/t-example-decorate.c            | 2 ++
 tag.c                                        | 2 ++
 tmp-objdir.c                                 | 2 ++
 transport-helper.c                           | 2 ++
 transport.c                                  | 2 ++
 tree-walk.c                                  | 2 ++
 tree.c                                       | 2 ++
 unpack-trees.c                               | 2 ++
 upload-pack.c                                | 2 ++
 walker.c                                     | 2 ++
 worktree.c                                   | 2 ++
 wt-status.c                                  | 2 ++
 xdiff-interface.c                            | 2 ++
 159 files changed, 339 insertions(+), 3 deletions(-)

diff --git a/add-interactive.c b/add-interactive.c
index a0961096cd..49042b3026 100644
--- a/add-interactive.c
+++ b/add-interactive.c
@@ -1,3 +1,5 @@
+#define USE_THE_REPOSITORY_VARIABLE
+
 #include "git-compat-util.h"
 #include "add-interactive.h"
 #include "color.h"
diff --git a/add-patch.c b/add-patch.c
index 86181770f2..99e037c1e2 100644
--- a/add-patch.c
+++ b/add-patch.c
@@ -1,3 +1,5 @@
+#define USE_THE_REPOSITORY_VARIABLE
+
 #include "git-compat-util.h"
 #include "add-interactive.h"
 #include "advice.h"
diff --git a/apply.c b/apply.c
index 528939abb6..ff939f908a 100644
--- a/apply.c
+++ b/apply.c
@@ -7,6 +7,8 @@
  *
  */
=20
+#define USE_THE_REPOSITORY_VARIABLE
+
 #include "git-compat-util.h"
 #include "abspath.h"
 #include "base85.h"
diff --git a/archive-tar.c b/archive-tar.c
index 8ae30125f8..e7b3489e1e 100644
--- a/archive-tar.c
+++ b/archive-tar.c
@@ -1,6 +1,9 @@
 /*
  * Copyright (c) 2005, 2006 Rene Scharfe
  */
+
+#define USE_THE_REPOSITORY_VARIABLE
+
 #include "git-compat-util.h"
 #include "config.h"
 #include "gettext.h"
diff --git a/archive-zip.c b/archive-zip.c
index fd1d3f816d..9f32730181 100644
--- a/archive-zip.c
+++ b/archive-zip.c
@@ -1,6 +1,9 @@
 /*
  * Copyright (c) 2006 Rene Scharfe
  */
+
+#define USE_THE_REPOSITORY_VARIABLE
+
 #include "git-compat-util.h"
 #include "config.h"
 #include "archive.h"
diff --git a/archive.c b/archive.c
index 5287fcdd8e..7bd60d0632 100644
--- a/archive.c
+++ b/archive.c
@@ -1,3 +1,5 @@
+#define USE_THE_REPOSITORY_VARIABLE
+
 #include "git-compat-util.h"
 #include "abspath.h"
 #include "config.h"
diff --git a/attr.c b/attr.c
index 300f994ba6..b5ed83c90e 100644
--- a/attr.c
+++ b/attr.c
@@ -6,6 +6,8 @@
  * an insanely large number of attributes.
  */
=20
+#define USE_THE_REPOSITORY_VARIABLE
+
 #include "git-compat-util.h"
 #include "config.h"
 #include "environment.h"
diff --git a/bisect.c b/bisect.c
index 4ea703bec1..135f94ba09 100644
--- a/bisect.c
+++ b/bisect.c
@@ -1,3 +1,5 @@
+#define USE_THE_REPOSITORY_VARIABLE
+
 #include "git-compat-util.h"
 #include "config.h"
 #include "commit.h"
diff --git a/blame.c b/blame.c
index a80f5e2e61..d403c46a35 100644
--- a/blame.c
+++ b/blame.c
@@ -1,3 +1,5 @@
+#define USE_THE_REPOSITORY_VARIABLE
+
 #include "git-compat-util.h"
 #include "refs.h"
 #include "object-store-ll.h"
diff --git a/branch.c b/branch.c
index df5d24fec6..c887ea2151 100644
--- a/branch.c
+++ b/branch.c
@@ -1,3 +1,5 @@
+#define USE_THE_REPOSITORY_VARIABLE
+
 #include "git-compat-util.h"
 #include "advice.h"
 #include "config.h"
diff --git a/builtin.h b/builtin.h
index 7eda9b2486..14fa017160 100644
--- a/builtin.h
+++ b/builtin.h
@@ -1,6 +1,14 @@
 #ifndef BUILTIN_H
 #define BUILTIN_H
=20
+/*
+ * TODO: Almost all of our builtins access `the_repository` by necessity
+ * because they do not get passed a pointer to it. We should adapt the fun=
ction
+ * signature of those main functions to accept a `struct repository *` and=
 then
+ * remove the macro here.
+ */
+#define USE_THE_REPOSITORY_VARIABLE
+
 #include "git-compat-util.h"
=20
 /*
diff --git a/builtin/blame.c b/builtin/blame.c
index e09ff0155a..de89fff3f8 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -5,7 +5,7 @@
  * See COPYING for licensing conditions
  */
=20
-#include "git-compat-util.h"
+#include "builtin.h"
 #include "config.h"
 #include "color.h"
 #include "builtin.h"
diff --git a/builtin/log.c b/builtin/log.c
index ccbda8a005..00305bea51 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -4,7 +4,7 @@
  * (C) Copyright 2006 Linus Torvalds
  *		 2006 Junio Hamano
  */
-#include "git-compat-util.h"
+#include "builtin.h"
 #include "abspath.h"
 #include "config.h"
 #include "environment.h"
diff --git a/bulk-checkin.c b/bulk-checkin.c
index eb46b88637..da8673199b 100644
--- a/bulk-checkin.c
+++ b/bulk-checkin.c
@@ -1,6 +1,9 @@
 /*
  * Copyright (c) 2011, Google Inc.
  */
+
+#define USE_THE_REPOSITORY_VARIABLE
+
 #include "git-compat-util.h"
 #include "bulk-checkin.h"
 #include "environment.h"
diff --git a/bundle-uri.c b/bundle-uri.c
index 91b3319a5c..804fbcfbfa 100644
--- a/bundle-uri.c
+++ b/bundle-uri.c
@@ -1,3 +1,5 @@
+#define USE_THE_REPOSITORY_VARIABLE
+
 #include "git-compat-util.h"
 #include "bundle-uri.h"
 #include "bundle.h"
diff --git a/bundle.c b/bundle.c
index 95367c2d0a..82c285b905 100644
--- a/bundle.c
+++ b/bundle.c
@@ -1,3 +1,5 @@
+#define USE_THE_REPOSITORY_VARIABLE
+
 #include "git-compat-util.h"
 #include "lockfile.h"
 #include "bundle.h"
diff --git a/cache-tree.c b/cache-tree.c
index 3290a1b8dd..50610c3f3c 100644
--- a/cache-tree.c
+++ b/cache-tree.c
@@ -1,3 +1,5 @@
+#define USE_THE_REPOSITORY_VARIABLE
+
 #include "git-compat-util.h"
 #include "environment.h"
 #include "hex.h"
diff --git a/checkout.c b/checkout.c
index cfaea4bd10..0b1cf8b40b 100644
--- a/checkout.c
+++ b/checkout.c
@@ -1,3 +1,5 @@
+#define USE_THE_REPOSITORY_VARIABLE
+
 #include "git-compat-util.h"
 #include "object-name.h"
 #include "remote.h"
diff --git a/chunk-format.c b/chunk-format.c
index cdc7f39b70..2dde24e6a3 100644
--- a/chunk-format.c
+++ b/chunk-format.c
@@ -1,3 +1,5 @@
+#define USE_THE_REPOSITORY_VARIABLE
+
 #include "git-compat-util.h"
 #include "chunk-format.h"
 #include "csum-file.h"
diff --git a/combine-diff.c b/combine-diff.c
index 4960d904ac..829a44e416 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -1,3 +1,5 @@
+#define USE_THE_REPOSITORY_VARIABLE
+
 #include "git-compat-util.h"
 #include "object-store-ll.h"
 #include "commit.h"
diff --git a/commit-graph.c b/commit-graph.c
index e4eefd83bf..b6bb9df0d0 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -1,3 +1,5 @@
+#define USE_THE_REPOSITORY_VARIABLE
+
 #include "git-compat-util.h"
 #include "config.h"
 #include "csum-file.h"
diff --git a/commit-reach.c b/commit-reach.c
index 384aee1ab3..dabc2972e4 100644
--- a/commit-reach.c
+++ b/commit-reach.c
@@ -1,3 +1,5 @@
+#define USE_THE_REPOSITORY_VARIABLE
+
 #include "git-compat-util.h"
 #include "commit.h"
 #include "commit-graph.h"
diff --git a/commit.c b/commit.c
index 1d08951007..4956803e11 100644
--- a/commit.c
+++ b/commit.c
@@ -1,3 +1,5 @@
+#define USE_THE_REPOSITORY_VARIABLE
+
 #include "git-compat-util.h"
 #include "tag.h"
 #include "commit.h"
diff --git a/common-main.c b/common-main.c
index b86f40600f..8e68ac9e42 100644
--- a/common-main.c
+++ b/common-main.c
@@ -1,3 +1,5 @@
+#define USE_THE_REPOSITORY_VARIABLE
+
 #include "git-compat-util.h"
 #include "exec-cmd.h"
 #include "gettext.h"
diff --git a/compat/win32/trace2_win32_process_info.c b/compat/win32/trace2=
_win32_process_info.c
index 3ef0936f6f..f147da706a 100644
--- a/compat/win32/trace2_win32_process_info.c
+++ b/compat/win32/trace2_win32_process_info.c
@@ -1,3 +1,5 @@
+#define USE_THE_REPOSITORY_VARIABLE
+
 #include "../../git-compat-util.h"
 #include "../../json-writer.h"
 #include "../../repository.h"
diff --git a/config.c b/config.c
index abce05b774..7951029644 100644
--- a/config.c
+++ b/config.c
@@ -5,6 +5,9 @@
  * Copyright (C) Johannes Schindelin, 2005
  *
  */
+
+#define USE_THE_REPOSITORY_VARIABLE
+
 #include "git-compat-util.h"
 #include "abspath.h"
 #include "advice.h"
diff --git a/connected.c b/connected.c
index 8f89376dbc..87cc4b57a1 100644
--- a/connected.c
+++ b/connected.c
@@ -1,3 +1,5 @@
+#define USE_THE_REPOSITORY_VARIABLE
+
 #include "git-compat-util.h"
 #include "gettext.h"
 #include "hex.h"
diff --git a/convert.c b/convert.c
index f2b9f01354..d8737fe0f2 100644
--- a/convert.c
+++ b/convert.c
@@ -1,3 +1,5 @@
+#define USE_THE_REPOSITORY_VARIABLE
+
 #include "git-compat-util.h"
 #include "advice.h"
 #include "config.h"
diff --git a/csum-file.c b/csum-file.c
index f4be0804b7..8abbf01325 100644
--- a/csum-file.c
+++ b/csum-file.c
@@ -7,6 +7,9 @@
  * files. Useful when you write a file that you want to be
  * able to verify hasn't been messed with afterwards.
  */
+
+#define USE_THE_REPOSITORY_VARIABLE
+
 #include "git-compat-util.h"
 #include "progress.h"
 #include "csum-file.h"
diff --git a/delta-islands.c b/delta-islands.c
index 89d51b72e3..ffe1ca2814 100644
--- a/delta-islands.c
+++ b/delta-islands.c
@@ -1,3 +1,5 @@
+#define USE_THE_REPOSITORY_VARIABLE
+
 #include "git-compat-util.h"
 #include "object.h"
 #include "commit.h"
diff --git a/diagnose.c b/diagnose.c
index 4d096c857f..cc2d535b60 100644
--- a/diagnose.c
+++ b/diagnose.c
@@ -1,3 +1,5 @@
+#define USE_THE_REPOSITORY_VARIABLE
+
 #include "git-compat-util.h"
 #include "diagnose.h"
 #include "compat/disk.h"
diff --git a/diff-lib.c b/diff-lib.c
index 3fb8d79fef..b0d0f711e8 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -1,6 +1,9 @@
 /*
  * Copyright (C) 2005 Junio C Hamano
  */
+
+#define USE_THE_REPOSITORY_VARIABLE
+
 #include "git-compat-util.h"
 #include "commit.h"
 #include "diff.h"
diff --git a/diff.c b/diff.c
index 60d1f7be81..d4579d5f76 100644
--- a/diff.c
+++ b/diff.c
@@ -1,6 +1,9 @@
 /*
  * Copyright (C) 2005 Junio C Hamano
  */
+
+#define USE_THE_REPOSITORY_VARIABLE
+
 #include "git-compat-util.h"
 #include "abspath.h"
 #include "base85.h"
diff --git a/diffcore-break.c b/diffcore-break.c
index 49ba38aa7c..831b66b5c3 100644
--- a/diffcore-break.c
+++ b/diffcore-break.c
@@ -1,6 +1,9 @@
 /*
  * Copyright (C) 2005 Junio C Hamano
  */
+
+#define USE_THE_REPOSITORY_VARIABLE
+
 #include "git-compat-util.h"
 #include "diffcore.h"
 #include "hash.h"
diff --git a/diffcore-rename.c b/diffcore-rename.c
index 5abb958651..ae504007cf 100644
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -2,6 +2,9 @@
  *
  * Copyright (C) 2005 Junio C Hamano
  */
+
+#define USE_THE_REPOSITORY_VARIABLE
+
 #include "git-compat-util.h"
 #include "diff.h"
 #include "diffcore.h"
diff --git a/dir.c b/dir.c
index 5de421c29c..b7a6625ebd 100644
--- a/dir.c
+++ b/dir.c
@@ -5,6 +5,9 @@
  * Copyright (C) Linus Torvalds, 2005-2006
  *		 Junio Hamano, 2005-2006
  */
+
+#define USE_THE_REPOSITORY_VARIABLE
+
 #include "git-compat-util.h"
 #include "abspath.h"
 #include "config.h"
diff --git a/entry.c b/entry.c
index b8c257f6f9..fe1f74d140 100644
--- a/entry.c
+++ b/entry.c
@@ -1,3 +1,5 @@
+#define USE_THE_REPOSITORY_VARIABLE
+
 #include "git-compat-util.h"
 #include "object-store-ll.h"
 #include "dir.h"
diff --git a/environment.c b/environment.c
index 701d515135..5cea2c9f54 100644
--- a/environment.c
+++ b/environment.c
@@ -7,6 +7,9 @@
  * even if you might want to know where the git directory etc
  * are.
  */
+
+#define USE_THE_REPOSITORY_VARIABLE
+
 #include "git-compat-util.h"
 #include "abspath.h"
 #include "branch.h"
diff --git a/fetch-pack.c b/fetch-pack.c
index eba9e420ea..e6e14b3874 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -1,3 +1,5 @@
+#define USE_THE_REPOSITORY_VARIABLE
+
 #include "git-compat-util.h"
 #include "repository.h"
 #include "config.h"
diff --git a/fmt-merge-msg.c b/fmt-merge-msg.c
index 7d144b803a..b8bca89c0c 100644
--- a/fmt-merge-msg.c
+++ b/fmt-merge-msg.c
@@ -1,3 +1,5 @@
+#define USE_THE_REPOSITORY_VARIABLE
+
 #include "git-compat-util.h"
 #include "config.h"
 #include "environment.h"
diff --git a/fsck.c b/fsck.c
index dd0a33028e..432996cbb6 100644
--- a/fsck.c
+++ b/fsck.c
@@ -1,3 +1,5 @@
+#define USE_THE_REPOSITORY_VARIABLE
+
 #include "git-compat-util.h"
 #include "date.h"
 #include "dir.h"
diff --git a/fsmonitor-ipc.c b/fsmonitor-ipc.c
index 45471b5b74..f1b1631111 100644
--- a/fsmonitor-ipc.c
+++ b/fsmonitor-ipc.c
@@ -1,3 +1,5 @@
+#define USE_THE_REPOSITORY_VARIABLE
+
 #include "git-compat-util.h"
 #include "gettext.h"
 #include "simple-ipc.h"
diff --git a/git.c b/git.c
index 683bb69194..e35af9b0e5 100644
--- a/git.c
+++ b/git.c
@@ -1,3 +1,5 @@
+#define USE_THE_REPOSITORY_VARIABLE
+
 #include "builtin.h"
 #include "config.h"
 #include "environment.h"
diff --git a/hash-lookup.c b/hash-lookup.c
index 9aa6b82eb7..5f808caa51 100644
--- a/hash-lookup.c
+++ b/hash-lookup.c
@@ -1,3 +1,5 @@
+#define USE_THE_REPOSITORY_VARIABLE
+
 #include "git-compat-util.h"
 #include "hash.h"
 #include "hash-lookup.h"
diff --git a/hash.h b/hash.h
index 39a0164be3..cb85d26a2f 100644
--- a/hash.h
+++ b/hash.h
@@ -4,6 +4,8 @@
 #include "hash-ll.h"
 #include "repository.h"
=20
-#define the_hash_algo the_repository->hash_algo
+#ifdef USE_THE_REPOSITORY_VARIABLE
+# define the_hash_algo the_repository->hash_algo
+#endif
=20
 #endif
diff --git a/help.c b/help.c
index 1d057aa607..10fdb1a03d 100644
--- a/help.c
+++ b/help.c
@@ -1,3 +1,5 @@
+#define USE_THE_REPOSITORY_VARIABLE
+
 #include "git-compat-util.h"
 #include "config.h"
 #include "builtin.h"
diff --git a/hex.c b/hex.c
index bc9e86a978..5ca78a7744 100644
--- a/hex.c
+++ b/hex.c
@@ -1,3 +1,5 @@
+#define USE_THE_REPOSITORY_VARIABLE
+
 #include "git-compat-util.h"
 #include "hash.h"
 #include "hex.h"
diff --git a/http-backend.c b/http-backend.c
index 5b65287ac9..7c0b3be968 100644
--- a/http-backend.c
+++ b/http-backend.c
@@ -1,3 +1,5 @@
+#define USE_THE_REPOSITORY_VARIABLE
+
 #include "git-compat-util.h"
 #include "config.h"
 #include "environment.h"
diff --git a/http-push.c b/http-push.c
index a97df4a1fb..7315a694aa 100644
--- a/http-push.c
+++ b/http-push.c
@@ -1,3 +1,5 @@
+#define USE_THE_REPOSITORY_VARIABLE
+
 #include "git-compat-util.h"
 #include "environment.h"
 #include "hex.h"
diff --git a/http-walker.c b/http-walker.c
index b7110b6f82..e417a7f51c 100644
--- a/http-walker.c
+++ b/http-walker.c
@@ -1,3 +1,5 @@
+#define USE_THE_REPOSITORY_VARIABLE
+
 #include "git-compat-util.h"
 #include "repository.h"
 #include "hex.h"
diff --git a/http.c b/http.c
index 67cc47d28f..6536816e81 100644
--- a/http.c
+++ b/http.c
@@ -1,3 +1,5 @@
+#define USE_THE_REPOSITORY_VARIABLE
+
 #include "git-compat-util.h"
 #include "git-curl-compat.h"
 #include "hex.h"
diff --git a/list-objects-filter-options.c b/list-objects-filter-options.c
index c5f363ca6f..00611107d2 100644
--- a/list-objects-filter-options.c
+++ b/list-objects-filter-options.c
@@ -1,3 +1,5 @@
+#define USE_THE_REPOSITORY_VARIABLE
+
 #include "git-compat-util.h"
 #include "config.h"
 #include "gettext.h"
diff --git a/list-objects-filter.c b/list-objects-filter.c
index 4346f8da45..49e2fa6f97 100644
--- a/list-objects-filter.c
+++ b/list-objects-filter.c
@@ -1,3 +1,5 @@
+#define USE_THE_REPOSITORY_VARIABLE
+
 #include "git-compat-util.h"
 #include "dir.h"
 #include "gettext.h"
diff --git a/list-objects.c b/list-objects.c
index 11ad8be411..985d008799 100644
--- a/list-objects.c
+++ b/list-objects.c
@@ -1,3 +1,5 @@
+#define USE_THE_REPOSITORY_VARIABLE
+
 #include "git-compat-util.h"
 #include "tag.h"
 #include "commit.h"
diff --git a/log-tree.c b/log-tree.c
index 41416de4e3..223a4d9463 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -1,3 +1,5 @@
+#define USE_THE_REPOSITORY_VARIABLE
+
 #include "git-compat-util.h"
 #include "commit-reach.h"
 #include "config.h"
diff --git a/loose.c b/loose.c
index f6faa6216a..a8bf772172 100644
--- a/loose.c
+++ b/loose.c
@@ -1,3 +1,5 @@
+#define USE_THE_REPOSITORY_VARIABLE
+
 #include "git-compat-util.h"
 #include "hash.h"
 #include "path.h"
diff --git a/ls-refs.c b/ls-refs.c
index 398afe4ce3..2dd925b43d 100644
--- a/ls-refs.c
+++ b/ls-refs.c
@@ -1,3 +1,5 @@
+#define USE_THE_REPOSITORY_VARIABLE
+
 #include "git-compat-util.h"
 #include "environment.h"
 #include "gettext.h"
diff --git a/mailmap.c b/mailmap.c
index b2efe29b3d..534a3eb4f0 100644
--- a/mailmap.c
+++ b/mailmap.c
@@ -1,3 +1,5 @@
+#define USE_THE_REPOSITORY_VARIABLE
+
 #include "git-compat-util.h"
 #include "environment.h"
 #include "string-list.h"
diff --git a/match-trees.c b/match-trees.c
index 50c42e2061..f17c74d483 100644
--- a/match-trees.c
+++ b/match-trees.c
@@ -1,3 +1,5 @@
+#define USE_THE_REPOSITORY_VARIABLE
+
 #include "git-compat-util.h"
 #include "hex.h"
 #include "match-trees.h"
diff --git a/merge-blobs.c b/merge-blobs.c
index 2f659fd014..0ad0390fea 100644
--- a/merge-blobs.c
+++ b/merge-blobs.c
@@ -1,3 +1,5 @@
+#define USE_THE_REPOSITORY_VARIABLE
+
 #include "git-compat-util.h"
 #include "merge-ll.h"
 #include "blob.h"
diff --git a/merge-ort.c b/merge-ort.c
index eaede6cead..691db9050e 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -14,6 +14,8 @@
  * "cale", "peedy", or "ins" instead of "ort"?)
  */
=20
+#define USE_THE_REPOSITORY_VARIABLE
+
 #include "git-compat-util.h"
 #include "merge-ort.h"
=20
diff --git a/merge-recursive.c b/merge-recursive.c
index 8ff29ed09e..46ee364af7 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -3,6 +3,9 @@
  * Fredrik Kuivinen.
  * The thieves were Alex Riesen and Johannes Schindelin, in June/July 2006
  */
+
+#define USE_THE_REPOSITORY_VARIABLE
+
 #include "git-compat-util.h"
 #include "merge-recursive.h"
=20
diff --git a/merge.c b/merge.c
index 752a937fa9..fe3efa4b24 100644
--- a/merge.c
+++ b/merge.c
@@ -1,3 +1,5 @@
+#define USE_THE_REPOSITORY_VARIABLE
+
 #include "git-compat-util.h"
 #include "gettext.h"
 #include "hash.h"
diff --git a/midx-write.c b/midx-write.c
index 55a6b63bac..9a194e8aac 100644
--- a/midx-write.c
+++ b/midx-write.c
@@ -1,3 +1,5 @@
+#define USE_THE_REPOSITORY_VARIABLE
+
 #include "git-compat-util.h"
 #include "abspath.h"
 #include "config.h"
diff --git a/midx.c b/midx.c
index 1e75f1a7eb..3992b05465 100644
--- a/midx.c
+++ b/midx.c
@@ -1,3 +1,5 @@
+#define USE_THE_REPOSITORY_VARIABLE
+
 #include "git-compat-util.h"
 #include "config.h"
 #include "dir.h"
diff --git a/negotiator/default.c b/negotiator/default.c
index 518b3c43b2..e3fa5c3324 100644
--- a/negotiator/default.c
+++ b/negotiator/default.c
@@ -1,3 +1,5 @@
+#define USE_THE_REPOSITORY_VARIABLE
+
 #include "git-compat-util.h"
 #include "default.h"
 #include "../commit.h"
diff --git a/negotiator/skipping.c b/negotiator/skipping.c
index b7e008c2fd..f109928ad0 100644
--- a/negotiator/skipping.c
+++ b/negotiator/skipping.c
@@ -1,3 +1,5 @@
+#define USE_THE_REPOSITORY_VARIABLE
+
 #include "git-compat-util.h"
 #include "skipping.h"
 #include "../commit.h"
diff --git a/notes-cache.c b/notes-cache.c
index 038db01ca0..ecfdf6e43b 100644
--- a/notes-cache.c
+++ b/notes-cache.c
@@ -1,3 +1,5 @@
+#define USE_THE_REPOSITORY_VARIABLE
+
 #include "git-compat-util.h"
 #include "notes-cache.h"
 #include "object-store-ll.h"
diff --git a/notes-merge.c b/notes-merge.c
index 801941c2d1..d95e683414 100644
--- a/notes-merge.c
+++ b/notes-merge.c
@@ -1,3 +1,5 @@
+#define USE_THE_REPOSITORY_VARIABLE
+
 #include "git-compat-util.h"
 #include "advice.h"
 #include "commit.h"
diff --git a/notes-utils.c b/notes-utils.c
index e33aa86c4b..bca71274be 100644
--- a/notes-utils.c
+++ b/notes-utils.c
@@ -1,3 +1,5 @@
+#define USE_THE_REPOSITORY_VARIABLE
+
 #include "git-compat-util.h"
 #include "config.h"
 #include "commit.h"
diff --git a/notes.c b/notes.c
index afe2e2882e..b6a13d0980 100644
--- a/notes.c
+++ b/notes.c
@@ -1,3 +1,5 @@
+#define USE_THE_REPOSITORY_VARIABLE
+
 #include "git-compat-util.h"
 #include "config.h"
 #include "environment.h"
diff --git a/object-file-convert.c b/object-file-convert.c
index f684038f7f..958f61f094 100644
--- a/object-file-convert.c
+++ b/object-file-convert.c
@@ -1,3 +1,5 @@
+#define USE_THE_REPOSITORY_VARIABLE
+
 #include "git-compat-util.h"
 #include "gettext.h"
 #include "strbuf.h"
diff --git a/object-file.c b/object-file.c
index 72318c8dd4..a6555ed68c 100644
--- a/object-file.c
+++ b/object-file.c
@@ -6,6 +6,9 @@
  * This handles basic git object files - packing, unpacking,
  * creation etc.
  */
+
+#define USE_THE_REPOSITORY_VARIABLE
+
 #include "git-compat-util.h"
 #include "abspath.h"
 #include "config.h"
diff --git a/object-name.c b/object-name.c
index 523af6f64f..d7509514bc 100644
--- a/object-name.c
+++ b/object-name.c
@@ -1,3 +1,5 @@
+#define USE_THE_REPOSITORY_VARIABLE
+
 #include "git-compat-util.h"
 #include "object-name.h"
 #include "advice.h"
diff --git a/object.c b/object.c
index 93b5d97fdb..0c0fcb76c0 100644
--- a/object.c
+++ b/object.c
@@ -1,3 +1,5 @@
+#define USE_THE_REPOSITORY_VARIABLE
+
 #include "git-compat-util.h"
 #include "gettext.h"
 #include "hex.h"
diff --git a/oid-array.c b/oid-array.c
index 1f36651754..9cac974395 100644
--- a/oid-array.c
+++ b/oid-array.c
@@ -1,3 +1,5 @@
+#define USE_THE_REPOSITORY_VARIABLE
+
 #include "git-compat-util.h"
 #include "oid-array.h"
 #include "hash-lookup.h"
diff --git a/oss-fuzz/fuzz-commit-graph.c b/oss-fuzz/fuzz-commit-graph.c
index 75e668a057..951c9c082f 100644
--- a/oss-fuzz/fuzz-commit-graph.c
+++ b/oss-fuzz/fuzz-commit-graph.c
@@ -1,3 +1,5 @@
+#define USE_THE_REPOSITORY_VARIABLE
+
 #include "git-compat-util.h"
 #include "commit-graph.h"
 #include "repository.h"
diff --git a/pack-bitmap-write.c b/pack-bitmap-write.c
index 59d2e3a387..37a8ad0fb3 100644
--- a/pack-bitmap-write.c
+++ b/pack-bitmap-write.c
@@ -1,3 +1,5 @@
+#define USE_THE_REPOSITORY_VARIABLE
+
 #include "git-compat-util.h"
 #include "environment.h"
 #include "gettext.h"
diff --git a/pack-bitmap.c b/pack-bitmap.c
index 184d28f05c..7eafdce4ee 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -1,3 +1,5 @@
+#define USE_THE_REPOSITORY_VARIABLE
+
 #include "git-compat-util.h"
 #include "commit.h"
 #include "gettext.h"
diff --git a/pack-check.c b/pack-check.c
index 288f5a3479..d78289da3c 100644
--- a/pack-check.c
+++ b/pack-check.c
@@ -1,3 +1,5 @@
+#define USE_THE_REPOSITORY_VARIABLE
+
 #include "git-compat-util.h"
 #include "environment.h"
 #include "hex.h"
diff --git a/pack-revindex.c b/pack-revindex.c
index fc63aa76a2..de922b47d2 100644
--- a/pack-revindex.c
+++ b/pack-revindex.c
@@ -1,3 +1,5 @@
+#define USE_THE_REPOSITORY_VARIABLE
+
 #include "git-compat-util.h"
 #include "gettext.h"
 #include "pack-revindex.h"
diff --git a/pack-write.c b/pack-write.c
index eef625fa5b..d07f03d0ab 100644
--- a/pack-write.c
+++ b/pack-write.c
@@ -1,3 +1,5 @@
+#define USE_THE_REPOSITORY_VARIABLE
+
 #include "git-compat-util.h"
 #include "environment.h"
 #include "gettext.h"
diff --git a/packfile.c b/packfile.c
index ec7312cd20..813584646f 100644
--- a/packfile.c
+++ b/packfile.c
@@ -1,3 +1,5 @@
+#define USE_THE_REPOSITORY_VARIABLE
+
 #include "git-compat-util.h"
 #include "environment.h"
 #include "gettext.h"
diff --git a/parse-options-cb.c b/parse-options-cb.c
index d99d688d3c..3fb7ce68ca 100644
--- a/parse-options-cb.c
+++ b/parse-options-cb.c
@@ -1,3 +1,5 @@
+#define USE_THE_REPOSITORY_VARIABLE
+
 #include "git-compat-util.h"
 #include "parse-options.h"
 #include "branch.h"
diff --git a/path.c b/path.c
index adfb3d3eb7..19f7684f38 100644
--- a/path.c
+++ b/path.c
@@ -1,6 +1,9 @@
 /*
  * Utilities for paths and pathnames
  */
+
+#define USE_THE_REPOSITORY_VARIABLE
+
 #include "git-compat-util.h"
 #include "abspath.h"
 #include "environment.h"
diff --git a/pathspec.c b/pathspec.c
index 2133b9fe60..fe1f0f41af 100644
--- a/pathspec.c
+++ b/pathspec.c
@@ -1,3 +1,5 @@
+#define USE_THE_REPOSITORY_VARIABLE
+
 #include "git-compat-util.h"
 #include "abspath.h"
 #include "parse.h"
diff --git a/pretty.c b/pretty.c
index 22a81506b7..2c14a88abc 100644
--- a/pretty.c
+++ b/pretty.c
@@ -1,3 +1,5 @@
+#define USE_THE_REPOSITORY_VARIABLE
+
 #include "git-compat-util.h"
 #include "config.h"
 #include "commit.h"
diff --git a/progress.c b/progress.c
index c83cb60bf1..0d44c18edc 100644
--- a/progress.c
+++ b/progress.c
@@ -9,6 +9,8 @@
  */
=20
 #define GIT_TEST_PROGRESS_ONLY
+#define USE_THE_REPOSITORY_VARIABLE
+
 #include "git-compat-util.h"
 #include "pager.h"
 #include "progress.h"
diff --git a/promisor-remote.c b/promisor-remote.c
index 2ca7c2ae48..317e1b127f 100644
--- a/promisor-remote.c
+++ b/promisor-remote.c
@@ -1,3 +1,5 @@
+#define USE_THE_REPOSITORY_VARIABLE
+
 #include "git-compat-util.h"
 #include "gettext.h"
 #include "hex.h"
diff --git a/range-diff.c b/range-diff.c
index c45b6d849c..5f01605550 100644
--- a/range-diff.c
+++ b/range-diff.c
@@ -1,3 +1,5 @@
+#define USE_THE_REPOSITORY_VARIABLE
+
 #include "git-compat-util.h"
 #include "environment.h"
 #include "gettext.h"
diff --git a/reachable.c b/reachable.c
index 1224b30008..46613a6bb6 100644
--- a/reachable.c
+++ b/reachable.c
@@ -1,3 +1,5 @@
+#define USE_THE_REPOSITORY_VARIABLE
+
 #include "git-compat-util.h"
 #include "gettext.h"
 #include "hex.h"
diff --git a/read-cache.c b/read-cache.c
index 085b22faf3..48bf24f87c 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -3,6 +3,9 @@
  *
  * Copyright (C) Linus Torvalds, 2005
  */
+
+#define USE_THE_REPOSITORY_VARIABLE
+
 #include "git-compat-util.h"
 #include "bulk-checkin.h"
 #include "config.h"
diff --git a/rebase-interactive.c b/rebase-interactive.c
index c343e16fcd..e93b385523 100644
--- a/rebase-interactive.c
+++ b/rebase-interactive.c
@@ -1,3 +1,5 @@
+#define USE_THE_REPOSITORY_VARIABLE
+
 #include "git-compat-util.h"
 #include "commit.h"
 #include "editor.h"
diff --git a/ref-filter.c b/ref-filter.c
index f7fb0c7e0e..8c5e673fc0 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -1,3 +1,5 @@
+#define USE_THE_REPOSITORY_VARIABLE
+
 #include "git-compat-util.h"
 #include "environment.h"
 #include "gettext.h"
diff --git a/reflog-walk.c b/reflog-walk.c
index 5f09552c5c..c7070b13b0 100644
--- a/reflog-walk.c
+++ b/reflog-walk.c
@@ -1,3 +1,5 @@
+#define USE_THE_REPOSITORY_VARIABLE
+
 #include "git-compat-util.h"
 #include "commit.h"
 #include "refs.h"
diff --git a/reflog.c b/reflog.c
index 3c80950186..5ca944529b 100644
--- a/reflog.c
+++ b/reflog.c
@@ -1,3 +1,5 @@
+#define USE_THE_REPOSITORY_VARIABLE
+
 #include "git-compat-util.h"
 #include "gettext.h"
 #include "object-store-ll.h"
diff --git a/refs.c b/refs.c
index 6e7caefdcf..727ed6c1d6 100644
--- a/refs.c
+++ b/refs.c
@@ -2,6 +2,8 @@
  * The backend-independent part of the reference module.
  */
=20
+#define USE_THE_REPOSITORY_VARIABLE
+
 #include "git-compat-util.h"
 #include "advice.h"
 #include "config.h"
diff --git a/refs/files-backend.c b/refs/files-backend.c
index b484b5880d..35931bc71e 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1,3 +1,5 @@
+#define USE_THE_REPOSITORY_VARIABLE
+
 #include "../git-compat-util.h"
 #include "../copy.h"
 #include "../environment.h"
diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index 5ab1b21d10..a0666407cd 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -1,3 +1,5 @@
+#define USE_THE_REPOSITORY_VARIABLE
+
 #include "../git-compat-util.h"
 #include "../config.h"
 #include "../dir.h"
diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
index 57df2aba66..6e34eb2188 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -1,3 +1,5 @@
+#define USE_THE_REPOSITORY_VARIABLE
+
 #include "../git-compat-util.h"
 #include "../abspath.h"
 #include "../chdir-notify.h"
diff --git a/refspec.c b/refspec.c
index d60932f4de..c2e3e24351 100644
--- a/refspec.c
+++ b/refspec.c
@@ -1,3 +1,5 @@
+#define USE_THE_REPOSITORY_VARIABLE
+
 #include "git-compat-util.h"
 #include "gettext.h"
 #include "hash.h"
diff --git a/remote-curl.c b/remote-curl.c
index 6008d7e87c..1930f83cc7 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -1,3 +1,5 @@
+#define USE_THE_REPOSITORY_VARIABLE
+
 #include "git-compat-util.h"
 #include "git-curl-compat.h"
 #include "config.h"
diff --git a/remote.c b/remote.c
index 1064171085..5fab7f0970 100644
--- a/remote.c
+++ b/remote.c
@@ -1,3 +1,5 @@
+#define USE_THE_REPOSITORY_VARIABLE
+
 #include "git-compat-util.h"
 #include "abspath.h"
 #include "config.h"
diff --git a/repository.h b/repository.h
index a35cd77c35..29727edec6 100644
--- a/repository.h
+++ b/repository.h
@@ -197,7 +197,9 @@ struct repository {
 	unsigned different_commondir:1;
 };
=20
+#ifdef USE_THE_REPOSITORY_VARIABLE
 extern struct repository *the_repository;
+#endif
=20
 /*
  * Define a custom repository layout. Any field can be NULL, which
diff --git a/rerere.c b/rerere.c
index c7e1f8fd25..597256fa5b 100644
--- a/rerere.c
+++ b/rerere.c
@@ -1,3 +1,5 @@
+#define USE_THE_REPOSITORY_VARIABLE
+
 #include "git-compat-util.h"
 #include "abspath.h"
 #include "config.h"
diff --git a/reset.c b/reset.c
index 937f11c0f4..9550dea03d 100644
--- a/reset.c
+++ b/reset.c
@@ -1,3 +1,5 @@
+#define USE_THE_REPOSITORY_VARIABLE
+
 #include "git-compat-util.h"
 #include "cache-tree.h"
 #include "gettext.h"
diff --git a/resolve-undo.c b/resolve-undo.c
index 4e6f0e4676..8c9911affb 100644
--- a/resolve-undo.c
+++ b/resolve-undo.c
@@ -1,3 +1,5 @@
+#define USE_THE_REPOSITORY_VARIABLE
+
 #include "git-compat-util.h"
 #include "dir.h"
 #include "hash.h"
diff --git a/revision.c b/revision.c
index 7ddf0f151a..40da255953 100644
--- a/revision.c
+++ b/revision.c
@@ -1,3 +1,5 @@
+#define USE_THE_REPOSITORY_VARIABLE
+
 #include "git-compat-util.h"
 #include "config.h"
 #include "environment.h"
diff --git a/run-command.c b/run-command.c
index 31b20123d8..f5fde92b7c 100644
--- a/run-command.c
+++ b/run-command.c
@@ -1,3 +1,5 @@
+#define USE_THE_REPOSITORY_VARIABLE
+
 #include "git-compat-util.h"
 #include "run-command.h"
 #include "environment.h"
diff --git a/scalar.c b/scalar.c
index 331b91dbdb..a1cb4b45b5 100644
--- a/scalar.c
+++ b/scalar.c
@@ -2,6 +2,8 @@
  * The Scalar command-line interface.
  */
=20
+#define USE_THE_REPOSITORY_VARIABLE
+
 #include "git-compat-util.h"
 #include "abspath.h"
 #include "gettext.h"
diff --git a/send-pack.c b/send-pack.c
index 37f59d4f66..b42e6986df 100644
--- a/send-pack.c
+++ b/send-pack.c
@@ -1,3 +1,5 @@
+#define USE_THE_REPOSITORY_VARIABLE
+
 #include "git-compat-util.h"
 #include "config.h"
 #include "commit.h"
diff --git a/sequencer.c b/sequencer.c
index 823691e379..8083fe20bf 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1,3 +1,5 @@
+#define USE_THE_REPOSITORY_VARIABLE
+
 #include "git-compat-util.h"
 #include "abspath.h"
 #include "advice.h"
diff --git a/serve.c b/serve.c
index aa651b73e9..33608ea4d5 100644
--- a/serve.c
+++ b/serve.c
@@ -1,3 +1,5 @@
+#define USE_THE_REPOSITORY_VARIABLE
+
 #include "git-compat-util.h"
 #include "repository.h"
 #include "config.h"
diff --git a/server-info.c b/server-info.c
index 6feaa457c5..97e839c33d 100644
--- a/server-info.c
+++ b/server-info.c
@@ -1,3 +1,5 @@
+#define USE_THE_REPOSITORY_VARIABLE
+
 #include "git-compat-util.h"
 #include "dir.h"
 #include "environment.h"
diff --git a/setup.c b/setup.c
index 20f380825b..7e1169eb86 100644
--- a/setup.c
+++ b/setup.c
@@ -1,3 +1,5 @@
+#define USE_THE_REPOSITORY_VARIABLE
+
 #include "git-compat-util.h"
 #include "abspath.h"
 #include "copy.h"
diff --git a/shallow.c b/shallow.c
index a0b181ba8a..31a6ca40fe 100644
--- a/shallow.c
+++ b/shallow.c
@@ -1,3 +1,5 @@
+#define USE_THE_REPOSITORY_VARIABLE
+
 #include "git-compat-util.h"
 #include "hex.h"
 #include "repository.h"
diff --git a/split-index.c b/split-index.c
index 058a8f448e..120c8190b1 100644
--- a/split-index.c
+++ b/split-index.c
@@ -1,3 +1,5 @@
+#define USE_THE_REPOSITORY_VARIABLE
+
 #include "git-compat-util.h"
 #include "gettext.h"
 #include "hash.h"
diff --git a/streaming.c b/streaming.c
index 10adf625b2..38839511af 100644
--- a/streaming.c
+++ b/streaming.c
@@ -1,6 +1,9 @@
 /*
  * Copyright (c) 2011, Google Inc.
  */
+
+#define USE_THE_REPOSITORY_VARIABLE
+
 #include "git-compat-util.h"
 #include "convert.h"
 #include "environment.h"
diff --git a/submodule-config.c b/submodule-config.c
index ad43a282da..9b0bb0b9f4 100644
--- a/submodule-config.c
+++ b/submodule-config.c
@@ -1,3 +1,5 @@
+#define USE_THE_REPOSITORY_VARIABLE
+
 #include "git-compat-util.h"
 #include "dir.h"
 #include "environment.h"
diff --git a/submodule.c b/submodule.c
index caf3aa5600..ab99a30253 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1,3 +1,5 @@
+#define USE_THE_REPOSITORY_VARIABLE
+
 #include "git-compat-util.h"
 #include "abspath.h"
 #include "repository.h"
diff --git a/t/helper/test-bitmap.c b/t/helper/test-bitmap.c
index af43ee1cb5..1f18d57007 100644
--- a/t/helper/test-bitmap.c
+++ b/t/helper/test-bitmap.c
@@ -1,3 +1,5 @@
+#define USE_THE_REPOSITORY_VARIABLE
+
 #include "test-tool.h"
 #include "git-compat-util.h"
 #include "pack-bitmap.h"
diff --git a/t/helper/test-bloom.c b/t/helper/test-bloom.c
index 1281e66876..f7f9b62002 100644
--- a/t/helper/test-bloom.c
+++ b/t/helper/test-bloom.c
@@ -1,3 +1,5 @@
+#define USE_THE_REPOSITORY_VARIABLE
+
 #include "test-tool.h"
 #include "bloom.h"
 #include "hex.h"
diff --git a/t/helper/test-cache-tree.c b/t/helper/test-cache-tree.c
index dc89ecfd71..5cdef3ebef 100644
--- a/t/helper/test-cache-tree.c
+++ b/t/helper/test-cache-tree.c
@@ -1,3 +1,5 @@
+#define USE_THE_REPOSITORY_VARIABLE
+
 #include "test-tool.h"
 #include "gettext.h"
 #include "hex.h"
diff --git a/t/helper/test-dump-cache-tree.c b/t/helper/test-dump-cache-tre=
e.c
index 02b0b46c3f..3f0c7d0ed0 100644
--- a/t/helper/test-dump-cache-tree.c
+++ b/t/helper/test-dump-cache-tree.c
@@ -1,3 +1,5 @@
+#define USE_THE_REPOSITORY_VARIABLE
+
 #include "test-tool.h"
 #include "hash.h"
 #include "hex.h"
diff --git a/t/helper/test-dump-fsmonitor.c b/t/helper/test-dump-fsmonitor.c
index 4f215fea02..1b7f37a84f 100644
--- a/t/helper/test-dump-fsmonitor.c
+++ b/t/helper/test-dump-fsmonitor.c
@@ -1,3 +1,5 @@
+#define USE_THE_REPOSITORY_VARIABLE
+
 #include "test-tool.h"
 #include "read-cache-ll.h"
 #include "repository.h"
diff --git a/t/helper/test-dump-split-index.c b/t/helper/test-dump-split-in=
dex.c
index f472691a3c..a6720faf9c 100644
--- a/t/helper/test-dump-split-index.c
+++ b/t/helper/test-dump-split-index.c
@@ -1,3 +1,5 @@
+#define USE_THE_REPOSITORY_VARIABLE
+
 #include "test-tool.h"
 #include "hex.h"
 #include "read-cache-ll.h"
diff --git a/t/helper/test-dump-untracked-cache.c b/t/helper/test-dump-untr=
acked-cache.c
index 9ff67c3967..4f010d5324 100644
--- a/t/helper/test-dump-untracked-cache.c
+++ b/t/helper/test-dump-untracked-cache.c
@@ -1,3 +1,5 @@
+#define USE_THE_REPOSITORY_VARIABLE
+
 #include "test-tool.h"
 #include "dir.h"
 #include "hex.h"
diff --git a/t/helper/test-find-pack.c b/t/helper/test-find-pack.c
index e8bd793e58..14b2b0c12c 100644
--- a/t/helper/test-find-pack.c
+++ b/t/helper/test-find-pack.c
@@ -1,3 +1,5 @@
+#define USE_THE_REPOSITORY_VARIABLE
+
 #include "test-tool.h"
 #include "object-name.h"
 #include "object-store.h"
diff --git a/t/helper/test-fsmonitor-client.c b/t/helper/test-fsmonitor-cli=
ent.c
index 8280984d08..02bfe92e8d 100644
--- a/t/helper/test-fsmonitor-client.c
+++ b/t/helper/test-fsmonitor-client.c
@@ -3,6 +3,8 @@
  * a `git fsmonitor--daemon` daemon.
  */
=20
+#define USE_THE_REPOSITORY_VARIABLE
+
 #include "test-tool.h"
 #include "parse-options.h"
 #include "fsmonitor-ipc.h"
diff --git a/t/helper/test-lazy-init-name-hash.c b/t/helper/test-lazy-init-=
name-hash.c
index 5f33bb7b8f..40f5df4412 100644
--- a/t/helper/test-lazy-init-name-hash.c
+++ b/t/helper/test-lazy-init-name-hash.c
@@ -1,3 +1,5 @@
+#define USE_THE_REPOSITORY_VARIABLE
+
 #include "test-tool.h"
 #include "environment.h"
 #include "name-hash.h"
diff --git a/t/helper/test-match-trees.c b/t/helper/test-match-trees.c
index d0db5ff26f..e0e2048320 100644
--- a/t/helper/test-match-trees.c
+++ b/t/helper/test-match-trees.c
@@ -1,3 +1,5 @@
+#define USE_THE_REPOSITORY_VARIABLE
+
 #include "test-tool.h"
 #include "hex.h"
 #include "match-trees.h"
diff --git a/t/helper/test-oidmap.c b/t/helper/test-oidmap.c
index bd30244a54..c03cfa5ecf 100644
--- a/t/helper/test-oidmap.c
+++ b/t/helper/test-oidmap.c
@@ -1,3 +1,5 @@
+#define USE_THE_REPOSITORY_VARIABLE
+
 #include "test-tool.h"
 #include "hex.h"
 #include "object-name.h"
diff --git a/t/helper/test-pack-mtimes.c b/t/helper/test-pack-mtimes.c
index 67a964ef90..f8f9afbb5b 100644
--- a/t/helper/test-pack-mtimes.c
+++ b/t/helper/test-pack-mtimes.c
@@ -1,3 +1,5 @@
+#define USE_THE_REPOSITORY_VARIABLE
+
 #include "test-tool.h"
 #include "hex.h"
 #include "strbuf.h"
diff --git a/t/helper/test-reach.c b/t/helper/test-reach.c
index 1ba226f1f9..5dd374379c 100644
--- a/t/helper/test-reach.c
+++ b/t/helper/test-reach.c
@@ -1,3 +1,5 @@
+#define USE_THE_REPOSITORY_VARIABLE
+
 #include "test-tool.h"
 #include "commit.h"
 #include "commit-reach.h"
diff --git a/t/helper/test-read-cache.c b/t/helper/test-read-cache.c
index e803c43ece..d285c656bd 100644
--- a/t/helper/test-read-cache.c
+++ b/t/helper/test-read-cache.c
@@ -1,3 +1,5 @@
+#define USE_THE_REPOSITORY_VARIABLE
+
 #include "test-tool.h"
 #include "config.h"
 #include "read-cache-ll.h"
diff --git a/t/helper/test-read-graph.c b/t/helper/test-read-graph.c
index 8c7a83f578..d9e980d04c 100644
--- a/t/helper/test-read-graph.c
+++ b/t/helper/test-read-graph.c
@@ -1,3 +1,5 @@
+#define USE_THE_REPOSITORY_VARIABLE
+
 #include "test-tool.h"
 #include "commit-graph.h"
 #include "repository.h"
diff --git a/t/helper/test-read-midx.c b/t/helper/test-read-midx.c
index 4acae41bb9..83effc2b5f 100644
--- a/t/helper/test-read-midx.c
+++ b/t/helper/test-read-midx.c
@@ -1,3 +1,5 @@
+#define USE_THE_REPOSITORY_VARIABLE
+
 #include "test-tool.h"
 #include "hex.h"
 #include "midx.h"
diff --git a/t/helper/test-ref-store.c b/t/helper/test-ref-store.c
index ad24300170..637b8b294e 100644
--- a/t/helper/test-ref-store.c
+++ b/t/helper/test-ref-store.c
@@ -1,3 +1,5 @@
+#define USE_THE_REPOSITORY_VARIABLE
+
 #include "test-tool.h"
 #include "hex.h"
 #include "refs.h"
diff --git a/t/helper/test-repository.c b/t/helper/test-repository.c
index 0c7c5aa4dd..c6a074df3d 100644
--- a/t/helper/test-repository.c
+++ b/t/helper/test-repository.c
@@ -1,3 +1,5 @@
+#define USE_THE_REPOSITORY_VARIABLE
+
 #include "test-tool.h"
 #include "commit-graph.h"
 #include "commit.h"
diff --git a/t/helper/test-revision-walking.c b/t/helper/test-revision-walk=
ing.c
index f346951bc2..071f5bd1e2 100644
--- a/t/helper/test-revision-walking.c
+++ b/t/helper/test-revision-walking.c
@@ -8,6 +8,8 @@
  * published by the Free Software Foundation.
  */
=20
+#define USE_THE_REPOSITORY_VARIABLE
+
 #include "test-tool.h"
 #include "commit.h"
 #include "diff.h"
diff --git a/t/helper/test-scrap-cache-tree.c b/t/helper/test-scrap-cache-t=
ree.c
index 737cbe475b..64fff6e9e3 100644
--- a/t/helper/test-scrap-cache-tree.c
+++ b/t/helper/test-scrap-cache-tree.c
@@ -1,3 +1,5 @@
+#define USE_THE_REPOSITORY_VARIABLE
+
 #include "test-tool.h"
 #include "lockfile.h"
 #include "read-cache-ll.h"
diff --git a/t/helper/test-submodule-config.c b/t/helper/test-submodule-con=
fig.c
index 4b809d9dca..cbe93f2f9e 100644
--- a/t/helper/test-submodule-config.c
+++ b/t/helper/test-submodule-config.c
@@ -1,3 +1,5 @@
+#define USE_THE_REPOSITORY_VARIABLE
+
 #include "test-tool.h"
 #include "config.h"
 #include "hash.h"
diff --git a/t/helper/test-submodule-nested-repo-config.c b/t/helper/test-s=
ubmodule-nested-repo-config.c
index ecd40ded99..6ca069ce63 100644
--- a/t/helper/test-submodule-nested-repo-config.c
+++ b/t/helper/test-submodule-nested-repo-config.c
@@ -1,3 +1,5 @@
+#define USE_THE_REPOSITORY_VARIABLE
+
 #include "test-tool.h"
 #include "repository.h"
 #include "setup.h"
diff --git a/t/helper/test-submodule.c b/t/helper/test-submodule.c
index 7197969a08..22e518d229 100644
--- a/t/helper/test-submodule.c
+++ b/t/helper/test-submodule.c
@@ -1,3 +1,5 @@
+#define USE_THE_REPOSITORY_VARIABLE
+
 #include "test-tool.h"
 #include "test-tool-utils.h"
 #include "parse-options.h"
diff --git a/t/helper/test-trace2.c b/t/helper/test-trace2.c
index 1adac29a57..cd955ec63e 100644
--- a/t/helper/test-trace2.c
+++ b/t/helper/test-trace2.c
@@ -1,3 +1,5 @@
+#define USE_THE_REPOSITORY_VARIABLE
+
 #include "test-tool.h"
 #include "strvec.h"
 #include "run-command.h"
diff --git a/t/helper/test-write-cache.c b/t/helper/test-write-cache.c
index 7e3da380a9..b37dd2c5d6 100644
--- a/t/helper/test-write-cache.c
+++ b/t/helper/test-write-cache.c
@@ -1,3 +1,5 @@
+#define USE_THE_REPOSITORY_VARIABLE
+
 #include "test-tool.h"
 #include "lockfile.h"
 #include "read-cache-ll.h"
diff --git a/t/unit-tests/t-example-decorate.c b/t/unit-tests/t-example-dec=
orate.c
index 3c856a8cf2..a4a75db735 100644
--- a/t/unit-tests/t-example-decorate.c
+++ b/t/unit-tests/t-example-decorate.c
@@ -1,3 +1,5 @@
+#define USE_THE_REPOSITORY_VARIABLE
+
 #include "test-lib.h"
 #include "object.h"
 #include "decorate.h"
diff --git a/tag.c b/tag.c
index 52bbe50819..d24170e340 100644
--- a/tag.c
+++ b/tag.c
@@ -1,3 +1,5 @@
+#define USE_THE_REPOSITORY_VARIABLE
+
 #include "git-compat-util.h"
 #include "environment.h"
 #include "tag.h"
diff --git a/tmp-objdir.c b/tmp-objdir.c
index 3509258be5..a8e4553f27 100644
--- a/tmp-objdir.c
+++ b/tmp-objdir.c
@@ -1,3 +1,5 @@
+#define USE_THE_REPOSITORY_VARIABLE
+
 #include "git-compat-util.h"
 #include "tmp-objdir.h"
 #include "abspath.h"
diff --git a/transport-helper.c b/transport-helper.c
index 9820947ab2..09b3560ffd 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -1,3 +1,5 @@
+#define USE_THE_REPOSITORY_VARIABLE
+
 #include "git-compat-util.h"
 #include "transport.h"
 #include "quote.h"
diff --git a/transport.c b/transport.c
index 83ddea8fbc..b9c8827ed9 100644
--- a/transport.c
+++ b/transport.c
@@ -1,3 +1,5 @@
+#define USE_THE_REPOSITORY_VARIABLE
+
 #include "git-compat-util.h"
 #include "advice.h"
 #include "config.h"
diff --git a/tree-walk.c b/tree-walk.c
index 535a3a2539..a033397965 100644
--- a/tree-walk.c
+++ b/tree-walk.c
@@ -1,3 +1,5 @@
+#define USE_THE_REPOSITORY_VARIABLE
+
 #include "git-compat-util.h"
 #include "tree-walk.h"
 #include "dir.h"
diff --git a/tree.c b/tree.c
index 7973d3f9a8..ad86ad1ba9 100644
--- a/tree.c
+++ b/tree.c
@@ -1,3 +1,5 @@
+#define USE_THE_REPOSITORY_VARIABLE
+
 #include "git-compat-util.h"
 #include "hex.h"
 #include "tree.h"
diff --git a/unpack-trees.c b/unpack-trees.c
index 304ea2ed86..7dc884fafd 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -1,3 +1,5 @@
+#define USE_THE_REPOSITORY_VARIABLE
+
 #include "git-compat-util.h"
 #include "advice.h"
 #include "strvec.h"
diff --git a/upload-pack.c b/upload-pack.c
index b726f7a57d..0052c6a4dc 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -1,3 +1,5 @@
+#define USE_THE_REPOSITORY_VARIABLE
+
 #include "git-compat-util.h"
 #include "config.h"
 #include "environment.h"
diff --git a/walker.c b/walker.c
index 946d86b04e..0fafdc97cf 100644
--- a/walker.c
+++ b/walker.c
@@ -1,3 +1,5 @@
+#define USE_THE_REPOSITORY_VARIABLE
+
 #include "git-compat-util.h"
 #include "gettext.h"
 #include "hex.h"
diff --git a/worktree.c b/worktree.c
index 70844d023a..f3c4c8ec54 100644
--- a/worktree.c
+++ b/worktree.c
@@ -1,3 +1,5 @@
+#define USE_THE_REPOSITORY_VARIABLE
+
 #include "git-compat-util.h"
 #include "abspath.h"
 #include "environment.h"
diff --git a/wt-status.c b/wt-status.c
index 5051f5e599..8815df419e 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -1,3 +1,5 @@
+#define USE_THE_REPOSITORY_VARIABLE
+
 #include "git-compat-util.h"
 #include "advice.h"
 #include "wt-status.h"
diff --git a/xdiff-interface.c b/xdiff-interface.c
index 16ed8ac492..d5dc88661e 100644
--- a/xdiff-interface.c
+++ b/xdiff-interface.c
@@ -1,3 +1,5 @@
+#define USE_THE_REPOSITORY_VARIABLE
+
 #include "git-compat-util.h"
 #include "gettext.h"
 #include "config.h"
--=20
2.45.2.457.g8d94cfb545.dirty


--rIrAXCpouaKX8OIm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZqjiwACgkQVbJhu7ck
PpTgwA/+NuhDxDXCdred61bdWY6CUbzOWEHnEDs972Y1xqBQRKzo2KtxB6MBuW2m
/prCHJEOlWdy2l5r58EwazAAdT9+gNNVWG3o9GGTaCcORy5LIwp7bGkeukAEhRtq
HG78vTUzvY1fZmuMES1WNEExKUEk4aZXDk5LFt4TDRffQKHBIUR07h89Hl/Z6NjV
qiirgNjj7Wg/hqr1xtLnM3b1SD0Zzt1Z+QGwLCbZa/gq54Q72xJaxxfkH8McxG4J
jeAHn9sUi9AjoTZOeGEowefyiDUfG6/1MvPY/75zE4HVcnUH9bGw7QmXnjJy9/za
mJi1F3MTrofiryOpKGVPxKdMvqlBt9RQy/dhEUKAQhTkEfWlyWlXit1M3fKLMmUV
hYBKWdwm16ysc2taStlseZikPvNLdagypUFjdBWTjiKAwyLNoYO8CwRUAU5HRXde
5rZOkxRa1UqlWJS4S9eziBFEWpd4P6BJlM9JUR+t5pByIvB2c6x935NkDvZElsK2
suITZcMJPdsUnwcfgvetcrnFwE5pl7wmEBSu9+BuI4PGp/t5LgjFX3DZqOtxaNzN
AO8DDlMgjUHA4uU2WopFkuD/9OxhaW1bbeXlaOCeodUH3K3FWfGYPHj0iY6O8WbY
9POLJfpYQXQn7b5ILUJwXqnlZS2AOJ9QzidvuNZVEon7k92oX2o=
=+fiL
-----END PGP SIGNATURE-----

--rIrAXCpouaKX8OIm--
