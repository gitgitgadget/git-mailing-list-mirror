Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9080C18D658
	for <git@vger.kernel.org>; Thu,  2 Apr 2026 19:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775157609; cv=none; b=MBxTmmXZSyUDt8TRmZMx6DIgvOUeDCSnzNKV+m/ZC46Twul6eG4tDSYyU1SzdOBvtOf54GD9bPiy6MhLa3gelK9CbkrIPlgmi/YqPChsAftlrkfg+o/7iJ+s8YXA2ATeyGEKa7FdFUZlpDfGtvhiTHcR1UiAlJrbQ8UapSeLTkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775157609; c=relaxed/simple;
	bh=sDvy7j/bJyTFkhN1d3gCXcLu9VlLViZZTMy8VCFGN50=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mrVL89eo+3exJ1UM4FL94MAYWkV1L27FKGCQRSHuZz5TiM4tDbX5bC8XDyqVwtFnbPniQo/2euSuDw1eWFtIvkeZ9x9x75V/2tqVmdZYi4dn2y667FujGjjDGlf8lupBgi96dY6E13/96VOh9kaeZ0Erng5B4Vv2RERkrrgeBGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Wyb5tV7u; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QiBWu6uE; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Wyb5tV7u";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QiBWu6uE"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id B4066EC0203;
	Thu,  2 Apr 2026 15:20:07 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Thu, 02 Apr 2026 15:20:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1775157607; x=1775244007; bh=3iJZ54Mk1h
	dX2qpJQbruX4OBVjgLveueH8KwQZb9rp0=; b=Wyb5tV7u8cGgi2twQPazicVBiI
	16EWw9W0SyNd3dHbXivDhQgSc8/wsaB4V1AryR1tM8007xwFaiZ+1m7S/lZkHsgT
	oan1bD9YzcQtYjO9hA+BaVYQfinHOiEOEVoz5gApdkvkgRkG30k2UHgwM3Sl3JRA
	Zsf52qwO9ckZpSPRdjXtf2T0GBHIAiY6tauvtSyFLUYqZiO7D9ntotywT2rTVOrf
	dJ9I7gk9s4mQ9kbpLYrDS/12A6zxtot89Vd2YEnwDSo+oFK8kVX5g5WZo9mWUFFH
	NNTpfN2zVmhVUReWRn4KWAQT5WoKXbg1eR0erYzVlfAeVqkc3IKf0b23O3iA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1775157607; x=1775244007; bh=3iJZ54Mk1hdX2qpJQbruX4OBVjgLveueH8K
	wQZb9rp0=; b=QiBWu6uExI7NZVrc+pOxPZ/TF6IJ2C9kZbfSNgcgtDi/nvzk9zN
	Vg9Lunf4jPr80RlarJrKt6psiGvRxr3lZ5bkSFcNza9iAAloLDf8sHtdRatCj/U7
	kPYZQfq2h/9OOllXEkZ7Tn3rCr2OdkulLDwsLdCzL6R4P1V6ofC55MKVB66BnqEq
	X4OWnmke8IX/FlI1HFya5WsrVBGBHWxZxsk66j2xM/5c8pNppbEpE3VmgFF0xbSL
	pi6xSk2ukgLEwCwBDPFG7i+OseZq1HztuBY691JnPO5hCUiLloDBj0ZLG9DRidtW
	M0pJ+8+YxpOcRy4Ae+/fJe+bRC7TX/UpHgA==
X-ME-Sender: <xms:Z8HOadmJmj3sW-zySSSyS8RzhKfVtCt0idCjOriEViWaUTTHuFTD_w>
    <xme:Z8HOaf1n4Lerr96zjZ9xrXNfPAK0OgoaxUgmcmQqPBbHi81qxL1HnS0dU-JwWHoeI
    y7JOksGbXGyj5LSDCD8QJT3IwvkiF5zSAaMH1QhLmRt49QhwJEupHk>
X-ME-Received: <xmr:Z8HOaYqiH5m1hQtY41ls8Q0CJwKpxAt7V993GePl0BOl2QiMlo3et7OINMSAUfaofQxoYrYX991ZmGgdVaxoRJJLDU-p7QH5oA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdeikeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    ephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcuvecu
    jfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvg
    hrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeeigeei
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhith
    hsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhht
    phhouhhtpdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilhdrtg
    homhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthht
    ohepvgiivghkihgvlhhnvgifrhgvnhesghhmrghilhdrtghomhdprhgtphhtthhopehgih
    htshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:Z8HOacc-2Pp_r6bUBeiOWp5lWbQtyZpLNTRSR43PBsgeg6_wVBIzHA>
    <xmx:Z8HOaXq6LjWjQ89gDmporj6LpnKLe9r4CMkEJkdDVywQEvO9Vv6a9A>
    <xmx:Z8HOadFPfaObvu-6lcV-R58-LqpCGkfEy_h5xBuIvB7z4uiCYvX5OQ>
    <xmx:Z8HOaXvVp4zk93BOATkBYJ3ljxGZf74k-gi-6bTTyresJtR7YjRj-A>
    <xmx:Z8HOaUKZ6a2D4LzBu8iiTDZT3jG48MWG31LayqrGqROW5TRrfN1jnbgK>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 2 Apr 2026 15:20:07 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: git@vger.kernel.org,  Ezekiel Newren <ezekielnewren@gmail.com>
Subject: Re: [PATCH 2/4] xdiff: cleanup xdl_clean_mmatch()
In-Reply-To: <78e9313fd44c7cd9f820109edb103a680aa73ad3.1775141855.git.phillip.wood@dunelm.org.uk>
	(Phillip Wood's message of "Thu, 2 Apr 2026 15:57:42 +0100")
References: <cover.1775141855.git.phillip.wood@dunelm.org.uk>
	<78e9313fd44c7cd9f820109edb103a680aa73ad3.1775141855.git.phillip.wood@dunelm.org.uk>
Date: Thu, 02 Apr 2026 12:20:06 -0700
Message-ID: <xmqqtsttp3tl.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> Remove the "s" parameter as, since the last commit, this function
> is always called with s == 0. Also change parameter "e" to expect a
> length, rather than the index of the last line to simplify the caller.
>
> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> ---
>  xdiff/xprepare.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)

Very logical consequence, given what the previous step did.  Makes sense.

>
> diff --git a/xdiff/xprepare.c b/xdiff/xprepare.c
> index 4bb3a8ef41c..f8e6a6d74d5 100644
> --- a/xdiff/xprepare.c
> +++ b/xdiff/xprepare.c
> @@ -197,8 +197,9 @@ void xdl_free_env(xdfenv_t *xe) {
>  }
>  
>  
> -static bool xdl_clean_mmatch(uint8_t const *action, ptrdiff_t i, ptrdiff_t s, ptrdiff_t e) {
> +static bool xdl_clean_mmatch(uint8_t const *action, ptrdiff_t i, ptrdiff_t len) {
>  	ptrdiff_t r, rdis0, rpdis0, rdis1, rpdis1;
> +	ptrdiff_t s = 0, e = len - 1;
>  
>  	/*
>  	 * Limits the window that is examined during the similar-lines
> @@ -333,7 +334,7 @@ static int xdl_cleanup_records(xdlclassifier_t *cf, xdfile_t *xdf1, xdfile_t *xd
>  	xdf1->nreff = 0;
>  	for (i = 0; i < len1; i++) {
>  		if (action1[i] == INVESTIGATE) {
> -			if (!xdl_clean_mmatch(action1, i, 0, len1 - 1))
> +			if (!xdl_clean_mmatch(action1, i, len1))
>  				action1[i] = KEEP;
>  			else
>  				action1[i] = DISCARD;
> @@ -351,7 +352,7 @@ static int xdl_cleanup_records(xdlclassifier_t *cf, xdfile_t *xdf1, xdfile_t *xd
>  	xdf2->nreff = 0;
>  	for (i = 0; i < len2; i++) {
>  		if (action2[i] == INVESTIGATE) {
> -			if (!xdl_clean_mmatch(action2, i, 0, len2 - 1))
> +			if (!xdl_clean_mmatch(action2, i, len2))
>  				action2[i] = KEEP;
>  			else
>  				action2[i] = DISCARD;
