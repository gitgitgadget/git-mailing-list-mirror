Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBA542153F0
	for <git@vger.kernel.org>; Wed, 26 Feb 2025 11:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740569987; cv=none; b=lMWJWERRse74oO9Dy38QdhyypcU7ArFzbbNNkel9QkgkQ6YxyWxB7EQ7if0jskE+LO8JDeW8olwit6Ywbik0O3Ep8QTKl36Bz7gRfeTaeF3McPppBDz17XNI3LNl7s5/XNidTP7xTSXhvmSqoNBFRuZlaPHlK8ri3o8dw9swiko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740569987; c=relaxed/simple;
	bh=k0aKgx5+KPeeAPqSMKdbuSoi934R7IVZsjdSKfP4zqk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LEacGXriwI+5JN44x95VHuUaiI8sUQXYoRJheFvS4zXAPJsEH4jKzCncheLd26rXYrIC4vO/1eSKIVrbR1Id7c3/aeswTfMAnh1TPY6V6lxbVbD6sk9d47dnHB8mnz3LKn8eKngH/CXdQdhWHPHfe2eFuN1eBzvQHQph7K21IHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=DfIbI8oY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=tUkqaqBp; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="DfIbI8oY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="tUkqaqBp"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 9B78A1140190;
	Wed, 26 Feb 2025 06:39:43 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Wed, 26 Feb 2025 06:39:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1740569983; x=1740656383; bh=/GBOLMC8xi
	zigznxs34CgyciF33w7qflOY0b8IK6kGs=; b=DfIbI8oYvHrzOXI1axhsB9k22B
	5N2LCgQB27VqG+YspWbMeWxibhen00YufOnLLz6/S9QEPcfYPf3lzLwY7G+pZ12n
	9wGtuHoiIHxGzuB/8vNL8yplUkTeu1II84EP8+j5zk5dtO63RK8wR0CgQh/faF9B
	EFDr0Qe49C/gnYUlaNmu2pFPM/x6NnMuXuqhOvpgHfl3MPKnuk3hUxeX+JcbbOGp
	IxkWCUBwQF+vVvetOxY3P2LZGOvU15Xs4PvNPOs9TmCKTwlrdPt8w4eRWRMwHnWp
	tJ+RPuLRNBYlsxaRSBsiWEkoTQikKCKhJCYJz58YrydAfu3zeDbvMoz/ZAFw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1740569983; x=1740656383; bh=/GBOLMC8xizigznxs34CgyciF33w7qflOY0
	b8IK6kGs=; b=tUkqaqBpJyA3KWISwxho5ETga0ZYjQnWGugPjhEhgNGU6L7kKAd
	v73c/ZFXZceFg9dy8Cbrn3e9juE9MvwkCnThK4k6QLv+zZ7Muv0sn1p8YrGMTQ+P
	N/9t7s6YxNvSLYKygJJK2yROQzWZWN3WhLGOP/skqnqIsProgI6Vz+s0JZ6QfkKE
	vdU9nQttDBnuAkA8IRaoWbqqnhdnx2UwQ2bnDhZNctt1SY4iGSw7tsYz14dmS6wV
	eRO+yj1Oqn+8JBpSpSmNfhRNVr0PQapmhfmsQ88IvZsMHebjAtFcLKmTSaHns1pd
	lYvp+IXeJQFflJM9u+qAPGJa65gdYnz0+8w==
X-ME-Sender: <xms:f_2-Z6U_fqe6A5Xu6CDxvuemoiACpPFVlStW_AurGSeFoIBObzepag>
    <xme:f_2-Z2lzAch1hGJ2MtQLpbJ__hYaQjpY5dqXGqHYfCEHcg6re596kmJFZl6PTvzIp
    O42spWr13wJjfZmnA>
X-ME-Received: <xmr:f_2-Z-bReuBNvDlNX2ws2CffOMHHPTs3MsL92S9wQFu23uIEcpua-NG3zBOsU25N95Dubxz3j-YfFYfrhgHGKVptuCTQ5okPagSzf6Y8p36zVhqW>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekgeegkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvf
    evuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghi
    nhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepveekkeffhf
    eitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnh
    gspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithes
    vhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsoh
    igrdgtohhmpdhrtghpthhtohepvddtvdehsehugihprdguvg
X-ME-Proxy: <xmx:f_2-ZxVvyyUQ_1NlQeMITYRA8uiFTYv8AwH-nQgZ7tswbzDXl9alLg>
    <xmx:f_2-Z0nuCreh1vBCPOJNErdHDv3Csc25vZ4m93821nESm1I6-xG6Jg>
    <xmx:f_2-Z2en7zuvlaR3cgEE4MMQqLmNbf5Dp-Js3mJ3pa9QPegk3fOFkg>
    <xmx:f_2-Z2FiAu26IcCtYDegNVslzF2-kdbHtq74WcSAkX7lKajOtuerHQ>
    <xmx:f_2-Z-jyaKNCtoQaWYI0pjGZ-qnpftKrXpGPECkpLet946zigvcIwQsH>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 26 Feb 2025 06:39:42 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id c316e359 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 26 Feb 2025 11:39:39 +0000 (UTC)
Date: Wed, 26 Feb 2025 12:39:35 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Markus Gerstel <2025@uxp.de>, git@vger.kernel.org
Subject: Re: 'git gc auto' didn't trigger on large reflog
Message-ID: <Z779d7SnW5j8XcOb@pks.im>
References: <e650f4e4-e267-4f1f-bb3a-c71b1fe0b276@uxp.de>
 <Z7xQey4S0ewT5rs7@pks.im>
 <xmqqeczn70pg.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqeczn70pg.fsf@gitster.g>

On Mon, Feb 24, 2025 at 08:43:23AM -0800, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > It's a bit funny, but whether or not `git gc --auto` does anything
> > solely depends on the state of the object database.
> 
> I guess after adding "auto", we haven't been careful enough to
> update the triggering condition as we added new kinds of "garbage"
> to collect?  Should we make an exhausitive and authoritative list of
> gc tasks, document them, and make sure "--auto" pays attention?

Maybe. But maybe a better solution would be to build this into
git-maintenance(1) instead, which is a lot more fine-grained. It already
has properly defined subtasks, and each of these subtasks has an
optional callback function that makes it only run as-needed.

So from my perspective we should:

  - Expand git-maintenance(1) to gain a new task for expiring reflogs.

  - Adapt it to not use git-gc(1) anymore, but instead use the specific
    subtasks.

It also allows us to iterate a lot more on the actual tasks run by the
command and make them configurable. It would for example allow us to
eventually enable incremental repacking via multi-pack indices or
geometric repacking.

> Other than objects (packing loose ones, pruning unreferenced loose
> ones or packing them into cruft packs), we seem to check reflog,
> worktree, and rerere database.
> 
> I do not think there is a readily usable API to query how much stale
> data is in reflogs that are more than N seconds old, without which
> "gc --auto" cannot make decisions.  I am reasonably sure rerere API
> does not give you such data, either.  I have no idea about the
> triggering condition of "worktree prune".

No, there isn't, and computing it is also potentially expensive. You
basically have to iterate through each reflog and then also iterate
through all of its reflog entries to figure out whether anything needs
cleaning or not.

But probably we can come up with clever heuristics instead that don't
require us to be this thorough. We could for example just read the
"HEAD" reflog and figure out whether it contains reflog entries that
would be pruned.

Patrick
