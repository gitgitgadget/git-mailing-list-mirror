Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31E9525B30D
	for <git@vger.kernel.org>; Mon, 30 Jun 2025 11:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751282063; cv=none; b=DxxfD+XaY2WhLPk9qSIEI6MIWjYC9HAUMkgLrDztSN9SOrJN8UllU271aFSW5YC/AZYWeetWxXPaD6j0SET9Q2Xj/8jRnKcC4SZjEo4mkXrrGEHb4gttfYsW81xUBLcNwMMc2FNSCPgyyEoES2nvFwz1hjOH0UxtiAE2SUJevcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751282063; c=relaxed/simple;
	bh=knPN/axC2PL5QtwdrYDcEM7BlqvSbFdtsPT4tSvRJe0=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=ZCy6mFESiQ3S18HErJlig+0FYX+OCwAf0zvlPDS43tI4ZIacIbD3IdgH5yJ180M0gU9+L9S1Tshb10MBLTGMqHMQOAIaeW+utXk/nT5r7KEkptrCdC54msl4xR3AiGmfccsUgd3eEPom2oHrjG25fBFLHwtx86WKioPGXEFUID8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=AL3QmXIQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=oM4b5n7P; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="AL3QmXIQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oM4b5n7P"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id C91AB1400231;
	Mon, 30 Jun 2025 07:14:16 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-09.internal (MEProxy); Mon, 30 Jun 2025 07:14:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1751282056;
	 x=1751368456; bh=gGGgFSgK2gkmk7Aaoe1RkuYbNqw5PSyj6G79ngd825M=; b=
	AL3QmXIQqTleutxF0U7oDgSegrE1AQ/VDrCC8rBfDhlMW2u4YzhP5c6mAQsTjhE6
	QXXMP4o35Xa4uKZNmHmuZNoJ8V9nbg5JVP7q7Tf1lGiNiL4dx7rSA9cyn8Tj/i09
	swaah+7cz11m6UpGHBS+rdoMTUB7nACRg616emYpw2uosdZIAfOXQ0C6h9pKCU0G
	9xBSMxkszgsmVsGe4nhyb+8WM2CMxJGtXwFLe0xFRdXpqqptURtAckcO3g5M8WMU
	vWw+NEU9lvW8fHAkbtEVvB9ct7NOBS0lTiJHeoqZMVF33jhmivFHcSQRfA3bcN8J
	yOL0P9i/JsTq+oH+LhJLbA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1751282056; x=1751368456; bh=g
	GGgFSgK2gkmk7Aaoe1RkuYbNqw5PSyj6G79ngd825M=; b=oM4b5n7PFRK1h5oDT
	27LhkwO7OrIe7oiqJO0c7+j6zO+YPA8T/9qw2DaUj4pj77W1AgcDPD4vDEr6pJ+r
	HX3fdwtPNtdByugnxYJn7bwh/N8eAG+Yut1aPIUyqilKsVdKkHL8X5NJNuxpH8+Y
	qG5Nzph63rPPDSxQJteOHM1qgW4ZLqAanIMvqGMAJ0F9uJq5S214Eh8NAa9sSrKa
	Mp2qH8xpqdFNInQRThKAKuM+idnJTLajHXo34Yfw7LlP59Et4S6K66SQTOfnbS3d
	Y75HcDADKCHq6YVavECV/hMZB4sufzx//sAv8J4V9lBQYl9PO17acRn6x+ThHxbA
	+y9yw==
X-ME-Sender: <xms:iHFiaHkcqtOG6Y8VHNYnv8xAWdkO3m5uVaPYMmjpd0yn_Rw2zzwuYRI>
    <xme:iHFiaK3xhGp4HS4aua6_oCcc5nT-mWWZGAx4LGiRvvPnRBJxkWUyH6NODny1fWR7W
    L24rx4tFyWqlPDfcw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduudehhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedfmfhrihhsthho
    fhhfvghrucfjrghughhssggrkhhkfdcuoehkrhhishhtohhffhgvrhhhrghughhssggrkh
    hksehfrghsthhmrghilhdrtghomheqnecuggftrfgrthhtvghrnhepvdeigedtgfetgefh
    ffetteeludevheetfeekffehheefieehudekveelveffhfejnecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhrihhsthhofhhfvghrhhgruhhg
    shgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtthhopedvpdhmohguvg
    epshhmthhpohhuthdprhgtphhtthhopeholhgrfhesrggvphhflhgvrdguvgdprhgtphht
    thhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:iHFiaNqsmJQCluWB2JSoVoW-oGa6ILb20snJD_lTSPgrKVjWUWcRWA>
    <xmx:iHFiaPngKBpsh_LT3pZYGigDgUGr-EwHPn5IYRGugeAgdYzL5ArJ9Q>
    <xmx:iHFiaF1EV20hAiIhZVJPJ7fCRH_1E4DYhs7hnibMXVBF120_0sw4jg>
    <xmx:iHFiaOtFNiJSEKEKoWUFaQoxOlGcom-7ydkDthL6YPbPwigFogiY8A>
    <xmx:iHFiaE3p_ZgiOTj0jeWsV-LPBoATQERUnF_bLxlwM-qBCT8Nr12ACriL>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 6FDB91EA0066; Mon, 30 Jun 2025 07:14:16 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: T3078ab33ae9f954f
Date: Mon, 30 Jun 2025 13:13:56 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Olaf Hering" <olaf@aepfle.de>, git@vger.kernel.org
Message-Id: <55b294bc-833d-4115-823a-2008657e68dc@app.fastmail.com>
In-Reply-To: <20250630121839.6252d9d9.olaf@aepfle.de>
References: <20250630121839.6252d9d9.olaf@aepfle.de>
Subject: Re: changed output in git branch -a
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Mon, Jun 30, 2025, at 12:23, Olaf Hering wrote:
> Hello,
>
> my dumb script parses the output of "git --git-dir=some/dir/.git branch -a".
> With git 2.43 it gets the expected list of "remote/branch".
> With git 2.50 it also gets something like "remote/HEAD -> remote/branch".
>
> The newer version runs on a different system. It might be that the repository
> was already cloned with a different format. For some reason it does have
> .git/refs/remotes/${remote}/HEAD, but the system with the older git lacks
> that entry.
>
> Is there a way to suppress such lines, or do I need to filter them manually?
> There is no obvious knob mentioned in git-branch(1).

Can you use something like

    git for-each-ref --format='%(refname:short)' --exclude='**/HEAD'

Instead?  The output of this f-e-r command is stable.

-- 
Kristoffer Haugsbakk

