Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CF041D5ADB
	for <git@vger.kernel.org>; Thu, 24 Oct 2024 12:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729773633; cv=none; b=tBSgADm+4DGghKVk+167IDlfk5FPguKl4qTOhMm+gYpdsH56EH8mbVNAJxxjNJL7UMLpoqN709ax5JDSn/Ct3M4RyCbnKk2buDbZnbKjbhYeWUfJlCPXyNBfGY7OuW4oIUKnLBUQCOhh4w8XDDL8M5FTSwumgEBrvXhMM9jZO8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729773633; c=relaxed/simple;
	bh=tDvNEP1JP/aqDj0rmlQSHt3nW7SWKcKEZ/poEWNcdaY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UmHhYG5TpaaDT3R232gpO1IpAjwHupV3/es3+It5SMuTzcuDQ/rzBDFgKASjN/Qb/ZfxBlLeeKZ0HGNTYs5/HwxNJf8IH75T+YxMiGZp8aO1fPru/C+VXVVSna3kfUhJxwbq8WZ3U1LtacFEdODTte47dqTCyc0IfwoC9oN3Le8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=mWApzIjA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ROVrEFBY; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="mWApzIjA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ROVrEFBY"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 6F2BA254014A;
	Thu, 24 Oct 2024 08:40:30 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Thu, 24 Oct 2024 08:40:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1729773630; x=1729860030; bh=GaaCT1D21+
	V9Z7EnM60lYTifmCeRLZS2ewPiwaZ+EHY=; b=mWApzIjAo0vF0LnYmwqJWRd2Ek
	gfQlwgjGHcrXEu9/lKBt1XNbmceEJwQGZoKIquDi7H+mToBfu6fg8HoVj8uDD/5j
	aUzn6VeqayEnxuhYF8ZY6pZTcOxlpAPrQeideURTKd6uZE86Vx8y5600fEHGJazb
	ur8j94+MU/MQ9EThE3qT8+8iYObDVAna9AmHu6jPfq25N2ZkFqMN6GqhFen2QDZr
	FjNtbQr5McoUmQUx4UpcnU/PaMmlUmHljraOQ0ukxoZJKaitPcMkn1VMaX2yqnWx
	9jHiro+SxYtP38RZ+ZdPk8NruTsI6hxIyj6FkvhZtzufzrKA7Yu/1khbvKlA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1729773630; x=1729860030; bh=GaaCT1D21+V9Z7EnM60lYTifmCeR
	LZS2ewPiwaZ+EHY=; b=ROVrEFBYNUJ9vLFx8nvIfW3KoInczfviezeh7KMJeTI2
	5GYZzuI9YnE2Hf+0ZWTetUJAPp3pY9joPV/WGU/xomgwr8ugTMY+Okq7RKkPyZoz
	SW1KIhNh8ThEd+K4Bj80g3gc1dGBG1hTq5ax9MBN4or5SrJwFJ74WKEyjl62+2qn
	cdO/T7LtSloHLPMBgbLEDrH5E+l0OPTbQDG6CpiU1yFbJ2w1iSye4QT6JxPWgpDV
	gKDKhqaypJZ7sqgJcIQdDC+a4pZaRc7w9DCnDek/jc9PQqqZ78oHwUjyn5j5Lk4t
	ieuN3linpcaqoOLmvMz9OfHvxSLv7xl0Z1mXrgKvJA==
X-ME-Sender: <xms:PkAaZyJnAogimdrk1sTR-qAWsV_cImnmOo-a6s_UE5nE3UG2TiepBg>
    <xme:PkAaZ6KR_OgrG_j7jcwxqHS4_jmdU1DeB_XQmjsBIda-Xa-3zC3jHNw3cMVXKjT5j
    QAPPteFtvxCd0x3FA>
X-ME-Received: <xmr:PkAaZyvmGdP5IJAJQOgo9KRsqD-L-VMplsAGD0cD13QFGrgg_gIhXpiOsE6DiASwpVCiZFYzkOBIOCZGZazUDKH8SF3k_738JjYHLi2EK1AdDd0c>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdejtddgvdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgepfeenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepjedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheprhgrmhhsrgihsehrrghmshgrhihjohhnvghsrdhplh
    hushdrtghomhdprhgtphhtthhopehphhhilhhlihhprdifohhougduvdefsehgmhgrihhl
    rdgtohhmpdhrtghpthhtohepvghstghhfigrrhhtiiesghgvnhhtohhordhorhhgpdhrtg
    hpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehsuhhnshhh
    ihhnvgesshhunhhshhhinhgvtghordgtohhmpdhrtghpthhtohepghhithesvhhgvghrrd
    hkvghrnhgvlhdrohhrghdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhm
X-ME-Proxy: <xmx:PkAaZ3YOWeVAqYwSFZlbStvRNnDkSS6ma7XbiNwzqZhsb-beX-AbUg>
    <xmx:PkAaZ5bw9I405M_kZJ9-bce8OPUqpw90MnSW33BGuF-U7REmoy9QDw>
    <xmx:PkAaZzDQn01mMO7hCGLLhJ_oibMPGRm2Okvb4MQWw3XE6a4g7d6hQQ>
    <xmx:PkAaZ_ZV9KAkjEed930tnQYKvnWaB73fK1X9XlEVhphTJDSrOE4DCw>
    <xmx:PkAaZ17IFdFiMCyY20ZZRGYJYM1mDuyQacv41BHwsunDu10DW9XDH_nF>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 24 Oct 2024 08:40:28 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 3d027ced (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 24 Oct 2024 12:40:31 +0000 (UTC)
Date: Thu, 24 Oct 2024 14:40:26 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Eli Schwartz <eschwartz@gentoo.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Taylor Blau <me@ttaylorr.com>
Subject: [RFC PATCH v4 13/19] Documentation: teach "cmd-list.perl" about
 out-of-tree builds
Message-ID: <cf1743667e9e1b8fead66dcc13776afe84a10ad9.1729771605.git.ps@pks.im>
References: <cover.1727881164.git.ps@pks.im>
 <cover.1729771605.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1729771605.git.ps@pks.im>

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
2.47.0.118.gfd3785337b.dirty

