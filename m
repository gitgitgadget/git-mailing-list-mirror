Received: from fout7-smtp.messagingengine.com (fout7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E89A16EB7C
	for <git@vger.kernel.org>; Fri, 30 Aug 2024 09:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725008437; cv=none; b=FAOb0sqy+hJbIickxauaNN6H0e2qDMUEYAtsHmjc2EMciVILezK9s8GlHsVDkV4ADdWeVKqmE1TOauchh50/JICtOWprp50E1/+zTAWk9sWoPsT+mGsS+Zu0dVh5ewcD5Gg2cJ3TBK9Jl29F8A9r58vICGrLe2lxMGtzPElm0IE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725008437; c=relaxed/simple;
	bh=w72bzSDbwqIrgvKjnoosCrLCcvN35G0nO2bxBxu7fN8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ftYo8NpJzCY8sgNverDhvWpHGkyXwfAt67UNHE8NySYyrWCTXZUB5/ScxmA+yI+jXg+aXAAd76IheYSZ/IHP21lz/VqIxd9MjtA/qvX0xYGDPK/Fss3iyttePcFgWegIGyslCc8xA1TKkwIuNTlJesv1SUMWrOjL01qJdaQe/P8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=jhM/Kt9B; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FjYWzd6a; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="jhM/Kt9B";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FjYWzd6a"
Received: from phl-compute-03.internal (phl-compute-03.nyi.internal [10.202.2.43])
	by mailfout.nyi.internal (Postfix) with ESMTP id 84ADD138024B;
	Fri, 30 Aug 2024 05:00:34 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Fri, 30 Aug 2024 05:00:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1725008434; x=1725094834; bh=5DT8dCZ7z4
	aBGA7G3L9VPQxNl2tYGkd491Wz79p7uoU=; b=jhM/Kt9B5P9F4Zij5wvWkXENG8
	SSGGPvN8UHfg7kzQ4pfb6xfqmuzjBDl/s7dHNcdzB15LG/WrgeyzlIOWn9FO5Dl6
	0Nly4uooQgSyl0m5QWLExBoQJS4v77enzMZU/KMUYhe4JV3hCgmhJXwhvlsmzSYX
	orYMzi+NQdDeGjj4EmxbxyiecgHZLYK+j4hxvrWMafS5pwEkqikNZL+GtogXSL89
	yVpLOOwuPQfA1/0FyMv8k1wNGhsh0a9NDn0PXnjyYr9jKxSZ3pOFoW6JaryOOO/B
	u7OQzMK9E3w1odjXyy5uJOtQX/ZFxL//JFb58C8dMVvrbqv41Ts4YM7kCdaA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1725008434; x=1725094834; bh=5DT8dCZ7z4aBGA7G3L9VPQxNl2tY
	Gkd491Wz79p7uoU=; b=FjYWzd6a2aL1s+eJNp2/cJKxqpwHu2o/3CxQ4kqgdBbQ
	wKJELC2WjFSyjEHM4kICQ4rs/OdCGETqi4Ue3oRL0svTkSdlTpBnLfdig2inL7X/
	xzDfLT3JDQ1+Y8ENND5uxeS+7GL5HyOhlQqnE2ZnwtcMjDT4GyIsZ2Z9vAzrrPVQ
	NsxQyi/qrt4Bn3ifg9NK9sMEKCCHMu+GtfYgofd6/Y9/CLSK+wNJSSUqyv0utk1S
	AwAhh8iaRU3XMPa+mi6cb825geVfNVHU/Mr0xb92CabAoamc1xUU2Q+SMcV0mCXG
	JPisoVdSxpfAEgUCCu2ht2U7gmQo0GKM3gpQWfVftA==
X-ME-Sender: <xms:MorRZqS_I90bqjqvUqGe5wnhWLhbBqHqgUc5LlP4j2h6eA4bLdcREQ>
    <xme:MorRZvwMjHEiQ8yjAtvosaGBfK3Z0RQQN6aZ4lYmT3PMNb6sPn5cVDivxdcwR0deC
    7AzP04B6o0V7jdUnA>
X-ME-Received: <xmr:MorRZn1H_KPGhik5btQDQfkRXNz8JsDCR4x0v4bZSG2uZT9ZkHOfSb-VQb2qwE5Uu1thPO0gsD3rxspBbmqnNObVI13N_FB9zj3--NDecNHXm4__pw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudefiedguddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtph
    htthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepthhoohhn
    sehiohhttghlrdgtohhm
X-ME-Proxy: <xmx:MorRZmAqxAwcsLY1v6h__p6oSlUGXQhbHKwxMQGH2H1E-bDoCvhzAA>
    <xmx:MorRZjgPXDr1GL9DPadpR3v_LBAoeuRMN5lP6yAFcuKsNjgSS-MxMA>
    <xmx:MorRZipnZacLNsAdmq8jMdv15T_pYQ0r7UML8EncUH7b938SOkLIzQ>
    <xmx:MorRZmg6Mlr_ABOaVBZ1AIEKuqzbvw8sUgT4xY8S3zH6Ncr6GyXoaQ>
    <xmx:MorRZgvI33PYRPKh6N2AYwXl9i47NDZ-ohepOLWmMrCSNH3OVGcdnh4a>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 30 Aug 2024 05:00:33 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 1f595e24 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 30 Aug 2024 09:00:22 +0000 (UTC)
Date: Fri, 30 Aug 2024 11:00:31 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Toon claes <toon@iotcl.com>, git@vger.kernel.org
Subject: Re: [PATCH 14/22] shallow: fix leaking members of `struct
 shallow_info`
Message-ID: <ZtGKL1m2MVOVYwfT@tanuki>
References: <cover.1724656120.git.ps@pks.im>
 <2a63030ff09f938d705c117406b501ecf81f67de.1724656120.git.ps@pks.im>
 <87ed67jtxy.fsf@iotcl.com>
 <xmqqr0a7wbvw.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqr0a7wbvw.fsf@gitster.g>

On Thu, Aug 29, 2024 at 09:07:47AM -0700, Junio C Hamano wrote:
> Toon claes <toon@iotcl.com> writes:
> 
> >>  void clear_shallow_info(struct shallow_info *info)
> >>  {
> >> +	if (info->used_shallow) {
> >> +		for (size_t i = 0; i < info->shallow->nr; i++)
> >> +			free(info->used_shallow[i]);
> >> +		free(info->used_shallow);
> >> +	}
> >> +
> >> +	free(info->need_reachability_test);
> >> +	free(info->reachable);
> >> +	free(info->shallow_ref);
> >>  	free(info->ours);
> >>  	free(info->theirs);
> >>  }
> >
> > `prepare_shallow_info()`, which allocates new memory. So would it be
> > worth to rename this function to `release_shallow_info()`?
> 
> In the longer term in a separate "renaming everything" effort, yes.
> In the context of "plug many resource leaks" series, probably no.

Yeah, agreed. And note that `release_shallow_info()` does not match our
style guide, either: it should be `shallow_info_release()`.

Patrick
