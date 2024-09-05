Received: from fout2-smtp.messagingengine.com (fout2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C27E9194A61
	for <git@vger.kernel.org>; Thu,  5 Sep 2024 10:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725533881; cv=none; b=oIbdPGjDk1YZpxYz4EaNYpuQAu16mW38mktETEzxPeQsy2R4x1os6kNDeesmpWispVcoqb4sikmbI4P4qz45dHYPujSzfXOHHwNeoU7DRr3j7ZPsIVJc4R1Uu4g/oqQtFFBZpSjKn149qDTi8OKU7T7S1ucWF7zALpkL5QEFBZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725533881; c=relaxed/simple;
	bh=OicRQ9NBzpqrTojqEfAuSJwiH1AfGEf1i+Hu9/XCuWc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gjZbxSXK3t9PWs+ODIAo1IJ3ql3xrdPYa78Y92JYH8m8zGntu5xhU+Ttd56L/cVoDVghBbDMsQ1SoRG4ORDHAxClD8a9r3jBkdEtQznAucwc9ShwW7rn3pKw6OSlTVZKRm1FkebyiuI6KRh28Nlnhn4+fDw8499NXH6jg1XIDRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=BaXQq8tl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gurnHi/q; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="BaXQq8tl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gurnHi/q"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id EDF671380342;
	Thu,  5 Sep 2024 06:57:58 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Thu, 05 Sep 2024 06:57:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1725533878; x=1725620278; bh=xlQj0henVE
	x/4X6GPhPOGmr7yOOHzgqH2nF+XbYhWSg=; b=BaXQq8tl9awSptWHCZF3vsqaze
	D43w6nsOXsKXGf0T6pXVHiLvRQm4K6gEvQUQ8Nf2jf9/TtU8bFIAH1dr0PgnL87F
	EvY2zoG597SWhWPm4M4qlyq1nxXITkb1KfUCVXvkhnUg6wgkcMyFTI1ZXDWLuoVV
	bGRFwkrmHVcC3IV3AqfysHqn7JXCI9kpE1dMDoaSWXQ4R7iVZNX+128K8BDmcFsG
	ac+MC5iPA1MLO/zUL+evKIlwtQ/UFsLQs3aIveMH4TUQ9RLvcG6bV/hAKi0MbM0P
	ac21Qn8dWpNtsrO/EAy4c2k2rQoODwaoVtm479wPeC6lTX+7ejxWDyKfLQvg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1725533878; x=1725620278; bh=xlQj0henVEx/4X6GPhPOGmr7yOOH
	zgqH2nF+XbYhWSg=; b=gurnHi/qF4LO5UquXSvR58HZwNkY9gJAbH2IS7L1ax/M
	xyk0K6O1aF2Zw/4kMKFQNHKmaAZWWDcuMxZe5V4sjoEQ6ydqypMvzvayPWpJR+2M
	JampJ364SNCM4TGbtAvtVgI7yIgOqwnqdjMaGiLDr5R9bfV9g0kEiCMb+PiNPa6l
	yLAE1iayPFs+/8uhjhMBz+eTRNZqPnCLAbB8GXhEiJZv/zoJKaUdjdh9wOLb3d5O
	8TCa2iyWSa0AnnzqztMXjVTsM56MrzHJBFSc/bsWIikxTJd8zI9GL9eT5z4kR1Ul
	mXqdZk98fwFOdlr3n4FRqrbazZMnwL9m41klC+b+gA==
X-ME-Sender: <xms:to7ZZplTxFOyx61q-DYQogUIEDMa78yFOZjx2zDNDHSR8CvKyEBp-g>
    <xme:to7ZZk0qtRTl8IqhuPucBL0Jgkt026OpfisB7WE-5DwnrIynxEuxclnOLlXPTV7Jn
    aLA4mssj1DSdViikw>
X-ME-Received: <xmr:to7ZZvqIgFF4WuVdmMBNYv1znHhntNFeovPZp1Lo4BOIw_m86gOpMM7HOxF2qEgHZTUi6saVlk4odTzSv6RlR7VFuL7xgukfejxsgg_xFy_Rtpc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudehledgfeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvve
    fukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeevkeekfffhie
    dtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsg
    gprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpvghffhes
    phgvfhhfrdhnvghtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:to7ZZplaJoaZOaQ4T37bMdun-dAVHZkC1JRzeEJ7qmrfs2MPz2wq7w>
    <xmx:to7ZZn3NCQOd06gAMvqBRu_Z4UgWCHi7sPQlEhfi9OlEgyy12TDcWg>
    <xmx:to7ZZoto7W9-RryijgMGR95BuKXaY9DpkZE5t0lEuOrQl7Z5Laa-6g>
    <xmx:to7ZZrX2w1DJGgcpwUyGVl9d_rm2FQTZrJ4jZtyrs1_pdWhvHwD98A>
    <xmx:to7ZZlAtwI3kFPDFZJoFkN_itRNenaLn6yY27MwLdMf9OxfZbvbDge6c>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Sep 2024 06:57:58 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 9fbad39d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 5 Sep 2024 10:57:46 +0000 (UTC)
Date: Thu, 5 Sep 2024 12:57:54 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] drop trailing newline from warning/error/die messages
Message-ID: <ZtmOsjjcMZ4nEsQN@pks.im>
References: <20240905085149.GA2340826@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240905085149.GA2340826@coredump.intra.peff.net>

On Thu, Sep 05, 2024 at 04:51:49AM -0400, Jeff King wrote:
> Our error reporting routines append a trailing newline, and the strings
> we pass to them should not include them (otherwise we get an extra blank
> line after the message).
> 
> These cases were all found by looking at the results of:
> 
>   git grep -P '[^_](error|error_errno|warning|die|die_errno)\(.*\\n"[,)]' '*.c'
> 
> Note that we _do_ sometimes include a newline in the middle of such
> messages, to create multiline output (hence our grep matching "," or ")"
> after we see the newline, so we know we're at the end of the string).
> 
> It's possible that one or more of these cases could intentionally be
> including a blank line at the end, but having looked at them all
> manually, I think these are all just mistakes.
> 
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> I just happened to notice one of these, so I grepped for more.

Do we maybe want to add a script that detects these via a Coccinelle
script? As it turns out, Coccinelle has an embedded Python interpreter
that allow us to extend it with arbitrary checks. So the following
script would check for trailing newlines in `die()`, `die_errno()`,
`error()` and `warning()`:

    @r@
    expression fmt;
    position p;
    @@
    (
    die(_(fmt), ...)@p
    |
    die(fmt, ...)@p
    |
    die_errno(_(fmt), ...)@p
    |
    die_errno(fmt, ...)@p
    |
    error(_(fmt), ...)@p
    |
    error(fmt, ...)@p
    |
    warning(_(fmt), ...)@p
    |
    warning(fmt, ...)@p
    )
    @script:python@
    fmt << r.fmt;
    p << r.p;
    @@
    if fmt.endswith("\\n\""):
        print("{}:{}:{}".format(p[0].file, p[0].line, fmt))

It doesn't auto-generate the patch for us. But at least we'd notice new
instances of these via CI. Output on top of 2e7b89e038 (The twelfth
batch, 2024-09-03):

    builtin/bisect.c:586: trailing newline in "revision walk setup failed\n"
    builtin/bisect.c:1111: trailing newline in "revision walk setup failed\n"
    builtin/push.c:639: trailing newline in "No configured push destination.\n" "Either specify the URL from the command-line or configure a remote repository using\n" "\n" "    git remote add <name> <url>\n" "\n" "and then push using the remote name\n" "\n" "    git push <name>\n"
    builtin/rebase.c:1410: trailing newline in "It seems that there is already a %s directory, and\n" "I wonder if you are in the middle of another rebase.  " "If that is the\n" "case, please try\n\t%s\n" "If that is not the case, please\n\t%s\n" "and run me again.  I am stopping in case you still " "have something\n" "valuable there.\n"
    compat/precompose_utf8.c:158: trailing newline in "iconv_open(%s,%s) failed, but needed:\n" "    precomposed unicode is not supported.\n" "    If you want to use decomposed unicode, run\n" "    \"git config core.precomposeunicode false\"\n"
    sequencer.c:3824: trailing newline in "execution failed: %s\n%s" "You can fix the problem, and then run\n" "\n" "  git rebase --continue\n" "\n"
    sequencer.c:3834: trailing newline in "execution succeeded: %s\nbut " "left changes to the index and/or the working tree.\n" "Commit or stash your changes, and then run\n" "\n" "  git rebase --continue\n" "\n"
    unpack-trees.c:408: trailing newline in "the following paths have collided (e.g. case-sensitive paths\n" "on a case-insensitive filesystem) and only one from the same\n" "colliding group is in the working tree:\n"

The last three lines are a bit of a false positive, I think. All of
these calls are `warning()` messages though, so we could potentially
just drop those conversions.

Patrick
