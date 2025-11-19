Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCCFD30EF7D
	for <git@vger.kernel.org>; Wed, 19 Nov 2025 17:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763574453; cv=none; b=L/VYhJSYwMWCxzyy0sbFnfiN+c8t6uo+WHdkgZsC4T1iNDaYBR/DzhiqEhKgXhRNqUK9C939MFUTjsaNpu7sWImHus4cykz6dibQVGd0TbIZ8Pl2LwzDr82FFPGg94WjvNolaDwBPzSTyRuPX4vBOvUIb7r9xvQIPkKD8lPmhFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763574453; c=relaxed/simple;
	bh=oWPR6ZCNI7cwwASJd4goOFDQ1nXHc3ZTl7Z0M7x5tac=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=u7rFfsHaYksyg6oc0wjh3fNScLPLPKJQSYVFxqSf3pKHxLT4+juwcc4gqaP72YVIwpkNnM4h0LuQ/75RzciCDkDIEVvun0F58Tx2J/cCzyjOCtm0fGG0J3FeJKuPW5U3rUyVHu890laL2/k/rEV8OKSOrcltDO9045ExpmDmJ5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=FtjfEb9I; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=yMc4m1Pb; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="FtjfEb9I";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="yMc4m1Pb"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id AD2507A00EF;
	Wed, 19 Nov 2025 12:47:26 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Wed, 19 Nov 2025 12:47:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1763574446; x=1763660846; bh=PgIvlw/fKW
	/KVcyDhhDKgR0s5bxnfmlCNQfZ/Hr9cRs=; b=FtjfEb9I0EzjNwR/3d4wOrx+9T
	wYz1FkS04MSDrIXT2TlhElmRM5z2TH0XZoavvoTdNYapAF5DxaBvcyl1z673yTAu
	Uq0/HoWAgRo/hoM2e+tyrGTUF1GabmPYRKjvQ8o7nnOtOBWYTPasDkhOKc7t+xHr
	b7PfP10+zg82IWM5wZnVOvLTO1yq/I7KnKMWqAQi4J/WxUnth5uGQO0aQ2VNtfMU
	lmM4vA8OTQ7qMeU/1l/4jWn4qJFDwzv/+5/g26vRM1qBd/wfYHgmC4AksnCGMijJ
	tzg0u/yDqSnYnWQCx7u6r5y2jlS9bcnbHWGQome8mSMlD0obTC1euXMAkXAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1763574446; x=1763660846; bh=PgIvlw/fKW/KVcyDhhDKgR0s5bxnfmlCNQf
	Z/Hr9cRs=; b=yMc4m1PbS0s9sN982gQaMy7NhA3rW/f3mzLjJt1zJ95VETd9qyV
	xJ4OBT9Q8eFBymE98yWBTHMazHhF6LgcjTqbl9kZzzM2U3fHsZSF0lMW+nUAlk6k
	kxA1+DfLp54j8cCABGmi+UtaRJutzbCMXH5vy4CtJs1yUGsE/6nVzT4176Lv8RU3
	rN/JwgPQ2dQ6CWA3sk86C4Hy7WPv+FlPHq4L8GPD4TSsBKWrgp3bY7YjkEPGEcyT
	iT68DKqGfwkhPCjkjj2xP23R670GdsHiyuT8RDjCIbHg2OZADYgrAWJQgSGbaU0y
	WCgv4st+PWM+b3zUa+j3PODg/lbf2YG64tw==
X-ME-Sender: <xms:rgIeabK8_NosvHG3NswwNEZcC-q_Z25N4thK4rEdqE30LFzcMRXRpA>
    <xme:rgIeabJB9H-JQynuq0KUXsD5AJWg2PC028XW3QwC1aggwewZGxiSdFJfLyI1NfS5v
    _zAVSw8AXZBHcrE223RYzApdXnjKUMkw2AgwA8ysed-WdjavPlnGg>
X-ME-Received: <xmr:rgIeaV414VyQPMAdACpr11C6fjAmAndGNVnV0FuHATFTVAm9-hrayxiwHhfQOxTChxK4nA8DwkgGNr650fte-hbV01dr4SzeeNr3>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvvdegkeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepkedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    peguvghlihhlrghhfihusehmihgtrhhoshhofhhtrdgtohhmpdhrtghpthhtohepshhtoh
    hlvggvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepjhhohhgrnhhnvghsrdhstghhihhn
    uggvlhhinhesghhmgidruggvpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtth
    hopeguvghlihhlrghhfihusehlihhnuhigrdhmihgtrhhoshhofhhtrdgtohhmpdhrtghp
    thhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:rgIeaVcNMsv5uYaao_zBf7BhrKm78UEnuGRNEGOQkYNTaU4i_JCzhQ>
    <xmx:rgIeaQGtncG5ZJ80I_BxVMfZNGzSOTuwQ929juxo2b5RXBtvhoYS5w>
    <xmx:rgIeaeRECoLD49eQGYZDtRzBf8EepJOMlcGt7lu_8-e-cAyQoCuqbg>
    <xmx:rgIeaeZc9FNub7ssdxwH6rxCuwCnXre95A0X5KOz1hTx0Frm43QMxQ>
    <xmx:rgIeaZJ0TFigS7H5zPcgZ1EiDA-teJjhebWdxl2fRp370ochmPowYxiv>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 19 Nov 2025 12:47:25 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Delilah Ashley Wu via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Delilah Ashley Wu <delilahwu@microsoft.com>,
  Derrick Stolee <stolee@gmail.com>,  Johannes Schindelin
 <johannes.schindelin@gmx.de>,  Patrick Steinhardt <ps@pks.im>,  Delilah
 Ashley Wu <delilahwu@linux.microsoft.com>
Subject: Re: [PATCH/RFC 1/4] cleanup_path: force forward slashes on Windows
In-Reply-To: <c8df6a042b9e971f392b2fd2d09a9c3c655dbceb.1760058849.git.gitgitgadget@gmail.com>
	(Delilah Ashley Wu via GitGitGadget's message of "Fri, 10 Oct 2025
	01:14:06 +0000")
References: <pull.1938.git.1760058849.gitgitgadget@gmail.com>
	<c8df6a042b9e971f392b2fd2d09a9c3c655dbceb.1760058849.git.gitgitgadget@gmail.com>
Date: Wed, 19 Nov 2025 09:47:24 -0800
Message-ID: <xmqq7bvldidv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Delilah Ashley Wu via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> All existing callers of
> `cleanup_path()` pass `char *` anyways, so this change is compatible.

Not just compatible ;-).  If there is a caller that wants
cleanup_path() not to munge what it passes, this change will
introduce a bug for them.  Have you made sure that none of these
callers mind that backslashes are converted into forward slashes?

> The next patch, config: test home and xdg files in `list --global`, will
> assert that the XDG config path uses forward slashes.

The path to the leaf-level blobs is always slash separated in the
index, a tree object sorts an entry that points at a subtree as if
its path component has terminating slash, etc., and only when these
paths are externalized, they are converted to filesystem dependent
hierarchy separator (by system call like creat(2) even on platforms
like Windows whose filesystem uses backslashes as the pathname
separator).  Canonicalizing end-user supplied path early at a
central place does make sense.

> -static const char *cleanup_path(const char *path)
> +static char *cleanup_path(char *path)
>  {
>  	/* Clean it up */
> -	if (skip_prefix(path, "./", &path)) {
> +	if (skip_prefix(path, "./", (const char **)&path))
>  		while (*path == '/')
>  			path++;
> -	}

Hmph, the need for cast is a bit annoying, but more importantly, why
don't we have to worry about leading ".\\\\" instead of ".////"?
Shouldn't we be stripping backslashes the same way on Windows?

> +#ifdef GIT_WINDOWS_NATIVE
> +	convert_slashes(path);
> +#endif

In other words, why do it here, not _before_ the loop that says "If
the path begins with dot (i.e. the thing is relative to the current
directory) followed by a directory separator, remove it together
with any extra directory separators that come immediately after it"?

>  	return path;
>  }
