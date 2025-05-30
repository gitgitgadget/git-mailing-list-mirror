Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B43AE14F125
	for <git@vger.kernel.org>; Fri, 30 May 2025 13:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748611914; cv=none; b=UIdwdmqKNGJOLLP9M6+voOsEn/xTAt+W0mLP+zJfAkUj8R4uIjrSn0FOO2ltBs7/go/GoaYZ/foEdIe04eN3iXQqqcLsBTaIfekVxocZdwjkpxvdRPLyEz0M5+TzGxbMx5Mfz2CJkp9aHddC6Xz2RuRD/mw0h9Yv3PiJBG+/Gtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748611914; c=relaxed/simple;
	bh=4UHc5SMtBNAhxk2Ks51Ortmr0M1W7T27ATorWzAvB0Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YTsK9ykE/E/RB1coHVATh7CCaaF3IOyoEe7kkXCnsCQ4M61NPWdi6jwuxWtauyUzWX5UKsUm0KhAb0ATTMS1MOpEBsq0SMCuSzUtTAtFegDJ0uMg4fsf+YUdonjtnXbY5X8bIZVsKG2QajvhTgpB5c6S2yewhfSd2LDtPjnUw1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=AmlEI4b5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AiF1Kpsk; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="AmlEI4b5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AiF1Kpsk"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id C743B11400F1;
	Fri, 30 May 2025 09:31:51 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Fri, 30 May 2025 09:31:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1748611911;
	 x=1748698311; bh=VKOg6JTux+7eyq8n4DIlpjbDARlE4mEz3HyekfFoG9U=; b=
	AmlEI4b5fbI+wPwvTn9ZVozB60gAyw/CM9+uYxgNVoWbwVFnbDnmZfL+aFlT5Gqg
	TMnCHxxrLq0dchINCylvpeSGhS585T8/RV70YEeyuu8A8YqxLyTmPNZIu+5YDVwc
	gJALZuBLXSv70bOw2YOmIO5ubf9APBuuBr3IPjyLmD7PF33S9V2HDoFBbRz34ban
	5ufexlEKqS8Tee8aR0yOHQBlRCHR9hLgNJ49DUtTYkoBWi6SNAGPJp0YCqQyCy2v
	vug+0nYMlpxdtjZT199oLmY5UUo0KW0JxwhYBgLnA3F3KtSNEKViDZYxqmhAcG/t
	0Gi8J2QkqVevKoKEiqNuRw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1748611911; x=
	1748698311; bh=VKOg6JTux+7eyq8n4DIlpjbDARlE4mEz3HyekfFoG9U=; b=A
	iF1Kpskqhojw1igBKRI0VaGlSk4SUc+6b09UqnCOCEgWrde4prz9qwRp/ZrekaOx
	uQ8COeFfPzDY1hQdR1bitzlF4Uc787RDd0xtouQKoUdj3O+9MYqXwEzdxZaO5/Gy
	NiOWW3be/KyRecytqYzMWpUnX46L+a7e+C1yx+60r/d0jpHs13qBhTzPTdBB7P0j
	XlmnzPazF50O1caSPv22c+z6kvinATBYyDiFdPyHcGWLZl5WwkpJVNI35vZxNuJ/
	dp0/fgVxzXPW1Heuz+bFvbPY/nrzxXfSzgL0gueJ6co4mUAoINoP65xQM6CP4c2D
	9bGMZPW1uVOeBlTHlMBMQ==
X-ME-Sender: <xms:R7M5aKR0KZxI24FnrsqZcSG6CNWOpbWgs5aR7Wclu5mm3PQPpVRJOA>
    <xme:R7M5aPwdmMPEgu9qT-6JOqD45rRIfDW919Qm3VpeUx8TeAbWG27i0A9t36JF1S5Nf
    mHx2Fa9QJC_JhZsMg>
X-ME-Received: <xmr:R7M5aH2EZRaPfqeN-z1sZtWtraRYBn1zDzl4iAsYta6kbolWlhxcpAK46sP2_eedmJGPPFudU9E1-KwZ03HhmODZsAG6yO1XjN8HG7P21Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgddvledugeculddtuddrgeefvddrtd
    dtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggft
    fghnshhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftd
    dtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffk
    fhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrg
    hrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeeh
    uedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghr
    tghpthhtohepkedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepkhgrrhhthhhikh
    drudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehphhhilhhlihhprdifohhougdu
    vdefsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlh
    drohhrghdprhgtphhtthhopegvshgthhifrghrthiisehgvghnthhoohdrohhrghdprhgt
    phhtthhopehtmhiisehpohgsohigrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesph
    hosghogidrtghomhdprhgtphhtthhopehrrghmshgrhiesrhgrmhhsrgihjhhonhgvshdr
    phhluhhsrdgtohhmpdhrtghpthhtohepshhunhhshhhinhgvsehsuhhnshhhihhnvggtoh
    drtghomh
X-ME-Proxy: <xmx:R7M5aGAjYYyx3C0_HodIZlr0ozjTMzOSQuRwDSWZ0c5UXPT3RyHFOg>
    <xmx:R7M5aDgU6COMu7Xgcextu3RUFl8Ec_P77YKnDdDD18HK0YsO_wl8MQ>
    <xmx:R7M5aCqIgYD_-s8kV3K2nlxE2JghB6MtpMZyliXyvaeZmjTwEUiNvw>
    <xmx:R7M5aGhH0nzi2XHCBv0WZCjccPUscgvx5xgHgSis8pbjKmcEXTS5Ew>
    <xmx:R7M5aH1zxMuQOsFVe_mE-iNkOr-joI-SMFjCLKawBglQKKma7awC55Am>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 30 May 2025 09:31:50 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 41e357eb (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 30 May 2025 13:31:47 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 30 May 2025 15:31:40 +0200
Subject: [PATCH v3 02/10] t: silence output from `test_create_repo()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250530-pks-meson-tap-v3-2-676f5e41f2e4@pks.im>
References: <20250530-pks-meson-tap-v3-0-676f5e41f2e4@pks.im>
In-Reply-To: <20250530-pks-meson-tap-v3-0-676f5e41f2e4@pks.im>
To: git@vger.kernel.org
Cc: Phillip Wood <phillip.wood123@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>, Karthik Nayak <karthik.188@gmail.com>, 
 Ramsay Jones <ramsay@ramsayjones.plus.com>, 
 Eli Schwartz <eschwartz@gentoo.org>, Todd Zullinger <tmz@pobox.com>, 
 Eric Sunshine <sunshine@sunshineco.com>
X-Mailer: b4 0.14.2

There are a couple users of `test_create_repo()` that use this function
outside of any test case. This function is nowadays only a thin wrapper
around `git init`, which by default prints a message to stdout that the
repository has been initialized. The resulting output may thus confuse
TAP parsers.

Refactor these users to instead create the repository in a "setup" test
case so that we don't explicitly have to silence them. There's one
exception in t1007: we use `push_repo()` and its `pop_repo()` equivalent
multiple times, so to reduce the noise introduced by this patch we
instead silence this invocation.

While at it, convert callsites to use git-init(1) directly as the
`test_create_repo()` function has been deprecated in f0d4d398e28
(test-lib: split up and deprecate test_create_repo(), 2021-05-10).

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/t1007-hash-object.sh                       |  2 +-
 t/t4041-diff-submodule-option.sh             | 22 +++++++++++++---------
 t/t4060-diff-submodule-option-diff-format.sh |  9 ++++++---
 t/t7401-submodule-summary.sh                 | 18 +++++++++++-------
 4 files changed, 31 insertions(+), 20 deletions(-)

diff --git a/t/t1007-hash-object.sh b/t/t1007-hash-object.sh
index b3cf53ff8c9..2cd0be7ba76 100755
--- a/t/t1007-hash-object.sh
+++ b/t/t1007-hash-object.sh
@@ -30,7 +30,7 @@ setup_repo() {
 
 test_repo=test
 push_repo() {
-	test_create_repo $test_repo
+	git init --quiet $test_repo
 	cd $test_repo
 
 	setup_repo
diff --git a/t/t4041-diff-submodule-option.sh b/t/t4041-diff-submodule-option.sh
index 28f9d83d4c1..e4289a1b71b 100755
--- a/t/t4041-diff-submodule-option.sh
+++ b/t/t4041-diff-submodule-option.sh
@@ -48,11 +48,12 @@ commit_file () {
 	git commit "$@" -m "Commit $*" >/dev/null
 }
 
-test_create_repo sm1 &&
-add_file . foo >/dev/null
-
-head1=$(add_file sm1 foo1 foo2)
-fullhead1=$(cd sm1; git rev-parse --verify HEAD)
+test_expect_success 'setup submodule' '
+	git init sm1 &&
+	add_file . foo &&
+	head1=$(add_file sm1 foo1 foo2) &&
+	fullhead1=$(cd sm1 && git rev-parse --verify HEAD)
+'
 
 test_expect_success 'added submodule' '
 	git add sm1 &&
@@ -235,10 +236,13 @@ test_expect_success 'typechanged submodule(submodule->blob)' '
 	test_cmp expected actual
 '
 
-rm -f sm1 &&
-test_create_repo sm1 &&
-head6=$(add_file sm1 foo6 foo7)
-fullhead6=$(cd sm1; git rev-parse --verify HEAD)
+test_expect_success 'setup submodule' '
+	rm -f sm1 &&
+	git init sm1 &&
+	head6=$(add_file sm1 foo6 foo7) &&
+	fullhead6=$(cd sm1 && git rev-parse --verify HEAD)
+'
+
 test_expect_success 'nonexistent commit' '
 	git diff-index -p --submodule=log HEAD >actual &&
 	cat >expected <<-EOF &&
diff --git a/t/t4060-diff-submodule-option-diff-format.sh b/t/t4060-diff-submodule-option-diff-format.sh
index 76b83101d3b..dbfeb7470bc 100755
--- a/t/t4060-diff-submodule-option-diff-format.sh
+++ b/t/t4060-diff-submodule-option-diff-format.sh
@@ -363,9 +363,12 @@ test_expect_success 'typechanged submodule(submodule->blob)' '
 	diff_cmp expected actual
 '
 
-rm -f sm1 &&
-test_create_repo sm1 &&
-head6=$(add_file sm1 foo6 foo7)
+test_expect_success 'setup' '
+	rm -f sm1 &&
+	git init sm1 &&
+	head6=$(add_file sm1 foo6 foo7)
+'
+
 test_expect_success 'nonexistent commit' '
 	git diff-index -p --submodule=diff HEAD >actual &&
 	cat >expected <<-EOF &&
diff --git a/t/t7401-submodule-summary.sh b/t/t7401-submodule-summary.sh
index 9c3cc4cf404..66c3ec2da22 100755
--- a/t/t7401-submodule-summary.sh
+++ b/t/t7401-submodule-summary.sh
@@ -38,10 +38,11 @@ commit_file () {
 	git commit "$@" -m "Commit $*" >/dev/null
 }
 
-test_create_repo sm1 &&
-add_file . foo >/dev/null
-
-head1=$(add_file sm1 foo1 foo2)
+test_expect_success 'setup submodule' '
+	git init sm1 &&
+	add_file . foo &&
+	head1=$(add_file sm1 foo1 foo2)
+'
 
 test_expect_success 'added submodule' "
 	git add sm1 &&
@@ -214,9 +215,12 @@ test_expect_success 'typechanged submodule(submodule->blob)' "
 	test_cmp expected actual
 "
 
-rm -f sm1 &&
-test_create_repo sm1 &&
-head6=$(add_file sm1 foo6 foo7)
+test_expect_success 'setup submodule' '
+	rm -f sm1 &&
+	git init sm1 &&
+	head6=$(add_file sm1 foo6 foo7)
+'
+
 test_expect_success 'nonexistent commit' "
 	git submodule summary >actual &&
 	cat >expected <<-EOF &&

-- 
2.50.0.rc0.604.gd4ff7b7c86.dirty

