Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B26F175A9F
	for <git@vger.kernel.org>; Tue, 10 Mar 2026 20:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773173426; cv=none; b=de814fK+Gaj4CIK4xd2OIw7QgpDSPHqtp8TRwHNRcCt/t/Nd4SyzHKT4nKNyVjM1HCKzTPUKZTzwqD/Qa3fkoh1y3rk8QG7khkeXkAfcfTduu6a9ixwtwiMEtTUh57qmF64X5IoE62WAEXJsVUQ63ICFhXc4E05ccfB5men+bmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773173426; c=relaxed/simple;
	bh=0syvigLEb5Z3d8UyP5M9ihpJAf1Q+v+cGEl2YfA1L8w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pbYcWFntk2rE5jHPWJaRw7x2jHDZA7jnCbYVLIf8inrpwLJ3K5ZqJeNhSp+C/eIAhe7SGt3R7pEcmDuqm1CCTmUDlaMaw09KyULby+ZLJAB/IDw9a3Bfn4rlFQz2II71wHYJ16+oPLE+oDC43WarND6PwczYi2sG18dK4OjlX9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=QyYtjyqC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=4AcFgQLm; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="QyYtjyqC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="4AcFgQLm"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id AE1E514001DA;
	Tue, 10 Mar 2026 16:10:24 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Tue, 10 Mar 2026 16:10:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1773173424; x=1773259824; bh=DbPAn19tNT
	b9qFNM8hUH/9U4ZV9WlHZ3FVdspNBlQcQ=; b=QyYtjyqCqzj3d6xV+goEW4aIVw
	UoSVjAb51TmVa3aRAM9XNSFdE9dC4eV0rdLTqgy+SwEu+HgWBVCizt1tl0L4UcVg
	EVBVEpF6/TN3+coEEGk/wcFivuiatp+CQ+8UbauV/Db5ixpX8XlPEfkudPvEVscQ
	kVr+W2N1wF0O2qH1j6cNJvt/vXea3G709rhNb1wAyHVsf/HZnp6HFgx2NBe7G3aV
	rvHYTEKK6rAyWHGPWunn6TJNwelVVG835V0EFyIh3j1ZDZkMXXgsoktDzh2Utivd
	/YltCsKEqWQ+te2XD2mNcmR3v9rvM3o2vYnWOIEKPTTB6DAYBmpRysvOhmYA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773173424; x=1773259824; bh=DbPAn19tNTb9qFNM8hUH/9U4ZV9WlHZ3FVd
	spNBlQcQ=; b=4AcFgQLmIrxJzOL2+Y5lu2HzWJrsj16nuyJxdX9bF0OB7c3vBVk
	2Zib0bcPGStHkOT6hUMVgIIvMWzy4JmMiIx/VP4pV2KnEn5DG01/X9rbnHTrLEkY
	5k81oBROrFD+jq3CSRNpmSjmCY+TcrXlJZDAczwqtQFpyMOjYCzwA3tLE/dge7kl
	aixYJdi99e51d29RZ49WECAbpQMmt0l/rmQk+pRWfFgXX5tYWGGJIPLYYum2eBqQ
	vJ0RK7z2kBWQPNeM4BsbDmxxYD8ubG6kPDCPOZmsvqay5FeLmp9yUyu0/Js6vHvm
	JqGboVQ06D0k74RRJAeeRmOKNCQwvMPrqjw==
X-ME-Sender: <xms:sHqwaRqJGEZ29tiPVfvJSqqOQa1qJTYdLpCkCZzueWfVsgqFSCqUGQ>
    <xme:sHqwaap8xjYLvPxRAZx53f5M9IiagXCNsYkz1x0suvvQjd9kuJmawcG4UQurvYWGs
    7MkYM0hnjDNPUSP3qh2iOIyaW3F_s_b-crO3JiVW5cGITCSTPmAT20>
X-ME-Received: <xmr:sHqwaTPeJW0YfXLZFiQTCqjNs5QA2FQLapYueFtZ4rdLaHg1_41n-jU5wi8siBc8RmASfmJazKKwbWXveY1y0s93y3jDWrTLig>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkeduleehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomh
    dprhgtphhtthhopeefleessggrrhhrohhithdrshhhpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrd
    gtohhm
X-ME-Proxy: <xmx:sHqwabx75Whyi-X0o4uc3B6G78q0n1vs4SmTdwpTdw4PywzzEr-ruA>
    <xmx:sHqwacvMcZ05SxFVA5KCgBDyoxHuL5leanv2kEjUUleypXJOXXRTsQ>
    <xmx:sHqwaU7iLGtYyr_mZZvgXkGHIfuii4sETxY1URRWmcKtAk7R8IBtSA>
    <xmx:sHqwabSCQcGcpdh3hMhOLHJj9vsvhTSn-Orm2ZJyXUUmFQJqPQHR8w>
    <xmx:sHqwaZMqdQAnwDr0GxWRH25z6JK2FAaN6rIsJZu2qt9BCwbYhXiYIZVI>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 10 Mar 2026 16:10:23 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: Jiamu Sun <39@barroit.sh>,  git@vger.kernel.org
Subject: Re: [PATCH v3 2/8] help: make autocorrect handling reusable
In-Reply-To: <CAOLa=ZQypadiSnU1hqHBUzzayGvvvv0z-X+-vNJRFgREmdB+qg@mail.gmail.com>
	(Karthik Nayak's message of "Tue, 10 Mar 2026 05:52:58 -0700")
References: <SY0P300MB08013E35DCA8FC31B0662125CE78A@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
	<SY0P300MB0801C6F21C2D8F49892DF8E7CE46A@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
	<SY0P300MB08017404C417D02058423130CE46A@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
	<CAOLa=ZQypadiSnU1hqHBUzzayGvvvv0z-X+-vNJRFgREmdB+qg@mail.gmail.com>
Date: Tue, 10 Mar 2026 13:10:22 -0700
Message-ID: <xmqqcy1btpht.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Karthik Nayak <karthik.188@gmail.com> writes:

>> +#define AUTOCORRECT_SHOW (-4)
>> +#define AUTOCORRECT_PROMPT (-3)
>> +#define AUTOCORRECT_NEVER (-2)
>> +#define AUTOCORRECT_IMMEDIATELY (-1)
>> +
>> +struct config_context;
>> +
>> +void autocorr_resolve_config(const char *var, const char *value,
>> +			     const struct config_context *ctx, void *data);
>> +
>> +void autocorr_confirm(int autocorr, const char *assumed);
>> +
>
> Why not use s/autocorr/autocorrect/ ? Also would be nice to add some
> documentation about each of the functions here.

Good.

>
> [snip]
>
> Also got this from running `git-clang-format` on this commit. Generally
> applying changes while moving code makes it harder to review. But here
> the changes are small enough that we could get away with it. I'll leave
> it to you.

No, you cannot leave it to the author.  

Leave it to CodingGuidelines; case and switch would start at the
same column.

> diff --git a/autocorrect.c b/autocorrect.c
> index 1037f03201..87351fd08f 100644
> --- a/autocorrect.c
> +++ b/autocorrect.c
> @@ -9,12 +9,12 @@
>  static int parse_autocorrect(const char *value)
>  {
>  	switch (git_parse_maybe_bool_text(value)) {
> -		case 1:
> -			return AUTOCORRECT_IMMEDIATELY;
> -		case 0:
> -			return AUTOCORRECT_SHOW;
> -		default: /* other random text */
> -			break;
> +	case 1:
> +		return AUTOCORRECT_IMMEDIATELY;
> +	case 0:
> +		return AUTOCORRECT_SHOW;
> +	default: /* other random text */
> +		break;
>  	}
>
>  	if (!strcmp(value, "prompt"))
> diff --git a/autocorrect.h b/autocorrect.h
> index 45609990c7..38f1e73131 100644
> --- a/autocorrect.h
> +++ b/autocorrect.h
> @@ -1,9 +1,9 @@
>  #ifndef AUTOCORRECT_H
>  #define AUTOCORRECT_H
>
> -#define AUTOCORRECT_SHOW (-4)
> -#define AUTOCORRECT_PROMPT (-3)
> -#define AUTOCORRECT_NEVER (-2)
> +#define AUTOCORRECT_SHOW	(-4)
> +#define AUTOCORRECT_PROMPT	(-3)
> +#define AUTOCORRECT_NEVER	(-2)
>  #define AUTOCORRECT_IMMEDIATELY (-1)
>
>  struct config_context;
