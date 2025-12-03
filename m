Received: from mailgate01.uberspace.is (mailgate01.uberspace.is [95.143.172.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEF6C398F98
	for <git@vger.kernel.org>; Wed,  3 Dec 2025 18:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.143.172.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764785903; cv=none; b=MReLy8JeTtYtjf27AGe0i7/1DKl75sm52BseCOPl6LQ4Ll0PE3HnefK3yNkuKmpz3Wz+pBu+OPMUgvRzYF3Ax0h0Du3Sl/3FPai+0AQyQtdkSmFNTtfv0oyyuX3jc9TghlLGHWmdkGzdCcB3vufYgGsWHGXOxOo88cOSWJFArPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764785903; c=relaxed/simple;
	bh=qqGmC3b8LBGCn+t2AxrPxv4z5oUFy+KT5ucT8BpJXoU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=muHJpzz+gJ1bHF4686NC1MJDxzWaY9AKcH85r5jqmVy6zpr25B6tDa/7Is91D1bUf98VMOptrMpqqkDbGz7mGcxXWAIXSZIdyFje11pgRhqmBvBiL82cPP62ogmFYrt9w5PJyrMQ7TiQhYg2t2fKbENglVfb8L1JR9WjeMU9JMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=beyermatthias.de; spf=pass smtp.mailfrom=beyermatthias.de; dkim=fail (0-bit key) header.d=beyermatthias.de header.i=@beyermatthias.de header.b=EUlH8alH reason="key not found in DNS"; arc=none smtp.client-ip=95.143.172.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=beyermatthias.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=beyermatthias.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=beyermatthias.de header.i=@beyermatthias.de header.b="EUlH8alH"
Received: from cressida.uberspace.de (cressida.uberspace.de [185.26.156.202])
	by mailgate01.uberspace.is (Postfix) with ESMTPS id 4430A60AF5
	for <git@vger.kernel.org>; Wed, 03 Dec 2025 19:18:12 +0100 (CET)
Received: (qmail 10376 invoked by uid 989); 3 Dec 2025 18:18:12 -0000
Authentication-Results: cressida.uberspace.de;
	auth=pass (plain)
Received: from unknown (HELO unkown) (::1)
	by cressida.uberspace.de (Haraka/3.0.1) with ESMTPSA; Wed, 03 Dec 2025 19:18:12 +0100
Date: Wed, 3 Dec 2025 19:18:10 +0100
From: Matthias Beyer <mail@beyermatthias.de>
To: SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>, 
	Martin von Zweigbergk <martinvonz@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH RFC 00/11] Introduce git-history(1) command for easy
 history editing
Message-ID: <4m6rmefbv4hftclimitz5rp6yapswjtnjsxymrsdkuan4jbg3u@dm5jzdiq5cxz>
References: <20250819-b4-pks-history-builtin-v1-0-9b77c32688fe@pks.im>
 <CANiSa6gXbrZaMLVq-AAg38sm+7qgzn4w98WWowLtUHA2P+BdLw@mail.gmail.com>
 <aKs3tqjE510MF0T-@pks.im>
 <aMsWL2cSoytbmRjA@szeder.dev>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aMsWL2cSoytbmRjA@szeder.dev>
X-Rspamd-Bar: +
X-Rspamd-Report: SUSPICIOUS_RECIPS(1.5) MID_RHS_NOT_FQDN(0.5) MIME_GOOD(-0.1) BAYES_HAM(-0.556185)
X-Rspamd-Score: 1.343814
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=beyermatthias.de; s=uberspace;
	h=from:to:cc:subject:date;
	bh=qqGmC3b8LBGCn+t2AxrPxv4z5oUFy+KT5ucT8BpJXoU=;
	b=EUlH8alHaXpDooEO8vjvw9T0SR9y8ZRWSpTvy2cz+ZTm14IGlhVQcPnbqx0B2OzELfERId/COO
	Bw/MlPAiX3wX/UID+whdUqQAg49re40MuuAy7M6LkTHXYx9l91bvyhP5w/S4ofbguHmELZ8DsBvq
	Wae8Dsr8AZbqn7ZGOCSoUcIpsU78avInWHJte0SHvzyIK6KLm2H5wgcL/6hE06ZiI9AkZtabagGd
	opV2H43riwkmFBgQSooFuJoHFSsHJhQPp+ZjaE1oGQ6PJF2zCxia6keIwoyUEaLj7X4kWyIvbp35
	/sCPo16BBE55wV1/0eSpsqUdADY+MbhEoUEhryxP9vU+DIugYRUW1RQtcv/KaURuWIQ11aRORJKq
	pIYwD8Y/hly1JaDVynwdVImRPWyWtt8fErqkZqf02w26DzUiwp3G4RnChxOwo7g3aBif6qeW/S6G
	GSVQrgeETTa9J+SIPy9Jhwmt2goJX4Ijky/kAqoEzjXZwkfVVfhEmYBonmIpEwmibsD40tPWS8bu
	qh+CJKgkawe2rQ9fyATZua/XOOePGX+olRTGOcnMfWQPCaWSbkmMf6idrLUkVsgSeAfMswijKWP9
	Nntb1mY/APYqUWYlVRqK4QUvdOUoGk1QbQXEPFl/XNqJ9dvpfB+f/RgNdzMhbOOtaTGVnGcKNvdE
	8=

Hi,

Am Wed, Sep 17, 2025 at 10:12:31PM +0200, schrieb SZEDER Gábor:
> On Sun, Aug 24, 2025 at 06:03:02PM +0200, Patrick Steinhardt wrote:
> > On Sat, Aug 23, 2025 at 06:25:06PM -0700, Martin von Zweigbergk wrote:
> > > On Tue, Aug 19, 2025 at 3:57 AM Patrick Steinhardt <ps@pks.im> wrote:
> > > >
> > > > Hi,
> > > >
> > > > over recent months I've been playing around with Jujutsu quite
> > > > frequently. While I still prefer using Git, there's been a couple
> > > > features in it that I really like and that I'd like to have in Git, as
> > > > well.
> > > >
> > > > A copule of these features relate to history editing. Most importantly,
> > > > I really dig the following commands:
> > > >
> > > >   - jj-abandon(1) to drop a specific commit from your history.
> > > 
> > > It also rebases all descendants on top of the parent(s) of the
> > > abandoned commit(s). Branches pointing to the rebased commits are also
> > > repointed. So is the working copy if it points to a rebased commit
> > > (the closest equivalent in Git would be HEAD). Do you plan to make all
> > > the `git history` commands behave that way too?
> > 
> > Yup.
> 
> That sounds scary...  What does "all descendants" mean in this
> context?
> 
> Let's suppose I have this piece of history, I'm on 'branch2', and I
> drop commit B.  Which commits will be rewritten and which branches
> will be repointed?
> 
>    A---B---C---D   branch1
>             \   \
>              \   E---F   branch2
>               \       \
>                \       G---H---I   branch3
>                 \
>                  J---K---L   branch4
> 

Just speaking as a user here, but my expectation in this scenario would
be that rewriting B would be denied by default here, as branch{1..4}
would be rewritten although I am at branch2.

In the scenario at hand, I would expect that I can only rewrite G, H, I
while on branch 3 and J, K, L while on branch4 (without passing some
extra flags for "yes, please also rewrite the other branches").

Just my 2cts
