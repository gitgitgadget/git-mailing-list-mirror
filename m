Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D4841D2700
	for <git@vger.kernel.org>; Wed, 16 Oct 2024 08:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729066394; cv=none; b=Nfd7yUDYPy2ApqvwLvpUxTTndDXflk3/05EeJNaIrvNz2tgEIIWv6tR0WhrCAW9YnjHpYf2a6+DH6K9PkbEQchDU6gSTFo7UtjWAtrOQLVMEcuCQnk9pxNOqb2ewUOGWg2iJJbSE49gzR+yb+IiA7y+A5lxRiO5t3LZCsJ1zIK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729066394; c=relaxed/simple;
	bh=c3RTVMk8oO4k7R13SnzHdXs0nruzngj3MksK/u0DS74=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EOilHOUFjDno7fkF150Ls53GiTv3rx/etnHJ1A+BJJ9GORfeTfPYrxvL2SJO6XhB+5Sp0hO7uWShgYngP+GGqnXJRXGG+esqOGa8ikmLi1O0oM/7hpcOZra+6cTii4H1oBi+V2XiYx+5E39KlRoDAoogYwRryxt1R2OI6sagpRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ViiX5KkX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fjxrMmj/; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ViiX5KkX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fjxrMmj/"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 595C11380044;
	Wed, 16 Oct 2024 04:13:12 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Wed, 16 Oct 2024 04:13:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1729066392; x=1729152792; bh=WbjcHA7+bU
	yzAzOGLc5SKECgOtm3PzmlwBh85bErodk=; b=ViiX5KkXm+se3wzn/OxKrc+WBJ
	ySBOYmG90/pi9r4jQv60EEN/FZKDVyAnJb2p75NaKY2LP1wqODGWRo1JYbMJmRGx
	wD70Bol1LUW8fPfPqO08+83QM3pc3q547T2+gc5lKJzRkwMtVerw8Te0mXYGfZWn
	5qqq/PVBREJhf0NM8eO3YeBoD+wQ/ZF+8UkI8+914t7Duv8LTKtj+6aan5QtjI4p
	lJGyRgYSc4zuXipM0h1eq6DURZkcK9AJhNyYL7WPalhNV/fzoHGD557neNTu/83K
	EdMYSpU948ESbPxXZVJmRAhN7lx8Ld5SpYs62PeOoeNBNA5jp/y1Z5ciw4EQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1729066392; x=1729152792; bh=WbjcHA7+bUyzAzOGLc5SKECgOtm3
	PzmlwBh85bErodk=; b=fjxrMmj/Eoj6QCrruOZAuhPGj2hMU6t566qQs3VOqMuy
	QFjRq5P8MOiTYTsi9UgxibGo6/0M9xTORFbFp5C1Rl1gdcCr40bohD93FFdH2U8W
	uzZyQ/hzeyLugrSYeaJqh0OPL683x7mXDbs4uoqEOtfkHRjgE8em8nlqtzq/yq8V
	kCmIbdpn4mweeojpK8Y1bt1ygMCQ+MVPx35l+D6ZOgGOpjkCAAiaZq0Xx6MtuQb0
	lf9lkohbc4R5j2IM6Z3IzeGyNQoTbmM8j1SzGOICqYop/R0n49gTacp5TxfGbbIB
	hCa2TTHSLTeIURzErzDG3rtNgETEfMayjlIXmPl+9w==
X-ME-Sender: <xms:mHUPZyMBYMfMtpmZFa-4AG00noCtOz1F12TjkxbJJ_wvaVJUnBpY1A>
    <xme:mHUPZw8KINMb7FHr67p7HnOWGgLEnb7LOdtF81SAi0A5f30n6ZSPwHTjVCgqBh8zO
    rYfGLvZi9PSJKoTUQ>
X-ME-Received: <xmr:mHUPZ5Qa4ux83H2fv7EDJxi6HDMQSDkbAVKseB3CjU2YN70nJYC8Ymwd-CigaVDw3XGp5y5sbZjJ91a9YPHBHd5A9yLZ2DLDeXkjWdV2gU2oFQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdegledgtdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepshhunhhshhhinhgvsehsuhhnshhhihhnvggtohdrtg
    homhdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepghhi
    thesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:mHUPZyu1eR1EZ4E9VsuaHUc-2rAZ1Qi7eT8eyAMCAtB34cBAj8mEJw>
    <xmx:mHUPZ6eJfm9g-Q-2vyKsuJbrTOnuMF4RWzpKCsXUCz4zPdyKJDCNmQ>
    <xmx:mHUPZ21CZ2EmOk9PknUATpf1iXfv_H3s4kySLft9HqHr9SUlTDSOXg>
    <xmx:mHUPZ-_HvnNdydRoZYdb6DKqsZMAcJ9byIWwrmOfw2-dNMaBJ2KMGg>
    <xmx:mHUPZ66o-uK6r1lvZiw41MfvKCmpNSKK5l1nGmKhIJ7kVtISPc3psFvq>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 16 Oct 2024 04:13:11 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id e80a4be6 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 16 Oct 2024 08:11:54 +0000 (UTC)
Date: Wed, 16 Oct 2024 10:13:10 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>, Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v3 07/10] t5500, t5601: skip tests which exercise paths with
 '[::1]' on Cygwin
Message-ID: <de4c0c786bd0368a732fd7a7476f7f8506d4d46a.1729060405.git.ps@pks.im>
References: <cover.1728906490.git.ps@pks.im>
 <cover.1729060405.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1729060405.git.ps@pks.im>

Parsing repositories which contain '[::1]' is broken on Cygwin. It seems
as if Cygwin is confusing those as drive letter prefixes or something
like this, but I couldn't deduce the actual root cause.

Mark those tests as broken for now.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/t5500-fetch-pack.sh | 14 ++++++++++----
 t/t5601-clone.sh      | 11 +++++++++--
 2 files changed, 19 insertions(+), 6 deletions(-)

diff --git a/t/t5500-fetch-pack.sh b/t/t5500-fetch-pack.sh
index 605f17240c1..416522c86ad 100755
--- a/t/t5500-fetch-pack.sh
+++ b/t/t5500-fetch-pack.sh
@@ -774,7 +774,7 @@ do
 	# file with scheme
 	for p in file
 	do
-		test_expect_success !MINGW "fetch-pack --diag-url $p://$h/$r" '
+		test_expect_success !WINDOWS "fetch-pack --diag-url $p://$h/$r" '
 			check_prot_path $p://$h/$r $p "/$r"
 		'
 		test_expect_success MINGW "fetch-pack --diag-url $p://$h/$r" '
@@ -784,7 +784,7 @@ do
 			check_prot_path $p:///$r $p "/$r"
 		'
 		# No "/~" -> "~" conversion for file
-		test_expect_success !MINGW "fetch-pack --diag-url $p://$h/~$r" '
+		test_expect_success !WINDOWS "fetch-pack --diag-url $p://$h/~$r" '
 			check_prot_path $p://$h/~$r $p "/~$r"
 		'
 		test_expect_success MINGW "fetch-pack --diag-url $p://$h/~$r" '
@@ -806,11 +806,17 @@ do
 	p=ssh
 	for h in host [::1]
 	do
-		test_expect_success "fetch-pack --diag-url $h:$r" '
+		expectation="success"
+		if test_have_prereq CYGWIN && test "$h" = "[::1]"
+		then
+			expectation="failure"
+		fi
+
+		test_expect_$expectation "fetch-pack --diag-url $h:$r" '
 			check_prot_host_port_path $h:$r $p "$h" NONE "$r"
 		'
 		# Do "/~" -> "~" conversion
-		test_expect_success "fetch-pack --diag-url $h:/~$r" '
+		test_expect_$expectation "fetch-pack --diag-url $h:/~$r" '
 			check_prot_host_port_path $h:/~$r $p "$h" NONE "~$r"
 		'
 	done
diff --git a/t/t5601-clone.sh b/t/t5601-clone.sh
index 5d7ea147f1a..9fe665eadfb 100755
--- a/t/t5601-clone.sh
+++ b/t/t5601-clone.sh
@@ -530,10 +530,17 @@ do
 	'
 done
 
+# Parsing of paths that look like IPv6 addresses is broken on Cygwin.
+expectation_for_ipv6_tests=success
+if test_have_prereq CYGWIN
+then
+	expectation_for_ipv6_tests=failure
+fi
+
 #ipv6
 for repo in rep rep/home/project 123
 do
-	test_expect_success "clone [::1]:$repo" '
+	test_expect_$expectation_for_ipv6_tests "clone [::1]:$repo" '
 		test_clone_url [::1]:$repo ::1 "$repo"
 	'
 done
@@ -542,7 +549,7 @@ test_expect_success "clone host:/~repo" '
 	test_clone_url host:/~repo host "~repo"
 '
 
-test_expect_success "clone [::1]:/~repo" '
+test_expect_$expectation_for_ipv6_tests "clone [::1]:/~repo" '
 	test_clone_url [::1]:/~repo ::1 "~repo"
 '
 
-- 
2.47.0.72.gef8ce8f3d4.dirty

