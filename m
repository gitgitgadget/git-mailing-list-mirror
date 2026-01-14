Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EB7B2E9ED8
	for <git@vger.kernel.org>; Wed, 14 Jan 2026 14:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768401278; cv=none; b=TNnbl3KzpM2KiiXdwDlTWgQEzcO5tJZQSWHJ4ntn7/ciV03bglEmlk4ALy+smDyQmsZuIhagShk/SQHhedvBJnc5of/J5y0C2YV+uruZl9R0/Q62+UhF2/D+v7UUCEM7nhwaWiBNL5TyTN9tkQoXgvriCb516zAn4Xdfw9+lVuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768401278; c=relaxed/simple;
	bh=kMHlw9tq8S9pttELX2p4iKZ0exsN8jaL6VTusr5IvAs=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=fhQwEgUjj/IrXKBF3aredCuQfv7kdW9qh/obUf/fuELW8PlrQ6G38MAbMX1/re/wILtbo5nyyuA/4/B4psvFe349S07R8B39qBoNfxcukUw2ilSQdl7swxHewzDapFCsWzp+/2jU5dMqNSDGhQouSlDHCzwI22QOQKWGFnpMQ4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=baLwkCDk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=wxHZ3GHL; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="baLwkCDk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="wxHZ3GHL"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 4ACBD1D00155;
	Wed, 14 Jan 2026 09:34:32 -0500 (EST)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-06.internal (MEProxy); Wed, 14 Jan 2026 09:34:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1768401272;
	 x=1768487672; bh=sSwhojhoTCjWpHjWGFSvCvsQu0PkPXOVScglMGDSHdY=; b=
	baLwkCDkv4l4NX4vFT7BhrDyOkqjBO5Mb6Le7NkGCjdLJlZxwlVNbFwFcUT+bnWx
	wTzzPro9M3ZbmUVYhVBpuSff1b2nADi1JK7nSvh6x0bTuzqaaSR47yZngQidPk/W
	QID+jkSgVbb8SXn79tYocnOxuP0EboNP39j+1yVRSupEHb6Bj4m7ZYw2pEwM2W6t
	BPHyilPBNMLAvCwPYdw/54er4lL3ziQTc5ZKdJbEsb4w1noJkk2p7YpahCdc2CSN
	qnZVONnpQkYlJxSZBQ0BZn8KEeUSJYyYY2ZfAyC1b0jALfUliQaby2E2QGi96gPf
	+jF5m3yG9JjP8mNWcrTJtw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1768401272; x=
	1768487672; bh=sSwhojhoTCjWpHjWGFSvCvsQu0PkPXOVScglMGDSHdY=; b=w
	xHZ3GHLhQn1L3u3puZM2aqLY9g208w458RnvHN1CZAd/DQSFrAnj0VHSJlb65g+7
	xCh8HRFglDSyRoluAjEnWAVOBcszzDE8lEE6JIPHKROd+GGCpydNfA9I0b8oYKAG
	Rvmq9myLccznLCbFVZe6VDaKmWh/J16zQhABP/U+wZYBEfsR3BnEpzjtPGMNgkqc
	XxnZ5EiflFZ+QlcuyVUTK3rxlW2Zvly5rExOi/7mC43zMIlqQBBn1bZI66OKdykt
	XxZp9+7PCGa1+k7gvdKTCUjpKwlf+NZfHmrEIu9qOmU4udEFykBYDZ/+9nR1K93X
	vrCDQFpswN8+YUqsRdhSA==
X-ME-Sender: <xms:d6lnaQlJG_roLqzi3TBkmQvQnWBwsggpmjQh8rqioKI3liAh5izIQC4>
    <xme:d6lnaaoCF_8fPBnlLJ_6qizGdNLFBRBwc_BV-9AtNt5EMMTMDuB9lq0J7iojr0vKh
    8J4Wnk9lTItvjmc-hs09fQc0g754kG8MxM7-FrgqUFN7I4T5JmJ1Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduvdefgeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedfmfhrihhs
    thhofhhfvghrucfjrghughhssggrkhhkfdcuoehkrhhishhtohhffhgvrhhhrghughhssg
    grkhhksehfrghsthhmrghilhdrtghomheqnecuggftrfgrthhtvghrnhepgedtjeeiteeg
    hfeutdeutddtiefgvdegteektdeutddugfekleeugfelteffjeffnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhrihhsthhofhhfvghrhhgr
    uhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtthhopeeipdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopeguvghmrghrtghhiheskhgvrhhnvghlrdho
    rhhgpdhrtghpthhtoheprghplhgrthhtnhgvrhesnhhvihguihgrrdgtohhmpdhrtghpth
    htoheprhhrrghmvghshhgsrggsuhesnhhvihguihgrrdgtohhmpdhrtghpthhtohepphhs
    sehpkhhsrdhimhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtg
    hpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:d6lnaWRuViGj7kNigKL2ocMlpE0FgaivvAKn94TAp7EUgsdktdxl_g>
    <xmx:d6lnaVFIGDl1RA9YJU_yU2e1WLphvArTxjhAHj9Zcp4uIF4-nGhQYQ>
    <xmx:d6lnabFfcW8uuee3_CfsDOnff5eSRv_sNSZWUxXyPd-bxkEhs83oSw>
    <xmx:d6lnaTTjmpMbz5psqK2W2rSkqWoe5PyZZiNxeQ9ElQpYtFJyMh4SIA>
    <xmx:eKlnaawbAlFJ_7jycMV3L6sbJtWC9cS-pmj2Z1KXJusFM8V0pgtjoQUu>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id D89C31EA006B; Wed, 14 Jan 2026 09:34:31 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Abh28FChBAq3
Date: Wed, 14 Jan 2026 15:34:11 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Aaron Plattner" <aplattner@nvidia.com>, git@vger.kernel.org,
 "Junio C Hamano" <gitster@pobox.com>
Cc: "Patrick Steinhardt" <ps@pks.im>,
 "Rahul Rameshbabu" <rrameshbabu@nvidia.com>,
 "Lucas De Marchi" <demarchi@kernel.org>
Message-Id: <d666df1e-2645-4597-ad10-be22d6a52ba5@app.fastmail.com>
In-Reply-To: <20260114010642.594566-2-aplattner@nvidia.com>
References: <20260114010642.594566-2-aplattner@nvidia.com>
Subject: Re: [PATCH v4] remote-curl: use auth for probe_rpc() requests too
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, Jan 14, 2026, at 02:06, Aaron Plattner wrote:
>[snip]
>
> Signed-off-by: Aaron Plattner <aplattner@nvidia.com>
> Tested-by: Lucas De Marchi <demarchi@kernel.org>

Unrelated nitpick: It is more common in this project to have your signoff last. 
If the maintainer applies this patch:

    Signed-off-by: Aaron Plattner <aplattner@nvidia.com>
    Tested-by: Lucas De Marchi <demarchi@kernel.org>
    Signed-off-by: The Maintainer <>

It looks like The Maintainer added the `Tested-by` trailer.

At least this is my experience with `Acked-by`.

> ---
> v4: Style nitpicks, use xargs in case 2000 branches is too many for the command
> line.
>[snip]
