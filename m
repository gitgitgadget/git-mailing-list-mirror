Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76CB041C69
	for <git@vger.kernel.org>; Tue,  5 Nov 2024 06:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730788089; cv=none; b=hFKfi4VQcFk2VHf32++kcf5lWlHl7XNqChjRhaNTgLXdVfnoe2lGRhHGqywoujWT0seuPW9ighUoz4h5lcx0+1R0rvL+8gaU2JK19Z/0oxYJUc5W0n2Apr2sIWOCLFJkhI1DQs4tg/msiYMGONR4+FiM6X+BTPnvkjLxa/NUFBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730788089; c=relaxed/simple;
	bh=19Ys6fBJzUuQB2klpMRCTF3l/gVAshlmsM7RT8FG+F0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=okRmnxe9tCIcuTWARTDTFhtloQcGAM7EP6GObKL/aTmW1PNcyW9FkU/Xhv+uGLQUOEIjMNKHk8qLdUJFT7/zMNIdCLpbsRfumzU7Hqk3uUkb46vTOF4GdfmorQBhExReE81tJWehgbmoAD7JvIZXmvZK0b7wmdedJujQ/MSVAG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=KmkCC90e; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VxpIEVq4; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="KmkCC90e";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VxpIEVq4"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id A61B82540177;
	Tue,  5 Nov 2024 01:28:06 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Tue, 05 Nov 2024 01:28:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1730788086; x=1730874486; bh=4R0SCQZKfI
	pnttyu+cJgRepKZSDryfXO89acjzpRFio=; b=KmkCC90eZTGvBeot3njEBMUsmS
	AXnTaVkfOy/jwdvUesdkHkoJNyVA8hKBePLyvSHqzowT+WfECsqeBKVY2ciPm+eY
	CAadEvdY8EfJOz+ScEOsrqDbmy0pidqR4MPZ6WZyiPInVfQXhPJj5fgNIVGe91Xb
	xHcP+MHf81hKK45jIGIpN0iyKjURDqwi/vm+5M6ZRKPMNF3t+NNv/SDkHdgkirRP
	h4i1ulf1qn2Lw71iMPqG5Mf7BbROEJTG21vuqZBTrIV6652tBX/AeJXrQIU1BvuO
	L6SJk4wTrafbqrEQctHmoKSmiFAKwlB4biKpuuJZZ4Mm5WkBn+i1MCPwMK4A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1730788086; x=1730874486; bh=4R0SCQZKfIpnttyu+cJgRepKZSDryfXO89a
	cjzpRFio=; b=VxpIEVq4Fg/PJrb+M5xFkXthXVcDCMO+1yuGeV7bv3ewsDHTf8+
	tjqAcJ8sCJAgj3xtLM3lXa5sQmWLZyVlUT4GMceMkJgtorlFGe7H1epsVgYozTED
	DyTCrcBoi9YxEoTALRnEUFolwLESo58Y28H0XEhDXI2VTHcgP/BT50EjS1GynhTH
	JWTg/RbrsQxdwJvRKpiR6qVgJACAMNw/7PvA15oujesZQbI/FfYFga960DbydHbl
	CWEr/V/x2Mce5RHOfgDT6HaiFeuQm95eIt9qHSxBerzz1ToRuHsxJM7iKolpi+lb
	T99wtnJUUbv4eNVOYcyW6pB4sbOq6wLBzfA==
X-ME-Sender: <xms:9ropZ_RluRCRAuFh0P1KB8roV_d7XYXGu06fp5B3TNU9_M7m3j8q_w>
    <xme:9ropZwy9b41iIIm1QN8R_YI5ZigrLMUZTAo0g8LkM9g9wgi27GYy1LcDgucp9RxVy
    iCiD6wS0Z-jILFEqQ>
X-ME-Received: <xmr:9ropZ02e3EKofcy21lyO7n4kIotcF16b7UD6OXuMm1eVhnA_yA5DCvxF5Lp1p7WaSfnbijSgZmQ5YfMTIwZxcCqiGEOOtVXXzoNz0Gt6EB1suA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeljedgleejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepnhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhi
    thesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:9ropZ_AACKg84n4MFPiGl18eoKmlQ7GgcuukBczaXy0jJ_h10mtyEA>
    <xmx:9ropZ4jKw_W1Ibg2-LHNxmIbmPjnE0_ip4d3KEiTzNsKr0SXDjVi4A>
    <xmx:9ropZzoImrKVutpyR0uxjFMtfLmxuxf6SA5L-jer8KmHPdzVMb-Ufw>
    <xmx:9ropZzguD8M0iCmgv1d8kGrfZDFUDcM-7rgchY21XT4ALutm2UtwLg>
    <xmx:9ropZxt7Ac2qkOkGbbJW0RMKUcyVR7QFr51VdrHtUjsSCpRJ1C8feO5->
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 5 Nov 2024 01:28:05 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 1e4f80ce (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 5 Nov 2024 06:27:41 +0000 (UTC)
Date: Tue, 5 Nov 2024 07:27:56 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 1/2] upload-pack: fix ambiguous error message
Message-ID: <Zym65pRWPqu9VIvq@pks.im>
References: <pull.1822.git.1730746964.gitgitgadget@gmail.com>
 <bb8dbc5c7086ce5c09f8980c923ec85da38c9147.1730746964.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bb8dbc5c7086ce5c09f8980c923ec85da38c9147.1730746964.git.gitgitgadget@gmail.com>

On Mon, Nov 04, 2024 at 07:02:43PM +0000, Elijah Newren via GitGitGadget wrote:
> diff --git a/upload-pack.c b/upload-pack.c
> index 6d6e0f9f980..640d45295e1 100644
> --- a/upload-pack.c
> +++ b/upload-pack.c
> @@ -1025,10 +1025,14 @@ static int process_deepen_not(const char *line, struct oidset *deepen_not, int *
>  {
>  	const char *arg;
>  	if (skip_prefix(line, "deepen-not ", &arg)) {
> +		int cnt;
>  		char *ref = NULL;
>  		struct object_id oid;
> -		if (expand_ref(the_repository, arg, strlen(arg), &oid, &ref) != 1)
> +		cnt = expand_ref(the_repository, arg, strlen(arg), &oid, &ref);
> +		if (cnt > 1)
>  			die("git upload-pack: ambiguous deepen-not: %s", line);
> +		if (cnt < 1)
> +			die("git upload-pack: deepen-not is not a ref: %s", line);

I was wondering whether `expand_ref()` could ever return negative, but
after reading through its implementation that doesn't seem to be the
case. It's somewhat misleading that it returns `int`, as `size_t` would
convey the return value in a better spirit.

Anyway, that is not an issue of this patch series, and the change looks
good.

Patrick
