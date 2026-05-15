Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A1D521771B
	for <git@vger.kernel.org>; Fri, 15 May 2026 01:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778808431; cv=none; b=a6aBzr/Mb9tGf7gguPLmE/zz3qHmHBRc2Ob52UbSGZUkE2TAHZ9AOJ9fta9M/Gv50mKaw6FAQmRQSKeqQfSkWj9e5Gl3jQiGQkqGW8lmDd3puq1vcI00BlSka0WJ2CHSZFdtZRS1GCl0ncWtO8JeQh3LY3pKOfPS4Iy4MfPUDtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778808431; c=relaxed/simple;
	bh=4rgeI3vKoRLsqK1ZLpYqI+L7wY2cnhRKyU0ZmySNEqY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rR8LePEg2Ezik9LO9LdQd4vYdjofHbHqW7QOoIynY3/yBs5R34e3rFokR9p1U5eNAcxPe65mrVkoAWTnk1b6ASNM/TIwsdbhrN7bRhKmBCH7ThunkIyaT+hCI/KhWXvusItsd6kI5ZXGSb9xv9upySU/UkqxinWml1Yg5Hex+qI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=brhwP/nX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ao2HGSEx; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="brhwP/nX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ao2HGSEx"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 8DCC3EC0076;
	Thu, 14 May 2026 21:27:08 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Thu, 14 May 2026 21:27:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1778808428; x=1778894828; bh=mipVfnGDJw
	f0E/W8HvTWfm9BuENcIX80UiZo0h9C9M8=; b=brhwP/nXZfcD4+ZjpHoOHEyQUY
	/QcH+8/BjeczVH2HvYLEWZO4czq+f7D7EsngzcGa5LmJCa1bEB3l2vn6odsyAvBn
	mJchEFKr7TUadlb9nV05rCxm4GcT+cOZqc0HV+MWcQOI3PnIFT8d1ZhJTLj/vurP
	1ZFYSurAKQwk/MVG0SQi3gKnuhBZspDazjc1SLrhswywNl9wiD6H5FneUaCO0Pdl
	fC05hrTUmu23LQv0vcbUa0kM3kvtvc0rZWo+J1VxeNaaDzDS1JOYmZrdpz2Z5pky
	bXRJMR5Sj4lK8O8VOhiFUYHWDygIZT0/6+RmGvE8lxhrp2Io+0PkSy/a27PA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1778808428; x=1778894828; bh=mipVfnGDJwf0E/W8HvTWfm9BuENcIX80UiZ
	o0h9C9M8=; b=ao2HGSEx9akevf5CcHCkRFDb2mnSgKjPvYgXnGmIr6BUn5iO34L
	27Otqf1YZXEm7vqkHxjMCqmiipKwiyU4JyadG53pXSpmpFjN8JhIHHMlZhU0VHG7
	87IEJo1UewBePW5SokInFDEGeuIpHZjMPwhrMMVem8lu2Y/f5hmjI6k61Ydkuj15
	FT87Fb8Zin1GLRF2sUFGASXYm4ksTKnkTB4HepHLu1csSWUQUHzu7pTBQKYRqRJI
	Wi3AxWxVLA/Y6OjH+9USOMLhs58c7gV3YCrnf6mVXt4rIH/9njVPqfBLk1IWCeZQ
	Xx7G28etE/Df2Q4VLYhv8rv9QAqoT560zNg==
X-ME-Sender: <xms:bHYGaqGp0tZzRBN6Fh4g8AqLbERHTf3kVKLzgvRT_3EuEG1LFlfkXQ>
    <xme:bHYGaiWgsx2wDatQqMkEPKnpBeaGbYmZuLS24hQ7floT0aQHAhpiMjzUIL-SiXze_
    AMlKNYXwse8F5_4CIWR_FeNiGTySMuSAndSRETpm0j9zNOh-DO0KA>
X-ME-Received: <xmr:bHYGapJ7Yi2cUui1v2cSvbmDQZI-jUGZp7g2cwv3oAfYrdGw-UcdabquQ_rcMCunC50X0piS-zPU0VJ2Ry6zx3ZBN91IB5X14A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduvdeltdekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepthgrrghhohhlsehuthhurdhfihdprhgtphhtthhope
    hgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgvfhhfsehpvghf
    fhdrnhgvthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:bHYGai_Xqy1Uw0eb06ys8pZUt6wTFtKQpqsjKtIu2Yum8SMcs5mnMA>
    <xmx:bHYGasIOFKSJ7fviusNOfGQ6FGlPRzItCu0IJwqNPUdinG-kwuAD6A>
    <xmx:bHYGanniOgcvlXXs8pxIXQdD7U-I5eRXIcDIw96hnRiHCntdNEkn6g>
    <xmx:bHYGagM3AjlGe78NMlam13ZfPqu2J1anvr7FpSsgDIj8IDOAjOrqdA>
    <xmx:bHYGaq8fbkeGQ0MCZoyxhsVysnqnZk84H1qQXs0ewicdnxk-j1CFus-w>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 14 May 2026 21:27:07 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Tuomas Ahola <taahol@utu.fi>
Cc: <git@vger.kernel.org>,  Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 2/4] approxidate: alias "today" to "now"
In-Reply-To: <20260514210742.Yc6NZ%taahol@utu.fi> (Tuomas Ahola's message of
	"Fri, 15 May 2026 00:07:42 +0300")
References: <20260512145430.13212-1-taahol@utu.fi>
	<20260514115520.6660-1-taahol@utu.fi>
	<20260514115520.6660-3-taahol@utu.fi> <xmqqwlx6f1fo.fsf@gitster.g>
	<20260514210742.Yc6NZ%taahol@utu.fi>
Date: Fri, 15 May 2026 10:27:06 +0900
Message-ID: <xmqqik8pea39.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Tuomas Ahola <taahol@utu.fi> writes:

> Junio C Hamano <gitster@pobox.com> wrote:
>
>> Tuomas Ahola <taahol@utu.fi> writes:
>> 
>> >     Sorry, I don't know if I understood.  Does the patch change the behavior of
>> >     that command somehow?  Is there some kind of edge case I missed?
>> 
>> No, I did not think it was a good idea to carve the behaviour in
>> stone that "git log --since=today" behaves as if it were given "git
>> log --since=now".  My reaction would have been very different if we
>> were deliberatly and explicitly saying "today is synonym for now",
>> but the thing is, it is not a designed behaviour but what
>> approxidate does for anything it does not understand, e.g.
>> 
>>     git log --since=decay
>>     git log --since=bogus
>> 
>> all behave as if it were given --since=now.
>
> Thanks for spelling that out.  So, as there is no deliberative
> decision behind the current behaviour of "today", the code has
> to remain non-committed on that; we are not at liberty to codify
> the status quo.  Right?

Not right.  It is more like "Even though we try not to change
existing behavoiur left and right without a good reason to avoid
breaking existing users' expectations, we should be able to "fix"
what is not intended behaviour but is something the code happened to
be doing, especially if the current behaviour does not make sense.
