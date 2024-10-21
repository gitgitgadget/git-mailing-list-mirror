Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C3871E47C1
	for <git@vger.kernel.org>; Mon, 21 Oct 2024 09:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729504670; cv=none; b=CxUpBOVcUfKhUsRe55SIqG3C5wTRsAoRdNSglgLIKRtVq+zRsBhZMkUDnZhoORP91GpiA7+02X0lP23FdDxfUbpx0V3xk3kstkVJvVmSPHXabn/tSBWWm7hY9s/cCzPYG33DGlaL7bZb7ARln+mQ7jXoenzscI34+1yOQBtiw8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729504670; c=relaxed/simple;
	bh=VU15rwljz0Qeqo70L3hMyhSoPQqPivk19asS+8gHWsM=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=l/SFiAhebnx8bADVX9LiLbdc4y+1R/GSXUHWCkOXVgP1USV7aTOfQYbl+PaeEsPsgIFWAn/G/PfP6l9UhRQv/p5xLwquwiVVlMQJ20nC9mIYr2PpHgsIwFxgQjf0s5jYDXFbcnIVe9lz+fmuL52hvNDQt+vV/oV4a2nWPf/o6Gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=D/NC0I1t; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OpmxENBr; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="D/NC0I1t";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OpmxENBr"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 99BD61140225;
	Mon, 21 Oct 2024 05:57:47 -0400 (EDT)
Received: from phl-imap-09 ([10.202.2.99])
  by phl-compute-06.internal (MEProxy); Mon, 21 Oct 2024 05:57:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1729504667;
	 x=1729591067; bh=m/0y9cFNSINpWI3lwDm8rrjJchqtW9xUipxcqolv4xM=; b=
	D/NC0I1trWtXh6+Fy5bRVE/504a/ZnMg7aHgIcQ5K0pYq8mDsQ1VwSiwShyVBU0k
	NJIkAEMbEXUz89BR0dMcEtvKeIYpLgC4m2CoecmzGbnafPMHhowgnWXlC9lePQfq
	STzPax1dqtmKQhKza1+8tFVIJb0UiXIXx4z3sZCp+/mHLNJ0j6lM1EXppzW+lbV+
	TEy/CFj6MLA3qCpIYZgRk6WsqCMC2YzWRfNiqqM9c/aOQ806MSx2nj51nYFGnP5+
	ZEnquU0Fkjc7VumzdhFZHymCFG/ehfPeAqXCQ5musIPuXdR1gQlN3eHHykyzmjBo
	lQFFs+tul37v4zzKAUi9ag==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1729504667; x=
	1729591067; bh=m/0y9cFNSINpWI3lwDm8rrjJchqtW9xUipxcqolv4xM=; b=O
	pmxENBrO177VmIkt4Ncfp3pqQA/4WaXOd9zoeqtyCgV7PvrlhfU7zdGspBVFWUd0
	PevtLelYqHu8MXYLzQHg5LfDM1LC4M1ZTgQd7XCr3LDT8nhagqruJGKo6BoeGgV4
	a034v52jKQ+jY1HxbF5YHvWxCZ/EtlCnjGNSkisHcfYqEkjtzMFpbufzsQghQrhS
	VbX2F8ZEZSNVEYKcIcpWrxUtvK3WRFzXHJgwuz9vDiQDLzPklX/2/gbS5VrzS9o/
	BjJNsnSXVJTO2hya8O5BVXzTPTLGDgCkyoE0UCi9dAWl6WbKHOefuvwPEWtiANVw
	dQfyjdJklFnJwjY6aBR8Q==
X-ME-Sender: <xms:myUWZ9gaFtZozTQwSDXbFlLrIlU3yaIKkAB2s1lSHn7WOWf2A96BhJE>
    <xme:myUWZyCanVpmlJ4kZzSlEv4M-HVUJ2zv0vJgdu4eXCsGUkOt9GuXCD-btv2mx2qDL
    mc3F7pxu8kvp40u1A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdehledgvddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdej
    necuhfhrohhmpedfmfhrihhsthhofhhfvghrucfjrghughhssggrkhhkfdcuoehkrhhish
    htohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomheqnecuggftrfgr
    thhtvghrnhephedugfevgfefgfffvdfhffdvveevgeehhedutedvgfeuffejveejudegve
    efvdefnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigv
    pedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkrhhishhtohhffhgvrhhhrghughhssg
    grkhhksehfrghsthhmrghilhdrtghomhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepvghmrghilhestghsqdifrghrvgdruggvpdhrtghpth
    htohepphhssehpkhhsrdhimhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghl
    rdhorhhg
X-ME-Proxy: <xmx:myUWZ9G3c_qNaSnizLS2nj_23NHMWtg1Cji_lMRRyH2f1QriS3MtSQ>
    <xmx:myUWZyR2-pEPXfI3qmZTMFZdDyVhpAds_FVDSzhu4r92w10lNJ22YQ>
    <xmx:myUWZ6xpPItKBoJ6SARBtlM85jYHoqUSY1_8RQj56bnID--N-GzoiA>
    <xmx:myUWZ44iIKOq8bWovhpm059mLnVQ9iXl2aETKXO-lczcDDHJB5YDCA>
    <xmx:myUWZ1-AEk8Sgs9fEqprcw6B1KR8A5jYyc5Sj4PtuuXYs3298lPNDU8C>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 3CC3E780068; Mon, 21 Oct 2024 05:57:47 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 21 Oct 2024 11:57:25 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Patrick Steinhardt" <ps@pks.im>
Cc: "Sven Strickroth" <email@cs-ware.de>, git@vger.kernel.org
Message-Id: <89ee8fab-ac1e-4e9b-98b7-f2ad25e8f0d0@app.fastmail.com>
In-Reply-To: <ZxYjISSiV-vlE96W@pks.im>
References: <b50f9706-bb45-4bf0-8d32-59149615301b@mrtux-pc.local>
 <e1ee980d-d8d2-4c9c-9a73-ba6af9009ba2@app.fastmail.com>
 <ZxYjISSiV-vlE96W@pks.im>
Subject: Re: [PATCH] Fix duplicate word typos
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 21, 2024, at 11:47, Patrick Steinhardt wrote:
> On Sat, Oct 19, 2024 at 12:06:54PM +0200, Kristoffer Haugsbakk wrote:
>> Hi
>>
>> I guess it was an intentional choice to not use an =E2=80=9Carea=E2=80=
=9D in the commit
>> message?
>>
>> I found this similar patch which used `*` as the area: abcb66c614c (*:
>> fix typos which duplicate a word, 2021-06-11); review here:
>>
>> https://lore.kernel.org/git/CAPig+cTjjNrU9q8UPm+CRuTKq8_XNc+1z7-3F4bv=
etBi+NjKeQ@mail.gmail.com/
>
> I think many projects also use the "global:" prefix to denote changes
> all over the place. We also do this in Git, even though I should
> probably say that all patches that do have that prefix are from myself
> :P In any case, I don't have a strong opinion here.
>
> Patrick

I forgot to mention that =E2=80=9Ctreewide=E2=80=9D is used to a decent =
degree.  :)

Cheers

--=20
Kristoffer Haugsbakk

