Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A92753542E1
	for <git@vger.kernel.org>; Wed,  4 Mar 2026 07:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772610166; cv=none; b=GGEG8Ccq9DdUPdoolJRteM+mgyj+CFjdyUuDiUzBgdLva9MNbiM6ynkqyhRnWSDNeMtfaKEyLqD10ke61piCCKjzDABwu4G9WORx0EdA2mHbaK/fRPuL1bnUktzK1igEPAbiFKYWEox1mv7YjFRjSEQYxXMlTtbkdE9N++HHEW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772610166; c=relaxed/simple;
	bh=I0nkqNQNBgvwaFDeroQMLbPGYXMkOPvT7fvh61vcj/Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qfPvCrfmSrJIwEe4m18FVaRzMuW2xpubnqpWl+3YLxMQiHJBAG4XWZ9tL5UbrDJvveQMFy81uEpHQuRUzXYT8zEyghHANYGMYRpyDzHtw8VIISUM+e8kHejFDdTbMKaO90NT7XzIkh2SiBrs8AgJgUJ8BLLBk56yPvvw9E1+5NQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ocqoz7t8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=L9R2JZjK; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ocqoz7t8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="L9R2JZjK"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id C6055EC00C3;
	Wed,  4 Mar 2026 02:42:43 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Wed, 04 Mar 2026 02:42:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1772610163; x=1772696563; bh=OMVuskz7Vs
	vZTLP3JHeaFcuomTXo8gjtczsb1W3Uwmo=; b=ocqoz7t8Luls6WJsiW9nq2uMrh
	SOJefdhTFhMqoynMjWSdzENiDMMK+MIzu6XbiYxrdUMbSJKM21tgh2NP2EiEfNj0
	AKlCSEAa9EyckkGw+HDfu4SvA6f8F+IfFnKYbTk0iIhJRnouKezoWJYW+8jON89H
	JUsObO3ZkqVdsRjY/SdqP7c0oIday7IfzXBpCxOE3uMzzZZGwWS6u5kDrETkRkzM
	UnV0Yb7Y8nlER4uyg+JDzLNSjTcfkO1RaKqRhwxBxb18inOs/pyCzekzKJcoktdl
	Pb0yYMOGhtbOSzN1i1NNcTEhN2haWV2mPCJemeQF4Obb67icvUa1qSVhEfDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1772610163; x=1772696563; bh=OMVuskz7VsvZTLP3JHeaFcuomTXo8gjtczs
	b1W3Uwmo=; b=L9R2JZjKTKsNOD17DcaZtnXxdtm4Tn6LxygUg2IY+Er3CZT/4HB
	m6a6XCI5M+NDQ033/y3kFYSysAvopuc/eGAhow6iTCFWtND4OrBOQZC+tfPGVmhU
	A5CBuqaqFl+I82qVVf5rHOLgWMtizGlel7/Z8xy75LYkFePgwhq3UsmXxeHW3z5K
	/TKfqJAsuDNYH2kfNRLEroiOHvkybka/T9WJX1cyK5JZ99AS9Kzao6kjQx09Z11D
	cSwlR0kwd7+4LBSGrq16rhom0j53wEbZIQl33e0g4wMHeDvLnCSjcW/tMqwlnAmi
	kwNA59SydRYSshH7u5l/o76zhuxiA/LZCSQ==
X-ME-Sender: <xms:c-KnabKx-MGa85SthyYzyUZameQry6yk6OF44jJq9fDGu0LD0ZhblA>
    <xme:c-KnaWmMc-TEF5J_qMs57VZvJq4n51JNJZvShGT-xzOAGU5rWuPDgLrTnpU7O24x3
    QSGJADOwwMpbFYyAlJp2LxXpnLm7emB80VF5TFO47KyxJ5kxTpNpw>
X-ME-Received: <xmr:c-KnaREno8j1s_Kc_6M_y59qMLiqiKpOscH6ptPIsTPrzHZnTmhi37WDZyxgDF3Bg8kuqMb723yonYBFwAi6sBB3FOJYXjmNTzx7Kyl0xzETMw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddviedvleduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithhhuhgssehprghulhhishgrghgvvghkrdgtohhmpdhrtghpthhtohepghhith
    hgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghr
    rdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:c-KnaeFrB63qcYOg78je9ap6dyxb1KvdNOtNVpPKvaC7CIJnKkphpA>
    <xmx:c-KnaWOQ4lJaO2OtUbHUkWQkKq-MY4RbxN-QddAWuJL_xcD0FBNLHw>
    <xmx:c-KnaVHtBdh-mPSgS4ciunKvB2CcVn0CdvhdoQEIbou207uqu_bu5w>
    <xmx:c-KnaVPbO8CtpZM9HpKieUbGAJvs0RPmxrRoZxVZLNHSltqXzCFFxQ>
    <xmx:c-KnabAz8eriYmoW8fq1VFllUgV-Js8JBEvDBUFsE8TvRmFW9_c1xQqP>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 4 Mar 2026 02:42:42 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id c680ce9c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 4 Mar 2026 07:42:41 +0000 (UTC)
Date: Wed, 4 Mar 2026 08:42:33 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Paul Tarjan via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Paul Tarjan <github@paulisageek.com>
Subject: Re: [PATCH v7 01/10] fsmonitor: fix khash memory leak in
 do_handle_client
Message-ID: <aafiaS-DscdIkori@pks.im>
References: <pull.2147.v6.git.git.1772050636.gitgitgadget@gmail.com>
 <pull.2147.v7.git.git.1772065643.gitgitgadget@gmail.com>
 <4d4dec8fa161926e6f6ac822aff0db35353705eb.1772065643.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4d4dec8fa161926e6f6ac822aff0db35353705eb.1772065643.git.gitgitgadget@gmail.com>

On Thu, Feb 26, 2026 at 12:27:14AM +0000, Paul Tarjan via GitGitGadget wrote:
> diff --git a/builtin/fsmonitor--daemon.c b/builtin/fsmonitor--daemon.c
> index 242c594646..bc4571938c 100644
> --- a/builtin/fsmonitor--daemon.c
> +++ b/builtin/fsmonitor--daemon.c
> @@ -671,7 +671,7 @@ static int do_handle_client(struct fsmonitor_daemon_state *state,
>  	const struct fsmonitor_batch *batch;
>  	struct fsmonitor_batch *remainder = NULL;
>  	intmax_t count = 0, duplicates = 0;
> -	kh_str_t *shown;
> +	kh_str_t *shown = NULL;
>  	int hash_ret;
>  	int do_trivial = 0;
>  	int do_flush = 0;
> @@ -909,8 +909,6 @@ static int do_handle_client(struct fsmonitor_daemon_state *state,
>  		total_response_len += payload.len;
>  	}
>  
> -	kh_release_str(shown);
> -
>  	pthread_mutex_lock(&state->main_lock);
>  
>  	if (token_data->client_ref_count > 0)
> @@ -954,6 +952,7 @@ static int do_handle_client(struct fsmonitor_daemon_state *state,
>  	trace2_data_intmax("fsmonitor", the_repository, "response/count/duplicates", duplicates);
>  
>  cleanup:
> +	kh_destroy_str(shown);
>  	strbuf_release(&response_token);
>  	strbuf_release(&requested_token_id);
>  	strbuf_release(&payload);

Makes sense. If I understood correctly I think we could improve this
code to stop using khash directly and instead use a strmap, which
has a nicer interface. But that's certainly outside of the scope of this
patch series and rather a #leftoverbit.

Patrick
