Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3C47A31
	for <git@vger.kernel.org>; Wed, 28 May 2025 06:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748414213; cv=none; b=h3Bl1bLS4XNKQhqp7cac7nxaIoGee8GvsuGi8qc11UxUJFfdV9foZzIoFld6d6W4Ms4N2RtCG78VbJq1TlqqEDY2xiVBbUCbNtm4ygbVTof6pIiFDMSctfTuQWvjdctQIuKv8p6Tfcg7XPoawsD4tanVb6zIsvH3CS9LhoIyj1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748414213; c=relaxed/simple;
	bh=g3SvZpcEkW+kfva8y1h47slr+YESYQv0NYt3ZkmQd7g=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=ahlK5iXTPLf5p+jpajKElHeQc6pUGeWAMqrkHQvF5TZpwaIDpYb1mBqz0BezBvHagDTQb7Fu7KgoKrwHBrMFeGMc5R3J1b3SB//t/EM9JG0fEfyZWxeGidimQMrhgDPnFhaTSRp11DQecwOxr5VAV461LGxVduxCvSHj2XJ/iWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=Lqo4lvNl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BII/ahlJ; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="Lqo4lvNl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BII/ahlJ"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id AA86513839BA;
	Wed, 28 May 2025 02:36:49 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-09.internal (MEProxy); Wed, 28 May 2025 02:36:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1748414209;
	 x=1748500609; bh=g3SvZpcEkW+kfva8y1h47slr+YESYQv0NYt3ZkmQd7g=; b=
	Lqo4lvNlaST1xYwjmn+DRfPTnOA/Vl60J7moR/Aswwg+56g0MNst0omNQoeyrsQo
	Mu2EL6ZJvOx+UeRjf0dRz21XIs2oShDPYMM+dTFZWP0ZSSdJ89GYoG4jxzXKcJ5l
	f7je6Eqi+N1bC7i10EiijXhx2roGxJc06HTvwnCSzqIjqWRb5T3mfwDq86Y7TJ+Z
	XU1gSwkU2qknNZi+w/eMfAp3nTcuqeTyhX7UJasSHHumQ8A7r0jVcF44FY36cEym
	tixt00AUpPuSlXUi/ZVcBtx6+DsQ8qOslsJef5EZdPRYxWChFRiybNfGwKIqzOcR
	zQvlFZG14nPLVLUwepoHdA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1748414209; x=
	1748500609; bh=g3SvZpcEkW+kfva8y1h47slr+YESYQv0NYt3ZkmQd7g=; b=B
	II/ahlJLXsq+w6Xs1neaUDcsceiFmxuRDG7+Y3TAw5MLGT9kj/DKe1g7HTE0H5Da
	pVl/h3MABqZyRyeyyjC9ZugmsCX8wc/5RvzElLe49E2G1NkqJKPbbX/kTCo7utlE
	9FERjamZpgxtGqZBNVTEF6hIWGo1PMBl/K58wkAnTldMeqkJfRIU80gJKN3+FR82
	mG+s/U4gCHnV9jOgMzM9YBQFjM1DtPfqe0Q5Z88FRmXjI6SUtetqJ8Vap+sNT38f
	EfbDSIYjcfuPsDYd6hnAZ4u15OD27R49/f/Ym+zlpZBjEczHBpjnP7lAuLSZPNG3
	u7rMjALPIDqLmOd0i+CbA==
X-ME-Sender: <xms:Aa82aDXlbMTLlr6PC8SV3x7EMwyqVKM2g5s9WDqJ1XjohDDYs4xneWA>
    <xme:Aa82aLlRHQPpuZWAgBVPuCfkTnaS74MAJd34QsJRzhF66H7xBFH-uXqozA6bSmRo5
    Zw4medMavFOOCrfOQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgddvvdehheculddtuddrgeefvddrtd
    dtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggft
    fghnshhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftd
    dtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefoggffhffvvefk
    jghfufgtgfesthhqredtredtjeenucfhrhhomhepfdfmrhhishhtohhffhgvrhcujfgruh
    hgshgsrghkkhdfuceokhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgr
    ihhlrdgtohhmqeenucggtffrrghtthgvrhhnpedtiefggeejgeejhfehuedvgeejkeelge
    duudekleejkedtveejgfeigfefkedugfenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrg
    hsthhmrghilhdrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhht
    pdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghpth
    htohepkhhimhiffidtfedtieesghhmrghilhdrtghomhdprhgtphhtthhopehnvgifrhgv
    nhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrd
    horhhg
X-ME-Proxy: <xmx:Aa82aPZZ1GZtfwAGR6z2PXxYqc2K_zEX5TBIuIm-oL2JhpVJ9JZgNA>
    <xmx:Aa82aOW96BgiYVXkUwushiikqlpyKIJWrKRmfTgQp6HQeUW9128BjA>
    <xmx:Aa82aNlcFJdCrXv4VYwUcVsuyz4sysPqCMxXVTPyi1evOy3-K16nVQ>
    <xmx:Aa82aLcaCeYA6c09PlprGKFcs4MLX6igZ3jq-JB8ge3kMlki1oPNsw>
    <xmx:Aa82aDOSJ4-7Ya-KAllzgRibq72GXRCqZTUKakmPBJezo_41PxHcGE2Y>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 6E4A81EA005F; Wed, 28 May 2025 02:36:49 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Ta5e7ea721107c802
Date: Wed, 28 May 2025 08:36:29 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: oneee <kimww0306@gmail.com>, "Josh Soref" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, "Elijah Newren" <newren@gmail.com>
Message-Id: <4047e889-901b-4ddd-9e7d-38fc595080a0@app.fastmail.com>
In-Reply-To: <1C18C458-3565-455E-92D5-594520413D13@gmail.com>
References: <1C18C458-3565-455E-92D5-594520413D13@gmail.com>
Subject: Re: [PATCH] doc: sparse-checkout: Fix list markers
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, May 28, 2025, at 08:19, oneee wrote:
> Hello, I was wondering if there=E2=80=99s any reason this hasn=E2=80=99=
t been reviewed
> yet. It=E2=80=99s been a month, and I believe this is a relatively sim=
ple
> change to go over.
>
> Thanks.

I=E2=80=99ve +Cc the original author.

20d87d32915 (sparse-checkout.txt: new document with sparse-checkout
directions, 2022-11-06)

--=20
Kristoffer Haugsbakk

