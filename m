Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3461817C21E
	for <git@vger.kernel.org>; Fri, 15 Nov 2024 07:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731655309; cv=none; b=WNAOSrZOtYCX9EfC7ljrx3PIjlUoarqvjTRUaCihOjOXNEHaQKQEcWMvYQpXp4aV4uM4vTYn3Ou39zIthaEvsch0EEL3IXLHLrTCj9/0m7SBuoNW4Iiqe6fejI4JTBM6NkE5CdhdM91wXvf4tpr31uHXV3dz7Jj7W19KEGtwEoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731655309; c=relaxed/simple;
	bh=sbT/kOa0wYpkEGF7SmukEwvdobfR8+Z9oEd14THGsHs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Nw+YUnzGAUKo/wYo255uXlzVQ4syuQq5sWKCAb0plOWmwLi0bbpUyoLT2Pbwbmt71IiG9Na7s8FEKTqIthpLlDfkU/pOy3K+r+7EMyJFgKQPjRuPQsCTpjfNeotR2cIVrCPjnf8oWLrqUQryJ6uR+IEXCFt/eZi4fJ6jqJtW8rM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=TBKS19d9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Tb9BqUSa; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="TBKS19d9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Tb9BqUSa"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id 902E513806C9;
	Fri, 15 Nov 2024 02:21:47 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Fri, 15 Nov 2024 02:21:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1731655307;
	 x=1731741707; bh=lzf2C9DQgg4dYHQp9dskrow902tGffVsVuSY5NKP9x0=; b=
	TBKS19d9eKnumXjdUvSYwiIr/weLAytf9yefHEhKxRKl9ujJlWLufPgnMtEg6sT1
	uX7R68jz04kPGeiGmTmrmPTgRsdRFx4HDboeJc9bQcGYDS9xyTUk1U3EQyk+Ycwr
	rsmqcy4ELz4UAZRTcDq6bXk2ktriXvlopiCxW1J9ub65Nc2JyEnsS5PtueVQSTQe
	g8WFo0F/OicBbgp+xk0xiaFH39B7HtgCGgirYbzVjwfLYLrovg1v8FxU+Pk6DUK7
	eS+x8ThVpip7Yv05oIFCq6vmqDocilWsPPBnkNAOXVKw9BCrTx4sKVWnQg4QDYa6
	FxiY0XWmb+13bEr8ssrAxg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1731655307; x=
	1731741707; bh=lzf2C9DQgg4dYHQp9dskrow902tGffVsVuSY5NKP9x0=; b=T
	b9BqUSaR258v2pkuVSbt+g664j7xYTNWhBiHUwblpoe8MR+HkLhCLWSZ9W3W/Bca
	SmJC/Cj+pXLfEhElWuKEJC05dhZ5cG+Glz/ZVuCY4vg9jkNWEBWsKH3MT40NTiVJ
	jwuX0O1QlCMKgNhegA0AVynjNvZ+CzwlavHNhMy1aJFMEFFec18T4U5OQJWyIoWC
	xpy6dao9Taod1wM2J3cBDFOlGw8OLVB9NIzQUVJawru1eO5Pja9qvKbTtti6yrjl
	7/xtgWaKqyO7nMzqbXn7olIUPKWKUwvnlooWeMySGo15CikSLfH//EhAHZcbq3He
	vESucNB+TaXO/5zDXYm3w==
X-ME-Sender: <xms:i_Y2Z7UfeIT85jVfys1aWcWRQiGwqJnNLLqqHbPbw5IdHMn7W9Govg>
    <xme:i_Y2Zzk6dMzPu7r_rsRPWu08CA7B0N8TwALNF4daTV1il6UW5ATSp6XRT9XALFl9v
    EGJgDKwqhwCWSQ3bw>
X-ME-Received: <xmr:i_Y2Z3ZYuIus16sL72zxe0TLbLJsJ4mW--26anxpUcxSxQxCETfJSbVfYrjwM5DoYS02fdXtzrkXSb2T46isKKc_v9dnwFxxkLHTNUdXLyVE6vVkog>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrvdefgddutdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdej
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteekudeh
    jeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedutddpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepvghstghhfigrrhhtiiesghgvnhhtohhordhorh
    hgpdhrtghpthhtohepuggrvhhvihgusehgmhgrihhlrdgtohhmpdhrtghpthhtoheprhgr
    mhhsrgihsehrrghmshgrhihjohhnvghsrdhplhhushdrtghomhdprhgtphhtthhopehpvg
    hffhesphgvfhhfrdhnvghtpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdp
    rhgtphhtthhopehphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrdgtohhmpdhrtg
    hpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihht
    shhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepshhunhhshhhinhgvsehsuhhnsh
    hhihhnvggtohdrtghomh
X-ME-Proxy: <xmx:i_Y2Z2Uao0KEY5YKt1mTySbFfG0hIlNrROGnwikUMd4YsoxBaxR6gQ>
    <xmx:i_Y2Z1m_iBCMo4bYaphnS6K2teiOZMbwALY__6mL3kmsSWik3NpIxw>
    <xmx:i_Y2ZzcLFvse4yMM7BGh7leG-oAGpyNRSHLZdYZIH1pJ3_OfsQk7fA>
    <xmx:i_Y2Z_HBxzE-erRPstKG4cQH5Eeh0WRBZYtG4r95LpVAlFGlJimTww>
    <xmx:i_Y2Z-fZ8ehvb8pJTvjy4MLsbDvp3FbkuyZ6zu9PyP1H-V9YWY4lF_k7>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 15 Nov 2024 02:21:45 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 9a06dd58 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 15 Nov 2024 07:21:03 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 15 Nov 2024 08:21:28 +0100
Subject: [PATCH RFC v7 16/22] Documentation: teach "cmd-list.perl" about
 out-of-tree builds
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241115-pks-meson-v7-16-47ec19b780b2@pks.im>
References: <20241115-pks-meson-v7-0-47ec19b780b2@pks.im>
In-Reply-To: <20241115-pks-meson-v7-0-47ec19b780b2@pks.im>
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

