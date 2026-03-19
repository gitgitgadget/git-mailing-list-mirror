Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5F283E8C67
	for <git@vger.kernel.org>; Thu, 19 Mar 2026 16:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773936530; cv=none; b=jMWpmxvTXbJsuhjJFsNj7ooLjFUcJQ1n9IgLEcY8BsJpR9c5MxIV+YoiGDuTmFoE+zg0iprwm5NWhO16NRNW7lGzSI9/HAJQgMMZyfmR+04OcMr11F3FBD/vy70K7n+D4EOQwPL7Kyq1jLTMZILt6alk3t3SIXJH14wsHLseYQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773936530; c=relaxed/simple;
	bh=YLwOioIuQ1xGMvaMbWhswquegTFdQ/xZIAtEXUW4MnU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WySl06HEmoT1mMXj8oOaVxOBwKluwqal3h/KaopNWcyFftNY/omSg6Ika+HRx1Rr0Jn+ZAGWw1Iy4YIKK+VTIS/Gdd2AIfOQfSPs88LZe+wg4vi3hHlW1kqUoXnJ8zjmrdE3Q0pbVWFl42oEFFYL46K9jfEWYdKVJ2OJZzJMg4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=i5/KdQcK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BIRAbbB9; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="i5/KdQcK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BIRAbbB9"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 05F6D7A01FD;
	Thu, 19 Mar 2026 12:08:46 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Thu, 19 Mar 2026 12:08:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1773936526; x=1774022926; bh=3XS1VFy0ZW
	BADZKfrA03MJOYCWUwNybCYQMUL4J5hhI=; b=i5/KdQcK8T0jQxATfKfqkvy5Of
	WeWnGQTa70G2QeYwD7hDROY5sM8eIcJdg0MwzsbkE2b4ptWk3IE9NNA0GoxNZeCZ
	lg1ru7ioTOks2vAlFOQnFZYVotWU0K0TMKu4XESrPgXp8VSeWh1MVTNBTJC3OPRS
	O+q33FqSLFUyiDoHNsB+tJc+tdkzY40wGZuR1aJNuNJO4ujvOEQGvguk9jO7VOs/
	VCtd+X100Gp+YUICqSxyzllbg7Y+/i7JQ9pT7U6lkr+z241aqGXcTguEsardX+6o
	70kdUMHPvHJ4iUVL9Dq9uvESTJYEB4AqpFJoCqMpuOdBzMGsGKLtbIA4eN5w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773936526; x=1774022926; bh=3XS1VFy0ZWBADZKfrA03MJOYCWUwNybCYQM
	UL4J5hhI=; b=BIRAbbB98sblWiG5pvFDXNWULengRM2gDg95yTNIxe0bB6FoOxE
	FOXvafV/x1kLO1dvFtKGGRl46Kttv07Lo/37dpuQksXU9HwW8gIvRZVdajSwEq+Y
	mg88P1wGELB/GtCQCtvvBAM957jM7K2Dsx/wCpgI4ds7BPSFyyBE79TCKHLJNqHo
	RK4EGqOFpKWnttnajuM04FFMpj8JeQpNw4AO/tjDjs7f9e5xj55KWIkJ7kb4cA++
	gk/prn8yH/pFE1zUGugyNFDZVPzkS8M/PuBKS7LV1JTQSarzfQ52zndwY6p/sC92
	nRSXbgk2Q1vY7K3KGRALNOALMFDnuAgF2mA==
X-ME-Sender: <xms:jh-8aWTB6MvuBN1IFk1-pQvljQuNxd97teq0WKgObLZ65Iu6NDwcgA>
    <xme:jh-8aTMn3KFDyRh3wPYDcpSffQSstuWKapbOVU_HNO_WOXqEwZuLrXEpIJNPSvKdW
    6wsrqvP-eDO0wQk-nHGBrIIAOvk8SmJVSxr6iSxAUX5k7wELFug8A>
X-ME-Received: <xmr:jh-8aROLdke2ppgY7of0NdAcxnu4MC3e2k1358dvzHp1kMEw1SzjaXlR4-hXlqYDBq6A3p789gaFDg4Um6mr2U6CLl8p4ANXzQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeftdejgeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehgihhtse
    hvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosgho
    gidrtghomh
X-ME-Proxy: <xmx:jh-8abvMuoaz7ir5gj4OwjqRpk0fugpKpvikT7LfE5DF8SkjgFdBCw>
    <xmx:jh-8aTWpPoK_HOqIEh7hvs5ZFK0gV_xM3PxcTlVFotKBr-cM8KGvUQ>
    <xmx:jh-8absqIb6xcjcKAYc5NPbGWeeTnOCv0DKmG0py_DnBBI6wWq-efg>
    <xmx:jh-8aXU9urwuG8GuvTt9pk9rCxzjXcYZGK1PXYgwyM7OHwb4xIjCyw>
    <xmx:jh-8abUqcu-aYtHWxVN-siGEMW9w40eevrm_d2HuJdfCFoMm_l6BmGyX>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 19 Mar 2026 12:08:46 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 01/14] oidtree: modernize the code a bit
In-Reply-To: <20260319-b4-pks-odb-source-abbrev-v1-1-5ddebad292b0@pks.im>
	(Patrick Steinhardt's message of "Thu, 19 Mar 2026 07:52:59 +0100")
References: <20260319-b4-pks-odb-source-abbrev-v1-0-5ddebad292b0@pks.im>
	<20260319-b4-pks-odb-source-abbrev-v1-1-5ddebad292b0@pks.im>
Date: Thu, 19 Mar 2026 09:08:44 -0700
Message-ID: <xmqqeclfn6nn.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> +void oidtree_each(struct oidtree *ot, const struct object_id *prefix,
> +		  size_t prefix_hex_len, oidtree_each_cb cb, void *cb_data)
>  {
> -	size_t klen = oidhexsz / 2;
> -	struct oidtree_iter_data x = { 0 };
> -	assert(oidhexsz <= GIT_MAX_HEXSZ);
> -
> -	x.fn = fn;
> -	x.arg = arg;
> -	x.algo = oid->algo;
> -	if (oidhexsz & 1) {
> -		x.last_byte = oid->hash[klen];
> -		x.last_nibble_at = &klen;
> +	struct oidtree_each_data data = {
> +		.cb = cb,
> +		.cb_data = cb_data,
> +		.algo = prefix->algo,
> +	};
> +	size_t klen = prefix_hex_len / 2;
> +	assert(prefix_hex_len <= GIT_MAX_HEXSZ);

I know the original also used GIT_MAX_HEXSZ to clamp the length for
sanity, but because we know what algorithm is in use, I wonder if we
want to use the limit more specific to it.

