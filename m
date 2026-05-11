Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D4E037998C
	for <git@vger.kernel.org>; Mon, 11 May 2026 06:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778479828; cv=none; b=UGirR3olRSpzEl8NQQpfIaunFyYNJ4/pUl4jZO/wHKsIU0FDtdKImM66MwmbPR2d600lPF8Yy0s/ZHE3EqmHRcOQcBA/3IOP+Reh+2r7ziE9pPD/JQqxTd6B9SMT+M9hWxrLTszvEvD/SBktsa9LHajP0QdCABQjHm0aQlCYrsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778479828; c=relaxed/simple;
	bh=eYksa/ch1Wmu7ZJGMUI1uMJebgmb3sUi7GEGQMNk2rg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SDOgWF6IzlFPDUpQ/ZMKY3of6QE0wnXnTJNG1BYTIwV/vfoAH7QJM/TntY1S65I+yBmavwIHqah96fJ0CJFJ0tr99OM/122EO9HOK1jcunAOsRd63tlebZoM54mWTnngEB3c3ynzDfvD7SpOCZw1r/L8Mkpohvk3D5kfnTYTklU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=PumngJgd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=a8KsnD/H; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="PumngJgd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="a8KsnD/H"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id 057501D0007B;
	Mon, 11 May 2026 02:10:25 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-09.internal (MEProxy); Mon, 11 May 2026 02:10:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1778479825; x=1778566225; bh=foQmzbiEml
	wjX63IO0f84JRFZgNTPIBGiNgmV16EmjY=; b=PumngJgd5uV0o7jS6hME+Rm7DM
	9HI0hvVlrRdWkrDnxP5Ro/zLObgDH/C5ZqBiUZgja0JJ/g1eIepRPWVTTeeFr3G0
	d246/b0xhWlDYdCbUOFJOXwzxmA443D4te09h/PdoCb/bjcStmNxaXqQssEy1Z1Z
	KLzmMUGy2QrsAYv23w/gMG14iFbnnDW2uP15rXKiKrCIYT6N/hbB+0SVWVoaCJ3c
	C1VIkth1xJoRgQLqkyHqtSAijdAarKxjf5sgmCLfmOPywv58rpiRTp+Q/2nCBAfP
	c0sdpTYCqvmxlSAyW5OgNpdkpHtQYJOlQm9FIKP4aq2151bXluDIzxYNEFaw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1778479825; x=1778566225; bh=foQmzbiEmlwjX63IO0f84JRFZgNTPIBGiNg
	mV16EmjY=; b=a8KsnD/HtZhDq6p5xqJYVLkdjpVRcGIAokpzeEq71bzI6cWdS+r
	SOuOkeuJxnfwmuR3ZIF2pPjCg9g1+i3RKBhGg8HN90ELOTBHCCIjGb2va6KpcpyN
	SZ7+qMA3raO03MULeuArwxDxBauskA5UIEbpKKauM09P4rUAPwIpSs75p8xOUSih
	ZBrn7lGKQ9O+MlWCVaQaWHeA4XgrLaRL0Z1l+LJVlakO4JuSnJ2+dffWSeWSKi37
	MaDx58+L3CQCS3eGFy7oPnFk2u2P18IiSUzz/fdkdAEdEKR8o9b7MYKiOOKBLhSA
	dzquKVMF+ikjDQbUP3DSogXqOHVi/xqH4Kg==
X-ME-Sender: <xms:0XIBai8jGplyDn15zLJjFPmtoLJD8AafNrnGjlNdtypZy3-BhMgTWA>
    <xme:0XIBapv1P0Buwy0ybkrLvK2htcw9r4p0bihZRmEUnxcgJHeUuLhCQzl86WXIFHTLD
    hYb-3wnpcdLt3v9QQIyeLNftmUhmMA9EBYLfnmNoYCZ54HFBg0rIA>
X-ME-Received: <xmr:0XIBatDishRsDXARVPq66rmTpRcqTJiNZuxqSsOd2l4M9prYMB3rSWbz32A1Ky-xcBinLs_MFFk0gBARUc1XhhV5FyVvWvH7iw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduudekvdefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtofdttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepieekueefhfetvdfftdegfeekhfffgefgfeeivddugeffgfffffevvedvieel
    ffdunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehsnhgrth
    husehgohhoghhlvgdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghl
    rdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:0XIBapWA0dj5_0-rMxXGj1S1qQMbKMHyTo5k0SRpKqCOBxeWGTFoJQ>
    <xmx:0XIBajDTVveKOtiwxeeewD9xD4eg24vMXDwPcYuh4rb6SF8DbSJgWA>
    <xmx:0XIBak9Zi_Cb7sWLJmyQhGz3R78TtX_897GtmkRh9Ks45f5CCwypAQ>
    <xmx:0XIBaiEUUfyQpXF937-20clSx7fa0ZDJq6CC4onGIPpTRL5W5On4fA>
    <xmx:0XIBalH-P4yJ6yIX1Nz9VKap-HJHW8RSnOtI1RD5_o0yLD0Q2aIZ-Jc8>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 May 2026 02:10:25 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Shardul Natu <snatu@google.com>,  git@vger.kernel.org
Subject: Re: [PATCH] build: tolerate use of _Generic from glibc 2.43 with Clang
In-Reply-To: <agFtGM0H4S87ZxwR@pks.im> (Patrick Steinhardt's message of "Mon,
	11 May 2026 07:46:00 +0200")
References: <20260505-b4-pks-ci-tolerate-glibc-generic-v1-1-5786386fe512@pks.im>
	<xmqqzf26sk80.fsf@gitster.g> <xmqqqzniset2.fsf@gitster.g>
	<agFtGM0H4S87ZxwR@pks.im>
Date: Mon, 11 May 2026 15:10:23 +0900
Message-ID: <xmqqecjischc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> On Mon, May 11, 2026 at 02:20:09PM +0900, Junio C Hamano wrote:
>> Junio C Hamano <gitster@pobox.com> writes:
>> 
>> > Wouldn't the approach you took on the meson side to pass
>> > "-Wno-c11-extensions" be yet another alternative?
>> 
>> In other words, I would imagine something like this patch that uses
>> the same strategy on both sides may be easier to reason about.
>
> I was going back and forth on this myself. I simply wasn't sure whether
> it even buys us anything anymore if we have both "-std=gnu99" _and_
> "-Wno-c11-extensions". But maybe this combination at least also detects
> the use of newer (C23) extensions?

We shouldn't be the only project hit by the unconditional use of
_Generic in glibc 2.43 headers, should we?  I was hoping that this
would be fixed upstream, and that anything we do locally is merely
a workaround of a tentative nature.

> In any case, I'm also happy with the patch you posted. Thanks!

Thanks for a quick response.

You may have guessed correctly that I want to fast-track this topic
down to 'next' and 'master' soonish to salvage CI jobs running for
them.
