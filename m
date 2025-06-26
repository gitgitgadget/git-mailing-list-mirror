Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE6A31DD877
	for <git@vger.kernel.org>; Thu, 26 Jun 2025 15:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750953368; cv=none; b=G5KtjGh+FSlvdTxo2W1KdaZtmeurYkJGkh3YlrjaW9LGsM6HB4Aku6HqgeEvdX4pQZDKVoVoGlNPQWmBOkCLYuiokaZOL29wteGNecvzYxCjiMgHKu4cZjUjAtAmoWMVIUw7eN9S99f65X0QwFnDdL0zK+zFfkEsqaI403HKvqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750953368; c=relaxed/simple;
	bh=Le5U6m/UAytYoq6y1cmADwK3uu4EVS5t6zPfLERdWkg=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=g3CBNmOo6anYwaK1Hc8qeCrFA3QvC+X63QTaSSfphHXAk3Yttllx9ZZ4W/5Hg5Mksi270E4VBKl+etM7WIEqzSgCGRLLuHNugFG1vEllOmZxotUDlrGFY6MDe5yCfSLqlFYF3EkW+VMO5qWb5oBbcWNiFMjtveoN8N3v5E2I+BM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=Vh365eBg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bHS1m9GG; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="Vh365eBg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bHS1m9GG"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id 1A3BE1D002B0;
	Thu, 26 Jun 2025 11:56:04 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-09.internal (MEProxy); Thu, 26 Jun 2025 11:56:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1750953363;
	 x=1751039763; bh=cqpS+iM+2U0kXgEYiqNCbxwPOeIvvLjCp4u2FcpLFBI=; b=
	Vh365eBggGeU9DYbxnY8YLGMs3o4h9Y5JEoN2AX5mDzHSZx8yZplKjU1VHAtTC9g
	IanY8PgZMdoTyzpLGv4laxS11eG6YHKqQV+XLz4GN3bjmR+XMzrFDUdqKWcBEqdL
	Zk4QKCPGPcPwh1WNKqXXvfdVtACiLMeK+FoCp1IDkdw9C13f1FjTHuhARPa0RMQz
	Ed9UJfUkP49AgS59X7J3+2bAgcbEhyprDJYH+0F713UQju1hlp53weVSZm/OeBuI
	LH7JievdX7n3Kwsqh+r9pT/3M39yqqiSfJw2cYkm6iyttZuWvzP8ro/wzGUV8uXR
	EkoeLjhWhQgMJuBbgv/rhA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1750953363; x=1751039763; bh=c
	qpS+iM+2U0kXgEYiqNCbxwPOeIvvLjCp4u2FcpLFBI=; b=bHS1m9GGyDuDalSKq
	wJQ0pD4ZyxwZhiCBis0mveblCneNLemkJr8gt+UHK+SQNEpKT8whETiNx54Tm8b4
	SvtHcNxwUqS1DHQGm2QKJI+tqNsBjfaRF3ehtWUtJjW9+W4qu+ce1lo+RvMUjiMh
	M+V7hzXQXB4I/EiRKP4Va6RqupFGwss4YyI0l10qJHKl9M7eT7+/7mseZlTcyMca
	8uKl0/z8u+Rma85EnD0zADwj/+9YfBWXr1uUM6GuD+hMoGmcZkJbrOL8aYqQfOjx
	ND+PcwriAPw0N787NHC18WJbko68q7qxtfnUl/cf8FnvBmukWMHeA2gDyGQlZQ2Q
	2lb8g==
X-ME-Sender: <xms:k21daLW_IcwJRS-LKrsOMChQ8q0c9Qae4Ur4MmJ4v-d_8yVwTCv7Ors>
    <xme:k21daDlabTXb5x7oBrJIE-2h1bAhmpnFpl4GePDo1sT-1c2KhM-m-TFFR3hbdq15I
    JRB6iOpE5oDl9QXig>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdehlecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegrihhl
    ohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpe
    foggffhffvkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedfmfhrihhsthhofhhf
    vghrucfjrghughhssggrkhhkfdcuoehkrhhishhtohhffhgvrhhhrghughhssggrkhhkse
    hfrghsthhmrghilhdrtghomheqnecuggftrfgrthhtvghrnhepvdeigedtgfetgefhffet
    teeludevheetfeekffehheefieehudekveelveffhfejnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhrihhsthhofhhfvghrhhgruhhgshgs
    rghkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtthhopedvpdhmohguvgepsh
    hmthhpohhuthdprhgtphhtthhopehsvggsrghsthhirghnsegsrhgvrghkphhoihhnthdr
    tggtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:k21daHb4ipA4A08ZXfv6A0XjZBTLKdogUzdjHq_09x80shzpOevhZA>
    <xmx:k21daGU6EQzd7cZkhJODjC6dpH3NeKdpeXCOtZdGOIKx7EDo-cWerw>
    <xmx:k21daFlfLEVFebgT-G_GBK9f0D87UhsQOomHj02YP2DbLRb2rpwXCg>
    <xmx:k21daDcrgeYO6Nj2j9g6QfriCxnSRkhG4S2mXl2alQSPmVXhgM1YAw>
    <xmx:k21daHny52ocmM3m6Uwiz4D6GpCwsute9PdeGtDro92cPBF33vPyTsFp>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 9EF2C1EA0066; Thu, 26 Jun 2025 11:56:03 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Tdf3fad211066d5c9
Date: Thu, 26 Jun 2025 17:55:43 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Sebastian Andrzej Siewior" <sebastian@breakpoint.cc>, git@vger.kernel.org
Message-Id: <e00dff7e-1920-45b6-85d2-49e6a1218882@app.fastmail.com>
In-Reply-To: <20250611221444.1567638-6-sebastian@breakpoint.cc>
References: <20250611221444.1567638-1-sebastian@breakpoint.cc>
 <20250611221444.1567638-6-sebastian@breakpoint.cc>
Subject: Re: [PATCH v2 5/6] bswap.h: Remove optimized x86 version of bswap32/64
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, Jun 12, 2025, at 00:14, Sebastian Andrzej Siewior wrote:
> On x86 the bswap32/64 macro is implemenated based on the x86 opcode wich

s/implemenated/implemented/

s/wich/which/

> performs the required shifting in just one opcode.
> The other CPUs fallback to the generic shifting as implemented by
> default_swab32() and default_bswap64() if needed.
>
> I've been looking at how good a compiler is at recognizing the default
> shift and emitting an optimized operation:
> - x86, arm64 msvc v19.20
>   default_swab32() optimized
>   default_bswap64() shifts
>   _byteswap_uint64() otimized
>
> - x86, arm64 msvc v19.37
>   default_swab32() optimized
>   default_bswap64() optimized
>   _byteswap_uint64() otimized

Is it supposed to say `otimized` twice?
