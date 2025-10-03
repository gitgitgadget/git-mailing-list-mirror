Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43C6F15853B
	for <git@vger.kernel.org>; Fri,  3 Oct 2025 17:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759514066; cv=none; b=rQJmvysPN6iX1SjelnRaeSKg2wyi/jpVD1PDQQm08O50LbyRAYQYjnCW0NxBz+0z3vEuQzgub7RH2lLN6hUeYdv14iNu8DdcqiMkQmKHE0yggCNRvK6PKByDJvYuI26X04xHoS+vV534BVL0js0m4S/Ijok6yExaGU0rDbRW9z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759514066; c=relaxed/simple;
	bh=JI8pxdayOGB690tfK4O5SdgBJ5nvUY5m3aYjhRUZZKg=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=ujccD61oIlmecCceHQS6Vjfp4SC8x7EI0VmWPe4IxY6+06t4RKq6TBqIOX9kaE0jhE7qOSCSxV7yjx2iTnQzqH0idnyP7qLxI/LAyhsMOWJ/7m4lIRmYLtjSejnALDv7omACWymdFu08LPdgxAeKu6vpTHQojI7bNWgvqQBBIRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca; spf=pass smtp.mailfrom=jvns.ca; dkim=pass (2048-bit key) header.d=jvns.ca header.i=@jvns.ca header.b=AxkBG/1K; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=X5mPKvai; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvns.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jvns.ca header.i=@jvns.ca header.b="AxkBG/1K";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="X5mPKvai"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 39B3F1D00109;
	Fri,  3 Oct 2025 13:54:23 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-04.internal (MEProxy); Fri, 03 Oct 2025 13:54:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvns.ca; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1759514063;
	 x=1759600463; bh=oFRL0/feXVLndKJFhkh2F9jBWXqaYKS46pQIvSKa3ZE=; b=
	AxkBG/1KgiiKofRWZjUs4bmLwqiYoYXcs2o5NwpJTUJ5OZ7H3c+WUwRFip7O+vCb
	f15JEatbQBUCoP9ebSjzpNV23sOIFxnMMeLJHHzllD+aq8EVSFJOSvkpM1s45rYt
	tu9nkn1wP0so4BnkvLW34CZZj1/jBYYMDHTnrVwXkfyo5DPVPe0wtM/WRJBu/TQl
	67QOB6ZC9OCXNKq1kk7U/U/DFL4jDoRHl0TmhO88Ndia+OW5kLb2hJ1JqZjuJjec
	YOCtqpfYS2+ViS2UhV48Y7oiHT6IP5DTbar21ePSpa9XlMokd2QGsYWqEg3oUZF1
	E8Z9kJUWWM1eNfnJJjIlNg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1759514063; x=
	1759600463; bh=oFRL0/feXVLndKJFhkh2F9jBWXqaYKS46pQIvSKa3ZE=; b=X
	5mPKvai2lBzkuA4FRmo1C2dn6uGVZy5IOdxYNeyeUIzguXBlrYhm8blTTLEMMq2F
	IIl3bfCn6VmBTywUKVhEVTgSu1YRDZp8ZTJTtaf/r5/qUTBNQ3oe/iMBe0QQaaj0
	Osd5DQnjvZ0IppSu4orQOnLLYbJMh+kLgC6ezUmQ5WBlg+kR5F9DvsG+2Nj77Pfp
	hLZk3F5gli6NXp447RsnHIZ6qvpHjEUnjF5GIhsktBD5VC+YpnCKmsJJNPEH2fsf
	WFfEm8eDD3+uLQVA7oOqmNzVK1sLdvXMHnVZ5xVASRJyW8jS5RaDdIqkBbOGi3CP
	4TWnfFPPamL2N5cV1h3dA==
X-ME-Sender: <xms:zg3gaJFA7yXAjyuhZ_RiMzASU5S-_gbr7rfQAzK4CDS2toQVrlAXvA>
    <xme:zg3gaJKXGzqmj30tsSSuO4vdeLkAnGQefxAryRbjfuIYdMBdsNGT9fBPaSHAtScGW
    IeIWR2212qTev7wd35TWLJXVXlf1Bopw-upAwu2l3OTQsp0G5SCkF84>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdekleehhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthejredtredttdenucfhrhhomhepfdfluhhlihgr
    ucfgvhgrnhhsfdcuoehjuhhlihgrsehjvhhnshdrtggrqeenucggtffrrghtthgvrhhnpe
    etjeevheejjeduhfevgfeggedtteeuieekffeutdfggeegudfgkeeiudffteegleenucff
    ohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepjhhulhhirgesjhhvnhhsrdgtrgdpnhgspghrtghpthht
    ohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepkhhrihhsthhofhhfvghrhh
    gruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhrtghpthhtohepjhhnrdgrvhhi
    lhgrsehfrhgvvgdrfhhrpdhrtghpthhtohepsggvnhdrkhhnohgslhgvsehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhr
    tghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:zg3gaErS7H1dK6toU7Xub1br18gIO796BPVqVOpkdqw_zJfOl96Ylw>
    <xmx:zg3gaMIvnfACMoSPj-dPgCLd6iH8XS4g3gLqLxzwOHHTaJIhL6CATQ>
    <xmx:zg3gaJRewyP-oqGI2zHrGAhKoChPym9BjSkUfApfeNiPMeCkn0i-uw>
    <xmx:zg3gaLuWlE08P_IZxfsI1glWzwTZZA6DYIXaG3H_CHrTbLngduEK0Q>
    <xmx:zw3gaM_pRttAsilHzM5N-uaU3HCqZo89DxTxfL1GoOXBKDY1nSNYPoqR>
Feedback-ID: i2aa947c3:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id B30AF78026F; Fri,  3 Oct 2025 13:54:22 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AiyWxa7EEqz3
Date: Fri, 03 Oct 2025 13:54:01 -0400
From: "Julia Evans" <julia@jvns.ca>
To: =?UTF-8?Q?Jean-No=C3=ABl_AVILA?= <jn.avila@free.fr>, git@vger.kernel.org,
 "Julia Evans" <gitgitgadget@gmail.com>
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>,
 "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
Message-Id: <d86f4f3a-b6eb-4684-823d-35dc1134b50e@app.fastmail.com>
In-Reply-To: <5044672.31r3eYUQgx@cayenne>
References: <pull.1964.v3.git.1758649472.gitgitgadget@gmail.com>
 <pull.1964.v4.git.1759262314.gitgitgadget@gmail.com>
 <69825d46349e55dd1b17444ab4e6d542fd44f371.1759262314.git.gitgitgadget@gmail.com>
 <5044672.31r3eYUQgx@cayenne>
Subject: Re: [PATCH v4 2/5] doc: add an UPSTREAM BRANCHES section to pull/push/fetch
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

>> +UPSTREAM BRANCHES[[UPSTREAM-BRANCHES]]
>> +--------------------------------------
>
> Please do not put anchors on the same line as the paragraph.

Thanks, will fix. I just copied that from elsewhere in the
documentation, but I agree the anchors should be on the line above.

>> +The upstream is stored in `.git/config`, in the "remote" and "merge"
>> +fields. For example, if `main`'s upstream is `origin/main`:
>> +
>> +	[branch "main"]
>> +	   remote = origin
>> +	   merge = refs/heads/main
>> +
>
> Please mark the code block with a dedicated fence:
>
> ----
> [branch "main"]
>    remote = origin
>    merge = refs/heads/main
> ----
>
> using tabs may lead to issues if the text is modified later.

Can do -- previously I was using backticks but they didn't work, so I
switched to indenting it as discussed here:
https://lore.kernel.org/git/xmqqqzw7arls.fsf@gitster.g/

But I can use ---- instead.

It might be useful to document both of those in the part of
CodingGuidelines that explains documentation formatting,
I don't see them there.
