Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F38513CFA5
	for <git@vger.kernel.org>; Wed, 27 Nov 2024 05:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732686309; cv=none; b=YW+77vXyGxOhioPG5GqtFnlY02BNqu22uAOHw4sBx7hJj8XDjIK+iBGIzCOI6KAU2d9U4w3WeFM+Y9AyXLe8PupNa/IpjF3XSifI70MJAphrzAP3kpibo1kBni/9MP4Zek6jCkM5gyNqO1CKQIVAu9FiGaVJfxvjO12HWtOFiJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732686309; c=relaxed/simple;
	bh=SqNBS0wbAEfTq6nP+N5z+9vH2e9UVTfPYrPWRp4rL3o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bPKNDOIJcU2lfSY15axowaglNnvHV0HIJ5744zJ3KtzaHfqm1CKvwZO3s2bS5bqd34HKnHQ4aCusK1oK+tlcc79dz5ypaLrelBwWMiQ6ORTCZl6vWjxsnCvxO7z2KpcZUhkzRkUHjOzn0wp+QJ5FIrCU/j8erZCg4nScLdwxkho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=FdzlxZAG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=swCezPht; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="FdzlxZAG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="swCezPht"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id F09F613802C1;
	Wed, 27 Nov 2024 00:45:03 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Wed, 27 Nov 2024 00:45:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1732686303; x=1732772703; bh=9QYnhpUlDP
	5HKLU/mefrSeGO8SIUgdTkZ0AWN82wWMo=; b=FdzlxZAGMKwZXSTCu1AvkhqZN7
	EFv+JfGpT6O8CiytsuXpkxTp9MkxmRvaSgiiDvbYOTxuCLHolM4bUr0jRbG8CLxA
	MvGchaHYNHm4pFzfiRIRIVY3aHbCJ43gzSvIoIkJ9NufYwVyClZQqFxTuVzgDy8I
	Zmtmoz4/xQw/WV9dueV5t0k5ipJdEjbK7VOmDjIxuSdAe+1jM+UNvxu/xi9mx8sT
	S55UQVppTj5zsbXqiCDpOJ9IFvcEbwzpwRKr/Gb5jtVLfL1rDnB3O514R79ZDSim
	qJk98lz7MY6RD3BWtPBN11LkYKIVQQli2hvNWgf28aj8zSuv2xrK+U3GWM0g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1732686303; x=1732772703; bh=9QYnhpUlDP5HKLU/mefrSeGO8SIUgdTkZ0A
	WN82wWMo=; b=swCezPhtHebn8/3ip65NTiP34gSVnNZQ0/c1g3l21S7mWFfgZBU
	EUNEOEQx5YzoK3Bg94V/zOLz6/gxzYeCV1KEtKAMTH+/yiJpqWfGN7Q5vXK/d3ax
	H1zTaJApkbIhanP2kyyF65bbFlHJPs2VNeOQPptlwvNnGgVnRBtmAgs1D2hA8iAo
	jSHBI+U4aTVyHt1gi/6AN9o+rJe9dTStCOm41rKTIhUQMMSZfk64SmlOQRj+z4WU
	bBQIdZTHd7XKe0hM0RJEhV3ZgvbX0LDOns4a6tF35jlHV6F0NinjPCpK6k8qiZ2Z
	ItpAp/t6YsVW5ZZVKYV+vWGB2GXay3N84WQ==
X-ME-Sender: <xms:37FGZx06oTPjncv7M0Ix8hdLYL-gFgmW4A1ir0-Yb2uD8V0QpKRxHg>
    <xme:37FGZ4HojdY4fJdNCXy7AgiR9wouztq1NQIYhIq2glm7Oj1v6dnRfYJLMPxPuxER_
    ANxPrg4R1LDDIijFQ>
X-ME-Received: <xmr:37FGZx49nAUWqYcEVbdpQ53-Use-_ujVREPfNFpZo4NNvRYxVAu0Ny9qOIPCoRCd7MwnW_Ric33UrSAcYXQlDoPfps--rtB43yoAeNtmXRTuL28>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrgeekgdekiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecu
    hfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqe
    enucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeugedu
    gffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedvpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:37FGZ-1l-mK3wcXVc0Q39vqUQ_xHWh6qxt1kbwkENjVZ3vIAB28srg>
    <xmx:37FGZ0EY8NTOVOzqNvJmnj3XflQZe4tu-KjvcdjgeOgCLo6WgCuTvg>
    <xmx:37FGZ_9V15rxMjQGuOgS250RMwShrOpOQe8INQAXfdFSPr_Y2QA8uA>
    <xmx:37FGZxlJpEBPok4WguutaNuKDBnzaRmxXQ9uh-fJOfm31IGBi6UVkQ>
    <xmx:37FGZ5SMMy-yUU8LPajCNaxhO09CsZejcCkZdBocXBwLAGX-rijmeUGf>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 27 Nov 2024 00:45:03 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 215b2267 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 27 Nov 2024 05:43:56 +0000 (UTC)
Date: Wed, 27 Nov 2024 06:44:47 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2 2/4] bundle: support fsck message configuration
Message-ID: <Z0axyWrT8n8reQWl@pks.im>
References: <20241121204119.1440773-1-jltobler@gmail.com>
 <20241127005707.319881-1-jltobler@gmail.com>
 <20241127005707.319881-3-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241127005707.319881-3-jltobler@gmail.com>

On Tue, Nov 26, 2024 at 06:57:05PM -0600, Justin Tobler wrote:
> diff --git a/bundle.c b/bundle.c
> index 485033ea3f..4e53ddfca2 100644
> --- a/bundle.c
> +++ b/bundle.c
> @@ -631,12 +631,12 @@ int unbundle(struct repository *r, struct bundle_header *header,
>  	     struct unbundle_opts *opts)
>  {
>  	struct child_process ip = CHILD_PROCESS_INIT;
> -	enum verify_bundle_flags flags = 0;
> +	struct unbundle_opts opts_fallback = { 0 };
>  
> -	if (opts)
> -		flags = opts->flags;
> +	if (!opts)
> +		opts = &opts_fallback;

Tiny nit: you could've introduced the fallback in the first commit
already. Like this you first introduce the code pattern and then change
it immediately in the subsequent commit.

Not worth a reroll though.

> diff --git a/bundle.h b/bundle.h
> index 6a09cc7bfb..df17326b09 100644
> --- a/bundle.h
> +++ b/bundle.h
> @@ -41,6 +41,13 @@ int verify_bundle(struct repository *r, struct bundle_header *header,
>  
>  struct unbundle_opts {
>  	enum verify_bundle_flags flags;
> +	/**

Nit: s|/**/|/*|

Again, not worth a reroll from my point of view, also with the recent
discussion at <877c8yti5n.fsf@iotcl.com> in mind where we basically went
"We don't care about them".

Patrick
