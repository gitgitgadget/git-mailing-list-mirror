Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 364EE8F4A
	for <git@vger.kernel.org>; Mon,  6 Oct 2025 21:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759787239; cv=none; b=W7uGyl2QmkwwBsjTqgSxzkx72AXunVApxunRFs+E4gTKFTP4WF2YATRgm7l1T6ReiIPSWNsjRsERBet4iStdEKlkPKaStKGmrRpc5I+fgtKBJIj+j127vB4Noq1FTw4UVQ9ubYCEG/SqfQ+1hFHWCVzPJeUv02jAqFW1ru1bCW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759787239; c=relaxed/simple;
	bh=dpGQvKEYOAZqi9QGrDGk9giOeHQ6lcOhbKLJB7LPIJ4=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=hL3AB2nSj5qp0siOXZYmonVyHI63rMsh5vN5zjeJevqQcmJqwiYgjTTr8d6Bc2tgOHExmX+4J+VA69bxwEY9SZJfDwneHZTFJL/IgMiFeVuDCiVxoWRioOSVnUIwAgDDX9ESnHYKnqalP0zCYKrikeMYcML3aIMtAsRcap+3wa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca; spf=pass smtp.mailfrom=jvns.ca; dkim=pass (2048-bit key) header.d=jvns.ca header.i=@jvns.ca header.b=Ee9RSim1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=R0fmLnJo; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvns.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jvns.ca header.i=@jvns.ca header.b="Ee9RSim1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="R0fmLnJo"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id BF17C1D00183;
	Mon,  6 Oct 2025 17:47:10 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-04.internal (MEProxy); Mon, 06 Oct 2025 17:47:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvns.ca; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1759787230;
	 x=1759873630; bh=nIk8YYxHpAMCo7Ox4LmAb/cL02JSoi2dV85DTy2SNeE=; b=
	Ee9RSim1v0PD6QK1QFoA2FLRFacTXMHIgRjqsgkQ/kXmYiUYjhXs9TbJat7mFkAj
	q4HHUH6enByrgTS7T2+XPnD/Gp/kU3G0pxisJVdVX5wzmU4HwtPfPPPOEGuIkPkB
	zqQo24chUqq29L7a+XXffoG/8UuvZZPY++DBUbNUqNYF4xIY9ZoXMGQxI8gG9jiz
	FGvXDKdpuGxbuk2+XKhJ/Cl8XFPTQMZEIKji/7B0qX7aPVydw/RYw6WMspCFZRn4
	stCnRhjDuz6YlO2jY6N3VeET6WFJkU86mO/FIllRF3AKcA0Ez2RYmMzlpnutYvOI
	LQGG2EgLY+uSZPS+1W0/wQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1759787230; x=
	1759873630; bh=nIk8YYxHpAMCo7Ox4LmAb/cL02JSoi2dV85DTy2SNeE=; b=R
	0fmLnJoavUrOyX5g4xviT7rh/6HKj+pCbQnw66SKJb7ixCaLHJFaAB4WqrX7NOa+
	7ksixktqaxZRTA4aZSMzwOUNTJ4bYVqHalfiKYCSz+L3XtKcitV8ymeOFfuixH2P
	8b7/MovXsDWo3IIeSt8qm6JOLEWqUL90TQAbGtbsjvf5wME93dGUs5JVJpjQ8Q55
	ZfazCH5TJWxN3NDqHsWLxSh4DN86bPXXKQ9VkfugsuEAD+nK3R/hM4J7VfYSAE6w
	mqfDpuERsE8lldn0VUdVPqeqHirY4KPXxq/wQV4HnP16tv9B0CoyqemtxoGrYi3X
	6m8nONZo1IWxtn2r+aAhg==
X-ME-Sender: <xms:3jjkaPVcGrQGceP2AFPVTFraPcv7rWnmEcXsvdBEEQ7sMlPgUm7HIw>
    <xme:3jjkaCaGKGKrWOv0OOcT9x0so8DTJ2K0oy3VN3B7JtWohC7wqHyZ0dDJfrXa1PN0T
    v_tGBK6D8sn4loSaJO2H8wID13kPyaeEnXIY8UaCcTsw33Wcp8nG7w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdelkeeiiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthhqredtredtjeenucfhrhhomhepfdfluhhlihgr
    ucfgvhgrnhhsfdcuoehjuhhlihgrsehjvhhnshdrtggrqeenucggtffrrghtthgvrhhnpe
    efieeigeegtdefkeejgfdvteejfffhveeuuddttedvjefggeevfffhleegvddvudenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehjuhhlihgrse
    hjvhhnshdrtggrpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgt
    phhtthhopehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtg
    homhdprhgtphhtthhopegsvghnrdhknhhosghlvgesghhmrghilhdrtghomhdprhgtphht
    thhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehgih
    htsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:3jjkaM8zX7fDRu9-CtMcuRa8On-p-0VUG10g6EVFRZYlKgBDXuWHCQ>
    <xmx:3jjkaCgXCbrFksjyl9vmYSGyV7Lz4CFksFVAg8A8QXJ4WmfQuFDfXg>
    <xmx:3jjkaMcBzhZ0OXDfi8fOQei8aBp-a1kAxYN4IsegG0YkVmzzdLlOLA>
    <xmx:3jjkaJrZWU95rci3ae7ozK06JOQfMoXKqR6VG1xZfmFkLAUUmc1PcQ>
    <xmx:3jjkaBwFlJVzRux4-_PsNFaP3fc6c1QL8uUAHNFTwcs2zJ1HM6bYHqrB>
Feedback-ID: i2aa947c3:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 432F3780054; Mon,  6 Oct 2025 17:47:10 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AfAzQvnzmZPw
Date: Mon, 06 Oct 2025 17:46:46 -0400
From: "Julia Evans" <julia@jvns.ca>
To: "D. Ben Knoble" <ben.knoble@gmail.com>
Cc: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>,
 "Julia Evans" <gitgitgadget@gmail.com>, git@vger.kernel.org
Message-Id: <1241cb86-9adf-4c52-87fb-028406ccd8f0@app.fastmail.com>
In-Reply-To: 
 <CALnO6CA29HA_FOQAJp_bkskKF-6Vy0_SKVL_OyJASByvKEZTqQ@mail.gmail.com>
References: <pull.1981.git.1759512876284.gitgitgadget@gmail.com>
 <8df4c59c-4d27-4f36-a231-f7af32ddf149@app.fastmail.com>
 <51e0a55c-1f1d-4cae-9459-8c2b9220e52d@app.fastmail.com>
 <CALnO6CA29HA_FOQAJp_bkskKF-6Vy0_SKVL_OyJASByvKEZTqQ@mail.gmail.com>
Subject: Re: [PATCH] doc: add a explanation of Git's data model
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On Mon, Oct 6, 2025, at 5:44 PM, D. Ben Knoble wrote:
> On Mon, Oct 6, 2025 at 3:37=E2=80=AFPM Julia Evans <julia@jvns.ca> wro=
te:
>>
>> Thanks for the review!
>>
>> >> 2. Don't mention that the full name of the branch `main` is
>> >>    technically `refs/heads/main`. This should likely change but I
>> >>    haven't worked out how to do it in a clear way yet.
>> >
>> > I think this is worth getting into.  This is a pretty
>> > user-facing concept.
>>
>> I think I'll see if I can figure out a way to mention this and at the
>> same time remove most of the rest of the references to the `.git`
>> directory when explaining references (which you talked about
>> further down), including packed refs.
>
> A colleague will be explaining reflog for an audience tomorrow, and
> decided to briefly explain refs, too=E2=80=94which tells me this is
> much-needed.
>
> For refs themselves, perhaps "git for-each-ref" is a reasonable place
> to start? Since it tells you the refs you have and how to spell them
> explicitly regardless of how they are stored?

Interesting, do you use git for-each-ref?=20
What do you use it for?

> --=20
> D. Ben Knoble
