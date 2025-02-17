Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CCE318DB3A
	for <git@vger.kernel.org>; Mon, 17 Feb 2025 06:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739775355; cv=none; b=WprRENuQop9ZqK39xetlISwtZ/CwnStZD/AUU3fGl/+xLOHn7h2Ssg6Zo+s8GvllQk5jmfbPMSE0Is+MbuhnshHoDxS9l/JXnxnWlNM6AcrdYGQC5ue1X8DV4kjLUa+EOrFhUt+XYEfxoLJ5ufw0WwhQ+6R9pq9tTBteb9BX9NQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739775355; c=relaxed/simple;
	bh=dgTQlE5xqirUN8Ncv+0Jut29DizHgakUI0vLF6G4WMs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SaUbZqcriViD0Q2y2tuGq/7o3BWQzONxLT1ibHAGXSHm7awWHSv+hfO8VE2Qu4T613AdmKBgiYgovAN0Nw7b86ogQYiouC6oi4oGdCBx41YE7wOEYBjZdUrMSivboHcM9DvvH1t58CohFRvjq5VM/3JdxW2pGkX4w/rzaxKE6p0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=P02xKaOc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PrOpV230; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="P02xKaOc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PrOpV230"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 0E51E114011C;
	Mon, 17 Feb 2025 01:55:53 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Mon, 17 Feb 2025 01:55:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1739775352; x=1739861752; bh=qCogWnIeDz
	cWwvAcDI4M4N8DqeyxWX+jLNu4zly/YKE=; b=P02xKaOc0c7fBOQsHf9V7QxPM8
	pLfDnBtqL1b1DraMurijbo+mekZshhKeEc0LrNaQEHR9OxuwxWLgMqFu1UqW02TZ
	h7Gjz1/ugDz+45uVhHYiKYLWTk7GxcMZCjEzYD9CAytdHC1IJxuKdgD0OteOhqX3
	L9oTBqgy4BvYZQLIu939EEOCZpQXeXlQ7Oa6wsoYUBNi80cEMhUwfb0bXQZyl/M3
	/pPXsUeYc1G7ebvHu3LxDDQAwkpEWPOpPKq7qkY/JjZyaNvd/uhEfvDvTswd1Lw8
	QZdwXNhKz5YfT1pNpzZB2bg5CyE+W8aNKQIaQ1w1oJt7F85mzIauM6vcfV4g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1739775352; x=1739861752; bh=qCogWnIeDzcWwvAcDI4M4N8DqeyxWX+jLNu
	4zly/YKE=; b=PrOpV230OYKwmX47H1/zmpkeLtWRzHuHlENt91bntVH9N1ul1t6
	qsZ5TmI/XfmJ4Fx9gXiqPFUmWvNpwyPJb7exCAwtHXQWVyGzWbCGRIlmjgrntZzx
	Ti7PpgVh3nfErmEPtYfXaTu71ChRuJ51zdONZpj5EOebbECH+VRRZT3zLjiuGypb
	0h8Mg8sCHwZaMqOj2f9fo0kxWm0RmDhlMiL9oJ1bjXWi5EmtobSo3ZhTKceSVmIH
	rVXYJWRsFqftkwwi9ZtmHOA1gNcNCksXOvjPi52Zvfux/cFelyKIqcbJE/ErpNGo
	7ULcYJs4LoiG0rwmGjztK56zd3n+r3F0D9A==
X-ME-Sender: <xms:eN2yZ_T_5ID84sU283HSpwILlWCck8XHHve7JF97G6-231jzd02yJA>
    <xme:eN2yZwxPXHSnK_mmLgywlRkPBMvKiEVarHKRyFHmILkvm_pgNX9h8SzuOQC2tKpHq
    Rg8AfNYIPzrJ9CuWg>
X-ME-Received: <xmr:eN2yZ03Iwrjy52xEk_8tAuoWXOOJ83nmyJTsJ-KeSGsqlB3QZ1yblHRcriSBOjVsj13g-upDbcLqfINcRn327iaqCV3xWwYmlit-jHqxQg3cats>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdehjeejudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeu
    gedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeeipdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehushhmrghnrghkihhnhigvmhhivddtvdesghhmrg
    hilhdrtghomhdprhgtphhtthhopehshhgvjhhirghluhhosehgmhgrihhlrdgtohhmpdhr
    tghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegthh
    hrihhstghoohhlsehtuhigfhgrmhhilhihrdhorhhgpdhrtghpthhtohepjhhohhhntggr
    ihekieesghhmrghilhdrtghomhdprhgtphhtthhopegthhhrihhsthhirghnrdgtohhuug
    gvrhesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:eN2yZ_Diw1wk3kob8f8Ns7lSDDX8y5TswAlv2F_bOEIoBc2CkU9ahg>
    <xmx:eN2yZ4gEzw5A9k8mKIWKw4Zt1-idIote2U_6JsJvYnL5ZhoDVRHjGw>
    <xmx:eN2yZzq6feo3nt9Vqz-3aYwMGlbJ7tnr-MN2zvXcE2oQLPS7NHvMaw>
    <xmx:eN2yZzj47TgJ-1caEA1x1UAL4JWWWDqoSOiaaDah8Yba3sAEpnWLSg>
    <xmx:eN2yZzVKIqp7hBpbDSsmbuQeZYriToOr2EY3CC4_ghC9oBMUPA_3gSM0>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 17 Feb 2025 01:55:51 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 8d44e06c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 17 Feb 2025 06:55:50 +0000 (UTC)
Date: Mon, 17 Feb 2025 07:55:49 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Usman Akinyemi <usmanakinyemi202@gmail.com>
Cc: git@vger.kernel.org, chriscool@tuxfamily.org,
	christian.couder@gmail.com, johncai86@gmail.com,
	shejialuo@gmail.com
Subject: Re: [PATCH 5/7] builtin/ls-files: stop using `the_repository`
Message-ID: <Z7Lddaa3SLSEziMx@pks.im>
References: <20250214230210.1460111-1-usmanakinyemi202@gmail.com>
 <20250214230210.1460111-6-usmanakinyemi202@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250214230210.1460111-6-usmanakinyemi202@gmail.com>

On Sat, Feb 15, 2025 at 04:27:21AM +0530, Usman Akinyemi wrote:
> Remove the_repository global variable in favor of the repository
> argument that gets passed in "builtin/ls-files.c".
> 
> When `-h` is passed to the command outside a Git repository, the
> `run_builtin()` will call the `cmd_ls_files()` function with `repo` set
> to NULL and then early in the function, `show_usage_with_options_if_asked()`
> call will give the options help and exit, without having to consult much
> of the configuration file.
> 
> Let's pass `repository` argument to `expand_objectsize()`,
> `show_ru_info()` functions to remove their dependency on the global
> `the_repository` variable.

This paragraph made my reading hickup a bit. How about:

    Pass the repository available in the calling context to both
    `expand_objectsize()` and `show_ru_info()` to remove their
    dependency on the global `the_repository` variable.

Patrick
