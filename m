Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E21AD3EA66
	for <git@vger.kernel.org>; Thu, 21 May 2026 00:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779323344; cv=none; b=Vsj89/aWAOkHUt5whLUAGBktB8F2cDp2Riuy61oHuwP3H9i7dtPpm1XEr+iAFRfpYzcV7fWl5YBP45ZGC74cJOo5GWrpoU1+xEU+NdVt9qSUKX3zkz+4bo74r5fNTg0AVjG3c4H+5/tyU6VXfezdkciNw5v0hvZYzkf+OJQvEQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779323344; c=relaxed/simple;
	bh=ACpo0Le4rygrolWoudsGv4LV7okgWHAb+nO8cOjGonE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UJFkPB/W/7UvbaUngHnOktQpvr3P3Yp4HUxSoVmk64TYJVbRvt+nfpcx2oyBej/gxRAknJd+ZW4APQX70X1mP+hr0q5brfCzHBhpvRTeJvMS4/g5CgxfpzXTfNZyWkY9mL2nbWmPoMT2mApom/mV8d5HoVAnyFFcZO7dW1+6C74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=UyxiNgk6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MQoFjepO; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="UyxiNgk6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MQoFjepO"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 84B0E1D00054;
	Wed, 20 May 2026 20:29:01 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Wed, 20 May 2026 20:29:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1779323341; x=1779409741; bh=euZ8FJ8iub
	LdtqpfS3/zotIGYXRAKtoH2JSqhZ3vgb4=; b=UyxiNgk6yhVBhg9zp46L8v8lwT
	l0sD6nvgwqmjTOpQCRIRgQkXhrzTPz/HNfO9lRohyVFOtDF7nHBmhDN+/leuD77r
	oczQzvYmTw8EFmQTxNRwhWwXuCy9pvNr5L0u1F+0ha7rAMSfzUTKygR4H8uxhagi
	cDKsjtc2D8hhBsCotZxxpFzYM43ZZsQvZOTWc7c+nHzVXSY8HaowFDbBr1ZRDper
	9dYDiuW7cyCV7njOyErSB1zdbuTNqsSQi2XGvD1cpp02ecK/0lPZJgAMWcjN9cee
	qHZWao+0qDA/yjGUxw6wdbKFc2xFe8hXmDOCmeqPo2Et9HiU6qOSQ+PmI5XA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1779323341; x=1779409741; bh=euZ8FJ8iubLdtqpfS3/zotIGYXRAKtoH2JS
	qhZ3vgb4=; b=MQoFjepOx0erD6Ea9beMQFMvv4fVqnlOOyojYaEOSTotZALH2gb
	aR0SR0TEl1swc0UQ73/bFChV8e1TFF1WezSL0iJi2ANwmn5IqNZpws4QNKdFKTkj
	IRQ8aURZr4DK9r0xMdtvtxkZuw2uZjh1RV1J+D8cHuKqHFK1dadH6wVKroN/mWBf
	ybH+HnZ6uzDE/cZDPxok1Y8SxT00KpAORgfzkpv1oA6Vpp4GqqN8rWSihckXbDeW
	ZX2lJbpsU7ai9RMm9SmC42AC7S7EBvAid+RA7FmsijLJcYqvwJczAx3oGo0zBmiQ
	B4IC1Dn7pMU5J/G+x+up4QqrEWvd35f7VNg==
X-ME-Sender: <xms:zVEOatlQ02rPFIu1AakJGf_HNQJWeXU2-wh1SaimYF-tgUEdMsNZQg>
    <xme:zVEOasijGQS98oyfMHijohFj2GnTelG2umAUbE0U9xmw8N1GYI5ZN2iT4pnttLPI8
    YuM_pjWmU428G9jCWYKHbXhhfhGAVAt-7rqiAvgZBc2lHZ5LACVZkM>
X-ME-Received: <xmr:zVEOatfGM33D8OHLZP1bN6HbAyr0-N2osrQks_oNqNNECPACicWm1PBIXhpC0P275LzIlt4x6Am8ZnxtjE72HE3e7IdBO1XMBg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddugeeitdejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepshhiugguhhdrrhgrmhgrnhdrphgrnhhtsehorhgrtg
    hlvgdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhr
    tghpthhtohepnhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepphhssehpkh
    hsrdhimhdprhgtphhtthhopegtohguvgeskhhhrghughhssggrkhhkrdhnrghmvgdprhgt
    phhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:zVEOakhD0nd4daSHe8Z9lexOvekrYuK3F3k4UrcIrmsA2KG40IyEyg>
    <xmx:zVEOatwkz8mpwS86OP4kOQZQcVdQagO7QaT8Y_U_8L8ONICiDhO1Iw>
    <xmx:zVEOaoN4UFroRYpPB4fHyeIz3xPab_776y_hiIqjJllyBF2aiczwKQ>
    <xmx:zVEOamV4VYEBbHwPI1o431Nsc6S--11GixHpo6jKt9sZfWmX82k6sw>
    <xmx:zVEOatARHuk6MayC0IhGQ21Ng24ewT3pA5j4nS_GBuXMOhkIfDdmKeaq>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 20 May 2026 20:29:00 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Siddh Raman Pant <siddh.raman.pant@oracle.com>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,  "newren@gmail.com"
 <newren@gmail.com>,  "ps@pks.im" <ps@pks.im>,  "code@khaugsbakk.name"
 <code@khaugsbakk.name>
Subject: Re: [PATCH 1/9] Documentation/git-range-diff: add missing notes
 options in synopsis
In-Reply-To: <b3958381907244ca06a39e2fc116eec113a6bc85.camel@oracle.com>
	(Siddh Raman Pant's message of "Wed, 20 May 2026 07:00:24 +0000")
References: <cover.1779207350.git.siddh.raman.pant@oracle.com>
	<290fe06d81e956253d3a06fc1e16848e0b86b603.1779207350.git.siddh.raman.pant@oracle.com>
	<87v7cjq7vc.fsf@gitster.g>
	<b3958381907244ca06a39e2fc116eec113a6bc85.camel@oracle.com>
Date: Thu, 21 May 2026 09:28:59 +0900
Message-ID: <xmqqpl2p38s4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Siddh Raman Pant <siddh.raman.pant@oracle.com> writes:

> On Wed, May 20 2026 at 05:17:51 +0530, Junio C Hamano wrote:
>> This has nothing to do with "external notes" topic, no?
>
> Yeah, but since I added the command line flag I found it doesn't
> mention the existing flags.
>
> Fixing it in the "external notes" commit would be bad, so I put it
> before that, since it also then provides a logical place to add new
> flags.

What I meant was that it would have been better as a standalone
patch that is unrelated to the (now) 8-patch topic for the external
notes.  That way, it can move faster without waiting for the rest.

Unless this patch has complex semantic or textual conflicts that
makes it easier to manage together with the external notes series,
that is.  I think adding [--notes=...] to one existing line (this
patch) and adding a new line with [--[no-]external] on it (the main
part of the topic) can be done in parallel and it is not too much to
ask for the integrator to merge them on the receiving end.

Thanks.



