Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7780E396B8A
	for <git@vger.kernel.org>; Wed, 14 Jan 2026 10:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768388334; cv=none; b=AjlOqXOxtOUHU5Wyp5zgvPtQCzwSq9a7sWtIijdIsEa/uL9uInM8t38wYEK7XRN2weeCSR077AZD/txoAoS6pdsLQws0fAYBz9WSknHSWTDlrMnrOArr1bUiMzxK+BQOqo1ae2L08PlXjKAnqRggGUqmGM+7W7nM4DYMrupYJOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768388334; c=relaxed/simple;
	bh=mQOgggIb+q3uyp00gMWASA1AKYdQgOCK9BWl9UxA7Dw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rl8Qkk2xLCTH6vF0YMcnImmMp4hpxlI8mgUJORevswKtbBrcKXj+2Ld9EP8/7IGXFg0Y7IHcO+o8SawEudQaRRrH7BnhYAS9Gc0izM/+AIcZmzVTmJdMfsJNkGL/VdjBPneUSjOj3HQB0PKxHEgjfJAXhuGWupayLo8N1fw69Rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=STWATY9Y; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CRAzYMN3; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="STWATY9Y";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CRAzYMN3"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id A3E36140005A;
	Wed, 14 Jan 2026 05:56:19 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Wed, 14 Jan 2026 05:56:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1768388179; x=1768474579; bh=iMbWpZcp6F
	5aGPSNtmYaC8l0LRFFv/JSqplGWhTxjZI=; b=STWATY9YAX6vO2nt+0BFYAhnNt
	Ffio943Cf1hsEGe4qQmGnwg5aBJWXi9aNulY+5pWo2ogQddiCgk4uDMpycav/5qY
	/0COrsyk/duGFHGfsgU1agGJWrE8AYlMOkuYPSjozSeR9sC5vBrYSrVmW69ptpLt
	fPkZu+NeMtG9hbXwJUGOWKhHDlOX3Rf/WykAcg5CdgsD7Z3IIJwK0UIwsMTIfwZK
	2VE/VsmgCErgK5xjyzAG4QlcZx7On8e+Of+8JvXKyMa0TvyCDHpkM/wK9mBt4JkR
	ng7IeCaznP+Gw8wCruTbYik7P/kOO+Onw4/TX4a05NDDkYYSaJnnxxWyocxA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1768388179; x=1768474579; bh=iMbWpZcp6F5aGPSNtmYaC8l0LRFFv/JSqpl
	GWhTxjZI=; b=CRAzYMN38JMKzPLHeS9hPwq1a6neElPcBC1ti0jxGDbcQTbn+5E
	ZqQzuRrnVCkVHOoQHtkbRaz/lFkA93og2V8Tas+LREPnQY1ZW9z0rrdIQs86j0FT
	dx/9mAl7aKp6sggEdfzcMhIND5FcNAkuOEPor+Z0aYfTxrGHeuWwc7M3KhAJNgro
	Ut/IodEELsElX3Kv6phBnJ43rMZBz9MAYpwJtXabXnsktTik3JzLbrs1DgylX+19
	GvDpEtonvhQSnPoO0eiyuVZTU6TbT1tl9tqikzYWQbX99SiC7pJqlXiJGD78rdUu
	U2s5iuLk+9ygsH4r840sKAbKpogmv8E5WvQ==
X-ME-Sender: <xms:U3ZnaaAaq6Ueg03SvA9eDf8fNkHjQxiMfvyBJftIJtkcdIYqshav6A>
    <xme:U3Znaai12WdQDFWiE2cxslDgDZ4A8ZhoUowR-Oh4nT6fEdR3Nw-8EWBV0EgNnEv_S
    -NvJlRpoEa7JF9_fvaEZ1h1KF6OOGMyzzRBwuLRSo69d0i8MeIG>
X-ME-Received: <xmr:U3ZnabM-ECzXjnuHQiqGl0BwZZZgPFuM4x5RKlAy1bX_M4V9ft2MVl_n29BAZmLOXZyO-NLj2i1i6UoHMO_wo47qH1R33JIuraeOzD73VyI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduvddvleelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepthhoohhnsehiohhttghlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvg
    hrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:U3ZnaT7NHYqZSJD44hWcGBLSxFl0rDYbHV4aWDwrhgVF_IIJn_Rnpg>
    <xmx:U3ZnaR2VBHhlK-F6iVUD31fPqSTT5e-ORoieWrS13voVrbc0WVZYvQ>
    <xmx:U3ZnacZ2P3KdPBHIDdxn2zn4O40s9nhB_0BdbYjGaahWeBW3Dl0HIQ>
    <xmx:U3ZnaRAp2LdkYGSg7FrcRcPoBeT_9wexL35TwqOxyzwJqhSgkQGiew>
    <xmx:U3Znadb4wWUT8qGaLXR24IyZJGLs5TFda4xliEnaX94cxIl0MfNjt8SN>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 14 Jan 2026 05:56:18 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 5cfb33a1 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 14 Jan 2026 10:56:18 +0000 (UTC)
Date: Wed, 14 Jan 2026 11:56:15 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Toon Claes <toon@iotcl.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2 2/3] last-modified: remove double error message
Message-ID: <aWd2T2mJSvE3XCZN@pks.im>
References: <20260114-toon-last-modified-tree-v2-0-ba3b1860898f@iotcl.com>
 <20260114-toon-last-modified-tree-v2-2-ba3b1860898f@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260114-toon-last-modified-tree-v2-2-ba3b1860898f@iotcl.com>

On Wed, Jan 14, 2026 at 11:24:46AM +0100, Toon Claes wrote:
> diff --git a/builtin/last-modified.c b/builtin/last-modified.c
> index 06e3f79aec..0df85be318 100644
> --- a/builtin/last-modified.c
> +++ b/builtin/last-modified.c
> @@ -495,7 +495,7 @@ static int last_modified_init(struct last_modified *lm, struct repository *r,
>  	lm->rev.bloom_filter_settings = get_bloom_filter_settings(lm->rev.repo);
>  
>  	if (populate_paths_from_revs(lm) < 0)
> -		return error(_("unable to setup last-modified"));
> +		return -1;

Makes sense. There's only one error condition in the function, and that
error condition already prints an error message.

Patrick
