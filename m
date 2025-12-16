Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9963922D7B0
	for <git@vger.kernel.org>; Tue, 16 Dec 2025 01:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765847982; cv=none; b=Hg4VP7229NCnTsbf18ahZb8U7vVFNlYJHwmNQM/oTldjeooOS+R3Ghi0QkJmd74gNKIGS9lByQMW43YsnB3jNqQ3n8YFqj+HmGsP1cq8JAcwPXOY/W/9A0RSI5BIcSORbVMPqbOC8G7jS0ELuHtcTT2NY3DMjY9MbspSd9bqs6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765847982; c=relaxed/simple;
	bh=pkFzLsFUAXp/fgUny3JRIiY0xXmxt6qIOT9lXTPuzFc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SkkG8oFoeaKSmrEfjjyhWO2EtjMgqyAcyQd2fEr0sKn5fl8FTdy3UuLasnJNbM3j1ejQpv42fhaBeizq+dX2981EvJEeh4MmC4gJpBFiLCbLGySjmeYalXFDAh8uWP1NNlGjE9I8TPBh0eZH2vkPEFpgthY2E0fVcEei296T5pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ScePyRZy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DlMk1HEU; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ScePyRZy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DlMk1HEU"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfhigh.stl.internal (Postfix) with ESMTP id AC7D07A01E4;
	Mon, 15 Dec 2025 20:19:39 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-08.internal (MEProxy); Mon, 15 Dec 2025 20:19:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1765847979; x=1765934379; bh=zmPALl9RLd
	CUlcjI/dMhQ0NOSMq30/UmLrK/KTD2r3A=; b=ScePyRZyfsaU5LJSF9/2zQOQM0
	y+wEXVGPWGrVFnOkvODiX1sEToQiJCynrLSn6IryqAaD7wytWZECNacPOp7+W0qE
	2oR/FXpPHC817n8THvjIfC7aYtt1sTcZOw+xJYFYf2HxXaHdMlopUSBujHWEOf9X
	H9KU45DqpO2f7f/cZ6A7+E8caFLgZQ4kKpFedmoxCTfHHv8MduanA0l9GZKTK/zK
	yveisMYTmqnbtPXVx3Mn2opl3NjqcnttL68JwKZgoY2AW5xvceor1vocCdSflj5p
	Dc1KFg7CNevi/z05wZZZ5p45qFFAdgaJCmpTqVFCe+Ae+TZesAQrWSAVKreQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1765847979; x=1765934379; bh=zmPALl9RLdCUlcjI/dMhQ0NOSMq30/UmLrK
	/KTD2r3A=; b=DlMk1HEUpaZSlu1ljmUvtxxBigSo7FtqN02FcIDo/+zRmB+Govt
	gwrpYgp/0yebDBgckplmUB7dY/gNUmKlqmiv0I3UqkkBG2lWOxrtg1I3zCWQIeUB
	P1Zz1qOV+jPZsnrvYFbpSpLz3ii2naCjVbRM4ycb3CHW5wfqdqW+bL3akGMX94Vs
	kWKHDTq2dXynLGabwEpepa4hUwEaaPLyZLkIsVOzW6KNIhhaCOFHpney1tmdiiEB
	Eqoifx77BaUV3+G4tmwKy92btH124UPtIjkECYAwIkOkM5zLczZV7HTQz+71rO8b
	yW95CtyAKUTXvxBz75pNwOLt+M+3mE8KYKA==
X-ME-Sender: <xms:q7NAaXOt2Rwyu0LPxgwRMQR_l0XskbR_VGsmSePJuM1u8YK8XeRAdg>
    <xme:q7NAaY_stt0MT5PbReaoeI_8KJZGYoXINO09DQlXjZG1RqLT5YOtgZ79GrO_3kxIT
    saTbX8eHcoMA6H61Jt8ZlxEyz1uVkIjxi3y4OwPU3s7L3C0hhBdETE>
X-ME-Received: <xmr:q7NAabRAKUMc37opq4KKGa2ke9MiH5QBNgev5j9N9vJGRpaRZV0ujWxvqT1u8J4iJ_6YzohKxI4KH7_sXn3A5rh9mEgsxMRNmQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefkeefiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehjlhhtohgslhgvrhesghhmrghilhdrtghomhdprhgtph
    htthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphhssehp
    khhsrdhimhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:q7NAaalSwj84lYtGBInnV2SDsID_RKs7FWZP-0-E9fyHbhsIqkrIog>
    <xmx:q7NAabQ9DisqJo_d8cJtHk1mTYMvaA8Fi6tzh2sHjmsZOR14tgfPew>
    <xmx:q7NAaYNLBmkeYOR9ZGI1XkD1TyZaJoboVEbxeunnr3b2sfOufYHK4g>
    <xmx:q7NAaUXsNB73qhxLZ0YoUoj7BEW8xVOZW6b8IfIa5GQAGBsF8wVQ6A>
    <xmx:q7NAaezPbByp74lifvjCy9pz-gQPV8UBsB7UmD7s_A3RAQF8bWr4RVwM>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 15 Dec 2025 20:19:39 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org,  ps@pks.im
Subject: Re: [PATCH v3 2/7] strbuf: split out logic to humanise byte values
In-Reply-To: <20251215205639.2700270-3-jltobler@gmail.com> (Justin Tobler's
	message of "Mon, 15 Dec 2025 14:56:34 -0600")
References: <20251212223644.3090879-1-jltobler@gmail.com>
	<20251215205639.2700270-1-jltobler@gmail.com>
	<20251215205639.2700270-3-jltobler@gmail.com>
Date: Tue, 16 Dec 2025 10:19:38 +0900
Message-ID: <xmqqms3j5il1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Justin Tobler <jltobler@gmail.com> writes:

> +		*value = xstrfmt(_("%u"), (unsigned)bytes);

Does this "%u" need translation?

I very much doubt it, but if it did, this does need TRANSLATORS
comment.

> +		*unit = humanise_rate ?
> +			       /* TRANSLATORS: IEC 80000-13:2008 byte/second */
> +			       Q_("byte/s", "bytes/s", bytes) :
> +			       /* TRANSLATORS: IEC 80000-13:2008 byte */
> +			       Q_("byte", "bytes", bytes);
>  	}
>  }
>  
> +static void strbuf_humanise(struct strbuf *buf, off_t bytes, unsigned flags)
> +{
> +	char *value;
> +	const char *unit;
> +
> +	humanise_bytes(bytes, &value, &unit, flags);
> +	strbuf_addf(buf, _("%s %s"), value, unit);

This definitely needs the TRANSLATORS comment to tell what is going on.

> +	free(value);
> +}


