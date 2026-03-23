Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB2C232C937
	for <git@vger.kernel.org>; Mon, 23 Mar 2026 19:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774292861; cv=none; b=Fsz9FlqByvbtrY89YW9IPQmH3l5ITZ5imBXVYHDJw1HKkx9ZwnMcu4cfUeWEVdOTGTnBPnVgb+WIoNwDWubq/5LEQ6lIMv0mI1iDtQjoJHqDYcIYE6VQcPUvho1XiFcvhc4JrcNc+guc5TAk0wRbJ4b5yH7zwfjsgJZhMqnvfAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774292861; c=relaxed/simple;
	bh=5zqpAmhxH25zOz36urX4uShPJtCyqwdl58LgakD8Bbw=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=hG05msyQZzye87z7sfe17JsOH28LY536kw8sf26IwcksNezGI774kCkCWj70Nk7f91d5aVPaOCmw9l+tlOtq7AeJxu23+6cegqhM82xi6Y3hy83D5vqBTZgemp7dS/PFrPO9SVEPw6U+CpcIu6yoPLTQD8pruOkc9tWaT+gxF6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=Vp24CQAC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=aE9HyTZz; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="Vp24CQAC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aE9HyTZz"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id E14737A0202;
	Mon, 23 Mar 2026 15:07:38 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-06.internal (MEProxy); Mon, 23 Mar 2026 15:07:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1774292858;
	 x=1774379258; bh=cMKBJEoN7+YxH98Z49eqB79Pd22Ouy5TWf2wiqzURDM=; b=
	Vp24CQACAcT32JuRIdsHaXdMEomOpT7UDr+SSdJBmhw9jUbCsTukGYSDIEnjRlC2
	PnPg5se4aDiSAGnUjE8wK5R26AlD8/2GfhAADivnawLru6VhnMAp3JIavlHNJFQ6
	77LdTg1kmyVJ+aM1uBXu/bjyYlezHvcvuyfFDcB5tSkQZ2zI5K2C5qKaebKI5KNz
	yOX6BcfG7lty/E2qGLeqGmvfZruOpix5/guh582YEwOQSO6Cm6XA5WD//hszzaqG
	91BJpl5YtVA2V7pKkC/C0HuAXHod5JyWyJ/egYf0j46l1EMWZhca10HbgngZpfXA
	1trAqd6t16uELdo2BsjzAA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1774292858; x=
	1774379258; bh=cMKBJEoN7+YxH98Z49eqB79Pd22Ouy5TWf2wiqzURDM=; b=a
	E9HyTZzE6hHKmj7yHSZlfOhzidinmBseFVK8WWVhyJNoL6v9IEZ+SUr4ID1Ab4Vc
	yRLLaxhcRuYaVtq80u5opN3IzOY6HfI6xtgg4Bd9Q3DWShx7xT9LY7aje7AG1rp0
	xrGPxY6iQBL2tGDqCKrZBpK816DZJ8dIlWTB+QCn+bmFkXC9qerCMp77wwEDd/WV
	zdsW5wbTsZ6bSwmAqxVuV0iA5MnA5O+PnfuvpuEByUozE5lnQNETuYXDQs6mxibh
	y6erftWTknLuGSIIlgNRfK8h6nKCSXXbjHYrGn1Z/TksLO6F3jWlhdgKIXs9RUHU
	Eg420/Y7W3HbQurt2ORJA==
X-ME-Sender: <xms:eo_BaQnKwS47Y8EG8s28b3gV7wyXMgTY2pNjAOZQ2NBLG63Ts6-pX5E>
    <xme:eo_Baarv4e1zMo3P8raXzH0hDf4kaN2VJUqUkdy9iAo8vATIhvR4Q0JfEttBkKLGV
    rTkeW5tXuElb_66Xq7ldyg0R5jDLN6ndgqTQiiLQRQIxrPjvTprRA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefudelheduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedfmfhrihhs
    thhofhhfvghrucfjrghughhssggrkhhkfdcuoehkrhhishhtohhffhgvrhhhrghughhssg
    grkhhksehfrghsthhmrghilhdrtghomheqnecuggftrfgrthhtvghrnhepgedtjeeiteeg
    hfeutdeutddtiefgvdegteektdeutddugfekleeugfelteffjeffnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhrihhsthhofhhfvghrhhgr
    uhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtthhopeehpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehjlhhtohgslhgvrhesghhmrghilhdrtgho
    mhdprhgtphhtthhopehsihguughhrghrthhhrghsthhhrghnrgefudesghhmrghilhdrtg
    homhdprhgtphhtthhopeihvggvtghhvghnghdrtghhihhnsehgmhgrihhlrdgtohhmpdhr
    tghpthhtohepthhoohhnsehiohhttghlrdgtohhmpdhrtghpthhtohepghhithesvhhgvg
    hrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:eo_BaYJgcyKrp8nAfq43sSDp0nGLp_MHOfWp4jOG9Ev5w7JnlLmdUA>
    <xmx:eo_BaZoNTo1EVLYQoKpu1WAU8xFoo0r96-dhN9OFTyfRpwb8UiXeWw>
    <xmx:eo_BaYzjgZXgFEHeAyuQBhvxngWittZdasgiiO6AVQGXUskR_A9dew>
    <xmx:eo_BaVMEyov0KyePqcITdtHo2Z2NQqnUKuXnilSj_mF8HTcNL5qPaA>
    <xmx:eo_BaYe44F2s5XC7uuTCU6-BN2GN7Wg8fHVqXlq5xCSuBFyFt5wrNPFc>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 50EAE1EA006B; Mon, 23 Mar 2026 15:07:38 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AHOAF4mS0e8c
Date: Mon, 23 Mar 2026 20:07:17 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Toon Claes" <toon@iotcl.com>, git@vger.kernel.org
Cc: "Justin Tobler" <jltobler@gmail.com>,
 "Siddharth Asthana" <siddharthasthana31@gmail.com>,
 "Yee Cheng Chin" <yeecheng.chin@gmail.com>
Message-Id: <63a66d11-d138-4d4e-ab5c-f7669c218293@app.fastmail.com>
In-Reply-To: <20260323-toon-replay-arbitrary-ref-v1-3-5c7172f675ec@iotcl.com>
References: <20260323-toon-replay-arbitrary-ref-v1-0-5c7172f675ec@iotcl.com>
 <20260323-toon-replay-arbitrary-ref-v1-3-5c7172f675ec@iotcl.com>
Subject: Re: [PATCH 3/3] replay: allow to specify a ref with option --ref
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Mon, Mar 23, 2026, at 17:09, Toon Claes wrote:
> To enable users to replay commits without having refs in
> <revision-range> or as the value for --advance and --revert, start
> accepting option --ref. When the user specifies a --ref, the refs from
> the other option are ignored, and only the ref is acted on.

s/option are/options are/

>
> Signed-off-by: Toon Claes <toon@iotcl.com>
> ---
>[snip]
> +To replay onto a specific commit while updating a different reference:
> +
> +------------
> +$ git replay --onto 112233 --ref refs/heads/mybranch aabbcc..ddeeff
> +------------

This example could use the stuck form like in the two previous commits.

    git replay --onto=112233 --ref=refs/heads/mybranch ...

> +
> +This replays the range `aabbcc..ddeeff` onto commit `112233` and updates
> +`refs/heads/mybranch` to point at the result. This is useful when you want
> +to use bare commit IDs instead of branch names.
> +
>  NOTE: For reverting an entire merge request as a single commit (rather
> than
>[snip]
