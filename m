Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FDB233F5B5
	for <git@vger.kernel.org>; Wed, 20 May 2026 06:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779259711; cv=none; b=dE1vMrloQxiAyqhKAq/d0kNpVztDFBlZqvOnsV2gVUfjIVMR1FmndpLViTVeprumRZolMG/5eZWrQoEkTDdXkRtqkQgpWVnvfWrvkr+DIUPaEihMUmJz5c+lokuPKlGKCY5LXVeoese1oyGd1Y+RxrVLwoKVPvmKbyhyk1Ooe/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779259711; c=relaxed/simple;
	bh=UHMZHbGj2WNsU2kC1M7bQ9lUFfY5+QatCeXlSOf3NAc=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tQdT8AQ2nkWGlhld54lmmQ96fE87HtWMBgsVchUy1UDcI25k3oBhcbhAijx1lCM297G9PJycX6Sz4D2DUdaoEkiphprNTMolQlQH5UOdy06KC7t48RhIGF1Vi9kjLmOokIgytV561EBCoPUcglK7G6i70tl3kdInyZ9MkTLe9hM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=vKkyddJw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WojVhxD+; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="vKkyddJw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WojVhxD+"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id ACB321D0011B;
	Wed, 20 May 2026 02:48:29 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Wed, 20 May 2026 02:48:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1779259709; x=1779346109; bh=ngeRtqvl7J
	gLaqPzXDW0h1FjUHUxDhxLQSMSMCTB3ag=; b=vKkyddJwUp/Cpd3RTCiVXUUvUa
	saH6nkxjgRJebiUQAgzBGh5m+JxAxDcsQH32+6dmjMrQWi8fI5McaYr7GHPMvcx/
	azMFc19XgFzdc41w/4sYZvhEWO7rmsatLFuUGQ01q6PeiS6LBo5OUMbG5iv9T7IJ
	RvinBIgVybzQ6n+tXnXKKtFN2bt+lqVJSNF4y9qrxLJC0JubuKHgUBlFr+iVIBUM
	8t9oqfzdRabkf+VjJK7uflWKiEy4l8ArX+vBvgEq+WNBMUzU5Y9EvAdpggSSsJoP
	Uo7y8GhOLSGh8vjft0e5PLSsv02ne0UZenWbBkv7b9w1OkqeS4p5tQQ8orrw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1779259709; x=1779346109; bh=ngeRtqvl7JgLaqPzXDW0h1FjUHUxDhxLQSM
	SMCTB3ag=; b=WojVhxD+cwoRmDKi8sWIUtKXn00eQam627VbOanKQJSuEqHUFaF
	qKCjXrWUKFl2hn4wRTzYYzFqkSYjdfqLnYy1uDh8SDM0j+uDU6ykAM8WTAo8SKl7
	fmHC3FvM+qR5unPaPi4z9dXQ5mGIiH1g/2zn50RhdN3jrOFnoWWqm13iwXylOapO
	jFrJOFC3qyuaxk0LJ64suUS/VB3I4wu9AvGmUlmAZ30eDq3d06VrfCIAjGPF3SVu
	QNi2PnLpyCxkrWuVVCNHu8v34M3whgfv2TO/4lpbSAvlbCf09/N8A9FFBFP84iWJ
	VP7pkVk4ULLUvidf+Gg5VjWEYPD82MSE5RA==
X-ME-Sender: <xms:PVkNanJrqp1Dmi0gFdsKmy_vicZPLuw483AyYlijRZvEev2dhr_xvg>
    <xme:PVkNahLLw__ZSioe2v1AEetm_DjbE5EqZ15836tqBIrmcwa_Am1yFFzsJSBLRTCBE
    VfsmKFgZwJsEBxlA9Ae18-mI4CezhdwqvnRq_2dWjGJpoxMjojWQEs>
X-ME-Received: <xmr:PVkNatWYsNPC2KUXTW6-rhAE0sdJQHURZNhOpbIkWkIgK0X1yUC826lg0d4MJoBC8F_kQPF_okj0Sb_x8Bz1MeGg50WcUvNMJg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddugeefleehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvffujghffffkfgggtgesthdtredttd
    ertdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphho
    sghogidrtghomheqnecuggftrfgrthhtvghrnhepkefhueduteekgfdtueegvdfgueeiue
    dvlefggfefkedvffduvddvkeeuhfeifeejnecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspg
    hrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrd
    gtohhm
X-ME-Proxy: <xmx:PVkNari5to282NWmHCZw0Ldvb78J6a4ltdTHLKAGe3s3jJdOvvhl8w>
    <xmx:PVkNag_hDjGLQTZJdZwRKj1kaORDKj_YnBplMAE1VBF2Z03LwDS6Ww>
    <xmx:PVkNatA49Vr5PlZpFN1f7CAV9Tv4aAZcgM1A8aIMnDzwtU5lVah1XQ>
    <xmx:PVkNalLDyKYr56BX3Hj_XqQ0-XB_3dGsQnlkGdFU3Nnnxxt6D21G3w>
    <xmx:PVkNaqgaJNbUC12fv3D_9EuZTQis8JJJy419NjJGCu6sfNwK5ywE_RwE>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 20 May 2026 02:48:29 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: Re: [PATCH] apply: plug strbuf leak
In-Reply-To: <xmqq33zm4msa.fsf@gitster.g> (Junio C. Hamano's message of "Wed,
	20 May 2026 15:28:53 +0900")
References: <xmqq33zm4msa.fsf@gitster.g>
Date: Wed, 20 May 2026 15:48:27 +0900
Message-ID: <xmqqtss237b8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> Depending on how read_patch_file() fails, it may already have read
> many bytes into the supplied strbuf.  Either the caller or the callee
> should release the strbuf.
>
> Here we choose to make the sole caller of the function responsible
> for releasing it, as it makes the error handling slightly simpler.
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  apply.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/apply.c b/apply.c
> index 4aa1694cfa..0167902325 100644
> --- a/apply.c
> +++ b/apply.c
> @@ -4881,8 +4881,10 @@ static int apply_patch(struct apply_state *state,
>  
>  	state->patch_input_file = filename;
>  	state->linenr = 1;
> -	if (read_patch_file(&buf, fd) < 0)
> +	if (read_patch_file(&buf, fd) < 0) {
> +		strbuf_release(&buf);
>  		return -128;
> +	}

Ah, my mistake.  This was one of the two "oh, we found longstanding
issues immediately after enabling EXPENSIVE tests on" fixes Peff
already fixed for us.

>  	offset = 0;
>  	while (offset < buf.len) {
>  		struct patch *patch;
