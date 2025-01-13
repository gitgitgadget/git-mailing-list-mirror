Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 119FB2343A1
	for <git@vger.kernel.org>; Mon, 13 Jan 2025 08:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736757246; cv=none; b=XlxanFU7h7dBebhPznXxPQgG2+ejJzbSQ7jy/X22ARsK+JbwL47fo1czOKKSl4zj63pmdUzKVOd7iaOn6I5tThNmAWOwmxY7hH50HkUlg8Oa9qjC/T/io1ykAtyeY5yjsiI23zA9BjB0+DuLgYHAMmm16rxEvzc1eCCS018S9HY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736757246; c=relaxed/simple;
	bh=PtpNxVcpEdRpAfiEu1BNRjy4Luz6xdm90zoH+u2SvVI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UOO5S7C+P6YbzHj4/ewm/IuW8rymzU9/zako5S0q1wxMtQisK1v3bMEJhEsB2N37fgRoLA31SQTmWosawWUn7+Y/2h2TujC6oS1rrJB0aWW2tseZ6hYRCJaYntes/gHVZkFHFFS1rtXNTGREv2naeU2vfleiA5QFkwSsrCWx9U8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=PuPfyiT0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FU2TjleM; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="PuPfyiT0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FU2TjleM"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 36B12254018C;
	Mon, 13 Jan 2025 03:34:04 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Mon, 13 Jan 2025 03:34:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1736757244;
	 x=1736843644; bh=H32mhsTgL/5r5cg5hwF0U3hC8O4vO02/2SkOsjMCpgo=; b=
	PuPfyiT0jYyFXiCqipYNYw9WasTbLrId36xy2BeNWv8BSJcWr1IXS866Tke0wu5q
	zJqxwpfwad3B4p61IfmYLLJJEAr/SiMyy9/eEYQ6/4QtHhXlIw+5+NERl0/coKO5
	v6/Rr5P2DiFSajuw7hEpdqRY1eEldJN/tuexzIPtAg7JbnBO0JGCsWHzaTKD4Xpm
	cM/uEVbXl+h2XME4CdY9cgStOHG0HxOr92+OBw3poXq56ZV+lG2pFyN9msq/SfV4
	PYUUoacLoDkGFyjsWDu3LCiPaAWQ0TtUKVkwNGeMilm7eTldetjzblxC/xSO7xUu
	21DrwNr5DKrXftbi0XMeqg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1736757244; x=
	1736843644; bh=H32mhsTgL/5r5cg5hwF0U3hC8O4vO02/2SkOsjMCpgo=; b=F
	U2TjleMERibKutVHljx142LmVDEAksCegiIXNlX7ExcbokbJjBXGiMJrOrMr3tIy
	ff3C2KIEnE7MWlxycMz8wnpi615dMsrEzBwsUnMyqaH1sxo3Tr1YyhdSSL2LOXxJ
	p0HNCLC72kppGOQvm4CiWSBp7MFpUFoN2xZlpsIcnWgnlXEaaMC5n79//U6jgzmd
	JRQHaK4rM+yi9/zu5frzXzUYqJYOjSpjWqK5P6ZciY5nMxLmAJNIJ+6Do+crb3tm
	ODuIMh7PjE2gXOOARtS0R5SB7YqmHEyzWf/DATxcpoBKFgoe3hN/Q8uvHKry5Ae3
	7UYSrDryivISW4kTwcthA==
X-ME-Sender: <xms:-8-EZ4m7YXTUJR4BhWTNSoR9qA_HtUiNvvqk__K4Ph3IR3tPCeEWVg>
    <xme:-8-EZ30LXFSJ9wIPcJi_q4G3HI_zEuOpda66VwUBlUoh4wkRAQBpGmOfHO_Qyy6On
    8smhwTTQudFOLCTpg>
X-ME-Received: <xmr:-8-EZ2qKH5JKxLnLkw4STCAqj79ro__hDq8gsuBMY5D_iuy2eO3lDxjZSCZ0HQ40VmyxszPC4yDggmkSu4TL7jdF-5-ASO0MVPG_JBHFOmVC1zJ8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudehfedguddulecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredt
    jeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkedu
    heejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopegvvhgrnhdrmhgrrhhtihhnsehgmhgrihhlrdgtohhmpdhrtghpthht
    ohepvghstghhfigrrhhtiiesghgvnhhtohhordhorhhg
X-ME-Proxy: <xmx:-8-EZ0mXZFiFoUT5ORcz6m9HdE-bCCqOVWCIZ4DPbKcCnC5vvyayCA>
    <xmx:-8-EZ23ETwQOG7QYlFiiiM8jrfNV5DDAxTK8VGY-oEMMwKbOZsVRRA>
    <xmx:-8-EZ7ss05tAHBntdIKAHmZCk15bE0RSjyZ69LGaWPgpq4M31Cd1ww>
    <xmx:-8-EZyWfG-w1O4xU-8sY1Z4nvirIJmBeStFGnhuyJRcMTnQZd8lKWw>
    <xmx:_M-EZ7xOsMDxAeAsgmoTp0aG5iLJDkJFn8iJsqM9UzV4qqVKbYcASHLO>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 Jan 2025 03:34:03 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id f1375057 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 13 Jan 2025 08:34:02 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 13 Jan 2025 09:33:39 +0100
Subject: [PATCH 6/9] meson: wire up fuzzers
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250113-b4-pks-meson-additions-v1-6-97f6a93f691d@pks.im>
References: <20250113-b4-pks-meson-additions-v1-0-97f6a93f691d@pks.im>
In-Reply-To: <20250113-b4-pks-meson-additions-v1-0-97f6a93f691d@pks.im>
To: git@vger.kernel.org
Cc: Evan Martin <evan.martin@gmail.com>, 
 Eli Schwartz <eschwartz@gentoo.org>
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
index 76667a1277720d74e09e8da227b5e0832003e0e2..6c828c3b755153dab179f73346e7124bda49c90e 100755
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
index 771bdded484a0c0e8638e7c6555e3f4e09e64025..5e1373f6a52a91beb527d00d8fd5c55d377c718b 100644
--- a/meson.build
+++ b/meson.build
@@ -1899,6 +1899,10 @@ if get_option('tests')
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
index 89b01bad042b533b23e0e2b4b780ce152ee688c8..34ba679cf931b67a794a9bb7e765bfb22106381e 100644
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
index 0000000000000000000000000000000000000000..ed79665501655eae4948623c07114fab23a55393
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
2.48.0.257.gd3603152ad.dirty

