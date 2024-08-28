Received: from fout3-smtp.messagingengine.com (fout3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB41616D300
	for <git@vger.kernel.org>; Wed, 28 Aug 2024 11:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724844762; cv=none; b=ZLP2atiywGfSU2D1Ip8Iih6rZW860773qNGxqPgNj5gz/vrGS/x45V+jXppwlIquL8ZFr9YiCnvzxvUDFFSVfV2Z0j6JIxZ73NJjg3rDNWMh496+3xjUnpskiVwUvcwO+NLWgEE1kMQUKw1p84iTtxp2OGxvpkPNj3HbkiLXZ9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724844762; c=relaxed/simple;
	bh=UmSd4xejagquSOCjYoxSfiRr+2bejO9a8dhZfkpSyLY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X6NlSd1yYKcaDBxrmQwkEzOBUKpzs28EZs5yK3nWxtmvPsDflt1nd28N4xtpGUrmsFdEhXtA+wU4Mnr2QZEYoqFcOd2/a7XgXAeZzRYeyVMOtvBDMW2YZAzTwJwXJL1HD20XvyUkQsPY41+phUrMg+pAfIR1nHS98q+vK+PsbK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=N5/kyedR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dzZcCJc4; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="N5/kyedR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dzZcCJc4"
Received: from phl-compute-08.internal (phl-compute-08.nyi.internal [10.202.2.48])
	by mailfout.nyi.internal (Postfix) with ESMTP id E9638138FFC2;
	Wed, 28 Aug 2024 07:32:38 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Wed, 28 Aug 2024 07:32:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1724844758;
	 x=1724931158; bh=aeizOY/8UIQzh0dE+wHSiOQYFGuR7IquIWJmtT0P6Ww=; b=
	N5/kyedRUweM7V9yJNrcoNns6Z34VuhZitDX4gahskQ1IPeKuq2YbtlokxJZ6U0F
	IkKMIMEREBiKNP07i1lfH8DoFPXvY7qKgIHyz4eSI5/+uDnqrAhi5T4D5bFjL2GF
	qgL4zJH0kdzTJ3JaouLSG9leVPpd34Kt2MhMI45OwEbWafXvC4Tb05oQS13PoPK7
	vsCGJ4uJamD9j63GwIO23vvyq3kaeR4MvgMvv9gAwO6HvNrm90nOSt3Tgd4W7cxC
	RcLKT//8r5GultngA02KFZkaDyJX7MhVPVDWCxqJYDtVfoCub9kxWFrlL9S2FMFK
	crBgC5d6QPu/QStdQwEAoA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1724844758; x=
	1724931158; bh=aeizOY/8UIQzh0dE+wHSiOQYFGuR7IquIWJmtT0P6Ww=; b=d
	zZcCJc4zCUMn32BdAIEYPdIAEWJrocy9lXKkjagiFR3dPvP45hGJM0s0lOZi8PmF
	FFDRDbXK7wl3xYPFM+TTJH4n/6N4LSyUeGCjHLKln29L0e662iThm3XgxKmyQ6EI
	j9MevIncX9QUr+rMAo47AhLhOiCDhuWvRbN/GbUg8IISq1Gcz65rCc6LSJj8GTg1
	Rt3uInr2aIStjfIDXxGLbbUWmcSXzGNmZ/1dohpnIlniVfFzUR2u/EvGHOo72gW0
	EZ8XXThGXIVGhOXDWW6KtOUw33y9nRkhwUCjoUc4MBIN2QxawpXBi4t/GTQNMSez
	WAcj7t7IX6GS3il9E/iHQ==
X-ME-Sender: <xms:1grPZjIM2xy-3rBg_D16CDRzd737kqmTuf4SF4qN5wwqtkLXVaIp_w>
    <xme:1grPZnI5R_iRbkpdHc6adzDLWbosJPFGfb4aNY6KPT-csifNn2wRa8s3jY1pgHB6g
    hZZOHTOLlY1e3CtHg>
X-ME-Received: <xmr:1grPZrs5aHzkZNX3k-KuRBt93HojUfrNHQlE4nP46RAsArBn3yNZ-Yy7MscIEl4lVmlHYkilqCB6NflcnHAI2e-b5xBgisgfPTsKBAMS9xDBx5M>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudefvddggedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvve
    fukfhfgggtugfgjgesthekredttddtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghi
    nhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepvdefjeeitd
    etleehieetkeevfedtfedvheekvdevteffvdevveejjeelgeetvdfgnecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnh
    gspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepshhhuhgs
    hhgrmhhsihiiiihlvghssehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvg
    hrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:1grPZsYChkN6oQz-TlHXEvh2Va3WmxpCSoD9Ig5L8iWbUGvGB1_Dng>
    <xmx:1grPZqbWWKVGB3skoZB7e1Lb6VyFu8U1Xmx7d6By4H0uBha86k6acw>
    <xmx:1grPZgAlm40St4yku4RlJbD1jO71yU6uaBCwLAbcyqTNRvoMXrnYlA>
    <xmx:1grPZoZS6jy1NLdrZ-Y-lglwxGSHkS8w-Mqe_7Oz1Pwhks3sDKi0iw>
    <xmx:1grPZpnSjVpY9L_JjsPUJqBh87gWuU494t6udADGnNzv9tCj5TMq0H8U>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 28 Aug 2024 07:32:37 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id a4ca4dce (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 28 Aug 2024 11:32:29 +0000 (UTC)
Date: Wed, 28 Aug 2024 13:32:34 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Shubham Kanodia <shubhamsizzles@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: Improvement: `git-maintenance` to allow configuring of remotes
 to fetch
Message-ID: <Zs8KzG0vzCEDvkvx@tanuki>
References: <CAG=Um+1wTbXn_RN+LOCrpZpSNR_QF582PszxNyhz5anVHtBp+w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAG=Um+1wTbXn_RN+LOCrpZpSNR_QF582PszxNyhz5anVHtBp+w@mail.gmail.com>

On Mon, Aug 26, 2024 at 05:20:50PM +0530, Shubham Kanodia wrote:
> `git-maintenance` aims to improve the health & performance of
> especially large git repositories.
> A part of git maintenance tasks is `prefetch`.
> 
> However, at the moment, it prefetches all objects from all branches —
> 
> > The prefetch task updates the object directory with the latest objects from all registered remotes.
> 
> This seems non-optimal for repositories where users use the main
> repository to fork branches (instead of personal forks) as the remote
> could have thousands of refs and objects from branches that a user may
> not care about, leading to a very large prefetch dir.
> 
> For large repositories, it might instead be helpful to only fetch
> objects on `main` or `master` because those are the ones most likely
> to be used by users.
> 
> To this effect, git maintenance should perhaps expose a
> maintenance.prefetch.refs setting that subsets prefetching only to
> certain references.

I think that this makes sense as an addition. We would have to think
about things like globbing and whatnot, such that we can say e.g. to
prefetch only tags, only branches or only a subset thereof. We may even
decide to use refspecs here, which could be the most flexible way of
configuring this. We already use the default refspecs anyway -- the only
thing we change is that we prefix the refspec destination with
"refs/prefetch/". So allowing the user to override the refspec used for
prefetching makes sense.

It opens up another question though: if you've got multiple remotes in a
repository, do we also want to make it configurable which of these
should be fetched from? And if you do, do you want to allow configuring
refs to fetch per remote? I guess the answer to both of these questions
would be "yes".

> Is this something that has been raised before / is in works by any
> chance or something that would be an acceptable contribution?

I'm not aware of any discussion around this, and think that this feature
does make sense indeed.

Patrick
