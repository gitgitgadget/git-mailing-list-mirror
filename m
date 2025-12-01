Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EB293C17
	for <git@vger.kernel.org>; Mon,  1 Dec 2025 08:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764576682; cv=none; b=tEIJPZiP8vd9+MES2txDgswtMaG2E2ldJ89ihjVk9bV6By+J1ScivmFoIUjSP/wJlCFkVH+bqJZ0pGj3H+NhDvVd0cfjxreYN9XJ2Lg+Jm6fvCMoA84KTo5bB6OoVLvbP2b7zsAjhFb5z5Jn9qKTQUlkN130IFj/ePg6ArlGDx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764576682; c=relaxed/simple;
	bh=wz5rTkIK07T1bJvRQP6VIemYdPdIZ08wlhD/477+bpc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ian+CB26EwnMeWosDnTmFSCh8ujXAXfa4dL6/IeiTG+7QcHjVG+zdaNz8gK+o1cFE5uXSa+a0evhUZHSkqCrCpTQcpcuEpnO/C/d2LOd6IHVys0gx8M9cz3mj+HlifYmHZO37aHwnPQKouFE3revF4YWym2++rX8P2NEEvBVQZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=FZjMVMax; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WNGrXUkM; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="FZjMVMax";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WNGrXUkM"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id 5363BEC0605;
	Mon,  1 Dec 2025 03:11:19 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Mon, 01 Dec 2025 03:11:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1764576679;
	 x=1764663079; bh=fnvjhlb5zrh1PxvJmWbEsLRndbsnAGztt0J9HjMOBoM=; b=
	FZjMVMaxJGatv2acTj/27bb5eunYhcS0klop0E/i3J9oPNWoDIC9DsPm16gVMwW8
	c6YRfLBnPMLZ4R9xqOZWyfV7CeqNk72Ifa2mtybQgSww3w8qDKUiGDm+OvZoPMnE
	HrRgBWP2YqqfAGpLhbsdqVOJClCg9L45GuD2K5wD6HbgH6nD97lqwu6jyoVk5zV2
	FsFmMQRDfrturiBJVmDu5+biTLluvM4duwcLSdop2k6Tih2VNgjfedpz1Vu+n7mm
	n29nbl3sxIua72YBKl45aoF40iLlMvPosN2yg4Lcodtm7+ESe1RANHBvqttJa7Ea
	zf7e5+qpWUpW9PSVc4Dtlw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1764576679; x=
	1764663079; bh=fnvjhlb5zrh1PxvJmWbEsLRndbsnAGztt0J9HjMOBoM=; b=W
	NGrXUkMIbsZtXDgJq3nD/6z1dIWROp57ZBxDflC4T8zCv6ivSN4Or55wbAVHf0+n
	nszY51iCWECl05sTN6v3z7bUDcb9FQE4D33YYqKzxUAtQr5afEcCFXVSEhIsmmKr
	0QkrgdBcISQwYTbz3cGpC0DepKGuz8VMZSAC0O6iU9GIrFFwc+TYnb9x8O1NYr2L
	WFxP0asPAMoJpBQtBjiLgbhqW8IS73KfiboA3BVgrpT8F47zPZ/aN3VxEtIZ/G6v
	VSGTZQfvB5l6sxFpiE3E1Zn/ufLNzWluYH3N896wQCCpK5ph1R39ac6Q0CWDzoti
	Zg8mZ2U2m2Bk0UHLTgS6A==
X-ME-Sender: <xms:p00taX80rRNDuOlSuL62kPHSRSV5VddfdImqyQAdDdo8GMxRgPoXiw>
    <xme:p00tabJrzzbd0qrup1h74W4Wp5_WrM1HxTVWXRbkBaCnU95lWClpDhJ9Qi-173Ztl
    tbXuwmkvjeIKeBNWzn7gdDW8tlUxfLPh_JBvJXUEmuf5HO1ei1y>
X-ME-Received: <xmr:p00taSbPqInZNhn1k7bcDCFfkixYxvZLPbblV9ZOFQ6haHCWVcrX_fwccloSm7wzaxaX4jJFk7M_p0Cpxz5nsBfWfIeZsm44mYpvq0Bb>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvheejudelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtugfgjgesthekre
    dttddtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepvdefjeeitdetleehieetkeevfedtfedvhe
    ekvdevteffvdevveejjeelgeetvdfgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopehlrdhsrdhrseifvggsrdguvgdprhgtphhtthhopehgihhtsh
    htvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:p00tadLazhoC4qiGAJSeqBEMqBcq9vss00lnLZ4Q9I1bOwBhOMJEKQ>
    <xmx:p00taQBTpYJiSSUpl1-M4jWflT3XEyC3dyK6Qj0hsjjvig709V5H9Q>
    <xmx:p00taSrYh7fjgp5MTLsQah_fiX59nxelOQRc4hNjGl1dy8KKw73HiQ>
    <xmx:p00tabjPl1E3LUijXPJDftyXM9z8GsmzquwpeC68VXwKHgH_ZzIM1A>
    <xmx:p00taeyTvwU7OKWWJimIgOVKlZy31zDcC5uPEjgZmO8X5u6dbW0kjQxS>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 1 Dec 2025 03:11:18 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 2afdd72d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 1 Dec 2025 08:11:16 +0000 (UTC)
Date: Mon, 1 Dec 2025 09:11:13 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	Git List <git@vger.kernel.org>
Subject: Re: [PATCH] config: fix short help of unset flags
Message-ID: <aS1NoXf4uBHyv13D@pks.im>
References: <06997dce-e4d5-4889-8e70-5f44da3dc800@web.de>
 <xmqqtsyjujd3.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqtsyjujd3.fsf@gitster.g>

On Mon, Nov 24, 2025 at 03:00:08PM -0800, Junio C Hamano wrote:
> René Scharfe <l.s.r@web.de> writes:
> 
> > The flags --all and --value of "git config unset" don't make the command
> > "replace" or "show" anything, they are about selecting what to unset.
> > Change their help text accordingly.
> 
> Good eyes.  Perfectly makes sense.  Will queue.  Thanks.

Indeed, the patch looks obviously good to me. Thanks for the fixes!

Patrick
