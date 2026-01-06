Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82E68328256
	for <git@vger.kernel.org>; Tue,  6 Jan 2026 10:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767696937; cv=none; b=iNEVuOhx7lnxRGgMxhVcPXB1q4xMmzYxDnV/pI2DUKc3ecikX8pMTyiLyd8Fr75WeRVnHSAUbNsxpfODM08CjBbH591MQv4WzcpNxfnlWfEfHPzUuCafj04aUL2k//uXG5YSjMqnRYjEZQRbSXjvHYRgp5Db8YCq/sO78Hx4wag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767696937; c=relaxed/simple;
	bh=lKpqkqxjm22ZfAfXnvEoaZnvKKpK4kbh1ZiLxJH6HqQ=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=SZMuCvvb+E93tq2vSECySkv5Sv5wy3OsZe81FzFF7jcUad2sCAPENCz0PPwuuIM3LkoEqKMsMmEswtpxcvwUD8QgV9npCdFP2SoqnoywjWRYvNfFLeJKXUgB4I8TrEVfDsBa29mqgv736KHQ7BP/80V9W0fbKFwkKBoGOLxXyK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=l+sfn5FA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FXyh98I/; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="l+sfn5FA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FXyh98I/"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id A1BEE7A0177;
	Tue,  6 Jan 2026 05:55:33 -0500 (EST)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-06.internal (MEProxy); Tue, 06 Jan 2026 05:55:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1767696933;
	 x=1767783333; bh=Qv6sWI0OldurdBPxWOAT/FuF3fiZtA9DcMWPwFUFPbE=; b=
	l+sfn5FAwNad1htfJVdsyG1fMjez/JTOI2kkNGq7dPwOR9f2KKnfcr4XIXGyUFMv
	NXdTDWH/e3Bejv0IseBFggjy8JkNvqi8z+578JOhoFS8cCHX+JJWL4zjQ7ztbZr7
	Q0NJfJPc25V2bjL6FXjjxI8oFk5Ec0gdGgtzrCO3H59vW336OWol9La7SCbuUURC
	ye9mTrXamjrPlg1HWinnKmBo8ryzRBN149k6cIbuDzvS/cgJe3C3wpinW2aqlNJb
	NXexBySkGUi2oDFDE103xEwBP0lF5r1FI9WvwdV9Yh4K1WO9wz01pou+WNCbz5KM
	pxEasyU/BLH+rUvUnVWSAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1767696933; x=
	1767783333; bh=Qv6sWI0OldurdBPxWOAT/FuF3fiZtA9DcMWPwFUFPbE=; b=F
	Xyh98I/RCz1AUQLawXrh/7ELwF2ZhR7wZ9fwDscSy31qU8URucPkuVoJQIZLD2Vi
	mXSBdt9GXX6ZoQ20uMXaz9khp6uZLVrPMKaIJZPv9HO67XBTENCKQ6w+sftqSKFm
	4Upps7SD1dUvquHV9O8Ab0n3J8r5KBuhd2FKP418kDESOCk08egJXI4npQ8pdduB
	iFEe6COs1EYEc1Qlbiy8c/1uhbMQefs/BwQU8hGGEZAUaVlvZRu3l1AipQjbTw9F
	EmQ5FDHvqEhzNQhZ7pH+sDcSW4sBgj3qkIpd2c8rQjdbh73WW24NmyG5tKY++qmR
	MWUL+9UOAxAXFpm7yEmFg==
X-ME-Sender: <xms:JepcaVj8q5inuXmFA0a7N2LOffJwmNPlheWVZ8E566GcPWXUuAsqx2c>
    <xme:JepcaU1VoFJ5qDNB3eeRGYR2mHcnP-X5ftt1i32svrzOot7Y8U0osdVSBUHoSIrY8
    TTxABFIoKajsxyoQmm2vhX7hMChPZnuZg9kmhZcxDpcwVA7oqnh1g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddutddttddtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedfmfhrihhs
    thhofhhfvghrucfjrghughhssggrkhhkfdcuoehkrhhishhtohhffhgvrhhhrghughhssg
    grkhhksehfrghsthhmrghilhdrtghomheqnecuggftrfgrthhtvghrnhepgedtjeeiteeg
    hfeutdeutddtiefgvdegteektdeutddugfekleeugfelteffjeffnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhrihhsthhofhhfvghrhhgr
    uhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtthhopeehpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehguhhsthgvugestghouggvsggvrhhgrdho
    rhhgpdhrtghpthhtohepthhoohhnsehiohhttghlrdgtohhmpdhrtghpthhtohepphhsse
    hpkhhsrdhimhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghp
    thhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:JepcaWlYuGVulayyWo_r36jhXO81iGwb1JqDRGAmcZ_40yov0XCMMA>
    <xmx:JepcafUkWQOYJng7eEztQ6F9y4n2d7MXERjzNAlLbeF0SE5Fs8P0KQ>
    <xmx:JepcaUuXGkGGeIzobfVkSRjuBIjNOLoXT01zzhE7a5UF4fDDSgILHw>
    <xmx:JepcaaYmYCNwCF9-Xb1I6-ksRExFbEmFtR18nMnQ3gEUGndPfpziNg>
    <xmx:JepcaeUh-_I3pGL_JURAOmmDx18eV5HCBm0gJ1DTG8q0uHEwizpZ_rOK>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 20F1D1EA0066; Tue,  6 Jan 2026 05:55:32 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A6Y4akRbTe2J
Date: Tue, 06 Jan 2026 11:54:39 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Patrick Steinhardt" <ps@pks.im>, Gusted <gusted@codeberg.org>
Cc: git@vger.kernel.org, "Toon Claes" <toon@iotcl.com>,
 "Junio C Hamano" <gitster@pobox.com>
Message-Id: <39eb6099-49ec-4ebd-8347-e2f2e18f3e8a@app.fastmail.com>
In-Reply-To: <aVzcyYjR8l-xXD4L@pks.im>
References: <09870987-ae2f-44ec-b8a0-1654f598b5fd@codeberg.org>
 <aVvSwkK7RdpFDaVv@pks.im> <8e6dd4d7-6e0a-477a-b10c-8571d6b7da4c@codeberg.org>
 <aVvWDDtBeJMIF3F0@pks.im> <eecb1c9a-4dc9-4666-b2af-1e3478109db3@codeberg.org>
 <aVzcyYjR8l-xXD4L@pks.im>
Subject: Re: git-last-modified on bare repository
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, Jan 6, 2026, at 10:58, Patrick Steinhardt wrote:
> On Tue, Jan 06, 2026 at 10:42:55AM +0100, Gusted wrote:
>> On 1/5/26 4:17 PM, Patrick Steinhardt wrote:
>>>[snip]
>>
>> Yup, git from source works! Do you by any chance know if 05491b90ce is going
>> to be in v2.52.1?
>
> No idea, point releases are typically done rather ad-hoc. Let me Cc
> Junio though so that he's aware that we might want to pick this if we
> ever release v2.52.1.

`RelNotes` says that this will be merged to `maint` later which points
at tag v2.52.0 currently.

     * "git last-modified" used to mishandle "--" to mark the beginning of
       pathspec, which has been corrected.
       (merge 05491b90ce js/last-modified-with-sparse-checkouts later to maint).
