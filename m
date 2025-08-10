Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEBBE635
	for <git@vger.kernel.org>; Sun, 10 Aug 2025 00:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754784459; cv=none; b=GYVEjBfoxSs39dWhbPHSpWWV0ojgyW1d5O6ds/pJV2bbax63njLxjvl2n+ns+nKY3qC6hUTRuLdmoYZbXuV3g1BRGvfAH+jWIMAF6/eR7CzGkUTDbytDNbkZgQ03SNx5CM5Wxsjd0dlAshmB3Ndj8fkL6Pr/H0A3bfaXN6pVkKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754784459; c=relaxed/simple;
	bh=mdC3v2JYPzzl8B4mRldAsWxwzYZtU4CWcM/YxOlRIwU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bozVpH3Kim+R4gGucOvwYoZsLKFU6BcWBViUZ/HyxXRvcwmAdPd2L/BCf/3eRfEEz8irGve6bKBlaTa+Ea51po4hm/Cn0cx8d6UMCS0bGK21zYHhQ1oJFt4FSrTA6SX41CevPorNROJgplJzIHbsgV7k9jfRPPxtIWuBJpfnEBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=LOrz2Xyp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=H83bZSyG; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="LOrz2Xyp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="H83bZSyG"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id A78C9EC00CC;
	Sat,  9 Aug 2025 20:07:33 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-12.internal (MEProxy); Sat, 09 Aug 2025 20:07:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1754784453;
	 x=1754870853; bh=bsAj7EZrwHaDhaM3SQ4bhcTsNx1MkQfNDcUdRkxXpsc=; b=
	LOrz2Xypj1fBqKGjlLO4qxZup87wO2PruxbbauJxtoQGFIOmQ/KLMRw3O83XDafv
	ePJZ6Z8tevJnF3fT86qwYFVo325zhKruhuCZ27R7VE+7ARHuehhU2aSeixSo9sGZ
	Lv01AaJUzRGsr/bGTR26woI3jRD1UOwang832DiTiBaabNSm42uO/HdSQHNwsY5e
	G/jRXbvEnR29zXsZEUCP/xBS70Yw6cMdweieIBJmWjt1Cwy0JzL9vqrmjMw/dNzi
	L4DuD0T7nY89pdofq8Ha8PnzOPsXBLuV2fqfNA+I5YsovBWf2Yd6YyXgtUOgvprw
	ICwThCZbMdBjPPeOr98W/g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1754784453; x=
	1754870853; bh=bsAj7EZrwHaDhaM3SQ4bhcTsNx1MkQfNDcUdRkxXpsc=; b=H
	83bZSyG+U2pYtGXP1IHqxt5IqEBU2lPRMqMJdYbYwGIxwmYWXUlH15aBVJCaCsGH
	4AaI3Fwx2AFPZ2Zh8NF5C8jGiTcoK21V+EDekM93BpEyzhgy9R87vfsn1lac42/H
	UYMZoivld1QSO51fN9u7hJ8XjgWFi45FQ9XbkvhwEZsFnlcjhEwd0/3gup7sIdhz
	0UsosKDsA+/1QNhoQkeV8TQ94gv3yymE82C/xw4k/OIM4541eihyFvLKc+g3A9vz
	7+qsmJ2FY1RWS7LLFgcRNTDK8LDqBq5FqCZZf8bxN/aqNOK0srOVHkFesMegma7u
	HfhcUg1eMvLa6BzrsnPOg==
X-ME-Sender: <xms:xeKXaOQAyuioEnOXR93QIoS_zIOAlJBApilPf7gOfoyi8kj6CUMEXg>
    <xme:xeKXaHBBfVlEdiS2gb8Aj7T1bIORM8RawbA9uvlJ8qqGLTdBqfY2WuYz6DVNyb6rJ
    xLuRnvHjPmp0479eg>
X-ME-Received: <xmr:xeKXaFQAKv-9VdbFV7wcr2PQN1PuV3KC2ge8u7HaSDpNYMpN-I9lgyYc-bU8D3fjaPl360o5QF4fsuffkOD05c03Gat6e7sgGoHMLiM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduvdektdelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtgfesthekre
    dttderjeenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhes
    phhosghogidrtghomheqnecuggftrfgrthhtvghrnheptdffvdetgedvtdekteefveeuve
    elgfekfeehiefgheevhedvkeehleevveeftdehnecuvehluhhsthgvrhfuihiivgeptden
    ucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnh
    gspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheplhdrshdr
    rhesfigvsgdruggvpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:xeKXaFoX__CwZC8z6VdtsjL5jzT_NRoZk0NMk2pgsQIuHHmnAb4m8g>
    <xmx:xeKXaHxOIWn0JzNI0dLx9Yi6AGI01eE3g0wZ8LS59O2X1RWilkH3AA>
    <xmx:xeKXaKLc1P974JqbitFXxdO3kPklwWmH4rTDtoRAoso11qJ96l5WJA>
    <xmx:xeKXaJI9YnBsJroj3ppvvq9HQhW6rLVjA4BrQUqMctvxgIEzExSscQ>
    <xmx:xeKXaKQ4wWUm4VjV9o_FVkqmfYRZyrOZrNZzZipWfZGGgGfbB_KpL_gy>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 9 Aug 2025 20:07:33 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc: Git List <git@vger.kernel.org>
Subject: Re: [PATCH] merge: don't document non-existing --compact-summary
 argument
In-Reply-To: <890631d1-4e3e-4ea5-8f58-371fadf2b1b3@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
	message of "Sat, 9 Aug 2025 12:00:16 +0200")
References: <890631d1-4e3e-4ea5-8f58-371fadf2b1b3@web.de>
Date: Sat, 09 Aug 2025 17:07:32 -0700
Message-ID: <xmqqa54859a3.fsf@gitster.g>
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

> 3a54f5bd5d (merge/pull: add the "--compact-summary" option, 2025-06-12)
> added the option --compact-summary to both merge and pull.  It takes no
> no argument, but for merge it got an argument help string.  Remove it,
> since it is unnecessary.

Thanks.

>
> Signed-off-by: René Scharfe <l.s.r@web.de>
> ---
>  builtin/merge.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/builtin/merge.c b/builtin/merge.c
> index dc4cb8fb14..ce880e6ccb 100644
> --- a/builtin/merge.c
> +++ b/builtin/merge.c
> @@ -264,7 +264,7 @@ static struct option builtin_merge_options[] = {
>  	OPT_BOOL(0, "stat", &show_diffstat,
>  		N_("show a diffstat at the end of the merge")),
>  	OPT_BOOL(0, "summary", &show_diffstat, N_("(synonym to --stat)")),
> -	OPT_CALLBACK_F(0, "compact-summary", &show_diffstat, N_("compact-summary"),
> +	OPT_CALLBACK_F(0, "compact-summary", &show_diffstat, NULL,
>  		       N_("show a compact-summary at the end of the merge"),
>  		       PARSE_OPT_NOARG,
>  		       option_parse_compact_summary),
