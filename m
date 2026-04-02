Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3E301B6D1A
	for <git@vger.kernel.org>; Thu,  2 Apr 2026 19:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775157568; cv=none; b=sG27iJ7CpDXNYGXfnNMsgLhfbCTcZzUwFwEhURhhssVrsHFmQB4LmyaEyEMiio+aP3TETjkRZ5KfA1lZk7XE/TM64qSHe5mKP0E9EzZLjtyHGv+VkwKCMgUKs7sX7Loh0KLrrP+gRDWDxgoujs6wJonSJWxBorTBRaIBkK19WmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775157568; c=relaxed/simple;
	bh=tIR82Mz9x2bZBeeCD+gpMERp1XwDh3oHvsdYfNCoNxY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uWm05iVzEVZA16nbEHWyixfnVaSPA/w4EzCkHCxDhFiHwXWS+NEcuXqKNCuDJXyBGnzCcm32rDS9J0zUM+ZYjJbA+ppUEyjw1TW9gFYQDxQZoS02FjudP/CrhtS5Rsfs1JOystj++GzhUfqDQGHIwEz8IDSC3OF9eBkzqTBBlMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=X4bGOZ9V; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eDRe9sO/; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="X4bGOZ9V";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eDRe9sO/"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id DFB05EC01CE;
	Thu,  2 Apr 2026 15:19:25 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Thu, 02 Apr 2026 15:19:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1775157565; x=1775243965; bh=/0W1T3YuU6
	Kv0x57XSG0MWackSArwVlQG7hgNQYn9GM=; b=X4bGOZ9VC2sO6Xcttw5FTOFl6Q
	Kjkw8qVa0ZKnHW1GpS67wyIfVs/m7/O4mnorLk4gB9cd+mZ0duEE9QbC+f+Fb9xY
	7y3E0e+NK435G0hjOpH77SfGsUOe/HP+rj00/gJnMyFA7MJRXhfuz7st9IN5IN1m
	6CjFotFmTFp2kNCBld1lhzdNI+HZWEGVC0Dc+1XB0+Nmsa3JSV4Z240SnmYxI0AL
	6Bn5UNxgMUx6+2ca/f4OdWyU3Ln1X5MPnAl5kO2NdkHHkym4+XDQo9gEHvaKB2BA
	Fpi84BWeFfbzZcSUoh1KbmHDwfbIZH5DeHRhO09Qv4AsNyPgSGmKH9JJty8A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1775157565; x=1775243965; bh=/0W1T3YuU6Kv0x57XSG0MWackSArwVlQG7h
	gNQYn9GM=; b=eDRe9sO/iPCAUxtN4pbyckKUEJyhzJPUpEJfuss74eHC5ISnJzH
	RFU8qoOeAFYLvZ6dJzsVKgbNchDPa1nru1pcsvpCbkjJLYCVV8AMb/dqV5nYtYjP
	cKddmfw4kiSr/KsBCSmWAYgQ13y9U/dO/VPWDhett93PmrbFGRl4qEUwHM6MT/OW
	uQnfC6qu6Q6ccQGVshnsctBpjJgcdK8WQPr3OKnIMZdTaia4jv8M1DpD3s2RnOch
	dr1KRkJI2TPXHUfDRyQc/Dclol+YlCh51g55NHJU6rMDEOfxqDK9jKF2xmABwgcY
	GvJEoDLLGI8NBmzIYd10PKpfyQsMTypSl6w==
X-ME-Sender: <xms:PcHOaS5ve--VzhX4x6S8tt_7kDO_O8xrGxYicMu0250_US-znIOoyg>
    <xme:PcHOaS5rCKNKyvdTiOlzBfMgAo-wKIgTke8loJbu88Zc2DSTSjVNNCnaAamgmysK6
    3UB1FcZQwwnEoK8N7wWV3pj_xHjcug_Vt1N5v0IVaL2Affe2u19nSU>
X-ME-Received: <xmr:PcHOaWcEMxtzKvdczdk0Ttf75AwL65Y9GOjlJkYY_GfrTKE6gOGd5-QGPvEZgCfv-sV0khXBpUW0HBUMeD5akYikTMHnyrdJjw>
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
X-ME-Proxy: <xmx:PcHOaeB3waQ6vgjxbW8bxYtm_OBcD3neefamq9oKOsPZ55_iz6z0RQ>
    <xmx:PcHOaR-A1Gd0TOAHZ6iEG5jrGnTTWB-iFZ1EzxoFdCo2oYBSkZDc0Q>
    <xmx:PcHOaRK1wG2CjCorO0lNq1HERLsSyptKTNXqNEjxXbgOH-mgiWd6sQ>
    <xmx:PcHOaShYPu5LisS8Vs9Z2q_8osaYKOtM9Xw3X2mh27f7zrOl3s-7Dg>
    <xmx:PcHOaV8RWh9yaOife84TNbQeIhTl_PZmGAU0pzthE8-L24gFEyWi6gd0>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 2 Apr 2026 15:19:25 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: git@vger.kernel.org,  Ezekiel Newren <ezekielnewren@gmail.com>
Subject: Re: [PATCH 1/4] xdiff: reduce size of action arrays
In-Reply-To: <447b8c0af1746d61bfa26e7908a784583ab5dc2e.1775141855.git.phillip.wood@dunelm.org.uk>
	(Phillip Wood's message of "Thu, 2 Apr 2026 15:57:41 +0100")
References: <cover.1775141855.git.phillip.wood@dunelm.org.uk>
	<447b8c0af1746d61bfa26e7908a784583ab5dc2e.1775141855.git.phillip.wood@dunelm.org.uk>
Date: Thu, 02 Apr 2026 12:19:24 -0700
Message-ID: <xmqqy0j5p3ur.fsf@gitster.g>
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
> When the myers algorithm is selected the input files are pre-processed
> to remove any common prefix and suffix. Then any lines that appear
> only in one side of the diff are marked as changed and frequently
> occurring lines are marked as changed if they are adjacent to a
> changed line. This step requires a couple of temporary arrays. As as
> the common prefix and suffix have already been removed, the arrays
> only need to be big enough to hold the lines between them, not the
> whole file. Reduce the size of the arrays and adjust the loops that
> use them accordingly while taking care to keep indexing the arrays
> in xdfile_t with absolute line numbers.

"As as"???

> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> ---
>  xdiff/xprepare.c | 31 +++++++++++++++++--------------
>  1 file changed, 17 insertions(+), 14 deletions(-)
>
> diff --git a/xdiff/xprepare.c b/xdiff/xprepare.c
> index 1f2e8c6b4b9..4bb3a8ef41c 100644
> --- a/xdiff/xprepare.c
> +++ b/xdiff/xprepare.c
> @@ -273,16 +273,19 @@ static int xdl_cleanup_records(xdlclassifier_t *cf, xdfile_t *xdf1, xdfile_t *xd
>  	uint8_t *action1 = NULL, *action2 = NULL;
>  	bool need_min = !!(cf->flags & XDF_NEED_MINIMAL);
>  	int ret = 0;
> +	ptrdiff_t off = xdf1->dstart;
> +	ptrdiff_t len1 = xdf1->dend - off + 1;
> +	ptrdiff_t len2 = xdf2->dend - off + 1;
>  
>  	/*
>  	 * Create temporary arrays that will help us decide if
>  	 * changed[i] should remain false, or become true.
>  	 */
> -	if (!XDL_CALLOC_ARRAY(action1, xdf1->nrec + 1)) {
> +	if (!XDL_CALLOC_ARRAY(action1, len1)) {
>  		ret = -1;
>  		goto cleanup;
>  	}
> -	if (!XDL_CALLOC_ARRAY(action2, xdf2->nrec + 1)) {
> +	if (!XDL_CALLOC_ARRAY(action2, len2)) {
>  		ret = -1;
>  		goto cleanup;
>  	}

OK, so we used to allocate for the whole thing, but now we only
allocate for lines starting at dstart.  "off" is the difference
between [i], the index into these action arrays, and the true line
numbers.

> @@ -299,8 +302,8 @@ static int xdl_cleanup_records(xdlclassifier_t *cf, xdfile_t *xdf1, xdfile_t *xd
>  	/*
>  	 * Initialize temporary arrays with DISCARD, KEEP, or INVESTIGATE.
>  	 */
> -	for (i = xdf1->dstart; i <= xdf1->dend; i++) {
> -		size_t mph1 = xdf1->recs[i].minimal_perfect_hash;
> +	for (i = 0; i < len1; i++) {
> +		size_t mph1 = xdf1->recs[i + off].minimal_perfect_hash;

And we iterate as many times as we have entries in the action array,
but we need to offset the [i] with off when looking at the record.

>  		rcrec = cf->rcrecs[mph1];
>  		nm = rcrec ? rcrec->len2 : 0;
>  		if (nm == 0)
> @@ -311,8 +314,8 @@ static int xdl_cleanup_records(xdlclassifier_t *cf, xdfile_t *xdf1, xdfile_t *xd
>  			action1[i] = INVESTIGATE;
>  	}
>  
> -	for (i = xdf2->dstart; i <= xdf2->dend; i++) {
> -		size_t mph2 = xdf2->recs[i].minimal_perfect_hash;
> +	for (i = 0; i < len2; i++) {
> +		size_t mph2 = xdf2->recs[i + off].minimal_perfect_hash;

Likewise.

> @@ -328,37 +331,37 @@ static int xdl_cleanup_records(xdlclassifier_t *cf, xdfile_t *xdf1, xdfile_t *xd
>  	 * false, or become true.
>  	 */
>  	xdf1->nreff = 0;
> -	for (i = xdf1->dstart; i <= xdf1->dend; i++) {
> +	for (i = 0; i < len1; i++) {
>  		if (action1[i] == INVESTIGATE) {
> -			if (!xdl_clean_mmatch(action1, i, xdf1->dstart, xdf1->dend))
> +			if (!xdl_clean_mmatch(action1, i, 0, len1 - 1))

Let me think aloud to see if I can follow the logic here.  Looking
at the implementation of the xdl_clean_mmatch() function, it takes
an action array, an offset 'i' into it (starting from dstart), the
beginning 'dstart' and the end 'dend' offsets.  The idea is that an
index derived from 'i' is used to index the action array and the
beginning and the end offsets are used to limit how much far the
access can deviate from 'i'.

Now we stripped the first xdf1->dstart elements from action1[]
array, 'i' in this loop runs from 0 (i.e. one beyond the initial
common section) and len1 (i.e. one before the tail end of the common
section), i.e., everything is consistently shifted down by xdf1->dstart
in this call.  So xdl_clean_mmatch() does not even need to know that
it is fed a shortened action[] array.


>  				action1[i] = KEEP;
>  			else
>  				action1[i] = DISCARD;
>  		}
>  
>  		if (action1[i] == KEEP) {
> -			xdf1->reference_index[xdf1->nreff++] = i;
> +			xdf1->reference_index[xdf1->nreff++] = i + off;
>  			/* changed[i] remains false */
>  		} else if (action1[i] == DISCARD)
> -			xdf1->changed[i] = true;
> +			xdf1->changed[i + off] = true;

But these two arrays are not shrunk, so we need to compensate by the 'off'
offset.

And the remainder is similar but for xdf2 instead of xdf1 above.

>  		else
>  			BUG("Illegal state for action1[i]");
>  	}
>  
>  	xdf2->nreff = 0;
> -	for (i = xdf2->dstart; i <= xdf2->dend; i++) {
> +	for (i = 0; i < len2; i++) {
>  		if (action2[i] == INVESTIGATE) {
> -			if (!xdl_clean_mmatch(action2, i, xdf2->dstart, xdf2->dend))
> +			if (!xdl_clean_mmatch(action2, i, 0, len2 - 1))
>  				action2[i] = KEEP;
>  			else
>  				action2[i] = DISCARD;
>  		}
>  
>  		if (action2[i] == KEEP) {
> -			xdf2->reference_index[xdf2->nreff++] = i;
> +			xdf2->reference_index[xdf2->nreff++] = i + off;
>  			/* changed[i] remains false */
>  		} else if (action2[i] == DISCARD)
> -			xdf2->changed[i] = true;
> +			xdf2->changed[i + off] = true;
>  		else
>  			BUG("Illegal state for action2[i]");
>  	}
