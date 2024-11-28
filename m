Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A185D1C32FD
	for <git@vger.kernel.org>; Thu, 28 Nov 2024 16:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732810365; cv=none; b=pSlCE2VylCscLBPgoPA0FWEk8c3PMEWA+2SURW926UYyD/ZMpWx0Cad2DTMqsqPuTaFsnkXOwY5t9+Xh9C2wRgR4OIDciYyMW/yYh4+1sW2nwJ+3fT8hCQJ4sJvHM12hjhXfy9J97mEN3bRH5pb9ATAMOUOLbFXNdRpMvQvP/Ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732810365; c=relaxed/simple;
	bh=2d0nNYqdfBPugbssBILs+9GxSJUlvZAfajzzfW0RHTM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qSwgllwu2fvaHLPNXiv/Uu2U+fj2OyO680FE5aUVDq4TIu3Nklyt6Zf8ROja5bkUm0c/ywjWut9Myp0sjUy1AhQQy/jw+s67cDzjg+LGaGmmS0p+C3wfN+buspr0bXpl6WSrGxmJP4PqWQJibEnxjqmnwA2hbvSMOh23aWc7aIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=sbLdOibq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UfeBueH5; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="sbLdOibq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UfeBueH5"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id DB02B1140143;
	Thu, 28 Nov 2024 11:12:42 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Thu, 28 Nov 2024 11:12:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1732810362;
	 x=1732896762; bh=wkb8AJInaEFG2Dao2fWN8pNqrfre7HfWsbAnsUGezCQ=; b=
	sbLdOibqjbYGNSGB8vGkM/4Rcd1Z4Y7Dx1yGlPnfxb9NPHl2XZOhXEK+p0fziwWG
	azwxRrI8Z7n87SReVEQkIggo5xvHM9yqSUVGD+EbnZyrznJgMqH4QMpAQsEe0Snf
	Yzoo4ePDq1BgeJ5wKqnuhnfUF2dJf9GJE1IAvYIKJ2e0qAPeZNxBr8h59yz13YZQ
	4jgsm8cmOqvAIVO9ch91hjW7gPZtqdAioY/xyo770d5fVYMVBYl0Ng151rKAdvyF
	l5vL1k777lm2RiiXRk11npMi3Fkb0oTl+ikJAkoWu3RB3Xz13B5rF15nKNUL/Ert
	PKyj8VHUkTAd8sqetCeTBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1732810362; x=
	1732896762; bh=wkb8AJInaEFG2Dao2fWN8pNqrfre7HfWsbAnsUGezCQ=; b=U
	feBueH566eIQoiBLtxhm/SXhLmMKMgoAH0bHLGBWwgAwSQDV/QYc617DJIONazQX
	GE+BdqpldPI6hN4kgdaL0sNc6bcJyu7TecKCUY3uIpMBOABIDc+PQFq6dr6TLyvJ
	TfMrcQtHYRiDznGqm/htO2clUnQ5qpgG6y8mW3eePLIRPOQE04hHt1QsMaseTpoe
	IBH2LIS3J1XtAgLovnreedd/i19rVILQgKsRppAxVDVi3XREaHc5vlmcaU2M0aSy
	HyDePfv10Xnx9mZdkXzbsBvJB0puX8gLvMGRJb7KSZGiIvK+ClH/AHaI3Mlhfru8
	fF6GpChgACnn9CZhoH2zA==
X-ME-Sender: <xms:epZIZ_lnKUvZPUWcN6HkIaxVnjDYWflwGU29Cwfr2cMEupADgRX1dA>
    <xme:epZIZy0XjUM-E7x-AvBP3eSHi4BxIPa2JJmgcSm-4ydfEnc61BjjgzBvwP_c8N_kP
    rqvaw5Zgftsy37HWw>
X-ME-Received: <xmr:epZIZ1qkweCeMXR1zUhhQ7aYPSdQprAsCS_8RxoJoNodR4B9zMGZXBowEqR4myVPjY1JZ6qQTscvOqJUS1zBB7lCPUkWCS8UumNoFDSFqDIa-g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrhedugdekgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeen
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkeduheej
    teekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgepfeenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddupdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopegurghvvhhiugesghhmrghilhdrtghomhdprhgtph
    htthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepshhunhhshhhinhgv
    sehsuhhnshhhihhnvggtohdrtghomhdprhgtphhtthhopehphhhilhhlihhprdifohhoug
    duvdefsehgmhgrihhlrdgtohhmpdhrtghpthhtoheprhgrmhhsrgihsehrrghmshgrhihj
    ohhnvghsrdhplhhushdrtghomhdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpd
    hrtghpthhtohepvghstghhfigrrhhtiiesghgvnhhtohhordhorhhgpdhrtghpthhtohep
    jheitheskhgusghgrdhorhhgpdhrtghpthhtoheptghhrhhishgtohholhesthhugihfrg
    hmihhlhidrohhrgh
X-ME-Proxy: <xmx:epZIZ3lC93-4TXKmTyf3_y9z6iZx0Ot1GmJWDI4ZHcrVIAbz09FjFw>
    <xmx:epZIZ93HzxPyzIajtJn7bQYz7r7HncbL8JjskVHv1Xw-rOEj1Y8xCQ>
    <xmx:epZIZ2tDq4MA8He_hpkzu7GOMsisuGYurx55O7KKz1IIdrUreVGK8A>
    <xmx:epZIZxVov1F4RiDuw98IPP51DJoot7YaRCCCsNnTPv8Doh4tk16ppg>
    <xmx:epZIZ-sGFbB8HQc7A2clw0vS35Mb9lHuq-CAhvbJ-1FXVyHu9wudlCpO>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 28 Nov 2024 11:12:40 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 6da5ce7b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 28 Nov 2024 16:11:30 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 28 Nov 2024 17:12:24 +0100
Subject: [PATCH v10 23/23] meson: fix conflicts with in-flight topics
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241128-pks-meson-v10-23-79a3fb0cb3a6@pks.im>
References: <20241128-pks-meson-v10-0-79a3fb0cb3a6@pks.im>
In-Reply-To: <20241128-pks-meson-v10-0-79a3fb0cb3a6@pks.im>
To: git@vger.kernel.org
Cc: Eli Schwartz <eschwartz@gentoo.org>, 
 Eric Sunshine <sunshine@sunshineco.com>, 
 Phillip Wood <phillip.wood123@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>, 
 Ramsay Jones <ramsay@ramsayjones.plus.com>, Taylor Blau <me@ttaylorr.com>, 
 David Aguilar <davvid@gmail.com>, Jeff King <peff@peff.net>, 
 Johannes Sixt <j6t@kdbg.org>, Christian Couder <chriscool@tuxfamily.org>
X-Mailer: b4 0.14.2

As support for Meson is still in-flight we have to accommodate for
conflicts with topics in "seen". The following conflicts are being
addressed in this commit:

  - ej/cat-file-remote-object-info adds t1017 and "fetch-object-info.c".

  - ds/path-walk-1 adds t6601 as well as "path-walk.c" and
    "test-path-walk.c".

  - ps/reftable-detach adds "reftable/system.c".

  - js/libgit-rust adds "common-exit.c" and "common-init.c".

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
 meson.build                 | 7 ++++++-
 t/helper/meson.build        | 2 ++
 t/meson.build               | 3 ++-
 templates/hooks/meson.build | 2 +-
 templates/info/meson.build  | 2 +-
 5 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/meson.build b/meson.build
index 6531c9b67ed2cb8cb5eac9b0be4654ddd14fbe1d..055c0671e9bc834062aff99e1e4e3ea3e54ad088 100644
--- a/meson.build
+++ b/meson.build
@@ -238,6 +238,8 @@ libgit_sources = [
   'commit-graph.c',
   'commit-reach.c',
   'commit.c',
+  'common-exit.c',
+  'common-init.c',
   'compat/nonblock.c',
   'compat/obstack.c',
   'compat/terminal.c',
@@ -276,6 +278,7 @@ libgit_sources = [
   'ewah/ewah_rlw.c',
   'exec-cmd.c',
   'fetch-negotiator.c',
+  'fetch-object-info.c',
   'fetch-pack.c',
   'fmt-merge-msg.c',
   'fsck.c',
@@ -350,6 +353,7 @@ libgit_sources = [
   'parse-options.c',
   'patch-delta.c',
   'patch-ids.c',
+  'path-walk.c',
   'path.c',
   'pathspec.c',
   'pkt-line.c',
@@ -390,6 +394,7 @@ libgit_sources = [
   'reftable/reader.c',
   'reftable/record.c',
   'reftable/stack.c',
+  'reftable/system.c',
   'reftable/tree.c',
   'reftable/writer.c',
   'remote.c',
@@ -1694,7 +1699,7 @@ foreach alias : [ 'git-receive-pack', 'git-upload-archive', 'git-upload-pack' ]
 
   install_symlink(alias + executable_suffix,
     install_dir: get_option('libexecdir') / 'git-core',
-    pointing_to: 'git-remote-http',
+    pointing_to: 'git',
   )
 endforeach
 
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
index 86076b77d2005529f58fb402e86bc95048071342..1c82e27a1d48dd6a163d7b26c74b5ebf6f258d41 100644
--- a/t/meson.build
+++ b/t/meson.build
@@ -177,6 +177,7 @@ integration_tests = [
   't1014-read-tree-confusing.sh',
   't1015-read-index-unmerged.sh',
   't1016-compatObjectFormat.sh',
+  't1017-cat-file-remote-object-info.sh',
   't1020-subdirectory.sh',
   't1021-rerere-in-workdir.sh',
   't1022-read-tree-partial-clone.sh',
@@ -306,7 +307,6 @@ integration_tests = [
   't2405-worktree-submodule.sh',
   't2406-worktree-repair.sh',
   't2407-worktree-heads.sh',
-  't2408-worktree-relative.sh',
   't2500-untracked-overwriting.sh',
   't2501-cwd-empty.sh',
   't3000-ls-files-others.sh',
@@ -830,6 +830,7 @@ integration_tests = [
   't6500-gc.sh',
   't6501-freshen-objects.sh',
   't6600-test-reach.sh',
+  't6601-path-walk.sh',
   't6700-tree-depth.sh',
   't7001-mv.sh',
   't7002-mv-sparse-checkout.sh',
diff --git a/templates/hooks/meson.build b/templates/hooks/meson.build
index 5bbb1bd483f24e05f826918fe63391ef72334e11..ef85e10a16ccd6c5569b8fc25210d6481025f33f 100644
--- a/templates/hooks/meson.build
+++ b/templates/hooks/meson.build
@@ -21,6 +21,6 @@ foreach hook : hooks
     output: hook,
     configuration: template_config,
     install: true,
-    install_dir: get_option('datadir') / 'git-core/templates',
+    install_dir: get_option('datadir') / 'git-core/templates/hooks',
   )
 endforeach
diff --git a/templates/info/meson.build b/templates/info/meson.build
index 7af5ddd24985fc0a5888961939ae3b2758f2aaa8..026f2313858c24e30a9bf115ee0f58144a593729 100644
--- a/templates/info/meson.build
+++ b/templates/info/meson.build
@@ -3,5 +3,5 @@ configure_file(
   output: 'exclude',
   configuration: template_config,
   install: true,
-  install_dir: get_option('datadir') / 'git-core/templates',
+  install_dir: get_option('datadir') / 'git-core/templates/info',
 )

-- 
2.47.0.366.g5daf58cba8.dirty

