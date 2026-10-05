Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 967453090C6
	for <git@vger.kernel.org>; Mon,  5 Oct 2026 06:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791183468; cv=none; b=mcxcRx6aFEG1zizxKCE1wsXs8JOmTH3zpgv43msbLIvVGp4x5aHO6OeiESjH50PSqGOymIIoZ83W/RVXMxV3jD5oEmRxi0bs/7NFo7FsiH0ycZ7VUYuNU2oCWeYkEa1r6jZyXBkHkySjG9pC3XJFAOMLY4u4KOjANj1fpgUEBHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791183468; c=relaxed/simple;
	bh=cG5b2Pt9O0iRk6y/LIS7X4Crvhr8ivaKwOFrTjpW7rM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SXvQ3xbJxBW8oVd6y8r+zXenvv741s4f5jhjFmZcykh+yHjKwENvpiaQehFSJ34Ibz3Ur8lnRDuQ1TLlVy0+xOvO1ojSKUS8LDjECAZc4LBBFYfFTBh5uCert7CPhsFXrBZboTof14W2NFw3MZggzIhlNDBkMdelTRVJSclfLsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=g35d2/1i; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=I3TBxzjE; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="g35d2/1i";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="I3TBxzjE"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id BCC1B14001E9
	for <git@vger.kernel.org>; Mon,  5 Oct 2026 02:57:45 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Mon, 05 Oct 2026 02:57:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1791183465;
	 x=1791269865; bh=NakD5GCjpW+e2wQMHytdejosCqRBYI/nEt8EYAr7TaE=; b=
	g35d2/1ix/+IDjDp9r+doAe+QBy10mKbEbbOXb+TEEGwSVX1wIcwjAx4yuk2/gTk
	rQhmaYfRBiwL6xY2Z0vUJxYKo+BSsev0NyByrJernXdaM9IH0gmeujGPj/i2fs0J
	hnQI7Bo0fdXWOLNne2rqat6ZelQoPUWhuQtMsp7d8JFN/iRSMiXNMvqaPU+/1apd
	LXPHEZQIBmw93Og8NtUhlRSDRvDTIsnFrakXLDMqPmBtl7vg29PIKICmcKFmI2sT
	JZjfw7vL69Erq/88KSonzmdlx7SaSJ4wIj4Qkqq/J07hvwptqLByK3RoRhc1pzTG
	2EeNKzxcI3Nk4xqJFLycBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1791183465; x=
	1791269865; bh=NakD5GCjpW+e2wQMHytdejosCqRBYI/nEt8EYAr7TaE=; b=I
	3TBxzjE0LCyp5mhw7PEE/s/K5twMWnd1M3ACXHM9GYSh4TOY+UVB1HkMKfnYVfNa
	8RO/OR0vSkrs7RW0IH/ioQ25JsAwhieecVNm5SX8WZbFgskL+RKgnDUAm1fpk94E
	fkl6J/8kNC95wku9O/vJKBFVGYt/lZflkoICfug65LV7M7BheSSxSAci/2G0Pbg9
	KDqvdDefugXB9YjKpppeCjXNcQ7Z2h2q8loYN5vwQe9I//6aqh/M5iSDpCbNIV+I
	zWYUdT7/uLR2nlt9dEViJZYRAoaXb8sggVO8TRVnarkBC7y8QWaZzGw1C06W/f3V
	Znqr5cniBhvboYc1418uA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791183465; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:rj86/PwY8GXGI6z/Qb60Uj50CfwLo0o6UXPtKeJ8C0KMffI
	pZvjYSWVGZzLAWGXK/q+/5ouLK+goJ/k7IaiJ/4lbHG9y5ohpTrusCkElFBLX9zx
	kQjeYT1E7TcZuKcKgthfUX7ehcFdn5eb+zQleAX+RkIDbKzt/UpDuxaYEmMSwAmC
	qdamDCS3zasN2jvutIeWR/4ACpdo1CkkmGsHJlQ/EwAEF79jaIWu2il7a2Q01y7J
	+2xwfQpfXh9Ha4zPZXh6r8qigLYoviu4ly3HCD8ImSMpUSDzWI6s9qeGF2OtlR7E
	ClYD3bWpMYS+OxC1KiW/MRY6dK5XHh00XthzqeQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=mi-m=1; hc=13;
	hn=cc,content-disposition,content-transfer-encoding,
	content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:JISlN2vaprPKs8NkdDtO7r7z5Y+uIw3Uan2/2JHJAR0=:cG5b2Pt9O0iRk6y/LIS7X4Crvhr8ivaKwOFrTjpW7rM=;
X-ME-Sender: <xms:aUrDapOdna8ibRXrmJZSgk7wCR77XFyq9i-NAhYgmKbtoV5qiiDaeg>
    <xme:aUrDah_JxfducSr86VlhdIR8ro1yEctKdjq-YSy9qqUlQANs8FwTWP0pbY-810LuB
    byTUVhbJb1xysE3MR3nZNnBE2Ghcwl9vQzXpu6ZuCgBufl4GDcA>
X-ME-Received: <xmr:aUrDal5yxbBO9nnV-wI3B6os0CDjgyqhuX5w-dPPNFZpuxLQll86uiHuFLT0I_pVB7dsgAs>
X-ME-Proxy-Cause: dmFkZTFEqu5DM9tIqLX6TUegQUaFQtA73ctzv6xv0r9PAWtNhEP4r/xEdLQT6DVkDSE5Tf
    YJG8b/SCsh68BSYJ8MP0777TTQcu/9Og8C6zfGxOd74poQiw6KQJfyvH6xRSkC2DUlGjq6
    knLyNEFR9zyMwROMfDxG2B0EJcrQx+IWZfG/nMJMN9RerlXOEFUIOL/zHEQjQrPjD/25fT
    SCO8VJDRfcP5I6JWjNAoubcItJScELegr4bHpD9UdFjOA0QRdMSK+vIU2TM9S+MYgH7eSt
    l5q6RGqxVzHybP60UXe3Ie7c/0WOPSqIlj1cOfsJo9awFV+NzuWjmUkLrTWD2G6iBMJBXu
    nCKO4S6TjGJpYSUIOaRWPyg05T/BpeHEmN1iOOJlmXXqIKKYdyVzw3ZQd3SHhcfhgGSQBv
    9S9ctf6+YmyDE/+c+8QcujNUUiekT5F3x5o5N5QX32qeiO5LNjCsZElnf4hEIKTtoqPqGL
    uMnKLmfwGKgdzCAkn4XtCVA6Idu6pRczB1XZeO6JMAmLs4hSLAHootEXP0XOmlgRCk5uju
    ql8d+/H9oibu0lnlMFUKzJWiw815vTOIntZoQBoLeVb7wH7ke17ibOFGjJLOJzqVaccMc8
    1xgZ5OdDYR/jt2pYuEM44IWMGN0MUUG68G9rJRTEeQEqLOtGMrHNOa1uE+5A
X-ME-Proxy: <xmx:aUrDag1vVMM7AklvlGP6Z6b7rI_1OMjPk_ZJNDdWrJDel9mGvAvEFA>
    <xmx:aUrDakB0e5bQUJ5dyhzta9m40mwf69n_0R5Ymkz1AbyUCiOMT3xD6w>
    <xmx:aUrDaq3qmUVtU4Es4vmPmvNCegBANUZgdeqSkx5_G2rAac9d1-v-XA>
    <xmx:aUrDamsMcSTLLYNWDMl6a3UKGuMDV6zR4QMrRRZ0_hDYiMEbamLdIg>
    <xmx:aUrDar_50NiIIVr6JBriSMl1W7sHRKQBhFfcBvVrXwxgyFbywvoh8sT->
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 5 Oct 2026 02:57:45 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id d9ee5284 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 5 Oct 2026 06:57:44 +0000 (UTC)
Date: Mon, 5 Oct 2026 08:57:42 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Sphinx <sphinx9692@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: Question: behavior when reverting a commit from a shallow clone
Message-ID: <asNKZpxiuFhVkVQd@pks.im>
References: <CALfz8Qx63qNoSbXq7C7u+KwX4=HCL7=uOUahpXd6j7KvW_c_Eg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALfz8Qx63qNoSbXq7C7u+KwX4=HCL7=uOUahpXd6j7KvW_c_Eg@mail.gmail.com>

On Sat, Oct 03, 2026 at 02:24:42PM +0530, Sphinx wrote:
> Hi Git maintainers,
> 
> I have been investigating Git's behavior in a particular destructive
> scenario and wanted to verify my understanding with the maintainers.
> 
> Consider the following repository history:
> 
> A -> B
> 
> where A contains the repository's files and B is the current HEAD.
> 
> The repository is then cloned with:
> 
> git clone --depth=1 <repository>
> 
> so only B is available locally and its parent A is not present in the
> shallow clone.
> 
> If an operation is then performed to restore/revert B, I was looking
> into the behavior when the resulting working tree/index becomes empty
> — effectively causing all tracked files to be removed.

Yeah, this can indeed be surprising behaviour. The reason for it is that
in a shallow clone, we rewrite the boundary commit (so in your case B)
so that it doesn't have any parents anymore. It thus looks like just
another root commit that has added all files in a single go. And the
consequence of that is that reverting it will then delete everything.

Now arguably, Git could be improved here. We just recently had a similar
discussion around maybe forbidding to "git commit --amend" such a
shallow commit. Your scenario is a second one where Git should probably
at least warn about what's happening.

Arguably we should even completely refuse editing such a shallow commit
by default. I would guess that in 99% of all the cases where a user does
it it's unintended. And for the 1% where it's actually intended we could
give users a way to override this safeguard.

> I have gone through the Git documentation and experimented with the
> relevant Git commands, including the behavior of shallow repositories,
> branch deletion, working-tree changes, resets, restores, and other
> destructive operations. Based on my investigation, I have not been
> able to find evidence that Git provides a warning or confirmation
> specifically when an operation results in all tracked files being
> removed or produces an empty tree.
> 
> Before drawing any conclusions, I wanted to verify this with the Git developers.
> 
> Is the following understanding correct?
> 
> An empty tree is a valid Git state, so Git does not generally consider
> transitioning from a non-empty tree to an empty tree inherently
> erroneous.

Mostly correct. A small correction though: Git considers the empty
_root_ tree to be a valid state so that you can create a commit that
contains no files at all. We never write an empty sub-tree though, so
you cannot add an empty directory.

> Git does not have a general safeguard that warns when an operation
> will delete all tracked files.

We try hard to not lose a user's data, so especially untracked data is
something we're careful about. But anything that's committed already is
fair game, as it's trivial to restore.

> If there are existing safeguards, warnings, configuration options, or
> historical discussions that I may have missed, I would appreciate any
> pointers.

There are none for the above use case, to the best of my knowledge.

> The reason I am asking is that I am trying to establish precisely
> where Git's safety boundary is in this scenario specifically, whether
> Git itself is expected to warn about the resulting empty tree, or
> whether detecting an unexpectedly destructive tree change is
> considered the responsibility of the tooling performing the operation.

I wouldn't warn about an empty tree in general. But editing a commit
that is a shallow boundary is something that I'd agree Git should warn
about, if not even refuse by default.

Patrick
