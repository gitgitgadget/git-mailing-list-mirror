Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ED181A3BD5
	for <git@vger.kernel.org>; Mon, 11 Nov 2024 15:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731339081; cv=none; b=b7skGQ/TMcS0i9lj7cZM0qo1DCYm4huWNcQ7H8QMbQxn8MJ+s97EKiZSaHc8LsHuoGXrySuesfaUP4U/xtZKdPWO5sSODFjBi3QR0EohFnLCMhKvsJmeNdkwJzERfxK1M/oafGOTxT9NvFqXCOADWRcHxnsQ3T41Cuz4tjBawIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731339081; c=relaxed/simple;
	bh=mNC7JbY2zeXVHxj5hPhWP65GGJkTD2dSgYRWj5EabE8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Eb6OnVfM0Bfq7DTYRgbLu1hcAj0EvRcjaoyXgkn2zgK6SoGbU8zLeFw01LJXEb9YEf4jMsiArf2SpvYDwonODM65uD0amFKsLnPxuoY7sPZFjAu4ISRKL4x8jKpBDmvAWDqCULbrx/ftn+Pq1WbnItZbtGg8YWSWTrtN0eUi8yI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=5BQsRazP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=epmIeRFE; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="5BQsRazP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="epmIeRFE"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id 5F29D13806E8;
	Mon, 11 Nov 2024 10:31:19 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Mon, 11 Nov 2024 10:31:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1731339079; x=1731425479; bh=UzQ2tB4RlL
	T55DnI7Ibb4CI7/0PQr5T9tTMtlIDfK9o=; b=5BQsRazP7JF95O6gIx5Btjm4sq
	A4ztNBOsRSzKBY+fZ6R+qDQ5RjBLKR+R3Cf3FBW9qvuco1MxKbePrycwhmu7+sic
	m4PqMdpqFKODIJzgpi4H7c+r4T2EBrtyJzJetJZhXWd8/uhVhTl4wZJ7jTbZVYh4
	4bQgyNKck2ip+OSMt5YUX4d/HpgRiRxxS5HT8AJ1zjaQL2Xo6r9Jfq6TTBFPh8/V
	kUvGB+tcPPh8OS+6lri485DRy5qo/sua95VY3H8qCH120oYvszkhtp2e/WfZrZS/
	u9v4SSuQ6GUrkglQWecgVRigqa+ISNZ8Zu2/NWGsW5yioEic6azrN2FEBNjg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1731339079; x=1731425479; bh=UzQ2tB4RlLT55DnI7Ibb4CI7/0PQr5T9tTM
	tlIDfK9o=; b=epmIeRFEvfX9oBbf/iW6ZPIpx+56PPzxdy0YgNZkMHfDFgwWqN8
	ij2r8d09X0ExW0bzvzes+dwPNU+eqVOx5YcxloyclOzsKTjuTI8Mb5XwZQPRgwKI
	8aDMISB0Un8jtpzZdd6i+Y//ASTR1Eu88HOb0QnzBVVHrl9YZGi4hmisN2lH6ATI
	BLTL81QVgJdZy/66kliJJz0Xv1IQQDwMYdfWJRwujKUOtHDggsQKkCt9P13e+MBF
	Y+Of3Av7rYXerK6t/aWImzNcdhWb/AHsiT/Uen55eI1ZpWH9FVDteKahdh0+RcJb
	6jx9kErIH9b4jwRr3uhEzWMMuo8KMTSwweQ==
X-ME-Sender: <xms:RyMyZ7f1LMn45uh37JgYJAoRIiJI4I-OL-SYY2nVOamxrhnkrGntnA>
    <xme:RyMyZxMlkYsUUtf325FaEdJ-HcO-5zHiICnD4YSmhHRP318wENjtcr8yAT69GViPr
    d_dhwxp72gC4cG3hA>
X-ME-Received: <xmr:RyMyZ0gzAHNgprsiD2scbqmRiCIg-DbwE9dIVKNLTJnTKymJG3ywvjlR7xaLMiYP5KAP9f4VCRncCn0p7foA7jrZTfHPHz8y3sl01-l51wiF5nke>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddvgdejjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecu
    hfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqe
    enucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeugedu
    gffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeekpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopegurghvvhhiugesghhmrghilhdrtghomhdprhgtphhtth
    hopehrrghmshgrhiesrhgrmhhsrgihjhhonhgvshdrphhluhhsrdgtohhmpdhrtghpthht
    ohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtthhopehphhhilhhlihhprdifoh
    hougduvdefsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghr
    nhgvlhdrohhrghdprhgtphhtthhopegvshgthhifrghrthiisehgvghnthhoohdrohhrgh
    dprhgtphhtthhopehsuhhnshhhihhnvgesshhunhhshhhinhgvtghordgtohhmpdhrtghp
    thhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:RyMyZ8_xayCJP4RB5Bkgl_shoY6N3jQdmP0ylmNfqITZi4YuivTFtQ>
    <xmx:RyMyZ3uzTXJP9LEsGwS9TmAERoIq2ppBmLa0SuxfUL3rO4P7UvgDEA>
    <xmx:RyMyZ7GJoBoomv_463uuKnmDxdDQMiLd_SLiTL2e5709h5LNcJRJcQ>
    <xmx:RyMyZ-M32XEXoDC4MlpdKkycoKgw7F1TBT65_Wklee1q10Xc2iXnMw>
    <xmx:RyMyZ9B9wqfRGNmis4qmGZKk2dA0e5E9G-wFrGM7PNgeZAvup1DoRPWM>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 Nov 2024 10:31:17 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 54c06e29 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 11 Nov 2024 15:30:42 +0000 (UTC)
Date: Mon, 11 Nov 2024 16:31:08 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Eli Schwartz <eschwartz@gentoo.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Taylor Blau <me@ttaylorr.com>, David Aguilar <davvid@gmail.com>
Subject: [RFC PATCH v5 13/19] Documentation: teach "cmd-list.perl" about
 out-of-tree builds
Message-ID: <7079149d6a14a1cde1a65192d6c5e2067477b166.1731335939.git.ps@pks.im>
References: <cover.1727881164.git.ps@pks.im>
 <cover.1731335938.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1731335938.git.ps@pks.im>

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
index 75755ceec18..2b9fd37ff70 100644
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
index 755a110bc48..e260a989774 100755
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
2.47.0.229.g8f8d6eee53.dirty

