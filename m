Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4006117B418
	for <git@vger.kernel.org>; Mon, 31 Mar 2025 06:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743401831; cv=none; b=ElGHcBTQV3PJ3cLLA63bdg3G/fv4AilqHpIvrbd2HyTx++whw+cd333edl7W7KixYhY1Nlh6V9lVL7JVSXQ3A1dnq6n+3fn3uYOZ9lzYDr0FryJPDz2G/pQsAix5rMoknq+wPtjcWeJS6O5d6yX6qXcSLBCVlSu99sKrkeXQl8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743401831; c=relaxed/simple;
	bh=+POAV3FlKDXv0LB/OvNo3S27cHvvXouQCsHF8zMI5AQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=M4DaUohr+8IWeMw1WVQeV8dIaitteMecRXmpa5CLURdcenRL3ipzhrJS9y6vmZuL5/8b8vy38Jf6o17MobHTemtdaiCNml4E8xswX9JpdjXlISxXAqvCj+7O92K0up7EEqsNQUQYx6vmqVE9I32BPRn+YThYJrnAtpPIXky3E4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Ll8w2rva; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kdMEwDUa; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Ll8w2rva";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kdMEwDUa"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id 63C421382D2E
	for <git@vger.kernel.org>; Mon, 31 Mar 2025 02:17:08 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Mon, 31 Mar 2025 02:17:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1743401828;
	 x=1743488228; bh=WJ8ztHDcwcpvMy9diYWVBfj0AtdftmxoNpmwkNHIEfw=; b=
	Ll8w2rvau7sb60U97fzHwYv1gQVE6ppdWzeiF51qr3WRc0irCoADXk/iXfIuJnhB
	S6f3K4Rgpp3yzpmfx5AfUvAOTP3kWtO+1vWvxRkohB+1M50Td8TIq8obMvmGQb+T
	Gqb0TZVRyY0aeENcvkdD1/tAEZt0x519Cfn80gQ7sWYQIw+9LJo8XpQIHh28wMj2
	C2ciuOBwt5gEUeALQXmAMkwocn66N5kmaPF1wQLNidHvIFIDeqO8fVNY/W3aK3xV
	ieOnFL8FQIQAFSlZt9AGnrIJSr68uXn0G6eaTpIXwbdRZ1QZW9JkDp/pvpVaSwQd
	iAphPlUNEa11PeFpN/sXgw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1743401828; x=
	1743488228; bh=WJ8ztHDcwcpvMy9diYWVBfj0AtdftmxoNpmwkNHIEfw=; b=k
	dMEwDUacHnFtMMNI6Maq0IHwCk8kMhqqkt8D+jQIeSRz0vdKkF9ff9WNlSD4WVcm
	uEustRIAdLnO0hPY4498jRQwo3pSvPa/butg4t5hTDcHtAH75ErXLFdmEP8B27Rr
	PmogMNIxp+OxYTCI0AlUBD8VxqqOiXbcZ5QhP3vMdPGOuv0Kq9B1fo3pQyVU0VRO
	Q5adepTwLms5UumUO/MhDWw+a9zVFodb3t7gzDByn7s1hu2v04JGmnZDXZO77KxW
	sRDE8iG1l2bfnFWxxSBSjGkruqXDcPcchTh1Jsef9ChczseigzWMAzXRNoKEkek3
	Fgd65EyPgfOvdGECYcQoA==
X-ME-Sender: <xms:ZDPqZ2iLC28PKQ5Xdbg0pl-Y3dViaVN4bZBNmiR51f3kGA6CGtq18A>
    <xme:ZDPqZ3Dn_6LMBgUWqPtsTbnZpOUZ9b6utINjxwg3puGPhJvPcAjKjOZZc4vl9rVbA
    MuD1iEbSeThe-wuDA>
X-ME-Received: <xmr:ZDPqZ-GChMOEbBhl6LDPJruhKFtE9Xlw-T2fRYM_DFL-IEs2IK3bw7TdBKqHFhi8XkI5DHqfEt8BooW9zkItzU6Zii06Jhe3LQwCKqcOPpPva9Lx>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddujeeludekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhff
    fugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgtkhcuufht
    vghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepffeuie
    dujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
    dpnhgspghrtghpthhtohepuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhi
    thesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:ZDPqZ_RLUVe0Q2wyrMYfJISXru9SUpvNKTGI5fQZquQzL-Ey8gY5Gw>
    <xmx:ZDPqZzxTDhG_Bbv_O_W9s5LR_h-4x8M7zTaKQer8ZLB3beho-cyzJw>
    <xmx:ZDPqZ970F2ZxdyFsgPH3ISOstLn-w4p4vZr7fYTl4rs8yXENAX6Nyw>
    <xmx:ZDPqZwxIeLF7kduuShy4-LE8EqJOh_yS1mlHQ57stC5coOqUlXDQ5A>
    <xmx:ZDPqZ8phQmEQZHKN0L8IBLNX0_XYE78SlX7-LZy49xr4y05zG9lYtkWE>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 31 Mar 2025 02:17:07 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id d0d51db9 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Mon, 31 Mar 2025 06:17:07 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 31 Mar 2025 08:16:47 +0200
Subject: [PATCH 4/5] meson: wire up benchmarks
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250331-pks-meson-benchmarks-v1-4-b2ace85616a3@pks.im>
References: <20250331-pks-meson-benchmarks-v1-0-b2ace85616a3@pks.im>
In-Reply-To: <20250331-pks-meson-benchmarks-v1-0-b2ace85616a3@pks.im>
To: git@vger.kernel.org
Cc: 
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
2.49.0.604.gff1f9ca942.dirty

