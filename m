Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8DF41AF0BB
	for <git@vger.kernel.org>; Mon,  2 Mar 2026 22:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772490934; cv=none; b=OOpfhSe7b4KU1bh9sndiT0OkEZFIGMFwcfCl61PMICxR2tYh4FhkVnbXURGQ0TONojtHy3NdSwkIz0+eSl/ByoFLkFtW4DXi4kzObhglNNQufZtz4/h7HHDgy5Kdv9ePzVFM/UVuRey+9TpPp5kLehW6BajAyttSkvjsYco6Ibc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772490934; c=relaxed/simple;
	bh=HYsuOSauerDKVlFny6Vs7jcZuf7aaFEUxZTIKlj/Bb0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Di/Q3iJHJBCQkY8L75gh/SyPrS4QR+cuu+ptxh1pSNE0VXmj9ZoWuVZGm0+2Di25cFgZWwziWOVgWwyJ01AHo8i21e7GJmAWNLa9RM9SAIYt5oHRUKdYLB84JON5BvSrtrKnOXyQ9G7z4z2Zsstoc28NnD17IG71uR5/C/TcEgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=JarNkXo7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YWHuw04c; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="JarNkXo7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YWHuw04c"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 185C71400073;
	Mon,  2 Mar 2026 17:35:33 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Mon, 02 Mar 2026 17:35:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1772490933; x=1772577333; bh=rdajfh18AF
	PRLc1Achs9cGylMrU9PKWk+89vWT5snx0=; b=JarNkXo70nuYOCfFmEjEQY1t4x
	c96LBTJ3cCn8DP8UidwMdxBYav/tOjEJ4tu7qZxKNPszkLgZeeJppVVMAiNYJeuk
	BVP+/2kDTh+rTNaKkYrkTxi3J3dTvMvSltb4zRSBV3ALUh7GLWogdPnhGqc4O7oQ
	v6zLbPEAPUfANRY633TxWuQpERIRNoDEy0tSuIuWiWnOKrRkAvmP+gUuhAgYYcIa
	qNwn03NiA/wANmrFRCfrLrYxyDJ+eS1TGU6BSXkW5zUFSimTt0Qh7h/88U3GqPi0
	diolY+uXEf5+305o+wO+drb9H4gRlosWbXCI0a0qoDb1INDyRq4YzqObmjZA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1772490933; x=1772577333; bh=rdajfh18AFPRLc1Achs9cGylMrU9PKWk+89
	vWT5snx0=; b=YWHuw04c4EmI/+kl0wsIx4MS51XVS+DGCMaUUtFP4haT0/z17Ak
	qZrox9WZ62X7YqwdGsDwN9BghNYFrAjTCYE/KW9xHF4TIhOMAui4GHUlvlD7AXwq
	BSeFoR5j2ZcFxhNXhJCaV0lG+YrXAsHNOegVnwipSMrBz056/JUU8WqeNqvV3vuf
	7n28zt7xRYSJSr5HVFsnBfaknYbbhjLE2fZpNcCKEDwszav8g5R5pDiDj8PudsmJ
	6hkefewQm1SQTPWAsLxn2VE7PHdAOegdkYfTiHN/4uHOoDiR+YYN5bUYizIQ21Cp
	2M4dV5er78yLf4wwLeSxFnEzVBM06ixJQbA==
X-ME-Sender: <xms:tBCmaV4akuT0KctiEJyV70z87kdwi2qRp3r6Sc2gl92ohDDYreDAjQ>
    <xme:tBCmade7d9b9uGQTEesGEUBT7OO_hOTmYKaR5qlatlwyH3c6qvXCxWVqxtunHV5KP
    yYrXstSW5CwE_5LZAo4KXZc9TZmNULZ0ze1By7TViTfBaQrxdOu-g>
X-ME-Received: <xmr:tBCmaZAyEll4ED73wOJ2FNxBEbXnGihtofY6cmyPQuHzKhQTn2dfbbu8A0Dz00605qWJZJKe8laweR9uwTH-KDBKmu1QrAlIgA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvheekkeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepkhhufhhorhhijhhileeksehgmhgrihhlrdgtohhmpd
    hrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehp
    shesphhkshdrihhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:tBCmaQ8dLnCJHbWqta_9NHi9B4G7mr25Vs1OI9HpQ4wBpr1BTYC7WQ>
    <xmx:tBCmaUInKEyMecWw9FgqlAyTL4iKOF6F_O_IebSaDMw5jAxhkhFgZw>
    <xmx:tBCmaZgWIXXYYSCnz_bSzUV59Q7CHcSTBVH3b7vJDpYTtle-lAGJTw>
    <xmx:tBCmaU4VsFifC7SquW-lQBYxErSSNWCE2FffLXhbRcHm8hYfhuvOfw>
    <xmx:tRCmaVo0lBgvYnWwqULLhzisMvGuMKuVM49CP8voYGf0vBOF4uztc11x>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Mar 2026 17:35:32 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Seyi Kuforiji <kuforiji98@gmail.com>
Cc: git@vger.kernel.org,  ps@pks.im
Subject: Re: [PATCH v2 4/5] odb: use oidmap_clear_with_free() to release
 replace_map entries
In-Reply-To: <20260302200018.75731-5-kuforiji98@gmail.com> (Seyi Kuforiji's
	message of "Mon, 2 Mar 2026 21:00:16 +0100")
References: <20260227234213.17633-1-kuforiji98@gmail.com>
	<20260302200018.75731-1-kuforiji98@gmail.com>
	<20260302200018.75731-5-kuforiji98@gmail.com>
Date: Mon, 02 Mar 2026 14:35:31 -0800
Message-ID: <xmqq1pi1yi4s.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Seyi Kuforiji <kuforiji98@gmail.com> writes:

> +static void free_replace_map_entry(void *e)
> +{
> +	struct replace_object *entry =
> +		container_of(e, struct replace_object, original);
> +	free(entry);
> +}
> +

The same comment as [PATCH v2 3/5].


> @@ -1109,7 +1117,8 @@ void odb_free(struct object_database *o)
>  
>  	free(o->alternate_db);
>  
> -	oidmap_clear(&o->replace_map, 1);
> +	if (o->replace_map_initialized)
> +		oidmap_clear_with_free(&o->replace_map, free_replace_map_entry);

It is a bit unfortunate that we need to know how o->replace_map is
initialized and maintained.  I wondered if we can do this without
peeking into o->replace_map_initialized, but o->replace_map is
already an instance of the map, not a pointer that points at a
lazily initialized instance of a map, so that cannot be done (and we
would not have replace_map_initialized member in the object_database
struct in the first place, if we can tell if o.replace_map needs
clearing by simply looking at it).

So, all OK, I guess.

>  	pthread_mutex_destroy(&o->replace_mutex);
>  
>  	odb_close(o);
