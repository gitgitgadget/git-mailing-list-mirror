Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 535DD36D513
	for <git@vger.kernel.org>; Tue, 17 Feb 2026 16:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771345223; cv=none; b=Aaxo8En+1VTURYAPH+wZbjJ8uLwpfYXtCxhIxA/+AEBYeIboCKSZfp7wOuTCZl2pJXmdjAWl6FuZddewhpw4jSXjRoaNvTlDFr8OECXaxUjBn+Bo0P9Zq6TnCdHGE8fKUR8nJFNMfTnAAjrQmmt17gpoZIvpxsh2WKAM+A4fS34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771345223; c=relaxed/simple;
	bh=kxVgpllsHD/8BC0qqL8o3JkdnX0Isxh5pNHWIeDPJrI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JStA0IpuiM6AKyA1Fq1eih1CaZgi+Qz+LdDmB5oO4pDFzltPTP8qbTw3UB+6cP+Kn1w7lrgnNITfq9qmnjLiMpnuxRZ+IPb+t78JYqvMfcQkHc0JXI/5czepA+5yaBXx1zMXR7eeXeicpBuHJ67uQ5LZzxvAQCP8Hs68/CRO/wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=oKDOCM/6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DhuL6O7D; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="oKDOCM/6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DhuL6O7D"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 90F14140010F;
	Tue, 17 Feb 2026 11:20:21 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Tue, 17 Feb 2026 11:20:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1771345221; x=1771431621; bh=IKNePJ9cbP
	UpFBv7JmTg7g50iUX5VABebHeEBom4NSc=; b=oKDOCM/6ABluWFMrdf3TLT2vSz
	M4zVqXpVhyv6pgXdCB7F7DGtRlv4lSZ1wnyFk1FKF+lK2gr/YY40ZPB5Va7lf98H
	u2UUcUPZrnRyif8rGZtTELDEmYzhQZmML1YFHnWigNFBoPNKZzizOxpu7oKJElFO
	+ec7MozgAsKndJ1OGBI1ZSWNYzgqQuZPt9Dahd4LY99QMc89C9WMm4ZrQXXkIbkS
	HGiXLQ/A3wZBj9PGkt2lJ7Sbhmg/p9A2BdCAmF6d7Rot1Imp27l0NTwELb3wpu2m
	QwnXUDsLilgd7y4PTpQutdgmLi/BoluMdN30mHXDrN5HW16RR8RkFqpOA3Vg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1771345221; x=1771431621; bh=IKNePJ9cbPUpFBv7JmTg7g50iUX5VABebHe
	EBom4NSc=; b=DhuL6O7DoJlVOhz5iv3hLDWhFvIhK8RNYiE+NJGyVfj+7p2D2u/
	gEK4ezgnIkP6MjU0AtSbFuevhoGA2W1g2/wmQU73zzKkMhOFzOwAfbYvhYX27Gwv
	X4zsWZW2QxNOrcKceFeum2KDSPF3bQ2g52J/Tou4afT+iFmANLqR9vy8MnZQq90R
	FaQ76W2Soxc4uSXAieiCbJTbJO6ehoSQTbEGnKgyCpt5d11p7+XIZ4KCxcZtzkAJ
	2QbD5WzZndHoRRoYPyoxcYpoLCTGVI9zt4oW/DHIZF41cNVtpB8ueXeE5S5NAog1
	3joWIfyxejHw/cjojVjmJCljVhghhEHzrmw==
X-ME-Sender: <xms:RZWUaXzBIKCzdyZEmxkkKTgZfPxIpyF13gY81whApYRMrVqtWn00qw>
    <xme:RZWUaR2qy7TwXb90stEf9zxKzcXHUZuXgsBe2Xu-BUCudCkw5_EkPUSLpQyJSRnSA
    Fq1deuOAGrPLri5tSWyEawIXlvcCUVIWSOa1rr7nFcYwLs_1IiH2g>
X-ME-Received: <xmr:RZWUaU9RZ3UM8_E0-wfzgl0EmBUOei8oi8wxNOFGHWCva8O97jA03Ri77uKN5UuijR58gvhmcudEkhyGv-jFb87aUxmk_VlpZw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvvddtvddvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepledpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehgihhtgh
    hithhgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdr
    khgvrhhnvghlrdhorhhgpdhrtghpthhtohepshgrnhgurghlshestghruhhsthihthhooh
    hthhhprghsthgvrdhnvghtpdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfees
    ghhmrghilhdrtghomhdprhgtphhtthhopehkrhhishhtohhffhgvrhhhrghughhssggrkh
    hksehfrghsthhmrghilhdrtghomhdprhgtphhtthhopehjnhdrrghvihhlrgesfhhrvggv
    rdhfrhdprhgtphhtthhopehsthholhgvvgesghhmrghilhdrtghomhdprhgtphhtthhope
    hgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:RZWUaRpOa1R4yiUjucjtALUtlff1cZNk0t9PbB1Q1kbmrhgFjiW2uA>
    <xmx:RZWUaeTMU2ckGTeS3QueSIF7R9iO0eMiQ0CQajw1gNiw2tAf2H5Jng>
    <xmx:RZWUaUPLlPTDV-HblYwAtgcPoW1pilbednfGEfShWHz_0n9xtJjRYA>
    <xmx:RZWUaci5wxbxj4EtrGgYiPbr8JxNKgFSGKHPW89JkFf65zoKA2RviQ>
    <xmx:RZWUaY_02JJXuEQBuqho6kUEFiHeSkYafOwAxnWj6Cc8_B_SQ-BNpvWp>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 17 Feb 2026 11:20:21 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  "brian m. carlson" <sandals@crustytoothpaste.net>,
  Phillip Wood <phillip.wood123@gmail.com>,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>,  =?utf-8?Q?Jean-No=C3=ABl?= Avila
 <jn.avila@free.fr>,
  Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v2 11/13] color: add color_parse_gently()
In-Reply-To: <aZQvT_fTlUIJd1DM@pks.im> (Patrick Steinhardt's message of "Tue,
	17 Feb 2026 10:05:19 +0100")
References: <pull.2044.git.1770698579.gitgitgadget@gmail.com>
	<pull.2044.v2.git.1771026918.gitgitgadget@gmail.com>
	<ddf6131ac9283bfbf4ec9ec000606765d887e6ec.1771026918.git.gitgitgadget@gmail.com>
	<aZQvT_fTlUIJd1DM@pks.im>
Date: Tue, 17 Feb 2026 08:20:19 -0800
Message-ID: <xmqq5x7ve3zw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> On Fri, Feb 13, 2026 at 11:55:16PM +0000, Derrick Stolee via GitGitGadget wrote:
>> diff --git a/color.c b/color.c
>> index 07ac8c9d40..ec8872d2dd 100644
>> --- a/color.c
>> +++ b/color.c
>> @@ -264,7 +259,8 @@ static int color_empty(const struct color *c)
>>  	return c->type <= COLOR_NORMAL;
>>  }
>>  
>> -int color_parse_mem(const char *value, int value_len, char *dst)
>> +static int color_parse_mem_1(const char *value, int value_len,
>> +			     char *dst, int gently)
>>  {
>>  	const char *ptr = value;
>>  	int len = value_len;
>> @@ -365,10 +361,25 @@ int color_parse_mem(const char *value, int value_len, char *dst)
>>  	OUT(0);
>>  	return 0;
>>  bad:
>> -	return error(_("invalid color value: %.*s"), value_len, value);
>> +	return gently ? -1 : error(_("invalid color value: %.*s"), value_len, value);
>>  #undef OUT
>>  }
>
> As far as I can see this isn't really about whether or not the function
> should be gentle. It's rather whether or not the function should print
> an error message when it sees an error.

Do you mean that this error() call is not die(), the flag does not
fit the usual "gently" criteria?  In other words, should we make
this call die() if we call it "gently"?

>
> So should we rename the parameter to `quiet`?
>
>>  
>> +int color_parse_mem(const char *value, int value_len, char *dst)
>> +{
>> +	return color_parse_mem_1(value, value_len, dst, 0);
>> +}
>> +
>> +int color_parse(const char *value, char *dst)
>> +{
>> +	return color_parse_mem(value, strlen(value), dst);
>> +}
>> +
>> +int color_parse_gently(const char *value, char *dst)
>> +{
>> +	return color_parse_mem_1(value, strlen(value), dst, 1);
>> +}
>
> And if so, this should probably be called `color_parse_quiet()`.
>
> Patrick
