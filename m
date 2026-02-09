Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6544F33B6D9
	for <git@vger.kernel.org>; Mon,  9 Feb 2026 09:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770630516; cv=none; b=IMeUIuYIrekhiPNPymaj5FpC+P7Bw0suPpL88CuN4P4iwAVEPS3VC6s2Fq54twY6Vtr0OcXFH2mjbBSvf+Do0aPlgOyF3B9eYOIziVmEqN0Mj+hS4xtDZhGrLTX8UpPeSkgwnQKhUwf5syQJOE4kn6Wh0SnbyX1HD9LWa97bSyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770630516; c=relaxed/simple;
	bh=3oaNLRAVRmsxgL9db6JP/fC3rLCF1yA6dOO/ckqD9C0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IqUXWqRyQGzDBuQLi7ege6dWHMB6IPI0QuPeMVAJTfNDiwql1K2Eq0GHINSmPIURILpUZtDuNQuHQEGfUrC1qFyhUIFI2LD+llR41HRp6xfCaPgHZxecs2lEEJ9eCYWif1j8hVgzWNmS9eFQiswquVv27iVkC60TDvQns6GW99I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=BDSHaPti; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FvT7W7kD; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="BDSHaPti";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FvT7W7kD"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id A8FC17A004F;
	Mon,  9 Feb 2026 04:48:35 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Mon, 09 Feb 2026 04:48:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1770630515;
	 x=1770716915; bh=DESzkOXPnA1Cstb7nr04WUrKbcfURQ5757vSHsaXWus=; b=
	BDSHaPtivzh3qF/obDLsA9VY0G31YDdAWllTKj9+PR+QSoVLcruuJaxxWZo8plEt
	kTySW8xb4Kgh1amJrqEPPSW7LUjf7RDDJOZd5iyBV3cDbSsyHTiaJKnbG/AdMQzI
	W+qJpIxbFBuEBbLPHgmJXPCCWOIiBz/5t2AG03DKsJ2Na9q6O1tNZy2nuQkEgmEt
	LXIZMkq9qrdhi9CI6GwqSjNt5N+rBDA4a/6imnPHdfsOXM4vDfYW4r2pQjZg22Lm
	Pe4C+As+zVplRPIgYKYcRHvUIc1ZnkW+IRJAu9QlgKhzfVEWNq8Jjxj5TttQvMbS
	mCc1H/E8eReVuFsm3uKVCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1770630515; x=
	1770716915; bh=DESzkOXPnA1Cstb7nr04WUrKbcfURQ5757vSHsaXWus=; b=F
	vT7W7kDZQfd6JZeAP+NC5jAmLdHcI7Bp4NgTbMJ6gx/RWPqnVVBnsAtxjCiqju9T
	TfNx5UicoeNEA/6HzLkF8g68KbFAEl1bjxpuLqBHnYiQD7j6cpN4rLYx25h7GCtq
	bcxtSmq74Chp28CCCfHzjzpYNe/JjSbpV1pGzwua9Z77s8FAhn/W1lgWYAqJy0rq
	CZqTiwD4CCe3DKJyzeaeKyM/o2youLg4f1YKJdoRwnY0otoIwXzSdVY7wKnKjYK1
	/MfSfgU4zsGRtx23ssylahan0kzrnDkZ7eKHUeeCNLYdPm+dhOiFrvksfJtCzXMw
	byJ3vcuP70N/VkQNudfSQ==
X-ME-Sender: <xms:c62JaaFysjPQDqOVkbxcjo8eZu3hPfQBIRbA-vR3wZAgrQj1IXeFMw>
    <xme:c62JaRUU93gY9_3ilZNbtKTWecXAbXDWME0mk5IpjBkLN_aDThJxnixuwVoUC9PfS
    MaTLmsY07HQSGKRKNTqT61jvWjl-U3J4irwWIyV_VZHG8vjAjQsl_Y>
X-ME-Received: <xmr:c62JaRxh42r2-MvgoFcKZwZUq2LQiV1QGbfeBhr12WWaXImJyh8cpvmYK6p-fLoqAY7whI6jGlqKyP9_ipeU3HbQ8OaeZoyGog3V3SyiDkM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduleeigeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtugfgjgesthekre
    dttddtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepvdefjeeitdetleehieetkeevfedtfedvhe
    ekvdevteffvdevveejjeelgeetvdfgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepvddpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopehlrdhsrdhrseifvggsrdguvg
X-ME-Proxy: <xmx:c62JafPJucEk1Ri-736UCZcNQ9nEnvQQIldwP0isOlE_Xa3MYd0KIQ>
    <xmx:c62JaS7MVTfqfbYjxoPN1ZkI6gGimYvwtHidljLvkzMqTsFpU0JerA>
    <xmx:c62JaQMv-WCg1EFHQShM_rITG_z4BTIqcNWBHYubrdAJqXD_dn3kdA>
    <xmx:c62JaQlprvaVTWriMevLc_VGkI7n1RheaW2XNfH2jVJo_sdM3HtXkw>
    <xmx:c62JaVdlQs2-_jeAfhkV1v-2bkoFVMA_Z7zcP7yVqnV7tHb3z41DDl5H>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 9 Feb 2026 04:48:34 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id a104c293 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 9 Feb 2026 09:48:32 +0000 (UTC)
Date: Mon, 9 Feb 2026 10:48:25 +0100
From: Patrick Steinhardt <ps@pks.im>
To: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc: Git List <git@vger.kernel.org>
Subject: Re: [PATCH] xdiff-interface: stop using the_repository
Message-ID: <aYmtab_uqMZBygAG@pks.im>
References: <f58fa33d-b015-4339-819a-9d91be60cd0c@web.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f58fa33d-b015-4339-819a-9d91be60cd0c@web.de>

On Sun, Feb 08, 2026 at 02:47:40PM +0100, René Scharfe wrote:
> diff --git a/xdiff-interface.c b/xdiff-interface.c
> index 1a35556380..cd7493730b 100644
> --- a/xdiff-interface.c
> +++ b/xdiff-interface.c
> @@ -7,6 +6,7 @@
>  #include "config.h"
>  #include "hex.h"
>  #include "odb.h"
> +#include "repository.h"
>  #include "strbuf.h"
>  #include "xdiff-interface.h"
>  #include "xdiff/xtypes.h"

It's a bit surprising that we have to add this include, but I assume
that we use a function that's declared in this file?

> @@ -177,18 +177,19 @@ int read_mmfile(mmfile_t *ptr, const char *filename)
>  	return 0;
>  }
>  
> -void read_mmblob(mmfile_t *ptr, const struct object_id *oid)
> +void read_mmblob(mmfile_t *ptr, struct object_database *odb,
> +		 const struct object_id *oid)
>  {
>  	unsigned long size;
>  	enum object_type type;
>  
> -	if (oideq(oid, null_oid(the_hash_algo))) {
> +	if (is_null_oid(oid)) {
>  		ptr->ptr = xstrdup("");
>  		ptr->size = 0;
>  		return;
>  	}

Arguably the commit coudl've been split up into three:

  1. The change to `is_null_oid()`.

  2. Adding the ODB to the parameter.

  3. Removing the macro and adding the include.

So that each of those could have a bit more explanation. But I guess the
changes are smallish enough so that this borders on okay-ish, so I won't
insist on such a change.

Other than that this patch looks good to me, thanks!

Patrick
