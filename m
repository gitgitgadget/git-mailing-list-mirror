Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF3FE1B87C0
	for <git@vger.kernel.org>; Mon, 14 Apr 2025 06:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744613481; cv=none; b=kvrOX9c9eZ7xM2rVzgQcMlMB8zUJwZQmVEyz4v4ddpwu+YCBxEcop2g4aKd9uAuxO27CmUcT6fHvmpa2a9AXEuuageMl0RlS+aPqYGLt/eiGUS4TXeSp+DyrawU1QabpYJwVokXd6wRojmL1PHYLFyZgefWWxGvFIkRXQRiTBbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744613481; c=relaxed/simple;
	bh=p4uKXXrpLbmrRBuWjgPwonGkNeGbp0tWQ8MCymIzOdU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To; b=ZKnuPuwtk/MkI3IlizDFYGgq68dJK6fC69Q21CllIMAbyrvTm7yj9FKgVQfsQkmIdyjmJ8BfKdGV9foX78QTS5Ab9RqeV6N76Ll3AoC32dabNEGH6eFxqWXIVQqI5CO6g9nrIhzi66GIaYA4KOzHdBuJpySzNOAPxVsalTngr2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Ur+5btaj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ncTiCOAS; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Ur+5btaj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ncTiCOAS"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id D0CCA1140109
	for <git@vger.kernel.org>; Mon, 14 Apr 2025 02:51:18 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Mon, 14 Apr 2025 02:51:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1744613478;
	 x=1744699878; bh=+vdvMOwKZehbvKlYMZC2vQExqr3GlcsWRoGYhFcBoeA=; b=
	Ur+5btaj8A3YRt8/MSmKyQd6RNoLsqQrZ7ZpZltAFwySAOVe+7CF8UAkL1uo0X9S
	+qNtGDQo6ZLr6JfriJhQmutY3N0TkXrCYwTKhKlkZAQRvBk/04WVvifieLSmJnKs
	pgRlwL6LdoxCQIYCELdNCJCWA2SwNg89kGb9I+aBSjJKyzMnFHsRFs+SEbzSsxwm
	IZ0RvKy2ESPe3+5pyrfSMJEmdTVL3aNbEQa1LgSveiY7V30sHx34V7KDwJwy/oLc
	Wsh8/UxMXeX3BcOTxqmqQBYPi+w92sS92VP1mwdzhELCP/Xl88oEdVHe/pzvEoIz
	kne0NSiuvDqazIAmW+umMQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1744613478; x=1744699878; bh=+
	vdvMOwKZehbvKlYMZC2vQExqr3GlcsWRoGYhFcBoeA=; b=ncTiCOASvZ1wY6ya6
	hdnbsSTmDJqPTWnSuuuP/UwCn1rljC135NUP0N9VMDEkM4SipWIfklD5uptqzVim
	boWkNtrIPJQRWDC/8mOjcQUaFn3ZUbkz6ZacLmRnxeOAhRgxYrqfdCQ7oI5SizAZ
	bwB/UwzXZcfHNfL478H2y1VL/4zT8LpvPeMvMrI7amWXSRu+Xst3/PWaKvHuX6Ac
	En+tWI4ChO/nygum6vDO9DbpwtM5SQywBeT/rxh3/NUMsaGyg8iVMIFGoH2Qu++4
	zgBQ4wtaBGRMUSumkMQvzNOH7mPKXfDQdYZ9f2oiqLIxUkvPjpPYJP+lhi3G8fGu
	ipmmw==
X-ME-Sender: <xms:ZrD8ZyO3lJcUSoYlqNXwQ4k-p4YFlI5bfeLdK6iLCr69fonOdu-9YA>
    <xme:ZrD8Zw-IFZ3HLR4llf8ZDisHRuFiCqWgmc_pun88OmlF9_KWfOE6jgzjHiqrjEK6y
    2SW8qSvTU3poXwl1A>
X-ME-Received: <xmr:ZrD8Z5TAnKHzxDR7iEQfVS9ZTLp-o_mzsF4EVNUIcCNyPdNWCK1DTfNiHKG7j6VBbU3Xmk2yY4Flkmp0Mj43nJo3Wk-xdIW-U25PBdY1T7nA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvudelkeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhff
    fugggtgffkfhgjvffosehtjeertdertdejnecuhfhrohhmpefrrghtrhhitghkucfuthgv
    ihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeelueduue
    eljeelhfejueeffefgtedtvedtfeeffeevleelueetffegteduffegleenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpd
    hnsggprhgtphhtthhopedupdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihht
    sehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:ZrD8ZytjFsoqfTTD0DphW7uwrOC9fWLkfLoudg0sWUNFq5Ezr3kqdQ>
    <xmx:ZrD8Z6efiBpixutPHkehAzdV4NQBrZnrv0Tlj5B-osLG4ROL4gYnAQ>
    <xmx:ZrD8Z22gdozNGA8_lsegIjRUOt-4nwmoWi9B_jK5PS16m1bl0vyrbw>
    <xmx:ZrD8Z-_NvT_KEyPckX3pyWDo1XMHksY3IaL7tqO189l-nUbWtW__7g>
    <xmx:ZrD8Z66kBqly6uVnQU2E10uKjoI9rR1-bfzjhSEG6gWlb0SKy-hNPk3o>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 14 Apr 2025 02:51:18 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id a0b1eeb3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Mon, 14 Apr 2025 06:51:17 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 14 Apr 2025 08:51:14 +0200
Subject: [PATCH v2 4/5] meson: wire up benchmarks
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250414-pks-meson-benchmarks-v2-4-04377080a167@pks.im>
References: <20250414-pks-meson-benchmarks-v2-0-04377080a167@pks.im>
In-Reply-To: <20250414-pks-meson-benchmarks-v2-0-04377080a167@pks.im>
To: git@vger.kernel.org
X-Mailer: b4 0.14.2

Wire up benchmarks in Meson. The setup is mostly the same as how we wire
up our tests. The only difference is that benchmarks get wired up via
the `benchmark()` option instead of via `test()`, which gives them a bit
of special treatment:

  - Benchmarks never run in parallel.

  - Benchmarks aren't run by default when tests are executed.

  - Meson does not inject the `MALLOC_PERTURB` environment variable.

Using benchmarks is quite simple:

    ```
    $ meson setup build
    # Run all benchmarks.
    $ meson test -C build --benchmark
    # Run a specific benchmark.
    $ meson test -C build --benchmark p0000-*
    ```

Other than that the usual command line arguments accepted when running
tests are also accepted when running benchmarks.

Note that the benchmarking target is somewhat limited because it will
only run benchmarks for the current build. Other usecases, like running
benchmarks against multiple different versions of Git, are not currently
supported. Users should continue to use "t/perf/run" for those usecases.
The script should get extended at one point in time to support Meson,
but this is outside of the scope of this series.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 meson.build   |  1 +
 t/meson.build | 77 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 78 insertions(+)

diff --git a/meson.build b/meson.build
index efe2871c9db..9af4a10188d 100644
--- a/meson.build
+++ b/meson.build
@@ -204,6 +204,7 @@ git = find_program('git', dirs: program_path, required: false)
 sed = find_program('sed', dirs: program_path)
 shell = find_program('sh', dirs: program_path)
 tar = find_program('tar', dirs: program_path)
+time = find_program('time', dirs: program_path, required: false)
 
 # Sanity-check that programs required for the build exist.
 foreach tool : ['cat', 'cut', 'grep', 'sort', 'tr', 'uname']
diff --git a/t/meson.build b/t/meson.build
index a59da26be3f..dba327fd7ec 100644
--- a/t/meson.build
+++ b/t/meson.build
@@ -1096,11 +1096,71 @@ integration_tests = [
   't9903-bash-prompt.sh',
 ]
 
+benchmarks = [
+  'perf/p0000-perf-lib-sanity.sh',
+  'perf/p0001-rev-list.sh',
+  'perf/p0002-read-cache.sh',
+  'perf/p0003-delta-base-cache.sh',
+  'perf/p0004-lazy-init-name-hash.sh',
+  'perf/p0005-status.sh',
+  'perf/p0006-read-tree-checkout.sh',
+  'perf/p0007-write-cache.sh',
+  'perf/p0008-odb-fsync.sh',
+  'perf/p0071-sort.sh',
+  'perf/p0090-cache-tree.sh',
+  'perf/p0100-globbing.sh',
+  'perf/p1006-cat-file.sh',
+  'perf/p1400-update-ref.sh',
+  'perf/p1450-fsck.sh',
+  'perf/p1451-fsck-skip-list.sh',
+  'perf/p1500-graph-walks.sh',
+  'perf/p2000-sparse-operations.sh',
+  'perf/p3400-rebase.sh',
+  'perf/p3404-rebase-interactive.sh',
+  'perf/p4000-diff-algorithms.sh',
+  'perf/p4001-diff-no-index.sh',
+  'perf/p4002-diff-color-moved.sh',
+  'perf/p4205-log-pretty-formats.sh',
+  'perf/p4209-pickaxe.sh',
+  'perf/p4211-line-log.sh',
+  'perf/p4220-log-grep-engines.sh',
+  'perf/p4221-log-grep-engines-fixed.sh',
+  'perf/p5302-pack-index.sh',
+  'perf/p5303-many-packs.sh',
+  'perf/p5304-prune.sh',
+  'perf/p5310-pack-bitmaps.sh',
+  'perf/p5311-pack-bitmaps-fetch.sh',
+  'perf/p5312-pack-bitmaps-revs.sh',
+  'perf/p5313-pack-objects.sh',
+  'perf/p5314-name-hash.sh',
+  'perf/p5326-multi-pack-bitmaps.sh',
+  'perf/p5332-multi-pack-reuse.sh',
+  'perf/p5333-pseudo-merge-bitmaps.sh',
+  'perf/p5550-fetch-tags.sh',
+  'perf/p5551-fetch-rescan.sh',
+  'perf/p5600-partial-clone.sh',
+  'perf/p5601-clone-reference.sh',
+  'perf/p6100-describe.sh',
+  'perf/p6300-for-each-ref.sh',
+  'perf/p7000-filter-branch.sh',
+  'perf/p7102-reset.sh',
+  'perf/p7300-clean.sh',
+  'perf/p7519-fsmonitor.sh',
+  'perf/p7527-builtin-fsmonitor.sh',
+  'perf/p7810-grep.sh',
+  'perf/p7820-grep-engines.sh',
+  'perf/p7821-grep-engines-fixed.sh',
+  'perf/p7822-grep-perl-character.sh',
+  'perf/p9210-scalar.sh',
+  'perf/p9300-fast-import-export.sh',
+]
+
 # Sanity check that we are not missing any tests present in 't/'. This check
 # only runs once at configure time and is thus best-effort, only. It is
 # sufficient to catch missing test suites in our CI though.
 foreach glob, tests : {
   't[0-9][0-9][0-9][0-9]-*.sh': integration_tests,
+  'perf/p[0-9][0-9][0-9][0-9]-*.sh': benchmarks,
   'unit-tests/t-*.c': unit_test_programs,
   'unit-tests/u-*.c': clar_test_suites,
 }
@@ -1152,3 +1212,20 @@ foreach integration_test : integration_tests
     timeout: 0,
   )
 endforeach
+
+if time.found()
+  benchmark_environment = test_environment
+  benchmark_environment.set('GTIME', time.full_path())
+
+  foreach benchmark : benchmarks
+    benchmark(fs.stem(benchmark), shell,
+      args: [
+        fs.name(benchmark),
+      ],
+      workdir: meson.current_source_dir() / 'perf',
+      env: benchmark_environment,
+      depends: test_dependencies + bin_wrappers,
+      timeout: 0,
+    )
+  endforeach
+endif

-- 
2.49.0.805.g082f7c87e0.dirty

