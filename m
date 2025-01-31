Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB9961B6D11
	for <git@vger.kernel.org>; Fri, 31 Jan 2025 10:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738320817; cv=none; b=D02WRbB7Ys26CXaOeXSUQ/64OXM0D77rMx3/Pareh0pvjZCkJ4nVaForUEn5QdIXRZOZcW0XQC/klGPw3IPZgrlhEtWfbMdDyZwrYwEEke1Kp/DsRa/9z6n9p10p7GA4xN7CEoOJ2r2T5cQuNoOsuvXLbun8yRx9kILEXSWtlao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738320817; c=relaxed/simple;
	bh=lZt4zNErN9sBh5DqGSH2drxCdpuvoFzSEnWqe8v7Vow=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HRkNgqQT1R7jdEhPosDR2F5TKqygMHVuzFuEs83jwuCgdqbnVWI9mWrkBDg0/FjZx46KsriEx3PLuseAFG0A1jaNTzMiXcx3Chhrd2HqSgZa3C9lXfFWD0eRZ+heRjuUQv67DA2527MVd9S9j67aT9P5ZGuZJY1BcadNpCayCRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=YkJqYr63; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=0rP68ard; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="YkJqYr63";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="0rP68ard"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id C6B391140101;
	Fri, 31 Jan 2025 05:53:33 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Fri, 31 Jan 2025 05:53:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1738320813;
	 x=1738407213; bh=PtLA/sjC39g2c0AYQeONFutL1BNWP5QHQyI0WKY2YYk=; b=
	YkJqYr63Kio7+w8w7zQBssgfTnRjGXgxtNcvOcZzfQWzauRN486e+Ua9d9Pt+qOz
	78obh4UjLlbvlG7pstlGt1ewetw32QYH80IpH3rI1HRPwEc2RnhMyPBduuqyhNKm
	VTcHYzO19LFadC6UZ3FW4ajUXkXDW4iXNWLbrFmKGY6GlFcyRFBD6xLadE9uur+c
	dD0JDxOwKvt+Pgpfi0oubsFpF6Guii1lySLP0P0916ym0UvW9gc1k6b5ryCZNmiR
	bc7NTFOjGHpcKE1U/xVI4bvJSwAv+FYTkuqiaEmjAMnoPlRRuaXTgmYqh8NbSepa
	jBvaC2a40ElP/8sTj999UA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1738320813; x=
	1738407213; bh=PtLA/sjC39g2c0AYQeONFutL1BNWP5QHQyI0WKY2YYk=; b=0
	rP68ardXuwWIHZRigBsWFPb+fCmVG8ef6dvdgFJdSWDwvyA9iKZbsEQhZ8fJ5uBj
	UTfmPr6jH+DR2Mt+Flizm5+miYmLfb9pU8J5sJKmU5WBGdWoWOU5/i7D7uKwRjXH
	DIqMS1KC29CkuNEXrW61bTkqpLSeukrzAzsRhPjh7bamzT8utwCh2iDo7ctT9sNw
	6b+Q2kjGs3WAN9/ZMhOl8CoC9P/CB0uYcTHHViQZ55U94YRvRYuZ+sr+C5Sx2rcn
	NbIHOE5jXl9k+YGQYIyjSsj7mp/49iYneNEoTNF70XPQKJFLTZvfajekZpjl3pjp
	DpscsN0m1koat8OSirxTQ==
X-ME-Sender: <xms:raucZz2m3zSoJPnOzWM25QJsP_mWX9kHoXOyhEV2Z9eTY2GE1L-OkA>
    <xme:raucZyGyxuDf-fqA08kOmLrGPGf-c78joAFhqka0mEO8ZoHGwA7ct2DviHBN-dM67
    5k4IYnp0ItAJceRkA>
X-ME-Received: <xmr:raucZz7WbwTu4j6iAG0ZKtOL43WjTLTyYLiioFs2HdWykvgCHUhovcmIZB0OFg4WAvsgXoVEGM1SJu2bUGO_-ACo274a85Cvjrt7GY-d_AoI2w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekheejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhfffugg
    gtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghi
    nhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepvdejteetff
    ehjeevledvffffffevhfffieejffeliefghfevieegffdvhedtkedunecuffhomhgrihhn
    pehhthhtphgurdhshhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtohepiihhihihohhurdhjgiesrghlihgsrggsrgdqihhntgdrtghomhdprhgtphht
    thhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:raucZ41YJeiyXBn3TSqaqtkRClCtEKyS8FOTq6W2hUQIKTtVL-pbSw>
    <xmx:raucZ2EmtYnbSLN-FCIxNo5ipy-_rYrWAevBimrRYPB-aDmiAUzAbw>
    <xmx:raucZ58Z72Lgj_CsuHiP89NyR3qtmCO8tzHA-Bh-p4rQWkFzhwQrDA>
    <xmx:raucZzlUBOQYTBnCDlhLqyY4ATtR4f-Nc9nqi_p36pNv8nGTqjniCg>
    <xmx:raucZyB0X5ze25PI1QYprsYxQyZhluaAQYQvB6NtXELGHJIHlrgBRiO1>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 31 Jan 2025 05:53:32 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 6310c25e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 31 Jan 2025 10:53:28 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 31 Jan 2025 11:53:26 +0100
Subject: [PATCH v4 2/8] t5548: refactor to reuse setup_upstream() function
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250131-pks-push-atomic-respect-exit-code-v4-2-a8b41f01a676@pks.im>
References: <20250131-pks-push-atomic-respect-exit-code-v4-0-a8b41f01a676@pks.im>
In-Reply-To: <20250131-pks-push-atomic-respect-exit-code-v4-0-a8b41f01a676@pks.im>
To: git@vger.kernel.org
Cc: Jiang Xin <zhiyou.jx@alibaba-inc.com>, 
 Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.2

From: Jiang Xin <zhiyou.jx@alibaba-inc.com>

Refactor the function setup_upstream_and_workbench(), extracting
create_upstream_template() and setup_upstream() from it. The former is
used to create the upstream repository template, while the latter is
used to rebuild the upstream repository and will be reused in subsequent
commits.

To ensure that setup_upstream() works properly in both local and HTTP
protocols, the HTTP settings have been moved to the setup_upstream() and
setup_upstream_and_workbench() functions.

Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/t5548-push-porcelain.sh | 85 ++++++++++++++++++++++++++++++-----------------
 1 file changed, 55 insertions(+), 30 deletions(-)

diff --git a/t/t5548-push-porcelain.sh b/t/t5548-push-porcelain.sh
index 6282728eaf..a3defd5b75 100755
--- a/t/t5548-push-porcelain.sh
+++ b/t/t5548-push-porcelain.sh
@@ -54,29 +54,67 @@ format_and_save_expect () {
 	sed -e 's/^> //' -e 's/Z$//' >expect
 }
 
+create_upstream_template () {
+	git init --bare upstream-template.git &&
+	git clone upstream-template.git tmp_work_dir &&
+	create_commits_in tmp_work_dir A B &&
+	(
+		cd tmp_work_dir &&
+		git push origin \
+			$B:refs/heads/main \
+			$A:refs/heads/foo \
+			$A:refs/heads/bar \
+			$A:refs/heads/baz
+	) &&
+	rm -rf tmp_work_dir
+}
+
+setup_upstream () {
+	if test $# -ne 1
+	then
+		BUG "location of upstream repository is not provided"
+	fi &&
+	rm -rf "$1" &&
+	if ! test -d upstream-template.git
+	then
+		create_upstream_template
+	fi &&
+	git clone --mirror upstream-template.git "$1" &&
+	# The upstream repository provides services using the HTTP protocol.
+	if ! test "$1" = "upstream.git"
+	then
+		git -C "$1" config http.receivepack true
+	fi
+}
+
 setup_upstream_and_workbench () {
+	if test $# -ne 1
+	then
+		BUG "location of upstream repository is not provided"
+	fi &&
+	# Assign the first argument to the variable upstream;
+	# we will use it in the subsequent test cases.
+	upstream="$1"
+
 	# Upstream  after setup : main(B)  foo(A)  bar(A)  baz(A)
 	# Workbench after setup : main(A)
 	test_expect_success "setup upstream repository and workbench" '
-		rm -rf upstream.git workbench &&
-		git init --bare upstream.git &&
-		git init workbench &&
-		create_commits_in workbench A B &&
+		setup_upstream "$upstream" &&
+		rm -rf workbench &&
+		git clone "$upstream" workbench &&
 		(
 			cd workbench &&
+			git update-ref refs/heads/main $A &&
 			# Try to make a stable fixed width for abbreviated commit ID,
 			# this fixed-width oid will be replaced with "<OID>".
 			git config core.abbrev 7 &&
-			git remote add origin ../upstream.git &&
-			git update-ref refs/heads/main $A &&
-			git push origin \
-				$B:refs/heads/main \
-				$A:refs/heads/foo \
-				$A:refs/heads/bar \
-				$A:refs/heads/baz
+			git config advice.pushUpdateRejected false
 		) &&
-		git -C "workbench" config advice.pushUpdateRejected false &&
-		upstream=upstream.git
+		# The upstream repository provides services using the HTTP protocol.
+		if ! test "$upstream" = "upstream.git"
+		then
+			git -C workbench remote set-url origin "$HTTPD_URL/smart/upstream.git"
+		fi
 	'
 }
 
@@ -88,7 +126,7 @@ run_git_push_porcelain_output_test() {
 		;;
 	file)
 		PROTOCOL="builtin protocol"
-		URL_PREFIX="\.\."
+		URL_PREFIX=".*"
 		;;
 	esac
 
@@ -247,10 +285,8 @@ run_git_push_porcelain_output_test() {
 	'
 }
 
-# Initialize the upstream repository and local workbench.
-setup_upstream_and_workbench
+setup_upstream_and_workbench upstream.git
 
-# Run git-push porcelain test on builtin protocol
 run_git_push_porcelain_output_test file
 
 ROOT_PATH="$PWD"
@@ -258,21 +294,10 @@ ROOT_PATH="$PWD"
 . "$TEST_DIRECTORY"/lib-httpd.sh
 . "$TEST_DIRECTORY"/lib-terminal.sh
 start_httpd
-
-# Re-initialize the upstream repository and local workbench.
-setup_upstream_and_workbench
-
-test_expect_success "setup for http" '
-	git -C upstream.git config http.receivepack true &&
-	upstream="$HTTPD_DOCUMENT_ROOT_PATH/upstream.git" &&
-	mv upstream.git "$upstream" &&
-
-	git -C workbench remote set-url origin $HTTPD_URL/smart/upstream.git
-'
-
 setup_askpass_helper
 
-# Run git-push porcelain test on HTTP protocol
+setup_upstream_and_workbench "$HTTPD_DOCUMENT_ROOT_PATH/upstream.git"
+
 run_git_push_porcelain_output_test http
 
 test_done

-- 
2.48.1.502.g6dc24dfdaf.dirty

