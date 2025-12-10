Received: from mailgate01.uberspace.is (mailgate01.uberspace.is [95.143.172.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BFDB2DF128
	for <git@vger.kernel.org>; Wed, 10 Dec 2025 10:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.143.172.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765363095; cv=none; b=q+0q1M1nCaYsOVBrcH+wfJZ075hGnczVKOCpl5kTzc9obO6S5iHjOeliHPCNdhJegT1yetJp219JzfsSqiSR3U5GDcIF6O3tTWuNz714yjoVpUyOf68RuLERAYSEo1RlySZndbuHK2C57SZxukCutXtZ7qV7bw/DqiO7E48deaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765363095; c=relaxed/simple;
	bh=72F2G2PFd6AhcwtjA6+ECx6GaTKjUVGliUXpTJ4HACU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LSFLFh2/zRxfnuXATgtW9r9v+E1inYLGG3K8WiL7paa9j3F2BBi3zqJEVPrKcOdQgbnBq3xtIL4+Y7nF5/ZIl+uGrPNbWMBWZ5VFWGZD+t1vFhuAUoEZ/qY2f5dPJJUdlgX+vaC/h0hcsXe0EYMRZCGP/6WUubLPY54Ha/KfMVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=beyermatthias.de; spf=pass smtp.mailfrom=beyermatthias.de; dkim=fail (0-bit key) header.d=beyermatthias.de header.i=@beyermatthias.de header.b=ZR7h2TSN reason="key not found in DNS"; arc=none smtp.client-ip=95.143.172.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=beyermatthias.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=beyermatthias.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=beyermatthias.de header.i=@beyermatthias.de header.b="ZR7h2TSN"
Received: from cressida.uberspace.de (cressida.uberspace.de [185.26.156.202])
	by mailgate01.uberspace.is (Postfix) with ESMTPS id D57C160B6C
	for <git@vger.kernel.org>; Wed, 10 Dec 2025 11:38:00 +0100 (CET)
Received: (qmail 7107 invoked by uid 989); 10 Dec 2025 10:38:00 -0000
Authentication-Results: cressida.uberspace.de;
	auth=pass (plain)
Received: from unknown (HELO unkown) (::1)
	by cressida.uberspace.de (Haraka/3.0.1) with ESMTPSA; Wed, 10 Dec 2025 11:38:00 +0100
Date: Wed, 10 Dec 2025 11:37:58 +0100
From: Matthias Beyer <mail@beyermatthias.de>
To: phillip.wood@dunelm.org.uk
Cc: SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>, 
	Patrick Steinhardt <ps@pks.im>, Martin von Zweigbergk <martinvonz@gmail.com>, 
	git@vger.kernel.org
Subject: Re: [PATCH RFC 00/11] Introduce git-history(1) command for easy
 history editing
Message-ID: <paqf2ko6kcm5qdcqxqz57qu6gjw3vf6boabjsryeugfnlzzb7z@4dzqo6jug6l2>
References: <20250819-b4-pks-history-builtin-v1-0-9b77c32688fe@pks.im>
 <CANiSa6gXbrZaMLVq-AAg38sm+7qgzn4w98WWowLtUHA2P+BdLw@mail.gmail.com>
 <aKs3tqjE510MF0T-@pks.im>
 <aMsWL2cSoytbmRjA@szeder.dev>
 <4m6rmefbv4hftclimitz5rp6yapswjtnjsxymrsdkuan4jbg3u@dm5jzdiq5cxz>
 <bc01706e-b9cc-4cd4-953a-971a3ccd6c79@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bc01706e-b9cc-4cd4-953a-971a3ccd6c79@gmail.com>
X-Rspamd-Bar: +
X-Rspamd-Report: SUSPICIOUS_RECIPS(1.5) MID_RHS_NOT_FQDN(0.5) MIME_GOOD(-0.1)
X-Rspamd-Score: 1.9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=beyermatthias.de; s=uberspace;
	h=from:to:cc:subject:date;
	bh=72F2G2PFd6AhcwtjA6+ECx6GaTKjUVGliUXpTJ4HACU=;
	b=ZR7h2TSNDqVokE+OAIcnsKIuFisILKQ+fYgPNvJv0+Sc5nzcL6+CFqM3p8ARPwG7HxHwWmUuvD
	BLsUgxnABrD0Uir+mhhgAfDeO/hozbSXNvHSTSr1jt3Yf6tahZlPiGoJLsB+TZAdlLZfrnc1jJDc
	ChtOxE1vRPjcQYvFDbH5+2LkNk93kAOMVd/FdlZu4q81UmrvyJ2zne8xH0omMbgA0+CdDLZkxK/s
	zZaegqeDFxUL/ZTXVnPqziOW9+LltN5CkI+IrGquXzUOmw/vp3PpM7GWy21fQRxO6xHvBE3aW2gG
	pTPCvzq6hDqe6kEfjNrhKQdxS53WR9K2Zo1OKieauVqm6KVz6QQwN6i1+rAlj3US2aJshAWEijT0
	ozOBfTUSsH5l6jkX6akKXprrb0oq2shYmSVPSIN2JTxyK0NtxYvVFvBSZvuFdU1JT5TpS+KatEzY
	8DRAzIDvdkS3H8fVZQyTfHxymDn370NQAaSwLNfVwUiYgxMb9iOYeEk6NaK2Kjo8WFpVEBz+loiH
	ICqIb4UC6tJYjDIwH4eY+iz+Oq1zIJAbXXC0SLcCuHYpZWeLDZbT8OENnTOneF6hQB+XWbmGi3Ee
	TFZYJFDkZwIKpiwlvAV1/r5exJJ7S8B2n+L7kIyKxgwrYd8oZU4iOq8UIQI1DKwWbP8ebXf0R7Ck
	k=

Am Wed, Dec 10, 2025 at 09:58:13AM +0000, schrieb Phillip Wood:
> Hi Matthias
> 
> On 03/12/2025 18:18, Matthias Beyer wrote:
> > Am Wed, Sep 17, 2025 at 10:12:31PM +0200, schrieb SZEDER Gábor:
> > 
> > > Let's suppose I have this piece of history, I'm on 'branch2', and I
> > > drop commit B.  Which commits will be rewritten and which branches
> > > will be repointed?
> > > 
> > >     A---B---C---D   branch1
> > >              \   \
> > >               \   E---F   branch2
> > >                \       \
> > >                 \       G---H---I   branch3
> > >                  \
> > >                   J---K---L   branch4
> > > 
> > 
> > Just speaking as a user here, but my expectation in this scenario would
> > be that rewriting B would be denied by default here, as branch{1..4}
> > would be rewritten although I am at branch2.
> > 
> > In the scenario at hand, I would expect that I can only rewrite G, H, I
> > while on branch 3 and J, K, L while on branch4 (without passing some
> > extra flags for "yes, please also rewrite the other branches").
> 
> Is that because you have branches that you don't want to rewrite because
> they've been merged upstream or is there another reason? If we start
> rewriting multiple branches we should probably check that we're not
> rewriting something that has been merged upstream but if I rewrite a commits
> that's an ancestor of several branches it would be very helpful to rewrite
> them all at the same time to keep them in sync.

Its mostly because I don't like too much magic and because I think being
explicit is always better than not.

So from my POV, I would expect "the simple case" to be "the simple CLI
call" and if I want the tool to do magic and "rewrite all the
things"^tm, that I would need to specify a flag for that.

Best,
Matthias
