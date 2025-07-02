Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7643B14A60C
	for <git@vger.kernel.org>; Wed,  2 Jul 2025 07:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751440612; cv=none; b=VznzUj05sckUy9tgmDQDptiKc6t/ZCOW/v95cP7UNokg+rpDzBNNOuXFq7g5P4ut5VEngPZdRpacoN1YaMhnYsZX6nWaPCj8thyzc6kdEWHWEuvmR9KXocYPM4lPeBe9ma3F8uXks52qkpZrCjBgkJN2eWglfcPjUtEgALgzOkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751440612; c=relaxed/simple;
	bh=qX/lKJoRxJY5WfRjS8jKF8q1FsqOEvrzKtuqGHCYLFI=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=Idc0yITc3usXOhYP6c8SvFpy3hAFNXSMyPjpYMjiL+8vzDstPbQlUaWItUpKhPEGEJdxiKkZw48kZq2xCET+2UAYlKzBZGoXgKwMX02EgghQRRWwhTSPGJZBnlBAfnUT9uBQxRmBL+HaO9TyOheQXw49WU8/4KEiyuLBUReHNxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=yG2mmcWi; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=g7qFehIi; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="yG2mmcWi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="g7qFehIi"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 92BE41400310;
	Wed,  2 Jul 2025 03:16:49 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-09.internal (MEProxy); Wed, 02 Jul 2025 03:16:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1751440609;
	 x=1751527009; bh=xBadST5B3h1POsmoVaXbsp6odiz8FrR7mIjZuQbJMTU=; b=
	yG2mmcWiYShEGutounxHe2IqF1ou5QVyEC/nEi8M7akf35nSA06n88NLrx8uR17y
	8Xv3H1od8b/9EmKgM8ETIEiVcm2Z4PczctkQhzz7NNrzrGbVg7DFCUzYB5g1m8VF
	klam21FyqPHf6L4kwXZttaZfUkPrk7bfXWXmtyGWVtB0kdFwoWLu7DiMO8kXFr6z
	lPZR8VjzMRA2Udmp0me/hK8UR73KxxfuhGEvFcHZpH1lXJT5qVPQwu5Avlu8ZX8h
	l3inu9ysFVXIz67eDmn8IbKH1w44Qhlz6Vqt95rdJqEOaQIl/jdF7nl+wKjyQQft
	HsLVvSWmEIapFmHQwQoTRQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1751440609; x=1751527009; bh=x
	BadST5B3h1POsmoVaXbsp6odiz8FrR7mIjZuQbJMTU=; b=g7qFehIivAiRTtkGg
	tv8I5FfwGeB2xVavIUTah5RmHKQfuT/abzcuzoYK0Md6+bjCG2q2SIkO95yDxHLQ
	6O77sTVNopbkyNPUyF+ztkzmHwIndC5IrRcdnAjqLrd0I1ugKE62o8IOt1J/AsS8
	AbjYcggBWTPNj1FZbW/iNTdnG+5fPL1BVoHI5Le5FioF2ag+lhY6pUqi6ELQAcZ5
	YUiulhVBlQTAgoMiVPGzkimQ/i+8OBpvSt+UvuXcjPb0VfkfaCf9T0/12zBXvzr6
	e/FEPxzYWrLp+A2QvbRvHhw0sZhdIWjppwhl8hmMVtR2WRw/+wY2/dETz1rCILQN
	Gns0Q==
X-ME-Sender: <xms:4dxkaBRUx05vBgY6r4mA4yMtJfSOMDxv8wyTXproaZYQmebtbYFskvI>
    <xme:4dxkaKzgzsLyj-aIrFWJDM8g54b7NnGWeeopIIzwrMIBEXm3V5G0ElAqYrSxteb32
    JZdnAY4uLglgFWoiQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduieejjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhepofggfffhvffkjghfufgtgfesthhqredtre
    dtjeenucfhrhhomhepfdfmrhhishhtohhffhgvrhcujfgruhhgshgsrghkkhdfuceokhhr
    ihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmqeenucggtf
    frrghtthgvrhhnpedtgfffteetudelhfefkeehtefggeefjeevieekfeefieekkefhveei
    ledtkefgueenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdp
    nhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhith
    hsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhn
    vghlrdhorhhg
X-ME-Proxy: <xmx:4dxkaG2J4A2J4BnQ7yfr_umSlqksrt0QxWrXEoStWS2PswoFgUYNlQ>
    <xmx:4dxkaJDdcR9YuLRJ-9FxQ_N-RRRhdIT8fJwn5zcM1YZnS99_bKtu_A>
    <xmx:4dxkaKh6jg3BGwka4dWwYM_Laie7fIexeIDMivvuFIehVbS-VIOmKw>
    <xmx:4dxkaNrFowu8dtogqJsI0aTOudBwi0RQaxlmXBcB-ItKmfHHF5nZCA>
    <xmx:4dxkaPZpY24cN1EN1Y4eB2Rjh-2hc_zMBKHBabxCQfbaGQz_dF_20Hwo>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 5464D1EA0066; Wed,  2 Jul 2025 03:16:49 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Tad7c12f59a96d8fa
Date: Wed, 02 Jul 2025 09:16:29 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
Message-Id: <5c12c2f7-47b8-4908-8ca5-5fb95e0c6e13@app.fastmail.com>
In-Reply-To: <xmqqwm8rh00m.fsf@gitster.g>
References: <xmqqwm8rh00m.fsf@gitster.g>
Subject: Re: What's cooking in git.git (Jul 2025, #01; Tue, 1)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 2, 2025, at 03:08, Junio C Hamano wrote:
> * kh/doc-config-subcommands (2025-07-01) 5 commits
>  - config: mention --url in the synopsis
>  - config: use --value instead of value-pattern
>  - config: document --[no-]value
>  - config: use --value=3D<pattern> consistently
>  - config: document --[no-]show-names
>
>  Documentation updates.
>
>  Will merge to 'next'?
>  source: <cover.1751382830.git.code@khaugsbakk.name>

Ah, so you=E2=80=99ve normalized the area to `config`.  I had a mix of `=
doc:
config` and `config` since some touched both `builtin/config.c` and the
doc. I=E2=80=99ll try to remember that for the next time.

--=20
Kristoffer Haugsbakk


