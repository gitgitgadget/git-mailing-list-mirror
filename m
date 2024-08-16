Received: from fout7-smtp.messagingengine.com (fout7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5E1213C9A9
	for <git@vger.kernel.org>; Fri, 16 Aug 2024 08:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723798216; cv=none; b=ktxttnvwJ2KroWlCytKhv8ezUzOp3CjPpULAAgCf0aQowEAfnfXkkyIejE7BNwJV8Fn3t70lYK8LDFr5/kVoCjVrp9zgWjudcTJwn8rZV1wid401oK6T7i9ncHS5MgZ+EbFPIGFT2W9q6nK8PNLlHVd6LbuS++IWtG6xwZ4K+cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723798216; c=relaxed/simple;
	bh=jXMSFsjgalaeA7KEUyLrjRHYEFm+yM17cdhbml+s19Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qGly9PCQenHTYbz9/CKjYGcQw9fBt4EMW4E7vaoHp5SNpawNFn/6IjRPRtAy2dPRgjXdqQ2gym53HLdrRUjLWc0C87Afbl5TTZcUmngshb17E9QlyBQhUTPP+g5+wzFTILGUsbJSNfs9XlMpol8+jbh/G83TJ7rLykj1Oa3Pd4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Kli/D0oT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jkI4dPS9; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Kli/D0oT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jkI4dPS9"
Received: from phl-compute-03.internal (phl-compute-03.nyi.internal [10.202.2.43])
	by mailfout.nyi.internal (Postfix) with ESMTP id A9640138FE99;
	Fri, 16 Aug 2024 04:50:13 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Fri, 16 Aug 2024 04:50:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1723798213; x=1723884613; bh=LCweKHB43d
	bmr4Pub0Ae/2G4YG3WVXfz1ntyjfWrHYA=; b=Kli/D0oTsRcGCiP+qvvxIZQgW6
	l4UYgKx2SIzvETERupjj4lIl6YmgeCeRA77kC1G6RCw259516mhVlNc+gAjQGiR4
	c5mQadUiFMM8Q2t1dkhAzNJ1nRRnA4UgwQEgOIqT38g45LAsVuycbqRKxtcgdTA0
	kUBwxfdxyjdy/EyHaj9Hn64E435GbOUlCfpAmifKaVl6gm40nk9Jw3R9D0xabfOF
	urAM7LQQKmMoiwMZTIFPfr+e+yKbLGbaq5fZ7mCttCsTWBaD6nGUwYCtWF5Y7Wzp
	RLww1pZN+eeJtk3eNSLAofRiW/ZcY9DnP/wreNtPAqUrmGTXh0Dgd6gtgvSw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723798213; x=1723884613; bh=LCweKHB43dbmr4Pub0Ae/2G4YG3W
	VXfz1ntyjfWrHYA=; b=jkI4dPS9vr5E9E1eKVuoO1Jcyb/8zPCUn0ui0fH8bXJx
	phpoNEYWzaRWiyLS8Cka5Fo07WZGl81sajD8jF4tyEEeEnDWEeSFrx3Lnd5s/CEH
	+XobKYzef8m+eQlSTDh8WvfWopFlkJt2pRdjBphD8mRikPAtP+avj6F9wfSqC3Mp
	EpphM820WHIPzbzkynj9PONSkrnXvlYEB8Huwwck3G39XhibZY9YVkD0P6Spjlms
	xYmd10x3PAi06ZKp7wuSRhg0AwV9DcGnTVkFfiM8I1+Lmf+V65hDIxTufDq4nVrM
	Og6f7+x9YdxqZqU/XczLKHznu0UgvguVWrhWD8bHmw==
X-ME-Sender: <xms:xRK_ZhDF08z64H6CKKIB6EO5TEJS2r9HAQQ0eM-rrwEz8YTpnx-5qg>
    <xme:xRK_Zvhj7UvjzoeADoET9DzUyECJl4bDYl5bSsPJsYXMwmSwYzJVDWi5zEgTMsUkf
    hRruz1Mwey-28VCJQ>
X-ME-Received: <xmr:xRK_Zsm45MtEchB0SARReJ1MCgULn-9I4LLYB9tUjwDnA0hp6OjJv0NBjEgbqv5uFHLUdnFx-4nHjsmnE1O6eFVLiGiasPUky9K03cT3G6-QRx4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddtkedgtdejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopegrvhhihhhpihhtseihrghhohhordgtohhmpdhrtghpthhtohepshgrnhgu
    rghlshestghruhhsthihthhoohhthhhprghsthgvrdhnvghtpdhrtghpthhtohepghhith
    hgihhtghgrughgvghtsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:xRK_ZryvljrZXqRykYwL_h87O-nZMmA7jRQF1rl0UbmorJLMWoVZMA>
    <xmx:xRK_ZmR_n5mXIFUrtVmWTWj3lGMmN1_ABknN7MSMyXQ9zP6ZBgz17Q>
    <xmx:xRK_Zuaxc170WE8HlJCVK33rcvh9DwOJDvATZ8qmkJnxZ_Xobgcltw>
    <xmx:xRK_ZnT0vA-pn3S09qe-xdIOb9yqYFUS5wGnhUCZiz9SFTU6KIZh9w>
    <xmx:xRK_ZsMd5Rj6p1NaYuhPRdhRRcuR5TLpDPUAfYmqMlkRspvRiOPnXBjt>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 16 Aug 2024 04:50:12 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 2e15fb4a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 16 Aug 2024 08:49:49 +0000 (UTC)
Date: Fri, 16 Aug 2024 10:50:10 +0200
From: Patrick Steinhardt <ps@pks.im>
To: "Avi Halachmi (:avih) via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, "brian m. carlson" <sandals@crustytoothpaste.net>,
	Avi Halachmi <avihpit@yahoo.com>
Subject: Re: [PATCH v2 3/8] git-prompt: don't use shell arrays
Message-ID: <Zr8Swsn3H2ebB7g6@tanuki>
References: <pull.1750.git.git.1721762306.gitgitgadget@gmail.com>
 <pull.1750.v2.git.git.1723727653.gitgitgadget@gmail.com>
 <7e994eae7bc3dfa021262410c801ddb124ce24f1.1723727653.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7e994eae7bc3dfa021262410c801ddb124ce24f1.1723727653.git.gitgitgadget@gmail.com>

On Thu, Aug 15, 2024 at 01:14:08PM +0000, Avi Halachmi (:avih) via GitGitGadget wrote:
> diff --git a/contrib/completion/git-prompt.sh b/contrib/completion/git-prompt.sh
> index 4cc2cf91bb6..75c3a813fda 100644
> --- a/contrib/completion/git-prompt.sh
> +++ b/contrib/completion/git-prompt.sh
> @@ -116,10 +116,10 @@ printf -v __git_printf_supports_v -- '%s' yes >/dev/null 2>&1
>  __git_ps1_show_upstream ()
>  {
>  	local key value
> -	local svn_remote svn_url_pattern="" count n
> +	local svn_remotes="" svn_url_pattern="" count n
>  	local upstream_type=git legacy="" verbose="" name=""
> +	local LF=$'\n'
>  
> -	svn_remote=()
>  	# get some config options from git-config
>  	local output="$(git config -z --get-regexp '^(svn-remote\..*\.url|bash\.showupstream)$' 2>/dev/null | tr '\0\n' '\n ')"
>  	while read -r key value; do
> @@ -132,7 +132,7 @@ __git_ps1_show_upstream ()
>  			fi
>  			;;
>  		svn-remote.*.url)
> -			svn_remote[$((${#svn_remote[@]} + 1))]="$value"
> +			svn_remotes=${svn_remotes}${value}${LF}  # URI\nURI\n...

I was wondering whether this is something we want to quote, mostly
because I still have the failures of dash in mind when assigning values
with spaces to a `local` variable without quoting. I do not know whether
the same issues also apply to non-local variables though, probably not.

Patrick
