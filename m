Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CB3C34321B
	for <git@vger.kernel.org>; Fri, 30 Jan 2026 16:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769790053; cv=none; b=SkcUi7qx+wzAP9iuH4C/5g+FoDt32cIZVPF1EQuXu507xbH6cQ7LQFBVmyamodzouL1mqhz6GuF8X6d/qhxFbV8xjRb3RM9HOernwm37Jexa1g/lMQkfhnvIq929zI4imeO9P/AjeDQEgiF90NhMlda/XB0P/Xo77i/5kEv5cs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769790053; c=relaxed/simple;
	bh=op95y2ynlWhjD07Nrb6ufAWxJSWRdgp7xk/YUqdlfjg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=QyoBhWXl5SVrC0cZjNuGCVyCSP8YqD21Wr8/gL1nFtVRWZyBHoZbZiU6BBCUxk3gxv++rqUNzujOzidzQ9xayEeCJx+R/G4morkliPwsPMeaEjY6KUXXte8yYBcq1KFD63U6cifa0zlCgGRPhSZcBltkpj+gFnzqaTuamkXW+FI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=FUOPlRsN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fW0jm2VE; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="FUOPlRsN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fW0jm2VE"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 45E8A1D0012B;
	Fri, 30 Jan 2026 11:20:50 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Fri, 30 Jan 2026 11:20:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1769790050; x=1769876450; bh=B9resUq81R
	ehmULOwghiOkH0tTk98kgFoVDBKH52BxQ=; b=FUOPlRsNK4twoi77ZSyHk/wBFm
	CElm8rhUYy1ahmY2CGj4Rvc38H0DmxOhgP5Gjirvtwc9Io9wjYCvO4y/cxINpmhE
	CGSbTf5W15VqknlT/6iPRBW0cs5QVEY40jgAgHdvOkd3p00CheW18CZWUazlw0HE
	tPad38X+8RHM9SfAHRVCcEsScsx7U9NAUnLZnkotet8O0R5HKH6Tj2xJwXmWseFX
	d44ZZsee5s0F6ll4HbH6IIHvHJ+L1RjqKCgKra6kSesuSirEMugvKvrfwNnMVmzE
	oLlfH1YPAGF7PJke34vPH3XIY2plAN3fRhSfOAsRUczhWbK0sc8vzzIHFBTg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1769790050; x=1769876450; bh=B9resUq81RehmULOwghiOkH0tTk98kgFoVD
	BKH52BxQ=; b=fW0jm2VEGbEkLOFD671qBf6oDONRx7+1imNdwqkuSb4Qnp++xvd
	ccdyBCON5bbWzjQiL5fdTXtnrzbdvrsOVBooCXLw/eOxWBD1DN/xuEK2Ck7OGgJN
	+VKsftNb+wulcmfyxe17Ntl1PHyIq/D9HBPFZYOCKslM9MLgFV2Ih99yekOn6K6U
	L4aBvVEptGaawXbeaqfUEBQN76v+AZsawu4QvDTW5fIsNMoFPrDea2or4i4w8gVj
	yPfwMB8zQe+zkydKSbX+UCnnCM33Hd4mikRaYYePs11pbQhAmYuNOLsoNIgO1gUL
	8Ec6hLAJcvLfGME2hsPw7TK6Nhif8R2IF4Q==
X-ME-Sender: <xms:Ydp8aeoO36bEQKjXBHpNdTxdKX_uPPpJoKLnc_ngjcieLqIYmddHFw>
    <xme:Ydp8aYXOvZPP568u1ex5ZhZ16XzyItl-AorVyYb12SoImfrRipTGZ1Rc1hmFKF5ls
    TwN4jNY7KKaCZV2YZk8iHrVJ0wvykDMTltdc_kIG5wSZjGF3BFssA>
X-ME-Received: <xmr:Ydp8afptbVg2KVX3ETBObZgp5oD0aPq5TyAwXrrZcuDk0Ys-G8tp19ycdrhk_vY5hbkUnO3SscUIslUWhOgsfbtjaeF1Buj4CINrSdA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduieelhedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeetudduveekgfeuteevudfgkeeffe
    eghfeiudekiedugfektdelvdevudeggefggeenucffohhmrghinheprhgvphhoshhithho
    rhihrdgtfienucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopedutddpmhho
    uggvpehsmhhtphhouhhtpdhrtghpthhtohepsggvlhhkihguleeksehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehtohhonhesihhothgtlhdrtghomhdprhgtphhtthhopehphhhilhhlihhprdifohhoug
    duvdefsehgmhgrihhlrdgtohhmpdhrtghpthhtoheptghhrhhishhtihgrnhdrtghouhgu
    vghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepuhhsmhgrnhgrkhhinhihvghmihdvtd
    dvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepkhgrrghrthhitgdrshhivhgrrhgrrghm
    sehgmhgrihhlrdgtohhmpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprh
    gtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:Ydp8aXBH_IEgjZzCxxQmLuG2Vcb-PyBWhAcWCjambIhCAsQzoyPKWg>
    <xmx:Ydp8aTiC29QO_ZGQjfNQLSf89k0gox4dnidHtTUzaXnQWlLyK9Ofig>
    <xmx:Ydp8adYq1QeuZ5_fUUA8logxppsRT2uuCFIdM2vUCdPHCNL8U-x2QQ>
    <xmx:Ydp8acmR-a0QWMVm87T0ycPa-SG173u0WWfsXVJrgXqCyGmHGAgfDw>
    <xmx:Ytp8aQXXj5z_Pl6baQCUKz8hik7dyIFBHtvG6B5y0ZUJglAAU5XUI8Lp>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 30 Jan 2026 11:20:49 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Olamide Caleb Bello <belkid98@gmail.com>
Cc: git@vger.kernel.org,  toon@iotcl.com,  phillip.wood123@gmail.com,
  christian.couder@gmail.com,  usmanakinyemi202@gmail.com,
  kaartic.sivaraam@gmail.com,  me@ttaylorr.com,  karthik.188@gmail.com
Subject: Re: [Outreachy PATCH v5 3/3] environment: move
 "branch.autoSetupMerge" into `struct repo_config_values`
In-Reply-To: <xmqqms1wb6zg.fsf@gitster.g> (Junio C. Hamano's message of "Thu,
	29 Jan 2026 10:37:23 -0800")
References: <cover.1769256839.git.belkid98@gmail.com>
	<e7f37bac87aac74ca13f85ae7e393a38d2079b9c.1769256839.git.belkid98@gmail.com>
	<xmqqms1wb6zg.fsf@gitster.g>
Date: Fri, 30 Jan 2026 08:20:47 -0800
Message-ID: <xmqqikcj842o.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> Olamide Caleb Bello <belkid98@gmail.com> writes:
>
>> -enum branch_track git_branch_track = BRANCH_TRACK_REMOTE;
>
> Unlike the other two, this global variable was not zero-initialized,
> so we can do something like this to initialize it statically in the
> new world order.  That way, we do not need to worry about the
> repo_config_values_init() helper function, which (1) we can easily
> forget to adjust, and (2) third-party may not be able to call.
>
> diff --git i/repository.c w/repository.c
> index d308cd78bf..b540e2ba01 100644
> --- i/repository.c
> +++ w/repository.c
> @@ -25,7 +25,11 @@
>  extern struct repository *the_repository;
>  
>  /* The main repository */
> -static struct repository the_repo;
> +static struct repository the_repo = {
> +	.config_values = {
> +		.branch_track = BRANCH_TRACK_REMOTE,
> +	},
> +};

After having slept over this one, I think a static initialization,
which mimicks what we have been doing with the global variables very
closely, is not what we want in the longer term.

The aim of these patches is to prepare for a new world order in
which we can add new Git subcommands that operates in two or more
repositories at the same time, and have these repositories use their
own versions of these "global" variables independently.  While the
static initialization has these advantages:

 * Once the code is written, no new command can forget to initialize
   them; initialization happens at the program load time.

 * No programming error can wipe what has already been read from the
   configuration by making a second repo_config_values_init() call
   by mistake.

neither of these advantages apply to second and subsequent
repositories.  We'd need to somehow initialize an instance of a
repository that is not "the_repo".

And for that, repo_config_values_init() is needed, even though it
adds the downsides that are opposite of the above two advantages of
not having to have an "initialization" step.

So, we need to take it as a given that repo_config_values_init()
needs to exist.  Under that condition, I wonder if we can somehow
have a cheap way to assert the following two things:

 * Before a repository instance is used, repo_config_values_init()
   has been called on it, as using an instance without initializing
   is a no-no.

 * repo_config_values_init() is never called twice on a repository
   instance, as the second call will wipe what the first call and
   subsequent reading of the configuration files have done.

Thanks.
