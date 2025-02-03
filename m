Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA6AA1E98EA
	for <git@vger.kernel.org>; Mon,  3 Feb 2025 07:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738569102; cv=none; b=iXm6FPbZ9gpykLRzWGHUD1g43I7YJVcCYcEwZ62P8oK8POC3LjOFRB0PHvnUPzKIGya3vd0gs0O/UrgASg9B2AbwrgG4rWeDmzJDVaTAvlTEPsV9X0GJN108PseR2HjHRqkQu3epeW8aCRfDmE+7+cw0yS+2NUeuQuSuyaqIebc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738569102; c=relaxed/simple;
	bh=NZSGuJ2OQE1batFhuNJUwyhPCWTu5V7LTSAicosuyXE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SzeGq/L5qiPqnU+HErpOC/GyEI2Nlk+wlTJG66mns39KWJNAAirQza+k/l87qb3rVV3FPjmaNGt1anaDdPMOIv22ncC1OUKub1yDOkfhfH/hIj52QNSpyXoel/Pp1iUtHGzY0zNXE9yI0rhnf7rR0LBXPIFj7LJduSlK9s2dg0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=UMXyNO7D; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Fic948/d; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="UMXyNO7D";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Fic948/d"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id CF09311400D0;
	Mon,  3 Feb 2025 02:51:39 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Mon, 03 Feb 2025 02:51:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1738569099; x=1738655499; bh=hs8CPiGEBO
	XT3Ccg1teMfBUt4RP0rVz+1t1F06Pep1Q=; b=UMXyNO7Dkbc/1vyQMfCIcBq0aA
	7aTXY9711NuDnXQKSADi6CYTP84164LtIFY0z5gf388t3W2sT6awiCQMXbgcaIZm
	8sDS8EICgsvShJCViCEcPuUVBPMZhhij6mbYz1CBpIu6sRVxmhkFIqnhojzxiW0q
	Pjg7BriKgJotlL4SQbY92GvK2zlWUuylv8B4/jR0rTFBHQYb3LZAfABQ5m5I/n8r
	R81CH5cMatS63hFiUYLnj1ClFgJFCM2XJl1lM7O01PdqqCJIhtn/HgAyZWb5Sc4o
	HgmcQDTrapBR1wsCsF+edh5K/BHyE1SWmPjPCEx03E1CJrvrNsB+3PW9O85Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1738569099; x=1738655499; bh=hs8CPiGEBOXT3Ccg1teMfBUt4RP0rVz+1t1
	F06Pep1Q=; b=Fic948/dS0V8MzKq0Lr3hg/ONa51LNsseoqOCQn0O9NQYCgybMK
	sn/GvY1n+cdRIREX8H8Zoc96yaY2ZxV6JNzUVmXEha0y5laaccW1JmusDssROnz0
	xxtMDgMUMmZdDLeIg0+f6pcJbIgy63CH9DGizAw0wAlmCtB0ZjxcAoLzotk9A+Oi
	bKbPOUSMqF9RaLvJiYfiVMMXAchuZNLCwazgK1tYwviFAzihZqRvpKzQiivQqOv8
	6KAWKFw35vg1rrAyfl7hBaKE385vFsM+FI7P3gzNj9yTNLK3M28EOArfU+ZmQLWR
	q/soRFoeyDl8lSkuDBrr4PldrEXvOwx5kjQ==
X-ME-Sender: <xms:i3WgZ2hybgHDQfbrcmmpByYWPIAN-p8SmZ52lVJyUmGHs1_ZorDRZw>
    <xme:i3WgZ3BCpsYYBKWNUOPKhCNGg4e_BuKM3czLCMfOiYfzZEFekREreO5qtyJARUxsL
    bLiwirAxuDhE84g_Q>
X-ME-Received: <xmr:i3WgZ-FBG0tMNZFJqpoWog7zaTISH6NA0H87TYYDgxVgwDEFq_Y6jKj7BThSuhORRea0ZvkkAHIXa23UjeledhUVostQFMT3xDlPRX81l4uOsA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddujedtvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeu
    gedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeehpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehkrhhishhtohhffhgvrhhhrghughhssggrkhhkse
    hfrghsthhmrghilhdrtghomhdprhgtphhtthhopehmshhutghhrghnvghksehsuhhsvgdr
    uggvpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehtohhonh
    esihhothgtlhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhg
X-ME-Proxy: <xmx:i3WgZ_SeGpbjcrMcND99gdTfefjkdsZ7NGNyzCKNSUiw1PcqyVCcaw>
    <xmx:i3WgZzyqWDFbfv9KAzbOrx0ouYh7xy65M11Rbx0PC-mOv4zRL1iiUg>
    <xmx:i3WgZ97_6CP1iMoBx6FevpCzY_SrQDQ86bphkoW7mray8jb4rTwq_w>
    <xmx:i3WgZwz3W3fTf2XJnWw_cPoDZ59_nDshTWcdHqwdjDPtUCb1DnsxSQ>
    <xmx:i3WgZ-odNntZkUijdc_1rm5l9Ka3w5YzLknAnpGV3REN0S2lPCqwH6d5>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Feb 2025 02:51:38 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 92237600 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 3 Feb 2025 07:51:38 +0000 (UTC)
Date: Mon, 3 Feb 2025 08:51:37 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Toon Claes <toon@iotcl.com>
Cc: git@vger.kernel.org,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Michal =?utf-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>,
	Jeff King <peff@peff.net>
Subject: Re: [PATCH v4 6/6] builtin/clone: teach git-clone(1) the --revision=
 option
Message-ID: <Z6B1bM7bbpNUNjpt@pks.im>
References: <20250131-toon-clone-refs-v4-0-2a4ff851498f@iotcl.com>
 <20250131-toon-clone-refs-v4-6-2a4ff851498f@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250131-toon-clone-refs-v4-6-2a4ff851498f@iotcl.com>

On Fri, Jan 31, 2025 at 04:30:34PM +0100, Toon Claes wrote:
> diff --git a/builtin/clone.c b/builtin/clone.c
> index f92017c751dd31cb25a3ba31667b015d5766ce84..40d6ecfa74608193a88715a29b4ca765687a0c86 100644
> --- a/builtin/clone.c
> +++ b/builtin/clone.c
> @@ -585,6 +586,10 @@ static void update_head(const struct ref *our, const struct ref *remote,
>  	} else if (our) {
>  		struct commit *c = lookup_commit_reference(the_repository,
>  							   &our->old_oid);
> +
> +		if (!c)
> +			die(_("couldn't look up commit object for '%s'"), our->name);

You can use `lookup_commit_or_die()` instead.

> @@ -1500,6 +1534,12 @@ int cmd_clone(int argc,
>  		if (!our_head_points_at)
>  			die(_("Remote branch %s not found in upstream %s"),
>  			    option_branch, remote_name);
> +	} else if (option_rev) {
> +		our_head_points_at = mapped_refs;
> +		if (!our_head_points_at)
> +			die(_("Remote revision %s not found in upstream %s"),
> +			    option_rev, remote_name);
> +		//mapped_refs->name[0] = 0;

This looks like a left-over debug statement?

> diff --git a/parse-options.h b/parse-options.h
> index 39f088625494f20dea96b9a9cbe986916773bf60..fca944d9a93d643d984c58de2ead9154c8b16c94 100644
> --- a/parse-options.h
> +++ b/parse-options.h
> @@ -436,6 +436,15 @@ static inline void die_for_incompatible_opt3(int opt1, const char *opt1_name,
>  				  0, "");
>  }
>  
> +static inline void die_for_incompatible_opt2(int opt1, const char *opt1_name,
> +					     int opt2, const char *opt2_name)
> +{
> +	die_for_incompatible_opt4(opt1, opt1_name,
> +				  opt2, opt2_name,
> +				  0, "",
> +				  0, "");
> +}
> +
>  /*
>   * Use these assertions for callbacks that expect to be called with NONEG and
>   * NOARG respectively, and do not otherwise handle the "unset" and "arg"

It might make sense to introduce this in a separate commit, ideally with
an example callsite. `grep die\(.*incompatible` surfaces a couple of
candidates.

Patrick
