Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 609ED3B634A
	for <git@vger.kernel.org>; Thu, 12 Mar 2026 14:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773326434; cv=none; b=ivdb2RqzkDD9M89J7u1mRGwt/NMdInvue9vT2mhRHvbEWlKJBpm6HkxfH26lUSi454PbDXd3VXe+IzQajmuFO+UIzuF42m11TesTI7lmIUqQRNIiVGjpehL0piNc2teMRuOijvoTBcIwOkFegKOHP17QyOAId/2e+c9cMyoy2Go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773326434; c=relaxed/simple;
	bh=X+LqG+41qlK2w4sx7aNJEddbf3OEomIqUWZoBy7UYdA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BjiAavX7uimv1mvnKKuNG98DeYAaaoRJ6g8UM9W1/qq3DG92MH93Kl5kZyssOxR7Q8o8k6WwTUjuM9BiuxuUbcx6bwvBE7mHEo5EXuivGENIHrQvqSvRUJyIJhOV8aqLvO1eALf0T38vB/Y2UCPfYKvAzI0iDIbSF1ryUbpLafY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=LaqZF2Yc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gQgpA5xf; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="LaqZF2Yc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gQgpA5xf"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 837D57A0147;
	Thu, 12 Mar 2026 10:40:31 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Thu, 12 Mar 2026 10:40:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1773326431; x=1773412831; bh=SFk4d9r0JG
	PF+KP49W2N2h/NvGqgJx4GZLQb3CjKg44=; b=LaqZF2Yc8bVURjODpEuXCA4WTn
	+jf/hjCSaG0dZK1HAd4wDMrlGAFKbsMaa/ksNReQXpEc9BOUdFDht6Llojhm6rso
	IftOKR7oShL961etLqJfD5Z0a1U+HYFvKSG0UtMfruP0S5UqTg7qMIljSGhGDiT5
	w+DbHuNYTG9x9FACT34xez1zpOUt2HTF+tftiw6JaK2l70MYLttKgsjv6A5Jt/4s
	HaQJb5aYf7HGWBiTBupE0lHWjq1GxnoPi4bLgbqp8GP4gpKuGuLk5lThzzHRORao
	5fs2Al5AujAi/KSdBs2imydvXfPKKo3VVBIzZ/rS0cJra508Z61Os52ZseCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773326431; x=1773412831; bh=SFk4d9r0JGPF+KP49W2N2h/NvGqgJx4GZLQ
	b3CjKg44=; b=gQgpA5xfd2XiDxnbJKDJRHa8XLtP1zvSZ/HFp1KADZ6xuEjmh1j
	k2YB9G55QCs5fcKNJ5lsa9p64/KZ5hGSxmNsgiHcgblm7JqKitjvxbzFKKy/dGID
	8a1jLrf9A2DMgAlF0sc80MitD9sz1TXgoVrcrhg07aZmbLe1VQwalaQ+EbfPKB+n
	KsHDC2mkwieR5E9xtCoYuykiYWKf5eW7B0O48pvwtny6Sp/N84AGy+lPFm4B04vP
	uf1b3DOWza7cD6U1NLsVy3SzhkjZag4sB9cxeVTP5vtX6wnzk/kronRB5MiYdnqM
	fnKTj+p80QdFFekMd/TrzbeoDVRx0NpCySw==
X-ME-Sender: <xms:X9CyaZfXsiF4tBFIzPTNCvQOksWh-72_L-DLT20hB4wV60CM5yplnQ>
    <xme:X9CyaeM1OhuQGIvOz1JZVcP5j0O84RRyp0RPLNvv8NekJFwiMhq0aAcSiY1b3y62_
    PriBhHagpwECKlNs_wt2PHcJCr9J5gkQCiAc02O_W_1W5nE4I_ZCg>
X-ME-Received: <xmr:X9CyaXjxYNlGr4wC4_2mvnLYYCL6HmXH9DgYyfj1AZH_70aTH4HXv5AyUkar8kwOCSpLAk52GOrNdesKXzb2NmuYinKz-HozXA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkeejtdegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehhrghrrghlughnohhrughgrhgvnhesghhmrghilhdrtghomhdprhgtphhtthhopehgih
    htshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:X9CyaR2u-CpJoeQhUeY74qTstJNov5exR6YNjIX3D0PUFQUrVB9ncQ>
    <xmx:X9CyaRhmTQ5n45xHEjPNkGikVz1e5E2ZZdMgyY65zkEG7kP-MEprMQ>
    <xmx:X9CyaRdWZN2QCx4pu9RP_DYasMHZsStP02eFnhkmWeqC41JcsA4pyg>
    <xmx:X9CyaUllMECRVPp1c5JP7oh-xzv3vh0uYFdn3QtMe9MPRhYshXNRMA>
    <xmx:X9CyabCdm4-L4tPYvyak-qT7anB1PaMBmLtlGuogTjAxlB_NPGvDw2tH>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Mar 2026 10:40:30 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Harald Nordgren <haraldnordgren@gmail.com>
Subject: Re: [PATCH] checkout: add --autostash option for branch switching
In-Reply-To: <pull.2234.git.git.1773321998854.gitgitgadget@gmail.com> (Harald
	Nordgren via GitGitGadget's message of "Thu, 12 Mar 2026 13:26:38
	+0000")
References: <pull.2234.git.git.1773321998854.gitgitgadget@gmail.com>
Date: Thu, 12 Mar 2026 07:40:29 -0700
Message-ID: <xmqqeclpi00y.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Harald Nordgren <haraldnordgren@gmail.com>
>
> When switching branches, local modifications in the working tree can
> prevent the checkout from succeeding.  While "git rebase" and "git
> merge" already support --autostash to handle this case automatically,
> "git checkout" and "git switch" require users to manually stash and
> unstash their changes.
>
> Teach "git checkout" and "git switch" to accept --autostash and
> --no-autostash options that automatically create a temporary stash
> entry before the branch switch begins and apply it after the switch
> completes.  If the stash application results in conflicts, the stash
> entry is saved to the stash list so the user can resolve them later.
>
> Also add a checkout.autoStash configuration option that enables this
> behavior by default, which can be overridden with --no-autostash on
> the command line.

Unconditionally always stash when checkout happens?  This feature as
implemented does not have to be a separate feature.  It can be done
by end-users as a short-cut for "stash" followed by "checkout" via
alias or custom command.

Perhaps doing it this way would make it more worth doing?

 - At the beginning of branch switching, ask a new helper function
   that takes the branch we are switching to as an argument this
   question:

   Do any paths that are different between the current branch and
   the branch we are switching to have local (i.e., either in the
   index or in the working tree) change [Yes/No]?

 - When the answer is "yes", save the local changes to a new stash
   entry, and clear the local changes from the index and from the
   working tree.  If not, do not bother with stash at all.

 - Switch to other branch the usual way.  This will never conflict.

 - If we created a stash entry earlier, try to unstash it.  It may
   conflict or it may not.  

   - If it does not conflict, then we are done.  We drop that stash
     entry, and tell nothing about the stash to the user, as there
     is nothing they can do to the now-consumed stash.

   - If it does conflict, tell the user that the original change is
     in the stash, and can be used to recover if you botch the
     conflict resolution, and also tell the user that they need to
     drop the stash entry once they are done with the change that
     caused this current conflict.

Essentially, the new "autostaash only when needed" would become a
much better reimplementation of the "-m" option.  From the point of
view of a user who is used to "checkout -m", the basic workflow
would be the same, only with vast improvement.

 - It may not conflict and merge cleanly, in which case they do not
   have to do anything.  This is the same as status quo.

 - It may conflict and they find it too involved to resolve right at
   the moment, in which case they now have a choiceto say "git reset
   --hard", essentially declaring "I prioritize working on this new
   branch; I'll deal with the work in progress I started on the
   previous branch later", and then later they can "git stash pop"
   to deal with it.

   Which is a vast improvement over the current "-m" that gives you
   only one chance to resolve it right.

 - It may conflict and they may be able to resolve cleanly, in which
   case they have to remember that they need to do an extra thing
   (i.e., drop the stash we created just in case) but that may not
   be too bad a tradeoff.

If we can sell it as an improved implementation of "-m", we probably
can lose some code that the current "-m" implementation uses to do
its merge; we'd be instead using the "unstash" code paths.

And the new helper function to detect if switching from one commit
to another commit would never conflict can later be used to enhance
"git rebase" as well---we could call it N times to rebase a branch
with N commits and if all steps are clear, we do not have to insist
that there is no local changes like we do currently.

Hmm?
