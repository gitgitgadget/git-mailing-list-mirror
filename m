Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 004EB1C84B4
	for <git@vger.kernel.org>; Fri, 14 Mar 2025 21:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741986555; cv=none; b=X7pF5Ug0igWmycqbvdOA+J1pEuRblR+ukH8abhDNv2Gi6adskQjEFKxT5NVoqrlQ4kmJSv4QUoZIoCQGsT9H8O30+dKg+d4LjdotQP2gu+LuYmGuk9NoGo9th2Ur5TAKFiDW7+cvGkntz+Uex3uVRKYObwx97vdk7DrTHQtSNi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741986555; c=relaxed/simple;
	bh=nztRyHPLRus+D5cMHDpWbK5db/m5T/PCyLq08NI2bL4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HnQV8kTLNPRMP5XzgHQq9ycp/JlEy0aOUbpggx5Pfqk7SM1/XQEGh9OTfB+f9xX9I4Y3hNLl3LIAmCpjepb+aq5fHBvmNpbNDxM0OwlapP1x6xoVmAWa0rLZ/GSPkMOrg3ghAtBvO0l615uJF21SpO5WDu5fhTP1FZdseTK1DTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=fJ4ngi63; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=4CFo3GZw; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="fJ4ngi63";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="4CFo3GZw"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfout.stl.internal (Postfix) with ESMTP id EE5C01140191;
	Fri, 14 Mar 2025 17:09:12 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-08.internal (MEProxy); Fri, 14 Mar 2025 17:09:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1741986552; x=
	1742072952; bh=De1sAcvmN/EETQtxluBbapW0ontDkZuFVSTDGzeWFHA=; b=f
	J4ngi636bpJo9gQbeTGEgKTm5EEC2WuSzwsz8nKlMF9O08keMcmH2NBai9ums0y9
	W4N/KVbmSjciftvHC4Jcpbl7FcdchPFd2Lc/LTH5y0IymASXwPeO4qURfYldpoqF
	Jh/2FcV5yCHqG4GzQPPfHVBs9K2/LYVKr8dl80shU8AZbNinqCwAfIBNRBE6w8CM
	rkEmxvTc5FjK4vEGS47i/QRippuAAaQyHw75GPzEjfgxycPhHE9XRLkoo/tyqGvD
	vDIQc7MywrT1+0mROJwCJ5DwyzBudZEyhx+RdnT76NmHBxG5B5VXpo5oHjC9tYz5
	I/GQHTLgDzUqFLKPqVjWQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1741986552; x=1742072952; bh=D
	e1sAcvmN/EETQtxluBbapW0ontDkZuFVSTDGzeWFHA=; b=4CFo3GZwmm7E9dHmp
	POM/CsqYZhW2CERhdiZnPIP3Boz7n+6DgQjPABnifPYz+PUxz0V+wScO+VMF3oST
	AyZpQpLHrb8dd4NDTWZ1hINK4Z3sIxYtzqAVs9yCHf+Wkj/de6CPPskssx/Q6O1V
	p6yFOUryevIa/R2Pm3ydSUS9LkceBOsSBJiK6Skfjxx26HPc8H6rko3qvkhyz7s1
	8fvCy1EckebugiQw37m2Rldva81N+xhJJTcePx9VWdGuEBnue6z1VJjqZWoo+Lrr
	R2TK/mJZBnuYLyg/zAC0mTwE+raP/6Rc7IPtN7pAYeN4dS1EklxRuxBm4WpNWXy1
	aPVBQ==
X-ME-Sender: <xms:-JrUZz1chcfD44jxPMeSQk7IEG2x66kdyxiIusE3acxC4NcdMcZx3Q>
    <xme:-JrUZyEw2fpCkP4Xa15bGpltxDrze_39IHJtigTCRcAxzIZn_gLrzaxkgsXuOvPY7
    4w7aJQwrbr9fgg4RA>
X-ME-Received: <xmr:-JrUZz58g-MjqJaD_ZdGcK0TzW5D7uHTh_R5A12zfjmoETHbLKPpM8mkTN9xxHNqSIPTxCE9JHdbS5eAmMCnhHa4r1cnhP80DU-D0nM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddufedukeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefufffkofgjfhgggfestdekredtredt
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepleeviefgleegfeeiffegfeetvdettddt
    ffeigffgleevieeuveduffefgfevtdelnecuffhomhgrihhnpehkvghrnhgvlhdrohhrgh
    dpshhtrggtkhhovhgvrhhflhhofidrtghomhdpmhgrkhdruggvvhenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsoh
    igrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgvfhhfse
    hpvghffhdrnhgvthdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepghhi
    thhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:-JrUZ40Gp5IhEDPC5GtOoIiBOKF9m1sTlELKKruIfuQRpHsH3LrJ-Q>
    <xmx:-JrUZ2E8QA29Wub1d79WuGHiD1GfXl84W1-lV2QvAqT-vZatNiyYhg>
    <xmx:-JrUZ59366KXT2cO-kuNdNXeURIQSrFnqASE4mVVK-NGkdVANnWq7w>
    <xmx:-JrUZzla7IbGAIYKvs8bZzH-e0xIvAI6yMeFeCSD0-7nK0TLqjxYwg>
    <xmx:-JrUZyiXr_adreImR5ahhLJpneFHcdlGtRMLvweAS82wJBjlgtPgCZ2n>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 14 Mar 2025 17:09:12 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>,
	Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 1/3] config.mak.dev: enable -Wunreachable-code
Date: Fri, 14 Mar 2025 14:09:07 -0700
Message-ID: <20250314210909.3776678-2-gitster@pobox.com>
X-Mailer: git-send-email 2.49.0-188-g35fcca2323
In-Reply-To: <20250314210909.3776678-1-gitster@pobox.com>
References: <20250307225444.GA42758@coredump.intra.peff.net>
 <20250314210909.3776678-1-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jeff King <peff@peff.net>

Having the compiler point out unreachable code can help avoid bugs, like
the one discussed in:

  https://lore.kernel.org/git/20250307195057.GA3675279@coredump.intra.peff.net/

In that case it was found by Coverity, but finding it earlier saves
everybody time and effort.

We can use -Wunreachable-code to get some help from the compiler here.
Interestingly, this is a noop in gcc. It was a real warning up until gcc
4.x, when it was removed for being too flaky, but they left the
command-line option to avoid breaking users. See:

  https://stackoverflow.com/questions/17249934/why-does-gcc-not-warn-for-unreachable-code

However, clang does implement this option, and it finds the case
mentioned above (and no other cases within the code base). And since we
run clang in several of our CI jobs, that's enough to get an early
warning of breakage.

We could enable it only for clang, but since gcc is happy to ignore it,
it's simpler to just turn it on for all developer builds.

Signed-off-by: Jeff King <peff@peff.net>
[jc: squashed meson.build change sent by Patrick]
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 config.mak.dev | 1 +
 meson.build    | 1 +
 2 files changed, 2 insertions(+)

diff --git a/config.mak.dev b/config.mak.dev
index 0fd8cc4d35..95b7bc46ae 100644
--- a/config.mak.dev
+++ b/config.mak.dev
@@ -39,6 +39,7 @@ DEVELOPER_CFLAGS += -Wunused
 DEVELOPER_CFLAGS += -Wvla
 DEVELOPER_CFLAGS += -Wwrite-strings
 DEVELOPER_CFLAGS += -fno-common
+DEVELOPER_CFLAGS += -Wunreachable-code
 
 ifneq ($(filter clang4,$(COMPILER_FEATURES)),)
 DEVELOPER_CFLAGS += -Wtautological-constant-out-of-range-compare
diff --git a/meson.build b/meson.build
index 0064eb64f5..f60f3f49e4 100644
--- a/meson.build
+++ b/meson.build
@@ -697,6 +697,7 @@ if get_option('warning_level') in ['2','3', 'everything'] and compiler.get_argum
     '-Woverflow',
     '-Wpointer-arith',
     '-Wstrict-prototypes',
+    '-Wunreachable-code',
     '-Wunused',
     '-Wvla',
     '-Wwrite-strings',
-- 
2.49.0-188-g35fcca2323

