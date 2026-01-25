Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5D7F26CE3B
	for <git@vger.kernel.org>; Sun, 25 Jan 2026 17:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769362501; cv=none; b=eK8hGzBOV/P/L1zDlyecFKmRjMD+j3JstR/SqyGFDSm1i9rIV6w4527oGig8toWaVPvaqQOJ8Zop+TtnIFzSBcj4ldJ0WQuCao92MI3XGiM87yMr9afCBW2uZQnTch+cbewBFAZZht0Di6x0E7hPKHir58dTpIeeW1FcuACGPVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769362501; c=relaxed/simple;
	bh=xxzpMmuva2DJsHz6+tQzu2XXvrqeukYK3astdoJ+6Jc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=oArdX8yhRDKdTBRqC4PzzMSkFrCy8LE8b7IFaXZQHBCka63x5old/6Wpc2epvSyMnH5Q9cbPqvBEwwWgXDEa4wc+8f1lgtgIW2lPGAyw5ZOX28CXoqJmaDDnpPdupfzWkcaKJhtpH/z3LRj/Ump3GbF5jPO5fiJnOgHQWGAGGck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=hetq+vb/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Fd58OmbH; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="hetq+vb/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Fd58OmbH"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id B19A67A0103;
	Sun, 25 Jan 2026 12:34:58 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-12.internal (MEProxy); Sun, 25 Jan 2026 12:34:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1769362498; x=1769448898; bh=XRqTnq3y26
	qq+3MG1x44IljsPEySjHNOQwNesHe2UWY=; b=hetq+vb/bvdh2r8K0xxH51JQ3h
	pwwmNj/+cZdb+Hu2SwDQ/Kfg9esz7wOUBWJH447e0B10YpH7MD9vuqf4XdWYE+AZ
	23UcI01FvC4L83q6SRoOPsC6vcM+odpy/4rzazmESOln1lJkDEE24NhmpJ3E3AM0
	lUIjyoK7INhLluP1Xw/wafkJfovKdl9z9FZ78/jA4jSWybpOuj1lhSlnn/QEktM5
	b8MQfc0nhYjiWbmwdGG3BI2dqPMdvRf8QV6k7SJWv/ljXxaSOa3zOM3IDuqDs4w8
	IKJWSIq1+wp7UtzB4M6Leu7RtJQaOD2X8tt8JBGSS2bpgngnZrPF+2dY17Ig==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1769362498; x=1769448898; bh=XRqTnq3y26qq+3MG1x44IljsPEySjHNOQwN
	esHe2UWY=; b=Fd58OmbHjp9obAoJybY6YTXGgB6YBXNs/W18/q/4uxLmZKfszBD
	9EYYLIrdD6VMuzqaxDrr0hql5otknOKmOSdZq5tCKDCSMPvZJkGrWLJRgv2H/x0J
	PXQjPFMUql8Qamk9NxrpzIIUsI6GR86iw1E4adXy1N6I0sE09uYvRH+KR9xx2Bpo
	aY3StCefQPa9YiyCg8irfrUUpxBR+T1P8ClOP+bY8daEfNkMbCMeASGEQ632cWQ0
	Q8E6Yiq4gKOOIzgo73FWnJV22dFtj4BaNWUJzhXGKox3EZbDC27vbFShzqLWu4Ra
	3CumnWx+mQxsu5xFsNMg3A4TjbSVG9yHwmQ==
X-ME-Sender: <xms:QlR2aVHXQuffGM7UFtBYURFyYbe4pA-Ju7TSr6qVHMtt1CZZ3vthgg>
    <xme:QlR2aRNawVya-wohWaLWZ-tgvASg592M9l5gu0vlvawGAQCsKBsq8yxqzrlxhLomf
    L0mKHb8S0IIpdxu2zuoVZfVNWrc8HEn3e_SIZLdszhTD8KFz0LOi2k>
X-ME-Received: <xmr:QlR2aff-1ltuF433yvHdiZZpPV5o-tf6ieruEHvp90D-mUh9PRQ0dUnlEHfDs7C1Lv-_uI0-Y32fxKKbTpVa9CCmM9d0pvgb-Artc88>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduheehgeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilh
    drtghomhdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomhdp
    rhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohephi
    gthhhinhdrghhithesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehp
    ohgsohigrdgtohhm
X-ME-Proxy: <xmx:QlR2aWuj8QYQUhI6F7VrYiDESGT5nTKWpvinpkxGIJu5WqLdDbFHHg>
    <xmx:QlR2aYlzbrMOqFmUY7-gqNzUPEVTz0m6jXna3nWaqqPPDNNU-CyZZw>
    <xmx:QlR2aQyhHPbUaS26-HpIyUWA_DQiTA8WEb4xQRjvsAQa6ny8ocKDnA>
    <xmx:QlR2aSOiKrgJmVskXIcF4EZZLKaF9mciNI_ixdIXuI3RsovFeJFpsA>
    <xmx:QlR2aV9Z64YO_GOYji15S4D_OnGOiBlaK6fxNGeMI4XeBdF0sAr4bA9A>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 25 Jan 2026 12:34:58 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Yee Cheng Chin via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Yee Cheng Chin <ychin.git@gmail.com>
Subject: Re: [PATCH] xdiff: re-diff shifted change groups when using
 histogram algorithm
In-Reply-To: <4fa413ae-f2a4-4de2-a2fb-0b1db379750b@gmail.com> (Phillip Wood's
	message of "Sat, 24 Jan 2026 10:54:14 +0000")
References: <pull.2120.git.git.1765054287938.gitgitgadget@gmail.com>
	<xmqqikcusn8p.fsf@gitster.g>
	<4fa413ae-f2a4-4de2-a2fb-0b1db379750b@gmail.com>
Date: Sun, 25 Jan 2026 09:34:57 -0800
Message-ID: <xmqqy0llk33y.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

> On 21/01/2026 20:51, Junio C Hamano wrote:
>> "Yee Cheng Chin via GitGitGadget" <gitgitgadget@gmail.com> writes:
>> 
>>> @@ -915,6 +919,45 @@ int xdl_change_compact(xdfile_t *xdf, xdfile_t *xdfo, long flags) {
>>>   			}
>>>   		}
>>>   
>>> +		/*
>>> +		 * If this has a matching group from the other file, it could
>>> +		 * either be the original match from the diff algorithm, or
>>> +		 * arrived at by shifting and joining groups. When it's the
>>> +		 * latter, it's possible for the two newly joined sides to have
>>> +		 * matching lines. Re-diff the group to mark these matching
>>> +		 * lines as unchanged and remove from the diff output.

Also, after reading the first paragraph of the big comment again, it
makes me wonder if it is saying the same thing as "When histogram is
being used, we shouldn't bother shifting up and down to join groups,
as the result will always worse than the fallback", but is it that
bad?

>>> +		if (end_matching_other != -1 &&
>>> +				XDF_DIFF_ALG(flags) == XDF_HISTOGRAM_DIFF &&
>>> +				(g.start != g_orig.start ||
>>> +				 g.end != g_orig.end ||
>>> +				 go.start != go_orig.start ||
>>> +				 go.end != go_orig.end)) {
>> 
>> So the idea is to remember the original values in g and go (the
>> location of the group in the file and the other file) and if
>> shifting up and down changed any one of the four ends from the
>> original locations, we always take the fall-back route (if we are
>> doing histogram)?
>
> I'm a bit confused why we need to check both groups. I think they're 
> supposed to move together (if we move "g" by n context lines we also 
> move "go" by n context lines) so I can't see how we can have
>
> 	g.start == g_orig.start && g.end == g_orig.end
>
> when
>
> 	go.start != go.orig.start || go.end != go_orig.end

Interesting.

>> By the way, this appears after the if/else if/ cascade that has:
>> 
>> 	if (g.end == earliest_end) {
>> 		... do nothing case (case #1)
>> 	} else if (end_matching_other != -1) {
>> 		... do the slide-up thing (case #2)
>> 	} else if (flags & XDF_INDENT_HEIRISTIC) {
>> 		... do the indent heuristic thing (case #3)
>> 	}
>> 
>> Am I reading the code correctly that, even though this new block
>> appears as if it is a post-clean-up phase that is independent from
>> which one of the three choices are taken in the previous if/elseif
>> cascade, it only is relevant to the second case?  I am wondering if
>> it would make it easier to follow if the new code were made into a
>> small helper function that is called from the (case #2) arm of the
>> existing if/else if cascade.
>
> That's a good point
>
>>> +			xpparam_t xpp;
>>> +			xdfenv_t xe;
>>> +
>>> +			memset(&xpp, 0, sizeof(xpp));
>>> +			xpp.flags = flags & ~XDF_DIFF_ALGORITHM_MASK;
>>> +
>>> +			memcpy(&xe.xdf1, xdf, sizeof(xdfile_t));
>>> +			memcpy(&xe.xdf2, xdfo, sizeof(xdfile_t));
>
> These would be safer as "xe.xdf1 = *xdf" so we don't have to worry about 
> getting the size correct (sizeof(*xdf) would also be safer but there is 
> no need for memcpy() here).

Very good readability enhancement suggestion.

Thanks.
