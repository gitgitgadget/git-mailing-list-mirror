Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9553518A6A3
	for <git@vger.kernel.org>; Fri, 15 Nov 2024 07:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731655316; cv=none; b=ChH3E0cvQ8zHvOCK/OlT5LGS1Ns9q5hpd16hn2v59Xjfk917i82K3mFWHfUPte7eLz2fKL9G13safXU2MXYUkJZGrHoYzZOeuRLRCCCKtLJT6AYx0TazbSyUG5Vghs1xu96nMAVl48tTfCTN/07N3Xl8WFYzO8gYqOMfXCV+Tto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731655316; c=relaxed/simple;
	bh=weXFrS1k2W1KI0yHcrhAlxFWa4n+OBrMS5h4TdCyauk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WTEGKLa+kflUGFrkCNkp1tPh9LtQWI11t+hDxjG97zN4Caz+HQ6yn+nVx3nsN1FARu3e2yDxUJCcDgaJHPdKIOWaTqclxS1tF+rCKQeQhtt9qHV2ZO+Dd49ZGg/cJf4drR4pT7P92PQRIqNwS2Ig9JcROql1WaJQIuv8S81XX5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=tJ4/xwpA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EdQBQI9x; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="tJ4/xwpA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EdQBQI9x"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id B71C41380604;
	Fri, 15 Nov 2024 02:21:53 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Fri, 15 Nov 2024 02:21:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1731655313;
	 x=1731741713; bh=FTuK41+7EJKdu1VD5UikTuZUDEo+V2zk63dqmQCCBaU=; b=
	tJ4/xwpA8TPkLY1yXCM1F3Eo1GPx/p3FRVqaFz8tmHzvRBKqEDCYlDEoZDXA4Bgw
	EZ3crVb5vpOWiPFE+JQzVGZklTLK+GPF/He/0fWUsJ1LnEX/hJN+9a9J0VsbJRkx
	JgNXWM7Pa8Macl+YFRDXH7J7+84ZZYJzEKxNpxCchW/qGaFwx3ghMyWZOh7sG8B8
	InzxQ5Cy4uz+Bv8Q++dEW1hWx20sP1KQogsMcsMQbJNmMm+9GhN0bVjNtmoXaXw4
	0oXbiHDiD4KpUte+7VwLmJtsmoBMHQuP6/DwSmlvTDT13efHfEEnqMVWgu/vo0TW
	rnMlDC/xiQ/xwzKpl88Z8A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1731655313; x=
	1731741713; bh=FTuK41+7EJKdu1VD5UikTuZUDEo+V2zk63dqmQCCBaU=; b=E
	dQBQI9xg8xJOdE/2dagGHChhmeuNq+AO1ajA6YoYWpi0rVhAF4AYlaK3qKCtzeEH
	NhY5OZ5Pw3K1nZZfan6GI1f0XQDefiYVJSNZ8NUey12w4WpIX7fX0B8ol7Mn93IR
	BA4nwHfu7oPNRMFl2V4JWjIPv3CEvyae2aR7Ru3vmGk14ymjwbAGqpcZz5RDHS7V
	DhbdVIXnhHTSTscH8eAg9tPkpvJJ1lPf5fh/QlyynKLKsOYkeqmU24Hy24da4fXF
	XdR7gNhGM0DK4rfcrKHrb6SCitlczc0lJsm5yLitINMt0prrFjPo1Y8068WpEYgw
	QfsN9JVPwyFeRJ7SJ3CRg==
X-ME-Sender: <xms:kfY2Z_K1i-m2E9-Bpz0_BJwMQHKkO-16FbL4l8_MlfQG0HK5gEt36g>
    <xme:kfY2ZzIAAtX1wq5RP4XP2bwoG2T-OPfoOzVVu4Z59Y1oAvk42s4FxnlsP7D0Cg-VE
    PpHkSYdVrWPUb4mxg>
X-ME-Received: <xmr:kfY2Z3tZf_88T434wnfU1LueZk7g3jR5CWita1vMWEd5_XYPFvU8L8gF16mL9GmRyJPlfyW45KUUcksbY97QH1ih7etqUHlJmyHmeex6j1nF-Lrwig>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrvdefgddutdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdej
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeegieffuefhjeegffejkeeugeetvdegtddvffeuudfg
    teeugffgleetffdukeefjeenucffohhmrghinhephhhtthhprdhshhenucevlhhushhtvg
    hrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhn
    sggprhgtphhtthhopedutddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepuggrvh
    hvihgusehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidr
    tghomhdprhgtphhtthhopegthhhrihhstghoohhlsehtuhigfhgrmhhilhihrdhorhhgpd
    hrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilhdrtghomhdprhgt
    phhtthhopehrrghmshgrhiesrhgrmhhsrgihjhhonhgvshdrphhluhhsrdgtohhmpdhrtg
    hpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehmvges
    thhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepshhunhhshhhinhgvsehsuhhnshhhih
    hnvggtohdrtghomhdprhgtphhtthhopegvshgthhifrghrthiisehgvghnthhoohdrohhr
    gh
X-ME-Proxy: <xmx:kfY2Z4YH5Z-qCs_CVtJRjWFXpdLNd0mcsYZW_d_keUzTnThzSDb9nQ>
    <xmx:kfY2Z2ZcEjl-YtbGhATZ2FEtv9xCGg8E9GHVPxks1lkJSJWUSkCoQQ>
    <xmx:kfY2Z8CXw-71_tRd3NPDMDcD609szbXoR9PbMb9Cuxk-_ttM8sDpNw>
    <xmx:kfY2Z0auOzs0CSFdUUbOylOHGvlL0SpTMbHIg71dVmO6TWfk5L-yvg>
    <xmx:kfY2ZzTUAFE4B-zHDqcNlWNxAC2yw7SYMuZ87pB5RDR09Hh37UhtjD2G>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 15 Nov 2024 02:21:51 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id cb9fb554 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 15 Nov 2024 07:21:09 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 15 Nov 2024 08:21:34 +0100
Subject: [PATCH RFC v7 22/22] meson: fix conflicts with in-flight topics
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241115-pks-meson-v7-22-47ec19b780b2@pks.im>
References: <20241115-pks-meson-v7-0-47ec19b780b2@pks.im>
In-Reply-To: <20241115-pks-meson-v7-0-47ec19b780b2@pks.im>
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
index 17974eafdd86d9c1b6696868f1497b71caa165a3..f5f6bd183f187540a9a0aa1e02d276d819f54d7a 100644
--- a/meson.build
+++ b/meson.build
@@ -217,6 +217,8 @@ libgit_sources = [
   'commit-graph.c',
   'commit-reach.c',
   'commit.c',
+  'common-exit.c',
+  'common-init.c',
   'compat/nonblock.c',
   'compat/obstack.c',
   'compat/terminal.c',
@@ -255,6 +257,7 @@ libgit_sources = [
   'ewah/ewah_rlw.c',
   'exec-cmd.c',
   'fetch-negotiator.c',
+  'fetch-object-info.c',
   'fetch-pack.c',
   'fmt-merge-msg.c',
   'fsck.c',
@@ -329,6 +332,7 @@ libgit_sources = [
   'parse-options.c',
   'patch-delta.c',
   'patch-ids.c',
+  'path-walk.c',
   'path.c',
   'pathspec.c',
   'pkt-line.c',
@@ -369,6 +373,7 @@ libgit_sources = [
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

