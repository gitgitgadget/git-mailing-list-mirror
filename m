Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F130E1DD0D6
	for <git@vger.kernel.org>; Mon,  6 Jan 2025 11:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736162223; cv=none; b=XPDmn0QYtAHsIlmgQiqzODyDkgDW7DhtXxhekzHIQiRXDydW1lmmqyPo99B2ly6pmnZEYwwhejWCkd8a+6wmykEn9TNJMB6xBloJAUhk8rpMm+6+Gis+gNUPURXXDOh0rnj5DoUlISGugYU9IJIC4HDVIoUMwjQ1BUaYEwLgl1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736162223; c=relaxed/simple;
	bh=84uQVCFHujT6wpkXE8p9FyIG/nrxYqx2FKfv5UN5LIE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jR8dT67rHay+z3A5t5mO12ImS7aQ8eFeNNgHGxvhCSw4dyZezVY/Zu+T8DfX5wxTG/CI+JgefaUnXNLZfgJD1aTZ/KXqVyxiublC8zrd0VoGFzSCEttfPTX5BSsyGtddl8Pj78DM6/pcZNsNGwbqV9F//2TLBKmpQpBpWWkYXbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=K7HaE+QN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=rxSkutwG; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="K7HaE+QN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rxSkutwG"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 13CF21140192;
	Mon,  6 Jan 2025 06:16:56 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Mon, 06 Jan 2025 06:16:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1736162216;
	 x=1736248616; bh=/ilJODA6fgcD1ENAhqf8EtaO6YmHhyupxU3bxKUwuVk=; b=
	K7HaE+QNfMrI2XZiD1ka3g/DvmqLdjxTafZVk8fO2lklby1a0ZwtaT27rvZFCGb/
	DhZ0aYjxHeMNGgtwsbeBd8nIiz8FqOAqUOwgErHrVbTxsGqKgpZUiBrTX4YeEPR/
	kxoFw/pVqqu2w784U4HdWToUeqSI4xDjmZSaIm69VhzJ+yzTjrchstG6too+BCr2
	SmIZnXHefyWXqnQp73Cemg+UarXHWicU/CKaPEREC7VCiplodIYlq80EJvwGsfSi
	bKOr+ZIEPKBf4f2Lpb13LXxCQL5nTvhNHe1KYUiI5hB+WicAGH7v32Tnw9Kt7QPg
	SW5ur/ZUAlKc9b7+PvRSvA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1736162216; x=
	1736248616; bh=/ilJODA6fgcD1ENAhqf8EtaO6YmHhyupxU3bxKUwuVk=; b=r
	xSkutwGDCnxjOqm9Xfpi9ymLcTy89sdAobcScyygd+jjdnRVQlSWVed7MZt4uS1t
	hwBMCl7LU2M58smcZOG9ZWjWWolDuUV6aXer17A+Aaxpoq4raLn8eQH9wcu0OnI4
	+ihiR2t41Zju6WJeZ7GaBWsvD9Y/VdAoMW89EOmIU6oobQh8uQc8bfRl86ab5XKn
	0cwqBBTrIPYLZjHPM9sumTqtW2CZQ/hDAnaOzLHMy6NHYj3OLADE0wFTOgVV7gMk
	IQtBASo/+rLc0tXbWfhG951KWlwhQ7hTad3ob8dCYLSzIYH/4ABwo+1rqLoNmYs1
	y/8dL0j5pPcvBvBXK9U+g==
X-ME-Sender: <xms:p7t7Z_llqQDDBfGe4hLvxuw10jaxXfuUqM2SYQW63ijtQpVGdKbbJg>
    <xme:p7t7Zy09QLEYL4UYhmWMl-Ji94BotnkZt3QZLdXVqOZ2ZmvFlE_l_KXFjEvBuTFOR
    lWt_YiwiJXMGBl3UA>
X-ME-Received: <xmr:p7t7Z1rSLJLn01TrIal784Jcpzk3JGbhG8texdAbkaCE8LVf18vlrl_0vPlMz0sB2VXl19by51vvqsxSYakA3VkAYZFRT5l53xO-EUzQQQlb2g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudegtddgvdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhfffugg
    gtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghi
    nhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepffeuieduje
    dvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnh
    gspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphgvfhhf
    sehpvghffhdrnhgvthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpd
    hrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:p7t7Z3nY7b07UCT4_rHfINH-7tLPMy-_5YEB5CWceO3chyoD-JnpGg>
    <xmx:p7t7Z92lkUhIZJWUdzedLIirsO4nanAGU9-TLgD3c7N6SOnD2gIVwg>
    <xmx:p7t7Z2vJqs-39NhizDpXJp_v-HDdeRd6w_NwoGDLd9tl2GZeuh94Lg>
    <xmx:p7t7ZxV278e38PqLZooIwRfHXV65-w65VYVsmNdyL2ONCcrmTH-cdg>
    <xmx:qLt7Z2zRPE-h2Sv286Fu3Z8hEJFGAFvTMh-o4lrmlPMgWJu7lFeSZWYw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 6 Jan 2025 06:16:55 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id d85a3b01 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 6 Jan 2025 11:16:52 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 06 Jan 2025 12:16:51 +0100
Subject: [PATCH v2 02/10] t7422: fix flaky test caused by buffered stdout
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250106-b4-pks-ci-fixes-v2-2-06ae540771b7@pks.im>
References: <20250106-b4-pks-ci-fixes-v2-0-06ae540771b7@pks.im>
In-Reply-To: <20250106-b4-pks-ci-fixes-v2-0-06ae540771b7@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.2

One test in t7422 asserts that `git submodule status --recursive`
properly handles SIGPIPE. This test is flaky though and may sometimes
not see a SIGPIPE at all:

    expecting success of 7422.18 'git submodule status --recursive propagates SIGPIPE':
            { git submodule status --recursive 2>err; echo $?>status; } |
                    grep -q X/S &&
            test_must_be_empty err &&
            test_match_signal 13 "$(cat status)"
    ++ git submodule status --recursive
    ++ grep -q X/S
    ++ echo 0
    ++ test_must_be_empty err
    ++ test 1 -ne 1
    ++ test_path_is_file err
    ++ test 1 -ne 1
    ++ test -f err
    ++ test -s err
    +++ cat status
    ++ test_match_signal 13 0
    ++ test 0 = 141
    ++ test 0 = 269
    ++ return 1
    error: last command exited with $?=1
    not ok 18 - git submodule status --recursive propagates SIGPIPE

The issue is caused by us using grep(1) to terminate the pipe on the
first matching line in the recursing git-submodule(1) process. Standard
streams are typically buffered though, so this condition is racy and may
cause us to terminate the pipe after git-submodule(1) has already
exited, and in that case we wouldn't see the expected signal.

Fix the issue by making the writer fill the pipe buffer before we
execute git-submodule(1). Ideally, it would be git-submodule(1) itself
that does produce all that data, but it would require us to create a
large amount of submodules, which is inefficient. Instead, we use Perl
to print gibberish until the buffer is filled.

To verify that this works as expected one can apply the following patch
to the preimage of this commit, which used to reliably trigger the race:

    diff --git a/t/t7422-submodule-output.sh b/t/t7422-submodule-output.sh
    index f21e920367..9338c75626 100755
    --- a/t/t7422-submodule-output.sh
    +++ b/t/t7422-submodule-output.sh
    @@ -168,7 +168,7 @@ done

     test_expect_success !MINGW 'git submodule status --recursive propagates SIGPIPE' '
            { git submodule status --recursive 2>err; echo $?>status; } |
    -		grep -q X/S &&
    +		{ sleep 1 && grep -q X/S; } &&
            test_must_be_empty err &&
            test_match_signal 13 "$(cat status)"
     '

With the pipe-stuffing workaround the test runs successfully.

Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/t7422-submodule-output.sh | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/t/t7422-submodule-output.sh b/t/t7422-submodule-output.sh
index f21e9203678b94701281d5339ae8bfe53d5de0ed..976f91b0ebd9d82daee3802a212dd3f4031fe86b 100755
--- a/t/t7422-submodule-output.sh
+++ b/t/t7422-submodule-output.sh
@@ -167,8 +167,14 @@ do
 done
 
 test_expect_success !MINGW 'git submodule status --recursive propagates SIGPIPE' '
-	{ git submodule status --recursive 2>err; echo $?>status; } |
-		grep -q X/S &&
+	{
+		# Stuff pipe buffer full of input so that `git submodule
+		# status` will block on write; this script will write over
+		# 128kb.
+		perl -le "print q{foo} for (1..33000)" &&
+		git submodule status --recursive 2>err
+		echo $?>status
+	} | grep -q X/S &&
 	test_must_be_empty err &&
 	test_match_signal 13 "$(cat status)"
 '

-- 
2.48.0.rc1.245.gb3e6e7acbc.dirty

