Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5282A2629C
	for <git@vger.kernel.org>; Wed, 24 Sep 2025 17:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758734514; cv=none; b=cqLMC/1RtIaUMlhvZbFpmQJCjKIBvgYEcWdex5H9JN+4wF/SAqGHHhEI3a+HajoRGere9udgp+yARSMynWuckYZEBNZWGnjWRaMoaimJj8/Gc27ZgB+GdJFSTq2vW449n/E0zvg/7H8d9AItXK2hq72TvXYrxf51+P9gY5l8Rgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758734514; c=relaxed/simple;
	bh=/ZWaNtmm4JVqbzxavg47xzHdUoxShF/CHrlm/U9PUro=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=lDBzSNlR7NF12fFiOt3DZdZpJ1WAMFT77lVj9+UfgxK3SqZgmMpGxU6SgvhKcyomh/PNxBuvKTG9r2MYUspEhr2YAZ9YzO20I6ypsTChw7fRTbmoMTKulvlOPBa/8dGdYQx8LRmaNSGk7pP5fQd9rScj1ded2n5UGo8qArBOcGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca; spf=pass smtp.mailfrom=jvns.ca; dkim=pass (2048-bit key) header.d=jvns.ca header.i=@jvns.ca header.b=PvDmGm6K; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=j7kEMbWg; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvns.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jvns.ca header.i=@jvns.ca header.b="PvDmGm6K";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="j7kEMbWg"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 5DB911D000BC;
	Wed, 24 Sep 2025 13:21:51 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-04.internal (MEProxy); Wed, 24 Sep 2025 13:21:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvns.ca; h=cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1758734511;
	 x=1758820911; bh=OcmFh+A9qbHUhQZ1theZRGaKFeq8gRp0eNr/Hqrvz1U=; b=
	PvDmGm6KPwElCnhOpqy2Q+vlgUvDSWB4UmENNidemr0sagnUVQdtafo6AtNZAU58
	OicxonwLWf/vVVdKWaffbeCN9T9ca/vrcdfVVAR/XQr5MbSI2FwVGqd9NUfDMCNx
	nt6WpeMKf1LFLREo2DjlDJrwy2d5WULWj9y2K5ROB4ONcyPG7jsY28CrO9taCkRB
	yMaKoEr+lzxMXGahPe4kUuC9s/5vvtpmOnuw4fTv7AQOioXYsrpKwBSk5eDu2FBC
	ScSRXlnbX/PHJrBohQp7daNGbzwOoxCCNp4shRWBJMf/k1qJUQYNrNPF2jOtB8l/
	3YfGsUlBRw08zYmoCkzGFQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1758734511; x=1758820911; bh=O
	cmFh+A9qbHUhQZ1theZRGaKFeq8gRp0eNr/Hqrvz1U=; b=j7kEMbWgfG7p81fvJ
	68zqSxrXUoxOTjQ9A4xZ/rAHGtx+wWAAbYXxm/XyWJK5TeTcKhH4QZK3w0iWr0qz
	15D4yHN1u+hLbcw8hGEefmz4V0ub+ZNtoQlacRLTzy0iXXxvMcHXaNYEMcilElvX
	10OzXKrm++dEDqTqQO2ud8PbRcAs5dY7aFHypQeR1jpChWHfeY9IFWYCH1Wl4KbB
	xEXJv/zKn8okvWUWbFSKmz3/wh9b3VKMSwEPmF9t7kbQw36Bwt/Mg6HTlMib6+5r
	dZ5A86SxAXlRP4FKRPfP7KP2efuW+D4SylqAZODPtNuyThi1HrOHbyD3jBfP3Xpr
	cUYfA==
X-ME-Sender: <xms:rijUaBTV8j8W8WB7JXtKk3P7h1rxzoAlwFNuvMhne74yqMi5wxdFJg>
    <xme:rijUaFmF0we98UPaSHQQydef0Y1Qh9RryVAMAHxVvmpaWNqXxZElryS0ZYDsKdrmC
    UHYJ7xOh_ndePOQhCDpefRnuhdzmoeEpm5IB43_49-Lg0gkW4snuqc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeigedvtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhepofggfffhvffkjghfufgtgfesthejredtre
    dttdenucfhrhhomhepfdfluhhlihgrucfgvhgrnhhsfdcuoehjuhhlihgrsehjvhhnshdr
    tggrqeenucggtffrrghtthgvrhhnpeehhedtleegfedvtedtfefgffevfeeuvdelieetje
    dufefhueeivdeukeeuleeitdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhep
    mhgrihhlfhhrohhmpehjuhhlihgrsehjvhhnshdrtggrpdhnsggprhgtphhtthhopedvpd
    hmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhm
    rghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:rijUaD-prCqpQzi68_JMa758twhna_-5q9tYys9QQc4f2TU05gURqg>
    <xmx:rijUaNrygBug9k1qRC4c54N6QSx2nVc7C_WmK8StU4eRNpsGMs9XnA>
    <xmx:rijUaInA1WY1rWOzVkJNGySwNGsL1GOH_NMV3Yiys4uN3T6ar5v6Qw>
    <xmx:rijUaML74b0Wie12FWdieI9UR7_aMJENdTlImsEDtvUMnRcfjTuDGg>
    <xmx:ryjUaOUOS-Hez-__pmnNw3LklSto4mMHXVmqiiM-6jXrNW849x6TA1oR>
Feedback-ID: i2aa947c3:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id DB9E178026F; Wed, 24 Sep 2025 13:21:50 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Arp_fDZwitDF
Date: Wed, 24 Sep 2025 13:21:30 -0400
From: "Julia Evans" <julia@jvns.ca>
To: "Julia Evans" <gitgitgadget@gmail.com>, git@vger.kernel.org
Message-Id: <1928a79e-c0e1-4510-8717-89053b54ff48@app.fastmail.com>
In-Reply-To: 
 <c7f09c2bd32baf9e1dda355656bba811484e90a0.1758656702.git.gitgitgadget@gmail.com>
References: <pull.1976.git.1758656702.gitgitgadget@gmail.com>
 <c7f09c2bd32baf9e1dda355656bba811484e90a0.1758656702.git.gitgitgadget@gmail.com>
Subject: Re: [PATCH 4/4] doc: git-pull: clarify how to exit a conflicted merge
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, Sep 23, 2025, at 3:45 PM, Julia Evans via GitGitGadget wrote:
> From: Julia Evans <julia@jvns.ca>
>
> From user feedback:
>
> - One user is confused about why `git reset --merge`
>   (why not just `git reset`?). Handle this by mentioning
>   `git merge --abort` and `git reset --abort` instead, which have a
>   more obvious meaning.
> - 2 users want to know what "In older versions of Git" means exactly
>   (in versions older than 1.7.0). Handle this by removing the warning
>   since it was added 15 years ago (in 3f8fc184c0e2c)
>
> Signed-off-by: Julia Evans <julia@jvns.ca>
> ---
>  Documentation/git-pull.adoc | 12 +++---------
>  1 file changed, 3 insertions(+), 9 deletions(-)
>
> diff --git a/Documentation/git-pull.adoc b/Documentation/git-pull.adoc
> index 91903b0a94..eec05ab6c7 100644
> --- a/Documentation/git-pull.adoc
> +++ b/Documentation/git-pull.adoc
> @@ -30,15 +30,9 @@ branch. There are 4 main options for integrating the 
> remote branch:
>  You can also set the configuration options `pull.rebase`, 
> `pull.squash`,
>  or `pull.ff` with your preferred behaviour.
> 
> -In Git 1.7.0 or later, to cancel a conflicting merge, use
> -`git reset --merge`.  *Warning*: In older versions of Git, running 'git pull'
> -with uncommitted changes is discouraged: while possible, it leaves you
> -in a state that may be hard to back out of in the case of a conflict.
> -
> -If any of the remote changes overlap with local uncommitted changes,
> -the merge will be automatically canceled and the work tree untouched.
> -It is generally best to get any local changes in working order before
> -pulling or stash them away with linkgit:git-stash[1].

After sending this I thought to read the `git merge` man page, which has
this warning:

> WARNING: Running `git merge` with non-trivial uncommitted changes is
discouraged: while possible, it may leave you in a state that is hard to
back out of in the case of a conflict.

I think I was probably too hasty in removing the warning entirely, since I
mainly use `git pull --rebase` and I hadn't fully thought through how
`git merge` has a different approach to uncommitted changes than 
`git rebase`.

I think a warning similar to that one would make sense, since any warning
that applies to `git merge` should also apply to `git pull`.

> +If there's a merge conflict during the merge or rebase that you don't
> +want to handle, you can safely abort it with `git merge --abort` or `git
> +--rebase abort`.

Also I noticed a typo in `git --rebase abort` :)
