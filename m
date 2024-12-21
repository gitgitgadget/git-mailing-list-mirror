Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 728011EC4C2
	for <git@vger.kernel.org>; Sat, 21 Dec 2024 12:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734785633; cv=none; b=gqD2Jb8YgaxSYY0W327CFqZYMA15UB70xsel2nBJrxcKF0t5xVZ5qhrc+pYBo8PcixhpF3s396ln9dermRpT2ihEW+y+maltV9yis6/Pe0RkRGY45gPgJjEKtBlwKp32MBXDIJ+/3AIcgnFPJ9WkJGPV/DWVBbZxhOJ1+emxDDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734785633; c=relaxed/simple;
	bh=aDxbDsppP3cHdkWyHmFMjOaqCOm0CeQCiab0TAiikUA=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=raiROU6TxrLJfsZe9eT255eMvhW+52QSYy7MrCQ5V5pwBCQEypCabunZUBTjgWDRYnzsToBtKP1vFeiibsWctX7GqQXUTqcBTHMlQiGzaW6q6BvijCUcR1d+73u9On08VEQF0htFDJubio9btPPXinC3GTP7M4EkzBcDWHPh52k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=QKjcq/02; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NSdu/xi+; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="QKjcq/02";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NSdu/xi+"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 6F3CB11401C0;
	Sat, 21 Dec 2024 07:53:50 -0500 (EST)
Received: from phl-imap-09 ([10.202.2.99])
  by phl-compute-06.internal (MEProxy); Sat, 21 Dec 2024 07:53:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1734785630;
	 x=1734872030; bh=+mWQZnkHGqpTedGCk6UmNTcHQuiPO3zAYIpA1ArLfQo=; b=
	QKjcq/02ERs8GaoOfSsEQYjZzh8HgyiMPr13XWLJDtMWAC6PyafGdUh5HYCTsezc
	otDwouxnmuGS0+iwHirpQbP34MnnDnBsqUxpSrscSnAdVTf5cxus6yKjiP+DtCMy
	LCvPmPFf69k55rUjgPiVGlu6Wt19f2+3h+YqMYAZ6IIBq8vUMhhCVwjVGlqWEQsd
	Oi6oawSxG/0P7L5rN27IYOz8CjmBQ4ypgb8K2ZagLpxEz8gZoxJGqSLA7VCHC0b3
	YzlXW2VyE0o3KTk28yWxkf5ilwLM/oI4AL6u/YA6Iw8AFxYi2vRtt0tVUnpIZnBF
	YalSoiPGhWGSxSgVgEeTdw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1734785630; x=
	1734872030; bh=+mWQZnkHGqpTedGCk6UmNTcHQuiPO3zAYIpA1ArLfQo=; b=N
	Sdu/xi+ujiLZu1NvuyG+n7M/s4y7xyFbCzUJom/2Y7ZlofPPsgKLuWrq2xTu3fsw
	AiSoVNVAxRvGq4Gy0wR+SVCUU/scWtdNHp9+VeIJ71HCPMlQ12efnmrky2Mc9RkQ
	YZR4O4O74PTtKfxw9JLCRZhj28j5tFft2psBsvkwluVKvGeGhYi+rbv76WSSOQWn
	bMMSp3tnaqbZaQP0OvKD6dtR+rBfXLFkqtHJFV4Z9ggdoyvbSG0uxXBzSJZfPej+
	Sdyb7d0QR53PY6Fgpf6RjreqZEEFfsZFy725rDN5pDzhjLhFsTQc4SRCO7dac73r
	T5ym4tf8hEiuSIrlswWBQ==
X-ME-Sender: <xms:XrpmZyrAdqG4cio_HuLlegelIUKmQA7fB4GjPvirjtRdKDFINv0XIK8>
    <xme:XrpmZwqq40qa9JQTqOtcPNGx8iaPHDAd9FtvhufPmooOhWH9yHbFgE2u8Xuixpcbt
    bsYXdcBxUg6CGy3Fg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddthedgvddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddt
    necuhfhrohhmpedfmfhrihhsthhofhhfvghrucfjrghughhssggrkhhkfdcuoehkrhhish
    htohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomheqnecuggftrfgr
    thhtvghrnhepgedtjeeiteeghfeutdeutddtiefgvdegteektdeutddugfekleeugfelte
    ffjeffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhep
    khhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsg
    gprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehrrghnuggr
    lhhlrdgsvggtkhgvrhesnhgvgigsrhhiughgvgdrtggrpdhrtghpthhtohepphhssehpkh
    hsrdhimhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:XrpmZ3O6TNIV7gTu7QfXzomjlZfqZ61JOntnfJekFGUgH8FLs6infw>
    <xmx:XrpmZx4hFltkMnT3IflxH0M66ZvwjhB8G39v0BXi_fGK-1QKNEypNQ>
    <xmx:XrpmZx7SGHIaew3pCnWTJ_xBhXsxFY2TyQEYn3riMTn3j-WRzp9olA>
    <xmx:XrpmZxgH5xlpUg8LrqWMHF1Oh9WKNq7VYF36becf3r56jC_iURftwg>
    <xmx:XrpmZ7k3UKj3_vr0M1JELZ6b4qMIG6mXEsKA2lQ3u2Usnum-6AuQGqZn>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 125FE780068; Sat, 21 Dec 2024 07:53:50 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sat, 21 Dec 2024 13:53:29 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Patrick Steinhardt" <ps@pks.im>, git@vger.kernel.org
Cc: "Junio C Hamano" <gitster@pobox.com>,
 "Randall S. Becker" <randall.becker@nexbridge.ca>
Message-Id: <1b833ccf-080d-4a92-afe2-3f469bc23dde@app.fastmail.com>
In-Reply-To: 
 <20241221-b4-pks-reftable-oom-fix-without-readers-v1-4-12db83a3267c@pks.im>
References: 
 <20241221-b4-pks-reftable-oom-fix-without-readers-v1-0-12db83a3267c@pks.im>
 <20241221-b4-pks-reftable-oom-fix-without-readers-v1-4-12db83a3267c@pks.im>
Subject: Re: [PATCH 4/4] reftable/basics: return NULL on zero-sized allocations
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Sat, Dec 21, 2024, at 12:50, Patrick Steinhardt wrote:
> In the preceding commits we have fixed a couple of issues when
> allocating zero-sized objects. These issues were masked by
> implementation-defined behaviour. Quoting malloc(3p):
>
>   If size is 0, either:
>
>     * A null pointer shall be returned and errno may be set to an
>       implementation-defined value, or
>
>     * A pointer to the allocated space shall be returned. The
>       application shall ensure that the pointer is not used to access an
>       object.
>
> So it is perfectly valid that implementations of this function may or
> may not return a NULL pointer in such a case.
>
> Adapt both `reftable_malloc()` and `reftable_realloc()` so that they
> return NULL pointers on zero-sized allocations. This should remove any
> implementation-defined behaviour in our allocators and thus allows us to
> detect such platform-specific issues more easily going forward.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>

Nice commit message.
