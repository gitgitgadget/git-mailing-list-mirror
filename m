Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1396227584E
	for <git@vger.kernel.org>; Tue, 27 May 2025 14:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748354583; cv=none; b=Zq29ZOsK1+5+F1236lKg255ciTGVb9nSS64FEddYDebgC6kV9FVngdqaOnk3/W7ZSB1zSvIWztcMmcw6en9iWaHcX3HAUaC5Up+MA6meiH5oIUzDDhJYx2cTckF3gHUd8aideIcdxROcRXX/xo8t0mwp8s3spq5jDaYJXkbtjTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748354583; c=relaxed/simple;
	bh=j6g3MQ80xQTkMkJUsF6TCs9Y+FeHPuxqnPy4FYtzzhA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jJbdfwtTWvVKeA0t3SaOxkoUKZ6cv9uRNYtj7877rWLkryo9adgmdoxJa/KAcv6btycaDZX6G0QJV2B7cmWy96uZIOzR5aBj12RDyq4nff6tnCeuEDUNUOhIfoLt+TzIIZX9upOVjVOvdbfehz/8qD90btgPptxICNTX4Spb94o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=byx63FNS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QxziHwzw; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="byx63FNS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QxziHwzw"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 298161140166;
	Tue, 27 May 2025 10:03:01 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Tue, 27 May 2025 10:03:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1748354581;
	 x=1748440981; bh=j6Iabma0YlTIen4o0SqrKhivGlaA9frNbI8LmDeiR50=; b=
	byx63FNS3od/dyP60rKhwl/iT1PmBo0KdBIybUpLfa63lpLcb9TDjt65zfJbxgmt
	GakPOAs52KKgNp0XOwwKu0OkYL7Tld4ZXp0jhLRnXDRn0YDO4SEFXnpL3OqQ8NIv
	/oJXc9SJUJf3+uPL1ohFCzQiMpNbruRiulKtVaJqeMA5jOWhhFOCpyFVj9xVZfRT
	IO/h6Sg9mBGkll13mfGiyUMAK3LbO63OyvYTiUDr2qYeWw5POo9RdYoMlU3odLKo
	XC5I+WtJuxQxZL2SkvitEn2XzNz4hTg0nNoGEfkr3XGT5pG0RvXz/PVST+pXCtEV
	AcWj2UGTqJVBt0KHgLYn4g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1748354581; x=
	1748440981; bh=j6Iabma0YlTIen4o0SqrKhivGlaA9frNbI8LmDeiR50=; b=Q
	xziHwzwsxS7a28K4ysGuFIsouxX2D1QzHVH47/9mRJq/BnGzRAURZTZL6ASIbQxE
	poheR4HqeQiRxLNMwF2MMLzEePbvcf2jn4xKXqkLOeSm14Pjmkg60fYwZnzTGmqB
	pUrTo/8VYwWcCgEAjIY7HlumVb1JlNp676RXGCq0FQFqfCwIRNV7pYcNBlu80yC+
	AaQ4DPqmXMoH9Rlm5u5NFyLUqAYsIMWFIH95b4WGXqUIt2KBUSGgyJfUagHBE37h
	02kzcaOYTPyGw/+K3OCjyS/GZbIcrUsZmk3K3O7pH4EH8Wwe0izYZ14AyISGBQ3k
	l1pv5sjKP9jEQ0lq7OClQ==
X-ME-Sender: <xms:FMY1aC6OgCF34eptZ-u4chLhKoFoJZdx1vgv7woZSDRBjaxazOtpXQ>
    <xme:FMY1aL751wFKsXdMPCRWXd9arAxHAuHGukqNkh8f7SJwSU7deE9_e45dZaF1qn06S
    8a6lW-gsBbQlFYydw>
X-ME-Received: <xmr:FMY1aBdi3sm2VN7ekrGRFmsFD0Ss9bEIZ_HpZebx091Bdz_kGMft9R3gkJzmPVjg_F1rNeEH00QbYfgON6Tk_rB801_waWxXbByuNAzRc-5jkQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgddvtdehjeculddtuddrgeefvddrtd
    dtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggft
    fghnshhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftd
    dtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffk
    fhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrg
    hrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeeh
    uedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghr
    tghpthhtohepjedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvg
    hrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehrrghmshgrhiesrhgrmhhsrgihjhho
    nhgvshdrphhluhhsrdgtohhmpdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfe
    esghhmrghilhdrtghomhdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhl
    rdgtohhmpdhrtghpthhtohepthhmiiesphhosghogidrtghomhdprhgtphhtthhopegvsh
    gthhifrghrthiisehgvghnthhoohdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehp
    ohgsohigrdgtohhm
X-ME-Proxy: <xmx:FMY1aPLZ52PzqkD8QiYA5gwDUF4An80Wbuid-62HRtFIo6hcucb6fA>
    <xmx:FMY1aGL84toJccQoOHZa33G-d9Ehs6Gv0xY9-CSnI5uIQlcejuH2RQ>
    <xmx:FMY1aAwepEiAoW4rHqxkHw2E-sStbGa0-ylEGBOTBxOPX-52QKS5dg>
    <xmx:FMY1aKIkje5ixfJqhX_MrmU15zxY86QEkEDhJbqyb7kOR7QqH3Y3rg>
    <xmx:FcY1aKuzEViZShzQWnk-Hx0NXHPnuT5RxYbvCu8MacU0LoSChsuSFSDS>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 27 May 2025 10:02:59 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 4fd326a7 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 27 May 2025 14:02:57 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 27 May 2025 16:02:52 +0200
Subject: [PATCH v2 4/6] t7815: fix unexpectedly passing test on macOS
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250527-pks-meson-tap-v2-4-ae360f77786e@pks.im>
References: <20250527-pks-meson-tap-v2-0-ae360f77786e@pks.im>
In-Reply-To: <20250527-pks-meson-tap-v2-0-ae360f77786e@pks.im>
To: git@vger.kernel.org
Cc: Phillip Wood <phillip.wood123@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>, Karthik Nayak <karthik.188@gmail.com>, 
 Ramsay Jones <ramsay@ramsayjones.plus.com>, 
 Eli Schwartz <eschwartz@gentoo.org>, Todd Zullinger <tmz@pobox.com>
X-Mailer: b4 0.14.2

In t7815, we have the following test:

    test_expect_failure !CYGWIN 'git grep .fi a' '
        git grep .fi a
    '

The test passes if '.' matches a NUL byte, which we expect to only
happen on Cygwin. The upcoming changes to support parsing TAP output in
Meson surface that this test is also unexpectedly passing on macOS
though.

It is unclear how long the test has been passing on macOS already.
064eed36c7f (config.mak.uname: only set NO_REGEX on cygwin for v1.7,
2025-04-17) mentions that the test started to pass for Cygwin once it
has imported a newer implementation of regcomp(3p) et all, which was
inherited from FreeBSD. Given the BSD lineage of macOS it is feasible
that it also inherited similar code eventually that made the test pass
now.

It is somewhat dubious what the test actually brings to the table given
that it is quite platform specific. Ideally, we would fix this mess by
having a configure-time check whether regcomp(3p) works as expected,
including NUL bytes, and use our bundled version of the regex library in
case it doesn't. Like this, we could ensure that all platforms work the
same in this edge case and mark the new behaviour as expected.

This change is outside of the scope of this patch series, which only
introduce support for TAP. So instead of fixing the bigger issue, ignore
the test on Darwin like we already do for Cygwin.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/t7815-grep-binary.sh | 2 +-
 t/test-lib.sh          | 3 +++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/t/t7815-grep-binary.sh b/t/t7815-grep-binary.sh
index b7d83f9a5de..55d5e6de17c 100755
--- a/t/t7815-grep-binary.sh
+++ b/t/t7815-grep-binary.sh
@@ -63,7 +63,7 @@ test_expect_success 'git grep ile a' '
 	git grep ile a
 '
 
-test_expect_failure !CYGWIN 'git grep .fi a' '
+test_expect_failure !CYGWIN,!MACOS 'git grep .fi a' '
 	git grep .fi a
 '
 
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 8c0d76ea5f0..0a124ffad38 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -1636,6 +1636,9 @@ fi
 # Fix some commands on Windows, and other OS-specific things
 uname_s=$(uname -s)
 case $uname_s in
+Darwin)
+	test_set_prereq MACOS
+	;;
 *MINGW*)
 	# Windows has its own (incompatible) sort and find
 	sort () {

-- 
2.49.0.1266.g31b7d2e469.dirty

