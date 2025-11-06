Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C387B2475D0
	for <git@vger.kernel.org>; Thu,  6 Nov 2025 11:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762430291; cv=none; b=LhDTNPQlrypYqBx/RmqcPGRbOQi6UiC2t/ZfBts3PbK6N8T0WfXaoJBpEI+//K6hSE6nGrhEVIAeMHU92wT+/H/v2CJRZx0Ed18mxxEBt3hUD+ji/KJmX9V4AeSfyntSMgmFUqcpq5bI27k1+WImQHQYOkW66LJ0jqDsnpBJl5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762430291; c=relaxed/simple;
	bh=67hRGkq2MoJcJHihGzzoEC+TOg9vfFcZS9m2HmME6RA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f6sMZv8Zim7pN+EYMC6kRQL8+FY19TbA0Rqdkbv+qhcWIFNbDL1tL7W2esDj/gWXcV2b4F7JQVheFCbllKfpBqG+YsfC7ctTCeo632rzi8TPRmPxSC6kjfav4vS5kdhOzPGlfGu/DoEx86BTAEwZXsxaW+i9WATlD3YD2sBhCxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=XpALCWIe; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fZDQPBI+; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="XpALCWIe";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fZDQPBI+"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id D3C32EC0265;
	Thu,  6 Nov 2025 06:58:07 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Thu, 06 Nov 2025 06:58:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1762430287; x=1762516687; bh=eB8so14Thi
	CiX+t2G4yO0vSQMfvPXfOhFK1uqBO2zCw=; b=XpALCWIecgKVkIC94fQHrYLREy
	r8yf5S+nH7fCOvr+l6D/s/SHsMx27PwfKCf77ZcDy0eiARnCSmzjQOa8WZoYvyIq
	BX4NIleM1M35AqIKzr+Dt16zDKzCh2PVofSF/MYTwHY0DDNH9K6igc7XvZju5qDV
	Ps/B8E7a2oGGGD8mCqXmRCpA4oGtaEYQUNM1xMTbrJ/EmbUOIQd/cjO1kY5/ghDB
	m72/xLBy2zxIcEn1lngY/eOWctU4J/iPJQfbY4Ku5z0qjeG8buvW4bqG0Y5+Gtvm
	lQqnDmsIppRMenfRTo6iVLwUKgj2PS33CHDsiVI5Hl3DqiWaQxP8T1slmSlQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1762430287; x=1762516687; bh=eB8so14ThiCiX+t2G4yO0vSQMfvPXfOhFK1
	uqBO2zCw=; b=fZDQPBI+K0As6ARrCq1XAtYXpdMt+tuD0h6DjqCbY6FglcGOMWA
	XkwCKlE68pMbUnU76VsZz8zvEh5R7e/R0j6RFdNw230yARRnbp9lZuZ4Wzjm+hRK
	gjpZrcDJaCdpkrvI7Q+CJBIdAyrn+XryPZihYKiWmKhn7bHto7VtuxRBrM7qBDPE
	v2uLxp3NkIz0s9rAqkcXaKIx7XnSKN3aza42JGT3Vux0VNWLS5kKjSgTfKjRR+5t
	LyNyUDOXmEw2szF4FQUV2ZkBREVd0z+0VWms4T6I5TeNjmnEnu8b6MnECM5et7i/
	mr/RWrpl0TRPCJdZCIeiPeLgrCINUDOJnGw==
X-ME-Sender: <xms:T40MaZUm7vXsxdkBsexYEhKY1Palx8MFMLhuvQdc3qgWJ1qvlHpTqg>
    <xme:T40MaQkMm9eMOuJYKVPJPSD8hfrqkAX-pJV6MMPS_18l7dLjA4pGKPxxgn3YUi2PC
    d0XpM0KLjkTOT7cZW4L2v1stSRsXvir2p9niQ2qICp711qy566GoUw>
X-ME-Received: <xmr:T40MaaZDCm5-vaIWzrLAkUyeOiRTNzMbufhK4V72GN15s_Pgr0phnphvR9tIjx0YUpZuNsz78wOl6c6Dxgl-5z7JTW_rM4dUgQ8kj7k8D2x_>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddukeeijedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtse
    hvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgr
    ihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:T40MabP_TT3kREd2Suuc5g_fzxQbpW1xzDSGRzgkPECtKILC0GNShg>
    <xmx:T40MafbmNc55uF9VgYrtH_H8KC1KZ2Ut1fkCJSZ95Sly7tH_wE4QBg>
    <xmx:T40MaZ2o0sdI5RcmcwMHv3_sxXHRfMqNfQlMRi4baGiC4DVSTIG2TA>
    <xmx:T40MaVfs1Xa15kpCVC_RykEHL7mJpBqiT-FiwVUDE9u9FGv9q-udQg>
    <xmx:T40MaT2ro8dIKHwSnnjPDoXnxumptEhJsKqnmLEUWpldzgh9Gr8yTrq7>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Nov 2025 06:58:06 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id d05cd387 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 6 Nov 2025 11:58:04 +0000 (UTC)
Date: Thu, 6 Nov 2025 12:58:00 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, jltobler@gmail.com, gitster@pobox.com
Subject: Re: [PATCH v3 4/5] maintenance: add checking logic in
 `pack_refs_condition()`
Message-ID: <aQyNSOdPWAxm15U3@pks.im>
References: <20251106-562-add-sub-command-to-check-if-maintenance-is-needed-v3-0-d611a2a95cf5@gmail.com>
 <20251106-562-add-sub-command-to-check-if-maintenance-is-needed-v3-4-d611a2a95cf5@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251106-562-add-sub-command-to-check-if-maintenance-is-needed-v3-4-d611a2a95cf5@gmail.com>

On Thu, Nov 06, 2025 at 09:22:33AM +0100, Karthik Nayak wrote:
> diff --git a/builtin/gc.c b/builtin/gc.c
> index c6d62c74a7..c3e7a84ec2 100644
> --- a/builtin/gc.c
> +++ b/builtin/gc.c
> @@ -285,12 +286,26 @@ static void maintenance_run_opts_release(struct maintenance_run_opts *opts)
>  
>  static int pack_refs_condition(UNUSED struct gc_config *cfg)
>  {
> -	/*
> -	 * The auto-repacking logic for refs is handled by the ref backends and
> -	 * exposed via `git pack-refs --auto`. We thus always return truish
> -	 * here and let the backend decide for us.
> -	 */
> -	return 1;
> +	struct string_list included_refs = STRING_LIST_INIT_NODUP;
> +	struct ref_exclusions excludes = REF_EXCLUSIONS_INIT;
> +	struct refs_optimize_opts optimize_opts = {
> +		.exclusions = &excludes,
> +		.includes = &included_refs,
> +		.flags = REFS_OPTIMIZE_PRUNE | REFS_OPTIMIZE_AUTO,
> +	};
> +	bool required;
> +
> +	/* Check for all refs, similar to 'git refs optimize --all'. */
> +	string_list_append(optimize_opts.includes, "*");
> +
> +	if (refs_optimize_required(get_main_ref_store(the_repository),
> +				   &optimize_opts, &required))
> +		return 0;
> +
> +	clear_ref_exclusions(&excludes);
> +	string_list_clear(&included_refs, 0);
> +
> +	return required == true;

Tiny nit: I think in our codebase this can be written in a more
idiomatic way by saying `!!required`.

Other than that I don't have anything more to add to this series.
Thanks!

Patrick
