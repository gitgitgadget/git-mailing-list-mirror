Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ED16375AC1
	for <git@vger.kernel.org>; Tue,  3 Mar 2026 06:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772518566; cv=none; b=oXjTmfToz8d4rx6WsTrsI24zVnR5qIrAlG7WiEqM6qGiZSsVXMYjTl8/CFbTGOGW2V4u0L8ZEPOcnQHPLmaKOTtXAFueICT1y0+0X08BVgjZVnQUBWLZtPUxt6Req+BDTTUyMDMSaG3aQ1pv+Z13KUu7Q/Tgz53Z9OeOSog6R5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772518566; c=relaxed/simple;
	bh=Lv2Dm/2zDjRoIk4Ayd4goyO7QiORpDdhZsZe04VO2Rw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DLCy82Bz4S18LGpOM0I7GdcvNXpxUfyOLcZQ5vKUVKjQ4lFONvsR//QEObcwYncLoUwPybzD8hfQhchIGe4Qsq8Ag+Z+op2qNagLMy+H4N5Xrtqusse7li14P4etmQm9dfAWW0TBgUW58fxK6XyrK6Zrf4mHbGrC3UP0h5HFOg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Sfissseg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nNw6SOmo; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Sfissseg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nNw6SOmo"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 5FEA87A02DA;
	Tue,  3 Mar 2026 01:16:04 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Tue, 03 Mar 2026 01:16:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1772518564; x=1772604964; bh=ZQtI0oD6YG
	nIpZ+OeCyO4imQXF6RhD03jo5azXuG2xg=; b=Sfissseg+771fa3nz6aHRTgWiM
	4CFWGEKXpYwpkEB+W4PSEge5TqOMKKaolnQKe5ZXeutaSk7wKbI4fJHkqnIJQTfz
	TdYH0TDyB8xcDRJpeC1Pu/+O94TnPbKCk4XHgmS7tA+/s5gnNOetQCEM342V7n8V
	rNYKzjWyvvp60VxEO8R8OW0b872qlUlAkibXvUnAv5DNK5wlQuQwl/7o0EHqdHkf
	k61mWioetjs6lBgKzJYatYeA/Qh6xkBPmPWCskrm6jULAC+HKIMuZhyKncqZ5tbs
	202CZnBi5k35t72GkFGvZUBNfj6zCfCs2KlYAjfKxBrKl2uPEfsZK5sp3YzQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1772518564; x=1772604964; bh=ZQtI0oD6YGnIpZ+OeCyO4imQXF6RhD03jo5
	azXuG2xg=; b=nNw6SOmoBonfn0EzpETVhBN86aX1fvP5OiSqkF145on8QCz4l6h
	i/C6jR/dwFkxBHwqte3fmzqEdHOHNO3OYjMT4yxkusB849gmLjmRaeo68+68dIw7
	a2RdMZTIVVMM0dnORPL4hIwOm9oiV3RI4WTgGehMp47Pz+UVqngxQAKFAjpyKGtP
	GnDsJK3jb19On1TnPdJ5QQRFPxW5w3j6EWWvMNL8oclyj+kvDcc2fzsuc/DtRgP4
	X7kcjob5jYSvVexZKjzIbEBHAB261AyDwPjznP7QHWTZRe83w0+yC+UqYpSw4Fov
	y/QSckGs4di+45B8d7bq5M///64fI0fj12g==
X-ME-Sender: <xms:pHymaVvk8XEdMTLpZJq5lcr58g0dMqYS5pgKwnzelz5aZFyOasGybA>
    <xme:pHymaUecnx0cZeH9wpaVHkKPQutQ7WdHP0LQZw7I6FTGqmLplNvxlCXqc0zEeA2lW
    HnKy-vl73S2QkTGQmHuymXZTd6wLiQld7vRkIRA_tryuyUZFdl_Rg>
X-ME-Received: <xmr:pHymaWZKGtu8fD8xJaiBrunSsjZid3RVc5qSUyQgnHZMF76mR9Nk_azih4vUMev4aGdjn0oYHgj01khpF1-zjxcBic53EqxMaW-ER8IWGaZT>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvheelkeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvg
    hrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:pHymaXWa6xrAACzYW66UGkM45kEfSqUu6bZd_KuXINd944jZksuv3w>
    <xmx:pHymaYhfuOaeLAIgZdTy8jX0BZfNzrFrgSjtIwR_TZ8392zEuCgXmA>
    <xmx:pHymaVXITIFBLfs9ZSNIaKYjvXEF2Mu_fBmfb0ebdHEM55-eykGs3Q>
    <xmx:pHymafNcnkkuZfzgXHnyBZrpKkxfqthsjogQndmDHAOVLPBECUTnIw>
    <xmx:pHymaQdt_lIflB1NCBo3IO-UBnVDMnSiEERNAYsHELzhFjtjr3_f8RPm>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Mar 2026 01:16:03 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id e8f6650d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 3 Mar 2026 06:16:02 +0000 (UTC)
Date: Tue, 3 Mar 2026 07:15:59 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] ci: unset GITLAB_FEATURES envvar to not bust xargs(1)
 limits
Message-ID: <aaZ8nyJFjFqct2Ri@pks.im>
References: <20260302-pks-msvc-meson-xargs-v1-1-8e42abd879ce@pks.im>
 <aaXArnhYbtX9gsUU@denethor>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aaXArnhYbtX9gsUU@denethor>

On Mon, Mar 02, 2026 at 11:11:52AM -0600, Justin Tobler wrote:
> On 26/03/02 12:55PM, Patrick Steinhardt wrote:
[snip]
> > The GITLAB_FEATURES environment variable makes up for roughly a third of
> > the complete environment. This variable is a comma-separated list of
> > features available for the GitLab instance, and seemingly it has been
> > growing over time as GitLab added more and more features.
> > 
> > Fix the issue by unsetting the environment variable in "ci/lib.sh". This
> > ensures that the environment variables are now smaller than the upper
> > limit on argument length again, and that in turn fixes the assert in
> > xargs(1).
> 
> So if we unset GITLAB_FEATURES, that puts us at 10987 bytes (17373 -
> 6386) which would be under the upper limit. Unsetting this environment
> variable seems like a reasonable means to mitigate this problem. Naive
> question: is the upper limit something we could increase for the
> environment?

Unfortunately not. Under normal Linux systems you'd be able to do that,
but in MSYS2 the limits are hardcoded as far as I could see.

Thanks!

Patrick
