Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C30B1219A89
	for <git@vger.kernel.org>; Fri,  7 Mar 2025 12:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741352386; cv=none; b=lvdA6jSoMlESKU6E5Q2sxIL6Zq7W0ST2LY1XJP6nAf+IRgwHOku2xjgzEBpLEFL03HjyX9MDIVlk9QTGp6gGRAT/7TgowhFBKl0dE1CnNcb6FKdtXA6TQHvq4v+SeDsEFujO6WeCemeiHLmjTeWB7mXmVeFeYx81AQQ9Tl9EJBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741352386; c=relaxed/simple;
	bh=7YlQomHoUEVzWfrrxyXVR2CKopsCOz2Lkb+zframFE4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LT4OIrqVptcP+VJkQPqft6VfVRlkvXzgksuqTHiKuTC+4txcYd8PN/uSt37y4+9Oht+t83ZlqeJy90lKrNxyV5FUvp89+RQVuRLEwv2diZWjRfEMHtcoTzXSBNUVEvjQwk0PH+cq76nAZRMxkpbwB35e8yddx2CHwObypq3Gzo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=c0Xe41Hj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=swoo8riK; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="c0Xe41Hj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="swoo8riK"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfhigh.stl.internal (Postfix) with ESMTP id A793B254014C;
	Fri,  7 Mar 2025 07:59:42 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Fri, 07 Mar 2025 07:59:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1741352382; x=1741438782; bh=jD/zWWbpEP
	ltdvl8lrMwrT+gQ3/NWOfeChcwdJzVY+o=; b=c0Xe41HjTiAWIyId8tdqn1Af5x
	t9jGl6H2Jv6bjkEp8gM5qinZxT7QK7WR0pW9R4a55VTz9P4JuLpCTL8j2lOacqE7
	gfg7SIaNbNxYMj3tfbsXPbyxTjoMl49ygIb4ZgRFLvAhmHT7N5fPF65TnSXfsnBB
	TXPuzWUlMgKRtCvpJvTZruUWJb/Md8K2/LBEBnZ8pk1KCKt6X8Ph9n9nYMeYKnGw
	kugk8toj3U98wTTz6kvy9r9OVziCaHkDOEz0nOQ6FckmfC3UM743o27PnL4N8WI5
	ednQIEwW5Z7SBNVkt6vmH8wpQNIFQQOmG9A/NRFG5fv33DpZXbbdK9tRSvdA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1741352382; x=1741438782; bh=jD/zWWbpEPltdvl8lrMwrT+gQ3/NWOfeChc
	wdJzVY+o=; b=swoo8riK09IcByi1pLvBKvGjn+sKm/tXzZuwE4OmBDcNLncm4vq
	J4GI3zFD6qbiixg23Ze/OjnajGijmnRaMkqjeFWUR2ioy2PO7J+p/vP5EeyZp22B
	mlpIUWPso95b0SyLZBvLcxAy6nHz9iuiJVBg9ZptOCHOnSbUIhHAi2VAWlTdsxw3
	ILzCoJw2VGd0VWuy+w2ehIyLZI80aF4Asyozeg1IGXhk/WcN4TlU4DYqpPYOlHMI
	w+/j443sQiCmSw0g28HFUPRsG2HwRgzQQG80eRl81E+XSUQy7TehOnvm7FFvOFsC
	GvOx3LbrSlKbShAySHU9de0qpwSgLcZPJKg==
X-ME-Sender: <xms:vu3KZ-c-knl--yE9wARxRofJk99_DNTfSOvHWX2GpVqfdtApEVB8IA>
    <xme:vu3KZ4Nusr6s473_Gz_VgTtQR7tIjnsUS5Q5WcBAr2gxLkpSWqmC9YJemUlQyFGqR
    t6BWwe8GAoeT-Hitw>
X-ME-Received: <xmr:vu3KZ_gXZ_P-X5ALhdBHwC6jpGTtZjBbOUQeIXYDgxUXPv_7BDn4pRLbapz74KcneifUmCoyQ8IZuZYWTNBFZZKAy-ecf2ZWenjnHVrrYJqg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduuddtjedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefg
    ueegudfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:vu3KZ79w8a88ELX1oR3LRDlbvVZI9bwmhmFodnO0C_lFz2wzIl_xoQ>
    <xmx:vu3KZ6tfcKMyEe1RLanGLis9dE1xWERbYq-UKGY8S2YRIMJ7E0t_oA>
    <xmx:vu3KZyH6VokIUmZ1-Xgn_0ZSTcnb1FkFzh5idAg-kMqZScPPVaQwjA>
    <xmx:vu3KZ5O3y0UuDvD_3fVwOwtqkX4OF-Ykp6m_Gc7jU38_EvKCk6go1A>
    <xmx:vu3KZz6XaaLb3biz7Py_uxuVUPdpRE-MrDCHvhF2qEUlesJG1daHSuPG>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 7 Mar 2025 07:59:41 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id c1f31ddc (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 7 Mar 2025 12:59:38 +0000 (UTC)
Date: Fri, 7 Mar 2025 13:59:37 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 2/2] reflog: implement subcommand to drop reflogs
Message-ID: <Z8rtuZysCngh5FQd@pks.im>
References: <20250307-493-add-command-to-purge-reflog-entries-v1-0-84ab8529cf9e@gmail.com>
 <20250307-493-add-command-to-purge-reflog-entries-v1-2-84ab8529cf9e@gmail.com>
 <Z8rdg90kxmKHHbyh@pks.im>
 <CAOLa=ZSMLwt53TwziCe71UbKWgRyNgg5VvUwTUUDkN60ymmFPA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOLa=ZSMLwt53TwziCe71UbKWgRyNgg5VvUwTUUDkN60ymmFPA@mail.gmail.com>

On Fri, Mar 07, 2025 at 06:53:31AM -0600, Karthik Nayak wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> > On Fri, Mar 07, 2025 at 12:17:26PM +0100, Karthik Nayak wrote:
> >> @@ -447,10 +456,56 @@ static int cmd_reflog_exists(int argc, const char **argv, const char *prefix,
> >>  				   refname);
> >>  }
> >>
> >> +static int cmd_reflog_drop(int argc, const char **argv, const char *prefix,
> >> +			   struct repository *repo)
> >> +{
> >> +	int i, ret, do_all;
> >> +	const struct option options[] = {
> >> +		OPT_BOOL(0, "all", &do_all, N_("process the reflogs of all references")),
> >> +		OPT_END()
> >> +	};
> >> +
> >> +	do_all = ret = 0;
> >
> > Can't we initiailize the variables directly when declaring them?
> >
> 
> We can, let me fix it! I'll also move the initialization of 'i' down to
> the loop while we're here.

You can also avoid declaring `i` here at all and just declare it inside
the loop.

Patrick
