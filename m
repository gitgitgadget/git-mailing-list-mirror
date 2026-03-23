Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C57F73AE19E
	for <git@vger.kernel.org>; Mon, 23 Mar 2026 17:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774287308; cv=none; b=Ut0C7AbSbW8Z2bvZYUtwEH15BM0hd42Nf1MvjLRA0/o+Kolw0mS24Up0IsR9gvIAtQvb5h0hxGNflnYr5nA+Knfbw9YJTR48RFUZTtV1lRuLl4O21llwlA3ikkfoN6KO6AVePGU72Yy8TWkJNwxf8Xu/i18c1QnAipe6QUjm1Ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774287308; c=relaxed/simple;
	bh=lRff7xMUaNQXi3YDKIv+YU4K1/k4Rq3M7rV6rSoNGsA=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=JWLm6WeLsQg/IlTFmmXe7hnsyCDoSbWtildOd7z7SNMK2Zs7yGymKvAhQW2j/YJYE+ziziGw+BKxWouGkbdy8xBx86j+tO6TykaYBtKZtZ0ZE+53pAHnFrsSpvJwr0lJgGy+c+FOup0/8gErEg8hzJLpv+abBI6Jg+PcFN1iXas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=UqARFEZA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=xcgo3Kv3; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="UqARFEZA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="xcgo3Kv3"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 108E0140020E;
	Mon, 23 Mar 2026 13:35:06 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-06.internal (MEProxy); Mon, 23 Mar 2026 13:35:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1774287306;
	 x=1774373706; bh=pvwzZAjsbfOmUZtWpOa1lG5JcfCWEmIgVt17+47KLog=; b=
	UqARFEZAcT3VZHJ5shR2cteY765Pi7xpovh09jkpdRWYTQulgNmMyapPq5EHwpmJ
	/zLHKKJbdtmNB5ZgQhPePXrprbB5RpVPDfiPusupzE0cp+pMb1xGLeOpKYuaRoa5
	BQak4Yy1wQwp53ZmiiRaq7W//XoVNOHbVoII7VMNqBZ/CQbO5tKJt0hHpyVojQhh
	j3zHXzwhv+FZZNXVn2+Tn8Jo883ZDt/PrUFJi08casfp6q6XF+0VFnhvWU7U0HdY
	tlgq3t8ok+f5YCuI3XzrBclJ5uDNbr/KHh5Hr1FKScPP29QjPAkM+jSoNZviruFh
	J3zgVFIUh34c2EsPdErPmQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1774287306; x=
	1774373706; bh=pvwzZAjsbfOmUZtWpOa1lG5JcfCWEmIgVt17+47KLog=; b=x
	cgo3Kv3fLv/bTwPQdbY6duvgHJiPD505vflKDmYRZZbGU57bp2yyu4z3FazpVWsy
	pHrehLHjGAX2aFHa+O8hM39Vl3710rbpP6+KRGR4q0cTUiuKoHyaj7xSRpBfWWGP
	ovHWMa4xJzmoDyA7Mo6szYQLdZhS0QZ92L1jFnIWdQCUiyaA6FonUfNQVwYls5Vc
	xyhptH63ZHwN2g3GAQrPszwi3B6ihdxjRfJ2xWRJiK76Fb2sp7QTeNNq9M5kJoSO
	M4GWAj23t/4W0LsrJxuNV6zjYTf6rhC4yrcvBhPh1rZsItiw++vJRrk3D3/Wnk+f
	FNZP8sViXxM/RUiFz2BQA==
X-ME-Sender: <xms:yXnBaT8272QI3s9Ohx3t8txC6O88Rw0ySMfpJGhusC7DtlwXWeUwJJ8>
    <xme:yXnBaaiGOWThHiWqdOdvhh8yX9jipx8malferK2sIFfc8QO0ItRGPktiIo4i2ni_Y
    kIPqmUz_dQt-kVdIvvBzALQQoLT527zI6loRxEg2z_C0a7sItkWoSg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefudelfedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedfmfhrihhs
    thhofhhfvghrucfjrghughhssggrkhhkfdcuoehkrhhishhtohhffhgvrhhhrghughhssg
    grkhhksehfrghsthhmrghilhdrtghomheqnecuggftrfgrthhtvghrnhepgedtjeeiteeg
    hfeutdeutddtiefgvdegteektdeutddugfekleeugfelteffjeffnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhrihhsthhofhhfvghrhhgr
    uhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtthhopedvpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopegsvghnrdhknhhosghlvgesghhmrghilhdr
    tghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:yXnBaSqr_64nYLh1qpYwlQ5A9WzMh5mVIdzWdKvHWB5cwNDURW3V-Q>
    <xmx:yXnBaenlNZUGP1BDk2klm9oKUwjUkckCFcr21m_uCwAoGzuFvDyF-w>
    <xmx:yXnBaey3FN9Zli9ii0GCyPFQr9qxE5Fmk1QYeqEwL030T6lKdYGaNg>
    <xmx:yXnBaelCOGxE0AfEbwWrn8wRrVrnqo5DcNvMvxvCiOdigap1jdJ8yw>
    <xmx:ynnBafQoE2gDOPGUmcLbh_UkxBXUfY07h_mqQsyzj7wyY1VlLESItTDu>
Feedback-ID: i83a1424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id D0BB51EA006B; Mon, 23 Mar 2026 13:35:05 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: ALlot-drpGVV
Date: Mon, 23 Mar 2026 18:34:44 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "D. Ben Knoble" <ben.knoble@gmail.com>
Cc: git@vger.kernel.org
Message-Id: <1873f57e-76b4-48d0-8034-73f72f5fe93d@app.fastmail.com>
In-Reply-To: 
 <CALnO6CB5WOTp_e7Kv3CrEbQ+3XE-gDxNVHf7qATBEbyKWfxpLg@mail.gmail.com>
References: <CV_name-rev_--format.4ad@msgid.xyz>
 <V2_CV_name-rev_--format.51b@msgid.xyz> <V2_name-rev_--format.51d@msgid.xyz>
 <CALnO6CB5WOTp_e7Kv3CrEbQ+3XE-gDxNVHf7qATBEbyKWfxpLg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] name-rev: learn --format=<pretty>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Fri, Mar 20, 2026, at 16:25, D. Ben Knoble wrote:
>>[snip]
>> +--format=<pretty>::
>> +--no-format::
>> +       Format revisions instead of outputting symbolic names. The
>> +       default is `--no-format`.
>> ++
>> +Implies `--name-only`. The negation `--no-format` implies
>> +`--no-name-only` (the default for the command).
>> +
>>  --tags::
>>         Do not use branch names, but only tags to name the commits
>
> IIUC that this patch also adds --notes, should it be documented here?

Yes certainly. It dropped from my mind when doing the last session for
this version.

Thanks for spotting.
