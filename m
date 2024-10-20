Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7373198853
	for <git@vger.kernel.org>; Sun, 20 Oct 2024 20:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729456851; cv=none; b=Ql4sh7FMM2dxCbi2Cta/K/tznvc0Jjvz7Z/soFg6qBLpyxcqGXgbccv6wcQvpifNGysX78dxHKiy6gwj8zC4dUPflonVLPcjdC+7z0lvkNqiRp0n/aoAYbo6814dnZN6dy2XbAD/paPZUFPCjwFGAFt5mONQeCXyHJzFaPMczhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729456851; c=relaxed/simple;
	bh=TaYGftwwxVGHY0FWss63/73dMMAf7wawXXgIZHOm6ls=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=eth+89g4bvhQBRTxOlJP6u70mqBNY9h7nfF7CU5I2PKNFxO7Z7FGQnMT+2eyI/3OCnGym0Ej9m17qt4pyvlPG5GOEWNWfGufTZGnpPNXuVoEYV2XmQ4vE2GW0wPvmHFVLWVscIBgUUX2JXEqep/OKQmXoxh1XiViXXqCRxq0c6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=HXnigRI5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ebk7lnPq; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="HXnigRI5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ebk7lnPq"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id AB46B1140186;
	Sun, 20 Oct 2024 16:40:47 -0400 (EDT)
Received: from phl-imap-09 ([10.202.2.99])
  by phl-compute-06.internal (MEProxy); Sun, 20 Oct 2024 16:40:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1729456847;
	 x=1729543247; bh=j1xXjzwNi/NzFI5De2JcX5BmBm4YsQQkk+u1fvtHUVk=; b=
	HXnigRI5PFw7SKOizDoiH+e4828nAE45m4ihJm7Nyie4/2fDlVEKVaYYiWr9LHNG
	PmqO9UAZ+0K7g3IPdDvFNVKulCjiwlN409XYzmDZZ5GpHt4cncq1fVQ0NfDMp5WR
	j/SOEzerXyxktWdk0slwaVetE06iSADezVR+gpPa7TIWRYh5nbubpP61n9zSSz3M
	SaoDSmXlFhFgK+w88G0ITH9o4An3zKX9rM/k070w3WImUdvTOvRp0pyAL8CE36WU
	RPNLfl+pJzjnGmfL0p4iBXCFluMvJmv3ljUy4ZB12CXuAAWB17inipJ3B3na9XIY
	RFlcyacW6uCqTI61DKOHBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1729456847; x=
	1729543247; bh=j1xXjzwNi/NzFI5De2JcX5BmBm4YsQQkk+u1fvtHUVk=; b=E
	bk7lnPqnBvJovxhzxthQxMgFCSBzn26yEXLvWGFmvwGiuR7UD5FEUaVsdyYcw02p
	eifitaW85BFBNkJKWL0cvgWjhKkhUJTwNSl9plqt7o7fhBsk/48j+sMIuOUeTGII
	gv23DoYSDOQvAVt3b+UOZkDRH2xQ/xYHEXlv/vHsy9z38PLXsfVS3Uj7VR1qu9Zh
	dvBWZOa36zq/Y02uZXcqwW1/8i4BBsPL1W+iqUQmNmcsUM88mkCBZ2YY7ajLz9rF
	Z9OowPWHHgRRug9hgH1F26n/H5D1+HlP1yM3yA6+VDmVGSylSoflBoKp0VZKwE09
	rxrX0WgBm9BPADhTKCsOg==
X-ME-Sender: <xms:z2oVZ-4XSJt7uXksiAkjjzg03GjI4GOVkC09vCQJhwNMvaIJXqoZB8k>
    <xme:z2oVZ34gkJ6wwgept6omAiPL27w_nGEY_QY8b1pHSY_DJY8OJLYEbcJxsnBczD-la
    USD6eX3NRtNIkk3iA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdehjedgudehudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefoggffhffvkfgjfhfutgfgsehtqhertdertdej
    necuhfhrohhmpedfmfhrihhsthhofhhfvghrucfjrghughhssggrkhhkfdcuoehkrhhish
    htohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomheqnecuggftrfgr
    thhtvghrnheptdfgffettedulefhfeekheetgfegfeejveeikeeffeeikeekhfevieeltd
    ekgfeunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhep
    khhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsg
    gprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegsvghntggv
    sehfvghrughinhgrnhguhidrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrh
    hnvghlrdhorhhg
X-ME-Proxy: <xmx:z2oVZ9dhFzCySM2JHA5IA-93I1DLGDsg-1jvIo0za2fhYtwGaaCdXA>
    <xmx:z2oVZ7I-82RIpI2WLGsCPIvs0Ah8yADj7QPW5zfh1j2-dlV3rKln8Q>
    <xmx:z2oVZyJiQeo_ET8g2Xc8vbN56YvNsck2A0bsDkdmlHVBZT-2pOXdOQ>
    <xmx:z2oVZ8zwP_D1aPVy_0Hgmfzv1qoslhshMMQ1jQp0gLjSReyAvxXfhw>
    <xmx:z2oVZ0iuXNBSG3Sn4xPaziIOgVX-A4d0WoRNcDkV-eqmdiCMdFzsif8x>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 638A1780068; Sun, 20 Oct 2024 16:40:47 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sun, 20 Oct 2024 22:40:27 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Bence Ferdinandy" <bence@ferdinandy.com>, git@vger.kernel.org
Message-Id: <1c056d39-950c-4965-89d6-85f0c2c1bccd@app.fastmail.com>
In-Reply-To: <20241020202507.2596990-1-bence@ferdinandy.com>
References: <20241020202507.2596990-1-bence@ferdinandy.com>
Subject: Re: [RFC PATCH] object-name: add @{upstreamhead} shorthand
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Good evening

On Sun, Oct 20, 2024, at 22:24, Bence Ferdinandy wrote:
> The HEAD of the remote is useful in many situations, but currently one
> would need to know the name of the remote to perform something like
> "git log origin/HEAD..", which makes writing remote agnostic aliases
> complicated. Introduce the new shorthand "@{upstreamhead}" which retur=
ns
> <remote>/HEAD for the same <remote> "@{upstream}" would yield.
>
> Signed-off-by: Bence Ferdinandy <bence@ferdinandy.com>
> ---
>
> Notes:
>     RFC v1: Testing and documentation is completely missing, I'll add =
those
>             in a v2 if people think the patch has merit.

Do you have some concrete examples?  I=E2=80=99m not well versed in using
remote HEAD.

--=20
Kristoffer Haugsbakk

