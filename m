Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE73318C332
	for <git@vger.kernel.org>; Fri,  9 Oct 2026 10:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791541342; cv=none; b=OpJL6Nmc2gZJDnrh+a9+wxafzxYvL7+W3IwPSJbCfUv9cn5cMFpa5kjqn7H98N6rMf6QP/mjJZ08oRvgyGTqoo3tH80LtQp+gby3OmWEfXCBOZojqhMsKTI9nbT29ELp3PQp3I93PRdR3bMxeFIz3b8I4gR9Uwjarg+jVuGqmks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791541342; c=relaxed/simple;
	bh=m0sITHX9Zd8odIa7Pj5N8hSKNW2Wn1b8T1GHUlQ4Jws=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dWE00Y84u3TCpKvoJ3qrPVFy16eK5CEvpz9v2WnL0gS0QB0MhW3BkOgQN+UXFKr0MaaelT49cblzry8yWX/Vwteh8RLOBUKX7iS1nx08iUZpSMBHyg1Hzd5i8gyMFl+GqQGGpM3mXT3jUkd8pDHjXg3BdV7pgPEUKBmJYe0AQZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=MHxdeJo9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=O17E6x3m; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="MHxdeJo9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="O17E6x3m"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 0975FEC00FB
	for <git@vger.kernel.org>; Fri,  9 Oct 2026 06:22:20 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Fri, 09 Oct 2026 06:22:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1791541340;
	 x=1791627740; bh=NPuIPsnytdvyUzdBVQkBgC/qbBDwfqTsgjKOWoo8bac=; b=
	MHxdeJo9nYmCJcxf1MmZpb2WzSK62uzfXb+CI5VXonsJF6ojHVcCnmgIE6IZZ4Eu
	hRCDEHizlb+u3ayTjwDiScwOMaZ+s+O7CTRIogNZ4G4D5xwQ9uPIrICJgP/nNfy3
	/+MaS1Tzim9JZA4ZBWAUUJ6Ixvn+KAt9WP6D9v8WVaR0An1lquNwNDCiPbjcythH
	komsjZ9GA/H3FSXy56E8nvADdh6DZiOAc4ik4BDqw+B7OChtrqiHcFHr2dMRnYRV
	IfUhvPzpTLlGnzVk08mqS9mVaSI88ebyRSf7W4yY7OUcWofjp5LyDHJjf/YbWUoB
	b05/cNuK00S1uMMe8mBpfA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1791541340; x=
	1791627740; bh=NPuIPsnytdvyUzdBVQkBgC/qbBDwfqTsgjKOWoo8bac=; b=O
	17E6x3mfMbcpqlnJLovSo27T0TR56fIASMFKI/VTxO/Y/wEMpN4R8XwmEp8+cv+1
	4jqxf8nsObX5oHi/b3CkT+SgDB5LKXJRRHYpGZUo1LvRRIvQQmiw0Wakt/40LsjD
	fktuM/mQTouE/yqETxQ1palgWIodf3bFPbm0AsWdIjeRkGmfWqqvTs9uawewl3UA
	rwuLMarz79KCmjjwKio79YfTmCIfVR7cU5959HDB9VG7win/KIzNiVmgLUs6hm/H
	cm/aJL8gK8B7SV0/cNPkLhoLTfnhiMjx1dVS7M06sPMk6vFp2rgFkAu1bwhDypHE
	2C1RZl75Ue2jSJ5tC+Zcg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791541340; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:cmsSOn1GB3W+v2VOSSx6Im0LHucgFnQu9SRTwFWNeWs4F5B
	AYjvjlDFX0kxfqwJfWhyy8cPpmLvaoHtp0x1VVUMsHWOEftBC3Oq9zeFw/P6wh3F
	J0yM44jLHNKVtpY9C/84w3yb9O+imrU9xSsdERhn7q/x//VP1nGSp8WrFKWD/6j+
	4dyUFeLotiAvHSdS9mplJpurtpNCNzSfpXx580PSHgMQMeEaQcXZ8SIgKBvpto25
	ap/HsGmjbYjUrj0srg/SXXSpKSm21ueJmAdI5R0EriRWLVI89hOyjaa8H6kk0GPs
	ceB8gLYsVYuOc3G9LpvlBUs2/pCFnuFfx7DZx0A==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=13;
	hn=cc,content-disposition,content-transfer-encoding,
	content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:siELvfgb+2fpu2jJvSVBk09oaTAspETQ10+VEuoG5FM=:m0sITHX9Zd8odIa7Pj5N8hSKNW2Wn1b8T1GHUlQ4Jws=;
X-ME-Sender: <xms:W8DIalb1yQR41UdctBmo_W3eqRDNE6dvMjAuNZre44I9JzWEZu6p3w>
    <xme:W8DIajZ6354IsPZj0eUcIOkwVnYHs0dXhJsnBmWz206xPjXx7zEkL0WwXKHclhnVC
    WcNc5AG_p_8pxUhj35SXWrLktkXc_UmSckWEUUxYx85bV73HuACzug>
X-ME-Received: <xmr:W8DIas-apVi5bXI-QrJcZ1rAlCLDMXQlD4TcjCnPWOdFBr2dz0SJELmG1rOIhdwBmzNwtw>
X-ME-Proxy-Cause: dmFkZTGJyh1TPU9OmRtlYx15R6j38K5vOaOkxyJe2TTSV7yEs0iX63n9SAUQxhyDwLnMuq
    3a2IFGA8bR4mao5iCbqFsA5BeQcNjvZe5M264FX5vAg/DR3PbBO9H/pSWORMO7VxITYV++
    QZLdXZHz/95xFxm1Q/qq/nT07vpqtWm+UI1BRzSzvnm492VA3vRK3IQJtyIr+tikH4+OGr
    axzov/beNunpDps8tR9fmjSZ+y0vdLFu8ebmDjeFcV0RXUGgkWwlVEnQTMGCOsKiLebrwe
    2AbFGmZMvxLfg6WQsP5uIOCf7jfpy0APcLkBAjyp3kpPkdAYw09utOf3uoVpGBGUlS7YGo
    PKU5fxPEJ7PCVps+8K1/dJRTOCIkItnexDl8sv1Vbmn0nCYxy4Iu0FdxoLq04A/uMm14Sy
    PMO9BBKm04DVkzyqHCrB8xGuv6VG9dUpDBPQNlRKarvAjklIn+u8ZxtGVlUSST9qW7DEEL
    KCbIxnQDgStwbKk8siCDtoTAQovRHJCMZ+IRXWtO9MDA1ThtDtL4a4Bfv1MHf0Bzl5zVzG
    HshQidEyd86m/Ci058knzZX/510Ky64WDL+hh73PqJwaMhY8i8+kemTtqKACTTG+oKfoMc
    laH2sodh4v7Ak2xmiC7ajsE1nrR29tqA9U4Dyg+v5OHiiXL5emryw4hJOq5g
X-ME-Proxy: <xmx:W8DIaijyjJnJq5oW19aaYoxYwdvju_ymZb78KO8MCsEDZVyveXjfoA>
    <xmx:W8DIasdAtJyIzJj6SadGNTvaMgdDr3gpLEaF_XtSLpveAk3d_Z5Mfw>
    <xmx:W8DIapqs_EIiJsq9pXvBqG-H-8Y9x5DUMqLlVZ5kh9RDPTocTSiC-w>
    <xmx:W8DIahDtirru_G9LemutK979qw6ZHk_BGPjFugwUEArs2G3OYs35bA>
    <xmx:XMDIah8VtsVdZ9zu55iB81Ad8T_iPMCnTqF-VO3LBIpLR2kCAxjcQSUl>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 9 Oct 2026 06:22:18 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id c2b397a0 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 9 Oct 2026 10:22:16 +0000 (UTC)
Date: Fri, 9 Oct 2026 12:22:13 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Scott Chacon <schacon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Scott Chacon <scott@gitbutler.net>,
	git@vger.kernel.org
Subject: Re: [RFC PATCH 1/1] SubmittingPatches: allow responsible AI
 assistance
Message-ID: <asjAVQD6mFnes00l@pks.im>
References: <20261007142954.31761-1-scott@gitbutler.net>
 <20261007142954.31761-2-scott@gitbutler.net>
 <xmqqcxtl3zda.fsf@gitster.g>
 <CAP2yMa+o7zv=8bzHUa8FRkTaU46BQ3w_ZAr6zQ=rFC_a4cg2yA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP2yMa+o7zv=8bzHUa8FRkTaU46BQ3w_ZAr6zQ=rFC_a4cg2yA@mail.gmail.com>

On Thu, Oct 08, 2026 at 03:53:11PM +0200, Scott Chacon wrote:
> On Thu, Oct 8, 2026 at 12:44 AM Junio C Hamano <gitster@pobox.com> wrote:
> > Scott Chacon <scott@gitbutler.net> writes:
[snip]
> > It looks, at least to me, that there is not much that can be
> > meaningfully enforced by reviewers and followed by contributors in
> > the above text.  It seems to be little more than "the world would be
> > a wonderful place if everybody behaved this way."
> >
> > A violation of "concise and relevant" seems to be the recent trend
> > of much AI-generated slop, so it may be a good suggestion to give
> > today.  But would we need to update it once the trend of text
> > generated by AI tools becomes "concise and relevant" nonsense that
> > merely sounds plausible?  What if an "AI-assisted" contributor lacks
> > common sense to tell between plausible-sounding nonsense and a
> > well-written description?  What if reviewers get too many such
> > "contributions" and cannot allocate enough review bandwidth to sift
> > good contributions from plausible-sounding nonsense?
> 
> This is a fair point, but you'll get unreviewed crap either way. I'm
> sure you already are. However, I don't think people who submit
> complete bullshit are reading the SubmittingPatches file in the first
> place, so I'm not sure that opening this wording up a little is going
> to make much of a difference here.
> 
> My recent patch series converting the sha1dc is a possible example. I
> don't understand all of the code it wrote. I read through it, but
> there are some crazy tables and complex math in there. The first pass
> did a weird Rust to C machine translation rather than reimplement it
> in more idiomatic C, so I had it rewrite that - so there was some
> approach guidance, but again, I wasn't hand crafting the code. I did,
> however, spend a lot of time and resources testing and benchmarking it
> on multiple architectures so that I was reasonably confident that it
> was fast and correct.
> 
> But I hesitated to submit it at all because I knew the policy. I only
> sent it so that if someone at GitHub or OpenAI or whatever wanted to
> use it in an internal fork so they could save a ton of CPU, this would
> be a way to get the implementation. I was aware that, although I
> believe the patch is quite reasonable and valuable, due to the
> conservative AI policies of this project, it would not seriously be
> considered no matter what.

I would argue that this is a good thing though. We want people to thing
twice before submitting code that they don't fully understand, don't we?
Otherwise we will get even more slop than we already get.

> My point with this change is to open the possibility for AI assisted
> change that is reasonable, similar to the Linux kernel's approach.

We already are accepting AI-generated code. So if the change would have
the effect that people _don't_ think twice anymore about sending their
AI generated code to the mailing list then I think that's a net-negative
change.

The bottleneck of the Git project has never really been the amount of
code that people can write, but the number of developers that we have
reviewing it. And you can feel that this bottleneck is getting tighter
now with AI -- over the last couple months I have spent way more time
reviewing stuff, and the number of times that I noticed too late that
I'm reviewing slop is going up steadily. I guess for Junio that must be
even worse.

So I think loosening our AI policy shouldn't go without finding
solutions for this problem first, because otherwise I feel like we are
just going to make a preexisting problem significantly worse.

Patrick
