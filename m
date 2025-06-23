Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52D8029CB2A
	for <git@vger.kernel.org>; Mon, 23 Jun 2025 16:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750695256; cv=none; b=iCI0Opmh6l+ig99d4CPE8cGbJPgZncDkmDQQqHkFU9s0q+hsTK9keAfUtx6GcT5sw6jV1b7lS/50sAnqYbGh6Yl9xKSqyLOT3aoKUs0EhFp9zHwgkhxi7PiFF5InljNZBQFJEQh/1GkVo5DQMfgsEtSE84URdUTFoFgQl4iG9/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750695256; c=relaxed/simple;
	bh=7iFZ6bdgCDP3rGjoD+DCadNKDklmeGY4xZHckW2ucl8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BL4lCqLUzZz52kY988HCAmFh7WPF8xujVOpNhsq/BuM5VmlUcmsYVcqV2U86+fSCrKokIDn4Wvb6bKPAgoE6KOrDdCb6blhoJaoqLbVFYBvF3Xa7JzKgjqHeJr0S8nULpVU4/crarsNGe2qkb9uQtuMda72rTsGCBMHyZXZaG+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=bkEsAWXf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Xon+675q; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="bkEsAWXf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Xon+675q"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 620C91140173;
	Mon, 23 Jun 2025 12:14:13 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-08.internal (MEProxy); Mon, 23 Jun 2025 12:14:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1750695253; x=1750781653; bh=gXt18hDOal
	JER9iWLw216BRHzOy0aUdONlZ1LaOM5WA=; b=bkEsAWXfz/njiA25FWi7TTSjpF
	LC3+jYDCldwhQ9ZbMz+S33Vq3MO+FydZkKs6oeFpUeFhjVJ805PcEuoPCgiQ3ylk
	EMkvaMh6ZT7zopE8ohiG/1Jf96K3x1fQqlLu7Q2Sf3Huxx4/AlpXh59iUKviyOw9
	9HN+9Zq1UTFCqSqL16HotiXPdSsUGzkPYQiDqFFyOBzgkgnmv0aoGbcvZqGVEdim
	Hwp6cY40TrxEVepXglb/tVmgeqZf5oBa+PzGMhMNX1wS7cOLy9ttq+WAeCFyt8QS
	To5jo/QDOhbuoOBuISEtFpDfV0KFGTH6jxU4hpEcGyVue/3Smk+AeUngkW5Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1750695253; x=1750781653; bh=gXt18hDOalJER9iWLw216BRHzOy0aUdONlZ
	1LaOM5WA=; b=Xon+675qZK4LXeKssbEq33x/xp3s5PuEQXerUl1VW/UeLL7vpZm
	ndBeTA8BfsPiYKPGHnIluCpDp4fl5jJKtB8kqzW32iiGo54zb6TarZX7JQpR58SU
	mkkyqxBEY/I7ELphxFsF4E1P8kM/e6NDQKdiCyZ23LVBShyd84pMaiqy9Ya+j+tt
	l9H4YqQmxKkOPCUV3shmYi7XMeQL7lw/mMAmGv6iQHIEKMv3/qa17bRxpy02Fwdb
	j5hxuj1GmcufxplYxAl4DBcJUxNkXXQV/amVflhDUA+cH9YBmTYfOKrMaWBmMcQn
	Gyiz9t7VgOZfntaA06JVXhioUWv7h2AZ/dg==
X-ME-Sender: <xms:VX1ZaI2AEZx1Da7jiWgKl64LnM4Z-_clETcK6htpVuXaDD4TfddDfQ>
    <xme:VX1ZaDGG5DzcR9NOrzCmgSlvOVESgs_wjePWuCKimX6fKfZDvBzYS8DjyADqlwcUB
    eb5fx0eiJ8NFEJPQw>
X-ME-Received: <xmr:VX1ZaA6BaWjNyBBXZa8fRaCqYgr0Tw1AyQU3JRFmHCWs0dlDXmZS5-NpkAJaDBj4B07ahZxjChmdlxzazOad7JBzJkLet4UCDqmwEzA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddvgddujeegjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopegtrghrvghnrghssehg
    mhgrihhlrdgtohhmpdhrtghpthhtohepshhunhhshhhinhgvsehsuhhnshhhihhnvggtoh
    drtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:VX1ZaB3zqaCSBRigN8iLEILaeKTMym59583WlBvHMz7GbHyzUQ8nPw>
    <xmx:VX1ZaLFVyJkSPQWFbcXYoQfMrdKfQW1NvO_HeV6SUCgVwEv_mYdVIQ>
    <xmx:VX1ZaK8eXHXclqUAbbwLXhetcP6-CSD0Vk0BgA-wimdakIy_-R6RWA>
    <xmx:VX1ZaAncuzm5t1yVB7WWDLalZvnZwhKhvXV3at-cSOLYL-Ztm0JIHA>
    <xmx:VX1ZaHPjO-ryWnATITiRCh8a0tCTZ16JBn-DrOhcI9lURP_W42lOR1cT>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 23 Jun 2025 12:14:12 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>,
    Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>,
    Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2] coccicheck: fail "make" when it fails
In-Reply-To: <xmqqwm97bv7c.fsf@gitster.g> (Junio C. Hamano's message of "Thu,
	19 Jun 2025 08:35:35 -0700")
References: <xmqqwm97bv7c.fsf@gitster.g>
Date: Mon, 23 Jun 2025 09:14:11 -0700
Message-ID: <xmqqbjqe77vw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

With "make coccicheck", we generate contrib/coccinelle/*.cocci.patch
files that contain changes suggested by semantic patches, but "make"
succeeds.  Admittedly, not many developers may run "make coccicheck"
in the first place, but it makes it harder to notice when they do
run it after they introduced an iffy piece of code.

Check that the resulting cocci.patch files are all empty.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Makefile | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index 97e8385b66..8f1e9424a7 100644
--- a/Makefile
+++ b/Makefile
@@ -3422,11 +3422,14 @@ endif
 coccicheck-test: $(COCCI_TEST_RES_GEN)
 
 coccicheck: coccicheck-test
+
 ifdef SPATCH_CONCAT_COCCI
-coccicheck: contrib/coccinelle/ALL.cocci.patch
+COCCICHECK_PATCH_MUST_BE_EMPTY_FILES = contrib/coccinelle/ALL.cocci.patch
 else
-coccicheck: $(COCCICHECK_PATCHES_INTREE)
+COCCICHECK_PATCH_MUST_BE_EMPTY_FILES = $(COCCICHECK_PATCHES_INTREE)
 endif
+coccicheck: $(COCCICHECK_PATCH_MUST_BE_EMPTY_FILES)
+	! grep -q ^ $(COCCICHECK_PATCH_MUST_BE_EMPTY_FILES) /dev/null
 
 # See contrib/coccinelle/README
 coccicheck-pending: coccicheck-test

Range-diff against v1:
1:  163a63f2cf ! 1:  dee873e931 coccicheck: fail "make" when it fails
    @@ Commit message
         Signed-off-by: Junio C Hamano <gitster@pobox.com>
     
      ## Makefile ##
    -@@ Makefile: coccicheck-test: $(COCCI_TEST_RES_GEN)
    +@@ Makefile: endif
    + coccicheck-test: $(COCCI_TEST_RES_GEN)
    + 
      coccicheck: coccicheck-test
    ++
      ifdef SPATCH_CONCAT_COCCI
    - coccicheck: contrib/coccinelle/ALL.cocci.patch
    -+	! test -s contrib/coccinelle/ALL.cocci.patch
    +-coccicheck: contrib/coccinelle/ALL.cocci.patch
    ++COCCICHECK_PATCH_MUST_BE_EMPTY_FILES = contrib/coccinelle/ALL.cocci.patch
      else
    - coccicheck: $(COCCICHECK_PATCHES_INTREE)
    -+	test $$(cat $(COCCICHECK_PATCHES_INTREE) | wc -c) = 0
    +-coccicheck: $(COCCICHECK_PATCHES_INTREE)
    ++COCCICHECK_PATCH_MUST_BE_EMPTY_FILES = $(COCCICHECK_PATCHES_INTREE)
      endif
    ++coccicheck: $(COCCICHECK_PATCH_MUST_BE_EMPTY_FILES)
    ++	! grep -q ^ $(COCCICHECK_PATCH_MUST_BE_EMPTY_FILES) /dev/null
      
      # See contrib/coccinelle/README
    + coccicheck-pending: coccicheck-test
-- 
2.50.0-243-g67b26bc0ed

