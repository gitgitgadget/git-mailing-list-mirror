Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8C8A2853F9
	for <git@vger.kernel.org>; Mon, 15 Sep 2025 23:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757977986; cv=none; b=tUNJMAd65OmQDDpeBMEBEFIqeZGFAe2ykHT5fD2Jhmexc9bgH6Mr52XyzswlJuhyc+xwW0WzkGl8uIAhrOgASvguBiyNoS1nhdNri8Hl1cYaZXhAmsD/JonSHc012RmrqEIYAbakPT09Y7IwWG6/xDn78dW2Ib6cqmAvsCxMFaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757977986; c=relaxed/simple;
	bh=YzGpcCq2CQl0Adg5pHmybe4pjHcWJI/HLnkhR/6IaFg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rfvQ5svTsSI5QB6oIBg+7Dz/4ylzMC2E34VRv7Tojqp7YhbHqvSYG58te9wThb6ZyXsx2xjxszNMZajqzVL1A3LeyTEfw5ZvG2uuDCPpOY96tUghWXAUiXGD4hc6CYaacsaifft5Y2nGOptcm877VoxgDNSZsq0xtci1EOCyuxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=PbLxyZ2W; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Lv/9Umt3; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="PbLxyZ2W";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Lv/9Umt3"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 8EFF37A01D2;
	Mon, 15 Sep 2025 19:13:02 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Mon, 15 Sep 2025 19:13:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1757977982; x=1758064382; bh=YmhYcHZYEj
	rv/Lq12bXu5noYmMWejbwMyRYVHVjVGAA=; b=PbLxyZ2WKTsDZlPnqQ4Dwj+8Lk
	isfCkgYcxKdDv6N08J0U2OiB4GVx2bhCyXci3+br+9Et+8VPBFdLXZGox0xoQwpt
	4UUT5v1v/gtZB/LZAtAeRW805HHGQISETFwZcTjDav5y6118BbrAXjQDwByiu7tg
	z+abqUB0kPHNQ6r/mUixQqtKyRw13ob3b0ZVFSxCsVqOWBUfzhJVI9RQUIrRNkid
	jFNZmEIPWJ0MqTwOXmcsF7gzgbwlp9hyMPA6mFtauoX65MFVK9sEPy5HVOBuKe6+
	BQ9ZE6Yt2lrllYhuI7Oiw0m/dUFjW35B28FyCyvFNonlTb3iz60FuPsKOc8A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1757977982; x=1758064382; bh=YmhYcHZYEjrv/Lq12bXu5noYmMWejbwMyRY
	VHVjVGAA=; b=Lv/9Umt3rSewGF31HwcrfAZIQSXAqe4h7ba/bSCPtvltMLQjxvy
	ZXxHYdsmJaUEAtPELT29njPasIM8ZK7SO7z2WveGrhA7IIITHThwCeitHsl4d2PF
	/AQXLe8EJ8RxT0zj+tCLOj2gRM8BdkodppWwDvlkXm9SwHFFSeAzTbb+yT69pENY
	yFlcEa+6fIlIdlcTmtsTuB8yNlSxVlyAclW6JRzWe0NR2sDsHXZpPSN/Q7nXgvKy
	utI/rPEp6ubQn/57zCdO7FHwYqJDGFVSrEvKEzdcNuWT1Ce+emAeH0pRI6C3axgd
	ZFa44JUrL5OhEQ8xd0bnN+EWpLW6iabtEDA==
X-ME-Sender: <xms:fp3IaL3cjhrq-eAPzhFtGj39BNm-LH59882Y7GqDL3mScZ7x2GVNuQ>
    <xme:fp3IaErYS3t8AjhOXJxxPLSw-lkMD9QFX-7_P7np3reC9d-bL9oxW_gKiySAB96ia
    3wqFDPF-0mXhNsBOg>
X-ME-Received: <xmr:fp3IaIeh9QwPgNO-P1F0wc96uJSx3tVdr3-OJPLFzOqE8V-uZYnwblRx1pFvw7ymw0XusNsBipxQcBbiRNpzr1tFEV91Y1lLsbkm5fc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdefkeelkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepghhithesvh
    hgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehsiigvuggvrhdruggvvhesghhm
    rghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:fp3IaDpGatvtW85AUYU3c5cYFxfVUGk18FnWDWdMesgKRDSk4u7_aQ>
    <xmx:fp3IaJFQZj-D0FBdf-Jxw-ftqS5NIqk28TMNbg4DM8TDY9FNewITNg>
    <xmx:fp3IaDuniXbvJbkKBvgPDANq_CTCCSE8oOJZCYrwMxHidKpuzDN2Eg>
    <xmx:fp3IaLUcbJT-cAOG1sQ7P2lQShY4cg7Iyz-GuhP0TwBvLldqquSFuw>
    <xmx:fp3IaBFeJOqqUN6egcn3C14VJNC6zyhIIE2KL6nPzb0zlRWcY520A0Oe>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 15 Sep 2025 19:13:01 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  SZEDER =?utf-8?Q?G=C3=A1bor?=
 <szeder.dev@gmail.com>
Subject: Re: [PATCH 0/3] ci: don't compile whole project when testing docs
 with Meson
In-Reply-To: <aMeshpRtFWyE0ja4@pks.im> (Patrick Steinhardt's message of "Mon,
	15 Sep 2025 08:04:54 +0200")
References: <20250911-b4-pks-meson-docs-target-v1-0-a92c666ecef9@pks.im>
	<xmqqwm64orc1.fsf@gitster.g> <aMeshpRtFWyE0ja4@pks.im>
Date: Mon, 15 Sep 2025 16:13:00 -0700
Message-ID: <xmqqcy7re2df.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

>> I wonder if we want to let people say "meson compile doc" to match
>> the other world?
>> 
>> Will queue.  Thanks.
>
> The reason why I picked 'docs' is that the accompanying user-facing
> option is also named the same way. It's thus a bit more consistent with
> itself to call the target 'docs' as well.

Sorry, but I am not sure what user-facing "docs" option you are
referring to; is this some earlier mistake we made that is way too
entrenched to fix?  I do know about the "make docs" that barfs with
"*** No rule to make target 'docs'.  Stop.", and I would call it
user-facing.  I would say it is a bit too old to "correct" without
disrupting existing users.

Thanks.

