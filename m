Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6CCF212FAF
	for <git@vger.kernel.org>; Wed, 22 Jan 2025 12:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737547563; cv=none; b=U7HJYl6yb2BgqK2zOcpeJ60BjESDqg2l6iTWpbr1hNuxGwVWDkMXBCV8QpKfYoJHRYzLllMkNcp81g+nqXeNAm59qT7cChyVGvszBoZ4OAF+0iwpcRlBltnVaH8ARMCqMNZL9eOrANSuBzbqF+7/m65L1rHZ+bckocwpGY8oiVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737547563; c=relaxed/simple;
	bh=N+XoOzYVZuLkxy5Fh7yv3Xm0mltfMthdUKtcJSlQcXY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oLb5GuzmcpuqinS40VpSc2PEP0B9fYjAJ2KTHBRjMEMHV7VL6OtRNfd4XIY6fzUc620UJNrZZ0JM3n3PMQ78qDLgc5MBmnLvfh37X7vQ7Q/88nKm+dv956oz9LP+reF6di9G67JavwuaR0eXT1Dd9osoSfBiqRfdzIwrWB9Oq40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=EqARDA7r; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iIUuYVqH; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="EqARDA7r";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iIUuYVqH"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id D3295138083C;
	Wed, 22 Jan 2025 07:06:00 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Wed, 22 Jan 2025 07:06:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1737547560;
	 x=1737633960; bh=dvAsikl8hB7dJ6Z5hiVOt+KQZBQJfI4ebexqeAEvvFo=; b=
	EqARDA7rMq6p95CDH3woDD+8LVJMZJGVYduPF8P3ykRAYg/DAbSSu42JYBZCf+ni
	B14Hn61XdxYN6gtSLHpwCIRi4y0VfoEe3zRDLYxOoX2j8cBSOMjAZ1qimkF4gaVR
	c9J4GJUrZdP9logRM62Z5+vZBvenMGTij2CHwZN8xZUZyulkqm6d7FSKrUI9zeFC
	XP7LQe9o65QlCjvB6Omb5Vp3gPnq+mqoPRhiTMywoHTmEtzViQ9oJPH9dFzm7ITX
	xJjPqjCfhrn1z7hsGxHM/O4IXHaShoiwP0A7OvIlN/sHCZtOH8aHbl8sQnTRPfyQ
	/hvlVHqmhee663YQj68Ibg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1737547560; x=
	1737633960; bh=dvAsikl8hB7dJ6Z5hiVOt+KQZBQJfI4ebexqeAEvvFo=; b=i
	IUuYVqHPYiNaT8XMaqYfy3obNwoHCS3zBYSOReGmEwG14qJrv1QSPSzn0+nTZxG9
	HszFNwi1Zc6nHUdgkzMH1aky5LvFjXgS3fUz/G76N2EWgUfFuZV1FTUm1hP5K338
	ifae1vrjm99NIZl9JipbkJIeCVQfIw5cyrarEXaESxMpFQSTbfCMm34ABhEqZQmB
	YfKbNYkg4HRuShpHZX5l4Qxm60xmzmotJ/lOKD62Dftg/g8vzB4WYx7SqtFfrnwR
	KoVp9zTWQhkNUQHx6pYeHFAiQbDKZeNF0jbWGBzmVbg4guwsBqAr9ckHi5Bg+pq7
	JJX1TlAmxvu1ejIjWT/kw==
X-ME-Sender: <xms:KN-QZ_6ihxZPdYqVupto2UFTfi5XTsRrgzaXZeo28ZGHbsqWWASD2w>
    <xme:KN-QZ062TkLK7hH0AvJD6MQ7_CuyW1omy_Fe5iqmLikQxpZBoWJoM9rbkgJlZZLL4
    61ZOAuxly9yfs641w>
X-ME-Received: <xmr:KN-QZ2cLlp5v2P9PGULEoD6JeqNlrrRQdIT1U4CgDq704z-6cIVPy4cubNjBmI62niYHN8ecsizFGqKGbZL6THu3QclfFak58yor0x_uovPaSpM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudejfedgudeiudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredt
    jeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkedu
    heejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepiedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepthhoohhnsehiohhttghlrdgtohhmpdhrtghpth
    htohepmhhirhhthhdrhhhitghkfhhorhgusehgmhgrihhlrdgtohhmpdhrtghpthhtohep
    vghstghhfigrrhhtiiesghgvnhhtohhordhorhhgpdhrtghpthhtohepghhithesvhhgvg
    hrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegvvhgrnhdrmhgrrhhtihhnsehgmhgr
    ihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:KN-QZwLR-G0glhFD9vflQ2nYIf7nFYpaa06vgMqD8dyMKn4CpY-JEQ>
    <xmx:KN-QZzKO1AQkl0i7DhDeNFc0IAVGkeeCbTle8SH_pKLrJpJm1NLBzg>
    <xmx:KN-QZ5wTQPktdG6uW2lbTcxpsPkRfY517LqXIIRv8iM2lvdG5la9JA>
    <xmx:KN-QZ_ISVIDzQBvdvO-P0EEtV8prCeoRfnknD5tQQZfl0u_xQGGu3w>
    <xmx:KN-QZ7_DO45RDwVssOdSURjjYWQnlG94e4YwEEzokbYdQNRshf4SnVtv>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 22 Jan 2025 07:05:59 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id d9be6ea5 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 22 Jan 2025 12:05:54 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 22 Jan 2025 13:05:50 +0100
Subject: [PATCH v3 07/11] meson: wire up fuzzers
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250122-b4-pks-meson-additions-v3-7-5a51eb5d3dcd@pks.im>
References: <20250122-b4-pks-meson-additions-v3-0-5a51eb5d3dcd@pks.im>
In-Reply-To: <20250122-b4-pks-meson-additions-v3-0-5a51eb5d3dcd@pks.im>
To: git@vger.kernel.org
Cc: Evan Martin <evan.martin@gmail.com>, 
 Eli Schwartz <eschwartz@gentoo.org>, Junio C Hamano <gitster@pobox.com>, 
 M Hickford <mirth.hickford@gmail.com>, Toon Claes <toon@iotcl.com>
X-Mailer: b4 0.14.2

Meson does not yet know to build our fuzzers. Introduce a new build
option "fuzzers" and wire up the fuzzers in case it is enabled. Adapt
our CI jobs so that they build the fuzzers by default.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 ci/run-build-and-tests.sh |  3 ++-
 meson.build               |  4 ++++
 meson_options.txt         |  2 ++
 oss-fuzz/meson.build      | 20 ++++++++++++++++++++
 4 files changed, 28 insertions(+), 1 deletion(-)

diff --git a/ci/run-build-and-tests.sh b/ci/run-build-and-tests.sh
index 76667a1277..6c828c3b75 100755
--- a/ci/run-build-and-tests.sh
+++ b/ci/run-build-and-tests.sh
@@ -53,7 +53,8 @@ case "$jobname" in
 *-meson)
 	group "Configure" meson setup build . \
 		--warnlevel 2 --werror \
-		--wrap-mode nofallback
+		--wrap-mode nofallback \
+		-Dfuzzers=true
 	group "Build" meson compile -C build --
 	if test -n "$run_tests"
 	then
diff --git a/meson.build b/meson.build
index a59072edf5..052bd80ac4 100644
--- a/meson.build
+++ b/meson.build
@@ -1906,6 +1906,10 @@ if get_option('tests')
   subdir('t')
 endif
 
+if get_option('fuzzers')
+  subdir('oss-fuzz')
+endif
+
 subdir('bin-wrappers')
 if get_option('docs') != []
   subdir('Documentation')
diff --git a/meson_options.txt b/meson_options.txt
index 89b01bad04..34ba679cf9 100644
--- a/meson_options.txt
+++ b/meson_options.txt
@@ -95,3 +95,5 @@ option('tests', type: 'boolean', value: true,
   description: 'Enable building tests. This requires Perl, but is separate from the "perl" option such that you can build tests without Perl features enabled.')
 option('test_output_directory', type: 'string',
   description: 'Path to the directory used to store test outputs')
+option('fuzzers', type: 'boolean', value: false,
+  description: 'Enable building fuzzers.')
diff --git a/oss-fuzz/meson.build b/oss-fuzz/meson.build
new file mode 100644
index 0000000000..ed79665501
--- /dev/null
+++ b/oss-fuzz/meson.build
@@ -0,0 +1,20 @@
+fuzz_programs = [
+  'fuzz-commit-graph.c',
+  'fuzz-config.c',
+  'fuzz-credential-from-url-gently.c',
+  'fuzz-date.c',
+  'fuzz-pack-headers.c',
+  'fuzz-pack-idx.c',
+  'fuzz-parse-attr-line.c',
+  'fuzz-url-decode-mem.c',
+]
+
+foreach fuzz_program : fuzz_programs
+  executable(fs.stem(fuzz_program),
+    sources: [
+      'dummy-cmd-main.c',
+      fuzz_program,
+    ],
+    dependencies: [libgit, common_main],
+  )
+endforeach

-- 
2.48.1.321.gbf1f004a4a.dirty

