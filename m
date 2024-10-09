Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E29B91A2860
	for <git@vger.kernel.org>; Wed,  9 Oct 2024 14:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728485793; cv=none; b=ZyHsPmKYhaolWjHLsOBJLGxtfDxvPUkU1ABfb5kr4O1ysm62Z3U2xWHPxPbzmmwfsUTqGu0eyWkAFc/WXe4TlwI6745Sn/bvh2BP8ZSZlb0mg9OT86Rop4+JpqhRD1xvZ6bRY/Ais/RsHAi5nDt72NjG4I7YjCMPjPSXBRGWPyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728485793; c=relaxed/simple;
	bh=8kwz4IIKk2z8j7HxT1eLtoMLhbRaBsWQoa2hIiVxmKE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rc0LT/6AMzRKHrIWbhQiR4wY/SynBowNPrCHXxvOEih4Xk1TJj4Qtsk5bAhlWu+k+T7DijnJ6thDh6QhlHFx/FREwbgZi5I0VAChZ5l02wWs/ygR2aLH8bRqRZP4W2v320mM4/cgquL7mlgHWMcKdYE2/dDAgwEZyIGYGWDW4pU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=sGNexgwH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RTIq420Z; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="sGNexgwH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RTIq420Z"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 0F94F13801C2;
	Wed,  9 Oct 2024 10:56:31 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Wed, 09 Oct 2024 10:56:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1728485791; x=1728572191; bh=EYVWAzTgIw
	8ifUwtibrD/7HUy9NffIUnoQswPsRlVFg=; b=sGNexgwH5Y0nWbAYG3Xs+YCbzf
	2scwNnsgo7f+Pc8pTwJbBbkfzdreFKvQUp6CkKaB4XWAEYddcz9eaal//tFiM9/9
	iOgoYGYh8wjP9vAcuRoZXZkj0koZEURIVmgpTqLCbOR4HfKknHXUUYMmTfgclhja
	8OMVtWUHR2bw1I1h6E0GzNWgbQUzn57QEIuH49ZQlb+f7tx/O4Dgtfa/vffVOAiY
	0iyKl1RCrSrEkvDI2kdIrg5Yc9WY9T3z/SEm/udbSne3yKi4uJ3uRzpspyG6Lq8a
	PEdger5jSLvYNxv8XEeWsRi8b+MtY7N7XpyOnhMem813plYI/EVUtSyZLfpA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1728485791; x=1728572191; bh=EYVWAzTgIw8ifUwtibrD/7HUy9Nf
	fIUnoQswPsRlVFg=; b=RTIq420ZzKayrOEYTudlWOoQNumANN4XFpjoWso3ROfS
	+j4Xnkkd0dYnpgsklMEu/1xzmQ5ofnGqk9suV6URugPnro+5KBOfNMEevyNh2Xmo
	Zjx22OnB81bbVbX8n9u5o1wX4lBN2Eb3W8IbqkYAUdntBGEwjZY8YBo7490g42GK
	oTydc+bFZjueyyYMCJJdWFY74nEgFdexrop8RdOy1QxCiIDWopyKforuRLQxw1z4
	CEPXWhQrmfyKOkuq4uUZvKIQZ0HsE+F8FWK5YkRsjJIg8OXjxoEoHiDCh1y0ah7I
	ycQXlAXa9GAal6quS0ql79WWpS+7i/VeiEO00vZaKw==
X-ME-Sender: <xms:npkGZ46DjKSCCpjSveVT_8d10BC0uRUwB6UQaVAlMqjTJmrMJ1482Q>
    <xme:npkGZ56z4wDyPAP-pbr_7SU1nhRIzlnPplW0Dp6aICcZurFUZVnzJNOXlTAAvYMhL
    I8M1-BsuztMMzxwgQ>
X-ME-Received: <xmr:npkGZ3fGW4W0DG7TcH9gWP-Nr68ezG9f09VTob7wnlv4INtoLkJIaWiQvL47VSAsCGScT79x1Qr_0h4fxR-obrj8ji3aU3viQwyx5s-Pj0MwTg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeffedgkeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopegvshgthhifrghrthiisehgvghnthhoohdrohhrghdprhgtphhtthhopehs
    uhhnshhhihhnvgesshhunhhshhhinhgvtghordgtohhmpdhrtghpthhtohepphhhihhllh
    hiphdrfihoohguuddvfeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghr
    sehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:npkGZ9LW-aioUO1I4SyOjNPnBpSMsPRTO62p0SESf7idR0HqsqNC_w>
    <xmx:npkGZ8LnPMt5JglJtvYPSnEu4Zp5UiUcwwE05YpihrEqckwCp2zRmQ>
    <xmx:npkGZ-yV5aQKJ-YbFc6ls2kzKG6-hHMD493KlISIJbum1lQzHeimPw>
    <xmx:npkGZwJvoMrmuFAcZ0Wxjus2T-ODOaIRcXOF8oyXTU7M5RMFDe5Diw>
    <xmx:n5kGZ2gv5D29T7erj4tqgseCSsvuYOn6-j6Ga4tYkBQmH0Eaiur1Zncr>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 9 Oct 2024 10:56:29 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 38fbe3f0 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 9 Oct 2024 14:55:26 +0000 (UTC)
Date: Wed, 9 Oct 2024 16:56:28 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Eli Schwartz <eschwartz@gentoo.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [RFC PATCH v2 07/24] t5500, t5601: skip tests which exercise paths
 with '[::1]' on Cygwin
Message-ID: <b4bdefe9e347e98764885f6c1713289d951e46de.1728485139.git.ps@pks.im>
References: <cover.1727881164.git.ps@pks.im>
 <cover.1728485139.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1728485139.git.ps@pks.im>

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
2.47.0.rc1.33.g90fe3800b9.dirty

