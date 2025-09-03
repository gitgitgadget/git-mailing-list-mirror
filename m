Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DCF814A9B
	for <git@vger.kernel.org>; Wed,  3 Sep 2025 06:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756879891; cv=none; b=LaEtIzKek/HHv7YBNNEZ+TFF7M5O0P4jEwDT93pemendUZb2JGxOEgp06d7nrAgaX4rZ8dWjgrThXvGItE8yVoRXGggdoibF14EEatC8qfykXPzMr6H9zL9nH6U4R7dN8xoano1sLVxt6TjeSFXk2deQlZ8weRmkRf2YCHjnskY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756879891; c=relaxed/simple;
	bh=5px9s9ALRnyWxfYqgu9Qe7Xg9BSK/qXvYd4fZFy01N0=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=mit9tmirnkO8uDeQ9qHl5ETTKquSTMdLIe+mC2CbZYFsLzcV7VCTL/gGdb8kiBFiTsowA8LHO+EegTNMnIhekIIPVYyVVgoSa7CNjE9Nqp7LElo+zUfqNqNaDw1Jp5jWVz/gChGwZxUBH9woHV+/V/wwhn+De4DpSL66FBwcZbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ml1.net; spf=pass smtp.mailfrom=ml1.net; dkim=pass (2048-bit key) header.d=ml1.net header.i=@ml1.net header.b=oo5JtmLP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YDkrSugd; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ml1.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ml1.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ml1.net header.i=@ml1.net header.b="oo5JtmLP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YDkrSugd"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 3E66D1400153;
	Wed,  3 Sep 2025 02:11:28 -0400 (EDT)
Received: from phl-imap-16 ([10.202.2.88])
  by phl-compute-02.internal (MEProxy); Wed, 03 Sep 2025 02:11:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ml1.net; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1756879888;
	 x=1756966288; bh=hI8RkcjsLWZWKGokct5LCkmYO/T7/IYmC65ntuX7dVE=; b=
	oo5JtmLPJLpayma4AXCPGooDQUkQ4HyvMEPn2bUZX9zdlWwcvm9FOQqSw+A3NCgf
	rgJslW0qi5SKrXWPOOdcu2ttPr5BgsyAA1gYVfMOb1tsVw1Kwv4YeUFF1mAuv6uV
	3DDcL6AlKDpTm6fGD0ah6YgUj9yPYgo7A6+QW+hr0+tKsjW+KwZ3LhKDDGd3fsx6
	BjDkY+V9OK6bO2tHFGsQxLcJ6tl4rucVIZXxPbpkd54JzsdrM3fpkZVI3YwWc/yr
	Od80u91phmHynTw08DLsTA5pUQ7FTUFBrwTdZOjGLHxyC+mJSIUvnmf9WjKQ52bT
	ymsfN7rONLv9thZibaTTDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1756879888; x=
	1756966288; bh=hI8RkcjsLWZWKGokct5LCkmYO/T7/IYmC65ntuX7dVE=; b=Y
	DkrSugdbmV+iK54UvhpurdvLenAtXNCWLyYpLiONLzHYxvxvl5Udxp9x3bjriV6v
	6ObJymcWptnKzbDYklFy2ZguH3bK16E5z1WL+QJGexXfFLNkZLvWdA7TUJxa9321
	KRFcZqREu9leIayA26BdSFO5DkvG/xxADC4mozCKhPE3QGACpo2kbYWOrJ0uw5Z+
	Slf1tPc/o+xIkBc2dp1wikAqxfuoAyiwOm8pAIMv43Vxo5KN1czch+czNVUWh2C1
	wUBsybMhgRMvpBs51YtAEryFNqaTgW6MmOQ4wZ+4DBD+3R/O8lQB6ATQSUgY0aaw
	bjxfLy+VlvJ7OBye1KOaA==
X-ME-Sender: <xms:ENy3aOTWZvOMKvFQZA3pnkYLTfegz2qL1vMgz5yPtM5tqaH8plcjCg>
    <xme:ENy3aDxzACLltwXOS2x2cKxlp0tjZkpi0ERvOgrLJoWWl8ZqoqLi-iszYFabo6_5T
    K86mDV-suQhR7lS>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvfeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucenucfjughrpefoggffhffvvefkjghfufgtgfesthejredtre
    dttdenucfhrhhomhepjhhorhhgsehmlhdurdhnvghtnecuggftrfgrthhtvghrnhephfdt
    ieffteekuddvffelffduleekteegffefueejteevieevleeftdettddvgfeinecuvehluh
    hsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepjhhorhhgsehmlhdu
    rdhnvghtpdhnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtth
    hopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepghhithesvhhgvghr
    rdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:ENy3aCW9hyXqPLkA8aIGi1YSQeXaZoHlXa3nKTwPOqaNMTXvWuPKAw>
    <xmx:ENy3aHhEnUzEcc-b6HWprndt1CwvAmJYfMoX09RsW90BfGRzGMVoEA>
    <xmx:ENy3aIXisbbYVg58c7Dm33NurwCd-2pAYsYGX9_RtkNcFJeMPpSiLQ>
    <xmx:ENy3aGOjcZ8snOSCtolBp-4tA17nKhf9XE-TSoUPwMRMsgkyJ3M5Rg>
    <xmx:ENy3aAFqutd9xXIErk44fjPgs9r879t7kysaeCZKqvRiLtm03qTHKeCN>
Feedback-ID: i470841e3:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 0CF8F2CC0083; Wed,  3 Sep 2025 02:11:28 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AaL8HUsuz1kN
Date: Wed, 03 Sep 2025 09:11:06 +0300
From: jorg@ml1.net
To: "Junio C Hamano" <gitster@pobox.com>
Cc: git@vger.kernel.org
Message-Id: <decdbc61-6273-4173-8044-31658f33e207@app.fastmail.com>
In-Reply-To: <xmqqa53cioh5.fsf@gitster.g>
References: <74c5f07d-6376-4787-a5e2-bb09abc58ce1@app.fastmail.com>
 <xmqqcy88lsw3.fsf@gitster.g>
 <6597b201-8087-462e-adc0-0ddaa8a7402e@app.fastmail.com>
 <xmqqa53cioh5.fsf@gitster.g>
Subject: Re: Still using "git whatchanged"
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, Sep 2, 2025, at 23:33, Junio C Hamano wrote:
> jorg@ml1.net writes:
>>
>> My point was merely that IMO "raw" is not the best name for that
>> option. When I specify "--raw" on the command line, I usually
>> expect the program to output similar data than without that
>> option, but of a less refined state or kind.
>
> Sorry, but you are 20 years too late for *that* party.  Once you
> invent a time machine and go back 20 years, you can advocate for
> different name(s) that may fit your personal preferences better
> there.
>
> But not here and not now.

See below:

>> I'm not sure if this is the right forum for this discussion, but if I were asked...

Given the circumstances, I vote for keeping "git whatchanged".

Regards,
J
