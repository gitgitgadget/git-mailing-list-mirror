Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDDA527FD56
	for <git@vger.kernel.org>; Wed, 20 Aug 2025 21:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755723852; cv=none; b=Xe+hFWKLUY6+BkU5t+sLs1zGUxkM+z1tM43m0yZCtjVvPNT+0o/ctD0e+G2dW/BiEJWQ19RrzsJj8tq++C3ZoJK6T90FgXGgdhSf2yb9iNmqFTzjaPO9wxk+TNsGEG9Ow4XaQn+9AZT+SOhP6RIk9FF1B3GsHXAFPm661gR6EM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755723852; c=relaxed/simple;
	bh=V+s5CIl5D9hOPuMdw6JEz01fUJGc+KqP8BCd8P5kTGs=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=P0NM/+3EFg8ipmcu6PD4cUbnM6Lz0plwAII6cs51+ebyL2nQ2KyMCh2l6saTgaUhHR7O5j22b5u6BL3kT85CF1Ddnm/5RIKgD3foqfJuQmiJI2eMkmYzj7XL6OipERaZaiDcVKxnY1u0qavX7ITbH+w89o4YnQAQpTgCMH6yapM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=rLG5WE9v; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UPK4ce76; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="rLG5WE9v";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UPK4ce76"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id EB1641D0008E;
	Wed, 20 Aug 2025 17:04:09 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-09.internal (MEProxy); Wed, 20 Aug 2025 17:04:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1755723849;
	 x=1755810249; bh=VSWAw4JiXWc/zRi24I0tBCip5SdGKokQSh+Sr+UUZpU=; b=
	rLG5WE9vmtxH98XjpZGy/HyafDvuBxAf8Pef3eIuboQipK1hzyPp+lcK9nUi4N1X
	StUKNMAwxOxDsXPnc0aDBWCi2YhZOKgOJpkDL/uRQmJ4I81uruYglAtVkhwwqSlN
	1BRsCHZK9tigl0KrUABF39m6PWrKSqfKk3c0VydB1UlwVCV/TN51yClhBBlAKo44
	pHSTRIEqq1w9d3jp44wmKf1m6wYVz0+s6uWk1fzht8SEVrqSfSS32uh7+44bx3RW
	SfIPaDnCfhhM+KIdCwMWjv86+JPzDxoCV+IsaswbNEQV02HwYN7GUUvMzGrPPZkj
	NhGt8RMsJQJvLrva2j5MPw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1755723849; x=
	1755810249; bh=VSWAw4JiXWc/zRi24I0tBCip5SdGKokQSh+Sr+UUZpU=; b=U
	PK4ce76ZdXPJjHRoLfb1N0scNJDYG0XpUOdTgj1L9bU6fZxvWqpU6X50inG729Fj
	N8botEipsTY/GVUOapSQ9yXgSTiyWAufY2HnKZi8EbZ0+gOzJQx6zCGgKQtrEXKP
	C+HNfR0KksLYo01hB8C4Va2CyuPuq7B2317I6e93SE50NMyMLFjsLzE5NuCNRCS/
	DFyvrAKeCcD3RHj8APF2CnFdCEKIVwK6jww0GhNbt2CgpLNtbz38XVRpdHIJPbZh
	g4JnLe+96mbQIaAgduycTcaXNYeT4tBVRt+T31Iy2MhC+YsX3xPJBh45Wwcc4/g4
	hzu6hkDZbq8xBVI6dSuhQ==
X-ME-Sender: <xms:STimaFIALCnCokzucB0LeRUT_K6uaXeN-WwTpWeo7HDhtRLaMU2nioo>
    <xme:STimaBLrk787LdIW9oFiSi8ds3UFpbh4cBPIH8tFxz6YBCCW0eyUAESybp8LVyH1O
    vGZ1aWtDtiPmwBpjA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduheelgedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedfmfhrihhs
    thhofhhfvghrucfjrghughhssggrkhhkfdcuoehkrhhishhtohhffhgvrhhhrghughhssg
    grkhhksehfrghsthhmrghilhdrtghomheqnecuggftrfgrthhtvghrnhepgedtjeeiteeg
    hfeutdeutddtiefgvdegteektdeutddugfekleeugfelteffjeffnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhrihhsthhofhhfvghrhhgr
    uhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtthhopeegpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehrrghpphgriiiiohesghhmrghilhdrtgho
    mhdprhgtphhtthhopehjiehtsehkuggsghdrohhrghdprhgtphhtthhopehgihhtshhtvg
    hrsehpohgsohigrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrgh
X-ME-Proxy: <xmx:STimaJSsVFfs5OhoQdFndGJ0ES38NgFpULaqfdmrV3Z5MVymQg30HA>
    <xmx:STimaMOoy1_cIs1X-_n2qiQ_HrV7aMtOzrt_gftTve7n7A02BEhghw>
    <xmx:STimaOZasL8GtdBbr_UtVGrQPCd4_Sb42TEd6fZfPDiXz_emB8GBiQ>
    <xmx:STimaGxrtNfLfgp8QN_JIG1dV0Iqb25eLFBxBbVwWzfbwXNva1esRQ>
    <xmx:STimaA_eIcZXZE4kGEdzcIGs8VwA5-ReeW7vQUFVTJ295BIX6aNpNeCK>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 9372C1EA0066; Wed, 20 Aug 2025 17:04:09 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Ap_P9_ogk0aF
Date: Wed, 20 Aug 2025 23:03:45 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Junio C Hamano" <gitster@pobox.com>,
 "Michael Rappazzo" <rappazzo@gmail.com>
Cc: git@vger.kernel.org, "Johannes Sixt" <j6t@kdbg.org>
Message-Id: <70e08a97-ca6a-4899-b779-1ed436b76fb7@app.fastmail.com>
In-Reply-To: <xmqq349laeyb.fsf@gitster.g>
References: <20250820195229.45943-1-rappazzo@gmail.com>
 <xmqq349laeyb.fsf@gitster.g>
Subject: Re: [PATCH gitk] gitk: add README.md with contribution guidelines
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, Aug 20, 2025, at 22:57, Junio C Hamano wrote:
> Michael Rappazzo <rappazzo@gmail.com> writes:
>
>> +#### Creating and Sending Patches
>> +After committing your changes:
>> +```bash
>> +git format-patch -1 --subject-prefix="PATCH gitk"
>> +git send-email --to=git@vger.kernel.org --cc=j6t@kdbg.org *.patch
>> +```
>
> Just being curious, but does the project strongly discourage a
> multi-patch topic?
>
> It would be really nice if you add "review them here before you run
> send-email" step between these two commands ;-).

I alwyays use

    git format-patch ... -opatchez
    cat patchez/* | less

Because sending out something weird to a mailing list gives me the
chills.  (And there might be format-patch bugs.)

-- 
Kristoffer Haugsbakk
