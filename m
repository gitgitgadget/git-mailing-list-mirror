Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE5E02DC77A
	for <git@vger.kernel.org>; Mon, 12 Jan 2026 15:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768231236; cv=none; b=enzwXqIwYKLPt3gFv/wZkRWyZALU1keHQCqC67E/twCI4IbkZ8J3lhRCzLttTBlOLtPIrZp79K3f0FEdjgWyo5MZzzBPzESum21flUFg6xOVDme6XxKArLMU6fjD/QlUczWT8mThanDlbBQqxamWrqAa6NIr+X2X+BLq5rwciMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768231236; c=relaxed/simple;
	bh=yk84XEggTluvvNsu5DE08ON3JR4VPSEKtztK/OA7f2s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XUGOimq4rUkIAl63yB5n3VdKT4AjwoqwH4+DfFsCAqv33wwCiIWAH1mnL8VIYV8TcK2SAnxX340oWMGz9r9UHufad8wRJwlG9wTCbP4TO+1SehDn/L1Nv9OSCLP8AkaeMGBirxv+C37n9nMM7Pm9hbuVBi4s6WaMSQzkHoUNRXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=KVvJtNNd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=aSJzEicw; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="KVvJtNNd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aSJzEicw"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 390C6EC0633;
	Mon, 12 Jan 2026 10:20:34 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Mon, 12 Jan 2026 10:20:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1768231234; x=1768317634; bh=qwkPdL0/f1
	iZUgXAU+g38ltHJH43VNusOzZaPDSQ2o8=; b=KVvJtNNdnE6ti5TIr5kViXb4dp
	UiwMGPL4H20URY2fNW0KAfMqK5Xsphe7PJmB234wdDbepiCVsBqxFOugbmMBGhx4
	GczNEipf+imq6UW60bT7A3wzBlVfQkN2g5+BVRwIxK6jp+12PA2p1YgdNpjvLfa8
	ciG4LlKz2XABZQuP232/PRsWxXk6XmHr8A+mmOl5H2iUooRltzu0O1DmTk1dCrAf
	yKxZQEy7DydwuhHnCiKWanZYeqZkZUMQZxWpStBwg7a3n5LQtqK2tF1Lf+x5a5xm
	9YaZfGxowPbZXsQ2jPJT9wPC/rywYs1dxlbSWdfyv5O5kgnWAF0ivEbzQnHQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1768231234; x=1768317634; bh=qwkPdL0/f1iZUgXAU+g38ltHJH43VNusOzZ
	aPDSQ2o8=; b=aSJzEicwNF+SLqMFUyV5nozu8b5hZ1TfDe/U+3kh8BDliBixmBt
	6UnRp741bY+Z5Hwbi3kG/hI2p8lAU6hFp8YgkqzgY1SiHPfju9C0uQ3m8zKg7dNN
	xaIYieqLsBmsdO3IN058/JbCODv0EpZg8/fcxtRGa9IsfF4G8m4l30/XAQ0iqa65
	bzxExYgm9cliO0uG97SA5gbWAt8blPoZMv3TWhBXbQ4rJjiQx0okBGUsKHYTaeIq
	xdyNJoJCitzSqfBMCIXF5pDWIHU2BAhIlrpKR0EcZFMV+DP/ER1tXaCrC8jczd9s
	HR7dv7HuVCVlosWJLFukVh7+wAKXi17PznA==
X-ME-Sender: <xms:QhFlaUNLhx_f8RpWifrMSmuyeTVXG0U47j75ruEkDPodzsc9qP39fQ>
    <xme:QhFlaR_-K9ntAmd60Bg2Kn6fNJj2l7rD4Bc4pvZp303ofnjf48RbHBYH2yZJEFcVy
    jdf-BZxZOeXhr1RNGzFW2g7LvL3FFIFIEm9d8_B--lrpDwpneggXg>
X-ME-Received: <xmr:QhFlaQQbiZJ6KsxcwlqqIuhRa4WHPJwdDxPcV8h40Yeym7H7NdGjLIKS_7kD7ewlNTMCTrZ6vPvxXpisqiC77TfPxaoO1RW6pgnzjLk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduudejkedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehlrdhsrd
    hrseifvggsrdguvgdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
    pdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:QhFlabkmdsuKh4qIpnEbqt2QrpP2zcle4Nhp0T5d7Vi2PDCakCFZaw>
    <xmx:QhFlaYTo5ZV2bO87bcUoJd8vRRBtf8UA7TbBAK9fr8kq0a0VafTWrA>
    <xmx:QhFlaRPmEIJh7Bw6945JON6cMIQdTTWktnA63Xv3YWXCAK--ZT5OYA>
    <xmx:QhFlaZUbVquOT2rStTUwebfK1NGAnkSMXe7f7Z2SYAvfzIZ7V5VWlw>
    <xmx:QhFlaRPIAhm00bc-Kr2UmCYXb4XmxIFSbzlAK7RAyUL1UKJrUZaaUL_O>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 12 Jan 2026 10:20:33 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,  git@vger.kernel.org
Subject: Re: [PATCH 09/10] tree: stop using the_repository
In-Reply-To: <aWUMn6G0C1cHA4qY@pks.im> (Patrick Steinhardt's message of "Mon,
	12 Jan 2026 16:00:47 +0100")
References: <20260109213021.2546-1-l.s.r@web.de>
	<20260109213021.2546-10-l.s.r@web.de> <aWS9Ll8CQ3eILx3z@pks.im>
	<xmqqh5sqoqr0.fsf@gitster.g> <aWUMn6G0C1cHA4qY@pks.im>
Date: Mon, 12 Jan 2026 07:20:32 -0800
Message-ID: <xmqqms2in9hb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

>> > In any case, I'd propose to move the compatibility macros into a section
>> > that says something like:
>> >
>> >     /* Deprecated wrappers that will be removed once Git 2.53 is released. */
>> 
>> Please do not take release schedule hostage to one particular fix-up
>> series of patches.  Thanks.
>
> The intent isn't really to take anything hostage. It's rather intended
> as a hint that once a specific event has happened, we should take
> another look at removing these wrappers.

I am OK with a comment that records the intent, e.g., "let's work
towards reducing the use of these wrappers", with the plan for the
next step, e.g., "and once we have done so, remove these."

But the comment you wrote is forcing people to make sure we remove
the code that uses these wrappers and unless we finish it we cannot
release 2.53, no?
