Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EAC2EDE
	for <git@vger.kernel.org>; Sun, 24 Nov 2024 20:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732478485; cv=none; b=s19+HIYtu8rgUPG1UGioTa8jFMXFcXi/AoisHc87wTIJfNB62x8Z87DN5l4ARoDTi24K2Cj2u82JttV9YzmMOlfKA0aHmiJoqMegIrkk5xY53SOOpbDSonChj7mY/ul70hX8AaW9sSEBSvLVQne/XSLncPTXun93CKDSP8ovvXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732478485; c=relaxed/simple;
	bh=AE0YNrRtTXkqJBgF7tkrCxcWb4CO6NgcGNk0QRHE7D4=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=lqFIQ6wswDWNVCHxbNg/C8p0+aCxAPs0+TgVu8JvVeIGxiy1n/SUGuo1jpTgqUtU9lx3K/Olpt3DyAm84KG0ROi70Q3T0Wn+cLlEqi6xALKmqfdchwOJXiMBxZUrRRNWCk+fopC2i5CogQtFxiAUO4PUftGSb5y4Ivh4XN1OW70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=fwJtK8D9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GiafCqNU; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="fwJtK8D9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GiafCqNU"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 3389D1140076;
	Sun, 24 Nov 2024 15:01:22 -0500 (EST)
Received: from phl-imap-09 ([10.202.2.99])
  by phl-compute-06.internal (MEProxy); Sun, 24 Nov 2024 15:01:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1732478482;
	 x=1732564882; bh=X85OufgOH479QBuD//eLNPiUmYHzVLYH4mZBo5KSZU0=; b=
	fwJtK8D9ctYh2cLEiPjwfPNxwK1mboukI4K5mERuOSbyZCGkRwLXCojJh59pQQCb
	MXy+1fhiLJ+LebcIs1OmcdsH3P9a3KqzZp1ALiZ2nF1czB/N+360lUFiFD3hWNRQ
	fzH5zh7Cdq4fYJt5DM9ZhvJIp46xFcQleyCWNzFH77pKcsZ0ujd45yAz7IbISLE4
	c9k13OSl8svHg0QFmICQ3qx9KRZbv9XPs1wGJahHlhpxB8PIBHjRNkbVx1q6ehHh
	gSUjIWhZGAoep740cKJguWn0INBGyRQgtSRErYvCPnTxr2ltgOhXQGSalVgWf8r/
	V1Yj6Ap5Oy7C8Dq1ydHfLA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1732478482; x=
	1732564882; bh=X85OufgOH479QBuD//eLNPiUmYHzVLYH4mZBo5KSZU0=; b=G
	iafCqNUAayfEZ1Zk5k90XQH9G4WICa1OR55++rbjg3ymauOcKYdF/Of0Bf/NTpu6
	d6XKtxPO9H8GudLCWzmK/NwxPJEjH1Y4LbIX5aufsS3BLVjnlvx4CbpHRKqzt1wD
	nEr21cRtNsB3QPF16+eA9xV9jlcGYPIPFmZGbv1Thnhthq4d2k9M4DrYZQb6S1ie
	NXv1i84juiU6VwEYC8ui+vq2jwA6XMDOtUkSfm/ihwkSJu8YslnbP8dtluXYedc+
	vtMEW4R/aetGrZxTjyXl19XKIiHm8e4Dg5Rz9+GOKzTpoLYkfhpXqPqZZPyhx67m
	PQR8WbTVlIvFQ68MbSCUA==
X-ME-Sender: <xms:EYZDZ8jX5-fmuLnuUGTb9RHlI48OevYBAlt4lKGcg0oj_lRNV4qd7vQ>
    <xme:EYZDZ1Cs6q35BFnE0YopFvmeviMSbAR0kQ9EhfVjZHreJgDbT_J3JALSc3SLygfEk
    cMEGCvvs4fPd-aiTw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrgeefgddufeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdej
    necuhfhrohhmpedfmfhrihhsthhofhhfvghrucfjrghughhssggrkhhkfdcuoehkrhhish
    htohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomheqnecuggftrfgr
    thhtvghrnhepleefjedujeffgfeludehgeehueeffeeftdfgfeefveduueelffegkedtle
    eukeeinecuffhomhgrihhnpehgihhthhhusgdrtghomhenucevlhhushhtvghrufhiiigv
    pedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkrhhishhtohhffhgvrhhhrghughhssg
    grkhhksehfrghsthhmrghilhdrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfh
    grshhtmhgrihhlrdgtohhmpdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfees
    ghhmrghilhdrtghomhdprhgtphhtthhopehsthholhgvvgesghhmrghilhdrtghomhdprh
    gtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepmhgvseht
    thgrhihlohhrrhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrd
    horhhg
X-ME-Proxy: <xmx:EYZDZ0GW2xSL5cttb3ENg7UyIDJH-TMtQ0kqFgAiUj7MFsc1xwxqtQ>
    <xmx:EYZDZ9TLTFEipsgeL8_L-_m4RF6QbSy7hUFuvqmsaZu05hV3awkoRg>
    <xmx:EYZDZ5wFh5gV6QzWnDYofuRMUuC2x7TyM5RGw3xr7uV3kVSXFuheOw>
    <xmx:EYZDZ74nPjXB74M5VqFh9IA_c_QS2IBuU6c2pbiaGoc_MlytVssP6w>
    <xmx:EoZDZ8q0RuUIDcCVubbXKOX3rLs69-XhUv-476DlzLjXw01igYLFx7Qe>
Feedback-ID: i83a1424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id B0CF7780068; Sun, 24 Nov 2024 15:01:21 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sun, 24 Nov 2024 21:01:01 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Junio C Hamano" <gitster@pobox.com>,
 "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
Cc: git@vger.kernel.org, "Derrick Stolee" <stolee@gmail.com>,
 "Phillip Wood" <phillip.wood123@gmail.com>, "Taylor Blau" <me@ttaylorr.com>
Message-Id: <2160428c-2e33-4c13-9b64-fe6a890ba494@app.fastmail.com>
In-Reply-To: <xmqq34jw3roe.fsf@gitster.g>
References: 
 <5267b9a9c8cc5cc66979117dc4c1e4d7329e2a03.1729704370.git.code@khaugsbakk.name>
 <cover.1731406513.git.code@khaugsbakk.name> <xmqq34jw3roe.fsf@gitster.g>
Subject: Re: [PATCH v2 0/3] sequencer: comment out properly in todo list
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 13, 2024, at 01:26, Junio C Hamano wrote:
> kristofferhaugsbakk@fastmail.com writes:
>
>> The first version just had patch 1 but this one fixes two other place=
s.
>> The two other places where unearthered during the v1 discussion.
>
> OK.  I guess they could be handled in a single patch, but the three
> patches address different things to be commented properly, so having
> them as three separate patches is good.
>
>> Rebased on `master` (b31fb630c0 (Merge https://github.com/j6t/git-gui,
>> 2024-11-11)).
>
> Was there any reason, other than "newer must be better" (which is
> not always true)?  I thought there isn't any in-flight topics that
> touched the sequencer machinery.

I=E2=80=99m sorry. I worked on the v2 by rebasing on `jc/strbuf-commente=
d-something`
which was in `seen` at the time. Then when I had to `rebase --onto` back
someplace I picked `master` since I didn=E2=80=99t need the interdiff fo=
r the cover
letter (two new patches, no changes to the first one).
