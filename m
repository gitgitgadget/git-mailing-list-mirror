Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23D9C1E2602
	for <git@vger.kernel.org>; Mon, 12 May 2025 17:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747071858; cv=none; b=gWIBrHOP5XASMx9zIKqhdbKs6ypP3ANICmZ6qooOI2A9jW9qITxjyAnZMOJBHEynZpei8zUX0GrmeiS9HBeWkjq8Q1D4oB//F6I9gEcIOiZyD525AFcVaCVj+xdjpPbgOeTa/HZGdm3jvjjUqVA5Cd7Ni8twgEkZv6/3nrg5CB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747071858; c=relaxed/simple;
	bh=HqE8sE5gk7X6tbkZkcCuUzyLHelnvhucsqyTt0Fqy70=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GaYmhQadWjPRWJfF7kf5he4lYfTG170xae9DLLmPRs4mFp3oUlpOlMBuxsnoQaJ8QwlO7oR3kDcN8WfceWLtMBZ86qkiVreCp1zSnp/Wx94L6IsVRvrOMrRQGqX5MWC4z3IHgL4lfGbIZ1Jzxr7CoE1umWYnzWuo0KpZZ7SoNTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=GaWhKnuD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QsO7uWDc; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="GaWhKnuD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QsO7uWDc"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 193F6254015A;
	Mon, 12 May 2025 13:44:13 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Mon, 12 May 2025 13:44:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1747071852; x=1747158252; bh=BL/8BZaBTK
	xX484G4pnI3RfK6ILVd33c55jwHuuPXI0=; b=GaWhKnuDw5nygVlpWUH7PaTOpr
	j79otg9VS6ifD/8X0JDDUCHySZ8ODY74869I9HpjUsHLYLHtfd9Kmrf7gisfBTCR
	r5P2nuw0rdxAY4r3razpclYntC89jVbSdOtOEUNIVnwsV6MmWtvA0I1uEku6IMqB
	D7WrIxPbWjhQHNiG6wUB9gpO3YEDV1LN296LIBTibnbAvm5OJ28AhGrWjDnhjJ4C
	GoDlCaPt50zYf0ziUb50Y44ti3kPDJE0n6MjPVg8gVKnqsF4Hu93uB5V1DtCO+E3
	4+hjjnfWqw/et3rKh/+mGkYcFGwPXDHvQ0+dgVIdMpY1+4HGXD/6DZfW8uMQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1747071852; x=1747158252; bh=BL/8BZaBTKxX484G4pnI3RfK6ILVd33c55j
	wHuuPXI0=; b=QsO7uWDcyYvkyZ7uEvyOIfoQrf5FNRuXoQ1XZJtdNlCkClhj1+7
	AU6730nrhcH0JoMo+l+P6JCwLDk8HuFkeLrjup19DwZwfHxKlaDvU1aFexf7TzXL
	oWBvbhgqf7cxmw6vj4/LnUFYkNFUKNCGIWhKHidiwerDKgByHDm1ZTst730Sb8Ut
	Qr8tZCsERKtb8svcDiiZwupxU6VVGqae7CjYQ6zvQjXHhHoY71+BvD81CPq0RYU1
	BOsrZOmlWK/hDDvnp8F7/Su85qCd8pJ+XPmRWkU7wIVGUIyag+EyfPRtCOiadIZb
	P3IklfhU2FnLhLG/QtnB3qFTx9BO7gKFpPg==
X-ME-Sender: <xms:bDMiaHwfOTH2hr4II85R6m6LZDRCx-MTX_6SqOuktjENoPDRCAeNOg>
    <xme:bDMiaPTr4R3CxfNJUw9BMSjoPS0OHL7lY4-nMNSMp3lDLy7H_Qn1cWXTlIn790Ic1
    Lig7jwu5iUSkk5SlQ>
X-ME-Received: <xmr:bDMiaBUHf8c8j_BNRzuFT_XB98rgT6Gn3G6yl0GYnyrAR3-oQ4xjTwEuuOs7PQbK87U2KVKNk7r9728l7vA0N-WxI0Cdm_bTX0HmkjQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeftddukeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepshhtohhlvggvse
    hgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhl
    rdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtph
    htthhopehjohhhrghnnhgvshdrshgthhhinhguvghlihhnsehgmhigrdguvgdprhgtphht
    thhopehpshesphhkshdrihhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtg
    homh
X-ME-Proxy: <xmx:bDMiaBhOshNF6Qphr18JATeteZNsZiIhUGtVQZgmRodOdmyamoMPfg>
    <xmx:bDMiaJCUeJ-VAzIMbC4KrtWk2M-E1hAI7GBwucOpUfkMqKgXeWBB2g>
    <xmx:bDMiaKI9d5H04R_NljCdfF6O4cep6xqnf037G27TAjeADmkvq-srWQ>
    <xmx:bDMiaIBbGtE7hUHj2dMn2sICIZ6lYb7nJhRfpN0KbNYeVcq03tQXaQ>
    <xmx:bDMiaJ4W3Le_icSEE9_mmn9aEV2xV85WX3-kSFIeA-YxlqZqcUa2a9i->
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 12 May 2025 13:44:12 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Derrick Stolee <stolee@gmail.com>
Cc: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  johannes.schindelin@gmx.de,  Patrick Steinhardt
 <ps@pks.im>
Subject: Re: [PATCH v3 4/4] scalar reconfigure: add --maintenance=<mode> option
In-Reply-To: <35ecaa1d-589f-4d28-9d97-78bae8de2d41@gmail.com> (Derrick
	Stolee's message of "Mon, 12 May 2025 10:34:22 -0400")
References: <pull.1913.v2.git.1746458844.gitgitgadget@gmail.com>
	<pull.1913.v3.git.1746582637.gitgitgadget@gmail.com>
	<684f04aaf7e87f22ab0b00a4fd42d2943304ef04.1746582637.git.gitgitgadget@gmail.com>
	<xmqqcyckayb4.fsf@gitster.g>
	<35ecaa1d-589f-4d28-9d97-78bae8de2d41@gmail.com>
Date: Mon, 12 May 2025 10:44:10 -0700
Message-ID: <xmqqy0v1sp05.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Derrick Stolee <stolee@gmail.com> writes:

> My intention was to bend over backwards to prevent a behavior change
> in the default case. However, I'm coming around to understand that
> we don't need this background maintenance to be redone every time
> and can become a no-op by default. (Other new configuration will
> still happen.)
>
> In the case where we're fine changing the default behavior, then
> the standard --[no-]maintenance option will work, though it is a
> three-way switch where the lack of its existence means "don't do
> either mode".

Ahh, OK.  I misread your intention.

If it is common for existing users to disable maintenance, perhaps
by mistake, together with configuration changes that are not quite
right, perhaps also by mistake, and if they used reconfigure to
recover from such mistakes, it indeed may make sense to nuke the
current setting and enable maintenance unconditionally.

As you suggested in a part of your response I omitted, we can
annotate <mode> to give hints on the valid choices to help users,
without changing the default behaviour.  I am personally fine either
way, as long as we clearly document the reasoning behind our design.

Thanks.
