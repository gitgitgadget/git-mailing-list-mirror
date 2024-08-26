Received: from fhigh4-smtp.messagingengine.com (fhigh4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 179CC8C11
	for <git@vger.kernel.org>; Mon, 26 Aug 2024 05:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724650596; cv=none; b=brwrKUCufL5dinC49u+i4Iib2mPAecSvWb2EEcvNabzxK5It5S+HcdGPgNv3H6tmHwD2i6OzKv0nRZSlNOUFSSx8iQZGehliFaAPT7l93mrXJghhuWFfvP/kpN32YzjiUCJ8V8WzThdFL+vbTq27zdA2Ctpel93mIWDMRvuulH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724650596; c=relaxed/simple;
	bh=rYthTVMTRwUYysoaECVXneov72EgEDqk6v4LrGt/+UM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Al11oq5/HDADCbUsIquaqxZu48zbH1GudSMVGxpklBzx8rUouSUEqcimPRWtcUsG255CwFezrluj2mA0R9Hv2JRxttuv1T5rSvExEsbIQsj7YFvCuVdr6F9T0MMI3/Dm1KCoQIGlSC3hyxZLKZ9ez4LUoQMmQ9FpQZHmF+z4Lac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=s4wikZT2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fBMiTZ8g; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="s4wikZT2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fBMiTZ8g"
Received: from phl-compute-02.internal (phl-compute-02.nyi.internal [10.202.2.42])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id C7D191151B70;
	Mon, 26 Aug 2024 01:36:31 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Mon, 26 Aug 2024 01:36:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1724650591;
	 x=1724736991; bh=DqFzHqKdQY99WlRs8HWXhign1wAOQrac73iC1bccZ7Y=; b=
	s4wikZT2KC9Kp5UqGss8pZAot6a5zmoNmpbJK9Am9ytbJVWUHEl4wG0uLBvsioaU
	TtoP3eDGWbFx/1AF2lyqjZPmwUuvFVdKYjjDR/FWn1ruOjIHUcK97ISH57rA7Ylq
	x6GuXYfgPAbdxt9j6utc4SVk2Rj1IHi1ZSYFAaWnwNlIq0CUt7xphbbeMdhbYJ6o
	LZA6UBMOXlXkg5Ku7d3B7yZQilZXuzr1lBUFKhNMFAzPeEZLD4WJMWl7CDrUBPpz
	SU3lY/XESbluEWuQhEX5qZnIRXze1KwFvLwCWmo4yQdcef1UPqfyIUQdW/FrqycA
	SbSQACKJOHsuTA0pZIZrmw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1724650591; x=
	1724736991; bh=DqFzHqKdQY99WlRs8HWXhign1wAOQrac73iC1bccZ7Y=; b=f
	BMiTZ8gmytc3rSF9oFMDg6+YSuSMQRIGG8HKwNMiskMbOgJAlnCN3K5iacVfoudt
	uFRAbkheAgf5XRXLwmQq4d3XFaAPikGIURBtF2zt3qHoeiKvmS/76VQgQXMqPFmy
	QkyhRcn837MZ0a/34Z09Z4NwR3KaNePCNswSzr4r2DUPLS+3eV6pLM5nSyWAcFB8
	1lrmSMR8PkuC/7/tF+WbjGy6Qi0XZKB/v+BPvDgv/30Xv+ffekM0TxescwgLmGQY
	OUPRil84+cRm6LY4u09Itn6mFqU0DD63X9q/4k5MZBFQMg5I0N72vUp/x1FiwbKY
	7KiKibnFX0x1KyTD8sIdw==
X-ME-Sender: <xms:XxTMZie1Cdg6vm3T4ylZa74vYz8Xc6ZXESMVnyf5LiNPm4YgN0QEWA>
    <xme:XxTMZsNHzc5qIZkPUW5a1_lYgZPzREIb_9kkAYOjaGpfPEYKCZxTq-7bxARWNxsEQ
    rO33NBoq9YpeapCSw>
X-ME-Received: <xmr:XxTMZjgYBbXQmiqsb74u25RgRDzo5F3UXuKcNyocIRk1_yIVJiIQs0DS1lEb_EpnNi_avtRH-T9eqB7FfuX6E_QMLfE-OGeuasaKDOO-poAopvo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddvjedgleekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvve
    fukfhfgggtugfgjgesthekredttddtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghi
    nhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepvdefjeeitd
    etleehieetkeevfedtfedvheekvdevteffvdevveejjeelgeetvdfgnecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnh
    gspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithes
    vhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlrdhsrdhrseifvggsrdguvg
    dprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:XxTMZv8Lcc9OPcGm3lSa7Vh7m8CcGstLLmVgyFZbe_L1KM4BC7iCxg>
    <xmx:XxTMZuv5QFETwVHCKZKt7rOcdITVZFUveZE1Iu0JyNYxe04-VQI8nQ>
    <xmx:XxTMZmEnvqj-6PSG547-O2UDHQubknQxoX8TxT7-xDLDsFMPeHVjXQ>
    <xmx:XxTMZtN7YY4HAvCYmhq61NaFFousOABHAhI8zn9G1LgGOyDQUD5miw>
    <xmx:XxTMZiK4pbAe84PP3haltjATPFm1cDj2XDcIULH3TnXgDZMQ1Pf4CTF2>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 26 Aug 2024 01:36:30 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 6d4cea34 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 26 Aug 2024 05:36:26 +0000 (UTC)
Date: Mon, 26 Aug 2024 07:36:26 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	Git List <git@vger.kernel.org>
Subject: Re: [PATCH] remote: plug memory leaks at early returns
Message-ID: <ZswUWj_dg7-kM8b0@tanuki>
References: <82cb986c-6830-4d9a-bad1-fe4cab6a76eb@web.de>
 <xmqqseuvndsq.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqseuvndsq.fsf@gitster.g>

On Fri, Aug 23, 2024 at 02:13:09PM -0700, Junio C Hamano wrote:
> René Scharfe <l.s.r@web.de> writes:
> 
> > Signed-off-by: René Scharfe <l.s.r@web.de>
> > ---
> >  builtin/remote.c | 23 +++++++++++++++--------
> >  1 file changed, 15 insertions(+), 8 deletions(-)
> 
> Looks straight-forward.  Does this allow us to mark any test script
> as leak-free?  I understand that Patrick has another round of
> leakfixes topic that is not yet published, and I'd prefer to see us
> not step each other's toes.

No, this doesn't conflict with anything I have. And even if it did, I'd
be happy to drop some patches from my local series :)

The changes themselves also look good to me, thanks!

Patrick
