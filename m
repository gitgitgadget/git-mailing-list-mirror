Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61A3A36D4E7
	for <git@vger.kernel.org>; Mon,  9 Mar 2026 21:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773093547; cv=none; b=PhGrhRg0LxdNEcGNz0/l0B/Hbtz49dpgV4Yo7NskhNc9eBn718nY9ro+11WrTRUypeWu0QyYY8pQaqC2pAoC3biJnTIpz3M2s+wE8tIjAPfRtuBEERxT8InEO+x0WXu6lxm6Zi/Bg6IuNlo17AWNQCaBIFrPjYwreLHbtPyI7zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773093547; c=relaxed/simple;
	bh=jN9Cf/THd74+RdWCOCgTdsce3DHTS5kRsKNfSeja658=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=EV04vWEpve5uaK+yGGE+6YZYCY29gLOVgOLQ3hRY0OcqqvN2sbI/Mdmmkarle2KEI/6SpeuaFB0qlZbNVlhhVITGE6P+fE3qqib+mlDoWoL0xbUimih9RCbEIbGQZYErTkdesFnxaGisSVZS98GabXZ6WYmDIGxNUyyQDfBzqwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=AQYra2C/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=aiHK0ZeT; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="AQYra2C/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aiHK0ZeT"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id A8C2A14001B3;
	Mon,  9 Mar 2026 17:59:05 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Mon, 09 Mar 2026 17:59:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1773093545; x=1773179945; bh=TfdBUBE83H
	pLtFWUAHT7Bvc5q7qxodO0s8qBJ717CIc=; b=AQYra2C/rchSKKxqSum+en4OUn
	/Swwg5deIUeMIR+uX67oXHDVCsOgsGs+RCEK7c140jJVAWjfbWwEkCMDkPPEE+S1
	LNdZ38NM6sgtd/NDzd7gm9A/XnuJ9qzo0qeFX4IezuXaiRWyDLiYHdW6+MBR4jtT
	iyM9KNAWIJk9DR1ErXkXfJf+SpsGaAwRPBSC9geu00hbAhxn1unjv8xHTvry5GQI
	zgCIRfKcWLrbbbxRCQHEa5D595LIP7WVnlplXRc59k8f81YVT6gTACR0EUpFjVG0
	V0suMVIJ+SpMmgCYJHSN+vOy+Ymw2N0+hYLcNpX1vsPTtua3qp4jDOvqLEKw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773093545; x=1773179945; bh=TfdBUBE83HpLtFWUAHT7Bvc5q7qxodO0s8q
	BJ717CIc=; b=aiHK0ZeTRqqP5iEfdahY8TlSV24NJzXviM7AjR74w9P1m1JXo40
	n4YfIglYvS06ZnqwZKpsrhrmCiOye7awCjqQewqs25rz2V9l+7i1rwmK3KdtzSmT
	V9pNV59PTBLLY82ZvMBc9bkaBX0O4rbww1ucEh/Ri2z8C46lBX4h9YNe4v3Y0mCn
	iOc/JgAKjuKFjfFUW5KJF+DDBXjEBU6SUXor7jofH/a0S2yN0543Z3qyUwAce6At
	SIQsB00p7T1gOPrJwWc9cbKSrnKpdKMRMJaBbKV1XTvCw1WPx634/FJPuqiX/CQW
	1lZmaroklTKIbqtHSuC91DAwiNcwFNz27mg==
X-ME-Sender: <xms:qUKvaRSoh5BMBYc-aH98xWxUeghlcYa1SRe_mhEg28Pfv6MIlKuh7Q>
    <xme:qUKvaefJpazA1sEXZ0796ewExlX1WDNU-BSXT7O1IkXUwzMtV_7G6Cepvnp6Hbd0u
    BP2fPAfCAtiPK8U_3SvMmvykXuqhJSpfRKEqaCTYnHIw79wKhyFIw>
X-ME-Received: <xmr:qUKvaQrcszEDvXw0CPAj5JnuNpkYXNIgy_VJJVpxVvhENVhXMsnhwMiPFJKVDLeDqFY5m8jTyM6_DhXtcJKALQq6TCBW46j5eA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvjeelvdejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheprggurhhirghnrdhrrghtihhusegtohhllhgrsghorh
    grrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopegvmhhilhihshhhrghffhgvrhesghhoohhglhgvrdgtohhmpdhrtghpthhtoh
    epphhssehpkhhsrdhimhdprhgtphhtthhopehsrghnuggrlhhssegtrhhushhthihtohho
    thhhphgrshhtvgdrnhgvthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtoh
    hm
X-ME-Proxy: <xmx:qUKvaf8bayqStNs-o2SBNjlKwxyvfV3KpJE6CtTFvoS_Sch7Y-nrqQ>
    <xmx:qUKvacfUS6Id88d7I3Bhnj1dfdicBqQJX3bbfa0QGJFQ8c1fRcHwrw>
    <xmx:qUKvaZKBGIQtyKQMXzN3ELXGe1qVcovduB2rRpsslxOMQG286Zl0iQ>
    <xmx:qUKvacjNeF_whIc2r6ZbBkfN0t0CDe9t62YYqKxldRQid9NcIrxfBA>
    <xmx:qUKvaSq2rBOnkPNryrR_BZHnDcU2Nq9kSGUh6U7DNOWgiq0KoqMJwgVI>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 9 Mar 2026 17:59:05 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Adrian Ratiu <adrian.ratiu@collabora.com>
Cc: git@vger.kernel.org,  Emily Shaffer <emilyshaffer@google.com>,  Patrick
 Steinhardt <ps@pks.im>,  "brian m . carlson"
 <sandals@crustytoothpaste.net>
Subject: Re: [PATCH 09/10] hook: show config scope in git hook list
In-Reply-To: <20260309005416.2760030-10-adrian.ratiu@collabora.com> (Adrian
	Ratiu's message of "Mon, 9 Mar 2026 02:54:15 +0200")
References: <20260309005416.2760030-1-adrian.ratiu@collabora.com>
	<20260309005416.2760030-10-adrian.ratiu@collabora.com>
Date: Mon, 09 Mar 2026 14:59:04 -0700
Message-ID: <xmqqpl5c3brr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Adrian Ratiu <adrian.ratiu@collabora.com> writes:

> +list [-z] [--show-scope]::
>  	Print a list of hooks which will be run on `<hook-name>` event. If no
>  	hooks are configured for that event, print a warning and return 1.
>  	Use `-z` to terminate output lines with NUL instead of newlines.
> ...
>  		case HOOK_CONFIGURED:
> -			printf("%s%c", h->u.configured.friendly_name, line_terminator);
> +			if (show_scope)
> +				printf("%s (%s)%c",
> +				       h->u.configured.friendly_name,
> +				       config_scope_name(h->u.configured.scope),
> +				       line_terminator);
> +			else
> +				printf("%s%c", h->u.configured.friendly_name,
> +				       line_terminator);
>  			break;

Everything in this patch was as expected (the most important of
which is where the data is kept, which is in the new structure
hook_config_cache_entry that was introduced in the previous step for
use case like this), except for the above bit.

I wonder if this already interacts well enough with "-z", or a minor
tweak would make it better?  Wouldn't a machine consumer expect that
friendly name and cope be given as two separate and easily parseable
fields in the same record?

