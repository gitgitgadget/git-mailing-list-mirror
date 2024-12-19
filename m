Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1198D198A31
	for <git@vger.kernel.org>; Thu, 19 Dec 2024 17:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734629293; cv=none; b=lz9vFSCtZisiTv0EgXPiGMFjN6hJvWBeMrhlDQwP9dDhk7FYke8DSkIHx4cubze6t6HL9Gy4hcLZx9m8eJb4NWSTwJLvB88c+NAl5smeCups97U5vOzgflbvgSMu4JhAsP4Rx7H+CdS5mnTMfbYe9J7VNpJwt4CWLLSoBxR/m5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734629293; c=relaxed/simple;
	bh=XeMY0TnT+i3U1NpHodRoVN/KGkhtWyKvf499nE0mx1c=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=inWmmaZP4FccpZRpzJr6dDbpiEFo6eUdXPpQX/8kRQ2SzlgkU6q1U6dI7T1wL+zUIbFvOWJu/LHXUOjD0hLzJqS4NX2UFK6nSVSKGbkKyIuWr6IMb6ZoGrr+eDwMa8CJUv7q42PbHPcf/qwj11PBX46PQu2mYE717FiPSYEoioA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=Ydw7X/8x; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=r/NdHeP+; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="Ydw7X/8x";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="r/NdHeP+"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 140BE114015D;
	Thu, 19 Dec 2024 12:28:10 -0500 (EST)
Received: from phl-imap-09 ([10.202.2.99])
  by phl-compute-06.internal (MEProxy); Thu, 19 Dec 2024 12:28:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1734629289;
	 x=1734715689; bh=XeMY0TnT+i3U1NpHodRoVN/KGkhtWyKvf499nE0mx1c=; b=
	Ydw7X/8xpzADLv5clZ5VgAXxYz2g8q1/BIjU+UihsPWBDY3zX5LIaqy/E+S36pAQ
	LHZSQHVv4cvOo0/dtUwAVlll/L8TTm8OanAaWc5gClWcxrLVY37HjH3H1yXzn3kB
	oAIRrjHodTHRzzPoP+j8MVtM0mWU6fW2jfnNSbwGxnfVYBBf5RG3LR0pKNvdtLDe
	bz5ZAwJtC0OQqxvs5MB4EE6/ldhrslSG+UMNIHLvLdOoUPF1bUrwnjmVU4p5AqEe
	vyLly0ZAVtuK1LumF1Uwwrc4MQm/QynCEFXWz1rDB+cQPiGPFr46uoYsfBwZHW48
	XQ1nr7dSGt4CAkjh6JzNAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1734629289; x=
	1734715689; bh=XeMY0TnT+i3U1NpHodRoVN/KGkhtWyKvf499nE0mx1c=; b=r
	/NdHeP+SEnQFM0MhwlEUrhSUsRGXKiod6D5sqHOLSEzyWqZvW91YVNtvwyddd99X
	6kmZPDvLSHrVMHuYfar/SAaoS1k8wbz6Mk5Lh3xh7mVrXiPFQbqYTo1TLI1AWTjZ
	0d8PV5osCkJahvVujo8ewn83tfi2qvUesAmyyiE8KM6ykzImCQmFTD0SZKRde8ih
	AOoZPbhpB29O69JrYQxRLoyubpqnRIIpBmF73ckSMcUBkCRbatpjkejmOlbXebcA
	ANMcZw1wUAMYuMoJ+8Qrlj/djVtVl33DDR75JSo2ujeL1fRALswgbphozF4ngHKD
	ePICECCEbSuZ+BiI+Ribw==
X-ME-Sender: <xms:qVdkZ7G10VyAtxqcB0BfLr-Drb75O1GPwpIHb0lpNJDqADGam3qylaU>
    <xme:qVdkZ4V-qTOW6QPJ1rCu7n6e_0boKfHTMp5JudMcwRv9i0OISCw9kNU5lJthqoDp6
    Lh9ZC2KRVD2zvdInw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddttddgleelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdej
    necuhfhrohhmpedfmfhrihhsthhofhhfvghrucfjrghughhssggrkhhkfdcuoehkrhhish
    htohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomheqnecuggftrfgr
    thhtvghrnhepleefjedujeffgfeludehgeehueeffeeftdfgfeefveduueelffegkedtle
    eukeeinecuffhomhgrihhnpehgihhthhhusgdrtghomhenucevlhhushhtvghrufhiiigv
    pedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkrhhishhtohhffhgvrhhhrghughhssg
    grkhhksehfrghsthhmrghilhdrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepsggrghgrshguohhtmhgvsehgmhgrihhlrdgtohhmpd
    hrtghpthhtohepfihorhhlughhvghllhhordhnvghtsehgmhgrihhlrdgtohhmpdhrtghp
    thhtohepghhithdqlhdutdhnsehgohhoghhlvghgrhhouhhpshdrtghomhdprhgtphhtth
    hopegtugifhhhithgvfeesphhmrdhmvgdprhgtphhtthhopehgihhtsehvghgvrhdrkhgv
    rhhnvghlrdhorhhg
X-ME-Proxy: <xmx:qVdkZ9K00jbm6IXmeCZ2SLJ6pKyaKoxcssCf5XRgEjZIyNgt_-PpNg>
    <xmx:qVdkZ5EVp7hFE2D7hx-2t4Sy7xAAFm344UsKEefqeyX1_w2Waxe2Dg>
    <xmx:qVdkZxU5dJgk6ZSNVCw44X6DL81HRVWw140oVoS2MrGHSBDUIMNHJw>
    <xmx:qVdkZ0PIB6sDKYRtxexuvlrZbKDz6h8gQAkGbaSCxtWHnFaHPaX9jg>
    <xmx:qVdkZ3yrMQdZhGt4AZUV3pbJXijlrlKp0jZrhguv_rEo8a734fuPalPi>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id AB070780068; Thu, 19 Dec 2024 12:28:09 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 19 Dec 2024 18:27:49 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Caleb White" <cdwhite3@pm.me>, "Bagas Sanjaya" <bagasdotme@gmail.com>,
 "Git Mailing List" <git@vger.kernel.org>,
 "Git l10n discussion group" <git-l10n@googlegroups.com>
Cc: "Jiang Xin" <worldhello.net@gmail.com>
Message-Id: <f0b52b6f-339f-4641-8c15-7bd93b03b24e@app.fastmail.com>
In-Reply-To: <D6FUAW0WHD9P.EKNH75JAR157@pm.me>
References: <D6FUAW0WHD9P.EKNH75JAR157@pm.me>
Subject: Re: OK to submit l10n PR with signed commits?
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 19, 2024, at 18:06, Caleb White wrote:
> On Wed Dec 18, 2024 at 4:08 AM CST, Bagas Sanjaya wrote:
>> So I'm interested in GPG-sign my commits (that is, ``git commit -S``)=
 for l10n
>> pull request (which I should submit in this cycle). Is it OK to do th=
at?
>> Drawbacks?
>
> The GPG signature is lost when emailing patches---so unless the PR is
> actually being merged directly (and not using GGG) then it doesn't
> matter.

The i10n project takes PRs on GitHub. That project is then later merged =
into
Junio=E2=80=99s tree. That=E2=80=99s how it=E2=80=99s relevant.

https://github.com/git-l10n/git-po/
