Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0534449984
	for <git@vger.kernel.org>; Thu,  9 Jul 2026 18:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783623136; cv=none; b=iK5KAD7gz9T3kYxJhwyY0S6r1ii4+gY89FJC8cpfmX0fQT81WvkJqYUQjuRFD+2TvU0Z2FFbZV7WZFnlSF5f5bxH3eac4U7Csyf3GcGbdS549A3o1yHnhlAzGgHHwa/Aiao5stiU31OBUbBZyKvLpC1UYFWImoxnn/fv0vjIoYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783623136; c=relaxed/simple;
	bh=EPA0cwcxMV17GAf+LmjDTAN8xT6tXERQhvzIPjiYTEU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KzwOOV+/S21hJ4CjaKQlqWSy+skGeCdSV3t8A0quDflHrgznlCgC3VlrjxlWTiaZqmXlvSjL5r0x+yoM8+bQkjDxHvbo1T+qaFI/kn7c3wtj3rfzNRlELtY7+n/Z2j5cVyYkn/gS3hqPyCAV5wNFxpbDUDGCGX85+ilCv0CTPiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Xbm53Y+G; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZkNyWLnP; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Xbm53Y+G";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZkNyWLnP"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id E9BFFEC01F9;
	Thu,  9 Jul 2026 14:52:13 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Thu, 09 Jul 2026 14:52:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1783623133; x=1783709533; bh=zXfFeDvuew
	HbDYaw06xBhKMnxQA8pD3TXouyGrvDNNc=; b=Xbm53Y+GmxX4DDdL24HppDTsGB
	gR0dwwmnVnTqFfGMs+DsGZRBOWOrdoo7n5bTBRQooj0Ne/CRHQS8dEzV/72k3kTL
	YuQDSh+AFi3UWlFhTERT0jrbhhePSOxLRO9hMphGr4qHXfdyaOXBONOwoIpVQHzu
	450aLj1Fm2IM8Qf0gkOX0k34x/p8UJCZA2fsDTSNkJVTdwGGykEBCYekbI3IEvu+
	JSAD+uaGfRp1I1tqtn8tx2icj1L20ptbgaWWtS1tYu4ighhSjegCaJYdgs2/Tm1Q
	qs2yOS6g3eaYP8xFB2f2zihqm2CbdsXeacZdPWR9ud608fWRsRMwi1hzOD9w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1783623133; x=1783709533; bh=zXfFeDvuewHbDYaw06xBhKMnxQA8pD3TXou
	yGrvDNNc=; b=ZkNyWLnPQQzzIRCwGsaUGtNDcMYCg9epG/fV/EoNr0PCF2RnKsu
	oqmEy9jOMx1wcsDXPjP3dF9siwTMvI7hUMA+LotDvBhSO/Oij0Be8OBnPKsdAstM
	/uC3MMPNcQnZsbPl+qTDKr23cd8/fbvtsVD/wK99DYemIg4y6A3deaw1uY4EStUW
	on5nTpMQIGmz+fNA4H7tmX3aj4F5uu+1Td8qoHuhR/yClCbtIwXr5ImFZmOpuygR
	J5MjOx2Q1P8x//Emg2KjnBI0qBxqMV80FsAuuxNKLvJ3RfrneM+cyebLTsa//PCJ
	7JwvtwQcrksPoL1h3M79NKLYTCVfxqIVgYQ==
X-ME-Sender: <xms:3e1Pamh1MdgYOICj3SmjEXg_YvRMlsygsdhrLojmeSEBhlhJWJOAlQ>
    <xme:3e1PaudkPJoRXr4EDQ6s08yqJp-pRWiX0ErDfM3O21CwLcljn85F8_wz4OWbOIYyg
    HdGPS_Ek3MmbnT0F6X80uuoVjfUuy3neS2HVDLqkyNdufo0eXLTdA>
X-ME-Received: <xmr:3e1PareI0Hnqin-GGydRXMyeM19R2b-25yUPhYdLM3b_de-kRi7d9bNY_VSreSQ2UE5MgTJIXugfkR5MOQD0qED1FxGNq9wmkfLm9wM>
X-ME-Proxy-Cause: dmFkZTGZKFLumNq4xFyECS8lZLwaZX/En1jGpUYFfoLnJA48j6SqsRT968jmPYFEiRYMA2
    I4JMdcxmi/kiFCe3xSm6a4705/qrlZafNBCmBOX16PxC+IF9H9OZJMXJPW7pv56fKfH+n+
    5fGSkih91DC6EHv68FMqz5ATdQjYoO2aka6RMPEuv2E/vgN2MJnvPzo+xv4Es9Cfwau5AP
    2EhDcB5ranV/YDAdtO+wRmFuoYTETLLFTcZo5UktRHm1QfMgViezwadKWRFAb7FocuPrd2
    kqJUsO3MglWxH1fC8/cH4E1V6kBU2IYKQCmCgf1DjjpKwJQhnfKCzwTUqWCw1BW7ppXxcQ
    NUdGJIZNKFge5VT2bzbgEp8PYGscDekS/f0msz59Ij4ienZfVLRvF9zZhDzymkVgZ9qzr1
    qfhlcHSvfCKnpDt1F921JzZ8Y2Kl6B4G2Pk2k3xZWC9mzjFR/SQ/WdLUCUrxGnM46lkUQp
    /oefRPjToFcMQqhbTNYlep3kYMFxq5m4E23zQCGJfG59F1qsTIQ1J+9iWIiGSEUDPJgQR8
    dvXX0W+XNyu8khi2VLL4qZeyQQPu0IJai52UeGQDvq8wf+jKuHU1UP8nc/q0Vxg4w4DSvP
    ySpdVaJxgHb/n0wXhHvCUCNFTnzc5idpN2rSR4DyP3QUmDAoVt+d+Is+JeRA
X-ME-Proxy: <xmx:3e1Pao8jHdxJ3Zh5MmYgwq9EiTwujyB1ycL9TMLg4SQAnMapB7KEQA>
    <xmx:3e1PankZkBo_V1llPCNO8pmN_K2RqfO7G9Zg6moaDHHBrI9vG-2tOQ>
    <xmx:3e1Paq8PWzoHryrFbgaRRUNhlwkph_hBmYJoa_TQqIRVtnSf5SZckQ>
    <xmx:3e1PalnxA042ArwTqNhA2kYzCrpWhBz7xhBf54rv48oUvQrUHcGDfA>
    <xmx:3e1PamlSZ8SyaaZM7-R_vvGAmpPWucuwdpe6YS4eCTwrYzT11-cl28rM>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 9 Jul 2026 14:52:13 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 1/7] refs/packed: de-globalize handling of
 "core.packedRefsTimeout"
In-Reply-To: <20260709-pks-refs-wo-the-repository-v1-1-1ad6f27529c9@pks.im>
	(Patrick Steinhardt's message of "Thu, 09 Jul 2026 10:29:12 +0200")
References: <20260709-pks-refs-wo-the-repository-v1-0-1ad6f27529c9@pks.im>
	<20260709-pks-refs-wo-the-repository-v1-1-1ad6f27529c9@pks.im>
Date: Thu, 09 Jul 2026 11:52:11 -0700
Message-ID: <xmqq7bn4ov1g.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> diff --git a/refs/packed-backend.c b/refs/packed-backend.c
> index 499cb55dfa..5c49c06493 100644
> --- a/refs/packed-backend.c
> +++ b/refs/packed-backend.c
> @@ -162,6 +162,13 @@ struct packed_ref_store {
>  	 * `packed_ref_store`) must not be freed.
>  	 */
>  	struct tempfile *tempfile;
> +
> +	/*
> +	 * Timeout when taking the "packed-refs.lock" file. configurable via
> +	 * "core.packedRefsTimeout".
> +	 */
> +	bool timeout_configured;
> +	int timeout_value;
>  };
>  
>  /*
> @@ -1233,12 +1240,10 @@ int packed_refs_lock(struct ref_store *ref_store, int flags, struct strbuf *err)
>  	struct packed_ref_store *refs =
>  		packed_downcast(ref_store, REF_STORE_WRITE | REF_STORE_MAIN,
>  				"packed_refs_lock");
> -	static int timeout_configured = 0;
> -	static int timeout_value = 1000;
>  
> -	if (!timeout_configured) {
> -		repo_config_get_int(the_repository, "core.packedrefstimeout", &timeout_value);
> -		timeout_configured = 1;

In the original code, when core.packedrefstimeout is not configured,
our call to repo_config_get_int() does not touch timeout_value.  As
a result, we get the static 1000 and flip the "configured" flag to
prevent this _value from further getting updated.

> +	if (!refs->timeout_configured) {
> +		repo_config_get_int(ref_store->repo, "core.packedrefstimeout", &refs->timeout_value);
> +		refs->timeout_configured = true;

But what happens in the new code when core.packedrefstimeout is not
configured?  It is up to whoever initialised refs->timeout_value.

If I am not mistaken, packed_ref_store_init() does xcalloc(), lets
base_ref_store_init() initialise some members, initialises a few
members itself (such as .store_flags and .path), and leaves other
members, including .timeout_configured and .timeout_value,
NUL-filled.  .timeout_configured starting as false is perfectly
fine, but shouldn't we initialise .timeout_value to 1000 as before?

Thanks.

> @@ -1249,7 +1254,7 @@ int packed_refs_lock(struct ref_store *ref_store, int flags, struct strbuf *err)
>  	if (hold_lock_file_for_update_timeout(
>  			    &refs->lock,
>  			    refs->path,
> -			    flags, timeout_value) < 0) {
> +			    flags, refs->timeout_value) < 0) {
>  		unable_to_lock_message(refs->path, errno, err);
>  		return -1;
>  	}
