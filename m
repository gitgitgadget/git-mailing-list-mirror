Received: from fout3-smtp.messagingengine.com (fout3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E9A87BAED
	for <git@vger.kernel.org>; Fri,  9 Feb 2024 18:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707503238; cv=none; b=ZnoeyvbQmKaTmFQH6fipYtfm4k5pYxpGPiUFidbroM1mUZJZ+pup3TdffxnftQPTDDJJHyxBREML2NkG/lFJWN45ukPobv3wKsGM5mwya+ZSnt+j3YKcT5/PVlQjsCH3GAtpcoOFYuFX05LKkTPrSgXzDvocpoRGhqCwAJQ4gSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707503238; c=relaxed/simple;
	bh=zhGTghxUDROvna89wNfkIRz/AWNDb6JeDI36JUv2i6k=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=s0ZDIA9tKlnHZaqtHjJFnlO1/5RwjP4xPl4siCcEBl8V/1CcQyl7qKS+QYAurzyUkySv4JhUkRv2fQLcAppl/63hq4PntUJvMmtViDLC9fQ8+aZa5fkqRboRhPCH8bYdcXjEcGH1w0/0yStdExGp/+GIA+mGmMpIscFFalu/KRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name; spf=pass smtp.mailfrom=khaugsbakk.name; dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b=dZIyj0fa; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=djbkxSKx; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b="dZIyj0fa";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="djbkxSKx"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfout.nyi.internal (Postfix) with ESMTP id 4024F13800AD;
	Fri,  9 Feb 2024 13:27:15 -0500 (EST)
Received: from imap49 ([10.202.2.99])
  by compute1.internal (MEProxy); Fri, 09 Feb 2024 13:27:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1707503235; x=
	1707589635; bh=wHILW9ZGlWqzUvj+JtOhiRuPQCmI0j9NbUkjF72wKZk=; b=d
	ZIyj0fa8+mk0c+YEQ+mr9VlLmmmNOhnm61FAIwIkOdFklW22yzp6LmnoHl7fJHYz
	XijrlCWQi8Gzz/XDMEPX1ei7YRqVuIwmDQpuzEpokGeqq4BqFrE47cmM84cKfBtI
	3dk9QB0D1I2Vvo9cM6mEcDvjKm19cVx6/dZiB4/LBmsLN9okrR6uvFmiinwDhFnN
	pjncZZjDJsCzbQkKzegsrZry+BLdVzFuIUYy0Ho2ySmi0U0rKnjieRjAqBsOB/4Y
	RwPHPk5dZ4EISIUP4gZoWBuopJw4wNIhB4+lR1CqsQKb6gspSbaiNnWMI/QAZ/uz
	A11xDSaYggA0dFOtdyzWA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1707503235; x=1707589635; bh=wHILW9ZGlWqzUvj+JtOhiRuPQCmI
	0j9NbUkjF72wKZk=; b=djbkxSKxUbdgsxYPW1R51PuBVom2CqHCIrgHVll6Iwm4
	UbI+mD/Ii3Gx4WQiqbva+ryfNL44/ynWCU8DGNar67X1qmurWHUhabbsNxwFYF9a
	/ZgcYIdv1kjPwTSxaYFNGxgaE4hlyqXCyW2muz0lb0UxaER2O/cHxDU389Palqfi
	wmV+oRBiQO93/ukYV29B6emSz0D3QvWKMMlO3LIDMGVlVlWJF1k7GfcSKwGL8idD
	3W2EbkNzu+F8kHZBTCVG8o8qe73XaYwbjFgmHxBIknfvNMxUhWkxf3JXGj5CETu3
	R1vBvS1q4I3e56I6bK1M17eD/y/efNHKb3okFD4EmA==
X-ME-Sender: <xms:g27GZVZrlw8n9IpYGBwbR_pH3-fk6Ar-LsBCTVXbLf3aRMgKRCd48II>
    <xme:g27GZcYTJn0C82BnJCfWrIte67CMeC3dmuSvzwpV5xi4Yo7esUJz9KHgG4ei3qOD_
    3NILASRnAU2_91bwQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrtdeigdduudduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedfmfhr
    ihhsthhofhhfvghrucfjrghughhssggrkhhkfdcuoegtohguvgeskhhhrghughhssggrkh
    hkrdhnrghmvgeqnecuggftrfgrthhtvghrnheptdektdejieffleetffehieehueffgfeh
    leeufedtjeekueffgfeihfegkeffffeunecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomheptghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgv
X-ME-Proxy: <xmx:g27GZX-n4mTyqj2jJYdO7-cIOx1ii_JomoZdN-7kDMiJhsbvhBuVig>
    <xmx:g27GZTrX9GbdAYobVTPyMmHn7IDPcjxpkzXzXeODv8sZu2sx1R9WuA>
    <xmx:g27GZQqEWcGl5KCtRjIWoQfGjm5eudHjMmHw0AFaFbVs6Cr2wxlIXg>
    <xmx:g27GZdDP9ZNX1QJkGCeyzahjfdGR1ATtqDduyEWOlU2-9jvrdH5MGw>
Feedback-ID: i2671468f:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 1B4FF15A0092; Fri,  9 Feb 2024 13:27:14 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-144-ge5821d614e-fm-20240125.002-ge5821d61
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <19119aa6-9a8c-44c6-af79-0ea6a8bcb181@app.fastmail.com>
In-Reply-To: 
 <76688ed2cc20031d70823d9f5d214f42b3bd1409.1707501064.git.code@khaugsbakk.name>
References: 
 <AS8P189MB21977ACC4866D9836DA29082BC4B2@AS8P189MB2197.EURP189.PROD.OUTLOOK.COM>
 <76688ed2cc20031d70823d9f5d214f42b3bd1409.1707501064.git.code@khaugsbakk.name>
Date: Fri, 09 Feb 2024 19:26:54 +0100
From: "Kristoffer Haugsbakk" <code@khaugsbakk.name>
To: git@vger.kernel.org
Cc: "Tiago Pascoal" <tiago@pascoal.net>
Subject: Re: [PATCH] column: disallow negative padding
Content-Type: text/plain

I forgot tests.

-- 
Kristoffer
