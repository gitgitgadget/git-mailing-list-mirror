Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F33D3309F1D
	for <git@vger.kernel.org>; Tue,  5 May 2026 19:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778009251; cv=none; b=o29OleQxf4YHSgijoJBDQwvqrzHEQFpJtD4VndcDlTmdX5HYI8aDlOb3qpNnf8u40bHY4OkcspiWrlbu+cwjsJ0S2BDqmiPZktl63I0h01aNYDaQlV5ywEI6qI55lGvUxmCuMuFfRqZUxanEKI2JLUlZStVvBbuRnA35baq6cCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778009251; c=relaxed/simple;
	bh=jFpljZbmczikyHZtsxFdNJ+SUzEnRfT2gCEnDbw2HqU=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=ItvgMYhC41soAxTINGNbqc223vvCIgn3TtpjDH687qVVie71kU+4Vjss2W4kz4jr/7BBOtFZrdgsfw9xi7/RSiE0l/F2dYntK8dPynBCNLRxbdKGyZeCyVde3zLdEMrKtvQK0h9JCRpAotTOWxIbq3sZ2jt/fEXv/sDkwC4TAME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=KBBhwaHE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=H2z1H/We; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="KBBhwaHE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="H2z1H/We"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 471DE14000A4;
	Tue,  5 May 2026 15:27:29 -0400 (EDT)
Received: from phl-imap-14 ([10.202.2.87])
  by phl-compute-06.internal (MEProxy); Tue, 05 May 2026 15:27:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1778009249;
	 x=1778095649; bh=jFpljZbmczikyHZtsxFdNJ+SUzEnRfT2gCEnDbw2HqU=; b=
	KBBhwaHEiMU9cgXkdv5GQuwzeTSQZEtKbSBsjLkwRI7MV0uHGQ36JcxlGkRafnvO
	TMMYFHdIb5bSRK/WJdqo0aZ35gX8IebM/WeOa29wOMGB6g6Ba0LpX+z4+2OeXnA4
	m0lFfrQetb43pc3R+zyuJqCvsFaHrzUj/nbwwpyExwXxRfaKrsabe3b5kGNi1oCK
	Yc7di8h+wxmItjjsHZULSEzX483bsWF2eNIQU0pHrBrTQ3uOqcu22L7S4qxVpNR1
	j1mzzKaXi5XUjdKYS9EXCp2cA6wT716uQNAUj5euUrSnQlA1dXFvrcWrvcWnGfhV
	HaFIV1C0oLeQJZneCtgF5Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1778009249; x=
	1778095649; bh=jFpljZbmczikyHZtsxFdNJ+SUzEnRfT2gCEnDbw2HqU=; b=H
	2z1H/WeYkPeGMD7+X9LHKPQ6P68dzJ7mdCtEmoCKKQIAZbkYpjxeUBmTsZmFepUs
	vX83Nkkju3l7jnHWcDVH63ctqGcmpRsAPUGtI8l8vxPqZN1FscqIZVdlb4Pp+bU7
	mx80dXz8SlO9FaDkaDdSbrVv3P86SUJ1GdM3RAPDgb3+Ad5ObdIrzORL3wkPNVzv
	ejV6rHa5kZwDUD2YYRtBz5N0BOvGmOy9O05m/Iaa17tbD+ibQA5Kkcwx00zKkshe
	ACC2IUQLXsQPNi9QQ0ohsj/i8Rj0AYTpjVrPwz5xlZPFBF6QfYB95g41UUDgGplN
	aLXFXzpTMdGTpFBnpbv4w==
X-ME-Sender: <xms:oUT6aRvn_-2CZxWm_sxi8eIzC5BG95D3SHsr25g2aNpKvg6gTAY3GCM>
    <xme:oUT6aVR8CpL_hyrJfyTDzXC2UK0q0RVru9C-RUh6ZYWgsDhpdYoNYnIkEu1xoLjgq
    EiwVQhMpbCyscYlI2FOSX4g__LnQiodg4agU4Bf3QwHXXMnGxA9BOM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddutddvheehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedfmfhrihhs
    thhofhhfvghrucfjrghughhssggrkhhkfdcuoehkrhhishhtohhffhgvrhhhrghughhssg
    grkhhksehfrghsthhmrghilhdrtghomheqnecuggftrfgrthhtvghrnheptdeigfegjeeg
    jefhheeuvdegjeekleeguddukeeljeektdevjefgiefgfeekudfgnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhrihhsthhofhhfvghrhhgr
    uhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtthhopeefpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopegsvghnrdhknhhosghlvgesghhmrghilhdr
    tghomhdprhgtphhtthhopehphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:oUT6aVrqQ7MSp0gNJ3xiiB77FziQfzlsReJAwZ4pcLITaWu0ww-KWw>
    <xmx:oUT6afYnOliv7p70Imf1MbN6QBCW9DzwKxW14N63v2lhFczWdHT4kQ>
    <xmx:oUT6aVSD02Wiv6sCXKLy4qSoK77rBRfXSzOuW3v7EVfPkTxp22XOkA>
    <xmx:oUT6ae7jDVcYCHoqZMtibs4gyPIe7UIMJmMXAx1ax1yRVRrtVOkcIg>
    <xmx:oUT6aaq_gF9w5f7P1yVN1JYv0h8gJcHifT1RuK_HKBNvUqMEVCBwD8cT>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 26D09C4006E; Tue,  5 May 2026 15:27:29 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Aq0cXLUbXG1o
Date: Tue, 05 May 2026 21:27:07 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Phillip Wood" <phillip.wood123@gmail.com>
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>, git@vger.kernel.org
Message-Id: <ae72e273-c6b0-4946-aedc-84b2e30aca87@app.fastmail.com>
In-Reply-To: <0f57e309-62a0-438e-a1d8-7c367379ef01@gmail.com>
References: <e8bb57a2-8eff-4f72-96ca-72d8880901e0@gmail.com>
 <20260501182718.27853-2-kristofferhaugsbakk@fastmail.com>
 <0f57e309-62a0-438e-a1d8-7c367379ef01@gmail.com>
Subject: Re: [PATCH v3 5/5] format-rev: introduce builtin for on-demand pretty
 formatting
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Sat, May 2, 2026, at 12:00, Phillip Wood wrote:
>>>[snip]
>>> We'll also need to be
>>> careful about flushing the output at the end of a processed message.
>>
>> I don=E2=80=99t get why this takes special care. I=E2=80=99ll think a=
bout it.
>
> Because the output from printf() is buffered, unless you explicitly
> flush it you can get into a state where git thinks it has printed the
> output and is waiting for the caller to write more input, but the call=
er
> is still waiting to read git's output and so they are deadlocked.
> Calling maybe_flush_or_die() is the usual way to handle this I think -
> see 344a107b55 (merge-tree --stdin: flush stdout to avoid deadlock,
> 2025-02-18)

Ah, I understand now. Very well explained. Thanks :)

>>> For "--stdin-mode=3Drevs" the caller cannot know how many lines the =
output
>>> will span because formats like %(trailers) will produce a variable
>>> number of lines depending on which trailers are present. It is also
>>> possible for a rev name to span more than one line. The following
>>> example finds the most recent commit that mentions 'cherry-pick' in =
the
>>> subject line
>>>
>>> :/^[^
>>> ]cherry-pick
>>>
>>> so we need a way to delimit the input and output records there as we=
ll.
>>
>> Okay, so a null-terminator mode for input as well?
>
> Yes I think "-z" should mean NUL terminated input and output.

I will use `-z` (and `--null`) to mean NUL terminated input and output
based on your recommendation and because I see that it is the approach
used in other commands that I have found that have NUL termination for
both stdin and stdout.

I also want to supply `--null-input` and `--null-output` since I think
`--null-output` will be more generally useful.

***

That these long options ended up being called `--null` instead of
`--nul` by convention is maybe just a historical accident? Considering
one writes NUL byte/character.

>[snip]
