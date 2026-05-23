Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2F1A22A4EE
	for <git@vger.kernel.org>; Sat, 23 May 2026 11:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779536634; cv=none; b=ZSC86tfD948cWHUrNXVjB3Q4YvkofTY60tquAFNq1DNuSuaZ5sjOgWKDKbSMr3nnuBUHfh/ac0LCbOnUHMoZaFSzT6u6tR0i/mv2mj4JNF3vIOtIEafX7F+bNo0c040lcU7WJsGff0TMkvuGfpXJg9fWvRsZeVwojbrZV4x1ROo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779536634; c=relaxed/simple;
	bh=vJQ78N8lOdEY5SN9Zrj26vNTcrdkJxZbb17stRW/y64=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=IFYwtWZekOx2irPMlxEDHeKHmSQ5RbdM2/HNppjw7WQZ87ailPEwPlM6RS1eUuzYMbEVxILxxNHCQgZZ7rVzecUs1qBRxNwCGn24jrvLPVCYURTJ7/wPjPRse9EKlC6FIjeodfem+wze3QAQqR0tPP9CxZ1FN55YlUXG1FnjSEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=jHscc4ov; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=tGACG3Gz; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="jHscc4ov";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="tGACG3Gz"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 2E3CBEC031D;
	Sat, 23 May 2026 07:43:51 -0400 (EDT)
Received: from phl-imap-09 ([10.202.2.99])
  by phl-compute-06.internal (MEProxy); Sat, 23 May 2026 07:43:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1779536631;
	 x=1779623031; bh=vRF7v6RG6+FzRAR7xUNZqOBGpD28mhB7wEWDZ6UcY78=; b=
	jHscc4ovBz+qPrNQFPHQUjLmlbL+HAXNpHOIz5OaftAAifv9pHgjnpyZl9YBsgaD
	CYkEVcYh3TYGJmOa98ODkeUV+KjVnHmkHyOKNz7ic2AyRq6f/OkOAa9IwgsCoOxC
	/+EKF/k40823glJkPo67eAbp+myMF5JdoBeix/dcrWhParurFKZ/nokwUYpvwp+y
	OVrPtqlJiZa6QXoNPuNQvb13fPlWdXlS1Iv6h9HMLT0zXFZkbVmR7Q1SCWSQy72W
	yPkUsO0tVU1X99/MUy2ur5jVE+fcfEcC5g4+zqgJBJmO9jwUA43thmhXm+PDkvzi
	XIgimuJRvUGBo4Sc6dZSzw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1779536631; x=
	1779623031; bh=vRF7v6RG6+FzRAR7xUNZqOBGpD28mhB7wEWDZ6UcY78=; b=t
	GACG3GzgwUxdsbOfLToqPU/AGqxdpIGef5btsRaDetrzlI9AB/97xYpDc7JbYvED
	j6JvF6I5RqJEysbTEWlO8idGOMFUWpY4/Ux8G15AjWmYjngKXum4UwqOCO1O3JQt
	/lsTD8H07wa1aid1DIktPiZ/3Wx0TTun7Xs+WKETRVNEBX8H37pExv2iBUhGZRXe
	M77nURC00ZbP1JKMvEEGbrn7c0hnBt08BdAKFFVWPzpf5SCSpa1vWjRGDIEjA1bw
	MMbfne0++CObrZURa+ZaucNZKD9GFzQF2wEH4+LPkm+8EROsnmbubFlOI2+pj9QF
	ww8iV/DCEAKq5LHYpAZFQ==
X-ME-Sender: <xms:95IRai6CmIFC0IKFOKfspMd6RuU60__LgNMzub6Z-wqzuXngNoHppkA>
    <xme:95IRamuV2_SUNhNFDLpcxW7Pmlme0MjD76lr7LPmJCDn1-LFoDHFfartfeQc6zrvm
    jM6nbLTPgzgEbgQYaIwlhfpNh2M4nwVWAfzch-4z8ZylimQIq6Et-c>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduhedvleeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedfmfhrihhs
    thhofhhfvghrucfjrghughhssggrkhhkfdcuoehkrhhishhtohhffhgvrhhhrghughhssg
    grkhhksehfrghsthhmrghilhdrtghomheqnecuggftrfgrthhtvghrnheptdeigfegjeeg
    jefhheeuvdegjeekleeguddukeeljeektdevjefgiefgfeekudfgnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhrihhsthhofhhfvghrhhgr
    uhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtthhopeefpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopegrughrihgrnhdrrhgrthhiuhestgholhhl
    rggsohhrrgdrtghomhdprhgtphhtthhopehjnhdrrghvihhlrgesfhhrvggvrdhfrhdprh
    gtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:95IRapW5RkSxlhzliUJVDsWoA8LxVk8nh39ax4F3EyB0YfZXM1YMIQ>
    <xmx:95IRahVm_9D7Zt-6Kd5IewRBsnWkaM9u_wYHemeonGKUEZZNNyUtog>
    <xmx:95IRaofQMi4TI1O_QU6UyaV9vdkLmT1Qkw_3iYNRGlh_Vt6IqT3Djg>
    <xmx:95IRaqWUAayxI565iveEgI-spCi5kDknaZHjbxrTBegQAU1f-gdIUQ>
    <xmx:95IRahEdsXhOZirmMuCccPSN89KwIJCeEuMdRF6zXt7s2OKkBLTGAt5g>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id ECB0F3020073; Sat, 23 May 2026 07:43:50 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AYiJhcGZxRkB
Date: Sat, 23 May 2026 13:43:30 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: =?UTF-8?Q?Jean-No=C3=ABl_AVILA?= <jn.avila@free.fr>, git@vger.kernel.org
Cc: "Adrian Ratiu" <adrian.ratiu@collabora.com>
Message-Id: <6cea9d6c-e72e-4b71-9380-41bcae72fd79@app.fastmail.com>
In-Reply-To: <2832179.mvXUDI8C0e@piment-oiseau>
References: <CV_doc_hook.6f0@msgid.xyz> <2832179.mvXUDI8C0e@piment-oiseau>
Subject: Re: [PATCH 0/4] doc: hook: small improvements
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Sat, May 23, 2026, at 12:24, Jean-No=C3=ABl AVILA wrote:
> On Thursday, 21 May 2026 18:25:54 CEST kristofferhaugsbakk@fastmail.co=
m wrote:
>> From: Kristoffer Haugsbakk <code@khaugsbakk.name>
>>
>> Topic name: kh/doc-hook
>>
>> Topic summary: Small improvements to git-hook(1) and the associated c=
onfig.
>>
>> [1/4] doc: hook: remove stray backtick
>> [2/4] doc: hook: consistently capitalize Git
>> [3/4] doc: config: include existing git-hook(1) section
>> [4/4] doc: hook: don=E2=80=99t self-link via config include
>>
>>  Documentation/config.adoc      |  2 ++
>>  Documentation/config/hook.adoc | 19 +++++++++++++------
>>  Documentation/git-hook.adoc    | 11 ++++++-----
>>  3 files changed, 21 insertions(+), 11 deletions(-)
>>
>>
>> base-commit: aec3f587505a472db67e9462d0702e7d463a449d
>
> This series looks good to me.

Thanks. Can I add your ack to the patches?
