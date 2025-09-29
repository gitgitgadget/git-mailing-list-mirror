Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E98F1E1A05
	for <git@vger.kernel.org>; Mon, 29 Sep 2025 20:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759176777; cv=none; b=qyBrvIJYKx5KYVyvvT1Fz9z7Mo0lJ4oqxYBbgEpND2kKatGfvaoMp7MzmA+pbmX5ZvZA+yAgHB2JDJ48HI3s1McEhEbC8fa55PP5E2Hwdfowh4ZHDKi1Zdr3aHhmS9nsyrcA2DDkMVa9xh28O4t1fXDuLbmPDY041+BJ5ajWwsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759176777; c=relaxed/simple;
	bh=ldIQEILMwxDwdrz1v2aKBny7azwfZQaxmvaa1Mnzh5o=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=kjyDsteUayKOl6ayaDdoKLIbRuo63yLqbnzVFurjE6bWpheXY3aFYwb/FtCHBhYUjMq/9sI+NjhPLsmtVd98I1RFeu0V1C4nJMUCjYC7zcj57veqV14m7dHJ7msRsqDWFoRJXhAHjTvunj5AUXSo/WaJl554ZpTKsNW5RXJEx8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=BxTnFgGa; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GEK0fzKi; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="BxTnFgGa";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GEK0fzKi"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id 7FE8BEC017B;
	Mon, 29 Sep 2025 16:12:53 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-09.internal (MEProxy); Mon, 29 Sep 2025 16:12:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1759176773;
	 x=1759263173; bh=qbcC7Mxm8ikdja8qWhFmExmEWm7PVqA71J1mrDRn1mk=; b=
	BxTnFgGajfFJBZEfWFhegPAb01YOQo8wh9wpC+NIA/72n4zSId6VH6fkJlMh7TyP
	cjM1gsAGFtshGbT9B8ClVHNzit8I8Kf+nPPSGdo32OzjKAQOWlPBow6jQnTfkT/p
	o08Zf1cGFb4RpIkBZ+5x25S5VS0Hkhx3kfQ/aeXtBdPiwzidyhMIcMLG9K1Mh7zS
	s/royM74kFG91MyIU/wdsgSVHukfzJ9D23K0NzL99qE6mwttKMEMkXTyBrrjb0WQ
	Li2gUMvqF68pXFR+VKzI0ObOgMRGXbLPLNbef5KH+DPmGUblc+R3wSnr0yd7BVJJ
	/IamoVDBhRBr9LaCwk6Auw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1759176773; x=
	1759263173; bh=qbcC7Mxm8ikdja8qWhFmExmEWm7PVqA71J1mrDRn1mk=; b=G
	EK0fzKi8UNtsEy3FbJnVPpcW7QkTNyDog9VnsixyVL5YPw0jYo+TxaIUhphuU7gQ
	w+btsmPfBqnx+wos2prUiPHHrw4Bn7ykOMDJvhcS59xOglkhGk0oBnWRSwgEhH1W
	PeswgtP7BrFeGN+OuNJvATySSAH8BV1JPIwXyIuNFkoF/+ad6nNJd13ISckGO1kn
	K8VMqXkGdri+PWB6LjEQd5JrfpyTJUnkdVVf0YChC1Ivf2j9JJqNoQexwnIVuPEB
	0Sip/8tqGrSrywmd//Fj1CTGt+Ucjnw75WOk3kAqrY/U/U3niKcR1hEaEbSCInrc
	FfUUYeozJUAQg17VGrsTA==
X-ME-Sender: <xms:RejaaOS3j4BGAKj44V21qHoVrRtlSei0iiCsukpYcxogCHawoGFakNs>
    <xme:RejaaOn3JvYRnnAKknc8-N_kxv37QpB5ZGDeOsUY-AcwqiGzf62qYhRtmw0AsGrk4
    PisFA89WkHiJw4hvz7pbqgbsSWQQBSN6I42qEraB8lgxUcnLQ9f4Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdejkeelfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhepofggfffhvfevkfgjfhfutgfgsehtjeertd
    ertddtnecuhfhrohhmpedfmfhrihhsthhofhhfvghrucfjrghughhssggrkhhkfdcuoehk
    rhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomheqnecugg
    ftrfgrthhtvghrnhepgedtjeeiteeghfeutdeutddtiefgvdegteektdeutddugfekleeu
    gfelteffjeffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhm
    pdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdr
    tghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:RejaaBu_D7PIeBxiII1ArOykPKeaXMmMrIUEWGD2gknE3SNhPWGTGA>
    <xmx:RejaaCMkFePAFVSjLRyBu1OPb8zbG_AY6MUvf3eInOs7cRL-SzxP7g>
    <xmx:RejaaH1QHcPFQQbVaY8qmH9tZJkTSed7xfSrzTmFcnTeLYJ61qFKow>
    <xmx:RejaaGMUmQ2R9S2DPdPGDFDMOQFiUgM5DVpZ1VB16s0gtXNZ4lb29Q>
    <xmx:RejaaAjH1gMPxYYh3lKMy66r7P-tYG58RvriCUCcYrVnCmbDw6lXmfut>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 17A271EA0068; Mon, 29 Sep 2025 16:12:53 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A4Ma-RQ-GLU7
Date: Mon, 29 Sep 2025 22:12:31 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Taylor Blau" <me@ttaylorr.com>, "Junio C Hamano" <gitster@pobox.com>
Cc: git@vger.kernel.org
Message-Id: <b583b17e-96a5-4f22-8cc4-acbd3dfec82b@app.fastmail.com>
In-Reply-To: <aNhX9AJ/zq4IYhmW@nand.local>
References: <xmqqldm0am4b.fsf@gitster.g> <aNhX9AJ/zq4IYhmW@nand.local>
Subject: Re: [RFC] How to accellerate the patch flow (or should we?)
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Sat, Sep 27, 2025, at 23:32, Taylor Blau wrote:
> On Fri, Sep 26, 2025 at 03:24:04PM -0700, Junio C Hamano wrote:
>>  4. While the above cycle is running, the maintainer may queue it in
>>     'seen', for two purposes.  (1) not to lose sight and forget
>>     about the change.  (2) to catch potential conflicts and overlaps
>>     with other in-flight topics to keep their interaction manageable.
>
> Perhaps a third purpose is to let the maintainer (or those who use
> and/or build off of 'seen' as their daily driver) detect any bugs in
> that topic, or via interaction with other topics in 'seen'.
>
>> The time taken during 7. is pretty much fixed and unless we are
>> willing to sacrifice the quality of the end result, cannot
>> reasonably be shortened (note that this is based on the assumption
>> that "find any remaining bugs while it is in 'next' before it hits
>> 'master'" philosophy is working, but we have never run experiments
>> to shorten this to say 3 days to see if we see more bugs on 'master'
>> yet).
>
> I have mixed feelings about this. On the one hand, I am a little
> uncomfortable with the idea of shortening the time in 'next' to fewer
> than 7 days. I, too, have the feeling that having more time in 'next'
> gives us a greater chance of spotting bugs in a topic that is otherwise
> destined for 'master'.
>
> On the other hand, how many people are using 'next' as their daily
> driver? Of those, how many are actively looking for bugs in the topics
> that are in master..next. And of those, how many are actually triggering
> unique code paths that would expose those bugs in the first place?

Theoretically all the projects that make heavy use of git(1) could run
`next` (and `master`) as an alternative configuration of their
integration tests.

-- 
Kristoffer
