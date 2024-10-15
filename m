Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 956251CFEA9
	for <git@vger.kernel.org>; Tue, 15 Oct 2024 11:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728992734; cv=none; b=DXh3aBq8QHYWOz+mRhKYnCxsvCUKoXtjhKXBJOHo7AJi+zCEc9eqFnrQMOtgxyezkK1oZIhQakp2uJz8qa0OzS/1sBiwXtkGfng8CAUspf5BWI6mVE98Hr1/IYoyNGfg+rkCOMFeWxfr7/s7beinTHbZvARRhdIa8pBBzmMk3N4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728992734; c=relaxed/simple;
	bh=c3RTVMk8oO4k7R13SnzHdXs0nruzngj3MksK/u0DS74=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WhCSUgPBPJdhA9Y65HxTR/QYncEvKGVKJ7TyU1RhImnhcX6RPar9CMzEAzkZ015f+3rM/O8VzKAgkfnBsPYIAJQ+vGskChkMQ1JQAKlDBlOwq5114ZlMY2XVU6Lrpu2e0/DuxTHFX8/75W/cDc8Cg+zJQjpWQJbmLGAT7BW6G8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=qCGREcKT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eFIFnKhs; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="qCGREcKT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eFIFnKhs"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 8E8FF11400B7;
	Tue, 15 Oct 2024 07:45:31 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Tue, 15 Oct 2024 07:45:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1728992731; x=1729079131; bh=WbjcHA7+bU
	yzAzOGLc5SKECgOtm3PzmlwBh85bErodk=; b=qCGREcKT5NTACUO+bgyAS8POH7
	JdtOseJ2i4Lmu4hM/BRaga29zj85bTDJ3vO9XxsDJNZ7oeK4MsficX6OJrR5vSSF
	nJHdsipezeNvCwSUDC7fqoSMxqY/v6sEF6C0u4Slr2DEeVPATsghEeqDwxWuyzN0
	RZlN4uXyjxaNpjUlfDTqjlmSu3aynzqIEUrMtUvIKpkwwpMAQhlNIodBWAry98J2
	Eyq0wEDedynRYC8H0xFIomq6MJmhhr19Km72Y2M08KVyimfjbM+BPrjiKUjbR/Ms
	JSpPOa8z+Y9TBS5/yLSDGCR4vtg5Scks1NeV7ysBX/QT43JN8mucQOHjnxVw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1728992731; x=1729079131; bh=WbjcHA7+bUyzAzOGLc5SKECgOtm3
	PzmlwBh85bErodk=; b=eFIFnKhst1EhrcSyjxQO62KT2m+dFi8z8K8lOBzTkZrr
	gmpOsyTG2PLui3eB0ZOWHXt/q6VQG1P/CHs+zx0gYkqBUcqJJPTSgfL/h4MHkFkS
	KmJV8uc5Arfiygxbae8OETljSMDAjrAyjrHSaeLofCst5iOAUee0vLCUFC6ulPAI
	rmRZ1hKT9rQiD/nuZ6tgddenPHL4mloZsumPRMmh0z0z66T8KsDiXaOEBuMtye1F
	lBpVR8NQvCb4aXWar0Y/kbly6HXoKlcuQPV45onCQrEbEy0XX4I/CSVXZplNzmXx
	ZGo1BVUCtp1jQlWLdJMS6aL7hUhrcnAazHaeFnJBgQ==
X-ME-Sender: <xms:21UOZ7Ufg89dGy2ofpkLNUlaFAwiNtnAlw1UqMhxHTfYolw9CtVunQ>
    <xme:21UOZzk6I6KKbZ03edL0UiZn-Is9AIHUG5Xo1DkINh4c7Z-YzxPoMxO3nqj_dVOrf
    bguFOVltbvhqYe8hg>
X-ME-Received: <xmr:21UOZ3ZYO8EdNBmIY3zFogJ_tGuYuVFlmhVVQWrAYeqa7EUBUdwkXhnNCOeQRjNAXvJzmq2pYl--AF0W5AeqVZC3cUGzaS3F2AZCwXXH6VjLSA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdegjedggeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtth
    hopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhunhhshhhi
    nhgvsehsuhhnshhhihhnvggtohdrtghomh
X-ME-Proxy: <xmx:21UOZ2Uaar1hTZxbeClMJMPVIDxWELSqfEMy3JxYeYcPqTh1hiobNA>
    <xmx:21UOZ1m_QyEoEBhWFkNdDn8jo0HVa86fNnqigv9cH-giW4mhYWQfHQ>
    <xmx:21UOZzcLtRwRVLVneE3LiUV_CMG-yRn0u3zdvB7dTyXAsOtc1R6ubw>
    <xmx:21UOZ_HBelwmg_EpqMkgt6m7QVuK32Hdcw0q6Smc9QTauvxLCWfyVQ>
    <xmx:21UOZ7gA6dKTE1d2IAPMPWF3khLtZdU6YLdSstc4WRMQ7RTWdjbI5z4P>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 15 Oct 2024 07:45:30 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id e33a5212 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 15 Oct 2024 11:44:15 +0000 (UTC)
Date: Tue, 15 Oct 2024 13:45:28 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>, Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 07/10] t5500, t5601: skip tests which exercise paths with
 '[::1]' on Cygwin
Message-ID: <374f47bf3deb96843631882bd00e0f6f0fdc7287.1728992306.git.ps@pks.im>
References: <cover.1728906490.git.ps@pks.im>
 <cover.1728992306.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1728992306.git.ps@pks.im>

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

