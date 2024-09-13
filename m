Received: from fout6-smtp.messagingengine.com (fout6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A1E21BAEFB
	for <git@vger.kernel.org>; Fri, 13 Sep 2024 06:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726208106; cv=none; b=dcZ7P3AyApqeDhXMrCMZltCsyGQIOyip30uWhApGXVfyPXOh0HY7/rswupkvvQzGicf1OL+8Eu4pxb57zC+63nFlQbvEJMW2VLvcMn9hVQS1Wlw1GY4M0aGUXFgImkNvPUi11PuBqaDfXOGJBDvqNSWF+/gNdwiHqS26e8tl5zM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726208106; c=relaxed/simple;
	bh=x3ujw2QIKXuCpbJdiQc0D8W7J7lBmrmrnEqlUMPg+24=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YS3sqfyDMnULqn8DQbVojlJbbA6MGerg1giCNNbhXxh+LVExYQa62hTV6LVAogF6Gnb5pzJQBTltxyo4xXHplRcnfO5b2AHenCs+eK6eiIPwzp/KYB8dporqRZ44G1XcEYYMFe9SPKhCtkfc0CuAB0IN59rX3oX4LWupYbLGjho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=d7lPOAS6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bhZsgTDA; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="d7lPOAS6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bhZsgTDA"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 7F9C41380624;
	Fri, 13 Sep 2024 02:15:03 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Fri, 13 Sep 2024 02:15:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1726208103; x=1726294503; bh=KtpbMfMg8r
	PX197hBGZuXxI0lSF6MTU3KLwcr8Re+Qw=; b=d7lPOAS6EAN0vc0m/YQmQ6bczp
	WCXDva+kDinArCIsSsd91NoE4XOb4K9uJGOj11xd/y+CuqjII2PUQjZS8pH9FN72
	Sp8kabUCH3sJmBEz9XzXfDmSbp6cGYF1L/3FCuupE3ZIFN0n9/yaa0amgMUxTFTk
	xyiyErB5xjwTTfCYeRpMptWIJK43W3e8aC9wpNKQ/8r1aZ/7Lsn7G+5TfOEcI/Ok
	eytV7uCM/PnPHTYpbkDhUXFQnvWmZ4OCfxe5N4FGFKE1vim7/KD/epflc0MjbVDz
	f0+5uE5fleu7+N938pEhqvuorUJAzTMDMrOlbjU3iy3DmAoKY2xQ7yWgcNgw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1726208103; x=1726294503; bh=KtpbMfMg8rPX197hBGZuXxI0lSF6
	MTU3KLwcr8Re+Qw=; b=bhZsgTDA0XtszzW8mwjrH3L5VCIxCyCloq4vP8cYI6Zu
	2hvkaBZcXixf4YSprjomeRv2I87rc6kTVU/VGv68nIpW7o1cIFVoApSQRpRTeb32
	KkBYzRfxfMEXJZdeZKClitoW4+98pCAA+CNtDqS4gWrita7XVr3wshsnX4cIz88N
	W4HIuOeEm8rNd25IBJR3CjMuhlb9T339gngfam/MC8Oizj2XanNOw5zkOdI2h5pP
	+yDO2nF8fsiDgvfT7aNDlu/ybFeDMfbGvpcHCzA9n1vDcdcRX9B+rwex1X16nP5B
	XjsVwkwOLIF6VYrs3ve0/DG3KRmik6dk04ubGzb3MQ==
X-ME-Sender: <xms:Z9jjZtsph9Zv_xehW83bdiUKfbpwEDLGegYr5t_fRUDixtWXbJ_BcQ>
    <xme:Z9jjZmewAY8wH-1Jg-taI6oxQRJRtNVYfVZ34d3rfG4tG_apwJhVDl_kSo7467YOY
    5AWdVcpXaBgFpOlWQ>
X-ME-Received: <xmr:Z9jjZgz-iFAZ8yM1V-9Y9kPYc-Qg2ysA8pXe8rsgM3U9V89Dgy4G8CdpfN3hqJydc4Jpe0XSGoNqi_CoCbBc4m6nf9Ye1eU29XE5O5Tanb4r7A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudejiedgvdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvve
    fukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeevkeekfffhie
    dtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsg
    gprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogi
    drtghomh
X-ME-Proxy: <xmx:Z9jjZkNfhj5CT7KZ19Myl4T3-R01-9bs_Qqp3CBwBsJ36AJjvCTp0g>
    <xmx:Z9jjZt-F1ID-R1Fspnz7aEwhZW8fRe6-DyXy2_jEqnKKXbtavBxhqg>
    <xmx:Z9jjZkX2PRePE3-Bq_7Xc9YF2qYlOObJLQPleBZjisqCCGM2hdFl4Q>
    <xmx:Z9jjZudq3eDGQ4_-mCTZtIH3_j7nXL_5gAq4R8XiM5Lh-Dde5EW9yw>
    <xmx:Z9jjZvLPkDHCtB8Bp2jsJG7uk9rP7hoNcn4OZrBsBqCijXPeUdIlAWlG>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 13 Sep 2024 02:15:02 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id c1f8baaf (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 13 Sep 2024 06:14:50 +0000 (UTC)
Date: Fri, 13 Sep 2024 08:15:01 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 0/2] Simplify "commented" API functions
Message-ID: <ZuPYZW3jYas4kJzC@pks.im>
References: <20240912205301.1809355-1-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240912205301.1809355-1-gitster@pobox.com>

On Thu, Sep 12, 2024 at 01:52:59PM -0700, Junio C Hamano wrote:
> We [earlier] noticed that a few helper functions that format strings
> into a strbuf, prefixed with an arbitrary comment leading character,
> are forcing their callers to always pass the same argument.  Instead
> of keeping this excess flexibility nobody wants in practice, narrow
> the API so that all callers of these functions will get the same
> comment leading character.
> 
> Superficially it may appear that this goes against one of the recent
> trend, "war on global variables", but I doubt it matters much in the
> longer run.

I'm not quite sure I agree. The comment strings we have are in theory
broken, because they can be configured differently per repository. So if
you happen to have a Git command that operates on multiple repositories
at once and that needs to pay attention to that config then it would now
use the same comment character for both repositories, which I'd argue is
the wrong thing to do.

The recent patch series that makes "environment.c" aware of
`USE_THE_REPOSITORY_VARIABLE` already converted some of the global
config variables to be per-repository, because ultimately all of them
are broken in the described way. So from my point of view we should aim
to convert remaining ones to be per-repository, as well.

> These call sites all have already been relying on the global
> "comment_line_str" anyway, and passing the variable from the top of
> arbitrary deep call chain, which may not care specifically about
> this single variable comment_line_str, would not scale as a
> solution.  If we were to make it a convention to pass something from
> the very top of the call chain everywhere, it should not be an
> individual variable that is overly specific, like comment_line_str.
> Rather, it has to be something that allows access to a bag of all
> the global settings (possibly wider than "the_repository" struct).
> We can also limit our reliance to the globals by allowing a single
> global function call to obtaion such a bag of all global settings,
> i.e. "get_the_environment()", and allow everybody, including
> functions at the leaf level, to ask "what is the comment_line_str in
> the environment I am working in?".  As part of the libification, we
> can plug in an appropriate shim for get_the_environment().

This here I can definitely agree with. I think the best fit we have in
general is the "repo-settings.c" subsystem, which is also where I've
moved some of the previously-global settings into. It still has some
downsides in its current format:

  - It depends on a repository, but I'd argue it shouldn't such that we
    can also query configuration in repo-less settings.

  - `prepare_repo_settings()` makes up for a bad calling convention. I
    think that lazy accessors are way easier to use.

But it is a start, and something we can continue to build on.

Patrick
