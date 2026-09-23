Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC7B54A0929
	for <git@vger.kernel.org>; Wed, 23 Sep 2026 13:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790168817; cv=none; b=FVSvXfUF+zpuWtZ1HaljBFPtbkOPxR91J/qZ3mrUSqbxvBCaI+84fo1vKk4yhFvFjCygkZzXaLDPTvoUCknV9fcFVIepzeJiAQE9t7qnMXzKt5L2i79f88fxzn701cL2hmYbp+EfUv+MaLOogsqKnr2d9+fHII3m7zNulDAYVZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790168817; c=relaxed/simple;
	bh=yLKMfhQMz8k9IPZVnwcERUTsvq+LKOfJfl7O5LUjhTo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eGaMdmhzCBOENs4mYxmcOTJ62G4sF0UjW299ukzd6HIoF5x/Io36xmUWEFhFYDomWs/dwMvpzzqNYsAq8fPFZ6rqacSLZZOB25ugT/y1zesi+jPEFzNQIUtZR0JAtX3dLd66DAZJ5JbLkCmZDBqWu7Q7WnsnQESYyIcndqadVsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=vuvYQ9Aj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GOXm/3c9; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="vuvYQ9Aj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GOXm/3c9"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 0EC997A007D;
	Wed, 23 Sep 2026 09:06:55 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Wed, 23 Sep 2026 09:06:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1790168814;
	 x=1790255214; bh=CBatYl7IsTIhHCryEEeLYxLQq6N2EwBzPH42MYgBULE=; b=
	vuvYQ9AjVr/e7s+4zXZBA6gdc2V/4xlWZrDUgzfNvcAYthSSWe92DLIfWooWkW6+
	mDQxkrccsBsaUPYbe6JroSUgMZOFoDLlgAqLZUQj9UW+w3e8cbyElogvel5gFV37
	4GUhKBiPl0xCvfsTGKxbDH45LYuluYkKJ8iDXsLWyWYg/yryctpdBoLbyDlb88Ld
	Xn6yV4t5xxwDlrx6OA/GZSpqWompBgARq1we2RtUHVgv9WB1+QXG8nCABsdNExrb
	rSVAtU+mwJMmc38xiSUioUrSzozqo1DRvdDu+qp96wdfwExm/fh23jEp++SfAsKA
	7Am4EmxuqTgL0C9O2vVNnQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1790168814; x=
	1790255214; bh=CBatYl7IsTIhHCryEEeLYxLQq6N2EwBzPH42MYgBULE=; b=G
	OXm/3c9JMJX7dR6lJastPnnpalGbwRknDfZCNRGJxqfrs7hn7fg+C63Dm76ufLjC
	6e9Kb51KFHUPgu/DC8kVPhNFdxdoZmrY5uMmvOcBbgqAEZBJ7JNYmgjl9glF/Uzr
	TYc/SQorzRaBBBwpXZSR2GYTxXKplYdSEVyXIUnjYl/Ek27zNAvdrYX83fu4+R+0
	FEBWVg+1UBLOyJgwgSFXtXND2mZqwqsuVf2k5cPU/z6WjbYbZf9Kk2etHPnej6eC
	q25qZpxRyc176/x9aX9iNAHgQVfZCujHjB2SugTnwh8jR51jO7WB71ZTpzBfeyOt
	3csn6wnX+0WRBnKF7fdQA==
X-ME-Sender: <xms:7s6zas807zXS1PtavMKY6d6BZLMugV29dpOUzwqQbDS352C_wsbuxg>
    <xme:7s6zasJt8cKOYhW-rLQO5ddwu5fXx_TCd-BZbSyYZmbkgVDiEUB1lhTZEC6AWBm-_
    InUGmwVT0cRO6vQ-QTnGVtLJ9LfPT38yfdVidT1T0BI_nwk04CHVOM>
X-ME-Received: <xmr:7s6zavYPvohVgG3HTmBc3Mkb08TXi1WQTSRfYGN-8nwCGpNFmMbElg>
X-ME-Proxy-Cause: dmFkZTE99K+rQ0yElREW1yi8nWWbpCV0UmtTbBqxmy3YkyunVAqrB9KWFFUtIgGRQ/cqcQ
    7YsH2udnFaBx0Dgr6FTww+zr+dCL43Ua1CkjZoQk/7/g1WSBUo78LmSNq+KpXSx/dOOGoS
    0VVxzafnPkCvPDjS0n1gDZuNoelxxIJwXChp+zdSRtb0VdGtQCLW3WiYSY0euQ+R9RSsKb
    61uekNRcEG5GoXXah0eNiB/XHNmPJsBVih5OS/PfwKpJ40RrTlXq1Y02UHUzk2aLvLXT5g
    N3XX6grwJfn5T8TV32ZEm/JBduBUgaNLesWhqEr8QDUU+ctN/+WWthQB8JEHrjDzdPMoi1
    voXpaIdZCyz1kg6uK0QMh49F77npsptTuiM0J4rG/l7qPYIWGMmWLRiWQgeR5pDliA5ybm
    CoHX17AF28nrEIxw6pJgTAS4DQASdzqIxWtZ0Jv54UPxZLoq9zjeOh70E3vZeuqkWAa3AW
    s/De9LoJzv8tiufleGxayB81qdh2KqqsKBRUwBqBfZ+kyVyYZBM7V+Ty9uaWJNO2KSb32W
    y3zSDu1Qj3QJWubwNOhbLclfbUBjBLJJcXreuw8zvj0WbjGEUR63FsOt8vUWRj3EvpI/Y2
    t60Zh9KzzPtQ7v03CLlV8GgbI3TWFr1c5d20UzgY+e4bjuqvVSKDgaac9Nkw
X-ME-Proxy: <xmx:7s6zamJT1u5luwpkyHZ4LOHuMjiE3Ld2zPPCUA1OQsFQtmCcM3PaRQ>
    <xmx:7s6zalAI5YTEoBqZGJmddS8tbtsZp1snJx1eI_Rfyt8VY284Eyd2DQ>
    <xmx:7s6zajrrTW9ABe6YznOM0vS5PGEkuQ1KGB57DQK3JBDP8Oxp7jho1A>
    <xmx:7s6zaohNzvhx1F00RcKu0N9cDRxJ77mxvrwENKtP3KE1ijfL3M3zwg>
    <xmx:7s6zainS4iW1FUJo9U69b656gDlBjS-j-rgzHCVU1zEVOUWiR6JYI4iY>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 23 Sep 2026 09:06:54 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 5077097a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 23 Sep 2026 13:06:52 +0000 (UTC)
Date: Wed, 23 Sep 2026 15:06:48 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Yoichi Nakayama <yoichi.nakayama@gmail.com>
Cc: Yoichi NAKAYAMA via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org
Subject: Re: [PATCH] completion: complete 'git worktree repair'
Message-ID: <arPO6GzJVjjdndTN@pks.im>
References: <pull.2218.git.1789171955370.gitgitgadget@gmail.com>
 <aqeUWrx7pbzDVbVt@pks.im>
 <CAF5D8-v2FSJX_dHFmNzaudAtPu76pVX0n5GhMnGjjnT2f3g3Ng@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAF5D8-v2FSJX_dHFmNzaudAtPu76pVX0n5GhMnGjjnT2f3g3Ng@mail.gmail.com>

On Mon, Sep 14, 2026 at 09:08:15PM +0900, Yoichi Nakayama wrote:
> On Mon, Sep 14, 2026 at 3:29 PM Patrick Steinhardt <ps@pks.im> wrote:
> >
> > On Sat, Sep 12, 2026 at 12:12:35AM +0000, Yoichi NAKAYAMA via GitGitGadget wrote:
> > > From: Yoichi NAKAYAMA <yoichi.nakayama@gmail.com>
> > >
> > > Added completion support for the 'repair' subcommand of worktree. It
> > > optionally receives a list of paths to linked worktrees or paths to
> > > worktrees with broken links.
> >
> > We typically write commit messages in imperative mood, as if instructing
> > the code to change. We also briefly describe the status quo, even though
> > it's not as important in this particular case. An example could be:
> >
> >   Our Bash completion does not know to complete the "repair" subcommand
> >   for git-worktree(1). Add support for it.
> >
> > One could also try to add in your bit about worktree paths, but that's
> > something that's quite obviously visible from the diff anyway. So this
> > may or may not be valuable.
> 
> Thank you for your comment.
> Since this is not limited to bash, it also adds completion support
> for zsh and tcsh via git-completion.{zsh,tcsh}.
> So I'd like to modify the body of the commit message as follows:
> 
>   The completion scripts do not complete the "repair" subcommand for
>   git-worktree(1). Add support for it.

Ah, fair. We know to reuse the Bash completion scripts for both of
these.

Patrick
