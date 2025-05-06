Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68399277021
	for <git@vger.kernel.org>; Tue,  6 May 2025 11:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746529202; cv=none; b=M66WOO4X8rg/bnnamqxs/L1InGAYABDlGkzk7HnPRyulRSl8HXOhxdufBUK5X8TaHBVRq5pgnNdUYr//E21nHg6yGTKNldsNg1ivsYpEAkMCmR36luGt3DSWXPnhh/OAVnJW2GWyOsNejFs+y4LRaW5lCzmyAhDznw8wtjfdghQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746529202; c=relaxed/simple;
	bh=oMNyfjXUgm78KB+5uxRH1weUYIDsYT7LH5Kj6N1+ZL4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=re9OdU4F6kc2v6+JUhhYSgzVRNNghcWFf72z5Lkhn4U4YakHNnWcfpBkrqxuc5iZy+X8nF96o+L9HpbC0JhVQUPQxrQrHD3YImDQ/G7j6YNw79SOL8WNMwDmgshW364MyixpWKVLEhNte4pikLtzzZcZPgQ4t/Di/TEPBOQPYhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=lN23tQ4L; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZPi1IPr7; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="lN23tQ4L";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZPi1IPr7"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id 7C8BF1380F9E
	for <git@vger.kernel.org>; Tue,  6 May 2025 06:59:59 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Tue, 06 May 2025 06:59:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1746529199;
	 x=1746615599; bh=AjJ1iM8rEU6Xy8a4aky7a+nG8xoxSetCXBUNJ7WWaKI=; b=
	lN23tQ4L+9rvincI2eUJGTJT3JbglotoKWZ9q/H1htCph7PAqtTd016UPIrzHUqx
	fGX49xuW78+FfZ1iCf194TIa974Mz0/ltPAUXK3jMSFuuKekDFvSsXyfqlIdch9j
	rmm1AT9Usku1oK/RSUjDAJcVi/ey4yPiQpBprNyt5iuK4iVRnbgg0xrO+BEkW5Xs
	WWmYy7kfRLUENiffH6lLaXmdkimT5dSN1C7U+sfROxqmGZUlfnFfyXJQfP+eZIh0
	nA5apREzHx+S7wuJ0TyJHSemUNlWh9X9Ie7vEIiyIM+ZAAXkXw/HUv5mQ+RXzg7P
	+ZH+3suOvAh4ET+okEZGNQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1746529199; x=
	1746615599; bh=AjJ1iM8rEU6Xy8a4aky7a+nG8xoxSetCXBUNJ7WWaKI=; b=Z
	Pi1IPr7sKrrk64MszHw0a6KREZnhKSXIEtmpvub1CdDX32IkeCYCG8pvea/i/Qg0
	YbLBxo6J0K0+ZOWS8mFc2uPKQh0RdVqqd7Z+wScqX7XREljEACaRKt4bWZQ/CC7o
	uYFn6+Hgoc9w1xJRhVODpwcixLCwlfL4CfHCD5ktNAAlkCxcQvxd8T5BJbHYkqH4
	25VnpaBvd0eoIu57UqndsNBRuK40x8UVEWRztY6j8Qprpie1hU2s1rzY++pzY26u
	Bcl6LVEA2lyQX5pmyM0RjpVhDUjv7yVCXIZHYVY4HuvHxT77e6286IDREEotaeJ6
	aHcq1tOS/76WZrehhZgew==
X-ME-Sender: <xms:r-sZaFgWxpWuUAW2VJJDci4aOvjKQtV3XWY7V3HsGPZoXGftHzRgyQ>
    <xme:r-sZaKCvgO6SmHznbe7zIxbe_Qa2pwoH92-rPSzhtEahD7X7G-qOPpN47Bilqqvxa
    4LWWbTPDMhM1XzlQw>
X-ME-Received: <xmr:r-sZaFHfdMljh_pSZV1PCnC8rzITWjp3z0rtHPpXgF1lZ5GNl78w_osBlUu3WUlUzv5KaphfPQ7mz8b9DJuZ46RjZ2DBQTtVzEz7FJuJ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvkeefkedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucgovfgvgihtqfhnlh
    ihqddqteefjeefqddtgeculdehtddmnecujfgurhephfffufggtgfgkfhfjgfvvefoseht
    jeertdertdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpsh
    esphhkshdrihhmqeenucggtffrrghtthgvrhhnpefhvddvvdetveekfeetgeevffeutdek
    hfehheeujedvieevvdekjeeiffeigefhueenucffohhmrghinheprgguuggpfhhilhgvrd
    hfohhonecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhep
    phhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddpmhhouggvpehsmhhtphhouhhtpd
    hrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:r-sZaKRH9SibeO0gJToMtaeJq57yiS-73dmSJCYXOdKX011OOfLwRA>
    <xmx:r-sZaCydQE64kUDqaH_SuOMX6BX9Zi92TwAUzHW4K2ubMBMAf1QWtw>
    <xmx:r-sZaA4QL-xGe-Jb66Z5D_G1knivBjY0q6mFxGlY1NELezvCbKQhyA>
    <xmx:r-sZaHz7-ztf3NqAvjyejxUosycEzwT2jdyKNGszztQUbgUwlZVC1A>
    <xmx:r-sZaGeZO2RJ0-FGbjof95QQvpWT__19hPzWYJgs0HMasMBhUhgf2W-P>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 6 May 2025 06:59:58 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 020f2242 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO)
	for <git@vger.kernel.org>;
	Tue, 6 May 2025 10:59:56 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 06 May 2025 12:59:50 +0200
Subject: [PATCH 1/4] t: fix cases where output breaks TAP format
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250506-pks-meson-tap-v1-1-5aaab2942a4c@pks.im>
References: <20250506-pks-meson-tap-v1-0-5aaab2942a4c@pks.im>
In-Reply-To: <20250506-pks-meson-tap-v1-0-5aaab2942a4c@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.2

The TAP format does not allow arbitrary output outside of a specific
test case. If a test suite wants to print any such diagnostic output,
then this output has to be prefixed with "#" to mark it accordingly.
A bunch of our tests generate output outside of `test_expect_*`
testcases anyway without such a mark, which breaks strict TAP parsers.

Upon further inspection, all of the output generated by such tests is
rather uninteresting. Refactor them so that we don't break the TAP
format.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/t1007-hash-object.sh                       |  2 +-
 t/t4041-diff-submodule-option.sh             |  4 ++--
 t/t4060-diff-submodule-option-diff-format.sh |  2 +-
 t/t7401-submodule-summary.sh                 |  4 ++--
 t/t9500-gitweb-standalone-no-errors.sh       | 14 +++++++-------
 5 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/t/t1007-hash-object.sh b/t/t1007-hash-object.sh
index b3cf53ff8c9..210cce56ec6 100755
--- a/t/t1007-hash-object.sh
+++ b/t/t1007-hash-object.sh
@@ -30,7 +30,7 @@ setup_repo() {
 
 test_repo=test
 push_repo() {
-	test_create_repo $test_repo
+	test_create_repo $test_repo >/dev/null
 	cd $test_repo
 
 	setup_repo
diff --git a/t/t4041-diff-submodule-option.sh b/t/t4041-diff-submodule-option.sh
index 28f9d83d4c1..31f359ddf1e 100755
--- a/t/t4041-diff-submodule-option.sh
+++ b/t/t4041-diff-submodule-option.sh
@@ -48,7 +48,7 @@ commit_file () {
 	git commit "$@" -m "Commit $*" >/dev/null
 }
 
-test_create_repo sm1 &&
+test_create_repo sm1 >/dev/null &&
 add_file . foo >/dev/null
 
 head1=$(add_file sm1 foo1 foo2)
@@ -236,7 +236,7 @@ test_expect_success 'typechanged submodule(submodule->blob)' '
 '
 
 rm -f sm1 &&
-test_create_repo sm1 &&
+test_create_repo sm1 >/dev/null &&
 head6=$(add_file sm1 foo6 foo7)
 fullhead6=$(cd sm1; git rev-parse --verify HEAD)
 test_expect_success 'nonexistent commit' '
diff --git a/t/t4060-diff-submodule-option-diff-format.sh b/t/t4060-diff-submodule-option-diff-format.sh
index 76b83101d3b..17ef40c0c9f 100755
--- a/t/t4060-diff-submodule-option-diff-format.sh
+++ b/t/t4060-diff-submodule-option-diff-format.sh
@@ -364,7 +364,7 @@ test_expect_success 'typechanged submodule(submodule->blob)' '
 '
 
 rm -f sm1 &&
-test_create_repo sm1 &&
+test_create_repo sm1 >/dev/null &&
 head6=$(add_file sm1 foo6 foo7)
 test_expect_success 'nonexistent commit' '
 	git diff-index -p --submodule=diff HEAD >actual &&
diff --git a/t/t7401-submodule-summary.sh b/t/t7401-submodule-summary.sh
index 9c3cc4cf404..80bbb1b7b5b 100755
--- a/t/t7401-submodule-summary.sh
+++ b/t/t7401-submodule-summary.sh
@@ -38,7 +38,7 @@ commit_file () {
 	git commit "$@" -m "Commit $*" >/dev/null
 }
 
-test_create_repo sm1 &&
+test_create_repo sm1 >/dev/null &&
 add_file . foo >/dev/null
 
 head1=$(add_file sm1 foo1 foo2)
@@ -215,7 +215,7 @@ test_expect_success 'typechanged submodule(submodule->blob)' "
 "
 
 rm -f sm1 &&
-test_create_repo sm1 &&
+test_create_repo sm1 >/dev/null &&
 head6=$(add_file sm1 foo6 foo7)
 test_expect_success 'nonexistent commit' "
 	git submodule summary >actual &&
diff --git a/t/t9500-gitweb-standalone-no-errors.sh b/t/t9500-gitweb-standalone-no-errors.sh
index 7679780fb87..84196a10896 100755
--- a/t/t9500-gitweb-standalone-no-errors.sh
+++ b/t/t9500-gitweb-standalone-no-errors.sh
@@ -701,13 +701,13 @@ test_expect_success \
 # syntax highlighting
 
 
-highlight_version=$(highlight --version </dev/null 2>/dev/null)
-if [ $? -eq 127 ]; then
-	say "Skipping syntax highlighting tests: 'highlight' not found"
-elif test -z "$highlight_version"; then
-	say "Skipping syntax highlighting tests: incorrect 'highlight' found"
-else
-	test_set_prereq HIGHLIGHT
+test_lazy_prereq HIGHLIGHT '
+	highlight_version=$(highlight --version </dev/null 2>/dev/null) &&
+	test -n "$highlight_version"
+'
+
+if test_have_prereq HIGHLIGHT
+then
 	cat >>gitweb_config.perl <<-\EOF
 	our $highlight_bin = "highlight";
 	$feature{'highlight'}{'override'} = 1;

-- 
2.49.0.1045.g170613ef41.dirty

