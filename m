Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61C552FD7C3
	for <git@vger.kernel.org>; Thu,  5 Feb 2026 18:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770314745; cv=none; b=ZS56001N90HNZi2GuRVY8xgfHFTyZ4pk2vqLZEiG+Igs02h3FlWHEkTHPs1xxUwuvmq56O7aXxicO/aTVHQkOZHHrlOvH8LUId1FVOrDl0PN8vpt/6m8UIz/RqGfZuTN6W43etk1niZ1PrV02P2MLNqucU3fkQoILtSfelO4sZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770314745; c=relaxed/simple;
	bh=oaT1hcisxqONzY/tLcCZryui0MW07ECCKvfEywGTnbw=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=SqeGkltGry4lbhEp90VUkM6JeooYHzh4p3Wqwu4o6XsNmKJNphSURf7Z1ZgI7zAP4uNb3BqzmXzbp+DnIjEf6LKRrQzClvaGS/L9GYo5VzZFMg9XDTLk8JB1aPuYGLtCEHYhTsPgJp273PWKkM3VcFOxveP1ZZNfCKrflL9ipxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=YITqvC27; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nL8+tcOQ; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="YITqvC27";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nL8+tcOQ"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id D6A08EC05A2;
	Thu,  5 Feb 2026 13:02:38 -0500 (EST)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-06.internal (MEProxy); Thu, 05 Feb 2026 13:02:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1770314558;
	 x=1770400958; bh=oaT1hcisxqONzY/tLcCZryui0MW07ECCKvfEywGTnbw=; b=
	YITqvC276MUYl8mSF8Iv94jVSj62Y5HHEN3/rhqeIcBHuy+6AE1b85pYyxxH0OCk
	Yn67EI+CsF5tMBUTD9nZkBTJ1Y5fvUnRonTONIwZVaUdU/5DQiqlmM6wv730bQMr
	jzQHHa/QXsbRoZP5yPuTxl5gIBghcVyzZVM8ytW19/LYtIZzb+LHCsZz/2Z0gA/b
	u+Z6Ax8d/R/+0rT9S6wOlVfos9CGGB3PdboYyoUXk16zRVvgG6cBv9kFUKWBls2+
	QHAZwrrzzawjQ6ZWH8uwwNHErDbForrwZBLU8XVNw1VjsSXImMsQ4hif6JXpVYVy
	tfrTzSfyq/Q3f/hsNe2r/A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1770314558; x=
	1770400958; bh=oaT1hcisxqONzY/tLcCZryui0MW07ECCKvfEywGTnbw=; b=n
	L8+tcOQIUv94nrqqszYduIkv+Xif3+bWwtGJg3VlF6KPt7h4ePL+XTuElLSgtI0O
	rkDRSWGj2cO7/x8TacmUlbfu8a3SBoAHhHcFV87boama74aXTAtOmEnl15SZFGht
	EyB8D7JUJV6o77DErEl+zYOuMdRr+PkiMQ2Ni5gyrrK47YF80f4fNNzFS3yzukNi
	3ciyMs4S01XOQNcCgFjmKhKth9lYUb0pagEFIsp+xla6J9xWu3SXzA4U38ARgdae
	sUu3LIhTJX73gvLsOULT3U2ABdRieyZ6S2MZH/UxQ10bu5nGUXJ3+KqCQho9u4Ws
	LQfRpCG4KlSQZk9UnGoGw==
X-ME-Sender: <xms:PtuEafpMTYr0_Tvb_lTERDBFOA2CYVY3eS-69BmiDCTHP-rDZ1xrSkw>
    <xme:PtuEaUc2GfQQLuOnzCOUji-vx80VZm6d6jDiVil2nyPIAge5NnWdoIHNN11ZfWxcX
    0J7Em1q_Y45yVwgORP8jgVbmFh3Ds3Y_yztcTjsfJMMrE7gC_6G5LU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddukeehleejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedfmfhrihhs
    thhofhhfvghrucfjrghughhssggrkhhkfdcuoehkrhhishhtohhffhgvrhhhrghughhssg
    grkhhksehfrghsthhmrghilhdrtghomheqnecuggftrfgrthhtvghrnhephedugfevgfef
    gfffvdfhffdvveevgeehhedutedvgfeuffejveejudegveefvdefnecuffhomhgrihhnpe
    hkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgr
    ihhlfhhrohhmpehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilh
    drtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehphhhilh
    hlihhprdifohhougduvdefsehgmhgrihhlrdgtohhmpdhrtghpthhtohepshhhrhgvhigr
    nhhshhhprghlihifrghltghmshhmnhesghhmrghilhdrtghomhdprhgtphhtthhopehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghr
    nhgvlhdrohhrgh
X-ME-Proxy: <xmx:PtuEadvfho4ckXDOSuppTmQVNOcG2Cls-_QbGQ6YcbavSbGCS_UymA>
    <xmx:PtuEaX88EarzwPSUi6Y3btakhlwZsP5MkEMP1jWp1qZT3HFoNiv8rw>
    <xmx:PtuEaQ2Z2gFpZZW94XX0vnhldJzFIe6LRSk1VgvMIxIrWyokVTdUNQ>
    <xmx:PtuEaUAyjZFwAK3djOL7MgjXc4RKFzxbmPMAiYXayhObYbdItxnsJg>
    <xmx:PtuEaSCBkiwfvfOJARkcUyIQVTZFafF-WvaqSARzPRzCXAxXvHDgPKzp>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id A75851EA006B; Thu,  5 Feb 2026 13:02:38 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AUvchStvJz8F
Date: Thu, 05 Feb 2026 19:02:18 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Shreyansh Paliwal" <shreyanshpaliwalcmsmn@gmail.com>, git@vger.kernel.org
Cc: "Junio C Hamano" <gitster@pobox.com>,
 "Karthik Nayak" <karthik.188@gmail.com>,
 "Phillip Wood" <phillip.wood123@gmail.com>
Message-Id: <20a892fd-ca59-49a3-afca-07cc003af052@app.fastmail.com>
In-Reply-To: <20260205173909.61406-1-shreyanshpaliwalcmsmn@gmail.com>
References: <16274976-17c0-499b-8225-de2d783ed343@gmail.com>
 <20260205173909.61406-1-shreyanshpaliwalcmsmn@gmail.com>
Subject: Re: [PATCH V2 0/3] wt-status: reduce reliance on global state
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 5, 2026, at 18:39, Shreyansh Paliwal wrote:
>>[snip]
>> As well as describing the changes it is very helpful to include a ran=
ge-diff to
>> show what's changed - see the --range-diff option to "git format-patc=
h". I've
>> pasted the range-diff between V1 and V2 below
>
> Thanks, I will keep this in mind.

I=E2=80=99m personally a happy user of `--interdiff` in addition. It=E2=80=
=99s a nice
supplement. :)

https://lore.kernel.org/git/CAPig+cSErj4ZB9bHB8mZfzNkiaN_EpjT6b4b=3Dcfsf=
_+KMqytiA@mail.gmail.com/
