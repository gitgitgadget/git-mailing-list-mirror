Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1068C1CD21A
	for <git@vger.kernel.org>; Tue, 19 Nov 2024 11:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732017079; cv=none; b=iWmbJgq6lnhd6nBElq/Mg7j4ub50tCFYOaUyGKiwaevYwqRjRpsmX4rQMqetQ+FLJ5K/O3HQTuSKwzflmGWnd05pM9DjUEVrE75kHohYMuSxDWEl5tdQ83cuzdTamsWzTdUTH93N4Zp0rOzzfx6JPDtrBfGiNS1dY5NiADTzjBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732017079; c=relaxed/simple;
	bh=I8U42lQZ2zaESjAaXD7xHkxijv85fbFtqF3owoJ2a9M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=StWq15t+itr1Oed3Vp4xsKQEz4Wc9ZxrzIt1wcyfGUIV7d0tJf9VDMaXoMmoI7og2qxXro+2bo78iFN4mpXgthFDr5vO4rG9EOgCWsEpJC4kaFZ2wxoL0XaGCAuqqneP5NAoL1saFrGfAczCJ5wcRs0nlrnhSgEbyR1BuV2gGKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=roDDmy03; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=aFAF43G3; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="roDDmy03";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aFAF43G3"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 4E1DA11400EF;
	Tue, 19 Nov 2024 06:51:16 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Tue, 19 Nov 2024 06:51:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1732017076;
	 x=1732103476; bh=YimsbkAUwD5K++s+P7D8r+M+9qQWVecbUyxnfCa/rIU=; b=
	roDDmy03l3Ip2nGec6mOeY7jCJa9gaDSVtgNEkMeuzx5InnELfO+Ss3p3Mc/RI5B
	bQHX9WsBTK47LTt2kPRrCpI7OFI2slxZQRnuiPpvKLK+LrSy/usUIqWAvcCYQrxY
	j8KXqi0cead7S0iIEh9sDTrT097KfBHEtT0oPCBN3mIQtFCzptrYxYHy/KgIfa2B
	Tx3o6tj3q+AAOUqSyZq5cQE0wzZ5apZ/oGiGRsOqJFAzZfBLc+tn84TUDhEVjVrQ
	AvDFJRP5cGfFz+FKOGILFLd7ogHdRfiMcB3Z3NWtzfN8tnKrzOWRQWhOcor+XKv1
	OT28ORjnBxF1g9cQLACI5g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1732017076; x=
	1732103476; bh=YimsbkAUwD5K++s+P7D8r+M+9qQWVecbUyxnfCa/rIU=; b=a
	FAF43G3rvNWzk3f+t4Lv1kn60mFzOdmolcAVfmOMb1iF9VATX6j8i15cwJgw5MZx
	OTAYWd4HuNpt93BF4EuoC2IuJS0x6HaBKVceHFweC/OGCvQz7XFQT/TCo0i+raDA
	eyQmwkmR/ziCrGXR2yu7wZpFhxCo3fW+EMftTGTFP5jSQtS+KioEzgFVNVD96Jcx
	xpbr0pMgcTT/dSfiBNVjEH6YMJd70RcYqIjxQF1O07zc47p4uaq8cHIbPkWYracq
	9a/OkD4kuF2wxUUnSuYizTYKVpbl5PxdSaVnC/Z4oAVrBoNubHpoqJMhoUXgmWKg
	ZRHCbQ5IfdAaLn+48RmUA==
X-ME-Sender: <xms:tHs8Z5AkTyQGO2fIRYPa5BQbaaCDPdNJnuexB6KioOfgRjxi3Yx0Hg>
    <xme:tHs8Z3gNQm3anqmnl9yv-_Q8aCiitMK4JFxYfjT_RjivzS0ix_HW5L9jJuy_LHbyV
    U62eEXBU15x-vKrNQ>
X-ME-Received: <xmr:tHs8Z0nkOU9Zr-Q_7tzvhq_MEtj1wzkYkNVgHzXvglTnhUKK8GcjF3J7k8X5a5IVCfN_LYRO-e5IHGe1iUcH6eMXeRQxyxVNP5OILOKjnAL7710>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrfedvgdefvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeen
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepgeeiffeuhfejgeffjeekueegtedvgedtvdffuedugfet
    uefggfelteffudekfeejnecuffhomhgrihhnpehhthhtphdrshhhnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgs
    pghrtghpthhtohepuddtpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpvghffh
    esphgvfhhfrdhnvghtpdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhm
    rghilhdrtghomhdprhgtphhtthhopegurghvvhhiugesghhmrghilhdrtghomhdprhgtph
    htthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepvghstghhfigrrhht
    iiesghgvnhhtohhordhorhhgpdhrtghpthhtoheptghhrhhishgtohholhesthhugihfrg
    hmihhlhidrohhrghdprhgtphhtthhopehsuhhnshhhihhnvgesshhunhhshhhinhgvtgho
    rdgtohhmpdhrtghpthhtoheprhgrmhhsrgihsehrrghmshgrhihjohhnvghsrdhplhhush
    drtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:tHs8Zzw178R3gY3WucZtJztHPDFZSd3zMcoK5jpD2AZAqlUjZOtzcA>
    <xmx:tHs8Z-RWQRvl4zAohM2yNDksseeT9Lmt62Czg2wXhKXTmgfEKJZF8w>
    <xmx:tHs8Z2Zz-aH_rgqkA5C0X2Rk7Xt8OGEnf1FuAo1XkvzJtS_saW2ZNg>
    <xmx:tHs8Z_RXiV3X7jcvnNqUUlsxkuF53NFWpXaOsUMxllGSI9PQMPmXXQ>
    <xmx:tHs8ZzJq-93rIWuJkIQrPfhsxOAQX-fSrkriZ0urg8eC2es4qS-jzeAp>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 19 Nov 2024 06:51:14 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id a4c69b08 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 19 Nov 2024 11:50:25 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 19 Nov 2024 12:51:00 +0100
Subject: [PATCH v8 23/23] meson: fix conflicts with in-flight topics
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241119-pks-meson-v8-23-809bf7f042f3@pks.im>
References: <20241119-pks-meson-v8-0-809bf7f042f3@pks.im>
In-Reply-To: <20241119-pks-meson-v8-0-809bf7f042f3@pks.im>
To: git@vger.kernel.org
Cc: Eli Schwartz <eschwartz@gentoo.org>, 
 Eric Sunshine <sunshine@sunshineco.com>, 
 Phillip Wood <phillip.wood123@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>, 
 Ramsay Jones <ramsay@ramsayjones.plus.com>, Taylor Blau <me@ttaylorr.com>, 
 David Aguilar <davvid@gmail.com>, Jeff King <peff@peff.net>, 
 Christian Couder <chriscool@tuxfamily.org>
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
index 5c6a4212b04174247db173860edd01926576d3e8..a7adae7b1a146e7a55ae27788ac92066d3b05d26 100644
--- a/meson.build
+++ b/meson.build
@@ -239,6 +239,8 @@ libgit_sources = [
   'commit-graph.c',
   'commit-reach.c',
   'commit.c',
+  'common-exit.c',
+  'common-init.c',
   'compat/nonblock.c',
   'compat/obstack.c',
   'compat/terminal.c',
@@ -277,6 +279,7 @@ libgit_sources = [
   'ewah/ewah_rlw.c',
   'exec-cmd.c',
   'fetch-negotiator.c',
+  'fetch-object-info.c',
   'fetch-pack.c',
   'fmt-merge-msg.c',
   'fsck.c',
@@ -351,6 +354,7 @@ libgit_sources = [
   'parse-options.c',
   'patch-delta.c',
   'patch-ids.c',
+  'path-walk.c',
   'path.c',
   'pathspec.c',
   'pkt-line.c',
@@ -391,6 +395,7 @@ libgit_sources = [
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
2.47.0.274.g962d0b743d.dirty

