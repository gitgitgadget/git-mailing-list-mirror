Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B903C849C
	for <git@vger.kernel.org>; Mon,  1 Dec 2025 10:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764585171; cv=none; b=uLAjJCEj17IbUT95whgcblk8d7oaWUYNqPxeIV19OGBWE0Teb5pSnSv2zEnuIyS0Knqcd0h6q+y6kdIei0G5D1RQDhuqgjquZ4IOXz6hdfqfyG2jAjzLwYdlym7bVDTNPrFvKXOyEbKinNmG2BgORhhvHTUKGVvw23BzV0jm2xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764585171; c=relaxed/simple;
	bh=+EyPuR4F9csGfs/KMIPe789DMu6WZnXF7KVvLKH7Wq0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RWjCITMmkJqj/BcsevqWjnSU/7Obn6ReVPwPnYCEyPkPAIoipRPsFfDJTQ3GHLt+AlmEnCuLmLDLc4v1W9mdFhoi5KYEaJgKQA41B4VkTDRKjqB0hlQ7px3/xPO6wsxCbsGTwWYyWq1TdZhMdHUXF9qJvily5pog0bgi+IH+tNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=U+tUeVZm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GpkDqdeO; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="U+tUeVZm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GpkDqdeO"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id A6DE3140001D;
	Mon,  1 Dec 2025 05:32:47 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Mon, 01 Dec 2025 05:32:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1764585167; x=1764671567; bh=ESBgBoe+YR
	sP4Uycz2NEaNYAx6LdffY0nmXwrAFR3ik=; b=U+tUeVZmuR6I2gxTreGsEvYLL/
	tKHfiwuA1EJrGTvVXkW9T2YHcsxiBZqZ8uzrmNhKf59F85FDQpgl2NPBG6v2Tkad
	THozQhK/w7hUsm9wFE3UOV5bLKc4gBl24g2BI+0cL7jMh9Z3Jqt4NY0vvQwJJMwg
	CjWVTbzHR8VSJhP94sk/7zeGO8Q2cdcuC4X+WwH1tK4rjvh1CB51v3UmSaiRsDMB
	IocEhdNrxmBodJWuSpKXLkxR43zGbF0IWaldX5CNOu5LHlpDtOg1CMJfjqwcPCX9
	rYg6JFIWAcy3UkjZ31hG06McB9dhh2nn+nk7Adpa9rItUi2mS83Y3LRq1VmQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1764585167; x=1764671567; bh=ESBgBoe+YRsP4Uycz2NEaNYAx6LdffY0nmX
	wrAFR3ik=; b=GpkDqdeOOT+UO/gc4ppAB89D/JPYE4nJDZK3XnJY7ygO4Lg7BM3
	l7j1KYQUWRNYqoBPBI3t+P8NJyqkX2mz1Ff0OtDkTwYNRyr40DvTFiy3viTcvSbg
	LBoZId8KJkf6l8qvzOfhs7qJ+VGBX9V+Y0Wk58kCuTadVwNpK+Ms2w0nblYNItiP
	shpPw8g6WAg7yo+6BbJU1cMZYC7Hpm7xEdUDRjttW1NJRwmoYcuk0eQumqY5EAAk
	jeEVgQOVGYVInr/4I1NC9sPE48qrPy+Nmx7Dll2ygeQ4KIQXLUDqUwToqCNhBYg0
	mkrT9TkDOOqzSFGqyoCEPbq+dzdwolHPqSQ==
X-ME-Sender: <xms:z24taRcwoQU352tfgoi4KxiE8SyjXTprXKStt949kVkV7QjQIvIgCw>
    <xme:z24taWob3C9swXZzdP3ujxb_927j8zKCWSdHmyP1bSvp46nqvKvAzXPPcOP-nnfO3
    oAPejUU92QM8QFeex_Ibf57NR5Qy99pDUL24jepjE4vMJuniBHLIw>
X-ME-Received: <xmr:z24taX7wjofTan37UTp47uurjXHUhThNT26zSvK9jjYkdwp5yQLDbIbjCVOPuze_xmTAMmsJxAaGaIDLbcNcQxdvV-vmZrpPhijTr1G3>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvheejgeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehtohhonhesih
    hothgtlhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:z24taUod4AQHSPspmxV5ZcpTOsogxyHLAhWisKPcby-YT3eJqRyMlg>
    <xmx:z24taRhwVgSgPyZMzNeunYEBNAcXTxLkuuKzzKZJBymOYrGCwLcgQQ>
    <xmx:z24taWLLNLLWuz0N3uXZBbvRlLi5sOuhMDNwN7WJPdYPz-PblZMtvw>
    <xmx:z24taZCuXzf7EYXFQtEoq0re76eFhxUmMQGv10sleYyV6mK-U02d_w>
    <xmx:z24taSQySMZQuY2tNk4fdbEumKQsWakeKz7pvrpV6Jqd6s_YaI8eEHUY>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 1 Dec 2025 05:32:46 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 509555aa (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 1 Dec 2025 10:32:44 +0000 (UTC)
Date: Mon, 1 Dec 2025 11:32:37 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Toon Claes <toon@iotcl.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH 1/3] last-modified: handle and document NUL termination
Message-ID: <aS1uxbvNE6rAQ1dl@pks.im>
References: <20251126-toon-last-modified-zzzz-v1-0-608350df0caa@iotcl.com>
 <20251126-toon-last-modified-zzzz-v1-1-608350df0caa@iotcl.com>
 <xmqq3460pw8y.fsf@gitster.g>
 <87tsye0z61.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87tsye0z61.fsf@iotcl.com>

On Fri, Nov 28, 2025 at 07:50:30PM +0100, Toon Claes wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
> > Toon Claes <toon@iotcl.com> writes:
> >
> >> When option `-z` is provided to git-last-modified(1), each line is
> >> separated with a NUL instead of a newline. Document this properly and
> >> handle parsing of the option in the builtin itself.
> >
> > I think documenting does make sense, but it is not clear from the
> > description why it is better to handle the option in the builtin
> > itself, instead of letting the setup_revisions() take care of it.
> 
> I know it's silly, but I wanted to feed these options to
> parse_options(). Doing this would make them show up in `git
> last-modified -h`.

I think that reasoning makes sense, but it's certainly non-obvious from
the commit message. So if you expand the commit message with an
explanation the change becomes much more sensible.

Patrick
