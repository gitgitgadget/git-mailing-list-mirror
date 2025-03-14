Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 495031EDA26
	for <git@vger.kernel.org>; Fri, 14 Mar 2025 22:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741991305; cv=none; b=UVcPaa4OAtgdzke8XGX3Xg7kxpGK3A53VjlHFY+ZRfT+r9tVLnwzV34/7yzUY/Rc7VdsOazH1rKy8uM2jEXsOYaxyXdM0YL9QXp9BvB3gBFs+p/JCmOsK//vnSRmuKgPfe3U/igfcSrfjt76A9e7IDSiDVeRl3rQo5h94FiJeDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741991305; c=relaxed/simple;
	bh=8U2/rPPcG114M13rU9moKLjW0aT/a95R5Tt0DJB9V+c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=RYyPg/tuRuz0pfcXgb3ApWFki57SW6pr9bqwTX1VUz23MmMftk8qNgzBtzzSSpQkuVKuuQSopwSZKdjdd4qqvSRGd5nxq35yuErbI6II6D+WwXaA6uPTLMZK6n8g9d52ggpmNXSi93RrKboNQeT+uu9KmcAC5L4lm5x54Mme0jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=CP6MfYCD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=wiYWjiqp; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="CP6MfYCD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="wiYWjiqp"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 3EAAE1382D6C;
	Fri, 14 Mar 2025 18:28:17 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Fri, 14 Mar 2025 18:28:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1741991297;
	 x=1742077697; bh=HZPDMc18N/tCbUzOfZdhCv8ZIGns7V3xiYtzg/F7qxA=; b=
	CP6MfYCDRBjOWeak7Cx+XWoqskssB3ZZB4LTCbGafP41g79G96US31OZSe1MjHV5
	YHVZmDUZKN1KaaRCB2N2pziZCE8uUiukLzWd5SAK7VW4j5csLLRW7f4+iGiZLMus
	uJB8FD13DXjRUERfABfYIAXq50SP4izTmHP7zuc4fqFuWef1ly8eg8LHl9Mk5XbG
	cHwJTCYEJ0uPEorn+9p234IHcsRUwxgQejQtyw6n1HeCZhKB8/H7I3dybJeaA1g1
	02TkT+eHEHhArv++mlZNIh7encVsiyEY4zCRoeI6dhMDgBJUiKwCm416shUCmMlb
	2gpYB6pahoRB7VhNRy7H+g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1741991297; x=
	1742077697; bh=HZPDMc18N/tCbUzOfZdhCv8ZIGns7V3xiYtzg/F7qxA=; b=w
	iYWjiqp7RJ63dhdQauLwfwUKSRzusEYCt/6iRX8p4yYBrkBvVAtH7halBVsBilNE
	TxGMegzP636ynz8IRayaDbX7c4xQItw/R1c8RgYrJ7cBAY7R6KW2vafUcb6N6NxC
	IAObtH7g5uhw1lHThHA7FDMsn4X0mWZydIxOPCjSwsiPoUhH+QEx0p9udgTg6Spt
	sHNtCVTB0LXI3cU4Ecp3pvO4P4gGJTAneIB1LWNyTqap2Ey9+q+JIRxcfA8ec7Rm
	ge0jAvjLN0X+R7r6vk5E2sQ+PAvfVuvay0S4iBFtZFaUUs+Ap58WyaZeOt1jM0H4
	F40COkHqbN4AmlYvmWhkg==
X-ME-Sender: <xms:gK3UZysDb3XrSmO8xJOSAZR1PvycuUir5-Fkg3UoWsaEK2xPpRzTxA>
    <xme:gK3UZ3cXtzo-wB6KOs9YxN9TPUInhZnpnEuT-T0hlsTjoY6B14xX14MVNv2_qyIxI
    Wm05FJ15P8e_69lNw>
X-ME-Received: <xmr:gK3UZ9w_HkoPX6YDWSMburGV26r8LuXNlJ99rDp9d7cpS9lcFXPNpg3S0NjQvs4VqS7PR5-JI5mO818IFWNEWyhYROSI2A0JE0BWciY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddufedvtdefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvf
    evufgjfhffkfgfgggtgfesthekredttderjeenucfhrhhomheplfhunhhiohcuvecujfgr
    mhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvghrnh
    eptdffvdetgedvtdekteefveeuveelgfekfeehiefgheevhedvkeehleevveeftdehnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsth
    gvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphho
    uhhtpdhrtghpthhtoheplhdrshdrrhesfigvsgdruggvpdhrtghpthhtohepjhgrshhonh
    duudgthhhotggrsehprhhothhonhdrmhgvpdhrtghpthhtohepghhithesvhhgvghrrdhk
    vghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:gK3UZ9NE9Kdh9abl4xLj7LssWzYqAPsOFF63_uPtwUUMshlja6VEjw>
    <xmx:gK3UZy-knqE4igP0i-twJWHe8vfUyYf-TYYcheD_k_CE83OX6YjjQA>
    <xmx:gK3UZ1W-SPaqPKZgTIqVQ1yEHXCzBSP5Y3zZbHWwevqAAbVlAe9Efg>
    <xmx:gK3UZ7f58tbW6Zur9_YVAMmq1J8GBZVmZMXUO0ZFSLenK_4Yn9vkWQ>
    <xmx:ga3UZ2Zoz7PbETmbJO1_oH-rLK3BPKZm-M2ycc66ilRgjB7hhB2vn6QL>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 14 Mar 2025 18:28:15 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc: Jason Cho <jason11choca@proton.me>,  "git@vger.kernel.org"
 <git@vger.kernel.org>
Subject: Re: [PATCH] xdiff: avoid arithmetic overflow in xdl_get_hunk()
In-Reply-To: <4e9b6b4c-aaa1-4c6f-93f4-7bb04607e843@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
	message of "Fri, 14 Mar 2025 23:00:42 +0100")
References: <xXWgbH3mlNEvFcdGLqBHwcclZoeZNPoLg8Hr6YCipHXvS5eKaHeTppzFM-l_wyB46BB1R1T0j6g_jWRXIj7-GRJh1LPxi1ta3GkQ5t8F4-0=@proton.me>
	<NYMqsJ7uttDzFT2OOEg5LLsxCSoQhTzqBs16KrMHGEKC7LzOAiYnYTEZavRQWqGH41UgjdwScwer7MssNzI7AEDHnD8GTBWvoBIqJ2e7D6g=@proton.me>
	<4e9b6b4c-aaa1-4c6f-93f4-7bb04607e843@web.de>
Date: Fri, 14 Mar 2025 15:28:14 -0700
Message-ID: <xmqqikobdz7l.fsf@gitster.g>
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

> xdl_get_hunk() calculates the maximum number of common lines between two
> changes that would fit into the same hunk for the given context options.
> It involves doubling and addition and thus can overflow if the terms are
> huge.
>
> The type of ctxlen and interhunkctxlen in xdemitconf_t is long, while
> the type of the corresponding context and interhunkcontext in struct
> diff_options is int.  On many platforms longs are bigger that ints,
> which prevents the overflow.  On Windows they have the same range and
> the overflow manifests as hunks that are split erroneously and lines
> being repeated between them.
>
> Fix the overflow by checking and not going beyond LONG_MAX.  This allows
> specifying a huge context line count and getting all lines of a changed
> files in a single hunk, as expected.
>
> Reported-by: Jason Cho <jason11choca@proton.me>
> Signed-off-by: René Scharfe <l.s.r@web.de>
> ---
>  t/t4055-diff-context.sh | 10 ++++++++++
>  xdiff/xemit.c           |  8 +++++++-
>  2 files changed, 17 insertions(+), 1 deletion(-)

Oh, I love a patch like this that is well thought out to carefully
check the bounds, instead of blindly say "ah, counting number of
things in size_t solves everything" ;-)

> diff --git a/xdiff/xemit.c b/xdiff/xemit.c
> index f8e3f25b03..1d40c9cb40 100644
> --- a/xdiff/xemit.c
> +++ b/xdiff/xemit.c
> @@ -43,6 +43,10 @@ static int xdl_emit_record(xdfile_t *xdf, long ri, char const *pre, xdemitcb_t *
>  	return 0;
>  }
>
> +static long saturating_add(long a, long b)
> +{
> +	return signed_add_overflows(a, b) ? LONG_MAX : a + b;
> +}
>
>  /*
>   * Starting at the passed change atom, find the latest change atom to be included
> @@ -52,7 +56,9 @@ static int xdl_emit_record(xdfile_t *xdf, long ri, char const *pre, xdemitcb_t *
>  xdchange_t *xdl_get_hunk(xdchange_t **xscr, xdemitconf_t const *xecfg)
>  {
>  	xdchange_t *xch, *xchp, *lxch;
> -	long max_common = 2 * xecfg->ctxlen + xecfg->interhunkctxlen;
> +	long max_common = saturating_add(saturating_add(xecfg->ctxlen,
> +							xecfg->ctxlen),
> +					 xecfg->interhunkctxlen);

Looking good.

Thanks.  Will queue.

