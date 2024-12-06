Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 343D420E6E7
	for <git@vger.kernel.org>; Fri,  6 Dec 2024 13:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733491546; cv=none; b=WQCsNFgsM9N78XVpA9+zOVtqcPugKeXUe6qyD6mV+CSHjHUO6PXrXwGkAUml77ZCx+UtQixqjM9nVp3T5bL/1Yh3P9wIQ4ubmJ4EcxjL3Dl+soFblncA4kYl3pd6CtQjYaf3PnppHxNXkE+y0fAF7xDXozwvOq4CSmxCsAxE0Bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733491546; c=relaxed/simple;
	bh=L8rsWItIUGll7Foaz9aP+k30slrwSf6LV2080tWfKvU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lvAp//q/zvppgp0ThOQJXphtcrV7L5bgepYu7dck+mUlcwwjadtjZn1j4hpoIcrLyeHDPVZNC44jYmy6l2lkZcs+CPgTBuZ41dySkC9E/68gQT+I8XVN0BtKxr3Yp71RA/3nSfaRnfUHROjFonux2wBqIHTwD9YRmsuBkK6y+CI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=E85DbB/k; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dJfuXNwY; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="E85DbB/k";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dJfuXNwY"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id 1ECE511401D3;
	Fri,  6 Dec 2024 08:25:44 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Fri, 06 Dec 2024 08:25:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1733491543;
	 x=1733577943; bh=281R7dXtY50f5N5iEVFa8Nvg05Kz/4/480WaS5ncv58=; b=
	E85DbB/kXk4bB2d5PkoHJNHxuL5JiFA1tXiXzdI/TQElDhMOSvkr6tgF3zop6qau
	s0xGEZ5xTFZNl2J8NgLqrnnZot9Z34qgslO624cOEkOl+TBov8Kj0nhXK4Y7E4IC
	fTx16Ln8vXjAujbU+cBRRD/NPvL4TJc8TUKZ/QyWOAMD26tjuhuOyH5dIupILRdy
	0lv3EQ8kYFY9vurgQfZVU8TVcIXB1wn0QgHhu1AfURpXVPrnmBDsgIIApoClZ6HP
	HY8/4LRGJCN5wRA11dKYlOcxyCwpwzXJIDaF1fg62gEnXY1pHtKSkqEKprLy7u+j
	0tIy0XmUr/SLGGTKzrrhSA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1733491543; x=
	1733577943; bh=281R7dXtY50f5N5iEVFa8Nvg05Kz/4/480WaS5ncv58=; b=d
	JfuXNwYFRF/xxhn2I4KYY9Pm3YdRiCD61EIZ0D6Y31natJetkO8pprIKNGWMcTNS
	/WMxbN582Qwqo6xO4/ZvsJ+14OGpu8p9FpMWuu4PYn1URgZE2trF28Mw1IiShog9
	mE8i2QvElYmvPR4tvt9NRSsEVil+B+lpbvr4PreKle4mmsEqdwcc9papQPDJQTP/
	X67gtcylP8/kfMS3AFr5h2SGrP9Z82FWaHvQLKV7ZBQsLTjB/mfEpl3xSi81kVoN
	lLDHmxhDPOBROUwm05EglwrGpbSCElNCUaY6i863ntBQjymlkbWmKbjDV9+Hj+Vf
	UsF8lnh1YrsfOvZeRWUhw==
X-ME-Sender: <xms:V_tSZ7imyAAMK5uo4vbkiUjI1Pos2cwTcCRmQJZTNblMYl6Aaxiwzg>
    <xme:V_tSZ4BoziRlyX8s5lDQ_y2hg61HttCoWXupTvyQMj5fbMbdaKUBUGK4SLRzOLowj
    Np13--cWWbzYFmf9g>
X-ME-Received: <xmr:V_tSZ7HWJWsiP9smQ9yO9VAyxdX9GVgbXF1jwuPrwKRYlgw93mMLrDq8GTmOcVGliVJEHbDErbWrYFhBlh1TQMGYTewEzBB2KtkUif8lzIFnUA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrieelgdehtdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeen
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkeduheej
    teekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgepfeenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddupdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohepshhunhhshhhinhgvsehsuhhnshhhihhnvggtohdrtghomhdprhgtphht
    thhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepjheitheskhgusghgrdhorh
    hgpdhrtghpthhtoheptghhrhhishgtohholhesthhugihfrghmihhlhidrohhrghdprhgt
    phhtthhopegvshgthhifrghrthiisehgvghnthhoohdrohhrghdprhgtphhtthhopehrrg
    hmshgrhiesrhgrmhhsrgihjhhonhgvshdrphhluhhsrdgtohhmpdhrtghpthhtohepuggr
    vhhvihgusehgmhgrihhlrdgtohhmpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtg
    homh
X-ME-Proxy: <xmx:V_tSZ4TbDkw0ATylnu1Y_j0CaJ5xgHYjC1qoN4WcfubvWlEK7yadkg>
    <xmx:V_tSZ4zTf83Io2PPRcwGIp48ZJfZ1uM5VSe_lNClApUSLBLzLnn5qA>
    <xmx:V_tSZ-52c0Uu0Ji9JARSG618StDpL4mDf0RazO3Wt1TTNK1KAxkTFw>
    <xmx:V_tSZ9wICcltMIfU2h78yywFWrURxZ_aNlaRtcad70B9N63NOAuSzw>
    <xmx:V_tSZy4hreu-1PJMw5QyrJzGYu-7D1Y0ngBjOv_BQAQXzbvSf3lFlObR>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 6 Dec 2024 08:25:41 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 60f2cdd3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 6 Dec 2024 13:24:14 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 06 Dec 2024 14:25:00 +0100
Subject: [PATCH v11 25/26] meson: fix conflicts with in-flight topics
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241206-pks-meson-v11-25-525ed4792b88@pks.im>
References: <20241206-pks-meson-v11-0-525ed4792b88@pks.im>
In-Reply-To: <20241206-pks-meson-v11-0-525ed4792b88@pks.im>
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

  - js/libgit-rust adds "common-exit.c" and "common-init.c".

  - ds/name-hash-tweaks adds "t/helper/test-name-hash.c".

This is somewhat painful in the current state where Meson is not yet
part of the main tree, but we'll have to live with that for the time
being.

I've split this commit out into a separate fixup-style commit such that
it is possible to test this topic both with and without "seen" merged
into it. You can simply revert this commit to test without "seen".

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 meson.build          | 4 ++++
 t/helper/meson.build | 2 ++
 t/meson.build        | 2 ++
 3 files changed, 8 insertions(+)

diff --git a/meson.build b/meson.build
index 0dccebcdf16b07650d943e53643f0e09e2975cc9..442d7bbabf407aee00cce280f40a4d5527f18d9c 100644
--- a/meson.build
+++ b/meson.build
@@ -235,6 +235,8 @@ libgit_sources = [
   'commit-graph.c',
   'commit-reach.c',
   'commit.c',
+  'common-exit.c',
+  'common-init.c',
   'compat/nonblock.c',
   'compat/obstack.c',
   'compat/terminal.c',
@@ -273,6 +275,7 @@ libgit_sources = [
   'ewah/ewah_rlw.c',
   'exec-cmd.c',
   'fetch-negotiator.c',
+  'fetch-object-info.c',
   'fetch-pack.c',
   'fmt-merge-msg.c',
   'fsck.c',
@@ -347,6 +350,7 @@ libgit_sources = [
   'parse-options.c',
   'patch-delta.c',
   'patch-ids.c',
+  'path-walk.c',
   'path.c',
   'pathspec.c',
   'pkt-line.c',
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
index 13fe854ba0a18f9b83dbc48651f581198042ffd3..1c82e27a1d48dd6a163d7b26c74b5ebf6f258d41 100644
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
@@ -829,6 +830,7 @@ integration_tests = [
   't6500-gc.sh',
   't6501-freshen-objects.sh',
   't6600-test-reach.sh',
+  't6601-path-walk.sh',
   't6700-tree-depth.sh',
   't7001-mv.sh',
   't7002-mv-sparse-checkout.sh',

-- 
2.47.0.366.g5daf58cba8.dirty

