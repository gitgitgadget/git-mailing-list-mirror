Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EE1C2F3621
	for <git@vger.kernel.org>; Wed, 14 Jan 2026 17:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768411652; cv=none; b=gK0Wb91ycRXeYngKKwG5uKmodIxR7MPfWx4xZX+I5t189CoSCht72NUgMueZIySlg3tzw7pf+mVu2XEVG6Y0pDrqvT+AJwtJ/H6EGgkY7t5IKUDVBI8rqqvrdHqJqHI0Nmekj1Mw0lnQy/tLwbMghJnil1UZjiAxmt5PAYYvkFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768411652; c=relaxed/simple;
	bh=Z/X+IBzmgRmkS/OgoYJYDIB5G6uXUaolwHNVx1O/+7s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PA8DPYRJq1Cj0x9EbifwBjUfGNFgE+VzylocGB3E6PtklBO2pZFOwstp0eM9lJbBlKyO4IX0heLIOeg4mU+0bMN8olO9O1nDKCHuJ0RL4e70Wa0NfZ8QY6hRLITgWSDZRItmoSY24w4HnR+S2PjD4nlX5S4eSs/8zW0aFzMKNnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=qYeQnwxh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QMpLCDHF; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="qYeQnwxh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QMpLCDHF"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 4FD737A0042;
	Wed, 14 Jan 2026 12:27:30 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-12.internal (MEProxy); Wed, 14 Jan 2026 12:27:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1768411650; x=1768498050; bh=Ed+Te8oj2y
	0Kvz0pHh8zbwfnm9Z82/3gXNW6QV6UQO8=; b=qYeQnwxhOM8WYxsMSMbNMnEkO0
	JT61MTvVpMF/kqdPwKeDn9rCbzn/Jeqq5XjPCDrGCa0FQ/e5EmJbfU8H3bOiI9p4
	DNCRfJzI+j08At9d0VDMKULSG9KoksYzvMZq29/+SPLDJ5joaqVQCU1PcceBGZRm
	UVJF2wdbdBakqHbwUTT5IPEPFNGCA1ZafM8kBzI6Q59llk6IoK6jdTJ3zCFrT+ys
	ud2cQQ1i5L1HqF9vgp8YbPCKyxWXbW9fidawkoRT0uk2EhfupQW9YuTmnYAFxfN2
	HeJ8beydTkl6hp8Eb4ftfbolbXP1aNgtB+GzP23ZAwhVVi7emidGXAIjJ3OQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1768411650; x=1768498050; bh=Ed+Te8oj2y0Kvz0pHh8zbwfnm9Z82/3gXNW
	6QV6UQO8=; b=QMpLCDHFEwinGKLzYUea8xNMYu6ZaMCsmR5wqw97cZfc+kwk6Us
	sEm2EKPUKNN9aWpuPgaI/cd/8zGM8gAmfKHNXwPDiAxdM+NxyzPPF9FofBLfbcaU
	YoOHLX2Iy1rwOHmniq17U9hcC8bek/9ZZcU5/egE8UspfQal6J2lpDz+DIvrb5GY
	TWZ3lEjCWIo4WMWUOOSWyjm7ZS8rdo48Edi+spKaw0jFYFdQG+xqq8WxVByRE8ev
	920pIAnQrEJQ4Gsu1TMQYy+ehXbQbtkmA7INIije64KFIIJOMGcITBTLLfn5yJKQ
	9Oc+TauS2l/hcCy/Xs8Rn73Pi3UkDy44XJg==
X-ME-Sender: <xms:AtJnaR3UMHUeIhOZ4uGZfzz5DPY3xC4KWV9EiraOkChuBCvuhTv5nQ>
    <xme:AtJnae9ERZC6LJ2x57AWs-aKxG3CwOHFMpdsz-gpr0aYW__DjZ-yLtB6rnWbXM0Pu
    ruER6EhB-MEL0NWJ-piMEVWR-LgzYswxlgB808NBl0GxEX9O2GW>
X-ME-Received: <xmr:AtJnaaOm0xqwP_5FnXy3KKzOP0XvTZA1UPHNXd1OUSbVC7WnRgLB_m22AwF5rutJyzb2n3tAjSb7Jfz9M3wDm0i0YoKktI_xPj5Ae6c>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduvdefjeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomh
    dprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    phgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehnvgifrhgvnhesghhmrghilhdrtg
    homhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:AtJnaaePuRGXhefSb5sbdArvKb52EwT1wpp-WnIOH99hbfssQQF-KA>
    <xmx:AtJnaRXxG7gj_WYcUGfGxgy0yuXWvIm4ewFjhW9PRNpgJQXme-4KiA>
    <xmx:AtJnaajd1veL_xH9D52pYSKsZsvY0llc4bFRX_CTrM-nPSl3zFeDDA>
    <xmx:AtJnaY-Yuu5zd7Tff9WF9jsp3waPol8vH3sqB2EuprFdzPZMtJpUIA>
    <xmx:AtJnaU8GCm1S6Q88YaLuFNILCMSWqbTYumMEdlf9aW7oSz-LgdfyOt4o>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 14 Jan 2026 12:27:29 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org,  peff@peff.net,  newren@gmail.com
Subject: Re: [PATCH 4/6] update-ref: utilize rejected error details if
 available
In-Reply-To: <20260114-633-regression-lost-diagnostic-message-when-pushing-non-commit-objects-to-refs-heads-v1-4-f5f8b173c501@gmail.com>
	(Karthik Nayak's message of "Wed, 14 Jan 2026 16:40:45 +0100")
References: <20260114-633-regression-lost-diagnostic-message-when-pushing-non-commit-objects-to-refs-heads-v1-0-f5f8b173c501@gmail.com>
	<20260114-633-regression-lost-diagnostic-message-when-pushing-non-commit-objects-to-refs-heads-v1-4-f5f8b173c501@gmail.com>
Date: Wed, 14 Jan 2026 09:27:28 -0800
Message-ID: <xmqqpl7cf6kf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Karthik Nayak <karthik.188@gmail.com> writes:

> @@ -573,16 +573,18 @@ static void print_rejected_refs(const char *refname,
>  				const char *old_target,
>  				const char *new_target,
>  				enum ref_transaction_error err,
> -				const char *details UNUSED,
> +				const char *details,
>  				void *cb_data UNUSED)
>  {
>  	struct strbuf sb = STRBUF_INIT;
> -	const char *reason = ref_transaction_error_msg(err);
>  
> -	strbuf_addf(&sb, "rejected %s %s %s %s\n", refname,
> -		    new_oid ? oid_to_hex(new_oid) : new_target,
> -		    old_oid ? oid_to_hex(old_oid) : old_target,
> -		    reason);
> +	if (details)
> +		strbuf_addf(&sb, "%s\n", details);
> +	else
> +		strbuf_addf(&sb, "rejected %s %s %s %s\n", refname,
> +			    new_oid ? oid_to_hex(new_oid) : new_target,
> +			    old_oid ? oid_to_hex(old_oid) : old_target,
> +			    ref_transaction_error_msg(err));

Could "details" reported from the lower layer be less detailed than
what we are formulating here, like updating the value of what ref
from what old object to what new object, or what the err code tells
the end-user?
