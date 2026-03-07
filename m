Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CAC51B4257
	for <git@vger.kernel.org>; Sat,  7 Mar 2026 02:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772849575; cv=none; b=RjJiruXH7UIgp2+jk0jJXGdOqL3TE2uAmn97EZB+dO9K5rEAy7cIdi0FFr5OsC34jY1Zd5+Friyzvp3xPm0q6uAVQf4Au01PAGdDOT1FNG9twctI9rb0am+7jCAyswSpOQzUA4gOnO/2ucbaELoQXVc//JCGHxOU84IfjLqZXWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772849575; c=relaxed/simple;
	bh=7zYY3hK3gcc7wzo5XVgaLQKrgmPUDFBtc3C6OrLXXH0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XB1Px6/le2NaF+sVwY0gIt0IvjiEg+2x2KcLT8j8EpFAoOopPD0XtSdk6Eu13N9CNjt0D1n88breTYyRZIzg0gnwBcGCt2cCbaOORNrc84Yeo9W2Uf3vmGVtaTxp6GaB98Qs0LJgZagYlQVIiYjXZboktVbM9DZK6KT/HYF51ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=dZvBumEO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gvGnM/IY; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="dZvBumEO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gvGnM/IY"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id C27471400112;
	Fri,  6 Mar 2026 21:12:52 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Fri, 06 Mar 2026 21:12:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1772849572; x=1772935972; bh=xmixZ5WoHr
	JzII9NFbTCk+nYYsidT6X4z5kmM1Z2e5A=; b=dZvBumEOZE9fUyrZ6Y04NKR0Iw
	POc3Dhfvf5Q+ic9zbD5uk4Ou3p5eCGvu7NVdLWCkHqzlRasu+1vewX6zqFyhLSde
	WhhH9Wmyw1zO8wQvHjzKJ9NND7Wc0lGb8CwYD5SLgWYie1lu1smGIWZVv4etI+E/
	Dvo1gLeqI/Qpq16d31ZVLIgo2fdwiTVGx7Ym6kf5ObhTpiEl66Yc9YExroSwWquH
	wtY2cWdQJ4NLpjaVCrBSNvDJcp2Jxaw3QSOPaiLxdgb5mjnOpOOh4J3eNBhkWD9Q
	mI8/X0DElhnHm+1MQg8UYz1TSZ6G4JEBhbtU/NEFn/jgaHuaH4c4PY5s8PLg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1772849572; x=1772935972; bh=xmixZ5WoHrJzII9NFbTCk+nYYsidT6X4z5k
	mM1Z2e5A=; b=gvGnM/IYyzkRfbFcPRQ9ELa/0x1Bbh+Kt5tFtT9yBG4EzhZDLaS
	Taip5kn08VNjrpfGa+vPuZfj3D2Nr2ma91khE90ivQf6Ie/FeBy4IqV+FAnQYWM6
	U6OqReNh6K4NMS/hDcWWgU6f5cMtLo4W4tJgeBNBzNm/KfMlbXGIKE9Y1K1B0zAO
	20pQsf68o5dOkVJFY5RIj19aq9rI0tqmGqIPHp8ARDqzfcM7G0vRg0mn84+vA123
	xtDFkZbZ1uRTAajSLB2kw8dLUiwCiWBVld4SqbbSqgZ3SCW/qKc7CP8C0fRh1cpf
	KFoprbJUHoImJLWx4x9uyjQH6eDlFvFfDHA==
X-ME-Sender: <xms:pImraW1n6YmIGxtik5XK5A3CCFAXtNwVA9NlyvhTxGDj5emZfceKCg>
    <xme:pImrabX7lkjO63pwnHyqXk9PBP4KRLtyvg7Z8ffI-y2VnU-tpU0LKLzfh0fiCzFx2
    LIyitFDxgj0bjP0Rxj9CojwINeNdk2SVSaH6E0tzifcBwpMpBjhUw>
X-ME-Received: <xmr:pImraRKmjXqmhf7aWQTjgT58IYtG9WYoukx0PSrlE_4YmeqZqXCgrBNgP13LP9TUER7iwbKp87srPWwo6chK4xGHd6PgQ3dDNQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvjedtleeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepjedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepuhhsmhgrnhgrkhhinhihvghmihdvtddvsehgmhgrih
    hlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopegthhhrihhsthhirghnrdgtohhuuggvrhesghhmrghilhdrtghomhdprhgtph
    htthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepphhhihhllhhiphdr
    fihoohguuddvfeesghhmrghilhdrtghomhdprhgtphhtthhopehpshesphhkshdrihhmpd
    hrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:pImrad1Py7RI2XAcFbJnac3TuJJMrGRL8ceqK8XHptFUcPm7GVdfLQ>
    <xmx:pImraX5jwjFXweEh3mtmpDzHToeMWj9mZG9KR58jzu62cDT0P9nBHQ>
    <xmx:pImraW_wnCNFWLrrvU2ZWCrLO3kakr1KRFgc42VmZngpTiqf4Hl6XQ>
    <xmx:pImraeV0BIa5TQBVO-AyCLB7Pu5Ofqw7cLKfV33wwk_bWGXMpj6lTA>
    <xmx:pImraYg8IAeu6R_x7pMWRIbn790yUeyu0NAxCaYPGt4LRELvatUTPAPQ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 6 Mar 2026 21:12:52 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Usman Akinyemi <usmanakinyemi202@gmail.com>
Cc: git@vger.kernel.org,  christian.couder@gmail.com,  me@ttaylorr.com,
  phillip.wood123@gmail.com,  ps@pks.im
Subject: Re: [RFC PATCH 2/2] push: support pushing to a remote group
In-Reply-To: <20260305223248.170785-3-usmanakinyemi202@gmail.com> (Usman
	Akinyemi's message of "Fri, 6 Mar 2026 04:02:48 +0530")
References: <20260305223248.170785-1-usmanakinyemi202@gmail.com>
	<20260305223248.170785-3-usmanakinyemi202@gmail.com>
Date: Fri, 06 Mar 2026 18:12:50 -0800
Message-ID: <xmqq4imsv13x.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Usman Akinyemi <usmanakinyemi202@gmail.com> writes:

> -	remote = pushremote_get(repo);
> -	if (!remote) {
> -		if (repo)
> -			die(_("bad repository '%s'"), repo);
> -		die(_("No configured push destination.\n"
> -		    "Either specify the URL from the command-line or configure a remote repository using\n"
> -		    "\n"
> -		    "    git remote add <name> <url>\n"
> -		    "\n"
> -		    "and then push using the remote name\n"
> -		    "\n"
> -		    "    git push <name>\n"));
> +	if (repo) {
> +		if (!add_remote_or_group(repo, &remote_group))
> +			die(_("no such remote or remote group: %s"), repo);
> +	} else {
> +		remote = pushremote_get(NULL);
> +		if (!remote)
> +			die(_("No configured push destination.\n"
> +			    "Either specify the URL from the command-line or configure a remote repository using\n"
> +			    "\n"
> +			    "    git remote add <name> <url>\n"
> +			    "\n"
> +			    "and then push using the remote name\n"
> +			    "\n"
> +			    "    git push <name>\n"));
>  	}

The basic idea to use "remote" (the default remote cannot be multiple)
vs "remote_group" (the command line gave which remotes to talk with)
sounds good.

But I started wondering what happens when the command line gave a
single remote to talk with.  Probably we want a code that does

	if (remote_group has only one remote)
		remote = take the sole remote from the remote_group;

here before we continue.  Or the other way around and we handle the
"default remote cannot be multiple" case as a special case, e.g.

	if (remote) {
		create remote_group with a single member "remote";
		remote = NULL;
	}

and then we do not have to do ...

> +	/*
> +	 * set_refspecs and mirror detection must not use `remote`
> +	 * when it may be NULL (group path). For the single-remote case,
> +	 * handle them here. For the group case they are handled
> +	 * per-remote inside the loop below.
> +	 */

... "handle them here because single-remote is special" at all, no?

I would prefer to avoid "X must be done for each remote in the
remote-group, but Y can be done only once", as future developers
will get it wrong when they add their own Z and consider which side
Z falls into.  The code structure that removes special case would
help by making sure that a singleton case is special only because
the loop over remote_group runs once, and otherwise there is nothing
special goes on.

Thanks.
