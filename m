Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D5AA46D2A9
	for <git@vger.kernel.org>; Fri, 28 Aug 2026 13:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787924925; cv=none; b=Z7Z8H0lBA95yJ2Z41oc100mWsD2u1ItFcUCoixLtVtT+p5p6qb6awhehFvCzRqGccVwMFJ5FMC2DQyhuwBE3X7F/E8a4rM+0LMtv5uNspc88/xPtgOQfgQh3x6nXBrDiw1PUV3kbX9HQQse0tevMV+BLGoy2iWUALqdR6KEimrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787924925; c=relaxed/simple;
	bh=QZSpN0/hpbZo22nJ2fGZ5mrpLYWVBeEYUWYGyRP/zMk=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=fIe5w15ueBe+eYM46wM2EJI5v3zKYm6iMRToAsWzTYQeZ5Bm/OOVMNlEKR4dLsqiEp+K/spHCxHhRPC31hZ1sVQm4b8EDHWGXkKLg3Fx6FC4HnYCU4qQgfzDeTbpcGDRIRmxNxkEnmIAHbteVdLoJ6fCWYXTxBLbAOWhzlum1To=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=S0/iDy6Z; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ko95es4s; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="S0/iDy6Z";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ko95es4s"
Received: from ams-compute-01.internal (ams-compute-01.internal [10.64.2.61])
	by mailfout.stl.internal (Postfix) with ESMTP id 685431D00158;
	Fri, 28 Aug 2026 09:48:37 -0400 (EDT)
Received: from ams-imap-15 ([10.64.2.35])
  by ams-compute-01.internal (MEProxy); Fri, 28 Aug 2026 09:48:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1787924916;
	 x=1788011316; bh=DOnRN3a7xqGo0yPhaWCywJNrLi+3rzG+YqYIefTbXeo=; b=
	S0/iDy6ZqZZmt7zEtuJtsTm1jYfpY5tV1XIJYL5oHGsBst11SLLrpWBe2EJfk1eH
	uoqeBIJI3kEDTScfUTNq+bSkTirM5tpO0mYULCJ20k2s49QyEHtUBEnEX1cUiKmM
	GMgHBOcMwMeSNIEN8VE3bGKtn+qwgBZMTNNm59j30haTLgWj72TRgb5RAcwX2NhI
	DoQWrTx38e5vS8FlU34ivxY90DEvRT3xHE2587IsKYsVJPzuGoLF6fFysWOUPMCb
	u2V8w2M+QIG8T36ZAw6XiQIprNAHcwR0hMdYatTbLwhBc4scctwwuWcye5XGhSGE
	om1aagwGN/cVB3Lhl8ksvQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1787924916; x=
	1788011316; bh=DOnRN3a7xqGo0yPhaWCywJNrLi+3rzG+YqYIefTbXeo=; b=k
	o95es4s6EE+9CDPCt31KE6dbDnWCFP2uPpZAUryg3PTxvS0j+Igc81KP2ER3OxSB
	SBTvR+0irEJZokry3h9FOCfRs5rQyRJmU0e7mv5A4W/fNUEwn4+KJOHvHW3fJulk
	1ktFqEOXOsrC9fjvttHhb8d6CVxhmVoS43PQ0wM6MsEZkHXNZonF/TY+2A4rI6m2
	fMogqHV1Z5CBiH9BXpZBOZc04NsDX50jaGBDV4MYRYR4y/2l/hhSsPe2mTYxlCZ9
	Gb7LXeriw9hOhcET4NbuOGofgRJL0ChzCqt1bodvGAGlYOLK7x+qrUEtx4yVAt6W
	QQVj42biFjJB/Z43bvdCA==
X-ME-Sender: <xms:spGRao7ejqIlktwtL-8-WKLcKBQHwxuc6uctcgy6Pffjykp6Fmx6KkY>
    <xme:spGRaksqP73lqfKWthBB8ClZGEROxXdKX2z-vEzwWh5Zygx19KESBJvygYd0x-zp_
    PmpApgopP-zed5mm2r_mK1_SfC7x8U1lIF87zxhs7LjGrRVTw4U9A>
X-ME-Proxy-Cause: dmFkZTFCUB29YWK08Cp5/dJF/sMSdk5I2YruOZmEe+joUhitlh9BfOaH8FaDJpS+5gyYZR
    t7Dihw/9xOUUrLVzOC6ZtKo7WOhw2CFJ5YQV1/1vf1EldX6YYwJyIvh0Gp4Uzqfnwsca/a
    aQpJoMaLajmnAHhhG9MNh1Mga3qkSrO3CNRcaE9a3Mmxvga1YNILit8KB0NF69Fdzu4GZc
    qpBvO81J7ksyp4qoPAvfC3L058nBwjG/GomfM6dd7ZIuxhgeQKmNf6FN5hvukBAkeaEuvY
    rfJ5A35pP6HnI3k8dTg4KRs0TQAL+Al1S7lp34xmuIs7UHlmegnVAk90yqu8hU6kjAl/E4
    ZhGroT8fEbh2Fup8IAQiKV3xLJs70FlvbZ6drTz3O14Hi2H8sm5NhWXfV7aB5OnxRr183j
    l2s0RNfXh28btk5mgSjJS0gU8CsDBZOlYfbNIQWZOYoXkwXnS0WW/sAw26BAPvkkluTZcQ
    /rsRTPFbp9yUXp+A+dMg2GAZNVMuyJpWmqspGuaxspxDIma+/MZpeVnJ46PVbY2TBH1dGO
    DTgCxvy7bfdmvMzoOtctFrZFaYuOeo1pZ93TpbonJ+N+IMpl13U5pN31AyMRsBlt+27PJh
    2RxYJEyRRWm791zx4K8DiDJcI3hNr71A5xAbZLPzYnIz/5WwO8wlI6NH7QsQ
X-ME-Proxy: <xmx:s5GRajkFpnfUsLaqBK4XldWkCBgzYFe_nkstgbZX52tMtEpKAG8ZCw>
    <xmx:s5GRaky4x4AgeaOt0PMye-AbLRELe0Arm8ZfsiVSplHHdiDIX7b4sg>
    <xmx:s5GRahM-dPzwfnG_ez7M7mekS7iLdgUrTtJ6y_NFjim__IvQwoPw9w>
    <xmx:s5GRaoRrXz66qR7YBHQQIg1oG3FtvcEcS4jwceUEu92eivI6gcF2zw>
    <xmx:tJGRajdUSP5Ev7PXCX65OqlJDwJhI_U-gcnZGhuRp_aD399NU_imGMTp>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id 259D522C007A; Fri, 28 Aug 2026 09:48:34 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 28 Aug 2026 15:48:13 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Junio C Hamano" <gitster@pobox.com>
Cc: git@vger.kernel.org
Message-Id: <9335a35f-e9c0-4e62-812c-e5855c201003@app.fastmail.com>
In-Reply-To: <xmqqbjan6q7l.fsf@gitster.g>
References: <CV_format-patch_learn_--range-diff-notes.c57@msgid.xyz>
 <format-patch_learn_--range-diff-notes.c5a@msgid.xyz>
 <xmqqjypfp2vl.fsf@gitster.g>
 <16315616-097a-4fe2-8665-010e424afd8b@app.fastmail.com>
 <xmqqbjan6q7l.fsf@gitster.g>
Subject: Re: [PATCH 3/3] format-patch: learn --[no-]range-diff-notes
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Fri, Aug 28, 2026, at 02:31, Junio C Hamano wrote:
> "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com> writes:
>
>>> Hmph, this is a bit too complex for me.  When I say
>>>
>>>     $ git format-patch --no-notes --range-diff-notes ...
>>>
>>> I would expect that individual patches would not get notes, but the
>>> range-diff will include them in the comparison.  But if
>>> --range-diff-notes just falls back to default (i.e., inherit what
>>> patches use), would I see the notes used in the range-diff?
>>
>> You will not get patch notes and not get
>> range diff notes. That --range-diff-notes
>> told it to use the patch notes which you
>> just turned off/emptied the list.
>>
>> Code-wise, the list of notes is cleared so you
>> you would have to change the --notes implementation
>> if you want to keep a sort of shadow list
>> of not-patch-notes-but-RD-notes.
>
> IOW, the design of how these options interact does not support the
> usecase I gave?

Correct as far as I understand the use case.

>
>> And another problem, or fact, is that format-patch
>> does not show notes by default. So what should
>> --RD-notes show? The default notes?
>
> I do not know.  My preference actually is not to introuce a new
> option whose interaction with the existing --notes option cannot be
> defined in simple terms.

Let's drop this topic then.

sent from mobile

