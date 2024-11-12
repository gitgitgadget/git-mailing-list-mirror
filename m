Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 682912185A9
	for <git@vger.kernel.org>; Tue, 12 Nov 2024 17:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731431024; cv=none; b=T9ddB8akN1M/skUPwLe9s0hSjU0epLG45OywLx4kuT9rwmBj8/46bmJm+AFdNnH19Ci2PQrcqHfuZx+wZqjkjgSad23TFglB3PoZPzTgVTQu/DJSMcqXW59lVrOPlq1HcjLEZZBSyL5gvVjT66Oepl0NFEWn5Z0aUFi2NZoOW88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731431024; c=relaxed/simple;
	bh=sbT/kOa0wYpkEGF7SmukEwvdobfR8+Z9oEd14THGsHs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Wqj9YZzAN6fvGjVQQHwBSjflLf54lX5iHVkjEB63AJ2Zd2qcTk0sUcoL3T1gwOamCDLyPe4JZJ5mC4L/YVCfQ1aLtfvO/KjQuVLJbTLXyMaLaJy18Q4BapUN49L192qjIEvifaPlIdvyuE8g549iFTOhiHQM1YDC/zFq+GgDVCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=qSfbjXSB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OGlNVg8A; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="qSfbjXSB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OGlNVg8A"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 68D5E114013A;
	Tue, 12 Nov 2024 12:03:41 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Tue, 12 Nov 2024 12:03:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1731431021;
	 x=1731517421; bh=lzf2C9DQgg4dYHQp9dskrow902tGffVsVuSY5NKP9x0=; b=
	qSfbjXSBDW3UEW+VMkm3JNvh+0s2L43fHZ9S4aTHHq0OER/85xdxi8rZQfDX/OGb
	LzUj//XQYa+dVh3HPBuD2iyNUaSgO89Cmniu8nbGtEA5Mo/bT52VNBFE96b3vwPn
	thB3m+oEQ2QKHtSjMLkZFXeCHQdWt6Wx0HS9lVF3x7Eyr4/Fy+igIZPsSBeB/Y+v
	W9LcvihrqT9DXZMtbqUP+osCGu+IG9GwP2xPH8ZXR/ibTrwsaHUqxvU+Osv6nBQa
	HJ9qoOwtDIj9En6d1Aki5x9gTF4iUo4WK0J87UXsMXRFdqwkrojJbxmoY5HfUZoq
	JaxmYoGH2eT7RgyFULBXZQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1731431021; x=
	1731517421; bh=lzf2C9DQgg4dYHQp9dskrow902tGffVsVuSY5NKP9x0=; b=O
	GlNVg8Ab3fe0JxBPUXiTf09BGd9FWcTk7qsF2QfFwjarwXF3im1wti3KjI6SWwFO
	Wpmg/g25ZGC4WbyyNMKrXk6wrZPwRUsaDPbm2zaZr+AQ3cfMU/wtlV7GuaBM85Pb
	nnJVputkojzTgVYE6kgbSAeWz8eDUYQSkxnzFDYqkQrntB7NpuYn+fZZK8ciGwPR
	WVWBUajNNTPFGncmHOIrrc7ytgnZPB/YzbJFgR3dPKnUDFVWP3v9ODNMwzHp4xEc
	5ajZVAM4EbKxfrJA3olVtJIAidYru5LG9rjJq7KzmDlVywr/5dpr6gkF/eeDJiqq
	dM4tzx5cjR1RjtSYLFnUQ==
X-ME-Sender: <xms:bIozZ0vJtNurDmydH_HB_nlyEjK6xMWDrGxmaBnpVM0dLDZk1_NQxQ>
    <xme:bIozZxcz7dtyMRZ83c9-aQ8pn-HLooZB9EsMiqIMXOgISs1G5Rod2MUzt4UYLunLe
    6BwllXERb0E4vkCww>
X-ME-Received: <xmr:bIozZ_zCecKKiFODzNyhN3oXLRipiF5Vp_Quenj0SftpsxU3Fg2BEsyKq8HqeWo7DoNPLW8HNPzGz6iOrcI5rOHmk-GpW3zy5jclhXKlVXRg2SA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudeggdelvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeen
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkeduheej
    teekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepledpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepmhgvseht
    thgrhihlohhrrhdrtghomhdprhgtphhtthhopehphhhilhhlihhprdifohhougduvdefse
    hgmhgrihhlrdgtohhmpdhrtghpthhtohepshhunhhshhhinhgvsehsuhhnshhhihhnvggt
    ohdrtghomhdprhgtphhtthhopehrrghmshgrhiesrhgrmhhsrgihjhhonhgvshdrphhluh
    hsrdgtohhmpdhrtghpthhtohepuggrvhhvihgusehgmhgrihhlrdgtohhmpdhrtghpthht
    ohepvghstghhfigrrhhtiiesghgvnhhtohhordhorhhgpdhrtghpthhtohepphgvfhhfse
    hpvghffhdrnhgvth
X-ME-Proxy: <xmx:bIozZ3PZOcCQO_wdqtEWpbGZV_RlgTwPiVyaZEoWo1jHy1LQrRXVEg>
    <xmx:bIozZ0-sRj5173itvZ2ILt7XSNdoQHTOYlSO0qTZMyYZZOEWlVOgFg>
    <xmx:bIozZ_XzoN7DLpzLYQdxL4aOUnO0_6LfxjQdZ1KM6VuXTXvIdJrJaA>
    <xmx:bIozZ9eOLzTU6QHHIZ5UdYGxXNZsjQoOTW5jPMii5mMki3o7sWo5Qw>
    <xmx:bYozZ_Y8lAeEpj3F12UvDdZdlHXDw1GPWkYJ-V2nbgLfRnM41qNWjUSG>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 12 Nov 2024 12:03:39 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 6ab0a4ff (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 12 Nov 2024 17:03:00 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 12 Nov 2024 18:02:56 +0100
Subject: [PATCH RFC v6 13/19] Documentation: teach "cmd-list.perl" about
 out-of-tree builds
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241112-pks-meson-v6-13-648b30996827@pks.im>
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
index 75755ceec189836813e01fa43bae69bdd2083f3e..2b9fd37ff7021f3d44eaa282b942c623f403510a 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -306,7 +306,7 @@ cmds_txt = cmds-ancillaryinterrogators.txt \
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
2.47.0.251.gb31fb630c0.dirty

