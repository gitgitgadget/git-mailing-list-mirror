Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7DC22206A8
	for <git@vger.kernel.org>; Wed, 21 May 2025 15:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747842466; cv=none; b=u8Nc0h+0zF6A1w+Y38hr92q4F7zLHn/QBEnvMeAzGAmNulefU0j/clkAMSYaZ95hqfW2gmeKCifrlaroPJgnisNnN7JU/1gLwValzS1Dq1mYrE+5FlVGI0vFQQM60eWKQwMBHQJhBNM6ZrQJzgrMPLlkyUWLJfHENLwnwvckYhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747842466; c=relaxed/simple;
	bh=yoBDWDSSc58wFyi4h1EruUPckEfACvCEMVBYynd10Nc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NPds812YGigXrEsjPdJBwoqSNVqh+utSkVQVC2tOEi+m6RPa17D2GVeykjALOwZqnIB9OjX1bBs8CmrN50hDfBqygvxGkPdiMWyM+DTtKrnydpLnOFMR8lpqf78Azk9SJTljO3QPQVPdNx9IBu1yA89RrlMXYAyY+jsLPTmA3Fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=CyyhL+nS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=E1Jhg8Z1; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="CyyhL+nS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="E1Jhg8Z1"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id 654BE1140137;
	Wed, 21 May 2025 11:47:42 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-10.internal (MEProxy); Wed, 21 May 2025 11:47:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1747842462;
	 x=1747928862; bh=kxIVI7qf1GZN+Uybv6wT6pgLJ4Fb2CrcgWZ7cn1mbvE=; b=
	CyyhL+nS3OX7NVHKEn0+GOCiXjw35UKMfVuOA2xPC0e9IWVn1+jxgzhZ8sOwq2bZ
	K7DUD+tcsUKTAkHD/0iROX/dilzIvSmIv3EyjeVKI8vWCNVZRkaRVVt95nrG2+iC
	r+43epPjqyWifVZg/55CwBltUCdc9p4y53z4sVd/qjMMfwyMi2HNWiMbIeZNWmqS
	Gtace0hVW8qUV05kakuAQkK+S2T1Myz7/F4SfIgtbrcn9imayVtnH5doY7qNoGeb
	x59aaxNjLvChkOrMLzQtKCfDX/puuiFH4Lh2c3QkHwXrxhZeuqsDELQBbLa09DqN
	+6dfy0VZgGm0rl2We3AY1A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1747842462; x=
	1747928862; bh=kxIVI7qf1GZN+Uybv6wT6pgLJ4Fb2CrcgWZ7cn1mbvE=; b=E
	1Jhg8Z1f9+GhpeEiBMd6Yq30n9xYv5gsIVY9gAMHK7RYk7Nt5i9HTK2BIxaEq8LZ
	9qMiTMUGQBx0k9p4VNqtdb9tZMquQyWxMr0lYtRuVnA5tRfAWHfSv9aJlttQHARR
	NkwVc19ovxQlTd/KY188D1NVXRAA8+srwXjliQ83JRs4GML9Uwb/DGK5L0u8PvAI
	LLjNtwcjXiE2cQga5nTKbW8/pWW1pw0AogPnZa+ecBWuKxTNYlRTPj8ISyUH5Son
	cYII4XTE4PIpK3vMqjt+7ExT9UNVFzTvjxihIMyUkUzduUJG0RIkZHJMnTm+06tU
	kXsu91UB0XxOGpNy66Z1w==
X-ME-Sender: <xms:nfUtaPMo_kGsIFFZirrokx9TIsn2Z0z7otpdKsybj602WHYoNSHf4w>
    <xme:nfUtaJ_d-zM19XmdcKoLmq5aPPYQ9N2F39xEJ1XXRRcBuqOqbI75JcyHmMm71LbRQ
    aq60-kgjKOoUlptZg>
X-ME-Received: <xmr:nfUtaOSOTpOoiAnCFy9ZqXe4hY7-wLR9AEsLzrHc_sFOJIVXGBv3hlb3tkcq6k_j0w5ZrXR8WgOeKacDfm7AV6jOvcMYeaGhWzo9VCQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgdefgeekucdltddurdegfedvrddttd
    dmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgf
    nhhsuhgsshgtrhhisggvpdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttd
    enucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefujghffffk
    fgggtgfgsehtkefotddtreejnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoe
    hgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeehveeiieef
    heeuvddvvdfghfehudetfffhudelvdetudevgedvgfefieduledtvdenucffohhmrghinh
    epkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehm
    rghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtoh
    epiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheptghouggvsehkhhgruhhgshgs
    rghkkhdrnhgrmhgvpdhrtghpthhtohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkh
    esfhgrshhtmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgv
    lhdrohhrghdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepug
    ihrhhonhgvthgvnhhgsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhes
    phhosghogidrtghomh
X-ME-Proxy: <xmx:nvUtaDsb5wMgSycGwN-VVpOAZJnB7FuWOLrMJyQCPCmwFVMZxWM2jw>
    <xmx:nvUtaHdehcwguY-VTtdfVl5oErFO0LpowF-oTU6a_HMeZy0hfIoSFw>
    <xmx:nvUtaP2-QrArMaREJhGS0ZS8ZVKKnEnyR3Wkop3uull1-drlk6MGHw>
    <xmx:nvUtaD8x3O2xuHC0XXfobb6aDvIDkMAT4ilQAfaD4r3Y8N_24zLzzw>
    <xmx:nvUtaMD5O23klW1hD8B1YwPr6KkLjysfeVqjAZVO-vtBHlvG8ByLXs19>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 21 May 2025 11:47:41 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Kristoffer Haugsbakk" <code@khaugsbakk.name>
Cc: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>,
  git@vger.kernel.org,  "Jeff King" <peff@peff.net>,  "Teng Long"
 <dyroneteng@gmail.com>
Subject: Re: [PATCH 3/6] doc: notes: split out options with negations
In-Reply-To: <d4491de5-9482-4bd1-9fca-dd960a815f51@app.fastmail.com>
	(Kristoffer Haugsbakk's message of "Wed, 21 May 2025 16:42:15 +0200")
References: <cover.1747763769.git.code@khaugsbakk.name>
	<d2b6864b7072faa2c804c98ce7758b666e11f00b.1747763769.git.code@khaugsbakk.name>
	<xmqqfrgzhzbp.fsf@gitster.g> <xmqqsekyds2e.fsf@gitster.g>
	<d4491de5-9482-4bd1-9fca-dd960a815f51@app.fastmail.com>
Date: Wed, 21 May 2025 08:47:39 -0700
Message-ID: <xmqqwmaaartw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

"Kristoffer Haugsbakk" <code@khaugsbakk.name> writes:

>> I guess this was left unresolved after the series, but it is
>> perfectly fine to leave it outside the topic.  Somebody else may
>> want to look into how exactly stripspace behaviour works by default
>> and how this option affects [*] and document it here.
>>
>> [Footnote]
>>
>>  * IIRC, we made the default to strip, unless the message came from
>>    an existing note in which case it is left intact; but whoever
>>    does the documentation update should check it.
>
> Good point. I looked over the options for any ambiguity but missed this
> one.

Heh, that was one of the things the article you cited stressed on [*].

> I’ll fix it on a separate patch in the next version.

Thanks.


[Reference]

* https://lore.kernel.org/git/xmqqcyct1mtq.fsf@gitster.g/
