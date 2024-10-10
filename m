Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3EE31CEAD2
	for <git@vger.kernel.org>; Thu, 10 Oct 2024 18:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728584644; cv=none; b=bI0h7jmHUPB9BpUdMBXnbasF3xQqbfvKeavdgE+M70q4J+avuMwqVr2FuQr2arlQVErU6ELUUlQUs8NjWVSa3M2vfDVmFwj6Gq0/YViz68QRNjLypULgfC7gcueVVY2aQ993fCi2bjTBxbORN4eGooZeDQ8aqB6AcUEAZVvjJXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728584644; c=relaxed/simple;
	bh=vU/PCUtkbITpkeTdY8zcZ6h04P/DZVursg/QMLEGsVI=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=SvF1khsZu4+Wec9j5Kxo5+d7p/oeHAVFCb69oXYRNeXPSp31aSLVrAmeO8QOl8EhFy1LujdeRYoDKWoYq0OpZ5YQ2I/FBFUg0xBcpnim86tCVzENfZg6Nj3Xgxu8zKT8WjSwYoiCtaIq7gM3m0lpNiG98k0KG+OQ0TJDwMNu0hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=CulHfQww; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XDMMN4Nu; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="CulHfQww";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XDMMN4Nu"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id CA9E21380532;
	Thu, 10 Oct 2024 14:24:00 -0400 (EDT)
Received: from phl-imap-09 ([10.202.2.99])
  by phl-compute-06.internal (MEProxy); Thu, 10 Oct 2024 14:24:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1728584640;
	 x=1728671040; bh=JQsYtDdWB+bfA3NXJbybL0g4zozF2LZJ+7W6K+KcRoQ=; b=
	CulHfQww/n2DCzpNa9FtcxlOi48NwSbfbyUC5La97gI0tA+GpsTN7ZlBck5Becso
	Mj2dl/A6r+TzOGQkOVHUsXbrlplcVSXVAdxwgt4nZ86eHnUqTvG851AsTbF2bVz8
	pMiZ/sDB8XdNDcH4t3X13oiAtMwZBmH3ZoLmp+lQS64+6gb0OtG7fE9BoTMOziJv
	qwGi3CvS6NqGabVU69xfelgEhHdTau0WUljx4xUYbsyamFzNzp2ta7GlEG+zJ3ui
	L2G8Iymr7NEPKAGuCmGnqgnSPo2Zqh0Wfw1J2MG2tulBZ+BB0uYgOfMMRr6G7geK
	7o0X2jrkyj1A94A8jTBOhg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1728584640; x=
	1728671040; bh=JQsYtDdWB+bfA3NXJbybL0g4zozF2LZJ+7W6K+KcRoQ=; b=X
	DMMN4Nu58cKRqrr5OGnDpW06eZ99f7vDDFBzSm9lG/3HtbHu+BRhFF6V4bw4Gutk
	h5G2r01wzBjrVKzqx4HMKpK6z1S5Ul1+fIwfYiFTWFBxha7IFfTVgFyaLnnGGXTj
	EXWQOtR6+hz1dh01txydvLESa9WVsipkL6TKne1/S8pkChtnsjFghpU7/mmGE3hh
	lP4+72YcbqeEyT1JpHAC8r7svuM/UH9qcHNh3mnErJXNF8/FqZO7W37415yTV/cJ
	Kcrr3pp7ELOfKqA69z+csFfPFLaiI9FYWiF/ZJIxVC3pgPoRGGcxg6tcylLfHAUk
	WMLx7PT+TLjJLg6EqnLXw==
X-ME-Sender: <xms:wBsIZyz04PeexFtx25eFJndvSlEie0PXOytLE9xLI5B5ytOvkLqQR4I>
    <xme:wBsIZ-SarS4Lmp99tcci52JI91SJw2KH9qFBDWqRi0H8v_EyFuSDepk5RFsZHiUMJ
    nqCosZewIesguHYCA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdefhedguddvkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhepofggff
    fhvfevkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedfmfhrihhsthhofhhfvghr
    ucfjrghughhssggrkhhkfdcuoehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrg
    hsthhmrghilhdrtghomheqnecuggftrfgrthhtvghrnheptdeigfegjeegjefhheeuvdeg
    jeekleeguddukeeljeektdevjefgiefgfeekudfgnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepkhhrihhsthhofhhfvghrhhgruhhgshgsrghk
    khesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmth
    hpohhuthdprhgtphhtthhopegtohguvgeskhhhrghughhssggrkhhkrdhnrghmvgdprhgt
    phhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepghhithesvh
    hgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:wBsIZ0UjpFLaXJ6tvP5vTwUWI0eas7Vepdw_rjct0MjNyvUPXjvqjA>
    <xmx:wBsIZ4huEkb1CaMIatM4BRHlEjtrvpj6KmTQo6w8JsFYl7_pa-XLkw>
    <xmx:wBsIZ0AEy3Y7xpuEHNjcAB_FG2u9Dw9Rz3rV19r_B2a23m-wltuBIg>
    <xmx:wBsIZ5LrKOaMx0GzuxYh7TXJnk49hyaJ5umUlYA72tlBosw_D8LElQ>
    <xmx:wBsIZ3NZ2oETxlBbIMEZCwEa9ZvXwCXwx56EACpnZvGCX6aPxumVleqT>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 721F4780068; Thu, 10 Oct 2024 14:24:00 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 10 Oct 2024 20:23:40 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Junio C Hamano" <gitster@pobox.com>,
 "Kristoffer Haugsbakk" <code@khaugsbakk.name>
Cc: git@vger.kernel.org
Message-Id: <23f2006d-145f-4cea-ab36-859eb2e87489@app.fastmail.com>
In-Reply-To: <xmqqh69lru6e.fsf@gitster.g>
References: 
 <259fcbb61f13873421d50df77f151130fdbf0166.1728494795.git.code@khaugsbakk.name>
 <xmqqh69lru6e.fsf@gitster.g>
Subject: Re: [PATCH] checkout: refer to other-worktree branch, not ref
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 9, 2024, at 20:46, Junio C Hamano wrote:
> A branch "in use" includes, but is not limited to, being checked
> out.  For example, "git rebase" may first detach the HEAD when it
> goes to work, but it fully intends to switch back to the branch it
> rebased when it is done.  It does not want somebody else mucking
> with the branch from other worktrees, so "checkout" or "switch"
> would consider such a branch is "in use".

I did not know that checkout and friends respect branches which are
preocuppied with (e.g.) a rebase.  But I=E2=80=99m glad to learn that th=
ey
do. :)

>
>>  --ignore-other-worktrees::
>> -	`git checkout` refuses when the wanted ref is already checked
>> -	out by another worktree. This option makes it check the ref
>> -	out anyway. In other words, the ref can be held by more than one
>> +	`git checkout` refuses when the wanted branch is already checked
>> +	out by another worktree. This option makes it check the branch
>> +	out anyway. In other words, the branch can be held by more than one
>>  	worktree.
>
> As you are updating the usage string, we may want to unify the use
> of the same word, just like the original said "be held" here to
> match "is holding" over there.  Perhaps
>
> 	... branch is already checked out or otherwise in use by
> 	another worktree. ... the branch can be in use by more than
> 	one worktree.
>
> or something?

Nice. I like it.

--=20
Kristoffer Haugsbakk

