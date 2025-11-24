Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC71A158538
	for <git@vger.kernel.org>; Mon, 24 Nov 2025 23:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764025213; cv=none; b=ukcHg/GVMoVWTxxgJS9eWH01qYxRiIw+/1GsuDsg2UZZ1KmGdINOAp6NXCfM90VJGWOL0LsAy4g5NU3XlzGpi7aIu7qkv079F0n1lcVipUWvTmLGFvjqEOwfIQVxZODvKftJEf02UQhW427JBo5NvmRliXrh/o/GaZSVcgdzQGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764025213; c=relaxed/simple;
	bh=zqD7UFJnYYxPhcrwnLDnsbogLj8yH/+Wq/h3QntKzLs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BO8C/LZm2ZRF4FmpSAGI9uHhO6ThSeMUluWz7udkAEUiWuV96WSMy/kJzuvi8koAk9XH2mOsh/MLFMg7aNmnKf7DOrzP/1v1On4TEjoeBujLaP29W90hpmFHojqBjX1TK508JUW5xFiaHe5bFSzxdGt5hA9WW5mcYTyLrw9y0ZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=R9KnXL0p; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=27Tv4Ch8; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="R9KnXL0p";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="27Tv4Ch8"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id CA334140025E;
	Mon, 24 Nov 2025 18:00:10 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Mon, 24 Nov 2025 18:00:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1764025210;
	 x=1764111610; bh=jGyvy2RZlxNWTxP0q6+aUCgjpydGxt1PX+Vst+Xh2g4=; b=
	R9KnXL0pGOuh6yeyxUeEdmeA0ZvQOO1aVJ54W276n1R+yrhUjJ5m2IOTgJUEmHKV
	4N1eN7Txe/7iGwyd9YuD7Ua7iS6Nzp4+ZD1abyU6GjZSPh8zntyyFSj3b4iMaJmn
	KZhB5oizbNuQpx0EPfztBM/NpqRUzXhiBYxedNkWYPaPTh+Usytj3RpGbLCO0a01
	nOyFrrVAdATBL7+zPEF/bhloSa7iK0CxjqSQRYnOPbInAOAjOGLQNPhKqQtYHgJq
	f47wKxu3oRjPM2nolZr6r1lXaFak5kjTSeKjygN3WAxLAkVSqM6a0C6G8XTEdZ5u
	rNhAPHCGGe9Mpd6oUkmewA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1764025210; x=
	1764111610; bh=jGyvy2RZlxNWTxP0q6+aUCgjpydGxt1PX+Vst+Xh2g4=; b=2
	7Tv4Ch8WcwvzkNSekMyuqiazSvf/TvyXa0U1njZc/ox0+lTxqXvYBDFSnpvpK4Lo
	0JrXhfukDzaWvSR+jQu8WEnt8LJmjr4M0lSCIs5DWh1BpAOZBOdRsKsJpRKuEiqH
	F2RiVBYkbsyjFN76yT9/DQFUfxN1l8EiUx9SHtDo74DPFao2zJXgSIy8YhDj9ltM
	2CyWsQ7vC+re/v3nU9DViL84L6e0JDo9bYi/G981fugJC9QpTTzRNxUyTSKa9l3v
	0yAGcG7I8IcduiQJVQZfl8eWMc/PFFtvAW5bEHn5t8CF0FgTnUGAz2+iYTkm/L+C
	R/UtRcVwHh/fb3ZK8cHvw==
X-ME-Sender: <xms:euMkaW0aRhBkCyp8IDQw9n4pnT13_rmr-GHlrGc9-YSIHtb-m1Gi8A>
    <xme:euMkaQHvQS_Ux6aD7QmbQAjkGugcu1-abUJJ-3sOFFMT2s1zCrqBGtHs3Hvupf-Db
    9hlKqFVV3SvEujYh2EE8dKFRaYOc1J7pSTHxlohWTRkKlYju7JNPQ>
X-ME-Received: <xmr:euMkaT63o_yWzJv0INfy8YmKNesY1dpLIRv3_7qEsQQ6DUk35bidWXLzCS6-UNp0PFZNxR4oPozkwtPKnJeSrJAWrDbCKYvz9Xyj>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvfeelkeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgfgsehtkeertddtreejnecuhfhrohhmpefluhhnihho
    ucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrg
    htthgvrhhnpedtffdvteegvddtkeetfeevueevlefgkeefheeigfehveehvdekheelveev
    fedtheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehlrdhsrdhrseifvggsrdguvgdprhgtphhtthhope
    hgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphhssehpkhhsrdhi
    mhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:euMkaWvHnjKZ3W593kYFbb1BGQ8WvOb0xpqMg2W0y8PKOpNkxoq_vg>
    <xmx:euMkaU5AqoIQ2JFUawtc6ZDt5ygav7WmPfUlrLEzbfIZIoBC7qpCKA>
    <xmx:euMkaRXDwdLJWyREujsCHImyr6JoksFqF0veLMn9AOEBqXwtf-VURQ>
    <xmx:euMkaW8BDGfyd3pNj-1pNajcdFbebZGfRg3er9jxu2hJ2pvwocLyXw>
    <xmx:euMkaS1k3aLoVst1TJNAjuJqaxJSmCrnxo2UhIqZFA9d2DmCtTfQSSRI>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 24 Nov 2025 18:00:10 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc: Git List <git@vger.kernel.org>,  Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH] config: fix short help of unset flags
In-Reply-To: <06997dce-e4d5-4889-8e70-5f44da3dc800@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
	message of "Mon, 24 Nov 2025 22:00:05 +0100")
References: <06997dce-e4d5-4889-8e70-5f44da3dc800@web.de>
Date: Mon, 24 Nov 2025 15:00:08 -0800
Message-ID: <xmqqtsyjujd3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

René Scharfe <l.s.r@web.de> writes:

> The flags --all and --value of "git config unset" don't make the command
> "replace" or "show" anything, they are about selecting what to unset.
> Change their help text accordingly.

Good eyes.  Perfectly makes sense.  Will queue.  Thanks.

>
> Signed-off-by: René Scharfe <l.s.r@web.de>
> ---
>  builtin/config.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/builtin/config.c b/builtin/config.c
> index 86e0cd77f3..80107e61dd 100644
> --- a/builtin/config.c
> +++ b/builtin/config.c
> @@ -1003,8 +1003,8 @@ static int cmd_config_unset(int argc, const char **argv, const char *prefix,
>  	struct option opts[] = {
>  		CONFIG_LOCATION_OPTIONS(location_opts),
>  		OPT_GROUP(N_("Filter")),
> -		OPT_BIT(0, "all", &flags, N_("replace multi-valued config option with new value"), CONFIG_FLAGS_MULTI_REPLACE),
> -		OPT_STRING(0, "value", &value_pattern, N_("pattern"), N_("show config with values matching the pattern")),
> +		OPT_BIT(0, "all", &flags, N_("unset all multi-valued config options"), CONFIG_FLAGS_MULTI_REPLACE),
> +		OPT_STRING(0, "value", &value_pattern, N_("pattern"), N_("unset multi-valued config options with matching values")),
>  		OPT_BIT(0, "fixed-value", &flags, N_("use string equality when comparing values to value pattern"), CONFIG_FLAGS_FIXED_VALUE),
>  		OPT_END(),
>  	};
