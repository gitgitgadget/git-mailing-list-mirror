Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 676C81D516A
	for <git@vger.kernel.org>; Thu,  5 Dec 2024 09:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733391414; cv=none; b=PQw+klGRe1rCwX+ny3eWavpYYfEWqMTne4267kRoKDqJdFmTmEL4iM37ZYH7499zqp0LaK+ECIkQ6Dzao9fgpUUXPk00dc9miRXfVsPDcuuH4IMPKX0kuW/lkY8D1vP9hrljJ2bA/P069s1NjILFQPgDttm9Wc4xdCQ5aGMHDXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733391414; c=relaxed/simple;
	bh=uzG4D6f0cRD73qE2kSPWnhPEUclXnvOONMhtgDEFfCg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tD2G1HNopsp2IxnxPcsrthIUnmU8KX/HGWaR/RjpoD6HC1QUI9Lr7QPxE3enkZ4jp3/dyusuaRONMCrzmbzY6BLbbYCUFLHtDykL25NclHjRh0aktdQuKkhZTrEUJRWXN3H/A++W+uKfe5xbzVKYrIwH36OqU/7H9tcmZQXyO6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=pvCyLUpo; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SYhHKRX2; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="pvCyLUpo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SYhHKRX2"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id 71F601380B83;
	Thu,  5 Dec 2024 04:36:51 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Thu, 05 Dec 2024 04:36:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1733391411;
	 x=1733477811; bh=Fz3/RqVx4WQHgOlLd9G/Uj9F5oXMMZuDotUJtdP+2Wk=; b=
	pvCyLUpoZFmLU8BoRtIkt/nUGnUyl0HwLgxAdStT5HEpbB9w0qSJXmUiK2KQRHDz
	OvyRVX3wJmX1IMWFCgI3FapKUVdvQYMLXojjKzYK41ZIqLyWkJMRuNWKDhfACLbC
	jk/KpmZq1Kwyvy+taKkRD6NZV3O7pKE4MnTp1dX0NqL3YTaiAaCkMdQzee8fplYa
	Gc7p85qFCiekpelEjlIciqhrUXNZyS5Vnn/+nKTWPsYcMVfb9GtklU0ZE974SMjN
	Qkw3shwrr9ADtGvl4FEsHpfLypodijdm5mI46mAGNGSDxOhe5b20YsHXS0ujNOqo
	GVjdL+V8Bcua+WHFjyiCxQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1733391411; x=
	1733477811; bh=Fz3/RqVx4WQHgOlLd9G/Uj9F5oXMMZuDotUJtdP+2Wk=; b=S
	YhHKRX20sQ0wQVD5XvfNZYvOs3x8eZZBc3AeBxAM4OcKghauBODuiD0plFDI3XfI
	nX2usC7e1OZRCe6XKEihiZNl4BzilXDOH57jruK1+T4AKTiJ/vvHkrV+xU/WmQCA
	XwosNSGWnfKveheGoASoAEBqh5kr13/bAoBdl84KvZBDEwS9/aUeerZh+7dAy1/q
	f/HbtFgyrKxa4XwbS0bUePQHDxq00pZ3TucOIFphRf/3opKvZBnOhoXYKJwPnWu+
	PfVhwhkUJMSYByiHxMDxthNRHcC264kEwBWwERC1H/9fc5OVgtUKMgfPb1J1O865
	Z28NYHatLFz82DYN9ZTMQ==
X-ME-Sender: <xms:M3RRZwPfsbcIIPsuvg6u8F7Z6BUO5P4rNTfFKUhM1KCQycZ0-gm7Hg>
    <xme:M3RRZ2_C0n3wHT8lSyFdNk-wkNnC6KkrvVT95eJWxaR0wycRabwi3EwqeCTotIrpz
    7gew_X-FXFRUwzXHw>
X-ME-Received: <xmr:M3RRZ3TbIGUhPxQsjUjfFqpizZz6kOGMfzJpt0Trv8EoW06lF5seQFWbAayJwZnEG5UiFzZLwqUfytjWGd5oHsY9Pp7OkxO49F0CL1aMOooHuw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrieejgddtgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephfffufggtg
    fgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvd
    ekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsg
    gprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhhvghjihgrlhhuohesghhmrg
    hilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghp
    thhtohepphgvfhhfsehpvghffhdrnhgvth
X-ME-Proxy: <xmx:M3RRZ4sU-79AhwPIvTPIGgZMbuX0SqzoeAQttnESd0ErRK5EHQdBsQ>
    <xmx:M3RRZ4dlxAgV0K4kCNbXCG_Ua7VOvaDBq25AXzx1AOTOQ78X8ofizg>
    <xmx:M3RRZ80gMVr5fVibluP-SXHPUzQNq5WXdCENBtwdZPnAVM-atlcpwA>
    <xmx:M3RRZ8-2_P8OF3SO6ivw584Sd5U_I4xAt6__y8gcWOcXi1w3Nhk6FQ>
    <xmx:M3RRZ9FPv5_fTZE4c4orQvKFKnfUgoLpTkX1jHHMLmaihynT-KIKEVc0>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Dec 2024 04:36:50 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 18ef404a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 5 Dec 2024 09:35:26 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 05 Dec 2024 10:36:23 +0100
Subject: [PATCH v3 01/15] git-compat-util: introduce macros to disable
 "-Wsign-compare" warnings
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241205-pks-sign-compare-v3-1-e211ee089717@pks.im>
References: <20241205-pks-sign-compare-v3-0-e211ee089717@pks.im>
In-Reply-To: <20241205-pks-sign-compare-v3-0-e211ee089717@pks.im>
To: git@vger.kernel.org
Cc: shejialuo <shejialuo@gmail.com>, Jeff King <peff@peff.net>, 
 Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.2

When compiling with DEVELOPER=YesPlease, we explicitly disable the
"-Wsign-compare" warning. This is mostly because our code base is full
of cases where we don't bother at all whether something should be signed
or unsigned, and enabling the warning would thus cause tons of warnings
to pop up.

Unfortunately, disabling this warning also masks real issues. There have
been multiple CVEs in the Git project that would have been flagged by
this warning (e.g. CVE-2022-39260, CVE-2022-41903 and several fixes in
the vicinity of these CVEs). Furthermore, the final audit report by
X41 D-Sec, who are the ones who have discovered some of the CVEs, hinted
that it might be a good idea to become more strict in this context.

Now simply enabling the warning globally does not fly due to the stated
reason above that we simply have too many sites where we use the wrong
integer types. Instead, introduce a new set of macros that allow us to
mark a file as being free of warnings with "-Wsign-compare". The
mechanism is similar to what we do with `USE_THE_REPOSITORY_VARIABLE`:
every file that is not marked with `DISABLE_SIGN_COMPARE_WARNINGS` will
be compiled with those warnings enabled.

These new markings will be wired up in the subsequent commits.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 git-compat-util.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/git-compat-util.h b/git-compat-util.h
index e4a306dd5639b58a4ec4d2a6269fb649348fb4e7..31a059820f3b1536a3c1a887390b70098a6fbd09 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -44,6 +44,16 @@ struct strbuf;
  #define GIT_GNUC_PREREQ(maj, min) 0
 #endif
 
+#if defined(__GNUC__) || defined(__clang__)
+#  define PRAGMA(pragma)           _Pragma(#pragma)
+#  define DISABLE_WARNING(warning) PRAGMA(GCC diagnostic ignored #warning)
+#else
+#  define DISABLE_WARNING(warning)
+#endif
+
+#ifdef DISABLE_SIGN_COMPARE_WARNINGS
+DISABLE_WARNING(-Wsign-compare)
+#endif
 
 #ifndef FLEX_ARRAY
 /*

-- 
2.47.0.366.g5daf58cba8.dirty

