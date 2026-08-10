Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFCF425771
	for <git@vger.kernel.org>; Mon, 10 Aug 2026 06:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786341793; cv=none; b=NSsLwgjfWvSvLC/h4Te17T+SOZRD3etf5wB97xWTOT8GpKPNGXBIuLSjn9fkoz/zQd7J0UvzBBZ4Cyf76EAq923x+jYajOc2EW+4CqJNviLnllyNYIXQFBQRtZU5j6pigSf4o75SDvJrvNe4cGCfVDyxh6r/ZSdfhyo8lV+QGSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786341793; c=relaxed/simple;
	bh=L/nk+dHFNYXdVUSJrOqpADoS5dWTZG6q0+qL2rTFHtY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZCfPudStPS/61Zu0VfIDAraJ+Q4+q1MmrO3VVHJrwuz+zRl29zeNsSVA20+MRxtu0KiTT8wCkd0BXvVa9k36YJVbZQ+HRzVO7tOrjlUwIKssnil1sT9wPsptc7IWhhZRYCjOHXm6iQ1FtOdZEBOAl7LUMUiO1uech/vKTrgEqo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=oTw79h+8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Gok1pRpS; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="oTw79h+8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Gok1pRpS"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id A46791D00226;
	Mon, 10 Aug 2026 02:03:10 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Mon, 10 Aug 2026 02:03:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1786341790; x=1786428190; bh=ARcTLmiYQM
	Xf31Rrbtqn3IzxBrylkBwUt2fc8lJNvAY=; b=oTw79h+8W3W3uThvcKaE9miVSn
	t1e93ppkgtk6F8QKaKtGmip4vpNSDY2cj+vaN+PJ0KlO5rv3b5149Omn8K2yMc7o
	IhhjGSWygUEtmHV849sLcSBGAuRkPilL5WvcSdzXDSTbS+2AXr7CLXFb70WqwU9r
	gat07FV6dMIqtw9o2W8E+BGnckmo4bhP9V9gGIht9RSSyF4rM+iqFFedCerzTiGP
	ga+mX8rEAX6RPu2XHBiUf+1IoPHHm8fjBCC7P4J8W/jzuqtpYU6qpCRC8aQDvZ1I
	+pff6DKAYNm09bX1uCA6w+KapSrASTrljJzBjwvIarVttikXG+Zap/h5KENw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1786341790; x=1786428190; bh=ARcTLmiYQMXf31Rrbtqn3IzxBrylkBwUt2f
	c8lJNvAY=; b=Gok1pRpStJXza+VbWRsQHs5NukBwR4VYeyuPEs7BfYKAclaTU0i
	OCgmVOtmZqvhWR+iKn5wtMjdPJbRCwMJtLr49LP9JQcPHcehqZmRWpfG90tmOL8c
	6No7ubGet3mQiQ6XOezJos4am/Rr8t12+Q6MPi5Kd3obU2F0Fsflp2N6Cfpfz4n4
	YY5qOq0fZ+OgH9WKJ+i6k4KiBerDcClS8C1xqb7+i64nXQG2F2ZepZooQS2Lzka3
	mdQK8X3v5iirV6uN5+RVqpiPsHV/YR6gjOpPDawfAsYH5OVUO/D2Bzv7ufl3IIBf
	TAqOKGTI2IHxKv0MEaCdkYiJ0zF+SyeKUdg==
X-ME-Sender: <xms:nml5arH4hwl2i8coO9MwcHvtIvF7bnTZ4My6Nc-hqbUGhX7SakY5hA>
    <xme:nml5avPPrBSQxd0PPv5Ps5s8CBFrodgpsbw2xPK7Tu0p8pwB3IqDXoEYbE4awknde
    3bB266SP4pzcDgxFTAJXtNDgKvexWYNzyudnobCHttOo_RlqfGjG14>
X-ME-Received: <xmr:nml5aldvfyFOz9rvSHGM_GrEZtKvXPa6Q3UaMMYWsFILyg1H62mFRg_qEShMOb7evtQMRxp6bGKPikqw60QLbI4L9KiU9e30W3mmadErcA>
X-ME-Proxy-Cause: dmFkZTEfwHlsAUGClsrAxHtzg2goZqopnmVJowJwQPfY+5CTK90kBMPKgOm9WzhtYol9Vv
    /uzUkBT1E3TQFaYBNC2OO8KiQAYwKilPA+v+ZW1O3evVLpf3AR2ISx6o2PVcNi3CNYlgTr
    E5sOGNTWuRC1Og4dlI+8RSOGhGsMBVDIWI4J1TemvfOH69yad24IjpZcA2dqj7D4wsMeRV
    05Dia/5GZkq668KpSpx1gm77o+xGv6qejAqxVx4bRykI/1CGTHtzOPD15tly4hOUauGKgj
    /5GmAhN6m9rMhpZCtdyUG28jrGEko0DY3A2XMBjD3WR0EUCDUAdk8rCyfz/7LI9SnUmgdT
    mod3IFH8dTI82c7lGBCy/XkT/HC2/4YrZSk70Ir0+6t3Dq9PeAY2VLgk7cw0I+4KQySmH4
    /JLs2hNlrOzAaG3Pp2SqpZ9K+OgD7cyMBm8U1krMWoTAKJEJs4H77NbcjWpObe0N14P3aw
    auQDNe1dq16iekXxxLt71xTEYHhVX9lW4fVuonnBdcVaj5VXfyr92h33H5oQ6zgCMlJRVl
    o0x07OUNbx+4dHiETNxYfzSz45wIXgVLvu+VfzmqxYz8j6h9G6abVbJ6u/M4ddKqEo7ooI
    L5rCLnKoEZpljFRSPbK9Zoi+tPBK9GH7MiMd4zVO1K0mugOa068s+8AANUvw
X-ME-Proxy: <xmx:nml5aku8H11TYDgnskn8Sd59IM5nlQFjwghZIP0aZlfcvMeqGCxHNg>
    <xmx:nml5aulK6P1ACfuYKnyTHG5GD5rsheLrMGnA1qD-kuEvAboresd2zw>
    <xmx:nml5auyU_e8q02S1sBbL6eW4xPUbGhKwkMdWezgO6MrGtClzjHoJCg>
    <xmx:nml5aoO4jUqN5kE8O_4VEcuEKarjw0KBSvLlRUyL-gy4NEnYzVSE3A>
    <xmx:nml5aj9KfbXX5nCZmqPgOVGea5ktmaI6rBdKJ_miV3az7YMi8DZFpiis>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 10 Aug 2026 02:03:09 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 79a76f62 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 10 Aug 2026 06:03:07 +0000 (UTC)
Date: Mon, 10 Aug 2026 08:03:04 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>, git@vger.kernel.org,
	Christian Couder <christian.couder@gmail.com>,
	"schacon@gmail.com" <schacon@gmail.com>
Subject: Re: Can we do better than "git checkout/add -p"
Message-ID: <anlpmNSjBUJ8p9RL@pks.im>
References: <xmqq8q6ih924.fsf@gitster.g>
 <CALnO6CBu8ZBDk9YwLW2jVJtBUk1=pvai5QHiLN6XLOOL-3KA=g@mail.gmail.com>
 <xmqqfr0qexps.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqfr0qexps.fsf@gitster.g>

On Fri, Aug 07, 2026 at 08:50:39AM -0700, Junio C Hamano wrote:
> "D. Ben Knoble" <ben.knoble@gmail.com> writes:
> 
> > I raise this as the kind of interface we could learn from: emulating
> > it might be a bit heavier (a full TUI?), but is certainly more
> > convenient to use than the prompt-loop over hunks.
> 
> Yes, the 'one hunk at a time' model was easy to implement and start
> using, but its limitations are apparent.  Users want to be able to
> jump around, starting in the middle and returning to the top later,
> for example.
> 
> It is more or less orthogonal to the reason I started this
> discussion, though, which is that limiting the direction in which
> modifications flow restricts the workflow, burdens the user, and
> makes the process error-prone.
> 
> When I see a hunk, I can immediately tell if it is one of three
> kinds (i.e., those we want to add, those we want to leave in the
> working tree, and those we want to discard from the working tree).
> But with 'git add -p' (especially with the original version of the
> feature, before the 'e' (edit) command was introduced), the third
> kind must be treated the same way as the second.  Then, after I am
> done with 'git add -p', I must go through the remaining hunks, sift
> them into two categories (those we want to keep in the working tree
> and those we want to discard), and run 'git checkout -p' to deal
> with the latter.
> 
> We should be able to improve this workflow without deviating from
> the 'one hunk at a time' model.

I wonder whether we can take JJ as inspiration. For commands like
jj-split(1) it has the ability to interactively select specific hunks
via `jj split --interactive`, too. But instead of looping through stuff,
it uses a full TUI that:

  - Gives you a list of all files that have changed. On this level you
    can select/deselect the complete file.

  - Also allows you to expand files and then select/deselect individual
    hunks and lines.

I found that model to be quite a bit superior to Git's own interactive
mode.

I've been playing around with the thought of introducing ncurses-based
interfaces into Git. I've been mostly thinking about git-history(1) here
so that you can just move commits around, squash them together, drop
them and so on. But I think fancy stuff like TUIs can also be applied to
other parts of Git, as well, to make things a bit more visual to our
users and, as a consequence, easier to use.

Patrick
