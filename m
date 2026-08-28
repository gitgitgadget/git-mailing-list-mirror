Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33D5C1DF748
	for <git@vger.kernel.org>; Fri, 28 Aug 2026 22:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787957843; cv=none; b=qCw71htEAFXW80yOLsywV+PrEt9v5eedhtrk9YtEiy14jSpTM4iUTiPWol6tmm3VG7j44zDIrxNzCO4ZvBmbcjelhAUjHynEnN1nqXsCA1lV6OpuXJNB3Ud78tJph8XfACyLmo0w1VOefiDMnekqZa2AYASFVsvAN/o0QDW0ERk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787957843; c=relaxed/simple;
	bh=/8zc4XFzwT10KTZpDa+Pgmwg6TCpprRsov3WLvVALAc=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=EfIryeUe5lCkt0TG989F42+XYoA1p9f9r5r4bqpqAPaeJUdUTEoeZEd3Eifk/OMbQj+MGpxXpefwzqDWM3W4EODiDUi3UarjvXgZCf6qMugt1OvVO1VkiyxOewWNSbixmDTDg1uf58AgvIBWlpITX8h3YN4aDrbGcMY4eSCvubc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=vIte1D4w; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bs5nv0+R; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="vIte1D4w";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bs5nv0+R"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 6C0C41D00157;
	Fri, 28 Aug 2026 18:57:21 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Fri, 28 Aug 2026 18:57:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1787957841; x=1788044241; bh=+xUFIcobEx
	tXw5BScetb/hXDJBkitRS3QT8yKeb9XOI=; b=vIte1D4wm5Eh4cqLU7qwbORL+j
	ec12IGxgsM40lcgLJu8iT41MEZU8PEvCdGw2MT0yk6RdAWbUtU5wL92Wsc2YbpwK
	/GGHSHGYJB3B2N5SyxooWeVdW3zrNvOZcBGR6YzpLfpqvo5PHF4jnWpGGueJHqPG
	xQNAfU9V6ox5K3bwu8+u3KoDyl1zgGyOedWhKHSvf/IHTyBRg32nOetWr8U8wAAF
	vyUnOq59XfpVoKC567qIo5wa0W6+z2mWxwhYgBEYWIrs35GWa6n4jfI1y+/DNaOC
	ETvRvJyYHBC967wvETiUxLlflRPPQ7KKJ/BjMVJ+BEa+704omM5qsJCsxpTA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1787957841; x=1788044241; bh=+xUFIcobExtXw5BScetb/hXDJBkitRS3QT8
	yKeb9XOI=; b=bs5nv0+R+gTEeC8Aj8v3lQEB4Z9XROt7wszFnFTrDG+G1xKpDnM
	ppqOpCrdpMPhwkFilLk5YL++V/xKZfo4sdaBqHCY9BtPpeWUpFM6NyfNcDpfOiuq
	0ZG92vC1IRG1RVtc1VLkhQq89ASugz/l1CxOXq2RHeujkaPbmUDEbfP+p8fCGn3/
	1TGkrILT4hOtZHVuSh+IAvhdNoLxxE1xgskpNzV1G951Omax8lf4vPdG9E5up5rw
	pBdqLgDUsco8+C/WDtwyWuomGtivoWQ1VAYcbAL9vpb1S9So4b/NyqLVQ4fdsXM1
	y6RinMKP5/lwIoOmJsdsoImTMQ+wHL5D74g==
X-ME-Sender: <xms:URKSamWHrOOmZxSpmoDVpgA2yQ3eefNFocjlUnFGWEws2xtSM3-snQ>
    <xme:URKSaokDyjFVlzjT-kZj6E4eeUIsIGq_q3oaoLEUIXTB4VFTE1LhnR-tYDx0SBXqf
    GP6QFWUY_Zc4LG0p2nxjqy3bYV9IDZ1GzcEy9PorQwSNbpZ9GTgPw>
X-ME-Received: <xmr:URKSaoCNxfakLCJwPBc311RfGwR7sgagEQscDDS7-oc7Dwus2Wz0TmrGvk2V1tkRAt601yERgFhe03trv42HjT_kR7f1_Vms4g>
X-ME-Proxy-Cause: dmFkZTFeA1sKfnaGx2CxC2MorUhWJ4EO+vkNljP8mkEmjGkzYJW6o+4uMyTYCUfFTLoFfW
    ay7JeCLUvKOpM5lBrHeNnCE4T8J4yeNegKqKTStLLsEOC4JsoCOB6YxUXeV+2dcrFsZWfE
    8vHktF3YHUDK+EaCsfjYc7qN15+tD9MSxzZM2g2pczSc8nLIlHSxXA5thOGdZHovi1Mf8L
    qZrkXW4JmHGfx8+3eV5XKYFDjvEZZQb5RDmA+fNwN3f1V96ddCpCspVWFXpFCnKWutSaDQ
    UMfAQ7btbhm1wr1Cd09UdvNg7xtzD4nP8Dcx0YhoAltuH8ICU/nw0x4OLkZHCBdm3jBkN/
    DFPAAgWxtY4PBnPQSd4VHwoJQl0Nmwuj7RhIBhVXoYTFhGW/Tf2IHKcnKt8S7VKEIq4AEu
    5GYjSOuginf+dii4nGoLQMrl6yfQEn9usFn+bmfYv6/S+YnShz0ma6VWySKZ7bZFTtIid3
    H2LQNmZLXC5KRBBc7g6xKAdG42l9kI6F61WLFQBOagDwwt/PsL6AqqZkVWXQRdCYX7rndT
    XfFY9AKdpqfyMGLAw1UTtdvqyaA0sDEXXiGsHvpWlMkNWgcd3kUwPqt/X4TCHaWTZoGH8u
    J/gNvISJbi8s9HiqNCyVTl8hZBSkG9OOU9xC+E/VKG+onTiBvxQ7OIvIMdvw
X-ME-Proxy: <xmx:URKSaoeIGCkBzygjj9E0emQW4X2z3fKDswBWLyIsSUfgnoQ86b52Ug>
    <xmx:URKSajLpVWIzUzFRUu-X-paBOCY3lQv27UKVQwAoeFMkI-ZpaTs8VQ>
    <xmx:URKSarchxwFcKkhcbGcKmkzGEN3Gl5A2LmHOhQBpQE5fS2PSUNR4ig>
    <xmx:URKSaq13XEz9w01LIqq8TLfYXyO2s1LLuiKhj8UTlmSYPMYF1UxFEw>
    <xmx:URKSahssWuV-RHnnTko8CXgBIHJ9PWCOTtMNp-8HCEpboX6pKCYkXRnD>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 28 Aug 2026 18:57:20 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: Re: [PATCH 8/8] checkout: move post_checkout_hook() to checkout.c
In-Reply-To: <20260828225206.310500-9-gitster@pobox.com> (Junio C. Hamano's
	message of "Fri, 28 Aug 2026 15:52:06 -0700")
References: <xmqqh5kd3lm3.fsf@gitster.g>
	<20260828225206.310500-1-gitster@pobox.com>
	<20260828225206.310500-9-gitster@pobox.com>
Date: Fri, 28 Aug 2026 15:57:19 -0700
Message-ID: <xmqq7bl93lbk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> +int post_checkout_hook(struct commit *old_commit, struct commit *new_commit,
> +		       int changed)
> +{
> +	struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT_FORCE_SERIAL;
> +
> +	/*
> +	 * "new_commit" can be NULL when checking out from the index before
> +	 * a commit exists.
> +	 */
> +	strvec_pushl(&opt.args,
> +		     oid_to_hex(old_commit ? &old_commit->object.oid : null_oid(the_hash_algo)),
> +		     oid_to_hex(new_commit ? &new_commit->object.oid : null_oid(the_hash_algo)),
> +		     changed ? "1" : "0",
> +		     NULL);
> +
> +	return run_hooks_opt(the_repository, "post-checkout", &opt);
> +}

Not a very good illustration.  We should teach the caller to pass
"struct repository *repo" to this function, and then teach this
function to learn what hash algorithm to use from the given
repository instance.

> +/*
> + * Run the post-checkout hook.
> + */
> +int post_checkout_hook(struct commit *old_commit, struct commit *new_commit,
> +		       int changed);
> +
>  #endif /* CHECKOUT_H */
