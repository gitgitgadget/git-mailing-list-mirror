Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7A3B2D1926
	for <git@vger.kernel.org>; Wed, 20 Aug 2025 21:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755724565; cv=none; b=qfICf7ZZkB2REEPc3VoUqfTzHPsl/frXRYWeOPW6pMo5NpU/kKRGF+Gj2gbK3BIBNAFPPbOgXJf5+LMgAUB+LbBlP2EgwYjXLUdJAbyq9OfLlyD/9qPbSNxu5D1UMxWl4DETvZzEaxlaRJ5ctP4I9Xb/oKNjgijgAYeE92RZTvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755724565; c=relaxed/simple;
	bh=3ZAhSr+HaNQbi52MDLf0MBrf79TPkoI0lVEdj9wXx0w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qIgF4dsdPYbrS8FbDzOjJYIqeAeNjPWYJpFCjMfNexRzEoYvOCbpx0FIfOkaY6NB5AAG7vVyWlqnFSiACqcG34bnes6S5LJbjkXt3xOQBZJxcwV4jltdEOItlcmXKV6nMTZqwTOwgQr0+kSCjvQRGXebvE0eYHrKIxMSrQg+xdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=DtPZhLTP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Iwdly2Jt; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="DtPZhLTP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Iwdly2Jt"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 891747A0060;
	Wed, 20 Aug 2025 17:15:59 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Wed, 20 Aug 2025 17:15:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1755724559; x=1755810959; bh=x2oinXeYsq
	3JflyB/anyuX2Qpy/9k40BUAvduAEDKDc=; b=DtPZhLTPHgmSgGVFuQxsIPwW6R
	7msS73JmwpxJFNx2LCePHm9iM/PleozHgLXtd82yahEL/wsGhhThVT961sxDx1so
	hFzEhA3eTrxBYcothgaPjYVFGpMvH5u6419cust76zDWK/dcBXqXafB+fK5R+ym9
	0y8fjtk/3/jpyFpNQ5CF49b4sIrNt0+hfcEg4jK/AEH46HZXUgh3ZY6m2UlB4ryj
	DmwFOl+aoFyHQ0QYiF3rspSABEUubR60ngdYtDGSGZq+AZGlWfe4TDBhwOzQLr5X
	COcTEcghHSn12t/tLvW04u23kKs6F98XBSs9o8hFINtqmcYBQK3tgAxN30/Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1755724559; x=1755810959; bh=x2oinXeYsq3JflyB/anyuX2Qpy/9k40BUAv
	duAEDKDc=; b=Iwdly2Jtro48Zans+gd4Y1NixXApSYlTceectYUJwOujuPxItHQ
	lzmKbwyeKubbqXoZDZ/5MmedWZdJp7zA6i3C83iMu35aYG9UFTDC1DahGCorQOpI
	W7Q1IDfTLXBHFYI6KXv+29g5tgMf/KpIv6H/4GqSQlBsF5DewvBDiXWXALJaqJep
	kBeeMxgA1VuQ5J8CmjvcrDd4pbf+5Tc88JQE6go9LiKvR6+0WjpTrEdUEEM+3VhO
	hFUar/kNkNqrwDDbk1aXU+uBrE8g/OT/QoJYOoJ5F7VBxAZ+Lnonp2w/nbF+MzUw
	vHfeojZt4AdEVfnnBicBz8oRhISZL8FKuKA==
X-ME-Sender: <xms:DzumaIEjOUqZ2DKHf3rrxpUW9lEP7X1y62sq5ze8JrEmToIgL8tqeg>
    <xme:DzumaM2WOCw8aPL8lpZ88Oh6-xXNu6kzWu0uVzVNdkJLPS5sQMyrkLbkRLDLV9Zk-
    -0fUCwkIGQXmaDkMg>
X-ME-Received: <xmr:DzumaImNMfyMvtdBk50qdlGfYxAoNDWUVgbfodw5hIci2J42UYM0BGGzlk9vp8SsorJy9_Ax75AGEZMEph5KSXprW1yCXqisTqxzsVI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduheelgeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfh
    grshhtmhgrihhlrdgtohhmpdhrtghpthhtoheprhgrphhprgiiiihosehgmhgrihhlrdgt
    ohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtth
    hopehjiehtsehkuggsghdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohig
    rdgtohhm
X-ME-Proxy: <xmx:DzumaE8WpGNCa1xGPPTYMUiZA2OE6O2aHKxKA-iPPQ3GbX1hb95Big>
    <xmx:DzumaFrTuO8k6sHMD_AuYiKtMkKxgI2XLOpbt35WCrDtYVuvQRh8IQ>
    <xmx:DzumaFkhxlicAhr2RErs6ke488pfSwvHjdQf_mQMoQpBzaEyRkmOIQ>
    <xmx:DzumaEhqz7ESSo9gJec27dIjDpqi4LOWdDNKx3gAG29EHa_o9yV0ZQ>
    <xmx:DzumaILsO7LrhFvhinLt8y1wEkB19eooeVzECkp5wJsqtSoZwMLAoQcM>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 20 Aug 2025 17:15:58 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
Cc: "Michael Rappazzo" <rappazzo@gmail.com>,  git@vger.kernel.org,
  "Johannes Sixt" <j6t@kdbg.org>
Subject: Re: [PATCH gitk] gitk: add README.md with contribution guidelines
In-Reply-To: <70e08a97-ca6a-4899-b779-1ed436b76fb7@app.fastmail.com>
	(Kristoffer Haugsbakk's message of "Wed, 20 Aug 2025 23:03:45 +0200")
References: <20250820195229.45943-1-rappazzo@gmail.com>
	<xmqq349laeyb.fsf@gitster.g>
	<70e08a97-ca6a-4899-b779-1ed436b76fb7@app.fastmail.com>
Date: Wed, 20 Aug 2025 14:15:57 -0700
Message-ID: <xmqqfrdl8zjm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com> writes:

>> It would be really nice if you add "review them here before you run
>> send-email" step between these two commands ;-).
>
> I alwyays use
>
>     git format-patch ... -opatchez
>     cat patchez/* | less
>
> Because sending out something weird to a mailing list gives me the
> chills.  (And there might be format-patch bugs.)

Thanks for a tip.

It matches what I do, except that I use ./+jc/<topic-name>/
directories as the staging area, as I tend to keep what I sent out
for a few days, and I strongly prefer to give its own directory to
each topic, to avoid "git send-email *.patch" sending out random
unrelated patches.
