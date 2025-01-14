Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03070243325
	for <git@vger.kernel.org>; Tue, 14 Jan 2025 11:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736855784; cv=none; b=OBRPwTrWser7ocd5y3NmbQLucJ8emfUlsBsacZWtH/qSkRRny3vaesSQRhIt8uJi36VXtz8Spt8bMZLkAln5ZzTzDAE5qVFsjSqegbPSia2tQHch+u9qZOpzLx8a9mLikbdDDGzOAMG/MOjAYq+3yk3QuvdJpNxL013tXsoC2Ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736855784; c=relaxed/simple;
	bh=p3U/Q1YUmlJi8irPErJ8hExxM6ngOvRMchGGMSFu/EU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QHVBGFq7oEvohNfmt6E9ELLfMeLGUbN26gQpwiGykgA1z3PZ+tLrGuy8okgRdxN8CJvZvq/FngtS6QxnPNwKrcNBCDIrui666P37c8xomnYUGCKdLE94D278lEenxaCBMhBIshnwbC0wxH7EJx9y+w4SEdkjSlFaVo/qrkfgVJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=oTtnR4Pa; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HZiOhCLd; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="oTtnR4Pa";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HZiOhCLd"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 0B0FF138029B;
	Tue, 14 Jan 2025 06:56:22 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Tue, 14 Jan 2025 06:56:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1736855782;
	 x=1736942182; bh=tGW0u5900v7aoumL6YmDh64gT5842dDFdXHh9GFbFMM=; b=
	oTtnR4PaNQp4YOl8z0HX3j7DXoLG+EsThrkzJCv77cuNXyHmg0bR6vtqpx0wwCb9
	8rYSS78gi5sJDgIhLlolEl9WELGkK87qzVtq12WdRd5O2qHoyO2IGKm7yyJJgNrv
	QazqFV/F3Wn2GcIhJfFM0hSYSoVMSDxQtBuIGqsFPHGKN+cRVyZVD7dhxg+r96yO
	n7mD8/Q7oobelh9loPA/Du4xlkKtAUHh2fwhIGrwnpSuhmLQxuhhZTA8NnN87eWm
	4Nz2Lf4iTatdQQFsCrMyiDRQs7t4HIq2Acuy0Y8Fe3ZWvYdEHOfNA4m2qnshRqP+
	p0r3avQ/HirleawRcPSU4w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1736855782; x=
	1736942182; bh=tGW0u5900v7aoumL6YmDh64gT5842dDFdXHh9GFbFMM=; b=H
	ZiOhCLdjs5N6TrK7pPVjLI1oaysFIzU6nbsTfvl+2wLfX5ZUYYREpLyurkQqAuNg
	qSUfGlgz/Qu/tZiCK1h+hEYFHRZlNE9M2A6f9GOL/lPpGASdH0nx/vfQXKQAZ6Sz
	pcWEcWU5UR5sRj7WIm9xp5xYHUjEt4WP0cS4WDQZN+T+T4iOQd3JaserCf08cbMx
	kxKSWaS7ZFVlThayht5xGLGYE8hjiJZTfX6/4en8rc3aGhUQmxLlbHEWxxJMOGot
	0xVmVDabmQxoEbq2HvkmjjP+S7cF1FXCcsvk2f+tzmSmBHpnb7A7AGPtxeed4ASC
	i7O2fjscL2aZHHRLPWg8Q==
X-ME-Sender: <xms:5VCGZ1ANSl8rqNLQL3Atte7OXxD7Zglnwchc0QEGoOD1nEEMM3lsAw>
    <xme:5VCGZzinMwju0pVlDC52Ay1-ldPNo99cWOB8yyhMteLcabmQu6tvASm-73OpZiMZB
    CducKvBedbWoMNRsQ>
X-ME-Received: <xmr:5VCGZwnbOpV-SA9PU7YCSiGgzDtQMGr2BWfLcXw9WXtV9RkMmRY3NJNm2Qwb-9jJwO5lBRAXKLX7-SnUzp97dJIfi6CjrdBNKRQJKFHdUMT1uA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudehiedgfeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdej
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteekudeh
    jeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeehpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopegvshgthhifrghrthiisehgvghnthhoohdrohhrgh
    dprhgtphhtthhopegvvhgrnhdrmhgrrhhtihhnsehgmhgrihhlrdgtohhmpdhrtghpthht
    ohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehmihhrthhhrdhhih
    gtkhhfohhrugesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgv
    rhhnvghlrdhorhhg
X-ME-Proxy: <xmx:5VCGZ_zECGoJzMzS-oBWIC5MeFcGqZvKShhxhxtAPdUH3V1GCyRSuA>
    <xmx:5VCGZ6QLSmPmKJokH5jK76rr6CNGtnhZI3Z3ni8AnOnxKcLI_dNd_A>
    <xmx:5VCGZybpEkFCa4IK91qxQZFWeStNsc8K7o6SnWST9-LKwXGp8_Wj1g>
    <xmx:5VCGZ7T6KgjvE-Kbwbryb5UZMfTsTgSD9xhXy5-kulOXSnc-FNyOjg>
    <xmx:5lCGZ3LlcZzsaNlW5GmVK9gwWiqssKemBHC2tcjIzxidU9WWaBmgzbCT>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 14 Jan 2025 06:56:20 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id cae2bbda (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 14 Jan 2025 11:56:19 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 14 Jan 2025 12:56:17 +0100
Subject: [PATCH v2 07/11] meson: wire up fuzzers
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250114-b4-pks-meson-additions-v2-7-8d7ec676cfd9@pks.im>
References: <20250114-b4-pks-meson-additions-v2-0-8d7ec676cfd9@pks.im>
In-Reply-To: <20250114-b4-pks-meson-additions-v2-0-8d7ec676cfd9@pks.im>
To: git@vger.kernel.org
Cc: Evan Martin <evan.martin@gmail.com>, 
 Eli Schwartz <eschwartz@gentoo.org>, Junio C Hamano <gitster@pobox.com>, 
 M Hickford <mirth.hickford@gmail.com>
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
index 5d074134195e5689d08da5597f0859d9623d014e..95baada74af8f7731867e7075d9986b32a034ff4 100644
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

