Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C291622DF91
	for <git@vger.kernel.org>; Fri, 25 Apr 2025 07:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745566104; cv=none; b=TqvvcOgj8cVILMXh2hqXHqSy0rcTtyF7GjniE9Mar6DFqbzKo6ul0AreRfNC7V9k8nCaD9tlEmOQGVdV3mq0UQJBCXzIqccy1EmSY92nroBezVIjxRBtzawhsKYC/sMo8VMBxCQXu/R2Uoq0uM4XcGRVUZD7UU9U6ai85CELUkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745566104; c=relaxed/simple;
	bh=C18Rz9ppXiUfZKmXXrC9ZsXDJ9G0KZvRYUrJNo4XiME=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rishetivejq055tf9PjS57lDBRH6JJIHsY6X3w4bKLVPEMoYMSTnTGgjU2b7e14UQrxrEly5PEOzP2FGrEpSa6KwCF3JYH0b6MV/X7gACsIi9VMrz9UUD+BQAmXYR2echQMrKGXZygtyrZrlH6PDwJxbEpgGhZSu1FmXMPq2cK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=fHKqGlPn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GmSeHukk; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="fHKqGlPn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GmSeHukk"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id CE7351140209;
	Fri, 25 Apr 2025 03:28:21 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Fri, 25 Apr 2025 03:28:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1745566101;
	 x=1745652501; bh=eI2NpY/I6QVprXPtdijK9DsMO35ZImQ6TYmWht72S1I=; b=
	fHKqGlPnMY/7d+86bg1gY2G1tKPlrf9Qky1oYjoOpKCrdxjGtyVcdPeB1gdCQ2fC
	bGETtPGVQuzcWmx0Ho4e38kYmVqT4bbcXeA/qDWhOk9ZoRs+lqbvRyL74Pn9+z5g
	85xSVPZKrifx70CV3sxJEBUr+05KblOxIBUYqRYaunzfrv4dBheWM5YtGL05Jq+L
	iU+cBswZ7ILMDLGvm745oLN3xjX0U7bOv2Dvkd5aK3vMPAW/JldS+mCH9JQHKyMD
	5fZkMqByGCc321lVIiXKMffwcKNkkwoTDPEU/GEUXKbYIe4++EIXqpCUDmLWJw0i
	nvBoZxwJH83f/iFvky1FAA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1745566101; x=
	1745652501; bh=eI2NpY/I6QVprXPtdijK9DsMO35ZImQ6TYmWht72S1I=; b=G
	mSeHukkZt7Xy+yw0DYkk3Au3FH7+Otu92QC+7GZ3YJKcHM+NAqTJdo8r0uKNxIzp
	BWdkvBmgBbgsgNCICBcSli89bhuonoUz1MOL/D2iBV/QkMZ9MurHxirhcE0q5M3I
	5ry8ziVCU2Jp64j9kcVx/CUZP5pkaXHkLFgaXS0mVED+ZOYRlKoXFyHFWB7r3IF0
	uJwSACeLPHvCFdF/uXP7C/Gji27Ax+xagZj/cuLH+CtR9+MLpBrYazY9sH44vu2I
	M6LhffDTlsr5hbU41Ngpu6nTamFLiS4X6V0kzNX5vKb4vsgc+M0TkD5esdrUANwL
	1GSBCJD6yzyqJTmrAlrmw==
X-ME-Sender: <xms:lTkLaPBUQLeFwDGGfa0aaPYiV1qk3rkcA8sQ7LbUQelAM9DlL5eyMQ>
    <xme:lTkLaFjm6YcdBSWaqK4eAGIawZkQEk6PUw_5fcDd5NpU1Y8r75_vYDxNOXtZWYNj3
    Wf7ivfNZJh0p1tJbA>
X-ME-Received: <xmr:lTkLaKl7CqR-r9mw_vpSXDA75519REJlZ32DzRlpc9cJbJ7kyNtN-asDh-qlmUTHXF1Pk9r0Pxj5_UlmQG5rVej-nfr4PzBTJWbYjGrw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvhedujeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteek
    udehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopegthhhrihhstghoohhlsehtuhigfhgrmhhilh
    ihrdhorhhgpdhrtghpthhtohepthhoohhnsehiohhttghlrdgtohhmpdhrtghpthhtohep
    ghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkh
    gvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:lTkLaBzpPxaWW94WIN-jYo_FXxxakWQvSG6sVVM3K2RPftgDgY6NuQ>
    <xmx:lTkLaEQtuU6XjQlaWUuRiR1vPUT47004flrkrITuT8lj_kvchex8Nw>
    <xmx:lTkLaEb6GRebeydzeL1hVBaeCjvhi-exqYYUUg-NgYdwgyuAG1V84g>
    <xmx:lTkLaFQFEAwPhO5CF-3QT6fw5Ls3f3S5DuSQb_YTrOkx93TPnV2m-g>
    <xmx:lTkLaL0cWw1oAKEcAidh49QvoL8TNuSIWl0hx8fbDXj3FtcPiakjhYQF>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 25 Apr 2025 03:28:20 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id ecf23695 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 25 Apr 2025 07:28:20 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 25 Apr 2025 09:28:16 +0200
Subject: [PATCH v4 4/5] meson: wire up benchmarks
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250425-pks-meson-benchmarks-v4-4-6b89555052c3@pks.im>
References: <20250425-pks-meson-benchmarks-v4-0-6b89555052c3@pks.im>
In-Reply-To: <20250425-pks-meson-benchmarks-v4-0-6b89555052c3@pks.im>
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
 meson.build       | 10 +++++++-
 meson_options.txt |  2 ++
 t/meson.build     | 77 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 88 insertions(+), 1 deletion(-)

diff --git a/meson.build b/meson.build
index 410bbf93dad..2cd05a9b1ba 100644
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
2.49.0.901.g37484f566f.dirty

