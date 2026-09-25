Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB76D4BD7A8
	for <git@vger.kernel.org>; Fri, 25 Sep 2026 16:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790352561; cv=none; b=bSusn1KYhrHDmvcvFyioWqkMBEu/NwUSiAFBFr1WBplOjB9HgK9qyP1QrjWWcPVF4OmqIdwv9OqOySLbSpI8RXo3YRoo82vVacLOSfaGUS/CHF3NQWZZL1JEpVQ7sLnA9sWbRKVMMVemZPmReLCWoE+uaiRM9rivzLdKaul/2rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790352561; c=relaxed/simple;
	bh=7UK9jLDejJrK3s6ajM0C06NLU+c2QbaexXLDJnVz7r4=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=vF2recwb9iHCLHhMc9cs39KD7DwXb+udEE/g7YOobQ3cp+aeMbBnszJPkEQAW5MYlv/aQ3nIH3fwEihl3q8kwR7f0cfh1XliuH9FqHptZgWoB/UsstDuaLYiklSnoOu98FovRF1JnybkKglKORomkRVbnQ2cVv37eUrEB4HfWcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca; spf=pass smtp.mailfrom=jvns.ca; dkim=pass (2048-bit key) header.d=jvns.ca header.i=@jvns.ca header.b=fD3O//Jf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=aJ6Gx0H5; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvns.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jvns.ca header.i=@jvns.ca header.b="fD3O//Jf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aJ6Gx0H5"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 30C74EC00F4
	for <git@vger.kernel.org>; Fri, 25 Sep 2026 12:09:12 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-05.internal (MEProxy); Fri, 25 Sep 2026 12:09:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvns.ca; h=cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1790352552;
	 x=1790438952; bh=NopDy+SxJqcb6aGAmo5yR+wSgS0JV7uwarffaKPNMII=; b=
	fD3O//Jf+uyI3CS0moxcs9Vb4tSkRjzbcekyU+0FCQgp143rrZLFJ4ZhTv/dePLy
	P2cTLLDsrIXdYQI3+MI5ci5Xqb4VJNU4ISAiQ55u2ipn7w9NYqE9b2Hb9ALsLr1X
	S6CLN66gtPG6Ehs8ddgcKJhvWfnAzc2jfMWExCsk01vbjlQPnDqYwCZKPD4TRbhW
	y3h89+79tzwEdd2imYtI/ciIMRhEGE+fkdYrpxDNd3kDJKCmmtxuMXzVmy2CdxmA
	ul37bnyIGLU+CSNVb8Z1zKHAJNO1HsEXsUz2MH36BjoiHaP/b+HFmNKPyJDn3Znl
	EEsw2LchfCNbSb224mGmeg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1790352552; x=1790438952; bh=N
	opDy+SxJqcb6aGAmo5yR+wSgS0JV7uwarffaKPNMII=; b=aJ6Gx0H5EpIo/Vstd
	KzMo/FptaXM0f8PbGPweODASLk2iobvDcnBcyp8RdbcaSzJCsZpH09b7f+XrERjD
	W6RxuiKrENL+/uwjYaAB7W0HD3CfmWNtCwLEoeUW0ZvJAmN6jL/mXAew1uQ/M4Ft
	PhcMvSNBefjgAN6tx3bMw2z4CIZapo56wt0D7gOBRwcdKnhZ68rwyPZM4BweNN3B
	C8wj/cxfvxRTL5cQJtf6Ofj8nmRH6GcHfQS/Scc5zm1l3r/9z30eJhbosVuSF8MS
	hF7a7OFWRqJE6oJVb55wWBLPmNzaj1zVj7AYm+fuwO0a1ig7HnOIuMXJArr86F4z
	FmQSQ==
X-ME-Sender: <xms:p5y2an5fzCcIc_2rnXOChTcJ8Ge55iDZtNzA7kft_XGESOjGHmtdcw>
    <xme:p5y2anuwhrfgvVOL5KreODSwj-93RmlPKQjiBvFMxGyzn7TWFLjNfahSTqUPlgirc
    FdcmDF3fRXh0s8AEaK5Ds7r7IGocuj7G_46Aw6Lzhfv4QHJLRxLWzw>
X-ME-Proxy-Cause: dmFkZTEyUMXU5NUvtOfUSd7axL6oUnAFNZlFcoYjJz0I6HnyvWowGQ4CXx+HeWhZm0s+7K
    lt55XxmLOlnMFUVMgxEOXrG6d/GsQXLlllgTBFxMNlGUo9btM0/d0L0jd7o1+9qzWdV128
    o4lsrmXblDHQ4GSwICAQGDGWWxoRQaLUfKdyln04T6WHQqWfRBex8LqSxAviGruQdNoE6S
    p34+OWj86tKzCW4X5JwZL5Bo0Zym6DLgFfMbLLFW2cdFztB5iSAIvuVRQDT/AmYj4DswNC
    j5R7NQnJ4pjWGqCfEBuBpfiUE2hLZ2AvRM8phsJz1RgiQVRzg9CmDrreFXDm4/E6yr4CEX
    5fE4E+ObLjJk3i6dYujqslL33PkUoLH9ZgYM1ulSbOxzDW6QkQ4VdEbqyLe8IjdavRsE0s
    fLtYS4B2RcDYMJ+2XvtdRl4Z/OvB9xT9+ICwgKNjQQSyBpqx7vS59vJrc5ZAjx5WlG94fk
    EkdhBA9jg/FtrN8ugmE7AgQEkcrUWDlIle74j8RYpvBLo5UFlYECLBilCK4+EqUVWVf2xK
    p1neZQhrYfRoekJ3aFXz90SHtUsqbm9/YXTSyuf8HxzTouu8JDgonGsnj3sKF/zRJk7s2x
    XyatIvXSBmuTrbC3mwHl19VzO2rj09NMAoTgk2V/MVksejKwtiKH0D3f3k6A
X-ME-Proxy: <xmx:p5y2akIfk1CaDPWOXoFg5UKY-RslzCuKvZRFuMB_LMstpyEk5VhHsg>
    <xmx:p5y2akEcB_LM7c0g8O7m4WAw93wF-4Lm7HAP3IY159HDw1f7I6vIwQ>
    <xmx:p5y2ahljenstahSIk3c_ua9g0Xdipcep763SCqRk_BijoyEnuhnb7g>
    <xmx:p5y2apKU21JkhkTljQzQC2W895hYqptK39a1ohcwsCED2YF38zFWqw>
    <xmx:qJy2auf1DoSqBuiRVpk4iw60Vd1Bq5pGE9ehYF5ry04bMdFJiO3NiyzV>
Feedback-ID: i2aa947c3:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id D7950780070; Fri, 25 Sep 2026 12:09:11 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AGBSJuH7AubZ
Date: Fri, 25 Sep 2026 12:08:51 -0400
From: "Julia Evans" <julia@jvns.ca>
To: git@vger.kernel.org
Message-Id: <bd5d9451-ac5a-4274-9a7a-57ae99864fe9@app.fastmail.com>
In-Reply-To: <20260925082723.GB1493716@coredump.intra.peff.net>
References: <pull.2416.git.git.1790105342890.gitgitgadget@gmail.com>
 <pull.2416.v2.git.git.1790297546771.gitgitgadget@gmail.com>
 <20260925082723.GB1493716@coredump.intra.peff.net>
Subject: Rewriting the Git tutorial to cover less content
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hello!

I'm working on a patch series to replace `gittutorial.adoc` with a completely
rewritten tutorial, since a lot has changed since it was originally written.

The new tutorial will cover much less material: just `git init`, `git add`,
`git commit`, `git status`,  `git diff`, `git push`, `git config`, and `git remote add`. 
One choice that might be controversial is that I'm not covering branches, 
though I think it would probably make sense to write a second tutorial on
branches and using Git to collaborate later.

The reason to cover fewer commands is that even this smaller set of commands
is a lot for beginners to absorb. I've already gotten feedback from a test
reader that they appreciated the "you can stop here!" in the middle of the
tutorial, since they didn't feel like they could absorb any more information at
that point.

If you'd like, you can read the current draft here: 
https://github.com/jvns/git/blob/git-tutorial/Documentation/gittutorial.adoc
I'm not looking for detailed feedback at this stage since I expect a lot of
the details to change, and since right now I'm prioritizing feedback from Git
beginners who are trying to learn Git for the first time from the tutorial.

But if folks have major objections to the high-level structure, let me know!

I'm excited about this direction, I've already gotten some positive feedback from
test readers, like:

> I can say I liked this tutorial better than any of the other git tutorials I've tried.

and

> I really like the tutorial, it's easy to follow and I learned a lot!

I have some ideas for what to do with `gittutorial-2` too but I'll leave
that for another discussion.

thanks!
Julia
