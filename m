Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FBD11C1F2E
	for <git@vger.kernel.org>; Thu, 28 Nov 2024 16:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732810362; cv=none; b=EKxLeGL21f7aemQrjcXeyn3NF4BX2AHkrIDZjtDYNWWHB3dfhFyNAiwyoN66vtV8kdsY61Vn4Jp7TXUPUvyTRmL6UN8/p2wgN2s8ngo6et8RGCqNWlyh2/XQNaZLmgpt4CVxurakT/OYFNgkzMZtS4vqL9CYZPveanSu+uzwXMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732810362; c=relaxed/simple;
	bh=MIVG3HJT3of2QOHuPdhXBE7bDlM0Qop/caKnhlpFDRo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=McxKypkWRgT8/OTOowEQAn5QORiJXxj5/4aqZoyOt+8ZW1XbnLgb7DGMEHKgoaZdsvwU1y2+o3+PSNw1Y0nkYfjswj+mTi3dJit7b5NNXTnYZ4cRUQmmYkPsoUrlXpHFhbKV9Kcv13XV9Ko2s7Gc2UJz9YXMTn7M7Vp+63dsjLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ChPd1QdQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fUjJ7KxP; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ChPd1QdQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fUjJ7KxP"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id EDAEE13802ED;
	Thu, 28 Nov 2024 11:12:39 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Thu, 28 Nov 2024 11:12:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1732810359;
	 x=1732896759; bh=52RI63OH3gFPnbmsGThI+MY3+EcemQD2g1AEwgMxAiU=; b=
	ChPd1QdQ14woB/qc+rD4wql/Y48RkPyt/mEAfth5cOicUvRWsoYR2aO5pUgnPrV7
	IS98Zfj9mhwTdZoC50BTh7olaTLyDBclHkvjMd/fKzI5QWCKGGTNV/k81xKM21ur
	0MwzrffoTs5SRh/YwlY8NRZCA0r3prZFJdZrpBE6yEsIPv6LUEe0ma7tQC/DjMQe
	aqpd81zSCrc5aH1zYJ5C1SmBDAQtgyXJd+KBf0KuDx1hT3dfiD6uzkoJ3xxf+J01
	VQFq4ArWuQ/XxMjGjmvdBYCY4kyxdeSj2CA1R8AdGeezB1OqAszDH79ohpCCFfoL
	sdewxdn70a/VzLAyPnJKeA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1732810359; x=
	1732896759; bh=52RI63OH3gFPnbmsGThI+MY3+EcemQD2g1AEwgMxAiU=; b=f
	UjJ7KxP6kA7IfHZGvT1HzekXB8KBszoGLaQP8uGdZy6X7W9tBBXRJgP3vohIZ2YJ
	guTjF8wbS8L5im1lFtMywSJFU8seZ4lJeh5m7LHi9JORrlleZItYvHwqQ00im0hS
	xlLRvdqhWoLv+IP0pvEK9WKUlOnPCh38YjRliL4UrwPTKSmdFTHZSWSzd6bp1xN/
	kRB0n8mgh1kFR4Sht14juFnhwxHgbfCSAEOoOjMN17H/wXDwPfaTuL+VJYMCBI3E
	KpNq55fXkwxkdry7JxqjLCtM05figTomlJaUCAoV2V3CIdL2F4INtxs8bbzMXDFa
	odki+wgFt5yEJJLZvcggg==
X-ME-Sender: <xms:d5ZIZ3JsvLM08Mv9XR8PkRb1ciTbBGwVW_MWT4NYycSHhfPE5mWqrg>
    <xme:d5ZIZ7K0tu1sBXVtUGj_DfwlPUng52XhfH4-lOay535SJPBlp2QDUenAsy8B8jNIm
    UXs7Vua_xOlNT6Ylg>
X-ME-Received: <xmr:d5ZIZ_szm0Rxkdt5aTkXWLr7eCLmTPA-3fsFUYuvVL0M6h3c6UC1qwrW9Sn_K9FzWdRawJWkGwYTlJaT6-VgD1bjDH-GTHQiGi-iwk1M8HkzJA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrhedugdekgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeen
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkeduheej
    teekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddupdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehrrghmshgrhiesrhgrmhhsrgihjhhonhgvshdrph
    hluhhsrdgtohhmpdhrtghpthhtohepuggrvhhvihgusehgmhgrihhlrdgtohhmpdhrtghp
    thhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehsuhhnshhhih
    hnvgesshhunhhshhhinhgvtghordgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhk
    vghrnhgvlhdrohhrghdprhgtphhtthhopegvshgthhifrghrthiisehgvghnthhoohdroh
    hrghdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepphhh
    ihhllhhiphdrfihoohguuddvfeesghhmrghilhdrtghomhdprhgtphhtthhopehpvghffh
    esphgvfhhfrdhnvght
X-ME-Proxy: <xmx:d5ZIZwYQEIERAyGlmLQWcwOKJbjUJ98F9kZ4uVsVF_xRzr11QC4OGQ>
    <xmx:d5ZIZ-b6B5g1zRtUVpOVoPE0nPtCkW2mRrs9zDbPT6wzO10f3W-U_g>
    <xmx:d5ZIZ0AUvychLCCTkFnS9fmSqv-CyCHggBDnKxhxl4nCXlYRhFsWeg>
    <xmx:d5ZIZ8awKjaz2yLe8PG_UH_F1ssg1G11NAE2fu777Xnr_QzAZDSXHQ>
    <xmx:d5ZIZwC3QgEH4yN8rOs21k7pk3VOuQr2HceW088aKgsE-BMSfp4N1vy6>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 28 Nov 2024 11:12:37 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 5d83d77d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 28 Nov 2024 16:11:25 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 28 Nov 2024 17:12:18 +0100
Subject: [PATCH v10 17/23] Documentation: teach "cmd-list.perl" about
 out-of-tree builds
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241128-pks-meson-v10-17-79a3fb0cb3a6@pks.im>
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

The "cmd-list.perl" script generates a list of commands that can be
included into our manpages. The script doesn't know about out-of-tree
builds and instead writes resulting files into the source directory.

Adapt it such that we can read data from the source directory and write
data into the build directory.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/Makefile      |  2 +-
 Documentation/cmd-list.perl | 23 ++++++++++++-----------
 2 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index c3d5ea1d46a57744bcacdc63b6c97911607e9fec..6c3f9b5ed13ab0b0ceae05128ec4086a7f61ca34 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -312,7 +312,7 @@ cmds_txt = cmds-ancillaryinterrogators.txt \
 $(cmds_txt): cmd-list.made
 
 cmd-list.made: cmd-list.perl ../command-list.txt $(MAN1_TXT)
-	$(QUIET_GEN)$(PERL_PATH) ./cmd-list.perl ../command-list.txt $(cmds_txt) $(QUIET_STDERR) && \
+	$(QUIET_GEN)$(PERL_PATH) ./cmd-list.perl .. . $(cmds_txt) && \
 	date >$@
 
 mergetools_txt = mergetools-diff.txt mergetools-merge.txt
diff --git a/Documentation/cmd-list.perl b/Documentation/cmd-list.perl
index 755a110bc48d7e2b596651ca13664c01192d966c..e260a989774071b66d2b56c56c5045b84a508c5c 100755
--- a/Documentation/cmd-list.perl
+++ b/Documentation/cmd-list.perl
@@ -3,12 +3,13 @@
 use File::Compare qw(compare);
 
 sub format_one {
-	my ($out, $nameattr) = @_;
+	my ($source_dir, $out, $nameattr) = @_;
 	my ($name, $attr) = @$nameattr;
+	my ($path) = "$source_dir/Documentation/$name.txt";
 	my ($state, $description);
 	my $mansection;
 	$state = 0;
-	open I, '<', "$name.txt" or die "No such file $name.txt";
+	open I, '<', "$path" or die "No such file $path.txt";
 	while (<I>) {
 		if (/^(?:git|scalar)[a-z0-9-]*\(([0-9])\)$/) {
 			$mansection = $1;
@@ -29,7 +30,7 @@ sub format_one {
 	}
 	close I;
 	if (!defined $description) {
-		die "No description found in $name.txt";
+		die "No description found in $path.txt";
 	}
 	if (my ($verify_name, $text) = ($description =~ /^($name) - (.*)/)) {
 		print $out "linkgit:$name\[$mansection\]::\n\t";
@@ -43,9 +44,9 @@ sub format_one {
 	}
 }
 
-my ($input, @categories) = @ARGV;
+my ($source_dir, $build_dir, @categories) = @ARGV;
 
-open IN, "<$input";
+open IN, "<$source_dir/command-list.txt";
 while (<IN>) {
 	last if /^### command list/;
 }
@@ -63,17 +64,17 @@ sub format_one {
 
 for my $out (@categories) {
 	my ($cat) = $out =~ /^cmds-(.*)\.txt$/;
-	open O, '>', "$out+" or die "Cannot open output file $out+";
+	my ($path) = "$build_dir/$out";
+	open O, '>', "$path+" or die "Cannot open output file $out+";
 	for (@{$cmds{$cat}}) {
-		format_one(\*O, $_);
+		format_one($source_dir, \*O, $_);
 	}
 	close O;
 
-	if (-f "$out" && compare("$out", "$out+") == 0) {
-		unlink "$out+";
+	if (-f "$path" && compare("$path", "$path+") == 0) {
+		unlink "$path+";
 	}
 	else {
-		print STDERR "$out\n";
-		rename "$out+", "$out";
+		rename "$path+", "$path";
 	}
 }

-- 
2.47.0.366.g5daf58cba8.dirty

