Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 197071A76A4
	for <git@vger.kernel.org>; Mon, 25 Nov 2024 09:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732528656; cv=none; b=gZeuYIn3ne88J3nowNSCof+egn6SS5skFO1YHbqiazrCfn631aluVsaK5Qdd5m6dG9HeZKi4NeRkzJr6UBoZbGhkF6iKzWaK38KEsWCmfOJValtXf2RrMutmfoAwmWWwSDEUOyaN72uPys95BUGuz9r1ZSGh/XL/T2fGS1nTHx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732528656; c=relaxed/simple;
	bh=VjfnEY0jEua6nEcjoeANyHkK3nezR6NwQVxTwG6PqmY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=E4pzDPmw7LA2+hvYTQzdXzPXRiF2d/Z4cAhVtQri5+bWWN+uf6iyjlzR4ALmVXwkXkv4hqrQ22gkOh3QzZnsLT5xFN2AZ+S77F9zRSnTA8IUJ/71iXVRf7LPWBe7lbha2O6T1GOaG3wwwuRiouokRJ31Q3UiIv5iOww9jl48L8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=uCybNLDO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ohWH7dz1; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="uCybNLDO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ohWH7dz1"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 2D614114017A;
	Mon, 25 Nov 2024 04:57:34 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Mon, 25 Nov 2024 04:57:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1732528654;
	 x=1732615054; bh=gd8NSiiE7h2XX3o0fI1rK6zoX2cFeoKiLsjMaaqjCHA=; b=
	uCybNLDOcEFRPuZvOJqh8OmGq17I9b+CsLLzox1yvGmNRnSYwmlYMbqfM+wY1MWi
	t0Dm2AEHpXGZk9J07PbB1ijtaTozxsP+fWHB7yow+LIHM+14t2Lgt8cJyvnhQ9l2
	9KTJSUhe9moo6hQWxAD13TVT+GNioGPTvB1pX6GghItRvVvXA7QQitHz9yk/qg92
	M/xhwcXI6iEcqlf2N22ctv083ZVMs8gSHTq6KtkvW5OP6L58pS23EcXeecRvmu+N
	lVYt4rx8IFJquArh1Ii8+5GHljqP3fb/8pTlQ9Kga7m0C8Pbnmez2bwhNj1gBSVe
	z7MiEpPoABNHHXRC6344aA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1732528654; x=
	1732615054; bh=gd8NSiiE7h2XX3o0fI1rK6zoX2cFeoKiLsjMaaqjCHA=; b=o
	hWH7dz1BujNvoiRj0EZVPFhNycIOpztLGohEIY4tNZcpDyFAZG4zJUqwLoiT9WrQ
	DxCQS38meL7jtGrsu6XpFRhL71/fcXKLRUnNuB7ef1iOnhH9PUzhIkxrzA2euOfn
	GAUsBRaKeBaSNte0MBDtDmauuwAYHnkbG/gM7tr/HyfIZz6JDNMCOxs9dJHn4Otu
	qG082HTOqFk1R/qeQ7rHs2kJg0nQphcCCTYxtN1Ze8dLMPkP+7ByHreHrxXMMbbt
	2aZjZHMygcfgFUiNa4FsYGBoN4B4Shni5BRJQ5lLwnRz2Drza8ImJta1E9RfLm2l
	Ln8Ykfy5kCsNZlwh2mK9A==
X-ME-Sender: <xms:DUpEZ74V7lHQOX5NcmqVNLP17E2nGdEv7nE8rP99AtnrKXpvTccL2g>
    <xme:DUpEZw4SBuHfrI8iAVM1rNwcd6FPZ_eEJHdDtS_vDb3wTAT6UbE5FuIiP-b01xHCM
    GkwLiMJ6KtOel2G-g>
X-ME-Received: <xmr:DUpEZyecFgR5ItpwX9ge30J0Le_e-Uvr8CNaATYH2TX5xPRPfbf-8TZ-OiAEV10iYVPCNkBDi0HefrPZ3vfrCNy5YgLnr5Z-LffJkf3QIoOKhA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrgeehgddtlecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeen
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepgeeiffeuhfejgeffjeekueegtedvgedtvdffuedugfet
    uefggfelteffudekfeejnecuffhomhgrihhnpehhthhtphdrshhhnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgs
    pghrtghpthhtohepuddupdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsh
    htvghrsehpohgsohigrdgtohhmpdhrtghpthhtoheprhgrmhhsrgihsehrrghmshgrhihj
    ohhnvghsrdhplhhushdrtghomhdprhgtphhtthhopegvshgthhifrghrthiisehgvghnth
    hoohdrohhrghdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhr
    tghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilhdrtghomhdprhgtph
    htthhopehjiehtsehkuggsghdrohhrghdprhgtphhtthhopegthhhrihhstghoohhlseht
    uhigfhgrmhhilhihrdhorhhgpdhrtghpthhtohepuggrvhhvihgusehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvth
X-ME-Proxy: <xmx:DUpEZ8LywhgkIs6kLIFAP51Mr9NGc2ICVrdPXdkXR4Zn3YX9cJJZFQ>
    <xmx:DUpEZ_JsN_RKjH2mqh95C1hUSvMlZgcFcZXm1PXUVUAeCkRTZYvymA>
    <xmx:DUpEZ1xreZOLzeNhwt19N230WABs-1e7YF4fjjE-6vENIvRJOd21FQ>
    <xmx:DUpEZ7LvlBSeffwXwSGOOKvOYXqnI6TrrTkO50ZY8C-LmPAGS-kmZA>
    <xmx:DkpEZxwN8cgQDnfPTTOzVSNLnOcdrumJXf6lT81lc4vuRwJzB9Sh-MuH>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 25 Nov 2024 04:57:31 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 6ea137c0 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 25 Nov 2024 09:56:26 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 25 Nov 2024 10:57:11 +0100
Subject: [PATCH v9 23/23] meson: fix conflicts with in-flight topics
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241125-pks-meson-v9-23-1c6cf242a5f1@pks.im>
References: <20241125-pks-meson-v9-0-1c6cf242a5f1@pks.im>
In-Reply-To: <20241125-pks-meson-v9-0-1c6cf242a5f1@pks.im>
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

  - cc/promisor-remote-capability adds t5710.

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
 meson.build          | 5 +++++
 t/helper/meson.build | 2 ++
 t/meson.build        | 4 +++-
 3 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/meson.build b/meson.build
index 6531c9b67ed2cb8cb5eac9b0be4654ddd14fbe1d..37b5ae2ece41e2ed145754f9920ed106e151ed52 100644
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
index 86076b77d2005529f58fb402e86bc95048071342..7b4f878bbdee9ae2156ff921c821e5f0db9cd6bc 100644
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
@@ -728,6 +728,7 @@ integration_tests = [
   't5703-upload-pack-ref-in-want.sh',
   't5704-protocol-violations.sh',
   't5705-session-id-in-capabilities.sh',
+  't5710-promisor-remote-capability.sh',
   't5730-protocol-v2-bundle-uri-file.sh',
   't5731-protocol-v2-bundle-uri-git.sh',
   't5732-protocol-v2-bundle-uri-http.sh',
@@ -830,6 +831,7 @@ integration_tests = [
   't6500-gc.sh',
   't6501-freshen-objects.sh',
   't6600-test-reach.sh',
+  't6601-path-walk.sh',
   't6700-tree-depth.sh',
   't7001-mv.sh',
   't7002-mv-sparse-checkout.sh',

-- 
2.47.0.274.g962d0b743d.dirty

