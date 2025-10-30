Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8379E35970F
	for <git@vger.kernel.org>; Thu, 30 Oct 2025 15:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761837353; cv=none; b=MM+mSoK+M9dn27wXEVnO9eeoKPmPtwQ/BisRpa8qOyxMql/yVCs9MYgHq02tVEntDfHWKYt6XsDNNdGh+mrSxSnt09LLW6AWQ8jAJhF1y28a3YyHAzmo6OinwPp5eZ3lNiogyfE8STVZZyEZaiX29OxPFzJk5wFhwb9ZXaF76DY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761837353; c=relaxed/simple;
	bh=XZIFzgMOHb5vQF1QRvynnzj7Np+Ea0C66sy1/n0QQuI=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=bovuFzQBOnTeJicSXk+zt8HkCRXtVX4pTOFm+jRaC8CoZFxeQQmOxcpCOUfoRA2lrivpQV57eDnzlJMiHulxlQ/YUOidEPArUoUyHHmDdpGf+YDcCPnYRpsxHdEWeLcLou7qRQCZWQ9DW1jddQpk1v+j8fNsedEh/BWdAWSGTNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=m7KxWZS/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kQxoer/l; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="m7KxWZS/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kQxoer/l"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 804EB140015A;
	Thu, 30 Oct 2025 11:15:49 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-06.internal (MEProxy); Thu, 30 Oct 2025 11:15:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1761837349;
	 x=1761923749; bh=MFJv1AjHbACA/blZ1uM3hhWYhZB9h9Y9CsMY92AcOGA=; b=
	m7KxWZS/yPdU6QITPQTX8CmHyIBJx4Qkn5IwOhqbTAJkhMtWbHSpRDGQwO3Ru9G8
	Hz7hLd2ESlYIBgyraFqpUXIk3vSiAj5DTfgE9dPDXGlfdcXC/SCwFs5cJx8YLaNV
	Oam4G4hjezvqQ+QdYssffuE0680VvkxZhhUy5SkTiJhUWlR+F7UNfKtYFtsq7puJ
	Tk3da/qluQr6nQ/CqkGuw5Z7ieBB/SEmuB/SRwt/T+k9uGSnfE0KjWOxKxMoWv2z
	eRltqK68ctoUg+1KLvJ/E80elZPGjLgFiC+MCtMGt+v1c9bC3scY0NtInkL9wc6k
	VeF4UT11a3fIEax+fLkY0w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1761837349; x=1761923749; bh=M
	FJv1AjHbACA/blZ1uM3hhWYhZB9h9Y9CsMY92AcOGA=; b=kQxoer/lbgjWUaVb3
	+HUYc2FPO72kSn3HT94aJuNqzulSaTiwGieS0EzWpwYgZKMorvkAFDFAVVk6dFme
	Btde3KrLn8QAQ44NY4pRko9SuiIIia8GLBIoG917ucbnAMDov14imu5ERutqqTF3
	3ABmR6csKseWGeKLMq0S2BWAE2EMcN3gRRw4n96KHFI3Tk9z7Ect09h8HGN5vBSD
	AGGzvlJxtubsROX4gbavp7/Gvf0PfJi4RGMm2NeqKROZUyS/39ZQqZQYvdQ5XlTj
	bpDJDLoETQp/wH0q/jpCn+hGum43VBgL46no+8QAvn2SpIU0/5vUwwESWQ0SD1A7
	VXoMA==
X-ME-Sender: <xms:JYEDaVLuBu0QezQ3oDp5s0VzCncRfrUiYh0NIqJRJ0CBeajJbXASS8s>
    <xme:JYEDab_4N9F0-RLQQ4JCHKayc-BmHdMA8xlwfZUVdmk-0h-u4ixqRYI5tybx6QQPD
    c2ItSpBlhd6SzwMmqRLK0GqvaxqpVF1eUkI9uwjoFZBy8O8KHIbvg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduieeileegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefoggffhffvkfgjfhfutgfgsehtjeertd
    ertddtnecuhfhrohhmpedfmfhrihhsthhofhhfvghrucfjrghughhssggrkhhkfdcuoehk
    rhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomheqnecugg
    ftrfgrthhtvghrnhepvdeigedtgfetgefhffetteeludevheetfeekffehheefieehudek
    veelveffhfejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhm
    pdhnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehrsh
    gsvggtkhgvrhesnhgvgigsrhhiughgvgdrtghomhdprhgtphhtthhopehgihhtsehvghgv
    rhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:JYEDaf2NEfVIdlQHsKZyF3tZRZXd9l0KRaromaMvemchf0T-6tyjDg>
    <xmx:JYEDacALIZEgZyLu-Dxh5B1wtOwHpK3RKxChALbhh8Uc6XZwP3XYwQ>
    <xmx:JYEDaXf-ZrrVfwBpOSRXA3dslF1rTrv8lFz8_L6vrqX8iBVaS8eBqQ>
    <xmx:JYEDaRguxUuBVRGvHwasCnhlyBEZnW3VkOMAUQICK9QlU9VEM3fOwA>
    <xmx:JYEDaVZ9lLATMdIRxvVSNNC2yp741Y4jP8J5mLQTQsFiwiyF6MC77ASQ>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 3165F1EA0068; Thu, 30 Oct 2025 11:15:49 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A6deAsQV7uqg
Date: Thu, 30 Oct 2025 16:15:27 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: rsbecker <rsbecker@nexbridge.com>, git@vger.kernel.org
Message-Id: <729f9bbf-b75b-4161-b8aa-505ff906bb8a@app.fastmail.com>
In-Reply-To: <000d01dc4831$ff049500$fd0dbf00$@nexbridge.com>
References: <xmqqo6psjq2n.fsf@gitster.g>
 <000d01dc4831$ff049500$fd0dbf00$@nexbridge.com>
Subject: Re: [BUGS] Git v2.51.2 on NonStop
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, Oct 28, 2025, at 18:40, rsbecker@nexbridge.com wrote:
> I have found new defects on 2.51.2 that were not present in 2.51.1 when
> building with OpenSSL 3.5 (probably unrelated).
>
> Many failures in t7900 resulting from the use of test_subcommand ! as
> seen below. This is run in bash 5.0.18:
>
>[snip]

Would it make sense for maintenance releases to have a small release
candidate pre-release?  Both of these maintenance releases have had
issues.
