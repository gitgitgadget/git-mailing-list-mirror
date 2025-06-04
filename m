Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA2AA242917
	for <git@vger.kernel.org>; Wed,  4 Jun 2025 07:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749023931; cv=none; b=ZQ/RlJP6ptXxf/EAXYxYax4lc5PyxrI3YKwA6Lpyen5B6VGJiR2kfl0ajdf4UCjU+py4BxZ8TCNQIICRQvRwnacac24d7onvV7IIXCwAWx9rlmMph6nN53VAGrEhUvdGl80cc1jEEWe+EwLE2A9CXHglAmobfbjeeqTu50REgs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749023931; c=relaxed/simple;
	bh=/gqdoRcoACnyd86OKR2YX8snTizFQ9pAbWUFBlMwyus=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V+kVXA8rf4HymS7+4/WQPsTGixKx4F6KJlKX+aUe6ionIVWUao8xfHhmGW+HWnRVsk/WsBg8NSCYhNO2KyUjBxuyWyHDICOjNiAftEYGYm/43S0jMEI9iWdX9bkRsA8JGopx5Zm97W8dIQTvHEjhYMkAXOI1RdKDCckSg17S52U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ohi1s7lw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AX3jrazS; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ohi1s7lw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AX3jrazS"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id B789611401A6;
	Wed,  4 Jun 2025 03:58:48 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Wed, 04 Jun 2025 03:58:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1749023928; x=1749110328; bh=3a7lSIw2lh
	VueIlJogAwok+37ZsE6UMpJrHyXzh88+M=; b=ohi1s7lweZRenes0CYJC5iUrVp
	SkNQM4s4WGNokHLi4Kg3/yiYMfWLuBnuUKvNQYSYEn8IDesDfVNJ1msbkWxbO+uQ
	2eynFF1eVWzeNoPn4NanoNXTaslIbTPLhRdEYdLayvVKuHiTdYOSTYVHUVlNRAXS
	AXAprK7I6eKgPiZVdIZFmrfdSDdGY2AklH1owd8wfsg4GII3K0pt1BQrpnxqb61X
	+NK3QpQx0D8IqYS07xlQdc/2NuLmn+oYiE+d4GoPDV1jFO0yXTyGr6p/ZXm/miU1
	VMuv8CfuBznD/i1DH+Nt6eRrdCSE8JNY9A+EuaHIyTdWpROK1Fi0VSW4aFoQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1749023928; x=1749110328; bh=3a7lSIw2lhVueIlJogAwok+37ZsE6UMpJrH
	yXzh88+M=; b=AX3jrazSJOmLk8CFN+EU1yS5t7oHLXK5BQCZwrXF4tfqnJo5+fH
	p11t+Q/h7Jxx8L/sVZ95KHIR076/3+7X4OjFEZsLwVPIvAzGjpde8mMy5gfprMOR
	fwjgrDARh4gfskVfmpcvfPLHo8xCDHJrJLAwC1yceUkCWn3SVe84Mfv8ReTcVU0o
	mVbGFBwGk0JelAx2DtyTq3b4QVwa4KbZhwsyTN+WKIqlO2TMpzRADUGdYg4qOdfY
	ly9Z+TaWoEM1yJGMTWmpqkX8ijpPdm3Ag/ZJrhNTKMobXMWZSR3xofkkYxgD2wFq
	59XvVUGHxbUYGkUfkDTVFVB8/bVFGbL0PxQ==
X-ME-Sender: <xms:uPw_aL1-S8Ku1wo3n93n-T9la_qYu0aJkzMhx9204QWiwlEb137qWg>
    <xme:uPw_aKHgNJLCeKlMu9tJX1HwUlJA8oFPm8gqWLTX8s4OPNX4Ht5Dr8FnyRbMPYtXI
    4Wx0ZhOpCIQoLTyBQ>
X-ME-Received: <xmr:uPw_aL6iIGygqCCYl1OpKY-xYsK1fpZK7eMfZ-tC4WZijByHhFEyzgUF67SnZIUmvIcA6CNRFt4q4Qn3y2nxgOvtfS7efJuNZb2RzCSl7bg4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugddukedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthho
    peehtddvtddvgeeffedttdehieesshhmrghilhdrnhhjuhdrvgguuhdrtghn
X-ME-Proxy: <xmx:uPw_aA1rJ2zHWVkewrtw0TBZaUymWF4VLHM9u3Adezek-5F90ESs8g>
    <xmx:uPw_aOEGNqntr2y4eU5ijtBDXt43Y5tcnGYJN7sHGhZ7LQWxE1s2uw>
    <xmx:uPw_aB-wgYwOhPPwC_HaoIRAfmnwMFLdCQepslqCdwA8Ef7rTM9Knw>
    <xmx:uPw_aLlopQjIpOdKjK8gM8A9VYgZ9-H7xQoutnc3oZu5FhIwOmDgyQ>
    <xmx:uPw_aJz_YSeZ46lFnZg3trDbv2tadi-qtELFMAzi9r6nM3VSZwNwvzNn>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 4 Jun 2025 03:58:47 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id d9091ddc (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 4 Jun 2025 07:58:46 +0000 (UTC)
Date: Wed, 4 Jun 2025 09:58:45 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Lidong Yan via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Lidong Yan <502024330056@smail.nju.edu.cn>
Subject: Re: [PATCH] builtin/fetch-pack: cleanup before return error
Message-ID: <aD_8tafSPGhtdQI0@pks.im>
References: <pull.1990.git.git.1749006474694.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pull.1990.git.git.1749006474694.gitgitgadget@gmail.com>

On Wed, Jun 04, 2025 at 03:07:54AM +0000, Lidong Yan via GitGitGadget wrote:
> diff --git a/builtin/fetch-pack.c b/builtin/fetch-pack.c
> index d07eec9e555..d9e42bad584 100644
> --- a/builtin/fetch-pack.c
> +++ b/builtin/fetch-pack.c
> @@ -274,8 +274,10 @@ int cmd_fetch_pack(int argc,
>  	}
>  	close(fd[0]);
>  	close(fd[1]);
> -	if (finish_connect(conn))
> -		return 1;
> +	if (finish_connect(conn)) {
> +		ret = 1;
> +		goto cleanup;
> +	}
>  
>  	ret = !fetched_refs;
>  
> @@ -291,6 +293,7 @@ int cmd_fetch_pack(int argc,
>  		printf("%s %s\n",
>  		       oid_to_hex(&ref->old_oid), ref->name);
>  
> +cleanup:
>  	for (size_t i = 0; i < nr_sought; i++)
>  		free_one_ref(sought_to_free[i]);
>  	free(sought_to_free);


Sensible again. My only worry is that some of the variables that get
free'd here may not have been initialized. But I went through all of
them and all of them are NULL- or zero-initialized indeed, so this looks
good to me. Thanks!

Patrick
