Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18DCE171E6E
	for <git@vger.kernel.org>; Sun,  3 Nov 2024 15:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730646813; cv=none; b=QBWnkQQBM15GCToVqqzclzzxM7koRAy2VesimaO48b613QeywgNuWURngr9HLvQqm+9uXv8WtKU/zw8xljkk0fNoI/eUxFF9FPAZZ2m7S8CHMf5M89omOdhgjfdBVw0OLMaPca4vks85BM7X4gmVnXBYUwCT5taowBLhk7RoLtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730646813; c=relaxed/simple;
	bh=rKC/auNHWRI81nsSVyQt0WjGd6Tr3v5vCvOvCHcQu7M=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=C4ZeZEN/bIEVVCnaeVYPHGoi+UgEy69XVbEYW1INC0Le8pSiBLaGThaUnzBvLGltv5ysEQnKL3gLqcZI22mcScq2Nra9xzTeaDmpwJaqIFKzHWOJgZfeTwHkUBGgYgO9A+Qjk0RzVbEeekheFdcsa9L45FpwmsVnJlZ8GzlWwVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=h+fxxucq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=d/WtlmrO; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="h+fxxucq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="d/WtlmrO"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id E28212540110;
	Sun,  3 Nov 2024 10:13:30 -0500 (EST)
Received: from phl-imap-09 ([10.202.2.99])
  by phl-compute-06.internal (MEProxy); Sun, 03 Nov 2024 10:13:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1730646810;
	 x=1730733210; bh=tY4FcalD/NJcQWLD6PZlqaBJBaXtCfgB7s1oJpapuk0=; b=
	h+fxxucqfF9ClU0TIZjHqYINZCtxtMFdBsK2jBHrmXKxNQLKBGx/oJv9d8xp11Wt
	rGukklSU5BUShVjmjxsmS+nBY4oCccT/DdNBJn7UVlZgy0aY+KG5dIxLkpi6NRIJ
	NUCIGd0jO51Y81mZh8pjHR/cfPfEyOfL3o7nP60RsJ7yzd3OJdvDZccs1pNjC7wT
	yrlFJfBI62bzAueeSp8PmuyzsliKCO15xkX6dtRra4hxMFnkWbPyAAugJyvJMP+E
	MzU9QHp359oM3Ux9dNSJOqfYXvq5iBFM5xJZTSoe0diRlq/YnEGpqNhTD0YgQEpu
	p63ytCETFXWuaE+d0NH0zw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1730646810; x=1730733210; bh=t
	Y4FcalD/NJcQWLD6PZlqaBJBaXtCfgB7s1oJpapuk0=; b=d/WtlmrO69rBCvETk
	YyuN6zpPSCS5Stcooq0Cw5ElkZTzfmip+uOGT8ihvKiNRqMO5kkppFxV81fj4/IZ
	kPOBxybyXOVaWUp3O/wEV6hGGZLLDyu/U0rI85k5YeS4v0DLDNx7nW+HXxqe91cw
	2/9rBaAUWCLr1y+a3w+YOoG+Z3CIGQH/xH055JIb5PUTM1yJvhOFFqQiRJlw9qkf
	wzIHdLNC+ueG8fW7dXKLXgh0JfpN8cpZLoAHivhhbrX9kAf2iMV/uNVwxIQE2GnN
	ZMe8qaPaD5So0DLrz8f2MD2Dta4yQiZnLP2HQOeN3P7dhyTk3VckWL+Ph+bnNEhH
	prj0A==
X-ME-Sender: <xms:GpMnZxCsthaGoVT5YWSe7gu0QyiMLqZz5xRSby42X9VoVAGPLgEAu4Y>
    <xme:GpMnZ_i-E5Fm8tS5MZDSjGi3uGjmjXdcDec7e6imMaabWvykirFCbjIAbBIUgXHxe
    0UeEfsomgY9Au0cTg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdelgedgjeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepofggfffhvffkjghfufgtgfesthhqredtredtjeen
    ucfhrhhomhepfdfmrhhishhtohhffhgvrhcujfgruhhgshgsrghkkhdfuceokhhrihhsth
    hofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmqeenucggtffrrght
    thgvrhhnpedtgfffteetudelhfefkeehtefggeefjeevieekfeefieekkefhveeiledtke
    fgueenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehk
    rhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdpnhgspg
    hrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepmhgrrhgtrdhs
    thgvphhhrghnleeisehhohhtmhgrihhlrdguvgdprhgtphhtthhopehgihhtsehvghgvrh
    drkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:GpMnZ8l3-5bR5snIF0fuRuJAnubTLOYlc6oATcByzzbx7lsNJbZNag>
    <xmx:GpMnZ7wC4DbKprhuDBXB7tPczJfEcHAuhcNN_o7ZXzJBV5IigD38ig>
    <xmx:GpMnZ2TWaWld5L-hTyClGZeNFYgd1WaYVpm4WLD93cxOXTCgsKhenw>
    <xmx:GpMnZ-a8xNWMwx6oRS_6G2EFVpeDmbpZjmi1cvOAJUKJnMaIY9BTKg>
    <xmx:GpMnZ5IpFnlZCTY84pKUr_nNrud47FRkM2A5mCxReYwh_cp-ffQeIvMG>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 88BC2780068; Sun,  3 Nov 2024 10:13:30 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sun, 03 Nov 2024 16:13:10 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Marco Stephan" <marc.stephan96@hotmail.de>,
 "git@vger.kernel.org" <git@vger.kernel.org>
Message-Id: <89796e97-e5e1-4668-8b81-692579547bbf@app.fastmail.com>
In-Reply-To: 
 <AM0PR02MB4980D186BDC087336C760132E6502@AM0PR02MB4980.eurprd02.prod.outlook.com>
References: 
 <AM0PR02MB4980D186BDC087336C760132E6502@AM0PR02MB4980.eurprd02.prod.outlook.com>
Subject: Re: Git revert cannot be aborted if the repository directory has been copied
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 3, 2024, at 02:25, Marco Stephan wrote:
> This consistently produces the error "error: Entry 'test.txt' not
> uptodate. Cannot merge.". I would expect step 14 to work regardless of
> how the repository directory itself has been created. Running "git
> status" or "git update --really-refresh" fixes the seemingly corrupt
> data and the revert in progress can be aborted.

Okay, I missed that `git update-index --really-refresh` previously.

I=E2=80=99m not a technical expert but is there a use-case here?  Or did=
 you
find this by accident while doing something else?

--=20
Kristoffer Haugsbakk


