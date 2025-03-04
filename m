Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AAA817583
	for <git@vger.kernel.org>; Tue,  4 Mar 2025 00:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741047312; cv=none; b=eHETxXRKD8BOWArm66cZgrqfYOlC1+6FfXkXHdAvFmOcR++7ArbA7ANiAnBTHPwSrkmO1fK6gbJvthDxUauovq+aNWBsGNIDBAFznGV7c3twJoelaRvm00bu3b8OmIXwytfJemmPHh6sBFs3NCJ2ifaSVlTUFcIlFvnZdOVfNL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741047312; c=relaxed/simple;
	bh=hnPlmepxMpJhV3jzgyyudiS6u2zmU6xdEU0J2tV+Wm4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DZPsPjE2C0cFIrG00w6fKPZ/Sire4bE2KIE2xqZ+5W/yMh5LWMIWS36S1iel+Xlsq45hGE/tJU27bQQNDwco7ZjflDZSNwgRMHEzTOFCKw35bFCkJWYUK3G/89VuVj1HL9CIFcIARPAXxjhwP1NWDx2DYHwQV+eVj1Mar1QDtQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=jLFMJt5S; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=A9L59KWV; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="jLFMJt5S";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="A9L59KWV"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 7C2892540475;
	Mon,  3 Mar 2025 19:15:08 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Mon, 03 Mar 2025 19:15:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1741047308; x=1741133708; bh=V1ba4uj1Bc
	Vsl0JfEKR+Vej+CuxMBoE4yHc1TaxOIeg=; b=jLFMJt5S7Fb6VHgiitr3u0MUrB
	zo9tUWdfrgmy9/43LTnIgLWFN3mpIPdG90je/wDuxz0PLL0O/+SBZKiLPeI1+6iy
	8KYpagDci3Zdsti2a4yuf9bHf7+M7qni2rByJSKCcYf2VGywTCOCr/U1vSkO5KRm
	wOZLxDNwgnmmtRpQVnfEVamhaJI7UWOfUYdRgYkMonYg/F4LNvSU7bg/xkLAjJVo
	zZDfnCnVuk3Fy6VOAHKTK243DUqjzRQ3MLv9yu07CyLkls/qtq23PqPskGUgN2TX
	PqxJfcQf/ai2pZTT2u3xNcT80sSYqd4WyFdFCGXcuvk/SYfENgOwQwcONNOQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1741047308; x=1741133708; bh=V1ba4uj1BcVsl0JfEKR+Vej+CuxMBoE4yHc
	1TaxOIeg=; b=A9L59KWVWERerf9dX9hL57SdRw0WlTORpCvuLmUYTmE9/ThgtA5
	h4zQs1GoTNUvUUA2D71DJXoPD+c3mUoJBH2fsThWr+Cbg6aOSgO2dTGCurksYT90
	O+FkxoLR57ErwWz2DL9ej1wVgyronC5MiH3qd1/pVesSXaHCVe2FqxUB7RuWO4vW
	A/GnOMwquy9dwEIy5/XoPmSqrZlkxLe6DEP4of6mdTVdJ97W8tNQrQrjZmir/2Yu
	foUbkEzXzF/BMo5TkjqQUioLBx5m7rMfzXyuUswkZf4ZcRfqbpJYuT+OPhXZLDal
	7C+u6hyiAAOFONxExl2paUNrYlLwapLLfhQ==
X-ME-Sender: <xms:DEbGZzggJaO6hQIpnEEsHpDFTbiV1Axte_sXDaVdKHVcE5CF3AiVnw>
    <xme:DEbGZwAkV13JNw5gINRpZ2l4gW6msBW1BY5LpB8Keegg8-uaOnDRo-d9dNQPF8MMV
    KqFmKyt5TDkCQgrPQ>
X-ME-Received: <xmr:DEbGZzGs0i8Lwpb9M1l19goHBhY99s4eh_3WhxGYHgdIseDDUd6Qnq7Ir1IanIA9XyTszkDDrmTDpYzoMbhnVweyP7FrQBInY_MGuv3zpb0WwJEywmlG>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddutddtheegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomhepvfhougguucgkuhhllhhinhhgvghruceothhmiiesphhosghogidrtg
    homheqnecuggftrfgrthhtvghrnhepgfevfeeviefhheehhfegtefhvdffheefheeuleeh
    ieffuedvvdeuhfevffeigfeunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepthhmiiesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedp
    mhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtg
    homhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthht
    ohepshgrnhgurghlshestghruhhsthihthhoohhthhhprghsthgvrdhnvghtpdhrtghpth
    htohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:DEbGZwTDdiORdfkartWNZJLMYPppTFxVx_BGW7aDpxwal-sVx3m-yw>
    <xmx:DEbGZwxlukjCKYJq4jJrylZq2Dts0HqnIBF28tC8AdiUtkSJN8vaog>
    <xmx:DEbGZ25qHH5gafjz8RqMhIl9HRphPnorEPK4wWVdZK4tj0NYl-PIaA>
    <xmx:DEbGZ1y2vS2YIaGqIIosF9gI_Mld13Oamx7e8N5N8vtoq7tCXhbSlA>
    <xmx:DEbGZ6s09Y2M6FwG_nQZbTRMGWOHt_041FZRym8htFOjcw2jB7wfpeB8>
Feedback-ID: ia13843cf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Mar 2025 19:15:07 -0500 (EST)
Date: Mon, 3 Mar 2025 19:15:06 -0500
From: Todd Zullinger <tmz@pobox.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, "brian m. carlson" <sandals@crustytoothpaste.net>,
	Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH 01/34] t0450: *.txt -> *.adoc fixes
Message-ID: <Z8ZGChnWGa3sXD3s@teonanacatl.net>
References: <20250303204443.360595-1-tmz@pobox.com>
 <20250303204443.360595-2-tmz@pobox.com>
 <xmqqo6yhvl2o.fsf@gitster.g>
 <Z8YtJd078J44snOE@teonanacatl.net>
 <xmqqbjuhvi57.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqbjuhvi57.fsf@gitster.g>

Junio C Hamano wrote:
> Todd Zullinger <tmz@pobox.com> writes:
> 
>> Indeed.  I haven't looked closely at the CI bits to see how
>> we might be able to improve this.  When we skip tests
>> unintentionally we just don't see that currently.
> 
> In any case, while the t0450 was inadvertently disabled this way, a
> topic seems to have escaped to 'master' already with an inconsistent
> synopsis section and help text.
> 
> Here is a fix.

I'm glad that's already paying off; it helps prove the patch
nicely.

I wondered for a moment why I didn't catch it with any of my
test runs.  But it's simply that the rpm build tests were on
top of 2.49.0-rc0 and my local branch for this was built on
top of tz/doc-txt-to-adoc-fixes, neither of which contain
89be7d2774 (builtin/refs: add '--no-reflog' flag to drop
reflogs, 2025-02-21).

> --- >8 ---
> Subject: [PATCH] refs: show --no-reflog in the help text
> 
> We forgot that we must keep the documentation and help text in sync.
> 
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  builtin/refs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/builtin/refs.c b/builtin/refs.c
> index c459507d51..44d592a94c 100644
> --- a/builtin/refs.c
> +++ b/builtin/refs.c
> @@ -8,7 +8,7 @@
>  #include "worktree.h"
>  
>  #define REFS_MIGRATE_USAGE \
> -	N_("git refs migrate --ref-format=<format> [--dry-run]")
> +	N_("git refs migrate --ref-format=<format> [--no-reflog] [--dry-run]")
>  
>  #define REFS_VERIFY_USAGE \
>  	N_("git refs verify [--strict] [--verbose]")

The fix looks obviously correct. :)

-- 
Todd
