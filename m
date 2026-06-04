Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DF1D3E2AD7
	for <git@vger.kernel.org>; Thu,  4 Jun 2026 08:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780562383; cv=none; b=bSzpD8JEfxQE1XsO9vAiwJSuMyfH12cGy1HeWF1qhUcJfLNYlgsEKiVU2j2akPucGhVzp+wjv1kq1jyCtmHU3Ro5ZQC0gTXBpIl71Pp8pCh9TA9N2CX6WC5zygWqBV8LIr5z5sX1FBFgs2CsZnM09tFBHQxY86LgXkV8ylL5xf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780562383; c=relaxed/simple;
	bh=gLwbKFT/QqLCXH6B4X5fZzMGXN0ZldKU73+NNN08XSI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mPcx3se26PW5RNzx59pn71aFIC/CCAZV+nIT7cqGy83tknw8RlOlkeM0oEHPxB5T3FnnPRq5A2TkXJhriRbq7DlLc87VaxLsO5XlB45OZwETg2msPb51EGr2Le5AQAr6x7Gr1Mo/E2y1/fD4NV57dbHc8D3O5Ozi1baU1rHqlzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ANIMyT/7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=B4KcGQXT; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ANIMyT/7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="B4KcGQXT"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 608E4EC0081;
	Thu,  4 Jun 2026 04:39:38 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Thu, 04 Jun 2026 04:39:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1780562378; x=1780648778; bh=wzrJLUJbdm
	61pC9S+Yf8Rkal6XdK/N88tsP8NWd4NNQ=; b=ANIMyT/7TOx7K79xGnxX79CK1I
	If/MtqgnYC3e08d3TaqMajN6GoSSFHsdPRjxKOGiofflSb+b1SSFCsYcBTsR4hgs
	tTBh2otZ5IG8X/WbhxvQ9eV0uvuRY7+ZsIxjZ845XVbguzwhikoBOvniN+ArRcf8
	Lh4mcxEkn37bWBFjnA5QD1nNLynOahcx7SxzV7xczXYHyRzXK0IV0UiCoxQD0nVd
	i/t/Xt9ggNdler4Tj8ywXLCvLsg32/GgTRErXedRdZIx3KA4a/isNzUZEXKMjKBh
	0Nqj+r8cWChMd2cK3YzUOhMQOKExGTbwifrlNwzPJZvW5JTA/iiUQmWPNXPQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1780562378; x=1780648778; bh=wzrJLUJbdm61pC9S+Yf8Rkal6XdK/N88tsP
	8NWd4NNQ=; b=B4KcGQXT9JMIaVoHwSd3XOBNDEA+RxdG5tuuvgTPPiBpl1w/NM2
	FI9FaOsfJ3jZ7iOUOH/rgggY/xAt/PtyrpNY8gfeoqzh34NVqYLypk9kJQQNou0Q
	aPs929dTZPXrH4zonimtzehzLAbVofn8kx2H2VKTIem7wOYvH9qr6XYRrzAtdELK
	Z5vWF4NUL25TImxlT9J9RnY5aMReb/2un2YgmF4TQwg3SW3laNmdBu2lVeCX9sxp
	d91z5OXKBmx3D8iKwQg72Ryb5/zaPF8lNJO4S8EGaMYkFQ5mD5LQUOC5IXe3/Bdy
	3iD791fakJkzRgK1UHuNx4YiA+vGIZnBmmA==
X-ME-Sender: <xms:yjkhahb6i9d4bGY6NUFvbkL4c51ffsU5V8MCwJaTmz2tyFoo4PK0Lw>
    <xme:yjkhaubeJAK8wWFXWno_CQnPHdspnRvgXRHsH4dtZ7kh4PcLUVf8wSn75H21T9dxA
    aWnfV82SCEoPMCVb-72p0BSnmMNZ3MNoc4D34MovmsPZpjjUafx8No>
X-ME-Received: <xmr:yjkhahmCRi6rGG_QJFkoGbun2KU45vVVJaWKi7wMkiBM57J4Qv8CDIyuGXSrv9-WPMoOsU4vidnBOkHwlOeqgDPZn5ARlFBITPtsp4e2d1s>
X-ME-Proxy-Cause: dmFkZTGR2rPpL8XoLfNkJ4iLamM+M56+uTdvtD1xTN5vcVVJdCk0zXQpEDaCyAAPzf8fHx
    XdZKT58OKpquBGKsosTv8Mbg0o4mMyB0vjOuZXb9Mg/gf5Snp0ET7IT/sKFv24pqfKrTpW
    R+YFqmt7KGWFx8Ls6mR5UowiX/Cb/fTRTgWI/44rhg8ONFuJiOXbzLHJJ1VohX+Bl+/5jk
    9dvbo46NhaSPPs/Es6BE50na7Ljbzs6LUT+Fu+siv3AwaOgXYkpOADymIMPyyYgiKNncQA
    xCGrAqTX/BcHmszEsmufZ9tL6o65PcQ2gEtPDJPayzJ6jTBsMuyJaCzNEZaoqSK94nGcOg
    eDX53ssa7JCsyfH29rVXouA3XkUcp622qW5OEjTyUYDMoRSklwf6+J1pLRGjXZIhXyudRX
    IWYTTHx6tM5gtk2UiT+J5cCkb4coEpQL0P0NgV12DO2dFssCBHDGnNd0aoG+YfPQbwqzT+
    qE6C7uEKSnPnuBUQcVvigD+iUiS8TZ9XxPD8hBXTXQ3LJqpVYbbXfu3l6DpOYtZz1G1NQ5
    3sLG8Oqck1jFCzp1/zhiUwPFODdE+B1/eUFrQchU4su7U/CPaPcxs1DzfHwctGt+RjGfNo
    04yKfZlZrK4WhxP+Li/9ddO6lsr2YD7VJHaGYbYIKvRkJCWV3Zlo2B8Qc/wQ
X-ME-Proxy: <xmx:yjkhaqwjztG3ILToS4FOfa8IkDqhmxpnH92lEC4isJ0GCWUfW41Wiw>
    <xmx:yjkhavM1KH1IQRbDV31PZeameWyNLw3yHSpnft-ChQDauKSW-7uY9Q>
    <xmx:yjkhauQ1M371rpdEwfq61n-BOeJc_Od0tcHK49ObXLeZHpl6DGvkAQ>
    <xmx:yjkhatZ8_f-_7XEu6CoUdRvtK1PFeb9p4WLfvavWHqkvImGMCrffVg>
    <xmx:yjkhakzLxRW2ZcWuB1ka8NsMPSvCZyhnjcLq-OTNSs2QfDI3Is2yhEOF>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 4 Jun 2026 04:39:37 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 653fa267 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 4 Jun 2026 08:39:34 +0000 (UTC)
Date: Thu, 4 Jun 2026 10:39:31 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Rasmus Villemoes <rv@rasmusvillemoes.dk>
Cc: git@vger.kernel.org
Subject: Re: git history feedback
Message-ID: <aiE5w_8Oxv-I54zy@pks.im>
References: <87ecimhg8s.fsf@rasmusvillemoes.dk>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ecimhg8s.fsf@rasmusvillemoes.dk>

On Thu, Jun 04, 2026 at 10:17:07AM +0200, Rasmus Villemoes wrote:
> Hi
> 
> As soon as I saw the announcement of 'git history', I knew that was
> something I was gonna use a lot. Especially the split functionality has
> always been somewhat of a hassle (at least for me) to do via an
> interactive rebase. I've played around with it a little, and it seems to
> work as it says on the tin.

Happy to hear!

> So today I had occasion to put it to real use, and then I found two
> things I'd like to be able to do with it:
> 
> When a commit needs to be split into three or more commits, it is a
> little cumbersome to do iteratively, since the new commit to split
> obviously has a new sha, so one first has to figure out what that new id
> is and then do another "git history split". For higher values of "three"
> that becomes rather tedious. So it would be nice if there was an
> iterative mode, which after splitting off the first commit would
> automatically start again with the new child commit.

That's fair, and also something that was discussed when initially
introducing the "split" subcommand. We don't have that mode right now,
but I think it would make sense to maybe add a new option that makes us
split repeatedly until all chunks have been exploded into separate
commits.

> If "git add -p" had an answer meaning "yes to this hunk and all
> following in this file and all remaining files as well", this could
> probably even be the default behaviour of "git history split", as it
> would just require that one extra answer to be given after the first
> commit is split off in order to keep the current behaviour. Otherwise,
> I'd also be happy to have "git history iter-split" or "git history split
> --iter" or any other spelling.

Yeah. From my perspective, having this available as an option would be
the best path forward. But I'm also open to alternatives as you suggest.

> The other thing I'd like is a sort of ultimate version of the above:
> What I needed in the concrete case at hand was actually to split two
> commit into n individual hunks each, then do an interactive rebase to combine
> those 2n commits to n commits (I had done changes "row-wise", but needed
> to change them to "column-wise"). For that, I would like to have had a
> completely automatic "git history atomize" that would split a commit
> into individual hunks, prefixing the commit subject with
> e.g. "[<filename> -- hunk #nn]". A subsequent 'git rebase -i' could then easily
> rearrange those and squash the related hunks.

It could easily be another option: `git history split --explode` for
example, which seems to be a common term for such an operation.

Regarding the subsequent rebase: I have one more patch series cooking
locally that implements `git history move` to move around commits, and I
did have the plan to eventually also implement `git history squash` to
squash commit A into commit B. But when handling many commits it might
even be easier to use interactive rebases instead.

Well, unless we eventually maybe even get something like a graphical
interface. I was playing around with a TUI interface for git-history(1)
that lets you move commits around without the hassle of the command
line. But that's certainly something that's still going to take a while
to materialize, if it ever does.

> Aside: are experimental commands eligible for teaching the completion
> logic about them? I.e., can we add a __git_history() to
> git-completion.bash? Aside from the obvious "let it know about existing
> subcommands", I'd love for "git history split <TAB>" to show the most
> recent ~20 (or something) commits in one-line format, stopping if
> there's a merge commit.

I just haven't gotten around to it yet. I'd certainly welcome the
addition of command line completion.

Thanks for your feedback!

Patrick
