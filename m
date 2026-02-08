Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2C7A2494F0
	for <git@vger.kernel.org>; Sun,  8 Feb 2026 21:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770585228; cv=none; b=FO1wo7ilYDK+fESKfJPMNRq/8jOv8B7T7LQCM08Nr88xkujlyNk7JlSuYhpqGYAjcr1JOZAWagg7A/SOfqP2ipF+QgCd0YY2SvelDFhv9Ca6fOnnUgp9RT1aRDlra0j7QUjaiEKkUJ/MXtS9uTlf6Pt5ojW89khbi4z+kt7ujHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770585228; c=relaxed/simple;
	bh=IUcbqfUxbGYkfCTsgoxR6sWTYN5HGakyhMOFVEZnni0=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=EGD7lcwydrIF7qiC0Zfa6jcE1fhF0x7zBtS7M+2W1D804AFShSXP5HTGhDRViVGMMBTH9BJA+1cC9D2afadH/O6Q3M0d9FIrSIqF2z4Je0o5tLPrSEdiX28mUFFI8rBciac03/dP5Ep1P2gfbt4QFAsC0gyts5yZg3DBxvVv+HY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=jrwRPvXv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=uJSL6/5k; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="jrwRPvXv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="uJSL6/5k"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 20B587A00C0;
	Sun,  8 Feb 2026 16:13:46 -0500 (EST)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-06.internal (MEProxy); Sun, 08 Feb 2026 16:13:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1770585226;
	 x=1770671626; bh=8PRRLmN/791EtKSEdnxCCDaXKJB4UG89MF2NORypLus=; b=
	jrwRPvXvihuDzjFIzbMeBC/0mQVuTQz99ubc/RFvYaHKrgH/x8MfTqlqh7EtYP2B
	2OYGcPAe2qICUJL6sO3sosFUaNR3xvBWZylKuqOWoZ80aILHq295bSHGrHSGk0KA
	ztQuO3YXdlgumQYRV+vhA1NjVtQORseSUYblrfU0QEJ/jplGe9I/MOX84nItIvyU
	X+OLh94V4CEu/3E9ifTsIcN+ai2J+QWhJ4MHGSLSkQ3gFEhbJ0iM0k/A0Scb9GZd
	j6U25HLtetkEgowmxYJPPtr2Wu/Mf8x1RKvlhsqyjBewuUCY2h96P1prcTjf96fK
	kQvKpWJswUmNcfYgm7UYnA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1770585226; x=1770671626; bh=8
	PRRLmN/791EtKSEdnxCCDaXKJB4UG89MF2NORypLus=; b=uJSL6/5kBeX/TpZWF
	Ed9g4+V5l0zAfQ9ieSDpU80rbWVZqOaiTk8WXuW1xH70xVNmaAc9CeSKcS++l+4r
	LF30106S2dvNNj16gEldaooO36EdObjQLv6Rw8/x/bIILKLFkOATR9KZ1jSHaQd2
	xymcCzuHkzD6/z1uf13At+1oAxm48tZMje6BE50M1+VrBC2UpaLxkgBu2+bYPrPB
	HmAj5WUnBD666c8unU+apBD2ali0oxg0T+hwunqbHmhSPDW+/6hrPYIryae4xiDw
	LqjTcuCthxLfoayYjxnujm7k+WLGaum9XxySVOS08mzv/l5KN8ovSn3nWoqm7oTw
	+Y5Bg==
X-ME-Sender: <xms:ivyIaRXJTEe1L5_CfaFjW_QOvOmliRAI2vPIsnL5xQy254Kpjm3ZR0k>
    <xme:ivyIacZPRclkHaP46hy3_wVasaK07j0wDS38G0s_BZfrCWlNuIFAzHW_YqzoKlLbB
    Dh315nmohEtHYaUl_WcMJdDQy_b7VragDdj2DqV6zSopkYDsNcZ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduleegleekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefoggffhffvkfgjfhfutgfgsehtjeertd
    ertddtnecuhfhrohhmpedfmfhrihhsthhofhhfvghrucfjrghughhssggrkhhkfdcuoehk
    rhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomheqnecugg
    ftrfgrthhtvghrnhepvdeigedtgfetgefhffetteeludevheetfeekffehheefieehudek
    veelveffhfejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhm
    pdhnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghr
    nhgvlhdrohhrgh
X-ME-Proxy: <xmx:ivyIaYCf36w_NQn8mXDEIutxptvOKHfyjZMJVM5bo9gnufaqnzcB4g>
    <xmx:ivyIaYcyXrYjyCdnkxHiHzBKSk3Tw3Uu5Ii7KrlLGnEd8Ph3yyMnXA>
    <xmx:ivyIaTJLu9cWuyNPsDKPPi4EuqR0Q3BguyprKxsX8lgwMDI-ROskZQ>
    <xmx:ivyIabfb_WvqXyCRDBtqKfz7897hEeCd8Cz66FBV2pUnhygD8KkijA>
    <xmx:ivyIaUKSSXq94HrnBXm2t2WXXRTo9wgryMQMwyMRdobdOveMUs4PY5AK>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 97AA81EA006B; Sun,  8 Feb 2026 16:13:46 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AeRUUZKvU2Z-
Date: Sun, 08 Feb 2026 22:13:21 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
Message-Id: <9d452bb3-104a-46ef-84fb-ec3ca0be990a@app.fastmail.com>
In-Reply-To: <xmqq7bsob0wo.fsf@gitster.g>
References: <xmqq7bsob0wo.fsf@gitster.g>
Subject: Re: What's cooking in git.git (Feb 2026, #03)
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Sun, Feb 8, 2026, at 00:15, Junio C Hamano wrote:
> * ja/doc-synopsis-style-even-more (2026-02-05) 4 commits
>  - doc: convert git-show to synopsis style
>  - doc: fix some style issues in git-clone and for-each-ref-options
>  - doc: finalize git-clone documentation conversion to synopsis style
>  - doc: convert git-submodule to synopsis style
>
>  A handful of documentation pages have been modernized to use the
>  "synopsis" style.
>
>  Will merge to 'next'?

This is ready in my opinion.

