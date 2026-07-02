Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9302147D947
	for <git@vger.kernel.org>; Thu,  2 Jul 2026 12:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782993674; cv=none; b=HfRAOavaZgbZtb6+5VO+hRznSqgI2LOTDv5RuggeXamHSAfmnWEIfcaGxKw8MWQOPxHzVdT96ecZouqgOo/hn/BEV0d8EEcR9mr+OD4r8mZZJwaICULIF3vpnzpHfBk0v7BRXuaY69for029LTi5qpXQHKkwZVJRiAjTvB/leRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782993674; c=relaxed/simple;
	bh=l4UBjbTL1gWgIb+oCWbw3vBeBTl3CZAZAWnXA50peFg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jRNNjAdHI/+k2JqOCDZFQ+2sFKB/iZf2I9MNUkYtmVXgZ0zAWcvETEc/TLIXfBXU/VI56b1Gysek1Kk2CJe0AlmQxjp0zoDVUEwVXD11fzu2WESN9RP9KoDk7Gpg2nR2O74A97X3+OoFphN0rXQmjWhpjxV6mN50kI0eNYkCxVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=dOj5m02J; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lAiokRbg; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="dOj5m02J";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lAiokRbg"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id E54B91D00038;
	Thu,  2 Jul 2026 08:01:12 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Thu, 02 Jul 2026 08:01:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1782993672;
	 x=1783080072; bh=4ledEEyP6D1dARBfoN4OI4yKdAZEaMoxYe2R4uS88Xc=; b=
	dOj5m02JyHJRL2cFm4CaoN4bk+HP4+Fz8mK0VhyGc9mwvXu/Iog1tiRAUbItcbzo
	btTdP4v9FkXBbwSDSbgqBIKiMyztmTXdEY8ydPtD1wyit9LdoAw9JK0QJq6NxO+S
	ph81SvdMREzFHuI5biJCI3/RCooKwsLnSUUQW/QWsxn+Xandmj90U5eIgNVB/FKM
	SKlAh9YY+cfUJlD7DS/t+aoN3nfRo28WLe0uH0WsQQsOx6UtUw4kBttOQRdAaOyU
	cAdtFwQSTjiVPZRMJuW73lo/aorm3DsUqfpMAvEHRKnR2TiZshO0ocLNbG0QNJ/6
	bGYEqJkKRWyzvtTQGTpfjA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1782993672; x=
	1783080072; bh=4ledEEyP6D1dARBfoN4OI4yKdAZEaMoxYe2R4uS88Xc=; b=l
	AiokRbgmnpdva9Onje+qdDfb1lmDwG1/UE70etIYBwu+WH7p/MmCi8B3hO0EzHJP
	E8g9lrYiPJRan2oJcubFXw6pc4bSU9HXbHUEgy9L4EvHaKIORupOoR4BOg48eVL/
	otHkvYsmVMasPw7gmb/zLIWVK6TaINe8IOHLQriLQooAdoOXid3aoo7Y/NE1+/NO
	rFsPw3kxeodwMPErqaWI5Z8AwG4Ek0ikZp3NmJGrebS6XVjetr5/khFbQjUqPFGI
	N31o+qhnkOPjbH3uI7rQaZcmUvoPMi/7F4p4GJogJg1Wfw5kLoa+W0/P3mfLtO1h
	EQOIZagzFFl5AMI5bFyJA==
X-ME-Sender: <xms:CFNGahM5i4Q3mEmhBoCNMrnhYdzR8fo-_KruT3ZzstNbWaD__f8rPw>
    <xme:CFNGarZW5E2lfEp5XoRncnOtOSjChYMO3qZ8XuAOM7r7N19XI36ewqa-UW25WQQB5
    OTdQeTxgplcWkxHzozyonQsjhN-yuAnFzH1FWhxsKipWZdELoLd3A>
X-ME-Received: <xmr:CFNGatp3ZkiEFeFzRTPO38z7YxKGbnED3y8Lss_7pMJ66F9tenXFqNeTRMZR-ojlFf8NP5LDPY7Zwz1YJO3vPF-A0fiOtSU-2OCD5omaLChUDw>
X-ME-Proxy-Cause: dmFkZTFq7YBXd34E3oKLbU9QoJDzZu1SA0HD/2618r+TdBaFUyYiI3/D0H3cg7pIWe5P7j
    6adEx1nwQuyPEDK8gBVp7Dj6BJB+4VhrrDabi4MCd2l8Dg9Rp9Zn0yBk/sUjhTrI9w4rWW
    AIaFBJZfG7w1qUhCNib+yYWChSi23zgbTECZJVOSqaUA+hdbQBGxoKKCJbTsHmyL6+3q4X
    tkFNRTpe6u5Zs0dvX1k7kUQ7rsAiUnmwun/4Ja9PNPI8Z9BBvPTORyNVgFKE9iqLgtDQpX
    W8eH51QB4nClwUU5Vc5BbRscIWdQEJlrAkhl0RMI4INjjJIdZFhbUkPupFwoJ6mciZyPAf
    pT4+LZK/N2Z24Kd+G/8AMD45o4nvGJY+cvjcUmrvt2IXDoxNftoHTgtIFZAziYfa5g3g7p
    7CmPg7Y9J+4+NEg4AK0oOjQvdr+tG8EJ9aDa6ODS9qI9mNkBfEGMXTm9Oe39lmQN7eZm1+
    siIxB76PKSz5ivf8BlrD1rRzdEODIXVwjyl3a0/kmnOy36YChuxYDItiQWODuk3X7w/jr/
    iaT5ytfCArmhRtDaBZz/FaNtz3HijzY7vTINjjJMe6QsIho+SIGSRvKSP+7Lxf1k0Ng2hV
    tkYzuFX+7F+E7tyqmD9Frdx8jlaC0SiwPWCEun/9X/quuFLpWbh21bJ8W+pA
X-ME-Proxy: <xmx:CFNGanZnEVUZeflkiRPLTNCUuNE_RdxUOZEunWHiSWwvW_pOFJISKQ>
    <xmx:CFNGatSMhvpluqfINk8oQ3N_86PFLHvmJfK-OfnMPNAyUP41Wx4ycA>
    <xmx:CFNGam7v0UOngGsLTJAmexLC2D7aI7FEf0jBEk2PqTuA0PKU-QKYdw>
    <xmx:CFNGaqzPugjg5KsVStUU7lnZIy4kBoP4e-jHRgvZF5VWfwwCpOKXjw>
    <xmx:CFNGat_qrrBUa3K6fUxHOg3M06NwaHsjIjsPC_fvpKXeb5y1Ov-NT4_e>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 2 Jul 2026 08:01:11 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id c867d01c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 2 Jul 2026 12:01:10 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 02 Jul 2026 14:00:56 +0200
Subject: [PATCH 3/9] t4141: fix inefficient use of dd(1)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260702-b4-pks-t-fixes-for-GIT-TEST-LONG-v1-3-76b4d7bab3d0@pks.im>
References: <20260702-b4-pks-t-fixes-for-GIT-TEST-LONG-v1-0-76b4d7bab3d0@pks.im>
In-Reply-To: <20260702-b4-pks-t-fixes-for-GIT-TEST-LONG-v1-0-76b4d7bab3d0@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, 
 Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-Mailer: b4 0.15.2

In t4141 we generate a patch that is roughly 1GB in size to verify that
git-apply(1) indeed rejects that patch. We generate that patch by
prepending a patch header and then executing `test-tool genzeros`
without a limit. This causes us to print infinitely many zeros, and we
limit the overall amount of generated bytes via `test_copy_bytes`.

This test setup is extremely expensive, as `test_copy_bytes` is
implemented via `dd ibs=1 count="$1"`, which copies data one byte at a
time. So as we write 1GB of data, we end up doing 1 billion reads and
writes. This naturally takes a while: it takes 6 minutes on my system,
and around 40 minutes in some CI jobs!

We can do much better though, as genzeros already knows to handle an
optional limit of how much data it is supposed to write, which allows us
to remove the call to `test_copy_bytes`. Furthermore, it has already
been optimized to generate the data fast.

And indeed, doing this conversion drops the test execution to less than
a second on my machine, so that we can drop the EXPENSIVE prerequisite.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/t4141-apply-too-large.sh | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/t/t4141-apply-too-large.sh b/t/t4141-apply-too-large.sh
index eac6f7e151..dad67779ed 100755
--- a/t/t4141-apply-too-large.sh
+++ b/t/t4141-apply-too-large.sh
@@ -4,8 +4,7 @@ test_description='git apply with too-large patch'
 
 . ./test-lib.sh
 
-test_expect_success EXPENSIVE 'git apply rejects patches that are too large' '
-	sz=$((1024 * 1024 * 1023)) &&
+test_expect_success 'git apply rejects patches that are too large' '
 	{
 		cat <<-\EOF &&
 		diff --git a/file b/file
@@ -14,8 +13,8 @@ test_expect_success EXPENSIVE 'git apply rejects patches that are too large' '
 		+++ b/file
 		@@ -0,0 +1 @@
 		EOF
-		test-tool genzeros
-	} | test_copy_bytes $sz | test_must_fail git apply 2>err &&
+		test-tool genzeros $((1024 * 1024 * 1023))
+	} | test_must_fail git apply 2>err &&
 	grep "patch too large" err
 '
 

-- 
2.55.0.795.g602f6c329a.dirty

