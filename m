Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BD5420010A
	for <git@vger.kernel.org>; Sun, 24 May 2026 08:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779612028; cv=none; b=CZzs7ure6IAhXqCy+dyyR6hLW1Mb/n7smBNOPOmzYSO6t5Nc7U+HphJQc/krB+e1lD3Swjyadg7NfX/W8X07XviZ2GXf8FKAjD5D0NytoIEB7VqO9+uI5Ozl3s0rGsb4d99V+YpLyQTyLOgsoUHaG2k39RLSi8D70d6umWPh5Mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779612028; c=relaxed/simple;
	bh=WKrYulesFoaEHtGQ0dK2cjS6XL6pPfR/jgXsIjbjrIs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=iUwZUpIrnzXwdX0CpGVC8vQ97VpAhOn7gF66DBAUfPx0sjxEgU61G2IKxeqmk7e8wz1VuvxiQnHjcy2dCgcMLKZ5/3s1WQqkzLexKCJZ7tyW1AikqR/eNAhyanY/KJUdbT/gFXK1fpfmJ88lG31sSBlj1lfFNbZBHMkXXhhIFOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=rXpCBqM5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BRUk7Hn3; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="rXpCBqM5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BRUk7Hn3"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 74687EC0118;
	Sun, 24 May 2026 04:40:25 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Sun, 24 May 2026 04:40:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1779612025;
	 x=1779698425; bh=zhSef8IlxyDAPmBzAQDWGZhDw/rYcfTBRHF/4anxHSs=; b=
	rXpCBqM5sEezPZcl1lgsE/CbDWwXKpP087Wfi3pevIvi8HPBnI9HSdI0s/pX0UIJ
	CdREnHqxIG+v7uDGuVoXUyEOQWovPFfaSu53QeERwBG+uNhEW7shPluyFTZFi8IS
	8Ma8I9T5IHQsKxBtEg3PjikL5UhTC19MP1a4Q8lHVSZlPpdiFpYSpk+rQB4NEmNC
	n80DLCq/MWh1wt1JRs6jaWhtdgnpf+PT0Eynm35RZbMEX6mUu0+V8DFlTmqE5zKz
	C3GVscqVgsDw+xmmMbi3YbLx7O5WAknlx840oaMGxPV9X8Ny/o1bG0ZWLxO0Apv0
	rbqhMJC34Qkeu8SyATTMfw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1779612025; x=
	1779698425; bh=zhSef8IlxyDAPmBzAQDWGZhDw/rYcfTBRHF/4anxHSs=; b=B
	RUk7Hn3gAyvS3A6QCHro6NCzOMVNTYkB7g671rcbX6HhSPbkNE8Bu3RTVP+O+X1t
	Gl+dlBNzuZ9JMiImMx24y+fNwfuLtxK7Hz6K+3yZrHbR9ti3hYeY0QpYP6eV0pPb
	TL4QwIlGOB5M6XB9sHGB8IAqG7Ygkd/NBBTIizmba95Fbp8bgYTc3q+aCiC9O/qK
	6XpcnLPQDHbmd1qIZvmE3MrDX+BH3kzv27FXQBcoNhsJWxEQ0wwUIzWTSKplyJB3
	qJgcjO0dnkqg00reS/RE+9HSXNqbDlPrI7h1TCkDesgZMaxg4l/uwEoaRRn8Cj+6
	3H4y7F08SCAjsYf4rlgog==
X-ME-Sender: <xms:ebkSagsGBpdFRMhNlBVYsnum6FsLiJ1_vHfi2KejAuKML2ghXSa23Q>
    <xme:ebkSakVbT-7brN_7-QuXheOf7KHpE9eQ3wozL_ovmDEIqjeQgj6mC4u-2v5gRdWgW
    _ZHuCsnQAmMhlDRY05XhzZ756SBo5QkkgmyV6WiVn59MWtsCbwcng>
X-ME-Received: <xmr:ebkSakFteGDY5AJSc1nzFV_q1VIhT3iQh5EFKDZZkNstsGwmg5KX8bTRajYoDlN0OE5W7nSpiDJ_wb9qI1f-_4EzBAPQ9utPMHY3>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduheehgeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgfgsehtkeertddtreejnecuhfhrohhmpefluhhnihho
    ucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrg
    htthgvrhhnpedtffdvteegvddtkeetfeevueevlefgkeefheeigfehveehvdekheelveev
    fedtheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehkrhhishhtohhffhgvrhhhrghughhssggrkhhkse
    hfrghsthhmrghilhdrtghomhdprhgtphhtthhopehjnhdrrghvihhlrgesfhhrvggvrdhf
    rhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    eprggurhhirghnrdhrrghtihhusegtohhllhgrsghorhgrrdgtohhmpdhrtghpthhtohep
    ghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:ebkSau0U_OBK-bYkRht7MVg3NVhAEA4A8wfXJoRC6N0sLAm4s0g5nw>
    <xmx:ebkSauOTs0vLg_tB4TF9LqoZNeYjMiWcU8wqdU0J-pKyPX1D0dt-3Q>
    <xmx:ebkSal5DlMUSrkJw-d4aTuzSi04xqJCLQPJAgX0IqaLIriXupR1oFw>
    <xmx:ebkSag1riEnargJfDLdaTJDZekqLeCrDBHpkNPBaYwB6YZqxhigwPA>
    <xmx:ebkSapGPIdq6cmstsRQCIDaz75O_mUuqL17VoCfOm3w_Dj25yeM9YzLL>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 24 May 2026 04:40:24 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
Cc: =?utf-8?Q?Jean-No=C3=ABl?= AVILA <jn.avila@free.fr>,
  git@vger.kernel.org,  "Adrian
 Ratiu" <adrian.ratiu@collabora.com>
Subject: Re: [PATCH 0/4] doc: hook: small improvements
In-Reply-To: <6cea9d6c-e72e-4b71-9380-41bcae72fd79@app.fastmail.com>
	(Kristoffer Haugsbakk's message of "Sat, 23 May 2026 13:43:30 +0200")
References: <CV_doc_hook.6f0@msgid.xyz> <2832179.mvXUDI8C0e@piment-oiseau>
	<6cea9d6c-e72e-4b71-9380-41bcae72fd79@app.fastmail.com>
Date: Sun, 24 May 2026 17:40:23 +0900
Message-ID: <xmqqy0h9i4js.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

"Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com> writes:

> On Sat, May 23, 2026, at 12:24, Jean-Noël AVILA wrote:
>> On Thursday, 21 May 2026 18:25:54 CEST kristofferhaugsbakk@fastmail.com wrote:
>>> From: Kristoffer Haugsbakk <code@khaugsbakk.name>
>>>
>>> Topic name: kh/doc-hook
>>>
>>> Topic summary: Small improvements to git-hook(1) and the associated config.
>>>
>>> [1/4] doc: hook: remove stray backtick
>>> [2/4] doc: hook: consistently capitalize Git
>>> [3/4] doc: config: include existing git-hook(1) section
>>> [4/4] doc: hook: don’t self-link via config include
>>>
>>>  Documentation/config.adoc      |  2 ++
>>>  Documentation/config/hook.adoc | 19 +++++++++++++------
>>>  Documentation/git-hook.adoc    | 11 ++++++-----
>>>  3 files changed, 21 insertions(+), 11 deletions(-)
>>>
>>>
>>> base-commit: aec3f587505a472db67e9462d0702e7d463a449d
>>
>> This series looks good to me.
>
> Thanks. Can I add your ack to the patches?

Sounds good.  Typically we only honor an explicit Reviewed-by:, but
we add Acked-by: a lot more casually.  "Looks good to me" you are
responding is typically good enough.

I'll mark the topic for 'next' in the draft edition of "What's
cooking" I work off of.

Thanks, both.
