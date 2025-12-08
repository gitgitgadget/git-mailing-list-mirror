Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E32E42D1913
	for <git@vger.kernel.org>; Mon,  8 Dec 2025 19:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765221640; cv=none; b=UpXr5QOVPm+SEtK293GT5KczmiqggbAWmGWbJhqeSWp+ySMqGra34qbyeYj21icdsDLzUfa/iU6SqHxyfEIQ5KM6ETuWH1V0/abRLkjJTCRXCTQNYc9KHwcskbip2Vawz3Pv3oOKVBcLP/Jjbo7QitfQm1F2YmqtUOq4vMkX7d0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765221640; c=relaxed/simple;
	bh=x2KRlL2syZZbi+OMElpI4NYa+Y8qBmoBB8ZWD4DnDrE=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=pPDqdooufppjGYokWHMUAtiw1hjrV68CL9JrvZ3eXh+SrCk3/eTJJl+Ld0qMWwmYXZiFQ+E/h9u3IMIvkKL+4g2ruOWbZgSkDfU+zVpT0SHegSaqsDP5s+Oizs3Scz3zJZknxHfT6KEBLZb8AgR/V6RWQYJLaFyrSoBq9VJkaEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=cSBmkYaN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Bo2T3L4h; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="cSBmkYaN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Bo2T3L4h"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id D301814001C8;
	Mon,  8 Dec 2025 14:20:34 -0500 (EST)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-06.internal (MEProxy); Mon, 08 Dec 2025 14:20:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1765221634;
	 x=1765308034; bh=x2KRlL2syZZbi+OMElpI4NYa+Y8qBmoBB8ZWD4DnDrE=; b=
	cSBmkYaNsPkx4s6OqmOYK3izQHzO1RgTgBeZopKHoB3Akve9BD5PPniFY1kzcaQE
	T16D0ren5NEOnneO66bTkZoWtjejK2sdohQDIxvTuIoi6A+NGJ5m/h6wYp1bvB2X
	OioMSUhJ1p8mhXZgAUnLWk7HRQue7OtbyOkXllMqK4NPAVrpDdedh+jtEY8f9agA
	2tJvvloB6lIqQcv0eXqzT7AV2D0jNW2yU17DgKeYoD0+Ua8AYj/X7MijQxSJiXw2
	snLsoVIR/DQXO64V3F6rYe4310YqAgM/lDJYu2ewUMfVoFBhr1REXS/6Aa1UZEF+
	TFDsRE2WwaQDs29nLF9BPg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1765221634; x=1765308034; bh=x
	2KRlL2syZZbi+OMElpI4NYa+Y8qBmoBB8ZWD4DnDrE=; b=Bo2T3L4hOnpa4FY9X
	v5Tmt2x/8+/CsZN1vL+uj8tUiCIjwrFUMWDWkZFlFUAdvhvLDnbpAEhtAZSrTnAO
	pSgInVwHqYsLuPeaIgpsxyIOHMDV5HWptMBwEqJTDOCsgCLQe3Qe4Y5vRfm6JbJW
	REb5GoX313EAezv7btIHRA27bmOCt3xWP/ZasHAc5I98SynRp7q0Gv9phKvpg4cY
	Asn2ecrre4chbl+fZWE/gMpL35mEo33c3l9xTQec+wUiYyfFLdQBOLBD4MJa0P6z
	xDRjNcSnpGL8dhu0gbHnKh00bAENZcfOt+JjYCZs5spWRmEowzvJMBX8zzVj0Jpa
	CaRqg==
X-ME-Sender: <xms:AiU3abwhcmDz-jplZ5dS1LXBzrb57Zhx1oNKEfOYfbWDZtZvsw9-wzk>
    <xme:AiU3aeEYxpfpBJLPF4zybr9bqx8ozqyQtMRwGI4MVddiP09x86qe-32WapypWRWHQ
    Ndpgnt1b4IZaD7j1QJdeRUk_ayysC-DvCpvWC2Cxr_AHt1aZN00fg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddujeehtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedfmfhrihhsthho
    fhhfvghrucfjrghughhssggrkhhkfdcuoehkrhhishhtohhffhgvrhhhrghughhssggrkh
    hksehfrghsthhmrghilhdrtghomheqnecuggftrfgrthhtvghrnhepffdtfffhfeffjeef
    ffettedvtedtveefteehgedthedtiedufeffudelffelleejnecuffhomhgrihhnpehkvg
    hrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhl
    fhhrohhmpehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtg
    homhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohep
    mhgrthhthhgvfihhuhhghhgvshelfeegsehgmhgrihhlrdgtohhmpdhrtghpthhtohepgh
    hithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:AiU3aedvuCVel1y4AQ8mqSwkgtJ5ztWjJ01WlFkfkCLe4QSzfda2hA>
    <xmx:AiU3aWJ432bwEWcj3LRkRnOLQsS2l-7Vx0d3a1A3StK9Ivea9ex96g>
    <xmx:AiU3aXHLbHO94lyN4-A7xUnCFaVH9MoLiFV8ZoK7OqSMV7CcyAajCQ>
    <xmx:AiU3aYoQ3gvjuyRelQClhrCKlXRBEApDucpfcMQwmUSZTnGJM1G2Uw>
    <xmx:AiU3aW1cXgo8SVeRPqnTU6D3_cdh_3v1hGV36QhaxbWbuq7ZeVrGU8Ka>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id B42411EA0066; Mon,  8 Dec 2025 14:20:34 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AgBmJBpImkWV
Date: Mon, 08 Dec 2025 20:20:07 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Matthew Hughes" <matthewhughes934@gmail.com>, git@vger.kernel.org
Message-Id: <ded2184e-595c-46f3-bba7-1bb574c2964c@app.fastmail.com>
In-Reply-To: <20251208190400.64920-1-matthewhughes934@gmail.com>
References: <20251208190400.64920-1-matthewhughes934@gmail.com>
Subject: Re: [PATCH] config: document 'gui.GCWarning'
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Mon, Dec 8, 2025, at 20:04, Matthew Hughes wrote:
> While investigating the config options set by 'scalar' I noticed this
> one wasn't documented.
>
> Signed-off-by: Matthew Hughes <matthewhughes934@gmail.com>
> ---
>[snip]

Apparently this is a continuation from here https://lore.kernel.org/git/jcqsqytuxpqwn3yhpz7fxucbuuf635q3jfgkjzauxwhrkhl7gg@g42r5kwwoknd/
