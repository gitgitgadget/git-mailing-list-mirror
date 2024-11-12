Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CD5A218D81
	for <git@vger.kernel.org>; Tue, 12 Nov 2024 17:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731431028; cv=none; b=hdL7AXnaWyuTwjiZ5SOgr7T6HvSGf16Sr4d0WPCaZOL8ym4OCDCoV/4hOAJW00Fn0fb5mxz5jCEN+nFv6fxAI7TiYQ2nwyFsP0Pmp3QDkqwksBamEDqskyAnsjNMGef2qYW1RWs83Feij1MOo9OCUPUszTxTMC+xjvgKrHoG6D0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731431028; c=relaxed/simple;
	bh=TnRWBPX1C0E6d/GxMgfHEyj7qlZdceOEbMNGepXG04M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PsfrWDRQ8w/d58H4gpli7TkGNBmkPgDPC9XkmxV3bvrjhyLidiA422szCFz27OyBW+C7w7oOsHQu+ehlhaoowtEcu2b3udIoENDjq2Zu4et57K46cuzJ6grcl2VmIculGH8R5hueAiMZFJIG5rgQNnLsbXxVS5bBG0xc2RxbqkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=qaICHRVb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Mt2D3d6V; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="qaICHRVb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Mt2D3d6V"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 6DC1A2540181;
	Tue, 12 Nov 2024 12:03:46 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Tue, 12 Nov 2024 12:03:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1731431026;
	 x=1731517426; bh=mjMsVC2gNiraNicRHK+MUsz9MwzGlg/iwy0aT1SGs50=; b=
	qaICHRVbDoEB+0vRAKV+5BJ4nVmh4/FVHB9IuslplWkjqJv5THB42eDLvOAbazXB
	gjKIOCFT7nmsbhmNv5FaoFVpCunJ+iTmNvolz8Br+XDvNrEK4YiHhxeT6zGs/c+X
	qiYpOUp0ZLXqCfeHiMNzBQI2EQyNmdBI5nRpsUP7oDe71zF8QQxuR9hYAkexPFUy
	NF86+5mLPJClDxH845f2D/au6BxqdQX3xJJPPCS7V/a4Xc68Q88GxFfcO+CkzEkb
	oSthYlK//h02ytbEbtkpCqpxIX3PqhTJaEA/yJm1XDkzh83mgLtISbXCrIxFcymw
	l47+LDydrX6MsDVxHYoTSw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1731431026; x=
	1731517426; bh=mjMsVC2gNiraNicRHK+MUsz9MwzGlg/iwy0aT1SGs50=; b=M
	t2D3d6VEWuKk4EVvc0ojwPZHgwLFhZ4vJ6exSffTb98TSsVXmyTbyxvRM/IAGl+B
	XA2VCTeB0Xds7EjaRqL4QD16Dlva/dr/oDMl6yvmO10ztObY+l/CJqtthZmmJbW1
	kZFgbmcKUD3e/57XpjMz0rGdv2Yni8Qenmbyo1xL06Ibw9b3/2F4zKlwjCMrJQtg
	mwYjHQLSCUxowEuXCU/k54dQyOMX0dqG6fnkqCh6U8GzfWdLAVGWnJSlvKFYbGAd
	SMY6nR/zUeSWv7kUvJG6F+ma0xyeDzHjO4cbVO81ZAbRvfJW25xCNrRl8z42qbou
	wWy6zBlLCFxenSRtZ5rxQ==
X-ME-Sender: <xms:coozZ84Uauivn1gxmWPQjJbbv803j7YmuAfBxvW-hFglLKzH2qFjig>
    <xme:coozZ94Lul1RKlH0aTU7o4avulSL_0WqCtlkx6wK5LLfrTN56sg7LZSH1wW4235IK
    L8g5YDOw2TFB8CjWQ>
X-ME-Received: <xmr:coozZ7fZ6Hq_gBp4JWVbXRTjDWhdu1dhH-yJ7022FkNIws4QkogWTyZez7MnlIGTzm2eoPb5um9QFipNju_9pdh4gNoHQKXPJxWv0J_B7J4MfyU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudeggdelvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeen
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepgeeiffeuhfejgeffjeekueegtedvgedtvdffuedugfet
    uefggfelteffudekfeejnecuffhomhgrihhnpehhthhtphdrshhhnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgs
    pghrtghpthhtohepledpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprhgrmhhsrg
    ihsehrrghmshgrhihjohhnvghsrdhplhhushdrtghomhdprhgtphhtthhopegvshgthhif
    rghrthiisehgvghnthhoohdrohhrghdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrd
    gtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthho
    pehphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrdgtohhmpdhrtghpthhtohepgh
    hithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghvvhhiugesghhm
    rghilhdrtghomhdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtoh
    epshhunhhshhhinhgvsehsuhhnshhhihhnvggtohdrtghomh
X-ME-Proxy: <xmx:coozZxKJVjQ_obcyN_t1Yzb7IHoOEvkBuUr126AAFn60xRGJvqRc3w>
    <xmx:coozZwJN2jzjz04C3cUXMcoVZGXoTfLtWRwi8l02hvvb_Ck_rZPoSA>
    <xmx:coozZywy4UR_PdagSQqmNNipWmJ4SrtEmu0cDcddnnVunjlfMTrEOA>
    <xmx:coozZ0J2I4J9nSfztcMPV2rmx-6w95SX3xXMFrJUKOGezAMNvwjTIw>
    <xmx:coozZ1USSPAM_7vU1GYbM3hQEpiOxotcSXkQTLZDtVciJEbBnmpqVTPC>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 12 Nov 2024 12:03:44 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 69814b06 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 12 Nov 2024 17:03:06 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 12 Nov 2024 18:03:02 +0100
Subject: [PATCH RFC v6 19/19] meson: fix conflicts with in-flight topics
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241112-pks-meson-v6-19-648b30996827@pks.im>
References: <20241112-pks-meson-v6-0-648b30996827@pks.im>
In-Reply-To: <20241112-pks-meson-v6-0-648b30996827@pks.im>
To: git@vger.kernel.org
Cc: Eli Schwartz <eschwartz@gentoo.org>, 
 Eric Sunshine <sunshine@sunshineco.com>, 
 Phillip Wood <phillip.wood123@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>, 
 Ramsay Jones <ramsay@ramsayjones.plus.com>, Taylor Blau <me@ttaylorr.com>, 
 David Aguilar <davvid@gmail.com>, Jeff King <peff@peff.net>
X-Mailer: b4 0.14.2

As support for Meson is still in-flight we have to accommodate for
conflicts with topics in "seen". The following conflicts are being
addressed in this commit:

  - ej/cat-file-remote-object-info adds t1017 and "fetch-object-info.c".

  - cc/promisor-remote-capability adds t5710.

  - ds/path-walk adds t6601 as well as "path-walk.c" and
    "test-path-walk.c".

  - ps/reftable-detach adds "reftable/system.c".

  - js/libgit-rust adds "common-exit.c" and "common-init.c".

  - ps/clar-build-improvement adapts the awk(1) script that generates
    "clar.suites" to instead be a shell script.

  - ds/full-name-hash adds "t/helper/test-name-hash.c".

  - cw/worktree-extension deletes t2408.

This is somewhat painful in the current state where Meson is not yet
part of the main tree, but we'll have to live with that for the time
being.

I've split this commit out into a separate fixup-style commit such that
it is possible to test this topic both with and without "seen" merged
into it. You can simply revert this commit to test without "seen".

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 meson.build          | 5 +++++
 t/helper/meson.build | 2 ++
 t/meson.build        | 9 +++++----
 3 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/meson.build b/meson.build
index 58f131bdb0e388697ca1b3455945239ad6343af2..321e681f8bd75984dac80102ea4cc85d44c76d80 100644
--- a/meson.build
+++ b/meson.build
@@ -220,6 +220,8 @@ libgit_sources = [
   'commit-graph.c',
   'commit-reach.c',
   'commit.c',
+  'common-exit.c',
+  'common-init.c',
   'compat/nonblock.c',
   'compat/obstack.c',
   'compat/terminal.c',
@@ -258,6 +260,7 @@ libgit_sources = [
   'ewah/ewah_rlw.c',
   'exec-cmd.c',
   'fetch-negotiator.c',
+  'fetch-object-info.c',
   'fetch-pack.c',
   'fmt-merge-msg.c',
   'fsck.c',
@@ -332,6 +335,7 @@ libgit_sources = [
   'parse-options.c',
   'patch-delta.c',
   'patch-ids.c',
+  'path-walk.c',
   'path.c',
   'pathspec.c',
   'pkt-line.c',
@@ -372,6 +376,7 @@ libgit_sources = [
   'reftable/reader.c',
   'reftable/record.c',
   'reftable/stack.c',
+  'reftable/system.c',
   'reftable/tree.c',
   'reftable/writer.c',
   'remote.c',
diff --git a/t/helper/meson.build b/t/helper/meson.build
index 5e83884246edc7841738de5085f3255aa1fa3fbe..1d6154ce9756db17bc9f69bc3cd71a32b93857c5 100644
--- a/t/helper/meson.build
+++ b/t/helper/meson.build
@@ -34,12 +34,14 @@ test_tool_sources = [
   'test-match-trees.c',
   'test-mergesort.c',
   'test-mktemp.c',
+  'test-name-hash.c',
   'test-online-cpus.c',
   'test-pack-mtimes.c',
   'test-parse-options.c',
   'test-parse-pathspec-file.c',
   'test-partial-clone.c',
   'test-path-utils.c',
+  'test-path-walk.c',
   'test-pcre2-config.c',
   'test-pkt-line.c',
   'test-proc-receive.c',
diff --git a/t/meson.build b/t/meson.build
index 9ec0b7fa34a033d508448dbd56ab2322a5106fd0..8f0ba136eeb0558f866d7fd3f0559d94139d4777 100644
--- a/t/meson.build
+++ b/t/meson.build
@@ -19,9 +19,8 @@ clar_sources += clar_decls_h
 clar_sources += custom_target(
   input: clar_decls_h,
   output: 'clar.suite',
-  feed: true,
-  capture: true,
-  command : [awk, '-f', meson.current_source_dir() + '/unit-tests/clar-generate.awk'],
+  command : [shell, meson.current_source_dir() + '/unit-tests/generate-clar-suites.sh', '@INPUT@', '@OUTPUT@'],
+  env: script_environment,
 )
 
 clar_unit_tests = executable('unit-tests',
@@ -168,6 +167,7 @@ integration_tests = [
   't1014-read-tree-confusing.sh',
   't1015-read-index-unmerged.sh',
   't1016-compatObjectFormat.sh',
+  't1017-cat-file-remote-object-info.sh',
   't1020-subdirectory.sh',
   't1021-rerere-in-workdir.sh',
   't1022-read-tree-partial-clone.sh',
@@ -297,7 +297,6 @@ integration_tests = [
   't2405-worktree-submodule.sh',
   't2406-worktree-repair.sh',
   't2407-worktree-heads.sh',
-  't2408-worktree-relative.sh',
   't2500-untracked-overwriting.sh',
   't2501-cwd-empty.sh',
   't3000-ls-files-others.sh',
@@ -719,6 +718,7 @@ integration_tests = [
   't5703-upload-pack-ref-in-want.sh',
   't5704-protocol-violations.sh',
   't5705-session-id-in-capabilities.sh',
+  't5710-promisor-remote-capability.sh',
   't5730-protocol-v2-bundle-uri-file.sh',
   't5731-protocol-v2-bundle-uri-git.sh',
   't5732-protocol-v2-bundle-uri-http.sh',
@@ -821,6 +821,7 @@ integration_tests = [
   't6500-gc.sh',
   't6501-freshen-objects.sh',
   't6600-test-reach.sh',
+  't6601-path-walk.sh',
   't6700-tree-depth.sh',
   't7001-mv.sh',
   't7002-mv-sparse-checkout.sh',

-- 
2.47.0.251.gb31fb630c0.dirty

