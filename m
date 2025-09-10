Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B671311C3A
	for <git@vger.kernel.org>; Wed, 10 Sep 2025 21:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757540550; cv=none; b=EEUPnAZT6oLO07jnYCyof0PxtaxN5TM4cgrpdWagdMSg65u8B+ZlsjYPnQJHUdKjVOA+D+XAcR8FJEUvPmexWs2XcWatbZXGn73ktUnIzJUQi82gxVWYL6NgzqqnGIiXnEDzAYgOLuwPHaws+EKiDS9C/06bnsD0cxiAUG4Sx+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757540550; c=relaxed/simple;
	bh=5FCVWlJxDyF8zFHDRbhBndsT9XjUrwBZJxUD7k7WBFM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=foTVOsZ+eYd9DeYXdD6dExV5TD86Su+CW3oIMt7ImZYaGFP97TOBYzW16hc0k+tDyFsYNYapAWtmGYzp/au5S476/puiGzpBNJNYtGTmYbfsOenQxFpKYJlT/H+g2gaZekPUniVP7aDdZLBxWWlshliNMEXMnl9p9k09xWhtKeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=jvWI8DwT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NsOEtfiv; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="jvWI8DwT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NsOEtfiv"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfout.phl.internal (Postfix) with ESMTP id 7A2B8EC028F;
	Wed, 10 Sep 2025 17:42:28 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-07.internal (MEProxy); Wed, 10 Sep 2025 17:42:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1757540548; x=1757626948; bh=ZgpdtVpeG6
	h+OHlQ+q0m4d/sZpgXiGPNcqIGfOlAaT0=; b=jvWI8DwT0hh74nrXfReqRMvC8C
	l4wAOEwyVLjF+rQCb2pPIFFQYaC8nFqmD9kwbydcCBFHn722JXI9IsGNS/AUvJCf
	3tG0wpPPNfgqE4Yaj4SrAwZbX31njHpkDetdKyzL4339R5Xmeld5WUk+Z2l+k9A+
	pSN0soko40S+y1bKC4q007Ly2Y8Sa7OCIp34iftwktWeckVREhZ7JZFg8sdzktGu
	5JMKe3GS2SLtnMvYJjW1C0Wi3M5d/ESXYS4ZC1aZXvezNu+XwD+7A0y1VRrie0EA
	lzVbFT4/sV20cqfN8F2At5T9nkJBRsScEsRBMwEihZwGc+7X2200UEnMPp7g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1757540548; x=1757626948; bh=ZgpdtVpeG6h+OHlQ+q0m4d/sZpgXiGPNcqI
	GfOlAaT0=; b=NsOEtfivmfeZK7f7e6ZLaHpyeQWar5RpPh+cICWTL7zY5U4/8/Q
	R1UjljaOTgukug2g8aQD8VfBP+1TRvuSObZx/hEEflJro/VawDzy/+aJRIWRGTV+
	wXLlAnvJjXY8MQKJP9Wo/2Ui0r3RPHiEX7wcelH35LLIxbhZLBVad+xS3XBwuKn/
	pmd/9QVyB3LcnuqXwEu/Gt7FjwRmIo+Y4/5tcpQa4CIkfKxMwaG/Jcx/YAtjtGUq
	9E5+fDc4Vgh3kMKWzzN/ZXtpRe4aCZyyK7CiDJ4eer0+JICNQ4iA3PinqKXPthLD
	RWrR2Sng7cThhExQZ+oiAl+vdmkWUihIkOA==
X-ME-Sender: <xms:xPDBaAbzWPUWaHu-kyrpDeB5W4aRtcjcKrZbTZ6TXk0tr-xpMCxCOw>
    <xme:xPDBaOrlPNMtpdp7RSqBn5NmsZw4Ig91opKD5T9XdrQFwghG_yAX7fAZxuDqBOM_m
    cINAJMFc6Ol2xZHWA>
X-ME-Received: <xmr:xPDBaEakAHBMjtwPbXJFfTqfTBPuoPNyxkUIZ9g3swnJdZebnitmF0hm3EIlEwaslEg1y61BktLRwDy9m2caTlVJSm0nkX3r2cWqqok>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvgeeflecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephffvvefujghffffkfgggtgesthdtredttd
    ertdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphho
    sghogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevff
    eufeejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspg
    hrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphgvfhhfsehp
    vghffhdrnhgvthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:xPDBaGRRxtJ--DEqGUe5nECSH7KZHrkDzWTMCJa0MfynDN-eSTFuSg>
    <xmx:xPDBaL4AUrY6_bPfRJS7r-iJWT4ctez8lBCvp7yv3kyUTY2w01aYvQ>
    <xmx:xPDBaLwOkC6EVh300HBeMNE730M13yyOPlgH-TqGZHbU-LpGTKAeFw>
    <xmx:xPDBaKTuEUHGzRGQ-pO7cjbFIk85d_tdnaTpriMFQg0FOKp54kk_lA>
    <xmx:xPDBaOuk18daQBwaX6eyHHxCoBrhZmd_5ckkdK5v3TkzwrHiUcCyIves>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 10 Sep 2025 17:42:27 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (Sep 2025, #03; Mon, 8)
In-Reply-To: <20250910155450.GA1135031@coredump.intra.peff.net> (Jeff King's
	message of "Wed, 10 Sep 2025 11:54:50 -0400")
References: <xmqqjz28v21e.fsf@gitster.g>
	<20250910155450.GA1135031@coredump.intra.peff.net>
Date: Wed, 10 Sep 2025 14:42:26 -0700
Message-ID: <xmqqv7lqougt.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> On Mon, Sep 08, 2025 at 06:37:49PM -0700, Junio C Hamano wrote:
>
>> * jk/curl-global-trace-components (2025-08-27) 1 commit
>>  - curl: add support for curl_global_trace() components
>> 
>>  Adjust to the way newer versions of cURL selectivel enables tracing
>>  options, so that our tests can continue to work.
>> 
>>  Will merge to 'next'?
>>  source: <20250827080702.GA3572995@coredump.intra.peff.net>
>
> It doesn't seem to have gotten a lot of interest. But we have to do
> _something_ if we want tests to keep passing with the new version of
> curl. The other obvious alternatives is to try to modify the tests so
> that we don't have to modify the code to support the extra debugging
> knob. But I suspect that debugging knob may come in handy at some point
> in the future, and is worth having.
>
> -Peff

Thanks for pinging.  I was hoping that other people, not you, to say
the above, but perhaps our developer population is too small for
that?

Let's merge it to 'next'.
