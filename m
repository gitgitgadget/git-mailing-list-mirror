Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C88D12DCF6C
	for <git@vger.kernel.org>; Mon, 17 Aug 2026 21:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787003218; cv=none; b=NuYRlRETAviMj9ASi6q9uiRZRFo+A7HHbSZCNuupn6NmoY/h5gkebFTqK1PPbwz8hRKFtWdjV2JTIBDrVR9B6bWC8h4aryE+vxomlXKomwwCtrjI0wYt450dlhXOriKqa2B5UdxmE65qam2O0RS9jlTqYOQQa7zxau/V7nsfo5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787003218; c=relaxed/simple;
	bh=rp5VmoHUZqbzoa5jBL4N5imxTIL4q8dRqGjxMENXPQw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=b3Wea1AoD9A4O5W1K5XJsTX9m1ZXGfCkh0SkUurKfIVu2wwX12RXDuIeVlJielU2l/J6XvOk9FeYeAoSPqQ3KGrh7HEJZK8BFBWMdinw0r7XHPqbvFohQKyZ9Lr3q8hDW0Zq6Gz9HODT8akb04YfiYWfWJocojY8WS/GFBwPlFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=HrCyCCL0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NRrPcgI1; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="HrCyCCL0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NRrPcgI1"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id CC6927A018B;
	Mon, 17 Aug 2026 17:46:55 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Mon, 17 Aug 2026 17:46:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1787003215;
	 x=1787089615; bh=gTenxT8rSN3iTK9Q3PmaLNsLvo7u18iIrkwe93WVsLo=; b=
	HrCyCCL0BswJVsckYg9IlpDBCR/nEswh/NDOsXD5G0AqgK7V/LpL9YWnWMuPU2pn
	iIUaypF+D7RF4BGVrryq5lNsGJcHmiY0Rc/qiGKEi2GTHWTu2L6kP3Q0uu1TqiNf
	Lrf/vSJ8gu1vuuc0mOz9YEkVzIL/Y9YnyrwpUXJ0WhmGHxvBVRF8FrHAZIT32k/u
	o7K/hmFNZMxANiyjtSM0O8h42AFz5doSrdQXriI49THF12PhUccoWrHxDnpHhHiv
	xZBqeyDT+wcX8baVtpH9Dz+Hcug4V7N/2JOQjNgCZds6HlzZ2mE6xvabJKi0DNzt
	OxeQlF1rcuholCLP0yjPCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1787003215; x=
	1787089615; bh=gTenxT8rSN3iTK9Q3PmaLNsLvo7u18iIrkwe93WVsLo=; b=N
	RrPcgI199TFwgbO99Z3y+jtG6ec63qhtPJh89AJJtOU11w/7i0WKC3QA3mrurEuP
	NsNMebebpQwho1l0J3AtQM2d9P4aBjWTzvGtd5L3damskbeN06cqkCew1JMOY5Zf
	yhx8qBq3bMq/JHBX9qVBcJPaZyQAC80wGu43drI5M10LRiIGDEcJnSZJmYRWovDC
	4J2Z8LCVFMCnj9fYbcx9axpXFb7Gt0EoDBtVIpJuXQCF+cKxvQbhpyS8Yg55sdn2
	tGe0xmteMSrhnM++1C09m+625Z7eJ59XzZeu8iCxxH05J1at2sVKL2IFFV7SF0V+
	yUjx+GunjJlZa8lJlO1dw==
X-ME-Sender: <xms:T4GDar4ZEUzY90ggsus648bqdoIWoS5IjaxZCDdZawL8xSVbQlUNoA>
    <xme:T4GDaknrATdCT8jbfhEVom8aumWWQLQoeJSPZOdodQ1GEeuAu5IaZq6uWPAQUZwEe
    tsX1LWXrHrSFYIaB8bHd6ci1BbT5sdWgDR79F-rG1ZVZan-4bRIjlc>
X-ME-Received: <xmr:T4GDasQeRKOTre94hdVDDk-L-eaRCITp4YrEFIEcEd6jexVGcQ2CYeuEXjbGFhjfTG1sWlI6Ync8RD4W0WifDkgYrCMwR5IrHg>
X-ME-Proxy-Cause: dmFkZTEodoEkvebJguRv1Qo0/jwQb4QFSKTdxpWV+P7d7FW68coDT1c3Ji3VuMQnHeXnnX
    FfaeYwmjSrsgIB1EeXYtt3YTGLc5aUALVIkHcCdGK2psly2+1syK7zTef5zBfiqMXr4eeY
    UTiryaQ6VwUE7H7NDjy2/twJrV4czwTVvggnztAiLPeTP7lezFlYOeJtUktdtXuvU5Sb0l
    yVG6Ft4s7DFsVoviCcKowCs1DzN7xkSOI/YpeznQ6hRrqXFlCTVSAYOnZhc1Fh2CK3/+yF
    M1RIk2TdRD7F1dF3DF8D5+MSeYHwhjfBOaxYs9c8D4OSoZaHSR7SazHwPoL7dH2JHutGhh
    oYXCBbL95zDt/22ajaSoRtnoUGVXMEB6mtoiZf/qUCAtI1TUTHtojbiOYwObZyDaDlz+JV
    R/wg2apJUV8cpRDEb8NWOqFgIDoWpUKA1lZnFHp/ensuX+nU4vgIboThm5ezaML/zePwwe
    8BgsK7fJC5ytbkSCgdlr1zFQd6YejNpu2K9L5TQVl9KdukKf7i9y4qyZ1okJ2RvvJxiVl8
    vkb1MWo5oCHj2iPrAU61BuUzrfEcCLTXeSFIt2gKPzFwzp5Yvx9bFp1hVsGVnyAhSoPueI
    pA3+Q+niMvJMLM+lGkS/qj4W0wQ3x0xCuEH9V+jvXS3Ff2fvbTW7Bg+DGy6w
X-ME-Proxy: <xmx:T4GDajGhQvBoZCVYmvDCQXfOZgFQVID262XpZMbEX3yIw6WhOCe4VA>
    <xmx:T4GDahF30qYlt_N4Q1CyudYjZ0vVKxebmBYlUnH2F7Z-a_He1gD8qA>
    <xmx:T4GDahQXci-1uaL-A9vyruIyAsVUmWRqcT1M8MpQzi82pESaStvQNQ>
    <xmx:T4GDaiJCyGDDqS_7cBOtpdUg163j9c_1_6ulba7lTGHmqZ66Dqo5BA>
    <xmx:T4GDai1KBE95fxxrQHygMSnOh_Rbyas21LkzSQqIYj6S8SBJPO5EJemv>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 17 Aug 2026 17:46:55 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: kristofferhaugsbakk@fastmail.com
Cc: git@vger.kernel.org,  Kristoffer Haugsbakk <code@khaugsbakk.name>,
  Patrick Steinhardt <ps@pks.im>,  =?utf-8?Q?Jean-No=C3=ABl?= Avila
 <jn.avila@free.fr>
Subject: Re: [PATCH v4 0/2] doc: format-rev: use [synopsis] on code block
In-Reply-To: <V4_CV_synopsis_block.b8e@msgid.xyz>
	(kristofferhaugsbakk@fastmail.com's message of "Mon, 17 Aug 2026
	20:51:47 +0200")
References: <synopsis_block.af9@msgid.xyz>
	<V4_CV_synopsis_block.b8e@msgid.xyz>
Date: Mon, 17 Aug 2026 14:46:53 -0700
Message-ID: <xmqq33wc4dyq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

kristofferhaugsbakk@fastmail.com writes:

> From: Kristoffer Haugsbakk <code@khaugsbakk.name>
>
> Topic name (applied): kh/format-rev-doc-synopsis
>
> Topic summary: Use '[synopsis]' on block in order to highlight
> placeholder properly. Also quote the subject consistently.
>
> § Changes in v4
>
> Sorry about not reading carefully. An open block is not a code block.
>
> (copied from the patch note)
>
> Fix block: use open block, not code block.[1] This is what was done for the
> synopsis blocks in commit a34d1d53, the commit mentioned here. I have
> tested this with what I believe are the use-asciidoc (tool) and
> use-asciidoctor (tool):
>
>     make doc
>     make USE_ASCIIDOCTOR=1 doc
>
> And they didn’t give any warnings. And they produced the correct result.
>
>   🔗 1: https://lore.kernel.org/git/xmqqfr0hqzvl.fsf@gitster.g/
>
> Rewrite or flesh out the commit message to reflect this newfound knowledge.
>
> Also remove the Ack since this change invalidates it.
>
> § Cc
>
> (See v2)
>
> § Link to v3
>
> https://lore.kernel.org/git/V3_CV_synopsis_block.b64@msgid.xyz/
>
> [1/2] doc: format-rev: quote subject placeholder before and after
> [2/2] doc: format-rev: use [synopsis] on code block

Hopefully this is now ready for 'next'.

Thanks.
