Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63C582206A2
	for <git@vger.kernel.org>; Fri, 18 Apr 2025 18:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744999934; cv=none; b=AzvBzjJB3LW8ULIkpYCgXv/PzLWgRn5zcrAidX+gVnEUOkeuYZIw/w/Kd27Ty14cww0/84JREe+RMdJcTBkXYvnB52mhz/ZWbdANYzS8uR6AB8nsmaL0hapWSKPUATGYITq3gB4XoB8q1Y+I7m6mQkIhf5uOxRVajcz643mjI5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744999934; c=relaxed/simple;
	bh=Z6iq/2nfDJJjjqDCR1Z+a0/E0G5LzHtfAVz3A9taK2U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=H6fxsY9VmU4Tc9/JdtG5LnBqHkCobXqzCfX6PkO/lHqqBRffDo1nOWN3byQWH4OdtsOAiG/g//DvUmKYXhUAgylGiwMDa4VbYsxWZ+x4r6K2GNYlfGwwVN+WRZZTkCLa17S/X0N1nPIyad7aDY8Osdlc/AxX1GUhhcR92AHXuTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=XIR8qgYh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AU5L69x3; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="XIR8qgYh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AU5L69x3"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 6C4B31380462;
	Fri, 18 Apr 2025 14:12:10 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Fri, 18 Apr 2025 14:12:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1744999930; x=1745086330; bh=s7xdEHabDG
	0tqoQOHRtCeElQunWRE0nJW6vQ8NGE2jA=; b=XIR8qgYhgiwano2nLh0c/mFA7w
	kPwapjkokm6K/D7U1d3LM+NmQfo+zaCey9eyRHQxfx/0l6FKUCO6nBupnaRiZIEf
	bihizHeQAAWL+l3JpFRJkqAzn1odZQmIlVu1GGqHCBQlxAUqwaeA+97k7ysVa0ub
	1kx0oOJqVsaw0ucVyOFYfhYV4AIcDG3WKePYokpkvHxIB3BFTJjtx9uYL2IYRN+G
	JPhLT4M9Mu1Rk5Nj8AxzCznHR5DmcMXYmlyPl4ZPCI+aq7L4FfZIKadi6XJH6+GS
	tZ6xmzc/zbe+cMxmTzVmzawMKhxShPLD9RkUqO9EE8ArafFv8f+0R0V5a/pQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1744999930; x=1745086330; bh=s7xdEHabDG0tqoQOHRtCeElQunWRE0nJW6v
	Q8NGE2jA=; b=AU5L69x3P0LZnh+QYVR0rGsqxUzj8Lf5J148LstkO7LYDegpxoV
	BJJqJ6lEsN9XeBfRD8N8wlNqGIs5B0iMZ9S40dMbWgLFhPMtd9F9WaXbnfj2k5Xs
	NXZQ3NIS8q9HX+FP/pW71dHiMa70Vk2pv3kJhgLsjCnZmJ1Y5WCGJPwbDpW59pIo
	5QErdi9c5GrF6+TxTwmhp0ERy8lGffrGzXRrGq/GbQg5hW7TFRhAkpWUlWO8pkVU
	obpmKaKu5eQI0QUYVhoe1PXD6g0+Ke90JE+SS7KxUOBbopjehG8D+O4tf7LdL+/U
	BusWLJyjwn/VGzpFyKexvhrLOS4YchJN/fA==
X-ME-Sender: <xms:-pUCaPWhCWlsysW4WLoMBEpSCJgZRo5x4nFJRJwdIH_s_oA8s9GYVg>
    <xme:-pUCaHkvbmxLRABaW59qizT8LJpMBv0fyQ6UPTstmBdN8hxdQ3dTbHPmAqFXvQtHo
    eHspugljfvbRXz8zQ>
X-ME-Received: <xmr:-pUCaLZEfdKC2tWvGhZJhAzHpCEpLFROGd-N8PY3Lh-ufZrPgPL-AkUN1FOnXXZPQP4oW5gqZmXZXJLwrgLHlybKvIpe258pjZSp>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvfedvkeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepffeiteeujeevfeehuddvjeduffeijeeg
    fefhtddvkeefjeejhedtgeefgfeijedtnecuffhomhgrihhnpehgihhthhhusgdrtghomh
    enucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihht
    shhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeelpdhmohguvgepshhmth
    hpohhuthdprhgtphhtthhopegrnhhthhhonhihfigrnhhghedufeesghhmrghilhdrtgho
    mhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    eprghnthhhohhnhiifrghnghdtfeesihgtlhhouhgurdgtohhmpdhrtghpthhtoheptghh
    rhhishhtihgrnhdrtghouhguvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepkhgrrh
    hthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehpshesphhkshdrihhm
    pdhrtghpthhtohepshhhvghjihgrlhhuohesghhmrghilhdrtghomhdprhgtphhtthhope
    hshhihrghmthhhrghkkhgrrhdttddusehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhi
    thhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:-pUCaKUxvZsELFDzA6eandf0monPFg7Xzedk7kGPGxVfASvMtAsefw>
    <xmx:-pUCaJkliGBiMjAaWu4Jug5XQcL8Nyukn8W4eqeo5QLguSIJj1LlSg>
    <xmx:-pUCaHcUskMBGkXB-Kp74MTMucoKHC2Qk8cRYA6mWZH6Zs8bkbqWCg>
    <xmx:-pUCaDEyh1Nm1B5PWfRU0CCfcMCrD6kMe7LzdnaQwmRqKC8Nlpoq2Q>
    <xmx:-pUCaHvuqRe7m6yK6VK7J-MJ3nG-J2TkfgY5pALpKlx9HOMPVJy2LAqD>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 18 Apr 2025 14:12:09 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Anthony Wang <anthonywang513@gmail.com>
Cc: git@vger.kernel.org,  anthonywang03@icloud.com,
  christian.couder@gmail.com,  karthik.188@gmail.com,  ps@pks.im,
  shejialuo@gmail.com,  shyamthakkar001@gmail.com
Subject: Re: [GSoC] [PATCH v7 1/1] t9811: be more precise to check importing
 of tags
In-Reply-To: <20250416145939.24207-2-anthonywang03@icloud.com> (Anthony Wang's
	message of "Wed, 16 Apr 2025 16:59:39 +0200")
References: <20250405103718.25160-1-anthonywang03@icloud.com>
	<20250416145939.24207-1-anthonywang03@icloud.com>
	<20250416145939.24207-2-anthonywang03@icloud.com>
Date: Fri, 18 Apr 2025 11:12:08 -0700
Message-ID: <xmqqikn1bapz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Anthony Wang <anthonywang513@gmail.com> writes:

> Additionally, we add a negative test to verify that a possible
> uninteded tag does not show up in the imported repository.

With this we tightened the tests to insist that TAG_F1_ONLY does not
exist, but it seems that our CI tests at least on macos seems to
think that the tag should exist.

https://github.com/git/git/actions/runs/14526556144/job/40759116464#step:4:1944

> +		git show-ref --verify refs/tags/TAG_F1_1 &&
> +		git show-ref --verify refs/tags/TAG_F1_2 &&
> +		test_must_fail git show-ref --verify refs/tags/TAG_F1_ONLY &&

And because of that, this third line which does not correspond to
any tests in the original makes the thing fail.

I think negative test was what I suggested, but I didn't know if
that particular tag used for the negative test should or should not
exist in the test at that point (I do not do Perforce, so I still do
not know the answer to that question; in any case, due to lack of p4
in my environment, my local testing did not catch this breakage).

Sorry about the confusion.

Let's add this on top.

-- >8 ---- >8 ---- >8 --
Subject: [PATCH] t9811: fix misconversion of test

The previous commit started to insist TAG_F1_ONLY to be missing,
which was not in the original.  Let's not to be overly eager in the
conversion.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t9811-git-p4-label-import.sh | 1 -
 1 file changed, 1 deletion(-)

diff --git a/t/t9811-git-p4-label-import.sh b/t/t9811-git-p4-label-import.sh
index 39856629c0..9637a46d6f 100755
--- a/t/t9811-git-p4-label-import.sh
+++ b/t/t9811-git-p4-label-import.sh
@@ -97,7 +97,6 @@ test_expect_success 'two labels on the same changelist' '
 
 		git show-ref --verify refs/tags/TAG_F1_1 &&
 		git show-ref --verify refs/tags/TAG_F1_2 &&
-		test_must_fail git show-ref --verify refs/tags/TAG_F1_ONLY &&
 
 		cd main &&
 
-- 
2.49.0-524-g64a58d64d1

