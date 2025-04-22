Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6321D22ACE3
	for <git@vger.kernel.org>; Tue, 22 Apr 2025 06:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745304626; cv=none; b=E+KGLpaZO3vA8CoqcTn/Ofvk+qLp/i9aHt9vRMPexnbeOypcx614pVLnhwmEziuUU5pvvl7YvDdf/vC0eb7oXN8j8Q+y/2oSjeYNZ3gssHGOML9T5w0v4VqcrB31WVjOxVzDq7lBTG3cRjz2V17TFm256iHu0HgvlSFXHMi/9uQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745304626; c=relaxed/simple;
	bh=+Mch/rBD3YK0qcvmH8NASRrmlEoxVFdWf8YzPzG2Imk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qFjM82ZrUifD0jfb1b2uyqMayzF/TH35PrO1bvlmAnOAFhDBI2ECcsufwAxE5pT2Lr5yI19FyQ1cLFG8jSCK3Mj9cyL9tLj30/bacB2WpSjienubt5h4BR3KIZpT5zyZ0fE4cPDHgQ5xyFq/kinK1+Tc16begZpYQJkv7Y0j8tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=IB5GPk+5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qA8KbzN8; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="IB5GPk+5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qA8KbzN8"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 513DE2540226;
	Tue, 22 Apr 2025 02:50:23 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Tue, 22 Apr 2025 02:50:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1745304623;
	 x=1745391023; bh=vyzyDOI3XCW5wz+sknaCW4H+0HcaofJQ+ae2UIcySYo=; b=
	IB5GPk+59DKxKf1qwi+Od/FqJt/USqEmwtUZpk4oyh1Vd1Jvnk5Q831U/A795/TX
	cXl5Obfu+49VPSfNjn3lSivM/hseR1xVRJfobsQQOb0AHzuwUpPKQMLXesPBhnZM
	Imy7wwfsUXs1uZ+/T4TLJGoGDp7UUHLG+J6pImHF82w0ilLLlCB492L8w9PkQQpY
	uqNmECq19GUqPqbmKZ2pvpV+RkoWzvOtXTN/M/VO2bMOlcVyHf6wXJzVMtg9JgNV
	O2icjBNSoYsWfydKzHszUVmTutpiQ6BXm7rHfvMShp2vCA3gVdzkmia+6r6QEezO
	s9C9sP/waA07CJeOR1AEGw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1745304623; x=
	1745391023; bh=vyzyDOI3XCW5wz+sknaCW4H+0HcaofJQ+ae2UIcySYo=; b=q
	A8KbzN8VCHsvhffUOq8xMhSfSJ1gu40tgpDkAYS0IxLnlF5N/G1MH+i2eOSOq3ap
	GbcmPum8fjag3dUauQSOggzYEdpyEfLcMHupxCtgBtlKBBVkBZigBn1B98FOyp4H
	s06lOOtlHBpuzboenfCybPkj96V/JdJcTsdrrFV5qh9hyu33us1h+w7fx573KIDv
	QhaKu2sxDMiQl3imUKj6O8XlUke2DEY8fw51WIu1SacS6Nd1ZXmlE3/2ZvRvAjNX
	Mr8yo8j+LtjsZS276dkcNjrzEvvpSfm9PPwr2Rprb1l3Tn6lZjuyfatZssuUHKWJ
	pSUjd+yA/j6hfINpuIqeg==
X-ME-Sender: <xms:LzwHaDICXUFLS3Adfm1Jl1lXL2gNLFQ4LOlkt26xwRbqTN5w1F_Nug>
    <xme:LzwHaHL3oA7byFneZn0NEYmY7vf5FNIIQb2KUeO3XQodnQug-yRgw8Ju6Qr5HCn6r
    m153IFnF9L-60C-FQ>
X-ME-Received: <xmr:LzwHaLsfUsmBPnH_RdcQrkYapJlhUNBQbQVx68JqORgEB47cVVto7ayvNdYtmVOvNeKtTeWBuVb7PW_cDfpgTNOBw3dWuIHfmed90ssI1EE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvgeeftdeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteek
    udehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopegthhhrihhstghoohhlsehtuhigfhgrmhhilh
    ihrdhorhhgpdhrtghpthhtohepthhoohhnsehiohhttghlrdgtohhmpdhrtghpthhtohep
    ghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:LzwHaMbwwC_hFEOc3ktHC93MP9-7LGWXJc16RmGyAaoz27ISk9hwKg>
    <xmx:LzwHaKYsRJQrqmNOLjWX96S8PqLINIgADhddFYYdrj4aoQ_gQbaJlA>
    <xmx:LzwHaADDEv9n3TO2YYhfUkiIzB4kOwugkShIWO1K1AnKC8M-zoUw8Q>
    <xmx:LzwHaIaYzKwvrQBZc0MOCh3jfac8inVeuyAYX-cl9EThqZEQVi-vTg>
    <xmx:LzwHaFd7gy0QTsoMHezG0x0diGHwftggPt-MDBYTtSbZmwWphsK7LaF0>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 22 Apr 2025 02:50:22 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 1bd7f86e (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 22 Apr 2025 06:50:20 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 22 Apr 2025 08:50:14 +0200
Subject: [PATCH v3 4/5] meson: wire up benchmarks
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250422-pks-meson-benchmarks-v3-4-7aad68bac6fd@pks.im>
References: <20250422-pks-meson-benchmarks-v3-0-7aad68bac6fd@pks.im>
In-Reply-To: <20250422-pks-meson-benchmarks-v3-0-7aad68bac6fd@pks.im>
To: git@vger.kernel.org
Cc: Toon Claes <toon@iotcl.com>, Christian Couder <chriscool@tuxfamily.org>
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
 meson.build   |  7 ++++++
 t/meson.build | 77 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 84 insertions(+)

diff --git a/meson.build b/meson.build
index efe2871c9db..205b1bb301a 100644
--- a/meson.build
+++ b/meson.build
@@ -70,6 +70,12 @@
 #      # Execute single test interactively such that features like `debug ()` work.
 #      $ meson test -i --test-args='-ix' t1400-update-ref
 #
+#      # Execute all benchmarks.
+#      $ meson test -i --benchmark
+#
+#      # Execute single benchmark.
+#      $ meson test -i --benchmark p0000-*
+#
 #   Test execution is parallelized by default and scales with the number of
 #   processor cores available. You can change the number of processes by passing
 #   the `-jN` flag to `meson test`.
@@ -204,6 +210,7 @@ git = find_program('git', dirs: program_path, required: false)
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
2.49.0.901.g37484f566f.dirty

