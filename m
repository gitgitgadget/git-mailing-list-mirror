Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21F6E28EC
	for <git@vger.kernel.org>; Sun,  6 Oct 2024 09:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728205267; cv=none; b=i0mF5N8Up5lzEsS/6TSoVCmL4Ddq/s4faa/w7B73V2y1lapAhcMYJ3Y3nc0mbikDe9DeU5EVNaHS8eZLm+adXy6zXBAw4VVdRSshcRrHjO8ZalXbGRKwe0a14c5rO3a8NRbm3m/KGO/IBvWwWxj81/hOjAJnDKz8DeGRNF+XT0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728205267; c=relaxed/simple;
	bh=QN0fsKdt0Bpda926UmMaxDDkACQWIV8LI3ffYz1r+4o=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=PkluP28L6oMe4uQHch8wEh4eS4VmPj3bzV3bo/k34Xa1GUREV137HOa9qlXTaD+ckbG3PSH/Ninmlkpnv0zEKgA+v3rzxr2ARdT5EUkB3N/NA8jSsd14lXy3OWuKa6RcZ6yugCNwgj+8b6D/m0yXZwOmS5c8QeoJ7a2pIYvscQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=XKIkGKRf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PeDacXB2; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="XKIkGKRf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PeDacXB2"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 36F3A1140293;
	Sun,  6 Oct 2024 05:01:04 -0400 (EDT)
Received: from phl-imap-09 ([10.202.2.99])
  by phl-compute-06.internal (MEProxy); Sun, 06 Oct 2024 05:01:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1728205264;
	 x=1728291664; bh=QN0fsKdt0Bpda926UmMaxDDkACQWIV8LI3ffYz1r+4o=; b=
	XKIkGKRfYMHMXavGjnDvqOAHK7tambW4Q0SN3PMQdV953F6xLDFCrct3ZPxS+Gl2
	jtajdBYPR+UfCs5PYTlAQo11FaANmWcBLyULw1hmkbbND8V6kmIswxmBdS/9va5y
	boaC8uFK+sqwv9lRQsG0qL0UgNupK1IgzuNuex/MEB9RoH4IJNg/hjDwUMGQmm0b
	II0/jPnGaYmwbT7THas66ElVeihq3PtAQIO8X1MW65vQwJAkK4t2yAr/YEGG/WqQ
	LoCsrQhY7967dqV1ckwl/9zZcCZXDF32UC8S+ZJJwL7yzSJI5VIQLF+cNZ57kZFl
	9LgzSk0gyNMjdYqSG1ElOA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1728205264; x=
	1728291664; bh=QN0fsKdt0Bpda926UmMaxDDkACQWIV8LI3ffYz1r+4o=; b=P
	eDacXB27dE7NhMaXV1zz2NtNH6bnzaY2iIb5moxXyJptkL3xMU2CoGXo1GU4PDeE
	WX87GGAIHuQouJTfP5FbM78FkqIbRK0n46d8XiM5nBdbf418f5vgiDXbjpgikNcz
	fe78s7beimWrNQy5gXEnfDuMAL4wQ/M+xGUZj2EvJtjgOpO/BTqjZFrlrhkDDVAG
	8B5dVF6pAztmyxFxU4nntKg2s/ZE1uiLrCPgAo/Qn0q5yB5BvqbTqynVko2mpMVE
	K8hedBAPV5OGnddODBSLbfZWY1V9MKOeByCTFAtUw1LYbnKt8iDaURMCU9V4zx2z
	UUvrVqwYwr4Ug/tIznXAw==
X-ME-Sender: <xms:z1ECZyNyfhT1maNBtagiWGqkJBPYjDp7DevBDbVfCmfqP2d20gCpkk4>
    <xme:z1ECZw8nnC6RnApF53PqIp-YR29mqgxw3Q7xr-MrP5ktbnGY8ZMopi_lSK5oDfD2g
    _09ixPh5SnRaMbGNg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddvjedgudduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddt
    necuhfhrohhmpedfmfhrihhsthhofhhfvghrucfjrghughhssggrkhhkfdcuoehkrhhish
    htohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomheqnecuggftrfgr
    thhtvghrnhepffeuueeiheehffejgedtveefhedthfevvdegudeltdffheejvdfhjeduff
    ehgeelnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigv
    pedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkrhhishhtohhffhgvrhhhrghughhssg
    grkhhksehfrghsthhmrghilhdrtghomhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheptggufihhihhtvgefsehpmhdrmhgvpdhrtghpthhtoh
    epshhunhhshhhinhgvsehsuhhnshhhihhnvggtohdrtghomhdprhgtphhtthhopehgihht
    sehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:z1ECZ5RzyB5XU-lC81h2BfG7rqpMOl1ZsOl5jTuXy0wcSwrmxLdqfQ>
    <xmx:z1ECZyuag1w-JB6NeHjAAA8TL19I1M-rONgAO5NsIIDxNtvF3NPhDQ>
    <xmx:z1ECZ6cKc0blA65Rc5W0twR9bIwE5wpBUU9jofcsTOmPfdb2Wpfr-Q>
    <xmx:z1ECZ20vaH9arT5LvUBpKma2VmTKQ1TQkDTFLwFqYMV_-QIFUOno7w>
    <xmx:0FECZ7olYIj-dO_wHAWCO6ykDTqyCdOnddQR3s8UHiM5nPTq3Mg2gNZk>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id BEA73780068; Sun,  6 Oct 2024 05:01:03 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sun, 06 Oct 2024 11:00:43 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Eric Sunshine" <sunshine@sunshineco.com>, "Caleb White" <cdwhite3@pm.me>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
Message-Id: <4bbe8ceb-2e72-463a-81a0-138815a1cf8c@app.fastmail.com>
In-Reply-To: 
 <CAPig+cQZmEdx1Th9VAHbEkJ=zm73TP7Wuda_G5CzFw7j9HTFQQ@mail.gmail.com>
References: <20241006045847.159937-1-cdwhite3@pm.me>
 <CAPig+cT6LALKjEappB7QkB7oc88NyMcr40T_qJGL2mPA77K7XQ@mail.gmail.com>
 <CAPig+cT7CEnb6cQmAOMbD82wxkg=7T0MMW=QNUSPU62a0rEGLA@mail.gmail.com>
 <TEfKiit-RYyr0ZuiQszaKaM64iSonfaQwWRqExOgXyPR1tVWyAzR3kVKmCd3aREZwDGuS5VXcHjCvneY-gCg2OuZyv2N2EkfARlZu4AVSsU=@pm.me>
 <CAPig+cTE0gaD=7dwSqY4S+7AqRoU9yOrS4sdBoybj0Pfyk9vxA@mail.gmail.com>
 <K1lpl_AWj4xpiHLG9AloFDP7hkJ7Ysf-LA5H-OeP6suaBcES3WS6NTYZGX96oQuNQ3x36eEOxGdqlj3fG3ybrn5y3LRPfCNqC7yqTyvqVrk=@pm.me>
 <CAPig+cQE0RNLhktuja-BbF8WwZmKC3cox_GUC-o4w87PadDpgw@mail.gmail.com>
 <gX8RNUg1e1FCYFS1vP-uT4rbMpg21Ax07CZm5Ha7Dsk93EN6CTuXiLr3boTaoNEi71O1rDoUxhTs6KQt7Cvfz7B3KlbpZzis5b05KW7ARls=@pm.me>
 <CAPig+cR4FXsGDE9Uu04EjK+vOo-Pi_VwOub8+Dy3r9t7z8GdkQ@mail.gmail.com>
 <AtSpzKynOkmMPZ3bR4qx-eA93Xo-1miPCIQSxIKP534tD-qpDU1AI74vqB78RsukQ0XP5eKdvzHcwy_lf8lpL9wAoHoom-koo5GKcbrcuX0=@pm.me>
 <CAPig+cQZmEdx1Th9VAHbEkJ=zm73TP7Wuda_G5CzFw7j9HTFQQ@mail.gmail.com>
Subject: Re: [PATCH 0/4] Link worktrees with relative paths
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Sun, Oct 6, 2024, at 09:45, EricSunshine wrote:
> Can you try GitGitGadget instead (preferable) or perhaps publish this
> series somewhere (less preferable).
>
> [*]: https://lore.kernel.org/git/20241006060017.171788-3-cdwhite3@pm.me/raw

If Caleb gives us a clone link then I could try to send.
