Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC4BD1C5D7D
	for <git@vger.kernel.org>; Mon, 28 Apr 2025 07:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745825460; cv=none; b=Rli5xYIyvKmSDYr7qv9x4iUVM7oewexY4Dhygij4rCumlL6qGuHXZLce0J0waAgdgr/f9JLNt/qJYyckJUEx/oohvuYwNBoW1DxuQQSZGYsHKTnZ0r76Sjw8Qsq4925NhtxQPPXQHyh1dUbku26yNWbjlsoRTt5RRX/PpMPox7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745825460; c=relaxed/simple;
	bh=x8OOyVetkuZm1Mr7w9zQRAqG52eADI9G5jP7lMmQGu8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=h9qMPbQwDr7i6UXDppFCPccJHtwER4xgE1VJj8cJ9B1tzdN/eHgO3NOETweD7mg/4Y3xgofh8H3LPMp2wYGxh1ls7K/bp3a7sJhyEI8yxWnPgtLK2SjPKqfrxa+bCSDFsFM8EnFlqyXt3628/ZrznCA/kvbsjsPYuX9Nrt2n314=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=G+PktPjs; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=q/OjGUds; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="G+PktPjs";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="q/OjGUds"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id B001C1140250;
	Mon, 28 Apr 2025 03:30:57 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Mon, 28 Apr 2025 03:30:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1745825457;
	 x=1745911857; bh=8vO08SWN52SsRWm8bahvZBYK9rCznZjuVxI8CaTIO8A=; b=
	G+PktPjs9bhkwEvDgGQ2jllbNL+2esdM2MS62ZLg4Cn83s/fdMO0PuOeAC9gu5hS
	00FRH/r/k78F67I/1aNteJO9ojFx3S/7V9PQwdQpihX13ZMW0CuvBV0qHqFd3sKo
	JGHSstglf0px808u+NA5Ir96WhRAX9wKX19LvCO001tNV818OsVjbJgmQ3HJwKJJ
	j3oJDOj9pXkoAXoiXXMDzZGnxA9kuedsxyWGYCQuY334nfIfM4lbM9eSEr9I5FJj
	Pd3Ssxn4QZcgx06NtlIjiQd905QjsDvL5RyMzvjAXdbOC3uyjSuwJ+UjYLBVao3j
	wXaiQ4ddCjYBczEmKGwTcA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1745825457; x=
	1745911857; bh=8vO08SWN52SsRWm8bahvZBYK9rCznZjuVxI8CaTIO8A=; b=q
	/OjGUdsMuZJJeEDXJ9f0ANflK1IpQT0RkIuxfxjIRVd59Jt9ZMx+nfGTzeE0p5Gd
	xyRdn9VZzJRwGIN+IB8KsFGHUmP1ZMoYEd8FceAve7v+FjRCyULw7qZVtCvBPrDN
	ipDiSeJHB19Y0Apay8uFLwOd8k61jYWkj4KGYVdLfhsJCQ002PiXFoePIi9RvG2i
	+gupCnJCQ6IXhKapwrk9ZEOQT6qOZU94xGVl7+EDhEMw4Z4O7DFGSxymVnsWc1dp
	6Lr7V9TjQdhkl+SW+elggJ03j2IMEOHbXrtYHhDTAFlL9rxokzq8HCXsfSvBjMdP
	cELCLnw3udcBOtocOw1AA==
X-ME-Sender: <xms:sS4PaMbv9h6mD5jF9eCBj-w93OgXTGbRc4Rbz0PsuaTQs_y7iLGF5g>
    <xme:sS4PaHYXDhE5dOJ2J0TuMfNa1oqS0TYI5bGs236K-DZJ7bVxlxOzdMXcIsCtsQ64d
    NyXl8gIJtRU8vl_-g>
X-ME-Received: <xmr:sS4PaG9ZPNgVK8wpvtKZk4QqYj9AUHZP4Ekmy2-hvu5MVhLeuAFGUAVGryxxfrs5nhOB2Rn4sNiE4cO6I353B4MghGtpsejdteci03gXNREe>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddviedtfeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteek
    udehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpd
    hrtghpthhtohepthhoohhnsehiohhttghlrdgtohhmpdhrtghpthhtoheptghhrhhishgt
    ohholhesthhugihfrghmihhlhidrohhrghdprhgtphhtthhopehgihhtsehvghgvrhdrkh
    gvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:sS4PaGo6Q0OZGGmo2oGEt9f_fyX1pxnMJ3Ta-o4CvB8u1BblLxX0dg>
    <xmx:sS4PaHrfFgwpgaso1dnK5ZsyNQSBdPe4VU6zR1nKn432zhAF5c4ulg>
    <xmx:sS4PaERf4wNbML4lCXrER8_r9bAhfs0ZYnFfIkN7msup8VuzjMsPXA>
    <xmx:sS4PaHo5tCwWx8FP8mxEYq-z1SSRmNGKEnkfjF8_N5c5OZPWj_hOTQ>
    <xmx:sS4PaMNVJ3ySG_saSMsaIGe4boBMZEpZ1xTahz7_JHr8-fUTMNyRjeUL>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 28 Apr 2025 03:30:56 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id ebad3883 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 28 Apr 2025 07:30:55 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 28 Apr 2025 09:30:49 +0200
Subject: [PATCH v5 4/5] meson: wire up benchmarks
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250428-pks-meson-benchmarks-v5-4-5010dd014d1d@pks.im>
References: <20250428-pks-meson-benchmarks-v5-0-5010dd014d1d@pks.im>
In-Reply-To: <20250428-pks-meson-benchmarks-v5-0-5010dd014d1d@pks.im>
To: git@vger.kernel.org
Cc: Toon Claes <toon@iotcl.com>, Junio C Hamano <gitster@pobox.com>, 
 Christian Couder <chriscool@tuxfamily.org>
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
only run benchmarks for the current build. Other use cases, like running
benchmarks against multiple different versions of Git, are not currently
supported. Users should continue to use "t/perf/run" for those use
cases. The script should get extended at one point in time to support
Meson, but this is outside of the scope of this series.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 meson.build       | 16 +++++++++---
 meson_options.txt |  2 ++
 t/meson.build     | 77 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 91 insertions(+), 4 deletions(-)

diff --git a/meson.build b/meson.build
index 410bbf93dad..939a2eae326 100644
--- a/meson.build
+++ b/meson.build
@@ -70,9 +70,15 @@
 #      # Execute single test interactively such that features like `debug ()` work.
 #      $ meson test -i --test-args='-ix' t1400-update-ref
 #
-#   Test execution is parallelized by default and scales with the number of
-#   processor cores available. You can change the number of processes by passing
-#   the `-jN` flag to `meson test`.
+#      # Execute all benchmarks.
+#      $ meson test -i --benchmark
+#
+#      # Execute single benchmark.
+#      $ meson test -i --benchmark p0000-*
+#
+#   Test execution (but not benchmark execution) is parallelized by default and
+#   scales with the number of processor cores available. You can change the
+#   number of processes by passing the `-jN` flag to `meson test`.
 #
 # 4. Install the Git distribution. Again, this can be done via Meson, Ninja or
 #    Samurai:
@@ -235,6 +241,7 @@ git = find_program('git', dirs: program_path, native: true, required: false)
 sed = find_program('sed', dirs: program_path, native: true)
 shell = find_program('sh', dirs: program_path, native: true)
 tar = find_program('tar', dirs: program_path, native: true)
+time = find_program('time', dirs: program_path, required: get_option('benchmarks'))
 
 target_shell = find_program('sh', dirs: program_path, native: false)
 
@@ -836,7 +843,7 @@ endif
 # features. It is optional if you want to neither execute tests nor use any of
 # these optional features.
 perl_required = get_option('perl')
-if get_option('gitweb').enabled() or 'netrc' in get_option('credential_helpers') or get_option('docs') != []
+if get_option('benchmarks').enabled() or get_option('gitweb').enabled() or 'netrc' in get_option('credential_helpers') or get_option('docs') != []
   perl_required = true
 endif
 
@@ -2082,6 +2089,7 @@ meson.add_dist_script(
 )
 
 summary({
+  'benchmarks': get_option('tests') and perl.found() and time.found(),
   'curl': curl.found(),
   'expat': expat.found(),
   'gettext': intl.found(),
diff --git a/meson_options.txt b/meson_options.txt
index 8ac30a52231..7f5bca5c029 100644
--- a/meson_options.txt
+++ b/meson_options.txt
@@ -101,6 +101,8 @@ option('docs_backend', type: 'combo', choices: ['asciidoc', 'asciidoctor', 'auto
   description: 'Which backend to use to generate documentation.')
 
 # Testing.
+option('benchmarks', type: 'feature', value: 'auto',
+  description: 'Enable benchmarks. This requires Perl and GNU time.')
 option('coccinelle', type: 'feature', value: 'auto',
   description: 'Provide a coccicheck target that generates a Coccinelle patch.')
 option('tests', type: 'boolean', value: true,
diff --git a/t/meson.build b/t/meson.build
index bfb744e8863..59438b06266 100644
--- a/t/meson.build
+++ b/t/meson.build
@@ -1097,11 +1097,71 @@ integration_tests = [
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
@@ -1153,3 +1213,20 @@ foreach integration_test : integration_tests
     timeout: 0,
   )
 endforeach
+
+if perl.found() and time.found()
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
2.49.0.967.g6a0df3ecc3.dirty

