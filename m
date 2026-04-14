Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAE5F3E6DF9
	for <git@vger.kernel.org>; Tue, 14 Apr 2026 14:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776176082; cv=none; b=mWdp2JB1RQsRkfGmf9x2Tw4LBcazWw19JZFtXOHJx7/j2HEpHo/3N1oHqIFcG6Kk1Cj/1sNkVrWrQCU3sV1KcoGH04mttR9/b7a3Sn5qHsftGJhWnLYXHHtGA9UPLQMqOy1ZoScv55dpazNx9ynajLaeMSkep4yaxlL7s6yGwCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776176082; c=relaxed/simple;
	bh=V0Jt/lb9Mgt5kuV3p5jlpFz7E9Ghuc4YgC84+YxUClY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Prwq3GyJskJeLnv7/f0DI5+IPiaqodgPOdRAjtANea4Wyzac+ijLlPjos0B10o9DaN5pMKm5bYwCULwakVCIG0uaXghCvmULIFy9C/Zd3SrGuyRhsIZqLsZQAUN80T+wo4eHx95PsVZutVI8NRBhaeTyi7g3o39gN1/452WsQG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=WwdUaOVe; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ni92w4n8; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="WwdUaOVe";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ni92w4n8"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id B2DA47A01FD;
	Tue, 14 Apr 2026 10:14:40 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Tue, 14 Apr 2026 10:14:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1776176080; x=1776262480; bh=8bf6oM12rf
	kkHn1Krl3zjBclfYtazrqq8ukKGbyz1vc=; b=WwdUaOVeYBOnzRQWx1ODpWqNz+
	8anpLg3d4sQ1B8fH4+DQdCEAsbD/lHMKrAMbz0IE6AGlan57uq+MzoIOYy6nZ7Ow
	IqUAAmA3OxqIoIlFxzle2KkOi1eXknImOghS+gcMDjgdkOH959NXX4WsrR3EUoWC
	s1dR5CnIPw7XBzMxkP/qnfFDHq8e1NpunpfP7ZXUSZK0xOmFpyLCNZkK3kdaH1zX
	VDL/nHcJtP28apXfRpWfU2FWX3ufSjqWwpXevJMhdjEmj1Q6DJFy+uB3jGIlAotx
	K0HqTpdI52SN7IcuRsgdBaVh454ly2/nDQKKjNG2nqFP9NBQlsWoVYXe43Ew==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1776176080; x=1776262480; bh=8bf6oM12rfkkHn1Krl3zjBclfYtazrqq8uk
	KGbyz1vc=; b=Ni92w4n8DFzn9HbZfWChuqLCPp14FjgcGrs6g2bLMDxPyIfROc5
	PDMUE2sgHPIBYmKEUrVer9OoocJwEwWwZJ5JXQxUFabhY7dqUfpkoL77h+hcKPZn
	6GZmk/Bnm51f6lfutX326+ugvXDDpmNcyQ94fwTeF6Nhe6A6LYqqdJX9FjzICGBJ
	J1VzY7K8/2JFo14hZdidyh+WRPAXuU31/naGLhGE9fMVHxYDQ6tfXfzngy2IVzgo
	IWBrsyfzlFX8mPt0PyadKfeYbqc2GPaedPBVRNBEXQ2vQ7qnxgt2csJJO1H9fi2t
	vtM6Uti4gyKwERFrWL5Z8wLfqnFbZjftLaA==
X-ME-Sender: <xms:0EveabGMzXFRbFwDlyF8HRjHHwety9GBOd1cmP9FSqun7giC842ZEw>
    <xme:0Eveaanx5VBpzWvYrwjkl5-lXgPwW_62YFNQWF2Y1RXjj6VTSsh2hJwP7FHMluyMu
    GdsMhEMooQXaA6bJaH7RxEhLJVpEntDrZvJ6xdnhM2Xbkb0qrx9yQ>
X-ME-Received: <xmr:0EveafaWFUpXI_Nf04bMfirNaoYEz4UgD-G8afW-QtuJE9r6rQLPNq_tp4U4QBSBATBxMLN3qjvb8YtEQyyyuMlE4PVYK__sLw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdegudefiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeejpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehhrghrrghlughnohhrughgrhgvnhesghhmrghilhdrtg
    homhdprhgtphhtthhopegthhhrihhsrdhtohhrvghksehgmhgrihhlrdgtohhmpdhrtghp
    thhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtgh
    hithhgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehpvghffhesphgvfhhf
    rdhnvghtpdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilhdrtg
    homhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:0EveafG4Sf7UZ_aLhdeLp7YdZKC_5af3Th0h6Uv_9tqtMOgJqzjJrA>
    <xmx:0EveaQIZbUUdseFi-Wk95edyHGAkO4nHoWGiyDSr6iab2_KO68u4tg>
    <xmx:0EveaaPRELBjdgWvY60vQCd1aerM02KeRoTidij0DSEITIiAvHkVaQ>
    <xmx:0EveaQkQoCO0hyZC5Mp7j81_8DpHtACC5bIUbbmmPpvM5L6KK4Tyvg>
    <xmx:0EveaToHgTgkuFQhnJK8IC_yiYNNVf4Z2PTXOZDxtH9YaktiLFFJRLsG>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 14 Apr 2026 10:14:39 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Harald Nordgren <haraldnordgren@gmail.com>
Cc: chris.torek@gmail.com,  git@vger.kernel.org,  gitgitgadget@gmail.com,
  peff@peff.net,  phillip.wood123@gmail.com
Subject: Re: [PATCH] checkout: add --autostash option for branch switching
In-Reply-To: <xmqqmrz5eklt.fsf@gitster.g> (Junio C. Hamano's message of "Tue,
	14 Apr 2026 06:29:18 -0700")
References: <xmqqa4v6fpj6.fsf@gitster.g>
	<20260414072950.61240-1-haraldnordgren@gmail.com>
	<xmqqmrz5eklt.fsf@gitster.g>
Date: Tue, 14 Apr 2026 07:14:38 -0700
Message-ID: <xmqq7bq9eii9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> Harald Nordgren <haraldnordgren@gmail.com> writes:
>
>> Sounds reasonable, but wouldn't it make more sense to call it "autostash
>> from master". We should still be able to abort the merge and merge it to
>> some other branch. I feel like the source is more relevant than the
>> destination, no?
>
> The new comment is for reminder, so "I made this while switching
> from 'master' to this new 'topic'" theoretically has more reminding
> value than "I made this while switching to this new 'topic'".  As I
> outlined my workflow, I usually am on 'master' or 'next' when I end
> up needing "co -m" option, so "I was on 'master' when I stashed
> this" has a much weaker reminding value.  Just like a series of
> "autostash" without any context comment irritated me, I'll see many
> "autostash on master" that I cannot quite distinguish.
>
> But that may be just me.

In any case, the topic is already in 'next' and this kind of minor
tweaks are best done as a separate topic once the basic framework
that works reasonably well is established on top.  We may end up
wanting some mechanism to customize the message in the end but that
is something we will find out and become able to decide on the best
design only after we let users use it for a while.

Thanks.
