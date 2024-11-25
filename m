Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74019199FB0
	for <git@vger.kernel.org>; Mon, 25 Nov 2024 09:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732528651; cv=none; b=jT+0Jjilx3otRFLv8M8arElIqttqrpdu5xA1EQN7am9skpS5Pf78dvSYV7mXIUDrM/izOab+DWU+PLwXh8efiLxVQ75KFesFRqk4f1cencdUHtYe1eTpEa9F5h6Whv4Ec/YYGTrkC0UlxMQegl88L8b+9hSArBxHxHFkOryIisE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732528651; c=relaxed/simple;
	bh=POoEA+Pe/6BOpQoosCzItwL/C2gcE/I7ZPf25veKpAk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=D/GJHwscYzsDCHM3CJDslWfxqOfhgeUY2w3ew2sO711ygGCxHNdd43WGHjg8JxF4f+tE1iW8ebXk0yx3X1NXnYk8Fg9QXD8fcGinH8LVrWSFhCpRQCowLa1oetaNgoSebCnsCHIEAg+1ZwL9VAK+oG4B/u3VvnuYV4cbwZLySf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=DYlUXqUi; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jPKwGHS/; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="DYlUXqUi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jPKwGHS/"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfout.stl.internal (Postfix) with ESMTP id 922E51140147;
	Mon, 25 Nov 2024 04:57:28 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Mon, 25 Nov 2024 04:57:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1732528648;
	 x=1732615048; bh=hk5AFPpVY3W3UbiPJ2gmv1oHqSjRh6jDBfxobWKUJTY=; b=
	DYlUXqUirrUOmbeL4Gw0coOy1ssflQlRYS2GS0niizKlbTaSBtJNM2Z0OW72TfEW
	7tdRC1pOvGdTNtSyELGL3AKia5t1yqufBekIGuQXVhJkpTB0L7AGVGe5AxJ/vTII
	CymOv3GyL7VF4XTMfqFy7WCIpYy9dfT4TBS/Mq79E93hOXWOevOkm36NBaCVnOFQ
	UEcVh/rW7oo7dnym/zj9E3gHOw4BPTLKGWr2xuoXINwuJY3CVBARAtITLXASFL2h
	N/LUKNchiJnFmjHy2ZGcPH8PzK6B9bygiR3E7WVVZQ00mdpJp6/oXHL6BM+hP3/f
	WTClOBO1Y6kgwBbqDBs7vA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1732528648; x=
	1732615048; bh=hk5AFPpVY3W3UbiPJ2gmv1oHqSjRh6jDBfxobWKUJTY=; b=j
	PKwGHS/M31NT6dhSmoaqmPbHX3BReoepQ2K4IB4rhn/QNdPudz08F4n8SwpMlZ/r
	VZbiLbL9Qyj++Ujc6eE7whTepvEZ3LCpSJ1/xQdju+7i3DymQg9El26JLcxjUyxM
	+XeiH13033+iCngpEtFBkVCa82MjfDJ+g8A/ELPn28Zde+doXWXgLYp9YLGWD3ei
	iMsI/LaA852zMuqxHJrBNNp4aCuM0SZLDQPY4sXo/5K4slIS7pHUuG9BRoK+Dmcc
	+SWw75VzyOM8/oQznsmnvw03a5NYMx60YMO68W8LuzFM3KJRsz1g6A3oHO0N2kBs
	Di2jlsZPVmUzksTX/dj3A==
X-ME-Sender: <xms:CEpEZ8t2NIlesEaatcJJT4OPNXZP4m7ZWajjORtaDh-aPNXaaHzPmA>
    <xme:CEpEZ5cSK2NeQAycDbPMlEv2TIxaKw96n52yEWUDFKEsa7GqcBvDQNzblVB9l13eB
    KhUIt3fr0gHhEFwRg>
X-ME-Received: <xmr:CEpEZ3zsnvjc9RwV8TkQwtb1o0qW3GPtCmokZBvxF_FkJVeq7bqa-0dL_5Tm496Br32Qt7NDnEVFXayuBm0AfktpeMU9XnBeLO0E5nft0bcunQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrgeehgddtkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeen
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkeduheej
    teekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddupdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtoh
    epjheitheskhgusghgrdhorhhgpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgv
    lhdrohhrghdprhgtphhtthhopegurghvvhhiugesghhmrghilhdrtghomhdprhgtphhtth
    hopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepshhunhhshhhinhgvsehs
    uhhnshhhihhnvggtohdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrd
    gtohhmpdhrtghpthhtoheprhgrmhhsrgihsehrrghmshgrhihjohhnvghsrdhplhhushdr
    tghomhdprhgtphhtthhopegvshgthhifrghrthiisehgvghnthhoohdrohhrgh
X-ME-Proxy: <xmx:CEpEZ_OEVXOzkRzMLbS8Rp60FDqp5wjt7ZS-QGwrkfJXoqyyj9qflg>
    <xmx:CEpEZ8-xI3dUn0iVp3mQm3WHrA7vPEdwJwsVNB_rmRvYwhA3gW-EcQ>
    <xmx:CEpEZ3VLrblb09GHI7urcPLkGStXenyg6_n1DARYw3LE_vaZZAQpSQ>
    <xmx:CEpEZ1fQDTkQOVc0f4frNt5Sy4KfRLz0_qd1-8zpNY5aT3i8LvcvhA>
    <xmx:CEpEZ3UlMc9jh3Naqn3B1us6TMTyrXUzeo97SdEsemjZnxRLqbDqRBCY>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 25 Nov 2024 04:57:26 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 4f5676c2 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 25 Nov 2024 09:56:21 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 25 Nov 2024 10:57:05 +0100
Subject: [PATCH v9 17/23] Documentation: teach "cmd-list.perl" about
 out-of-tree builds
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241125-pks-meson-v9-17-1c6cf242a5f1@pks.im>
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
2.47.0.274.g962d0b743d.dirty

