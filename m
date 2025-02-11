Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55A8E1EDA22
	for <git@vger.kernel.org>; Tue, 11 Feb 2025 07:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739259822; cv=none; b=ohIlhEmWwqe9OAynL/7ziTgIQkl/JUju6ewhQIveS/0ZTRsJYZluSKtK2x94cbslkoq6EJwdV4vT+T3XV1TCRtFs6glpmk1dgEZdwtv+qZMFdBqsW9bz5tR0Foui2hgv4nny5ppbX8yBj/Q3AxUMc6CrdzZLJ2WG+10e1Thtuwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739259822; c=relaxed/simple;
	bh=Iq1P2AYxiXzXUnhyJr2KIXHyCNjsk71JyqaKAaTZ06I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ke6hf4f2E85YkcSkg15bIQyRxpwAOHTcLkZmQprZebO0n5AELTidbpTmLLrNeOoulsEaqhQVLUCJnTxALkCH/8Ec+acePDiti5EMKlAZz94+TlaO+zcihj287JNQZCzKINw0Qr5MrTlS3QoRPQVB/CG9BdXemWVsquEoW8qpXMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Xbc+BtwW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=r2nnlBiU; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Xbc+BtwW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="r2nnlBiU"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 1416625401BF;
	Tue, 11 Feb 2025 02:43:38 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Tue, 11 Feb 2025 02:43:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1739259817; x=1739346217; bh=cWZdQBmEJG
	8xva3ZGxOQF5AG3qjI8qAEwfJa61hFsaU=; b=Xbc+BtwWErO/nba2qBqVCl4OnO
	BiLek/lU/knxLhd5Zif7IQic62Dsi546aJ/jJ6jsus2QYRFFSh89T2nS9/fcVYtZ
	P/2GkO2sOsCI8GJfxCfScWnYDPBTt0pBtcteuJt7VI94HkjhkHSQlQxQ3FGMEPhD
	LJcThsIO6L3IFWr9VweokWm3RFVUxZHeX0lm7xKV9/h1c1iNs6erR4ADcdzPpBqk
	tdgGpI1KyPQfzgnj62/9gFdjLuGEwm/SbOiZEaDVD3USZuqZkLjEL9Xc9h7CAb4W
	+q1YxeZH/8FZoifR9o0wuZTCpNt8l11237A3NRXiyqz1Gujd8JvV17B38E2w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1739259817; x=1739346217; bh=cWZdQBmEJG8xva3ZGxOQF5AG3qjI8qAEwfJ
	a61hFsaU=; b=r2nnlBiUzqJm0TLXc7LJPu/ewHS6pfzWlsVo36+Olqp/Bxal9PT
	xTn2bQQSKZzy22U9iXoGXTAQYqgVjVVtRKvWRA53a6isirIBCSTogyrdPn/E6oim
	bOi4mWr88dHGWf/WX8L8BnAMDwwixzVMJ4pxz8PO5q4fj/iCeWkbvb8wBMGJuwQp
	Z9J+ems5j6nq1D0h41ljf5PsipTjY4D8dnd2CiZMTnvHUc1OE1gmkdE1Wo97Usro
	2JEoyBgVGwaBe57RMSBxbspDTJOuV7RhO5ylP3lxAd8YDh9NJMb591LuWHgVTTGc
	APgWb+YMVHluyDJqK8V0KRazlzL+P1gjy/w==
X-ME-Sender: <xms:qf-qZwg5DmWu9uTeZgbq1gAp4s6fyFEIEO97uIk5WuaLztyhLwK1Og>
    <xme:qf-qZ5CUoZmw80PphlXGbgdN55Qxd1jzHQaLG7ItYQrbW6Aw_padzumqrQdxtYqjD
    RIYVeFico1gyweQJA>
X-ME-Received: <xmr:qf-qZ4H5ZWHzNaw2vHL5IP_yxWekr6LMDalKuse5ikxvdEngLMChDwnC0HvanEJAexm5HHlgtArOxsjyi04DaGViQwWHaP8xgDkYPhF1eq5DFX4t>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdegtdegvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeu
    gedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeeipdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopegthhhrihhsthhirghnrdgtohhuuggvrhesghhmrg
    hilhdrtghomhdprhgtphhtthhopegthhhrihhstghoohhlsehtuhigfhgrmhhilhihrdho
    rhhgpdhrtghpthhtohepuhhsmhgrnhgrkhhinhihvghmihdvtddvsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehjohhhnhgtrghikeeisehgmhgrihhlrdgtohhmpdhrtghpthhtohepshhhvghjihgrlh
    huohesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:qf-qZxSOZDzunLM9DLjmpVmobDByg8yBvm5yJOznITKDzyAjz2padg>
    <xmx:qf-qZ9w6Kp3omoZGpCwIdgz8TndXEZN8_ZPLZZ1X_TinpLdYt3TGIQ>
    <xmx:qf-qZ_5Tk2fb4SUpdl3_B1jztPf37oARMBWB23O7IFRfuTBc7MKVVw>
    <xmx:qf-qZ6yI9pt52x5X17KdeS8xC702fShgsJ3kuwD5IJ-d-T0BiwIRyQ>
    <xmx:qf-qZ0nwG0hXaa--ycGT4bSRUUewQk0Z4ZDWYcw15MKxNTkn59a5lOdA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 11 Feb 2025 02:43:36 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id b2d4a607 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 11 Feb 2025 07:43:35 +0000 (UTC)
Date: Tue, 11 Feb 2025 08:43:34 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Usman Akinyemi <usmanakinyemi202@gmail.com>
Cc: git@vger.kernel.org, christian.couder@gmail.com, shejialuo@gmail.com,
	johncai86@gmail.com, Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [Outreachy][PATCH v2] builtin/update-server-info: remove
 the_repository global variable
Message-ID: <Z6r_pqqP5vjJI-R5@pks.im>
References: <20250210142820.3588250-1-usmanakinyemi202@gmail.com>
 <20250210181103.3609495-1-usmanakinyemi202@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250210181103.3609495-1-usmanakinyemi202@gmail.com>

On Mon, Feb 10, 2025 at 11:40:30PM +0530, Usman Akinyemi wrote:
> Remove the_repository global variable in favor of the repository
> argument that gets passed in "builtin/update-server-info.c".
> 
> When `-h` is passed to the command outside a Git repository, the
> `run_builtin()` will call the `cmd_update_server_info()` function
> with `repo` set to NULL and then early in the function, "parse_options()"
> call will give the options help and exit, without having to consult much
> of the configuration file. So it is safe to omit reading the config when
> `repo` argument the caller gave us is NULL.

Thanks, this version looks good to me.

Patrick
