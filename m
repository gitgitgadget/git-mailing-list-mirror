Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A9F82EA468
	for <git@vger.kernel.org>; Tue,  3 Mar 2026 13:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772545353; cv=none; b=dx++3/E7E/xourKEyApbOHFlLo1N8E46Z4ObUehca+x7iAl1twtmui8C7rWn/vTYUAyq0YJWktAq/CJbv1yCHELD+aCuCxv2l4AG1E9od9rHaoylvculAlHI1WIsYgPlT+S+ucPgEr0ZOEsEtqGQOzBVHJjNU+4uJI+wlqftUBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772545353; c=relaxed/simple;
	bh=Qfj9yDReG1N1DtK5R/NHDVkYcZPmsirLAvFIttc6VJo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JYtzI8t549CYCBT8J36QCV6tVECgiHTfnR54kSGUMy6awlCiXO7xJ4yDHsTiz8Qt95YfKqMblNFRECfAzWB6BAvJJgnGQmanwkFoeQImctEXav5LoVWeVR3XL+YgYbxusPbIX7Ck76qF2ZvstGdrnU/KmEOpDkbJeOBW7DKlR3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=FIotHqwn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=5jx5uc2Q; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="FIotHqwn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="5jx5uc2Q"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id DC8A6EC026F;
	Tue,  3 Mar 2026 08:42:31 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Tue, 03 Mar 2026 08:42:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1772545351; x=1772631751; bh=FxC+MDIibP
	U3c9Mvc/fC3TlGadFIW4tB/4AcebJ60gM=; b=FIotHqwnlaGtPbZwdlPF7akOPH
	3gGtHnspN44NmZ/YGDLR9pT+2QzzZVXo211KLfTj31fZcok11he1th0+P66nDlbG
	6u+eHSgzbIksUm6En/DOs+fVigamA3pnlHxbcHHnKGIhGy/TvXIrACUx2qcjbFfV
	lmGSqKY/rGRJChmrNs0pagHlU4RE0yuYcz+F05jKSF6ouMYpjTGsGUj5aKG8WkCn
	FugVE8lvHC5umyuNLn6/isLRKfp2p0kB/982GhtzP8J5SUNmTPy1Ao/6m/iw2hdS
	b6IdlWPUQNDOvGHxAzQ7dmyet4TR8DS10QtmpzeX2a8as1w3S+LPzM/Jaxlw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1772545351; x=1772631751; bh=FxC+MDIibPU3c9Mvc/fC3TlGadFIW4tB/4A
	cebJ60gM=; b=5jx5uc2QDipfAvQldvaacxcrNmJR/AElzCNMhOVJIxWqOP2q/Ek
	JayAobMluf94sLmBUx+vbYgk0+pOvGDdNWTj7OWFgW1V98/fsjaW23Y7m7ZOxfWf
	g/U9jaK/tuP6z58dTZxMnhs1OAKyCM20Qoin7KYyCVANRNBPag0MNmYGBurYqQYM
	9aIvdW1ZOfFI5Uuo27PPTF41kh9KXyhyrWGTckxY8P89ye/9Dykd1iztK2XesW5R
	qTEA0MBUJixhoz7fdk+rjLR7lMuRCvY4X6tZuXzdfCxHO5cLZ82Y5wpnbXUtMaOV
	6M1H+dngXZndMSCVOiEPXa0FBh0tOOLMibw==
X-ME-Sender: <xms:R-WmafZkecdHJpCfYnNGe6dZ0eUDJ5mivj5pXaIp7kOp7aPSONGwuQ>
    <xme:R-WmaUagwD6Y4fZ8k3kqzUAfsIxmyU7K6gp-XVZchPUKPd-kIylKBilltAq1BacPz
    9cN7XKBxWqK040BoPxoJk3idwbZtwxiMvEJqqXynGpY3rteMc-nqA>
X-ME-Received: <xmr:R-WmafkX1HBkefDTZMhg6n9Mr3MVYXWqwz84pam7WYBKHm-Gr9DAXElRFb3JU59RAWdmq81PfrQgrdDwias0tPIwclzbRQWCejg7wymFFhgk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddviedtjeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehjrgihrghthh
    gvvghrthhhkhhulhhkrghrnhhivddttdehsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:R-WmaQw0PsdxOx0g5gknjFoMbJZ23Xm5TZA381RMiplPVsbs34ovxA>
    <xmx:R-WmadNuFQV9HUq5HsnZ6WaVW3jum_s-Nktf7wC2yK41G4ynmXbIRQ>
    <xmx:R-WmaUStzS0-vkUEcbQulFxikmu63ggWfDzg-rmpNiFS8S1hvClHHg>
    <xmx:R-WmabaQgtiMraO0V0-xUszhkquHVZAytbP9PpFSMu2txIBTbE7swA>
    <xmx:R-WmaVI_iyeeLhkYPjQdJgxtvM2s2jjqA4Vb55cO6yhSfFoks9DXWdF3>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Mar 2026 08:42:31 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id ac14fc19 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 3 Mar 2026 13:42:30 +0000 (UTC)
Date: Tue, 3 Mar 2026 14:42:28 +0100
From: Patrick Steinhardt <ps@pks.im>
To: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 3/3] path: remove redundant function calls
Message-ID: <aablRKlhQZUTct56@pks.im>
References: <20260302142138.712273-1-jayatheerthkulkarni2005@gmail.com>
 <20260302142138.712273-4-jayatheerthkulkarni2005@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260302142138.712273-4-jayatheerthkulkarni2005@gmail.com>

On Mon, Mar 02, 2026 at 07:51:38PM +0530, K Jayatheerth wrote:
> We fetch the exact same setting up to four times.
> We fix this by evaluating it once, storing it in a local variable,

Micronit: we typically write this as if instructing the code itself to
change. So this would rather be something like "Fix this by storing it
in a local variable.".

> and referencing that variable.
> 
> Signed-off-by: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
> ---
>  path.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/path.c b/path.c
> index 56be5e1726..5cd38b2a16 100644
> --- a/path.c
> +++ b/path.c
> @@ -741,18 +741,18 @@ int calc_shared_perm(struct repository *repo,
>  		     int mode)
>  {
>  	int tweak;
> -
> -	if (repo_settings_get_shared_repository(repo) < 0)
> -		tweak = -repo_settings_get_shared_repository(repo);
> +	int shared_repo = repo_settings_get_shared_repository(repo);
> +	if (shared_repo < 0)
> +		tweak = -shared_repo;
>  	else
> -		tweak = repo_settings_get_shared_repository(repo);
> +		tweak = shared_repo;
>  
>  	if (!(mode & S_IWUSR))
>  		tweak &= ~0222;
>  	if (mode & S_IXUSR)
>  		/* Copy read bits to execute bits */
>  		tweak |= (tweak & 0444) >> 2;
> -	if (repo_settings_get_shared_repository(repo) < 0)
> +	if (shared_repo < 0)
>  		mode = (mode & ~0777) | tweak;
>  	else
>  		mode |= tweak;

I agree with the fix itself though. Probably doesn't matter much as we
simply retrieve a value from the repo settings, but this also removes
some mental overhead in my mind.

Thanks!

Patrick
