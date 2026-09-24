Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 450EC40D582
	for <git@vger.kernel.org>; Thu, 24 Sep 2026 03:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790222192; cv=none; b=cO5aYdzF7ZXK7rVrXZQl93qs9HBCiatXzLMwvYGI5E2lh0xNQwJXp7AiCa3krfsLB/VAqWLXkIJM3KwU5H05eOm6hqTTCjN9HuR2z0rXY5VmFhVh2WuEyJX9efMKcpwSf59peShjIhE5BmdRja1bJf+ZgNmyyXX+U999gQbWpMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790222192; c=relaxed/simple;
	bh=BDYpQN2EvJy12AqgBNsr1XZezT51thIbCA6g1pKZDmE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lMCiB9T90LnQ2WFHbUDoqGUvQsXfmr8i5eUrI7kCkaPlpBZpJlA4jBrj7T48axndlJwRT9qu7AI8bNBuKa9jPfF6FNCW7dUb541fJdAbWgc3AVy1bHFNmBA1miim7oF0ZXFoAAWMCkgetpXpvD1wEBdfK1ob5G06uAZUWcy916E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=DPDOTxNP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=pLIG0C9+; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="DPDOTxNP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pLIG0C9+"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 4F67B1400053;
	Wed, 23 Sep 2026 23:56:29 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-12.internal (MEProxy); Wed, 23 Sep 2026 23:56:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1790222189; x=1790308589; bh=cy4d22UYm6
	v3XX9w6mEsBhPthiUInt3nlWb9Naa7FfM=; b=DPDOTxNPcBDanbLhhtSPu76t/W
	I5pDFlAjFzmPojJqGYu7d5VmvYW+ZmCmBIGHLV9XhVx7/muHMYpBUqs9gCR8PRxg
	J0hr2tTLsFGI208OIKWYLxD9N35ILg288FS5g0oxm9xu+RAIf1r8Q38ngqezuO/J
	dlh/3ZQ59ZRG6IK8jiplW3QxfpMtdKx1wp+9tfzWMImwQN2CdzbNkK31RE2fVbdm
	zdkpD/MEsfCoH7EBlbrJND2c1fd7N/a2v793Z/ThSyK999nauTm2HTVcbqJiaTIV
	QwGB/+JMb/ZF+oJ5ZK2GbxwgX0xTJtrIKWLlBVzsoBtMYdp/2bSUTQGxvLBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790222189; x=1790308589; bh=cy4d22UYm6v3XX9w6mEsBhPthiUInt3nlWb
	9Naa7FfM=; b=pLIG0C9+TCIBzVXUQhovjXv+Nl889zuOOnNWWaySmAa8ZjLZTzE
	pp9f70j51TqW1+IBeKdoj9oOsICKIQQ7+zJMl6+umP+L63IN5umIKx17zLtspgtd
	9vb+/wvrkjKCUzNOyZW+xhUnQBHaDs0ZgyWfz1+aACLtZeESjG5AA3xNYOgcN3Z+
	P6JP4fCXns+yx7RhFPPVv1Y38O1ZG3kYvHBtuHG4BNW3QWCJIx3/83vq18nXSOuz
	9oD69zpMhIoh37WpSCHsuWNRklX7mh/cAhOOT/CZK8ZilMmwDJfYah0X10VQv0I4
	aHTUzf1fF2htjKdTOVd3yLaVOSOLaNME5yA==
X-ME-Sender: <xms:bZ-0arbLXoLQe5B9YrD1mK13QnnCV4m9HHOQzRWAm2SC73fETTiWNw>
    <xme:bZ-0atpIqIFkkdNyYygQwORLaLzMoTGoCsNtvhNW9XDwNldV9ACuLtdUDAey4dmVb
    Eh4wbWfHPCChLkeykua9X29NBAhRyAGZzthJ1z2kfKtctsiuojCeJU>
X-ME-Received: <xmr:bZ-0anZk3YPye7yDqpi1tlOM4ipDcoNriIkJev0qNQlBAagZavdfFdbM_Rin9OE8Hqpbg8pOGm5Mw7kFm6bkdY_ifyJAqrMTJKNP>
X-ME-Proxy-Cause: dmFkZTFneGFuzgvHLu+WxGE0f/+lPO64LBGuUBDC1ZTZiM5AJ+Ifr+6cXF6kO88fF6vaWw
    YS3JaQ98K3/Y6izXNRcHen/NnndmWBn/gcC54awJBDRaccItbh9HL/QDXSrgLQBAxfe7DS
    hAjuAAsmhG7aI4HhUtixLwwm64eK30s2HPPuFr3nzlQZCoQxkhOAhh1Kq9Uloz7V6D78Qk
    mNbNZsvx1AlpsNgUnQeP1qOSltai2eqMQHjUvMQr9geHKgtLuofIP0eZRMuzA/mHR1t+fW
    LoRBWnzIs7iDuSKBO0T7OSMgYtfst8xGMX+btKAABdsBKIPPCFQbGJrELkUgpsN+jw5EXc
    PAi1St7AHkPpd+wA05rGWEHxqZKcCee6IMDVPkIEetFb1SzVHicIZsfaLVnFKKsUaBtmEj
    gA8NNIcZ+CFvMuKiabA6c1abY4gwBPGMTERhAJHinxbRnViIhE16XzDac03eX+k/9WIocf
    6qX9u0qdtpmQ8UJ5YucYfXRBdGSgMt8JOYhx1Nd3edJb//y3bMHCz/pnGnu8G5lK37ayw4
    vGCSncVggi6RdIumgEdjwlVCKAUPx1va2p/10deB8DaaEhxR8UHQvQdcZ7qLtx3AcrRVPd
    QRFfLBPIjRxYGdGAoOBlBHypM92NzmnXa2HEot7/VMXIxBw4b0omWPSZPvXg
X-ME-Proxy: <xmx:bZ-0atRFr2hHWI-bVCiUktrRYaFtfWpTbkSSOAEb4ymN665Bt1Betw>
    <xmx:bZ-0am60Xk0jR95f-T4S9bH0VAoabofr_wOycYXBVupWm7ap7ZEx-w>
    <xmx:bZ-0aqywqC5Ivjg7v6nLEyBVZdojVCXKy35VZQDue_8jx6OdB9Tl_A>
    <xmx:bZ-0atSBTNZOrC_Zlfw3s_us-biInh13a-0u4pHLhKJW7PdXcZ7GAQ>
    <xmx:bZ-0ahauQd4MdqognKYWOnTzbh6Pn8c1ZOm0NfXFXUtZIJWrn1FIua5K>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 23 Sep 2026 23:56:28 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc: git@vger.kernel.org
Subject: Re: Git v3.0 timeline, was Re: What's cooking in git.git (Sep 2026,
 #08)
In-Reply-To: <5f34a5a9-9f72-b725-666a-94798895d122@gmx.de> (Johannes
	Schindelin's message of "Tue, 22 Sep 2026 19:06:55 +0200 (CEST)")
References: <xmqqwlsei1pv.fsf@gitster.g>
	<76ac51df-cef8-c6a9-2610-8c21f03c6999@gmx.de>
	<xmqq4ifhgzvx.fsf@gitster.g>
	<5f34a5a9-9f72-b725-666a-94798895d122@gmx.de>
Date: Wed, 23 Sep 2026 20:56:27 -0700
Message-ID: <xmqq4iff5ml0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Fair enough: I did ask you to confirm my summit summary. Let me separate
> that from what I need for planning: a proposal from you as release
> maintainer can be discussed on the list on its own merits, without waiting
> for publication of the meeting record or claiming summit consensus.

As I wrote, after the current cycle ends at the end of this month, a
10-12 week cycle including the end-of-year slowness would mean the
next cycle 2.98 will end at the end of this year.  Expolation from
there, 2.99 will be March 2027.

The consensus in the room was that we want to use 2.99 as a signal
that something big is coming, so between 2.99 and 3.0 needs to be
some lead time for "advertisement".  This lead time between 2.99 and
3.0 does not have to be the usual 8-to-12-weeks full release cycle.

I do not think there was a firm agreement on the date for 2.99.1 and
3.0.  Potential factors mentioned in the room included that we may
want to match the LTS release schedule of major distros.  My
preference would be to give a month after 2.99 to apply only
accumulated bugfixes and nothing else and tag it as 2.99.1, which
means 2.99.1 would be April 2027.

The contents of 3.0 should be identical to 2.99.1 except for the
breaking changes are enabled in 3.0 while they are disabled in
2.99.1.  Volunteers can run 2.99.X series indefinitely to help LTS
distributions.

At the release engineering level, I am very tempted to keep the
WITH_BREAKING_CHANGES Makefile knob in 3.0 release in order to keep
the differences between 2.99.1 and 3.0 to absolute minimum, and then
remove the "dead code" that is used when WITH_BREAKING_CHANGES is
not enabled from 3.X at our leasure.

So the above is what I have in mind, shaped mostly around the
concensus at Contributor's summit (or at least how I understand what
the concensus was), with my preference filling in what was not
firmly decided in the room.

Good enough?
