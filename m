Received: from fout1-smtp.messagingengine.com (fout1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCEC0156967
	for <git@vger.kernel.org>; Wed, 28 Aug 2024 08:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724833169; cv=none; b=nvQUtYWFDm4wrr1uq/47LB2n4g4SFRr7xK1eFcb/U7eQh7MrpPpqTWi6Pir/OdufjO6Rh3hqvE0OFtCVmBy1rWvuVclCyo5pGOtNvLcga/Q1sE3Vi1Vx215SFulurscnDtUAxGJAEmQN16/8ujeWZWZ/OcdnT4tXNFBwExM6FrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724833169; c=relaxed/simple;
	bh=VmTWWxVXctRtCZjoDCXt5TZ1s45j485FSPl1B/t0oi0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=elZGOk65yrNLYrwKmJlR0YtynNPuZf52QlUTKpw2I4mLPeYDJf8DLss3VeXZrhiwVzlhK0Kz5p6NnK44qGAdbYytQgLOfIO/jKxZHVlAb5Z1Bld88Fup0CFmRhNHMnox3E2/KD+nZtpTFSRx+ATVa5jomkSWqvvJdSPDA7LI1qU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=kqUvL1As; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CJQbHA3e; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="kqUvL1As";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CJQbHA3e"
Received: from phl-compute-05.internal (phl-compute-05.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id 5050613900BC;
	Wed, 28 Aug 2024 04:19:25 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Wed, 28 Aug 2024 04:19:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1724833165; x=1724919565; bh=ej7B/XtmZ9
	PZIA2Tuk+ti4B++ThsTVFH7uiA0qgTs1Y=; b=kqUvL1AsVX7qRUx87g6ypU8gWF
	k4OmROkyjpvxh2DIODJynDvpmk6zcU/hlQpdJ7O6DxMC5B090zjabyWRisWy4EC3
	daoe0khvTwI4JDOWa+1qUoi0KFwyv6C5i5HuJh1MH9wyXEVcPWcFFp30jzbwNmsU
	auxn0mvJvHyQYBLBUDmzmpRxBGYuB6KwoGwgrv1qs2K53mLAiy/UR31XAkuIV2JM
	Xq57GL9YZ+hUQQ/p35lntRi04EsEF5LJICak7eO2RtqFHZ+7ZuaiAWfozHXIkKx8
	jj044yaaPOraqVZN2JTSmF/4bsPYhZMk7BARzxi/9BE4RFNpbX77GcmlXgzg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1724833165; x=1724919565; bh=ej7B/XtmZ9PZIA2Tuk+ti4B++Ths
	TVFH7uiA0qgTs1Y=; b=CJQbHA3eQ/BJI4UqpWIwo7ypFWgvXUO1MpwkGqA4qnGK
	sKm/a0usvW5y58DaUiqruLkxOf/GrCo9kiw/gPxnUoVxJJHWHeIIePsp7s5DOFOh
	UJR1Nzl0G1ZkII2MWU7oKhzy3KrkiCDOv/6qNOxZnA2gF8oZfSlR4fsGQAtuXI+H
	2I6//XiPiVY030T9U1tJW+MyNdyNfFKRsrvhd3f4/oAzL4FYx/0FUJAP3puNdwdC
	HvzJOLH98+Pr9H8pNxVhAp7mqADl8iBa0MG2JaBIEK3wJhtC+WxUU/RvMXvjJtap
	CejUy69J+aoowYDdjkaWsFtUil38YNuw7ylMUUG/Pw==
X-ME-Sender: <xms:jd3OZt7M8rW_AhDQznSJ2-BeK_VFfNuVAq6n_-RC5D95YOeIP1Wf_Q>
    <xme:jd3OZq7KDkUZKT3OuwXJUAe9dWpvrkEI9M4Kcy4jzShuZXWs1Be7hbAq967tAU_ii
    ZZ3x_C8D47heFOwgg>
X-ME-Received: <xmr:jd3OZkf4LGXWmgIJNBPyDCQOJLm-yyOOaR_9q9Kn4RgPE9DJjSeDGtSCeHGqcKRDqgTe1tGT6CnudQjJiGh8PMRSeJVs8rFklDUbE3BA_wiKREE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudefvddgtddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvve
    fukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeevkeekfffhie
    dtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsg
    gprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpvghffhes
    phgvfhhfrdhnvghtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:jd3OZmLsjDNqzJfS6S8TTA8A6y0y0uHaUjLvP4E267rju2tel7_jYg>
    <xmx:jd3OZhJ2_LHmQw4jiYrPdcLfRDRji5hh3B0ct2dk_-BoYP0LWTmSWw>
    <xmx:jd3OZvwNEZCynZ1OPMygoVn6MeFxBSeUt7UmvCljh_yJTq5zxssvUA>
    <xmx:jd3OZtLtwIjzINMLGDDcRXzRizex7j9dN2LCrtYqNI3sFySmTJcjHQ>
    <xmx:jd3OZoVzRbrdB6v3oLhd9HO1hRAvVMJu9Uh8oS_jJeFNIyepEv9EnPg7>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 28 Aug 2024 04:19:24 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 8990f55d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 28 Aug 2024 08:19:16 +0000 (UTC)
Date: Wed, 28 Aug 2024 10:19:20 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] reftable: mark unused parameters in empty iterator
 functions
Message-ID: <Zs7diDgkP33jG5W7@tanuki>
References: <20240828040944.GA4005021@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240828040944.GA4005021@coredump.intra.peff.net>

On Wed, Aug 28, 2024 at 12:09:44AM -0400, Jeff King wrote:
> These unused parameters were marked in a68ec8683a (reftable: mark unused
> parameters in virtual functions, 2024-08-17), but the functions were
> moved to a new file in a parallel branch via f2406c81b9
> (reftable/generic: move generic iterator code into iterator interface,
> 2024-08-22).
> 
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> This should go on top of ps/reftable-drop-generic. Arguably this could
> have been done as part of the conflict resolution when merging into next
> alongside jk/mark-unused-parameters, but at this point I think a
> separate patch is the best way forward.
> 
>  reftable/iter.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/reftable/iter.c b/reftable/iter.c
> index 97a4642ed5..1d99fe4f7d 100644
> --- a/reftable/iter.c
> +++ b/reftable/iter.c
> @@ -25,17 +25,17 @@ int iterator_next(struct reftable_iterator *it, struct reftable_record *rec)
>  	return it->ops->next(it->iter_arg, rec);
>  }
>  
> -static int empty_iterator_seek(void *arg, struct reftable_record *want)
> +static int empty_iterator_seek(void *arg UNUSED, struct reftable_record *want UNUSED)
>  {
>  	return 0;
>  }
>  
> -static int empty_iterator_next(void *arg, struct reftable_record *rec)
> +static int empty_iterator_next(void *arg UNUSED, struct reftable_record *rec UNUSED)
>  {
>  	return 1;
>  }
>  
> -static void empty_iterator_close(void *arg)
> +static void empty_iterator_close(void *arg UNUSED)
>  {
>  }

These changes look obviously correct to me, thanks!

Patrick
