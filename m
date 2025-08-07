Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 804031F4198
	for <git@vger.kernel.org>; Thu,  7 Aug 2025 05:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754546129; cv=none; b=DvlcZ/onffw97t3rsINgybZosLalTLKDEUh1HuOlv8u7vPXcEzuVCoeSmQdVgYfCp9lS2GP9+DO2YNlvNirTNTpfBlpd04IosKDmTxWMCNI9mxJFN1gdeICSwDfGgp8Sao4WVfXeKEu72rvBp/+Een2msq6fcawcOYGAA3h/Toc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754546129; c=relaxed/simple;
	bh=O2WuiSELz3VBf5qqbabJPnkGXNAXgv3JYmVIiTWKpec=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KJWCNMf8xWDajr74nlmPgBvxhpU7H36kCMqtlyPZaMwG/MzvKEh8sRc+gaSTRZH7vAMYe14HTlLHJX5Ul4wu+6pTeHj627wkYzRGhS9W5jpR+50mNmgRYbSi+WQXFg74iM/+qnaQ1bupDd7aVPnShwArIOUJNU+Y7uYFa9yO7LQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=TPqP3DPn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Frv0iV30; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="TPqP3DPn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Frv0iV30"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 8B6F614000EA;
	Thu,  7 Aug 2025 01:55:26 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Thu, 07 Aug 2025 01:55:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1754546126; x=1754632526; bh=LRw7ODgUgC
	hwz5BpjnCjDGlNh/hWAXfbZ5/VnlhIl5o=; b=TPqP3DPnep3Jyk02klf6/AoKLG
	2P3Cdpi2c1BkSXSltSXJMRce/QLGig/gz4BBbEDLpP/OUIVZWa8D4LoBJJzs+XVj
	Ez5ybelPwQ5JAZzZEyJe4p0uu2eZPS1WhIsgecMpCCb573ey2D+ZeH4V9qT+UKvD
	N8mXJR/SkLtT1eHuMy8vSZJvMp4vSHI/Z0jQ0GdwOXxAjmMRNF6sNQk0Dm3DSJGb
	/U1pIPv3GrLStuwgsOg9+YNaVKNhm5qj1AUVOkBaa64dZz8gsnv8akyw6/+xKFpK
	rS6OiPAPL+iQLPnOjev0itThj8adVzGa8d3j2EpDv48VnB+f502egkIGX8zA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1754546126; x=1754632526; bh=LRw7ODgUgChwz5BpjnCjDGlNh/hWAXfbZ5/
	VnlhIl5o=; b=Frv0iV30ItnOfd3gGYzWg5E0fPJEAPaf+rrDCsHioFuM9NaRQ/U
	MN4d6k/duSl9yVxmBcDBClnBWl8/EE+ivmKQ+jWjqHccd6vSZWfPVQ55IkXtvlbR
	FNdMpgqPxWWq2T+lO52lmi38iGAvIudgtE0TyKhOHZdZP4ru43PTJi1AKIHvDz9v
	rT94/qFIDcOkbBmrYjnACHL+EBqjd9FJGm+l2NOrdpp6FhPB8UttzBL/FdUL62zC
	K238vViSxwGmp6S3FQuvMEZTWoXbq0Ji7YjEUIWgvJHeZWwbBCD+xU9hUsD95AuZ
	cdJ2/8Ocal6Qm7ze+pKgEw8Q0u4xeQ5s0WQ==
X-ME-Sender: <xms:zT-UaGCalssZWATJRSOT1mDWrrQPSRi4P7o7vaMahoSNZUWoDFOqNQ>
    <xme:zT-UaLEIPPwj9kgisMKXi5hm1JULs5ehAlDI3rHhGqH28y2LpGp-Hv7vpZLIZXMXy
    R00lgP-lB_kwru9bQ>
X-ME-Received: <xmr:zT-UaGLHqq9WxoQwYUxJ9YZGV4r4jz50DcKmL2ZlqRfDMWsnPcM5018M581AzBBLA89WhIaGsEbchzJoby6F6nXT_47CPRcO8XLkgvmCSQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduvddtudehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepthhoohhnsehiohhttghlrdgtohhmpdhrtghpthhtohepphgvfhhfsehpvghffhdrnh
    gvthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthht
    ohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:zT-UaHkmcrIeBDyl6FvV3pIJLQ1mqjzUrMbtNvBFWMB6QIRdaj3i2Q>
    <xmx:zT-UaGRlTT2PjWqbFXtqf9lmy1qHJhSJeWPqyOM5ozdM6talspFCvA>
    <xmx:zT-UaBIXJ1uZKNOUtcbR0tK9XhXh-vPj3JLgG46lC0b-kELDaEym_A>
    <xmx:zT-UaEDlI-oirXS6tKqhqEI_yRE5leZ_LYjOUfETeB3P4RttkClhmA>
    <xmx:zj-UaMSRKIul_DCto0efGBU2yMdR_cQMTcO6haHtSVhwsH5OLKm-IyZZ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 7 Aug 2025 01:55:24 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 64951706 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 7 Aug 2025 05:55:23 +0000 (UTC)
Date: Thu, 7 Aug 2025 07:55:19 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Toon Claes <toon@iotcl.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Justin Tobler <jltobler@gmail.com>
Subject: Re: [PATCH 3/3] diff: teach tree-diff a max-depth parameter
Message-ID: <aJQ_x787aceaudef@pks.im>
References: <20250729-toon-max-depth-v1-0-c177e39c40fb@iotcl.com>
 <20250729-toon-max-depth-v1-3-c177e39c40fb@iotcl.com>
 <aIm5x4kah8608Ba5@pks.im>
 <87jz3gtshx.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87jz3gtshx.fsf@iotcl.com>

On Wed, Aug 06, 2025 at 04:49:30PM +0200, Toon Claes wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> > On Tue, Jul 29, 2025 at 08:57:44PM +0200, Toon Claes wrote:
> >> diff --git a/diff.c b/diff.c
> >> index dca87e164f..c03a59ac3b 100644
> >> --- a/diff.c
> >> +++ b/diff.c
> >> @@ -5894,6 +5909,10 @@ struct option *add_diff_options(const struct option *opts,
> >>  		OPT_CALLBACK_F(0, "diff-filter", options, N_("[(A|C|D|M|R|T|U|X|B)...[*]]"),
> >>  			       N_("select files by diff type"),
> >>  			       PARSE_OPT_NONEG, diff_opt_diff_filter),
> >> +		OPT_CALLBACK_F(0, "max-depth", options, N_("<depth>"),
> >> +			       N_("maximum tree depth to recurse"),
> >> +			       PARSE_OPT_NONEG, diff_opt_max_depth),
> >> +
> >>  		{
> >>  			.type = OPTION_CALLBACK,
> >>  			.long_name = "output",
> >
> > Okay. We don't use `OPT_UNSIGNED()` because we also want to impliy the
> > `recursive` flag. Wouldn't it be simpler though to use `OPT_UNSIGNED()`
> > and then set the flag in `diff_setup_done()` like we already do for a
> > couple of other options?
> 
> But how would you determine `max_depth_valid`?

Ideally we wouldn't need it as we could just initialize with a default
value.

> And, without realizing, you touch a good point here. Looking at the
> git-grep(1) docs, it says:
> 
>     For each <pathspec> given on command line, descend at most <depth>
>     levels of directories. A value of -1 means no limit.
> 
> And:
> 
>     -r::
>     --recursive::
>     	Same as `--max-depth=-1`; this is the default.
> 
> We should handle -1 the same, that's currently not the case.

True. Do we have the same default? If so, couldn't we drop
`max_depth_valid` and initialize it with -1 from the start?

If that's not easily possible we can just stick with what you have.

Patrick
