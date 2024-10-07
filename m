Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D621FC0E
	for <git@vger.kernel.org>; Mon,  7 Oct 2024 15:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728313253; cv=none; b=Ajz7jHIOJZbyrr1eddftkxVQo13AwiM3ngjl0+W6TF8wmE13VIGp/59idCwbteHxPJ2BaHauVIlyc/JCj8E/us3kmbee3oJh7qIPVXUZYC8yCICS5fHx7XIKNYzu5ndkkX386hA3SkqVpqXIW/OAy1lRQdXWAF/b6W4Ba4Jxz/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728313253; c=relaxed/simple;
	bh=Ly1Aox00CkXWMRMhEj9nMR0Aici4wyp9klFffuVXbC8=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=m4/3C7jjXV3JTg1KIZFdx/QBOlHKrQ60MautwcCyWmG86tIVp2cQNoeTALTWihjgxAzDPYosa3BmXBaMupUvM9VhFqPXIzfIa+PtONxG7Le9xNiihmyBY1exS2KHolE+KKBnPUozVUBxTisoUuk3lini8yhcuxF2cGcbGLCWOUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=JknMeNio; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nIjwpQuo; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="JknMeNio";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nIjwpQuo"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 98CCF11401CA;
	Mon,  7 Oct 2024 11:00:50 -0400 (EDT)
Received: from phl-imap-09 ([10.202.2.99])
  by phl-compute-06.internal (MEProxy); Mon, 07 Oct 2024 11:00:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1728313250;
	 x=1728399650; bh=KyMR214CLgPyGBdwfI3ARO8rfZnQzK6Wre/t3InEHd0=; b=
	JknMeNiojoUXIfLwC0pWZscOmmlWxil3oLJRtXN/z3gf/TT01tyPvIXNSfYEiUjj
	+NgtC6T4FN1NcWRPA+SKRx7h2611Kh0XrI8p2cvlY6geGMqz5fo5fdszlH1fzPmx
	6inHUdZU6Gi9rqCAzNG0FbegVeuR2BJiDQdhih+E7eILiIjxpFR26sVy9r8V56ob
	K6v3tlxq6oDcGRP9pdD3iQ965ULGvt4umFZF09gZGmAn/TmzObYaqIq0TFjIW5NY
	sPLXvtElu4S7cYOk1olrRcQveDnK22+p3sZrcwxm6WmOB0u1sj2emhyh3ed6W6kE
	/aovKyVjAEOPLeGNUcMlIA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1728313250; x=
	1728399650; bh=KyMR214CLgPyGBdwfI3ARO8rfZnQzK6Wre/t3InEHd0=; b=n
	IjwpQuoiwGrv/b8I0UiIKBYuq9P3a6in939S1TZAz6LZHm96iPg4ZJM7x5Gs+lMj
	DNRjvAQXDWzi2OYrrqRp7gch2GZYHuZwmuqXk6tn6U4HDYIkoAUDSOGHY8uyARVI
	tqj0KAUiCIBDjJg8W+CMSr8nNfdSOS8T+Iv8ys8JrSSTRO8/B43s/iyTdeDej0eU
	JogPXSYxgwkNwUbV1YKP9lJeGH59mP5CmbNsGcvu/sdtN1OkXz+M6/Ognu5d9FKL
	OZMO4Zy/HQkvOd5mr1pbKigw4yRc0QpZscS3c9KakSszTzstL048XMhEZDmuL9OA
	msBrTJwO0HsrEslaY5PnQ==
X-ME-Sender: <xms:ofcDZz82Oob-a2kXpVmNPLPh7a2WZtoq2CkfOdjMwW8ruVLoulrerPg>
    <xme:ofcDZ_vOj199M1UfFBBLv1epEapyo2_axqyGNJJNCiM9kwoFtJumQ_3ud7YvRqGW5
    4i0z5INhY0z3gHxwA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddvledgkeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddt
    necuhfhrohhmpedfmfhrihhsthhofhhfvghrucfjrghughhssggrkhhkfdcuoehkrhhish
    htohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomheqnecuggftrfgr
    thhtvghrnhepgedtjeeiteeghfeutdeutddtiefgvdegteektdeutddugfekleeugfelte
    ffjeffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhep
    khhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsg
    gprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehphhhilhhl
    ihhprdifohhougesughunhgvlhhmrdhorhhgrdhukhdprhgtphhtthhopehnvgifrhgvnh
    esghhmrghilhdrtghomhdprhgtphhtthhopegtohguvgeskhhhrghughhssggrkhhkrdhn
    rghmvgdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:ofcDZxD79FSMLR2PT5b3M-9ApQVE2nF2hTrKTLjsj2195wN5TUYMZg>
    <xmx:ofcDZ_exgt3_-5dlHvzcQoYP8tdGgTgjDVLk5EB2bUBrfmjf5iIqaQ>
    <xmx:ofcDZ4N0gTrbSqFDcOTzoOIUzeTn1ixhccoh9-bGPwpOVuXLe-OwcQ>
    <xmx:ofcDZxnqdrtIEw71OYlvfdaXGAshWmIAxUmKGe7PFMLGPr2NV0o7Wg>
    <xmx:ovcDZ9oZ_0f4A6-BKOZC3lmMXKF9YS59XXHYpIh2JELA2itwiLSsLte9>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 9065F780068; Mon,  7 Oct 2024 11:00:49 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 07 Oct 2024 17:00:28 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Phillip Wood" <phillip.wood@dunelm.org.uk>,
 "Kristoffer Haugsbakk" <code@khaugsbakk.name>, git@vger.kernel.org
Cc: "Elijah Newren" <newren@gmail.com>
Message-Id: <002b3e89-fa60-4927-bae3-bf95bdfd60cf@app.fastmail.com>
In-Reply-To: <3ce39bec-24e4-4850-b947-e6476fac5132@gmail.com>
References: <cover.1728298931.git.code@khaugsbakk.name>
 <3ce39bec-24e4-4850-b947-e6476fac5132@gmail.com>
Subject: Re: [PATCH 0/3] doc: merge-tree: improve the script example
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Mon, Oct 7, 2024, at 16:59, Phillip Wood wrote:
> Hi Kristoffer
>
> Thanks for working on this. Patches 1 and 3 look like clear improvements 
> to me, I've left a comment on patch 2 as the improvement is less clear 
> to me but I wouldn't object to it being merged.
>
> Best Wishes
>
> Phillip

Thanks for taking a look!

-- 
Kristoffer Haugsbakk
