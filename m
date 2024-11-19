Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8DBC1CCB2F
	for <git@vger.kernel.org>; Tue, 19 Nov 2024 11:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732017073; cv=none; b=ZfMfkwcRiveuC7SUBiWN3Isin9qDZCp8Hg0f40o+WXHvGd+dadIqAJM1VzuzEt5G2wp593CSF1LY6lh0+9y/7E1wDXMbLigpgpWBQGMrj6nHI6ctHBcg7k6kF+ifTJ6qHkyPnCwfjTCSx0paO9mFHnZLuBKYvWBeHUR2sd8Q5Ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732017073; c=relaxed/simple;
	bh=GGwytFWxo+ZG3Med7l5O9+oBbqTB71/zQz+3jiY3rw4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kt3zfmBpCiPArUw3/LdbmuvbouqusWBfMjfuiAxGSlS7lzqQ3JX/KBgm44tWoRbSzWxO0tF6lvla64Jj/4fbW/ldoZ4bn1INmWNpk9MH9lacy0t7NsCveOLymqeSQ4Z8l6aEYST+JtiiJon1x9Wz8xaNPeno/bsdAQP5RDnu8Qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=YRixxwuP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OOydjYvQ; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="YRixxwuP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OOydjYvQ"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id F08FF13805F8;
	Tue, 19 Nov 2024 06:51:10 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Tue, 19 Nov 2024 06:51:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1732017070;
	 x=1732103470; bh=3/2A7v9q9GR8xaa3lITnY2W/TVKvDkX+67dgsrG7kHo=; b=
	YRixxwuPdwPhiTNWb0rWKsSQ4MViI+1hTdvarVy+TPxttWLGTPOwkuF8wYBaLUui
	RfiAxTcA1PEK912s1mZ2MUVWSySE1yJI8Ei1mhCAuII9RxnaxrDKM4Ae6s1fcelE
	XFsSaUQ3f88oLEmcDa/ZT5oXFqq0y0p2VI9ToeFFSO3yAa17y8ELI1WdrQtyeCnB
	4PWBc0kQqsOGHBJ3Bd+6G9FyWAKgeVdXJ4BvkFGMz1qQNWeYGiU+6fRP0Km+tEeV
	x6Gm184oZilqt1OJGHgaZ0wsGQhVTrhhl3BJRDmDnmpF9Z5r9WBvqOwCXaYOcXNP
	+TjjMRp3YloTlOYj7SG9Bg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1732017070; x=
	1732103470; bh=3/2A7v9q9GR8xaa3lITnY2W/TVKvDkX+67dgsrG7kHo=; b=O
	OydjYvQRYbt0o7ErKEq5TYBqbrXKXSBFr0bdNnNaLSshYUYOZsb0Cg9n5i2Lvnw1
	dsVFXtCtdBA9AAVXtkkGAE2weGyY7cmQX4Uq1S1cN3CRpuBDR0mP5f1YrEmjnZvm
	d8JG++xwVC0miE9k/ErTS5Is5Cp3dvE1OYFnsX4wAv6vUBr3yf0ywEWigbhTYcdd
	TXUZ4O1pTAup8eYrVyutHnnqhxd2d8e394Sc8wRNv2QVdBi5z98xSiHMv2CqoQE/
	Fx5NzkErihve6dTip7ClI2cnGch83l4oXDXMNGVWDm3R3EnNvpp1zxSSLy8l0kGb
	Rqta5pJthqsRi/79gYj5A==
X-ME-Sender: <xms:rns8Z8zG-fcCM2AuS6bVZ-9McA3fNQBvVlGVoiDTWFwR66RDlbUVVA>
    <xme:rns8ZwQJ-3ElczYeZW68OHWo_8NEDDnkdbow3cHM1HT-AbBG52U76utVmRov23vdC
    -vBMiGeh6p6tkEOGw>
X-ME-Received: <xmr:rns8Z-XGDNEkWO1-mG_sTvE_o3Au0o_uX7zbHDByjCAZGuZKqErRf5CvpvwFm4nKDpCOdKNorm-jwJlO6FHf6LUxm92metqtJ4FUDwClvGvhxOw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrfedvgdefudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeen
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkeduheej
    teekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddtpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehsuhhnshhhihhnvgesshhunhhshhhinhgvtghord
    gtohhmpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtthhopehg
    ihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvg
    hrnhgvlhdrohhrghdprhgtphhtthhopehrrghmshgrhiesrhgrmhhsrgihjhhonhgvshdr
    phhluhhsrdgtohhmpdhrtghpthhtoheptghhrhhishgtohholhesthhugihfrghmihhlhi
    drohhrghdprhgtphhtthhopegvshgthhifrghrthiisehgvghnthhoohdrohhrghdprhgt
    phhtthhopehphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrdgtohhmpdhrtghpth
    htohepphgvfhhfsehpvghffhdrnhgvth
X-ME-Proxy: <xmx:rns8Z6jZIbOt5YR6kfGakDzVX_v2WNWYVLOM9brtRkcM4DoMxUR7UA>
    <xmx:rns8Z-BgGkL1X2DkKiQ1NH6pKbZyUOEldZD4xnIVC_abjF6sqKLUYQ>
    <xmx:rns8Z7Ibq-e_gvQ0QZJFnFVbN6JdjBb1k3sIN52RCwz9O48yRfuV_w>
    <xmx:rns8Z1BIcrUDP8QshPBnMuOBtnZWUtmTTZoG0A5DpGo3ZkXu14QIoQ>
    <xmx:rns8Zy7rWnMVeJDslL6oNfR2mB8qDnOcNm2KXagTtm2FELLwqIQL87NF>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 19 Nov 2024 06:51:09 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id cccf87cd (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 19 Nov 2024 11:50:19 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 19 Nov 2024 12:50:54 +0100
Subject: [PATCH v8 17/23] Documentation: teach "cmd-list.perl" about
 out-of-tree builds
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241119-pks-meson-v8-17-809bf7f042f3@pks.im>
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
index d26d9b155dc511494da4124ee22630d02f5d528c..ca59581df65ca478910321fc937f98b23d597bd2 100644
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
2.47.0.274.g962d0b743d.dirty

