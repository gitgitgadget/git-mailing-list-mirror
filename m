Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7EDD20E03C
	for <git@vger.kernel.org>; Fri,  6 Dec 2024 13:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733491541; cv=none; b=eWArsAkiKQDo5qLIkkgNj5rj+7/PvdjIqcjtn3eO2tgLC4hCOk76Gh/rH54XCQi50OlO4BCJBA0IIyZ0x1BUZEh/x07MU2MBQqBkaxf+iWT49YdgFo4PK84W+o743n8q0WaHjG4G3Pme0L6+HvkTTzS44vOb8afnnW58VOx5wmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733491541; c=relaxed/simple;
	bh=O4uEscOFyy8ft3NINNjgsOz9btpEI4DvTYbxp1w1VIo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LE5AEu+9Sjul1B5ag9yRsp4/8o+LxJY2RteJH9QXGD7vT+QhOLvYRIfW+2d1iyNRKUMG/vMEoHdjp3PzyNCxsbgaGIczOTCuFV7//Wl3v5A1mtZZMoKlsTP9kKXdegBTjcrH8/kFSgV1lmnr/wv6hYh1+YuZsAouxcJIIuSkexo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=c/wzpSUt; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=xxtKXpb6; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="c/wzpSUt";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="xxtKXpb6"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id B19B4254019D;
	Fri,  6 Dec 2024 08:25:38 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Fri, 06 Dec 2024 08:25:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1733491538;
	 x=1733577938; bh=JKNuZjAKqaSeDKBIWhLkBcZcLIkyuFdCZtGIBqC//fQ=; b=
	c/wzpSUtwIKksOyVSLXhBQMIRc/cD2ba03j7EHGhdRFxzlQPtRWBZy9q5LZVo7hH
	OCQij+KmMtGL2EXo5aAPQLech3DX7k/gLqEjNqiR34iSl4dNxriG45132GdDFHbr
	2fAEUczu8OYBBkvsBnEbHOq/EA23sox74E31roOpPw+5fLNC+inuQj7YKEnhUhSd
	KcdhY64vLV3JpIaHzX+vAK9uxUaAWy988dgILU9AsU22XxjlUMlFrGDHGayogLoY
	OKRKnT1BHMFWBQLSuSmqm5zjKG+D7uf4wl8M2ounx8y1GpNzA2moCjt/5wl4cPF9
	2RMIqNME1P+bWDHjJtVOHQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1733491538; x=
	1733577938; bh=JKNuZjAKqaSeDKBIWhLkBcZcLIkyuFdCZtGIBqC//fQ=; b=x
	xtKXpb6milYVXw3k8a156kM0jPjK0/faDlhkuiAmmsfSnl7xqCv47UQsEMl6m9xN
	qe+dAXemfjA5uKcLYHJu3iD27lQw7+moFvT8hMMm1nPa9Hh8QjIvDn7D+izs9b++
	tZp691xWBIkWNeHW6wC4016B/CKIohTdbJtvJqgTwSAOudhI7pvP4oi4M7XRp8Sy
	U+/RkTmPCk1mg+lT1vo87W2+kc3NEihXqkI6Q4rt35LOY8xfDPMIuz8/ew7TBTP+
	4jN84d/hhIPhFFtazcHw/yr2Py9kHrgBaW/PWgZH87DGTOMCYBMZ2bom81kYKC5y
	Bj0OtTyEuLuDjN4E/ZOBg==
X-ME-Sender: <xms:UvtSZ1jlgiqDSuK2JVW_koYzyp28tTlOojLg4sSFusqWhX0Pz4YTKw>
    <xme:UvtSZ6DS3rg2bViLO54dJ_vHkbRiQTgdVPTUK4j3JzokqetniJcmaxyZ3pK0Y8w7b
    tSQGl7mMvE-7ebYAA>
X-ME-Received: <xmr:UvtSZ1HG-8qS67jXLmZoI9d6MRk2iIh5vAyAwsI_tb9XNVMgEJ-kJhlRud1Dka6n473JqX1X9DJyobns8KRw17nj8ElbiB4Tzcxv2T4eIKkEpw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrieelgdehudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeen
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkeduheej
    teekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddupdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopegthhhrihhstghoohhlsehtuhigfhgrmhhilhihrd
    horhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthho
    pehjiehtsehkuggsghdrohhrghdprhgtphhtthhopegurghvvhhiugesghhmrghilhdrtg
    homhdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepghhithes
    vhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehphhhilhhlihhprdifohhoug
    duvdefsehgmhgrihhlrdgtohhmpdhrtghpthhtohepshhunhhshhhinhgvsehsuhhnshhh
    ihhnvggtohdrtghomhdprhgtphhtthhopegvshgthhifrghrthiisehgvghnthhoohdroh
    hrgh
X-ME-Proxy: <xmx:UvtSZ6Si7_YFpRaWrGDBHHB5xKOqZ45dmmAINIkJWWR_5PYiB0z5fA>
    <xmx:UvtSZyxcm9PhXqOgK83WgbBr-W--MtKX0wMAaM24DYp1axqgX42lLA>
    <xmx:UvtSZw5jbE_9iND7aHSWKbs4-Q2rBZ9KlsskItWplDumHuPK0yLrDA>
    <xmx:UvtSZ3xSqhlp3HNUh3nqYnNP5uydQ2kBXUYubYVaCrSmhxBZ9Zev2Q>
    <xmx:UvtSZ05VOWT-ZpBJhjSwhRRMFsZSPOVLuTPfA7KMBmbixmT0KREsTJdo>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 6 Dec 2024 08:25:36 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 9cdc8c34 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 6 Dec 2024 13:24:08 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 06 Dec 2024 14:24:54 +0100
Subject: [PATCH v11 19/26] Documentation: teach "cmd-list.perl" about
 out-of-tree builds
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241206-pks-meson-v11-19-525ed4792b88@pks.im>
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
index a74fc0ff3d3721daa991c675b3f1f212e6e1e243..e853d89eb5d6c89eb7e7bf10c5b75e5ad0db531b 100644
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

