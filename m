Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0BD8220F3F
	for <git@vger.kernel.org>; Mon, 28 Jul 2025 06:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753682730; cv=none; b=C3J2foKC1CxUOH2eZltdvT9EHmga/GiI9xlWJ00dlsRezDUSXzN52QqzBVhXb5hD1q8QMq+Rsq3XQukwHbBGdEKtTgQcPDYBPnZRmw2QQWjic5qh70VPS/j3KzhgTYsVmmuqFVsBeXMstr3LSaEhmYnZxj8QsxZzFmXLrERnCWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753682730; c=relaxed/simple;
	bh=QEx1LvFXB+MrHdkpsKjHkO4ZjcT7x6sS1tg4JqS6xQ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RYmiJK1r/VBH4aydRd/GNo0hYSXw5lRPwHlr2YNSaP6e2fCEIwZ9DAemVGnLykA3IauMQAVnS9Y3pdKrpzxqunX+VOf0oYXlHoVUY74jKcfKQArJRprfyyPwJBiaFJPBj8mmNVJxRVYNBgNLJLb3lBi50WxhnKxYXfOo2qdIlF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=E07WdMqo; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Y1GP455z; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="E07WdMqo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Y1GP455z"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id AD8AA1D00101;
	Mon, 28 Jul 2025 02:05:26 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Mon, 28 Jul 2025 02:05:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1753682726; x=1753769126; bh=PYdMCVt2m5
	ry2+M4l7zHKpEihlp/TII4uGVTIse+ocU=; b=E07WdMqokT/AYMYf6heD5R8KMn
	0mXJopmqs+wxWdWlBQH0wPU3beHERCz2Hzj+XKte7zwFyYLUP1GqjQHnGpP3XFxh
	UcgLjXY027Cuc67wQWRxSGbJ3vhjIxkgJkGajXxQWkvveLKl0T4mZr7oYawteMkR
	aT+tLKT0dZ7m6X+E81sZZfRhhR/5tx8YCzsxW1bEG0NeDD5yXMAiuzyIY+LNxBWB
	o811Qm2Cd3MnXA5FU0ZwL3zDuxQGNY7wnlFSpzsx5qBcnADdwmc3oQopiYaFlCmZ
	oMlfKk0FpRIyztAkMu6VQBfONRQMYB94KCzf1kCs1SUl4W6Oz7DSyWS27IWQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1753682726; x=1753769126; bh=PYdMCVt2m5ry2+M4l7zHKpEihlp/TII4uGV
	TIse+ocU=; b=Y1GP455z77CkWcWU1VAXtTDXLmj1PLe50UUV0jECfWm84tHkp7K
	Vye47Nyc5Ohm2LPl2MwM59ooEC+KoNWqdJDZA20l077RSm5t66Q+PUQ9fqOqObi7
	DF8JC6Y2mp1dr7PBpUlWyikwsMPcxA6inykpu8fsAXs7BAWmhkn7accWKRV4SKyx
	W+kosMShgq/mVbF1i8jJyHb9f0pYhRjyqkjusa9j9tCQa8eQZ7baD5ndm03uTia+
	wdkoBORUDuCeovk/nhSt+cDMcDAoZKodcBSpC/mACnqwEV4XpsxlvntGRD/iwvgs
	zotWZfFwZqnX6AAzuOLNrp85BIpZuOvqBKQ==
X-ME-Sender: <xms:JhOHaAgmqFQBvzrKxDxxjhDpx12Cze-zItbKn4FoGRrxPXaxA-SkQQ>
    <xme:JhOHaMRpoVHrMQxW8fsgZ-0nDeWm81HcqEieaGIisWsQzjE26mMDoUjHXlk_vY674
    FdsF5RC_7ccjg2clA>
X-ME-Received: <xmr:JhOHaBikOigozmC1TF6V6BuFGsUoEQuTZupcJpt8ouwERhcWWhQ9lWEiKrBEbhQ17ahovVG1d-xyQ2TW0uo5HHQWtzHOiTV3h0OESsoQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdeludegudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesthdtredttd
    dtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhs
    rdhimheqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhe
    fgueegudfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
    pehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhoug
    gvpehsmhhtphhouhhtpdhrtghpthhtohepjhhhtggrrhhltdekudegsehgmhgrihhlrdgt
    ohhmpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehgihhtse
    hvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:JhOHaM7p5lA9eyjLr99KhzumQVXht9BtMYvAN7llJw3Xufj6pYZWJw>
    <xmx:JhOHaOAh2iDz9OVzYwIj4QzaDkhC4GuZwS8qiusYXFE9OhoDTHnHYA>
    <xmx:JhOHaDa2ot-_lrz0zeLzomdAABFRYjhhGg1N3-Mu60gisYvepd_sQQ>
    <xmx:JhOHaJbZ8phw_Gp4_Y7EuxpZmdUSjpiTuvd8XQuZ1mTYGv0q5nsnfQ>
    <xmx:JhOHaH60tNEIggcswj8WYCOFECagJedYTDsEAXFr49B7vf8pd-W7Wg3j>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 28 Jul 2025 02:05:25 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 241d1908 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 28 Jul 2025 06:05:24 +0000 (UTC)
Date: Mon, 28 Jul 2025 08:05:20 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: Han Jiang <jhcarl0814@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
Subject: Re: `git remote rename` does not work when
 `refs/remotes/server/HEAD` is unborn (when right after `git remote add -m`)
Message-ID: <aIcTIFbKud0k2ioB@pks.im>
References: <CANrWfmQWa=RJnm7d3C7ogRX6Tth2eeuGwvwrNmzS2gr+eP0OpA@mail.gmail.com>
 <20250724104536.GA1316505@coredump.intra.peff.net>
 <aIIf7S5iPspktxdw@pks.im>
 <aIIvHxR8wXLTCgMW@pks.im>
 <20250725110243.GA3014187@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250725110243.GA3014187@coredump.intra.peff.net>

On Fri, Jul 25, 2025 at 07:02:43AM -0400, Jeff King wrote:
> On Thu, Jul 24, 2025 at 03:03:27PM +0200, Patrick Steinhardt wrote:
> 
> > I've quickly hacked something together now, see the work-in-progress
> > patch below. The patch does not yet handle reflogs, but that isn't too
> > hard to implement.
> > 
> > And these changes indeed speed up things by quite a lot: instead of
> > hours it now takes 7 seconds :) I'll polish this patch series and will
> > likely send it in tomorrow.
> 
> Cool. I agree with all of the pain points you outlined, and the general
> direction. There was one other sub-optimal thing I noticed, which was...
> 
> > -	refs_for_each_ref(get_main_ref_store(the_repository),
> > -			  read_remote_branches, &rename);
> > [...]
> > +	result = refs_for_each_rawref(get_main_ref_store(the_repository),
> > +				      queue_one_rename, &rename);
> 
> Both before and after your patch, we're iterating over _all_ refs and
> skipping ones that aren't in "refs/remotes/<remote>/". If we just ask to
> iterate over that subset of refs, then we save the effort of iterating
> over the others that we don't care about.
> 
> But:
> 
>   1. We have refs_for_each_ref_in() and refs_for_each_rawref(), but no
>      refs_for_each_rawref_in(). Feels like it should be easy to add it,
>      though.
> 
>   2. It's an obvious small optimization, but it doesn't help us in a
>      big-O way. Iterating the refs is obviously O(n), and in the worst
>      case rewriting the packed-refs file is likewise O(n). So I wouldn't
>      expect to see the dramatic improvements you found by removing the
>      quadratic bits. But I'd bet it's still measurable in a repo with a
>      lot of refs (and maybe with reftables it actually would be bigger,
>      since the goal there is to amortize the rewrites).

Yeah, I was wondering whether to re-do this part while at it. I
initially decided to not do so, but I guess that was just me being lazy.

Patrick
