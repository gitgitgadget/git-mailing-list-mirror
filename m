Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 514A316F0DE
	for <git@vger.kernel.org>; Wed, 21 Aug 2024 23:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724284292; cv=none; b=Ksyvf0BIEl9VK9QxzmiWbM+lDnA0+DUYiXsyTga3d6/PgXP1TVH5fCnlSaZqGngalw535B1DkPuLMfkHFVtwuIJPfsauI4Xamd+h8lbt6hIct6J5sXO4o1QyASAODfaXBIMd3Z5WbL++xhxwuiWmiUZGCshB3F2mpuBjFzXGjtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724284292; c=relaxed/simple;
	bh=QISifeU+0sHGnnzt4yFI2uvow8qgCdjqLUVIqqeaXw0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IUWInck72SPdiIo5TaL2d03vra3a38pKKBBANd7cYrhARmUaWBeck5seOwOlqaoNV+Dlc+aZ+sjuDuhUZOrAOs2dJLjJBkTJJfb5y4cO6/mfRaA2n3PaP0M8SbMZxyrM9bbiUth2x1bhowip3zK9lDEF66LcBWgaStq8jw1swYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=WcjHWqGw; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="WcjHWqGw"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=QISifeU+0sHGnnzt4yFI2uvow8qgCdjqLUVIqqeaXw0=; b=WcjHWqGwnNtlkn9EHpm9lNc9/6
	c+Cvj4PGaUqv8UCPQRgq9VwTpHSEokNRVkecTuTjuCjDwvf3nEfGvARixqxQ9I2uvHeSd3xwt8rRI
	WsT1mpPbTM3AQfgf5VFHZRZOc1TevmZ7we+hih1dg+r0AZt4UpNmMat0sb1/8UcaVCfaHOrh68/TT
	WXjqyiHfxFOuxZSq3t3xpqExencqaISB0yC5XpMjhzVInAtGyKnoYsNfm3qb4In0ZAyWEm8t96ShT
	r0uIlteP7FRFnZbBPT5SehbUQQsE96mVhx7sZhqLAAe6Us2qRYhRQRvNMu5RItSf5f7sLC8E5JLEu
	AZqT7lyA==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.94.2)
	(envelope-from <zeha@debian.org>)
	id 1sgv6s-0078Tu-0t; Wed, 21 Aug 2024 23:51:24 +0000
Date: Thu, 22 Aug 2024 01:51:23 +0200
From: Chris Hofstaedtler <zeha@debian.org>
To: rsbecker@nexbridge.com
Cc: 'Simon Richter' <sjr@debian.org>, git@vger.kernel.org, 
	debian-devel@lists.debian.org
Subject: Re: Representing Debian Metadata in Git
Message-ID: <z574b3k5mld3oshnlwho5jlpvgagkra6p2kmy2fe6urfhvtjeq@fivivkehco4o>
References: <eb963843-9e2c-49f2-911f-fa36f33f9bfd@debian.org>
 <gbgpxxpikhkykvhug4ugbufqm6bdh44ygiknpzc3khalibwutk@jlebwg4vsvjt>
 <029801daf41f$7e994b70$7bcbe250$@nexbridge.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <029801daf41f$7e994b70$7bcbe250$@nexbridge.com>
X-Debian-User: zeha

* rsbecker@nexbridge.com <rsbecker@nexbridge.com> [240822 01:21]:
> >> Any feelings/objections/missed requirements?
> >
> >In the current DEP14/DEP18 discussions a lot of discussion was had about how we
> >should represent Debian things in git; your mail also goes into this direction.
> >
> >My *feeling* is we should do the opposite - that is, represent less Debian stuff in git,
> >and especially do it in less Debian-specific ways. IOW, no git extensions, no setup
> >with multiple branches that contain more or less unrelated things, etc.
>[..]

> On the other side (perhaps), git is increasingly being used in the Ops setting for
> DevOps and DevSecOps. Production configurations for high-value applications are
> moving to storing those configurations into git for tracing and audit. Git is an
> enabler for good production operations practices.

Don't get me wrong. Yes, we should use git to do what git is good
for (tracking changes, etc).

We should not invent new ways of using git that no one else uses.
I'd like to reduce the delta of "how Debian uses git" to "how
everyone else uses git" to, hopefully, zero.

Chris

