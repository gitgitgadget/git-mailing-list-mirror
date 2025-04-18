Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30DA2204C0C
	for <git@vger.kernel.org>; Fri, 18 Apr 2025 21:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745010228; cv=none; b=ef9Y2bYp06Kp0/hDs/0k8Lal2w6rNDCDej0cHhU4Z9hO+HzN7KWi7GyKmmIbAYyWcSuCaAQcfeb/szT4LT8/FdoOe8HRecEZ0Z/9Ag2HXIEzzUItWbehck9zIuOs9DjazVshBfSpcP4YxZ6KQTZmA+nB7mwA+Atw3i9OgFe+r/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745010228; c=relaxed/simple;
	bh=CZI76Jc+1OQXCl0tqxChfjgC7Atd/CwjlUdDZbpEErM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qYWx1IqC6vOkGSOWqfr0G6YZhKWOgjBtxaW91wE1ffnG9qmlJ09Fmd1OxVNcJ3gAB3I6ptHg15CcHbCfuQTM8S2XsrI6g0hwU5F9gwml+SItjvOiqjPJo5c/ZBZnb1fbvYYL7Rl3ymnb9bqZ6zLLiOge/aDVzz1zcpwrq3znMmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=tR6nDqs0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YYsQHm35; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="tR6nDqs0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YYsQHm35"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 20C3B11401EF;
	Fri, 18 Apr 2025 17:03:44 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Fri, 18 Apr 2025 17:03:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1745010224; x=1745096624; bh=LDqZ37kChR
	NptzB97bjcMyt+FiRu40OCIVu8DGQkn9M=; b=tR6nDqs0uvo2SICCDkej/C8XZN
	RxV2EuzdZfh28GyLQrBnpejU/W1Xbpcjc7c/vN2KkYFIIJjz9m/nnGNFJIKVfZNH
	7RA0FOj0zhuaBIyv1yRacDFjzp66gQncpWezZpy3jsmECyffZF8V6YjOHXLL/fmK
	9KQqUorgVEzHkUN+43hFi5WBojmU0/AEQYesHh+EXHdM7cfx3nS0Hrdq+DsY3Y3c
	TPwruZBv+06M0WdPRsfsGJGOs92+yftimKdqyYRX8n/uzseverrO/laT5C1oiorJ
	GKQSU//zROfN4H30FsFJWszIZ4ibTEtVV27X/skV2lfv7CcX0scTJM6JmACw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1745010224; x=1745096624; bh=LDqZ37kChRNptzB97bjcMyt+FiRu40OCIVu
	8DGQkn9M=; b=YYsQHm3513OeUOknu/bH7BwzkRrss7s4aa7Yu3VIaTtzMudSl46
	mLzVFdvUGbQTNc0pTwRCmHB+P2jiRNon2Zwdk7b4riXa7jZnhZuIehinUVxdRFgx
	FQNc0senxX9lYxsQp3vI8BAWUqcpTSaV6H3sIF+gNSkmPDBcvlJrEttPXLhBygLp
	ECkulbNVltGZvx+QhEWtYvAlie1lsZ7PcvKDCm/S+oEdLi2aB6/ZHYMeWnb0MG7g
	BHucHbFoxQWwCuwpqb/SsKdDLyqqEc7RUyN0sam+9OoDFfquHO6RFP46/UWjzWsg
	uSrUqtKfMkomQcsgNcPm/o8SSUafv0pcW2g==
X-ME-Sender: <xms:L74CaBJsG_v1rKKPyK2vXLGuZuNuReVvO4rBLPz8pbZusxoGEeNdnw>
    <xme:L74CaNJLUxIcnCWNXmEXo_M42oGXWiWFoF1HNAmspo6aY_UFZpM41tVi6r7rJMWJT
    JUe3YL3WDhV7lr9Sw>
X-ME-Received: <xmr:L74CaJtMjpwYa63OxuWzXKMX7Fq6S_O76_eDnpzsU2kxW71OBTD8sI3DbAxa3myTehuqRkTSaH0-9tI6UanXJNjIlMi4o3LOrQmM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvfeefudekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepledpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprghnthhhohhnhi
    ifrghnghehudefsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhk
    vghrnhgvlhdrohhrghdprhgtphhtthhopegrnhhthhhonhihfigrnhhgtdefsehitghloh
    huugdrtghomhdprhgtphhtthhopegthhhrihhsthhirghnrdgtohhuuggvrhesghhmrghi
    lhdrtghomhdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpd
    hrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehshhgvjhhirghluhhosehg
    mhgrihhlrdgtohhmpdhrtghpthhtohepshhhhigrmhhthhgrkhhkrghrtddtudesghhmrg
    hilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:L74CaCZMMc9GEEccCIBsip9iq7m3qSYUrNxnM4cHD6gXCo98MC7rjQ>
    <xmx:L74CaIZUs-VAhuaCcI7AuhsZGMpAF43JM5N31ltgeC1cT9QKRZPPtQ>
    <xmx:L74CaGD9uYs8W_XbTX-FxHgD2rtUYbsFVILFaJ0y8FW4lncdu4RcAg>
    <xmx:L74CaGaz8t6eTIuwldMotrtrGsh-wD3x-jle4xHpmJqEuBbyCGWhnQ>
    <xmx:ML4CaIylYXkuNzJf4f5O0gKvVWuha4i6RsaCU5pQfeve-8XBshkqp27_>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 18 Apr 2025 17:03:43 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Anthony Wang <anthonywang513@gmail.com>
Cc: git@vger.kernel.org,  anthonywang03@icloud.com,
  christian.couder@gmail.com,  karthik.188@gmail.com,  ps@pks.im,
  shejialuo@gmail.com,  shyamthakkar001@gmail.com
Subject: Re: [GSoC] [PATCH v7 1/1] t9811: be more precise to check importing
 of tags
In-Reply-To: <xmqqikn1bapz.fsf@gitster.g> (Junio C. Hamano's message of "Fri,
	18 Apr 2025 11:12:08 -0700")
References: <20250405103718.25160-1-anthonywang03@icloud.com>
	<20250416145939.24207-1-anthonywang03@icloud.com>
	<20250416145939.24207-2-anthonywang03@icloud.com>
	<xmqqikn1bapz.fsf@gitster.g>
Date: Fri, 18 Apr 2025 14:03:41 -0700
Message-ID: <xmqq34e5b2s2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> Let's add this on top.

Well, it turns out that it wasn't enough.

--- >8 ------ >8 ------ >8 ---
Subject: [PATCH] t9811: fix misconversion of test

The previous commit started to insist TAG_F1_ONLY to be missing,
which was not in the original.  Let's not to be overly eager in the
conversion.

Aso, the other hunk in the commit introduced shell syntax errors,
breaking the test to fail.  Fix it.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t9811-git-p4-label-import.sh | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/t/t9811-git-p4-label-import.sh b/t/t9811-git-p4-label-import.sh
index 39856629c0..7614dfbd95 100755
--- a/t/t9811-git-p4-label-import.sh
+++ b/t/t9811-git-p4-label-import.sh
@@ -97,7 +97,6 @@ test_expect_success 'two labels on the same changelist' '
 
 		git show-ref --verify refs/tags/TAG_F1_1 &&
 		git show-ref --verify refs/tags/TAG_F1_2 &&
-		test_must_fail git show-ref --verify refs/tags/TAG_F1_ONLY &&
 
 		cd main &&
 
@@ -207,7 +206,7 @@ test_expect_success 'use git config to enable import/export of tags' '
 		git tag CFG_A_GIT_TAG &&
 		git p4 rebase --verbose &&
 		git p4 submit --verbose &&
-		git show-ref --verify refs/tags/TAG_F1_1 &&
+		git show-ref --verify refs/tags/TAG_F1_1
 	) &&
 	(
 		cd "$cli" &&
-- 
2.49.0-524-g64a58d64d1

