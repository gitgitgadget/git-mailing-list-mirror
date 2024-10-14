Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0DB31A4F11
	for <git@vger.kernel.org>; Mon, 14 Oct 2024 12:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728908496; cv=none; b=o3YvtHMy6f/4eE0uD59FC3zRI8yTkhd+VYlyZqok2bzi9N9fP9SvNXjqZSkYbRKWDhG/YSlcgZwAR1dCSTNc2cCZ1I5LDkIVB6y4ycMz3lr/VP1JhSsk/6zxqGM67Ec9AClqF1yGICvwH8L3K4J5k+P99trQ1EnczwG142k6sJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728908496; c=relaxed/simple;
	bh=3Di1PMGv+1pequW/gFp4eOe1BSfvOsP6SJnMYscjywo=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YVOrpTqcz17ags0NVb6ZTLM+UVO261HirSnXxA+4cFvY0QzJn8DZOTtYLn+IInF2gmWx5e+T+/Me+M5bDrJRNNYRF9WgFwHWs0NFB5ozpqQidJV310hCUxuGBbUz/TyTNP1iqeWRlYinkSJj0eEepqMBXXcJqsgrMaPsBeBtq4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Vqq0R/Y4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TietlaYw; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Vqq0R/Y4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TietlaYw"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 53A15138023C
	for <git@vger.kernel.org>; Mon, 14 Oct 2024 08:21:34 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Mon, 14 Oct 2024 08:21:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1728908494; x=1728994894; bh=febV9xGy+l
	o581aaQTTofByR03Eq8ea7hVFn3qGA4SM=; b=Vqq0R/Y4n4Disqz82Va4La/ZTa
	weLxtVk/mFd9HKVEae/Jjw99JYUfxyZ9ceiHci/2KEsN/oKoJH9Yy9hMcK22S1L2
	7ND/XO50gTK3Uz0DPlul53Hq+JLnk8pB1tVNLdjEGGqyDkX2YUqbODuOQWfPc41a
	/ykSSLm9hWybLkP7KrRqgMeP9WMhkGctn/+c7pLfOsJOUC7BNfUgtTvV1gFqxCsv
	Mt00G77D0/Cok4rSh7gm+ZIwCkEVjIu4WOl+hGkKqKPQFhZTMLepQPytWqBErXqO
	rD1C8YDfshF9QNOsBoWZ87AhKlBYA+utEQqt6SygjgSSo6GDibBW17hhHrRA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1728908494; x=1728994894; bh=febV9xGy+lo581aaQTTofByR03Eq
	8ea7hVFn3qGA4SM=; b=TietlaYw7BYGpZaW2YVxHjxw7hIePUVJc3znQf6AGdSg
	pYkCSvu/whomysP30v1jZldVY9VsMVjLuT67oXb5ppBw3LXqg+F0EyljJ91WdN6p
	A45NZT3wp4yxh7AxLt4YaLTRzWNYyLMmsLGtXkh7k05ai1dhSahOhnBsZnU44xKp
	3dYxyukldQv6dBAB9uA6j365urs0GicfuMveSHVwNjQon5uabOf4QI+ymGHR9Q/A
	yxf4ak/80F9ck6ul563MNucw6RJoln1Sf6vgWu49dN2ZHD91xn3A6KfIjCyPPUMm
	1fespVe40inzEoLJDuNCBp3fBVkfi3SW5NOfc4Tchg==
X-ME-Sender: <xms:zgwNZyyWWBn_a7suB5ErtpgiR5cfBaHUI6Ool5_axXYIdPCvD8bbLQ>
    <xme:zgwNZ-SUKULbhhn2kXCmndxyEs2d6h-fnJ-UxGkK9XfeHsxhIj37c7MwxKH5OkvsQ
    mOVYDbqVoqw6wq_IQ>
X-ME-Received: <xmr:zgwNZ0WVCXnxJ5gvdRW7C8132AR9qcQqqLD_h_DPCHTNiku60DymhSkHcqpfIAHWvjpblmMm-PwNOEvV1yifItBC9I_05VSXqfh35rynHHHNfw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeghedghedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuf
    fkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhh
    rghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepheekfeefgeegvd
    egvdeffeehtedttdffjeeuffelgffgheefleffleejvdefheeinecuvehluhhsthgvrhfu
    ihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspg
    hrtghpthhtohepuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:zgwNZ4j4r9td06jiRbSRSFHrsax4ZUlV5GrTyi7lYDMKV8j3n4aUhg>
    <xmx:zgwNZ0DG2uzZFjqwbkTOZMnFzCmjs03qEMXqlwPpPCMumFWimYhxbg>
    <xmx:zgwNZ5KFKisWOH0uxQ67bJz4FGLNg__0gCGYi6Ony95d1wlUm5xUVA>
    <xmx:zgwNZ7CcUcbBJJV63j1TYrbrKKepi1ZdnqXckeyUl2cWyjxweeEsSQ>
    <xmx:zgwNZ96MChwJ06sQFbNBjZLHmlKetYUUytqhkaCQEFNU-JPsA2mwWaSq>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 14 Oct 2024 08:21:33 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id be596d2a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Mon, 14 Oct 2024 12:20:20 +0000 (UTC)
Date: Mon, 14 Oct 2024 14:21:31 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 07/10] t5500, t5601: skip tests which exercise paths with
 '[::1]' on Cygwin
Message-ID: <e1b9617f9439ce81172d7fde74369ab12407f5dd.1728906490.git.ps@pks.im>
References: <cover.1728906490.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1728906490.git.ps@pks.im>

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
2.47.0.dirty

