Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62BFE2DECB4
	for <git@vger.kernel.org>; Mon,  1 Dec 2025 08:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764579334; cv=none; b=Ei4o5ket/e19KWG3I/IG2VxjNf7MOgzkRi1fIo3nRruaFFoY7xXhRkisaiaAWjGAdMRmcB5JRrvjb3eaagSzJfLmr04Y54YV7boVggF5EPTBTFeG65ugH2IBPNh34GEiProypVGzydDRc9/nilere4BwDWB25mDA9U8iZUNTIGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764579334; c=relaxed/simple;
	bh=/M6o/AGofLMprd+RKM6KRGejWyXwTWI2CQ02niny+A4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mf2gnevNdEwi6fDSBinJCW8kRN5OIXi8h04XLQYHehRlf0IGF958VdWQswns9sV1fuQCYMbFdX/ydGVD29QqYFGzR4cVdbxJkR6BkRYACw1HLav7OaHyrWhfEKL3UEIveViEm1Ra4rur1XxxtlmuCSazQFm9iKJFwXz97jurKAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=aBjWfIKs; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=pqRSG9Te; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="aBjWfIKs";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pqRSG9Te"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 717C7EC0949;
	Mon,  1 Dec 2025 03:55:31 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Mon, 01 Dec 2025 03:55:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1764579331; x=1764665731; bh=GF7mYmxrVK
	P0r40mZbadrSjgg8QznDZtmWv/WmYylm0=; b=aBjWfIKs+D3IfeJLyNVzQcEEft
	SpGpISKNv26QXQtjERRso/FnEKvA9fEPEpF45PRSt8wgxeqTE8MLwfoqLJLKS4De
	J3zg5SXX4XdNiR592+7/2U2dR/PLjJf6jQfFaimrprFzpPX/D0ywuefb+IkleDmS
	DoJ3ocyLBtog9JTyVM6hnQXbPfG5EH9YHqqXeuvmQcebmGOPDeDNbygWV8YxhLeQ
	8p1GFho5utcW1aP60v5PchgL9oB+/AaLfwqw18IsmWvbrw+bdrqfW6sOYwNzO3lb
	wuF3ec1qh0OWpwOCrcpFt+lf+k16XAU7Rrj/izgVJ4DfZCb9lCI8NaqOaCWQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1764579331; x=1764665731; bh=GF7mYmxrVKP0r40mZbadrSjgg8QznDZtmWv
	/WmYylm0=; b=pqRSG9TeL73AXhTxMWywEtAraROlFmJFjDjhkCJbZLCGQ92csAy
	S/1P/J1Wt8v4FI5s4oQAkrTuJZa/d7K6lppFh34/wq4ll81RJTQmmgBtYXppW7lM
	fuscD/Z8k5onylzHv6KOOtoogEA+mDgaKhzIwMnztYJft1M4VkWTI78xr4r70+j7
	AtIHXaM09HgsBQzTg7+P57eMtCil3vps+vbu9ssoqt+aQjx6udUKfSLdSJlF1z98
	nqgSy0WfmrJtsjfiA8XrxCZOk/2Ew4ziqsU9nzMEr/X3BUg+QFFAex+dBXlGxDaD
	odEivway9HqY0oZAbboz4wAwhGYDhZLkv1Q==
X-ME-Sender: <xms:A1gtaRZuxiixC5KcESura2hsXdlFo8Av_c1jzfM4klhkhmHCijlWpQ>
    <xme:A1gtacHkHSvE9ucsBPwfrm8SWsBZ2MlL99VcCvcMlAxlVHMLD4sVYIP8NAbFQ147C
    HJ0NL9fLCJP0LhvLihNzqqxpCjfF-Ffnpp9qZwg5Rq_i8-WHQw2dA>
X-ME-Received: <xmr:A1gtadwm77_0QX6F_AAxYy5oN0wSOEYRMJRkmChmoeGZ0IdG89CmLiu1PmA7zE4a0hO9h90nJlAgRoH6ZIB3Fq8-AYm9pqXlWIx6Fig4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvheejvdekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepjhhohhgrnhhnvghsrdhstghhihhnuggvlhhinhesghhmgidruggvpdhrtghpthhtoh
    eprghtthhhvgifhhhughhhvghsleefgeesghhmrghilhdrtghomhdprhgtphhtthhopehs
    thholhgvvgesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsoh
    igrdgtohhmpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhm
    pdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:A1gtaWmjehTchnNw9dPknG7kimI7V1gt2j0CTQWs6BEQV_12pW3nbg>
    <xmx:A1gtaem4SQBBJrPsV4iRf1e8Vx9EewpAMN2cXtua7p5kERnZhB6qFw>
    <xmx:A1gtaQwwgW-8KY7prNw10KYJblShuRXC6NZVmxEFVTYu3-vxV87IGg>
    <xmx:A1gtabqzREz2AgEu9C1IbPeXNiNzCt6FgB1WK5SRLMsA22K0MS0l-Q>
    <xmx:A1gtaV2F6jahyQNao9O2UhZZ6n6yLKZ7kEh7Jd17Rceq6O3rlDEZMwJD>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 1 Dec 2025 03:55:30 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id bfac591c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 1 Dec 2025 08:55:28 +0000 (UTC)
Date: Mon, 1 Dec 2025 09:55:25 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, atthewhughes934@gmail.com,
	johannes.schindelin@gmx.de, Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH 1/5] scalar: annotate config file with "set by scalar"
Message-ID: <aS1X_UohbRkttu0E@pks.im>
References: <pull.2010.git.1764195516.gitgitgadget@gmail.com>
 <a4ad8f80d062cd9fc62db69c21625eb286f4ebb8.1764195516.git.gitgitgadget@gmail.com>
 <xmqqqztkl57l.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqqztkl57l.fsf@gitster.g>

On Wed, Nov 26, 2025 at 03:55:10PM -0800, Junio C Hamano wrote:
> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
> > Add "# set by scalar" to the end of each config option to assist users
> > in identifying why these config options were set in their repo.
> 
> The implementation is quite straight-forward, inlining expansion of
> repo_config_set_gently() in the places that we want to add comment to.
> 
> If we had (a lot) more than two callsites, I would have suggested to
> add a simple helper function, something like
> 
>     static int scalar_config_set(struct repository *r, const char *key, const char *value)
>     {
> 	char *file = repo_git_path(r, "config");
>         int res = repo_config_set_multivar_in_file_gently(r, file,
> 		key, value, NULL, " # set by scalar", 0);
> 	free(file);
> 	return res;
>     }
> 
> and then the updates to the callers would have been absolute minimum.
> 
> Well, even with only two callsites, perhaps such a refactoring may
> still have value in reducing the risk of typo in the comment.

Agreed, I think it's a good idea to provide such a function. The calls
to `repo_config_set_multivar_in_file_gently()` are quite verbose.

Patrick
