Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87F9D849C
	for <git@vger.kernel.org>; Mon,  7 Oct 2024 08:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728288220; cv=none; b=t61fDgmu4QRbiatOMaXDaYG8VJre9HT5OQ4oqbc9KcP6cl67L+i4hbbrrQIGsM+f94Db1wHSO4+UNsh6QiPhVvS4jOu0OoJUPhKmAIZy9DlwLHuWz5RaU4IiD1jbSZ/gBws4D8cTGtkmrk1a+XV8Jcy3t4Fa725NNYuP6UihYJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728288220; c=relaxed/simple;
	bh=ssKm5X4kYJcccVT7+UwhlULt5+8x0SMWqJ2VaHZOi1k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FDvr0TLTaRkB7QA/6rLI4cxNXV1RSfxV6gSgR+7zMnmu3BWosdZwpj/z9re9ipy+hFc0TYEZA16EoBPU4UNTuTU7AMIOZT9KLpF+KNFW2VyJaXoJumGDZAtffeeSDv/61uk495B9OCb0yhEtvfWnYVP7B6Bz3ij8nvN0B+5as2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=C+Ks7bXO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jTMQ8KZF; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="C+Ks7bXO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jTMQ8KZF"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id 767EF11400DF;
	Mon,  7 Oct 2024 04:03:37 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Mon, 07 Oct 2024 04:03:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1728288217;
	 x=1728374617; bh=t0YSM3o7rTKM+Iq09HeyHE63Mekolt4vu0A5NqxjjaM=; b=
	C+Ks7bXOunzie2cU37ertT9RZiH07pyoMhBgtsX0kIS2oBxFb4ewoLBvEX7oSGeZ
	sq6WEXo0juIvu9cNgN2/R9ZJi2LLytyRmGeLU2Fwpl9XzzVpcUM6c38E6Liz2GSA
	VmuzyH5O45uxssBwv8WvE3sW9st1dHFDV5yMPsBRmsc1irKGDl/+/VKopKBEOOn7
	qDyCuoKtXALWyRnlXuRGyyaaMXwFg39gVjZDQU+md2MfcwyAcSuc/hPJ/wmJblDU
	Qg8C2gzLGdMvjXxFE5qUSxDFPaEMjqPTZt/yiSRxhwPqAcrT4vxuC4Sq5BR9s7qe
	XyHHwwHWPKRuPcbG1VY3tw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1728288217; x=
	1728374617; bh=t0YSM3o7rTKM+Iq09HeyHE63Mekolt4vu0A5NqxjjaM=; b=j
	TMQ8KZFUap+Ow8QNac2e9kl72+/HKbnvYVLjsLRwl9VBwpatGG7ze9rKyhGS1R/W
	kgt6XHn5DM86INorsAeWIkYBeDV7KP0wXnzdykevwYQXkaWOYvBWImN3ctRZFz+q
	G9NbdebmXXo68s02ntg1/DiokNQBEWNuvS5YPAASncJSCf14m/DkGxwgWt9OG8w6
	DxnfLJzj6PD0VnOKa7JLiF/Ay+r75AYCFJaWjlME94lgo/WwTi/Lqgq6jnV0ovjD
	7YjZGLDZPZjZebL/O40CqRLgHlEqGHKNY1WgTVIgferDq5vv/XE79Qr/ltQh5rFO
	in4uxWDZowt3t5SSce7+A==
X-ME-Sender: <xms:2ZUDZzeS3jUMn_8SzASKK-FfV7x-eYY2a8n0scgflcjEALyNZLxjig>
    <xme:2ZUDZ5PHy6vM1bQE6kmHrIwBtyBK0bpIQWVYdJM3Z1ei-HoFioCYjf3nW0rOX63Zs
    vDVPnkFDqz7hjaOxg>
X-ME-Received: <xmr:2ZUDZ8hj9qewY2NpUxq9WM-noRrFvr42_YWbvxh-RRdymYI5wmaQabcv4E6jFz66SYdwqx5ZV_T7V92kw-H4OLVNYoiyA1KRTNEAKjo_bA6DwpCP-w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddvkedguddvkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtugfgjgesthekredttddt
    jeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepfeehffegfeelgfeiudelheeuuefgieefveejjeev
    leehtedvgeejgfekgeeugfdtnecuffhomhgrihhnpehgihhthhhusgdrtghomhenucevlh
    hushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdr
    ihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhope
    hkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhnuhgvthii
    ihesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrd
    horhhg
X-ME-Proxy: <xmx:2ZUDZ0-Y0ZIwpbXACUsh1lU5LMq_vSYTHuVYPHg8O6qpS_ixV4pESA>
    <xmx:2ZUDZ_uXLPnAFVB3KgwAlvjYejiJ2mQKKoJYeWfz-3eSD1Ua8fNJxQ>
    <xmx:2ZUDZzHU0m58VW4hZV1j2tE-K9ZjTU6pnGfJzPfnxV6Wmk4ESQl7oA>
    <xmx:2ZUDZ2PwMSjIQqcsdPNIPotDnmnvoBF6s2rk-DrRl-lQTkdjRO6sig>
    <xmx:2ZUDZ_IutTqPvaYEBodmyLpXVpmw4j6GGMqkgKbhqe8q7JMarlSzuHjd>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 7 Oct 2024 04:03:36 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id c3516acd (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 7 Oct 2024 08:02:35 +0000 (UTC)
Date: Mon, 7 Oct 2024 10:03:30 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Gabriel =?utf-8?B?TsO8dHpp?= <gnuetzi@gmail.com>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>
Subject: Re: Bug: `git init` with hook `reference-transaction` running `git
 rev-parse --git-dir` fails
Message-ID: <ZwOVy4FltrEjxHn_@pks.im>
References: <0084cc18b6d90ba14849a7f788939f4a1d0d61c9.camel@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0084cc18b6d90ba14849a7f788939f4a1d0d61c9.camel@gmail.com>

On Fri, Sep 20, 2024 at 12:07:53PM +0200, Gabriel Nützi wrote:
> Thank you for filling out a Git bug report!
> Please answer the following questions to help us understand your issue.
> 
> What did you do before the bug happened? (Steps to reproduce your
> issue)
> 
> I set `git config --global core.hooksPath ~/myhooks` and placed a
> `reference-transaction` hook in `~/myhooks/reference-transaction`
> with the content:
> 
> ```shell
> #!/usr/bin/env bash
> 
> set -e
> echo "$GIT_DIR"
> git rev-parse --absolute-git-dir
> ```
> 
> then I ran
> 
> ```shell
> mkdir ~/test && cd test
> git init
> ```
> 
> What did you expect to happen? (Expected behavior)
> 
> The Git repo `~/test` should have been initialized (and the hook
> `reference-transaction` would have passed successfully.)
> 
> 
> What happened instead? (Actual behavior)
> 
> The hook `reference-transaction` crashes since `git rev-parse --
> absolute-git-dir` with
> ```
> failed: not a git repository: ...
> ```
> 
> What's different between what you expected and what actually happened?
> 
> The documentation says that `git rev-parse --absolute-git-dir` inside
> the `reference-transaction` hooks read "$GIT_DIR" if defined (which is
> defined!) so the `reference-transaction` should have passed. I assume
> that hooks should be executed on properly initialized repositories,
> right? Therefore I do not understand why `git rev-parse --absolute-git-
> dir` fails -> Bug?
> 
> Anything else you want to add:
> 
> This came up with `Githooks` hooks manager
> https://github.com/gabyx/Githooks where we use this command
> to locate the current Git dir...
> 
> Please review the rest of the bug report below.
> You can delete any lines you don't wish to share.

Thanks for your bug report, and sorry for taking so long to respond.
Reproducing the observed behaviour is quite simple:

    test_expect_success 'git-init with global hook' '
        test_when_finished "rm -rf hooks repo" &&
        mkdir hooks &&
        write_script hooks/reference-transaction <<-EOF &&
        git rev-parse --absolute-git-dir >>"$(pwd)/reftx-logs"
        EOF
        test_config --global core.hooksPath "$(pwd)/hooks" &&
        git init repo
    '

This breakage is new in Git v2.46 and comes from the patch series that
introduces support for symbolic refs in the reftx hook via a8ae923f85
(refs: support symrefs in 'reference-transaction' hook, 2024-05-07) .
Before that change we didn't execute the hook for "HEAD" in the first
place, now we do.

Now the question is whether this is a bug or not. When the reftx hook
executes the first time it is when we are creating the "HEAD" ref in
the repo. Consequently, that file did not yet exist beforehand. And as
Git only considers something a repository when the "HEAD" file exists it
rightfully complains that this is not a valid Git repository when you
ask it to resolve the repo paths. So conceptually, the behaviour here is
correct.

There are two ways we could fix this that I can think of:

  - We can create a dummy "HEAD" file with invalid contents such that we
    do have a proper Git repository when creating "HEAD". It feels like
    a bit of a hack though, but we play similar games in git-clone(1).

  - We can skip execution of the "reference-transaction" hook during
    initialization of the repository. But this would make us miss some
    ref updates, which feels conceptually wrong.

I'd rule out (2), but (1) could be feasible if we label this a bug. I'm
not a 100% sure whether we should, as you could also argue that this is
reflecting the actual state of the repo. I'd be happy to hear arguments
in either direction.

Also Cc'd Karthik, the author of the menitoned change.

Patrick
