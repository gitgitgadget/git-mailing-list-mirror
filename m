Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB30034A783
	for <git@vger.kernel.org>; Wed, 21 Jan 2026 18:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769018680; cv=none; b=T7bOCiifC/UeDuqEhcmF+eqpNvq1+qZTmTZY0T3xNHxeA3hRMl0ecnvQ1S9iMgO6GH1IwITwLXJRl8HVQJVn5JhPpaRqVLSLL05vFIfg76IiTMN7p7pYPEn/JZRYS9xLNfb4+1XjulSVtO7Z5xocL7j7t3NMMmq4v9ukGU4L6+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769018680; c=relaxed/simple;
	bh=AcO99QAbCFzqzC2GITuhJX1Hm8rv4qkFZp2QEeIi6O8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lAJKzjsKwrfoSRaHmrP6ntyMekAtMGaMwub6q7AknY0jO0UjyqLCckAcyptjEwNvjWXVi+17CguDSNhJn9sWOkBHTiVbc6qFyegbXlU7KJnG0jZobOfJ8Q6jp98dJ1uwaRFN53uVXJFdB7qllq+K/7iAXF0TG4lBBseFJpFMbC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=mVvdogaT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OnezAsBt; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="mVvdogaT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OnezAsBt"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id BECD81D00056;
	Wed, 21 Jan 2026 13:04:34 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Wed, 21 Jan 2026 13:04:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1769018674; x=1769105074; bh=BAXlCdiIbe
	v2yxjpMIkAHtLogrXfazq6G9jVo7CdWeg=; b=mVvdogaTgwLJ6Wihqen+xnnG4m
	vaSF+96v2gNxHUnpkLKdDdTdJiQ+qyxwlRzhdQWfaaL9frMQskBUV5hxInlGgRer
	hJDJ2fA4dmupf7+H0nN3NrIsCnYRf9WLnHmnLJZ/FmGIu67zwklqy8D47Yf/m8Po
	yAL6Qh3rNSJgY5Y8w7pOaJF6wUT+2MoYbmk0OD8XNNTvzSr/mzcnzMRliKQj1B+/
	7B7kz1z8hn0gONuxRRlASme/6BVHvwMYo/A2IQpNzF+WwNmDRJ2BuPKgVI0Pptl5
	lZe6gNEhJZGge3yvU+EPBB4eLgf9y/5UIyRbJef3ZvnHnDP/JLOWDPZo5OjA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1769018674; x=1769105074; bh=BAXlCdiIbev2yxjpMIkAHtLogrXfazq6G9j
	Vo7CdWeg=; b=OnezAsBt+LSWxJpQfWVVcZkJhdOlgPu8OT6B4Ct6xzRgH205Z9J
	1qrk0Yk6NNw+lDgx/ZiyTCDgqSVyDCAxdrCmtKWuoGldImIMbLBPgiZIg+X8jrgv
	YPtq3Ih5YnISq3KTJCDhIpJphcn6bFHDYlHV0xDyi0iCwURoiNC0ORmsJOF1T/ee
	cVnDhhUCG/M7QS2Lb2q+78T22Ozrv8Zrn3B92IB94Ixe1BIFpbyIlhPQ4dx15hMn
	pNpkuMyCpHIpZ49aOXpsFKiAFeib+Hz0QrnJGD0savgZvoqunOJpONqTb6g1hBFp
	Bh8UOwGp0DB43oEY4YTWW3mzIgDBt7ay/3g==
X-ME-Sender: <xms:MhVxadNqK7ffpcbnfkfw3Rx7KMPtn2TctT8HkjGxU2niaoURUDyKdA>
    <xme:MhVxaW_OKNf_DHjz1FbDBWGDmXqcj6RWdHm8qym1un51VUQi1-a6dvkeoU2AvXAeZ
    Ni0Uc3hdaRex7AWy_2-mNFOCQWinv9ciS0e70nme1POfvwmDNKZ>
X-ME-Received: <xmr:MhVxaRStFUQQ2ipWQJ0-0rvaLpD3JWV-sPIOqZAjEBjazaCIjzRpIIMAezPMn-ZHrLCLdYtC88D2KiDGVZSzVZUFDnhx7oUgd1QIf5g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddugeefleehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeive
    ffueefjeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsg
    gprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegrfedvtdeh
    udehfeegudeisehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvg
    hrnhgvlhdrohhrghdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepghhi
    thhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:MhVxaYm3SjZFnIq5EBPty8n1FLlp0NPI2V0uRqE0uLsB0YoKNwxl6w>
    <xmx:MhVxaRRxQuy7lZW5WX7AjnoUQyc3b_KVYm5I6_oD7vBQ-0qdW3Mmkg>
    <xmx:MhVxaWNr6C5flL3ZvCJNlj4MdLHBHx-Oe78X1q0afmekt-6lw1xxMw>
    <xmx:MhVxaaW-nyoSzJaC91ac_6-COua-911GRQG3zitr0CeqfaL0715JqQ>
    <xmx:MhVxaUx0GPDUHyFtY2GrbnltQnhXUbK5646sov-QG5tnmyhZFf8V3DiB>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 21 Jan 2026 13:04:34 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Tian Yuchen <a3205153416@gmail.com>
Cc: git@vger.kernel.org,  ps@pks.im
Subject: Re: [PATCH v2] symlinks: use unsigned int for flags
In-Reply-To: <20260121162640.424126-1-a3205153416@gmail.com> (Tian Yuchen's
	message of "Thu, 22 Jan 2026 00:26:40 +0800")
References: <20260121162640.424126-1-a3205153416@gmail.com>
Date: Wed, 21 Jan 2026 10:04:32 -0800
Message-ID: <xmqqzf66u9jj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Tian Yuchen <a3205153416@gmail.com> writes:

> The 'flags' and 'track_flags' fields in symlinks.c are used
> strictly as a collection of bits (using bitwise operators including
> &, |, ~). Using a signed integer for bitmasks may lead to undefined
> behavior with shift operations and logic errors if the MSB is touched.

Which we do not do, so the "signed can lead to bugs" is a valid
concern and moving to unsigned is a good mitigation, but ...

>
> Change these fields from 'int' to 'unsigned int' to align with C
> standards and typical usage patterns.

... I'd tone it down a bit by replacing "aling with C standards and
typical" with "match our", if I were writing this.

>
> Signed-off-by: Tian Yuchen <a3205153416@gmail.com>
>
> ---
> Changes in v2:
>
> Decouple definition of 'ret' and 'saved_errno' from 'save_flags'.
> 'ret' captures the return value of lstat() which can be -1, so it
> must remain signed. Same applies to 'saved_errno'.
>
> (Thanks to Patrick Steinhardt for spotting this)

Yes, indeed.  Thanks.
