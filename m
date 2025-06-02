Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AD0C1A00ED
	for <git@vger.kernel.org>; Mon,  2 Jun 2025 06:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748846696; cv=none; b=pLOAW4xEkxh0VNzHCJiXbxpChQXSlgXerTwEZw0kynC6yDj9Jr9b73Sy3sKnqX6thhnXyFi3ZfpC7dPTu1HtDBkygJblpAdu+f2Gp+9QczSq6rMkw8d0Zbs+mctMuMJg2NWNlwIi3VhQks73urLF7flyHPYkHhz7EdGSpzYYQ+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748846696; c=relaxed/simple;
	bh=Wh5MMoz8ykj1K1MwDr4XmJs0Uwrb8t3CaUuLrSwYYSo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YkuNBDjdAA7Y3l9tY1uqfG082HT+X3RUQ/1qTL6BAA72JH7ezW7Mdg5906XC6/OypqyXoqXaH/TEKQmE5s6VrwxAal6EtwMrAf74oF7WOrAd62+NmSCHG6kKhl0jnxUA1+eRxbJWs/Nzn9CKdETYIt2/maFAhPlhIRd+CBuGJJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=DqSMy+92; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Cdv47x7S; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="DqSMy+92";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Cdv47x7S"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfout.stl.internal (Postfix) with ESMTP id 5F8BF114014B;
	Mon,  2 Jun 2025 02:44:53 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Mon, 02 Jun 2025 02:44:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1748846693;
	 x=1748933093; bh=QNwXxBnc7tmAbR/YV3oWug9Dq4FGym616bUBtH2kp9I=; b=
	DqSMy+92V+9bfhLhYS8JBbSEfQ6NPaHQ0aOAfgc/mAnItudjDaEIjY6Grnv4LplY
	B6fGhvLwGevLZR+Re8woUyom9ey5zA+NE/zFwGXiKGTyPTMHJMibv8hscu/0JeBQ
	dd0Yljmn6vY5bNNBR0+d66MwvIbccEDVlokarsPOrVq6r3bW9ZpJSw0tB16eyMte
	pYL6G7HVMnI+QjvnEDnNy8fibp1/CDFE5lVmILKEYR2rI1bB+IceshJKTGYaK+0P
	sJ07jAvt5pj3IHAQNGIJTtBSiekv2U49Nzoo8P2CIEIlb1Gtr9986S3cIGvi1veI
	6J5CmZTAtpcjp9fVwXRVCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1748846693; x=
	1748933093; bh=QNwXxBnc7tmAbR/YV3oWug9Dq4FGym616bUBtH2kp9I=; b=C
	dv47x7SqQHOxbYYr2UgpnMKpWY5ljFhx826h3iuaOOyugvmvfTnIHFFC32q0zV34
	CL861HLOLa1y4LY5XULz9bmrsHZQQM2Tv7ZjR8K9RkxHPhIwv80va37+Al1xHl4t
	r1AUeKTL0UtwJW4woUvpeZI8CS/69w3AbBRoykS+2xDEW4O+VgPB3CBGw6U8A/1m
	wO7gJDbDxZdDKdTeHSgJ6tfXXXDI6lfW9KUcGWyOLrCaoFfFcXKCeNAPynGaSO8y
	DDs4Cgkm7zm89KT2T3dyYxvEthX820fXuTgF4J84CC8bp7DcBJVUt1QBBYxRdL0K
	EuQltUr+MZIKjLVhZKhyA==
X-ME-Sender: <xms:ZEg9aF8ro3jDBFONpXFefY-YXOhv-iTgzgy7gLYAcGSgnUuwBpNVYA>
    <xme:ZEg9aJvt-pukM5BIRki5QjDaRSiShtcDB_gjLC6Hx5oYT8Q6ISCTEjEuc5ANHvUS6
    sUUDicpi3VHSdhwiA>
X-ME-Received: <xmr:ZEg9aDDFlEeBLa83OfzHEjU9xiOtLfSOPhNi1x6udloEy-4p33nttBYIuRItJzitVyBScSZfOy6G8GDBC4y644bsgAXWOIW1OkJLTxIxwmkuww>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgdefieelleculddtuddrgeefvddrtd
    dtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggft
    fghnshhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftd
    dtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffk
    fhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrg
    hrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeeh
    uedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghr
    tghpthhtohepkedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvg
    hrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehsuhhnshhhihhnvgesshhunhhshhhi
    nhgvtghordgtohhmpdhrtghpthhtohepvghstghhfigrrhhtiiesghgvnhhtohhordhorh
    hgpdhrtghpthhtoheprhgrmhhsrgihsehrrghmshgrhihjohhnvghsrdhplhhushdrtgho
    mhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepph
    hhihhllhhiphdrfihoohguuddvfeesghhmrghilhdrtghomhdprhgtphhtthhopehtmhii
    sehpohgsohigrdgtohhmpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilh
    drtghomh
X-ME-Proxy: <xmx:ZEg9aJeBpNDojV9uQ2hza5JwMHT4Y6HXwyaGSTlzoPaoRQFh8lgfAQ>
    <xmx:ZEg9aKOb8EewOzfSiO_O8WLgf0BwDKWKx0beum1uNrzmjDQccM9BQQ>
    <xmx:ZEg9aLlScSJxgO7Es-O_r_WvZC5GGaFaQakz4Grm3mMc0yt5hkEKmw>
    <xmx:ZEg9aEsAvJ3q--W_pj2oAnn8rjxfjytZc6KELqaGE1rKdnHZtBT5pw>
    <xmx:ZUg9aHibjOd3jb1gy-6u3UK3I5xZQ_EwghWPtK3JlnCBPuyCsCzTTBum>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Jun 2025 02:44:51 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 7e08daa4 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 2 Jun 2025 06:44:47 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 02 Jun 2025 08:44:42 +0200
Subject: [PATCH v4 02/10] t: silence output from `test_create_repo()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250602-pks-meson-tap-v4-2-052dfde0818a@pks.im>
References: <20250602-pks-meson-tap-v4-0-052dfde0818a@pks.im>
In-Reply-To: <20250602-pks-meson-tap-v4-0-052dfde0818a@pks.im>
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
index 28f9d83d4c1..4d4aa1650fe 100755
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
+test_expect_success 'setup submodule anew' '
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
2.50.0.rc0.629.g846fc57c9e.dirty

