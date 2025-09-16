Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B76A2DE704
	for <git@vger.kernel.org>; Tue, 16 Sep 2025 06:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758005817; cv=none; b=KsBwgcjqT0a1KBFFawhqmGMN5zFIS8ewjDDmXGMYFwFCcadvWtUZEcRbruxzt9PNVM8gkAQW+oG6g3KXVqXmX90o10ErzdCgHJeGtLeJhB2qxzZuplVk6GWQ5Mu6Zxyh/rWVNAwQQAHqFOIE36+n9c30x1xjHmTl5OJVB8F7g/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758005817; c=relaxed/simple;
	bh=tRYS9CHELE76yX/nNlL3oyZeaYw5FoYLhUk4g/Qtnks=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=oEc//JIGyKQqdlCkU5paSceszWmLlWZ3D/5sSX4LxqoIG8goq4F6BsAgWkIN3ta3BINJmtLXLLs3IqUaTnUHLiDeMvm33+2WSHRpXUEQS7NSR1o6mjumxfgZO6NamWxwhgTyyGXzJIQzMt9pAk391oguOpOdTCbpZqRKLW0szgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=boeSRuyE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=L/TTy229; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="boeSRuyE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="L/TTy229"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id 625D71D0021F;
	Tue, 16 Sep 2025 02:56:54 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-09.internal (MEProxy); Tue, 16 Sep 2025 02:56:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1758005814;
	 x=1758092214; bh=3mW95nqHTvXx2xNgqkj5docRbeHEx2YM5g3ulHIL3zI=; b=
	boeSRuyER7b3DA3voQOnITAAI4ngCcX7e+lpmvUpS58Q+jLx4XG0JGx4HblLK+/r
	WOzmz/MFADOOcN4z2qovHJojS+GO/XKBsRV/l9SFdam4/6X1fCZiWbjHQcI8Kitw
	z56eMU1p6U1BMCj3F/wWVDecAQXoRiJChqHfnPqaml5ksefIZnVhYRjXOEsVT866
	Okpm8dFr4o8BbkzBu76ciFWGwEmfLoqPvxFIzqwFFV2jsbXqg9MUjIaOsoUCl8h/
	fOblbpoxc2v60kBbLtBpIjmkOmaLPHLh79QcjO6RkH2/bvcpMKCgh6oRYPdqQJMm
	uPE+xClc9CUtG7Qfmenfeg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1758005814; x=
	1758092214; bh=3mW95nqHTvXx2xNgqkj5docRbeHEx2YM5g3ulHIL3zI=; b=L
	/TTy229vwCLXz56Oe6rpfhJWkWO9CdNAdrca2AhYTxvCnwGzrRrS+eaneQngs75e
	Ds7LVMr5jDepyVjMoOjdKXa4ZLZlSz3p+3YRnRj2jNNUUCaJ5jd5toNZKLBzN3OE
	6UAMnIyMNX/40dSSyFMQ0fFUfOadznIPWshRQL1CyE+Df2864o3L4c9RHh5rBXt3
	m9r9eGRa+NPsoPHxz7W2QWuKieTYzYLQuHgQgksOcQSmawnw7yYqPpU4HGAutZaY
	MN0GgvPlVVTYCEjBAnQMoHLgdkBZso7Wck3idoyvhy/1/L9Hqg3xdeZt2AlwkTkr
	S9cE6Qi3T/h78YTOMyV5A==
X-ME-Sender: <xms:NgrJaJM-2BadtF3dAqGds4VeIUhG8nLGPczWkhTC6rj0qQkmPeQHQUE>
    <xme:NgrJaL_SxHPFi7GE2zAfcHk1iO4ekJ967Qagl-7oKrYALH0CaN_Qd3NIYqAUE6DH-
    HICKxdhQRMIklD-Ww>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdefleeltdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthejredtredttdenucfhrhhomhepfdfmrhhishht
    ohhffhgvrhcujfgruhhgshgsrghkkhdfuceokhhrihhsthhofhhfvghrhhgruhhgshgsrg
    hkkhesfhgrshhtmhgrihhlrdgtohhmqeenucggtffrrghtthgvrhhnpeegtdejieetgefh
    uedtuedttdeigfdvgeetkedtuedtudfgkeeluefgleetffejffenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkrhhishhtohhffhgvrhhhrghu
    ghhssggrkhhksehfrghsthhmrghilhdrtghomhdpnhgspghrtghpthhtohepgedpmhhoug
    gvpehsmhhtphhouhhtpdhrtghpthhtohepshiivgguvghrrdguvghvsehgmhgrihhlrdgt
    ohhmpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehgihhtshhtvghrse
    hpohgsohigrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhr
    gh
X-ME-Proxy: <xmx:NgrJaEXl8LPB66lvrgdM-paxnBIoDFmCjcpICWNF4_pH0ixpPdl0CQ>
    <xmx:NgrJaCDSauqCP36VMH3ASEBvDopxkE6kHBvLZYh7k6a6be4WiJf0fw>
    <xmx:NgrJaH-FWoySFIbLP6Ut2YFXK3Mw6PCMUNgpnIT0oCNsWcjFKgeK7w>
    <xmx:NgrJaJEEetFiJsMbkpsLPP6Dl8tqnlQrk43bINitdFGkyCKVcjkBwQ>
    <xmx:NgrJaHii-6IMM4fsYPgKBwimqFE9XVMEB3U5p8Q-XWkISKGTA3aYEfqC>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 0311D1EA0068; Tue, 16 Sep 2025 02:56:53 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A7Q1VxplDoy7
Date: Tue, 16 Sep 2025 08:56:32 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Junio C Hamano" <gitster@pobox.com>, "Patrick Steinhardt" <ps@pks.im>
Cc: git@vger.kernel.org, =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Message-Id: <a8702bc6-154a-439c-b4c2-0de208838775@app.fastmail.com>
In-Reply-To: <xmqqikhjhbgo.fsf@gitster.g>
References: <20250915-pks-config-color-v2-0-e4290bd8d13c@pks.im>
 <20250915-pks-config-color-v2-5-e4290bd8d13c@pks.im>
 <xmqqikhjhbgo.fsf@gitster.g>
Subject: Re: [PATCH v2 5/5] builtin/config: do not spawn pager when printing color
 codes
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Mon, Sep 15, 2025, at 19:28, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
>[snip]
>> Fix this by disabling the pager in case the user is asking us to print
>> color sequences.
>
> I am of two minds.  Part of me obviously agrees that it is more
> straight forward with this change.  But it may 

Did you drop something here or is it covered by the next paragraph?

>
> An interactive user experimenting while writing their own script
> might say something like
>
>  $ git config --type=color --default="reverse red" n.n
>
>[snip]
